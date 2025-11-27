Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC41391;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258496; cv=none; b=UP8MZ2ak7kVntk2VNpNWZAkjBO/D8tJ8Fq5u/jzhxyfb5XT5FCQueZk1ocSUwpNCrMTsQOcR/47dlLNW9jwH2fxIN9/cNhEX2KhG/D+cBvsAeQBVm7Uvqkpn17WvNjPTux+ewBG+jan4OoLdf3SC42qW1dwB5I/jT4owAhpfuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258496; c=relaxed/simple;
	bh=szdsVpTs9+zbXS/0lR/jnO42tgSCUM8xtocZUBWfick=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=au2rbNDZkSo2r7osfA8X8gS3Xxuxe3erTbowNvPyBdsHFomcci7SRVbPBmSE7HhobcNJs3QrIxu2mMdz3cz/r6+VtGRsMNmBW2XUxP8qX3olAs/kRsZK74f6vgezQoXY2gSjcavYJwC9bkTEDM3EkAVrd2IN9QKbyUcYQgi0hNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KAftj7Kc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KAftj7Kc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Fg/dshgqdIk9MpN0Q/eQ+5nOs/fbqHzIMhoq7/G0x7Q=; b=KAftj7Kc7WT3PAypmJH+7yDeqx
	GUT0RRLjsZf5uMQe0p1lDEWpfcL5gKFXMrthwp13UCkWZxsYIZAniRAaulN75i4go7gRdhfZT522b
	wdi+A64zEh4qqrkaIJdVP8qqzGfTX/8OWZNyVP3QBeY1zPCQI5faxCROIJo4DIrhaT2o/J0Xcdinu
	92GE1moKnQrZWPneI6EhmhcRF4P8M6wWUEObmwr7BHL4bbygySOQTnpt+cJx3o9L/OLJez+CcbEbu
	WpW4RKduIDNGTjqPtzNs3XoOZIS+mCn8aKaCFvY5hiJ6lzh2t4ULXB4ZscmgJOMCAknDZTk3sVtqj
	yB/hVB1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdMT-0000000AP1y-3J2p;
	Thu, 27 Nov 2025 14:52:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AAA7D300F1A; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127154725.532469061@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 2/5] sched/fair: Avoid rq->lock bouncing in sched_balance_newidle()
References: <20251127153943.696191429@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

While poking at this code recently I noted we do a pointless
unlock+lock cycle in sched_balance_newidle(). We drop the rq->lock (so
we can balance) but then instantly grab the same rq->lock again in
sched_balance_update_blocked_averages().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9902,15 +9902,11 @@ static unsigned long task_h_load(struct
 }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-static void sched_balance_update_blocked_averages(int cpu)
+static void __sched_balance_update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
-	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
-	rq_lock_irqsave(rq, &rf);
 	update_blocked_load_tick(rq);
-	update_rq_clock(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
 	decayed |= __update_blocked_fair(rq, &done);
@@ -9918,7 +9914,15 @@ static void sched_balance_update_blocked
 	update_blocked_load_status(rq, !done);
 	if (decayed)
 		cpufreq_update_util(rq, 0);
-	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void sched_balance_update_blocked_averages(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	guard(rq_lock_irqsave)(rq);
+	update_rq_clock(rq);
+	__sched_balance_update_blocked_averages(rq);
 }
 
 /********** Helpers for sched_balance_find_src_group ************************/
@@ -12865,12 +12869,17 @@ static int sched_balance_newidle(struct
 	}
 	rcu_read_unlock();
 
+	/*
+	 * Include sched_balance_update_blocked_averages() in the cost
+	 * calculation because it can be quite costly -- this ensures we skip
+	 * it when avg_idle gets to be very low.
+	 */
+	t0 = sched_clock_cpu(this_cpu);
+	__sched_balance_update_blocked_averages(this_rq);
+
 	rq_modified_clear(this_rq);
 	raw_spin_rq_unlock(this_rq);
 
-	t0 = sched_clock_cpu(this_cpu);
-	sched_balance_update_blocked_averages(this_cpu);
-
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		u64 domain_cost;


