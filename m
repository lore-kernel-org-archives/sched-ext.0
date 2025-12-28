Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C32D6E70;
	Sun, 28 Dec 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766964488; cv=none; b=iSw9glUrETyGNiQxzMKwYDQGqlbf80UEQsArRVpSmBMdDsKZ3/Ba7N3GpEnH7aJuqb9HWiS70QVN9rg0XWH+3kaiGQt5IXZj7Sy0YJWuIt9CmW8ct741FBne7t+sFtst6vTpmW8mDYKsH81MZ2baiRgj9+1Qwt4UhsE4hnyilqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766964488; c=relaxed/simple;
	bh=z+/xhIX6R8wOzAZqKm6qXO1cwVh2xP4SS+YRaO9NKw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCBuMhZrko1IwtkW6BNiIg9X98XwLm1D1Myq1rxJaYNqXsPYGobcYAEGVSLfd/S3TmnUktxpmDEXwwleqEVILO9LaCeorE7MMwqxfXhKadY1z1En9UxKzL2FIshMg15v51KOVm/XKHee5dhGysCcuupAGFIosPzmKFMO/QHQMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg1UgC6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg1UgC6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B332EC4CEFB;
	Sun, 28 Dec 2025 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766964485;
	bh=z+/xhIX6R8wOzAZqKm6qXO1cwVh2xP4SS+YRaO9NKw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tg1UgC6BuZU+Ggg6Ok9Y9DS95z5TWKPDwYKIZqE/LUE7Z5RyLOhXqKDM4khamxfMw
	 f8Vj9zKn5qbMmL9bGdKdmx02z6GqlUVcFjVzsakQ2saNunGl3m8n0zusuvcLWOM2tm
	 IsweV8KO55od+MKKZT+/1r/EFAnmyNlva65ogHodOUGPSYEYUGncBElI7oZma7Yile
	 45KPUZY1kaUihOpz+ruL7uaK/LMSptszbs38Fo5NdEF8iAFf1etTL/xLdt+nILrpVO
	 xIqvjhZ2l8jGRGX/LcchsMWdTDp6lY3JoOtvszeOu65oyZhqfX3bxR06EVQDgrFRjv
	 9FFkVzu8HC6gw==
Date: Sun, 28 Dec 2025 13:28:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVG9BBWIQLL8uJrQ@slm.duckdns.org>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVFmstVjLW_QIQis@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVFmstVjLW_QIQis@slm.duckdns.org>

Hello,

On Sun, Dec 28, 2025 at 07:19:46AM -1000, Tejun Heo wrote:
> While this works, from the BPF sched's POV, there's no way to tell whether
> an ops.dequeue() call is from the task being actually dequeued or the
> follow-up to the dispatch operation it just did. This won't make much
> difference if ops.dequeue() is just used for accounting purposes, but, a
> scheduler which uses an arena data structure for queueing would likely need
> to perform extra tests to tell whether the task needs to be dequeued from
> the arena side. I *think* hot path (ops.dequeue() following the task's
> dispatch) can be a simple lockless test, so this may be okay, but from API
> POV, it can probably be better.
> 
> The counter interlocking point is scx_bpf_dsq_insert(). If we can
> synchronize scx_bpf_dsq_insert() and dequeue so that ops.dequeue() is not
> called for a successfully inserted task, I think the semantics would be
> neater - an enqueued task is either dispatched or dequeued. Due to the async
> dispatch operation, this likely is difficult to do without adding extra sync
> operations in scx_bpf_dsq_insert(). However, I *think* we may be able to get
> rid of dspc and async inserting if we call ops.dispatch() w/ rq lock
> dropped. That may make the whole dispatch path simpler and the behavior
> neater too. What do you think?

I sat down and went through the code to see whether I was actually making
sense, and I wasn't:

The async dispatch buffering is necessary to avoid lock inversion between rq
lock and whatever locks the BPF scheduler might be using internally. This is
necessary because enqueue path runs with rq lock held. Thus, any lock that
BPF sched uses in tne enqueue path has to nest inside rq lock.

In dispatch, scx_bpf_dsq_insert() is likely to be called with the same BPF
sched side lock held. If we try to do rq lock dancing synchronously, we can
end up trying to grab rq lock while holding BPF side lock leading to
deadlock.

Kernel side has no control over BPF side locking, so the asynchronous
operation is there to side-step the issue. I don't see a good way to make
this synchronous.

So, please ignore that part. That's non-sense. I still wonder whether we can
create some interlocking between scx_bpf_dsq_insert() and ops.dequeue()
without making hot path slower. I'll think more about it.

Thanks.

-- 
tejun
