Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133044D6BB;
	Wed, 21 Jan 2026 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037108; cv=none; b=XATjRIKggnjeX27FRKmZrM+zbCFPfUTfcD8LvehVLS1I8k17vHLynBjs9nMU8UXS/Um02nlxZU+uXuoAP/rmpVXwNmtiFG4n5+JNsMFVlWv+vNaLRbAt4IT7JYCFYSHvrSYGieucvmhknvxFpM95hufMAc0YMub3+4lJ0dg11w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037108; c=relaxed/simple;
	bh=HjQgIdDIxyx1uPdwvSa6MUZW1bh+8Du8uQaqUmH7Zm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTasdUTyuB02XprvmOrG4gD3oqhu7Rulc4lAaUb0CTt6dZBUTRs0O5l79v5jVhFG3tsWXQsbgWiAyl1uPOjMAm/Mm3VKmzFZaYeirakJkkmgkrqgV9gQ712O+/XJ2ZbqxlIzchwJpbvrOBSqo2kIT5P+Yliu2oPuPru0o2dXcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzy3aGHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzy3aGHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EF1C4CEF1;
	Wed, 21 Jan 2026 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037106;
	bh=HjQgIdDIxyx1uPdwvSa6MUZW1bh+8Du8uQaqUmH7Zm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzy3aGHQctCFsaL0JS5sxo71V06neIDQWIJ1x9FXOla3OajOithRfV6jXSOvsn/Jx
	 qje6NzrjHMwrZMMk5flxUpNIpAUQ89g2q3Ytil+PK7XNwj2IcBZPucPTNN2k+7k1QB
	 wrDeF9lzjWt30u3oDBmPYTJvkibv7rWtBybi8o7wOJRNi19qGMhn5A9A0J2PXKzoDn
	 3vKog2Rs6dDCFG+HQMtBECM5NlrDWgDwz0r2q/w0mCZhYqWQOJ8PeGMPPNTXYeyP6w
	 zVwJOJMpCuowS5USi1L5/VqhRaYM7eWsmBx9Mq/hWrKwZ3LjbqAitZjOd7Urq3Zrou
	 QS8RPENZy3MhA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/34] sched_ext: Update p->scx.disallow warning in scx_init_task()
Date: Wed, 21 Jan 2026 13:11:11 -1000
Message-ID: <20260121231140.832332-6-tj@kernel.org>
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

- Always trigger the warning if p->scx.disallow is set for fork inits. There
  is no reason to set it during forks.

- Flip the positions of if/else arms to ease adding error conditions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 213f421b00e5..e61af4b0961c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2908,7 +2908,10 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		if (!fork) {
+		if (unlikely(fork)) {
+			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
+				  p->comm, p->pid);
+		} else {
 			struct rq *rq;
 			struct rq_flags rf;
 
@@ -2927,9 +2930,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 			}
 
 			task_rq_unlock(rq, p, &rf);
-		} else if (p->policy == SCHED_EXT) {
-			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
-				  p->comm, p->pid);
 		}
 	}
 
-- 
2.52.0

