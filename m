Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67716386435
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321543; cv=fail; b=e/RjrHoDil5FIhSDjul6+j4BsZgfe/u+gixcmGyv8wY9cxMimqYtF5ZAfRMgJTrxoWmloOAHMNJ7BDxwaplpRwSpZjSQ79V7yE8qIyrwodIfoJEpSA/GAJ4KAQ3HGzYNCSgqLh1Qc9iucXapuhKIm8GMv2m6KJxycXiqizkplKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321543; c=relaxed/simple;
	bh=81Z7hRexs9KkTnJbrstZERSXKO27FWmwQMV3kEXG11s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7+wG86rFpGZvRPw8VKiz9ZLE3CFmRt0q+aTJmenrqXlxp6jWIbmtFcgg/DBO+2yCirNpwsVMyp/6pl5nepW4kkS7SWzv99cg4K+nYLBpB/SIUG3VeOoio/GK5IDz1o39o4GDs5Nc7uqqJ8Es379+o7ULOYI/IPtaKSu3FTzSqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2witPdV; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2witPdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8nIIoAg3Umz2x/nk3WMz5XqgBViQTD/n4NpwUFhUFGQhVPjNKCYoHGjNYp47xMt4N3IBTjV1D83yBr91nwLBixdSj/K1gKb0LrC9cvXBIz4eJZRKMhZGr+qcUhCUUVDbvFzuXHF94Uw1BUVenmtk7MmUeSdJylOjOK3GwZV/k3vsxhpOI/0uOfeJTkdsn9cF/qXErhN3Uaop373VrtC2Tqc0iIEXgkKk62w5p4+eTGIuVk4iYv+MrKcCLuJ4ojdSQnVXFeO30XKpGzsS9aM7h1GttUWnQDuIClikVVglDa7hy0qO+kWqBCCUbEJ1B/ZHekHTBcGj2AV/CMUWutNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La9a01SqTo9OAdYhScLzU//3On49/FA960b309RIruM=;
 b=kzSA/f9q+DuwWyV8oeXAGFz4AsFPK7CAk0oTNUfERdQFydG2er7SV3SMGZCrqnfsp37vzQ2gQrQfnkks/sMF3tMR9uFfqdl96LzWRe5cLg8Kg1CwDVjAcvdkR49COrm1t5Um4DwpUH0gztrBK3U4Cio96do2wj0GRn2fqbvRnYQtbByZchhJkZIwW7d77XuY60wyFvZPEvxXe6usQdKsnOlB4u7COK8qJfiPVA832vBcn1uwG9G893ZG4dnxYvLFX/6mqU+D35dStYexeP5oEeUXv1l+alhZGh4WYcVVmsLTQ3gBy3xrQGo3xFOVw4jwbVKMFWYMNaugYb3ba/av/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La9a01SqTo9OAdYhScLzU//3On49/FA960b309RIruM=;
 b=t2witPdVTOx3bU7ehN/VuF/A1tqif5O0dV9yqzgwCD2JPjdtLNnFwyETvw0tHAFeyrCfPQ9APYL87ag6LsL6LWED+TkpJQqDtlM9FsyDDlwh48s/feT0b5SW8kJ6+VLJ+LIOIAId1USqINrk7n0d4BOl6/TNTc1ktmNKiuRwdE1iu2KCbbFtGUmn6vs/rypVBf9mcPvawL3jiGCZBl1nFNRdI/rJNzp1hOgBuoOC3lVZRsnfm1UB78mA9cyYzYENJST7zcj98itSOEmKbpKvAa8MhOJzP25KJR/IXS+wdHIOKbncsPElFfyV8frBP1SKlKZaieE4pfloIAatYyY6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:05:04 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:05:04 +0000
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
Subject: [PATCH 6/9] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Mon,  6 Jul 2026 08:51:01 +0200
Message-ID: <20260706070410.282826-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077DC.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::41a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: e3757d0c-5bfe-4d76-d0a2-08dedb2ce772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QiLfFAIYfVqGhmpUrw2h7zPNU3lx6Gfam5bWKX/Qhv94IEZp/rcu/b6JVZktQe+igp5wUVf+IHjrV6b0TPG0nwLR4AGit3XIaHj+rUREQs0dDdVN6t17SMYLjpRpOe3eFJm/J9kmQjktXq7WrRtHGWah/BxjrrwtqLpjIMFZFKFU18Fgl5lyyTgkX56OLNrV9wahuIQJcTzy6tjAQMmvzIYFZ2JIAwY80N5NxaZz65fKEQRNXMngh0mRaaZcDTh+k0BbcIksEdwNfDBdKKSNsELOs8ivHGDeM/VSLuzJK2aQTCau5rsw+7RsFgTxAKzEllCZx4a3IoaAQl8OOke+UhgSFic2uk8H323d3UFmxb681I3Xu3bvZajge02djp/cEHuTeLHiPA1MVUSkfAVFT+gPce0PRcIbhLyJM/1RYColW57LUcZJKuy3/w8E4zEsdf7McimIWT5RT2LtDKA9JHvyem6BmCXOC2P/GmDIdT/GeQkhcLeoAlBMt/o+pFbxYdg8Ztjdt2P4x2oCRX5gEdUi5M5PM+NdDB/4rN1V2iaQlexMsVJHnu4jNM49ImwmU7WGaPugaooUMTc2nMfhgp09ZUH1NrD/g4rPzg2rdensMh/EkNAHbBoZ0+0qaIPD8A0QYH7AEfzHow/pYL3vw8nRPLaOl3Teus1kiKot1lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bs5Gd8quChtqB/0WzcmafIFAyqtBOMUD3i4UQmf2E0rfyMX0Rj+8Kiyttk+3?=
 =?us-ascii?Q?R3MnQrsvfTl6iM6166M6GpVOZu6FL+alDJufSuMAaroa1/a6qtwDOemZ/ZX7?=
 =?us-ascii?Q?CDAy0yyQpgc+uPZxd9maiAEBFHAYDMZHeDL+/oGJwC/NguT+F9pydvmd2vYd?=
 =?us-ascii?Q?WSphWIh9gxIib8ovOPSNgQD0prWMRtmkorBAAjZqza6gHRO6kv962IDMS9EA?=
 =?us-ascii?Q?3tpXczSP3HvUnj9qFBcYuuu+dWFf6H2dwWAPxcrM2hk9M9gIzcNWtj59PFyH?=
 =?us-ascii?Q?c6MQwU0TB0cfzsG72UYpJGbmiFpQepsE1hrVTmU9qY9N/l2YTdd89WZ6nHt8?=
 =?us-ascii?Q?Mg5odwJO1mJBtQHEoKvNYPWbFExhWTSTHGrzL16KZZp2PMJQ0DNSZY7cNwA3?=
 =?us-ascii?Q?Gs5zU/K5oZfJ6/tEYpcCc5hmCwK85EqeG6HUixEEbkmGKc2oFU+1iq1rGi/d?=
 =?us-ascii?Q?tGzxKv/dwc9IgsBcGOECIV4xMh/cWkM7h3IPh3E54YanhXQlIpixhziiLsTr?=
 =?us-ascii?Q?1AphBKVAOx7Oi5jMOP8R8bTrScsjWLHlFxuNVJqYwk7WldFyUJbykjXO/niw?=
 =?us-ascii?Q?oT1bldcp64hZncgzII074wtaF9aH0DUvyXG9YaTCywz/VODgjvEHnHIc6YXZ?=
 =?us-ascii?Q?tBaZ+GM2hRsK4L5r5Ycx4UzjCQOiTDhXqKFTdSQ6e976PZSRIJlveBC8ISSc?=
 =?us-ascii?Q?O+jvjPhjnJwSmDOPe8CbZBnwAl0E4TtI9m3KPvlBPJSRLNwyqto21XX3T/2P?=
 =?us-ascii?Q?GcP6EQixinm9lk+fGjGLgkwCqS9VyWpEY1I8D5nwX2OnSZARKNbysLrOqsnH?=
 =?us-ascii?Q?QVlIOgLUz+SLhlt+wDDFt3RhtUtsWY1cjGb7P/yxtqD/+Hqf1jAYwe12Z6/Q?=
 =?us-ascii?Q?xOy/5N3MMHIrlRAufrhTac0ZeHupguVn25TPKqm1WapQcyNRUCaFOoIa2qsz?=
 =?us-ascii?Q?XROR74HF8K1c7j0KUhxP2NScghPV86RHtxmD0/EaeqSIfHr5GieD163QFdtV?=
 =?us-ascii?Q?8Rwti4Dp/f/IjQIUi1tqxM2NIo9yvBWghBRRwAgNfLQ/5YVnE4Lvajinz3gt?=
 =?us-ascii?Q?GPhBHYF6EzRZ7O91Ygrdbzi7w/3+FFAr8daynpjPuyldDIfuPRzzqa5wh1Dn?=
 =?us-ascii?Q?SUPUlepZWzRFHFxNPOMI0lqMzOfu/TRwjo2ij9ZtAAPSMT8KU5Cwx0hxBAoh?=
 =?us-ascii?Q?Dq71qCFRyZydm2MUbgkNwBRYFDXAaU0/rV3csaPWyiMfnYIVkFgtIfkJY9lX?=
 =?us-ascii?Q?YI8xzd0wQeovTH1HzSiLrRarQp4WBid9quLVUedQih0Yy0P91TM9a7N79n4N?=
 =?us-ascii?Q?I/669YahyQWDoDS2XVyZCuGwXP0Tv+RABkZz0fugxsycWgCq9SAJXfehnc0O?=
 =?us-ascii?Q?uJOtf1+JIYdyFgjVcvMdpb8/Md4h4u66bnmsYGxA95xjsdG+CJK/sWDv7Ptt?=
 =?us-ascii?Q?hXRFh0T1sG0VGwXozFNBxpUG7tkEjcBjRN3Ba+2lZgiLcvukq0GF1zj9TMmX?=
 =?us-ascii?Q?SPu/ToDS8Si1ygTmPOCaHWF1UP+PIxkpxdnUqsTnoDaYM8vkYwlBF++LAsw5?=
 =?us-ascii?Q?zcDx0YMFAE/bG8RmYET/Jz957MarxeGsXiRirvcA6v3gsCOfvILc8eIIEQdE?=
 =?us-ascii?Q?oXXjbUOGYRB6XgnyMWgRgGmWKdDdPr7IL+iIENnWc+jtw40mp25xuZxR5z23?=
 =?us-ascii?Q?FeXM9lENmq0UrbKjMYgVbsyp4VGJjopgkMMClr4m8KmYzikDQ1xpTQ0+J3vZ?=
 =?us-ascii?Q?OkZf9P2ddQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3757d0c-5bfe-4d76-d0a2-08dedb2ce772
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:05:04.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHmyIO5TZ3T4r3GegkBmEjRzLRO+FOeO12vcr/K494RNpGDgT5rXshuRHv/OPDwYzMoN41dabsXrk5IH5DMBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Proxy execution keeps a blocked donor runnable so its scheduling context
can execute the mutex owner. Dispatching sched_ext donors on a local
DSQ bypasses the BPF scheduler ordering policy and can give donors
more CPU priority than intended to perform the proxy execution handoff.

