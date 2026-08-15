Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA9345EA2;
	Sat, 15 Aug 2026 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773071; cv=none; b=AJY20FihMbLTwdN6vXVWJwHk5OYuiTw3gBfjpBXaq3H0OhNJq7tEdQg+NPtliQL1W07eSj4eKMZu3K44/DKXQ2jJgOR93CKVk11Z0t7FVvcuNaz2hETgAC2eX0BsnvGF3U9NLORd5eGVO380hvaEIRawrAEEECMd5DWRvUsjXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773071; c=relaxed/simple;
	bh=ixZsHci0NENIdWrnyvq5d9S+VeSe3nvZAiFtHfyGEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyUTCUOsPnvaufZ5lv69khVbu+Lyh6wIit6tctyMHwhqE2BwNiVnto78TPFu0o+hSKWguOw1xghKGf3l+bmrGKYW/Gd9VL73rbE9sb69yTy0bEnHX8iyrRuDpbophPgo+ualNMDw6Ua7wKbmlL3lFKXJSDGH6aSKgBMSnDWEB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYF6O+fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYF6O+fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA0A1F000E9;
	Sat, 15 Aug 2026 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786773070;
	bh=DDwCXmQPX/tbYe0YGCgmQIhNbYAoW0xZdmeoENoIa9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYF6O+fPt5X15K+Hzh0QlKevwv7qK9UmxhUYuG3UaQhW1FYU7ZJpcV+/DUi2nS2l2
	 wx6WSVQITzng4NICV+cOcHzeuiUzhWurvo8uZkFL/o3LaKamowioR2ZC2z2fEIo/s8
	 f4eXEo6SKtgLjccI+6RMQ6eArGVkPNvfmBxgyHBqSulCSkjJt84hOrmULtJjJHaSft
	 zRmp1xRFqT4tSB4AMJSxNwzyaLkJ/XS1pKoUNJ86UVqyL240lvyIQxtvAmj+5q/1Pg
	 h9s5loDp2dld+wi26N2wvA/0pgQ73AoXjDXfAk3LKq8KoA32Qbtoo4BSZ9gLIpUTGP
	 wLkwFTaGQlBtQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Make scx_bpf_events() read the calling scheduler's counters
Date: Fri, 14 Aug 2026 19:51:07 -1000
Message-ID: <20260815055107.115671-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815055107.115671-1-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_events() always reads the root scheduler's event counters, so a
sub-scheduler program querying its own events silently gets the root's
instead and has no BPF-visible way to read its own (the per-scheduler sysfs
"events" file is the only interface). Resolve the scheduler from the calling
program with scx_prog_sched(). Unassociated programs follow the usual
scx_prog_sched() resolution: the root scheduler under a pre-sub-attach
compat root and zeroed counters otherwise.

Also fix up the malformed comment into proper kerneldoc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d301fe757193..b9060c318c3c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10608,19 +10608,23 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 	}
 }
 
-/*
- * scx_bpf_events - Get a system-wide event counter to
+/**
+ * scx_bpf_events - Read the event counters of the calling scheduler
  * @events: output buffer from a BPF program
- * @events__sz: @events len, must end in '__sz'' for the verifier
+ * @events__sz: @events len, must end in '__sz' for the verifier
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Read the event counters of the scheduler associated with the calling program.
+ * @events is zeroed when no scheduler can be resolved.
  */
-__bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
-				size_t events__sz)
+__bpf_kfunc void scx_bpf_events(struct scx_event_stats *events, size_t events__sz,
+				const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	struct scx_event_stats e_sys;
 
 	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux);
 	if (sch)
 		scx_read_events(sch, &e_sys);
 	else
@@ -10743,7 +10747,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PRO
 BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_tid_to_task, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_now)
-BTF_ID_FLAGS(func, scx_bpf_events)
+BTF_ID_FLAGS(func, scx_bpf_events, KF_IMPLICIT_ARGS)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
 #endif
-- 
2.55.0

