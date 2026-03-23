Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A433C5DB2
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286520; cv=none; b=HtWNBqckvu6JjZ/gfd1LKizMQkCGvnMBd0fG6dr4jUSqyNdt10mKSlTYZQFek9C4i+yPWRxjec6SyQAhyryC5pwyli0/Jsf6wkmg4W4BmVhG1ZKpCMXuP9szrA93KOo1mMD+eCqgs4+zEeLyS+BysA3+cIitLb4wCiMblWVGOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286520; c=relaxed/simple;
	bh=hCvHf3Nr7PkJ8IeR0WMorR0k2cswI8Soc6xmRviuVlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf2ZnMerLIIVYHR/8wb73QqdfHJZvnxsRZNZDJeTdK/Y4gZxkd4On1dbhg9UGDBiuT5nv4zGxANkDZIqgzADxBN5slPVt9PXx8tMfLfgjeUUSaO/NqLtOxStSALERwQpTsL9o1SEAZYM1n7dbeQYSjkd4rArf6DYun38AICu5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJo/UyWI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJo/UyWI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2890479a91.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774286518; x=1774891318; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7meqAHrvnNT1fXMzNiz1ICYl4tvDc8rvMGtiyMCXf6A=;
        b=IJo/UyWI0TjTwnHWzlRjppjJyqNXbzsUohSO1W8odlZNEQ+MG8dCOPqsrA7Vw7Hqvk
         qNtx1TKLPquJhd/1Q26wd8Sr0ljeIK60WfcXaCihVkE5BgdtS25NjM4lg5r++hDcNV3+
         9O+W+k4Y3pggujU7RPIq+rvzMWus4fc5j/yLRT3WzHQhSVVc7APbIqhuVvQ0A+ZNA7BJ
         t4/ZYGevg5DSBpT7hAYQdalMUOJEmdmjnPxGk2HkYt6o+koycnkNhwdY4FxOj0+PQK0/
         00DJLguPQQ9K/1C2c2N2Uevh4VUf5W9jJqtXTcyzbVpcxE07jTqq8KFLQ9wDaG7LMXGg
         WBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286518; x=1774891318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7meqAHrvnNT1fXMzNiz1ICYl4tvDc8rvMGtiyMCXf6A=;
        b=KLkKsmWXhDBqtYJx0/t255QGXX0LrgEqTPqFd6eZG1aRolBNBMjy7qI9lXEeWZHk5q
         SyOLbVxOIV8aAA2j+57/gm2OhYsiLVcrw04Tu+5oGL6+ms0fS7icI04Cg9JPcr3e7XRd
         RtBY/vp6oTDEmPoyp2aXYXKx91TEdYPUwOwUaw3usuTP/iAlPlDlGUNdY28ibqyRkWhw
         ArYO6joQ/u0RGXYKZSj4qNgLl6xypshrGUS+WaMDykjXYpQtk69rYs78vn6+1C8l+DdE
         9rI9dP3B3srbDzNIzSvfEICUgI1aws/+C6EB2fmqG7uIB+A4OpElzlyuA/G9+H9d0Dag
         vlVQ==
X-Gm-Message-State: AOJu0Yw2UWx6atW4VusV/sgavfisOP8yZOFhm117Tr/saOw/+iIYwXoN
	Z7sOS3lEWmuV7rj3Q6V9yStnvLHq7lkbxrsLoeLKQbPyrrIHNl/MwR1MXDalzVtS
X-Gm-Gg: ATEYQzy8rJXMLvPKWuxZAlqBlJazOET4wnMU9DOtnrOxlZ3HObDiO15r5CEL7qzrKeX
	izaWutPDOulT9+7k76o/Z0FaQDLl5tZpeJJkbGYErrYKGArs/+K20/KoLxSROmIyD016kdia5iZ
	YSDYCLyo+Gq6+02zGf8gAQBbvtDfY6Mdpg2MBWJ3HEy3sC5Cds7aALz9LIYaQ5uqtHJiDRONQSB
	5zJV0jTtQTCbfYUHKB91gtIBt6F7LjArV6aDyxjzAsYnfPrf/CFIbodjACY9RPetLQ9AUAUJcX0
	zuR467svPTOLYuo4NPsvApuzyfhEtTceUehHqGvbIfBzNh1wDpsRrE+Z4bBt1wtLaGzVCfVYFrx
	W5SaZjv+/RarZhOMvRV20m0FNUj2amQ5Plr6NOCaCilNL6W+cXqkiUA4Pm+yJRKQqmLxzCqsxOD
	JzySJKHENKc+aDFQ2xuth/r0mJHOjGmgfPX3ILH5i7n838H6dFWhjK
X-Received: by 2002:a17:90b:3b81:b0:35b:9ab6:1d51 with SMTP id 98e67ed59e1d1-35bd2cfeb8dmr10466401a91.24.1774286517732;
        Mon, 23 Mar 2026 10:21:57 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm13552672a91.14.2026.03.23.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:21:57 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/3] tools/sched_ext: Remove __COMPAT prefix from compat.bpf.h wrappers
