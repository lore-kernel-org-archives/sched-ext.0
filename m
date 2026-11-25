Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606125;
	b=VEjDTgx8Ca6J6wWV7HmT1jVJVeuTCbXenBNx15i1HAPdPEH2ZjncZf7+675AnN9/29jl
	 1YVJqtsC+4JAXRjR8tnPuKmlOW26fGs3lAmpfJ35ekVw36u4Bg6wMWix0vrZNoLdgr2O0
	 EKLZcytTluZhGCl+gqVhbDIzf0sCbwAMqxeJjz3NtJVQX8SZ6zR+3xnwzreNIIYtQWgFX
	 YHpwphhZb52m+u8Waltimpxq1yC4ZTOCNADx3Sbfr1Kjk0z4WxgXPPp+6C1KofTyhJ0CJ
	 b5bE8RM7r9d9LQi6mFlbhAWsxNwqW6kLW53GFYx7KfVgwiHB1szhxzO4k0wuYBCNw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PH9AUh7w6ThZJsKaitS9ec4EBwWzCSLKSPBtEPu/DFo=;
	b=gzL23pAT6df+Oq2IztRI5l9uM9g9HWQaBePNShvjNug7WS1jnAyCr2+zQzOe/67ihAx8
	 p1CazUfFoFs55Y2T0sbRFIpbFjPN2G+QOr6qAuK6UfR3Jj5qDGeKDEVAmYB2DscxLmi/2
	 iz5/eoxit+90j9GhO7ZxcLK2Cnu+TZ4FlPJsEdrehhT9m19g6a1mkQSY8VZgSaSuOTyqL
	 s2Pu3gzOrhhNaEn1+hY4XAnxWtekJLUv0eo1pwg4ajDDYkL5uLrAY+pFoe+49ffru/mTR
	 HJhfndyUnn3tP3huYsqTrCvhhNmn6u5RcF0mWNp/jI50fwoHRfzcrAG4bwKL3jRJNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="TbXef/i3";
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9ED606A688
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9ED606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbXef/i3
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso31835445e9.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606123; x=1796210923; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PH9AUh7w6ThZJsKaitS9ec4EBwWzCSLKSPBtEPu/DFo=;
        b=TbXef/i3wZSbqdIl82ZFw1KoL8fFPIodZ1KiNLhi4g6fjlStYi0sHBBKSvH7fZNnTj
         W0xDNPJNGFC80VQeFaxgFal+nl2gknj2I2w/pyVWFY93DsTuxcrjCW6LDJPfmc8mi07m
         n0uMFh6l+m7HIeNrA8Z/AcGMdIeSi8SjpvbdbyCIsxl9ttdmsHWa5sILGbV0delkLCkD
         q60hwWKYCvQ3J+DM+f/nsGvNGqxa/5z2viSrZOujavOjLzoxW1y6yTqx/dQsNR3pbpOU
         SkDpXPYkKavCqoH07nHsaViCR4GFHmKaR+CpqAhvvjVcb7Vh0xIC5+QcBhkWYxja6+Yb
         xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606123; x=1796210923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PH9AUh7w6ThZJsKaitS9ec4EBwWzCSLKSPBtEPu/DFo=;
        b=LvHJFfDsQqKRtdl2jqdba1lMWBevY3aR0y/PKbBpvwHL45V7+KtZazrg3C6dC2ZoNQ
         DybUthm4StmffeFmOzta1+l+tPK+aLOu5wB4A/VNJgyjZQIhdq3+/PjJzDQmR/+MIwA5
         skxvabegBWM8eeje60vsra1Yymtyq3h+w+99e+KupnE14Q0JKMWFNY+wOzRnMEl2QEq3
         DPPU+gyJdTBYAcJzsh7Zx+1E+Xs05CO47a27qy+tpximiWBAkPGB4+KWB6w/Jq9wxjLf
         BTxZPDrxRyf25XeBCIUMoqvJqkaGmhWmBsTyJKaS+RPjnu2xngfTyd6OwrgTp6DADiHB
         Gxyw==
X-Forwarded-Encrypted: i=1; AL+hErGX1wOEMwBroFk92S1Zrj3XdoP9NByT2MH91GMCBwtEFYOisU9QTp+cOALV3NxkCy7WDyzsmaZHTZU=@lists.linux.dev
X-Gm-Message-State: APuU4Z9EhpnX0doUMA/oKCUYNvHnK1w34p7DeubGaeuijIdhZCE0gGxT
	2OvTb9QHE57fQOu2QokKWDVrAX35JLTHuar93t6VpswDmBoRJuc9dvDfJvKJi39/zSgP6DbCCqg
	NTqhz9ikcUOOTzg==
