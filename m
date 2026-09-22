Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C6576EBD
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096142; cv=fail; b=RKjMwlvG1mOyYrHRSrs7p9bKhyPTyUxbREUSUtMXZNaH2ku0Was0P13BqnPPK+BiralCiaTOUYWrhoEQM/wg+qzNlvyBa2LPYy6LqQuylibG8lq2EhrH9ZVm1ySBvDStqj0Pr8DBOeHmIyaq/+BHDQTeWnlu2FzUe9WKV2xkRZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096142; c=relaxed/simple;
	bh=zVCgR6IngwhF5r303pk66mYtiMBahHVgj/ud2EsQWGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmT0t7vh5zyj5fOFXmfVpu9aF+xRHWKS8nAtyaYAN5lPHUvfWvV5iRi6Q/jDny9LeQ1mYqgV1fDtZK4lmBFwY5lG4bI+r3xUaLkXLzOvrPfWJSjsgY5x6Gg4tF95pVZRqA3CflpY6Y2EL1QdENy5WcZYYmRVMCfgFXe5qYgEesA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFm/m7dj; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFm/m7dj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc9Zidc4tpApdk/mEoDBeZQ7jLu9vLxM57fhCJZyoHo4nCeD/u9N0go3hEY62SWC/mfasIKoXMiIRDAUGZB/pQIbydZJyo1KDGYlY4mwqkY+v9E1IZ4aC3Q+vWLTlC0NZs/Lp+QNRkyzqzP8+YuItvE3puiwcyduligKAjYyaQhYJ1e+hRrebt4KqmJu/6evHL9Eagz10EB4DrcdDmSumvZHCX72dtLOfGqf0Ve366c+hYVC1TRYlLZOjsF8XySVK2rtLUJsrOXI7sHV/ZfiA87oqEaJhtJK2+yFwFSPsAbJNcBffhXizVLp8L/eqHHk2+qPXewwJSQGc23zZ7kfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je08prSC14mBI04B5t+uB9bnlNTDtKYoo2+u04UWtnY=;
 b=N0V0p5Cpc2P5vrYK+sMJ4NZiKIMe1bytOtEh9jaqXRltW89MRf/NUB1p8N404JsTwU0L3l8KpfWxAcsNsR3ldL3qv6xC77RLPISfNPS7ocsuryFQvsK9O0ACC0P1/m1PNB14NZHtKSFWyHm5/bZzZCle8D1iUXNJa8M8Tgt+pm2pMxgSgRFPtLebZdAkJMkS3+JXEDp7zHtxsT70oKMJH7RiEG6YEv6zLTegdYE3DNQXjRh5sVk1ACYyZw2vIQE3BhLnaJ3YRX4Ej7bpczu3G24s6ghrvJ7BjohZX0MP1pBpyJsF1Dex6TMse6Pu5wMaef21jP31kPjdyxKkTuAyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je08prSC14mBI04B5t+uB9bnlNTDtKYoo2+u04UWtnY=;
 b=fFm/m7djPjLzjouIHIgQr2R4BprTDKsjJrHYwM5qmF0wCohhV+NRLNfYDi/GP+GEPrAc+1uPgfVg1hlKfc/TVyMZt9LnfLp8ydj+FFM6E+NvXljBgQtyCKFclkPSk27qllRsayvE7fJVEVEcQSy1GlCvM0OPSpDSK7mf23Ao0p5HlwufTTvg45FQC96gsrDp+rpP2awCxPy9xIQVHCsu5D8ziHqRyPa2mBtVJuzLWJ12oRM147z+w3oyJ7sqKLZA9YzRnZnTtq3o6cv43U39t4+ZHruI8FZJmiWHWqGtVn2lUFvVDbR6aKfgG0LogQfRudwOV0yktIPIaxXjEIuyDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:30 +0000
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
Subject: [PATCH 09/16] sched_ext: Generalize the reject DSQ reenqueue path
Date: Tue, 22 Sep 2026 18:51:48 +0200
Message-ID: <20260922165445.943315-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 00321188-3e66-42cb-632a-08df18ca4f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nkx1SFcwnfHKNDUxCUrt/3YJxB5TcJOPSu8YxRPQCx/X4+RTH/n2xQpC8iqi8wTHZGmBEjj3Dr0pbB19wb0UQtaw7zjnsgPHZ7jQ4VSNBV0vxsEGm2Kk2W9fVUAm5ZrfBvk80Wf1x+u1I71JK1SaqSHJMkUnn2e/aTMXwGmvdG5bH9GYrHVnwjo16HKeiyZmyED26Hl5XHzasKFnPVYGk1fde+VaLbWDHcHQEU4qgjHYr4loBs8QQvAs12clKHXHdqsPvcXUix1ziVwuEBO/rXeR6Jo2rvDCYgPnhmanhVh4x9CecdwxH0/ceEsMm/mzpSDVd5VedIWEJ7sLmYTrkxl3p9LXRijmd4jENYrs8Au2Rn02xBJZHRsgoy8731Qh55PcRprCGnoH9hMwFL2LwtxWAZGCHUgo/KQGpyS9SHCmhkxCjiDsZ1qxbCGwyejA5OFRy4jUk38qGOZj08OroyPM8dfHXjnACYa2NlYJwdge8NVcNleZtLtw4sL2pFlFYFheDuyyum/++27MSyqvp3Udg7rhiy9e2zLKB89+aHgxolA3D9N+CpEUO+bQxRbVewAFgCPQbSjv7Y8C5Jbm677PGhy5cPg26ZXGuzMTqNPrI5za3LJlhAVfTAbkj1ZEP8paQOW1wWVxEPW0t6AN+bouQZd4BSkho88/zKMVA7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9ZKHMKxJns61WKb8XDSu28zafLVpAqFU6ahFbyyAEZlTCzQE08xgM7q99EB?=
 =?us-ascii?Q?YJqTU58KVMt162TnhvnQA7rKyD+cjw/qWyfJY9qJq0wr9kRHC6S8yTdXbpuO?=
 =?us-ascii?Q?8baEg1LZJW8YgtYxenVFddhgxxg5BxFihDfuGwDGO9DVY3cR5Yj3I1gP30yP?=
 =?us-ascii?Q?OxB1HzyWO0T+Wmll8BZy4kBOtHosbbjTLOi8S3KuJdQiMjhnL1UPQOPQyeAx?=
 =?us-ascii?Q?7gRkCPTq1ilT70lkkzC5JGTW46Q4/h/+SsigUTZsOAwE+LLEjjFyMT7xhG0p?=
 =?us-ascii?Q?yi2PfbPxnMgonOunRY++263k0gHywEzma1tPxuq59u0aVK8UKdwmG8p/tsey?=
 =?us-ascii?Q?PG5gy+GrYWzfJ2Ga7odN5wE0v1ndg4D5U5k8MQaGEa6UoRAMEKK7y3dUbrqR?=
 =?us-ascii?Q?pGSiJEq8vRfv3EZnWdiBfmNEYvVoX1FLdk75EnBLe4USJKDgWnxVhzFW7Ebz?=
 =?us-ascii?Q?AhrZeqQmcrQgyavJDeiH5GtkIzc9mzm/hNC9IIvyLzSePfohjlZN7zKVih58?=
 =?us-ascii?Q?gn+MFwiRvb20AD46brZxYlArWl71qtsH5aTEWq50lFD7F5e4JpynK8hzN3i5?=
 =?us-ascii?Q?9oZT2m1oonNC//cmp5bYfSDVqgWKNIKk0ktIMFRmRN6GG+qqulXGVKioOHuF?=
 =?us-ascii?Q?MnVcdYgHs3Kf7McYstiHDVKoxKgWPOVasuYJJaKR3cXm/ElrJRnDiHUXGBM7?=
 =?us-ascii?Q?nEWSln7TPuEDrbtwv6TDb8RLVaKIke0RgTh/ltpAiqI49+LQmPT7OQ3E0qMV?=
 =?us-ascii?Q?yIZ+js2y9xWcKvmHZBM89i3Ib507gmZYt2ljYxJMUPTDD2yl9MnoI28e2hvc?=
 =?us-ascii?Q?Wz9lnbOvazeK4l0mdkGPbLgyHuwQKv8BUkcQO6tt67ZJkPAQTVXuwqSkbSnY?=
 =?us-ascii?Q?sPVJNwbDd43mGh+QBxNiAYunG6qJ6Y8faSzc5+whCwrtroXHPY36BxKlCyZT?=
 =?us-ascii?Q?Z5BNZDocnim/fDrOoibUggi7T2yiam0VjN+nGgYDAXzwmxiOt4Q+3o479dVo?=
 =?us-ascii?Q?E9RzkUhJnGV5pfWAf2rdbzeUd351Yst5tegr0C+zZsxD37SjhIKWS9ooQ2FF?=
 =?us-ascii?Q?lgWAmXHvT3P57Z1xV7/LtoRtLu1L8TkDnqK6gzQH6P6zVNSRJMJsfPVtmABA?=
 =?us-ascii?Q?24OOOV4zf0CoiIj5ZCqFxw06lL1oLdEd7gLalRJvoHDPs5wk/eqiQDpxjqUh?=
 =?us-ascii?Q?aesn+e94y5sOpijwiqDPade1Q088M5xLaVKm2JIVgrbuEQs2Q1CJNi7vEqKU?=
 =?us-ascii?Q?jmBTGTJCqtAkRliZDqrvX322Zg7kLV1Toj3OqlU51YSgvV15+OxF6vGpVnEw?=
 =?us-ascii?Q?oFirOdxGbtNqz6fQq/GFTUTgBw3+9R6tSPcC+zjkOFnkx9Gb37O2qlC85oVv?=
 =?us-ascii?Q?wzg5+K0CD5wRf+BeXGEKSa2inTzpaeTNyb5+KdvlkexFgBtg2fiB7t6vSaNx?=
 =?us-ascii?Q?iRxXf0wtIkwY3WjpkM5clxw1vG422DCplsFPnR7Coib+voShGGBqajgvjnK6?=
 =?us-ascii?Q?4HfLLjHDP9WgD2XbWhMzh+x10Sme/U7UlWVc+EdX7bJIEBEaaZ1JqAPkq90+?=
 =?us-ascii?Q?voifKFqFPgspN/Bre8DExlVyTAPXPJ7Qz8x2f/KLt5YSsBJYtypt66n8vtLn?=
 =?us-ascii?Q?NCnpnf4yuYzT/ZqjCP/sIpH6f06z3ovl1AJQ9oq+PwDKSu+LjVLUxPLAKUUb?=
 =?us-ascii?Q?CKDj+X7oRNHNjk6FW98Z+hnU83JWy1I/rEThTBFX3kfSUnb0F7huG01rVhWF?=
 =?us-ascii?Q?KbbKLFb0Ww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00321188-3e66-42cb-632a-08df18ca4f61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:30.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25w/IFI9p8lcOLggPdBxvPhsLO6/DvFS/lnljOzlX4jl5IQY2k+bQalBodG3qUff1V+U+PCxzqxi3N1WEjZlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

