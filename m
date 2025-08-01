Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E026C386
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060317; cv=none; b=m9sAfj1WUtP6yHxCx+8ZnyjaA/moszUPg6EojCv4WqNN5V6KjGnEenSeMH2U4tFfVmGflJoK+HOkdW444TWhKZUnsubVI5LE2hAuaPDBkwuaYORB2AzOV9lOWVs2vmbBVZPIgKaQS+pDA4rPATrgCtNj7ftD4GqD92inrvqGYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060317; c=relaxed/simple;
	bh=KF9x5kdJRLx1xotHe/1wP9u0pTSCMds+cnMTN5T+KKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMqshQRCVs89umvjIzYrfHQ520TE/qZbzhKcpbHrSc3ijI492hs3nowjCEKgZNP5H1LrOAaw4eopkE8cpwbh7guZV908CP9l21IB2xi7Hau84bw/x59xRweX3f96xsIiF9X/8cqFnn128K8RSkhvbAqQyMG2yOHrWyoDLgZ5qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA771516;
	Fri,  1 Aug 2025 07:58:27 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6073F66E;
	Fri,  1 Aug 2025 07:58:33 -0700 (PDT)
Message-ID: <7aa0ba1c-bcd4-4ac6-9699-98e2526fb15d@arm.com>
Date: Fri, 1 Aug 2025 15:58:27 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sched_ext: Provide scx_bpf_remote_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
 void@manifault.com, mingo@redhat.com, peterz@infradead.org
References: <20250801141741.355059-1-christian.loehle@arm.com>
 <20250801141741.355059-3-christian.loehle@arm.com> <aIzTcxGC6_5Ntm18@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aIzTcxGC6_5Ntm18@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 15:47, Andrea Righi wrote:
> On Fri, Aug 01, 2025 at 03:17:40PM +0100, Christian Loehle wrote:
>> Provide scx_bpf_remote_curr() as a way for scx schedulers to
>> check the curr task of a remote rq, without assuming its lock
>> or acquiring any.
>>
>> Many scx schedulers make use of scx_bpf_cpu_rq() to check a
>> remote curr (e.g. to see if it should be preempted). This is
>> problematic because scx_bpf_cpu_rq() provides access to all
>> fields of struct rq, most of which aren't safe to use without
>> holding the associated rq lock.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c                       | 15 +++++++++++++++
>>  tools/sched_ext/include/scx/common.bpf.  |  1 +
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index b734f55f3318..92e66bb0b5f2 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7436,6 +7436,20 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  	return cpu_rq(cpu);
>>  }
>>  
>> +/**
>> + * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
>> + * @cpu: CPU of the rq
>> + *
>> + * Neither a rq lock nor a task reference is acquired.
>> + */
>> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
>> +{
>> +	if (!kf_cpu_valid(cpu, NULL))
>> +		return NULL;
>> +
>> +	return cpu_rq(cpu)->curr;
>> +}
> 
> As mentioned in my previou comment, this should be something like:
> 
>  if (!kf_cpu_valid(cpu, NULL))
>  	return NULL;
> 
>  rcu_read_lock();
>  p = cpu_rq(cpu)->curr;
>  if (p)
>  	p = bpf_task_acquire(p);
>  rcu_read_unlock();
> 
>  return p;

Alright, that's actually what I had at first, but went with the
drop-in-replacement that doesn't acquire.
I'll resend with an acquire.
Thanks, Andrea!

> 
> We may still race with CPU hotplugging, but I think it's not always
> possible to use cpus_read_lock/unlock() here. Also, most of the scx
> schedulers are restarted on CPU hotplugging events, so... one thing at a
> time. :)
> 
>> +
>>  /**
>>   * scx_bpf_task_cgroup - Return the sched cgroup of a task
>>   * @p: task of interest
>> @@ -7600,6 +7614,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
>> +BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL)
>>  #ifdef CONFIG_CGROUP_SCHED
>>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>>  #endif
>> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
>> index d4e21558e982..e5d4ef124532 100644
>> --- a/tools/sched_ext/include/scx/common.bpf.h
>> +++ b/tools/sched_ext/include/scx/common.bpf.h
>> @@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
>>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>> +struct task_struct *scx_bpf_remote_curr(s32 cpu) __ksym;
>>  struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
>>  u64 scx_bpf_now(void) __ksym __weak;
>>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
>> -- 
>> 2.34.1
>>
> 
> -Andrea

