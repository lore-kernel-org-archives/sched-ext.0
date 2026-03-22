Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA663290D8;
	Sun, 22 Mar 2026 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211590; cv=none; b=cSIFmDiY1LVnj/k85nC7LSRbUvBT4+ia82pGIvCyZFHpTOfkYgoMb0+qD42wu8wBIJ2+SCA3TYX4ge0QbvRiNKb1unOmhuFayR2iWrGPXGwCs7X+ZhmZQBkAbNpo4uuhTDIMzWRJ7zai86hqaCOrS5avekNG2OJUzBv130WWNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211590; c=relaxed/simple;
	bh=zu1/43nNGJlxxaO6CP+OcmAkDqJ4/L2Y58t5tNI7bOs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=D2un6kinOfleGuCcXLN9XQkjtgWI+PLu8jo5T7FiLL/wMwEoAcLFQMTliy1lvGYLJ5veXjZ2ioZiqwvTyw3jMRhNJlzUU3iS/43bumHw7zTdkMO21pi+hmsIAJEW+U/mhf22KACL6VRq8rES7L23kfUuEkJjf2SpwcKdxDfSIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoAWowIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoAWowIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6A3C19424;
	Sun, 22 Mar 2026 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774211589;
	bh=zu1/43nNGJlxxaO6CP+OcmAkDqJ4/L2Y58t5tNI7bOs=;
	h=Date:From:To:Cc:Subject:From;
	b=CoAWowIbRi8jwn5WY5ICC8bHOKIJUKChLP9bF0ccW3bDNKJq16WNnMcsSV8CH1ZB8
	 Ha9U6RimWJzFrlkH2GBfVgxXv8vlDjOnO9fI08NaH0BLR3g3enlGdTAEHYgBMqEYQs
	 AxG8Gtpm8walyjg18Ne/tnO/Jp9RNnmLSBsrh8d6oHM267HdMIVEPchuUmYmc6McAX
	 f5dSTJNu1UxtiJaGB/KyFHGDHYkRik7zoRumz377nwLx3eBZa5PfNlicJP2fTQvhBp
	 tC1Vv47f1GVpPoBlqrXpPkAB0dq1nkQiChOhHNVNVZ1zyQ/FhU2dZLrafAGLoprSAc
	 AjqNAZ84usr5Q==
Date: Sun, 22 Mar 2026 10:33:08 -1000
Message-ID: <a80d84c345be8fbbd5a1294b9a72ae37@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] sched_ext: Use irq_work_queue_on() in
 schedule_deferred()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

schedule_deferred() uses irq_work_queue() which always queues on the
calling CPU. The deferred work can run from any CPU correctly, and the
_locked() path already processes remote rqs from the calling CPU. However,
when falling through to the irq_work path, queuing on the target CPU is
preferable as the work can run sooner via IPI delivery rather than waiting
for the calling CPU to re-enable IRQs.

Currently, only reenqueue operations use this path - either BPF-initiated
reenqueue targeting a remote rq, or IMMED reenqueue when the target CPU is
busy running userspace (not in balance or wakeup, so the _locked() fast
paths aren't available). Use irq_work_queue_on() to target the owning CPU.

This improves IMMED reenqueue latency when tasks are dispatched to
remote local DSQs. Testing on a 24-CPU AMD Ryzen 3900X with scx_qmap
-I -F 50 (ALWAYS_ENQ_IMMED, every 50th enqueue forced to prev_cpu's
local DSQ) under heavy mixed load (2x CPU oversubscription, yield and
context-switch pressure, SCHED_FIFO bursts, periodic fork storms, mixed
nice levels, C-states disabled), measuring local DSQ residence time
(insert to remove) over 5 x 120s runs (~1.2M tasks per set):

  >128us outliers:  71 -> 39  (-45%)
  >256us outliers:  59 -> 36  (-39%)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1164,10 +1164,18 @@ static void deferred_irq_workfn(struct i
 static void schedule_deferred(struct rq *rq)
 {
 	/*
-	 * Queue an irq work. They are executed on IRQ re-enable which may take
-	 * a bit longer than the scheduler hook in schedule_deferred_locked().
+	 * This is the fallback when schedule_deferred_locked() can't use
+	 * the cheaper balance callback or wakeup hook paths (the target
+	 * CPU is not in balance or wakeup). Currently, this is primarily
+	 * hit by reenqueue operations targeting a remote CPU.
+	 *
+	 * Queue on the target CPU. The deferred work can run from any CPU
+	 * correctly - the _locked() path already processes remote rqs from
+	 * the calling CPU - but targeting the owning CPU allows IPI delivery
+	 * without waiting for the calling CPU to re-enable IRQs and is
+	 * cheaper as the reenqueue runs locally.
 	 */
-	irq_work_queue(&rq->scx.deferred_irq_work);
+	irq_work_queue_on(&rq->scx.deferred_irq_work, cpu_of(rq));
 }

 /**
--
tejun
