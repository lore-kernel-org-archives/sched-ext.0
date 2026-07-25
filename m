Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F430D414
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995538; cv=fail; b=g5fOmiqSR/zLFZFKjdgX6B1lTfwzDGMn8iJ7e6FicgcgoKUBUIkkd2INoc2uu2RwiqoPaj56cnpAvzRJi4ww3xb8BFZpnvAm1CbwqwfLLQANWolvGoorOl7w7YHNukuaIuyoK56egjC1Tj/LxG6SkkIe5HfLZHl6e4fdYv0hhhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995538; c=relaxed/simple;
	bh=9xnH9ZN4ZeqBdtBXq62MilWQhbpaF/I3XFAqcZr+bKI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k0fJjkK7AtUjDjAkGRRjFNgQ077JtfjVXsz56gdw1fz6xkeMBp6wyzaFqcvBZ4heEZLDQCyyldc6iH3v6ZRkHwEY4bLzjenD7gatAumwZYvDV6+2z6Rf0x5N2MSuFjMpboWScL9eoV2qemrx5KgnJaPYb2V6TFuqpPOXPJ5gjkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgxiApxs; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgxiApxs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSgaQd/HuLKeB3cZUy5EO77QDjmt3gvO8R3wEfFRhcSnO9FpX9j3F7mNOGgw0JIFaLY18TgFzg/8JmqfXxNKZfcsaU+ZTRKka6ta7Dnas5nDZLrZXywNcYPpnOoUMw3jUxy42BDMNcGKcSQOddZFgqI0x2Vgt+Bvb7cKxk7F35qGg7xq3TpQvY2NrG+Rgc/7L5eliuHCerJiXHX1D7XlErrSwkKZM1v/3S7KdpFV40dWFQOs40pOG53N0CzUE7oCW4du/oL9lTzDIvzh6AqLJWczxvaPqlLh5XCp/eSwazRtP/sQP5BO2e0Ldz9prnx+dp/t14IJPcP4tyNLZL62bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPnxAVd7Iexb0dQd8WRZuqb/fCHfIe/7xjKaesssnqQ=;
 b=eRY2RW0aETNqRT9DJb8b9G0k4sDZXu7/AJO6cYRok7wMp1MvMOUkilA1s/r9RIUf3rVnNB8u0Cyt+7MUKSmYm1Y/C2UJBDWDlJCcaqIr7IMLg/mDlX7FS8TGFawac27Zed3SqJ40uehcN/e4YgQZndUAAVQCQrzizgcNPJwxenyTAgZZSehHy55OH+QTWxvpI44kJoRhwSMceo0jgHZPE0gViL088cn3u9ysrn4849ad/xL2CJ7NhxhbNl/3V0L++6HPnH8k1aJiQzcloz/IIxnGV2dcMS7IDnoxxxKLc0WzxqSyPVdwZNkZVoq1sy2cPBNXHa+T1B+yIBWrwaHX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPnxAVd7Iexb0dQd8WRZuqb/fCHfIe/7xjKaesssnqQ=;
 b=AgxiApxsqlNUb6RB6jotYHIJEcwS7ah/BGCj90lFEHAmYf22XJCCyn4xWoiiGh9JekThqWdlckGG1R0p4Ej8/dd2+9DpDuI5SncvOkJGm8JhU+AdmhzitbG47f+X9fxnd7+S6rOsEVYKo+S22jjrXxPq7q2A+I798RY8yd/uA1SYtuBNA6bCWe2Y7qnkmO1vy1EShwBUSYNLsqDlxoS2NVcySNE8P+nmH7a1bicHrxn7rEFEdOlpeT0/rSFF27Y608FVF/8CN59ELyASprLvHr/ESo+i9767sHKz3H9KwPdq95HauXGwy9SdCG6ZThdm94G1y1i7kxDamILDwER3mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:29 +0000
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
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v9 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Sat, 25 Jul 2026 18:04:06 +0200
Message-ID: <20260725160513.57477-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4f1dcb-1766-48b0-4177-08deea668b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|5023799004|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	lja7KUbqHY0X4db0JSaIPQIz/OxtijPgqOD+mo57/5aF41UrqJ4j4DJhYl4AKH6Ng2Z9SZhTFF5WWdUvJFxnXhOJaA9RF+pNph2I6YNw6jcaY9rKul1eRdikAIKvPEVAaclIdyZGt9n1NPMu+fMsJUncTZpK/R56OOOHTjcZnYuGcF4VVbDC/OlzwV7gbJJWKlloSzb3RCFbvl48v9kJcKNs4YPBhLFE72+pMju/TLlkxvUd6u/xNLL2QoPFXv+vWmDK+o+DU2Yshm25HvpqgTRslUHDEKaUrODyt6ErrDRHXU7dil0tetq00K+37NkulMhBePzj9I3zLpJAsVd/60BGOEqfdaZ/8eRbtNpGmI2AuGcZaMUykm8uVswe21ot/O3I1d/K8d3TbJ2yxtgUtdQ3UHvX/TYetTEkOuAyxJ/+BvBCRG2rLCwpfrnT0z41p2jtKfLoVyWtZ72RxkdPI6XHrNgLA3UerPi4LU2n948zj8iy1pznaQvDAC+W6UpDfcBBZd9hkYCCSQA+3z0CrBTXRZreh6RwPiAoO3I49bwcIgcpfTE10LZCX96x9j/iiHLaD2fGLm2IlvID91dgxu/04APSetXPEjslo3uXnvEUb+0mogmPM8qDJaGiwyTNE3zgVZ4evFC447fpFKnX0qhFMCK9EX2cfb0aDItn0yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8JYzk56ovm1mnC+xKFQXyOmr+Da3LOm6DWZ8CnwrHmBqw/rIPQAqpwFPiRO?=
 =?us-ascii?Q?1WzSVliXbdIOvO0822BMZ82iHZH5sOpWIHpdRNuMbLCTC0KmArSODUkF7B51?=
 =?us-ascii?Q?XphPLuPsOm/rigknCMUVUXij3HDDFEA/QzseecqdLvt9KnOJkfJfQCG9bnOy?=
 =?us-ascii?Q?5WoaX2YyyFzWeo24PjTn3h1aVTWH7GfJ6L9cu6AzmprZRdPzqOHNYCg3Y4dp?=
 =?us-ascii?Q?XdcANLnG1LMRde0k+yrC58zVmg4aldanPEHUsCy75C0/P6NtJ22KG0wthlpP?=
 =?us-ascii?Q?BN0TwoqFXq/EdRvbPwA1+Ulaq324P1UiQRyUcTAgBOywZmKIZmiNp5cIWW+l?=
 =?us-ascii?Q?JezGUXzONj8Kp15iZpi2Ro6mfXKsnSQ09HtXB0aOZ0u6aGiYWd2wCAqwtks+?=
 =?us-ascii?Q?OPkbFRnqepg5eSTLbhl7i5GIXepbLNfBhOO+hAedt2n6jS65nhQM1B+OXGeA?=
 =?us-ascii?Q?G05OQQwTQ8wCRoXExQNzXQ2IiIgA9qdgt38GPZ6z8Ph+bFZow2C+wC9TKpHz?=
 =?us-ascii?Q?WN1Q6jjrH5sgddzp3rSuJ5SjyD1wpVb+EnPWvwyaLsoD07eIWHtLX3EeL69t?=
 =?us-ascii?Q?IjUuU8Cab3KFicyqsn6QvT0EYI4MnpauWJvraVDfDbpHVC+rM0yd96T/t7qw?=
 =?us-ascii?Q?9Tj0rnhJV94w4+CQWaCHEI62oOPyRwDIwy/6vF6UKcr2E73hsDKfrgVu9tDz?=
 =?us-ascii?Q?Pg4W4GLaBuFgUvM96sMfl1gpOw8xE8e8kSXOQws7hEFzibyNwv7J+KTX/Cxz?=
 =?us-ascii?Q?hEPJmcHKQTEU7Ss+cgNgB1MlJtkw/xpEHU48LSyrX8hapWgmTObhdGeAs9Rq?=
 =?us-ascii?Q?XwVqIyYTs6aC+mQ/yaqHEhsUw1rr6NMohYns46UJewcZtSK790J5CP2Y2VkZ?=
 =?us-ascii?Q?fUbekrd8N1CYFMj8z77i2P9QfdY+YgSSuFA8M56FMZaaVGs1F4HpsVXQ0KxR?=
 =?us-ascii?Q?phDyE2ZYu7NagxauUQuYLQCk6rEsmDKAx7PIZsS5s+LdZG+HoqyuIeCrcGV7?=
 =?us-ascii?Q?vBEOiPUGlUXRUJRctOilNraWfJaGUp8H/5yn8VRuJA/KwT4OGAIhM7L4BT6Y?=
 =?us-ascii?Q?hTYxhG0fF+deDZvrQ9fuFR/DhWYqx6rRneygQPJMtySJhWl9DrsFSwWZ2CE/?=
 =?us-ascii?Q?mI/7WpMql2ea2TVanfveOlcNqtTZkP8S5TDbnqFrAr4ftfcfMS2240pNoGaI?=
 =?us-ascii?Q?C3YIoYkdgPPpRLftrlXZRBdBZse33eYrE9NBco38uWWZxPG2NjKrlShPnCuL?=
 =?us-ascii?Q?mDRJoPacwcA746FYJGxSWNxeIzEo5pl5RPF7TlPBC4zuxjceFefnhldVe9PO?=
 =?us-ascii?Q?rkzV/rP0M8WzvoeFRV5khsp7xdbIcRDgUqZd+exg/8eXO770ib+UgfC8Iic0?=
 =?us-ascii?Q?V9bSQP8w4ulyunJvXPwQ4PhABgDq2vsD4ixKs9cmF6uwwyNwRpw6h9WrBf2T?=
 =?us-ascii?Q?6zKjMScSjdiNqLwK21SeKa4tye24a9a3Jh7Ib3vPmaadK2/jAaC7e9L8CTcS?=
 =?us-ascii?Q?FdiA1gTDG15wlIXeDR6w6fWf1KkvCJ+SWge1INWif7FmSbPffNEKF/q1hpH6?=
 =?us-ascii?Q?gsuOx2zTR6y5RCwKAtH0Iq/AYU30xiFD/KOw4sdKB+IgkuSdt6rSMWRBiKrZ?=
 =?us-ascii?Q?J0kraIb0+ZLl9wHF9fJdufJ/u+bfMk4ZmqCLI/lJbbfpBfa2OW/LXNYAkyjm?=
 =?us-ascii?Q?WGdQ6d+ohd6j/ihsNi+oa0ckQ2gge5Iav3clfzPBc02QFlzebdoSl3BsfMfq?=
 =?us-ascii?Q?4ZCSDxPfSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4f1dcb-1766-48b0-4177-08deea668b40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:29.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6cVCn0XjCMuhMPchXE5gfGopMFok0ctpYLYs8lhGmPKQAwDDJaEmS2OMgSrLfGtvvEDKzfOT/FM1VbKvyCPDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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
