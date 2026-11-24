Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516277;
	b=xA/teIlIcYc4tUJnYknE596i8z7EUb60/subMBVWgjnbJNXtzWQYDTdmpO6eUIFZTNEY
	 lcBdc4CZ2TonJGxv/RQ0UbUb09ywFq/fwWk/du2kldzJF1J7o1b+7Dccg5GdNTGQYDyg1
	 8Am265YXaPW33AYNhupbqH2nNk3C3rW5MFpkcMafPEombpU12+/RYYeA8ZUoyyIazJI59
	 4iHFgCeI6JTlI1AjVJZX4YbQWAt+yFCEbVYTnb3gqaE3uDnq94kS+x2fhoyXBqQXAaSgK
	 KxBfXlKJN9RT00AZkp9tJV5B1tsHnDkUyfsodCfk4Hp15g4qWeaorfdr61EaHUxe54g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1Sf68OIIcuaTDE9RTPGfqBeJ0BZYyHQM20HV27OG4qo=;
	b=k/sZIQAypT71NAG0qinyM+7pOjzuRUxsfLBW6vmf5yoJele7Y2iKaez6ZQj5IQcaojUK
	 7VoJeJkJ0U4GZDbXGbFszU8f4WvkSBbwsxVKD3ZT6vwpc8P0SQ5/Cw80vNE1N17wDduFD
	 FU4zHvbOw338sAG0cCHyQYLjXeyqACFAmLENMiBSc3DcTzvCs8CAtNxidSEDIzraFtP51
	 oD1EHu8feOd2C+j8K8L3JHg4/IkMQge9B7yA0MFmYP+DPDgd1gv2fnUbddplDkl3/mfdS
	 /v+4HUVlHTnUKRigcSTbSDAAM8zbKNrYjJSiE2cthfK8QYu74zgv0MZR1MBA63iMGKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MvpetjIh;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FA606A327
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 10:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890FA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MvpetjIh
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6ba63cc6d3aso3400545a12.2
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795516276; x=1796121076; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Sf68OIIcuaTDE9RTPGfqBeJ0BZYyHQM20HV27OG4qo=;
        b=MvpetjIhhZuEUSFFxa7DeR4WwbpwZsliLrCe8reRNl8qRUrbnhW2mDFq3QroIIEhTf
         DHXJuJSos81TJV/I55gLxbiE6zy7wAvZqFtU2BPw14VcZGr/WamDtjmbn2PT16ueArej
         rAONYgjt7AWbiypbohPYBJq7TKXP2fKXgHKNHzeDk6K5gPVXgutHX10HV7O1TyCe+5Tj
         KEFo/2apcFLyQODwgd//ZTUgwZs4e+VRKRbQS0OaTFDZQYh1Puj4KsGv798PvJ0rSz9Y
         cWWcYi1gse1vUqdAjDPx/eD7j4aZoAcKa1KAW53NyG+XgEXdwoAbHdz/g3hrqKX3u58W
         s1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516276; x=1796121076;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Sf68OIIcuaTDE9RTPGfqBeJ0BZYyHQM20HV27OG4qo=;
        b=iRSffwzeQHej13Zu8zqcOexFlxBa5gUZ6V+8rDuTTvcdj7eTITc8SB4AnL/Wst1KUH
         r4j+SWRYppg7uMiBg6wVV21NhrqKZ4xS+WqDmfo924sblj9WLZza3ttP17xbiNAMxL4J
         b/TGm+6uf4vgoZA7p0/n+wK8qA9dy+ca5N+it8hBl9Jsf1+iYzpQ96SzOswv7Wl+3qSJ
         nHDobx30sDUNzWLKXRIofL6x1/reKJyjYapQpqVdZbF2v/mZdBKfjefM4ONIEPzuQp+y
         i//Z+z7+m7m6Z7FKROAsGx8l5Kyjhlfw7YSib4BHpebDBFuCyzwzZvWhpVrGwWF0Mh4x
         Sj8Q==
