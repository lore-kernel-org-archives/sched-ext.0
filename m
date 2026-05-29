Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC753E0C4C
	for <sched-ext@lists.linux.dev>; Fri, 29 May 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069926; cv=none; b=cvIPk0Tauq9891pmtNWEmTBqJA3/3QZgSIYOeOcdbPDfIawR6CEdjToQqa3I7VDCSlEeJ1buEX3tlHcVvJMd1W1fnXKD+nKYvCTAcpUIhGCj73vyDMZcnXW9sG4wF78Bf2L9fg4tXd+9yjDVlnr5eG2jcjCTaO3/HfE3jq6+WPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069926; c=relaxed/simple;
	bh=DOt/FscedNBalKmbrCX7DNYaR2v+1Xccunjq7K5Dra8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvmIwebBL0UyWfMz1i1ciyfZVe07sHwGM3FdLkiX5WWRLVL+J6KqSMS7JYtU58Qge0Oy5b7NCEOBkcFztHwnxd7i9SbfjQ/UJQgfnWq4K6INwWiv0N/pcA1ExSIZw5+Ey9zovAhHxR/flkiKozMU+jtr3Nm1HTJynpE+T/Xs+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToxhbnHQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToxhbnHQ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80170db7d6so5583875a12.0
        for <sched-ext@lists.linux.dev>; Fri, 29 May 2026 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780069919; x=1780674719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyvZfJ64Ok9rkT1fbSw+QwvuGZzuFxNCaqmrG+8+EWg=;
        b=ToxhbnHQCibpBuhRsz5qYHKI841MqgGp9VYXyzugUZpmxE6kecwNPRt5LLIT5ecvh3
         /zZhM3jrK9AUxKQzw7Uck3GlI8TI+89Vqp4FCv5nT+4TVTGp81t+ymTvLeIrgUkDlIVQ
         gC6XefvAXRhFuhtIzi/CStHCGn0Oyz/7GwJBnZq9tfy2roukXfq6pvflpTBl2Sl25ueB
         yNLdR3rVA7SgHfzspCnMHuXNceiB00NRWde8PvAoZARAapmpWgeKDXyg92IOI8q5mtK/
         qld5N0HsTmiVhMzZthAGVtFliCqONHl9ndxQOBoQmcK4ki/jbHFdJce/WcLma+du4FbF
         nq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069919; x=1780674719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyvZfJ64Ok9rkT1fbSw+QwvuGZzuFxNCaqmrG+8+EWg=;
        b=kt6WPQPOgQN4CAF/dq1IbrkUKA57MXI1973jGrILk0YDlmOi/YrfeOpI326SZxyyd5
         ZwadCy5BZt/vpktqfDD03uk+fhNRmDTY8ORACAgtJUEt2CEpUKF7fOIx4UQyiuoc/CQZ
         NEgyzmvO+Rer5jQoH9xnEaepGTYNjyvVFD874PMjgIIKEa9DPPZTDJu4JGAeSYNb+fkt
         304s1+VJ00W5fwSkG1PVXi5ZwCH1nnKSQ65RzklVw7qirwrHYz5C3FUqV3mOFd3L+RAF
         hA/9Gu31tFxzLOMXqpwrBraSunA0W0XjALZ9dzlcu1vPx/0Fc2vPf6P1ltWjEMI7MYgY
         B1dQ==
X-Gm-Message-State: AOJu0YwWMd6I47dr+beJjRk0D7k/1zj73nnVNbAO2sMKaJmC9frAZK6x
	tT4dUD8K7jJZfhRgvn97meTCj68QtOY+e7Jywza75wRVg8sk2l4CCrRl
X-Gm-Gg: Acq92OFXbo73sX0eJNC4XMuxJkL2w+Z4xhUvS4C+IatjeXd2+F6SGxpau/vBgEoy7K3
	b6fMRqup0I6BfL56CpKkA57rvJ89Ci23in+o96C4hUdwkNQ2gVE7IcTXvSTNa3lVg6dlHoKKb9d
	EG8OHQQXLrLxq/JUww5Azf0qvER3aI8H9csIMYJN8ErRyAmnuX4FFrfcBW81Tk5r5pqBmdW0h9F
	4liVP2rq540ss8q5jpBBJx1anw4ShHJwkpxuaTDAQpEq5HgC4SdDwRbwL/5UZO8cGs7q4xKQful
	mVAfo59tKhewSPALkuJc0cMgxjsz0q2dOoF5fZsRoxnMqdShfNrjPDNYeAAab9Kpl1vErkYOQgZ
	SESSgit31fA9CYwqyFaIXXtvqlHHsTspiHWSwm9TbJPqwHHcHzInvSIQQWxQRFE+cHpupUryuI0
	rXby46HszBdsPuko8IbUxHp3uy8doY8dElX8bBhm8wIPnDDbrqxdl9jedAWq7pcAXTbjf4mnrLL
	rtRdRqrY+jI632Y
