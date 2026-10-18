Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB345DF41
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340674; cv=fail; b=ih53KeyUadjMgxj9ybyNH09AIGGcrR8TOQPD0bNBWV8R4gQwY9liVbSJQ6KpvMZqvXB5Y6AdsSnjopsf7PnhyJog0hGjefcGtZGGCvuLVPjOwO7+HnUnAwY+vbBrP30OJm6TKIdnIFqFKafZjziRKlLWNqCfElaniVfk+AIFUNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340674; c=relaxed/simple;
	bh=c0v20HzAXCdEUyc/O/GdMhlDiRYEh/tcKZ+OE6Kr6hM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o+tcd9TAdgLVMICgmmfR9zg1vVsO9WTyoORBAQUd+AZM8Wi8+BrEwQkPPeMuOLT/tLr/GGpzPBGvb6XozX6cWiC9u6SSLXenm2pTlpnKNMTfxVDBplg34qFs/w3QlFJjPSspDLMZZhMKmWmTa3MjtW3oPUEWtNlNfLDPJI9Js98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqooOpK3; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqooOpK3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb4Tu2sbz05bb4AuA5e0pTutbD5Qgp7wDzg5q/0W7bFSIuefT6K8qh2T6yk6GKF3L8R1IO8ZtIRSM7vuUUFKFYEv9A/hoH5mMhbDaBJD3O5noC8tqvLyn1MVPCXQ40tjc/ysCZZwPTrCD5cQqp/EeGYO3g9cFllKEZrF/gqRAzcp/H0wj/xfSCWLcW84fLWkH7TCX1tzU29GzGYzk/szTGc+wRTw6yK/vPequ7PNa8GMf2QQ4MtBTgjwA16S9FRIZkz2xMWscf6rElS8TQjqbGQdIOlmuKBTPXTSsURbcUaaOoOlEpuA18Ntzb8LkBXq1qVvXUIGcmkRNKtk1Qta7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAkisoIyKb7ubyC6LnCMmD4w2GduaqrARNuQUmZMwGc=;
 b=JlxhP8mhjWQ7xSM9v4CxLZjoEA3iB8L0P1hT6xGkqwVAKO/QYN8sQZacKfXUZzAu/SCIStNof1AAja/wN5wLTvQqexFledM2WbNTnptUb+pbfuSzQEUh4e4mbGDSdoCbxYZT7ZLdd4BiY4rYVla9naZDy3nz/2s6ErkrSepO+2sCLvo3URdThsC2gpKMTiwTvwVAOC896+MqX0cbvJ/JUtdw4phlvF7wMoJE2mKJpPdWZqremR3DvJUs1EcatG90l8fbs3+pdCMf3acXeMKTtl62IYJW+dHmk+Ct81FtPVgIOx6LpGMxHiFkeMlwh71R/pfXM7KJz8rJe7XUF21+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAkisoIyKb7ubyC6LnCMmD4w2GduaqrARNuQUmZMwGc=;
 b=mqooOpK39/YWFVlPag22XBr0p6eMltmYMatB+RDsUFXuZMmOu2T+t/h7bCNk9aUtnsh+FOLhtZ3jjEXptW8Crzcf0IZ5gqDmGf8/p42YNfHLnBAPbKovQ0kjvsUPIWQzHuXp4XCyzyrgmbX5LiolW0Xur8epNHX6ZKUqmZyZlFH/ArU6zYESM1YA4WVARubCe4mVoHrWEweDvGa3lGm/I/vpamD5irem4diXUOzspW79Q8RDDABnLF266anRP4HAgjF1heXWKEgLTt5NBxX7fgk6WHMK03Pf7vEpvKnzkwZ2xVReOEOClXSH5Eo/yuXNaygJuDO499cWNax0OuHZSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sun, 18 Oct
 2026 16:24:28 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 16:24:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.4] sched_ext: Queue the kick_sync wait from set_next_task_scx()
