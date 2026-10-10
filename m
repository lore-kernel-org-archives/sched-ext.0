Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC93CF660
	for <sched-ext@lists.linux.dev>; Sat, 10 Oct 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623291; cv=fail; b=kqlodxmvKquVPUbYUzlgruImL7agwfnBrmshaUcCGq4RLwD9wk9odzCL2bMDEkXdr+lyFFCE0MGXKP9RltSS9RNAGpJ4I9J9OhV6Pb0btqt7mRoKCWhlGQkmhS8/EWfrZZwcwTAy2jaWWSdnCFAHfeU9yri3ugEMGIBoaRp5yNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623291; c=relaxed/simple;
	bh=Lu4TEdR5z4PygZGvqM5tc/Btm3sQL1DA2EploYYQwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JNIiGfl1Bw7LQ8Aq29JIXm6ziXxgCcSeoTEOwUkm+Ui4BpxpPPU3frhnUdKQ+HTIbizojeva5rg/H9fUlbI1NzAPKY/ZdjfBZnVjjBUIELglCxzI1d4+A4B8F8tn8Yp1dZ3yBFTvmgaOm6r6tLFBRSh4O+ljOMIA5Dac6NL5xok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUs7tT/l; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUs7tT/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwaEXthdGUNIzzM4tgGYcD9gtjbBAGFdhD64qNMNdTJ45oPO7g0otMn9I+d900YlyAMNys7uBNGzWQsD4u9rxutiRs1uICAAzzDoHI7ObzN0bKwWDV03Jvvjk7dWCx0hY5F5N5ug3OitU7HdHnVsMB0ukMtXyrmARdmnnfx9AouIkfjnmbxTa28KR68+IB56VrYzjWxrQDKNzT+QG/UrKiwpOczxSGtLtv79nD2jYz0qtNczGodIQOcmxbzk5Hr3G9JdCD+mp9y1vf+yv0Hr1ki6/vdPVNm4u2JYUppXf6yK6oerQujsa1jwY/2SBsnl4T0Q9SUF6k07w1lyBpZ+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n9fP6cfOg7q/ZZmXVPVvjOvnbEVxPBvpVeMuCEOoo0=;
 b=WuG9EJdZ8ah1qdANISgU5cB7Evp2EuHJfO9aLukBuO0bZsUAGHloUf0SMJRO/nFfq1qGWrr1XaRPFoc0iP18jIZdXv34sQHv9rkT/4knjbWYZVJI1mWxeUsrHOA6cM07G8xtg8Hd1b0pqb6cbazJmk2lceKpIMynBvrV3qxdnOoL175yiw698aJILXGLBx3x9B14a6hswYRyUic6jzFNDGpvK+1HXHkhBTaModmpnoRZDkePeQ+Q2hx1cwO+hdK9C9N1yREaPr78dqbxxuDUomeeZCriVBjGDUbRra4+6VkmiPLSm0Anz9TmNBIZd2BHS2NcYAvjKycyOX15QYgz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n9fP6cfOg7q/ZZmXVPVvjOvnbEVxPBvpVeMuCEOoo0=;
 b=HUs7tT/lsOArgi/KRL31iXXCU/DA/30goaewDei/8w+0X2yVgUzG5YNFe1ap3bWNG3PuU6w0SkVqHNFMrkwnnRZhcp2sDml5EIxqQWrrYdRRTMrjvAAagHYvEZULlyuNx0053zNE9d9pPd+88X8bQ3sgw0lrrLpGvMQRoiQrd8AnbpG/jR0wlo9AwVt4z+949Hk/aENInp3qQbrGf7PkZbz+onZvN3gkkyJjn8zc8VppFahBkGFRu3l74fEZrmOQpMGoOh/puNRIJNbbVMPLsBEpn9gtPYe6n7pSelevGi370zMVlE2KM2DJ86Tp/qlz31DgmoAHTj3IsRXwtHyACg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 09:06:38 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 09:06:37 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
