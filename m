Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495002;
	b=AYZMD4pWzpqYMDmLLJSbVTun7O4B9aWJtrEZwnkCzBYuqOfogIqJ/JIUNtcagK0KiXeK
	 PDrXtTinVTMfZrYzIua6urYY7UkNBzxnSAysz15OPbX47kjsxIqnU3xmZVClrHVMxeSOU
	 8DCpCxv6+gXn+BynGziAUGxUkEZmGqoMkkAybt17/Hf5Zyka0YirfiGqSvmwQgPumXutw
	 5mXB4UyPLYpGlE0tw/B96cQ6lc+5txl6Eekjd6FGbyf1h48GsW2RVBeap2qnAVV4waTvA
	 V/HufIkgVS+EnM0HGMh4WcGVgeWCm+p8Li05X9cSO7dQHb+VasGoEqUdh/WMVmRclkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495002;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LdP00xaRudb52/LsBw7dU8aWxZVXiu8lJBJmgivD284=;
	b=HxsML6h82klzzz1hY0nGKmumKeCVvmSEeZy/oxYUEXz8Jrs0WRSPzVDWw1lgUh5zPttb
	 HhKlBS2KqtU6ZOYFfThEY54nTE/+6KxW5aGw5v4zExW27JPdQTD7XHwbLFJuf3waBafJa
	 +9EWRvPsh92vSljwG1axqSE9LY3qqhbOoIi850vmluST5b1XvriuEvE6fZudOlXB+zu55
	 kxIhAXiD+h3MB/ZFLDkiSLDt6uI4xYS0sFfkerLzVebkhzbQtiLii56pPIOhLEpM4BwVE
	 jznQYGe7vtZ/DWzixY9oTtI1XUpNnYKbXg4fHYyYKZqjvgGvX8BqE1wJOjpOeo4xXUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xcIwmSyT;
	arc=none smtp.remote-ip=91.218.175.9
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05C606A334
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 14:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD05C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xcIwmSyT
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=VR44OXmMFC5Ziuz2RAZRy7KzJEZP4oWMUQ30NNHSlsk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794494999; v=1; x=1795099799;
 b=xcIwmSyTjhIjxHb3LrVUVNylcyg0sc2pTEcm8nd0tKL7PKZZZLxSNtrkVXXF0XBoaGXGvNQ4
 2St2569UEGCMghATDJyou+hx806TEXBVqzbTkN6w6yqBkWsSni4HtURw3qmw9pc8XE28n6yQFST
 whWlJ2UzumtDKNDpGJ1L87Tw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 72b595bf3f24a98d;
	Thu, 12 Nov 2026 14:49:59 +0000
X-Mizu-Trace-ID: 72b595bf3f24a98d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] sched/core: Pass ENQUEUE_RQ_SELECTED on initial enqueue
Date: Thu, 12 Nov 2026 22:49:34 +0800
Message-ID: <20261112144935.583937-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112144935.583937-1-cui.tao@linux.dev>
References: <20261112144935.583937-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

select_task_rq() sets WF_RQ_SELECTED and ttwu_do_activate() maps it to
ENQUEUE_RQ_SELECTED so enqueue_task_scx() knows whether ops.select_cpu()
ran. wake_up_new_task() also calls select_task_rq() but activates the
new task without the flag, so on the fork path ops.enqueue() never sees
SCX_ENQ_CPU_SELECTED and SCX_EV_SELECT_CPU_FALLBACK never counts a
fork-path fallback: a misbehaving select_cpu() leaves no trace in the
counters, and schedulers testing SCX_ENQ_CPU_SELECTED run a redundant
select_cpu_dfl() on tasks select_cpu() already placed.

Set ENQUEUE_RQ_SELECTED on the initial enqueue when select_task_rq() was
called, matching the wakeup path. Only sched_ext consumes the flag.

Fixes: 9b671793c7d9 ("sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..f7a452123ef5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5016,6 +5016,7 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq_flags rf;
 	struct rq *rq;
 	int wake_flags = WF_FORK;
+	int en_flags = ENQUEUE_NOCLOCK | ENQUEUE_INITIAL;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
@@ -5029,11 +5030,13 @@ void wake_up_new_task(struct task_struct *p)
 	 */
 	p->recent_used_cpu = task_cpu(p);
 	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
+	if (wake_flags & WF_RQ_SELECTED)
+		en_flags |= ENQUEUE_RQ_SELECTED;
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
+	activate_task(rq, p, en_flags);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, wake_flags);
 	if (p->sched_class->task_woken) {
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
