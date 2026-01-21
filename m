Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3894779AB;
	Wed, 21 Jan 2026 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037134; cv=none; b=XcJwySa67QPOnZisZv0oj4PO/gWCMVFctZ14oFCCdlYMpSf6I/5XD5vqvzfsjBMCfiUZ+wZ8d4rk0rKkol1aD6eSRyKoOI2htzFIzqxcrd93wdrEnG3HyZxZqRaP0dJJ5PLorOZ7ANFxF0ah9SYJDKkjHUoLn7Hql4l5h0RpfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037134; c=relaxed/simple;
	bh=wk37XPSiP0QjtFuul1bNzZuUlj7WjlIhyOufIpV3XlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwCICs0m7ouqhgKLg3kO9BbBWyZLsiWLUT3oMYSpOjFGSxFDmRhSClFKJcU7ebQIsjx3cteBQPqnAwKej1vZaCXQIe/IIFrcZVIpYjNnor2LvTm6gUUpqprdJiymB/sMEUgRAD1PShAiz8Td6CWgvEObkz4Vw3hbKvGMoFCQY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfvrSAMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfvrSAMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECEAC19422;
	Wed, 21 Jan 2026 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037133;
	bh=wk37XPSiP0QjtFuul1bNzZuUlj7WjlIhyOufIpV3XlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfvrSAMeJ8AN2K2sekx1cOUh1E60zQRskv0J0zSR6JKtWrjaOfXlZrB9zPDdmWmxT
	 VTxLixFYe5NNBB4JyyOhdjjIXfcd29y4uFevSSY3lTyhtf0L0pOOiDklziwUPIvZph
	 ehEGd27kpo9z1fqxvarncjJXmMmV2zV/e18e9HK2ofQfEO13bqRh/4vjUY4OBEbIEz
	 UCknC59tjLmamG0Cpi24YZZ2UPBY+A8cWRKbLBow1teM0HOFDlakYByT9EDCtysRuQ
	 1sIVtysXB+yf1FOcvtPEOEyvR1z9kqYLYwuO/ejlGP4VEgxhJtRdUxN8p1bga0D1TH
	 c0U11vYU72//A==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 30/34] sched_ext: Add scx_sched back pointer to scx_sched_pcpu
Date: Wed, 21 Jan 2026 13:11:36 -1000
Message-ID: <20260121231140.832332-31-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
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
index d58b2664f40a..d21a3f805704 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5443,6 +5443,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	for_each_possible_cpu(cpu)
 		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(sch->pcpu, cpu)->sch = sch;
+
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 6ad1c00a72ba..cbe10672f6a4 100644
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
2.52.0

