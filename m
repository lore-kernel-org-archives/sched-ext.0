Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222A374756;
	Wed,  4 Mar 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661706; cv=none; b=H985sLhE8xVdkWIApSos+cGCMtoHn2Q9MFQwNzPNdi80zEK0xm/VqRmf16hq1MU6UwudTochzBMnNH9SbvQJ21Wvc+eKIz52ZSbnez7AOv3VoxNZHuh5pueXvPF6l3MWx/fCD2DnW19oqlB1DK1+1JmZqlLzJcEsEd7AnXeh0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661706; c=relaxed/simple;
	bh=FFbRoBIXoqmdtObLRdAaoJ7JVihdNAUnkHTDQh0yjAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr97gJJf5H5+Mr6kGJ1cEZ9cFomtMfS3uckJ4g3jVKPLxPad4ekLRQKtS7sNN6r2BcFHRNfCG0s1pzEnS9gHgakF+gRQpvhLbNatE05hakjHvskhxYxcoU/rlO2kujHMGzzTb2T2VPRqoGy20XnvS0DbgQ0pyIKNn5X7gIKr1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEnF4ok7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEnF4ok7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71ADC2BC86;
	Wed,  4 Mar 2026 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661705;
	bh=FFbRoBIXoqmdtObLRdAaoJ7JVihdNAUnkHTDQh0yjAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEnF4ok7cHQYpi90IhG0qwaLPY+KIqxZXiFikB7WUDl68s4K4ak655U0JRfeWM0f2
	 ZMDHwdeD/65qe0yJWD+eVxl3McuwvHps/n/j9cEb2+kBg2sBbKhKUe5mNMNBA2paDD
	 j0BxZAkVzAHuZimvXSAv7fRLqlyqDX9EkfI2fFqjZiziVFtlwvayodHq5dzZQSg6Wq
	 jOuFQ187hBYcUKjNNMnlOjzvnxtKOGUir3vrfdMVb7v/nxD3BV+OIDE1Dv6AwAaiwd
	 z0n2DKGBGhnJr9Z55J/HD1bWMx9z2Y2aDu897eSPmtoTH3zgW+cPSGJtv6vg7jqDdS
	 W8LbmQIZLXSlw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/34] sched_ext: Dispatch from all scx_sched instances
Date: Wed,  4 Mar 2026 12:01:09 -1000
Message-ID: <20260304220119.4095551-25-tj@kernel.org>
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

The cgroup sub-sched support involves invasive changes to many areas of
sched_ext. The overall scaffolding is now in place and the next step is
implementing sub-sched enable/disable.

To enable partial testing and verification, update balance_one() to
dispatch from all scx_sched instances until it finds a task to run. This
should keep scheduling working when sub-scheds are enabled with tasks on
them. This will be replaced by BPF-driven hierarchical operation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2a19df67a66c..09b756141d2f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2526,7 +2526,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root, *pos;
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
@@ -2570,9 +2570,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/* dispatch @sch */
-	if (scx_dispatch_sched(sch, rq, prev))
-		goto has_tasks;
+	/*
+	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
+	 * hierarchical operation.
+	 */
+	list_for_each_entry_rcu(pos, &scx_sched_all, all)
+		if (scx_dispatch_sched(pos, rq, prev))
+			goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
-- 
2.53.0

