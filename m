Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAF4A1380
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089637; cv=fail; b=jozjfJcqnA7xUzsckbv8ks+vB+f1NJGAaxyunXNNTjia2THlmJBzL3LkZgLhL63jV7bMQKdC0be2vmZ4cUGHbRW8OJxT6dQdrMHq8aoSC1LhjtFA8vKFomi0WP0ZvKpy00PeH6VCmO7jYFhV8+iwlVgJufmG7qdhMCrZwhMNbkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089637; c=relaxed/simple;
	bh=pEvxWtns1T+r8XBJQSMqOcSCTxuINrVF/vQ+gyfHfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5Z0/eho5MDS/ynj3Kls7Tq47eqoxT64dyMYB3NXXnw86FoBiUIdmmI+puq64qzRSZuycEA1cGWleNp6CZx+UOkhSIfxvrgZFYRJtShB8UBtaC0p1XmPTcwXfr/auAloHjQ6wHlRhU1sIB+ZEZPTNo3+R1Xj6CtWageriZkM1P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzC+EGNu; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzC+EGNu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDKHecbw9+VjmK2ywB+XQl7mpWTBfa6fTmSig6G+GjLhDYiaDJ/6uBRnGD820RT0F41laeytGchMcgpVz9ugI2gdrvGrIr2JV7qUneSzr1Rden9dVzmLsVfS0zMcHVnmOCbaO61486/aBktBnpXaThgcQ8edOczwcwtc5licZEB7GKqEC8L7rOucQLnaRdbMWI/QW63/msvHWVz3Jb+eFlMBWB7Fr9RRIO16z3byVpvskwuh/h8W3FvqbBnt7WzbEtWy2ao1tIaPdlibfD9OGyjBwh6zUTelyuVQgv6wIJgNqrUzJdHwKzVMq5RyLPNgHakdWxUwQHZBEsvXim/bZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiTwQ7f9Ov6BL02RKzPMPGHTKdrXFmM3I/SXph9PCyI=;
 b=c/tj/Sceo0qwNjqM1dxF9br1IrWUGeohEg+vt5MgLZvXrbUkU95gkBRsEVozOlT7yBYm4jsokLwKghRy4ewHPEM57hvrhGX1vULiYAl6moeXiXO1wu7Tc/sZNuPkguKZuhqABcywzW0IZ36RS2iSrpwediw8acnYMs5FbTN/6y58fIbTYRu+jrGYNzoHxlu7fqJwUvJDplb5GGNU4nlU+56sgSF6ak2e8B1DHR1ogTtwzja0gM7h6tsnRxhhEgzSErBDgdklkHsxfny+jtn0Du8rXmED2rCAsClhPmNxIuFqGy9h6UbJVVjfbLgXsRJzFDNVjj8Uv3ZaKJH8im4JSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiTwQ7f9Ov6BL02RKzPMPGHTKdrXFmM3I/SXph9PCyI=;
 b=NzC+EGNudQml9x1GpctILw5o/a01ZPiAtr1nt38KDQ6JA+xxMl57nRVXZwRZ+uPslQrWqWQOZ+O5Y4G0QH8DBIcFnAhUadplEj5y+e6cEkGnoIQky0zs5gf4yggdrgrdFrQpDvRJlV5WiTeMndH59ju9Oboc2KDhWTjbjtBkfVnEERa6M1cIpnwWhO9ewhJbGEb0PaY3/qMQB/vny5Jlxzt5QadL+nJNIaerTAr0obfIkzLkxGbQH4Xhi8GZeDmiMjRoLhq7qbJygE0c+9J9z5iL7Vac4F9+6tBa+k65wpeqDMNmAb60Ky0dUO27xo6M3vcS7RY6751+xhS+4yjcCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:02 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] sched/ext: Split curr|donor references properly