X-Forwarded-Encrypted: i=1; AL+hErFHKYnTTCVUQOJhJnxA+VghG0ZQGrKPaGcGARymAV0Ujhn/xtcGRQXNUB10DfAXqn1M3ZNr+SldyIE=@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ai6h2ZlpJcou6KKyniomYiSXeStxGhUIrUaWHJv3OA+w0kSBt
	U6TNcIjvod0ezbg8hueWx5GGPO20s3PiS+9tWS/GIVRq7JGqd3JjE36PZXvTIksFC4vjQ8F/F1t
	5yY/CwKcLnx9luA==
X-Received: from edcns3-n2.prod.google.com ([2002:a05:6402:c6c3:20b0:6b8:9a3c:9b74])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42c8:b0:6ba:c8d4:1cad with SMTP id 4fb4d7f45d1cf-6bac8d41d4fmr3349102a12.15.1795516275588;
 Tue, 24 Nov 2026 02:31:15 -0800 (PST)
Date: Tue, 24 Nov 2026 10:31:14 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124103043.339553-1-jpiecuch@google.com>
Subject: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix suspicious RCU
 usage in KF_RCU_PROTECTED kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_bpf_dsq_peek() and scx_bpf_tid_to_task() call rcu_dereference()
without taking rcu_read_lock() and rely on KF_RCU_PROTECTED instead.
However, the verifier treats every non-sleepable program as being in an
RCU read-side section, including bpf_timer callbacks. bpf_timer_cb()
runs those from hrtimer softirq without rcu_read_lock(), so calling
either kfunc from a bpf_timer callback triggers:

  WARNING: suspicious RCU usage
  kernel/sched/ext/ext.c:11170 suspicious rcu_dereference_check() usage!
  ...
   scx_bpf_dsq_peek+0x7d/0xd0
   bpf_timer_cb+0xf9/0x130

The same happens from a sleepable program inside bpf_preempt_disable().
Both contexts are RCU readers, so this is a lockdep false positive, not
a use-after-free.

Every context accepted by KF_RCU_PROTECTED satisfies
rcu_read_lock_any_held(). Use rcu_dereference_all() in both kfuncs,
matching scx_prog_sched() and rhashtable_lookup(), and convert
scx_bpf_cpu_curr() and scx_bpf_cid_curr() from guard(rcu)() +
rcu_dereference() to rcu_dereference_all() as well to avoid redundant
per-call RCU read-side lock/unlock overhead.

This patch was written with the help of an AI coding assistant.

Fixes: 44f5c8ec5b9a ("sched_ext: Add lockless peek operation for DSQs")
Fixes: 41e3312861ea ("sched_ext: add p->scx.tid and SCX_OPS_TID_TO_TASK lookup")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
Changes in v2:
- Use rcu_dereference_all() instead of guard(rcu)() in
  scx_bpf_dsq_peek() and scx_bpf_tid_to_task(), and convert
  scx_bpf_cpu_curr() and scx_bpf_cid_curr() to match (Andrea).
- Drop patch 2 ("sched_ext: Take rcu_read_lock() explicitly in sub-cap
  kfuncs") (Andrea).

v1: https://lore.kernel.org/all/20261123145927.577162-1-jpiecuch@google.com/

 kernel/sched/ext/ext.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8c30a21e03e..b8702b81782a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11167,7 +11167,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
 		return NULL;
 	}
 
-	return rcu_dereference(dsq->first_task);
+	return rcu_dereference_all(dsq->first_task);
 }
 
 /**
@@ -11908,8 +11908,6 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 {
 	struct scx_sched *sch;
 
-	guard(rcu)();
-
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
 		return NULL;
@@ -11917,7 +11915,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->donor);
+	return rcu_dereference_all(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -11933,15 +11931,13 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	struct scx_sched *sch;
 	s32 cpu;
 
-	guard(rcu)();
-
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
 		return NULL;
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->donor);
+	return rcu_dereference_all(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -11958,7 +11954,7 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
 	struct sched_ext_entity *scx;
 
 	if (!scx_tid_to_task_enabled()) {
-		struct scx_sched *sch = rcu_dereference(scx_root);
+		struct scx_sched *sch = rcu_dereference_all(scx_root);
 
 		if (sch)
 			scx_error(sch, "scx_bpf_tid_to_task() called without SCX_OPS_TID_TO_TASK");

base-commit: 2f7928516314f37d7cb334675656b4412edc8be3
-- 
2.56.1.831.g720f3f5937-goog

