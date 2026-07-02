Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432334EF1F
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012829; cv=fail; b=hAZWkgcl4Rg1KPgnekrEZg9tghWfhBpUQi4I7IwQqo9yht5uV21R2Gh7nXi0xHocpv3n/6DQ2xvymSNcz6YmpIkxwiFhIhksbJBhOv5APJ+gV9PFyghKBi99P99ekdn7Tdw9EtXeWlpMU07/wscuH5Pvi39BXnypp/nJSXQJYu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012829; c=relaxed/simple;
	bh=bva6L9pMTjvEDEvKLAzloT2cE33LJFIKetS46zaWWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBJBKXP3Kz+R71Ef44HYStwRI1RGCbFBDpJPfSzbI2AFODq+l4WuTJbIpNyQ0UNu4t8j5b1ttMM9sYNB/wpRBd/PrV4dGty8ERogFnLExf8Y8PEWKqmfJo1B5DdAe3v6czF/U/r0J/sTMXxflQZA6KmDYnppT8eTBX98FgTdz3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Se6R/vz2; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Se6R/vz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK9FCCIzVMF1UdzIp2U9Pn8D7j443S4fcjYuAT8qj8466Q6U75/VqnoMmGwqlX4yvgWGC2GtVqXRphL0pxFpdbm/9e8AOswHP2Ya2O+VVq8uxKO728qup/s8DWM+M61GfUo9AaBb37HNsHof2ZaPXlg3kpqD0pT2rP8PunZDTSbn9ioRz7iCrWBZZIWDO2tO/SudYBnES0Nv0VraIWoxgxtxGgguYxupFET/OX6v8hIwt65IE80+b1QrGzLREurtFcJZAbFgK1ICpxQLxXeDyrWzvcNemrLP9/2u6t5cMMmnXkF2p2OXSeH2i89yXJd08iLUSjsEsZrvz60P7glE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5qVGOqe/HfHmY2CS3UtFZAdiySP5rOvvVDuH3AtjPk=;
 b=fpbsm9OAHO+IWfKFUhSQWf2t4fVk+4pLnsm6QPmhurHD+sjLZxgqElOAdkN28l3OCg5biUdBCwdWh+es8M/cc88GkqL1XdKYmytdhwxPlrDWK0GMq483IIDXo2S4uQ4CTQru2PYrW6TFmkb5FS+cVhDkUzs/xwy81Jblh848YZ7lyuCLsljhbySw66Dkweds0IU9RWM6a9C8LNDAtBqx4JOCI1aP04PKRqqGr89IkT18ZIMEyZB1td2GZxhZuZPtqa2UtuW4WOzgnLRsWMwMPHswqb67vH9LtW7PBUJM6gW/zzwxft77tID4Y5i7625WRzKxFxfYkSd75qNBIL8/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5qVGOqe/HfHmY2CS3UtFZAdiySP5rOvvVDuH3AtjPk=;
 b=Se6R/vz2RrJ/UsXy8t1T8jye0pMsYVIoHhr+AVKuSdnUELGTuZh0QOQDf1HbiTx7LFfLQd/Gax4Sf+Nx+OPjU6FAsRKq+3uEji9yRh6EPpBSZv+9WYwGyCCbo6H2dR+i9EO8DjYZ6IQ4rjfEWYjWpIqr6knrlBmkbebvTnjUqEyoYysrvP/4N+ELdV+v9p9dqjovkmq11Xr4KsioIqWV6hRIbPUZxkyyv9rkLPSG9hW3w7rUz4rGkorP9Igd/oIyCZcmJvFVQGZjD2wG2sj7Yb6KlSLH6MdEUDb1xWhewAGpq+MaJ1jd+qspgIKAq68UBERL0L9iidMlxrPAZKJ3EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:21 +0000
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
Subject: [PATCH 07/12] sched_ext: Save/restore kf_tasks[] when task ops nest
Date: Thu,  2 Jul 2026 19:09:23 +0200
Message-ID: <20260702171909.1994478-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 115992a7-b7a9-4571-5d77-08ded85e3249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U/u7VM8IsgG/hEs8XLiOPVk2q8fa2+o1AjyHiRjh60ESiAoQqSsq7OtXjgGvjAzYN4V7KmtKLUPJFiouX9EHK84nlRvX2BjmbOiyeD+UEYag33YgBWNHWFa4ugWQuT0L4iKJjlAxKp28Q+orNgGdfN1rGRIIRjXycL95PUZwo8iszLON+Lxchx8hDI6uVtLUDzKcVnaSANOyHpYv9xhimxng4jqgrQgbndLriJeH6jo+NUiJ8q1twGibseCmcJLGH7KJMelJnRI9ZKHVy+QMQD+UV84KPVN4ClxxfZ5nTGu13o02trKGlvMbZ6+gW/9rZTnJWWjK4fy7R7S+JCfG+5NL8UZ+NLKjJsr2D8LN1hQaXfjKhB7w3E8qvfTlbqGB7MZoAJvPgYegpjh4b5eemieVGijb38l7hX124s1j2bONRTZNCzhcJ+KrKFsIdjpRpHTcClSux13AmNd74xPrRhnemWePKtTY8bCNwMcnz+C65u1pQcjVFjRvuv7F9v0sfO0Q+8YtMnOcoBU+Jwt18aW0V0aFigW2nctkgX+0Fh2fMZ/FVfm7VhhtOxs6r+qLNewAAvbCUso6KLYct7VH933zSeGu9AkDT7N2c6tRG9rVXRSr0lprmiyHr3qtw6HRxIHq1+MTxMyPuO18efGqpghPM/qV/ad8egshj1b9F5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VuV98fNKp3DIf31Zu2a+QcUxlaNyD1IfeG+Jp+PmbEj+rhvJSn8QmTAwRR4K?=
 =?us-ascii?Q?n6ly4zJDhG/4B1/yNw30ubRNgLwUY7QGMA2LDGIBaVnwKNoonkLX3Ody3mK8?=
 =?us-ascii?Q?6aH1n5/QOyq5BQCAyokevctkOeHubJBDFAEIlTcHf5Q/+Xca6BqGFAVdapOq?=
 =?us-ascii?Q?euJWFzLSpYn6E48FfJ5vTcgJ6gFgg/tr/dZ5jRSJ68e3QkAgy9MvYWXSzMyR?=
 =?us-ascii?Q?nPomiGxeDXg3yhzBth7D/rJNeBoGoaiXbvSbleY2Kduk0B8yw4P5uf5Ad2ne?=
 =?us-ascii?Q?cjjdnJcTyMo6cOIdyZ3qKeTqyC7EKB3EVFSBY07CMc2UpUUFMGa+nBFTSD9Q?=
 =?us-ascii?Q?vuBojPhOtlcTkxdi0ngot3fla1xbYAKgiTGBslBjAEwG8gEz+sT4G2rc8OYP?=
 =?us-ascii?Q?h1QG38wYn5Mo2wzQUdwdctqGZKu41eTdbcanbRt5BA0lB3D8jitl48AiZG6O?=
 =?us-ascii?Q?00yeQMvGHyJXjkmv13zvI9TXu/d8sm49zHHLeUBT3nP/xlpgWtBEcrs1y6nq?=
 =?us-ascii?Q?5KawxmP1UOl4j/fi5tfIkFKpyguyEKnWHrvbbI4XeG7IX6Cv1EDxgQ9YUoLw?=
 =?us-ascii?Q?t44sFns9xs/2gAXKIyaKZcDT6oUFQEPwx0paT071e8tiFBOIJTKDdZDGDdNp?=
 =?us-ascii?Q?dcDZE3lnIaMZijXpeW7uFTcCBhrvBLrzXYDvq8ZD68nG9G8kPqq47gFumTJI?=
 =?us-ascii?Q?Va//vCgNdsaNky02luJuGpzk1kmt737INVVnR2WNgpOYv67oh31T155c1Dpf?=
 =?us-ascii?Q?X9tO0aTcM1z0oaJk4PoJVTh0GArT4UWmcBG8vP7VU1lY3DnkhbDbt0oqo+Oe?=
 =?us-ascii?Q?N3wAbqdRu4XXei0y/nYsWI3evIN/ewMZG34R45cGp73J+UuSVrcgM1Zr739p?=
 =?us-ascii?Q?2EWzOjLaf4rcz2O0LpJ/j81S6Rk8//qR8kd2XEu8H1Q+BIXnMEgV24V8T3Gp?=
 =?us-ascii?Q?GzS8FTHr4nJ+OWkjAkU5MnBz40r2ULrFXt6xvoUGFde06c9Uijf6tIbnfwfL?=
 =?us-ascii?Q?4dqbWXKIL5ILv3nsAZJcz1C9x5AUL9peBBTVCqPy3qTRB4FH5/w/9s2w2j6E?=
 =?us-ascii?Q?APxOCev/w3tfVgOMuhHwno3sr2nSj00ET0+oUCppIXv4l6Oto1XHjI29Ifva?=
 =?us-ascii?Q?TCFzcO5Cku59gr+8GohBfbWW6lBdGQ5AmqZm+BAYWSsikUI8DqdESicl/2/k?=
 =?us-ascii?Q?fep6D37E96lJhJHMNYnXx1D94tl6fs4bYAIVi7278zyfoRRbGMTyL+ezcJUo?=
 =?us-ascii?Q?mGTcXpWFHqD9RWRnTme/krcgSovc1JZGdUmdQMig31NfDHKAzeix98tgjyCr?=
 =?us-ascii?Q?e9Yg4w2wH+tgkLet2It9icUHHl9bv9Af7nCwhd//ajyr17EraW33tcdf1PLD?=
 =?us-ascii?Q?s65seERPlLcWSloDQLbTRpEMnkV2//pJtLNc6MGcUC8uzta3X0+e0AwrzYY0?=
 =?us-ascii?Q?dexhEXVhpYXj7TVZHbQUxGmeDy8aMhu6HNLFoRfzqLnsRcro54OSVmZXkiRw?=
 =?us-ascii?Q?+29iF2bV/Ee/ZsXGdMNkjKJsTA3gcttUZIpKL2oKx0/z14hjWm6mZlAQDFxj?=
 =?us-ascii?Q?7KDKp08i+GUl0+AMtXdnqTcQXvA/RuGq65ee5Z4sz9An7oj4DJW6XWhokIJw?=
 =?us-ascii?Q?lGE7FhtBGGIMcnAda2t8Yb6GPAXAdN3yCALjOjnItZEv545C2aVzcU/beOQm?=
 =?us-ascii?Q?82JTP05PKVcS9LIhDkec/R7gq68LLrMlNxB8cq1BsrrDdy07ETfhEvqnH2m9?=
 =?us-ascii?Q?9P04iihL5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115992a7-b7a9-4571-5d77-08ded85e3249
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:21.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSw/63lRTUOFqKuYweUPtUzsMMQFYexnwMtXCgSuWnG6fMdMDpSGgYQ4cwl2LcVKZD9sSpk3HIeicnAWY5GMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

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
 kernel/sched/ext/ext.c      | 10 ++++++++--
 kernel/sched/ext/internal.h | 33 +++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b0ec579e3a3ef..4cefe5acb36ff 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -410,8 +410,12 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
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
 
@@ -430,7 +434,9 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 
 	if (rq)
 		update_locked_rq(NULL);
-	current->scx.kf_tasks[0] = NULL;
+	current->scx.kf_tasks[0] = __scx_kf0_sv;
+	current->scx.kf_tasks[1] = __scx_kf1_sv;
+	current->scx.kf_nest--;
 }
 
 enum scx_dsq_iter_flags {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index f9fe7c6ebc4be..7d92826fc3a5f 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1792,37 +1792,50 @@ do {										\
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
 
-- 
2.55.0

