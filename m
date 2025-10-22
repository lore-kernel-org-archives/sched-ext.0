Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18532E146
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147394; cv=fail; b=YdiZ2KfeETUv54HzKOYafGoA5qHCir2RB22zdLq+GjKs3YCC9XFBxOSA5X88XpDG9dPfsjWZP6lNGN5OFnNfYnnpvxW8/p3zO4IZ5cC8Tsy04MaCpYkyS8H6B43fdR8PnmFTRVi5dE8z5ipbwAZzRTimrIDf9flTr/YqZDz8t3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147394; c=relaxed/simple;
	bh=oZMEVLLOCXZq3mHzKLWmSEW2tDUtmcGXzLQaMDHSUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkBXvlN2ahMl0JGN7rv0RRQst4FckSYAYWSKK4hMuHOb4Di2uEiNEtb+MolHl7ILjyVKnVB2knlGF7mbEXfy8VQuFcKUhSpHE2MyGGdPJHFxlkvTNbEsmmaAaEWmTkEs8qxZJgDEo2TcKA7V6QbUAfXZoF9ArMnIU9RKMF6fSTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXy1jBCm; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXy1jBCm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhyPeiu+Jiwf3GoyVt1v5NUoBWpN9QZr/+sNwGMsM5OfdvAoaLeiUPNlYYmbVk/4zhQb9m2F833+DZXzGI6B7xuKcGmhvQx3bjTUuS3oFVHqXi48ioE6vya6iKcgsf0x00WE5981YIARd1rVg2hKQpKFJJzh0P+Mv2oAy1c7dqI4oJjB4gUToXP5/ApLT1m4Tu9QaQvbChJj+fDBo/TOpVDeS/Bmxp3+41OghU/yTo7slJaym1j1Wysc8+VKE3RAQHp6+Wej2Ufp97s4xPZY90shYiPGPQm5rtaGaCxDoUq8qgbQopO0h9i87nOxcRSkbyEfGDYrVDM3i9BmQj0f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgIVXuL4jiZO8VYi5HYJxJcXcF7hTH3zxbL8RhkBdaE=;
 b=mp6GE3vIOqGAyQoHYsBUXfebNvjJqcOx+opxuaAiLr4Rhgaj5xiM9VYKaRFWBs52vvaz5S0yUmCs0Fz5HrZQKhSor3qc8bPXuGI1LhtDZFfqHyqb3q1cZHlDRBDf/iJeEmcQ5qIgLdcKrA+sesaOeT5DEc6dhhTHf4+SkA03c0x0FGpq+GWui3qHw1yMhjgs4a3rHNyDDQHwV6kESDNlnaiUMYYOrMwcQKxafOWJ9YonOWrRoX1Ajrc2BDD9V7K9CGw3H5k9ieWsb5d/apKkD+1RkKKi4L7+mtmOTlISBzHbzdL8DsK7zeA2/G7EPcQiQL0KPUXbiFo6uwFtcziA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgIVXuL4jiZO8VYi5HYJxJcXcF7hTH3zxbL8RhkBdaE=;
 b=XXy1jBCmWH83VdbXvocdtIh1OFxOObxcdleINdnITV0tfndYN2DUPJlPaD/1GlZmLcxoK0S7/EQOjjb1S24sZjFgba+6FP1gdfKlJWUG3FUViG54zdsEW6mdUhAECpNpjsxdcI2E6EGtbIuRckyNgREHexjAb7d/+7alzs5hStLywwbLWz2T1ttfcYR/22h4PjtGuWARq6LiW1Z+3KLvbKlP6AXTKaTTRAEYaOvYBQVY/YB3kcJcj38mt647NC/fxo03zl7DBp0GnoN88RCOJ7caphTGgZZ02siirDDJ4GjmQlgVTi57VvNZMmbCOxtgUa2Lqo8TtMtns6Ek84mW3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:36:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 15:36:23 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.19] sched_ext: Use ___v2 suffix for new kfuncs and fix scx build errors
