Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FD346E6E;
	Tue, 21 Oct 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065278; cv=none; b=BFXIYvDz+2UgliDMILZIidQZDVGEM+TLXBa8GwXZenA8tjFZ+tcRoBCNFLSr4/hxaq7dJFJP9+4IuiekpETjjnoTx4Rog23Lav/pGHw3sLnmcPPH9PynTE/YoFVbqPitJmIJVe/l+431TF9PsMBUPBs4IE0OJ6YdhAi14zWZdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065278; c=relaxed/simple;
	bh=fOOg7+3J7rwGg8btrPOiTJvE5JmCHKDybAWrBt8TS0A=;
	h=Date:Message-ID:From:To:Cc:Subject; b=DmulXbYd88J7/KX9WHhRDlZshoVp8/Pu7NLdbN//nFs4eYOkBN/7jevA6NYT4Jm3g9LN9A7YSAQT9BlCtJ6gaMElvKf1oxVcFXAzG4aQzOcclFDoxIrEz0PBQrelbuNx+revU3DRnw9duRXGCrJm878/Wdi6Y2xZlX0Z/6NGaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs3cnIO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs3cnIO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E288FC4CEF1;
	Tue, 21 Oct 2025 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065278;
	bh=fOOg7+3J7rwGg8btrPOiTJvE5JmCHKDybAWrBt8TS0A=;
	h=Date:From:To:Cc:Subject:From;
	b=Xs3cnIO/aQ+miCGfM2oV12t+hEMfdb/wUwz8l0ng/UkfdSiNpW15KXY6eGPFDaQU3
	 bwvGX5XkYBrhLsi+/Pw2cUSvT+i73IjAojzqJGrWHyTukAtSMDNPo6zPVj42M74vS3
	 eqnrXlnDibB8YeM9fGXCo06apBh8eQuXtGoX8XFDuW6+Ut2kAfKRdyCGxL1rZiRzcn
	 0B5TyHHUp/hNb7Ksy7J/9kVXYtPzVzVyAbThXZmHEE5GhxL0cAjTPCTJS/q5yFLzC6
	 zjooe1JUjrD90E8ol1d9Pid2yA+TdtbrVga1JItajlsIO/q8frzdMMcMNJJey8GVHw
	 ZCgNsABrHcOUQ==
Date: Tue, 21 Oct 2025 06:47:57 -1000
Message-ID: <c860cc12b4b0da311fa8cbbbe17f8199@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Fix scx_bpf_dsq_insert() backward binary compatibility
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

commit cded46d97159 ("sched_ext: Make scx_bpf_dsq_insert*() return bool")
introduced a new bool-returning scx_bpf_dsq_insert() and renamed the old
void-returning version to scx_bpf_dsq_insert___compat, with the expectation
that libbpf would match old binaries to the ___compat variant, maintaining
backward binary compatibility. However, while libbpf ignores ___suffix on
the BPF side when matching symbols, it doesn't do so for kernel-side
symbols. Old binaries compiled with the original scx_bpf_dsq_insert() could
no longer resolve the symbol.

Fix by reversing the naming: Keep scx_bpf_dsq_insert() as the old
void-returning interface and add ___new to the new bool-returning version.
This allows old binaries to continue working while new code can use the
___new variant. Once libbpf is updated to ignore kernel-side ___suffix, the
___new suffix can be dropped when the compat interface is removed.

Fixes: cded46d97159 ("sched_ext: Make scx_bpf_dsq_insert*() return bool")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       |    8 ++++----
 tools/sched_ext/include/scx/compat.bpf.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5407,7 +5407,7 @@ __bpf_kfunc_start_defs();
  * scheduler, %false return triggers scheduler abort and the caller doesn't need
  * to check the return value.
  */
-__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
+__bpf_kfunc bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice,
 				    u64 enq_flags)
 {
 	struct scx_sched *sch;
@@ -5433,10 +5433,10 @@ __bpf_kfunc bool scx_bpf_dsq_insert(stru
 /*
  * COMPAT: Will be removed in v6.23.
  */
-__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id,
+__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 					     u64 slice, u64 enq_flags)
 {
-	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
+	scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_flags);
 }

 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
@@ -5532,7 +5532,7 @@ __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert___new, KF_RCU)
 BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -239,7 +239,7 @@ scx_bpf_dsq_insert_vtime(struct task_str
  * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
  */
 bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
-void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+void scx_bpf_dsq_insert___old(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;

 static inline bool
 scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
@@ -247,7 +247,7 @@ scx_bpf_dsq_insert(struct task_struct *p
 	if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
 		return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_flags);
 	} else {
-		scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
+		scx_bpf_dsq_insert___old(p, dsq_id, slice, enq_flags);
 		return true;
 	}
 }
