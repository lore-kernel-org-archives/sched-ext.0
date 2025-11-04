Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920733FBA7;
	Tue,  4 Nov 2025 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292576; cv=none; b=u0TqcHCKXf4dqCncrnqdrjiksg8fd/wMzXLFkuYczqsBMLYSlP8qwW32hY4U+SnU83/Vkv5BATCNjRR4/I0UwyP6UwgjvqBxnAn8O7+jcRzQ3cqntvi51tZOD8oCoOk7yt6GI1KlquUrtt2idD66E+NIGvZvSKLB65l6qZq5aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292576; c=relaxed/simple;
	bh=EJTYTEM0Ei3whPU8Go4j/5k+wpOdRNHe4vZrGD5qWkM=;
	h=Date:Message-ID:From:To:To:To:Cc:Cc:Subject:In-Reply-To:
	 References; b=u8OBG2H2ZcUoHFyjWc4TRSTvrfojh+Ki2O3WzztjwawfWroEa2wG95r5Tb/BMP0g39EJVdQshq8UG1qlroWECbv4/AWaX4OuHFEu/AupppyyYwnjzcSznGl4rLBCG+N3lXYj1FWL6QlvVleSvKqFOypXzUnP0GEMX+K433LcyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWsYIdWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWsYIdWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE6BC4CEF7;
	Tue,  4 Nov 2025 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762292576;
	bh=EJTYTEM0Ei3whPU8Go4j/5k+wpOdRNHe4vZrGD5qWkM=;
	h=Date:From:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
	b=oWsYIdWSzzxIYta3JI3axtqFvjJ5WJ6sWrvildO0KkmncV6Gq8e9LyiVCgu/hiIJu
	 ETeBRUnwKtKASrCrKZd41SzoaEYc+q5GhxUOCI+Vr15hBTryku8Gl3j0n5B4CNkMOp
	 2asLfxr86BemeBajCRUjNjbo6iHySYtfXFkM1/4xwcvxnRA/gwPhAKT35DsZf22ugm
	 CRn1RwQeFFnGm3QZVnqPj8qhwxwi1YFpGQj0AlCN7suS2kdWTB3qst/HEut0or53QH
	 CNHzaZGAH0f+0bp1nVYG+mb1SqD6+K/IAP9LSHFiTRMAZ1nxFFOZyHzMAzf45IqHxr
	 S7Bb2wXTaYUeQ==
Date: Tue, 04 Nov 2025 11:42:55 -1000
Message-ID: <6ee50c6ec435d9180310a8160a9aadca@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Minor cleanups to scx_task_iter
In-Reply-To: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
References: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

- Use memset() in scx_task_iter_start() instead of zeroing fields individually.

- In scx_task_iter_next(), move __scx_task_iter_maybe_relock() after the batch
  check which is simpler.

- Update comment to reflect that tasks are removed from scx_tasks when dead
  (commit 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving
  sched_ext_free() to finish_task_switch()")).

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -470,16 +470,16 @@ struct scx_task_iter {
  * RCU read lock or obtaining a reference count.
  *
  * All tasks which existed when the iteration started are guaranteed to be
- * visited as long as they still exist.
+ * visited as long as they are not dead.
  */
 static void scx_task_iter_start(struct scx_task_iter *iter)
 {
+	memset(iter, 0, sizeof(*iter));
+
 	spin_lock_irq(&scx_tasks_lock);

 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
-	iter->locked_task = NULL;
-	iter->cnt = 0;
 	iter->list_locked = true;
 }

@@ -545,14 +545,13 @@ static struct task_struct *scx_task_iter
 	struct list_head *cursor = &iter->cursor.tasks_node;
 	struct sched_ext_entity *pos;

-	__scx_task_iter_maybe_relock(iter);
-
 	if (!(++iter->cnt % SCX_TASK_ITER_BATCH)) {
 		scx_task_iter_unlock(iter);
 		cond_resched();
-		__scx_task_iter_maybe_relock(iter);
 	}

+	__scx_task_iter_maybe_relock(iter);
+
 	list_for_each_entry(pos, cursor, tasks_node) {
 		if (&pos->tasks_node == &scx_tasks)
 			return NULL;
