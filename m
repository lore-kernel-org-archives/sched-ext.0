Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD994372B2C
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699993; cv=none; b=YRyMRBMIZ7RY03Pc62ATCklkX1nl5MCjKGv8YV9s8iUg2X9tHCPqO71ebE+InJ6SXlIglTetqEy5CSCZvU8qLhlLFOQauU0rSCwRJ1jcnJG/88J8/KggZep0eB4YLmdt9BdMgy9sD3tuidREcCBkOqCTsI2fg/Uq+cbz827HoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699993; c=relaxed/simple;
	bh=e5dOuCCDwUf3EU9mP3PtOmGyvPEZB/V5HBYkrVkHPoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p94dER+AmL9WL4uwnNAFtxHRc4guSk6vZ4hMOe6D1moVQoUJqYLiewE4QWhaNiNxOipukoo1aXcc+dL7iRSZVfFcqQQxT6x13ghcCE0d/KsdKAtXn8JgIt9vmDnU8szFjRnDwQazFQn+HAcxPQd9JxT/upPfO0HS6N4zHbIsmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D6B1476;
	Mon, 16 Mar 2026 15:26:22 -0700 (PDT)
Received: from [10.57.19.92] (unknown [10.57.19.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C123F7BD;
	Mon, 16 Mar 2026 15:26:26 -0700 (PDT)
Message-ID: <d0d1d1fa-7ba3-456d-b2a9-cc3f550e2cf1@arm.com>
Date: Mon, 16 Mar 2026 22:26:23 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
 shuah@kernel.org, dietmar.eggemann@arm.com
References: <20260316100249.1651641-1-christian.loehle@arm.com>
 <20260316100249.1651641-2-christian.loehle@arm.com>
 <abhB4bCsvd9WDxid@slm.duckdns.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <abhB4bCsvd9WDxid@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 17:46, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 16, 2026 at 10:02:48AM +0000, Christian Loehle wrote:
>> @@ -5686,11 +5718,20 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>>  		 * task is picked subsequently. The latter is necessary to break
>>  		 * the wait when $cpu is taken by a higher sched class.
>>  		 */
>> -		if (cpu != cpu_of(this_rq))
>> +		if (cpu != this_cpu)
>>  			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
> 
> Given that irq_work is executed at the end of IRQ handling, we can just
> reschedule the irq work when the condition is not met (or separate that out
> into its own irq_work). That way, I think we can avoid the global lock.
> 
I'll go poke at it some more, but I think it's not guaranteed that B actually
advances kick_sync if A keeps kicking. At least not if the handling is in HARD irqwork?
Or what would the separated out irq work do differently?
