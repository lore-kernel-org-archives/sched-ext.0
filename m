Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0B4E1C7E
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955910; cv=none; b=QQKvtfv1t3gujv6zXIvkjw+mFmHEeTNpOqbLDf+mUPM3f97FOI0mBuamTnTZCF4Z8K0O1Fv/kD+bK+I4GHCs5nL1e7TzpkHu0t44YweTm2ReoT1wKr8BZw3cPnqk4CiULrK/qhCq+zylrrZ7GqrhYKA42IXw+itduiidekO8abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955910; c=relaxed/simple;
	bh=CTaQke7SU+dNOxVuINpaFMcJR69qg82aQwGX0Pu+f+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIJWq5B44C3jr9WUpcL8pSzukS2v0UHaSb/nDDSvo+9CFh0IfvcRACs4CYNCZuYufDQmG8lrA/UlTpe51dcvjyoAlfmwkW3SI3YkQ7IIwJkfAFzFz2gu5nv6/APaAynpleUoQXyD83MDGtqW2Eg3S4sIbfFru7z4z/qo4WpYe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HrQRYRQO; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrQRYRQO"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so180685e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955905; x=1791560705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCbQwEE09RLLlmPAHT5m8hX24lXl899bphgbqp3z/Hk=;
        b=HrQRYRQOc1uoeeViIs9FU+PPpinHSAWV/rTftp4zKrPCpDkXmUsOt8iHZcskpR/W/4
         CV/mgA0rd8D4OETfrULL1sLwD4uNeHqCkcIs855Dp7Qkhm5N6YlboDv6jDQKmUu0/IQu
         OY657O6PDQkG+LK8HKo6iD8KFK4xbdEw91Lm8sIPMBc/GcDbx/TPDEJSnLfA/KUI43Zg
         DrQ94vrwFJYce7yGYvwvNFIyfxmGTWvr8LswYWuCeKV3OFMosW6l0JU2u/29aWQnm4xo
         JB6kGY33KaD/WeNwwCTVyx97oFEffnTcIh9X9QFFbZgt2KXh5g2W7H1j+wvYkGMGCK4Y
         97IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955905; x=1791560705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCbQwEE09RLLlmPAHT5m8hX24lXl899bphgbqp3z/Hk=;
        b=dQn0H68noLJvHFUHQdM4pWuMpYtv2gRa+kwd8FLjvr0f1bD6eBC/9SjBpzrnwXvrXQ
         51RlyCgiuUrJ0CMIBYz4vEYU0XfgT21bxXXy5YrvSkhb0BX4f46mFkWNC0SEuw5U846g
         yKuYaOM5xMOynUiDQQ+rNWgGZO5T2Mc27aHIU53qLqq6lmnwe2/eXYhyAOB9pHzmfYyo
         TR1EgU1h34Jw3BwXTRjWTSUs31l2vx66u1qL/yyY5Rr/FgOSDq7U/87XX81R1TyKBsro
         6yqG4nlS4YlPIeVRx+nJqAi9otcr+6dwp5HkwsGj2r0UbA6jtChuoK4opMGX2M0sK3Oj
         WttA==
X-Forwarded-Encrypted: i=1; AKwUvBwvPs6xLsz8Vf2L8OJlecvIvRPXlNIQP9MMhLUMyoQft+OYpeYGbk2lvarIBjcISqJP3uOMQf+qSx8=@lists.linux.dev
X-Gm-Message-State: AFuF++nIyRRQ6/cMw9R2fsL/vlNZ7jB5BTra2liiNFOTCY8vSlUDATqM
	qdKAna0cwSzl3lEXyiSm58WaPCyQeR5ZVEnIgH9MPDy/gG4RHm94w9UQStUeZz7gqU0=
