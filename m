Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54135677C
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059015; cv=none; b=UcIUPvl/1h6iDZDBQmxmoRBE4yxIsLbeQ3X7XaI205m/E0csiuxt8+xP0M2YiAUNUr1VuZcuu1Kcnddvs+PHOWKz7vh0VaV8jiGyt/CdJRtmiPij21dR0FQpcxDu+5MxIXu9AXcapr3ycU+cyCvAIXBJriSvlpg3abujKyMyMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059015; c=relaxed/simple;
	bh=ILyYp7u+Xx5IQb71iXxLXGG7E5bV1KwyT8OFv+gb7kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWhH4IUQbQbXFvRdIqZZgQVFPEwQaC6Jxu0uzn4WpZl4Q/xGdyyPJArWx9jGH6l0nQ0iBJI2B5psXvVcNXRA+dr4QOYmLwspXKt94h0uOwx8yiUhM2/iLqkxRl/wtFHufk40W1fH70aQNFJZP1x1teoDfbi4vItYH2dEdWxOGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXKUMr51; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eo60CRZO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXKUMr51";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eo60CRZO"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rsC13129448
	for <sched-ext@lists.linux.dev>; Fri, 3 Jul 2026 06:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QgvYG/htqLFEmwIf1znvyLSb4uZLi0GqE7sjW+im1c8=; b=ZXKUMr51NaonOCBJ
	ia/h91fZOqegcHLCiYrmIvMk53Pmi/kD3KM08hcDy7kqTO1ppdlxvHcAjL03iMjC
	KYBCw8ivs+VlqwWFJUJ99yi8R9LqNLbsZJgFqvvK6weIjjZOOVNeVAkjfpGoTLDw
	Hst33Pz4i0o5AjJLO4icTyqcPLh1zSPNeyWywI/XzjpCBtF3OcIkgPMPtdxbBvcr
	mn4XKIemI+IPR9y/SATH3IzeliJf4G9NtgRPvc/mZZDjVK55Il0HVq0bS75gMrGK
	tYyQPK8HSNyUM11u2dRkNMfaR6lJ322lw61A5ZcECiPWnfpEZthzNnVG94uXARlc
	3EkSNQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc44gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 03 Jul 2026 06:10:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-846bc8a0d12so56851b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 02 Jul 2026 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783059012; x=1783663812; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgvYG/htqLFEmwIf1znvyLSb4uZLi0GqE7sjW+im1c8=;
        b=eo60CRZORgKUYRSRP+dQMHOi+cz5nGmc21htsRsbrqN7Bh8q8nHwGmhdBbgaWyRziV
         Fom0frpEY1pyA7iJ1PimalTD6fVIdI+FjSxXDbjHDIXD9Druh9YhQZ/oblD1N67i53zS
         45B88eI4YYAClFdcb4nqzfeURi8kdJRFHUrUadhza5Q1vUgvEd9iPRjtQhFzMUkY82yl
         AdbKiQVaiWRUkMD213LMpztTPfZ9lct2eObEKcOdONnKt8U9fbBjrMvhkfwVpq06Gpv5
         nYROLJLuytC/DL1xnrFkVkLcBrrsWQfWKBxMTwT2pzr5rl5arP+ahaW7OwVZKTUveBD0
         S5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059012; x=1783663812;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgvYG/htqLFEmwIf1znvyLSb4uZLi0GqE7sjW+im1c8=;
        b=L4YhjETf+JeiD0Nfqnq4fMwYTXDR9YOPHpTr5Am8oMUZHVJXHfY2Jwl1YjG0l63eBs
         EdLeZ+8VbHWGYw5Xgtfy8WdQudJRSNiiZOAze3xKRJdO8velW+HXiTtHm1r6CVj4Mkja
         zkh0g32vfWAB5NMQYlJS2L+xeFm1KdoCIY+vYSQHlutHEBIAjdEpfpnuufcfcT+JSSyH
         BUgAa4VylR8P4KjKHLzTpBFGLJx2PRU0FY2Vv/FC1LoRfKLgwSoUA7UPaxALidHwWtJz
         JBgmMmi40lVKBB6E8JGMBh4/v+zl8qJQPHsc5G0lCm7DgbRpQFCCT/XhSYJ/u+oWz8QI
         LpPg==
