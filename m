Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F93CE0A2
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260634; cv=none; b=BW+6x4PhDecuV4aAwT3aG5qRi8x0ywEuRRJPc4sVP+DE8x4NY4nnsKldN+Kt9+MS+6QL4lgrNOsPRZOQFNtWJnVgXXwY+bUnlJNEzDEm3tpKg/RDu8iW7zxxjFqFppUcxxPYzjF0xSfmlCGL659RJXG8pqnFZPKJyZT4WNY826o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260634; c=relaxed/simple;
	bh=ou0O4CuNX5ILgN31NAiaI6c7dWhPnAdBnqJ3tLGKyPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0DBUcwUaOY4BbUZ7aoRdCrBph+BjDlTwVrzx+JxDOyG4shoSQCPbfZvEJxZ8MihEDT57slvuuhHpJQjUS4UEdqVu7k84Qo21D/ugo4WZKX5jNbW5cvf9f9ZBqW8GV/G47k4x5pk3NCkVm0vcNuHOdE3//4tn/QvzCHzADTtpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 682cd574b82511f19a56ed5b684f684d-20260924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0e115794-e25a-4d1b-bb3b-98435fd13a3e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d00b7c7931d244afe033524368d1898f,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50|99,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 682cd574b82511f19a56ed5b684f684d-20260924
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 452790152; Thu, 24 Sep 2026 22:37:02 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH 0/3] tools/sched_ext: Fix three example scheduler bugs
Date: Thu, 24 Sep 2026 22:36:56 +0800
Message-Id: <20260924143659.268595-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes scx_userland, where the BPF component never increments
nr_queued although both its declaration comment and the NOTE in
userland_update_idle() say it does.  As a result the "wake the
user-space scheduler when a CPU goes idle" decision silently degrades
to nr_scheduled alone and tasks sitting in the enqueued map are
invisible to it.

Patches 2 and 3 fix two related queue-lifetime bugs in scx_pair, which
has no .dequeue and no .cgroup_move callback and therefore leaves stale
pids in the per-cgroup FIFOs:

 - pair_cgroup_exit() releases a queue slot without draining it.  The
   next cgroup inheriting the slot starts with a stale non-zero
   cgrp_q_len, so its first enqueue never sees the 0 -> 1 transition
   and its cgid is never queued on top_q: the cgroup starves for the
   lifetime of the scheduler.

 - try_dispatch() trusts a pid popped from a cgroup's FIFO.  If the
   task migrated to another cgroup between enqueue and dispatch, it is
   dispatched under the old cgroup's context, violating the core
   "paired CPUs only run tasks from the same cgroup" invariant.

Wanwu Li (3):
  tools/sched_ext: Increment nr_queued when a task is queued to user
    space
  tools/sched_ext: scx_pair: Drain task queue on cgroup exit
  tools/sched_ext: scx_pair: Verify task cgroup before dispatch

 tools/sched_ext/scx_pair.bpf.c     | 47 ++++++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_userland.bpf.c |  1 +
 2 files changed, 48 insertions(+)

-- 
2.25.1