Add SCX_OPS_ENQ_BLOCKED as an explicit proxy execution capability. Tasks
owned by schedulers without the flag block normally. Schedulers with the
flag receive blocked donors through ops.enqueue() with SCX_ENQ_BLOCKED
set in enq_flags and can apply their own admission policy.

From a high-level perspective, the resulting flow for a BPF scheduler
with SCX_OPS_ENQ_BLOCKED is:

    D ------ blocked on -----> M ------ owned by -----> O
 [donor]                    [mutex]                [owner]
    |
    | ops.enqueue(D, SCX_ENQ_BLOCKED)
    | BPF dispatches D to CPUi
    v
 +-----------------+
 | CPUi local DSQ  |
 +-------+---------+
         |
         | pick_next_task() selects D
         v
 +-----------------+
 |   proxy exec    | move D to O's rq
 +-------+---------+
         |
         | run O using D's scheduling context
         v
    rq->curr  = O
    rq->donor = D
         |
         | O releases M
         v
 +-----------------+
 |   proxy exec    | return D to CPUi via wakeup
 +-----------------+

Scheduler ownership can change after a donor has already blocked. Since
sched_change preserves queued state, deactivate retained donors before
moving them to a root or sub-scheduler without the flag. They remain on
the mutex wait path and wake normally when the mutex becomes available.

