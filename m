Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6086314D1F;
	Fri, 24 Jul 2026 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856559; cv=none; b=mIMQ5Egx6bEqjzHr1sbn9rO7HOW1vPVbFRfIGmukD9UmVgsywjnHXbP7A/iWAfvtIlWgMe2VH8jL+jacwX6GoMNWdz/52G9JJh28JQVQRnaa094NCxzB+MTOddaZFcTvwnXLtkAhx7tNtvIQEJzGTQDuWOZZjwSc/2sxP8W2QVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856559; c=relaxed/simple;
	bh=pzKLtTKZ8lEWpvBFSC31ckNFoxAzvuBi4sGs74nv0as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOQ3vIKdOlrpjYI/aXxALvv2sCl++e34oFfuAx937YZS6TQBE49DQL5Cv30MSdIxmtTMMhjTFJLJLZy2wELI+tS4lbPIT5jIMCwpXM3oO41dVyGy8C223QD7PV7SO14OyFJn/0X8we4+YT8URXlVxcBVsPhm3o/1fhZfT+OxD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJT7LTpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJT7LTpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837031F00A3A;
	Fri, 24 Jul 2026 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856558;
	bh=rf2NANC+jWhvNmBCJnAv2iuGbYbpQknxh3LL7TOLu3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJT7LTpBrm3Fj4+U2ciEigKCVCS/MZzEydguHrKcnwKfOyyZ4akFHy49kP7XPdphD
	 +AVP2I/bJnHgm4dv5AmO01LH5nNW69Abx3Dz6e7u5ua4wIbyUXTRK4MHGpsP6DRfSc
	 lINQoBr7+UNTmcA6g+VCY1a8UlinBWNo6QPlnluHsug5iWrL0/pl2VwpfyQmfbpgiJ
	 W6cPcwIY7ShwVXgu9SOpYZoxzEX6JlODrFuAOfb1zllcjHG+c5HYN1fz5MaX3PGs9E
	 2jRCHjJKwZtnS7xgyjDJYOUsGHIHgzRuL7TkxZ2kbXZ00eWC5EXqSCBtl8k19v+arx
	 v9IGAhLgN/y3Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: Use rcu_access_pointer() for the first_task comparison
Date: Thu, 23 Jul 2026 15:29:14 -1000
Message-ID: <20260724012914.107823-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724012914.107823-1-tj@kernel.org>
References: <20260724012914.107823-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsq->first_task is __rcu for the lockless scx_bpf_dsq_peek(). The task
removal path compares it against the departing task with a plain load, which
sparse flags. The comparison runs under the dsq lock and only tests
identity, so rcu_access_pointer() is the fit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 95aadce7b104..53e4aaac46b7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1642,7 +1642,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_dec_nr(dsq, p);
 
-	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
+	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && rcu_access_pointer(dsq->first_task) == p) {
 		struct task_struct *first_task;
 
 		first_task = nldsq_next_task(dsq, NULL, false);
-- 
2.55.0