X-Received: from wmbz19.prod.google.com ([2002:a05:600c:c093:b0:4a2:8b4:78e1])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr329998235e9.19.1795606123419;
 Wed, 25 Nov 2026 03:28:43 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:38 +0000
In-Reply-To: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125112553.1539758-5-jpiecuch@google.com>
Subject: [PATCH v2 4/4] selftests/sched_ext: Test that ops.dequeue() runs with
 the task's rq locked
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check in dequeue_remote's ops.dequeue() that scx_bpf_locked_rq() is the
task's rq, and add a scenario that inserts tasks into SCX_DSQ_GLOBAL from
ops.dispatch(), mostly from CPUs other than the task's.

dequeue_remote fails without "sched_ext: Fix ops_state and ops.dequeue()
locking races in dispatch".

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 .../selftests/sched_ext/dequeue_remote.bpf.c  | 34 +++++++++++++++--
 .../selftests/sched_ext/dequeue_remote.c      | 37 +++++++++++++++----
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
index 983590c6d498..8996bcc96e1d 100644
--- a/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
@@ -8,7 +8,11 @@
  * the dispatching CPU's local DSQ, so most moves cross CPUs. With
  * @test_use_move_to_local, tasks are queued on a user DSQ and consumed with
  * scx_bpf_dsq_move_to_local(). Otherwise, they are queued in a BPF queue and
- * dispatched with SCX_DSQ_LOCAL_ON.
+ * dispatched with SCX_DSQ_LOCAL_ON or, with @test_use_global, inserted into
+ * SCX_DSQ_GLOBAL, often from a CPU other than the task's.
+ *
+ * ops.dequeue() also verifies that it's always called with the task's rq
+ * locked.
  *
  * Copyright (c) 2026 Google LLC.
  */
@@ -53,10 +57,11 @@ struct task_struct___core_sched {
 } __attribute__((preserve_access_index));
 
 bool test_use_move_to_local;
+bool test_use_global;
 
 u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
 u64 remote_dispatch_cnt, remote_running_cnt, missed_dequeue_cnt;
