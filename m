Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CF2E11CB
	for <sched-ext@lists.linux.dev>; Mon,  7 Jul 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899725; cv=none; b=f609cQrUH4q2K28qKGWep1fbWaznIaeKQAgXQnmzICLDjRxGGAN6LUYGRIRhzGA60qznJckANyb2MjtIJUS7QuS60HqM+O0GPoPsuwr+Myxls+MtDci6E+udl0uQmKIdomdaKbDVbMgNurbQdOrsBxoR+zwdXu17pqJyrzc1Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899725; c=relaxed/simple;
	bh=XOo/KqeoUFr4ZoV+7SA2c0dUkyLoUkEZgvTIoppRoo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFdb0fTmjVuL9sRfC6lR4s5LrulaAFJO/7mD4lWZPJVVeVtTnOXpaFeeS3lvyoOC1gwRAOwuHEP/KNDYSj7+YVlyEdT9pEF1K9q+x8UHlRsB4lMHzfLRc4KU38kKe2o5aeNko8XlWV+TlkVqsAGJWu3YJaF8WjVXcBE0h18vLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQHI765d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQHI765d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751899722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7oIatGosEglmz7e/TgETTEwaxMtMboDfPP4HMOfw2I=;
	b=MQHI765d0lvXnZ3oYxYbaRinpN4d6xFlXrFhb+oFsStb61tklYm+N6QgADjKH7GTISFfb/
	mdXGw1jPcDyC9cajxXPCRCe49Y5AgVmDNdC3k1NYPmYVMRcalF9nIAjYQSOAngPHQRfXMO
	WtLRop2ay6q0m4nSW4EZToErss32Baw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-9VK7nEcINiidUlGI8xicbg-1; Mon,
 07 Jul 2025 10:48:39 -0400
X-MC-Unique: 9VK7nEcINiidUlGI8xicbg-1
X-Mimecast-MFC-AGG-ID: 9VK7nEcINiidUlGI8xicbg_1751899718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEADB1955EC1;
	Mon,  7 Jul 2025 14:48:37 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FF79180045B;
	Mon,  7 Jul 2025 14:48:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	sched-ext@lists.linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.org>
Subject: [PATCH v14 1/3] sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
Date: Mon,  7 Jul 2025 16:48:22 +0200
Message-ID: <20250707144824.117014-2-gmonaco@redhat.com>
In-Reply-To: <20250707144824.117014-1-gmonaco@redhat.com>
References: <20250707144824.117014-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The fair scheduling class relies on prev_sum_exec_runtime to compute the
duration of the task's runtime since it was last scheduled. This value
is currently not required by other scheduling classes but can be useful
to understand long running tasks and take certain actions (e.g. during a
scheduler tick).

Add support for prev_sum_exec_runtime to the RT, deadline and sched_ext
classes by simply assigning the sum_exec_runtime at each set_next_task.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/ext.c      | 1 +
 kernel/sched/rt.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a1408264..65ecd86bae37d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2389,6 +2389,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
 		update_stats_wait_end_dl(dl_rq, dl_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..a4ac4386b9795 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3255,6 +3255,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c370335..2c70ff2042ee9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1693,6 +1693,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
-- 
2.50.0

