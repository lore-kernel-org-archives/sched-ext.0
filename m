Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06B569F1D
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096104; cv=fail; b=p6OaQThne4lNzJXoKl9iwPirxmSNR1rEFqaKJZhg/pIvUYyKxUiEM21J2xZgnxCOCcuoEGgHZaIBO9zcGddJQ60WRQSJ7TIx1KZo60JD/2sOYdAAu13kmqWJdm8MECq1QsrOb6wcKIEmMGAH5i0xuRsK9ChOivn4FMivI3ueSTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096104; c=relaxed/simple;
	bh=xzsp/rMNhN2QHPbR7xCEU65exmtw/uAhyOczrvnafyo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kk2iOFBYOjAxMRxMq2k61r8MxfSIpBX13s1a+ZSH2mIwMgV1FImT9fnC0kfmtblj5L+h3/65Q2y7jo7v+ezS3TzHsNTnUD81B/DlSQ6I8oSOIdVhp4rVANDtenhhZEclbYVKJ6ImihheGtSs1jVpYMt1xm+b53GY/gqLC2L2ZgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpgHf7XH; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpgHf7XH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdMji/wMdQMkiKdSZG6UQJDb+S5KYU8lFzcJn/rXo+q46E+1S3QAK9JjsRyDQ83zylZ5G80EPt0Yij5B78jADSq5tk2xAGZiVf36zM+VXbvJIhXx0cCIXY7LXV+wv+SvKNR2rEBcGMD/IGdxhZEiqJf/pZfZgn8NKGXRE+gl2On3GyHjhrfgrLJPweIHHFsiBw72B/CbovmZuKUlKS8/dxdMQirtcanJjTu9J1sg8qT78fUnNhoA9Rmkpy2ad230R5QpEEOw+3WQTnj+ZvxwtlgiQaDr49ihAII1a+YL/SFhC9lpnYNZ2qL8H1Ru7PVfErNmzD02ePBFUagBuRKDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8xxjtwH8nzAL0cQHNS9qu33eUxJqGyoFRS/cbFUfQM=;
 b=l+GVczJ+v3BmvOcqaQ0fey/jmx0mJUrd5x9fZdboTlSW27PzP/yYGNWDDU6no1DV+9tK21rsTVOnCwH69SOjne7uDP4rYR3UosGM5FSDg4fwoyokYXJ/R1hOxDhnnZQToALsBQxzyQxci32Umz5l4CrfuuRG1HKv7o8oeH/98JM6zk30/UIjFCl8w5RO6KLtV8gcUdLWR5Gi6UhlxSU+h2QOYfOv+ncf/Xi/ixn7xv6yvN9QGDsHJ2aHmH9neH7cT3JOHeVuxZTesvMTKfmB3f4rKy0Dm7EFcdbSJnMwj2SZAVYbShKZysBluREHf1nSXER7dQCxPLaUPYLzHEAiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8xxjtwH8nzAL0cQHNS9qu33eUxJqGyoFRS/cbFUfQM=;
 b=CpgHf7XHE5ZRZog6uCrDji0N5tvRgqaSqNVPU2X9S2Ng5FIcUbk500a+FYVXAEp8G1QgFy59b4vJo+PWaRB7I/EaKssHpWXe/e5W60ZOu6ovKE8iU3ojE1imM2Z5QtqdVG9tqbwSrQg3B2bhrloye1NXn/Lwn/O2GRjOL9s9cVqxF0avYj+VETbt0vYXt5vkgPOBqk0d1uuwckJkpGMebq4f/NY81AYWKsKiSAIA427rW1LLAfZmiE58erpziLFE5bROuVh78AL4vAUiMcifUqXAmOYlJdGzb49CPtgw0DeWXHEidfV7jj5qGlR62tb+7wQKmRuP0f4bqbpjq7hVdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:54:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:54:52 +0000
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
Subject: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution compatible with sched_ext
Date: Tue, 22 Sep 2026 18:51:39 +0200
Message-ID: <20260922165445.943315-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0375.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ea2e9c-dc28-4935-c14c-08df18ca389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|5023799004|6133799003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	rngxpM9yVEKlFgyKkAYbFs5yaIZ3HYQSRLEfgOkABg5ysp5sfj4hqLEwA24gZf3bUG8qaQQzJ1t0kYSXnKbdP8JiE2E/F9fYtfiZaUnoFyfBM4zcOPzdfkhB5PDjVdrpO1zFZyLy2PEdfpuwskyNkRZI03WI1bgQzT0e6EX6ODD9v/1lKLRveDeEU2tJ34BTBiID/ac3C8zpxTxhfW/9TqAGLorasTidRrfLX5mcPcSVZft+9KRZFFFgfb+gMtQUir+3RppQYmanh54w5xwPIKV+kSGABmuclImzAz5Oiniyy9Ekpe+qoo54gKJE+FvgjJ5uA7gIbGTLSkcrujDaN/f/EIhn6ha3fBlWTItdNMKrtMq+YpSyv406OkMrKWBFfGlNwCCynsd3YM7LAGumvIDTIFYg2yVgB+3BbY3uhxEZ0AzZBAtRCfJx5L/ICVR4MMaMeKH/ln/mFlF9lh0C5w0VwDMYXILwUoeRRzCWBjp/Mtmyr2XqTFUEyB5ae3+PWlJdguWg6LvkhoXW33RHJw8e/zDr8B0wFm9S2XfCsfpGgPBp2xl2SeYz/EYbxQ3/pETFO2DlFTmF2OOW3SNPLsY3TadsTrigVv6oX7r2xxfve5GM26n1LXMhE/RmPzltKgwzoxKJ0vpe72KMg1sk5OYJJrxcfWz5JqCra6YGsyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xFJWtCntydmM3eVWRbm3RHtfRRdLtHOabk99+OWAWztFrhdTlv++vJFfw0ZY?=
 =?us-ascii?Q?41fl5sAhxq2dmbVUwXM4L5iU4McDg+YZVhFJ7P5LtLNQOeJneBJccdn4mkvP?=
 =?us-ascii?Q?2ojusLI000y/M43G2S0910J1lWbvHZpLNUbrFVwXBghEEOgfvMOruj21DYuJ?=
 =?us-ascii?Q?xgApGlblDhn8wawj8DdCiB4XRxu1xnbYGJG+iqsCAXLCq8fJs6TvVfBqHDaM?=
 =?us-ascii?Q?TsSyAt3Ptzh5SVfdb9S+AwrBuCbkpH++dXe2xadovDCiMzTCCDywXY6Bs6vj?=
 =?us-ascii?Q?pXlYQAY58sNxI0xZZ2FkBU2eGfj3717LHoAfbZS3k0IPWQW0MJ2dHuhAvkvC?=
 =?us-ascii?Q?VwjnJrUuQ94rwjt4t7Jiz8YBCa09Lc8s8MNr3ygNWd1qWRXLK1OBt9l9Vfho?=
 =?us-ascii?Q?ujBHTZSM+jjLHgcQVybqzfQ+PBpof9U3UMwPWheYRtnAJ+/kpH9alyqOFfpM?=
 =?us-ascii?Q?kjJdj0XfRE55p2GBu6+0sl9ua9pfTiUVfzH1D1mBO+KGJNztQpwnkNBIvuwJ?=
 =?us-ascii?Q?aN4vc5dO73byvYW09mCoVyiAZZ+pNDb0RR1Jwx1AIN6dgLZ8Y1k6MogxAW+Y?=
 =?us-ascii?Q?IVLiO/xS64874sxNicehCOwi/hK7DmXb2/bSptwOCzCwgA4hiI8pn234Wd2h?=
 =?us-ascii?Q?vJgbHyXYalTQURk81mdsHolPQUP8tb4eOlnzUrUg8B6jBRupos3TU2gLlxUL?=
 =?us-ascii?Q?whdhgyRujxxi1S1Zuy1D31vMz4h67V4VF6X4OQUPc/MOwgMoqqIFk8tRA8cL?=
 =?us-ascii?Q?g/wUaFnWMhXTOHtD+6ijacnkuxQvTEH5y6UqWzIlbdDXUivAsVBESy09pI+T?=
 =?us-ascii?Q?1RoK1sJssxGIFsnfZ5Uj4+qiTiOiGW/sG6D2z+mzGVu1qRt6M23yJOOFhiJP?=
 =?us-ascii?Q?feU87TH7gf8kahaHhFddRuxIYHTknaPmZqjYQHpAR1xJg3STwZya13vwciG9?=
 =?us-ascii?Q?5F2kHce3GKFR6AZ/mNeX8SobY2JuCzN+5hyNNfAvFWl4aHbSZv2fv9SfxnxW?=
 =?us-ascii?Q?aYBu2ovKWb6feFu/xyKJ8+cqqLJs1bhMELTbZWhR4ljgu0+uJ8htlRxlSQYC?=
 =?us-ascii?Q?MG/2kE+1X/Me5DU29NGhStTenoVo00RsBN24uaGNRArMf4f1NYVQ4Cs19r1T?=
 =?us-ascii?Q?L+sFm0Qitpsiap+Uk3q55BXVzeJPbRYIYIuW4Cspz8KwfP5v0IlwcNcsNsXm?=
 =?us-ascii?Q?FJK63pkoV1qpW8+cFK3NjNxxc6tI1ojPCY5fOaD9fcSbhh9EOAcDLX2X8qE5?=
 =?us-ascii?Q?5p5Kq/p5pQ5LXBBKDExpvGgxOk9TW/QO7ZGajIT+yPp8cHSE7HeSCGPcwcKH?=
 =?us-ascii?Q?PS0bfE3qOg44H6OW8yhUU2imAuXWoXF4DMwcyBWbLgWprs2XKyqtyavhtPYe?=
 =?us-ascii?Q?rpttsthetfrVHsyFQkZFF9rFLfJxIHJPssJOR+6wFNd1YgGa0w8PwcR2l74o?=
 =?us-ascii?Q?whvkWOrCatzEieR9BxnPFBAqnHBlIim00zGPd7L2gdVkm71Nr14jOq6b1C2w?=
 =?us-ascii?Q?Zr4B1dGln1Rk26zZCPZLmoU0Z/hQgkqlLAppSNS8UrsjxtznvsVZks6nuxVI?=
 =?us-ascii?Q?Oi4IHrcZdUsWOj+APpcd7e3IGkfmXG8Z6bEYzM2/zmaW67vo9SoehdU19LAt?=
 =?us-ascii?Q?Fv9Op+CgrElGlktWXO3HEHwGdJ+bzWkLJFpPe4W1i6ApPDyeL8V/K1MFxts4?=
 =?us-ascii?Q?ygNZqFFVirzFbNYk2M3nhdnASWTFXi+5R2+HUQ/YLbbmhe2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ea2e9c-dc28-4935-c14c-08df18ca389f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:54:52.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrL4VqTKKsPqIPGuaTo+Y9ASjbcoq5v8/SeO/JZ9MwVBIxvPIGM6Cs9Gn2ToWSz2w9vlSEYbYkwig0yjnQCxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

