Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE377231A3B;
	Sun, 21 Jun 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059429; cv=none; b=ZVjkUKqMPiEjKXj7BzfiQ7xCPgdoeZKpdfPEL2obXdLATZj/m6kx5a/YIPAo5Ck4MG0w/cRMQz6/v8vHRazopgsuVfvl9v1/6tcglOm5vORuL2zeiLGk/MZLv/m2ppJmGanLe4sGF8PzbwNfgzvrnabx3A+naP0duLybQnzspVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059429; c=relaxed/simple;
	bh=r95uceunPpSAULJctxLAsoT0NTNSxqcsA+XE2FImUTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGjyitbBhQyAsEAf4qiCnUfmYu+Vom5jMbWLzzh+2tbPDoPbeUNZfIeY4GQ5Bdj8kW3aFNDqycRef2wDSIWs8W4iGpfxwy4UiS4zUAM2X8Rg4DV1q697a0YnkDGYErKUNX8TzvYn6OBjpZFgyFkNh/tt/fFzQlZd70V+pUCG7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WedGnkes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WedGnkes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2F31F000E9;
	Sun, 21 Jun 2026 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782059427;
	bh=QVz7y2Fm20ZUDvaQ0gxxKs0hccfq9hbTXdbkTvcRx4Y=;
	h=From:To:Cc:Subject:Date;
	b=WedGnkesbApC4xDlp0XHKtmX/fPhBmHJ4bdwJ3O71CM6yWKbd9tEjpzFVqfg167t3
	 8LWGeH7pW04vEilhM9h0yYfVTss9jp7w6/8rMXpHFxSF/NuPXJnHyYr7wSg8WFo6Tm
	 AodlKUHX1NeHA+kcEaRh/JOq3onnT/b0A25jkrJpk6wRVdEjUP1FV7XsmI88koKd6g
	 IzEgxw19WsVqBqS/Bb05rAj6yLTiv/ev4FM7bkXthBRR/TD/ymlDIYiUs9EdZ2tnHJ
	 +5jfey02yPbqHI0XdcvGFflk/aHwHvMf3RU3iw1yyh+7owI/Phh7kMt65RMm3DiH0i
	 ynHfyNzWHFzfw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: [PATCH sched_ext/for-7.2] sched_ext: Move sources under kernel/sched/ext/
Date: Sun, 21 Jun 2026 06:30:26 -1000
Message-ID: <20260621163026.434856-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sched_ext sources had grown to ten ext* files directly under
kernel/sched/. Move them into a new kernel/sched/ext/ subdirectory and drop
the now-redundant ext_ prefix. ext.c/h keep their names.

  kernel/sched/ext.{c,h}       -> kernel/sched/ext/ext.{c,h}
  kernel/sched/ext_internal.h  -> kernel/sched/ext/internal.h
  kernel/sched/ext_types.h     -> kernel/sched/ext/types.h
  kernel/sched/ext_idle.{c,h}  -> kernel/sched/ext/idle.{c,h}
  kernel/sched/ext_cid.{c,h}   -> kernel/sched/ext/cid.{c,h}
  kernel/sched/ext_arena.{c,h} -> kernel/sched/ext/arena.{c,h}

The include paths in build_policy.c and sched.h, the MAINTAINERS glob, and a
few documentation and comment references are updated to match. No code or
symbol changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
I'm applying this to sched_ext/for-7.2 and sending it to Linus before the
merge window closes so that for-7.2-fixes and for-7.3 don't diverge
unnecessarily.

