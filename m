Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041839;
	b=zRyeIY/eXoFcdg2AOCdMHhQV6DgUlAXuBnJliZZQ5Ep2o71R1alBksB4VnEZ/vGtSHF1
	 Qmp08C+c1B4rHrXqQzrfK2cIg9eyqDCRudHOvbomDSK6BI0QP1Ns543sCq8f0sAgtTO49
	 DBakPznHs0z5rJfXVRc0FaLjR/fJpgfceSOUZc74i+3oETnjST1ui15geiccj6BeZvkUy
	 mAxaIclWyxuBlYyiGJxs+MSvHuT+yJcavrEL1jGIzGCv03cLgVDrV4J1xFAP3nUs1oUp2
	 s7wxIgzq6+D51EmppbGFgvoPz1BV4xFV3sJVP2NnCCrrJWXV5FYOJg+1EfTyvvoLrlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=o/S19kSM9lYLAGwga0DXgPXg/sfdJ1jaylcSZ4R6Qfs=;
	b=fRUTcDsA9v51IYgU3JK3MYL57S4+Cp73JoR33utu200MjZlnnYv3cGjE/E0G4nssH2JX
	 4Km+jrn4zB351CKM+Vhl/GfVpxPBXVd3MBl360wX1/jCaUE23jY277mDksIzZmD8N6Dau
	 Qmqiegf2C2N9SuMHfb9eaNShG98dRg35a7T5yMjiTfNa/mLPcdkZvpEHB07nYLLPCDA1A
	 j6pwZ6qp2wpKztj+Vj33Pa577X4NPiZbIsyj5tz/BGJnwMJ9srn5I3eeox8mNqHcSXAZw
	 igfKdpuWAT4HgkNuh69RvKOZlXDKqbZYzbZrFiqef0/9ciWqAbl2t4JJt5qeF2tel7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ez+qi1mC;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41F606A32C
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 08:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC41F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ez+qi1mC
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so1336155e9.0
        for <sched-ext@lists.linux.dev>; Sat, 07 Nov 2026 00:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041837; x=1794646637; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o/S19kSM9lYLAGwga0DXgPXg/sfdJ1jaylcSZ4R6Qfs=;
        b=ez+qi1mCTD0O9MaXdAjKCWc2vk5GCJv30d/k/gL1hJFUn3/jp++M7mxH+ibZrWv9kM
         AsxFEQ2LxP34YkYsVzn628SSXLvxzIvayi7P0L5MxFamdVl2ReY1bZEt1A1EtiBNjBQ2
         zmr8w+nL7TaFpnaQYHcae19DSOpFnHE+DvN3Po3de3B9lBFOlUcC2Xi78VQpi5tpiV/4
         9Zrr/+S3TAEjNQpemk+j/iFhUfj9tugNj1l+E3z1peS8e/Sau6f7Jqp+RixJB7FkaTHx
         +H0TALk8oGUOEwIAaHV1OXtYolMrMnLK8JyLLPUfhVzJg+Qx/JrFQ7cb/DaRJw7wsC8x
         bTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041837; x=1794646637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/S19kSM9lYLAGwga0DXgPXg/sfdJ1jaylcSZ4R6Qfs=;
        b=qLWHAgfPmsXHkODyZErglJVn+tutxPZCoZ8/f5Pk0kV4kXTGMziMbZSV+e0GX/1nP4
         hP3RU7ZSrPSAoTuQtveG0kYnffiUKh6goN4DrLQ3RtyVjVsod3cz+6t3iNoBNHnPh1Cl
         b5LIuL0RD5QWoosGWacdcajsc7oi1TjC8cZV4wjRQvSSE+hhhsYvQoBUL7mtwyjAYjgg
         0MeqHpN6w4rscV6O3la+G285BKioTIf/jm3+3ig9oP74ppHWfE9SwZlwOYHY6ndXkILQ
         D2EaEZaapEDBIXjfsTfZMwNVLOA0iiAPm3x3fjwSHyD0otgu9OVyKcRdGCk04J6J/UZD
         FP6Q==
X-Forwarded-Encrypted: i=1; AL+hErFwVReJADuHOJBYmRZxfiMcLabq0ETrcb7Qf3ND8ndxlPomOJYwekj0TcIOQouBKOrEyM2hXjhrwNo=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Y2AcEiB/IkIQhu9+s1xyG0V4ud3KQxNuraD7qRsY05T/bFszk
	s3h/vslMIr91dYC4+WEaeleTA3mjB7tFLV9fAst27lazaXmT8fuz/qRp
