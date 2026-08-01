Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3442DA775;
	Sat,  1 Aug 2026 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574325; cv=none; b=eNKo7piMi5aimF7mAWgwXYSrWsuxGHTShy4TrGzsVUuCoRTTd5jLoMvdtQWU5iXb8yHv07R0vsVZCDZHhi3M9n/OkPljMdkBwU9YMl1b0XFgh7vd+VSMxn1AntzFJQd1rFxin1Y2Afgcahz/5HqnXzZTwyV8GCdrza0kk1sM53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574325; c=relaxed/simple;
	bh=Dx2lfm0Spa67Yweq3qHvOgTUQEkjVpnkUgDZIMd3Az8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgxMHY2cNL6LYGhsfn30oQ7OxU3x7BypfnkUFJBC6eVX66+EhyGAHTWldxCN8zwJQ0guY7Xd49+HffBu7SR3AEr3Xb3XxzG+CisEpmyjl0Upwr55HER4HpFdUpcQssvCo4iinYSJ89oCIvD+wr7GDrzoW+L5Y78J4I0c7uE4n1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9OSVdfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9OSVdfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E11F00ADE;
	Sat,  1 Aug 2026 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574322;
	bh=37u3WufUpVJF/pGTYol6nwIu5efHfC1htT/IT2Xmzxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a9OSVdfa7ymUbSnt9sQBWOG4qJa/0O7FTryk2UGk9mmsoBzZ0yCSRn6P9OeIplNqh
	 wTw6vMq15dIOBDMwBmBJJR7DF5I2HfSvwDeo1GVl8EIxd1pl1zBFB26gU5ZKm+IkjE
	 pS60DsdLrA2b4NL/TY59NcF1wNj8irqLPwld1hLLIx2UPyEtevzLm+/8kNzycLDNDQ
	 EG9j428Jem/F47bAYx5PVgbDE1+LakiH2kEYtFnD23KeBf7zJke+CubF/Bp4XAwtNK
	 O0MhPKQhCF8I9FdAMS3oCNRZIByPlwQbpO9QMQXnYaosOAIvHiVqOovdi8lACJBYxv
	 V24GjEcYP7iUQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/12] sched_ext: scx_qmap - Idle-check pinned tasks before direct dispatch
Date: Fri, 31 Jul 2026 22:51:49 -1000
Message-ID: <20260801085150.2697653-12-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_direct_dispatch_cid() sent a pinned task straight to its only cpu
without an idle check. An insert onto a time-shared cid is forced IMMED,
which may not wait on a busy cpu - the kernel bounces the task back to
ops.enqueue(), the shortcut re-inserts it, and the loop runs into the
reenqueue repeat limit.

Run pinned tasks through the same idle test as everyone else and queue them
when the cpu is busy. always_enq_immed forces IMMED on every local insert
and already skipped the shortcut for the same reason.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 8822ed11c0d8..9a0321e84e88 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -230,9 +230,6 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 	s32 cid;
 	u32 i;
 
-	if (!always_enq_immed && p->nr_cpus_allowed == 1)
-		return prev_cid;
-
 	if (cmask_test(prev_cid, &qa.self_cids.mask) &&
 	    cmask_test_and_clear(prev_cid, &qa.idle_cids.mask))
 		return prev_cid;
-- 
2.55.0

