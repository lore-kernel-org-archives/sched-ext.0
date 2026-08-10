Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71041834A
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374956; cv=fail; b=Iv7qhDPj7FjtR2fVJ71lCc2ijwB4Xl2qXb/ns8YeYsgsmTSX9garH4YCFt+lL1gvsx4egedlJ0/mXv0JVNdkc+9P/uIOJN/6o7SJcx2GbvNzg+dwwlCVuiIiwMAupOa1pcFdtbWtjCOc+c+vsjLXkW/yFalF/sDAWPrI//1h1Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374956; c=relaxed/simple;
	bh=T0jq5DKl4UzxUJeslpMnAiOoQgfgVKW6uXbFXSfx3io=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eJG4Bq8N3Tf8hbULMsANQGWjlCL1GqT/+lRYTr+YJyW8qoIIXnpUL1t2JzV6CnTpNvDTt8L10+t6EY02GbltvKngDe0H8bGjgv/IZN/+SEerKwNoVtTNoc4M3NxFC3rAMyo6BrNLo0WDpHqnVKfwTHSlMZSKaY4xxw08x04d4A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3FE/2Qa; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3FE/2Qa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyL+/iXGoaIk4HiW+UW8omX1pTB8sLYTE+IGM98ia4l/fzeWllBedbAvCojiJbyrmjoHvUnPj4pmh+M2dn9DRzIKAs+STu1GnzS4egL3rBYtc7DlA19q+PsrbyjSlMpise57/emGyzD1nTsfklVNOMYuoaXQICGgRnWd7cjscdL34nLu59NrXoXLTdVR9/VKQH7gdmDKGjnEEupo/eV9ql5xHql4eXDdnnADLVhLxU9SLsx5moZtdvtesNPGJ4asiz2okNwp6FNZJBWbdIjfpOmDGKu5cIqLy+/82haWqCYxeZCAQpnKzA1Lk6FYib/+vocLTzE8prRkCyWUH5252w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmRii0vEU+X7BLnjjzaqzWPiV8EcutZ7qmRkJfphUpE=;
 b=jvPMBspkg+qKkkvFFCCD2u8ydQ9R3t10BL6Y6d5qJuADjeLVDiqAi1GvOj1U2ta6lMnLozwY7ggqkNbEiT3cevBu4efg36IGA/IgDvpqksDKIVyicZW83mW9pdvcMdYods+1xvnuJBcelWqfNtXygx+TEDVcJp4rUR3yheJNvk3Aq7/0pRQ7HgaegFacHyMMxl5WS6/qf5UYG5/43njZOnY6m9eSfB4b7+DAuul+ZNjU3Rr+MPS7RKiSwokGGBeuve1jV5NcOXWz7CT7//gZ7x0LxfXy3FT7wiNG7He/9x/Y5vKxDPykP1pwa8RjacPlZb8RuanQKpQdNGiU6+X+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmRii0vEU+X7BLnjjzaqzWPiV8EcutZ7qmRkJfphUpE=;
 b=Q3FE/2Qa79KZVWne1L2l80M84pVwDxG3iFFC4jcN5knhRre2YapbwMVkHGHnzxnb/NsbjlEBJ/No+Tvpub/hQ20MnnJB0YBdTRS0MsOO7XY1jpSzrNyrWldT4KiUYbgn5vhuAxUnOGQicZlWQIKkcE/YqRNVnrmnhIqU6m9846qzogpVShpXRgPkp3kJyACcIPU3q5p2DZD4SWLl2m+046c/mwSBk/52G9ej3NMR/I7r4rs+AtfzoZizt70ksI4iwKc1hRztaA7I8mUXSBLMogN6VaTizVE7P4TG5bkN8GEVdsRcOKxyHM1QxF0F6nFmWpZIA3GvKx5+QylfFHYweg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Mon, 10 Aug
 2026 15:15:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:15:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v11 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Mon, 10 Aug 2026 17:13:46 +0200
