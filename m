Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315ED3242B8
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778453025; cv=fail; b=fXIDygG4zcopPtdHQUhhqPrdkEKsgwSqK/Gv+q1lLIdDT34PjVHEDTbMk5lBYLkOW5Ma6PcUZHsAqU+Z2bR0jkASp/eTU6IPF7xKlkrjUL0DwEIgS/C/Dv/+auOzQw9M8iawSnhExYuq5l7XwsFY9PEXnWZN+UizHvHbvL14PB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778453025; c=relaxed/simple;
	bh=1Ctfrh8Xh2sXByvM3k/0A/3D/w4pqLLdbxsDdxUT/LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iNr3DQXFFCmazzazahAbe/tkZpojfOyq1pRPO2287YuBL3ECKKX2Y69wtalB6XaZZBY/NM3Cgmk3S7ViYTiFZ6ERnefkdCFLOxZQPsO0+5zKYrJaT8+5kI/LzqNmxJkmwr2x32QlvvPICzs6vluxEwyti1Ci3PY+ITI+M4EAf68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iACEzBJ8; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iACEzBJ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6sat7z1kVvNRvn3UPiNtsnaH23Mta0Hfej2GSdXhnf/A06EgY8uiNI2CBosyAcBm9bI/otNBZqkCbLRaxl8EBu+WUm2gzhLn2IHXWa+KoKabY1ItEaUFwdWEIe1ozsA+UfyQoLrmWtvOaXtbPrV06qUU1A9cQe/4gwXxu8/0f7xbvwH4klXGo5mrEFKoFtgjwqLEh8W4zdUkdo/UFqY6uDOrKe5j8nU53me4dAd1aSA4KZ8kkz1/lseworhiEcSsRSYWIHcwfyj8THwTlPoFhucjLZmc4aWyC7u7douYaCdqCcnTjrvD/olFPOC49K7JbyEFhM0f5n9EqULe3E9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRJ1Uj+JncKMut1g/wzyBjOSKpXraFzPuPg8lJOi6LM=;
 b=B4p31YvL+eCjSfSqEp+muX7/St/VBEDAyFJVUXfDdXuznyyZenfkJwYaigD+qxg1SGS2g93SlUQrrUW9TR19HTBFxv6g/CdCmOun4WS/GMj4eW6L3JHzuFSFVJNhW90IPvSn+ANwfTL9evKaUdDoTqmzdVfQnwXMeBvmfs7OnRC8lS0hC74FS3gf1MYu4WR/QIUHsczBcBp1hwZc+Fhbz6JlTFhxqd3NWyiiHtf5UOokGmRraXGnB11ES9GqtEsjE/8qCWUUv6KkaT9MZy+Xg9bBUdHL6/HOLYslhdmNhqoaSdQFxpR9t3qkwh3BScB7M0UR5AqGHgejw1NodkAmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRJ1Uj+JncKMut1g/wzyBjOSKpXraFzPuPg8lJOi6LM=;
 b=iACEzBJ8VSsE1wXpPgbWih4b5Cfd7uuJzm12Px3aLwr67gLSeQkAoXSwz6fSi1Jl96R5f7+WVHQoLb/4aloc8f6gc58dlk+DGboDRi6TnE+VEfoahz0Yth3+FCj9gdBaIEGMoFUh131/xnle6lImeB6g9Amxe2ahb5WjZnzIrvP2azVafRo8KTKd/n7HpVpcTSdwAKXA0UHUFLOwXr/F7SFtlL4778isUIx4uEhsAFJJ6i/Bk9PDxztUO0/dXtaWLuBQXwzTmbxAHTmjE0Hbk5zii0niDOeiybhlPOJUf0yMdNlsdjIossSAXfJHXawLYd4V2bbecol1kzR/ZHFT9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 22:43:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 22:43:39 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv NULL pointer deref in bpf_scx_unreg()
