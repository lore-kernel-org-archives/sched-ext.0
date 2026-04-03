Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFB283FE5
	for <sched-ext@lists.linux.dev>; Fri,  3 Apr 2026 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189363; cv=none; b=StGwhjuOPV8zJ4aJ+TfSpm33A/bYOECjMBjxbeVkdz6pR+sVvF4ozc4BCPMa5tNBCoqbkdsTzWNwD9sATNPBrLleLrs1YE+gu/n/RsXHWJIISLjQ7AI3CBoL/QHT6DtkpFeT34mZUMdhIu2gD0NWp+6f5Hyi5be4gRTxITD3au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189363; c=relaxed/simple;
	bh=prc5n/ytwE/qY/wonszaXJVFeBJfFaSDkKuqEAbR5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nA5KMS03GffmMkoJGp/IW1xx9PKY5T3YUC1WO5SeUQMOUd/OTC+cn+mlORUjzziw7JIkLgjn2A9vJVvmsgmxXjDgcwRTMMTBzsYnItXU7Dsz5s2anuVIJJBbxMvRUJ9TZNbTO1AVJx5jCcAO3w16EjHvgmJng+VuL0ToLW7MDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGX0BaOU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGX0BaOU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso8930315ad.0
        for <sched-ext@lists.linux.dev>; Thu, 02 Apr 2026 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775189361; x=1775794161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NA0rogMEw9V7om4ByXiPCdC/1j4NC9VdrCRIErunmp8=;
        b=jGX0BaOUy5yzKmFnCfCUhstHhKH7A3cY5bBeheGqo897vKiHVPaQ/DYfJH6oEQlchu
         TfJHbbaE+13LApAq/lRNfHD7Eiu1UMEIOcDHFFWYCaUw3BweP7JEPDuKQiGS0OF/zEHb
         mTPFj7Q9BAoyMLzINDTO9DrQT14Vzb2HDPAu8x8rKZ+OT0Or1Y3JgQ158J1qPVztjWcR
         inIBK5CXhN9sqj9TV6rmC480zfBigYzIHpUkGyATVfyGXbehxTsEv416oh8HQdsb9N2D
         evxttovkoZkB2GUs8wE3IKI3uQWIv1ydM72Y8MMqi5f0Fq+IplRMMlwWfAAJKLV9rzWb
         X5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775189361; x=1775794161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA0rogMEw9V7om4ByXiPCdC/1j4NC9VdrCRIErunmp8=;
        b=HUqUfDjtQC0SILkZTs/Vzg/cFFIhvXHtQqoGhi7n3g+6vhIzne8KQwLBvX9CHRkMZo
         v9DAzKXxfoqI4OjWa1u5JX1qY/hd1ldm85EyElnvPrE2kgRwkODwHYW97QEQ9I42s9lG
         29tu3bOB70OZUl1QVHvPvr6yeQ0CAmi2krOGTynmvGI1GN+BWCin3I6LMF0trcRvP88c
         rVtf3AUIis2u5V3UZx6mDwFbVx2hvfYoRr5mZB6b5vlIKmdg0/KTeE1FQGr5O9WEc28I
         ThrRrZrVaF4p1N6cUPnqeKVdlUjStrgQlydSteh0txNz8MfjG8Kru9yKmo0fjLtqynUT
         3vfQ==
X-Gm-Message-State: AOJu0Yz8xUT9UU3E93A47ljt2M8XRm//jeRFMLLrdtJFSCLM4MmyfFSy
	UCOJWwpy5OVECGEDUYkesNm7Z5hH01gNfk3b7yMjX3sQWK5HZuK6CaF6Bh3j4A==
