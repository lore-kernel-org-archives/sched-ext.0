Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E641A79C
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374980; cv=fail; b=Tm6AMlkE0Kaen2MrcKcRguiC3KHtp2ZX7wdZvWenC3qUkf/Jy9h3J1oPfq0iovArp/RsOf/YgSCvxOANdLaCqnOkE36bC35/NB/ilEz3Zv9LHzg1yAHpxbismD6gE9PN+Ooo/8HqkLN7cWYpzx0cwIa7YalXLthjLVDaj5TgsSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374980; c=relaxed/simple;
	bh=m/Uth1isfSpnNRd8QnWorlejqfSsOjSVCR9CEm5IfiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXk4D0cra817j1wPxk9c3ltIpO1UK09ZCA4ErpX72+o+iCzDemPOHgMBTFEnuSJMx4hGFoI3nW8cXf8rPgF/FGQhOJcMZoMmFn5/KuAwtVU5QaOyzkwVlnaM+Ls3CP4vf1CBbcC391zsRXsYEgS8nUs/9KwxHIdXIUeQUbzsY9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=evEUlspz; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="evEUlspz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6QMxnqIF2AN8Y3Tf18r3+iSbzDn0AeAwq57DTCRed4nC/Drp60omP8ZI0A+l/Mlbu/HUOGKyYxO9x2SSrEOHFRrbLvLiCALXqLiNLklhaWJeagcI39EB4pKpZYdd8SIIgD6gjTm7OgBylpsv1LpQoKapl3HC4jjqRINImg1Umt+VZGqi4GvA+3j9DH7tskowCVf0OoJclhLzPRTmw+k1QGYpul0bMYoiDVRFc75QuMPODRSqSQU7Eb5Z2W+XuwNRLpZJablmbaGtkP/WZeoIZrWyJVvfuwcEDcekMQrVXU9trL0hoUIgu8yO4WryW8h86KuQjj0k0bE7W2/ncOW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFhxL0BcLIXcgbtJhDL4flutWTz8qlOqf5C//Xmum5M=;
 b=ueO/4p5QwDBjzVXMan9kujnqN/Na9QxkmdYnbUKvIPOxeWbj/MsHmI5Nd9pAu4Vtebc/K0Gj+m76OGc3fk55gsOvR8pQ6z5xwDF8Zn9uczHguJqzYWmHM+tykuCBsauSYirGxZuTSB2UGjkNR4u90Bjs1eYrzQIFnaxMVSAYljApqeHcD1b+pQ0QHpQ8Tr0Zm3TZPWPAKXMkT8aRt6Dm70VVWMM5X8amDhupf4kxlrbL0xAJlPx9S1LNQf4hZDuSKzu2ed8At0Zf7/32aYITgtE2YKJeLj1JVx1dQl881pbuLb1/hFHBILyhPT0v77EJj+RUfLEY01q8GXsB+O26fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFhxL0BcLIXcgbtJhDL4flutWTz8qlOqf5C//Xmum5M=;
 b=evEUlspzjCUQB6riBVywtZLt8RiHdfhUlSHDvY0hm/onyqTfudvMmeR8UGZTBIm03lzd0f2bvLOIUBBKdx9V0nl68K3zx7ptBwhbc7RXRVfjFqKL0wiB7lS8gZblp4CeBZalW30KFauEZdFa+STlcJpvfAcver+qdXeWVJyqu+Liy+EKYsV4V86CTC8nrZQAEL67cVjYZ25PjaJedB4qRX/v+n57oDgMi9sYB9vXUxubZyXdqet4p4Uu4rX+/JMrrDQAy3lJxks7Uw2YfBElG+QRaFYx8/hpNP1Ms9Y69xVFkAwkFfoYA/WYAXCQeJZMfuIvvgLDVkyAUf8UE3M9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:06 +0000
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
Subject: [PATCH 03/15] sched: Pass next class to sched_change_begin()
Date: Mon, 10 Aug 2026 17:13:49 +0200
Message-ID: <20260810151523.86994-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: a816803d-2784-497c-c367-08def6f24c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KcgbbKLop959mIWPILfeUGmEaughbAx+5LGazAdf5YCmhyuxVAnS6m9P7sV3NHwVoXpO2tFbNrsztxv8A3ARRky4EyJ3Eg7X4GtBtWsYn1UrqLwTBSUDbi0ECDG7Md5oT0Esz6Eb3QITv6JuMSjVRctk/904HvX56XGRBEd1WvzmzXiOHilX7sGn0tQlweAz+pKKDZ9nB1fN1euCDB3/NRvHtT8IGCejhY6UPN5dDOgDcdT97vw3oyo28Asztf9PUZTkCjFccfsL4c8BjkW27HQisyc4oixuK9FzvokPYCenujCQo13gq0NA98Z3/wzUd+iTeGNkgonolZrfflxN8LZHlX5blLAssW05Yj15oK/cYKEAwp2YyAoxQMCl6jmUYh2vZiJNb+ENRQkbVh1+ulQAXFZWkSooBBnjIyj/lxlRv2ta+JEYGnHbNxEBHdNXJLc2fv6cpyDeWP4CDJy9g4jMnzaEIEuEAJqVwv00657b+J/IEm90ymn8lvj/zql7ODsQicg99kqLgHNmvku+RMmgLqnoywR344YxdHHxPyiuoQNWP9w8nUSxgOYgYSLoo2cbPKK0xenyHTVptn2NIqn4DylyLWMIQ8QUxNUbsTdYU5IewGVZXNf8AGbgcrSqYXfHUrP66F4rkfi8sXpkh9WrMPWa3LlS2Z4B2U8upZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAB8/BXI8m9Mj0dZdQuupZ6rX06ex/fpXvt9eaNXkg1NZTPmcyuuIGHuA+oN?=
 =?us-ascii?Q?rYu5ZKSVPXtvUi5Kr+6YGmzqJ35udn8BjcQ/aP22yfGclqpr/f9D0shvj5Fq?=
 =?us-ascii?Q?QXZTN85pz2Lh5Dk9/ilgo8KterUneFI5UC0KRiyrzInpdB9iI31ieFceIiZt?=
 =?us-ascii?Q?E6CzSUPrPn3pIZK7rJR1/4Grn0WuefqjOCLZxKAuLXRybQMiT4k+AJT8b2sF?=
 =?us-ascii?Q?HY1dlYyTB27zaKQoLx3lKEFpphIG6cBFjrZu6Iuf2Tj2q8YofuchD3PuMIg5?=
 =?us-ascii?Q?hm0kzBBOlBl01w9ltfcZEQti9W+p0eYwPtlMBMQzRB7ky8b/S4tNThk2o/1M?=
 =?us-ascii?Q?DZIZqele4TDS/D1lOskyhqGzvbOPJBrxPeCbfzC87zbdSg+txleIKO12IFuj?=
 =?us-ascii?Q?+aqWEv61Gh4+2eiEgEz88Vg4WxAPPFALi1yJQu92f6TuV51UXUGGX+a5v/Ex?=
 =?us-ascii?Q?MJ09ORpgoYtSUOTk3WcEOn5unVgrRd2YuonkLlflMGu0L11SxznAtDq8EeE3?=
 =?us-ascii?Q?cuhWKT01nQ/MofzaUpzPwF50B4gYv8F/OZTub9fNGrHgP2WyW/T+mKAezLwk?=
 =?us-ascii?Q?vhmevu/Pc6CkijD7NlneeXOPNE/CT3CGgeI4CZNIx374OBGu/5WwhGBVBAlZ?=
 =?us-ascii?Q?4SfFSLF1q6/eYbpp/0SAqWKe+ldlHT8Z8kqbEEiIUSUcYfBiwnCLUPcmejva?=
 =?us-ascii?Q?1VD36th0UzcRXVM8YGh0RPjZ53hxcNyI96xZBDAUMK0Juf8NBuNEauxDQSla?=
 =?us-ascii?Q?qBcoBDX6FHvql9kRslOIGAYZWwaMeWvv49S9vD6u+4aMW/dTNxupRScbCnB6?=
 =?us-ascii?Q?3NGIRSHF3bH4m6fBRsA//nddm6Gi4Xw81xQ2t4fTNzPZ9als6D0S5KfU91f5?=
 =?us-ascii?Q?N671MjWwwt8c5BxyBUmI9YcHXMiZDT7/mpsUKnZlc99UjXFeLIHXdsTPih2m?=
 =?us-ascii?Q?A8hyMQ6ujA8l14/ayR62mEK+RDAJv//QCwScuT3zhVYvWz2zRvucNPCybr6y?=
 =?us-ascii?Q?WZPcUmEs/wP9hzHPb3cBFVHNoKoieDIF9Jyu9wF+XmLUlWh7ddbr9gL2vjSh?=
 =?us-ascii?Q?Fk2LvJpj7hHpaDIJU1w+wHa5VHvcsXna4quKnI/qXN0ylYzx4N099LZ00qQz?=
 =?us-ascii?Q?bnlE8bMePvaS5YPDLrR3TnWy7Zw0LHAAeJ/cF3RliSxqN+hW/OyoNwhi4o+e?=
 =?us-ascii?Q?ixFRxQsK2ISUED7fQcHjs2ZbYcRHVLhTwh/dLgnA4RO7AuLZxvAtYAgx6xxw?=
 =?us-ascii?Q?eC3GbtlD/oUcuFSt1JuGnZO7S3F9L0dw2M6Cs8fe+tCCw/g3hHa3Fd6tzi9U?=
 =?us-ascii?Q?sZhbHOGHdGg70o2vjEYyXGS9hQcM8dbf6goE8/wY7yy3juS6jJYkCDoWpJi/?=
 =?us-ascii?Q?BmVooJ7KtO72YYHjhQLt4n5rZgSzR6i9pouuyNcF0n/t0O2ukTiaVr97HIqh?=
 =?us-ascii?Q?dmZSj43py9bzfizqZvm87NB//lavP2Xc9++7HlXF5s1N4FjnX+JH/TyFbI3s?=
 =?us-ascii?Q?ItaVmU5YpYzWh6G4hiRCCtTaEJ7RsL1T/E8YzgxYkh0HDcs1kAnM8Z2ZIIQS?=
 =?us-ascii?Q?G7Pg+Qc8VWZzzHfcrUMiQu/V7/fs09ZEdbvbi7PXCLtfop5WcnkPgUFpy8ox?=
 =?us-ascii?Q?3W4LIBQxz7BB/o0AG9xUpU4doJaJPML7+WHlOkI0J/pLov+HWhhkdWpBoebR?=
 =?us-ascii?Q?PvMJJkkSyjixESSE3NIQl2jgbhYO3bQ5kMgEhchM7+fyFYV9CUbXRIjceQxi?=
 =?us-ascii?Q?2AtFmWuhZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a816803d-2784-497c-c367-08def6f24c15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:05.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UySE+uHqA5Qgsr+FPoQxlZwoI+hw/kxcNTXjnggtVd/jy2BgK8B/112E00PkIsnWGDvXXHl9VQuBAELgeZ2TGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

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
index 96b8b01d43101..e71fd07254d6e 100644
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
 
