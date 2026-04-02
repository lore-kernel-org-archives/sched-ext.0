Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF332142B
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120279; cv=fail; b=e18qlKIEXG0e+Fof5NHOzxicIMqyww4COCDQlHxhIfqAIwRF3G7H1mPIMyd3uqpVjY3TV2cZMOFg79geUaArhBE+dbi6PumWyq0o2x0RtdUjC2MJnZEfNGSxJ1KnWBOxLfL27EAsBSfyEWMGgQYGFpIIsy8atsEZnQVxgCWIsao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120279; c=relaxed/simple;
	bh=HDRMJN6G5iI08/a6toSuAx14PkbKOR8FybsuK666cqo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=myinlOe81JBHAr241VUYVGh4IFuCqSzIeX+n3VvlAx/es301J96ImuZuWa7H6SAc8x1yTVYZi1jUwsv5UKT4O/9V3phyLkkKAtmKxbrvlNV9jYDgZpPHHaLWwTzlg9r9SFKvcN+0LmfnhYwV0SUvMBt4o0nugmoDBLCK2oMO5m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fl7rfGQr; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fl7rfGQr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll+vdrjm+ZsTnwlLIKXk7k7zfhiUc8jFKU7x92a0NUO971q8e6e9uQLsPhIIHGqOQz7z3HXks0MmELrWqj+IMO7WHCpsJBpLH6O0O5HXFkWAF9bocFF6xa5x4uZFHR32zhqaE6Sbxgi6JiFncOIqx5qOcpXTXqcTD4j75jWtHii/eFe8jj0RdDdm8FUaohxL32Nz+4AqTSGGC/ZakgJdPB61nEgoLbPDEkhYiN0UJ21HXtBBccBtUUlG0g9EAPtFfvLayGnb1hCZRHVy/U2bB4iee4GMob+bRPfzZlUKXJeFLhtJTt+edKu9qGYNpF4Dlv6MhoCYKunQ+XzadWSh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+Sy6LnWhfuarUkh8XQwJtgV8/dXiHJ/ogzPS/1gEFQ=;
 b=YPSN59M9sVV5SxNJM7LvGMXUoOYaD/+C1dJA7okI9rtT6lbbI1tEdGVvZpWDZAmmEej/krnd2axOtbarH0wm6da8MgUVOdTxtQbl2zOS/lbwMyNGq80w8eoC85s3dMexWIB4BVpdITJzV2ohrCq6vzBzaCvFiS4J3l74+f5z9PzfL9eoZJ+uTH2KocyBybTqiOc3cRCfuwZiGauVJsRQaCNdjquvKptqGsRQ9TVb+3AJ/pRttHo7ht1aDe1Fwx7amWI4XfThFxWAyl8ofO6BZT8jGEGrt8+4fma/GEOfqXBKgUCRe5M05ygV1PhYNPX1N33xT/3SBn8evrzFf7go7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+Sy6LnWhfuarUkh8XQwJtgV8/dXiHJ/ogzPS/1gEFQ=;
 b=Fl7rfGQrQcluVJwjilFpwsCh0zCu6VkB/NtI63bsOMJ4ST9CzrvDbelYdZu6plfeunhz+LvCJ8SNEGQ40hB6X3SlYwRgzQup1bjgjwyR8iYF+8/8dFQk7+ewiDkHPaLLjVBGGPMBmSUwK91wIyLx8PXu/a0qSfKiNt44luXy+nOUhnbgFsw3iA412n3OGTvQlNebUW4HUeL4T6yh2XQzA2MCi5fi4q3kteCoTFayu9KYpovLCIWeDRsfa5EYln5GBDpN7e4tbyuHu/LGIFnJH+pNSBM/ggH4RXpAwM/x3CVeGOXxb9ddUiKf+uAGvj/duIRoBqwb4bN/DwH5fvmR9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 08:57:54 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 08:57:53 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Date: Thu,  2 Apr 2026 10:57:43 +0200
