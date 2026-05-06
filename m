Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BE4B8DDD
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089663; cv=fail; b=GNhO3nXP2RnZvZKnqwrTvCK5bjrsu2rr4JJiyotcsaqDrnFM6tSk18LyHDG922/fjvt+AQwqdHS2OUS9kOiZuXqIKs9pwbGdht2Dnkr1EOqSk/gDheHEMvSQ1yqPDThoqx6iufBGb5To3fOpI65BqIizOzYTWXW2cs115osc8CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089663; c=relaxed/simple;
	bh=WNPU4S2skZAygpxa8PmTF48VuohBD0HLnvmvCMH8TBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4cHmS5Gm6pozsoQ81GXxeeBHLij2cc7xwi7rPwBKX34ZAYDLRol4LCbI9qblOGVI9iTDZEKmSvBEepfX2ML2inG9XX6FxnqqJ4fjUG973cFjkrjyPs5VkyJrvQqssi3pD2NexbvGidBAZp0IB+40RTEFvM8kmiz7C4EhwV2izQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1ddwAa2; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1ddwAa2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4PQLa6M3gpuzAvAQpQKqo6PEdgdX7TNmTR4AtFsPowQocUgXgk6JCaRF7FSfuBTlsELC4/MymE4LjT3h9R8M2Ydu72imAkB2vofzVa++y89qSof6HdrIGqhlR0ITWL8LfHy3cQfNvUEtq26USxHcQWDUMgejgtq/TcQz9wtdJLcmffa0bu4dYXGZOGqSPO96A6BntQE6HLvELdawENVIxF/gEryJBoFG7/W9hC9DEXOfqv6GjLmzMlvWAvOKliCBC0LbT9eUDuigQgV1QqHhhJZjy0DF4sNqrBBuYd9fVJusadXgVKPsr11nMxZJAQwryPwwGLRSrJKZ6kDktnsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au7suUdRqD8m7sbp7/FNqluo00E6w/GBXnNBjDecpTY=;
 b=ANs8BjB1n9+gBastfgx/aoB4pBKF6WbROt7q5MUK3FfYhuvg5H6ofJz+e/h2oQpvLZItvg3YtzR1iMGo9WD0hoYRmliL+49Cpe6TR11Gu1btWOu6YYJ68yXJpATszcb7g3hNjtUmA4L51XOqJgTJ16V29yilZJMVO9G4COzcjpWaMBigNLoyY5RmG0pXHPypvhglFRBBCz0o7PfsZq9D7oTmJIl42tNvfVP/ZyMvRpno79L1WBZ05kMs18m2+nX7QPkQgQe9vhWz/kSliFYCA2HCc2YBStSzOFRyAlcHFACMU/GnYiTfcD8GTA/qYJKk8oneVxegcrNijJnhQc3AZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au7suUdRqD8m7sbp7/FNqluo00E6w/GBXnNBjDecpTY=;
 b=N1ddwAa2zqI9oI/2BASpVZGz1znWPVVRqPkHV8+gNw3CkZw3+RcWxWAdUJhWkoYyo2ZeZIjvQ6ElVfi3NmBfdWBV+kv6LD47moRChHKQnUu3ZAzzpdtDVpE01dJEKhac0SHTcviICvpq3klB4kh0i0FFLupuiU25ylaYdaHLlRcMsrrdqFRrbFV++uyR0U5gQT+OR8YyXZv2QerYGv9MmjO0fwyi4YnlEIyr0qyKMTHrDCKzGnbSHcFrlA604ukk6ib61D1BZIUFJ2Gr5gqDRETFpz/bUrhl4HAiDun3ZG1hte78hC13xvFFecqybeDniWl9ipG2vpMwUPB7i7au5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:30 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] sched_ext: Save/restore kf_tasks[] when task ops nest
