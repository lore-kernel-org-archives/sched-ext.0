Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EF36403A;
	Sat, 26 Sep 2026 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450597; cv=none; b=QQrD6Fx5zoehk7Vr86GZD0Q6p5O/0R/edKsVT+ncvuVXkZXPhgyo6GYJzgujSpYPqSzNTfo2XZRiSUbtnEdWYZd9dLcZeLAdU25EuJySTLxfODHrCLJWGsEyp4IIk8NTAA4QQCcTXwu5+hTyjzzxvxRvkHSpj24aP8E7/gURcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450597; c=relaxed/simple;
	bh=N9b5W4k3H7lpzU8+3GrIZ8YZvpGsZQcYIRnr2pymXpU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tGe5cf/p/cSgq6A8Iy3Sd4bWi78to4UuBAngDVmkmuTiv1B/Vx1tSwRRn/TapqOeOKKWLh7KwdMikhLI9vOShbyLHC3eHehC9yCGmNEMNmQRscjcdbtqk+hH77QwJHDOI/7EgeInRNyKo7jhXKxpj4LaJdY+HD6Q/JUh++670xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPGEIIeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPGEIIeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569211F000FF;
	Sat, 26 Sep 2026 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790450596;
	bh=5GmMXH2MSE8fCTwjZyLPwXRVM1ejDzkcG3jX3AUs4L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LPGEIIegBImAqR9c6Q+wVqJDm2RVK0Qurd0nmhQweHnwpwT8nEVl8lR20rLumw7Qj
	 nD0G4nfFiireOPT4F/A3xjLnNLr7pt4wssOtQtDpJOmpmcEd7F6+bh6zTievcRywvS
	 buB6B/3KB+WdlQIWHPV0IHu+YU2OBPxKhq2mbuF/qpNi9D1V/f2GxOTswN+jFFQlsF
	 A4D9lC3rXIiU0d+Ztj5sdcRKBony07UXWjCSh5nTMbzgOjrq03GDwFGqTzwgEU1aie
	 Vm8nrFZyPPTG7WDAx1UdLUjwT4D9ryVO30Fvbq7vf6fnFfXrNr6qIQMuJ2qSctIJnT
	 9D6iuGx7eYOZQ==
Date: Sat, 26 Sep 2026 09:23:15 -1000
Message-ID: <23db458c1526966f521d41322ab47056@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
In-Reply-To: <20260926152306.3190774-1-arighi@nvidia.com>
References: <20260926152306.3190774-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Sep 26, 2026 at 05:23:06PM +0200, Andrea Righi wrote:
>  - set @cluster_cid to the LLC's own CID when no cluster level exists,
>  - set @cluster_idx to -1 when no cluster level exists,

The other levels are inclusive: a level that doesn't exist for a cpu is
represented by the level below it, the way a core on a non-SMT machine is
just the cpu. Can we do the same here? A core without a cluster level is
its own cluster, cluster_cid = core_cid with a dense cluster_idx. Then
every cluster is a contiguous cid range, cluster_idx indexes per-cluster
arrays without a -1 special case, and cluster_cid can't alias between a
real cluster and the fallback cpus in the same LLC.

> +	s32 cluster_cid;
> +	s32 cluster_idx;

Growing struct scx_cid_topo breaks existing binaries: scx_bpf_cid_topo()
copies out the kernel's sizeof into a buffer the program sized from its
own vmlinux.h. I'm changing the kfunc to take the buffer size and copy the
smaller of the two, filling the rest with -1, and routing that through
for-7.3-fixes so that it lands before any growth. Can you base the next
version on top of it and append the new fields at the end of the struct?

Thanks.

-- 
tejun
