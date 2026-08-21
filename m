Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86B29E0E5
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286164; cv=none; b=NeTmkxX43kPRVBGVK+eKxK+Ja6hU8TRYdfYVVRQEvvym+v7gRd0iP7O8mZ9I87huWTxVMhum75BalFDt7gxFn45azOVeWdmlXnR8PsVp/Icbnl9yXH86Xn7F7P953Qze0SEUI4LF5P2gt6vBoMstmmhro7vtCAVvYBUBQgFpd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286164; c=relaxed/simple;
	bh=cPcpHDnk78THB+xEFpRyTeofLEkDDxQmtlHlAeyCOM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIwO20odS5g7ANVUx+0QcrEh0rqGzPj2EhI4nXhj2q+DKmxvfMHV+l0MYLQRrNgWOBxdAQNiYvY6Vt9kTjeDrFqMFTKA7EIoiZJpOQkhvlyKWtRsnqOAc+wqM0MZAoPQfDxwTnCDd30TuA38FpETSHoKpnOv8jrEjOOYGd9jBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BmCXlMpq; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BmCXlMpq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mzI0JzEY4/j8PBLVW81FbeH8s5RG7lJpJEpzDCj0bYM=;
	b=BmCXlMpq9ANB81Jc7fJaKtL2MzIcCJRS5dLAD1AfKBWf4RcwA5sWSkqmNQQIXiafIc4bxhw4p
	UcIQcOehw9fgS7Mi8EnFIDBGUe5xsovWulxoF0/fTwdkkyP/8v/p7sUsgrJ9C36xKIlimDO/ByM
	RJ7MBvER81FUuaLjIZhIME8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hR6MD2WWMz1prKd;
	Fri, 21 Aug 2026 12:11:52 +0800 (CST)
