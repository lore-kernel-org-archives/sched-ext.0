Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED844F57A
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325709; cv=none; b=gKk2BDhq2bCHGYCvQrnLajecOaLkmLllNH99GpSbi2e9qQexrcOC7m1UoBQb+At2/rFWBLi37MA354KZw5oB0mSyQj6oLfvA4jlAB+wSGXG+3G/JjSNC5Ftlvnf4REv5tVPc99jQnaaAKIv47I7L+TPU7ruIAC4W1bMzLMMi6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325709; c=relaxed/simple;
	bh=r8Uu/Zqf/xnZi6fRiFqul+3vjGq3cQfIrUxSpg4T2l4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=es003xIT+teUjMi51JlikmBJ3aDncMRfptTkUV+a/+MbURNW175IO0ZeOaWlkx4qDah3eDHtRcQo6FK4PDQZi7Vq2Mgj/bqeGxaaoqfOxEmEFvPgvGTDNL9y2HUDHeMhIUNt5mzkn9kfA9141BpzEl9ZgbA2W2d+fssgmS/RlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6h2qqHH; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6h2qqHH"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so759683f8f.1
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325705; x=1792930505; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwuUz0sjEedmtSHgGjyiQeqFNpTVTmBpgU8lv48Qk8g=;
        b=m6h2qqHHpK2G6YjRhvV8TRmazUq5TBLuWMN3WhCVa4EOzR663F1sFyKo5QW4OqQxjx
         9/ARgeHiyiYLoHWtnTTaUeJOGcZqr0gnZOLY49qSwI21JJvzPIlDa3LmvU3wkgXn3S4f
         t46L+jCDqK0rGSM/m66tunyoObeRoNIW3tJSJP7XNfsJ0bTkih+5NTXv4ULE6okkqn/+
         O4QCv7O+jL+Wo9ifqimJyqWcWmqX71coFtddb8p5PRgoduGTYeBxYXxpYvpuG5ETymHZ
         iNS8lod7+q5SNq1V4lcqwHoruKhjcrPM1PyRmGROF+ix8RorzQh3G7eLzsKwPftIyQj/
         yAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325705; x=1792930505;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hwuUz0sjEedmtSHgGjyiQeqFNpTVTmBpgU8lv48Qk8g=;
        b=bKpkiYLbENwBPD3So79aty++j62j2YPmywSf5eo16yOicV5ZhidBfnHbR9s1zs2jEf
         O3zN3xciK6k+ija/q3i3M6M7Qx3x2s/inUT1kJJkh1xmfP/Z6IGFZrSPlFjMwV3cm+dA
         8g5s7IJroTSSpx1R5Ivh8dk/i6cQt2GkWlF/Gs+u2RsEjrWg5j6ijE23YkhZz6wOjlco
         eT2dR9+oWBxsm82ogP+BPQee7F2v5hOWBE+aDX7cvzh8ud3oIES9NVW8w3Nfx5DtVSPF
         4x/XVPWit6BTbmbq/h9BllOM4kONSWENUWGnVMlAsDwpSpFHoEI5G4K3BwKb1If7cV5W
         wp1A==
X-Forwarded-Encrypted: i=1; AKwUvBxyb6BRIFCXWNoOccdgB2o3u96ZT91QbmEoyQPt4WMGeourgT361DRgMmK2c8mh5+mYbHtw5JzBMEU=@lists.linux.dev
X-Gm-Message-State: AFq9FYIWzGl2tfeZWGw5NolBnmF5hhuwAMEGs3srrl2NYfsE8rhZak8z
	Q0H22+KryuYH6MWFtQp7JMtsgW27FgbfK+IoT6XUqvBOis0EgYo+0YBdP7HwURpepXDPpVNSDUG
	xOnxELUaZbDI0Qg==
X-Received: from wmsz10.prod.google.com ([2002:a05:600c:c16a:b0:4a1:b482:e0f8])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a1d75ab363mr107302835e9.4.1792325704715;
 Sun, 18 Oct 2026 05:15:04 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:48 +0000
