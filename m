Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD7468C02;
	Mon, 17 Aug 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986602; cv=none; b=sJjDvf7cSKoRxAvL/0XR3S8WAitiTFGLPU3UFWHLquH5uskDFPS3yQ11X5PsQP7q5cy/7KxcKV0thtcIJc76Hrprp/cxa/8WV7ld5sSeYa8l6t1ngyukGvAMFELsKv7fiSHKRZp5K/1pGMFQFntDn/l4PiUebhwPAu+laSDUYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986602; c=relaxed/simple;
	bh=pxK5FLzofsL1EsUG8GyqXqB3OyxyPQjsHcGvnbKd5+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S48PySJFyYhfGBTYunRTRXD5ZGmq6iMWMkLto/sDia/bIiTSqhWoYahwaVDdNFnsRXpMJ3n9NPSyI1vn92b5zp04khAzVEKIRKFX3KDe2DoCpAvW6n357Xgua2D8mz+txe6mXRZwRNknYGxRp4EQTFvWspnJz2SKgtv3kC6Y/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VUJ2SjZP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VUJ2SjZP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=0ou//kEwQ6SaKepK4qgGqGKvr1r5rIF+tCIrIx+4Gfw=; b=
	VUJ2SjZPxwy+s16D+C+ahIEe9ioZEPjZJ+Ax3Ro9cSkIvmgP6g0kMkC078fLr2BHUbtGauafZHcbU
	f1V4gtIzPeZps66DJ1AyHcVa839u2N1eYudfBHULbSZINuy0cSXmd3H4evE3C7cCU98hf08Iz0QBw
	EIh0UyrQNfaDe3gF+3DWrwsMkzmCCThC1jwOOA6TG0Or/tH1i/7GuP60cJcoR1cnjCRFEIlxVaskr
	v1cFb9FKdAmKz46a8+oU1KpxITa+6WCTV6aTdbY+LQXybeLSvzw7KsmpsjSsRWENMbIGdfWo3XRqD
	aX+NEnAdBL/XYGlYN3QYfa2rCm0bpye83g==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ww0qL-004pOg-Mk; Mon, 17 Aug 2026 19:09:50 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: allow ops.cgroup_set_bandwidth() to be sleepable
Date: Tue, 18 Aug 2026 02:09:41 +0900
Message-ID: <20260817170941.668571-1-changwoo@igalia.com>
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
in process context. tg_set_cfs_bandwidth() has already returned by then, so
its cpus_read_lock and cfs_constraints_mutex are released, and the only lock
held is percpu_down_read(&scx_cgroup_ops_rwsem), whose read side may sleep.
The call site is therefore sleepable, like ops.cgroup_init().

bpf_scx_check_member() rejects a sleepable program on any member not on its
allow-list, so a BPF scheduler cannot allocate -- which is sleepable -- when
a cgroup gains a cpu.max limit at runtime; it must instead pre-reserve memory
for a callback that cannot allocate. Add cgroup_set_bandwidth() to the
allow-list so the callback can allocate on demand, and document that it may
block.

A scheduler must decide at load time whether to mark the callback sleepable,
but the allow-list entry is a verifier property with no symbol to probe. Add
scx_cgroup_set_bandwidth_may_sleep() as a marker whose presence in the
kernel's BTF lets userspace detect this support; it has no callers and does
nothing.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext/ext.c      | 10 ++++++++++
 kernel/sched/ext/ext.h      |  1 +
 kernel/sched/ext/internal.h |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..e25a2e9f4eca 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4960,6 +4960,15 @@ void scx_group_set_bandwidth(struct task_group *tg,
 
 	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
+
+/*
+ * Capability marker for userspace. The sleepable allowance for
+ * ops.cgroup_set_bandwidth() (see bpf_scx_check_member()) is a verifier
+ * property with no other symbol a scheduler can probe, so this no-op function
+ * exists solely so its presence in the kernel's BTF can be detected. It has no
+ * callers; __used keeps it from being optimized away.
+ */
+__used void scx_cgroup_set_bandwidth_may_sleep(void) {}
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
 #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
@@ -8079,6 +8088,7 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, cgroup_init):
 	case offsetof(struct sched_ext_ops, cgroup_exit):
 	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
 #endif
 	case offsetof(struct sched_ext_ops, cpu_online):
 	case offsetof(struct sched_ext_ops, cpu_offline):
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08..e6fcfadc25aa 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -81,6 +81,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
 void scx_group_set_idle(struct task_group *tg, bool idle);
 void scx_group_set_bandwidth(struct task_group *tg, u64 period_us, u64 quota_us, u64 burst_us);
+void scx_cgroup_set_bandwidth_may_sleep(void);
 #else	/* CONFIG_EXT_GROUP_SCHED */
 static inline void scx_tg_init(struct task_group *tg) {}
 static inline int scx_tg_online(struct task_group *tg) { return 0; }
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d90..e2d553d13c49 100644
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
-- 
2.55.0

