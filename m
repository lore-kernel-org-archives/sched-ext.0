Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CF38B131
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338140; cv=none; b=FT7CDJGnHmvk7wNDqJM3JA3lL9E7zCyVI1IdDjs43z9hYgNBERD4NdJWqfmJwLnbowj9sG5ZA8Y6+K4HcmMRRHpZ/ETBC+zTsDKbDcH1cJpTSSw7y8XkNwpqT5TQncPO+P5zwtDjdmHr3LVWbTuOsYV5w9ioJzvF7uaJIvq9Z94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338140; c=relaxed/simple;
	bh=pzf63wxPUVhaRfoEB0ZNzINQ3XqI1uWQt3pF2NLaQvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpEnaCxLvPFg5BkuEIieFsu+uTSDV4YYv6W+ZB/3vvxKKNfSHx3B/CDuMJ46NPJx70AeXMuTqcvhwDamNqwMP1rj+gKnv1jlvvB2gQMpFTFo8N5lRZmks2f4nVFLepilikH0STm8WHPNSZfvJFvmd7/3FK+pELaEAjZ4HOMrc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2lXeS87; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2lXeS87"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so832916a91.3
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338138; x=1773942938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxPlTyf/UB9bSz4fgNdN7QXPAjYvDskIC5UKTjz2dj8=;
        b=F2lXeS87WI6ZXPglhWlIr+Ny1EiHtkKzrBZx8WtqKf9NXiBNV/JEiJh8cLSNWeRWUP
         hJbMQzrpoJNC/sVtLAXJDVgQU3ygenSgrOXnu1MUaS8B5n8Ee3Sd1Mkao4mTOz5CgqHv
         v0JB9hTOXW348wKm9N3NmgSN9jrF23zADqx00lFOFobm8eJ45nbUd6xkB2yq8KXMX3zq
         ZWl7fttAxbDo/oRrhLLF4+xDUycovPBItYU4mtQsAaui3YgVDRg5YO8SlJzfis/OWTfP
         SPPN3bsv8bm5/Pzdf637KGC2Z1CHWnqj95ApdHznu9T08YKrNbI//w8lG1WsM4KpQvQQ
         xQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338138; x=1773942938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GxPlTyf/UB9bSz4fgNdN7QXPAjYvDskIC5UKTjz2dj8=;
        b=rKFJcaTY3Pcq8s1xzA9Ul9TFzFfb116SoevvPeobFL1KqXmLbPgIxU36RcI/OAMMT8
         8GaBCEte9XIX+ifggvGYzvjAa7Us67fka55q27uwB/TLwuaZQZeQ5+PgNQiJW8+rb3bv
         xOKwMInnWQgddh9adk+p8TktbxEAO8xEZyP7ub1icwAG1wvYLS/rDglAS+79O3E617kf
         o9g2vFfPYGNIe0DU7xJfV4L+bLqCPjwh9ccgRIoZyzUrvY2D2oTznL9i72lzpHxDLXXi
         Qem7bWWIK+etolz/Y+3cV+Da2MDh9JQZb4KBV2VpxhV9M9qqgpoF8/kyPgK7IlIPdTNj
         dNAA==
X-Gm-Message-State: AOJu0YwhHOv3COZrvlvcX1WYopYKqc20QPS+H6/F24+td3Z8lhRk/e1T
	4xS4eRUSXF2UtL2f30alujfhz5fGbOmModUkPU1J2tnZAPkKQZAByiW8GuxQQQM5
X-Gm-Gg: ATEYQzxLB70tyJS3ge4XwqbRS67YH42Zvoezxo/MtCvyKebaPDS5+eporAk+canUPQY
	rLuiyHbzUPVWGHqeRnnDm+mg7tUJ2xyhOtN39stiamZdKqbB7+seJp/QiHku0MnM6gDM2Z1ODhd
	kSJ0PT8kWRbkv0EN8UzTMaAgGM2JVOHFeen7MhnOLIsfN9YV1jls13QKZInx/xzjEZ6sjbCS7/n
	EAiSSUoDYHgQuk9Bo7LkLTuh2/IB32XDxUCWPeZMb145s8MyQ6Z8nETFFC/HZI4To8fzv61qMwm
	qTzJdK1G/IvIw02YHTf5mT11ODxTEzGp/CCEvrycXm3FtX2tcT32ARiamC1uczs3ykw6gWg9PWO
	hNNNIfnz+99yx/JuqLm5s8gKnbVBBzHk47BtyjP5gPH1XTHYL+BXDmS5SYI0w7nXWZejK5aR7LM
	7D7x1Q+141+FQAdXNDsDbIFaGQyznKLne28hlogzat9H2PPuMdKPiR/YWqFZa7EGo=
