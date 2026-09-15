Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D13AAF76
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462907; cv=fail; b=BOo5/WTim5omsfkkLNOtLhmab9AVLlGEECaoiGXSOx6y/UOr1yCn8ADJcaUrVyX0fRxlOSzHbPIC/XeCc1mNu7QxRghIgAPDrNjSL3LvNDPr4E+rfzm/GFDa8KvKS9Z+pXqBMeYSz7kMrPcG4kNgEGOVFD+y8kgK1L6lG5GDxjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462907; c=relaxed/simple;
	bh=soiyP5j2OCi8EXSpvMDhBVrvnXXCDoC7kLxgrGXR2fw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KbdRwKHAR8p8DI4dxGjUi53bjJAFMql7TEENln0xLdA5sjq8/ciPoYq/SDYAt/4SlgeA9dNumju3lp4W87SLwSpScCnUAYwllMQE3JvM0KJ5eCArqst+W4jBd6TagwLA2VkJUGK7jcfg+12clnvpcw1OSMMh96KWlOGTKoGW52k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cr/b5Eci; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cr/b5Eci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds9k6CrOzjfPlCnr7BI3fevs0vzYw9PUbZDz7EAdYmMcHAnm8KUQDihG38JU4Is7kum9bEVHnA6WGlK7Xxp45Hbp8Py/nCq4oyiPdQE7iY8PzDVkLsRi+4vg3RH4b9Hj3MZsRUZLkbrqtR/tcU+BKaBeNKJ6xvbVjmGDlo9CqG6++N9z8861F79ByxMZGeQHhKTSleKev/8B7hZc4zFfPkpS7/vojUmxe6E8PhQT3Egnx/Xa/pUriR3EMkCmih0C3HfeYPsjBHqbvFghc66civF0v2oT4nC0eoW4hmHv1r+qnHC3OmlJ6ySDJm91sMsxxj0sbpdz55cBi60YGDHLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=397CMVTRJ9yZJf52uL56I/XLyiZQ2dtqVsbO49Qaqnw=;
 b=AlnYX/FIvTKU+Hkdl5iM6+CfIqHWfxdLw/KyP08C7sGD9DyZ4Pif9+YhNfGrVTS8X73u/x6vwU582QOxmg5zeEZ1HrKTVgjc31Ew69UiPLZdEFCLAoqdronGe9OEJ76QGeWuHPcv5BkAYDsw4oGhAg/ahjK8dzlQvCL9+mtc4/KqYNqlAkSwtJZ/MJ9ILrCgF1wyWm0HyTXv9vnru3kbac2jmb35ANAuzdHnykIFLIAKx42AlT9I3XxiOrFtjVIpCOI7uR7Hy2xAVVVoztMiJGxHLxLFEu9Iz5CI4VfkrGvrqMlLnSgErumR2kCbldroJyKF3Ox7q6YOX5inJz+J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=397CMVTRJ9yZJf52uL56I/XLyiZQ2dtqVsbO49Qaqnw=;
 b=cr/b5EcibO0oQUJzKxFHZWUARoElBProJYxJHl16VJAk2RTIj64gJUI8Dx4Mek7nsC+v1MURw68QfJmc76izcMzcFo2lX/bnqIaMJrO/xdKIQEX5GLf20GgYQjtJg8MEKxIMoG0spdTAfxwrGaMEj4PjTDJJLKQUnWgmC8s2dEJFfNj4eEedHB2Edjnl2mC15yJyeViaVj+QVmIOOGEjr6JqPs06XCpbyr7Y9K8furWjOszMN8yUSzLDCoZoICNekBCSwJjSkJve1mZxZDsTMBycyXR+iLTj5OSEQpmdHCAQe29zicNbOxlmWHzq4TaqE7n6QC4SkVg2muOGgpylPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:01:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 09:01:41 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4 sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Tue, 15 Sep 2026 11:00:11 +0200
