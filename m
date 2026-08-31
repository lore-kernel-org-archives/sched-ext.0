Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46477538D95
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183930; cv=fail; b=aWELam03K/U0FXbLn5fHhVYoCB3sG68sgWA6tAVciFHssURS31Kb7Vk+pcQK99yWY4QqvokAqk+bARGbjoOOmoMG36OD3M6LSQL7qwCAG2aLo3/ZJ3ShPZ1NFUhiQbmykQquP8eSXIAGq470cX90aYOiqj+ep1/nxSmtzvq+zxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183930; c=relaxed/simple;
	bh=Qx34cOVYrwBbsJQCgVH/mSbXGKJ2MExstGB8vr+//wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dG5C38usCuyBrtpj1VnDQitkXKJRjrTTlMRlZxQd97UZ7KI/4I0lIOlLkGdgJgl8+w4/4IYmuyn6zzIx7u7Yy9XaCzlR8gkwbNDcX6TI7uLdg2ljJ1hHRAqd4H8GgkRnPJk5FY+5VTjEXtgrlM5T8NokmA+t0HwQWlwMn4kHIXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oczsnbNG; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oczsnbNG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfIyCYW8slZ3h0hC6ZVXiWvy0USSYr+XpKmSoJwUp9jn0hUOkVJQPpTZ3WyhFz4s+v5B/D5+0sTasjVI9a/ZQtm1dyTtAnHNO1yKW427fyKWKvuuK8UZ/dkuRB48GsA1dAo+YpHt7r4e4DUB+KOeFSo9+c3s+FBqxxBUYzGH+ZwkSz9SKXqEtJ4QfevidXgVsDrlVkccO4hwLLtnU4WciFwjzpiG9ATrY/UkcON0JCXogiDETaXaNs93h+sd8cnN7Zdyiai7GYEYDkIiIFw9djR/zOzuzv/WA2akdVuTOn5wKEalpyVM5+cV7eG30f3RoyKBg/GHGcEQ2ejZVt59OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi5iCZrbb9ZZ4FlCnTK45Vc1+K5Ff8gssVz6GgMdzfI=;
 b=Fm0yrzQyG1T0RFFM9ppa/T1/hEDOOC/+wATV1N1JmwPMHDBqwZPF6OCZvQGlP1WjSzSvGpuOL9ShJxs9mb0w/P3sxDw7wUmbsaPhxl8sJnmfRsK0FrlM0Lsnr1zUF5gWOk350Hzol7mQwHVWAQAtc+gQWaB07kiY7PyA1gYMK5sxkOnPLMRr/yWUc8xrAGXA1J27KFPt1VYhqMiiN2PL4NSgTktETep8FqE/KZR/T6bDgdl1o8cg9RsIz26WpOPYHQz2zHBc+cxdLzTTeO1iDE9/2eCZ8vZX2Aj0p7m67RzAM4T8TtP7Jrw/aKxFZB4qdk8lQgn8fsmtvpqvcmm2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi5iCZrbb9ZZ4FlCnTK45Vc1+K5Ff8gssVz6GgMdzfI=;
 b=oczsnbNGbajPOx9CWfThCBmgLbXEhFGalZrXQMxygykakLOPiTsD68VPMuIqKztEt8Iiti28BOnPgimgP+m1plbqfoGsS6IBm85I4AW7SymitloHxAJuuzaRZLCH//eeVJFRalZWZeYB99CfMpjY3+CvS/s8BrHAU7GWUAhHDIiHPzdKRDFlUA+Tr12RbYD0Ze995OWJoI5wK5u1ejWjaz/GrxQlcyxW9fwdZvkRq7sURvz9eKsAnTieDf9c97r/jNXBNWjwV+gj9jOxu0DjiEdowKnFiRGRyJKXsxejDxyjlJfXgYN3/jlsZ/L5Yop9AlZHXDTqdlv1OIRg4vRMAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:17 +0000
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
Subject: [PATCH 12/18] sched_ext: Generalize the reject DSQ reenqueue path
Date: Mon, 31 Aug 2026 15:42:22 +0200
Message-ID: <20260831134338.1531664-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0099.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 884c1e91-8282-4351-0f13-08df0766178d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I3sJGzmvPhuiUbF5vQKTYKRUL1sWpBqbYN8JevBgVFcilGUYG+0DbXhp3yH3xegopjEzP6V9NZ+FcIQg88yhjBdX9bmR30nHWW2+Y35ARbVhVv8iwRWY3pm3jqyrcN8YBdoimbFDBIePTMVuJAzf4IrzLxJQhIwvESbgzp5QRE+Eo9rMHm4ZKl7wgim06z9owXeFAMvhDQ35tuEe/rO9tOGzcJuomRimv8Q4ZzC5fjwvHaGxaD/RzbOiYZHRi59cfPdsHkiqv/1aMJumAg4cjUzrdU0j8ddJTDXmKCaXT7Nebnp5eOjF7cV8b1MrzucEDaWRafgKU61Ud+Dm7Tn02yrFSNGkqdDnf3zmwAm2CVrCq7n9Ku5hXy1ohtVwuAQvvLn31MZdg36ZeQnCMhMSfwyD04m+lTUI9X2zl7g3E1NTDJDQR8oGEBN8GI/RFSyWrxhl72bLkVUa/XVVIKf2iReCrkSu4KEr5cKuy8LW9Bu2SWrIHST0wTWM3f5s1yLEJdXKg6WuYCGpyJdU7s7HpjbqcDZ877EtCScOGVBAQ2UZeX0o1lZK8dpK3uL2udt1+eSK21+BdnOFCGivmnydIffDLGLrGYI51NXd+tX8z3M76QIjcSE9H7q11bOkf+MGqDr+QUqepcFqbBh6crVeCdSeb+RJbfmJ5voz0c/bfJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CeLlL9RjAk8yt7ak+oaIaeu466ces2AHt2NNNZZDwfdT6DxxGZL1STd3fj0p?=
 =?us-ascii?Q?zCaJcgWRIOUAnAsFwj72R5UZTgBAwpsJHkEakpLh+l5miOVHhwLxy5abjPEF?=
 =?us-ascii?Q?K4WzZLr/VtCe+P8E8tGeN222mvX0d8kKwOUssUp2GZkzAY0WKj5M+wnr1BlQ?=
 =?us-ascii?Q?nD22xTiy+vDPA4kWWJ+tDT18Eujku1FC0fKuHOyABcdeDR48iA3qcoj6LexV?=
 =?us-ascii?Q?1DM3QtVkK9qqSUX2yhcjy25832kAauWppzux1qfGGGrInNFQ/0ygFpcjPvoX?=
 =?us-ascii?Q?seJbeUXfXVknJA0hdCejZRH7xwLkAZxxUcHVsYasc3CO6zUKuR98jPt54aYe?=
 =?us-ascii?Q?oKOmq2QEmvLZO6gPu7SSMmjNn+NQfKSgTTsDzf+0sy439WEPtef0rviYSkNv?=
 =?us-ascii?Q?eyL+41wR7QDACgW2O6AEG/llXFi8X1tLebTVJppqT8vP9X5vtM0AKy+59nZw?=
 =?us-ascii?Q?rHRuEDE2V3JoMbPbDVPxK1uUISUH8V+83+ll7U9PceRzSBqkxWrG8b5oc5C6?=
 =?us-ascii?Q?Xjtpl242sXz7F9IQrVfkhQ5ZBt70qd3NW1rIRmJC7ZBIQjFBYDctRYrnI8cE?=
 =?us-ascii?Q?TrYnXqZi25E+kTJhYUr/v2cdrRPrLIYFudDrmYqLhBj0HB4xoYl05rzN/L6m?=
 =?us-ascii?Q?r9jniib0wqcM3vq/3q1tGKPP/qZ5tVaMyq8D+45JDrUdKOEyIG8nVtLiEMGJ?=
 =?us-ascii?Q?NcZrdPyGtn0rc0SaiAWWAA/Fu6oKdBIkxqyG4cbO1Ffv8VNK5esQpr/qMsOV?=
 =?us-ascii?Q?LuJkFqEDaOHlb2/TysRiAmSCcYRLJQ8yQqq+e/SGz4SdOADWi0NkDiC0kU15?=
 =?us-ascii?Q?EGQdyDnDMU7jk8LSmB5sFj33hB28x3DTFbDNSrj1QFQrXRA5Hx2mT9t0OnHL?=
 =?us-ascii?Q?ApbnKGDamwI7f5Z00JR9CdZ+ImHvVhLe11BZZ/gHXxZXXYwM1EI+fowoVCsC?=
 =?us-ascii?Q?nIri6Kl4mPUMclcTGZ0O8OAIzBkQL4WEpIxLIccqTzawQfx0sM5+o7l1DDvu?=
 =?us-ascii?Q?WDWuKiEwEFiOJU1BegFnWf1bLAxLttDm8mmNQ0QdyJJBQyX2/sKCzYtiI519?=
 =?us-ascii?Q?PZTS3/EZQ7ZNh/LCrSDYrK8+GhHT+mNem7xs+xqURegHzG3dE9Nhk8RfrVts?=
 =?us-ascii?Q?SpcLVDLnJJ7QeqyEC1PYu0sP/lMj9YMhNAJHEl22a+uXkpH30GIVnnMLbsJH?=
 =?us-ascii?Q?o+IpoNRQh/qT7XvdIHEHu8VqAFnTuoORafU600tFop4CWViKil9woK+N1j0Z?=
 =?us-ascii?Q?q3UXw5sxo05q2XD4NUrxhOD+tt9Ln0rFcg7lfE8gghYcbQu7HcSMC5NgPY1C?=
 =?us-ascii?Q?ebzCuHfmQq99eHUdfE7Ygrd+uVp60iItpnFC9Kd7EsE9xkSA2Gq5JhYmjaOr?=
 =?us-ascii?Q?bXajV3ZISHHWK/vZ3sQp6RDW7/D1snJTqIxLSq4boRWVRnspNuv0yDoHPGSJ?=
 =?us-ascii?Q?YLEZkF9JUl6TPX8sCxwVP1yDNABVSvv1hKKTDnwxWJupoi/HuzB8Qh0tpahT?=
 =?us-ascii?Q?u6m8Bc/ijOs5dPIobu/tA3Pm/YJEGh5B9JSbDWzpXw1iNV3/oI1lH8WLj7p4?=
 =?us-ascii?Q?k0U3Mz/di74bG8QagwYyalznwuGncmde8gah2usHEGwpNsTMCW4lvnNzQx6c?=
 =?us-ascii?Q?/HHEzx/7SN17xuPKwLcnLtQN1dUuiA/TUYr6FeeVpKHGSCg8z/YrFYiajFSZ?=
 =?us-ascii?Q?MC4y5XeqTkwzSCFoz0a7f7X3EOLYrSq1l24A3sX/R8DBiQBY6YJeJc5Eb1nL?=
 =?us-ascii?Q?es7+pxYTjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884c1e91-8282-4351-0f13-08df0766178d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:17.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXygyOYc0YGmvXIwoadCqT1Z6r1IBGEnUP+O2csnd0w+WXSdoKHGGyNO1T9X+azQp8G4pQrqdeA2NLeHXDJSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

