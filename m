Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645CB3E8C48
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000088; cv=none; b=Y5c9t7s2ydQgF6uAzDCNKDjaW3kz2GaXAqHqsJzV0KKqFsfPvu5nURYBmoovc2wrVJjuWaNYERv8LoLRd5FzQDYq2w7FgQf4/3tfvlWFz7KjQle8iZHlzMjNDc+Pop+kRZ/PRZeTt9jAzZqzID1fVcTN9IdSqpR4dYXz2tWdboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000088; c=relaxed/simple;
	bh=E0w9v4ollfskhCuz4k+TOLZ51LtnLdukdOAYJrTA78w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOsKT7OZH5FXoYbNWylmkAbQ2QIpMuXZsd7F2xwPqUc0ljecWnP0uVPSMBHAn75/qEelKmW82krBP8jo19d3yhcvGkK3bxM5YPsj58nYhEhnBT0GqaM8sDzyYDkrWM3Pln8mFpRtWik94SefqUbmrSvj4Fy7s2oxKwz+ipQD/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378E61476;
	Wed, 21 Jan 2026 04:54:39 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8AF3F632;
	Wed, 21 Jan 2026 04:54:43 -0800 (PST)
Message-ID: <9e5d53ad-c347-4f24-ad6b-9abc1088e35d@arm.com>
Date: Wed, 21 Jan 2026 12:54:42 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260121123118.964704-1-arighi@nvidia.com>
 <20260121123118.964704-2-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260121123118.964704-2-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/26 12:25, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change scenarios. As a result, BPF schedulers
> cannot reliably track task state.
> 
> In addition, some ops.dequeue() callbacks can be skipped (e.g., during
> direct dispatch), so ops.enqueue() calls are not always paired with a
> corresponding ops.dequeue(), potentially breaking accounting logic.
> 
> Fix this by guaranteeing that every ops.enqueue() is matched with a
> corresponding ops.dequeue(), and introduce the SCX_DEQ_ASYNC flag to
> distinguish dequeues triggered by scheduling property changes from those
> occurring in the normal dispatch workflow.
> 
> New semantics:
> 1. ops.enqueue() is called when a task enters the BPF scheduler
> 2. ops.dequeue() is called when the task leaves the BPF scheduler,
>    because it is dispatched to a DSQ (regular workflow)
> 3. ops.dequeue(SCX_DEQ_ASYNC) is called when the task leaves the BPF
>    scheduler, because a task property is changed (sched_change)
> 
> The SCX_DEQ_ASYNC flag allows BPF schedulers to distinguish between a
> regular dispatch workflow and a task property changes (e.g.,
> sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> balancing, CPU migrations, etc.).
> 
> This allows BPF schedulers to:
> - reliably track task ownership and lifecycle,
> - maintain accurate accounting of enqueue/dequeue pairs,
> - update internal state when tasks change properties.
> [snip]

Cool, so with this patch I should be able to fix my scx_storm BPF
scheduler doing local inserts, as long as I track all the task's status
that are not in a DSQ?
https://github.com/cloehle/scx/commit/25ea91d8f7fea1f31cf426561b432180fb9cf76a
mentioned in
https://github.com/sched-ext/scx/issues/2825

Let me give that a go and report back!