Date: Sat, 10 Oct 2026 11:06:21 +0200
Message-ID: <20261010090621.184717-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d35a43a-c5f5-4d1d-9a0a-08df26adc37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|56012099006|5023799004|11063799006|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qOwhsHBMhMgfdrYlA4fvTj5mLz1GibhMn3j4+VetkHba0JAdujgV5yb3Bfo8B1O9u35qpkZcsn2D4nGkwin27TpCog7bDXQs0TrYAkntdX0PBt0Nq6GOcplWB3poLEpoJQM/e9lBidqzeL4PFv/fhJADIVcBLbIkcTzxaOXe5lFcaFqvjFPQTCmz1iFw6Q0YQfVTSP77tlyB5nTuqNPWI+/bTwfEwWjzrIzquGiwBSp9O1l2y+svlEPfWM8ofmAHyVN9nKGmrDtqJH4+eBsYpGlmcpTW/2WeiBo2kLQ4NCCDUJGQw1eIiz1EvQ/pPDp4hrbaGcfk9MTNe+vBC/8+cXZ55dwIPsf8Wm5wdJD/TcObunJXmuTt3M8o8cF0Q5m/qtrXXQkc6hCK8zFdqx9zPHAB+bp9/Eyg84b8yRd/zPGKf1R193wYhEyX57Dh/4PgtRwMPqP6CEPsqEC+vp/qWGxweCRqT4i7jAFjTdmQByMYkfimxxlCaQO15SFkOxTBk66m03bYx+1lG1RupTghuQQLHv+Avjrnwa12FjVwxyljN50PtBbKE8Mgg6oY+s0LqGJyebKT2quLlU9W+ZjpgkUgLFAYbMfBsAvozQQk9dGfg/4MnKH+N7DrvRmgi1qFykBu/32J2Fqe+KWoWI6Sr4Vqzc0EhmabqKPFvuBKSG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TChDW1buc/y6DDB6oa/96e26Qz2Gnahvjgu2Xiy/RkmPoReCSyWlneXskjtN?=
 =?us-ascii?Q?Fo8zHNlyFU4YiamuTK+5KvfYhvxG+mIrSyxQo6OmcPQqVcfo882RPiewI64E?=
 =?us-ascii?Q?TuZhn37coMAWj3CsDNnGcZAMk/uMJQawub+zL33ODsoF9Toe3A3tr1uSBo0I?=
 =?us-ascii?Q?/IuQtFxzt2LaFPimFzjEsLYp03wiADJQ9kbfUC3qj/IvWgS5YLlpBXqhqFuM?=
 =?us-ascii?Q?jtzsp4ZzFbgyRCQjoEondG/F+r8cfg8ua0ifyS9TexW0gLwiE8/VcTX7qNvN?=
 =?us-ascii?Q?eoNEgxJ9kN/HVcFJJxMfODEQvDFN0Bc/8FOMYCK3qv4KObaBAbCf013ePZrp?=
 =?us-ascii?Q?NZ61txYcaVbPBOnWsjj8EWkeTbDx1qaVJYhdVfRcR37QW1Gp4rI7xblLOd3N?=
 =?us-ascii?Q?IanXwdgoJas0pJ/337Sf2UuYzKZ+sU0PYRcXy/Z5Ru3zeBm7aG5u5UsIHVhB?=
 =?us-ascii?Q?3NPWxi9PZeLy53G6bziS2UfTNNvCvrydO81h7LPX/Nry9ZDXn7R0mhliW7KS?=
 =?us-ascii?Q?SJ4vyWQ0FXmli58iOhQhPKVDERvlcuVijFIeARX+WgafzExs0pPM+P/sgZDY?=
 =?us-ascii?Q?e2mP0bOdBkSepQnh+YMzrLDrRlXUfjW2XAsZn5HRyQCSMN6g+tNN+44b6uEY?=
 =?us-ascii?Q?CqiC0gfZb5TBPuBazCtakRJRNnt1QU1VXDP1tRrSuFvGC7aszUCaHTRYibuQ?=
 =?us-ascii?Q?cD17FK4EEN54s0MYI8Hj6hQ84k+Siavohtzy5zGB40OIMaWmZULOSXaE/K1e?=
 =?us-ascii?Q?O88LBXxQhvW/yGm/oSHoMMW1CCqvoJIben5d0YNbtf2bRMlG88S5kDD6VB8c?=
 =?us-ascii?Q?C+21qc+PSW63PFmMTYiy0/tIvF0LpLXwQ3N4YcVZUjN7S6KwqfDrs/rzcFz9?=
 =?us-ascii?Q?VhWY/H4IqaVv5N0q3DnYvsSyxrwYu0md1qjeUMGY2Fdb+gc8WWIwsLwl0iJH?=
 =?us-ascii?Q?qnQzyV4/2r7iHltCiFPkc719JGm8YqisMODp2hDhY7xAXr7U2KuinB3a91RW?=
 =?us-ascii?Q?EaE35TOWEtnNkkO3oAHgXQyYpL87FvZaGIuCa+CxqK6ggDE2uGE+tAQFPG8f?=
 =?us-ascii?Q?zo/bRYh7d2yI7YFTd4FsFH9HnvXsFR/FyigfVg0jgl8Z3/DwVVsDOYl3WD9Q?=
 =?us-ascii?Q?eR8E3Vcey5nNpwMtjyKksJe7tUGbM1Ow5tdeVCgaVHAqllaHDCiq9fC6MM+2?=
 =?us-ascii?Q?KZvFVY6quNtiXhZ++NrR4mTGkHZQhkFVWzZC8mtrNzwDUAE+UVAOS88oARtR?=
 =?us-ascii?Q?PILWN71SzkFzuC+GEpTel+C7GkjVV7hnL83P/TyRoAZ8Mtr7OPuZl6zL+MHz?=
 =?us-ascii?Q?jOD7hxoi1mutvLDOLtZMSAWnbcOZrP/gndOjzKH2NtqDt9KpCoFMK9YzyEkP?=
 =?us-ascii?Q?ycri1m31M8xn3dnI3h52WVZRPYFGWew+3YYWfuQtbYZYXXvmba3YTXl/gOJT?=
 =?us-ascii?Q?1sOU2ABCd0YlVHHw6CJ/pjpC5cpvGazCDIgwEDQSp9am7ZO3zeSgQquQ6eUJ?=
 =?us-ascii?Q?DEnkj7NrUDu3Ru85KjulVmvEV7GevG4+mmFCdvZIXxzMh4KkiP0CtU6ydtRd?=
 =?us-ascii?Q?ToRAin7TVF/uZcrE1KcsszM+ywK02wgw46Q0yICuAndHYXH51k5OYZPwVs9v?=
 =?us-ascii?Q?yIV+OJ+NZxZsOTNCY09YBZ2nmHUfDye3eTML/P/BV6LccHBKcQIMsYUcIwhl?=
 =?us-ascii?Q?cIY38oGjK9FqqsvWHDkSw97s9aov3oHfAjXJd0HHFny8IxQj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d35a43a-c5f5-4d1d-9a0a-08df26adc37c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 09:06:37.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7cxIiOMlv273UYUNF1aW+SWoPEUgQ8vlNs53untFJvNouy5YSFPVdmMgFJqh1MtFs5GUGya/6ZtFOgiPxQMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

