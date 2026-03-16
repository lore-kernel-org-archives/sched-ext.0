Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A24346FC0;
	Mon, 16 Mar 2026 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639811; cv=none; b=Iz+H0wuVXJXS7PL3VB0x2LzXi5ci2QChxPhX+KS16ngCOa9kwytB+b+52KJ2Q4cTFgNJuGpjkuynXQ+WhNXu5SnL2uoSH5jd2RsCLTFvZDEngMj4YkgnPFonHsP1mE4Yvmw3Ec3IFbSSnThQyaKBJPqfuhfkKYoZiOLbTAj9xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639811; c=relaxed/simple;
	bh=sMMXChBx6w5lN1RhK2+y8S0MCaZAKtUZ/YR+3TZ7NcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6duFWxVbK3DBUYPdGAdSqr2hLJIrsfg7Gp9Ow4iEELcFAuE0VTb4rC59hmrvlvFHSBe1vlGPp8vcNQUhzI2K9l5PFjdV6acMDekUa2PgAaQhk8fA27x7HK9k3UODcrsxq9sjSH6gtQNIZrDgLXrM4pYTRsCKnWMavhsRc9dPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h26jDlFa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h26jDlFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C21C19425;
	Mon, 16 Mar 2026 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639811;
	bh=sMMXChBx6w5lN1RhK2+y8S0MCaZAKtUZ/YR+3TZ7NcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h26jDlFarMh/awPUgVEX4wfWRV6IwglFrpQTAe38KMdLAHl/PInuMkrTgLALUm/6t
	 lqbahlU29abq0r9CLqRdECRNthSlt4FuvJ8NTItk92tO8qqJho+YMX/+GqZIqKwF4m
	 r4qp2H0tA5Uc13VNt/zZAuggC60b4DobM0CXDchCiuSPYSa3e4h3SoxebogBWxqNP+
	 dnRuHfp7mQEfQTUdlnuwlxKxuN6oDc9M9dhXtdbTHOCw5zisiXq8G/heFqTKrkoIBp
	 j6pjHVxBTQRlXB47QE8MnTr67eUg6JsT1R5AMVz+AoY4Mzt1PjYPTs6d+Q2iKmy+9B
	 nULqwRwCLsCmQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Fix cgroup double-put on sub-sched abort path
Date: Sun, 15 Mar 2026 19:43:27 -1000
Message-ID: <20260316054328.838304-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316054328.838304-1-tj@kernel.org>
References: <20260316054328.838304-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abort path in scx_sub_enable_workfn() fell through to out_put_cgrp,
double-putting the cgroup ref already owned by sch->cgrp. It also skipped
kthread_flush_work() needed to flush the disable path.

Relocate the abort block above err_unlock_and_disable so it falls through to
err_disable.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9202c6d7a771..2f70effcc4a6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7050,6 +7050,13 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	ret = 0;
 	goto out_unlock;
 
+out_put_cgrp:
+	cgroup_put(cgrp);
+out_unlock:
+	mutex_unlock(&scx_enable_mutex);
+	cmd->ret = ret;
+	return;
+
 abort:
 	put_task_struct(p);
 	scx_task_iter_stop(&sti);
@@ -7063,15 +7070,6 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		}
 	}
 	scx_task_iter_stop(&sti);
-	scx_cgroup_unlock();
-	percpu_up_write(&scx_fork_rwsem);
-out_put_cgrp:
-	cgroup_put(cgrp);
-out_unlock:
-	mutex_unlock(&scx_enable_mutex);
-	cmd->ret = ret;
-	return;
-
 err_unlock_and_disable:
 	/* we'll soon enter disable path, keep bypass on */
 	scx_cgroup_unlock();
-- 
2.53.0

