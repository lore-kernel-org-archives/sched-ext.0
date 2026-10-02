Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9F3B5837
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979379; cv=fail; b=Rkp8sTGf3x9JeW71EajkXYudXKEdk3kImuXU5cEg2pZ96aBvElOt64SrnMPl8BQ+pE1NRat6q3+XwtCF45VM42FHLeJ4ntuYdnpXa8zLN0FFdI8720s2vVXzKMmHQ7BpoqofmpeJ8whdN4H0A40J0yZO55D6QJoNxMBd2jdOGtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979379; c=relaxed/simple;
	bh=CetcU4GfsrEvqvCV2E/cddtFojthNYlg/393ujs2hYU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cwzz4BMmNK5Q/yr3zOddtV8q8u7aLMr7URU55Cwjw/FV3WlditETKZ9z6xKKfyYu4B6aKYKtr2NvpYhEt6JSSv1nGfz2N/HDb1/+3lm7omg/+28q+0CDmu0X+nJEFsz+zeuc/M+lz8Zu+oqLcMn33AiofwdbmvrP09E4gbzzZRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIU76MKd; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIU76MKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzJ5Xu2xFCiS28p3RXXGb/OaOnVkE1Og2uLc6FI47clRjQUJ/J6OQuqn0nP4ooa2BlqRAmfb7NKsSw0lg1u29+JTK0PZz3Dxc16LJRl0Fwee768xMVQ3elv641m+jmG3Oi0uOYf8D3qF6LWlMc5mNf1dxtQDo3MPAQXPSWqyiKcSC+9twgX/URKsB/bLUCNTIuYzhxU8L1KqMBaIO0UPP4HI6iLAPlzS1EP1uWThAHyExakU4JJZ54SR+TmJt4CcudsXBzmZpaIOppUIqcvY5HfDUTnX2R3DiqiGvaUXOqnwRkP+ZvnLZJf4+yMXs1Dv0+6rKBpB7AeCh0g3KN429A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxa9bBD4TalatfgBbAsZYRgi7XTe3UcpK8u86AI8UaY=;
 b=cfn8XQuFuwaP28xombxZdjHTAy3fxjmVlFpUe40SnThMKxT4akBjtTaEB4Bpor4mcvasj9OxqeMzAkOzxT3xhYSZHATY+jfvW+XrAcCCkiCsNcxmPtb9cC4Qs2xrmOHDAgXM2GHp2QCoOWBjsBQbE4FT0JN1ElaEIMBE9Y1EF0s0o5nCJ1uHCI7dUg9FYuk5nNp1OvaK7Y+cq8XBLAnXgNi/tEsYyDwpvS9PORfDkOzg0iKqA9ui8xW+y8XRjn2bjm5YiOQKF7zwC+SS6QG2IZ1qDwfvzzhPSJKhmAWGwNi92V/oLPY36jWijZZ9Zbio8xZF+thms/jrZLxuN9p8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxa9bBD4TalatfgBbAsZYRgi7XTe3UcpK8u86AI8UaY=;
 b=UIU76MKd4F4tOLXKd38eJg/Mf2uvfkSY4b72vRNk71u1kcWAyNv0ST2llmX2nsT/PK3DcxP9IffkWNTY6MLGl0MSgiKJYkhogttgxGaTccW9sYfKP18c0k3nuuMkBwMuwJhys/8wiYAk95aGEghWK5NOfK5UEaIYDP/JYcxSUiSX2Ao3Z6OlPk3qT8XlHKa7IY1lL3FoqspGQ/nc7YdraEXQW49iiF/zFOQQPbtI7wkKU7fr2a72rjUjCw63tnyREMbLfnCiudHhPlNTL0XTWrfitas2SW/RXlXRtafNiYCWbm+dtYQOTI1aOHT3MEgQbldvfXJvSP7+gBXPLSSlOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 22:16:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 22:16:07 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
