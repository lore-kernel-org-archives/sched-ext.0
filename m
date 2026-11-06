Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978394;
	b=OlD32EzsU2G+fHRgkxwqMzp0oTp/DUP07/dKjhAcgrlfIwI3J6+se3xWCS81Mjp+u46j
	 eOoxJgWWL7lsLIq34sQ1nbIHqfQXWU+sufC8efFa3TuRvDqzIpollqqchmsKOA1Fmad0i
	 TLuBXtmFQiVcn/rlV3BtdjQDa7NvkHyVo95Pedq6Q0itTaN+Z5h0UsvN1xo9s34BVldp8
	 KpjWZoLdvt2RRJx11r0dGQR8lshOKEx3UEojUt1CAEuGhWXdavCU0JyBcGnRBL0fTsYlm
	 l1eDeNSJTJsLA6ilJNBmB2/eJ3RawjU602XZgMnJceqxRtYBODELC57hMQGP/usRUUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
	b=WIcYuyQaH9uS2tjo5TV9amJOfQfyE4vezlOhJpu/53uDfmKzEtpcr68pqBoGhk2wJ8M7
	 l/VILjQYRDRasYSXfVQPgaN8CooQp/qeuzOGY3JqN9PubeR1CGxt39vUqAbPDKxdzq6vm
	 RAD6zq8RHxhBJABd6IfsILQv6YNKwyQSHUJnqzzOE2MTBwWx/scX4/IiWMZ17m/mjM+rm
	 O88DundMR3evTTrRT+jq20u2dkJvXe0z44F/vRj38t0WlN5Oyn4slM99OLCudfynNCfDX
	 HEjcgxW1nTn+jqB1YKcLdVI8H97b75icCQbijSuIEWvKMaFU5FM8jS1h0D02A6Y59Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p857pSKv;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21324606A338
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21324606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p857pSKv
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so7805545e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978392; x=1794583192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
        b=p857pSKveqk1Ci/LbF+DLrMz5KieSNZmkVptEpDNsOjHM9s5HaxAinG+TaDORfg7C1
         oVOuK55HJ9m9AOfFuON3joB7SJgXgFIdKFXp/H1ZMydoAMYg9eMARS1roOyt467Fr3NK
         tQcTZdFt+F3r3A3X3E4UdG10iuYUr2iWbTjhLH1/siIKVfjuo6c1epeNmEvFGB4HMvG9
         2SusVP9SwGN7vs7w6+4F7tiVIny6P7p3b7kN5OrCWLrO5Xcom2ceRd/+4/Ar66maTRXp
         +cKGKNvBdC+EFstRco0KiheQj14iWGqXDIZypLEBPisGigzd7MBwMKN3MwRgjyiGpgtU
         oj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978392; x=1794583192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
        b=VzwRM1lx0aTW5Xg9k+Tzx9Y9oLnwYHtIx4/d5jPM87PzMFP0RI5EdbrFY4/p308vLI
         e6MgjQ+JfVefm37DBaQdVU9qf0HCowy2x/Spbyh3mMW3ecPC6RcFl3bc5ZnIjRudq57d
         W4flcst12fMj/+BfE5wEISvUZXyi5RDinE/LRjxhBOh1hkFj6In6kIamvKihAB66go+b
         3/cngU9iSgPt981WAuuLyifhSWnCIb3GWFT7+ASLTAk0n4BgGtLaWHN211S5QURDrlAA
         dUyslhjRwh0KRefJ95haawuaQQQc8xFzpYiyI11KYalsQtHxIJzUMzYghsRuapeZIwjX
         ba/w==
X-Forwarded-Encrypted: i=1; AKwUvByxi+DVyqcXKK1t6SCRM+3wEUgyQMcA6ZYvKkX0WGkYZ1kz4lW/CDScbcW/uwEWU9ieiRM4nFzb8Ws=@lists.linux.dev
X-Gm-Message-State: APuU4Z+Te9t3iGFI+UQ2KWxGW6HF+vccP5R1cL4mD3MTVOU+K1cEbAEZ
	E3ZAo+pNmdEteXtS7f70ORZlg5ZHCd7nSVpc64uc0FA7K0A/w0t79umILANXwVJopqM=
X-Gm-Gg: AYBFou1PXQE2MtREFPKyHJPNLmD5H4OEzHCQJ00j+7E4a0asAW22yeO9kbFXDUtbWZ9
	56OQAowbXDs/KNwbbQLGSsVp8DxAsX8v3ijeZaNPvc71V0UJ1F4pPcAK7ponPyvYZ+EE/saR74K
	NytY+q3+e5mHFlz3o5w3LguI3ivnnzfWvYNjCNSzNlvx2ydSRIqqUicOzDVfo5xePv8okcPbvjS
	q1Hh685KPVRqCzPK7esfTK76zhF+3nxb7PVN+Wk47uHf7g2kS98lfcuxWejwTl4f83ppmpzhYRx
	9LWQC71BWhyaNf0xfEx/q3ImaAZzSfgs4t8rHSO3C6p1ecNMS52LA8/InYDHAVlJtXMedTON6gp
	wujTiS10as/jVki8dzQdZ0YOqRRdo0JWn4FsHVHQpYcatbhd7cc7NOYJSc8i/S8lwvc3ZVcD5qj
	SQgUOM1yYiWVyullo++EGlUhw+aaqELCqz03tmRRP5JK8e8F/OSk04bzThLQQzgF+Xq7Ty+MB9P
	CKZnQdOg2wMOwIdS3CSPIoi5vHjorvCu3LtYUEwV/MMN9OyVneidhiXKUSJNBW4QpnYuFOboki1
	GVBeTcWN+/kJvggK28M6fvRPRxyyDEF8V3yFVxsyw76i5s3S6aQZCEfRbyYEK+8Fzrq5