sub-schedulers, or when PI de-boosting moves it into EXT. If the incoming
scheduler does not set SCX_OPS_ENQ_BLOCKED, the retained donor is removed from
the runqueue and stays on the normal mutex wait path. Otherwise it remains
eligible for BPF admission.

Remote DSQ transfers recheck proxy-sensitive state after locking the source
runqueue. If a transfer races with proxy execution, the task is parked on the
source runqueue's reject DSQ and returned to its owning BPF scheduler after
proxy resolution settles. This preserves scheduler placement and sub-scheduler
capability rules without migrating an active execution context.

scx_qmap has been modified with a -B option to enable queueing mutex-blocked
tasks for proxy-exec. Blocked donors receive a fresh slice, are inserted at the
head of their current cid's local DSQ and request immediate preemption. This is
an intentionally aggressive policy for making proxy-exec easy to observe.
Capability-rejection re-enqueues bypass this blocked-donor fast path and fall
back to the shared DSQ, avoiding repeated rejection on a cid that no longer has
the required capability. A new statistic reports blocked-donor dispatches.

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
  nr_blocked_enqueues=60
  nr_blocked_enqueues_donor_cpu=60
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

Andrea Righi (14):
      sched/core: Avoid false migration warning for proxy donors
      sched: Make NOHZ CFS bandwidth checks follow proxy donor
      sched: Add helper to block retained proxy donors
      sched: Add prepare_switch() class callback
      sched: Add sched_ext hooks for proxy execution
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Generalize the reject DSQ reenqueue path
      sched_ext: Handle proxy-exec races in remote DSQ transfers
      sched_ext: Split curr|donor references properly
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

 Documentation/scheduler/sched-ext.rst              |   6 +
 include/linux/sched/ext.h                          |   8 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  76 +-
 kernel/sched/ext/ext.c                             | 550 ++++++++++--
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  29 +-
 kernel/sched/ext/sub.c                             |  58 +-
 kernel/sched/ext/sub.h                             |  10 +-
 kernel/sched/fair.c                                |  12 +-
 kernel/sched/sched.h                               |  21 +-
 kernel/sched/syscalls.c                            |   4 +-
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  34 +
 tools/sched_ext/scx_qmap.c                         |  13 +-
 tools/sched_ext/scx_qmap.h                         |   1 +
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 116 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 918 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  28 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 195 +++++
 27 files changed, 1939 insertions(+), 175 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
