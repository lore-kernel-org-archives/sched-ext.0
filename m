Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0789225788
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773471086; cv=fail; b=bx9fcw9l8ySabZdAE6/6PYdxWpOMJ6r+jyWco/MfIxqlopGS/xSfi4gE8Q4Q5JrsZ1z2cuuFgEAN5YpOofDjOcIDdKbsn5eM8jzH/IkNsytnKgdZc8Rcl8748uguO+LBK8dHMHjsKwW7V6Iy0z9s0mIyVSQ8LU72eK5xZHwSmUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773471086; c=relaxed/simple;
	bh=2ffWwtRipMR3fNIC8+T4z3oqX1F40Xx5f0RNlcP71yw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k77ceN5fF9vXbpl+i7/C2XOIFEkMJXE4NbG0zJM/vwAruC9h13oaOSgs5/tM7j/3pJrguIN+iSTH3Al6ezhIniy1OobyfPYdqqNNQH3ZuJqIz48ssl1GioQW7dnY4StpX7nYjmkCHSh1zwenJ4Js0tGxqhq98lDiEKGMTp3QHrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loWC71qI; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loWC71qI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVTf5fbPKzVFbXoZjaAcvWggXu6RrDVf8nrOO3T7nFbTdEVbaCnV8NkNUVEVS1BwUNmGP8yrF91i0pHRE3f9/uiMcBtu3Drs4fRlsPTem8ShCfmYK+zei+OkdEtVJDiUloRyAUlWq29JRuH+YBqU9vv2gp9gnfhVX2JuvlSCxGa3Nr8rfAzZIWoIxTGvG6KTWpwXyW/H/SX1JcGYGOe7JOjfqn+jcVeGM2bYwzACYr18gKYw45zw/PoRraxoa96qImuhXGQgTxwq8jnNnwVrr84zhX2qCTHmmyR6keyPGBRimByU7DhRcbwDlSmr4OdDPiqafsoaZwEhQgA3n/hoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7whAXlLe3UFnzvzR776Wh6IL4+7nkM9dpdbNnRXRNo=;
 b=Xc+r8Jmso3TC+WIsVUF/lw3Hr5nnHXknCKDT7Hxeh5aSOssTSnfJA2dxBd2fnTjUjfIDGesOpo85WhmbuU2n0J94PMblfuQPlaMyyTcE7L2xBaj3m8J8GFWyUyf+HxbjN0Z4mHs1c/P/3I7t2ThcYVJA5DdtIHN5RPAz3t3kScYF8tePR9A0enJ4scH0fU88Royo9k+65gQo5Z/DuRrYY3LUOLpAxoEKQWfNuw4wiA5Vs/aLY3xj2ezFb9XXT0dttCyT//7jm3pDJWXKrRbjXkDNkPkrotqIYUccAIUzfB7Gx8OLcsl/O6b+cbcYAyksLraPj0MTaQBs4L8NQYgrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7whAXlLe3UFnzvzR776Wh6IL4+7nkM9dpdbNnRXRNo=;
 b=loWC71qIeyQ3352R4aXuBzej+XdBhM+9VnWseUkA4YsA+kz4NLJeT/gaySqCd8GAfYCPSDX6XZ19Obv7jpIXS92ORBoouQRO9pwpivbbftURXaqRVgUjubdUjzyJ8Jgr9nC9tfELwrF48Kfzao/bK1+cy+eftddnCgPRuyUEacd+TyVsgTeQwNJYoapUYIXROpA64DAzoOStwSFbCIrRE48M6zwX8UeMs5054VWXAU8DJOQXksywiWQInCkcA231kHC1ZSUw0C24utEl5nXU71gPbn+LV62tqjhOW0KAALZhwCtk+C7q7GtgjUTO3kmNANdBhYDCHl0ZyOGaXbYKEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Sat, 14 Mar
 2026 06:51:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sat, 14 Mar 2026
 06:51:14 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] selftests/sched_ext: Update scx_bpf_dsq_move_to_local() in kselftests
