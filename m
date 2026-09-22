Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7F572670
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096147; cv=fail; b=SefQ5J6j+M/KF7PenwFEAVV27SJWU47SSY2y69Xy5UXR17oQn/QstDvzziJl/mz/7Gwl1M0ZVeKRjICUH1/bJ9pbZkKjv+wRAC58bj1tCIbGGRi4YlPuUgx5dZaETQUsMPzx1GEhz6JCg1jiKcf1QiNQu6Bl43B0e1yOVZSEbII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096147; c=relaxed/simple;
	bh=QsbrUZhaNfTepj5h67jADLCKHMu9i9Dy1d4saRULagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOjZpSQf3Bzl78HQH203H7qUkF4nHgGBgbKnFUcGZlUX7IJzid5mLt4o4q25J9nOjaLwDDMVXGid7KZpIrr5OLk86lNMnyd068FfZeG72hcB/qThcseMSNDvPLyisGy9GT3LBBbcNBOvTtZrjnJoj39S3j5TbMiLUXl9vgXe/7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YtDppqCB; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YtDppqCB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3gOO13mPuF02EqWgmNa03bgPpsnsAInh4pEffmmrCTfL6ShZ8GQM/2cAShFpwSD27Sgg272YGHYDzFQuj1echVI4+YzJIQ7O614bNBo/hJXVwfhTppAuCONjiMgn9M4KeZwekp41VtMtfXPMfNgoXwSD2ChlZHBha+Fj4w/Epi9cPVg+0Do6ql3OpyWKBAcE/5Qq+sMwFADkfEYdynE/xXb42DpBuFEngZOY3u05UepwzGQZTt7m6lNunMSz8UPStqSQP3UK3VpL872wxD0b+v+J3QwF/r50dNg34F8JkL7daJkL87H5ptl0lIO0xHW1sVCrGzPCr2VjF5TUC1ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpQrq/WFXn8y9P1Yl29AWSJ6qHUXLCaWmdQlALPk020=;
 b=tZiCjoxOoifLseJ+E/y+XqxPUaGuO4XDjUt2QrCAKOqLUsn0njiXjaOMD33dvcl2cckHCwEkKAGiypW/yJMbWYq7nx1fEI0U/XoBXZKkvPtk/NQvtO4EGVdtAtSRAm62xxpTZqbe8QCTekvRdWbu/Kla7WgWW7qmGVvAS1dstchojdg/m7XbAvpqzmKQEsmALsUPqAazyB+L6QgyiHJJwmrLJKSzZD2n0UGOWehInoB/ZhkCNuEbuVCdKL0ZfHkMcTMVa6Y+ooPeCBV8tpFV6KeGAdD7PlnngCLcrKo3ZAbpvM+QvPdYz7n7WKTCR+SFctTeBtWDkHT3M2bmlO5HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpQrq/WFXn8y9P1Yl29AWSJ6qHUXLCaWmdQlALPk020=;
 b=YtDppqCBwCHgyimBlymP7juEvc3ftFuDSGUi0n2Z4osmozBWn98Zvruwp1HB3vHjLgtXzK8n0vDPdTrNesKs+1TEdxvDHdZ8mw1rzFtrebOFD3nBdz6NE7P4CAJluy8abuOyzEW6qBOS0e0f+5yhmencHSwz/9MGdmddPxKEfY+xqlrixa30tq/mi4u22X5UJdPsdxU1vPIgXIrnEWgyPwSQb/D0+Y7lVK0ikG9dcy8MpJqpQNqdhqe2ciR1L6yiZTZS8Tcg1Wgwvmv2w2IgXrcaRhQA51OI5Jkm8A9V8c8MX403itdx/EAwaST5hS1c1Z0UsUHObdTebCFKYz8Qeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:34 +0000
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
Subject: [PATCH 10/16] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Tue, 22 Sep 2026 18:51:49 +0200
Message-ID: <20260922165445.943315-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: a48c3bce-435e-4c2e-e0b1-08df18ca5176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fqFMMttodY+NSF1T+WiJO/cqitrQVwJg6Gs2nGFET+f3OvuOD8LRDHHSMx6GAYhJ8PqERQ/+QM0BgFzOys9+095EcCTpDWmWZ/kD0YBDgBsFCHZxlLLHdKCXKUfsSlRClXNZcU1ivyo5XDF54XmQGnNXAW65Y1zAKyofwH4UMgcP9+hxS70xfIsV3SyWrhJxrSTAzRaP1AVBg+0uwGxDvSTEFs9YhciqUP0CKpVNJfWXfWVgSPAUbOEuaOvNOXI72vTZlaAq2vgnZP8S4rW6Dte3QgozJ8TIWXyksACMI8twd4TvrnJwFYquF+4iG/LNU8vxC/siJti2s9jKp+CtT+kQrin5bOKAGpkdKSJujX1Yflq9jRGTzZqNH9Dg8qd+zp4paEYBgiXs4Nr0lqU6pgj4YhGbKjD7oV7rJ9vvulJ6oc9LsaMkdmL+wZJFye3Sl8bOuVWLMXvOKU/tn3Kz4v3gIeVYuKvv1dJrShySPJruVl0nnnAAuoUxfPQdFJtnHkEfpeuZ63t/IIjDD5XhXQf+CKh0dW13GPDEefYNJKbfmVbXSZN1Ds4xUA1YCdbBkSvyOdd1jtI3QdwqtHijLL1KPBPKx6rGf++IzGru9Z8ycK/jtVsGMRA3rP2XgfNCnXf8Rb7eH1jLTShAvkBTjqapTi1fzq52d5d8lQpSxtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6q2naOZtvTD+Vyu8Xh2txPIXAzpbyPaAgL1aoWLos1624kmLH7fpJ9463ZFD?=
 =?us-ascii?Q?73xwu0vzlbeUYP5rGKjJQiFZUiF9vYskrdpSLo+aw2Ns1WrmxJyv3PSICOim?=
 =?us-ascii?Q?lDz0Tm1jpqa8xVBrR1HDlzS2sqbNascfSzsEbxEBpVxgENvmftzUu6x+EJPA?=
 =?us-ascii?Q?2Ep/ds+MXVguD1tVFbl4Ix+F9Z4YsZdf83sjWVrcw5QaB2vZuLNq9GaXgfJ6?=
 =?us-ascii?Q?kBqrVhIWy9MjVB2Ofqifw3UA52dDDm8mfd9ZjSlZigDRwr4rfrYPWaDP9btB?=
 =?us-ascii?Q?6KXYAl3aZ718X3maHgVDL5C0HLnn14nEWMQoxrRcwzSWY7j4hw+JtiMe4xjQ?=
 =?us-ascii?Q?nTwjQSWNOnV8feZwI67+u2uYP9PQL1K1yXE86x45Xuzbeoa9QYOXjmPlqcMd?=
 =?us-ascii?Q?NAl0q6CPhI7lmqRo/+Kz1Kvs4ZFUDwKCsBJquXKIi4BkRiA6lvLGMOFzs/uA?=
 =?us-ascii?Q?erXZ6paW2lBRVCzY8ElUg+O2iWFD55haqNbn6vtvVFM+Ty/ziQgdVsB5tvvX?=
 =?us-ascii?Q?MmG/lLs971BT3bjbrH5urp/wzmKW2UoGu84OX1P2JgHrHONTkBsPcbW2Ub8H?=
 =?us-ascii?Q?dtPNBzCubhGqoujjAmJEzhb7EJE8EVNHg6RQ34C9gSBCO9qgIo84GdGqBwSF?=
 =?us-ascii?Q?JfmmBkZF3TZjzWLJu+bznmpbr/e3MOGXZbY/jelKDBN2LN66SkQxnfXPm0V6?=
 =?us-ascii?Q?+c4Py1tdTUmY0TcjXyMaR6SkQXlxfYY1o5Ie9XUF0ODRHW9wo8V9/8iO1mu8?=
 =?us-ascii?Q?E6BUc0v16mdEefidhfJKjekzKcAGmAkgbiTnmU/jOo3dLd8in1YhIQFkRhka?=
 =?us-ascii?Q?CEaxKkxaMGM06y89F0xTvwcy4rvW+q9DKO7OZlXuHvxw+yXyY9gBAHdlZX3C?=
 =?us-ascii?Q?8ry0bZkqLyu7aoICzkq7h2gIJjlxl9ocAekGkemBuhuWXlpyUU6ePKeaJW7/?=
 =?us-ascii?Q?YopKfY9IFVmWD5CKyIL7hVEXqio/quGkkNPxpyoZrrpA0H6m4GsPCEPinVwI?=
 =?us-ascii?Q?aDdvXBODyUF6cZUS4YqJbV94nzZin6r15jW3KND2Y2tBEirIdjpEFsDaGnJX?=
 =?us-ascii?Q?ZTAda8NXrnWKQ7rTuyj4rUdcODgz4ZvqqMVibq+0fdwnhbi2iJ2DKI3sOrei?=
 =?us-ascii?Q?gtzqmrhtn9Qcf1NqLMYD257fhJ+wRhl+VAlbsZ7C6cPr/2hvA3A6RaJf/uhc?=
 =?us-ascii?Q?d3+cwkPsaDWL53W4BcF3oe96dRtHBsz3uB14f8c04GfjTcBD/2sDWktuW33o?=
 =?us-ascii?Q?aFz0gqGRvFKQsPBRgie/U1XrLHOQ6lAMg6p/PcvWCtM5kKC09F79DElgYN32?=
 =?us-ascii?Q?n27M13nzX8ljBGkZvkseFtNibksPDa7mR5PHy7Gm0XPdChzQoPQJrCLWGCma?=
 =?us-ascii?Q?VtJG2d03JibN6nH7mSMNMIlppGtg00zVv9e8XwWrHaKnNs8jet9FtGbFEUuj?=
 =?us-ascii?Q?XX5isgg/fuhpopeDzabAeLgdWNosVC9pMXPflC12oFSrPidVqESXP5eBcJTw?=
 =?us-ascii?Q?edhhl4VkizxFGEcDgeDn+yJhIGlIOARaVou3uWW7sSk+asN9oIT94WNssdsA?=
 =?us-ascii?Q?VDWnsC5I56pH+VXLEZRoLUk7nDEU58RMGT+j2Rt4quvhd+CQ/su2zpJvpyCp?=
 =?us-ascii?Q?8Mx76nuIvR2drH52GV+hyAGCyb7bXcan/p+lZ9Rt8YfV12qEZtHVZ6lqdku8?=
 =?us-ascii?Q?UyBU5ln9oQM9kvm+LNbRBULAdrFn8vr2DsV91sAm6yY5H7n49NusfDE/VrNC?=
 =?us-ascii?Q?JqQmkZqbbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c3bce-435e-4c2e-e0b1-08df18ca5176
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:34.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXqhpOyo6rTjh7V2PZHFFfYwTzf1fTcmO+c9bnIR5KWKtSGmBmHhdTez8YzjJwpZZSK9kCxan65lqcM/ENa0BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during an rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception: a task can start physically executing
as a lock owner while its scheduling context remains on a DSQ; its
on-CPU or migration-disabled state can therefore change without
clearing holding_cpu.