Date: Sat,  3 Oct 2026 00:15:58 +0200
Message-ID: <20261002221559.3090900-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: c43d89df-00c7-4dd6-e897-08df20d2c179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|6133799003|10067099003|56012099006|11063799006|10063799003;
X-Microsoft-Antispam-Message-Info:
	V3nXDS6+JxIxCFtI/Gbi/rWSBCXFK2Z2lDEp+DWAAASiG9H/nB018x380hyjJE/9m5yRieTWhOVkmhP9Fe5b0TxowlaGhwq+pBX5uniOtV9UyLAxyz2vcRNNvWe1C8vdv2jrDEpHPOqkKp4XX4xMzl+3R4SJz7+kCf2zUh6LiGgl+5KMZMjLVShrGDgS2mW70RNZp5GbOFq6yVe/itDAzX3FnIDWI8ixHJnqbkCHBDdxJEj/35Ee7Fl2c1kg30UDh9yGR+giKoIxEO/dg972OItjyXM8com3AFLXlL7LR7R9+kz5ws8rNA5ar1wCo+itsrXdIVNycvTrhuDPmMsvqgTdQ+103iarBinxoiB32uwS7C0lcp+PeR9lIeysyJw/oKTYd5vUWZ6AtDi3qt1M8zJqU9zEA0aMpqHc8g+FfT+tovPlANq6jYFi4L2vQrR7f4If05M6yvaD6rIxAp8HbmYObqYEzik9ggfU5uzSBc5Yp7CI2XVoFWliSBrdiGkJWeNn1CT1dBlHbyc1dsyAynXJZGDTu7UgprO8QZJLDrLnXsjr7ZxNFOyRANYIg2j47zYvtx6IEcq33qpR5g+03QnKBr2+eVppOapsu2mV6WWiF95DvqfPyKWK9f6fgPbFhiyCHsueI7vdpoErt48n9RZDFpu9qOhcH0AVOlcglZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG9XdXRsTk9IYlViS05SSkpxb0xuSHk5R2cwT1ZWZXQ5L2pSU0xxRzR2ampm?=
 =?utf-8?B?MDk5Mmh4aHFrN0oxdUNMVGJjK29ZU3FNREh1QnI0cW55YU14RlpuWGN1ckVq?=
 =?utf-8?B?bEhqTENDY3FVTDVOSjdJeUVRQ04xTWVieEw2a1ptUWg1eEloZ1lyeVlaRWhQ?=
 =?utf-8?B?UTBva2s3UjBQekg0Y1VWZTJMWjBYMVBkUzB0V3hwY1dsY2tGYXFxc2p4VFhz?=
 =?utf-8?B?UXRKaG5PZ0podWlDVVlvaU83bkhVVjRMRGNvMUw2ZkdvUUpiV3FJTHplQ2VH?=
 =?utf-8?B?d1BQa0h0U2tlWlRpRE9FMzNnekN5MGtzWUM3dVVzZlh3RnZ2aU94dlFROE1E?=
 =?utf-8?B?SitCbytKcHc0ZnYvSWswZjJDOHdlMWNkY1kySkM1bmlxcXREVGtFdXQxRmtq?=
 =?utf-8?B?ZkQ0dG5LaWVYd0E1WG9xcWFPTThYdUR1YnB6UERnUmtXcjdwbVE1R1Q1Ris4?=
 =?utf-8?B?a3QrSlVwbEZIdjdYYTJRWDJGQ0hRbkxWN3VQTSt0aUFKNC9MZFRiMXo0VEVt?=
 =?utf-8?B?Z1NsRnIvUG9GM0xrRnJJYWxHdW9mTFlOb29KOE5vWmV3ZHpmT0NRYmdVWGxI?=
 =?utf-8?B?MkJNOFJsVHRmR3hjQjdQQTE1SXh2WWw4RldLWXpQdjdYVkRwQkxRY0FaWFh1?=
 =?utf-8?B?Zm5mL09YYXg0UGVQMTRTUWNPTS9pYzRLaWpLRW5QdEs0WlZ5ZW1PTm5OWG5L?=
 =?utf-8?B?TXp1V3FsSml3U01mZVpudysrVExEZXVyUzNtcnoxNGJwYVlzTDNmdm9nWDhN?=
 =?utf-8?B?STgvTHJTWHgrbzNzdCtkZS9DNTBsbkg3dS9jeWN1TmFMZllQSHZJem5iMjUr?=
 =?utf-8?B?QW9iVHQzemVTSnNmOWRFTXl4bG9wUVJzV1lsTG9yZThjNWRISVJReEc4aUZQ?=
 =?utf-8?B?VHVTNzNMZytFTUxocEhSWTZlYVp6T3pWQUJ6OFF1cit0bVcvb3pNQngzMlBZ?=
 =?utf-8?B?OWpHeTJFakRkSm1acGhydytXUEowV0Q2VkZxUzRxbDF0OHBqbGNzcXFqc1hQ?=
 =?utf-8?B?bjBqY2RtVDJZYk41OU84VmxuZVVmbUhRckk4VWV4M1RSd3NRM1A0cTZ6YzNM?=
 =?utf-8?B?SVU2RDcxZFMraEdQVXRqWGszOEdiWVFINE5LSXVmSHJtVVhQV3FJYTZxY0ky?=
 =?utf-8?B?b2F6OE5SS0hhS0NjYkIvWGpvWlNOSkFvMzZmRmo0bDRQMWlqUERmbDhCSHdW?=
 =?utf-8?B?VDFqazF0VVFDTzg0cHZ1alJabWFyMU0vLzZYMWU2K2h1OVFLR2U4SlI5NDRn?=
 =?utf-8?B?Z0JwTUZrQ2EzeEZlZ0RiMjZpVyt2VlR5a05XMXJEQUQ2eHBPTGVDRkh5QWRJ?=
 =?utf-8?B?cFdJYk4vOHNWdGdtOVFuNW5MWkQwV3RnMlA2cTdReEJvVjMxdGZSbVljQWVR?=
 =?utf-8?B?MjNXbUEyL3VjdEFWdkNPeTAyQmhxeUE3MjBwajFNSVJpOEVVZ1RBSkpzTjV1?=
 =?utf-8?B?NWxnWHpPeWtsYTkyMklUbmFCVnN3d1Q0TkFpQWZ2MHhndzNlTjhGTTlFTHF1?=
 =?utf-8?B?OU9IOWgwK3oxb08rOXVZZ2paY2xaR2NSZDdZWHRydHpxNnpoclJKclFNRTFE?=
 =?utf-8?B?UmM3STN0UXA1ckFOaXpILytkZklmMVpKVi9VWlIzT2lIOWNZd3kzR3Y5WjRS?=
 =?utf-8?B?Z3RVelNySU9PYmcvV2lrUndXTXU1QVJ4ajdRZXpaeHNsRktuSDJlNkdIL29o?=
 =?utf-8?B?Uk02OWgrUXh2eFk4eXpZNER4bHNlQWg1UktocXNqUy94bnhQeDdsM3oxT0RB?=
 =?utf-8?B?VFQ3d3NwR3BZb3VCei9ibWJoWWU1NnBQbWVsSVFLSXNiS1dHWG54OGxsWlNW?=
 =?utf-8?B?MUNOWVdwVEJPK2NXNDFoWHFQSFFhaFVzbnJrM3lUUnpvdGtPUXJRRVFOb2lr?=
 =?utf-8?B?TXZFTmgyLzcybkZRa0ZaRlFIS0lOZk1tL0VRV01WbE5KMVBES1orczVyN3Jk?=
 =?utf-8?B?cWYwTGZxZ0VaRC9zZFhGU0xVWW1qVlNxcXBhTFM5ejllVnJqek9WWGNWZmE2?=
 =?utf-8?B?YUJsbkJuVHIyc2VpNGlCa25UTkxOT0hrRWZONWF4NVlUWHF5NVhTUkIxTDVp?=
 =?utf-8?B?Zk1YemNxbXpQc2cwM2Q1eTYxS2docUllc1FGN0UxakJQa1FnM0pVMDNqdVU1?=
 =?utf-8?B?TVFqRlAyK3VZaHZsZHFPN3NLRk9oMWZRMGtmdHJlV0ZHWDFhVjNld25BMG1C?=
 =?utf-8?B?ZW9jbjYrbmw1eU5WSmtjS2hCYkdYVlM4MnQ3QTN3L1BFMDU0RlhUQjlBVURa?=
 =?utf-8?B?NTRCTG9DVnByNnovNVlKWm5jeXJtdTRWZFhZdkUzOU1xOXMrcE9NeW1uWjVH?=
 =?utf-8?Q?U/7be691n28V/rtxlk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d89df-00c7-4dd6-e897-08df20d2c179
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 22:16:07.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GtphLfIsZCRewqFbKnfKLXbXt5I+SIPqOJLlqhy5FYfN253GVjbL6XfQttAklPB/k6X8OSeMEBakGh1JLNjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

