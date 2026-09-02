Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BE390609
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328977; cv=none; b=I+jCptBmm66/hOeVtnK/f9ZAIBQnD5lo+puhrxr11nW9f5mveSzYYNq7Gu2InJIdLXxDEyJ23iuT0i41VbvZPbhxyZ7OgbJnabDbOLc6hF9Y6Vr/xXZiWSwECCJCz08uGXhoV662NeU+3IN5zxgh/6vBe4hs/d3ykkjiqHFXWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328977; c=relaxed/simple;
	bh=y+XNkQtTq2t/3FqKLQcKIw9MCb8uejqyFRZ98eTmR0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYz3h7VO5CfcBbIhzSnlVWLybslw8qfVxGSx7Fg/FLj1iUEb5HRNVuBvmrLdpkwQvCoiJRfNwtZhY6eFqx2H04O4kDUG/TdfezRsNA4J7LacT8wkv3FVJlH4Tp0FIbPdM2lZLR7l7fYupPsbDbvkfULsk12mIZ4fovevDOxJdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5SeZ4HE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5SeZ4HE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DC41F000E9;
	Wed,  2 Sep 2026 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328975;
	bh=GuPWPFseTCgPQ0rpXcPEShzrxq9MJlHlDxmHF0rJbm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g5SeZ4HE0BZqBtgn2slrwo8DHkcOzIZ72pBo5WmHMibAHKiZU3LKfnTCt2lPgWily
	 uGhIuVkXkldRYJXHXZARym8PBz5eJ2NjmeL6OymCBHc+EnKZQo/M45vFfVms8JS8+g
	 vfwo8zJrWtl4GrwqrO7Ty97rj23zfwhtACZ2CUDB69S61ifdyhsLXeg1rRQC6FqwFg
	 32x/EkAX+yU87ci5V6GrwUFGyFnqJIP3a2Oqi1bCJU4q/xdOgEWnFK89HyjyfVKUyi
	 xE+If2GO2QjxaqfcHKxq/qlvvh29d5iwsRqT8OjCqVsnBCk84WuBiNHVurNESckhuu
	 RYXlkWorN7QcQ==
Date: Tue, 1 Sep 2026 20:02:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: arighi@nvidia.com, sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Delete sub-scheduler kobjects before
 releasing scx_enable_mutex
Message-ID: <ape8DkMkIdWeyAd7@slm.duckdns.org>
References: <apcuA5kzwRCu_P-V@slm.duckdns.org>
 <20260902032233.135959-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902032233.135959-1-fangqiurong@kylinos.cn>

Hello,

On Wed, Sep 02, 2026 at 11:22:33AM +0800, Qiurong Fang wrote:
> Hello Tejun,
> 
> On Tue, Sep 01, 2026 at 09:56:51AM -1000, Tejun Heo wrote:
> > Why is this a problem? The subsched hasn't been fully unloaded yet so if you
> > try to attach a new one, it's going to fail.
> 
> When the mutex is released, the cgroup has already been given back to the
> parent and the exiting scheduler unlinked - its sysfs name is the only
> thing left, and only kobject_add() can see it:
> 
>   exiting sched (disable workfn)        new sched (enable workfn)
>   -----------------------------        ---------------------------
>   mutex_lock(&scx_enable_mutex)
>     set_cgroup_sched(cgrp, parent)
>     scx_unlink_sched(sch)
>   mutex_unlock(&scx_enable_mutex)
>                                        mutex_lock(&scx_enable_mutex)
>                                        find_parent_sched()         ok
>                                        create/validate/link sch    ok
>                                        scx_sched_sysfs_add()
>                                          kobject_add("sub-%llu")  -EEXIST
>                                        err_disable: tear down the
>                                        otherwise healthy sched
>   ops.sub_detach()/exit()      ~100ms
>   synchronize_rcu()
>   kobject_del("sub-%llu")      too late
> 
> The new scheduler passes every check and dies only at sysfs_add(); the
> error surfaces via its own ops.exit() while the attach syscall returns 0,
> and there is nothing userspace could wait on. This is the case the root
> path's comment covers by deleting before unlocking.
> 
> Reproduced with a slow (~100ms) ops.exit() and a second struct_ops
> instance attaching to the same cgroup in a loop: 40/40 iterations hit
> -EEXIST without the patch, 0/40 with it. Happy to turn the reproducer
> into a selftest as a follow-up if wanted.

How is that distinguishible from new sched being loaded while the previous
one is still there? There are two ways to observe whether a scheduler is in
place - bpf link destruction, which cna propagate through the sched process
exit, and sysfs kobject visibility and the associated uevent notifications.
ops.sub_detach/exit() being called doesn't mean that a subsched is gone -
these are internal cleanup routines. You don't generate userspace visible
indications from those.

You're trying to load a new scheduler when nobody told anybody that the
previous one is gone, declaring that not succeeding a bug and then fixing
that by introducing an actual bug - now you're telling userspace that the
scheduler is gone via uevent while the scheduler is *still* there. Please
stop.

Thanks.

-- 
tejun
