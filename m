Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28A417D86
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615588; cv=fail; b=aLt67+DnW1/PJxmgKAil9xR3GBM7aydb9z2Y2hE2Cp0yyrMOFdBkuJCN84emLwGD4pPieFFgChA4uFM3825/hR+fmIB+VXroyfHyZsU7UMzgtT84EJD7AqzlQnFi3GazzbCWo8fdmhRmkTtWnm42j2/3fFzJOFjpdnS+1BwSDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615588; c=relaxed/simple;
	bh=jPtLkNMg3ueVG9cYSgeoD3l4nJqMrnB8fZ1VuMyHAl4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fk2Hjt2RLg1C9R74tuqx4bnToC0UOgV26nume+2MDhDPfUBB4yRdzhWU1IrnDrdPCKYUZYubLoBahwhnUXcaDw4lW6qIgYK6LvAt1/awToxf2wikBYdQftfXl2WQuKIaxkmx5pM20DbKlmSV7AoalwLWujx7FP/QJkbwQeUUQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i7CMFe+Y; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i7CMFe+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNqNf1rc4VY8P5SHo/vDNaGPrqKBGoHQNvjno+kaWEk/dlaaJ/R+xngaLnNedjo0JrGBLX+eTLhIgaeCJhmNt0Jtx9XydqRojxOw4+N3jmIWorLBI25UcaA45RGzxwuQgIGZIufvLTHneapnv8Ew0N4XLR3I5KHyiG8gkMr38N/2ISj+oBK1jEbGxwI+TvQM2C/Z9L/K0Z6CvtpvTcDcmxM9PhlVgWY9KGdou2osdkmEiQArJQQuQno+3xXRAj7A7grBiZfM7gbeoFdHKxNcQapJCr8tYYnN93h5H0FyIuAflIV0wmeQecZWpdGWlty+ua4/AmSTj9iwTzk1n2kWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QvrS2J5uxVa7T2F7r+eyrt2T5BzlHhEqnCU9waAJLc=;
 b=oGFZkwegeu5B83JN138x56Jv61b0sGFghyipJDl5nl2uuo1mt/O+xQMsKXVfDXx7fPNh8gqULrerN+8Rw7YeEGPD7oCHVnr+cU1U9Y0844vWS3GZCKIBUPKd+Tqvy6G2qiWQAe/19hSctAoEGgXIC8PyIkBKsdoZOQm/WMdYjaLuyaHSBKHeH5nrChy8GuUVwZAlGpnQZAULlcrBJzNsV4g7s+8kbUqXJ12HzuL3iCasvloDjvqFBwTR11yQg+LFrCAOeM1Kfpw5Eh+531Wr4SQdoEcPN01nsCDnV4rUAzN78rwB6a0mH9qp/r3RLCUvESYZfCf5pxqBfSCZraIkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QvrS2J5uxVa7T2F7r+eyrt2T5BzlHhEqnCU9waAJLc=;
 b=i7CMFe+Y5u0TzibeYfYJmhkBdk2Wn/mdgjueY9VPy8reKlsSi7qL6zkMCa51LF/oIOmzo2FCUQ3jeSFX8sox9wT2M6BhU1aRSZKTO7G/ZtY3Ai1DCOeXzab44arBZiOIHQ/Ib8o02/uaEYcq0E2zXMaOCK6nG7GzzifIi+FfPez54WjJ0ikXx9EuK1zU4XLEiQkIAuZ9bdrkVOc5G5uK3qAU4m+LIhJEGotORj1/txirokDmdGDsHbIMfahNMKALCsLm/BFUIggdBlv2uSqOPxf2YHu+h+j1YF0YNXD7+4tGZvltweUwALBTkl1wwrsPW8Ind8YiceqC5PV/aGf1mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:00 +0000
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
Subject: [PATCHSET v8 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Tue, 21 Jul 2026 08:31:21 +0200
Message-ID: <20260721063242.552774-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: cfed8cb6-c32e-4e1c-df7b-08dee6f1e635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|3023799007|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ec7BlyUxYHyQB/iy+NrM3qXwZZcqAqDDI4JPDSZkhMHICosAVyxQPX1LI/HTLrhfiDIwMkoDo7cXmkxtVqyIMpTpsJQtUcGHFe8hCVA2JLaoxl5ovVOsHD8BWWNUwLN+4KwMmhx325SBvkn3OrSWq+dg0Wyfxwk+s6jOSigHkrSMZi3dXaUoexeIw5CJV2PgXSc7PYYaDTe+QYg9AZMq7PWoUKKPxYRUxk5KvtFS6NXDhWorl0yHUwM0K7c+rm6miOj7vEyhmgMUWoXk+cHsIO3MBFbrE3OfiRTG2v3hrKKnKP8kmnsxDCmAwPNZYSvIfF0CYWRYl1+WZ5Ham+YO2CAnNU/gdli2y8dK9JdGteBpo+4oqGHq7gwUKMNo4AP9fyHbmGef4gbcvRmBMjdsAyykFTdfIp2VfJ5G8HS79eUBTjwYtq6A3A17wjBS5g075MCZuUOFSOOdmHOJTWorrnphl4XZwMI5X8HTfWtr/dqJ+AEvvQHbKsyTy8HLycdJWuT/QwMLXj+5jvwNHnxOZ5DEeXKJt9E3Onf0cwt53+Diqza4QfZR7t2Dv01//3piwDfUKGWs7z+RGb/YST8ecu+9pr1HtJvIRb/G68p3E5YfEYYLMm8n/T6ND9nnxpITcBlfV4oawyGwResfpe+2SvlLFLRhJteWkMqIKHvku4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sexSE1xQd4CYGzvuAJGKoLaKwUoPvXoic6o5SkN+JJd/q2eLnRDEs0SlXtpo?=
 =?us-ascii?Q?mMEO6VrOj/OmwgHQrGTTXjPs0+/vUPv3rstL4jFAOec0M5Lnq17ubn/8wemd?=
 =?us-ascii?Q?zUiQA/M7bc1petkLY8kj5RBHqWsw8np9jvEy8VKxlfTkw4RQ8p+3+3ScIQAi?=
 =?us-ascii?Q?bQLzgMNbCl7/PviHrp8oOM8bWNG6PNX9g4KjIddIjBH8HyYmTPer6mAkJ5hk?=
 =?us-ascii?Q?WDmcTA8hjAIf4rVojHmgEpiev7McttHk2eaqkCECIL+tOtjRyTHtTyhbX+yk?=
 =?us-ascii?Q?2hwjiLJG9eH3hyoJUQmIxhvZp3yrxwfpBDxFwAScNA9j7eQPR/+eC39KxOwo?=
 =?us-ascii?Q?/1hdTyjh+Zwh3ZOQ0kl8ituXysZGPhPkOSNRWNaIgfBGA13CGtCdlpC4DKBf?=
 =?us-ascii?Q?WbgcxM0qwuy2BPN2uEvZDDF2CRxoGAC5y3s4fWF7BUYzMjJP6mkvS0rjj+1+?=
 =?us-ascii?Q?Pz+qJ5sX78rfJqEa9C17d1n8CQTaQqI60r/ISl7NbuZ0nfpKGt5ZqHjpBhTe?=
 =?us-ascii?Q?wwpkHmzXUSUX+K0ld6lJBBc656jIG0Ltr5XLmAeuwQzKFWupPsipnshGZhVD?=
 =?us-ascii?Q?aCoXOtImmxFpqdHCO1kewO6vCfOQF2JWo7kyEzpYNrv6eHIWyklxWFxw2r7Q?=
 =?us-ascii?Q?V2qYlPsDsYdDLRrBeUzKMpmibEURhnfEOQHs4uw1OIBOeIR3rCtNR/6XiBrF?=
 =?us-ascii?Q?sNrJOeUnkwBMytRI2TjkGMtD5PeOHnFrV1RIbwiu3J90up/kqRJjmuE/CGE2?=
 =?us-ascii?Q?mPyP2LzJYPwruXh8UwfUG/rdoJ4vOF0UOS1YFZ4wiFr3l5GhZhpBDLDwIu0f?=
 =?us-ascii?Q?eWVrPmDTruTKnj88kCKh8OIO6uSY1Hf+894EznKE7zpEbFbqsLUqBuBbIGRU?=
 =?us-ascii?Q?YcERL6+5qiUYZQHLiLdgX5TiIgile8hW+JzAwEc6Y5qsjcQMherIGJj0BvUJ?=
 =?us-ascii?Q?Riq9XZ7hy+11OxrzYcui7A2bx3UiJcZ6ikugCEkQ/EK1Ad0LGoCM6ITgUWSq?=
 =?us-ascii?Q?WnW2AZP75fdDVgnLQb60VSTUEPLJtkkFW09CUhqlbsnOx4DcmES53zgr9b39?=
 =?us-ascii?Q?LOqKwL8oqZgA2/zm1KrGRobJXl/glRQTnl6b4qkVNatX/eq5QCVxFR+4cpTi?=
 =?us-ascii?Q?6TSpPW9SilKEkvtXxOrlh8IX/Q9skzditqjsRCclnrCvHySFPxOz0zuWmNBv?=
 =?us-ascii?Q?LtuW+nwwMtnYj3w0a8taIbyrZXYFWICdTF5pZhIjdxm2Fp4DBmm68a2RRgB/?=
 =?us-ascii?Q?IlVZep+rXENeJZYz5AQOO4IFBboph+iRjgGB90aSk7rq9PEMyvwCM0q2s9zt?=
 =?us-ascii?Q?g0Uev/8nFrxo5nhSgXxyPdxgpy7eXuagoiebNX+HLCAp6X0lBeWqZWrW6NlL?=
 =?us-ascii?Q?YESw1asGa6jq6pVeOO01LTWIDY0f8KPNGDml4oBps1pkaIeZGS2rEsdRyqsa?=
 =?us-ascii?Q?bsAQOMTzRdoqw+TmfW2K3O/0w3TbE61dFY4yhUXFqE6mnj8YGsOLnvt+sBif?=
 =?us-ascii?Q?4CI9aJ0ye6YgxGE5v6V/18bAH5tbaOQqL3Xkct/2e1EuGRONQqD5fhocu0qY?=
 =?us-ascii?Q?vV/pGbEVrQVLK8o9ILfSWbPmC7tGuQbjnFs8cYt+lIxd9kZdck7BzQCH0TES?=
 =?us-ascii?Q?0onX9Jn2JoqReA1vDlYEqcBvvFJy/6KHoqcf9KBeTNCwESyZJ/Hipei1Dpdz?=
 =?us-ascii?Q?1waraZxOlHDdXDUyM+WLdGuoPTDejaNMnNa0gmLRnVW2j1J4Xgh3YisRnZ3o?=
 =?us-ascii?Q?CFu6vJYvxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed8cb6-c32e-4e1c-df7b-08dee6f1e635
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:00.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0N5+FrkcI8k775Nj9PrA1gHRJQcn2f3sFQYez0MdzBdNSiNYTWkHf2EABUlMnPFfDFzWBxeE6SnygLT9CbrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

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

Andrea Righi (11):
      sched/core: Avoid false migration warning for proxy donors
      sched: Make NOHZ CFS bandwidth checks follow proxy donor
      sched: Add helper to block retained proxy donors
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Fix proxy-exec race in consume_remote_task()
      sched_ext: Split curr|donor references properly
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (1):
      sched_ext: Handle blocked donor migration with proxy execution

 Documentation/scheduler/sched-ext.rst              |   6 +
 include/linux/sched/ext.h                          |   3 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  59 +-
 kernel/sched/ext/ext.c                             | 374 +++++++--
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  29 +-
 kernel/sched/ext/sub.c                             |   8 +-
 kernel/sched/ext/sub.h                             |   8 +-
 kernel/sched/sched.h                               |   6 +
 kernel/sched/syscalls.c                            |   3 +
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
 26 files changed, 1753 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
