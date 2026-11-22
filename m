Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318398;
	b=SSIVGGIH8uPlE4N6R921JSQbaOPdhAGvbxDvfHdI09cAH7QgF+5sQ0Lq+CBARbkBRNAy
	 bvvlkxSBB8frNPExNDdLZS4rZqJjLIIlxGztYhB+dKarEjTUUdFJ6MfsPD6PrsOKbnU8G
	 Z57xn6VLpmcDu+gUuAXM4uM+V05yFicRr+hyVhOKsVpONCOg/u/1JgmIOZDbmtpI/ZSuh
	 YoKc4pcNUHR/dd2VR1dl2DrSQh8R2RvdF2KNPdptWusUvOtArkuIqI9r1bF98b0iJ8e4h
	 XzAXvhvTT2r29bIOyRnqCPhvi/7M8n2Q3oSYmCPSsS8jHk4NDYo17oOd/EEgscmODVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nEWTTmYbR5yEEt5N6be7z5Q5FBiYqT8Psorb4IsgBd8=;
	b=p0x7FUh/w4gpPGAR4jej8Z2JCFYN+4F88EmkITe7McWMzwF3DKG+/aSTclm6IX9/Hbp8
	 VBIIabMS/KHGI/Alsn6Jho24oJ0rNdXwyexAZwSW8dcVaQUDhcPLEA+qPLbAsfWn9KExt
	 yoOZbn+SZJM937zFg4FLAuW6sVWXKycGhALXAe1s+KoM/+m7hrKsOfGhdPBqN7x3FjbP3
	 PAT7/8DCLdwmC2OXiw6iQRRzXTY3fSmeZWiNJX4bEg6EAk0Ye0QH823/jQOPhleLNzPH6
	 xfKYDe4yrjbwQnPxPn2SjGfeKt/SZNIh81p+PVt+WKLEgYZmv1GqLSBj7uqBtrjzNQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEVQpbMJ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CE606A32A
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 03:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7CE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEVQpbMJ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3084323eec.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795318397; x=1795923197; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEWTTmYbR5yEEt5N6be7z5Q5FBiYqT8Psorb4IsgBd8=;
        b=UEVQpbMJvgbX/81uBm02U+pZ0raggMWHErYPR9FsqxBIHhu4JG/BgbN8nelDW7B2CG
         WmgXZ3NDkGilSmPTZ+atWPsr+85ZAifhjosIIIF/T7602k1vqVkD4CgMsBfWilPT458K
         1V6dDTjhD4r43iqVG0Ar8GoixIZMElPg2ycKbw3sRlKRxCcFIfCF3P0Mcnl3NRCNDq2V
         Z5l4MT5sUqMP1qiwHdoF4Z5y5JljVJEJ2//BSjyuANTZo+txy3DRVTuwqW+WEcOIKMLb
         Y7I5A9syh8R5xt5JiWjyftq/62g4uWJCjzM94KMvm52KQUmRhTxlqmNEQ2fXPmA1pPqx
         UOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795318397; x=1795923197;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEWTTmYbR5yEEt5N6be7z5Q5FBiYqT8Psorb4IsgBd8=;
        b=j1mVGDSXrOtiK7oJIulAqMupC+AqhaEh0r6ptprdmSZpcUWXjhxb93OW3x7GU7mp/x
         Hhdyp/YdWS5E/KqFkTXsLAhLXtcPVfrbOG4PpcvcljW8FJPsmInkAXDl1Gy+Xsz775aW
         0cPnGl+gAJfmSD/0J1EWvxNNWtf/05jmuYL+4WTUEpuDayI8okOKoGxuNQbhCCpMw7qC
         lZyJFeyuUOLV9lRAp7tmFo4bButXtQX2+YrdvjnoH8RDlWqxpm6rJWW7tAfyx5qaE1YX
         rWX5gydmCh2boPKBrBQ/GJjidswIqAWV7cJJQBLjAFFMPN4/Ctd4reTPkW4Uqyc7eEVA
         XxeA==