Commit ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF
schedulers") makes put_prev_task_scx() pass a retained proxy donor to
ops.enqueue() with SCX_ENQ_BLOCKED.

Some of these puts are only proxy bookkeeping; proxy_resched_idle()
drops the rq's donor reference before switching to idle when:
 - find_proxy_task() finds a remote mutex owner before the donor
   switches out,
 - proxy_migrate_task() detaches the donor before migration,
 - proxy_deactivate() blocks a donor whose owner cannot run.

In the first case, BPF has already selected a donor with slice left,
returning it to ops.enqueue() forces BPF to dispatch it again before
proxy resolution can continue. In the other two cases, the caller
deactivates the donor immediately after ops.enqueue(), undoing any
placement BPF makes.

Keep a donor with slice left at the head of the local DSQ instead, so
the next pick can resolve its owner, or deactivation can remove it
without an unnecessary BPF handoff.

For donors with slice left, this leaves BPF to handle meaningful
placement decisions rather than transient proxy-bookkeeping puts.

Fixes: ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF schedulers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Keep blocked donors with slice left on the local DSQ regardless of
   IMMED and drop SCX_RQ_PROXY_PICK_PENDING (Tejun Heo)
 - Fold blocked-donor fallback into the normal enqueue path and restrict
   SCX_ENQ_LAST handling to unblocked tasks (Tejun Heo)
 - Link to v1: https://lore.kernel.org/r/20261001191216.2391359-1-arighi@nvidia.com

 kernel/sched/ext/ext.c      | 66 ++++++++++++++++++++++---------------
 kernel/sched/ext/internal.h | 16 ++++++---
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 96c904b396019..aba035213bfc8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1574,7 +1574,8 @@ static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 en
 
 		/*
 		 * If @rq already had other tasks or the current task is not
-		 * done yet, @p can't go on the CPU immediately. Re-enqueue.
+		 * done yet, @p can't go on the CPU immediately. Check whether
+		 * it needs to be reenqueued.
 		 */
 		if (unlikely(dsq->nr > 1 || !rq_is_open(rq, enq_flags)))
 			scx_schedule_reenq_local(rq, 0);
