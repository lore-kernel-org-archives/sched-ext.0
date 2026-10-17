Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74E3BCD24;
	Sat, 17 Oct 2026 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792276661; cv=none; b=chfv5dvWAhfZHtK9/ei+GSNKt0Cc4NyDg2zN2AJ9bqb85CIIrye5NAGtOFTPewJEhq/Lcjq2IrZRbstJSuwb2ESqI1PNN85Bk/sfIf/+UMVukcbMYCb9pdfCjTh9Cl9BpofS8GPWFc1fXPeLlZno6YJbK1se92l9024gxbxTyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792276661; c=relaxed/simple;
	bh=hrKiDFkU/pUpRekuIvLwKgY9FqFKaw2GvKJ4Y5/CQmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFyLv3J1jdhTS+NVT/76e6yFVcO7eHAXfgsxWOL39PToCFDNwMkDmCKcsHx3d/ByjA/Xb6vUQyufhQpgkzVzFaO+IQIGrUhT0WgNHciTGbgiSDwXxAx2cFWt9/ZTMJNdEI6Pxu+Hoed3XJyEFxb0PA7Cl5rdIJI8oZE2uzeT4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipfNVSVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipfNVSVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D0A1F000C4;
	Sat, 17 Oct 2026 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792276660;
	bh=axon6rabWoLfUGlE2j2dlSHrJd2Csma9URIPcS59GH8=;
	h=From:To:Cc:Subject:Date;
	b=ipfNVSVnZ4O7vM62n+vfKT2h1+bkJZsXZ1QsflHmUhZNq2kuJuc19L8EBk9X+95x/
	 oXfVEaT3d++Fb2UXHMXK1uW6vXsqQOfScUIoEtey4IsYWj8D2SLmnuSGa/G2AFcgTO
	 m9dzuf16g/NH7L4lW3oVqHpZAsjhUID7+fSbO3bABvW4fwD+1AMnHyvljJb05t2zHh
	 bvgBN0mKPEWg7i90ldmosce4IectZuX6Je+kM2AWXOa+5PHtl7oh+NaITBfC7mRWtx
	 ZtcxNAQt5IoZHZeg3UbpbwXho/KwgzIKRBzo3meL7fqe+OeoIbyfy8OByWFpBgplYo
	 C9ZrbrVC9oDvg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Add scx_bpf_dsq_reenq_task()
Date: Sat, 17 Oct 2026 12:37:35 -1000
Message-ID: <20261017223738.993262-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A scheduler that loses the cpus serving a DSQ needs the tasks stranded on it
placed again, and only those. scx_bpf_dsq_reenq() re-enqueues the whole DSQ:
every task goes back through ops.enqueue() and is re-placed and reordered.
The only per-task primitive, scx_bpf_dsq_move(), is a placement decision,
not a re-enqueue. A sub-scheduler sweeping its DSQs after a cap revoke is
one such caller.

Patch 1 factors the rq lock switch out of scx_dsq_move() so that the new
kfunc can share it. Patch 2 adds scx_bpf_dsq_reenq_task(), which marks a
task from a DSQ iteration. When the iteration ends, the DSQ's deferred
re-enqueue walk is scheduled once and re-enqueues only the marked tasks, in
DSQ order with SCX_ENQ_REENQ. The other tasks keep their positions.

The kfunc locks the task's rq and the DSQ like scx_bpf_dsq_move() and is
callable from the same contexts. The mark is cleared when the task leaves
the DSQ, so a task consumed before the walk is not re-enqueued.

Patch 3 makes scx_qmap re-enqueue some of the tasks stranded on its shared
DSQs with the new kfunc instead of moving them to the rescue path, so that
both kfuncs are exercised. They go back through ops.enqueue(), which rescues
them, and the other queued tasks keep their places.

Based on sched_ext/for-7.4 (9c0af54cb49c).

This patchset contains the following 3 patches.

 0001 sched_ext: Factor out the rq lock switch of scx_dsq_move()
 0002 sched_ext: Add scx_bpf_dsq_reenq_task() to re-enqueue single tasks from a DSQ iteration
 0003 sched_ext: scx_qmap: Also re-enqueue stranded tasks with scx_bpf_dsq_reenq_task()

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git dsq-reenq-task

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   1 +
 kernel/sched/ext/ext.c                   | 142 ++++++++++++++++++++++++-------
 kernel/sched/ext/internal.h              |   2 +
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 tools/sched_ext/include/scx/compat.bpf.h |   6 ++
 tools/sched_ext/scx_qmap.bpf.c           |  50 ++++++-----
 6 files changed, 153 insertions(+), 49 deletions(-)

--
tejun
