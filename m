Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906F1EF36E
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987748; cv=none; b=hG7yLjSFaw3GLdxqsdvA/58VUezUSKh9lfoVN0Pkzlga7nTT1SrIilYjsMvQO7BkEosQlLWHbcmbw4T8zd8WSEknNMu9qtxeT2U1k5vTsGa7UsVtnl/pVmxW6hYEQAI3dVqG5EDE9sYt+yaB2yHP73nYipxkZlegk+uBnqtCS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987748; c=relaxed/simple;
	bh=XVCsyOGJdweid+Hkrs1mnBjSZEfhBqgCs1WaMylpkIU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QJaqRoraVrScKK+NkRLz4dRHUUDjJQXeWiLa8T+Cs/Q/CWfRImOLaQDCYgoNSqTIQXEnrJrcTP0nAQaFOY+t3P7YwEmhmwRV+DmNCn5FMznMSJci6wzYvK7yOeqoP8lvV0u6U/FjFj7oijDTBt0eHVDHZM/yR5hMJ3LTv17ggK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anyN4oAN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anyN4oAN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso5028521b3a.0
        for <sched-ext@lists.linux.dev>; Fri, 05 Dec 2025 18:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764987746; x=1765592546; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdV7N4pfSKAse/61258VLDqIWR7NsSJT3WSRlwQOzKI=;
        b=anyN4oANncFRmMMEYLEeMfGNqSIj7RMF8MtVv6xB/w86nZ7i0Wq2mxElHreksy08Fs
         3zrUdmrx43eRTTcTXko4NQEwn9ErNHTvh9StTODJDiXBliXnAxx0zRbigULqrb1XuFgp
         o8T4RerqLU2ES45uoGVAxlT9SPoc6GCRfQEiCBiefOIccHTiL2bYV4M8DweaZZNz1vLF
         W1ysF/rh4tUBqvZ2gzJhv3DkkdngWlRDMn7js2mT5hhN880GwVTg8DjveRELFNpUcCuZ
         iZ6BNDOziGHwV5fvB7xL5pH5ir/X+rhm+IF6js2uIcFenxFOUqf2YQYEggLUKnO6vD9w
         T2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764987746; x=1765592546;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdV7N4pfSKAse/61258VLDqIWR7NsSJT3WSRlwQOzKI=;
        b=N2FMCg7BWvbIBpdE9Q/6/nwoUW/9FxNJfUufEFQ/hCXE2NwA3qsi24UVU5RGHIBt78
         gTMir7uidBSwy5TSCEESNuT2VRvEQE/CkWXsR+yJ2+fWoVEgdZwL2tk+2fHHK67I+C0j
         liDTBbQ7K/MYOcFyu5TJnAViUb0pKBYblMF0MD4O9B7DQoAdz6riOGmUFmHq4D1kUCqC
         Nwxd+byMoIP3WXX6TcGXgPsqVIXD7sSf/Lr0vxlbJsgKCyTRK7UV25nwFwJKSGGTjMnF
         VKlGEHT7Oseg5CV6lkvpIuX7PUJk1ZSCS2FAp6OAnRI/EmLjqMKLHr0ZrvlLkmZ2zRgg
         uINQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdKEXq5cnBbpVUnU7wbJgYaGk0nqosvwBvmUeZ5VeTnFavpUWDE3kPL7dZ3vwncuH7e05gonuL+LU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8uQqPVKRG2fU2vcQV/+LIemKA/pO1rNKSBFZWEEdXC7tBf+gD
	oC5W3ZhcYYXQyh0AF8OxF9YjaKBcpm2gk3pjm/UURFjUsE+rRe6amwRAzvNX9MYyYrJQzNuO3p8
	6DkpGvUoE
X-Google-Smtp-Source: AGHT+IFxrNvkNeRuDCNG+ZcWkFhXmvzU4P3pH7Pgn3ovztAsqVSl3V0pw8OUcWVAybxQomfezKOcPyThv5SD
X-Received: from pgah22.prod.google.com ([2002:a05:6a02:4e96:b0:bac:ef38:605c])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e211:b0:366:14af:9bb8
 with SMTP id adf61e73a8af0-36618017e9cmr1315282637.66.1764987746096; Fri, 05
 Dec 2025 18:22:26 -0800 (PST)
Date: Sat,  6 Dec 2025 02:22:03 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206022218.1541878-1-jstultz@google.com>
Subject: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Early when trying to get sched_ext and proxy-exe working together,
I kept tripping over NULL ptr in put_prev_task_scx() on the line:
  if (sched_class_above(&ext_sched_class, next->sched_class)) {

Which was due to put_prev_task() passes a NULL next, calling:
  prev->sched_class->put_prev_task(rq, prev, NULL);

put_prev_task_scx() already guards for a NULL next in the
switch_class case, but doesn't seem to have a guard for
sched_class_above() check.

I can't say I understand why this doesn't trip usually without
proxy-exec. And in newer kernels there are way fewer
put_prev_task(), and I can't easily reproduce the issue now
even with proxy-exec.

But we still have one put_prev_task() call left in core.c that
seems like it could trip this, so I wanted to send this out for
consideration.

Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
Cc: kernel-team@android.com
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 446091cba4429..598552f58f5ec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2402,7 +2402,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * ops.enqueue() that @p is the only one available for this cpu,
 		 * which should trigger an explicit follow-up scheduling event.
 		 */
-		if (sched_class_above(&ext_sched_class, next->sched_class)) {
+		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
 			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
-- 
2.52.0.223.gf5cc29aaa4-goog

