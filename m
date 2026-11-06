Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978401;
	b=1gK4Qq0/QkNY3XEeAFuRiE28cecUFA6YrYZy91XxVq2/0gDdVlihvdaBIGrcdESwZiZw
	 u86qVerWdvuoSP8sYdTpus3rk6LAZfzwruiQhJ0BLzWhWE0wHdJ4rUnZ3Onl/82JgJBp2
	 Kjm5E40c5x5WWvKXKnfQucxjyIIypLf1ELEwf9P2/bnGvPqbCdhMaJtrQ/f18KgcUHVqb
	 NCMIE1u6DPAgavtZ7NiOqUo5DX8Uk/c7Z9JLr7IHJ+hSpAROqd3adXD8MXLLWOPGtw/qI
	 y3gu0dwYuPtNnKTiZ2Rb0smW7BsxUSZsptWHfHobfSTLhdMsyaI4k+fdb/hk+GT+1DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
	b=1F3feN8hMYw4b5jjnUUdVAmsu60/eAF0LD2fZ3luV1KFH+khWzAAGKEzeC2mOdzttR9w
	 iIc9P1zY1U2UXWoE1ZKNHNlHk2FHkia2/HYiroToeIb26tpnxno8Lohnkt4czxRvyPLCO
	 ZCxI/F3vIzpaEIOiE1sJzX6hZ5Wp4XQsMFDkXTN/v/Yz6msRkHk/uoVvkEd5+qs9MAmM9
	 6zSVZwrJW0SMvULIeQ7rQVRZ9zadi1fmm5fD8GW4+L5A5WxTRa0JT7rOl9pIWhrhpS6jD
	 rNVUTHd5JKaU6o2/secy5kViZiOxDHmyHFXIuQVE4WbAd97hrAMCke85J4nsD8ymLzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lMpzYuQ1;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D38606A33E
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D38606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lMpzYuQ1
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so830329f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978399; x=1794583199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
        b=lMpzYuQ1SEi8o95/iccD6Yp4j3xpR0QI/wSYGdshZBX65DDhwHUE5CcIyDg/YNCYe5
         SfCHKEofdQDxzLjS31Im2MeGDQbGc6VQcsaGWYavJG+pzqadpWSRgOr31JrsA7tUkfxb
         Au5M75/t7ATy1gY8EOexVsX2Dq1DVRIQNyeq+7yO3lAeVTlUdhzDMmfJEk4ECGCzuI7e
         1GrQkbaDE1SdiA1AkAAkJmi3YGZqMBtBDsOiEQVP/aplfJDnATSrpWxErW8vMaZrR2XO
         FRBWZBgRi9+SGrP4MDilMk3bYMqwpdwjVX8PeGnH/DNNCO/iHqSvaLH5F9yjbAtD1GOi
         NOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978399; x=1794583199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UwfbJWPzhnrx0wIoFojbwEGGK1EaNf0y0KOrOChCXjU=;
        b=Y13xYr14CngFPqXyql0Q9QbXiXs93GMamNETl4gUU2zpK0qKbKKDNW8zbpQv/hvEnb
         IuhEvnxh5jYwcoDnfl7hTMA8DcGdOFXOF2eLyInQpdXhdh2jqjhrB4SVQih2I5eAyaga
         yVWNS2yeRMqreAtV/5pedDK27qJiSRyi0CXI07/+os/yJROgEjJqjeWG85TEacFgLKFY
         flO5LZ6dZBRXqCIMv23ZJJFuUjvkTqVNJHbSgNbYgO40wEFmDfdgNUCbO9z/T6gXEp5Q
         UulApHl1z3+xpyQXG0cAHEejucLaJ86E6b2XEMuS8a1pVDXqlbPVdoQKEeSuU2l41ZQl
         Emrw==
X-Forwarded-Encrypted: i=1; AL+hErEqvGzTLejcxcPQE8/xXe+Vb35wPFSeKkEU7NGS9lUFmLEkrf9xNvmdzWZ08zTN8stQvkyUtaeOwO0=@lists.linux.dev
X-Gm-Message-State: APuU4Z/RlXRsqnRMdM+L71YRsg2g7eFWdK62JAxtem48H+x4oFcLEzHY
	9kO0Wolpam4mI6r4EDiUlp7/5Jd2sZY1CNyMwgByf89eeL0NqglKqnMrWAoGU6H3g8E=
X-Gm-Gg: AYBFou1L0KmhGU0YSYAYv1CQAHE5opfHZPUqTL6jo2vBXeZ0x/xNrN95+yJqc5txTnh
	ODL3WALR4h06PPhnYP5N/6qsAomcQjhcKzuGjGl9Zgr4m5VHUCHXIRwCxyRFSukz3wHtYXx2ky8
	fFsadYGsMRx9SVPO0AfQDOgTgUhq+/2C6n9BvEUArqieQR8XAgx7489LIpuEG1+Nbh6VUukDC/9
	J3Ub7E+pWjagjj6Ub072MIB1x/KS0i8V3WriaFh/t3/wP/jvNphbX4r2UdyySSoTEhy0jOxJ4sI
	yfEZSSIqh0PS4vNdwWWjtjNmfGeEIGYORisRt0XDsSaX2uBJ/CJJDqI3VeSjO4K4w9VohUwlLti
	jsYe6Ck9xnfjaOJg9wQEUDjqBqQOIZxTeu9UvYKdL4EkOw/zCoUEcnGvfKvmGHOnNvhDclH6aXs
	nID4tK0WqDUU9wf4nErF6Xoo0u5rLNiq48iKKwrcAoto2EAIuc1JDBDP/heGnn6IyHLcPsiLS7N
	VIsWG5c+Gx0MLDKyhnzsfOhATw/onhFT4TbembY0OOG+609E0jEH7DbJ42J2dXph9wBxTxrbwuV
	PQ6l7QtdpbEnooS30bYJ/js3PiWA2KCuwaVpF2yRbnDehyA=
X-Received: by 2002:a5d:5f04:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49278174603mr5569876f8f.52.1793978399093;
        Fri, 06 Nov 2026 07:19:59 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:57 -0800 (PST)
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
Subject: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
Date: Fri,  6 Nov 2026 16:19:32 +0100
Message-ID: <20261106151947.3991524-6-vincent.guittot@linaro.org>
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

In order to use min_slice during CPU selection, update a cached value when
needed after en/dequeing a new task. This cached value includes current
task.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7c3b43158de..031efe7d49fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9012,6 +9012,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->min_slice = ULONG_MAX;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ce4162a7703..cfc99b94d9ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1130,6 +1130,30 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb,
 		     RB_AUG(slice, min_slice, min),
 		     RB_AUG(slice, max_slice, max));
 
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
+	/*
+	 * When there is no task enqueued, we check idleness instead of slice.
+	 * Reset min_slice so the rq will be selected because its idlenes and
+	 * not because of slice comparison.
+	 */
+	if (min == ULONG_MAX)
+		min = 0;
+
+	if (min != get_rq_min_slice(rq))
+		WRITE_ONCE(rq->min_slice, min);
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
@@ -8295,6 +8319,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		__enqueue_entity(cfs_rq, se);
 	}
 
+	__update_rq_min_slice(rq);
+
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
@@ -8420,6 +8446,8 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 
+	__update_rq_min_slice(rq);
+
 	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24f9b7bd8f0f..7a95df4f14d2 100644
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

