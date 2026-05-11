Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D9383318
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539314; cv=none; b=gFMHgLCCG7p1mcco3Ntshnp4kU2L3UXMlT93AgYzgTNqlWHKqVeT2WQCWGa5h0GJdTcFp3CFlAWNCPaJYxbye8jq/0De6USwQr8902hn4eVpwQLo0Ja2I5kHXI6pglDbFoPHy0IfFw2oUCbeOpAyyHSn6vxsbHBQU4dNeVhlxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539314; c=relaxed/simple;
	bh=ncZHMm/pH5nCy2rL6AA9a7bTc/40wqmspVwmdBXC6pc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XsLfCt0JJE1/TeqOvPwYtConWWwyso+FYOE2Z5Wf04egWJletp1rU2DfoY8zqwbV1TLwWEr14AeV+TYbw6NqzX3BSucUreNi5jFmgaiV/zG6aPiOrtx3L0JFLKPAmibR72Mf79mHFek5yF5DQDREqNdgoemVkfBpu533W0f7gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V76vgeG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V76vgeG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953EAC2BCB0;
	Mon, 11 May 2026 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778539313;
	bh=ncZHMm/pH5nCy2rL6AA9a7bTc/40wqmspVwmdBXC6pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V76vgeG35xVMAB20igTl4WH2b3kcn/e3JJBH+bKIOzuzbCtUA4einzYT9QHEPJdQg
	 mXBvRsme+vWIDkpPBbh42hed7ZWmZ46CTwPox52eec8C4GzYdr1lkEml3PkTt0dwdt
	 IQ1XcbLltdwKPgn6l/wvZjtvVI3rrQClhIAdAW+SLRZ+dx+J+4OEcy1MZVAD1IWBfD
	 D10whFwdkOHtsZIJ9+Hp/dNhT1BrFihUoPW83RlzOiiCVKi0xgxR85gBCl9L6fbzts
	 k8Ccda3zgoMB2sI00LLPdmZyK123QgHznLp7Ct33l9DUtNN4Pj4tdm4z3fmKuH8GfF
	 mBHoAE842NSHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: Add
 scx_task_iter_relock() and use it in scx_root_enable_workfn()
Reply-To: sashiko@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260510224511.2683323-1-tj@kernel.org>
References: <20260510224511.2683323-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 22:41:52 +0000
Message-Id: <20260511224153.953EAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Dereferencing `p->comm` and `p->pid` in `scx_error()` after dr=
opping the task reference and releasing locks causes a Use-After-Free.
--

commit 3693e9669076c05d1b5519c1c28733cc325c69fb
Author: Tejun Heo <tj@kernel.org>
sched_ext: Add scx_task_iter_relock() and use it in scx_root_enable_workfn()

This commit introduces scx_task_iter_relock() to re-acquire scx_tasks_lock
and optionally the task's runqueue lock. It applies this new function in
scx_root_enable_workfn() to properly manage locking during task
initialization and hash insertion.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1d7f206941f0c..2238bd005dc7b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -7135,6 +7153,9 @@ static void scx_root_enable_workfn(struct kthread_w=
ork *work)
>  		scx_task_iter_unlock(&sti);
> =20
>  		ret =3D scx_init_task(sch, p, false);
> +
> +		scx_task_iter_relock(&sti, p);
> +
>  		if (ret) {
>  			put_task_struct(p);
>  			scx_task_iter_stop(&sti);

This regression wasn't introduced by this patch, but existed previously. Can
this cause a use-after-free when scx_error() is called?

Looking at the error path just below this diff chunk:

    if (ret) {
        put_task_struct(p);
        scx_task_iter_stop(&sti);
        scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
                  ret, p->comm, p->pid);

If put_task_struct() drops the last reference to the task, and
scx_task_iter_stop() drops the iterator locks (which unconditionally
re-enables local interrupts via raw_spin_unlock_irq()), could an RCU grace
period expire and physically free the task struct before scx_error() access=
es
p->comm and p->pid?

Would it be safer to move the put_task_struct() call until after the
scx_error() formatting completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510224511.2683=
323-1-tj@kernel.org?part=3D1