X-Forwarded-Encrypted: i=1; AHgh+RqAihUt2/+sA1f5Fra7dItT9HWwG8rWDth00AgdRexedCfdPHn+hGf4j1ae0Wip6+l9hapA+LNZVRQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YweChOiA8HrddU7WWcXHywqvH9zbbKmz120cwLzXryD1xioI3xG
	MvyC1hE1sFjQxh40ywKyHHouB8wYutbAj/29BB9G/qc6H4e5Fp02HbG8Gf0aX3HEF+KP3C+6wM4
	shuINt1kZF6mk7QV7EIMAUjvvvDyUWzuimezPlGIk+uefAYxJTcP72bV3sn/Ma1o=
X-Gm-Gg: AfdE7cmIa3jQSXM/I9ej/fvhzTSkF2qfySQoDpFrgq+2PaWEFchC3sOozp5+pLQcTEW
	2AhyFah4zI9OsSccZ7Fc6qtbkZExVSm+XA/QeB+BKMKT4yP8Hn6kP5o1HWDuK2xNY4zBwcGAzAz
	hFVBf2+5mwp5IeFzXdukXDsyrR943Viblw2Kggf27W+8S3yGR/fYPOfWuC/bRdjKIluMYoPt3Xt
	jWKTcHWLWF20QTSE8WnuyAvD0gRv3YlvT2ClF0Lx3gA5s+AUZiWuQHEtU8gXLTW1qSPSaUOsdp5
	QNKyuti929+eidr28c0QLiKjjmZF+yai86A3XYCJh/EfRuBpP1qVo+QTQjHcMQyI4uGhK3Ckvb2
	a6nLHKTsPUr69/1Oythbrh1voYgNFKoAikd6/dEjanv7RzNQy1LJbvdRY6Iz2XofJUHg7MfR6Ka
	yNYQ==
X-Received: by 2002:a05:6a00:2315:b0:847:88f4:30e1 with SMTP id d2e1a72fcca58-847c099a6camr5266126b3a.3.1783059011901;
        Thu, 02 Jul 2026 23:10:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2315:b0:847:88f4:30e1 with SMTP id d2e1a72fcca58-847c099a6camr5266098b3a.3.1783059011169;
        Thu, 02 Jul 2026 23:10:11 -0700 (PDT)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9b409fsm2365444b3a.52.2026.07.02.23.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:10:10 -0700 (PDT)
Message-ID: <4c58a564-f53b-4031-8821-206f359994ed@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:10:05 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] sched_ext: Split curr|donor references properly
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
        John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Christian Loehle <christian.loehle@arm.com>,
        David Dai
 <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-4-arighi@nvidia.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702171909.1994478-4-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aeAKmN0Lh90GhKqVtLh6o78wOY3i-8mF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1NiBTYWx0ZWRfX//lFgmDU6jop
 FgGB5mVjLyqm6/zrAcekve9we831tu0dbFpCmbzdAKldSc47JMLjQyTI9klzb1A+cdPDZL+FIVU
 prybaNfnI//2yl2f6aoIZmxh5Zo/EB+wqMNtg5o3SudMQMRVjgB5G97IhVZlB7X+fyT2JrwYFOo
 c++R7TLLVuMcS+DS8PtGRmITZpS0obIYpOU4FE5rKBmaeFZDUBLsxW4ECyhkHFdGWL1/Pg3Uew/
 dhzBv5lg+ba4XDO6IC3SD5bm4ab9wy8opjvQ00G9RDutZB5nNMK7se78mYwenHdL3cN8xaF3MDB
 SMftwgqZkKxWfcjBr11fMVtzq4gsN62gVBX7aKovf3sMqEx9nhhKNUPaMxwdVPC/dJA81vm9Y/o
 rwK8OE5oT50UkBrVQW42LsNcFOMaTy5taAsDYvFm3CT9ejN1btERSaSWz/q4N0tmqWZ+I+yR3hV
 +/4mqusOcInzSckoF0Q==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a475244 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1XWaLZrsAAAA:8 a=21McqEnWWSrJDHrl5ZIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: aeAKmN0Lh90GhKqVtLh6o78wOY3i-8mF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1NiBTYWx0ZWRfX6ZdtaFaUA5kK
 TKT5b3HejqYaWdKFXj6zdXgyLIregLaUrwW5ibm4Jx67+i3be6YKaycIVwBM9+tZnlaqcE1FqnZ
 Oh6W2qxY9J1/AzLU3twpz3V2qmjPsWc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030056

