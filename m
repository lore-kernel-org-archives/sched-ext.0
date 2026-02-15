Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09F266565
	for <sched-ext@lists.linux.dev>; Sun, 15 Feb 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183194; cv=fail; b=ZmvrKI0lkRJaDBEK34uHeZAo7+v87FpLyfSrtoVvXDby0rrvrWMGp2JKP33u2CiXrrh0wrwy7/3teE9KFuih2vyPO2NxwRly1ZoKhfWlNf4rz5feBO6MsFE3/JJBobdZw1ekpid/J/UAgZ8FkJpt5KlrSZnB3mZcxx+0SAsWems=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183194; c=relaxed/simple;
	bh=J8Nl5zlMR1osG6i+2P2REpttDtZjcctl8iM/+kZ1RKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a3TilFr7GbN0PK3NZvBBRJAS/hj3KWr/RRyhVcLdJOP08J4HTJYR0qumdGuZ0nLIrYnTFZFxagZtNQlM6GA7gMhAQRoMTVaBX/M72lUzaNsMrSiaHXJ1ckjeGfyFgdFkmvbBTPDoV3dKr0G4RD332HwA92VpGEvEIaM8VuGDMAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wytu61Vt; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wytu61Vt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2GFRQE5IDAhdAgAVp2I2rnaJvLAY5S1HwdyMmQOYRWxJabtmnV4w1QYkdvKqJpiMxCx7Yxoa6+1toh4NUHROgasy2LSCVrefDuWoHiUFqnacnLlH4Krg5lkNbMDrbVU/aeg+Z6JbKpQ/xxbg9rswOmfpjeGYqhiiJvAWONZPCPihJzET2CEEZeQOT+pReJW9N2KLZPFr+imiVE31BPl3fyXQkMqXI49zLsyWD8WME6TeW17tLRaSfJeWRzV2ltifJtPR1UMZ1iyJgFIF9SDlb/bg3yrd2r7HE4qHXbJ6lbbrCTn9TKV1bD2+q47iM5Cszbvoy36eSNJso3g+780kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGaU2i6FNHj49mNkg/XXTK/fC7F8A/WqZnS8TZeJnKw=;
 b=dDtXSYKn0+CDxLji22O5gOdtsInpL/m1t0Gf4YDbNiqvVbMNWrTqvA6BiAsnm2/0wmJ9NNbBIvFEHw5Rw5GpaHMGAYOBhuAKEPvtAejCiM3w7pYPa4h1JQHiOkQH/MefhoYsmqXmgkXPxVuvt4PsaH8rlr1qXwH7M2PignwjHG8LiCT6QwPG4rb7yqM0BVXQI/uz+PrNaA0iJoT8CmAkVNh6JQqQ7DqZuRp7Y/YPwrCaGya46sEvDfSKYi+Ef2HFzZTEbFYB58n+mHm+J+gD8szResKRDivet0Y8RS21SOQ7WvCpdYoX1vO1p9tHubkjdcFRjED08LuWFWqK/wQ1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGaU2i6FNHj49mNkg/XXTK/fC7F8A/WqZnS8TZeJnKw=;
 b=Wytu61Vt04Bv0WUEo3in3yqnZ/q/GGq7UD5MHDINlcUmknuUk46kKepULVTQYj2wTSDy6b+1PYAh7TAzGc4bOBXD1ONwJswlzfrHwlR5x/f7GPDIt8wlfRyaIbe/ivAyIk9vVF6uch1atAVdtzNo22JTXG4etu8jzNOb8Ouh4XbWRc9grs3Eg2FF8nSCt81DmIpZ4Pf9GIViDJAgK6O1DOozgqqIX+q96dokYjBVpAIa8khYUX4ZGqxEU+5AawPS9uTn9vvvnBvQ3og33WZgU1pRwN+2vvUqU1jPC/Y30WpJo+jPJukqGGd0eiD+RY5ir5Fr/Hsxn4bRUCXc/fvftA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 19:19:47 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:19:47 +0000
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
Subject: [PATCH 1/4] sched_ext: Properly mark SCX-internal migrations via sticky_cpu
Date: Sun, 15 Feb 2026 20:16:53 +0100
Message-ID: <20260215191933.2358161-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260215191933.2358161-1-arighi@nvidia.com>
References: <20260215191933.2358161-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bca473-fc42-4425-61d4-08de6cc72e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TxDND7aSzTpbi9HY4aitFph8bu4+QbXJUTVlYbi54OxBddcb9Y7uhTcNJA5m?=
 =?us-ascii?Q?bffL5J7JJ20IaEcUTT5J1xKfglmor3qzhisZC22lUFjIenYYn/vLEZ5gt/bC?=
 =?us-ascii?Q?OsbO5Mpvb38PaH7ce79AnfUNrDyN698rviT867A+wDQxEHY6JEldS9kEYwMV?=
 =?us-ascii?Q?iOxK2jUPAYSy2YL/xRZk1c8BnyN5oLE/l/U6h240N9XIfaaXX8Uogb3kmed8?=
 =?us-ascii?Q?BGZPf2pc7U9XVXuztBjKJXQvxEvUKzTvql78Yenb6Yf1Nckbbq4RpefrRu1c?=
 =?us-ascii?Q?mUDux4weYBrFaR3QbO0xyFl365F0o0ilRLFOCXSuptpXlYuhv7OSGRDRywuK?=
 =?us-ascii?Q?mZmjY5RbV8AYX6v051S6UA5+RLn2cGZMJpHjvNh8VNqDzPzhkpVwUsGGNW8x?=
 =?us-ascii?Q?fzfqZU2pXraEoeahAHn6xj+YZeiJV5yMmjVnqqgq+4SCuxkeGbwIZNg0ABrV?=
 =?us-ascii?Q?tY4F8jbRwUMfuxK1UJUoRYUz6bR5f83y0W6Hwe0/v0DKE5OPvDi178QtuzL4?=
 =?us-ascii?Q?RgdiUf1wurE6S2yRoSf/H92WQdjcjsOCwTlqhI8vcGO2kCaDTPRcZlyLFbBE?=
 =?us-ascii?Q?jGMjWsy6FJjmhSoWAVRlmp4HyRF4TiIdLs3FfUe9CDHNKixKyn+X57gWsRJz?=
 =?us-ascii?Q?oLkIDyxC5Hu0bdr17KOwbyWBAiyHeNYdVN4QIt6+Q06LNtWPBkYwgZMQCPuZ?=
 =?us-ascii?Q?cKyDvdhkqL8W+iSNq5vAJkQwjv27Ay3UJxe27Y3NOQnGah5p/AllM89N9iB/?=
 =?us-ascii?Q?JLal8NN6ccz8vwEmk2sLpF/ESFtXdQvTI7ztSQ4y7ttSk33OQRG56z0w9EAB?=
 =?us-ascii?Q?DVytSK2N+lx/qJ7UatRMAFHek7+se9WT9QKXll4lNyc9mGplaXTxLxYdye+6?=
 =?us-ascii?Q?K36zYESuLn8pfgiSAa2fumw77KGzbGtjSBej/2KG3Ry4+eLUzv4/l+DULLeJ?=
 =?us-ascii?Q?KQdVYheNGZSde1EsEtlEAbA4Yf9t7LFkeYA8GqXX1g76I+yGTKGqBOMVz7NE?=
 =?us-ascii?Q?B2Nuq7Pr251a5JTtBfuZnXX7hETGKkCnl9h9H1V5IHvWE0wliiTmU76pwO5n?=
 =?us-ascii?Q?pYWwJSevV3FizqWGLnFaCOg7H+PpjO3XIz5RawCwn6rginQgFOaaYyxWLBsy?=
 =?us-ascii?Q?LMURPxB1QQoypb87Eg9Vv+YgIvzypjLAIvNyK08e90thOFftCWyAjMm6Ee3c?=
 =?us-ascii?Q?/ikKUJpWwGT2RmTPhREnRT0qvZhR3GmaMbwdtsO8Vo15+rCjTpr1P/VJbpY1?=
 =?us-ascii?Q?jhel3W6jMQgaJn5LRHFCaRIE0/vlAjazy9Z1voGVxkGtOyxvIctFZjt4HQOk?=
 =?us-ascii?Q?29j9bXcN4/vhnkVQ1UTvPk0Izjr9bRqqTbP0YR5ejHUz4gZ2t+ZxiHiPcp3g?=
 =?us-ascii?Q?sZcMDkFBIgeNFN3HNjvfCDau/QTkiyfIv1xQ3YJUo+TlAgd7+dVm4VkVhM+z?=
 =?us-ascii?Q?vfuzmPVcnIWLhkHLjAfGpvQxlBzpYWHX76xcFGo7Lu7IweHhNJuqmiI6b3mF?=
 =?us-ascii?Q?sZhP2MOhnMrhXnJUzmyOpT7jSTu9kpGlrzfOeX/NyXxRy009xDvIjbkrrdAG?=
 =?us-ascii?Q?c17pwAbw3X2zunpv/F8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGlZ920sut0RVUo0WdC3Wbd3pdYLXAjHUgtrs7smMCSVRae0VknRIzqxli0h?=
 =?us-ascii?Q?JiUro5aNXoouVoAD73ANCbg/tBPyLyiPCLICGSKcbh/EFTU/pNXE9HXeyLCm?=
 =?us-ascii?Q?VWG6DMWxZreqHef3OvyqFX+69QwKaVetrbEGv5dUR+7iNeJXD5S9Y03BSbGt?=
 =?us-ascii?Q?6pMYxmzIemPss38ILAoYKdR6R0S9lbe+7RiGSP2XcRVVu/DquU/NvQ5HSsPE?=
 =?us-ascii?Q?hLo3t07H7BVKd75eZE640XCgwhvgzCdMYMys7PPIhVQWSHU0Q6SXiuSqJpfU?=
 =?us-ascii?Q?XvJ9UOg35fAxnbSO7lTJuLz+pxXaYS51ykkhgy+SSgke0eZ5rmmcGzUrwNpO?=
 =?us-ascii?Q?UprENISM/2HefKIH5wUswJPMXkSgAF0BrEuLHn41OOlB2O13FrFSG+yNJPAl?=
 =?us-ascii?Q?ZQiFZQh+Xp6hIiIqBQT3h/2QnstEynm+9GOeM3ct5fkJwl0yWjqAz3RCTFds?=
 =?us-ascii?Q?69nMZi3MX0kQoLbvS7UO66rPBj23k1aJJZxvOmZpFcLRMhymceeB+lvtBrpf?=
 =?us-ascii?Q?VVFmeXp7LuLK2yoKOjpJf8iASed7ncOrRGzHDhj+CWsFVaUod2GDKl5VFkf/?=
 =?us-ascii?Q?bKV++77DYETMIT7vBoFGMTg8Mn6CLvuDnzA444fEFPU3OAd0GAX6Md9/Ljxm?=
 =?us-ascii?Q?YzFSuGjb1pR6+0S5kYKn2enWk5fMf6J9uaNOIoVhBcyRiK2IWCCX439f1gDo?=
 =?us-ascii?Q?Swkos1yd2TPTj/cM0rrXpOGTvA8MQa5kBa6bMVqggQOIdejF4mSdYeVuWs7n?=
 =?us-ascii?Q?mCqu7QAoOqu0rhkWpGMkkTU3eRQoDwJGZUTxmitehRTligP27/3Eos0OJsIe?=
 =?us-ascii?Q?Wyk09vGgvt9qCFRbhiiEN81tsqsegt0RAosPVnurZ/VL6qdJI78ERHpka4S2?=
 =?us-ascii?Q?HgfzxadmGBtWvfhMEbYQxx9QIKTBq2lIsqGsAdvYoZ87a3xEWeLgStbeyzgL?=
 =?us-ascii?Q?NaOjSJZxRn7HSGE1tqm5Kvkdm7lRyjdA2C1jeB2bPuDkltZn00IPMZxf/qDq?=
 =?us-ascii?Q?4bvW/zoKlWq7ufSyo0bkdCHSs9s/TtEID72e3o2eP/lFW9u7sSlQhXn6WQiQ?=
 =?us-ascii?Q?ItRdd/yV9Mofky7on8G8wh5jOTg2mr6roC7D3A0iN9eKt88Vpwb83YlQZ2KI?=
 =?us-ascii?Q?Ze7zv2ztq9bh6oCSg8XAwNTI3ck3oq/b88nCfV4Q4yRKCeuZ6SstAJFu0aeq?=
 =?us-ascii?Q?T4R60bit26uvJ02x4r/AGkRsdzNVkfSpr7Y+WAIhn6/AW1Y4NI2yhu6c7qLB?=
 =?us-ascii?Q?Us9mhulFyGCVV859M+7Rs5osN2bKouqfhuz1VSLTH4pAvw3ma2JS8XWaVTGX?=
 =?us-ascii?Q?whRsl3fHGLnItkmLjueW53FiYM5EOkw/3/7TSUkMn7YsnZq+7Nb6cLoOPJiX?=
 =?us-ascii?Q?0V4odDQulTiItSJGXtovnOCddCsccpRrYayJVVkyjSzq+hWwpRiGRb2ymovK?=
 =?us-ascii?Q?H5WeUdveZ3+QA6Lxz3FD4fOwsiKdK1QBgEa+EG3VSgQR6YiwNJRKI2pPByEh?=
 =?us-ascii?Q?3hOyW/UtI74NzkeAa0UUDoPoymhd2kps5Rn9A+DGPiBINR/Apxfjb+t+QN85?=
 =?us-ascii?Q?7uuUglEybMUwSFRn+6Q9T/yncZ1pR+CbZjfPhA7yBlUdmw5hTc8UdYv7ePC2?=
 =?us-ascii?Q?DyOJTGvpRqNSrbP4wKcDgo6mk4HgyFUpWbikM50PEtQInYJcaCqBxAUdOCx0?=
 =?us-ascii?Q?2FxBSbru0n4IjvB9TFNnCO3H36sOdD+Ti4yif3nmjx8meC5x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bca473-fc42-4425-61d4-08de6cc72e8f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:19:47.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYe1gkDRMRUrzy6hnjkzmMZC+Zm0u4zk+iHjr44OJkPCBdxJ1EM1tW01LJSyQS0IKM5VzhSsnjaaOU8bJZiETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