Message-ID: <20260915090127.2321020-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac22736-cf53-4927-794a-08df1307f53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	I2KQr9QZQjiyT2RO2pqUa34lFPmwqLeOaNHpG1Mtieue5htrmeDY1IXdnb6S3R4hFX6ZIMc4Us4eOiigin+nrv+ynjrNR2AmRpW0bVBYSo4QP98am608AM5OMbBHaSYb8lSYuS62YDjlQir0lFFZ7vq8A26tdCHhpow3iSZ/jDFHQsS4Irbs6Or6VW6SG75taX9w3r5mZFPBPj2lwGbuhYcxs8Kkws5XjYY69WqvD7OEJP+NeyJvMSYfbpyEeA8SO1AYEW87Nvpgv5WgNaXBNTVk7ia9DxVodmB6MkPwi31Z8nyD2X9558kx+PayBm5sJKt4F7ui7wZtbNCQFL5oIqg2oiTcjwJOUs1S+YeSM/yeGvURu90HxTdd7P5vZDOEw6wQSJ4aXQxEw6KR/8lfgRCn36L31dRfBMKheqh7hHo8gUEtbVsOTZJIBV+HAh1CC52pWfarFk4QxJ25R7HvgUhYi+LbSEXTMj17rlVkc3CDDsf4It8spU4iDNMMGTXmI43hstd2YMT+jJPc5F5t7U77rYCpjqLrefCpAYcnmSMVElhsbYt7GLtuQC+0bNNwIK4ylRU+OFD9lJXvHMfveKaizrdYtcTwq//E90LdUrz5cYryLZBJ7o6zptJc2lENWORdCF91WlP5SdTVwxCOBGKX9Xq+8S1mY3Zy1BlwSTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9ta1srk8e6YdLQ/K1Ep9opuDNp0mKBXTJ36RXqDFJnNmTKG7inqq7eC6Ks2?=
 =?us-ascii?Q?qi6qzuLiTrj70H1DuMWi1K+9nyb9S7rMiZXLWeGsHW3EeC4SzraEEP7YfTyU?=
 =?us-ascii?Q?G54QgmTdWsUqgL/UVmLQMskPOe1/N6Trbpf+4qsuT3oFiRe0XDqW7CSqRRXH?=
 =?us-ascii?Q?7z5QtmGKXuJltos7sEK3RkK2L1F2e1STxqf+IhkS2HToykvhEECXP1ENSyaK?=
 =?us-ascii?Q?DEUK8yXjnf90HlPOfdoBdoHqJg8B5C3+4Om1zEfhVPBYBwo+oxfN5VOE0c3t?=
 =?us-ascii?Q?q1EGkYW6umZ2+VttkR2S92byWbHQslbYuoCOEl5F8da4vIoVgWa2cRvxR5Ng?=
 =?us-ascii?Q?9GkV9N3FNOoFztJarRM/zsZGELuz3wo/sVKr1YjPiqhbZS85mNUz5+EBkRCK?=
 =?us-ascii?Q?lBFGAisuNxIzeMvnm3gm3DYICvx40QO26WC+PaWi1/ScfWRZ3Ci0coewQfpx?=
 =?us-ascii?Q?35WGk3DzgwY7U/mbLCw/2NiSFspQ3RusIGOPKsZEei0INBxlw50H4ZHv03Dj?=
 =?us-ascii?Q?9QRsBG/fMfGvuigZ3TDK3OZAXwJ0z0QWmJuGQy83SCEYnzHD/oD87+IMoiLU?=
 =?us-ascii?Q?UJSg5xSK7gfC3ssXBaN2xS4AtFM57DuRXyhlvyCawCDm588dIgCa3bMUcEu9?=
 =?us-ascii?Q?YLCC4xO2iVJgdlGQA/zIQ7dwnf73yViq3dqVfNBoZZg9eXmANwag4EJqia1x?=
 =?us-ascii?Q?9TQPKDHu1PCmCUKT6PXHjuo/wwbyJf6Efr2RC7pNtqmZp3Kymj1u+PwGGvw7?=
 =?us-ascii?Q?mtIncErRMTT7ZrB6t7gWWcNqenQLfDmwmiOiSIvA/Z4o/FZspbGVxJj121mA?=
 =?us-ascii?Q?BeICbuXljsMvmIcmjD9aCQ8BOxmo3HaVP/T5Z3Ovg44q38hyz2Z+VgUuDkcB?=
 =?us-ascii?Q?T4GWixzU8sXHmeCpiglYRNz6Rf93xvTV69D3DaAIoWrgP/j5cBz7DD1A+aBB?=
 =?us-ascii?Q?Zf5EC6nZnr9ZHVGDV8Cg2ZYDOWJDneYeGH/AsHLehlHZPyqNjZPsew7tq5qG?=
 =?us-ascii?Q?QFTB6MM1zbxWYUWxsi4bJVWERQn/l5YWraybAfU/KcaaBabs7w7h467MQnpe?=
 =?us-ascii?Q?qcP8TVMtV6NOodZsw6LBPykRcOwxy/uI8sBopydgL1j1nWjfHXNDSBwA5CJP?=
 =?us-ascii?Q?ODeJF4rQdxWiXBNbWpypHyZMANcSJGwMdipCJd/4a0/BOZ4604lfc9+GNG2O?=
 =?us-ascii?Q?/kx4sSTeYr7SsdkokP/ZvYRMEAiWO7yz71intyBl8wz2uceZs5ND1lkMMsx4?=
 =?us-ascii?Q?fZ3ZedYRUSbuhuCHcTrzjZvJXDxiHu/Lr9LYHHbpzZGxhnYwAcCfeIGkrDzz?=
 =?us-ascii?Q?w2U//5DgjfT1yDXyug5WilWi4JQpovELCA5dNGlyyXrDiFSnkj9hfjviYoDp?=
 =?us-ascii?Q?OXEEsqFg7KM2MbmyShPc++DQI8TcM3q1AIrLYY14TxYvqrkhWHfC9698CU3F?=
 =?us-ascii?Q?9eL6natd9TSRWj/P+P0ru6S0uzIAxm/uYDHetrkPV0G50HFUhxFoUBm8/9Y8?=
 =?us-ascii?Q?1wk+ArrEy9WWgEzs6vf+3b8NPiBgMU3aAswBybEfpKWVnKMhs9BQHUnI1KUX?=
 =?us-ascii?Q?yvKZq3tNIxk5UHiu1uYifIa2vi4BOMqN4/5bTtfdnz3ZDq/qYIzhbGBaoeYW?=
 =?us-ascii?Q?MMij/j05NxkIVa5gixUplaOrvNkGQFcYnnES+7aCv5LJwrIoP+PHs8YMzwHF?=
 =?us-ascii?Q?qlEXl0Dcu1MjHafDEs+j3SXcyeHGUZldeECLtwxp7PSHnTFXOVitpQCZWkfs?=
 =?us-ascii?Q?HlJcHlROUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac22736-cf53-4927-794a-08df1307f53a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:01:41.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXiJSOGXfUbsh1MVxgcQzKuH3rl084wYdAwK+BAd9isMcLIlRh9RjZu7QoM6irjjdTrwdO25CKwC2qiSvyQ8ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