Message-ID: <20260810151523.86994-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 504b5645-cd6f-4286-af3a-08def6f23d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|56012099006|11063799006|5023799004|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2Imh2qpnAHecLd0Sl+8Rtsb15+ZQFj0jIY0mz2e40dhxJIWYKy4wus8IdSeuC4Le/imQCM0SVgNaTa/kyOVMD2QZ+ivmBa2A1MIaxT9WqEp2psHnPD5Qlx3AbsdUr4b0S/7jdYuQFjHu4cOV3XdZawynHcgTnYZc7G8PlOpPR4kgknRg72YG4YnTp020h8OQwSyRFPYTlJXPA7k1THlUspv30Ldn3HwQyPjcO306saRq3vvhY2tVvR10m+KWBeJ0cT0ouXO7dfnqOai2Nf+cfm1EBsqGn3BRp1F+A6j9t/gfjl59BIRjW0+uUzvgmR6z0W4rywDN/I7CX8lVJNgNHz6wS+Xv8SF4THhSNpZrO/5vwTKqfrrfN4XPczoOs4i+ggdoUCWJyTFFa70kLJzIIQ8xpB19dFXjI1AhZULNJK96WlHVv5TZ/p3TfxaKInbCOfps+yL5Xlq4QdvPBR2n5NGqIae/bB/cnRR2GWU5wvwye30Eoyx5M2Keu7NisDM2n+PJPG54RCBXxWESPTjsxJX+1pWid3wWBySAQXTgkHugp9oXgHxgGkUIJ7ngYnN43nvc0GyNs7R4ewB5rIT2A5Yn93Y0jcoNuXexuHWeFdAB4mlw64kxKmwiU4f3pwPeOZY3EgYRjV05WTD3lvSd8+hODsN0UIYrHxBreWexgbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrtxQg5LdeUhecUIHHwOqtucLtzKkdVnV8DTgn8xAOSX866tlfLkkl6zQvxe?=
 =?us-ascii?Q?WConcexX7W7foOkHFwV327Lj7EdUV9xnds6aEMnuaohYlKPr1MwBtwaAOmQU?=
 =?us-ascii?Q?WDxn3+PpmIo134nBKDrDoFzP8MEHuHalKVVg0TQ9P6VTFDWN2pQtPXLDjOmW?=
 =?us-ascii?Q?Oa8hmpu8p2tz4XFXXbc+dFA+T5/i/IjUXQfkPIqMoUAHSfwMzfyTGL8+8XVv?=
 =?us-ascii?Q?RaJeEyOjn7I15BPrmKSbVrxi9l41fHLAC+Q9RXtVo1z50vtDc8KWfBx2/i3a?=
 =?us-ascii?Q?0ohX1Rjt+3LTomXodvSaBVwuWlM7iCWWuxKyth2V1V9EG8nA0ZMjSQTsLgaY?=
 =?us-ascii?Q?cif/+fUydZpk69hKWOAtI+3mYlcE40kUjszBT6vGZ+oKyhawP+effNDLHM25?=
 =?us-ascii?Q?E5++o4HDsOSCLGhR0Y7JyfCKqcb7I6bHVVLm6a+LbAtLjLqh5c8ktvOOWlZi?=
 =?us-ascii?Q?QwICAOopV0T75T7CPsAXuHZxkfcifdJM5SWHafab2ViVltnFwbiD+cLkms2d?=
 =?us-ascii?Q?Q819y2i/4vtqXdnTOlfxhQ98ijqHNiNyI0xE2lxx0kq0DwBFRHoICbXs59Sn?=
 =?us-ascii?Q?/lKXPwSkxN6/69+cs3xaVwsaEuefXChuIiEhZVnU2USWzJ7UcDaoXbpIu3+u?=
 =?us-ascii?Q?KAaYN0BFIRzIEoyDZdk5ElTJbb7dgM9GH8gsFwWkbwaUQz1COlyZB9D0BbX2?=
 =?us-ascii?Q?dfkU6HD4ZUHK9GZYier4no/SPdhahrdMaxzAWxGOEq+yZI5tM33kyIMI1aoL?=
 =?us-ascii?Q?ExyNJLYIKYSTgKDjolJ2FRI9o7sDZ6JdZ2M5TbBfiXWEmD4hy8WwKd/aH2h4?=
 =?us-ascii?Q?5KAKFrSssFPQtUzpnsB4+CmAUH46OIsSLYBAccbh9sjtamwxtHdLtZmwfEHt?=
 =?us-ascii?Q?xEG71hUUoJTPknZwBQJx/oUmt9MjmFEu3OVDFYm+PiOJnTEbc26JewZmnTOI?=
 =?us-ascii?Q?c43aa6mECPwP5HK0sAypabVCFEPJ79SSaySeloENMS5fV0QrS8Bgv9x+kqXg?=
 =?us-ascii?Q?gUNUVJdYfdsQeb5Z/9XNhsrxUS+y39KcGdQ9XxH+WM+O/ravZJldlKwyK4zh?=
 =?us-ascii?Q?WpXn3yqNl2T63n5Kl+vPukj+kQElVnR0LQsi71bWLhIqMHM+bjMl235xWjww?=
 =?us-ascii?Q?HSSf2X/TXYe8KzIxvMIDbOI5wQtiuipy11F2CengxuR9Dus8SkKNZy/C6Kc3?=
 =?us-ascii?Q?AXxejmI8DkrlkDh7mv+2UEJZrJWgH0cllUzS6eAFm3UjEogoIayzjhPEz3PZ?=
 =?us-ascii?Q?JvWASPzstHmxTjcddQ6s9c8tzK3OAJyvfBfD0jBG1TRNwHWjGU2ZfZVsTW3d?=
 =?us-ascii?Q?ZaKyVME7hmDnDcJ9p7R32CeWBTcht+FHRpZScVXmrjS9FNks4k/V4XhOwu8C?=
 =?us-ascii?Q?+QuyhaQHqpY9HlouQjvgcTJy9wGAuX4kcAyFEfBKp8s8MjldmkCyK1PCqqzZ?=
 =?us-ascii?Q?Ocq8iNqJu+lxaV0d9KvfPNUlrcXYUsITMC5VBtHRGerfe/rKWwjTRHEnPYq7?=
 =?us-ascii?Q?cL5o2/hTICTjtKeLmQipsLww2aMi1Qy043zS67rX5I+TCfhRfisYM1gJMZ3v?=
 =?us-ascii?Q?NphXbPamy9Mg8UEjBt3OfXMtWcavNY2qPMH0Hs+WlZsW9IQnFVy4W6Gxffo5?=
 =?us-ascii?Q?6jVWlm/GxmISp5ptQwflja0ijwv4sxepK/yjXV4VPdxiRQ8Zv6KvL799JZPL?=
 =?us-ascii?Q?MvqPnbDVITdZO2MpPpjbkcNM/7W9U/iEe7Vk7YmK2dnuyAN8H+mEAMnXHQ0N?=
 =?us-ascii?Q?JOspYUWQCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504b5645-cd6f-4286-af3a-08def6f23d1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:15:40.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEKSSTZYmJ417z2x7Gxid5+RS4or2+sz3aRAUMMhbgdttDSEvaS0KxLd47D4mDhjRE6sdYK4aB9KO92vYoA49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

