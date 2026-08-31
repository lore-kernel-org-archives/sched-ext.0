Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4945111A1
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183924; cv=fail; b=RjgQt144cy5YD9Myi2dVGlNgJsenIfdEhdf9mPsZUAbp+4jdSwaxOm8jySMtwzZ057SNE4fy7HwdC37cQdht1PPOrikXNLTl/FrI7kIE8Fdt4SPUF2vS7qOgqkA3nuafuIj4X1iY97jlvpiZkMWreQws0lhiZJxnSdSMSIIi34E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183924; c=relaxed/simple;
	bh=dcCjZMYZhlpTdgnCHP5mPtfMHA9XKo5GTcxJVgaGyFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2nTfFYZ/0I5/JPDWR79vBrA1Fd5tdu5IezxaEEbXtmzt1avvcfMlpTvZwfvMEFILhqcDmhQeR5qFsRa0uKyEVxnIfhYEG7wX5eoADOvqehRbX/nbtwa6YEcdJWpEbw9vxUs3zPcmKSj31NEyx7D+uvWRhfpMyIzzKlYxKCXSZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4r7k1X+; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4r7k1X+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv2e7scxuSrLKAsR04Sckgh4+xSt+QUuVX/n80YTGBsCHSENAWPPSTrjKWJp2GvS2ISPsHIefu6byrSTWy0KCK5bP8pQ+yrheQ1InO/hcn8lgrYvnmAXmXMrVwZAtbqYL9CCLG36mZYCuZYIMz4L5uVvu1AP6ZHlH6AD0oTXjVbwmfaesk0wB3shndZf5XG0qin0K0OSb1jLKWZS/DQ/F9g3ls0aqtmBm22xivDbvUSBK274kCGF2zwAVwI96oXweuSz8HmQWSxpACpj2cByvwJ05N8rNTbgoVFC8wni1xA6MH84b8IUwnODn0ZQ6u5U1TZFVqIUu3pDP4xmz4Fgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvcg0G6cJ29ncACWGSdBhMHvRP2GDgeSk11PwQ+RZvk=;
 b=domVJrCF/PbyqcRxUMmnI62ltE02QfK7Q9RiCDJ2lz716xM1vvj5avcQus5XmmLkBy7zuJAGRepoz/Rnv5dMugqPYJdQQLuQFDa4mG/3LjEgpws/BfyPcPhsM+xKaZIErDINcmRZrut3QTEaBRWZ5fXdw4BAUtg5TylQKVZ32f81DpMg8OzO7tUeHfBgJIBbZthOxvnaxgtWRFk4NHUJAAqBHUbBBaMLyXGgV2RDfMwWtzwMI3hV1O/jrpmYkVHwZA69DMVsuXc9sAJbHXCianDJHlq663XUXK27JdN82hFYRTadYGaeI/b604TyAYgXjrBe1oLF9hnrYU3MjDH0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvcg0G6cJ29ncACWGSdBhMHvRP2GDgeSk11PwQ+RZvk=;
 b=L4r7k1X+Ps5ez3pia+gWOuAdbBjdlz1W6ylyptZVa6VVITLbVksJdA16zxpjFA2QGXcbqsnXLdxIq7EMHlV6F34EaohyrbqoTGdmmqsD2RQuyJ/F5WISiP/0/09NqnIBWIQEN1/mb5uu1Et/dpY2NlXejjOJQQ2CF2HZDB94XWPoL1FaluUl79G0GndSIm1kfSM97teum5k9UxFuNllwFtHFqBza++sodwnI+Ans4vRhxS3vQTP0AiLjGsBAYn5yrHsOds+OuS/yo8KrrOqKDWNQ6hZsnEnB+bqzNfklHlKBScF0On+pXLt4JblQRV2U7Dwzt4XZuJBmLPN4LyIuJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:09 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] sched_ext: Move reject DSQ draining into core