Date: Wed,  6 May 2026 19:45:47 +0200
Message-ID: <20260506174639.535232-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008CE.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42a) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5526dd-3a8d-42fb-8286-08deab978b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MjFbTXZlCpk9ub9W3E+fKO05A5P9iih1AthWCDXkNwb0mvex5OQ7JWcN7rVjn3f+visYm1DjgoXopu+dDQvuGGzrw2o1+j/VbXUlCAZuUGJJBgjDVHsXOkEBeACgxqPJ3A1OVqX2L06Pm5Ed3+Oen1iN+CiKHR6iJ0rvZzvkL1BEyXkOirQHgJdroc7H0LCML2KrKxhwaBEFsW3gPhc2sE1hCc+YlT2SK0YhFvoSmgZSSAtsqBCKfsYZdjk6ZcoLOSF7QrGwCO25Sps8QKrQyYolmNmPzG1QSdzcAmi37QFRAdqYDdrbFloSUhiy0kRW2VdV/Ccu8AyVGz32/cxik8hp2GuEb7VfZ8Otvu7xFW47xRqoBNgVGlxa+ZNCTFHYRE1FyBlPYkFkWCkCqN7llhQo2KCz8nXAfcQ+uC621UB+yP9E2oc+MVDFNTqRhpmjqVHbQCHWbECD1ZbJBrWR4U+qu+kHsBGSf1khGFIiTuUIyRtjdmshM+tv7SK38EkngdsgY/aZ+uCTbs506pWy78VKL1LdGEPTj+8y7zb7FfCdyqt6wNASOak3BQJSJHhURwigf4MV6rVJP1fcwwuM5DJzIP/9l/THVBxWwz8ehiiY2rgD3zBZ1ZifxW2HI5XvQynjkAOMBG9NkFpbIyjyDM6DWGxuqPvvTI6aIYXDtSEv5s+38p6u3jlR59q4qjP9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/RWp83hmgv0Pbi064UPpy3LGEh2/7qtetBYvgAi3QCTdXHVN6Rx4fKuf9FR?=
 =?us-ascii?Q?Jxaypok2r08RcOcsCWyu2s50cgznNfDhyRleddnjvI+BF8z0vs8KGM79fg/x?=
 =?us-ascii?Q?krpqXqFG1GYQL6wlpOPxVx/ncw9rOvLqsr9n3WMZMYtLnnFYjyWyKCxDG+Bd?=
 =?us-ascii?Q?hJ4HpZmSoJwzlQCqyBeQ1o1n8Ch+GX4+FjGaaqtE1i9V60HU1TW5QbMWdpYM?=
 =?us-ascii?Q?UaL1HwXgJVJiMX33pccZaqF6RI6jPK9YoXO48hRuv40+C397J6b03xi0qMmV?=
 =?us-ascii?Q?a0k2u6xmde+UTQP6Q0VA5CVkRwlTyv71rZmTR88zaZ1TDdc+zx/MOVseSgot?=
 =?us-ascii?Q?W/WB+eK+MbvBzV8+EQeHfoQj2lUqm9OlElWfJzq6sMae4ug39HUpTjroemKw?=
 =?us-ascii?Q?uIx1GWlTd/Jrr5pqNZTlmkIwTfPRVHb5WvNbsFP6QP9lQwsXMynpJ94NalLf?=
 =?us-ascii?Q?c3xnpvW00s501LlQmQSl9+mJXUWY83Gj6Br+AqToNjU5di23GBqIxTnFADZU?=
 =?us-ascii?Q?iiPgPk6HBIyXwv0qMrhXKHqGrAjXd2taSwxGoO8IQIU9ACqvuLsGdfuf6W5e?=
 =?us-ascii?Q?KOZakOt5NKZfFtJibzRkjpnrmSZMypQGhq7sQ4ba3QdUnySWBjlHZl+Pw+3l?=
 =?us-ascii?Q?F5exM8ki9QS2rM2Zzy4xc2MxHKRuCmkTpurdoxOwOvLV8kerhe3s/+ykqrZB?=
 =?us-ascii?Q?R5owD/uHph2xXC68jfAP/8d9XJeo31n2xAiuoh7O9Jic+3wu+/zWw4ld1Wnt?=
 =?us-ascii?Q?ZQaJuQpNmRVjne0JdK/RFFFuQNt6NqNwdGxPOuHvCcz6gTHFKrJsbgJHnE3Z?=
 =?us-ascii?Q?oKtyq4gWLrSG1cr/E0WfZawM87iEudM0Q9VWP77dRL602FgfF5L5o3NT5F20?=
 =?us-ascii?Q?hc2cvUtZF9moKUy5/TNkpA1n1nIrFYtOM1imcbppyaN6YABgRCwgn0xK6aSs?=
 =?us-ascii?Q?NoMs8uyovqblRlgXRl6kpzolC1msFtmJXOgr0qWeDogN1zjVypClBGVuNRBn?=
 =?us-ascii?Q?jI2ZBIO0oBr0eEv83bsxG3EGSVb6MAC6DsE8wNd/a1cmH0Aew4NgYQh5iaaY?=
 =?us-ascii?Q?5DUK4gn4zGrutsbkJq7vjw+ljKjhlEFnzd+gd2hSOwjsjJAN6BUklSdDEE6n?=
 =?us-ascii?Q?wHGmiMs2cA4CTGpxLBR1yFKjzO5GMSewbGcIRz9MGntnXVdZJHvQ3+HX5fk1?=
 =?us-ascii?Q?cqdsnO3pHxOclWLOelLbN1Y6whpgZGiiPmg6tq9QYvaxNL5391MJgsL+bNmV?=
 =?us-ascii?Q?0a9VXAYcNArQJW3PK0wTKFZTxmCslKZ+PKIz61AhmuhOydpzcenNrWm9qInb?=
 =?us-ascii?Q?Nqo+XlvGfUz+sDODvTvytalFrmU+kaPdYZoWgXuHEGDo45upZC4ppTNW6ExT?=
 =?us-ascii?Q?N5N3B80V7rpqKoZ4GL9x/43vFfNWDERAoNNXv26Q2ifb/Q2XfKVQMuf8wCjs?=
 =?us-ascii?Q?2I0dcUGF0Q7XqP7Rkavt+uO3em5SYUGfTtKEEmHiXlKtFjb0W7Sc2yOhakh8?=
 =?us-ascii?Q?qdpOl1aBzgSXXNtJCsdl/6Z3PcCPSrnHhCW2/u30DyJ8yozXHllyyQRfvKnY?=
 =?us-ascii?Q?lRXAM4/yv5Apto63tyixoTUoolPKIysgVRDrnUe4899NKA75VwXptmw1gWwH?=
 =?us-ascii?Q?fG+C8uwhIQ5mjBOHItlEdbWeOgk2gQziPQiYn2n2f/bjD8smh6XO/yptt7Xl?=
 =?us-ascii?Q?L7vnE4VS7ymJ3Hsz0kvyvhNYzsXTUtHLtfcocpG49RvPqlQq4qYwQxLxgXOg?=
 =?us-ascii?Q?G231S3f1pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5526dd-3a8d-42fb-8286-08deab978b2c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:30.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL6hkZMQU4EhjsRTrDWYRnehPv6QOI4BEQ6Tpw2/p5wj3Qxkgq9w4C4OWBW9ChOyLXl/KPUq+H6FSOHjeKMifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

