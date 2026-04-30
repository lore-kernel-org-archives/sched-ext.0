Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0A3A1687
	for <sched-ext@lists.linux.dev>; Thu, 30 Apr 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541273; cv=none; b=lIs7nb2LhMIOIoRSvM8IvSTWeR3nCTl86K0UCFl0oWsTXW9JUhfm2DQJajVHaP/pySDU5NK3KFld0T0wiy2jPRZFAAhKBBRlOKFcXe/fx5u9yCe8t9y7FiBQMNUVFsXRoYIF6ONe3udEcTem1xiNLeQEO4p9Lf/L+io+zDoNi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541273; c=relaxed/simple;
	bh=CXDxq6gShe6+wBOoBAqetqOH0qIWfFPLMI4Hbm9iCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2AzL0t/c+ZDQ3UhnU0bOv46hE8kD297b633LGCr3kts3Gn7kB9tPSE7a7/gikIV+/GT6K5rIM0LKCd1Wnr6+2kvLQchC9OYVC0RM3tHqRHKVCZweB0hGvyMKCFrjFHfuGspIvgS5+Bqwvmd/ddLPFZp8+DhaJgyPK8IyWLKoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE5QFHho; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE5QFHho"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0046078so5935295e9.1
        for <sched-ext@lists.linux.dev>; Thu, 30 Apr 2026 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777541271; x=1778146071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=23Gv79bX11KtZ0VP1e3ka7ca7k5Ir/in0ODtFUOjGc4=;
        b=SE5QFHhobUy7n/m9CZxncXRO0P3kA1xX4AKP/zB0kyNgFDluzUcrg02ZImb9GegFzZ
         14/Y5MiNxuKyhqLSnPcqGxMW80e6+daG9+U65kCqepIHGYhv3c8I6xkLIpSROaHXofE0
         BEhaiBWXa2IN7cqfzT8ACNw66L+WCEgERaFYl7bN4uLdkw22KYgYhHEGPqN2zTazIFyO
         AFKNiUJGL1KEDVErmKrwQN4WhHDbS8XALVx0EXKd7NzvSPIhkzFtuq2Vm8HBNc43pL2T
         es0zerVayUgUFavQJa23LgvbU5gX5QsrKgpcbciqTXHb3kwLTB+QH0KgpDwtevWlaD/9
         nRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777541271; x=1778146071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23Gv79bX11KtZ0VP1e3ka7ca7k5Ir/in0ODtFUOjGc4=;
        b=pdyXpbuzWnoCUXxCmoPtZQ2nWM+ZK2ohz/ua8ddPhHOOu/+B6d4xtEXiGowc3c7u0U
         jd8NoJVFjbgc5T/HJDRB0Hog4n9SgbZ4HD8L6hWkKJZk5AO8KhRVdymCKtICu1UcCOP7
         Y56CtSSz8uBazaTRPnYRgcRGziO1ICMhRx1DSkPDkIcY0bIxDfbn3YbeUpiWfp30DEC9
         BqRNYevlK88MYRPGuHfO59ygg8ZzDFSZptT00kWkW9r93UnNzdKSeXX03b8hwThsqq5+
         ma/CdJGeTSQiva4ccUdwr5VtpC5ZohvhkNHfxk6Krn6irL9d/skus5YY0IjOcUANLsJe
         0v7w==
X-Forwarded-Encrypted: i=1; AFNElJ/mKedmPOwn8Y4xse9KJHhAdW/v2xdJS8B3OjlFgRJnbKYR4T1Vq6QD0GAjrO5a2YaLV2xybsLFp2U=@lists.linux.dev
X-Gm-Message-State: AOJu0YxLCnJ5eLbVM+pMaMX7vdSb28bA/gFmnUkYB2YQaJH3uX32z8sZ
	lFK5HQ63OGAS7V51H9/0XNQ4SSVF9pwmW4+OLgH+UFHX5XSC01cZe3vv
X-Gm-Gg: AeBDiet1HjMpHiyOdstZbrstlMzH1ENFwyX8LcygQRiT7Ou7jXsplo4q6tTLVlmCYgG
	H+JGE9YKHBuY52fGghohjfi03rcfuC3iU7YOHeMT8j9zoW7ECgQcgVXHVeN21UiQ2Ga0b6Nq+4k
	KjCK9sScSgdCJgk2jvPzway2eLgmDDp7QCuhf8ik7V1EYGDiqHzhZ7ke4m7K6KRVud/jI7/26at
	Wq4fb17ZisWzjQWVnpUu7pzcPr8CnHIZM1eBgp4RokCb9MjfM47ir0CAvgCKFgk2mP/xnSIcWrW
	1Iyi9E+8Z0URJNngssPWxtM9a2rKwAztNPotqAhmSBaX/vrVE+O0YImbdGE0CkwJB42KSruMdUG
	00IaR6OLNe1lIS7qcJnnh8aC/snqG9Lgop6Qoe13tIX9wLmT+9n/sTpymX1O7q4UuFuelNwtU1O
	0sOq9BNT3nrU3TW7eQpY1NY6MLsM/Bkml8j7EBF9g6IdtDx0Jvb+pItbYWp4DBM8zj/MPmrlNHn
	F3I/L4frzAX4XGAy8H9qQLuW0qitdWk
X-Received: by 2002:a05:600c:4688:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48a8444da8emr38043855e9.22.1777541270697;
        Thu, 30 Apr 2026 02:27:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm48160615e9.5.2026.04.30.02.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:27:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	sched-ext@lists.linux.dev (open list:SCHEDULER - SCHED_EXT),
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: David Carlier <devnexen@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH] sched_ext: idle: Recheck prev_cpu after narrowing allowed mask
Date: Thu, 30 Apr 2026 10:27:47 +0100
Message-ID: <20260430092747.73114-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_select_cpu_dfl() narrows @allowed to @cpus_allowed & @p->cpus_ptr
when the BPF caller supplies a @cpus_allowed that differs from
@p->cpus_ptr and @p doesn't have full affinity. However,
@is_prev_allowed was computed against the original (wider)
@cpus_allowed, so the prev_cpu fast paths could pick a @prev_cpu that
is in @cpus_allowed but not in @p->cpus_ptr, violating the intended
invariant that the returned CPU is always usable by @p. The kernel
masks this via the SCX_EV_SELECT_CPU_FALLBACK fallback, but the
behavior contradicts the documented contract.

Move the @is_prev_allowed evaluation past the narrowing block so it
tests against the final @allowed mask.

Fixes: ee9a4e92799d ("sched_ext: idle: Properly handle invalid prev_cpu during idle selection")
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/sched/ext_idle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 41785f65bbb2..bbb845f36a0a 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -464,12 +464,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 
 	preempt_disable();
 
-	/*
-	 * Check whether @prev_cpu is still within the allowed set. If not,
-	 * we can still try selecting a nearby CPU.
-	 */
-	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
-
 	/*
 	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
 	 */
@@ -486,6 +480,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		}
 	}
 
+	/*
+	 * Check whether @prev_cpu is still within the allowed set. If not,
+	 * we can still try selecting a nearby CPU.
+	 */
+	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
-- 
2.53.0

