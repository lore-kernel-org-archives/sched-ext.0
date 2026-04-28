Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510281BF33;
	Tue, 28 Apr 2026 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335397; cv=none; b=JMNUE2YuOLP3sm3URvaf6Z/rvVR+AlvSo06+fubhlZQiJhvJwYMQaLuSQfmoajJhkKUd2WC7XT+RuBRVYUO+qZqOJhT9elGmBRUe9GDx2kZtp8OrjtaloYSSTYqSJOjMQsyJGfwVOMtQJ+0n8VxCIDzQqpQxtnHqefmRrB8J5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335397; c=relaxed/simple;
	bh=0tDXt2OImmJyzi5sDrnNs49nNivoqCOmqNWKSmd2Kgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwTIrY0CsXf7gvFM19JpOo1eRVZYPIZIIjbwRXeP080gOZR5ACURE4GSaCo/lJ1hT7+DbdRAeOn7kpHVBARrH1qWx9g1Xs7VVBuMPkxd2PI0gvuDTAOHh/+iWRpGyFqCAGrSJzq79O8lVH7GT1TOPshRxMUtFJNbUIX0NZxiHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYVuyJJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYVuyJJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D08C19425;
	Tue, 28 Apr 2026 00:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335396;
	bh=0tDXt2OImmJyzi5sDrnNs49nNivoqCOmqNWKSmd2Kgo=;
	h=From:To:Cc:Subject:Date:From;
	b=hYVuyJJx/JqViTyatWWxBbbbGkkXcrlKL7oA7L9Qwbo35UVd5hHBgOkPK8rp4t5/0
	 f7mKMP1vxaeJT7oez4noT8sKhGRTwiD1K0FC2hzJeUAkkZfvi1ObAU5aW9996yn7+h
	 abuIP/lEJ3fgN8gFCdFNfz8U+My3E4dgEZdoo2pi8ugh4YEcIn60fzHRMpKWxpBzhE
	 Ur9NVuBWUz3PKhHYnW0mhYHVjYVsthEwmbbQljSE4Feap119QR2Vjq9zYJdwvqgznI
	 juFgDh/ql/r0q1+UbeeksxwcHUfEIGhOxVDIdECv+nYtvAP1W1t6TziihQ7xQyuqXk
	 Bj5yB/axDHgfA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Fix cgroup iter coverage of in-do_exit tasks
Date: Mon, 27 Apr 2026 14:16:33 -1000
Message-ID: <20260428001635.3293997-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup") made
css_task_iter_advance() skip exiting tasks. That broke scx_task_iter's
cgroup-scoped mode: it now silently skips tasks that are still on
scx_tasks but past exit_signals(), so the abort path in
scx_sub_enable_workfn() can miss SCX_TASK_SUB_INIT-marked exiting tasks
and leak __scx_init_task() state.

Restoring iter coverage exposes a separate latent issue: cgroup
iteration can return tasks whose sched_ext_dead() has already torn down
their per-task SCX state (cgroup_task_dead() runs after sched_ext_dead()
in finish_task_switch() and is irq-work deferred on PREEMPT_RT). Callers
trip WARN_ON_ONCE() / fail assertions when they see such a task.

This pair fixes both:

 0001 sched_ext: Include exiting tasks in cgroup iter
      Adds CSS_TASK_ITER_WITH_DEAD; scx_task_iter opts in.

 0002 sched_ext: Skip past-sched_ext_dead() tasks in
      scx_task_iter_next_locked()
      Adds SCX_TASK_OFF_TASKS, set in sched_ext_dead() under the rq
      lock; scx_task_iter_next_locked() skips flagged tasks under the
      same lock.

Verified with a stress harness that runs a 4-deep nested sub-sched
hierarchy with continuous fork/switch workers and random sub-sched
restarts at 5s intervals. Baseline (without the patches) wedged a
192-CPU bare-metal box in 66s and oopsed a 24-thread bare-metal box at
227s. Patched ran clean for 30min on both plus an 8-vCPU vng - 0
WARN/BUG/lockdep across ~1000 sub-restarts.

Based on sched_ext/for-7.1-fixes (deb7b2f93d01).

 include/linux/cgroup.h    |  1 +
 include/linux/sched/ext.h |  1 +
 kernel/cgroup/cgroup.c    |  8 +++++---
 kernel/sched/ext.c        | 39 +++++++++++++++++++++++++++++----------
 4 files changed, 36 insertions(+), 13 deletions(-)

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git iter-include-dead-v1

Thanks.

--
tejun
