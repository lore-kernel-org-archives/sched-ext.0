Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE933A9E2
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959714; cv=fail; b=A2LKogQcdSL5momCnq+PH0Yug5DnrqZX21qt+KByL/lmZ7eAoU6zqofYqP0GTfGHMBZIgQBaT+iA00kDbi5nu16CByrPbWdp2PZml0MUqyFjwAvjU5ejxCFeqURLf6YKsedUFCZPMkH+KCz1tOk1IxWr8wUxgfR6+cRZW0XtRoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959714; c=relaxed/simple;
	bh=IsEcQutnXAw+GrQAHzaWdLRO1Gvq1HCd/CHmfp6E5iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nooBPwYF2DD/gf4pp6Qs/HVAoeKseZtJRgLS3gZD5fC0AvS1hWGfg2Vjr90rfUULiLP98bB1vaZdZJkWc38NOCyHllcO/bBa3TuQ+eS8fHrDZV2eKt4bK1HAhGjCuUP2WmYzGsblr2euvTiBIFciFTJYm/l+WzwkiYAA9XqTA2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQdWzXNs; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQdWzXNs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/YmEi0OLS6pVyUnqERxE0RqiG+Wh2jGBcwu3ToBxUoGPV2AErH1Ybn32skn/w7FzKneAQMxZbVxL8AC543Gwna3kHQ+OCHutSa8Fx69VjtG5M/o7zQB/fCf0Xj71MXVeW43n4C6kqs6YrjWNOFbopj0jUrZiW1UfJcgN6Xq8g79BwOUjEHmw+ujvycKWBVoeeOulcacMCfNp5GYTGIOrW7mourCevGPpvjQawq1F964Fuu5pF13OchfPLPTH4LHxsuKWSLdhNI+eWY1omQOUlorQXTtQTNKKCkogg42TBNkTQUol9dSGKHOKsLTnUgAhdO+v9p9v+VuUdE0gZza/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/uxrNPVQfo17Ms/itS2Ocq638YFe66+fPUAZgTAfN0=;
 b=k2tbCwy0epH6eB0SCtZkGKe9bGb40GeLucGRU/RFVs//lw9eeWhFIhtYbgtYDxqd0Z3iDzjXeeJ4Yrvoh+gDD5S8d16el8fvznWBIZDxRbr40z7KbuomYZmSDbeIOBbtR3KVUw99ru/eZ4eaSAEnas0COdGGrzhnxvOu7ioeUCUr2brw3puvrVBsXPg2QfXerR8sBJ+fgFQQ6t8wO8JedF2/GVbv7CZKomE5Lw3ihWu5RLAwkx4fyMD4a+QKQ7YOxeB0BWjn0Zy+RzeAOEb483U5zlupT4kPHgUGbgA/5AkCVUEbvmzQw4v34e69Z+ddhxZglqW/W7J6kAs8oVR9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/uxrNPVQfo17Ms/itS2Ocq638YFe66+fPUAZgTAfN0=;
 b=tQdWzXNsqbcz3H3XqZk5BSKe58NOUhWNmIcVBGe1sWInV19dbaRIcVZ18WVh/isJKtb1/XNN9gHItov8S/f+4GRDvXsk0rjhbxcW3R2UlqjAH586qm9ou+I07Yjh0/HGY9JKAK+/JO3gIjYQABVlSmW5Ktd5u8S78fGYXgNQt4fM8ym6GppGFNhq4Qt2Xs4CYTJkjXZK/EE3yMqhZwGHpW6cEjSGrKLR5XnMgqBBuy2yIM38wwiP0vYRHTaAixdpumBqtE8HUkGMNv6b7lTRcPz5SxUDGy3MIl6zUWwuDMAcv6XNjOtSe3ppiXdbveG2hiH6Gpq1iZbedN6eXdRk+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:46 +0000
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
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Mon, 13 Jul 2026 18:17:03 +0200
Message-ID: <20260713162112.26785-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcad0e5-a745-4291-c4ce-08dee0fad566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Nn5GlNdFHq668zZJyC53RHu0+XJse2w2K+qpDKwUvmySpiWCuxCG1lcVPXU11m5o8nXXJPNSaWmuh8+bb4o/Rdb/JoMSG1eLMDXkq3hxEAtj/pfOwZ0X3hBeR3288y6YmxP/39VemusnSzjaDz9zdqatTwk+yPSJd54u6+jeh3rI7YkSU76faxeyZihcg4/QtnG3j3vtQO5evkKzK1MP5qt+u5NoxYXYYkQBnno1TPtBy2GMaXkd9O0/1E+wH/lVZzG3D+diVbIoow9GYp+PvydD/f8844jqVmqwPHRye8ybh84wC/e+i5exbJcKT5pc36lNTL2Md8JQZshR2GFSVCcgWZ3dh6rNxxWfe/2aVmMkvhCYpfBNElq7/epJ7qKt/DUmmCa8XwokmW3/e51vKQ3DDFQLSEhmWsY0x2TYLDKxjHJsEFcI8df+hMYzxr4SBdx36rcTlVubqbbjPa7Zd9YXdCWTenFevtcudOft0LYw3VPHzUiKzSucS/aBZHkjb4V7FoLtc0i2BC0H4wqDeNSH9H/IS9VcGS65kEOveAG0N2K2caIuxu2NtvJx87D1XqweKJmoRRCLNiPQq68qMD/lzgSbgZG1YoOl0bcOB157AB74hwzB12OXuVeh0n4r8g0GY7POOjGuLClWs4Oo+DAj6kO4DmxH83WctzRS5VY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HBuYzA1oLrYdMI/gPtznuGAL8O8CG8MkrYWxt1a/qHTVLQgP0S/SaHdXUZXj?=
 =?us-ascii?Q?Y77+YGwDb8vPuNTkyyCuibBtqzeX6A2NsmtTuYl49ZOh9OQ57FONC8HShpg1?=
 =?us-ascii?Q?691CZv8BKMEXlK1VUOneHm+AQYdtMFTS/UyU37gRR8ggyVEdMnm3q7AmyfiS?=
 =?us-ascii?Q?fHvLTlEDpltqkcUobOci9XmZkyfecQ8FfuBHHPQrhl8oU+uPS8Lim4fu/T/R?=
 =?us-ascii?Q?btfiKRdw0DCSnxqno1mKfdQyw4OC8TclDhBMlSeXTAkoAFF5MBXRN/jKqj06?=
 =?us-ascii?Q?drYOAIg11nrpNBBQ1YNF1nvteXXwWa40W9Lw8zRnw9ns8gF/SaVYXSdlk65j?=
 =?us-ascii?Q?4LZJg6hbaQmoqkDUv4SzboUbAEq/9MGn8Q7sWq5P/J21eQMTJSq1XkUd7fbW?=
 =?us-ascii?Q?NEej+2UFfzL51tYozpoX3vMl9b9anAdjoRCxac9+vfV4hY0Y1bBqTLyL+oNA?=
 =?us-ascii?Q?sAILh5MxPI5pkP5cce0bN2PGEBQ7V42SiIbgwu/W/kCKIwPEkXzJ5vGPVhRk?=
 =?us-ascii?Q?e09r5OkmQqcHKr3lJBAcb7lwIJK4hiuc9nhIyWqGgVC7jDikWrW1lWHN9YlE?=
 =?us-ascii?Q?bejJenhz0wPe0PLfmW66MnalCxYBgJewxRzElCGBhWuCNwbR+eXP/La/5yyS?=
 =?us-ascii?Q?xwTs255mpKXPYHmYjR81J498TPRxRkEzCcCkgq6TayOd7k+tI1hCViqrbeKa?=
 =?us-ascii?Q?YIZGjcuWwJlOiI0gDCzHER3JKjlHZd35abKdNRcGqr40lc2aD86I5vql4G79?=
 =?us-ascii?Q?8WqHjiEHBbCZb7XXsumQGIc10UTXz4CRfL6nFGrO9UxRSNVSSDIGiJ9IZweQ?=
 =?us-ascii?Q?3w1mAm+TsZuOM4h9fMY8z7515Wz+m5zomdgoCLlRon6VcWFnRoTDT2tJW76t?=
 =?us-ascii?Q?qw2K5pBtcQ56XWceCse/FdrSagtGFwsCxD38r9LI2A7awzd8pDDmNtQedBeI?=
 =?us-ascii?Q?jLP+RfoG2SH9z9FyK1i5Gkj0ikOoR50kSRyyNJVYFs4/K8B+bklbb7aspmoC?=
 =?us-ascii?Q?LDKtDBQuWSDdquLWo9VJO3o1LYNO9+abLAWKNRaTEyBWwrWXlu/LhcFnNa43?=
 =?us-ascii?Q?LXpNGUrjt3HQ33XtSUuRt8PAQq74HvZbUtwitZbFkzcQ8xmj9j7yjBaWfXCL?=
 =?us-ascii?Q?hjeyjd64t+IxS+JuQpW58M4tX9kmUjx6rQr4xyKRvn9Uf0++34TVn2FxSeEn?=
 =?us-ascii?Q?FrgmJryoIWTr5FQdG1PfenPQWr6JW5tuJC/BOV1a5FQCvMP1WTVXY9T7f1+H?=
 =?us-ascii?Q?ELQwWCVppROrWcVEWAdlTMjQMWjI2caUvfnO4z4Cj/OgnheVxUVH7IrTHkNI?=
 =?us-ascii?Q?mOl0f93XOFxilXGSaV2SV40Sb0mkF70gF5yqhR1u5bkwhKBtRQ/hmvMM+iGq?=
 =?us-ascii?Q?hwC2tr0I6GAqfiIW0njKThZ2HrjJzoeY5157tHQP0vSNFODoaDrOsR6wBodN?=
 =?us-ascii?Q?cZva0/QSvPaxcGnqoGqU6x6MVdCVXyjpDSqlGIzi19aRH+mapV5fjY+VN+Le?=
 =?us-ascii?Q?zkglIOd6wuExM1q5o3nQDsnmZPBtha3g2oY3gxsEQEQlzkvUpfKOqN8w9tiQ?=
 =?us-ascii?Q?3vlshROH/cHMm5wZv1V9QPYXMs12yvxHCXKwwvQ/+UqOEIGLCqSbFXrMxI2i?=
 =?us-ascii?Q?rkASS1QzzrdIaDOX2s6f7OVZ7UpEwBdEQIQ7p4peftWFG74OXuaRk0otGjfG?=
 =?us-ascii?Q?1q3ycpx3RL+Os0pySA4QZToCIhqZfKqK8jvvpVQKObLduqMsimy+FkUdTfGy?=
 =?us-ascii?Q?OAPkv4wydg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcad0e5-a745-4291-c4ce-08dee0fad566
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:46.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9crngDuCrB87B9UDDIo4Or/BiiHTGCMf5YemHwcIvfar5CMyTXpMnw93tXHPAt8medkGffEZ0EO6MqYnwYySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

With proxy-exec, pick_next_task() can return a task with p->is_blocked
set (a proxy donor). put_prev_set_next_task() then calls
set_next_task_scx() on this "ghost" task even though the task only
provides scheduling context and never actually runs.

Calling ops.running() for such a donor produces a spurious running
event. Simply suppressing ops.running() is not sufficient because the
following put_prev_task_scx() would still invoke ops.stopping(),
resulting in an unpaired stopping event.

Introduce SCX_TASK_RUN_TRACKED to track whether a task entered an
ops.running()/stopping() session. Set and clear the flag independently
of ops.running() and ops.stopping(), as the callbacks are independently
optional. Invoke ops.running() only for non-blocked tasks and invoke
ops.stopping() only after entering a tracked session. This keeps the
callbacks paired for proxy donors while preserving stopping
notifications for schedulers which only implement ops.stopping().

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext/ext.c    | 33 +++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 75cb8b119fb79..eebb7e10086a3 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8c527fa14a15f..2bd7d6efa1f2f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2010,9 +2010,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2707,9 +2711,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked proxy
+	 * donor is also skipped because it provides scheduling context but never
+	 * runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !p->is_blocked) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_RUN_TRACKED;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -2812,8 +2824,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	if ((p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.55.0

