Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB3353EF7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901868; cv=fail; b=RIb5IBNFRizbRAwlvUQu/oSTT+IDLs46M11wCzep4mQiTcCGH0nE1fLG9joAV8TbRbZUICUdTrhsajmkI8ecHxo5wLDhFSZkFnS1ivYRVqUrEeRKVBAW+Z7Q5E+JTjqYnIzIwsGBSXEEnu5aIXv+59w8ii3r8gL5lTuFFKsclZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901868; c=relaxed/simple;
	bh=hr238r/1++0ow5Tqvt7JgZyBhE/pDdIzW8owgUkrERo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O9m3TxarPgedvd6kgncaWxZvGGgBXrBNx9uy4ohG3f2zBuuelv4Eb+9/xIrCMpCh0VxGtNI2w57sM6i1+NTzJpvkgCiyZGp/cnf6fMGYpglix4VlzHLVxlp2InzI0/YT+JIQ41XkioaT4+rHBfCN9vVpKgL+PDpcKzb/p1b2+K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jSEurcqu; arc=fail smtp.client-ip=40.93.194.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jSEurcqu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCOQnCSmFkgTcY+CvvihCA2RD8uT97mhk+WaRCOx8dMbsoGxyOJ1CQICpMugJNztJsYlbWAChKnqoe0amGrgb7DD2uM6oRbI6WlqtTmuewNLtjIzYUXuVnX8MAWU/MzECkCzMm6qw53Nn0W1T1OuHHJPiL6duSWOVnHvUlPHczipwnGM3Wk1mCn0QhaNyYQsWo3Jf03Bkor9u8aC/gjG+j23uw/eEupBXLi1mwS2E4yXLRKeR+GVvlSQ/DzUrSnCDj158UT6zyvqVwFIGy/1HnpqNX8Xa6rgptBJbkUPYasSAn6UyXlvTyTSR5k6inwnGykHUMKNOaEng/0ZnXCSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp54zU+jmZpH4z/z0q4cmGhT8mXlJ570nOWJTFifD84=;
 b=rseLbWXvVJ4EIrb7LmZZ4taDawzQmA0gi7pFNLoHUFHGsmFqcsyZw7Fz7hzIGZNGepkI/pZlxBHE4RnbACGAhYkcH6WBUb7v+Pu65bvyul69qQJZWwyTHjdtHRMskY8KSus36X5+2Z5cpNn08WRy6VaBdPpRjualqVOWp/HlgIqh1ZDBQerfkGxjdEd4vVpo1BfZm1OKY0gw4pBWc/AxSfOKsd2bVAg0xCVi5DvmybsMI7kf9QZb+dAhtNRcH8+XLdkWbpZ4WIXQgfvYn4u/5/LCwiD43aq0uxA7Tm1hK1rpEtJ8xq8W5uALwC+Di1Sd5KsgEgc2q/63lQrRfmXaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp54zU+jmZpH4z/z0q4cmGhT8mXlJ570nOWJTFifD84=;
 b=jSEurcquWVdz/Zug7w9Zj9bsojtXdnEbvBNDTJeKD4jatnz6hc2JdIINiaQOhAL3dUb+PDxpGUeT3Eh8iksUAjwkw5aa0tYdlJ4QfBWHM5l+rYK8HNVgtXLhdsTgM1L2uSyQutL6yH4WUgb1he3XCnuBVNqotyO+9pUHHylIHwqwICE7wZ0owG5UzK7HnwiKI2D9m8WAvvnBptoUQ9HdgLYZ1Lh3m0WkW56y3s3nCbBTWsO7K94vu6DhDQXW+aYSQy354tVlre8tQFhwRvscbld+jfMh+RGjQipMbpMzjnDzqf4ik/9ezcP+RJcqlRsjbiGAey4qJiBIFSe387y2UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:40 +0000
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
Subject: [PATCHSET v12 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Sun, 16 Aug 2026 19:34:58 +0200
Message-ID: <20260816173732.17162-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ad8427-108c-48eb-6679-08defbbd11cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|18002099003|3023799007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	HqetIMYSMpA5UHrTqP0N3A8iZvsVzg5hpc4JyQqZ9ZHEn9CfUVABZqCLTGUgUw8xnHlGinyrdm+cM08bgW0UtPya909QTQroR3gkfG8Pjc6ZqRqfq4ryAJlJs9EOrx6cQMD+CqFQ8+QUficicdPpSlcxEowj44NGrpyh+BnG4ea3Kn5qUT5Me8B8nrTLH4iBE6ujXjc6Y20/1oc3p7mooMPNbC3wopgxf1ihu0wzLpt0Pubx08n6+a4O7juO8GkqksuKsZsViNCfuX98mEiZgzZIXF0KMUbWGmydjAf+G+RLUkgMcSrv6k24YjJTlWDiBZqM3L2tEuRWu8YXcFO7xx7jzbziuVZJdJgxBLJhXnRbAynxO2T4wl0l5tybFyKkMyWIMm6gvQVuH6UzSU99IBiI1BMcxGy2eAAZxhuwYRLA3opCQFNmilcsWI/+IXIHzTxSZP4LdGzZhlSnb4BGLJR4wvBe3io+EM4SEwYCIeqdiBUDWqC0bOfHDIziyGOFcgZBxdomkBfgCtknuAScPLioBnzc51aIg43jCsZHFQdG4VUhQ4gTKYShyog6Q7emAsczqxx9tRS9HeUzaVllMrf38ptx/eUOQs0D5JTcKn89bVa6FCqFKzJeXgxC1gf07SBuhIft0nMyReeW1QaAGBkkTni57t1Zi8OXiCFx7SM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IutRRbCoMWnzozhZ8gwNLTy1/CZOq3kK73UupGuv8BMrPlKyLSKwtSPjZvdx?=
 =?us-ascii?Q?RaNqjOtw9cj4juLB3eci5bRPUtSa7JHOUtPMTB0Dew29HerrKY/UXUYZ5ZSR?=
 =?us-ascii?Q?v+46BNuLnMAFglcsB8diE07blF23lyHV/QmYn+SMZqqMvbPprAzQ9e+czaEW?=
 =?us-ascii?Q?ObFwQcwlBeIJUbBYIlEbcLVOer25DZzDvEZ3pbA8pTHnnPNDt/u4rnQcKPuk?=
 =?us-ascii?Q?5gpmycG5MuBdTK+JSE4ZNdaDwjJPg2zn3Og0QD8mNaEx0460tXRX/ccIPaS3?=
 =?us-ascii?Q?kKFNrGPp7ugZlCzY231mYb7Othg/PO99GUnirr2LpsFb4V9yy/0MHyeJh16b?=
 =?us-ascii?Q?bTndEECxMAQR65XGfnHf1VNIb1S6VS2/DquI/cj+DpozL64CV6iug1a+8+bm?=
 =?us-ascii?Q?8GcCXNCUIaC6UfxpTgfmSryKulJ5UK9aC1GEPBmmbaxNtG5m9+a9eDZ/vBmi?=
 =?us-ascii?Q?AOquX7Ig8FsuCpcwciv2R5Wo1CTxwkIKkg+uHsZzxcjf+hspT6w8vOKO64E6?=
 =?us-ascii?Q?+cQzIvJHnsezPgMR69ey/udgHqygSo6AZpTf1OsO+yaiBOvTnDeqK/V0Nbm5?=
 =?us-ascii?Q?I+czzYZaGX/VFCbV10dIoJQhCULgDnjHZuLnzLWGkjhUEDQEeDBdqXItSJ6l?=
 =?us-ascii?Q?ZZH+IyWt9FH0xGE9gdaOmpYoHK7L6OA4T00eiq1zJddOfwcfoLoxBhuWChTC?=
 =?us-ascii?Q?J+W202gHKyH9BNgwHU8cfpgHfZz8oDBN0PeNcmrKyxBjpnk/7gDZpUt5V9/w?=
 =?us-ascii?Q?Sl+3/wmhwd/iVe8HTNyMe+O7nIlsP7HJjwC2ZGChgIPMxZUJgICXLpnoazUd?=
 =?us-ascii?Q?viw3k18hjDrvrleEPxSji/1EEy+C734YVp8IWZs8ZYaQhrvfppryBk1WMVS6?=
 =?us-ascii?Q?r+GWJ7BXlhUwVuwAWlQw/tiBRt9GnFWBtx1rtAEaD5DksYSEFbgnCVDiQ2VI?=
 =?us-ascii?Q?GVzz6FbyZjTlz5e654vRV3ZsVQcEJ6ZZvSPU9tFiEaXo1HOlAfycnOctRCes?=
 =?us-ascii?Q?yWnBMLVQ2yk1NnAN/lvME/r0yvw75TrOX90ETK1ZpZYpg9AAEr/yRsio8T+R?=
 =?us-ascii?Q?zozmz3utdUxN+3gSCx9I0ZWnlKvngQCAwWpO76S96g7e0HXalz7dmJhovecK?=
 =?us-ascii?Q?ZnhEGhpmb6i91PZgVozVg+gDGfhZyTH249WsLCuhTNa83TDu37NV40Rv76uu?=
 =?us-ascii?Q?ps++opG82Tqs2vcJyM+zXzh+hgQhY0B3htQgSPzp5iwE5nSLwdqPs+U5OOG2?=
 =?us-ascii?Q?ocvO/FG+ytB0vreg8BPPAedxkJJCkFn/rClhQXv2OJPkRlOOx1moyAhR9JBM?=
 =?us-ascii?Q?gxNIA+XZPCsOwj1RWP7K/SXUrOy2XPYq9w6vigSzRCmPkuRIc/W1Rs8ODIve?=
 =?us-ascii?Q?2f9u01JH1a5L2tbNvbs7vjpwmDyO6wEnLAAKwqKL27Dzx8cfEbkviFxPH/pT?=
 =?us-ascii?Q?qLVRbGrVnOlhdxM20uxaGvWWDhKPZZJIOj4z3UvffDVW4falfwNZk/zEA/50?=
 =?us-ascii?Q?097iHRVUXngVuXEyYHX9a11EFsUwSR0Gwz+ZOckIbFOBDdsAS6m0XdIlISik?=
 =?us-ascii?Q?tlaacPFkCFOeEexmTc9ft0s8EubwD3oQnr5b22gq6Di4NWLUV3/wBm6AAQfJ?=
 =?us-ascii?Q?+3jiFI/QDrbT/6s71ff9lLhIh2/kKqgZHBS1NRwJ3o8SqqCTLVK+2GxVqqKU?=
 =?us-ascii?Q?pC2qF2mAk3bCHCzOz9mM3tuFWTUNE1pz4w3GQWvca5Xyo7F5ztWGbjwsIhoD?=
 =?us-ascii?Q?b74TBAoG2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ad8427-108c-48eb-6679-08defbbd11cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:40.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMRKjgmqAuVPD3Wq1/4xX1IDKylI47kQnfmCXTwqpfSAyDlPtXRCLL5RCmQH2vT+dOCRsDtS0NclM6U5AzPXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

This series enables proxy execution with sched_ext and is based on early work
by John Stultz [1].

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
proxy resolution settles. Ordinary migration-disabled tasks still reach the
normal validation path, where an illegal BPF-directed migration is reported.
If an affinity migration is pending, the task remains parked until the affinity
machinery completes the operation. This preserves scheduler placement and
sub-scheduler capability rules without migrating an active execution context.

scx_qmap has been modified with a -X option to enable queueing mutex-blocked
tasks for proxy-exec. Blocked donors receive a fresh slice, are inserted at the
head of their current cid's local DSQ and request immediate preemption. This is
an intentionally aggressive policy for making proxy-exec easy to observe.
With SCX_OPS_ALWAYS_ENQ_IMMED, a blocked donor which is returned through
ops.enqueue() with SCX_ENQ_REENQ falls back to the shared DSQ, avoiding a loop
which would repeatedly return it from the same local DSQ. A new statistic
reports direct blocked-donor dispatch attempts.

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

Changes in v12:
 - Preserve a fresh re-enqueue reason when ops.enqueue() synchronously rejects
   a task again and clear the consumed reason only after the task leaves the
   reject DSQ (sashiko)
 - Immediately process tasks rejected after becoming migration-disabled
   during an rq-lock handoff, leaving only active proxy contexts parked
   (sashiko)
 - Use the donor scheduling context for protected-slice admission, rescue
   preemption, slice save/restore and bypass handling, and charge rescue
   runtime to the rescued task's scheduler (sashiko)
 - Refresh the NOHZ tick dependency after rq->donor changes in __schedule(),
   preventing a stale constrained FAIR donor from keeping the tick enabled for
   an incoming RT task (sashiko)
 - Clarify that ops.running()/ops.stopping() track the donor's scheduling
   context including blocked donors after successful proxy resolution
   (sashiko)
 - Restore the change that leaves mutex proxy-lock scopes before calling
   proxy_resched_idle() (required to avoid scheduling-class callbacks under the
   extra raw spinlocks)
 - Dequeue waking proxy donors before replacing rq->donor references avoiding
   callbacks under blocked_lock and transient donor re-enqueueing
 - Harden scx_qmap blocked-donor fast paths against missing eligible self cids
 - Move SCX_TASK_ENQ_WAKEUP to bit 16, leaving room for task-state and
   re-enqueue-reason expansion
 - Link to v11: https://lore.kernel.org/all/20260810151523.86994-1-arighi@nvidia.com/

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

Andrea Righi (17):
      sched/core: Drop mutex locks before proxy rescheduling
      sched/core: Dequeue waking proxy donors before reset
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

 Documentation/scheduler/sched-ext.rst              |  13 +
 include/linux/sched/ext.h                          |   4 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                | 146 +++-
 kernel/sched/ext/ext.c                             | 574 ++++++++++---
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  37 +-
 kernel/sched/ext/sub.c                             |  70 +-
 kernel/sched/ext/sub.h                             |  13 +-
 kernel/sched/fair.c                                |  12 +-
 kernel/sched/sched.h                               |  18 +-
 kernel/sched/syscalls.c                            |   4 +-
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   4 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  40 +-
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
 27 files changed, 2024 insertions(+), 215 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