This series enables proxy execution with sched_ext and is based on early work by
John Stultz [1].

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

Once BPF dispatches a donor, proxy execution may move its scheduling context to
the mutex owner's rq. This move is distinct from BPF placement: wake_cpu
continues to identify the donor's pre-proxy CPU, while task_cpu() identifies the
proxy CPU. When the donor wakes, the normal wakeup path uses wake_cpu as
prev_cpu when returning the task to the BPF scheduler, which can then choose its
next placement normally.

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
such a session. This state is independent of physical rq->curr execution, which
may refer to the mutex owner instead of the donor.

Scheduler ownership changes need special handling because a donor may already be
blocked when a root scheduler is enabled, when a task moves between root and
sub-schedulers, or when a class transition moves it into or out of EXT. Start
every scheduling-class or BPF-scheduler ownership change from clean task state:
fully deactivate a retained donor before the transition and let the incoming
scheduler apply its own admission policy the next time the task blocks. This
conservative rule leaves retaining proxy state across compatible RT/DL PI
transitions as a future improvement.

scx_qmap has been modified with a -X option to enable queueing mutex-blocked
tasks for proxy-exec. Blocked donors receive a fresh slice and are inserted at
the head of an eligible local DSQ selected from the task's allowed cids and
qmap's self cids, preferring the current cid. They request immediate preemption,
and time-shared targets also carry SCX_ENQ_IMMED. This is an intentionally
aggressive policy for making proxy-exec easy to observe.

