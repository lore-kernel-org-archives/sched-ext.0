Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576752ED4E
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183918; cv=fail; b=sWPB/+bImuJbphoFsN/Lhn+kV6Z+KOBF3Nll728LNg4HjzOhRhAgEOWD3Nb/KNjX66aWEDEwnjvWlvOUEtmbspiDtio6xA2N/3lmnIBwiXl0zKXfc+D8sAKFJmUqOhFC2+OjW779UcUqeBPWHYISb9pmPnr0+rVrLtJv29CtHJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183918; c=relaxed/simple;
	bh=fx1FeHXbOo6+71u7eaXGzbDwExM9AB9FjKXWH+vg5HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQ4M9udH+aAr8L9qch9iz6u+4nRBZsbgEKzr2TpKOg9NTqTw4XDus6KFlzEC4HhVHSDqYzmCncUkZ4jwarS+8vhHdVO2ssG1ELSU1O0fA+ZNMz7hZGRCTZ7Pctxpuevz28weiz30lKK+H2yTbEOZbSaygREG9Wmx6unsAOverMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8xI55Lp; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8xI55Lp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxJOkbUaKH2AcXBbOa7jDM9gPeMXiZRLB9QV8M4+7IwvkLjrelZnjuJrSi7N+Y3H2qhcBOidlRz8X+fuH/xt4OyqKXLtzALCRcFHddUkBi/4WBBA22RK3PSm9jkrtPRTaqmBdPdmuMw7qTeJx97JPCDTvGu/xi3SJrRmZPnGFzODAvuGcvuDvZoWoSGfx4DZlk9osNZ1dNeoVYwRjowHg8NVX6bXwXBhaIEl/HxUsE+QaNuyk2Lne0D/RWKUupuR3BCgUyzpgSKv9Ge8hn3pTRqzEcpCwvs8xyouBupa5m6/VVTvec36/puz7BR/fVC3m1EvL1D4y8UR1MjslePiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cazztr2/qms6TdZAL7QHGsmE68710phQGmpwNgh5eGU=;
 b=xcUhpTsofRrvwiMsJ7WRaefg/fBZ+jFFh8Xc1AeHCtEZBHH1gmF41/oXt5Y9Tq4GyPRMllojZH9A9N8E8jYKsEaYe3GPMGUc855zRl7FX0QFyb0F+I3Ddk8Oke1z4MyxkUjc3N9Zkp2PpzEvBVDCmcTy+Kirihw1squWlMCZRkmLDy89WXln0KLTU8q7AxZ5o84I1HZKreOIcHiaHzCnF/Pc2rL2gXxr532SBpcKwpI5RB5INvvSTdlVkMw5/hEjcVE7z+PAWJAFgfH8X2K7U+NjGhZF7ve3Vl+peqEVzQTsfhT9eVN7pTruYXxq00kkgVhEwKGLMAIJnJ+l5tglkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cazztr2/qms6TdZAL7QHGsmE68710phQGmpwNgh5eGU=;
 b=p8xI55LpDz4ic4CdF28nusPBFbnUklVafffKqB41bJlEwlTATS+E6M0aYUkGp5gA3HCq79UPZxRndsOlyZz4jQldoUHy7dbtQtn0bdqFjJCXUk8oCklYcQzd5RzrArT/fdUqMB4CafOqKbGeda4c2W4lnt9gEUpUBS5Jgs7vSYml+PTrUmQBnY9KzlIFDnEnQXwOsC3QmJ2XgAKHnCQUgxa6Ik9GGeZL/f0/6BsHIqKExTxR8aVmdeWJSU12OD3ACpDvGqaH/t0gDZHoZ4dquKuL0tnWaL9rjMG+TOcKwUH/HaxGEQjUZIPEkaW4G7p1CmeshccsxRu4zLqJpnpSHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:03 +0000
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
Subject: [PATCH 10/18] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Mon, 31 Aug 2026 15:42:20 +0200
Message-ID: <20260831134338.1531664-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: dedee273-282f-46ef-04a5-08df07660f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gAfa/mLBothcis/QENy7NjUqTn3GiO3jE2RDjHtA55mXyiE4t2VbTkO/33zN/2qqqv9K54+67IJDi2YgO4VG12lzSUubUNNw66KPNgFYSczWi7n6r9gtTgcwcg19didpPRPOVCG+n2wLFUr7tjmS9v5UWdZypvi6kit7dfb1Ty5HSK7Zz/Tm+tEqX4bLwgFv/GV8U7sYGrnjNU/9xi44HiBen4top1Ygs/qlz5o9yIOTfbXf7pXS5mQ6PqNPNiJ4Dax8KvxXx/wYYUcllm9y5b/8yEfS8ecEk+nzM1kNVqhmnCoSaQyhMOMk0COccVB3G/AaUx9yQiiL1NxXDSbLZduBMGmUlAbLr1qLcSlPtjCREyPRuvgEYH1pju+/MIlnv+QzDSxttGCqXnsVnTDwvkhra4nRpTU4BeyMyquamKBE8ZXarmcSYjdn2Rwem97olSnMoqVib5Fdx2SYLXQJt544JzFyaG3X0G6EIxYsIHAwmD12QRxyoYM/kls1rsFgAbq2lOMz4LBcnh57F6QaYyIGqsF6XZtvvylguD61lbXxaFHV/0QihbPn0IHYos0omU1wattitsGldWU6XKun9U1L9oa7gfVthK4CFQSeVNFcloNB+BBxUH3723SR2suMOIQsaFjKIpZ8JgzIX9mfyY+7wDqxNvWIr7WjFmq9Xic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8AArsgBMOXq0YhkoYyA7dTxUsfCQfejvg8nHpdqQwk2vK5XfMVgQDnSoCWvL?=
 =?us-ascii?Q?lu9ZzPZt7mqN6B6kQEOS1YIHPl2r/MGQUCstmCDtUu+tcJT64esjkQjKMJM6?=
 =?us-ascii?Q?7Mt7l7BkivyOUtbk5ct6qp1y29TOd4J/4/mQ6KtvmAMFwvj/tH+XHgsecvUQ?=
 =?us-ascii?Q?mMQDYbnLbBqKhrk2Onn3HwLwYOImuGbOXcB+G1IpMrzGcf2rSPIAFEvBqSJy?=
 =?us-ascii?Q?nSr6sKEDJbu0ujyiKb40PnqBtX6FbtkYSZY00dZXr1TjyeTX+My8beXZlopU?=
 =?us-ascii?Q?gi87rQp35MFfrNoWLCMugNg7VauikJguuU/DdytR6yMJjT5Qie/YD3rlGUEM?=
 =?us-ascii?Q?pDO1Q4yDqxLGYQ02l/Aa3OzuUk5MIvLRLrIScd640GfWpNrzsTpLIVLEmNe8?=
 =?us-ascii?Q?PnUB8fRTpV3yMLJIoOdT8d+68OxPLhaO05jy7wNBb7kaqGr10cqSNRRYI6Qk?=
 =?us-ascii?Q?w5fbYFw3iDVldnRZMTn6kLXAASb52/tGtReLtDwter7j4IXvis5MsYWHpi82?=
 =?us-ascii?Q?iGPUSGQS22JGmOQD3Lb0GhYy7rv+MDCFQMPXXZQ5ovSdrinjLAUMBGMXsBp1?=
 =?us-ascii?Q?5CS6ZQ6zZcpUFz3txj9dVqkGaiOcW7H1we6gYT3xgq5Oi7FmtBwDsFLPeQ7g?=
 =?us-ascii?Q?5RfTP2TajRKTyR3uf6p1fLIuVJsCa+92TdOgciCqeTqKOkZRP+DJ8/ysBnKS?=
 =?us-ascii?Q?nJUf0Xbt41i0yrX5zd13tIYJg3HCYJINtmphrEbZWM2Zr1L6yy6wseSMUQkW?=
 =?us-ascii?Q?7lFjY8hVP67R9G+om7ER3DVG/+ZGX3GpL8Cqjf0y7IA6lC87HHHUACIBLpUO?=
 =?us-ascii?Q?HIdgjz2qVImTa8syaQz/WIiTomaYzI7yoXtw+xD+CahWJOrnGrq87bCG3qQN?=
 =?us-ascii?Q?QNArd9Pg77U5eZFKXq/QnSp0GG02EJs7v5OaXOWXXY6o1Vew+dqSpLjxvnSr?=
 =?us-ascii?Q?GealCy7IIYfJ3fSaXknevEubQZ/ycdBcDgzzcX3r7xh8MDgE/lzRfgjJye2F?=
 =?us-ascii?Q?1gY7tAhkdeQMiGTChXdidb91qka3hV6tK+pd4RMpJsJJW6kfllFYTxk05fJD?=
 =?us-ascii?Q?8qEMEwvH5OBCMOBJ2fzvxK2Djm8WDj8drZnHtkaWwcu5MVvlRJbxhgZXBry5?=
 =?us-ascii?Q?KyHN4T5UJF7oocJKH0FYVvFQETKU06MAj9ToioMhQpOjkMWVVmhxISw7N3rc?=
 =?us-ascii?Q?QrG4WI+pNIrN17uHzHCLnIDwaXQqr6uDLmE+jlxdyT8EIdRd1lr/hh0GeB7F?=
 =?us-ascii?Q?zD/nw+/iyT6Gku0V7qvzHJPr3cLHAGs7LvBpXGLcJAXSQNiYNCgOkGq07csA?=
 =?us-ascii?Q?Ai8nv2yq/mAi9QCLB//2PdKLwsURAgleMubQO8Qct4l1DKbv5WuXdqBCLONa?=
 =?us-ascii?Q?yQO17KQs/joyjRYHX8L82Dox85AdV0HS/TU/9w+reUXsTzQNJQcNcT+QmhUG?=
 =?us-ascii?Q?4e3hMmAawTgMDKC1xW5/vZwWBGTejGrEhdmcDW9xD/4aQxWul2PQ/5106IFD?=
 =?us-ascii?Q?V2g87B5bVmsRaNFInVOKpg26LSZRtQ+COwpF1g/xjmmShWEc4+z+jhKHTN6G?=
 =?us-ascii?Q?B72sQsyj88JVJ3Q1JNQQT+StYVMp8W/K7HOTBA2eoTKBd3jbnysZTdS+poSJ?=
 =?us-ascii?Q?fsuGiStJyENOOMMK1VVJaqbNzGkhMolvbVM6ZH53vZxrnSLXU5Sanvxi+MgR?=
 =?us-ascii?Q?GXpuz6iP7AmiS94AsEe+IhfrHcvulKMKHu8rR8+SQrH/Z21AOJn5QxhNco5X?=
 =?us-ascii?Q?gCj4VG7bzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedee273-282f-46ef-04a5-08df07660f5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:03.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sMkcNK77bPhB4SMhcW+8RRhkidZ5ISYzlN196DDQu4ZMoCilrsgirF/A4/u1UaW2hO9kb+WA8ZRVWAGdGo33A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

