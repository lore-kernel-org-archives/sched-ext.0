Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611A1A8F84;
	Mon, 29 Dec 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766969475; cv=none; b=jREks0Zpy52nNKk1TJ/qREBsnkzLZdQd/XKRe1qMecLcvGs6IwNIinvEx5/aWA4VXIO98HI6/yyWsPpxBUa2LbeqQALl3ERaLRw3lWgcsXbcLei4TQ2jEcVivMe7bb4m62Oak2I3lQYLr/LTtryMwF2+oc2JuhbsuZ02uYn3sdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766969475; c=relaxed/simple;
	bh=3aGKb2t4bqry3ubWVkbMe5Cpg7Z7feNWMZdLqQfCKyI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ITSG7Hrx3//idFWwJvR6XOsacpLLHgisgHQq+b1aFJofwanRdvnLGNZY9TZSkoAqaalLcmNnl4NHnBsfV121Ku7rgbrbnMr+ZK7RY00VAEeJUYqiLT80EFA1HYiPNwgNpf/XBh9AXCbspo8otOUJHXWdAqZ22ZJhNtYu+jjQgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVf3WK5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVf3WK5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ECAC4CEFB;
	Mon, 29 Dec 2025 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766969473;
	bh=3aGKb2t4bqry3ubWVkbMe5Cpg7Z7feNWMZdLqQfCKyI=;
	h=Date:From:To:Cc:Subject:From;
	b=mVf3WK5zANkRvBL2P13xSpfI0NyKP79DN3OHDdss6O7vjoFthwcmPZV5lNCJfS+0n
	 Czj9zvz3zU/x1x2bjH1insyqqNy6/LeclG+jKWj0/qwShtQsYhwMIlc/IxnmtW1Yam
	 wD9oeogtN141sS59Yo9DMFYpXkHEVXaK0vdqMzbQvxKupEKKQN/SP3MO4f9+/bd0fI
	 Xki6i6+Hn/1FKTct1d97M3Ltih1HkxzjzU/AJTOE0QABHPzsKf+dxkon+a9KtSSKnI
	 NhgrcPC5BdbeBWPr5AJxR2UPlv9HhYFSJK0OWjWxl3AAGo0qHlsT1VEB+rjlC/f91Y
	 xJY1swx0EAecA==
Date: Sun, 28 Dec 2025 14:51:12 -1000
Message-ID: <311f420a9bebc537ef84f66b0de04129@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v6.19-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

Miscellaneous sched_ext fixes.

Thanks.

The following changes since commit bb27226f0d00588ac53be8825e021ae80aa43371:

  sched_ext: Remove unused code in the do_pick_task_scx() (2025-12-15 05:53:49 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc3-fixes

for you to fetch changes up to c9894e6f0160414b57e895332c580cf5c8da6780:

  tools/sched_ext: update scx_show_state.py for scx_aborting change (2025-12-28 06:11:26 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.19-rc3

- Fix uninitialized @ret on alloc_percpu() failure leading to ERR_PTR(0).

- Fix PREEMPT_RT warning when bypass load balancer sends IPI to offline
  CPU by using resched_cpu() instead of resched_curr().

- Fix comment referring to renamed function.

- Update scx_show_state.py for scx_root and scx_aborting changes.

----------------------------------------------------------------
Kohei Enju (2):
      tools/sched_ext: fix scx_show_state.py for scx_root change
      tools/sched_ext: update scx_show_state.py for scx_aborting change

Liang Jie (1):
      sched_ext: fix uninitialized ret on alloc_percpu() failure

Zqiang (2):
      sched_ext: Fix some comments in ext.c
      sched_ext: Use the resched_cpu() to replace resched_curr() in the bypass_lb_node()

 kernel/sched/ext.c                | 23 ++++++++++-------------
 tools/sched_ext/scx_show_state.py | 10 ++++++----
 2 files changed, 16 insertions(+), 17 deletions(-)

--
tejun