The reject DSQ is currently specific to sub-scheduler cap failures. Its
storage and initialization depend on CONFIG_EXT_SUB_SCHED, and the drain
path assumes every rejected task was rejected for SCX_TASK_REENQ_CAP.

Other transient placement failures need the same ability to park a task
on its source rq and return it to the owning BPF scheduler. Make the
reject DSQ unconditional and carry the reenqueue reason directly in
p->scx.flags from the rejection site.

A reenqueue reason remains valid while ops.enqueue() runs so that BPF
can inspect it. Clear it immediately after the callback returns and
before resolving a direct dispatch. Paths which bypass ops.enqueue()
clear the reason before the kernel-selected placement. A rejection from
the new placement can therefore install its reason into a clear field.
Route all paths through a common cleanup point to enforce this ordering.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 91 +++++++++++++++++++++++-------------------
 kernel/sched/ext/sub.c |  2 +
 kernel/sched/sched.h   |  2 +-
 3 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 70832475cbf13..f16450dac6406 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1669,12 +1669,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = false;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
-	if (dsq->id == SCX_DSQ_LOCAL) {
+	if (dsq->id == SCX_DSQ_LOCAL)
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
-		is_rq_owned = true;
-	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
@@ -2054,6 +2052,12 @@ bool scx_rq_online(struct rq *rq)
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu)
 {
+	enum {
+		ENQ_ACTION_NONE,
+		ENQ_ACTION_DIRECT,
+		ENQ_ACTION_LOCAL_NOREFILL,
+		ENQ_ACTION_ENQUEUE,
+	} action = ENQ_ACTION_NONE;
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
@@ -2087,7 +2091,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
 				   "%s[%d] reenqueued %u times without running",
 				   p->comm, p->pid, p->scx.reenq_cnt);
