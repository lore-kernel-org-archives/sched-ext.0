Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C7423EB5
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208235; cv=fail; b=uDrGWjUD0YmANj3fgRNBUU2QrcPikgsBSIVPWax8fFpQz5kugoxRiO0ON3OCOurZPbly/la5fAyV7iIJt7IGo015neKsvpnUue2+KlvdFXYdAlZ2s6ORXo6VF5bEwycVKpkvq6GpZWcNhLSN7HJhW1m7uSczTpPOm046bekRp9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208235; c=relaxed/simple;
	bh=+Vwm/Rux3XeYoHPtm+i7PjWlT0CC8//CznA2sSyvy44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRWIr2zhLeX82lDDf17T3O05OGjY/Ihc8DDF31p0QT7g2aMO3q9JRYO/8BEttY8U4eXLQU6UMTjyLFiwNg7ywtLM3YmYvXLJCyHJJblPoVNTtmsHIvsSwpxndIwsZNx6+JIJ5F6NuQf1xYPm5T4vHE+kuf1Rly66v9FesogiutY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tPtjDNFT; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tPtjDNFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShIroRDzy9Zpk0qbbPFNLLuDUa7zZmcnSxI/r9BjBh0XD+nXrECEeWuNLY/iVa/+HdxWTfW6/hvRqyS5jjdKrNiOQjivMOAQiuOA0cgAQuXCywinQDGnVFq9st1HxGTrbNMEc484DbJzd7QfCx4Gk8fzY6c9JdFO3xgTg860UVj2nMp4sYK8Gfr9V/bOSGCl0lbXnnHqhNPPB/nEFDb63bETx8Ua+vldoVHhjIIrbfsowBHW3DV9RMVC2D1iCTBp8dBJRLyq9Q+wseQaWDAaVanSESvDP8r6RJM7JqR9ihON/Cu55QgwLvpzZfRRHityw+M9wn6/zzk/+/1W5k97Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p061kqbPUyjO8twv3TPPrEdOOMwTIDuRY5ONU6vwreo=;
 b=NEqCu51MIh+D/dMXou4s8qjUUE9hh+LTpdYDw9wdomu9rlAjXCncSZGRLYM5xcyD4saId0lMeb3Wj1V0AzqtDiLTFn316sdKO60kVPzs74IhUfH5PwGMpWX33XKSaDe042zcNzxGxLgaGheZNjldBa/wSPXBVYDpmXf9CpxGy9E1XQ8CLIUXngG9f28VNFXijePjKEFDyhfy+lFBxOxwRfJE89yKeObnYTCpWWY/D5sVcOuhkLv28aJCiJeY0ItM8HvUxqG5m/zJhnumIiibQ1/JFPdIPfkMwnPJKdS/VFHvZVVLHkBTSH+6cn2u3dNB+HMKyHkdnLcwpJB3JQvLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p061kqbPUyjO8twv3TPPrEdOOMwTIDuRY5ONU6vwreo=;
 b=tPtjDNFTG8ggZymXm0s3nM9cfeRZykQ87YfefL7RRzavMpJ0WqbxYlqII5+PESMfX41nMpab03P3oREWMQP+hogcqHI6IFlefT5Ap0k0FY/p507/oniJIW6ZXVQ2GTlTwTeUe8M4HmwfWwEDUqi8TLBkhn3WoEBQXhoE74fLc3EGrQC3LbfZJKHXNzis7ehyR0FSqFapuJRYfKl1a60JrPt4xUq1kG0vq1P7xL1QZ61Ti1HR34F50qvUJxGc55GAuFDa9jjDBnTaUg+WXpqiH6rEcSMo8/iMzm0BksoJ1meQKXEysXjuRdHVyU6yGH9Bnl/rlrB6ysRjYPj5NMcClg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:44 +0000
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
Subject: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Date: Thu, 16 Jul 2026 15:20:45 +0200
Message-ID: <20260716132229.61603-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a50e216-64d6-4a02-1baf-08dee33d75eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zLqbQcQ4RdrWGE132uni6emu/hJC2+jxT82OlbAnr393sgIIlfElW2/ev2BC2FPqAlDOfTNF76e0o/51RX43kTILdtw4aCbUVkqH9SgziBXD2VZm/SwreG0Hh8IWCtBSqNf9Sx8uqthVb5U8ItdRhSbaxko2jFNt7zpxnuR3PlAOJHOhpuUkYymzPFlQ6kpYxIMJoBbkrC74zo6LHae7coVEThztw7SKp/5F1o1yNzuUekX/EbkNfRWgtDCWdBCvlQ8SI9f/XNBh1SCuBvqZRIvL1ZXGGlo7gJoR4ubDCq/w8s8DF8vfbRv5rzqGYH+YyXh16sVu4iNd3st0mqfXgm4MedL5sF4HiIDKK1v+xjvHlMn+yNCQQQ4G6WB75nfPnULNcnPpVZYgGQuENCGs4sijYWFjCqc8Oo03DHJKZTPQixMlL7iAXbXvMVzdVVtyCk5hDjM7D9gminff+z/PjPJWkqURSTigGErCm+i7KXYrGBy44pxsRR5hSfRmK4AcU+H2l9Dqqk0JXMCITarCosfQZSUft7f4W/KEGEfdjgFAzNzuKOFCoT9IzfEZoVM8VhrV7hZVdQb9B6hGm7vJO4cYpyVaDSDKPE0XAN9qXVF8D5jSz0xIyis74VPimvQbyJNQaNSMk6Yg73cetFBGMPoNO0Yl75vCLQW62FbPxjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyaP93mlUNraGTF2YV1C5KNAGrjdf+5yagAJz0WOwUVl742PhT5+jMKWnd6N?=
 =?us-ascii?Q?Zd73kXkKPi8uit61RBRIkhHh83J8IJrSBP1PN+H6oszQu+pVfG//nc4Q+9Lm?=
 =?us-ascii?Q?L0dX5xVVE6tk8bpxQBoU+mMp82jwPuvEdlPTRYvUmnW1sI1GLI/3Xzf1T38l?=
 =?us-ascii?Q?SPCyGE9QCanPYR9D9dsOXZ2if5z2TUX1ctv8H1uN1Yoltq1RrjkoeLWOHUmW?=
 =?us-ascii?Q?pNnNe7Xjc86BJf6O3nNP33l0GRZocNby4g+K7KURfVBYPVyRu4kI1myuBGuZ?=
 =?us-ascii?Q?nBKNo03ou8VPrjLeHsuE59jIjkdwRhNgDHsWPT2bx8MvWhzB+5gJTrsNz+F9?=
 =?us-ascii?Q?FKZ7tVsNiVqrfGj/eikMw11pMIFSOxVxgiYiJAqWvzy47la6L3Dzs/M7pn0v?=
 =?us-ascii?Q?VK93tJxExCLGk74gKrU/SFUj+NV8ohdfoL81Upw52xg3v/b1kLPOCoesprDG?=
 =?us-ascii?Q?U5SmhAuxaSS/xsgpg0fii+G7p8SQn7SwPChKgszjb7c560XrEc6VE3w40CtZ?=
 =?us-ascii?Q?/aPg/2WnWRxAWEO7pgZ0R1rcbsKSSfDo4vjDPOeqpdSAYCnZXd3GWMXQ/DNr?=
 =?us-ascii?Q?foxwiIBi8Y9aBc26lGt3/WYqsk8a0SIBzu4nzV1YYyJAn+m/6fErjc8JQSxG?=
 =?us-ascii?Q?WED5TTdmEaSFRXCO/HPR8RabjHQ5AnhlXhVOXbFRrc1J1boyG6JeeTJU3F8v?=
 =?us-ascii?Q?Sx0W5C2x3Sawzq9As0HEYUmcePxYvnGsozrYjThh8hLLEwWlcV3mKuBtEhUE?=
 =?us-ascii?Q?uc9yEvbCvFNGvJjRd/FLMPYTMKg7UVAbi8Xenz9SaWty3hJZHjkQneJlMv3a?=
 =?us-ascii?Q?iR0aYKeHlRVW0HpfyNqeFnrv7GrPpJBAh2HS7bqjfRpeR+MssnKlbNIEIw+g?=
 =?us-ascii?Q?BS92rcvgg/nL47nzt6dJCbLpBEiMRhBSGco8+xJcOuV1q0HYHBPUg9Nlj+Ht?=
 =?us-ascii?Q?Hjp3uYkF+V3i3IQO5jtMNUSJpjhR4/YL4vTRtpl3k6xG5RxrmQ1qh/a8nXcU?=
 =?us-ascii?Q?z/Zlm3Of34Nar+ja1NdT13NpZX8TLGMhQF+K74/NjXqiiI+VvUSBG3ccI1Vx?=
 =?us-ascii?Q?n9JMhn/kRGer75gmJWP9p3OHqtH6GGAXd/nc6CW0WO1Fe2mbsiM/icBPhH8u?=
 =?us-ascii?Q?NFUMevDwsAmBo6yBQd8nAHS5W1+5L9avGeRYvXfl3+Mr60oH/dYxpfVcJCEa?=
 =?us-ascii?Q?8d3omFD5c1JL7zMkX9Jv2vep0XbTFRXk5PUzSio7lLwGJCjvS7sAjB064kmi?=
 =?us-ascii?Q?fCtHUt6foZRUPh+X0nIUAOVOqN3lRZPjqXBKwqAdgzak2agatfAmhcpVcvdB?=
 =?us-ascii?Q?rwWmJT7IP081+HLmltTfD+vtmO9yBNrT7YFTyBxxxTmP/0SWQjK4hVYdw10W?=
 =?us-ascii?Q?cfrlNpq5bV1n+0Z+QqUTeQvwxQ6HjUOxjzY9cYSciPUGZefPAGokfIaVQeHs?=
 =?us-ascii?Q?2PMAwQNueu8we84/fuIUSKdAZp/fJCnvq78c1XSPX0+bHVlhrlKsOTzrYH2r?=
 =?us-ascii?Q?rgeJMmtYaAKK7dUEprhxS4f/Ku05MpamsIQtWxRfIFWkrMLfLgWsmCtZKmTu?=
 =?us-ascii?Q?hzvUD+rM6KT/Fa70tI4yKMA2G1C31a3mi9JAl+7bNHAVCoNOddZJdSyjtQBz?=
 =?us-ascii?Q?dpVv121Fh+jjRs1TQkEEMtFTlxHGT/SDBJGW4ouscgbEmhq08qOofMF4B3oA?=
 =?us-ascii?Q?XXURRBNY4KPLEL4HkBp3uJKHt3+YH+ZyJW2lzhKecc/A/xgj2Fsa3ChiEmLn?=
 =?us-ascii?Q?wlQYLe6ZQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a50e216-64d6-4a02-1baf-08dee33d75eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:44.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drGNmJCMPW4np/qYWlaiidVilpEaAT/BwzcTaiglQbphCzkGn60dKXPbjcFVSWfyBcbCyzMezmWzol6kfOM7NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, dispatch it directly to the