Date: Wed, 22 Oct 2025 17:36:10 +0200
Message-ID: <20251022153610.20111-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251022093826.113508-1-arighi@nvidia.com>
References: <20251022093826.113508-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e98c2-ebf4-4c28-08ab-08de1180c0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAqdxmJ3ftgw4iYg8/ShFAwKnuf0ym2/7F/Byocatz1LMsp6dUFp+MWaSgOp?=
 =?us-ascii?Q?91qSHqkUuyyZknd4AzbABXsTdrlFFSuDS65cvC6UEkZ+LHO/rxO5T9uizleJ?=
 =?us-ascii?Q?GXr7oMicJkHSPF22avGUZQntZ6BdA2+hprtxmj1UyWea8kCQU6cGQ7851LPP?=
 =?us-ascii?Q?cAV7S5ZCwdoc2PXmyaHFmtVetTuKn1eY/fno3MdgSGNcqAISAQTbmP75A+Jt?=
 =?us-ascii?Q?Bb0Cl/gkQsTt4YtelaAZXm6IIWOKHIMpI41tuFZGqowd7rUUGTG6W5yxHjrV?=
 =?us-ascii?Q?y/TOED8lRdbO0jVkI1+PdAwzfbjQrkQxp239CrHjSFmeRUlxtRDW3zEjk9Mn?=
 =?us-ascii?Q?5ihafQhmt/11z0en3QD6NCzv109NMAyXCfMeZEztNEXIrciVv8MxDgb34VXp?=
 =?us-ascii?Q?yDMyT4nFgP27KBYRM4hEBB7AEl10FH49ml/h9HEs6UJkFDi37tuyvzL3fj/w?=
 =?us-ascii?Q?Tk1ni5pHgbYyyoOViO0BhMQJq7DcExT5UKfYgMEJj8OGiBwpdFiNZ9dD9hj+?=
 =?us-ascii?Q?rB7PfAOAUldJkkTYqwJlAxNCbbthZbXooHc1pFDwmf09NFW0LBalfbzY+Rwu?=
 =?us-ascii?Q?jbAljQITzuY3sVWs5cu3qXXl5qDW6r/b1HsHJNFErRbmajdcCiulE8EEuavN?=
 =?us-ascii?Q?eMWQ7jTLXAe1Lgg063vUkyLTV7pIP2kNnQnr9SOcXDAgLY2Zc+nAXysCkASd?=
 =?us-ascii?Q?MyUJD0fpoQtIK83gDRUyCcl8TdY83lbKa4ZgA0FvqzsVOF283a0xLHD81M7R?=
 =?us-ascii?Q?fYgTI1+rXm/QN2KteUmktLxmUKanRFxJDv/syYrmNJmZopJ0+gZp0u5D41Ic?=
 =?us-ascii?Q?vii061CUa5zKohp1lH5AF7Kb8vU5LyCk/EfYdpvfnIKJXNQnOkRFPKEz9a5w?=
 =?us-ascii?Q?pBplF+6V9Ici3LAwoVm48g1ADEZRG0DRRquSaeCzlWOExdpOFOob5IAjhqWI?=
 =?us-ascii?Q?d6xTdTZNF5j+jpzOgEoOPqIkG8CxRsHwuEJvlvhmvt168mdeo1hxqtWaWwzC?=
 =?us-ascii?Q?VZH17Mur+BjvuvWdxPMBS6eZx1vH32Sj2fsThfdpFbtoJg3/D36qpc8l3+8O?=
 =?us-ascii?Q?xCivPTG0mc1wILHqJKe+5Z/oBwAQ7p78zUMg+wH1IQCP3wc7udDwGZG/wqId?=
 =?us-ascii?Q?B2tC3srXA8XETWmUzZMCnAWcvO7FMVjVlCdG96J34KRMnV/fBV8pr0lPQgVC?=
 =?us-ascii?Q?wCTqfWiYYutzqX2RxsUCRplVcWGi8qaZ64EKjaEuJ3NDLbeLIx/30+nKTvKH?=
 =?us-ascii?Q?uPjzIu7IB4doWDNld23lKpYJwioke6t+AhjIEVvBYJVp5GoLG360l1GjgThU?=
 =?us-ascii?Q?Q0jsTNd1zUsnWUfJFpIMx3UtVVQfgejwf0yd7HJ4xN7fF+fEq46hJcLlaZfj?=
 =?us-ascii?Q?cPWGPILzyGVcM7BnXZKJ+QkLiRUx8YXySkP6YhYrMDLiPif5LvIvzPC9BtQa?=
 =?us-ascii?Q?Vrj1ior+s2AETfUOHcEpgRwZbdzeUo0F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/UYPLoxTHzgITMnCAUIbp3UN8fFVRj8kbrqoYLZidvcT3CKt/Dy5QAfMZ2FX?=
 =?us-ascii?Q?ruoWfumeF/LULJ4YV9hywmcaduxKM3vrLIjn3vvZkHiK5ajA4M5ffVeznNMq?=
 =?us-ascii?Q?3B8PwWP2haaeoK0Pj1xfGrCDo7AqRnCP0tAYDPXA24bD3kyuhYK7FHNdDuDK?=
 =?us-ascii?Q?PFymie58eMnvJOBYJE24kq7UeAF9Moy2PDG3bogwZ0YplxC5JoyMJzTvq/cM?=
 =?us-ascii?Q?26fBUqJ3/+Rjrp7ZIbIZribGk0Rz7KhNw3xZKidhVXAGPfxtm6x7lPLQzEym?=
 =?us-ascii?Q?9cgXou97xQimKXOyPC5wuzzCL97XOjpzDWF0swcVC647We49sxc9Hq27dz+Z?=
 =?us-ascii?Q?aDRfvHumBmfa3vB64el1CDoLUEwvznonSYeH3QMOpiJHf0IG9aUsCzu+46wg?=
 =?us-ascii?Q?4BMfjnd/kGKbu44fyt6OKM0cI1AiRcuxHVTMrY5V6zQWq2MMSgIetQAE1dLT?=
 =?us-ascii?Q?F1uJ2j66ArkxOZsTIlVre7oGEF9NdTm7VPxNOAATBXBxqTuJivfBKKskBonP?=
 =?us-ascii?Q?CgJ3/Z8SPAE6FcdA6v/NwOUA8AFpMCKMd2NcrojO3TmK2pBS5N8hfseCAAWb?=
 =?us-ascii?Q?NIW3xsCW2Z9/cGkW7tQKzuFRXom3rlRI+R9313OQXmEfQ61EK2ksKSZWGxCj?=
 =?us-ascii?Q?EQT48T8y8q8a7Jg5QJiyzSQGQF/YzG3l0o9SqG4wOg5N0tyjnSslAOsC5d+Z?=
 =?us-ascii?Q?48bcZgG1emOVoLb6ieDq5P/v2qd5Hbmk+IaHgp4IXbYNbUv+39STe8Wmaoma?=
 =?us-ascii?Q?sjxca9cLt1IIb0u47t0DUPW2fNtLWyefhdUkxu1jTecFp0Zj7rQ39FRFrDRh?=
 =?us-ascii?Q?yllNMPBktV1m6Q8DHxcvNX/BFfErWeVDftNohLGPgyuHYRr/89cPXs8h/YFo?=
 =?us-ascii?Q?87wd3s7VDqQkdEG8+tPsrEVLwsFALipiWpdOSANbM7PmS066YEuK6YV1Vetk?=
 =?us-ascii?Q?Kn8YBDpvGuqhs1YvBQ+iK4pEwVGbN3LkNLwUh1SbnuFdwjrkR6Go712Feosn?=
 =?us-ascii?Q?mQSJqKd1zMh6XEonYxPFNTSQVmgJGzgWBQR1VP0FwiZJTYp+3TPbjNQdwgLB?=
 =?us-ascii?Q?qJEu/0FBqWyO8NXev2ec2DKsh4rhhLzo/dl+r5WGyPmm2gfOkkwmacWgT9q0?=
 =?us-ascii?Q?/iK+lRZWvvDu3kzC/dU64Xtbf9BVG1cWzs43g30c3lhgLL05t2AoaGXNoXBr?=
 =?us-ascii?Q?leoykhucnF7r/srznhUdS7vMXD9cC7qAYFTVD4hFWzY09XpIwRVqFfQBImVs?=
 =?us-ascii?Q?LoEP6Y4N4XVtjF2QA5uFv8WQ9f/K2vmERZsAL77srcsWGiC+dcuiLfAKV4V0?=
 =?us-ascii?Q?dmMo6LqZzrvLV7XpwoLrYcviGB8mMhIbLyZwl8UV1qsqYmoDW3RNgg6JD/T0?=
 =?us-ascii?Q?oR0rIRxUxPUz18ILir3CscVjp3aEDbCH9ADBsACxyv+0g1zhmYnzvvzlqiDX?=
 =?us-ascii?Q?djDZdkQB04GjH8N8gJQTkf7Ue/w+r9ZZHcWwe+qbh2u0YoFmRdaXKIFEU7/M?=
 =?us-ascii?Q?5k0YJT8h24Nn0ORtNCAY6/gXOxdzUudWfcakyoPL/md5QzrHy/W6oUQCViUS?=
 =?us-ascii?Q?grpCngPYjXth9yXe5Fvliyzh4CoRpzFf9/ZqtyRl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e98c2-ebf4-4c28-08ab-08de1180c0d7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:36:23.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jqybArlHNJQhsjplZGuivCG+aehv3th1PCRBinOAL+0SZT5Jugztak7ZpOVmOKAk8kz1w3jh7WqedExywq9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