SCX_CALL_OP_TASK*() stored the subject task in current->scx.kf_tasks[]
and assumed ops would not nest. A BPF ops.running() callback can call
kfuncs (e.g. scx_bpf_dsq_insert) that enqueue work and trigger
enqueue_task_scx() -> ops.runnable(), which used SCX_CALL_OP_TASK again
and overwrote kf_tasks[0] then cleared it, leaving the running context
wrong and leading to NULL function dispatches from BPF helpers.

Save and restore kf_tasks[] (both slots for the two-task variant) around
each invocation so nested task-based ops preserve the outer context.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b6d29087ec0e8..1ac885eadfa8e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -567,37 +567,50 @@ static s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
  * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
  * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
  *
- * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
- * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
- * while a previous one is still in progress.
+ * Task-based SCX ops may nest (e.g. ops.running() calling a kfunc that ends up
+ * in enqueue_task_scx() -> ops.runnable()). Save and restore kf_tasks[] around
+ * each invocation so the outer op's context is restored for kfuncs and for
+ * further nested calls. Single-task ops save/restore both slots and clear
+ * kf_tasks[1] while active so a nested call under SCX_CALL_OP_2TASKS_RET does
+ * not leave the outer pair's second task authenticated for kfuncs.
  */
 #define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
 do {										\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
+	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
+										\
 	current->scx.kf_tasks[0] = task;					\
+	current->scx.kf_tasks[1] = NULL;					\
 	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
-	current->scx.kf_tasks[0] = NULL;					\
+	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
+	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
 } while (0)
 
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
+	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
+										\
 	current->scx.kf_tasks[0] = task;					\
+	current->scx.kf_tasks[1] = NULL;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
-	current->scx.kf_tasks[0] = NULL;					\
+	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
+	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
 	__ret;									\
 })
 
 #define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
 ({										\
 	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
+	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
+										\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
-	current->scx.kf_tasks[0] = NULL;					\
-	current->scx.kf_tasks[1] = NULL;					\
+	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
+	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
 	__ret;									\
 })
 
@@ -616,8 +629,12 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 					   struct task_struct *task,
 					   const struct cpumask *cpumask)
 {
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);
+	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];
+	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];
+
+	current->scx.kf_nest++;
 	current->scx.kf_tasks[0] = task;
+	current->scx.kf_tasks[1] = NULL;
 	if (rq)
 		update_locked_rq(rq);
 
@@ -633,7 +650,9 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 
 	if (rq)
 		update_locked_rq(NULL);
-	current->scx.kf_tasks[0] = NULL;
+	current->scx.kf_tasks[0] = __scx_kf0_sv;
+	current->scx.kf_tasks[1] = __scx_kf1_sv;
+	current->scx.kf_nest--;
 }
 
 /* see SCX_CALL_OP_TASK() */
-- 
2.54.0

