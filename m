Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F43E49C2
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946286; cv=none; b=QLaBqGDRkrkjiTde5qhGZ1CKnBS54VTSO8QVXOsCPZ+ot1tr9Gbgekv/oO5wfL79l9nSW4JqBkyNDV8WMQDR7GocgXe4IO31p8nPGU28et+HawWNghQLLDj3PbpRI92boL+aFhp0bfU55cdz0zo4QBJ4Nj+tbZd0rRxMCNsQqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946286; c=relaxed/simple;
	bh=Fy3ns/ZnbLZXhijt7Rc/AHXFsVYqq574Btv1EqTJQlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+A7qJ2si6OX1I5jIS2s/V7jiMR3jHbrQmYbexG0QACpu5CMwTK0+zDdZ/UM9re3/i7LnfLd/SYtsenOLD3HQUxwRd9foafzu7M+ohh3rq51lmfvLIHKFCcL5bVdgb9ib6406NCE4GOPlfdlafW7aElDx+s+CcJcfn5xuIDE8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZvXJqV6G; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZvXJqV6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fF
	zHyQeuvhMYcUOa4ltm3Z1+jcIQ8uPomv6l9bRurMA=; b=ZvXJqV6GFufHmoMad8
	uqUNzCzyZK3h+PjWHnxvloF5VbMn3GiAMtqt6FziVnRPmVy5ts7VfkXdy4prOh4f
	oTkRPPWPB9e1GXSVLIM1pUAQ6WQvI8HJiZksulLXG4V3cRuuXZEkiOEKRU/evW27
	jB3P9OuEZKRmMkQ/hgkXjgFmw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCn78kOJ6FqofNuBg--.25246S2;
	Wed, 09 Sep 2026 17:29:51 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v4 0/5] sched: Handle split scheduling and execution contexts in task ticks
Date: Wed,  9 Sep 2026 18:28:56 +0900
Message-ID: <20260909092901.2989564-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn78kOJ6FqofNuBg--.25246S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr17GFW7ZF15CF15ur1fXrb_yoW7ury7pF
	ZYqa43Jw1kKaySyF4fCwsYga4fC3Z3J3WUXrsrKry8ur98t3WrKr1F9r1jvFy5ArWFkFn2
	vr1DZ3s7Cr1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-jjgUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRDQMGqhJxAWZgAA39

Proxy execution allows a task to execute on behalf of a different
scheduling context. Scheduler tick users do not all operate on the same
context: scheduling-class state and core-scheduling slice decisions belong
to the donor, while NUMA/cache work and RT watchdog state follow the task
that is actually executing.

The sched_class::task_tick() interface currently receives a single task
argument. Under cross-class proxy execution this is insufficient because
both the donor class and the execution class can have tick work to perform.

v3 handled the NUMA and cache cases with a common execution-context helper.
Following Peter Zijlstra's suggestion, v4 instead removes the task argument
from sched_class::task_tick() and lets each class derive the state it owns
from the runqueue. The common dispatcher invokes the donor class first and,
when the execution class differs, invokes that class afterwards.

The series is organized as follows:

- Patch 1 introduces the split-context task_tick() dispatch mechanism while
  keeping the existing class-specific behavior donor-gated.
- Patches 2 and 3 move NUMA and cache tick work to the FAIR execution
  context.
- Patch 4 keeps RT scheduling-class state and RR time-slice management with
  the donor while associating the RT watchdog with the execution task. It
  also handles an RT execution context whose donor belongs to another
  scheduling class.
- Patch 5 fixes the complementary core-scheduling issue found during
  review. task_tick_core() correctly remains donor-based, but the donor's
  sum_exec_runtime does not advance while another task executes on its
  behalf. Measure the donor's consumed slice in the task-clock domain
  instead.

The RT watchdog follows the task whose execution runtime advances, while
RT scheduling-class state remains associated with the donor.

Changes in v4 (since v3):
- Rework the series around per-class task_tick() dispatch as suggested by
  Peter Zijlstra, replacing the v3 common execution-context helper.
