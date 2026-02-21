Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE5212F98;
	Sat, 21 Feb 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645309; cv=none; b=D+j1yB3Yj1EWITEDRCg+pDCvn5Xbu6/vUWAKJ8hJyhN3qnPvEOS90x/H3FlW/+pH64Wq++xU+1sGTjcloZtOvT85Kz1lTQkbG+GIvDDpj30xPNAgymn/ObiDB1A8cv35UdqyjdoBN4qxOTHDoi+SYW+Yh80InhPuiulPwFsgkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645309; c=relaxed/simple;
	bh=m3JnmAKqXfa0e2Bu4axFrlysGLe8GSEGDHYNvxqrdfE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=BwQzNO35z16Clo1erYJ5IFgzkxULrUAhuSO4crwdjiQTCk1GyzsiVYCGV5RHORQpKXeDprsd80gCVPVxT00RCJ3Af3z6xZw+7iwiwhSKDSfO8uuGtsZj+6BihKJ2hAZcm0sREVvMfxJ1ljcS+z+C76x6EbBK8BHnqNx/aCVPrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwFzWloq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwFzWloq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE66C4CEF7;
	Sat, 21 Feb 2026 03:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771645308;
	bh=m3JnmAKqXfa0e2Bu4axFrlysGLe8GSEGDHYNvxqrdfE=;
	h=Date:From:To:Cc:Subject:From;
	b=lwFzWloqsD3ZQgEIoZa3ulT6pREbHfNK1OPb76wRkPg9SztrowBNCk5s5ARyNvT3N
	 KmDJuo6jozvLEWk3SFpMMV2Ri3QABJIcQE8tPHXAdMq/RSTni0/B/IZXib/t0LtPk2
	 TjcnBs+7wGroz8Z/9rRefn67Q77kCdc2Pvo9ev5c3R6e9Ey3HqXpYkToBcJwoY1cB/
	 C+9Rm/SLxwYAKWzaW25Nf+SF/Du4eQh0KPbuGOiXelEDp/KjgwMLDwc/F2QOjnJT1v
	 logH5tJiCJ3hkcNNfxlHzA3I7QJ4XXTdr4xWP2yYJYImqfUibch9rX1Q74YBOFW68F
	 rmutaxpEE/AaA==
Date: Fri, 20 Feb 2026 17:41:47 -1000
Message-ID: <bac5659887fbca95e7159ffb94ec2e43@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Fixes for v7.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

The following changes since commit 37a93dd5c49b5fda807fd204edf2547c3493319c:

  Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-02-11 19:31:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-fixes

for you to fetch changes up to 640c9dc72f21f325700a4b0f839ad568ff21c697:

  tools/sched_ext: fix getopt not re-parsed on restart (2026-02-20 17:17:38 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.0

- Various bug fixes for the example schedulers and selftests.

----------------------------------------------------------------
David Carlier (9):
      tools/sched_ext: scx_flatcg: zero-initialize stats counter array
      tools/sched_ext: scx_central: fix sched_setaffinity() call with the set size
      tools/sched_ext: scx_userland: fix restart and stats thread lifecycle bugs
      tools/sched_ext: scx_flatcg: fix potential stack overflow from VLA in fcg_read_stats
      tools/sched_ext: scx_userland: fix stale data on restart
      tools/sched_ext: scx_central: fix CPU_SET and skeleton leak on early exit
      tools/sched_ext: scx_pair: fix stride == 0 crash on single-CPU systems
      tools/sched_ext: scx_userland: fix data races on shared counters
      tools/sched_ext: fix getopt not re-parsed on restart

Ihor Solodrai (1):
      selftests/sched_ext: Fix rt_stall flaky failure

 tools/sched_ext/scx_central.c                | 10 ++++--
 tools/sched_ext/scx_cpu0.c                   |  1 +
 tools/sched_ext/scx_flatcg.c                 | 13 ++++++--
 tools/sched_ext/scx_pair.c                   |  8 ++++-
 tools/sched_ext/scx_sdt.c                    |  1 +
 tools/sched_ext/scx_simple.c                 |  1 +
 tools/sched_ext/scx_userland.c               | 31 +++++++++++-------
 tools/testing/selftests/sched_ext/rt_stall.c | 49 ++++++++++++++++++++++++++++
 8 files changed, 96 insertions(+), 18 deletions(-)

Thanks.
--
tejun
