Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAC42885F
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299588; cv=none; b=GqR+fjIDXDnKgAtHHn/+9Jq7FzzANrU1lSSDaNDBEhNPT/NjG23THPAsWWyiuYwoaJrRSy1Vt6P9pHgersGfoN5N9uj7WCxQbcXXbkoPbhVfgCz8lA50GfZ+e2NAIYWfmlhMeUhhPbRORRRFyZfK8svqu7HVscgq/8LS8QNh/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299588; c=relaxed/simple;
	bh=nB5D+c6mlpQKbqzWpZYWketXeNIQDK8RXO1T9f01JPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqRzlsnooEy6SyV8W/ewucw6pg+eBKqybx3hj9sDgYmK+XA+XRX2bfJEywRDt2qus7N98GPvd6jPArFpkRHdT9gXshfQgXqMxS6cGPQ3X53oMwYHCr5tRYzxiFxWVk9cOnnA6THS2nw4UIxdSayi62vN08rPQ/ZigXG/Gac2VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oGsmx6kd; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oGsmx6kd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VyQXL9lhNEzJMERcMyRIW1EikWF4o55LaWJsWhpm7Pk=;
	b=oGsmx6kdYeHeKXLFXbhrSMplqR4CGolQVlxDeMgD3QOH8dWU9d9MGgXa2TLT2uunFhmxdEGah
	nAe7vathgmiCdYWq9yk4dO3sS4XYTyWp0VY4QbCvZMpiOzamBT+sgi2c9kWBL9iV7HFRTC4XwhW
	UKtm54uuiFkQwyd6EOoahJc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hRCKL5FCnz1K97N;
	Fri, 21 Aug 2026 15:55:34 +0800 (CST)
Received: from kwepemg500006.china.huawei.com (unknown [7.202.181.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AD014057A;
	Fri, 21 Aug 2026 16:06:17 +0800 (CST)
Received: from kwepemg500004.china.huawei.com (7.202.181.40) by
 kwepemg500006.china.huawei.com (7.202.181.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Aug 2026 16:06:16 +0800
Received: from kwepemg500004.china.huawei.com ([7.202.181.40]) by
 kwepemg500004.china.huawei.com ([7.202.181.40]) with mapi id 15.02.1544.011;
 Fri, 21 Aug 2026 16:06:16 +0800
From: "yaoyiqi (A)" <yaoyiqi3@huawei.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
CC: "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>, "tj@kernel.org"
	<tj@kernel.org>, "void@manifault.com" <void@manifault.com>,
	"arighi@nvidia.com" <arighi@nvidia.com>, "changwoo@igalia.com"
	<changwoo@igalia.com>
Subject: Re: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Topic: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Index: Ad0xDcEQVcEhz353RJ2TMpKa0d43u///higAgAAhjwCAAB/GAIAAHsXA
Date: Fri, 21 Aug 2026 08:06:16 +0000
Message-ID: <badf60497ca0443e947ffa2831cc19ba@huawei.com>
References: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com>
 <19aa0be21ad34c6cabab7cc8b26d4656@huawei.com>
 <20260821061608.1987231-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260821061608.1987231-1-zhanxusheng@xiaomi.com>
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

On Fri, 21 Aug 2026 06:16:00 +0000, Zhan Xusheng wrote:
> stat_inc(NEST_STAT(CALLBACK_COMPACTED)) sits above this, so the stale exp=
iries get counted as compactions that did not happen. The counters also sto=
p adding up: the cancel in migrate_primary() takes CANCELLED_COMPACTION, th=
en the same timer still fires and takes CALLBACK_COMPACTED, so SCHEDULED_CO=
MPACTION no longer matches the sum unless the core was re-armed in between.

I tried your suggestion, but still CALLBACK_COMPATED + CANCELLED_COMPACTION
< SCHEDULED_COMPACTION. This might be the .dispatch() re-armed the timer
before the callback compact_primary_core was triggered.

On Fri, 21 Aug 2026 06:16:00 +0000, Zhan Xusheng wrote:
> I would drop the "can": it looks unconditional to me.

Thanks for your confirmation. Searching for the callers of
select_task_rq_scx(), all of them have raw_spinlock_irqsave for p->pi_lock.

Newer patch can be reviewed below.

Thanks,
Yao YiQi
---
diff --git a/scheds/c/scx_nest.bpf.c b/scheds/c/scx_nest.bpf.c
index 2992f90b..d93549dc 100644
--- a/scheds/c/scx_nest.bpf.c
+++ b/scheds/c/scx_nest.bpf.c
@@ -194,17 +194,27 @@ static int compact_primary_core(void *map, int *key, =
struct bpf_timer *timer)
 	s32 cpu =3D bpf_get_smp_processor_id();
 	struct pcpu_ctx *pcpu_ctx;
=20
-	stat_inc(NEST_STAT(CALLBACK_COMPACTED));
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
+	 * longer cancel the timer from there: select_cpu() is invoked with
+	 * p->pi_lock held (its callers take it via raw_spin_lock_irqsave() and
+	 * thus always run with local IRQs disabled, regardless of the entry
+	 * context), where the timer-cancel synchronization isn't available.
+	 * Instead the pending callback detects that scheduled_compaction was
+	 * cleared and bails out. Only demote the core if a compaction is still
+	 * actually scheduled.
+	 */
+	if (!pcpu_ctx->scheduled_compaction)
+		return 0;
+
+	stat_inc(NEST_STAT(CALLBACK_COMPACTED));
 	bpf_rcu_read_lock();
 	primary =3D primary_cpumask;
 	reserve =3D reserve_cpumask;
@@ -356,11 +366,15 @@ migrate_primary:
 		tctx->prev_misses =3D 0;
 	pcpu_ctx =3D bpf_map_lookup_elem(&pcpu_ctxs, &cpu);
 	if (pcpu_ctx) {
+		/*
+		 * A compaction may have been scheduled for this core. Instead of
+		 * cancelling the timer (select_cpu() holds p->pi_lock, which locks
+		 * with local IRQs disabled within all callers of select_task_rq,
+		 * so the timer cancel isn't usable here), clear scheduled_compaction
+		 * so that the timer callback, if it fires after we land a task here,
+		 * detects it as stale and bails out.
+		 */
 		if (pcpu_ctx->scheduled_compaction) {
-			if (bpf_timer_cancel(&pcpu_ctx->timer) < 0)
-				scx_bpf_error("Failed to cancel pcpu timer");
-			if (bpf_timer_set_callback(&pcpu_ctx->timer, compact_primary_core))
-				scx_bpf_error("Failed to re-arm pcpu timer");
 			pcpu_ctx->scheduled_compaction =3D false;
 			stat_inc(NEST_STAT(CANCELLED_COMPACTION));
 		}
