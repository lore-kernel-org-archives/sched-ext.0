Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3293C4B63;
	Thu, 16 Jul 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237464; cv=none; b=I9vAvSFmMLtiG846T+xlp8I74YQR9ju23g3SsNo/pv8guqpIInsitBwcHG5QS71G95q6SrbcSPl4aH32PhvX+E9BAQ5QhCEOlgyfjbwFwY7teBhUGrTqaiAKn7aMbrpa169j31VmsTc1VY2lyTn0flSf1Rb809BNE+s/CsstRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237464; c=relaxed/simple;
	bh=cBWYzS7kUKF18KuFMXt6wKfzQ0mKT9GjfUin99eQyCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i10IiU8vOF6w7we4YZfVsHtwRi6bN5xpycV6SLY3U18l+3TnFoCy/8EEfB056FgHIDxtGpktpPMiUz6j0UqwWV71RiKVbxZB1VWVlH+8ohAQljIU5jFxBnnINfILaNkgRahoh50eSPNsOC0+ZfWU7LudS5pwRiDQAo3/IyqZ6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxo19zbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxo19zbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADB1F00A3A;
	Thu, 16 Jul 2026 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237462;
	bh=W7peqmaxqbM3MLxI3TlmLAEEbcx2TGgCAz6iOp0G6HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oxo19zbRf4g6eL1rfQNiwewD6OQAOep7LV3Iai6/MphvXq54NghiJqaWDB6yb6AT2
	 /8ZMDELABfs7qRwVVkiWGazTWMmdojqY/0I+5wThda1wWwnAAsvJNlq2nWX/PWlIkg
	 C/lII1YaSgGlujITuFDCblEwRhuUY+1KbU4xjsxhyYW6lH9+g5kHBjQt9TfUyAV9S7
	 /aU3JZVBozJ0DKDu1MCZ5tr/K0789cpD029y7lQdtwHoBuvlG17kfFxNwlfqX1m7Js
	 sB9fQtjxQ8/73AUNIZH6oc6JcWGczTVYSTogkNolweibbykLUP25ypKRH0ASGWgwCK
	 Fw1SqJFFWYJTg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Skip sub-disable teardown for never-linked sub-schedulers
Date: Thu, 16 Jul 2026 11:30:57 -1000
Message-ID: <20260716213058.1739522-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
References: <20260716213058.1739522-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sub-scheduler enable can fail before scx_link_sched() links the sched into
the hierarchy, e.g. when the parent is already being disabled, and cleanup
still runs the full scx_sub_disable().

That is racy against root disable: drain_descendants() is the only ordering
between a sub's disable-time task walk and root disable's all-task teardown,
and an unlinked sub is invisible to it. Root's teardown can thus run between
the never-linked sub's drain and its walk, exiting every task to no
scheduler.

The walk then trips the membership WARN and re-homes the exited tasks onto
the dying hierarchy, a use-after-free.

Skip the cgroup ownership reset and the task walk if @sch was never linked,
indicated by the empty ->sibling as unlinking only happens later in the same
function. The membership WARN remains valid: a linked sub is always waited
on by an ancestor's drain.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 58898cd0727b..98dd7df88db4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5937,6 +5937,15 @@ static void scx_sub_disable(struct scx_sched *sch)
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
+	/*
+	 * An enable that failed before scx_link_sched() never owned a cgroup or
+	 * task and won't be waited on by an ancestor's drain_descendants().
+	 * Nothing to reparent and walking the tasks can misbehave as the task
+	 * ownership invariant (either owned by self or parent) does not hold.
+	 */
+	if (list_empty(&sch->sibling))
+		goto dump;
+
 	set_cgroup_sched(sch_cgroup(sch), parent);
 
 	scx_task_iter_start(&sti, sch->cgrp);
@@ -5949,8 +5958,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 			continue;
 
 		/*
-		 * By the time control reaches here, all descendant schedulers
-		 * should already have been disabled.
+		 * By the time control reaches here, all linked descendant
+		 * schedulers should have been disabled.
 		 */
 		WARN_ON_ONCE(!scx_task_on_sched(sch, p));
 
@@ -6017,6 +6026,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 	}
 	scx_task_iter_stop(&sti);
 
+dump:
 	scx_disable_dump(sch);
 
 	scx_cgroup_unlock();
-- 
2.55.0

