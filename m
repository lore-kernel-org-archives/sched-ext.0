Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B2371057;
	Fri,  6 Mar 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823985; cv=none; b=Lq2AP2DbHvEFySUNkenFwxOtSyLODEOgcCEsJhwIk6PFVGW50Epywc8d7HC1u4/kiNpRW+HpxNogEl3KZIZC2qen/yHdTy0RI3Yw/XsgJwWK8FO1gR76Acl0G/+hMCT8X3UzoD0HqyxYm/HrtHMgOmaoJ6VJkT0Tmx3n15AgBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823985; c=relaxed/simple;
	bh=txnrtzvJWEregd/kzVRgzre4oagqPVy3LG8vyNS1Gfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD23js9AlUnR2MPEVL0iV7feX0G+XdcLkk7aFCaCnmF9+2pPA5s9Hf+b/psguuWRsWp5B0fzIziaFZQLvn9joP66kuexK7MOa2m8OjRoP7MXYydmd/q2aOXAZz5OJ7iJf4jTKn7azB7PAhRNME/LM+77j9g7NfjnCidwCe26M8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUmrfXy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUmrfXy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9A9C2BC86;
	Fri,  6 Mar 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823985;
	bh=txnrtzvJWEregd/kzVRgzre4oagqPVy3LG8vyNS1Gfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUmrfXy/Pi9rHDk9WpTSMA3C0r1L7xL/vWJmTdy03uqyXqKG56wF706sZXSw5TyvI
	 /axBsdmlEm+TDkG3Zmbo3Y9+EUDzjMENSTftdrt+LjelK3b/zfgeUZBtlYKNtFRCvC
	 fgnlE/XbWuee4dX5y+sl1IBLCP4ENZ5C7Q3kJscz/9g6pl6ydnvUjgVARbt2J/6wD4
	 Vtc+NCu+bIjvmD/4u16BeU8CZCTXy6yh6m28ToCvezQKFud7F24eH+3b3ge3qtoLU+
	 GIbVS0tJ0MX26QiYdiGzgo10PaU7konepEA3Lnp7Il+VPRqlOnorWlTKkXljg6azh5
	 yhP19SGE1CMFQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/15] sched_ext: Relocate scx_bpf_task_cgroup() and its BTF_ID to the end of kfunc section
Date: Fri,  6 Mar 2026 09:06:09 -1000
Message-ID: <20260306190623.1076074-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move scx_bpf_task_cgroup() kfunc definition and its BTF_ID entry to the end
of the kfunc section before __bpf_kfunc_end_defs() for cleaner code
organization.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 78 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e25b3593dd30..fe222df1d494 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8628,43 +8628,6 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	return rcu_dereference(cpu_rq(cpu)->curr);
 }
 
-/**
- * scx_bpf_task_cgroup - Return the sched cgroup of a task
- * @p: task of interest
- * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
- *
- * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
- * from the scheduler's POV. SCX operations should use this function to
- * determine @p's current cgroup as, unlike following @p->cgroups,
- * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
- * rq-locked operations. Can be called on the parameter tasks of rq-locked
- * operations. The restriction guarantees that @p's rq is locked by the caller.
- */
-#ifdef CONFIG_CGROUP_SCHED
-__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
-					       const struct bpf_prog_aux *aux)
-{
-	struct task_group *tg = p->sched_task_group;
-	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
-	struct scx_sched *sch;
-
-	guard(rcu)();
-
-	sch = scx_prog_sched(aux);
-	if (unlikely(!sch))
-		goto out;
-
-	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
-		goto out;
-
-	cgrp = tg_cgrp(tg);
-
-out:
-	cgroup_get(cgrp);
-	return cgrp;
-}
-#endif
-
 /**
  * scx_bpf_now - Returns a high-performance monotonically non-decreasing
  * clock for the current CPU. The clock returned is in nanoseconds.
@@ -8779,6 +8742,43 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 	memcpy(events, &e_sys, events__sz);
 }
 
+#ifdef CONFIG_CGROUP_SCHED
+/**
+ * scx_bpf_task_cgroup - Return the sched cgroup of a task
+ * @p: task of interest
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
+ * from the scheduler's POV. SCX operations should use this function to
+ * determine @p's current cgroup as, unlike following @p->cgroups,
+ * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
+ * rq-locked operations. Can be called on the parameter tasks of rq-locked
+ * operations. The restriction guarantees that @p's rq is locked by the caller.
+ */
+__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
+					       const struct bpf_prog_aux *aux)
+{
+	struct task_group *tg = p->sched_task_group;
+	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		goto out;
+
+	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
+		goto out;
+
+	cgrp = tg_cgrp(tg);
+
+out:
+	cgroup_get(cgrp);
+	return cgrp;
+}
+#endif	/* CONFIG_CGROUP_SCHED */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -8808,11 +8808,11 @@ BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, scx_bpf_now)
+BTF_ID_FLAGS(func, scx_bpf_events)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
 #endif
-BTF_ID_FLAGS(func, scx_bpf_now)
-BTF_ID_FLAGS(func, scx_bpf_events)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
-- 
2.53.0

