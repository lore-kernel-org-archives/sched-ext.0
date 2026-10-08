Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9327280A
	for <sched-ext@lists.linux.dev>; Thu,  8 Oct 2026 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434365; cv=none; b=W88nq5TgTpMUEs7BC7Md8MHv2J6GvIq+6TuSBGukv0o4gK5JdvZ4hp4zW24IMkY19OmmJEa4VB23KJ8rdFOJvhcY80UFgeA9T4UK9e75eVpWt0ZyCUipVpnItaxObu0yAvPx9Pb0yKRBgQwXhqNfdHmJr/GbvZRaoK1qlNvdg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434365; c=relaxed/simple;
	bh=Rx/tqj4wkyZ6VSBTAWBfFMGKzOaN07eLyd4U5584Wl8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AOr4+HbDhaeZjFmg2Gg7rNRhxX+BGuQE0xnSC67qNT4BKIG9UsaQJ1vQGAa/qO35R0dHi/7rkto/5OSEqMXlEvgY0IFAaosWEjKWnZQNSf/Tom4x1LWk1/w1vhQ70KSb2ZvfigKlVWP63WShX5NErb5xyKOqqH0+uLYLrMb77a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Co8pMymN; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Co8pMymN"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Rx/tqj4wkyZ6VSBTAWBfFMGKzOaN07eLyd4U5584Wl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791434361; v=1; x=1792039161;
 b=Co8pMymNq6jUiNTUkebwzeriYuzG4Ivrcs+qPDWGV8nUoJZ8KyGVcL21+6C2aR8KHyahPgFq
 mcLVKku8yvVx3Vi3zrCSqxeLBk7HmIzkBDDQXENBJBbHaAGixu+AgCRh+NlyoJhhfRx3z2g2Uzr
 6aYxbMITTbku9F3ZNQgLdPq8=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2d52907cc6520490;
	Thu, 08 Oct 2026 04:39:20 +0000
X-Mizu-Trace-ID: 2d52907cc6520490
X-Migadu-Flow: FLOW_OUT
Message-ID: <8fd657b9-4bd4-48a4-a359-62096ba14bec@linux.dev>
Date: Thu, 8 Oct 2026 12:39:12 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Clear a sub-scheduler's caps
 before ops.sub_detach()
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
References: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/10/7 04:31, Tejun Heo 写道:
> A sub-scheduler can leave standing state behind on the cids delegated to it,
> cpuperf targets being the obvious case, and the kernel does not track who
> wrote it. Restoring it is the parent's job and ops.sub_detach() is the place
> for it. Today the parent can't rely on that: the dying sub-scheduler keeps
> every cap until it is marked dead after ops.exit(), so its ops.exit() or a
> late timer can write after the parent has cleaned up.
> 
> Clear every cap of the sub-scheduler before ops.sub_detach(). The pshard
> caps go first as a pending sync recomputes ecaps from them, and ecaps are
> then zeroed directly. A grant racing the clear is refused under the child's
> pshard lock, so nothing hands the caps back.
> 
> Fixes: 86094b95efcf ("sched_ext: Add per-shard cap delegation for sub-schedulers")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Applied to sched_ext/for-7.4.
> 

Tested this patch on a kvm guest running a sched_ext/for-7.4 based
tree with the patch applied, using a pair of cid-form test schedulers:
a parent that grants SCX_CAP_PERF | SCX_CAP_ENQ_IMMED on a cgroup to a
child, and the child writing cpuperf target 1 from ops.tick(). The
parent either restores SCX_CPUPERF_ONE for the delegated cids in
ops.sub_detach() or does nothing, and rq->scx.cpuperf_target is
sampled every second.

With a restoring parent: the child writes target 1 while alive; after
SIGTERM and disable, the parent's ops.sub_detach() write of
SCX_CPUPERF_ONE lands and stays - the child's ops.exit() and timers no
longer overtake the parent's cleanup, which is exactly the gap this
patch closes.

With a parent that does not restore: the child's last written target
persists after the child goes away, as expected from treating the
target as last-writer-wins state.

Both runs are clean with lockdep enabled (no warnings or splats).

Tested-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Thanks.
--
Tao

