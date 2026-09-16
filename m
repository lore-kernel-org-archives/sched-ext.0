Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C493630BE
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570712; cv=fail; b=lIz8wYVeG7hMWv3B0VKxIF8n7X9rS0MDCWEqxMdO10AUhaI0ki8oHW69bR4lBfvI9AFveSBOQWtu88UhjP9hEuta7f8njrey46+CSK7At/tVx6okPItvwrrY1lWpffA91/gbGRKNpKPrrE8BC7ugFScatWettQQ7YHmKCYbxImQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570712; c=relaxed/simple;
	bh=0jfXn/YgLX6nzGG0eWdxlOPyGcQ8YDpmf5ZAtBoLbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HwwMtjds2xsCzS6DZiOpkU7qyurvprABY0FNbliJLOrUjFhFnR8UbttEPwX8boTilG/WMwTB0kWYJR3w6Kdwi5IEtzUiCX7FdUehfWHFmAPxK4i79ylLJ8iRop1H2BYzidvjOnIxvV05ZR2eKecvL0Z/XOKtfgmM4kLr4zLbgvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o9DEBlku; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o9DEBlku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd/ZF83lhtcJ08uPJcNVMV7In0fTk5k9Vf8lSSlDCuKmcOJWaCv6w1HGtZouYfbtt5Sl84/IMY33QNgY4BOK61TAoawkoBP/EPfT/CEvHA1Bsh9r3YVI5bLZP5iSTwq9bfuqWhMN1IJODXDJpkbzLXEz+rIcfrxFeQZ1JcmuXED/ijPjxfdxn+GsZkN45PIVph0pULMBPykdrHVXZZNd3Jx/e8pcrNbgRRLwQ5THnn3O/bjscdBkR6d9KE6Jdrgi5LE8poPNFpXRUlKctRUkHrDdN4SMfzg4KuIeOCbynScnnKjtqbAS9DUXrLNOgo8gj4cVf/8/jARMnHf6G1MOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLQDiOrYRqSOCdXucKTRBwD7M8NFbmhR6oEk/P/yp6s=;
 b=EF1RsGHAlbQiqaBkzt/jV8UcAHmJkq7L3h7bB3p8tIfEAR403tB8cc5c9xBQRuPQ0v5lkLJrS5gW9RPmbUMt0BML4kiTSiEkprGw4GsUfHbm5/oOnDXuv4jvIWNI6bKtiaAqC893MhXndJYl1TraAh+mXa21pCVQ8NA4x2xxDGtGctmFeQbXq7AgGpVo7ZeRlT8c8YLTM55UBqxnufQ/Oo7IThGywriJjoLhzKDI7fiuYrSTCiU/a410k8jBqImEUKBr71GwwhlR9mD6XIWQ6AMtvrBg68rmVZEKdR6KbnLrJqtxuiXF+dAnvxwKORYjgGecUqMtv05PZxvXUR6M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLQDiOrYRqSOCdXucKTRBwD7M8NFbmhR6oEk/P/yp6s=;
 b=o9DEBlkuCJ0CejbbaDgEFYGin6kqKpgIHXxw0LBkg1ndO/Tvp+3a9fbOHMzkQ4MNxJsVHeVZe1dzybkq3O8DzexnkODQDUqyxqLWEC1yjZD/P3WY6MIh9Nkm0xgqPDi2VioONJUwb6MDeMNECGR28GdW05wm/tXoCy/Nidp+ZamJbw8RKeWsuSctociNcUC9o+AR6IPMpwJfXyrgPoDWAMQkSQrayNypwuNbsfPtm8waIEx9TLsVmTrNVvdi0mQ8inbjSbaEUAtn0PHGpXiHK5M6k8dfsAj8FD0IvCjVgVyspxwbIvRV67kfZVBxQdaKli02B62VkOdxdJ//IrPpMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:58:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 14:58:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Unlink pending local reenqueues before freeing scheduler
