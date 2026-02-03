Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFD2F39A1
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160017; cv=fail; b=NGwgQc1UlXGmUKfiFUVCrKfiPKjfmtnjIrFZLUutvg/tBLu6rEVi1Kk1lIysWiewsCMr7WW6ZXF7Gyd1XmuPJsGn4EEBELtTB1faguC8YXGlnrW6t6S+2AmOcWngQ1RjqxDuVAHSVDPMHXAzUsyDLX9G6Dunu4SBeeGIXo+yxNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160017; c=relaxed/simple;
	bh=r2Pk9w+FuLPkFcvkRGYu+W4UpbUp9yTzdsjwAzseE2M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZKxj7tNpS7t8A2DwNmRCJ6kAf0ay0ZPOTcJCUpe9/yrg3p5dwJbIN15KpAUyBO32dcMnbhhkouFTKWZ81I1q5zJ7QBASdsBw5Eqvqtb2ATxtx1N9Qo5Cj+5Ogct4lhi3LQ9k3VDnm/8OyDGK+nSkM/MaVWCrSaDyodUmMWxAR3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2uxy5mN; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2uxy5mN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxhsbwBClkWsG/lXl1QRWFNxg3eGYCFuU60zptUjtVGCze4RrDK/fpvc9pjoMS8SV+C3GjjzqMZwz4ctMVndFIZ9rQJGo5F1aHGB2OTqcr1GgNBYmJNzGi/qiLLHtzW/q9ashIXvCBCI+gQmwwjwGCn0ISZVRgTGSzsyFIVtwsAtNK3gBclQGcTrbvPu5TajQy0mhHYc7mYBfuTsvn2hp8T9Lg3Iu1fs/tGVIuZcUgwiLpI9C5iHmioNijFtu9O0EQHaXZ7pDbwNzgOEZCeYlVDYhfxZiMtG6HOzad+ZM8y74g89wTVcqEIwcMdVYbOzQk8aWKIb0HncaPYUIoDboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fekh9roMzFCw3eFE8bPQFIH36Rnsn4DYe6AUtygoYCY=;
 b=rG+xEMWRzJl26XfTNuyZenPqiGRZB0FFzg/XWyeVwh/boD+J205qJiiCRzPEG3gt2gpF0eKXLwXsM30+Bq7nwr2EqE03bhCRqnKTUHzi6yGUUQpcFLaUp0vQKu4YVhA5q5tx8kJHRwBXM7cvOpIKJ1XPq0aaAb5Jr/1IAQ8H8Jpn8OjFqCJjRQrCCqJjA85RpoMQvg6S8JRZYN7WvlNlysjT0irlU/+VW0OQ2R057cNK1u1ccpmZEg8wG6lDSPM03zC2G7QM1jhBN8CTqmP2B3iArktqZjyTDAozT012G/1sTUXx8vc8+h5N4Ey9RtMrGpSslHIqwuIq9mX9JYHONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fekh9roMzFCw3eFE8bPQFIH36Rnsn4DYe6AUtygoYCY=;
 b=r2uxy5mNbMetyj66UbGtSeXHOqpjFI6h/500imcKesP2JvbdKWqE84zd1pvO/3rOMxgG5eqDiiBb3b2iBmoF37hZ7ZeQomGKfJ6FyMDBg9ALqQVsvt7FspTiTFEJUgxtz+eYc5NsizpAg/R3MltTg0f3F3dRDM9subotxdTfDNPOd7vRQbyPkEgiz2NGK1jPx5MI1SPHybP25AzGDrWrCuhVtJSWbggGcBbwrwBoPKAoHb7NTjDbg06jrd3jgs/deGc9npu7ENLYv2naMVTzRSVb8EUN9nGy4krKJNX+v0y3UKElJaDl1RSS2TpMYe2c/HxnbFzEF8sj78AHQVWEOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 23:06:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 23:06:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity changes
