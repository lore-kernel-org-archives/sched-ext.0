Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E223CF1E7;
	Wed,  8 Jul 2026 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537796; cv=none; b=juUgF+uOmAWVKoOnM3E79l0NdEhIpymu8gGphV8nWNqEBE7m/s4HFqA0wipVKZxb/5ntE7XWuHsCLAF9KBjHY9m/BLtKulTT54L5lGO1LpD2OVAVrgcDQ/U6G6g2yPcEVfPozk4pC6W/ChK45haFYmrDwRA1Q4855ndud6fW3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537796; c=relaxed/simple;
	bh=IHpWtP0FcTkhS/GIjzc91SE+h1lBGL944YPeJ/X+110=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=u569WljabhmA6icPbsQ0u3WrsjWn8yWZ01FbDLNZMY14SaJ+81Qnt1uXGxV85wggHv133FXKpPe/wNEnkaJaBux9W3mGp9wq4lHkRQ+K9mGJJnLF4MwesfqLh/nw0QVuaiwC1BsIZe1jqDBKbNMZ9L1RLm0ogZgxKnBytuWzexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQTeXRxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQTeXRxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDAF1F00A3D;
	Wed,  8 Jul 2026 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537785;
	bh=ginsaI+HyRIcyHqi34yOhEM5q95MZdTRNgahmXbcuLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JQTeXRxSNOYdgUPY0Xx0VQvcU3DDPFRe2ZjU2GO9kMzPhxYA5HJUAtYUMlY14/Nz/
	 ElQ7C6a2AqDk3zkR8ssPomAACBS+23KFcIYkWBEkPITu2SDnEZp18X6PwpeC1U14wl
	 W1cHsD9AxrvJqc6ccKc4Nw0Cwe8F8LiD1FelS++DgmwEJSYnmq/sng17kIuQKP3vSq
	 yDNy6w9qMIU2EnarvvH1EJ4Mqn/45UcUtdJcUW3KEWyv0G9o/Ue2ITkr7JJCSAwvLA
	 Pj1QayglTjDvyHcqEg0Pt40fPnqyUQG1UsW+CaKPqJtDx1wHJAPKUT3RrUlw+dz5CH
	 92vpUZSFedGVg==
Date: Wed, 08 Jul 2026 09:09:44 -1000
Message-ID: <d0ae1c17ef35bc81e5a36e4be4ca2f07@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 35/36] tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
In-Reply-To: <20260707004101.869821F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-36-tj@kernel.org> <20260707004101.869821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:41:01 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Newly acquired exclusive CPUs are not added to `idle_cids.mask` if they were already idle when ownership changed, leading to lost wakeups.
> - [Medium] Tasks pinned exclusively to delegated CPUs will be permanently stranded in `SHARED_DSQ`.
> - [Medium] `qmap_sub_attach` and `qmap_sub_detach` modify the `sub_sched_ctxs` array without synchronization, causing data races with timer-driven partition updates.

1. Real - a cid already idle when it's reclaimed into the owned set was
   missed. Fixed by making idle_cids track physical idleness for every
   cid and masking it against the owned set at dispatch, so no reseed is
   needed.

2. Known limitation - a task affined only to delegated cids strands in
   SHARED_DSQ. This is the missing per-affinity fallback, now noted in
   the cover letter; a later series adds a root-reserved fallback slice.

3. Real but self-healing - the fields are re-derived by the following
   redistribute(). The clean fix (a bpf_spin_lock over the accesses)
   isn't usable because the cmask ops it would guard call kfuncs, which
   the verifier forbids inside a bpf_spin_lock section. Left as-is for
   the demo.

Thanks.

-- 
tejun
