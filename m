Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C03BE14A
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501603; cv=fail; b=uV+86fpoXaHf2Ofmuklou7olav1xStZCqcP/i2FGvBmhrzxM4sFqfqvW0XZzWRUEdaWi6Mgcm5+g6id44ARWA8YYCqOTvSJBMe6rqYv4/gqT9yVEjyc6RcuqGSEmj0cy+/2k94UBnhBY+cvWavhEWw+Et4I83KaFcZHxFRanW8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501603; c=relaxed/simple;
	bh=5pHl/iG6ntnxOJ133fLwiBw22yf6Pq1hXvx9O+mk9vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufsPikAelo8WDAfiIEsTJEtKe/k8p/QnobSJFnXWiJjFI2qQlSUZIJdjXzwDzSisMRXCMlEfYSoEEVKFznYGDekvDzRr6MBgKpCSZh5DmPYNaLbNWF8KZINUVzwgckUboKCUbkt/5xqZX5Oh4uyNSk5Vn9Y6NyvoDpwonwz0LjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTduWi2F; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTduWi2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4bm7fr6Rh2GwWEXm7vzWW392i5uhsbzAdOM/c+K4zbLeeHIjc0tfKievZOY16Bq7lEpz9CdMV4zkGXZ7IpcdZKEDmGndtxGYwEEuRptCshp8CQB1KaW6tQSabm95Ao2RkvHQxSNprtz4MDj+81ToLz+ZPeckTxcahCkOFNHYzL3C1FPnWkovxUoZmpBouQFTGnPrl0ecbLg8/weY1L5pDYxp11ZZ9VwsrbJZgEukL7VbfH4L6ZPzLp9kramEChFhurF+U2vMq0+DQke1lDHZDlG0Iqa/F7EYWjqu5T4bvBt4OAXQJitWLdWTwi0NtugQpOTBFkW0x6TrcGrlt6UIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKS/cJNEqMLp/5reVuFHfQ2Qohvcc0tM2Gdj6zuC/os=;
 b=IxvOek0DEZBrksUc0z3AClZPcvlIr8lVvZmAhIbyWVOJDHowHRcR0qnrIkK0Hviu8PqCC1WXbF7Y9XffNdpp6hD91AAd9Pjd+Mqvs00hvL8Vc3VrrZUC/zJAIyGnw7BqUmJm1Uzr1XTWS80qorlRuyf1wT3gyFQf+V3hnSp5p8xJvEl7hQGasejXUXYF8+lMPNB8x5IJfLMmCOH986Bz0c6TGuW3/TqYuYGmE+sjCY4/JqgnfICrC+5OE95bYIUqNv33hjvzelAD4gjg6QV/qSRoLeVh3KvmkwyGlJyhGzwDWjdcqynabjahMa4SO8d22LbtIJ4gC4F6bkDXUsk1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKS/cJNEqMLp/5reVuFHfQ2Qohvcc0tM2Gdj6zuC/os=;
 b=GTduWi2F6sLmIafUJh9hyYzxcRmwQ2xjRKJrrEowgEY2y0l+NCZ8gCsGtnjn21aWOWmPod4dgyoy40uNmFnEYm2Nx32UJOyCECCYa1NGwStLkup02kbimIb9JAOifZMV/SHOWnZdURyJGHn5QLUWCZEnyacUMFnePe3HR2gSsby25mDQ0mLeCkE9lgA5ShgDgstBykJRN+CYet4Z3K/mq3kgrWKfGMSquJNIm34/KpFzMj0kB+JLW9CSFAK43cs8BqTxMoD7sN9XwWMKMO5d7Z0CIoonEzTBI1O2hxLaTjL9PaIproyi5cTf2x3OmZFHdn3g9dy9gfdM+MrcJn0tFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 19:46:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:46:27 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Tue, 15 Sep 2026 21:45:12 +0200
