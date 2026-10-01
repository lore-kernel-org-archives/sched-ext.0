Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B647607B
	for <sched-ext@lists.linux.dev>; Thu,  1 Oct 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881948; cv=fail; b=JS8Iqwtlx4BidH9b5nJSC2P/lJMojONPtCzpXDEUESvdWgMMSpC+18TYgw8tN4FOD+EMlGAF5IqI9jusz9jeBaJpIbTygDSjlO4j0dKuMfG2nluiQW/tZ0vGII+pFxSVQBgublS7HI+4Ob8pXR+ShzfzNOpLYWWdDiZDl2Wtf/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881948; c=relaxed/simple;
	bh=dFVDH+U36tEX2luvgPrKHMdSWS8zAcxXTGRGU2NsGCA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BpU0aAK6Rp7N60Cm7eMBo8EYafRPemGqQsEnjGKNvZBuP+gpBKseL4JsiBITklrxd6kGxF2D2azBGHgQVzSg+5hr+kl4Jn7IU9yE5xlL7fcXNEy1zsmoRlv+09v0IzRZxVLOtFCGUz4ISlivePziQ1x5g+qiULc9uujGUaxrfCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5pcpCM0; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5pcpCM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMkOxNZB9nN3gmKyNHfSqbE4y8W2NqqgLUdyHPLJwtjS95Ag9kJsxoHxOMZ7IvxDw7WfiBeNIjqmTeq9lFYaDgKS7QSxOfnqW7RkD7vDg3BNixnDPoMqvbcgr6p5qprNuWnn4WFJSrr/l46Kz77azbLr1EEMIEquKE9GpPLETvhlG6vJCCcPjvpqruK95moj4HalNIZNARooLpbPeF7LTbq7EOnLhkK/CkDLP2bGGa9RazPwi2BOBbANDHCWhPtRuA9cuf6CjydFbAQTfAoX+Aa/RAEjbJ8obk2XyGrpwu9GDyspM0z7yc2YXluSqoIl5IwXpimrxowyhM8XlmIM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edF6iAtjFGg+35wZ8QCQKxkJVD/e07OHAqdfJFMunR0=;
 b=xxGmX7jXE+ImLC3NytqNb/3JaMbP/SqutWHVSiG0mDAGArlXam07PTZuFHO45Rzqd2jpYFh0TFbcR37OipIxYYjpyij+zvmbMG4cEHF5xcHPsHAti8N47DhUZdQs0OIOEe2QFUEFzHxbfsTblA/6h555kbkMbIx05nUlosvSHR1f7zHrLiLNKhLmcOAxZ98hpPFfh5oPUBAjFvaNVEcC4l+Zp4Ny8QbwtCX3jjxFy0J/N0klMAK4uffBJSDyWLlVb0enuhAdxXyclvKymtiEx3yQOGPF+MPbR/fQgJowbkPIBGvWk90fPAYLlwAArDOxEezkzAIXiGV1kV/rx4NLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edF6iAtjFGg+35wZ8QCQKxkJVD/e07OHAqdfJFMunR0=;
 b=N5pcpCM0tfHFZlq9hbJNPHh3iZGUiUrVKl4M3ZYsGvMPDF+WjlzvcRNCEufccBoevSddsZkTCOBKJTbwuHP/Cjn8o/cv02ep0Nld4uMT6xyh09FJoZqakvG31Razj8SonyOvfePkEBJ+GAqHRpTlDu0L2j2ZotjJsrmCou9I6NdIh7H5jqIF0HimeUpnMMJaxvbZYuPRFE9+h6MUAisSMj/kJGFqEjf7lDmRfPboZEbRfGeipv/rCU/aOk3NOD9+ilo80bmyW7QPEWgZRM0xt7G5jvXl5FNv78a5R1iri44sqiGEmHMFhqVshzOVRSU/NRRqLvuWSlUZqHZfW/gLVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:12:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 19:12:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