Date: Sun, 18 Oct 2026 18:24:15 +0200
Message-ID: <20261018162415.55913-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1ddb5a-5659-4639-e902-08df2d3447f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|10067099003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	u+XGTsz3OGds4Z+nOr39Yn//RUjyGzWwsYFnFjTCixNhCZPMP0VUYTykj0xy3P+7HaSFrbsdDdD36tYq1G3XPRywsHKL2GlIaFuvHYBqUGCZ26lFhRQAvDW2wJUevAdQtmKH7P1qyVZKXOL/SwUeUxr0rJTmgOk+IsQILWLdsMzRa78fcXLgJ1IWvcH5XJogsNBO7RpADBIkrn5+x6qlcH+VgmbonzwfYLb1wjU0Z8MGe5aYKOLkkXsi9oCLBTveer/Fe3oByNYXcAqJu/CJcVXWYjvVgAPiCOepDRViYFzxrh1JWmu4W3y+aZfdRxHjyACro9uhT+RGFBSAXWm2JFqI06wxsM2bbnx2m55Y7YX7WN3/9yUNwoSiGvttQlch3Ja4LO13Cs0SLLofo/r8i1aTs0GIQTFraIAAwq05S0zdPrAs2R1QdzFmFvfSdaItgUH9gp2c/HvmOz/hNw4vNJ3h+bNOsiHshbKUCeV/rwqR4geTyxmWTUiK7lThPWhXNmRBv+ITIYidcJdnp9lOJaCnMp0eMIpWcjK4CXAvvnY9SJWoFT4F0/KvOCSxlPuJKc60yJU446ubhSmmai47wexGA/JZHrK1Rq2R8v7NvlomHumg8qI+cUnZxU7ckav0r5/D4olTVBE2HIgIiuDPoEnVCqhPNHYiNdYWjZ1Z4wI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(10067099003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nw/Nk/nCnLEyJByKOgeO0LN+t/Zo3xQN+bPH5s24o1WmVX8noO6f0A/pCv/x?=
 =?us-ascii?Q?eRs9BhW3zX2Y5bYYxpXYgaWG5W3+gysDnL7EWabCIkMTewYDes1OBgNym9tg?=
 =?us-ascii?Q?n0sfpZrGCBwDXHtgIZnjjhnvOlbSU5opBO5Y74ia4pAdzRuMAIpyjIMvXC2z?=
 =?us-ascii?Q?Zgq4XsnO9YlFAbZhYkbjRkIBFMqcBOgx6SimLLZAFhxbjsqCwvSgEaPDxyCf?=
 =?us-ascii?Q?TzAUYHoGenLubWYRIbw1n5XPTgD49QuByWjZdNRM9ueFkyQAYRJR0a2fDmTq?=
 =?us-ascii?Q?8R5YqO94E9tOKhOZjb/9saOp9VzMvL3ysS4iigmE0QrRZ4pPgUT3EbloPW2A?=
 =?us-ascii?Q?gUu1ilb0nfCYQeSdYZq/PpFq/i7NhZf0nrpuEs2BwDNJawITkdKNUHn03cYm?=
 =?us-ascii?Q?MAM0XMf52BRGD14MX37JbTIRRFAbqMAWtS8sl84jSkkYIlRoHhpT0X6LBFpZ?=
 =?us-ascii?Q?gH7ykt09X+h5gxJ3s3WismACzRDu6vujI4CnUtnaswd56u9phmzfSWkBvuSl?=
 =?us-ascii?Q?0DDevM42jKN0FtooVDwoIsgGbSBxZ2ol/ZJ9TTKvrxNuQ3OXAYt9oVQLNQxo?=
 =?us-ascii?Q?OjHxswhQRB77xaNX8XXXD/uV/4CONJJo8nv5D9NS+oWt09T34Kab6LlKpeS+?=
 =?us-ascii?Q?sX6/K7eUiGC16/sdxfdcFUqssQQoZqxO5zxx5QlWvWt4jZB61bFCCxxxRsJW?=
 =?us-ascii?Q?ZjbtBf7zH58IfsNPBChgdSVWyOnNHHukGjZn+yL2vzevP7w1mPf5A1dCY3G1?=
 =?us-ascii?Q?7n3hEPiCv1q/Mn8cP0xWJHlvw1NkNqtLrwXxHUurv7qeQgz77m2CQLeR7Bzl?=
 =?us-ascii?Q?eYCWsrmfnFJ8hVSjfDd49up6IRh33/PeoZOmqhviYL47d+vVy9V0N2d2DXCl?=
 =?us-ascii?Q?lGHAsbD6dL6y6wJyomn+m2+OzG+qbThfUBbwvnrFMl7O2CEw1XYPnaufvAGX?=
 =?us-ascii?Q?t3KNSdYrnso9dp99u07ajFnjm49QLL5o7EB+hHo7ZBZaO3iv829F6Q2MJst9?=
 =?us-ascii?Q?R/xwS4h//a1ch3cm+d7X/T44tCVdSze0O2vcN5vf9v1E18xf6am+j/v1fjBc?=
 =?us-ascii?Q?WBfNJPpEdDtvu73scv414I2A9nvykfcwx7b9jqTMIyM9+4NuPgboiuOZ7tXf?=
 =?us-ascii?Q?Jwgz8yZCkTCKuBM+1BmbyIyCfd/8TpYRcjWrer4SqQ2xIPTcajcaoAJOs7p5?=
 =?us-ascii?Q?0fKb8p8t5UwUM0n8bNNXIYp83cdR++vZL4ZdAi1wW/QpomMAyc4Jvv1dkt7S?=
 =?us-ascii?Q?uV765wObSrN85QZErSjvz2SKJktBhHK209XLSd//RS/SW07wpdB7DlmQE5Ud?=
 =?us-ascii?Q?ZYbJzTerdQw1a2Gnhu1TsTm43GfhDbXmorA1EyyfFrW9wBC0Y+4B4yKbejbL?=
 =?us-ascii?Q?bbmtUwaAZxd/YCCQrB/HO8/lJ6PZOMsURUCdz3KOi2q/G9TROVHlXQlZoRcL?=
 =?us-ascii?Q?bw/09ckopM+7y4Ac0yL9qhHloKi1CwMy+O02G4N1p9HmR9mpOcnog08fvFPu?=
 =?us-ascii?Q?PfXmODKZqAbiP+nJuPPYEcxSTCsF1LXMRf5mPC6L/bdixrMPWc9C3wgT8x+n?=
 =?us-ascii?Q?hNHUNOTKRsd5JX6Vdfua4EJZQZWxiNojpzfLKBBLxqapU7dq5LzSnlQPvXKk?=
 =?us-ascii?Q?ydFoMr7dzVahW7HwUst4e6E8rmydTLN0p0JWHzRkGIJs5DvYy6esNnsidE6x?=
 =?us-ascii?Q?5KFZisuN2uolZ6eD6E2guAdJ40hUilTfvGBUOJpFgvK1t/iPFPeShx/PzyQe?=
 =?us-ascii?Q?y5uUOULNPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ddb5a-5659-4639-e902-08df2d3447f1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 16:24:28.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2CFTSI2dxJ70sUmjc6jN/ZtcW0Oh9cqIWdUN0QcxGjcTvhXk4Vq5hVQQvxRQc19p1OiJr+66ljOtubXayt2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

