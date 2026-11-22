Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321567;
	b=F0uMviKZZzSci9ChOfRqBMHP7T6LiqmzmgqtpFYqrjDuV83phnRpgHy6p/1hX3RVVZ/X
	 fUcv0qFSWpERS5BrovtUFLkVB7KK6fwpvIGTPzqmxb3Ia0IcPeo9hgEGT08bM7Uv9ez7i
	 sOJ0vyOHLO1PnN31ila4b3i0Q6DLhqac1HdNQi2whT7SCxv17A7Ak4zGdH43DGOV8zrJb
	 5OU2CfqNBOKaNrfmSta/O7LpPPWME4pMii5ZEEq4yl7wWe4ix+bEqEuMtMW3wn1WmZBIX
	 MH4M2SF9esBVNG+/yuwhmuV5EaLuT839gZMsBHwropIkA4q8cFQ+dNOd86zz3Md0G9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0jg4qq9XadgtOFwiQ/w6ym8+ZsypQY27mB/+0Ay1dt0=;
	b=O9H9k3tbfyIMOegg8dPjlMcDFfY4+PqNhK3KNjRJQ3emKngU/TieZ+LoJYpxn0190jH/
	 NAFIuo2MA36CixD1PZtWWHrA8Gw0lWLfXPcmtrp9IC4Ou1WXSkZVv/NjcIGuG5DKDs7p4
	 L8oqnybAq6fMF9WITwGa8fqZqc3VdgteiqRDAo60YRKmClbDI047kaaBSddiw5a8q9bZG
	 Fj4BWWLbpKHoefST/71eDAc9cmZaQElh2oECpWUKh+dgzGFm0F+ns3In7MlP9Z709z7ul
	 dNgoWGRszFZyzNo46rV+N87WWUhJ784CWDpjfrTNxmVrqCUnPAdoVMJ0YK/BSNwiJag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ESYKGgrJ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAD606A32A
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 04:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFAD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ESYKGgrJ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38355b03cb8so2247527eec.0
        for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795321566; x=1795926366; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jg4qq9XadgtOFwiQ/w6ym8+ZsypQY27mB/+0Ay1dt0=;
        b=ESYKGgrJy0MOc5QwPRvQFVJsBuWHiY55b1TDAXjoeKl718nmA6emvVXdOPhU8/Nb8m
         m9nmfpoZGQz8F9e+X66uYhGCu2oHFkiPaTFQwsYMVB4xIVqLbckcWOERkkLOGA5addyq
         EdXwUPJEssPl8XfGuGOa6oGnvkuqZymjX9Ad4zoOCWX3loGbm9cdgPDhDH5x0AxlEwdE
         VE7z7jIULYxSOajaae//JR6C+wT5OLz4jwKporJQaxKZE7lNKMgh4BxCP5DmWrbrpJ9O
         QfB6e5Sk1EZVvWt+3OzXrpwrLovE3/bHKi2SSR5iciv91gSwEf+RWOUZHGVIDXA0bh7o
         aNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795321566; x=1795926366;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jg4qq9XadgtOFwiQ/w6ym8+ZsypQY27mB/+0Ay1dt0=;
        b=UDPPjK7GUPP2oWunb5kMFBQ4Z0NVJ5DMpSOuqPFkxUq/bTVBJfqJk1sIEnsvyBa0+3
         fRzZWxqiBEMfnisfEIQSZBQh3MoHhduPsv/1jTr7t2qlf9TkUui3526Oz212HY/xHvr2
         1+e9nwe+9Cjckl5bcsjWYYYaYH1pvM2exNzIL/wvNC15zs9gmI2hKVwO3KB+0m5o6dcT
         qEmA6GYBSOYj4Oj3ixpbevBirYXlDKgNdpcI6rW2Ke0Oy0OqVs9vOSkQys9E8pNLbmPW
         4bUYkLyHux5KCLX56hTZiKxek4+4OHZGU/Rh2XzvaA3UTswDW3UFknrnFoqzAKQ+D4q6
         YanQ==
