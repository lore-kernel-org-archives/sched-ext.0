Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415A31B114
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772877405; cv=fail; b=tilX9/zL5OvH4dUffmIiyA5XqSgYeJjvZyc6k/eelD5mu+UI42Bf244BBt6L96CNR96ofc38C0wIbmssrEcJnoMzraaV8piqGGBliHybp1nX5SGioldSAC6756DMqnBOCTkXGu0tFeDh5po44zvXXb+tFCmZPbNASfu2Uxs9zpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772877405; c=relaxed/simple;
	bh=tYS3VXEN7sBQGJ+nzXKzfVgsz1+/NBjCHySqieOzjzc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Miu72AHcgBtDTVZMlEpwgmhjjJvGKf9xoKe6Zf1lgMw7ekOYGaGojMluRG9kvlmFchajyotLzbLGlo+f9Bj4a+LbrtJGbwCAhnH2tpD/n/EtuLox74kFaqjXlHxxrHKecSTRNNczvwKHecSqH9vFH7XzmwHhBMrYuWxMxNl8c+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aR9pHZhf; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aR9pHZhf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNUwdTxCdNKZajnSqs/4N4STPMo8XVYFrmh6xfDoMil8fvsOaITiyNz2weLOZVC0MLpWvjN20dmQ+ptMteBesENYJ+wos7BJnYbf/DnTdA2/iJ7ykCEZ6hyL/Lz17/U9Y3sL2Gl/RaNZT+DWCAvG1s7rvPdHS7PYXeS4YmBfqRciYMdcZkX/saU76F2NKo2jp3qeqAXAQ1RCGSM0o8Q4rQRTu8+C8WzCH8rp09eZOXeTwZwSYDXoZKd8w6rm18v7XMK9Tp8whvxgS57F4yxGWWgrW+LxG6xIJfHxMPqpTqe2cCRwfd8tpu8/r5k5mF41DxonlXUAfiAarQu0bdymhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk/W/y7FIpZeScsvBsXFkYIvEozZhcgSn4VpFQd8LRA=;
 b=EYOwka+P2TUoEUAo7OFJtOl/kAGSeksw6lN0Wm+7kuncWGkzHrXAtGpXBKe8pJW/0/8ZuZWz0iZ/kI7zEU0G0+GtsMxEGWUxwOZB2pv0nx+3fbNzEIuGhNE0lc45OoAbWeK7q5dq5c0UZeJYSvjSAT2FD/ta77qrD092GbvLqcelJCky0ZndYUg/TtaBg7Xj/zdOrB0CILWMut609B/tuAFhygm0/Jp6Gg8U6K74S0h3OCZaHjqO0nvGObFE3zUh9BUvgkhSSYsYQIBVjGWt5jS13/rUmt+UXDOiCAi5is6ygBgNV7HKiK4AbZTuvtTVFhKJxSI+KD0lKRjM2fizDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk/W/y7FIpZeScsvBsXFkYIvEozZhcgSn4VpFQd8LRA=;
 b=aR9pHZhf9qYktxfsFEv1sLYY4fTzN/CMqNzkBBIsyGtIte/JKWnI9QnKqg7Ld/icBk1rSA8egeZT91RLYj+52oa1qgubKSSzgsxQiDg45H0eTVfyPIbnVWXwkWcG/xzWaxbhS02fUyfKqdVXUc95WoMVAaEZ+nx4RzVZvitJtqXtY5tACqqdNILBB1VABhNNAxToa28VvFis8G0K2nU4TzoMAzPfDR8+lxEXmK4mDJyrd1yeWSieWIAT3mB8JyZ36rWIG84v5YzPLKz95AgQuEZWCvPdds1L5asOCHjYoVQ1FH99MlCaJIT/rrRRIV17EKOCKdcvAp8bfFDKL7b/VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sat, 7 Mar
 2026 09:56:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 09:56:41 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] sched_ext: Pass full dequeue flags to ops.quiescent()
