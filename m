Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B43DB626
	for <sched-ext@lists.linux.dev>; Sat, 10 Oct 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625941; cv=fail; b=rRqaUFiQsyv/3RU6TKdd/RIqSel/j3H+pBEsVwizu07qyIOaggvMmA9VXgIN0ladwSlJbx3Nk22blVsOSPijMfgcD4sNhwSYZyLKCr/po8QkgryjeM1quSiZN6dpL7Fsu0J2tmK9d7lPZrgw6u7acU4MpAE1g8utXwuGDN5MYvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625941; c=relaxed/simple;
	bh=fBTEjnLLALljoaolUyXJUVMkl+2icqJoRRQ3euxDdaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I62tRLlmwwJzOdcVab+JrlglEpVJrjG2f8s2uCgg4KCMvJEmviqueYpScRQBtbYZ2+WJTSu2Au8GRda1UeL8NrM+XPyKy4sHIAUZ/SE5JWiPzZxNClBUm8bJ94gUjQBHM1WeVwrPqFFoZ/NOEtZ5E6E3wd8uanVrYTSvtxrsaIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1M1FhTA; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1M1FhTA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr3MTBP7xXjP4B18H3coWJAovW/g8F22Apeol4wd9THfCDz/kQlns1yYHXy/TcjnqIu98n0TPYQXNdJoaDE9O7KM+r98mjGseFDs1DNXM/d1iLYWMM2M4gIFf/qoMHntmpptWcKKrNBIqaoN5lDCpE7ZTrpJFB5NOLTil3tgu47Tp0CL3E4DEe9GfXtpQ6wJiMYZ5SCV1MSQEuRtoHV6kJPZrdrBiNKmnZF2Obmg9GZzWsWZFEqRVSddLZ9r2EjgkImSUXrD9zETPsXnpJMI3gPj2lUawP59OBLoT/5+c1m0az5cJr/jvaDh6tf47YxM0NPgy3kUZI4tC+uDWXlzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhfFcTgeeUumQVZ5SVvDQKCiYw3A5EQIznTqfdCV7tI=;
 b=BDjoiQKCIX3lblI5kqf2ibN3Z25IaRhshGdqW/Lfxv3ubkAeTdgnNz7/oE7DPwsoj5EVFZR+6f61oinrcQsN/JUK3x3rX5UgcqVWT5F767+AFmlWH0K1oMUohPQw467GIh0G+v2RHbTJ7aafsWH+tKfeoQrXHT4fgEqY0Olu7/ECmHQc/FLHw/GODn7KmewAf+3oZWMy1W9mmgllAnYWfArJG6WsWi8D0XRriLd8pF27RsrNfDkltdVFZ8qOXmCQj7WMQrR91B42GVgMPslTqW37xyR/jXISqZ8888Zw39TGOkpcj7Ie9E5/IqjBiibLNUyUQoWg76JdIZP5rjd/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhfFcTgeeUumQVZ5SVvDQKCiYw3A5EQIznTqfdCV7tI=;
 b=m1M1FhTACykJRAD2f86D3WyecSnlO2gmRKrr+dxw4wCGgGTdNIz+RPOfjLUUZ/ne2ndwd8EXoDvHuDi1rAnEJ9KqUVa6dJS6/cQbWQcf00rf45JpymbgsDcp5qM9WnnXX1j47ZEvC700f3XSeU5NlCV9Ce6McWv89Eu3304Xp6MKO2ByvMZQtDOmnVkMKtPP0MY/q4Id0LlGgBcqhm2LmS2E50NqySzBwNz9GtANlxqkZa4D2bM0DbXJnDfUrMSO3xpwq722Wxct2yvOoBaYPJMiILRsGGcjLQmdIIR/uWr6j7XRV86l1GJOZ6wbZjooin5GN7FdRwXDrG6DVu5hSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sat, 10 Oct
 2026 09:52:14 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 09:52:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't leave balance callbacks queued across a pick retry
