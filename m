Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EE32AAAB
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253567; cv=fail; b=nkO3He7qv2XyKf9GifseaqHKoyGWdFCV8bygG7SIGcUhJkKlwfe3WvKn10uLK35juVgilivIC9pAdynOrT0QMcUCjUrkCT2DM6Q71FangZuOJSbng+YVkmoSTgfXB/xfb3StPLXosHeEAjhIgTlCKOvQHq66l8ESz/7OoAlPcHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253567; c=relaxed/simple;
	bh=b3WkawFgGkhWl2+PKqZQ43ibrE3fPSI7F4Bp9CuUgg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhZXhZ/L7TN3R6xWpiT52hm1fU02puQGJ+qTa6PLj/M/s+VY/lcK1SRTngy7m0pcZb83mv1korFy0RWWZKU3C4lteupx4EDITlky3PExIc9upelMdfJp+BF3XRf124IyofA8YXVl6JCwBYhdLyMQd/1FM4pH2vrTBFchT6AeLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvbSEk8l; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvbSEk8l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is43hQ+d9ABzy1nj0gJ7uWQlyie264U/QCoYDr3hpgB78K0dd7+7Cq107I9CJwPQe0nNYGYyeZwCeXw2KRQB1gkvrZo1y3IWJGRZQSXCBIM+aJMJVXnO0M7vVPga+Pbl9e5IWlCMkHKIfdiRhpuuvRYgi9vbZKb99/NGkvfaJWADZTLhHkl4uc+6inE6JuP7YQixMJ85oFcEhTkkxWcufP2B4+dzroOtcYHKqou0FaB1XpFH+5rUUv76k17JMBYTMn6tnhY6XZ+uMYW3MpjXJWjmBTc7KAsq36C1mu64u5QjElqAjhPS7djzkJIiVWELZz/L5bJMcvr5fARdCqw+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKl3CcCfBywtTmqg8ZDjhKcU2U7A5FTrlW4NcQuA/Zg=;
 b=nh5fKGgBwE0hptn4bFWWWkQf0Hd/ENu9hGNf6qTmspJUYpWDOrkdNKamAqxhCJogfKsXYFxvFBjx8anl22mK4yi4GQMGyF7jnoS5NypyzqUSFKWyTQXlpdyBAlPU3yxgWPJEnt2yF09gVVd8lUj0GwooE+VrGQ9dE1oY78CpoaB4M+fegOGaUjUgiGp8WlgXLRds9QpXbglpicIzj0Twp+djW8RrlvVrjcwvc8LhgNvyVTMu7rM9jKAscnDLaN6LNwG93zEwszrltEwmBQaIMN/SoQ4FZGr7pWGelTmV2imZNhPvSEHXRFqazuJTwa0y93tNLrOeA8BkeHwf4TEYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKl3CcCfBywtTmqg8ZDjhKcU2U7A5FTrlW4NcQuA/Zg=;
 b=nvbSEk8lUQoGX44ij2O8QGXKRjoQA2H0dtpxk/ny+i1aMsA53QSkwoPNcUQdMjURT7dCHvQ4jKn+nqyb2nE0NuqP/Af7Rq+YUQ6z7z2GoBZ5S5PAselOs6cAMfag6qxQe2ze8FzS5EsNReg7LQXcPTavnELxOrof3ODfdd7s9kDfsGlWrTroeQ6gkIxMH2X7EEGQriIhqlJlpASSrcCLNArjmBo2cZ6sIfp6AGYrOBZt+e7XNCLAgeupyEEvLnRaUeE+eSAbdbv6QZWTvNlLOxNDTAu7xHnYxKn4doV5/QeyNmH/zYCWDU2sAdlWdNmgKbmRnVRP8uNtCzYAx9PWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:58 +0000
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
Subject: [PATCH 14/15] sched_ext: scx_qmap: Add proxy execution support
Date: Tue, 28 Jul 2026 17:43:32 +0200
Message-ID: <20260728154425.1549660-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e958ea-989f-433f-a57b-08deecbf512f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|3023799007|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6u+EaNcKuRMJn2MDuT9aljAKAYuuBk31rk0zwb7IM6b7aIdDg3Sy7AY21K78e4F/b7fPVPoMUEUnhod+VooxF+bHIrTknLA8gitFF4I6GYF3eAWO9K17Dd4CQ044HzdQP3LNPX+qsgmVUcskZoOwFEoSPU4qKr/cDji6HwlNEkyBllzTzZ+Dlj4al04jONxdLCdKZ4IBH0r7hPmAoZILEm1svVqiXUovNmr0Hfh/2L/k6rrFacajsflYeMFx+mqIcwcK6//5BOY6ierWgTS5oF02s8LiXo97v+YVmY1iArUZdbU9w7dwW+MuiRUMsbqVJgEHiwzxRRx566VYreoXqjaaY78ZYru2pRtIQNTCdnNbTWq0psVVD/lM4x5Q2brNCtbfnCLo4ikYQCKtb+NQtegzvO/qNppDVoLUXnEg2PHCR8ysE4NbaVgfKaefW5dyQ5GLBOdoZ5kulc4ciMA3wyNlCk7qOv7zz+PDoLr3USm2Xm8B5DW4rUaLZWOdotJwP0elyPAYEaBOllzzTkvHw1VAmECYaJ84fipZ2bUqGYXJK1MIGqWiaN5ZEHKCfRdJHcDONAU03ylKmSpkJrkERfgyWhlOu7Kdp0FJHxkoNXmaVqpfaar2SnEZqAq9/GlTMxuJo1sExnB1YJaxpfaPF3++YxqV1Z3u39ybLtXtz74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(3023799007)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JTniClOmZcVFw56l6KveF9yNKUlmpPx0dr95OJL09wvseeogGUH6kt1XoxN?=
 =?us-ascii?Q?UPfkgsjrBHVAFHXOAh/qOnobxw0F91Pyu8xhp1fGO5g1xCd3vnvFebplVbYU?=
 =?us-ascii?Q?zfqojx7OYtTjAxJ73SMnSiby83PgnX+tZ+eS/kHhgHnqDx+9dhB9uinn5rsW?=
 =?us-ascii?Q?JIZ0kqVAO2By3dRgrPFtIeOMoW1Z9u1v136W2Uj7JHtHgy3mORZxX1pVIi1J?=
 =?us-ascii?Q?U0CKNlgsHvGpn5eN5RayLUAz65SnX+Rl0F/088LrZJ3kWVY8xtLCYbuT6yH0?=
 =?us-ascii?Q?X/JIJM+rN+xQ9txIVQgjMQBVTxCxr6C31FVSbT+9IwXldlpMqfRMwJUCjK+E?=
 =?us-ascii?Q?njvdm8+bkhfYc0gX6KO/wGgcmkIzmXjfQdUNVwwTGizG8RQiEc6noDPFLBg4?=
 =?us-ascii?Q?UHPr4iM91osNeQYAa3pbfR+UnhFtQMfWntGIcnapLOFQqLd6RZYaZaPhz42F?=
 =?us-ascii?Q?9Nzc6fzA7Fum6P3bReu380yEfaWTpA7B4uEmxvKUk0USvL7W+OFsdGwpCX0s?=
 =?us-ascii?Q?jqaxXTiHxb8tbY0lsCvvedIcKGqVwYGtvWhEYMAwqxrXlcm4vPZakbvd9ajb?=
 =?us-ascii?Q?HoNIuSmRHmkX5HRFoP74QhUirRr+7/O/jDt4vJr0HYMliXqlPRznteSzgrfR?=
 =?us-ascii?Q?RMjg5Ye4mQHmD3thXVP3PZ9b6cvmfWYauR99l83jwom2B36Hv/Ctz+6IkagS?=
 =?us-ascii?Q?4+EqI1a5GPeyPOXG8tehmPmA6+sPirbMeFd9SXmpuAD6SPZ79XITb85kgef3?=
 =?us-ascii?Q?f/9t9rU6GL2dEngt6aSzb3e0fjfIMMsU/fMksBVzxZ37VsBwcqTxTH6YLvnZ?=
 =?us-ascii?Q?Xsq+5dH66LgeV4AJ3QeKOaBdYicEft1tLi0hlbFR4mZzlumjEaPJkzzqh8S7?=
 =?us-ascii?Q?Z+MObJLEBSoTr59gdrVp5H192yBOHE45zY552nsMneDgZu9qX9jcvSQOjcsF?=
 =?us-ascii?Q?mweps+qJTr8D+54bKPENqfjpWthun6OfpMw95ddXS4r70vUnq9y0vmZM7ykL?=
 =?us-ascii?Q?QAmnZk+J3oGHNy3Dk6V7cqzUE0Ce/bh8PBwXO4WRhYpS+dMSVqbfb/LlmhQj?=
 =?us-ascii?Q?C8lJR/Jd8H/Zlz4FDlQ5xhzT8Vy8Lh229RmBL2GEYMzTagpjWd3zSX1NsAWN?=
 =?us-ascii?Q?NqK92Ik/E7KvpUIhcORoVSDHLYMcn1a/QFMnGW0zxFex4uBGa2fTeOiTC8FE?=
 =?us-ascii?Q?U4uMHiakYRPmAAR7e8VLZ2CIJYGDO9WyHbUschmEwFwtjHg7Yhh+FnjYpmGE?=
 =?us-ascii?Q?Q2hAkozPFSY4AJjKKzz/fkuZvg4J/I3XO/FmkKLHqYHClmTN/ByEwLolbI1F?=
 =?us-ascii?Q?9TzNaQ0qNyy0UmAA1rvHVoe8OtRikKvs3dipHmfS1SwnI8dazlvqcbt+3tPO?=
 =?us-ascii?Q?7pcqKEAbDp6i8Af/V4MrNP+s98KO8C+beByXUBEX7lY0LMPW6gxLl1dfB3lY?=
 =?us-ascii?Q?X2+83QpxcCUksF9QAiFUmOb4wN9M09hRCAnkMozcJaHHx7YXCTi1a04+Fu3r?=
 =?us-ascii?Q?5EMjcFP1u1HJ8ipSrgdYKUOWHlpb2UO7jbQSUC2rUwlvYbF+EWqomDaLdIrC?=
 =?us-ascii?Q?m4+9D9GGvvTNCEjqxEYWzYb/ktKdAb51Wmjm8LgreKxOCJYlTaJGPOmlWZpW?=
 =?us-ascii?Q?nE2qaWweFNiVMzz04EKMh5/8/1bEvUDYICcHNd4z8627fJLrB8DLhksM7FNR?=
 =?us-ascii?Q?pm2LaAke0qN2/xDwxAMUwBk4A/Sf7RKvUU3Vs8ld/agOMDEKXooxxoObIk5N?=
 =?us-ascii?Q?guoYDWNLUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e958ea-989f-433f-a57b-08deecbf512f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:57.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0GKqbHdmhwLl0LHDh/gZ4wxtTbp3OBBGdGiu89AOzSWzUkxsRbMl/3bRkZPACxcVQb8FdSon57gkm26b2IqfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

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

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 34 ++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     | 13 ++++++++++---
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 8822ed11c0d8b..ca806ade6c013 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -451,6 +451,40 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * A blocked donor rejected by a local DSQ must not be dispatched back
+	 * to the same DSQ immediately. Move it to the global DSQ so another CPU
+	 * can pick it up and kick an idle cid to accelerate its consumption.
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
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 3f54796e48bef..e27bf8dddd4eb 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -105,6 +106,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 };
 
@@ -187,13 +189,15 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
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
@@ -256,7 +260,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -318,6 +322,9 @@ int main(int argc, char **argv)
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
index c42f7ef74b894..7f4d3b33e6133 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -174,6 +174,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
-- 
2.55.0