Thanks.

 Documentation/scheduler/sched-ext.rst          |  8 ++++----
 MAINTAINERS                                    |  2 +-
 kernel/sched/build_policy.c                    | 18 +++++++++---------
 kernel/sched/{ext_arena.c => ext/arena.c}      |  0
 kernel/sched/{ext_arena.h => ext/arena.h}      |  0
 kernel/sched/{ext_cid.c => ext/cid.c}          |  2 +-
 kernel/sched/{ext_cid.h => ext/cid.h}          |  0
 kernel/sched/{ => ext}/ext.c                   |  2 +-
 kernel/sched/{ => ext}/ext.h                   |  0
 kernel/sched/{ext_idle.c => ext/idle.c}        |  0
 kernel/sched/{ext_idle.h => ext/idle.h}        |  0
 .../sched/{ext_internal.h => ext/internal.h}   |  0
 kernel/sched/{ext_types.h => ext/types.h}      |  0
 kernel/sched/sched.h                           |  2 +-
 tools/sched_ext/include/scx/cid.bpf.h          |  6 +++---
 15 files changed, 20 insertions(+), 20 deletions(-)
 rename kernel/sched/{ext_arena.c => ext/arena.c} (100%)
 rename kernel/sched/{ext_arena.h => ext/arena.h} (100%)
 rename kernel/sched/{ext_cid.c => ext/cid.c} (99%)
 rename kernel/sched/{ext_cid.h => ext/cid.h} (100%)
 rename kernel/sched/{ => ext}/ext.c (99%)
 rename kernel/sched/{ => ext}/ext.h (100%)
 rename kernel/sched/{ext_idle.c => ext/idle.c} (100%)
 rename kernel/sched/{ext_idle.h => ext/idle.h} (100%)
 rename kernel/sched/{ext_internal.h => ext/internal.h} (100%)
 rename kernel/sched/{ext_types.h => ext/types.h} (100%)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index c4f59c08d8a4..4b1ffd03f516 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -114,7 +114,7 @@ Each running scheduler also exposes a per-scheduler ``events`` file under
     SCX_EV_INSERT_NOT_OWNED 0
     SCX_EV_SUB_BYPASS_DISPATCH 0
 
-The counters are described in ``kernel/sched/ext_internal.h``; briefly:
+The counters are described in ``kernel/sched/ext/internal.h``; briefly:
 
 * ``SCX_EV_SELECT_CPU_FALLBACK``: ops.select_cpu() returned a CPU unusable by
   the task and the core scheduler silently picked a fallback CPU.
@@ -496,11 +496,11 @@ Where to Look
 * ``include/linux/sched/ext.h`` defines the core data structures, ops table
   and constants.
 
-* ``kernel/sched/ext.c`` contains sched_ext core implementation and helpers.
+* ``kernel/sched/ext/ext.c`` contains sched_ext core implementation and helpers.
   The functions prefixed with ``scx_bpf_`` can be called from the BPF
   scheduler.
 
-* ``kernel/sched/ext_idle.c`` contains the built-in idle CPU selection policy.
+* ``kernel/sched/ext/idle.c`` contains the built-in idle CPU selection policy.
 
 * ``tools/sched_ext/`` hosts example BPF scheduler implementations.
 
@@ -557,7 +557,7 @@ ABI Instability
 The APIs provided by sched_ext to BPF schedulers programs have no stability
 guarantees. This includes the ops table callbacks and constants defined in
 ``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
-``kernel/sched/ext.c`` and ``kernel/sched/ext_idle.c``.
+``kernel/sched/ext/ext.c`` and ``kernel/sched/ext/idle.c``.
 
 While we will attempt to provide a relatively stable API surface when
 possible, they are subject to change without warning between kernel
diff --git a/MAINTAINERS b/MAINTAINERS
index d95d3ef77773..ebd76d0367ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24164,7 +24164,7 @@ S:	Maintained
 W:	https://github.com/sched-ext/scx
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
 F:	include/linux/sched/ext.h
-F:	kernel/sched/ext*
+F:	kernel/sched/ext/
 F:	tools/sched_ext/
 F:	tools/testing/selftests/sched_ext
 
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 067979a7b69e..d74b54f81992 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -61,15 +61,15 @@
 # include <linux/btf_ids.h>
 # include <linux/find.h>
 # include <linux/genalloc.h>
-# include "ext_types.h"
-# include "ext_internal.h"
-# include "ext_cid.h"
-# include "ext_arena.h"
-# include "ext_idle.h"
-# include "ext.c"
-# include "ext_cid.c"
-# include "ext_arena.c"
-# include "ext_idle.c"
+# include "ext/types.h"
+# include "ext/internal.h"
+# include "ext/cid.h"
+# include "ext/arena.h"
+# include "ext/idle.h"
+# include "ext/ext.c"
+# include "ext/cid.c"
+# include "ext/arena.c"
+# include "ext/idle.c"
 #endif
 
 #include "syscalls.c"
