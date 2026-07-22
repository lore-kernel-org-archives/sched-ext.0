Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205C30C174
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728586; cv=none; b=RDUyiS7gL7opTZypxVcV5C6YWF0zP9+a+k9+Pw1w7vgiceG9TaMlXz+j2mViMYM8iNUGi7xsOzTbrQ2Adqpwzfs3831rUNFmycfmAnvmvnsN2HO3ZIE0BwDT8Uj6Y1JYoYTMkOo0Hc/b+bFOfLQEGo8Zn/DnZa+YrvCQ12Ae7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728586; c=relaxed/simple;
	bh=ss8IiYE6TY8EsqmlTZIQHqFlHaYa2tuqnKrLAnY2yw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfEiWonyvHYCp8tpldzV38G0cGsUrvwJP1t6+6nVuzJtTwbq//FIBb+4SNftlnootVDBsnWBVLaLstY7JPXiYXjsvBhLWXDGjSUSbiiPffJOtTAZvWVZgaqo0Cb41iHWvk4DERGCLFeVnK8YGs8Psf/iwgmRWGLojMbMxvYP9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdvfKMxR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdvfKMxR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caed617615so139987885ad.3
        for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728583; x=1785333383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YxzX1H/rYOI/vQmSe8vTVLgX+6bhgy4V5l71XZvk0Zk=;
        b=qdvfKMxRVkOfPrJGmppmS8QtzXMh9ZWOXVAK5IeIFmBIUglDIoyWONlw6oyAAeHBTs
         wMIqUGDmTilVyPwajUny6dnGQ2FVY8hY86vAZBh35//jMIz5ywBpg95AxyTR28Ntschw
         BA8+/NLYU5XYIUGMxwalAzWj8yMTv20travEvHn2p2lpTba1QnfOd5N/lWGLrYaTegyW
         ArJuj/4eQ89SE0AXMXyXN+Kf3Gsjc6V6gVfTx7dVlq14C2/pDsN1a1w+I8SXPQutYb+P
         o8kaTnGsGeI807y8hjO1p9S0RoTzb1T9kWcdrkqWuOYVFld898bcKIqWDK58iMMCnNRZ
         f04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728583; x=1785333383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxzX1H/rYOI/vQmSe8vTVLgX+6bhgy4V5l71XZvk0Zk=;
        b=UrfWfIpgMEX7JbdKbo609DCUzGN1JUWzYq+ugw6aDV4N5CPzbU0sSPoocvUm6E5wlS
         RcYdhS61Q1Te2LC3DlzZ2QW1rQ8AVIvKnB8vXx8FccNl2T7DdIG5y6ZJE8s2+CZ4453O
         /v9DgrH1C/hy7bzDlpO0hkRAgm6rkh8WstxoX1Nac42y1J3qBej6Ap6CcGXIQ5DPdeSv
         8lFqbprziCyQ4FyKxGBuFVpbgxLy2hTj9AWnzz71GFgIC0uPNsuvj3lxp/zOIxt4xWCw
         BQb/S7Je4dTiy64UQUt4ijoWLs4KqB3YGt/2EP08jmguG2FtG1tapBy04w14sMDkrJ8i
         TJjA==
X-Gm-Message-State: AOJu0Yxm/MlEcsyx4wqgLHQGy7GML08Vr9K2vzPYhP4oKp1yr1x0bPhe
	snaij/HlAsGp9/wVXiBfDjWLxwgmB0E2lcpcXfoq8PViZkqpwHeLeuLf
X-Gm-Gg: AR+sD10HK18KcVr6AX2T4jT2EcnLpRUkcrr+E658BgLH0Z5KAEC5QA2pC5mqVx55JAX
	zQDIELnOEVTfb5otctxvSmGh/NTHfQw9ryoTo5fR14mMy96L6eiE9fIhx8pOlIDZYXuKBYB4z6z
	oMvGa/3z377AmH1uU/TNwLK0lpb9uegHwxYIz/kpY2lJRAq4e1k4S+CUtlbPt3uTnRLkzJKP80n
	BBSxIZDxC6sBoENX7lfEkEh5LuDGB2LwlqgOJXyBdSlGbzeqWdnvqWeXLZQPJ/9o0LFo5JY55c4
	BwyCdpRSkdbEiqEc+E9dzVA4JDd69GsGaNZiSotDrMkhO25hpipuIe9eHEubjysagel3nfWP1fU
	/2tE4HGSOHPibI9RrDExSFfMLYCUjP6shtt9xeADzUsz4Ew1VVdEgCti1IH0nq3BO6zAqAp+Zuf
	3RlrIttYu9qjTUHze0m+URacxD/H5e9yks/Qf4YCj2p5uzt3xYx9c=
