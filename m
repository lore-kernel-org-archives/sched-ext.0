Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364B367F41;
	Sat,  5 Sep 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624608; cv=none; b=Ba1pkXYLJum6XFzLGhJQYTsTR1GLsCNywa0CiKjrHcQAUqWn3Hz0yoOPLTWsBd5YRl957WIS0RbJPaYzJqo7/qnWA0vpsQ08u/t8BCxmLXTubBSJoxS34tGbnJZF9d+YCAymv1M+i4DCgtPxWkHiXoaO5eEsdt1amY8mY3O2w/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624608; c=relaxed/simple;
	bh=9AtWgmMdaiTCXJykV3jPSQgSBUMnxSMr2ITb33XPzV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB/TtC5UFEjq6eDrLIWQLSFFelFKq548s4yxqExtHdAqy9wKDBSDS3CHl72MOmQnd2Al6SV0Ml9FKvFGrjY7EnhLwOKwuRNhhY7yv40dXXSPadVHM+3Nsy9wM+AX9O8pO4s3JOKnYHekmex0U32j2AtolesNuNtM6BFOoRk7epc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8qgZ/Zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8qgZ/Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21371F00A3A;
	Sat,  5 Sep 2026 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624600;
	bh=avpjCmFixdSY1F64kyLrkW7lKGYjOsPGHPzgKCSWKCI=;
	h=From:To:Cc:Subject:Date;
	b=e8qgZ/ZgN/INdETndA9fLYNhg7Kpn15KvPBxhhjJTDCETVMgVBzxqs9EBSrgJrwcD
	 RdV/H6CntU+JghMVZHDPaKkVafXbqE0rnksBBE5RUP1kY+m8Dh6bgae+4CqZVE1nwB
	 +aTlAjIly78h/VXD+UklEuAd0yeKOOJDYALh5cIsNhjOBR/3N7eRwB9eLBWRV92bom
	 BYnc+Qi6VrpWk7x7gbsI7sKSdOT29gl2kvkqHdp699YSWF8cPYKt+pZS1DktUG+DDI
	 mcpNmiwDxaCbwAjguwsT207k/IZIKIctjapwJfNZ4uic+pVeZjbAg8acOHeknNEEhL
	 dS7W0q/l4f3RQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix keep-last for sub-scheduler tasks and two scx_qmap placement loops
Date: Sat,  5 Sep 2026 06:09:54 -1000
Message-ID: <20260905160958.1565156-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Running scx_qmap as a sub-scheduler under scx_nitosis exposed a kernel bug
and two scx_qmap bugs:

- dispatch_one() decides whether to keep running @prev by testing the root
  scheduler's SCX_OPS_ENQ_LAST and bypass state. Those are properties of
  @prev's own scheduler, and put_prev_task_scx() acts on that scheduler.
  When the root sets the flag and @prev belongs to a sub-scheduler that
  doesn't, the task is not kept and is enqueued with SCX_ENQ_LAST to a
  scheduler that never opted in. This trips the WARN_ON_ONCE in
  put_prev_task_scx(), and the task is queued without a follow-up scheduling
  event, which can stall it. Patches 1-2 fix this.

- scx_qmap added SCX_ENQ_IMMED to its rescue inserts, which turns a rescue
  request into a regular placement on a time-shared cid and loops with the
  kernel's REENQ bounce until the reenqueue limit ejects the scheduler.
  Patch 3 fixes this.

- scx_qmap placed tasks from the delegation split alone, ahead of the caps
  in effect on the cpus, so highpri moves to a freshly granted cid were
  denied and bounced. Patch 4 fixes this.

This patchset contains the following four patches:

 0001 sched_ext: Rename sch to root_sch in dispatch_one()
 0002 sched_ext: Use @prev's scheduler for the keep decisions in dispatch_one()
 0003 sched_ext: scx_qmap: Do not add IMMED to rescue inserts
 0004 sched_ext: scx_qmap: Place only on cids whose caps are in effect

0001-0002 fix the kernel side. 0003-0004 fix scx_qmap.

The patchset is based on sched_ext/for-7.3-fixes (0a85182723b6) and is also
available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-keep-last-rescue

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         |  33 ++++++++------
 tools/sched_ext/scx_qmap.bpf.c | 101 ++++++++++++++++++++++++++++++-----------
 tools/sched_ext/scx_qmap.h     |   3 ++
 3 files changed, 97 insertions(+), 40 deletions(-)

--
tejun