Date: Sat, 14 Mar 2026 07:51:04 +0100
Message-ID: <20260314065104.113372-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2ce603-ff6d-48e6-aae4-08de8196150d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s3cwqMizQatGEveVtbUgKwmKGLqMe98M1jdMqzwNeohOh8Fk9XRDMOR3vCMXxHPeFNHPZwWzsvi5EHtTMalwR3VsrLb9VJTFta9M25OcdNPMSt1KeE/1JlXd9nj94r3RjPTmZ/pKzWIv29aEBE5ne9szwKw9AF7dOkSB2cP4OlKKEi3Ypuc2cgYZM5UVv1Dssz7/rNdqG7c1GfV64a7/KD4FA6ZpFYq6oKHwX06CUwianHjRyBp0MZ1ZEQExk2CwIomC5TqmDvLVot19AjAxaHUk6vJlSxWv1YGMl+TJQUyMSyA93ioWtiMST+3ZftUvEMTlTCZHcpv5A8GUmU0Pe2Tsp4xyeRV6r4/rJH2veXzrBXK0rgqOPp4G/wyyzM273L3wg5veziEcu2bP04dmqLS9Rxhmu0G2urwiDp+kazn6P6XXrl1Cvr0CFUi5zzbaOH/pPMnYmDa66cB3rFl89ocZTVy2W0TxZTIL5Tg7fJEntmjdzts3Ewzt/cc5MgN42Qdyz0Oly8bCbgCxlVgaDSOTo8qlOhFti+Epmuy615EY0jBxDMtRCJyX+C5Aw07XUUvPs7QojV3jwd4k6Xgh/S0r8+kSJpNMqBsBDv9I0+nCQ2LBM03affUUTLLxj01Mvu1EiXASCwVzOtgp3hVcnRD5oU9JcYLgC4PVyDqhuyfPYmWqvFuEJ9rRU+PYQJfwjIhVsFqgK0ZK0/FVeaKuUx+wO0jMLGPVASt8oqAbgaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5O6bSgv2Mmx5heoW1Lo0feFsrvO4q1Khvl2BY3lb2+Ey59bjhbXtjWBKzG0?=
 =?us-ascii?Q?KjrOYN9/stsEBQr104oFPkxub0Li3FB4ye0AegaaY640ZTuw//k5Ax8Unezo?=
 =?us-ascii?Q?ffTig7HMSHnVz24tRxsQViaDLQwkn+3Y3bM3bWKhS7hTN3dRi+TVOwZpp7VE?=
 =?us-ascii?Q?YIs6zv/yti25t2WnIU9ZYK4Ydme4n9U/i+EYqonzBZqDtayHwNBEzAXfPAz9?=
 =?us-ascii?Q?QrnMrY0g3f4ewmsjYqoXvLss/rJApjg1j53Q/ReLtELDI3xrhR8fgcsUoIyR?=
 =?us-ascii?Q?O2slcSdUZtgKtuPJ9vnz6O5u+O7HD/lK8grvrvl5pzdfnucmVGHmslqKdet2?=
 =?us-ascii?Q?uqnZCyVkrYxKT6wlwgSNwj7rfGH4htg74S/Oiwf5qsJs+JqugMDHpgAQ1TOO?=
 =?us-ascii?Q?WtMrgAlAhnjWSw4CcbE/tpb05hf81jZ4bHM0snS1PUmvng+LQSvxb9l1Wotn?=
 =?us-ascii?Q?doDiy6zpvD8MRAD7REqWX7LIfcrYaEmafDTn43fZgAtoFsdsUysVmQvKlUWU?=
 =?us-ascii?Q?lGaOkHvlDz+QSi2YF0cfLEnBwlhYwNFeLsCflYbF/HDtj2BUZ0H55RYwQiAK?=
 =?us-ascii?Q?L4R5pgiC5q5O/kpqpPSYf2QX2oGXD27CYnWykkLfrkQFQ8gHmYdo2ACsENEy?=
 =?us-ascii?Q?xEtHcQvGWwWUd/3WYFgmM1bWSYsXglDjolu7ZhJRTHBn9NZdQwaNFBdy+Zl9?=
 =?us-ascii?Q?rRtcibLLUTEGFjjKD0IfPYcgJvpekUlVlYPK3HQm29sPPa3exnDFR1p9Esmh?=
 =?us-ascii?Q?o4b3UY+MQJ7ZyTWY98S2IRbBKmG/ZwZ1wles69/yxknZ1iiK+j6JsckyZKeu?=
 =?us-ascii?Q?Vt7skT2nA5crrg1Ou0bHVa12T0NsQ2CgZzW6hvFDwRfIQyryYNBsoPgSDNkb?=
 =?us-ascii?Q?9yIDDm6QqL2He0IzsenzxOBgZ26tVWdtOhe6OCPW2uQNAtC63CgDATc5gCD7?=
 =?us-ascii?Q?Jn0JLNymK3lRAqH+toPqBwICmTHowDz0Sr2AffdawUYMLBSqadD5f5dtKYvF?=
 =?us-ascii?Q?Fi6lSFE1BjpWPO18MtwipQbaHOIeuax7MU7VeW+OMaP52woLQT6TL8NktCkw?=
 =?us-ascii?Q?NWaaLNXvn3tPLS7SUyQb9ZkwizQ4Sm4J7FuFGhsfgku2LQ8SUWCQtw30kIIb?=
 =?us-ascii?Q?J+wWVhPvjR5LQWZVVaHEKPYb7xpl5Lk+JIf7XI2I6a0NDPjjsEW1F9NFhIKs?=
 =?us-ascii?Q?JSA+J9uZiuhdSjvdiJU2yk5yP91tKym2wsds/ZxjOMAae/BetS9Sb3ldPz5E?=
 =?us-ascii?Q?o4y6p1zey3PcXHeVsiXRu8PSDKMjJh+D+QaRNleQzZwwB20fhJjN2c1DnxXz?=
 =?us-ascii?Q?RpI1oVh8SkeG54mKGfxbYdtOhQ6Pp2UtNZLWsJINW9PEISa84XHahKmSXuPK?=
 =?us-ascii?Q?OENmiteHyIu5mbaBgsfyBJwBpuyz5rXypgmj1Sadopw1uyr5yTjNN9hyMh0D?=
 =?us-ascii?Q?IqNDf7Xh1V2RJS0hdW4GsjfGdcgt5Pwk2OTzS1hewuC1cJ2mjW2fCUJ8EQ+x?=
 =?us-ascii?Q?Hn4OkHgnKj2hfocObmmlRtzN6J4BRQJzewPHba0lGZsRWokjnXofS84B84V+?=
 =?us-ascii?Q?TWxBpKCyV87UhZaeyYKQW6nm97CZAhTgE6dsUEVTDeqDDX3xGvwWcp8osD5+?=
 =?us-ascii?Q?Ibp61oZSLL7IPGIN3BRGQUiGDeM7MK4aY1QDkNt35v+4Pz5h1s+QHrIaX8Ql?=
 =?us-ascii?Q?VkCvyCVAW/b3NdnCeGb2Ix5wur/rtQTSSuXynLlR/LD+IWKlBD9IO9ussj0/?=
 =?us-ascii?Q?3oXW0ONUAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ce603-ff6d-48e6-aae4-08de8196150d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 06:51:13.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjIb24LrlbJI2rJxXOIS25tbduiflIpZS4KARMKjb4bxH7F8bvairh5eEhwiqx2o9+q9kSM4phmJAhFsjsM20g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731

