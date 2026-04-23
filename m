Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537419C556;
	Thu, 23 Apr 2026 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985466; cv=none; b=KLP4BGSF8G83TMSOkz1FKwFKHkLrP0lS9hIhNi1pJX5KnJPki9bDKy35gBskItJpiXS82hbJ0+CYn32Sc8lxnTTqFcKRlSkm0XJLxEnsLuyKuigGAGVn+OQkVwI9jQIzeS+Ek7O6yMrfwEuhVm75dDaSUu85ZyGyiH1e0saCqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985466; c=relaxed/simple;
	bh=qzfzVjLbbS2qpRjqwvHDBULTq4u8olwDzHtrTDmzlJU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uT8sqARjFjGdZSuKoGDulOvr4QvjzcgMdTXh0+Vk7CZiJeNHeNO3YKnsJrtSH7SkKU3c+HPvaRDom5YEQW1HUPbx6VCrlTZ0vNoxTZIFzePvWpaaOOZegA+GADuuiuVcIxYX+BIap9Lqf3mvBSTs9B4cJSxH3qZS/pr5uZRRniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCZ8Cqpp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCZ8Cqpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A63C2BCAF;
	Thu, 23 Apr 2026 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776985465;
	bh=qzfzVjLbbS2qpRjqwvHDBULTq4u8olwDzHtrTDmzlJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCZ8Cqpp4bUrdDg7NyWv/BiOpcd5YSJWY6TMIb8Go/u5bv2Y8CQQkA2W/UEUhZc3x
	 fbBKz+cr6MqGVtvN9Hv19vmBfVK6a1ZNJ0TRIXNtKbB5vZf47KPR0JkcO8cWncBwvW
	 R5sTVHMXyi/DUid8Sy1sp7MszzxaJJqS2lZh901kPp6UK2G7sRBcFdlc3Ejd3CIP2p
	 B4uKM2e9YV526G8rsnGBKuJLkuq6GdvmdazEuvviAuf036X5qGcQhK6V6ah2kbuSWl
	 e8nOgg6U+cAAOo9agWSDL/U+pezKas0hDBsVXrAhPIXQ+nK1lKLySiDrkia9MeRxKK
	 qHK9W5lBwLQ5A==
Date: Thu, 23 Apr 2026 13:04:24 -1000
Message-ID: <38133c3fa792e3a5d5b425729f59b9ee@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 emil@etsalapatis.com,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Zhao Mengmeng <zhaomzhao@126.com>
Subject: [PATCH v2 sched_ext/for-7.2] sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
In-Reply-To: <20260421071945.3110084-13-tj@kernel.org>
References: <20260421071945.3110084-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

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
 kernel/sched/ext.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9969,6 +9969,47 @@ static const struct btf_kfunc_id_set scx
 };

 /*
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
+/*
  * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
  * group; an op may permit zero or more groups, with the union expressed in
  * scx_kf_allow_flags[]. The verifier-time filter (scx_kfunc_context_filter())
@@ -10031,6 +10072,7 @@ int scx_kfunc_context_filter(const struc
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
+	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
 	u32 moff, flags;

 	/* Not an SCX kfunc - allow. */
@@ -10068,6 +10110,15 @@ int scx_kfunc_context_filter(const struc
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
