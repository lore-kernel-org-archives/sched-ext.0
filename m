Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797667;
	b=wmFGYxw7Q0+Kf9/aylKuAAGBgG9OORQ2jgxXSBclYt+BjMGhD9l0XdDUsagx6hvVdbgH
	 iHaT08Vpe1rYA2Oa0jOer6IIfOU1obJQ3i/m/cXbJnsjvv4dXNasyMfhCJuvZmjLFUyeC
	 38zaEvzSLeOhkeVrnJjovjBLkiPDskpVfurP2+QFKJcF5qOsg9kNvHwZ+aKS/Omy6E+Tn
	 RNDADLvbus1JJC7DHtG0HfJaxyASwzQqBZvYmCF25epkfGcv5gJP8pMlSwogaXcuvi1nA
	 37p8bDOEwgZCK5Y9MsBnzwNe/tOnfjSNfEQ/tNeOG8nNAeH2z4OEK+O8RCSkfUYht0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+1O4H5VmUHljqTHJZZVUdnem3u7vjClv0WTXcZlZrB0=;
	b=vO4Gn4IygcNu2HADoBiMlFzRDpglFIEMPeSb+T9aciJCvkpVfDlQ/ogehzyohYGuwbms
	 lBQb2eFyGQP2ea00w9+UPJhnruWXAzw+bdnPbkjFUBRA9zEWAE7WXLKpjQek4OcQzz/AO
	 19QFZGto2jt3iSre5R0V6MIFAfpoRVx/zYwkc1/IvErdwIUDx3FxnxeOQk+1Bf9bDccDC
	 HXlwfskxJl0IENU6kxlzvd/RpHO0aUKY/+HFWFv2Ux+C9ac8d7Y0PwZVwEdsaPQREv4Fe
	 D7P4LdELDTVJIiFJXHsIW4fagd5WeI9I25xqPSAHT18y3mdN8hglT2yrrEYsDHd54vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQm7mIIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EC60A263B;
	Fri, 23 Oct 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQm7mIIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B56B1F01828;
	Fri, 23 Oct 2026 23:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797666;
	bh=+1O4H5VmUHljqTHJZZVUdnem3u7vjClv0WTXcZlZrB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQm7mIIAw5pE8aVLvYCFhlijpaum4MS3zGcMhrMUryxkASKAn7Gje3zqPqjWe6nwM
	 lFgz9n3aMjp6BwMOpzNGh3g/x+K6BA+utzNGsE5sByI1DwaaACIksR5oNyPiRXXnrX
	 DJ/GnK1fwc8t9EvD7ZeUU74ESVWNLm16MNNmjRGqGCnO3AxlK0y2xhU59FxySkT9Mj
	 uDZzlja4w2y39gBA7JlKa3Qnt+grChgiEuZdIncMJxpecSfLLPoIK+HO3hqBHzMIke
	 d7e1zas9VDjlgMfeconoPBQ43+gbGVmVu0mhunmIMA0SO3URfU5OotuJM8cripIXJC
	 KzT3IdmABm/0Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Sync common and compat headers from the scx repo
