Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AA408611
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375015; cv=fail; b=dm9Sipwe6uNBr98d1R/+Cd0tf1Y69ruYJXyUHO8jMDs/7P/gZCFfUrZFT487VU9EdaxClV+OHvhEhKQlgdAhyWLiXMp+HQMuw75950V3Iw8fUFr+KnVTaxxAfS+W8tafIn0aQ9PDN+G1M6PgRY8C+396/zaRLdc8Z8NH8hk2cL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375015; c=relaxed/simple;
	bh=kcvwIKybKKzcol3iVrJEk1LRkelYglaoAix2h3kc9nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyoETw9218TDTzEjVVffTYbMJPuvS8d4kfpcrhPgLglrPsVkzobSAuVUFCdy1l++zOKIIyca7NH29A+e7tNJgJ0jsrFUUAeXb3Z1CEq266d2aD9hqT3XqHqvXfcjtJ4rFJHteaWrlrmezRiMO3OLI0/n1tHoIcgrqLr/wojMLig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MH76S1aM; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MH76S1aM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH1AoBRdRRrP3+FcHse5P+ozDebWnW+N5gbFM7BiTU5pUml5RxEHGR3Gky64mnqaS/MMqT9fQLvxLiowkfMSBPgz5Fn9xkWp+BNUV5GM/3qP/vinfyJraSOMPsGFc4mj6Ug//tGifvkB6m8TR+tRWGY24GdOiEtARVFQQ9ffTv+SX+ELl50tB8S3TlKooyhfGoqgOZOmESan70MewdXgn4OnHqw+TCfMkhzEl49GGMveV1AVZBb6iM5q5l9xonAA7bYNE4OpefMcXxPEmAj0cTjibS81BPW2cLMVUcwzolgIsuJHQ7tlQ0Bj1A6Qx2DbqxorPnr26l9A7oULWFgLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR8HoPedKgkcjxhW6QHclWvd2D6U6qNWxHUV16aYnNY=;
 b=oNw9l3350/o+sAEeAORJrIEjsksCGDUAK7g2nTIHQD/1yPALZHHu/+rv6qMRXLt0A8b+ayDOzWnSw5eKeSPSDS03uyjjhnf4fWICTbOZ/NtRhwq+QLXfoRtPFD8xB4Tu9L4+GvYDFWZEuJ+ViUBGk/ZXKUPPeOdxwyxSUNtbZoLs8Ay4IKfGpCaP2iJe5/0A3Z1MEsG6aNkWnAugzo9Llvzc71AQtjYDzwSYgCCnIJU3/Bt6Y2XY4IxNvzXNvC8/jl/Mca/Br6LuV5AKqwPOUxKsJvDnIY+Te/JvAobQ7fJSVNYD3myTqkaET3XACJjG6X7oZd8qzTflhdvct6RLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR8HoPedKgkcjxhW6QHclWvd2D6U6qNWxHUV16aYnNY=;
 b=MH76S1aM1Pl7IhgO4qWu61x8vWP4o6vT37g+w0E3sBssQzewjQMZ+RM79z6zxUqqI1h4A7vAhSjahRTA7pP+5uqXzvg41ghqdBlxSaxZIxoWcIcEQotGEYzvm4B0HYruyrLwn6r8QvBKn9F3/XronYSxulnzxySa9AT+hGzNCrUr2U9XiS9p/qYQcva5/3RySc28XXiprZD9diSSNz/gupy6YJ6C1Hh4Vfp4tbRPntbb5oCYBNncTb8Mh2mSj8rxrKDU7+WcCykT2EoDYOx6QrBfm/1J2PFrIbegcxnYfiwDlfCRjgA5R8NjeT/Xr5MwdVBxzkvfdsm6TiT3/PRffw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:48 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue path