X-Received: by 2002:a17:90b:278d:b0:359:f3ec:c773 with SMTP id 98e67ed59e1d1-35a21e4ee48mr543621a91.3.1773338137936;
        Thu, 12 Mar 2026 10:55:37 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf24c5csm6027353a12.12.2026.03.12.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:55:37 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/2] sched_ext: Update demo schedulers and selftests to drop ops.cpu_acquire/release()
Date: Fri, 13 Mar 2026 01:55:27 +0800
Message-ID: <20260312175527.1220540-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260312175527.1220540-1-yphbchou0911@gmail.com>
References: <20260312175527.1220540-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.cpu_acquire/release() are deprecated by commit a3f5d4822253
("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
anywhere") in favor of handling CPU preemption via the sched_switch
tracepoint. Update scx_qmap and the maximal selftest to use the new
approach.

In scx_qmap, remove the cpu_release fallback and the
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
qmap_sched_switch(), unconditionally handling preemption via the TP.

In the maximal selftest, replace the cpu_acquire/release stubs with a
minimal sched_switch TP program. Attach all non-struct_ops programs
(including the new TP) via maximal__attach() after disabling auto-attach
for the maximal_ops struct_ops map, which is managed manually in run().

Apply the same fix to reload_loop, which also uses the maximal skeleton.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c                  | 15 ++-------------
 tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c     |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c |  3 +++
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a4a1b84fe359..a11e27c8de77 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -11,8 +11,8 @@
  *
  * - BPF-side queueing using PIDs.
  * - Sleepable per-task storage allocation using ops.prep_enable().
- * - Using ops.cpu_release() to handle a higher priority scheduling class taking
- *   the CPU away.
+ * - Using the sched_switch tracepoint to handle a higher priority scheduling
+ *   class taking the CPU away.
  * - Core-sched support.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
@@ -562,9 +562,6 @@ SEC("tp_btf/sched_switch")
 int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
 	     struct task_struct *next, unsigned long prev_state)
 {
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		return 0;
-
 	/*
 	 * If @cpu is taken by a higher priority scheduling class, it is no
 	 * longer available for executing sched_ext tasks. As we don't want the
@@ -586,13 +583,6 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
 	return 0;
 }
 
-void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
-{
-	/* see qmap_sched_switch() to learn how to do this on newer kernels */
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		scx_bpf_reenqueue_local();
-}
-
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		   struct scx_init_task_args *args)
 {
@@ -999,7 +989,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
-	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 01cf4f3da4e0..5858f64313e9 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -67,13 +67,12 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
 {}
 
-void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
-		    struct scx_cpu_acquire_args *args)
-{}
-
-void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
-		    struct scx_cpu_release_args *args)
-{}
+SEC("tp_btf/sched_switch")
+int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned long prev_state)
+{
+	return 0;
+}
 
 void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
 {}
@@ -150,8 +149,6 @@ struct sched_ext_ops maximal_ops = {
 	.set_weight		= (void *) maximal_set_weight,
 	.set_cpumask		= (void *) maximal_set_cpumask,
 	.update_idle		= (void *) maximal_update_idle,
-	.cpu_acquire		= (void *) maximal_cpu_acquire,
-	.cpu_release		= (void *) maximal_cpu_release,
 	.cpu_online		= (void *) maximal_cpu_online,
 	.cpu_offline		= (void *) maximal_cpu_offline,
 	.init_task		= (void *) maximal_init_task,
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index c6be50a9941d..1dc369224670 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -19,6 +19,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	*ctx = skel;
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 308211d80436..49297b83d748 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -23,6 +23,9 @@ static enum scx_test_status setup(void **ctx)
 	SCX_ENUM_INIT(skel);
 	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
 
+	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
+	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
+
 	return SCX_TEST_PASS;
 }
 
-- 
2.48.1

