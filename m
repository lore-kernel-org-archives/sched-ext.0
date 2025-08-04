Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72817A2F6
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306887; cv=none; b=EIj2o2ja3ADnMZiQWkb+0jYsVSwghtKvxQXuPJWvyODBsJ2KOQLwloJyTVl3GJXEr8I97HdvpRsvujbi00cZUNOW57saPXTtv2Y21mpiGqAaz+gs8HRWVSApNBLPFij/PRPUSOvbpDmfuY+KJWrDxV67aJnb3HQ2MQThsYKF7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306887; c=relaxed/simple;
	bh=TVL7oBZTW4sAc3iLEJbdMd79Nyh9EdGsVc8HVP/ZcWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XRwmnsolVBuCb/CSczv779h/OTLCW+Zecu4EovYporgOVyQkXg/1sD9/LeOHJwzLUGqqj2rL4tDfKr+NKvenBYUnFqlUZfPpLhUV2nhaKp43LpI1ucn+WjxCvnpWtPPq5A7wGDa1WcjNZn9DEjV9kirO2ULhCUvFhQ8agK20BWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CCAF1424;
	Mon,  4 Aug 2025 04:27:56 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 463E33F673;
	Mon,  4 Aug 2025 04:28:02 -0700 (PDT)
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 0/3]  sched_ext: Harden scx_bpf_cpu_rq()
Date: Mon,  4 Aug 2025 12:27:40 +0100
Message-Id: <20250804112743.711816-1-christian.loehle@arm.com>
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
So provide an alternative scx_bpf_remote_curr() that doesn't expose
struct rq and harden scx_bpf_cpu_rq() by ensuring we hold the rq lock.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
if (!p)
	return;
/* ... Do something with p */

into:

p = scx_bpf_remote_curr(cpu);
if (!p)
	return;
/* ... Do something with p */
bpf_task_release(p);


Patch 1 was previously submitted and can be applied independently of
the other two.
https://lore.kernel.org/lkml/43a9cbdc-5121-4dc8-8438-0f01c90a4687@arm.com/
https://lore.kernel.org/lkml/0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com/

v1:
https://lore.kernel.org/lkml/20250801141741.355059-1-christian.loehle@arm.com/
- scx_bpf_cpu_rq() now errors when a not locked rq is requested. (Andrea)
- scx_bpf_remote_curr() calls bpf_task_acquire() which BPF user needs to
release. (Andrea)

Christian Loehle (3):
  sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
  sched_ext: Provide scx_bpf_remote_curr()
  sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 36 ++++++++++++++++++++++--
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 35 insertions(+), 2 deletions(-)

--
2.34.1

