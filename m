Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6B47CC7C
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470062; cv=none; b=YKs5vlVQAnV1vPyFkf6eqGL//eOu4DiYIkepiCMb8vqCWEN3h/MnwuXzcy7tP53vTQF/z/iAcJVkMEbp4ePFMIk9l9uDLPJLCclatIThxtOR3Qu3hDb9zBLvV1siFZxtOOVzii+4JSlMnf5mu52w7v20NkRmrpZ+BPgtbzGnuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470062; c=relaxed/simple;
	bh=qO6gn4UanxpCrFgfNrtGT1S0KDu1g33oJ6GL6IOOR/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQVFdqNOGiE2UaFfNrmbEhKfQLmhT1SGhKYl4RMJv6TxikQoby5B+i6M0x34V605ueh9M6l6y5GKwggJ4kH94rKbe6bNsxIQB8NQBKlkXwhZwC8+04St9A3tma3N2nisfNZTt+Qk03C10OFWSeKz9UrdOFIQhWHmU83eB5//bTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jab7uWBc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jab7uWBc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83659d38e38so3100526b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779470060; x=1780074860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Xf0kdb/nd9ycYypBsYXIUMkLq8x49IBlSXsUsHEn4=;
        b=jab7uWBcxOYNHs3QWS0CIdEgVaInyLxJyXOfCC1wTFdF66Znz0db/TtIxuGJWGK68v
         iH/vqvg/Q1cOdnrUO7W/rpx6ntJ/CDgaoYpqru7qEp+7ts9y24/d9QG9Mdyw4ovpBxCp
         saabPWGysAk9BWT+9Kq6yqRlDcTiDAg7SpHuen4rqsfsc2x/xvrpVjgOLfQ2RhO6I35U
         9YR0jE61fcU18IgWai4sQFoxEZGaMMq03eHwV88PvP2130laLsr55V+EIdFfpUDI8i4l
         oBC9Mi1qnxTKZ9RUT7GXK9HepA5XrtS4E8QE5jNfVyLbuVaLMEJjventWoSJEBRpULpo
         zaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470060; x=1780074860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44Xf0kdb/nd9ycYypBsYXIUMkLq8x49IBlSXsUsHEn4=;
        b=L5+jI7e+JfEXygWVuT88Oaog5U6pz0EuJoPmoKLoVLAFh4GgQljct+TT2Z+OItLgdM
         lm4Bmzu71xnzv6mCiakOIR3BRnkgashfgKsP4eLm0NTlqGxpU1QOCK8HDwauEJsxNMf/
         /g8O5k4LQQctqExMMm1EJC1ul9cCKCYdhVOpj5YBkSevuklKsaA0Lf9FTX2fERbLt+lA
         s3iXostj5Nam261S31fpHmjs5LJ71TkQ5j/KU7NQPuUA7xDW0XUkaJpk7y9vs/VnjjRY
         yWctlKSLCpE2qkZJxI/+NZPNO13ejZIqg0hS1UIM4uthJKzNfU6CN2Ub2KLeN8p8gbK3
         aEkw==
X-Gm-Message-State: AOJu0Yyfk7yUhlGT4qnwh7lgbBDczCtbh5CEN6fM6qRRTOTTtC+KK+BO
	RUYe6cVBaId6jwT7p/18zPCPTeERUJ0XBCGyjy2mCAbIjf3G/qQXMTTM80QKJQ==
X-Gm-Gg: Acq92OHB8+K86hNJsXDPsd0QmjdwfXkZptLSiPIayjur4X06mxufJlTu3QpPopyVLfk
	moujWOVpwrD7o1mPbtlYxyGscHmM5U/O1HWjpHaAlfXdQCPYsfbEiH2FBLl294LvErcovl0cTRn
	cP1Ezp5ymyXLbFFNsj5siAMTugyTbZpnV/mbQ2BDx39tDj7yY35CO06B1+S3timdGfSBiuvFsi1
	eLCYAw0rK6n44StdyNdmwC0iBSSmXUnzXL3BFOZSVbzUnWcOik9nibvR9vDs+kDQnZpv5pW83aF
	4h8Ep8cDHFfpfRAHNdIZvrSNp2+53DzVlhSQNP0kbbdbZ1Bz/kyiIvpdkMBO1XJ5EyV7G0l8ACu
	msl5DwIhejHcJvFXS4sosPGYAk5qSmE6kofy/U2Ea4ys2qtKqEZFferRXx36YWj/r+69nkNH4lC
	oFVd2ndmtdjcBM/lfFEUouE+F2oUx1WAT4ViDyp/3TCpy0T/aPsbpdOw4oQF4D
