Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710472;
	b=qNr007gidayvDa3OlGgFVmDlqYlovVeRQa9MvCs+atj+ioZRxM7mVmhLFjB+/Yi2pbgZ
	 ReBVUK2Z+5WugdlAGHxXxpOeW9JAlVTnOJcvxaHRnMHjowhm7TiS9Gj/0O8UR+e+Oi82z
	 yOFF+mKOVx0xUUfc1Yk3R9p5pflxXcMkQ89XO5lCOnW3iAkugeLKojChabjB6zB9UjhVz
	 OGZmRACJXnMq5tZbH7OJAMKHt+tBB0TUfFbEk1VdYbaDkguFkCPwwXOhbQ8Uja2Zu1frX
	 uurFOC0OI+PCYwHcR/SYqH0R+9CDJdh5MsnzR/eqbuSeVhzUiomyY0MfutMw57cvPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
	b=jzQoCR69VEmiAYsMNIME6qOQof7uG3dW5FFbd0JitBHUWL/h2ypWpC0+tAHvbvxWx3Xi
	 tNFrFIr5q9fznCJaCC19BeNeZJMuABUuI4irvcFxhTDp9WjJmSdwYkS+eezpX/RTddqlU
	 VJg41GY7xX3LpWWT/f9V2PZAF47n8mZTmuw7HHnkPaQIiqYm83jtrlyvZ1VmMXttr6H7v
	 s4qp2UY4qIJ4tQlxqVVJu5iDgtCxqvINeYQDvAE5mrItFW45MXseJ5lGa1qVUu5ahb4Q/
	 SgA1/S45Qb8VchGA8W8OJ+pzSvlHdlP3pa5LNw9U2+8/CiNf0uq1cMhqHSa6HWFNtbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=famD3Qpf;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06326606A31E
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 16:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06326606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=famD3Qpf
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so3534231b3a.2
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710471; x=1796315271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
        b=famD3Qpfac5yon4wvHjUOPOv/GlTc/qpm8rRyn/TBNjDoe9jXrjcPWsYxDLXYF5Kwf
         7Snkzmp7JTdbM1dX/M/9um+pKMMWavKKJ8CjG9oADNvCxxkszkBv8hLPhM005ZdQfImo
         fDZryx8BreWKaoQtTI1q/c4jpEa8lrqhQMnTNOGuxIgMA6rjmZLirSSGVeVudFgbEzJ0
         nwiiZhFM4nhYYi8fmlKgaRHU71u3ScQSOJXjgBeVqn0LNFeEaQZSvLlvk17etbCImq6Q
         3FHuJaRZcUXs0G4hoQMxpgU7eMWVGxRKTxh6PW6lTFGvEJrCTAiuX4xwRVy4Og+6wrli
         9owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710471; x=1796315271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
        b=eASTJUebUnsKFhMdEf4uOjfgkqv6+++Fw5r74+syGE7/4ObY7pI7ap9W4BSQPOgUZO
         EyJJe5vKOFwK3noyzK9UvPvGECH7tzXMFscS9I3tgjWHbTs056bDL7xs3R0IVzSiCbFP
         3FXVkk+2JjC+XnBEwjqngQMwO9DDcEC9Yx5HeZyv/bM2LStm8+P7hFHCJHS8H1Q7SPo2
         45eDL7q1UET+3x9nZbBiEg9pJ9Uu3ThiJEK7vk7P5gWBSJLuQ1gTeeXJIxSIAUqr5QAL
         sQwwjYJJKz8e3OcppOCZ3vfDFrO84YvI3oesRKvI8Vyoi5BiFkMEl5tB1RrRjJvT7EGd
         Fa0g==
X-Forwarded-Encrypted: i=1; AL+hErEwwyoLX2uuaZEdPXUTZ2aqTCBZlruqc3RyA/EAuFjhR2GSo1RXfyOgA3sPxi1s8cOXpJBiaZeVsJA=@lists.linux.dev
X-Gm-Message-State: APuU4Z9c63JeQawZChFxlPuk+9/DOK6/MKZlEfY3IxhhOgCt2jAiDYn+
	OBvdgvOli9WnBkc8GsEk/4bUFBShwDL9OgHf243e16z3NeYEkvkZ2H4X
