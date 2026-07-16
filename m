Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200F423E94
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208172; cv=fail; b=jwW4+eQfe9IoL7VS+lMsW2lkXdjSbFdl+Ku0ZFWqKVF7k7xSlqHp5nfi30k7L6QgyXXVDyJTr8dK+iZief5EGMF3pHRS7gKtksp8AJ0Lt25ElJwhMTKeUBprpk+w7PDcXyTjDDFSKFvT10tHU0McWr0/IaKsbd06lDfCpNi7xrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208172; c=relaxed/simple;
	bh=q0cMDdETtUYzg0qOgboF/JG1DMsP0v3hWLKpJ/g/S50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JPeizkwrH32bqW/iyMiL89/4fVOKD/R5vlKQAR67DwIXOimUuRr0nd5qv+569iiOmWNDEdsw2lrCa+WzcLFg++kAV9zcKl4LZvUgi8GeXVuSN9xeHqhV6J2DzosBRfYg5U3nQpGdxMTn5FUHkddOcKEETCBMtt/DYN3algX5Gss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjFnAr3y; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjFnAr3y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH3kJgdriXkqUT8ITW+hPpraDw0PjAeq6LUAfMuuTobEkm01yl/9SEF0PnvDMqOepzCGG9hQnE5DSVPbt6YSDiQI1QuS232ngcu5p9cFtEq/gjAPTjF2XcbHUE+tIvJ+I6rrolQVuAKU7hQNULRgjhjwv6gxLMElJGmGg66McbsuuI3gHALVYbFFvvN9fwkv92RF36dbiDtZxHNyl1XbXbKlybE7TBBjk2lDHUiHeB3NXJ9/jFyfhkLdKlpXFGL7ZE5e2GP7SJt07VHIj2bqDp1vQoMmbbEYhJm1AQ1XH/n34RWFgRKvtnTwcYsvGtYYXkC43gW91U/6mlCE+wEk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrzO4NaGNATp2/BwRVIQxM2qXIWQqbmLGWpDpfn3cCQ=;
 b=pOqm48LcCn1+XD7eEq92FhHQzeLXMReTYmCP4q/Nec9mWveB5edKO7gMQdtO7kkMLe+KFDfoEbXnbDoKjpvx+vpJPjMLsIhaP4HdsMdDvVBv2NX/f1qcoOBJZS2GfnFZEtjw/qi03k+V2z5oiJaraNMW75wlCaz8sand+f9mhbZ0s/JxxqOMmnw6FWp2glJ7L9udr4bypYgs5iv9iip5LjQB1Z5vxu89ef2lpeyrtMvz4X2H2LuodQgKvpg5agwJojfZQGxfzsnAwJNdbiU4beO6RlK19U45KHP0uxJ9CYbw3QVax8qtdmqh3CHURWpVZSPPbxGUBdrEowRRbRxcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrzO4NaGNATp2/BwRVIQxM2qXIWQqbmLGWpDpfn3cCQ=;
 b=YjFnAr3yyC+Wi2Z3TEvAtptZckPuzpS+BRCuOald8RPQETzTzGGemDDn7gxucTmxUkHkV5qYjOKYWdlVjxou1pS01wB1qLKvGDykoMaGzIkH85l9JgwcrOxoohsUPNwHDPY/IWKnFv8u1brSWVn+JVRwClcAJgilwetIRqCnIREca58QaQowFzJIHX66x2pcL/DCr71gbwPPfe3Sl5zCq4G0tpoVIky+OW4Wd3TEY8HfpxofHghy3ivAzagJxyIslVJaDqMcptjkZvMZVGbkgLxaKCEOU08E9xJKeq4wjdlsMGNt7O7NuUdMxN/AI2eNxdsSX8BhswOhvb7G6CP7DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:22:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:22:40 +0000
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
Subject: [PATCHSET v7 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Thu, 16 Jul 2026 15:20:35 +0200
Message-ID: <20260716132229.61603-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EAA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: b60d484a-b4c2-4e1a-4b75-08dee33d4fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|10067099003|11063799006|6133799003|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XhWm9gOPMEz9OFCBCO3nY5McaNGBgymNCQsLgYILlq3+bXvKIX+h3WET7Y3I4CHfM5bYgynlYgUVWVZM8Su7tHrfUyUhF4pC3ol+aUSch28i/DjWnL8EYYeuZe2jNxl8s+/P5Gv98c+534VwURT5saLNh8ugV1TXCn1aBV1nO/mvskLEOIoZnpJc6oOB9/t6SLMlC6DwAc5jdFp6o6loByc1Nk0O76fgwt6ndnNYxc8VfpaFFMPEM1x56aprHBTBm62JLEt+/yr3jsyhty+lkmepKL3zw04jkbc9bZUXY/x1LbOMcZSlN4uORYYsNhWxmQai7yS8ZlHRWSPZbcHnL+zqOFfBFMHEmf5uebCexDysEy3FIsdBnX3yPgM/htyX+3aEufbntLVmzy9cAtZKVxm0Cm9nZFeOTihbLOev/4uHvwZEuqGGLzVRL5ljFsCOW3gJZ7eRbQ/dUb1BC43+309Fn+AV7p0kJhBDVjRapSs0E/R6ApvzxG+JzNGRUOicIxHgF4/I608k3a95PA1sWKRngw10+IoY/L5S7qALIyNITb/3rIuvLK1j+Jp8LlRuVCnXyZhT+atQVhi1jvGq2G+E6Me8uvEx+wRbRZ+qV8nGMcF4j+L7mYEfYprAokKRo5f7blhhXy4ikVVDdEzelZT3hMDR0CdqNcrhpA+YThw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(10067099003)(11063799006)(6133799003)(5023799004)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vTb5WkrgKZVbhSirEDWOpHKrDpgO95qEK62AVo8YfU2R8cH6oBTQCEqX+1E?=
 =?us-ascii?Q?WA6LcCZqSCKJZ/+2X2d44JN3xLTG3ZozGgkLNTqUDSMt6r3oox+R5MaWCEYF?=
 =?us-ascii?Q?0tTTvZLmq/0MxWHF7JvijaDjGL1zxncKSxLTcxU3m7lIU4n0sA1aDXP4sUES?=
 =?us-ascii?Q?yFdh6EmDJHFRg0TN/9JCjeQedTc8uGOPu7kJ9/ctYUsjF/7lc5a20HeCS7L3?=
 =?us-ascii?Q?6StsDGBcOrOsfWLTVZyQLqebK7yS9h9WCCfmrkICsVK+NCR5PfhRggTbGrIa?=
 =?us-ascii?Q?47Rt+PHbO0r+o/InJRWDwVz/Q3x6c8r5D8vC8FUIdT2nahYGuseMnOtYnuA8?=
 =?us-ascii?Q?mwNmz1xwV2mdENex681v+RQ1xP1UITnKFuvJueIBs8BDrrU4RouNTH2W7x8L?=
 =?us-ascii?Q?reY0xBCPpWDgXbxrxhR6AkMH4/vukEpB2IR9Qi+eecDoQBOZirQX6UvvkqpN?=
 =?us-ascii?Q?WiF2A1onRGaMQNh9WwgJ7Fr3efSQCiavdIwrRZoTF8dfzJQHTu5wMm3Lk95H?=
 =?us-ascii?Q?Vu6WBLxP3kGvi0MSxXT03Zh+ICz7olcu9cJ8AUnDmeiMCPxohQFVQ2WNiWmL?=
 =?us-ascii?Q?lrt83WoixV/CgP2tiCSvUBNwT7Dwc2PulnafC2j31dw+lhEQHe80T8KkqnUO?=
 =?us-ascii?Q?NKUaWtXNj1rH6FIvB4f410CHeE0sVyuIraTNz1ZBJfM3qEGLsWPiqy5lOJBE?=
 =?us-ascii?Q?rvyd4wXQJN8M9xekIFviRjAR4f+0pvV5CXT7ySWqu4XX+e4dHUjvSpGETXjb?=
 =?us-ascii?Q?iJj6tZtS866R0qS/mAz1u/kqEXnyQirutFTK4BWuev5jw/Alavo+ypb8YvST?=
 =?us-ascii?Q?l+y+aYKWaZM0qwg7sg+6feGQfm0d3JT0nYeMFV7tj6b576XCtrrRWcCyes3V?=
 =?us-ascii?Q?fWCPY7Ug3O74a1fPpazTdt5ws24dyPE200PFP5E872n0zoYFnHQiwpuYuqq/?=
 =?us-ascii?Q?kBVYhANq4vuVoW+Mhk4yT2Zbgz1hlY8IMSCdpEjBONI7GTbfVdl5znlpfmv0?=
 =?us-ascii?Q?0FbDv1iB17Flj8sUTg+8DaiGmuds9e5vC/dg552O4sCQqypxreuaH3QT0IQz?=
 =?us-ascii?Q?WdGPOfepoErgFn0r9AidqrxPWCY3vK6dNU3me6gEJZoF1ohZVrp1mQnqLdBE?=
 =?us-ascii?Q?U8sU5hQIxvQIcWLHe/JRbUnfGD1noeOqnSpiYrUjHeHpXKcdrBE00BhQ/OLF?=
 =?us-ascii?Q?QYx8T8b0nsthoCf01RqecZmF4zEkaOaJL04sPIci60VmYdNUgTIUFCwehvOh?=
 =?us-ascii?Q?zIQe5sZx3PZgKSNP8UAl/adhgpHGPZrYn37b/rxRfNjL/XL17wrKAzj7psAX?=
 =?us-ascii?Q?POTS+nqJu/l2t1HJQV9YnZ1r09DSjVb577DF6zOGj3epZDqjMj11ohpJMY8v?=
 =?us-ascii?Q?toz7wny1oKmV7BcOaXrZdb72ArKU7we3TEU7ONB7WtCZ9vIftweQqIJTtpRr?=
 =?us-ascii?Q?LWwnFacM5CSHgib+x+ypb+lxZzCpRsmYMOUhlwUnlnqRHlIvnz3H2cSOxzQB?=
 =?us-ascii?Q?hfqh8Dy7ZtLhjAkaTkv1RK6vYvu5XrZxSynsdNkgAdZixkAeipGC6sLBWK0e?=
 =?us-ascii?Q?mBy7GBu6s9j00vpns1A7SesVFJr2xENAWyxf3trb9P1O8jxRyTxl1IOdVgrs?=
 =?us-ascii?Q?4QOm2x7v+9tgET5C/RAzgVvWnINAJx5w7wzd4lPieny4xFqkQ7Sc4YUoZRNf?=
 =?us-ascii?Q?bDt19uziVNVBS2IT8jAY85pAZA+f3MS3n6hNgoRhWmRFnCzwPK5kpnhh9IEa?=
 =?us-ascii?Q?VIQdjm+3SQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60d484a-b4c2-4e1a-4b75-08dee33d4fa7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:22:40.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR2q/L41CzvIIfcj/YDZlbcIUgGSBVW6S7zaJ5u+ZE2aPiJnXMKdEgbSilKjlhkB37dU/o6h2TB5BPlGkM7yDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

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

The sched_ext callback bookkeeping is adjusted accordingly. Blocked proxy
donors do not generate spurious ops.running() callbacks and ops.stopping() is
only called for tasks that entered a tracked ops.running()/stopping() session.
This state is independent of physical rq->curr execution, which may refer to
the mutex owner instead of the donor.

NOHZ CFS bandwidth checks also follow rq->donor rather than rq->curr, so a
bandwidth-constrained FAIR donor keeps the tick running while an owner executes
on its behalf.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled, when a task moves between root and
sub-schedulers, or when PI de-boosting moves it into EXT. If the incoming
scheduler does not set SCX_OPS_ENQ_BLOCKED, the retained donor is removed from
the runqueue and stays on the normal mutex wait path. Otherwise it remains
eligible for BPF admission.

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

Andrea Righi (10):
      sched: Make NOHZ CFS bandwidth checks follow proxy donor
      sched: Add helper to block retained proxy donors
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Split curr|donor references properly
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (1):
      sched_ext: Handle blocked donor migration with proxy execution

 include/linux/sched/ext.h                          |   3 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  62 +-
 kernel/sched/ext/ext.c                             | 327 ++++++--
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  23 +-
 kernel/sched/ext/sub.c                             |  12 +-
 kernel/sched/ext/sub.h                             |   8 +-
 kernel/sched/sched.h                               |   6 +
 kernel/sched/syscalls.c                            |   3 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  52 +-
 tools/sched_ext/scx_qmap.c                         |  13 +-
 tools/sched_ext/scx_qmap.h                         |   1 +
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 116 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 908 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  27 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 193 +++++
 25 files changed, 1692 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
