Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350E438479
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149001; cv=fail; b=eElb5lnm8eLTTT7yDzLt638bHyd45/UGSQB5iDoV6bBbNVTd89lR9pSvSz74n/Ce5WLgSiN4UKx8k2O6Zd97fDGeU/TvzPQpDb+mrudhnDWRaJLlNxwOIodw8l4dESq9d+P07+NVYzEySnRYT5t+j+Bfemdyt1R4I1JsH8pCSKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149001; c=relaxed/simple;
	bh=YXkUYWKnskzyJE0aCzm7u/g2LMLu0NHANHOH+H2SpMs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mlk6osfwI5teDS+mV2Zd7MZMCFTBc4LB5yzmJtw86NCG8vkSF/pvuxHA5Va17tTfBWd3pszFXaZdMACB+rZdU0iosFRVYFdefBZu8+1jaHoQ4t7+YQsfloZRPB6XsAhvpWnOzUWNK2NkXKbqKCkWsqNyHxRUxfKHx8aKrk3VjB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+DgKQUX; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h+DgKQUX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+DN8uTpGJPFxFCMrSQbv2NOiwFmbXztfmX9Of5YTdOjWAWPkabK+vm+OFcrCftgZR99H9NJEv9I6lsW91zfgXN6LJoXaIdeCFfRcJ5bvfPd6Z6V6fJncSskd8ZOpDkG8G1Pwc6z1k/Kwx8ENNk5ZsbXAolJmJEVekldwhKjzKEbojaHdHJAXdkgoqZHEjD73Dre+2EmyhibSHRTtBSS6gJ5wdcG39sTOUuEIPuu5GMdA9FQL1tlbJXTxCTmU9gK7nDE18PptbaOtC6m8WF45NL0IBgc5ZYzjc49hqkoAkezRug6W145aaFxE6auSeXibHhTy8l5BaUeWE/St2k+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knCL6C5gVg366pQO3pwN8C30W2G/yQw9+buXzUn/lJg=;
 b=QBd8jEUmumPfbkftt8+MrJRYmw4XGozCGbnhuz1PWmi1qPprINakGYxre3aDiLR+Jr4XkB6F9qsk9IjO78SzTxfpV9VJxABMKcGiCWGYfGKpjA1xK3Orzr2zSa8lhgl7OCoPrb8QUkB2auxRtw39bOxj9R2qE6T70iV0RXtjuZ/YtFoCeMS9uQdWKColh85NjhQ/Rcv0o1SpuJv62upBoJMUJYk1PuBxLjIPcfueNPvodq6nt92y+SPp0BhcUoQscuqhXQUPwxCU7DZ7KZZhAepEVBRJafPtSJAH9i/H38ikip2j+3YENMlZ5cLR4ARxkfLHN7fAOZH16882Xiu5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knCL6C5gVg366pQO3pwN8C30W2G/yQw9+buXzUn/lJg=;
 b=h+DgKQUXiQQUxCdAAnrVIst2C4AG8v+4AfJsd2NuZx6GYzHiN3luu8LHvJfOyKCPlKMBmLUBZHc/0QiqS3oDKHdsLrHZt3KQbqsFUD6jwMrJo5cGVdKxX8P23NnBdJ65yApYws+sp5SXO6Tsj1ybW40NORGBz1H7usA310HVZt30BlL7Do/0bhYgZQRPnE4KOnNlNFFw/QVPySFozaiRmLfh+u526VR6aK//93SRJT51zttxMy+jOSoLsVJdv4jWi1vIvxb87VmhcW9JPGv41ZGTlGTr8OUG15poYF6EHWFqJU1E2MoXZlRV1sAz/er/JIIFTf3vK4K8rbf6J0uUHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:31 +0000
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
Subject: [PATCHSET v6 sched_ext/for-7.3] sched: Make proxy execution compatible with sched_ext
Date: Wed, 15 Jul 2026 22:54:08 +0200
Message-ID: <20260715205622.276220-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e37ee79-f24c-442c-5487-08dee2b38be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|3023799007|10067099003|6133799003|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bSub1AwHyQOjMCEBJkxu2zptqtjQ51JgERG2neiSZpPXqFrBxp9OOjGY7oaB4K6TPEqWsx1Dn0tQ+ZQA8c9LpXaQP4U8uLcreuAWgCPRj/u0zkvp7OotVY+c8XuZl0ZjbjlNwvKvUXWtmw5to/ah1Z7looyZiLYjqhGY8oXVRMbgvka3Yj8YyFGfMfFLol58ZvtYxywB+C0VdIG4TtDu2BiSv6s44ogqLSNmYOvHBsHoimAHzk/otEO7qGYSqPDhBFgcE+LGEIxEn8O/QOYBcYvOVt3zCRg7bU+gMbJkHbRvFToRXcCCz/zGofiv5tH4PlEvLmHgAAt3wKe6sTlFzZ6S7IYPM8HWIUBESGxNcRzo/quuAd3ubdVoO3ZIqSXtEiu3kK993iyD+I3pLOwDnbGJD0OpKR/d9F50nIu3F2fSyLfElNWIufayJxQYRBjZmWhC/AFbPK7GFBugaJuD+3JUremLeutQF1bnzFUQWxc+6xYUUrSUPytmAlloUM4/is/MzZSbt+okJ4rNdlTz1F+b6oDmS31nEHdXDOvHiEefWUWkfkWuqrRdmP60shv3MyLz+VBbR9R2USdTzgwfiT/PKDvsMBj/lSB+1cTkg9680h7l5I675CHotskZbcdkBt2pCwnUZMyPRc7eoEcB/U300sIJiAcCzIhMtkacJ74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(6133799003)(5023799004)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xO0pXxl1g7gBZj87qInYXSi9N/CIW7uuaif9163qMOtD0nGlliAwH1VP4TK9?=
 =?us-ascii?Q?gJeeTTiAHgLawKY4hfGsbuFwKz6AONgKLhq/WDIBNmqxlsS1hZ//mPC/Nrq7?=
 =?us-ascii?Q?uNg6amqzbstRNS3aMYKk1PKmV02lUzOAMa+yq060d11QlwuyadY/nmw8Enit?=
 =?us-ascii?Q?qCCWFLveVgSbQmBMRX+EyHyNMYR+ixZG9kFpfKhqqCaBI1a2ewZHwQ9FQDTy?=
 =?us-ascii?Q?sHkJcHQSVvDVzSDWCBkrD5qMkfMGzHr9700/TBV8J32W3WXIW073Ez5CJrVf?=
 =?us-ascii?Q?eqVXwQtbCzh0r95mqNqnrLuLjOTwtzyrdUboFfweVSTOnjx2f7liPkMiw8HY?=
 =?us-ascii?Q?eISP/Ubi/6oujU0XoSetBWXmd9oINNzW1h5OuZ53kou25naKhkYFmf/TxEg9?=
 =?us-ascii?Q?wbZy60aO8W7wLBlNHkoHmUYXYUgnpemv3Lbw32xI51XJ3kChgh55QIHfZtkw?=
 =?us-ascii?Q?BvbkhZRNGAv08fD0Ebvf2NImNztqXzibRIxWAK5W7NiRhhtvIlLP7Lnq1yjL?=
 =?us-ascii?Q?VGAkkRSr+qQAkOedurz7i+WEDRvD5wJHRAC2dleGi8EXoozN7V+B6/mBH8vY?=
 =?us-ascii?Q?sE4+YPUp9CS0QOuhdeuTAsbJsrmv0nzr0I5dTXOkgqLo/S8c0qBVXwx3pbOz?=
 =?us-ascii?Q?7rRlM5qpkBZ14PJAGXPYUF8KPI3X55nuuZ2uYvqwfV3ak4tUMGKw2XdMUd4h?=
 =?us-ascii?Q?Q+wuOcHTYJ35OASOipRyerIll6BDpP9ucuaAnY93LZNviYv0EscoK7UGVT1b?=
 =?us-ascii?Q?f/Ouct4o8mTMdi58vH1H0dVswNjWQWkrnaiQHRWlBGtIy/tVgm3I20G7K8HF?=
 =?us-ascii?Q?oK4piOuNC5O6gp7ndpCY5Y834gBJrvL8e45bFfyPXGGw72X1pKCB70Zbv+0D?=
 =?us-ascii?Q?bITPJRJHLdPj/BVhDHUBCHIUrdMOiVSMJfTwufDoTggDkrnOOEYqMeTOEv8A?=
 =?us-ascii?Q?ZSBPKRtr2+dGA4KABZXkTloF3ca13rULd6576kOgelOMKK/mboqOVdOHCaMF?=
 =?us-ascii?Q?NgsoFFyoZMZSZN6hYK2zDb22PNJC0rAabtDwjYCsSscVddCr9n2vflKUhg4y?=
 =?us-ascii?Q?NiaFOKbgUXbZC1gWbtsf1I7iziWESJnhyCFN65TGypv02c6puiz7eK3IIemm?=
 =?us-ascii?Q?HhSPxDQYOrksyegcmLCHG2AyX7UfNoTRSBqvGym6nwlU7qM7Nq8pe0rGtPnb?=
 =?us-ascii?Q?Thy4V/7U0juikPXgH7c+vUouO4YiqEgnGW4SWZUyaG2JXZYbBUCzUL7tw9Rg?=
 =?us-ascii?Q?XWDqZ8bZifmakFDYgtyb7ZKXrWHl+GEIQZVBvbck1wY2KPGTwGq92VQd8ebK?=
 =?us-ascii?Q?DZfJyNlrhGdV4kHQ/1zqRKoIkz7LJJIpK5TmysoY0c7rHICHHr3Q4Ic0SZEh?=
 =?us-ascii?Q?RUyR3BM5GSKhgS2wv9q9sybcVuW5umV0mt7dnEG4okX0oF8asIO2Ixk7oJBq?=
 =?us-ascii?Q?vGMnTLQP3vbSyjY/RDiUUMC7k81KkgPUOMb7O+W90g8mEyoubDWwdldoxg10?=
 =?us-ascii?Q?5ipQaXbGdtH1zNtwO3dCJLPet72AYLFp8lkIIMw2MasKMKJy6pqoF9EWuahv?=
 =?us-ascii?Q?VtkGnc9n8kCeMsN5UoatYeWjWZ3YOmy5zb1KGwHISsDkKI/LJ0G4OARerwvQ?=
 =?us-ascii?Q?V9vTKWUL7kIHHzwpB1JJBTN9DyahnsNKudZAjLZ5uiGsdcqgE8F4+tpR//yr?=
 =?us-ascii?Q?Dgq9MR0Q3YFAkPrGY8T+TuxEyHP+ZMoDjX+48gWJrBPd8lNRKlp0RrMoh70o?=
 =?us-ascii?Q?5e4R7u25PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e37ee79-f24c-442c-5487-08dee2b38be6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:30.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX2p9qBdCHP9BeTg9pSXkTQiRsejYAxEJTdBvbDxq2J9MNzliIammg4hg7JoaWdekyVbFik2B/6Pr6dJ776mkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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

