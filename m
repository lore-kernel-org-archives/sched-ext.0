Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B337B02E
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995561; cv=fail; b=WSd7XSJCdo3ovLldr0pSmrhUSY4i7BHAceIRVeVZ1u5FZwYrRjmm503yaZ6Ko2RCqOHtUnTQ/lNpGzIqsR4n6P9ZOAYOcOnCsX/h09pyly37qWPpfETxWGThi72ka7vRIZE0GC20v56gSws610MXdBATgUjQX6HSkRbqI9/ZyWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995561; c=relaxed/simple;
	bh=W7/MspLDli1DNJ3w4QONPLjE898rVLtU2oDldsGLfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMzyQKAcD8mVKr+ucrqgU9ZzXfOw6d5R922YihLC45lyaOCyjV1zLd9wmimMHF8mJhdcXsDxMceBOPZskcwf49+mhSQxEviRBPxm7yK83aXliQbZLhsn3r+Vtjqi7FWmuf31LcTdtZG0jLmQCwuTWTX4aeWLPFOj4OEitFK8rgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iOF1s919; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iOF1s919"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B67NmZFlzAsJBV/qnB2HMRFlUSeEQbikTD+Z547lL3Njtx1zSwfK0NexY6qkbYJKEtLWF031nLqBsU8ydWUW7mcWND96FCYRkCeWgkLnxeTZJgCoHKDopxvgYJ10iGzJ2iTUXxVKjWb2Sd8aNhWY0vCgzzFOkGofji9/ezhX7noYr0cDuevyOIsmSqTrs6DVcZOiEmt2GoPTD72EzW0FzP89tMIjp1pSuAXpaGwspMXVCZrMFRuh95xKQkalvkbAjeIxa7/fUbzObeaMRjMBLQl72NNKwJfmXfzM1shqnx6e+m2LOrDWbE0D8mqgPIkPkLcQpoLJrmnBtQFpe2yZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIT9+JaVHBHEJLxSliYiU/NlxkatTKFYmu5KSFchh7Y=;
 b=xrZH7DXj1v2rILFPhpDNVhg5QXxTCZ+FnTyw6fLslUQ9UHXnQN7w1ll0bBCjNQwjJ9vtPd5ajgy+cPmwDPx49TUiRfQuqHsf+hWqcntOgV/cCwyUzM+Sb7z2dUJOnsnhs3bgxB6tYwpKbQ6InITVz0KRr1gZn3xNHXK6W0bLGcyhxVo4f8uor/r/EimDgXFbqRtYaOia0qvsV0ku8ApPdDsIENsQtHKsyyv8pLR6n0ggiRMdwSSHamoVCKhZonKxv6CETPZFmkDTEQX+i+/yaDPZBpneUfrba0E+p7kanxXbkBltPRbmr5zuiCM6AZRh7SaSutnDUuEDhjQaAdQSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIT9+JaVHBHEJLxSliYiU/NlxkatTKFYmu5KSFchh7Y=;
 b=iOF1s919FZNPubp2P6F9S56KprwTlNDu0x5ZodsQzuJJoMvSOObizbJUor7PeevQfH35tR7miQq42kQodTPOTHKa6jmFhsFpoFEFMS52ydIdnv5dPVSdmKvMNVjs621rHyDxQamll62JT5jp6PvWcX9lATNSdPtC01v0EVsU0eJFwXS4tMOVj0BipGOT3qgNlXuUPEHr4S+PERqnZDTdgxgU0wzffqFZKz/v9vlodrhMRgeee9+sbCNLP0jvW9gfxUK+0pfJANZVfmUmtKjnJRJ/fu9JUWgN31eHGmpFOOoetuA5zwyEYtGSGYKQQ2W2iCPzaK2axAthYoCmn1uv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:54 +0000
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
Subject: [PATCH 04/14] sched: Add prepare_switch() class callback
Date: Sat, 25 Jul 2026 18:04:10 +0200
Message-ID: <20260725160513.57477-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: d119e2ec-cf67-4cfe-aefa-08deea669ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DnWED5UP0qwXZ/lXQV43rdUg7cn+anC7pFPEAZL1fDYw+J0snZAi+6syTANem7pAvtO2SELgnWSaWJIF4djh9kryP45R7WCCiWx30lfzRv/wcLpHKZ3dOXlMD56/d9Nsfjqo2gnN1W1vd+oT+zBzkZcI+LxgJUKOvlsaMc9j3gA/HM7tqKSmqrxjY8aHJim58MyALIgJwhD73tgtexEOMvQT9zLGkfMCX7eB2j0pZT1X+A4dQqEsPMo3JBerpl35ghA5bvGacb6F3xuzVcJx3lNE3vOqcmQs4m5QIaFGKdD4neQiXZLbKO35Gof+Rua9sr1kddoWS7sWIBQPqxjBZldE2mAK6/6Ks1RHTh4ZgQ7qyqdLa1V9kf2WYqEOrPJX30zxK0GPjgayH53egV+Q/wIg7IPkGty9Yp1O01SAUV7KBlG+THKxIK48XpwlbLH4Ck+7MRBh03QfRpWmJdT9zBiH2AoId7+GoeqbPX+PG10+ufxPRWQvk+yhDOX4fHDzmK0RRH+vOaRbPzTXfiWatOV+SXVTE4gJdEKKad6cOIRVEuK6PFsi2w8w3EBKFgUEAeSgvr7tPlVQO7Fchb39mPKKlxC0riHPoO5am6tVWvZ/bmRAmv2c995gcl25j92LwIw34Icy1CLJP2gzbFrQagtyG2qs6C50KLBmFKoPnWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HEl4Qo28rdNm4xx4MYm//LIcfnLeUtqq3pBSjKUaBr/EmsTFI82Hp6QXlP1?=
 =?us-ascii?Q?JTV0AEHCq6uwN8kLapB49j//iZ2/h8CU4YxPxgFMQCwAsY+pAbWF2FL2wLH+?=
 =?us-ascii?Q?aDVXYoRyJ55Uk83JaxQv6V5bn712yTA3I+mIblwFMmwZQhTfy1jOZjpKHBqV?=
 =?us-ascii?Q?t7bNLnd+JvtdNK74X8uVoZURU6zZoPzT2pVZvmXYGSL220BgwOTbcN4+gEvo?=
 =?us-ascii?Q?bzXLMaLCd8UiA6Ps/Mu0WzdRbUCHgi0ALWZt720aM86b/GyJe3O/WhP+26SA?=
 =?us-ascii?Q?u+m4TF82SLY84VX24fYOXpRgmVH4dT9b7K60Kjt9nw1FwihwNefn+GmQXf5W?=
 =?us-ascii?Q?SUVkmWFcAQx8jVresqKNranp1HR0fww3uex4uVCQslQy6zvUdoqoR4t6p5mF?=
 =?us-ascii?Q?Vwhuc0PzKB0v6Bct0ct+T0ulCkPkqJtf+hnSQhagTDP/IZVRDeZNWQpua2Jq?=
 =?us-ascii?Q?B1cWV5KAGp4kKD2WjEMzg32o0/vLeBGR4OLQNHvXz1aVt+4IAxtL3+HPZ8JB?=
 =?us-ascii?Q?+16UGhGh3XWUbEZusCDKsGvBFw7L+l0iSivaf3QVSkS635Xe7qhBYzPvIlLj?=
 =?us-ascii?Q?+zXSbtIKYmnfVxCoJV+ZfKbD7tYGGWx13TJiO5iaS4uS3ym5WLReayjXVcNj?=
 =?us-ascii?Q?D38bKa883IckGPrjLJQ7F6AThjis7QkR5erKF/u9HUonTIY6DB4dc2PnEdoi?=
 =?us-ascii?Q?26VngwBTQu5cz4oDwQCafGP6fiXrcmy80Sv34tNhL+mxnCUyo04+v9h/5Kjj?=
 =?us-ascii?Q?cGpjD+1AMQy4e9Z4TBbv3xcCJxJlI4ytXShoVGv3sbRNwN1jN8JOyJo8PYux?=
 =?us-ascii?Q?QBoIdYc7s0hiYODkW+2ikHvsTiyFDWtPdkNjcouoXoX0rFljAVquhgsAW9lg?=
 =?us-ascii?Q?0irGnZYZeCy06oiXJN2L55pi4jWNC1x1tmvI99h8Q71iS5gvxA7B6M3S+4Ef?=
 =?us-ascii?Q?IPeES/wgEEOc6lRQz17kB3BQmb6WR8/mFE4Jnm34HMUBnHj7v2mtqk81JsnK?=
 =?us-ascii?Q?eVaa5o7Yl2/8tpo3zUKEhJro0GtViKyJgS/mQDUC3XIUfgJsDCBvYQJQvRGt?=
 =?us-ascii?Q?A26OPjA9lAVSYGugvaviVL+qUjEJsTYNpcWPj3lgsgTd654/wlTExHLkWFTn?=
 =?us-ascii?Q?ymwiUY4JDYKCvNU9WryekEcmLijBzQHEvXe2//oC1zfSkut5iJK8qYpK6FXa?=
 =?us-ascii?Q?EDCfvUe1qEV+dgQ520Tr4rnXGK1HjSFVHCk158EGu0os1Wcw2PKjPJDxk9P0?=
 =?us-ascii?Q?1OOubuwVJYAYCVvW3uDR44p7hx0v5uSLyg2YtyyLfKaiBe/jMIlvJuViqVOE?=
 =?us-ascii?Q?wclSVdjGDhmCP0sUelDS8b1skTH/m1Ce8esKZuK2Jl4E43x8dC55SfgBXNlk?=
 =?us-ascii?Q?XSfIHKsBo8hofiPdSuqUfnux6Js+ywbaVoYd1Ml+BBtr3gVBlILrKED9186r?=
 =?us-ascii?Q?lpRoJ0ZnawTLbhtpYjaKRzlnU/fVHT4IH8cbSOiJR9moXYVNOaFIwuFHh1nr?=
 =?us-ascii?Q?me8OIDrjyEXqKVjXhnwwOoEmzDcEEjOG24OCp6IHqI8ukEKq48d38dtbgs9G?=
 =?us-ascii?Q?pEzQk1+iwhR1nmxvJymgTlqe3HJH0whz7W4s3CZ8wxnef3AiL4jv0hbHM3Mi?=
 =?us-ascii?Q?uxoj3YWJqQgy2JARL6vy07xGwUX0JgGLquNMLRkSeleWtfYZGW/a7lnMi1Sq?=
 =?us-ascii?Q?+DhUNS4+0D3JJnwd01F5aUnN/Wir30qMe1fFRpn5v+xRb9kTn/CW5f9Dfm7m?=
 =?us-ascii?Q?QYjWn4Qc3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d119e2ec-cf67-4cfe-aefa-08deea669ad6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:54.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB+nrHJVnowvncrJ2Yw86u98KVgMmZG6lTYyK8qwWuSmEuwiVlL0GdwZTX7VS1jOdkFIbCCobdjZ01XKnY6BPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