Date: Wed,  4 Feb 2026 00:06:39 +0100
Message-ID: <20260203230639.1259869-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ca7826-4e89-462c-df43-08de6378e9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qgMUYqvO2MBM5wKD3iIDDkeW50b2hsz33p2c4RZ4pVztoOg8vVxndus/qm2U?=
 =?us-ascii?Q?/kwgmdyU9fymjFwhQ/FAJHs0oX8CGNLPDmusyxbvlsXeBZ+tLgMrXjQzGU/2?=
 =?us-ascii?Q?P13AwVOC3PAA0JqT4uoNrWiGYRyNzT5//wWFDE3CdkDiDrfsAHpyBpAeZDbf?=
 =?us-ascii?Q?YvyQRg1Ryj6qm1lcRdU3Wy+cCcJCDqID0pMT9HCqxAaZ3ORhEcQTSpjdUU2X?=
 =?us-ascii?Q?im7BQedE9SINtynxp5p73gxA99A3m4pZ9oTwYhO2tom98FJmISwHcqe4gHbw?=
 =?us-ascii?Q?AKfERsj0KSiCTZUDqejBS1/sj4Eb4QeW5DFl/4GO1Syehb8jZUrowupXtF/v?=
 =?us-ascii?Q?/5S63ci6GkStE35ohnq/z7DqMoeCBbB3ml5OHb2cJIwYMGQ3s3/85NEy5eL7?=
 =?us-ascii?Q?3jrl1jWcC4Jj0eJUIveub0VJVHaOyziJat1eodAXbPRzgxPCVai9n4EMf/Hy?=
 =?us-ascii?Q?0eoFc1GDUHEbMraO4P64XT6x7woX0erT2tvlddQkQt/aii3Ul4AuE1WZC96A?=
 =?us-ascii?Q?0br4lqSGSp0WQBTinFT4E4Y+1GJAK5iMBns8IgPMH3v4v8UycyzKwb8MLKNT?=
 =?us-ascii?Q?c/RF2MHkXFIQ9BUAedFGATyVaHjrEASZyG6P7sV268WNJJNv6fzvWjCFkkCF?=
 =?us-ascii?Q?I9EMIN1Yk96ov2+zDjhHfphfIsq9BI/nZkh6g9INuHqN3dKqcsZHP0NA99jT?=
 =?us-ascii?Q?YmG7fzGicYDB/+NtvOMevje3N8FLRUsUv+XVki03RYF50MZ8AsMp2CNNxR93?=
 =?us-ascii?Q?GKoHmjAnj57RoyIIGoZNNv5c8zn2jT/buS6idyFJdMOhLr0snv7BVtfGKh+y?=
 =?us-ascii?Q?LiK3QXSbfF37INA/5CpgKRK3qebOOv305+m+JE2N8m0t59b2//DNy6pvj0CF?=
 =?us-ascii?Q?rTnZhVuRLmE6CMpBJJ1COfuarXx9MahcShLyryt17rS7XKQmj5LZTV6AIltD?=
 =?us-ascii?Q?AoYdZ7zwxGULvQbXcxPnzQTJxYVjuryk/Xl9FjnzTA7PgHcO4jgndXMdk49P?=
 =?us-ascii?Q?bdNaqQGwS+WzCCeWMGh/mCrc5xBPsv5AmHPvMKhI61kcraUqMACMOHZP1mJn?=
 =?us-ascii?Q?0LyJn7eiuU9sNa40jGddgAFiZFeTfgyASwK5SRzOnslKOHTiBlTB3HeWIfXd?=
 =?us-ascii?Q?SLHgrMGRvr8sU6h8MK8jF4kY5/qeMh4W5QxIUO2RuwLjxxwQZfRJ4KNT2aKH?=
 =?us-ascii?Q?CBw/8KuLjoLoWGBSVpyYm8x+8i7EM+IvYA79qp7MoejKvva992+48YP3YrIt?=
 =?us-ascii?Q?ETFt+ZVIFuYM3JrAWTej8Fddkp6ygMsWebcxJGV6sd8YH3utcsveSPbA64dQ?=
 =?us-ascii?Q?L7j52Z5sRnDxxe7lcbvL50pfDOogfo12qg2FGRlve6uXALacdeHwkvjFXa9U?=
 =?us-ascii?Q?i/vdu04TGgBHt/xrSiHWvP7q/ggOlULl07cy8Zlz6aAajEvhAVVzcUCSMoQ0?=
 =?us-ascii?Q?A4WRczQ2TsMaiYHvTb4jbfh5ybyeMnDdd3edYFt+gHq1ooKmyQLtGFxX/CsG?=
 =?us-ascii?Q?YXoAu9f8MlXu9AtJldsacIg1laNidl9J1fxA30DSpoCMLGhYE9HysEeQ9RKC?=
 =?us-ascii?Q?6waouso667oMLmPbgYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xd/poSf2fhuFbSqGQp1YAqFxX9WtVvnzbQBWIOppeGCZ50L+UGI6eHoaVvUB?=
 =?us-ascii?Q?cMpgIkLTGFjFjdKO8Y+okqCqkFj2PBjZGMmvl8Z7ANS6hGA2lpVQRwUjWlJu?=
 =?us-ascii?Q?4sALZtdd2UQCBZ77vy8nTDuC6aFYyOP5xA9TUXabBTOiIUuwL9D9P5wySw+E?=
 =?us-ascii?Q?wyaIDE786mB2DQtRI1Ic2lQXye09AeVkMj7iV1z0znbQjPiRNM/CfRoL3vGq?=
 =?us-ascii?Q?6p2aGWGEVUMqx700ybkxoXvLwMm6xdx0IwVx6T3LkNZ/3EcnPDSuQ/lP59h0?=
 =?us-ascii?Q?BEdsGGUPCBFXhY8ASpR9g9TRBPYbngTmeLuIZuBJl5czlQoyei8UM/JPFNUV?=
 =?us-ascii?Q?Sa9lnTPm/DGuAlnYy9Uk9c/qoqcwBr8wfX8FlNlgAv1BOeyHWn9aZHuRevnP?=
 =?us-ascii?Q?sqaB2b2qjZ+D/bA0n2BSF54YDaegXIM/8bdTTl0Q4PkQ5WyYgndnUUy0hSSL?=
 =?us-ascii?Q?E9MJzxlDvfksCi26B8GcVGrfB5P+pPXjW30VYm8bGXNNwtsimhgWXfLVyOxz?=
 =?us-ascii?Q?lmyKaDjI9zYNem1eaG0kbdaF9Y4yMH81Xhx5ux23DFslQYzS8g9eDHO6zDrq?=
 =?us-ascii?Q?tX695uVpStevMWG67RTNpGuGtaGZhYitudyQuCTyhxlSqqpHPBe2nFuLaEeA?=
 =?us-ascii?Q?mnkHD03kaLIZ4bxrJOFIeJjn2hAEVa3pZOPP4OLiRXoRdsdezhiMHnqW/yl9?=
 =?us-ascii?Q?2Bf7SZNODAOdVc+IgQtFyaH+LlsCc4+yY12gKR8yrGZDv6IeopMfmVCAsjKM?=
 =?us-ascii?Q?nhAtH323cocFRNIy4UF2HTv2YEL0/fh9PRYCKipMyoZkeH5er5cqJk8+2hM6?=
 =?us-ascii?Q?9UQWE0ws9X0oU0JxnM6PTelZlTSjrDCaXF1W9WcFpaUewq7PxnpHuR9TGk2R?=
 =?us-ascii?Q?CqA3zNdDghfUfm1Ljcz7wBhxwcdkvqlmZhZfKqnuQxQZd0aEjuD99NDjtB68?=
 =?us-ascii?Q?VS2IhhOLDxoMdWRPf8FE91kRUWvI4JzKmrB1B8M13s33jSxybsUQeUk3Wnw8?=
 =?us-ascii?Q?Y/kjMDiCdIUFwyLmG24/KpQSP+Y6V8XPRfFSbmpCFyEFo46FUZm2RwpSbngw?=
 =?us-ascii?Q?vlxt0KF9glEZ05Xp9h9fXxbu6FgoDG6hMZ5Inu12dXulfXVx4gHQW/2v4rSz?=
 =?us-ascii?Q?6k7M/LfaepWGwmz5OR5oHlXOZcNY2KcJH47SbH9WrtJBHC8TG3SMHg7Mf/DI?=
 =?us-ascii?Q?zD4b/A6YA4A6DjoQzTL4JXCj3ih4Aq12tNHmh93rM1sOw/7r4lrv1UlfBuIb?=
 =?us-ascii?Q?QLOj8BE+POxyVfpzJnkOypcl2mJRrTLmw1tjEWzaJOVRWZ/DCHM7lG0f6hGM?=
 =?us-ascii?Q?ekuzdaUJRXLPITjFtc6G6qMMU0dLpgrAllaOGuzZKoXNZMOtvBHQswwbTNsM?=
 =?us-ascii?Q?JfZYqtgRi8bUXr2Qm+yqADMVPMQj1lPsKhVH9xowROVRWhHyfDkKAu/ddSBA?=
 =?us-ascii?Q?zmkX8GIgiUwFGY8H3znew1jV9odKgH+gMeV+QQ6jLfujiD+qeTFHCKKqzlPq?=
 =?us-ascii?Q?y0Uzjnmdp8jx5JRSTuKj1zmAvqococMuZwgamwi/Q+1Jx/I9zLey277WgAnr?=
 =?us-ascii?Q?aESkva3ROHIm9wGUuwTOxKqy4Q3B4eBTwbsA2nYmQBbLiVTK5iix68N+QuAY?=
 =?us-ascii?Q?9BmyEzhGZnKtw0qnEl/5fCaOQAzPOJSSxKA8nfeDiLo5zFCkzR1Re+Gj+mhA?=
 =?us-ascii?Q?I5+p/K2TT/zjZap927h1TfWN4IkJlypqoD8p/co6L2Q9Nm/VJAmg7INah82a?=
 =?us-ascii?Q?qn1g+YRthw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ca7826-4e89-462c-df43-08de6378e9f7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 23:06:50.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbyWV6/IwsYILif+Uk/W9mguh+wXsPZEiwXVYmcZ0pmmjGWdrlOren0FMmEg9AJ3gaKO1aEUeA6msbii6l8Xow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
