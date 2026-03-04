Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C93EB7E2;
	Wed,  4 Mar 2026 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661709; cv=none; b=guGVAUwPX8GBRRFw2uJ7wdCV2p4c6E56RiQQ+uHsW5WvES9aCiuoeizNePyufOyorHCakUp1ZmlEhrbhXC/UXxWmZUdbUktXLQcuDOIhNV1mbPwUbomT+5VKJTvfO6gjZI4736bzUrjDeYxiEZxDKaIrQ+43W75O8UumVZNRaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661709; c=relaxed/simple;
	bh=NENahHbec0Fe0skGpqBpDLEVGhRVFFr40DIcLRb1Hzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X//kpRRiWgshUHgKg7L8wWWLi3VVwPFfLpYFRfz6x3dy0zPds5zCS6XfKQuPmmcR/3pO2FCmrPZMDcvmF3QBhXAOkBVLXJ/+RuNcoN57SEo/hbDbkbGl16VPf2NLeH5WG2HaB0x4aRBj93s2qx6orSYG+rtv1Pa/TTMoFNocSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBc1JIM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBc1JIM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D834DC19425;
	Wed,  4 Mar 2026 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661709;
	bh=NENahHbec0Fe0skGpqBpDLEVGhRVFFr40DIcLRb1Hzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBc1JIM0NtbRZTEdutjJxyvIi93FIvCor1Ys5HYj0nVOkLw7ZhpUB4lwu99WMu3ip
	 wfariZrsCYFpUEdIcpe0smJzkcEe29HFrPg9SU3UhS6cLhZUZfMh1p9jkYkxFKgH92
	 anevEOtXk/Hpli3Mns03NsH8Ubd8xJeJq2pHe2OTy1imT9LrcQL7Dmplvlh0UzNqjM
	 IvkeTvNenipoi5+rguJpNYbYVtxf5CloMhLjRmBu8bkjw+hQ+MvYIcBtH/MxspBrWO
	 CIDyNggYeaCuzg7uCIdjmKc1TipOFItJ+iXCFcoQh5gLXEY61o6Zam7kvLBWqv+lDM
	 Xc4TDi5/N2C/g==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/34] sched_ext: Convert scx_dump_state() spinlock to raw spinlock
Date: Wed,  4 Mar 2026 12:01:12 -1000
Message-ID: <20260304220119.4095551-28-tj@kernel.org>
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

The scx_dump_state() function uses a regular spinlock to serialize
access. In a subsequent patch, this function will be called while
holding scx_sched_lock, which is a raw spinlock, creating a lock
nesting violation.

Convert the dump_lock to a raw spinlock and use the guard macro for
cleaner lock management.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e2f919d3ec3..2811e3f7e9f0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5220,7 +5220,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 {
-	static DEFINE_SPINLOCK(dump_lock);
+	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
 	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
@@ -5232,11 +5232,10 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	};
 	struct seq_buf s;
 	struct scx_event_stats events;
-	unsigned long flags;
 	char *buf;
 	int cpu;
 
-	spin_lock_irqsave(&dump_lock, flags);
+	guard(raw_spinlock_irqsave)(&dump_lock);
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
@@ -5361,8 +5360,6 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
 		       trunc_marker, sizeof(trunc_marker));
-
-	spin_unlock_irqrestore(&dump_lock, flags);
 }
 
 static void scx_error_irq_workfn(struct irq_work *irq_work)
-- 
2.53.0

