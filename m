Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978396;
	b=H0uz+OM/1F1mOQHwlZ+HiCS9gfLaUWH1okOOQcCui96s1uqmH/tVpdEsQHTF6UgKPxgG
	 AEdpBHGO4oMt1VK5INKZw34qxPD+fCexgnX/2ZQc3IotaJP4Psa7U0TgXF/qSks4nuH66
	 o2V0f24IbgmW6k10/Pl07hoKHOCy9OhIuyz7mTZA2fr51rsCQV4FkeU1aCalWRCjLgFtk
	 XO4Kc0GtVpQFa6W8n9SXQTuo6JtkcgI+PBLNVJHXVwMhCFtAYVEnIzwIAajvtAO3C4089
	 /alkkJ1ZBhmOQc6H+f2sFeLDzON9kxGmyww1PYVd4tBpZE+S3P5IeByC0Zh3lB+HQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
	b=s4HfZVlZ4baDmp0hymkLERAaTHNvCmi8ldo+Tj7//fJttkVY+TG3ld9e40+SR52ase3k
	 YLS9hC8fIkQPK12F9kmOEYNsljDwDfvxz/dCqmBxRM45AYpN26XXDNAxjBslY0SgKmFxS
	 eQDwPfhdf9RYwbilx6VG3xSODEoLYZVMuv1aY2Krvuof0YEygrPA/9BvbyWYOH+upWSqz
	 mAHfLlswAUTrSzv81UqS4WvChbx4eyR7Czwyr1apBHx/+MaFUjFLtEVVBPDm4K/A+DDau
	 mbsXmLzAYlD7LeVWaJ2Mu6/+GZRmFqYu6ATzdWgPWiOi5UvQ31n4rqyZTkZ8LT4ISRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sTB9nXxW;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61D606D80A
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A61D606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sTB9nXxW
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49318428d98so364595f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978395; x=1794583195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
        b=sTB9nXxWdOPN7QBE7hTO8v5C2lwIRWSPoba/XhI3tIJeI7hQpM6qcMfdrgj+tHigQW
         f/rpkJDyiscbqs1Xy4Ln7KYcAOyYOzrM+CRGaruKhhq86CTsXZ/1RURsPIBxLjM2lzZy
         q5gDA1ZuleuoJipMAjs2JIpeAfu34UxtfXBiPr3YH+wIw8GCPhqTwCG4Bz3QQ83wpDkP
         0D+QaYVKjSnF6Jyfw+cZco0btWi3Cw3XSL6BttJrA7PDZnttfkp4mmRFpZJVmjn6WJPU
         6cZIx1gteBqIJwK7HizhuMyVxG5LvH51L+GKygPtLVkWeP9FyVUYOPwg6RrPqU+yw9Im
         6GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978395; x=1794583195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqum8wvj/7Uuzw1gTiTBSXxhGiPLwY6qFIUmcHJ68Sg=;
        b=SD+ehnNNVBqIun5It12Nqw0HRKrp1GigZ0PeJGOvtBlLkAWiJhXslTjq0gFqp3NDDl
         0rt4fHn5o0Zf3j/uSfnZW4okemN1ZNiLrZcMesxlmjtBSTvzRJuqXOecITmRukk9yjhN
         PKzXks0AHXjpbkpMsL+UAa+XyxIEg4/2xRmPckKdzQ79icA48EeBLexi7YwakrXRxeB3
         cMY9iFp5TgxkuHLqbpypmSjumQSMJQNQAqMmWag5icL98vQ0vCQbHHNNr+1GTrn2Manh
         xUC8mBB88JSCzmSsazWrIXYXR8v14oLC8av98D33DFq4EytLMDnbi6bHB1wWe+1lVOca
         OYGA==
X-Forwarded-Encrypted: i=1; AL+hErGOvKYTeZC8Hz0phjdEiyQLVNL8UhXmkVctErp+Wf4g0piadNC08qNCiT8lpAEIy+kc29J1ayBqgm4=@lists.linux.dev
X-Gm-Message-State: APuU4Z/aa9MxV9284bVq2BTiX12mcMeEZRf5e0xcRzO8+muoJerW5L86
	MEl7+CyzbBq3LGTazngoTOoDKvk7FSbc8jk/ss8JqcEtMrXoiDm1W4iqOEHVU2xbl5E=
