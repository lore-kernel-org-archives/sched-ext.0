Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEB298CC4;
	Tue, 21 Jul 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673081; cv=none; b=pVHpn76oBpqjgj0dT+Lw3Ah5WKVNrQ46jNf4wk+jYeqWMeIIY+Tz02Zj2PfhMpmiCWvKOcdfNlca2tcu7vRFCKZn6jx1p4eZZTT6/jsVuKQ+NyQ5aGWlINsmd1365f35R6CBLbCEw86pKVnv8rObP55QMPvaW15kW0OzONsurP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673081; c=relaxed/simple;
	bh=iEpIi4Qa5NpGgD6Ierc/GuvynTAcyIadgREuSfbMMMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRnl0jYDnV6iYeSibE9zv6XcNr8gJm4LV57kJxfUO+LrUYg6Oi7+3rl9JJD+PNJPAVRyIW/nIy8f5LzP8JAMkD/z2UwnN3kDFnfDog56/UNzgoO9T4T+YNQkPZONZSoY2Fdsh5dZUiTG9ztKpX7kSxwe/XdyqUjHvtgGYsNVKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elmmc4mi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elmmc4mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5531F00A3D;
	Tue, 21 Jul 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784673080;
	bh=Gxzi8yFm78Vzpa1VaYX8QMdAUOLSezhMie0/U7K7InY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Elmmc4mihL/pxeCgITL+fyYY64JV8kTysQlyn2UMYjZhxvuuEvqQP51KDEMObumx6
	 ONgZNIJMmYAZpLsD+c+Sh5Frkl+B3psiCBVKIc5HxukU3+uJJBjsStOZz64de00sQc
	 4B3bFGqq1uWRU6j/yjVM6klRsC5J2pdEmYejneq9wKlqRrwFjZxuRygBnZO7Qy8u94
	 9PmshW2eHO4tCtx3Emo/MvWmdBKW6QxPhjCVBpbPHBveIC4QXdq2LPCg3uhvebws05
	 1Lstb5H/OAwg7F/owyI6JgDUshpT3biYAFFnfK5usLj6tvI444NwEEIUQ8p5qDHtu2
	 Agf0rD5A1yd3w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 1/4] sched_ext: Blame the DSQ's owning scheduler for a runnable stall
Date: Tue, 21 Jul 2026 12:31:15 -1000
Message-ID: <20260721223118.2268529-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721223118.2268529-1-tj@kernel.org>
References: <20260721223118.2268529-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_rq_for_timeouts() blames a runnable stall on the task's owner. Under
a sub-scheduler hierarchy the stalled task can be sitting on a DSQ that a
different scheduler has to drain, e.g. an ancestor's bypass DSQ while the
owner is bypassing. The drainer then escapes blame while the owner is
exited, and when the owner's exit is already claimed, nothing actionable is
reported at all.

Blame the DSQ's owning scheduler instead. The local DSQ is consumed by the
cpu itself and keeps blame on the owner. Detection keeps the owner's timeout
and single-scheduler behavior is unchanged.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b730eac4b13f..96389ec31ab8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3391,8 +3391,19 @@ static bool check_rq_for_timeouts(struct rq *rq)
 
 		if (unlikely(time_after(jiffies,
 					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
+			struct scx_dispatch_q *dsq = READ_ONCE(p->scx.dsq);
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
+			/*
+			 * A task can be stuck on a DSQ that a sched other than
+			 * its owner is responsible for draining, e.g. an
+			 * ancestor's bypass DSQ while the owner is bypassing.
+			 * Blame the drainer. The local DSQ is consumed by the
+			 * cpu itself and keeps blame on the owner.
+			 */
+			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
+				sch = dsq->sched;
+
 			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
 				   "%s[%d] failed to run for %u.%03us",
 				   p->comm, p->pid, dur_ms / 1000,
-- 
2.55.0

