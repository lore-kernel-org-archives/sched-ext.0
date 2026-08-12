Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D5388E4D;
	Wed, 12 Aug 2026 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569373; cv=none; b=UYqTxwkKARBQWb2lhSY44JQ9EeA/+6ABG6ee/XYkPGpkhM8KS3+2EB0zIhhbAcNKCuIrrR/O/6uz33xGN6p/G5xNHWsRsXlHmqcG4UihgCa1uoUaiyTEHNZN57zmrKg3TbWIdV6xygt4dAZ3ctn75sQnXE9rwSLw0vaC7SCRRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569373; c=relaxed/simple;
	bh=wd+S0XqTzLyncnsdMy6MCwpneO1VnlFyhXPV1Gi8UOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9uIBK/H1AQQVW0k3Ra6X7rnt4pDfTroIi11CQfy/tBawt7oDp8HI+pCLVjPi6ThjoO7kN/qk6MJX+tCJD6H5kJ8+KmPraXbF2s1Xr7EF3LvL8oJB4a8TpmyoFpVhIW4wCNFkYW6AQmZj1FP/sg6fRdrhCNZP3DdnbJDyiCBd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPzwzi4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPzwzi4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F751F00A3A;
	Wed, 12 Aug 2026 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786569371;
	bh=6s3hVryl7Hr+Mjy1Bngzze7TTWq+XkCV2ez5bOtnMX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPzwzi4GRosxYJdxG2lKyCIh7XuW4mIayBVD8wiahsKo9SCMj+Z41VS6DjlfLktRL
	 Up29MIP4r8Sc98tRkvGuMUdvAouwl9H7yTn8UvfhBiFTeTpx4Mb/FhtsI50tU4nilS
	 vvT3TvTasuz2mTbUmrC5sridycf2LcHX+Iwi6eushUSCkoiwj3OoU2WAXSLsrilfZL
	 fxJJODniRFeMYDkqBRXd1dRuWyMcvgV9fsswX+SU7M2qNyxajeDlEYu9FKb+Fq1bjh
	 iDU38j4U8Sclxg9zDWzJT75UzUKbB6Dizh+GCDgmLOwmU062bGH6xkpXuBCQJArvXU
	 MLx+bV8kQHorw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Pass kernel arena pointers to ops_cid callbacks
Date: Wed, 12 Aug 2026 11:16:07 -1000
Message-ID: <20260812211609.2495583-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812211609.2495583-1-tj@kernel.org>
References: <20260812211609.2495583-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid-form set_cmask() and sub_caps_updated() callbacks receive cmasks
that the kernel builds in the arena, and the kernel converts the kernel
addresses to the BPF arena pointer form by hand before each call.

BPF now translates between BPF and kernel arena addresses for __arena
arguments. Tag the arguments __arena in the cfi stubs and the ops_cid member
declarations and pass the kernel arena addresses directly, dropping the
manual scx_kaddr_to_arena() conversions and the now-unused helper. The
delivered value is unchanged and existing BPF-side code works as before.

The arena argument address translation is currently implemented only on
x86-64. cid-form schedulers implementing these callbacks load only there for
now.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/arena.c    |  3 +--
 kernel/sched/ext/ext.c      | 14 +++++++-------
 kernel/sched/ext/internal.h | 19 ++++---------------
 kernel/sched/ext/sub.c      |  4 +---
 4 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/ext/arena.c b/kernel/sched/ext/arena.c
index b0e6a0be4913..f7a9f633f435 100644
--- a/kernel/sched/ext/arena.c
+++ b/kernel/sched/ext/arena.c
@@ -6,8 +6,7 @@
  *
  * Each chunk added to @sch->arena_pool comes from one
  * bpf_arena_alloc_pages_sleepable() call and is registered at the
- * kernel-side mapping address. Callers translate to the BPF-arena form
- * themselves if needed.
+ * kernel-side mapping address.
  *
  * Allocations grow the pool on demand. Underlying arena pages are released
  * when the arena map itself is torn down.
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 61b156d7fc4b..c12327b6d541 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -467,13 +467,14 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 
 		/*
 		 * Build the per-cpu arena cmask from kernel geometry via @ref,
-		 * never reading its BPF-writable header, and hand BPF the arena
-		 * address. The rq lock makes this cpu the sole kernel writer.
+		 * never reading its BPF-writable header. set_cmask()'s __arena
+		 * argument takes the kernel address and the struct_ops
+		 * trampoline rebases it into BPF's arena pointer form. The rq
+		 * lock makes this cpu the sole kernel writer.
 		 */
 		scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
 		scx_cmask_ref_from_cpumask(&ref, cpumask);
