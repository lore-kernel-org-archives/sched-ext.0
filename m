Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633C3CB2C7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919370; cv=fail; b=kNTGlKLV4hN1QbhjpiFr6QNA0+WPdoh10IgZg0fsNLgKOazdqgGV++IChOVoga5m5FUq3/0bx0Nq3qObq3rcRTo6i+yPBlwnIKtElFD+WEsYDHQ5TUUhXbUvF+mPfD+UUW29/0OVK7B5pl9Ikxhdgqx++mHHjmSSYF9HOglj+3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919370; c=relaxed/simple;
	bh=YTatZ53HhVpVE7MfE7O4VHiUcgT63IZ9K/cT43OMySg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q47eXFJ+1onFmy3Ur3/VGwUnJzWhGgo5xtuQ70PL4FMybY5E8JlYzP7poexVbs6QULEs+7YAmw+O8+ModvidRlVE1GBgX/MNfp4VZOYmWw0ABMrwnV/g0Dv2P7273ntsy4czH/MfxKXCZjrSFDbPv3pXvPVBsPzb4ijaCVftrWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EN1teDYj; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EN1teDYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrd+jq5tnsO/hIza/cgEzhj25H+W5EC8MHo6Si6VFjnVZ31rzYu80zSF/EcP1jogWEjEz69vA6rxWUkwdM/CE3+IOoPZDstjkp5mz8WxowqxHUCPX+tS41ntyPIWbDKOQ+EZI1JMTbdIMbQxW+ryMb3Bg59exC8LKXZwP3ZHNzttcSK4QwQnQwudZvMwoCXD2tGe9yUN0X0MBTDhOxfiUSMKlc9xYMaPiSrj1Qu9teQ5pynA1q13noM0cSw7QKEa9nxMN3QAyJPRS/CuFSB7WPVIXHcgAgKHE8Yqwy0pSrmdXvKphCjUVW04+a2N1hGzLW/iPsbinpKngphByf/xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u4sGWoeHm96B2O4IoyZpdLk/gjwwWitGLqGFR0CwhM=;
 b=qimPCiEXOsdkqx1K/0VsjklhalQTHPeMiBMjqLHqZv21+i/2i07MP525xq0SGDTqetmvD/2cb4LWgS1BApAC3rF+7n2Ytz+/hrL02roSG6TFJ0JSwe5WgtyLt1NSQM7w/3rbppzHRDvzm7n3hixNvXKMa2KX2YU7bpSeHTFLGtE3y8CptFV2ymEFjB3r8AlbeGhEU/kegFCuwywB+PhdimfjVTcsoQ36fGpt03BbXba3fdyhRS18xlftEZ/3DPWsoRYo0uOnf+wUOpSOv+6qAyhBUORD08OM0wczQmY8hUqU6844a+7Zim3z0WGsx8G6fpMwdXlq2Bb4suhpW2hC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u4sGWoeHm96B2O4IoyZpdLk/gjwwWitGLqGFR0CwhM=;
 b=EN1teDYjtjIcAgdZIljekMDh9Z1WtcXVekDxLFxmYKsDMLJer+KnT+oAod+95I1/N+dR/k6pn+1ECKfGtGzYgR4xvmqkT/Qh2wI+fwBAFS9Z3UUpfp+BdCLhHbGhRseFa/amXbUEumVUcMZRUSBDiEQD+eK66Q5BLnjGKfApKhTk8+q2kMwKXjETic99joOxSsLlkUyzMeTWaKrouDoudt82AZ09AmP7qY6mWo87t4f0DkEvOSbbWNvHhJvH7GoHxnCyLKmoEiQZ0AzSI/yZ6/LkPURuggB75Q4ALUiiWUA8xQoRpsQ7jb0mey6ovHZF/ixc4JzO7Ru+h+DOog7KfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 22:29:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 22:29:24 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Mon, 17 Aug 2026 00:29:20 +0200
