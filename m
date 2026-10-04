Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE472602
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099074; cv=fail; b=W7zgq3i97Uj4YuZJjgFBmjY1Q3CF27DQpkQLnVluRvJ27f1otynHf+5HI3sR8Lks21f5fZES5xTNVBB172ZUZ3O9z37S1cmLio0RrGhu1THLJxSZQNPoT/JpkUb983W2Mb3QSBsdx76V2yMAs7/oJvaQkg3sKeQeAPy3aC8TBxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099074; c=relaxed/simple;
	bh=D+6OrCGRkGbnfjuvCKUIjvm6NJRMp9tiHz1DAAowiYc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XlwkhFYOdiY2KpG8P7MUMzjM9bMsKvGoSRcz8c9/6NF9EB+JRl+Jy9xrWqahSBh4SVSBQvogEF8ndA4wY454ExI14heas5ef+IVDGMijmE+7j/07yIGihIGqWRUotRxXxrWgz9jgxwLFxvpx1O8uo056+z7g2unzltpLHu+mYuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/jPSNFH; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/jPSNFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYt8Tfa7EGlNM71wOPmegzKMJaB/gN+M9lbo5DHtpucdfBgoC1dAFilGOSCUppRdDizDXwqClG2x90h2+rwvve/Xwo67M0evCneXdL44uhZUfSEdtMjwCccxbhaRdLhD9ESqEm6jHCXF2C6uwLNrIhMkbJdCRNVfcXDIa8vqKvG2JYmkzNNkYcwTtVyR1Rf/xIFQFdRt4cFujKX/9a61LeHgzQQgnRcszrnWei277xY9nbQvUIG2nWR97po3WvlAt9L1ODiAWhXrO0+Cd/t7z20NU30tUeiajBaxGcS2FV+XuLDzqlS3kSGzMG0fOPiFmGVuuA6Z/+LWaDfVVsbj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXkH/77cy1aPVW7s6iUuOQeAaGos8PRlg8F7+AIbC8c=;
 b=V6ROhyxVRdzfWccUgvt72XV1MxT4y+0R/ANpOKfSuaVNHj4qZBwglO2VJy3+jx5oR/XOcBFJepleXPE5Epv6iYNslSzbaLu+Qs8094/lBwOWpzk00Tdp0Nca3pVaxJwaq/EDkihUCzlnoVJxO/GVGDh09W+X6UhMu03dfmzTbiTPYSP7rGa7H1p70xutBcY2+5UIi+eBrdskEyT2VOnjT+SEn39arAIhd56IRrZjVb1cyK3vwCdNkudVIUT4s7MPRAkMwfi6z1sq8nuYwFnMbf30miiPPD/SR9WJ9Tzav79DRXygUxDE72dD0ijS573QdeFALn3FjAi37LpWCGvz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXkH/77cy1aPVW7s6iUuOQeAaGos8PRlg8F7+AIbC8c=;
 b=h/jPSNFHnHebD25QgLH2KPqihvP0UEtOyUDJ+ltGb2eHVAYK4MvCfppLv0KOBII9d0/6a5YB+ShonZPoHhwEBkuDlZrLMER3FSaBrfsSeLksW24tCyBum0zI3pMx22+GqgfYScm+IuVhbEcrWyPnfzbPITfYHgIjjHK9lj1gy3j9j+tgKKczbw3MLywekNMjaRirzIJwwDv3+vu9awGtWihZQHaarxLSRVOvH0DVUSxFdRQl+emYlOiahJo03GSRrowMxqcYo4q/tE+AE+B9bDs5pK4HdY/11bU2ydu4+9bCQiK1xSjVqj6iCKKw21ePO35NCMPbKGXy5LmfMvjCoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:09 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Add NUMA balancing support
