Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312652;
	b=oNYswnXy5KiL5TzfN0/RrwFLaMM3nYnWBZUbujqI0yomn2lTQlIa7D/BWl1hDvbkk6QL
	 yYqlfrm75UZ4M9FEOqd+TR91rjuaS6gGLlhK+id+qakb2os1nk58YCJYC+m/LtycsQjTw
	 Rqpu1wVQrQ+jKTPk53RrOuiEzyiOkX1jSh9hTVi1HmjjO7d4Pdh26HF2yB+GJjAT4WnY6
	 tpJNwkP3dG9/uCprf8/zNWf+mNj097NbxzxoTQLEiQ2yDzHcuW+S46Ev+h75IyZXsfF0e
	 ejunafgtx12nGA8Y4dabu/kRi4x9f/QMNf/k1p12fahoCbtwYNC0Nl9e4W8poB/d3qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
	b=Ykd8Y0KMxHcUcOkBMo1lgfz3KYhTJ68WDwQzh34eYugkw+QT9v4cstOypf7TlgVaZtH3
	 72by9PR5wdCuF/w/LInqVRuKMmWKY7I0DHIe6TloJ8qiQONFAZFobcAelGG0HEmhzIoVW
	 nBRkULxrxMMt/Rab3CVZF4sUW5L7hch8JV/eF4ImnP4RizGosw+Wkqmzl637m+ASHzbtn
	 hfb9MZY5OA2YDwsJUoTWsD+vMuENrvQ+o63L28ID+1qasw9rUWeenZ8RSQ03m7AWaKiO5
	 e76d0MlzYjZQRyC0+CBUDNU5jiVZr4stJY0LHcUqYrZdUn8Qj+IgIgwPY39beX99gPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZHVlImnz;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC71606A320
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 01:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZHVlImnz
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b56c696405so1296350c88.1
        for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 17:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795312651; x=1795917451; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
        b=ZHVlImnzYu2CSxenbfjmnnWc1tUEEp6J9m4s/8YAqJ+ze0jqPlU7Wci9aIgRA/Q1eD
         Z9dG8tqIu3iruWHBGvC8veiUNRaCSJUKEv6HUe8pyogTOYurTMWu0cDc5wqUMb0t7ijS
         vZMcXHc5feHPVThJReYgf8PHOjrxs6dD8Y4Zxpo4EaSKMT6CD798+f8w1jBcFlkfftWh
         Z+p29lhaAJOtP5dne3Qhymn6p1w5F4Y6zaDdTKP5yEwrdvssm/j4aq7VYRDm3ZG76rfg
         MXscr9MaEkv719nW1BDLY/z/8QOdQf3GTMHIPG7oss8Rvo+t5dz1J6koz1TOJHaoHewy
         ulwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795312651; x=1795917451;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
        b=z+vI++nHsNgOm6WTE18nrWcCf3gh8x/OQV+5s7mGxxSSLkL2MiFIlAjpjRsPNlWO8M
         GSqcdwsjEMZWlbxZiKLMyCVsok8WNOvx7DfuW5xo7t0N6miCR/Lo1luxsx3ohYHdAcLp
         r0qmSZ8I46P725Qo5eztoygUd1qZayjw6bwZtbhOumW/Kg5dggVJEo1+VVGjhkPutU9d
         z+QZ7QWg/SrN+DcypBeCQaAwZZ1FH0O/6zNvPWRPk8+nii/7Y+tBni4YNhXJM81aJEpj
         CS5yPLOpY9GBucMs6mgxtvAHddExqgPa0Dq4YnDj6ZO+Cqftevww4/0zwUk4u0Hmb89V
         lQ9Q==
X-Forwarded-Encrypted: i=1; AL+hErEOcukL2nJCw0s15A+8zEUKuEtoeaBIWsKD77iXYSdow053c5JUGodIvYS8MsGfF/CSPvs8C8p9vdE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/mnOEh+pL0Dlk5Tv5Mu+ADzp4bRrMpghGZDkq0eydbwAZbiTZD
	2tqTBuqVhEbZPM9cqMFlo3wN7u0qa5DMqvzG1hv8PmuRsnpQqDZqolWSqkVw17D7WQMV09irpeA
	z/LHRDiyYkkhpo9lBMQ==
X-Received: from dldz10-n1.prod.google.com ([2002:a05:701b:418a:10b0:1b5:9ce:e6d5])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:321:b0:145:287:ce91 with SMTP id a92af1059eb24-1b5568cb6b6mr11510102c88.14.1795312650111;
 Sat, 21 Nov 2026 17:57:30 -0800 (PST)
Date: Sat, 21 Nov 2026 17:57:29 -0800
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
Message-ID: <20261122015729.2512645-1-penghuang@google.com>
Subject: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peng Huang <penghuang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When scx_switched_all() is enabled, all fair-class tasks move to
sched_ext, scheduler_tick() skips sched_balance_trigger(), and fair_rq
scheduling is bypassed. As a result, rq->cfs.avg.util_sum stops updating
and retains whatever stale load was present prior to switching to SCX.

When a CPU later goes idle, update_idle_rq_clock_pelt() still adds this
dormant rq->cfs.avg.util_sum. If stale cfs.avg.util_sum plus active RT
and DL util_sum reaches divider, update_idle_rq_clock_pelt() treats the
rq as overutilized, continuously increments rq->lost_idle_time, and
stalls rq_clock_pelt(), which in turn freezes RT and DL PELT updates.

Exclude rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() while
scx_switched_all() is active so dormant CFS load cannot stall idle
rq_clock_pelt().

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/pelt.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index f921302dc40f..6d31e1fbd094 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -138,7 +138,12 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 static inline void update_idle_rq_clock_pelt(struct rq *rq)
 {
 	u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
-	u32 util_sum = rq->cfs.avg.util_sum;
+	/*
+	 * Under scx_switched_all(), CFS PELT is dormant and may stay stale;
+	 * exclude it so idle CPUs do not trip lost_idle_time and freeze RT
+	 * PELT.
+	 */
+	u32 util_sum = scx_switched_all() ? 0 : rq->cfs.avg.util_sum;
 	util_sum += rq->avg_rt.util_sum;
 	util_sum += rq->avg_dl.util_sum;
 
-- 
2.56.1.750.gf70dc682cf-goog