On 7/3/2026 1:09 AM, Andrea Righi wrote:
> From: John Stultz <jstultz@google.com>
> 
> With proxy-exec, we want to do the accounting against the donor most of
> the time. Without proxy-exec, there should be no difference as the
> rq->donor and rq->curr are the same.

Trying to understand more of the situation when donor and curr in
different sched_class? one is in scx and the other is not.
 could you pls help to explain more with this information in commit message?

> 
> So rework the logic to reference the rq->donor where appropriate.
> 
> Also add donor info to scx_dump_state().
> 
> Since CONFIG_SCHED_PROXY_EXEC currently depends on
> !CONFIG_SCHED_CLASS_EXT, this should have no effect (other than the
> extra donor output in scx_dump_state), but this is one step needed to
> eventually remove that constraint for proxy-exec.
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/sched/ext/ext.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1a0ec985da77d..1588565050679 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1145,17 +1145,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
>  
>  static void update_curr_scx(struct rq *rq)
>  {
> -	struct task_struct *curr = rq->curr;
> +	struct task_struct *donor = rq->donor;
>  	s64 delta_exec;
>  
>  	delta_exec = update_curr_common(rq);
>  	if (unlikely(delta_exec <= 0))
>  		return;
>  
> -	if (curr->scx.slice != SCX_SLICE_INF) {
> -		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
> -		if (!curr->scx.slice)
> -			touch_core_sched(rq, curr);
> +	if (donor->scx.slice != SCX_SLICE_INF) {
> +		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
> +		if (!donor->scx.slice)
> +			touch_core_sched(rq, donor);
>  	}
>  
>  	dl_server_update(&rq->ext_server, delta_exec);
> @@ -1316,8 +1316,8 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
>  	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
>  		return;
>  
> -	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> -	    rq->curr->sched_class == &ext_sched_class) {
> +	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
> +	    rq->donor->sched_class == &ext_sched_class) {
>  		rq->curr->scx.slice = 0;

Do you forget to update rq->curr with rq->donor here?

>  		resched_curr(rq);
>  	}
> @@ -2464,7 +2464,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		}
>  
>  		/* if the destination CPU is idle, wake it up */
> -		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
> +		if (!fallback && sched_class_above(p->sched_class,
> +						      dst_rq->donor->sched_class))
>  			resched_curr(dst_rq);
>  	}
>  
> @@ -2876,7 +2877,7 @@ static struct task_struct *first_local_task(struct rq *rq)
>  static struct task_struct *
>  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
> -	struct task_struct *prev = rq->curr;
> +	struct task_struct *prev = rq->donor;
>  	bool keep_prev;
>  	struct task_struct *p;
>  
> @@ -4029,7 +4030,7 @@ static void run_deferred(struct rq *rq)
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> -	struct task_struct *p = rq->curr;
> +	struct task_struct *p = rq->donor;
>  	struct scx_sched *sch = scx_task_sched(p);
>  
>  	if (p->sched_class != &ext_sched_class)
> @@ -6007,6 +6008,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
>  	dump_line(&ns, "          curr=%s[%d] class=%ps",
>  		  rq->curr->comm, rq->curr->pid,
>  		  rq->curr->sched_class);
> +	dump_line(&ns, "          donor=%s[%d] class=%ps",
> +		  rq->donor->comm, rq->donor->pid,
> +		  rq->donor->sched_class);
>  	if (!cpumask_empty(rq->scx.cpus_to_kick))
>  		dump_line(&ns, "  cpus_to_kick   : %*pb",
>  			  cpumask_pr_args(rq->scx.cpus_to_kick));
> @@ -7452,7 +7456,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
>  	unsigned long flags;
>  
>  	raw_spin_rq_lock_irqsave(rq, flags);
> -	cur_class = rq->curr->sched_class;
> +	cur_class = rq->donor->sched_class;
>  
>  	/*
>  	 * During CPU hotplug, a CPU may depend on kicking itself to make
> @@ -7464,7 +7468,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
>  	    !sched_class_above(cur_class, &ext_sched_class)) {
>  		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
>  			if (cur_class == &ext_sched_class)
> -				rq->curr->scx.slice = 0;
> +				rq->donor->scx.slice = 0;
>  			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
>  		}
>  


-- 
Thx and BRs,
Aiqun(Maria) Yu
