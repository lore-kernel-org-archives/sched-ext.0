Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E52FD689
	for <sched-ext@lists.linux.dev>; Sun,  1 Feb 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769937213; cv=fail; b=d3QDW042Hisnbo1hHBIzK1syG2S9CyLDtVnhJ2QVp/fkLn3I7xAAI8IJn6a2JxkxOn1d40s1BakHqzyR3f51vA1TKwwSFZJ4nVb56an+y7E1YZvdDuicSH8yzLmQs/3qGQ1qhlMGYbqfXxFbF0rWY6h6Rq6sHx2LdGQMdvrKotg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769937213; c=relaxed/simple;
	bh=jupzGQ9U+RPaiiIWW6XEmbxbAUatfK4dI/kwBxMX2Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NC33j9JaR1gTqeh44kNwArP1FUPriss+1No6VNzGaDXRkbkwC5+mUX369RSQRbj7j860AGWS72H3WCy+kzjno0kWEMS6o3ANvsX3OYTrMJnqcLXPclGNZQ5Ko64D5aQz5MJQpszaAK0Mr8zXax+meXydss6NR38GlypWkriNTQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udU4gi4z; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udU4gi4z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3yhSW/zZANKndr0Nheqzvc2aC1qU5CPjxVYGEuX3YbNXfzCcBd4CJtlFB561JxKoYP2P+v0aGFC3mAdYE3WxCNGqmCiTGLCiJEte/xA/t5o34IXs+IBVswrQkOjcp1ika6eQZbne1CV0L1r4KpAcYcgwFL26nLNIPU043APyU8XErW4zg9CRhjx1wO+7G6xZPYnD4hNhb4daQPBKMWfzeVRauWzIY1vnxIDv01BDhSqiDkSPCFBjOVL2bD/auTU3F22I8o/g1dZ9jhgFggFLR+2v+6++EcJFdvasz0sse8SxLoSFMfPsbEqBu/uCXtsol8jEVy5PZhvYEUKmKyVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCbZ7lGqNM2Nz8pL2KVN6qLivgjc9ieeAp/YoFO/w4Q=;
 b=mPAm7/rXBNTsi1wQVdDB+gLHSYTOJjd3qi99u+fFY+K0NOXb7QZ2chZGYmAcCGJq1cbGKFiCQMup+xYCJ0lZQKnEDey18X6dKpgKtYslAFJq4fIqLEmygLuUdx+liRHBvMBBvpFH3VdIOzyz63dRYRMSg5wmqex+B1IqpoNk2Oj13bb6Z2ygkKjaKjIArXjRJK9NMP3j6u8XveHOvwNtlBNXxHl7FqUk0wvTLpvxineaS8RiijXbiE4Knn0pB7x/Be0VlVRIEtCjp/24W7muD1kOhVa4O7UNHGfR5NpkIwSYNWZoGzJl9hQ2RJkjayiCTs92YisqkUKGr9t8V299Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCbZ7lGqNM2Nz8pL2KVN6qLivgjc9ieeAp/YoFO/w4Q=;
 b=udU4gi4zgrVOrOC93GhgaK8vYjxjWSuy/1/SdPXcmg4WgGrCeW81GLNwo2r8iMcaa8KBJAz+jOVZHXiauy2x/MievN+5Mgkift1F5v1ledpDMbAij3qFAIGiHMi3+6DmAypa3S73SMb3Xwa1LGFKgvwi0jnhbsegl5sD4zmxMhqlqNmuUwBiddhUyooUWexEzU2WcuCRBHvn26rw02/2HfY/p/dU2sbKUOsgbnCNCYJnuzJ9R9tBGHpsiJGrSoxavbzTLoEFIOYJH84evLltW65yuGsA+rkUxsARM2POyvT4aOfoWuWmpinzcMNkCBxt2cJ+fBS1NtXlCSj2qeZ3vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 09:13:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 09:13:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4 sched_ext/for-6.20] sched_ext: Fix ops.dequeue() semantics
