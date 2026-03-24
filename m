Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC025785D
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353818; cv=none; b=ezzDvUGQa6kEcsd9CGI+v566kiwd6iNA4se9AA0o1B2wh/bceaY1l14b+jAScM/EfnEj2h8PWaMT5TlT6wvMPhYETS4yvTGq3EsOAvqGfLTXeIuBuWdlWwbBFkGsgO8PnsC5/mxMgQRwttsuFln15aRkHBohYGOjx8bhRGTXYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353818; c=relaxed/simple;
	bh=OgwMl9BBU59wkO4jMeeKBXKQP4qdej0R2bWwj5cNAdw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cVeT0GLivBrgD7CrvGGcLFGYnn8IqtRXgpDxuOo/y+/qC9ebxWNgdXkSjlTjhzvYsgsxeP+9zfMPjTbAh96CnKpSCxILsm5hK7/Jqj1u84VCd9kbYTo24ifF++poyplfDTwMOTPu3PQWkJ2j4qdtYvKTAoXk63uLBktbnbcP73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t/Th6maK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/Th6maK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774353814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=UnDG+AGpSBMOmqf3u00JXWeFG2eqQ9lAlo9mgy+QKxI=;
	b=t/Th6maKReuc7r2LThxo8Y+POJcgazu7v1Ec4zTLYD/F36nvvMoRrC8weZtovnVPFHjibL
	3kG/uBoMKG5xU4YOCe9gLhupQAilT4RL3Hf+wy012vJNs9BlRjRW9yeCJmRQeK/pY92JDX
	5eU1ZyiK6BTdqgTTuHVZqs6Z2BBgebk=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Choose the right sch->ops.name to output in the print_scx_info()
Date: Tue, 24 Mar 2026 20:03:13 +0800
Message-Id: <20260324120313.12632-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

This commit use the scx_task_sched_rcu() to get task->scx.sched
structure to correctly output, instead of always using scx_root
in the print_scx_info().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2472231ec556..5d670b50da3d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7680,14 +7680,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
  */
 void print_scx_info(const char *log_lvl, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 	enum scx_enable_state state = scx_enable_state();
 	const char *all = READ_ONCE(scx_switching_all) ? "+all" : "";
 	char runnable_at_buf[22] = "?";
 	struct sched_class *class;
 	unsigned long runnable_at;
 
-	if (state == SCX_DISABLED)
+	guard(rcu)();
+
+	sch = scx_task_sched_rcu(p);
+
+	if (!sch || state == SCX_DISABLED)
 		return;
 
 	/*
-- 
2.17.1

