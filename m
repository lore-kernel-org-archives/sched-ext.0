Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCE3D5657;
	Wed,  4 Mar 2026 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661691; cv=none; b=PP7oGLvC7OIFx7wrYJI5Ndg5ZXC+kLdGzGRLKICVgIKXFuZRWmC5+BjAnVRtMKlarjfb4XoyTBZKxLXoVEgh5pYpRbLuG+X1MrgjAXpyV+wbF/l+9Z5N/9dIO/PVUDwaG/3XRXqddu637Zvt/se/tuNqbbdvNKCop8ucDtsKxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661691; c=relaxed/simple;
	bh=xn+UbqeKbAeRYToS9yQBKosKcYwa04Cpx4pAAIadeNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn208jMYlHRHYXcE2MDE3969fx0+tcyWXhXP+ttzxTLWGSl7z1E3w3BJJOvQeBqlvItQmF0VDAC0CAo4d2GhCy3EAwKJqM79oN0qlFX/WNXZIEPGuJWLcsUf57NZo22BGODmuokaffMPuZwEieu8KW15Anuaw2KgVmE8O9f06yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAsG324y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAsG324y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B6AC4CEF7;
	Wed,  4 Mar 2026 22:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661691;
	bh=xn+UbqeKbAeRYToS9yQBKosKcYwa04Cpx4pAAIadeNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAsG324ymaII9mOMCPIfe5hlgVGNwASvBruhJIVSZxoJUgPRMlyR6ZHjB8qLCJI5p
	 25IKtIPqAcmi4Jn/DB30I9dqUtiDCCy+hdieaVYbCuduzK237RvLxRAOo91rqxeLU0
	 WU1/KOEPK1qdDb1k9vHodD8kZqRNckZc4temgZ9MDKfNBM2Wv0gVGVljKs47WzWmfz
	 NxXWmkFILF34bo8bvv/zOvlcW9h8yBB5GdekFlmgrnk9Chlm9o85CHqZI4clCXwu8N
	 Hk8Mm6VhiWaD3pp8Ct4Fjsks7E6X+fwyMPwNl4kCVotyJS2a0KXXjDa3LgeXkrTM27
	 mPf913d09mEgw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/34] sched_ext: Enforce scheduling authority in dispatch and select_cpu operations
Date: Wed,  4 Mar 2026 12:00:55 -1000
Message-ID: <20260304220119.4095551-11-tj@kernel.org>
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

Add checks to enforce scheduling authority boundaries when multiple
schedulers are present:

1. In scx_dsq_insert_preamble() and the dispatch retry path, ignore attempts
   to insert tasks that the scheduler doesn't own, counting them via
   SCX_EV_INSERT_NOT_OWNED. As BPF schedulers are allowed to ignore
   dequeues, such attempts can occur legitimately during sub-scheduler
   enabling when tasks move between schedulers. The counter helps distinguish
   normal cases from scheduler bugs.

2. For scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and(), error out
   when sub-schedulers are attached. These functions lack the aux__prog
   parameter needed to identify the calling scheduler, so they cannot be used
   safely with multiple schedulers. BPF programs should use the arg-wrapped
   versions (__scx_bpf_dsq_insert_vtime() and __scx_bpf_select_cpu_and())
   instead.

These checks ensure that with multiple concurrent schedulers, scheduler
identity can be properly determined and unauthorized task operations are
prevented or tracked.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 26 ++++++++++++++++++++++++++
 kernel/sched/ext_idle.c     | 11 +++++++++++
 kernel/sched/ext_internal.h | 12 ++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f5e394c5b981..b54b7a5b2bb8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2325,6 +2325,12 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
 			return;
 
+		/* see SCX_EV_INSERT_NOT_OWNED definition */
+		if (unlikely(!scx_task_on_sched(sch, p))) {
+			__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
+			return;
+		}
+
 		/*
 		 * While we know @p is accessible, we don't yet have a claim on
 		 * it - the BPF scheduler is allowed to dispatch tasks
@@ -4028,6 +4034,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
 	return at;
 }
 SCX_ATTR(events);
@@ -5150,6 +5157,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
+	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -6476,6 +6484,12 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
+	/* see SCX_EV_INSERT_NOT_OWNED definition */
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
+		return false;
+	}
+
 	return true;
 }
 
@@ -6668,6 +6682,17 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Disallow if any sub-scheds are attached. There is no way to tell
+	 * which scheduler called us, just error out @p's scheduler.
+	 */
+	if (unlikely(!list_empty(&sch->children))) {
+		scx_error(scx_task_sched(p), "__scx_bpf_dsq_insert_vtime() must be used");
+		return;
+	}
+#endif
+
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
@@ -8000,6 +8025,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
+		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
 	}
 }
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cc72146ee898..9f6abee1e234 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1060,6 +1060,17 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
 	if (unlikely(!sch))
 		return -ENODEV;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Disallow if any sub-scheds are attached. There is no way to tell
+	 * which scheduler called us, just error out @p's scheduler.
+	 */
+	if (unlikely(!list_empty(&sch->children))) {
+		scx_error(scx_task_sched(p), "__scx_bpf_select_cpu_and() must be used");
+		return -EINVAL;
+	}
+#endif
+
 	return select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags,
 				     cpus_allowed, flags);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 33c243dd10a3..078fcd1c6bee 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -911,6 +911,18 @@ struct scx_event_stats {
 	 * The number of times the bypassing mode has been activated.
 	 */
 	s64		SCX_EV_BYPASS_ACTIVATE;
+
+	/*
+	 * The number of times the scheduler attempted to insert a task that it
+	 * doesn't own into a DSQ. Such attempts are ignored.
+	 *
+	 * As BPF schedulers are allowed to ignore dequeues, it's difficult to
+	 * tell whether such an attempt is from a scheduler malfunction or an
+	 * ignored dequeue around sub-sched enabling. If this count keeps going
+	 * up regardless of sub-sched enabling, it likely indicates a bug in the
+	 * scheduler.
+	 */
+	s64		SCX_EV_INSERT_NOT_OWNED;
 };
 
 struct scx_sched_pcpu {
-- 
2.53.0

