Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FC283FCF;
	Wed, 21 Jan 2026 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037105; cv=none; b=LQ4NenhyddzNXLRkUTREgE15Ign6u8KKwcUWs0L/PTZAZLtsUPGkpd4lyF8hSUjPf4hTDDJAKL9ctTKuijWsQo8HgpWKs0BMNssyjY/ooLPg4rbEabgd16K18+MqRiY90W+NdQ7stZ5QRm6L1DvbTWNzmbfqtT47bw7h3Uwo+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037105; c=relaxed/simple;
	bh=JX5WU4Je5PL4G6Kt3cgUEAGhcdZNfdPIwVIt7Qn3DNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR7MkqQSgSULPNo9Fi/P27qAMwL/5IMB30U68vKud8UuiNPUdhFNKTHVMpJy6SUngEJGI2yetJvrgg5gRrlC6nfdAUOFlja5qF2v1quHRJYCyrisCfCwJdHh9j1d1nIN+kufA7RZgihWN90ZhohjdgvthXGXoIovTp+VRSeBKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEQNEeyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEQNEeyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA23C4CEF1;
	Wed, 21 Jan 2026 23:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037104;
	bh=JX5WU4Je5PL4G6Kt3cgUEAGhcdZNfdPIwVIt7Qn3DNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEQNEeyQccJNFuH4N1AW5KtmIdGUGORI+HYU920eeQKMiXI81FrvmwuGNguE+6Co4
	 M4ARAU+EDfICKv6CRYXvLcMkfwHTrsZyXAEX3RCn2b74c4QMbdx9tukzmFMJ5geQUK
	 R2ziqio2t/8fy3eE5pS/hZ8DU8Iy7jwTOCCYR5dMKjVQLupS9xu9r08fVFcEq2leSU
	 5vaRs7akxZmDu0qC11SFgCnVxuUQrnJtPQXjkI7CluEfrZ27HQ9VoW4H6oKCPEK42U
	 VHdBbGQSrqL5n2vt8Y34iWvdFghTWad/eQs6DiNlFXiEUiVQii8Knxr/NXujTghQ28
	 9CQFY7fopAbXA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/34] sched/core: Swap the order between sched_post_fork() and cgroup_post_fork()
Date: Wed, 21 Jan 2026 13:11:09 -1000
Message-ID: <20260121231140.832332-4-tj@kernel.org>
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

The planned sched_ext cgroup sub-scheduler support needs the newly forked
task to be associated with its cgroup in its post_fork() hook. There is no
existing ordering requirement between the two now. Swap them and note the
new ordering requirement.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/fork.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8e..726d3ccad15b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2461,8 +2461,12 @@ __latent_entropy struct task_struct *copy_process(
 		fd_install(pidfd, pidfile);
 
 	proc_fork_connector(p);
-	sched_post_fork(p);
+	/*
+	 * sched_ext needs @p to be associated with its cgroup in its post_fork
+	 * hook. cgroup_post_fork() should come before sched_post_fork().
+	 */
 	cgroup_post_fork(p, args);
+	sched_post_fork(p);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
-- 
2.52.0