X-Gm-Gg: AeBDievySELZ5rXy/Bb3v/gNRS3E+xfB33y1+km8e2JTYAnSKdzwnMBoTbwg92yLQML
	0Q1hUzHZtLkGdLBoC519uM/Hrwbh45vaR1P35C1pIPa5lNgZMkVIqfz3SmjaFH0aubyErr607Ox
	NiQ9jIGt4vL7r0+DiRrRLEJpr1rjn5oFpaRIQX5w1DTIYlXGYp0408qhARkQdxoJJaen1NDBU8W
	mYak2bO67SGWGlcb2qZe5PFx2UDMFoRGqIAngsjsLxmfE16kdg01rX6brHR0R/cho38kV+KsUBb
	cTSHYef/gjPbB1G6mVntmsD7eak7yM3jQM0DaaB2oeaw1OH4VZxji5VH0imygkAmIvW5I//jC0y
	83ZsrINO/WNqg7DKAxSBLlvcnEGVt2jsk6UAhatGiWTKfRlDelhAoDuhyLfFpBwRy1+t6yUqauV
	i13+dBKBfuYf06Bg86PY7R/2x4T6tj0HLv7h4y6vB6u1yWZ0Vir6uI
X-Received: by 2002:a17:902:ce0a:b0:2b0:53b6:d0a4 with SMTP id d9443c01a7336-2b277dad2d0mr44443775ad.12.1775189361060;
        Thu, 02 Apr 2026 21:09:21 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:566e:8ca1:fcf3:4f49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm42055915ad.74.2026.04.02.21.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:09:20 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] tools/sched_ext: Add scx_lib_init() to probe BPF prolog migrate_disable() behavior