X-Gm-Gg: AYBFou2mC8XC2U8RVOCZiAqKSBJmFw9zwvKEnPeBfTpdT1jmlsDpEbB2jBvwQq9LPiP
	3SRGuZwxwIw6pUuM8nEyG5M+IWJz9LrIDgfK+Mj2bmscxFUlG24PUfyHDyRLmo/OsdgZhZ812NR
	auu/CbFbauT14mxTctHgiec//fts2nHq5rPn1b9BCK4Hn21lAJpY6upwtw0dqBrGIGoLZt1ms+Y
	Ncp0/zfQukdvh2/ChJkXPYNUxnUcfC9YixTBzj20IO7B8pQEj0htVJb2xRksvv05q/ap+yaAXiw
	TPYJVMWdxXr9cMqgJeHCp4O3pXivs9x1YU3gD8Lpw+p6gfuZJhx+cQ8fmwY5yFgMvj4UrUjTn1t
	/tvFcegKrwv0DuctZ2IB2YPAElWwqIzZgS2Z+AEsoZLR7XbEowfCm3danSPFbRCM/Zkn9B2Ou+u
	j0aY9Vri1quj7p9s+XI8cvDybAtJcXbYIwBU+2aqohSjT9i+UAbEKfFbg4rEC9D4vtLDkAzbNMn
	XJvfv7aslbtaqUJhGRAXBBYv5l/ZMA02j5yAT0q4E7t68ENM/nqb0fsLdZcxWyKc9x1Gdgn8lGF
	GHqCOchDDCJbJpcTQAwIhfvBgtqGTI3f
X-Received: by 2002:a05:6000:4312:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-49274bc8429mr6643038f8f.14.1793978394356;
        Fri, 06 Nov 2026 07:19:54 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:53 -0800 (PST)
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
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU has been idle
Date: Fri,  6 Nov 2026 16:19:29 +0100
Message-ID: <20261106151947.3991524-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
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

When prev CPU entered idle while a task was sleeping, we assume that the
latter received enough running time and the lag can be cleared similarly to
what happens for a negative lag.
Track CPU's idle phase and save it when a task goes to sleep. Then check if
the local CPU entered idle while the task was sleeping when enqueuing the
waking task.
This only applies if the task didn't migrate at wakeup.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 14 ++++++++++++--
 kernel/sched/sched.h  |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cb03f9acfe3..3d31e9a698c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -593,6 +593,7 @@ struct sched_entity {
 	u64				vruntime;
 	/* Approximated virtual lag: */
 	s64				vlag;
+	u32				vlag_seq;
 	/* 'Protected' deadline, to give out minimum quantums: */
 	u64				vprot;
 	u64				slice;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cd171f830d8..79f53811274e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			vlag = min(vlag, 0);
 	}
 	se->vlag = vlag;
+	se->vlag_seq = cfs_rq->idle_seq;
 
 	return avruntime - vlag != se->vruntime;
 }
@@ -945,12 +946,18 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
 	if (vlag <= 0)
 		return;
 
-	rq = rq_of(cfs_rq);
-
 	/* No fast access to prev rq task clock */
 	if (flags & ENQUEUE_MIGRATED)
 		return;
 
+	/* CPU has been idle in between so the lag has been removed */
+	if (se->vlag_seq != cfs_rq->idle_seq) {
+		se->vlag = 0;
+		return;
+	}
+
+	rq = rq_of(cfs_rq);
+
 	/* Compute sleep time */
 	delta_exec = rq_clock_task(rq) - se->exec_start;
 	if (unlikely(delta_exec <= 0))
@@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	dequeue_hierarchy(p, flags);
 
+	if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
+		cfs_rq->idle_seq++;
+
 	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d2ec527b8a2..24f9b7bd8f0f 100644
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

