Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB937BE78;
	Sun, 26 Jul 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785102508; cv=none; b=FGry9huJY3Raljy6tDVGrHqBqFRP8e2c3L+vxecZMwD9jIODQIA6zv4p5BOcUoFta/d27fMsbzo6eISlD4g3EYxWGFL0DyAHDR6LQymrrBV29r3jDqtYx5P1bQ3gaAYZRy5kr4NCykgS1k+IKVeI3+NVI+5K3IpKt3+T2ZURv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785102508; c=relaxed/simple;
	bh=xzfm4tZGC4QDX2wmqSkmrALyprBQB1mOiGpdKphpESM=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=YwqcIoj0Pj6DWpv7IfjQvnmgttoTakM5wL+xtlv9Gk3ZElDprQH/fxPs6OZQ30Mqorvpk+in41soGO0C3kL+W6iQYWY28lepJm0GZ5sGy18ljDeJSVIYEbDcHiCjIEQquQc69bkrnNNSDGeDNR716OYuvurGwd4PrXPgNK7wx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWNKAr4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWNKAr4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655AA1F000E9;
	Sun, 26 Jul 2026 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785102506;
	bh=BYBWivTAOL/BTfIMopeakOcytv7LEuulUnndmrUjYCo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=TWNKAr4klIkrpTRevRwFg8f6JkhHPF4n1W5KrNGAf2YVpNFiIP8m+DNgnTToFUpWt
	 al88v5LxTCYCEyauOZs2dZQz9Oqvl3981aA9Oz1tbJ+xxwEIhryQT3BNGhTrN8YRsU
	 RU0bzT3QytYSU5qGCzFpkOqZ7M/1/Vqk0v9RJklVwfT1KUuUuZGT0R97O2EtmfHbSy
	 eViShciZRswONnEus/QwFGdZjnZ3Fm5TXiMTxk0Y+33ctVt4xiyM/3FqBgDH3pMlQA
	 2AmyvD1BzHLz2kL1hRrvDNtaOxIFeaMXxTtjdCvSBKIZFLZGi8ZTJX+Tprg5BPVjqf
	 h0DM1jwmsswcw==
Date: Sun, 26 Jul 2026 11:48:25 -1000
Message-ID: <048d8cc6b8e9be48ec0e6e431afc75cd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
    Andrea Righi <arighi@nvidia.com>,
    Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
    Emil Tsalapatis <emil@etsalapatis.com>,
    linux-kernel@vger.kernel.org
In-Reply-To: <amZsEbZJdDgjstPF@gpd4>
References: <6649066b805d5660b598f3155c30daac@kernel.org>
    <amZsEbZJdDgjstPF@gpd4>
Subject: [PATCH sched_ext/for-7.3] tools/sched_ext/include: Regenerate enum_defs.autogen.h
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Regenerate enum_defs.autogen.h from the current vmlinux.h to pick up the SCX
enum changes accumulated since the last regeneration, including the
SCX_REENQ_LOCAL_MAX_REPEAT to SCX_REENQ_MAX_REPEAT rename.

Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/amZsEbZJdDgjstPF@gpd4/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-7.3.

 .../sched_ext/include/scx/enum_defs.autogen.h | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index da4b459820fd..0379eff117c9 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -7,9 +7,26 @@
 #ifndef __ENUM_DEFS_AUTOGEN_H__
 #define __ENUM_DEFS_AUTOGEN_H__
 
+#define HAVE_SCX_ARENA_MIN_ORDER
+#define HAVE_SCX_ARENA_GROW_PAGES
+#define HAVE___SCX_CAP_ENQ_IMMED
+#define HAVE___SCX_CAP_ENQ
+#define HAVE___SCX_CAP_PREEMPT
+#define HAVE___SCX_CAP_PERF
+#define HAVE___SCX_NR_CAPS
+#define HAVE___SCX_CAP_ALL
+#define HAVE_SCX_CAP_ENQ_IMMED
+#define HAVE_SCX_CAP_ENQ
+#define HAVE_SCX_CAP_PREEMPT
+#define HAVE_SCX_CAP_PERF
+#define HAVE_SCX_CAP_BASE
+#define HAVE_SCX_CAPS_REENQ_ON_LOSS
+#define HAVE_SCX_CID_SHARD_SIZE_DFL
+#define HAVE_SCX_CID_SHARD_MAX_CPUS
 #define HAVE_SCX_DSP_DFL_MAX_BATCH
 #define HAVE_SCX_DSP_MAX_LOOPS
 #define HAVE_SCX_WATCHDOG_MAX_TIMEOUT
+#define HAVE_SCX_TID_CHUNK
 #define HAVE_SCX_EXIT_BT_LEN
 #define HAVE_SCX_EXIT_MSG_LEN
 #define HAVE_SCX_EXIT_DUMP_DFL_LEN
@@ -20,7 +37,7 @@
 #define HAVE_SCX_BYPASS_LB_DONOR_PCT
 #define HAVE_SCX_BYPASS_LB_MIN_DELTA_DIV
 #define HAVE_SCX_BYPASS_LB_BATCH
-#define HAVE_SCX_REENQ_LOCAL_MAX_REPEAT
+#define HAVE_SCX_REENQ_MAX_REPEAT
 #define HAVE_SCX_SUB_MAX_DEPTH
 #define HAVE_SCX_CPU_PREEMPT_RT
 #define HAVE_SCX_CPU_PREEMPT_DL
