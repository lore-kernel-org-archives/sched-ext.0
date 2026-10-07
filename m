Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B13C1D49
	for <sched-ext@lists.linux.dev>; Wed,  7 Oct 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395734; cv=none; b=RoiHoZxqAK6TLy33gJ8pMDomC3v2uxeA9RUey5W8FF4B7mfIkCtegDso9fzn0+cSRurRYFLFb2JrLE0Wqp8yJza+M0fAZkUBdY/kqdC+5UGXLHMpjauF/7DshOfrjXOb3dZHxI4BUerk5JdbSBio5uObA/zPNNxRU4m7EkCp2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395734; c=relaxed/simple;
	bh=C9yfwdCFUFaflhWGnqJx++BjuGQaVBswaweZexH+PSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEj/TFLvzowu161/thlGVc3gWRbBdfEgz0bmU+1yjU2rcGvTPP/8NicQ2il/GZhNKlyHvlw8DjbjKvUBjPVRsrOM7yXw3WUxO6w7dNGkf4/HyFYDqKE1++nA0ilVz+6NBIODEcbqfEXf4CQXiiRE5ttHIOp7QRdy1Fi5hDUBJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpTG+ySa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpTG+ySa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791395733; x=1822931733;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=C9yfwdCFUFaflhWGnqJx++BjuGQaVBswaweZexH+PSs=;
  b=IpTG+ySaaWmwtVl2aFxfS6NMWW2c2mhzzKbGs4e5cgdL/A5Kfdz3+XLl
   LgKwwwQdgZQysk2z1FmLWP5EV3qaE4k1J43scBrlviV/peYEoH7ZMbhuC
   I4aiRlb4+TskQMwBZ1qSxpbqrXoSWKldvHUclP0GUAa8SegvXltATkiMl
   y6tNSvmMckbZEX9T76qETM/4MnIaHeFxdPhUoG43c1SSzYoF6yH4gvkqQ
   LtPSdlCCC9zB77NDdBZ4JlODIkltQuz/HtyQRL34N+bUHLpb13RBOKhy0
   1fVxwxu2+sXw2WnZUMPsfvKQ6bfxKquz9O04s6JUdBYk4+fQjlHNqutAy
   Q==;
X-CSE-ConnectionGUID: KUy+Ps4rTTWjdF6IRYNGJg==
X-CSE-MsgGUID: W9OnRuXuQGGJdanFBJDaGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="67313"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="67313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:55:16 -0700
X-CSE-ConnectionGUID: fMvzl4HuTBa1zKTdtBZMvQ==
X-CSE-MsgGUID: CA2CNo/vT1u4VDB5k2ZQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285591577"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 10:55:15 -0700
Message-ID: <62547ac28298442a246abe0471647e36518a93cb.camel@linux.intel.com>
Subject: Re: [PATCH 11/18 v2] sched/fair: Support not wakeup case in
 select_idle_sibling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, 	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 lukasz.luba@arm.com, 	rafael@kernel.org, linux-pm@vger.kernel.org,
 tj@kernel.org, void@manifault.com, 	arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com
Date: Wed, 07 Oct 2026 10:55:15 -0700
In-Reply-To: <20261002154415.2270586-12-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
	 <20261002154415.2270586-12-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> With push callback mecanism, select_task_rq_fair can be called for a task
> that is already enqueued. Task into account this case when choosing idle
> CPU.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6ed3e5bb7fd6..38eb80dbd1a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7974,10 +7974,13 @@ static int choose_sched_idle_rq(struct rq *rq, st=
ruct task_struct *p)
>  	return sched_idle_rq(rq) && !task_has_idle_policy(p);
>  }
> =20
> +static int idle_cpu_without(int cpu, struct task_struct *p);
> +
>  static int choose_idle_cpu(int cpu, struct task_struct *p)
>  {
>  	return available_idle_cpu(cpu) ||
> -	       choose_sched_idle_rq(cpu_rq(cpu), p);
> +	       choose_sched_idle_rq(cpu_rq(cpu), p) ||
> +	       idle_cpu_without(cpu, p);
>  }
> =20
>  static void


Hi Vincent,

One concern I have is that many CPUs will try to push
their tasks onto the same idle CPU and causes over stacking.

idle_cpu_without() doesn't check nr_running. Its comment says:

         * rq->nr_running can't be used but an updated version without the
         * impact of p on cpu must be used instead. The updated nr_running
         * be computed and tested before calling idle_cpu_without().

and update_sg_wakeup_stats() does this:

        if (!nr_running && idle_cpu_without(i, p))

choose_idle_cpu() calls it without that test. So a CPU that runs its
idle task but already has a queued task is now idle for every caller:
the target, prev and recent_used_cpu checks, __select_idle_cpu(),
select_idle_smt() and select_idle_capacity(). This affects wakeups
too, not only pushes.

For a wakeup to an idle CPU, the wakelist usually sets ttwu_pending,
which idle_cpu_without() checks. A push enqueues the task directly, so
after a push the destination stays idle for everyone until it
schedules. If it wakes up from a deep idle state, this can take a
while, and other CPUs can push or wake their tasks onto it in the
meantime.

The fixup below removes p from nr_running when p is queued on the CPU,
and calls idle_cpu_without() only when nothing else is queued. The
tick case that this patch is for still works: p is the only task, so
its CPU is still idle without it.

It is build tested only.

Thanks,
Tim

---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3eb8a0170902..cb00f24a58fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7978,9 +7978,16 @@ static int idle_cpu_without(int cpu, struct task_str=
uct *p);

 static int choose_idle_cpu(int cpu, struct task_struct *p)
 {
+       struct rq *rq =3D cpu_rq(cpu);
+       unsigned int nr_running =3D rq->nr_running;
+
+       /* idle_cpu_without() needs nr_running without p */
+       if (task_cpu(p) =3D=3D cpu && task_on_rq_queued(p))
+               nr_running--;
+
        return available_idle_cpu(cpu) ||
-              choose_sched_idle_rq(cpu_rq(cpu), p) ||
-              idle_cpu_without(cpu, p);
+              choose_sched_idle_rq(rq, p) ||
+              (!nr_running && idle_cpu_without(cpu, p));
 }

 static void