This series enables using proxy execution with sched_ext and is based on early
work by John Stultz [1].

Background
==========

Proxy execution (proxy-exec) lets a waiting task ("donor") donate its scheduling
context to a mutex owner, so the owner can run while the donor stays eligible on
the runqueue.

Currently, proxy-exec and sched_ext are mutually exclusive at build time: we
can't enable CONFIG_SCHED_PROXY_EXEC=y and CONFIG_SCHED_CLASS_EXT=y in the same
kernel.

This restriction can be problematic for Linux distributions and for anyone who
wants to ship one kernel and choose features at runtime.

Why are they mutually exclusive?
================================

sched_ext schedulers drive dispatch through their own interfaces. A proxy-exec
handoff can run a task that the BPF scheduler never dispatched through that
path. sched_ext callbacks then observe a "current" task that does not match what
the BPF side considers running, so kfuncs and helper state can see an
inconsistent view of the executing task.

sched_ext also tracks runnable work through Dispatch Queues (DSQs) and BPF
chosen dispatch rules, while the core scheduler still maintains classic per-CPU
runqueues and pick paths. A proxy handoff can therefore switch the CPU to a task
that the BPF scheduler never inserted or ordered through its DSQ interface.

DSQ state, vtime, and "who is running" bookkeeping inside the BPF program can
then disagree with what the core actually executes, so helpers and kfuncs that
assume their dispatched task is current may observe stale or inconsistent state.