@@ -2563,8 +2564,17 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 		    p->is_blocked) {
 			struct scx_sched *sch = scx_task_sched(p);
 
-			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED)) {
+				/*
+				 * A proxy-migrated donor is dequeued before this callback.
+				 * Recheck a local IMMED donor still on its wake_cpu after
+				 * ttwu_runnable() clears is_blocked.
+				 */
+				if ((p->scx.flags & SCX_TASK_IMMED) &&
+				    p->scx.dsq == &rq->scx.local_dsq)
+					scx_schedule_reenq_local(rq, 0);
 				resched_curr(rq);
+			}
 		}
 		return;
 	}
@@ -3318,6 +3328,9 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	 *
 	 * - A non-IMMED HEAD task can get queued in front of an IMMED task
 	 *   between the IMMED queueing and the subsequent scheduling event.
+	 *
+	 * A blocked IMMED donor may make this scan a no-op. Skipping it does
+	 * not schedule another scan, so avoid separate accounting for it.
 	 */
 	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
 		scx_schedule_reenq_local(rq, 0);
@@ -3516,37 +3529,31 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
-		/* Delegate retained donor admission to its owning BPF scheduler. */
-		if (p->is_blocked) {
-			/*
-			 * If the donor is the same and only the mutex owner
-			 * changes, avoid triggering another ops.enqueue(): the
-			 * BPF scheduler has already admitted the donor, so it
-			 * can continue running.
-			 */
-			if (next == p)
-				goto switch_class;
-
-			if (WARN_ON_ONCE(!sch))
-				goto switch_class;
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
-			scx_do_enqueue_task(rq, p, 0, -1);
+		/*
+		 * If the donor is the same and only the mutex owner changes,
+		 * avoid triggering another ops.enqueue(): the BPF scheduler has
+		 * already admitted the donor, so it can continue running.
+		 */
+		if (p->is_blocked && next == p)
 			goto switch_class;
-		}
 
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
 		 * forcing a different task. Leave it at the head of the local
