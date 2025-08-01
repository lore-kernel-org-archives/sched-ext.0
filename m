Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DFF2264D2
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057875; cv=none; b=YZuZ1B1S4qhj85BbJewgqpwhhzXjwnTkQZwZGTCA1ssS0IJ9nbyC8ltnhyyVxvhvBXpj7O4o/+bhVfluiwdQaj5n0Xyq0ZVeKbjTzDMsWrTmDLdTN4psE+L9s7BW7hpqWM7BlmDRGSA6VeNZrjnl/Td1lUU5GvotDQa1/6W3AXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057875; c=relaxed/simple;
	bh=ig8Ck3SfCH2BcN0AVXhy6BfHt/GRT4cxu3on8MCRK9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fE5jbCCzPsSQWqMQw0WYOlOCY4ReAHk21RTqSAtVQUQCPwmAKFsa2pPqtq9wnn6HrfRcTdmdm5yD87hD9bdDr4sUPEo84jXkeGYd+A1VwOsOgAnE2cObczqAdGV85AszKupg0n2CphZQMkeh9j+fbR4OGQXTbIPKCLfFFH3TYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286821515;
	Fri,  1 Aug 2025 07:17:44 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EE1A3F673;
	Fri,  1 Aug 2025 07:17:49 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Fri,  1 Aug 2025 15:17:38 +0100
Message-Id: <20250801141741.355059-1-christian.loehle@arm.com>
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


Patch 1 was previously submitted and can be applied independently of
the other two.
https://lore.kernel.org/lkml/43a9cbdc-5121-4dc8-8438-0f01c90a4687@arm.com/
https://lore.kernel.org/lkml/0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com/

Christian Loehle (3):
  sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
  sched_ext: Provide scx_bpf_remote_curr()
  sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 21 ++++++++++++++++++---
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

--
2.34.1

