Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1234582FD;
	Wed, 22 Jul 2026 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763367; cv=none; b=C/iWrTQ+elcFn4jWHV+Zc94bU8GHDRBZFgTmII3RuBWgXLzwgv+SK9xxHuLQ06Q0UWBKXe5h0qkCR9e70T6Zg0DtXt2ogDRKF+BEkg0PC2jstqGJUyKLsoGnxOeN0e1vYWY4+fXi7oTL7mkDSRWm0qj+z4oqthSMBWEtiYSUnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763367; c=relaxed/simple;
	bh=IfWkqpeBfLBAuv9N/WhfKP/zkHXbOKcMJBQm3autBDA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=se4ta0OUWzwCU9Luc8LM7IucuuM+fo0RIdenz2E4sQvLEs0c1oJYg5piAQzWc2OnbmJa1mpK3nwujonpBe85+kZFhvGUTLYTAh+ZM4cUaBBx2vACFhIB28yPjpZ2zF+k2nahVe7TCZsd2WTXbxqInpSngDPy1XdXWyMxT+U3K9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwQjG/0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwQjG/0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0378D1F00A3F;
	Wed, 22 Jul 2026 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763366;
	bh=swFuh1PPk6kgwBS+ydO+DRiGQfnSWFxZZ/hCz10i32E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OwQjG/0z+qooG3ikw63aVQjoLA2JFUOlIHlzBv6Db8hgYaegL/Qw2JwxrbIV+JUTF
	 I0bupjtRiTVWGWREpIPG7D7GNfN3k2p/dF9X9e81r8ZT8wo5dhmcA7gX1I1ndoy+73
	 uNZhDVMsEQUfrD/kerynB8wPEa97Jsvrywg1gB49TAbE+UqAn7o5m86+o+Ra1LBePI
	 m8ypgGmqtJdneICBD6qY/MImdq+MeNFq4L8hpz7yH9mRINmjKRUgwRHOB6kAp7ISFi
	 lUlF5SwSLH0dH/oW6XCE/2666//dc8QBMdM8Lihp6ZTQX1IjoS5rjMDGajuWktUAfi
	 HH5xDfUqiGd6A==
Message-ID: <682151bebb5125c1f6ee0eac7b931096@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Wed, 22 Jul 2026 13:26:03 -1000
In-Reply-To: <20260721063242.552774-10-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-10-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 21, 2026 at 08:31:30AM +0200, Andrea Righi wrote:
> A proxy migration preserves the donor's wake_cpu while moving its
> scheduling context to the owner's rq, so task_cpu() differs from wake_cpu
> until the donor wakes. Prevent BPF-directed migrations from pulling a
> blocked donor off this proxy rq. Otherwise each blocked re-enqueue may
> move the donor back to its callback rq only for proxy execution to move
> it to the owner again.

The description reads scattered - from here on, it's a flat list of corner
cases, one per hunk, and the design that connects them never gets stated.

> +	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
> +	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
> +		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
> +	if (enq_blocked)
> +		enq_flags |= SCX_ENQ_BLOCKED;
> +
>  	/* see %SCX_OPS_ENQ_EXITING */
> -	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
> +	if (!enq_blocked && !(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
>  	    unlikely(p->flags & PF_EXITING)) {
>  		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
>  		goto local;
>  	}
>
>  	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
> -	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
> +	if (!enq_blocked &&
> +	    !(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
>  	    is_migration_disabled(p)) {
>  		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
>  		goto local;
>  	}

Both fallbacks repeating !enq_blocked reads awkward. How about grouping
them?

	if (enq_blocked) {
		enq_flags |= SCX_ENQ_BLOCKED;
	} else {
		/* see %SCX_OPS_ENQ_EXITING */
		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
		    unlikely(p->flags & PF_EXITING)) {
			...
		}

		/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
		if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
		    is_migration_disabled(p)) {
			...
		}
	}

The "takes precedence" comment can then go away as the structure says it.

Thanks.

-- 
tejun