Received: from kwepemg200006.china.huawei.com (unknown [7.202.181.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B909940577;
	Fri, 21 Aug 2026 12:22:36 +0800 (CST)
Received: from kwepemg500004.china.huawei.com (7.202.181.40) by
 kwepemg200006.china.huawei.com (7.202.181.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Aug 2026 12:22:36 +0800
Received: from kwepemg500004.china.huawei.com ([7.202.181.40]) by
 kwepemg500004.china.huawei.com ([7.202.181.40]) with mapi id 15.02.1544.011;
 Fri, 21 Aug 2026 12:22:26 +0800
From: "yaoyiqi (A)" <yaoyiqi3@huawei.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
CC: "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>, "tj@kernel.org"
	<tj@kernel.org>, "void@manifault.com" <void@manifault.com>,
	"arighi@nvidia.com" <arighi@nvidia.com>, "changwoo@igalia.com"
	<changwoo@igalia.com>
Subject: Re: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Topic: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Index: Ad0xDcEQVcEhz353RJ2TMpKa0d43u///higAgAAhjwA=
Date: Fri, 21 Aug 2026 04:22:26 +0000
Message-ID: <19aa0be21ad34c6cabab7cc8b26d4656@huawei.com>
References: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com>
 <20260821022218.1941947-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260821022218.1941947-1-zhanxusheng@xiaomi.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 21 Aug 2026 02:22:00 +0000, Zhan Xusheng wrote:
> helpers.c:1515. .select_cpu() qualifies through irqs_disabled():
> try_to_wake_up() holds p->pi_lock across the wakeup via
> scoped_guard(raw_spinlock_irqsave) at kernel/sched/core.c:4302 and calls
> select_task_rq() inside it at 4403, which dispatches through sched_class-=
>select_task_rq (core.c:3629) into select_task_rq_scx() and SCX_CALL_OP_TAS=
K_RET(sch, select_cpu, ...) at kernel/sched/ext/ext.c:3530 and 3558. So a s=
ched_ext callback that runs with IRQs enabled is unaffected, and this is no=
t specific to CPU-pinned timers.

Unfortunately I encountered -EOPNOTSUPP with bpf_timer_cancel(), which
means it ran with IRQs disabled or within hard IRQs.

On Fri, 21 Aug 2026 02:22:00 +0000, Zhan Xusheng wrote:
> If it was -ECANCELED then the sync/async split is the whole story, and th=
e gate is neither sleepability nor sched_ext:

Thanks for your clarification, it turns out that the
bpf_timer_cancel_async() kfunc returned -ECANCELED as you pointed out. I
erroneously use "< 0" to come to a bad conclusion without further
investigation. The gate is not about sleepability, is whether
bpf_timer_cancel can happen on .select_cpu, which might be triggered by
hard IRQs. I have changed my comment on the diff to not mislead other
people.

But I think our current workaround might be more compatible with kernels
have bpf_timer_cancel() only. I think this might not be a good solution:

	#define __COMPAT_scx_bpf_timer_cancel(timer)				\
		(bpf_ksym_exists(scx_bpf_timer_cancel_async)?			\
		bpf_timer_cancel_async((timer)) : bpf_timer_cancel((timer))

	/*
	 * bpf_timer_cancel_async returns -ECANCELED for async cancel.
	 */
	if ((ret =3D __COMPAT_scx_bpf_timer_cancel(&pcpu_ctx->timer)) < 0 &&
	ret !=3D -ECANCELED)
		scx_bpf_error("Failed to cancel pcpu timer");
	/*
	 * bpf_timer_cancel_async does not need to set callback again.
	 */
	if (ret !=3D -ECANCELED && bpf_timer_set_callback(&pcpu_ctx->timer,
	compact_primary_core))
		scx_bpf_error("Failed to re-arm pcpu timer");

This runs into a problem: On old kernels the macro gives us a synchronous
cancel. On 7.x it gives you an asynchronous one. The scheduler will have
different behavior on different kernels and thus have different
performance.

So I will keep the flag-based one as my workaround.

Thanks,
Yao YiQi
---
diff --git a/scheds/c/scx_nest.bpf.c b/scheds/c/scx_nest.bpf.c
index 2992f90b..b53a0864 100644
--- a/scheds/c/scx_nest.bpf.c
+++ b/scheds/c/scx_nest.bpf.c
@@ -195,16 +195,26 @@ static int compact_primary_core(void *map, int *key, =
struct bpf_timer *timer)
 	struct pcpu_ctx *pcpu_ctx;
=20
 	stat_inc(NEST_STAT(CALLBACK_COMPACTED));
-	/*
-	 * If we made it to this callback, it means that the timer callback was
-	 * never cancelled, and so the core needs to be demoted from the
-	 * primary nest.
-	 */
 	pcpu_ctx =3D bpf_map_lookup_elem(&pcpu_ctxs, &cpu);
 	if (!pcpu_ctx) {
 		scx_bpf_error("Couldn't lookup pcpu ctx");
 		return 0;
 	}
+
+	/*
+	 * The core may have been re-promoted to the primary nest while this
+	 * timer was pending (see migrate_primary in nest_select_cpu()). We no
+	 * longer cancel the timer from there: select_cpu() runs in the task
+	 * wakeup path, which can be entered with local IRQs disabled or from
+	 * hardirq contexts (e.g. wakeups originating in interrupt handlers),
+	 * where the timer-cancel synchronization isn't available. Instead the
+	 * pending callback detects that scheduled_compaction was cleared and
+	 * bails out. Only demote the core if a compaction is still actually
+	 * scheduled.
+	 */
+	if (!pcpu_ctx->scheduled_compaction)
+		return 0;
+
 	bpf_rcu_read_lock();
 	primary =3D primary_cpumask;
 	reserve =3D reserve_cpumask;
@@ -356,11 +366,16 @@ migrate_primary:
 		tctx->prev_misses =3D 0;
 	pcpu_ctx =3D bpf_map_lookup_elem(&pcpu_ctxs, &cpu);
 	if (pcpu_ctx) {
+		/*
+		 * A compaction may have been scheduled for this core. Instead of
+		 * cancelling the timer (select_cpu() is entered from the wakeup
+		 * path, which can run with local IRQs disabled or in hardirq
+		 * contexts - not merely "non-sleepable" - so the timer cancel
+		 * isn't usable here), clear scheduled_compaction so that the
+		 * timer callback, if it fires after we land a task here, detects
+		 * it as stale and bails out.
+		 */
 		if (pcpu_ctx->scheduled_compaction) {
-			if (bpf_timer_cancel(&pcpu_ctx->timer) < 0)
-				scx_bpf_error("Failed to cancel pcpu timer");
-			if (bpf_timer_set_callback(&pcpu_ctx->timer, compact_primary_core))
-				scx_bpf_error("Failed to re-arm pcpu timer");
 			pcpu_ctx->scheduled_compaction =3D false;
 			stat_inc(NEST_STAT(CANCELLED_COMPACTION));
 		}