- Call the donor class before a different execution class so runtime
  accounting is updated before execution-context consumers run.
- Keep task_tick() outside CONFIG_SCHED_HRTICK and preserve queued/hrtick
  behavior.
- Keep task_tick_numa() and task_tick_cache() local to fair.c and preserve
  the ordinary FAIR tick ordering.
- Fold in the RT watchdog proxy-execution fix, rebased on the new
  task_tick() interface, including execution-only RT callbacks with another
  donor class.
- Preserve RT-policy watchdog intervals across temporary DL PI boosts while
  still clearing stale intervals when non-RT owners leave RT proxy service.
- Add the separate core-scheduling donor slice-accounting fix identified
  during review, using a task-clock selection baseline.
- Extend the proxy-execution reproducers to cover FAIR/RT/DL cross-class
  and same-class dispatch, NUMA/cache work, RT watchdog behavior, and
  core-slice accounting.

v3: https://lore.kernel.org/r/20260904085244.799276-1-sh_def@163.com

Testing:
- Built kernel/sched/ at each patch boundary and built the final x86_64
  bzImage. Also tested CONFIG_SCHED_HRTICK=n, CONFIG_POSIX_TIMERS=n,
  CONFIG_SCHED_CLASS_EXT=y with proxy execution disabled,
  CONFIG_SCHED_CORE=n, CONFIG_NUMA_BALANCING=n, CONFIG_SCHED_CACHE=n,
  and CONFIG_FAIR_GROUP_SCHED=n.
- Verified NUMA and cache execution-context ticks and actual work callbacks
  in a two-node, two-SMT-pair QEMU guest with FAIR, RT, and DL donors.
  NO_HZ_FULL remote ticks were also exercised.
- Exercised RT-to-FAIR, DL-to-FAIR, FAIR-to-FAIR, RT-to-RT, DL-to-RT,
  and DL-to-RR split-context dispatch. hrtick callbacks with queued=1 were
  also exercised.
- Verified FIFO/RR watchdog attribution, blocking and nested proxy
  execution, SIGXCPU, hard RLIMIT_RTTIME handling, and DL-donor/RT-owner
  execution. For DL-to-RR execution-only callbacks, the execution owner's
  watchdog advanced while its rt.time_slice remained unchanged.
- Reproduced an incorrect 123-to-0 timeout reset when a SCHED_FIFO owner
  was PI-boosted into the DL class. With the policy guard, the timeout
  remained 123 during the boost and after deboosting; a FAIR owner leaving
  RT proxy service still reset its timeout from 123 to zero.
- Compared the existing and task-clock core-slice predicates over 89,900
  non-proxy samples across HZ=100/250/1000 and nice -10/0/+10, with zero
  mismatches. Under proxy execution the donor's sum_exec_runtime delta
  remained zero while the task-clock delta advanced and reached the
  force-idle reschedule condition.
- Exercised dynamic nice and cgroup-weight changes, migration, and
  execution-owner handoff.
- Ran a 31-minute KASAN/LOCKDEP soak covering 33 cycles x 13 modes
  (429 cases), with no failures or kernel fault reports.

Hui Su (5):
  sched: Dispatch task ticks for donor and execution classes
  sched/numa: Drive NUMA task tick from execution context
  sched/cache: Drive cache task tick from execution context
  sched/rt: Fix RT watchdog accounting for proxy execution
  sched/core: Fix donor slice accounting under proxy execution

 include/linux/sched.h    |  3 ++
 kernel/sched/core.c      | 43 +++++++++++++++++++++++++--
 kernel/sched/deadline.c  | 10 +++++--
 kernel/sched/ext/ext.c   | 10 +++++--
 kernel/sched/fair.c      | 64 ++++++++++++++++++++++++----------------
 kernel/sched/idle.c      |  8 ++---
 kernel/sched/rt.c        | 23 +++++++++++----
 kernel/sched/sched.h     |  2 +-
 kernel/sched/stop_task.c |  5 ++--
 9 files changed, 121 insertions(+), 47 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0