X-Forwarded-Encrypted: i=1; AL+hErF0Xtue2ojUmmmdveFsGJJS/KcsWuIkhqyvAs30KzLc0fAqI4zAwT0DvI46e4VLy7gLiKAIIVBjG3k=@lists.linux.dev
X-Gm-Message-State: APuU4Z+yAbla7fEmTnNrrUcTcgFUrmppFAgZI1SDfzm0RCW9/Ikjhz5E
	l80vAU9NpUbyIq/JaVHXYLILGhJ+n6otxxUyD3lDZKfV4CjR32EfAjNhB5JN28oAjwYuit/6X2n
	m6oVfR+7ZkklcHAAAPg==
X-Received: from dlgw5-n1.prod.google.com ([2002:a05:701a:cc85:10b0:15f:4035:64c7])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f516:b0:1b5:4aba:b087 with SMTP id a92af1059eb24-1b5567c0c01mr6774411c88.3.1795318396734;
 Sat, 21 Nov 2026 19:33:16 -0800 (PST)
Date: Sat, 21 Nov 2026 19:33:16 -0800
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
Message-ID: <20261122033316.2819845-1-penghuang@google.com>
Subject: [PATCH] sched_ext: Update other_load_avgs on set_next_task_scx
From: Peng Huang <penghuang@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org, penghuang@google.com
Content-Type: text/plain; charset="UTF-8"

When scx_switched_all() is enabled, scheduler_tick() skips
sched_balance_trigger(), so __update_blocked_others() no longer runs to
decay RT, DL, IRQ, and HW pressure load averages. Other-class load
averages then depend on scx_tick() and SCX_RQ_CAN_STOP_TICK transitions
in set_next_task_scx().

If SCX_RQ_CAN_STOP_TICK stays unchanged (e.g., remaining set across an
idle or RT interval on tickless CPUs, or remaining clear on finite-slice
switches before a tick fires or before going idle), stale RT/DL PELT
values can remain elevated when consumers such as effective_cpu_util()
or update_idle_rq_clock_pelt() read them.

Track load-average updates explicitly with @update_load_avgs in
set_next_task_scx() and refresh update_other_load_avgs() on SNT_PICK as
well as when SCX_RQ_CAN_STOP_TICK toggles.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/ext/ext.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..e29c9c18e1ab 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3553,6 +3553,7 @@ static void kick_sync_wait_bal_cb(struct rq *rq);
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	bool first = type == SNT_PICK;
+	bool update_load_avgs = first;
 	bool can_stop_tick;
 
 	/*
@@ -3619,10 +3620,6 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	 * @p is getting newly scheduled or got kicked after someone updated its
 	 * slice. Update SCX_RQ_CAN_STOP_TICK to reflect whether the tick can be
 	 * stopped. See scx_can_stop_tick().
-	 *
-	 * Moreover, refresh the load_avgs just when transitioning in and out of
-	 * nohz. In the future, we might want to add a mechanism to update
-	 * load_avgs periodically on tick-stopped CPUs.
 	 */
 	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
@@ -3634,13 +3631,12 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 			 */
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
 			sched_update_tick_dependency(rq);
-
-			update_other_load_avgs(rq);
+			update_load_avgs = true;
 		}
 	} else {
 		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
 			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
-			update_other_load_avgs(rq);
+			update_load_avgs = true;
 		}
 
 		/*
@@ -3651,6 +3647,15 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
 	}
+
+	/*
+	 * Refresh other-class (RT/DL/IRQ/HW) load averages when picking a new
+	 * task or toggling nohz tick dependency while CFS PELT is dormant.
+	 * In the future, we might want to add a mechanism to update load_avgs
+	 * periodically on tick-stopped CPUs.
+	 */
+	if (update_load_avgs)
+		update_other_load_avgs(rq);
 }
 
 void scx_proxy_donor_start(struct rq *rq)
-- 
2.56.1.750.gf70dc682cf-goog

