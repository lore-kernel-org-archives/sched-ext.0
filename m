Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4B2DB7AA;
	Tue, 10 Mar 2026 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105419; cv=none; b=iWIXPj0cv0pII/MnAxHQpZ8gNwT0RzGyOAdaIckhHay8ZTHGxhzUJVOzbFoJUO+k84F87AtqS+bwiFhVjFHotNaQvgV10SkSy3Ei9+cCDgbEV2x+aw751wC88tIWUj8uM66wt+L2F4Bmv/bMI6yJL4q6Uh9FjZucLD/HHJWGCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105419; c=relaxed/simple;
	bh=bSbp8aP+imDpUMaChzYLU6vv77SKS/VSh41wcxu3H7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0SgBh/AUdx0Np4j4fuVGuQf+fgniEDmde9ioUbmtL0l1tOF8dCUKRoU7Y85qMoAFtnq6lAEwveoWkfXBApUBHOMMbQHHvY+6GUWzb23vkNBxGc/RVThtZVb5OUyW2r/Fcf74B2Gr+4q2WGnXz0XYkSkh9VUaONK6wC/aAFw4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgvwS1EI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgvwS1EI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB73C4CEF7;
	Tue, 10 Mar 2026 01:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105419;
	bh=bSbp8aP+imDpUMaChzYLU6vv77SKS/VSh41wcxu3H7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgvwS1EIr6T9m+Qqi7QmQKd4LxHjlyM2Zd6eLuM4J5sZASO/3I/xCpGXa6P1NXGw3
	 +w8PVGa5Bw14qQi+lKpJMAyXdRlVIOAdj3pqwvCf1ZSzpszycaAY4jBtF62e/677S3
	 2l/57xbfUoC7DmYQwWwj0u4/YJZbzEgV8jJLWogey6EjEnKfHs1+Y/KRPUR693KBL/
	 rNTCFn38eWAgYsdX9Ku+StLcGCYLOAOn4/D/ik9zrDbb1Rvr1HLD3hv2WnlLSn8XUz
	 +BiVEM8F4py/h6qpMG1CfOlDPdBkPkRBYtwv93Wuj/1d1t4OqTBXFUTQOxdgOERgdZ
	 4z60pHOOGa3cw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] sched_ext: Fix scx_sched_lock / rq lock ordering
Date: Mon,  9 Mar 2026 15:16:52 -1000
Message-ID: <20260310011653.2993712-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
References: <20260310011653.2993712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two sites that nest rq lock inside scx_sched_lock:

- scx_bypass() takes scx_sched_lock then rq lock per CPU to propagate
  per-cpu bypass flags and re-enqueue tasks.

- sysrq_handle_sched_ext_dump() takes scx_sched_lock to iterate all
  scheds, scx_dump_state() then takes rq lock per CPU for dump.

And scx_claim_exit() takes scx_sched_lock to propagate exits to
descendants. It can be reached from scx_tick(), BPF kfuncs, and many
other paths with rq lock already held, creating the reverse ordering:

  rq lock -> scx_sched_lock vs. scx_sched_lock -> rq lock

Fix by flipping scx_bypass() to take rq lock first, and dropping
scx_sched_lock from sysrq_handle_sched_ext_dump() as scx_sched_all is
already RCU-traversable and scx_dump_lock now prevents dumping a dead
sched. This makes the consistent ordering rq lock -> scx_sched_lock.

Reported-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Link: http://lkml.kernel.org/r/20260309163025.2240221-1-yphbchou0911@gmail.com
Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf28a8f62ad0..677c1c6c64bf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5097,8 +5097,8 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		struct rq *rq = cpu_rq(cpu);
 		struct task_struct *p, *n;
 
-		raw_spin_lock(&scx_sched_lock);
 		raw_spin_rq_lock(rq);
+		raw_spin_lock(&scx_sched_lock);
 
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
@@ -7240,8 +7240,6 @@ static void sysrq_handle_sched_ext_dump(u8 key)
 	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
 	struct scx_sched *sch;
 
-	guard(raw_spinlock_irqsave)(&scx_sched_lock);
-
 	list_for_each_entry_rcu(sch, &scx_sched_all, all)
 		scx_dump_state(sch, &ei, 0, false);
 }
-- 
2.53.0

