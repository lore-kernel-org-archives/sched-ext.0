Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2552882DE
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995596; cv=fail; b=aAhlDSWRPCXJE9da3vTR0gavR6K/1q0HOosYdpzLHw2UhsqVIF09+e2BtLNjXP3fT6zYJfh0ghWqhrIr/gaZWgtBtPt54r3JtbN77a1BRFwQ39Tc7eV1gbfRURE9kJVYHWUr8saYVjAmwerKHHgLPfgxnqN89+4B/YdSp7GL8WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995596; c=relaxed/simple;
	bh=kn1IOtqeYpVZlIpxXLvlqxotENVzTp1r0WX5HMSDF54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIYQ9L29H4ZdT/M1+J16QKhy99+mCDCUNqKBGFvF5bXrEU7sB0XHKTv4j5hMtOefZ/zXqmTxuSTikgFV8/yQpE73TnFqXHmttpl/cn0t2AmafOubUiEDJH1ghr8fTJvV1zbnwJ4INUolPa74NRwCS1YBKahFAG5ePY3lISK8NLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdJiBR1l; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdJiBR1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLW/Ox+g77EXuazU0v5E9bCKQ/ryn1LhHk8XYjUznOVEQtQz2miBmSyDqVNtwvmsUg541OQ+N8bAGR9qdZkEUBe8KxyQdwtUB780xfYVAxofp9GMunA4rcAHpt+47WaPjztNXMrYUwJAZTdV/pWlnc8Rx/lyU2QNSIsKQyN6B4WH/sVt0i9clH2nib0Pz4Dt7rqkLCv3jR0N7tjF9uoOO8f1EBUunR8mS2kle5dows+Mgni1JTLZBdyqRAWOqn0MK0MHHZ6V8Q8ZASswRRv925qYL/J9bSkrJKYXfVP7JshLSlijXUkfZZREM3wwt8Fz89okYcouJrTHX2JWB5mRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdL+vJLMN5oTtzYRdTedCTMNufPNfrEcbJeQ1Jnt570=;
 b=p1Vg/p1zUin6pRhqE4YTRAwUGmqtIDW57r+AQsnZ3mM0eDCTSpFgC8e5/5NerVlfkj+QKNKgDoHpnDWA4cZ3EXPi/p11HNcGqjimVjLWUp/zLdaANOr+xbyv01bo979c+sRSR1+gn7xQdHUGIhKahDY3brqawcHAJLSwPWPl3jypd2MFnODiVG8hiDol6TipShcJJHdhc/Vq98a5ziyHEOcTIRlhW3/dSdop0j/MBbVHYJyz+mOwDHWhkUPDnGJhAxqdW0md4+/iM4v9CnnsjAgn+MlOo2khS+dZ1ZyAMhC/O5CEkyGF5qf43TQETpHzZyYkHOc+QbHNn1Wr1Sk1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdL+vJLMN5oTtzYRdTedCTMNufPNfrEcbJeQ1Jnt570=;
 b=tdJiBR1lfdskbhhLJjaX9LOiwDLz29N6eAtTm7hJUhZr+8XjmN/i7D0HEkti9FN5CMzHJAZ4EpYyVxOxomoh1GyFZakiaTStaDTEX7Uql3dEuwzjWtY+uRw/BWBB9t1ZvvbfctoJtzYmxcF1eZQqeRB1cKlkXKmN4bqApOMQEWKm0FHr8SC7s4XTzDg7mJM6kx5t0gpO6XuS5/ODGsfnaYCqO41/0my8lNsADje4P4PqvIJtK2JvPs+UkPn4WF4V3rXGCsmm+ZuAAsq9DDM6gmi8SGcB1Vq2OGDWCFm8f3+koz1CseUmLJAeUiOZd1vabeFK8jul3rAYY4STCINwPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:29 +0000
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
Subject: [PATCH 08/14] sched_ext: Generalize the reject DSQ reenqueue path
Date: Sat, 25 Jul 2026 18:04:14 +0200
Message-ID: <20260725160513.57477-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce6d633-d84b-4793-ad47-08deea66afbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5IWhsOxdS55qP9i+1liwtoaufVIX7ELjI8Bv4x6aqUotN5IJ4MzWAxzf4xhaE2TH9HlLqs5vcTcQu1aHyXRWWl3W5quWqZwu6+Z2iyGSmkHlbjG7A6m4vpqu3oNEA16zftoSO0O38vJCBpJ8UcVxUzEWTsIYBwQND50xPHr2ubuIA6TPxEFrNn5V8KyR26RRPggdh9yEBLK+Wy2uqYJG1RVUaP9F2yMgKwJAFSCejCFiHH1i3xMi3lgoGHLm7xPk6ea7VyZovG4zkFLBKVQS9HfCSuYKDGZ326PB8ubrF1RO5mYtCtONkaFsSnrQJeuWrKiQRkZT3T+KAsEC7qBekf1Z7ddh83T7xWi+qSPQsvzkbu323kGcL2DCzamIrpXdhu2g1cWDIvRj2WenVDGzIDQSnlpm7mLWqwCIggt/6ZmXJnXe6+ywj9UZrQtWv60l6SNLl3G4b7uREMScXq1u/G/JxdyQso9YLiuNbzb0cXKe/KzS39YV0jAXS/xOdw5epkiqyHCRNxPFjhhHqXBwC/BzisldZBaAGPxtbaEtj7U5T4cb7/Z66f6RJro4IF+saga7yk2NxoT3ZbWWW4WAI0i19Yqpy8a1+r8zW65X4+msqwY/Cyky+UhkgOXbdZxYlthVbUiH17DfxcLdseQzpU6TxNeYu1CVo2x1V2CpLTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8lULhpMdK6i7DspdNe6Zf7oztEVmojMaER0McqMfQKitBlYOONWdsiSzNXw?=
 =?us-ascii?Q?IBA/W6VTTIGA+8kDNCbuPm6fHLbu01LuvVoyQYoAXZxrvLOGsMfwx5yfxlmd?=
 =?us-ascii?Q?7Xy+ZAQDMp+Us10PuYWdBFgNdPbZdeyx4Tm0Dw/EMcTi8ZrQo6GniCgwqOu7?=
 =?us-ascii?Q?tfr+X/cOTv7aVWixu9AjTpv/y5uZJdvYuURKAqR8z6HsqNIrN/lYGPwWKy5I?=
 =?us-ascii?Q?6mHRPp8nK8L9Hpad24zkiJza7QERopPHES+C2xxUKIMwrQslJYjz0S8FUYJR?=
 =?us-ascii?Q?xI3r+3+DD3BHszPVOHCawYzfR8wXaGskW3pO3IXV1/v31KvQ1r7RQjhORZV/?=
 =?us-ascii?Q?97aOccbYnc5dNIWpxXJuVQQVzSHM9gpGFpvfaGdjroAWmV1orDuO/eXHaaYn?=
 =?us-ascii?Q?ow558Ov0EG0VwnDMnq475Jcb/mn77eK6S2C/OPKW7GTulOls9vu7/63QXjzh?=
 =?us-ascii?Q?w5Rav174NWv+CmlzGFckrEvVKDAz4Dn2xr0W32mQP77Jyw+FA07TlOnpZ3rd?=
 =?us-ascii?Q?SbPvZoNcn70dWbQFv00J8W9WfxlgEG6N/42Vwo1TBeZZ2vinto90/sWWpJYx?=
 =?us-ascii?Q?bOvboJ2qGOQfLIrGPypg7wzQ07sKSz7J4ZLOTa4lIIyaC8pTN4CYuiDnVEhJ?=
 =?us-ascii?Q?boPYC5kUbpTa0mVH6bDrbHWQPuyRYn2pf3JeWUMiBpCW5IrwnF1gfPnr+QLu?=
 =?us-ascii?Q?U7N+aQADZVzxaRagi+VkP69qHegPM9Zl5U0gyE+59CTjOXdhyet0gjz5SvgM?=
 =?us-ascii?Q?n2R3I7XBNoquu02DGUZoFXqOHrZXFzo/pNquct7Q+cFCP8Ph86kRw9w5EVAm?=
 =?us-ascii?Q?3fDFyF8peGzHDmnwlB7jkOSUyPnaarpr+B8UXpzVE1W6ajXyqBT6yIEn0gix?=
 =?us-ascii?Q?ONaIcMjYQBgrJYpTo0y3nbskQT3tYHy8Myvr5IgluakzncxQLGAl200fHstP?=
 =?us-ascii?Q?ni7DmIUj+GmNp5sWl+NP/0nnd903vx1jS5rQE5TWZji3HfOo3JgQJotJYyEA?=
 =?us-ascii?Q?BHqw+e7WikAZ5ojNHFSOdurwtBXE6bHcJLAtsYsu4IP2qYDQZPlZUfaIiji9?=
 =?us-ascii?Q?akTeipG0MYJNoQTpUYRNxou2CWp8H2rYgPZeSPvbCVXCSzDUbM7s3iJbqPzM?=
 =?us-ascii?Q?Scxw4H9LY945kQYUMNZbeQtRr4aqjDpLQVVefFxniEGhpYKd/4v+O5swksBm?=
 =?us-ascii?Q?t5R9t6U7F7F0eSTqq6In8VqXS595yZJtNXQZVOOOgkzErdncZVeHmqSXEelH?=
 =?us-ascii?Q?tkM8LQ+cJERxf+6Yej2ZVll5WiKpngk5m11T+hI9qdFV9HJ2ex3DOkFM6RQZ?=
 =?us-ascii?Q?O7ABXdgkdJ/QiB+qF59iswMHhRvmKk/l8lTi4b3ukwmhYs81/Lu3bhHf7ftJ?=
 =?us-ascii?Q?opZ87nEHI3MW6SU7089dMbU6b8/Fyv0TZmYIppf6TTHcbt+F0DPEFwZOPrbh?=
 =?us-ascii?Q?M2weUscIo8cuzChSNKNCZ3kQoEhWhBSrC/cvrgmRNNToQ7C1Eeejg9riYEOQ?=
 =?us-ascii?Q?yaPZQIsWNRYloYDg/nDqAao6rWKNUMn85ug85lag5HoJcHFV/I3hyaDssXkk?=
 =?us-ascii?Q?6wadiNyzFVk60PLboz+sLlOhQqcHPMY1YYen8c3OSy7xkhfaP5muFHUQ1/2R?=
 =?us-ascii?Q?xYKEuUST3a6Fe+PUBosAllsk64x9GWuKtTAgbce0uynpxCKJ/2iCkU9035rG?=
 =?us-ascii?Q?nnET4ID+fSXDlT3X9Zh9Vfy3UGaJomWJEJm0EA55F2ymEKx3F8Ow0qyPkA4C?=
 =?us-ascii?Q?Oezcm5iEGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce6d633-d84b-4793-ad47-08deea66afbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:29.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gc4EZcR9w39hVjC4AuJ902vqSviJ4JnW/YOtcaBognAdY//zTbhN9bAshKGX5yF3eM/KHr1BFcGePKyZV/rf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

