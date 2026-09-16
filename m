Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F4DE717;
	Wed, 16 Sep 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596039; cv=none; b=P4OR0Zl8FeKBtDuRuALiMGJNY41+P29qZ7he7UKznhLlV+lMHCXoEkCs9J9uVF08Ph4d0zNqDvId4JaGDxiIDuzEhhIonqhv8mrPHrBLOblLbDu0VBSA3oOPOlZ3OevC7O8GcttIZQBXPfrD9oDYzVudv2fTduzz4IAhEWJQgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596039; c=relaxed/simple;
	bh=KzkH8QFrTSNJMtzGIMNg2Wza6DJ/2N05QsDwkvTsRzA=;
	h=Date:From:To:Cc:Message-ID:Subject; b=cQJlOW8d5nOkLCJxrjVkyv/HZnvsEED1zW4t5YjLQWK+oKGpyq1EThbwfUBO3B/JS9/hsTTBDTz117BgwjEx95HX907jxZFKRo+KTnKI/CzxW5TjBOC89Jytlny1b1BxNKw7sw5+ORJIs+UQgrGTH2pzF44wMlKI97MAdQJ0jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LygXS/nA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LygXS/nA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A17A1F000FF;
	Wed, 16 Sep 2026 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596025;
	bh=WshlAkbyobussNbzhS2z24BR1P/J+Omaz6QOM5JeuEw=;
	h=Date:From:To:Cc:Subject;
	b=LygXS/nAOG32y+nL6fMuW0jiIZwAlbmTaYNOu72EsI6mZYq8marTZ31VKN3DIZqUO
	 m/O3fCD6pQWFDXE0xfTt3Ymm3UbB/l0kR0bdhIC1NZtRMM5/gC3DDvZ/A9V4Tt0sKO
	 lL48C4LITsPrdJhTiYoO5VoBz7HAgyH2mKrStYhGHmqzoTitrwIJf5nZD/smKEt/MO
	 uPY5FAcXR2wNReCNz/Hl8DurUY3Kg4N5pYIAq+FckJmkhao7ECjVEWoei/c+BqqNbu
	 EstjXkXXNsg3powBG8y1e0RKbFKSbh6/H19utZVokfsFay1RWPTM2DxiDStvjoLabf
	 knRFNQV7UowyQ==
Date: Wed, 16 Sep 2026 12:00:24 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Message-ID: <20260916215713.2701551-1-tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Derive SCX_RQ_IN_WAKEUP
 from the core enqueue flags
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

schedule_deferred_locked() skips scheduling a deferred action while
SCX_RQ_IN_WAKEUP is set and relies on the task_woken_scx() call that follows
a wakeup enqueue to run it. enqueue_task_scx() sets the flag from the merged
enqueue flags, which include the flags stashed for a remote activation.
move_remote_task_to_local_dsq() thus sets SCX_RQ_IN_WAKEUP on the
destination rq when the moved task was woken up, although no
task_woken_scx() follows that activation.

An IMMED insert into a busy destination requests a local reenqueue during
that enqueue. The request gets linked but not scheduled and stays pending
until an unrelated wakeup or preemption on that CPU runs the deferred
actions. The IMMED task sits behind the running task in the meantime. If
nothing runs them before the scheduler is disabled, the request outlives the
scheduler and points into its freed per-cpu area, which the next scheduler
dereferences from run_deferred().

Test the core enqueue flags for the wakeup bit. Only the core's wakeup path
is followed by task_woken_scx().

Fixes: 57ccf5ccdc56 ("sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/20260916145807.3250167-1-arighi@nvidia.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2141,7 +2141,12 @@ static void enqueue_task_scx(struct rq *
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
+	 * returns. Only the core's wakeup path delivers one. The flags stashed
+	 * for a remote activation may carry the wakeup bit without it.
+	 */
+	if (core_enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
 	/*