Date: Mon, 11 May 2026 00:43:32 +0200
Message-ID: <20260510224332.2011982-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B81.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::418) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 1608405a-541e-4267-433e-08deaee5942c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HrmdKguS0Kfrzzz13UR8J4hgS09MHlOb69AfUJoFJbh2BkE140pU3ukRV/ooYGr10Cc/qg2drXIUlYh/VoM1XgNqMNh7oqNWnN4OfjjlcOBdkGKefeZ2CI0XXNqP9TYa/dXfOK4htzH92vyKUuqnPew2aOS6zUKBb0eB/79r6Z/rtwLdCAa21tQjvVTwtVXgh54YE2JjUwDhAsSiRTgQcajggspyC3e7H8FoJ4GXCHQw+allDexXwAQpwnlxlhRwI8JEQri6pqt6SxGhlb/PLP9u+LqT/oXU0/UxcptzZFpRf4DQFZKvjVk3lBCatpkLXpfEIBzVlOtXyh703uKm8bZprbB0++zTg3ND6LZLCkiS+Ftc3p6qRUb0+4pxTLV1sYwEV3e8tRRJ6PtvsM6CXkrAnoi7p1A8BjEj0eaTW9Q5GX/rqsJH4IYwsKxrPgEgwXOoYZpYkUWC7krV2pwwwa2yRn2knT9J/NxRmLk5kNJFgROMD0Ppo0/ZLrLpLATZWuepXGrZKLGFec7h+YvmLU60sR5xWyk0qbtmVP3NtjNXIAamniuSpZWyLM4VVLDwo3aaV9l8rFjOH6qfvJI0Bz8o7Vi7EgZLhq3cpc47PKSkuGB1qoeJorLyXh24mbHQiG9lHqiXyvC7qofngo9axSykPGg83Ft4vUu+0E3HOB0GZ0KXpGJ79r3tC+ZKrQGa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWUXYZz54h9JOpBKs5d1sweaTaU3e1ujTYP5CIIU4KRzmR2szgwlUcsO0Fdp?=
 =?us-ascii?Q?WFxjrCDlOpqT2S1wCYgwoRx6fP7b7awxxakkgkRiSRdTmvm+HnFwiwagvLpR?=
 =?us-ascii?Q?mfqs8/5ksvXSCi9KaQ4wnRMoWCwRplw/VJLmHaxsgOJKFQINzpJKxTUzNdkt?=
 =?us-ascii?Q?2ENEo3bCSpWzd23HrcQahs1nMVTRV6+3d7uowY/iEmPuFgq2z3CdZ3VSMdTH?=
 =?us-ascii?Q?MRChWTgQd5zk9abfjZeIU4QSD1HwDg9jVrv+efwj542rwL1eIpP8Ax/ayl5x?=
 =?us-ascii?Q?h1kBXhr430fmNOxLzkZDSc3j7tI2Xf9wVHY4crRs9Ei4vnlajPm4AWQpWWIv?=
 =?us-ascii?Q?5eI3Bze55vpZw7seuO/bezIjzkbegA0qO1rEbChU/9zEinFh9QBZdtB59Ni+?=
 =?us-ascii?Q?ivPyKcs5l0h1uzFG414uN6BUWLYhKhaPE9iWhqsxAFCF1XmtU8sa/J8Mvb9A?=
 =?us-ascii?Q?3KhNOt1PTabqACT5kWssbfYJ2p7DWiZYAyh/yELmfbY+OthViD7wCmONTFny?=
 =?us-ascii?Q?fkYr7ncfDBsrw0f/6D4qIKyollcDI+H+119VKuc4DAs9IxgkShhs8/TRURnN?=
 =?us-ascii?Q?pniK8sRKcOSrUG1AnAlXtnYiw5eP+DjE2f8+JnkkNJz1EZiLZ0hOkMRP+rqi?=
 =?us-ascii?Q?W2hfeSxXNEyaoTLV8eRbtjCXIbTj7DUlA92ZjjtyiKKj0fYOaYFKMWAvQkY4?=
 =?us-ascii?Q?4KZkN5zN7xSCy0bmUDwTDEcZghkvAOZu9YhEfoL+pXkpzRqnjHOLGn5GD+RH?=
 =?us-ascii?Q?Xo3mvZBGuQT26EvnP7jCjBUDdKvK45WyNzLfYaDaCZ1OQdMLxFULu7Ndin2F?=
 =?us-ascii?Q?GANRoy486YEHsBypWa6ipF0gd/1DOqFo81PaNQdMq85szE7JGxfGxMKI5rGd?=
 =?us-ascii?Q?5ylKph6BOPMRh0RMXitTwH33k/IntEQHFJyQmIXJ+m8iYwJRJsXFk5As7O9c?=
 =?us-ascii?Q?K/sGH9vsQXn5yuzMX2ld1DL5zxm2h7q9Giqe6s8qnFDTkz3RIeXZMR1EwK6M?=
 =?us-ascii?Q?fic1vJKBofvtIGl5SQu8mNqXUgF/g5swGRroG2jg96Y5TIutSb2bUqd9U21/?=
 =?us-ascii?Q?S8U4Ci88o0EmYCj5A0esrqvqw7nawD2fGYiozSuTYaKT/ymlB1slR54v317j?=
 =?us-ascii?Q?LagBcQr3unQ5iNKr0ZJphUp2MtgtdAElprhPK44f1BdSOkzQEexfbBtgbcYw?=
 =?us-ascii?Q?Y9aC3P4ycjkWQsOaSBd+fepm7rN6hPdgqPuwCns68Xfs6L8SIQZ6dNIFgEgf?=
 =?us-ascii?Q?o85cEMk9ZPVdauCj4aJ7RebFY+h6/nUsdrVinJQzvDqDYoWH3thv6auQr6Fd?=
 =?us-ascii?Q?MWz4Ve66bynbuGRiaSBV6FGREVAXRFZGEyM5QN6c8PPJawA78ONEdO3eixz6?=
 =?us-ascii?Q?l+Vhj+b/QxsJf9klNb7huX+VMiqYUJi+JKWFOw/CeAztJyZeyhRHFrWpAvrU?=
 =?us-ascii?Q?vPK5VB5rvCcGqHivVoU/dkdAiUe6FIdDOXw+ixzmfdz19HL1/KnFKXpTL4xU?=
 =?us-ascii?Q?SQW18eYXoNAL37QUTFU84UyU7D952ZUmu16c9KTd9xNKdRS4TE0Q5sSR0vye?=
 =?us-ascii?Q?4wVuh12TAwzbONT53Re9iJjRpUKsytjwJbpLx83ysVb+Qec1nU7UCN3A3EWY?=
 =?us-ascii?Q?XuiS+9WL3EcdNIHzq9wJYCN3GdNdYEWjSBrSaG5G4UwEhQblGAWEphu/GRK/?=
 =?us-ascii?Q?2EwmYYCKxYh88g44+P/u3ctOFQaKy27bYhcoQNv/K4O/n0Mo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1608405a-541e-4267-433e-08deaee5942c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 22:43:39.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdUr2XnDOQKCL5G55oeHV7qAeftU5l421N3NKQW1uVRQnq6GDr0o2yBHgjDONPx6UKcINJZB+UdQ5oUKRtUfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

