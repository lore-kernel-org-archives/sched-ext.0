Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832B3469EE
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012823; cv=fail; b=CkbXudlu02Z+pRLOl3xZileag8jFsvSK5BWDXEeBRRTCCgfpASQUzc6kLPuUs+PqMi+nAbnVyoxYRabBsqRQX9D8gjniBoPKL5ng1M/Wo3JM8OLsiRR8RRZIhuy0np1bKZabVqPXZLE+prUN0wKbO3xbHOjqbsg9xkJkYJwfiNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012823; c=relaxed/simple;
	bh=gQ2my5x122V0YhaOZhX7/SDMxa0Va9MUT2UGdPLD4os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbjjD8BINU0CCPzFCd0Pg68GZxZk3Z4xT+TbRCkLzZuIPx3bTJnlB31wMIO1mx7Ven/vt2R+dNCrFhm+jA7U6JFQwayIuZbgi6nWlygWoyhDGZyIxBNv9OI+o1mKLSQIbgBuUdvWC7NfeYdv7Rqi6gRDAx7PC12XSNFe9XW3vaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgkwYCXh; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgkwYCXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1z7iEGAyMvd8AfZqy2EpYxg6mlklgBpdmoru+U/bs843r80ecobRL6L4LaU3J24EDMq3cjiLGWIXrv31jjfMGycGoSvd69NHtuL+Z0yz1LtpD8dz5p/IWfoHn/VO1LaOHnjTNunXEnMckkHXWE6NdL0Mn1eAATQff2CLTMiazOSps+wWLL9yzxcXbYCWTtxsjTuS43Zvawa/bMlFH7Yc+TURJ5AUP+K/WfzDHUG9jdw2ZlT0C3jPJ6LWqkiXdITZ0CwrvKwkQcHYdK+JyKGXhyBGHRQQGNblyRx8PRAi2TP+HBp4WZpE2nHCQejBL7lEHQBX0hJsJVRtf/UQ9UKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BusbfnWQmNv1VmT3WIWxpGzjuMdDMRLMXgodis5hftc=;
 b=xwUe2leu5Cq8OE43PzWihaye3kIk/ERWR79WPmFTyzA0f4X/P4U3nIxfQV21zteeTi9L6KDIF0E4PaOW12qe5cMEhQqr8JjzsBauxvpG7pwww+uUEyS2wKlyUK1w2614pqRu7cf7qUEj55xcYui8p8wFG9Li4JtcA+vSpqWSdqdr6/Ver1NZRhUnALjWEpXnia0H2JIbROomz56Y++/Knea/ZCbDJnBsWcwU/q0PWW7ygKMMFESRO+B0FM5grZk/KapqsPQvKaWzvGgJ79J+xHJq+vr1ctDHI81WA1Bq6mPeiLjysNpQyWu3IAegTmNjZn0UQMmKWC4UzYYlgziiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BusbfnWQmNv1VmT3WIWxpGzjuMdDMRLMXgodis5hftc=;
 b=sgkwYCXhAOb2S1qxbiDw8JskED4okAz80t71/RKvA9+8ImFyL8LCIsFEXJXOLEWaB720Bgj6tNxbDIIdQ9Vr0e7LHiXjCwYsjFUavjKuN65KcgnXyrydRDiGs0SVuwHC7wBiqOUVyVdhsyNd+UkkC23cbDDXZ7ZxJcvYvZUtEfDEQaziczc08NKBrlLjtgiPaHVXBNbgSuZhHEohHB/+BSyefYz/r/0xkCp2tiF5oSLf5D7TI61yKdusope7G4j+pMQVAmu5XeaNAnynTrHYkGduiq9HA6xYZa74Dbj+Ka+XP9Al9ctYx5hJY4kw24YCUUqMsS/LYYMyGANCynyitw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:16 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
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
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Thu,  2 Jul 2026 19:09:22 +0200
Message-ID: <20260702171909.1994478-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: f60fcaf9-8d78-448a-0e95-08ded85e2f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gkBSYC3zDZ5078CvYuG3YSZaWwplafy+34T2JRvr9pPJZ1iGJCQVsTXwP5pcQs1nWWYZsyvAjx4rSiWBWyJ9VyuSpx+SK37BLbkIu4yjfD4+iALN1F42rIJk9KbZhBd9YjCi1QJobU4DV2OOViaOrmwITxUOe18ubwiQ/ZY9N8NA5c/Vc6OMrjaiKWae1V9bh+zE9vDbMsU2ogyfIHJ4Gaisf3a0Pl3ssZnGXb5rtOmQrZPqtaW0AE/Qtyo199GGh3g51HeS6pkK3jM7Q2KoZwTvtuM2zlpzpj1pOJ/zCiE3DpMJqnjFtzXMqv15wPt/aTIk5VkqJL+XPVTjWyAJ0iVZdr/yfGbxXFE5IOv/gBgFMz8Y45SCKcUVUrvt2kcaxdHnOQoXjzyeJ5nWh25ZPFMNkmYdoEnJepumZE/cozUUJCGhEiBxauy7U3oSJTzKL8KhCpMDWf+MJ5yTL11pg1PWWeaAVn/VJnINSs/GplP+ejxRjmc0L0p+gEJZTGmMWrdE89O7LwcY2HNap6O6n4MwLAoE/vXOo+rZb3e+C2kAxMyY6byX82qHBxQSfv+laZzmSzXqDHDz4DspPzMYii4ZpuikfcBR/4Tp7Kx2T9CqE6ZPVX0OLuhix8F0Msb7vX8eLghTDmmHqja8NumkQDvvjX9vhCPOHIwoJcbDX5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/RhwPY9alH928DbNnlUd9s8nrUBJbT4STXRcQ9WqDjltQzdlUC0sIhkhTABT?=
 =?us-ascii?Q?28XJIkKvlliQPFmyyBLhUaRRT9hK0g5311ZVtgoGVVnmBP8PyhL+gRCKDwA7?=
 =?us-ascii?Q?kVsZ3wtqPbUcKThu066I2mUdF0eLHxtxV8Z4HxWIV3V9/LpGxfOAI/JWP+w6?=
 =?us-ascii?Q?FxwlPuyxpN5Tg3TyL9NrcshSsAVrD8upKMpu9bOJPuqyBGf+/JHokhH2fc/9?=
 =?us-ascii?Q?ky0GESpkzIzBFIFYZDpSPZKFSmduwC/X4HpCI8qTtl5XNTjKcDWhv3rnCkps?=
 =?us-ascii?Q?EcAxVKQdU4g0ayoUqSPsOZQyX+swCjW8YaYKZpGHTOKZ5s1ExxoNwYrgIoD9?=
 =?us-ascii?Q?54uW1A8EowDru7sp7hFjVstrXwDr4PWQtlOc9M8Fakh17Mjr7FgZ4ZDuBiun?=
 =?us-ascii?Q?XDNJwkf8nMpBDPDK40SmbyHu/FVlRdCfQWzyFm7ziMLIFQj10G3Bz+zOHSQp?=
 =?us-ascii?Q?cVEbZDpya8FziwoLC6svo9hVBBpXoiQfanK7MYr5dTzoAFMPDSp103BApgdg?=
 =?us-ascii?Q?1c5w5E3Wb9yzXHWF0yO/vOPgKW8A9bCLDClIl8On38+OPaKK0Ml6v3du9g9l?=
 =?us-ascii?Q?ORWK9iIvE1ZOYREjikBtrF6aulUPtwKgRMYPlSPubdNDgNsIIWGjK5+pzejK?=
 =?us-ascii?Q?bnnufXUZR/H/mAm2uZPDzi3Q+tJxsRyr1CWzVPcSg4OTQu10Sk5J2E8qON67?=
 =?us-ascii?Q?hFhkvEny/ox7W4T3oxypdIBqe0rtyavCeCYhW9/bLDQpUo1U9Dc79eXrNeQQ?=
 =?us-ascii?Q?HBFmcwCnoWqkt2iqgfvBiG94e6l6/yeKPMnGWRlZf6zhKpksNCKIGqEa3i7u?=
 =?us-ascii?Q?97JyzC7dv8JKw4julWQHKnhhCfCf8M5qovSmX+zkY3aHQmfVBUNdH1cvKBPZ?=
 =?us-ascii?Q?TfWUhmLGAu8pMuJDvdn7N/9P6YbbIgZ181255NZ4wkytWG0yQpbXd6Eppk0Q?=
 =?us-ascii?Q?KeZZNxdLrCAdLhVipOG+9/4C+Yoyb6CAFb9rdnXCWBDPelSDbPglzAdnvY3O?=
 =?us-ascii?Q?FRiQ25X/MMNu7O860zATv7Et3a21/Dl6Ru0U7b5OgMISDBo28RqUcxK+Nshe?=
 =?us-ascii?Q?j/z85P+OQPdqnpUw0MrgzvUyzxK0/BbjlXcyhGdHQsNKCSZPDSR7y45jj5Y1?=
 =?us-ascii?Q?TGdKfTjfbhXARGtUvDm/CLqq9N89aOTDsHiX4Qg6DMi6x39R3a9JXQ46ehrT?=
 =?us-ascii?Q?x5OAsgyGQSf3x+Sx1XnpR5CARovGDgsP3i8KiM3BuxPF4WW1hyjXIGK0c7rq?=
 =?us-ascii?Q?NxJfonssLngmTcMmCOBATL0CpxdERkNkdO4GgCv1vacwVwCZvahNiLNECzKQ?=
 =?us-ascii?Q?Ugxn46dAUbVr6k/OMPDReIW3HBT9ZxoCQyZfSBQfT+xlapc2DsoFoDaJnw9m?=
 =?us-ascii?Q?xN6K1SDWemaNCqjtXUXygC2pvI9YsLI8R6Pw0rL47y/R8iBXAL77oTLjIdoz?=
 =?us-ascii?Q?XFLICeQkhllHIRC7v98d2U1gVHYJIcMQ2fifrzmLwJmtAREQqQQt1C4eamKm?=
 =?us-ascii?Q?GvoIfxk7O5K3Xm12ixnVoz479y6f3ueomjmpcMKCTEVnbi4jGmfOzn+Xf67E?=
 =?us-ascii?Q?HmojJx9m5S3R+PRnQ7NbCxG02wpnrA0dzDBvBK1bmPSk85/927jNLyw/7s6Z?=
 =?us-ascii?Q?9Jdkys2yPauGpyJvn69CWN0pDNLwbbOLzDx9LeNfPcKlO4PBK+fbEik1CBMv?=
 =?us-ascii?Q?Dr1WH0TSiB+NP19yjJMuvr9LG2gSlb0F8dlwKA2cwEmd2f3n11eVPalvNE8Q?=
 =?us-ascii?Q?mXsvCaBkAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60fcaf9-8d78-448a-0e95-08ded85e2f6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:16.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vknz+/hG6pRNqVsy5zwCNrufS9bAWuIpP+hRSZehmReglSySergEDwMnNhAULS9jnDKoSDrNHt9oAz+Up434w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

