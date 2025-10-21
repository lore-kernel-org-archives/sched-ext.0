Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA998528E;
	Tue, 21 Oct 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079165; cv=none; b=EEMdOHwCSP0Clye9IKBupX8ETGtisDbY2io1F9wh5aeZxooEHwk68lvUZiNhFmvIF5JvLukvK53kLhPpro13jAyYx8UHlJOLwzc6gv2G1fK+O8UpLxjy4IE1SSbdE1sdyaLYIC0v3l0r8CZtGYfT0PfpZJmuUpFPZvGwlLWhJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079165; c=relaxed/simple;
	bh=6MoCzJu0OSrp5FJUgSLHBivJyw/b6mr+rt3qFr2LoRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+JVNJDR3dDBtcQp2ZpHjpNfvLWuJERQx7SeDaIKGmhLElyHlUUxM2xa1sVJ78C4wowwCvv01UXWOEcdWriKPNZe7JoyTVt5YZUHWHWlxtyULZ8WU+I+bzhalDd8i/9Blnq7j3zY274MQMr9bo2zK6XqI/TL+JRsp8IDDoPZRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOSvS27I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOSvS27I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C016C4CEF1;
	Tue, 21 Oct 2025 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079165;
	bh=6MoCzJu0OSrp5FJUgSLHBivJyw/b6mr+rt3qFr2LoRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOSvS27IahyFHqcGsLlVugHbvLmmwv+qR9avWY7PnLB9H6WquFRMV1f2D2nX/r+Pz
	 n98a0j+MuukWkbQbend1WApPPuasOx/YYWbgFVYEgL53ay+/2V0yOWo/aYeZ0ogYqq
	 FeOh6zosYKzhFJ2xGSUE2cdKiv+7cxVCs+dDT0edP96JGhOzTc6BmR0v1g5QPdYfUg
	 BIOovi+i5WOulBf1ZkJQIJhGvSAQlUNwe5Yu9TVsr7ugqJXxtXOj7v+31J4MjOVG6l
	 h82kjs/EMk9o1rt7blCtI2FAOOLUOJAxDXaIs8+YrUlaFTOVYZUvkfCvp9s/GuSSCN
	 tatOsW5YQhAwA==
Date: Tue, 21 Oct 2025 10:39:24 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.19] sched_ext: Fix scx_bpf_dsq_insert()
 backward binary compatibility
Message-ID: <aPfvfL_8knMw0w8Q@slm.duckdns.org>
References: <c860cc12b4b0da311fa8cbbbe17f8199@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c860cc12b4b0da311fa8cbbbe17f8199@kernel.org>

cded46d97159 ("sched_ext: Make scx_bpf_dsq_insert*() return bool")
introduced a new bool-returning scx_bpf_dsq_insert() and renamed the old
void-returning version to scx_bpf_dsq_insert___compat, with the expectation
that libbpf would match old binaries to the ___compat variant, maintaining
backward binary compatibility. However, while libbpf ignores ___suffix on
the BPF side when matching symbols, it doesn't do so for kernel-side symbols.
Old binaries compiled with the original scx_bpf_dsq_insert() could no longer
resolve the symbol.

Fix by reversing the naming: Keep scx_bpf_dsq_insert() as the old
void-returning interface and add ___v2 to the new bool-returning version.
This allows old binaries to continue working while new code can use the
___v2 variant. Once libbpf is updated to ignore kernel-side ___SUFFIX, the
___v2 suffix can be dropped when the compat interface is removed.

v2: Use ___v2 instead of ___new.

Fixes: cded46d97159 ("sched_ext: Make scx_bpf_dsq_insert*() return bool")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying to sched_ext/for-6.19. Thanks.

 kernel/sched/ext.c                       |   12 ++++++------
 tools/sched_ext/include/scx/compat.bpf.h |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5407,8 +5407,8 @@ __bpf_kfunc_start_defs();
  * scheduler, %false return triggers scheduler abort and the caller doesn't need
  * to check the return value.
  */
-__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
-				    u64 enq_flags)
+__bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
+					 u64 slice, u64 enq_flags)
 {
 	struct scx_sched *sch;
 
@@ -5431,12 +5431,12 @@ __bpf_kfunc bool scx_bpf_dsq_insert(stru
 }
 
 /*
- * COMPAT: Will be removed in v6.23.
+ * COMPAT: Will be removed in v6.23 along with the ___v2 suffix.
  */
-__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id,
+__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 					     u64 slice, u64 enq_flags)
 {
-	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
+	scx_bpf_dsq_insert___v2(p, dsq_id, slice, enq_flags);
 }
 
 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
@@ -5532,7 +5532,7 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_RCU)
 BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -238,16 +238,16 @@ scx_bpf_dsq_insert_vtime(struct task_str
  * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
  * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
  */
-bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
-void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+void scx_bpf_dsq_insert___v1(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 
 static inline bool
 scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
 {
-	if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
-		return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_flags);
+	if (bpf_ksym_exists(scx_bpf_dsq_insert___v2)) {
+		return scx_bpf_dsq_insert___v2(p, dsq_id, slice, enq_flags);
 	} else {
-		scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
+		scx_bpf_dsq_insert___v1(p, dsq_id, slice, enq_flags);
 		return true;
 	}
 }
