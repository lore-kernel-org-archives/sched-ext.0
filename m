Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0925F7A9
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312575; cv=none; b=dq9sqcRIFzridLEbw0bb4vTLduDxtSEU+Kuepqn6DrKABeWbLQUE3KfCT1EbazRX3H0JUC2moYwhEIHg4fIGgq4itYabBDZlqvZc3FHQcVU4EdZnoMpuqOtDuLf4bISWKDRvV1bMmbuzEBB11nu+VHQlDjDmZ0Py5iFdpDe9mJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312575; c=relaxed/simple;
	bh=KVFdHv6v0HPgtkAz+4l8lGdkysZRAs30mbAPN7yO0tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vt0gXDT23edGASfewwNsHAJBo07v55/SnUrQ2MshPy65Sa4L+XeREV6R9izV7IOPaiLGfx13xWtzy62p93u5IpkWamHDLYVvFhIUE4hfq8c6dWugAkDzoEfNNjpugEwDuR+4UTR0cfo8UHDPKNkY7o0zkvzk3zzmdv9KS3yW3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50485150C;
	Mon,  4 Aug 2025 06:02:43 -0700 (PDT)
Received: from [10.1.25.45] (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A49B63F673;
	Mon,  4 Aug 2025 06:02:49 -0700 (PDT)
Message-ID: <1ae1700c-9102-44b1-93f0-1c2ebc4f433e@arm.com>
Date: Mon, 4 Aug 2025 14:02:47 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-4-christian.loehle@arm.com> <aJCqb-ZI4pd15cr5@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aJCqb-ZI4pd15cr5@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 13:41, Andrea Righi wrote:
> On Mon, Aug 04, 2025 at 12:27:43PM +0100, Christian Loehle wrote:
>> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
>> Furthermore they become meaningless without rq lock, too.
>> Only return scx_bpf_cpu_rq() if we hold rq lock of that rq.
>>
>> All upstream scx schedulers can be converted into the new
>> scx_bpf_remote_curr() instead.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 1d9d9cbed0aa..0b05ddc1f100 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7420,10 +7420,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>>   */
>>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  {
>> +	struct rq *rq;
>> +
>>  	if (!kf_cpu_valid(cpu, NULL))
>>  		return NULL;
>>  
>> -	return cpu_rq(cpu);
>> +	rq = cpu_rq(cpu);
>> +	if (rq != scx_locked_rq_state) {
> 
> I think you want to check rq != scx_locked_rq(), since scx_locked_rq_state
> is a per-CPU variable.

Duh, of course. m(

> 
> We may also want to add a preempt_disable/enable() for consistency. How
> about something like this?
> 
> 	preempt_disable();
> 	rq = cpu_rq(cpu);
> 	if (rq != scx_locked_rq()) {
> 		scx_kf_error("Accessing CPU%d rq from CPU%d without holding its lock",
> 			     cpu, smp_processor_id());
> 		rq = NULL;
> 	}
> 	preempt_enable();

Ack

