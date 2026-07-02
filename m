Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7623A6B82;
	Thu,  2 Jul 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016494; cv=none; b=tzUnZwKwc3qxaRue6yt7HdhmHoviyEDecL3eNCs6p2XVSK0DKraJXO3benmW+Mogd2kHTx3gw5eaz9ZiwA/tKYFjIZFZNDJmsTJB3s3LZ+CWzLvBc8c6k6lJcWarwiFkXC5f/Uo4V6t+QDlJTKr/GIqJbW6c/qHk6e3JabPW0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016494; c=relaxed/simple;
	bh=R50w4ONzLnXl1VM24e0p8F33RGkMwGvCywnD9mgSBVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQGiYyf6jvUvkQYMlIPbbz+riykYe0RXMiG4SwVl24m+BBPDYWk4FhxjQhS6MMW3Z98cveT2OXvR0nEUCtv9wvrPbo6mUjYy9ykz71ArX3cXR6ivFeMrq6M993p8u8JzmQkVx+Pr1yViLuKM673NU5W7lOKFcmEQi7ZgaN7oPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cdvl3ofA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdvl3ofA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NSx9fj5OgJi8DoIMB8ArnocORh675jvqV7/5UpsqU30=; b=cdvl3ofA5lUf1bgEhyWK4logX1
	HCbhxWxId80aiVxpHZ5Ir4GqH80dNGy0Rb1npJ8zGYeD+ZMn+EX2g9hk62H8KZNcVQ8RMxhyqwaFD
	M/chr8gv+vjJGUW7BVgDHNKgkLMRbZPbd5m9kYDRQ0Y7piSPlnrq5XZWzy01XgMug7UadHPdO0V4X
	nqolOP7LZy3h/Xa9G9Y20QQ8oNjuq5XsXdTSF4vUyCaMc9Xh6kJMW9Zn86m+yRHOFAQ7N0rfRlrz5
	CBmsqkAK29toKB4Y1rlT7ABXrfgGkkIRsnUbBOnyEGsVVl/aumFesovXKq4zeIkM1Jt6Loow/4deD
	/HYXd5MQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wfM2K-000000048UE-0xmZ;
	Thu, 02 Jul 2026 18:21:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67C5C300220; Thu, 02 Jul 2026 20:21:18 +0200 (CEST)
Date: Thu, 2 Jul 2026 20:21:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] sched/core: Skip migration disabled tasks in proxy
 execution
Message-ID: <20260702182118.GL751831@noisy.programming.kicks-ass.net>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702171909.1994478-2-arighi@nvidia.com>

On Thu, Jul 02, 2026 at 07:09:17PM +0200, Andrea Righi wrote:
> Never attempt to migrate migration-disabled tasks or tasks that can only
> run on a single CPU when switching donor's execution context, preventing
> task pinning violations.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3cc6fb1d20547..8a3eecc7caf5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6936,6 +6936,20 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  			 */
>  			if (curr_in_chain)
>  				return proxy_resched_idle(rq);
> +			/*
> +			 * Tasks pinned to a single CPU (per-CPU kthreads via
> +			 * kthread_bind(), tasks under migrate_disable()) cannot
> +			 * be moved to @owner_cpu. proxy_migrate_task() uses
> +			 * __set_task_cpu() which would silently violate the
> +			 * pinning and leave the task to run on a CPU outside
> +			 * its cpus_ptr once it is unblocked. Deactivate it on
> +			 * this CPU; the owner running elsewhere will wake @p
> +			 * back up when the mutex becomes available.
> +			 */

No, this is actually OK. Remember, we only migrate the scheduling
context, but the task as such won't ever execute on the remote CPU.