Date: Fri,  3 Apr 2026 12:09:02 +0800
Message-ID: <20260403040913.610756-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_migration_disabled() uses LINUX_KERNEL_VERSION >= v6.18 to detect
whether the BPF prolog calls migrate_disable(). This is unreliable for
downstream kernels that cherry-pick 8e4f0b1ebcf2 ("bpf: use
rcu_read_lock_dont_migrate() for trampoline.c") onto a pre-v6.18 base.

Add scx_lib_init() to be called from ops.init() to probe the actual
runtime behavior. The result is stored in __scx_prolog_disables_migration
and used as a slow path in is_migration_disabled() for the pre-v6.18
!CONFIG_PREEMPT_RCU case. The two fast paths (CONFIG_PREEMPT_RCU and
v6.18+ without CONFIG_PREEMPT_RCU) are unaffected.

Call scx_lib_init() in dsp_local_on's ops.init() as the first user.

Sync with upstream scx a4863764ff55, a6101f6c277f, and 1488e1aaf659.

CC: Changwoo Min <changwoo@igalia.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h      | 82 +++++++++++++++----
 .../selftests/sched_ext/dsp_local_on.bpf.c    |  6 ++
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 821d5791bd42..2c143e3d14c4 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,6 +47,7 @@
 extern int LINUX_KERNEL_VERSION __kconfig;
 extern const char CONFIG_CC_VERSION_TEXT[64] __kconfig __weak;
 extern const char CONFIG_LOCALVERSION[64] __kconfig __weak;
+extern bool CONFIG_PREEMPT_RCU __kconfig __weak;
 
 /*
  * Earlier versions of clang/pahole lost upper 32bits in 64bit enums which can
@@ -447,6 +448,38 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 	return (const struct cpumask *)mask;
 }
 
+/*
+ * True if the BPF prolog (__bpf_prog_enter) calls migrate_disable() for the
+ * current task. Probed at runtime by scx_lib_init(). Defaults to true because
+ * the prolog called migrate_disable() unconditionally on kernels before v6.18,
+ * so schedulers that omit scx_lib_init() safely fall back to the original
+ * p == current disambiguation.
+ */
+static bool __scx_prolog_disables_migration = true;
+
+/*
+ * scx_lib_init - initialize the scx BPF library
+ *
+ * Must be called at the top of ops.init(). Probes runtime behavior needed by
+ * library functions such as is_migration_disabled().
+ *
+ * Returns 0 on success.
+ */
+static inline int scx_lib_init(void)
+{
+	/*
+	 * Probe whether the BPF prolog calls migrate_disable() by checking
+	 * migration_disabled of the current task. Since we are executing BPF
+	 * code right now, the prolog has already run: if it called
+	 * migrate_disable(), migration_disabled is non-zero.
+	 */
+	if (bpf_core_field_exists(((struct task_struct *)0)->migration_disabled)) {
+		const struct task_struct *p = bpf_get_current_task_btf();
+		__scx_prolog_disables_migration = p->migration_disabled > 0;
+	}
+	return 0;
+}
+
 /*
  * Return true if task @p cannot migrate to a different CPU, false
  * otherwise.
@@ -454,25 +487,42 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 static inline bool is_migration_disabled(const struct task_struct *p)
 {
 	/*
-	 * Testing p->migration_disabled in a BPF code is tricky because the
-	 * migration is _always_ disabled while running the BPF code.
-	 * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) for BPF
-	 * code execution disable and re-enable the migration of the current
-	 * task, respectively. So, the _current_ task of the sched_ext ops is
-	 * always migration-disabled. Moreover, p->migration_disabled could be
-	 * two or greater when a sched_ext ops BPF code (e.g., ops.tick) is
-	 * executed in the middle of the other BPF code execution.
+	 * Testing p->migration_disabled in BPF is tricky because the BPF prolog
+	 * (__bpf_prog_enter) may call migrate_disable() for the current task,
+	 * making migration_disabled == 1 even for tasks that are not truly
+	 * migration-disabled.
+	 *
+	 * Since commit 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
+	 * trampoline.c"), the BPF prolog calls migrate_disable() only when
+	 * CONFIG_PREEMPT_RCU is enabled. Two fast paths cover the common cases:
+	 *
+	 *   1) CONFIG_PREEMPT_RCU: prolog always calls migrate_disable(), so
+	 *      migration_disabled == 1 for the current task is ambiguous.
+	 *      Disambiguate by checking p == current.
+	 *
+	 *   2) v6.18+ without CONFIG_PREEMPT_RCU: prolog never calls
+	 *      migrate_disable(), so migration_disabled == 1 is unambiguously
+	 *      a real migrate_disable() call.
 	 *
-	 * Therefore, we should decide that the _current_ task is
-	 * migration-disabled only when its migration_disabled count is greater
-	 * than one. In other words, when  p->migration_disabled == 1, there is
-	 * an ambiguity, so we should check if @p is the current task or not.
+	 * A slow path handles pre-v6.18 kernels without CONFIG_PREEMPT_RCU,
+	 * where the prolog historically called migrate_disable() unconditionally
+	 * but a cherry-picked downstream kernel may not. The runtime-probed flag
+	 * __scx_prolog_disables_migration (set by scx_lib_init()) distinguishes
+	 * the two cases without relying on the kernel version alone.
 	 */
 	if (bpf_core_field_exists(p->migration_disabled)) {
-		if (p->migration_disabled == 1)
-			return bpf_get_current_task_btf() != p;
-		else
-			return p->migration_disabled;
+		if (p->migration_disabled == 1) {
+			/* Fast path: prolog always disables migration */
+			if (CONFIG_PREEMPT_RCU)
+				return bpf_get_current_task_btf() != p;
+			/* Fast path: prolog never disables migration */
+			if (LINUX_KERNEL_VERSION >= KERNEL_VERSION(6, 18, 0))
+				return true;
+			/* Slow path: pre-v6.18, !PREEMPT_RCU - use runtime flag */
+			return __scx_prolog_disables_migration ?
+			       bpf_get_current_task_btf() != p : true;
+		}
+		return p->migration_disabled;
 	}
 	return false;
 }
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index c02b2aa6fc64..f8c5239a9637 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -16,6 +16,11 @@ struct {
 	__type(value, s32);
 } queue SEC(".maps");
 
+s32 BPF_STRUCT_OPS(dsp_local_on_init, bool autoload)
+{
+	return scx_lib_init();
+}
+
 s32 BPF_STRUCT_OPS(dsp_local_on_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -59,6 +64,7 @@ void BPF_STRUCT_OPS(dsp_local_on_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops dsp_local_on_ops = {
+	.init			= (void *) dsp_local_on_init,
 	.select_cpu		= (void *) dsp_local_on_select_cpu,
 	.enqueue		= (void *) dsp_local_on_enqueue,
 	.dispatch		= (void *) dsp_local_on_dispatch,
-- 
2.48.1

