Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C12D5C91
	for <sched-ext@lists.linux.dev>; Sun, 10 Aug 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864353; cv=none; b=CNQJs1JmpSR2CzMZz66vsCiatX2c7bv7aK+uUvC/AKmS9JEBXO/zcF2i7XagXjXHBgPTYcHsrhEkjOgXE/cOT6gvwwm4G+haT1XUIbaaMgCvtyACAdbeZYT/y9E7HfuQ1xlrBZN8F7advBW5HspXMAWTxRs2sfr0Tsp6qKxxvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864353; c=relaxed/simple;
	bh=xSTvinf6QHJ/tcvawD5nXvMu0BMw86IESQVB3t83wRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUCkv1cA3JqSLwepJEHrwIAJrcLIB1IXCVT43yRdCMLGiK1h4VPRqOwtNOGMQSEpPSdUxSK+tzK2vzq+vZBTvKzpTcoEHt2vHHw13mqpRGDO8hjPxw+kUECduIZbezkOEeuGG4t3G4tu13uC5Urn6v9YIc4V56UF/f69zlsrhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344D61596;
	Sun, 10 Aug 2025 15:18:56 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5363F738;
	Sun, 10 Aug 2025 15:19:02 -0700 (PDT)
Message-ID: <cc68722b-75f8-4de8-bf83-0fc1518ad60c@arm.com>
Date: Sun, 10 Aug 2025 23:18:52 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org> <aJh6BWX7rYCNrzGu@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aJh6BWX7rYCNrzGu@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/25 11:52, Andrea Righi wrote:
> On Sat, Aug 09, 2025 at 09:03:46AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Aug 05, 2025 at 12:10:36PM +0100, Christian Loehle wrote:
>>> @@ -7420,10 +7420,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>>>   */
>>>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>>  {
>>> +	struct rq *rq;
>>> +
>>>  	if (!kf_cpu_valid(cpu, NULL))
>>>  		return NULL;
>>>  
>>> -	return cpu_rq(cpu);
>>> +	preempt_disable();
>>> +	rq = cpu_rq(cpu);
>>> +	if (rq != scx_locked_rq()) {
>>> +		scx_kf_error("Accessing not locked rq %d", cpu);
>>> +		rq = NULL;
>>> +	}
>>> +	preempt_enable();
>>
>> So, this will break the existing scheduler binaries immediately, which I
>> don't think is a good way to go about it. Can you add a pr_warn_once() to
>> print deprecation warning and add e.g. scx_bpf_locked_cpu_rq() instead?
> 
> Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> we force schedulers to check for NULL and, if they don't, the verifier
> won't be happy, so this already breaks existing binaries.
> 
> Even if a scheduler performs the NULL check, this change might still cause
> incorrect behaviors, which can be worse than triggering an error.
> 
> How about we introduce scx_bpf_locked_cpu_rq() and we still trigger an
> error in scx_bpf_cpu_rq(), mentioning about the new locked kfunc and
> scx_bpf_task_acquire_remote_curr()?

If we still trigger an error in scx_bpf_cpu_rq() what's the difference
between scx_bpf_cpu_rq() and scx_bpf_cpu_rq_locked() then?
Just the error message?

