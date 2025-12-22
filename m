Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED2311C37
	for <sched-ext@lists.linux.dev>; Mon, 22 Dec 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404427; cv=none; b=Lj72qHLiLr0eBIL9YBLqxO3viH7e2DcIBpsrkj+SH9QY63Mgr+d/vpbaDiZLBHV91q+MYmr4UQ7+yC9s6dlfKcq7AvAM3qN6UZgHenBTtw9DXnuSPVUt4vlMSzJuM9PKiZELmK7J7EtKwnB+q0DnWBZXWQL2Zz97lAk5M/uhcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404427; c=relaxed/simple;
	bh=hC4oZEjxTpyCP6KxsSR8CLmJCVu6YtgC8aNZ5BPhO7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hewi2NpNPWRw6w7WPJ4/NQtRAQ+6532TjhJpU7zPfFjc7oVE4WtlXjpbsb9OTNoP+DbeAessrdjeaiHXoTbjGeIBx2gwXsbMGJ8TD5eqLC99tBVjqfJMN6XT0dwV0XBnnOE6NDlACzUVVuFlxhLBmp3PBhSgKRJnkJ16lPzdkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h21M8yYa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h21M8yYa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766404423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=bHuQHoob5ZAhYSGFMJgCTQzBqKBamqWLxONSfbeTRBM=;
	b=h21M8yYaYnstOPuApmLMhdnQ/saGs6E9Ve0ZwTgGowHi2yluOZF/KPxXttphWuv2OjkDM3
	DdbJ1KyqFX1zsCPNGVyXyIFApSKjygbNKXyfbcfmE/rLyBUr1lUL0C/tksqa5oxGFcYjLV
	g/LMA2pxuU9f3gITCod9loIQJE8JB88=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Avoid multiple irq_work_queue() calls in destroy_dsq()
Date: Mon, 22 Dec 2025 19:53:18 +0800
Message-Id: <20251222115318.18997-2-qiang.zhang@linux.dev>
In-Reply-To: <20251222115318.18997-1-qiang.zhang@linux.dev>
References: <20251222115318.18997-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

This commit only make irq_work_queue() to be called when the
llist_add() returns true.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f6d8d7f895c..136b01950a62 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3439,8 +3439,8 @@ static void destroy_dsq(struct scx_sched *sch, u64 dsq_id)
 	 * operations inside scheduler locks.
 	 */
 	dsq->id = SCX_DSQ_INVALID;
-	llist_add(&dsq->free_node, &dsqs_to_free);
-	irq_work_queue(&free_dsq_irq_work);
+	if (llist_add(&dsq->free_node, &dsqs_to_free))
+		irq_work_queue(&free_dsq_irq_work);
 
 out_unlock_dsq:
 	raw_spin_unlock_irqrestore(&dsq->lock, flags);
-- 
2.17.1

