Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD820125F
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901885; cv=fail; b=HgxD+nrmWEtylgpldIxNPBFMQaCXBSqbJl1WXUnIERzBkA2pgJrS1aippwlZsHsweGak3pMKy3NfdUFjBnJ17c+SOgc/Llr25eInhzVaHcSIdlnzf644Tl1bK3h0LGXeCepDFsjZx+gwhphrwy7U6d+vtzxF+KNo8O2obRtcNuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901885; c=relaxed/simple;
	bh=3TbZoeybtBijkIHlXmQhCtatzhYHYY+oII10G8kNNqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQUSSglyWt6pnB9ZnShnbkvuJdHWgBmu6Ehqk/J23JAHksUFc+i+jwdMY9o8cw4lfBuLzc2MUKkwszgcArWZoIlVeql36q0dylLRkfK1QtmnDFUsHnJ6nt3brWcsiFKMdhbEKn3lhsElJsvJvCtzC+JxeoAau5avarEDRr8R0uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyE0U7SD; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyE0U7SD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtFG5qThdIJeezV4Mv0aBfMLuiaGXeYrezxPkZMTKTHZzodgk+dWnWean6p/hxcmW0zzDmsPSgS/bMHm7ZH3/29NIB9jpc8poo3qIn/KtIPgEkGf9JKoIpfTdwa90nld9d+AbhDgqn3AzTPkKGaYU8Yv5AxyUwXmin019aP2miESTq820fBy7EtWRY23YZ/nnInIxOpl6Atxo/2211Z5zUpy8O4Hz32eg0HXmPUq4a3zqScA2E6AnhyospMFry5bWCFFXEh+Bg5jU8HNg1DiCW+KgevYHWwW3BCoXF4v0lhwd9C9fkEeumJ9E7cirGoc3QChH6tfQO3hlSnj73DOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEaZMxrfmTrNGmfsK4KzIeAIjPJthG7txUYaKPMXEOg=;
 b=OywHyWCked3p4YUpJ0zbRJQ+kn+aiOdNTkKAX6NKkHROb3t6qCzMQdcgngjUJs3D3VNJ/kl4FZqpcoyBJvIPwmxS0zrDbcdQcTeklONBlpoptDS7fzN/5JHrqIq0d0djExb+h5wG85qsWqqvgkvnlVP4Na8A8Hcd1MRwwuhVagDiVOts0etYbgG4l5LjVa6RBUZR6JfnhErEOLAF1/6v6nqF/f4CnomXQHaeZBdcjRmlBoBvRrity+6YSCGCyX8K2ids2qo9eRU5LTdCyGdtPmDN0VcauxnCAA8VFhkbmRmEdGscXWX0zXHgfa5j7wSr4fbTideOxiQDiZj5eC3Bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEaZMxrfmTrNGmfsK4KzIeAIjPJthG7txUYaKPMXEOg=;
 b=eyE0U7SDxUFU0+RgD2PeMAL9s7BsV7MGCt8Mub+Xfx31HIqAm3QbOQMgh3qw8YUFLA87//zk2ZXB216Qj+FzMyb5pObFoqSudY5r1lwkQu0q6kibW7YVDV2WSWhjXaHaKf3EyI9ljcYnbFXkhNmaUm653DlmhEuejTbS2kd0dDy3DTzSqIC5wmc7/1H7oWoDRj4cXRuU67RprMKvss6PckVGrDblvJsoQ6jhXfD2JsVahF6Dl49+DjNTp9q0NClK2ShnNzkxxq1MkqynrgYXDRZ1TIW8wGmTS2BYiLqpOmDODwuRrHPERkZRYTpdvTgGdc6JmcDBI0EY+YsKPc7j9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:59 +0000
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
Subject: [PATCH 05/17] sched: Pass next class to sched_change_begin()
Date: Sun, 16 Aug 2026 19:35:03 +0200
Message-ID: <20260816173732.17162-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f92274bf-6b31-470d-aa9f-08defbbd1d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Wt0w5aCA/wbtL2r0xJL6dMbbRNuCgGspQ1N+tJdQIENNC+GlhTyK0Rl5gtghmywkmAqGtqdHnkRSeltwpNxcblihuslhaPUCiAJFAzpNPBQB6b7/Cy4x3IT4ZHo1KpbffGovIDZMZql1ohDIAMA98+1bU5YsC+gGVW+Emczxyqb7Q3lpetElsi0cPEyd9BAiNyVVCje7EQX6fHF+ecAxdndKhDPm710zmNdFiWIihdgL28tz9yhHcFG6WFp/LyI0YyzerS+pF1PrkfMpHCYu7pflcy/1iq+mFdgfbmkJSJm0U6IzIV9ui3ts76PZzZ2LYwJXV8j8XhGAA/eyskLCcO+bxe2Abhbez/V9aPoOteJE0GFGisFslXeyQFIoYt4qxbEp8ulomvx4GAfgr7Wiu+x7x9Lqdd8usgh35OuLhKlarODRxOkzf2cTOyIioqncMOxbd/xAM+WcJCMGQtDrygCJFEoAFttatRGGYBfgFddj0v1Es2jvaNL69Hp8GJ3vUy9NbKZBdWj9tE598UVyyzUuYtP3pUivYXHr+4FNUEpwPL2ZFrqyg16UTGpzacZgZFXDo+BZsne7EME5qGUYRWBvExR576rZCtkfoJ+sgX8O386aJU+Vnrdxl40EMuZgSj540qhA7FkFUVxFoMXoJcfeBCUsi2p/snPeLNrGNaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptR2kZcSfV1hZJl/eA2pJsnoWQNW+NtczWVnpGVjdqOqUNffG/9WWoP+3nRn?=
 =?us-ascii?Q?krxNHoSXOABRXkoE6jcZhHUp1bz7Al0kI7kfH2icjIPwXnPT9XJ2YKWHTg3y?=
 =?us-ascii?Q?o+PcJDte05PfNmb0bmykHh/kHr5+l7qX5Zgy2vQQ1nY1/QECtpg6wwRGL7Q7?=
 =?us-ascii?Q?sUHxUFTSxhIWTdCKGIEjDgBSsCdrxr5PRh/MGGCcToJ9efvjEnuREHbfDyko?=
 =?us-ascii?Q?So6fYFEhLPBCBtGcLBmeg7hYXcjG2SK7d3ARf2rjDGReecYguJhtqRDGsBXh?=
 =?us-ascii?Q?a7IldKfxyT/v8i9p4DBotWjkTdFnyL1k8xe+7hLCBm4huOOT+oQozVVXEM1+?=
 =?us-ascii?Q?yjX00kNf5y5xYdvWaqlW+QSciHeMKWz/i0j13N7kXPBVRAh4Be6XbmsYD81F?=
 =?us-ascii?Q?g8LqFSAdQdzfxVh6j3x3Q6nfjoDIBcuBwu/bWCPrHrRKlgx13yK2/NLx0xjF?=
 =?us-ascii?Q?xwlve20x1X41THs6zmeHoK1DS1ZFe/8vZBQFC/K935gHSWIl+/MHuO6Q9eAv?=
 =?us-ascii?Q?PRFbsmgZFaxuXyI1KQqzTfE2vZvO78AuKhYKEqNIJByQjTwKyDtEsySjbNBQ?=
 =?us-ascii?Q?IT0cgPjLWbtXMVims3HrVyt1YdND6SSYOca1rAFKhqioABRwm9D2dzgGNY+U?=
 =?us-ascii?Q?NhqnYDX5AGIkfW+qqLaJ6AGfoPhDIH4Mw5yOf4ehg91l33RTqJwfk5g8Xz9w?=
 =?us-ascii?Q?xDa536ciVZq2/xFpCof0mvEMyMvlqsk1fWanSy19kekR+L4EpbNM7RFPO4UP?=
 =?us-ascii?Q?9V6Gluz0912w27V9cdlEuQcpzGEpVFJSKC7oa1r8Ihuxto75tWnfw32GpLOM?=
 =?us-ascii?Q?oDrdWzMc8IQ6OAZK6Oyji5mdledzAhwcmy7ThgnBIsYltyyTvoynYOlj2hKf?=
 =?us-ascii?Q?VZ38NOYilcPPKwoFe2EddC1iDx65wH/gImBSYVX547fU+Q/X5s0I/yFQxY+j?=
 =?us-ascii?Q?mUGa3vh1c22qKpNitTn7ufUOD3AFNUI1kckVy1iFBrfr29/bSXZbhkAELZ5h?=
 =?us-ascii?Q?aXjJB4y/yv/i9zPizJhRsmcS9kSgv4VxvM0peYVWz2U4jU0npl0Sart+zxbQ?=
 =?us-ascii?Q?HF+tlz3E9fHmuj917FxbiJ3VyGPjftGibhSOB7yYGKQbnD2/DgMhQsgQ7J+X?=
 =?us-ascii?Q?oOHVfoCuDs+ImeZp9umYg8AJqGK6LJTlmmnXLDrxB+kKdSr/c8kTzQ88JGam?=
 =?us-ascii?Q?xeJ4F7nosCjivyjyyLvmWf2wNWqIgYlVNrVSIBU3hIsaqLGcThRvdgC5K7Ju?=
 =?us-ascii?Q?QHHSDM7IkYjtlgBgrGSvsGdnE8x3m9yZe33aUqH/YH+AUXE9XO7MHCOk42kX?=
 =?us-ascii?Q?apVoaIl2X+uEAepnJVLMHUHMmpRLYEY4LXvgtJuzkAdDTMw5AxpZndq8JK15?=
 =?us-ascii?Q?Guc3HocWBCDkHizmfn/OUNJK26gjcxqHoQuOVXElTDGiHKKjCdrU9sOagnTl?=
 =?us-ascii?Q?IL0og5KK4aIJwtTr1Vu5QoxbZsi2R9VgXklWHNeFl7r4ujP6Njw9NcU5eXfv?=
 =?us-ascii?Q?cOJ2R0JcZTzwhanNorDgN0hf87klzz74VfiB8QagtNvLXN9L25D/qSoh4GsC?=
 =?us-ascii?Q?fhcZEqLF7mwlhgA1GGyAXs5oFklF4DAQ0JE0nXlxxonTnoxa5XPzwKg/fx6I?=
 =?us-ascii?Q?Tn0z+ie3yeEfZ7YSk18UWk6x7Bb813rWpWRu9jQblvMaiFUqMuD0TV1DhFAn?=
 =?us-ascii?Q?swLGd/z/SFqIdXXGpwDLEVCNc8Xxx+PIG+sLvgIYz8xF9Duykx1OTsu7lX0L?=
 =?us-ascii?Q?dUkq8IjWPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92274bf-6b31-470d-aa9f-08defbbd1d7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:59.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erfqwEVnkiTPcJLHi/32LXZj/XxKBNre++oNWj+DAxRJ26E2sThhKJD43/n9DsLezfpoWG4t8Dxqztj/3lgS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