Message-ID: <20260915194611.2674127-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915194611.2674127-1-arighi@nvidia.com>
References: <20260915194611.2674127-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 94781d7d-78ca-4e17-851c-08df136207eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TWNt13wI/eI8k6gQm6tfc0SRRan7roP2RTcOiAcRSBGgtO3+AgbsVkqsiQ0YE5lyjUSgKK5QbuBHOFpNSxqG1G5FtzwqdIt3tjinmbq8lf8KeIcR07P8W425GPP4tqyVxW8gci3vd9+V0UxCtu0Cv2ISP5NxLve9M0ZEjJ4agWxKl7LpRHLa/hqSWHrxaw8HsCpCGWtJOyjdt3IKc49Le1ZfPtj7j5MPAaRjch0LM6DiwRWGW+qLvE5U/VKZ/LhJLi0Y6n50DNMiOqnr/ua9hcl4mCS+598oQIt6gA/B0sO9J7dB9e6Oxbl3HG7MeXT6y8Xj6jvErsfi1XzullSmMb2zOJeXML7jT0m/gh6dMLg2rlIqryB8Se87ubcLvLr2JpJLU1k9J8RLmzi0PJHrUTQD3meYyBEKI6FTK+gKJIUWinxFkmfjZGHMdvaF89pxUqHmrlgTI9i+BQvDPD5GFrFZWWdbhq5V3TKtq/ejBEpiMXJxrAgzs9fZcB2n71Jew/NjRBYxCc7Ae34Q2awvFFjFySpO0svLKdiMW094GpITfmyw+QXEIwt/nBgZ+w/HaSns5uVfR9BNtAd53523e00/qSRXP5BNTZZX/P3RXZGcCt0PIg0vUCVcWB0Ua8VPSs1HSqKFECdTxjs3xmD6TFulmTX77TstLq6o7zxFsbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCayEtTEIbPaWRphfvqgGxh+y4xMIFHUdMHaHqt2Q8DvWVAeocJrne87ogPc?=
 =?us-ascii?Q?F9bU2UufyojA7juUunTwkiU9RUg03aQUmxoi0QgpBwfkpp2Bd0uq/WPxvs96?=
 =?us-ascii?Q?5vo/NdBRzY9xHJaBEVk0JDTUXO5s6/VaIGBm4hPIPRzZpUX7mVX+Z1tY8Bh0?=
 =?us-ascii?Q?EmqrCyYqhbH+tDmXcCGzaI5aMDLh0xEXa/phG5VczeECViH7rXkV3KDiCQ0A?=
 =?us-ascii?Q?Xd0q+bOQCtu7mAWOb3w/7+frylTk1sQWUabrdsJFQlkyiax2DzpWgfG+R5jf?=
 =?us-ascii?Q?sEDaM8fOKnX4thvdrGombllZYw20iXKGjg1VxZFqy28q0FL1TiFPqWMECRcP?=
 =?us-ascii?Q?CIc4KiSgDa5i1VDETuhdSyqEH7sZirJ91XUywJSUpwLRSTLu9UdA+bjJ1r+k?=
 =?us-ascii?Q?UEFlJ37wiXXnQiITHs/SX+vC7r4M/1LwxQuKI8ODHtzZpuOtiR8e0g1Ags76?=
 =?us-ascii?Q?a86lk+D+Sk4zNP6dmCajykoy3Mfo5saYmabY5HZ5ll5NxtueqotOLpVqDV65?=
 =?us-ascii?Q?D4zU2bsQqEuqqACkIJBePP5H0U5SIUbJ8oFFaA33BRs9IwE5vYzBVvI4Hg1e?=
 =?us-ascii?Q?gv/aZ8Sx9FoL1OwEmb0hxgGwCiKpnPicOCrKK4R1jXCO+LhAwYMJmdu73EER?=
 =?us-ascii?Q?BUKD009vijD942fPTB2r5e8CWkASbujiAdpJCwQhN3vS1CIm7LMWgxxqalLD?=
 =?us-ascii?Q?aj1i56xnhKxi8P1WVp2bQNLvZyZbILYrq9Uzv/tiAFNUDnGngFTRAfoVFlmA?=
 =?us-ascii?Q?xB5LWigTx75Ve0r39UXxx0yOiqkizrU2GC4XTznm+mdA1h3tcZqriPDG4SQ2?=
 =?us-ascii?Q?iD1tdV6ChdduiLNpHaHJ62geqIsgGFmscAMj0d2r46VHQWOzHTzrBUsPxrRs?=
 =?us-ascii?Q?gJgGxkACNQuWcKt4MUKssn4vcv8eK+pRq8hb3c+ZcpTk2S7FAOgHfYCAnRvh?=
 =?us-ascii?Q?o8RnpLslW5ps7lNBxhAcCS6TL8eWMoPCyQaWBqsNTMqaS4sjtT6jjPhonKbP?=
 =?us-ascii?Q?h8W9IM0ZplESPa73alMubQ4X9SpINklvtxpfnHrf4WS8WDbvhAACIMSnC4b3?=
 =?us-ascii?Q?6W/OBjGrW2At8tIu7/TqlhetStCnfEut/o5Fnin8QnbqA4lOHY/tw0ezgg/G?=
 =?us-ascii?Q?6qLPPVaE1FNsdKfokxgwsaMY833/iLdrH7XX7flLlG8g5nMxR/YAtrRFJ7lS?=
 =?us-ascii?Q?3zQm2UzgHWJfD1oot5ZBcdEM/OCDB2buqfatPKOruns6lNOgcoDiawIVACZD?=
 =?us-ascii?Q?lNTbFV3Rab6Mx7rzSa2W88//xrLGA+kTweQlunvdPJzs0Fa3h/G0rWOAe08X?=
 =?us-ascii?Q?v6cjRt1cad+47OIm/XkH60JN8R+vYPBoDkU1luWAPrFn3/LH4lzYW2UGoZCA?=
 =?us-ascii?Q?3NTdcEhHyi/PdJe5aQSFcfIvtTRRr6zO20/2lTr91VM5FJS/AXbZNgXCyJMU?=
 =?us-ascii?Q?G2GzfiXEH7jpZLH43zlc6sMbJOjPRmBtDt6A/CkDwX5sHV8Y9P7T+d6KXLd+?=
 =?us-ascii?Q?1+mJouVoVyvKfaK+oqsjZOe/9GlCn2tj8A5SW9G1z9agILu+e6O3rHms5jAV?=
 =?us-ascii?Q?zhPE2vyo81j9zY9KRNoyHlXGgnk4CwzC/+Y232vJcsf/7S+dls0K9Pshopfb?=
 =?us-ascii?Q?UuCnt5geJLOJW3dWpbyD8QxZZ+v4gOPJYp47MIudjqtUbJWeqSEf5hxpA68h?=
 =?us-ascii?Q?GiCW659hhvuikHDWk0p4NJxlenmD2kfcv8zKu3a6adG0I/RztBklyY2WYThF?=
 =?us-ascii?Q?SQ0TjtXQ7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94781d7d-78ca-4e17-851c-08df136207eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:46:27.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz6iJUvm0xg0oumEKq4D6CfBjR2RvXpk8aWZQ6Lx3Ur3OZd1LCnLYaH9m1rkwaEs/vyIuZ5xOFVtgu/CHAdmtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