X-Received: by 2002:a05:6a00:4292:b0:83e:b125:ff30 with SMTP id d2e1a72fcca58-8415f2d6d66mr4683897b3a.7.1779470060175;
        Fri, 22 May 2026 10:14:20 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d6b:1176:68e:1fdb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe338sm2517549b3a.18.2026.05.22.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:14:19 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] tools/sched_ext: scx_qmap: fix arena stores
Date: Sat, 23 May 2026 01:13:19 +0800
Message-ID: <20260522171406.2171819-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260522171406.2171819-1-yphbchou0911@gmail.com>
References: <20260522171406.2171819-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With __BPF_FEATURE_ADDR_SPACE_CAST, LLVM maintains two aliases for
each arena pointer: a scalar (from the map_value load) and a
PTR_TO_ARENA (from the addr_space_cast it auto-emits). Liveness
analysis kills the PTR_TO_ARENA alias at the last arena read. After
that point only the scalar survives. When LLVM generates arena field
stores, it uses the scalar register, and the BPF verifier rejects the
program with "RN invalid mem access 'scalar'".

This manifests in qmap_fifo_remove() (qmap_dequeue), qmap_fifo_pop()
(qmap_dispatch), and qmap_init_task()/qmap_exit_task() after a
spin-lock or unlock call.

Casting to scalar, opacifying with barrier_var(), and casting back to
arena does not work. With __BPF_FEATURE_ADDR_SPACE_CAST, LLVM
understands both ends of the round-trip and silently eliminates it
even across the barrier.

Use bpf_addr_space_cast() at every site where the arena alias dies
before a write: qmap_fifo_enqueue(), qmap_fifo_pop(),
qmap_fifo_remove(), qmap_init_task(), and qmap_exit_task().

Fixes: 1d2c5353152d ("sched_ext: scx_qmap: replace FIFO queue maps with arena-backed lists")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 85 +++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 7e77f22674ea..a6019e8fe0cc 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -256,17 +256,21 @@ static task_ctx_t *lookup_task_ctx(struct task_struct *p)
 static void qmap_fifo_enqueue(struct qmap_fifo __arena *fifo, task_ctx_t *taskc)
 {
 	struct bpf_res_spin_lock *lock = qa_q_lock(fifo->idx);
+	struct task_ctx *__tc;
 
 	if (!lock || qmap_spin_lock(lock))
 		return;
-	taskc->fifo = fifo;
-	taskc->q_next = NULL;
-	taskc->q_prev = fifo->tail;
+	__tc = (struct task_ctx *)taskc;
+	barrier_var(__tc);
+	bpf_addr_space_cast(__tc, 0, 1);
+	__tc->fifo = fifo;
+	__tc->q_next = NULL;
+	__tc->q_prev = fifo->tail;
 	if (fifo->tail)
-		fifo->tail->q_next = taskc;
+		fifo->tail->q_next = (task_ctx_t *)__tc;
 	else
-		fifo->head = taskc;
-	fifo->tail = taskc;
+		fifo->head = (task_ctx_t *)__tc;
+	fifo->tail = (task_ctx_t *)__tc;
 	bpf_res_spin_unlock(lock);
 }
 
@@ -274,6 +278,7 @@ static void qmap_fifo_enqueue(struct qmap_fifo __arena *fifo, task_ctx_t *taskc)
 static task_ctx_t *qmap_fifo_pop(struct qmap_fifo __arena *fifo)
 {
 	struct bpf_res_spin_lock *lock = qa_q_lock(fifo->idx);
+	struct task_ctx *__tc;
 	task_ctx_t *taskc;
 
 	if (!lock || qmap_spin_lock(lock))
@@ -285,9 +290,12 @@ static task_ctx_t *qmap_fifo_pop(struct qmap_fifo __arena *fifo)
 			taskc->q_next->q_prev = NULL;
 		else
 			fifo->tail = NULL;
-		taskc->q_next = NULL;
-		taskc->q_prev = NULL;
-		taskc->fifo = NULL;
+		__tc = (struct task_ctx *)taskc;
+		barrier_var(__tc);
+		bpf_addr_space_cast(__tc, 0, 1);
+		__tc->q_next = NULL;
+		__tc->q_prev = NULL;
+		__tc->fifo = NULL;
 	}
 	bpf_res_spin_unlock(lock);
 	return taskc;