The reject DSQ is currently specific to sub-scheduler cap failures. Its
storage and initialization depend on CONFIG_EXT_SUB_SCHED, and the drain
path assumes every rejected task was rejected for SCX_TASK_REENQ_CAP.

Other transient placement failures need the same ability to park a task
on its source rq and return it to the owning BPF scheduler. Make the
reject DSQ unconditional and carry the reenqueue reason directly in
p->scx.flags from the rejection site.

A reenqueue reason remains valid while ops.enqueue() runs so that BPF can
inspect it. Clear it immediately after the callback returns and before
resolving a direct dispatch. Paths which bypass ops.enqueue() clear the
reason before the kernel-selected placement. A rejection from the new
placement can therefore install its reason into a clear field.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 52 ++++++++++++++++++------------------------
 kernel/sched/ext/sub.c |  2 ++
 kernel/sched/sched.h   |  2 +-
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 967bf31a32754..2c5ae2811c77e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1599,11 +1599,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = false;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
-		is_rq_owned = true;
 	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
@@ -2017,6 +2016,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
 				   "%s[%d] reenqueued %u times without running",
 				   p->comm, p->pid, p->scx.reenq_cnt);
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 			return;
 		}
 	}
@@ -2067,6 +2067,8 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	SCX_CALL_OP_TASK(sch, enqueue, rq, p, enq_flags);
 