A new kselftest (enq_blocked) is also introduced to validate proxy-exec with
sched_ext. The test creates a priority inversion with a low-priority owner
(nice +19), a high-priority donor (nice -20) and one nice 0 contender per
allowed CPU. It exercises a same-CPU topology and a cross-CPU topology, where
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
      sched: Add helper to block retained proxy donors
      sched: Make NOHZ CFS bandwidth checks follow proxy donor
      sched_ext: Block proxy donors across scheduler transitions
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Split curr|donor references properly
      sched_ext: Fix TOCTOU race in consume_remote_task()
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext

John Stultz (1):
      sched_ext: Handle blocked donor migration with proxy execution

 include/linux/sched/ext.h                          |   3 +
 init/Kconfig                                       |   2 -
 kernel/sched/core.c                                |  62 +-
 kernel/sched/ext/ext.c                             | 276 ++++++-
 kernel/sched/ext/ext.h                             |   6 +
 kernel/sched/ext/internal.h                        |  23 +-
 kernel/sched/ext/sub.c                             |  12 +-
 kernel/sched/sched.h                               |   6 +
 kernel/sched/syscalls.c                            |   3 +
 tools/sched_ext/include/scx/compat.h               |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   3 +
 tools/sched_ext/include/scx/enums.autogen.h        |   1 +
 tools/sched_ext/scx_qmap.bpf.c                     |  16 +
 tools/sched_ext/scx_qmap.c                         |   8 +-
 tools/testing/selftests/sched_ext/.gitignore       |   4 +
 tools/testing/selftests/sched_ext/Makefile         |   2 +
 tools/testing/selftests/sched_ext/config           |   2 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  | 116 +++
 tools/testing/selftests/sched_ext/enq_blocked.c    | 908 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |  27 +
 .../selftests/sched_ext/test_modules/Makefile      |  13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  | 193 +++++
 23 files changed, 1630 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