Date: Wed,  6 May 2026 19:45:43 +0200
Message-ID: <20260506174639.535232-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e7380f-3fb5-47cd-a22f-08deab977a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XsqaVQSXhIfUJxSH7gFEt09CQcx2/2gnz8Wa10V1CZxjTdiS3rW2b859hgW7V3NNdkPHkWJi6lmn0d8KHKNUgIslIDCGiHg4c8n5ZVkTDTkjDvnpOfKLNtCu+uZy0pntLmmupuCF5B1PRyD40d0JNKYVlUdoVKOg/kfLaLKTozuqOZ3/z1s7nNI0AsEEfhnpmCR5RJ5qQLPM3i0lzVMtMQ2qWk98w8E869qw1TepvF6gzsHXWqTQ6HjzcYL0Oh/PykWBbbP8DwFoM4JqLr3C1xoFs5T2X0M71gWLaSOiBnqJ1ry+EjCp7W6QabYotf4tBdr2/O0PB7NzVULYH97jXF8cpV4lLMgo5eKibWRqZZqz0nyJQADE/I/Mtt7lPxiduG1w8PPxSnEY7NaiklzvSnzxoto5zpYTfIZhEN6eszXWNSO5fGE8Tc1zOaZ1T0+2wRig2PtTM8cAFqgNHPn/Ax9OdPI+VVNbGeh0kGoCbcew9Jf6UGxv2btpmNWRvNmoSY+EZtwROwLos56Ov0oAawub0TORbFvlSOP2gODPpD1gqVfjhCpBK9H9AI9qK2mRIxMdV5/vyIGfLBQ7RKr6/ZFXqM/oJJaJrYBVIyYKBeeR1uWGfgO6PFLvzaF+7rNHntlIJAcSkEF7gSZCLPiurBkupQCzcbz3eAceanJ2K3d46JnudT/5u2968OSNso4D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gMbBJM0Zkm+1lZ+FgN7KtKkwo2yaAuTcuWpMGCH6x75TqUkhwlaNdjQMg7J?=
 =?us-ascii?Q?adT0QqaToRWfjG5XU3V3Ql8R+yDiCbl07l1DZ+xO7oedJLeYNDRH6+O0CA+i?=
 =?us-ascii?Q?WwR8+bL864wyBvuR/t/rHGYjsuFXKss8DjKnWD0MChAVLuhBU354Z7ljJ+h7?=
 =?us-ascii?Q?krwZyi9PZ3UGsZth6WzCVafL4ZzdtnaddFGgDqr43EP7FnUKz6tt+iGM7ebA?=
 =?us-ascii?Q?64wUTmwa3tcwXnIHDZOihyxgKMGMf3tgMG2kDF6sOar3Qe6rtfJ6cznNjsJx?=
 =?us-ascii?Q?ToXswqNPFCblUtDx9tYk+1o0CNOaV+3Y2OKEa2Rp8Qn1yxu8TXNd01P4EgBO?=
 =?us-ascii?Q?zv1Abo2yOg9dYFJ3dxiLSO+taSLza0EB64W6EVfiWJDWKZwOczHKGySAfqZB?=
 =?us-ascii?Q?ns525To386c0DpZ9pU+IZNor7nRQyDzKfAScBZLuDE/d5AXcH0dceS9JnktL?=
 =?us-ascii?Q?NdGDJdZRT0YN1N0c0v8idEMwlK4HkhadEY1rSdofYQYLrA8e/ZKaW3pSo5uh?=
 =?us-ascii?Q?grKB5TACb1yyWzzTvwIJPRA0q/lcnD027WXk1ZZ9CbcvfVb/wQjfsaqK+1cM?=
 =?us-ascii?Q?zJfQIe2kMswsKgv4gV77OvC9f+xiT/+AgCIbmgofQjbs0x9zJGfX9O8T+OHR?=
 =?us-ascii?Q?K1IpifVyDzD3x9TO9dXMmYmgjN71CAastIdwsOs1VEnPoxbIRgH5l4eDLIhQ?=
 =?us-ascii?Q?RGNkS3zRJdtrcIsC65IcyKyI5zY1uiTC5IiQ8khMk1W4kz7jVIy3cUuEByxf?=
 =?us-ascii?Q?jPLd2zKmV27brvI1DkJJeieh7POp9zFE8EtU979nLRPmKn0Oxztx4XUMwY4t?=
 =?us-ascii?Q?FkIyQbaS5vQcZ1+gUQDNjOOcnJphqQ51rfGENx/75v0+XdwtQumD+w12bTdc?=
 =?us-ascii?Q?RjbDh34y9wsptfuSlqKiFlry55/WJUx1LpYnc30HluZCoMs4kGW5XXAGtujr?=
 =?us-ascii?Q?Xcx3BRRo5qFr1uRl2ZtKn/QNFsOk78OwvUC1N/qeQMzv9lg22WxjEdheODtf?=
 =?us-ascii?Q?+iigmJrkE002MVYMIrhxPa9yFR1liHGH3PxVd+AzZT9e8vJqYeYIAJqxEo8K?=
 =?us-ascii?Q?bsp4B85w6J20zbYcnjiWVKWtkSnhFtIK949OSe0IXILbxA2Fha9S5q+N5ADK?=
 =?us-ascii?Q?y4802sMzV5prdCIVksNtjilA7FhzWDKP1j8nHyW/xFgn6HQu5AROKbVd9GKE?=
 =?us-ascii?Q?gSGAKhB2bqi2OJGSpOpGM0m4v21OvithdnseOeZuidnfIpf8db9Z99K392HL?=
 =?us-ascii?Q?sa7lqS71FuBLF+5VKj5HeixyyDtSKLZER7CEZ0+wJBw6PuR21llkRM6Dddh4?=
 =?us-ascii?Q?lnONAh3tiXTdIo7+1M5k7vxToaGBF8JPa1xHGdYUP0qHG+upTdfr3wULzRG6?=
 =?us-ascii?Q?ugdCK2iIvZ6F34lQkHtttimzC6VM/sxwLnA5oxrlzmiErtqApwI3VchcgP8k?=
 =?us-ascii?Q?uEa8anxgLv9bFCzBhyjq7/5h3x7a1ed8ReQiBeM4CledmScLiHuH1sTvZ0Jh?=
 =?us-ascii?Q?taumqDWV8Ev7TN9AOWbv/2ebuv7MdapAnIHbCtVGPbXWyCPG4djpJjXn4tWS?=
 =?us-ascii?Q?YaFTwrAV32sLoK9BjyeX/tH2k6m8vDJVaQfa3EHkjGo8LjfB73Bgm7I9vGSE?=
 =?us-ascii?Q?X6pXLuBBxgNmGp066Bxej8YM/LpWhhBbJGGvWeRRCBtKFJu28PU9n+I9KVSm?=
 =?us-ascii?Q?nUXKkSItV+g5ZI3isfSpT2BZzRgHEkHPElAPu0xp/hEoBttL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e7380f-3fb5-47cd-a22f-08deab977a7c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:01.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+y3nA1q7kgrMUn//qEVwGo+yUDlYxHrmbvAT4k4uh/lAjRWQG4ZE2yjLgiMKU5z1DR5rshLpWtX11sBzDfgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