Design: supporting proxy-exec with sched_ext
============================================

Provide proxy-exec in sched_ext as optional per-scheduler capability: a BPF
scheduler can set the ops flag SCX_OPS_ENQ_BLOCKED to keep mutex-blocked donors
runnable and receive them through ops.enqueue() with SCX_ENQ_BLOCKED set.

This flag requires an ops.enqueue() callback and gives BPF control over whether,
where, and in what order to dispatch each donor. The core then walks the
mutex-owner chain and, when needed, migrates the donor's scheduling context to
the owner's rq before executing the owner.

Without the SCX_OPS_ENQ_BLOCKED flag, mutex waiters block normally and do not
participate in proxy-exec while owned by that scheduler.

Once BPF dispatches a donor, proxy execution may move its scheduling context
to the mutex owner's rq. This move is distinct from BPF placement: wake_cpu
continues to identify the donor's callback CPU, while task_cpu() identifies the
proxy CPU. When the donor wakes, the normal wakeup path uses wake_cpu as
prev_cpu when returning the task to the BPF scheduler, which can then choose
its next placement normally.

The donor-to-owner handoff is modeled like a "function call" from the
scheduler's perspective. The donor remains the running scheduling entity
selected by BPF: its scheduling context, runtime and slice are consumed while
the core temporarily invokes the mutex owner's code to make the critical section
progress. It is not a scheduler-visible switch to the owner.

Accordingly, the donor remains the scheduling context presented to sched_ext,
while the mutex owner is treated solely as the execution context selected
internally by the core scheduler. Scheduling state is accounted against
rq->donor where appropriate, while rq->curr identifies the execution context.
The internal owner substitution does not generate synthetic sched_ext callbacks
for a task that BPF did not dispatch.

Scheduler-facing current-task kfuncs follow the same rule:
scx_bpf_task_running(), scx_bpf_cpu_curr() and scx_bpf_cid_curr() report the
donor selected by the scheduler rather than the mutex owner whose code happens
to execute on its behalf.

The sched_ext callback bookkeeping is adjusted accordingly. A blocked donor
enters a tracked ops.running()/ops.stopping() session only after proxy
resolution succeeds, and ops.stopping() is only called for tasks that entered
such a session. This state is independent of physical rq->curr execution,
which may refer to the mutex owner instead of the donor.

NOHZ CFS bandwidth checks also follow rq->donor rather than rq->curr and use
the number of queued FAIR tasks when deciding whether the tick can stop. This
keeps bandwidth enforcement active for a constrained FAIR donor even when its
proxy owner remains runnable in another scheduling class.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled, when a task moves between root and
sub-schedulers, or when a class transition moves it into or out of EXT. Start
every scheduling-class or BPF-scheduler ownership change from clean task state:
fully deactivate a retained donor before the transition and let the incoming
scheduler apply its own admission policy the next time the task blocks. This
conservative rule leaves retaining proxy state across compatible RT/DL PI
transitions as a future improvement.