Date: Wed, 16 Sep 2026 16:58:07 +0200
Message-ID: <20260916145807.3250167-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::457) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a613b4e-a85a-45f0-a8f0-08df1402f298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+gTlXbz71vtXk1MQeASPVO4sDViElKudfsVSYi6nKRsvdHvu7KFDHCogLJfoHS1kzZyVMNG1pWl4ABWF2GEHQn2dnBgKKIqX+BVv4bMNo0kuCTchPGMejqcOje+DT8oIZF2JMfETUtohZjTX9g201we0Hq5fDTgwC5gknQ32oukLjZYbZkNiWJx3lr8JuCvauPIzVC1hi2k4+B+F1Z9jdFTU3SvGJRMsDCLWKNMgyWFhL0iyZyiH6EfTJ2ptztm534Njweyg5O5oIPMRKN7UKGNTworLFoe6hVPwTQi5KxofzS8PtWRvzwdUSaC3TNuF+kHQ2e0sbHIb35mignjWD6tJFY2aALQOLCFn1E1gT1hAkWFahHg5lCxqO568eGyCXz9Y/PSwXRrjBO/7zYDTzGxCHT14+hJqya8OwO2zM/mPyxy0cXFzIa5ODY6TSpAQVSFXGZReyxdsNAIT99mvhKmu8kAfq3zf4phWC4XNpgB7Har/A6fewoNYXBLMY0OIhla0OcDOk0yf1MPpsUy1pwqAM/P5F8DA3805a7wqdW/Y59VTlUmY2mC1YFdazBcENQyR+j/59rM/GlkeHu4YVaKdSq025hshLLxPl0zNqMWycYQaebnfRzp1BZshWTtmRzLT9uFMrLhwC65YpbQn8I0Bf/jg2L2UDwRu6+zwpug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWwcMLdeVCsJ5MJi03p+t1+4DqTT+r/O2mjrixwkntIcG3Q0UVG8SjF9WLCt?=
 =?us-ascii?Q?o8wYSuJdF+RIx+v3ukgvwkAx9ea/UqDJj0Bcxo1eWb0MjGDIOswpCV+GYkIl?=
 =?us-ascii?Q?EudKlbVGNUMY9GfDyaF8WAE82CYhv4oZiBBIBOnDitx5XSBFZ/DI44YAjN9T?=
 =?us-ascii?Q?BdvCyThbp72aPZHw7LZ7/4ORE4Py6zAITIN9SAbh2Yzolx9ydgulPxBa/YUo?=
 =?us-ascii?Q?/g16VWPCbJPlgFUtjzlTV3vJdk2u1OAAHlMTLW9Pti7tgIiOvVF9O9RScN9J?=
 =?us-ascii?Q?1OHqqS9F2vcNHday07Nmzcwsm0XqQHFu4I3/0KGIQIjhzY+WiBRvCIOLyTFB?=
 =?us-ascii?Q?VG7x5t3zcjpV21XMZZzaj0spk1NfDidffLIb3N9d8x3K4lx3YqlweRvd7aqr?=
 =?us-ascii?Q?R3LdqQIWKQasbVj6xibyUvdG9Zzip6PLIMpINtd2b+y7fVM+D+yZiqLeaHNu?=
 =?us-ascii?Q?j3J1F3tuCmnsM3F/bbMSyC6CKrfrUxHJIW9jvpgdSketJU90XXuarUGLCOAD?=
 =?us-ascii?Q?5L2bH6SA8AbJ+xQD8Q4o5gPvc+fYDkdgm2tOKgEsYLveLcrwj837bmrFuzhI?=
 =?us-ascii?Q?ETM+qRv8wvyGHN0Y8uH6e9007VdW+e0JjEflwBxF1+Q61Cb2GCwtnF1yyo/Y?=
 =?us-ascii?Q?t4t4IF/Mlb38dQWH6rXjbX2kdxG3gGHfsJdF+su6iGXJu1MWbG7a2QP0TezV?=
 =?us-ascii?Q?TZAnLCP0IL8FLkIfCylL0C3Y28hs+dxN/lQErafCRGhL8lUzR+e4Ao/9THJS?=
 =?us-ascii?Q?llbXITUmf/8/1OiDxDZvP7eRmwP4B7dA5YLH/mKZ0bxo3mieesm6EBjUfPfk?=
 =?us-ascii?Q?eJspSN0bpQzp21ZSX9jOsZkm046ylr9ER8BqkdlElppEblH68bKX0QEFuaIk?=
 =?us-ascii?Q?ZdmgELS7fx0b2lyWT5FnIiDacpk0Rd4G5KdgubGdCD9pNjah0ygl2OPhflIF?=
 =?us-ascii?Q?hi/3+vjFJ4dub88UCHPmMTJYcioBLiF9ITwCnJveSC3Wb1iVUBU4ry0qv01Y?=
 =?us-ascii?Q?QKNWgHj7R7gIenKfD7rNZmO6dum4X+cgRfEYkeMYiyKcF7mV8ph6poUJIBxs?=
 =?us-ascii?Q?VVWHkjgvnCIfgY8EZMA6AZAy0g7R93juc/4WqJWj+abdWb++siASH0CKK21f?=
 =?us-ascii?Q?PM3aq5W2hYI5AfeqiYmTAr/NV4SXyGI5ef65yh/Uo+St80aRHIyv+MI7H5eb?=
 =?us-ascii?Q?fQvQRn+m/WUuJ5RIomacBxSxrFE9NYwgi7P/bjHRclqlIMYbQnmA6CDLDmrQ?=
 =?us-ascii?Q?LzytEsLgsz7okIQygOMYyoJTs46maF5osi7GSZrISYZr8TOXHd+FRPiTCQ7q?=
 =?us-ascii?Q?7R+y94mCluuMrOJ/Fdo7gKRGTaVlFmIDM0gDLyc4lie4/G8l/HvJEUqlNim+?=
 =?us-ascii?Q?PkVYdCYRjx/5jKLjALfqz574y9iajdqI8ubuR4XdTJlUUGpLYWFt+XVtKpxm?=
 =?us-ascii?Q?beOV65cd2yFD9nWYqNcQ0+Zs+0Lk9IYOzT2OTfQDwk4omjSZ4IitKgrLy22l?=
 =?us-ascii?Q?GBTAQXdVswG4RQlVytIvHszhcPhT0nfIuc/UAnlPVKCuUl0ef7HcT4NvyO8F?=
 =?us-ascii?Q?c2EZ9BReOOzSzrQP2nc38+YqEGDnIp1Lw6SBTU+HFwKs99YGajPGsBoxyIA/?=
 =?us-ascii?Q?RgHOsLa2FczARQ8BgUV5QvXwJ5gThCBgpqdJnLuLg8iFDK0LQtlawr0WASIa?=
 =?us-ascii?Q?5xe9yWsM7A/knlvBEWmM+J+tFebKCMLVDzADgeMXCIwhr3ukBQg6O/MbtP3b?=
 =?us-ascii?Q?67FCXriDxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a613b4e-a85a-45f0-a8f0-08df1402f298
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:58:20.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKow/1juJItCoWTydCskLWZ51IQ1RxTZoORH2upvC3+nOD2Ni6u5YjXL7V3U2qs0aiWCi69Qok0YI+zOfbkxNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