target CPU. However, task affinity can change between the dispatch
decision and its finalization in finish_dispatch(). When this happens,
the scheduler may attempt to dispatch a task to a CPU that is no longer
allowed, resulting in fatal errors such as:

 EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])

This race exists because ops.dispatch() runs without holding the task's
run queue lock, allowing a concurrent set_cpus_allowed() to update
p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
then finalized using stale affinity information.

Example timeline:

  CPU0                                      CPU1
  ----                                      ----
                                            task_rq_lock(p)
  if (cpumask_test_cpu(cpu, p->cpus_ptr))
                                            set_cpus_allowed_scx(p, new_mask)
                                            task_rq_unlock(p)
      scx_bpf_dsq_insert(p,
              SCX_DSQ_LOCAL_ON | cpu, 0)

Fix this by extending the existing qseq invalidation mechanism to also
cover CPU affinity changes, in addition to task dequeues/re-enqueues,
occurring between dispatch decision and finalization.

When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
re-dispatched using up-to-date affinity information.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 58 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0ab994180f655..6128a2529a7c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1828,8 +1828,9 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
  * will change. As @p's task_rq is locked, this function doesn't need to use the
  * holding_cpu mechanism.
  *
- * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
- * return value, is locked.
+ * On success, @src_dsq is unlocked and only @p's new task_rq, which is the
+ * return value, is locked. On failure (affinity change invalidated the move),
+ * returns NULL with @src_dsq unlocked and task remaining in @src_dsq.
  */
 static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct task_struct *p, u64 enq_flags,
