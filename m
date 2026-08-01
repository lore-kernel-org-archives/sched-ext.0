Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD5311C2C;
	Sat,  1 Aug 2026 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574323; cv=none; b=MTbnofy7NC29wKsGECCBRleT0fpEoWH7XdOliD1B7xCinlSKcHhfRkJti+MZsDf+5vZN87RACdbYBKFusvbE0k5/bwOPWfOff9eMs1AVCi1TbPepOHH+wZ4vKGr3hJ08rgQ7Cqo+q3fvNJglXMSZwDkcETw71fQf1CWQFvIxC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574323; c=relaxed/simple;
	bh=VFwoOH/rJhQ3x4GDlUKFlJYUJunaZvv3YQxexa9vWos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7b8jV1qh2BnVI7+6n1+TIr53SJcgYnLg4U26Y+P+HpUC7yCzDz24nTmX9r6UGZ2Qt6p2PG+N1mPjlaPOLjWsFMPF0+b0WKgelqzm/f6MsQb6GAAmxJB5sDG3ayKtODwMEm1Q3dSUkVxm/12FJEnZFR2sthcqdG0lGCtb1ufXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzRaA13k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzRaA13k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720431F00ACF;
	Sat,  1 Aug 2026 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574321;
	bh=6C72SZkthJuIp+kZcPc92L8sFG/r4P5gI1b3cefqKag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzRaA13kex3YplES0GSivHLNEqYov3e5K350rCq/DqjqV+qV39bD7vM+CAO3gfOjI
	 EGr3p6WVVwOKhV0+QpqSqDyKarxWS8sknsLkNzupYdMhniGHm/2HfBz6Fq5bcXxQR2
	 46O9KFwLIShKhc/xFmfkNk0I2fAB17GMlc/hTtAiT9EzIfPEpFTuuedxjjzz1UhSGP
	 7JphUw+fPewIKgGk6oP8YpmlgE9g1jOx/80qPzA4SD75LuLz+2u4Sf3kam6txYS+mT
	 XCSY5XwVdTgY9i/sLC/d7T62gMq0LoAMFaD2hyJDjkhKdEmoMeTrqrOoLWz4wFZmXJ
	 xaTWHRRaOyP2A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/12] sched_ext: Sync tools autogen enum headers
Date: Fri, 31 Jul 2026 22:51:48 -1000
Message-ID: <20260801085150.2697653-11-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mechanical regeneration for the enumerators added by the slice write rework
and the rescue machinery. BPF schedulers reference SCX_ENQ_RESCUE, the rest
are enum_defs presence markers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/enum_defs.autogen.h | 16 ++++++++++++++++
 tools/sched_ext/include/scx/enums.autogen.bpf.h |  3 +++
 tools/sched_ext/include/scx/enums.autogen.h     |  1 +
 3 files changed, 20 insertions(+)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 0379eff117c9..c05d4b572955 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -26,6 +26,16 @@
 #define HAVE_SCX_DSP_DFL_MAX_BATCH
 #define HAVE_SCX_DSP_MAX_LOOPS
 #define HAVE_SCX_WATCHDOG_MAX_TIMEOUT
+#define HAVE_SCX_RESCUE_DFL_BW_PPT
+#define HAVE_SCX_RESCUE_MAX_BW_PPT
+#define HAVE_SCX_RESCUE_DISABLE
+#define HAVE_SCX_RESCUE_DFL_QUANTUM_US
+#define HAVE_SCX_RESCUE_MIN_QUANTUM_US
+#define HAVE_SCX_RESCUE_MAX_QUANTUM_US
+#define HAVE_SCX_RESCUE_MIN_SLICE_US
+#define HAVE_SCX_RESCUE_OVERLOAD_MULT
+#define HAVE_SCX_RESCUE_MIN_OVERLOAD_MS
+#define HAVE_SCX_RESCUE_MAX_OVERLOAD_MS
 #define HAVE_SCX_TID_CHUNK
 #define HAVE_SCX_EXIT_BT_LEN
 #define HAVE_SCX_EXIT_MSG_LEN
@@ -53,6 +63,7 @@
 #define HAVE_SCX_DSQ_LOCAL
 #define HAVE_SCX_DSQ_BYPASS
 #define HAVE_SCX_DSQ_REJECT
+#define HAVE_SCX_DSQ_RESCUE
 #define HAVE_SCX_DSQ_LOCAL_ON
 #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
 #define HAVE_SCX_DSQ_ITER_REV
@@ -71,6 +82,7 @@
 #define HAVE_SCX_ENQ_CPU_SELECTED
 #define HAVE_SCX_ENQ_PREEMPT
 #define HAVE_SCX_ENQ_IMMED
+#define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
 #define HAVE___SCX_ENQ_INTERNAL_MASK
@@ -79,6 +91,8 @@
 #define HAVE_SCX_ENQ_NESTED
 #define HAVE_SCX_ENQ_GDSQ_FALLBACK
 #define HAVE_SCX_ENQ_IGNORE_CAPS
+#define HAVE_SCX_ENQ_APPLY_SLICE
+#define HAVE_SCX_ENQ_SLICE_DFL
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_IN_CUSTODY
@@ -86,6 +100,7 @@
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
 #define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_IMMED
+#define HAVE_SCX_TASK_PROTECTED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
@@ -120,6 +135,7 @@
 #define HAVE_SCX_EXIT_ERROR_BPF
 #define HAVE_SCX_EXIT_ERROR_STALL
 #define HAVE_SCX_EXIT_ERROR_REENQ
+#define HAVE_SCX_EXIT_ERROR_RESCUE
 #define HAVE_SCX_KF_ALLOW_UNLOCKED
 #define HAVE_SCX_KF_ALLOW_INIT_CIDS
 #define HAVE_SCX_KF_ALLOW_CPU_RELEASE
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d..11bd9b70811a 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -124,6 +124,9 @@ const volatile u64 __SCX_ENQ_PREEMPT __weak;
 const volatile u64 __SCX_ENQ_IMMED __weak;
 #define SCX_ENQ_IMMED __SCX_ENQ_IMMED
 
+const volatile u64 __SCX_ENQ_RESCUE __weak;
+#define SCX_ENQ_RESCUE __SCX_ENQ_RESCUE
+
 const volatile u64 __SCX_ENQ_REENQ __weak;
 #define SCX_ENQ_REENQ __SCX_ENQ_REENQ
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce..0cc4f21c6b6a 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -45,6 +45,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
-- 
2.55.0

