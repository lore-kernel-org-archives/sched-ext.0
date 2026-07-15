Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26EA3C8C5E
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149040; cv=fail; b=O6TTuCQ/w5PJTqiStgqQ8SYqrdkIQ5OVUzb0L2up4uLVCOj0D/mXc+VLBPYv6YmiZJvGq/gWBhbaJrnaOkIJS9zvI982OvMnkzjs72RzSA0vVqloQzEf4d3TPzJUumgfg/CtLUIAQu+v6muQ3MzPGvg+0N2dIsCZjU6NM0qvTAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149040; c=relaxed/simple;
	bh=j299/0opmz1vRVbTi4je4Brj4eYEhhIYeumsAU6yRaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hyd/a9ZdxXoB339QaZLZYcIOKVQWRx6x7MFiwOtkd6v54sSvgEF7rFc5L+LfLxT/b6UlOkd6r22WUAIa3GwIvCGxthkFBndgSFKRABBazoLxsRBzv/2ocIESX8W9T8rFXfzieRQNmb0EUKu98IekzPzoANvqLQ2YM3P2WqrlD9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZOA3r//; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZOA3r//"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAHiRERZFY62c7b5smKrN3bV9J0Q1xwbYw9TDQ2Fs/alTq2AQOQ/Je9KMZ2dfNrMF314z2bgr7qWO7c9RV/lfhcV5Ggwi9Lt44g5KnMcIwYnLZq6LPVkhuA/umTHQj1V7TdWI9E46VuRKE/RdI7gFXsRgxyjNyRdpdd7pR0/skk0uSayCrvmyvtQCw0bti3WxI6zG4HegldbOkSUCJfh0rm0SRxgcn7rBToQW5PZ4ly3f8BJhZeR6K8dOTVfyfiF6ftasOOEPkh0+/ITtoOn28n2rNSd2rYtB4A3JPKuqtU3Cp0viKq2vwtosIjQbvHBC7jfxVBIEWZGETqyfQ1Ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xnT4Np3gQ7rDgXeM9tkkUStZXIzd0EBUB+MBzU1Lhc=;
 b=rnQ04wnAx00qrN0DPfjN+e59ymJFt9gnubxco+TeinUap3yF7zPeNn6UZmiSr31hmSXvGqDE+aaPOuVp1W4zWxW/KyCIf2muYwQJGhdR41sODdV0THHPhSo1EduQyNF0DR6Q4Xj+F9CRSnL64c0FHVpbUH5HdHFQ+T0xu/pwOVKbyL39yhFOZ/qq7iSQQDSTtnWhHmT1v51jZScSK+RyxydOVbjyhWwqGW1ksDmZA9HdNl3G8bU/M5elCmL/Itl4MsdUSRQzGNhP/GQMI1F4g6SRngbYBe4tVy0hcEcaW7/80coujAK8yj+Gme7X9+Wm59SR+6/og4uuBP5VDp0u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xnT4Np3gQ7rDgXeM9tkkUStZXIzd0EBUB+MBzU1Lhc=;
 b=qZOA3r//+B3ZWgMIcCXhf6xeE95KSf2NYspiyiOWy4KKa7p4hnSE9FnaXwb7o5FLIhNHBsB+pyEuiSe8gTdFXx+XQB0OCUpJrtCMYv/AyLLvZiRPs5kkYv6uwhfyD2GqnoSYI/Q30EsIorPopAGaBwZz+7Y0kwWSmkEDOqq4nqs9syib9U9GUHxMvpT5qXBm2229GFsQev8jFzFDr+GJbEHDy4Ra0uiE19X5lKzdaotI/SF2Hrb7n7m9ocjn2PXtnoxJLyGQTmBB/niVm53AgxTKB3r+4mDkjNXQxLGp9k3O3Rj3dTol34tkFh9VJuFr1ZCbEUxa774M+o5o8lAI7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:10 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:10 +0000
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
Subject: [PATCH 07/11] sched_ext: Handle blocked donor migration with proxy execution
Date: Wed, 15 Jul 2026 22:54:15 +0200
Message-ID: <20260715205622.276220-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 091d12b9-dc00-4133-11dc-08dee2b3a39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	COHikhCQofnf99lpE4iSXGlGYj1clrARxBJDKDgs8Tmbc71pqjp9rFkuoMcunMkq2ozi7cADjFoEfLJAWxjvTQBZI9aVjEkFJEOf8Ee88HMkQRWCllZZffINPGSTqY3pVb8WgTFMtWVyxWm+n1XVq9zSoEMmFU+UmtlFxQ6J06XVE7nPtIvCSUvwHCrzHbq5yxIyituhaj1TnG9Gbydm95i/x3Xlue3dUwn/jaXzy0uLASptiSM+Gs6nVGbYc2iZIU06Id2ulrce9Wtiy3PbGBmJOajnvmsBrayeFA4h9QniOGkshratnS9Zj13vGlITWkgEUEU/nOYBriIt0/LEaL5g/tTPipBzMEKgZ4Qax55QyqF5A7RWYpqxGhsmEB7KFWzM4Ssr5lRnMsLaktbcrjpwM8hZNOjn4mj0/FVKiVfbRccpGqOscNlr1wD3f97QAjlUAj1mHLWOwHqxtKq7p+d8y50NnAoJEP7fK00gW4X4DfCL1cxT5ieQCSRyKXayv702+SG/DfDbN1XU2iFz96CLjdpIZEze7d+8ZTQmfisKdHjtiSfLXrHvfKzJoyc1DwWpWIcOuKsmME7eLkSJvuNrhQZY3B8XtWb0u7NSKowLZJklv5GMwO80Hn9paRhnW7qFq8ZPq5/9q5OFrHVF3Z6b5x/i/xAj2U3nf0yjVjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKaF7wT9mP6ocjH3a/FKTp6p6KKmayOhyjWCFUdS88Fg7Qps+hUvVDhlJxH7?=
 =?us-ascii?Q?DkksqYQOiFh1ccaQcDBKIy1VLlxyDbgVQYacaeR6+/ZyTSfm8Z9DKI3RWyao?=
 =?us-ascii?Q?WO6qXFeFKc2swtnt2YobFK9bxxKvMEyROstyGmQyeZgBXce7SDJxXMpH/OqO?=
 =?us-ascii?Q?0/R7YZkv/FVcsjmTTFc4KOqOJkDlIiRmBDkBz5SV8rb91a5t3SK1v+WFBGSQ?=
 =?us-ascii?Q?bH4ooZ2SmxVvLQy3+3wooBuw/iFDQ3iOEiMRt7goXmzIVEr5Ck7WJI5FUsiG?=
 =?us-ascii?Q?3hM9ZJmhD7Jhy0/2/PSHdNHLTZZjTjMh4zbsHWJhpNA+6+uLJSCRBOsABk2r?=
 =?us-ascii?Q?yf8K4791/h9OuLfX+1iLCAT/3hHqM5LNnyYJ0H2V6dMg1On86EKkbinggrJF?=
 =?us-ascii?Q?hJPoxgyz+LzOud+ATBerPR7nV+YJ8gagHwNNXlcRTDTSYxeoEu6nECVtqXeT?=
 =?us-ascii?Q?ASAfLE0G+92o8Q6esMcCfE82yLkWX5Z1iFVcJxJXbMZEIFgENwMGJdmzIHOz?=
 =?us-ascii?Q?MHDDNk2zkMcv0gnQWmWK1F3IX1MH/erh1esQvutBQeZPgDmlz8RUMcB28z7W?=
 =?us-ascii?Q?8gxB41/HIeBm1ACVujJ4T8ZS7Nf/ExQcPrfzbQxRBOHFHxloIjFnJXNliP2/?=
 =?us-ascii?Q?Uf99nYDxQFJXCwv6e9/XG6Xxw3+aSJxDyDwmIcKd3U90iVQ44HqeeTaXqkXt?=
 =?us-ascii?Q?wjqEBAUfrnVbgDG4aHVB1aX3q9Re7br2T6PgcW1jXWq8tcwCbvFWiZFTSBn2?=
 =?us-ascii?Q?daR7aSOkB4I4fdQXM6ubUcnF1Wi2nxF8M4uGpQ9JTyTHCQBmh4p4wdjJyrOr?=
 =?us-ascii?Q?KBcBZXc4jE8fhHRE84psjiJ1qwENfXF12N3p4hhys6Sq95HlxVAg/SjTw693?=
 =?us-ascii?Q?7Nt1m4tkTwL3F37eimGQjTpkRkIRwsFjnlY3jGbTn0nU12N9FvWu2+9rDjNm?=
 =?us-ascii?Q?iorW2yIuArQ6Jaq9u2TD7Mx41iU29AWFObKddu3/VeTnLA1n62L5PTZVSQDM?=
 =?us-ascii?Q?ATAnRR6rc92ALEjR8Z6jAkWf8IAbsCZq+moHMr0ftoGCs7PUpB9XyEg/EJRR?=
 =?us-ascii?Q?9vXaVSr/fvaSvEL4poFZhZdowxfWFPE0P6HrFJm28r7xSWEYxNd3+3xcnMo9?=
 =?us-ascii?Q?kl3QmzlECugi8tmythL3IzJ6TNpEdHz7AEw4V2gJdVRSxxJa5i4q/R+25rJT?=
 =?us-ascii?Q?bXJSbfanZJHTNRIuAzG0kBmKY57AOH2VKb6rrJymIDS+SM/KzMPLiBpraFlX?=
 =?us-ascii?Q?bzUtd9J1nbHvL60PaGKCSAQVIDh2nlBW7Pf832joWa4CWYtu6lXwW4jwqlDa?=
 =?us-ascii?Q?ZHCs7VfAzHF49g3xfwS8AaqhGSMhk/Sp05bmPPDzhAxOjd84zL2gwa7y3auW?=
 =?us-ascii?Q?FFdifrx5/+pqYzCojDQp64yyjk3itjxubaWdyxe5Qnn9O7fYkXT22GqxVgj5?=
 =?us-ascii?Q?LE8jQPtzOwEO9xlJ2KG/NHn0sn2bXiG57MEtmwx5PhoHhXIR68vP6/ydUlWC?=
 =?us-ascii?Q?vfoC12BCMhQhYnyPPoQIN8s9rnasZAN99+Q4QTANH8upSuD0QTR+h7ZgreHS?=
 =?us-ascii?Q?zg/l7KzqaDOmu0wPer3Gp15vl+85/rc1ugH2Y0XkpckZ4Hvz676m0xvJwPxa?=
 =?us-ascii?Q?vKjqzBewG5lS7kwnEt2Y+JkYcQjXjgteerJQtmsoiqeOonElhzI74ys4lVh/?=
 =?us-ascii?Q?Lb+t/aVrJztd24hHahAeeeL+7/IfAnKPNu3H/hmxgDuKGB8eIdn0VdGpvaCE?=
 =?us-ascii?Q?BclYV2FEpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d12b9-dc00-4133-11dc-08dee2b3a39b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:10.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gr8BidnSkD/0Z8WFuOy+PLu4Z7/X+YLwagxHj6G9X25Wh2Ctolu5TABXtScayD1Zu30HQBYm7gUxIDpVQjGwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