-u64 core_sched_exec_dequeue_cnt;
+u64 core_sched_exec_dequeue_cnt, remote_global_cnt, wrong_rq_dequeue_cnt;
 
 static struct task_ctx *lookup_task_ctx(struct task_struct *p)
 {
@@ -121,9 +126,22 @@ void BPF_STRUCT_OPS(dequeue_remote_enqueue, struct task_struct *p, u64 enq_flags
 void BPF_STRUCT_OPS(dequeue_remote_dequeue, struct task_struct *p, u64 deq_flags)
 {
 	struct task_ctx *tctx;
+	struct rq *locked_rq;
 
 	__sync_fetch_and_add(&dequeue_cnt, 1);
 
+	/*
+	 * ops.dequeue() must always run with @p's rq locked, even when @p is
+	 * inserted into SCX_DSQ_GLOBAL by ops.dispatch() on another CPU.
+	 */
+	locked_rq = scx_bpf_locked_rq();
+	if (!locked_rq || locked_rq->cpu != scx_bpf_task_cpu(p)) {
+		__sync_fetch_and_add(&wrong_rq_dequeue_cnt, 1);
+		scx_bpf_error("%d (%s): dequeue without task rq lock (locked=%d cpu=%d)",
+			      p->pid, p->comm, locked_rq ? locked_rq->cpu : -1,
+			      scx_bpf_task_cpu(p));
+	}
+
 	tctx = lookup_task_ctx(p);
 	if (!tctx)
 		return;
@@ -187,7 +205,17 @@ void BPF_STRUCT_OPS(dequeue_remote_dispatch, s32 cpu, struct task_struct *prev)
 			continue;
 		}
 
-		if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+		if (test_use_global) {
+			/*
+			 * @p goes on the global DSQ of its own node, which this
+			 * CPU may not consume. Kick @p's CPU in case it's idle.
+			 */
+			if (scx_bpf_task_cpu(p) != cpu) {
+				__sync_fetch_and_add(&remote_global_cnt, 1);
+				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+			}
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		} else if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			if (scx_bpf_task_cpu(p) != cpu)
 				__sync_fetch_and_add(&remote_dispatch_cnt, 1);
 			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu,
diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/testing/selftests/sched_ext/dequeue_remote.c
index af344581d5f1..aab6dfb2d64f 100644
--- a/tools/testing/selftests/sched_ext/dequeue_remote.c
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Verify that ops.dequeue() is called for tasks leaving BPF custody through
- * an SCX-internal cross-CPU migration (move_remote_task_to_local_dsq()).
+ * an SCX-internal cross-CPU migration (move_remote_task_to_local_dsq()) and
+ * that it always runs with the task's rq locked, including when the task is
+ * inserted into SCX_DSQ_GLOBAL from another CPU.
  *
  * Copyright (c) 2026 Google LLC.
  */
@@ -54,7 +56,7 @@ static void worker_fn(int id)
 }
 
 static enum scx_test_status run_scenario(struct dequeue_remote *skel,
-					 bool use_move_to_local,
+					 bool use_move_to_local, bool use_global,
 					 const char *name)
 {
 	enum scx_test_status ret = SCX_TEST_PASS;
@@ -69,6 +71,7 @@ static enum scx_test_status run_scenario(struct dequeue_remote *skel,
 		nr_workers = MAX_WORKERS;
 
 	skel->bss->test_use_move_to_local = use_move_to_local;
+	skel->bss->test_use_global = use_global;
 	skel->bss->enqueue_cnt = 0;
 	skel->bss->dequeue_cnt = 0;
 	skel->bss->dispatch_dequeue_cnt = 0;
@@ -77,6 +80,8 @@ static enum scx_test_status run_scenario(struct dequeue_remote *skel,
 	skel->bss->remote_running_cnt = 0;
 	skel->bss->missed_dequeue_cnt = 0;
 	skel->bss->core_sched_exec_dequeue_cnt = 0;
+	skel->bss->remote_global_cnt = 0;
+	skel->bss->wrong_rq_dequeue_cnt = 0;
 	memset(&skel->data->uei, 0, sizeof(skel->data->uei));
 
 	link = bpf_map__attach_struct_ops(skel->maps.dequeue_remote_ops);
@@ -126,7 +131,10 @@ static enum scx_test_status run_scenario(struct dequeue_remote *skel,
 	       (unsigned long)skel->bss->dequeue_cnt,
 	       (unsigned long)skel->bss->dispatch_dequeue_cnt,
 	       (unsigned long)skel->bss->change_dequeue_cnt);
-	if (!use_move_to_local)
+	if (use_global)
+		printf("  remote SCX_DSQ_GLOBAL dispatches: %lu\n",
+		       (unsigned long)skel->bss->remote_global_cnt);
+	else if (!use_move_to_local)
 		printf("  remote SCX_DSQ_LOCAL_ON dispatches: %lu\n",
 		       (unsigned long)skel->bss->remote_dispatch_cnt);
 	printf("  ran on a CPU other than the enqueue CPU: %lu\n",
@@ -135,15 +143,25 @@ static enum scx_test_status run_scenario(struct dequeue_remote *skel,
 	       (unsigned long)skel->bss->missed_dequeue_cnt);
 	printf("  late SCX_DEQ_CORE_SCHED_EXEC dequeues: %lu\n",
 	       (unsigned long)skel->bss->core_sched_exec_dequeue_cnt);
+	printf("  dequeues without the task's rq locked: %lu\n",
+	       (unsigned long)skel->bss->wrong_rq_dequeue_cnt);
 
 	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_UNREG))
 		SCX_ERR("Scheduler exited with kind=%lld: %s",
 			(long long)skel->data->uei.kind, skel->data->uei.msg);
 	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
 
-	/* the test is meaningless if no task was moved across CPUs */
-	SCX_GT(skel->bss->remote_running_cnt, 0);
+	/*
+	 * The test is meaningless if no task was moved across CPUs. Global DSQs
+	 * are per node, so the global scenario may not migrate tasks at all and
+	 * needs remote global dispatches instead.
+	 */
+	if (use_global)
+		SCX_GT(skel->bss->remote_global_cnt, 0);
+	else
+		SCX_GT(skel->bss->remote_running_cnt, 0);
 	SCX_EQ(skel->bss->enqueue_cnt, skel->bss->dequeue_cnt);
+	SCX_EQ(skel->bss->wrong_rq_dequeue_cnt, 0);
 
 	return SCX_TEST_PASS;
 }
@@ -174,16 +192,21 @@ static enum scx_test_status run(void *ctx)
 	struct dequeue_remote *skel = ctx;
 	enum scx_test_status status;
 
-	status = run_scenario(skel, false,
+	status = run_scenario(skel, false, false,
 			      "BPF queue -> SCX_DSQ_LOCAL_ON | cpu");
 	if (status != SCX_TEST_PASS)
 		return status;
 
-	status = run_scenario(skel, true,
+	status = run_scenario(skel, true, false,
 			      "user DSQ -> scx_bpf_dsq_move_to_local()");
 	if (status != SCX_TEST_PASS)
 		return status;
 
+	status = run_scenario(skel, false, true,
+			      "BPF queue -> SCX_DSQ_GLOBAL");
+	if (status != SCX_TEST_PASS)
+		return status;
+
 	return SCX_TEST_PASS;
 }
 
-- 
2.56.1.839.g22a8290db9-goog

