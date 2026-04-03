Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF98282F0E;
	Fri,  3 Apr 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239265; cv=none; b=GB88uG4TyJE22SmcPWk5C2gvQsZsm8w0d3d0nhZ6c1sGfsemnA6GuI+pLpgtFlUL8Vtd17p/pVyr5c/RcAhaI/XYpUcWTKQqBcfiQn83WvOYfK4zHFcNne3rdpjwbX9vKvBFGqWAD88aNG0K/t0wCy9gI25I1ogyKNHXD2Uzwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239265; c=relaxed/simple;
	bh=MTRbNgjS5nUE+1XNu0PiCCcDA0BUIbboDTzNL5TrdBI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=WfEjm07iRHDlvXY7QSIYNX/v2o2FYPh9CEsDAHpU3P8vqqKcsZV1IM+zdLvVuEDmXYoH6oSwv/G/PTPLtyIdHsz7ttHn/wVtBnUvozPCOCaB4ZSFEUrteudInDVj2q7Vr4yjqSULfOtLKz8bzn4cdRwtVq5OfT6LwRcEcb9HYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqK45V0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqK45V0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9C1C4CEF7;
	Fri,  3 Apr 2026 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775239265;
	bh=MTRbNgjS5nUE+1XNu0PiCCcDA0BUIbboDTzNL5TrdBI=;
	h=Date:From:To:Cc:Subject:From;
	b=DqK45V0u2NGsSrbDR18LMqrpLFZBpQtn8u1rn9yfGxbSRRoYIVv1wHx1OdnzEn0L4
	 NwUnFtfVvHVfIUoZNKZxKoIu+ntkVoh129Z2tpGLK6R5P4SM8Dud/K1V7jbpBlYnLs
	 wS15Oz3EXspU53LbuhQQ0yutAbj3OmqGLKHQwI64nw3+bbrx+m6KwE8UPA21wGAykb
	 W/aRPecV3e7jZAzyEwKmFHSNjRTxvmJBO7WkpXvJ56VGuoig8XzrOGwI6ST0y6dGtn
	 S5ZnNtUIeg6087Iav59nPWjcGX/L+3vEWyqA/OY+EFtd5Qu7WnnMCHgbTw3VPUvXNu
	 eTI26Tn4QKDgg==
Date: Fri, 03 Apr 2026 08:01:03 -1000
Message-ID: <185f1512633cf18018c9c93e891d7c67@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Another fix for v7.0-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

These are late but both fix subtle yet critical problems and the blast
radius is limited strictly to sched_ext.

The following changes since commit 090d34f0f0285124452373225bcc520a31e305e4:

  selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test (2026-03-30 08:37:55 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes-2

for you to fetch changes up to 7e0ffb72de8aa3b25989c2d980e81b829c577010:

  sched_ext: Fix stale direct dispatch state in ddsp_dsq_id (2026-04-03 07:14:49 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.0-rc6

- Fix stale direct dispatch state in ddsp_dsq_id which can cause
  spurious warnings in mark_direct_dispatch() on task wakeup.

- Fix is_bpf_migration_disabled() false negative on non-PREEMPT_RCU
  configs which can lead to incorrectly dispatching migration-disabled
  tasks to remote CPUs.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Fix stale direct dispatch state in ddsp_dsq_id

Changwoo Min (1):
      sched_ext: Fix is_bpf_migration_disabled() false negative on non-PREEMPT_RCU

 kernel/sched/ext.c      | 49 +++++++++++++++++++++++++++++++++++--------------
 kernel/sched/ext_idle.c | 31 +++++++++++++++++++------------
 2 files changed, 54 insertions(+), 26 deletions(-)

--
tejun
