Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC733A9F3;
	Wed, 21 Jan 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037131; cv=none; b=XZxLCOmw3qf6DOv4DkAEBgw7u0WZ4K9s0zQDPYFc+KfjW8b1SrogTHNeyacPfECSZr7etaC3dN+q0dtxHlxFyOF52jxFcVq4Ao0lJ7s/qYYl+yZk9p86ubo0xe1o1QLvm83VHptubYwTXeJ0ZyK9RtF3/mx7+w8TlR/gIB/Wo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037131; c=relaxed/simple;
	bh=9lgelVngAgEDqKXUZ15e6KyOT2gXio+KlQl4Sp2atRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/ahsmSP7cRh97JMhq+jR9ml8DW4Vo88SQfP4EhBEkwZg8zYv6GfITrQgDRaUwRSa1TjC9Fao2p3yPmWV7eYU6OdI08L0JVaZ6Zt/gk6CJ64WrGASkc15gnNN00m5Sw1Ha0/tAmL/p4EwEJPVlv2mXdoqvwW9O9EUU812VZo4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDdBaVgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDdBaVgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F27C4CEF1;
	Wed, 21 Jan 2026 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037130;
	bh=9lgelVngAgEDqKXUZ15e6KyOT2gXio+KlQl4Sp2atRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDdBaVgdhUl2dkCP8SFCXpTKt3iA8dbrNNTWBpyfFvWX5oJWXs0WicAC0xZsXQPx2
	 P5vRLbufcm4OjBRh+OUdNkSrPQGmoI3NNOmSGMCVs1eRqs118Re/7+PXwPDcZVvVp8
	 HUBinQQ/Jp9uQQ7Y5ZYjj0KeFAXjwGocK45eJhX5CkZEdIpDQSWsLG1LJSermwIG5c
	 c3rRWLlFCvO8a/VG2hbhqYiT8ldEzAw+w/DAZzqHoCQKMopinyFn8eWVabzfGRRMnf
	 J6TlEMGHx/pxXGs+lIZ999AR4CevbgjA1/XNPG23P52cX+KzqXHN4YLmQ5dDLDXryV
	 8AqE0IZuedhqg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/34] sched_ext: Convert scx_dump_state() spinlock to raw spinlock
Date: Wed, 21 Jan 2026 13:11:33 -1000
Message-ID: <20260121231140.832332-28-tj@kernel.org>
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
index e34896a57780..e8d7ad0a8a6b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5014,7 +5014,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 {
-	static DEFINE_SPINLOCK(dump_lock);
+	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
 	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
@@ -5026,11 +5026,10 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	};
 	struct seq_buf s;
 	struct scx_event_stats events;
-	unsigned long flags;
 	char *buf;
 	int cpu;
 
-	spin_lock_irqsave(&dump_lock, flags);
+	guard(raw_spinlock_irqsave)(&dump_lock);
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
@@ -5155,8 +5154,6 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
 		       trunc_marker, sizeof(trunc_marker));
-
-	spin_unlock_irqrestore(&dump_lock, flags);
 }
 
 static void scx_error_irq_workfn(struct irq_work *irq_work)
-- 
2.52.0

