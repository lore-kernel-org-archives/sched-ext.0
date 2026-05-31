Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F835C180;
	Sun, 31 May 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250267; cv=none; b=Bgih0pPgCioefDqUNw52KVIB7/fOF02ZqniDkptQ7ro6klR+cvrbf4iJrJAv5vh9XYZX8MhFfJi145ECzeiFtY0FYl3n9LVHkNNk2IZDGugRwgGKo1XwnFFLvNtDHX2z5CFD35XiE2Zy1HD5E+9no4tjQXDFA2BOaDTHp81Mmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250267; c=relaxed/simple;
	bh=+jUHNOFIjufT0wc/maroJN34fLQ8BFzMAqNSmIdn3D4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ccsoUgDtPNDbX+MCnQfLs2lH0XUi5W84nb7jfTRvOCNFO00JKI5JoS6QZtv7qLlH39svEncQcarnoktfdl8IQmR8ASQubwM6xoxWOiuqQoDp2qFJLmgJLaPtkVfMssv0zniLZP/3wrZYodbfwlvbR80SkEPZCVnxCL3AWQ/IND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neZ/ZJOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neZ/ZJOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED51F00893;
	Sun, 31 May 2026 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780250266;
	bh=G02nokUN9RASzoOgmoYwao63/4k1n5EyizLqFQ+AUcA=;
	h=Date:From:To:Cc:Subject;
	b=neZ/ZJOtARHB1a/P0nO+jbMuMzT3TXJraNXwh6a/vD3WhAMVsFSYd/cFFWY1bvkx2
	 hrHJDyEp+10KEs7gB3qmGePSArZRD4gr+2gfSs7q4WgECQtlyUz9hmGHGDLMT7vwZz
	 FAvhpC1TehfUO5nvMDjgQq4VI1XL+6deHbxDDMvEn96y0BQnpX4leSzMYjo8FaKrcc
	 npqpsfLue1kby2MVQ1sIfwi09CaRMfg9F+2xH11Ww3Lnn0S1VODfoQlJulPt91Z4IL
	 X1yBb8xIU4zkJ3HHT3kMcgoGI0SeNeYLUkSfHtu8BQ6FZRio3UbJxTEU2I/vfy8sXU
	 zMkPDU74avRKQ==
Date: Sun, 31 May 2026 07:57:45 -1000
Message-ID: <e8d28ed3e35f72b7dc647a6ef27e1b80@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Guard BPF arena helper calls to fix 32-bit build
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

BPF arena (kernel/bpf/arena.c) is compiled only on MMU && 64BIT, while
SCHED_CLASS_EXT depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF with no
64BIT requirement. On a 32-bit arch with a BPF JIT, SCX builds while the
arena helpers are absent, so the cid-form code's unconditional calls to
bpf_prog_arena() and bpf_arena_map_kern_vm_start() fail to link:

  build_policy.o: undefined reference to `bpf_prog_arena'
  build_policy.o: undefined reference to `bpf_arena_map_kern_vm_start'

Guard the three call sites with the same MMU && 64BIT condition that gates
arena.o. A cid-form scheduler needs a BPF arena, which isn't available on
such builds, so it can't run there regardless. cpu-form schedulers don't
touch the arena and are unaffected.

This is a quick workaround to get past the build errors. A fuller fix may
make the whole cid-form path conditional on the same condition, or drop
32-bit support outright.

Fixes: 0e2819cba977 ("sched_ext: Require an arena for cid-form schedulers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605310454.U9iByL2n-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202605310926.APXMc0RJ-lkp@intel.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c       | 14 +++++++++++---
 kernel/sched/ext_arena.c |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ffad1a90196f..8ef55dac69c8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -622,8 +622,12 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 
 	if (scx_is_cid_type()) {
 		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
-		unsigned long uaddr = (unsigned long)kern_va -
-			bpf_arena_map_kern_vm_start(sch->arena_map);
+		unsigned long uaddr = (unsigned long)kern_va;
+
+		/* arena.o, which defines these, is built only on MMU && 64BIT */
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+		uaddr -= bpf_arena_map_kern_vm_start(sch->arena_map);
+#endif
 		/*
 		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
 		 * holds the rq lock with IRQs disabled, which makes us the sole
@@ -8005,8 +8009,12 @@ struct scx_arena_scan {
 static int scx_arena_scan_prog(struct bpf_prog *prog, void *data)
 {
 	struct scx_arena_scan *s = data;
-	struct bpf_map *arena = bpf_prog_arena(prog);
+	struct bpf_map *arena = NULL;
 
+	/* arena.o, which defines these, is built only on MMU && 64BIT */
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+	arena = bpf_prog_arena(prog);
+#endif
 	if (!arena)
 		return 0;
 	if (s->arena && s->arena != arena) {
diff --git a/kernel/sched/ext_arena.c b/kernel/sched/ext_arena.c
index b413e155ba6b..493c2424f842 100644
--- a/kernel/sched/ext_arena.c
+++ b/kernel/sched/ext_arena.c
@@ -80,7 +80,12 @@ static int scx_arena_grow(struct scx_sched *sch, u32 page_cnt)
 		return -ENOMEM;
 
 	uaddr32 = (u32)(unsigned long)p;
+	/* arena.o, which defines these, is built only on MMU && 64BIT */
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 	kern_vm_start = bpf_arena_map_kern_vm_start(sch->arena_map);
+#else
+	kern_vm_start = 0;
+#endif
 
 	ret = gen_pool_add(sch->arena_pool, kern_vm_start + uaddr32,
 			   page_cnt * PAGE_SIZE, NUMA_NO_NODE);
