Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA23A6F06
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557776; cv=none; b=RbwEmxWVSWjSlQCDJhvGNSMgA2Cm1wop23zBo2KCz9OngetGFlZdxNM7s6QGJjSSqyDM58Qw+uKrPmtOTAoLZbnHU2iBe42BfGh9LaIgbo4e51fcogNC49i6gUEnaMyBAzi4MjVGpdXl775CJmU2ODAz7s8duipDZW1Erd6v1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557776; c=relaxed/simple;
	bh=/F4faJlCk5xFIpMdFjvblOLbKJepVT7BEZ3H6ShzYpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebLulDR67RHfb7n97rbWCu/u4UZTzQo2gEFCcCoQPy2+/cxQ2dUUdl6FTwMwqfkuE95/Zb9f2pJbmH9NWEmLPP25VKT4j8i78hwYDvMz9R+RSAk6sqmRmOXd5rRPDL+f9z21Tzz+e/FJWi0LgZ8p+RGAwlNKjkRlHgKeFLOgz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni0G6qyM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni0G6qyM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adbfab4501so6875765ad.2
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557775; x=1775162575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQWmRiTvxEJUeJjwhYuVUrdZjK9tcpL66RkPZ6C4zEY=;
        b=Ni0G6qyMvddsZrikZFLyvneHszY4uZbu98rWQHk6Ri1Q9WnhzFEieFBjW8VPW4Cg6E
         enjP9iSUXO882JTIEvSuRjKJYizYRr43q0pjKCPsf9Uo0Yu7eXHOISbTOZxwZjgORXSb
         qsnm4hXLNWdyySZ/4Mo6OaGL+JFVTqqsPORixtoNzeC8QcFPz4culM4ppLr5xLpuEzcW
         tNndFtgNmr5VrJjf9UqedNDSrJi6HMAIeHKXF2o4ZML5B1KWxXXJTNhU5CI/UM4bldUg
         C4+PGMdYW9JJUCva286xVzM7v+uD7gs7qCqfE57Cx/yIoHNRWgoIbbsE4cempbxZfrWX
         EYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557775; x=1775162575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQWmRiTvxEJUeJjwhYuVUrdZjK9tcpL66RkPZ6C4zEY=;
        b=hhiJCsLAoF5VSug2GMMdKU1Eyjr5po/uFeqHZKpRwPlsyWgWQiS0aRriLkt50BaBnq
         ItikW+vUno275nVElK59cRuyRd4pboK5UBQ3Gw6zf6jggqS9mnfRB1JXlIKB/xEyzwS0
         B68I3lsTJ+dauStox/BR1WQQ21fpTqwSrDUuwNTFL6IeHD8pOCk1hlbNGjr0Ncsd+3bZ
         YR/CQ0/VJEU2xYSUtG7k6g/A7f0cU7dLwNP+/iheGI/ZinZPXev1IhOIDObVvT3wKsed
         2VInTdeAkkWZvKUDDx6K9GseFvlrfp9zPlLNUzx40x/HS+89u01e70zj6zh/hAFAd/r1
         M+kw==
X-Gm-Message-State: AOJu0YwIvUKH9EhS/kcC/TU2yKPTS5TQUNLU4PH7R5TNyj5WmnGs8K5B
	UqCxm9A8whiP66lliYNmwjEdWfOADJkfYgttuu8aq5bVbDlHM8UpsMTJzvH98w==
X-Gm-Gg: ATEYQzxJm92vyOL4Co8J9c5bZ6qqBNAKPnHS+V2r1mtcVIhgNDJrHXo8dpctFSGN0du
	bTOA99nfMvyPCrV/yRKcSO+hbeqb82d7r8Cue1gs+wnD7gJqZYc0/VoSE5fpXIcmllPT/J7lY4F
	RxO45uXFeJw3Fu6j2TQkEjnL0Vcky0DwUtMjgUt/qDpbRVC7o0FkdA3+CfUaZtNgR0g0cLGSxSD
	EQDho8EecZmPYtqy6TLmalGPdlwZQC4tB4NaB9VMGmvyBsEvMRx1zyLLDFzgboEWHuyePZbPHyF
	gdtE61e1QpX5Z/o6cQ4YK/mkQJVAJvQjRbeJVQHcCnWtPVb5A3SRtjhCya/97g54H4vOahrStHL
	UNBZLCRsQSvH7DZMCcdKlJ5I5Oj+P1JTs1LcgtVvJ4JW2rLaR0fuLmx8pvg4ONg/aIp9eolwdIM
	Ig7AeiBnKKAACeRCxlYM+5Rd4adKOu6+PSs1oc+B3G2t0H9rqKEMCNCoyykvFBlcWpe3DPgZ008
	pc=
X-Received: by 2002:a17:902:e952:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2b0cdbf704cmr414835ad.6.1774557774864;
        Thu, 26 Mar 2026 13:42:54 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm4004905ad.25.2026.03.26.13.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:42:54 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 3/4] selftests/sched_ext: dsq_reenq: fix reliability with two-DSQ design