The SCX_KICK_WAIT wait is deferred to rq->scx.kick_sync_bal_cb, which a
final pick queues on the local rq. Under core scheduling, a pick that
returns a task isn't final: pick_next_task() goes on to pick the SMT
siblings, and their dispatch can release the shared rq lock with the
callback still queued. A CPU acquiring the rq lock in that window then
finds a pending balance callback and triggers the warning in
rq_pin_lock().

Fix this by queuing the callback from set_next_task_scx() on SNT_PICK
and SNT_REPICK. put_prev_set_next_task() calls it once the pick is
final, after the core-wide selection, so the rq lock can't be dropped
with the callback queued. If the CPU ends up running idle or a higher
class task, no SCX task runs there and there's nothing to wait for:
kick_sync_pending stays set and the next pick of an SCX task waits
before running it.

Also, proxy exec zaps the balance callbacks and picks again when
find_proxy_task() fails, so clear kick_sync_pending when the callback
runs rather than when it's queued.

Fixes: 415cb193bb97 ("sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback")
Cc: stable@vger.kernel.org # v7.0+: c72945693b90: sched: Restart fair hrtick after same-task repicks
Cc: stable@vger.kernel.org # v7.0+
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Queue the kick_sync wait from set_next_task_scx() on SNT_PICK and
   SNT_REPICK, once the pick is final, instead of taking it off the local
   rq around each dispatch of a core-wide selection (Tejun Heo)
 - Clear kick_sync_pending when the callback runs rather than when it's
   queued, since proxy exec can zap the balance callbacks (Tejun Heo)
 - Link to v1:
   https://lore.kernel.org/r/20261017202025.3834954-3-arighi@nvidia.com

 kernel/sched/ext/ext.c | 50 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aa00b75371822..e975e1086e7bc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3418,6 +3418,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 	p->scx.flags |= SCX_TASK_RUN_TRACKED;
 }
 