local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
This places the donor at the head of the DSQ and requests an immediate
reschedule, allowing the core proxy-exec path to run the mutex owner
using the donor's scheduling context as soon as the donor is selected.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count
these dispatch attempts in nr_enq_blocked and report their per-interval
delta.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 52 ++++++++++++++++++++++------------
 tools/sched_ext/scx_qmap.c     | 13 +++++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 09aee49120c28..ab14325a07b6d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -451,6 +451,40 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * If the task was re-enqueued due to the CPU being preempted by a
+	 * higher priority scheduling class, just re-enqueue the task directly
+	 * on the global DSQ. As we want another CPU to pick it up, find and
+	 * kick an idle cid.
+	 */
+	if (enq_flags & SCX_ENQ_REENQ) {
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
+	 * Insert a blocked mutex donor at the head of its current cid's local
+	 * DSQ with a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate
+	 * reschedule. Once selected, the core proxy-exec path can immediately
+	 * run the mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * A node with children delegates most cids. A task of ours that can run
 	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
@@ -537,24 +571,6 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	/*
-	 * If the task was re-enqueued due to the CPU being preempted by a
-	 * higher priority scheduling class, just re-enqueue the task directly
-	 * on the global DSQ. As we want another CPU to pick it up, find and
-	 * kick an idle cid.
-	 */
-	if (enq_flags & SCX_ENQ_REENQ) {
-		s32 cid;
-
-		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
-		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
-					       &qa.idle_cids.mask,
-					       &qa.self_cids.mask, 0);
-		if (cid < scx_bpf_nr_cids())
-			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
-		return;
-	}
-
 	/* Queue on the selected FIFO. */
 	qmap_fifo_enqueue(&qa.fifos[idx], taskc);
 
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index dda3ddf5b7494..bdc8c4a5e178f 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -51,7 +51,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -70,6 +70,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats and weight-refresh interval, seconds (default 5)\n"
@@ -185,6 +186,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 };
 
@@ -267,13 +269,15 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 
 	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
@@ -336,7 +340,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -398,6 +402,9 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 87642d21fce38..c706d91a6349c 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -173,6 +173,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
-- 
2.55.0