@@ -1845,9 +1846,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(sch, p);
-			dst_rq = src_rq;
+		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
+			/*
+			 * Task affinity changed after dispatch decision:
+			 * drop the dispatch, caller will handle returning
+			 * the task to its original DSQ.
+			 */
+			return NULL;
 		}
 	} else {
 		/* no need to migrate if destination is a non-local DSQ */
@@ -1974,9 +1979,15 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	}
 
 	if (src_rq != dst_rq &&
-	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
+		/*
+		 * Task affinity changed after dispatch decision: drop the
+		 * dispatch, task remains in its current state and will be
+		 * dispatched again in a future cycle.
+		 */
+		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED |
+					(atomic_long_read(&p->scx.ops_state) &
+					 SCX_OPSS_QSEQ_MASK));
 		return;
 	}
 
@@ -2616,12 +2627,30 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 struct affinity_context *ac)
 {
 	struct scx_sched *sch = scx_root;
+	struct rq *rq = task_rq(p);
+
+	lockdep_assert_rq_held(rq);
 
 	set_cpus_allowed_common(p, ac);
 
 	if (unlikely(!sch))
 		return;
 
+	/*
+	 * Affinity changes invalidate any pending dispatch decisions made
+	 * with the old affinity. Increment the runqueue's ops_qseq and
+	 * update the task's qseq to invalidate in-flight dispatches.
+	 */
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		unsigned long opss;
+
+		rq->scx.ops_qseq++;
+		opss = atomic_long_read(&p->scx.ops_state);
+		atomic_long_set(&p->scx.ops_state,
+				(opss & SCX_OPSS_STATE_MASK) |
+				(rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
+	}
+
 	/*
 	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
 	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
@@ -6013,14 +6042,21 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
-	dispatched = true;
+	if (locked_rq) {
+		dispatched = true;
+	} else {
+		/* Move failed: task stays in src_dsq */
+		raw_spin_unlock(&src_dsq->lock);
+		locked_rq = in_balance ? this_rq : NULL;
+	}
 out:
 	if (in_balance) {
 		if (this_rq != locked_rq) {
-			raw_spin_rq_unlock(locked_rq);
+			if (locked_rq)
+				raw_spin_rq_unlock(locked_rq);
 			raw_spin_rq_lock(this_rq);
 		}
-	} else {
+	} else if (locked_rq) {
 		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
 	}
 
-- 
2.52.0