sched_change_begin() currently only receives the task whose scheduling
state is being changed. It cannot distinguish a class transition from a
same-class update before recording the task queueing state.

Pass the incoming scheduling class to sched_change_begin() and update all
callers. This allows transition handling to run before the normal dequeue
and class change.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     | 12 +++++++-----
 kernel/sched/ext/ext.c  |  7 ++++---
 kernel/sched/ext/sub.c  |  9 ++++++---
 kernel/sched/sched.h    |  9 ++++++---
 kernel/sched/syscalls.c |  4 ++--
 5 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2d34b7f96e67..6b883d21d5885 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2803,7 +2803,7 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->sched_class->set_cpus_allowed(p, ctx);
 }
 
@@ -7746,7 +7746,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flag) {
+	scoped_guard (sched_change, p, next_class, queue_flag) {
 		/*
 		 * Boosting condition are:
 		 * 1. -rt task is running and holds mutex A
@@ -8423,7 +8423,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9541,7 +9541,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	scoped_guard (sched_change, tsk, queue_flags) {
+	scoped_guard (sched_change, tsk, tsk->sched_class, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
 			scx_cgroup_move_task(tsk);
@@ -11245,7 +11245,9 @@ static inline void sched_mm_cid_fork(struct task_struct *t) { }
 
 static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags)
 {
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 532c979a1de4d..186a3f4e1a92f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6158,7 +6158,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scoped_guard (sched_change, p, p->sched_class,
+				      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
 			}
 		}
@@ -6440,7 +6441,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			p->sched_class = new_class;
 		}
 
@@ -7801,7 +7802,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 92720a00b7113..2258cc94e6661 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1257,7 +1257,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1287,7 +1288,8 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1941,7 +1943,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, p->sched_class,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7701a5a60972c..458edb4e52c49 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4223,13 +4223,16 @@ struct sched_change_ctx {
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