The fair scheduling class can request lazy rescheduling, deferring an
in-kernel scheduling boundary until returning to user space or until the
next scheduler tick. sched_ext only exposes immediate preemption,
preventing BPF schedulers from making the same trade-off.

Add SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY. Both expire the
current sched_ext task slice but request lazy rescheduling. Immediate
preemption, WAIT and plain kicks take precedence when requests are
combined, while a lazy enqueue to a non-local DSQ retains the
head-insertion semantics of SCX_ENQ_PREEMPT.

Add SCX_OPS_LAZY_SLICE_EXPIRY as the default expiry policy for newly
enabled tasks and initialize it before ops.enable(). Add
scx_bpf_task_set_slice_expiry() so the owning scheduler can override the
policy per task from any callback while preserving sub-scheduler task
ownership boundaries. Bypass continues to force immediate expiry.

Restore the scheduler tick dependency before lazily rescheduling a task
whose infinite slice allowed a NO_HZ_FULL CPU to stop its tick.
Accumulate kick requests independently and resolve precedence while
holding the target rq lock. Reject unknown kick flags and invalid
SCX_KICK_IDLE combinations.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   8 +
 kernel/sched/ext/ext.c                        | 153 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  39 ++++-
 kernel/sched/ext/sub.c                        |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h      |  13 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |   3 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   6 +
 tools/sched_ext/include/scx/enums.autogen.h   |   2 +
 .../sched_ext/include/scx/enums_abi.autogen.h |   5 +-
 9 files changed, 204 insertions(+), 40 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8de69843c2150..685f1846aa386 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -249,6 +249,14 @@ struct sched_ext_entity {
 	 */
 	u64			dsq_vtime;
 
+	/*
+	 * If set, depletion of this task's slice at the scheduler tick requests
+	 * lazy instead of immediate rescheduling. Initialized from
+	 * %SCX_OPS_LAZY_SLICE_EXPIRY immediately before ops.enable() and may be
+	 * modified afterwards with scx_bpf_task_set_slice_expiry().
+	 */
+	bool			slice_expires_lazy;
+
 	/*
 	 * Out-of-band slice request from scx_bpf_task_set_slice() when the
 	 * caller does not hold the rq lock, applied under the rq lock at the
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4080902a528cd..83752c076094c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -383,11 +383,11 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 		return true;
 
 	/*
-	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
-	 * so allow it to avoid spuriously triggering reenq on a combined
+	 * The preemption flags clear $curr's slice if on SCX and kick dispatch,
+	 * so allow them to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
-	if (enq_flags & SCX_ENQ_PREEMPT) {
+	if (enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 		struct task_struct *curr = rq->curr;
 
 		/*
@@ -1515,6 +1515,24 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
+/*
+ * A task with an infinite slice may be running with its tick stopped. Lazy
+ * rescheduling doesn't send an IPI, so restore the tick dependency first to
+ * guarantee that the lazy request is promoted by a real scheduler tick.
+ */
+static void scx_resched_curr_lazy(struct rq *rq)
+{
+	if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
+		rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+		if (rq->clock_update_flags < RQCF_UPDATED)
+			update_rq_clock(rq);
+		update_other_load_avgs(rq);
+		sched_update_tick_dependency(rq);
+	}
+
+	resched_curr_lazy(rq);
+}
+
 static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 			      struct scx_dispatch_q *dsq, struct task_struct *p,
 			      u64 enq_flags)
