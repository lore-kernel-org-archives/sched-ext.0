Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBA2727FA;
	Sat,  7 Mar 2026 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843300; cv=none; b=bdpl1GxoyzHZwfZPxOLueVHBcj2BjIbIpmqAdW2TJduvVtQ4WgHKdT78ol3roMEdrnTNDRXbk6Kjx8s0deRX27idg8WWTB6vS4fPREcoNfiLtlkPQVoXHgR8j2ETyTQlTnfnOLQt6HCAzxwtBwY8a8ZDnw5cHqbspTtNSNS/yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843300; c=relaxed/simple;
	bh=fCe5eqkdYeOC6Tt0jPIItuOeGjxUJfILC/UKJGuznwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it0HM+aCy9J7lgrYa6jLpdvMepSmsHRc6EZsa3jpKpatBEsUtt2OOeQ2bLT0PYlIoFBeFEIVqmpladA2rP7Pcv0iDqJ6SVxkFDIaxPFMQjfImcUFq1yBbEUigJqrGvuq0PGczOzzYXjnaq+pF9oxjulbBcVJwTVtkjPDZGrRlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyoo4pUz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyoo4pUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC5C4CEF7;
	Sat,  7 Mar 2026 00:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843300;
	bh=fCe5eqkdYeOC6Tt0jPIItuOeGjxUJfILC/UKJGuznwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyoo4pUzXCpVzF9ITXmk777SAMbAJ3oRo114IwZ1ACzZ4sbjm03JtU99GiIKKw9uY
	 2GZc+1VXot0iBl393pP1L55U2wO8xLCTg+rFUC56psviIjka+rPklTpJHev4gWbjvh
	 +CXX6ePrcemtXmD623tL5Dqp6swd8vty3Tki7qMs7KUcTw/RAW8u6lx3uSaUofevNz
	 cJuktQEN1pDL0iuh+Y7INOJ6LWUS3sOFvEfxkTng75OP6dpltaDcQQzjdBLI5ztVpB
	 j7Cnxyu9frADAorzI2E/fMcVxshB0lqN41dj/q5ACIs0jqHexAgo/EM/hQCxqB1+7m
	 Ecq1XV05oy9Xw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Disallow setting slice to zero via scx_bpf_task_set_slice()
Date: Fri,  6 Mar 2026 14:28:15 -1000
Message-ID: <20260307002817.1298341-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307002817.1298341-1-tj@kernel.org>
References: <20260307002817.1298341-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task's slice can reach zero through natural consumption in update_curr_scx()
as time passes, yielding, and preemption. In all these cases, the task is
about to go through scheduling and off CPU. scx_bpf_task_set_slice() is
currently the only path that can set slice to zero without triggering a
scheduling event.

The upcoming SCX_ENQ_IMMED flag will allow BPF schedulers to dispatch tasks
only when the target CPU can run the task immediately. To determine whether
a CPU is open for new tasks, the core can test whether the current task's
slice is zero.

Close the hole by disallowing scx_bpf_task_set_slice() from setting slice to
zero. To preempt the current task, use scx_bpf_kick_cpu() with SCX_KICK_PREEMPT.
To force slice expiration on the next tick, set it to 1.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66af7a83bb1e..8c42405e27fd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8210,11 +8210,17 @@ __bpf_kfunc_start_defs();
 /**
  * scx_bpf_task_set_slice - Set task's time slice
  * @p: task of interest
- * @slice: time slice to set in nsecs
+ * @slice: non-zero time slice to set in nsecs
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's time slice to @slice. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
+ *
+ * @slice cannot be zero to ensure that 0 slice reliably indicates that the task
+ * has expired and is soon to go through scheduling. To clear the slice of a
+ * running task and trigger preemption, use scx_bpf_kick_cpu() with
+ * %SCX_KICK_PREEMPT. To force slice expiration on the next tick, use 1 which is
+ * practically guaranteed to expire on the following tick.
  */
 __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 					const struct bpf_prog_aux *aux)
@@ -8226,6 +8232,11 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!scx_task_on_sched(sch, p)))
 		return false;
 
+	if (unlikely(!slice)) {
+		scx_error(sch, "scx_bpf_task_set_slice() called with 0 slice, use SCX_KICK_PREEMPT instead");
+		return false;
+	}
+
 	p->scx.slice = slice;
 	return true;
 }
-- 
2.53.0