X-Received: by 2002:a05:6a21:48f:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3c3ad9691cdmr23763324637.46.1784728583112;
        Wed, 22 Jul 2026 06:56:23 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-89-91.dynamic-ip.hinet.net. [1.164.89.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb902acb3fsm1097606a12.2.2026.07.22.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:56:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:56:18 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] tools/sched_ext: scx_pair: Convert to
 sched_switch TP
Message-ID: <20260722215438.G6ef2@cchengyang.duckdns.org>
References: <20260719142917.34238-1-yphbchou0911@gmail.com>
 <al_Kjns3FrkBgR4W@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al_Kjns3FrkBgR4W@gpd4>

Hi Andrea, thanks for the review :)

On Tue, Jul 21, 2026 at 09:37:50PM +0200, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Sun, Jul 19, 2026 at 10:28:45PM +0800, Cheng-Yang Chou wrote:
> > ops.cpu_acquire/release() are deprecated in favor of tracking CPU
> > preemption from a sched_switch tracepoint, see
> > commit a3f5d4822253 ("sched_ext: Allow scx_bpf_reenqueue_local() to
> > be called from anywhere"). Loading scx_pair currently emits a
> > deprecation warning.
> > 
> > Replace the pair_cpu_acquire/release() callbacks with a
> > tp_btf/sched_switch program that edge-detects the same transitions the
> > core used to deliver: a release when a running SCX task loses its CPU
> > to a higher-priority class, and an acquire when the CPU switches back
> > to an SCX task or idle while marked preempted.
> > 
> > Tasks are classified by effective priority (p->prio) rather than by
> > policy: rt_mutex_setprio() boosts a PI beneficiary into the rt/dl
> > classes while leaving its policy untouched, so a policy test would
> > both miss the release when a boosted task takes the CPU and fire a
> > spurious acquire when a boosted task replaces a real rt task.
> > 
> > A switch from idle straight to a higher-priority task is deliberately
> > not treated as a release. The CPU was not running an SCX task, so
> > there is nothing to drain, and kicking SCX_KICK_PREEMPT |
> > SCX_KICK_WAIT on every rt wakeup would make the pair CPU wait out rt
> > bursts it was never coupled to. The old callbacks behaved the same
> > way, firing ops.cpu_release() only from switch_class() when an SCX
> > task was put for a higher class.
> > 
> > The tracepoint runs on every context switch in the system, so the
> > common no-transition case is filtered before taking the pair-shared
> > lock. This is safe because a CPU's own preempted_mask bit is only ever
> > written by this tracepoint running on that CPU.
> > 
> > sched_setscheduler() on a running task changes class in place without
> > a context switch, so such transitions are only observed at the task's
> > next switch. The old callbacks had the same blind spot in
> > switch_class(), and try_dispatch() already bounds the resulting wait.
> > 
> > Verified in virtme-ng with the script below. The scheduler must load
> > without the deprecation warning, stay enabled through the rt churn and
> > the idle soak (the watchdog would otherwise abort it with "runnable
> > task stall"), keep its preemption counter advancing, and unregister
> > cleanly at the end. A PI rt-mutex churn that repeatedly boosts
> > SCX tasks into the rt class was exercised separately:
> > 
> >   #!/bin/bash
> >   # vng --verbose --cpus 8 -m 4G --user root -- ./verify.sh
> >   # FIFO harness: survives even if all SCHED_NORMAL tasks stall
> >   [ "${RT:-0}" = 1 ] || exec chrt -f 5 env RT=1 "$0"
> > 
> >   chrt -o 0 ./tools/sched_ext/build/bin/scx_pair &
> >   PAIR=$!
> >   sleep 3
> >   for round in $(seq 10); do
> >     pids=""
> >     for i in 0 1 2 3; do  # SCHED_FIFO churn
> >       chrt -f 10 bash -c \
> >         'e=$((SECONDS+1)); while [ $SECONDS -lt $e ]; do :; done' &
> >       pids="$pids $!"
> >     done
> >     for i in 0 1; do      # SCHED_NORMAL load under scx
> >       chrt -o 0 bash -c \
> >         'n=0; while [ $n -lt 200000 ]; do n=$((n+1)); done' &
> >       pids="$pids $!"
> >     done
> >     wait $pids            # explicit pids, not the scx_pair job
> >   done
> >   sleep 300               # idle soak
> >   kill -INT $PAIR         # expect clean unregister in dmesg
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> This looks good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> Thanks,
> -Andrea
> 
> > ---
> >  tools/sched_ext/scx_pair.bpf.c | 136 ++++++++++++++++++++++-----------
> >  1 file changed, 90 insertions(+), 46 deletions(-)
> > 
> > diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
> > index 267011b57cba..0d61b7b812db 100644
> > --- a/tools/sched_ext/scx_pair.bpf.c
> > +++ b/tools/sched_ext/scx_pair.bpf.c
> > @@ -93,12 +93,13 @@
> >   * -----------------------
> >   *
> >   * SCX is the lowest priority sched_class, and could be preempted by them at
> > - * any time. To address this, the scheduler implements pair_cpu_release() and
> > - * pair_cpu_acquire() callbacks which are invoked by the core scheduler when
> > - * the scheduler loses and gains control of the CPU respectively.
> > + * any time. To address this, the scheduler watches every sched_switch from
> > + * a tracepoint and edge-detects when a CPU leaves and returns to SCX
> > + * control.
> >   *
> > - * In pair_cpu_release(), we mark the pair_ctx as having been preempted, and
> > - * then invoke:
> > + * When a higher-priority class takes a CPU away from a running SCX task -
> > + * a sched_switch from an SCX task to a higher-priority task - we mark the
> > + * pair_ctx as having been preempted and then invoke:
> >   *
> >   * scx_bpf_kick_cpu(pair_cpu, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
> >   *
> > @@ -107,9 +108,19 @@
> >   * sched_class that preempted our scheduler does not schedule a task
> >   * concurrently with our pair CPU.
> >   *
> > - * When the CPU is re-acquired in pair_cpu_acquire(), we unmark the preemption
> > - * in the pair_ctx, and send another resched IPI to the pair CPU to re-enable
> > - * pair scheduling.
> > + * When the CPU returns to SCX or idle, we unmark the preemption in the
> > + * pair_ctx and send another resched IPI to the pair CPU to re-enable pair
> > + * scheduling.
> > + *
> > + * A switch from idle straight to a higher-priority task is not a release:
> > + * the CPU was not running an SCX task, so there is nothing to drain and no
> > + * reason to make the pair wait. Kicking SCX_KICK_WAIT on every such wakeup
> > + * would stall the pair CPU behind rt bursts it was never coupled to.
> > + *
> > + * Note that sched_setscheduler() on a running task changes its class in
> > + * place without a context switch, so such transitions are only observed at
> > + * the task's next switch. Until then the stale active_mask bit makes the
> > + * pair wait in try_dispatch(), which is bounded by that next switch.
> >   *
> >   * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> >   * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> > @@ -118,6 +129,8 @@
> >  #include <scx/common.bpf.h>
> >  #include "scx_pair.h"
> >  
> > +#define MAX_RT_PRIO	100
> > +
> >  char _license[] SEC("license") = "GPL";
> >  
> >  /* !0 for veristat, set during init */
> > @@ -308,6 +321,40 @@ static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * A task is above SCX whenever its effective priority is in the rt/dl
> > + * range. Test p->prio rather than p->policy: rt_mutex_setprio() boosts
> > + * a PI beneficiary into the rt/dl classes with its policy left
> > + * untouched, so a policy test would misclassify boosted tasks in both
> > + * directions. p->prio follows the boost and the deboost.
> > + *
> > + * This still cannot tell fair and SCX tasks apart. It is complete only
> > + * because scx_pair runs in switch-all mode, where no fair class task
> > + * exists; in partial mode fair is also above SCX and can take the CPU.
> > + */
> > +static bool pair_task_is_highpri(struct task_struct *p)
> > +{
> > +	return p->prio < MAX_RT_PRIO;
> > +}
> > +
> > +static void pair_cpu_acquire_locked(struct pair_ctx *pairc, u32 in_pair_mask,
> > +					u32 *kick_flags)
> > +{
> > +	pairc->preempted_mask &= ~in_pair_mask;
> > +	/* Kick the pair CPU, unless it was also preempted. */
> > +	*kick_flags = !pairc->preempted_mask ? SCX_KICK_PREEMPT : 0;
> > +}
> > +
> > +static void pair_cpu_release_locked(struct pair_ctx *pairc, u32 in_pair_mask,
> > +					u32 *kick_flags)
> > +{
> > +	pairc->preempted_mask |= in_pair_mask;
> > +	pairc->active_mask &= ~in_pair_mask;
> > +	/* Kick the pair CPU if it's still running. */
> > +	*kick_flags = pairc->active_mask ? SCX_KICK_PREEMPT | SCX_KICK_WAIT : 0;
> > +	pairc->draining = true;
> > +}
> > +
> >  __attribute__((noinline))
> >  static int try_dispatch(s32 cpu)
> >  {
> > @@ -500,61 +547,60 @@ void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
> >  	}
> >  }
> >  
> > -void BPF_STRUCT_OPS(pair_cpu_acquire, s32 cpu, struct scx_cpu_acquire_args *args)
> > +SEC("tp_btf/sched_switch")
> > +int BPF_PROG(pair_sched_switch, bool preempt, struct task_struct *prev,
> > +	     struct task_struct *next, unsigned int prev_state)
> >  {
> >  	int ret;
> > +	s32 cpu = bpf_get_smp_processor_id();
> >  	u32 in_pair_mask;
> >  	struct pair_ctx *pairc;
> > -	bool kick_pair;
> > +	u32 kick_flags = 0;
> > +	bool preempted;
> > +	bool release, acquire;
> >  
> >  	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
> >  	if (ret)
> > -		return;
> > -
> > -	bpf_spin_lock(&pairc->lock);
> > -	pairc->preempted_mask &= ~in_pair_mask;
> > -	/* Kick the pair CPU, unless it was also preempted. */
> > -	kick_pair = !pairc->preempted_mask;
> > -	bpf_spin_unlock(&pairc->lock);
> > -
> > -	if (kick_pair) {
> > -		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
> > +		return 0;
> >  
> > -		if (pair) {
> > -			__sync_fetch_and_add(&nr_kicks, 1);
> > -			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
> > -		}
> > +	/*
> > +	 * This runs on every context switch in the system. A CPU's own
> > +	 * preempted_mask bit is only ever written by this tracepoint
> > +	 * running on that CPU, so the unlocked read is exact and the
> > +	 * pair-shared lock is only taken on actual transitions.
> > +	 */
> > +	preempted = pairc->preempted_mask & in_pair_mask;
> > +	if (next->pid && pair_task_is_highpri(next)) {
> > +		/* an SCX task lost the CPU to a higher-priority class */
> > +		release = !preempted && prev->pid && !pair_task_is_highpri(prev);
> > +		acquire = false;
> > +	} else {
> > +		/* the CPU is back under SCX control (or idle) */
> > +		release = false;
> > +		acquire = preempted;
> >  	}
> > -}
> > -
> > -void BPF_STRUCT_OPS(pair_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
> > -{
> > -	int ret;
> > -	u32 in_pair_mask;
> > -	struct pair_ctx *pairc;
> > -	bool kick_pair;
> > -
> > -	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
> > -	if (ret)
> > -		return;
> > +	if (!release && !acquire)
> > +		return 0;
> >  
> >  	bpf_spin_lock(&pairc->lock);
> > -	pairc->preempted_mask |= in_pair_mask;
> > -	pairc->active_mask &= ~in_pair_mask;
> > -	/* Kick the pair CPU if it's still running. */
> > -	kick_pair = pairc->active_mask;
> > -	pairc->draining = true;
> > +	if (release) {
> > +		pair_cpu_release_locked(pairc, in_pair_mask, &kick_flags);
> > +		__sync_fetch_and_add(&nr_preemptions, 1);
> > +	} else {
> > +		pair_cpu_acquire_locked(pairc, in_pair_mask, &kick_flags);
> > +	}
> >  	bpf_spin_unlock(&pairc->lock);
> >  
> > -	if (kick_pair) {
> > +	if (kick_flags) {
> >  		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
> >  
> >  		if (pair) {
> >  			__sync_fetch_and_add(&nr_kicks, 1);
> > -			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
> > +			scx_bpf_kick_cpu(*pair, kick_flags);
> >  		}
> >  	}
> > -	__sync_fetch_and_add(&nr_preemptions, 1);
> > +
> > +	return 0;
> >  }
> >  
> >  s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
> > @@ -602,8 +648,6 @@ void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
> >  SCX_OPS_DEFINE(pair_ops,
> >  	       .enqueue			= (void *)pair_enqueue,
> >  	       .dispatch		= (void *)pair_dispatch,
> > -	       .cpu_acquire		= (void *)pair_cpu_acquire,
> > -	       .cpu_release		= (void *)pair_cpu_release,
> >  	       .cgroup_init		= (void *)pair_cgroup_init,
> >  	       .cgroup_exit		= (void *)pair_cgroup_exit,
> >  	       .exit			= (void *)pair_exit,
> > -- 
> > 2.43.0
> > 

-- 
Cheers,
Cheng-Yang
