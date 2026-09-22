Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B217576EDE
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096161; cv=fail; b=CRXbR45I3hY6KkW25hCqTe7325WXi5ZahXo/RKElkfZ2Wp/iBXArhYZ3aZR4HyOnQJMiNWZYC0EtSlhsGLF58FbsheZ0CXL0PxCCONuX3mSl/v/V2wywBsh3PnVLOV8ony1/BQrQ8Im69Ytn7CVxLWJzYOhBD7TRrKTu9Wr8n6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096161; c=relaxed/simple;
	bh=cG0K5iCAe2V1AosCG48iwKKRoec6VBamVEpRKDqfRUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqRwLnrPS5uNn2kicZXdSaVcjlkDLXPJGgLY2nftba5rHtru9YSV3rPSi1bmHCFIou0/n9eyxW8qmQqdRPnhhhONvhVii+KKUPvV+pLlCeI7vMJX9+1Zq6VxJPsCi/C/UVHOE9u4UkBVWu79lG/3CvmLXMvve5E/AkYKPF7+b9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Exul9rr8; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Exul9rr8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHVtWIBJ+ojkAFoJspedAMyCFM89cd7p3iN9AKscOLUJfl9D8DxyJizprQU5HerFe2AEfcgKs2m5ZE+b/y3wdv0aPaC/LoRlQG7qhQZ6TDGM13ZuSjd49Ft2SlN9Tl+VAGx9q0g9xkRZRYI1ZywMOeekimgAApyntx0So72rziRP0Iqjv8VUAPIZmmTqi/FPx549iTR9/QzEUoX/R5PMVyhOYsRLEiT/EFXCDH+4igrpYpDcVpUYD57Nx74kmEt/JdYCX1mjG0drLxaHAXj37E4nKZDAHQlss3rlb2J6+UUWvPoLAEVWphgThkOPlNrTl497ssuApSp5VPkpT7CoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm33fZ6yZxiWRV9le6clNfRo9R2oRzaqLgqekLMhnvk=;
 b=U4dyz6cqc2YA3/TDTOYASFIPMTnJLnZO+BolrPCARd0TSN0pyBeG4fBg0J0EcvL1apDiuz+nPUAR3Xm61n7oPhq9IMcWk2H1EXjuTfoIop2kVWuym/gY9FBtq6tJH2Ncb3nX8gP7r6ZzguX+Y6VZ3rIvGRl2SHAVXpWEGQ1QQrtV+iUdvUELIH2EZcURTnURyk/qHul1afcmNSPTupEgk7+fL8ECKaL/LJMa/3hXO8Cev3SdTfCDFKragMFfioN8cnWKGp/aeaqMDAnm26fA6g8577EtSYjG1/2Y2GiT7mMzu2xGZyUyzSD+8Jn7b7J2G2ONJ0E+5b5IUbbKda+RBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm33fZ6yZxiWRV9le6clNfRo9R2oRzaqLgqekLMhnvk=;
 b=Exul9rr8cVck6cPVfu5PVq67C9KjqdeZiXIEkciQN3uv6fDSxUeOreJUM/II2AQttJoQyHwRh6Ald4Ya282nbjudCNn8K1oLCkYCRjbJ7pr9BM7bGPoK/42YOpNphWWhc6AeyLvOsId5P3s3sse86cVisuTZUAtVo2WQyt0iWLEsI31LeJiXji1QNipFDuZKVH7Qos9EduWIrxF3/GnsMJCr/1zV23Bolv4LEihMPj1XJ9gi/eZdjEW4rxRI/L01JjieNr5e6VzA2+jJutUHPIBPBJhk3mQTKEkaiPQfkGx3BF8DL1/4tAXDRz5/Z9FdBLF4cBup+kX048cfX9Lznw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:53 +0000
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
Subject: [PATCH 15/16] sched_ext: scx_qmap: Add proxy execution support
Date: Tue, 22 Sep 2026 18:51:54 +0200
Message-ID: <20260922165445.943315-16-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::32) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3c7eab-ffd6-4b3b-82ad-08df18ca5cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3nesh280g60mHAiz5iV89BoY7n0++Xy3X3LsfeyJCk1JX4Lk6/09yztDVkT6Rd8WE2jivg+WawBCETmquzne+EOn+6C0/6mSXpqf4Oqi2hcZsJw3K3LS4Z+BFMbfUOQOIDpTFU4yDhEfbYhogEn7uIjwabnjYDsPW6lrbdZtlFS4kGrqaAq4gf3lMnoWhmFW+8f7DhcZzNlCsUHJflsUDWodTDWRusJ4N08RHU8/MbGAKA8sBpIbm1/2jf7jEG9/4jv61pyO3kRHs45RV8cKE5SVsufHfNdNUt7CgOMWV8lGnf2+p9F9+AcWsRVELFx+BnrAeiWj0GBkm/CRz9ZkO/lsliUDIvQsvmOZybtO18gRHUTX6EcYcfMRplhnHiQ3/wt36M0/7t9I0uYANYHJVt+2Jzwc8KB1wJ0mJd6g/RkwOseUNqlYRj+eGBoQ6sVKnWG8KwQV7DJV/wVTCVSugkim/ukeeDMhvSWwFrFkzVPugieKIqQSmh6hzVzZRTsmxkwXAOXa5n1yV3IDGEfrGRevCcpzbrQVNBJNS/YhUW7HuqEZMk4x2/J3ANGYmLdEzUvRZx7c7Kd6YjDjH98yFOWIb2GYQy9LVrg5FqJQLbQXppDWJfLZ5pdHl6LC67WMKiBF0rDkbqGXBrgVX5eozWjDQDr7fZZoXPYx7kN/EN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dirMb6/hQxlRZ7hns+Q433UmNoicvHLVBc5SQ9ozReNI/5h/gut4Ld/CJV+c?=
 =?us-ascii?Q?O35A/vxdKxY5tXLngaeaoKHZONhJxLeBn00O9WdoNqqk863vBMieU9hIQIms?=
 =?us-ascii?Q?0VI1AlpY9g7lLP/wurU3NE2aqwtUVGPeK9qtzG6mQ7GfjNVVtjfjHzsPuwYJ?=
 =?us-ascii?Q?m8sZr3ZktRJBSBFyMGREtYVbzjLA5nb7Bmt7Qk6wPieu5rxl9o2Jfg7j5q0z?=
 =?us-ascii?Q?IJ1H7ZJGhXq7y41IBj6qWeY+78gsL+QO5VE0Mbe3HtRTSvfK06N0peLz9Bc5?=
 =?us-ascii?Q?2uw7MZH6J/P+OWQMWsSd+4WHLL5x1GxDrVKLn+5L8WylP24Rz33ev3APiueh?=
 =?us-ascii?Q?+OVhR76sKhZ+T1700mZuvdv6BELdaiTvo4N0b5o+a4s6tjLRPCyYgFIp1k6t?=
 =?us-ascii?Q?izTGIboAeTgQ3lzQd0NaInHz+j7115YovSDT+bkkMJKoyXh0NZ5TxBzzN/yl?=
 =?us-ascii?Q?2mrUnIFH+mnrkjtb8Bfsd8SVoP6oW8WYKHoxHFQNUWzrn5ru/PENrHihvtFa?=
 =?us-ascii?Q?fCFQN/3zE+q+9fymQMcs7F9dUHAxbV+kKg7hpSFX3CHyUkgHg06KfHlrSpc6?=
 =?us-ascii?Q?RxfmeRIHiQnBwiThbJIZV/0s+cHvjPdSVPwNwnx+6dCwB0jaFi6SaIgjdMC9?=
 =?us-ascii?Q?Fw8wNV/b8QvN0w9iXe/GnjPdtcMk6EEbMawIq2yLA19ZgMJOecMB2yG6fnR/?=
 =?us-ascii?Q?VU6I86mICJROX9BWR80GZnycgczuw1NL5CEnlqDynvIbIIbomNlQWCQuVFSE?=
 =?us-ascii?Q?lLAtm3i4O4RMYfObgRMyI2vyVVYPHUwM4PofbllNxOsJzv/nQiNkQqcGRiIs?=
 =?us-ascii?Q?/Y/UHYlw1l2BF28XZLEI58x8bL6Ej8PSDLbw+dqv5Zw7Eej6g4nJnbt1jq2O?=
 =?us-ascii?Q?MmFGXlihW61d/OdV1Bh8rW2qKGD/16W9llxA0RQJE4ynyRWYxaO1/3VG4wVZ?=
 =?us-ascii?Q?Djp9wuFjfo+HwG8Q9/535W5kh/KxQb31pB7VY8apxK5G92lT/oO1A2fSXDSu?=
 =?us-ascii?Q?SOGVkAKWz3Qr2NRyd2e1WDOlYEZGdorD/2XeZU6hJ1tFoq8vx+7rBkmQRLSd?=
 =?us-ascii?Q?pht/vCNkFoW8yefcKN12S/gIUSuYqLVkuCEHDFYRtKlW7pHcVV48E4uRpC6d?=
 =?us-ascii?Q?idoAtt6z+FTZLIOP3qtEAOB5n+WpbSsAIGsox6LigVzguenH74DPjcFE6RZp?=
 =?us-ascii?Q?WhxkGXQelZYyDTW/qbHLSkjen6nIEOQ2Z1cfDguLf4zpzAQkgK/6zDYFQXEO?=
 =?us-ascii?Q?tdNVaGBi/ODF/i9/+rmXWdsl4rfT4NS11CbpSp2BVHRFygv8yZm3SMaQoE6r?=
 =?us-ascii?Q?6M4wi21kG/OeOtB0SR3dBNte6bHGoc0hnTi1dFlv6NQHbOF7EbBfJE35s7uz?=
 =?us-ascii?Q?HN7kQ1X4MdxU57VJxYSxHLRx2Io9wOnMf1xSt+QqNnraU0aCPjGgcOluCs0S?=
 =?us-ascii?Q?k+HQxyMzDffi0z5pzBZ3BoyTLimWw0kMIRRb0RRjyibfAjF0a5ECcH2+L7Ip?=
 =?us-ascii?Q?hHkMmu9wknHwGYOZunmdeK2r38Dpe2Uy7nIYmghdGbyRPQg7+7KTGf5QF/KI?=
 =?us-ascii?Q?RoyGWBdp2Gn/6UKDap0g9L2UaNP3LEMYFfHhyS4AFhmmptE1HbL6EI9cUo1e?=
 =?us-ascii?Q?qRVyAIVvV6+eZ8lHTU/7IWef3joLjPdCrLSGBrNprxBDlOCKqAbvwgi26WyH?=
 =?us-ascii?Q?ewL3oadR3RpORb7tqvC9o+uELbUQC9GH2idpi9hoMVjF4FmORd5FJLm/nQE6?=
 =?us-ascii?Q?Yj9+DTkO/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3c7eab-ffd6-4b3b-82ad-08df18ca5cf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:53.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW7tnmLmOxPQZ53l6CiAormVNHP0wYyu/74xkgqMzclAlgJvdZ5tZGTtahuTgz6TZ1i5+mujEvw0m1mzbrl9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -X, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, select a cid allowed by the task
