Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA740DFA2;
	Sun, 29 Mar 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774743537; cv=none; b=t8RjsSIAAe3ys/1PUNmXUcU/2pBhUdxrfPyo6U6t4QR9tP4DP6EFyZbUbzVKyyj1kkQi6TiEqM+Cr0FFj7LKBgFqSwnBhvDqZloZssyOua7flLcQSxEJNQclczPtufeSBZTWFyVZ5hu4+fhpEaTDY4FVloRYha8Z+KpfZj/HkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774743537; c=relaxed/simple;
	bh=rp9/JUAaIvp5v252b6Sodgub/b7yW2eOXJutCOZAdPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOfRPh3zyLHbTC9Xxo3Jp+xztWYZKlbX5DGrUBQWHUM3L4BFmMor0l8tkZ6NxwvboiKsc1GL/PUngnA+f6tZbLpIizYHFMdvpTilxMJFuWgUoCa5k/4rSDMOS6k2247knuQd7WyxWLZ+hCMTn3RpsQ5BKlRnT4VLOaX1oLXLsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVwI8RIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVwI8RIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574C0C4CEF7;
	Sun, 29 Mar 2026 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774743537;
	bh=rp9/JUAaIvp5v252b6Sodgub/b7yW2eOXJutCOZAdPY=;
	h=From:To:Cc:Subject:Date:From;
	b=WVwI8RIXJGaf1IcIIiCercHXckkf7SUrShY5qKuzEujuPxZ87zv8dFHVrkoLXByjq
	 jkOG3mew44l98//A4eLlniJ42NrmrYvUP2qkHED5BB8zsfFbpGhsPTUh1Wrw6ZT2UV
	 XZI0WRTLhRjU/5Y+vJpk7KuD0Ee0bIMGy0XkWKyY0LhC5cLLEmqzlWODFnoykgbrwK
	 BzslQPgaEj9Kq06NX8I8tR8r0FWJljseAZ+mDbcb0MGtGN6BB2MAkSRJXdtUDbzzyl
	 lPZOv0JGix6S0X1VNtmcGJ/g5P9NrY5PsMpxe6yM5wIHOFNEk6ZXJM1+bYiD5zFbAq
	 aUSPlZaGraDxg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.0-fixes] sched_ext: Fix SCX_KICK_WAIT deadlock
Date: Sat, 28 Mar 2026 14:18:54 -1000
Message-ID: <20260329001856.835643-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

SCX_KICK_WAIT busy-waits in kick_cpus_irq_workfn() until the target CPU
reschedules. Because the irq_work runs in hardirq context, the waiting
CPU's kick_sync never advances, and if multiple CPUs form a wait cycle, all
deadlock. This was reported by Christian while testing on arm64.

0001 fixes the deadlock by deferring the wait to a balance callback which
drops the rq lock and enables IRQs, allowing IPIs to be processed and
kick_sync to keep advancing during the wait.

0002 adds a selftest that creates a 3-CPU kick_wait cycle to reproduce the
issue.

Based on sched_ext/for-7.0-fixes (db08b1940f4b).

 0001-sched_ext-Fix-SCX_KICK_WAIT-deadlock-by-deferring-wa.patch
 0002-selftests-sched_ext-Add-cyclic-SCX_KICK_WAIT-stress-.patch

 kernel/sched/ext.c                                 |  95 +++++++---
 kernel/sched/sched.h                               |   3 +
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../selftests/sched_ext/cyclic_kick_wait.bpf.c     |  68 ++++++++
 .../testing/selftests/sched_ext/cyclic_kick_wait.c | 194 +++++++++++++++++++++
 5 files changed, 336 insertions(+), 25 deletions(-)

--
tejun
