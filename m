Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DB324B0B;
	Tue, 11 Nov 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888697; cv=none; b=GdRhCP3Edzsb+L0I+l/yNuN4IwJE5T2r4dV+Y5ANIyeIAjGNmQZIjAkq7Ig8dxDYDZWhia/7hEzVL3akxqZ4hq8ngQMXmwuQt2Slwmpf0IdIAWCHSZf5DQJhpiMw/5xNWX14f1lvNJAtAkH1MIbDC+iGm3c70t+ngH8cCXNMUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888697; c=relaxed/simple;
	bh=K6CxKHnS4nc7Sgf1wuDOm8ygfnlmy3eQSyA3TaN1IuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7DrsP1dC+9jDpSqOuY6In4Yhi5sBFviU3aIuIf14olaSw+21Ck/XpCjNRiqHN/AlxInBSbCBxarfKrButCx5kObrgbrnmkZo2ennxBnxJs8s7YXaMbhchiMenDWsoKJoK0/xwyKVNIaYF3kguhBVWBRA+qbmpJhf/gsmx+Z1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONiBI/Nn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONiBI/Nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44654C4CEF7;
	Tue, 11 Nov 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888697;
	bh=K6CxKHnS4nc7Sgf1wuDOm8ygfnlmy3eQSyA3TaN1IuM=;
	h=From:To:Cc:Subject:Date:From;
	b=ONiBI/NnbpPeuHBji1qRL/95a/Amn/99iY6hCeGh+dy7pPKp8iizqvNIHizqi0bq2
	 8ggee7EiFsDAGGEsjE0MPN3Gvkk2gtMqX+XvVNExSizf3tkUsyUGutOzoMNk6wcKjE
	 vnRov3lzvidZXyEmivmNDFiBGvoCs/SlPmj1seTmqUJOHF+F7HjCTFPo6bpJcZ1jQk
	 JObmjTu8LoPA7fqZW0ct/+f+J6DKcHBq0f/QN43VYejdwPCpmsZycYTMYbtf6U7crZ
	 C3K13oCVN4hfLPt2/1jKAu73dHUUHPyXBrBkOur3Kx/h+GfuKNvmzL3i/UL41rr9O5
	 NMI1uWE2j1fpQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-6.19] sched_ext: Improve bypass mode scalability
Date: Tue, 11 Nov 2025 09:18:03 -1000
Message-ID: <20251111191816.862797-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: - Removed first patch.
    - Added READ_ONCE/WRITE_ONCE for scx_slice_dfl access (#1, Dan).
    - Added missing dummy scx_hardlockup() definition for !CONFIG_SCHED_CLASS_EXT
      (#9, kernel test bot).

v2: http://lkml.kernel.org/r/20251110205636.405592-1-tj@kernel.org

Hello,

This patchset improves bypass mode scalability on large systems with many
runnable tasks.

Problem 1: Per-node DSQ contention with affinitized tasks

When bypass mode is triggered, tasks are routed through fallback dispatch
queues. Originally, bypass used a single global DSQ, but this didn't scale on
NUMA machines and could lead to livelocks. It was changed to use per-node
global DSQs with a breather mechanism that injects delays during bypass mode
switching to reduce lock contention. This resolved the cross-node issues and
has worked well for most cases.

However, Dan Schatzberg found that per-node global DSQs can still livelock in
a different scenario: On systems with many CPUs and many threads pinned to
different small subsets of CPUs, each CPU often has to scan through many
tasks it cannot run to find the one task it can run. With high CPU counts,
this scanning overhead causes severe DSQ lock contention that can live-lock
the system, preventing bypass mode activation from completing at all.

The patchset addresses this by switching to per-CPU bypass DSQs to eliminate
the shared DSQ contention. However, per-CPU DSQs alone aren't enough - CPUs
can still get stuck in long iteration loops during dispatch and move
operations. The existing breather mechanism helps with lock contention but
doesn't help when CPUs are trapped in these loops. The patchset replaces the
breather with immediate exits from dispatch and move operations when
aborting. Since these operations only run during scheduler abort, there's no
need to maintain normal operation semantics, making immediate exit both
simpler and more effective.

As an additional safety net, the patchset hooks up the hardlockup detector.
The contention can be so severe that hardlockup can be the first sign of
trouble. For example, running scx_simple (which uses a single global DSQ)
with many affinitized tasks causes all CPUs to contend on the DSQ lock while
doing long scans, triggering hardlockup before other warnings appear.

Problem 2: Task concentration with per-CPU DSQs

The switch to per-CPU DSQs introduces a new failure mode. If the BPF
scheduler severely skews task placement before triggering bypass in a highly
over-saturated system, most tasks can end up concentrated on a few CPUs.
Those CPUs then accumulate queues that are too long to drain in a reasonable
time, leading to RCU stalls and hung tasks.

This is addressed by implementing a simple timer-based load balancer that
redistributes tasks across CPUs within each NUMA node.

The patchset also uses shorter time slices in bypass mode for faster forward
progress.

The patchset has been tested on a 192 CPU dual socket AMD EPYC machine with
~20k runnable tasks:

- For problem 1 (contention): 20k runnable threads in 20 cgroups affinitized
  to different CPU subsets running scx_simple. This creates the worst-case
  contention scenario where every CPU must scan through many incompatible
  tasks. The system can now reliably survive and kick out the scheduler.

- For problem 2 (concentration): scx_cpu0 (included in this series) queues
  all tasks to CPU0, creating worst-case task concentration. Without these
  changes, disabling the scheduler leads to RCU stalls and hung tasks. With
  these changes, disable completes in about a second.

This patchset contains the following 13 patches:

 0001-sched_ext-Use-shorter-slice-in-bypass-mode.patch
 0002-sched_ext-Refactor-do_enqueue_task-local-and-global-.patch
 0003-sched_ext-Use-per-CPU-DSQs-instead-of-per-node-globa.patch
 0004-sched_ext-Simplify-breather-mechanism-with-scx_abort.patch
 0005-sched_ext-Exit-dispatch-and-move-operations-immediat.patch
 0006-sched_ext-Make-scx_exit-and-scx_vexit-return-bool.patch
 0007-sched_ext-Refactor-lockup-handlers-into-handle_locku.patch
 0008-sched_ext-Make-handle_lockup-propagate-scx_verror-re.patch
 0009-sched_ext-Hook-up-hardlockup-detector.patch
 0010-sched_ext-Add-scx_cpu0-example-scheduler.patch
 0011-sched_ext-Factor-out-scx_dsq_list_node-cursor-initia.patch
 0012-sched_ext-Factor-out-abbreviated-dispatch-dequeue-in.patch
 0013-sched_ext-Implement-load-balancer-for-bypass-mode.patch

Based on sched_ext/for-6.19 (5a629ecbcdff).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-bypass-scalability-v3

 include/linux/sched/ext.h        |  21 ++
 include/trace/events/sched_ext.h |  39 +++
 kernel/sched/ext.c               | 518 +++++++++++++++++++++++++++++----------
 kernel/sched/ext_internal.h      |   6 +
 kernel/sched/sched.h             |   1 +
 kernel/watchdog.c                |   9 +
 tools/sched_ext/Makefile         |   2 +-
 tools/sched_ext/scx_cpu0.bpf.c   |  88 +++++++
 tools/sched_ext/scx_cpu0.c       | 106 ++++++++
 9 files changed, 663 insertions(+), 127 deletions(-)

--
tejun