Date: Sun,  1 Feb 2026 10:08:03 +0100
Message-ID: <20260201091318.178710-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd372b4-0cdc-47c6-9959-08de61722783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxFKETQ2PXpfzxUdxLg6ByflzA1SJlF0v/G8F0aFenSMjv6qaUq5ep1QmRAk?=
 =?us-ascii?Q?eBcM+gpwoxBivW1dl9ViebZ55pbLBeics9vhWcyD7WCQGbeJybzURB54q7TI?=
 =?us-ascii?Q?McixX/106blJVH9C0zAdefH8xIOeNNclBbzBPRyPGvcSvlHtxdaPwQ+vNrhW?=
 =?us-ascii?Q?GqFpgmtaXT1MvWsZJJ7I74LPEjtubF5fNzakVc7r1rMENfDpbp/JN/JKy61/?=
 =?us-ascii?Q?2EpzjAGuImxOR5vZgowOw/JCWa6NioP4kdcLCQOmELNmj0iSGqiTXCYc6bDf?=
 =?us-ascii?Q?jD7L3qdsebsgLk4WHZL5q9OA9HAfpcYQKXw3PNXOllOKbHhYoFaD1lI3p/yA?=
 =?us-ascii?Q?jJ7/LHmL8EZ1t9X5MmBiOfq3NIgjFhhBtsyb2LzQAFImLN2E/UFjuBLdcIy9?=
 =?us-ascii?Q?cbmdves+dxNm0c0C8nCHishZoNgthkqo/IKLN3ZoHq0cH+9/xTcECgibXpfj?=
 =?us-ascii?Q?RO4ulMgx3xWfNgnTPgps/dJU5Ol6sZ3ms59TpE4Ag4zmmkPgOFwMDiY2TLqq?=
 =?us-ascii?Q?qczvw+lo6UQ0OPgUXMJcnVb4vJvQbX2fUk3UXEH2ZIYh1LgpW34okz82SbQl?=
 =?us-ascii?Q?k4fhAwbBvhLtLVA+weoxGDR8fUkkFROeDRdOlR5MS2LhKt0TJSVXXqlP14U2?=
 =?us-ascii?Q?zs+CCQtX0+phi/TbCmeErt7R3mhTyS7XObfNxyCpmo4p6pGb9coBm6J9A+NK?=
 =?us-ascii?Q?ju29BXWss4y+YoQhjAQXcIY4tlOv9D6lpPDgK3iucH5kP52edCx2Di0i5N7I?=
 =?us-ascii?Q?N1d7aU2OLqLyF1rakj1Zd9NenCakQ4IwDezyHn/yxphEOoCOYBQ2aqXHfbl3?=
 =?us-ascii?Q?OvNMQgsyuE59kJNP+TQfADtIW06QA3hP4SQFYDuilS/UBs1BYQl1u9D+cNHB?=
 =?us-ascii?Q?wwt3GzTWfCxTa0zU8r6QVdpoCVz0Uig+xpH9U6Z0OA1jbUulvY5+DbW0axQg?=
 =?us-ascii?Q?yOFIZp7Rbw2CyZChEjpFmx4cGp4tXfmM0OHQzzfEUjlAYbNsxMeeRhHK5zsr?=
 =?us-ascii?Q?ep/2qyp49aqt/s13l32dccjclbCTY0LTOrf5f60v1DC0cV5napv3Hno+XYq+?=
 =?us-ascii?Q?MEJQBuvpCFolB3ybzHRFGIicu4BVcXzoISt8pHp218PwqUSjyQ+nc2ChsCVC?=
 =?us-ascii?Q?gzR6XcYeEMOkRVEJ0spPXz3PynlpXhqppXy/0GemDFOxNRsReYWcOJ8LHs1F?=
 =?us-ascii?Q?0V26UUGsYD0wh3XeB7zg7/157I4nxoIG53pKnEyuRUPbacTydiW2x5qKufbR?=
 =?us-ascii?Q?vo0UjLrksxqCMYiAZNyyAFgPGr6ngBEafQkIB28Up64Hfs07RKZcZBDJZo/N?=
 =?us-ascii?Q?HgKcxmYVsSgpd9ZXMrh/rndNiGLph18ogHjkVo3ZQh2DwCWiS/yjxpsGLw9u?=
 =?us-ascii?Q?HurGOpw8gSDxxCNv9eWIc5wUwnWL26JmnDTA0pDNLzkplGend/EpLF50RL77?=
 =?us-ascii?Q?+OrUrmiirvTPdSC4TxnOBBWbYQG7+KOuVso2Z/CGs3a5rpyzfoH2JP+6Kgf/?=
 =?us-ascii?Q?TXr2AnLW25qrLd6nBweVzV3bxk45BlZLPs0s+fWkVt9vgars5lAavBQjPwpA?=
 =?us-ascii?Q?SXRE9oZZZCNmpHL9SBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PC/KuJOlUVQQN24UhUFuLYc6WHjepyVq3+/XG34Uey0rg0noMLDc6Sup7Rm4?=
 =?us-ascii?Q?CjNxjhVfqRxFoH/O0gkOG78etDS57qfCJTn0vqjpCarPJf6pmX2NCYcfP/Xq?=
 =?us-ascii?Q?j+HF/3ww7zsyoNIgBCk8avnCyDRUFbEOryfGrdFpTgr04ow/RsQQvrM09kPs?=
 =?us-ascii?Q?gzdKNsIr76IkxgvCU+OzyGqREa/xls9SI/dlAR3gOcWKwuvJdt0xwZg2Gby8?=
 =?us-ascii?Q?exUKqKtLbJyys/m7CMje+WPlu1T08bbkBf8/ThvZBDLl1QJjnfvQE/dCxyR5?=
 =?us-ascii?Q?toerZgzMijJVSbPm469HbIZbK6mtQUReHH9al4d+NNnzZ9wzJJOsJKOHA9Rc?=
 =?us-ascii?Q?L9MO8mA2VFsoRDR1s+Ly4aD1Qj8W1iZG6HfcJj2hltk4DAh3umI9C8Eyhj+K?=
 =?us-ascii?Q?cFMCkLdd3Q0ftlr26cAVG5hAEtQUsuxfKe66Q4TFr0VHHoUoT4E38sof5Fxm?=
 =?us-ascii?Q?wqE2fQtH8ijnfRF/3N8mRPq/qT0MUt96LCVX/4R9TQGf4RH1U/ZV+AhyF4qC?=
 =?us-ascii?Q?SNDNPrAXWa3OA8t6XHWhtWWAtzRKLDHVP7Rhq+6o7xpjQ/sGusO2YJhl5ScD?=
 =?us-ascii?Q?WruUdl7HVMhykU9zzAArQQeUd+bREbUPMhQws4qcfoS90pDu3KTwyd6eWC11?=
 =?us-ascii?Q?Shb1TPcnQsh0s8IgR4Iiw0ebW3hKeiBJKFVsSCfpJaIbzDWjYQiNQfK4oXIL?=
 =?us-ascii?Q?MVO+raoRUA5j1Dla+J1AAxczgJAytJt/nhLHS8gOHogHz1lIhj7cMWpCnD7Q?=
 =?us-ascii?Q?3wAk4AUrHpnwnjtEwmj8/n0/ZYV6m52zZ4opuoo4OlsbEDXTJQX+olsvjdZk?=
 =?us-ascii?Q?2a+BP+cmC2UVeWRSQvb3tlrNyj+Cge124CTjC/P6lwxzH91UYwzp9lAGVZcE?=
 =?us-ascii?Q?shlJfTOzEgV+sSRfMN0c0DSdGXgoJ1hk7gNAnIaSYdCHxLUAdb9jgc8N9wQX?=
 =?us-ascii?Q?LHUC9FgRKgPKnQrepqevR2uOkUioU69xLP+HmD94hrR1oDjxA1IKe1JamUKH?=
 =?us-ascii?Q?slCQSQn2r6TTK0RrJi8PZ/+GpM3Crw1qquMxXp7rEeoO1NmyPdjU2E5rDYAJ?=
 =?us-ascii?Q?gvM8oYB8PJrBDWTHNrz0All+94ynDTKgiK7o4Ep2gDkDPJY9gYLEifcyAqs4?=
 =?us-ascii?Q?rPjz5RutEhq0RLWUWO+EJBDMm+eJO4czTnZYLRare7D1tzj4z8Qa7I01b5zd?=
 =?us-ascii?Q?eNEc5GYk2V+XKqq0mPM9WL9+GHk+324vxwPjfnWHGznUoWJogDY7RwgrddxU?=
 =?us-ascii?Q?vDA+o4rtZJUH2Yj4EMI1p/c4PlcvNTS1GDnYEkPrvDp5Z9uA/AeTwN0t0xPP?=
 =?us-ascii?Q?lP8UZGnQGCfKrENCOYSoJfbyzwghpsgLPzVMUAOKXyppcc8yrFPE3LtsaPaF?=
 =?us-ascii?Q?iQS0oNZEqUuK3voFrUDdEw3bN2y4Pa5cSFufQ6MKIWIfsbmhg58bk0WBm7UX?=
 =?us-ascii?Q?EEekB2k8Fao9MMSH5XOeO08d9qwEsM91legy19NKN71xjm4Wm195YJdXw4Lx?=
 =?us-ascii?Q?92lOSuwbVqZG95WJ+8ckGFXf/4e39/75DdFHarzQcAexUCqjVhlYXP5pR0JU?=
 =?us-ascii?Q?1dfANOdDWtBI5YwDZMuP5ccCrIi2Ymhsnq8AQ97pYYVJcmVyfcgq3IHGs7sU?=
 =?us-ascii?Q?YwukaX/EbL8Ns1TzcrVBDBrNLF782HxPOTRbw3FfgjXsaVBQcdgoMXEZQaeH?=
 =?us-ascii?Q?TWi4zD24MdHxjewLIxg7sf3WDsPftsFK2kAEfY/lAL05lsvv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd372b4-0cdc-47c6-9959-08de61722783
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 09:13:25.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqOPTzpEEZauHsGjX6eSJYK4o0UZvPh7tQnZSaUnR1HGaZUy1k5lyFx4R/DzQkHawGpBoQLjEjcHHZj/4ZUJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), by guaranteeing that
each task entering the BPF scheduler's custody triggers exactly one
ops.dequeue() call when it leaves that custody, whether the exit is due to
a dispatch (regular or via a core scheduling pick) or to a scheduling
property change (e.g.  sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

= Open issues =

Even though a few refinements are still pending, I'm sending a new
patchset, so we can comment more effectively based on the latest
agreed-upon semantics.

Open issues that still need agreement:

 - Should we trigger ops.dequeue() for tasks dispatched to SCX_DSQ_GLOBAL?
   (do we treat SCX_DSQ_GLOBAL as a local DSQ or a user DSQ?). In the
   current implementation, SCX_DSQ_GLOBAL is treated like a built-in user
   DSQ -> ops.dequeue() invoked for tasks dispatched to SCX_DSQ_GLOBAL.

Changes in v4:
 - Introduce the concept of "BPF scheduler custody"
 - Do not trigger ops.dequeue() for tasks directly dispatched to local DSQs
 - Trigger ops.dequeue() only once; after the task leaves BPF scheduler
   custody, further dequeue events are not reported.
 - Link to v3: https://lore.kernel.org/all/20260126084258.3798129-1-arighi@nvidia.com

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  76 ++++++++
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 168 ++++++++++++++++-
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 234 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 198 ++++++++++++++++++++
 10 files changed, 686 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
