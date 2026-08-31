Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D844A64D7
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183886; cv=fail; b=I0KjYF24YbI4dKbTz0WKyJLrHbvMWz+xvnPAvc+v6Z0A5nOT8Y6F72MfgTgdfjOP9wF8OBQKlBDf0u3xk8rpFkCmIikhw9Rh4YFoCNa9acNLBCrkHcV4uoevMDzHG2iLRxR/+dBfEm2tofOsicl8K1I/ngebqRkwwQjmy3FedLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183886; c=relaxed/simple;
	bh=1lIhMj5GpskGsUTmdB/pdpgJOLljensR26uPwauMuco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXcmv1ZhOV8CD2N3cgHvkSilcgALJWN597fZlJ021AvGmcVluHrTEhoNC1JpY+tCmfartcZK55SfTWjijJ2GEnwRnz/CBIo81IXYmjXriVOxk7PizYukKW3OWbTnM8SvzsMdnAF0BAuTG8aH6OxzU4pXIAdIHgqatLxe1lkHQHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PsqApy0J; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsqApy0J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eaj7GIhvXiGZoIckphqAV3Mdv9exui8dnqYtqqFeABIH41E55cviHTBiYRkTcS/TB71WPrPNFL8MS51KbwYTBj/g+dk8TGedNy2batj8fGisIUkfXPXJIB8jZL+fn8pMBnsKs8ihhs+IE0eRWTIVZ7t0tO4/1eljEgAyU3+pylSEeAvVgil9LEw3FMDbdYsXBqz5Tm8/rI77gUS/10gS2oucPTjpM1h1IjDTsrC39/grSjp+P7Eqar1qmJmQViA927L3D2AopmDMxKvicucVcRq+Vhkj3RKUk/643s384nOg7vX8BJHedZS5bWYOwTxEeVeWQ1EZgbKotGRy4Mlw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzvmCBlE0CesQOzMKLvl9ZcKGgINP3hKjck4QWMZyaM=;
 b=pLpjnQBuuON+VdAWZAzF2RYZhCjMNXtVFd8kxbIbk+F8ioPdHUDDfHPdaJjDG4Xj2ephsCzISODiH08j8gqckKz+H2v99vFzAo3bBTh7ThukuvlQpc4okO67PM5oetQ88Pp1KXpTjOXQsgUybzrvwaBMYdwOYmPukY1ZJ1vK+YefzcdI4xGPrDOHwHLk5mwbblqL4reXW0WFC+bjjmGx3HlxvlRiVdf00F0Toh9MwpCVp/E3POXBAeP93m7DydQPiP1H8bYAvgb8pr3/daZAFj+t6o/22LSawwnKFHCbBkbxgBn/cbojdkBY3AlbFmrPPJyWZW2n+we67YRZaHQQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzvmCBlE0CesQOzMKLvl9ZcKGgINP3hKjck4QWMZyaM=;
 b=PsqApy0JtHv252wAMkR0PaPNE5cdwP+FKr2GOzBzQD0pOURKs4fIqIrxJCFs8dwJ3znjjoBr8TwMVNjFL7enV9EVKVeCGL8kQnn3HCv7iJbGNAiPLhFrH9e3HaPR/YfmsE5eS5NzFCFiDgBPYP3opjXfYSSaj5dGUGcROFTLOpzXiVZgEFeLAZOUK/CwuRyBjjbRi6Xe6y/hvGXDKZ+LPzGB3RwjGeILIcKAdqVX71YZ6P1tEUre0mwvRSknesZFC2suDT2H2SDnYHEwLo2Wa4WlLKxVHmlYjt8mFJAZIi1DSe+16LO/+U4S3S9etWmgbOhCfoo4ZWVJZ8bcUCvzNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:36 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:36 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] sched: Add helper to block retained proxy donors