Message-ID: <20260816222920.118275-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoI1SOEXuIUHl7jc@slm.duckdns.org>
References: <aoI1SOEXuIUHl7jc@slm.duckdns.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f0a27d-b441-4b82-ed6f-08defbe5d2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4twE9X+0mWFyQEjmKuEn3q9+ew1nrh3jM2e3sBt/o7wmbe5Y1x2NJ0yX3ChPtuZhzmeTKuEoyj3/bwwrNpmQgzUHUZZ0XMKRfF1F96M/f3lewVptJN/MZlWafqQ3p7S2mYwVv3Zc3Nkyi0lPJOin1nZHiS6bYEa3csgFSe3qQGbfp8St6f3oL0d7Sflaqq9gjq0pscu2ute1DTwy33LoMXtCBTSPWlBWj6ebKzQQnY82VcNVsVTsf4enuDYvmdwQDkiNfBtZDyBdI9c65+kkFHgN8XyFzieLo8K+JRpPPIKiMyP0ZG3A08U2t0iqi8G9p0tefgBbtH07BhPSSVOENimMRYE+FKbFZ99Bvr0wxazPZWVXcNTYC89yQsaX/o2GSnO3wCX1CTRAwDng3ufbrJ9uJnAKzLsPhcpQTTRZ5rUpkUoPA65hdkrEvbHvKd22WQKJCCDIAxtmdWzrUJciDjbE7zZfo5l/BfdVZnkjs9sp86UB3BWBA2SlTgB3+zYiTJIZvA/TUgE5N/vQ1UTCg+rzTkG0RGflzTqOMIvlBimNiAhc55wLgGZ40MN5X4sAtJZofxkYCOgfHpHX02YlwFGmMEP/YDnS9/jIPDFWFnU5RSdkISP60nHoyZXL8dELCroE08ueAU4CvJ9sOmhKTuomm0IbpVlujMJaIw7ArYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?isaoGxHmWKy2s0W8OBVFD4oQn+SVOYdfGUoyw63to07wRJY91UJdAsv1J7q6?=
 =?us-ascii?Q?EwX2hhfLJtzKRTsuKcsBLTwuQf9sDZ9K9ew/39SlW0BWBEV3eqGX1L17Kc5/?=
 =?us-ascii?Q?KCpKhcyrwWNyGpw6PZejQeKfI4rkqvwJG05TOdjR/Jk3s6FVRa9IatwmG3sn?=
 =?us-ascii?Q?aPQYOmeRHxwAFq67fqZZIGT9TWwV0yypXgQV1xJbV7qFeDHkOPAhopySXYnn?=
 =?us-ascii?Q?FGkzYgeIr6OEX76LtdfKmEbqwJXZpT2sDMhqOWPcjWoZb1Sg7PCGxtrE1KTN?=
 =?us-ascii?Q?Tq86atkxWmzglBMNqvx5Ewl/8en3yexfvd2chgpXLazbWQvpnwqZ2ifZXlKJ?=
 =?us-ascii?Q?qe2A2E47ehtd5FxDsYl8e3B2YObFdUIvmxPJUpaQo73GjndyODKbpJ+53kz9?=
 =?us-ascii?Q?Hr6xO+xVur2LhI/jFjEjVjBKLr5R9vlJqb3ABArymAZDLPOm59NeX3QpqrX8?=
 =?us-ascii?Q?3NjPUMVZpnYKTEbPfxdpQ5OTo8OEWpmBY16IdtCjYtoKoKwVkjVVMPDnde8U?=
 =?us-ascii?Q?WtteZJaweRmb49iRwRDk/w1FRpCAjCpVrJWmbu03PyytnDgfQnZInG79FvjK?=
 =?us-ascii?Q?8c8LJb0bjGn0e8HGpXr+dCFOd92K+vcoQupj8Z9fzJsVkZMtTf0HmqqI4ZBQ?=
 =?us-ascii?Q?IrW3v+i5adqZXgG/hJYxu0xRcTaiJ6X1PmvxtXJQv4InnO0wYAit6+o6g87A?=
 =?us-ascii?Q?u62dUt2bgP8+q6aBpmhlnsU9U/GlVrMN0Uqct16FI8/aJPgUGhP95eBKbEwA?=
 =?us-ascii?Q?sgLgUxwPxgFtZe9iQLjS1TcNrkJFh0KZSy763n5KYk+qJzwidMe7txh5e64r?=
 =?us-ascii?Q?FTzR7mq0MUrlP4zdm0UiAfT6eUstIk88HoxAeVfe47pB00kpPF8AtfiP9Fh1?=
 =?us-ascii?Q?eJHrrWVB1jOuNgGc4gmNQ+Iu9guedYqecaWwFncoODie7hOSA1xTVYsXNL+I?=
 =?us-ascii?Q?4mH2vc3GrGQkgdPH5VCEp4q2MFAwgrPRl3Xr/jsydAZhjsOTG7eTwNeiTCoV?=
 =?us-ascii?Q?GYY97t1kLP6aydBX5fg2Oz6zwMKEEMCvVY8KMKIrS6pjDewJ/wVXb15YZNpV?=
 =?us-ascii?Q?AMM8whNhQifLDU8g8InUgXM38Q2K67w/7TLqNd/hv91QWfsbf+qpmSiVxW7E?=
 =?us-ascii?Q?C8v65305waBiuctkXxUFA0nZim3cbBY4l4jGAf1DWCCabF6jJRJRci9d88RB?=
 =?us-ascii?Q?Fmort9CUcejGE45JXdt3EG/HQZ/PPMpki5EGNuIhZuG1+xeQOhLLmMlaUX+l?=
 =?us-ascii?Q?N8e8Gri8xa6QOnD4nIZkjBTMIkSyOAZQu7WIKtTsdIGWepPJj071oWaHAIck?=
 =?us-ascii?Q?AFPbwnmTH/Ll0x4/H8c4qitPCg26UADkyRWsMrNU392mF1RVJeHBYmg/djDB?=
 =?us-ascii?Q?RnScosDuQGIEfFooonVHou0VeWnLIXZDwe0aUaX+H0YrASuYPdxs5cAQgFEQ?=
 =?us-ascii?Q?XydMH/Duc/pe9fuDSjZQNhRya82TyIjJxaVU7NvuOdR8MpsNw7NKZYw8VT7R?=
 =?us-ascii?Q?CFipu87SoBjRqiltN2u8DpKcEyRgq3wJeklSgKmoRK7AiGZSLQ9zUV3pAdvR?=
 =?us-ascii?Q?EkkT2HN5WgOXVyxYMruKTnsxAF7M08+iuxjkr6Udta7NBXcrlPJ/TAGbkwlH?=
 =?us-ascii?Q?9y+zh51M6aoJx4FnwbGbUsW3WzIrlIhZ4BZArmzGAOanBpFZ/m13XSMoENUi?=
 =?us-ascii?Q?1ENj8MKIg6y0+BXuT35xuFqQso5n3HpnYpS3wCYwnQAiY1BqoHoXn2Elbjjr?=
 =?us-ascii?Q?qEtGpyANTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f0a27d-b441-4b82-ed6f-08defbe5d2f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 22:29:23.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um7id/uRJwRt5TcmWx/5PjnoZQgq9czGrTlPpcAY9T8+g6rLI8XTStqkVNzFHkX3ofIL2BVZdbWAJ9cjAAJNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

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