X-Forwarded-Encrypted: i=1; AL+hErE+wmdzpAK3+QeWmkG2OhsQ53FuW7+tLjEFmy9J8Nw/orfNSU6F7MHVTA0+gY1c0rFzPYAk1aGNa00=@lists.linux.dev
X-Gm-Message-State: APuU4Z/6IhOVIzYkcfGagSuaVtGXGr/0my6X6teKnJdXygBYpR1nFvtC
	ccbJWsl2oOLaeoddSy99cwyWjoLRapmKecsuLcopUMSmfO98MCiY11ynoMR/Hv215f9FJZWXJ5k
	0Lmir+7eFsWL0cYmPxw==
X-Received: from dlbsj2-n1.prod.google.com ([2002:a05:7022:f902:10b0:17d:5c89:d119])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4281:20b0:14d:c7ae:85dd with SMTP id a92af1059eb24-1b55686523bmr8270361c88.7.1795321565734;
 Sat, 21 Nov 2026 20:26:05 -0800 (PST)
Date: Sat, 21 Nov 2026 20:26:05 -0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122042605.2996910-1-penghuang@google.com>
Subject: [PATCH] sched_ext: Block donor on rt_mutex_setprio() switch to SCX
From: Peng Huang <penghuang@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org, penghuang@google.com
Content-Type: text/plain; charset="UTF-8"

scx_prepare_setscheduler() and scx_root_enable_workfn() block any
retained proxy donor before entering sched_ext so a blocked task is not
carried across scheduling classes without sched_ext admission.
rt_mutex_setprio() misses this cleanup when PI deboost returns a
blocked RT or DL donor back to ext_sched_class.

Expose scx_block_proxy_donor() via scx_prepare_class_switch() in ext.h
and invoke it in rt_mutex_setprio() before sched_change when
transitioning a task into ext_sched_class. Because rt_mutex_setprio()
has already updated rq->clock, calling scx_block_proxy_donor() directly
matches scx_prepare_setscheduler() and avoids double clock updates.

Fixes: be8be8acb268 ("sched_ext: Block proxy donors before taking control")
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/core.c    |  4 +++-
 kernel/sched/ext/ext.c |  8 ++++++--
 kernel/sched/ext/ext.h | 12 ++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed660f099a5..1a2a317f1194 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7814,8 +7814,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(p->policy, prio);
 
-	if (prev_class != next_class)
+	if (prev_class != next_class) {
+		scx_prepare_class_switch(rq, p, next_class);
 		queue_flag |= DEQUEUE_CLASS;
+	}
 
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..4914da605519 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,10 +26,14 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 /*
  * Block a retained proxy donor, telling put_prev_task_scx() that the donor is
- * about to be dequeued and must not be reenqueued.
+ * about to be dequeued and must not be reenqueued. Caller holds @p->pi_lock
+ * and @rq's lock and has already updated @rq's clock.
  */
-static void scx_block_proxy_donor(struct rq *rq, struct task_struct *p)
+void scx_block_proxy_donor(struct rq *rq, struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
 	rq->scx.flags |= SCX_RQ_PROXY_BLOCKING;
 	sched_proxy_block_task(rq, p);
 	rq->scx.flags &= ~SCX_RQ_PROXY_BLOCKING;
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index d32bc01071b0..d2e0e7a23639 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -19,6 +19,7 @@ void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 void scx_prepare_setscheduler(struct task_struct *p, int policy);
+void scx_block_proxy_donor(struct rq *rq, struct task_struct *p);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
 bool __scx_allow_proxy_exec(const struct task_struct *p);
@@ -54,6 +55,14 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+static inline void
+scx_prepare_class_switch(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *next_class)
+{
+	if (scx_enabled() && next_class == &ext_sched_class)
+		scx_block_proxy_donor(rq, p);
+}
+
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -73,6 +82,9 @@ static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
+static inline void
+scx_prepare_class_switch(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *next_class) {}
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
 static inline void scx_proxy_donor_start(struct rq *rq) {}
-- 
2.56.1.750.gf70dc682cf-goog

