Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394336A359
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543722; cv=none; b=rLK7rMcs/K4vxBFySLmySMbpXmoPdBWJvz0ZDER3T2M9JMwyWMcq4IqHfQkb+8AbLKjwSo1WOUEhHP7qTE/VgvQsz1QbG9npqCSS94NFSui/AUhP2LaRL7IuUbhUh0IlTKj8zBJE2gdn07j1nJb0Yld8dOj5+wwVrdOrvRmxA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543722; c=relaxed/simple;
	bh=Ri7aBqovBDa+AJSFQ4scuCSecfIi8HVbIQGqRqLKQTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgQl9behwHoxsYITGOzM3fEkjf15UBeI53/Cn4gF53cH2sRU55H/ULqe9sTdWm8W8R+PTDVyOjR0Si5k1jSKZlPqU0Km7pJPgVlgNgxQgzTiR3cCFwU6aozNtodViFk6r6MmyXEkbAkvRmawZiyxyRSf9tuUyFLLesJhUeWyTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfmtWr+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfmtWr+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B19C2BCB0;
	Mon, 11 May 2026 23:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778543722;
	bh=Ri7aBqovBDa+AJSFQ4scuCSecfIi8HVbIQGqRqLKQTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YfmtWr+DRo851xHPNm9gusv3BLlkehiFpISuhGc+fMBQI0qG3spaVbr4oXHuP+BYq
	 osP1VfQb7gZfSUbZ1hn2S04+I+6ACZFyzWHBrPNoeOziUZvaLHOrCjlb4t7z+kgnPH
	 3RORLEWRWQvIZhLWefD4LmSAsnFJUfRKu9PaPT9UhAHL7lpBzs+RHhnXIY7aEd0Fax
	 +CrcbaLhUm+Nx0XM4IrUzJzuSQhTwfm54sJRYl+bzDc7LRYIwJ4ydPaeyfNjq+VKv+
	 txEhDBGYohVZ6DW0ydqzAma2QLQzST0mBH3sq8EdqRq5T7gQ7ZeE9fGGrU9s3sENgq
	 TCJ9JGotuITsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] sched_ext: Handle SCX_TASK_NONE in
 disable/switched_from paths
Reply-To: sashiko@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260510074113.2049514-7-tj@kernel.org>
References: <20260510074113.2049514-7-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 23:55:21 +0000
Message-Id: <20260511235521.D8B19C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The newly added early return in `scx_disable_and_exit_task()` =
skips clearing the `p->scx.sched` pointer for tasks in the `SCX_TASK_NONE` =
state, creating a deterministic Use-After-Free (UAF) vulnerability.
--

commit edcdc86f04b3e413339b79eef811a59560178144
Author: Tejun Heo <tj@kernel.org>

sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths

This commit adds early returns for tasks in the SCX_TASK_NONE state
during scx_disable_and_exit_task() and switched_from_scx(). It prevents
writing state=3DREADY on already detached tasks and clobbering the parent
scheduler left by scx_fail_parent().

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 08e7dad437b32..eba25eb4e0543 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3704,6 +3704,15 @@ static void scx_sub_init_cancel_task(struct scx_sc=
hed *sch, struct task_struct *
>  static void scx_disable_and_exit_task(struct scx_sched *sch,
>  				      struct task_struct *p)
>  {
> +	/*
> +	 * %NONE means @p is already detached at the SCX level (e.g. handed
> +	 * back to the parent by scx_fail_parent() with no init to undo).
> +	 * Skip to avoid clobbering scx_task_sched() and writing %NONE again
> +	 * on a state that's already %NONE.
> +	 */
> +	if (scx_get_task_state(p) =3D=3D SCX_TASK_NONE)
> +		return;
> +

Does this early return leave a dangling pointer in p->scx.sched?

When scx_fail_parent() hands a task back to the parent scheduler, it
transitions the task to SCX_TASK_NONE and sets p->scx.sched =3D parent.

If the parent scheduler is subsequently torn down, it iterates over all
tasks to detach them. Because the state is SCX_TASK_NONE, this early return
bypasses the trailing scx_set_task_sched(p, NULL) cleanup step at the end of
this function.

The task is migrated back to CFS but retains a dangling p->scx.sched
pointer to the freed parent scheduler. If /proc/self/sched is read
afterward, print_scx_info() retrieves this pointer via
scx_task_sched_rcu(p) and dereferences it to print sch->ops.name, causing a
use-after-free read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510074113.2049=
514-1-tj@kernel.org?part=3D6