Date: Thu,  1 Oct 2026 21:12:16 +0200
Message-ID: <20261001191216.2391359-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B89.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::407) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 51115e6e-9273-4a99-51fc-08df1fefea7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e77fdLrlz47GRYf+GTBffpv8iCo1SVUAISmRnHWImkVgAg2gmNOjtBdgsuGPSaxbhSKQrv443u++W46K0IdYmixp9ceX3fmHbxXdnDzSqnsH8bnmAlnT424JD+a8xNprN1sJnvc3BSWi5wC+LuLQbthD3InyZ9lHXnc59yrZLPeVvwjkkViPa8BOWnnCdvewIg0pI25tMhTI98zRlsklBzylhQnYIC0y6Ss3r/GdVMj/qzMJL4872F3BuJV8WCiWz1b8C3UDzg/5qW+EpIpbEn98YeJx/h3BrjTlsUgEElYozk9uf5ya7HG2fwOOMltarxl5qIyYdgJwVnY+GYmIlZUWPlhNkMXh72QEJwJIejm71iclmxdzGT2Chh9WQn+cWoygEQIUCyxJp8diHRfst621oLgdilZQ3PXkDNpiyG/e0Qif+kClziWVZ1bvTANqugEuwY8DPDfyBS2Va1koUHligcFD0QK6fFZ/+3T6UjK6KV/wfWDMeol9C3Ecaalku8qPH9Oo/KYX6+bMDv98ccUxHsJYBOfn8Hqk18+W1DVOAKFTKiKfgJjH5H261lpWQR8w652d+KkiCUM+FjxhH+4SE/02S/v/MSv7QJn+gLw/B4ewXm//WN/kf3hTAe1rw324y/vOOaokti0tPJYSnigCnY5SZ4DC2/v8r8VzatE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQ4z+or7/y5CEAEVojzhpiVyUbEO26E/C/0g4n9Ar4c4XDVwl/EebQoqYr+6?=
 =?us-ascii?Q?jNANtuwuo/pOQg/yaPvTdIc4W2BjJ2OeFZtupFqI4bF4yaZ2YiQfCy76cmzt?=
 =?us-ascii?Q?0sq21WO05DjiKB1KzCbHALnYsSRwky8mkouSDftZ+zNNFzNOe+lO2nit4clW?=
 =?us-ascii?Q?JkLoxy4urXJoi/tcYZequJDQyZWlKO+URaAL3M4ero15Ivh2/dq1m6r46PI8?=
 =?us-ascii?Q?tFs6WmiUvHW7mqdvwfxlht8dQuHWkNeclwXplJTK+wP4oUMLSkYNMalMNOUU?=
 =?us-ascii?Q?OBJvRtSQL2P8Z7z1K9wrbX7IPKYLFUwU/XjAvXg/6eiDPF5qUNyVnn0kEu3J?=
 =?us-ascii?Q?l5pgvRvM6+8eVwrY6ShsBXb57q53a8dELskJoxgFV+9OJkO5UCg17VsSgUKP?=
 =?us-ascii?Q?tISfm1TE6bXekEaLdhHfRQu8BWES0BSpFQ5ZrRA43iF1Y0T+q6zDfEhRP2ba?=
 =?us-ascii?Q?oiu5VfVtVZOIUmp5L/yZemmWtrMKpK2lK6DoLqhuon5yZgObpx4ObAbbHz96?=
 =?us-ascii?Q?wvjMLErnjOSiD/Iw+unSw/DFogVMYi/8jTZCiIWi9BexkN53YHnb/uFHT4Ma?=
 =?us-ascii?Q?vvgat2Ek+L+6pfm0k7kplBQM9WGleEsrOwE0P/jt2DoXFO2A07nx9h5w1R2J?=
 =?us-ascii?Q?TNSsYjodSvrxwPh0v/aRuvydETUV34jSrVFZMNT2GDAqokcEriK3QYTmGqzh?=
 =?us-ascii?Q?lc1wk8qe48urtDuqCSZiLI3wQwuwCGPKhd+1ElLOXfDirpGizzEdUzo/favh?=
 =?us-ascii?Q?xLvuTxl0TKGwjzj+rW0TIVjuqpbpn/bulIgsiBEDYmz+a5HUcb+U3Xt3fvwu?=
 =?us-ascii?Q?+gtt9zvxrwgt13dYbjv5/iXutz6i2N7FuF0SAF+PrpYttcZnxgf0BfKjvLjh?=
 =?us-ascii?Q?7z9/xwNdIU7jeat7OTz8Z6NGYU1vBSQuhfDpS17LkH2UOpaHr6Hf0S4/NRpU?=
 =?us-ascii?Q?N9PTQni8B313zkXKF7fWsBFeZf8rsVjRmoR4tvjoEO3aGO/a69zQ+OMqlZ/e?=
 =?us-ascii?Q?yhnrwVybzXMl+3LXaFWVPhs2+UNBoRbCp94BaVcPEUYOMyOeHvZ1gxN+56k1?=
 =?us-ascii?Q?LxWCm8fg/7CUNEe1F78x2r2iALjCp5NNv+nJ4TXurTiMy4QoA5+ejYxUCqxQ?=
 =?us-ascii?Q?SZbsIVGTXUMAgr3oaseJDpv2vd0iu5T3SB/HwUgkZ1GDywCyvC4vJSCyhTP5?=
 =?us-ascii?Q?/rkSAUTGAkY6rW1tcyZqj1bZYYtMNZXXHlI4J3SYFA531YQgYOcn4PAdtcPf?=
 =?us-ascii?Q?AR45ypNX8237mq0c3hi1dmfAJI3FiJVJZ0nu1HYw0UGGQvI7WAsfHPQdxZic?=
 =?us-ascii?Q?GzSHDE10qVHzo0yoKr2pXF4onSaH1eMR73zC3KRXpYP5BVDMBDDD6krrCso2?=
 =?us-ascii?Q?tsh3DujTchi2YyYXhqseBQy2aml3qHGLL9dgieQhcdc7VI+kiXiGkf83IsUR?=
 =?us-ascii?Q?YGv/BC2w2s9i2YdxfekHGiUTI/CrYY94+G4f+T4CeFIo56RbtmMhrqEkFxzy?=
 =?us-ascii?Q?SVkeAJy13dqfoe5tQPnkeeV3drK0k2ihLIAwcl5k2pkWpvplkll60aBKOhAd?=
 =?us-ascii?Q?3I/T4S7w7JuJQsNWK5DwSwvsN6U/NCCih7kDaLYtzZ8EGYi2e3HkBA8Q4Roc?=
 =?us-ascii?Q?XBexaD/4krIFZSPGtQAQ2fZ5sbaeALF+BCJ2bORH6pXlUr2iz9TSGEAkX4qP?=
 =?us-ascii?Q?EMV6FiZMpTK6bhcL8rB/wFfcZNRGrLb5UZygL4RSz58WIkpF//6msWKHhhNA?=
 =?us-ascii?Q?39Staj3hLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51115e6e-9273-4a99-51fc-08df1fefea7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:12:20.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1hdxxJQ2jA4Qhxki5PJN0eSSTeR4NwbLuQiPmnFLN1B5EmlsdSNe3fg5ZmM8ShxCvNeJ8fCR8QqwMzZnydWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

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

