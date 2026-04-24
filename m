Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547ED30B53C;
	Fri, 24 Apr 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063460; cv=none; b=nnecT1pEeu3yOYvYKTaFv8U2Nb40tBhmt7eSK+At0MO8PHcqLDjnMF/Lac/7Xy35+x/VEwvTJfYSufqojviTq5w5Mi1/xQMdlN9dJ65/Ht2z6yTVZgA67jrhap+X/MCHk+SbEJ6PWf6Oa7P5QseWO0S7T5OSLvj1kgN4K7/rk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063460; c=relaxed/simple;
	bh=aZIKvsuRPQmGIMJ3egP7+5rq2nJvA1CiL1WxzxfW2AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8lLNLUF4xu6AIE7Q6bEK1uszD0gqF6MasfZxCXSfNMBu+43kC6JUt5iYxnzhivLq7d9TJeGKiZa73iY5EnG/6+FwuotVZCl6gzjF4thkNrx8Skkl+LbtZKu76O4NvDzSuKnBgUGX5GIB9SATZibzCiaN3L1UNNo+X5tA+jECyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4CexKW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4CexKW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E344FC19425;
	Fri, 24 Apr 2026 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063460;
	bh=aZIKvsuRPQmGIMJ3egP7+5rq2nJvA1CiL1WxzxfW2AU=;
	h=From:To:Cc:Subject:Date:From;
	b=g4CexKW7X4pDXy1n3f2lR7KOa/i734igEKYhYbwLJ1GkSJovteAFLuKYo+yunXkEC
	 qSIjScCAcU1+Jt386jZ7QCQLQk57tWVLsvGGiIrYLfMLlTvQa+KN0iLaK1s1lAnbmI
	 +XqL36wJ7uY0D3xnAvjyTx+/+BoX7A/pTw72bBwOnXpAqqP0Q5seKkXLrjqWmiSCg7
	 t5GIpzoJ+oLFQPYu8MNMEyY1PeBfxJrikhWrQgtBN25R888y/cj9GBF6IBDKxSFruJ
	 I9BtNCT32bwVd7Ps/hMjIVLdmmJUbyATM/Zbt3rmei7PytZQ5Ha77Fb3C7bARLnmZD
	 PmUHsNIS54Gig==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Assorted fixes
Date: Fri, 24 Apr 2026 10:44:05 -1000
Message-ID: <20260424204418.3809733-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset collects fixes for issues surfaced by Chris Mason's
AI-assisted review of sched_ext. The bugs span use-after-free, leak,
lock/state inconsistency, rq-lock AA deadlock, and cross-task kfunc
misuse paths. Each patch stands on its own.

Based on sched_ext/for-7.1-fixes (510a27055446).

 1: sched_ext: Unregister sub_kset on scheduler disable
 2: sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new
 3: sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
 4: sched_ext: Don't disable tasks in scx_sub_enable_workfn() abort path
 5: sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
 6: sched_ext: Resolve caller's scheduler in scx_bpf_destroy_dsq() / scx_bpf_dsq_nr_queued()
 7: sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail
 8: sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP
 9: sched_ext: Pass held rq to SCX_CALL_OP() for dump_cpu/dump_task
10: sched_ext: Pass held rq to SCX_CALL_OP() for core_sched_before
11: sched_ext: Make bypass LB cpumasks per-scheduler
12: sched_ext: Align cgroup #ifdef guards with SUB_SCHED vs GROUP_SCHED
13: sched_ext: Refuse cross-task select_cpu_from_kfunc calls

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git fix-slop-review

 kernel/sched/ext.c          | 238 +++++++++++++++++++++++++++++---------------
 kernel/sched/ext_idle.c     |  19 +++-
 kernel/sched/ext_internal.h |   2 +
 3 files changed, 174 insertions(+), 85 deletions(-)

Thanks.

--
tejun
