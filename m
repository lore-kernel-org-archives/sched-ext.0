Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695CF23D2B1;
	Tue, 10 Mar 2026 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105415; cv=none; b=a4JcOgpyDY4hQPYlFQLTstUvR95shBoUToEXh2MNDlOBEjM32p7jfAR2JS0n1vTUHGfSyCq3WUfizUZsyg6iIRqvMkYRrIfa2lqQV41mUHbu1gkEAOEiqmkDQsXYLjjHHKRw6fOfQfx7+U15HvU810UdK3JctxFEpRJHHSlAhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105415; c=relaxed/simple;
	bh=RrIN4OOP1EpX+CE9HbVjZtGpq4LXImyb+61qVC0kS6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzTsYbOQn5BxQa9VB7M3Z3wfSVY01aODv1rsvjqz520USEdIJrk2NLAxFmVTVrOU4vMWPxjUCX7JFJ7tfus237x9q4YL1x2HLFzfWD8SMgILdnmU9XS3NEwyyS4LlL+mmdkmlRaBmqDUf1ifOQl+oI3/HfbKxayrcEVbTqUhZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNRYKKUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNRYKKUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D4C4CEF7;
	Tue, 10 Mar 2026 01:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105415;
	bh=RrIN4OOP1EpX+CE9HbVjZtGpq4LXImyb+61qVC0kS6s=;
	h=From:To:Cc:Subject:Date:From;
	b=mNRYKKUiQSQfjG/bo/TgkIcWIC6kjZnGpq6lpkTyrTMBQc2GMZTS2gRRH8JfATzvO
	 VbWeKxg5TbT0uNblkM7/pUpvLEyzQMIrqnUET8vNq9Wki0YvNVzaIlm0hIe0pu1aOL
	 f0zTbx5QOxUYxod4FAhYfV6YIOFsLz+P9NI/tvvMo2ahS8ZprOJEUxVZKvo4PgvQEl
	 pMED0KvfCqBy1TiJOqc4QFuL0ptzDRXSA4mETHcL2b1GnoEGjfo0BODREzDF78b4iZ
	 23g9c5vR6WiTndMj5zasBqmm+k1rv9ruHT3SKo501UgCojZ2F5dGtO6YCALN9WO8e7
	 kluxUQlOMDKqA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1] Fix sub-sched locking issues
Date: Mon,  9 Mar 2026 15:16:48 -1000
Message-ID: <20260310011653.2993712-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Cheng-Yang reported a lockdep circular dependency between scx_sched_lock and
rq->__lock. scx_bypass() and sysrq_handle_sched_ext_dump() take
scx_sched_lock -> rq lock, while scx_claim_exit() (reachable from many paths
with rq lock held) takes rq -> scx_sched_lock. In addition, scx_disable()
directly calling kthread_queue_work() under scx_sched_lock creates another
chain through worker->lock -> pi_lock -> rq->__lock.

This patchset fixes these issues:

1. Fix wrong sub_detach op check.
2. Add scx_dump_lock and dump_disabled to decouple dump from scx_sched_lock.
3. Always bounce scx_disable() through irq_work to avoid lock nesting.
4. Flip scx_bypass() lock order and drop scx_sched_lock from sysrq dump.
5. Reject sub-sched attachment to a disabled parent.

Tested on three machines (16-CPU QEMU, 192-CPU dual-socket EPYC, AMD Ryzen)
with lockdep trigger tests and an 11-test stress suite covering
attach/detach, nesting, reverse teardown, rapid cycling, error injection,
SysRq-D/S dump/exit, and combined stress. Lockdep triggered on baseline,
clean after patches.

Based on sched_ext/for-7.1 (b8840942644c).

 1. sched_ext: Fix sub_detach op check to test the parent's ops
 2. sched_ext: Add scx_dump_lock and dump_disabled
 3. sched_ext: Always bounce scx_disable() through irq_work
 4. sched_ext: Fix scx_sched_lock / rq lock ordering
 5. sched_ext: Reject sub-sched attachment to a disabled parent

 kernel/sched/ext.c          | 59 +++++++++++++++++++++++++++++++++++----------
 kernel/sched/ext_internal.h |  3 ++-
 2 files changed, 48 insertions(+), 14 deletions(-)

--
tejun