+static void kick_sync_wait_bal_cb(struct rq *rq);
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	bool first = type == SNT_PICK;
@@ -3433,6 +3435,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	    (type == SNT_PICK || type == SNT_REPICK))
 		rq->scx.flags |= SCX_RQ_PROXY_PENDING;
 
+	/*
+	 * Defer the kick_sync wait to a balance callback which can drop rq lock
+	 * and enable IRQs. Waiting directly in the pick path would deadlock
+	 * against CPUs sending us IPIs (e.g., TLB flushes) while we wait for
+	 * them.
+	 *
+	 * Queue it only once the pick is final, so that the rq lock can't be
+	 * released with the callback queued (e.g., by another dispatch during
+	 * a core-wide selection). If no SCX task gets picked, there's nothing
+	 * to wait for and kick_sync_pending stays set for the next SCX pick.
+	 */
+	if (unlikely(rq->scx.kick_sync_pending) && (type == SNT_PICK || type == SNT_REPICK))
+		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb, kick_sync_wait_bal_cb);
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3713,17 +3729,22 @@ static void kick_sync_wait_bal_cb(struct rq *rq)
 	s32 cpu;
 
 	/*
-	 * This callback is queued and normally flushed within @rq's own
-	 * scheduling pass. However, dispatch can drop the rq lock while it sits
-	 * queued, and lock takers in that window (the sched class change paths,
-	 * the scx task iterator) flush pending balance callbacks on release,
-	 * running this one on a foreign CPU whose snapshots are unrelated. The
-	 * kicked CPUs are already on their way to advance the kick_syncs being
-	 * waited on. Don't get in the way.
+	 * This callback is queued once the pick is final and flushed within
+	 * @rq's own scheduling pass. If a lock taker on a foreign CPU ever
+	 * flushes it, the snapshots are unrelated to that CPU. Don't get in the
+	 * way and leave the wait pending for @rq's next pick.
 	 */
 	if (unlikely(cpu_of(rq) != smp_processor_id()))
 		return;
 
+	/*
+	 * Clear only when the wait actually runs. The callback can be dropped
+	 * without running (e.g., proxy exec zaps the balance callbacks and
+	 * picks again when find_proxy_task() fails), in which case the next
+	 * pick must queue it again.
+	 */
+	rq->scx.kick_sync_pending = false;
+
 	ks = __this_cpu_read(scx_kick_syncs);
 	ksyncs = rcu_dereference_sched(ks)->syncs;
 
@@ -3922,25 +3943,12 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	 * NULL pick from the dl_server, the core continues picking and can
 	 * release the rq lock (e.g., prev_balance() or another dispatch). In
 	 * that case, run the deferred work from irq_work, which doesn't depend
-	 * on the current rq lock section, and leave the kick sync wait pending
-	 * for the next pick.
+	 * on the current rq lock section.
 	 */
 	if (p != RETRY_TASK && (p || !force_scx)) {
 		/* under core scheduling, see dispatch_core_pick() */
 		if (!core_sched)
 			maybe_queue_balance_callback(rq);
-
-		/*
-		 * Defer to a balance callback which can drop rq lock and enable
-		 * IRQs. Waiting directly in the pick path would deadlock against
-		 * CPUs sending us IPIs (e.g., TLB flushes) while we wait for
-		 * them.
-		 */
-		if (unlikely(rq->scx.kick_sync_pending)) {
-			rq->scx.kick_sync_pending = false;
-			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
-					       kick_sync_wait_bal_cb);
-		}
 	} else if (!core_sched && (rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
 		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 		schedule_deferred(rq);
-- 
2.56.0

