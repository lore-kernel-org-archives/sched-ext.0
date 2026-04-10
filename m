Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0F38837C;
	Fri, 10 Apr 2026 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802650; cv=none; b=JED6zfcvQ0GHyG71xw2bgQYsqduj/kPKVkHIrnzULt0T8uHlrerxLqCYQpaOe66cJu7oNWHkY/iLe1A72LgsYkaf0KBlHkXA3MF0iCp8nGeDsmsX0549gwGsak3ilcgvRnfC8D5LFUNa5mJNgKVH65P5oJw2Ln6zRH13JyfdcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802650; c=relaxed/simple;
	bh=nUoQSFHjAYRBpJinLQlX8UdQlOrbw6YPNPndYA3tP2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmJz+Lm82iDexo4USBBB9BFwxaf1jWvJm2XHDY/ytg2Jm/tNIHLQMruWYwI2AlPKZFBSWll3RCjaJGENjcTrGzimp/ENPwm4KpIV5LfPX217+t1NhryTiIjOgkHZVWA/dLOvOhA2LbWMWeBXWTPwqSZBeByWdMfq9TOwOOR/V5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJpS3MnX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJpS3MnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1741C19421;
	Fri, 10 Apr 2026 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802650;
	bh=nUoQSFHjAYRBpJinLQlX8UdQlOrbw6YPNPndYA3tP2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJpS3MnX7sSJOY7lsCI8wxO8TKcGe9AD+R/FKNHrnoodTPAA00i72w83RJZfrXE6S
	 F5ZNqNEEJQ5b/9EnSzcfVN4uFr1cMfQcEE9XWGD8BTrk3LBjdPRHwAKvY/8iZH+C0x
	 mp2B3S2x9HrcbcyHjgCVM8XEdxKUFdptMBtvpOX0r1O7kfF1mno/rcVmyfrelNoq+1
	 JCjCxHEmEoqr9tE05+iHbLn1e6DkJy9QfNE6dZueu3aLmAv3s0fO/ethl3wNEZOra7
	 kikSI4murRGCbHMGtW8EiMTYgisU4S4ictHdZJLkqO9InhPZEST1geFi9ejQgvDUKe
	 plqyLrp2tnBoQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] sched_ext: Add select_cpu kfuncs to scx_kfunc_ids_unlocked
Date: Thu,  9 Apr 2026 20:30:38 -1000
Message-ID: <20260410063046.3556100-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

select_cpu_from_kfunc() has an extra scx_kf_allowed_if_unlocked() branch
that accepts calls from unlocked contexts and takes task_rq_lock() itself
- a "callable from unlocked" property encoded in the kfunc body rather
than in set membership. That's fine while the runtime check is the
authoritative gate, but the upcoming verifier-time filter uses set
membership as the source of truth and needs it to reflect every context
the kfunc may be called from.

Add the three select_cpu kfuncs to scx_kfunc_ids_unlocked so their full
set of callable contexts is captured by set membership. This follows the
existing dual-set convention used by scx_bpf_dsq_move{,_vtime} and
scx_bpf_dsq_move_set_{slice,vtime}, which are members of both
scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked.

While at it, add brief comments on each duplicate BTF_ID_FLAGS block
(including the pre-existing dsq_move ones) explaining the dual
membership.

No runtime behavior change: the runtime check in select_cpu_from_kfunc()
remains the authoritative gate until it is removed along with the rest
of the scx_kf_mask enforcement in a follow-up.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c      | 6 ++++++
 kernel/sched/ext_idle.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b757b853b42b..cf441fb4b1ad 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8497,6 +8497,7 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
+/* also in scx_kfunc_ids_unlocked: also callable from unlocked contexts */
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
@@ -8612,10 +8613,15 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_IMPLICIT_ARGS | KF_SLEEPABLE)
+/* also in scx_kfunc_ids_dispatch: also callable from ops.dispatch() */
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+/* also in scx_kfunc_ids_select_cpu: also callable from ops.select_cpu()/ops.enqueue() */
+BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index cd88aee47bd8..8c31fb65477c 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1482,6 +1482,10 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
  * contexts where @p's pi_lock state is unknown. Keep them out of
  * BPF_PROG_TYPE_TRACING by registering them in their own set which is exposed
  * only to STRUCT_OPS and SYSCALL programs.
+ *
+ * These kfuncs are also members of scx_kfunc_ids_unlocked (see ext.c) because
+ * they're callable from unlocked contexts in addition to ops.select_cpu() and
+ * ops.enqueue().
  */
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
-- 
2.53.0