Date: Sat, 10 Oct 2026 11:52:08 +0200
Message-ID: <20261010095208.276806-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF00000AE5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4b3) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b91b138-5247-454c-a814-08df26b427ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|6133799003|56012099006|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fRM40DYa4PVFw2FLo68mQfISC9fPMM8mZ21q1OEOk0944h4d4Yb++IhIuRJrjF55GuL3uzg7sWjOeNDPmK/6izarGM5ynjvUQS4RHCVmoL2j/452OuD2SYLqA2BaHQ7r4bbWYnaRoOKDhQBYw9SFpPBAF0EXVp1ejIwJYBewIYgMiwSdwptxV7yhKhTTTYo8BmT/jxuIA6IguBBWWBpz7Dhh+5MLG3/QYxS3kkTHlmTFCSoteUUtXGwyo5ZtN4x5b3T++7lsqkN2+6QtWRywLDOVKUUK6EhHIAXY6MJSuIk0Ir9UyH3dXS1zl4ebYPPwefaByLLYLL05ObUkuvhViz+2uokjdsjnQQrPUWDB/KucRAMAZGYoP4srOsZD+m8X+8q2d9n9e6QGIuBQ4P57TMSA4F3WGrCwu6/kFM4ZmOYiyADuSBWbjyw/z71Vzx3LVlHAktVnyot63gakYnVUeiswrpTZGnqOA6+WVZRC/qpYhtKWmVY1YkYstoHtBhZkfRLMBuELquH5F0dpVzQu1duXcJ3kD8sjMbKaimIW95uglNrO9dU2J8pe2VuOF6Uy5jq2hojdCifxUVAUbkmUWt71E3GDxrIPmSqvV5233dA/P9OpMFXA7jDQN2XGZflL5TtW4czX3AHqNURpsNvsR40hmK9yXDK7098X1tdyRNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGyH7KXoCUw0pAl09UzMnRdYN+v3tifgzRe//1ARYUkyz4DayGrfBU37RmFH?=
 =?us-ascii?Q?a/pTjRe/qjouhGhyJRSPC129wOlWJ2unA9TiejkDidQo/ZLBxBFyG7F2Zoo4?=
 =?us-ascii?Q?HHTVMvsas0RTzdCL3NZuTWRrMjXwAzVp0Ko4cNXDQFaQFnzDt0HP+lzMrvUE?=
 =?us-ascii?Q?boeTjUjQrfJthlh3KTbBqNPRwdFf+YcgScuE12RTvE2KNBwwI5lTDgo29xZF?=
 =?us-ascii?Q?8fAVGdnGikWqeG4qz2ACpPO0GXFiwEmE/tbFPrq5dNVq8HiyO5UmnwCumiW+?=
 =?us-ascii?Q?4eaI2EdaFC5RIV7UauAniA1NvQLdxIxDe+loJXLJ/zKqtNeJnEz353s/4FUH?=
 =?us-ascii?Q?IwKZ+StINEBq24BSAcrOWdA//1dl10nDFXSghBLgt5OrzVwaUwyoVMLQTkU0?=
 =?us-ascii?Q?e36/NYrnWZTHiOQG84iDIoEOpzLWYvIBj0X1m37vv9NAF5HaL/HBs9EnBqnY?=
 =?us-ascii?Q?xnFuEwayCu2Ry0Cy5x+Nr5zKvGi23ph6TEERumOXxgkbwMZYTrYKbWrrsOlC?=
 =?us-ascii?Q?TjsqW0pO9CyVaMK5nYu4hgAmFov2wSfCTJAWr8ok+8XueAzu3lkxUoGFpe7Q?=
 =?us-ascii?Q?XvSNLmOkgBmGZmlzp66z6VuEOoYaSEXzNSdaNILhEgColNTb73uxUKC9IVKW?=
 =?us-ascii?Q?JgBX/XLVEFZXP+lZ03pd5TIiCAaAnv9sv9uCX/zzcl4LGqbtkvDV4+0E7QGe?=
 =?us-ascii?Q?2hFeq8DIsjOrkvBumdXWAJvvJzipQ++fMD4zYgxIcPRM6ljLZ9gawAKWDA1W?=
 =?us-ascii?Q?LMURMpST3p6YOWdhWj1lWJPZCQgU6xBUD9pADz7yAO7jabcUdbKSN1EhWdaE?=
 =?us-ascii?Q?5vd1wfPouMWvrnyosxWU/csgfBGLn04Dmk9AMksVF51++aR3cgNPzcNLrW6s?=
 =?us-ascii?Q?66gWMKEIXQ90DgSspps95OFR96QyuJZAjx78s9RZmCoDwFRBoqFmnmOmFopN?=
 =?us-ascii?Q?jmXkJVfAJbzuBA/I8eV2iSoYzIeNpmDaLzHRTVe6n5NOECgqn/mLcypwxNPy?=
 =?us-ascii?Q?eGOrFRHcsv9kcQv1+gZgbu4FshCc/qu5Jh5AetzAUd/wy9KhhxOz5vQLk2jt?=
 =?us-ascii?Q?ByYBl76+drgS/cmtX5d6pcibfRBY/VNwA42NX5E7GjcQ86EAkJUL0NdTj75E?=
 =?us-ascii?Q?/fJJvnXDN/TymDXzNga0R42wZ+sFwR2pjt5757O1ShcI8iiGSvRg4g7nMtiM?=
 =?us-ascii?Q?c/9ZWI7EW7PwdcZ7TUMcF3jICzcPcer9Al/2OUUEBQ8o8gUuYkOtbGdz3iQx?=
 =?us-ascii?Q?3y+D8jHkxJfO2PVNb98VGwvYaC+urf3TPYR+blefLElpLwDhRjRvxZRade5/?=
 =?us-ascii?Q?7TiGNGAKskmkNV2+9BAyA45LpZHrv6mEj8N5zgWxrqzWAQW023jR+DJfpqEj?=
 =?us-ascii?Q?s8kxevszDuZVvsfpa8tJE+ZDiJuqCP0x7Ly5UL/47bxEetIPgePSqL4Xl5V8?=
 =?us-ascii?Q?T2RE7QwEmMhMwq0hk2545PdRKbobJ1AXsLdZknkrV/wlL7ONYY3gw5SXVWbc?=
 =?us-ascii?Q?+wyCwZzk7/9t19aOfnb83RONyhcaJAmgLFwiQMZfCB3uHKXN8GTx3dxyMmqm?=
 =?us-ascii?Q?lS04MG/OrhUc54z4DlP2n4SVRt+e/gD7J65KSsYMXo+LRU1OIVE8RvFoK/1z?=
 =?us-ascii?Q?qfuZgBew2AV3zMYo6GZ70zk4NFP3uhE/KD9AEcKZjJ1Bwau3sxhfdPmmry7P?=
 =?us-ascii?Q?3TwvEc/smST4/XZf9e9uMWZ20QzXwAQkNQ1JK+PHi7aSJF8+jvF85Fw75/G4?=
 =?us-ascii?Q?p8pHERruJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b91b138-5247-454c-a814-08df26b427ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 09:52:11.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHkKnF+6h8W6uuei8drGiDqJExp+gw+UPPVLgIiE2OiayMkB+nJgRLTymO8UpJl1CUfX9YY5LBtGNFLFEV0COQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

