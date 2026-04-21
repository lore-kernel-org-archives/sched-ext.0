Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C1399345;
	Tue, 21 Apr 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756000; cv=none; b=JNjYFsc67QB2ulq1xB3fkCxmEnVYGdPMGithpQdSBwJRIVJKgMBaJbk6vslBbQoB+rTKgbxoL8f/ySRVx46QkKn/udCaUTe9k0Ulmvdf4/imd23e6TXpg8a3QW4GXaGR820/AjprA3z9crbbtv0a6N2n252jabXeg4XKZ6IttK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756000; c=relaxed/simple;
	bh=VoKSZpEMAIJxnm02Qf2Uyjj2XAwtFh5go4+u8Ktc9Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYijCnxOHpCvXDzDC2Wxk+RBY87l4t5gODBoeev6hBJeewAe5jf1ur1TVnOPKW5jTVEHG6N2MKgrV3Vh1AyfIpUPd0Pp5iWSoM4NgVzfz96X8+KLFDV8pTDSswMXwclvKNh++MyFdxPWrV5BiX8UgfrXc/+zEMN4MYBgC54Y1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSuWHLeh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSuWHLeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD261C2BCB9;
	Tue, 21 Apr 2026 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756000;
	bh=VoKSZpEMAIJxnm02Qf2Uyjj2XAwtFh5go4+u8Ktc9Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSuWHLehqlwdgVK8kGHjoWM7wQ8KOtjwRD0vv9uMvPYk0fkz2QJ0ner0M9SqAOKWJ
	 VXHmF0S6N/OIapgvnQqLfAAS0Y7FZJnXvj5UmjQsNH6kqRGRe5dRRxHg8t5A3LgS7f
	 GbbB4gBJE1rk3Rby3DHJPy+SPgA0s6YA1r58I5yzim7YUn4QbftDTOTqFpVf7gGiTI
	 xy1/zi31xYsu6VC8vrISWgla0maImgXxItBEyYruGtUWzoScwLa5M14tgZ9izfh5Mg
	 Ab+U+NLqaghICOCzskuUEeMt7yZzAtN65+TVra/IJrNpbG6Vv0/8Hp0XXh9SMZVOnq
	 H30+1n/UA+YvQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
Date: Mon, 20 Apr 2026 21:19:41 -1000
Message-ID: <20260421071945.3110084-13-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fcb5f98d670d..02bdd393bbe4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9968,6 +9968,42 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
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
+ */
+BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
+BTF_ID_FLAGS(func, scx_bpf_task_cpu)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
+BTF_ID_FLAGS(func, scx_bpf_cpu_node)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
+BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
+BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
+BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
+BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
+BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
+
 /*
  * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
  * group; an op may permit zero or more groups, with the union expressed in
@@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
+	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
@@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
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