-			return;
+			goto out;
 		}
 	}
 
@@ -2152,14 +2156,14 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * dequeue may be waiting. The store_release matches their load_acquire.
 	 */
 	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
-	return;
+	goto out;
 
 direct:
-	direct_dispatch(sch, p, enq_flags);
-	return;
+	action = ENQ_ACTION_DIRECT;
+	goto out;
 local_norefill:
-	scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0, enq_flags);
-	return;
+	action = ENQ_ACTION_LOCAL_NOREFILL;
+	goto out;
 local:
 	dsq = &rq->scx.local_dsq;
 	goto enqueue;
@@ -2171,9 +2175,27 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	goto enqueue;
 
 enqueue:
-	refill_task_slice_dfl(sch, p);
-	clear_direct_dispatch(p);
-	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
+	action = ENQ_ACTION_ENQUEUE;
+out:
+	/* The reason is input to ops.enqueue(), not to the resulting placement. */
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
+	switch (action) {
+	case ENQ_ACTION_DIRECT:
+		direct_dispatch(sch, p, enq_flags);
+		break;
+	case ENQ_ACTION_LOCAL_NOREFILL:
+		scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
+				     enq_flags);
+		break;
+	case ENQ_ACTION_ENQUEUE:
+		refill_task_slice_dfl(sch, p);
+		clear_direct_dispatch(p);
+		scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
+		break;
+	case ENQ_ACTION_NONE:
+		break;
+	}
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -2393,6 +2415,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	sub_nr_running(rq, 1);
 
 	scx_dispatch_dequeue(rq, p);
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 
 	/* see scx_task_slice_ended() for the save/restore exception */
 	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