After commit 860683763ebf ("sched_ext: Add enq_flags to
scx_bpf_dsq_move_to_local()") some of the kselftests are failing to
build:

 exit.bpf.c:44:34: error: too few arguments provided to function-like macro invocation
    44 |         scx_bpf_dsq_move_to_local(DSQ_ID);

Update the kselftests adding the new argument to
scx_bpf_dsq_move_to_local().

Fixes: 860683763ebf ("sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/dequeue.bpf.c          | 2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c             | 2 +-
 tools/testing/selftests/sched_ext/maximal.bpf.c          | 2 +-
 tools/testing/selftests/sched_ext/numa.bpf.c             | 2 +-
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c         | 8 ++++----
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
index 597b88563d7de..624e2ccb06884 100644
--- a/tools/testing/selftests/sched_ext/dequeue.bpf.c
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -342,7 +342,7 @@ void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
 
 		bpf_task_release(p);
 	} else {
-		scx_bpf_dsq_move_to_local(SHARED_DSQ);
+		scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
 	}
 }
 
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index 4bc36182d3ffc..2e848820a44bb 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
 	if (exit_point == EXIT_DISPATCH)
 		EXIT_CLEANLY();
 
-	scx_bpf_dsq_move_to_local(DSQ_ID);
+	scx_bpf_dsq_move_to_local(DSQ_ID, 0);
 }
 
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 01cf4f3da4e09..a3aabeb82e6be 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(DSQ_ID);
+	scx_bpf_dsq_move_to_local(DSQ_ID, 0);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index a79d86ed54a1b..78cc49a7f9a67 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -68,7 +68,7 @@ void BPF_STRUCT_OPS(numa_dispatch, s32 cpu, struct task_struct *prev)
 {
 	int node = __COMPAT_scx_bpf_cpu_node(cpu);
 
-	scx_bpf_dsq_move_to_local(node);
+	scx_bpf_dsq_move_to_local(node, 0);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(numa_init)
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
index 784f2f6c1af9b..96e3a336a8a60 100644
--- a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -95,7 +95,7 @@ static int scan_dsq_pool(void)
 			record_peek_result(task->pid);
 
 			/* Try to move this task to local */
-			if (!moved && scx_bpf_dsq_move_to_local(dsq_id) == 0) {
+			if (!moved && scx_bpf_dsq_move_to_local(dsq_id, 0) == 0) {
 				moved = 1;
 				break;
 			}
@@ -156,19 +156,19 @@ void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
 		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
 
 		/* Now consume the task since we've peeked at it */
-		scx_bpf_dsq_move_to_local(test_dsq_id);
+		scx_bpf_dsq_move_to_local(test_dsq_id, 0);
 
 		/* Mark phase 1 as complete */
 		phase1_complete = 1;
 		bpf_printk("Phase 1 complete, starting phase 2 stress testing");
 	} else if (!phase1_complete) {
 		/* Still in phase 1, use real DSQ */
-		scx_bpf_dsq_move_to_local(real_dsq_id);
+		scx_bpf_dsq_move_to_local(real_dsq_id, 0);
 	} else {
 		/* Phase 2: Scan all DSQs in the pool and try to move a task */
 		if (!scan_dsq_pool()) {
 			/* No tasks found in DSQ pool, fall back to real DSQ */
-			scx_bpf_dsq_move_to_local(real_dsq_id);
+			scx_bpf_dsq_move_to_local(real_dsq_id, 0);
 		}
 	}
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index bfcb96cd4954b..7aa5dc6bfb936 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -53,7 +53,7 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
 
 void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
 {
-	if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
+	if (scx_bpf_dsq_move_to_local(VTIME_DSQ, 0))
 		consumed = true;
 }
 
-- 
2.53.0