From: John Stultz <jstultz@google.com>

With proxy-exec, we want to do the accounting against the donor most of
the time. Without proxy-exec, there should be no difference as the
rq->donor and rq->curr are the same.

So rework the logic to reference the rq->donor where appropriate.

Also add donor info to scx_dump_state().

Since CONFIG_SCHED_PROXY_EXEC currently depends on
!CONFIG_SCHED_CLASS_EXT, this should have no effect (other than the
extra donor output in scx_dump_state), but this is one step needed to
eventually remove that constraint for proxy-exec.

Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/ext.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7ac7d10a41bef..c410afd28fb6d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1370,17 +1370,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 
 static void update_curr_scx(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 	s64 delta_exec;
 
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF) {
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
-		if (!curr->scx.slice)
-			touch_core_sched(rq, curr);
+	if (donor->scx.slice != SCX_SLICE_INF) {
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
+		if (!donor->scx.slice)
+			touch_core_sched(rq, donor);
 	}
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1504,13 +1504,14 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		rq->donor->scx.slice = 0;
 		preempt = true;
 	}
 
-	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
+	if (preempt || sched_class_above(&ext_sched_class,
+					 rq->donor->sched_class))
 		resched_curr(rq);
 }
 
@@ -2634,7 +2635,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (sched_class_above(p->sched_class, dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3150,7 +3151,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -4323,7 +4324,7 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->sched_class != &ext_sched_class)
@@ -6355,6 +6356,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(rq->scx.cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(rq->scx.cpus_to_kick));
@@ -7974,7 +7978,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -7986,7 +7990,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				rq->donor->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
-- 
2.54.0

