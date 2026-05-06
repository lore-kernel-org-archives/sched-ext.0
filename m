Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56715A864
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054386; cv=none; b=ewI1FjL0JKjCsNcp+HFa1FqV7WSUA6MEkz/51oSZP2ZKcR4I14Tfu0JyFCezKcYDCE1/RRYunhPOk6MovuLVV+4e2s91ZvE4JXglEQT/cTEuofkR8wFB4xUm1VwMF+mAI8c4jKfKo65ho0UBXt2C+bdTO9UeuDX99KVTTbtWq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054386; c=relaxed/simple;
	bh=mZX9gNDURpiuAyN6IOmaMHejLTzuxT72fq5/OA9KN6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzvsJ0doE/7KNwY1baGtgBrBJ8V2lqH82ldzzceFHKEJMbhjDwdc/OxGwk3n1AvmWcdb8O7avNDAPQQDkM2x+CJiZV9ToNrE+Vr5YpGokwtPAW4UPaaLqO2GYn0t3M6om542JTzNUuICxiVJWt0RO73S5T2AzvtHqljI0U0S22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOoiIHKF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOoiIHKF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so2309995b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778054384; x=1778659184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4dy71nocwmDk2GInI4U9N3zYYgSRjxdg3aEBPK/5Dk=;
        b=AOoiIHKFS4urU9AVkltCbcjYBVHtH5GTyrpkzKSX+zPBESvec1NpZuzUkGopXYnGu2
         iDasvCmI3Du8QBbR6JWyftX3r/kEP7nJiIxURelBX/3ul7xPm3aKA42KMAqKAxOyclHq
         oWY3xpyNwn0QezmH9lpQETFxrql4HLlyCIjqHVvOtO2sZb1eAk9Bl5xBzfRZNhS/i26k
         Huny+5nG55XCXI9HHcySfFTsMlkcHNrYLU2X/7vIVmMnLmwriKH9KD0C72EP4liWK3X0
         St7f3gjyKlO8Q3pbEn0mvuKmJa3ZzyTViCn782rF3Y8XvqVSygfY6WSvT0ngSm8pwkrF
         sWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778054384; x=1778659184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4dy71nocwmDk2GInI4U9N3zYYgSRjxdg3aEBPK/5Dk=;
        b=WCfqPuHEnXOufXlUto4XenGRRy+YqM0VyTDVm+8qQxQ1EslJdNFLGtBMMDRROnn/bL
         0ZI+cpl/K29DwvCX7s/EI8jJYRygFJ0vPMYfieQTDQ/8rlY7imuT0fzGEECH6n/zPySL
         r6Aa47Ikcq6MKsuRH9nociYBB13jQb4IgDvC/wLbEM6zRpOtL33BPaOSRuga6sjYrYjD
         xC6ldmoIYvPiY23jNXb1V+HZ123DBHB0NE6TW1z2c4jHgSqCoaKdgX2jM8SxfPD9ewmv
         ZcSKltCmBjIt/7xRbUfmsFPAeSQljO1kxWnS91okJeapuypdKNhqkcCjAnoTQFtiLLUx
         9GXQ==
X-Gm-Message-State: AOJu0YxGqovCUooJJuM67Kdffaj/3X4RR5RB59NZwEBRn4Nlmo6xy3d3
	KdhG2ngAeN36TLOKHU4wcmf63uK9CCOM0pOprSE/DfHWljI8rJhtLGpBm2puew==
X-Gm-Gg: AeBDiesSYVmr2uIU9EvyJR1Pn7zRaRvCarDwnxP9OcCybuBC8tCqu7WmTSDuxW+6EdK
	tV1h9SRuRY/Xw3+wN3cuy+MXM3LL1rb/7+ma8x718+S9nPcJ85pEsKh5Ka6T5Dgoxg1pERo8iCM
	2sxBQXoZKcCW+asw52NrRpxbdhpvUdA9kl4EVpZ7ZNOXMteu3AztxiTQhOf7hkKnKebyPcmTnkZ
	yHdyyTQ88u0lpVWhrd2nag8AFRKSDK6o1N8SH/ueLbOgA1BRO1y3Tg+U1Scx/ItPxAR4TtRHprm
	UkgQxhHLRcW/Am+RXeR+ur2b7dc80Um409r+gpCgWIuzncacWLpKKN7RdDi0uKDw7wniog51tkl
	vVoOybonGGT88Omdv6llZuR3B8Uu303l3WwTN5FS8zx+N4/JBbV8jRqiuh9Xu5iD2PezVInnwkW
	zRbPE3joZTYUYCVupM2fexju0MomrYwnlK/A1mulPRr6ckMJpX1fNIN8JdPpJJ9Q==
