Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6472C21C5
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694639; cv=none; b=ETrv4qgXsvSS1ZqflOLPrDRucJRVQJpbu8uDzbCiKqpXPpgDlswBYoORXNLFyNogL/fVbkgpXzGQEOCzjf96aunIIvnMTPfqcEbCABVhlt4sayYqy+2cPIpSAOVebDkWXV5UxfsjguNp+WIpx80HOzhPp8jHEc6Dd9sWia3fRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694639; c=relaxed/simple;
	bh=pzRKBu3SXQKga3pYDi4SadmUoxVjMew/0Myz9yjAuGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qu5ImFeVEuvI5L/H0XPvmZY53LlA0rj/z8njrn5EirK2AopDLw6q/K5Apzxu9p+9e6rx6uQQMA8GNoy9F6HOkwDKHWQ1VSGXxQVua0Lp5znZPM5hscGCRQ53rU3+SVD0ms7NohnAv4W9Sa2tYJbmfLd62EKD8/nCOJvBGcjvdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBe6aA7Z; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBe6aA7Z"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1288e572c9so111604866b.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783694636; x=1784299436; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxNlQqZ4nmCctseCgXDiOPH8Q0HV/V8Z2ffjauVlT1w=;
        b=mBe6aA7Zu6Skhvqf6FKj7xc/mnTHksQPyH/eZ5tF+hadY8yvRlXI0+FN6TPaqJ62P3
         JHryv84lq/NNZKMGNONrQ8jlgds9uA0nlTO1V+61JPuDZsHO5wLbEIHYGCB9plSRWUGE
         T2G199p/LU15wNjv6vAQlsur0CZYHFHlrLOLyZZNUi1zQ/MAAs4QenYV0pnND3/E4nnX
         lAsRfYzu6l5l4KL2DG66I9nnzdEl+cvL7gk2YClatppo8ryheBMYarUKYpIi3DLIqrBo
         9GB6O/R3zrP6GzyOFEyc4/gXhIxrJ85YF5IMjbWSwjOfIXDHASlEIY2G1IGZ1n2R5xZl
         ZKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783694636; x=1784299436;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxNlQqZ4nmCctseCgXDiOPH8Q0HV/V8Z2ffjauVlT1w=;
        b=MAHJffqgm4u+vqu/e3MBee6emPYe6rDNSsKO4katux8X1PBRvNoWisBVTHHT2pPIdv
         GZultZgmfW639DJwNjuJPkTfJ+FWlF2n/YoMRLVCu6KPbiVyDfzkP8lEu5+Orwe2sMxe
         eJHCs2HGRkxFatj/y3ux7bhL+gObWEUuCRwinIk0BEiOrAyGZxl1LChOX6gXhwEKqfKu
         C99QZNPDNecqd/VVWhngjtsC/0RlL+BYcL3UIGMjD9cRinsc+sp7zgkPCHmSnbOrp2TR
         XHomOVm0iyyWg5516UnKZPKLRXa5M2FcJKJo3rmlr12MaPUrW2YOwBmLLgejaYdvmh++
         sqEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+TzEypVaSlSqczQEfgNSUbCwOLo41xiT3iWRIm15smf1IlDpdbu43QMlw6zuZx6DWrmFb0MYPVIU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0FxJc2IZmYL941l8zzTQW/2IjTUy1yF/+wntF+Nfve2Tlis7m
	lSb6dSOUg6qVUlf0utLBiC7ZRWXyuknnoIxWWZ+3Crc2/dG1UBXEpnIcSmFuKKCnZwEFBjZT4uU
	85SOsMX4Evb3IdQ==
X-Received: from ejbgw6.prod.google.com ([2002:a17:906:f146:b0:c12:549e:c2fd])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:bd81:b0:c12:a469:c with SMTP id a640c23a62f3a-c15cded3365mr517601366b.9.1783694635943;
 Fri, 10 Jul 2026 07:43:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:43:41 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710144342.3802587-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.3] sched_ext: skip ops.set_weight() for
 disabled tasks
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

When switching a task's sched_class away from sched_ext, we get the
following sequence of events in __sched_setscheduler():

sched_change_begin()
  switched_from_scx()
    scx_disable_task(p)
      ops.disable(p)
__setscheduler_params()
  set_load_weight()
    reweight_task_scx(p)
      ops.set_weight(p)
p->sched_class = next_class;
sched_change_end()
  ...

Notably, ops.set_weight() is called _after_ ops.disable().
This violates the expected semantics of the callbacks, the expectation
being that ops.disable() can only be followed by ops.exit_task() or
ops.enable().

Skipping the weight adjustment for disabled tasks should be harmless
since the weight will be recalculated in scx_enable_task() if the task
ever rejoins SCX.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5241b55a58ec..b75d8d71ef4d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3673,6 +3673,17 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 	if (task_dead_and_done(p))
 		return;
 
+	/*
+	 * When switching sched_class away from SCX, reweight_task_scx()
+	 * is called _after_ scx_disable_task(). Skip calling ops.set_weight()
+	 * since the BPF scheduler may have already forgotten the task in
+	 * ops.disable().
+	 * p->scx.weight will be recalculated in scx_enable_task() if the task
+	 * ever returns to SCX class.
+	 */
+	if (scx_get_task_state(p) != SCX_TASK_ENABLED)
+		return;
+
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
-- 
2.55.0.795.g602f6c329a-goog

