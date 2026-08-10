Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F840DB35
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375022; cv=fail; b=XCt4p5hTEtwY3BaoTyF998BbIGWrtdX6TwL2mj4wrp0MiE8BQvBhJanNf9F0af41f4He2R5tXAiU+/AWi6AHyh9e4X2XNxq6NxodG0LKttWN49MGS8QCkZMya/nNEd5zGV3GzCthbznxon8PpJHR4LfqPYfe2K5IbLx5NrHQdw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375022; c=relaxed/simple;
	bh=b2P/6B9bXhPtC+KBvt75/CFvSiDnJilSQ3e7azHZP+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mf6L/qcKmrfI6vOR18QrckeRdhtm764Qi1uPKzu7PS+pujCpzX/mymKaLigL/g0mDwNduyudR9YSUruwbz4i6cD4OBV7+Xj4oSj0rR6UY/CO1YW2jvhKlMvt4Al61GFFPbQafWl1drgQCTweAqnwIYzaPCZ8qa92gbS15TMtclQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XkySRYfb; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XkySRYfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv/QFD6xObOcL6zp4niWl32d60B9hh7fs5VCOjR6HDWy0YamHTfbqjxXDbxFT2zUvHZ7O04I2CfvAsoBjEZW1543w/Ph5lP5tXtgKf03n/PqwBwjUNUHXZEx2ASa/nmUGKc6qaL16/9rn8EKJjBlvN8jXOB2ZqsoYbCmSbACQOGhG6OVVYMqb6raCUTQDN+icGgMraarJ14I12/ChXc095FmOXYMBSHN8OMC4E5ksEYw352iKpMM7dK52WgvNUuujnQu7xxscAQsMT8mGA5Jqy4cC3dwqRgoB8DC9B0rS64Ul/RokOOHzLGW8l7aQMpMBVDs4DWTblOkq2q6HsnMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HEM6ivS8pwtRLLKq0eT2ZqbzTMaHO55+GVC1zYS+Q=;
 b=c7bfHJzZqK8S5uis3EGMspgNUqN6b7WqmDK93rynMi9JfTGdrcKyNVj/aAtDVPEM00uEM9nGttluq/sY7NKCWyGoZsDKRIECoabK5Ms5ZilJfY65qFJs4WZRnICdW8GHaRVcJJ+K09psCDtRjJXuuRR30M7EStxgYKiEAYVhjrjhp+R2SpakA5UGH1uYVblIMEhAZKq0GVKKXqR8FVN7jexTbSW0gdpvllK8YYIwzJ35GiMHbQIKeZS9h66EocA0N1bQFJhSP/HLYSOkMncS8+LjCExcgmv92uXOUbm7cOOkKEkZxzjXOxK8SKjFmJElr84upOWBg7WGCqi/ViM//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HEM6ivS8pwtRLLKq0eT2ZqbzTMaHO55+GVC1zYS+Q=;
 b=XkySRYfbu3XIQTjOUsE/PE+Y7nZc9K6YH+em6UiJVlr4Z8yAABSCFUOI57990oCnFcwDTmAl2TVjSJjg2CnmG7d7t4eH2o9FaFX75lEMv3o5jGlp463IWorxdW4ifqR3HQrUCsjEVLlzpAigRU+DQx8bt+6iClu07Rr7z6kKQZ4gpsscnzQauLbIwTYT+6+mJAiq9gvDm53TAphojtJoiouqTqERzpJFOs4zzDfLESXTpw+HX3XCM2kEjVymyCru88PJSzT9Wbo4RJ5oW/mpEv412gIhjNv9iV9+Mof9vbeS/wRCkIoXvzipzGBkDXpV0M2F6baty1/x953SvpmldQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:53 +0000
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
Subject: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Mon, 10 Aug 2026 17:13:56 +0200
Message-ID: <20260810151523.86994-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d8e6e1-6a70-46fd-8525-08def6f268a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KQB3UA408w8PPfV1Ij1aVh5znJNS8rQXhpjSywsPS75s3gLMxSDffzXPGOsWms3xwIQDWsIp21d00Hu24q0yLBQdQRm4EySno+OwLSfpolxOFUsnix4cnapN9cRstu0IGb/FBvWp4TD5Ii1DCQAIX3vA3TXt8QFl/yxpK74K7/MZ2ji34cqkpBYyI5huD1+8FZauEOgLM+T8bWFOwg8Y4greRsuUY/DGcWpCV4MvvRadDf9L436K3uGCG++hFry0kRyJcSauqfIUGQVKdC7+oyicBJ1pPe8Kt+yPGAXZ4z0t1A2PLreVQnR08WEEx2d/YflHYQlBSWkWUICxrMO37bDJljfyoYZkiX9D1Pt0Gj6SxFxYn2DNTou6u08zuagxlVr47kJOfJOWDKIVK+F5ad24vFBPGAnICGWVyY1CzEinxQI7NcfyQbk4Pj5fqURXbmfkXke1xnVn8uqQf7bVtRM82+aRY9Y5r14wvnFLr0aT7CHny/F/wiAdO0q2PURTm4VYiOPsUXpFSLMTTzeuAs1K0CiR2FbcWYZmDvDFyxd8xUjdIdMpHGdGpaW/83NRHZ2bKDYcfZu8PyCoz+PVETJdZshX6/d5l6evXMg9ezmRYbgZW4PxNBKHEGHfnab9TqurIdZk2LbuQoz0Q0pOnOxxSwnkKmlP6U6FX8xuZD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AH9gdC3dd/Pp2uGwfwajXhhrO6wD2C3aOj5S9UAuFJYPW+ZbI1msSjQNDz1o?=
 =?us-ascii?Q?sR6CG8Z/GYoujehuih1BAa2wntoqM+v8SSc31A8h5pfix/3JkzY9nNEztWiA?=
 =?us-ascii?Q?4+5bOZDtf5dfpD9lISNrZ78XUj/c0FqrzRHtrYHKgyvsv1Satrsv26UKlVA+?=
 =?us-ascii?Q?FMB4ZRnz/L7YAi96FLHeuQwARmHBXpeSkQNZTf534nAQuAQ5y0mxPuSuuT77?=
 =?us-ascii?Q?y7CT4xgb251Wz3ziA4umzLnAvVQphJXtGvZff5u0Blt/FOLPcByWvUPVwq0g?=
 =?us-ascii?Q?UgPO/ICHGRglvffkOmIGGG1DSoQjdRLx9O9jQ9lKeKqNxbI2uMUxcdzgcvl5?=
 =?us-ascii?Q?/CMzXiDfpnWFph6I7j/Nqgkd1Z6Rflj4dIBrYzHOwSG8ABRVuas3r84f5HRt?=
 =?us-ascii?Q?PNaiuJSyanLnCsSIleZkiEV53Uua7Cv0Ec11kNuqiJF34s2Eaw/kriL2CBiv?=
 =?us-ascii?Q?q6VWo/Q4QMEyqqDbWG87xNfZ+L7NWu4q7zQ6VNLP7g9Y/ZYyH5mIVXKnDQSc?=
 =?us-ascii?Q?Dlpu2bCy0a40Cf0XYvubMOE4kZNmveiDNlynIBeJp6LAPbhMqTbpXcm0vbCF?=
 =?us-ascii?Q?niVrK6v5io1FT/5PkB1xdFhQ3ykwbak3guHaAGa4c0POQC3EJwNTwdvZEseV?=
 =?us-ascii?Q?7BRiWtfKQVB6DuN4nnCYMWyzTmEMsYVmv71DhnwDnBfgTYucIErdHFwSnw2J?=
 =?us-ascii?Q?c2h7CWnhYmE5TRTF2KrvhijQQ6PCDOQh65mP132FlICPfoTGOj48+bN6m1Fo?=
 =?us-ascii?Q?8ySzv1OUDhniUxD8ZMmhvp+K2al6o6Ont/GcKCW02/8WUb1DLb/eYHL2tVKk?=
 =?us-ascii?Q?yCFxhxGYC7V//HQW68wbNTgq13qkrRX/CW0q+KkByQITNdClb7ezbYouPXWh?=
 =?us-ascii?Q?Nm4nBliCqDw3h/sjzCAV+UREy3h98Jn1zrgfG66mRO8hMKCv+tdOUNfkxH64?=
 =?us-ascii?Q?OA/KY9n0LQzcHJOfkwyUtlWIzvkDkRt5f2kuU2TF56SVNql3qfvCWd7usuKw?=
 =?us-ascii?Q?d2pFRY9QhaXLhssVU4oKzPZi6cnPOP8l4oF8m8auuCoGySzUVMluk4q66lZf?=
 =?us-ascii?Q?fZqcPfuje4mqWfEtukwK4/R0WX/O/IuBGhZY+4JL7lOAFtFCVCBOUTHQZzV1?=
 =?us-ascii?Q?vt9NOJaPOmIJ1muqx13I2/f1Fxe3Hu1/YsgxBaQVFCl7/X45ftDkxNyj6mcD?=
 =?us-ascii?Q?NNEcLZtW95AOq79DXll/HH30h0zqI5AO8btkWRLaGnCU0vC9hqbOOF4/uUt7?=
 =?us-ascii?Q?Fh2hfpZ2O0ksgcteeQeA6coRNDFkhyalVvRO1tHNIaSdm0PDbofVG42BwaYK?=
 =?us-ascii?Q?TRrcN21Q74H4D95drZIhdFP27Bo/avnDthJsjcs9M54ZuvIw/UW8CZOnV+vp?=
 =?us-ascii?Q?Ie2WIyp/7AVXS/+81CfKty2S/Z13RdAauM+DnJzV8T+yWOfz5QthqEke34L1?=
 =?us-ascii?Q?/9pVtvB/ExGGvTYISJTGcOOpgTpnb2W5WwtNVVXjphx+86KQUjRFskIfSIYO?=
 =?us-ascii?Q?7JQDA5JlY1e3jZRGR5bZ1FuJEzHoRKIziwDfDG667h3KWJgAR2EeqGP8+rzW?=
 =?us-ascii?Q?0xmMZaMET9ripLEMj1VThVo/4uxFYir6+IcSJxwgGDnmwxXJicddQNrA2Tr5?=
 =?us-ascii?Q?pQP12dQx+bIp/8hNt+Dpommsw/D0iJ4paYe9/5kuRBriyxD1gMxuN+F9vh+Z?=
 =?us-ascii?Q?wd8BxNysebarKy4/EJv143B51Ogj92UdlXnQfuyfijmfJCUME1cacYoQUfmd?=
 =?us-ascii?Q?RyZg82dxGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d8e6e1-6a70-46fd-8525-08def6f268a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:53.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZm8+cBTp1SyROVuY0IxgCJebhXd2pJjPWh5yOf0TXUTmzrmCzSHijmTjiXVFZS0A2yEiaCT2YOZ9YyqOKK3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during an rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception: a task can start physically executing
