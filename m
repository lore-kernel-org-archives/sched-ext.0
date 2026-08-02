Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31C3D565E;
	Sun,  2 Aug 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707699; cv=none; b=QPkICay5Y0Gpeb8lRSUYcBv2q78GKAj7N6/31LmEca4+DEePWSmOhL/3XR5A6+Qb6Gpe6TWm7AP8eRve+Y5sOPTUpVSLTu1hWRq1Jfr781m3Lon3FlBv4AIsuhmIMPYgcBD5ws1MykZN+jaDEZT6m1KpmFIvuVGE06FMPBWFk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707699; c=relaxed/simple;
	bh=VFwoOH/rJhQ3x4GDlUKFlJYUJunaZvv3YQxexa9vWos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGeCfGXo7spluLIoC5kfFU7fZFU8FElMT+Y8UkhTArKfgqpxFuq79t+92Idwef6b2Amcy0pJ7hsl+K7wOxQ03Xxc2O31QPKA8pHod+bJ5H+XIMUxBF2tTlkRS60z6UU1ZJngULhFxB7nWELDWUGOVXhr2eex5M3rOlSgAzAXh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGUvAUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGUvAUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95501F00A3A;
	Sun,  2 Aug 2026 21:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707697;
	bh=6C72SZkthJuIp+kZcPc92L8sFG/r4P5gI1b3cefqKag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUGUvAUG5CdXzllyP2bIfPqasvyLBBJu13fiQcMRRrYt+vPUPKZxIL5bYM4xONuow
	 Yh+zRrCrcTziiP5sq8d/WzlbfwIBfV0RB0BJ6vWnQ5OF/6PhlDBc6IrqB/3uZPs8zz
	 Y+Z/G15SzdatbPdGkl6q4BQVqh5vBjny+aoyi9p8SKQHnH+ajjWTpoCbIEkRFDVfHn
	 1hqxXyGz7WTQk9mjA8ZURPYSc+BdP8dB/zMMcrgTva+rSz5p7GeMa6d9JEWiYRO1w2
	 zm/dBrznXbSnK49o3LJDrAhEvmJw82Qf4iHqLQUUCfy+0opQrXey6fyj7VznbRaN3q
	 xITc+oJtFSh6A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/12] sched_ext: Sync tools autogen enum headers
Date: Sun,  2 Aug 2026 11:54:45 -1000
Message-ID: <20260802215447.3134509-11-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
References: <20260802215447.3134509-1-tj@kernel.org>
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

