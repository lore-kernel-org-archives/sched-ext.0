Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606122;
	b=MX5qxHXabMauS3l9LzP2/oL2jMr0s1oU6wR1VamP94eS+mDf54x9EoeAEPmdUe90P5tL
	 wCqfj5uunopo6iqhsT0YGWpBCnrCpuKXuumt0sEycGfzpDpvjdsU3eCHd4PQNKPfdh5Th
	 1I5/46lXcXedquG3NBaLSdgM4luz7yqKvCWrqwj6ODxyUTsd9EHcdg57V/iFjwBbv6tBi
	 ilxnDhZSOmdkRHjqXav0h++aI0JAWrECmLd3JUMS1nwqgif5S2EMXRLEMB4tNlXYt07Do
	 KMD4SrMXpmQYAg6Sdz03fdlOkmuxZsnycz8MqJPk7MH29qnlfgi9DiQ78KiGbTWNsIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hjrWtGqjdTkvqbgRLAZG9FmN7gaLopZWwSHoe/hNnVk=;
	b=h3tmHLRJ1Ny3jsHZwDQkh5TydzMf9a9tEVjJqX5OpZFGEuFr0T73vLknNNrpuMhk2UBe
	 SpGyvnip8qUvtpQaLccsHSbtrdewLGKZGEbUtuvwndZcoNY0M1CS4tSn7iekkdsRXmV29
	 IFOYZlOejMAT9SvdSkW1lV3fS7j/TSlH1lm1Mu8VKu05Q4gXyzbuNhtsP6qlvBxNS8svd
	 WaA4ApUUnsW3XgttkPyyV5W8amjEyxsgWw/T3AJigam7yt3kSjH6bK4SSOaN36s4CW7jT
	 wtSr2nOmXl80TnzpAa0R4aK8Oov5QprYG1wPAjzbBZDuiSjuqhy3GJzgIUdpOfj7btw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QFxFRZRU;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EF606A32D
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898EF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QFxFRZRU
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so48420985e9.2
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606121; x=1796210921; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjrWtGqjdTkvqbgRLAZG9FmN7gaLopZWwSHoe/hNnVk=;
        b=QFxFRZRUcUOGyZkNchZQKV7kc8b54FdzFiltpJ5A1M0zc3VgslCd2FuOfdmuyx0E7t
         Js4gyBE7L7Zx/+dc+Qo339hEkItwsUnwiJF5bmDNBhmXVqWFNfEFX8fGajmLsxrkkveP
         jOYAKtANWDlyPhsiPX/IDd4N/Y6dSYlyspRrHELDPg1LpqamyUU2lvLXnSmIZtvMMqnc
         CabbivciTBHCfuiI20xTS04peI5WfeCK1jxYRU7I3goFnLW6UWT4ykgnT02sSZYQGTIz
         VN9w+a3bh2SdTG9QrVwR6Bk97Gw/5fWcCL4VWkYdNWH4fKwmElGq8rSbE8SVef4Bu21/
         tClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606121; x=1796210921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjrWtGqjdTkvqbgRLAZG9FmN7gaLopZWwSHoe/hNnVk=;
        b=O2QNHKEWaFyzRb6+2U3+XYqATd+G+fxL338Y5c62P1Z5i9WpaRBAJUd0g9126HoQ7I
         SedKS0ODZ+nw1DmE3a9GD2nBMRud7ZGpQ1PgtaxOsjAcJRvzdQpj7hBx2+sSs6Xipiyz
         +ob9ugR/+WwsHtJc7nSt2pW1Fx8xxCwfghik112n9w+08LW6TOkUOpn6H0nqL6Rdma4U
         UtApov2EuMVB8a/Y5/549lPjWlMupNEpKe2Fj2x8Q4WjkGkM/0OpnR5C1XoN1Ka6ydnr
         DYJ463D8OOZ+Pr3Nay+VApskjll1dwzu/h04lo5qEKBOIPGPONFYFKLn9MWcKibDSFR6
         UxYw==