@@ -298,6 +306,8 @@ static void qmap_fifo_remove(task_ctx_t *taskc)
 {
 	struct qmap_fifo __arena *fifo = taskc->fifo;
 	struct bpf_res_spin_lock *lock;
+	task_ctx_t *q_next, *q_prev;
+	struct task_ctx *__tc;
 
 	if (!fifo)
 		return;
@@ -312,17 +322,29 @@ static void qmap_fifo_remove(task_ctx_t *taskc)
 		return;
 	}
 
-	if (taskc->q_next)
-		taskc->q_next->q_prev = taskc->q_prev;
+	q_next = taskc->q_next;
+	q_prev = taskc->q_prev;
+
+	/*
+	 * NULL out @taskc's queue pointers before updating its neighbors.
+	 * The arena alias dies after loading q_next/q_prev. Refresh it via
+	 * bpf_addr_space_cast() - see bpf_arena_common.bpf.h.
+	 */
+	__tc = (struct task_ctx *)taskc;
+	barrier_var(__tc);
+	bpf_addr_space_cast(__tc, 0, 1);
+	__tc->q_next = NULL;
+	__tc->q_prev = NULL;
+	__tc->fifo = NULL;
+
+	if (q_next)
+		q_next->q_prev = q_prev;
 	else
-		fifo->tail = taskc->q_prev;
-	if (taskc->q_prev)
-		taskc->q_prev->q_next = taskc->q_next;
+		fifo->tail = q_prev;
+	if (q_prev)
+		q_prev->q_next = q_next;
 	else
-		fifo->head = taskc->q_next;
-	taskc->q_next = NULL;
-	taskc->q_prev = NULL;
-	taskc->fifo = NULL;
+		fifo->head = q_next;
 	bpf_res_spin_unlock(lock);
 }
 
@@ -762,6 +784,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 			     struct scx_init_task_args *args)
 {
 	struct task_ctx_stor_val *v;
+	struct task_ctx *__tc;
 	task_ctx_t *taskc;
 
 	if (p->tgid == disallow_tgid)
@@ -779,10 +802,13 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 		return -ENOMEM;
 	}
 
-	taskc->next_free = NULL;
-	taskc->q_next = NULL;
-	taskc->q_prev = NULL;
-	taskc->fifo = NULL;
+	__tc = (struct task_ctx *)taskc;
+	barrier_var(__tc);
+	bpf_addr_space_cast(__tc, 0, 1);
+	__tc->next_free = NULL;
+	__tc->q_next = NULL;
+	__tc->q_prev = NULL;
+	__tc->fifo = NULL;
 	taskc->tid = p->scx.tid;
 	taskc->pid = p->pid;
 	taskc->force_local = false;
@@ -798,8 +824,11 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 	if (!v) {
 		/* push back to the free list */
 		if (!qmap_spin_lock(&qa_task_lock)) {
-			taskc->next_free = qa.task_free_head;
-			qa.task_free_head = taskc;
+			__tc = (struct task_ctx *)taskc;
+			barrier_var(__tc);
+			bpf_addr_space_cast(__tc, 0, 1);
+			__tc->next_free = qa.task_free_head;
+			qa.task_free_head = (task_ctx_t *)__tc;
 			bpf_res_spin_unlock(&qa_task_lock);
 		}
 		return -ENOMEM;
@@ -812,6 +841,7 @@ void BPF_STRUCT_OPS(qmap_exit_task, struct task_struct *p,
 		    struct scx_exit_task_args *args)
 {
 	struct task_ctx_stor_val *v;
+	struct task_ctx *__tc;
 	task_ctx_t *taskc;
 
 	v = bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
@@ -822,8 +852,11 @@ void BPF_STRUCT_OPS(qmap_exit_task, struct task_struct *p,
 
 	if (qmap_spin_lock(&qa_task_lock))
 		return;
-	taskc->next_free = qa.task_free_head;
-	qa.task_free_head = taskc;
+	__tc = (struct task_ctx *)taskc;
+	barrier_var(__tc);
+	bpf_addr_space_cast(__tc, 0, 1);
+	__tc->next_free = qa.task_free_head;
+	qa.task_free_head = (task_ctx_t *)__tc;
 	bpf_res_spin_unlock(&qa_task_lock);
 }
 
-- 
2.48.1

