Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F26495AF3
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325707; cv=none; b=VXI54hGQyxXufQcxKiNuYso4b79jVnV7hu256lKViuiW88qTHEpaZw3MhN4y35hz4TOAGy1SJMTfXz17alM4AW54a8cVb9V63ZZuK6HeySWL7LlZC+V7o2gBYLmAtmAyVsPab/uZOsU4VMomwnhPjxey7Ih3B33lUGd8f92z8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325707; c=relaxed/simple;
	bh=BW+uARivC6jjD/2a75VRmqqWhOr1I5QX4BGUopHD3Zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LkhPXvBbTpVc48KbjWMoONKG5Kpg1TSzxstyJv8iedzZgKVYMaprY3WvpprIlmZWTlKucIQ5AwZIwrFE0FcPrMbSepIkiMWAoLx8xYpi7u9USlLJOMsnplIMU8niJ39O8ZPpyok9qrQTCQJH58RknUQ0qhPz7K4ULWMKctkc4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0FMgHEZ; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0FMgHEZ"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso721678f8f.0
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325704; x=1792930504; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Diqeqj2OU9UtngRhSx/ZRJRD+vZIyN5fgaD++Yc3pxU=;
        b=J0FMgHEZ9iZgqUmcBR3OHbFPol36irOcup3kdl1aAK4hpqxWVn0YxS317dbrBmmRU+
         WvWUb6aFjAWQBN0Kvoomv2Mdti59Dk8aOKFQz1HH5Bm1rPRlw7wVWQGufDvhMW9AMwhX
         oy4pGSPBDBjYCMNmbc+CqO6xz+Yep23dks2EzqBF1xJtEMdo+CWsN1wkevvPICXBZaF6
         s42U2Bm7h7Zk72n3kthwZ9Xs2fgC481jHKjxKX9YJIOm37yERBwhX1HE58g6x1bh8vr1
         t3TyI69jhmVrjRxRftCDZLHDv4Tp40wmeONso/95cDRwoKgsbOOX2hDR2nQF11EekYRc
         b0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325704; x=1792930504;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Diqeqj2OU9UtngRhSx/ZRJRD+vZIyN5fgaD++Yc3pxU=;
        b=FJ7SRUab9DcRssvf2AAWVeYfH3yYUGelWkjzehHjrMDDR+FHbq5hZ5DoGxzKRs90UO
         q74gqy//PqC6ji28yUUSvuH0QiaizAtQogZexCb8xOs26/qLiEzm2sGWU76qS/+9vV9r
         KY9LzcjS1f078Gqc6/iGRmFI5JCVObhKbqGrEmhfLaMMVMnsI5MrSTgu+1955R7Kvt59
         ie5dMGG+lYIa8ulz/FcpDBSgtYttqxQtQv8laDXlaVvtM7IIu5CXTzVaCV7EqzjgwXBg
         pnPtRy21Xj4Vc45SWL0L7ZdHqgEk1+fAuc3O52eeqAGdf//eni+jKcv4hW7waO7xISBO
         729w==
X-Forwarded-Encrypted: i=1; AKwUvBycn+/RB1MMO+4mEZAWcFjZEpNZoUv84H64ZMNQSoO1bRNc7fmSQ7bp5oXU6AAC2LxUiclPAA877l8=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ6USvURcqejqJE52E5R0/LAsJrOLmNIBTt89gcpokB23Y5fbi9
	XM3y3VnrLX1YWoC5Yhwe0x/RYQL1WmeftzcqW2F3EOX52k2EyTEsGDTNGq75e2DngxnPI+GzMyA
	sfMlNprpil+QD3Q==
X-Received: from wrdv26.prod.google.com ([2002:a5d:591a:0:b0:48d:efdd:ded])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:f8c2:0:b0:48d:fbf4:895e with SMTP id ffacd0b85a97d-48e07fb31demr5661713f8f.11.1792325703377;
 Sun, 18 Oct 2026 05:15:03 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:47 +0000
In-Reply-To: <cover.1792248922.git.jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <45315290c86670e424bb38a547d2c325a6a9a7c7.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH 3/5] sched_ext: Release the CPU when its running task
 leaves SCX
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the task running on a CPU switches from SCX to another sched_class
through sched_setscheduler() or a PI boost, the CPU is taken away from
the BPF scheduler without a context switch. sched_change_begin() calls
put_prev_task() with a NULL @next, so put_prev_task_scx() can't tell
where the task is going, and the new class's set_next_task() doesn't
notify SCX. The BPF scheduler is never told that the CPU has been
released.

Release the CPU from switched_from_scx() if @p is the CPU's scheduling
context. Every class @p can switch to is above SCX, so the CPU is no
longer available. As the new class isn't known yet, report the new
SCX_CPU_PREEMPT_CLASS_CHANGE reason, with @args->task pointing to @p.
The release happens before ops.disable() for @p.

switched_from_scx() is the only reliable place for this:
put_prev_task_scx() with a NULL @next is also called for changes which
keep @p in SCX, and the wakeup_preempt() call at the end of
sched_change_end() is skipped if rq->next_class has already been raised.

The reverse direction needs nothing new: when a running task switches to
SCX, sched_change_end() calls set_next_task_scx(), which acquires the
CPU.

sched_setscheduler() and PI boosting can target a task running on
another CPU, so ops.cpu_release() can now be invoked for a remote CPU,
with that CPU's rq locked. The legacy scx_bpf_reenqueue_local() was
already switched to the locked rq to handle this.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      | 11 +++++++++++
 kernel/sched/ext/internal.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4d02d2d6e6d0..d56c692f3dfa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4433,6 +4433,17 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
+	/*
+	 * The running task changing class (sched_setscheduler(), PI boost)
+	 * keeps the CPU without a context switch, so neither
+	 * put_prev_task_scx() nor the idle class sees it. Every class @p can
+	 * switch to is above SCX, release the CPU. The new class isn't known
+	 * yet. The scheduler being disabled is excluded by the static key.
+	 */
+	if (static_branch_unlikely(&__scx_cpu_avail_enabled) &&
+	    task_current_donor(rq, p))
+		scx_cpu_release(rq, SCX_CPU_PREEMPT_CLASS_CHANGE, p);
+
 	if (task_dead_and_done(p))
 		return;
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 2d8c789c1e76..65b6ec7dc2f3 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -300,6 +300,8 @@ enum scx_cpu_preempt_reason {
 	SCX_CPU_PREEMPT_UNKNOWN,
 	/* next task is being scheduled by &fair_sched_class (partial mode) */
 	SCX_CPU_PREEMPT_FAIR,
+	/* the running task switched from SCX to another sched_class */
+	SCX_CPU_PREEMPT_CLASS_CHANGE,
 };
 
 /*
-- 
2.56.0.176.g3575e65682-goog