Date: Mon, 10 Aug 2026 17:13:55 +0200
Message-ID: <20260810151523.86994-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: ce27bceb-af34-4b81-84b5-08def6f26599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bPD8rvYpbBULxDzrmc+MA8gZmz7fXbfGl2+93+FKvQkIvTW9Cg8v92STpGB2QAshjKDf7olG8LZ5d56uY3nD9ZObvRUdlu/1yajUV/4dffZZotrhynMI7dPmQJILkm8fpx5sYnV9WbUT1vGY8boj0A7ydeB7Op6ZuYFYNMMGaq1tnGetPWfuqQSES/4IkSrTKPND7dq36lg89LYg/Sft7NucxOATilwRTtGpJ/Aw+6WvFbN4YQKGGrtmueiek0nXQHEF06qaFE4kp1eAwoZ1jSPUbvlAPKqk0SF+WQq1ja3G26e2gbSMU3t5u76OVrSW+2hC4vK8rTvDnuqAVCtrI9NYcE018J2b6PuKwNEoiZu0ztkcsgTwOieEDoNOs0TT5i3QQw3iwLmmjBsGqBvH2HbF9NXLq03545K7aQT3RAklgSSdsECCxY702HQQT4n7fc+5NP6wFrC1kck/4P64yZuaq6e+XuvH0mcJr68u9QWl6j46cZMI43FRrObYFL869Soa1vJyxuKcZaxxlOsypv6AA9v6/qf6ufZ7JGfhYlRpyxX3S0d0J/HupYznV/80lqxmxJ2wR/LgkAxWr1ELGgQW2TqVOIiWw8XHx8YA9LcL8I/iRToFCYFGLRWrrp9mDQGyMtMkb7mI1qGkvY23G7384CRZng2uSbecUu31ZnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIiT6z5epbZV/eFG1Jy6WXhgcHEutVjKdntwF8UqoHSNa7GZ04j2cwg6c2IJ?=
 =?us-ascii?Q?yDDAyEdsrMIyqdGvWxB6kxoQGmLYwZJwDpHxZOYArMe25XaBTopkNMHrQ282?=
 =?us-ascii?Q?OIYU04fEfMQzeazSCYlBClNpj1bLPoJtdiGBKpL0D0tH/e4eKpbH8CEzTdgC?=
 =?us-ascii?Q?Z3vc9SvFeKF+xIdaSUys+NyldaCUYegK3OoqAEbkVCHzln+FK66IBGYsLGL/?=
 =?us-ascii?Q?hMRj3LqphcuL4vrfFTuAS0QvxA9OSFb+60M3cPmBrUw93juZiEIEhBD5NHBi?=
 =?us-ascii?Q?c6b5XqBdOjn0evg7bcHKgI3pq9mYt6X7K+eRJ6+LxYgTCUooZI1jhuT89g+t?=
 =?us-ascii?Q?5b1cJHbaYq8lsuDVw7XyhSBfwV2hNzRnf8V12Lg6gQsRiaopEKswyWs/F1ak?=
 =?us-ascii?Q?i8kIseOU0Ij635o0/464dHC6+Okyjl0I63A+x+h34DjOGwHCOVrPsOgCsl2Z?=
 =?us-ascii?Q?eTeQQ4aMNmqfHgAQLC25/yIvfP3ZuU+Z2f5lAdM08KPKkR9OB/oSUKizuzC3?=
 =?us-ascii?Q?IlwMPnf5gxRn3vV2P6ITrJqMbrMr+TXXMMSiBwMI06ovikjO1s0vb+53UaP8?=
 =?us-ascii?Q?kNbJQVaMLGX5pQI/hTOgEISvIzM5bACJ3D15SYK7ien+vyCjLupBF3ncGtmJ?=
 =?us-ascii?Q?1X6Hk0bB6KRd7967mef1aIlGlwA47sQsqV3M6nNaqImesR8DQuWu5QY117qd?=
 =?us-ascii?Q?NFP5YnrB6IKVMDmjyAJz9Yukbhe+LepWCOavJQbHSEWnq47CXpJxfGR9Ia7h?=
 =?us-ascii?Q?0PWssVjgO9hu+/GXRVnirUjzVmQdkzXZpED2wjztKyqkbHcihH5m4pOLyLnb?=
 =?us-ascii?Q?E4d12TqG+7Cbg1aSnq5ZfR2oXyjY4dw6dJxj8Ie0jvD56eGBXWFncDISFc/p?=
 =?us-ascii?Q?AonU9DHDuvq5R6v+uEb67yV4F/wIWa5f+87xYkvENCPSted4b6e/ZAw/scDP?=
 =?us-ascii?Q?7YBZKbSuBQaIQbvWtz5h1eKGmXUkLYsU4ouD7VcfUA9/ionjGIRRylqhENJX?=
 =?us-ascii?Q?WiYDqM51vSMHW6pebAdg7WENoWtdUaz4OjrfHheu/oIVasFJ4etZIgyHnpxa?=
 =?us-ascii?Q?KBOE+W9+FjNnsYtecmiy/AUWUC6z00rz5m98jdnQQ5AUKuw/FSSxx9IeaxYQ?=
 =?us-ascii?Q?ZPtQpBZYN3GdJd5CIVeowfNsnVu5lnpSikSURI0/r++cSxMnqTuRdhOZclGt?=
 =?us-ascii?Q?61mRriAgq4jRqnzhlb/8s47tgqr+qzyOCD6tII+JuhJ14MqcqCIGEvyI//dJ?=
 =?us-ascii?Q?1KB4VUHJx9e0gXB/22hroDy70y9sef92bnJrC3U5mkTUcm0OF5T1wwHu2SAi?=
 =?us-ascii?Q?7e0U6U2JXE3GKrkxoen0Sx0zKGJqn2xQA1SImA1alqebAfwN2kGhAWEWx9zw?=
 =?us-ascii?Q?km+NsouRp00bvz6zI/lbhbuzWJ4+/rdGO1dgcgyA8iessBq7S3rOk5BqGmwK?=
 =?us-ascii?Q?o9U9peXqGT2WwGwf4C+q37CB6PX723SSycJY6G3E3P6YkK03vytC7M4Xt9DX?=
 =?us-ascii?Q?rbUQova0XODpQL3EMpLFBQCJQ9eJscvYmehYk23f6dZ5zaoZ/dME6xJnhENc?=
 =?us-ascii?Q?ZxA893YhhtfEAWCi6DBPZ8rgtuFHHigAIH0+/Pg63x9kkY5rL488ah3rv3fE?=
 =?us-ascii?Q?DAMh8KdKz5LmLNrWbpGy6F2S+v8FACbcgJLMGWviyz72PBC07QPdj7Khu2Gf?=
 =?us-ascii?Q?SDwTev303FqCWCtr1O1Dvhyh55Yqhw/gsByoP5X6sa3r8ufHrk9cytwg9I/L?=
 =?us-ascii?Q?IfvZ3peWbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce27bceb-af34-4b81-84b5-08def6f26599
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:48.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZFqTr58RCm49GD1dWZA3sq5eLaeGov/MJwchPgdCCraVSvdfk/kiWdKOU8UK+E2XLS5yOrIOKT66vmCwfYirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

