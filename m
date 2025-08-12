Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB62ED85B
	for <sched-ext@lists.linux.dev>; Tue, 12 Aug 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998846; cv=none; b=I26BNR+Rqfqi75sEtkflvtgpkOZPOQcIs83kJyMVn1dH4psSpv8A8oDq82VVNmSqt691CYzk4+uJ4Vm/k50L4eSoO7LseUY66kn/s83iZSx3JK34l8a+uh5g2lMoEytIC1OxHT9BK1M6pFsrkknQLeL7WMqGFBmHuDMvvviw4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998846; c=relaxed/simple;
	bh=g1vwROxCO5WdQqIchwM/IVald5YgOpS/73AvjuIAUXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPcnRoDbxXLaiTIVu0kJ2QjBoN46QmB/amsHHSKPtumR8sHlVAuyoGXbp1TqW2NRAKUgctW+2L+4JLruiIE0ZEay2MH4MVJ6V9ReGdgq/SaKcAmHgD1hqUBpVk0rDKi9IAJvv92XIUHkGwRjOYJs2WBc+QU+xc5XhDJsvaLDwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE91625E1;
	Tue, 12 Aug 2025 04:40:35 -0700 (PDT)
Received: from [10.1.37.57] (e127648.arm.com [10.1.37.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4F1B3F63F;
	Tue, 12 Aug 2025 04:40:41 -0700 (PDT)
Message-ID: <c9d6f327-3eca-4bf6-a5b1-323749ee44f1@arm.com>
Date: Tue, 12 Aug 2025 12:40:39 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] sched_ext: Harden scx_bpf_cpu_rq()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, arighi@nvidia.com, void@manifault.com,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com, jake@hillion.co.uk
References: <20250811212150.85759-1-christian.loehle@arm.com>
 <20250812080046.GF4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250812080046.GF4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 09:00, Peter Zijlstra wrote:
> On Mon, Aug 11, 2025 at 10:21:47PM +0100, Christian Loehle wrote:
>> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
>> holding the associated rq.
>> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
>> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
>> So provide an alternative scx_bpf_task_acquire_remote_curr() that
>> doesn't expose struct rq and provide a hardened scx_bpf_cpu_rq_locked()
>> by ensuring we hold the rq lock.
>> Add a deprecation warning to scx_bpf_cpu_rq_locked() that mentions the
>> two alternatives.
>>
>> This also simplifies scx code from:
>>
>> rq = scx_bpf_cpu_rq(cpu);
>> if (!rq)
>> 	return;
>> p = rq->curr
>> if (!p)
>> 	return;
>> /* ... Do something with p */
>>
>> into:
>>
>> p = scx_bpf_task_acquire_remote_curr(cpu);
>> if (!p)
>> 	return;
>> /* ... Do something with p */
>> bpf_task_release(p);
> 
> Why do that mandatory refcount dance, rather than directly exposing the
> RCU-ness of that pointer? IIRC BPF was good with RCU.

Just because that's how
bpf_task_from_pid()
bpf_task_from_vpid()
already work. I have no strong preference either way.
Apart from the above just returning
rcu_dereference(cpu_rq(cpu)->curr);
is obviously a bit less cumbersome (and yes, RCUs are exposed to BPF,
for scx most callbacks have that implicit anyway.)

I'll change it to scx_bpf_remote_curr() that does that in the next
version, thanks!
