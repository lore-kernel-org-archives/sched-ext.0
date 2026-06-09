Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2A3FB075;
	Tue,  9 Jun 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004205; cv=none; b=j60ARFlUAXAXA+UxhU0e/db3LG92yPiYjcEvKNlj6JrBBijzT1i6fWgR/MA81pShoKjykwKhGqNtJzS4z+p+5NdJcQ7e/xIOFU6JXJFN2AooFhxcS/Re2p85//sxOjw6+XW5iZkoOMn3nBxSVTgJPrPrF3mrJmPCquRKMckEbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004205; c=relaxed/simple;
	bh=L27Sak4wu42mnkfh4iKkjYEhWRC/zo0wlLqMdtyhjO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1PNSz2WES/BML5pC4iNFACljlt31A0CBMmj0tzThmzO9rT+2ZdtqgwmDp9thVhNHiH9ypptOEpau4MVHxTzDh/9u7t8vnEHd4p2QY3Az/eS87ms3gDOEZrvf/eNumpQEeJIDQHMSdUwd1ZtKrTIgIv7sLMmicSr5XV8YyuLMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/StMYaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/StMYaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8821F00893;
	Tue,  9 Jun 2026 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781004204;
	bh=maOEgfptFr4B0bn3vZnzWiF1krzs9XFqC32SOBdL3VM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=k/StMYaDFd83FyKK9uShyqW+aV2PZxaZFFeV1/R2Lh9Lk9TrkLD9OvpDKw/VI+fXE
	 IjRgLh5DkN4PNORnMt3TuTAAM0B9red3uonPB/nQbGvOwQ8Gugx2kvHQSc28wxZZQ9
	 QVH9CxNB+Y5+plwf2H/tmn+OxN/4fAHOannmjCldrk+9Lgx7XBDlQTrV34JJwEVZRb
	 J+sWwSso2H61qK9X+L89M2Xqj/1PFDZNU1z0DFpad+9KHIxreQe89+1rCjAWtji1jx
	 wW1FXC3+cZsRoFBuR8b+w6VdtfbC3oBMxxVpf+zTStcXr5O6QM1kETJ/4/V7z/9QYU
	 9fflXQmRwoypg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8FC5CE1ADC; Tue,  9 Jun 2026 04:23:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 04:23:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609104733.1184001-1-mfleming@cloudflare.com>

On Tue, Jun 09, 2026 at 11:47:33AM +0100, Matt Fleming wrote:
> Hi there,
> 
> We're investigating a hard lockup on a 6.18.33-based kernel with scx_lavd
> running.
> 
> The vmcore shows CPU#67 stuck in:
> 
>   native_queued_spin_lock_slowpath
>   _raw_spin_lock
>   task_rq_lock
>   sched_ext_free
>   __put_task_struct
>   rcu_core
>   handle_softirqs
>   irq_exit_rcu
>   sysvec_apic_timer_interrupt
> 
> The rq lock being waited on is for CPU#66.
> 
> Another CPU in the same dump is in:
> 
>   sched_ext_free
>   scx_exit_task
>   bpf_task_storage_delete
>   call_rcu_tasks_generic+547
>   _printk
>   console_unlock
>   wake_up_q
>   try_to_wake_up
>   __task_rq_lock
> 
> The `call_rcu_tasks_generic+547` site is the old needadjust path that
> prints:
> 
>   Switching RCU Tasks Trace to per-CPU callback queuing.
> 
> So the current theory is that a task teardown under rq lock enters
> bpf_task_storage_delete(), hits the callback-queue adjustment printk,
> then console wakeup tries to acquire the same rq lock again.
> 
> We found related upstream changes:
> 
>   3063b33a347c ("rcu-tasks: Avoid raw-spinlocked wakeups from call_rcu_tasks_generic()")
>   d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
>   7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
>   7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> 
> But none appears to directly fix the old 6.18 needadjust printk path.
> 
> Would backporting d245698d727a and 7900aa699c34 be useful, or should
> the needadjust printk path itself be deferred away from rq-locked
> callers?

Does commenting out the 'call_rcu_tasks_generic+547' printk() avoid the
issue?  If so, that printk() might be deferred or some such.

"But if you cannot trust printk(), what *can* you trust?"  ;-)

							Thanx, Paul