@@ -7687,7 +7687,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	scoped_guard (sched_change, p, queue_flag) {
+	scoped_guard (sched_change, p, next_class, queue_flag) {
 		/*
 		 * Boosting condition are:
 		 * 1. -rt task is running and holds mutex A
@@ -8364,7 +8364,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, p->sched_class, DEQUEUE_SAVE)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9481,7 +9481,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	scoped_guard (sched_change, tsk, queue_flags) {
+	scoped_guard (sched_change, tsk, tsk->sched_class, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
 			scx_cgroup_move_task(tsk);
@@ -11185,7 +11185,9 @@ static inline void sched_mm_cid_fork(struct task_struct *t) { }
 
 static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
 
-struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int flags)
+struct sched_change_ctx *
+sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
+		   unsigned int flags)
 {
 	struct sched_change_ctx *ctx = this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq = task_rq(p);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0bbe144c98111..17dab1543f012 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6069,7 +6069,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
-			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scoped_guard (sched_change, p, p->sched_class,
+				      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
 			}
 		}
@@ -6350,7 +6351,7 @@ static void scx_root_disable(struct scx_sched *sch)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			p->sched_class = new_class;
 		}
 
@@ -7716,7 +7717,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		scoped_guard (sched_change, p, queue_flags) {
+		scoped_guard (sched_change, p, new_class, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index b81254be1b04c..9e1f1afd389f1 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1253,7 +1253,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1283,7 +1284,8 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scoped_guard (sched_change, p, p->sched_class,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1937,7 +1939,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scoped_guard (sched_change, p, p->sched_class,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 63786712a1156..7779bcf7c6a12 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4220,13 +4220,16 @@ struct sched_change_ctx {
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