X-Gm-Gg: AYBFou1XIorsHqvMTOr9Lmoi04ZHX9lwMHlmODP6WiQz7dkkvGG3Owl9Zd7HBwWtE7k
	3D8hfU8vqRrfwe+FMyhHVxOBFW8NrqUElyEWtw7Yj2K/VmtQy2xLrsKKxai3I7pbFZ03MkD1sAH
	aCT0Y03HX+XdNIKe/0c1bYW0G0mnEUjkfx+SK1qeTjZrzdRedi8gna3wUlM7hUquDo+Oou8twvn
	QN3NuK2Z136FOCLdWNS422qXjrI1o8UDwFxBQQ6PXYAGKxlgLogSJuNKe6o6AhnMpy0lW16Igfz
	uvH7LdPHbHN7qd5YcbkkC6U4OgezIXfAtpJs8skMSk8t0IT8o76+mibgEuHCAtJQWM/Z5UlcIM5
	aJHLQqtF+Djcfaa3nT4M5+PFp0hC4KYkNEjyRxeEEid5nCr/ymBE3eh6cm47GoSLJwJr3GX9Ys1
	Zc6/+MOeqr5eixb39k91gQ9sB2aJwygnGRAyYa2i4rHoCzb/oGAyw04mwL/MJT7EP5sZqhAYtnG
	BR6BPVnUzQIA3ouhBK+EdqIWtTRcZDAHJXsQh5OfM7Gik/fGCs6cKc7edkVaJu/a1EfOJiZY/nF
	uUtf0JtYezdcdd/xo3qKITh3zZM9sRdHXyDbCyq1kPZ2NSY1fBJn3uY=
X-Received: by 2002:a5d:5a45:0:b0:493:9233:ce65 with SMTP id ffacd0b85a97d-4939233ce93mr4171013f8f.0.1794041836979;
        Sat, 07 Nov 2026 00:57:16 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d6085asm11840800f8f.3.2026.11.07.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:57:16 -0800 (PST)
Date: Sat, 7 Nov 2026 11:57:12 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <au7SabL5pfbsApyB@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-7-vincent.guittot@linaro.org>


Hi Vincent,


Sashiko reviewed this one so I'll just put here my own concerns instead
of repeating.


On Fri, Nov 06, 2026 at 04:19:33PM +0100, Vincent Guittot wrote:

> Add a new level for selecting CPU when select_task_rq_fair() fails to find
> an idle CPU. This last level compares the min slice to select a CPU where
> the task could run 1st.
> This helps a waking task to select a CPU where a longer slice runs
> instead of one where a task with the same or shorter slice already runs.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c |   2 +-
>  kernel/sched/fair.c | 157 ++++++++++++++++++++++++++++----------------
>  2 files changed, 102 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 031efe7d49fb..d71da9069218 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9012,7 +9012,7 @@ void __init sched_init(void)
>  		rq->sd = NULL;
>  		rq->rd = NULL;
>  		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> -		rq->min_slice = ULONG_MAX;
> +		rq->min_slice = 0;
>  		rq->balance_callback = &balance_push_callback;
>  		rq->active_balance = 0;
>  		rq->next_balance = jiffies;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cfc99b94d9ce..039dce244aaa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8842,11 +8842,25 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>  	return new_cpu;
>  }
>  
> -static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> +static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
>  {
> -	if (choose_idle_cpu(cpu, p) && sched_cpu_cookie_match(cpu_rq(cpu), p))
> +	if (p->se.slice < get_rq_min_slice(rq))
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
> +{
> +	if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
> +		return -1;
> +
> +	if (choose_idle_cpu(cpu, p))
>  		return cpu;
>  
> +	if (*slice_cpu == -1 && choose_sched_slice_rq(cpu_rq(cpu), p))
> +		*slice_cpu = cpu;
> +
>  	return -1;
>  }


Look here:

CPU1: CPU2:
FA    RA
      FC

CPU2 has 1 RT and 1 Fair tasks named RA and FC.
Let's say RA is running on CPU2 and FC's slice is 10 ms.

And let's say FA has 8 ms slice, and a fair task named TC is waking up
with 9 ms slice:

* We look to CPU1, 9 < 8 is false so we return false

* We look to CPU2, 9 < 10 is true so we return it.

But the problem is, CPU2 has a RT task running and we are going to
compete with the RT task. In that case it can be worse than CPU1.

So, I would suggest something like this or so:


(My editor got crazy, so I had to copy this diff :<)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 262626455497..8b0dd858f332 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 
 static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
 {
-	if (p->se.slice < get_rq_min_slice(rq))
-		return true;
-
-	return false;
+	return p->se.slice < get_rq_min_slice(rq) &&
+		READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
 }
 
 static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
@@ -9193,7 +9191,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	bool has_idle_core = sched_smt_active() && test_idle_cores(target);
 	unsigned long task_util, util_min, util_max, best_cap = 0;
 	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
-	unsigned long task_slice;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 	int nr = INT_MAX;
@@ -9204,7 +9201,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	task_util = task_util_est(p);
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
-	task_slice = p->se.slice;
 
 	if (sched_feat(SIS_UTIL) && sd->shared) {
 		/*
@@ -9260,7 +9256,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 			else if (fits > 0)
 				fits = ASYM_IDLE_THREAD_FITS;
 
-		} else if (fits > 0 && task_slice < get_rq_min_slice(cpu_rq(cpu))) {
+		} else if (fits > 0 && choose_sched_slice_rq(cpu_rq(cpu), p)) {
 			fits = ASYM_BUSY_THREAD_FITS;
 			cpu_cap = get_actual_cpu_capacity(cpu);
 		} else {



Cheers,

Kayra :-)