Recheck these states after acquiring the source rq lock. If the transfer
can no longer proceed, park the task on the source rq's reject DSQ and
reenqueue it through its owning scheduler. This preserves the BPF
scheduler's placement policy and keeps descendant tasks within their
sub-scheduler's cap grants.

Queue a deferred drain for every rejection. If a drain finds a
proxy-rejected task still running or donating, leave it parked and
record a retry request on the rq. scx_proxy_reenqueue_retry() consumes
the request and schedules another drain when proxy state changes.

Without this change and proxy execution enabled, stress-ng --pipeherd
can trigger this race and migrate an active execution context, leading
to sleeping-while-atomic warnings and subsequent lockdep corruption.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   2 +
 kernel/sched/ext/ext.c                        | 145 +++++++++++++++---
 kernel/sched/ext/internal.h                   |   9 ++
 kernel/sched/ext/sub.c                        |   4 +-
 kernel/sched/sched.h                          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 6 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index b71dfdfb09f62..0395af1cbd3ad 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -137,6 +137,7 @@ enum scx_ent_flags {
 	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 * PREEMPTED	preempted while running
 	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
+	 * PROXY	proxy state prevented a remote DSQ transfer
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 3,
@@ -147,6 +148,7 @@ enum scx_ent_flags {
 	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_PROXY	= 5 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f16450dac6406..ea930d10cb383 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1130,8 +1130,17 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
-void scx_proxy_reenqueue_retry(struct rq *rq)
+/*
+ * Retry proxy-rejected tasks which couldn't be reenqueued by an earlier drain.
+ */
+void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next)
 {
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_PROXY_RETRY) {
+		rq->scx.flags &= ~SCX_RQ_PROXY_RETRY;
+		schedule_deferred_locked(rq);
+	}
 }
 
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1597,8 +1606,10 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
-	 * Only local inserts get the wakeup treatment below. Rejects kick the
-	 * deferred reenq and rescue parks are paced by the rescue timer.
+	 * Only local inserts get the wakeup treatment below. Rejects kick a
+	 * deferred reenq and rescue parks are paced by the rescue timer. Proxy
+	 * rejects which aren't ready when drained request a later retry from
+	 * scx_proxy_reenqueue_retry().
 	 */
 	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
 		if (dsq->id == SCX_DSQ_REJECT)