With proxy-exec, pick_next_task() can return a task with blocked_on set
(a proxy donor); put_prev_set_next_task() then calls set_next_task_scx()
on this "ghost" task, which fires ops.running(). However, the task never
actually runs.

If we simply short-circuit set_next_task_scx() for blocked tasks, we
break DSQ bookkeeping. If we only skip ops.running(), we create an
ops.enqueue() -> ops.stopping() pair without running, because
ops.stopping() is still called in put_prev_task_scx().

Fix this by introducing a new flag SCX_TASK_IS_RUNNING to track whether
ops.running() was actually called. Skip ops.running() for blocked tasks,
and only call ops.stopping() if SCX_TASK_IS_RUNNING is set. This ensures
that running and stopping callbacks are perfectly paired even when a
blocked task is picked as a proxy donor.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/core.c       |  2 +-
 kernel/sched/ext/ext.c    | 14 +++++++++++---
 kernel/sched/ext/ext.h    |  6 ++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 75cb8b119fb79..e599bb86f8acd 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_IS_RUNNING	= 1 << 6, /* ops.running() has been called */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4c98b4ea6b0..6aedb26c08ee7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7189,7 +7189,7 @@ static void __sched notrace __schedule(int sched_mode)
 			 * sched_ext tracks curr/donor itself; re-entering set_next_task_scx
 			 * here dispatches through a stale/NULL BPF ops vtable.
 			 */
-			if (donor->sched_class != &ext_sched_class) {
+			if (!is_ext_class(donor)) {
 				donor->sched_class->put_prev_task(rq, donor, donor);
 				donor->sched_class->set_next_task(rq, donor, true);
 			}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 189ba9c42043a..b0ec579e3a3ef 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1985,9 +1985,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
+	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
 		update_curr_scx(rq);
 		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2725,8 +2727,11 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
+	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    !task_is_blocked(p)) {
 		SCX_CALL_OP_TASK(sch, running, rq, p);
+		p->scx.flags |= SCX_TASK_IS_RUNNING;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -2815,8 +2820,11 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
 		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..c7fa4d06ac7d3 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -35,6 +35,11 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+static inline bool is_ext_class(const struct task_struct *p)
+{
+	return p->sched_class == &ext_sched_class;
+}
+
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -53,6 +58,7 @@ static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
+static inline bool is_ext_class(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
-- 
2.55.0

