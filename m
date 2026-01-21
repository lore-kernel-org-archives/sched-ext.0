Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885D451067;
	Wed, 21 Jan 2026 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037112; cv=none; b=LXwezxdtLZbKUBSryVrYbqB04tV3ko9HZPVvWWPVf3TbPXoUA5yHA5A0BdapmpiA4zBZlgzLICyrIOO47d0znq0lZb2IqhcPEFGxChb2KiwAlB/ylX5+Mytevik4HWC2hguy95YS4QsDpGNxkZR7TCLFovcH2CIxP+vEKdE4i1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037112; c=relaxed/simple;
	bh=Q2mA8+zyS7sMCkRTPUV7+AbqrROFwLrFmPLqGjbbwY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgPfPzrX2WEa1CX7deMPdMc1MFCRv/zUfihyD5FNHyQV+ucugbjg1X6whs8xb07orbgFWcF3ri5WKf5QScDdLxcTICIth/Q8e5BO96UhFYJ2BrAF4XNI5kLyQAy1DHM3DzRBsZsYdv5GB3Q9NtAhCzto3q5mOsa7JfiTr4ou67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTAQmI48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTAQmI48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1551C16AAE;
	Wed, 21 Jan 2026 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037112;
	bh=Q2mA8+zyS7sMCkRTPUV7+AbqrROFwLrFmPLqGjbbwY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTAQmI48dgpnYX8B/Kg0ShhkzZh4xhUEDMD4TYC9XJ8fupyEjIciI75FDw2vvu4ZD
	 o6OKTY2uZOYF0HqHoJSJYc/EDI/rgVfZDWwPuJD7D/y1TPfiGqER5bWhLGuNPgt+Kz
	 tAOi+lgiPKi6mesBUWnQfOejb3P4Qm33ErUCrKl/Ys2KhlgXgqLvturz7iqDa0KWDz
	 FrR7WdTRKav+ht5hL/B9uWCk+YOYIg8oAbYZEMTwx91tImExQ/CaGZCXbDXPkpPJIh
	 IKR/hZPKdZ7pvI1y/5Armwt80z969bL8UYyv/0C5sZXpSj+xv4Vdx2ecnd3HfhmKJC
	 zdSEYv3kq6MZw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/34] sched_ext: Enforce scheduling authority in dispatch and select_cpu operations
Date: Wed, 21 Jan 2026 13:11:16 -1000
Message-ID: <20260121231140.832332-11-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
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
index e33689b91ff7..bdcb46f42625 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2231,6 +2231,12 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
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
@@ -3834,6 +3840,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
 	return at;
 }
 SCX_ATTR(events);
@@ -4944,6 +4951,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
+	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -6221,6 +6229,12 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
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
 
@@ -6413,6 +6427,17 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
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
 
@@ -7745,6 +7770,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
+		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
 	}
 }
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 20fe1eae3b34..c913c0b850da 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1061,6 +1061,17 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
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
index 4eebf5ef5823..335e90ca132e 100644
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
2.52.0

