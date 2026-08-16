Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041239794B
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901907; cv=fail; b=t7DgnOQt+fb8JsfUpfei/qeTQM6Ylydqzyp6vWm8Dn7i8Eru/rRoE4wdLpbjan6Qn3t2CT9jxOIV7pZbJaCINj/AiYYoFZmtynk+QDiaU9Yud7/r1JerYZmKUvaowp9kQP1yxOzrUwhNovbW1Mb7dWfxs905Ee39mKsu9oBrad0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901907; c=relaxed/simple;
	bh=layu4U93u/8uhxmIpJnh/nV9/Ei7ZnIBGOG7t7K68rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VV5Iuwrb++IkdLjBdiXrFeIgM4K2Bo7WZuiXfhUky5exzkw51RzqO/UtXAw0pDALpMgrRQRzLeciZkf6OXbYSanRalTqZoScEyM10xRQoXswzgANoFKo37e8SGOC7/Ii5Ko5ytKAyHhNmYWS8vYZHnKAmgInKwymgrnS1a2Vfcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdCuDLyW; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdCuDLyW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCAthSvVQdEU/2zK1Qwbn/UHXHYZd5Hv1MEHnZfDZL8ltI/rCfwXm4xYGZjgdWydlFtDpOp7CxUmNApuXMzi3OOe37AOhgO1NDJW7SYp490xuul7cVw6jwOc1YTV4XmMmzQXET3+W+TwuAKJ/aBgNsPmSvO2gxtp9KkyqyrEO5w8Ks3UOpgNiEgtkBmDJUDJpTFPVEsc8KxloGHieXW3RTpTbSy0vev/SHZ+vFn52nRDqbm8+UAQE1kfz2EVpNrI/Ize0wnZ2iTH/Om6aTMj+WyrSWbZzb3CEcAW3m+T93aTKMc+0HdAyTUe+tYg9MVIFZusBrJMmPkROZTQXv0pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pI1nXQsnUlAX1TylRM6y2rFvFW3EMht0TNZmEd6JaA=;
 b=RnD7Gjt5FMdixxYfgIlsAnxEIyvY6IV7j05POJQwK902i+kt8LHWonVvIOUIlIVaJiyHFbl/rRk67q670pr+yvDfLdoHJOD+blH1P4lxd/UiEYTlTkOZ624epxhm/+cLPUj05Ms24E3xaOSlAqYHytzjfzc90j3F/5u/Xy7ePa4e+cGgFWNBYKr+fSOxFAh5gMozmK30sz0wGYxelpk0fttTMWid7jxxJuCTOFakjq2kUCwGGiRz4PIriK47TrrDuZsYn04A1JCyQqZ99oZ9JDMQLE8u4/eSAVe7ChrNzUwuICkIbdK2I72rvgO2Rg7gJrq+dx5CCdnglFUXLizxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pI1nXQsnUlAX1TylRM6y2rFvFW3EMht0TNZmEd6JaA=;
 b=QdCuDLyW3Knw502o5CO0MZp65m6rPkusKhTGZBLl8XrJir9q+qTBexsN6jrttI18C4ziPmS/prUYI8A7hwuNIgp8lT5ttTI3MlPfvWPiYLSmGtf+UmjVirwyEQQZP2Fz5C+cAdnal+GXqBFaTF2Ewss/v8sgZk68PXZ/l+rsWVLGKaTBPOSmuelsgiqEyYeiUXuQfobHtXJub0xAXjDTaqHs7bhxmLyL8/A/xPgBF48k+LYRLP2PrInMyxTRIZePchzINbPfUOYyBAQYwrLEVJ8OJfNrigphoZmbw9rZU8lirFcK8NuxCO4SQF8Y6unu1dX+wYKTiSzo+mkVZMh7Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:21 +0000
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
Subject: [PATCH 11/17] sched_ext: Generalize the reject DSQ reenqueue path
Date: Sun, 16 Aug 2026 19:35:09 +0200
Message-ID: <20260816173732.17162-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: fa69843b-bcfe-4b87-e3be-08defbbd2a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	n9NT0r2gb+omSBfpH1/2lLJOrEEqOrkOubjQvNX3ngdsmy5zF3acDTalGfejd4NI+8vjmhx2b0+YX+zoSL5w1/ZLDiJGZs7SF0zK+T6XaFaWbDCJRoLGjG2yZObv90BNuxtFnNxSFz3Fh85EkXj23sweE26hC9L0/iwi6U0d/SccnfTSOjh3RT3HEcZMS3LNN2MmGkM+wu9ftc7zy2frtEa5D0fhT2RrmmmZ7LR0vrhLhAnhaBn1IJS5zSkCPHarGJBuV44agmWIs1ibMk9THdyTsDJ11j/3W6yww79KOC4/ucNGYSn3+LYd6sUQng77d2MmZvt4JLeB1TfeC6Xn2zIYJRnb9sPr9cdjKnCWLzpFIz0AW//yWHz9XaOWKYIp1yhAawuW2W2BMiDL2Zf1Rejkf6amGurJiEQhrz+V0FvjpoEvd+8nwtt/6byUgdV4Q50mDkflrMxk6ggY9BjQPXNNUqjzdv+Vb9SGNZGUqYGrh1P7eeaoC7zYj8jO3zKlgqZN51Kp/4BK514W3+V0gOjahjMU0dqs6vi0J8YO6pwhRa7CyzjV5hAG8RP6j29fZNz8aA9CV2uGaKe9ur+nKsxjgYnJ0Vo5go9TinX3OOdk0HTP/VoSlNtPlGGm3cSdxtfXuC8VSvRKC5J6lWcWveNEhDG5wF8tk36McNNwb6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V8hue0fMdF1BO++FkKpkY51yypzxcDAo3cJUxEB6TVQdopfF0iVuloWJ/FxB?=
 =?us-ascii?Q?k7Rst74Ic+wZXNjnnwJ9nkp+PCf3Hz1PUYDSBXfJMC+LWUrspjPYqpR43uIQ?=
 =?us-ascii?Q?BdHgiLocmzEeFefDdGWIiuz7WHj0blxG3+iGL0oOUamjiNh40mvFQUnliwhv?=
 =?us-ascii?Q?BAkBEmSkf3dR3CXlbQ6rnLDkmah1ZVyPe7rTKlq5lLeRKINOFshtgG/R1XW0?=
 =?us-ascii?Q?LBJhWf1klmECkaLKYw+MySkBkWe7BNVvkqfz6+eY7/fBevVJVadWyR+xcBnn?=
 =?us-ascii?Q?PYixjrcmr4y5xO4eMLBz48TuFRQ5gYFnIGQipfUSB6Ws+W8ail9bSkQ7oK4Y?=
 =?us-ascii?Q?LrcAvUf81bEo146vnCT8fV9wMhSxoCVIeTRzZcYPodC8xUBayTpiU7HV6+1O?=
 =?us-ascii?Q?aO5fbMOcx/Xi6RigvBr/PyCl3SXwxTC5rhR68nNKmiz5U0NYDyiBbRMjwgdu?=
 =?us-ascii?Q?F64HzfaYORyxFkzz8NY5RjCY7P8I9qzSaCo7L/7jf3gD0ca24P2l1MhLjNQ8?=
 =?us-ascii?Q?M9dSdcD7kAneMA9nx7taO/nRcPMmSD0OurjIHvuWi+TWoJ8a0/hC9RWNadIs?=
 =?us-ascii?Q?+UCsJFPMKujp8rSrhR2zmqXfufoJq/5P0CqfwP2aaQ2BXu/pBOiFUzF7rmEO?=
 =?us-ascii?Q?o9YjF1I1sucv0J+C9t3XCDa32y5zC4G13AfjkxDs3vIzv3HArCJcHPgn/VvW?=
 =?us-ascii?Q?hcfoRBPUhEo9ssIBhdpv2++dDY8U9mn9aGxvAjCF6Cwy3c2vULoYUy6juTaX?=
 =?us-ascii?Q?ky6KmVtor74nf4UY9g8WRcQqXqB4P2CyQnr0uZWx3lhQHBteoTP844NZLbZj?=
 =?us-ascii?Q?Y2utE4M2hrcA8iMoS6ZGr7KCXNVzcr2N3gKlPlhw/Od6TPrIBJMK7yac15GB?=
 =?us-ascii?Q?qn6Mq42kB7/XGLdpJiwNi3EiBiy7S+jn+t3WSjqQeIxN02WwHLe0tB7LvAqN?=
 =?us-ascii?Q?InTZ4XDWlAIAA4QPxiZO2mvDtiId5rjNtS1raYCuAyWBA5aoigbXvRmEmykJ?=
 =?us-ascii?Q?fbwARDrQWWPj2NKX1dHRA0wuhz8byP+AVUNyOIkJzXSocb1FgR5yM6Nle4sx?=
 =?us-ascii?Q?ATrB/8On2tkLdDv6iBOAYC5fjYl81ijhB6rrkqf5Uo1CK3uyzKKizo09PCOz?=
 =?us-ascii?Q?opVkS0AuCXvcMLivLh4UQ6tySba75R43kYCVs+BaaaMUmZTXgyDUHDQ5FeRS?=
 =?us-ascii?Q?JUZBQd4N1LMYVDhgAv+cTy75uaqXRcv0s3HaP9zTYkbLj3Xj0/qzPbt9UL6M?=
 =?us-ascii?Q?aX0eYAG9lLiDG839453ao6apdMtoBXMAL6B/5EZ+c7tzhhikOvCj15IoI5g4?=
 =?us-ascii?Q?Z+fuG7i1sMNIXT6zVYkqH+RZBHn17Gb19xpDbPhkATOCXzpwyldIrwnsFrJ0?=
 =?us-ascii?Q?at3u6+jft/a9Hqy27YY9cgZu7fc5K0QIeZ+eOU0umEniKb1VHfsD4C4wQ4Wc?=
 =?us-ascii?Q?oZ/ocvc+M2vnCLhfnNhh7aj5Uxcd7hbzf8ign3NJJZRVcreAtpAo0VZTrtk8?=
 =?us-ascii?Q?Qowf+cZsep3IlQ8JkaRXH4M+bXE4io9DTCdBcczUARnjPXyxIecgckNMozVq?=
 =?us-ascii?Q?YgZAc8qdHTu0pZmPzP/uv8FEoqOECHeOY1fkLsxxpXlw1G99bsk3xyV37q9m?=
 =?us-ascii?Q?Ft8REN0tGqmuiiupkJ+6x7PraAT/x3KzYFDBLeEhj4sCw9f2vFO96YCDbosB?=
 =?us-ascii?Q?w8ZPCXq7NUVZdOJ0fLSD1xDNcrjW/mQ/fzTETh5+h35DeifHvd6z1ZswAliy?=
 =?us-ascii?Q?Nzt0unLkSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa69843b-bcfe-4b87-e3be-08defbbd2a6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:21.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HKujpb5o9GHXNqw0xFZBp4V6JL8tRTTNA5NdLkMFHz5MtDpz3XvYNJH+xhxpLmeMAP0c3uqEn3I1olX+b8N8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

