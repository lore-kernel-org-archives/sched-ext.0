Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682F4BC005
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089642; cv=fail; b=dI1ohYuiPJQnoIRFUYyS+R4Vdodaw4Qpas8g0ziAGLObdHiwodHTju6S8++Y0QoujFIMRazzFe+j+7b+L5W/snN09KYaf8qH1xaIgdaPg1VHt17KWvdxRxxP6s+VZZE5qFSxEzLkyj4DE03LVRn6mdiyV7IDLlr7EJ8mc4D8D28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089642; c=relaxed/simple;
	bh=C+75qp3JCtTOEM67j7iKJ0SOxRoAI/teAHCF49NMtJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COv+e6f5qKL6sV373xgJAaHPZ0v7P9R90pG8QdFoLmlKMsBV1unoq9jsKR76owv8ZJzsVXs0e0w0GV/vxoZm8RpTLr0HzIytODoht9SHBEkPR5JK6+kJg+igcM3hoYHPFqCxAaboZ1qG6YVmRQiXKiWq3P9vXorbGQm1OSJXnQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhuSHbzp; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhuSHbzp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agqobRUf1WaDHEQgPuN6eDfF28FN4ec0Q4+i8zI1kluH3GeIIILDTm4VHQSuoEJ7KhWfn/RuVSjHedIbnhaRIrAZHmeDXcCKuOFIRfhJmvFVHjLooECd5uWLVfMNGL2acDCdzFMepTigQP9VK7JSbx3cuNH+JQApoj2ox9WxS/En3v2GU9CjXpIJQDtJmSsyFyl25qYNuv7eCTmFBFON8AckwM2ekeBuyxG+HXlW8534mrS2+5N5ToUX3QP6eZa5PG47VudIkUNeoifPvCUJlxWc3Df8AmHQ6t0iVBopyF8Vr0RHISkpEoIN58T1LWRSm59Bgg8awe3hRiLqgnw/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8v/jptC54ooNtWYQzzxNMCvWsu6w2Pfw+87MKptQ0g=;
 b=Nfj+FEg97+xaRMEkuYperSPG3lhyXBY4OygROCirUgbS4x0iBbLRYjSi2vPiwzb4BBOYGVVe5UZnhatgksuSwjfuw4Vv+42ijUhH+IZlF5ni/KWLXfJ+Lec5O16bw/XnokLRtsOH/bBQo/vcKcFKjxMndo8vve5uXuXm/IFDZHH1/Dmd1btqqpHYz2x5C2BmS3H8C8Qq6Z5lUAt+uiiUJE8d1gnQZz6lolKo3hPkSV8cHfzDB6sI/LMmc7vamed4/orn467vCi3CvFWaFiidgTkYSHnceekyZErdte+J8DL5aMeZwSlf78XD3cjjF6byCN1d31hGoiM0zp4ldfricw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8v/jptC54ooNtWYQzzxNMCvWsu6w2Pfw+87MKptQ0g=;
 b=FhuSHbzp/jcNShopFGjsCiIw8JVnxrTFBhrpJaA1U/Z9m5ShKdjeo2cACYZXLuNDCI/2gJ8MFjRq+5EIpRzrZwgRByDUuG1p2ozu5bWnrtARL2WsyK4x8RMROZhI5ouLCFIt2XaNJU9bpj1aFto8PC/6LCoDdbmfIxK6fxXXT9NMjKJ7nxAiYRfmUuid9uO43CGXGM2meiqaIFcdQCbc3SGnA6qWEdFICiIRnTTGAHBEDnSLQBOFFjJJyMfLnNoPphWZstK2Qv2qu5XrKlkrVTmcBeton2M7rvg7rswYHN+Ni6jgDz8fAsecbM0zVcE7RQDnMtrlWZAmI/Utbin6iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:06 +0000
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
Subject: [PATCH 04/10] sched/ext: Avoid migrating blocked tasks with proxy execution
Date: Wed,  6 May 2026 19:45:44 +0200
Message-ID: <20260506174639.535232-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B82.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::415) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 302c5bff-b348-49ce-e4ae-08deab977d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1zHKYF0J9x9TcHVrIBM3V3FvqcS9Kta684wIBPeN79HnnZbdLN39EdBs5fCZ4O1iMiK8NMEz2GIj9qJUoZ4PPMx5OFazHtjKdS2v70fHmGr6OGIGzLL9mGuurymrkEOIJADyycHiIsQxE1vhwwnhAfizbfCsHpNdOuOkM/TSxh9b0Acz/Dr8BmKmem/lvQllVRggAiUBAyTtFTljnH+pfURUA8jnQfismzQOKGUBgRRAu9VPju/OHJCq6bEmBLVloDxTONUd1yP3g1SHM3HCemTi+eBXN/g0Z4jDOM/QC6Yj+nd1K74+xvDaQZrGNRg8R4Ku+uswpS6Fa0fdJnORJNbpbArajsxUM0JFxCkTn+etHUcMs+uB1wZnCop/E+YePN73yGfjuVbfty+qXdP8Yo9pC9YonOYQJJRSp4tWmaZvKlflI5cLM0UWz0kDXUfY6lJt+tC8JdvkJvhzouZqWGhUTMsnAzcq3Id6ec+xyhJ9BmU8SLjSaCFk0wemQWt8vyJQDgoX3cJXJ6XC9RAcqLNzQOFGKeqrSdniK8K6D+kewCg5Lr4pD76ss5PP4FONVm7m0KP+/NqEQ3T/5FR5c4O4QHuXBZQHN1sSVkgQ2VNKz92kLNL4OESXioeTrYs1nFBOn/8KIU5iNLZbaNqc4MB8sylYVOZZGfNP2RcNZemzBhSTVbL8heTsqtx/4YT4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?es4aLUCwSW/k27Yx7yNlflyyHa2vMZPVpPjyMvhTxyWyqvF9MVzBrt8xz8h6?=
 =?us-ascii?Q?Jlp/kKFhZNjtACGhoJQT/HpGVA2vG3wfEszmr+yBq1Bw7RCDgSEebrF5XEyi?=
 =?us-ascii?Q?/DN5WAApPeV/lYIhEkvMP7VXfM0G0/HjzolwTBdijK8f6Vrl8AAAGBzXpmFj?=
 =?us-ascii?Q?ylJymRF0L9UiHeXYLtfa/U1/SWK1GUva3MDhMv6zac+euQiZd+roFdE4GvZp?=
 =?us-ascii?Q?x/10rCda2MdphQW+71CrOY2UabOeOFhZBg6bC/3UnQW5UlWeyUVHG10S07Dl?=
 =?us-ascii?Q?R3/8oB31JrzMAe9QtLK0TJbMgBqNxD3P8+6IDt8Kd3+LTyqpQP8xaaYF0uRR?=
 =?us-ascii?Q?Ll1FZul8RkYmqPenlWvo+sWmJXvpgRupF4+kSlMzGB+n07sOD49CD88ROH2t?=
 =?us-ascii?Q?zmf/f+uo0YG/IhSL7dwjzpxHBo9Y8lzjZDqVlDL/XJ/nrYzIZoLgkdjKr51y?=
 =?us-ascii?Q?n57aABpCEpKMrEShWXLYFGPZ43luLWzCIgBj7zIFyAAJB2oPjijp/GleftbT?=
 =?us-ascii?Q?OER8rBLrwgtGTI+u/MtxiD8dPAPTrJg8hyFpAI4KVAjx1uYGjtKzDwdZ3Z/z?=
 =?us-ascii?Q?5AxVBgWwt9vi+S/OeqtbexrmkBPnOlHwhuE2fMjaTk3fqM7olFeWfgjYtoCe?=
 =?us-ascii?Q?UQMWaEM9o7Dw6b5yX4nSnC5qHS6zUlRSyfmeVndzshXJtAovgmsOTSn13taW?=
 =?us-ascii?Q?F+Gv0jSnfZ3xTsfhXio16uyktdZP41qhjuVaN4JHtMnFLOceOjJu5DyKTAlr?=
 =?us-ascii?Q?dWKd8qo6fw0KvugyENim+54nA5o0IKMzcFFJqT8Xqua35irc6+KERYPHGB7h?=
 =?us-ascii?Q?BO52m39q+M1YypHHTheK7KYV/rOcVq9jv+SEDeqr+Bue3fADoL16BCGM8uW6?=
 =?us-ascii?Q?aAI5btPW6rLsyMa9t8vLrBwgvww5LRZD7EisDdXX81d4xXS/CLPSWBEsxoDW?=
 =?us-ascii?Q?bnwLTNVS26CCVuQFzDxqJ4twrXytKpj9P65h7qv+KWakLp8GrDPu5JzLZ/Ep?=
 =?us-ascii?Q?/XoTKm45vik0J2bUgCAdhzI//Ee5Gfg2t4BZsgUrLmrT7uJVdO+BFJKFdj+i?=
 =?us-ascii?Q?Wj0wE0GVWnUOTtNJxIK5OmAuKd3RJOXLVr9GfD8LSspffUMINIX05T0DVWv8?=
 =?us-ascii?Q?JDl7ZBaB5MhDSBz7wiDyQjiVOrLAYbP+R6JPIaZbxoIsp09uSOvVVeHrNjaZ?=
 =?us-ascii?Q?hkby13UWC9qKUW1kmeLNhx5RKOe4MsGWdZzo3wjwQcyqdFN37X4QLeVR/H3s?=
 =?us-ascii?Q?6C9oFTfi/fK6w0AI1Aplxd0W/C6LFsEbAutY8E69F9VbxncgWsjQNcz21dJc?=
 =?us-ascii?Q?Dq6qSMmwWMzzZNB9H1aN1ckjle80SY01biRWllWc+KT5exI0NHjOIR+zKfmR?=
 =?us-ascii?Q?Ri3+Y4u51sElw6XrO6V09LTrpHXwCGEiTKAAgWNDBDKIzdjIXduesJPMvWq7?=
 =?us-ascii?Q?zGdtXfVBfmxvVWrbu9Mi4CzjtFzaLSpBjZM+TJ9wL3UH/i9skmflre3n3qWN?=
 =?us-ascii?Q?hIP/4RTCAh5DghYLF6ngtG1QAtHic8WS9LQovZeKszNd/kLX5l3ZZS10/pOq?=
 =?us-ascii?Q?mlqXTTtUU7L+WB5rCBSgUt8XeM+5yA6RCtpQgPRANJhH8SQNoGJBOQFgDyku?=
 =?us-ascii?Q?0Z7FPcnJwA2gkSxyMJUO0X5fqVW0X0uWRFxb53snWqJAF7LDhP/Q95tWCGiK?=
 =?us-ascii?Q?tXaUiYt+DNCS2xHcG/QPcIEigofex75zM5no8Udzvc6/fbdu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302c5bff-b348-49ce-e4ae-08deab977d11
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:06.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhO6poAVYpfJr6AY9z5fWk8GDacdK/b0qg858o/c155BZQM3i+MpRXaIwHeP2T+nTEER0NCpb6eQ7FWzVfFTfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex blocked tasks stay on the runqueue.
Later with donor migration they will be migrated when necessary by the
core scheduler to boost lock owners.

Don't try to migrate mutex blocked tasks, the proxy logic will handle
that.

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/ext.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c410afd28fb6d..d64b1283fa851 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2320,6 +2320,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Make sure tasks aren't on a cpu */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
+	/* Don't migrate blocked tasks, proxy-exec will handle this */
+	if (task_is_blocked(p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3063,6 +3071,23 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly, so pick_next_task()
+		 * can still see it, find_proxy_task() will be invoked on
+		 * next->blocked_on and either run the chain owner here, or call
+		 * proxy_force_return() and let BPF make a new dispatch decision
+		 * once the task is no longer blocked.
+		 */
+		if (task_is_blocked(p)) {
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.54.0

