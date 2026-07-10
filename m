Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3383EF678
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672769; cv=fail; b=ksDa6C1ck3FkNccRhh/k398f4GUhZn/FRU806N4tWPmwcLAzCIOYhrz9d3qgV2A6HOofOMFpUYtxoR1cn6oFKuDhDifmCPrc08GXzE3G8xJA67v6MKBhJ2VEj9kG1O5qlH0TRuazNa0518t4ZFQ1kmNuPVD1AtvdYe92zBSKhkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672769; c=relaxed/simple;
	bh=BdN3OXYZAixu9kCvegT2UspBfMj8PYKcUeIvj/j0FJo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i3Cn7hZ0cRyajQWRnKhoIPsnB2zB1uqJ04oU7SqpR1O3grvxSlZkQQPFqCSKRz+SUt/te8AGTHw+oCk1MmCkOfa18upFyPrcOnEkQFdmsKmszlU7lQcq/yStwm/Bkd8vs80WCBvtnHtUq/xWsfCtGZPPCzKS3Dkr0DwaPYpSVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BANNW8Oh; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BANNW8Oh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g50lVcezS6LNQc2Mwn2G7smD+UaRPSJMrHM4vqTRWlwk588RUh9raJA7xkYpHxX6KePR8cihkfar/k+SixSHCu39j6KJ8yfn+iffyoHNAD+ngibZUGVpuSmkJGgo4GOpG2P1ribSSfhQEjwI18ftrexxakMf2XMPHCULH8py8afxdQoLLQv6LZNJXxSMlRdekBCiYvblNKINlihNCIwSlt4UGGYOwWbCGGHUeV67RpLsln1n+hmGbLTXSmsJLe0zvKTNJggqr+ztKqQyQiN2yMa711uVak65NWSqLqQvRQexQlXS2kZwdCn/Rr1EQsw2IZJic301w7E5MrXdaMIZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je2xvW6bZHTxE/toHekIpZQ4LRf57elscyxe8n9chU8=;
 b=qxG6EaoW1WI4JxUXTLom5Y83erxK82yjwjp+4jJgPLjl9STZTcI+JcQ1Gw87wKgNB6sc2EQ3E292w3rAr8zhDMX10/qR9dQOdB7lo6urVvzUl8fPUDRy6l6EfNxdFYWGxDXYavLL9kETFEnVJu1lf5oHurmDs2pjQHt23zu1VEsjt8VPO0u1MIEbhedIHAx4xaJvd8uwbfnFUyN/O64/eh3jt9bsNw+eam5wJnvv1RV0wDMyfzce9GFnyvmWD7nVP8LblyV3dRt0WMS182eskXzmHvHSZcycgSOoVILsgmK6C1i0YBE64ZHREiYeMrssWb4vVKKVozQ+4Bhy50oENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je2xvW6bZHTxE/toHekIpZQ4LRf57elscyxe8n9chU8=;
 b=BANNW8Ohcu769nIJXKhV4/v3PuTNbndhCzpqAt1h9k6UOqkTRKWEhveqgsdEXmuRjIhnojl8JLP7CYS2Fch6XH/ZOIqskCHF7+zgIZMOQxGlL8t0/IW2GCBLKSoBpj4x/0q5mcvVKVy9UldD6goW46L0kEo/KJJSRKXg8lbVA6S4fdeUvumouys4Hhqan7fqfdXjOYAcOtYl2WVZNXN9n2Am5Li7/61Ih4DE287QXqzyl3cL//wQRfvW+h+p3IxODKf3YjiFS3x2Ko1Ra0522WwFl4ZMhC5roEEGSM+nUdlWwExssP2bJoT05UxLOtXTrAxCGo2NYqPmqjUl7Y0L+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:39:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:39:20 +0000
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
Subject: [PATCHSET v4 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Fri, 10 Jul 2026 10:36:24 +0200
Message-ID: <20260710083913.30573-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b9a0b0-4477-4555-f5c0-08dede5ebbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|5023799004|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	CrAegX6mqshAzxWdraKlwA0TA7iPlHSaEGEBpIQkvCZCY5DO9I6lbqJqv6Rlp+SRD12zt+iHddBg1GgoWD2a2cW4KJlnBFB326aVfbbg68LfZMkjVoiQk+AD8F+S6VvwelMT6rxcI21zVuVp+y3Ft55iPL9Sc33bFbxHksfhmiI7VZ8XT7RoO8Jkt5mFsD2auM+F1v6NEcvNSIYzvE3TewtTrvHvRQQ00+yGU3zG48Jrwexoxpd6rwd21W8CsJUyQf6yxFucf1/Be7PsVLK4zhD46arY29zH57Tcd5gkyDqthb7Kt64IyoEKG3Y2U4n9303Pz2glY4xMNOYMoPQgwr311CCTAc1bINquoiI4cROd8PiF9xiIPezS3RDIyYxEOpmIJjmErLNW+08n4k/sS8S9IMZ/aGHpojueMK8bhg84FCwr3wAjWsgI3ggBQKVIqWAYD+mh2w74a8e4N341uykmu6Crz0nEb4xLk/Kb8e3W1dsWy3K19FAmWJsgpzkrtERZU3cTG78u5weDAINPe6T1jXrl5+Lwm5NnwcVwX85wjcGJDk4KR/kVx4CImGoE/D8tYVojTUtFcwyQC8qBV+MYRVIlmsvIobjFDcO3lGOfpK3w//ZmXQD/WFCwinoJkAGIV1KiYDrs2d/u+xi/zARRHhMkiSfL7pkRcGnov8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0QGr/0LTt0jevl4vx8wjjOIw/R/2y89vRttmr1uTjS63Hr7SQK9kbe8KJ2g?=
 =?us-ascii?Q?EDmhp2qOzEAByMwxLOc8STEDJn5m7iQAoJQhxUeYH4DqeNSMHYed8ATuiBjZ?=
 =?us-ascii?Q?VYawQi2x8MNX/uteHVGL992bdz5Dr8O8efwQCxKfn5NCM7UuPYg38WB9KpGh?=
 =?us-ascii?Q?E4MRndLCAgfxP6w86pFKEmB/tjHmUc7ze4C0OAVCyy7h+Mxm+XgJGk57Z4KE?=
 =?us-ascii?Q?RKmbKV1IIIgoshu38l+pkOdNJ+8BpDCtY+lFOlHiLGasRNzPHfNYhWq968J2?=
 =?us-ascii?Q?BTh4mQkGjWY1ZT6e4RDmGx9tHdteUUvWMvnE+6e5O7vvTeEy3I7sAWlEh3JI?=
 =?us-ascii?Q?YTn15xY3nfnI6MMsiJ6g87W07yEq+NGUepYBdE84Jj0ze6cT5cALGeQmcyZs?=
 =?us-ascii?Q?lTOq3WIlJgtEoInYUl1mTyhqTVoo+PFH6Uh+Nv/2UM3zXGoBGah9ItzQiDng?=
 =?us-ascii?Q?QagtYPCIF3x0WbuOl4h0lWrrxiRRQ+MQqb0RGW6vXpSaF68QHVo2cE4F5WJ6?=
 =?us-ascii?Q?VhcfPa3FeF/GMyR5xuGfz/GzLMBIbmZwi1DbOWAsPtPE9S984h0ieB16gptf?=
 =?us-ascii?Q?LV14vReWEfYdDXqPCmcI6FPiNCmrLKb+yosx9H/W2iAgydRRBJZCSDc7xfGh?=
 =?us-ascii?Q?dMbkuyiqegZrsIoqzwHY8w+dTwy007p6gCsO5vIdJsz5IIJBllENMPmCvqVh?=
 =?us-ascii?Q?6jgIooWz6335pEqWlBHWGn8o0Q1lc+un0tduJH+R6644g2YxKCWiV2k2Kx2w?=
 =?us-ascii?Q?q0fA6Hu8Qfx6mE8WoUpAT4ZllcLplEyjeC9dHniucuLjDFuZd0sn4tqJVMxm?=
 =?us-ascii?Q?39o0LRwi/z++9pB1oKI9nEC4TUrMQDzn+2VaJBViw/bWeWGLsZqGE6pTjiyM?=
 =?us-ascii?Q?/qI+GVqec4Sgg5nRp6jTSb41m7bFXHkPrPNf/SoEKfZXrn9DI2zK5jhSsghd?=
 =?us-ascii?Q?dGJ2NQNxHgQxef1gPkwSAnGLiN5Em0ohSzm7kWTVs5hxrVpZ6OYzuhQWT6XX?=
 =?us-ascii?Q?omNimJrtzPY+JbmiaGn/9STUg1ohCmEwX5YRiJzXRYqqrz7w943ARtCpuDcW?=
 =?us-ascii?Q?yakRbEjIJJwketQ8ZI3fF8cYCZLGFy6mOlmvCNia3SkO3XmzgG6xGjccFiDC?=
 =?us-ascii?Q?KOQoqza/WKO9+kuw6sD4yb3LkJ1yO+yevi6JTKY9D7evZLl5HPxCIQpzf2zl?=
 =?us-ascii?Q?gGMY73NNr/E24UFIYOUMv+EQZs+mnkBo88qY/MtYNYsy4SD8d78ObhbvTuee?=
 =?us-ascii?Q?c5JxsGbMdwtXYrzsIea/fYytPj8n+dUEHKWoSYURaLjT+UW1H0k6NXXSXbNd?=
 =?us-ascii?Q?ISvaLlLyrkxLGJAcE8Cj1p6jCMSlR3dNdBpQCsQ9gxajziVLfCMo8X5Mi4YF?=
 =?us-ascii?Q?DSAq77khKEE96/OR3NjlYC4+gh1tw50qg2qzvALIbExawvLanDZidEGeJqZy?=
 =?us-ascii?Q?r+ZQQywhcNnme+Tay5ZZ4p+AS8k83XQ7DT3g622pYpLYE/L/X7WUfvy4eqo9?=
 =?us-ascii?Q?cOsFaK2qwch6n3TLCW49Or5U/tbsl+ougPKt5MgA3XR2oieOlr0TMjEGJrlW?=
 =?us-ascii?Q?IDibrVfV/akoIb9rdyLzV+qot+tjUYw2bcMfCUs7LMmUnUGh6c8SVY3NTre3?=
 =?us-ascii?Q?tlGXqn6mkjeZWXWP2+MkQplCb8CPDxjWO0F/Gkpsoka+xHVZqtl26Uy2jBWa?=
 =?us-ascii?Q?V2b7WcL30EqiWYYudjgLLSLoTPC2DLvcZoqiP+lty52eJZKzEOdVgqgg41fG?=
 =?us-ascii?Q?JbPRTJQs5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b9a0b0-4477-4555-f5c0-08dede5ebbfd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:19.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArY5z43+inpDdjoJosqCI/wSuDMtorhnuamKELsBMwTZopBYEr9SA3gX13YvCZwnnc7FJN1JC2LY3uAkESxncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

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

The sched_ext callback bookkeeping is adjusted accordingly. Blocked proxy donors
do not generate spurious ops.running() callbacks and ops.stopping() is only
called after a real running transition. The core also drops mutex locks before
proxy rescheduling invokes scheduling-class callbacks, so callbacks can safely
inspect the proxy chain.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled or when a task moves between root and
sub-schedulers. If the incoming scheduler does not set SCX_OPS_ENQ_BLOCKED, the
retained donor is removed from the runqueue and stays on the normal mutex wait
path. Otherwise it remains eligible for BPF admission.

The mutex owner's CPU can be queried from BPF using scx_bpf_task_proxy_cpu(p) or
scx_bpf_task_proxy_cid(p), with p being the mutex-blocked task. It's up to the
BPF scheduler to decide how to use this information. For example, it may inspect
the task currently running at that location, steer the donor there, or request
preemption to expedite the proxy-exec handoff. Schedulers that do not need this
information can keep the donor on its current CPU/cid and let the core perform
the handoff.

scx_qmap has been modified with a -B option to enable queueing mutex-blocked
tasks for proxy-exec.

A new kselftest (enq_blocked) is also introduced to validate proxy-exec with
sched_ext. The test creates a three-task priority inversion on one CPU: a
low-priority owner (nice +19) holds a kernel mutex, a high-priority donor
(nice -20) blocks on it and a nice 0 contender competes for the CPU. The test
runs with SCX_OPS_ENQ_BLOCKED first disabled and then enabled. In the enabled
run it checks that blocked donors reach ops.enqueue() with SCX_ENQ_BLOCKED and
that scx_bpf_task_proxy_cpu() reports the shared CPU. Access to the mutex is
provided by a loadable kernel module built via TEST_GEN_MODS_DIR, with the test
responsible for its lifecycle.

Example kselftest run:

  $ sudo tools/testing/selftests/sched_ext/runner -t enq_blocked
  ===== START =====
  TEST: enq_blocked
  DESCRIPTION: Verify BPF-driven proxy donor admission
  OUTPUT:

  [SCX_OPS_ENQ_BLOCKED=disabled]
    proxy_exec=enabled
    owner_nice=19
    donor_nice=-20
    contender_nice=0
    mutex_hold_avg_ns=254084719 (254.084 ms, samples=10)
    mutex_wait_avg_ns=254095120 (254.095 ms, samples=10)
    nr_blocked_enqueues=0

  [SCX_OPS_ENQ_BLOCKED=enabled]
    proxy_exec=enabled
    owner_nice=19
    donor_nice=-20
    contender_nice=0
    mutex_hold_avg_ns=228884734 (228.884 ms, samples=10)
    mutex_wait_avg_ns=207903720 (207.903 ms, samples=10)
    nr_blocked_enqueues=51

  [delta: enabled - disabled]
    mutex_hold_delta_ns=-25199985 (-9.92%)
    mutex_wait_delta_ns=-46191400 (-18.18%)
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

Andrea Righi (9):
      sched/core: Drop mutex locks before proxy rescheduling
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Split curr|donor references properly
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add proxy destination query kfuncs
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (1):
      sched_ext: Handle blocked donor migration with proxy execution

 include/linux/sched/ext.h                          |   2 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  81 ++-
 kernel/sched/ext/ext.c                             | 279 +++++++-
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  25 +-
 kernel/sched/ext/sub.c                             |  12 +-
 kernel/sched/sched.h                               |   8 +
 kernel/sched/syscalls.c                            |   3 +
 tools/sched_ext/include/scx/common.bpf.h           |   2 +
 tools/sched_ext/include/scx/compat.bpf.h           |  18 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  13 +
 tools/sched_ext/scx_qmap.c                         |   9 +-
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 109 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 733 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  27 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 193 ++++++
 25 files changed, 1501 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