@@ -35,6 +52,7 @@
 #define HAVE_SCX_DSQ_GLOBAL
 #define HAVE_SCX_DSQ_LOCAL
 #define HAVE_SCX_DSQ_BYPASS
+#define HAVE_SCX_DSQ_REJECT
 #define HAVE_SCX_DSQ_LOCAL_ON
 #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
 #define HAVE_SCX_DSQ_ITER_REV
@@ -60,6 +78,7 @@
 #define HAVE_SCX_ENQ_DSQ_PRIQ
 #define HAVE_SCX_ENQ_NESTED
 #define HAVE_SCX_ENQ_GDSQ_FALLBACK
+#define HAVE_SCX_ENQ_IGNORE_CAPS
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_IN_CUSTODY
@@ -71,9 +90,11 @@
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
 #define HAVE_SCX_TASK_NONE
+#define HAVE_SCX_TASK_INIT_BEGIN
 #define HAVE_SCX_TASK_INIT
 #define HAVE_SCX_TASK_READY
 #define HAVE_SCX_TASK_ENABLED
+#define HAVE_SCX_TASK_DEAD
 #define HAVE_SCX_TASK_REENQ_REASON_SHIFT
 #define HAVE_SCX_TASK_REENQ_REASON_BITS
 #define HAVE_SCX_TASK_REENQ_REASON_MASK
@@ -81,6 +102,7 @@
 #define HAVE_SCX_TASK_REENQ_KFUNC
 #define HAVE_SCX_TASK_REENQ_IMMED
 #define HAVE_SCX_TASK_REENQ_PREEMPTED
+#define HAVE_SCX_TASK_REENQ_CAP
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
@@ -93,17 +115,17 @@
 #define HAVE_SCX_EXIT_UNREG_KERN
 #define HAVE_SCX_EXIT_SYSRQ
 #define HAVE_SCX_EXIT_PARENT
+#define HAVE_SCX_EXIT_PARENT_KILL
 #define HAVE_SCX_EXIT_ERROR
 #define HAVE_SCX_EXIT_ERROR_BPF
 #define HAVE_SCX_EXIT_ERROR_STALL
-#define HAVE_SCX_KF_UNLOCKED
-#define HAVE_SCX_KF_CPU_RELEASE
-#define HAVE_SCX_KF_DISPATCH
-#define HAVE_SCX_KF_ENQUEUE
-#define HAVE_SCX_KF_SELECT_CPU
-#define HAVE_SCX_KF_REST
-#define HAVE___SCX_KF_RQ_LOCKED
-#define HAVE___SCX_KF_TERMINAL
+#define HAVE_SCX_EXIT_ERROR_REENQ
+#define HAVE_SCX_KF_ALLOW_UNLOCKED
+#define HAVE_SCX_KF_ALLOW_INIT_CIDS
+#define HAVE_SCX_KF_ALLOW_CPU_RELEASE
+#define HAVE_SCX_KF_ALLOW_DISPATCH
+#define HAVE_SCX_KF_ALLOW_ENQUEUE
+#define HAVE_SCX_KF_ALLOW_SELECT_CPU
 #define HAVE_SCX_KICK_IDLE
 #define HAVE_SCX_KICK_PREEMPT
 #define HAVE_SCX_KICK_WAIT
@@ -121,6 +143,7 @@
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
+#define HAVE_SCX_OPS_TID_TO_TASK
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
@@ -136,6 +159,7 @@
 #define HAVE_SCX_SLICE_BYPASS
 #define HAVE_SCX_SLICE_INF
 #define HAVE_SCX_REENQ_ANY
+#define HAVE_SCX_REENQ_CAP_REVOKE
 #define HAVE___SCX_REENQ_FILTER_MASK
 #define HAVE___SCX_REENQ_USER_MASK
 #define HAVE_SCX_REENQ_TSR_RQ_OPEN
@@ -146,11 +170,20 @@
 #define HAVE_SCX_RQ_BAL_KEEP
 #define HAVE_SCX_RQ_CLK_VALID
 #define HAVE_SCX_RQ_BAL_CB_PENDING
+#define HAVE_SCX_RQ_SUB_IDLE_RENOTIFY
+#define HAVE_SCX_RQ_ROOT_IDLE_RENOTIFY
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_BALANCE
 #define HAVE_SCX_SCHED_PCPU_BYPASSING
+#define HAVE_SCX_SLICE_OOB_DUR_BITS
+#define HAVE_SCX_SLICE_OOB_ID_BITS
+#define HAVE_SCX_SLICE_OOB_DUR_MASK
+#define HAVE_SCX_SLICE_OOB_ID_SHIFT
+#define HAVE_SCX_SLICE_OOB_ID_MASK
+#define HAVE_SCX_SLICE_OOB_PENDING
 #define HAVE_SCX_TG_ONLINE
 #define HAVE_SCX_TG_INITED
+#define HAVE_SCX_TG_SUB_INIT
 #define HAVE_SCX_WAKE_FORK
 #define HAVE_SCX_WAKE_TTWU
 #define HAVE_SCX_WAKE_SYNC
-- 
2.55.0

