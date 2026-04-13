Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA82EAD1B
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058724; cv=none; b=a+PBLtzmjhEetE5n2GJIsun42z5z3cvxLOD6XJaFmQUhmtXGyjfRvFzkhlZ6I9Y7W+cgbd98XMDJBg2f0xH+SDAuZ26NKEN6XLyhZWgb9K4w/RVeNGvtViBJBs4jGbsQcZyNNSGPbnvpbF6GKDi+a70kPDKfW2mIShyK1uIQ/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058724; c=relaxed/simple;
	bh=jL3lf1klZq550mfZrnzPzNMaTcEpClL7MwCDkwsOB/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXZ+9jCnlaRZQZVPJ13gOIRNT2FSxjtCbSaHOBrVWSjymvqMKongHXmDEIlf5fgq409kNLrQcSrX6J6rW/4qbNSXslAhN5RcLPm4r/bqfDeVEVhkmj3hK9DyblXrorWVsmsAUpVIV/UlfVpP9/6V+B3poTrRbCmcxA2GUQMdv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvDj8KEH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvDj8KEH"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so154306b3a.0
        for <sched-ext@lists.linux.dev>; Sun, 12 Apr 2026 22:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776058723; x=1776663523; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7f9S46JRfJV9VWECJMfQ9/QBBXcSj958M1O9Ik4azY=;
        b=DvDj8KEHdmrSeC8W7dvrJtFKhDIeYMiqjPp7nULBTBYQr1rZJzBZ/AQT2ejE8qwoEo
         FATQePjDdCTugbALT9KCFoY78hAnFzW/SudQhccG5D7iwPBP50+atV/rMmC21LrfpaPP
         ukVi9NOKmIvP3PiUU8f4as/i4RLIAmOS1kkufNEQxAvFMdoKzz74OzvBrmnT03gYntW5
         6E6q0zYCogmX82jLxYWQ1zkv5xOshmT5ai6Eo4xda7ANLgSREtfkeR77Xyie4rnnT1p+
         ssF5Thl/endmuD66ixe7TlpuRH6D2QyJVGD4/XHkgvlAEDO3C1By7KvGXMkjvDc5bvUb
         gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776058723; x=1776663523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7f9S46JRfJV9VWECJMfQ9/QBBXcSj958M1O9Ik4azY=;
        b=oYMnNAyi6HDsz3St5BQGJDbm0aBceB1MbXhfAWjXWNlm76zcXrbX9XuqKES9TioxuP
         TLflmO+K21NMNYPjj242EIHX4ZSEWQrrTQ1IUUMNCb9gBPdcyq+km5suzxdcaYm+ak3a
         clLLZhXighYZdtqIpapXM46Fx1LRgkcXq6as9ZwNf3dvWZWAv9vE1sBDQmfxydH0wMCo
         LaY5z4b2KKfOyZjrEBXARZE547Fq3fp11MwKqUBZphzP2lWjGQN3UtJOHJ3ucq05n8wf
         Q4ag7a3AtkRsBbzU1UIg9eqi6UCnGfjhGZ6boggW8tG40oftFmp6aDNUjuf3WWPGhw5N
         4fdw==
X-Forwarded-Encrypted: i=1; AFNElJ+9noVijGukEFz72edC6zI76N9a6ekSrtuCfJ44JpjtFuaZaisXymfhVPPLPEf4rBT4537ux3rHleA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxPT1C6LTgxpQQJTkdyuhxmnSHsT9dWXxjZ0lr23NkAsenGYijB
	OtAwMP1xd+RYLMJuddRcs1tngVsAvcOZeRvb10a+T4umarEbSfmYBzgGhfHtEJ4w
X-Gm-Gg: AeBDievCuFNBbvcjROz9pkFCNRkQLgl505Nfqdzie60lGRCozRSYQWxOwdNsCv07mfn
	PUYfnpWZolMiMT9LBKS5vhLMkfzPyCemaywsp2y64zuZEf1t4WpJRcHuficPWmcS9jDmcLruH4D
	uclXFv/TbdVjcTFCGnyZIhJDjw/6/wgtHGl13Vb8SKa0oRhsZg5oQ5v0Ktupb2JFQW9p/AIgGzg
	/AitSNqKtzY6zL9rIswCQ3Er0CptlotY069K2hzatrBDxWJ9lYM5CQrxRpfey8jm26vB3wcC1lQ
	nLhBKSyKSNfzeCzxzFI+7fimb2myLLb7rFwU7w+IzClqsgNBp7K1lBgAOukYXuI+9n7pd0zH/nC
	bAXjjE+CiEDV7pGQMQjH1O6vtZMkAcvTgKHfozmzAvbb4dBQ1CQvAGDqlMiqp3JpNn8iOFUcyM+
	t5qabtcMwyRqD7QNNITCwTBvgtIbg=
