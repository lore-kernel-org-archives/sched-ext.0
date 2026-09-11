Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537F404BF9
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156706; cv=fail; b=ssHrG6T9JPNE7vsATInj/Qf/h7hkT0b/sG0dX8C/jP1au7ZhFrmdeLi2PilanArTmJ5XsIzvdKpddwgUa9wAGKb0Ksblv7DiEbV/6Q2P9+0HZgJhVs8dqaR08bZadIJD6V1DSF1g0gLF7HyXgEoAa8HQ2JrXniO+6oDlEP3QIXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156706; c=relaxed/simple;
	bh=55pA7gLaJ/8LwQwnF7zPw62kC86gNx7nw7ut9BvF+CE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ATghxshJ6PNT50hU5TJVDU6JinIBqXrLyoAX3Oco+bpiec6lhFHrc9mhiZzuXCHTOGJBgQTDS5GATDyBelnMYLST4w7UCkm1CkAIuetCKNaK80uPoFqO5oNdhvspRVtLhOXFko1pMGHqIBmTKHJvzCSOqoykZI6w1nxZhOhvuZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ysll+zwi; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ysll+zwi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkBj7aKMy4Saw0Tf6Ov1inkqMiO2vynNR/S0fdYa0UZdlRqKB6pYX8g0Lbjp0SF3a27Y4QpTNQW3aAgyLe3nJ0pxLiC+XiUbnDmVpttL1TkFqxGGqiBIAoKadxPWWJ8voOZ7w/0/jBno8F6GJY2vaV2OQ/mdCZnAkn+h/atmmT5k3JKP37T+8BnGQBsjshUwcIjf+NgA5FWcVp6CtdTsjzByy+qDKQpj1T4q1i657i6jf9ZAEhGu6ZFjm0JEqNy9wUYFCkXQVLyq4o7buDBAMNVcU+juS2wq4JVm7QJRdTZJBKig4mE/4Sh6YGIZEON6iFxp5NZQyysLkmA4ajd0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY+fwNqKQbNtz/me7zHb9Q3yMZ/hY78l/39W8HPru8s=;
 b=TQ28SgD+LcSQZm/gxlSgFl7fIwuei0z5OM8OLDssk3ooAKESJ9FYTozzvWExJVpKRT5K8Xm7iul79nF+SmD2Bl2Bc6aEl5XBAnoihlDf0D55QYflNoW13bNst4oZay5wPz+mOKi75SHNPP1N/zDI3lyC0ALJFK52CFWxfdrebXiOWng+xwQXR6y/msycltTaH+nvOL7B8wXUSRTEV7o47442SGoQ2qqXUaaS8oSZx8AAOLTeFb1B6eWEZrX+b2SmmNEVyQxJC6efQaaucLpaOcT9QsaozzaITQstScJ73MhVN71+GxAcv4rOZK8IMwemgZYr034cIRk020H2n6LYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY+fwNqKQbNtz/me7zHb9Q3yMZ/hY78l/39W8HPru8s=;
 b=Ysll+zwieAL2/vbYK1L80gr/rdpWlOsHb5SeQX2+XtU4yVGxEsjPMPvOQdsRfnDoNrXmkqqZIHl2mKdXA2GhhOA2D7u06VTM4TdstCq5CU6qYfYUMHMjRhAt+i5SavYplPfcODw3wD+Rhl+/F+yBp2usWVq2VhMB7TzrLeMtXVMPi+3IzAZnZxosX6Vn7Wq5+Yo0BXi2BCPL+oWTdfXmxEfZDgmEvg9XEOW76GWu0ElCYq6JHTZ026UlhxQDTWlQbVZ6A3V76haX4bi3OU5DQ90E7C80GgX93nu1v+0SDf0xxbW4wvO7tF3/wlcTPQszql7aLWcIzMyA/bVbJgoIbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:58:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 19:58:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Add lazy preemption support
