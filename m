Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215294;
	b=t7XRPWTmemJNLkIboCy4ZZ0y9bPIq4P0VOKEwEmAYu4wGcW5sqAynHMs5DFsK+LfIJFP
	 7D0cZDgjfSncdNt+j5Y783a9/TaaiIVk27aLYF5UBcPZjsOT7sh3zFmKwXqcIM/8hwCqu
	 0GYfHb4Ic7wxKTXL3CzCm4l2zDNYkjU7fl/GOj09AG3Zz3fw1uUnz+VFfToUJM1XCH482
	 lUHvfTD8Dl2C8jVBrHWUzET1qL8gGRtrWyn+e8bGIS5l/YLFOkx+Nk4O2Z/XRGXl4n4Oj
	 DGgGme7qbtSfFTkhdgftY6FS4rsdWOwYNDRwsjk2X9Kt7LWMqyc1TOsPXp57gZ3t4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215294;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=3bvvTJnPZabqaDZdBJTshH2tst9rQFUl49juPIv2dIs=;
	b=nXw6xK6U815DQZNHZgwD+bFP8maQTU+ZPyNNapPlMRxcjTBl958/Rv/B8jBa66i9zKSy
	 inN3P8oeFVBrlkyUTG+c3M5gQzzby8YSjYSqn1M0iNU6sBRvewRlhEHlpbzddxtnvKYrS
	 0/84n5L6/6eh5f+4+urT1cIks9LD/2Ukr0UjaoIJ7ztw/1SESFd6HdbntHC6nqabq3Ilh
	 Zv2IqWTzXli0aNATteyqV1BQMzQyN48IgAsf4156bf4LsCbdpeQ2LdO7S5T+SDcxskHaW
	 VeWzzTDsZi7LovpBZoUtSL4IF0aV/DxWlHEu3jvvRNCddwah+RfeBPtaOYlYB0uJwTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLS7O7kk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D9606A31D;
	Wed, 28 Oct 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLS7O7kk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC41F01828;
	Wed, 28 Oct 2026 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793215293;
	bh=3bvvTJnPZabqaDZdBJTshH2tst9rQFUl49juPIv2dIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LLS7O7kk0d1qKu2VhrOtw3q+9UhHBxY1qKjVj6Mg3VywpOiIL2DOM/2s8Fl+irNn5
	 kOcLXP9guBiTb6tI4q57+cXIldHN8hZY9N8iQaz6LePBVNA945M5WVxh2rmVUzq8ZX
	 G6Am/wQOx9YPDgQX4VNvLMuuUU8/80YCsZ1id2xSdEDA5YsmN1I9cQ8Kv97GH4XRE1
	 r1pSeLGHb57brcaRIKrg63V0iA6api1ld0k/onWC92gjEYbIi9h237/3bMS/vXLgWp
	 jb4Fhh/UPennGdiWdZWjkogxu6S1JLHHNB+TaJh4S3eMFp0M3rcMCYK85Y4Ezq2SAO
	 nB+u/uYpeZQYQ==
Date: Wed, 28 Oct 2026 09:21:32 -1000
Message-ID: <019648c2b11a3aa6a9b14723df813d65@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Avoid unnecessary IMMED reenqueues on idle CPUs
In-Reply-To: <20261028165258.3723153-1-arighi@nvidia.com>
References: <20261028165258.3723153-1-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Andrea.

On Wed, Oct 28, 2026 at 05:52:58PM +0100, Andrea Righi wrote:
> +	/*
> +	 * A local insertion can raise next_class to ext while the donor is
> +	 * still idle, including after proxy_resched_idle(). The local DSQ head
> +	 * is next to run if its cookie matches, so keep it through IMMED reenq.
> +	 */
> +	if (rq->donor == rq->idle) {
> +		struct task_struct *first = first_local_task(rq);
> +
> +		if (first && sched_cpu_cookie_match(rq, first))
> +			return true;
> +	}

Can you leave the core-sched cookie check out of this patch? IMMED
doesn't handle core scheduling correctly in other places either, e.g.
when core scheduling forces a CPU idle, nothing reenqueues the IMMED
tasks left on its local DSQ. Core sched should be addressed in its own
patch.

Also, the check as written doesn't work on an idle core.
sched_cpu_cookie_match() compares the task's cookie against
rq->core->core_cookie, which the core-wide pick sets from the
max-priority pick, so it's 0 when the whole core is idle. A task with a
cookie that wakes on an idle core fails the check and still gets
reenqueued even though the next core-wide pick would run it.

> -		if (p->migration_pending)
> +		if (p->migration_pending) {
> +			reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
>  			continue;
> +		}
>
> -		if (!scx_is_descendant(task_sch, sch))
> +		if (!scx_is_descendant(task_sch, sch)) {
> +			reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
>  			continue;
> +		}

Can you split this out into a separate patch? Skipped tasks not taking
the first position is a gap that has existed since the IMMED
implementation and is independent of the rq_is_open() change.

Thanks.

--
tejun
