Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83F4DEC3A
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413726; cv=none; b=nrLArFFYK92sr5rZ3Rr8rY3u3zYi+e1kgVSCGKFxE18FxccsI14NOPa6zbd8myGq2Ag0pWQU1Ii9TAhF7xnLIqKpM0PtOfSRJyuz4TUwz7EBaLAbWwpenLdyiWxIH6Oz57QPYeS28rAXGTxnvPTSeLQ9ltXJmuv2Bm4vQ3K0uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413726; c=relaxed/simple;
	bh=FlBQwdip4g4HHV/g4pwDPD+JRcfp+uQYehDQvnDw7uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGMUQuGouG5fufwGTQvIwp50pMPY/idyVQIqAgYAMqycrCz9LlIJGwFGb+iaCiLYV+Q0d9V62L0R+fTp6Gl7wGI9qIewBHGHXce3A/Yg6hkXyTMGebFhosa6FIDo3Y968OyvB/f9A69fACqUL7V3f0M9700taZG+1B3pdsAiLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Do38YEwm; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Do38YEwm"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c41b03cd1dcso173177066b.3
        for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792413714; x=1793018514; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LoRGSkasm8ghLjUGPktte7l/3lMtd3+HJlK+733NI4=;
        b=Do38YEwmVnufZiRCZce1GrEk0wD/Lt4x2NkjlnJ1IUMTRYczGBMeNVM8SocUbDH8cs
         daa+GzMBZl7q1c6sYi+ce1l+g446Isy/CjkVq45XGS9BOjkq+1mV+mOMVIAo/CJ2ntUv
         YSCu93CCbSpQZPHzdTsMWMuEdLqQy/KQYbM+SOIYomwQRZD2Aq7Epfi79DakbC5Arc5E
         myRuVOgSIssSHv1fsqpWULB3G8pWOVCmlIBgpjzPwFpnwSCiuTpdW4EBnSlg4Te66lPG
         +Tri62IKxlGCNF3kj0uC3fj5v0++8lYafzv1YX4g6lQ7YC3L0rkebwJNua2Wwvvk5jzs
         sorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413714; x=1793018514;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LoRGSkasm8ghLjUGPktte7l/3lMtd3+HJlK+733NI4=;
        b=KE6ynbJ4rnpwKA5MmLpT2GeWVrkjz/JkdZUMFZuTvOph6mRQFu3g+dXMZvWkZUwsZE
         LSkAgxSHGeg5Da3bhOdpRUTNR9LZ9GCsB7D4Xaw2BcAOR9oNKLWTxjCaXxwI1YY2EZaH
         cMIPYXs6+2zK1eAJqyD0XiATr5FUMJUTUqNOhnXS8JXgCsR497xs+vkBBNgjNHkfTmOR
         jiIHxW1M9D0Tx9YYlPhwgIQBTWJGs3utgm+ahzLC4vs9+WOiSGeUqtMHUhm13sO6UPCz
         bhIfTVsH0dmFmEhMfSagdyhX10LNuKJ+ZRKyTyTEAoTw795MUyeQO+kBR5f9qa1LvDU/
         hBZg==
X-Gm-Message-State: AFq9FYKX1WWFRsrEQcd7OUFow+Ooj6Sw3aQwf+5kOtUoyaXviQXQLzz8
	FHwf8BUrQKC6ApXA2M2pjjVpCGC6xvdZB38AzfDIZfhnvNblZFYU3QC+vl06QiCn2IlF0oIFkae
	3fipwzMM/GYSlNk4Sfg==
X-Received: from ejgi17.prod.google.com ([2002:a17:906:3c51:b0:c3f:bf12:31eb])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d08d:b0:c41:8736:8c38 with SMTP id a640c23a62f3a-c419f703a50mr462018766b.30.1792413713899;
 Mon, 19 Oct 2026 05:41:53 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:41:45 +0000
In-Reply-To: <20261019124146.3582127-1-michalblk@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261019124146.3582127-1-michalblk@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019124146.3582127-2-michalblk@google.com>
Subject: [PATCH 1/2] sched_ext: Reset runnable_at when a task leaves its scheduler
From: Michal Blaszczyk <michalblk@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>, 
	Michal Blaszczyk <michalblk@google.com>
Content-Type: text/plain; charset="UTF-8"

The watchdog measures how long a task has been waiting from
p->scx.runnable_at, which set_task_runnable() resets when the task becomes
runnable after it last ran. ops_dequeue() never asks for a reset, as the
dequeue of a waiting task is temporary, e.g. for a migration or an
attribute change.

Leaving the scheduler isn't temporary. A task which is switched out of
SCHED_EXT while it's waiting keeps its runnable_at. When it's switched back
and becomes runnable, its wait appears to have started before it left, and
the time it spent in another class counts towards the timeout. If the
watchdog checks before the task runs, it aborts the scheduler:

  sched_ext: class_switch_stall: runner[418] failed to run for 3.010s

Here, the task waited for a few milliseconds before it was switched to
SCHED_OTHER, slept outside of SCHED_EXT for three seconds, and was charged
for all of it as soon as it woke up on SCHED_EXT again.

The same happens when scx_sub_enable_workfn() hands a waiting task over to
a new sub-scheduler, which can then be blamed for time the task waited
under the parent. scx_rehome_task() isn't affected, as it moves the task
through SCX_TASK_INIT, which resets runnable_at. The stale runnable_at also
skews the default core-sched ordering in scx_prio_less().

Reset runnable_at in scx_disable_task(), when the task leaves the control
of its scheduler.

Fixes: 8a010b81b3a5 ("sched_ext: Implement runnable task stall watchdog")
Assisted-by: LLM
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 kernel/sched/ext/ext.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 07857039aee69..120df09b9e0af 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2424,7 +2424,11 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	struct scx_sched *sch = scx_task_sched(p);
 	unsigned long opss;
 
-	/* dequeue is always temporary, don't reset runnable_at */
+	/*
+	 * Don't reset runnable_at. If @p is waiting, the wait continues across
+	 * temporary dequeues, e.g. for a migration or an attribute change.
+	 * scx_disable_task() ends it if @p leaves its scheduler.
+	 */
 	clr_task_runnable(p, false);
 
 retry:
@@ -4517,6 +4521,14 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	scx_set_task_slice(p, 0);
 	p->scx.reenq_cnt = 0;
 
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
+	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
+	 * doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
 	 * transitions are consistent, the flag should always be clear
-- 
2.56.0.176.g3575e65682-goog