sched_change_begin() only invokes callbacks on the outgoing class before
recording the task queueing state. An incoming class may need to prepare
a task while that state is still live, before the normal dequeue and
class transition take place.

Pass the incoming class to sched_change_begin() and invoke its optional
prepare_switch() callback before recording the queued and running state.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     | 16 +++++++++++-----
 kernel/sched/ext/ext.c  |  7 ++++---
 kernel/sched/ext/sub.c  |  9 ++++++---
 kernel/sched/sched.h    | 10 +++++++---
 kernel/sched/syscalls.c |  4 ++--
 5 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a9d4b5040089..474628f520a29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2792,7 +2792,7 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->sched_class->set_cpus_allowed(p, ctx);
 }
 
@@ -7722,7 +7722,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flag) {
+	scoped_guard (sched_change, p, next_class, queue_flag) {
 		/*
 		 * Boosting condition are:
 		 * 1. -rt task is running and holds mutex A
@@ -8399,7 +8399,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9516,7 +9516,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	scoped_guard (sched_change, tsk, queue_flags) {
+	scoped_guard (sched_change, tsk, tsk->sched_class, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
 			scx_cgroup_move_task(tsk);
@@ -11220,7 +11220,9 @@ static inline void sched_mm_cid_fork(struct task_struct *t) { }
 
 static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags)
 {
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
@@ -11238,6 +11240,10 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
+	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class &&
+	    next_class->prepare_switch)
+		next_class->prepare_switch(rq, p);
+
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
 		p->sched_class->switching_from(rq, p);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 81c2d8eeae410..285bd8422193d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5859,7 +5859,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				continue;
 
 			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scoped_guard (sched_change, p, p->sched_class,
+				      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
 			}
 		}
@@ -6141,7 +6142,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			p->sched_class = new_class;
 		}
 
@@ -7477,7 +7478,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6da6c91e42870..765b516e06c95 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -791,7 +791,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -821,7 +822,8 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1471,7 +1473,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, p->sched_class,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 437c4f68c9e53..ca436a8174d30 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2705,6 +2705,7 @@ struct sched_class {
 	/*
 	 * sched_change
 	 */
+	void (*prepare_switch)(struct rq *this_rq, struct task_struct *task);
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
 	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
@@ -4214,13 +4215,16 @@ struct sched_change_ctx {
 	bool			running;
 };
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags);
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags);
 void sched_change_end(struct sched_change_ctx *ctx);
 
 DEFINE_CLASS(sched_change, struct sched_change_ctx *,
 	     sched_change_end(_T),
-	     sched_change_begin(p, flags),
-	     struct task_struct *p, unsigned int flags)
+	     sched_change_begin(p, next_class, flags),
+	     struct task_struct *p, const struct sched_class *next_class,
+	     unsigned int flags)
 
 DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a60..bc32ce76ff4fe 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -85,7 +85,7 @@ void set_user_nice(struct task_struct *p, long nice)
 		return;
 	}
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		set_load_weight(p, true);
 		old_prio = p->prio;
@@ -678,7 +678,7 @@ int __sched_setscheduler(struct task_struct *p,
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flags) {
+	scoped_guard (sched_change, p, next_class, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
 			__setscheduler_params(p, attr);
-- 
2.55.0