@@ -2560,8 +2571,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  *
- * The caller must ensure that @p and @rq are on different CPUs.
- * If enforce == true, caller must hold @p's rq lock.
+ * The caller must ensure that @p and @rq are on different CPUs. If @enforce is
+ * true, report violations attributable to BPF-directed migrations. The caller
+ * must hold @p's rq lock to avoid reporting a transient race as a scheduler
+ * error.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2569,11 +2582,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2620,6 +2628,64 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Proxy execution can change @p's execution and migration-disabled state
+ * without touching its DSQ entry or clearing holding_cpu. Check those states
+ * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
+ * sufficient and this must not affect the existing migration path.
+ *
+ * A BPF-directed transfer to a remote local DSQ performs a normal task
+ * migration and thus cannot move a migration-disabled task. In contrast,
+ * proxy_migrate_task() moves only a blocked donor's scheduling context towards
+ * the mutex owner and preserves its execution home in wake_cpu. The latter is
+ * therefore allowed even when the donor is migration-disabled.
+ */
+static bool task_proxy_running_or_donating(struct task_struct *p)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!sched_proxy_exec())
+		return false;
+
+	/* @p may be rq->curr under another task's scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return true;
+
+	/* Don't move an active scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return true;
+
+	return false;
+}
+
+static bool task_proxy_unsafe_to_move(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return task_proxy_running_or_donating(p) || is_migration_disabled(p);
+}
+
+/*
+ * Park a task whose remote transfer raced with proxy execution. Reenqueueing
+ * from the source rq makes the task's owning scheduler choose its placement
+ * again and preserves sub-scheduler containment.
+ */
+static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
+				  struct task_struct *p, u64 enq_flags)
+{
+	lockdep_assert_rq_held(rq);
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
+
+	p->scx.holding_cpu = -1;
+	p->scx.flags |= SCX_TASK_REENQ_PROXY;
+	scx_divert_strip_flags(p, &enq_flags);
+
+	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2677,6 +2743,19 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Proxy execution may have changed @p's running or
+		 * migration-disabled state while switching rq locks without
+		 * clearing holding_cpu. Park it on the source rq and let its
+		 * owning scheduler choose its placement again.
+		 */
+		if (unlikely(task_proxy_unsafe_to_move(p))) {
+			p->scx.dsq = NULL;
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2714,6 +2793,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		/*
+		 * Unlike the rq-lock handoff paths, @src_rq has been locked
+		 * throughout this operation. Only active proxy state can race the
+		 * move here; let the enforcing check below diagnose an ordinary
+		 * migration-disabled task.
+		 */
+		if (src_rq != dst_rq &&
+		    unlikely(task_proxy_running_or_donating(p))) {
+			dispatch_dequeue_locked(p, src_dsq);
+			raw_spin_unlock(&src_dsq->lock);
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags);
+			return src_rq;
+		}
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
@@ -2870,6 +2962,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
 		bool fallback = false;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2879,6 +2972,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
+		} else if (unlikely(task_proxy_unsafe_to_move(p))) {
+			fallback = true;
+			scx_proxy_reject_task(sch, src_rq, p, enq_flags);
 		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			p->scx.holding_cpu = -1;
 			fallback = true;
@@ -4785,13 +4881,13 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked and rearm the retry notification for a later proxy resolution.
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler. The private list below prevents a task from being revisited in
- * the same round.
+ * scheduler.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
@@ -4804,13 +4900,26 @@ static void scx_reenq_reject(struct rq *rq)
 		return;
 
 	/*
-	 * Move tasks to a private list so a task re-rejected by
+	 * Move ready tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
-		/* migration_pending tasks should have bypassed to local DSQ */
-		WARN_ON_ONCE(p->migration_pending);
-		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_REENQ_REASON_MASK));
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
+		WARN_ON_ONCE(!reason);
+
+		if (sched_proxy_exec() && reason == SCX_TASK_REENQ_PROXY) {
+			/* Affinity machinery will dequeue and reactivate @p. */
+			if (p->migration_pending)
+				continue;
+
+			if (task_on_cpu(rq, p) || task_current_donor(rq, p)) {
+				rq->scx.flags |= SCX_RQ_PROXY_RETRY;
+				continue;
+			}
+		} else {
+			WARN_ON_ONCE(p->migration_pending);
+		}
 
 		scx_dispatch_dequeue(rq, p);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 9e1eb1028eaf6..3320b280f0a6a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1777,6 +1777,15 @@ enum scx_enq_flags {
 	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
 };
 
+/* Strip priority and carried slice state when diverting from a local DSQ. */
+static inline void scx_divert_strip_flags(struct task_struct *p, u64 *enq_flags)
+{
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT |
+			SCX_ENQ_PREEMPT_LAZY | SCX_ENQ_HEAD |
+			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	p->scx.flags &= ~SCX_TASK_IMMED;
+}
+
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index cab6ffaea1ab5..9e46392023774 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -736,9 +736,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY |
-			SCX_ENQ_HEAD | SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
-	p->scx.flags &= ~SCX_TASK_IMMED;
+	scx_divert_strip_flags(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
 	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f94522ef9b34c..52c60a884994f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -788,6 +788,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
+	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index a6c1e36f83964..015eb6f400684 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -124,6 +124,7 @@
 #define HAVE_SCX_TASK_REENQ_IMMED
 #define HAVE_SCX_TASK_REENQ_PREEMPTED
 #define HAVE_SCX_TASK_REENQ_CAP
+#define HAVE_SCX_TASK_REENQ_PROXY
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
-- 
2.55.0

