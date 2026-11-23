Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453840;
	b=16LtYOcgk/dHnwH+TzUePrkmUdiV1E5OEAxScDqD3h/GBNOVXINSax1S0OfEcefN6QfD
	 Gvxq/0sqjbmoo3PbYtm54J/WfEXi1MHrGZI+jdzJAd4f8H2D5WqLTdNNHqzfwSFYs76Kj
	 YL4aIn65W+Wxtg1et31xDwyIIj7UAtQTkpmzd8167Fq+zJxDArWe/D5iyj2frWk/gAYvH
	 yboXxdcLYoVVWsemrTc+GN+gQjTC1/BnVBkRCgAH8hqDz2ZfFDYiGV+QlEfpFGX8k/BPm
	 NFaz/MBTbEpfkA6ZCprr5M+GD4L8+UDdn3lcO1EB8QUNFuNoKRq6Gg8TJrzqSqyyOPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t25R0OQppt5JZE3XIImm1+OnaJwjOmNRYl7971qMLRY=;
	b=rRWwrLhpzGUnUrqdUUa7WLAMQery6i8l5kF8bS6RuwPRDZ/H53EqtHKyYsAGert6/2B7
	 zZlyjcUOcWQ3s7kbNVNSWtOcVmphZVb1PA0HAiEAdb0RAAYMpi4nLYhd0kHALXmoFtLa5
	 yk/Z8NsKZ5sCoMJ42/EqOa9QBJJV5V8uSQAPPKCxN+JpSmdTKaSXK0Tq1J6CuNmbqeQms
	 dwl057QaTUTVZPLNjyixpCIQpaWkQL9nIi4EJGqaSl059x9rKBC7YnkRppiu/znvg7FuX
	 c+FN5Hid64SZZleJZmwJIG1BWEr5CgoSoPxhsa6M7ke424SWcypiba1pHWg5OVX5Khw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ENWrvpba;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BC606A6B8
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8BC606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ENWrvpba
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48fbcf023dcso1567063f8f.2
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795453838; x=1796058638; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t25R0OQppt5JZE3XIImm1+OnaJwjOmNRYl7971qMLRY=;
        b=ENWrvpbaEOa4DVFQooLyA/WSLhEdWvyXK7sdgte7KQA3qiryLEY+2tctKFiBL2YFax
         SKAw4KMXq47RC0ARW2dmzaoClnbIyvmao2G4/xdb2O8IOrIw5bDeqPxHvX1Cq9LZDet0
         t6FBRL8374wN8v1TaJU4EMPmdpMCYMoIV5loUCh9Q2MmmRBUj63SvigHc6/En+LE0oyV
         cVikf4uHwuLOAd2up6OarFNfu8PvEkn7s51PW4YnjUNgsf/S3ACea4fhMrfmHfbAzyPP
         AtJ5X9lcqPVEo8ZB8Gqw5xyOH5Ls+i80v64D/3sLxZI1KNTrqq+qpfhAfSDrs3wkmPuY
         aXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453838; x=1796058638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t25R0OQppt5JZE3XIImm1+OnaJwjOmNRYl7971qMLRY=;
        b=XsfF1sSrnNB/RkKbS9XqoNnjYrIiCv0znD/dco1oVE44n646/V6UIr3+JsgwKegzfy
         UXVlKK3tAQrVixh2cRWKYpBwUtZBQQPx8Bf0zQQiJRYD9x18QpvsYe4Fs0dUQyh5r8Wq
         incUfcudhHrpg4RrsVOljLVkUOEU/2LgyyGftNwhrWx7Munm9kfHxRyWJimGUukwu5Kf
         jVy0XU68Ff9FARNFw/P9tSlzfVodjGgZmJRc2vGTiig/fuOulnO2B18ShqjLFKJoWno/
         CNHPBR7r9gs5Le83MVk/WB4AgmUKKRGdSU5Hi8l+wC0vd+TwWiYJ0BZP6GVCMrilvXcs
         1RiA==
X-Forwarded-Encrypted: i=1; AL+hErGyECa1Oylnq5a75wLNdM84LkQVmHirzF9WUDp6jhOcLLbFax+XNaKtkrb51j9r36z6kkdimF7mNF0=@lists.linux.dev
X-Gm-Message-State: APuU4Z/2u0YsmfncU0wPXvelxpg1Eu/zSuVjjlhb9j2mUh8bNsl2gC6u
	9t3IsLTN81dpqFvbvZTSnl5VMZo4gE96wxrQHI+45sV8kEy7YN2eCjc/FXWMRYZIUd2wRbQxXWP
	UaLwh/ab/p1SkZw==
X-Received: from wmbh22.prod.google.com ([2002:a05:600c:a116:b0:4a2:677:24c])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr168409645e9.26.1795453838453;
 Mon, 23 Nov 2026 09:10:38 -0800 (PST)
Date: Mon, 23 Nov 2026 17:10:34 +0000
In-Reply-To: <20261123170846.3165648-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123170846.3165648-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123170846.3165648-4-jpiecuch@google.com>
Subject: [PATCH 3/3] selftests/sched_ext: Test that ops.dequeue() runs with
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
2.56.1.750.gf70dc682cf-goog