@@ -1577,12 +1595,16 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+	if ((enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0)))
-			resched_curr(rq);
-		else
+		if (likely(scx_set_task_slice(rq->curr, 0))) {
+			if (enq_flags & SCX_ENQ_PREEMPT)
+				resched_curr(rq);
+			else
+				scx_resched_curr_lazy(rq);
+		} else {
 			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
+		}
 	}
 }
 
@@ -1672,7 +1694,7 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 			/* new task inserted at head - use fastpath */
 			if (dsq_insert_head(dsq, p) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
@@ -2386,7 +2408,7 @@ void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		dsq_insert_head(dst_dsq, p);
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -3804,8 +3826,14 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
 
-	if (!curr->scx.slice)
-		resched_curr(rq);
+	if (!curr->scx.slice) {
+		/* the slice can't be trusted while bypassing */
+		if (READ_ONCE(curr->scx.slice_expires_lazy) &&
+		    !scx_bypassing(sch, cpu_of(rq)))
+			scx_resched_curr_lazy(rq);
+		else
+			resched_curr(rq);
+	}
 }
 
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -3921,6 +3949,7 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 		weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
 
 	p->scx.weight = sched_weight_to_cgroup(weight);
+	p->scx.slice_expires_lazy = sch->ops.flags & SCX_OPS_LAZY_SLICE_EXPIRY;
 
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, enable, rq, p);
@@ -5371,6 +5400,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 
 		exit_dsq(scx_bypass_dsq(sch, cpu));
