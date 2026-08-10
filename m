Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E993415F2B
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375042; cv=fail; b=dl22ZFTkhhfLlsekaNve1rJqmaQcgNEfN6viqCqvG557OOHXCxO1oCW0c0UDiBqn2wY6WI03haTrZHTUwe+KjKapG1mrhy+dq0yuAPX6/4zLJW/WYFPc3cKPAGhlFYnlMwxrDMRvp2fpKx6nge+JvuQPmbZsKn50XV2iJvyO0LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375042; c=relaxed/simple;
	bh=L94Wc8xSclxOF8bl0gC6CdDqdmE3B/FLi8OUeb3HCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U79rlrWzne5etQCxFhvTKDeCAyB7rAyokNqS9MZXnLIV6awe04W0WKzlzz/cmqkZw/1E4O54i1U9lMPMfMg2RBWkVhJbdsIMftvPSMEn/MA6X3h//WXDYpgrYAZEDV2YBytWscquvN3o7T8SBhZrqATxjwjOiNgGambT9kJiFjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQQ4a5wT; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQQ4a5wT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoXV3p7FpexnS4OZncqgNnAwY7GJV4zINlvMmzmZyuskpfXAzbsfn/P9BerLd7eObPwlt5qVQG/pnRZrTkJBEf1vZ+0ZxDq2RUF4R0eMVG7rqoD981O6MphY3dL3fMyXgP/emyrDbwZOqZVU56oSTmsqYyO8rOxSS2TAH+1fBBvEPiSmUFjsQrhU79mIA5zun11odjOkHV/V8SHO/GslPemPE718ms1OdQZREkudcSP9VV2SYK+RkhmYzZl4u2DfKtnr/GP36kF5dEOfXZlSZTKLb7JQqGcpgK963LUSaou+JDeJBJ+EDULXzYv3TyaYD/nGQQaLtTm5tUxUCnj7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FCL5FNY8OVc8RAGD50ge2fu0qDJCI5j2snkRd+0u8g=;
 b=tDrdl3pDb3DHFL+oXiCUEEXY0lwx7ynRjXyXWbC/izTXi/hwvcg7QwgzlC4AbtOkEHro1ZWRGvHIzM5tNY8MJkOzLBb8VsPnuvWVL0VIfnt6Qv883VbGC7tnDqHLhNUzOQlrJw6or4BnXlpI9BAB+f3LCtVoW6+UhZ5TzuDLOLVn65duzDko9BJHwvvfv443vNw8diQ/j3mF63fxikd3zAPNoz8TpasV4/m5e1tDxnTRChgiq7H8fu3joStvSlbW1nCDm4INb6rqCS0jevySP23VGgFZG5BdAidZ3q9XH0gSq5x3p28JXbVSjCrtNIcVkf0NgxJDex785O8Q3h4zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FCL5FNY8OVc8RAGD50ge2fu0qDJCI5j2snkRd+0u8g=;
 b=lQQ4a5wT2qjT9IXBVayR1CqjyFfJ4jPzYdg4BrJ8ocHPwdKr5R0MvsAfg9hGyomEHXsKdqZy2fEZFgoaPrcDFqzGJSTElWtc+QnUzf4z3pUMdEjs31dwSo00zFvC39PuC4PC/FVETNix7VwyudAPLiTlHgKtqkx2KrmtdJAImMDr4aN49uxI6xd0nRq/KaOUqkIEqhk60GRMTL5vMgVMh486YyID7gRsBdQlytpZIx7jTSdToZx+HnkGnurxRMWTt3efO3rkmXPq5vp4ZAyRCykzK0xUgtRTVC8+PKZZQCMd7X0JySWvjULjV859iX7FJ/OOWBceaHG/B+eYjtb69A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:17:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:17:07 +0000
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
Subject: [PATCH 12/15] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Mon, 10 Aug 2026 17:13:58 +0200
Message-ID: <20260810151523.86994-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7958f449-1a9b-4491-68aa-08def6f2712a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	utgE6cu6y61L3tlojN+2Uo2ZjER83J5JFmIQUGY+K5bGN5gkF8KQPHFjQkfVjWmAd6oLKGDM6e7hXGpK8DShR2BwF/NqZYQao2jFlKDmHyv+8riZw3ALOzw9T83S2JM7pSaW8AUV+XQgX5YGV66kM7kJlF6Yn9G/QWtozfTen0QskwSSg3NPN1BLkhjEKFnOsnJ24fv0voo9wNN7X5vix+6+oqsacZF89kmIan9yPlGPhwiN4vkA8DeZNj5T4skTzAwJVFio5AOEk1Z+Qv1+sz3EMttbJ9uRdUU9dnBmYEf4kv9rfudIu7osCXrsJQQgnZzRDAnzr6onUVmft3EtcMdQjIm1IVtM/ACBnv3m+q13t4gHG4br+iA+CGFMD1EEDZrsciw+67o1aMKTDOzqGKyPjBn/31FHZRBdcl4E/MdKY1QKVFYMAU30Q1DeiQ7ALXN4SSP1o/rYtU4r8108DvKWujvlvJQdRs/ifvapiwtnXLOfZ7ZCvIZmKknXOgf555FBiL0AbRX419P4g52w6rpw+b8Q1R6rrJXH22C8WjF3PLRG945QtSxofHI0HvaFBeR96WSf08E7SIRCu0eQiEIkG2TREGvbBuy20BAD0bJZLB+Dmyb1MgbBtt0ph/jI6ycf1X2KcM3b/KXltvopbBjcxd4POfYSeC55npmshTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Rmj/007lcW+wmQtccgYTppb6Y7yd+oUXjdtvMshep5mx87+fkFSL0uY4UWy?=
 =?us-ascii?Q?UX0rTsSplpuxu0HQpds28eV3AxCq2q+01slWYRoPK1UKxdihPkyWMHXq8yvl?=
 =?us-ascii?Q?2GZPJMlFuaKzVe9KpzqtB/LezBsa8gLRcLKBwPAML89x1sfEPueBuDdxBLdY?=
 =?us-ascii?Q?0mnszjB13JK2rGLtGlxBquwVknf7XhlPA7AAbbIGClmqOpok2q85pvNgBaWS?=
 =?us-ascii?Q?p5yVENsZ2J68v1K0PAkJho/TAzkuvorMzeqrjIJIxjVVRLwMQKa1PJJTi1bg?=
 =?us-ascii?Q?6j7V7I4fV/4NbZLFR2hjd74ejsLOhzGTpYtc5Lu048Z3Ab7z9zLB9xZ6VXxJ?=
 =?us-ascii?Q?fK9gdHwD8Q1pqwnUB8ZT4QraPnL4qODTsw3hDaWhVSQplKXwiUmvB9PDfRZt?=
 =?us-ascii?Q?LPI70TI+JJJXNCXZL1uNFBBNff8HuHrv/Ga3JaUzRD6O5yDvm/Z0L6IAEYMe?=
 =?us-ascii?Q?1L19rdhZxdAtER2w1uuGTBXLRoK8ODQjFf5XdyIH9Hq09oR2ui/Un3puzMMK?=
 =?us-ascii?Q?yKpAbotYQBdMsivsW1X37U0b7djaVNM9PFQpdhN1hpb7UiU60onV461/PJfd?=
 =?us-ascii?Q?vfKkaev7T5ax0b3n+toqFLVO0AEmQMS7zFEHHsNEmO9cTX2QTvpG02VAbqAn?=
 =?us-ascii?Q?p9TdGUPzU0jmBE9tjkjQsyr3G4G+VOKAMP40CtxHeqZUACZTsZIOVBWr/jrD?=
 =?us-ascii?Q?o08Ukdf6mHyrn6AF5iJSna9UNAZNcpiTiPtivbWt4G8CdCPm+09VBPWo5lG3?=
 =?us-ascii?Q?HngJfBNOPi08QD2gIBN38Uq3W8Om1Ya5J1DQvUDdtZtCcf/HA93V9TmlsfAI?=
 =?us-ascii?Q?ACTcoeyKYerl882qZ2gVefTUYEClDtPyvrSvkSdj16L+KED6Hau34xjC3+MB?=
 =?us-ascii?Q?BGw6zErbdS1EgKyYd1GUp6kyAEZAlVpvNcfBgW151YQFb1B+wpjbXTiiIEUp?=
 =?us-ascii?Q?5HESv5988T1wTH99kedD+9PZ6p2gCVh9vaa/i7P/Kh02hEbSL5j+MSl6U5AV?=
 =?us-ascii?Q?8d176id3z+s7UzIdRWY5CHHNXFYxLWd+bLhlpVchEVl2YH3DXJFLakufJYOa?=
 =?us-ascii?Q?ONYfGhYHzl/ZmIwa8D1FemEuFLw5shrYR5Fkr3csdxQGs+lyXk83lb2mWowM?=
 =?us-ascii?Q?PXvA5OtcsxqA/AZSOFJiFAIz3Yepvc46JyAuTmuJykRZBwvHoXr4/OFRBZIn?=
 =?us-ascii?Q?QdsAA+K/xCgCZHvZj8S1OINpIYu5Nfw39RS1G4g75S/p9/WQnM8Pex/oUnN5?=
 =?us-ascii?Q?+XWHS0Wu8dJNlwVNlRBT6+GFZCaBmTlVAdFufuuY/6VxLaHkLgY0/Iga5Kwa?=
 =?us-ascii?Q?qr/Fth6uy2ikgChJBeNpMG/mBI9Z3qzDdcOQPYej80aSOdQOTo0RdMn29yTh?=
 =?us-ascii?Q?i4/YGG3Wrm171mkePtkAOqIFZIZ5dUVPknsXzZckpY5lXKcy1Zy/op9ZlLt0?=
 =?us-ascii?Q?RQ020xIPljqY+BPYhn2RC1ZLGXiDwYgVhoNSDuUdSZ2NFya0eh+keWlxREj5?=
 =?us-ascii?Q?elDk0GNLZpRdMsAOQ1nILb1wlLJdvPb5dhgSeeLeD0Ta4n4YcZ6vVfOjyOxx?=
 =?us-ascii?Q?rN3bY/T26Sn7bfYigO397X3ofhWeDgVjwbzqaUnpQNdsV7TDdmrKfxsjMtqJ?=
 =?us-ascii?Q?P0auUXrUNy6Kq/EBZ22u0yFVry8o+2+pTFt98tPSLxBw/7HiyKCN3VVoByux?=
 =?us-ascii?Q?UPAuzwjXl+TZSFo+a9x+Q7MY8xkEQl6vD7irllGBFkSTCZ4udMrnP7cFtCzZ?=
 =?us-ascii?Q?XE7qcyfxUA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7958f449-1a9b-4491-68aa-08def6f2712a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:17:07.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfmEO6Qdsif16R9z4Bp0GWwv3bZP5kL3dsCMMT5A40bUzTU10aTG59OqiZ6EXyRFe7CYMqWfACcRY/huF0TLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Proxy execution keeps a mutex-blocked donor runnable so that its scheduling