diff --git a/kernel/sched/ext_arena.c b/kernel/sched/ext/arena.c
similarity index 100%
rename from kernel/sched/ext_arena.c
rename to kernel/sched/ext/arena.c
diff --git a/kernel/sched/ext_arena.h b/kernel/sched/ext/arena.h
similarity index 100%
rename from kernel/sched/ext_arena.h
rename to kernel/sched/ext/arena.h
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext/cid.c
similarity index 99%
rename from kernel/sched/ext_cid.c
rename to kernel/sched/ext/cid.c
index 66944a7ef79d..aeaea88f34c5 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext/cid.c
@@ -71,7 +71,7 @@ static s32 scx_cid_arrays_alloc(void)
  * scx_cid_init - build the cid mapping
  * @sch: the scx_sched being initialized; used as the scx_error() target
  *
- * See "Topological CPU IDs" in ext_cid.h for the model. Walk online cpus by
+ * See "Topological CPU IDs" in cid.h for the model. Walk online cpus by
  * intersection at each level (parent_scratch & this_level_mask), which keeps
  * containment correct by construction and naturally splits a physical LLC
  * straddling two NUMA nodes into two LLC units. The caller must hold
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext/cid.h
similarity index 100%
rename from kernel/sched/ext_cid.h
rename to kernel/sched/ext/cid.h
diff --git a/kernel/sched/ext.c b/kernel/sched/ext/ext.c
similarity index 99%
rename from kernel/sched/ext.c
rename to kernel/sched/ext/ext.c
index 0db6fa2daea3..f229690a7898 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -513,7 +513,7 @@ do {										\
 } while (0)
 
 /*
- * Flipped on enable per sch->is_cid_type. Declared in ext_internal.h so
+ * Flipped on enable per sch->is_cid_type. Declared in internal.h so
  * subsystem inlines can read it.
  */
 DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext/ext.h
similarity index 100%
rename from kernel/sched/ext.h
rename to kernel/sched/ext/ext.h
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext/idle.c
similarity index 100%
rename from kernel/sched/ext_idle.c
rename to kernel/sched/ext/idle.c
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext/idle.h
similarity index 100%
rename from kernel/sched/ext_idle.h
rename to kernel/sched/ext/idle.h
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext/internal.h
similarity index 100%
rename from kernel/sched/ext_internal.h
rename to kernel/sched/ext/internal.h
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext/types.h
similarity index 100%
rename from kernel/sched/ext_types.h
rename to kernel/sched/ext/types.h
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7c2dea65edd..56acf502ba26 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4211,6 +4211,6 @@ DEFINE_CLASS(sched_change, struct sched_change_ctx *,
 
 DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
-#include "ext.h"
+#include "ext/ext.h"
 
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 9d89bb57e201..db247e42fb45 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * BPF-side helpers for cids and cmasks. See kernel/sched/ext_cid.h for the
+ * BPF-side helpers for cids and cmasks. See kernel/sched/ext/cid.h for the
  * authoritative layout and semantics. The BPF-side helpers use the cmask_*
  * naming (no scx_ prefix); cmask is the SCX bitmap type so the prefix is
  * redundant in BPF code. Atomics use __sync_val_compare_and_swap and every
@@ -33,7 +33,7 @@
 #endif
 
 /*
- * Mirrors SCX_CMASK_NR_WORDS in kernel/sched/ext_types.h. The u64 cast keeps
+ * Mirrors SCX_CMASK_NR_WORDS in kernel/sched/ext/types.h. The u64 cast keeps
  * the +63 from wrapping when @nr_cids is near U32_MAX, so cmask_reframe()
  * bounds-checking the result against alloc_words catches the overflow instead
  * of seeing a small value.
@@ -281,7 +281,7 @@ static __always_inline void cmask_zero(struct scx_cmask __arena *m)
 
 /*
  * BPF_-prefixed to avoid colliding with the kernel's anonymous CMASK_OP_*
- * enum in ext_cid.c, which is exported via BTF and reachable through
+ * enum in ext/cid.c, which is exported via BTF and reachable through
  * vmlinux.h.
  */
 enum {
-- 
2.54.0