Following commit 2dbbdeda77a61 ("sched_ext: Fix scx_bpf_dsq_insert()
backward binary compatibility"), consistently use the ___v2 suffix also
to the new scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and()
kfuncs.

Introduce __COMPAT_scx_bpf_select_cpu_and() and
__COMPAT_scx_bpf_dsq_insert_vtime(), to ensure schedulers can transition
smoothly to the updated interfaces, and temporarily mirror the
definitions of struct scx_bpf_select_cpu_and_args and struct
scx_bpf_dsq_insert_vtime_args to prevent build failures on kernels where
these structs are not yet defined.

Both the compatibility helpers and mirrored structs will be removed in
v6.23.

With these changes in place, all schedulers in the scx repository build
and run correctly with the updated headers.

Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare for aux__prog")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
ChangeLog v1 -> v2:
 - Introduce __COMPAT_* struct to fix build error with v6.19 (thanks Emil)

 kernel/sched/ext.c                       | 10 ++--
 kernel/sched/ext_idle.c                  | 10 ++--
 tools/sched_ext/include/scx/common.bpf.h |  3 --
 tools/sched_ext/include/scx/compat.bpf.h | 65 +++++++++++++++++-------
 4 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7409de4321e90..5dd28b0d69c24 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5490,7 +5490,7 @@ struct scx_bpf_dsq_insert_vtime_args {
 };
 
 /**
- * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
+ * scx_bpf_dsq_insert_vtime___v2 - Arg-wrapped vtime DSQ insertion
  * @p: task_struct to insert
  * @args: struct containing the rest of the arguments
  *       @args->dsq_id: DSQ to insert into
@@ -5520,8 +5520,8 @@ struct scx_bpf_dsq_insert_vtime_args {
  * to check the return value.
  */
 __bpf_kfunc bool
-__scx_bpf_dsq_insert_vtime(struct task_struct *p,
-			   struct scx_bpf_dsq_insert_vtime_args *args)
+scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
+			      struct scx_bpf_dsq_insert_vtime_args *args)
 {
 	struct scx_sched *sch;
 
@@ -5536,7 +5536,7 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
 }
 
 /*
- * COMPAT: Will be removed in v6.23.
+ * COMPAT: Will be removed in v6.23 along with the ___v2 suffix.
  */
 __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 					  u64 slice, u64 vtime, u64 enq_flags)