Track these sessions with a new SCX_TASK_RUN_TRACKED flag. The explicit
running-state tracking is also required by later donor-based accounting:
it prevents an EXT owner executing for a non-EXT donor from being
treated as the active EXT scheduling context when it is dequeued.

This is a preparatory change for enabling proxy execution together with
sched_ext.

Cc: Tejun Heo <tj@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Simplify the donor checks and clarify normal selection versus
   SAVE/RESTORE handling (Tejun Heo)

 include/linux/sched/ext.h                     |  1 +
 kernel/sched/ext/ext.c                        | 70 ++++++++++++++-----
 kernel/sched/ext/internal.h                   |  6 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a9839..9912ad0c2d445 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
+	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7bbe3c2e243af..e1bee7b11c96a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2289,10 +2289,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
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
@@ -2300,11 +2300,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (task_current(rq, p) &&
-	    (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq)))) {
-		update_curr_scx(rq);
-		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq))) {
+			update_curr_scx(rq);
+			if (SCX_HAS_OP(sch, stopping))
+				SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -3009,10 +3011,21 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
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
@@ -3024,9 +3037,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED.
+	 *
+	 * During a normal switch (@first), a blocked task is only a provisional
+	 * donor. Proxy resolution may fail or migrate the donor to another CPU,
+	 * so defer ops.running() until scx_proxy_donor_start() confirms that
+	 * resolution succeeded.
+	 *
+	 * !@first denotes restoration after a SAVE/RESTORE cycle. The matching
+	 * dequeue already issued ops.stopping(), so restart the session here
+	 * regardless of the donor state.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !(p->is_blocked && first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3072,6 +3096,12 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3147,9 +3177,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			scx_task_slice_ended(rq, p);
 	}
 
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
index fa20cac3ab61f..2b2dcde923600 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -449,6 +449,12 @@ struct sched_ext_ops {
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
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 19aa1de3e7005..cccc0c3987b85 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -101,6 +101,7 @@
 #define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
+#define HAVE_SCX_TASK_RUN_TRACKED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
-- 
2.55.0