A donor placed with SCX_ENQ_IMMED retains SCX_TASK_IMMED and needs
special care. Normally, putting such a task with slice left reports an
IMMED preemption and returns it to BPF. Proxy resolution may put the
already selected donor to idle only to drop rq references. Treating that
as preemption would repeat the same BPF placement unnecessarily. Mark a
blocked pick as awaiting proxy resolution (SCX_RQ_PROXY_PICK_PENDING),
so this put retains the donor locally. A real preemption still returns
it to BPF. Moreover, carry SCX_ENQ_IMMED on the local insertion so
sub-scheduler capability checks use SCX_CAP_ENQ_IMMED rather than
SCX_CAP_ENQ.

For donors with slice left, this leaves BPF to handle meaningful
placement decisions rather than transient proxy-bookkeeping puts.

Fixes: ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF schedulers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c      | 62 +++++++++++++++++++++++++++----------
 kernel/sched/ext/internal.h |  7 +++++
 kernel/sched/sched.h        |  1 +
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 96c904b396019..2c5e9eccf170a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3344,6 +3344,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	bool first = type == SNT_PICK;
 	bool can_stop_tick;
 
+	/*
+	 * A blocked donor picked by sched_ext still needs proxy resolution;
+	 * find_proxy_task() may put it to idle while looking for its mutex
+	 * owner. That put is bookkeeping, not an IMMED preemption, so mark the
+	 * pick so put_prev_task_scx() can distinguish the two.
+	 *
+	 * With proxy execution, a blocked mutex waiter can stay on the runqueue
+	 * as a donor and be picked again (SNT_REPICK). Core scheduling's
+	 * forced-idle pick selects idle instead, so it must not mark a proxy put.
+	 */
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+	if (sched_proxy_exec() && p->is_blocked && (type == SNT_PICK || type == SNT_REPICK))
+		rq->scx.flags |= SCX_RQ_PROXY_PICK_PENDING;
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3423,6 +3437,7 @@ void scx_proxy_donor_start(struct rq *rq)
 	struct task_struct *donor = rq->donor;
 
 	lockdep_assert_rq_held(rq);
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
 
 	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
 		scx_start_task_running(rq, donor);
