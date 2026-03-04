Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D783932F1;
	Wed,  4 Mar 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661685; cv=none; b=s+ga6H26Raro6HJOTTZwUOgbHjyDmE6qrpGzIKnUmQRglVxaQHl9V9TERQ4BB8FfEVIlADZQ7gHZJ4YJUZpLo1TJqt04cgDWJpAm+DWi3Gk2T1rx+GjYAF4O8P/CSEco32aUo4PUyuvrMNdpIUeXhNZAGZaeGsL3XH5LE8ScX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661685; c=relaxed/simple;
	bh=k2WAte+6Yxgk4GJPju4ikVYZjJEYr1itTM7IJQG5yWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpVoXLLZ++szVgqesEz4hsk4fd2f4Sfcy5HkudEAIcEox8qSR6g0DPc2rNeCtcW48XcsjCGWDu+MX0hnFPMY3WoYAEcIY9kDTIzOvPQKDHdaGeH108LEvJvpLn5G2GoGINicD3ClWR13IeM16vf0Qe0Ar59O4Rqo4RVUn0lVyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHRiXF33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHRiXF33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E166C4CEF7;
	Wed,  4 Mar 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661685;
	bh=k2WAte+6Yxgk4GJPju4ikVYZjJEYr1itTM7IJQG5yWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHRiXF337/MJrUPUmx6euSmJ+atjnSmRsRNS1T8Nag/q9Frob25k9QQtdXVIFEoGk
	 3hrgczTjM2wpVq4EL/NoO3sre8Gl/rA6cyZc8UP18XqXmbefNvNlZq1QNpCRiQZum6
	 jnj4nO47qiShzIUG33uAk3PJ8BUiFIf8U2BCU0DxlyUzEre6YMpXs56MLjOlc1x5f2
	 ZTcmVtCdQlJNvqPJpDm/MGaKitmYbjbAR9hzzQa9/yMZhbX01j8UWUSOJLxZOGvykc
	 vnHgU+LbulVMVF2LZvv8LK72uCxXeaiu0WRpwndc4bQQSWRoockMjjNOrAkHm8zB8d
	 6d/dGmViB1kRA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/34] sched_ext: Update p->scx.disallow warning in scx_init_task()
Date: Wed,  4 Mar 2026 12:00:50 -1000
Message-ID: <20260304220119.4095551-6-tj@kernel.org>
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

- Always trigger the warning if p->scx.disallow is set for fork inits. There
  is no reason to set it during forks.

- Flip the positions of if/else arms to ease adding error conditions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e6abe7303a2..d1f7de05da04 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3032,7 +3032,10 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		if (!fork) {
+		if (unlikely(fork)) {
+			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
+				  p->comm, p->pid);
+		} else {
 			struct rq *rq;
 			struct rq_flags rf;
 
@@ -3051,9 +3054,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 			}
 
 			task_rq_unlock(rq, p, &rf);
-		} else if (p->policy == SCHED_EXT) {
-			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
-				  p->comm, p->pid);
 		}
 	}
 
-- 
2.53.0

