Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6E2FD1B5;
	Sat, 18 Jul 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784369432; cv=none; b=Ri7JQy9cQBler675fnsaXHYn04kW2ca3Fm5O6rRYqpqt/esIKN8Zaf5IT+r+tUHlmm9jQ40yNSzRc3ND0l9mOBEOdSBK4FFkhAiUTxvKzXUa0H0pCQOVXsoxl2bKxBs5YhtMVUjPZavAizZb6niRoF7wMXbctKLMSQxO+7Z2v2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784369432; c=relaxed/simple;
	bh=DyspBFKm0jTK/fnV9SIa1h+7TV05Z+4uFa8EK5yyEqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmP4IIplHq2x0toJhJIp8H78pNTFn5uaqXWkVhICJnVLEyovKagSM2+mRttrxu6VkRWytId+e2iBR0UvLrfx1sPSD6MgSYqgC6sRTBVeZmRHOFht/O35E+dADeRXXRG2cJXD4kNtWjJaWkriNRj73J98hBbHOrKj9+3gepJ/mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ZWjcoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ZWjcoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3572B1F00A3A;
	Sat, 18 Jul 2026 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784369431;
	bh=Shzu7bqgEBDkHjO2Gj4qgOS97Hid+JKdSvgKYKMsQo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7ZWjcojwXrcWnVRVa+3PHmnQUTPRAPBpACjwwexSqgCTNFT7RF29XvwCRASeUjHj
	 epOL36P78k4Wz9ebsvuAqUCKCTUwiuIAAr2ahveJtlmiO+QkOcSEMBnvBoCSjJFBhM
	 e7QTbQ6eicU/ZyjaC1Wc7iCMHngadAegXss0e3Z/fl9+IpPky3yN3CXHoMbM9oltbP
	 tDOz8HOzN1sh7+9wu7Zq6NMt8jXpMaiym+j9q9XgiJvU8GuZGWKzY1NMuDuGobTPFG
	 HFdUuEKFyILKpw5znKwbIx7FIUGYSolnz5y0wGao/6R66v3i9MHl7ePldgUZXp8BvQ
	 ofL6iT6S8ySLg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] tools/sched_ext: Add SCX_OPS_CID_OPEN for cid-form schedulers
Date: Sat, 18 Jul 2026 00:10:28 -1000
Message-ID: <20260718101029.725350-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718101029.725350-1-tj@kernel.org>
References: <20260718101029.725350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_OPS_OPEN() clears compat-gated ops fields which the running kernel
lacks. The clears dereference cpu-form member names and compile for
cid-form skeletons only because both ops structs currently name their
cgroup ops identically, which an upcoming rename will end. No load-time
fix-up can apply to a cid-form scheduler anyway as the cid form postdates
every compat-gated op.

Factor the skeleton open path out of SCX_OPS_OPEN() and add
SCX_OPS_CID_OPEN() which uses only that shared part. Switch scx_qmap, the
only cid-form scheduler, over.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.h | 30 ++++++++++++++++++++--------
 tools/sched_ext/scx_qmap.c           |  2 +-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 23d9ef3e4c9d..7757252d52e2 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -154,7 +154,7 @@ static inline long scx_hotplug_seq(void)
  * struct sched_ext_ops can change over time. Two complementary mechanisms
  * keep BPF schedulers built against newer headers running on older kernels:
  *
- * 1. Load-time fix-up (this macro). For each optional ops callback or field
+ * 1. Load-time fix-up (SCX_OPS_OPEN()). For each optional ops callback or field
  *    added to struct sched_ext_ops, an explicit stanza below probes the
  *    running kernel's BTF via __COMPAT_struct_has_field() and, if the field
  *    is missing, clears it in the in-memory struct_ops (with a warning to
@@ -176,16 +176,23 @@ static inline long scx_hotplug_seq(void)
  * - v6.19: ops.cgroup_set_idle()
  * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
  */
+#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct) ({			\
+	struct __scx_name *__oskel;						\
+										\
+	SCX_BUG_ON(!__COMPAT_struct_has_field(__ops_struct, "dump"),		\
+		   __ops_struct ".dump() missing, kernel too old?");		\
+										\
+	__oskel = __scx_name##__open();						\
+	SCX_BUG_ON(!__oskel, "Could not open " #__scx_name);			\
+	__oskel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
+	SCX_ENUM_INIT(__oskel);							\
+	__oskel;								\
+})
+
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
 										\
-	SCX_BUG_ON(!__COMPAT_struct_has_field("sched_ext_ops", "dump"),		\
-		   "sched_ext_ops.dump() missing, kernel too old?");		\
-										\
-	__skel = __scx_name##__open();						\
-	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
-	__skel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();		\
-	SCX_ENUM_INIT(__skel);							\
+	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops");	\
 	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
 	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
 		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
@@ -214,6 +221,13 @@ static inline long scx_hotplug_seq(void)
 	__skel; 								\
 })
 
+/*
+ * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
+ * every op the load-time fix-ups above handle, so none of them apply.
+ */
+#define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
+	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
+
 /*
  * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
  * that scx_prog_sched() can determine which scheduler a BPF program belongs
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 46892b4bb448..ddb524b4946c 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
 	}
 restart:
 	optind = 1;
-	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
+	skel = SCX_OPS_CID_OPEN(qmap_ops, scx_qmap);
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
-- 
2.55.0

