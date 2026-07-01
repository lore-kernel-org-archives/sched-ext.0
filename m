Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7223F0AA8
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897607; cv=none; b=JBJO1jbPsVtcxggSeuTM0re7++BQHUd9+HKmYJxTxnWQ8VFxxAc/qhIa/9dXXi0n+SQ3Q6u2ymV10949zmEr+rWc4wJgpmeGn+Mtam7QO4DDez/XGDZd30uHLYqXFIPSHT6K6pEFg4QSKeM6dwne4KW6AxhKKW3ny66ZFzJZn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897607; c=relaxed/simple;
	bh=7P+u0ve+4pTAQ3JWDmumCDHsnrmWBaIf1JwfEVKSINo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN0NRx24TABfJEomow+bZRNyTHJ8ftUnUbL/05qQErsV/Sro4QKy21T0pK+cNfrQreIE4cBtWeXVk/qI0g5WHL8IVM+U/setYkqG23y2qPnUrilTcRujKiz+624sVhv2MtsSOgW3+qmLFaOhEqINP+VQylWFLGArANH/ayE13Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZIakNla; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZIakNla"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37fb434c547so275492a91.0
        for <sched-ext@lists.linux.dev>; Wed, 01 Jul 2026 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782897603; x=1783502403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=737f7Ebbsrst7YTIEUi1Ot0TEsMTGrl0n4PwgIjxMgU=;
        b=gZIakNlaU5mmPgYun8JukA+osGdf5k7oiyOO6P1rlrc6lpVZOKR2+b73311BAEA1ru
         O1QH6hAeLjbOvQSckTGXDubzVIq9YhiCwrBQcKAsZHojAxUgyO2k4aldJIYRBG+NmHJz
         g+Q79MNyX+nFRyW8/bm4NRn5VywNd7zm04dCNUr/Hj3zR1HGSwIt6vaMmj5JyCnG/HW4
         n0RNKajyG4EmBX6EIB4GbdeFjie8xXtD/W25Fzwg3P65HPmhIkl+lAgxGkuK3oqx16RH
         nZoDNl68ufNfoOBAOSw4HhRdHZE3UwLAnsgrcCTeU9/XEznbEC5zeeiCS5dWQdoZ2K/d
         gdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782897603; x=1783502403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=737f7Ebbsrst7YTIEUi1Ot0TEsMTGrl0n4PwgIjxMgU=;
        b=pLO7w3551c9lHmkNUC4R67tfBh08seI+4CasSgLSjG6IHBKHxSIe5QEJWdyB8fFS73
         pC/2owyXLV3rhSTlRgpBBBI7Tj5ME4qK2XQNNj8cMWFcVCnb1upOgJuJdhJKCKmjB3Nb
         XDVrRszURRXEwLlR+NaKIYbwxlFBgY2rC1QmGccsEDqhagK7W6CI96OdvuXOaLolvqB4
         4xWDaUGPudYEqIrkkiE7Kp6aqecwDSS1uSQpkVgBnhoi2Le04lvAGAwvm9buRl1QRzz2
         QTgOyCQervLJDGkUphAlIoqGgo5pRY9LIBpHMLbAophpE7ILArUGrdtXRCgtADVVLck5
         Msvg==
X-Forwarded-Encrypted: i=1; AHgh+Ro04TSfvYjSCQBGzlk7NgzR3Kq5W4vOT3mRZqPxTHCw2/vnXdfV4PpcDwBcuthCCUu+uXKXCoYjt1Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2qepvjCSw6lCKQyvgV/Qupz6RueBG0/YmAda8ddDNWsGPFuu2
	MihOLoLAbZWZMBcXNqLQJb49MbMOeNF4Hm3i7x6jSP9OE0OHv7CIZs96
X-Gm-Gg: AfdE7ckepg1bU8wzog4EqTbkLHIpjPrFUqnv26FBlboXPitEKDhjqcnuw7PpVL5FrOc
	HbFCWzSXndKBXAR3Gyaal8Mx/bzdXRE7a4YgNCxUn46rKHgAYWQALFyYdIHa3SSy312dprS35Qn
	NCY8qSV7nDsUZKfEqvKCAsPCPTUMGtTwn7RnSsblt38Y35VO9JvOK7FdKNF79utWwCIZgA2LkV9
	uU/EIv3Z5Knd3ekKI4ce+Yxt993d+byRMOcEZeSo60fXm12cuJg7YyQl6WPgwQlHfWReb8mTdau
	Rc4ADAZjs06xOpTWRc6mC6RLW2BauIvpt8JcPT6x+/bPLZoAmQy8WfYhYFrTvyYKKESj/8cR8+0
	cUomB93JVeNuY5w6AD7hOFWT+cx+xG0DgbKELJKveg8Up0Cl7Pbqh9m2JwO4JhoCT2B7SP4nnVp
	N08sd0tzpXV1kKsEJaytNdRGA7kg0bkZTZ7wkSEd7v9ECPjaTwdrkNvARj8PolZFboYQ==
X-Received: by 2002:a17:90b:28c4:b0:37f:9ce2:348c with SMTP id 98e67ed59e1d1-380aa2078admr873524a91.29.1782897603321;
        Wed, 01 Jul 2026 02:20:03 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809645185dsm1457000a91.15.2026.07.01.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:20:02 -0700 (PDT)
From: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: zhidao su <soolaugust@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	zhidao su <suzhidao@xiaomi.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: Reject task setter kfuncs outside SCX contexts
Date: Wed,  1 Jul 2026 17:19:54 +0800
Message-ID: <20260701091954.384565-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() mutate
sched_ext task state and rely on scx_prog_sched() and
scx_task_on_sched() to validate the calling scheduler's authority over
the target task.

