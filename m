Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9A3803F5;
	Thu,  4 Jun 2026 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567347; cv=none; b=dx3Ei3ssjNiLRbPdR7HSbPaw10pfBcamvsAXa8BzMlFBQRw4k0V3NDzJ22kLNmB55xNp9QI916NkVDOKFPox3AtXBLVOOSXmk+WOQLf/hBkJhuTO35rNotK9NYXbrBDCMW7RWtjvb9A8fmkP3cv7IbXGZTtJdbiwwwFCjfhNGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567347; c=relaxed/simple;
	bh=DyMUon2G2mWXj/xDOTycE7lJVXiEm68mVI9gWOWF6+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMCya1xkXU1LS8babufstlJkVlXt9zzv4TSe8PyZqBe+THoW/99UKYHXkUkuo0whP09HY+ltlbp1Y2mTikdEALxCcf5OIqa1CevGBX93qICfbXDaPtcI9uthqx9OSyCsiYKOrEbm9fNVgqS/8itHS7XkXbSHSRPbEwOirZeHtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJfoP71b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJfoP71b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F47F1F00893;
	Thu,  4 Jun 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780567344;
	bh=HY5XkVcghHJCTqVlAXNEkFZ4uHobheClGyJ5+okiTj8=;
	h=From:To:Cc:Subject:Date;
	b=NJfoP71by0+GUEnU8QppTpl8rHRzVjrlcWoGQs1xj6nWZEUe3Cgb/w7ID5LBiYHbL
	 xw5INmKbkflMmNeEQ4bq8g4HPAm1t9vol5F5jvaz5zkzgO5qhjZ5hW0n7yg0Pt4R49
	 ycIjCXEvStFlVS4lBAFyUuwWpaYx6vPlE5L7A34dfYYNqlaoDXaRHyn1DolCwfqygy
	 7mAimI5l+XjagG9cEr2tnHzKcJ6ljLHN2tCiHimwBriKY0//7asIHBXy6c5SEGws0c
	 NjGXKECXO9OCfX3qkpM2tqQbmedrN9N8MSQO8Ca4WRu8JRH1Sl3MvAH2KKRxLOHR7Q
	 rU5JRnL2VzJnw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.2] sched_ext: Add scx_arena_to_kaddr() / scx_kaddr_to_arena()
Date: Thu,  4 Jun 2026 00:02:23 -1000
Message-ID: <20260604100223.3831303-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translating between a BPF-arena pointer and its kernel-side address is just
an add or subtract of the arena's kern_vm start. More such translations are
coming, so cache that start on scx_sched as @arena_kern_base at arena attach
and wrap both directions. Convert the existing open-coded subtraction in
scx_call_op_set_cpumask().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 19 +++++++++----------
 kernel/sched/ext_internal.h | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62769abb553a..6567f626b3f0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -622,19 +622,13 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 
 	if (scx_is_cid_type()) {
 		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
-		unsigned long uaddr = (unsigned long)kern_va;
-
-		/* arena.o, which defines these, is built only on MMU && 64BIT */
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
-		uaddr -= bpf_arena_map_kern_vm_start(sch->arena_map);
-#endif
 		/*
-		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
-		 * holds the rq lock with IRQs disabled, which makes us the sole
-		 * user of the scratch area.
+		 * Build the per-CPU arena cmask and hand BPF its arena address.
+		 * Caller holds the rq lock with IRQs disabled, which makes us
+		 * the sole user of the scratch area.
 		 */
 		scx_cpumask_to_cmask(cpumask, kern_va);
-		sch->ops_cid.set_cmask(task, (struct scx_cmask *)uaddr);
+		sch->ops_cid.set_cmask(task, scx_kaddr_to_arena(sch, kern_va));
 	} else {
 		sch->ops.set_cpumask(task, cpumask);
 	}
@@ -6977,6 +6971,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	 * runs through scx_sched_free_rcu_work() which puts it.
 	 */
 	sch->arena_map = cmd->arena_map;
+	/* BPF arena is only available on MMU && 64BIT */
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+	if (sch->arena_map)
+		sch->arena_kern_base = bpf_arena_map_kern_vm_start(sch->arena_map);
+#endif
 	cmd->arena_map = NULL;
 	return sch;
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9bb65367f510..b04701190b23 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1118,17 +1118,18 @@ struct scx_sched {
 	 * progs. NULL on cpu-form.
 	 *
 	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
-	 * at the kernel-side mapping address. Grows on demand and pages are
-	 * not released until sched destroy.
+	 * at the kernel-side mapping address. @arena_kern_base is the start
+	 * of the arena's kern_vm range. See scx_arena_to_kaddr() and
+	 * scx_kaddr_to_arena().
 	 */
 	struct bpf_map		*arena_map;
 	struct gen_pool		*arena_pool;
+	uintptr_t		arena_kern_base;
 
 	/*
 	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
-	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va;
-	 * the BPF-arena uaddr handed to BPF is recovered by subtracting the
-	 * arena's kern_vm_start.
+	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va
+	 * and hands BPF its arena pointer via scx_kaddr_to_arena().
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
 
@@ -1205,6 +1206,31 @@ struct scx_sched {
 	struct scx_sched	*ancestors[];
 };
 
+/**
+ * scx_arena_to_kaddr - Translate a BPF-arena pointer to its kernel address
+ * @sch: scheduler whose arena hosts @bpf_ptr
+ * @bpf_ptr: BPF-arena pointer, only the low 32 bits are used
+ *
+ * The (u32) cast normalizes any input into the arena's 4 GiB kern_vm range,
+ * which combined with scratch-page fault recovery makes the returned pointer
+ * safe to dereference up to GUARD_SZ / 2 past the intended object. Accesses
+ * larger than GUARD_SZ / 2 must be explicitly bounds-checked.
+ */
+static inline void *scx_arena_to_kaddr(struct scx_sched *sch, const void *bpf_ptr)
+{
+	return (void *)(sch->arena_kern_base + (u32)(uintptr_t)bpf_ptr);
+}
+
+/**
+ * scx_kaddr_to_arena - Translate a kernel arena address to its BPF form
+ * @sch: scheduler whose arena hosts @kaddr
+ * @kaddr: kernel-side arena address, supplied by trusted kernel code
+ */
+static inline void *scx_kaddr_to_arena(struct scx_sched *sch, const void *kaddr)
+{
+	return (void *)((uintptr_t)kaddr - sch->arena_kern_base);
+}
+
 enum scx_wake_flags {
 	/* expose select WF_* flags as enums */
 	SCX_WAKE_FORK		= WF_FORK,
-- 
2.54.0