The reject DSQ is currently specific to sub-scheduler cap failures. Its
storage and initialization depend on CONFIG_EXT_SUB_SCHED, and the drain
path assumes every rejected task was rejected for SCX_TASK_REENQ_CAP.

Other transient placement failures need the same ability to park a task
on its source rq and return it to the owning BPF scheduler. Make the
reject DSQ unconditional, move its drain path into the core sched_ext
implementation, and record the reenqueue reason on each parked task.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext/ext.c    | 57 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/ext/sub.c    | 47 ++------------------------------
 kernel/sched/ext/sub.h    |  2 --
 kernel/sched/sched.h      |  4 +--
 5 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 92f21b0e2ab9e..91b255fdd16bc 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -197,6 +197,7 @@ struct sched_ext_entity {
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
 	u32			dsq_seq;
 	u32			dsq_flags;	/* protected by DSQ lock */
+	u32			reject_reason;	/* protected by rq lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d9f9d039459f6..2fcd303b44894 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1512,11 +1512,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 enq_flags)
 {
-	bool is_rq_owned = false;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
 		dsq = scx_local_or_reject_dsq(sch, rq, p, &enq_flags);
-		is_rq_owned = true;
 	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
@@ -1716,6 +1715,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
+	if (dsq->id == SCX_DSQ_REJECT)
+		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
+
 	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
@@ -4379,6 +4381,55 @@ static void process_deferred_reenq_users(struct rq *rq)
 	}
 }
 
+/*
+ * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
+ * scheduler chooses placement again.
+ *
+ * A task can be re-rejected repeatedly, and there's no repeat limit here. The
+ * private list below prevents a task from being revisited in the same round.
+ */
+static void scx_reenq_reject(struct rq *rq)
+{
+	LIST_HEAD(tasks);
+	struct task_struct *p, *n;
+
+	lockdep_assert_rq_held(rq);
+
+	if (list_empty(&rq->scx.reject_dsq.list))
+		return;
+
+	/*
+	 * Move tasks to a private list so a task re-rejected by
+	 * scx_do_enqueue_task() below isn't revisited this round.
+	 */
+	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
+		u32 reason = p->scx.reject_reason;
+
+		/* migration_pending tasks should have bypassed to local DSQ */
+		if (WARN_ON_ONCE(p->migration_pending))
+			continue;
+		if (WARN_ON_ONCE(!reason))
+			continue;
+
+		scx_dispatch_dequeue(rq, p);
+		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
+
+		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		p->scx.flags |= reason;
+
+		list_add_tail(&p->scx.dsq_list.node, &tasks);
+	}
+
+	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
+		list_del_init(&p->scx.dsq_list.node);
+
+		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+	}
+}
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
@@ -8382,9 +8433,7 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
-#endif
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 765b516e06c95..f4ce5b74b7bfc 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -284,6 +284,8 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
+	WARN_ON_ONCE(p->scx.reject_reason);
+	p->scx.reject_reason = SCX_TASK_REENQ_CAP;
 
 	/*
 	 * Only local DSQ can honor IMMED and dsq_inc_nr() WARNs on IMMED into
@@ -315,51 +317,6 @@ bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
 	return true;
 }
 
-/*
- * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
- * from p->scx.reenq_reason_*.
- *
- * A task can be re-rejected repeatedly, and there's no repeat limit here.
- * Rejection can't happen for root, and sub-scheds can be safely ejected after
- * triggering the stall watchdog.
- */
-void scx_reenq_reject(struct rq *rq)
-{
-	LIST_HEAD(tasks);
-	struct task_struct *p, *n;
-
-	lockdep_assert_rq_held(rq);
-
-	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
-		return;
-
-	/*
-	 * Move to a private list so a task re-rejected by the
-	 * scx_do_enqueue_task() below isn't revisited this round.
-	 */
-	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
-		/* migration_pending tasks should have bypassed to local DSQ */
-		if (WARN_ON_ONCE(p->migration_pending))
-			continue;
-
-		scx_dispatch_dequeue(rq, p);
-
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-		p->scx.flags |= SCX_TASK_REENQ_CAP;
-
-		list_add_tail(&p->scx.dsq_list.node, &tasks);
-	}
-
-	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
-		list_del_init(&p->scx.dsq_list.node);
-
-		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-	}
-}
-
 /* record a caps change, see struct scx_caps_updated */
 static void caps_updated_record(struct scx_pshard *ps, const struct scx_cmask *cids, u64 caps,
 				struct list_head *to_deliver)
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 625d7ce334aa8..08d46b92633a6 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -37,7 +37,6 @@ void scx_discard_stale_ecaps_syncs(void);
 struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
 					       struct task_struct *p, u64 *enq_flags);
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
-void scx_reenq_reject(struct rq *rq);
 
 static inline const char *sch_cgrp_path(struct scx_sched *sch)
 {
@@ -72,7 +71,6 @@ static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcp
 static inline void scx_discard_stale_ecaps_syncs(void) {}
 static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
-static inline void scx_reenq_reject(struct rq *rq) {}
 static inline void scx_dec_has_subs(struct scx_sched *sch) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ca436a8174d30..00a7f864ac23d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -796,9 +796,7 @@ enum scx_rq_flags {
 
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
-#ifdef CONFIG_EXT_SUB_SCHED
-	struct scx_dispatch_q	reject_dsq;		/* staging for cap-rejected tasks */
-#endif
+	struct scx_dispatch_q	reject_dsq;		/* staging for rejected tasks */
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
-- 
2.55.0