context can execute the mutex owner.

Define SCX_OPS_ENQ_BLOCKED as the admission contract for retained donors.
Schedulers without the flag block EXT donors normally. Schedulers with the
flag continue to own blocked donors and receive them through ops.enqueue()
with SCX_ENQ_BLOCKED, allowing BPF to choose their DSQ, CPU and ordering.

After BPF dispatches a donor, proxy execution may move its context
to the rq of the mutex owner. This move is distinct from BPF placement:
wake_cpu continues to identify the callback CPU of the donor, while
task_cpu() identifies the proxy CPU. A proxy-migrated donor returns through
the full wakeup activation path when the mutex is released.

Do not carry a retained proxy session across BPF scheduler ownership
changes. Before root activation, parent-to-child takeover, rehome or punt,
fully deactivate a retained donor unconditionally. The incoming scheduler
then starts with clean task state and applies its own admission policy the
next time the task blocks.

A retained donor that wakes on its callback rq does not pass through
enqueue_task_scx() again. Track full wakeup enqueueing with
SCX_TASK_ENQ_WAKEUP so wakeup_preempt_scx() can request dispatch
reconsideration only for this retained-donor case.

Blocked-donor enqueueing takes precedence over the exiting and
migration-disabled local-DSQ fallbacks, so that an opted-in scheduler sees
every eligible donor request.

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext/ext.c                        | 141 ++++++++++++++++--
 kernel/sched/ext/internal.h                   |  23 ++-
 kernel/sched/ext/sub.c                        |   9 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 160 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 3fe3364604aff..4ff3186eca9eb 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -105,6 +105,7 @@ enum scx_ent_flags {
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
 	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 11, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 39d3e3af05f90..8b0c81b59e738 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,33 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
+}
+
+/*
+ * End retained proxy execution before changing @p's BPF scheduler ownership.
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+	sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -2046,6 +2072,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -2096,19 +2123,25 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
-	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
-	    unlikely(p->flags & PF_EXITING)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
-		enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
-		goto local;
-	}
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
+	if (enq_blocked) {
+		enq_flags |= SCX_ENQ_BLOCKED;
+	} else {
+		/* see %SCX_OPS_ENQ_EXITING */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+		    unlikely(p->flags & PF_EXITING)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
+			enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
+			goto local;
+		}
 
