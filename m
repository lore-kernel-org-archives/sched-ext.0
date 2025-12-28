Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD513A3ED;
	Sun, 28 Dec 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942387; cv=none; b=o5ZQShnYfdOn8Ej+Yy7PjhZHgCW4Yz3DxwMC3FpNC/oypvUB+OfB+32V3yMwTr986uV3n6FHsOAMXh6Vc8l5AJbez6oRweLPWxnM75HXnsS/rv5+mBhUlElNbp8lqY9Kx7y6KdMtfBBlvPZ4CQ9OONlwZU3h5xR49N+fWZjzleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942387; c=relaxed/simple;
	bh=AzX5MBJWEsNW7mEi4pcTX20zLlmiLQUvYLq/P01Hol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP0ifUDAvw1XlqZB0YnBT5I9b7UrIWk48KQBz053Zx7anzoczOukc2dDu5SVHFEF70klIa3Uf3SUVj0eNPIyBrP36QIgvoWsdyFE0+ZXYLIAKytFCF1N/4+GVYOXA59q8/V9ccozta8OF4ErTHBEiS9asKSdDVVdq0fFw5kciME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXCEHzbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXCEHzbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBEDC4CEFB;
	Sun, 28 Dec 2025 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766942387;
	bh=AzX5MBJWEsNW7mEi4pcTX20zLlmiLQUvYLq/P01Hol8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXCEHzbGZQ63kbNROIQM0ENRclT9Z9f0pBevoq65jCD1aHQyOAubGkIRjktS5L91l
	 VVXW8rnR8j3mPgZUaSLFiWjYSFxdAWYPuT8KlZ0azjMaDkRHWe/mBDwbxMPXAbb/l/
	 BL7TqJ2T4tAtJaAWHOpfmvSd+q1TUnthk2RRmo3VXNDTBJBh7wG/J22WN+pjPnw6py
	 a9Wd9tIFrL2n7OnVQGu6DB5CHLuxJ4C5bxg8fyJQhvzm+0hVUrudSBa3BrVZe4TBzm
	 G1p8Uso4L72n1XeaYCzzfzZtDSQ13cVwJaHjE4JUuKxhmeoUU9bZL5zAIhGKyvn6+W
	 tUJN3WzAHHtQw==
Date: Sun, 28 Dec 2025 07:19:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVFmstVjLW_QIQis@slm.duckdns.org>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219224450.2537941-2-arighi@nvidia.com>

Hello, Andrea.

On Fri, Dec 19, 2025 at 11:43:14PM +0100, Andrea Righi wrote:
...
> +   Once ``ops.enqueue()`` is called, the task is considered "enqueued" and
> +   is owned by the BPF scheduler. Ownership is retained until the task is
> +   either dispatched (moved to a local DSQ for execution) or dequeued
> +   (removed from the scheduler due to a blocking event, or to modify a
> +   property, like CPU affinity, priority, etc.). When the task leaves the
> +   BPF scheduler ``ops.dequeue()`` is invoked.
> +
> +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> +   regardless of whether the task is still on a BPF data structure, or it
> +   is already dispatched to a DSQ (global, local, or user DSQ)
> +
> +   This guarantees that every ``ops.enqueue()`` will eventually be followed
> +   by a ``ops.dequeue()``. This makes it reliable for BPF schedulers to
> +   track task ownership and maintain accurate accounting, such as per-DSQ
> +   queued runtime sums.

While this works, from the BPF sched's POV, there's no way to tell whether
an ops.dequeue() call is from the task being actually dequeued or the
follow-up to the dispatch operation it just did. This won't make much
difference if ops.dequeue() is just used for accounting purposes, but, a
scheduler which uses an arena data structure for queueing would likely need
to perform extra tests to tell whether the task needs to be dequeued from
the arena side. I *think* hot path (ops.dequeue() following the task's
dispatch) can be a simple lockless test, so this may be okay, but from API
POV, it can probably be better.

The counter interlocking point is scx_bpf_dsq_insert(). If we can
synchronize scx_bpf_dsq_insert() and dequeue so that ops.dequeue() is not
called for a successfully inserted task, I think the semantics would be
neater - an enqueued task is either dispatched or dequeued. Due to the async
dispatch operation, this likely is difficult to do without adding extra sync
operations in scx_bpf_dsq_insert(). However, I *think* we may be able to get
rid of dspc and async inserting if we call ops.dispatch() w/ rq lock
dropped. That may make the whole dispatch path simpler and the behavior
neater too. What do you think?

Thanks.

-- 
tejun