@@ -6883,6 +6913,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (!cpumask_empty(pcpu->cpus_to_preempt))
 		scx_dump_line(&ns, "  cpus_to_preempt: %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_preempt));
+	if (!cpumask_empty(pcpu->cpus_to_preempt_lazy))
+		scx_dump_line(&ns, "  preempt_lazy   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_preempt_lazy));
 	if (!cpumask_empty(pcpu->cpus_to_wait))
 		scx_dump_line(&ns, "  cpus_to_wait   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_wait));
@@ -7200,6 +7233,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		if (!zalloc_cpumask_var_node(&pcpu->cpus_to_kick, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_kick_if_idle, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt_lazy, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_wait, GFP_KERNEL, node)) {
 			ret = -ENOMEM;
 			goto err_free_pcpu;
@@ -7335,6 +7369,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 	}
 	for_each_possible_cpu(cpu) {
@@ -7953,7 +7988,7 @@ static bool bpf_scx_is_valid_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
-/* common to both forms: only scx.disallow is writable */
+/* common to both forms: only the fields below are writable */
 static int bpf_scx_btf_struct_access_common(const struct bpf_reg_state *reg,
 					    int off, int size)
 {
@@ -7964,7 +7999,6 @@ static int bpf_scx_btf_struct_access_common(const struct bpf_reg_state *reg,
 	    off >= offsetof(struct task_struct, scx.disallow) &&
 	    off + size <= offsetofend(struct task_struct, scx.disallow))
 		return SCALAR_VALUE;
-
 	return -EACCES;
 }
 
@@ -8459,13 +8493,23 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	struct rq_flags rf;
 	const struct sched_class *cur_class;
 	bool should_wait = false;
 	bool kickable;
-	unsigned long flags;
+	bool preempt, preempt_lazy, wait, immediate;
 
-	raw_spin_rq_lock_irqsave(rq, flags);
+	rq_lock_irqsave(rq, &rf);
 	cur_class = rq->curr->sched_class;
+	preempt = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt);
+	preempt_lazy = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt_lazy);
+	wait = cpumask_test_cpu(cpu, pcpu->cpus_to_wait);
+	/*
+	 * Immediate preemption, waiting and a plain kick take precedence over
+	 * lazy preemption. The lazy request still clears the slice, so all
+	 * accumulated requests are served.
+	 */
+	immediate = preempt || wait || cpumask_test_cpu(cpu, pcpu->cpus_to_kick);
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8479,19 +8523,23 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 		   !sched_class_above(cur_class, &ext_sched_class);
 
 	if (kickable && !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
-		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
+		if (preempt || preempt_lazy) {
 			if (cur_class == &ext_sched_class) {
 				u64 caps = scx_caps_for_preempt(pcpu->sch, rq, 0);
 
-				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps)))
+				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps))) {
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
-				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
+					/* degrade to a plain, immediate kick */
+					immediate = true;
+				} else if (unlikely(!scx_set_task_slice(rq->curr, 0))) {
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
+				}
 			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		}
 
-		if (cpumask_test_cpu(cpu, pcpu->cpus_to_wait)) {
+		if (wait) {
 			if (cur_class == &ext_sched_class) {
 				cpumask_set_cpu(cpu, this_scx->cpus_to_sync);
 				ksyncs[cpu] = rq->scx.kick_sync;
@@ -8500,17 +8548,21 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 		}
 
-		resched_curr(rq);
+		if (immediate)
+			resched_curr(rq);
+		else
+			scx_resched_curr_lazy(rq);
 	} else {
 		/* a kickable cpu was skipped solely for the missing caps */
 		if (kickable)
 			__scx_add_event(pcpu->sch, SCX_EV_SUB_KICK_DENIED, 1);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 	}
 
 	scx_rq_lock_drop(rq);
-	raw_spin_rq_unlock_irqrestore(rq, flags);
+	rq_unlock_irqrestore(rq, &rf);
 
 	return should_wait;
 }