Message-ID: <20260402085743.1410070-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::10) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 63455d82-e486-4890-6162-08de9095ecf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fCbl6ph1MLRSr075AqxSiQqPG8Dm2ShrT7hiKBq4sLpi+4+kLRJCXg2vNybsLJ8qw010Gcyk528Oz1wSPHBQ+H1iHev5js/4wH3hYBRUQO0V+6E71iadsm/Cxi+RsLLIR0FGUaB7iWk+c72zgyTp7bFUfo6abkdc71u9n/D7wuDMc3QGSj6zv8ld6jvSPE7F1OsTk5vLZYUTr8AJqZ9dXRFgbw72AgUZZO0t6UdE7jQAgoYB2Xe2aOr2YoxjEUN/OEG0qovX/fEyk9h4F10lnMRkw/DRnZdD/RBrALDlVy8PAJUOB4HUGBxAT3MjjaY1F579W/QhCsIjVkhMY10QFV1AIunEcNBBYcBXQOkyvdbuUqhm0X7OdFcq0vxzXK20/xhVBMmF/Nl/mfJjwS1C5LPanQWC2rA4+IcNlFUUtbRJKGTLTtqW2Nquw+4mGu12ivYvMwmx9wHpEpy6t9xhaFNP44VUKktkJURHsAwhU+ty2gqaJp4mkzS2kDxxxDBXRbP4oJD8UIEiHLt6vTIgJ4DcLg7E0zhC06EichPuWQyXA084leods4rYilKVnFuaxwT10RrAnZ/azNDtMfCujK96iOhc8rrIwJ3kARZx7iDbKDdxFFDk2rzgoEBJdrRPtnJBnISoINMxmDNj6NLr4bP9FEPIno07VdY4OpLLif2+QhL77YyUz/dxKv0LWrCU2doSB2SFmOCFiEJUMGKPu5gogzfiWAQAxYnWvYwumoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LlWCHLgri24KFJVepX05C8XXgHuWCpCAntCiVtLw2Bw2wEzzlmvyzca1p9M?=
 =?us-ascii?Q?kxUFHdE2+vqeDqIK7uzymrSCsztbh6KgKY44WVWpYb+5WZFRLLadoDd9IBy9?=
 =?us-ascii?Q?XMV8jhJWereDMvtKT3Q7RNYq9mOuA3ISznVtbKN1aQqCGBrmKg3Y8/fDrMqA?=
 =?us-ascii?Q?T694DgW8HWBXNwytfqVBA91Aywv3UIOgz+pzcT2Y9I57DazalfeH0qf7jdlj?=
 =?us-ascii?Q?5iO2eJMKHEBA6mh5aX4dO3nyyg5gkIC4JIvEOAd/RMnga57j5qKzGHm1ixGf?=
 =?us-ascii?Q?HzbF0MghiV9ydGuflNKrikD5FTAHmhVn8ktqjXYbVjfBrQEd1qXKwRXVPuTD?=
 =?us-ascii?Q?Roy0wUVbWMkVP0JMtcjElXWjBcLAYiSa70j5Q/HzrTvFVgMykqrrrIjV/0D+?=
 =?us-ascii?Q?RTLEwz43OAY31lbITg63ywJbbXfqCXaPTdL8bt1TEHndFtwcse8jvkt/CYDR?=
 =?us-ascii?Q?MYkKUKfOZgjN0fL7XUknCcrkCRqASx25PQVcicErUoAGcXrVaU+3Sb3TD465?=
 =?us-ascii?Q?/okJirCgK//kPs1n+5hiVI5NeSowGX7tRLsQc9Q4wbl7t6shR5h8eJ0v9oej?=
 =?us-ascii?Q?Nn6cs47QyD9IWLc/GjV9mT11gD0dbkhlnezy6qHURqbb39Uf+lYU2xASb09J?=
 =?us-ascii?Q?tlpmx20ViVYEurSM3Fes5S2mpho8j6ibYFNcc8nCdjtS9i6LZml/jt/iE6c4?=
 =?us-ascii?Q?FsV0EYMk2jk/hbooBRV7IIJcJz4EPTqpZ84POHAdaVB3JFjJBg5TRgiUzWVj?=
 =?us-ascii?Q?AXrrCBNXXLvxVetPZnAbwkpo6Fr3mAmTnKirGi4GbmVut5RsHzbfalsOkMKG?=
 =?us-ascii?Q?LITd2nb+vxyx0mgwHc++aCK4MMBBLuHDYNgpl42jcSkoftfgZbjzR+ByGhtv?=
 =?us-ascii?Q?YfRRI6M4lIyMhnl7ITqVjCo9QXSFkjK6/muSYSY+LP5j9560fywRUDblklaS?=
 =?us-ascii?Q?D+Mnq96keAOWXkc/CfKQgCjcSOzGZmyb1g4247hRNpeVVwbY6t3fKIKNmFD0?=
 =?us-ascii?Q?JFE/ybqgAZJMVfRrjxSAN+nIqvn3Maza81j05IId7ndra/jWuagUslW1cAKW?=
 =?us-ascii?Q?jDy2RxX9Kzu64Gufh/O4QeXR3+M392QBo/j46ic+b3TnqXVfyWImPUQ/mycI?=
 =?us-ascii?Q?YiFKxL7jWRM9j6vMJYqdvxkZ5HuEWhYS2sjMZ9FmmV95fep/kISZimaFYVRf?=
 =?us-ascii?Q?dJJRdX37VENAl9Zx0YWxe/3iWDYljmfmQb1nLozuJjyzKNDNwRTUTL9UOoyC?=
 =?us-ascii?Q?zKmoun3UNVU6LwPMdJ9iIp0hi5XCPTXq8Pw7BJ0DSmQpXEIbXRwWl4VsbS/Z?=
 =?us-ascii?Q?UiWe2K1589LBc5VBbln6L+cePGxQHzIpVJL5C7ZVeb6L/M2aw989iQlhLbW3?=
 =?us-ascii?Q?pUF+uOUilv5aZCribAvtKYU339GU5rJ09Cq0yhvD1Vzk5sdjVTNgG/HIxSQc?=
 =?us-ascii?Q?22GKuzzsvMgwr+Eu+vVFZyfXxkgLaeJGky6geBM8XraJ0gjfN3rjuPT9vfZs?=
 =?us-ascii?Q?M6tjpThhjO988yPixkmSHNRqeuMHUvQhATD2AohKT57LUqiS2Af+aDar7iX6?=
 =?us-ascii?Q?HLfunZqJ+YF0N60ap0yK3/jrOivjCzgI8UU2wmHEa/duTTgoY6pvPAKZ1vPh?=
 =?us-ascii?Q?mIiJc2HatJL71a616zuRzcjFfcbCopuXxn1KU+IiibgbE1Ywi6poCEw99Df1?=
 =?us-ascii?Q?coEaHEk3WhgSbNx7CjdIAiWhu6wihFOmTgBn3hBIzUL+zzFdgegWkJ0CLzYN?=
 =?us-ascii?Q?aihDUNSXzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63455d82-e486-4890-6162-08de9095ecf6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:57:53.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tws7khRCdRsBrjHJ857A9Mt7dZxonKxbavhbZKEwZl8f8voVXaNXQF2CgS7XB94zxt76Q+nwfrEEbiBum7JiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

