Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3422B8D0
	for <sched-ext@lists.linux.dev>; Sat, 29 Nov 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439761; cv=none; b=exj3UYa3NgXxzgKFXBa26VF9xGQ81D8wzP4hkv5mEnrxg5AiqKYcRe6OUw43n40KHBBIQ2lTTuPmGBJ+/bxBrbbPF/GK/E95JxAMGaeRN+voXvaY9neESJBu8Oa64YuPyNB67HMwfgBnk/bUgk7s+J3XnV6XGduv1YSsdI/gmMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439761; c=relaxed/simple;
	bh=BSQpfAXfRv6+V/MAgcbKwlwESaCTSvGT5aUnQukl99U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AabgWrzQxCXj/QP2YxIvGaADKxZr+nhN3c1zndHucTwLOHb7mUXdIW+BoJRjhocWZuHXDEsiu/nh9RXfG23opdqquRFX3cdnmfAs2PoCadCayYyOd4CbpiYTvJ5Nhf+6cxqJTYACbx7j9yGZlS6Yz1mgPoNljtSo6bEzjt2xtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPn+z2J4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPn+z2J4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATGF9wi019350;
	Sat, 29 Nov 2025 18:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ebUpWe
	QgWUMYd6Xyust+C6kNXFO/2b0aGlYKpBFnVFI=; b=rPn+z2J4cC99A4txz1Etcq
	BN13f6XjZ9TwdebaLMddWNMmQUl12lj0s1iumjGMvfaNZllz19Ns3LkMpTtElL5/
	sLKn9KdGBWo8ZeJxRueC8r3tcvSYtjMuE5GQCxwEKo9uGoA0dztrTjeeAHqbHHcA
	uDjAXOVW6N6itAHY1TJrFMCP8NxBvlktsGqIqQkEsCNfk97olVZ5y56fFbcRrRH+
	uHwWVGwlGlo8Z+j/T7gT7KwIx+ZAbOFi1btuwHq/RSCr8GYrPQxbhEppiJF517Nh
	Wt+uzvegN8IrR+gtjx7GVOuwPmrbhPXxTIKCBJPSIKPSV7n1yHcvJsMKmF74ahOg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8u9h7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:08:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ATI8uDr024982;
	Sat, 29 Nov 2025 18:08:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8u9h7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:08:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATGqqbO016418;
	Sat, 29 Nov 2025 18:08:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0ksvqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Nov 2025 18:08:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ATI8ri759638148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 18:08:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F6FF20043;
	Sat, 29 Nov 2025 18:08:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B54720040;
	Sat, 29 Nov 2025 18:08:50 +0000 (GMT)
Received: from [9.124.219.208] (unknown [9.124.219.208])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 29 Nov 2025 18:08:49 +0000 (GMT)
Message-ID: <3d9d0e43-b73c-4bed-b59c-dc1387d183e4@linux.ibm.com>
Date: Sat, 29 Nov 2025 23:38:49 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
        void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
        sched-ext@lists.linux.dev, mingo@kernel.org,
        vincent.guittot@linaro.org
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251127154725.901391274@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Otqt9yXfNoWnVqhfVlNRNMnUgTzJxwbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX7IsDIuvSfFG/
 P4WYqL60LhSsrCSUqUmH1MPc28X3adayBz4CVzuYD+m+JhdNlrlV5PGVgrW74oCp+K2HEGK8X5E
 R7HzaOOBzNr2qcc2YD8vC7J2c72DqQJymYEfxM/b0znHdqPL8RBjoSpFwA+jHwlvflhSVTTbwtz
 NaMT9hEMlpsPbawmpBmlb/kD8JP45SxU2p2YpeenpAeljVG/ur41e0Spc4/r2CIAHjEAUnVSCSD
 i9NLou7LBaRvj/p3WW34Vy8q33mHiKrFZbu3IqA3q7eCAlqeRQgy2eWKXDY/q1p2Vbulwupo+/s
 l5chCkCVbC/Zq8nj/W9N/rNUjhHNwwPAVWhVpyIWjXX12VDBRE1eEf/uWDFzoKUabecELp4mgsf
 rFk7RitzIKuqE/j0E9c3xC6+eAFdjw==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692b36b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=BZLcMPKaMRHIE5nWHRwA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: aPAfNjoPj66wqapIBW3br_g35oxm1fXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008