@@ -8566,6 +8618,14 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 		}
 
+		/*
+		 * kick_one_cpu() clears the lazy bit of every cpu it visited
+		 * above; visit the remaining requests which contain lazy
+		 * preemption, see scx_kick_cpu().
+		 */
+		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
+			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
+
 		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
 			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
@@ -9531,6 +9591,31 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	return true;
 }
 
+/**
+ * scx_bpf_task_set_slice_expiry - Set task's slice expiry policy
+ * @p: task of interest
+ * @lazy: whether slice expiry should request lazy rescheduling
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Choose whether depletion of @p's slice at the scheduler tick requests lazy
+ * or immediate rescheduling. @p must be on the calling scheduler.
+ *
+ * Return %true on success, %false if @p is not on the calling scheduler.
+ */
+__bpf_kfunc bool scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy,
+					       const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
+		return false;
+
+	WRITE_ONCE(p->scx.slice_expires_lazy, lazy);
+	return true;
+}
+
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct scx_sched_pcpu *pcpu;
@@ -9539,6 +9624,16 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 
 	if (!scx_kf_allowed_ctx(sch))
 		return;
+	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
+			       SCX_KICK_PREEMPT_LAZY))) {
+		scx_error(sch, "invalid kick flags 0x%llx", flags);
+		return;
+	}
+	if (unlikely((flags & SCX_KICK_IDLE) &&
+		     (flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT)))) {
+		scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
+		return;
+	}
 
 	local_irq_save(irq_flags);
 
@@ -9564,9 +9659,6 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
-			scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
-
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
 				scx_rq_lock_drop(target_rq);
@@ -9578,12 +9670,15 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 		}
 		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 	} else {
-		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
-
+		/* Accumulate requests and resolve their precedence at delivery. */
 		if (flags & SCX_KICK_PREEMPT)
 			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
+		if (flags & SCX_KICK_PREEMPT_LAZY)
+			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		if (flags & SCX_KICK_WAIT)
 			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
+		if (!(flags & SCX_KICK_PREEMPT_LAZY))
+			cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
 	}
 
 	if (list_empty(&pcpu->to_kick_node))
@@ -9623,8 +9718,9 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
  * scheduler via scx_cid_to_cpu(). Caps are enforced on the delivery path: a
  * kick is dropped if the caller lacks baseline access on @cid, and a
- * %SCX_KICK_PREEMPT degrades to a plain reschedule if the caller lacks
- * %SCX_CAP_PREEMPT for a task outside its subtree.
+ * %SCX_KICK_PREEMPT or %SCX_KICK_PREEMPT_LAZY request degrades to a plain
+ * reschedule if the caller lacks %SCX_CAP_PREEMPT for a task outside its
+ * subtree.
  */
 __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
