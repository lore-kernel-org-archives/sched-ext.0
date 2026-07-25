Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609830D414
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995585; cv=fail; b=twq5WzD47dr5juhsBpXMGNTNK0cAicd1lDaACBqh9cDfnS2HpbIJsGvXJuY2Ik1HkYEwlwHAQL982X/+6FVZM0qPLs2UczZxfkN4L5rF3KDZW9+5y1m2u7OlG0k9gZoEAuxBTmMLBkliddjIwijxRKKGmgFqtCL3376stjdjMBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995585; c=relaxed/simple;
	bh=cI8QffIPnPkWg4JJqYtZZAuNpWsH6VpfCJeCypG6eeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmZMJytPPdpgSDPIwAEOM+7JucRFnXunEn+lqzPgYnfYMRnx7jEhmkbm06zcNYjXEnfT1kSSuSk1ailBg/L06J5/jBId1EaN1C6m/9bRNKFzSnS60VhOWFZgIrZtdxgt6ZUQ22gXKe/Aev4IUFpHX3UT1loM1B5x5jaTxo1UjPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jyz1W+hT; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jyz1W+hT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLROCLMkRIHh6fwakjoLc4SONjN5PtZSCXrmN2pKV213INDe3vwUq7qac3b6YH9ThF8f26asANa6XuHzAyZpsutVo/l9+2Hj9qaiBXoRZ/Zh0JeShVPlrticf/FfpPpF5kJL6hh4H01caUJEC6NCecl+LA+Gew+3S/yO+47TV4u8fvFPtRwJhn5ZhGLTy1WxHvtsJm2raazXxEu5w4CB2zzCboKP5iOJ0MclGRFVd0Ax5sSFp7isoWcZ2zLi6Bapri69x2QB86E5p6/aa6LlXIL/UV8FVZYtN4KVLXsfyFz1m5tYp9Ox4VYandM9xKqAkSobT3wjotBzBpDnyr0xFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3hPEnyZYwMMIuwds5nOANhLdkGLI7jmHhFDADHSBgQ=;
 b=KoAFWK/2ryqvZmvF89ctaXfH+rqy4gqygdxQRUzHJ0XGo/Oynk/+3NWkk+WhE33c8XCCkwtwMPyzrXlcmISnpN3GjYLCxyuBPgc8swACCgVScv1QLVRNVRt4BeHhyO7Dm95rC/B5ah3RpS8Gy0I5D+dK2rZmc5KlHzfhj45iT3HbZBdiO2rpB71nNurECE6eaWryqJwBSLAkQksBbveNAhC8uDAsGvx83MwB54ps8QadFRfg+bjqVxZFDIyvTlt00/X5bXICgCqi5scWMlf/upn1ENh2dV6GFRVu54LBQ+6dCMaFczcHv0Blt7GmHI7fzlJTQrm3GGf+dV7sfGqVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3hPEnyZYwMMIuwds5nOANhLdkGLI7jmHhFDADHSBgQ=;
 b=jyz1W+hTfmfrAUmnLHM2OChQXebqTyDqjRXid67RA9n29o+8J9dXD+FQ38kKoobR4QlQ0+g3BRKlVmIdso0UTqmSXsVzgSEQwpEGez4QKBPankEpOcbdJbRWx9lKt9m2ZKayT29NCAIE2linBcZ9ebfxmrtQbXYJ9eEzDwkG3+90VVO6oG6qU6XBNsWItFxseq4Nla+tYLYwPmn6M3MkxsIFDd6hK/1b0GX54ZP2erDWa2CWEG3Ii6bttgODmsuHI/Bo8bazJFfMTypyFhEgqVXL4to0kNKlmiOX0hDnqzJOGH5MqaoNlcBxWN73bZYBzNzUW4x2eqq/QlcRQpz7Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:19 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:18 +0000
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
Subject: [PATCH 07/14] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Sat, 25 Jul 2026 18:04:13 +0200
Message-ID: <20260725160513.57477-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008CB.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::439) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bb7c4b-9975-413a-0849-08deea66a97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	21kXYtloCMoFG8LBJn6P9WsRvVSrk9Y6sqBxCxD3OIR2FhfeGXZ9XIusFBqZTQyspr8RBBOn8kC7iH00Xi8KZWExYzYw7Ux7bJk7M2kWPpU0l2qfY0ocDhO+GIABMkQsPM8pz/33zbsGn/XS9WdBwX4e0wjIv5utbSFR3OQwc0pDpDyW1SqwLAKgRn2WW+5TZGUgeuDT7xFuUVB8gs7kFOxVII9XVCzrI4R7GVO18nOfdWR3LD+GG5+iI1n93lxUzc7kfbrDot2Myvio346tOT53PCS667tDD4glfL2xOl5UuabbQZB293GRw1zxeVOZeA9toHIP3WAZX+EINprw10Jgc+7IVVhHhcNi4w43S249Y0IU1qvwlSgSR6yZr+JCIRkjGbYVQywafpuBj0VmQPai7kx7s13WLb+mXRUpcoDbA4umqUUYIZXuPihJt8avBrgxNFhUy7QXTNEPxgKos7ev1IJmQxHTpwOc8kcOj0NHmfbpgIfjOjqqj2MgqZIO4meirx0N2YKhFynvwkDllEWm/D7TQSw49asEDRwA39WeaIIspR/Mjl1YDyOmjGxI/T4Wj5AfWK/llLXsoifdaO/sQc3PmXjW+XaAc2tpgi/YEtK1poC4G7PpLybPrbxlmEjJleHjI5l+Z2e6IqjYyisvyh2HTmy2V5ePh/LIXIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQXULmDihbfzByZkEzxxfaTW4w3u12bjkKu91tdOrPvNDhe38GGBZSKyi3Ce?=
 =?us-ascii?Q?lN68CKdqV2oY4dZ2jo3B8H7jrSLGOUOdLMuMFWQ5uzb0CgJHbzt8+poVxafB?=
 =?us-ascii?Q?SBNizQoQE95IslWx+WtkkSd7UI3XzEyezZQiLvpANJ+03+gcdghrOvCo3pg4?=
 =?us-ascii?Q?BLaDXSsz8mHiLwmjzsWUO4lgNBSnriobLOWqk2FKfUWayECAZtwQWa9tI+NV?=
 =?us-ascii?Q?lHb/Z4VNyoNtfvePeRtYW6Z+LBqYLJ11ix4QH9ZNy5xAAt0RbyAtAclzEn5+?=
 =?us-ascii?Q?KzNtYgtMFqbbN4q6iTzrrKmuOuVWqSaIcOgGXYL3QP8toPYH1N0Nkxw2FKUP?=
 =?us-ascii?Q?1CVSBY8ZFIKF3onSosnx5NFRI4YaUIiLP8NJbFRboAElEW3m/9DeUqvthaA8?=
 =?us-ascii?Q?E1R5UwUaHc5gdwp7dcNZN5j8zDyOR288kOAw8V3eO6L4U93FOLKB0X9UbpY1?=
 =?us-ascii?Q?78gbimhosHHIOgMk7rDQTQwEHSNzj25cU1TvQ/tkdJJEBbgGaPS79pEYDGSr?=
 =?us-ascii?Q?EGMvNjlveazQfxYrRs3Y8jkTC2gSOOskMAFZmvEKm734DY/KXD+1Gc/9+YaJ?=
 =?us-ascii?Q?c+XKTYD1NFSVTFE+ulCq9XQyQB94L9PxLhlhItwaqdkzFiTnHRV55YA+1APE?=
 =?us-ascii?Q?69TQlJsKuaGGFskc8mgPEUB+lPjcZeQPpwhPs7hg3dGf5TMgv57uNzncwsS5?=
 =?us-ascii?Q?5ihSZOHf4OA2x8mZ+GhgQED41zahJCnZuehzLg5a8PR3b3R6p86JWtoMV1AB?=
 =?us-ascii?Q?4f8VfxR9WXy5AE19kG0Pf1s4pDrU+A6eCFuHW4d+5faIbsSDBw38b9oKrC4i?=
 =?us-ascii?Q?zYid7cbEpk3R+yYC83lGQMzxqSc3EvIHUXbxneOvFdQr5bYNfOW/aC0SrCDu?=
 =?us-ascii?Q?cKsJBQsyas/H/XygnzOI/QGQcJ5UpMQ8ef/YuSJQ9DTTpSPb0P1zneHx9TPW?=
 =?us-ascii?Q?It6JX97YfnBG7akdPxRp7yeunlh4Axv8MxccbhstQm3f//G/6akf8hPI4jkJ?=
 =?us-ascii?Q?s0seSUBzE+sjKyrE1+34urb0hgRaZOhKKy4Wb7Vs6g9fR0NLtQBpVQ8g3J5c?=
 =?us-ascii?Q?50/jLsUwmGWTFxOiNNUm19kVEnbyYYoDqMrMab8kufKN7nDTdXuxoXgKqXiV?=
 =?us-ascii?Q?jRzLK4jG6YAPhuTRGqYuKy4Pc0/0jaJ3rX9tcHylq25opK8SfN+5Ete5JbX1?=
 =?us-ascii?Q?hJ4nyB73frn/BZgfaueNpgY2nnTk7RMQ2SqFlwwF/GL7artxsPFIj55m1+JM?=
 =?us-ascii?Q?MJPs2axINbxoczusNA8POqyLpdmSN51bXwTiVH3rDc12dRhfTNZwgM9wUado?=
 =?us-ascii?Q?taaOXCC7niH+PrqeMvfYIt9LRl29rVSWUeeBMz0WfOFv3CdZcd/Ml24aQiFb?=
 =?us-ascii?Q?b6btiRkSOBeHefV8lQyyY0SwWpLqjmHbJnmhQLLXuKRiKiqwH7Ku6oA0Di2U?=
 =?us-ascii?Q?rv3ECc+odm4Dy6dZjNQ/YFt4uPrfBDUfyufInxRZO69egYl8WmyJNlMSyhiz?=
 =?us-ascii?Q?fz2ziaQsknR7FcOHdqSy6Me7WOofOMgERb5I6xubLijGwwstK16ZvM9GanjH?=
 =?us-ascii?Q?c4koTwuqhfxPny8YhafWLy7qbXHzYWjp9naq4bWikxyRZeqBFF/NcJ2H8SzW?=
 =?us-ascii?Q?YAco6KcFgGQGp7J21ilXJXvhWppoMxasxjLR8fixXyT8BteOFDuffx7YGHnf?=
 =?us-ascii?Q?0LaQ2lJAR4z0sRnsVVHCs8b4xC8U3iHzoD7c6agV8dzRDJ6yxCimx1qwldo6?=
 =?us-ascii?Q?NgkYxB4HVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bb7c4b-9975-413a-0849-08deea66a97a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:18.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPI8Q9BBDuKhS9wAS6kIG4cpZKtQVJk1xKDhO3HBgz0RJ1s4pgaC9lHFQE9qFATU79TpYaqSWGIfICwoDSONgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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

Keep track of the "running" session introducing a new
SCX_TASK_RUN_TRACKED flag.

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext/ext.c      | 62 ++++++++++++++++++++++++++++---------
 kernel/sched/ext/internal.h |  6 ++++
 3 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 78b2f289cb986..92f21b0e2ab9e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,7 @@ enum scx_ent_flags {
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
+	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bd9a8c3a269af..d9f9d039459f6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2183,10 +2183,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
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
@@ -2194,9 +2194,12 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2884,10 +2887,21 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	return true;
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
@@ -2899,9 +2913,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
+	 * scheduling transition, defer starting a blocked donor's session until
+	 * proxy resolution succeeds. A restore follows an already resolved
+	 * scheduling context and can start the session immediately.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -2947,6 +2966,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class &&
+	    (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3010,9 +3036,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	update_curr_scx(rq);
 
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
index a9a853a71061c..351ffd1e02fb8 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -447,6 +447,12 @@ struct sched_ext_ops {
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
-- 
2.55.0

