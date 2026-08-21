Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEE30C164
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276380; cv=none; b=NQEgmQ8eOIwseQ4EnfVC2G9m9hlDPnwllLdmFKGtK0qHNZ6STTijBohaPAhTjV6g+Lb5pV09AIb3Zv+NJcn3Zfv+mkknw4FA8HbZNuNgtole8bccZUhBMmUxWH/QZYcVd63ZNYHBLcgqelv7Wq9XFcst3tOtYa7xFixL67bcvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276380; c=relaxed/simple;
	bh=gXG8pBHgiYXDEa2dl4MTgiVKi9lCwQgGEy47PzFi5Tc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zv7gWmKXWseYxC4mB4yingChLRcBC4hk50RGUx1KkeoK4zdiGN0NSTmhZzioFIVN3YRIEkFOsXinR490T2zh/8yAG6ZTaGrcR2BedEY/POM5mMXBPqHLxhQ9PjrCHQgqc/7Dkg3DjtJAG1p0FUvhc4XjEU9mlV2ClXZC4U0Zspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wQKi5xIf; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wQKi5xIf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6y4Sf+i0nBBWLna9eaPUuseTlL2XSf2x71Szhx6/WWs=;
	b=wQKi5xIfnU6wacWAKhLayKObuacAGByKcHjsKXfBDmSENWNPCT5HQShK59/nylFNn2JFhNS5a
	VIrp+7kQ5eUyKbU+hYy8cU3E5TVdmFnyqsj6tRwtC3JHkG02cSaraQ8jm31pttFQGCmaGxKltdC
	eyH/60TDjrJpDGcfaQYXKUI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hR2kv56cKz1prN4;
	Fri, 21 Aug 2026 09:28:39 +0800 (CST)
Received: from kwepemg100005.china.huawei.com (unknown [7.202.181.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C8334057F;
	Fri, 21 Aug 2026 09:39:24 +0800 (CST)
Received: from kwepemg500004.china.huawei.com (7.202.181.40) by
 kwepemg100005.china.huawei.com (7.202.181.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 21 Aug 2026 09:39:23 +0800
Received: from kwepemg500004.china.huawei.com ([7.202.181.40]) by
 kwepemg500004.china.huawei.com ([7.202.181.40]) with mapi id 15.02.1544.011;
 Fri, 21 Aug 2026 09:39:23 +0800
From: "yaoyiqi (A)" <yaoyiqi3@huawei.com>
To: "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>
CC: "tj@kernel.org" <tj@kernel.org>, "void@manifault.com"
	<void@manifault.com>, "arighi@nvidia.com" <arighi@nvidia.com>,
	"changwoo@igalia.com" <changwoo@igalia.com>
Subject: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Topic: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Thread-Index: Ad0xDcEQVcEhz353RJ2TMpKa0d43uw==
Date: Fri, 21 Aug 2026 01:39:23 +0000
Message-ID: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com>
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

Hi,

I ran into a regression with the classic C example scheduler scx_nest
(sched-ext/scx-c-examples) on a 7.1.8 kernel (post-bpf_async timer
rework). It loads and attaches fine, but exits immediately once a
re-promoted core's compaction timer needs cancelling:

sched_ext: BPF scheduler "nest" enabled
sched_ext: nest: .../scheds/c/scx_nest.bpf.c:361: Failed to cancel pcpu tim=
er
scx_bpf_error_bstr()
nest_select_cpu()
bpf__sched_ext_ops_select_cpu()

The failing call is bpf_timer_cancel(&pcpu_ctx->timer) from the
non-sleepable .select_cpu() callback. Testing showed that on this kernel
bpf_timer_cancel_async(&timer) also returns an error from the same
context, so this appears to be a broader restriction than the
sync/async split: cancelling a CPU-pinned timer is not usable from a
sched_ext hot-path callback at all.

For context: scx_nest is the only C scheduler in scx-c-examples that
uses bpf_timer_cancel(); scx_central/scx_qmap only init/start timers and
are unaffected. None of the current Rust schedulers in sched-ext/scx
cancel timers either - they all use flags/generations to let stale
callbacks no-op, which is what I applied to scx_nest as a workaround.

Questions / notes for maintainers:
- Is this restriction intentional? I'd expect the timer docs to call out
that bpf_timer_cancel()/bpf_timer_cancel_async() may fail from
non-sleepable sched_ext callbacks such as select_cpu().
- Since scx_nest isn't in tools/sched_ext I'm not submitting this as a
kernel patch; I'm reporting it so the API change is on record and in
case the example deserves updating elsewhere.

Workaround diff (in case it helps, applies to scx-c-examples): instead
of cancelling the pending timer when a core is re-promoted, clear
pcpu_ctx->scheduled_compaction in migrate_primary() and let the
compact_primary_core() callback detect the stale request and bail out.

Thanks,
Yao YiQi

---

diff --git a/scheds/c/scx_nest.bpf.c b/scheds/c/scx_nest.bpf.c
index 2992f90b..ef0cbe78 100644
--- a/scheds/c/scx_nest.bpf.c
+++ b/scheds/c/scx_nest.bpf.c
@@ -195,16 +195,23 @@ static int compact_primary_core(void *map, int *key, =
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
+	 * longer cancel the timer from there as bpf_timer_cancel() isn't usable
+	 * in that non-sleepable context on newer kernels; instead the pending
+	 * callback detects that scheduled_compaction was cleared and bails out.
+	 * Only demote the core if a compaction is still actually scheduled.
+	 */
+	if (!pcpu_ctx->scheduled_compaction)
+		return 0;
+
 	bpf_rcu_read_lock();
 	primary =3D primary_cpumask;
 	reserve =3D reserve_cpumask;
@@ -356,11 +363,14 @@ migrate_primary:
 		tctx->prev_misses =3D 0;
 	pcpu_ctx =3D bpf_map_lookup_elem(&pcpu_ctxs, &cpu);
 	if (pcpu_ctx) {
+		/*
+		 * A compaction may have been scheduled for this core. Instead of
+		 * cancelling the timer (bpf_timer_cancel() is not usable from
+		 * this non-sleepable context), clear scheduled_compaction so that
+		 * the timer callback, if it fires after we land a task here,
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