-		 * DSQ unless it was an IMMED task. IMMED tasks should not
-		 * linger on a busy CPU, reenqueue them to the BPF scheduler.
+		 * DSQ unless it was an unblocked IMMED task. Such tasks should not
+		 * linger on a busy CPU, so reenqueue them to the BPF scheduler.
+		 *
+		 * A blocked donor's progress depends on its mutex owner. Moving the
+		 * donor elsewhere does not move its owner, so keep it local even if
+		 * it is IMMED.
 		 *
 		 * An open rescue must keep @p on the local DSQ even if the
 		 * scheduler zeroed the slice in ops.stopping() above.
 		 */
 		if ((p->scx.slice || unlikely(p == scx_rescuee(rq))) &&
 		    !scx_bypassing(sch, cpu_of(rq))) {
-			if (p->scx.flags & SCX_TASK_IMMED) {
+			if ((p->scx.flags & SCX_TASK_IMMED) && !p->is_blocked) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 			} else {
@@ -3563,6 +3570,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 						enq_flags |= SCX_ENQ_HEAD;
 				} else {
 					enq_flags |= SCX_ENQ_HEAD;
+					if (p->scx.flags & SCX_TASK_IMMED)
+						enq_flags |= SCX_ENQ_IMMED;
 				}
 
 				scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
@@ -3582,7 +3591,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * locally runnable and can legitimately go idle with @p still
 		 * runnable (see do_pick_task_scx()).
 		 */
-		if (next && sched_class_above(&ext_sched_class, next->sched_class) &&
+		if (!p->is_blocked &&
+		    next && sched_class_above(&ext_sched_class, next->sched_class) &&
 		    scx_task_can_stay_on_cpu(rq, p)) {
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
@@ -4811,10 +4821,12 @@ static void process_ddsp_deferred_locals(struct rq *rq)
  * - %SCX_REENQ_TSR_RQ_OPEN: Set by reenq_local() before the walk if
  *   rq_is_open() is true.
  *
- * An IMMED task is kept (returns %false) only if it's the first task in the DSQ
- * AND the current task is done — i.e. it will execute immediately. All other
- * IMMED tasks are reenqueued. This means if a non-IMMED task sits at the head,
- * every IMMED task behind it gets reenqueued.
+ * An unblocked IMMED task is kept (returns %false) only if it's the first task
+ * in the DSQ AND the current task is done, so it will execute immediately.
+ * Other unblocked IMMED tasks are reenqueued. Blocked proxy donors are not
+ * reenqueued for IMMED alone, even if they are not first or the rq is busy.
+ * If a non-IMMED task sits at the head, every unblocked IMMED task behind it
+ * gets reenqueued.
  *
  * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
  * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
@@ -4835,7 +4847,7 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 
 	*reason = SCX_TASK_REENQ_KFUNC;
 
-	if ((p->scx.flags & SCX_TASK_IMMED) &&
+	if ((p->scx.flags & SCX_TASK_IMMED) && !p->is_blocked &&
 	    (!first || !(*reenq_flags & SCX_REENQ_TSR_RQ_OPEN))) {
 		__scx_add_event(scx_task_sched(p), SCX_EV_REENQ_IMMED, 1);
 		*reason = SCX_TASK_REENQ_IMMED;
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d65fec631bdf7..dfea7b1f95f98 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1780,14 +1780,14 @@ enum scx_enq_flags {
 	SCX_ENQ_PREEMPT_LAZY	= 1LLU << 35,
 
 	/*
-	 * Only allowed on local DSQs. Guarantees that the task either gets
-	 * on the CPU immediately and stays on it, or gets reenqueued back
-	 * to the BPF scheduler. It will never linger on a local DSQ or be
-	 * silently put back after preemption.
+	 * Only allowed on local DSQs. Guarantees that an unblocked task either
+	 * gets on the CPU immediately and stays on it, or gets reenqueued back
+	 * to the BPF scheduler. A blocked proxy donor can stay on the local DSQ
+	 * with slice left because its progress depends on its mutex owner.
 	 *
 	 * The protection persists until the next fresh enqueue - it
 	 * survives SAVE/RESTORE cycles, slice extensions and preemption.
-	 * If the task can't stay on the CPU for any reason, it gets
+	 * If an unblocked task can't stay on the CPU for any reason, it gets
 	 * reenqueued back to the BPF scheduler.
 	 *
 	 * Exiting and migration-disabled tasks bypass ops.enqueue() and
@@ -1829,6 +1829,12 @@ enum scx_enq_flags {
 	/*
 	 * The task is blocked on a mutex and is being kept runnable as a proxy
 	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 *
+	 * Blocking on the mutex does not enqueue the task by itself. A donor put
+	 * with slice left stays at the head of the local DSQ, including IMMED
+	 * donors. It is passed to ops.enqueue() when its slice runs out
+	 * (including an SCX preemption that zeros it), or proxy execution moves
+	 * it to the CPU of the mutex owner.
 	 */
 	SCX_ENQ_BLOCKED		= 1LLU << 42,
 
-- 
2.55.0
