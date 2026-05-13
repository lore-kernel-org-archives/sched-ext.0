Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBD309EEC
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644822; cv=none; b=jJ0XwkXh8DkDCTs/qXS1MOEj8Wj8dHbTWQRm1nqhGpxjFJyW7x/DKvilQZ4clvD8xJnyURRl1g1QClyATKnhSlxxT3dVNsRZZ0Yt5s/3T7ct1icDzGA+55VZfpBMwDe5GHZ+Xrexl0JKpklLD8mKnx/kIBwME1482oYzXKX6tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644822; c=relaxed/simple;
	bh=LLcMw4uYJMZkC/1BDqu2FCNNT9kO4p+UVqII1vFsvI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xs0HJea6jqzeiHryYp3FCk1UhwwxOh7ADwZru0Iz0mCtIdf8yrkCTXcIGoeZm6oKbnWBhERHvpQ705g1lvDOPU4meJEMCyIS5FUmbh1QT2g1gxCRvq+ullqjMjx5fg9F7C6ZN5GTJDGsZnvlgnT+7RPM2RT2QhdgxG+ipSk5f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1p3mb0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1p3mb0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35121C2BCC7;
	Wed, 13 May 2026 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644822;
	bh=LLcMw4uYJMZkC/1BDqu2FCNNT9kO4p+UVqII1vFsvI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X1p3mb0ipuuMmjXyTN79KTN/8+nOrrFrvHTMjxmgJpILt/Y1M8ARoRoh4fEN5KBPK
	 M2KKEGTQvGVUIfXpWZEWB5cI7M+EfeyMA2HaYpx/BLWUWzbYxg4tjxx8sw35fD8zRK
	 qcEd8m6Ah9tRHXKJEany40hQzZkO0A4/qVnQxiq5yvx9YNZOn5aYDAUQlnEZajiYk+
	 HpGIyvPA+KHAJeLIUbIj0O2fA33Pjziv/vy62jG7p9oOjKfbgv6SgXosHujKmE6ggW
	 v9RfGtRRTGHcjTZFqpwENC8p/u5qqSh/fnffYObCyyKT+lRnJZZFTJTnrXNrmeFreT
	 Fg67zXpUo2IEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer sub_kset base
 put to scx_sched_free_rcu_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <2f2b7481ef217ad89c5d90fd56fc0c01@kernel.org>
References: <2f2b7481ef217ad89c5d90fd56fc0c01@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:00:21 +0000
Message-Id: <20260513040022.35121C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Relying on sysfs_create_dir() failure triggers a user-triggerabl=
e kernel log spam (pr_err).
- [Medium] Inconsistent error handling paths for the same race condition.
--

commit e9f250877d2f7deea4cca723a738f6925005797e
Author: Tejun Heo <tj@kernel.org>

sched_ext: Defer sub_kset base put to scx_sched_free_rcu_work

This commit splits the sub_kset teardown by moving kobject_put() to
scx_sched_free_rcu_work() while keeping kobject_del() in the disable
path. This ensures the memory remains valid during concurrent disable
and enable operations, relying on sysfs creation failure to catch races.

> A racing child sees state_in_sysfs=3D0 with valid memory, sysfs_create_di=
r() fails, and
> the existing exit_kind gate in scx_link_sched() turns it away with -ENOEN=
T.

Does this accurately describe the error path? If sysfs_create_dir() fails,
wouldn't scx_alloc_and_add_sched() return ERR_PTR(-ENOENT) and jump directly
to out_unlock in scx_sub_enable_workfn(), completely bypassing
scx_link_sched()?

Also, does this create an inconsistent API contract for userspace? If the
sysfs creation fails, userspace receives a synchronous -ENOENT. However, if
sysfs creation succeeds but the race is caught later by the exit_kind gate =
in
scx_link_sched(), the error path jumps to err_disable which sets cmd->ret =
=3D 0,
resulting in an asynchronous failure instead.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -5801,7 +5803,7 @@ static void scx_sub_disable(struct scx_sched *sch)
>  	if (sch->ops.exit)
>  		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
>  	if (sch->sub_kset)
> -		kset_unregister(sch->sub_kset);
> +		kobject_del(&sch->sub_kset->kobj);
>  	kobject_del(&sch->kobj);
>  }

Will relying on sysfs failure here cause user-triggerable kernel log spam?

When the parent's sysfs directory is removed via kobject_del(), its ->sd
pointer is set to NULL. When the racing child subsequently calls
kobject_init_and_add() and sysfs_create_dir_ns() fails with -ENOENT,
kobject_add_internal() will unconditionally print a pr_err() about the fail=
ure.

Since this is an expected race condition, is it safe to handle it by letting
sysfs fail and print an error to dmesg?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2f2b7481ef217ad89c5=
d90fd56fc0c01@kernel.org?part=3D1
