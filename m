Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795328483;
	b=xpke1ZbF5rwmXuXU8xIW9uqRNy+F8YyvIkzMZcXwrit7ytERX9BIM2PiFjetOfHl/5Zg
	 OMaolfBfi9f8byDi+GManiQ+8anrzHEkaDoK+J+3NttWKbIrnxre4jF4mUrcz6Y4TJxjn
	 SySwWNBK3fQ2MlDfFVWDKBg5LvU31xzAaHm1tZH3rdATGG4PBtXJ+GgH5gAZqIdun5SxJ
	 DOFfZ+DQbESWOHBYN5XWk55oyn68qhQ76fStZZMQiJnhYm+tUHUnmFaIzsnIP8WT2kcrD
	 aKi61RQ/qdjlgYhnfMQNya7htZK2kgzWh9mB3q/qZu0GMTc/QUXjdhZvLQ5tOQgSTvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795328483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=koc9xJiwfj5fEHnmMrkj9b2J5u5Ubgro9rz3sdyn6XE=;
	b=yI7yumiaWXmb38XsYC1DiDNRg3MyG90+QBCry1QttDXWry3PHYbtc9IlMmMoqx2KDQZ7
	 qaf6Lpv9g6eljHauKP1R8aBslKL3BRpI19+0CE73hB3NQN0Z3er9D93QG4Ncu3B4+SBTU
	 JiyjObZjjgJL/6V14zY8PQszd66V1n8buIpX2+CtPDEo+W6rYNEWxj4FDAuHNmtbQbwZ+
	 n1LMoQ5waXeZWkahKc1kXUf33+Dm44LzrPg1Lj8VhFXmtB5IF4U2W4tiOuuKUIvnfINLl
	 tRyi9BBZz+RO18UZmdC/0NCbjd47AbYb2W+ml5V5/ZluVOm39Iw9xOD34ao+iu5ET2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJKhU3NR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39358606A32A
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 06:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39358606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJKhU3NR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386177b0516so6267203eec.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 22:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795328482; x=1795933282; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koc9xJiwfj5fEHnmMrkj9b2J5u5Ubgro9rz3sdyn6XE=;
        b=cJKhU3NRn1OeLCTV3n6xLN9plA/abFgHHhcXof4uy9+Heol/lDm+6gmoj1IIG2nYBr
         IgSjX8AvCzMqtobGL56vEfCnmBmSgp34+Ac4TVRiD68Wo0xSfNkCQSFfll6T3qEyvKpT
         04ovycIQz38khUpGk1J5vBJdGfhtbmYV1f3hUstjxxIrceCqwAfBALxWYk/7N8zCHI1I
         LG4giwnZ3BGiN2ncmMMaBPCLq++18lhli+70TtH/pm1TYHjVcJt5OgbtTzpmdMLJ4OQ2
         1TgQt4aDmp/+KlprLQMfHuAvyUYd5W7NP3Br2Qwuo61ijhMeNbyjaBlSLrF/ODN5FHig
         Qt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795328482; x=1795933282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koc9xJiwfj5fEHnmMrkj9b2J5u5Ubgro9rz3sdyn6XE=;
        b=OqCfSyrl+XxisIiuOxbM951hSnoPfvjRPDzIaqr8P1O+NM3jQnxxfQt3AUgUMJle+l
         Ag9Kn9Ya6d/xGubRG89XjSagA6zPNvBRyqa4QvaaIrjUAiikI5wNvm0aKXXXHOagJ+Nc
         5eTsSLD7M/tlmDnakIit9UcvkVITwX1F8P/+P0qxLrDiOJbNRjttFY64RsDMZ47Fcx39
         8FO2Mg5QKol30hsOvx8TUhW+gc1Pg81zyeZ5kF6c8pLYmmWFBrtKb7QvB7VixtTnK33O
         hzS3wRAsH+1X33uJanJ2ViA6I7egFxwO5qDqyRrHxJ8A3qy/grepMSTiDhnfLfw8BDxi
         1QEw==