@p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) triggering a
spurious warning in mark_direct_dispatch() when the next wakeup's
ops.select_cpu() calls scx_bpf_dsq_insert(), such as:

 WARNING: kernel/sched/ext.c:1273 at scx_dsq_insert_commit+0xcd/0x140

The root cause is that ddsp_dsq_id was only cleared in dispatch_enqueue(),
which is not reached in all paths that consume or cancel a direct dispatch
verdict. Instead, clear it at the right places:

 - direct_dispatch(): cache the direct dispatch state in local variables
   and clear it before dispatch_enqueue() on the synchronous path. For
   the deferred path, the direct dispatch state must remain set until
   process_ddsp_deferred_locals() consumes them.

 - process_ddsp_deferred_locals(): cache the dispatch state in local
   variables and clear it before calling dispatch_to_local_dsq(), which
   may migrate the task to another rq.

 - do_enqueue_task(): clear the dispatch state on the enqueue path
   (local/global/bypass fallbacks), where the direct dispatch verdict is
   ignored.

 - dequeue_task_scx(): clear the dispatch state after dispatch_dequeue()
   to handle both the deferred dispatch cancellation and the holding_cpu
   race, covering all cases where a pending direct dispatch is
   cancelled.

 - scx_disable_task(): clear the direct dispatch state when
   transitioning a task out of the current scheduler. Waking tasks may
   have had the direct dispatch state set by the outgoing scheduler's
   ops.select_cpu() and then been queued on a wake_list via
   ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such
   tasks are not on the runqueue and are not iterated by scx_bypass(),
   so their direct dispatch state won't be cleared. Without this clear,
   when the new scheduler calls scx_enable_task() for these tasks, any
   subsequent ops.select_cpu() call that tries to direct dispatch the
   task will trigger the WARN_ON_ONCE() in mark_direct_dispatch().

