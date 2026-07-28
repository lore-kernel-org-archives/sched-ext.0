Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F132BF24
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253542; cv=fail; b=chnHK69abaqZE/+UJGyL75kpvgYhlVU7wXJBvk3RLXrGmsmqOJxVpU6nO56VJdafwwhk3vUyRBIVSMwqZAB89H1c0yNrUDZjabnsDs9h1AmjZUHZUWFykRDnLM227LUiXzpCnEcfVzDwUx9LhqghP0yCDEAEoVSRGIp0xLyAf9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253542; c=relaxed/simple;
	bh=awWc4dW2qfb1ufVft8W+kt/NVD5sqEc0at6FIzUAh4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLBPRfHh/3IhevBf0/6hEFsdEMWYpz30aaWVZzfx/OBueOluQeG1tJQyh1BD1ea1ahlxz0Q6ax2dji5JiJYJ21XKkLJ7hqd3Z9jvocLpw5ckwaC1pY9Gg2C7RO0YgisUbmhiQ246E8FZyuyHrrb2pW8CUcMu9zpzADeclIq4s/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cemyMjzJ; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cemyMjzJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6750Kf8ZCtGw2xN6xkNOF7GkwnYq6slEfmn/U8tn9NMkqNcAJtAsYltP3iSxiqFJywrWGiKBEF9egLQ3eaGxatSJ/BXKU8358G/qbScUT4vKINu7aWPZPHkAJPSITSSB4fCAHfjEpaRRkmsH2+tFxHaOeI/YL5IB2ocIuxtdfRlVraqkg8UOzxzrVx0QyWFf25TNeeNuCQYxo66dKIEUqlz6gTitn3flo1VO9cUCHb4hUVFS168zTwtiEOtb8YguniFpoX2BXfAwYOXaB7NOM0I4cC1A8Pfb9M5SeUSbzQxqKDamALejfDqHSD1lTlmn1i7J0jALW+Fj8Ekpln66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZY64oCN6anUM50unUR8K7svOitx4uHI/Oz0D/907E8=;
 b=LuSeplAHls1bnGhtTTnf4d22UAUMvyAyDGmvS9IlzJo2cvF682e9aOcocdDsA6NbIBUdlECZY4h0T1piBzzJqWQYTyZWxirJbeiXGzvRHLu+YuzhihwvfaoDOmxsP62FzVFHRuf7dCtDS5AsuUemN4GufFRkv6afokOAqRgeC8AxFsQzPTAtC5wS9vkPsoYMlpg3bWU3O+usJifduHUlDWpnfBOfqzwHrqoK5bSMDgAcIgKGETRzEZrvusGqWlETF0i0rp0kQBXpNQbN/Hbck9wtVn6MD7XUg4W4zbaFuTay1thSAuSDOmQzpvEEfCA0U8c1u/Ku4WUABEhvU2ORpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZY64oCN6anUM50unUR8K7svOitx4uHI/Oz0D/907E8=;
 b=cemyMjzJp9dF2oMk2+S5cGDlYGjdwfFVf4kn7HdOlmy8qmHp1Sm6/KYg2BqEwwhBPjcnELN9ErE7dWEgYYctxe07DG+EEQ7JIwdca07eHXvacP0sBuMOp36dezsBqjAgVGRSynV8dvu2nRSzHyUU22U5l1TfHPZaycXnBt+P5GMsaK7eUB96xsRPqgbwEVHdk2uHcA7r2aRw3GMgDhFVUKfGryNDbYvwaMB7QuetB7J9KDd6IXfV5E4meUVkOeF3Ae8t4ak3j8PnAUq7B9RN7ZkDm1UeOlHJR/rIxEypsZQIUB+N2nujhgnFay+qcnCPZpfBZ8wPxlaLmvX0r4V+Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:28 +0000
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
Subject: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue path
Date: Tue, 28 Jul 2026 17:43:27 +0200
Message-ID: <20260728154425.1549660-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 14060acf-b51c-47b6-f2fd-08deecbf3f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KJg2HgnaYYx9F+MyUVtVAU9SUeEtE3iljV+oMLHFwn0qR1hz9Ds2/hXq2lMHziReZywM699+knlO9E/PkLMGqJETNW0/DMTTEC8z2fY9v6ub0lNq3v3LWp/ft9HvZFDHsXG1DD6AnIbzzmMfNEGPL8WMlJRl25gnv+UwCBVkYoe5S+B2n3QzCam4hyJWIz7KX+3XoVh7jWQYHjkWaQuLMOPv11VRDbyHGN9vVYcfKkqUF0hvXkPSJVn34uJCXHWYMk0t1h44Eqsmce6vtoJb+IFDPK/Dfc33nmUPqq3Pf9dttGTmhc9P6ph22iVwwNDO07i/6hWb6oxUYsUp/fcdD3C6YmcYLT63ezTadaleDqk/qP8zB25ma/BUoAYGZE2L9+h+JAvQECm+DbdhBD59M65JRMlOayArsneMEYgtNTdzs3zU0Ujlqf3US0plbNRbgF1cxlbYkhRtz8MocPaFbzpTjYW3/Q5B4V7bOOH1w0cNV7CspEmf1INdZRqopJBfpptbdpdQ1fky23Mp1K43MBDeOtgywVhFhVm4c3/oH2rd+RkiPdSUH0UBiqMkLZu4webJLd4+yAVs9c5oFhjkCUOTjlmQG6BadFfTi4wYqh6dMZN5Zq8lNr8b1tZv9QQ015hwBrh18wdSdsGjqnbep+uqaRygTyij0pMzOvMzoLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZYXnFTWA4hwaWuFjj9gwMMybtgLrTClxIzy/3FsY9bJSy/ydTrH/Eb/GYit?=
 =?us-ascii?Q?iiuFb3XhKwlsQlIuyMkGN/UaNQy6N8URd9ynx/1QgtL+V6BeObc2tAfD4E+0?=
 =?us-ascii?Q?kYnI+rrr6WzWmAe/aYB1wawlGsICpb1SISUTGniz9YOHcpfhJn5o1LSzn+An?=
 =?us-ascii?Q?MfpiAIDqcXNuhvZhiVQT7dEF591GTiyt9TDHGZ6e7cxn5Q4sdxsU+QAtZDN+?=
 =?us-ascii?Q?6fF0rBdvHIT2Bm8q2ryxfnOe4ljRZ6uY8EcQjAERBdXZ7f4RcNJS1cCkNsUH?=
 =?us-ascii?Q?rlAQZEXoP96IUlGpzkJf27vg3NqYbR2Wtr+f6mgpUwdbj5Jde2xacQ/jCiZd?=
 =?us-ascii?Q?IVrV/tzxcVl99iWbm8obILd8a/jVozxpVJtcDS4wdg2BlrarwCCOZf/VJHjH?=
 =?us-ascii?Q?5GgshfldFxOCOt96EDJhcPcbHBWftZJj6oiy6duc1KNskD69/YTdYgrfuxLm?=
 =?us-ascii?Q?0RfMBBcPutFnowOTREBsolHdKqflbstfBvffGZN1Lllx1cMBd1KFm7SFUsba?=
 =?us-ascii?Q?QjMtiZ8gXvFTSRi546Ja5OF2j1ExPTKmh9/fh8lSNLHY8bkFCH4y38Pch1hx?=
 =?us-ascii?Q?5YZ/XZOz9V7SgmFxWu2d7cj/aNuAjpHU32fXDc1NmXTSWIuG7uT7ZV8D6rjk?=
 =?us-ascii?Q?ZTMXJMbZvj0UEaj0tffRVdgLIyCxuXbIJ4vRZP6+0gWwVsU1R5kuEpdaD8OC?=
 =?us-ascii?Q?t62SO2TfxipfbKC8rCuhebyI+asAXQ+Ogu00RQRR2MFH/zpqvtkfM11YK+hK?=
 =?us-ascii?Q?BhWgx8XbLqCCKXS5WrFO1qke6UiCmoy8f5aJTRzbm/vcH7C7Bj2hfaf53H6O?=
 =?us-ascii?Q?8tpLy6cmUVSd3ZOPHPfKZinGDWoMqffjfRlW+cBZmUz+7fZBwhcJ0b0oPYn9?=
 =?us-ascii?Q?sx85S65g+qn+hXpsNpKqDBN7awSFHMvr7TgTH6ZTWg4Tv3EagxEIQCV4/NyZ?=
 =?us-ascii?Q?Bg1dff0sdT2zMehR4HqIUAxc9IE/Vx01uF6oSWI++5G37esbdJYOJ37mCkmJ?=
 =?us-ascii?Q?56fGuw1l/XJNrC6c3zmuhfOGbwtOzzutQIUSZ41xTnmB5X4IluR+R5ZnjUuC?=
 =?us-ascii?Q?2kYYxuX3EaL+zgIzSfykaX/HZ7XqlEhEWx+vUujWJOt/pLRMyqqi96E7kSEy?=
 =?us-ascii?Q?LBE7TJxw8CTijua3kBP6DRTp9vZFyH4kMi23L4XRtGMh/09BeMe0Q/eB9kEu?=
 =?us-ascii?Q?QsH1wNmBVdgOdkZ1jah6igjYR4lsyTVnbeaScnH/iF5ADWmhaw3re0DAJRqe?=
 =?us-ascii?Q?KkD76e6qhB6Ebmc7jmnxzJ6ADufgcDsLlj+oY9evMJV9wdnKQq3wo26+juYo?=
 =?us-ascii?Q?RIialGMC8NcRBWHfnhzt3eNCJQBwZhiwgxilHcHQ+d6p54ND/FHtJFff7jom?=
 =?us-ascii?Q?UOCjKRrrkIWlZbIPV7rHdbmquaYyqDjVMrHauNhbCOShsoH7gTKyos8GQ+NO?=
 =?us-ascii?Q?FDmXezGKfcBCXVuc8NJP5V5DSy/40bbTd1JDmhgEOfooAg7W3rIpdY3cLbYF?=
 =?us-ascii?Q?P1JPfYSRLVccaHCTMeMPUduAd/NNkrdHcaehfT8QDiyZTxSYbnBBTp6ONFDu?=
 =?us-ascii?Q?a0AUwYDeNWuHPX+YgNXOg5RLHZxO/IadXyvD2Y1LHiK/sLMHlcumvSRqT0a2?=
 =?us-ascii?Q?DQlNbVw30ML7l+AagxK31Oabuflt543uyZMqH3GMJIL7XUN3Rl38ZhzmFAwA?=
 =?us-ascii?Q?8OWUaJdWFUFq2aExXNBhBbrm8s1o9Leeb9oi4lUZgkDN6ZhLXT3p90/bwNWe?=
 =?us-ascii?Q?CDvsxg88iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14060acf-b51c-47b6-f2fd-08deecbf3f58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:28.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8m0yumGjZfDUewONVzfD3N2wGw8vFauVqlHzDLahZFgx/2yKMvBK0Nso4wIUirMf2EQnBNbidlAjvuZH/MiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

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
 kernel/sched/ext/ext.c    | 59 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/ext/sub.c    | 47 ++-----------------------------
 kernel/sched/ext/sub.h    |  2 --
 kernel/sched/sched.h      |  4 +--
 5 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 4785a02905ecc..0f25d99f5fdd0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -197,6 +197,7 @@ struct sched_ext_entity {
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
 	u32			dsq_seq;
 	u32			dsq_flags;	/* protected by DSQ lock */
+	u32			reject_reason;	/* protected by rq lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	u32			reenq_cnt;	/* reenqueues since last run */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 240d84a0aaa37..fd4860b7fce4e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1521,11 +1521,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
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
@@ -1725,6 +1724,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
+	if (dsq->id == SCX_DSQ_REJECT)
+		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
+
 	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
@@ -4396,6 +4398,57 @@ static void process_deferred_reenq_users(struct rq *rq)
 	}
 }
 
+/*
+ * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
+ * scheduler chooses placement again.
+ *
+ * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
+ * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
+ * scheduler. The private list below prevents a task from being revisited in
+ * the same round.
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
@@ -8421,9 +8474,7 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
-#endif
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 8758317035754..640e4a4f3c07f 100644
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
- * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
- * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
- * Rejection can't happen for root.
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
index 0019b75a2560e..b5870aeb9c625 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -37,7 +37,6 @@ void scx_discard_stale_ecaps_syncs(void);
 struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
 					       struct task_struct *p, u64 *enq_flags);
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
-void scx_reenq_reject(struct rq *rq);
 
 /*
  * cgrp->scx_sched is written by root/sub enable/disable under all of
@@ -86,7 +85,6 @@ static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcp
 static inline void scx_discard_stale_ecaps_syncs(void) {}
 static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
-static inline void scx_reenq_reject(struct rq *rq) {}
 static inline void scx_dec_has_subs(struct scx_sched *sch) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 79daacc2389e1..ade8bb393786a 100644
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

