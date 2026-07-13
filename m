Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C07419303
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959737; cv=fail; b=Ra2/SgmWrTG69AbuNHYP8Qv8q52N/voASWx1xLvg+7IqwgchOHS+IdLMVOrGLKaFmTMeWSrj63xuyw6RXmNCebcrQhBLdzNWTOPJiC3nbW/E1UNfdx7ce6bFgC10TgpdnuZNVpp9cI0fUxBvadBn8f9IsM54MnC+bn+pXm7zgnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959737; c=relaxed/simple;
	bh=KI65eEtq5uVgXPpnVSztMQ/T2IIHBBNsFQHJdKJFMAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQUBGEWHpxFdtEGSnW2q2FbNHmQq1ibFZeon03Vaiw+14ZyDhLWXK3Swds8DP1UOtwsuL3ay4ok2SioAnM86GLC2Ewhf28ym3zGjAgdaN4afKLjyWK/cabY5KDk9sO4YB4SW3zcE5xrXEHarPJXwEPd7B1e8d0t6eUUKbcgAyIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJRlhtSZ; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJRlhtSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHoIi74GGbh/dr8VQFf7tCMs3sVAI3chiAA3srWQPfDeV/+31ARpaDVqq6hvv8ES8KByG9m3BrHKMnRbwkQqN1d/DXArYKmuuzrL7XF7Jx6xwR2f6rv5OOhce/UUmu9yAvqDMi8B0nBNylT4Oa6fRd3OeFNZBF0yZAAOTIBwXnl8m3Of/kl2kHg9Zc2s8XwfmDFEafJD04+/A5BTCNsiqsir+sCyVCkFqaW7UQ00b9/1pH3ADkBvfuTXb/N4wSmJk4gdGMfLkc2PKU3+DGVTfO/aigFDd8cHMRT/wtOiihIq4gLdXyzUTS/KiIQeVoevK5TsTRy5p3VLAGL64ND6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tsZaGJfKpzEu4pNO8CenioNUV7drj4aUyc3E0AypQA=;
 b=FC4RGifGt3hEG5OVDTWv6MbVLGKLs/SZaDYhHJa6smVrVtABJl99wGPcIpflva1D0VSVTwuxbZlOsKb0dX4VKmEi2zOU56V3IRUQhx/yPpuOXk1IL+LW9BIqdDcyh5It9KMxQAHoY5BTmPYLv/bY/EReTGSeJfN84YyhZ50eR3coSPwiiqeRCFxBFIO4RGh+04mwobI3VHX1AetsSi0LhBBvgM0fCWC7pFgc8nMx+KZgGSMttfUweX9ioh0QJsT2S6O+FeEqn+jwc29or74WwvnR6YmQLUQGs9EPSF4St6FEZhnhT8wie+rsxYRbI/vGD8dKen0gUBtPFYEL4jbyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tsZaGJfKpzEu4pNO8CenioNUV7drj4aUyc3E0AypQA=;
 b=RJRlhtSZCAdCJRQ+H2invoAxYnQgNOPP+LqA9QQp/LdW/AFg5tUXeZ4SalwuCKqhRXtnJB3drJKf/LyQ+bD7aJPbnzf2kvoYEGEdqvVrt05knz1kXh5zs01PRl7i/qARcBCa2oqLAHcqF90KLofYxsDilEVr2mBys1YNw6WcqJqm3opSLGb7yzxSMPQagS17/bwuBpTkVzWLcMQ+O7r7beO9kVAWQCLMzEYc5C/Cx/PfKPFnoKrREB7qpIwQrBprCwu5znkGcsNLUXAuP78bFQnoXw0eGX8NFGZX4VwCbL+AaUuQahR1VdqihvxYVB56ZGX6hKafRRFeHmAj6U5KNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:22:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:22:06 +0000
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
Subject: [PATCH 07/10] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Mon, 13 Jul 2026 18:17:07 +0200
Message-ID: <20260713162112.26785-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3970ccf8-74c4-4e3c-39fa-08dee0fae10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|3023799007|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	wNBpIagmkndL/ahiTJKzPJFCQ3xi2ynbIWh1mc+Ab5qBKQaH/6dKEBjyijKg+PZT1/HLJptxFLL0Fhznn5Bv+0/367SoO6NM23ZgTf5XqQzlLhK1jNqb57cZTFKPnwmYjdJP2caSHIPkYv0bCXinILYUUA4qxeBPNbx2pUIPAj14LCSZsXFnsIAN5Jor9lEgCr8N9ExUPWbk2oFmm1XjLd3T3OCxBXDS42G7Z85C9ifGYdiKZ2LMvBhQwIErjttfq0sWggIPw33ILUKRxSG4GMVMynCs/X8eAo78X5ryLKGS87uypwcf5b7GZULAX2Wyabc1YrAJFEyvR+tw+jHBE/B15rnwCYuKR1vuRc5id4al/gBtFcNcl/DPwbBUp+voGfHFV6BvxJd4F37CzreAk/XbYM5Ty/byuXJr+0DeoUSL44KF0UtdLtBfOn7XUojPzsGh/wU0/uPyvKo17O+NGDulnasFSGSonkuE5CmjSvXRhmJn23+Xtddq/wkqM5XRITwOn/oRM5s01JT5sw4WNwIh6FSVkwWWWvZXAl2EVBOBs2M84IXi5vp0jsMye2S2YAQYXThClwWYYZDa9tDiOg3D07N/KXaCXVc1GLpu38mkiS+sZPlTR5XKmrA+VR/btomWHcjcmQ5rQ12bNKEb47B9EnFgOodmpiMe0Da1udo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QexJqE63sRDRzKXkbCFZs4mwZeW2OTKN05hLDmQ5Ai4dqlDLNXawHbn9344r?=
 =?us-ascii?Q?Axt8cVg8qYJhup4YV5K3cSTjPoodAHGWV5bgXZ52e3pZGLgnm2fR/jlpuXPK?=
 =?us-ascii?Q?Zct4nFnq8e9zBb6qs65JOlg2yvGsWwDmn2iCKwbjRqZr4GUYBhw2XLagZjtU?=
 =?us-ascii?Q?shk48nplAF7raxd4h86Eit8XeCzdK1ZA0mjKfSxXL3ontvs+Vpfvi5Jq8wTt?=
 =?us-ascii?Q?IerLbaYb5A8iYPIZCkFFY08oJNB9ErF9GZcTe2eef1u0zUX0WGX2QlabLT3s?=
 =?us-ascii?Q?ZrB+pMjHMkKmZgyzmJzo/cAFqwGetTkMl809txxDaPspsIZKzXbE35fTpJdX?=
 =?us-ascii?Q?Tat18B/r2KvF8LWnaW+aW4e9uPRpl1YnfXnxZBVo8D1u8F9+umVe6erfAnah?=
 =?us-ascii?Q?lYHgXqxC4LZQ2S3GXlwp2i3zNjYGWQu1RADohP7SRlfL2q9UT5E07OM7viod?=
 =?us-ascii?Q?tIhHNqWbxla5pauE/DMXFoFRI/iFPxieSoNjb+XCAe9onnLRYz4lMthY1ELh?=
 =?us-ascii?Q?3Kxug57+CUS2i0nacdJMRSIsjtQHeAhjLKPWaHqKuRGn0iHbQAQFpL0H+VTL?=
 =?us-ascii?Q?1ABYgCG/xOc5w4/5WfzuTXH7/Yh8LkCUoE0o4KAgVwtgE8vwc6gDQtow6/Sj?=
 =?us-ascii?Q?PrhzXdG6R+nkPBy7a31BEaO6rEtxmgnn+U3SP84E+nVyTuCLwZm2F0kKNO/Y?=
 =?us-ascii?Q?lhWljCbqLC+zQ+0PWh06LUh3aXTQ9LvSue/kqcAxPyOVZbn8Hn2h2E4lRHLX?=
 =?us-ascii?Q?KmVSz1H5gXQvjjqQlnWs3Htd7DhbFz+6yw4ZWJIoMrkh7LH1svIF8U2LMdUy?=
 =?us-ascii?Q?ElYUmtTW6avwb5B6aInV13xhBarU2aqapjaDBaXQyurRXqRoKAksxKg/17Tt?=
 =?us-ascii?Q?E4lw5pIbVkdGlA/+knDP2E1RFSaINK/PcJscQcy740pY6xUGoH+YjTk/+Bzn?=
 =?us-ascii?Q?fIQt3iGrn+fYmPc8tgphvEvpMVUXH9X6wAYuJJRxEYPfxkhT+YKmJzLoqzhG?=
 =?us-ascii?Q?UuZIn0zmSBZdLbmOZFjhSspRfzDAtJZTcWMfZigMWHkMMbnPvBdV49Ew985j?=
 =?us-ascii?Q?l3hH7YuKn2erEKpTn4ojLSrJW0EVbjCexhUhOk3T4Ry8bEFzzgRylDbITofS?=
 =?us-ascii?Q?bvYojwkLW6IHUNglOnWN7GVMOfWBi08Xb4i2+gb0ekweChi9fEufNs6cDS92?=
 =?us-ascii?Q?1cSDqZqyU0f5xvjTRdMgj4c3etg3jw8+EvU/53jhrESc8CMwYI/tZoCaNMFL?=
 =?us-ascii?Q?ZDRgGIla6CrsHCNONAkcu4WXU81vZghmEtI7sksUOaqvwcMK4dy3/VdjUcVF?=
 =?us-ascii?Q?5IGDX9FXW0nEk5AGNiD7p4E5ff6xTnTDhmbNsWVrmIQruoMU1EA21jqn76hs?=
 =?us-ascii?Q?3ATze5N9ObPkhS+EyjkA/XGfS6KYKKxskoDqkd2S6+UEv1JQBmQab6mZXyzA?=
 =?us-ascii?Q?ICPPidtzqKjGAjcickmRnfFo6gOiW5C8K57oqIYRc1HiA64aBGlOQJrIxnwX?=
 =?us-ascii?Q?S4btEEkOgwi0zuMJywOhoIi0TJcemQwrcaNxrPX4lNPuWhL3kdJwD053bpRz?=
 =?us-ascii?Q?fOGqeV5tVg1fV94HpMl6BSs0EsjEPJ93Yz4JbqxAygRJdpoJ9j16upAjXngk?=
 =?us-ascii?Q?UwUDp6Tm91pTxFS3XgtCGmhORSOgfaU8BpZiHy9f1dGTpH38yD+TT2MtuEp2?=
 =?us-ascii?Q?pjvtVXzJK8kMQS7SMY3ncrL1zTiOiaxqwtbgxek67afsDKftChqmGAFm8OAT?=
 =?us-ascii?Q?ARWHMahRXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3970ccf8-74c4-4e3c-39fa-08dee0fae10c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:22:06.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2ucIoJVKNeuSTu4liKuT6aoOYwGg5hArsoEhlmvbl+z/FsEzrWlizcaYlSHI0ZYk1eS+z1a0NInEGxB+WjkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

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

