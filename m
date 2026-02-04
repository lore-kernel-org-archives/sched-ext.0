Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332B4279EE
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217672; cv=none; b=jjiODcGBZVmgUET/R3fhCfBu+jxEy3giMCT1iHbseP+8nApZt8UxMwztY7nRhVonSj9Gc/0JnEkQsUIw4u5/VubhFz+kGL3QO5YHZ6OLssHIyLi2p54ob+szn0+fq1Dnr0UxD0P9HeKESKTufFnH1y5nNG2ADSL6FU3ef2cEUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217672; c=relaxed/simple;
	bh=B/bcAqUbyYgDs/Qe8gVdEkUbA0r9T8e6NuLdMhdB5qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9bGPcVn/Y6vaXUwt5ZFAlhmA+hnh9w63gCw10ytARRKjT3TAJjQPT/dKaZ+pG6fgnZhnnsGm9+7og4evBN4BmO9JDGopmkZa+Ax72VsRynx+BtRMy+1NjmFs/kuN982WcfmP2LlL9XrkAES5Sq4OZ0/kMWPzx9u+NBZDCPxDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA915339;
	Wed,  4 Feb 2026 07:07:44 -0800 (PST)
Received: from [10.1.30.86] (e127648.arm.com [10.1.30.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7274F3F778;
	Wed,  4 Feb 2026 07:07:49 -0800 (PST)
Message-ID: <b328f5e7-2abd-46a1-bc34-8e2e906b4d0d@arm.com>
Date: Wed, 4 Feb 2026 15:07:47 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260203230639.1259869-1-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260203230639.1259869-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 23:06, Andrea Righi wrote:
> A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
> target CPU. However, task affinity can change between the dispatch
> decision and its finalization in finish_dispatch(). When this happens,
> the scheduler may attempt to dispatch a task to a CPU that is no longer
> allowed, resulting in fatal errors such as:
> 
>  EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])
> 
> This race exists because ops.dispatch() runs without holding the task's
> run queue lock, allowing a concurrent set_cpus_allowed() to update
> p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
> then finalized using stale affinity information.
> 
> Example timeline:
> 
>   CPU0                                      CPU1
>   ----                                      ----
>                                             task_rq_lock(p)
>   if (cpumask_test_cpu(cpu, p->cpus_ptr))
>                                             set_cpus_allowed_scx(p, new_mask)
>                                             task_rq_unlock(p)
>       scx_bpf_dsq_insert(p,
>               SCX_DSQ_LOCAL_ON | cpu, 0)
> 
> Fix this by extending the existing qseq invalidation mechanism to also
> cover CPU affinity changes, in addition to task dequeues/re-enqueues,
> occurring between dispatch decision and finalization.
> 
> When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> re-dispatched using up-to-date affinity information.
> 
Hi Andrea,
so this fixes the default scx_storm insert / dequeue race indeed, let me go
review in-depth and create some more tests...
