Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7530E821
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383135; cv=none; b=qiHYmE0Bs2XQJJR0tKkNL4CzqR7CoUJHvCK3X0pRRtqaGIyYkxjdCilJo4E50yoHi0gNBjW7QB/Jklt0/wBHw1l4jvMrOePmiInoqk0ipTHObPrIplxxTGrMddoAQFn3HzBFB3kUwtHlATVPhc0l7oINcMOD0+a3C/TTszHuQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383135; c=relaxed/simple;
	bh=n4vX10ifIzQv6GVZTUuOMyntV9Gq2eosqV7JVsEmMiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IiByrITvw8ASnqYAlgd/roESJbVEN0Hb1k2Cwma7DuAS3nMt33sQNtS5BTksX2bFnaENkL4TVAow0C/NVZF6oIH13iYViWvgn5t4ZU1+Bkm6CCrMQ1MdabHYNz4Wu7VWOZlnn4ZKKm2XKCjqbAzPcguQfSLeFEsu8bGQPXwpfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acNtftNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acNtftNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B529B1F000E9;
	Thu, 21 May 2026 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383134;
	bh=w+iYWBuQiV0Woz2VWmMOPkcloptThmZwoXVJ8WHstVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=acNtftNvlwuKDcSnT8zQHIkfUiDBy4uX7a68YUbjvWY7PKcydcfwQ39M7MOPDANng
	 /QfFWopRfofCsas8b8f+gLX+w2XkK60M2PEzGPC/kVphrjSanIpnriWNkzSpKYelOF
	 NV9PQyYIdVRx17bdJV99z9B1buZsV63cpFMu4f60aM1lK1R1K3Dh+MKNS1nzYkUnXW
	 7EB+DxPHGSo90sDkwSzrSGiuvM6j4/hQCoTdMTdymFNm2nULeku8uls9jnNbKoy1wj
	 vgZiAOkvvCdca69pSRvmHQG1qEkuQkJedV/DsdercmemDniBzWWtAPldf+5oaAIz2G
	 NLCE5LFEtgadQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260521161636.1893894-3-yphbchou0911@gmail.com>
References: <20260521161636.1893894-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 17:05:33 +0000
Message-Id: <20260521170533.B529B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent execution of RCU stall detection introduces a data race=
 on the global `rcu_stall_cpumask`, leading to a Time-Of-Check to Time-Of-U=
se (TOCTOU) bug that causes an out-of-bounds array access in `scx_dump_stat=
e()`.
--

commit f19732cfebfb0ed5b2408491122054e9d0b8b9ff
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs

This commit threads a cpumask through the RCU stall warning paths to
capture all stalled CPUs. It stores this mask in the sched_ext dump
structures so that all stalled CPUs can be dumped first, avoiding
truncation.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4871,6 +4871,9 @@ static void __init rcu_dump_rcu_node_tree(void)
> =20
>  struct workqueue_struct *rcu_gp_wq;
> =20
> +static struct cpumask rcu_stall_cpumask;
> +static struct cpumask rcu_exp_stall_cpumask;
> +
>  void __init rcu_init(void)

[ ... ]

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
[ ... ]
> @@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_se=
q, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
> =20
> +	cpumask_clear(&rcu_stall_cpumask);
> +
>  	nbcon_cpu_emergency_enter();
> =20
>  	/*

[ ... ]

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -5187,9 +5190,46 @@ static __printf(2, 3) bool handle_lockup(int exit_=
cpu, const char *fmt, ...)
>   * resolve the reported RCU stall. %false if sched_ext is not enabled or=
 someone
>   * else already initiated abort.
>   */
> -bool scx_rcu_cpu_stall(void)
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
>  {
> -	return handle_lockup(-1, "RCU CPU stall detected!");
> +	struct scx_sched *sch;
> +	struct scx_exit_info *ei;
> +	int exit_cpu;
> +
> +	guard(rcu)();
> +
> +	sch =3D rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	switch (scx_enable_state()) {
> +	case SCX_ENABLING:
> +	case SCX_ENABLED:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	exit_cpu =3D cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stal=
led_mask);

[Severity: High]
If multiple CPUs concurrently execute the RCU stall detection, can they race
on the global rcu_stall_cpumask variable?

If the mask is concurrently cleared between cpumask_empty() and
cpumask_first(), couldn't cpumask_first() return nr_cpumask_bits?

This would result in exit_cpu being set to nr_cpumask_bits (which is greater
than or equal to nr_cpu_ids).

> +	ei =3D sch->exit_info;

[ ... ]

> @@ -6608,14 +6648,23 @@ static void scx_dump_state(struct scx_sched *sch,=
 struct scx_exit_info *ei,
>  	dump_line(&s, "----------");
> =20
>  	/*
> -	 * Dump the exit CPU first so it isn't lost to dump truncation, then
> -	 * walk the rest in order, skipping the one already dumped.
> +	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
> +	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
>  	 */
> -	if (ei->exit_cpu >=3D 0)
> -		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> -	for_each_possible_cpu(cpu) {
> -		if (cpu !=3D ei->exit_cpu)
> +	if (!cpumask_empty(sch->stall_cpus)) {
> +		for_each_cpu(cpu, sch->stall_cpus)
>  			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		for_each_possible_cpu(cpu) {
> +			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
> +	} else {
> +		if (ei->exit_cpu >=3D 0)
> +			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);

[Severity: High]
If ei->exit_cpu was set to nr_cpumask_bits from the race described above, w=
ill
this cause an out-of-bounds array access?

Since scx_dump_cpu() uses the cpu_rq(cpu) macro without bounds checking, do=
es
this risk an out-of-bounds read in the per-cpu runqueues array that could
disrupt the system's crash dump process?

> +		for_each_possible_cpu(cpu) {
> +			if (cpu !=3D ei->exit_cpu)
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
>  	}
> =20
>  	dump_newline(&s);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161636.1893=
894-1-yphbchou0911@gmail.com?part=3D2
