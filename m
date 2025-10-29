Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04012F6190;
	Wed, 29 Oct 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762926; cv=none; b=qYg2YgxXv1PwptITQUcK4sxyGCRHfyi0d5h5xPw5ho33/7Hk13eBvMxFgkuGX0XFoJouD7nHiB3liHp9MJucHe8eHc36kCkjKf2U7GVxeXak5kgF2kcEx+CvRuNMDyUh/6gCpMRqubKZXhfjmJH8HvJnc34xqWaWJOp3IZeZ6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762926; c=relaxed/simple;
	bh=YqYFEM6sU+bVnLh0MCyQQXAhE49af6qZDocNaiAryLs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=uhb6Afr5e8d8Zgl0uSdC8aI1OpamiV8wXTJ2cJOaXUD+OJ99wOPLlJT7nelO5QR0AQyCEcHWqyZRmwPnjM87IUkKLnskKzWIlegqe9uVj20PvNZhxaOTzDCmVSIWcgqiKaG0ySwPZvToSEt/EbmbbPZm0PcOrsABgaLxCh7lgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQZ78YJs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQZ78YJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED39C4CEF7;
	Wed, 29 Oct 2025 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761762926;
	bh=YqYFEM6sU+bVnLh0MCyQQXAhE49af6qZDocNaiAryLs=;
	h=Date:From:To:Cc:Subject:From;
	b=rQZ78YJs5MlhgbzYsiaS2cNk0NCgJHmzItXQs1WX9ETnrSyeo/Sau0O70UAzqbeM+
	 8Op8DQgYZAFpB4iNEGHvkrFcxM//+aA3AjAl2tpvHoSm3XyY3XFD+eQTA2sdxzVFo1
	 wBLzaqCKSBF8p86qXaLqBuRx+5TZfGoI4mjAlBceKenqN2l0fBGcZgKgB21V/CZHsR
	 RgYD60X6tnszok9quI71YoPH7FTIynYbYRcut6Hym6quTmRuTYRctEJqVulhl5K0jU
	 Fg53sJgXxVxQ0qo3fXlQDXkCzrWmA/a+YTukCQRcfpP55H3As8gSoe5QgkOqndJ9nH
	 2J0MMvtHVoqGw==
Date: Wed, 29 Oct 2025 08:35:25 -1000
Message-ID: <33d319a7063f59638ae1be709f4e10e9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext/tools: Restore backward compat with v6.12 kernels
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Commit 111a79800aed ("tools/sched_ext: Strip compatibility macros for
cgroup and dispatch APIs") removed the compat layer for v6.12-v6.13 kfunc
renaming, but v6.12 is the current LTS kernel and will remain supported
through 2026. Restore backward compatibility so schedulers built with v6.19+
headers can run on v6.12 kernels.

The restored compat differs from the original in two ways:

1. Uses ___new/___old suffixes instead of ___compat for clarity. The new
   macros check for v6.13+ names (scx_bpf_dsq_move*), fall back to v6.12
   names (scx_bpf_dispatch_from_dsq*, scx_bpf_consume), then return safe
   no-ops for missing symbols.

2. Integrates with the args-struct-packing changes added in c0d630ba347c
   ("sched_ext: Wrap kfunc args in struct to prepare for aux__prog").
   scx_bpf_dsq_insert_vtime() now tries __scx_bpf_dsq_insert_vtime (args
   struct), then scx_bpf_dsq_insert_vtime___compat (v6.13-v6.18), then
   scx_bpf_dispatch_vtime___compat (pre-v6.13).

Forward compatibility is not restored - binaries built against v6.13 or
earlier headers won't run on v6.19+ kernels, as the old kfunc names are not
exported. This is acceptable since the priority is new binaries running on
older kernels.

Also add missing compat checks for ops.cgroup_set_bandwidth() (added v6.17)
and ops.cgroup_set_idle() (added v6.19). These need to be NULLed out in
userspace on older kernels.

Reported-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/common.bpf.h |    6 --
 tools/sched_ext/include/scx/compat.bpf.h |   81 ++++++++++++++++++++++++++++++-
 tools/sched_ext/include/scx/compat.h     |   14 +++++
 3 files changed, 93 insertions(+), 8 deletions(-)

--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -65,11 +65,6 @@ s32 __scx_bpf_select_cpu_and(struct task
 bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
-bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
-void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
-void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
-bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
-bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
@@ -104,7 +99,6 @@ s32 scx_bpf_task_cpu(const struct task_s
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
-struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -15,6 +15,68 @@
 	__ret;									\
 })
 
+/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
+struct cgroup *scx_bpf_task_cgroup___new(struct task_struct *p) __ksym __weak;
+
+#define scx_bpf_task_cgroup(p)							\
+	(bpf_ksym_exists(scx_bpf_task_cgroup___new) ?				\
+	 scx_bpf_task_cgroup___new((p)) : NULL)
+
+/*
+ * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs are
+ * renamed to unload the verb.
+ *
+ * Build error is triggered if old names are used. New binaries work with both
+ * new and old names. The compat macros will be removed on v6.15 release.
+ *
+ * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
+ * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
+ */
+bool scx_bpf_dsq_move_to_local___new(u64 dsq_id) __ksym __weak;
+void scx_bpf_dsq_move_set_slice___new(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dsq_move_set_vtime___new(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
+bool scx_bpf_dsq_move___new(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_move_vtime___new(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+
+bool scx_bpf_consume___old(u64 dsq_id) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_slice___old(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_vtime___old(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
+bool scx_bpf_dispatch_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+
+#define scx_bpf_dsq_move_to_local(dsq_id)					\
+	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___new) ?			\
+	 scx_bpf_dsq_move_to_local___new((dsq_id)) :				\
+	 scx_bpf_consume___old((dsq_id)))
+
+#define scx_bpf_dsq_move_set_slice(it__iter, slice)				\
+	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice___new) ?			\
+	 scx_bpf_dsq_move_set_slice___new((it__iter), (slice)) :		\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___old) ?		\
+	  scx_bpf_dispatch_from_dsq_set_slice___old((it__iter), (slice)) :	\
+	  (void)0))
+
+#define scx_bpf_dsq_move_set_vtime(it__iter, vtime)				\
+	(bpf_ksym_exists(scx_bpf_dsq_move_set_vtime___new) ?			\
+	 scx_bpf_dsq_move_set_vtime___new((it__iter), (vtime)) :		\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___old) ?		\
+	  scx_bpf_dispatch_from_dsq_set_vtime___old((it__iter), (vtime)) :	\
+	  (void)0))
+
+#define scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)			\
+	(bpf_ksym_exists(scx_bpf_dsq_move___new) ?				\
+	 scx_bpf_dsq_move___new((it__iter), (p), (dsq_id), (enq_flags)) :	\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___old) ?			\
+	  scx_bpf_dispatch_from_dsq___old((it__iter), (p), (dsq_id), (enq_flags)) : \
+	  false))
+
+#define scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags)			\
+	(bpf_ksym_exists(scx_bpf_dsq_move_vtime___new) ?			\
+	 scx_bpf_dsq_move_vtime___new((it__iter), (p), (dsq_id), (enq_flags)) : \
+	 (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___old) ?		\
+	  scx_bpf_dispatch_vtime_from_dsq___old((it__iter), (p), (dsq_id), (enq_flags)) : \
+	  false))
+
 /*
  * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
  *
@@ -166,12 +228,16 @@ static inline struct task_struct *__COMP
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
  * provided to maintain source compatibility.
  *
+ * v6.13: scx_bpf_dsq_insert_vtime() renaming is also handled here. See the
+ * block on dispatch renaming above for more details.
+ *
  * The kernel will carry the compat variants until v6.23 to maintain binary
  * compatibility. After v6.23 release, remove the compat handling and move the
  * wrappers to common.bpf.h.
  */
 s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