>  kernel/sched/ext/internal.h |    7 ++++++
>  kernel/sched/ext/sub.c      |   49 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 52 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -828,6 +828,10 @@ struct sched_ext_ops {
>  	/**
>  	 * @sub_detach: Detach a sub-scheduler
>  	 * @args: argument container, see the struct definition
> +	 *
> +	 * The sub-scheduler holds no caps by this point and can no longer
> +	 * affect any cid. Whatever was delegated to it, e.g. cpuperf targets,
> +	 * is the parent's to restore here.
>  	 */
>  	void (*sub_detach)(struct scx_sub_detach_args *args);
>  
> @@ -911,6 +915,9 @@ struct sched_ext_ops {
>  	 * ops.exit() is also called on ops.init() failure, which is a bit
>  	 * unusual. This is to allow rich reporting through @info on how
>  	 * ops.init() failed.
> +	 *
> +	 * A sub-scheduler holds no caps by the time ops.exit() runs. Its
> +	 * cap-gated kfuncs are denied.
>  	 */
>  	void (*exit)(struct scx_exit_info *info);
>  
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1154,6 +1154,34 @@ void scx_offline_ecaps(struct rq *rq)
>  }
>  
>  /*
> + * Clear every cap @sch holds. The pshard caps go first as they are the source a
> + * pending sync recomputes ecaps from. ecaps are then zeroed directly for the
> + * cap checks.
> + */
> +static void clear_all_caps(struct scx_sched *sch)
> +{
> +	s32 si, cpu;
> +	u32 cap_bit;
> +
> +	/* enable may have failed before scx_alloc_pshards() */
> +	if (!sch->pshard)
> +		return;
> +
> +	for (si = 0; si < sch->nr_pshards; si++) {
> +		struct scx_pshard *ps = sch->pshard[si];
> +
> +		guard(raw_spinlock_irqsave)(&ps->lock);
> +		for (cap_bit = 0; cap_bit < __SCX_NR_CAPS; cap_bit++)
> +			scx_cmask_clear(&ps->caps[cap_bit].cmask);
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		guard(rq_lock_irqsave)(cpu_rq(cpu));
> +		WRITE_ONCE(per_cpu_ptr(sch->pcpu, cpu)->ecaps, 0);
> +	}
> +}
> +
> +/*
>   * @pcpu's sched was unhashed before the grace period, so nothing re-queues its
>   * sync node. Remove the node from @rq's pending list so the pcpu can be freed.
>   */
> @@ -1628,6 +1656,12 @@ dump:
>  
>  	scx_unlink_sched(sch);
>  
> +	/*
> +	 * The parent restores what it delegated in ops.sub_detach(). @sch must
> +	 * hold no caps by then.
> +	 */
> +	clear_all_caps(sch);
> +
>  	mutex_unlock(&scx_enable_mutex);
>  
>  	/*
> @@ -2306,8 +2340,8 @@ static s32 sub_cap_preamble(u64 cgroup_i
>   * All-or-nothing keeps the caller-visible result binary per cid, so the denied
>   * mask is one mask to interpret rather than a per-cap matrix.
>   *
> - * Return 0 on full success, -EPERM if any cid was refused, or a negative
> - * errno on other failures.
> + * Return 0 on full success, -EPERM if any cid was refused, -ENODEV if the child
> + * is gone or being disabled, or a negative errno on other failures.
>   */
>  __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
>  				  const struct scx_cmask *cmask__arena,
> @@ -2361,6 +2395,12 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cg
>  		scoped_guard (raw_spinlock, &pps->lock) {
>  			guard(raw_spinlock_nested)(&cps->lock);
>  
> +			/* the child is being disabled, see clear_all_caps() */
> +			if (unlikely(READ_ONCE(child->aborting))) {
> +				ret = -ENODEV;
> +				goto out;
> +			}
> +
>  			/*
>  			 * Narrow granted_cids to cids the parent holds every
>  			 * requested cap on. All-or-nothing per cid.
> @@ -2413,9 +2453,10 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cg
>  		}
>  	}
>  
> +	ret = any_denied ? -EPERM : 0;
> +out:
>  	caps_updated_deliver(&to_deliver);
> -
> -	return any_denied ? -EPERM : 0;
> +	return ret;
>  }
>  
>  /**

