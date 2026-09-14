Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB48095A
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397199; cv=fail; b=DzaC6Bim1ehRmkUgsALa6SbUMvxdhVXZy8hXMq6M4j8h3iXh/qt7moDCIodnq6o79SZtnX/OR5/DQyTXOkpYZeXyAxnqB0qyc0Mmn26cdDMTUthCGIvgtZkGVmNlCYuGnWBYPhWlswpi9KWReQe4QK214GcvS4nMifSyBnYiDdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397199; c=relaxed/simple;
	bh=/JidOn/XPF4+tAVoaVAQ8APoHGbOsueQAAMYRumGwlw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TP4HPqoiC04aCyqjVttEz3/jwB4cXBumq0EENY3qiLEOpI4m3lfXiT+HUNxr6kCYk0t24O70gLHiGlpo2qvLAXjeO2+1G2wyP5XmkAmYm36ntl2ObDFd+0XU1IU/OOULdLGcl+tJa/KsRcu2x7jJsOiHCCYl9sWlUWbbXzNDvvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pm5va6az; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pm5va6az"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqJZt2UoOQZmXsy2GB2WhH4fCYgLYXgaUS9xjGYAO6KMlhiHLsx+d06fqc4tgnBUrzhZMQyuUGnOurUj4zmLQPODlp7DPKPpi5AZsEhKLP7dQPdM+Ou+xHjQmCDFJVVoODAYy5Q7vn4Og+cmoHroeYD/s3NHoBK+GAoVGU+dyEB8bEpjbBL2fXwRnse+GjG1VctfII01bloRWHZWzfZorooKCJ3iX6EGegqaP+wJl1seQYMsadBFH67XQPa+V0s+M5ZP3Xuy0kRxX64OBuw+WuPt/0Qo8fh3jqiYBWlC3PyYX1GBQAj/iNyyShQJ7Uj7+sCaFQFSSJQJe9kq33fSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/pb9Gmao60GI4Ip+Yf4Al/KC4h95mMWgnhBb+LiY0M=;
 b=EYrWwoPZ8Vo5KjbSQC1++Y+sSLSUlf2I0S0+qZf3lh5Xo6b4v6YRVxLJ/1EBVEZK2tY62ed/+J90qU3xWsc40XLYHrInFcojb8eu3veZslyZeo/5U0f5LEqSb0yG9tED/YvEwSZJ+EIKAqQi0+HVrOg7fAVg3fIkRoZ5JNnwnz2QTdgLZjzASLrdyaBCfT/+9BbpT3lN61daMUMpqFCtdTdStARguOMe+YdvEUfcikx9hmJV2vkd9EsAaNL9iPzmAB5DXlIzKjnAIMDrcawahqCgjoysL9rX6Fz++fVHA5BslszaRwYQFuZc5LbUg+NMiKiLiPTn7sU8NQ9IMegDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/pb9Gmao60GI4Ip+Yf4Al/KC4h95mMWgnhBb+LiY0M=;
 b=pm5va6azJaWKvQ06Qx6jWsblDEMWqVDmdgu2/l5SZ1YhDN1v48X7wwfZFObQuAh31c5hYcCquFjWAd+PhFv90Q96Dn3OL4+SzkMbP3QvaGqNORr62RM8YRuz46E2dKHjPTq7kyxBdIC9VXAgbYd+//9j7CkMeigfln7yfWDX4yDDKUKBEgeoU0bBCwe/VEv6JzoESagMlC2VJMiHb2nMA04NgzyxZeMDK29cYUS915ANt/+Zxv8B7pV3uoggWFVwNjWZ3GBGmJfS2TMXpNx8PddncgRgXKTdWkfytuTMgx2bQCpvmja6pU4ZS+whl563kQjeyjxUbLWE2k5wJmRlsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:46:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:46:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Mon, 14 Sep 2026 16:44:52 +0200
