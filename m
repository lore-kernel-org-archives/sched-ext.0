Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE56334727
	for <sched-ext@lists.linux.dev>; Mon,  1 Sep 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733920; cv=none; b=cnpDoErYoLOJmssw9/83KMGZacvD0YEtkeuwj+VYJu2ICQW0EhcdzkGztrx4VAxrN61INKnC67NZWKsFWWSP4G2ezNLlIhqDQNHqbbNMrzeU+REiB47pQhB1VCIBj+U3mA9HlUizFtXhQfQJRfoASTZDUiJ31vxLheq8ZQTdxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733920; c=relaxed/simple;
	bh=yNKaDKts2YbApzoLqnclX16Jw7o4uRQy3j6FqOY2JUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTUgls1dF5JeDFrZDAyqK2sau3sr80H8qKQxAdKzdqxo0mvmsd2QGDllA0RslTm7owRCSnVQcW14V8hNgq54QnpLVC1dpAkd/0qBp9JYCi/iqR5Bg/W7UGXIRNRe70n4Lor7II/SW3n5sd1pRhrK4q0IMLcKBZbsuq3NjaXUwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF32D16A3;
	Mon,  1 Sep 2025 06:38:29 -0700 (PDT)
Received: from [10.1.36.60] (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8953F694;
	Mon,  1 Sep 2025 06:38:36 -0700 (PDT)
Message-ID: <29ef4e43-601a-48f3-b14b-a95514df7746@arm.com>
Date: Mon, 1 Sep 2025 14:38:35 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] sched_ext: Harden scx_bpf_cpu_rq()
To: tj@kernel.org, arighi@nvidia.com, void@manifault.com
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com,
 peterz@infradead.org, jake@hillion.co.uk
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-2-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250901132605.2282650-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 14:26, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
> and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
> Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_remote_curr(cpu);
> /* ... Do something with p */
> 
> v4:
> Remove cpu argument from scx_bpf_cpu_rq_locked() as SCX has a unique
> locked_rq_state anyway. (Tejun)
> Expose RCU pointer in scx_bpf_remote_curr() (Peter)
> v3:
> https://lore.kernel.org/lkml/20250805111036.130121-1-christian.loehle@arm.com/
> Don't change scx_bpf_cpu_rq() do not break BPF schedulers without the
> grace period. Just add the deprecation warning and do the hardening in
> the new scx_bpf_cpu_rq_locked(). (Andrea, Tejun, Jake)
> v2:
> https://lore.kernel.org/lkml/20250804112743.711816-1-christian.loehle@arm.com/
> - Open-code bpf_task_acquire() to avoid the forward declaration (Andrea)
> - Rename scx_bpf_task_acquire_remote_curr() to make it more explicit it
> behaves like bpf_task_acquire()
> - Dis
> v1:
> https://lore.kernel.org/lkml/20250801141741.355059-1-christian.loehle@arm.com/
> - scx_bpf_cpu_rq() now errors when a not locked rq is requested. (Andrea)
> - scx_bpf_remote_curr() calls bpf_task_acquire() which BPF user needs to
> release. (Andrea)
> 
> Christian Loehle (3):
>   sched_ext: Introduce scx_bpf_cpu_rq_locked()
>   sched_ext: Introduce scx_bpf_remote_curr()
>   sched_ext: deprecation warn for scx_bpf_cpu_rq()
> 
>  kernel/sched/ext.c                       | 40 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  2 ++
>  2 files changed, 42 insertions(+)
> 
> --
> 2.34.1
> 

Messed up my git-send-mail here :/
Anyway either one of those v5 cover letters is the correct one.