@@ -10691,6 +10787,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice_expiry, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e1eb3a0d456cb..d73b10d692d21 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, tasks default to requesting lazy rescheduling when their slice
+	 * runs out at the tick, the way fair.c expires a slice from update_curr().
+	 * The default is copied to p->scx.slice_expires_lazy immediately before
+	 * ops.enable(), after which scx_bpf_task_set_slice_expiry() may override
+	 * it per task.
+	 * A task in user space still reschedules on the way back from the tick; a
+	 * task in the kernel runs on to its next return to user space or to the
+	 * next tick, which promotes the request. No effect on kernels without
+	 * lazy preemption. Rescheduling while disabling stays immediate.
+	 */
+	SCX_OPS_LAZY_SLICE_EXPIRY	= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +236,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_LAZY_SLICE_EXPIRY,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1327,6 +1341,7 @@ struct scx_sched_pcpu {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_preempt_lazy;
 	cpumask_var_t		cpus_to_wait;
 	struct list_head	to_kick_node;
 
@@ -1407,15 +1422,16 @@ struct scx_sched_pnode {
  * the allocation pattern.
  *
  * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
- *            - kick the cid's cpu (except SCX_KICK_PREEMPT)
+ *            - kick the cid's cpu (except SCX_KICK_PREEMPT and
+ *              SCX_KICK_PREEMPT_LAZY)
  *
  * ENQ        insert any task onto the cid's local DSQ (implies ENQ_IMMED)
  *
  * PREEMPT    preempt any task running on the cid regardless of the owning
  *            sched (implies ENQ). Preempting a task in the sched's own subtree
  *            doesn't require any cap.
- *            - SCX_ENQ_PREEMPT inserts
- *            - SCX_KICK_PREEMPT kicks
+ *            - SCX_ENQ_PREEMPT and SCX_ENQ_PREEMPT_LAZY inserts
+ *            - SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY kicks
  *
  * PERF       control the cid's cpu power/perf management state, currently the
  *            cpufreq target set through scx_bpf_cidperf_set(). Hardware
@@ -1685,6 +1701,15 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * Like %SCX_ENQ_PREEMPT, but request lazy rescheduling. The current
+	 * task's slice is still cleared immediately so that the next scheduling
+	 * boundary observes the new ordering. %SCX_ENQ_PREEMPT takes precedence
+	 * if both are specified. Implies %SCX_ENQ_HEAD, which is all it means on
+	 * a non-local DSQ, as with %SCX_ENQ_PREEMPT.
+	 */
+	SCX_ENQ_PREEMPT_LAZY	= 1LLU << 35,
+
 	/*
 	 * Only allowed on local DSQs. Guarantees that the task either gets
 	 * on the CPU immediately and stays on it, or gets reenqueued back
@@ -1811,6 +1836,12 @@ enum scx_kick_flags {
 	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
+
+	/*
+	 * Like %SCX_KICK_PREEMPT, but request lazy rescheduling. If combined
+	 * with %SCX_KICK_PREEMPT or %SCX_KICK_WAIT, rescheduling is immediate.
+	 */
+	SCX_KICK_PREEMPT_LAZY	= 1LLU << 3,
 };
 
 enum scx_tg_flags {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 380a5653dc529..a88b87614b55e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -686,9 +686,10 @@ void scx_rescue_init(struct rq *rq)
  * rescue is enabled, or @rq's reject DSQ after recording the reenq reason on
  * @p.
  *
- * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT and %SCX_ENQ_HEAD are cleared when diverting
- * to rescue or reject. %SCX_ENQ_PREEMPT is also cleared on a fallback
- * migration-disabled admission.
+ * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT, %SCX_ENQ_PREEMPT_LAZY and %SCX_ENQ_HEAD
+ * are cleared when diverting to rescue or reject. %SCX_ENQ_PREEMPT and
+ * %SCX_ENQ_PREEMPT_LAZY are also cleared on a fallback migration-disabled
+ * admission.
  *
  * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
@@ -709,7 +710,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * On a remote activation the scheduling sched (@asch) differs from
 	 * @p's owner (@sch). Check caps against the scheduling sched.
 	 */
-	if (*enq_flags & SCX_ENQ_PREEMPT)
+	if (*enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		needed |= scx_caps_for_preempt(asch, rq, *enq_flags);
 	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
@@ -726,7 +727,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	if (unlikely(!scx_rq_online(rq) || is_migration_disabled(p) ||
 		     p->migration_pending)) {
 		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
-		*enq_flags &= ~SCX_ENQ_PREEMPT;
+		*enq_flags &= ~(SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY);
 		return &rq->scx.local_dsq;
 	}
 
@@ -735,8 +736,8 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY |
+			SCX_ENQ_HEAD | SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 6944221f96cc0..4a9bf1a4bb4a8 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -403,6 +403,19 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
+ * v7.4: scx_bpf_task_set_slice_expiry() added to enforce sub-scheduler task
+ * ownership. Preserve until v7.7.
+ */
+bool scx_bpf_task_set_slice_expiry___new(struct task_struct *p, bool lazy) __ksym __weak;
+
+static inline bool scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy)
+{
+	if (bpf_ksym_exists(scx_bpf_task_set_slice_expiry___new))
+		return scx_bpf_task_set_slice_expiry___new(p, lazy);
+	return false;
+}
+
 /*
  * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
  * will eventually deprecate scx_bpf_reenqueue_local().
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 63b6b14b19bd4..f1554c22071ff 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -85,6 +85,7 @@
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
 #define HAVE_SCX_ENQ_PREEMPT
+#define HAVE_SCX_ENQ_PREEMPT_LAZY
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
@@ -148,6 +149,7 @@
 #define HAVE_SCX_KF_ALLOW_SELECT_CPU
 #define HAVE_SCX_KICK_IDLE
 #define HAVE_SCX_KICK_PREEMPT
+#define HAVE_SCX_KICK_PREEMPT_LAZY
 #define HAVE_SCX_KICK_WAIT
 #define HAVE_SCX_OPI_BEGIN
 #define HAVE_SCX_OPI_NORMAL_BEGIN
@@ -164,6 +166,7 @@
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
+#define HAVE_SCX_OPS_LAZY_SLICE_EXPIRY
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..2cec24beb2d80 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -109,6 +109,9 @@ const volatile u64 __SCX_KICK_IDLE __weak;
 const volatile u64 __SCX_KICK_PREEMPT __weak;
 #define SCX_KICK_PREEMPT __SCX_KICK_PREEMPT
 
+const volatile u64 __SCX_KICK_PREEMPT_LAZY __weak;
+#define SCX_KICK_PREEMPT_LAZY __SCX_KICK_PREEMPT_LAZY
+
 const volatile u64 __SCX_KICK_WAIT __weak;
 #define SCX_KICK_WAIT __SCX_KICK_WAIT
 
@@ -121,6 +124,9 @@ const volatile u64 __SCX_ENQ_HEAD __weak;
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
+const volatile u64 __SCX_ENQ_PREEMPT_LAZY __weak;
+#define SCX_ENQ_PREEMPT_LAZY __SCX_ENQ_PREEMPT_LAZY
+
 const volatile u64 __SCX_ENQ_IMMED __weak;
 #define SCX_ENQ_IMMED __SCX_ENQ_IMMED
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index e616326545172..dd762ee0ddb36 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -40,10 +40,12 @@
 	SCX_ENUM_SET(skel, scx_ent_dsq_flags, SCX_TASK_DSQ_ON_PRIQ); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_WAIT); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index d53899764f5ac..672c02a497d14 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -97,6 +97,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_enq_flags", "SCX_ENQ_HEAD", 0x10000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_CPU_SELECTED", 0x100000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_PREEMPT", 0x100000000LLU },
+	{ "scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY", 0x800000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_IMMED", 0x200000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_RESCUE", 0x400000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_REENQ", 0x10000000000LLU },
@@ -160,6 +161,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_kf_allow_flags", "SCX_KF_ALLOW_SELECT_CPU", 0x20LLU },
 	{ "scx_kick_flags", "SCX_KICK_IDLE", 0x1LLU },
 	{ "scx_kick_flags", "SCX_KICK_PREEMPT", 0x2LLU },
+	{ "scx_kick_flags", "SCX_KICK_PREEMPT_LAZY", 0x8LLU },
 	{ "scx_kick_flags", "SCX_KICK_WAIT", 0x4LLU },
 	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
@@ -176,7 +178,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE", 0x40LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x1ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

