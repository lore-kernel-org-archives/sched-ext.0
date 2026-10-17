Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E353403EB
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250558; cv=fail; b=iOiuhr2LUqkjT0GLNi16B+jX+W0lnR4Vj3Tl6m5PFri4TFBXzHAA6fhX9NcyyGB9nYw67PgwokZYHJT1kPNW/dsd7WO9k9tWNQrK1AYoeYvqh79dpEKNykdAvF2X6ukyk/dF686p8GvaTH7CZ4uhToWOqeOXSrkTJVx+cftRGoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250558; c=relaxed/simple;
	bh=wwaliUoU5TSqve4VxbDncWNaUbNwR1XaHlb9xBZpoVI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TY17K/4Mo2U9/cEvhoBSbl0PoSmeepvTw8rtBdaxICLBclaOO7o+TNTSL+mXkFd/K2p2IzyNP6VC74yN3Szu144JPTgCiaXdKmxozXQOyKgcohXFpMUHQGgWB710HAA/5wAQFGKWg0JwVc5Lmym6xeHYRLXaOzglrYNS/iHFLRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=txlz5gL1; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="txlz5gL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD44vLQQwcW/SdLN5qKpwLwAA1/VFbsBcVXRRVpCAQKC89Kx/V9llQ9SH1qqfXNQkDqhh07Y9OoVSXXrxslESUG8XUVUCVfMe4cPoC58TrdgAkJvWVWBDHkg3vZRczJvgAn8EwHzLx11p3keg3IWkM/coeLY2qZVNVykoq1Qf3Chy6EgeOvxfraETH/OhCr24NGJHQ63nNE+jDyOf4FZufgI0Qfu1iiWWxgqNXs1Cd2tTbwAXJ4LnjaEFvj6YReUdPzWmuQ9H02ApWM6x0a27TC5eEmIW/uGTfwnL7NoFKpxzUfmcG8iY9PslEgCf8wMhXTIu6Z5zVGm6VDrJxU3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEY98rzHKWksIAO+5IR1OCC3dOTWyusLzjY33Ah42Uw=;
 b=a6oKR53fd38jYbzKXgqScYz+YNoJYFXh2QRcWUlnSYBZZ32nA5CS795Uv5v8ZfjokZu/uzwrMpCBc1h+0rsniTSh32JyUOAtbTrFQ1pZXUZPpZikmJz+famfc41zPDv5DGGYW01lMcvL5+Ks9RiIL0qo1sdPbxDiuxhJ82nJF0rgX/sz8Yy1JwCInT9WkSptZ/YVMsSG3RBnb7bX00hP4AZGSp+Mn3tC86crZfYcTUZiRLYbiWsfQBPbbvXRb7kHNt66ywpw47Uu4gBFt6kmqEeO4uXus3EKtA0H35ShXTAR9JABwnRD107H86AXkvFg2Ldm6A3UuCVio/pZxLZrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEY98rzHKWksIAO+5IR1OCC3dOTWyusLzjY33Ah42Uw=;
 b=txlz5gL183rYIR98elrmTo+uwqi+tzAsQMfB1PnWCesLGXbByo2QbfYHQWtsSEmQw5QMpBip1UNqm2w4JWUer+chkVDmgOp+J71bqai3R6SycuVCmyF96p8tQi+rsMC7gWccdqMQ/afSDvbjE1cP9k7NDhgtVwmtVk7QFy8kSdzpTLZPYZIdxzhAr1q+PV3rAAWPjVdbCXUQljYtuGQikdP+qU92pkGFwpvnnrql/gwDRj7ZU6wey4Rxmfy3M4xk8p6BH8uosv2mhzfLVXYGgn3wDkT5Uvay87kq21d/D1bDksa8Vwo8N9vEjI7LXdvf6Afsukbjlrv41bFChWMnMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by FT1PR12MB798771.namprd12.prod.outlook.com (2603:10b6:170:1e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 15:22:32 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 15:22:32 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Don't leave balance callbacks queued across a pick retry
Date: Sat, 17 Oct 2026 17:22:26 +0200
Message-ID: <20261017152226.3690249-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|FT1PR12MB798771:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f95d59-8c70-4199-97b8-08df2c6276c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C1zWSPd7Ng2Chwaa9Zrl0B5gymyZ31dGqpSS9xcLKKbNCQ2FOYhGU2qI8N1GKyme7qz8MZ/S2pG+1xURcB4Uf9HxriUR0u46gwdmEyV4O1ggOo9iikhTI2kXh7FnLRbKSL1gk+rooz739L4MJg78+q/TnBt+8js4aK98LShIxJPvb8n9yLCezAqHz1+2JiE9uNFZj+5F4OD/QiWJdrRpCzX91vxVn5OUCZSnGSliCh+UNvqN1mdecM7EwTvTa9OplBK+5dYb3gNa49EBVbISTNdoRsA5CqiS7pLcIUCwi4odT2AvU6vTddKQDMRgtV/TOlQtfEFJVaQS3aNcIByJyd6xucHEwaXCdYUYkFFVHjipUGDg0dPANKUx5X9SYQlPCT3FUIqMoWipHPpbqYaqsYgKeKikxFfn5T8ANeiBdCUrvKZCeWYRRYn2CbmcZV4tHutYGy2DpauKYXLIBQ6+Ajru/2RjIODVulMtpii0vHUjpfhvvGxuRHrsjyDSQLBRIq2tzNmkTbVxnCjt4yPHcYROI/LIid5QdFuzxJVKoWr/+RMrg2zk0P41BpECkht6Qk04byTeAXO7elsvowQPwX1ZdHiNtDObXtWJVoLrrfHOccUcfJyL/wOVcrL9v6vzCd9azVRPP++5+Z2cZ42ArIOcxMFiM8OsEbjcaXmnMoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KKZtelcV0NER0b5Ya8mQb5dM8a5YzAGf+FOIq1LVDJju1the0QDwQpZKv1e?=
 =?us-ascii?Q?qK1HjZpcF7xfFedpTIhBrZr3RJH63V0eyDiwLbGmbShQ0SUjQjWO9+QoLx0C?=
 =?us-ascii?Q?NVbLLfgXdGfz2bJRKRv1EJRfHpctqI93m5A2V2ljFRj4ATLI00Z4fIowj7Sn?=
 =?us-ascii?Q?e+N3+aY5pfgL2nQ0NsGLD5PNTJ95B6jXjzyGIgS0M+hzjjBMKXBiEZJwOemJ?=
 =?us-ascii?Q?mB0jDVyCiEdjZaXpuNYwfUpOXtRohl7f7efpFjavJnGvk5OnufF8tqwKflCv?=
 =?us-ascii?Q?KUDT+MC0PnNDgye1+A4lwaeVf0AFnO4Yqo80lmXmNdpKncaa/p1Eat8r28JD?=
 =?us-ascii?Q?GriZfhbeUg0GgUbxxCLo5cc60e6OGFvBKQ0/PAxxl/9LaiE6APqcngK4gLEv?=
 =?us-ascii?Q?4qvZPIk7RDrhC5LyrIpaW6zFUputgWLRDlqSmbRNNB/PSz4lJG9gjt09F/Vn?=
 =?us-ascii?Q?vptnIhruM9zTOEDVpFOnb/A5xhr+hy1914AueaoyxqcnomiigbThbaxyvLqy?=
 =?us-ascii?Q?atEgwAPsAi4HVrKBdc+AqxS2QONiYtWQsMLCpVaMnOFP1qiExDIwyZcs8135?=
 =?us-ascii?Q?jX19dvrifEOnWyB2k43McixcKFNre3ggRYZOLWmW+nhZJTX22Oy1PvK7+fvd?=
 =?us-ascii?Q?cW3C6rK8jxLEHhcFBRI/z+BA4xLjcMSR4FtY54sd9/cbg8fS7+oCD1dXy4KW?=
 =?us-ascii?Q?OD68HIRVyXn4jbvB8db4CNQvvDbNHfQyP8W8ltTzDzj+U28tcgHAjEIDFWoP?=
 =?us-ascii?Q?IR2jvmxpkCe9o3YJZJ30SBqnmWOanNfq77Rz9Qkg7SvJg6Ktvg9aVzV7fQ/H?=
 =?us-ascii?Q?ka6Qr+8I+Xzxk4FTg3T86WZ6BNdddfXCp4teNy3A7mrkC/HSRIfdp+IWCW/k?=
 =?us-ascii?Q?1fJAOsaTR8POWOjVdvEZkAKsircuaWIRmdN8z9AdRgMscbIjoRHurFY3bgST?=
 =?us-ascii?Q?AGz6bUnMJmkD/BDwOgNglk7o8Yc82nwaw40P93B8R5ZOlUb+ztU7sHFjZmGE?=
 =?us-ascii?Q?FdLE9wmJf7uxxiJ1u4oSykwKjGaS4oG3a3DO7pqhrUv5ZGZXv8GIL35kYjhm?=
 =?us-ascii?Q?Pv+rC7tYwQuTIbtL8WHGeoL+PS1xWQ8Y2n+l1+VPg1TtTCshXIt9th7oxxcQ?=
 =?us-ascii?Q?bkeJ/7OPJ/EO1DkewcEYa3gVbILzNKjwwDqrFQFMqciMZ0cWxw3KTarhSMY7?=
 =?us-ascii?Q?XPD5LAfnvXkY4Jreo5Tlxy18jZvvi/NBtTENEGOhmlO/wvrfvawP/EksQWiI?=
 =?us-ascii?Q?lnvqPKxU34B1oELK9bWYnq/avB6i7P0d8ymFRkjBwCQeyZo9qYZxxjHeWP+N?=
 =?us-ascii?Q?FsA6e3GUwiW5O1FMBFMJ5qoLjvxXDJlwTiDqepILexAMhH+mY6ZQ7ryU8nRM?=
 =?us-ascii?Q?GB4fjDtGeD4yCrwFVC+YEO6CFvuQCh8o4n+K1ZSHvDe9hePvvRpL+wle+vme?=
 =?us-ascii?Q?70XfsjRSOg1avcO/6yQ+IRKT0VA3kJAWBUiC731mHLvoEz8pl6RNZiFaUJHi?=
 =?us-ascii?Q?ePSs21VZGdjRSFNhOLtK9IafnStm5LVD7pNA8c4bCrUsXDLiv5PssZhqvtX1?=
 =?us-ascii?Q?Nr+xB85UfzAQAnlJF55tL+DEMRPTZaObayHnhEeQYaiYy1vJ0hAs1AQbn5WV?=
 =?us-ascii?Q?fjpHsYkbElGjBScdLqGz5EPqbdARHnQpa0/xx9zU7yQ+fn4EqOfUXJ34C+mH?=
 =?us-ascii?Q?0jGBaRY2PWsmZzedVVqXCZ/ME0UJETENYDlG7FveTCIVnGCx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f95d59-8c70-4199-97b8-08df2c6276c2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 15:22:32.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otXH1qXYmD0MdHiCi73i9ZPiZdCE6dWFpDeu+IK+qXscrkf734UkGWktvXDgX+OIRWgq6ukKkn//SIXjoTMT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB798771

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
depend on the current rq lock section, and leave the kick sync wait
pending for the next pick.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Fold the balance callback handling into do_pick_task_scx() with a
   single exit, instead of splitting out __do_pick_task_scx() (Tejun Heo)
 - Update the comment above dispatch_pick(), which no longer queues the
   follow-up work (Tejun Heo)
 - Link to v1: https://lore.kernel.org/r/20261010095208.276806-1-arighi@nvidia.com

 kernel/sched/ext/ext.c | 73 ++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4259578186954..0e93a5c45ede4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3353,7 +3353,8 @@ static struct task_struct *first_local_task(struct rq *rq)
 }
 
 /*
- * Run dispatch and queue the follow-up work for a pick.
+ * Run dispatch for a pick. The follow-up work is queued by do_pick_task_scx()
+ * once the pick is final.
  */
 static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 					  struct task_struct *prev)
