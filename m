Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4435D5F8;
	Sun,  8 Mar 2026 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937927; cv=none; b=NgUdww0zzkfVjGaYeeorq5fvZNMuQ+sjmPBtnJ4+6clscstb4yHKTStptb7ibyWBTCeqWNOEJDY7reP81HkXpT6Adn8dMdvuuvc7Im1jNpdZiUVARQDvMKbgq7noOERD/vguYkp7+w/W5d4qT5T/cLFAVm1OJZ8Ek3Viy1gRw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937927; c=relaxed/simple;
	bh=r9Re9wK5NNLKkQLWnkDqcT5AGwLOLKatmrU7hNu8/mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ib8IJ9hCMnGj9slCrP/8VAcHa/fNmbVXYwK16yHAON3hHgrSkeJ4byk7dkZ1KKmGEzYqz4YcHWRA5RrXS12pw+szSK0NHiEgK+5KAgIIZOM37TR4+YKKjKdeTKS2thkdSJK2NNyoWv8rTTbT9HiYdm765LJ9SufTNc+szCKw2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjZYCnpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjZYCnpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE525C19425;
	Sun,  8 Mar 2026 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937927;
	bh=r9Re9wK5NNLKkQLWnkDqcT5AGwLOLKatmrU7hNu8/mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjZYCnptBKHAAMJ8s2onMEnBOgx+YzQgfTfCPgollH/n5qzcgGwChCmSoqYfOf19q
	 Sp+22QgU1SJg3v2oUPIZSEOCXZoRY8XO/IXhJGdlYkvRgmkXcDxjTNtB4JBql5JpYZ
	 z+Ukhwj7Z+VpdXpv/sBliCLT9P4kCeM9lzEyu0uvjdfboxCZdMajMiNiPx86Dhffxm
	 brf0/W/ljhUnPAJyT9udlAtyIVpQrO3i57zPYT2kP/oMqr0SQt2HbT4VFebhS0E0nT
	 4paJFl7Pc5k96MoAHjhTHYxiNySKqifl3XvLepymRiTKUy9cqC3rfaTy8JTzXr3pix
	 UqLIQ3P3RWFFA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] tools/sched_ext/include: Regenerate enum_defs.autogen.h
Date: Sat,  7 Mar 2026 16:45:19 -1000
Message-ID: <20260308024519.1980564-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regenerate enum_defs.autogen.h from the current vmlinux.h to pick up
new SCX enums added in the for-7.1 cycle.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../sched_ext/include/scx/enum_defs.autogen.h | 49 ++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index dcc945304760..78d34f0c29f0 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -14,7 +14,13 @@
 #define HAVE_SCX_EXIT_MSG_LEN
 #define HAVE_SCX_EXIT_DUMP_DFL_LEN
 #define HAVE_SCX_CPUPERF_ONE
-#define HAVE_SCX_OPS_TASK_ITER_BATCH
+#define HAVE_SCX_TASK_ITER_BATCH
+#define HAVE_SCX_BYPASS_HOST_NTH
+#define HAVE_SCX_BYPASS_LB_DFL_INTV_US
+#define HAVE_SCX_BYPASS_LB_DONOR_PCT
+#define HAVE_SCX_BYPASS_LB_MIN_DELTA_DIV
+#define HAVE_SCX_BYPASS_LB_BATCH
+#define HAVE_SCX_SUB_MAX_DEPTH
 #define HAVE_SCX_CPU_PREEMPT_RT
 #define HAVE_SCX_CPU_PREEMPT_DL
 #define HAVE_SCX_CPU_PREEMPT_STOP
@@ -27,6 +33,7 @@
 #define HAVE_SCX_DSQ_INVALID
 #define HAVE_SCX_DSQ_GLOBAL
 #define HAVE_SCX_DSQ_LOCAL
+#define HAVE_SCX_DSQ_BYPASS
 #define HAVE_SCX_DSQ_LOCAL_ON
 #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
 #define HAVE_SCX_DSQ_ITER_REV
@@ -36,6 +43,10 @@
 #define HAVE___SCX_DSQ_ITER_ALL_FLAGS
 #define HAVE_SCX_DSQ_LNODE_ITER_CURSOR
 #define HAVE___SCX_DSQ_LNODE_PRIV_SHIFT
