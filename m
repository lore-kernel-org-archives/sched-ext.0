Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53018349AF5
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012838; cv=fail; b=gPYJ4zBIYCUxHnbuKVdl2WARCJ8+maJKox66twHj+ZOEQH7a6Tsa2KgnHOdRZpe6kASmHpUfSBVr2leJaw19zJI1KNPxVp11ItGszh5DasdkV4V+HYBlsg/71mgyZl+Jvg49SrCCxLQ6n4rY/IKw9hGyS7F2BR7uVaULpj8BCfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012838; c=relaxed/simple;
	bh=V9iPaT38Ct0pUXbvL/aBrYD5MrvYEQ+0WW/51d07CyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CprSea5Lxe4RAcrxUz+Y04UvjwYovKCHRohYOvSxye3y51FC+gITr8pZDYt6+Nz2PnQB0Iw72wCEpwwm3qkfAzkDzMeSWfDJZ8XQI/xOc8QLw2KSkX308FWW5IKac0Q5wDMzP6uwk1Wd2Cu9mfluPfocOnTJrov5IPPQiy86okM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=urgaCr/b; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urgaCr/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkjZwOgK8uyz4SruVBCpzU1Vx+WEQ6joFzbmHG6sgDxkbicy37mArGGc5cDsS5pNloDqYB/ylrF/FF2nYs/fp6GqzFYT1cm3iZoILy2mpkUZk4QmbvxwMgV/NesBlkngQu4ytiyqLiIY7HLXLBwoq168MqD/bZed/deDqpbkA9Z4WD/u24A7lEU7RlsP+BLkzYy8GgvbOx1Tpi+rKZ60kwull8cjTWr0xgKYjfPbpECwGjUm26lwVnOWLPBHIEubmU0zfqt1vM6tAsZm2KS8+ue05R6UllhyZ1Aot5bDcefdAiURoW4o691AmIEzfbWnF8W9hVpw0vg/nwh2MFUjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgRneBV2kWQ4PH9LYS1SJRlBXH39U385QzITMMNLg9s=;
 b=YsBIZ4WTEKDoxV1czqfowZTIqS9Kw/ekVC/wujKH5V1Ii7m2Mi+u7er2Hnh/xdDdcQwmOgTAnY9NFvCm86JmbzeQvNPpW7SsuGNgLF0Wl44RrD6E28Z4M0Q1kY8SjY3vKHE/mGG7fcbYZ7Pd3wgDWo1Ari/B5Xb0hCS/SJTTKVkqaiThtx9EQAcmewptg/L3mKEPHAWRQH8eXbsr0LB6uVij8h/PI6zpMAjNtfIo4gEz1y/yqeexMxzL5oCbU+wgq5RI6lwUkRQj73EgVOfdOMGsXdoP3TgZbfn9ISZHU/oV3wuUZfgT+XxgxPBIavcqo97eQdOGG66QM+G3W0Oesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgRneBV2kWQ4PH9LYS1SJRlBXH39U385QzITMMNLg9s=;
 b=urgaCr/bgBp2NnbOYYr0WnDynDVOi+tpm+lgGzjS0bqpSAKylY819lDkbynIxsCtJl+/J8U38lULqSy6/s0EifJWS/9Uwx6jWwxf70axsVr19+y7IywJy2hTI6ddI+RcS4i69iOAMrcsNnlL45Xy9YwU/ms0kTpdN9paajeI9FbMRHUt1Br8jxZ9PlQqrlnChJOpyWI4S/Nfy4JWZjH9ADibanl1Vw0GbFmzQl7pU6oWvZpwcFySm0jEm9xHdlUgif0GaCXeeFZFNH2ZoFYahjzcY1UFtm4+LS0iwyNSCGEDALnfQzDtF+cSeKd+nnQhDhbfjtxSH9X6Q4KSoZEKnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:30 +0000
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
Subject: [PATCH 08/12] sched_ext: Skip ops.runnable() when nested in SCX_CALL_OP_TASK
Date: Thu,  2 Jul 2026 19:09:24 +0200
Message-ID: <20260702171909.1994478-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d66fdb1-5cf9-4232-8ad9-08ded85e3774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cqxVkKzCdSvoQ6MerfsFNMORTNqCtAvahIN0X2QmzGuXUGUMUbaAVX1ITz1adArhTIZrhkI5pX1iPjgPYebjGmHRsPbr8dyFZZ4b3LI9A6MMIycUglYkOzy8mihbQ1F+Db/26d8jY2q10wCOLu5P9WB9z6IWEQuC5uiBVsk0ZxBPv3QPZZXKlJinMdsv+cVLRk8vfWdPLoKgVa3p7SuZcA/5uHuJHQDurU/DWJpZnrnQ7b/+TWEg3UXXLNK1xn9VIv7X9OUJjGUFsa0PY5ZgaXLyv9CRDKUKNFbQCdSi10UJxgexhx7uHQcwdgccX5l+XSn79i2zWGG1bRyzPiOL7xISwJa2w1NSnbWdSy5ftE9or99Q6+lDfIix0eos5keNSt1T4Cn84M661nDARrNEIWmT/lV0yz+Q7XWz9q1UfPUILREa1rD54QgJxj2ESLX9t1MghnkmnYf4HUu5mX5FLHvWN4/tObF18pPzc0jqPlgHUnhuOEpq6THebCEMSg0s5U6UngKpMFVyDRaCXhna4THLi+2rekkbel+NVYOY18P7YaFmUclz9nTM5sMDt8l+bcUsAlvoX5yPqv5J5ontDKJBUv0iB8R7qWNIwfQ1JBJGAyyDESGMVgn2ffe8Yui25A87FtI0pKWobi9u98Q/aDn272YV5ChlirTJAZmUk/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+JEFrE/EVbIjhD8brR2IpoMNwlncetrel49g/273WICP+taW3d23ke9e+sh?=
 =?us-ascii?Q?kb3yIUEAXtrPL3UvPfEvmacTvIKAK0lik8PgRKGSKfVwO0/mMuvPRR5NjVUu?=
 =?us-ascii?Q?GiaveAay3lRdcpB6NVlr4YPryF9j+lxTKYNY43R4fgDVGeoeon12LO/0DA1D?=
 =?us-ascii?Q?I1dDWIzmRKCjxJ60Ba/wEQQ2cZFzN2GeE6x6vkQ9dKJ2sq5DAlyKQ1jqh/Kc?=
 =?us-ascii?Q?JARuzDwQYnpYyeg1mSIswRUB8RWFzBcaGzXIgJS/rN56IsUMJUic1bwU3AoM?=
 =?us-ascii?Q?jUel5VcKJ0YPs8+bNxq32ne+IaK+mFrpU0Rj6ZcON3OlBdujzMiawX2obpre?=
 =?us-ascii?Q?+xlupV6plT++EZWPu4E5dgkQtHJoYh8TpbNPP8AezH9AcGmCUtgkgKv+PvcW?=
 =?us-ascii?Q?MJCT7Rhfo8GBgPtaWhpTAWaZjPdkJdjvyd5y0J9TmMLwqHrOajQM0ukDXZzP?=
 =?us-ascii?Q?PM/jy3zkZmWNw3edxBsnvdWkZhQALPQRj84TJ0GIZLNCNYRND1xP/UvwUbNy?=
 =?us-ascii?Q?A+/5rlvdVBncNcAvesR+eMFBOaQyJ7o48OkwE3kMOahACQ3zfO6wQvsw6Gix?=
 =?us-ascii?Q?aZvxKHSm2FgaotB/G77Tr8G8Q2U5ChXoyKuyFrxkEHMf0jRtxuJl91pzPf5n?=
 =?us-ascii?Q?6K4Cxns4XcmJfa6qGBQRER0StRFwxEBJ/uLBo4HY5Npv6DJyqHGUUCfYy1d/?=
 =?us-ascii?Q?u/7pBZCVKDqfAoIbm4EoHOQXCOkV5o9dpla+G9v1q+/ezWg0/CtSaLnZl1Zn?=
 =?us-ascii?Q?+Ln29KF0NSpfyby8n5j3LhFSH/7ws5n/CFHh/+NfJEDBu2kFG5dcX3CeS4pb?=
 =?us-ascii?Q?uc33+TD1qHmV8UNRc0RNEfCGccE0CdRCDAeEu/pn4BWfuwbkJjqbYwcsDP8a?=
 =?us-ascii?Q?QTHVmR6+BTy/JKFSVpLldAFaoybzCBufO76urbMx5Kwjjn3H5bvcaBfjmO4Z?=
 =?us-ascii?Q?YoUOvsqRs4+gigHmqk5kzEvMBmrGw//DNb+VwVDvwx1dqSR7V+3WBcbGeXlB?=
 =?us-ascii?Q?sDXXO/PL70tIp2tTjSdzcTzvlAKgMi70AUFd+sxJEDali6iL2k6B687o77zm?=
 =?us-ascii?Q?QPki/mQTK4qdoBKho12Fyo/3SaGYiKqcl5JJJ0LKbGGaJ2064x4oOqZP/Kyu?=
 =?us-ascii?Q?yc96XdmLQRrSSVlyFbVk8E1zC4iiYotRqVA6vuDGyWsmdXnuaLTZTaspHsao?=
 =?us-ascii?Q?pAuBiQAdhBxBedgrcwrWjwVEcWOnQF3mmT/RTU4DOR/UebDGvCiUbhSrrloE?=
 =?us-ascii?Q?BnuMmSS0Pm99+yFgtX1ITZJXNw2np+9y8ZQxFbjZLsEbVD1GZFRiNh5ksnJH?=
 =?us-ascii?Q?Sxw4gPYHpG0bUXih+HegkqUIoVKeiSrvfPKFbLobO59BpXwNdaVAS6Oo2kV7?=
 =?us-ascii?Q?hi3bjOEMyKZ7fFmzyOP96elnjpLOWKn9HegVLrBumSwJvUYJAWrrrQdVqwZ9?=
 =?us-ascii?Q?nTHtt4zmAbIb5zCJ6GgHoOgsSZYHkhgqkWNUim6C7AtYN6PEMQQ23d3JUAtW?=
 =?us-ascii?Q?8zfueEIaudLHeqiV1z/X1PzrAMNKtKk6ucSeuxp8RAjeOhrVFxGjP0s6RGOL?=
 =?us-ascii?Q?XizjRbqboaC/K07Y0nfxRQA07Md1haRKvmR8Ec3tiAgCSJ4MqWkkA7XAJK5i?=
 =?us-ascii?Q?V2DBs3hpicezMN8X8mEsFJXhBofgHviLNrdWfGO6ZhrAlBb3UeUT46P4zbyY?=
 =?us-ascii?Q?Fk6YtfBoGyXDw5giwdA9psKtHFG7nSkG69OxxpFyPcpMwbr4RD+cWFTIA5x+?=
 =?us-ascii?Q?NsJuJv0qOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d66fdb1-5cf9-4232-8ad9-08ded85e3774
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:30.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5sJktEYvuQZimhBRy0wMsKzPJEQzzYXrh0s3m/9u1+1rJR783fHEX5UIcE4GZiu+vfC45Jvi9gK00+rrbr4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

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
 include/linux/sched/ext.h   | 7 +++++++
 kernel/sched/ext/ext.c      | 3 ++-
 kernel/sched/ext/internal.h | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index e599bb86f8acd..a0c2077216094 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -201,6 +201,13 @@ struct sched_ext_entity {
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
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4cefe5acb36ff..c48d043dbe58f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1862,7 +1862,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p) &&
+	    !READ_ONCE(current->scx.kf_nest))
 		SCX_CALL_OP_TASK(sch, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 7d92826fc3a5f..1774e44aebcf7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1804,11 +1804,13 @@ do {										\
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
@@ -1817,11 +1819,13 @@ do {										\
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
 
@@ -1831,11 +1835,13 @@ do {										\
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
 
-- 
2.55.0