Date: Fri, 23 Oct 2026 13:21:01 -1000
Message-ID: <20261023232102.1124938-4-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
References: <20261023232102.1124938-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync common.bpf.h, compat.bpf.h and bpf_arena_common.bpf.h with the scx repo
at a094b6ec68c9 ("scheds/include: Sync with kernel sched_ext/for-7.5
(b1c2a6b0d90d)"), which accumulated the following since the last sync:

- common.bpf.h gained div_round_up(), the bpf_local_irq_save() and
  bpf_local_irq_restore() declarations for scx's irqsave spinlock guard, and
  the bpf_call_rcu() declaration, whose bpf_rcu_callback_t came into for-7.5
  with the bpf-next-7.4 merge.

- The scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() compat
  wrappers return the kfunc's bool instead of dropping it.

- bpf_arena_common.bpf.h has an opt-in arena mode, SCX_ARENA_SCALAR, for
  loaders that set BPF_F_ARENA_SCALAR.

scx_flatcg.bpf.c defined a static div_round_up() of its own, which the macro
of the same name now breaks. Drop it, as the macro computes the same value.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../include/scx/bpf_arena_common.bpf.h        | 23 ++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h      |  9 ++++++++
 tools/sched_ext/include/scx/compat.bpf.h      | 16 ++++++-------
 tools/sched_ext/scx_flatcg.bpf.c              |  5 ----
 4 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
index 2043d66940ea..fa6dd9c9c295 100644
--- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -14,7 +14,28 @@
  */
 #endif
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#if defined(SCX_ARENA_SCALAR)
+/*
+ * Arena pointers without address_space(1).
+ *
+ * Under BPF_F_ARENA_SCALAR a load or store through a plain scalar is an arena
+ * access: the JIT adds the arena base to the address's low 32 bits. A pointer
+ * loaded from arena memory is a scalar to the verifier anyway, so the tag and
+ * the casts LLVM emits for it can go, which makes the code a lot tidier.
+ *
+ * On a global, address_space(1) does two things: it places the variable in
+ * .addr_space.1, which libbpf maps into the arena, and it makes LLVM cast every
+ * access to it. SEC(".addr_space.1") does only the first, which is all that is
+ * still needed. An object that lives in the arena is therefore declared
+ * __arena_global, since __arena on it now places nothing.
+ */
+#define __arena
+#define __arena_global SEC(".addr_space.1")
+#define cast_kern(ptr)
+#define cast_user(ptr)
+/* the loader keys BPF_F_ARENA_SCALAR on this marker */
+const volatile bool __SCX_MARKER_arena_scalar __weak = true;
+#elif defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
 #ifndef __arena
 #define __arena __attribute__((address_space(1)))
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 9376d5704a47..4e7836526684 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -29,6 +29,8 @@
 #include "bpf_arena_common.bpf.h"
 #include "const-defs.h"
 
+#define div_round_up(a, b) (((a) + (b) - 1) / (b))
+
 #define PF_IDLE				0x00000002	/* I am an IDLE thread */
 #define PF_IO_WORKER			0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER			0x00000020	/* I'm a workqueue worker */
@@ -127,6 +129,9 @@ void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps, const struct scx_cmask __arena
 s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask __arena *out__arena) __ksym __weak;
 s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 
+int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
+		 bpf_rcu_callback_t callback) __ksym __weak;
+
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
  * within bpf_for_each() loops.
@@ -645,6 +650,10 @@ static inline bool is_migration_disabled(const struct task_struct *p)
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+/* irq */
+void bpf_local_irq_save(unsigned long *flags) __ksym __weak;
+void bpf_local_irq_restore(unsigned long *flags) __ksym __weak;
+
 /* resilient qspinlock */
 int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __ksym __weak;
 void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 254882bd8ce6..3520a749f8ce 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -462,20 +462,20 @@ scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
 bool scx_bpf_task_set_slice___new(struct task_struct *p, u64 slice) __ksym __weak;
 bool scx_bpf_task_set_dsq_vtime___new(struct task_struct *p, u64 vtime) __ksym __weak;
 
-static inline void scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+static inline bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
 {
 	if (bpf_ksym_exists(scx_bpf_task_set_slice___new))
-		scx_bpf_task_set_slice___new(p, slice);
-	else
-		p->scx.slice = slice;
+		return scx_bpf_task_set_slice___new(p, slice);
+	p->scx.slice = slice;
+	return true;
 }
 
-static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+static inline bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 {
 	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
-		scx_bpf_task_set_dsq_vtime___new(p, vtime);
-	else
-		p->scx.dsq_vtime = vtime;
+		return scx_bpf_task_set_dsq_vtime___new(p, vtime);
+	p->scx.dsq_vtime = vtime;
+	return true;
 }
 
 /* v7.4: Add scx_bpf_task_set_lazy_resched(). */
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 5e6abd0bccb3..1d168d492203 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -132,11 +132,6 @@ struct {
 /* gets inc'd on weight tree changes to expire the cached hweights */
 u64 hweight_gen = 1;
 
-static u64 div_round_up(u64 dividend, u64 divisor)
-{
-	return (dividend + divisor - 1) / divisor;
-}
-
 static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
 	struct cgv_node *cgc_a, *cgc_b;
-- 
2.56.0