The reject DSQ is currently specific to sub-scheduler cap failures. Its
storage and initialization depend on CONFIG_EXT_SUB_SCHED, and the drain
path assumes every rejected task was rejected for SCX_TASK_REENQ_CAP.

Other transient placement failures need the same ability to park a task
on its source rq and return it to the owning BPF scheduler. Make the
reject DSQ unconditional and carry the reenqueue reason directly in
p->scx.flags from the rejection site.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 38 ++++++++++++++++++--------------------
 kernel/sched/ext/sub.c |  3 +++
 kernel/sched/sched.h   |  2 +-
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1ad65b8051008..b43b2834141e6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1632,11 +1632,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = false;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
-		is_rq_owned = true;
 	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
@@ -1841,6 +1840,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
+	if (dsq->id == SCX_DSQ_REJECT)
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
 	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
@@ -4582,14 +4584,14 @@ static void process_deferred_reenq_users(struct rq *rq)
 	}
 }
 
-#ifdef CONFIG_EXT_SUB_SCHED
 /*
- * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
- * from p->scx.reenq_reason_*.
+ * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
+ * scheduler chooses placement again.
  *
- * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
- * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
- * Rejection can't happen for root.
+ * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
+ * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
+ * scheduler. The private list below prevents a task from being revisited in
+ * the same round.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
@@ -4598,23 +4600,22 @@ static void scx_reenq_reject(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list))
 		return;
 
 	/*
-	 * Move to a private list so a task re-rejected by the
+	 * Move tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
 		/* migration_pending tasks should have bypassed to local DSQ */
-		if (WARN_ON_ONCE(p->migration_pending))
-			continue;
+		WARN_ON_ONCE(p->migration_pending);
+		WARN_ON_ONCE(!reason);
 
 		scx_dispatch_dequeue(rq, p);
-
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-		p->scx.flags |= SCX_TASK_REENQ_CAP;
+		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
@@ -4627,9 +4628,6 @@ static void scx_reenq_reject(struct rq *rq)
 		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	}
 }
-#else
-static void scx_reenq_reject(struct rq *rq) {}
-#endif
 
 static void run_deferred(struct rq *rq)
 {
@@ -8687,8 +8685,8 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(scx_init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(scx_init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+#ifdef CONFIG_EXT_SUB_SCHED
 		scx_rescue_init(rq);
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 2391bb0c0ecb0..a04eccd837348 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -752,6 +752,9 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
+	if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+	p->scx.flags |= SCX_TASK_REENQ_CAP;
 
 	return &rq->scx.reject_dsq;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ee3ba7b5b11f5..aa8664e189aff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -808,8 +808,8 @@ struct scx_rq_rescue {
 
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+	struct scx_dispatch_q	reject_dsq;		/* staging for rejected tasks */
 #ifdef CONFIG_EXT_SUB_SCHED
-	struct scx_dispatch_q	reject_dsq;		/* staging for cap-rejected tasks */
 	struct scx_rq_rescue	rescue;
 #endif
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
-- 
2.55.0

