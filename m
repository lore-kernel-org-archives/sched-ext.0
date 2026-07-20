Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E53CB2F6;
	Mon, 20 Jul 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535968; cv=none; b=meDCuJF1AEcvSJHIqb/OufPz9X4b6bLkmAbggErF11dC9vX1ObGjqnRfxyWvEQhtz2Z8CiyhBNN2+kFdFJ7bMxGjILC6DYA3c4NRHlZ6AbCYeUetO/2kTblX1unFwTYZYFDXkkNOI8gsY63kf1VjVsRtQ0vA9YH4zDfYFzMNetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535968; c=relaxed/simple;
	bh=iEpIi4Qa5NpGgD6Ierc/GuvynTAcyIadgREuSfbMMMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTpq2BEM1R9G9B2UGM8tUogXNW21oZDYpELfDZGPMN1S4iD2aMgEF95Z5yRTRpSMqa3dRiVVO7no53/N3zZxQuxksRENC/YBSUOTpdfPXkWoPilKBxdagzKNi3+NjoREu9PRmY8ytIXy7/USgjIqP/ZnW5woTsu9erWVvAl4qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apjc6Cvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apjc6Cvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1581F00A3A;
	Mon, 20 Jul 2026 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784535967;
	bh=Gxzi8yFm78Vzpa1VaYX8QMdAUOLSezhMie0/U7K7InY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=apjc6CvmmE0UcepCl7aUJdLMs2/w/znu/agWQZpH8FWzalfocjTA/UlX6ykdWRj84
	 vmF3irg/Au+MIP93IKTk2kB/5zImjRvrzsyRw0YFRFGP18jSWLf4YwGmgyTLtbgy05
	 QiDmXXOoZFB5C/2ZHaQYMpWNn+4/b6Y1o8fndd6iVhJIBkFcy5ZTwDQJGUtgR8TTe5
	 lUb0L0NwoxZiLgCdsHQnN94pBnTA+5zSbdmTmW6v7PBCqIVw68xpZkqZbuVg5BJU7S
	 8y5YT+ssBiR2Iqd1ifh9w5zUfVD8txv8Wo4G5+UDo9yoDHEY5M1HaTtsQ8Pa+chY+A
	 a7eXO25GSvSvw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Blame the DSQ's owning scheduler for a runnable stall
Date: Sun, 19 Jul 2026 22:26:03 -1000
Message-ID: <20260720082605.1451945-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720082605.1451945-1-tj@kernel.org>
References: <20260720082605.1451945-1-tj@kernel.org>
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

