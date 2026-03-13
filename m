Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D532470E
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366597; cv=none; b=J+zziT0RRxHlTIFOGbroAMQTWnJH4Em9Dn0Qzek6WvBAWeCppJSySGNLamnMb3szWhRADuolpe74468hVS+iM2ZV+/NqnNROxqXw9GKXqfh/AaZ3eCChTHAqNAZMZTLro2chfcMyPOP8CfkAEsLWXpqu7BApGnBPkRqXUaVmRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366597; c=relaxed/simple;
	bh=Ie9stTe3UJN54kze7gFEIIQ8wjDNY7T/bh/T724AVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4UHIV13AOCcYBDeMsaI1RyM5dmzhTJ7Es0oVpY873HaBkgcVEJveSEHYOzpbyu1U2P57zJfTkTCgxkLRFNqYxEnFSCuzpaIZJvaIbX2IlcRxh1Ju21VyfMgXL6V3OAZoseP9pOzy84uCHjzPyH/Hwhf7gQAyaCJGn6O+i45WxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT/+ZpOZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT/+ZpOZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824b05d2786so1129483b3a.2
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773366595; x=1773971395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82WEp8nzzZ8MXE4TyjdhmeotQUQUGdMmnILzeGRRNX4=;
        b=aT/+ZpOZ4pwhTwO4XkiA5fL4t4JbJ8yp57DOnfQpjj3IiGRMnQTLCxOf6pCrkbx9AF
         liAzTh1Vo0PU0Q+ZiivkItpwtr6525fBYDTCWPGxbtPDgZ+OF+LHCHFSIVuA4MPYxN/z
         9HGBP4dsfztfwvsrtjutspLRzPyN7E/pJ4VPIKjw59Xwn03A8CBTz2Zo71ARXAcqyceH
         U8F0HiEvVRDJGn69T5P3b7cf+ip4CjRJQ1mMPydQb1ParkQPTSM1jZBJd1ULOIDP/Vaa
         oRlM+rBxHphko2QtbKfQHKAS6XmC3sLHaEdkQG9vJj2Lkcvw2R/A0AlxCegV7xFvibjo
         CHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773366595; x=1773971395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82WEp8nzzZ8MXE4TyjdhmeotQUQUGdMmnILzeGRRNX4=;
        b=Ot7abYBx1fmRQcUY4apgngSzjKAOQvNNarRc7qweHuy8RCkjxV30i531uh9MOc8ud8
         MJ5xyqITYAVifDquozLprLsxmZt8HrWq/ZqWimhqVYC1qPNHqAaST5B80II1x1u/Rlt/
         diLYjRRB/+4Rgv9GP0szW5QRaIRcUKgYIEUKq8rjHDVm0HctcvlYJ0MqqjUyOHBS9yh+
         CaLvaWtEXtCcVpG97ug0O/t/jWQiypzCptBzP/alLMtpNJSJjkXJ8Z7Z1TVcjyOMGYXw
         4jv6UTu4YXkEHP4HTdJkyHunTUXUhpYPwY5PGM4yp7MeVVh074E4C9OYypnF098WeY+n
         F+QA==
X-Gm-Message-State: AOJu0YxK2dTTo1q++wiaBgjcNzOhmcgR0c/tfv0p4QHy03uU7TWgIAyL
	MKguEOAVIhDqiGQkCT4zK4wwcbez8hhvHxlRR/P3CYkLB4Dl9r9tszHVCXsoNU4t
X-Gm-Gg: ATEYQzzJHZGqMW8X096sZu4RYEbQ5byobXFVlPuiHMMeeKRVHWA0rUIETXTf/UWNQON
	6V0Nw+IdxS9zVgrktAaq6i0KQInEqVXbj0MS4FEKaG3i0A9Q8u6/5/ukSAqub2gePLr0qRvt14a
	8GhAuHEVlAlfuZvJ9PLQLHC7Jx+ibxlBHAlFJ6A8hxG/L4TEUMGtDgyBu7sgZf+FBNBaALNYj/Z
	+WXPq2NlVmDH480uormmRAT7QGn75DsDUePajIv22H2LZN8Q/+ThNcoV7/xtsnyFrVKOpBWHDv4
	i1zI2Kq2empN0WslZFQCCPMciHA3zckeRdlZDG1QtRgJoxt4Ndzq7dcfAqy6HN5s57TCuJsl1xu
	KdPT3NxUcan/YZp5IKRbHlTzznG9TKzFwbH97UkRLDSvNvvSzcbpMgfm0d1+fcMBHm9Zs8D5NV9
	TNCStUwSRaYLvHZ3Zm1laiKXzPGST8eB6iW1u9+M7JCkYFY2cAFOtP
X-Received: by 2002:a05:6a21:4d8d:b0:398:ab1b:5f30 with SMTP id adf61e73a8af0-398ecdf20e6mr1070515637.69.1773366595069;
        Thu, 12 Mar 2026 18:49:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm4268676b3a.46.2026.03.12.18.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:49:54 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v3 2/2] sched_ext: Update demo schedulers and selftests to drop ops.cpu_acquire/release()
Date: Fri, 13 Mar 2026 09:49:44 +0800
Message-ID: <20260313014944.1234667-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260313014944.1234667-1-yphbchou0911@gmail.com>
References: <20260313014944.1234667-1-yphbchou0911@gmail.com>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
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

