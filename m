Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02E22A7E9;
	Sun,  9 Nov 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713075; cv=none; b=AYnbge0HGRjXWuvz4Bfh+6Y8GEesTyQ7vnLhqhl0HyU9+1jwPheqhtxYdiisZtwhT4nHwAXnppssi9hYdOS0konYbBW4OG81NyueprfBUpEPztCxpb9J086ZSb2dNM2nIOZc2e9LY8RL0tQbVuT7jzcwGnOAh9NPeGZG2bQaT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713075; c=relaxed/simple;
	bh=LxGjkTklcEH59FmuhV0EwrRPbF0LTFCa20MfII6HxSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ3j5wf80xNRt8rrIyRkw6F2dEpQWTvJEAJPYwgYgz3XnAC6KomPW1suoFlt4R+n2M6woUXEdv0240xEs4eFrKa0oeeJ+Efa1UN8zq/53nblcZOBZKhhwmsZGteg4piwZtdOXO8EN0ENG9SHLbdU0tcUuCc22A+3ku7AUIReGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbR1nWl+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbR1nWl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F2C4CEF8;
	Sun,  9 Nov 2025 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713075;
	bh=LxGjkTklcEH59FmuhV0EwrRPbF0LTFCa20MfII6HxSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbR1nWl+6mKr1WZxF8RVF90IEtHlyQDaEVdHJID/po4Clwxdwn2xjJPmIJ52ElwLZ
	 qsCFP/JVEyyywdLQIMRJ1kiDHFRR4Z1FIZH7yuhTcsLaAJ9ifrhZIFY//kZa3KkvC3
	 V3kbNE5rTcJSXJO6C7j0O2St4HTK3yO8BTw7y0VxhUBZZAWa1/JeIIucHE7I2GBPCv
	 Mrv3z84xyVQ+xoqhZz3aXtjUcdH3vhqE0d4LPOv1Np+QxrtnF+iR0VxTgFnzPzRTTI
	 KI0gFalur7zeN5HMsdFTCdKLkmEKImxILCKjayrX4u+cwDgMvAP/xVTOfrH5F+ovOo
	 tFd22rw25db+A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Patrick Lu <patlu@meta.com>
Subject: [PATCH 01/13] sched_ext: Don't set ddsp_dsq_id during select_cpu in bypass mode
Date: Sun,  9 Nov 2025 08:31:00 -1000
Message-ID: <20251109183112.2412147-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the default CPU selection path used during bypass mode, select_task_rq_scx()
set p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. However,
do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the global
DSQ, leaving ddsp_dsq_id dangling. This triggers WARN_ON_ONCE() in
mark_direct_dispatch() if the task later gets direct dispatched.

Don't use direct dispatch from bypass. Just return the selected CPU, which has
the effect of waking up the picked idle CPU. Later patches will implement
per-CPU bypass DSQs to resolve this issue in a more proper way.

Reported-by: Patrick Lu <patlu@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 652a364e9e4c..cf8d86a2585c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		s32 cpu;
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
-		if (cpu >= 0) {
-			refill_task_slice_dfl(sch, p);
-			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
-		} else {
+		if (cpu < 0)
 			cpu = prev_cpu;
-		}
 		p->scx.selected_cpu = cpu;
 
 		if (rq_bypass)
-- 
2.51.1

