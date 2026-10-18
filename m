Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216A331EB3;
	Sun, 18 Oct 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288794; cv=none; b=arhhOXCbbw9Km1zoAwjyV9AsUXM06bnrG63wb7hBVfStgqw3qFZMMQV2eFEB5BbcCgpgRQCuA8zyf3A1WuPnpao9Ogpoh/J+uK7ZEW/tegclID9TxnnsO3P29Wd2HRzCyP0hmXo1b7CqlP2JEffvdmPj9COCOpnFLhEQDKFJzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288794; c=relaxed/simple;
	bh=8dLOFiA4fzpj8NCDNmK7jyvEfF539jlGvoyLwU+eQ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwuA1P0eRrm66NnY2dO9A0DYniSAhxZ9hvu8hblSCt0N+n9dwu1Ve38x96SqkKnGzjsOM0bGTtd8MmDzyeZiqvedeS58dajgAnzq1LPleIPIisamigM9faC/XcnwKMpjWbrqHja+V9wWzLm9hEUJ+y42upj05XZbI8HSQVtRT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVa7bC6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVa7bC6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339201F000C4;
	Sun, 18 Oct 2026 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288793;
	bh=ZVnHd/z4A0/hNmWxtZfdVw8ktzyrwK44lQJwznTmkqM=;
	h=From:To:Cc:Subject:Date;
	b=hVa7bC6Z0vVrMF44rdWtm0od+Ofz1iTEJ/1UkWeFucGQOwRWQdNKCbXPhkjef4okC
	 5mnpe3YM3LsRJEdfZUYDqwk38skBo0aKYgjEvp5haAgvdKKZGb9JjlVrnKQb1TNNmw
	 19mu3v69DH6FPPqyZ6NMY2UeSEaOTc7cdPBePk3AX166ucFKq7IJFx/ne+Rt3up6No
	 On9zeqoc0vTz0UUUE+CmgU4K/mLHyiSkih5TcKLICMi+KQwfURDqQja4J6vI/Dib0p
	 N60/7aM3iq6zHHOLi+Te2pBWOVQc64xKt0SJKF3egkWwnNKNRdeDOGINKBihyaPAUC
	 gJt4v/HyNR8Dw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.4] sched_ext: Report a sub-scheduler's ecaps on attach, detach and cpu hotplug
Date: Sat, 17 Oct 2026 15:59:46 -1000
Message-ID: <20261018015952.1499528-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3 (resched from irq work):
- Reschedule the cpu for its queued ecaps syncs from hard irq work on that
  cpu instead of a kick. dispatch_one() processes the syncs only at its
  start, and a kick that lands while the pick has the rq lock dropped is
  cleared with the pick (#3, #5, sashiko).
- Fix the SCX_RQ_ONLINE comments (#4) and why no report mark is pending at a
  suspend down (#6), and update comments and descriptions.

v2 (detach and cpu hotplug):
- Report the caps on detach as well as attach, and deliver regardless of
  bypass, which drops the replay at unbypass (#3).
- Drop the sync_pcpu_ecaps() factoring. Add the cid_pshard() factoring and
  free a sub-scheduler a grace period after discarding its syncs (#1, #2).
- Deliver only while the root has the cpu online, report the loss when a
  cpu goes offline, and leave suspend and hibernation out (#4-#6).

v2: https://lore.kernel.org/r/20261017164556.4136807-1-tj@kernel.org
v1: https://lore.kernel.org/r/20261009094356.2852794-1-tj@kernel.org

A sub-scheduler learns which cids it holds through ops.sub_ecaps_updated(),
but the grants its parent makes when it attaches are reported only after its
enable bypass is lifted, which is also when its tasks are handed to it. So
it gets its first ops.enqueue() calls before it has been notified of a
single cid and has to hold the tasks somewhere until the grants arrive.

The losses aren't reported either. The caps go away on detach and when a cpu
goes offline without a delivery to the sub-scheduler or its parent. The
reseed of a cpu coming back can also run their ops before the root's
ops.cpu_online().

With this patchset, a sub-scheduler's ecaps change only with the deliveries
that report them. The attach-time caps are reported before bypass lifts, the
loss on detach before any task goes back to the parent, and a cpu's loss and
regain around the root's ops.cpu_offline() and ops.cpu_online(). Suspend
and hibernation are left out: a cpu they take down keeps the caps last
delivered, and the resume reports only the net change.

Verified with sub-schedulers attaching and detaching with tasks queued and
caps granted and revoked, through cpu hotplug with the races widened by
debug patches and grants flooding a cpu as it goes down, on PREEMPT_RT as
well, and across suspend. The protocol between the reports, the per-cpu
syncs, cpu hotplug, suspend and the free path was model checked with TLC
for small cpu counts.

Based on sched_ext/for-7.4 (9c0af54cb49c).

This patchset contains the following 6 patches.

 0001 sched_ext: Factor out cid_pshard()
 0002 sched_ext: Free a sub-scheduler a grace period after discarding its ecaps syncs
 0003 sched_ext: Report a sub-scheduler's ecaps on attach and detach
 0004 sched_ext: Deliver ecaps only while the root has the cpu online
 0005 sched_ext: Report the ecaps loss when a cpu goes offline
 0006 sched_ext: Leave suspend and hibernation out of the ecaps reports

The patches are organized as follows:

- 0001-0002 are prep. 0002 stops the free path from relying on a bypassing
  sched's syncs calling no op.

- 0003 reports the caps on attach and detach.

- 0004-0006 cover cpu hotplug.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-attach-ecaps-v3

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         | 157 ++++++++---
 kernel/sched/ext/internal.h    |  71 ++++-
 kernel/sched/ext/sub.c         | 625 +++++++++++++++++++++++++++++++----------
 kernel/sched/ext/sub.h         |  10 +-
 kernel/sched/sched.h           |  17 +-
 tools/sched_ext/scx_qmap.bpf.c |  25 +-
 6 files changed, 683 insertions(+), 222 deletions(-)

--
tejun
