Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912F1DF27D
	for <sched-ext@lists.linux.dev>; Mon, 17 Nov 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384011; cv=none; b=LDeTkIbWPHFgZb4p0W26fiZ5m8j2fUe/YGuVJ2PijbYgu9QLW7kOdSDuZHJUFnjYoFVEBYztjsbQoMKU1Kz0Ku5k57uyKUn+MFMXVZJcbN19TmXxoEIHYbyVXuCUrLVKfFgFR35tSYHr6A72sPs+KHs8ymUJkE8+vlTmuPyfzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384011; c=relaxed/simple;
	bh=D3JRjoGIp2W/xKQKZllojR67fXSSAJjjAbJmeRNxRN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ym/oTYFmJGIaMxDaGf+ouHO5TKeu61Um3hG6YBRJpW8zBMFyCYUZ8veyvFkoeie69+ZEDVGFeKeNgeRKcqidbmFTe49aIqyAAGmo5FrMQnJvEGAWjIJOdZrUQBeLq5pUnqji0nAAgWTaFAfb2fv0eIRdUSZVCrTzY+SiivelLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rybdaxK8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rybdaxK8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763384004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tbj/dYxEeRLF/Vk3A+CJ44vVCppp0vNdAwYnP6OMnGo=;
	b=rybdaxK8GayDD4Az9+bn3py+OqsaK4+2seME+RUg1PExkTSGJvU7+vQhUs66FuknNvaxwt
	iXoBwqksRC8Xj/8+3hoD9QjZAqAHQZgq2+nflCj8EI8Vwz07ghmsqS3L030UOSrycQ5CUD
	rOARldKhcv/a585tDX82vWskDCZoBdM=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev,
	qiang.zhang1211@gmail.com
Subject: [PATCH] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work
Date: Mon, 17 Nov 2025 20:53:10 +0800
Message-ID: <20251117125311.107687-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For PREEMPT_RT kernels, the kick_cpus_irq_workfn() be invoked in
the per-cpu irq_work/* task context and there is no rcu-read critical
section to protect. this commit therefore use IRQ_WORK_INIT_HARD() to
initialize the per-cpu rq->scx.kick_cpus_irq_work in the
init_sched_ext_class().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8b88a9e69f8a..c8de9ec70d75 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5628,7 +5628,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
-		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
+		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
 			cpu_rq(cpu)->scx.flags |= SCX_RQ_ONLINE;
-- 
2.48.1