A deferred local DSQ reenqueue embeds its list node in struct
scx_sched_pcpu and links it into rq->scx.deferred_reenq_locals.

A scheduler teardown enters bypass before the RCU grace period, which
prevents new requests. However, this does not guarantee that an
already-linked request has been consumed. An RCU grace period waits for
active readers and it does not flush a pending rq deferred request.

scx_sched_free_rcu_work() assumes that each node has been removed. It only
warns when one remains linked and then frees sch->pcpu. The rq list
therefore retains a pointer into freed per-CPU storage. A later
run_deferred() can walk the stale node, derive sch_pcpu and sch from it,
and dereference freed memory.

This was reproduced on a 352-CPU arm64 machine by repeatedly attaching
an SCX scheduler, running hackbench, and detaching it:

  for i in $(seq 1 100); do
          sudo timeout --signal=INT 15s \
                  scx_cidland --stats 1 &
          sleep 1
          hackbench -l 2000 -g 100
          wait
  done

The scheduler was enabled and disabled twice in close succession. On the
second detach, scx_sched_free_rcu_work() reported the pending node:

  WARNING: kernel/sched/ext/ext.c:5351 at
           scx_sched_free_rcu_work+0x460/0x5a0
  Workqueue: events_unbound scx_sched_free_rcu_work

After scx_cidland was attached again, a hackbench worker hit the stale
entry two seconds later:

  Unable to handle kernel paging request at virtual address
  000000000010b8bf
  CPU: 89 PID: 590569 Comm: hackbench
  pc : run_deferred+0x148/0x5a8
  lr : run_deferred+0x194/0x5a8
  x1 : 000000000010b8bf
  Call trace:
    run_deferred+0x148/0x5a8
    task_woken_scx+0x1c/0x40
    wake_up_new_task+0x1d4/0x448
    kernel_clone+0x1b8/0x5e8

The oops left interrupts disabled and was followed by persistent RCU
stalls, making the system unusable.

Cancel any pending local reenqueue before freeing sch->pcpu. Take the rq
lock first to wait for any in-flight run_deferred() and prevent another
one from starting, then unlink the request under deferred_reenq_lock
(the request is obsolete once its scheduler is being torn down).

Fixes: 0d8c551dd5de ("sched_ext: Make scx_bpf_reenqueue_local() sub-sched aware")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 70b711c4de6e1..94ee33ec88de6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5380,13 +5380,20 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+		struct rq *rq = cpu_rq(cpu);
 
 		/*
-		 * $sch would have entered bypass mode before the RCU grace
-		 * period. As that blocks new deferrals, all
-		 * deferred_reenq_local_node's must be off-list by now.
+		 * Bypass blocks new deferrals, but a request queued before bypass
+		 * may still be pending. As run_deferred() runs under the rq lock,
+		 * take it to wait for any in-flight processing before unlinking the
+		 * now-obsolete request.
 		 */
-		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
+		scoped_guard (rq_lock_irqsave, rq) {
+			guard(raw_spinlock)(&rq->scx.deferred_reenq_lock);
+
+			if (!list_empty(&pcpu->deferred_reenq_local.node))
+				list_del_init(&pcpu->deferred_reenq_local.node);
+		}
 
 		/* remove the queued ecaps sync so the pcpu can be freed */
 		scx_discard_ecaps_to_sync(cpu, pcpu);
@@ -5395,7 +5402,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		 * Bypass blocks new kicks. Flush the kick irq_work so this
 		 * pcpu's to_kick_node is off the list before it is freed.
 		 */
-		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
+		irq_work_sync(&rq->scx.kick_cpus_irq_work);
 		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
-- 
2.55.0