Date: Mon, 31 Aug 2026 15:42:16 +0200
Message-ID: <20260831134338.1531664-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 238eab13-d018-4d24-5304-08df0765ff15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oNBl1TnBMpaGc4ImTK9ymPjVlDynITGVoMyJWB7Curw2NVTry/j3xq5hZHRBQKUxfM7jnDK7HCHA//1xxTLOjw6fHMWhAGpDATS17k0Wh3BCsKIOv+e2vI+qR54IaU50ZuwW/jr9NiZHFYfaq9XY9qSBp48xd6K2dZmjeEgKkX58MmJvnJcZcdOW8tQMmOyPncTTJzDPXqgKtPFeBlRbVte79rCpeDA5obtoTBBJ3Ha/MmZJPi+9GWuMRIVbt5/4gM/MfbTVyaJjlxL1XJ9ekNvEmKj7aojw3hVQmZAXTrDv88EuAhfN57SBkL0yjjExOaQYMyqGYTxAhaaAiUNm6BXbx5d7vvcnqJo9d2/W8y8FEhHFy8Auriq7+2uRHLmvdn8L199+3bkzSpEZ8rV041w07JT5e+MYXIvib6dcKIexXybOcICUQOsxwXJ0hR3CvY3PYy/HfBiD1Nsszr+wugnRH/qLe6RfBmrYSke7uCsjCam0AOHjbyL1wnnNe06tSa+ulSoImSgEuUgBQ6u0LpTQQKqKchopyZRR5CvGHpFELfu9bDdso84DibCoWjb43xDR4KTZYsfc4C3xinxM/4FlVjuAOdOXkrDVr9MrylJlBWtKX7PpZGiSXdogVUu9n9p6Ka0mspiGi5YW6zyKja68pM5YaruYt8t9ZrI7P08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/TRYk+uI6ZA2wqOU7tb+IfgCnNYMfS2qOlUAI8yNROX9h0Db2Zq6uFbFijF?=
 =?us-ascii?Q?pfCHP1QCddXzf5nMAO9+HlV0uMe3gyoE0WB9BJTBVcfrrt24H8l/sEWWLpsu?=
 =?us-ascii?Q?F4mCvielq0I2rDDz58G/LzWmTP1zv1cySumChHHZVRuFwSQkGj1FHPXV2Oua?=
 =?us-ascii?Q?0I8YZwhAPG9rDMMCnbiHRfeRwjLUxv6US/dU/RIXrHzoXurjqIpNtgqsFJ58?=
 =?us-ascii?Q?ZR3hGT2++1pcVHW2atZDz7HkM1WWMAlniQoQb7r/QNchjsBCGdEF0PNY8ZBi?=
 =?us-ascii?Q?QfvXUPXgzFDeaHZ22nsrSEnE5aWMDdtGlZ7EkEWS0fGU4z6m+nd3bGPhnyfb?=
 =?us-ascii?Q?Tc0YaJvRty6MobkQ8zxkfFO5eBOshE/adUUNcegf4sZluWWtPRpa8ALqUvuG?=
 =?us-ascii?Q?1qxse8ec+4CUK+8PysOcKdJBPYI9D/fV+0taGGYt1uzZs13NUXtRCylgA1Rh?=
 =?us-ascii?Q?q9XoH9p0heX7kE36aMa9ENETdnSYgHWi7v3F5Tasvx9Pm67N0cNjcicdt0Vd?=
 =?us-ascii?Q?wcUNV6Gq3sbjTQYUtqAt2RShOOjkLlLc7epMBCqXSAgb7iy2QA/DDlU/Ywwg?=
 =?us-ascii?Q?TPfICgi6M4NGCxwWQnjKFfTTiQ19KL2P/uzZiUi/IbV2ds12WQjanlfAHhcM?=
 =?us-ascii?Q?KoVgm5sc9dZ+3EK1g4510qM8gnEWxeE5kwyS0AhmgDJ4sa73ABGnZFgZztAm?=
 =?us-ascii?Q?mitUc97IOfDQK+cbA2CD607HJSK9ZhZsreVQR8GSN8PcxBLvkl0M9A5Jyvug?=
 =?us-ascii?Q?F3IpnuE7fNVIsuN8ztWRrIj1uSt7zRXYpJpyGYrLQpvnmrCt3H+kOd4WTvhO?=
 =?us-ascii?Q?l64saamjjfV1G5JsXMxUCEY0az4r5prOym4iGkGqOOd9TMpX29+4YhCi7wm+?=
 =?us-ascii?Q?jXCDM6oV1IVBG/jdHo8ZYPoqbGTo8c8xxX2EifTQ+XqGphxVXvhFLsXD5Aup?=
 =?us-ascii?Q?uRelWwFpu6srUulmmw4ObISdqCca6DmT1o0OJsHvoM1fhw+l2qZfnwtdh31Y?=
 =?us-ascii?Q?yfXAYBuNToXsMEDXtRjwYSZrhYPGqj62o/U/cbBiD6N24sgtuEL3QsVCEGBs?=
 =?us-ascii?Q?+9d9ZIYa4bqY+eEmUq8RdXurtXh5hSvlkOe1E28ND9rftVcP8hTW+Z+AESln?=
 =?us-ascii?Q?CdqWvFxWQOspE4mPPr/LTkPW2bh8isdqWWXyRyFaC6rfrSskIBpkcU4K7hJj?=
 =?us-ascii?Q?FxtRvyU7k4OtMqSHAJLL6GJ1XUVm7YjLJ3VJtrEOBEhEz0XsVm9IW4bJgYJH?=
 =?us-ascii?Q?Zm+73lQXydMU5Lg/5h6q0DzYhnPseJZCiZBdxh7sHwZt8ZrjSwN4SeEXIZm7?=
 =?us-ascii?Q?HMnKBSqZ2eS99/sxHvGLr5fnY4/rmFoIzSeKCN3xx03AO+a08LR+y87ZQjyA?=
 =?us-ascii?Q?IaVimyUpVKT+IOOwPePOeQVydWavK/UZJ8DDpFufn72uFbyc8GKCBd/FVxXi?=
 =?us-ascii?Q?CXzwKC4YuzbOu70MstdK7MIOzbKL4McNjuXykBM7QSn+WdwSrARXIqltKcX3?=
 =?us-ascii?Q?a1d3vmb/KTh1WSpk2OVoUeVU5Ztw5xdJcUYv4lE0O96bNTpo5tsPgaRbPUjh?=
 =?us-ascii?Q?oMmYf+jyQkYM4nf1uclfBAFwwJYnRWcXK/HD8bSg5UjuAL+dFphsmfrDoeYF?=
 =?us-ascii?Q?et1uvN27qpuRfGdL8Ev2jJbdZ/VG8y4bQuG64vnMSPx0pS/inPyeXRe7W33H?=
 =?us-ascii?Q?Zwro6Oo8PdVii7XEK8ndQTLME1e6fL11rdO3BpQDvvoWMT4COryEqe2oUs6l?=
 =?us-ascii?Q?jok2ep4j4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238eab13-d018-4d24-5304-08df0765ff15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:36.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pFHEdUizzFD4A9NuRWubJVck5vcg660vDiuWYtkZKWUS0wpTuR8EUPfvvUtMkyiYqim6nKnJ/s4WHABHkX8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Reset an active donor to the
physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
donor queued, the immediately following sched_change_begin() completes
the dequeue through switching_from_fair() before recording its queued
state.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 26b8da8c8a2c5..bb79fcfa21cd2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6822,6 +6822,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
+ * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
+ * queued, switching_from_fair() completes the dequeue in the immediately
+ * following sched_change_begin().
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+
+	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6bba1f3b5d4cd..56ac104f1f825 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2508,6 +2508,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