Date: Tue, 24 Mar 2026 01:21:28 +0800
Message-ID: <20260323172145.25689-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260323172145.25689-1-yphbchou0911@gmail.com>
References: <20260323172145.25689-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert __COMPAT prefix kfunc wrappers to transparent static inline
functions using the ___compat suffix pattern, so schedulers can call
them directly without needing to know about compat details.

Transparent kfunc wrappers:
- bpf_cpumask_populate
- scx_bpf_dsq_peek
- scx_bpf_events
- scx_bpf_nr_node_ids, scx_bpf_cpu_node
- scx_bpf_get_idle_cpumask_node, scx_bpf_get_idle_smtmask_node
- scx_bpf_pick_idle_cpu_node, scx_bpf_pick_any_cpu_node
- scx_bpf_cpu_curr

Each function is declared with a ___compat suffix as __ksym __weak so
libbpf resolves it to the kernel's original symbol. The static inline
wrapper checks bpf_ksym_exists() and falls back gracefully on older
kernels. The corresponding __ksym __weak declarations are removed from
common.bpf.h.

Helper renames:
- __COMPAT_is_enq_cpu_selected -> scx_bpf_is_enq_cpu_selected
- __COMPAT_HAS_scx_bpf_select_cpu_and -> scx_bpf_has_select_cpu_and
- __COMPAT_has_generic_reenq -> scx_bpf_has_generic_reenq
- __COMPAT_scx_bpf_reenqueue_local_from_anywhere: inlined into
  scx_bpf_reenqueue_local(), removing the separate helper

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h |   9 --
 tools/sched_ext/include/scx/compat.bpf.h | 139 ++++++++++++++---------
 2 files changed, 83 insertions(+), 65 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index a63a98a96b86..ce35944fb86f 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -68,7 +68,6 @@ void scx_bpf_dispatch_cancel(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
-struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
@@ -78,29 +77,21 @@ void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym
 u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
-u32 scx_bpf_nr_node_ids(void) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
-int scx_bpf_cpu_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
-const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
-const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
-s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
-s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
-struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
-void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 bool scx_bpf_sub_dispatch(u64 cgroup_id) __ksym __weak;
 
 /*
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 83b3425e63b2..b63c268ab5b9 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -82,26 +82,31 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, st
 /*
  * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
  *
- * Compat macro will be dropped on v6.19 release.
+ * Preserve until v6.19.
  */
-int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
+int bpf_cpumask_populate___compat(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
-#define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
-	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
-	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
+static inline int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz)
+{
+	if (bpf_ksym_exists(bpf_cpumask_populate___compat))
+		return bpf_cpumask_populate___compat(dst, src, src__sz);
+	return -EOPNOTSUPP;
+}
 
 /*
  * v6.19: Introduce lockless peek API for user DSQs.
  *
- * Preserve the following macro until v6.21.
+ * Preserve until v6.21.
  */
-static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
+struct task_struct *scx_bpf_dsq_peek___compat(u64 dsq_id) __ksym __weak;
+
+static inline struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
 {
 	struct task_struct *p = NULL;
 	struct bpf_iter_scx_dsq it;
 
-	if (bpf_ksym_exists(scx_bpf_dsq_peek))
-		return scx_bpf_dsq_peek(dsq_id);
+	if (bpf_ksym_exists(scx_bpf_dsq_peek___compat))
+		return scx_bpf_dsq_peek___compat(dsq_id);
 	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
 		p = bpf_iter_scx_dsq_next(&it);
 	bpf_iter_scx_dsq_destroy(&it);
@@ -109,14 +114,14 @@ static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
 }
 
 /**
- * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
- * in a compatible way. We will preserve this __COMPAT helper until v6.16.
+ * scx_bpf_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
+ * in a compatible way. Preserve until v6.16.
  *
  * @enq_flags: enqueue flags from ops.enqueue()
  *
  * Return: True if SCX_ENQ_CPU_SELECTED is turned on in @enq_flags
  */
-static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
+static inline bool scx_bpf_is_enq_cpu_selected(u64 enq_flags)
 {
 #ifdef HAVE_SCX_ENQ_CPU_SELECTED
 	/*
@@ -168,57 +173,84 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 /*
  * v6.15: Introduce event counters.
  *
- * Preserve the following macro until v6.17.
+ * Preserve until v6.17.
  */
-#define __COMPAT_scx_bpf_events(events, size)					\
-	(bpf_ksym_exists(scx_bpf_events) ?					\
-	 scx_bpf_events(events, size) : ({}))
+void scx_bpf_events___compat(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
+
+static inline void scx_bpf_events(struct scx_event_stats *events, size_t events__sz)
+{
+	if (bpf_ksym_exists(scx_bpf_events___compat))
+		scx_bpf_events___compat(events, events__sz);
+}
 
 /*
  * v6.15: Introduce NUMA-aware kfuncs to operate with per-node idle
  * cpumasks.
  *
- * Preserve the following __COMPAT_scx_*_node macros until v6.17.
+ * Preserve until v6.17.
  */
-#define __COMPAT_scx_bpf_nr_node_ids()						\
-	(bpf_ksym_exists(scx_bpf_nr_node_ids) ?					\
-	 scx_bpf_nr_node_ids() : 1U)
-
-#define __COMPAT_scx_bpf_cpu_node(cpu)						\
-	(bpf_ksym_exists(scx_bpf_cpu_node) ?					\
-	 scx_bpf_cpu_node(cpu) : 0)
-
-#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)				\
-	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?			\
-	 scx_bpf_get_idle_cpumask_node(node) :					\
-	 scx_bpf_get_idle_cpumask())						\
-
-#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)				\
-	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?			\
-	 scx_bpf_get_idle_smtmask_node(node) :					\
-	 scx_bpf_get_idle_smtmask())
-
-#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
-	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
-	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
-	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
-
-#define __COMPAT_scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags)		\
-	(bpf_ksym_exists(scx_bpf_pick_any_cpu_node) ?				\
-	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
-	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
+u32 scx_bpf_nr_node_ids___compat(void) __ksym __weak;
+int scx_bpf_cpu_node___compat(s32 cpu) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_cpumask_node___compat(int node) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_smtmask_node___compat(int node) __ksym __weak;
+s32 scx_bpf_pick_idle_cpu_node___compat(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
+s32 scx_bpf_pick_any_cpu_node___compat(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
+
+static inline u32 scx_bpf_nr_node_ids(void)
+{
+	return bpf_ksym_exists(scx_bpf_nr_node_ids___compat) ?
+	       scx_bpf_nr_node_ids___compat() : 1U;
+}
+
+static inline int scx_bpf_cpu_node(s32 cpu)
+{
+	return bpf_ksym_exists(scx_bpf_cpu_node___compat) ?
+	       scx_bpf_cpu_node___compat(cpu) : 0;
+}
+
+static inline const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	return bpf_ksym_exists(scx_bpf_get_idle_cpumask_node___compat) ?
+	       scx_bpf_get_idle_cpumask_node___compat(node) :
+	       scx_bpf_get_idle_cpumask();
+}
+
+static inline const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	return bpf_ksym_exists(scx_bpf_get_idle_smtmask_node___compat) ?
+	       scx_bpf_get_idle_smtmask_node___compat(node) :
+	       scx_bpf_get_idle_smtmask();
+}
+
+static inline s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
+					     int node, u64 flags)
+{
+	return bpf_ksym_exists(scx_bpf_pick_idle_cpu_node___compat) ?
+	       scx_bpf_pick_idle_cpu_node___compat(cpus_allowed, node, flags) :
+	       scx_bpf_pick_idle_cpu(cpus_allowed, flags);
+}
+
+static inline s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
+					    int node, u64 flags)
+{
+	return bpf_ksym_exists(scx_bpf_pick_any_cpu_node___compat) ?
+	       scx_bpf_pick_any_cpu_node___compat(cpus_allowed, node, flags) :
+	       scx_bpf_pick_any_cpu(cpus_allowed, flags);
+}
 
 /*
  * v6.18: Add a helper to retrieve the current task running on a CPU.
  *
- * Keep this helper available until v6.20 for compatibility.
+ * Preserve until v6.20 for compatibility.
  */
