Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96131572697
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096133; cv=fail; b=HN9JcIdlD2DaoSyRDIevztFEPRC2OFbbFRfQIu7SR3byEPWsQbvx6yqP2K3dxIQeca4FjYHE4SEG0hPj9t1LY8jS9K8t85ywHuBu/2UR08r9zlHljHUuI1wKq0h88I0jWlbFtwXwbg3rrCU9x60+88guyc052ekgUf7HEyEwyN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096133; c=relaxed/simple;
	bh=Li0l4H5wHMot9EO93ibKx/kLH5jW2VjqQjaL0sTD5Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGXf4/PwCZHAgkL/MLAD91q3vVond3LKaSt6RdAsZ+eotSkalGw1cftm7ZvvXG3ymCFWV5xXOKT6nKrZXuv4gcXJ7TzwIvx639c/BFY6j+/nKv/NGC5A5YElkhh3h1VkhrcnSjb1XoF7ry7pKDoYF8/6zRX9KMFWN1YAlQZ+Xuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OwmBysQ/; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OwmBysQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCfGpMQnJhlf0QNA+1PuqlNl8NagwSaeSpbRELcKvs4mwzGwwvI81B0bqLzDGK4hFMfAtwnAX5Ta5iFpxIvgKgGOG0bxVF8CBeBp2DzdyUVW5xoLci8/I6AGQDDKkyC1h7vsa+El2c9s34SzmIrbdMGQ9W3Q5HK2zMnD7OPbvBsO1KLcOXvY5OhqxwkGS5mwgJ1uOLUWlsevOs1ne4qtjAe8NL/a5xCstjbR1jxVlsidPfLTVJyVKB10n6bfgzK4VSRi9JV3loqGO/I5j5zw/ridQ+dVlILsyR7YDWvmt0NfxpRweQnzc3rVZHiD4tw4C1/s+mIp6O5z2qTsrrYknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMxifVclLlESYF30LW4f/1QPsD+d12KRkUvaiyfmb2s=;
 b=s+TN8xLt1GQ4PqcAIqOBhwHbSq/Nf/V3tCDej3sv8mNxT0g5t4SBPtj6vxszKfecjx8wB1cCDNwVmTAiwpy2xpEeWuKbf+/hxUDJ/aelHEnHU4VWWIKsAu2KB4+JICLziBpJHWfxIW22AdoCmRQCA9A2QjJLLULmkZX4ZBjjAjnMOnD1BMeMyvrxAPFeCktcvZqGSdpeY8hjZcUSUthTUS3XxSSnWy9fwu5Z36wBuWlzt5LcL2eLcWlFBsgVad3M/A6+k0pEREXJL/3GpLZnQR+ns25Y4jK3WVdpnOx1aiKlv/cdXF+3LW9Dwu451fueFxBfy8oAqzPizlKrdxL8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMxifVclLlESYF30LW4f/1QPsD+d12KRkUvaiyfmb2s=;
 b=OwmBysQ/kBaziPlLOP0/iZ+vF6M9fvN4g4PjqTeOCSgu/YOlG5uP8XiBgipnA8RyqxQcSiKTvdejcPbkAooyJYpD6fWyP3/jJhLAljp2IZh9AdYrzGK967C0f7nkuiqW3p5UzajJ72n3svRv2CiLAzwABp41L7lOT73yxfc6HntgdOXGFhNSlc3adybLEVUrHfSW6l6tp+Gbp12MaHhct/hyNX8woN/tfNkoB6kINc40aTyyU/a+YwvJvEUXnb0BPDsaVCnCa31chF94bJWQFpP3bMSMYmbH0Ngrqf2ZCQtSe2GaoC7ySzZuhvIi91vd9xwOotbtq6hd6WSYOBY7IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:26 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:26 +0000
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
Subject: [PATCH 08/16] sched_ext: Move reject DSQ draining into core
Date: Tue, 22 Sep 2026 18:51:47 +0200
Message-ID: <20260922165445.943315-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a1a31-2e04-4e27-9030-08df18ca4c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m9b98TjeNorh7kaDGqn9GBcZ7VFXFA3iR6weMFZBXcTxdg9mVTl7p5n3zPSLSecUpYgkiMNDBAKVLgiJRXc5jOvuqQh6H+HGr5CW/DhOF74mUfiRxxmFx9Agia9B2eTTJrbrGHHG4Bn9JQxMAkTfzf4cNhltNDvORHqIthNXltstumsIgDZeBWll/t4eX2c3gYzgbM0nMfFJjB0J/i9nbj17rhN2lmBNrN41DIXv2oQXe85+ZVfACt+Y2DDWfxuOvVJKpRGYjkzQQw6FwEsQDQwueXmsbnwOJc9d2lwQ6NRdkFRW1i0qTOTByy7mNWK7ZHEO/tvWwress4hX+z+ESVMdJ2Zkncn4zZxfVKpdpsS4DnJs8YKm7Y4vza0RaVlhF2jgtxtem0ptUYSH9VzzbPDVPe4AJw+PjQDqVm/wO4cDSf7BKA29Tm3QWnXGJLlOetyUA4MFcudjPeIF97nSSi2bwq4T0E1NXmPrrAn9u1E7ticBoXIuSzqKsuiT+8aFnzrTJ9BHoD6BcyPVqe6npQQjEgoERJannzF+jE6SJAm3bmk9Rz3QA8xpI9Mf0qEdRyExvi85VkeAzPHolmy/+U1tQXW5PAduVhP9Nn4OPADaShauC9PJaBDiaULlHs+xEiKIvoj2a1bKCjWL8W3Ql2BCNFDK7bCMeSUmv5SGSVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1C8Z6OmIe740xjr4zjUgyvwVVF8YvoGdaJB6SLRE+eLW7U/3xVxEiEfohA+r?=
 =?us-ascii?Q?eQwe1RmQ/ykASz1276fc4plVAJXgMk3ZY/sk5vU7KVXtnUS1reeRATAdJRyQ?=
 =?us-ascii?Q?O//tvgbjtxad5fE2+ZwazYLzwJD+AFYiDsD4cwN+x216VlDRz49JW9MGbcqt?=
 =?us-ascii?Q?cbeZ4u1nQQwPXE+Oj4S222u7lSZlgpS5JiHyG45/WO519v7NgoG2cwJRVzF5?=
 =?us-ascii?Q?EpurCDcuOY6GxK/TpdY7WLJ5kLIVaZsdiBaBo41biR+sf7C2Cc1nBBJzkwyY?=
 =?us-ascii?Q?WEOaCrSTVv3nppY7Rs7CKmQF8PSxUHQIf0ykC8X+B7UfUH0+LgXNQX7ci2S0?=
 =?us-ascii?Q?7SKf7Vsp6eeE4Xk3AS9+zGiLgj3St6QG1VuXGFgR+VbwteQDAPwnH4zSlKOp?=
 =?us-ascii?Q?DS8oRCTDaIuURQ7vP0zaVetZ5cYQE283ax2z9qSiQZvkkgg0CnUwAwY2mKIS?=
 =?us-ascii?Q?fWQMgdt70f6rYp+lvL+6MfsFvfY7BiyFrK/Fl3dhI+xo8NAqah2y0GtjTXoS?=
 =?us-ascii?Q?vqKGvavg7vnu3LeCKlSk/pFbsxYM7WYZIDcge7Y6/nF3bamjXx0Y6sJ5i4+6?=
 =?us-ascii?Q?/p4Rh9+z1fg1DloDp/b6v2zRcJLH9G2ScaD8ehJO16mSpin2kQpjdyAJa6tk?=
 =?us-ascii?Q?aKhMEA39OF4DINMbn2TSU+Iv7dqYc4YtuP5MdV2iTXQ/r+eYXaaUh0rM/4t+?=
 =?us-ascii?Q?M553wZOmbBVQgvIGs8prF6HJafanbupOPFVHcoK4kufmeR6BFTYQG0HpqEYQ?=
 =?us-ascii?Q?lCii9hpyiMF+YLvnNbET4QPB5gBMpuG3vzZntav8n6J0/ImzGBkZIW0RxN+Z?=
 =?us-ascii?Q?Vrwo92ImLPQpxy9ltr24C7Y9SB3ujiiksrzLzNOx+X9IMX635ZWcEmvRHA7t?=
 =?us-ascii?Q?WmL6XtW4GAyMideLPHrepmqzGgYcw3gindWBFEM1ZzEWeNnmOHabDA2iCgeU?=
 =?us-ascii?Q?lAtSuFB8UBEKXIURHK/oi07inquMA8q9rrWghjyAoPULShQCx3AO61TQurAs?=
 =?us-ascii?Q?njlMS9+mLhc4K75F+wORsU7NjoBjJ27/0YuvuckFxOlxuRn7NtQmOB4Plzki?=
 =?us-ascii?Q?NJ6hVCTmiQj1L+seLUmiGWzRrga7dJ6baATVncQDxYrvxFYUCumiGveSWQ1e?=
 =?us-ascii?Q?BDA7TBenbzJjDp5kiKiNsmDSLBW7ANTwjtjp/Kdrer2Jv5udaSM1Zr0monAE?=
 =?us-ascii?Q?8H1J35M+qPxq4CqRZL1G5hSJSTyyw/42F1qs13sb4j8YjLx5sd3Pdvd8mFax?=
 =?us-ascii?Q?kfR5hlPvp8MaFeMgkPnPAy6dev3QoE0FVd7uvtjYvCl6Hpet9y0vJ673H4Tk?=
 =?us-ascii?Q?cyTudyUwFn+pKrz15ZciD3RLusyTvUth99x2aik3334PCqRtr15B+3cOIgJY?=
 =?us-ascii?Q?cjV6DJsIdGBVQztAHo7AIdlRBne+Rqfeym1tNk6tiiWzBSQrzL0kLVbcB284?=
 =?us-ascii?Q?CLVryvLwB9XIxlKmcy5225pMxiMp9bVr9r5IwvN2ZnZyNk6vwLLZ/zCNkbRI?=
 =?us-ascii?Q?gRAhu49+zH2niRSHRFkrCfX0FxYXlnBe5qhRl6U1DIwsGQ5nsiBz9kKnw/yH?=
 =?us-ascii?Q?s0lvDv9OyXdGbJc0tm9Ff1mQiVPESJsdIqcIuptf3CUANObj1IMTrGGXK3VQ?=
 =?us-ascii?Q?bL8OXcI2C4akj8vBX3uMxFIPM/BD3/2pdSjUZKzYxgJW2i/JzmEJPriFvL5/?=
 =?us-ascii?Q?0BfGgBBjzQ/WXpGTrlnmKPd3VLE41RJfAWFRU5nyadKfUdLsR79QvNdk1tUN?=
 =?us-ascii?Q?DLa3y9mrzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a1a31-2e04-4e27-9030-08df18ca4c8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:25.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ9euTAZFfygW4QAXUt6eevIP0L5RXLegZUJ7HoyZU8/IlmaMPmaMiGfjr+FspTdVoad7XTMWTanGdGbkRFA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

