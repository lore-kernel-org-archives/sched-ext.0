Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D229222578
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771077; cv=none; b=ikkrpalSYPzuGLFoXIyTxG/XYNDFatW6xqc1FkD6KU3pq1XQDvg0/NtwbK6qDr1yOgE+Vmt3h/wZNT8EatxGZ2ASSa7ijuUkzyFiptp05x3w8svzve8zH4aqoxKkcUumwhvlft+LVenJoKDfbme6e3+/mh3o8JHMciFvnOUqq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771077; c=relaxed/simple;
	bh=HsQYB4QSSlp+TbfIv3Csfr32rbRC0IDoiYvvASAgBqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abg6EiRqj8PTvjkdk2rS/ASDKs4ebLnXYVEFymO5ZWu0aLuTC/bLTb9bAztZ3wWLS5ErJFxBfjPM4rQFDd2UUmIG3b/JTD9ib7uFw67QYK+OiRvJERKQ0UtbDT624zFL8syfHG/f05kr8sPGI7E56Aszle7meYTIUciCDoKNdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645E61515;
	Mon,  6 Oct 2025 10:17:46 -0700 (PDT)
Received: from [10.57.5.180] (unknown [10.57.5.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B533F66E;
	Mon,  6 Oct 2025 10:17:52 -0700 (PDT)
Message-ID: <54151879-f2bd-4e87-b5b5-5e916ee1e743@arm.com>
Date: Mon, 6 Oct 2025 18:17:50 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched_ext: Add a selftest for scx_bpf_dsq_peek
To: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev, tj@kernel.org, arighi@nvidia.com,
 newton@meta.com
References: <20251006170403.3584204-1-rrnewton@gmail.com>
 <20251006170403.3584204-3-rrnewton@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251006170403.3584204-3-rrnewton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 18:04, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> Perform the most basic unit test: make sure an empty queue peeks as
> empty, and when we put one element in the queue, make sure peek returns
> that element.
> 
> However, even this simple test is a little complicated by the different
> behavior of scx_bpf_dsq_insert in different calling contexts:
>  - insert is for direct dispatch in enqueue
>  - insert is delayed when called from select_cpu
> 
> In this case we split the insert and the peek that verifies the
> result between enqueue/dispatch. As a second phase, we stress test by
> performing many peeks on an array of user DSQs.
> 
> Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
> empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
> the buffered insert. Unfortunately, this is not viable within the
> enqueue path, as it attempts a voluntary context switch within an RCU
> read-side critical section.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> ---
>  kernel/sched/ext.c                            |   2 +
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
>  4 files changed, 498 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d3537e65001..ec7e791cd4c8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6120,6 +6120,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
>  	sch = rcu_dereference(scx_root);
>  	if (unlikely(!sch))
>  		return NULL;
> +

Accidental whitespace

>  	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
>  		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
>  		return NULL;
> @@ -6130,6 +6131,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
>  		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
>  		return NULL;
>  	}
> +

Accidental whitespace

>  	return rcu_dereference(dsq->first_task);
>  }
>  [snip]
