Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D056E050
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096149; cv=fail; b=JybQsgt9C29V6iNgJAYSjYhfqaUiJHqAHYLTIbfA1nfyN507jd4nE+RiZ1o6TAbKdCGXpexYPAXkWt0KcWejgCLCMpa4KD4hIQVcrWcDw7v0Iv2Uwo2mwYW3CUN9/6O4Ru7mPsCTasee+s/Cnp6lsAzHkY4mt6FYsGOrQdhbkSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096149; c=relaxed/simple;
	bh=+Tv5jzoObutXUdhbfD9yKEl0uW/6kfSTRPZyuNPjmPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuzzZG+UhO1KJTbkoclDvEYgUnQEjYjwm+whOr3YWf3iVs8Pdkj+7H75Oi/h/1gr/fEztrTq/CkrzWdWULZhEbU+Ay26/Wv80xSJgUQpaWQdg4f/fvYUXVDdsW/bxrhzDSbDTejHMz7oNzUgiwnth9cVrcO74iO6nRJEP/CBOdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4AY2CsF; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4AY2CsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw771o/zNa2xOidGyw3LmpBleJjTQk1RKOtpBmhjnOOokTRcUGlL3Hj4eGU7gTmFPXbQFvjWMFlQnyfSxIpqWzT20LcyyrH7U4kmsu0bLokqa4u+RAYKA/Uj+ruCMhqY/1TpBKPPlgvPlQCbq+M2nO/hziJe5+7JQUIhKjezyRYBdlkGQUm0+fYxjtgY6+0gjL8y6kZfweJzvGh0REom/cwasvDpFHBM8qOhhbeN8x0+halNEQgaU3WmOs8/zC8eLv5JWQ592iicyu2rB+JDLGODkadFkR19MVejz7PVAYo0Qm3OBBq+6Wg7YwjFa1guyF7y4CAwrO3Rd81VKVHbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF4UEOK7XILtYCFo5P998iFDt0+VHxCCFSgJqGjX0IU=;
 b=uEkYxKIDENRtM4lzeFV74dXtBmfb4LmcuRMTHZXYVA68fzPjJBZTMCOLlEMaQpGZ6FVQPE9sOUyo9oF9MkRy+R7RoC2X1VYu2yBr8agMsKUHc703uvBbYVNr1/9U5GOj/rjlCdlNOGvkiVTNIGRyv7gCYfynQXm/0389K7kkqiRMrZV1ABUDc9krvL7lpj65l/CdNgXSbXFdWNb+lB+fwS9qIJPxaD/pW62MWEDK8cSZAlJwv2bsipEAW401eZZlldBhq8BtBU3IPFG34TtA3NMYjAN8kU/CSFrcwV1Btq86hkA0kOSq+mh+Tifg19ZAIlTaoFlHr5JQr7+E1A1IVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF4UEOK7XILtYCFo5P998iFDt0+VHxCCFSgJqGjX0IU=;
 b=J4AY2CsFnSXqxxxwEh0fsnV0ArfmArWE10LP8rRHcUzvacy1t+Qe0Jg26KudQ31XR3k1vXmTaXKwmZq1q8hAmgj6VwpebcCDeneRHNSVU0hCm5tgQtD3OeWH/5745tTOoapq4v5X5SXSaUmPpk49UwTbW0WskQHESTsxdZV8E5PB/W8e6FuLQ5zwqh6Fpk5yfWGNN5Al2GySfMhxkc0Rzq/rcmbZNNELAyjp1JlFPhfLIuE1YEstH0j6EVFfUS8WTSshByR0Mj2UXSvriHFqNleGO9VFWaCe094wDVO7x7J3X4qV6i5JbtZ2I6cFQIc5Bnz1jpm6HUX9lmRJ106L8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:41 +0000
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
Subject: [PATCH 12/16] sched_ext: Track proxy execution for NOHZ_FULL
Date: Tue, 22 Sep 2026 18:51:51 +0200
Message-ID: <20260922165445.943315-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d688db8-1022-435b-c395-08df18ca5618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YlV78GaV3q4G7EP14U03o0XROML58f1Rzm+OPseR/c9tz5VdTNo59wFpiZKvXzuK9Gv1QfDUASRNi5a/aa1B3uwHQi097dHipUUbgjX8jVCbqsGwGEbSRo43lY+bphAy2jK/1000A42ukIQP1S6AiKv/JNOi1Go6/qyxjdyj1menFsw5RefHKAkd8y0Zrj66oVV7gWtFotXcDC5FcnYEb0VL4WM132HC+q+/4c8aocPlsqPM52Z3g/7LBoP+JyhkLbaRVYfSsqlPFmkQuJ0ShbOJHFf7MpS+kcxzMO33154rJzbbK07ZBWgzZ2abFL6lFBupK3lF+DMKo1dHbHTy41YRIjisPHJtIxEigduog5IxJnWtV7dyum//TbjnPVNoIT3KQ8bSnXRFJQUDNXYp39chVkT6YUJuOqqVp+3epxjWVpdLocjSd8qSWvLEFyteoOOoax+4MOyXL96XEsKC56QDVVsGHE1E7Ttm9ytRGMOd6abfPBPh2CMWcNzcD8+CTHpeNAsjNuCa8ppkngC4lJ8F4yfRyoSgMi+R+Srjsg+44UceB+hKl/SOSuZuY9bkL+1NdGZAYffJ4AhNTg6cQEjOHvnpV8rGvxpYpSNLQfmGP4g4/hEPTGzgkJUBvyTb/4JOGKl0gTwntt0QyrjbdsQxKSiYSly0ixnHDIiJ1w4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gEbRz3g4OnJrlpxF7OKEodvPVI7iVt+PlvagBMXrnFiLVZsD9y4ZajAYTzJ?=
 =?us-ascii?Q?zrA0g+yTu2adpDPggkBezbAvMQTJeoJzL8YrqC7crEUpcitWFml9lMVn2b8r?=
 =?us-ascii?Q?AUQwrbfGeBx4Io9UibD02YXK10N9pNxCtf5dMGRHI/FgS7rwtMwZnu6p/Glt?=
 =?us-ascii?Q?7SNwyLWVE29tkXMSNu4VrZdvGpff2rdcSyM5H97c8GvY+SfURgn5h26j1RzO?=
 =?us-ascii?Q?cNnQANeZk2unH6rwOrWkUoJWgweH2J5TScOBBQz2wJ2fLoFhiZ72RhlHr7RQ?=
 =?us-ascii?Q?KlyH4tg5OsjlJ5HXEDFoJGDwyDHHNK2ddDY53HFtoONqlsBCAeUTLd/h8fq3?=
 =?us-ascii?Q?1yXByNMgGMUg3DRgSlrasa4t76geW+ZemYfzt5nkxY/vO+eRXF7hsW5/ue5H?=
 =?us-ascii?Q?HID3+K9sisy7i+BvbddoHqnmDZG0olMdO/2N7mKlHjCnlfGTNtSAEcqHkTWn?=
 =?us-ascii?Q?A8MEfSFQA5CMbtiHiYcL2ydZ8MPzrQPBM6pwUDZV7OgPF34BqOY2OojNL+xL?=
 =?us-ascii?Q?f1PGvRrzmh/gXBPx55b2NtFzNET0tKD9Se0F9k+x4XR9/A6n6pIWCZWfQwIP?=
 =?us-ascii?Q?lk5kxJZeOUajUu0CHb8cTPNXT7zBjgOj8HseTXNAirc1WXOqHMXjJLclOoP3?=
 =?us-ascii?Q?xphF4x4fw8I0dT3T3ZHqpDVpc7BZ2uV6Z8T6idLy3kWWsafZp8EnGw5SdfhN?=
 =?us-ascii?Q?evaCfbYGM8P/KgHS8Z7uZnCNbD0LoeZ06gaKoP8yAJ4vAjRZFVz96ixxx7Sl?=
 =?us-ascii?Q?v1G4rWzhPqgzsp+qdE5+MhuFsYchT9INuvnn7REtxhaSihm0l/+YySf0U3e8?=
 =?us-ascii?Q?+bNLwww+Y0AP3cCZe4zaeTry3D+2QKT34bDkl8FANXGbinjOjcA2LtKcA91P?=
 =?us-ascii?Q?f9h0DrkxyYvIVR1a1E5Ash3XBZtEgAQe2NPpN/dInerY9zhXseu443pc4+XY?=
 =?us-ascii?Q?EUGix9vbh7hAuUXT43KC5S0Yzyav6wzQhe9yiL5dZ+ZIxf/iAnsTuDgHBEZc?=
 =?us-ascii?Q?omp2BmKVlz8SmwnS+KfDGSMEFJ8b6pM2Aiex4rS8qbDxzv0vVjfNjlfaRUde?=
 =?us-ascii?Q?Ut28pEEo5Yd7K/YoJ0mE9XAtPGlsmz2OM1OG7S+RNFIMu6k8qNasQMGg3/Pa?=
 =?us-ascii?Q?OaUKVVu4U9x2PUai/rBdWwAcXtD09QOVo22S582US/oL9JxbrhHBO1laIlCV?=
 =?us-ascii?Q?Z/uO5qtcxYAilfuRymvVy/EA6j666/qHdWzRMeRT4o8seR0o0MHDgl2b/O3v?=
 =?us-ascii?Q?B8kZo8rJrZNfZYrdjFnrXYwZQ4a8+Y8OY7q0nT+EKWVH0aO6ByOkSYn4Y7dJ?=
 =?us-ascii?Q?PJg0/3NYBN/I1fmkxsUeh9h0a3X4fiOx5kUert4Rcage++q9Ff0E7nVghW+p?=
 =?us-ascii?Q?0kzQQAM/BvvVidjX5W7d2kakeRa/22ycPEdxjKvvF6vM60yAgNNxmrW6mcZ6?=
 =?us-ascii?Q?fSFaKSH1iA2LoopyBAR4vh3HJmFP85C4zRjuJX51lylZkcvVmNGoQVFxjSIi?=
 =?us-ascii?Q?kbra+1Bqb/F95G72Y7d3g8Cou5ejjMMc+BDvsh9gL9h9sbuXvkDIEKipctt5?=
 =?us-ascii?Q?hVMZBdWnhsJr5nw/4cIheTDi1gjjuNJv45Wx3iCGl2DP4/gwvAu7SoV0D1Eo?=
 =?us-ascii?Q?OjIjE7fqBz/PzitAxZByzUQL7oQFRe4QkskgRGpNhSheAMxc1eydCyhzNauz?=
 =?us-ascii?Q?z+VuaKCSqDnB3CSMsZ/eDxjm1oPtDpRfkUog23zsIjCMyLmyr5smfVeyXrEW?=
 =?us-ascii?Q?BrSy7O3Wcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d688db8-1022-435b-c395-08df18ca5618
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:41.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IleejA+eF8wGpawQ7Zo+77zQ09zsZPbRsMAvQGLiJ6FhE0p0zUK4wbKXotyolVJehi+piQgweUSXDKI5pIkKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