The reject DSQ is currently specific to sub-scheduler cap failures. Its
storage and initialization depend on CONFIG_EXT_SUB_SCHED, and the drain
path assumes every rejected task was rejected for SCX_TASK_REENQ_CAP.

Other transient placement failures need the same ability to park a task
on its source rq and return it to the owning BPF scheduler. Make the
reject DSQ unconditional and carry the reenqueue reason directly in
p->scx.flags from the rejection site.

A reenqueue reason remains valid while ops.enqueue() runs. If the
resulting placement is rejected again, the rejection path replaces the
carried reason and the new reason remains attached to the task on the
reject DSQ. Clear the reason only when the task was not rejected again.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 57 ++++++++++++++++++++++++------------------
 kernel/sched/ext/sub.c |  4 +++
 kernel/sched/sched.h   |  2 +-
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0cb9ce0f8d4ed..59261218ba37b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1598,11 +1598,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = false;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
-		is_rq_owned = true;
 	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
@@ -1807,6 +1806,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
+	if (dsq->id == SCX_DSQ_REJECT)
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
 	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
@@ -2105,6 +2107,17 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
 }
 
+/*
+ * Clear the reason consumed by ops.enqueue() unless the resulting placement
+ * produced a fresh rejection. A rejected task must retain its new reason
+ * while it remains parked on @rq's reject DSQ.
+ */
+static void scx_finish_reenqueue(struct rq *rq, struct task_struct *p)
+{
+	if (p->scx.dsq != &rq->scx.reject_dsq)
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+}
+
 static bool task_runnable(const struct task_struct *p)
 {
 	return !list_empty(&p->scx.runnable_node);
@@ -3202,7 +3215,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			if (p->scx.flags & SCX_TASK_IMMED) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-				p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+				scx_finish_reenqueue(rq, p);
 			} else {
 				u64 enq_flags = 0;
 
@@ -4487,7 +4500,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		scx_finish_reenqueue(rq, p);
 		nr_enqueued++;
 	}
 