Message-ID: <20260914144620.2032614-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B84.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: e036743e-e764-4416-53b4-08df126ef731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|3023799007|10067099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sn3aihmOU69/beReGeuL59suj5gNN8J7zctH2MLFrQfVNwaPKuocKtrnZFije71qDsUEhNBJEDkNP0753GrOUQd3f0hd8zhs/TSr/bA/71pIBINSR3SlGdnlYkqRxGCZyiLEduC+MfSg3bl60oMsKekIy3Ar1brZiq9i6NuPMINgDgWRiidAsJTCX202Y5GOsmflNLWOlMkmnqy2NlkwmcgvDA4dC9M7fw04MKYGHF68Z+Hnhxlwlt9YHTPsN0RMzBLGqNXuLXwmeE1S2CgKv3YbvTliXSDbMOn5XEjGaePjjOFlH0zdc65DPtgORJCxmLYHJfogkIkbLuwgZk6WVm6a99D1RqfWBqNWHLgrxR/fcx7EBvUyyyRUUKH/7Pfzbdis5yn0E18plIVDTsS2m0lhRT8QnAAen2y+XtbiN1KCvjPHGbxs9y5e4Kvi8AqBcWyvuMgRBXBb9SxhEHSGmyUI2e/xEFuk8G+cw4LIM7WLi7boC6LBa2TNDeJI6cN89DMu9TyA0+QsXIoJk8t6oRQKAJo+TVfX4v1CA5Uq1wrDHAX5y6iXEze/hxGZC9grDKwSQHXwlEXwzwtuKdmdo3L6BYcPdVVu9DSC1UDbKqOKJ4ora1SRgVQvqx9c7yyFBRGI0+prUTR6UAymd2YPvLMd1MCV+6wKkxKcmaCVJ1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(3023799007)(10067099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUPzvlBrYrJc8RCZFZdGayxVehSJpZmHezAzlV4UMY6X5IMCpeqjEo+Z4umr?=
 =?us-ascii?Q?2lDm8f129XO4CMrlSvtciGOm6B9bZW+wtdEqF8OAq6fCNfBTsOqUtqYkwuhc?=
 =?us-ascii?Q?mqEzRBWAKtVQXbCq1PVeZKASDJglMbH05RZeJIwNYK0hrMhK+6QXZF6CVq0+?=
 =?us-ascii?Q?iVr/zvxCGziZfgJ1280r8AcUTFgARWQ1LbIusT9rQ3xoxC3k69vK6f4h+4LT?=
 =?us-ascii?Q?l6D8fVMayJAbAxeCEGvpf2CsIoLE7PNSjyvLtklbQaAhJl2EtZgMjlmQSHl/?=
 =?us-ascii?Q?VX/+OpZoiQvIjIlG0OVIsbkRqPQzvyzaNXvZJws+n9grfN+AL2Bjo5VXa+ys?=
 =?us-ascii?Q?u6jsyjgx8Mwk8EKCkvRS8hJyI4/LJEYxcFYbSaNQbY+Bs03esQ9bvhuas9Ad?=
 =?us-ascii?Q?L4PivgVkcEmVkhQ/oOy2evA99JDK2ln9hL8u4TKY2MQn7TE77KEeNWfOGd2E?=
 =?us-ascii?Q?cIyS8j28O4drN8l67lmnINWweLFEAe5+Pkg6ARUCsssEKEcpz6bF1Egoggl5?=
 =?us-ascii?Q?1sZkU13CygFGGJyJSYyrBZeEnESUvrJJHHhK4pU24Kxvb4TjQ+5IEXhGEnIJ?=
 =?us-ascii?Q?vKHPxng5wQqnBj71ebb74L15N4rVSQ0TxbjuIcquDKDEaCNFWlDIpWAY9/kW?=
 =?us-ascii?Q?7+wY+WzYbtoiHW4D3TC83gkwQtqWz5G9yDFzwb+D+Za1hgGu+oR8NmaA//sz?=
 =?us-ascii?Q?84Ota85g6eseLVoiWnZL/b+TuUmOXZB7xHF9G7YvQPU2NivbnF5zKdVBJagK?=
 =?us-ascii?Q?d3n0IUonSEMwDRG/U9Z09wkXaAXv6l5Ta00+S9n17fiKzsso1NftDGQF+WWy?=
 =?us-ascii?Q?npp010tWNefiUkyp7EAXkrhrnwdprFnBRIW5xcZ3tnY91caOYKzrIKSVE11P?=
 =?us-ascii?Q?nK7mJYNZN//NDPpVPUCT6wS6E4TaeDuQcxZkhfDTJbrAYyGOp4sKl+ZssqsV?=
 =?us-ascii?Q?UH9RFJ69T9l/lSG9jclLhS+4uf9rvGa6H7AxuiifYc9Xs12BlQjMg/u0hSfb?=
 =?us-ascii?Q?DMbYsTMEuYcE70zI4bOBUr4HeKYbJ829b/5giD9ke+0hjp3P1vLwNKP3NFqE?=
 =?us-ascii?Q?3Ku5JIGhl91FuS/AZoCar505d+6hMn5kolmerbWNpuX5DxHNzxo15kte1KAY?=
 =?us-ascii?Q?VulgHmanETKgvp9PxBui1M8c2SMY8ONZVXE7uFqnuY+6vjCj/WWBoMKV7dv3?=
 =?us-ascii?Q?t46Uvf++aMhadzQUv6BwrprzVG7bAtL+GjPxwXHXv/HciyIU0TOCTBqUYHeS?=
 =?us-ascii?Q?DUch8rgpmkYvu15OJQkMHQy6I7PkRsUTz/oItzC2hzSTT7+AxrSddZ7Lu8w6?=
 =?us-ascii?Q?6rdfDKuSFcPh4EPmff4P4kNLL63uIfvqqhZCoGfxk9zqzNQJXaiYLKAhSRAO?=
 =?us-ascii?Q?uhBcNtwfrelbJCLAO0E0I/58PeKy+fk+HGHnAk8aWGq7aiX8InGBYIT+/BDR?=
 =?us-ascii?Q?D0mV8p5kZV1GEaC0VjsSro8nvxhMkcxLGokkZK1PNvlpDZtPfXpuCIA4cOf7?=
 =?us-ascii?Q?heUT/0gMq1xLWbZYnnxKfADeRtn2VGS5d5YGrr3LROWP+s9bHXAymtiYoDA6?=
 =?us-ascii?Q?fFg7f8GxwCKnrCEjcXtBfnKiy0mi0aGLxVsfjofxlIfhxGj6FRbuI8hUKIZ1?=
 =?us-ascii?Q?vDW4bClA23bIda/i7DBa7WxWC0N2UfIhGH+QNG801i3RnxAEaE840EU4cPTa?=
 =?us-ascii?Q?VHko6TaG3dIeK+neYIJ8WGXKLrAK5+9osatuPkTqYuqmrdbzRFlnJ1xuL3M2?=
 =?us-ascii?Q?4c4YCSV1zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e036743e-e764-4416-53b4-08df126ef731
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:46:31.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j31tLQuXPye1hdarOwLyiVIkxdr0XqpIF12A9uv6K+sG7RX0rpzqCaS2iT4ZdPZV4mB2hcoeQLBxsjM9hnhSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags.  They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_SLICE_EXPIRY selects lazy slice expiry by default.  Schedulers can
override that default in either direction for individual tasks through
scx_bpf_task_set_slice_expiry().  The helper preserves sub-scheduler task
ownership boundaries.  Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU, ensuring forward progress even when the
target's tick has stopped.

The selftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task slice-expiry overrides, invalid
flags, and lazy preemption of infinite-slice tasks on NO_HZ_FULL CPUs.

Tested in separate virtme-ng runs, covering preempt=lazy and nohz_full:

 $ vng -a "preempt=lazy" -- tools/testing/selftests/sched_ext/runner -t kick

  kick:
    PASSED:  6
    SKIPPED: 0
    FAILED:  0

 $ vng -a "preempt=lazy nohz_full=8-15" -- tools/testing/selftests/sched_ext/runner -t nohz_tick

  nohz_tick:
    CPU 8 received 7 finite-slice ticks
    PASSED:  1
    SKIPPED: 0
    FAILED:  0

Changes in v3:
 - Avoid redundant rq clock updates when restoring the tick dependency and use
   the pinned rq lock helpers for lazy kick delivery (Sashiko).
 - Set PR_SET_PDEATHSIG for the indefinitely spinning kick test workers so they
   don't survive unexpected test-runner exit (Sashiko).
 - Wait for a delta in nr_lazy_victim_running instead of an absolute count that
   may include reschedules from the previous phase (Sashiko).
 - Increase the nohz_tick scheduler watchdog and phase timeouts to tolerate
   scheduling delays in oversubscribed test VMs.
 - Link to v2: https://lore.kernel.org/r/20260914084955.1798562-1-arighi@nvidia.com

Changes in v2:
 - Make lazy slice expiry a per-task property (Tejun Heo).
 - Add scx_bpf_task_set_slice_expiry() for per-task overrides from any sched_ext
   callback (preserving sub-scheduler task ownership).
 - Restore the scheduler tick dependency for lazy enqueue and kick preemption of
   infinite-slice tasks on NO_HZ_FULL CPUs (Tejun Heo).
 - Accumulate immediate and lazy kick requests independently and resolve their
   precedence in kick_one_cpu() (Tejun Heo).
 - Allow PREEMPT|PREEMPT_LAZY and WAIT|PREEMPT_LAZY, immediate preemption, WAIT
   and plain kicks take precedence over lazy preemption (Tejun Heo).
 - Clear both preemption masks together when processing or skipping a preemption
   request (Tejun Heo).
 - Extend the kselftests with combined and ordered kick requests, per-task
   expiry overrides and NO_HZ_FULL coverage.
 - Link to v1: https://lore.kernel.org/r/20260911195800.974364-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Add lazy preemption support
      selftests/sched_ext: Add lazy preemption tests

 include/linux/sched/ext.h                         |   8 +
 kernel/sched/ext/ext.c                            | 153 +++++--
 kernel/sched/ext/internal.h                       |  39 +-
 kernel/sched/ext/sub.c                            |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h          |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h   |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h   |   6 +
 tools/sched_ext/include/scx/enums.autogen.h       |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h   |   5 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c      | 166 +++++++
 tools/testing/selftests/sched_ext/kick.c          | 530 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  56 ++-
 tools/testing/selftests/sched_ext/nohz_tick.c     | 195 +++++++-
 14 files changed, 1143 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