A new kselftest (enq_blocked) is also introduced to validate proxy-exec with
sched_ext. The test creates a priority inversion with a low-priority owner (nice
+19), a high-priority donor (nice -20) and one nice 0 contender per available
CPU. It exercises a same-CPU topology and a cross-CPU topology, where the donor
and owner run on different CPUs. Each configuration runs with
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

Changes in v14:
 - Clarify why a waking EXT donor must be dequeued before rq->donor is reset,
   and remove the unnecessary cached donor-state variable (K Prateek Nayak)
 - Track resolved proxy sessions explicitly on NOHZ_FULL CPUs, conservatively
   re-enable the periodic tick during proxy execution
 - Drop the next-class sched_change_begin() argument and move retained-donor
   cleanup to the sched_ext ownership transitions (Peter Zijlstra)
 - Extend the existing post-resolution scx_proxy_reenqueue_retry() hook with
   NOHZ proxy-state tracking (Peter Zijlstra)
 - Rename WF_ON_RQ to WF_TTWU_RQ to identify the exact wakeup path that skipped
   activation and enqueueing, and split the core marker into a preparatory patch
   (Peter Zijlstra)
 - Gate the blocked-donor admission hook with the scx_enabled() static key and
   clean up the root-scheduler activation path (Peter Zijlstra)
 - Remove impossible lower-priority-donor cases from the curr/donor class
   interaction description (Peter Zijlstra)
 - Route reject-DSQ enqueue outcomes through one cleanup point (Tejun Heo)
 - Validate scx_qmap's selected cid after the self-cid mask race and fall back
   to rescue placement when the intersection disappears (Richard Cheng)
 - Drop "sched/core: Avoid false migration warning for proxy donors", now
   applied upstream as fe3c73d7bc76 ("sched/core: Avoid false migration
   warning for proxy donors")
 - Link to v13: https://lore.kernel.org/all/20260831134338.1531664-1-arighi@nvidia.com/

Changes in v13:
 - Keep re-enqueue reason lifetime out of the generic DSQ unlink primitive;
   preserve it through ops.enqueue() and clear it before resolving the new
   placement (Tejun Heo)
 - Immediately drain proxy-rejected tasks and request a later retry only when
   the task is still running or donating, using SCX_RQ_PROXY_RETRY to track
   the pending retry (Tejun Heo)
 - Restructure proxy reject handling, rename the helpers to describe their
   roles and document why the locked DSQ move deliberately diagnoses ordinary
   migration-disabled tasks instead of treating them as proxy races (Tejun Heo)
 - Introduce WF_ON_RQ to distinguish already-runnable wakeups from full
   activations, replacing SCX_TASK_ENQ_WAKEUP tracking, and gate the sched_ext
   reschedule path on proxy execution (Tejun Heo)
 - Keep the conservative reset across scheduling-class transitions, retaining
   proxy state across compatible RT/DL PI transitions remains future work
 - Dispatch scx_qmap blocked donors to an eligible self cid, preferring the
   current cid, carry SCX_ENQ_IMMED for time-shared targets and count reenqueued
   shared-DSQ dispatches in nr_enq_blocked
 - Link to v12: https://lore.kernel.org/all/20260816173732.17162-1-arighi@nvidia.com/

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

Andrea Righi (16):
      sched/core: Drop mutex locks before proxy rescheduling
      sched/core: Dequeue waking proxy donors before reset
      sched/core: Mark wakeups completed through ttwu_runnable()
      sched: Add helper to block retained proxy donors
      sched: Add sched_ext hooks for proxy execution
      sched_ext: Block proxy donors before taking control
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Move reject DSQ draining into core
      sched_ext: Generalize the reject DSQ reenqueue path
      sched_ext: Handle proxy-exec races in remote DSQ transfers
      sched_ext: Split curr|donor references properly
      sched_ext: Track proxy execution for NOHZ_FULL
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

 Documentation/scheduler/sched-ext.rst              |  13 +
 include/linux/sched/ext.h                          |   3 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  88 +-
 kernel/sched/ext/ext.c                             | 617 +++++++++++---
 kernel/sched/ext/ext.h                             |  17 +
 kernel/sched/ext/internal.h                        |  38 +-
 kernel/sched/ext/sub.c                             |  68 +-
 kernel/sched/ext/sub.h                             |  13 +-
 kernel/sched/sched.h                               |  14 +-
 kernel/sched/syscalls.c                            |   2 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h    |   2 +-
 tools/sched_ext/scx_qmap.bpf.c                     |  79 +-
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
 27 files changed, 2051 insertions(+), 204 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
