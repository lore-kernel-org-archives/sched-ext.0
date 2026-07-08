Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94640680A;
	Wed,  8 Jul 2026 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545913; cv=none; b=rO0OllOU02I792jKIXDPeUz8vCC5Hj7YOl8VcJyW8jnECYuQ06XlK8wAVmWG8ekRHLS4wU9SgxotbZezcOGd2wti7ZB5LYgDaQPzxdU06KtIn554qBLzvbcsP0GykQSw8U01vJ/k0Gg/LW8Ghl2ef634JQoELx8eXDeki6AcTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545913; c=relaxed/simple;
	bh=Fu+IadO94lQQ+cpjtcbvqZUkVLDmbF/MCEvhwgHgqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRm0sDad2TtY74yiPazOl+uJ2lsw5Jl+8tpRv6cwG/znnDin4ivWKvDLpu6090BjBTFAccPUVFwyTFX0F1vDRaKilvwlWbDrbnilzqdLYmv7jvgyLh0WU7zJaDVnybrwp9I7j9Z/z4AD5Fz4UNM173Alcd0Xgyr4+SCOIHKbcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxuPJ5GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxuPJ5GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DF81F00A3A;
	Wed,  8 Jul 2026 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545911;
	bh=BUQIHi222qS2UdQyTiiyHTekGTsCB9gXVFzqCThObh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxuPJ5GDqwrVAzac0anuR9HkDSnnQqy3NAVAJoJz6A/Ama+7k8/NwT5UusQ8cLknY
	 WONjkfk3xXCWuad14LYIHydHRYzHuuFKhacb7gPQkxRWw6WPG/sU1PQw4wMsj0QzT+
	 uNuzE9fNTHFy61Y76CMk2fCGJEUW+Au9OvKhw7wuryx9jgu4ZJ11yNypzZjgLdY7mt
	 rfOHkY7rKv0KNSIklRD7msy5T838mba5cT3GCyxB8f2c0I0FF9FDfIGKd83uBKO9fu
	 79JwjvUx7urmPRbllebNi81S/F1SvACfor5ip0RToJX8SgyrcrCXRgRdKcwjH2lf9T
	 fHyzwv3GSa6Sw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 37/40] sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
Date: Wed,  8 Jul 2026 11:24:26 -1000
Message-ID: <20260708212429.3405787-38-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cid-form scheduler can grant caps to and revoke them from its child
sub-schedulers but has no way to tear one down. Add scx_bpf_sub_kill() to
evict a direct child with a printf-style reason that reaches the child's
scx_exit_info. No exit code is taken because the child is a separate
scheduler whose exit-code semantics the parent cannot know. The child and
its subtree are disabled through the usual async path under a new exit kind,
SCX_EXIT_PARENT_KILL.

The bstr formatting infrastructure in ext.c is exposed through internal.h
with scx_ prefixes so the kfunc, which lives in sub.c, can format the
reason.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   | 28 +++++++-----
 kernel/sched/ext/internal.h              | 11 +++++
 kernel/sched/ext/sub.c                   | 57 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h | 18 ++++++++
 4 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 44622dcc8b4f..5c9cd3682f08 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -187,14 +187,8 @@ static const struct rhashtable_params dsq_hash_params = {
 
 static LLIST_HEAD(dsqs_to_free);
 
-/* string formatting from BPF */
-struct scx_bstr_buf {
-	u64			data[MAX_BPRINTF_VARARGS];
-	char			line[SCX_EXIT_MSG_LEN];
-};
-
-static DEFINE_RAW_SPINLOCK(scx_exit_bstr_buf_lock);
-static struct scx_bstr_buf scx_exit_bstr_buf;
+DEFINE_RAW_SPINLOCK(scx_exit_bstr_buf_lock);
+struct scx_bstr_buf scx_exit_bstr_buf;
 
 /* ops debug dump */
 static DEFINE_RAW_SPINLOCK(scx_dump_lock);
@@ -5714,6 +5708,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "disabled by sysrq-S";
 	case SCX_EXIT_PARENT:
 		return "parent exiting";
+	case SCX_EXIT_PARENT_KILL:
+		return "killed by parent scheduler";
 	case SCX_EXIT_ERROR:
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
@@ -9331,8 +9327,8 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 }
 
 __printf(3, 0)