X-Forwarded-Encrypted: i=1; AL+hErENKARSHMQhbF2mVyDURZF/n7H4R1EHzPo990C4j5VzU+L+AUpVLjCIEDjV1xLmcDj8Q8gzoOfxiEU=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Q2qnw1/W71CKqMrbtQGhibgycmmut/cED2Dv4+a1m74hRcinw
	G7SbC3eETRGKtOoAO2JzehV+bfi1wuXS7YjbGT2kk7qQOspleVOTYW/YHM8RWq00BT/mxl4miAF
	GaEuqGOVjmvAojg==
X-Received: from wrxf1.prod.google.com ([2002:a05:6000:1281:b0:4a5:46fd:392d])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb8882948dmr358570145e9.18.1795606120690;
 Wed, 25 Nov 2026 03:28:40 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:35 +0000
In-Reply-To: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125112553.1539758-2-jpiecuch@google.com>
Subject: [PATCH v2 1/4] sched_ext: Factor out release_dispatching_and_lock_task_rq()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor the holding_cpu + SCX_OPSS_NONE + switch_rq_lock() handoff out of
dispatch_to_local_dsq() into release_dispatching_and_lock_task_rq() so
that other remote dispatch paths can share it.

No functional change.

Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 73 ++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index efa1d01d03af..d6505d90e2c6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3166,6 +3166,48 @@ bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 	return scx_consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq, 0);
 }
 
+/**
+ * release_dispatching_and_lock_task_rq - Release DISPATCHING and lock task_rq
+ * @p: task being dispatched, owned by the caller (e.g. through
+ *     %SCX_OPSS_DISPATCHING)
+ * @locked_rq: currently locked rq
+ * @src_rq: @p's rq, stable while the caller owns @p
+ *
+ * @p is on a possibly remote @src_rq which we need to lock. If dequeue is in
+ * progress, it'd be locking @src_rq and waiting on DISPATCHING, so we can't
+ * grab @src_rq lock while holding DISPATCHING.
+ *
+ * As @p is wholly ours, we can pretend that we're moving from a DSQ and use the
+ * same mechanism - mark the task under transfer with holding_cpu, release
+ * DISPATCHING and then follow the same protocol. See
+ * unlink_dsq_and_switch_rq_lock().
+ *
+ * On return, @src_rq is locked. Return %true if @p is still ours, with
+ * holding_cpu cleared. Return %false if @p was lost to a dequeue.
+ */
+static bool release_dispatching_and_lock_task_rq(struct task_struct *p,
+						 struct rq *locked_rq,
+						 struct rq *src_rq)
+{
+	p->scx.holding_cpu = raw_smp_processor_id();
+
+	/* store_release ensures that dequeue sees the above */
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+	if (locked_rq != src_rq)
+		switch_rq_lock(locked_rq, src_rq);
+
+	/* task_rq couldn't have changed if we're still the holding cpu */
+	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
+	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
+		p->scx.holding_cpu = -1;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @sch: scx_sched being operated on
@@ -3189,7 +3231,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 {
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
-	struct rq *locked_rq = rq;
+	struct rq *locked_rq;
 
 	/*
 	 * We're synchronized against dequeue through DISPATCHING. As @p can't
@@ -3203,36 +3245,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
-	/*
-	 * @p is on a possibly remote @src_rq which we need to lock to move the
-	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
-	 * on DISPATCHING, so we can't grab @src_rq lock while holding
-	 * DISPATCHING.
-	 *
-	 * As DISPATCHING guarantees that @p is wholly ours, we can pretend that
-	 * we're moving from a DSQ and use the same mechanism - mark the task
-	 * under transfer with holding_cpu, release DISPATCHING and then follow
-	 * the same protocol. See unlink_dsq_and_switch_rq_lock().
-	 */
-	p->scx.holding_cpu = raw_smp_processor_id();
-
-	/* store_release ensures that dequeue sees the above */
-	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
-
 	/* switch to @src_rq lock */
-	if (locked_rq != src_rq) {
-		switch_rq_lock(locked_rq, src_rq);
-		locked_rq = src_rq;
-	}
-
-	/* task_rq couldn't have changed if we're still the holding cpu */
-	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
-	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+	locked_rq = src_rq;
+	if (release_dispatching_and_lock_task_rq(p, rq, src_rq)) {
 		bool fallback = false;
 
-		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
-		p->scx.holding_cpu = -1;
-
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
-- 
2.56.1.839.g22a8290db9-goog

