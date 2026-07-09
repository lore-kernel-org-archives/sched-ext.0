Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA603E1689;
	Thu,  9 Jul 2026 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636129; cv=none; b=XB1fdbiMZxjzSBYySxgcfGvwbDR8k7e+6G0VyO1hGXGQF4Fr+sdI2Ly2IVBg9mJjt07QzCoPjrVeckfOrQ9H7L2kXgehH2P3xBJHPHLGstEZR0fxi43rJZmSiFFpJlkGX84NBcnIiXUee3E9LQN8ynPZRMlPJxMyTcpJpbyfbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636129; c=relaxed/simple;
	bh=GmVnDyZRyNiG5BNVHOy8vuItXOwxP8tkfp4OIXISzpw=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=SFNn80kHGWlUydFVIMcI6JZ3N2hSUmfNb++iv6brW6LnoHFUuaSMsVNdVr/451cZXQNANjL9j7CEhb5OyW/LerK6CiY0TowSIahuwh0AmwOM5tHVItS5RPf3WaUSqaYNxRNPn2gHEbeeEz7372oYTqr5iLgjPHIjjm7AzmM+fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7WEQIFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7WEQIFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F74B1F000E9;
	Thu,  9 Jul 2026 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636126;
	bh=KjlmM+XM+NhtFsGUwUi/hWR+WI2EYgF+F8XLBAi9rns=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U7WEQIFPA+dheeNEs9jlXsEK8Wt+L++mIem/f580uHw1bLVoHDNs8OafoPrEDrnnW
	 CqvQhBujPMn9ArKpAzijedXYKyx//eu83VdnTow18fugjzNKzuSTpXk3KQf4Z6QStF
	 JZkJwmLOkoQzG+tExgPW0salCODMd2q0gBWnAqmBzOIWOwr0cVPqMJ7E6BWkZ4znz0
	 zB0mq163ru2ZcXXgJF5rpSe5cUvsMO8NWhqSHz97o8q0WUVg79/UDCTbUqQDISe2eX
	 c8KCHXdwEUmWH9UTaofsJ+DTgspc6PaYJh790d0V/ktnpF8+1/lwHQULoU6NF0ISyo
	 w05BncIA4UAKw==
Date: Thu, 09 Jul 2026 12:28:45 -1000
Message-ID: <c75768cd2c76f07fe6f822a2f1350c2b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220444.DDA121F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-35-tj@kernel.org> <20260708220444.DDA121F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 34/40] sched_ext: Authorize remote-move inserts against the placing scheduler
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:04:44 +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does passing the placing scheduler
> during local moves cause issues with ops.dequeue?

The combination can't materialize: call_task_dequeue() no-ops unless
SCX_TASK_IN_CUSTODY is set, custody is only entered for tasks placed on a
user DSQ after an scx_task_on_sched() ownership check, and the one path
where placer != owner (remote bypass drain) runs with custody already
clear. That said, v5 adds a WARN_ON_ONCE to the per-task op macros
asserting @sch is the task's owner, with the two intentional non-owner
sites dispatching explicitly, so any future conflation surfaces instead
of hiding.

> If the placer passes invalid enq_flags or an invalid DSQ ID to a
> built-in DSQ, scx_dispatch_enqueue() triggers scx_error(sch, "cannot use
> vtime..."). For remote moves, sch here is the owner.

A remote re-activation always inserts into the local (or reject) DSQ, so
the builtin-DSQ error branches aren't reachable from a placer move - they
fire on a scheduler's own dispatches.

> should the error attribution (and events like SCX_EV_SUB_FORCED_ADMIT)
> use asch instead of sch so the descendant scheduler isn't unfairly
> aborted when an ancestor lacks capabilities?

scx_local_or_reject_dsq() records no error and aborts nothing - the
missing-caps branch either force-admits or diverts to the reject DSQ. The
only owner-vs-placer @sch use is the FORCED_ADMIT event counter, which is
cosmetic. May sync it to @asch later.

Thanks.

-- 
tejun
