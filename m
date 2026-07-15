Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E383CBE8B
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149008; cv=fail; b=njFoeoxZaJBUVNJU7kaBbUphEoEYEtFM28Yca02vTy2YLSPUMAbLce5mwI0w8J9ajIAFLUWKn3s1VOS3XqFCaBADc1xH4LDil7s+VUwmXVjmnRMhnHPBLzkmst951BYb6ownZr5M/al/yBpPTt+hqtbF7RYJY7V+LezfBnKTJfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149008; c=relaxed/simple;
	bh=g6Vie6J0sszGIGyJD5Pt54qepF80t/bxNqJEhGaNlBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDFjPq9Iul0N9kDQh6/4621mOv+6qpCT/3tpUY3PAxGXVzzEJ+cSsg51I+fpJsUGZsQnl8yBPbNf8OG9Syo+K8gr50eoDncjWF41Ike1EpYMzY5rdTMMFvLidiKVRvsOlXKB8HSia/lSqf1hjJBrUpBgrYnTVJqnBQ7lQFHHLG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WNEP5XbH; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNEP5XbH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poXrCBBS8RGhMws33QVp9p7yWV9PwojyAGLXrUsZtOgwHgZM9Qa2JkyXWBdPWR2bCN9+F+dfYRFmKjABnsWqLPAbH/9ZTE+UUt0xvEBBhcaUGGMW8I7m9hB0pRQp3Nkh/JeYsb3A6FvxEtIbxpDAVp/VhBL+05oWccdq1RX4TaWjID2V2g9EjMMcIMdkTxaNL/g7ZNKeatepFP0/P8ZPYx1vaAUCKubxP/EVgGWLFvl6N9pcEw7WvKzRCSbr3nENGVMUZ5FEHKgfmVY/UZktGZOudrc4u7auZ90TaNukLyW/mtWp04uWpqsUESRgAqgzW9B9sFYWFavRLl0c88EMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNPyf3knuTvYg5RhuPTL5tXmUdIx5kj1iYrALtx8c+k=;
 b=ABLeQqFs/ObtZf3RsL1lSI53sPOmV5eT5chA5mPJ0KxUiFvB1No7rx3H/9uRApwTl2T3HNgweGwE9BhG+5srDqXtm1aHvIWNtn359C4XH5u9g5ihzlkLTroAfLv20sDxEnCWpjZoxYqPhVpvy3g3lH5Ix4zcmtzghnqAO/WK1fA5wSFZxiALLVBn/Z/iofwafHMFAQ2pUbt778PLl+v5Yk1W37y8ytuCxbFz/vIfKQuMd507ucPGWpgsMtfXziZq8rhsjzdofrkdltA1hvrHcgtW7QIyAF9fdjdwaCcoZDE7Qm2JJ70xQHdctyfyzH8v+pj+9y/aCOVrssO3t01B2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNPyf3knuTvYg5RhuPTL5tXmUdIx5kj1iYrALtx8c+k=;
 b=WNEP5XbHlr61WAhkUR4Kema6D1zP2VLYDKBlMRJ1LSz0MACxq7uydhbGsGCvKapNze1odRCblpb3hUYld7JFqEzJsLHZNNxOpyrlHsIeo/JvRU78KOndsrZ5G1Dx2ZsxwdWmLfG5hbQ9pZaKPiUqmAwjvxULnuFM9tIFemR+7JNVIPu8jK3l6LuQFe7KR3yjSap9oj8OkR3qV/Q4FV6qNZqIUhyuqkelE8v0wF4wL8zQTw7FtgOu4OMJ2GaPK4Qv/Ad1ZOX1L0HYqprLdkDew1FFoss3H4FHvfFd1BgJX6DXA3Wvl2iEFMV2Ed/MFoEQTGQZu9XVzqB8rjYL8rQijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:40 +0000
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
Subject: [PATCH 02/11] sched: Add helper to block retained proxy donors
Date: Wed, 15 Jul 2026 22:54:10 +0200
Message-ID: <20260715205622.276220-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c3eed-799c-43b0-5b33-08dee2b391ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aUGULL4dF05Lkg7mCaHRTeY6LBwMLv0Sh7NRC8DLRB0B8ThMLlIQ3LYtYOeq6a9NZ2pItxwv6wQZ6SFAG4e8AdgAlZl7N4Zx7NVN2tDrBDxM4DLXKrGjLPAEy9d0l54RAineh5SgiQCvjne8HNX6aYCnnxivrOtAmPh3upq3wLL52l5vQyDjSudwlppGGIrYKiRjwZQW+klfRWFauUG4I28qpAa9nZeCh32GYYDqtDQI3ZxArrzViJQ3pkFckK5MaZ6gZezPPA9VjTwlf8HyuryZMeJr/6ZtWCesq3Lyima+oC5OBtdh16+QbhdJwGa/2CE3Hz7XDJvnXs6VQNeVuwCin3sw2FK9gFV0gYds0bkjtqtTzgkTXMtynny7Sxy1SidQZtKg8oFmHO3qYXptnPTtzeYyXidjVzfkam7mgLj3ecOr887qViICf3sgtjVL4KGUXS9LODH6jeXloHUDBe5c+6fc6Khyh1PF4U+xwEQvXnBDsOF4BFm6fN252U8r+8ZXnQJ8XyOQ/EKkTCmYaVoduaF/X3LoB1/v1RVnZpn+MJMayQUIzOvUrx0J/XAY0VYdIQ6+oztNvU2KUOAb+PehTB7zk0VnSfCTOeeX/Jd21cUNnUGxk271MrWMch5XTpK5SC96GV2zvKrf9XkQe39nZk5l825h9as5mfVjq+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJPQVLHg47lIVvzedsEnPz6TUmucOTCmRBeseCtuCR8RpenXMGiSRtu1rlVY?=
 =?us-ascii?Q?558+M06kuhECI4EeNc7C39yzrhPivp7lRdEv0xoI5yKIgPoa+Ahi6jmw7Pka?=
 =?us-ascii?Q?SAWOWyG5Khb4y3jBLWgyCDMDj+Nrs/Kr1cbF9/Yb10tv04+H4uqLSYDvyhca?=
 =?us-ascii?Q?oRcli4z6Ny2cvgDM3pOqtMhv5I061uqXrwWG/KP0JsuUI3bKmoIIe8PNFFDj?=
 =?us-ascii?Q?4lF2sQyJHKRUWRDKtZjHS5MKswrQdwy1zTHmbCeF3BEy7wXvkSHyMVfdxj/A?=
 =?us-ascii?Q?+iYB4iIiJBE5Y3vcdtFBx2Uwj14FL0mGnAUJ1C/uJEILXKmCTQjTFSaBMiMS?=
 =?us-ascii?Q?RGBwxOTlZ6vsl5lOpsXzN3u2F0sKqXsbPz8QMD9x4KqlHNTb/NYHPYO2LvUn?=
 =?us-ascii?Q?Kdy6hqE3iIkTXXbOh9Odb1TYX+9nhUbRYXoHExK44ToIBBPaaNON6XeoG5Fo?=
 =?us-ascii?Q?jNwpoVIeGgWYbB6HUpbztoOkJ9FPOunpzeNxVdWzN4PEnQr45F5w1YuF8V8C?=
 =?us-ascii?Q?tQJXAkaVVJXIcw25ypyTNSfnocXavpJrGBQQYkrJmSFFgtciEwIGUkeZe7cq?=
 =?us-ascii?Q?UWbA82g5vkAjKZCNG2MVnGT7hXA48g4y1i2q0645a+0einrQd/TnjHSy2va5?=
 =?us-ascii?Q?oDb+OAs/x2g2GoalKV67TsyaPxvDtnOSUMRyg3oifFaheLwG1iSRihQXonaG?=
 =?us-ascii?Q?7i8dWhws4b7bbbKQQyFB2w2txykua+YUWJcrCQFqTamA8W8IDAEYs/wzZqex?=
 =?us-ascii?Q?bBL3NOAKgB2lPvYbJcMWoVuHRwMYoMMaX5NocTHKwzl+gfW+t402bjqm6ajs?=
 =?us-ascii?Q?xAsCOasviAAHbr469NyN3L/8a3nTaYr5W4frLqtZyoJ1mF2iIe7nMYFCXcVy?=
 =?us-ascii?Q?IJklO/qCbzfgw+utZtNSEl0e29djjYCLrAOhJ7CxrTcn6qp+FPR1vbIakE7r?=
 =?us-ascii?Q?QHIJwwCxlzuqlvTmm1SS40sVy7b7Hem4xE44/ZKTUD9bLfN9iTkfIKM1POCX?=
 =?us-ascii?Q?DRLX0Nny8GQl3PC3CjQRmggHPRle8O5xjrJv0VzcYLtXN9XmnaNu/5nn7kYs?=
 =?us-ascii?Q?oJW99aXJzOJMehsPGeJKJKExBTPVQWtVUcN7RpNRfLM3jdfSDuDRUCl7X+ZM?=
 =?us-ascii?Q?3URbxSMH4mmuZNK4rRIgDVC7xXqj711Nu1Qlfe0U5iQEzOrl2eSEoKvUVOSJ?=
 =?us-ascii?Q?SYNo/IBrieeYxRkQyN9pRO6fQ3PGrtsk3j/9OJGd4XOOXz9QkhZJOeAVuVkv?=
 =?us-ascii?Q?/ImHRR4SY50jPjmO4HqOiQdLzXV3K2sMDftUa9n9uK7d98vBlSBVpRWZbfmo?=
 =?us-ascii?Q?KtsYApsOtoFxSIltimYFCskDZmdfXpC3hjMoAPwFgqbGfKAnbtkn+Yx8WwaQ?=
 =?us-ascii?Q?PSCR38+2VA25tL9IDyQZvymYqYs5fKLVVPep/wP7WphGXPQGDNXG4cIvG5lw?=
 =?us-ascii?Q?7o4ABDYQnT7wqhn0VOtbtHR/Yon4+KUI+nm89cxndFpvh/7YhLDNG4rzL/Cg?=
 =?us-ascii?Q?zaW+MTRczCfoID2JzuItFuQHeVkP0V3kyEapKDNIzG1eGQuxAXjND+jRFMOv?=
 =?us-ascii?Q?/I2PdUYI12vtxowhQ72l27GQWGjTLCTsnJN1ctGVE0buEDmbgEkQsHIYOdNv?=
 =?us-ascii?Q?yiuYFBpAhuzQoS3FU3IbeZ/NPE/7IXwYfhFLWjqqoO0PxjyGWyhdR35tgoBm?=
 =?us-ascii?Q?TL178CTfyh540bBNeKdRhKIwX2skv8Snboq0e8ycB1Jj2E9xx2qQRXbNFEza?=
 =?us-ascii?Q?3EQ6KSBzzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c3eed-799c-43b0-5b33-08dee2b391ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:40.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2thrW5WDZ5tlzXfs16gkeDwI5ntjJtAUbfdKg1lCM8MDbhIIRddHMbtBnLAnQMlNXbpBkWi/pu8JcdhvjATUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Move an active donor off the
CPU first, and complete any delayed dequeue so a following sched_change
cannot preserve and re-enqueue the task.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f47bcfb25033a..e7827cffc2f0c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,45 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
+ * drops it from the runqueue.
+ *
+ * Unlike the regular schedule() path, this must leave @p fully dequeued.
+ * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
+ * which would let the following sched_change preserve and re-enqueue it under
+ * the new scheduler. Complete an existing or newly-created delayed dequeue
+ * before returning.
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p)) {
+		proxy_resched_idle(rq);
+		/* Kick the execution context if @rq is remote. */
+		resched_curr(rq);
+	}
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
+			     DEQUEUE_NOCLOCK);
+
+	WARN_ON_ONCE(task_on_rq_queued(p));
+	WARN_ON_ONCE(p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 54cff94556c0b..6b49b13cb8ea7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2478,6 +2478,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