The donor starts associated with its original CPU. A BPF scheduler may
dispatch it directly into that CPU local DSQ to let the core resolve the
mutex owner and execute it with the donor scheduling context.

Although proxy execution does not require BPF to know the mutex owner's
location, scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() are
provided to allow BPF schedulers to determine the owner's CPU or cid and
make placement decisions, such as steering the donor toward the owner,
according to their scheduling policy. Provide __COMPAT wrappers which
return -EOPNOTSUPP when either kfunc is unavailable so schedulers remain
loadable on older kernels.

Reschedule a retained donor when its mutex wakes it so ops.dispatch()
can reconsider the now-unblocked task. Make SCX_OPS_ENQ_BLOCKED
override the exiting and migration-disabled enqueue fallbacks so
opted-in schedulers receive all eligible donor requests.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c                           |  58 ++++++++-
 kernel/sched/ext/ext.c                        | 112 +++++++++++++++---
 kernel/sched/ext/ext.h                        |   2 +
 kernel/sched/ext/internal.h                   |  25 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 kernel/sched/sched.h                          |   8 ++
 tools/sched_ext/include/scx/common.bpf.h      |   2 +
 tools/sched_ext/include/scx/compat.bpf.h      |  18 +++
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 12 files changed, 222 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0139cd4a8be7e..f3b6c3c952e69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,28 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
+ * drops it from the runqueue.
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!task_is_blocked(p) || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p))
+		proxy_resched_idle(rq);
+	block_task(rq, p, state);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
@@ -7006,6 +7028,39 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	proxy_migrate_task(rq, rf, p, owner_cpu);
 	return NULL;
 }
