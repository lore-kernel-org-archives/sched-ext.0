Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19993469F6
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772956351; cv=none; b=FEC5Lwk6/8thK3ivwk9qNXSNkWQOz68YqeL541virn3+tXY3jNLqcA5eg8Oj/PpioVmP5+SrXKTPOxnQe66E3tve/si8BrsX//6OCF1jhCKFi/AzyK07SG+k/FmJsdQA/Xog3cRhzrxzYk2QKCbXDWTVVxYy860ptaaz4kx7/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772956351; c=relaxed/simple;
	bh=gDKvYEWmlVfxm6sI1YCOPeCpz5ZY53sZbmI8cZbu7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nAvkgWt67zmoUZhTPk9Dp6mUN05txhll+aCLYV1m6UsEvfwvsnSaycimR6JSdjNzwf1PGr54pqj96Dw6NjXCsPQ6qjYoqI88GDZxbOLIUmpgCgnFYRKKvQ+lKX0+8sr0bJMJT4O/w7PubJ4XCjUVCfxFYG/4HcRBlZQGR8p6yFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzijFxW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzijFxW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBAC116C6;
	Sun,  8 Mar 2026 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772956350;
	bh=gDKvYEWmlVfxm6sI1YCOPeCpz5ZY53sZbmI8cZbu7Tk=;
	h=Date:From:To:Cc:Subject:From;
	b=QzijFxW2YF5USVAoCPhC1iJu+rh3zNOr8+G28nxdOIDemyEq+rxqWjWwJfbmmSTlP
	 V6kmOde3qUpTXaynMdditcWxk1qys2WYS7HXJeJ7tmCTepwqqaUpqD8nJr/4aV5e6D
	 TYH2kcjm9+vjCnRC95kpY44Gy+IvSDgET2pe4mj3VxHBPNHb9GSK55zw/Bh4CxWafA
	 d3CbzTh4urZ0gDBEmSJMy5Db6tYEVCeBIepyNeO9kTt31+EH1sEuQtsXQgHN8YKVdv
	 fmXwVNzZcb3qS2Z4wEGtkmFEsHSUMWwgGewHy+wYoAlmRE6IiT20lEIh9tZ2OJlNLy
	 6fejNWjuOToOw==
Date: Sat, 7 Mar 2026 21:52:29 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [PATCH sched_ext/for-7.1] Revert "sched_ext: Use READ_ONCE() for the
 read side of dsq->nr update"
Message-ID: <aa0qvdpOdxW-CjqL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 80a54b807d6c0b98e43522f102da61c953cfd502 Mon Sep 17 00:00:00 2001

This reverts commit 9adfcef334bf9c6ef68eaecfca5f45d18614efe0.

dsq->nr is protected by dsq->lock and reading while holding the lock doesn't
constitute a racy read.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: zhidao su <suzhidao@xiaomi.com>
---
Committed to sched_ext/for-7.1.

Please provide positive KCSAN output on future READ/WRITE_ONCE()
submissions.

Thanks.

 kernel/sched/ext.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f6bafcfe0b93..d6d807337013 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1296,12 +1296,8 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 
 static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 {
-	/*
-	 * scx_bpf_dsq_nr_queued() reads ->nr without locking. Use READ_ONCE()
-	 * on the read side and WRITE_ONCE() on the write side to properly
-	 * annotate the concurrent lockless access and avoid KCSAN warnings.
-	 */
-	WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) + delta);
+	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
+	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
-- 
2.53.0


