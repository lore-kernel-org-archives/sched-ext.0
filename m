Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532714BE44A
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955908; cv=none; b=LgknipbE1tVWgVTc9PwA6j6jPwb+SFGODS+m+dJJePRDdVDoyg2yWpBbFzmgNG3fG02mQhM/f19WNU+o8H8cAmIQzoXFOPgAvgTlne+JOpEquFAzPOooDsxZ18itJKBuCANDN51yqhudn8v03eW0/r/9ZExIn8RVUXMBBJGAh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955908; c=relaxed/simple;
	bh=mqcr69n+Cki+W9shlrgvILn8znvb3ow0aMd43jWczjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAA2o0aWbLSVYPUXzUnCi6BdjQJH5NAHQx10U3EiJIbiL8PLXXlcYvjettOGjTLBbxbUWI6TPqqfTahEdDjgcRbalEoF4N0LGkG3BsoDXHn1t77lumvlmjbYVB1CXs9sXr+EtUgQIjjntDFqDo6SzSf4y9Mqq0d2rUZy5IvjE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qaHiw++t; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaHiw++t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so426945e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955904; x=1791560704; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8shURt70eLGsxqpmwK6tNDdH4TKn99x5ZtIeJ/6eoc=;
        b=qaHiw++trGLNQ/KgMeO0Zfo+CcgklZfivGZ4pAMMkXSexMQ3BOcQlOAAIbR9g2NO3K
         p8v0W3wywzFH+WEckYSb2LoGniCaBS29alkSWlmLrS6FQQknVdVRKXe5i8TxXWgmsZax
         1iNMOPNiAFYJlGwvTnhnK5EatCXB0Bn9jrakoOhfd34YCxNn0WiXHZ+zXBMY2REz9tEw
         5P4bxSf4zmwT2qVfpzepWiSGMrwElmoZGEWT/Rm5TB88AvaLwqZx+T6iMB8QxjdGqYVv
         u4TDDVYOYNnTp8W+Bb732FBVOKJ2zdqgPennh25gAGDRjZ4uQCXuG8P9/P5d4u2CpFlr
         GV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955904; x=1791560704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8shURt70eLGsxqpmwK6tNDdH4TKn99x5ZtIeJ/6eoc=;
        b=PQ1MBtq06joH+UVUL17Qv5szQq0S9/xCXPMt+rCMmmqYYdjU5hcY0XasYtlbKTB9Od
         puLz/MQXOG93RMB4l/8edx1Vx458ODvxMcmcWp0oG4o+92ROQTnP6pTHhDBaf+mdraMC
         jtENQbrJ4BVHPcg4wS+4GxknkAjC6MD5APFhyoBbDOKzwAHAI+2db2JDAhZIXuLU2Hz4
         uVN9nAXOjJ8IFfiDccuq0opkvj8QNyfVSLKEfB/9+sXRWHhL0NptADTQaHCW1HUSRccF
         ER+egiNQfHgD9rsoWAf+3MFb23lAwFi3H84crkNp0HCTr0VJ0guDn3M1rB9uaGQ2+QeL
         /zAg==
X-Forwarded-Encrypted: i=1; AKwUvBxRPZ3hN8g9n9vuMPmtRiGCoG5R0aLlIV3UvhewbH2N982C/dDmA5yzvjYB9f6UaUUPY7SbmGBY/Ys=@lists.linux.dev
X-Gm-Message-State: AFuF++kYnZ2FSgkbWARd0CY4F/I3t8wRTLJhZojK/olvS4yNCkseOSJn
	bVEIXy3wvtnPstIsQ3FdBmNXP2Lr5Dk6zfMtJj+YBe/bSMkSUvr3QKdjo/49UfmQQPs=
X-Gm-Gg: AYBFou0Af7ExbgdVwI9wwySNTdV3Y01O2WGVKWGMwQYTWP2Whmqk7P/3fGwfqzucvc+
	f9PbzjwYupBqDCPV85IQ2kuVBrqI4DXz7PmNDRGVCpg2TxJuczlmIEdDgccqt8bScutKRvz/lp7
	BqQJLmS/UbXGHxY4Y7o6pLY/GZE5dPyWdQLKd/tGn2QZncSU3OtKkV0pcD/A9BPpl4498khFgP7
	Vwh0Kx2J3ysoHrkhZrGMskVeB3Pu4NwZARm2uqWw67IRQD58tIDb9iO2mPdXTQn5r9yIZfrTg/u
	oodOFn6vzAbyKj6gjgS0TpwEbxQL5YQcEKj5Ee1QNQp20+UTP8WUQv0T0JBReIDvvRAqBwAvx08
	NLBuipBh+nkoQAVITUTBHs2m85Q+dxc7NP5zh9xQ3SJqAeV1j0YFZlEywkGtHndFdXy/Jt6TIWs
	pkeuFRnSRKVGpgxqbm97aTQ+sHhUruq+NmmjJvrEqMxsDenVy4VQW8LYk2NkaXwIdQxJatgcTr7
	XYdU2Q92OsPAWzi
X-Received: by 2002:a05:600c:6092:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a027452eb0mr57787735e9.0.1790955904125;
        Fri, 02 Oct 2026 08:45:04 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:03 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 01/18 v2] sched/eevdf: Decay positive lag of sleeping entities
Date: Fri,  2 Oct 2026 17:43:58 +0200
Message-ID: <20261002154415.2270586-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to delayed dequeue that enables an entity to decay its negative
lag while sleeping, a task should not keep a positive lag forever.

The sleep duration and the weight of the entity is used to decay the
positive lag at wakeup.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 51 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03206e15e6fe..8cda1d39b037 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -897,6 +897,51 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return avruntime - vlag != se->vruntime;
 }
 
+static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
+
+static __always_inline
+void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	s64 delta_exec, vlag = se->vlag;
+	unsigned long cfs_load;
+	struct rq *rq;
+
+	WARN_ON_ONCE(se->on_rq);
+
+	/* Negative lag implies delayed dequeue */
+	if (vlag <= 0)
+		return;
+
+	rq = rq_of(cfs_rq);
+
+	if (flags & ENQUEUE_MIGRATED)
+		return;
+
+	/* Compute sleep time */
+	delta_exec = rq_clock_task(rq) - se->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	/* For anything above ~4 seconds, save computation and clear the lag */
+	if (unlikely(delta_exec >> 32)) {
+		se->vlag = 0;
+		return;
+	}
+
+	cfs_load = cfs_rq_load_avg(cfs_rq);
+	if (cfs_load) {
+		unsigned long weight = scale_load_down(se->h_load.weight);
+
+		delta_exec *= weight;
+		delta_exec = div64_long(delta_exec, cfs_load + weight);
+	}
+
+	vlag -= calc_delta_fair(delta_exec, se);
+
+	/* vlag can't become neg while sleeping */
+	se->vlag = max(0, vlag);
+}
+
 /*
  * Entity is eligible once it received less service than it ought to have,
  * eg. lag >= 0.
@@ -7987,7 +8032,7 @@ static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int task_wake = flags & ENQUEUE_WAKEUP;
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight;
@@ -8019,6 +8064,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_wake)
+		decay_entity_lag(cfs_rq, se, flags);
 
 	if (se->on_rq && se->sched_delayed)
 		requeue_delayed_entity(cfs_rq, se);
@@ -8048,7 +8095,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (!task_new)
+	if (task_wake)
 		check_update_overutilized_status(rq);
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.53.0

