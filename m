Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1593375B4
	for <sched-ext@lists.linux.dev>; Mon,  1 Sep 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733183; cv=none; b=jbAg5AJqIfaQPL2o/JappZG7IBQ4HkBHu91C8cBpCdhxRtoUWkI9i7OoK+9INe1IJcUkJHWxY4ukcu699xCs3lLQHe32DpiAYNoaF/cfqDJM57FdYKVdll49JkFj5I1KXCfQe+rFxCppwYx/0Pg1bfPpXQEJ3FuLiiZJSZFf8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733183; c=relaxed/simple;
	bh=tAWptsPoAQN7clhwaWlgvNzQhTIkN34Fvqere1BPJJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lpz0BudF+m70SwCspMqTWcq1s3D3bMjF+Qi/HOFoSCqWEH1RkxY1TaryeXJUcd8MhicNPsUtJs9/ZfgmRIyDfauxPp32dOXNajIKB+8EmqRVcRGo1nZflgLlDx3gvKQ2WUryol15XjLVcRByBmED9uDLzIe/2O3erBxMjBIwdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4419A2696;
	Mon,  1 Sep 2025 06:26:13 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0A1A3F694;
	Mon,  1 Sep 2025 06:26:19 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v5 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Mon,  1 Sep 2025 14:26:05 +0100
Message-Id: <20250901132605.2282650-6-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132605.2282650-1-christian.loehle@arm.com>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() currently allows accessing struct rq fields without
holding the associated rq.
It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
scx_tickless. Fortunately it is only ever used to fetch rq->curr.
So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
/* ... Do something with p */

into:

p = scx_bpf_remote_curr(cpu);
/* ... Do something with p */

v4:
Remove cpu argument from scx_bpf_cpu_rq_locked() as SCX has a unique
locked_rq_state anyway. (Tejun)
Expose RCU pointer in scx_bpf_remote_curr() (Peter)
v3:
https://lore.kernel.org/lkml/20250805111036.130121-1-christian.loehle@arm.com/
Don't change scx_bpf_cpu_rq() do not break BPF schedulers without the
grace period. Just add the deprecation warning and do the hardening in
the new scx_bpf_cpu_rq_locked(). (Andrea, Tejun, Jake)
v2:
https://lore.kernel.org/lkml/20250804112743.711816-1-christian.loehle@arm.com/
- Open-code bpf_task_acquire() to avoid the forward declaration (Andrea)
- Rename scx_bpf_task_acquire_remote_curr() to make it more explicit it
behaves like bpf_task_acquire()
- Dis
v1:
https://lore.kernel.org/lkml/20250801141741.355059-1-christian.loehle@arm.com/
- scx_bpf_cpu_rq() now errors when a not locked rq is requested. (Andrea)
- scx_bpf_remote_curr() calls bpf_task_acquire() which BPF user needs to
release. (Andrea)

Christian Loehle (3):
  sched_ext: Introduce scx_bpf_cpu_rq_locked()
  sched_ext: Introduce scx_bpf_remote_curr()
  sched_ext: deprecation warn for scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 40 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 2 files changed, 42 insertions(+)

--
2.34.1