The reject DSQ drain will be generalized for placement failures outside
sub-scheduler capability rejection. Move the drain into the core
sched_ext implementation first so the subsequent behavioral changes can
be reviewed separately. No functional change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.c | 45 --------------------------------------
 kernel/sched/ext/sub.h |  2 --
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3b6caaf70fc77..70832475cbf13 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4766,6 +4766,55 @@ static void process_deferred_reenq_users(struct rq *rq)
 	}
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/*
+ * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
+ * from p->scx.reenq_reason_*.
+ *
+ * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
+ * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
+ * Rejection can't happen for root.
+ */
+static void scx_reenq_reject(struct rq *rq)
+{
+	LIST_HEAD(tasks);
+	struct task_struct *p, *n;
+
+	lockdep_assert_rq_held(rq);
+
+	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
+		return;
+
+	/*
+	 * Move to a private list so a task re-rejected by the
+	 * scx_do_enqueue_task() below isn't revisited this round.
+	 */
+	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
+		/* migration_pending tasks should have bypassed to local DSQ */
+		if (WARN_ON_ONCE(p->migration_pending))
+			continue;
+
+		scx_dispatch_dequeue(rq, p);
+
+		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		p->scx.flags |= SCX_TASK_REENQ_CAP;
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
+#else
+static void scx_reenq_reject(struct rq *rq) {}
+#endif
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 1bd1b461ff30c..893d7cdd88b4a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -775,51 +775,6 @@ bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
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
index f7bcdfda8dd85..8f2425bdb9530 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -37,7 +37,6 @@ void scx_discard_stale_ecaps_syncs(void);
 struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
 					     struct task_struct *p, u64 *enq_flags);
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
-void scx_reenq_reject(struct rq *rq);
 void scx_rescue_charge(struct rq *rq, s64 delta_exec);
 void scx_rescue_end(struct rq *rq);
 bool scx_rescue_keep(struct rq *rq, struct task_struct *p);
@@ -93,7 +92,6 @@ static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcp
 static inline void scx_discard_stale_ecaps_syncs(void) {}
 static inline struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
-static inline void scx_reenq_reject(struct rq *rq) {}
 static inline void scx_rescue_charge(struct rq *rq, s64 delta_exec) {}
 static inline void scx_rescue_end(struct rq *rq) {}
 static inline bool scx_rescue_keep(struct rq *rq, struct task_struct *p) { return false; }
-- 
2.55.0