X-Forwarded-Encrypted: i=1; AL+hErFGY+0wfg8a6rK2ue+hfM4HpcH+ZvYnyLhgQ4BCaH5P8bzzcJn+WgqFzfne/A67km7RDtkNgQ62V5A=@lists.linux.dev
X-Gm-Message-State: APuU4Z9zRjmETnyZDg4SNR7TnTK9wmsXlUaUdl95DHfnS4vnzAfltTdd
	5aSmk9tHXaG95UX6VqJvnNA2kz7WNz2femOebV5WKvIp+84jwdI7SlC1Ip2/CsqeKzurSbK/tZF
	0xhRSKLPELe/64HV2mA==
X-Received: from dli24.prod.google.com ([2002:a05:7022:298:b0:195:d59a:94bc])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4593:b0:177:9a5b:a89 with SMTP id a92af1059eb24-1b556906925mr8700359c88.29.1795328481804;
 Sat, 21 Nov 2026 22:21:21 -0800 (PST)
Date: Sat, 21 Nov 2026 22:21:21 -0800
In-Reply-To: <20261122033316.2819845-1-penghuang@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122033316.2819845-1-penghuang@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122062121.4172437-1-penghuang@google.com>
Subject: [PATCH v2] sched_ext: Update other_load_avgs on set_next_task_scx and
 idle entry
From: Peng Huang <penghuang@google.com>
To: tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, haoluo@google.com, brho@google.com, 
	joshdon@google.com, linux-kernel@vger.kernel.org, penghuang@google.com
Content-Type: text/plain; charset="UTF-8"

When scx_switched_all() is enabled, scheduler_tick() skips
sched_balance_trigger(), so __update_blocked_others() no longer runs to
decay RT, DL, IRQ, and HW pressure load averages. Other-class load
averages then depend on scx_tick() and SCX_RQ_CAN_STOP_TICK transitions
in set_next_task_scx().

If SCX_RQ_CAN_STOP_TICK stays unchanged (e.g., remaining set across an
idle or RT interval on tickless CPUs, or remaining clear on finite-slice
switches before a tick fires), or when an SCX task goes idle after an
RT/DL interval without an intervening tick, stale RT/DL PELT values
can remain elevated when consumers such as effective_cpu_util() or
update_idle_rq_clock_pelt() read them.

Refresh update_other_load_avgs() once at the entry of set_next_task_scx()
(before SNT_REPICK early return and before ops.running() for SNT_PICK /
SNT_NORMAL), and in put_prev_task_scx() when transitioning to the idle
class.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
Changes in v2:
- Call update_other_load_avgs() once before SNT_REPICK return and before
  ops.running() in set_next_task_scx() so BPF callbacks such as
  scx_bpf_cpuperf_set() see updated PELT values, and cover SNT_REPICK.
- Refresh other-class load_avgs in put_prev_task_scx() when transitioning to
  idle_sched_class before ops.update_idle() and update_idle_rq_clock_pelt().
- Link to v1: https://lore.kernel.org/r/20261122033316.2819845-1-penghuang@google.com
 kernel/sched/ext/ext.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..523f86be4d26 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3579,6 +3579,15 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	if (unlikely(rq->scx.kick_sync_pending) && (type == SNT_PICK || type == SNT_REPICK))
 		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb, kick_sync_wait_bal_cb);
 
+	/*
+	 * Refresh other-class (RT/DL/IRQ/HW) load averages before ops.running()
+	 * (or returning on SNT_REPICK) so BPF callbacks such as
+	 * scx_bpf_cpuperf_set() observe fresh utilization while CFS PELT is
+	 * dormant. In the future, we might want to add a mechanism to update
+	 * load_avgs periodically on tick-stopped CPUs.
+	 */
+	update_other_load_avgs(rq);
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3619,10 +3628,6 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
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
@@ -3634,14 +3639,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 			 */
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
 			sched_update_tick_dependency(rq);
-
-			update_other_load_avgs(rq);
 		}
 	} else {
-		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
+		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK)
 			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
-			update_other_load_avgs(rq);
-		}
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
@@ -3863,6 +3864,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (next && next->sched_class != &ext_sched_class) {
 		scx_cid_sched_update(rq, NULL);
 		switch_class(rq, next);
+
+		/*
+		 * Refresh other-class load averages before entering idle so
+		 * ops.update_idle() and update_idle_rq_clock_pelt() observe
+		 * decayed RT/DL/IRQ/HW metrics while CFS PELT is dormant.
+		 */
+		if (sched_class_above(&ext_sched_class, next->sched_class))
+			update_other_load_avgs(rq);
 	}
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