Remote DSQ transfers recheck proxy-sensitive state after locking the source
runqueue. If a transfer races with proxy execution, the task is parked on the
source runqueue's reject DSQ and returned to its owning BPF scheduler after
proxy resolution settles. If an affinity migration is pending, the task remains
parked until the affinity machinery completes the operation. This preserves
scheduler placement and sub-scheduler capability rules without migrating an
active execution context.

scx_qmap has been modified with a -X option to enable queueing mutex-blocked
tasks for proxy-exec. Blocked donors receive a fresh slice, are inserted at the
head of their current cid's local DSQ and request immediate preemption. This is
an intentionally aggressive policy for making proxy-exec easy to observe.
With SCX_OPS_ALWAYS_ENQ_IMMED, a blocked donor which is returned through
ops.enqueue() with SCX_ENQ_REENQ falls back to the shared DSQ, avoiding a loop
which would repeatedly return it from the same local DSQ. A new statistic
reports blocked-donor dispatches.

A new kselftest (enq_blocked) is also introduced to validate proxy-exec with
sched_ext. The test creates a priority inversion with a low-priority owner
(nice +19), a high-priority donor (nice -20) and one nice 0 contender per
available CPU. It exercises a same-CPU topology and a cross-CPU topology, where
the donor and owner run on different CPUs. Each configuration runs with
SCX_OPS_ENQ_BLOCKED first disabled and then enabled, counts blocked-donor
enqueues by CPU and reports mutex hold/wait-time deltas. Access to the mutex is
provided by a loadable kernel module built via TEST_GEN_MODS_DIR, with the test
responsible for its lifecycle.

Example kselftest run:

===== START =====
TEST: enq_blocked
DESCRIPTION: Verify proxy donor admission under CPU-wide contention
OUTPUT:

[topology=same-cpu SCX_OPS_ENQ_BLOCKED=disabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=0
  nr_contenders=16
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=263587544 (263.587 ms, samples=10)
  mutex_wait_avg_ns=263597934 (263.597 ms, samples=10)
  nr_blocked_enqueues=0
  nr_blocked_enqueues_donor_cpu=0
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0
  nr_blocked_wakeups=0

[topology=same-cpu SCX_OPS_ENQ_BLOCKED=enabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=0
  nr_contenders=16
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=251789178 (251.789 ms, samples=10)
  mutex_wait_avg_ns=209808599 (209.808 ms, samples=10)
  nr_blocked_enqueues=50
  nr_blocked_enqueues_donor_cpu=50
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0
  nr_blocked_wakeups=0

[topology=same-cpu delta: enabled - disabled]
  mutex_hold_delta_ns=-11798366 (-4.48%)
  mutex_wait_delta_ns=-53789335 (-20.41%)

[topology=cross-cpu SCX_OPS_ENQ_BLOCKED=disabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=1
  nr_contenders=16
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=246794454 (246.794 ms, samples=10)
  mutex_wait_avg_ns=247298497 (247.298 ms, samples=10)
  nr_blocked_enqueues=0
  nr_blocked_enqueues_donor_cpu=0
  nr_blocked_enqueues_owner_cpu=0
  nr_blocked_enqueues_other_cpu=0
  nr_blocked_wakeups=0

[topology=cross-cpu SCX_OPS_ENQ_BLOCKED=enabled]
  proxy_exec=enabled
  donor_cpu=0
  owner_cpu=1
  nr_contenders=16
  measured_trials=10
  owner_nice=19
  donor_nice=-20
  contender_nice=0
  mutex_hold_avg_ns=215486809 (215.486 ms, samples=10)
  mutex_wait_avg_ns=215498090 (215.498 ms, samples=10)
  nr_blocked_enqueues=80
  nr_blocked_enqueues_donor_cpu=20
  nr_blocked_enqueues_owner_cpu=60
  nr_blocked_enqueues_other_cpu=0
  nr_blocked_wakeups=0

[topology=cross-cpu delta: enabled - disabled]
  mutex_hold_delta_ns=-31307645 (-12.69%)
  mutex_wait_delta_ns=-31800407 (-12.86%)
ok 1 enq_blocked #
=====  END  =====


=============================

RESULTS:

PASSED:  1
SKIPPED: 0
FAILED:  0

References
==========

[1] https://lore.kernel.org/all/20251206001451.1418225-1-jstultz@google.com

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec

Changes in v11:
 - End retained proxy execution before every scheduling-class or BPF-scheduler
   ownership change, passing the incoming class to sched_change_begin() and
   removing the prepare_switch() class callback (Tejun Heo)
 - Document the conservative class-transition rule and leave retaining proxy
   state across compatible RT/DL PI transitions for future work (Tejun Heo)
 - Split reject-DSQ code movement from its generalization and carry the
   re-enqueue reason directly in p->scx.flags (Tejun Heo)
 - Use one SCX_TASK_REENQ_PROXY reason for all proxy-raced remote transfers,
   clarify why proxy migration differs from BPF-directed migration and keep
   tasks parked while affinity migration is pending (Tejun Heo)
 - Factor local-DSQ diversion cleanup into a shared helper, clear HEAD, IMMED,
   PREEMPT and carried-slice state for proxy rejection (Tejun Heo)
 - Explain the scx_qmap SCX_OPS_ALWAYS_ENQ_IMMED re-enqueue fallback (Tejun Heo)
 - Rename the blocked-donor command-line option to -X, since -B is now taken for
   the rescue bandwidth setting
 - Drop the SCHED_FLAG_KEEP_PARAMS preparatory fix (this is addressed separately
   by https://lore.kernel.org/all/20260730135858.2460751-1-arighi@nvidia.com)
 - Link to v10: https://lore.kernel.org/all/20260728154425.1549660-1-arighi@nvidia.com/

Changes in v10:
 - Check constrained FAIR proxy donors before the RT fast paths in
   sched_can_stop_tick(), so a throttled RT owner cannot bypass bandwidth
   enforcement (sashiko)
 - Add a preparatory fix that sets DEQUEUE_CLASS only when
   SCHED_FLAG_KEEP_PARAMS permits the scheduling class to change, preventing
   class-transition callbacks from running without an actual transition
   (sashiko)
 - Update try_to_block_task() comment to describe the sched_ext blocked-donor
   admission check (sashiko)
 - Link to v9: https://lore.kernel.org/all/20260725160513.57477-1-arighi@nvidia.com/

Changes in v9:
 - Add an incoming-class prepare_switch() callback and use it to block retained
   donors before transitions into sched_ext (Tejun Heo)
 - Generalize the per-rq reject DSQ and use it for proxy-raced remote transfers
   instead of bouncing tasks to a global DSQ (Tejun Heo)
 - Restrict migration-disabled warning exception to blocked donors whose
   scheduling context was actually proxy-migrated (sashiko)
 - Keep ops.tick() and other donor accounting inside a tracked
   ops.running()/ops.stopping() session (sashiko)
 - Prevent BPF-directed migration of an active proxy donor and use the donor as
   the current scheduling context during restore (sashiko)
 - Update sched_fair_update_stop_tick() to use the number of queued FAIR tasks
   (sashiko)
 - Fold the temporary local-DSQ donor placement into the final BPF-controlled
   admission change
 - Link to v8: https://lore.kernel.org/all/20260721063242.552774-1-arighi@nvidia.com/

Changes in v8:
 - Rework remote-DSQ migration check so the locked re-check handles only
   proxy-exec state changes (Tejun Heo)
 - Use the current-donor helper when preventing migration of an active donor
   (sashiko)
 - Handle blocked-donor reactivation into scx schedulers without
   SCX_OPS_ENQ_BLOCKED (John Stultz)
 - Document sched_ext callback behavior under proxy execution (sashiko)
 - Avoid redispatching a rejected blocked donor to the same local DSQ in
   scx_qmap (sashiko)
 - Add a preparatory fix to avoid false migration warnings when proxy-exec moves
   a migration-disabled donor
 - Skip the enq_blocked kselftest when proxy execution is unavailable
 - Link to v7: https://lore.kernel.org/all/20260716132229.61603-1-arighi@nvidia.com/

Changes in v7:
 - Move the remote CPU check out of the lockless remote-DSQ scan and perform it
   only after locking the source rq, retain the locked migration recheck
   immediately before moving the task (sashiko)
 - Complete the scheduler-context conversion from rq->curr to rq->donor for
   capability revocation and preemption checks, make scx_bpf_task_running(),
   scx_bpf_cpu_curr() and scx_bpf_cid_curr() expose the donor selected by the
   scheduler (sashiko)
 - Handle SCX_ENQ_REENQ before scx_qmap's blocked-donor fast path to avoid an
   infinite reject/re-enqueue loop (sashiko)
 - Add scx_qmap stat for SCX_ENQ_BLOCKED dispatches
 - Link to v6: https://lore.kernel.org/all/20260715205622.276220-1-arighi@nvidia.com/

Changes in v6:
 - Add a scheduler-core fix to make NOHZ CFS bandwidth checks follow the proxy
   donor instead of the physical execution context (sashiko)
 - Block retained donors when entering sched_ext through PI de-boosting or
   global scheduler activation (sashiko)
 - Distinguish ordinary wakeup activations from retained-donor admissions so
   SCX_ENQ_BLOCKED is not reported for normal wakeups; extend the selftest to
   detect this regression (sashiko)
 - Validate unexpected-CPU blocked-donor enqueues in both same-CPU and
   cross-CPU test topologies (sashiko)
 - Link to v5: https://lore.kernel.org/all/20260713162112.26785-1-arighi@nvidia.com/

Changes in v5:
 - Split retained-donor deactivation and sched_ext's default rejection into
   preparatory patches so the scheduler-core changes can be routed separately
 - Drop the proxy destination query kfuncs and the preparatory mutex lock-scope
   change (John Stultz)
 - Use p->is_blocked instead of task_is_blocked() to fix a WARN triggered during
   scx_pair testing (John Stultz)
 - Rename SCX_TASK_IS_RUNNING to SCX_TASK_RUN_TRACKED and document that it
   tracks an ops.running()/stopping() session rather than physical rq->curr
   execution
 - Keep a proxy-migrated blocked donor on the owner's rq until wakeup instead of
   allowing BPF-directed migration to pull it back to wake_cpu and cause
   repeated donor migration
 - Extend kselftest to cover same-CPU and cross-CPU proxy-exec switches
 - Make scx_qmap insert blocked donors at the head of their current cid's local
   DSQ and request immediate preemption
 - Link to v4: https://lore.kernel.org/all/20260710083913.30573-1-arighi@nvidia.com/

Changes in v4:
 - Harden scx_bpf_task_proxy_cpu() locking and blocked-state validation, return
   -ENOENT for unrunnable owners and drop unnecessary donor-affinity checks
   (K Prateek Nayak, sashiko)
 - Reschedule remote CPUs after donor deactivation, handle sched_setscheduler()
   admission and assert scheduler-change locking (sashiko)
 - Avoid a potential KCSAN data-race report in the lockless blocked-donor
   migration check by using rcu_access_pointer() for rq->donor (sashiko)
 - Fix tick dependency updates for incoming EXT contexts and keep the tick
   enabled for blocked donors (sashiko)
 - Dump EXT donors in scx_dump_state() (sashiko)
 - Reordered the preparatory sched_ext changes so real running-state tracking
   is established before donor-based accounting, and split the proxy
   destination query kfuncs into a separate patch
 - Add compatibility wrappers for the proxy CPU/cid kfuncs and document their
   results as scheduling hints
 - Link to v3: https://lore.kernel.org/all/20260706070410.282826-1-arighi@nvidia.com/

Changes in v3:
 - Dropped the core restrictions on proxy-migrating migration-disabled and
   single-CPU donors: proxy execution moves the scheduling context, not the
   task's execution context. (Peter Zijlstra, K Prateek Nayak)
 - Dropped the sched_ext-specific put_prev_task()/set_next_task() exception and
   fixed ops.running()/ops.stopping() pairing inside sched_ext instead; track a
   real running transition even when either callback is absent. (Peter Zijlstra)
 - Dropped the kf_tasks[] nesting and nested ops.runnable() patches from v2;
   extensive proxy-exec testing did not reproduce task-op re-entry, so retain
   the existing non-nesting invariant.
 - Replaced scx_bpf_task_is_blocked() with SCX_ENQ_BLOCKED in ops.enqueue()
   flags, identifying blocked-donor admission directly at enqueue time.
 - Expanded the curr/donor description to cover mixed scheduling classes and
   fixed local preemption to expire rq->donor's slice. (Aiqun Maria Yu)
 - Allow inactive blocked donors to be placed on a remote local DSQ while
   preventing normal migration of an active rq donor. (Aiqun Maria Yu)
 - Deactivate retained donors when ownership changes to a root or sub-scheduler
   without SCX_OPS_ENQ_BLOCKED, and extend the selftest to cover attaching a
   scheduler after the donor blocks. (K Prateek Nayak)
 - Harden remote DSQ consumption by rejecting active tasks and rechecking
   migration eligibility after locking the source rq. Fall back to the global
   DSQ without treating an eligibility change during the lock handoff as a BPF
   scheduler error.
 - scx_qmap has a command line option (-B) to enable blocked-donor queueing
 - Link to v2: https://lore.kernel.org/all/20260702171909.1994478-1-arighi@nvidia.com/

Changes in v2:
 - Rebased onto sched_ext/for-7.3 and adapted the series to the split
   sched_ext implementation and cid-form scheduler interfaces.
 - Replaced the global sched_proxy_exec_scx boot-time opt-in with the
   per-scheduler SCX_OPS_ENQ_BLOCKED capability, allowing BPF to control donor
   admission and ordering through ops.enqueue().
 - Added scx_bpf_task_is_blocked(), scx_bpf_task_proxy_cpu(), and
   scx_bpf_task_proxy_cid(); enforce CPU/cid API separation for cid-form
   schedulers.
 - Added proxy exec support to scx_qmap, including optional owner-cid steering,
   affinity validation, and fallback to the donor's current cid.
 - Added a kselftest with a kernel mutex test and a three-task priority
   inversion workload, test is executed with blocked task admission disabled and
   enabled, validates the behavior, and reports hold/wait-time deltas.
 - Link to v1: https://lore.kernel.org/all/20260506174639.535232-1-arighi@nvidia.com/

Andrea Righi (15):
      sched: Make NOHZ CFS bandwidth checks follow proxy donor
      sched/core: Avoid false migration warning for proxy donors
      sched: Pass next class to sched_change_begin()
      sched: Add helper to block retained proxy donors
      sched: Add sched_ext hooks for proxy execution
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Move reject DSQ draining into core
      sched_ext: Generalize the reject DSQ reenqueue path
      sched_ext: Handle proxy-exec races in remote DSQ transfers
      sched_ext: Split curr|donor references properly
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

 Documentation/scheduler/sched-ext.rst              |   6 +
 include/linux/sched/ext.h                          |   4 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  95 ++-
 kernel/sched/ext/ext.c                             | 536 ++++++++++--
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  37 +-
 kernel/sched/ext/sub.c                             |  64 +-
 kernel/sched/ext/sub.h                             |  13 +-
 kernel/sched/fair.c                                |  12 +-
 kernel/sched/sched.h                               |  18 +-
 kernel/sched/syscalls.c                            |   4 +-
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   2 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  37 +
 tools/sched_ext/scx_qmap.c                         |  13 +-
 tools/sched_ext/scx_qmap.h                         |   1 +
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 116 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 917 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  28 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 195 +++++
 27 files changed, 1940 insertions(+), 192 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