With proxy execution, pick_next_task() can select a blocked task as the
scheduling context before find_proxy_task() resolves the execution
context.

From the BPF scheduler perspective, that donor is running while its
scheduling context drives the lock owner; ops.tick() and other
accounting must therefore remain enclosed by a matching
ops.running()/ops.stopping() session.

In this scenario, the session boundaries do not always match physical
task switches. Keep the "running" session open when the same donor
continues on the same CPU. When proxy execution migrates a donor's
scheduling context to another CPU, end its running session on the source
CPU and start a new session on the destination CPU only after proxy
resolution succeeds. This prevents a failed resolution from exposing a
provisional ops.running() event.

Track these sessions with a new SCX_TASK_RUN_TRACKED flag. The explicit
running-state tracking is also required by later donor-based accounting:
it prevents an EXT owner executing for a non-EXT donor from being
treated as the active EXT scheduling context when it is dequeued.

This is a preparatory change for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |  1 +
 kernel/sched/ext/ext.c                        | 70 ++++++++++++++-----
 kernel/sched/ext/internal.h                   |  6 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a9839..9912ad0c2d445 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
+	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d5ed996ebfb4c..307d2080b967a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2290,10 +2290,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
-	 * A currently running task which is going off @rq first gets dequeued
-	 * and then stops running. As we want running <-> stopping transitions
-	 * to be contained within runnable <-> quiescent transitions, trigger
-	 * ->stopping() early here instead of in put_prev_task_scx().
+	 * A current scheduling context which is going off @rq first gets
+	 * dequeued and then stops running. As we want running <-> stopping
+	 * transitions to be contained within runnable <-> quiescent transitions,
+	 * trigger ->stopping() early here instead of in put_prev_task_scx().
 	 *
 	 * @p may go through multiple stopping <-> running transitions between
 	 * here and put_prev_task_scx() if task attribute changes occur while
