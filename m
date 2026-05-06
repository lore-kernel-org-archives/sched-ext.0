Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327F4C0414
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089671; cv=fail; b=PbIhhRaUyJfy7BOTTzKq5J8NNfZW9aAwD/l5jnmF8B0k782AUCgXbCsObg1JycT9OxrIRQXczhH6fYtxAqvfFrXe03GF3UOqAWx1SJUC4RRwtTIaaGci7dX/9eQPkpDjvdV7MBhH6A7Jp+iznq4xJ3clG1bekldWOGQ9nYpPlXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089671; c=relaxed/simple;
	bh=bV26OnWAAuRpbun0suZqiyCWEmSOLxGoDVOlWxICbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZh/nwHMM3NoKXjahWPTxTAQY8T64fHvG8V/LICGB7rr/Jqfkrh/3PqLWN8EuZOFqots2VXsSwzT7MqeiGRaDYyx+rlLIiR6oQj004pKOrgU1jUvyXDL/ngq5T7/Xn/BrbfnCCgcQbwrIXLX1xkvlJFeJDN+czqe0ojyIP323qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iCu9xefX; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCu9xefX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap7oIoQDWZ1wJbj/xH+c0MHFl1dcVwarLDy2S5uglfDKTt7N6zv4e/hdxNqh+NrNnwGBkFlHT9XkeSdQsx7uivoETNuEJ0Aj4tPrXL9DbPWfOFUa/VnHPi1MiZhsE0ZZ2TvLSAdBWVJCpe6BahhDzP3MpkW0rTw3pjDxv/o2FSamf9ipzWAnbBgoE260nLFBYSj4Tv+xbYz4uvU+kZXyXO/6UezG2WW7una8wRiD4ULLjd7vmtbhpNTA6+zBf5JiA1XViG80dOHcx8NqE+lC73ZCdpCVgWWvpjCA0vbufASozSY4aqo5SNmwd7dlarB06977fa/vvSIGljUzIVBmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfYlsTmXBQk6LdSY7qhFPQkgWWUcJxDqo2BpmW1IFa0=;
 b=qgVoaPau+D5Llg/AMWyalSnsp/at4cbwfMzRuOgP9bOqElrKjslV5oqUj2B1TRSOTwc6gTW20dkQ9lHHDRiy/YZp2c8AhJmwoWZGwPNjuTWE0CRG4bvf/SIv1zA9+xuUvytZDFDO7Q9rThim7uLoAjYdPDlqYx/52P1mrC2HSaev08FggepGBoMGa/gK+gDrBlCXBaGd5spW5ip160daoCHN/78XiQxk4Xam1KaDfoW079Bh2VHIBMN9mg0Du8EoqE/f0YXsYG2LThWrsWw42Wj3h0ANOwjtQY+7olCRCsOWUQEAVeC2jMAzGA51K+X9MG3JXOJWB7CbXzGkUjzoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfYlsTmXBQk6LdSY7qhFPQkgWWUcJxDqo2BpmW1IFa0=;
 b=iCu9xefXm+KRnTykCME/3+pUYIAeFoiCLitTYZhuDPJJszzMuAX0+gxHoAXpvV1dt24/gMI9Sa8t8mcHLVKeEIr/1p8Mb8B/qRtNnXVWypoLiOhMlwoW7sbMe/XEwxFIWFgJCcWp3HU8AyQezr1vXWgnTJtd3PzhQtvP/Upy/TkNpse3/QieVEzj6xqQeLRUMg7excUcuFARuw7LeYr92myhdFPKuWB/o9074xdstPWaunZBpp2ArXcGx3yGqX3RBla5fP3dMTBjT/58FMBNAl3INaUXMSnOwyAZK7IclhEMmR/ljFJERIpYdTbviTLWriH/kH5mNFHf4gIMMaXvLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:35 +0000
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
Subject: [PATCH 08/10] sched_ext: Skip ops.runnable() when nested in SCX_CALL_OP_TASK
Date: Wed,  6 May 2026 19:45:48 +0200
Message-ID: <20260506174639.535232-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd492a-473f-4007-b702-08deab978e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2VKKzg6ugoMpQXI5dRBCLx+H9liksj39r9PPWIAJ4RoF7EkHWGw3gWvxh2G/8Zz5pkKx0S+JD+JjVKbYny8jMhRFFaDT7f0h8LExxdtvkEuUHyU0QwMLUYcIvFmHFQDHYE3KeJ7iq7ZvVlBuR0gRRm3/S9ocY+9N2zV80gdFISKKPKrpFXefckxKfRRmQxn9mVQEFwFXi3VES+ECBn7cYgaLCy9FV/H9v4M1ImcE6VqPnK/8OOOX5Oov60IvAoivd5BWZhKbReB6cGzsGSbJK3LMhEpU4K2E6GAsc++JrrX2JLe43Lr3yNH+yjE/QFkBab16eTwvCVeq5BTxTQH3XbvDOyuhWUVi84On6ArkpsYyn6XvsHME1sk459OsaPdlKlxfFuh95vMJZmNyR+MvvCLP2LBagHXK7v82LQW19r9u5+xvsEIMTEyA1XAWYEudl+SLp8IZxrLvK4BBlGTH8ifP3kATBwrmjpAMq4fapypqLyXPh5/2iLoUJrzZVKXBusHvWgnYuQnyKzfJIBFwMS9h7eAZQKRb7fG2u/F4Gy7WYyFEYrWX7JS1hlnekzcy2Eo0ahPrHxDOMPCI0m12ZvF0Bk5yHtMgYga3QxXNOng4zNx9Ka9iV4Gvhhjl+fPcRr0m3uO4MDko030lJQbcQ6IOonGMZzjhfk6BQ/4frlDdA3u3rm32X5KrqZ6wb6AL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QplUcPlOkFWkwYZS40rRt0OL62PwIGkRiSbhWkvPRJFwfBGDzi9hJCFfp3kv?=
 =?us-ascii?Q?vCGPuA9T4hHHUIO3U9Brrj5EUTuEPd03Csz8CKWnvzV6i/oZeISJJI6sOjoU?=
 =?us-ascii?Q?oBFZtgaPhLiS2a0X6CCbVXgwzuxMVb7MQlN7ar48UT6xBGSlcuiXAkAO4dFI?=
 =?us-ascii?Q?/NC/nCGTk9t8nYuBW/QJsxltghXuIDi00iOroXq3hzL67aC31hULXrlw9zkx?=
 =?us-ascii?Q?V+EJQFLRYzuux+Jq1JjpVxyACCe+R38QJvznsijNg1n356F1hL+tQ9gUmM/8?=
 =?us-ascii?Q?M1rfIVYgtbfxryJrtFozTcB9Xt4se++nvfpf+AHRfai6k/wkD3uM30oRkwuZ?=
 =?us-ascii?Q?4RCSxS4dQcWchL/4zSYP0TnOceb/kelxsPVgsetXL6440yJJ0jNNvzMcHMXL?=
 =?us-ascii?Q?fa6RDKfwtNHQfG7JPgPEZ/1NrNlhYbeqXxgpTUaeBYVFoU9yGgd6rKGaDMfz?=
 =?us-ascii?Q?cg/zDJkAa+6UBcPSc5BHgPJxCzrMZZ/fiL4AwtUOzlG3amhrOxRvsshdT2Gl?=
 =?us-ascii?Q?qlBlXtHdQVknTso8Bbq/1bSZrvsklnRB5T+oQxdYu1dbC9obCW3zSQdZBX6n?=
 =?us-ascii?Q?mydPRxUG2kNe6zB3GK1lgLbzomIjsPF//0bAzMaqu8346jTkn1bWQ79TpaAF?=
 =?us-ascii?Q?wCs75S3MTaahrNQWnVV0yfzbUN6uojtjYkYt/qWWVe2iURjQRb0iBTx/0Wwm?=
 =?us-ascii?Q?b2p13rzkKH6xW4Z84M/XtIl2kzK1Rqjte4RCaA/x+HZcgVdpLrRZ0ix18aTo?=
 =?us-ascii?Q?NTtrraLerlNuWphOK/h5cdHrxwymSX9p8tEEjfwYldfG0UYR+Gg1wi9ZxSW5?=
 =?us-ascii?Q?7fphzwxLTWLz/xMMXcPBMO/AcMInsnW3CG3XizGiXZxQGt4HU9K5QaKlsvcx?=
 =?us-ascii?Q?QsdX39RfbIy15+wruRTNB3gc5fyFx5dTcaToapM6jJYfJviJM8r/fx+pEDgO?=
 =?us-ascii?Q?f4vq2/KJWdOXqmzVoaJn6p8OrXYd7kGNnSyvNlkFzZCOr1r+aVAkoo2D33yf?=
 =?us-ascii?Q?SQVFR2Yrhk7OD1G15qCFSh1y1UQPjap/db3zRkFrjTW0cehXO3+BCCVS+fsD?=
 =?us-ascii?Q?BnNvanA8WlIarrvq+o0H0z5XzhborwdNVd8Yn5JG9a5Ih/bzzY91LvQMwc8H?=
 =?us-ascii?Q?RSZ/k25w4YNcLxAaN6gvunb+YPAyUjjNCmsAOGOiaaiLbsin2pd0Y84vsR03?=
 =?us-ascii?Q?AS6pjxrIQFRK1aGfQMoUQFw8fXHeMaAYAB2pwc1D4+ozT7Vw2nVJEQhuMjrD?=
 =?us-ascii?Q?xULuyEICS8B8SZuWeTLft/n7P6FiKkrgI1fT/vTJ/IEx3r3E8E+PnYxY88Um?=
 =?us-ascii?Q?78i+iPvpon/dw67evnTCDdcmMyH1Q060B0yVEXFmwh3HVyaM3fhf/rCpecw5?=
 =?us-ascii?Q?nhkJExZJZlepVx5aau5/H4zqhwrgrQEHoE1+HxTph7u4CSLNTznIyZfE5v8v?=
 =?us-ascii?Q?O1sQ1KAEssybosj8bEilstmfgqS1oT4rn0XZw1LaLssdr2J3m/+K38CyNIIr?=
 =?us-ascii?Q?hRUXSZDdlxppDlpHym0tEjdvfXameQQDu60kUYy4/AWE5u/jh4wG+NviRoy5?=
 =?us-ascii?Q?HCF3KpAaKUrSkMPsO+yJ2lAa/N2aZJGYSxgscW3qikbrIhIUZyO1RNaPEFAQ?=
 =?us-ascii?Q?REA5rVqyFk+dHXCiemPELN+qu/FfLOp/ZSXbUW546xauyo8dbJ0QuKXcuZKS?=
 =?us-ascii?Q?4fJi30wXx7jzrDTY1GvYMEcIWpXOLwaqQoQEm9mCvOWTCrhtkV0Hk0eDrvX4?=
 =?us-ascii?Q?O5jObBZE4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd492a-473f-4007-b702-08deab978e4c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:35.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZtvWQ3j/E9Oyict//m1xo49u7lH/TJd3N+eOhhQuIVibUrsUuSXW2xpJaHsX+4CzFqUnnoem9UzUhizFnsYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

