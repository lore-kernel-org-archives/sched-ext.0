Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4825F998
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314041; cv=none; b=gHPGgMhuN+eI7eUdNL6yuYI0Cm7xEa33c+9EsJfPvx5aFbJqEoxzCA/Rh7m/pIpdjnV4l06LKmbFHTIdnSsjIo6NAnd9BpmLY8n04ZTVOVrbXb8PU8vJA9Dvn8BlDnFPaS3j4EfhCvM2NTfksNxiX2OvoNtPmgJPmKkpkkLW2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314041; c=relaxed/simple;
	bh=hrOFhNzQwtjQEgKoxn82R5VHolV33TM8BcW3dPefzrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYVKuTkwvYa2V7v0Z/I19elXjLg3mmeJ60kYtk+cklUUAQXlI0GOM+PjiPVm/JLMxBJElhh8jNBRK3cA4ECTTV7kEMaKafHSmrpHTfbgBhwRWB/OfS0NHYTvihGlviOU90Xsegzl8Gcl14xFTleTEDHq54Ck+KdOSVem82696pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CFCE150C;
	Mon,  4 Aug 2025 06:27:10 -0700 (PDT)
Received: from [10.1.25.45] (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B263F673;
	Mon,  4 Aug 2025 06:27:16 -0700 (PDT)
Message-ID: <c8b71208-b8da-4f64-9550-13ddeca9b225@arm.com>
Date: Mon, 4 Aug 2025 14:27:14 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sched_ext: Provide scx_bpf_remote_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-3-christian.loehle@arm.com> <aJCsx7hbCD9f5RK3@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aJCsx7hbCD9f5RK3@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 13:51, Andrea Righi wrote:
> On Mon, Aug 04, 2025 at 12:27:42PM +0100, Christian Loehle wrote:
>> Provide scx_bpf_remote_curr() as a way for scx schedulers to
>> check the curr task of a remote rq, without assuming its lock
>> is held.
>>
>> Many scx schedulers make use of scx_bpf_cpu_rq() to check a
>> remote curr (e.g. to see if it should be preempted). This is
>> problematic because scx_bpf_cpu_rq() provides access to all
>> fields of struct rq, most of which aren't safe to use without
>> holding the associated rq lock.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c                       | 24 ++++++++++++++++++++++++
>>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 3ea3f0f18030..1d9d9cbed0aa 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7426,6 +7426,29 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  	return cpu_rq(cpu);
>>  }
>>
>> +struct task_struct *bpf_task_acquire(struct task_struct *p);
> 
> Can we move include <linux/btf.h> all the way to the top? In this way we
> don't have to add this forward declaration.
> 

At least currently <linux/btf.h> doesn't declare bpf_task_acquire.
I'm not quite sure what's most elegant here, none of the bpf helper
kfuncs seem to be used from kernel code / kernel/sched/ext.c


>> +
>> +/**
>> + * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
>> + * @cpu: CPU of the rq
>> + *
>> + * Increments the refcount of the task_struct which needs to be released later.
> 
> Maybe we should mention that the task must be released by calling
> bpf_task_release().

Sure.

> 
> While at it, what do you think about renaming this to something like
> scx_bpf_task_acquire_on_cpu(), so that it looks similar to
> bpf_task_acquire()?

Will change it to
bpf_task_acquire_remote_curr()?
..on_cpu() seems like a bit of a jump semantically.

> 
>> + */
>> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
>> +{
>> +	struct task_struct *p;
>> +
>> +	if (!kf_cpu_valid(cpu, NULL))
>> +		return NULL;
>> +
>> +	rcu_read_lock();
>> +	p = cpu_rq(cpu)->curr;
>> +	if (p)
>> +		p = bpf_task_acquire(p);
>> +	rcu_read_unlock();
>> +	return p;
>> +}
>> +
>>  /**
>>   * scx_bpf_task_cgroup - Return the sched cgroup of a task
>>   * @p: task of interest
>> @@ -7590,6 +7613,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
>> +BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL | KF_ACQUIRE)
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
> Thanks,
> -Andrea