Date: Sun,  4 Oct 2026 09:27:06 +0200
Message-ID: <20261004072901.3579967-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::21) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: c0687781-205a-41db-d7de-08df21e92dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|18002099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	keQ1KLgjwfXh3u9cD9Jxz5f6W0jkeencM0CbbuZoeUVzuehBGc33ucpnqbesUr8oZVdR/i0pwpecWO+6yZodaPb7KNSPVNzoLXl7CWgz5m1Ykjev/PVaZ+n09llVl4i+90CT+pv3DL6Ie8xAb7Sh2gz8+kMOWANEtTH3886uE38koSoiK2HKJFjmbQaWwWCwRmaQ6CHwjmbxoc2mi0lavHeAnxyFHkXgrm2+tvPW4u8t3UC59T3LoOUAGoZCO/hNQQPwMCOUocZiFuwz1DQkILNOu/fJL7x7qeK8a339Bbq9qncqlnJjJh34/gj1xir4XhWlWSR2iXyIO7BwPeXqg/M2ZzuGpjQsP56aGBQzYRzxo2ydJwUMNPN3vjaJPGxpVVQdz9SV0FOerJr4fiFTpZjGvHEj5hSIFSGbkUhl7FJxy1AM21sHSOkIC3q9IvGYtyoQmf7EaJliNS6OXiQBh1WOUlAdAZQNWiB1tNGmekYXwbe6RRtT5zuxArq8aZ5Xx8KYTLyc4JY7pB1erOmaFUOj6xcjZDhHqwJomGrp8XH0Ax+OFWNDGtYX6w6nhZaX2rsI4SkBjghUhloaD+6YREkA1osL3RDTvZgSbLLrxpvDsmrAuUhkgaANiGHg/T1guCJ/y1Fl4MFT+Zc4lJ0dz+ZgDIrm70XnnW3gzUsQWFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zOB1FXGlC0d6yefidPjfee6VN0t3YE8NssRHf6QW91EhLl8/DipZAH+hyC/?=
 =?us-ascii?Q?lrPiBIS//qJvpPM5OR+YOlWuVrgG99yZaFh02xYnqKev9DGiMTeRvisKZw8D?=
 =?us-ascii?Q?3Wf3T5IUzuJjY8xUEybhMvDzzmiVut6WsWpLFB2pqk3jiMWukGFcJIl+87Sg?=
 =?us-ascii?Q?A50ul1v7+5sp4vCJwOyoDWQrKm0cbbrK8X1vCySDUPXN/UFfpDaGN+gUE9St?=
 =?us-ascii?Q?03HmD3tYYEx1m1ndDEc/WOstgfiy26eAI2AedFE6bbZRvBulNmD9R57Lp+e6?=
 =?us-ascii?Q?p6ZuFxsp+9e7RJeiXOq5WXhuwgPpOGEDp1TOQ4EnAn1Hr88so0MAhRf1eepR?=
 =?us-ascii?Q?h6pbskGsrA2zqPqOOah/Fh5/oCmBHKj50gm7F2gYGiiaEwvSgg64Yu0jTwv2?=
 =?us-ascii?Q?I6j4xA5lRXgWMEwwwfXni8J9meqLN2iUb8iDKaMfFwaRVJ6V1Jr6auoO4NH/?=
 =?us-ascii?Q?Xqj4+LN3XjJCqhhChY025Yz3sOtNunPSLWNDf6X88NCp0v2ec4o3PEcYTK2U?=
 =?us-ascii?Q?zc88WCSu6NS7C4YvwyKYMNDbTXBciycOAn51RLewex3vRXMgeyPmCtMuGPgi?=
 =?us-ascii?Q?539PH6R/WIgZY/BYp5eOAUM0iyySjGUrLsVOGty7Y2iJ96xN8QHzLUrTZ8KN?=
 =?us-ascii?Q?sdfghO4pdNML5YmWtyk+/+Bq8LzHl/7+R3eAY7Pnp4bKNpsensRrWzRFUN4K?=
 =?us-ascii?Q?EwmIR2Jcu6/dUu3fCuBsK17YnKXU1rsyrccKBUOsB8dT2wIcGDkKS7QV/vC5?=
 =?us-ascii?Q?woterFKa22FNU3pjZnwfQrmvxkgC1CjMtlGWjLBlU/BTYuWHwScB8omxPyH7?=
 =?us-ascii?Q?uFScveCZUnYekzcRlX/zyveBbWIaTt1cPv9BAnNsg9TV8hrWbCuJNcFiNjUZ?=
 =?us-ascii?Q?IMUs/1CghEirhBRXbTIrMeHJA/TKtgwvr0W3517Na1a8tyE3AyLSgE0pgwK+?=
 =?us-ascii?Q?vxUzBao6ovZjhKCD93xHa0RBGUNQLH5Rpwh06AqP3b9BUzwgr5M/krTAk4Ml?=
 =?us-ascii?Q?kayJxxzWBkqs/P2cQip1oBZmbB7sGSognwotHL9FzcE+O4B1g0FLWrp/Y8Rj?=
 =?us-ascii?Q?qQXioYqbvvUxPvOpZoZ/HYuKXTlshSg/ku2eMIOXAMgpw+0JON+rNPVOu5tC?=
 =?us-ascii?Q?BtPRxeianzqW32Gk0wEktD63gDR9Oi4wech0sYGZS9Nqi1rtsvsj6TLcvdgV?=
 =?us-ascii?Q?0y0hQIN0rUbTV2Rdlt28QOhWOr909LNdsbwsHW03FehXiGS/QYRkmq4HGJ5v?=
 =?us-ascii?Q?RFh5HC6HkDONoVQFHiE1uVSWWp5//zwiYTjpl0xipSkaLipnnlNnxQK8TuwP?=
 =?us-ascii?Q?iQW3c1TvonoKjgz6gwVdO1QHd9WViwiyuWej4q1I4y9yP+J4vw0xEZskx9xT?=
 =?us-ascii?Q?86sbVrzilcqaPFBr6Cf9eK78DGZxW14uzWFQHlcnw0fhtkzk2/AhhY0Oh57o?=
 =?us-ascii?Q?fRGTrk/lACbva1Z1CQIc4Fmj0zvpCdLsPtaCWXdf4JIqewy8sf8CSG+j3wMC?=
 =?us-ascii?Q?Xt0kDOfPgkVG5mh0IRhlD3huc68u2pKew0FHTFVEgeex+KRzP5/eRHsEi8FQ?=
 =?us-ascii?Q?q+ZRWcSmbaKd41euCvIUymQSUHFSDUIvo3o+q4MxakewEBFYwV5TA+F1aQhD?=
 =?us-ascii?Q?3jDJPXnZYky3GQIB9ZuLoIV2UCqP45I+TtFCga0gYpC7/HDNP1DIK8kx6uRH?=
 =?us-ascii?Q?Iop/LfMfHWXhcz92XN0iYLVf8UcIsyhpLtLMmMCnXhUprWjkr53ak5yJcJSS?=
 =?us-ascii?Q?8IaqARm3Lg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0687781-205a-41db-d7de-08df21e92dff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:09.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8iFTWqr73FlnAo3Kr/4yHTLce+yboO6JHfwh1zihW6FLLy+G0JTZH2nNlAzrHGbqd72A0r/vJSsBIsn1FV8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