Date: Fri, 27 Mar 2026 04:42:37 +0800
Message-ID: <20260326204238.3755737-4-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204238.3755737-1-suzhidao@xiaomi.com>
References: <20260326204238.3755737-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original test used a single USER_DSQ for both holding tasks and
triggering scx_bpf_dsq_reenq().  ops.dispatch() consumed directly from
USER_DSQ, which raced with the 5 ms BPF timer: by the time the timer
fired, dispatch had already drained USER_DSQ, so scx_bpf_dsq_reenq()
found no tasks to reenqueue and nr_reenq_kfunc remained zero.

Fix with a two-DSQ design:
- USER_DSQ: tasks land here on initial enqueue; ops.dispatch() never
  consumes from it, so tasks accumulate and the timer always finds them.
- RUN_DSQ: reenqueued tasks (SCX_ENQ_REENQ path) land here; dispatch
  consumes from RUN_DSQ so tasks can run.

This guarantees scx_bpf_dsq_reenq() always observes tasks in USER_DSQ
and nr_reenq_kfunc is reliably incremented every timer tick.

Fixes: c50dcf533149 ("selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 .../selftests/sched_ext/dsq_reenq.bpf.c       | 45 ++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
index 750bb10508df..ccce75a99d8a 100644
--- a/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
@@ -2,9 +2,15 @@
 /*
  * Validate scx_bpf_dsq_reenq() semantics on user DSQs.
  *
- * A BPF timer periodically calls scx_bpf_dsq_reenq() on a user DSQ,
- * causing tasks to be re-enqueued through ops.enqueue() with SCX_ENQ_REENQ
- * set and SCX_TASK_REENQ_KFUNC recorded in p->scx.flags.
+ * Worker tasks are placed into USER_DSQ.  ops.dispatch() does NOT consume
+ * from USER_DSQ directly, so tasks accumulate there between timer ticks.
+ * A BPF timer fires every 5 ms and calls scx_bpf_dsq_reenq(USER_DSQ, 0),
+ * which re-enqueues every task in USER_DSQ through ops.enqueue() with
+ * SCX_ENQ_REENQ set and SCX_TASK_REENQ_KFUNC in p->scx.flags.
+ *
+ * Reenqueued tasks are placed into RUN_DSQ so ops.dispatch() can pick them
+ * up and run them.  This two-queue design guarantees tasks remain in
+ * USER_DSQ long enough for the timer to observe them.
  *
  * The test verifies:
  *  - scx_bpf_dsq_reenq() triggers ops.enqueue() with SCX_ENQ_REENQ
@@ -18,7 +24,13 @@ char _license[] SEC("license") = "GPL";
 
 UEI_DEFINE(uei);
 
+/*
+ * USER_DSQ: tasks sit here between timer ticks so scx_bpf_dsq_reenq()
+ *           can observe and re-enqueue them.
+ * RUN_DSQ:  tasks land here after reenqueue and are consumed by dispatch.
+ */
 #define USER_DSQ	0
+#define RUN_DSQ		1
 
 /*
  * SCX_TASK_REENQ_REASON_MASK and SCX_TASK_REENQ_KFUNC are exported via
@@ -58,27 +70,36 @@ static int reenq_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 void BPF_STRUCT_OPS(dsq_reenq_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	/*
-	 * If this is a kfunc-triggered reenqueue, verify that
-	 * SCX_TASK_REENQ_KFUNC is recorded in p->scx.flags.
-	 */
 	if (enq_flags & SCX_ENQ_REENQ) {
 		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
 
 		if (reason == SCX_TASK_REENQ_KFUNC)
 			__sync_fetch_and_add(&nr_reenq_kfunc, 1);
+
+		/*
+		 * Reenqueued tasks go to RUN_DSQ so dispatch() can run them.
+		 * Keeping them in USER_DSQ would cause the timer to reenqueue
+		 * them again endlessly without ever running.
+		 */
+		scx_bpf_dsq_insert(p, RUN_DSQ, SCX_SLICE_DFL, enq_flags);
+		return;
 	}
 
 	/*
-	 * Always dispatch to USER_DSQ so the timer can reenqueue tasks again
-	 * on the next tick.
+	 * Non-reenqueue path: place the task in USER_DSQ.  ops.dispatch()
+	 * does not consume USER_DSQ directly, so tasks sit here until the
+	 * timer fires and calls scx_bpf_dsq_reenq(USER_DSQ, 0).
 	 */
 	scx_bpf_dsq_insert(p, USER_DSQ, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(dsq_reenq_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(USER_DSQ, 0);
+	/*
+	 * Only consume from RUN_DSQ (tasks that have been through the
+	 * reenqueue path).  USER_DSQ is deliberately left for the timer.
+	 */
+	scx_bpf_dsq_move_to_local(RUN_DSQ, 0);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_reenq_init)
@@ -91,6 +112,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_reenq_init)
 	if (ret)
 		return ret;
 
+	ret = scx_bpf_create_dsq(RUN_DSQ, -1);
+	if (ret)
+		return ret;
+
 	if (!__COMPAT_has_generic_reenq()) {
 		scx_bpf_error("scx_bpf_dsq_reenq() not available");
 		return -EOPNOTSUPP;
-- 
2.43.0

