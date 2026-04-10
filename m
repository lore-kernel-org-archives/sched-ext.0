Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676F230BE9;
	Fri, 10 Apr 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843511; cv=none; b=kPuygMOzIKicLLaVtKpbuIpAEtqDs7DRqsP1L5ztA+mEgS5rSR1XfAqGecwppI17coND5GZVPPdYmCaP5Gp+QUv6DtOFXZdAw5LVD+bLBCAJggaGxG0u1AIeIQkAw91VCuHxdfMNsfTKn0BZ7RW5ZP9GgU29PatrXOBuCP1aIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843511; c=relaxed/simple;
	bh=lTeXv+sYC2gUYGe8+OtVM3fr/mOC0Oby+lMsJPrKn+Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UpyXTYYA1N0VM0mfzLFE13aC5kK5cOKuURLG2c1jUa7L2JVEXeMdCi0ZxXJJwXhYpRLDyIPHUpfKKK/azxVxQHH49Xua1lPq1LRf+AREA9n+uWYLxPx99w0NeIPS9to72ORx1mKMpk4IwazkKqHby9qqupvVoYU0G2DqwO/g3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc7yHcYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc7yHcYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADEC19421;
	Fri, 10 Apr 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775843510;
	bh=lTeXv+sYC2gUYGe8+OtVM3fr/mOC0Oby+lMsJPrKn+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uc7yHcYI9it3NctNjmI3M1iGZynrQTbFNOBOeZM2Knaz9WbXZrg7ltw9Or2gzeard
	 InrqNeTvO0StEuHUPIiVIcN7nH7Rr+nLFAeI53DAEHyFVE8qzrJGz773BLoD5UDXTH
	 ffkPnWCX4gcixC83adz+eHLFyFd3xS5/6yc8Vsdc0O29k1RdBjFHVII9fDxo5S/OAc
	 sxPK3yI12hrE8jkbbyTULmQPqX3QqKGcISTincYiUC0YU+epMTfGgxgx1XRhSZEkS9
	 k8ak80T9/NmItuaXVF0/QmCkyKz/Zj4Q6JDJP2MORxxSjLN0OkDYIhv2WW8IoDyxkm
	 upEFcvmvZeVtQ==
Date: Fri, 10 Apr 2026 07:51:49 -1000
Message-ID: <71bdb4d99ef8c2e770f883fc0f2a2d67@kernel.org>
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
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] sched_ext: Add select_cpu kfuncs to
 scx_kfunc_ids_unlocked
In-Reply-To: <20260410063046.3556100-3-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

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

v2: Clarify dispatch-set comment to name scx_bpf_dsq_move*() explicitly so it
    doesn't appear to cover scx_bpf_sub_dispatch() (Andrea Righi).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |    6 ++++++
 kernel/sched/ext_idle.c |    4 ++++
 2 files changed, 10 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8497,6 +8497,7 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_s
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
+/* scx_bpf_dsq_move*() also in scx_kfunc_ids_unlocked: callable from unlocked contexts */
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
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1482,6 +1482,10 @@ static const struct btf_kfunc_id_set scx
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
