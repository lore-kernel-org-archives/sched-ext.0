Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766921;
	b=3/0O6SVcBYXBlKX2iApV2VZ37FvzpS4nm/2eOS7WFa9v70H3VGac61AIuR3sQFKyCPr+
	 gZWoIIgEJYv+Gfrbk11SMTNBb6KikxjPlaPKSFXRB5c0V5wA00mIjLTigD76YqenvLTji
	 Rlrf0BnOoUZf4zzi2/4FwSqL2nr1gyzBlJFRHG1tvCRqL3Wugzkiy9gktFjoMB/6O0Cdp
	 qYNz2/Avz7AVfTbO4au3JOvefHuEZYVCIJthTTdX9bm7sRVZYjcuusUyJ3coQroucZdXv
	 ESGac1bME4C9LJ6MAfZnRnRjPwPCDiKht5L9Q3L7q52S18Abx7rpZehqwgrqZkxxJHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XoNiU9ULidIP7mhpM0I3d1L1MqWC9duVSz+nVIzIlO4=;
	b=p1mV9/tHHN7332rhy1X30clUp7pqCsceOKGi3Xe3bpCj4QqpvAmTsnRO1ybIuAhyJYX9
	 ljql7Mojz0os7pTEInMMkKBm2ZDiQ1Bu8S6uiylEMJWEVL3CJ/GEd4U+S4dnY9fp50KiT
	 UMFr6F2AAzxxj8+NcZ8pkot/vMBfwRh/03+EJ2fjBqn4hSMRptmDsfhU4DRuSwlscOfYE
	 OQulimFIbgya3eUpQlQfF6BrEsJDKB2zGbwkd/0WXzfzX7BY998U3/KqtV/zyk/i1JTar
	 mion4/UyOGDTxUzW2k9/wH1xqky9Zkd7MmhIDVKSy8F4/Sx8n/fdKw39scnH0cI6vEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=t2mtBxPK;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C159606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 14:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C159606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=t2mtBxPK
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso7623745e9.0
        for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792766919; x=1793371719; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoNiU9ULidIP7mhpM0I3d1L1MqWC9duVSz+nVIzIlO4=;
        b=t2mtBxPKkLJT0OQfNx0e7W5EwX/mjWFXluHvo63UO0fsNImuI6u8Fr+WmnboFNGLoW
         9XzFGxy93gIUkTRyhm3MQ2hvyp4xDoCFMekDFkj7i/1lCogPYYjSKctauGNMsDnCmyfe
         dtmCPsHDgs1iNSlBeh+NLobltGmQJnL74XjrCoBSk0dMzpLS0nLkMoAo7tGGOCZSDUJI
         52YM8DCDuS/3jV1v9ShLyvoPNK/BawcFn04uno8MKgGi6Gt723q8kwrIvw2UlpYGmI06
         pZfRSIiQl0wAQD0/sFreGtMhTJ/TOugb3ExSTSBlblr4sdIH9kASTo5JqIxehW2EeKSX
         oMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766919; x=1793371719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoNiU9ULidIP7mhpM0I3d1L1MqWC9duVSz+nVIzIlO4=;
        b=DYWRkGJVPwW3D9BBftuF++ZCbqRjlcUTG/s4tU5B06Om9sCKJ6FFHK5mxMnacQLAL0
         3o/wSPqsq3jYmB5CzEHsBHKDwLCjh0fQadbOE1HjZbyFEc1pvVxbKwrXuMviWsli7hmS
         nLrlsyKc+s01Nk0Op6d1FE/dJCBXo3O0WHy5/QyZN0+V538N73u1g9fO1hjooYnI51qu
         jYDnRRMelaSiiLxTB4dtoAPJ5R6gnovK7LhBE1lPXDKBTeal33V6HHN/2J12a49kd4SA
         2mXeAO6rbNEaL0QWGhilj3kfMlWrzXqimU/shjGiWRFY+kSh9nDcyOX0XD9meNjLm430
         /u4g==
X-Forwarded-Encrypted: i=1; AKwUvBy3dzVTEc1IyoFq7KT9EWb5DcUKyqrGWJZOTeCgpFwWBgJTmzU4Hk7rQ7gwtxXpxOm9je/WbdzXvz8=@lists.linux.dev
X-Gm-Message-State: AFq9FYKbISCD6KIHa7pVT6iB6zuJwcOdW/egGW9I2oUFx1l+AzFp1G1h
	KhY7inDTWJAgYcH9AamK9URLWQiqg8nGXi06Vs39qeLPQTZ5e3fx2mFdB3zqD2hxEjrWR04PDKa
	UnjVkWywUZXK2gQ==
X-Received: from wmoo14.prod.google.com ([2002:a05:600d:10e:b0:4a1:df53:c6c2])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a00c:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4a211f11bf8mr35857445e9.29.1792766918592;
 Fri, 23 Oct 2026 07:48:38 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:48:04 +0000
In-Reply-To: <20261023144811.2230393-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261023144811.2230393-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023144811.2230393-2-jpiecuch@google.com>
Subject: [PATCH 1/2] sched/core: Preserve WF_RQ_SELECTED across queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ENQUEUE_RQ_SELECTED tells a sched_class that ->select_task_rq() was
called for a task wakeup. sched_ext exposes this flag to BPF schedulers
as SCX_ENQ_CPU_SELECTED. However, the flag is lost for queued wakeups,
which a BPF scheduler can opt into with SCX_OPS_ALLOW_QUEUED_WAKEUP.
This also results in undercounting SCX_EV_SELECT_CPU_FALLBACK events.

Preserve WF_RQ_SELECTED for queued wakeups in the same way WF_MIGRATED
is. This way, ttwu_activate() receives WF_RQ_SELECTED for queued wakeups
and passes ENQUEUE_RQ_SELECTED to activate_task().

Fixes: 3539c6411a7c ("sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched.h |  6 ++++--
 kernel/sched/core.c   | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 12a7e094a3e6..9dabffea1c54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1006,7 +1006,7 @@ struct task_struct {
 	/* Unserialized, strictly 'current' */
 
 	/*
-	 * This field must not be in the scheduler word above due to wakelist
+	 * These fields must not be in the scheduler word above due to wakelist
 	 * queueing no longer being serialized by p->on_cpu. However:
 	 *
 	 * p->XXX = X;			ttwu()
@@ -1016,9 +1016,11 @@ struct task_struct {
 	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
 	 *
 	 * guarantees all stores of 'current' are visible before
-	 * ->sched_remote_wakeup gets used, so it can be in this word.
+	 * ->sched_remote_wakeup and ->sched_rq_selected get used, so they can
+	 * be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+	unsigned			sched_rq_selected:1;
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0ab15f03cb94..d8495735166d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3975,13 +3975,20 @@ void sched_ttwu_pending(void *arg)
 	update_rq_clock(rq);
 
 	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+		int wake_flags = 0;
+
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
-		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		if (p->sched_remote_wakeup)
+			wake_flags |= WF_MIGRATED;
+		if (p->sched_rq_selected)
+			wake_flags |= WF_RQ_SELECTED;
+
+		ttwu_do_activate(rq, p, wake_flags, &rf);
 	}
 
 	/*
@@ -4025,6 +4032,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	struct rq *rq = cpu_rq(cpu);
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
+	p->sched_rq_selected = !!(wake_flags & WF_RQ_SELECTED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
 #ifdef CONFIG_SMP
-- 
2.56.0.257.gf7497c7d27-goog