Date: Fri, 11 Sep 2026 21:56:52 +0200
Message-ID: <20260911195800.974364-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::45b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c79aee-ebe3-44dc-b505-08df103f0212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uFvqvdb6AsCXiLHMVbMB0WM4xIcu2RFdFpfagQfPI2pmNECD3A+OBqiVSqTepH6pT0/no9mJdKp9BfTKtcferdsg4yRHlcoKEpjyifJQoosS7WaaNx6bP2iVIpu/QfK9w1dDPnQ4FqwcPq+4rLkv4wbyrdQFzq5XH7udGMAPaAOkPDJUA8ES0Jkh70RlIASkGujBYtcwXJuXNHUMsepwpuPx/79g9W7W+9fxrD34oljbNk5BUFHrqcA06Lx7dlmtM0f4Xm2oenIvS+EUxzRQP8SJRWdp4Z69Vdn3ZgTK07c975PEOXZudreOyJuaE43cGb0sY4oKTxaJ8fDtqYKoLg0r/2IXdRFqxOEPGIvZbqL4RKaDT7tSMF0EhfOKTRPAd9vx0HSadbvQ821oBalF9jYOJiJef/gVhN+yyj0uQF0OpyRSs26G3Egv4h3wKvxWpG2tW1VzeGxgCx01PQ0iXIpm0D8YmhpcmPZQIm3L4xQ9kzMLCX7d02qvV0PXdgLWjqClYWJ+y4eC56VSycmUflyvgDwpRNqQC+WUzWWm89PEnDEudtgTTaB9pEa3MoOzgM6YHmJDkywxZbpQZeRF2kutiBjMSBEJUdBrCxcBaYjoNvRli4X0rsjDTKKqdKAW9hHHRehJ5i5vnmNMlUgJ8OdIYqWLB35zXN247Qq3PAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxFwjOj8A4rzbAjlnVp3rLW4NQiznZlzimX9RqnVcnfwkjT2QqNEOCqbQ7LL?=
 =?us-ascii?Q?k9mIxjdqLCmQ99J5MuV8WLQR5BHmXRx80rf11+PbLvbXpt66dr/b5s0zuScB?=
 =?us-ascii?Q?ww6ylUxMsj81wQ+34HuPaFMoRgPaxkc8dCtQWBPk/rl/ucngqDnQ1gE6/pr/?=
 =?us-ascii?Q?v2S0ylbpG8tTPDX7eiZ/APLPJ7LTHMcz33UOFRe2P/VNiBWCuc2QCQQrGlTk?=
 =?us-ascii?Q?PfAihKdlobe2gZkYa5kMax7t8hHWPF8cKfko88Inp2sbs92uBbX5853J7PJo?=
 =?us-ascii?Q?g/WWkSq27BNtFQFPkkylvHd+RbRVHflPSDip6Jh/GFYD2Uwy72yOpRQC04+J?=
 =?us-ascii?Q?kW9Qb/83kq92KuWiqz3Ipq3luy0zZhuprw+5pDvF18Z+S/jnfS6aUe5DmR54?=
 =?us-ascii?Q?M6aBczqLhy0JRH2dUvvYBfR3TvRmxSqKX03B3Jgw//kaGQkvhJjB2+Yd3Za+?=
 =?us-ascii?Q?ZpiUuEOZDE5OCqEsPO5sEL8OoxWQgm/FoXsqtUAos/Sm7HBxL0g0NWGIr/p9?=
 =?us-ascii?Q?VccKRMWCOLcl0AIycbCgCbo/vdsgg571s03c/aORiK3Keuk5jXovIRqyywP1?=
 =?us-ascii?Q?oo7TKhHTHkJ8h+e9wL3GeTAqgnI7mFxCmK2SpJO1LTiFdBv/OKQOOGDAKluT?=
 =?us-ascii?Q?BrD35IPXiQPGR3lu2UnFCplsWwtiLjYC6FQyTRQPPdcyat+nUtTf+xa0vN/x?=
 =?us-ascii?Q?KaFDTgd9H6j2e3r4YJhVQV2Drw1BxE5IzDXFoFIIVizEMd1buecw1VA3KGq3?=
 =?us-ascii?Q?y1j+LiWP+nKJFlLmuHIkU6SG9iumSvGJO5OVyDtuMAVUnZOozQCkHjOqa57L?=
 =?us-ascii?Q?fzCkbirES0SFsVNB4KMEOHJEnrK3WSlOk+Rc0olzCs45E58jd5rjfW5dXQoP?=
 =?us-ascii?Q?HQ4ZgeHuQKa83zxVpxIflTv2dHKMMUb3xOAO8oTBHYWeQaO/+Bs50hDFT7KN?=
 =?us-ascii?Q?PRmgsD54n1Ndr3xa5AIJ8jYMDbYjZNkITzK8J47vs8sqp6D+RTwunp91MOar?=
 =?us-ascii?Q?rrqgZVlxeaRBLbUEX+SEtqmBD35hlN5p9bVNZuOV+fOq0OYhgOzmjZT97A7X?=
 =?us-ascii?Q?d8tuZ/LRHczYzRjUJZe+mMwR7E0cjcGwPOIaVL9utbTzTROO5pszThGU6klq?=
 =?us-ascii?Q?Nj/pYfmxfM+Lq1CHsNu4Ey1Lk02UjfhamLHmHyQUffQTHplNCIM/w/6LfVsq?=
 =?us-ascii?Q?TIWYnWf4az9pUAgIMDAogF5sw5VsB7TI4s+AJgP1+zdIgoSAZuyoTCiNmfJG?=
 =?us-ascii?Q?jazj8WZplOntsdLUy1eIJzGgL0YxbFaBpOCxO6a74WMZ3r7LIEjURGuosooc?=
 =?us-ascii?Q?2ubVrnS08VqWjCljyw/JeXhVcOfLQ09xJFSD+TGgD3AaLsYpBA5YxhOBgA15?=
 =?us-ascii?Q?E2IPtDrruF4OB6JTTKbOfl7TYRnOmMk8ZqOFe7Mpn1LbycZvjnEWR2RvTXmk?=
 =?us-ascii?Q?zAqkGO+AD+wQYfKidbuSkCHYgxKCUNbgKuOuCKDF8TqxWp4r7zbAuMa4mKSP?=
 =?us-ascii?Q?jB8uUIHv8b/WWg+MQXvXsmayTVmRWONx9o9GwghuiQI0Su0azo8h8XCgsquD?=
 =?us-ascii?Q?IodFQ6AbdbENjSbDei5/DO9wGsLp39n7RgAar3GC0WOWqIKt19W7jGrrgZSy?=
 =?us-ascii?Q?Gg43LwDHYlCkNQboiYphvzmN80GJDRMQH/ZHIXYK2EKr6bcAOdk+7Ii2+kjw?=
 =?us-ascii?Q?d4Ef72dSjQa5TGcVPBQrgHUwOSx/JhB+wfcuq6hSVdmfoEhous3PcALSlYUr?=
 =?us-ascii?Q?ABZ2BNGkwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c79aee-ebe3-44dc-b505-08df103f0212
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:58:11.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYwJmRoGkbPLBW+EQdRaRAydHTphF2mS6kSV8XYPZjJYr1gorFYM0ALqZWXWsa07QbGgYNqumy9btsBZyWN1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