X-Gm-Gg: AZFdTZcIqdatpKUcw2EkFSKF+QUDjYHYq4OIsk3JtuFtOr4t7mfd+m/6rrvEjxwNKGc
	V+GNLMFE8hSVojpsbOfkALEAwL7F0HPYC9ThdTVYCXcR+ASHoA9Nmisq+zxPkAHPL17rF4/wxh1
	69a+WSEFWTgkHsGicjdGe+kqH4td7YX8UHiE6BAaspT3yCu/NdhAJYPmyI0FQTMD1DWdmc3pNw1
	v6VNJvj2runL1AW2IZ9ApFnblEA6stExR8VTGvv8X8DEkhahAI3I6RcIu3XrkmvZVOAKFB35Q9z
	uym/GY/wzPFq/PMH3hNKwHUN+CBcb354bzBjVVOG7ZnwavcwwnLwk2fHR+Xl62FQ4hk3cYGC9Ju
	O0kn02GmMhCwoIvOhXv1n+Y2sUEov7eflhTHNa0j4UtBqeeayDNKb7CEI741PkD2bqAi5UCsbny
	eMhU+XbwTD1vrnTIFW3aNyrhqVimjAtijenHCiuSc5aZzBKq6+Qh0yXiYRFeXjlfbUjlLU0qiWS
	elpv+REoB2a62/pyk3fL4BNXuwzwx0++TvdNgtBk8w52NRmyzgL1ZCAInuI3m59EJz+8q4Phm4V
	k4o5d/FEqQaPDTjKon1wp/DRd2MTMLvudTKRpOJkr0xUIzRMzxJZqNTD8SQ6P8zQpM0BoNhULC8
	Vjk076DGUeoqQZrIr+Enzjdb1AyqfWHiE5Q8=
X-Received: by 2002:aa7:930b:0:b0:8b5:f9b1:a8cf with SMTP id d2e1a72fcca58-8c87d32a732mr21318565b3a.51.1795710471016;
        Thu, 26 Nov 2026 08:27:51 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:50 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kang Chen <k.chen@smail.nju.edu.cn>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 7.3.y 1/2] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Fri, 27 Nov 2026 00:26:57 +0800
Message-ID: <20261126162700.22257-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126162700.22257-1-yphbchou0911@gmail.com>
References: <20261126162700.22257-1-yphbchou0911@gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

commit 564405c424f49d70b13debe7fe5b550234ad6b84 upstream.

Tasks in SCX_TASK_READY are attached to a scheduler but outside the ext
class, such as RT/DL tasks, or non-SCHED_EXT tasks under a partial switch.
The scheduler's BPF code can still update their dsq_vtime and slice (for
instance, via ops.cgroup_move() as done by scx_flatcg).

Because __scx_disable_and_exit_task() currently breaks out of the state
switch for SCX_TASK_READY without calling scx_reset_task_fields(), these
fields are not cleared when the task leaves the scheduler. If the task is
subsequently moved to another cgroup/sub-scheduler and later switches to
SCHED_NORMAL, the new scheduler's ops.enable() sees stale dsq_vtime from
the previous scheduler's clock.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure SCX-managed fields are properly
reset when leaving the scheduler.

Fixes: 5771e79e461e ("sched_ext: Reset dsq_vtime and slice when a task leaves SCX")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ chengyang: 7.3 lacks scx_reset_task_fields(), so factor it out of
  scx_disable_task() ]
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cc8d09924fa1..1049a0914d60 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4159,6 +4159,27 @@ void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 }
 
+/*
+ * Reset the SCX-managed fields when @p leaves the BPF scheduler's control.
+ */
+static void scx_reset_task_fields(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+
+	p->scx.dsq_vtime = 0;
+	scx_task_slice_ended(rq, p);
+	scx_set_task_slice(p, 0);
+	p->scx.reenq_cnt = 0;
+
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving the scheduler ends the
+	 * wait. Reset runnable_at the next time @p is enqueued on SCX, so that
+	 * the watchdog doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+}
+
 static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 {
 	struct rq *rq = task_rq(p);
@@ -4172,22 +4193,8 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 		SCX_CALL_OP_TASK(sch, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 
-	/*
-	 * Reset the SCX-managed fields when @p leaves the BPF scheduler's
-	 * control, after ops.disable() has observed their final values.
-	 */
-	p->scx.dsq_vtime = 0;
-	scx_task_slice_ended(rq, p);
-	scx_set_task_slice(p, 0);
-	p->scx.reenq_cnt = 0;
-
-	/*
-	 * If @p is runnable but not running, its wait started at runnable_at,
-	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
-	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
-	 * doesn't count the time @p spends elsewhere.
-	 */
-	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+	/* after ops.disable() has observed the final values */
+	scx_reset_task_fields(rq, p);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -4213,6 +4220,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.56.0