X-Received: by 2002:a05:600c:64c5:b0:4a7:4697:dae3 with SMTP id 5b1f17b1804b1-4b6dfca2330mr52438285e9.24.1793978392407;
        Fri, 06 Nov 2026 07:19:52 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:51 -0800 (PST)
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
Subject: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping entities
Date: Fri,  6 Nov 2026 16:19:28 +0100
Message-ID: <20261106151947.3991524-2-vincent.guittot@linaro.org>
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

Similarly to delayed dequeue, which enables an entity to decay its negative
lag while sleeping, a task should not keep a positive lag forever.

The sleep duration and the weight are used to decay the positive lag at
wakeup.

Apply the decay when enqueueing on prev rq for which we hold the lock to
get rq_clock_task().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0feec172fd37..5cd171f830d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return avruntime - vlag != se->vruntime;
 }
 
+/*
+ * Signed add and clamp on underflow.
+ *
+ * Explicitly do a load-store to ensure the intermediate value never hits
+ * memory. This allows lockless observations without ever seeing the negative
+ * values.
+ */
+#define add_positive(_ptr, _val) do {                           \
+	typeof(_ptr) ptr = (_ptr);                              \
+	__signed_scalar_typeof(*ptr) val = (_val);              \
+	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
+								\
+	res = var + val;                                        \
+								\
+	if (val < 0 && res > var)                               \
+		res = 0;                                        \
+								\
+	WRITE_ONCE(*ptr, res);                                  \
+} while (0)
+
+/*
+ * Remove and clamp on negative, from a local variable.
+ *
+ * A variant of sub_positive(), which does not use explicit load-store
+ * and is thus optimized for local variable updates.
+ */
+#define lsub_positive(_ptr, _val) do {				\
+	typeof(_ptr) ptr = (_ptr);				\
+	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
+} while (0)
+
+static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
+static unsigned long task_h_load(struct task_struct *p);
+
+static __always_inline
+void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
+{
+	struct sched_entity *se = &p->se;
+	s64 delta_exec, vlag = se->vlag;
+	unsigned long cfs_load;
+	struct rq *rq;
+
+	WARN_ON_ONCE(se->on_rq);
+
+	/* Negative lag is managed by delayed dequeue path */
+	if (vlag <= 0)
+		return;
+
+	rq = rq_of(cfs_rq);
+
+	/* No fast access to prev rq task clock */
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
+	/*
+	 * Use cfs' load and p's weight to estimate what would have been the
+	 * share for p. task's load contribution to cfs' load is replaced by
+	 * its weight.
+	 */
+	cfs_load = cfs_rq_load_avg(cfs_rq);
+	lsub_positive(&cfs_load, task_h_load(p));
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
@@ -4693,38 +4778,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->nr_queued--;
 }
 
-/*
- * Signed add and clamp on underflow.
- *
- * Explicitly do a load-store to ensure the intermediate value never hits
- * memory. This allows lockless observations without ever seeing the negative
- * values.
- */
-#define add_positive(_ptr, _val) do {                           \
-	typeof(_ptr) ptr = (_ptr);                              \
-	__signed_scalar_typeof(*ptr) val = (_val);              \
-	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
-								\
-	res = var + val;                                        \
-								\
-	if (val < 0 && res > var)                               \
-		res = 0;                                        \
-								\
-	WRITE_ONCE(*ptr, res);                                  \
-} while (0)
-
-/*
- * Remove and clamp on negative, from a local variable.
- *
- * A variant of sub_positive(), which does not use explicit load-store
- * and is thus optimized for local variable updates.
- */
-#define lsub_positive(_ptr, _val) do {				\
-	typeof(_ptr) ptr = (_ptr);				\
-	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
-} while (0)
-
-
 /*
  * Because of rounding, se->util_sum might ends up being +1 more than
  * cfs->util_sum. Although this is not a problem by itself, detaching
@@ -8152,7 +8205,7 @@ static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int task_wake = flags & ENQUEUE_WAKEUP;
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight;
@@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_wake)
+		decay_entity_lag(cfs_rq, p, flags);
+
 	curr = (cfs_rq->curr == se);
 	/*
 	 * This can actually happen with CFS_BANDWIDTH, a task can be throttled
@@ -8225,7 +8281,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (!task_new)
+	if (task_wake)
 		check_update_overutilized_status(rq);
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.53.0

