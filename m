Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE17264A7F
	for <sched-ext@lists.linux.dev>; Sat,  5 Jul 2025 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751694246; cv=fail; b=cClESd8Qcb8IqjjquNtuANras75CsLWqHb04ALq5nWjeaMzJ9S2vTtf4BHC7byAO2IgQHXSEJPt+aYvi7+ti7xDSWi2UtvKsgjr2IH5Rb9dgoCwXfG7FDwV8A8CNCjXvv3YhbkVfxvCtKdfdJhFbk/gZk5vgIpnnIaemheeWIJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751694246; c=relaxed/simple;
	bh=BcvRKS7k6GNFCQflER6EId7hQ7maZnIsyJYs6E9bqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nuYf6SEH/YpY7sVfDT3Om7/OdAGs2HsWwCY53OaaDhA7sGmwTnAIt1Gu0UFbhZ0KPObAK0h6mCOM/g7AjWGTQwcYTyBdJltcVizy/aw6UdwK1E8ZLDNE2HxiyaPTTlRxe4Dj7sdcppLlqTaiX5cR8ecfpnCJzLI8bOgNGbep/Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XD5YUHIp; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XD5YUHIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJKxxUgsf44Gyg4xP7caKrpBXzxlbBN6GzsrmVXJQDUJmzpTI3OeYEYkHsb33L3NryrOqgAIuxHO1109UuODm0M+P+/GQ7EBokjR1RxVTvc0N8oPipW3wWkShlI/EK3zO6Rc9nX89IXxOTk5CoRlq3XCrZJKgl2nL0T2HPsMJ6irA8IZx64qlfszwArJ6YJyzjIBbacar0iG3zigflJCPm1EuoGhXMxwvYpfZBQlK5RsdJ1FPYk/tj6WCiWcT3aSLEEVKT+SXP5k3SJhht3M4ol1SAfBpXs9BbcPHGKtihEl9I5f8/7GGN9mz5jdIw3BYQxNBbmzSxnPhkRdYvsWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nutTncCcekddzRZjhgurPATvLi+Ykw/C8LylCAQAUM=;
 b=TQ9OCslylXBDRWHTxwBSaaF8nrOmwAwP6Vr/FSBkISJGEJnQ/bauo8kdyOnEU44b43f8GIfP4WNbaCyeCPUbmDJnCMsJjpHYrRMJCoWFL1437mupEnCN2kSQysSmo2v5D0TJBaZf1Yf6GdePXWTgVe2gbUcsEj+WJvhd6RpDsg9PpByv8yRj9RKOupvb53Fb8x7OeXSEd63MWJViwaG0iAG03hFYaGfe0bqYrhpg/vyd3cTx5Wi6P0/JZ0ci0e1M7Xq6Uul00E6BsPTYmejlTA5rpWwQ59duN7PJ/tpmrqXp2evAhPdMSfeQPG+hniNlEUIEo06TiBO+ge361UYw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nutTncCcekddzRZjhgurPATvLi+Ykw/C8LylCAQAUM=;
 b=XD5YUHIpJFr5kKF98pW1NBB+zGiRFQVQYz82J7xcoHeawsBHC0WaLEqyVoWIP6W4bO5gGund5QGKqAAI9K8Oxj6OAnK9laDBKk9IlX/1PcijgCEFW+n7hHpQ6z8SX/NQskKU9ZZtRWzY2pczj0Obgo2kVOy7k/jPVcyC3v9GoWEI7X7xezNvnw1JdFOeBUhBhYr13r0g6pTpB8orRKnEg1QswgUkykwuHXuzrSvSQRT75y068eW/cJLnwwpN7D1Ji0xyIKjpgqru2M6I0FwkOiU619ktM43wXNBwkdZt9FDdGzh1wmCpWWXp9tFHKOlLFlmFiWaT6MBTeHPiZXQV8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Sat, 5 Jul
 2025 05:44:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%6]) with mapi id 15.20.8857.038; Sat, 5 Jul 2025
 05:44:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: idle: Handle migration-disabled tasks in idle selection
