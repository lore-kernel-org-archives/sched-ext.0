Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBF265CDD
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083469; cv=none; b=c8rwSXSYytxGB68/mq3gNxeSZQb4OaYD0Jo91xsflWw8FtToLxg8Ygr+TTuOBZb68NDmNuGYRB3a+4afBniQr+kuisRrddgCdiuY9qA65qhDCggxwtiPe6mkq8UH+klZ/hLkeoxY0egXU4Gft1X1Wqh5cryNm/CkEWxFc0zLepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083469; c=relaxed/simple;
	bh=tjvWia/q8nId4bgAQFtb/U/4FETQa4Ij98I1Rf4+yLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqapFjritBg7xxs+KSr/dVM1BFJF2js4JJEXoTvTUhmXwRx+1DzMs913XZcZse2pmXdGrQACK0hgPVTciHMpXjI6VGy83K9RL//R0NvARf1nEx3FPG+qJh6vobs2S7no/FLASq5KA7trPwxHfaKr7nKgAru/0c6rHnq8rBzQKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeMtuLTr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeMtuLTr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3658c87160eso1192375a91.0
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083461; x=1778688261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPnrSgtmFF1Udoue8aZyvqxIyRTiy5EiC9+gkdriCKs=;
        b=DeMtuLTrjALPNZOgVsQ4chcaGJxNT1w4WQHyFyJ0uZAjROPc6ufevZp+467xOmMLN2
         rgYvTWxM292XDnFLu61ESusdSSJqt6enxO2zMfgGp4KK3+fIpIx4mwVuZLxWaL0es9d+
         WTmdgOJeH3jaOyu2yJ3Keg+CHTtRy1vTESmDfyTN0SR+GE+BTU+aPjVexDOrvcEfmqlk
         MPyVPCU1TZwleXFhq63nrr3Kuj4Z84EK0fh2mv/KmavVL/m9jZZn3qZjA2uPdkLctwKl
         jXehm5eEiX93hQRZ6nVMgf80SkyMPFJZfssBmMoUJxx47h7YYOPvJBG4Hes3PgIEEK7k
         IzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083461; x=1778688261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPnrSgtmFF1Udoue8aZyvqxIyRTiy5EiC9+gkdriCKs=;
        b=XQzGnFDgb6f5XrZq4Jq1yprVsDYmzFc7EVseTzR1OkhBklVDJpVskW0qJlPmq/Bt+4
         D39TFjpH+aiMTJx0LTbQIVc0grtuaj2jl/XvNowAM22D9B9gwpVagD3fhJG9plGsiCVw
         FonWujEtDDrqNadwTzRlafIyv40f5TWKDuRbhpFbW2w+rEtm+fePgZizr/M5khnUP7JP
         DOLKKg4ccJ2jKytE8Tr0Dk4+JZgVNivDN0VYKKmKDhpWa5da4sV/BqVHfHhUypXFvC+J
         PmXkr+or5fhO/GA2+zL0921C6165WsctAXNUszQVa1opT6LuqPs/CWwXkxdfRluCW/iv
         AeVA==
X-Gm-Message-State: AOJu0YxWEC5SvsPG9WXJQwW9qpMIXBgPsn3SExy1RdI5jkb2RPyAcVwT
	lNp8sXeNTG52+a6AdZ9IycE0kjUU6r32FpsBmhlIFGysw0iwtEhHOTQxYA69hw==
X-Gm-Gg: AeBDieugE/f9EGWpCuvFNgIBl7yqlBBSzHde9/EK3YOWi1nhuWG29AugtTiACY0W1sE
	xQjoYjA1vQFoMmXB/uIMeyEljTUmD5n1VKt1aCHOYl2Zd2czeFmhh2aAQ2ylzMcCEw6IX+1E74p
	IccglhqcbNd1qndx6JLybZsaqs2KMPLHQPBnKq5sfqIK6qvBhpv5IhtWXh176hWaqruAF9lUjY0
	LW+grUGEh+cyTUmbvMyCQodgY6BgKt5y9FzbSELRLTQzBRw6xhLtwxftodzjWz8tTv1YSQJx9la
	7IRrmkU0PcELi8rb0tCuo1FahvKQJLQxG5nErB68/XUh3q/hAYZp0sSXPf+nO2P0QrV0V68Ei6u
	/pVGWgsXBBES1rikyR13cx9M+MkWS+W0jJo74CsjMbiidd0nMMLwknQlYAYD2jkaeABF1k7h08j
	G9QkwzZvZ79qLadji/FPM21Och6XFcaSTw5jsYrY0GGWicqr0MKy4tJYgvCfDllA==
X-Received: by 2002:a17:90b:184c:b0:35e:5ae3:298a with SMTP id 98e67ed59e1d1-365abe8096dmr4497816a91.18.1778083461098;
        Wed, 06 May 2026 09:04:21 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:5aa6:d56d:38a9:469])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4fb36f4sm2777448a91.13.2026.05.06.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:04:20 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] sched_ext: Add cookie API for early qseq capture
Date: Thu,  7 May 2026 00:04:01 +0800
Message-ID: <20260506160412.522199-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260506160412.522199-1-yphbchou0911@gmail.com>
References: <20260506160412.522199-1-yphbchou0911@gmail.com>
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
 kernel/sched/ext.c                       | 69 ++++++++++++++++++++++--
 tools/sched_ext/include/scx/common.bpf.h |  2 +
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c80f0efd42c0..ff70550e1c12 100644
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
@@ -8505,13 +8507,71 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
+/**
+ * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
+ * @p: task_struct to read cookie from
+ *
+ * Returns an opaque u64 dispatch cookie. Pass the cookie to
+ * scx_bpf_dsq_insert_with_cookie() to extend the time window during
+ * which sched_ext will detect racing dequeues/enqueues of @p. The
+ * extended window begins with this call and ends at the same point as
+ * for dispatches without cookies, i.e. when sched_ext attempts to
+ * finish the dispatch.
+ *
+ * This API is intended for schedulers that do not implement properly
+ * synchronized dequeue.
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
+ * Like scx_bpf_dsq_insert() with slice=0, but uses an early-captured
+ * @cookie to extend the dispatch race detection window. A stale cookie
+ * causes sched_ext to silently discard the dispatch. Use
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
@@ -10181,6 +10241,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_get_cookie, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5f715d69cde6..ae04f54d3dd1 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,6 +63,8 @@ s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
 			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
 bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+u64 scx_bpf_task_get_cookie(struct task_struct *p) __ksym __weak;
+bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p, u64 dsq_id, u64 enq_flags, u64 cookie) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
-- 
2.48.1

