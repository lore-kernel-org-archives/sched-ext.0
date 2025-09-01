Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB71E0E14
	for <sched-ext@lists.linux.dev>; Mon,  1 Sep 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733175; cv=none; b=aLElreJHYoAOxldaQAD7iaDPdC/4N8p9kq9dWcyOYslRS/1G1nPE5KUtWsVZoiK3MqUrYkABrMNQ/s5lvv5a0ABzbhkSH2eCO0bYhst+rcFwlM2T3SKBwRN0TWfovz5kyO4UOoQ/+OjzdSfJvU6kxuTgudt8Wt7qqTzNf8QM5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733175; c=relaxed/simple;
	bh=JIwwHamYIg6ImzIx11Fn52SRN15A1Imu5cksjrEjJww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NcLQMhyJj92kMuj/qhQP72Rk0pkPT8ON8YqwIdlSv4qUHIg7VOskPopUM1CbdaywJTXB+nJiVyuLj4tzBGEEXcnyt5MzftEGCBv9ntEg8jK5eQmO5SC81X0es+Gnpm/plP7uzQuqyIvrDNGpqdhUC1/T3FBPTL9QaZNRzoKUsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D79E16A3;
	Mon,  1 Sep 2025 06:26:03 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 524153F694;
	Mon,  1 Sep 2025 06:26:10 -0700 (PDT)
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
Subject: [PATCH v4 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Mon,  1 Sep 2025 14:26:00 +0100
Message-Id: <20250901132605.2282650-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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
So provide an alternative scx_bpf_task_acquire_remote_curr() that
doesn't expose struct rq and provide a hardened scx_bpf_cpu_rq_locked()
by ensuring we hold the rq lock.
Add a deprecation warning to scx_bpf_cpu_rq_locked() that mentions the
two alternatives.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
if (!p)
	return;
/* ... Do something with p */

into:

p = scx_bpf_task_acquire_remote_curr(cpu);
if (!p)
	return;
/* ... Do something with p */
bpf_task_release(p);


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
  sched_ext: Provide scx_bpf_task_acquire_remote_curr()
  sched_ext: deprecation warn for scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 49 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 +
 2 files changed, 51 insertions(+)

-- 
2.34.1