Date: Sat,  5 Jul 2025 07:43:51 +0200
Message-ID: <20250705054351.332038-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac2036f-f616-4723-0d41-08ddbb86f1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jXw23nrcmzw35U2wgwfyWdXOk8bmZfKIc2M91gcL0CKNFTfLC+nopnRQzP6?=
 =?us-ascii?Q?BAeBR+FvAuXOWDxGj78Da9V+9Mz9dM9DFMSu4ELLEBKnCUrRw9yf47dtMzfg?=
 =?us-ascii?Q?B7iYP6JCHFTcfEt6NdsdM9S3YwJg4YHinz9DSpTiaDT5c55pehEO+ys856GL?=
 =?us-ascii?Q?Psr0XvqaSAH4na45gL/zpttfNZ4ZiFozx5utWiYbd1ooiH7nBi38pvtS2c9R?=
 =?us-ascii?Q?LOuUJ6ZYUdRUMxn9hx/p4DZn2CToriOT/n3hyU9BB8fP1de0UZJxZ7iHBiow?=
 =?us-ascii?Q?1udcDIyU/V+YQvcJZ/6q7biwes95GeN6JyMbbKs8mbwHXSHWs/OixwJCnTFB?=
 =?us-ascii?Q?gHT8pUGWJn7Go2djlkO5rx7X/T3sFaJrWBtHlIWloHEFvtkPTO5vXTdhE968?=
 =?us-ascii?Q?5ruf1j+nnGnH2fv7Smxp7S0H9Zi+XjNczFb0RkTqSq/439Pu2ZhhCYs69eok?=
 =?us-ascii?Q?/14OTWJ/Q9WlvaCUpYgyB9UawwxZ97xeCC3JiZ6dIxI/FrtgNDLs5d46Xn4v?=
 =?us-ascii?Q?zcJeE6C2GyC8u9uX16w61naMdlI0EsOHbDaOOHcCa/cl5rQLLIZko+0GAGqV?=
 =?us-ascii?Q?S2rGkGNt1+pWh9UgHUqvLzJR2umo4uc4uIzmcX8iGq3Yg2dJ12bT1WYNDCa7?=
 =?us-ascii?Q?buixhdGoLNY4gXAjyTPWsYSHEH+aFRQRDffuR5QXpcZ/MANQVSod7U4qeuxh?=
 =?us-ascii?Q?dW5hrXzCcF3My/KO4umMLKilWTwKgYtDb6qtYeDwPWIQrBSlKVq4jOA5n/FK?=
 =?us-ascii?Q?cL+E+XXiB7K19WhRUuEw0sGSjgDEz2Ia6wLGohBRS8/ouUlxKGp+Zz57BHS2?=
 =?us-ascii?Q?/Pc/1S3HzPsot6gkmnyTGrQQcx74XhW/1KjYqDadJvMJX1nlc0Uh5ToJoLDZ?=
 =?us-ascii?Q?6PKlvl8MF6nFwS6qlK27pAhlDzhkybDyjt+E2hrsnFYQzYDAekAR6rMOSmSt?=
 =?us-ascii?Q?sngqj2xnnlsunkPTgKGRkRSFV4Ob+LmrD0giaoLNfdvcfa/C15noJKXcv8fc?=
 =?us-ascii?Q?YaWfnYq82MSXzTXaHpw9aEqWf2mWR9lKGAMDzpVkiZumqyHScedukl0sjKlk?=
 =?us-ascii?Q?eLS2UTkCn7SCN+2NPe0HJEu4ogaSnDVbpnX9zlsntX3PKlZ4mJF6ZymeGqG0?=
 =?us-ascii?Q?B1ySzekp0+dc8c2P+e4sc0zlQU+SwH78aQU7H60LW18aE9N1xmIRimSjRc/a?=
 =?us-ascii?Q?JiQbCVel2KA1WNG6EFYKty0W8g1DUAxKgVjWKyeBKBNop1TUsAzD761BDuwQ?=
 =?us-ascii?Q?MI7bBhE8bDD6l19FTI0kH7y98zmss1+lXT9ARKpY3JL7ntfnSbZ26JMYtFTL?=
 =?us-ascii?Q?SE9LJ3NufCirNgjC+/u/uZWrLp01fceeoIX4sMaVwteeh524S3w/ToI2TBMh?=
 =?us-ascii?Q?wgqlcmkvTBrJ1vmJcih1+YUQpZlY0UL1qqaD/+UZugRL0ft1cMOdAZShwTVQ?=
 =?us-ascii?Q?+CZq0pB8tik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vY0Zr+D/ZBdz3R5mU3d97dzgegKXckoukWFita3icl67n0j/Z1oQB3u1EnDa?=
 =?us-ascii?Q?9SNgfuFHcxS4aMHAh3zrDsychKnQ27Qu4MzHEeesloTJrbOni77gXsOjb6xd?=
 =?us-ascii?Q?mr4weTucUDRqBZoC3qUAjhroxz2VtyXeViZzql0LXWxEzqW1r+rWmFMGPYQ4?=
 =?us-ascii?Q?/J5YJPQfxOzvisXaNJcM/lvEhs2644C3uMBjCh5CnpvzSarf8Z43UTMJKBvb?=
 =?us-ascii?Q?hTUL5aJt8g+r9dVxBNRmrKbA4v49b6ulu3pigy/NDrKQX0AdygXhusucbXMn?=
 =?us-ascii?Q?NXUk0dqJfTki2/btDX6xQWKIDR4axK188GWuGyVqaNPIyUcEndwAVr3pQYdR?=
 =?us-ascii?Q?YIgDWimi+BVL7o7zxbpN5JpVEDi4lPHx1/pCOO/PT36CL7UEPZx/+CGdIgpo?=
 =?us-ascii?Q?dtT9G/B53AaPPXHUW6bPXUlU+mEE91P3OACkY3ajyvwC9oDZb1iKDuShf2EJ?=
 =?us-ascii?Q?+sFLaYmlxnBkdQZiQyCCSC9V3AWeoKtY/RU9rBS3zvKnh0FRL2ow0gS33h7T?=
 =?us-ascii?Q?vj215S1eWnS62RVpHWn79Aq4pEuvreteggnSF/zZNnUlDkYbgb20KA6BMxvf?=
 =?us-ascii?Q?lOxinjhpadX0YaGhY5vnn0cLQgVOeuDtoX+Gp4jDydhxojSOGusLtx4zemsa?=
 =?us-ascii?Q?57RaX0sDUHx7PAC59r8KAot4uma/mJBAobW0kF2zXiH9Xep7dF5bRsqWzfwZ?=
 =?us-ascii?Q?je48ahYV35pZm6ezuE3KDMX+sWr0LPskTWGW8Pub8I9tNUt3bleGY2eCw87I?=
 =?us-ascii?Q?ovn5nQxt6D9njN2RVxpv6wF8fIi30G5OgureBapgzX8+c+ztjrK7dN2IOTB+?=
 =?us-ascii?Q?/FhNq8vNHLVQoHeFp0lbvYZYtC3fcJJvyXkmVLT2BduR7PB2mKxelp5N7a69?=
 =?us-ascii?Q?mRuRxhlgQyHVc34GJX7F6TbRiaRmSvhP+b3TMRg/JM6Fyn7hOYkg17KEP95g?=
 =?us-ascii?Q?BHCefQ7OR+ggEVhmDLMdadV1w7Z1j9brqyPbJ5ZMeAEc7NFUmdLeHjn0zfYI?=
 =?us-ascii?Q?y1qGEJqovUZKkibqgxO0KvCUSJnzXcNHGK8xyHGlOrmGC58Ai2lOrGtcf2Mw?=
 =?us-ascii?Q?cutGPTvWu4xnlQMSCHK91pbjX12DcWGT06kBGS2VAfeZ5RtGClZ1QRnskUOS?=
 =?us-ascii?Q?/Ee4veqDhKbEpKAEnUxgBqT3TndD1Vqmrh6gOHNECE4UTVrLZx2W0pWmm2sc?=
 =?us-ascii?Q?zbMUcxfC+VcTjqhUbyHTS25UFj+QUM7qF86dsV6JSwcHFVc9j0DdUrI+eUAH?=
 =?us-ascii?Q?uXN/yxPZBYN1W7/tKV0CNrVZUqEomLhB37fMX8BSAhxdFczlzE8Mmzeuu/qP?=
 =?us-ascii?Q?6nxZjnjDbE349NrWjI2iThSxkXxIcwug4RFC71UE/7qjW2PXfH+rkbCmdSGr?=
 =?us-ascii?Q?DEFB/NXKBjwJIzPaJ3B+2LMGkuwDSpCPGmfBMkH7Xdn6FyLR/EgbZ0IDtn6v?=
 =?us-ascii?Q?HMoZ5knlolvZVgLlNzO/mbUV9pL84WDYCkuZLdvyIYXw4zdRZVC+EqSCIhvU?=
 =?us-ascii?Q?edftBeqN7dGUPBbG2+IdCWnUVhYoIITHghu+CM1ETiqCpeJedsvcJZ+In2yt?=
 =?us-ascii?Q?DU7zHqn/6eOyT5RBgJltvUqM1k5Z+o6H5IeYP43m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac2036f-f616-4723-0d41-08ddbb86f1b8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 05:44:01.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CVCvpBnjTEeN5ivHxm4dEburyMLDjX9oNNCdQs9W4WIWHe8djbNWEPNRF+ZBRxhUm+NZ/CmPsxG9uZVtggocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

When SCX_OPS_ENQ_MIGRATION_DISABLED is enabled, migration-disabled tasks
are also routed to ops.enqueue(). A scheduler may attempt to dispatch
such tasks directly to an idle CPU using the default idle selection
policy via scx_bpf_select_cpu_and() or scx_bpf_select_cpu_dfl().

This scenario must be properly handled by the built-in idle policy to
avoid returning an idle CPU where the target task isn't allowed to run.
Otherwise, it can lead to errors such as:

 EXIT: runtime error (SCX_DSQ_LOCAL[_ON] cannot move migration disabled Chrome_ChildIOT[291646] from CPU 3 to 14)

Prevent this by explicitly handling migration-disabled tasks in the
built-in idle selection logic, maintaining their CPU affinity.

Fixes: a730e3f7a48bc ("sched_ext: idle: Consolidate default idle CPU selection kfuncs")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 6d29d3cbc6707..001fb88a8481d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -903,7 +903,7 @@ s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * selection optimizations and simply check whether the previously
 	 * used CPU is idle and within the allowed cpumask.
 	 */
-	if (p->nr_cpus_allowed == 1) {
+	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
 		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu))
 			cpu = prev_cpu;
-- 
2.50.0