Date: Sat,  7 Mar 2026 10:56:31 +0100
Message-ID: <20260307095631.74437-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 7130afa2-8fea-4c42-37d2-08de7c2fd4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	BTTVw9hDAxNGIXHMmJBgqO4v9F6ZzjDgdPkBLpwXuDuuf2Sne8Eq3EgSxV31uxHXTpdSfeWEVCqj/yIqqvN+PPXeTkXtkzbsFrmuiFpI0mCkrO7OYa7dTx3jT/zQNHL1vP4ZUUja8k7TA810MqJ2pdOkqo5D5o8Wr0tPFF3WUYurBxOtShqY2csQgImhDdntbmtVD8JUCj7+rH8mO11ryXDbT/huIl3gdwbRCsg+4ba73ySBt6cWw4tGZcI3c4IAgBGwDURbtoZTJKKKNowW0f1plVMl5wVWTGMYMiMeRmkFNpEmqXx1/nzy4uoefQO6ZXo41Vj8rzyif6mJ8zMwXnm1tWtqAH3ncwxgsWHH7cDHhJ5IASks0XHipmb4hyoD+XldQX8IaK4Adca/byTEi4OS6E9qdo9FwptidcCfF1KJTZc0xGMCqFM5MhiWYYIPVkHG4vZqbYPVcG/Z8fYcVLZDCy9viFRWLtj1Lij6aRFwKwDPHYmNkJYljuXE884f+Ejczhi/jZwUM17JlfvNzwBsS3iwDtj55hu1sGXbXRxAk7ens/NTjNArVCH46hLn6x1vQj2iUdnznkCN07ve4olVcva3B/2n5HE/CPRod3XryrwxNW8kVs/7TfKPh3nBbz9KUK1Be+xDiNc8YHh8xwMMMPiRUhUs22jSHvX8LsHqPEss20yUbb/H9QQwDLBz9+NmBZVqIUN4lIUO1LZntJUVfgFdrlA0aYV41++g8p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8sWhRqha8EeS+9VGyH8YW8T194GsUMn09Af3aKPpszfgwxnZa21cQOcXDRh?=
 =?us-ascii?Q?8d9LWy7MHH72JAUmFT28T+9Jggcxi0jvsrEx7uxl7HIDKDlSg6Um3guQxwdk?=
 =?us-ascii?Q?R8FSZL/p5zhnccUHZbgX/vIebcAICSzRz4l1saywfTgOuxTKOssJRuH2T75F?=
 =?us-ascii?Q?oZb4XZ2+ZVpZIIf0aKIfHpssB6Jlql09CZcXLXGxAhEc+sdw+F7SmYTqpkwU?=
 =?us-ascii?Q?BsB+danOd1jFHh/v8hLoUKwjiew9zDkIOQOjsRaIalBrM7XgaPpwfY49Wp3j?=
 =?us-ascii?Q?s0GvHv6GeHNv6pr5oFFrE5JxG6kKq86wTERqI7edpB5df0tL+8rad4Gf0UcX?=
 =?us-ascii?Q?NonViqz767N/3e8ghdTS16iLQJahhE5aO9g5Lw6vEtpSwIQOz5uvGv5SjkMy?=
 =?us-ascii?Q?v/8XUEesJf2ed2tkuf1kUAjylUOd/yIWzOQT77gGlbsn9AXKK9TNrTaGO7jc?=
 =?us-ascii?Q?m41pYGiEMsvzestY8hpyPSJ6P53P9ZwYczkFxqlHZKyPVTU6STiXEQt3hvt+?=
 =?us-ascii?Q?266ldvqHkixzAGD+NeU76YStw3g/SKsXH63HMX9G7eUY8rn1RG+7qEr4ukAN?=
 =?us-ascii?Q?Ncn6dtyK2yoYGQtlJQkBSkNTssuDzfcrAwkNCYU7CZk2M8wnAiXGFxWPeO5B?=
 =?us-ascii?Q?vgCE5g1q7+Nh7uFtKIB6GtVrz31O26yipqfyX0bVFtvzXS5+++4W/J6n2zt7?=
 =?us-ascii?Q?lCv4uSsfY9dcjgWwR87bWr6gg6l5ny5S27QnUKaE5wGBDbNf9fVr+M7KiPFC?=
 =?us-ascii?Q?L85tvsgliROYzXX2D5veqLB5TMsE2prZ5o96jKlZ4GmdRu4uLuBBHDgdw5B4?=
 =?us-ascii?Q?6S8HcqA+TGQsQV4lhDJprbwosxFbZ6eyhrem0PFKYmPH8vOY4FXH35F2peyY?=
 =?us-ascii?Q?jhuPGjEzk3O0pfyHz3zZNUoiFiyc8B3DNNaUzv7rXD5IamtGpUJJgcH3B8p7?=
 =?us-ascii?Q?Bz5g+jHpZt3NhxtDN1erNHvZHIfKmXmR2hq64RLLoGW59BlUeSfRP4R2IEJ7?=
 =?us-ascii?Q?MNUjU7JvizMEZLdrhSsjZdymE/Xw790sc5G54OQqUbWzL7Ri67sj1s8yI/W8?=
 =?us-ascii?Q?MzMm6M8SOQ4/wsO+zMbbcs0o6IbvB4nZfN9MCFTfjHgqilJfW1TCXeI/6yr/?=
 =?us-ascii?Q?L/BirtEdFFL4YO2EM5DKjf8HZpypf3woBR26ojeGFUnpd1SZepZWYDrXklFm?=
 =?us-ascii?Q?gQIA/ZGwHWNMiHy37sb/QCibQzsGhb5ae5HapVmB2tGy+dlwZd4C9zaTsa+w?=
 =?us-ascii?Q?RYx6CkkCEeER9lBKhUcUU0ue92TF0ZSTTtKL4t1FusGHrkn2Sg44SDrZQzqw?=
 =?us-ascii?Q?F/aCEjH31DZ+q9B/cj+jXUTs61hrKPn3oefKQ7/tVAupf82sc7GwobezuQBR?=
 =?us-ascii?Q?GQ7kOzDPvwBgx0xJ2Q0zk/+eDiuB4Feshp0fDirDVomYjLqVn8BZ6VCqtcQs?=
 =?us-ascii?Q?sqJSqpixYozOzqrA7MkiPQp0RVl7P9qq2lIVJ5+oUoCnExz8mw9pCUF8b4XA?=
 =?us-ascii?Q?BcX4c1KMP7FO83SLzkyEnurmafEMLN31RYtzk0AsHgcOqcdcK12N1AJWGOzL?=
 =?us-ascii?Q?D1/adenKMyGOQBsgFKWqaFOLmoVEZB96BDYQnIEeZy7wv7kTDY7X1HfHpzZM?=
 =?us-ascii?Q?qH30bjEmAr6whFtkH+pK2ug4FCPqYXosSeUPBBRat9uTf6fUeB/WhgNjv7EN?=
 =?us-ascii?Q?oSph9OSPdNwFcS1b/0QFKDcedXc1+PduMjm8QOJydukZD/dc4BKc53DrKfr/?=
 =?us-ascii?Q?M6gv++HkoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7130afa2-8fea-4c42-37d2-08de7c2fd4df
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 09:56:41.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr3qGIOHBY4f+meGNCh2hzv3Qh4KMIh3XgdIrrqioEVSJ89PGmjXie6vj76NDTrhdzUAsBbfCi3lB40FjZvE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

