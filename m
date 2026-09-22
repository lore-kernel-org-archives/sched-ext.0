Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549D572664
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096114; cv=fail; b=IqqFD57gx1ITQyxSLHzlnMltnXPa9P/92p1he7vCy3oA3HfF1iVwlOUT5zziGNrvKplJQj8leTwUBdeeWHv9+DkyXk7Khj+lLQQIXwvSjh6KAIOCQOPZDYNlyHVyhLBDTp0kEQVeloSiCQOFG3/mnGu6xhK3VGI1HSlioC4xxbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096114; c=relaxed/simple;
	bh=EhKbPu3eucIfznMVqDHPAVBgUBsZoZNLWV4at9v9c4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNRG35Wb9EWO9QzcI8mzOULBmzOyqOkMmZB71yI+RWFyRRXRcrQpUw+kXc8cGdG8meLQB8T1pjqnHBQ9voCLoLh6o+0U+rR/Flz7IREtAI7J4KdiaBLAChW22KkMe/7ZP9YasrwB1tyMe/1EAn3WubXIfgOLkCv1J9M7g/hyIzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjXXEp8A; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjXXEp8A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIZoV5SJG+Yu4LLmUodZG+TDSjWT4l3a2SQknclscqcJM3/QOq/xx3CY3XojbscSuaD1wFS+a94qsZFn5KvtFaQT/G+LW+5Sh2Lm3AD+vgsnOAP6CIq5zSS4z//hQHLRuykMIJTDvdMoxqle/5V/ziirgTpoCST+fZg9lyBcIKvrBYXvhhbtWKkNnPTTFwQhx+xP+4ypzZyrW9Y6nfeHhU/0zYqjGWccc3FWiM0Nr26oHdX9dg70AguHWcYfyY2X5uJYC/WH0Ju5dKT6wT6RgPTxLhmNkmcQ2oRLpfPE7SIv1R7H8O95oPPsIOC1Azp7YUzTLe4KZmy3VnhxFz+wKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhLZi3kHp/V2DlTCWYpafrmiD40hzBPse6gOdKaAb30=;
 b=pZjZbbWXPrmqHlm/F/r9i9tOXXsWAz0LsAJ+woojlSVwUtGvxTtQnolv9H3Azm5Fr5T9Q+fbcac+WMTvVClLMhaxgapNzradVaDpjsUtUDe5Tmc7dtHp76/SE0gFtaZf5cQ6cD7WR1CEVYUZ4UcqMoIiyWsFcrfWCcuyUuSn/H+a1OYr6KVhicogPfQl+W6JOiK98rIFGEqCRrLOvt5JXYJxGKUpB7/SDvSzQ4cgPjnNmVhATaQy0NQhaMnWZIHh7hqTAS2hb1y88y2F2YxPhkf83lmqz2xAhuJosqAie3SFmxbzIkDOV+dFkfeWf1zXdyKI+r1l0qqfufDmmsO2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhLZi3kHp/V2DlTCWYpafrmiD40hzBPse6gOdKaAb30=;
 b=tjXXEp8Axc4QBzI0zALkOWlgqmdPRw+0w2STywhcmDm1u7uaNArIaSeW3HJSAY3iQWAMox71EgE5Vet7b2AePTmiuum5AZXESJAF5Vw4wktDhaKGtKuDqkO0l3QUSeaLNch3fuvoBijMRse6qjeLqDnokjy8Pvv/iAQ6jhZvpdzEmS3+9zSmAfUdyCnZiwj1/lEo38hLDiE1QUn8oQ36B/SpM4QHEd3S75TmS+uLs3MvMkoq2hQ60swovfBpxGvCmHWhQHs7rk2rCSn3S8uNba0hqvevgyGloSRYxk/Pk54MNuM2IMmRC7Y4/WJFGTwLLioMkOv+ENhCdSaEYTuwqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:08 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:08 +0000
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
Subject: [PATCH 04/16] sched: Add helper to block retained proxy donors
Date: Tue, 22 Sep 2026 18:51:43 +0200
Message-ID: <20260922165445.943315-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0322.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: c30c5c20-398a-446b-6594-08df18ca421a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qes6OJulBy4S5aseHcaEVQplqz6pHh24+8zVKziKVu4viNjZf0oTXI0Tn/0srNIyHr16KnzsmWj1RnTj0hf8wIAtY6muOZDcHqL1eAuFNTviDHndUdNDeFOtq4M1Y0Q2bbzXr/r/D727UqNbo1C929gC+qgCrsHYqwKKxZp3xpUW0qnJOc7i3zccMITWrdgDrhIh/mu+MHAVblBNd0ssSfZYpygMOpsaS2u5rpDGVT95aPa01Z30PYyLpx7WPEZMqhNtwjn23M8KfjiMuF3t28IU1X5Gt7Gc7n3K/iip2rxBzWdhFayx37uajtmdMHqxZJ2jQlX7LVDhRMx5KwLWxL/2zkoOkH7AEVp/aJEdmT9uw2se1m1Evz/KSggOJwqI1fClUPiCwqV1ZHbVUsZhO3QEDeyYyNTNFM3cRP9IQfRlF2S5g2gv1ZLY6xXMBB5RP3tYyyegHH3gCD/z/lTriYAM/mG95LytwWPq/F56qStIImin5YeV+xWpZeWhQzqp3Gitl16kqBQ9mskRn52rIHWDxduSITUCbuheRK5a7ZFeMrPXfkoX8366PU2SugefwWUjEwaiAoE8DrskStAFUEOO/fUEXtieVJuUncjHPi6V03P5rtwLvXH6/4/5gSPtnFrkfdYb6h3b0vb7PLYLhcnvnuviu/OMQHM+LDtCG10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TkkE2l8/Etptd0zn64ULxiK6tmF1eRuNq2ttFNv+OZYYpWmFfQfqmnbg7HK?=
 =?us-ascii?Q?X+NOXFZwb2Hm1CzyAcA6qrgR5OX5/icHpbUmGwV0rnQ3rdywDdEKT80NI6FH?=
 =?us-ascii?Q?QQpEHKIG8o5iJxFL4w3K9WSni9gs9S49QSDHEXFCIXSkE2XWBae20k+IlFY6?=
 =?us-ascii?Q?0pXnOrgAvqfaiGpXgQgxs9BFBsV06M3bZhtRIRaaUFPJzUxNcTN5yshFst2M?=
 =?us-ascii?Q?VShQ9nODD7DH73hP+MHT6vhntlu9KODvKnGQEWz8kVqjZNWwtZm7pd/l+WYC?=
 =?us-ascii?Q?3XKC/N39cKB8bKsfF3A3W7llox2a88SUP73tDnappoHwToNEZWpjvgnpJWnG?=
 =?us-ascii?Q?a9YKSNgasHZx9SvtltaXbVyoJpCwGG683JNyhJY23SmWHsDeE/dcBILoz9Zc?=
 =?us-ascii?Q?4nEqpvP8aufmAxKgBCyhr5wB9NzrgMHCPJwz/Z7M2BAs80IRwJLxeGShCCWs?=
 =?us-ascii?Q?eaSI9NRYscORJw3uJrBPqGfRZUXGdteVSBVrQpo51PInOahluWnwC6hsKVwB?=
 =?us-ascii?Q?z5Oyenxk0w6goqSDbXIJfFgphFNIroarjDaMXQc32jsgatDHxohk4JjE1THv?=
 =?us-ascii?Q?yc53K6Rfh9Gky5eWnX+BVeuZIObSr88va17qyr/d6cubc+lM0cbAozQfVWBB?=
 =?us-ascii?Q?8CBQOO824ZKJSGQVGSBGpygfNCf77/Aw8tfnbq5EHJqbv4I7joFYTie/IRR2?=
 =?us-ascii?Q?M8cm1ox+JANVD5MqIdu74wJLymtw+kk2uqszavAkTt6nattZpcJtkr1WoUgO?=
 =?us-ascii?Q?/9K+AKHVVYw+blbB7Eo1d7TpJFj1Gn3oygUwyAlwW2iMYlOj7CFjlKn/667X?=
 =?us-ascii?Q?82T1ikFH7oyTZROKMrMZGQDv5y3u33q6dDXduoLcHoN8x+Z4a32osDzXXHUR?=
 =?us-ascii?Q?OgViDQSyuqVIvtR+vFSJzsBaL6OHYd6NYqau5szyok1ovC6CatejFvm7DNtX?=
 =?us-ascii?Q?zHh53Ccj8byq6UQ0JZd1Bj+GJMIdPnF8h+kbmn8C7MPUmZqD5IfJ15jvV1ad?=
 =?us-ascii?Q?cUlQ2Nx2PYuRvfxWMfjZJFqXae04TVe5YbDz44K0g8cqNGuFkQTF4IF+aiRl?=
 =?us-ascii?Q?siwc0FoKI171X1BeIq/yIKTk12BF5kEdNPaXdC0QYDtU6WrxGJN5KNewWg+6?=
 =?us-ascii?Q?PVmgu0+PZbvSGgrSAD1PnTKkPDEckHWw/p7JqfkVOlMK6xl0sggKzRQoH5tB?=
 =?us-ascii?Q?Judttx/ZXvh4JTimqS7VOvLUaKOohaXvsH1XLC9JIimRA1QhaMO68nNxgPJx?=
 =?us-ascii?Q?kPqjgRE9CiiePz4SqG88HeVqMSAcq67D/u36RSKFE4M7LYflSrbk+YjKyyIN?=
 =?us-ascii?Q?QJzDsrR/2PbjFBKiHmwL1b96o04X7ogG0FDSmUf4SjrGsAO0i5DG35Smeux3?=
 =?us-ascii?Q?s+nIHHOXlJivpEoXUKfpzJsHaB2Cc/ypWZS0hcaDTKXLIfA1gm8uR1kK+Xn8?=
 =?us-ascii?Q?ju22GLPLqMxQdU6OzqYhlm5ymNcppVkXK7Z+9TCFQkSguZF1gTc7XiVMvD2w?=
 =?us-ascii?Q?UcDGUGP0yMbExuybJKsvvVq29fAubRxeSgoxKZRjOZ+0vqLAhrVbGHVfua0V?=
 =?us-ascii?Q?JxMYFOt2+lHww61GveL3veQ/ppBPzr5rCoLTkDGehjrMx4gn6uk2XGni4qSa?=
 =?us-ascii?Q?vvt6/trGwnrf46xVg3aJdxGkr6E3xtzI3X49DRxDe/eT0WuUfNMTFD8aqO6D?=
 =?us-ascii?Q?onI7ZKsyhNa5bSdrVxLnsXK3w1zXQ3YwBSoU1Lju/HmM0vVz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30c5c20-398a-446b-6594-08df18ca421a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:08.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVAzBR+qcSCRcecsSzdxxElPb793NCSj2GSPGb+H6NUeRYlOoRWyXHKO3HzRQ1o4hBz73qpFF6z1sNsLqPCpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

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
index 124f0a5220869..2bf1bd5d6a98b 100644
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
index 6801d8e5c1480..a096f23f4fbd0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2492,6 +2492,12 @@ static inline bool task_is_blocked(struct task_struct *p)
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