@@ -3483,8 +3498,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool proxy_put = p->is_blocked && next == rq->idle &&
+			 (rq->scx.flags & SCX_RQ_PROXY_PICK_PENDING);
 	bool rescue_keep = false;
 
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
@@ -3516,23 +3535,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -3541,12 +3550,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ unless it was an IMMED task. IMMED tasks should not
 		 * linger on a busy CPU, reenqueue them to the BPF scheduler.
 		 *
+		 * proxy_resched_idle() also puts a blocked donor while resolving its
+		 * mutex owner. That put is bookkeeping, not a preemption, so retain
+		 * the donor locally even if it is IMMED. The deferred local check
+		 * returns it to BPF if this CPU becomes unavailable.
+		 *
 		 * An open rescue must keep @p on the local DSQ even if the
 		 * scheduler zeroed the slice in ops.stopping() above.
 		 */
 		if ((p->scx.slice || unlikely(p == scx_rescuee(rq))) &&
 		    !scx_bypassing(sch, cpu_of(rq))) {
-			if (p->scx.flags & SCX_TASK_IMMED) {
+			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
 			} else {
@@ -3563,6 +3577,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 						enq_flags |= SCX_ENQ_HEAD;
 				} else {
 					enq_flags |= SCX_ENQ_HEAD;
+					if (proxy_put && (p->scx.flags & SCX_TASK_IMMED))
+						enq_flags |= SCX_ENQ_IMMED;
 				}
 
 				scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
@@ -3571,6 +3587,15 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			goto switch_class;
 		}
 
+		/* Delegate retained donor admission to its owning BPF scheduler. */
+		if (p->is_blocked) {
+			if (WARN_ON_ONCE(!sch))
+				goto switch_class;
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
@@ -3752,6 +3777,9 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
+	/* A retry can abandon a provisional blocked-donor pick. */
+	rq->scx.flags &= ~SCX_RQ_PROXY_PICK_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d65fec631bdf7..7aa9b567bd73f 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1829,6 +1829,13 @@ enum scx_enq_flags {
 	/*
 	 * The task is blocked on a mutex and is being kept runnable as a proxy
 	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 *
+	 * Blocking on the mutex does not enqueue the task by itself. A donor put
+	 * with slice left stays at the head of the local DSQ, except when an
+	 * IMMED donor is preempted or cannot run on the CPU. It is passed to
+	 * ops.enqueue() when its slice runs out, another SCX task preempts it,
+	 * an IMMED placement cannot be kept, or proxy execution moves it to the
+	 * CPU of the mutex owner.
 	 */
 	SCX_ENQ_BLOCKED		= 1LLU << 42,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0a34f0da1ec36..c7f0fc8fecec2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -793,6 +793,7 @@ enum scx_rq_flags {
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
 	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
+	SCX_RQ_PROXY_PICK_PENDING = 1 << 11, /* blocked donor awaits proxy resolution */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
-- 
2.55.0

