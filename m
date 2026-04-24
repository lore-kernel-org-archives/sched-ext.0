Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66B282F34;
	Fri, 24 Apr 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994346; cv=none; b=hzACVHERDU1wlI2h+qqyMTYBEfsayHn4X4XgWyEfr+BrA7fl2Cx9I2hpQ28KY3l/7Ujvgvajk/TuD5DtA909i0WpemDsckqzPhW5MIqqCEaVIwccw8Rr5aP18h6Opf5JFR/vU1l2D8RZOHbXXmg9Y9n7paSOl2WiyeZAXvoiCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994346; c=relaxed/simple;
	bh=uqXLflywe9C9UiFcc9RHvFzM3t/SMzACQvf5KfdMLAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIB0qh65U5h3IWLN3t1wl+76nutNIC/TZDdGGGoZP4q35hviPEZ8zoZ5sTU0mhf/uY826cu58VKt6VEXczL6J0n/xqeHgqOBjzIH8XY2dLdS1yILPc/GKkJ/LU9QZz7/zrjFmqQfgsLBV0VNojHFEkLHRJL1beCnqq6Z/C8uQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvcVG2xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvcVG2xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9C4C2BCB3;
	Fri, 24 Apr 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994346;
	bh=uqXLflywe9C9UiFcc9RHvFzM3t/SMzACQvf5KfdMLAg=;
	h=From:To:Cc:Subject:Date:From;
	b=IvcVG2xoIGzXYWKhVLXExitVFSnEB8GbFSX8CIZqkj9C1vnlHexP/voBVMkKqYNtt
	 WQr8P65fDr6VlNTDb8oqrF1hSLs4ZSW0kb6UY2IjbZ/4O81pxZXczcqueSma0HAoz3
	 z6eKB50GK5KgbvqSeSBvggYRQTK87o8UOAwkilYroYb0mIiGrnf/rebG2X/BSlpbAw
	 unAmX+SoYviTLEwAPx6CxRsDtudiFoSlGzjrvVSPwLBts/IbkuPyPFmHDNk3U0Twfg
	 BTsLl0cvkU6hVBm1y4V5cPL1fnW4umSMTFyrW4fjZW39rsEZEd/cvQbTHFd+0rqJdT
	 hIQ9zOvGogfZg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/17] sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
Date: Thu, 23 Apr 2026 15:32:07 -1000
Message-ID: <20260424013220.2923402-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers that already know the cpu is valid shouldn't have to pay for a
redundant check. scx_kick_cpu() is called from the in-kernel balance loop
break-out path with the current cpu (trivially valid) and from
scx_bpf_kick_cpu() with a BPF-supplied cpu that does need validation. Move
the check out of scx_kick_cpu() into scx_bpf_kick_cpu() so the backend is
reusable by callers that have already validated.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d57ba3df0c8c..a94e621d2c6c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8674,9 +8674,6 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!scx_cpu_valid(sch, cpu, NULL))
-		return;
-
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
@@ -8739,7 +8736,7 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (likely(sch))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		scx_kick_cpu(sch, cpu, flags);
 }
 
-- 
2.53.0

