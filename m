Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A32E1F01
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026555; cv=none; b=uuEsZQKFYSR/bmrbmVIY79V1mw0YDmayVlqCWaj1f32l+70csG9ZPOm3q5oLb5cuIUtFLkqFSY5bWb2FAIp5nbkhEwPkeahszfwewbJPTLXUkRJKYyjo4y2EJsg6M3tVtExzxTtjpS8NfmgWYP4CcwcTbzgTCaBwC55bMIbQyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026555; c=relaxed/simple;
	bh=Cur4HguJBmNejFu8hNFhkcGD4rPJ0wCpovu8PAoIcbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/tCtnMRcFuoTUFn9aO9NMhbrIbRnGeaD2c89phEnfdic6YODMak9zyg5dbZxLahzYS3tmLYKG9XX5fLZ4VNppWbhiOzOokrn+niGEMWC4iGWEi2whQ9L2RnLXI966TePQ28EyVNhs0y1A5o1uoFSfTCHWV/9tXVDmVCYNoT910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93CCB339;
	Mon,  2 Feb 2026 02:02:26 -0800 (PST)
Received: from [10.1.35.46] (unknown [10.1.35.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69EA3F740;
	Mon,  2 Feb 2026 02:02:31 -0800 (PST)
Message-ID: <dbced6c4-388d-4f2e-90c3-cb2299fca34d@arm.com>
Date: Mon, 2 Feb 2026 10:02:30 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com> <aYBWAzFDX8Rv-paN@gpd4>
 <aYBtydrekCC-pPL_@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aYBtydrekCC-pPL_@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 09:26, Andrea Righi wrote:
> On Mon, Feb 02, 2026 at 08:45:18AM +0100, Andrea Righi wrote:
> ...
>>> So I have finally gotten around updating scx_storm to the new semantics,
>>> see:
>>> https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics
>>>
>>> I don't think the new ops.dequeue() are enough to make inserts to local-on
>>> from anywhere safe, because it's still racing with dequeue from another CPU?
>>
>> Yeah, with this patch set BPF schedulers get proper ops.dequeue()
>> callbacks, but we're not fixing the usage of SCX_DSQ_LOCAL_ON from
>> ops.dispatch().
>>
>> When task properties change between scx_bpf_dsq_insert() and the actual
>> dispatch, task_can_run_on_remote_rq() can still trigger a fatal
>> scx_error().
>>
>> The ops.dequeue(SCX_DEQ_SCHED_CHANGE) notifications happens after the
>> property change, so it can't prevent already-queued dispatches from
>> failing. The race window is between ops.dispatch() returning and
>> dispatch_to_local_dsq() executing.
>>
>> We can address this in a separate patch set. One thing at a time. :)
> 
> Thinking more on this, the problem is that we're passing enforce=true to
> task_can_run_on_remote_rq(), triggering a critical failure - scx_error().
> There's a logic in task_can_run_on_remote_rq() to fallback to the global
> DSQ, that doesn't happen if we pass enforce=true, due to scx_error().
> 
> However, instead of the global DSQ fallback, I was wondering if it'd be
> better to simply re-enqueue the task - setting SCX_ENQ_REENQ - if the
> target local DSQ isn't valid anymore when the dispatch is finalized.
> 
> In this way using SCX_DSQ_LOCAL_ON | cpu from ops.dispatch() would simply
> trigger a re-enqueue when "cpu" isn't valid anymore (due to concurrent
> affinity / migration disabled changes) and the BPF scheduler can handle
> that in another ops.enqueue().
> 
> What do you think?

I think that's a lot more versatile for the BPF scheduler than using the
global DSQ as fallback in that case, so yeah I'm all for it!