+
+int task_proxy_cpu(struct task_struct *p)
+{
+	struct task_struct *owner;
+	struct mutex *mutex;
+	int owner_cpu;
+
+	if (!task_is_blocked(p))
+		return -ENOENT;
+
+	mutex = READ_ONCE(p->blocked_on);
+	if (!mutex)
+		return -ENOENT;
+
+	guard(raw_spinlock)(&mutex->wait_lock);
+	guard(raw_spinlock)(&p->blocked_lock);
+
+	if (mutex != __get_task_blocked_on(p))
+		return -EAGAIN;
+
+	owner = __mutex_owner(mutex);
+	if (!owner)
+		return -ENOENT;
+	if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
+		return -EAGAIN;
+
+	owner_cpu = task_cpu(owner);
+	if (owner_cpu != task_cpu(p) &&
+	    (p->nr_cpus_allowed == 1 || is_migration_disabled(p)))
+		return -EOPNOTSUPP;
+
+	return owner_cpu;
+}
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
@@ -7136,7 +7191,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 85e07cbe626f6..a47ddbf741ea3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -23,6 +23,27 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	if (!task_on_scx(p))
+		return true;
+
+	return scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED;
+}
+
+/*
+ * Called immediately before sched_change_begin(). The caller must pass
+ * DEQUEUE_NOCLOCK so the rq clock is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
+{
+	update_rq_clock(task_rq(p));
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -1694,6 +1715,7 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1726,15 +1748,22 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      task_is_blocked(p);
+	if (enq_blocked)
+		enq_flags |= SCX_ENQ_BLOCKED;
+
 	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+	if (!enq_blocked && !(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
 	    unlikely(p->flags & PF_EXITING)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
 		goto local;
 	}
 
 	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+	if (!enq_blocked &&
+	    !(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
 	    is_migration_disabled(p)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
 		goto local;
@@ -2037,11 +2066,18 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
-	 */
-	if (p->sched_class == &ext_sched_class)
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
+	 */
+	if (p->sched_class == &ext_sched_class) {
+		if (p->is_blocked &&
+		    (scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED))
+			resched_curr(rq);
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2858,18 +2894,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
-		 *
-		 * Put the donor on the local DSQ directly so pick_next_task()
-		 * can still see it. find_proxy_task() will either run the chain
-		 * owner or deactivate the donor so the wakeup path can return it
-		 * and let BPF make a new dispatch decision once it is unblocked.
+		 * Mutex-blocked donors only stay queued when their BPF scheduler
+		 * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
 		 */
 		if (task_is_blocked(p)) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -6601,6 +6631,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -6950,6 +6985,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p, sch);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice = READ_ONCE(sch->slice_dfl);