and held by qmap, preferring its current cid. Dispatch the donor to that
cid's local DSQ with a fresh slice and SCX_ENQ_PREEMPT, adding
SCX_ENQ_IMMED when the cid is time-shared. This places the donor at the
head of an eligible DSQ and requests an immediate reschedule, allowing
the core proxy-exec path to run the mutex owner using the donor's
scheduling context as soon as the donor is selected.

Partition ownership can change concurrently with enqueue, so the
self-cid intersection can disappear between the initial check and cid
selection. Validate the selected cid before indexing per-cid state or
constructing a local DSQ id, and fall back to rescue placement if the
intersection has disappeared.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count all
blocked dispatch attempts in nr_enq_blocked and report their
per-interval delta.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 79 +++++++++++++++++++++++++++++++---
 tools/sched_ext/scx_qmap.c     | 13 ++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 9f6e61d7ca071..84e711ffb0d22 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -366,6 +366,22 @@ static u64 needs_immed(s32 cid)
 	return qa.cid_shared[cid] ? SCX_ENQ_IMMED : 0;
 }
 
+static void dispatch_to_rescue(struct task_struct *p, task_ctx_t *taskc,
+			       u64 enq_flags)
+{
+	u32 cid = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+
+	if (cid >= scx_bpf_nr_cids()) {
+		scx_bpf_error("task %d has no allowed cid", p->pid);
+		return;
+	}
+
+	taskc->force_local = false;
+	__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
+	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
+			   enq_flags | needs_immed(cid) | SCX_ENQ_RESCUE);
+}
+
 /* first cid this node does NOT hold for fault injection, -1 if none */
 static s32 first_unavail_cid(void)
 {
@@ -439,6 +455,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	if (enq_flags & SCX_ENQ_BLOCKED)
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+
 	/*
 	 * A task of ours that can run on none of our self cids - the parent
 	 * didn't grant them or we delegated them to children - would starve in
@@ -446,18 +465,64 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 *
 	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
 	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
-	 * diverts the task to its rescue path.
+	 * diverts the task to its rescue path. Do this before the blocked-donor
+	 * fast paths, which also require an eligible self cid to make progress.
 	 */
 	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
-		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+		dispatch_to_rescue(p, taskc, enq_flags);
+		return;
+	}
 