scx_can_stop_tick() currently treats any blocked rq->donor as an active
proxy session. However, rq->donor can temporarily still identify an
outgoing blocked task while the scheduler selects an ordinary execution
context. A dependency update in that window can keep TICK_DEP_BIT_SCHED
set after the context switch.

Track whether proxy resolution actually selected a different execution
context. Keep the tick active while that state is set instead of
deriving it from a potentially stale donor.

When proxy execution ends, clear the state and queue a balance callback
to reevaluate the tick dependency after context_switch() updates
rq->curr. This lets sched_can_stop_tick() observe the complete donor and
execution selection without adding work outside the existing
proxy-execution branch.

Conservatively re-enable the periodic scheduler tick for the duration of
proxy execution. Allowing proxy execution itself to run tickless would
require making the remote NOHZ scheduler tick aware of the split between
rq->curr and rq->donor, which is left as a future improvement.

Perform the tick update from scx_proxy_reenqueue_retry(), which already
runs after proxy resolution, so scheduler core needs no additional hook.
Compile the additional runqueue state and callback out when
CONFIG_NO_HZ_FULL is disabled.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 44 +++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h   |  4 ++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1f4016c04d527..247da76021044 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1130,13 +1130,51 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static void scx_proxy_tick_bal_cb(struct rq *rq)
+{
+	sched_update_tick_dependency(rq);
+}
+
+static void scx_proxy_update_tick(struct rq *rq, struct task_struct *next)
+{
+	bool proxy = next != rq->donor;
+	bool was_proxy = rq->scx.flags & SCX_RQ_PROXY_TICK;
+
+	if (likely(proxy == was_proxy))
+		return;
+
+	if (proxy) {
+		/* Keep proxy execution tick-driven for now. */
+		rq->scx.flags |= SCX_RQ_PROXY_TICK;
+		tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
+	} else {
+		rq->scx.flags &= ~SCX_RQ_PROXY_TICK;
+		/*
+		 * The selected donor is already visible, but rq->curr still
+		 * identifies the outgoing execution context. Reevaluate after
+		 * context_switch() updates rq->curr so sched_can_stop_tick() sees
+		 * the complete selection.
+		 */
+		queue_balance_callback(rq, &rq->scx.proxy_tick_bal_cb,
+				       scx_proxy_tick_bal_cb);
+	}
+}
+#endif
+
 /*
- * Retry proxy-rejected tasks which couldn't be reenqueued by an earlier drain.
+ * Complete sched_ext bookkeeping after proxy resolution and retry tasks which
+ * couldn't be reenqueued by an earlier reject DSQ drain.
  */
 void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next)
 {
 	lockdep_assert_rq_held(rq);
 
+#ifdef CONFIG_NO_HZ_FULL
+	if (scx_enabled() && tick_nohz_full_cpu(cpu_of(rq)))
+		scx_proxy_update_tick(rq, next);
+#endif
+
 	if (rq->scx.flags & SCX_RQ_PROXY_RETRY) {
 		rq->scx.flags &= ~SCX_RQ_PROXY_RETRY;
 		schedule_deferred_locked(rq);
@@ -4966,8 +5004,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
-	/* Keep the tick running while a blocked proxy donor is selected. */
-	if (p->is_blocked)
+	/* Proxy execution is conservatively tick-driven for now. */
+	if (rq->scx.flags & SCX_RQ_PROXY_TICK)
 		return false;
 
 	if (p->sched_class != &ext_sched_class)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 52c60a884994f..083074edd0bab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -789,6 +789,7 @@ enum scx_rq_flags {
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
 	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
+	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
@@ -843,6 +844,9 @@ struct scx_rq {
 	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
 	struct balance_callback	deferred_bal_cb;
 	struct balance_callback	kick_sync_bal_cb;
+#ifdef CONFIG_NO_HZ_FULL
+	struct balance_callback	proxy_tick_bal_cb;
+#endif
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
 };
-- 
2.55.0