In-Reply-To: <cover.1792248922.git.jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <4396cb340aea678a9a17a3e91cd3da681ccff6c8.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH 4/5] sched_ext: Un-deprecate ops.cpu_acquire/release()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit a3f5d4822253 ("sched_ext: Allow scx_bpf_reenqueue_local() to be
called from anywhere") deprecated ops.cpu_acquire() and
ops.cpu_release() because they missed events, and fixing that was
thought to require a hook invoked regardless of sched class. The
previous patches make the callbacks reliable using only hooks in the ext
and idle classes: they are now emitted on every transition of a CPU
between being available to the BPF scheduler and being released, and
only then.

A reliable, edge-triggered view of CPU availability is useful to BPF
schedulers beyond re-enqueueing preempted tasks, e.g. to keep track of
which CPUs can be used for placement without tracing every context
switch through the sched_switch tracepoint.

Drop the deprecation warning from scx_validate_ops() and the deprecation
notes from the kerneldoc. Document the contract in the kerneldoc: what
available means, the order relative to ops.running() and
ops.update_idle(), that ops.dispatch() may run on a released CPU, that
the callbacks may be invoked for a remote CPU, and the rules for
scheduler load and CPU hotplug. Also note that for
SCX_CPU_PREEMPT_CLASS_CHANGE, the task in the release arguments is the
one which left SCX.

The callbacks stay cpu-form only. They remain at the tail of struct
sched_ext_ops, past SCX_OPI_END, and struct sched_ext_ops_cid doesn't
have them. Since cpu-form schedulers can neither be sub-schedulers nor
have sub-schedulers, they are root-only by construction.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      | 15 +++------
 kernel/sched/ext/internal.h | 65 ++++++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d56c692f3dfa..7f4496667b1a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7681,14 +7681,6 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
-	/*
-	 * cid-form's struct is shorter and doesn't include the cpu_acquire /
-	 * cpu_release tail; reading those fields off a cid-form @ops would
-	 * run past the BPF allocation. Skip for cid-form.
-	 */
-	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
-		pr_warn_ratelimited("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
-
 	/*
 	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
 	 * attaches through a cid-form-only interface (sub_attach/sub_detach),
@@ -11283,9 +11275,10 @@ static int __init scx_init(void)
 	/* @priv tail must align since both share the same data block */
 	CID_OFFSET_MATCH(priv, priv);
 	/*
-	 * cid-form must end exactly at @priv - scx_validate_ops() skips
-	 * cpu_acquire/cpu_release for cid-form because reading those fields
-	 * past the BPF allocation would be UB.
+	 * cid-form must end exactly at @priv. It doesn't have the cpu-form only
+	 * cpu_acquire/cpu_release and reading them off a cid-form @ops would
+	 * run past the BPF allocation. The kernel copy in sch->ops keeps them
+	 * zero for cid-form, see scx_alloc_and_add_sched().
 	 */
 	BUILD_BUG_ON(offsetof(struct sched_ext_ops_cid, __end) !=
 		     offsetofend(struct sched_ext_ops, priv));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 65b6ec7dc2f3..415fc0cd314c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -315,7 +315,11 @@ struct scx_cpu_release_args {
 	/* the reason the CPU was preempted */
 	enum scx_cpu_preempt_reason reason;
 
-	/* the task that's going to be scheduled on the CPU */
+	/*
+	 * The task that's going to be scheduled on the CPU. For
+	 * %SCX_CPU_PREEMPT_CLASS_CHANGE, the task which left SCX and keeps
+	 * running on the CPU.
+	 */
 	struct task_struct	*task;
 };
 
@@ -1019,12 +1023,33 @@ struct sched_ext_ops {
 	void __rcu *priv;
 
 	/*
-	 * Deprecated callbacks. Kept at the end of the struct so the cid-form
-	 * struct (sched_ext_ops_cid) can omit them without affecting the
-	 * shared field offsets. Use SCX_ENQ_IMMED instead. Sitting past
-	 * SCX_OPI_END means has_op doesn't cover them, so SCX_HAS_OP() cannot
-	 * be used; callers must test sch->ops.cpu_acquire / cpu_release
-	 * directly.
+	 * cpu-form only callbacks. Kept at the end of the struct so the
+	 * cid-form struct (sched_ext_ops_cid) can omit them without affecting
+	 * the shared field offsets. Sitting past SCX_OPI_END means has_op
+	 * doesn't cover them, so SCX_HAS_OP() cannot be used; callers must test
+	 * sch->ops.cpu_acquire / cpu_release directly.
+	 *
+	 * A CPU is available to the BPF scheduler while its scheduling context
+	 * is an SCX task or the idle task, including core-sched forced idle:
+	 * whether a task can run on a forced idle CPU depends on the task's
+	 * core cookie. A CPU is released while a stop, deadline, RT or fair
+	 * (%SCX_OPS_SWITCH_PARTIAL) task runs on it, and while it's offline.
+	 *
+	 * ops.cpu_acquire() and ops.cpu_release() are called on every
+	 * transition between the two states and only then, so they always
+	 * alternate for a given CPU. Every CPU starts released when the
+	 * scheduler is loaded and ops.cpu_acquire() is called for each online
+	 * CPU which is available at that point. ops.cpu_offline() implies a
+	 * release and neither callback is called for a CPU between
+	 * ops.cpu_offline() and ops.cpu_online(). ops.cpu_acquire() is called
+	 * right after ops.cpu_online() if the CPU is available.
+	 *
+	 * Both callbacks are called with the rq of @cpu locked and may be
+	 * called from a CPU other than @cpu. Don't assume that @cpu equals
+	 * bpf_get_smp_processor_id().
+	 *
+	 * Both callbacks are only effective for the root scheduler: cpu-form
+	 * schedulers can't be sub-schedulers or have sub-schedulers.
 	 */
 
 	/**
@@ -1033,7 +1058,11 @@ struct sched_ext_ops {
 	 * @args: Acquire arguments, see the struct definition.
 	 *
 	 * A CPU that was previously released from the BPF scheduler is now once
-	 * again under its control. Deprecated; use SCX_ENQ_IMMED instead.
+	 * again available to it. Called when the CPU switches to an SCX task
+	 * or the idle task, before ops.running() and ops.update_idle(@cpu,
+	 * %true) for it. ops.dispatch() is called when the CPU is looking for
+	 * a task to run and may thus be called on a CPU which is still
+	 * released.
 	 */
 	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
 
@@ -1042,11 +1071,17 @@ struct sched_ext_ops {
 	 * @cpu: The CPU being released by the BPF scheduler.
 	 * @args: Release arguments, see the struct definition.
 	 *
-	 * The specified CPU is no longer under the control of the BPF
-	 * scheduler. This could be because it was preempted by a higher
-	 * priority sched_class, though there may be other reasons as well. The
-	 * caller should consult @args->reason to determine the cause.
-	 * Deprecated; use SCX_ENQ_IMMED instead.
+	 * The specified CPU is no longer available to the BPF scheduler. This
+	 * could be because a task of a higher priority sched_class is about
+	 * to run on it or because the task running on it switched to another
+	 * sched_class. The callee should consult @args->reason to determine
+	 * the cause. When an SCX task is preempted, this is called after the
+	 * task has been put back on the local DSQ, or re-enqueued to the BPF
+	 * scheduler if it's an %SCX_TASK_IMMED task. When the CPU leaves idle,
+	 * this is called after ops.update_idle(@cpu, %false).
+	 *
+	 * scx_bpf_reenqueue_local() can be used to re-enqueue the tasks queued
+	 * on @cpu's local DSQ.
 	 */
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 };
@@ -1058,7 +1093,7 @@ struct sched_ext_ops {
  * where applicable. Layout up to and including @priv matches sched_ext_ops
  * byte-for-byte (verified by BUILD_BUG_ON checks at scx_init() time) so
  * shared field offsets work for both struct types in bpf_scx_init_member()
- * and bpf_scx_check_member(). The deprecated cpu_acquire/cpu_release
+ * and bpf_scx_check_member(). The cpu-form only cpu_acquire/cpu_release
  * callbacks at the tail of sched_ext_ops are omitted here entirely.
  *
  * Differences from sched_ext_ops:
@@ -1071,7 +1106,7 @@ struct sched_ext_ops {
  *   - cpu_offline      -> cid_offline
  *   - dump_cpu         -> dump_cid
  *   - cgroup_*         -> cpuctl_* (they track the cgroup cpu controller)
- *   - cpu_acquire/cpu_release  -> not present (deprecated in sched_ext_ops)
+ *   - cpu_acquire/cpu_release  -> not present (cpu-form only)
  *
  * BPF schedulers using this type cannot call cpu-form scx_bpf_* kfuncs;
  * use the cid-form variants instead. Enforced at BPF verifier time via
-- 
2.56.0.176.g3575e65682-goog

