Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDB48AE17;
	Fri, 14 Aug 2026 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734260; cv=none; b=VXcUemPmk4Vtp52bUHz8+BfQCAdxHI+z5nSx/QKX0Wul5IjDtkWkkv3BopvQxYZQQNQTK2IaDiBWnyJPd9WBewricU8STjd4CJb1gfVnfFok2dAE+YCORjJfG5N1PoXhG4Y3+7ss3eV6FUr5vb2WeD/PSSV+LXUa9WzHJKHawIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734260; c=relaxed/simple;
	bh=GYDu1AuTQbs9LeeILZqkFEPK3XYhZUKEQzSi96n6J10=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=AJhn0RHFd8YsjJyn63C+J9djfsGeSWX6ZXWbfsIoWkHzdgNNtVvSh4eRkN+4149zvJXj+yZNiFhzQwGHLbD297pAW+UU1i5srwoJz8pYCi7sCGiTlyYo0JqKPQ22CZmOg19b3HxS7akh+TJBCIjo43bpfxnqpo6HPvDiNHzmGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQEZjon0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQEZjon0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCCC1F000E9;
	Fri, 14 Aug 2026 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786734259;
	bh=GYDu1AuTQbs9LeeILZqkFEPK3XYhZUKEQzSi96n6J10=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=UQEZjon04vgKOG9r325Nof+0b9y/x0EaZKT+oSJOW1ejouJPIt+lxwqajZRy9Xwxd
	 vo3PJ0hc++FJ0h0jbkaIdyP9UX6rpaksMlX0e/crqKCspjOZBmXbKTIhCJHxwzPdIK
	 ahySuvzD+7Dkgt1SwACPf7UA6cf7sEufFt13GhWlcKX4WzGJa82kieAPow2zky+bNp
	 jlEOzVpuCX3XaJnPyJanY7oFTCEupV8oY59cfMvndNSTSz19UVVBnjhBfEDCsJCJWc
	 iCnM8nzHt1JiOHbRhvNKuHK9/ePis5VWTQxypSKxEb592YEAGnN6Dxk1dRoDU7M4nU
	 XPQujH/4U/RwA==
Date: Fri, 14 Aug 2026 09:04:18 -1000
Message-ID: <71d1c173b538ca29d783232d89464d7a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260811103122.357067-1-cui.tao@linux.dev>
References: <20260811103122.357067-1-cui.tao@linux.dev>
Subject: Re: [PATCH] sched_ext: don't rehome a dead task in
 scx_cgroup_task_migrated
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Aug 11, 2026 at 06:31:22PM +0800, Tao Cui wrote:
> A task can exit between cgroup migration commit and the MIGRATED callback:
> sched_ext_dead() marks it SCX_TASK_DEAD before cgroup_task_dead() removes it
> from the migration list, so scx_cgroup_task_migrated() can pick up a dead
> task and call scx_rehome_task(), which re-enables it and leaks the BPF
> scheduler's per-task resources. The other scx_rehome_task() callers already
> check for this; do the same here.

I don't think this window exists. SCX_TASK_DEAD is set only by
sched_ext_dead() from finish_task_switch(), which a task reaches only
after exit_signals(), and exit_signals() sets PF_EXITING inside
cgroup_threadgroup_change_begin(). The MIGRATED notifiers run inside
cgroup_migrate_execute() with the same rwsem write-held through
cgroup_attach_lock(), so no task in the set can enter the exit path
until the migration is done. Tasks which were already exiting are
filtered out by the PF_EXITING test in cgroup_migrate_add_task().

The DEAD tests you referenced are in scx_task_iter walks which run
without the threadgroup rwsem, where dying tasks can actually show up.

Did you try to reproduce the leak? When code review turns up a
suspected bug, it's a good idea to reproduce it first to verify the
assumptions before writing a fix.

Thanks.

--
tejun
