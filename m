Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9D3EB7E2;
	Wed,  4 Mar 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661712; cv=none; b=ZgN791xHbGb5xZSgx+5FpJxcOG2t2Ic2Ya7lq4vqBkZhfGp19joGJkgEPRhb2xqwXtQRHviMOfjwH3Ya6b645AsJdHKYRbTihdRzAnBfu5DkZgcyysvjbcl+v6J8eC7RnMEgN52tmdJhGJsi9A35TDChuBPUv72vq5UWCc5Wic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661712; c=relaxed/simple;
	bh=Kfe1bZO69EFJrY0RCeBxLulY5qTAxa55o9g0u4Jw5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLcPGGQMpnHFn8hOHPnT5JFCr6c7VgTTMhsUNcFC8FG6ye1U6eDrbp4sb/SmHfbzJANS2rrQHQrYIAkyCtSJ17+XHZcOjtgWdlhiBFqoY4BOv3vrojW9i/Ux0Y7O1H64tF5X1CwXxwCgVhR+nXSeg1aDVe8nM/Imv+102c4DyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2MLOFIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2MLOFIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D362C4CEF7;
	Wed,  4 Mar 2026 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661712;
	bh=Kfe1bZO69EFJrY0RCeBxLulY5qTAxa55o9g0u4Jw5uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2MLOFIqOmW87WXV/VGDV3ZjBq1l2uu+6OyMKRTiK/JmvTB1cpUDv2q0lEixAbEDn
	 2Re3aSCOb9oI/PEJYzaWYQBOaGmdDaYQtsQAWgHwGDnjdkXByNFHhn7X2dEPQurKea
	 uuSL2P4BpC7EXtW+PogG+rINCWsuTGNX0eqrjQW5K42OAHLVYjs4R5k4FgP9B/2tta
	 2kK1CjhBd4Qu6LtHo+KEvvgk5V0hkrl8alnUvVQvWnRe7d/tIe9C5O0bfKJb/9jbv+
	 tiWkyrb8ZiXeC9m4AwkmxzJwXtzijTd6YC4OI+3tlV1OozUMnY6N6CGrSnE2jLsqDp
	 Y8sas1Tf091Vw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 30/34] sched_ext: Add scx_sched back pointer to scx_sched_pcpu
Date: Wed,  4 Mar 2026 12:01:15 -1000
Message-ID: <20260304220119.4095551-31-tj@kernel.org>
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

Add a back pointer from scx_sched_pcpu to scx_sched. This will be used by
the next patch to make scx_bpf_reenqueue_local() sub-sched aware.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 3 +++
 kernel/sched/ext_internal.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dac94364f187..c7651f40ff86 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5655,6 +5655,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	for_each_possible_cpu(cpu)
 		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(sch->pcpu, cpu)->sch = sch;
+
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 524bd7afbfe6..9029fa4695c0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -933,6 +933,8 @@ struct scx_event_stats {
 	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
+struct scx_sched;
+
 enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
 };
@@ -953,6 +955,7 @@ struct scx_dsp_ctx {
 };
 
 struct scx_sched_pcpu {
+	struct scx_sched	*sch;
 	u64			flags;	/* protected by rq lock */
 
 	/*
-- 
2.53.0