-		if (c >= 0 && c < scx_bpf_nr_cids()) {
-			taskc->force_local = false;
-			__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
-			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | c, slice_ns,
-					   enq_flags | needs_immed(c) | SCX_ENQ_RESCUE);
+	/*
+	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
+	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
+	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
+	 * it into the same local DSQ would repeat the IMMED handback until the
+	 * scheduler is ejected. Move reenqueued blocked donors to the shared DSQ,
+	 * which doesn't carry SCX_ENQ_IMMED, so another CPU can consume them.
+	 */
+	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
+	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
+		taskc->force_local = false;
+		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
+		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
+					       &qa.idle_cids.mask,
+					       &qa.self_cids.mask, 0);
+		if (cid < scx_bpf_nr_cids())
+			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
+		return;
+	}
+
+	/*
+	 * Insert a blocked mutex donor at the head of an eligible local DSQ with
+	 * a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate reschedule.
+	 * The test above guarantees that cpus_allowed intersects self_cids, but
+	 * the donor's current cid may have been delegated to a child. Search the
+	 * intersection starting at the current cid, preserving it when qmap still
+	 * holds it and wrapping to another eligible self cid otherwise.
+	 *
+	 * A self cid may be held exclusively with SCX_CAP_ENQ or time-shared with
+	 * only SCX_CAP_ENQ_IMMED. Add needs_immed() so either kind can accept the
+	 * local insertion instead of rejecting and reenqueuing the donor for a
+	 * capability miss. Once selected, the core proxy-exec path can run the
+	 * mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
+					      &qa.self_cids.mask,
+					      scx_bpf_task_cid(p));
+		if (cid >= scx_bpf_nr_cids()) {
+			/* self_cids may have changed since the intersection test */
+			dispatch_to_rescue(p, taskc, enq_flags);
 			return;
 		}
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
+				   enq_flags | needs_immed(cid) | SCX_ENQ_PREEMPT);
+		return;
 	}
 
 	/*
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5bb5f687e579c..d5226e0716573 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-X]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -X            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -107,6 +108,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 	u64 nr_rescue_dsp;
 };
@@ -190,14 +192,16 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu rescue=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
 	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
 
@@ -263,7 +267,7 @@ int main(int argc, char **argv)
 	skel->rodata->max_tasks = 16384;
 
 	while ((opt = getopt(argc, argv,
-			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
+			     "s:e:t:T:l:b:N:PMHc:d:D:SpIXF:C:i:R:J:B:q:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -324,6 +328,9 @@ int main(int argc, char **argv)
 		case 'I':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'X':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c78d61806b398..fc10b542fb477 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -178,6 +178,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
-- 
2.55.0

