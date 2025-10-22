Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF75301489;
	Wed, 22 Oct 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166591; cv=none; b=iuSvmzK+hteBEpiH0nUtYX2Mou3uw/YjQy1l4KbItJXWxT2vRo3Wj9/hf1c6UC0J1dG1ay69t77vlwzw22qsp5Ecd71UKY5bGYe/Z78BSr3pTBQejG2t+ekjIXUPMtmZZvYHMrwVioYLDJ5NPcpSUnrHvBP2pobcplEO1f4MkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166591; c=relaxed/simple;
	bh=jb7Yzd3Lj40X7MyHDOMKC7vlfciGvtL9XYo30IpStT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iL/NIkbMDjYU8a/kHe0+ycmYkNC4i/0+bA0A6j8EQFGugfEzF06DGFVfyr4boOvwr9LCqxMLn9dYcYVvIAtnbGHWxWktQuDGdO+LJ7+8C0ZnkaNi6wEfWSLLscZM3kZXRRWJntnacEV12+F72BY+pDvtvHpX2unL7hmlUEACI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2OQ3pXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2OQ3pXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6801FC4CEE7;
	Wed, 22 Oct 2025 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166590;
	bh=jb7Yzd3Lj40X7MyHDOMKC7vlfciGvtL9XYo30IpStT0=;
	h=From:To:Cc:Subject:Date:From;
	b=M2OQ3pXJFoYoV5Q1SLe9ZwHs5MAnAqhgPCuLNPGcHOcLA5/aMrjBW6D9vL8p8/+0a
	 g3oyQURhVzv6ffitmoHahZsw3FzWq9OruQhoY8xwzBGrNf7WCcNuU8YtYd8c5GQtRo
	 Kc7GynGRVlkWlXW24ibpLRdeBCji8U9IfWpsZAxcpgqGfZ5mbUB/Sf2HFm7V0eD2jN
	 qGyvxf2em/C/Peitk7vRg3YfU76FwoWCbqsBxxQcVh7qkclbLe8K+MvqFnAaJxku6R
	 p62gFpq3/ldTGsCea1y2cyxDqUzT2PTVCZjvN2QozGU6ReH/tSIp2YGbbjxiW60ux1
	 lKkIryOmg7L1w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	peterz@infradead.org
Subject: [PATCHSET RESEND v2 sched_ext/for-6.19] sched_ext: Fix SCX_KICK_WAIT reliability
Date: Wed, 22 Oct 2025 10:56:26 -1000
Message-ID: <20251022205629.845930-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending because the original v2 posting didn't include the full recipient
list on the individual patches due to git send-email invocation error. Sorry
about the noise.

SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
a reschedule and can be used to implement operations like core scheduling.
However, recent scheduler refactorings broke its reliability. This series
fixes the issue and improves the code clarity.

v2: - In patch #2, also increment pnt_seq in pick_task_scx() to handle
      same-task re-selection (Andrea Righi).
    - In patch #2, use smp_cond_load_acquire() for the busy-wait loop for
      better architecture optimization (Peter Zijlstra).
    - Added patch #3 to rename pnt_seq to kick_sync for clarity.

v1: http://lkml.kernel.org/r/20251021210354.89570-1-tj@kernel.org

Based on sched_ext/for-6.19 (2dbbdeda77a6).

 1 sched_ext: Don't kick CPUs running higher classes
 2 sched_ext: Fix SCX_KICK_WAIT to work reliably
 3 sched_ext: Rename pnt_seq to kick_sync

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-fix-kick_wait

 kernel/sched/ext.c          | 129 ++++++++++++++++++++++++--------------------
 kernel/sched/ext_internal.h |   6 ++-
 kernel/sched/sched.h        |   2 +-
 3 files changed, 75 insertions(+), 62 deletions(-)

--
tejun
