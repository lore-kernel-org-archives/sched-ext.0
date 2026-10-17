Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA9375F9C;
	Sat, 17 Oct 2026 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215439; cv=none; b=UyOJg5vWAaF+/+QE9kwaQTGArrhTKoGW2E3I9CSiezFRdcmeXqQHB3A2muM2SRRap7YYpLp4BUwlDtoaNrr53NZhpNrBM4pHWU2tMhKCpMln1pw4sD/mAd0aYfG+dC/3uUoBuEET8X/7aMcQlQxHvAh/zQzfyNZpFH05QTF7OJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215439; c=relaxed/simple;
	bh=EvIU8EuXNwKOEt+5tNKCNvzueHmtt9H6cO3Bhc8VB34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5ZR+/GNEujrLcNFEtcNo66gpq1iXiM+ErJxB5zyXBuu8Dva8UGBLobGrOO3NdVYvX12jSAkdQjL8x7SRuxPxqqQiPaVrzFkkYy7A+vPk8IljrHp27QHeAytnLoWdu6e6mcDMcLUPo0Dh+NQKOh+Z6IM9sdlg/O6QUmyXfrATAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7w9P7MX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7w9P7MX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F28E1F000C4;
	Sat, 17 Oct 2026 05:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792215438;
	bh=3Sjqebret22MRPMuJf2Lbw+gl5w07tTwnx2YlqGOC1k=;
	h=From:To:Cc:Subject:Date;
	b=n7w9P7MX1654hBDw+JR+Z+qZybpV/Kqvxdgf58mSIDCMR5vT/qQtjVpZ0HKBfWpgi
	 NezYtRJW5WUh633OqGUtht78i/pfouzprMSrpMD4TWXwTUVTw5/YpUQ3nIGAz8nh/z
	 T5T9aaB9FVoQYd1xook4LPUP5zFW2hFoLKg4z+Rh1wjTECEK34zfZqz8zFQTkcgizf
	 yvIB3XZ2zPb5NWvm92e00er+qf+1aenwbTFYBmS1CDkLBuYGgJHF/xB5lrlQdoR2Op
	 OF0PRLNuP7Pc+ajlPHQoI8rkGGkllc+pMSKOzq8c6UKXMjajHegfl1eBdpcrs79/vE
	 0+lKXVvZ8oP4g==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass leaving the running task protected and bypassed tasks stranded
Date: Fri, 16 Oct 2026 19:37:15 -1000
Message-ID: <20261017053717.3162619-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

scx_bypass() handles the running task inside its walk over the runnable
list, which never contains the running task, so the protection strip at
bypass entry never runs. Separately, a bypassing sub-scheduler's tasks are
run by its nearest ancestor that isn't bypassing, but whether such a task
may stay on its cpu is still checked against the caps of its own scheduler.
A bypassed task that the bypass load balancer moved to a cpu where its
scheduler holds no caps can't stay there once its slice runs out, and the
cpu can go idle with the task queued on the ancestor's bypass DSQ.

Patch 1 handles the running task outside the walk. Patch 2 checks a bypassed
task against the caps of the scheduler running it and, in the block patch 1
adds, evicts the running task when bypass lifts if its own scheduler lacks
the caps to keep it.

Verified on bare metal by attaching and detaching a sub-scheduler repeatedly
under load. A debug knob that marks the running task protected at each
bypass entry finds every such task stripped with patch 1. Without it, they
all keep their protection and the bypass tick can't cut their slices. In a
VM, running tasks whose scheduler holds no caps on their cpu leave it within
about 50us of the bypass lift with patch 2, instead of running out their
bypass slice. The sched_ext selftests pass.

Based on sched_ext/for-7.3-fixes (43e1ef14a472).

This patchset contains the following 2 patches.

 0001 sched_ext: Fix the running task keeping its protection into bypass
 0002 sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-stall-fixes

diffstat follows. Thanks.

 kernel/sched/ext/ext.c      | 32 +++++++++++++++++++-------------
 kernel/sched/ext/internal.h | 17 +++++++++++++++++
 kernel/sched/ext/sub.c      |  7 +++++--
 kernel/sched/ext/sub.h      |  6 +++++-
 4 files changed, 46 insertions(+), 16 deletions(-)

--
tejun