+void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 
 /**
@@ -227,10 +293,14 @@ scx_bpf_dsq_insert_vtime(struct task_str
 		};
 
 		return __scx_bpf_dsq_insert_vtime(p, &args);
-	} else {
+	} else if (bpf_ksym_exists(scx_bpf_dsq_insert_vtime___compat)) {
 		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
 						  enq_flags);
 		return true;
+	} else {
+		scx_bpf_dispatch_vtime___compat(p, dsq_id, slice, vtime,
+						enq_flags);
+		return true;
 	}
 }
 
@@ -239,18 +309,25 @@ scx_bpf_dsq_insert_vtime(struct task_str
  * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
  * The extra ___compat suffix is to work around libbpf not ignoring __SUFFIX on
  * kernel side. The entire suffix can be dropped later.
+ *
+ * v6.13: scx_bpf_dsq_insert() renaming is also handled here. See the block on
+ * dispatch renaming above for more details.
  */
 bool scx_bpf_dsq_insert___v2___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert___v1(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 
 static inline bool
 scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
 {
 	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2___compat)) {
 		return scx_bpf_dsq_insert___v2___compat(p, dsq_id, slice, enq_flags);
-	} else {
+	} else if (bpf_ksym_exists(scx_bpf_dsq_insert___v1)) {
 		scx_bpf_dsq_insert___v1(p, dsq_id, slice, enq_flags);
 		return true;
+	} else {
+		scx_bpf_dispatch___compat(p, dsq_id, slice, enq_flags);
+		return true;
 	}
 }
 
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -151,6 +151,10 @@ static inline long scx_hotplug_seq(void)
  *
  * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
  * the current minimum required kernel version.
+ *
+ * COMPAT:
+ * - v6.17: ops.cgroup_set_bandwidth()
+ * - v6.19: ops.cgroup_set_idle()
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
@@ -162,6 +166,16 @@ static inline long scx_hotplug_seq(void)
 	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
 	__skel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();		\
 	SCX_ENUM_INIT(__skel);							\
+	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
+		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
+		__skel->struct_ops.__ops_name->cgroup_set_bandwidth = NULL;	\
+	}									\
+	if (__skel->struct_ops.__ops_name->cgroup_set_idle &&			\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_idle")) { \
+		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_idle()\n"); \
+		__skel->struct_ops.__ops_name->cgroup_set_idle = NULL;	\
+	}									\
 	__skel; 								\
 })
 