+#define HAVE_SCX_ENABLING
+#define HAVE_SCX_ENABLED
+#define HAVE_SCX_DISABLING
+#define HAVE_SCX_DISABLED
 #define HAVE_SCX_ENQ_WAKEUP
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
@@ -45,22 +56,37 @@
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
+#define HAVE_SCX_ENQ_NESTED
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
 #define HAVE_SCX_TASK_QUEUED
+#define HAVE_SCX_TASK_IN_CUSTODY
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
+#define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
+#define HAVE_SCX_TASK_NONE
+#define HAVE_SCX_TASK_INIT
+#define HAVE_SCX_TASK_READY
+#define HAVE_SCX_TASK_ENABLED
+#define HAVE_SCX_TASK_REENQ_REASON_SHIFT
+#define HAVE_SCX_TASK_REENQ_REASON_BITS
+#define HAVE_SCX_TASK_REENQ_REASON_MASK
+#define HAVE_SCX_TASK_REENQ_NONE
+#define HAVE_SCX_TASK_REENQ_KFUNC
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
+#define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
 #define HAVE_SCX_ECODE_ACT_RESTART
+#define HAVE_SCX_EFLAG_INITIALIZED
 #define HAVE_SCX_EXIT_NONE
 #define HAVE_SCX_EXIT_DONE
 #define HAVE_SCX_EXIT_UNREG
 #define HAVE_SCX_EXIT_UNREG_BPF
 #define HAVE_SCX_EXIT_UNREG_KERN
 #define HAVE_SCX_EXIT_SYSRQ
+#define HAVE_SCX_EXIT_PARENT
 #define HAVE_SCX_EXIT_ERROR
 #define HAVE_SCX_EXIT_ERROR_BPF
 #define HAVE_SCX_EXIT_ERROR_STALL
@@ -81,40 +107,39 @@
 #define HAVE_SCX_OPI_CPU_HOTPLUG_BEGIN
 #define HAVE_SCX_OPI_CPU_HOTPLUG_END
 #define HAVE_SCX_OPI_END
-#define HAVE_SCX_OPS_ENABLING
-#define HAVE_SCX_OPS_ENABLED
-#define HAVE_SCX_OPS_DISABLING
-#define HAVE_SCX_OPS_DISABLED
 #define HAVE_SCX_OPS_KEEP_BUILTIN_IDLE
 #define HAVE_SCX_OPS_ENQ_LAST
 #define HAVE_SCX_OPS_ENQ_EXITING
 #define HAVE_SCX_OPS_SWITCH_PARTIAL
 #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
+#define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_HAS_CGROUP_WEIGHT
 #define HAVE_SCX_OPS_ALL_FLAGS
+#define HAVE___SCX_OPS_INTERNAL_MASK
+#define HAVE_SCX_OPS_HAS_CPU_PREEMPT
 #define HAVE_SCX_OPSS_NONE
 #define HAVE_SCX_OPSS_QUEUEING
 #define HAVE_SCX_OPSS_QUEUED
 #define HAVE_SCX_OPSS_DISPATCHING
 #define HAVE_SCX_OPSS_QSEQ_SHIFT
 #define HAVE_SCX_PICK_IDLE_CORE
+#define HAVE_SCX_PICK_IDLE_IN_NODE
 #define HAVE_SCX_OPS_NAME_LEN
 #define HAVE_SCX_SLICE_DFL
+#define HAVE_SCX_SLICE_BYPASS
 #define HAVE_SCX_SLICE_INF
+#define HAVE_SCX_REENQ_ANY
+#define HAVE___SCX_REENQ_FILTER_MASK
+#define HAVE___SCX_REENQ_USER_MASK
 #define HAVE_SCX_RQ_ONLINE
 #define HAVE_SCX_RQ_CAN_STOP_TICK
-#define HAVE_SCX_RQ_BAL_PENDING
 #define HAVE_SCX_RQ_BAL_KEEP
-#define HAVE_SCX_RQ_BYPASSING
 #define HAVE_SCX_RQ_CLK_VALID
+#define HAVE_SCX_RQ_BAL_CB_PENDING
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_BALANCE
-#define HAVE_SCX_TASK_NONE
-#define HAVE_SCX_TASK_INIT
-#define HAVE_SCX_TASK_READY
-#define HAVE_SCX_TASK_ENABLED
-#define HAVE_SCX_TASK_NR_STATES
+#define HAVE_SCX_SCHED_PCPU_BYPASSING
 #define HAVE_SCX_TG_ONLINE
 #define HAVE_SCX_TG_INITED
 #define HAVE_SCX_WAKE_FORK
-- 
2.53.0