Commit ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF
schedulers") makes put_prev_task_scx() pass a retained proxy donor to
ops.enqueue() with SCX_ENQ_BLOCKED.

Some of these puts are only proxy bookkeeping; proxy_resched_idle()
drops the rq's donor reference before switching to idle when:
 - find_proxy_task() cannot run the mutex owner yet and retries through
   idle (e.g., the owner is on a remote CPU),
 - proxy_migrate_task() detaches the donor before migration,
 - proxy_deactivate() blocks a task in the chain whose owner cannot run.

In the first case, BPF has already selected a donor with slice left.
Returning it to ops.enqueue() forces BPF to dispatch it again before
proxy resolution can continue. In the other two cases, the donor is
typically deactivated right after ops.enqueue(), undoing any placement
BPF makes.

As also discussed at the sched_ext microconference at Linux Plumbers
2026, these ops.enqueue/dequeue() invocations do not represent any
meaningful scheduling events, so we should avoid triggering them.

A more reasonable semantic is to keep a donor with slice left at the
head of the local DSQ, so the next pick can resolve its owner, or
deactivation can remove it without an unnecessary BPF handoff.

An IMMED donor can stay there only for a bookkeeping put during proxy
resolution. Mark a blocked pick as awaiting resolution with
SCX_RQ_PROXY_PENDING to distinguish that put from a real preemption and
re-insert the donor with SCX_ENQ_IMMED, so that it only needs
SCX_CAP_ENQ_IMMED rather than SCX_CAP_ENQ. A preempted IMMED donor still
returns to BPF. If a higher priority class takes the CPU once proxy
resolution completes, schedule a local reenqueue, so that a parked IMMED
donor returns to BPF instead of lingering on the local DSQ. Update the
SCX_ENQ_IMMED and SCX_ENQ_BLOCKED documentation accordingly.