sched_ext may normally relocate a queued blocked donor. set_task_cpu()
updates both task_cpu() and wake_cpu, making the destination rq the
donor's new callback home. This remains valid if the donor was
previously proxy-migrated: the BPF scheduler is intentionally selecting
a new return destination, which the next proxy migration will preserve.
The usual migration-disabled, affinity, and rq-online checks apply.

An active donor cannot be moved normally because the source rq still
references it through rq->donor for scheduling-class operations and
runtime accounting. Moving it would associate the task with a different
rq while leaving those source-rq references in place. The core proxy
migration path avoids this by switching the rq donor to idle before
moving the scheduling context.

Allow normal sched_ext migration of blocked donors unless the donor is
active on its rq. In that case, defer migration until it is switched out
or leave it to the proxy machinery.

Keep blocked donors on the local DSQ when they are put so they remain
visible to the proxy pick path.

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6f6884833f8dd..94a6d7ffd924e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2395,6 +2395,19 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	if (task_on_cpu(task_rq(p), p))
 		return false;
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home, even if the donor was previously proxy-migrated.
+	 *
+	 * Don't move an active donor while the source rq still references it for
+	 * scheduling and accounting. The migration can be retried after the donor
+	 * is switched out.
+	 */
+	if (p->is_blocked &&
+	    rcu_access_pointer(task_rq(p)->donor) == p)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3081,6 +3094,22 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly so pick_next_task()
+		 * can still see it. find_proxy_task() will either run the chain
+		 * owner or deactivate the donor so the wakeup path can return it
+		 * and let BPF make a new dispatch decision once it is unblocked.
+		 */
+		if (p->is_blocked) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