Fixes: 5b26f7b920f76 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")
Cc: stable@vger.kernel.org # v6.12+
Cc: Daniel Hodges <hodgesd@meta.com>
Cc: Patrick Somaru <patsomaru@meta.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Move clearing of the direct dispatch state out of dispatch_enqueue() to the
   appropriate places (Tejun Heo)
 - Do not unconditionally clear the direct dispatch state in scx_enable_task()
 - Link to v1: https://lore.kernel.org/all/20260401215619.1188194-1-arighi@nvidia.com

 kernel/sched/ext.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5bdcdb3f7004..71bb83fccd60d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1109,15 +1109,6 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
-	/*
-	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
-	 * direct dispatch path, but we clear them here because the direct
-	 * dispatch verdict may be overridden on the enqueue path during e.g.
-	 * bypass.
-	 */
-	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
-	p->scx.ddsp_enq_flags = 0;
-
 	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
@@ -1283,16 +1274,23 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 	p->scx.ddsp_enq_flags = enq_flags;
 }
 
+static inline void clear_direct_dispatch(struct task_struct *p)
+{
+	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+	p->scx.ddsp_enq_flags = 0;
+}
+
 static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 			    u64 enq_flags)
 {
 	struct rq *rq = task_rq(p);
-	struct scx_dispatch_q *dsq =
-		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+	u64 dsq_id = p->scx.ddsp_dsq_id;
+	u64 ddsp_enq_flags = p->scx.ddsp_enq_flags | enq_flags;
+	struct scx_dispatch_q *dsq;
 
 	touch_core_sched_dispatch(rq, p);
 
-	p->scx.ddsp_enq_flags |= enq_flags;
+	dsq = find_dsq_for_dispatch(sch, rq, dsq_id, p);
 
 	/*
 	 * We are in the enqueue path with @rq locked and pinned, and thus can't
@@ -1303,6 +1301,12 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 	if (dsq->id == SCX_DSQ_LOCAL && dsq != &rq->scx.local_dsq) {
 		unsigned long opss;
 
+		/*
+		 * Update the direct dispatch state and keep it until
+		 * process_ddsp_deferred_locals() consumes it.
+		 */
+		p->scx.ddsp_enq_flags = ddsp_enq_flags;
+
 		opss = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_STATE_MASK;
 
 		switch (opss & SCX_OPSS_STATE_MASK) {
@@ -1329,8 +1333,8 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
-			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	clear_direct_dispatch(p);
+	dispatch_enqueue(sch, dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -1439,6 +1443,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
+	clear_direct_dispatch(p);
 	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
@@ -1610,6 +1615,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	clear_direct_dispatch(p);
 	return true;
 }
 
@@ -2293,13 +2299,15 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 				struct task_struct, scx.dsq_list.node))) {
 		struct scx_sched *sch = scx_root;
 		struct scx_dispatch_q *dsq;
+		u64 dsq_id = p->scx.ddsp_dsq_id;
+		u64 enq_flags = p->scx.ddsp_enq_flags;
 
 		list_del_init(&p->scx.dsq_list.node);
+		clear_direct_dispatch(p);
 
-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(sch, rq, dsq_id, p);
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
-			dispatch_to_local_dsq(sch, rq, dsq, p,
-					      p->scx.ddsp_enq_flags);
+			dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	}
 }
 
@@ -3147,6 +3155,8 @@ static bool task_dead_and_done(struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
+	clear_direct_dispatch(p);
+
 	/*
 	 * In do_task_dead(), a dying task sets %TASK_DEAD with preemption
 	 * disabled and __schedule(). If @p has %TASK_DEAD set and off CPU, @p
-- 
2.53.0