Moreover, a donor that has run out of slice now follows the regular put
path, so it can receive SCX_ENQ_LAST when the CPU is about to go idle
and the scheduler needs to arrange a follow-up scheduling event. This
does not apply to bookkeeping puts, where the switch to idle is only
temporary. The blocked-donor specific sanity checks go away together
with the special case.

When a retained donor is removed ahead of a scheduler ownership or
policy change, mark the proxy reset with SCX_RQ_PROXY_BLOCKING and skip
reenqueueing the active donor: sched_proxy_block_task() will dequeue it
next. Report it as not runnable to ops.stopping(), as a regular dequeue
of the current donor does. This avoids a transient ops.enqueue/dequeue()
pair and a false ENQ_LAST warning.

With this, the sched_ext core absorbs the transient proxy-bookkeeping
puts and the BPF scheduler only sees a blocked donor when there is an
actual placement decision to make.

Fixes: ee172227d0dc ("sched_ext: Delegate proxy donor admission to BPF schedulers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v4:
 - Schedule a local reenqueue when a higher priority class takes the CPU after
   the transient proxy idle, so that an IMMED donor parked on the local DSQ does
   not linger behind it (Tejun Heo)
 - Skip the SCX_ENQ_LAST path for proxy bookkeeping puts, fixing the false
   ENQ_LAST warning when the donor is not kept on the local DSQ (Tejun Heo)
 - Rename SCX_RQ_PROXY_PICK_PENDING to SCX_RQ_PROXY_PENDING
 - Link to v3: https://lore.kernel.org/r/20261009200827.4026499-1-arighi@nvidia.com

 kernel/sched/ext/ext.c      | 84+++++++++++++++++++++++++++----------
 kernel/sched/ext/internal.h | 10 ++++-
 kernel/sched/sched.h        |  2 +
 3 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 248b39d09ce3c..49de031204d19 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,6 +24,17 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+/*
+ * Block a retained proxy donor, telling put_prev_task_scx() that the donor is
+ * about to be dequeued and must not be reenqueued.
+ */
+static void scx_block_proxy_donor(struct rq *rq, struct task_struct *p)
+{
+	rq->scx.flags |= SCX_RQ_PROXY_BLOCKING;
+	sched_proxy_block_task(rq, p);
+	rq->scx.flags &= ~SCX_RQ_PROXY_BLOCKING;
+}
+
 bool __scx_allow_proxy_exec(const struct task_struct *p)
 {
 	struct scx_sched *sch;
@@ -47,7 +58,7 @@ void scx_prepare_task_sched_change(struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 
 	update_rq_clock(task_rq(p));
-	sched_proxy_block_task(task_rq(p), p);
+	scx_block_proxy_donor(task_rq(p), p);
 }
 
 /*
@@ -1189,6 +1200,14 @@ void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next)
 		scx_proxy_update_tick(rq, next);
 #endif
 
+	/*
+	 * A higher priority class may wake up while @rq is transiently idle
+	 * for proxy resolution. wakeup_preempt_scx() isn't invoked in that
+	 * case, so reenqueue IMMED donors parked on the local DSQ here.
+	 */
+	if (rq->scx.nr_immed && sched_class_above(rq->next_class, &ext_sched_class))
+		scx_schedule_reenq_local(rq, 0);
+
 	if (rq->scx.flags & SCX_RQ_PROXY_RETRY) {
 		rq->scx.flags &= ~SCX_RQ_PROXY_RETRY;
 		schedule_deferred_locked(rq);
@@ -3346,6 +3365,16 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e t
 	bool first = type == SNT_PICK;
 	bool can_stop_tick;
 
+	/*
+	 * A blocked pick is provisional until proxy resolution completes, see
+	 * put_prev_task_scx(). A retry can repick the same donor, so
+	 * SNT_REPICK must set it again.
+	 */
+	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
+	if (sched_proxy_exec() && p->is_blocked &&
+	    (type == SNT_PICK || type == SNT_REPICK))
+		rq->scx.flags |= SCX_RQ_PROXY_PENDING;
+
 	if (type == SNT_REPICK)
 		return;
 
@@ -3425,6 +3454,7 @@ void scx_proxy_donor_start(struct rq *rq)
 	struct task_struct *donor = rq->donor;
 
 	lockdep_assert_rq_held(rq);
+	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
 
 	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
 		scx_start_task_running(rq, donor);
@@ -3485,8 +3515,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool proxy_put = p->is_blocked && next == rq->idle &&
+			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
+	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
 
+	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
@@ -3510,31 +3545,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
 	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
 		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, !proxy_block);
 
 		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		set_task_runnable(rq, p);
+		if (proxy_block)
+			goto switch_class;
 
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
+		set_task_runnable(rq, p);
 
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
@@ -3543,12 +3571,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * DSQ unless it was an IMMED task. IMMED tasks should not
 		 * linger on a busy CPU, reenqueue them to the BPF scheduler.
 		 *
+		 * The exception is an IMMED donor put by proxy_resched_idle():
+		 * the CPU isn't busy, proxy resolution is only retrying through
+		 * idle, so keep the donor where it can be picked again.
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
@@ -3565,6 +3597,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 						enq_flags |= SCX_ENQ_HEAD;
 				} else {
 					enq_flags |= SCX_ENQ_HEAD;
+					/* only require SCX_CAP_ENQ_IMMED, see scx_caps_for_enq() */
+					if (proxy_put && (p->scx.flags & SCX_TASK_IMMED))
+						enq_flags |= SCX_ENQ_IMMED;
 				}
 
 				scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0,
@@ -3578,13 +3613,15 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
 		 * ops.enqueue() that @p is the only one available for this cpu,
 		 * which should trigger an explicit follow-up scheduling event.
-		 * This doesn't apply if the baseline access on the CPU is lost.
+		 * This doesn't apply if the baseline access on the CPU is lost or
+		 * proxy resolution temporarily switches to idle.
 		 *
 		 * Under core scheduling, a pick dispatches only when nothing is
 		 * locally runnable and can legitimately go idle with @p still
 		 * runnable (see do_pick_task_scx()).
 		 */
-		if (next && sched_class_above(&ext_sched_class, next->sched_class) &&
+		if (!proxy_put && next &&
+		    sched_class_above(&ext_sched_class, next->sched_class) &&
 		    scx_task_can_stay_on_cpu(rq, p)) {
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
@@ -3756,6 +3793,9 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
+	/* A retry can abandon a provisional blocked-donor pick. */
+	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
+
 	/* see kick_sync_wait_bal_cb() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
@@ -4776,7 +4816,7 @@ void scx_prepare_setscheduler(struct task_struct *p, int policy)
 	lockdep_assert_rq_held(task_rq(p));
 
 	if (scx_enabled() && p->policy != policy && policy == SCHED_EXT)
-		sched_proxy_block_task(task_rq(p), p);
+		scx_block_proxy_donor(task_rq(p), p);
 }
 
 static void process_ddsp_deferred_locals(struct rq *rq)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8dcab02a38ab1..8821eb7d143e3 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1818,8 +1818,8 @@ enum scx_enq_flags {
 	/*
 	 * Only allowed on local DSQs. Guarantees that the task either gets
 	 * on the CPU immediately and stays on it, or gets reenqueued back
-	 * to the BPF scheduler. It will never linger on a local DSQ or be
-	 * silently put back after preemption.
+	 * to the BPF scheduler. A blocked proxy donor may be put back on the
+	 * local DSQ temporarily while proxy execution resolves its mutex owner.
 	 *
 	 * The protection persists until the next fresh enqueue - it
 	 * survives SAVE/RESTORE cycles, slice extensions and preemption.
@@ -1865,6 +1865,12 @@ enum scx_enq_flags {
 	/*
 	 * The task is blocked on a mutex and is being kept runnable as a proxy
 	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 *
+	 * Blocking on the mutex does not enqueue the task by itself. A donor put
+	 * with slice left stays at the head of the local DSQ, except when an
+	 * IMMED donor is preempted or cannot stay local. It is passed to
+	 * ops.enqueue() when its slice runs out, the IMMED placement cannot be
+	 * kept, or proxy execution moves it to the owner's CPU.
 	 */
 	SCX_ENQ_BLOCKED		= 1LLU << 42,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fc65296f5c745..3118502d64a9e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -793,6 +793,8 @@ enum scx_rq_flags {
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
 	SCX_RQ_PROXY_RETRY	= 1 << 9, /* proxy-rejected tasks need retry */
 	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
+	SCX_RQ_PROXY_PENDING	= 1 << 11, /* blocked donor awaits proxy resolution */
+	SCX_RQ_PROXY_BLOCKING	= 1 << 12, /* donor is being removed for sched change */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
-- 
2.56.0

