Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D443246F4
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253518; cv=fail; b=JabnsOdADaqXE05if3jzp0s2WsZB0cqa3MyUWv04QZ8/RbDKL3btSzzINFLvuEwPrA872eh+gv65j86aFz9e0222etINy+9SzRUnI7p8HALmKrkjy0yDAi/euyQinMjJ1u+YObaudP+tOuY+lM989Gm1z83TR83/5Tmv4XE92mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253518; c=relaxed/simple;
	bh=ctt1pjfbZQtAbZ6rXjJ+1+UB9WyvQOu1H5jEZ3nvhFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CotLBfVrMBH4tM/WiVUj8pJGlkoIBDLYVV6a4WsryEgoGc6qVNEFv1xqtM2AMK0ue99edXUbQkplp90cL2mQAZHQTJNqsC4IsH2vlbLUJduUJdJaVK0OOVVaP6GvAW5y53k649ioOny3cAOuKEbSo9LCPbBogXe9K7qIN31rHEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WMSoTUFq; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMSoTUFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llbmJ6Hh6SDJnOXSR9kk5p6cUkOy3Tv+6efkHhPamDxdjC83Ys1F56rLsvs1+ilXQq/qBjn/PxuVsJePsGab6ui+6047GNJYHvWXS9ctn2d+VbM+8BZohlMryJas6EKiVMpB52WhiAuz5BQpxAeJ56Qbx+TI4iU52Hau77f/kIPYEtyLY4Pkju/SgFJdS2OOLYLgn/YZNjO/TfGFc//Uil9Sujl94jRFlnIvRagm8NZz+kRxmavJbP9P/psjgxxchW105qCjaEWJExHCGjp1MpyRUay8Gz1BWQ0AtEtlxfG97aD0QCJo9/bP5L8Nd1Lu3jfy++lc/HKG0iAmVABX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvgbrVGqJ2xDmvAhfPXOsm1crYX6j1ch6ijKCf1Doc4=;
 b=Enh/G8zWlbhOaIGwbPiqcU7y42+HzKXTnBqpMLow8W8/I5eR0wDI70Yqma2GDRbKBAKwS1f6B+EC8jej0qZQTTdZmxltz6mCchMH4uEMUCRP/9qlIeTuV7RTouBDrlBfISYfkjgALMacM3o8ZND7wZ00gH3TDHef8rBlz4Hw4LL4SFT42uL9ivH2TxF0m8Dtk2t1M2I0SwTc+4iBylyBcz9jKcxv+WzvsVxa80AnA/sqZrx0DDgA+dkRiP/rYpIQqZ5N2JMo+yNor4zKXS5xntvpyuMNxaqCf+9IhPk1ud9eBVB7zZuIi2uUVkhu/eWS0Zv7YsHt7lXEcY31mlsDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvgbrVGqJ2xDmvAhfPXOsm1crYX6j1ch6ijKCf1Doc4=;
 b=WMSoTUFqPJcp1NqEs2nsetnrJP01stKc5rGCl/vX+7oeoi/gIKxVX58M0MtPzxuQJp4rE+FmzGsMDAVHfp4kbJbGEow74k/w+G+W7gHuUht/FZZJ5YeYt5Ho9dHO8YxZ+l2PrhHjIvN4rPD+Qml0ZcKROSK36SHig1uYCZcrTg38XZmtQGxpiUX2rBTzC8t2tpnZE2k630rh7uRlwGc0D7SeDWYsxziD8afklxcKuLAQ4tUFdHfJvBV6X0azHwM+DXyVCgJj2J1sYIx2f+9jjQJJnpzcaV4+y4mB8JhFsYEwkR60wkF0WqHat45q78f73ZzFXqUDLQSYHTyp8RSL6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:06 +0000
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
Subject: [PATCH 05/15] sched: Add prepare_switch() class callback
Date: Tue, 28 Jul 2026 17:43:23 +0200
Message-ID: <20260728154425.1549660-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007534.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ed3af1-cfeb-4861-505a-08deecbf3233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GMlQljU37w/CFwWxm2SEYXPfvPL/LccDQAkiU7U4V1EtkgppBlAchnyW3tXbcwbhl5Ar/ks3TGy7WWHjjxk7cV5Q6xU4xVC9OqWuOOfjNRPPZ6xMhJ00wt7mhF4tZuYaK41uMwkPrEsob1Pr0Hc7aqzm3G61HdEIX97w2J3MMS9U4qr8rImAHniw4vNgSwADGm5YV9k2Qgci8ECpPzahNLYbAQncmX0lX2QC5MiL3U/LEivkPvVTn3L/aVTg95eGhG29SEc8BXXvl8eBWu1Z3ROdnrxIyllkNXUWSAMCN22mekYVnKviM1KnQKSU4tfbEKplMppt+QZvRZMbGqNKW2VyGajqpS8wuYcACGVbxZEy8uE6HAcNbI0YzhjPKXoc6Si/DDbDLWFYXdz1BgUVjziekTC37KgYiwdf2+lgRQE8g25Mp2E2W0AYLD+EaXbR6iW1jxhpmo/LULHoK1zRsE8H7It6P0b6YmZCGz4zely6gejfMjNm2Q2nVm6ICoQ1BiM9qKn28Bc6kb0md3SeKOPbC+VLI/1ikMm0baZWJEt+c82VyHJEhHi0zHNQa6C2zdgKHi4CertctorwvRYVUAA/mKEwMgxW/wXOSVOVc/zitd4cNeNSYP89o1g1VctCMb9irZjGcHhkmcw+tltT4H4N/LjdS09mPuyEpCGRbuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFcfpa+VTvZCgq4ui6wWY3IwofuV7oDWdGqraMFO50sjAUjOzYjelzgxkXKV?=
 =?us-ascii?Q?lrwHuj6OXzChZH8nZU/vFNRWj/+J1Q0qKDJ9dOy2oSihHA61oi4xaxp7TNJY?=
 =?us-ascii?Q?CyvswbS1+pUn+AXyGB76YNJM8niFfWtX5+Pijg5H45/wx4RAs9hG7MFuojl+?=
 =?us-ascii?Q?UM1lvqMYXIxl3pPU2W1OcOPSCYJxS+R9D/P4CHhTVuiBcApRHCm3K8fVBFjX?=
 =?us-ascii?Q?mI8NLKrngQq5Yk2jNYdXAv2twySyzrSOIhif8s+ZEdewJ7dpDtGlcelZSOTK?=
 =?us-ascii?Q?LXI+IHvEaae14e0f3AwhL1KwZfiCv1dUWb1hCYhLf298Sv1l1+T4lnGAk84O?=
 =?us-ascii?Q?nFshDSoCptKL7M/26bgaZJuihiUy1pr3ktK6tx0H4bLhMer75yTdbvE+bA3D?=
 =?us-ascii?Q?V1oqWKCGcfJ9waHclVYBGPITd5vvfxicuHWeURFp5dH+LXQ78I9RZQpW9lxH?=
 =?us-ascii?Q?vwBnWhNCxmYDPpXcdZY51eVmyG2ChgFsBA3bbvxkL7sSTmF8hLYq2qc3BVhB?=
 =?us-ascii?Q?TrIM3jy9755gpX+XrnuZfvOfhZAp/NWsuoSRpv80Ou+J+zngMBoLfBDauQc+?=
 =?us-ascii?Q?BYqpxOMibB0B061W8PfzV9NTorWbxQp1Z+KA/mGTZctFIxnyMuOYz5Bws7Eq?=
 =?us-ascii?Q?svQafIgd+dPP5T3D+QQ2UOqPvfpE6cBcIIhLBpL1nnExdDt8Mibc8w3hL6yF?=
 =?us-ascii?Q?rp8G34o8KPxL0IT8h7z4UkDvRz6jAxonICwvoDQBrCsMUZb7wcIjs646TtUQ?=
 =?us-ascii?Q?+smiVWlu4dsHGjAKA3+yzZBEukAU0TG5NuEPmWww5dey2J7xPxoadPaFpXGB?=
 =?us-ascii?Q?220D2cR1H8GRKLNCpDvwGc06LdnmaK9BWKM2qKheC7OZRZOYiYdeIjt5A/DM?=
 =?us-ascii?Q?a+GOSKiYyY5RHAIJuH2Qdni8fKrTlHw03j3nSZ3dtHUwTVGP14BNgVnsv74o?=
 =?us-ascii?Q?JMTLQwkT5WnQJusuCe1uDLgR+M0MJgd3BMTwkLGYwQqNHVlQ1p/72low+qqP?=
 =?us-ascii?Q?GBFEgXTEj851X6RDnQbECX5sKoPKvqNEO4vZcGj0N6GxMutJQJKkKJdasPgm?=
 =?us-ascii?Q?FOAwXa9X171hTEnwr9Qrz4GLhJZULi6DsSUiLLwM1RVzNr98Qde1xik+uHlj?=
 =?us-ascii?Q?ExVdsz2LZhu4sjsZ5C+axtoWxEvRNACgiBCpXDPwxuld0qezfK0UtkygE8zn?=
 =?us-ascii?Q?jNxFcmImO+dudiQrVv3qiNxbipdQwnNGv+l3v/gf2qCqoYDEmPnXbjPJ+nzj?=
 =?us-ascii?Q?3eT3POkB1He+YVBpeABFoEzPwBwNYGfMKAS+8Mp5P+GdI6GZdSEHEMxkF8b3?=
 =?us-ascii?Q?1CMRcFRxUAi4jylcCPPa/0ktNOn0uhZHLTdVIDmaWXWXu+vFodZd0a9G2xrX?=
 =?us-ascii?Q?c95O5y5Ha0HWxhM7DJVLf3dO5kc9YEN1h2vkRGPXiCdwITkON17VIlyYJRVm?=
 =?us-ascii?Q?XM8sTU4seh4DshB4aFumrvRYS2MguMjKeIlBNMc/DtRtmml5ZnDnwLww8hxq?=
 =?us-ascii?Q?2SOSFrMZc327dNZgxXr/hoSZ7VUptbmEdFa86rmNW/4aP/baz+jAyR32kio+?=
 =?us-ascii?Q?DxmOtjU3AeYf9qTVpdSrg5iQjAbgyK+YGi/gYPOnajge1bsGa8IlEWvVTtJF?=
 =?us-ascii?Q?dtAELwfVLlsdhIMUnqZwZVIsH4UveqwQNLPBmgJjaw75EAE74t2AhCJ2ZxYT?=
 =?us-ascii?Q?/mhf35ziHMXSf/YJqVGHDqFpwlJVO7umECguvH5EWZERTj1ETGrNx24z4Gtv?=
 =?us-ascii?Q?pOp1e2rvTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed3af1-cfeb-4861-505a-08deecbf3233
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:05.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OYjLKOkXIH8PIU25LdKKs+iEas80glP7Wz7NV4QJS9asctFSFYgmACpUkL9BNhYEBw6l2XmBTp3zXdmiOEP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

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
index 2cc6c9d16200c..cff007d8b5e26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2785,7 +2785,7 @@ void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->sched_class->set_cpus_allowed(p, ctx);
 }
 
