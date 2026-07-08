Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CA31282F;
	Wed,  8 Jul 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537772; cv=none; b=qBaSs+c8CTQ5c3UMG1jLi6ZyWapbsxSbR25nrkJm5oDc3OFhV1n/4CV7QYY7xm5TngDmHs5mavQzSj8BDfrT0yxiHdBS05OCW7LGiOfRrA1uPIeAFe5bkhPZ/20MqMB7tVPfbZmMkEBJuVMOUg0VsLGQf3NnlAsSZq02FCH5wDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537772; c=relaxed/simple;
	bh=j+hlszvG5Qs1YHJXjjYSDW2DhU/etlTBYOWhMcJ17N0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ry46p2iHFIn2eZLNbgVyftihFOXpagZrFNqji/ebomrT56wkLvmBxOHpQC5ETDynYm9jWsmbW51Yxb2uP5RKKiI3DYuaW+kDHXKe5DM+rucpw15IWQLDuUUSXa9Y5bDi6XCgWyBNAPDjD8HCHlpKoXwXD+ExzWqxD7lytvxSkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clSiCVHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clSiCVHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D532B1F00A3D;
	Wed,  8 Jul 2026 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537771;
	bh=xx4AcPhq+wNA9dSgmjFEvyrY8Wu6+TTj794arojpoLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=clSiCVHRMP0BiBtLNghm+fASdMzRvKUWSW0BgmcRD/EJ73wHDHsfpZUNm1oLPLzeR
	 J7ghmhWTDQT62BL5Sz6ksJL2WIuKDD7hFZH1J1Sjc7/pOqFcGmOUt5oNrfxU4oMEMh
	 u7xPHPDquuaQPgrd7vnJolkMLDzQpiVHDK5rm7shnHaJK4JkGfZN23qXys+emuEwOD
	 TOZ3PVrto4XrNT+Ek2Wx9tSMHBbSnmdTBDeJh+4aAyQOpa069qds1sevQ+gduoP+l0
	 /vyyo2+UI01qDHTqfmcf64liVlZYXJnXGBFbqvj8VOXmCzj3lps1hWR7wAZz//Qohg
	 Qy7mDiKKx6fEA==
Date: Wed, 08 Jul 2026 09:09:29 -1000
Message-ID: <4601226c108db23d4bf1c2890c2ae14f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 09/36] sched_ext: Make the kick machinery per-sched
In-Reply-To: <20260707003334.59ACF1F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-10-tj@kernel.org> <20260707003334.59ACF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:33:33 +0000, sashiko-bot@kernel.org wrote:
> - [High] Early return in `kick_cpus_irq_workfn()` skips removing `pcpu->to_kick_node` from `sched_pcpus_to_kick` if `ksyncs_pcpu` is NULL, leading to a Use-After-Free when the `pcpu` structure is later freed.

The UAF isn't reachable: disable turns on bypass and does a
synchronize_rcu() before free_kick_syncs(), which fires any pending kick
irq_work first, so the workfn unlinks its to_kick_node while ksyncs is
still published. I've added an explicit irq_work_sync() in the free path
anyway so the invariant is local rather than resting on the disable-path
ordering.

Thanks.

-- 
tejun