On 11/27/25 9:09 PM, Peter Zijlstra wrote:
> Change sched_class::wakeup_preempt() to also get called for
> cross-class wakeups, specifically those where the woken task is of a
> higher class than the previous highest class.
> 
> In order to do this, track the current highest class of the runqueue
> in rq::next_class and have wakeup_preempt() track this upwards for
> each new wakeup. Additionally have set_next_task() re-set the value to
> the current class.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/core.c      |   32 +++++++++++++++++++++++---------
>   kernel/sched/deadline.c  |   14 +++++++++-----
>   kernel/sched/ext.c       |    9 ++++-----
>   kernel/sched/fair.c      |   17 ++++++++++-------
>   kernel/sched/idle.c      |    3 ---
>   kernel/sched/rt.c        |    9 ++++++---
>   kernel/sched/sched.h     |   26 ++------------------------
>   kernel/sched/stop_task.c |    3 ---
>   8 files changed, 54 insertions(+), 59 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2090,7 +2090,6 @@ void enqueue_task(struct rq *rq, struct
>   	 */
>   	uclamp_rq_inc(rq, p, flags);
>   
> -	rq->queue_mask |= p->sched_class->queue_mask;
>   	p->sched_class->enqueue_task(rq, p, flags);
>   
>   	psi_enqueue(p, flags);
> @@ -2123,7 +2122,6 @@ inline bool dequeue_task(struct rq *rq,
>   	 * and mark the task ->sched_delayed.
>   	 */
>   	uclamp_rq_dec(rq, p);
> -	rq->queue_mask |= p->sched_class->queue_mask;
>   	return p->sched_class->dequeue_task(rq, p, flags);
>   }
>   
> @@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struc
>   {
>   	struct task_struct *donor = rq->donor;
>   
> -	if (p->sched_class == donor->sched_class)
> -		donor->sched_class->wakeup_preempt(rq, p, flags);
> -	else if (sched_class_above(p->sched_class, donor->sched_class))
> +	if (p->sched_class == rq->next_class) {
> +		rq->next_class->wakeup_preempt(rq, p, flags);
> +
> +	} else if (sched_class_above(p->sched_class, rq->next_class)) {
> +		rq->next_class->wakeup_preempt(rq, p, flags);

Whats the logic of calling wakeup_preempt here?

say rq was running CFS, now RT is waking up. but first thing we do is return if not
fair_sched_class. it is effectively resched_curr right?

>   		resched_curr(rq);
> +		rq->next_class = p->sched_class;

Since resched will happen and __schedule can set the next_class. it is necessary to set it
even earlier?

> +	}
>   
>   	/*
>   	 * A queue event has occurred, and we're going to schedule.  In
> @@ -6797,6 +6799,7 @@ static void __sched notrace __schedule(i
>   pick_again:
>   	next = pick_next_task(rq, rq->donor, &rf);
>   	rq_set_donor(rq, next);
> +	rq->next_class = next->sched_class;
>   	if (unlikely(task_is_blocked(next))) {
>   		next = find_proxy_task(rq, next, &rf);
>   		if (!next)
> @@ -8646,6 +8649,8 @@ void __init sched_init(void)
>   		rq->rt.rt_runtime = global_rt_runtime();
>   		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
>   #endif
> +		rq->next_class = &idle_sched_class;
> +
>   		rq->sd = NULL;
>   		rq->rd = NULL;
>   		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> @@ -10771,10 +10776,8 @@ struct sched_change_ctx *sched_change_be
>   		flags |= DEQUEUE_NOCLOCK;
>   	}
>   
> -	if (flags & DEQUEUE_CLASS) {
> -		if (p->sched_class->switching_from)
> -			p->sched_class->switching_from(rq, p);
> -	}
> +	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
> +		p->sched_class->switching_from(rq, p);
>   
>   	*ctx = (struct sched_change_ctx){
>   		.p = p,
> @@ -10827,6 +10830,17 @@ void sched_change_end(struct sched_chang
>   			p->sched_class->switched_to(rq, p);
>   
>   		/*
> +		 * If this was a class promotion; let the old class know it
> +		 * got preempted. Note that none of the switch*_from() methods
> +		 * know the new class and none of the switch*_to() methods
> +		 * know the old class.
> +		 */
> +		if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
> +			rq->next_class->wakeup_preempt(rq, p, 0);
> +			rq->next_class = p->sched_class;
> +		}
> +
> +		/*
>   		 * If this was a degradation in class someone should have set
>   		 * need_resched by now.
>   		 */
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2499,9 +2499,16 @@ static int balance_dl(struct rq *rq, str
>    * Only called when both the current and waking task are -deadline
>    * tasks.
>    */
> -static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
> -				  int flags)
> +static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flags)
>   {
> +	/*
> +	 * Can only get preempted by stop-class, and those should be
> +	 * few and short lived, doesn't really make sense to push
> +	 * anything away for that.
> +	 */
> +	if (p->sched_class != &dl_sched_class)
> +		return;
> +
>   	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
>   		resched_curr(rq);
>   		return;
> @@ -3304,9 +3311,6 @@ static int task_is_throttled_dl(struct t
>   #endif
>   
>   DEFINE_SCHED_CLASS(dl) = {
> -
> -	.queue_mask		= 8,
> -
>   	.enqueue_task		= enqueue_task_dl,
>   	.dequeue_task		= dequeue_task_dl,
>   	.yield_task		= yield_task_dl,
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2338,12 +2338,12 @@ static struct task_struct *pick_task_scx
>   	bool keep_prev, kick_idle = false;
>   	struct task_struct *p;
>   
> -	rq_modified_clear(rq);
> +	rq->next_class = &ext_sched_class;
>   	rq_unpin_lock(rq, rf);
>   	balance_one(rq, prev);
>   	rq_repin_lock(rq, rf);
>   	maybe_queue_balance_callback(rq);
> -	if (rq_modified_above(rq, &ext_sched_class))
> +	if (sched_class_above(rq->next_class, &ext_sched_class))
>   		return RETRY_TASK;
>   
>   	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
> @@ -2967,7 +2967,8 @@ static void switched_from_scx(struct rq
>   	scx_disable_task(p);
>   }
>   
> -static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
> +static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
> +
>   static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
>   
>   int scx_check_setscheduler(struct task_struct *p, int policy)
> @@ -3216,8 +3217,6 @@ static void scx_cgroup_unlock(void) {}
>    *   their current sched_class. Call them directly from sched core instead.
>    */
>   DEFINE_SCHED_CLASS(ext) = {
> -	.queue_mask		= 1,
> -
>   	.enqueue_task		= enqueue_task_scx,
>   	.dequeue_task		= dequeue_task_scx,
>   	.yield_task		= yield_task_scx,
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8697,7 +8697,7 @@ preempt_sync(struct rq *rq, int wake_fla
>   /*
>    * Preempt the current task with a newly woken task if needed:
>    */
> -static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
> +static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_flags)
>   {
>   	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
>   	struct task_struct *donor = rq->donor;
> @@ -8705,6 +8705,12 @@ static void check_preempt_wakeup_fair(st
>   	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
>   	int cse_is_idle, pse_is_idle;
>   
> +	/*
> +	 * XXX Getting preempted by higher class, try and find idle CPU?
> +	 */
> +	if (p->sched_class != &fair_sched_class)
> +		return;
> +
>   	if (unlikely(se == pse))
>   		return;
>   
> @@ -12872,7 +12878,7 @@ static int sched_balance_newidle(struct
>   	t0 = sched_clock_cpu(this_cpu);
>   	__sched_balance_update_blocked_averages(this_rq);
>   
> -	rq_modified_clear(this_rq);
> +	this_rq->next_class = &fair_sched_class;
>   	raw_spin_rq_unlock(this_rq);
>   
>   	for_each_domain(this_cpu, sd) {
> @@ -12939,7 +12945,7 @@ static int sched_balance_newidle(struct
>   		pulled_task = 1;
>   
>   	/* If a higher prio class was modified, restart the pick */
> -	if (rq_modified_above(this_rq, &fair_sched_class))
> +	if (sched_class_above(this_rq->next_class, &fair_sched_class))
>   		pulled_task = -1;
>   
>   out:
> @@ -13837,15 +13843,12 @@ static unsigned int get_rr_interval_fair
>    * All the scheduling class methods:
>    */
>   DEFINE_SCHED_CLASS(fair) = {
> -
> -	.queue_mask		= 2,
> -
>   	.enqueue_task		= enqueue_task_fair,
>   	.dequeue_task		= dequeue_task_fair,
>   	.yield_task		= yield_task_fair,
>   	.yield_to_task		= yield_to_task_fair,
>   
> -	.wakeup_preempt		= check_preempt_wakeup_fair,
> +	.wakeup_preempt		= wakeup_preempt_fair,
>   
>   	.pick_task		= pick_task_fair,
>   	.pick_next_task		= pick_next_task_fair,
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -534,9 +534,6 @@ static void update_curr_idle(struct rq *
>    * Simple, special scheduling class for the per-CPU idle tasks:
>    */
>   DEFINE_SCHED_CLASS(idle) = {
> -
> -	.queue_mask		= 0,
> -
>   	/* no enqueue/yield_task for idle tasks */
>   
>   	/* dequeue is not valid, we print a debug message there: */
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1615,6 +1615,12 @@ static void wakeup_preempt_rt(struct rq
>   {
>   	struct task_struct *donor = rq->donor;
>   
> +	/*
> +	 * XXX If we're preempted by DL, queue a push?
> +	 */
> +	if (p->sched_class != &rt_sched_class)
> +		return;
> +
>   	if (p->prio < donor->prio) {
>   		resched_curr(rq);
>   		return;
> @@ -2568,9 +2574,6 @@ static int task_is_throttled_rt(struct t
>   #endif /* CONFIG_SCHED_CORE */
>   
>   DEFINE_SCHED_CLASS(rt) = {
> -
> -	.queue_mask		= 4,
> -
>   	.enqueue_task		= enqueue_task_rt,
>   	.dequeue_task		= dequeue_task_rt,
>   	.yield_task		= yield_task_rt,
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1119,7 +1119,6 @@ struct rq {
>   	raw_spinlock_t		__lock;
>   
>   	/* Per class runqueue modification mask; bits in class order. */
> -	unsigned int		queue_mask;
>   	unsigned int		nr_running;
>   #ifdef CONFIG_NUMA_BALANCING
>   	unsigned int		nr_numa_running;
> @@ -1179,6 +1178,7 @@ struct rq {
>   	struct sched_dl_entity	*dl_server;
>   	struct task_struct	*idle;
>   	struct task_struct	*stop;
> +	const struct sched_class *next_class;
>   	unsigned long		next_balance;
>   	struct mm_struct	*prev_mm;
>   
> @@ -2426,15 +2426,6 @@ struct sched_class {
>   #ifdef CONFIG_UCLAMP_TASK
>   	int uclamp_enabled;
>   #endif
> -	/*
> -	 * idle:  0
> -	 * ext:   1
> -	 * fair:  2
> -	 * rt:    4
> -	 * dl:    8
> -	 * stop: 16
> -	 */
> -	unsigned int queue_mask;
>   
>   	/*
>   	 * move_queued_task/activate_task/enqueue_task: rq->lock
> @@ -2593,20 +2584,6 @@ struct sched_class {
>   #endif
>   };
>   
> -/*
> - * Does not nest; only used around sched_class::pick_task() rq-lock-breaks.
> - */
> -static inline void rq_modified_clear(struct rq *rq)
> -{
> -	rq->queue_mask = 0;
> -}
> -
> -static inline bool rq_modified_above(struct rq *rq, const struct sched_class * class)
> -{
> -	unsigned int mask = class->queue_mask;
> -	return rq->queue_mask & ~((mask << 1) - 1);
> -}
> -
>   static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>   {
>   	WARN_ON_ONCE(rq->donor != prev);
> @@ -3899,6 +3876,7 @@ void move_queued_task_locked(struct rq *
>   	deactivate_task(src_rq, task, 0);
>   	set_task_cpu(task, dst_rq->cpu);
>   	activate_task(dst_rq, task, 0);
> +	wakeup_preempt(dst_rq, task, 0);

Whats the need of wakeup_preempt here?

In all places, move_queued_task_locked is followed by resched_curr
except in __migrate_swap_task which does same wakeup_preempt.


>   }
>   
>   static inline
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -97,9 +97,6 @@ static void update_curr_stop(struct rq *
>    * Simple, special scheduling class for the per-CPU stop tasks:
>    */
>   DEFINE_SCHED_CLASS(stop) = {
> -
> -	.queue_mask		= 16,
> -
>   	.enqueue_task		= enqueue_task_stop,
>   	.dequeue_task		= dequeue_task_stop,
>   	.yield_task		= yield_task_stop,
> 
> 

