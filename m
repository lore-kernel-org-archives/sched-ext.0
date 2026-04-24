Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642C3E8C49;
	Fri, 24 Apr 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051657; cv=none; b=J/7WscJcQeXoqDE5TEBuuevCZKq+GlyeB1mR5fsxcGLwz6Hx5UhZOgNbvxS11JlWlGefPCyXJqwhL6sTp1LRHWlQVHKKHuY30edxYod5ThPMy1CLe7EOFeIuT9tQTGKsQaUdTrvyqpVs9iQDz9BW9QJvwvle6fvRPrFM7CnJZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051657; c=relaxed/simple;
	bh=wgAZWZnwPTuTa4J/xCCTY035YQWlZi8On7A+A3CvQic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ5fl3XzLkLJ60ihb2is/abfXs9T/FdtX4wJMt8YjBlFCvvMRAhMWERZHlBI0jGif1azjKHLzJHjB5Zey65m+O9ftbso5KVj7JTK1JqrLqXnSEThhHuiDhzEGMBQaXmLtcWqlGAnb61ZxmHxl3x4cJkKyUq1ADQoIcT0BvHMHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbRaRjGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbRaRjGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02CFC2BCB2;
	Fri, 24 Apr 2026 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051656;
	bh=wgAZWZnwPTuTa4J/xCCTY035YQWlZi8On7A+A3CvQic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbRaRjGNzBgiDwthUiWHumIZxFi9As/pQIoKXjzQEIoc/rTyXBHMCMbHm3EtxBByd
	 MNTgRvdlOb/pEvhYioIR8XBZZml5zhxF646KZL7GbvvQYtfCE7LCE6v5azb5TRuoyY
	 gnjY1pV3qWc0tNC6zisWLzglJVyFAq6M42xf2ACDnDsxQLJhyYVgCt2C6rOAYytbzM
	 U0+ta7PPaz8RHUoaZPctEpf3chjAQCTVRkZS0ZKzQobdZEVSrD2Y0kSPVIAuXgOb7r
	 8E8RTM3aqw3wJy5aFr1HeoQNO0o9Qo1Vgq2Q35x/1U5dHDUTsabxuVbYta7bX0I+Lb
	 MM8pUoKdEitQg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/17] sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
Date: Fri, 24 Apr 2026 07:27:17 -1000
Message-ID: <20260424172721.3458520-14-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
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
Cc: Zhao Mengmeng <zhaomzhao@126.com>
---
 kernel/sched/ext.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index abc0c798150d..37f37f31b025 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9979,6 +9979,47 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
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
@@ -10042,6 +10083,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
+	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
@@ -10079,6 +10121,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
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
2.53.0

