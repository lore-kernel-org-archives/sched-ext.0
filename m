Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E991DFDE;
	Fri,  8 May 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199414; cv=none; b=NdYmDDRajz4iJjCXgIf15vdjG6wc9a/I0rG/YHNk5F1mG1YLcaX3RLMWXEB4H88o9EPHc8TWncNM+5rIFyzX21kcW5euTI/wKFPH2muJlAv2x7kftrUeT6wYVUq6/GX49h9656O6uWoqYJBLqUbDZCDAOa7MNHvQAoSxl2FU6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199414; c=relaxed/simple;
	bh=S5MClpKvomTXIophHpwHSVzzs95e4JS2EaLDLrkMKQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BiFAOimxSw64ItG0vOSm22De4QF3yxxwcdZd7QU1ZKvXLPnb+WgFQuljKnNOcLaqQbAJRl3lkMq4/LD10HehaKfQ7qabDKM3afa/hLNvI63+jt687Qv0P1Y5ezdit5CH8S2pjgkSwOE5tHCqlSiZEheC4LEBi2XyKs6n+w5eqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN+kVwLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN+kVwLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB743C2BCB2;
	Fri,  8 May 2026 00:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199413;
	bh=S5MClpKvomTXIophHpwHSVzzs95e4JS2EaLDLrkMKQA=;
	h=From:To:Cc:Subject:Date:From;
	b=MN+kVwLQyW0ivR8yt3zEhF7aZl1EjusN6xEQzs6VV8gojdBHNy0fPiX7BN7y7L9br
	 b3+g2vpzc0KuzUw6iKdYculXrgaV7wrsFBxsk0D5HP2Gs9s204Sdcdw8+2C5QFUlX0
	 We7iZrldG6vvNRFlLj8d4wUWPjgmMSonlg/e9x1mKhbjaCPCdhtwN9/qo8hIT2mvJ+
	 UErrVgNY+gaM19SR7JeOgF/OkkXrAxq/8RVbMsxco1fJ2At0kCTMATOkkvfOesNcTT
	 nl//gDqGwev1a5T/g9t3vTQpW8r4CpMufYQUAkC4h+GXamdmP5sTM5ZcDMSlk2a5Ik
	 twNWMVF7AXkGA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix !CONFIG_EXT_SUB_SCHED build warnings
Date: Thu,  7 May 2026 14:16:52 -1000
Message-ID: <20260508001652.3477646-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

W=1 with CONFIG_EXT_SUB_SCHED=n flags 'err_msg' uninitialized and
'err_free_lb_resched' unused. Initialize err_msg and gate the label.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48b4834c7027..f4e2db8e56be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5584,7 +5584,7 @@ static void refresh_watchdog(void)

 static s32 scx_link_sched(struct scx_sched *sch)
 {
-	const char *err_msg;
+	const char *err_msg = "";
 	s32 ret = 0;

 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
@@ -6652,8 +6652,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;

+#ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
 	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+#endif
 err_free_lb_cpumask:
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 err_stop_helper:
