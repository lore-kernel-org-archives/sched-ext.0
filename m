Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCB3F1ABF
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098977; cv=fail; b=fx2Vu4d6iOsui+70RQx/SNHpggc5R2QHByiXJNxlSmB4s6RombOlT1qdEIlaFoR519bmdDulMroSmxw0yoDD4v/FsZlwIaRMAgeI8Mw2R0umVBnq0KsxvL/5DBtznsPNdCdioUCXxgWI34fVp6VsUxqbGUdrztz4LuFCI5JNM9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098977; c=relaxed/simple;
	bh=j+/jyLN4rZgfzxYGPUxST+j6Uf58U8TrB884afUWMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDclXEb9rixOG13CaLPeR6VHkfoAknZ6zC8tCv824+LBnJ8FXGwEFV4Ek59ZbEEtW0ocoJJEOouc8role12a2+EDuv/sXG47NShFbg39nIX2DWimToTJ7uHkNTdUVtldd5mXRG3EirwFQvDWXkpDeHLNKaGexgMgTdHd/55s168=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nyo66uzh; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nyo66uzh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEhBfHIZMsS9+Qnj7STq8lRLHx33AlNvanVax3GDmYQwEUGNGp6IUdwWM9TqoMdR+OU11M/+SZN3Bu7aPyZONc9l0HnlrRclNBw1oJ4MCJ+2YwjfSE9B65Gj/if+R19rSkVuCo9HT7F3tvYM9lm7z1+LEfxADD/m1DriJZlQB2DWsE/72pe5Ado3fRBRjrvOMSgU4D2HZuJKJpZnvJe0/kDmrcKFQLPiR4R5N1tyS/Y2Cz5rkZML5eOgN+cjvCMTYc5kPx/xHYaMAb8vi+SjS8SYjH2XpUdyFd8wachCm8hun6gHqU/DdYjiV0kTz3pO4RhKoTIn1r0clTRQZoQPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPe9j5WRrQ1T5UT3o9xGxvPkv9VvrYdhJcq0ckmxN24=;
 b=iE8/41ek/od9x73AvYjjeh4Rcf23UbyldPR3yOR6zlQkzizrP3Y+/Mj58C2/XfEI9YCwZLdN38wBlSpDBAeYKYLd/9lwVJ3CJUmbztPMTOOmkkSwSDLmitWdwoiw9RbIbvQxOJRcNtgL5C2xEVKgGrcId7YhWrWxG9K8QVMz3NbfaZ19Qh0wubQ3vN66D7zNkN3o+gT5JkbOJh7w+gbJXuhzaYdKculos2tynjTIp75M5oBEIEAczhbEwUlV3erQf0HsiYpkB7mdFoUMxJDxtOgOoUpYErb1xaKfYsXlbRq9Ozohvq5HGiHBmbsSABmSBJ9UVMxe6KPY3FBaUKlbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPe9j5WRrQ1T5UT3o9xGxvPkv9VvrYdhJcq0ckmxN24=;
 b=Nyo66uzh31XC6kHCzFuE8wPeXKA3ghNf3PEwfJBB0AZ4xtUeVDEPV5mW13wEk1/zdYzoAfblieqqlfh06J0BLlSt3N9Bd9ZBjOwlQ1F/JSf0B4C3FSBuPaDrdPubAHMQstiDLvKflGGDndP0mZBU2hJJDM7Rlkz33NMOra6pQK6n9h4SbHKWMT6pRpRoqeI+9eQgVwuZpH80maheuE+pSg7amFLRX4s/t3+HdSu00bMA0PeWtMQ9UYbDCtuXyI0mNL9a87Lq5KLuobRmzuoCe42NFlmcGU5q/QGNOpI6JK/ucz9xK6Apvv5ZZQUwfAz2oiq2wWfxPS+UIzLCF3mVZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:16 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:16 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] sched/numa: Let other scheduling classes drive NUMA scanning
Date: Sun,  4 Oct 2026 09:27:07 +0200
Message-ID: <20261004072901.3579967-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::26) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea7026c-012d-4bac-4607-08df21e9303e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	sfXzy6ktch9MrV1V9+Ms61j+UdcAHHHli1lyBIYd3Di83f7ZWGJCOqfao7ek1qXfMn3KlF7zZBtNsg8poluomhINBy4DXQXvCAeHzyYgcjAkDPKW722RnQzaAzifhA1tu9Fs46up5sxf0whK9cXPGB6HDtcQA2e2/7xoDYzzgPpUr6tKLW54YSQYjcmre+X4xAkA3QGJeW80sE8esRN3hB1vgljESKZ0dbNuKogxcM/bWMdNBYHL22VZ0xEZ76QEgx1uJTXhtwuTAoUUW23cr2WFzEl9OzKq+wEvhaUSPdkiLkBNM2VlakhyoXYmEUNNoVzcixD6nIpXlWO5Qi2AJmEkXDI1iBArU7XkZvApkM22aGxqbe7NEc9hs5hRsef/SMXfpHlsAPZghZlWH/ID7R79odB4TJgSXcTaidBo4JxfwleUNaLj9zw0uo7MqNFZ/JHBK733m5t/gWeO6KuHnD2AL/9P8ys50UK0W7i6t/Puenskhp4IBk+6wsKVmZf6KhX3Eb+3qXqzuxS/Y7oyuhD2QaorYfvbWvOmQ1NKMFj2oBBR76RMZtLX9lKi7b5uTwBipGsXNJsdSA3Ce8nVBwi003ZIAiUrY8bfO2eUcCjnqZwwSF85JT7tq9jTegeepLhv8ZGaF/9epohx1Pjsi9qtGNliSf8cJfJmeJiq92Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHJmDoToiZKTaf2VYEqFeEDjjeA5tvmhD4O8dUbeV9gW2rAKYf1/K7Pek47i?=
 =?us-ascii?Q?SSV4rAu/BLAo9d0bdtZkkpiSqoDbto38cJDK51mgRZONXUfgOh/7qDwtkH2i?=
 =?us-ascii?Q?y9NLfTsQl9LnO29Y1csOo7wriUbaevoq4gySNXJpURBOtZzzUNQIiY+0FifL?=
 =?us-ascii?Q?CbZU4wTDc6yEAK0gl68i+0KNt/kOeYulHTNbPoUywHsw/syJPUxxL6hcV2O2?=
 =?us-ascii?Q?72+gAFVIOOwUbe++r80vlnnTc5Fo4vwcmHbqAkSiELhTM8L2iXiPEpUv4XhN?=
 =?us-ascii?Q?6VEDwalC6u2VTw8zDBSs8Def4Slxl7DADxB+jVQ3IumLjlB0ce0Bpkn0F57x?=
 =?us-ascii?Q?iV3jkWkhorcXX6s9zASRfLoS5SLKj2mkzL/Mm3KmY2x8v3i2rvunsqI17yO+?=
 =?us-ascii?Q?3Is7xDxtsCue0m54l1Uq/0lKbqyxcMgoeujXtf1LbXEDKkgMbP8m9tHEPvkw?=
 =?us-ascii?Q?qQGpN5I8P8NmdytDFIjbATvZFidfqNsjy5djjuFtHpYDtx19ShaMSiHWMr1p?=
 =?us-ascii?Q?Ljr2s6NlkjBF8UPomJh712UKU53WNKilqxhdn0WgNmaJqBQRozXYQO+9KFes?=
 =?us-ascii?Q?Us/dmizmSv+Md2xkcbUldVeBI9d64fQD9SEDaJGz8lYlT7DInh0iESSpPQL0?=
 =?us-ascii?Q?XmTPwPTGy38RiUTEuz0ZbjvNZIvOJgti2GIgVzqbUencijzLjcXfTnQ95cpa?=
 =?us-ascii?Q?R7ihXpCzHXKZ9rb6mNC4B1Y/MXDRhi7pZ1O9aUD5mgLZb9x7O1lzrD8/shlm?=
 =?us-ascii?Q?Hj3jk1RxDQbG07hF9LPzn0ltBfY6ldVrkmpBB8rVZug6NzxospyyMK+qVHIz?=
 =?us-ascii?Q?FLbkHIo+KuOiuGYpafnFjyLFm/slwGRVJA91I34ewTCtCKQoJpHw/rQeGgzn?=
 =?us-ascii?Q?qEynMx1f1XbqFBtCOg+f8JgSvYXNliA+Ru9Iz/SQ1zmK/kurHlm/ZUHgCu5G?=
 =?us-ascii?Q?3vY55S1T5FjY7EUfQKXyAs+7Dy9UmT6BLAhf/5GJICtTD0qq7RXiFs33ChCQ?=
 =?us-ascii?Q?4uuV67QQUEB3kszw65Zo2N/YleS+57vkeY8hTwiEpt3wp2WXHIznpw9EHIQw?=
 =?us-ascii?Q?ckm3Ae82ghMcug9HIDQ2fyTptOrUB+T4/UlyaDTm4PzsSuWJDSeJLClLZsgs?=
 =?us-ascii?Q?vAd6/gensVreRV2KETvmB6vIUWkovGm7cZvavvkOHYBUf9RZfjF7lTujw2wd?=
 =?us-ascii?Q?Wa940BeMikF4CFI+8SEH5fbaNB5ojrGXnEZlhVdcVLDLcobj8F/x4hAClH+M?=
 =?us-ascii?Q?F52AmGQ3vhWl2YaHzWfWTfRKqtSOTkSgpYQingFnzEAI3BrUyIDhhaTwYVk2?=
 =?us-ascii?Q?hO55O3/oohP+S9Q8U6mpJLliAIXEM6FFH+ntoJIzCVwyP/YS/5IJ8V3GrFY3?=
 =?us-ascii?Q?7IhO8iIoLpBEB5vfx/m9GUUc8c6e+fp8YER6y1wfSjstYmr3AA2stI5x3RYt?=
 =?us-ascii?Q?7nygrZdoQnm1xAZJ0Li9jv+XRHRaGEiJNAU7/7Cy4y4Bolxd/STGe75E0SKU?=
 =?us-ascii?Q?JDMOrmaZUgs8B944ysRDt1NmS0c0Hrs0igKGq2gjJje5R/sLpdhc7473cCBY?=
 =?us-ascii?Q?QHvpt++vWVqeE6RFReusoKcVjcW1rv5C5ySXFgorfOwmIdXN/wqokgLkZ01z?=
 =?us-ascii?Q?cWageQ96pa9qe53qZIgsGlIscxeKpXBAVjgvmmgRbPjO7yn1JBp4ItLVUbUF?=
 =?us-ascii?Q?JP338HGt8DTQktLoaPfBoevfxpwObxrfkkLL4bhoF3JoUVmiYj+hPN+URTDu?=
 =?us-ascii?Q?Ock9OlM4Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea7026c-012d-4bac-4607-08df21e9303e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:16.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k4bs00XIB+cwtQCru1qB1h1dqrJH2a55HCZ5aLV8t3/SkuJoFVKXZ2SRXrZNIg1ksitguRtIkjMn7E2aZcA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

The periodic scan that installs the NUMA hinting faults is driven by
task_tick_numa(), which is reachable only from task_tick_fair(). What
the scan feeds is class independent, but a task that is not in the fair
class is never scanned, records no faults and never gets a preferred
node.

Make task_tick_numa() available to the other scheduling classes (e.g.,
sched_ext). Declare it in sched.h and move the !CONFIG_NUMA_BALANCING
stub there, so a class that has no interest in NUMA balancing keeps
costing nothing.

No functional change: task_tick_fair() remains the only caller.

Reported-by: Vladimir Vdovin <deliran@verdict.gg>
Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/fair.c  | 6 +-----
 kernel/sched/sched.h | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03206e15e6fe4..e2d52faacdb7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4431,7 +4431,7 @@ void init_numa_balancing(u64 clone_flags, struct task_struct *p)
 /*
  * Drive the periodic memory faults..
  */
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
+void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
@@ -4497,10 +4497,6 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
-{
-}
-
 static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0a34f0da1ec36..30232341db9de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2137,6 +2137,7 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(u64 clone_flags, struct task_struct *p);
+extern void task_tick_numa(struct rq *rq, struct task_struct *curr);
 
 #else /* !CONFIG_NUMA_BALANCING: */
 
@@ -2145,6 +2146,10 @@ init_numa_balancing(u64 clone_flags, struct task_struct *p)
 {
 }
 
+static inline void task_tick_numa(struct rq *rq, struct task_struct *curr)
+{
+}
+
 #endif /* !CONFIG_NUMA_BALANCING */
 
 int task_llc(const struct task_struct *p);
-- 
2.55.0