as a lock owner while its scheduling context remains on a DSQ; its
on-CPU or migration-disabled state can therefore change without clearing
holding_cpu.

Recheck these states after acquiring the source rq lock. If the transfer
can no longer proceed, park the task on the source rq's reject DSQ and
re-enqueue it through its owning scheduler. This preserves the BPF
scheduler's placement policy and keeps descendant tasks within their
sub-scheduler's cap grants.

Implement the scx_proxy_resolved() hook to drain the parked tasks once
proxy resolution has settled and the outgoing owner has switched out.

Without this change and proxy execution enabled, stress-ng --pipeherd
can trigger this race and migrate an active execution context, leading
to sleeping-while-atomic warnings and subsequent lockdep corruption.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   2 +
 kernel/sched/ext/ext.c                        | 159 +++++++++++++++---
 kernel/sched/ext/internal.h                   |   8 +
 kernel/sched/ext/sub.c                        |   4 +-
 kernel/sched/sched.h                          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 6 files changed, 151 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index c34744c493885..3fe3364604aff 100644
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
index b43b2834141e6..7b467b666212b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1067,8 +1067,17 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+/*
+ * Proxy resolution happens before rq->curr is switched. Queue deferred work
+ * on the rq so that an outgoing proxy owner has cleared on_cpu by the time
+ * reject_dsq is drained.
+ */
 void scx_proxy_resolved(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_PROXY_REENQ)
