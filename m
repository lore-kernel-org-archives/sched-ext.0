Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDB484258;
	Mon,  5 Oct 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222923; cv=none; b=LHecSXg6IAtzzjoTGxoGr+JwyDitpQXZpEH+cbE1orewiSorwjkiAWC7zBPrmuDmKbh3oaphCb3G8qk8Gg0qxOoJUcqx/8Dfd01DA2m13r9Kl9BFrNh4f9ujiDXajYcjKigojI/K43dOsJSz94YSAJ2tA00ou1CdaSPaIhheTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222923; c=relaxed/simple;
	bh=1Mx/US5FiWZuGhguldH7lQ9+gURj5PJo8st5S842C5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbwGJSSb5fty1Skj4ot7HhxTx+JjjRRp4gegZ1VF2xopbtXhlp3odycfx40ZYqOecKs826DCKyZnpQMFgSa4sHnJY0ZROSCSFsOGBs0Gv6PPqzbOLHgMdSyHYrsJWJGx6ojSGgrRTy6KIff6dAYG75GVWbvFb6ZkvEOgLcvHTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd4tNgDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd4tNgDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956891F00893;
	Mon,  5 Oct 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222921;
	bh=oBONrVi2lGXy6k4TkrDqmIWYBdVUvOTekE56T54W/0Y=;
	h=From:To:Cc:Subject:Date;
	b=Qd4tNgDC1+VT8kL7/IwddYZAuTxPDtiM1mHpyvv/9HDYhefGcDP8kBRrYYrj0UlyX
	 lf7Owb2mvF3bR2VpIM3cLui1Bfw8dTpWw72TZX1wO5+b1q6sbFHsPcIrWN9X8BAFZN
	 naxUc+1Bn7H7zik/t8htdqG9vTDnVIurWv5kPEkmAk62A0Q5mYj7w/Eg/EJKI0XaQl
	 vl1HSOMPuI0KK8FVd8QQYFd4S71PJvN5G0G2IkHWSQwhi0Sw09MH7GkwEfcIuyvdkO
	 GJr4lP1OXnbcJjojUOq+jv8ApFZvxbDj60KNKQZ7yb0HrMrU3arbLqY0TGbLVljn5V
	 NquopLCMCgdbw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Add ops.sub_cid_sched_updated()
Date: Mon,  5 Oct 2026 07:55:17 -1000
Message-ID: <20261005175520.2756986-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A parent sched that delegates cpus to sub-scheds has no way of telling how
much each delegatee is using them. A parent that sizes its delegations by
demand cannot measure it, and one that wants to hand a cid from one sub to
another cannot see which sub it would take the cid from.

Patch 1 adds ops.sub_cid_sched_updated(), invoked on a sched when what it
sees running on a cid changes: NONE when no task of its subtree runs there,
SELF for its own task, or a direct child's cgroup id. Changes inside a
child's subtree are not reported. The op costs one pointer compare per
context switch when the sched does not change and sits behind a static key
that is on only while a loaded sched implements the op.

Patch 2 sizes scx_qmap's cid range buffer for large machines and patch 3
makes it show the cid-time each participant actually used next to what the
partition allocated to it.

Based on sched_ext/for-7.4 (3521f92ddd5f).

This patchset contains the following 3 patches.

 0001 sched_ext: Add ops.sub_cid_sched_updated() to report the sched running on a cid
 0002 sched_ext: scx_qmap: Size the cid range buffer for large machines
 0003 sched_ext: scx_qmap: Show actual cid use per participant

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-cid-sched

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         |  20 ++++-
 kernel/sched/ext/internal.h    |  29 +++++++
 kernel/sched/ext/sub.c         | 166 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.h         |   6 ++
 kernel/sched/sched.h           |   2 +
 tools/sched_ext/scx_qmap.bpf.c |  87 ++++++++++++++++++++-
 tools/sched_ext/scx_qmap.c     |  42 +++++++++--
 tools/sched_ext/scx_qmap.h     |  11 +++
 8 files changed, 352 insertions(+), 11 deletions(-)

--
tejun
