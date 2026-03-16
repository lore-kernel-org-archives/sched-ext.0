Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB327FD74
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659570; cv=none; b=cX1dEBAPgEC61KW4ILT5qeQe4oITkKl7jsbrYS+K8rzCNk6AUB7sUySh5dmnL0BI+gihpKSpaEqIwc1NXBRUeijo2ZTynEYa5QbGted2uFdeeOMRM1ote7EDVDhB/2XpBMWbYxXz4hLr87jcsI5CG8hSGesTf2HPLEwRbt8pbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659570; c=relaxed/simple;
	bh=0zQ6fs2ohWt+9jsO2su/IMuFegSZK3H8H4KQEDebPP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2dXXDdbxalRln6LF3aTsR9XTm37IHFaKxXg0S05EDMdovUYPPkf8WCnXR5+oA9wp1H1ovn4yDxcoat1iuGuKJsOSpuxCSVwkuTc8IeDGcl9DVQydEjk7xOGNZyIdaiX4K6MW5lCAapPkgS3EJWoe3zWxmr4y/1JyYPR2kG3gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4461477;
	Mon, 16 Mar 2026 04:12:42 -0700 (PDT)
Received: from [10.1.28.15] (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1897B3F778;
	Mon, 16 Mar 2026 04:12:45 -0700 (PDT)
Message-ID: <1e72dc1d-ce46-4dcd-9811-761221fa20c0@arm.com>
Date: Mon, 16 Mar 2026 11:12:43 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
 shuah@kernel.org, dietmar.eggemann@arm.com
References: <20260316100249.1651641-1-christian.loehle@arm.com>
 <20260316100249.1651641-2-christian.loehle@arm.com> <abfgRv5DkOnCzz-q@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <abfgRv5DkOnCzz-q@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 10:49, Andrea Righi wrote:
> Hi Christian,
> 
> On Mon, Mar 16, 2026 at 10:02:48AM +0000, Christian Loehle wrote:
>> SCX_KICK_WAIT causes kick_cpus_irq_workfn() to busy-wait using
>> smp_cond_load_acquire() until the target CPU's current SCX task has been
>> context-switched out (its kick_sync counter advanced).
>>
>> If multiple CPUs each issue SCX_KICK_WAIT targeting one another
>> concurrently — e.g. CPU A waits for CPU B, B waits for CPU C, C waits for
>> CPU A — all CPUs can end up wedged inside smp_cond_load_acquire()
>> simultaneously.  Because each victim CPU is spinning in hardirq/irq_work
>> context, it cannot reschedule, so no kick_sync counter ever advances and
>> the system deadlocks.
>>
>> Fix this by serializing access to the wait loop behind a global raw
>> spinlock (scx_kick_wait_lock).  Only one CPU at a time may execute the
>> wait loop; any other CPU that has SCX_KICK_WAIT work to do and fails to
>> acquire the lock records itself in scx_kick_wait_pending and returns.
>> When the active waiter finishes and releases the lock, it replays the
>> pending set by re-queuing each pending CPU's kick_cpus_irq_work, ensuring
>> no wait request is silently dropped.
>>
>> This is deliberately a coarse serialization: multiple simultaneous wait
>> operations now run sequentially, increasing latency.  In exchange,
>> deadlocks are impossible regardless of the cycle length (A->B->C->...->A).
>>
>> Also clear scx_kick_wait_pending in free_kick_syncs() so that any stale
>> bits left by a CPU that deferred just as the scheduler exited are reset
>> before the next scheduler instance loads.
>>
>> Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 26a6ac2f8826..b63ae13d0486 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -89,6 +89,19 @@ struct scx_kick_syncs {
>>  
>>  static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
>>  
>> +/*
>> + * Serialize %SCX_KICK_WAIT processing across CPUs to avoid wait cycles.
>> + * Callers failing to acquire @scx_kick_wait_lock defer by recording
>> + * themselves in @scx_kick_wait_pending and are retriggered when the active
>> + * waiter completes.
>> + *
>> + * Lock ordering: @scx_kick_wait_lock is always acquired before
>> + * @scx_kick_wait_pending_lock; the two are never taken in the opposite order.
>> + */
>> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_lock);
>> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_pending_lock);
>> +static cpumask_t scx_kick_wait_pending;
>> +
>>  /*
>>   * Direct dispatch marker.
>>   *
>> @@ -4279,6 +4292,13 @@ static void free_kick_syncs(void)
>>  		if (to_free)
>>  			kvfree_rcu(to_free, rcu);
>>  	}
>> +
>> +	/*
>> +	 * Clear any CPUs that were waiting for the lock when the scheduler
>> +	 * exited.  Their irq_work has already returned so no in-flight
>> +	 * waiter can observe the stale bits on the next enable.
>> +	 */
>> +	cpumask_clear(&scx_kick_wait_pending);
> 
> Do we need a raw_spin_lock/unlock(&scx_kick_wait_pending_lock) here to make
> sure we're not racing with with cpumask_set_cpu()/cpumask_clear_cpu()?
> Probably it's not that relevant at this point, but I'd keep the locking for
> correctness.

Of course, thanks. Noted for v2!

Are you fine with the approach, i.e. hitting it with the sledge hammer of global
serialization?
I have something more complex in mind too, but yeah, we'd need to at least either
let scx_bpf_kick_cpu() fail / -ERETRY or restrict kicking/kicked CPUs and introduce
a whole lot of infra, which seems a bit overkill for a apparently barely used
interface and also would be nasty to backport.