@@ -7715,7 +7715,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flag) {
+	scoped_guard (sched_change, p, next_class, queue_flag) {
 		/*
 		 * Boosting condition are:
 		 * 1. -rt task is running and holds mutex A
@@ -8392,7 +8392,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9509,7 +9509,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	scoped_guard (sched_change, tsk, queue_flags) {
+	scoped_guard (sched_change, tsk, tsk->sched_class, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
 			scx_cgroup_move_task(tsk);
@@ -11213,7 +11213,9 @@ static inline void sched_mm_cid_fork(struct task_struct *t) { }
 
 static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags)
 {
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
@@ -11231,6 +11233,10 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
+	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class &&
+	    next_class->prepare_switch)
+		next_class->prepare_switch(rq, p);
+
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
 		p->sched_class->switching_from(rq, p);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 312938179e524..69ab59d176ce0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5861,7 +5861,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				continue;
 
 			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scoped_guard (sched_change, p, p->sched_class,
+				      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
 			}
 		}
@@ -6140,7 +6141,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			p->sched_class = new_class;
 		}
 
@@ -7508,7 +7509,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index daf7fbd3d0c3b..8758317035754 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -794,7 +794,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -824,7 +825,8 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1476,7 +1478,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, p->sched_class,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6119bfd2de60d..79daacc2389e1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2704,6 +2704,7 @@ struct sched_class {
 	/*
 	 * sched_change
 	 */
+	void (*prepare_switch)(struct rq *this_rq, struct task_struct *task);
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
 	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
@@ -4213,13 +4214,16 @@ struct sched_change_ctx {
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
index 903b47f5d0b74..9ab23f765f7a7 100644
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
@@ -679,7 +679,7 @@ int __sched_setscheduler(struct task_struct *p,
 	    prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flags) {
+	scoped_guard (sched_change, p, next_class, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
 			__setscheduler_params(p, attr);
-- 
2.55.0