ops.quiescent() is invoked with the same deq_flags as ops.dequeue(), so
the BPF scheduler is able to distinguish sleep vs property changes in
both callbacks.

However, dequeue_task_scx() receives deq_flags as an int from the
sched_class interface, so SCX flags above bit 32 (%SCX_DEQ_SCHED_CHANGE)
are truncated. ops_dequeue() reconstructs the full u64 for ops.dequeue(),
but ops.quiescent() is still called with the original int and can never
see %SCX_DEQ_SCHED_CHANGE.

Fix this by constructing the full u64 deq_flags in dequeue_task_scx()
(renaming the int parameter to core_deq_flags) and passing the complete
flags to both ops_dequeue() and ops.quiescent().

Fixes: ebf1ccff79c43 ("sched_ext: Fix ops.dequeue() semantics")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 863400f91543e..75e38f44dd7ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1900,14 +1900,6 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 	unsigned long opss;
-	u64 op_deq_flags = deq_flags;
-
-	/*
-	 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a property
-	 * change (not sleep or core-sched pick).
-	 */
-	if (!(op_deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
-		op_deq_flags |= SCX_DEQ_SCHED_CHANGE;
 
 	/* dequeue is always temporary, don't reset runnable_at */
 	clr_task_runnable(p, false);
@@ -1964,12 +1956,20 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
 	 * it is enqueued on the destination.
 	 */
-	call_task_dequeue(sch, rq, p, op_deq_flags);
+	call_task_dequeue(sch, rq, p, deq_flags);
 }
 
-static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
+static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_flags)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	u64 deq_flags = core_deq_flags;
+
+	/*
+	 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a property
+	 * change (not sleep or core-sched pick).
+	 */
+	if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+		deq_flags |= SCX_DEQ_SCHED_CHANGE;
 
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
 		WARN_ON_ONCE(task_runnable(p));
-- 
2.53.0