-	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
-	    is_migration_disabled(p)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
-		goto local;
+		/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+		    is_migration_disabled(p)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
+			goto local;
+		}
 	}
 
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
@@ -2215,8 +2248,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
+	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
+	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
+	 */
+	if (enq_flags & ENQUEUE_WAKEUP) {
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
+	} else {
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+	}
 
 	/*
 	 * Restoring the current scheduling context will be immediately followed
@@ -2434,10 +2476,30 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
 	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
+	 *
+	 * A mutex waiter can remain on-rq as a proxy donor while logically
+	 * blocked. If it wakes without having been proxy-migrated,
+	 * ttwu_runnable() calls here without another enqueue_task_scx(). Request
+	 * rescheduling so that ops.dispatch() can reconsider the task after
+	 * ttwu_runnable() clears is_blocked.
+	 *
+	 * A proxy-migrated donor instead returns through the full activation
+	 * path, which calls enqueue_task_scx() before arriving here.
+	 * SCX_TASK_ENQ_WAKEUP records that the enqueue already happened and an
+	 * additional reschedule isn't needed.
 	 */
-	if (p->sched_class == &ext_sched_class)
+	if (p->sched_class == &ext_sched_class) {
+		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
+
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+		if (!enq_wakeup && p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2552,6 +2614,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
+	 */
+	if (sched_proxy_exec() && p->is_blocked &&
+	    task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3176,6 +3252,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3339,6 +3417,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/* Delegate retained donor admission to its owning BPF scheduler. */
+		if (p->is_blocked) {
+			/*
+			 * If the donor is the same and only the mutex owner
+			 * changes, avoid triggering another ops.enqueue(): the
+			 * BPF scheduler has already admitted the donor, so it
+			 * can continue running.
+			 */
+			if (next == p)
+				goto switch_class;
+
+			if (WARN_ON_ONCE(!sch))
+				goto switch_class;
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
@@ -7563,6 +7659,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -7950,6 +8051,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (old_class == new_class && new_class == &ext_sched_class) {
+			/*
+			 * This is an EXT-to-EXT scheduler ownership change, so
+			 * sched_change_begin() won't end retained proxy execution.
+			 */
+			scx_prepare_task_sched_change(p);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, new_class, queue_flags) {
 			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index f02b384d1fb0d..f33c3601b189d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +236,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1740,6 +1754,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -2049,6 +2069,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
+void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 1266dcf446349..8ffa38fc6d5eb 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1209,8 +1209,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1240,8 +1241,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1895,8 +1897,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
+		scx_prepare_task_sched_change(p);
 		scoped_guard (sched_change, p, p->sched_class,
-			      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df5af7..8313a2f6d03ce 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index ec5e3fbc650fa..c4e02ed921574 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -85,6 +85,7 @@
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 11bd9b70811a8..83f2bba3ff291 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -133,6 +133,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index 0cc4f21c6b6a5..b36fb41fa783b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -48,6 +48,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

