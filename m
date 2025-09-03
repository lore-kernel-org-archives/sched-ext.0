Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4862EB86C
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934613; cv=none; b=PQBnVM5CTvvpAiT+gh8i6uEfa53YrNGa8+jouRHZTkc5hiLTwdylsAUDGfkuXlC9UCQpjHxJF3l0gN6mrojelm1xfwLyunfXpzof3ca7g7QFiMQNwBU4GSIxk8q6icMN4xMyNxT8amrUnXHhRJrTQeweYuDc+02pkFkrLKSym60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934613; c=relaxed/simple;
	bh=h1QhN/kSTcrpq+tj/cQL6u+Ya5TSdAHv2+PcPv0chsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rl9NK3jPf0W1m6fzfu/xWhj2IqMtXMiRlsDuNwffyMkgHnkXqi3lzQi5SwA89Hh5yfDOEcmGaNTycZ1mlD91v+LQVk3UYyBSLuP/AaFNLqvFdwRSA42KyD3xhEi7BVylFGJXakRIsFVpjfVYoHsvz55LrdRQR/3Nqky9E+mraDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E26C1655;
	Wed,  3 Sep 2025 14:23:22 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.93.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 915283F694;
	Wed,  3 Sep 2025 14:23:28 -0700 (PDT)
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
Subject: [PATCH v7 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Wed,  3 Sep 2025 22:23:08 +0100
Message-Id: <20250903212311.369697-1-christian.loehle@arm.com>
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
So provide an alternative scx_bpf_cpu_curr() that doesn't expose struct rq
and provide a hardened scx_bpf_locked_rq() by ensuring we hold the rq lock.
Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
/* ... Do something with p */

into:

p = scx_bpf_cpu_curr(cpu);
/* ... Do something with p */

Changes since:
v6:
https://lore.kernel.org/lkml/20250902111143.2667154-1-christian.loehle@arm.com/
- Rename: scx_bpf_cpu_rq_locked() -> scx_bpf_locked_rq() and
scx_bpf_remote_curr() -> scx_bpf_cpu_curr() (Tejun)
- Print the deprecation warning of scx_bpf_cpu_rq() once per scheduler. (Tejun)
- Picked up Andrea's ACKs (except for 3/3 because of the logic change).
v5:
https://lore.kernel.org/lkml/20250901132605.2282650-2-christian.loehle@arm.com/
- Actually expose the RCU pointer in scx_bpf_remote_curr() as such (Andrea)
v4:
https://lore.kernel.org/lkml/20250811212150.85759-1-christian.loehle@arm.com/
- Remove cpu argument from scx_bpf_cpu_rq_locked() as SCX has a unique
locked_rq_state anyway. (Tejun)
- Expose RCU pointer in scx_bpf_remote_curr() (Peter)
v3:
https://lore.kernel.org/lkml/20250805111036.130121-1-christian.loehle@arm.com/
- Don't change scx_bpf_cpu_rq() do not break BPF schedulers without the
grace period. Just add the deprecation warning and do the hardening in
the new scx_bpf_cpu_rq_locked(). (Andrea, Tejun, Jake)
v2:
https://lore.kernel.org/lkml/20250804112743.711816-1-christian.loehle@arm.com/
- Open-code bpf_task_acquire() to avoid the forward declaration (Andrea)
- Rename scx_bpf_task_acquire_remote_curr() to make it more explicit it
behaves like bpf_task_acquire()
v1:
https://lore.kernel.org/lkml/20250801141741.355059-1-christian.loehle@arm.com/
- scx_bpf_cpu_rq() now errors when a not locked rq is requested. (Andrea)
- scx_bpf_remote_curr() calls bpf_task_acquire() which BPF user needs to
release. (Andrea)

Christian Loehle (3):
  sched_ext: Introduce scx_bpf_locked_rq()
  sched_ext: Introduce scx_bpf_cpu_curr()
  sched_ext: deprecation warn for scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 47 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 +
 2 files changed, 49 insertions(+)

--
2.34.1