@@ -3363,18 +3364,6 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
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
@@ -3401,16 +3390,8 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 
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
@@ -3453,8 +3434,10 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	else
 		verdict = dispatch_pick(rq, rf, prev);
 
-	if (verdict == SCX_DSP_RETRY)
-		return RETRY_TASK;
+	if (verdict == SCX_DSP_RETRY) {
+		p = RETRY_TASK;
+		goto out;
+	}
 
 	/*
 	 * If any higher-priority sched class enqueued a runnable task on this
@@ -3464,8 +3447,10 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	 * If @force_scx is true, always try to pick a SCHED_EXT task,
 	 * regardless of any higher-priority sched classes activity.
 	 */
-	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
-		return RETRY_TASK;
+	if (!force_scx && rq_modified_above(rq, &ext_sched_class)) {
+		p = RETRY_TASK;
+		goto out;
+	}
 
 	/*
 	 * If we're keeping @prev, replenish slice if necessary and keep running
@@ -3481,7 +3466,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	} else {
 		p = first_local_task(rq);
 		if (!p)
-			return NULL;
+			goto out;
 
 		if (unlikely(!p->scx.slice) && scx_task_can_stay_on_cpu(rq, p)) {
 			struct scx_sched *sch = scx_task_sched(p);
@@ -3496,6 +3481,38 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 		}
 	}
 
+out:
+	if (cpu_of(rq) != smp_processor_id())
+		return p;
+
+	/*
+	 * Balance callbacks must be consumed before the rq lock is released, so
+	 * queue them only when the pick is final. On RETRY_TASK, or after a
+	 * NULL pick from the dl_server, the core continues picking and can
+	 * release the rq lock (e.g., prev_balance() or another dispatch). In
+	 * that case, run the deferred work from irq_work, which doesn't depend
+	 * on the current rq lock section, and leave the kick sync wait pending
+	 * for the next pick.
+	 */
+	if (p != RETRY_TASK && (p || !force_scx)) {
+		maybe_queue_balance_callback(rq);
+
+		/*
+		 * Defer to a balance callback which can drop rq lock and enable
+		 * IRQs. Waiting directly in the pick path would deadlock against
+		 * CPUs sending us IPIs (e.g., TLB flushes) while we wait for
+		 * them.
+		 */
+		if (unlikely(rq->scx.kick_sync_pending)) {
+			rq->scx.kick_sync_pending = false;
+			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
+					       kick_sync_wait_bal_cb);
+		}
+	} else if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
+		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
+		schedule_deferred(rq);
+	}
+
 	return p;
 }
 
-- 
2.56.0

