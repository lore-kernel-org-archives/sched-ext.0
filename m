Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794533D7D63;
	Wed,  4 Mar 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661692; cv=none; b=Of7ehFPhQKfUVJqOayNnaQxT3l+mfh5z3psut2zq0dKA8DW2nN7tGtr5l51KjXh+XA6VvM9DRtVKqk4EOoQy/ot/9sQMMqrrtzQhGhty7Esplpx7af/YJb6ynT0D9joRm67HtR1DiomrDiyjE99r5/L20EVMDCehKe1quHB+DBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661692; c=relaxed/simple;
	bh=/QYFzdqlyA+Y3xdq/4Ppuc0oRS6wPk3N1ew6qoaXbak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oURp0mbhcnakEMHjzaXZ6xEo+o65RyZIh4qX/i/8PsFgr13s241+3YGetH0J2HiTKgxC5oMbSF3Lj+KV5cojYKThLIItL2ZwsgeyoNWHt48LbbD7sH1F88kz8Wg/0C9kGpBKwVb//MlIW94mj/QSVmjBtW8kxZDPttrRauvDROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OASpYiUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OASpYiUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA5C19425;
	Wed,  4 Mar 2026 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661692;
	bh=/QYFzdqlyA+Y3xdq/4Ppuc0oRS6wPk3N1ew6qoaXbak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OASpYiUjdiBjtr4msc0aXqr9hry42nFPY+no2Rl5PNT0Ohb5syCSTiLu0IalPyGB1
	 Txt1/CQtxJhb/EqGxAFeCHQT4w443p6l6wLrydaZ/YrScKq/Mrlmj1S5zbnY/AA9P6
	 i0QAnTQT++T68f12Kxqaxwwp751fdHVRyLHQ33jMS4/fgWAZi+7c9G9NLWqaZvYc3v
	 eimUHANRB+QS1dGWlIZV8wbMHNxnRdhjv04mbjaXEgV6WjpuH/T8LI6alYZmLZ1la1
	 wnyL2nXWTCB3YO8vvQFM/oBF9KMjV2+BLq/qsoeVLC5sMuw1EOa2D2mzwXIaaa/nzr
	 JjTSmKcha3P2A==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/34] sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime
Date: Wed,  4 Mar 2026 12:00:56 -1000
Message-ID: <20260304220119.4095551-12-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() now verify that
the calling scheduler has authority over the task before allowing updates.
This prevents schedulers from modifying tasks that don't belong to them in
hierarchical scheduling configurations.

Direct writes to p->scx.slice and p->scx.dsq_vtime are deprecated and now
trigger warnings. They will be disallowed in a future release.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b54b7a5b2bb8..b2b1b05f1cd6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5945,12 +5945,17 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t == task_struct_type) {
-		if (off >= offsetof(struct task_struct, scx.slice) &&
-		    off + size <= offsetofend(struct task_struct, scx.slice))
-			return SCALAR_VALUE;
-		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
-		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+		/*
+		 * COMPAT: Will be removed in v6.23.
+		 */
+		if ((off >= offsetof(struct task_struct, scx.slice) &&
+		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
+		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
+			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
 			return SCALAR_VALUE;
+		}
+
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -7163,12 +7168,21 @@ __bpf_kfunc_start_defs();
  * scx_bpf_task_set_slice - Set task's time slice
  * @p: task of interest
  * @slice: time slice to set in nsecs
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's time slice to @slice. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
+					const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.slice = slice;
 	return true;
 }
@@ -7177,12 +7191,21 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
  * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
  * @p: task of interest
  * @vtime: virtual time to set
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's virtual time to @vtime. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
+					    const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.dsq_vtime = vtime;
 	return true;
 }
@@ -8062,8 +8085,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
-BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
-BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
-- 
2.53.0

