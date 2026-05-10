Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AE365A02;
	Sun, 10 May 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398875; cv=none; b=OyiX//qFmGqEkvch5HKp0H4FL2PAk7VbOjcs42z1Pge9Ft5xyZC8OSPFz5c8S5pzu/flpw76LaHmai3L+GYrmsswukrJs3dWodD9T1P1xGB6MFr5m3xGloZM097WNOwk0YZJKhIUrOExxgRlmqT+XYoe7GXn7yx6FkP0EYccNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398875; c=relaxed/simple;
	bh=K00/YCvdLdV1Zu0dxfP4tGTY5a895KvmzQKtTYjix+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgmcNBwPCzrR0QqhVSVqTGm4s37Wra1ZP7ynSCl4vURLPsVGeUmBfuRUQojOK4w9nty2uKkwX/IIGZfIPMFNBv9VaLgpiwgf4Wl8jvuceRHupz6ydLhgXCHTxpbcTGpqZ7DFTTV5+Gs2UaJyynWVu/loYc7YyyVAAI5iDgN1jXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQBZrvtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQBZrvtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF663C2BCB8;
	Sun, 10 May 2026 07:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398875;
	bh=K00/YCvdLdV1Zu0dxfP4tGTY5a895KvmzQKtTYjix+w=;
	h=From:To:Cc:Subject:Date:From;
	b=FQBZrvtX5HsNEq0wx2WuqX6BP8k72cNhbUPp5IrSbaLgOQxkbqc0mt/qI5BpTJFnz
	 xWzT7VMujhnam67TwgV6POIgxFlKJpQ49Gn7lNZoNPUGyo87K0aYdK6Le8uts7lLGu
	 WfN+J9UpxX1l/2R9eiTASTQ2fN5FUaPRQxDZtPAUAsJsy68hB0v7R2DxPJ62v++Q7D
	 Sv0uf9Qpgn6qwBL5H1x0KmYis55DNETcOEDNs7gwUQ3prV2xuEOH+oaW73unGvObfC
	 kGfqlzY/wQd5FeCeXVFhbgXv/mIs2K/5WbESiGFJt+7Duqd4wFMyRwKVjT9hXHyRWI
	 8Qs0Kt492dTYw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Fix sched_ext_dead() races with task initialization
Date: Sat,  9 May 2026 21:41:07 -1000
Message-ID: <20260510074113.2049514-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

zhidao su reported a NULL deref and an ops.init_task() leak when
sched_ext_dead() races scx_root_enable_workfn() in CONFIG_EXT_SUB_SCHED
kernels [1]. The same race window also affects the analogous sub-sched paths
(scx_sub_enable_workfn()'s per-task init pass and scx_sub_disable()'s
migration loop), and the wrapper-disable paths trip on the NONE state that
scx_fail_parent() leaves behind. Closing all of these calls for a
state-machine extension rather than a localized fix.

The series introduces SCX_TASK_INIT_BEGIN as an explicit intermediate state
between NONE and INIT, and replaces the SCX_TASK_OFF_TASKS marker flag with
a real SCX_TASK_DEAD terminal state. With the state machine in place, every
init path uses the same handshake: write INIT_BEGIN under rq lock, init
outside the lock, recheck DEAD under rq lock, unwind via
scx_sub_init_cancel_task() on hit. The wrapper-disable and
switched_from_scx() paths get NONE early-returns to handle the
scx_fail_parent() residue.

It is more invasive than zhidao's patches but covers the related races
uniformly and avoids the implicit list_empty() check his approach relies
on. Credit to him for finding and reporting the bug.

 0001 sched_ext: Cleanups in preparation for the SCX_TASK_INIT_BEGIN/DEAD work
 0002 sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_task_state()
 0003 sched_ext: Replace SCX_TASK_OFF_TASKS flag with SCX_TASK_DEAD state
 0004 sched_ext: Close root-enable vs sched_ext_dead() race with SCX_TASK_INIT_BEGIN
 0005 sched_ext: Close sub-sched init race with post-init DEAD recheck
 0006 sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths

Based on sched_ext/for-7.1-fixes (ab28a0673daa).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.1-fixes-dead-race

Verified with a debug patch that widens the unlocked init windows on the
root and sub-sched paths and counts post-init DEAD-recheck hits.
Reproducers exercise each of the original races plus the scx_fail_parent
NONE-state regression, followed by a multi-iteration stress under fork
churn. Counters show the windows are hit and no
BUG/WARNING/Oops/Invalid-task-state appears.

[1] https://lore.kernel.org/all/20260429133155.3825247-1-suzhidao@xiaomi.com/

 include/linux/sched/ext.h |  17 ++--
 kernel/sched/ext.c        | 221 +++++++++++++++++++++++++++++++---------------
 2 files changed, 162 insertions(+), 76 deletions(-)

Thanks.

--
tejun
