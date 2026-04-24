Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1B3E63A7;
	Fri, 24 Apr 2026 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051647; cv=none; b=ctHHDQ5mBdRIpWqycqFizjS4DTDgatGCjcL7wa4ou1CUmaFIZJ/XxkS7T4xEXKBRfl/DLWphLCqraA+/c2mpcI2Fxkp+ieQkMuBBAP5UUttvH1IXrr4aZnxzVvinS2e2azOthFdym75u526SHG75zQ8bDmHtCCLtffz066gtBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051647; c=relaxed/simple;
	bh=uqXLflywe9C9UiFcc9RHvFzM3t/SMzACQvf5KfdMLAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhIgyMIIu2j3V+lyW0gaFkDRfjLel+RhiYtC1wtSyrWfVLw9CSSJK35u00KWMrN25QoGef6Rn9jrCXHd7GNKt7ag+PguSO254wt8rQXsC1yyBIul8ElbJHAcPlpc7AvB0dCEcBoeQVzTT1ric9d7KVre5WwQqN2evg8fIjIpuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH1CASYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH1CASYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA0C19425;
	Fri, 24 Apr 2026 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051647;
	bh=uqXLflywe9C9UiFcc9RHvFzM3t/SMzACQvf5KfdMLAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nH1CASYK6pyWbJ9Hbn0y+k/8xmyS9zxlXS/FRuC2cTOBAHcN6ooCk01nkxauzgB+D
	 AhVrLD6lge9+009MiMfLCR6gQyYKSnrKRAboG0gSJjoSvn7fppukPg8FdnZNpG9om2
	 fnGwaNOkkzv+nXROVS7XPAwHKooMU8hpb9IoLFR42DBqeeMjpJXHEKb2XGiUMQCR9K
	 EFXBrFb+KUE+WZGdiqTNy4yfKgGplkWZe6dNuLMQ2H2cqytxDt7XrNFG56BZiQdGEm
	 aHxFIFLD5n1yBzOsp9ozR8g0LvgjyEjFOVlfBQAhSDNnmjkLCltYv3IScIMubUUyKC
	 KlylMTTyoQacA==
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
Date: Fri, 24 Apr 2026 07:27:08 -1000
Message-ID: <20260424172721.3458520-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
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