-static s32 bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
-		       char *fmt, unsigned long long *data, u32 data__sz)
+s32 scx_bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
+		    char *fmt, unsigned long long *data, u32 data__sz)
 {
 	return __bstr_format(sch, buf->data, buf->line, sizeof(buf->line),
 			     fmt, data, data__sz);
@@ -9362,7 +9358,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
 	sch = scx_prog_sched(aux);
 	if (likely(sch) &&
-	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_exit(sch, SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -9387,7 +9383,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
 	sch = scx_prog_sched(aux);
 	if (likely(sch) &&
-	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_exit(sch, SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
@@ -10023,6 +10019,13 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
 {
 	return -EOPNOTSUPP;
 }
+
+__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
+				      unsigned long long *data, u32 data__sz,
+				      const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* !CONFIG_EXT_SUB_SCHED */
 
 __bpf_kfunc_end_defs();
@@ -10072,6 +10075,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_sub_grant, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_revoke, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_caps, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_sub_kill_bstr, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a6283a8fd9fd..0a21891508bd 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -51,6 +51,7 @@ enum scx_exit_kind {
 	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
 	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
 	SCX_EXIT_PARENT,	/* parent exiting */
+	SCX_EXIT_PARENT_KILL,	/* killed by parent scheduler */
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
@@ -1875,6 +1876,12 @@ struct scx_enable_cmd {
 	int			ret;
 };
 
+/* string formatting from BPF */
+struct scx_bstr_buf {
+	u64			data[MAX_BPRINTF_VARARGS];
+	char			line[SCX_EXIT_MSG_LEN];
+};
+
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
@@ -1935,10 +1942,14 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
 int scx_sched_sysfs_add(struct scx_sched *sch);
 bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor);
+__printf(3, 0) s32 scx_bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
+				   char *fmt, unsigned long long *data, u32 data__sz);
 
 extern raw_spinlock_t scx_sched_lock;
 extern struct mutex scx_enable_mutex;
 extern struct percpu_rw_semaphore scx_fork_rwsem;
+extern raw_spinlock_t scx_exit_bstr_buf_lock;
+extern struct scx_bstr_buf scx_exit_bstr_buf;
 #ifdef CONFIG_EXT_SUB_SCHED
 extern const struct rhashtable_params scx_sched_hash_params;
 extern struct rhashtable scx_sched_hash;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 77cb7f3d7826..b3e72fffb0f6 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1694,6 +1694,63 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
 	return 0;
 }
 
+/**
+ * scx_bpf_sub_kill_bstr - Kill a direct child sub-scheduler
+ * @cgroup_id: cgroup id of the direct child to kill
+ * @fmt: reason message format string
+ * @data: format string parameters packaged using ___bpf_fill() macro
+ * @data__sz: @data len, must end in '__sz' for the verifier
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Evict a direct child sub-scheduler, disabling it with the supplied reason.
+ * The child and its subtree are torn down asynchronously through the usual
+ * disable path.
+ *
+ * Unlike scx_bpf_exit(), no exit code is taken: the child is a separate
+ * scheduler with its own exit-code semantics, so a code chosen by the parent
+ * would have no defined meaning. The reason string carries the intent.
+ *
+ * Return 0 on success or -ENODEV if @cgroup_id names no sub-scheduler, which
+ * can race with the child detaching on its own and so is not a scheduler error.
+ * Naming a sched that exists but is not a direct child aborts the parent.
+ */
+__printf(2, 0)
+__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
+				      unsigned long long *data, u32 data__sz,
+				      const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *parent, *child;
+	s32 ret;
+
+	guard(rcu)();
+
+	parent = scx_prog_sched(aux);
+	if (unlikely(!parent))
+		return -ENODEV;
+
+	if (!scx_is_cid_type()) {
+		scx_error(parent, "sub-cap kfuncs require a cid-form scheduler");
+		return -EOPNOTSUPP;
+	}
+
+	child = scx_find_sub_sched(cgroup_id);
+	if (unlikely(!child))
+		return -ENODEV;
+
+	if (unlikely(scx_parent(child) != parent)) {
+		scx_error(parent, "%s: sub-%llu is not a direct child",
+			  parent->cgrp_path, cgroup_id);
+		return -EINVAL;
+	}
+
+	guard(raw_spinlock_irqsave)(&scx_exit_bstr_buf_lock);
+	ret = scx_bstr_format(parent, &scx_exit_bstr_buf, fmt, data, data__sz);
+	if (ret < 0)
+		return ret;
+	scx_exit(child, SCX_EXIT_PARENT_KILL, 0, "%s", scx_exit_bstr_buf.line);
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 09c21602b2ed..acc2b131ea8f 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -119,6 +119,8 @@ s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps, const struct scx_cmask *cmask,
 		      struct scx_cmask *denied) __ksym __weak;
 void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps, const struct scx_cmask *cmask) __ksym __weak;
 s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out) __ksym __weak;
+s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
+			  unsigned long long *data, u32 data__sz) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
@@ -165,6 +167,22 @@ void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 	___scx_bpf_bstr_format_checker(fmt, ##args);				\
 })
 
+/*
+ * scx_bpf_sub_kill() wraps the scx_bpf_sub_kill_bstr() kfunc with variadic
+ * arguments instead of an array of u64. It kills the direct child sub-scheduler
+ * @cgid, passing the formatted reason to its user space, and evaluates to the
+ * kfunc's return value. On a kernel without sub-scheduler support the kfunc is
+ * absent and it returns -EOPNOTSUPP.
+ */
+#define scx_bpf_sub_kill(cgid, fmt, args...)					\
+({										\
+	scx_bpf_bstr_preamble(fmt, args)					\
+	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+	bpf_ksym_exists(scx_bpf_sub_kill_bstr) ?				\
+		scx_bpf_sub_kill_bstr((cgid), ___fmt, ___param,			\
+				      sizeof(___param)) : -EOPNOTSUPP;		\
+})
+
 /*
  * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
  * instead of an array of u64. Invoking this macro will cause the scheduler to
-- 
2.54.0