Under heavy concurrent attach/detach operations, scx_claim_exit() can
trigger a NULL pointer dereference. This can be reproduced running the
reload_loop kselftests inside a virtme-ng session:

 $ vng -v -- ./tools/testing/selftests/sched_ext/runner -t reload_loop
 ...
 BUG: kernel NULL pointer dereference, address: 0000000000000400
 ...
 RIP: 0010:scx_claim_exit+0x3b/0x120
 Call Trace:
  <TASK>
  bpf_scx_unreg+0x45/0xb0
  bpf_struct_ops_map_link_dealloc+0x39/0x50
  bpf_link_release+0x18/0x20
  __fput+0x10b/0x2e0
  __x64_sys_close+0x47/0xa0

This was introduced by commit 105dcd005be2 ("sched_ext: Introduce
scx_prog_sched()"), which:

  - Made kfuncs look up the scheduler via scx_prog_sched(aux), which
    resolves aux -> struct_ops -> ops->priv.

  - Added RCU_INIT_POINTER(ops->priv, NULL) to bpf_scx_unreg() before
    dropping the kobject reference.

Under concurrent attach/detach of the same struct_ops program, the BPF
program's aux->struct_ops association can resolve to a struct_ops whose
->priv was just cleared by a concurrent bpf_scx_unreg(), or to one where
scx_alloc_and_add_sched() has not yet completed rcu_assign_pointer().

When scx_prog_sched() observes this transient ops->priv == NULL, it
returns NULL; kfuncs like scx_bpf_create_dsq() then return -ENODEV,
which causes ops.init() to fail with -ENODEV. The failed attach enters
the disable path, and the subsequent bpf_scx_unreg() reads NULL from
ops->priv and dereferences it in scx_claim_exit().

Fix it in two places:

  - scx_prog_sched(): when ops is found but ops->priv is NULL, fall
    through to the scx_root path instead of returning NULL. For
    single-sched (the only currently supported configuration), this
    recovers the previous behavior; for sub-sched-aware schedulers the
    existing !root->ops.sub_attach guard keeps the fallback off so
    multi-sched semantics are preserved.

  - bpf_scx_unreg(): guard against ops->priv == NULL so the function is
    a no-op instead of NULL-dereferencing scx_disable(NULL, ...).

Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          |  8 ++++++++
 kernel/sched/ext_internal.h | 16 +++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4efe0099f79af..6c476ec5dcbe1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7608,6 +7608,14 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
 
+	/*
+	 * ops->priv can be NULL if scx_alloc_and_add_sched() failed before
+	 * assigning it, or if bpf_scx_unreg() somehow re-entered. There's
+	 * nothing to tear down in either case.
+	 */
+	if (!sch)
+		return;
+
 	scx_disable(sch, SCX_EXIT_UNREG);
 	scx_flush_disable_work(sch);
 	RCU_INIT_POINTER(ops->priv, NULL);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a075732d4430d..e468a7401ed83 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1433,11 +1433,21 @@ static inline bool scx_task_on_sched(struct scx_sched *sch,
 static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
 	struct sched_ext_ops *ops;
-	struct scx_sched *root;
+	struct scx_sched *root, *sch;
 
 	ops = bpf_prog_get_assoc_struct_ops(aux);
-	if (likely(ops))
-		return rcu_dereference_all(ops->priv);
+	if (likely(ops)) {
+		sch = rcu_dereference_all(ops->priv);
+		if (likely(sch))
+			return sch;
+		/*
+		 * @aux is associated with @ops but @ops->priv is NULL. This can
+		 * be observed transiently under concurrent attach/detach (e.g.
+		 * bpf_scx_unreg() clears @ops->priv before kdata is freed).
+		 * Continue with the scx_root path so single-sched users keep
+		 * working, sub-sched users see no scheduler.
+		 */
+	}
 
 	root = rcu_dereference_all(scx_root);
 	if (root) {
-- 
2.54.0