X-Received: by 2002:a05:6a20:9392:b0:3a3:a5cd:5621 with SMTP id adf61e73a8af0-3aa5ac148c8mr2387420637.51.1778054384175;
        Wed, 06 May 2026 00:59:44 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:5aa6:d56d:38a9:469])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242ab2971sm1689268a12.6.2026.05.06.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 00:59:43 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	Kuba Piecuch <jpiecuch@google.com>
Subject: [PATCH] sched_ext: Add cookie API for early qseq capture
Date: Wed,  6 May 2026 15:59:21 +0800
Message-ID: <20260506075925.371138-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_insert() captures qseq at insert time. Any BPF-side
pre-dispatch checks (e.g. CPU affinity validation) performed before
the insert are outside the qseq protection window: a dequeue/re-enqueue
race occurring between the check and the insert goes undetected by
finish_dispatch(), which sees a matching qseq and proceeds with stale
assumptions.

Introduce two new kfuncs to extend the qseq protection window:

- scx_bpf_task_get_cookie(p)
    Reads @p's current qseq from ops_state and returns it as an opaque
    u64 cookie. The BPF scheduler should call this before performing
    pre-dispatch validity checks. The cookie may be stored in BPF maps
    to support cross-CPU dispatch patterns.

- scx_bpf_dsq_insert_with_cookie(p, dsq_id, enq_flags, cookie)
    Like scx_bpf_dsq_insert() with slice=0, but uses the cookie's qseq
    instead of re-reading ops_state at insert time. If @p was dequeued
    and re-enqueued between get_cookie() and here, qseq will have
    changed and finish_dispatch() will silently discard the stale
    dispatch. Use scx_bpf_task_set_slice() to set a non-default slice.

To support explicit qseq passing, refactor scx_dsq_insert_commit() to
take qseq as a parameter; all existing callers capture ops_state at
their call site, preserving the original behavior.

This mechanism is intended for schedulers that do not implement
properly synchronized dequeue. A scheduler whose ops.dequeue()
synchronizes atomically with the dispatch path does not need cookies.

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Suggested-by: Andrea Righi <arighi@nvidia.com>
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
As discussed in [1].
[1]: https://lore.kernel.org/r/20260319083518.94673-1-arighi@nvidia.com/

 kernel/sched/ext.c | 65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c80f0efd42c0..49577cca3104 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8303,7 +8303,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 }
 
 static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
-				  u64 dsq_id, u64 enq_flags)
+				  u64 dsq_id, u64 enq_flags, unsigned long qseq)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
@@ -8321,7 +8321,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 
 	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
 		.task = p,
-		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.qseq = qseq,
 		.dsq_id = dsq_id,
 		.enq_flags = enq_flags,
 	};
@@ -8388,7 +8388,8 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8416,7 +8417,8 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8505,13 +8507,67 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
+/**
+ * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
+ * @p: task_struct to read cookie from
+ *
+ * Returns an opaque u64 cookie encoding @p's current qseq. Call this
+ * before pre-dispatch validity checks and pass the result to
+ * scx_bpf_dsq_insert_with_cookie() to extend the qseq protection window.
+ *
+ * For schedulers that do not implement properly synchronized dequeue only.
+ */
+__bpf_kfunc u64 scx_bpf_task_get_cookie(struct task_struct *p)
+{
+	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
+}
+
+/**
+ * scx_bpf_dsq_insert_with_cookie - Insert a task using an early-captured cookie
+ * @p: task_struct to insert
+ * @dsq_id: DSQ to insert into
+ * @enq_flags: SCX_ENQ_*
+ * @cookie: cookie from scx_bpf_task_get_cookie()
+ * @aux: implicit BPF argument
+ *
+ * Like scx_bpf_dsq_insert() with slice=0, but uses @cookie's qseq instead
+ * of re-reading ops_state at insert time. A stale cookie causes
+ * finish_dispatch() to silently discard the dispatch. Use
+ * scx_bpf_task_set_slice() to set a non-default slice.
+ *
+ * Returns %true on success, %false on failure.
+ */
+__bpf_kfunc bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p,
+						 u64 dsq_id, u64 enq_flags,
+						 u64 cookie,
+						 const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return false;
+
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
+		return false;
+
+	p->scx.slice = p->scx.slice ?: 1;
+
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags, (unsigned long)cookie);
+
+	return true;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_with_cookie, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
@@ -10181,6 +10237,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
-- 
2.48.1

