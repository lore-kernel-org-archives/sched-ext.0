Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768434F27B
	for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444313; cv=none; b=QuXzEUehSuOPddxyYACYSyXPxFCdep6dMRDCDjSA6xCXkRram9fdq1eaj9jpVm+L2mDGeUJHsIEdSodLvQI3cMuLTyDt21qa2cXfDGGtONWiCB4BM/1CP9H32TDl1mNbY7hBatm4YVNsA33QvGhr/ylTtqr+gC9xMg/YZmN8MpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444313; c=relaxed/simple;
	bh=OVBvx9P63qbdCm81YGL65qP7CzKdU9QIj4qTvVtPTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/7B4xchpUyyT0OgzMZDj4UbBstY7B5lua9FdZbo46jHDazt08CAmGZLgM8ElE8h4aVm7InxVLmhtD2rRtwulh8hc9eL2jZ4dG6GTaeyuJTSrRnfneVEaWkHcNK8XjbAhdIY1aJdu3lHltjJ1xwpi1bZpwM6ZZfZ7d3Ylrik3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WItRofii; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WItRofii"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786444306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t09GNjGvOxrA+ki1RYZJjqgi+sjsgwDT7vGmVGyXz6g=;
	b=WItRofiiDb7g13CzRZC5tljY6ujgTBe+E96qvxqL6wZGUpZQ6XvAHXXHxnp0v1HNZng2rl
	ugqSuu+1sZN6LNJWRzfb+gxVUo/fX+JtzMC1798/REKLXgZ8OLrva/3+BkVGpBopvFd0pR
	pDbMQ/wucbUK9wYPaokO9BmA4QbJVxE=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: don't rehome a dead task in scx_cgroup_task_migrated
Date: Tue, 11 Aug 2026 18:31:22 +0800
Message-ID: <20260811103122.357067-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

A task can exit between cgroup migration commit and the MIGRATED callback:
sched_ext_dead() marks it SCX_TASK_DEAD before cgroup_task_dead() removes it
from the migration list, so scx_cgroup_task_migrated() can pick up a dead
task and call scx_rehome_task(), which re-enables it and leaks the BPF
scheduler's per-task resources. The other scx_rehome_task() callers already
check for this; do the same here.

Fixes: bf9dee58ab56 ("sched_ext: Re-home tasks on cgroup migration")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/sub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index b81254be1b04..8f8d21b85abe 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2083,6 +2083,13 @@ static void scx_cgroup_task_migrated(struct cgroup_task_migrate_ctx *ctx)
 		return;
 
 	rq = task_rq_lock(p, &rf);
+
+	if (scx_get_task_state(p) == SCX_TASK_DEAD) {
+		/* sched_ext_dead() raced us */
+		task_rq_unlock(rq, p, &rf);
+		return;
+	}
+
 	scx_rehome_task(to, p);
 	task_rq_unlock(rq, p, &rf);
 }
-- 
2.43.0

