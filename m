Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC53B14A9
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901901; cv=fail; b=c+q+SeHvxTNuXPJAfjWP/WwkOzkplW/R/oJ3oy4RTVTf8UgPOBWIS0P3U87+ax5sEJ/RIRIDF/WaRabwr047vC/41DXHOu90nv61rYv9qbpoz63xt1rkZB9Hou8CFadFedY6tmgZppnSq+dBEga9Dxu0iT0sTjJyxxetaku+chY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901901; c=relaxed/simple;
	bh=47sMj7irBGMGqEVztdYvq6VIjQ3aQwMpcvBEHDfH/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fn53fJDTbq0o12w0ZFD2ngw3fAyru82lMwS4ggzX68zqL3chRSrjVxepGjR85HwpFyXyWv+Rl9bc/L8jYVuCGMjMKm6oqvyjBoy785qAmRqB6YyUf2AjSVIcVS6N1CTm54qzaGWL4tYoLVEoa0KylMApYE6EEpqFQdNYyFYixLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntjQ5EtM; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntjQ5EtM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPf1318htYap3CJPrXfvXWL9k/TJVPtGrMf2izJLvmXfDEg8HbgwB7bdMDqudFD2dM7LHLphsWsCul3t6FEZYQZLVdu/5lIjWCGDSIlT4t8Z8p8IALmTPfM5OXnrrO7QoyeMuP3MZu0TCyGjcxcejHd4kTC1ArdqXl6DXEy+B2/TDUKmgMhYLJloeyw7mNUpW0fbEYnJY+mvcjhv0yZQqle4Pid7oGD2Vw1OVwWDscGtUOwIxcbGpSDbe2cXQt7jO3zr2rFYrLmKX9n2ajLDkYON1Y1TeixJre9sbC2wyoWji/IXSxjLtdpInwm7DnVKYiEVoLuz10+5SYf6Wt3aIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeMqjXUIphf0kChcbHKZOpif5mE58KPFhl0lKd3PtFs=;
 b=Am2uMViWdzEAnuauQ5Izk44RfboDHmqpMyLd99+jL++o19ENVRDupkXG6xAP0Wgy9kSthKyDXlMdv+1+9Fdmiom6ZMk3nS8Ncur3SmDgqRK23IrFXR2iRJIEIjymDELAT2j+M4cLvv5WaHUmCSbnexY0CLL1CcjD8I/iMMG66chdYcdAndzNfV796nP0xpRlP0LZoahV+rsZv3jNl54TOeAicQChF3wd0HAcWuI7sLlzmfv2NkLWmr11f27FtkfcU3V59oEEjjH1hOmnEAVasXkU9cDB8bwU8KOgW1INDwmpXrGZqwD5VIINSQOtL/s8abRZV+/XQUAvN1hFqNe+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMqjXUIphf0kChcbHKZOpif5mE58KPFhl0lKd3PtFs=;
 b=ntjQ5EtMLgMo4Np7ffTi2dMhISJUD+wjlz0QxZESi+Pe30wR9N6W5mhNoSmR/SF0aFPe64TMoQVUnSgfCFwuGGvpH7KY6dunZF3ITRxNbXxetT+lqrJ4WYv/B9OqQ+RjTaOgbJS4FZyu56aH3uEpIWtkq9qDUyK+zjADqypc3BAKS4J2UaP+6WbwrsFFtuJGlLvY5LgFgl5u3A0oimWGQrec9imXqz+HPlSt6k7q45C6e9An4Gn1fZaVHgE+t9oA7cum2eUxJHaPSFeAC9GkVFSTvK6UFQAy9GySVT6+Kqtnfe9vfeG8M+gTg+cSgUKqQQuRgY1wq41XaJJFh9VSJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:17 +0000
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
Subject: [PATCH 10/17] sched_ext: Move reject DSQ draining into core
Date: Sun, 16 Aug 2026 19:35:08 +0200
Message-ID: <20260816173732.17162-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B76.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cab190-ecff-43f5-93ea-08defbbd2811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+tqkvr1SrquFZ62Sc31POZi4wY3BzsjkdXWVDnCPbHHOZN3Z+zES82myCBSFowdVnhp5xCbEPqnlWH94rUT1K2dKPEINEJmmCjALTwL2qK5YPgW/0cJ0flK15q7PZoayaXsH+uD5kqvZ+ffWRn2imRikcXVfBhVbGTHMMQeLl6dn2hRQx+fve6sCEoDrpL36ijeiT/w/d+WquRzB7Kh++iXthXYA+lGbmzQfM+u34RMrUPUVMbyo2G4ta+0eeGVon0WzbcL7VWxomyTYmH1LnrNaA3WiywWS/Fn3nzr7ImQ+7WN/LCxhlV2suLdtUkEEHCoicKub6QewSuR3JICJC6qWDXfmqUARXqsjrMzOu1T/cQrWC0HWUHZpm87lm9sQJhVFRS/erUvM35w7+JFkEtYrrUk8+M/5+g2BZrKQXkwhpTrDN1j2zUItAfZFwbg1+Zq86DCqobTD83tciv0xSjLwR5C+04hf6nfdAp09S1IgiUorzMxnWwtna5aC5ZEz5qfw2Owt9+EBTvUxlmbkjAigKeEdT4X+FioU85wxBeh+iT8DtqsLy1KQp9Xqg7EOH6cv6ZpA2Y1F3V9lHkdLPpJijDXB1Ro9utA1QQgBJYXtfTf/wFlkBKpbkdWPKIFxnishGf0E8Kratt+q+ClQWMrvdzcMf2f6Rf0xzsCt/vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bEFoafg8LD26llqfYDeT43IerxvUqZ8j24v8MlvAAYirP9egvLaF7tHeU4Pl?=
 =?us-ascii?Q?3fBqarvc9n+sIQcmgpEQcxGOn2yAXX6cYHqFxpGFQn12SQrR2o9UAfGqj8vY?=
 =?us-ascii?Q?EYzEvqSVl5mScIvqKbXDHXo/cGT1HqDbTdIxEYX1LBepuAcg3k1IskGyexrB?=
 =?us-ascii?Q?SjjaO4SPT4uF7+3azL1f89u0v7COF1XU4BaHD/2NyCop9nIWAHtQ58Jy1J52?=
 =?us-ascii?Q?WKTQXUR81PM6l0nRk8AzlNh5hRkgZnAJa7JOGArgwFHogW6N/b+6Wj86JMI9?=
 =?us-ascii?Q?T0TfJNJk8ElvBuafbJrhtMEMvflk2dYnw8kIr9cUYqwKfCFxbK2sI2bzexcy?=
 =?us-ascii?Q?5eF31QybHx0KKgGjRFtQNrPtsq8g9/vrJPmNGf7hIQwnMcR9NEJrQtbXLx3J?=
 =?us-ascii?Q?JQdy/S4I0GDqgCmbs340/KltIw3iSASBSObRCr5erew5RUplxZE3anqjtAne?=
 =?us-ascii?Q?UnYc1Fb0PBw7bOeJcVGl66tqwAkqPfc03Odu2h2Sy/duMp7PMtgXzmdVNYGL?=
 =?us-ascii?Q?n786uznrGPxLq348DdmRM7cWXPsIYK41IPb4aZ3RiEb89ZjmJwCtiHs4oRju?=
 =?us-ascii?Q?/MXml+8Z1Tb1Mpxw8I3p1cFEMoimoV5p6aUZlXd9zH9m9aaBbyAppCGta367?=
 =?us-ascii?Q?xMR0+X+m24NheZGlDxFamA+gZa2nqHX1Tj9yKSz5KohVg4j9Tsrqs0RdqI0i?=
 =?us-ascii?Q?BhNwfDIZvujHaeFi5UgnXI9Gab/7rwjaM6m8GDmV/0Yk3q6kDTyJom88FMYU?=
 =?us-ascii?Q?radFvboQF3I2/bFePuBN6k5rt1CzuzdGUg97aVgYU0fZ2GkNhU+P1etlvvsL?=
 =?us-ascii?Q?F9sRP8dQY2ksj5hdYHkrxF4JwWQWqBKtO3jGFsC4nGaOT8CQp342SMCp9jBF?=
 =?us-ascii?Q?7FT31kXvTFD+KlodbBiiG4bm7dSyBu5rLo0ATWMLXlsMWAJtz/KzK5uxGxch?=
 =?us-ascii?Q?nxDafk7QdOKVa18dnvT5xjuw/lILAI9VjvPD7Uo+YQKMBm+yyle7Zy9K/Ry8?=
 =?us-ascii?Q?5oHkiGRJXPwXa9UCSmz8JyMJdM3UM6O0Ji93N1V+hZxP8t1U0yATE5y7Swi5?=
 =?us-ascii?Q?0UsKO88ACpvIYSWeR1sI9739vzssj9ckn3ElVXRcaA3iNORIqk8xals35l6j?=
 =?us-ascii?Q?sQWb/1WUpRRHcs9fcafW/oxcezoiZjkobpm/dtgrK0igu3onMqLn2rPSMve9?=
 =?us-ascii?Q?vOA/baKmiEryElyqvyDgm4rUlqj6wQe4dJP0vHDgkxHuOHGBvKDjfD6Hq7fJ?=
 =?us-ascii?Q?/ed3737dRi0/q9sJx/5gXsne+/dZPp/AxzMADVEkpDdYVvjVA8gzmqoRKHpA?=
 =?us-ascii?Q?/UC7+8D/ca6PY6KVoZ8CgLKHaYt1+kbY8puo47eYuAWy8579PRjO4/i1728v?=
 =?us-ascii?Q?Z0mT+9NwmadJ77QYclqseO9/JbFSbliLGhhMbNL1I63OtA1RDOU35V8JGkn8?=
 =?us-ascii?Q?QGSq6l9FyNWTzfx3cOjkJ7fndPo3GJxWnAKbo97gUOPJs8CFjZi1Rm6Q9fFQ?=
 =?us-ascii?Q?jA1C8uFABV1qtgQkWVPDb5BNvytLduijcSP4lKFGuO7Mij09hFhepkcARjei?=
 =?us-ascii?Q?2qhlf24GcAPTa05/w2EttUoL9WjwSAUK4hFx5RN60Zyvc6PzQ5J/+2R4iDeW?=
 =?us-ascii?Q?Iqb9rF1YYBVPv/bFfxAW9Ii+jmSMMXgDIZxDhyeMLMMG+hgzcC4F/zUvODPi?=
 =?us-ascii?Q?0rLAHTuMLNXIcx433SRrwGCtLN9FKD6kXa8j8NNJD8/8JcSPlBH4xox9tftG?=
 =?us-ascii?Q?6nQMuWjdJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cab190-ecff-43f5-93ea-08defbbd2811
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:17.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrboQXHnroNPJY7r+DZJAs0InVFF1apfCZkNS/D1vu2gko0JCm1OHz3W5x0cobVtErUw5TwzbwJjkRvoI4gvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

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
index 2739cd180bd74..0cb9ce0f8d4ed 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4668,6 +4668,55 @@ static void process_deferred_reenq_users(struct rq *rq)
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
index 2258cc94e6661..dcb3f8fd1951c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -774,51 +774,6 @@ bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
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

