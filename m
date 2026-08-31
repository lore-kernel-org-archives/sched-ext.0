Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE93932D8
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199719; cv=none; b=Jdj9rKo12Zk+vFLo7roRICC0C24eL+9oxGgKAuMzX7eiAYAVwvaHHwVNIm+U2XyJsdZGrUvQHyxHGCs/7Elp2KYKdUM6zrhpyXsfPISTDjfi2sN4mzhYLmzRnkybqHQA0tF+NVC4EPzwd2koZz9byQ0qUr1+yxBq7hXs/HrpG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199719; c=relaxed/simple;
	bh=H3WdgyYOjAkW3SbpRalbgS7TePsFJGUKR0GYEdkQjrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JvTrv0ATWbmDwhThu3/fWy/dOiYA+wHkzZeLk8h/dbKic++WMSalrpRCuRvIFtN0H05HSRZ3xU615kLKHNjl2uD8+6Icg0NKhbT4EcezF/HIGe2377cTBTH4ziVJLer7BweNswn9IpNmkb8xYJCPWd4cUjJlnrDlHynHnCEbMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBjW6E+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBjW6E+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947171F000E9;
	Mon, 31 Aug 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199717;
	bh=lLTalW1SKx3oGZxPLe/FTv5YXAZdr2NJMwSWAPCuDiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBjW6E+T3NOGNjCqB5y5MF1UyOtDGqy68L/eHwth+V+C5EMeTElwxvb+6OXarV3nO
	 +AylH9Nd07R4lW4SF/TzzoRb3DGBOjAZ64S0pkGecmgjkISZYm6mHnu4cGDbEMo8mW
	 b33l67kz3Xe6XBVXMZrM79KQteoo3HkxYgnQFNx0uVd1lX/2+8DV5JfK/CFF085u/v
	 XnxtYuatZeZiPxm9F5dpQ7rblOi//11XS9PQRYvaMBoEc5mMNpHbpQoBraGg5dS7qV
	 RUprJDBotcskzAk7Hr5m/M1NjF4DVJykaR42DLGrIk1ODBPJB8mGLqR+JhElf5K5+w
	 fwWwWED1H4sXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260831134338.1531664-16-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-16-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:08:37 +0000
Message-Id: <20260831180837.947171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new BPF scheduler receives `ops.dequeue` before `ops.enable` o=
r `ops.enqueue` for retained proxy donors during root scheduler enablement,=
 violating the BPF lifecycle contract.
--

commit 2446f36cb7fab90783875259131bf6b0d4fa2d3d
Author: Andrea Righi <arighi@nvidia.com>

    sched_ext: Delegate proxy donor admission to BPF schedulers

    Proxy execution keeps a mutex-blocked donor runnable so that its
    scheduling context can execute the mutex owner. This patch introduces
    SCX_OPS_ENQ_BLOCKED to allow schedulers to continue owning blocked dono=
rs.
    A proxy-migrated donor returns through the full wakeup activation path
    when the mutex is released.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f23e9f1ee2f3c..06067fe504a24 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8027,6 +8108,14 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
> =20
>  		if (old_class !=3D new_class)
>  			queue_flags |=3D DEQUEUE_CLASS;
> +		if (old_class =3D=3D new_class && new_class =3D=3D &ext_sched_class) {
> +			/*
> +			 * This is an EXT-to-EXT scheduler ownership change, so
> +			 * sched_change_begin() won't end retained proxy execution.
> +			 */
> +			scx_prepare_task_sched_change(p);
> +			queue_flags |=3D DEQUEUE_NOCLOCK;
> +		}
                 ^

[Severity: High]
Does this code call ops.dequeue() on the new BPF scheduler before ops.enabl=
e()
has been called?

Looking at scx_root_enable_workfn() in kernel/sched/ext/ext.c, the task's
p->scx.sched is updated to the new scheduler in a previous loop.=20

When scx_prepare_task_sched_change(p) is called during an EXT-to-EXT
scheduler ownership change, it triggers the following sequence:

scx_prepare_task_sched_change()
  sched_proxy_block_task()
    dequeue_task_scx()
      ops.dequeue()

Because dequeue_task_scx() sees the SCX_TASK_IN_CUSTODY flag left over from
the old scheduler, it executes ops.dequeue() on the new scheduler.

Since DEQUEUE_CLASS is omitted from queue_flags for EXT-to-EXT transitions,
the switching_to hook is skipped and scx_enable_task() is never called to
initialize the per-task state for the new scheduler.

Can this lead to the BPF program experiencing out-of-bounds map accesses or
NULL pointer dereferences, as it relies on ops.enable() to initialize state
before ops.dequeue() is called?

> =20
>  		scoped_guard (sched_change, p, new_class, queue_flags) {
>  			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831134338.1531=
664-1-arighi@nvidia.com?part=3D15
