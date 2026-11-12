Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494995;
	b=i9OrCYaxxwiW+7LumHX5SI+UcjTIW4kyedGqyMKQEAdKlK9Hgnyjhq2I0ENSRzZ25ewf
	 3louArxdBd4fBvHXuODoHLiJLx1G6RPEJXilPWvdIagn7k8KDcGlWzTDWZvFuUdoM4BPC
	 Xa+kgQNH6su9AUa1A9kDPZsUGlFKhQbLPIp1DoXgsBZE8ezvd7qz29mSAilnaoNZs2D4i
	 1HhKF3Ub05gFD/QhGH4hiqqqn3ekJhavf6O7VK5PAQQqokmxqmsD+RF+c7+IF+4bjWnAF
	 L5YBIuOO7eNVIPoPe28rwqYjxWsqbogSpQG4DLhVz84I/cXeSD2edVCsJacUgCWD2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jAT9uzZN4CHxink0sOWnNuooJmxzLwbXbcUHNUyhvls=;
	b=jD44tsOH0qxD+iJ6C69n5fCOgeTwi2zl/jB3N4v6+JwTHsDA/1XoAbW9piI/fo+Hhz2p
	 8Mc+acOvsHDOaORN3fx5Qk+OI4/9W692Fz2LqxCQD4ZZemjNqIuJbm1S0OG0KJ5XOgQqa
	 D/9Y1kb6da2h8Or3Gp519eCJ6Kalqo4O1R4YnjkOEfgxT7y1sXXtOs0xdAgBCm+UEjVXV
	 5sAW//u/B+k+TI5Kn9xttQcF6RR2IXtAi7rxb1QLKj0B/JeCaxqBAgz+Jeo5SDxQ3hpic
	 cZToEHNlTafDf0PGVa7gQmrrf8k7PEtfAfIYCtKi9CO2GhpeITi3VTNcb1Nv4ncYMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="dOFZ/OV/";
	arc=none smtp.remote-ip=95.215.58.99
Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF68606A327
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 14:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF68606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dOFZ/OV/
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=QylnOTCLVuW+y4dsWIYbQEgIFWSTXK6eCnnqIoOQp5c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794494992; v=1; x=1795099792;
 b=dOFZ/OV/ttunqUnkH5nm/NDIRwl74rRY4i1fMgxhyqMAaIw50mcAG4yxE7OddMc5o7INuJKe
 RXClRuvuNoLF8EixYvlqWXu4g+SKsvHoRNY78EsbzHWiYOmqd1WNg+HXdGUm8+cy3rU251TjMM2
 IfBle4rqxhPn2DhUnXwdXS3Q=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 40af8fb229db3720;
	Thu, 12 Nov 2026 14:49:52 +0000
X-Mizu-Trace-ID: 40af8fb229db3720
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] sched_ext: Fix entry-path contract breaks in core.c
Date: Thu, 12 Nov 2026 22:49:33 +0800
Message-ID: <20261112144935.583937-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hello,

wake_up_new_task() consults select_task_rq() but activates the new task
without ENQUEUE_RQ_SELECTED, so on the fork path ops.enqueue() never
sees SCX_ENQ_CPU_SELECTED and SCX_EV_SELECT_CPU_FALLBACK never counts a
fork-path fallback; pass the flag on the initial enqueue to match the
wakeup path. rt_mutex_setprio() is the only entry path into sched_ext
that does not call sched_proxy_block_task(): an ext task PI-boosted by
an rt waiter and blocked on a second kernel mutex is routed back to ext
on deboost carrying the queued+blocked state that
scx_prepare_setscheduler() promises never happens; block a retained
donor before the deboost routes it back.

0001 passes the flag on the initial enqueue to match the wakeup path,
and 0002 blocks a retained donor before the deboost routes it back to
ext.

Verified in qemu on tj/sched_ext for-next (5b740a72b55c), same kernel
and config with and without each patch, comparing stock and patched
binaries; the touched core.c regions are byte-identical on this base,
so the runs carry over: with a probe forcing select_cpu() fallbacks,
40k forks produce 0 fallback events on the baseline kernel while the
wakeup side counts normally, and fork and wakeup paths both count 1:1
with patch 1; and a driver-model trigger hands the scheduler ~39966
queued+blocked donors across 40000 PI cycles on the baseline kernel
with 0 with patch 2, PI chain traffic unchanged.

Based on sched_ext/for-next (5b740a72b55c).

Tao Cui (2):
  sched/core: Pass ENQUEUE_RQ_SELECTED on initial enqueue
  sched_ext: Block a retained donor before PI deboost routes it back to
    sched_ext

 kernel/sched/core.c    | 17 ++++++++++++++++-
 kernel/sched/ext/ext.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.53.0
