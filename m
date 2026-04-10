Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BF38655E;
	Fri, 10 Apr 2026 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802648; cv=none; b=WEJfYbFeCHOOVkNYF2d9BoY5c0RoikmdW/RvxRw9mG2yFYEjubHAkq6ZZ5nfhOT0KuZFF7y8X85WP/jO/wUH2hs6QD44Zu3l4Fcl/h+cKUvxH5FXTFO3Blsb7alPxHm5+ymTs31WGXTCxLim9nL4qPYd3q4YAiv6ZChOINbW2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802648; c=relaxed/simple;
	bh=suPMO7P78NQCrlpQySt2FvE3xVVlzIPiC3jRKgPxt1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIwsLqLlrb+4pCxcf183T1MFtdJ88riXgw4RLoo0vXzlsFtLxrIJBf6beW+p2iMWM4ScW+CaKeuqa4P1voMeNweXhasifQilaILe5HL4qTGBXhKfBed9joY1IOf8KWpYtEW1UUBalce1wCx/sB7G2onAcuG7PXdX0TRfYRImDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSfClPLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSfClPLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDAAC19421;
	Fri, 10 Apr 2026 06:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802647;
	bh=suPMO7P78NQCrlpQySt2FvE3xVVlzIPiC3jRKgPxt1U=;
	h=From:To:Cc:Subject:Date:From;
	b=kSfClPLuswyxjMEst7TCZAmgNdODLsFekFuOGHogReF9xBos4e6L5tqVtY5LC3yvs
	 7PljlSAKs04udkCfA5N6NbcSZkma90tXrLiOkGYQ058KO+ca2CyM71yGtBEtECIaxx
	 6rPPtM9/w7bDz3fbBgH7roqX+AbyEGG3Fy3v839Dlc7nbupmEzuSvCxilI0mPcjG1z
	 BOIuSW0Xn/xIRGninkLsKZYd52cwF+8iLveBSveP1ljj31MTanNpC4EQp7+Se0gp6n
	 Wo0YmBssUtD+oZteEArI2YVz1CJaiozC4rCHi6Jd0FWNOzf0Majf23yc5CItTrmt0J
	 TKDicGWRXvyZA==
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
Subject: [PATCHSET sched_ext/for-7.1] sched_ext: Add verifier-time kfunc context filter
Date: Thu,  9 Apr 2026 20:30:36 -1000
Message-ID: <20260410063046.3556100-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This moves enforcement of SCX context-sensitive kfunc restrictions from
runtime kf_mask checks to BPF verifier-time filtering, using the BPF core's
struct_ops context information.

This is based on work by Juntong Deng and Cheng-Yang Chou:

  https://lore.kernel.org/r/20260406154834.1920962-1-yphbchou0911@gmail.com

I ended up redoing the series. The number of changes needed and the
difficulty of validating each one made iterating through review emails
impractical:

 - Pre-existing call-site bugs needed fixing first. ops.cgroup_move() was
   mislabeled as SCX_KF_UNLOCKED when sched_move_task() actually holds the
   rq lock, and set_cpus_allowed_scx() passed rq=NULL to SCX_CALL_OP_TASK
   despite holding the rq lock. These had to be sorted out before the
   runtime-to-verifier conversion could be validated.

 - The macro-based kfunc ID deduplication (SCX_KFUNCS_*) made it hard to
   verify that the new code produced the same accept/reject verdicts as
   the old.

 - No systematic validation of the full (kfunc, caller) verdict matrix
   existed, so it wasn't clear whether the conversion was correct.

This series takes a different approach: first fix the call-site bugs that
made the conversion harder than it needed to be, then do the conversion in
small isolated steps, and verify the full verdict matrix at each stage.

The series:

 01/10 Drop TRACING access to select_cpu kfuncs
 02/10 Add select_cpu kfuncs to scx_kfunc_ids_unlocked
 03/10 Track @p's rq lock across set_cpus_allowed_scx -> ops.set_cpumask
 04/10 Fix ops.cgroup_move() invocation kf_mask and rq tracking
 05/10 Decouple kfunc unlocked-context check from kf_mask
 06/10 Drop redundant rq-locked check from scx_bpf_task_cgroup()
 07/10 Add verifier-time kfunc context filter
 08/10 Remove runtime kfunc mask enforcement
 09/10 Rename scx_kf_allowed_on_arg_tasks() to scx_kf_arg_task_ok()
 10/10 Warn on task-based SCX op recursion

Patches 1-2 are extracted from the original patchset. Patches 3-4 fix
pre-existing call-site bugs where SCX_CALL_OP_TASK passed rq=NULL despite
the kernel holding the rq lock. Patch 5 converts select_cpu_from_kfunc and
scx_dsq_move to explicit locked-state tests. Patch 6 drops the now-
redundant kf_mask check from scx_kf_allowed_on_arg_tasks. Patch 7 adds the
verifier-time filter. Patch 8 removes the runtime kf_mask machinery. Patches
9-10 are post-removal cleanup.

The full verdict matrix was verified by writing BPF test programs covering
every kfunc group from every relevant caller context, testing both baseline
and patched kernels. All in-tree example schedulers and most scx-repo
schedulers pass smoke testing on the patched kernel.

Based on sched_ext/for-7.1 (ff1befcb1683).

 include/linux/sched/ext.h   |  28 ---
 kernel/sched/ext.c          | 415 ++++++++++++++++++++---------------------
 kernel/sched/ext_idle.c     |  69 ++++---
 kernel/sched/ext_idle.h     |   2 +
 kernel/sched/ext_internal.h |   8 +-
 kernel/sched/sched.h        |   1 +
 6 files changed, 253 insertions(+), 270 deletions(-)

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-kf-allowed-filter

--
tejun
