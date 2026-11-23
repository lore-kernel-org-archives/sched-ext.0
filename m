Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464834;
	b=cn276jVdY+n+ud0cBrGiQTdbMt2TjOjX2I4wtJLJbS3Y1XV9TSckcF9Cxew+orMMCCnJ
	 j4y48vpUm4Tuv3BzJrysnFUqeWDD+gYRQgsG4KV/yGRtcPCIn5vfQkzm5LId24v+clZkw
	 2ULC94gBop84JZgwne3YpLhsj5uLidvRw9fYZDi/ItO6M6HkzN2HPWvoMpsPm2oX6vrKd
	 yvOoL0kYxH08HIXW90pzk/2SU7Tkgb9nT8LyHBCkkvGcb1Wyyk2MxX9ZUicqTF+kqc5bl
	 RHDZljDrr1MY3CxNDG2Ej9KuN5OiCAAiECOHImY0t2k2uhwvTBQwpM+onUPZmbEtBng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
	b=4Lm8fyb860kY1alLZn22Gz2mtR699EFW8GsrbIrsS7CJ91G0Jflah8IOaRRWdWxIZQG4
	 UD+mqjgzGelCd8mSrl1a1CPYwIwSv4+fbY17S8S5I2NA+WrqpE5sNaRdOKW1XgU+SvDaJ
	 T21hIS/zBJXHS6Jg+tFXLL7ClPpgoomVn7uSsMWvBoQ8R4CxwdkhQG3julV+e6gy3t1kz
	 pcrMNuc9arXv0W/ni2oWDAZANUz1mUNL1dZM/E812qrErOPksE6h1R9Y8CJ5VpoxHk446
	 ynwId+MrG7q+yTtG6ADrDITGMEdZrhJYRBJ5uHk0H1SGUmAjFruDLIMypanrNnEQ7Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j7HVZsDn;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08458606A32E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 20:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08458606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j7HVZsDn
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386ad819860so193445eec.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464833; x=1796069633; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
        b=j7HVZsDnW279ATvM5NgJFXFthxlSeFlFdVNkFZiKNk43pqY+KR0SzC4T30HNU/ckUT
         Oa5DJrEkWoI3iprix2bdbo5GjV961fOtw6h0lJ0bDql21pnoKgP+0ISoAEczt638+zer
         ntCx2C3u/STqVdQABRh3qS64VNurKQGWrCDY2e6kT517831PNLPj4Fp9EuVfya/KfcqG
         qcLdkBVRvTWMb4ZjB2VpVjVlgEI1pdFCuEFyfzvf1SESZgi37uBqj8BKJVu3Er5GX95H
         oRS6EO1eq0eaDVEzK9fHsCUUIQb4B799SaNXOEvfBFUZb75Hvs+FZK7iA0rWKxrTeqZu
         BcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464833; x=1796069633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
        b=zNnwKt29jeEIHs8Snl1WoJr/wkKbg1ZZnSTqoc0xTY3Jr+AG6gjRW9yamzmelLXUma
         /dBzha4BrH2tzru+HJIcjK9BZrFnIei7SNGL7un6jdi8k9l2EPOv3RLvhMafRMVH2Oq3
         tBW60BvrNSISrDCwh0vSPqvQRxKqs/L8rSMseYQngEcv61GH3OQ6BjROdpiSyZL+u+bE
         2ihWvY2OPe9MVJh4W/5NzdDj0zbkssZuXq7Sls2xfXCllayEnQv1ZhnLwzQKpbISvt0H
         MSwCvpxigwVQtopGf6scoNziWcPCF9kfDmc6zs2fD2baJIdyGfMtKhxo8qZoqVD2R99B
         MjHw==
X-Forwarded-Encrypted: i=1; AL+hErGY+eVrSJHEFruyCHKt3IXjAmIduFqrSIVz+53WtX/4Q+HZ21r2TrjRh7Hi0iHwC7aQJrr+Sp2caAA=@lists.linux.dev
X-Gm-Message-State: APuU4Z8iZRAtRdwffr9XwHVOLYa+dDlVHBJN55RSa/OZpMPnekdGA6/8
	i68lkrM03m5kP/VnAwq/HWqrCsQBb8N2IAvd94x0F2IA5cn9Yl8WcGZ/Rp5507gLuo3y3HkGKqK
	YgoXs9M0BT8zgqnc5ag==
X-Received: from dybmb7.prod.google.com ([2002:a05:7301:1907:b0:385:6c3c:3ea1])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:f498:b0:386:a716:916b with SMTP id 5a478bee46e88-386a7169544mr6533417eec.31.1795464832877;
 Mon, 23 Nov 2026 12:13:52 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:50 -0800
In-Reply-To: <cover.1795462673.git.penghuang@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com> <cover.1795462673.git.penghuang@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group avg propagation
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, Peng Huang <penghuang@google.com>
Content-Type: text/plain; charset="UTF-8"

In update_load_avg(), __update_load_avg_se() ages the group entity @se
before propagate_entity_load_avg() runs. If @se's _avg has already
decayed to 0 while its _sum still holds a sub-divider residual, and the
child gcfs_rq's _avg also reaches 0 (e.g. when its last task detaches),
update_tg_cfs_{util,runnable,load}() see delta_avg == 0 and return early
without subtracting @se's remaining _sum from the parent cfs_rq.

Keep scaling non-zero averages by the parent cfs_rq's divider to
preserve period_contrib alignment, while letting zero-avg propagations
proceed whenever @se still holds a non-zero _sum so the residual is
cleared from both @se and its parent cfs_rq.

Fixes: 7ceb77103001 ("sched/pelt: Continue to relax the sync of util_sum with util_avg")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/fair.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c8af1cac2d5..f6c3bbb19557 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5516,9 +5516,15 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
 	u32 new_sum, divider;
 
-	/* Nothing to update */
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep util_sum as-is for unchanged non-zero avg */
+		if (gcfs_rq->avg.util_avg != 0)
+			return;
+
+		/* Nothing to clear once se->avg.util_sum is also 0 */
+		if (se->avg.util_sum == 0)
+			return;
+	}
 
 	/*
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
@@ -5543,9 +5549,15 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	u64 new_sum;
 	u32 divider;
 
-	/* Nothing to update */
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep runnable_sum as-is for unchanged non-zero avg */
+		if (gcfs_rq->avg.runnable_avg != 0)
+			return;
+
+		/* Nothing to clear once se->avg.runnable_sum is 0 */
+		if (se->avg.runnable_sum == 0)
+			return;
+	}
 
 	/*
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
@@ -5617,8 +5629,15 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_avg = div_u64(load_sum, divider);
 
 	delta_avg = load_avg - se->avg.load_avg;
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep load_sum as-is while child load is non-zero */
+		if (load_sum != 0)
+			return;
+
+		/* Nothing to clear once se->avg.load_sum is also 0 */
+		if (se->avg.load_sum == 0)
+			return;
+	}
 
 	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
 
-- 
2.56.1.831.g720f3f5937-goog