@@ -5557,7 +5557,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime___v2, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 3d9d404d5cd20..d4b6b5a300345 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1003,7 +1003,7 @@ struct scx_bpf_select_cpu_and_args {
 };
 
 /**
- * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
+ * scx_bpf_select_cpu_and___v2 - Arg-wrapped CPU selection with cpumask
  * @p: task_struct to select a CPU for
  * @cpus_allowed: cpumask of allowed CPUs
  * @args: struct containing the rest of the arguments
@@ -1027,8 +1027,8 @@ struct scx_bpf_select_cpu_and_args {
  * a negative value if no idle CPU is available.
  */
 __bpf_kfunc s32
-__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
-			 struct scx_bpf_select_cpu_and_args *args)
+scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpumask *cpus_allowed,
+			    struct scx_bpf_select_cpu_and_args *args)
 {
 	struct scx_sched *sch;
 
@@ -1043,7 +1043,7 @@ __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allow
 }
 
 /*
- * COMPAT: Will be removed in v6.22.
+ * COMPAT: Will be removed in v6.22 along with the ___v2 suffix.
  */
 __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				       const struct cpumask *cpus_allowed, u64 flags)
@@ -1413,7 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and___v2, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e65b1eb668ea5..64e5411d04c04 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -60,9 +60,6 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
-s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
-			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
-bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index a023b71991a6a..2f797d1c19f2b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -161,6 +161,27 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
 	return rq ? rq->curr : NULL;
 }
 
