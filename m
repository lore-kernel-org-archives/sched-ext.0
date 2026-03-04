Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380E3DBD55;
	Wed,  4 Mar 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661703; cv=none; b=HIAaQXI6fn6Gqbx+r/8bG4moeVWgpPe3cAZ02cty1TnESQZUEjWFqqmNPOS7gYl+zhpM9Sq8LF+5v4vAzprmidB8Xcg7xMTGs1vk8S7kGiC1p1f2z3YqMqjjh5T8jV1MLl/kPrMk6rAUUx/ik/gHFXl+QYaeJVpbIITWkjw6+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661703; c=relaxed/simple;
	bh=lBuYIYG8FaGBLIEQkB3q9e5c1sJh26dfObh3wsQlRa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O94C89ec/X98RnlzJ5aRVT+XjIXHhkrzOR5vn/OAGzGenFoA7JBn3ii6UzA+f1p8GZLLUp0EEYj5SULTKDiMqoYYN1RFbC9JtPViQwKy0042v/E19DrfhUUbVZT6QxeP2gvXzPOEWfGklSAuCO5g/tavmjmVtaRY7bnpvwnad3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYunSZFW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYunSZFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C6C4CEF7;
	Wed,  4 Mar 2026 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661702;
	bh=lBuYIYG8FaGBLIEQkB3q9e5c1sJh26dfObh3wsQlRa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYunSZFWwHnSZUBtimlpHDp+hpuQVOd+rTrYFliJE0b7hXLy/+jx/RRbQ6S91jlpj
	 ZnfBO4r/PDXJ7s67XsdIfamCwrsBlJOhaYGzLMzd3Qv3TAVsBdTRyxa8uo/z08hlTP
	 7jd7U+SSzsWswMU/7xJ/kCaDhwGeJEx56C1PztKtbi8PvgVOpTDHifKwXi4Gk6lR6O
	 oGfoLpB6NOJ4pH2Z0ENA6nWl3V6Fa9ICWQzl47UM+KZ/lw196DcMm1ofr42AVHxlDm
	 nL/OuGhXeogdgQdeapBZrIXn8BWUVxZhM4aUhXAP3nzZK4xo/OWPUUS6jCP2uDnnT6
	 4Nc2bIFsxFRbA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/34] sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
Date: Wed,  4 Mar 2026 12:01:06 -1000
Message-ID: <20260304220119.4095551-22-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The @prev parameter passed into ops.dispatch() is expected to be on the
same sched. Passing in @prev which isn't on the sched can spuriously
trigger failures that can kill the scheduler. Pass in @prev iff it's on
the same sched.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0082919e2e8f..1570b6a8158c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2392,9 +2392,10 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
+	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
+		scx_task_on_sched(sch, prev);
 
 	if (consume_global_dsq(sch, rq))
 		return true;
@@ -2418,7 +2419,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
-			    prev_on_scx ? prev : NULL);
+			    prev_on_sch ? prev : NULL);
 
 		flush_dispatch_buf(sch, rq);
 
-- 
2.53.0

