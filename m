Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80F3A9612
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901917; cv=fail; b=NyN/zdyowlAnUHxjUl4bNYttCLWqAiINV8id+1/51wFB5IozNJlzU9k7yxRcU4f9xtVeb9UfyEMyw9JtUOB5YwEueUI+sXsCB1ZfRvbANWWiRc8Ez0i4da2ZMrgGY9DrNH0ICfYjnMWkUhTqOx+3RNoSXCT42x0/Ns1C7RHIKb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901917; c=relaxed/simple;
	bh=60On48OZMdBhmvOIksC4D+eDuwjCKL4bEhCTH4ez+uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVnnRX77MQMgojZmk7DmMsN3yw6l9FO48Yg9xyWmyamG1tyuJgQVtnmIuKgE6g13uQK/Qp93yKrhvgMo2+TNv7NxLGOpy28GzvFRAHnchCBMstprfNVwZY/GZ7Qgx+1MhNoRlv8qMfTyI8r6vQ2Sl5XwCvlfTHzlCL0oZDjAsyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dAf9yuCs; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dAf9yuCs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaHF+MapuZow2KfLMuHLa9D7XLiyKx4CAWvc2f6aLDpJn/UxI3lAjeKz53cp93jpqLOV8yeylZMxcdcFqsrXFtOKvzS+MhN/gltVCeyqsZzCYotj8bwd/qgMnRkY1EK3bbv/FQQHln390OI7Qalix/kVVQF1gJ6LwEIBT74CDe8Gx9Zp+A6Yg5gWRZ9OVAwvoUs1BWBIkVyu6qXZ2HWFigNMUFlPy6QyfyOsCt7i8n1+HHhpZZuGpKkdXEgDIbzRDmL/vpAC3bapr4HDmZeTHthQoWX3oecNgFEdt0FaLtnyAKKonsTACLijHNqv/7PIG2uaG2TT3mjOICpLikT9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/oiFNDeVMeudy/jKWBYVpwUF6kfHdKqqeH5UiH9yRc=;
 b=ILhUMjgIWuKTHDv4Apy3K1ppNKZdoh1tfADo7AoQuBkiRIJNf+5PumTLOLRKKAYeFjVs7BJiQWwL0+xdd+z1h/Meq0IBWem/i+n5IgR9P+MX07OQs3Et4b1dHGpWNOf3TCIhPDMYy3iAKqaRQUfl6RAdZ0gXGZLzOgpL0L1GFzlsv8FJL66JQZVZ3tlw4pNHgtFA04GXLBAYGCUFBjgjRuf1yHb/Oqfyq+pVaI7CGmgzidWWiJjn6Lt3xebTm/nU0/5z0MNcp+7rKz4NKKhBn3XdOqhu2vsg/CJc8HDafiumX5g0KKJS7/cWN7tTnpmcdU+nvYrURtRpm12mHzMujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/oiFNDeVMeudy/jKWBYVpwUF6kfHdKqqeH5UiH9yRc=;
 b=dAf9yuCsI6erNHu4+F11eUYiIe2PtISpVlz+0C1yIvgXEkbivTZPIkOwyqtHUVHIbC5bHWUR9z8MPzOg4JI9QY381yV0uI2McPDiQCcf4IYN2gSZdAz6x7ob+UsE4GGMasdc0dCgzHKzHx3hPxtVHuttZBcqBz43a62h5BEmgzOyuOoPoUGD8pQQbAe6cGQWPQ/LJCvVaMVAkSxLKTvYWFsvlIqZ1YQ6y5vEprfca4RadIk1UVqZNGtFV8kUshGEtpF1af71ltRAzLqb7VR1NQJJsoYXZxVt8tOxU6zgjwQAOUuGdqAYJjWlkCRcQRV+1bvgnGDVSgFyrhcQ6oIxyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:32 +0000
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
Subject: [PATCH 14/17] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Sun, 16 Aug 2026 19:35:12 +0200
Message-ID: <20260816173732.17162-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b34544a-ca57-4cae-4818-08defbbd30c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	VwR1ob93MjLg45RAYEp9mBzrf+d8kWMhyrndH6Njrnmd9hyZqCWQ093YK2VlIb+ryL8o/DlGFNB5oEf+T+zRwcfTqWtSW/lLn3JgWfW/VjZ9xTZDvfLiCwVGAq5nPSJwxSsrHRnxrpxbPLg2Tmkv1YU7UBJyyWLM5ZVmr5+BlSgd1agbwx87QvFJyVrTFk7A8eFMo3G4Vbbf/rkQpBFkcHGLsr5ejCNnpz91/pCn4tmpYX7PhUzQVLUns51wPmbGdXImkne5morwZqHNHfsTjOrRZGgeZ4xzl/i4dW+zElj9J/NO+vPoLdG0RLjs0BO65ExHZxqp2uiXfYmMH2VFFXCZ5oNPc6f1T9dUX+Ns8UekOfb8YfFnwdrEuCzKiIZA7v9G87S5zu0kFHLFoqkJU1arJ1M4oVxd9eAelvyxVtcDeRq869EO797w4LE6r4cJ8sGdnkH82OmaJcHZyjfn2lsdzy5whYMdxZNlS77GdTZrYQzmxEdoOISI6oZkepFLt/4QMEkjkkqAO/UmcACWOWcO+1jvOiaFRJkdoRunyvB46nJe3yNFN9s9RyWD9H+bbp/RtpG7PThdUlHS2sM7a7yQAHbsWBE9xnmTumb9jF4iuindwfPHKmLDz/mssNN9UmSnk3EDVLmKQwopWAFsadZIw20zIPCg3Cs0r7nJfNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCiRgORG3RGxlnsV7AlR953BBYgCIBOHbCm9NDvmLEvzPayyJA3hKiROi4Tv?=
 =?us-ascii?Q?hSmKfeSj9kRPqxm0PoH5/4kxdtrqycl56HhFNzG86IBwEsr3ErxInr3MEUqs?=
 =?us-ascii?Q?QdZJa2eXMzXBzFid9c2ebeiEdE6thJ8LvlWtWDDvg1itDxDLagXe9raBfnYu?=
 =?us-ascii?Q?VUBO56WYAFShMcGGUICeE22zHCZkPagvH9RV5wWmiQYQGiSiTy4VCirysRqn?=
 =?us-ascii?Q?A2yYZeGJLhhEqPi+Fd+D6HFFuk3ua1tjzOYximNNvusfstr36cEQM4TDPmq/?=
 =?us-ascii?Q?wbOE4t+/z48ycTJkzZ6wVxpB3yXVb9ai0AH8J4U6v2j+vA6ki2WaXyCEXD17?=
 =?us-ascii?Q?oJRg2K5NFYiCDPRUGV5tjlh598TPXvVzHrUm1Mtz8+U4AOQQjDyl3YPa8/Ux?=
 =?us-ascii?Q?WwI9ornoVAKW62jHTyFrmkiAFU48z/u9A0aGtDsthWZeVkMXUUYLYWaP4S/a?=
 =?us-ascii?Q?9MwJyJKjF4UWDv1Cf7GEJqUwFZWCbMD9XkF/xH9wcTEHR2VWH/w1C+j8RW4J?=
 =?us-ascii?Q?qi4A+IiYUijdwbKcGGrYEMp1ENIXJIsoZgPvMwMNqTTcYAazlyEVGaG4WkjI?=
 =?us-ascii?Q?hvuCg2JzYOXFz48GyJ1E2Ta0p8ZmH636bNDqWReGWRnXyAtHoeprqSslH0o6?=
 =?us-ascii?Q?iscAANKhM7XKnt/qtm4H5bZYa1tN+LfQYgPw4+Evhh791+xI5rIuXiMqdQbR?=
 =?us-ascii?Q?GNtm5DjLlppR1Fzp/MH7umknTW/3fCJP8j8l8//Xff5D5oa9JGeVLwnTD5PF?=
 =?us-ascii?Q?xw2/2ioAIwhwBa1d7TtxakSe+bR+gXHFnTR0g7oR7qedgGaamGFXb5RArAgh?=
 =?us-ascii?Q?qMItfsQ9QY0phN6xMuqhy++5Fj9yjKDYUIRKqsyoZ4Ll1h68s7G0xOivrVTz?=
 =?us-ascii?Q?LhJN8/ncXj2XzOgShiY135Yx9B0aUfMB5a5aNwhEgFzDAm/96PkZ4dUtM2ki?=
 =?us-ascii?Q?Tvb8jbXZD0LvRy6u93qO02YNHP+MoM7uMlJwg/BfppWCxZkrpnAv5vqFw8N8?=
 =?us-ascii?Q?Cg/tZkv3sfaTOs+/VlQXhnp4Csij4ICptSPtOXjxW9A4KnFMOqF4cNlQ9a8N?=
 =?us-ascii?Q?sxR/D6ea/Q3Uy/MIn5cDJueCW/sSOLVZYKVlLbu/DFKBOEbd60/EiadsjtpV?=
 =?us-ascii?Q?4ttE/3ACoULXW16ZvZAxus4na+gdBys1m9WylcMTf62F1E5m7Uli9gwxwaIy?=
 =?us-ascii?Q?I9ggnlZqEBXbtftb7Q7NPn5GosHITRV0GZKPxyXZEZWj7/nJm87BcIQw4APx?=
 =?us-ascii?Q?o4ZioLOmmfpsmqYVwdkkbe+ELa/GS6uAh6wtv81Ic16Sms3chD8KW0OJGWEI?=
 =?us-ascii?Q?ZDTOd9me/FUNPBbEsyoFKr4aMU5BHgaTlyoa1gOC1US+18Ba9VibXqfuBP/B?=
 =?us-ascii?Q?qFSGoEeJTt8D1EzTeoFe5nP03YWeeDdprH9fiQAxoYkGldkEiFU34h2mpXlv?=
 =?us-ascii?Q?UAHwdbVv8k+HFceFiGsLmPZ6sAac9sge6PyWm/kbWeWRfNIXgruUK6+UBILR?=
 =?us-ascii?Q?YiG8J3UPL65wL63KLlvTmMMYhfVpy47+I/MsbKIZE2+BezQ/2EkNnIjin7my?=
 =?us-ascii?Q?ycjKRNdDi0Ap2KT/eG9Q1b4+pCNjiaQVsUadHuneh75uUNrDnjwQECfl73bL?=
 =?us-ascii?Q?1YaH5Di0I3qi1r05i+Kpnf3lO3cwSxUuePHzEFex5pEcxeel9Bkgj6Z6iTYP?=
 =?us-ascii?Q?VepaRf94UgrKoTyD09XZ9VRgM6nVCFVOWtHUptpwnHrO9/W9QHg/vC+UDoAC?=
 =?us-ascii?Q?Y0eoNEY6eA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b34544a-ca57-4cae-4818-08defbbd30c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:32.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUAowbCdCpbv2f2N/d9hJFtAQthWidYpQTa0Op3OpyQe1FsWUo6OBqsdJRWmsCMyCojELeVY4z9tu8/VnZ8HRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

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
 .../sched_ext/include/scx/enum_defs.autogen.h |   2 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 161 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 55c2665a6d37a..0a8288bc1c760 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -105,6 +105,7 @@ enum scx_ent_flags {
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
 	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 16, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4890cede57281..6f61cb4cbd428 100644
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
@@ -2009,6 +2035,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -2059,19 +2086,25 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -2183,8 +2216,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2399,10 +2441,30 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
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
@@ -2517,6 +2579,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
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
@@ -3155,6 +3231,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3318,6 +3396,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -7670,6 +7766,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -8057,6 +8158,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
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
index 8b0be25cda7d0..9d6d00d75072b 100644
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
@@ -1746,6 +1760,12 @@ enum scx_enq_flags {
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
 
@@ -2055,6 +2075,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
+void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 22b2fabb896bf..e994869b581d4 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1215,8 +1215,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1246,8 +1247,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
+	scx_prepare_task_sched_change(p);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1901,8 +1903,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
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
index b1351f346e1d9..3650f187838f0 100644
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
@@ -102,6 +103,7 @@
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
 #define HAVE_SCX_TASK_RUN_TRACKED
+#define HAVE_SCX_TASK_ENQ_WAKEUP
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..c45ce9f1c39ff 100644
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
index e616326545172..52d64a67401ea 100644
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