X-Received: by 2002:a05:6a20:cf8d:b0:3b3:26aa:5453 with SMTP id adf61e73a8af0-3b4122c8ec2mr3974845637.29.1780069918806;
        Fri, 29 May 2026 08:51:58 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-227-39.dynamic-ip.hinet.net. [36.226.227.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8580efbad6sm579028a12.13.2026.05.29.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:51:58 -0700 (PDT)
Date: Fri, 29 May 2026 23:51:54 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260529234948.G96b5@cchengyang.duckdns.org>
References: <20260521161636.1893894-1-yphbchou0911@gmail.com>
 <20260521161636.1893894-3-yphbchou0911@gmail.com>
 <6e26e461-6953-4161-835d-5e4412f8ba33@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e26e461-6953-4161-835d-5e4412f8ba33@paulmck-laptop>

Hi Paul,

On Wed, May 27, 2026 at 04:19:08PM -0700, Paul E. McKenney wrote:
[...]
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 82cada459e5d..0a9a509c8c91 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -555,7 +555,8 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
> >  /*
> >   * Print out an expedited RCU CPU stall warning message.
> >   */
> > -static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
> > +static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j,
> > +					    struct cpumask *stalled_mask)
> >  {
> >  	int cpu;
> >  	unsigned long mask;
> > @@ -578,6 +579,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
> >  			if (!(READ_ONCE(rnp->expmask) & mask))
> >  				continue;
> >  			ndetected++;
> > +			cpumask_set_cpu(cpu, stalled_mask);
> >  			rdp = per_cpu_ptr(&rcu_data, cpu);
> >  			pr_cont(" %d-%c%c%c%c", cpu,
> >  				"O."[!!cpu_online(cpu)],
> > @@ -665,17 +667,19 @@ static void synchronize_rcu_expedited_wait(void)
> >  		if (rcu_stall_is_suppressed())
> >  			continue;
> >  
> > +		cpumask_clear(&rcu_exp_stall_cpumask);
> > +
> >  		nbcon_cpu_emergency_enter();
> >  
> >  		j = jiffies;
> >  		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
> >  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> > -		synchronize_rcu_expedited_stall(jiffies_start, j);
> > +		synchronize_rcu_expedited_stall(jiffies_start, j, &rcu_exp_stall_cpumask);
> 
> Are we ever going to pass some other cpumask to this function?
> 
> I would not expect that the rcu_stall_cpumask would ever be passed in
> here, for example.  And the two definitions in tree.c are visible to
> the synchronize_rcu_expedited_stall() function.

Agree, drop in v6, thanks!

> 
> Or am I missing something here?
> 
> >  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
> >  
> >  		nbcon_cpu_emergency_exit();
> >  
> > -		panic_on_rcu_stall();
> > +		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
> 
> Now this one I get: This function is called from both normal and expedited
> RCU CPU stall code.
> 
> >  	}
> >  }
> >  
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb8770..d0c4f193f17e 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
> >  early_initcall(check_cpu_stall_init);
> >  
> >  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> > -static void panic_on_rcu_stall(void)
> > +static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> >  {
> >  	static int cpu_stall;
> >  
> > @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
> >  	 * Attempt to kick out the BPF scheduler if it's installed and defer
> >  	 * the panic to give the system a chance to recover.
> >  	 */
> > -	if (scx_rcu_cpu_stall())
> > +	if (scx_rcu_cpu_stall(stalled_mask))
> >  		return;
> >  
> >  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > @@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  	if (rcu_stall_is_suppressed())
> >  		return;
> >  
> > +	cpumask_clear(&rcu_stall_cpumask);
> > +
> >  	nbcon_cpu_emergency_enter();
> >  
> >  	/*
> > @@ -660,6 +662,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  			for_each_leaf_node_possible_cpu(rnp, cpu)
> >  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> >  					print_cpu_stall_info(cpu);
> > +					cpumask_set_cpu(cpu, &rcu_stall_cpumask);
> >  					ndetected++;
> >  				}
> >  		}
> > @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	panic_on_rcu_stall(&rcu_stall_cpumask);
> >  
> >  	rcu_force_quiescent_state();  /* Kick them all. */
> >  }
> > @@ -754,7 +757,9 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	cpumask_clear(&rcu_stall_cpumask);
> > +	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
> > +	panic_on_rcu_stall(&rcu_stall_cpumask);
> >  
> >  	/*
> >  	 * Attempt to revive the RCU machinery by forcing a context switch.
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 22b1356aa4eb..7bf3c22d573e 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -4948,6 +4948,8 @@ static const struct attribute_group scx_global_attr_group = {
> >  
> >  static void free_pnode(struct scx_sched_pnode *pnode);
> >  static void free_exit_info(struct scx_exit_info *ei);
> > +static const char *scx_exit_reason(enum scx_exit_kind kind);
> > +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
> >  
> >  static void scx_sched_free_rcu_work(struct work_struct *work)
> >  {
> > @@ -4962,6 +4964,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
> >  	timer_shutdown_sync(&sch->bypass_lb_timer);
> >  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
> >  	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> > +	free_cpumask_var(sch->stall_cpus);
> >  
> >  #ifdef CONFIG_EXT_SUB_SCHED
> >  	kfree(sch->cgrp_path);
> > @@ -5187,9 +5190,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
> >   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
> >   * else already initiated abort.
> >   */
> > -bool scx_rcu_cpu_stall(void)
> > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> >  {
> > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > +	struct scx_sched *sch;
> > +	struct scx_exit_info *ei;
> > +	int exit_cpu;
> > +
> > +	guard(rcu)();
> > +
> > +	sch = rcu_dereference(scx_root);
> > +	if (unlikely(!sch))
> > +		return false;
> > +
> > +	switch (scx_enable_state()) {
> > +	case SCX_ENABLING:
> > +	case SCX_ENABLED:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > +	ei = sch->exit_info;
> > +
> > +	guard(preempt)();
> > +
> > +	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
> > +		return false;
> > +
> > +#ifdef CONFIG_STACKTRACE
> > +	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
> > +#endif
> > +	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
> > +		  cpumask_pr_args(stalled_mask));
> > +	ei->kind = SCX_EXIT_ERROR;
> > +	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
> > +	ei->exit_cpu = exit_cpu;
> > +	cpumask_copy(sch->stall_cpus, stalled_mask);
> > +
> > +	irq_work_queue(&sch->disable_irq_work);
> > +	return true;
> >  }
> >  
> >  /**
> > @@ -6608,14 +6648,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
> >  	dump_line(&s, "----------");
> >  
> >  	/*
> > -	 * Dump the exit CPU first so it isn't lost to dump truncation, then
> > -	 * walk the rest in order, skipping the one already dumped.
> > +	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
> > +	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
> >  	 */
> > -	if (ei->exit_cpu >= 0)
> > -		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> > -	for_each_possible_cpu(cpu) {
> > -		if (cpu != ei->exit_cpu)
> > +	if (!cpumask_empty(sch->stall_cpus)) {
> > +		for_each_cpu(cpu, sch->stall_cpus)
> >  			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		for_each_possible_cpu(cpu) {
> > +			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
> > +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		}
> > +	} else {
> > +		if (ei->exit_cpu >= 0)
> > +			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> > +		for_each_possible_cpu(cpu) {
> > +			if (cpu != ei->exit_cpu)
> > +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		}
> >  	}
> >  
> >  	dump_newline(&s);
> > @@ -6851,6 +6900,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
> >  		ret = -ENOMEM;
> >  		goto err_free_lb_cpumask;
> >  	}
> > +	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
> > +		ret = -ENOMEM;
> > +		goto err_free_lb_resched_cpumask;
> > +	}
> >  	/*
> >  	 * Copy ops through the right union view. For cid-form the source is
> >  	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
> > @@ -6920,8 +6973,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
> >  #ifdef CONFIG_EXT_SUB_SCHED
> >  err_free_lb_resched:
> >  	RCU_INIT_POINTER(ops->priv, NULL);
> > -	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> > +	free_cpumask_var(sch->stall_cpus);
> >  #endif
> > +err_free_lb_resched_cpumask:
> > +	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> >  err_free_lb_cpumask:
> >  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
> >  err_stop_helper:
> > diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> > index 3ccfea06cba0..f51f03868ff7 100644
> > --- a/kernel/sched/ext_internal.h
> > +++ b/kernel/sched/ext_internal.h
> > @@ -1178,6 +1178,7 @@ struct scx_sched {
> >  	struct timer_list	bypass_lb_timer;
> >  	cpumask_var_t		bypass_lb_donee_cpumask;
> >  	cpumask_var_t		bypass_lb_resched_cpumask;
> > +	cpumask_var_t		stall_cpus;
> >  	struct rcu_work		rcu_work;
> >  
> >  	/* all ancestors including self */
> > -- 
> > 2.48.1
> > 

-- 
Cheers,
Cheng-Yang
