Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F836CE0D;
	Wed,  4 Mar 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661684; cv=none; b=oTP4dvAw/18Q3VtQZX0QTWK52CQ5xjUkta4I+t4YpzpimyxKa6qiJqt2AKc1CmIaqBJmf7dte12ZWa67gOYXfoMciPHHi42K5iTcxqBVA1wq+xYXWII1na5ldtuvnfAm1pJAaSAzo8KyBrOAmZsJW4cBck2bIP0SNweVYnLaIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661684; c=relaxed/simple;
	bh=E26OVCEL8c3zQQvvezdfLrOf8JY6Y9gT2qAcLHEB2+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYOYbmTADzQxNhLPCC9p7y+c5Rf3+A1d4CmYKbluBa7kPOI8ehgJ0UwVMVw7jrgp2Y6XAmeFHFO/4ZQ0PM9Jm0AxRrZxIG/flOoq9vRICbtxSEbgwaBnBrzb+CVhw6MBbsb1PC+Q7IWLmGcbanA9IWkYNqKvhtoFYW2/b1e6wDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfix8DHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfix8DHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75681C4CEF7;
	Wed,  4 Mar 2026 22:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661683;
	bh=E26OVCEL8c3zQQvvezdfLrOf8JY6Y9gT2qAcLHEB2+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bfix8DHP9o4qcABmcS7i2y6TVzVsD9fJdbc4URzTjSbnlqXPN1Yqka/VsSDYxIvM2
	 vCqhOH3pLU4ElJPFe6fkBlYqwyylhahcP92umKZVdlo4hs90wsv8epN7x0iOjpSWeT
	 GzFIWv1yOF7iE/leHJE7lrdRP4YzvF+IgwCgwuG6SWh5zDkB3H6L67g0cZhHb2uNfS
	 +D2l2GVPNmn+N8NjOFG3DYqSD36v1pwhoA7YHdJABrd1LYf7lVwUcStGBqgRKwYGIW
	 vm/Bchys49iK0dy0Sgu/J6feqAdSrXU1KhOZIPDhE3tkoWTIzadAWT3936DNUJ+Z4l
	 Nms2QakeyY6gg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/34] sched/core: Swap the order between sched_post_fork() and cgroup_post_fork()
Date: Wed,  4 Mar 2026 12:00:48 -1000
Message-ID: <20260304220119.4095551-4-tj@kernel.org>
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
index 65113a304518..4759b6214df4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2463,8 +2463,12 @@ __latent_entropy struct task_struct *copy_process(
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
2.53.0