ops.running() can pull in enqueue_task_scx() -> ops.runnable() on the
same current task while kf_tasks[] save/restore is still insufficient
for every BPF/kfunc combination, leading to NULL dispatches and stack
corruption.

Track SCX_CALL_OP_TASK nesting in current->scx.kf_nest (incremented by
all SCX_CALL_OP_TASK* macros) and omit the ops.runnable() callback when
non-zero. The full enqueue path including ops.enqueue() still runs, only
the runnable hook is skipped in this case.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h | 7 +++++++
 kernel/sched/ext.c        | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 5096c05d7a978..8c04edf1bc91a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -197,6 +197,13 @@ struct sched_ext_entity {
 	s32			holding_cpu;
 	s32			selected_cpu;
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
+	/*
+	 * Nesting depth of SCX_CALL_OP_TASK() on this task as %current (e.g.
+	 * during schedule() %current is still the previous task). Used to skip
+	 * ops.runnable() when invoked from inside another task op such as
+	 * ops.running() to avoid breaking BPF re-entrance guarantees.
+	 */
+	u32			kf_nest;
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
 	unsigned long		runnable_at;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1ac885eadfa8e..af9b10cd82c4a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -579,11 +579,13 @@ do {										\
 	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
 	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
 										\
+	current->scx.kf_nest++;							\
 	current->scx.kf_tasks[0] = task;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
 	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
 	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
+	current->scx.kf_nest--;							\
 } while (0)
 
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
@@ -592,11 +594,13 @@ do {										\
 	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
 	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
 										\
+	current->scx.kf_nest++;							\
 	current->scx.kf_tasks[0] = task;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
 	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
 	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
+	current->scx.kf_nest--;							\
 	__ret;									\
 })
 
@@ -606,11 +610,13 @@ do {										\
 	struct task_struct *__scx_kf0_sv = current->scx.kf_tasks[0];		\
 	struct task_struct *__scx_kf1_sv = current->scx.kf_tasks[1];		\
 										\
+	current->scx.kf_nest++;							\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
 	current->scx.kf_tasks[0] = __scx_kf0_sv;				\
 	current->scx.kf_tasks[1] = __scx_kf1_sv;				\
+	current->scx.kf_nest--;							\
 	__ret;									\
 })
 
@@ -2067,7 +2073,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p) &&
+	    !READ_ONCE(current->scx.kf_nest))
 		SCX_CALL_OP_TASK(sch, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
-- 
2.54.0