Tasks running under a BPF scheduler are currently invisible to NUMA balancing:
their address space is never scanned for hinting faults, so they never record
NUMA fault statistics and never acquire a preferred node. A BPF scheduler
therefore has no information about where a task's memory is when deciding where
to run it.

This series lets a BPF scheduler opt into the NUMA hinting-fault scan with
SCX_OPS_NUMA_BALANCING. The existing scan is driven from the sched_ext tick for
the tasks of such a scheduler, and the hinting faults then work for them as they
do for fair tasks: the kernel maintains their NUMA fault statistics and
preferred node, and migrates the memory a task accesses toward the node it runs
on. The tasks themselves are not migrated: their placement is left to the BPF
scheduler.

The resulting preferred node is exposed to BPF schedulers with
scx_bpf_task_numa_nid(), which they can use to keep a task close to its memory
when placing or balancing it. The value is advisory; nothing in the kernel acts
on it for these tasks.

The ultimate goal is to give BPF schedulers both controls that NUMA balancing
combines: moving a task to the node where its memory is and moving the memory a
task uses to the node where the task runs. This series provides the first: with
the preferred node available, a scheduler can decide where to run the task. A
second series, to follow once this one lands, will provide the second: a kfunc
that hints the memory manager to migrate the task's memory toward the node its
scheduler has chosen.

Vladimir Vdovin recently posted an RFC [1] that drives the scan from the
sched_ext tick in the same way and skips the fair-class task migration for tasks
under a BPF scheduler. This series covers what that RFC proposed and adds the
opt-in flag and the kfunc on top.

Patches 1 and 2 are small preparatory changes to the generic NUMA balancing
code: the first makes the scan available to other scheduling classes, the second
skips the fair-class task migration for tasks owned by a BPF scheduler. Neither
changes the behavior of fair, RT or deadline tasks. Patches 3 and 4 add the
opt-in flag and the kfunc and patch 5 adds a selftest.

[1] https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg

Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-numa-balancing

Andrea Righi (5):
      sched/numa: Let other scheduling classes drive NUMA scanning
      sched/numa: Leave the placement of a BPF-scheduled task to its scheduler
      sched_ext: Scan NUMA hinting faults for opted-in BPF schedulers
      sched_ext: Add scx_bpf_task_numa_nid()
      selftests/sched_ext: Add a test for scx_bpf_task_numa_nid()

 kernel/sched/ext/ext.c                           |  39 ++++++++
 kernel/sched/ext/internal.h                      |  16 +++-
 kernel/sched/fair.c                              |  14 ++-
 kernel/sched/sched.h                             |   5 +
 tools/sched_ext/include/scx/compat.bpf.h         |  10 ++
 tools/sched_ext/include/scx/compat.h             |   1 +
 tools/sched_ext/include/scx/enum_defs.autogen.h  |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h  |   3 +-
 tools/testing/selftests/sched_ext/Makefile       |   1 +
 tools/testing/selftests/sched_ext/numa_nid.bpf.c |  52 +++++++++++
 tools/testing/selftests/sched_ext/numa_nid.c     | 111 +++++++++++++++++++++++
 11 files changed, 246 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.c
