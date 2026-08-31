Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609D5293EA
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183878; cv=fail; b=IsB8/jkWGY0ojGBcD9MuJssVNnJV+JrLJvF9Owg9yb1sH7GdgpI2lihQkSUWmRNYwUL+HdmzqK0ZLPUnwOeWOZLsnD5/75GqJ75TrqJCfn/e1XY3BbBf48Bqs9jQ0BdHTdNX3eysrwrm6H21ZyufqjPh7EJdpkhISEdJh8LFsu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183878; c=relaxed/simple;
	bh=/tZxOJ1pI6L/Jw5ME3cxwwC2D8nhMCOxd2cKYgj+eCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DN9zJvFTI+sOZWzVf0g37tLRD9orye2qZEIW2CWTdzy7Egv45tGhi1eQGTOjKCf/pX9Iy4qTobb0Illhv94zVoskOkosdI6gxtZIOMv3II397iXAxdmxyc19szpfwYE5XBykGECukKEn5rqMm1il9zLmaMYH6XNoy1kRObsoWsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WyWCcc3H; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyWCcc3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aC2bTnUWYE5COng60Q15yX6NPBSLg1tualNKQBRLuNWQkHUlOI20DO8cAo2q3DkyxEfoUTVWFNEW2jgW+3BE9Zboec18D70AK5SseWzIM5tj6hDz5P5N9d1kodPLo2NaGSfWswZFT1n5NC+5zOoA4ljLPnr5oAyCijUX2MKybtusTZ/1P4RGQjqyQxHM3dbVSb4nLPGGhGo95eh6r32ij5exHRYP9DX1jCOaHg7rxZKl/cugt0jw6jZxYiajiTCHWj0w8k5yGO9fRUyuX1KrlY1LnN86OsuXwJ9IVPOzVmfF93CUJfhX02YBEermHWwi1wfbO+i9S1Wt6XsmzH5MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG6e8PCVljnYMooSMxSzGNMu7Xo9+qywTphurOe8yUw=;
 b=yFOaelt70rJjhcGfCdrt3uCLvm0PLlnET9S3lWkJe1jMRFIbeZNdyiHoPPOlFRvO6vX175njkiZ4IHJ/krwm6veykI9uuQ4lqb88wn/lHd5T03WlCcxi5z/WwyTLVE186Aqoq97DBYnAR6QCSh3kln8NpiyCkXViLjYM/RE78FTUvm8+QJK23TlMEc8TMH3YJZxDddNdOLDgoUomJhgAOvxXgMPeRuwgMI4WTQmBMxFbbzLNwTv41PO6sUwhcs8XHv2ZQp5woyzcNganCys0uIydx+wNJjFRYWHAuWvWSRpws28BBPMsb8bhQUcdxaYbP+XHV470L1H9QdaKGLDplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG6e8PCVljnYMooSMxSzGNMu7Xo9+qywTphurOe8yUw=;
 b=WyWCcc3HGDhgb4DWKdjV8WFceAEJMFEzbpjTAHlJ43wRbSB31HaEfxh8Wkem/POd4arHkhZ7uEdiiC2XnORH8jHnRuOsPU2QZ02BJzS6Itw7fphS8uNc8IYVkYyZeYCVV5a6xQLlTlQJb19Vbdt4ltIn/MMSBJElR+XpnA8E2jMiax4cL2td7y2+HwZm3g6HqF0GIufsnn+yhqsbK3n/MmhpfAg6W4eeauBG1oCnlVHqleeHjR7YPUgwe+MSexcSImsfhIophuwrd81P5qojzmBCMoE0VCK1vf9YuytOK/k+cmSSjf9iqZdiy0ECAMveEiFkg8RRqDeslDKQkNXsZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:28 +0000
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
Subject: [PATCH 05/18] sched: Pass next class to sched_change_begin()
Date: Mon, 31 Aug 2026 15:42:15 +0200
Message-ID: <20260831134338.1531664-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 244a813c-12b1-48fc-3bac-08df0765fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U73xZ376NNUq4AGEoUlX4f9c9nZJ4iqUDv0O8qYA98ZL8vmmU0wqBWlW9LV9gw94cq0oz7QZ5F/q45OgHej9t+i57GDkA3XrtE8+ebdUQmG1203vFE/5tUJ9S2SjhfcXMDPuofr/2bDO5q1Vd/R7XNi59acwaqNpP7uGhzIr8s7VIll2OzLOliENcM5Y9xiF73wx+3E1rBx3BiqjqCf1Ni3GC6dm6GRJpD/egO4IZgvs3JU11uEyX80K4KbTR1xtAo+dZQfsVTRkhFgJ8mW9VvsRb+eijOk2YuPobgjkNyCCQ4gP4sHPsjH4vtZ/A/qXacaI46YAfxMAecX91tqFwz8ArCz6RdCmz8+tp6wu+FpieDh603vAeoPKTxM0/6Hzc7U5EI3/aArazB4h5t74OmRW/b5jAgGpPTVc4AvzBUA2Ga04D/XRWlSMtSaepZNpq09cW6OuTryOYxREbS3gYKQzzbecKqNmvuK0ofaHeikEv3FMhNWU3kCG1nLgxH58ZgVbuSHyi8fewFxwE7rSfUn/c1MvAhIeMzpQc0GASdCiPpnX06hIhVlc1NsFENQFqA1h/DelUcSslw/g5SX+UWtvkFeafdGMFeqZHw/Bpw4XP4hFmHa9kPGqW+zLVMJ8MLBcoJfK/4OhBtm+6FQL/j9YcuFN0syAepWpmnOGlbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWL3W2TGvzqyqmKcZTouYYxgIaFQBh7W2pFPseKRPSOCZ5uVnmSSIT/3S6J2?=
 =?us-ascii?Q?lGw5Lh6lc6qKiIm+QfIm/JKgW9l/13Ciyk9mhmUmo+K7+ra1hFH2Rkq4aVFW?=
 =?us-ascii?Q?mZbhBdv+omW9KpxpDm+whukifZmjgkGcUfwXv9tqKN7OHge6Qd6qWytr112o?=
 =?us-ascii?Q?aP1E34avBIOCyTB577C4OPSEbA37v4ugd6B7IXn/WxQIYt48XKaBMxpWwBPh?=
 =?us-ascii?Q?5+ArRkI2PwbyjTlykvKCYMzB1nqzCgGGOHc8wG1vwsNnvOqwhybvk7V/j2hG?=
 =?us-ascii?Q?a+V/6x7lgGrH09JAd7icejkulrO0FcGEcqIT+IM5XbO8a01oyaEzmdxsaebm?=
 =?us-ascii?Q?+nZu+OPItRIApExKiATtbrstjgCxOIOzGhprpWRCOduV6tb+WtiK25cJ3p5s?=
 =?us-ascii?Q?JPSuIYdVI0jLi+uPf0+ALqzmRMIJr6m4dMU4ulCqLWP97UR667gciT094f5u?=
 =?us-ascii?Q?7hQgpmuIXVpgJFuGIollH/VRsambNVUtzW9vTYuqfewfSEquMtypUBA1Vks6?=
 =?us-ascii?Q?MEEKyowzfoooUX5sUllIo+QdymKAhsDpJqra+EI+7kkEDKeCX+fXjrJMnr/I?=
 =?us-ascii?Q?2zqTDdipyFov9XxnbctTWiAz8eg/8YcUlgHgjk1LdvkGYUFPp46L1yBQiyL1?=
 =?us-ascii?Q?u6KpLT1/iguYx4UYjZuPDfPiXsIEBm7OOTceqABGcONmnZgGNztTTeVfK/IB?=
 =?us-ascii?Q?yoS4XByWUlN/HBozXO2Kvm7MYVkX35TQ8mHj+JNgi/BAZXYtz9lruI76j/Yc?=
 =?us-ascii?Q?9z/kUmFo2t6UaKgN4PqixMYtMQmkWPRRC2rdCVCwt8G08dXiMC96dHy10SDe?=
 =?us-ascii?Q?9FruSLyR08ofXcvgCQYEdUISSOaoWYOeJ16Q2ksTmHr2ScQJ6Y6JV6qEA7M7?=
 =?us-ascii?Q?z75x8tv2ykakFvG/ib5y7+l7kHLeJhAnvFNNdWbwzTJR4V7hZ6RReeHgtMJN?=
 =?us-ascii?Q?48ipzb8zyUsYQUAvLun36VpJdOdsfqXFKMiYaLSsFYmlTemI4Lh8vrMMU3iS?=
 =?us-ascii?Q?1TvGcYfEq/R++WsXpeZQfdBeXSHOEvNV8b5thVQ3HSf3llyzeOWMMI9+Zkbx?=
 =?us-ascii?Q?kJq87alQMMp3/AY+NrWjRfPd+39Fyqe5Kgd3wZsqc/LrgTgthsLs31LwIFI5?=
 =?us-ascii?Q?VFVUsMMiBL08/pHazXH+kHoG6F62FpPiaridlF46j7+LgLncqQanBpbpIKxQ?=
 =?us-ascii?Q?QkzoOpSJg18tIWKLVmX6jrJaACQ60eAXK6KUBeIS0qHSVMLmUZivAdvnv/0b?=
 =?us-ascii?Q?FC21jLQHWycZmIoXnkLyA5g4zVz8Q0YWPDv2WL/kKne9cV18airCarROfj+Z?=
 =?us-ascii?Q?ogUj5LaXgtbLRBhKljjzWggr4yEdCZHlqkeXA6xGKnP2sbfwAGQiz2yRN8DB?=
 =?us-ascii?Q?A3tgKAso8W8xApgRlwU7g3Xyh6wWPuVx+837S92c3fTcdVAUJDcntpMXswSm?=
 =?us-ascii?Q?6W50n6j7HDSyU2PYhYx3FIVuWuxQ9e/ETn1VOG5HeNx0BL/LmDqHPSpXZgGV?=
 =?us-ascii?Q?i9AkPcJj7/brGGkUkG5yHFySOmqV6UtERFr87xbp59HUIUsEfbLSO32OKNlf?=
 =?us-ascii?Q?wzl9454l+6hvgKZbhX07zoezH3HLJcEV8ZjdbfhG0fQGT00UDBNbMIlV7EeV?=
 =?us-ascii?Q?sdLSX9MRL5vEIEnmRRZCkUGbaGc+7QMXX/6FR/5wCtG9DDkhAZD3dnpOol6w?=
 =?us-ascii?Q?4+wBnpZvoj9SnpZt6TB8YweOTF58GT0/LzpF1vuHC3zv+YZlpaX0XW+aeKZF?=
 =?us-ascii?Q?bEqGEiETDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a813c-12b1-48fc-3bac-08df0765fa02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:28.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srPJd9KftlivBAAk3RHkzhRCRcSmpORagcHssAUwAz8Mfn8lZnPIfsa4G6t/aUntlhk2lUBvBXeTwZP7GQIdlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

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
index 0a2eabadfee02..26b8da8c8a2c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2802,7 +2802,7 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->sched_class->set_cpus_allowed(p, ctx);
 }
 
@@ -7753,7 +7753,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flag) {
+	scoped_guard (sched_change, p, next_class, queue_flag) {
 		/*
 		 * Boosting condition are:
 		 * 1. -rt task is running and holds mutex A
@@ -8430,7 +8430,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9548,7 +9548,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	scoped_guard (sched_change, tsk, queue_flags) {
+	scoped_guard (sched_change, tsk, tsk->sched_class, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
 			scx_cgroup_move_task(tsk);
@@ -11252,7 +11252,9 @@ static inline void sched_mm_cid_fork(struct task_struct *t) { }
 
 static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags)
 {
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0c..00c368e2fc82d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6159,7 +6159,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scoped_guard (sched_change, p, p->sched_class,
+				      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
 			}
 		}
@@ -6441,7 +6442,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			p->sched_class = new_class;
 		}
 
@@ -7802,7 +7803,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0554448835bd0..c3955c8163a03 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1255,7 +1255,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1285,7 +1286,8 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1939,7 +1941,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, p->sched_class,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf86..6bba1f3b5d4cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4240,13 +4240,16 @@ struct sched_change_ctx {
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