The dispatch path can request deferred work to be run from a balance
callback and pick_task_scx() queues rq->scx.deferred_bal_cb right after
dispatching. However, a balance callback must be consumed before the rq
lock is released and pick_task_scx() is not necessarily the end of the
pick:

 - it returns RETRY_TASK when a higher priority class task has been
   enqueued while the dispatch had the rq lock released;

 - the dl_server pick can return NULL, in which case the lower classes
   are picked next.

In both cases the callback stays queued while the core keeps picking,
and the rq lock can be released again, either by prev_balance() or by
another dispatch. For example, with an RT task as prev:

  __schedule()
    __pick_next_task()
      pick_task_scx()
        dispatch_pick()
          maybe_queue_balance_callback()    <- deferred_bal_cb queued
        return RETRY_TASK
      prev_balance()
        balance_rt()
          pull_rt_task()
            double_lock_balance()           <- rq lock released

Any CPU acquiring the rq lock in that window finds a pending balance
callback and triggers the following warning in rq_pin_lock():

  WARNING: kernel/sched/sched.h:1919 at rq_lock+0x7f/0xe0, CPU#10: stress-ng-sleep/533
  CPU: 10 UID: 0 PID: 533 Comm: stress-ng-sleep Not tainted 7.2.0-rc6-virtme #61 PREEMPT(full)
  Sched_ext: qmap (enabled+all)
  Call Trace:
   <IRQ>
   try_to_wake_up+0x2c1/0x5c0
   hrtimer_wakeup+0x22/0x30
   __hrtimer_run_queues+0x1d5/0x350
   hrtimer_interrupt+0x106/0x1e0
   __sysvec_apic_timer_interrupt+0x6f/0x210
   sysvec_apic_timer_interrupt+0x71/0x90
   </IRQ>