X-Received: by 2002:a05:6a00:2c95:b0:827:37d5:af4d with SMTP id d2e1a72fcca58-82f0c291cf0mr12023567b3a.24.1776058722633;
        Sun, 12 Apr 2026 22:38:42 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:da32:10f:5734:2b9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm9410214b3a.56.2026.04.12.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:38:42 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:38:38 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick home CPU for
 stranded tasks in scx_qmap
Message-ID: <pbsbopzoeq5v4hsi5snmr74rljpwnuoyg7xyupfdpmrzkzkyim@x7avxt5fztxk>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
 <9e172bda49dade833db7118929332693@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e172bda49dade833db7118929332693@kernel.org>

Hi Tejun,

On Sun, Apr 12, 2026 at 05:30:52PM -1000, Tejun Heo wrote:
> scx_qmap uses global BPF queue maps (BPF_MAP_TYPE_QUEUE) that any CPU's
> ops.dispatch() can pop from. When a CPU pops a task that can't run on it
> (e.g. a pinned per-CPU kthread), it inserts the task into SHARED_DSQ.
> consume_dispatch_q() then skips the task due to affinity mismatch, leaving it
> stranded until some CPU in its allowed mask calls ops.dispatch(). This doesn't
> cause indefinite stalls -- the periodic tick keeps firing (can_stop_idle_tick()
> returns false when softirq is pending) -- but can cause noticeable scheduling
> delays.
> 
> After inserting to SHARED_DSQ, kick the task's home CPU if this CPU can't run
> it. There's a small race window where the home CPU can enter idle before the
> kick lands -- if a per-CPU kthread like ksoftirqd is the stranded task, this
> can trigger a "NOHZ tick-stop error" warning. The kick arrives shortly after
> and the home CPU drains the task.
> 
> Rather than fully eliminating the warning by routing pinned tasks to local or
> global DSQs, the current code keeps them going through the normal BPF queue
> path and documents the race and the resulting warning in detail. scx_qmap is an
> example scheduler and having tasks go through the usual dispatch path is useful
> for testing. The detailed comment also serves as a reference for other
> schedulers that may encounter similar warnings.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> v2: Replaced the previous enqueue-side fix which kicked when a pinned task was
>     enqueued. That was based on the theory that ops.select_cpu() being skipped
>     meant the home CPU wouldn't be woken, which wasn't quite right --
>     wakeup_preempt() kicks the target CPU regardless. Moved the fix to
>     ops.dispatch() where the stranding is actually observable.
> 
>  tools/sched_ext/scx_qmap.bpf.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index f3587fb709c9..a4543c7ab25d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -471,6 +471,46 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
>  			__sync_fetch_and_add(&nr_dispatched, 1);
> 
>  			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
> +
> +			/*
> +			 * scx_qmap uses a global BPF queue that any CPU's
> +			 * dispatch can pop from. If this CPU popped a task that
> +			 * can't run here, it gets stranded on SHARED_DSQ after
> +			 * consume_dispatch_q() skips it. Kick the task's home
> +			 * CPU so it drains SHARED_DSQ.
> +			 *
> +			 * There's a race between the pop and the flush of the
> +			 * buffered dsq_insert:
> +			 *
> +			 *  CPU 0 (dispatching)      CPU 1 (home, idle)
> +			 *  ~~~~~~~~~~~~~~~~~~~      ~~~~~~~~~~~~~~~~~~~
> +			 *  pop from BPF queue
> +			 *  dsq_insert(buffered)
> +			 *                           balance:
> +			 *                             SHARED_DSQ empty
> +			 *                             BPF queue empty
> +			 *                             -> goes idle
> +			 *  flush -> on SHARED
> +			 *  kick CPU 1
> +			 *                           wakes, drains task
> +			 *
> +			 * The kick prevents indefinite stalls but a per-CPU
> +			 * kthread like ksoftirqd can be briefly stranded when
> +			 * its home CPU enters idle with softirq pending,
> +			 * triggering:
> +			 *
> +			 *  "NOHZ tick-stop error: local softirq work is pending, handler #N!!!"
> +			 *
> +			 * from report_idle_softirq(). The kick lands shortly
> +			 * after and the home CPU drains the task. This could be
> +			 * avoided by e.g. dispatching pinned tasks to local or
> +			 * global DSQs, but the current code is left as-is to
> +			 * document this class of issue -- other schedulers
> +			 * seeing similar warnings can use this as a reference.
> +			 */
> +			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
> +				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
> +
>  			bpf_task_release(p);
> 
>  			batch--;
> --
> 2.53.0

This makes sense.

I also realized my previous patch for scx_userland was unnecessary, as
the global DSQ logic handles this automatically. Sorry for the nose on
that one.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
