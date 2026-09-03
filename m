Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA731E106;
	Thu,  3 Sep 2026 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419120; cv=none; b=BvTy/Ga9DtKt0R/VLHCinlJR/VE85A27mXM3uvkTV+4Sq83XO9UYspoLYUc9XnuOGPKSvhKtP3pQ1EZpMnITqPdnJ3SjlK7+0etABJPxj0/j/PePQlRZL+QsQX+Rk5eF2PgWtLHPhBD0eOFleIpcN6dSsI/raDT8zvbdlO828Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419120; c=relaxed/simple;
	bh=Hya4wvtDliJ4OHidTyaSFddktPet8bu5TEy3biRmPFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gz5YI+I4yBlENh/NByClpGQSx2MzLJQe4IrN6+OZ8knrYp/Y5Sl/Azr49GhBIko/QwWv9yTeMxUNKT6i2tiSrYyG2K/C/11Lu3YUz3cnfvh7J4VSo7c4L1d44kb92itGuXaqMn/CuepyJTnayxeMgls2mlSFVYRwD++VmJQBVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc139436a76511f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5c270c26-e288-4919-a95d-51748516f4e9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:62461457bf7e8221defec45b8364f82a,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc139436a76511f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from [10.42.12.206] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1568282815; Thu, 03 Sep 2026 15:05:08 +0800
Message-ID: <77807d4c-b9a2-4171-aab0-5ec4ab111ace@kylinos.cn>
Date: Thu, 3 Sep 2026 15:05:05 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Make scx_locked_rq() return NULL from NMI
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
References: <20260903032953.659847-1-liwanwu@kylinos.cn>
 <20260903035719.721445-1-liwanwu@kylinos.cn>
 <20260903041854.936D41F000E9@smtp.kernel.org>
Content-Language: en-US
From: liwanwu <liwanwu@kylinos.cn>
In-Reply-To: <20260903041854.936D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/3 12:18, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] scx_bpf_cpuperf_set() and scx_bpf_cidperf_set() deadlock in NMI when scx_locked_rq() returns NULL.
> 
> Pre-existing issues:
> - [High] Tracing BPF programs executing in NMI context can deadlock the system by calling pre-existing 'any' category kfuncs that acquire raw spinlocks.
> --
> 
> commit e3a4b62825e5b60c4d87fa4b8dd2f4b8dee65bbf
> Author: Wanwu Li <liwanwu@kylinos.cn>
> 
> sched_ext: Make scx_locked_rq() return NULL from NMI
> 
> scx_locked_rq() reads the per-CPU scx_locked_rq_state, which tracks the
> rq locked by the context running on the CPU. Tracing progs can call
> kfuncs from NMI, and an NMI interrupts - rather than replaces - the
> context that set scx_locked_rq_state, so a non-NULL read from NMI
> falsely tells the caller that it holds the interrupted context's rq lock.
> 
> Link: https://lore.kernel.org/r/d84b31727f04e1ed0d40042ba1c09e61@kernel.org
> 
>> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
>> index 27bbf5e04d900..faa80ac5a653a 100644
>> --- a/kernel/sched/ext/internal.h
>> +++ b/kernel/sched/ext/internal.h
>> @@ -2181,6 +2181,15 @@ static inline void scx_schedule_reenq_local(struct rq *rq, u64 reenq_flags)
>>    */
>>   static inline struct rq *scx_locked_rq(void)
>>   {
>> +	/*
>> +	 * Tracing progs can call kfuncs from NMI. scx_locked_rq_state tracks
>> +	 * the rq locked by the interrupted context, so a non-NULL read from
>> +	 * NMI would falsely claim its lock. Return NULL from NMI so that
>> +	 * callers take their unlocked paths.
>> +	 */
>> +	if (unlikely(in_nmi()))
>> +		return NULL;
>> +
> 
Already fixed in sched_ext: Reject NMI calls to lock-taking kfuncs.
> [Severity: High]
> Does returning NULL in NMI cause a deadlock in scx_cpuperf_set() and
> scx_cidperf_set()?
> 
> When a tracing BPF program executing in NMI context calls
> scx_bpf_cpuperf_set(), it now sees locked_rq as NULL:
> 
> kernel/sched/ext/ext.c:scx_cpuperf_set() {
>      [ ... ]
>      locked_rq = scx_locked_rq();
> 
>      /*
>       * If no rq lock is held, allow to operate on any CPU by acquiring
>       * the corresponding rq lock.
>       */
>      if (!locked_rq) {
>          rq_lock_irqsave(rq, &rf);
>          update_rq_clock(rq);
>      }
>      [ ... ]
> }
> 
> If the interrupted kernel context was already holding this CPU's rq->lock,
> wouldn't attempting to unconditionally acquire it here cause the NMI handler
> to spin forever and deadlock the system?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but several any category kfuncs
> unconditionally acquire raw spinlocks. Can these cause similar deadlocks if
> invoked from NMI tracing programs?
> 
> For example, scx_bpf_destroy_dsq() calls destroy_dsq():
> 
> kernel/sched/ext/ext.c:destroy_dsq() {
>      [ ... ]
>      raw_spin_lock_irqsave(&dsq->lock, flags);
>      [ ... ]
> }
> 
> Similarly, bpf_iter_scx_dsq_next() unconditionally takes the dsq lock:
> 
> kernel/sched/ext/ext.c:bpf_iter_scx_dsq_next() {
>      [ ... ]
>      guard(raw_spinlock_irqsave)(&kit->dsq->lock);
>      [ ... ]
> }
> 
> And scx_bpf_dsq_reenq() calls schedule_dsq_reenq() which also takes a raw
> spinlock:
> 
> kernel/sched/ext/ext.c:schedule_dsq_reenq() {
>      [ ... ]
>      guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
>      [ ... ]
> }
> 
Same as above.
> If an NMI interrupts a kernel path holding one of these locks and the tracing
> program invokes the corresponding kfunc, will the NMI handler spin forever
> trying to acquire the held lock?
> 
>>   	return __this_cpu_read(scx_locked_rq_state);
>>   }
> 
Here only read the lock-holding state without acquiring the lock.
