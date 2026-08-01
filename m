Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BA256C8B;
	Sat,  1 Aug 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574313; cv=none; b=O6rxVuo23t/4A0E+bd3dKL6BGI4gifmulPvUsFaaGK97svvJjlAtqXDnPOYxa+5TnSfp80sFqt7VT0hZ78txnNdFeDRDBFgXrQwlA7L2ftErRFMcn/I/rvKEBQ1GBVNBZ23EIgf1d2Cz5I4iHcGCfk6f7G2iuvd4BulXKpghITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574313; c=relaxed/simple;
	bh=z1EYT1mdMHSkFtqJdTIUcbHpk4i/aa/d+JGDmvE1hpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P193zQPO39XhxyKVn2jbjS3LlJAmTqC7ISG8L+iRs5jbSfVvabngv9Dn0R2kadibO1qvNncrH6o2vWwxjT7xaRyEvs128HjhbP1zZWAaqY7OJH9N+Vzd3MvMbzW0Lo2S05P9QtDnVJrVOKz3LQL6Cfu16bmmMe0HSrcvbrjZVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVK69Zrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVK69Zrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A559A1F00AC4;
	Sat,  1 Aug 2026 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574311;
	bh=CiX1sQC9+P5DnbJ2hx3Q+w/JK6q7h4KqOKOaeEP4/5g=;
	h=From:To:Cc:Subject:Date;
	b=kVK69ZrmxBR13TP8rV3muerD1iNp2xOkpERoEY/j4w6L37NxLv2WLBA2e0qj1BxmK
	 8axZi5iXwbllZj+4moDbtAM5OAyhv+mCe2bmXWiQHc86uP3bVXafkkUNWlKVWxMlOy
	 T9F6Ao8qXSRFKg5w2n1YnC3KZV3gWFclW9nyv8pT32149wce10IEjybBT/oHWRofs9
	 jvdDeckKEAjfvQ0Xp5i7w8gZLv3o6C/8VkKdJbCg7r50JRZ90xybchmfIkvKecjh7n
	 kbpb4ZvfNfrwrG0SWJAwEaBekEVbIMQJjjh6rBuiJ19LPTLkhWGtF+snXerGmFXt13
	 ujbodDKov+aRw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.3] sched_ext: Bandwidth-limited rescue execution for stranded tasks
Date: Fri, 31 Jul 2026 22:51:38 -1000
Message-ID: <20260801085150.2697653-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

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

Based on sched_ext/for-7.3 (ee7aece60817).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-rescue-v1

 include/linux/sched/ext.h                       |   7 +
 kernel/sched/ext/ext.c                          | 690 ++++++++++++++++--------
 kernel/sched/ext/internal.h                     |  78 ++-
 kernel/sched/ext/sub.c                          | 496 ++++++++++++++++-
 kernel/sched/ext/sub.h                          |  41 +-
 kernel/sched/ext/types.h                        |  12 +
 kernel/sched/sched.h                            |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |  16 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/sched_ext/scx_qmap.bpf.c                  |  88 +--
 tools/sched_ext/scx_qmap.c                      |  23 +-
 tools/sched_ext/scx_qmap.h                      |   1 +
 13 files changed, 1186 insertions(+), 283 deletions(-)

--
tejun