+	/* The reason is input to ops.enqueue(), not to the resulting placement. */
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
@@ -2085,9 +2087,11 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	return;
 
 direct:
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	direct_dispatch(sch, p, enq_flags);
 	return;
 local_norefill:
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0, enq_flags);
 	return;
 local:
@@ -2101,6 +2105,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	goto enqueue;
 
 enqueue:
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	refill_task_slice_dfl(sch, p);
 	clear_direct_dispatch(p);
 	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
@@ -2323,6 +2328,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	sub_nr_running(rq, 1);
 
 	scx_dispatch_dequeue(rq, p);
+	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 
 	/* see scx_task_slice_ended() for the save/restore exception */
 	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
@@ -3034,6 +3040,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		 */
 		ops_dequeue(rq, p, SCX_DEQ_CORE_SCHED_EXEC);
 		scx_dispatch_dequeue(rq, p);
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
@@ -3208,7 +3215,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			if (p->scx.flags & SCX_TASK_IMMED) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-				p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 			} else {
 				u64 enq_flags = 0;
 
@@ -4481,8 +4487,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 		scx_dispatch_dequeue(rq, p);
 
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
 		p->scx.flags |= reason;
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
@@ -4493,7 +4498,6 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 
-		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 		nr_enqueued++;
 	}
 
@@ -4605,14 +4609,11 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
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
@@ -4674,14 +4675,14 @@ static void process_deferred_reenq_users(struct rq *rq)
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
@@ -4690,24 +4691,20 @@ static void scx_reenq_reject(struct rq *rq)
 
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
 
@@ -4715,13 +4712,8 @@ static void scx_reenq_reject(struct rq *rq)
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
@@ -8780,8 +8772,8 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(scx_init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
-#ifdef CONFIG_EXT_SUB_SCHED
 		BUG_ON(scx_init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+#ifdef CONFIG_EXT_SUB_SCHED
 		scx_rescue_init(rq);
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a73593e828267..40a79028de8e6 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -752,6 +752,8 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
+	p->scx.flags |= SCX_TASK_REENQ_CAP;
 
 	return &rq->scx.reject_dsq;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f30d122909e7b..43f04989557b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -810,8 +810,8 @@ struct scx_rq_rescue {
 
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