This can be reproduced running scx_qmap -I together with a SCHED_FIFO
workload that frequently sleeps, e.g.:

  $ vng -v --cpus 16 --memory 4G -- \
      'tools/sched_ext/build/bin/scx_qmap -I >/dev/null & \
       stress-ng --sleep 4 --sched fifo --sched-prio 1 -t 30 -q'

Fix this by queueing the balance callbacks only when the pick is final.
Otherwise, defer the pending work to the irq_work path, which doesn't
depend on the current rq lock section and leave the kick sync wait
pending for the next pick.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 74 +++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ac8fe70a9fb6f..10b3b95f70a1b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3311,18 +3311,6 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 	rq_unpin_lock(rq, rf);
 	verdict = dispatch_one(rq, prev);
 	rq_repin_lock(rq, rf);
-	maybe_queue_balance_callback(rq);
-
-	/*
-	 * Defer to a balance callback which can drop rq lock and enable IRQs.
-	 * Waiting directly in the pick path would deadlock against CPUs sending
-	 * us IPIs (e.g. TLB flushes) while we wait for them.
-	 */
-	if (unlikely(rq->scx.kick_sync_pending)) {
-		rq->scx.kick_sync_pending = false;
-		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
-				       kick_sync_wait_bal_cb);
-	}
 
 	return verdict;
 }
@@ -3349,16 +3337,8 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 
 	verdict = dispatch_one(rq, prev);
 
-	if (cpu_of(rq) == smp_processor_id()) {
-		maybe_queue_balance_callback(rq);
-
-		/* see dispatch_pick() */
-		if (unlikely(rq->scx.kick_sync_pending)) {
-			rq->scx.kick_sync_pending = false;
-			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
-					       kick_sync_wait_bal_cb);
-		}
-	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
+	if (cpu_of(rq) != smp_processor_id() &&
+	    unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
 		/*
 		 * Balance callbacks must run in the context that queued them,
 		 * so they can't be queued on another CPU's rq. Run the deferred
@@ -3384,8 +3364,45 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 }
 #endif	/* CONFIG_SCHED_CORE */
 
+/*
+ * Queue the balance callbacks requested by the dispatch path. Balance callbacks
+ * must stay queued only until the end of the current rq lock section, so they
+ * can be used only when the pick is @final. Otherwise, the core is going to
+ * retry or continue the pick, which may release the rq lock (e.g.,
+ * prev_balance() or another dispatch) and expose the queued callbacks to
+ * rq_pin_lock() on other CPUs. Punt the deferred work to irq_work in that case.
+ */
+static void pick_queue_balance_callbacks(struct rq *rq, bool final)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (cpu_of(rq) != smp_processor_id())
+		return;
+
+	if (!final) {
+		if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
+			rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
+			schedule_deferred(rq);
+		}
+		return;
+	}
+
+	maybe_queue_balance_callback(rq);
+
+	/*
+	 * Defer to a balance callback which can drop rq lock and enable IRQs.
+	 * Waiting directly in the pick path would deadlock against CPUs sending
+	 * us IPIs (e.g., TLB flushes) while we wait for them.
+	 */
+	if (unlikely(rq->scx.kick_sync_pending)) {
+		rq->scx.kick_sync_pending = false;
+		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
+				       kick_sync_wait_bal_cb);
+	}
+}
+
 static struct task_struct *
-do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
+__do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
 	struct task_struct *prev = rq->curr;
 	enum scx_dsp_verdict verdict;
@@ -3447,6 +3464,17 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	return p;
 }
 
+static struct task_struct *
+do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
+{
+	struct task_struct *p = __do_pick_task_scx(rq, rf, force_scx);
+
+	/* after a NULL pick from the dl_server the lower classes still pick */
+	pick_queue_balance_callbacks(rq, p != RETRY_TASK && (p || !force_scx));
+
+	return p;
+}
+
 static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	return do_pick_task_scx(rq, rf, false);
-- 
2.56.0