-		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
-				     scx_kaddr_to_arena(sch, kern_va));
+		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task, kern_va);
 	} else {
 		SCX_CALL_OP_TASK(sch, set_cpumask, rq, task, cpumask);
 	}
@@ -8339,9 +8340,8 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
  * fresh stubs, set_cmask due to an argument type difference and the sub-sched
  * notifiers because no cpu-form stub exists to reuse.
  */
-static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
-					 const struct scx_cmask *cmask) {}
-static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask, u64 caps) {}
+static void sched_ext_ops_cid__set_cmask(struct task_struct *p, const struct scx_cmask *cmask__arena) {}
+static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask__arena, u64 caps) {}
 static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
 
 static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b699e7c1103f..35b5bf8c5c66 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1049,7 +1049,7 @@ struct sched_ext_ops_cid {
 				   struct task_struct *b);
 	void (*set_weight)(struct task_struct *p, u32 weight);
 	void (*set_cmask)(struct task_struct *p,
-			   const struct scx_cmask *cmask);
+			   const struct scx_cmask *cmask__arena);
 	void (*update_idle)(s32 cid, bool idle);
 	s32 (*init_task)(struct task_struct *p,
 			  struct scx_init_task_args *args);
@@ -1075,7 +1075,7 @@ struct sched_ext_ops_cid {
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 	s32 (*sub_attach)(struct scx_sub_attach_args *args);
 	void (*sub_detach)(struct scx_sub_detach_args *args);
-	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
+	void (*sub_caps_updated)(const struct scx_cmask *cmask__arena, u64 caps);
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 	void (*cid_online)(s32 cid);
 	void (*cid_offline)(s32 cid);
@@ -1534,8 +1534,7 @@ struct scx_sched {
 	 *
 	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
 	 * at the kernel-side mapping address. @arena_kern_base is the start
-	 * of the arena's kern_vm range. See scx_arena_to_kaddr() and
-	 * scx_kaddr_to_arena().
+	 * of the arena's kern_vm range. See scx_arena_to_kaddr().
 	 */
 	struct bpf_map		*arena_map;
 	struct gen_pool		*arena_pool;
@@ -1544,7 +1543,7 @@ struct scx_sched {
 	/*
 	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
 	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va
-	 * and hands BPF its arena pointer via scx_kaddr_to_arena().
+	 * and passes it to the callback's __arena argument.
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
 
@@ -1654,16 +1653,6 @@ static inline void *scx_arena_to_kaddr(struct scx_sched *sch, const void *bpf_pt
 	return (void *)(sch->arena_kern_base + (u32)(uintptr_t)bpf_ptr);
 }
 
-/**
- * scx_kaddr_to_arena - Translate a kernel arena address to its BPF form
- * @sch: scheduler whose arena hosts @kaddr
- * @kaddr: kernel-side arena address, supplied by trusted kernel code
- */
-static inline void *scx_kaddr_to_arena(struct scx_sched *sch, const void *kaddr)
-{
-	return (void *)((uintptr_t)kaddr - sch->arena_kern_base);
-}
-
 enum scx_wake_flags {
 	/* expose select WF_* flags as enums */
 	SCX_WAKE_FORK		= WF_FORK,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 3bd12c1ff0a3..0978581d8c8e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -870,9 +870,7 @@ static void caps_updated_deliver(struct list_head *to_deliver)
 				break;
 
 			/* caps != 0 only when deliverable (has_op, above) */
-			SCX_CALL_OP(sch, sub_caps_updated, NULL,
-				    scx_kaddr_to_arena(sch, cu->cmask_arena_out),
-				    caps);
+			SCX_CALL_OP(sch, sub_caps_updated, NULL, cu->cmask_arena_out, caps);
 		}
 	}
 }
-- 
2.55.0

