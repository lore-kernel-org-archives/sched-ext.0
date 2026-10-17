Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73203355F49;
	Sat, 17 Oct 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255558; cv=none; b=cSN6D4cwCRV4ehtDDoFZgIXvzw/v9WfCVQ2GKyqLu05U4w8em/rx4KWJtyQr83Jqsea/PWH/dhFsd6sIZsBy/MI2gRFLf6CcIsTHmRLTbSZEV6mpjb/fG809iF4b3Nc43+LaRrAIEPU99ogh6qL1MHk5O6Rb/sq27jLWT0cz8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255558; c=relaxed/simple;
	bh=Lys8GRdYyxDU8E+GoKzvsQO1fMlUOA+t/ccwWB9bds4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qA8tbG5gng2EPl34v6c/YeLilQ+c7zC9+UXv9IEcdrRTJEfEbV7Il/D7Kuf01JXfcZx0S8NDxFm4sc2Vz3owAY4Pc7jux7pKMxYbEnNotiXWIpFWNHQgfBKHyX9dBuNy6MRRBqbp8LyllFcUig8hj3bo5NRBMmtbEy4M8rWQs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuqWCkrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuqWCkrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCF41F000CC;
	Sat, 17 Oct 2026 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255557;
	bh=g/iOltkrVN4U7SJFLPmyrz6ktfbwaClLJPPQgGdNzHc=;
	h=From:To:Cc:Subject:Date;
	b=KuqWCkrvL4Tn4zqat1oQ7zhL3c10D163wVIPZLt4aElin6+3jzKuQ3Fk6R4Z1cbKz
	 oZql2iqSvOEwVsfWsl+YlMc8gW0+4nEoFTGOMW16peiSO9zblyuJC6jdDvB0h0oMWv
	 0GawPdEPpxrpvGjkUHWoeWCzb1Ti/jJoXOOgVjWdiqGoP0x4MpubbkES2niGW3Clcc
	 3i8ylx456ga+IP2sS9YA9k0fPyOKKo5VWKGsJEqEa6RiClucLEFmNpGoyps/7zR0vF
	 4o0KlburNlMzUR38eTE0MviFTL9qbVo1zsgi3eD0wHGyrqh9P858jN6FwP8TIJ6Us5
	 lL8r2ocZjXn3w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.4] sched_ext: Report a sub-scheduler's ecaps on attach, detach and cpu hotplug
Date: Sat, 17 Oct 2026 06:45:50 -1000
Message-ID: <20261017164556.4136807-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2 (detach and cpu hotplug):
- Report the caps on detach as well as attach, and deliver regardless of
  bypass, which drops the replay at unbypass (#3).
- Drop the sync_pcpu_ecaps() factoring. Add the cid_pshard() factoring and
  free a sub-scheduler a grace period after discarding its syncs (#1, #2).
- Deliver only while the root has the cpu online, report the loss when a
  cpu goes offline, and leave suspend and hibernation out (#4-#6).

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

Based on sched_ext/for-7.4 (db87a8f530b6).

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

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-attach-ecaps-v2

diffstat follows. Thanks.

 kernel/sched/ext/ext.c         | 116 ++++++--
 kernel/sched/ext/internal.h    |  69 ++++-
 kernel/sched/ext/sub.c         | 612 +++++++++++++++++++++++++++++++----------
 kernel/sched/ext/sub.h         |  10 +-
 kernel/sched/sched.h           |   8 +
 tools/sched_ext/scx_qmap.bpf.c |  25 +-
 6 files changed, 625 insertions(+), 215 deletions(-)

--
tejun
