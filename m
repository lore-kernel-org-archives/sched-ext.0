Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32330330B14
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864093; cv=none; b=r8/j9Q2s5liRWRrMYW326mb+dMyya7WJKr3tEullTu5cKNsvoc2EADyINJEz2HxilV6TGBssaU0qULZ3MgoQLa1wETcMzIflWNUGzozV+KkCy1EouPZJji7wGqLaw6TtgPslGCayQXGdUjFoXaJzrOWkLj/zuW1yplAU9pJuUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864093; c=relaxed/simple;
	bh=Wl8/yonMi1Xj3FkTx7Nutbni9RoU96mZlTgPZJ9pTUo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qcXGnng+2eChTgJD5bRZNTOWKBWlmxrg57U8hLx9LOY4Y4hxIwTvIewX+GJnpjk3o287yDRwC9QWGAf/8DpZA3i6YuoVkmIwyb7B5mK0aLOj3w4SpjnAH+7u5m7dgCx3ntg+11m/yjSQ3OIyHj+H/UcYrAQjFF6HhJUiPpuOhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLmRN5pr; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLmRN5pr"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d7d03e1e7so4257699f8f.3
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776864089; x=1777468889; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CesbFZs4c9Pqg2tm5xcqWyWaJqZrUAi3Am22HOf06o=;
        b=lLmRN5prTtPyeFac8d4ySPpmCimESD6glZttFlrcQWkoI9Bv0+UBtGmCk58fd4oO/3
         udrj3poV2hCk1+O3mJd5uqFFaETvSiutWtDAGVrUfFAzGrgTg2IBK9ZNrZfkQmLIg8hG
         K6j8Lubg2r9q/LiZOxQrjh/T/giFzFvO0SDvJK8fBzbmNYYC9EL0yHwsXzM/g6VJ36kJ
         Mu8MoBhwvXQnG7NMimrnc6X+r0ymSCMYWFNpaE6vP+mEssFwLa20ho/7ZqC18bcv2sAo
         yz1zglCKonJMPeEKk2cb2jAOOzj8drEnJHQg7qoOLnYbHTCXZMQdxT1muhkUwZA4uhJm
         +p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864089; x=1777468889;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CesbFZs4c9Pqg2tm5xcqWyWaJqZrUAi3Am22HOf06o=;
        b=gyhJBMJoPvOugD++nbhb33ZxtaEesLZHeVd33o5ktz25i17yoyCJBdokzqbt58SldZ
         zWri5RSI4Uv9RzBzsA8jUAuW+QZwdLptKby4kiUF1ztECKtNdk6dHwgdspC21IUxwfhg
         u9C7nSPx24NmOCejoIVPtu7SP5W4/yunW9zJeZR5P02occrRZm0RgTgUIAdYiGE38ANI
         o6grBtpRhbf3oG4UBEkSjd+97xp23MUntiUNfF6m94Jn35pLolug5NZTr8k++3gBYzOh
         TLmVIAQk51+zKLcBiOVVroZnWG87urDDjdHcLZAjJbfJ3+vVD8cYxNEZMv2Yt1wiuXX5
         1fIw==
X-Forwarded-Encrypted: i=1; AFNElJ8WsxfWVOEqkQjlpCcA6dr+1jbpIJuZ+RREGSvec2WwDda56Vbsuv5TH6lVHuRHR8J/wREwN08cL3o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIX6CZ4goC8e817Sd9Z0dVfD9Rc5zI7Al0qwGketrg1XIFaQB7
	W7LYpX/tAi+Di3ik17VJkpZhaqw9Fz46lOa1EOq2fjdsWyJhtzJzUSeBD3fl5rTVGmZATreH0+l
	Ss3NewPqOy0h92A==
X-Received: from wruq11.prod.google.com ([2002:a5d:658b:0:b0:43c:f906:ae85])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2283:b0:43f:e94a:e777 with SMTP id ffacd0b85a97d-43fe94ae7eamr31430236f8f.37.1776864088325;
 Wed, 22 Apr 2026 06:21:28 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:21:27 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>
Subject: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on local DSQs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>
Cc: <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I recently saw that scx_qmap got rid of the sched_switch tracepoint hook,
claiming that SCX_OPS_ALWAYS_ENQ_IMMED is sufficient to keep tasks from
lingering on local DSQs.

This prompted me to think about some possible edge cases, and I think we
can end up with lingering tasks on the local DSQ in the following scenario:

Initial conditions: rq->curr == rq->idle &&
                    rq->next_class == &idle_sched_class

1. We enter schedule() for whatever reason, e.g. BPF scheduler kick from
   another CPU.

2. In __pick_next_task(), all sched classes above SCX fail to pick a task.
   We still have rq->next_class == &idle_sched_class.

3. We enter do_pick_task_scx(). rq_modified_begin() does nothing because
   sched_class_above(rq->next_class, &ext_sched_class) is false.

4. ops.dispatch() dispatches two tasks. The first one goes to the local DSQ,
   and the second one goes to a remote CPU's local DSQ. The first task is
   dispatched without interference.

5. During dispatch of the second task, while the local CPU's rq lock is dropped
   during insertion into the remote CPU's local DSQ, an RT task wakes up on the
   local CPU. Since rq->next_class is still idle, wakeup_preempt() calls
   wakeup_preempt_idle() which calls resched_curr(rq). This effectively does
   nothing since need_resched is cleared in __schedule() after pick.
   rq->next_class is set to &rt_sched_class.

6. At the end of balance_one(), we don't trigger a reenqueue because the local
   DSQ has only one task.

7. do_pick_task_scx() notices rq_modified_above(rq, &ext_sched_class) and
   returns RETRY_TASK.

8. The RT task ends up being picked and runs. SCX is not notified of the switch
   because we're switching from the idle task to an RT task.

If my understanding is correct and I didn't miss anything important, then
at no point does SCX reenqueue the first task, even though it should.

This particular scenario may not apply to scx_qmap, but I think it proves that
it's possible to have dispatched tasks lingering on the local DSQ even with
SCX_OPS_ALWAYS_ENQ_IMMED.

I was thinking we could fix this by adding a nr_immed check right before
returning RETRY_TASK:

diff --git i/kernel/sched/ext.c w/kernel/sched/ext.c
index d66fea57ee69..480627fdc203 100644
--- i/kernel/sched/ext.c
+++ w/kernel/sched/ext.c
@@ -3079,8 +3079,11 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
         * If @force_scx is true, always try to pick a SCHED_EXT task,
         * regardless of any higher-priority sched classes activity.
         */
-       if (!force_scx && rq_modified_above(rq, &ext_sched_class))
+       if (!force_scx && rq_modified_above(rq, &ext_sched_class)) {
+               if (rq->scx.nr_immed)
+                       schedule_reenq_local(rq, 0);
                return RETRY_TASK;
+       }

        keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
        if (unlikely(keep_prev &&

...but I think this only fixes the case where the RT task wakes up on the CPU
that is doing the dispatch. The other case is one where the RT task wakes up
on the remote CPU (the one the second task was dispatched to) after insertion
of the second task, assuming the remote CPU is initially idle.

To fix both cases, one potential solution that comes to mind is bumping
rq->next_class to &ext_sched_class when inserting a task into rq->scx.local_dsq.
Perhaps we should call wakeup_preempt() in dispatch_to_local_dsq()?

Let me know what you think!

Thanks,
Kuba
