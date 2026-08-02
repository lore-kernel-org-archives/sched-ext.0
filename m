Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD775801;
	Sun,  2 Aug 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707689; cv=none; b=qbroaXMOJjyR63MTwy3mMPO9PITfEuaualCqvl5jzBxqZXiaxULVX09mg1Q2JPqNRanEznhmLowttjo6YQLgvveJM4Z/DdLEaxmCyXGSOANvXj/QcyJjGRqoz3GeCYhggDZ+/Ubd8ODeJ3gNRurEwG8tYh9dj4ljfBChdUsQdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707689; c=relaxed/simple;
	bh=cxQw2/b/J4xBQO5TVVUUzObXXV89h5BwvBDLj8EAacg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKJUOO8mWoW8Gb+Ce/lUtlPi4le7b2ojO8rr3NWyhhTKOC7rxWHqXmvbgUUlCtl4IkqSt4aSTqXVurtFzYOSGjEeS7G+N4J1nG1s51DIATPWGYdnDu08LKcWQgWTbAeZD7+j43/22dO/nWMP0RoL7gio9cVPRBr2xqjlYyiCKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE/Rl+SK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE/Rl+SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B421F000E9;
	Sun,  2 Aug 2026 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707688;
	bh=NVwjZYSYQt34aKOHmt/XjMl9xoBqi7S5UyPbN2YyzZg=;
	h=From:To:Cc:Subject:Date;
	b=aE/Rl+SKY3ZOG6YyJYNv/Zj2T5jli2QxS66OnDdN2Vpaz62HTQLfryWcXd+dtWFoS
	 PKu0I2+tEZZfcEQKkb48oWqDHq1Hlvec0eD3WV3USZPIMl67YFuNAXwiBaH1cOtQiW
	 p69U42J4zIXew7y9fPafz5QMkNVHTMcdAx2MbFPCs8lEeYn5FbK167Nc1O8pjfZ3xx
	 z8M3W0gLaqafDnORTHNLanygn+8m2KgTWlaK/HO6rdI2pg95t2KDsyw18ntK0DBlLl
	 9asPeRLTiNzAG2ft4HAOMVdq6oKp9GfYABEoWavHV1W6VQ8MbntCwmLL0Wpn+whgpC
	 xPPVAvUNIVN1A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Bandwidth-limited rescue execution for stranded tasks
Date: Sun,  2 Aug 2026 11:54:35 -1000
Message-ID: <20260802215447.3134509-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2: Changes from the sashiko AI review:

    - Declare scx_sched_all outside the CONFIG_EXT_SUB_SCHED block, the
      definition is unconditional (0002).

    - Track the overload grace and usage-decay timestamps in jiffies_64 so
      that 32-bit arithmetic on them can't wrap (0009).

    - Drop the now-unread always_enq_immed rodata mirror (0011).

v1: https://lore.kernel.org/r/20260801085150.2697653-1-tj@kernel.org

A sub-scheduler holds only the cids its parent granted and nothing
guarantees that they cover its tasks' affinities. A task that can run on
none of them currently has no good ending: the scheduler's insert is
cap-rejected and reenqueued until the repeat limit ejects the scheduler, or
the task stalls into the watchdog.

This series adds kernel-side rescue execution. A scheduler marks an insert
that may be cap-rejected with SCX_ENQ_RESCUE and the kernel, instead of
bouncing it, runs the task on the target cpu at a small configured
bandwidth. A rescue starts out non-disruptive. Schedulers that hold caps on
the cid largely stay in control of the cpu - a preemption cap, for example,
still lets its holder preempt the rescuee. When a rescue goes unserved for
too long, it escalates into protected execution.

When a cpu's rescue queue stays oversaturated past the overload threshold,
the kernel ejects the sub-scheduler with the highest recent rescue
consumption on that cpu instead of misblaming the waiter's owner.

- 0001-0005 are preps: naming, helper visibility, dsq-move flag vetting and
  the IGNORE_CAPS preemption waiver.
- 0006-0007 synchronize slice/dsq_vtime writes at insertion commit and add
  SCX_TASK_PROTECTED, the groundwork that lets a kernel-granted slice
  survive scheduler writes.
- 0008-0009 add the rescue machinery and the overload ejection.
- 0010 syncs the tools autogen enum headers.
- 0011-0012 fix scx_qmap's pinned-task direct dispatch and add rescue
  support as the demonstration consumer.

 0001-sched_ext-Rename-scx_local_or_reject_dsq-to-scx_reso.patch
 0002-sched_ext-Make-several-ext.c-helpers-available-outsi.patch
 0003-sched_ext-Factor-out-__scx_bpf_now.patch
 0004-sched_ext-Reject-internal-enq_flags-in-the-dsq-move-.patch
 0005-sched_ext-Make-SCX_ENQ_IGNORE_CAPS-waive-the-preempt.patch
 0006-sched_ext-Synchronize-slice-and-dsq_vtime-writes.patch
 0007-sched_ext-Add-SCX_TASK_PROTECTED.patch
 0008-sched_ext-Add-bandwidth-limited-rescue-execution-for.patch
 0009-sched_ext-Eject-the-top-rescue-consumer-on-overload.patch
 0010-sched_ext-Sync-tools-autogen-enum-headers.patch
 0011-sched_ext-scx_qmap-Idle-check-pinned-tasks-before-di.patch
 0012-sched_ext-scx_qmap-Add-rescue-support.patch

Based on sched_ext/for-7.3 (c5b9316cf3d5).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-rescue-v2

 include/linux/sched/ext.h                       |   7 +
 kernel/sched/ext/ext.c                          | 690 ++++++++++++++++--------
 kernel/sched/ext/internal.h                     |  78 ++-
 kernel/sched/ext/sub.c                          | 497 ++++++++++++++++-
 kernel/sched/ext/sub.h                          |  41 +-
 kernel/sched/ext/types.h                        |  12 +
 kernel/sched/sched.h                            |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |  16 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/sched_ext/scx_qmap.bpf.c                  |  89 +--
 tools/sched_ext/scx_qmap.c                      |  24 +-
 tools/sched_ext/scx_qmap.h                      |   1 +
 13 files changed, 1187 insertions(+), 285 deletions(-)

--
tejun