A proxy migration preserves the donor's wake_cpu while moving its
scheduling context to the owner's rq, so task_cpu() differs from wake_cpu
until the donor wakes. Prevent BPF-directed migrations from pulling a
blocked donor off this proxy rq. Otherwise each blocked re-enqueue may
move the donor back to its callback rq only for proxy execution to move
it to the owner again.

Scheduler ownership can change after a donor has already blocked. Since
sched_change preserves queued state, handle both iterator-driven moves
to root or sub-schedulers and sched_setscheduler() transitions into EXT.
Before entering a scheduler without the flag, deactivate the retained
donor. It remains on the mutex wait path and wakes normally when the
mutex becomes available.

The global sched_ext enable state can change while __schedule() holds
the runqueue lock. Once an EXT task has an assigned scheduler, consult
it directly so the task cannot retain a donor during the transition
unless the scheduler opted in. Tasks without an assigned scheduler keep
the generic proxy execution behavior.

The preparation helpers require and assert that p->pi_lock and p's rq
lock are held before updating rq state.

The donor starts associated with its original CPU. A BPF scheduler may
dispatch it directly into that CPU local DSQ to let the core resolve the
mutex owner and execute it with the donor scheduling context.

Reschedule a retained donor when its mutex wakes it so ops.dispatch()
can reconsider the now-unblocked task. Make SCX_OPS_ENQ_BLOCKED
override the exiting and migration-disabled enqueue fallbacks so
opted-in schedulers receive all eligible donor requests.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                        | 107 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 7 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 578929dc40e9c..d15ae141fe2bc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -25,7 +25,18 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
 /*
@@ -35,13 +46,38 @@ bool scx_allow_proxy_exec(const struct task_struct *p)
 void scx_prepare_setscheduler(struct task_struct *p,
 			      const struct sched_class *next_class)
 {
+	struct scx_sched *sch;
+
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
 	if (p->sched_class == next_class || next_class != &ext_sched_class)
 		return;
 
-	sched_proxy_block_task(task_rq(p), p);
+	sch = scx_task_sched(p);
+	if (WARN_ON_ONCE(!sch))
+		return;
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
+}
+
+/*
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -1726,6 +1762,7 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1758,15 +1795,22 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      p->is_blocked;
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
@@ -2069,11 +2113,21 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
 	 */
-	if (p->sched_class == &ext_sched_class)
+	if (p->sched_class == &ext_sched_class) {
+		if (p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2194,15 +2248,23 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	/*
 	 * A blocked donor may be moved normally to select a new callback rq.
 	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
-	 * callback home, even if the donor was previously proxy-migrated.
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
 	 *
 	 * Don't move an active donor while the source rq still references it for
 	 * scheduling and accounting. The migration can be retried after the donor
 	 * is switched out.
 	 */
-	if (p->is_blocked &&
-	    rcu_access_pointer(task_rq(p)->donor) == p)
-		return false;
+	if (p->is_blocked) {
+		if (task_cpu(p) != p->wake_cpu)
+			return false;
+		if (rcu_access_pointer(task_rq(p)->donor) == p)
+			return false;
+	}
 
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
@@ -2887,18 +2949,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
 		if (p->is_blocked) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -6652,6 +6708,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7001,6 +7062,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p, sch);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice = READ_ONCE(sch->slice_dfl);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5ca44ad887864..8ac195934f63b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -212,6 +212,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
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
@@ -220,7 +233,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1339,6 +1353,12 @@ enum scx_enq_flags {
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
 
@@ -1624,6 +1644,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index ce76ae141e0a9..954aef5950e95 100644
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