@@ -4605,7 +4618,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 
 		scx_do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		scx_finish_reenqueue(task_rq, p);
 
 		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
 			scx_rq_lock_drop(locked_rq);
@@ -4668,14 +4681,14 @@ static void process_deferred_reenq_users(struct rq *rq)
 	}
 }
 
-#ifdef CONFIG_EXT_SUB_SCHED
 /*
- * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
- * from p->scx.reenq_reason_*.
+ * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
+ * scheduler chooses placement again.
  *
- * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
- * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
- * Rejection can't happen for root.
+ * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
+ * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
+ * scheduler. The private list below prevents a task from being revisited in
+ * the same round.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
@@ -4684,23 +4697,22 @@ static void scx_reenq_reject(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list))
 		return;
 
 	/*
-	 * Move to a private list so a task re-rejected by the
+	 * Move tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
 		/* migration_pending tasks should have bypassed to local DSQ */
-		if (WARN_ON_ONCE(p->migration_pending))
-			continue;
+		WARN_ON_ONCE(p->migration_pending);
+		WARN_ON_ONCE(!reason);
 
 		scx_dispatch_dequeue(rq, p);
-
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-		p->scx.flags |= SCX_TASK_REENQ_CAP;
+		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
@@ -4710,12 +4722,9 @@ static void scx_reenq_reject(struct rq *rq)
 
 		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		scx_finish_reenqueue(rq, p);
 	}
 }
-#else
-static void scx_reenq_reject(struct rq *rq) {}
-#endif
 
 static void run_deferred(struct rq *rq)
 {
@@ -8775,8 +8784,8 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(scx_init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(scx_init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+#ifdef CONFIG_EXT_SUB_SCHED
 		scx_rescue_init(rq);
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index dcb3f8fd1951c..26e0acc65618c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -752,6 +752,10 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
+	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
+		     !(*enq_flags & SCX_ENQ_REENQ));
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+	p->scx.flags |= SCX_TASK_REENQ_CAP;
 
 	return &rq->scx.reject_dsq;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6357c2d6a1e9..2e7a82eed59a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -807,8 +807,8 @@ struct scx_rq_rescue {
 
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+	struct scx_dispatch_q	reject_dsq;		/* staging for rejected tasks */
 #ifdef CONFIG_EXT_SUB_SCHED
-	struct scx_dispatch_q	reject_dsq;		/* staging for cap-rejected tasks */
 	struct scx_rq_rescue	rescue;
 #endif
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
-- 
2.55.0