@@ -2301,11 +2301,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (task_current(rq, p) &&
-	    (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq)))) {
-		update_curr_scx(rq);
-		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq))) {
+			update_curr_scx(rq);
+			if (SCX_HAS_OP(sch, stopping))
+				SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -3010,10 +3012,21 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	if (p->scx.flags & SCX_TASK_RUN_TRACKED)
+		return;
+
+	if (SCX_HAS_OP(sch, running))
+		SCX_CALL_OP_TASK(sch, running, rq, p);
+
+	p->scx.flags |= SCX_TASK_RUN_TRACKED;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3025,9 +3038,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED.
+	 *
+	 * During a normal switch (@first), a blocked task is only a provisional
+	 * donor. Proxy resolution may fail or migrate the donor to another CPU,
+	 * so defer ops.running() until scx_proxy_donor_start() confirms that
+	 * resolution succeeded.
+	 *
+	 * !@first denotes restoration after a SAVE/RESTORE cycle. The matching
+	 * dequeue already issued ops.stopping(), so restart the session here
+	 * regardless of the donor state.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !(p->is_blocked && first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3073,6 +3097,12 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3148,9 +3178,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			scx_task_slice_ended(rq, p);
 	}
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	/*
+	 * Preserve the running session when proxy execution refreshes the same
+	 * donor around an execution-context switch on this rq.
+	 */
+	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d900..0d7efbee2862c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -449,6 +449,12 @@ struct sched_ext_ops {
 	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
 	 * target CPU the task is going to use.
 	 *
+	 * Under proxy execution, the BPF scheduler continues to observe the
+	 * donor as the current scheduling context. A blocked donor enters a
+	 * ->running()/->stopping() session while its scheduling context drives
+	 * the lock owner. The lock owner executing on its behalf is intentionally
+	 * not reported through these callbacks.
+	 *
 	 * See ->runnable() for explanation on the task state notifiers.
 	 */
 	void (*running)(struct task_struct *p);
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 19aa1de3e7005..cccc0c3987b85 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -101,6 +101,7 @@
 #define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
+#define HAVE_SCX_TASK_RUN_TRACKED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
-- 
2.55.0