Date: Mon, 31 Aug 2026 15:42:21 +0200
Message-ID: <20260831134338.1531664-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b9daa4-4cba-4c52-e7eb-08df076612b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dm+Fyw8X8JOEKeV9C9PKm2R7lhS4FaAtPiiVclOxoc5BzigtwRc9vO87Q7WOgLxC/6G2gOqTcU/CLln7o1Y4EGPZdurv/Lc97smkMgi+LCFDfgP6qlCUTN0BgVxNXUUk251Zu2yE/k+TY+L7UUAzxqx4I9TdzTht/x/5dTSVNUkeF1tbsu9upS+CHUTLEYhL94+HxFSOR6aWw5GNngd4iF2/PV9+6xHfslALZXt4B13CVzPyLR+f7vIauEmH2wkHlSNz/0Cxyt0YD4CziMlKv2wFDLFWg/FSG/Fe2ZvUOVx9qoJ0cVRrRH/Eom0VQUB6J7MXIfOG1gDPU1efFgJ78Z6zdeXEHGYqJxPHOTQ3dtyZeWbWIefi5piyOoVVf1Ojho0y7/AOuxGWC7kktxxqqxNGiRyAk7a2BYwFqdeVf6ichYUloU+iYpQvJKHw17Xi+ogTXlEtNTMYTEb6MjqlyC0dAS3nBzybjAOQ5mlJ5bSMd01uYStaCCLPZ1Drcyd3PPxqP6pBOBm8Hr3JHMlbRdQUE0E6Yt3JffR9OxK5dn6GPzMGI59AeQ6LYgGCsX9FlFzQxKtIoiQwbc/43SyUPRpGE6aR4iydJ4as8+Cmz3OcFhtoSTHAiupJKSIdSlcYJoIl6IAXvvNOMRi0MYC1ZoJJgcMisrW1LS3/e2gMicg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?93nSB9Mf4PnooiL+2PnJn5vFEfT/0Ogb21OEKgopKPqOSUC2TlpbiZcnNPO2?=
 =?us-ascii?Q?u22gzlePtf2+pNAQsquN4NrS9hRJkqByRm6R9lIetT8ls/RqbmenaB6lIFly?=
 =?us-ascii?Q?VohOliDstSfu/ihhJBmSS3qluX9SNN0qHX5JN2v8jc/w0fN1t4rj7fywqdi1?=
 =?us-ascii?Q?6x2TtPThsUzrUKD5aNgTSNKhhA3hqp9ldLSQBFjoc96IDX+Uep8MkpTZll+m?=
 =?us-ascii?Q?TcjarYE9wDrfLK1bEv6+cw0UOHmS4N9deZslam1QpcFqR8ixOLTi4jez1gLk?=
 =?us-ascii?Q?tGgNJc3TK/Km1HMJNTb6hj0B0UvJs5IK4dvzoN83qukFsxMViFxkieFWa4RN?=
 =?us-ascii?Q?E3VVZKuQrnK1DSPZjvCb2+CZ650G7i8sr8naU/ZkxqHVJM7vDbArPB9eQJ6q?=
 =?us-ascii?Q?mb8TMPou8aBNRgX4NZ7XCDpoOdtIZW9FQOhJHfWgt7sCYBV+6L3uOVyzIYu4?=
 =?us-ascii?Q?suSGwmY6/O3ihpIXRchFNmQ3bziMybwiLjMcqap93GFshRIgsHlVNdrVjqhR?=
 =?us-ascii?Q?7gboq/jk/67JswpbR5zjF6AZyQDMk7OG6ejpR1+pHwCq5/3pJ9nUxYkfd/zi?=
 =?us-ascii?Q?iME9bVunmLXKPhxznj2otmjKL7g5aPvYoNfnpKy3aY7zyA6bIaipJeTNCt+M?=
 =?us-ascii?Q?8QvI4lKrx2lPE+v0QFhyHRzqh/0vKrUQh6m3Y2dDbpRwiwz/dqoKS7Q+gi01?=
 =?us-ascii?Q?wdcD3vNvnXZlRA5Z5rP8N3joSOuAsOERdpjqUixhFQLgiIT62sm6+MFdpyyv?=
 =?us-ascii?Q?x2HMAArhQF/i9sThoWJQKke868vcctlyQAxLcDzS49jcUFETKzu7Mc1wSDC1?=
 =?us-ascii?Q?9l6IFuR8ZvFuj1Si49ePqewPXNfYnzZMuA+gr1aomH+BUU+M25f7m6RhVLYl?=
 =?us-ascii?Q?nVkBXZgPwKEYLYTuns8ONGInHr6ADGDes/ZUERJKDS+cEqBjfeYiFN+QR27j?=
 =?us-ascii?Q?bR+3J4T5exMF9nuBmVIUT7L61mV+boRhIBIMVJQkkHrfeJs/rsp9l2i5uMGl?=
 =?us-ascii?Q?thOz3zMqDieQN59Ld3gHHahvfpUf8zDco2pY9EOFzU+lTmtad1fprmyp6t+j?=
 =?us-ascii?Q?UwpjYmn050K5sK4Q/uNw7syhlbjJqflmiHnv25qswM1Ff0Tm7KnP/tXvdm2y?=
 =?us-ascii?Q?b4jhsC6wRJPSNx+LR2umuv+fRQmB0xHo/zX1WRv63AO8yE/DWRIKxbyfjzja?=
 =?us-ascii?Q?a34FOS/3igzcI2wyexuHCEeRzCGMRtEflr6wRxKBKWbtkrnVEQ5411+TioKT?=
 =?us-ascii?Q?6gm0Wili/lxfDaWq9K5/904PKqdq2G1g3cHlkEXrjkN9YCVhYa9qeJTIhMsU?=
 =?us-ascii?Q?j/JcNIML7Sptwb2U55P6nlpGuA+ckJtospXazyuGePhhb35fVRZh56bvsQfw?=
 =?us-ascii?Q?e2h+I30kOs3zbuSSD3+q1l0Uo2G5x+R+OVcXkdyCNj4fz4vDX0V0U1qIkWXM?=
 =?us-ascii?Q?nJoK5f4D0f/HrMfeGvTFTZGKFr1GY9cNcJggqxp1Wpdq0Es4CaN71t/MG2Q2?=
 =?us-ascii?Q?dbdBxDrTrJ41ou4TPrsSUTkpKjq3cvohXC7iblHyApft5IAPqNL+0gvBW3tv?=
 =?us-ascii?Q?ckOwTLPXL9uTfAD4E3vYn+0F+iwOrlPbgATUHYqOuNNV6S9RJNoej13+0ZBg?=
 =?us-ascii?Q?yTObWYZKf9/0y9Q0oU6qh275B6UiR3V/cR/ElOESTBcIuMH707oBjeN3k4+z?=
 =?us-ascii?Q?Q8bKHQYn6tELpn4x3/kQGDU3m3zxob7VA9LJXPNkzxSShemkpX7SDbvfsqKV?=
 =?us-ascii?Q?ucj7H24uXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b9daa4-4cba-4c52-e7eb-08df076612b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:09.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooTgocRCWAmaz7QdNHFTMGUUkA+LfISBq74Xz7qfwmTQXX7LDVdua+WAnS3fe6QGX4B2cffUdWGwzPZzwrNgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

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
index 307d2080b967a..967bf31a32754 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4674,6 +4674,55 @@ static void process_deferred_reenq_users(struct rq *rq)
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
index c3955c8163a03..a73593e828267 100644
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

