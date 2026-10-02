Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8B2EF653
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955910; cv=none; b=C7+n36I6zQXUC9TiRSOFEfLkk2ZUP/7EML36yejIh9RrfBRfaHZRUeMVm8dQR4bhzNhEAdp/K2SbmqJdg2Ywa5iTk5YPJP+nkmTSpM2KcADrPq4Egh7+SRWsbL6cjmvMK37NXQ3XWNrWLXMRvdCLreheKmvWE8cXYSb1bDjosYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955910; c=relaxed/simple;
	bh=Jf5E32GF85o6HQAbOOcsttI4ZjzXaQd9Z4H5WyGTqyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzKMxGftGuXSG5uiwEJTKnRTXmFmu8aL0nsMne6jD+TWP7Mc1xum3uz8Xa3OIZLe6Ko3EpKjredmp0hMD0b3DVBKUBKtLKITQCEfyaTlJpz0QDoleivZMQhNdBCj72/Hme4QkMOOTYlwnxtI2bMSteeFFvLNc+A/f0z+m91Q5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyQRH2To; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyQRH2To"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0977b9c20so298385e9.2
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955906; x=1791560706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2kuJVAAelDyNc/5dJ9IAgD/T6ohQyK6/p84njFW19Y=;
        b=cyQRH2To2ImBrJ8Xth8nHl0qRQvt7bJd9Ae2Mo7au/MAn+HD9EzKlgqth6HWuU5gnW
         GFs2AjcpNGLlzmW9Qh9JnUxIh0X7rrUIOsmZuFTqkb1K2E+QSaQciqq160tOV3jWAVQw
         I2UteiPaNiQ6znGX/+FNXUyUhUYKqqxEcgcDGYJxNnrDmGxd9GNFJQRmIeyWtFwFS6PC
         rDOrRG+ZoZYgY+fHgqoTFE5ScNVfYQ61q4arrVw7IRcLxckVA5xfh96NTjCxgq/KMpL6
         6Cylqs2eHaZV3jhgfOno3+nu9QtJUC+8VhrC9LZ7xRUPYMwMWavMgtmzOY0+yj/yvZND
         +Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955906; x=1791560706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2kuJVAAelDyNc/5dJ9IAgD/T6ohQyK6/p84njFW19Y=;
        b=x1iFkM2XQ+C74KeTLQSr42+KbYocYlW1XzEku6P+yh4F7YZYb+pWUl3KOksVXsU4H1
         m0MCXvQ+Nb7tQfmrxLpRWk5gshKFAgNX8VC9iBejQVicwoZum6i/88kwSOqX0+KosnB8
         ZPwIHth5u6F0r//5VL+q+/yT4T2mUlDwNwJvpR9a1SNGUOdv+2a09pfSxmrH/gnhgz2S
         9dOmBLROsFgLHUKgbFuI8+V3vHGxfzZL7D7tcBkwtS16RiW3QUH3y6XxxURYDQv7i3zX
         U2NYe9xM+MzQRRaX5HSDfh3onpJkgI/83EWB0+GuLPo4GEScKG2SYnPXcUzDmIIPZx6D
         Zk7g==
X-Forwarded-Encrypted: i=1; AKwUvBy1QyjgxwZR0cm2Ic2FyhTfnOKrsquMkYWQV6E/xWuzrp9M9TIzrPg2QY6vmMBSMqIfYaVw92n8uVo=@lists.linux.dev
X-Gm-Message-State: AFuF++lIlVKvSRxwf63mkc1TAJfpbMbqMMnUYebtx4rJrTh2sT9cL2Vx
	HvCeFgWpta70Xxua2hNoPG+ZdoMODWBwiopy385UPYc34ijrSeHPxcezecEdetajzLk=
X-Gm-Gg: AYBFou3ok4tKYT/KyjH7Qf/8KkKwsKmJJga0jMlIDL8fMvXvWRbHzgrDqfSvNh49le5
	8hrCNBJ4cNeWFh31+UJeLG6JupAY51ek7+Z2kqWkG6L78QUhg0sZL5Fsq1vqad8qfkc74v4YkZ7
	cQzFcrw71F1qGZRiDLrYPayWmymjS9ajPlWnDZDtLNVLLNTjhf08sKNz15b4lyS+MlW/gidKh67
	be8LtvwDjKZDVmZgXAM7DKBdLEW8vnRWhFmCCx81GhCu/f1V7/fx7Ga8jkxBw53e7c90fAeulRp
	Wfqumcb/OSbqXJxyUW1ml4k5OisMTQFo9WbJA1RVHQZAIxrVhukidNyIZF29j25YbSeAoOhWLCl
	OGB6fWMmSyaQpTLzHJgL6gW+nvyeezgmbWqWUkCyMMjH+fnO+JzkVVYAizGsCehSwmcxWMKAbOP
	u5MCW1vlc8LfOn9BMJGmzUBdrVtT4H9WhLZJO+ojHiV8gibHwJzg2tUwkMtMn+BUSAipsR5LXhT
	+lqpXXrRuNRK7JI
X-Received: by 2002:a05:600c:a010:b0:4a0:251f:a726 with SMTP id 5b1f17b1804b1-4a02759badbmr51939065e9.24.1790955906410;
        Fri, 02 Oct 2026 08:45:06 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:05 -0700 (PDT)
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
Subject: [PATCH 03/18 v2] sched/eevdf: Add per cpu cached min_slice
Date: Fri,  2 Oct 2026 17:44:00 +0200
Message-ID: <20261002154415.2270586-4-vincent.guittot@linaro.org>
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

In order to use min_slice during cpu selection, update a cached value when
needed after en/dequeing a new task. This cached value includes current
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee9b443f760d..f38cf5a37a8a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8902,6 +8902,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->min_slice = ULONG_MAX;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c8f12fc8869..ad72b8536d6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1116,6 +1116,22 @@ static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 		     run_node, min_vruntime, min_vruntime_update);
 
+/*
+ * Entity's slice is in the range [100us:100ms].
+ */
+static unsigned long get_rq_min_slice(struct rq *rq)
+{
+	return READ_ONCE(rq->min_slice);
+}
+
+static void __update_rq_min_slice(struct rq *rq)
+{
+	unsigned long min = cfs_rq_min_slice(&rq->cfs);
+
+	if (min != get_rq_min_slice(rq))
+		WRITE_ONCE(rq->min_slice, min);
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
@@ -8089,6 +8105,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);
 	__enqueue_entity(cfs_rq, se);
 
+	__update_rq_min_slice(rq);
+
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
@@ -8214,6 +8232,8 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 
+	__update_rq_min_slice(rq);
+
 	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 69a2a749e188..e025d2a6c302 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1173,6 +1173,7 @@ struct rq {
 #endif
 	unsigned int		ttwu_pending;
 	unsigned long		cpu_capacity;
+	unsigned long		min_slice;
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */
 	struct task_struct __rcu	*curr;   /* Execution context */
-- 
2.53.0