+		schedule_deferred_locked(rq);
 }
 
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1564,12 +1573,18 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
-	 * Only local inserts get the wakeup treatment below. Rejects kick the
-	 * deferred reenq and rescue parks are paced by the rescue timer.
+	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
+	 * and rescuees remain parked until their respective resolution paths.
+	 * Other rejects can be reenqueued immediately.
 	 */
 	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
-		if (dsq->id == SCX_DSQ_REJECT)
-			schedule_deferred_locked(rq);
+		if (dsq->id == SCX_DSQ_REJECT) {
+			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
+			    SCX_TASK_REENQ_PROXY)
+				rq->scx.flags |= SCX_RQ_PROXY_REENQ;
+			else
+				schedule_deferred_locked(rq);
+		}
 		return;
 	}
 
@@ -2513,8 +2528,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
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
@@ -2522,11 +2539,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2573,6 +2585,60 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
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
+static bool task_move_proxy_raced(struct task_struct *p)
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
+	if (is_migration_disabled(p))
+		return true;
+
+	/* Don't move an active scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return true;
+
+	return false;
+}
+
+/*
+ * Park a task whose remote transfer raced with proxy execution. Reenqueueing
+ * from the source rq makes the task's owning scheduler choose its placement
+ * again and preserves sub-scheduler containment.
+ */
+static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
+			    struct task_struct *p, u64 enq_flags)
+{
+	lockdep_assert_rq_held(rq);
+	if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
+	p->scx.holding_cpu = -1;
+	p->scx.flags |= SCX_TASK_REENQ_PROXY;
+	scx_prepare_dsq_divert(p, &enq_flags);
+
+	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2630,6 +2696,20 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Proxy execution may have changed @p's running or
+		 * migration-disabled state while switching rq locks without
+		 * clearing holding_cpu. Park it on the source rq and let its
+		 * owning scheduler choose its placement again.
+		 */
+		if (unlikely(task_move_proxy_raced(p))) {
+			p->scx.dsq = NULL;
+			scx_reject_task(sch, src_rq, p,
+					enq_flags | SCX_ENQ_CLEAR_OPSS);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2660,6 +2740,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct scx_dispatch_q *dst_dsq)
 {
 	struct rq *src_rq = task_rq(p), *dst_rq;
+	bool proxy_raced;
 
 	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
 	lockdep_assert_held(&src_dsq->lock);
@@ -2667,6 +2748,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		proxy_raced = src_rq != dst_rq && task_move_proxy_raced(p);
+		if (unlikely(proxy_raced)) {
+			dispatch_dequeue_locked(p, src_dsq);
+			raw_spin_unlock(&src_dsq->lock);
+			scx_reject_task(sch, src_rq, p, enq_flags);
+			return src_rq;
+		}
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
@@ -2822,7 +2910,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		bool proxy_raced = src_rq != dst_rq && task_move_proxy_raced(p);
 		bool fallback = false;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2832,9 +2922,13 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
-		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			p->scx.holding_cpu = -1;
+		} else if (unlikely(proxy_raced)) {
+			fallback = true;
+			scx_reject_task(sch, src_rq, p, enq_flags);
+		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq,
+							       true))) {
 			fallback = true;
+			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, slice, vtime,
 					     enq_flags | SCX_ENQ_APPLY_SLICE |
@@ -4585,41 +4679,64 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked until proxy resolution schedules another drain after switch-out.
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler. The private list below prevents a task from being revisited in
- * the same round.
+ * scheduler.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	struct task_struct *p, *n;
+	bool proxy_pending = false;
 
 	lockdep_assert_rq_held(rq);
 
-	if (list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list)) {
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
 		return;
+	}
 
 	/*
-	 * Move tasks to a private list so a task re-rejected by
+	 * Move ready tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
 		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
 
-		/* migration_pending tasks should have bypassed to local DSQ */
-		WARN_ON_ONCE(p->migration_pending);
 		WARN_ON_ONCE(!reason);
 
