Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAD42316F;
	Wed, 29 Apr 2026 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486907; cv=none; b=Nn05myqFzwcJVp5w1kxZcJMfaV0fVWhw3BVoAoz/nV6VV5tIm6sP3rc2pV7xTIDR+zl6jd/GjsefXAoju8uKKilDuDSHhhIatL3AjeNOVEkNgbNIjUcn7q0kc+c8oTc1mHGpez8njJTD9AxJrMXVLpfCXbRKr0kXO7jBTQPMeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486907; c=relaxed/simple;
	bh=hbqttJF5jyJFSz0TLOeCS06MonNovnebKp2SS1A1zfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s52j8gwLTb4P5DQRvjcc2pYKddYSruQpscaXEhNwImhSA7e4BXrk36dz/xL2eWMoZRchRW1/4r3m9RUis65XzF5hLt0vy4akJuyuuDA9ktEwnUKrgTVgDcnlrOpi+d2uYlrswJQTsENlJwpovWxZ9vagoJHMEgfTYlcS7ofWdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceu1aSYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceu1aSYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3238C2BCB8;
	Wed, 29 Apr 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486907;
	bh=hbqttJF5jyJFSz0TLOeCS06MonNovnebKp2SS1A1zfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceu1aSYKFObafIokelHE3eXysfsy7YrcetAW3aH3ggq38TpBAjyH5SDOvfPk3YxQq
	 fVPt9UnN7Ns26m+ZOtEiglv8NdXMm2yTrJYTib4KMAgMRJam5OfJEQ+lAx84Zckdy0
	 XldQtXJoLjE/FVPbdXaG+D+4LqxlOCsJg0qey6gh6e/2SSCKMPGnWIfexc/p19ostd
	 q8BAXA+xc9g7j0sD9612ZEoPdqzcptOm7Yzv4Na+5Nf1knW9W6r6kEhaEYo1pONWYO
	 n1oRvH4BsG6f5Rf+4cZfQCLVb9HjfN1MpAbQ+Ad4DWliV2Xk3juFNS3R4Mz7WZ33t+
	 JevKiNsiL4WoQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH 13/17] sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
Date: Wed, 29 Apr 2026 08:21:27 -1000
Message-ID: <20260429182131.1780125-14-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cid and cpu are both small s32s, trivially confused when a cid-form
scheduler calls a cpu-keyed kfunc. Reject cid-form programs that
reference any kfunc in the new scx_kfunc_ids_cpu_only at verifier load
time.

The reverse direction is intentionally permissive: cpu-form schedulers
can freely call cid-form kfuncs to ease a gradual cpumask -> cid
migration.

The check sits in scx_kfunc_context_filter() right after the SCX
struct_ops gate and before the any/idle allow and per-op allow-list
checks, so it catches cpu-only kfuncs regardless of which set they
belong to (any, idle, or select_cpu).

v2: Sync per-entry kfunc flags with their primary declarations (Zhao).
    pahole intersects flags across BTF_ID_FLAGS() occurrences, so
    omitting them drops the flags globally.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 79565fabd9b4..65a00c979691 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10121,6 +10121,47 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.filter			= scx_kfunc_context_filter,
 };
 
+/*
+ * cpu-form kfuncs that are forbidden from cid-form schedulers
+ * (bpf_sched_ext_ops_cid). Programs targeting the cid struct_ops type must
+ * use the cid-form alternative (cid/cmask kfuncs).
+ *
+ * Membership overlaps with scx_kfunc_ids_{any,idle,select_cpu}; the filter
+ * tests this set independently and rejects matches before the per-op
+ * allow-list check runs.
+ *
+ * pahole/resolve_btfids scans every BTF_ID_FLAGS() at build time and
+ * intersects flags across duplicate entries, so each entry must carry the
+ * same flags as the kfunc's primary declaration; otherwise the flags get
+ * dropped globally.
+ */
+BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_IMPLICIT_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_IMPLICIT_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_IMPLICIT_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_IMPLICIT_ARGS | KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
+
 /*
  * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
  * group; an op may permit zero or more groups, with the union expressed in
@@ -10184,6 +10225,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
+	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
@@ -10221,6 +10263,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
 		return -EACCES;
 
+	/*
+	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
+	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
+	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
+	 * intentionally permissive to ease gradual cpumask -> cid migration.
+	 */
+	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
+		return -EACCES;
+
 	/* SCX struct_ops: check the per-op allow list. */
 	if (in_any || in_idle)
 		return 0;
-- 
2.54.0