@@ -3106,6 +3129,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		 */
 		ops_dequeue(rq, p, SCX_DEQ_CORE_SCHED_EXEC);
 		scx_dispatch_dequeue(rq, p);
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
@@ -3280,7 +3304,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			if (p->scx.flags & SCX_TASK_IMMED) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-				p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 			} else {
 				u64 enq_flags = 0;
 
@@ -4573,8 +4596,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 		scx_dispatch_dequeue(rq, p);
 
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
 		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
@@ -4585,7 +4607,6 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 		nr_enqueued++;
 	}
 
@@ -4697,14 +4718,11 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
 		p->scx.flags |= reason;
 
 		scx_do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-
 		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
 			scx_rq_lock_drop(locked_rq);
 			raw_spin_rq_unlock(locked_rq);
@@ -4766,14 +4784,14 @@ static void process_deferred_reenq_users(struct rq *rq)
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
@@ -4782,24 +4800,20 @@ static void scx_reenq_reject(struct rq *rq)
 
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
 		/* migration_pending tasks should have bypassed to local DSQ */
-		if (WARN_ON_ONCE(p->migration_pending))
-			continue;
+		WARN_ON_ONCE(p->migration_pending);
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_REENQ_REASON_MASK));
 
 		scx_dispatch_dequeue(rq, p);
 
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
-		p->scx.flags |= SCX_TASK_REENQ_CAP;
-
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
@@ -4807,13 +4821,8 @@ static void scx_reenq_reject(struct rq *rq)
 		list_del_init(&p->scx.dsq_list.node);
 
 		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	}
 }
-#else
-static void scx_reenq_reject(struct rq *rq) {}
-#endif
 
 static void run_deferred(struct rq *rq)
 {
@@ -8909,8 +8918,8 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(scx_init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(scx_init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+#ifdef CONFIG_EXT_SUB_SCHED
 		scx_rescue_init(rq);
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 893d7cdd88b4a..cab6ffaea1ab5 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -753,6 +753,8 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
+	p->scx.flags |= SCX_TASK_REENQ_CAP;
 
 	return &rq->scx.reject_dsq;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a096f23f4fbd0..f94522ef9b34c 100644
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