+		/*
+		 * The affinity machinery owns placement while a migration is
+		 * pending and will dequeue and reactivate @p as necessary. Don't
+		 * return it to BPF in the meantime. This isn't a proxy-resolution
+		 * state and thus doesn't contribute to @proxy_pending.
+		 */
+		if (p->migration_pending) {
+			WARN_ON_ONCE(reason != SCX_TASK_REENQ_PROXY);
+			continue;
+		}
+
+		if (reason == SCX_TASK_REENQ_PROXY &&
+		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
+			proxy_pending = true;
+			continue;
+		}
+
 		scx_dispatch_dequeue(rq, p);
 		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
+	if (proxy_pending)
+		rq->scx.flags |= SCX_RQ_PROXY_REENQ;
+	else
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
+
 	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
 		list_del_init(&p->scx.dsq_list.node);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index c458a12c64574..f02b384d1fb0d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1752,6 +1752,14 @@ enum scx_enq_flags {
 	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
 };
 
+/* Strip priority and carried slice state when diverting from a local DSQ. */
+static inline void scx_prepare_dsq_divert(struct task_struct *p, u64 *enq_flags)
+{
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
+			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	p->scx.flags &= ~SCX_TASK_IMMED;
+}
+
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a04eccd837348..1266dcf446349 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -735,9 +735,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
-	p->scx.flags &= ~SCX_TASK_IMMED;
+	scx_prepare_dsq_divert(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
 	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aa8664e189aff..15fc7c4ab73f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -789,6 +789,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
+	SCX_RQ_PROXY_REENQ	= 1 << 9, /* proxy-rejected tasks need reenqueue */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c05d4b5729555..ec5e3fbc650fa 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -118,6 +118,7 @@
 #define HAVE_SCX_TASK_REENQ_IMMED
 #define HAVE_SCX_TASK_REENQ_PREEMPTED
 #define HAVE_SCX_TASK_REENQ_CAP
+#define HAVE_SCX_TASK_REENQ_PROXY
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
-- 
2.55.0

