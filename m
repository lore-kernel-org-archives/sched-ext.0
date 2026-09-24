Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1730C142;
	Thu, 24 Sep 2026 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284795; cv=none; b=DnwkYERUbJ8TrPnPvSKPjdms+IGgseo8j2qgwNHl8FgNMyohKnRGgCc90bcc/m0EXUfYb8fbhh2WGqNYY0tR7GV+sUfKwxzlTcTaOxoQNu9hFDkvjp8wBszbuSDovBEXutxSXrnzyrlmxrJ01IcCMTDuQswFSCK+zsoEPmLhNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284795; c=relaxed/simple;
	bh=il6CD+udxM9Q79dxH2fF1i6WSjN6YNdMEY+NBba0Pzw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=jB3EdHeY42I2sMc1GRZHmWVFB16uUYlZzUekWT8K+e2H3pvPNwvVv+3r16ITAPRgetGJHfgM5IaV6quUID9wVFTe6/hzUne/YtjbAukw+HG8eT7eLFDAKrCaoGm8AsndPyanZ9w4PQi6dPi9xbgUJET/nE/FfpZ+pgaeJl1VCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngJp59Tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngJp59Tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD34E1F000FF;
	Thu, 24 Sep 2026 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790284787;
	bh=MlwzQF8d1p8Q1Kw/wJj/bEnhAei43APQe7dwOOz+qaQ=;
	h=Date:From:To:Cc:Subject;
	b=ngJp59TkyVeSV6Jxts7JG9csHubPlg2zgBchruolhx3P5F2uefK1qX/3Q7hA+ABzC
	 dE7aZbVJX1cYTqNZfspUWQ2a1YhymrK/J4i8gTDCLeba/W7vAuPN0OFhhdnQIRoVmP
	 MO5z0GpJM6LWMt+DeGRNvgwlSF6f3VzC+/TqoJvltMkO6FugNAlgGikxkHN/J+/FPp
	 Rgaynm0l1Oi7MLIADHEFkXs/ZYwcPAONEEn7odaFQPSPRWCx505guB9Xehu0kjoB+d
	 KBaQjN61G8IpfJNVZhoz2cbseK62g/m2adF1v51h/3FcQ+VpKR1KKxH8QwZvC3J28A
	 uYut/iI+1V43Q==
Date: Thu, 24 Sep 2026 11:19:47 -1000
Message-ID: <be7ef09b8be82e9f0c5fb2bf197d7a44@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.3-rc4
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit a9e3760b0838299649c0d57cca44daaf40ba3c33:

  sched_ext: Maintain an online cid mask in the scheduler arena (2026-09-15 06:57:20 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes

for you to fetch changes up to 4409a85735cdca5c4c400c0dad1feee091872eee:

  sched_ext: Count SCX_EV_SUB_BYPASS_DISPATCH in the dispatch fallback (2026-09-23 08:16:10 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc4

- A task reenqueued while its dispatch was still completing had its queued
  state clobbered by the dispatcher, dropping every later dispatch of the
  task. Wait for the in-flight dispatch to settle first.

- A wakeup activation on another CPU marked the destination runqueue as
  mid-wakeup, stranding a pending local reenqueue. If the scheduler was
  unloaded first, the stale request pointed into freed memory that the next
  scheduler dereferenced.

- ops.dequeue() ran with the source dispatch queue's lock held, so a
  scheduler iterating that queue from the callback deadlocked the CPU.

- Schedulers with their own CPU ID mapping had no way to learn a task's
  initial CPU mask and rebuilt it themselves, which went wrong across
  sub-scheduler enable and re-home. Pass it to ops.enable().

- A bypass dispatch event counter missed the dispatches made by the
  end-of-dispatch fallback and under-reported.

- Selftests for the dequeue locking and initial mask changes.

----------------------------------------------------------------
Liang Luo (1):
      sched_ext: Count SCX_EV_SUB_BYPASS_DISPATCH in the dispatch fallback

Tejun Heo (4):
      sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task
      sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue flags
      sched_ext: Pass the initial cmask to cid-form ops.enable()
      selftests/sched_ext: Check the cmask cid-form ops.enable() receives

fangqiurong (2):
      sched_ext: Don't run ops.dequeue() with a DSQ lock held
      selftests/sched_ext: Test that ops.dequeue() can iterate the consumed DSQ

 kernel/sched/ext/ext.c                             | 156 ++++++++++-----
 kernel/sched/ext/inlines.h                         |   4 +-
 kernel/sched/ext/internal.h                        |  60 +++++-
 kernel/sched/ext/sub.c                             |  11 +-
 tools/sched_ext/scx_qmap.bpf.c                     |   3 -
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 .../testing/selftests/sched_ext/dequeue_iter.bpf.c |  73 +++++++
 tools/testing/selftests/sched_ext/dequeue_iter.c   |  79 ++++++++
 .../testing/selftests/sched_ext/enable_cmask.bpf.c | 217 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enable_cmask.c   | 138 +++++++++++++
 10 files changed, 671 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.c
 create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.c

-- 
tejun