+/*
+ * v6.19: Mirror the following _args structs, to prevent build errors in
+ * kernels that don't have these structs defined yet.
+ *
+ * The kernel will carry these __COMPAT_* structs until v6.23 (see below).
+ */
+#define scx_bpf_select_cpu_and_args __COMPAT_scx_bpf_select_cpu_and_args
+struct __COMPAT_scx_bpf_select_cpu_and_args {
+	s32 prev_cpu;
+	u64 wake_flags;
+	u64 flags;
+};
+
+#define scx_bpf_dsq_insert_vtime_args __COMPAT_scx_bpf_dsq_insert_vtime_args
+struct __COMPAT_scx_bpf_dsq_insert_vtime_args {
+	u64 dsq_id;
+	u64 slice;
+	u64 vtime;
+	u64 enq_flags;
+};
+
 /*
  * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
@@ -170,12 +191,20 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
  * compatibility. After v6.23 release, remove the compat handling and move the
  * wrappers to common.bpf.h.
  */
-s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
-void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+s32 scx_bpf_select_cpu_and___v2(struct task_struct *p, const struct cpumask *cpus_allowed,
+			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
+
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
+
+bool scx_bpf_dsq_insert_vtime___v2(struct task_struct *p,
+				   struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+
+void scx_bpf_dsq_insert_vtime(struct task_struct *p,
+			      u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 
 /**
- * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
+ * __COMPAT_scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
  * @p: task_struct to select a CPU for
  * @prev_cpu: CPU @p was on previously
  * @wake_flags: %SCX_WAKE_* flags
@@ -183,11 +212,12 @@ void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 sl
  * @flags: %SCX_PICK_IDLE* flags
  *
  * Inline wrapper that packs scalar arguments into a struct and calls
- * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for details.
+ * scx_bpf_select_cpu_and___v2(). See scx_bpf_select_cpu_and___v2() for
+ * details.
  */
 static inline s32
-scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-		       const struct cpumask *cpus_allowed, u64 flags)
+__COMPAT_scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				const struct cpumask *cpus_allowed, u64 flags)
 {
 	if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
 		struct scx_bpf_select_cpu_and_args args = {
@@ -196,15 +226,16 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			.flags = flags,
 		};
 
-		return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
+		return scx_bpf_select_cpu_and___v2(p, cpus_allowed, &args);
 	} else {
-		return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_flags,
-						       cpus_allowed, flags);
+		return scx_bpf_select_cpu_and(p, prev_cpu, wake_flags,
+					      cpus_allowed, flags);
 	}
 }
 
 /**
- * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
+ * __COMPAT_scx_bpf_dsq_insert_vtime - Insert a task into the vtime
+ *				       priority queue of a DSQ
  * @p: task_struct to insert
  * @dsq_id: DSQ to insert into
  * @slice: duration @p can run for in nsecs, 0 to keep the current value
@@ -212,11 +243,12 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
  * @enq_flags: SCX_ENQ_*
  *
  * Inline wrapper that packs scalar arguments into a struct and calls
- * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
+ * scx_bpf_dsq_insert_vtime___v2(). See scx_bpf_dsq_insert_vtime___v2() for
+ * details.
  */
 static inline bool
-scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
-			 u64 enq_flags)
+__COMPAT_scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
+				  u64 enq_flags)
 {
 	if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
 		struct scx_bpf_dsq_insert_vtime_args args = {
@@ -226,10 +258,9 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
 			.enq_flags = enq_flags,
 		};
 
-		return __scx_bpf_dsq_insert_vtime(p, &args);
+		return scx_bpf_dsq_insert_vtime___v2(p, &args);
 	} else {
-		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
-						  enq_flags);
+		scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags);
 		return true;
 	}
 }
-- 
2.51.1

