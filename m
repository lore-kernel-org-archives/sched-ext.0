Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBA18C933;
	Sun, 16 Aug 2026 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846433; cv=none; b=jJhR8NDrmtZ+DCPuspsM7HSp7cePeK3etRcl/BQ6rQ7APUzNY5Qa6JyElChQEAnhkQ1EP11I8eCGRxQjeMV0WFy1825t1pYjsXm9AeczdWSeGohDWGBhTTWiwvLdkSAZ/YG+kK780lCjLXI2S+P+jJCPq16MVW+UA+s0uRYkef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846433; c=relaxed/simple;
	bh=yxglBjCa7WnowXVY6OqpgwBpdMGdbfJHJehkMkSb9RI=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=edpySZ0rzTl0Q1jS1s4ZkbaxpneWdcGVHR5xxDWzlDJKTJEGp/zXPJVinKiBP7Kj6UWsCK+csDnDo6ErA3qb9rFE/BFrk9rl8QQxbNwoc3xy98fNaFD1hTjOxMWRnDP7+7Ek703L/PIrN1e6utNT17mm1ACaoHDtMTSFgGs7254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJI4IaOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJI4IaOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90661F000E9;
	Sun, 16 Aug 2026 02:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786846432;
	bh=qaof8s9XbpCF42eChy9bu4KX69bMUAVkEJNWI5c/S5I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZJI4IaOPy1armGEcZBetv9rQg7Dcp6g61ww9QcqKOYQu6fk4juTki6tZQu5B/gJNn
	 4xDAfvr20F4eZPIr9T5UeET7FYvNZm3XgJWMsazfODDjiFjx1U97Y4+yZya0NAJl5h
	 OHNsDE4Vg1wxzHRGSwxcARhN8Wr20hJ55O6MbDQCq0edgSQ8AlEnP6SuSdIYyx+oJx
	 723M/LgBRbzaqRFzujFG84KPVIgaDtxD8Y+U1DoVaFfcX+xRXALh7Jzz88pSpjrnbJ
	 /TgtpZC1uFs2mG/HwJCWOZhy9dwpOdvN61zonm1HYQ4Rwu9/Pn2+XxKQxqfz3Nck/a
	 /28PegRFr5tWA==
Date: Sat, 15 Aug 2026 16:13:51 -1000
Message-ID: <329d3d9a741d415ada204c51c3b73b12@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260816000527.988170-1-tj@kernel.org>
References: <20260816000527.988170-1-tj@kernel.org>
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Update core-sched task ordering for scheduler hierarchies
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (4):
>   sched_ext: Fix inverted ops.core_sched_before() invocation
>   sched_ext: Use runnable_at for the default core-sched task ordering
>   sched_ext: Make core-sched task ordering hierarchy-aware
>   sched_ext: Drop the dead SCX_DEQ_CORE_SCHED_EXEC test in dequeue_task_scx()

Applied 1-4 to sched_ext/for-7.3. The patches are going in really
quickly. They are plugging obvious holes in sub-scheduler support and
I'd like to make it more or less complete before the merge window opens.
The blast radius is also pretty limited. If there are any review points,
I'll address them with followup patches.

Thanks.

--
tejun
