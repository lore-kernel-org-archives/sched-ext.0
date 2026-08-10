Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FD42467D
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375007; cv=fail; b=J53xCpU8a3BxbCcEWY+qKzWbCsfiHGC7XuQ8kj8jo9XigBJyMlUllrlvhhdyo46Pexp6FQE+MxFKE7eLvKrR4cOrW3vFX9XTwxzhYtHJejJwGFTT0tvAIqmrHEehXu1ntdX3Csz753gm+o+X1BjNdZGTTl6US5ZEQV9Fd4c/MbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375007; c=relaxed/simple;
	bh=sC1vVW/wA9VS+F3pDXmAstmo4hC/EheKqMQsqw07jF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPbET/AmOg38M4MWOSbVH9TGU2ktn0ccAY7ojlzy4zaFTnLb/2PDJBgQKIH758D52kpekBa3bKZxWrHGV4R3NWmEvC9pW3Qzc5dNnJqA6WRawkJ1ZA0nojmrbPr5tE6uA1Agj81yCb+ReoG26UpxQokTBec+CB1+wslHIrXFpqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iORXAEek; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iORXAEek"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF/Dx3oGZoBIW2x7kQq47wi7nxkF12QSX5SH5criHpkvJZqDv43RspJNlJWrrSpr9Ji+OE94HqN6J81OQ8cTie0SnrEez7aUd6Q4szYvtbrAAdss1IqU8TbjdsFm/I2xcVk1M7iDyHpRWDij9mXuTGJGwlkbF0DOeWdInh8sbgOzwvEenNW8+G9TQE3h3SDggRUbXQvECmqcPFYFtUWP5cMAuIo/AmPlLzlcAup66CjDdffhnFOcAzdll2GnYMpHRWu9KamPWjs59EyVXNnlwsX08yiji/YiiQ51X+D8SxnCztgrDl7rrBQ5yJvLhpBpbC5tLZOVQPrMvytpK86GQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPOKVMC0q//4KZRVnVqQREQuG4QWn6kWSR9+P7IN1UI=;
 b=ZuimYc7HrkoNEmeN5SUHPq/6In+Ym80/PL8dVBq7uG9JJ0vR6k0us+IswVS8U2KlbhUgEMspsdxMa8R5iYMSROgknZpNuY15wpC5zmcQV/JB7/yCly9OIOtG73tPtEAD+m8UXvn9ro9/Z8Sg2WjPHGh4Ioj76d34KgOhZQuDyJpbA7T9SDxrrfBtyarP3BHWgAb8RBu710ILiscUv2Gptgxw+74J9ZMebttvaosxxIyM9VvrLqR7qZ5GEMeGQAFgGzkksv/q6oFscZtFhbrbRTzZ8U2gmPptiGh3sImtaPYxF3OLBcFWum0HbfJGTioWYvqVO4DAzGDd1EnlUOTvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPOKVMC0q//4KZRVnVqQREQuG4QWn6kWSR9+P7IN1UI=;
 b=iORXAEekKQmPWcSN0lFTCOeoN5iQ1sZeFy9YEbBUUtG0rbguKN+O0u7T/rNKE6xp22QiwhHcRfIQ0gQZkZqhc1mL+HZyjGphvlPQW0v6BEexxRjB2ohBB3okOZX9wIsSynFQzT3mQiXfPPrf35GyYvldBLKIwmIyebEjjYu5BwrGgjTa216V6lDdywOtl8siNkTUNRxB/ew0IVk8jyUKjENgKScnBk6ppDKCdJIZO6TF7GkmGvN+sOtZkTRKeNFdOBQoLOqtJvAcBR6LD+ehU/YySvzLOHLbrGu9pcUZ4vrYN0SssxN8nFxULAs0mX+9mfG4c9EsiZ5VL4YngIokBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:39 +0000
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
Subject: [PATCH 08/15] sched_ext: Move reject DSQ draining into core
Date: Mon, 10 Aug 2026 17:13:54 +0200
Message-ID: <20260810151523.86994-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007544.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cf) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f45f15-db2d-488e-9046-08def6f26064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9tCQFgAxPvnzBCxUI2mIa0JHFJyJYMKSHUB9Xq/AwBKeppEaFhxT5gYuqcLDHL4nrAEwAhS+ErV/iq0AlGMg3DzAyiN/jlDZAIjdE1bkMq4vYJvGodD3SYvwC/xlDlRH8GDKtrJAnMkEBAdr8FCV13DZE9Ki+KeF4fKCIf9yyv1WUGFwhsMSNI0rvA9W/99mFfMxNaPIUZz6lLkrCVYEYWveG7PqA2Yq2jMJKO+RIeI98p2EeaPiEv2P9jkjBrTYhbqy+D6/VljhtrJauh3v0ef5iRxEYJmInugn8mTBIM8XJ6fbNEwx8r39eXVLmswsIowjv0JifAWVThxXE2jHy+wRGy4EhRGkvxxxq1WBrPt3s6hMoWkaUSO6W9Y62F1F58zTG9NXlktu7Jj0wKwm6u7ZxLWZNUOHj9zPWl5jgW0/LEtqC4o1v92x8FhjKfXug9M8t6INHpLdPDmtR3uxoc78i7NIf2Jpo3RO+DIXVM539m27ZRE5VAVAIoiwkmAuwceWTO2lU0UOcagsc4UFAhLnRjhXMeS5zA+wAVATxShN++QIAC2CX3pA4lHH5d9wwQrVbitCI9yeb8nsGa+/zWjSSOfg3031Vtn3UyNmfrJ8QoRlBtGhpOU90u7WtfFL+jgeo03BHJDENQ5CALi6iJPB8EjrdCHQAEYjZfzryVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?thIJAmXC/x3E5nSLslTtAGoTXqRZ5tgjSJ66cPfruuEEK6boV7xp90Ci+ZQu?=
 =?us-ascii?Q?fyyK0ehfm0XI0F4MHkLhTuuj1lqQKTAS2TV4poY0f547Sz5gqwJn4i2fMpcJ?=
 =?us-ascii?Q?if52x9LTdPQR+/hPp3sl78wBQXhlpwQTIgsk/2nqWHlSfPvvri0BxSl9u3zR?=
 =?us-ascii?Q?UmaGIdfocu7vi9ZrR3/+Fer+DeruSJcoKohzqO3aC3cV0XN5Ss+WieO2n/21?=
 =?us-ascii?Q?ZIAdJMx9ouRcPu0f4ph7Qxy8fwT0so7bmooqoSDitUmKAAjcISmjZ6SFxOku?=
 =?us-ascii?Q?zQ983nE1z/M7p+nVXHhdWQVCYVK/+eCgMHHbVjIQGP7rCa+2nFfWQ3zhyp4d?=
 =?us-ascii?Q?r0kVnbRGFJFsx1t2V6w57aRd6uRhX17ot3TOjGERaJ0MvRDy7+RnGYsquLcT?=
 =?us-ascii?Q?tdIPKK6oLfVB96HrS9kCMBzllmDb0hMgAmDzel9oTpYnAB7XVbYVaHpbiZ8H?=
 =?us-ascii?Q?CB9Wi6HKshaVPY+T6My0aW0UXf4eJYD1DWoy+s+xODOnE3Uc9lLjerWqk0rv?=
 =?us-ascii?Q?boL4uzpuCTfcDN0joD0cDlXeVl2deN6v/IN+BK3J6fjuCTY/LzmsB8AgDiRk?=
 =?us-ascii?Q?dNclirac/3xsTHmXaNWyU/KFpEr9QY5QKV8KvwhFbgf/lhZPKNhl3LTpwbk6?=
 =?us-ascii?Q?hhIj/O6WGbcU0oQXX9fRrk3fEpYNEc1ZXAcP0rZr7yDbYdwtX7sbE40/7e97?=
 =?us-ascii?Q?uMkBbTqQTTQCqlnth8+UMrI9K18STj0TMX5SondhzbsrAmlNXAuBO3Kzkq8+?=
 =?us-ascii?Q?ivJR10c+k99BFzHSFLwRfd6J5R/iH7ouH2Ef7rHEeDAe0LH5YS1rzGyTmSYf?=
 =?us-ascii?Q?3XZUJyTIllbK3KB4OxKYc/a205OQO/MlU3MMZquAoCCCXUsuzy3ZLXOUq7VK?=
 =?us-ascii?Q?Z1+p8fIwwMQuSrhfuIbZokWCXaKf19whKDZzsYeUcDQjHdijm5PsroYxe0It?=
 =?us-ascii?Q?B5Hc0MTdkZrPfyn8CyaKkvqdotm87GBik8j39HtCmA6KQxnsSCkyUSZPhmEz?=
 =?us-ascii?Q?tnwtKJW5zp1bjiTX4LZeKDrDsyRLG2bKNlyTJySO4nGG5MEaF8q3I+7YHRlJ?=
 =?us-ascii?Q?hsJFhKbvDRZHdRt6GcfioSH40E/8XtJYsR7nCLDZ9tuG7+qTuefkfQwpAeoL?=
 =?us-ascii?Q?ASuFTTIBocvrbR92tY/WZP9WLA6+PAeOHJu1cM1Tq9c/Xq86zijmvcCvAcD0?=
 =?us-ascii?Q?M/U/EqFci0HN7+/TpZIEaieSsrHvFTA4N15uR2JgAoP410jLS0nqvQlJkXC3?=
 =?us-ascii?Q?MQenN4O+l6zBHyMt+8iMqC1SHiYoHJOzPhsMy//IPOsODf/xXX0WVCfZUOXP?=
 =?us-ascii?Q?7+i5uRcq6tE6sRAZdtroFC1fhNva6oxogYhcjsv3JamAoZe/Laql3vrmqhrx?=
 =?us-ascii?Q?YYedor88HlHScXZKRbIEtuaavdwsKGUe41zSQJbg7JQA88MCP7pY3SlJK1uY?=
 =?us-ascii?Q?yQFdhMC9zHoDDXdJWiGSXrWObohOONR8KpRlg/Nnv8rPwMgLsrHdewQvu7kF?=
 =?us-ascii?Q?+3CMnisL7O0Y2L1NmWGGH3shOQIp/Xtxvu+iGZUNSdlVSkbsU26gVXbF/BQY?=
 =?us-ascii?Q?tlDny5i9P6k6QZAx4VRTNuUIzPocCexvhSgTjEvzjYr06799eWXeS71aTHix?=
 =?us-ascii?Q?AEc5V5kzJFR2jkIqT1sydwZTX2VMC9ZHlHxGCoDaZAnHWcNOZtsK6i16LnoS?=
 =?us-ascii?Q?Cd2TOcHQFfhLd1NhIVMXmtVxhxGjCmLxWIhjHc/utAaeITVtMghlYPDF3eEN?=
 =?us-ascii?Q?e8cKXmyvHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f45f15-db2d-488e-9046-08def6f26064
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:39.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMT2Ja9gHdpt8czaK5XNR7xo9nT9NmI3TNoO9SksLpkMdM4FFQNTFmPV54XAXlwbg8q8jQWO7HccSJYQ/CIjVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

The reject DSQ drain will be generalized for placement failures outside
sub-scheduler capability rejection. Move the drain into the core
sched_ext implementation first so the subsequent behavioral changes can
be reviewed separately.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.c | 45 --------------------------------------
 kernel/sched/ext/sub.h |  2 --
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0958622d4382d..1ad65b8051008 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4582,6 +4582,55 @@ static void process_deferred_reenq_users(struct rq *rq)
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
index 9e1f1afd389f1..2391bb0c0ecb0 100644
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