However, the kfuncs were part of scx_kfunc_ids_any. That set is also
registered for tracing and syscall programs and the verifier-time
context filter allows any-set kfuncs from non-STRUCT_OPS program types.
As a result, a non-SCX tracing program can load after calling the task
setter wrappers, reaching the mutator kfuncs outside an SCX scheduler
context.

Split the task setter kfuncs into their own filtered kfunc set. Register
that set for STRUCT_OPS, TRACING, and SYSCALL so the verifier can find
the kfuncs, but let scx_kfunc_context_filter() reject them outside SCX
struct_ops contexts. SCX schedulers can still call the setters, and the
existing runtime task authority checks remain in place.

Add a negative sched_ext selftest which tries to call both task setter
kfuncs from a tracing program. The test fails before this change because
the program loads successfully, and passes after this change because the
verifier rejects the task setter call.

Signed-off-by: zhidao su (Xiaomi) <soolaugust@gmail.com>

---
Validation:
- Before fix: task_setter_kfunc_deny failed because non-SCX BPF loaded after calling task setter kfuncs
- After fix: runner -t task_setter_kfunc_deny passed (PASSED=1 FAILED=0)
- checkpatch --strict: 0 errors, 1 warning (MAINTAINERS new-file prompt), 0 checks

 kernel/sched/ext.c                                      | 24 ++++++++++++++++++------
 tools/testing/selftests/sched_ext/Makefile              |  1 +
 tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c | 17 +++++++++++++++++
 tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b8dd3358959d..257ffaca45f6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10254,9 +10254,12 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(scx_kfunc_ids_any)
+BTF_KFUNCS_START(scx_kfunc_ids_task_setter)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_KFUNCS_END(scx_kfunc_ids_task_setter)
+
+BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
@@ -10299,6 +10302,12 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
 #endif
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+static const struct btf_kfunc_id_set scx_kfunc_set_task_setter = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_task_setter,
+	.filter			= scx_kfunc_context_filter,
+};
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
@@ -10408,13 +10417,14 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
+	bool in_task_setter = btf_id_set8_contains(&scx_kfunc_ids_task_setter, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
 	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
 	if (!(in_unlocked || in_init || in_select_cpu || in_enqueue || in_dispatch ||
-	      in_cpu_release || in_idle || in_any))
+	      in_cpu_release || in_idle || in_task_setter || in_any))
 		return 0;
 
 	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
@@ -10457,7 +10467,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return -EACCES;
 
 	/* SCX struct_ops: check the per-op allow list. */
-	if (in_any || in_idle)
+	if (in_any || in_idle || in_task_setter)
 		return 0;
 
 	moff = prog->aux->attach_st_ops_member_off;
@@ -10572,6 +10582,12 @@ static int __init scx_init(void)
 					     &scx_kfunc_set_unlocked)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					     &scx_kfunc_set_unlocked)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_task_setter)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					     &scx_kfunc_set_task_setter)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					     &scx_kfunc_set_task_setter)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e91..000000000000 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -176,6 +176,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	non_scx_kfunc_deny		\
+	task_setter_kfunc_deny		\
 	numa				\
 	allowed_cpus			\
 	peek_dsq			\
diff --git a/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c
new file mode 100644
index 000000000000..79b619a3445f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that non-SCX programs cannot call task-mutating SCX kfuncs.
+ */
+
+#include <scx/common.bpf.h>
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(non_scx_task_setter, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned int prev_state)
+{
+	scx_bpf_task_set_slice(next, 1000000);
+	scx_bpf_task_set_dsq_vtime(next, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c
new file mode 100644
index 000000000000..1450a7133a5c
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that task-mutating SCX kfuncs are rejected outside SCX contexts.
+ */
+
+#include <bpf/libbpf.h>
+#include <stdarg.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <string.h>
+#include "scx_test.h"
+#include "task_setter_kfunc_deny.bpf.skel.h"
+
+static char verifier_log[8192];
+static size_t verifier_log_pos;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && verifier_log_pos < sizeof(verifier_log)) {
+		int ret = vsnprintf(verifier_log + verifier_log_pos,
+				  sizeof(verifier_log) - verifier_log_pos, format, args);
+
+		if (ret > 0)
+			verifier_log_pos += ret;
+	}
+
+	return 0;
+}
+
+static bool expected_rejection_seen(void)
+{
+	return strstr(verifier_log, "scx_bpf_task_set_slice") ||
+	       strstr(verifier_log, "scx_bpf_task_set_dsq_vtime");
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct task_setter_kfunc_deny *skel;
+	libbpf_print_fn_t old_libbpf_print_fn;
+	int err;
+
+	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
+	verifier_log[0] = '\0';
+	verifier_log_pos = 0;
+
+	skel = task_setter_kfunc_deny__open();
+	if (!skel) {
+		SCX_ERR("Failed to open skel");
+		libbpf_set_print(old_libbpf_print_fn);
+		return SCX_TEST_FAIL;
+	}
+
+	err = task_setter_kfunc_deny__load(skel);
+	task_setter_kfunc_deny__destroy(skel);
+	libbpf_set_print(old_libbpf_print_fn);
+
+	if (!err) {
+		SCX_ERR("non-SCX BPF program loaded after calling task setter kfuncs");
+		return SCX_TEST_FAIL;
+	}
+
+	if (!expected_rejection_seen()) {
+		SCX_ERR("load failed without expected sched_ext task setter rejection: %s",
+			verifier_log);
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test task_setter_kfunc_deny = {
+	.name = "task_setter_kfunc_deny",
+	.description = "Verify non-SCX programs cannot call SCX task setter kfuncs",
+	.run = run,
+};
+
+REGISTER_SCX_TEST(&task_setter_kfunc_deny)