The fair scheduling class can defer a scheduling boundary through lazy
rescheduling, but sched_ext currently exposes only immediate preemption to BPF
schedulers.

The series adds lazy variants of the enqueue and kick preemption flags.  They
expire the running sched_ext task's slice while allowing the scheduling boundary
to be deferred until a return to user space or the next scheduler tick.
Non-local lazy enqueue requests retain the head-insertion semantics of immediate
preemption.

SCX_OPS_LAZY_SLICE_EXPIRY also lets a BPF scheduler request lazy rescheduling
when a slice expires in task_tick_scx(), matching the choice available to the
fair scheduling class. Immediate behavior remains the default and is used while
sched_ext is being disabled.

An fexit probe on __resched_curr() records the exact reschedule TIF after the
running task's slice is expired. Together with the stopping callback, the
selftests cover immediate and lazy kicks, coalescing in both orders, tick-driven
slice expiry and invalid flag combinations. Individual modes are skipped when
the running kernel does not expose the corresponding flag.

Andrea Righi (2):
      sched_ext: Add lazy preemption support
      selftests/sched_ext: Add kick selftest

 kernel/sched/ext/ext.c                          | 115 ++++--
 kernel/sched/ext/internal.h                     |  36 +-
 kernel/sched/ext/sub.c                          |  15 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   6 +
 tools/sched_ext/include/scx/enums.autogen.h     |   2 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |   5 +-
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c    | 144 +++++++
 tools/testing/selftests/sched_ext/kick.c        | 479 ++++++++++++++++++++++++
 10 files changed, 773 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