X-Gm-Gg: AYBFou1uGToRPZQbi5JeYrnN3SdoNTR1EVpBUeVVMZHs9QYuf/1766Z+8josqy8IuF3
	YaNTIE7VBrH3GBG59sCQj5IQyLQujjgvx32KL0t5QtjiGQIy7tPgBynCDB3DYI70P4CekEEhxQd
	2ea0cMd0dr5nEJdFlKC45JJjJXWUb+/mxA+bbXVq/G3Bm/SLHzgglMg/uxV7STWfWus6ZcENIJ4
	ZL7NUxKrOJyVV6oQhHbsjsJCr+GQ3JoPYv5BqxHvlMHjoiMr89nfMgel4Y62LtdWqf800uCb+3s
	rrVnCqOxsst94PsDpL5pt5bZishwvLFExVxGu6xws2hYlUwgtkWMAuXP/nAU89tvRCX7R7ZL7uZ
	LwU7uDalPsJedCwPsSLOlYOhSzsDYoIPyUz6L6jii0jGSM/OUpZUq5yJ8S1KBrmzRT71npDOzDL
	de0RxFz/m4ajcXOh2TINHwZbDr6NLZQjQ2I6AV1zk7n8cd3RBhaP2pbOscRSp+nRabeVe7F0tCp
	VaYRykvOXhDJaMm
X-Received: by 2002:a05:600c:3b01:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a027573634mr47267725e9.25.1790955905339;
        Fri, 02 Oct 2026 08:45:05 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:04 -0700 (PDT)
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
Subject: [PATCH 02/18] sched/eevdf: Reset lag when waking up on idle cpu
Date: Fri,  2 Oct 2026 17:43:59 +0200
Message-ID: <20261002154415.2270586-3-vincent.guittot@linaro.org>
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

When several tasks wake up simultaneously on an idle CPU, their final vlag
will depend of the ordering as the first one will lose its lag but not
the next ones.
Reset the lag when the enqueue happens while no fair task has already been
picked et set as the running task.

As a typical example:
CPU0 is idle
TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
Depending which grab the lock 1st the behavior will be different:
If TA is enqueued 1st, TB will be enqueued with a positive lag and will
be picked 1st.
But if TB is enqueued 1st, it will loose its positive vlag and both TA and
TB will have 0 vlag when fair will pick a task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 17 +++++++++++++++++
 kernel/sched/sched.h  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d7cc77181ef9..32d7077ef148 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -592,6 +592,7 @@ struct sched_entity {
 	u64				vruntime;
 	/* Approximated virtual lag: */
 	s64				vlag;
+	u32				vlag_seq;
 	/* 'Protected' deadline, to give out minimum quantums: */
 	u64				vprot;
 	u64				slice;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8cda1d39b037..4c8f12fc8869 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			vlag = min(vlag, 0);
 	}
 	se->vlag = vlag;
+	se->vlag_seq = cfs_rq->idle_seq;
 
 	return avruntime - vlag != se->vruntime;
 }
@@ -914,9 +915,22 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	rq = rq_of(cfs_rq);
 
+	/* You can't claim any lag when waking on idle CPU */
+	if (rq->curr == rq->idle) {
+		se->vlag = 0;
+		return;
+	}
+
+	/* Accessing remote rq task clock is a cost */
 	if (flags & ENQUEUE_MIGRATED)
 		return;
 
+	/* CPU has been idle in between so the lag has been removed */
+	if (se->vlag_seq != cfs_rq->idle_seq) {
+		se->vlag = 0;
+		return;
+	}
+
 	/* Compute sleep time */
 	delta_exec = rq_clock_task(rq) - se->exec_start;
 	if (unlikely(delta_exec <= 0))
@@ -8190,6 +8204,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	dequeue_hierarchy(p, flags);
 
+	if (!cfs_rq->h_nr_queued)
+		cfs_rq->idle_seq++;
+
 	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b98084e1f5b0..69a2a749e188 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,6 +689,7 @@ struct cfs_rq {
 	u64			sum_weight;
 	u64			zero_vruntime;
 	unsigned int		sum_shift;
+	u32			idle_seq;
 
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
-- 
2.53.0