-static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
+struct task_struct *scx_bpf_cpu_curr___compat(s32 cpu) __ksym __weak;
+
+static inline struct task_struct *scx_bpf_cpu_curr(s32 cpu)
 {
 	struct rq *rq;
 
-	if (bpf_ksym_exists(scx_bpf_cpu_curr))
-		return scx_bpf_cpu_curr(cpu);
+	if (bpf_ksym_exists(scx_bpf_cpu_curr___compat))
+		return scx_bpf_cpu_curr___compat(cpu);
 
 	rq = scx_bpf_cpu_rq(cpu);
 
@@ -275,7 +307,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
  * scx_bpf_select_cpu_and() is now an inline wrapper. Use this instead of
  * bpf_ksym_exists(scx_bpf_select_cpu_and) to test availability.
  */
-#define __COMPAT_HAS_scx_bpf_select_cpu_and				\
+#define scx_bpf_has_select_cpu_and					\
 	(bpf_core_type_exists(struct scx_bpf_select_cpu_and_args) ||	\
 	 bpf_ksym_exists(scx_bpf_select_cpu_and___compat))
 
@@ -375,14 +407,9 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
 void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
 
-static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
-{
-	return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
-}
-
 static inline void scx_bpf_reenqueue_local(void)
 {
-	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+	if (bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat))
 		scx_bpf_reenqueue_local___v2___compat();
 	else
 		scx_bpf_reenqueue_local___v1();
@@ -394,7 +421,7 @@ static inline void scx_bpf_reenqueue_local(void)
  */
 void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
 
-static inline bool __COMPAT_has_generic_reenq(void)
+static inline bool scx_bpf_has_generic_reenq(void)
 {
 	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
 }
-- 
2.48.1