@@ -9314,6 +9353,44 @@ __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 	return task_rq(p)->curr == p;
 }
 
+/**
+ * scx_bpf_task_proxy_cpu - Return the next proxy execution CPU
+ * @p: task of interest
+ *
+ * Return the CPU of the mutex owner toward which @p's scheduling context
+ * would next be migrated for proxy execution. The owner relationship can
+ * change after this function returns, so the result is only a scheduling
+ * hint. Returns a negative errno if no valid proxy destination is available.
+ */
+__bpf_kfunc s32 scx_bpf_task_proxy_cpu(struct task_struct *p)
+{
+	return task_proxy_cpu(p);
+}
+
+/**
+ * scx_bpf_task_proxy_cid - Return the next proxy execution cid
+ * @p: task of interest
+ *
+ * cid-addressed equivalent of scx_bpf_task_proxy_cpu(). Return the cid of the
+ * mutex owner toward which @p's scheduling context would next be migrated for
+ * proxy execution. The owner relationship can change after this function
+ * returns, so the result is only a scheduling hint. Returns a negative errno
+ * if no valid proxy destination or cid mapping is available.
+ */
+__bpf_kfunc s32 scx_bpf_task_proxy_cid(struct task_struct *p)
+{
+	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
+	s32 cpu;
+
+	cpu = task_proxy_cpu(p);
+	if (cpu < 0)
+		return cpu;
+	if (!tbl)
+		return -EINVAL;
+
+	return READ_ONCE(tbl[cpu]);
+}
+
 /**
  * scx_bpf_task_cpu - CPU a task is currently associated with
  * @p: task of interest
@@ -9617,6 +9694,8 @@ BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
@@ -9652,6 +9731,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  */
 BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_task_proxy_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..95aa0025c88e9 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -20,6 +20,7 @@ void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -54,6 +55,7 @@ static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index f9fe7c6ebc4be..e966860a3d2fc 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -212,6 +212,21 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler can
+	 * query the next mutex owner's CPU or cid with scx_bpf_task_proxy_cpu()
+	 * or scx_bpf_task_proxy_cid(). It controls when donors are dispatched and
+	 * whether they should preempt work on the owner's CPU.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -220,7 +235,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1339,6 +1355,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -1624,6 +1646,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0504204272732..0a5b84575ba5a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -117,7 +117,9 @@ static void scx_fail_parent(struct scx_sched *sch,
 		if (scx_task_on_sched(parent, p))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_sched(p, parent);
 		}
@@ -209,7 +211,9 @@ void scx_sub_disable(struct scx_sched *sch)
 			continue;
 		}
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p is initialized for $parent and still attached to
 			 * @sch. Disable and exit for @sch, switch over to
@@ -503,7 +507,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, sch);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba260..1e4872ab46848 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2470,6 +2470,14 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+int task_proxy_cpu(struct task_struct *p);
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline int task_proxy_cpu(struct task_struct *p) { return -EOPNOTSUPP; }
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index bd51986c4c42e..74d57b0aec39e 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -95,6 +95,8 @@ s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+s32 scx_bpf_task_proxy_cpu(struct task_struct *p) __ksym __weak;
+s32 scx_bpf_task_proxy_cid(struct task_struct *p) __ksym __weak;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 133058578668d..d25996163206a 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -133,6 +133,24 @@ static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__s
 		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
 }
 
+/*
+ * v7.3: scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() for querying
+ * the next proxy execution destination. Return -EOPNOTSUPP if unavailable.
+ */
+static inline s32 __COMPAT_scx_bpf_task_proxy_cpu(struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_proxy_cpu))
+		return scx_bpf_task_proxy_cpu(p);
+	return -EOPNOTSUPP;
+}
+
+static inline s32 __COMPAT_scx_bpf_task_proxy_cid(struct task_struct *p)
+{
+	if (bpf_ksym_exists(scx_bpf_task_proxy_cid))
+		return scx_bpf_task_proxy_cid(p);
+	return -EOPNOTSUPP;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 23d9ef3e4c9d2..8d5606e465080 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index da4b459820fdd..79b31eb7db7cb 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -55,6 +55,7 @@
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d2..7efe7b9346b49 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce3..f8fbeb7fbf95b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -47,6 +47,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

