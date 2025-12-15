Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D599317710;
	Mon, 15 Dec 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817811; cv=none; b=BWY2jRJn9L8XasD88yy6sGuWQr/Rqatjgz3DMki9tlxwbmtBzFkALc7/QjrDnNHC9cA5wVGuABNJRU8QnJ7gfJtw4P9QqwY86hrjXjj5R/EG165KLImWNb/I58dy30obJMq87lFhPQLDTxd+pucuu36DgjmTJcKBx/gmW4uYKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817811; c=relaxed/simple;
	bh=RQzDq1PMeWYLgyTxclVvU9Bcd4kSS3hJnGBt7EMS/uc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=BzhYgeK7es+h0STE6m/fBF6yG10+7YTS/ejdZklfnG6Zf3OtoeKA0aVi9IejL8YDfFe+mgSttEDpLkzXpqqF6/2FNfsORgrjrqk7N0neUX2rChThuuo3yJxpjTqph1tFKNdknHa9gCTPaEgVKHjBAxodbzZlFFvMZy2N2/MreZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twu4LwTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twu4LwTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A0C4CEF5;
	Mon, 15 Dec 2025 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765817811;
	bh=RQzDq1PMeWYLgyTxclVvU9Bcd4kSS3hJnGBt7EMS/uc=;
	h=Date:From:To:Cc:Subject:From;
	b=Twu4LwTt8GAVWf1eNJLi6QN7kvPLz+KGdq/WDfrPZRNLCJmS3gqxIkBqPXjQlIisQ
	 /0KN6z/B9GZPf7rX3FxnfK5dDu4ITTzsSJf1KfAi+TV0T7hsgQz70k124hXWarnQnD
	 JSDzv+Mo8A4vPChwq5wi+3MK+g75VYHPROI62dlpcTXHee4K26W5lTcpGVgqMwoDeB
	 IYIqs+ClhXHVq6cLTdMUCdMhq0cuZSQT2Hyw3O56UZg+CZRvplctKu8Ms8iJp8Ax/o
	 enDdlfk+GmtOFuNE6LwfBeEbbW8JDKOjQsG7c3e+4+yKTLvl1sZhJy87CpNFTK/4u+
	 7+PqAOyA/FuGA==
Date: Mon, 15 Dec 2025 06:56:50 -1000
Message-ID: <4f9a656c7143b04e974d447e1b3660cf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v6.19-rc1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi,

The following changes since commit c2f2b01b74be8b40a2173372bcd770723f87e7b2:

  Merge tag 'i3c/for-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux (2025-12-08 11:25:14 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc1-fixes

for you to fetch changes up to bb27226f0d00588ac53be8825e021ae80aa43371:

  sched_ext: Remove unused code in the do_pick_task_scx() (2025-12-15 05:53:49 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v6.19-rc1

- Fix memory leak when destroying helper kthread workers during scheduler
  disable.

- Fix bypass depth accounting on scx_enable() failure which could leave
  the system permanently in bypass mode.

- Fix missing preemption handling when moving tasks to local DSQs via
  scx_bpf_dsq_move().

- Misc fixes including NULL check for put_prev_task(), flushing stdout in
  selftests, and removing unused code.

----------------------------------------------------------------
Emil Tsalapatis (1):
      selftests/sched_ext: flush stdout before test to avoid log spam

John Stultz (1):
      sched/ext: Avoid null ptr traversal when ->put_prev_task() is called with NULL next

Tejun Heo (3):
      sched_ext: Fix bypass depth leak on scx_enable() failure
      sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
      sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()

Zqiang (2):
      sched_ext: Fix the memleak for sch->helper objects
      sched_ext: Remove unused code in the do_pick_task_scx()

 kernel/sched/ext.c                         | 72 ++++++++++++++++++++----------
 tools/testing/selftests/sched_ext/runner.c |  8 ++++
 2 files changed, 56 insertions(+), 24 deletions(-)

Thanks.

--
tejun
