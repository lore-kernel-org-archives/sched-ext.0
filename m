Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1D486BA7;
	Thu, 23 Jul 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827884; cv=none; b=mSF6D68VnJ2NDjYlGZ5ACJPbLpAjkRD0dQvbuQ5qxc9+wXNzjxarl2n1vNK1kuT7klx6wyg8OCfNjfOhaBg7EwJ6LJ40/AMPCtdzVPhETN9RRPS6ll84Q8dtkk8zAkUU1R5L9YxwggBGWW2W2hRzObQnQCa8kTkENZK5Tx3628A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827884; c=relaxed/simple;
	bh=uH7OD7e/Oc9elhpkqBLy7L7UIbZBhwC4SOZlvUHLW+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrHbFyjA+88KrDiNZiK1AhxyNYG8ksgQLa0BkPdk/j+PccaVAkui4cZwQzFC8JmSaA7mNB4Z4dubQv3zKwEwxb9jMqjjIf8DexrSfTV/X8bmhvMkPc5xPlCr8fmRwHDYPFW3+iZ8ouu6QQR36JHwYJ4GQUu2LiIKrIJVvqjBGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=envfQh4X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="envfQh4X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=L4Gy7aBw3yor/0bRmtTEw3QON8BLQ4+AVZA8wiTqSck=; b=envfQh4XLRQXAVCYD/PSG8hYP+
	+6B8Ke+dUfFwvn7HFBVgsBNR+YAWTvVeCPkkjVptmbet9xWRNk5YytG5SXRhvd2fS3ENuRB1Zxr6F
	q/8lvoaya2B3RYlB+n9y3hmDab57XXM0wwdwoR6lbQQUE1iCC28bzwNANn3m8yVQ6P5yifhVp9/IX
	Ng8wFcwyivDvXJl2bM99HB3Ds5nKW1JGzaOWYaei4y3FIJxFJL4gG417yh+j7lhZadE5c1zDDigxP
	OyJH+Tg7Fyim3sI9qZLkTniJDowUxGabUsSqyOOr7Wbgk/CqT5jw5qoKBdBj2SCMOYbF8m5ozqEab
	lvNk1EEw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmxGT-0000000Epeg-0J1v;
	Thu, 23 Jul 2026 17:31:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH] sched_ext: repair kernel-doc comments
Date: Thu, 23 Jul 2026 10:31:18 -0700
Message-ID: <20260723173118.327466-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing function parameter descriptions and use the correct
function name in kernel-doc comments to avoid kernel-doc warnings:

Warning: kernel/sched/ext/ext.c:2692 function parameter 'sch' not described in 'finish_dispatch'
Warning: kernel/sched/ext/ext.c:5309 function parameter 'stalled_mask' not described in 'scx_rcu_cpu_stall'
Warning: kernel/sched/ext/ext.c:5405 function parameter 'cpu' not described in 'scx_hardlockup'
Warning: kernel/sched/ext/ext.c:8470 expecting prototype for scx_bpf_dsq_insert(). Prototype was for scx_bpf_dsq_insert___v2() instead
Warning: kernel/sched/ext/ext.c:8784 expecting prototype for scx_bpf_dsq_move_to_local(). Prototype was for scx_bpf_dsq_move_to_local___v2() instead
Warning: kernel/sched/ext/ext.c:9498 expecting prototype for scx_bpf_reenqueue_local(). Prototype was for scx_bpf_reenqueue_local___v2() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev

 kernel/sched/ext/ext.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-next-20260722.orig/kernel/sched/ext/ext.c
+++ linux-next-20260722/kernel/sched/ext/ext.c
@@ -2669,6 +2669,7 @@ static void dispatch_to_local_dsq(struct
 
 /**
  * finish_dispatch - Asynchronously finish dispatching a task
+ * @sch: the scheduler
  * @rq: current rq which is locked
  * @p: task to finish dispatching
  * @qseq_at_dispatch: qseq when @p started getting dispatched
@@ -5296,6 +5297,7 @@ static __printf(2, 3) bool handle_lockup
 
 /**
  * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
+ * @stalled_mask: bit mask of stalled CPUs
  *
  * While there are various reasons why RCU CPU stalls can occur on a system
  * that may not be caused by the current BPF scheduler, try kicking out the
@@ -5390,6 +5392,7 @@ static DEFINE_IRQ_WORK(scx_hardlockup_ir
 
 /**
  * scx_hardlockup - sched_ext hardlockup handler
+ * @cpu: the target CPU
  *
  * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putting
  * numerous affinitized tasks in a single queue and directing all CPUs at it.
@@ -8426,7 +8429,7 @@ static void scx_dsq_insert_commit(struct
 __bpf_kfunc_start_defs();
 
 /**
- * scx_bpf_dsq_insert - Insert a task into the FIFO queue of a DSQ
+ * scx_bpf_dsq_insert___v2 - Insert a task into the FIFO queue of a DSQ
  * @p: task_struct to insert
  * @dsq_id: DSQ to insert into
  * @slice: duration @p can run for in nsecs, 0 to keep the current value
@@ -8756,7 +8759,7 @@ __bpf_kfunc void scx_bpf_dispatch_cancel
 }
 
 /**
- * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
+ * scx_bpf_dsq_move_to_local___v2 - move a task from a DSQ to the current CPU's local DSQ
  * @dsq_id: DSQ to move task from. Must be a user-created DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  * @enq_flags: %SCX_ENQ_*
@@ -9485,7 +9488,7 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 d
 }
 
 /**
- * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ * scx_bpf_reenqueue_local___v2 - Re-enqueue tasks on a local DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
