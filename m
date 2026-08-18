Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A3429033;
	Tue, 18 Aug 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069089; cv=none; b=erCYzc+PxB2DOBQhoS6jRMX5+LHquiU9h4OemY2Lnu3uZzOgd7XxvFX7yw2YL/IZxNR2sZf9mesQzdSdYIpIkkxUlutqUTEOOh5WnrlBM2BiKfIVxMILyPc8dMoAfizZe2L8Nfs1iAVFr5J75MA4wIB0xnTnZlIgqWn2ocsdM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069089; c=relaxed/simple;
	bh=9Rb4U7oqr2k1em1EGiJEyii4jDzpCvm8OV7ZTsUZU5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnD9csgiXMXArRZlYjgzipFVo7ahwmABaVwijY30oth2AM3bGAUEJXURFBaqCtBYjUWZxoQngzrGJDQ2Jqv6vLnpgVQ1jLWQa3CC3jZcYXvbKbcYAwJvvZyYo2jvIuCWk2DMH7hm/ohrMtbSmr1K7Pw4BvS9j9e/aZr4duTvolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z9zBZais; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z9zBZais"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=QJWe2PryGb/+mAp12hGd6NgaJEPJJsvfVGiAbEYPFsA=; b=
	Z9zBZaiski4Y3Rie8p0XhFiswllo7GyePL5YgvjaH0bTUrDr++WOk2vbEww/jOO+hJ35k1spdxXQv
	xiTI/u6QHNv/zeg2WxMXCROx8Fb8omBSEQn7GxnsZ5fKJlKXFWbkdV1izdUpAJpuJ7a+3Jk7sL0E3
	YPRjtPomIjPLBGODYQX88mlOBR+dpDjzNW92v+1vtX5hC3T1iHeH0FU6x6IPM4DhB6kvpBoV4N+rb
	85pja5VDVFRbdd16oi3hIfE6Z4MU0J4fT6BYK8y/xGyoCZpGKZTWTryvAFUZETj6zNiN4Hy3q6aVP
	CYQuTsch+gEtO2a/7KAyqMEQdZA2Aak/KA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wwMIm-005hJ4-F9; Tue, 18 Aug 2026 18:04:37 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: allow ops.cgroup_set_bandwidth() to be sleepable
Date: Wed, 19 Aug 2026 01:04:29 +0900
Message-ID: <20260818160429.932265-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops.cgroup_set_bandwidth() is delivered from scx_group_set_bandwidth(),
which runs from the cpu.max cgroup interface write path (tg_set_bandwidth())
in process context. scx_group_set_bandwidth() holds
percpu_down_read(&scx_cgroup_ops_rwsem), whose read side may sleep.
The call site is therefore sleepable, like ops.cgroup_init().

bpf_scx_check_member() rejects a sleepable program on any member not on its
allow-list, so a BPF scheduler cannot allocate -- which is sleepable -- when
a cgroup gains a cpu.max limit at runtime; it must instead pre-reserve memory
for a callback that cannot allocate. Add cgroup_set_bandwidth() to the
allow-list so the callback can allocate on demand, and document that it may
block.

A scheduler must decide at load time whether to mark the callback sleepable,
but the allow-list entry is a verifier property with no symbol to probe. Add
a compatibility marker whose presence in the kernel's BTF lets userspace detect
this support: DEFINE_SCX_COMPAT_MARKER() emits an empty, callerless function,
here scx_compat_marker_cgroup_set_bandwidth_may_sleep(). It is __used
__retain so neither the compiler nor the linker (under
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) drops it. The markers share the
scx_compat_marker_ prefix and are collected near the end of ext.c so more
can be added as further capabilities appear.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
Change in v2:
- Mark the capability marker __retain in addition to __used so the linker
  does not garbage-collect it under CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
  (cf. __bpf_kfunc).
- Give the markers a shared scx_compat_marker_ prefix via a new
  DEFINE_SCX_COMPAT_MARKER() helper, collected near the module init code at
  the end of ext.c so future markers live in one place.
---
 kernel/sched/ext/ext.c      | 14 ++++++++++++++
 kernel/sched/ext/internal.h | 23 ++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..b646711a45fe 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8079,6 +8079,7 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, cgroup_init):
 	case offsetof(struct sched_ext_ops, cgroup_exit):
 	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
 #endif
 	case offsetof(struct sched_ext_ops, cpu_online):
 	case offsetof(struct sched_ext_ops, cpu_offline):
@@ -11041,3 +11042,16 @@ static int __init scx_init(void)
 	return 0;
 }
 __initcall(scx_init);
+
+/*
+ * Compatibility markers for userspace. Existence of a marker function
+ * represents that the kernel supports that sched-ext feature.
+ */
+
+/*
+ * scx_compat_marker_cgroup_set_bandwidth_may_sleep: advertises that
+ * ops.cgroup_set_bandwidth() may be implemented as a sleepable callback.
+ */
+#ifdef CONFIG_EXT_GROUP_SCHED
+DEFINE_SCX_COMPAT_MARKER(cgroup_set_bandwidth_may_sleep);
+#endif	/* CONFIG_EXT_GROUP_SCHED */
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d90..53e136a47924 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -753,7 +753,7 @@ struct sched_ext_ops {
 	 * @burst_us: bandwidth control burst
 	 *
 	 * Update @cgrp's bandwidth control parameters. This is from the cpu.max
-	 * cgroup interface.
+	 * cgroup interface. This operation may block.
 	 *
 	 * @quota_us / @period_us determines the CPU bandwidth @cgrp is entitled
 	 * to. For example, if @period_us is 1_000_000 and @quota_us is
@@ -2001,6 +2001,27 @@ struct scx_bstr_buf {
 	char			line[SCX_EXIT_MSG_LEN];
 };
 
+/* Internal helper for DEFINE_SCX_COMPAT_MARKER(). */
+#define DECLARE_SCX_COMPAT_MARKER(func)						\
+	extern void scx_compat_marker_##func(void)
+
+/**
+ * DEFINE_SCX_COMPAT_MARKER() - define a userspace capability marker
+ * @func: marker suffix; the defined symbol is scx_compat_marker_@func
+ *
+ * Emit an empty, callerless function that is retained in the kernel's BTF.
+ * Its presence is part of the kernel<->userspace contract: userspace probes
+ * scx_compat_marker_@func (e.g. via BTF) to detect that this kernel supports
+ * the corresponding feature.
+ *
+ * The leading declaration suppresses the missing-prototype warning; the
+ * trailing declaration consumes the semicolon at the use site.
+ */
+#define DEFINE_SCX_COMPAT_MARKER(func)						\
+	DECLARE_SCX_COMPAT_MARKER(func);					\
+	__used __retain void scx_compat_marker_##func(void) {}			\
+	DECLARE_SCX_COMPAT_MARKER(func)
+
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
-- 
2.55.0