Reposition the setting and clearing of sticky_cpu to better define the
scope of SCX-internal migrations.

This ensures @sticky_cpu is set for the entire duration of an internal
migration (from dequeue through enqueue), making it a reliable indicator
that an SCX-internal migration is in progress. The dequeue and enqueue
paths can then use @sticky_cpu to identify internal migrations and skip
BPF scheduler notifications accordingly.

This prepares for a later commit fixing the ops.dequeue() semantics.
No functional change intended.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c18e81e8ef51b..3885dd06dd573 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1476,9 +1476,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 	enq_flags |= rq->scx.extra_enq_flags;
 
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
-
 	/*
 	 * Restoring a running task will be immediately followed by
 	 * set_next_task_scx() which expects the task to not be on the BPF
@@ -1509,6 +1506,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 		dl_server_start(&rq->ext_server);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
@@ -1670,10 +1670,13 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 {
 	lockdep_assert_rq_held(src_rq);
 
-	/* the following marks @p MIGRATING which excludes dequeue */
+	/*
+	 * Set sticky_cpu before deactivate_task() to properly mark the
+	 * beginning of an SCX-internal migration.
+	 */
+	p->scx.sticky_cpu = cpu_of(dst_rq);
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
-	p->scx.sticky_cpu = cpu_of(dst_rq);
 
 	raw_spin_rq_unlock(src_rq);
 	raw_spin_rq_lock(dst_rq);
-- 
2.53.0

