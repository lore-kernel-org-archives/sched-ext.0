Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359D3CC7D3;
	Wed,  8 Jul 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537782; cv=none; b=kyYDDLEXOB1Lnyix9+4Cu2TPzI4GTIfinXBhpUUdCZ2qfWOJILgBBmVi1YcmQ+d+FJ3DftDFYmJLe+cf+o9WZxx6cBNB6oPS3AzNlUSBaGVeGxUVtZzEsm/Qrm1QnPEp9H3GSAhbklavxt+xD6clacYxL4ALZtsiTwRVTfhlvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537782; c=relaxed/simple;
	bh=PeKYXP8xuzjyzI2lStbZrfylKlFZxrvg1d3NY5rE07s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SNrFCza1PXligmK7GKhYExM4EbI6gZybnLW4S12o5W91DQCW2ZK7oVQjHU1fChPmUblJi+U2RM+cLfGB/xeLLEGpDpvKwiaKM1EdLHkusjk50lEBOATWDJHmM2sTDhU9+MRZkQldZI/sHHWCmVPtlsLAgzvSWPBEOBAOUuIz0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH7+6unO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH7+6unO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852FA1F000E9;
	Wed,  8 Jul 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537777;
	bh=kR3W6SZpZpCJUuaVGBK1eP+MfVqfDTIHB8POV9fTfGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FH7+6unOco6OB8kt4uponBWjcOIXDi+qdrLP5XOOYnnKnXP8Am0eg3e26S+kcAU9n
	 4qCWZCWb2eMs98CU1uSrTqQtTiSk61E/ePqR/KnZ+5G0STgWq8/oA3Coeph6XnKQAY
	 4RMnMxmmBZU0sMFVdRgwgyef5rG2ND5qAtZp70p5o3K1LtUSiWFG8baK1PT//5P+o9
	 axafIGmtrZbBcivHVCi3rHb0ADbp6G0bysNkBSgLIVQvo+twek/YF+akVLz1dfhUsR
	 BgkyDv/pDR267xPaDHq6V4vi7zO7Tfv4dTUH+oVU1sdZBo/f89nx9wMrBIv4FKhfbE
	 NJNiSeZaOQgdw==
Date: Wed, 08 Jul 2026 09:09:36 -1000
Message-ID: <45b2e5b36f300bd2cbe5de16ad472cb4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 19/36] sched_ext: Add per-shard cap delegation for sub-schedulers
In-Reply-To: <20260707003934.3FC381F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-20-tj@kernel.org> <20260707003934.3FC381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:39:33 +0000, sashiko-bot@kernel.org wrote:
> - [High] Missing bounds check on the shard index `si` against `target->nr_pshards` in `scx_bpf_sub_caps()` leads to an out-of-bounds array access on the `pshard` array.

The out-of-bounds access is real, but it's cross-generation rather than
a same-generation missing bounds check. A disabled scheduler still
resolvable through an fd held open by userspace keeps its pshard[] sized
to its older, smaller generation, while the shard index comes from the
current global geometry a newer root has grown - so it overruns (a read
here, a write in grant/revoke). Fixed by gating scx_prog_sched() to
return NULL for a disabled scheduler (a new prep patch), which closes it
for every sub-cap kfunc at one choke point.

Thanks.

-- 
tejun