This series adds lazy variants of the enqueue and kick preemption flags. They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.

SCX_OPS_LAZY_SLICE_EXPIRY selects lazy slice expiry by default. Schedulers can
override that default in either direction for individual tasks through
scx_bpf_task_set_slice_expiry(). The helper preserves sub-scheduler task
ownership boundaries. Bypass continues to force immediate rescheduling.

Lazy enqueue and kick requests also restore the scheduler tick when targeting an
infinite-slice task on a NO_HZ_FULL CPU, ensuring forward progress even when the
target's tick has stopped.

The selftests cover immediate and lazy preemption, coalescing and precedence
between kick modes, enqueue preemption, per-task slice-expiry overrides, invalid
flags and lazy preemption of infinite-slice tasks on NO_HZ_FULL CPUs.

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

Changes in v4:

 - Preserve SCX_KICK_WAIT synchronization when it is combined with
   SCX_KICK_PREEMPT_LAZY (Sashiko).
 - Restore the scheduler tick dependency when ops.tick() lazily expires an
   infinite slice, ensuring the request is promoted by a later tick (Sashiko).
 - kselftest: verify that the deferred SCX_KICK_WAIT callback runs (Sashiko).
 - kselftest: keep the kick test controller off the victim CPU and skip cleanly
   when a second allowed CPU is unavailable (Sashiko).
 - kselftest: select the nohz_tick controller from allowed housekeeping CPUs
   outside the NOHZ_FULL mask and skip when the required topology is
   unavailable.
 - Link to v3: https://lore.kernel.org/r/20260914144620.2032614-1-arighi@nvidia.com

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
 kernel/sched/ext/ext.c                            | 153 +++++-
 kernel/sched/ext/internal.h                       |  39 +-
 kernel/sched/ext/sub.c                            |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h          |  13 +
 tools/sched_ext/include/scx/enum_defs.autogen.h   |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h   |   6 +
 tools/sched_ext/include/scx/enums.autogen.h       |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h   |   5 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c      | 182 +++++++
 tools/testing/selftests/sched_ext/kick.c          | 608 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  56 +-
 tools/testing/selftests/sched_ext/nohz_tick.c     | 249 ++++++++-
 14 files changed, 1273 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
