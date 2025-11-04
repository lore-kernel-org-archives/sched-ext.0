Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A622FDFF;
	Tue,  4 Nov 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292424; cv=none; b=TPw3yHt1JBftfHe9Cxrc7bD+1QimDfaFXs3pTsE0iud/8xqVssUF/PT0xlYeZTWB78hA+6z7ZQgD8OrFY2PzV8mCn2it8HdGqnOe955tWzWk21HZSFGU461rMIbm2qL/ricFK32guLJKXuThefI6/8/RfAfloPVlItMqkxBfczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292424; c=relaxed/simple;
	bh=xYU6XL5l0dHXzcHycJly5ql/iPEw6c2gc6LYrnlPDmo=;
	h=Date:Message-ID:From:To:To:To:Cc:Cc:Subject; b=Cu1FQawXh4H+NWMqY2+ChV3WO5IJcTw2Xt8qCM5j/Hmz5apjue9oeyHUBk59D2rcOf/jVxr+MX+dxIQjKjBmNH2kLGDJF0Js4MMlDb9KaLc+J3fO162PciETevyV9nPVJfhb50o1S3Xt7XoRmOc4qCEhWW1rnsfHQre6o2r3QrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnSLEGRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnSLEGRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3546C4CEF7;
	Tue,  4 Nov 2025 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762292423;
	bh=xYU6XL5l0dHXzcHycJly5ql/iPEw6c2gc6LYrnlPDmo=;
	h=Date:From:To:To:To:Cc:Cc:Subject:From;
	b=rnSLEGRZST1yPwN1S875q6KzMMyC3YtXCtMgqh8+NRvdDuaGOgZFP5ogQuuzQ9s/O
	 BcZRBLhhE5PeGROBWgrgL9+CUaBcSxL0jWPnxxJTzRJ8IbiDJyt99VXFcL1QoV4reP
	 55MFiopyQEj6k0/Ii1OM5XPwN03c+oiCy7/GtOjF2wDDzbNHv0V/x9jR21OyHln383
	 TK+0QxtRQIioAN2zrFthxTP8QzI876I7Z79j/055Ga55TNThg7LGhniSmhNnyRHsqb
	 TLwHZhn4TTTfS83Ot+y9azuLH2CDoXQ2BYnqXrsZQ+Xdv3cDCNGIJdoJZ2O9jiJI3+
	 KU1BIr2eIvDQw==
Date: Tue, 04 Nov 2025 11:40:22 -1000
Message-ID: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Move __SCX_DSQ_ITER_ALL_FLAGS BUILD_BUG_ON to the right place
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The BUILD_BUG_ON() which checks that __SCX_DSQ_ITER_ALL_FLAGS doesn't
overlap with the private lnode bits was in scx_task_iter_start() which has
nothing to do with DSQ iteration. Move it to bpf_iter_scx_dsq_new() where it
belongs.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -474,9 +474,6 @@ struct scx_task_iter {
  */
 static void scx_task_iter_start(struct scx_task_iter *iter)
 {
-	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
-		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
-
 	spin_lock_irq(&scx_tasks_lock);

 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
@@ -6218,6 +6215,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(str
 		     sizeof(struct bpf_iter_scx_dsq));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
 		     __alignof__(struct bpf_iter_scx_dsq));
+	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
+		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));

 	/*
 	 * next() and destroy() will be called regardless of the return value.
