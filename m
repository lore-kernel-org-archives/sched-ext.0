Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66C53CA94
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183942; cv=fail; b=tO7moPKUrkdCQM0QFfw51bH7oIMNADMPmaWYu59udMlksPLBTb3xvIhZbrTS1wh0P2xV/6VkujyrPFDf/yK7DMH8WiugXhYliCA7Gjq5pOxEhMYAEjzIfaD+qJdhPgJ8051BSEtIBDp3tfo9oadrOmGKJLRScOp2X4IYdY+r3+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183942; c=relaxed/simple;
	bh=XvINLbEXUA1g75cSeVAfqMLBarbOj9nEOnr5vrMUtZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=up/i6+EMZBB2SsU+1iMad8c7U26BGpywfxwDkFnpf33WXlwjII1WFddWik45QBPVG432tBSxIMFYxm9XkDxoQso5A5MK2CM5CQT+lYPYF6aomUyRjnHD658bIes5Lxx/tiMpB7GzU+lTZ7s/7UDN0fcqbUB+Gol4qN2Q/zYrnfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uE3TKyyH; arc=fail smtp.client-ip=52.101.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uE3TKyyH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOMawbJLkTsiQhoyKvpP0S61OFwmksumkKahv7ZzD82x7W9zy1QPJLpeK5+jxRf+Zxeq5eFIuNtUyTKjdBCbXC2EPCcfrORtP/WUhPcUDRfjvrl4M9T6ECKbN7rSzH3T8jlyi2KJg7o+rWEy1866Uh4Km72Pc58F8QNwBFwjt0KOS02JOkdBLnBHIWecy2Hp6TIDS8cITZqqmEFCkdX2LH5LsaVv+gWyyJTJeFDZ1oLfzBwfhCnn1grk6VHG9S58f0u4SZblTQJi+JyLhQ4on2m7FNpX8yqJHlL1+k+flxI6774soLrkNcGjxA0NFM4hma6aLyE3TUGMcStPrYx2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1x7a6mL0VRcqBw6/NZLT/YJWF8BfqkmgIBbEUBI3qA=;
 b=TuEujmkpLVBFO1GbMTOV57AVb6bGtt3CfQ5ckzG2Cjp9Q3+dd6AeLlQmOZ79k+jZR8sMhVfmrdMyKo95xJbVDO/mny/bJL9Y2AmP4wiaEODglLoauwcZZq3SNgZkLVFn8BtIV1UqpdnDM6T5ASTYn7PByqXEQ2mosRzjvHqYr1axzuxTqHigiWuqj/I30Nu82nn2F9c48XWdSB3ngSIccEnw0FZj5G4H569ngYxwvo2IsVMm18K9e0GGDyqSpwts71ZxisIlq8kB2x/+YXUHnzL1nqtVeLWfYymbXnVIGR4j3iER33ZiI4uP2rf/sDZOrNRZtCVkYLP3+w53CSkM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1x7a6mL0VRcqBw6/NZLT/YJWF8BfqkmgIBbEUBI3qA=;
 b=uE3TKyyHiv8/AIEqejLnVkpjAyN/rrEP2yvPo4niTWVnO/zCB5vtURTKUbqS4qcnWAlUe/RSvhrp4NyJY0DM92TrKRisSO1Zj0RebNfiUxR8ypPibD4fU5BvT/A7AWnaR4y7L3Cn7DK3Gg52frZvn+n2MqjXDA8kqCNa/VtBg5IOmN79FQ5FOk578EUwemRU0+o1CfRrxAMEZkhGeiOhns88MotUB2gDpQQHU4OtGiwmzDfz8r0wLWmsQ3ZcmXaOoPd+kF/NW1IGbE/qmEGxSTTCGgU97DlSZk3f64P1Vz6TdYdzTsoRweMvpN2WPdJ3AiUz+pqmtiKfW07WQZEadw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:45:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:45:31 +0000
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
Subject: [PATCH 14/18] sched_ext: Split curr|donor references properly
Date: Mon, 31 Aug 2026 15:42:24 +0200
Message-ID: <20260831134338.1531664-15-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4e2dfb-0c21-4998-b72e-08df07661fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TS1OjiB3poUYiaO/11bm8uWkCgy9a62+DqrOpHT+8mDBunGAk/wjC87UnczorauYYJkMDcVtXNw6ZoBRFB5zUNOpmjEZVeuCulOJLyV9WSbnfl86tEpDMbkl0t/6PtPqVzcjwexzrRreqN8DdRST8nwNlFqIjYA9BT9yNbfjitPGEvsIg2z/ZRMksFE8sKFZS+8Wbeq2ZLY2qxhNh4Y1Jz9V4lHLbglEDjrWyRvmj4cZHh5e2H+EVmIjuZcMGcFR82H5aAQkGPiWpF0B1+ZX9yJzCr9bRjA+r3Xu0DjOnp9owLIo9c2OfeYb3RBCN55jOHRlY61qbjE2M+LXWhDeZpScrvn5CjDX4We79EVsTV5CnI3aWvoih9mank9HNrAQUFfk1axMblq/NI23sNJUdxX0XVLZS1GeT8gSok3EWiiwQTCyJDn4S7OutgKjg2X8ldVSaoC/Pd8NtFPo56PRe2Jjdm/2Dg03mwy28npzqeGMGYGJgTrzujW61kjKwJaLkzzGtlIxbKx6QyQKIrlYdvBHjfKFi23Qlcneqqh/iPS215+sjoimN3Hxzj74I4JMuJGMtJS/F/VILS0KvQgzhLsz9K0QhMZdMIUACPYtaNde2ZnQIHZ49RfpXXtwnZoUNU1YmenfX5SzXHR8KSV3p7MB1t4zoi26OIZw9yV/FuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZXkJ3k+wDdE3sNQJkbYBLZO7npj6SB3dFkrVmpGem4ZY8NDWPRYyIIriFfN?=
 =?us-ascii?Q?OgLerhvD8KzwDN3+Emuy13Vk97PLksrqSYMsbFmBKaFjd2OHvtlfvSQbrZX0?=
 =?us-ascii?Q?mLfdEty3kUhSA4LNSAx8xk04iTnzpiCLGtO+Zq0jQbos6qUEOhEFUztrk+1v?=
 =?us-ascii?Q?Z5MQP5sfh+aTO+bhK+cx7YvJ2zc7LH8hs1jp+44dNAtyofJK+eEtOGYC/ROz?=
 =?us-ascii?Q?OQbpEncgF/96HA1S0sSel5dtaTn/5ylfPftNUivmiY6brnklwYKxoZLPOdZx?=
 =?us-ascii?Q?j0dh4mUNBfBIW5MBqvCgwWObdRHEia4ZYZX3P1GFTn+Yny9Mx8w5pDfPvdlf?=
 =?us-ascii?Q?PNSMTDLfikeg3qo0xxGTYhkl+Rqm8ktX3gd8uDkygZ/NMUQrB9AzpqO3qELf?=
 =?us-ascii?Q?F+udODU2S27/G/W+uvAca5V5YMhCCz8n8UCJnxh3zEUHvFs6C+e7OHEWm3Er?=
 =?us-ascii?Q?VNh4OozNcHJ7HtCSkH/J0g16hrA2dFTGlZmBzR6s29mHNpRAiGSHIaYBb8Uv?=
 =?us-ascii?Q?s9wTIoVTy9zvoVyMeAmCrGY6v6MYBYFyXwjnqDQwWYZySihYAcjJywQGdT6V?=
 =?us-ascii?Q?S2dx8haZ2B72BV/BT3yFqGVdeMKPpzbVX7L8g9aedm1S4dxCzYsWPIjVdYSW?=
 =?us-ascii?Q?l76w+GkFV1mJG0Ct6ohsOXFGnsjT1V9Z3Btq3+ZRzydphO34NmMIA9YYAm6p?=
 =?us-ascii?Q?5dJxw0OwQJqDOSxoKa+VGXAP90gVy0HlTRdrU5x2pg23MGYOPJmwEHuMhv1O?=
 =?us-ascii?Q?pn5WpNHHtW2DC70cYy9BrRLAYdFAOehgni1N8Gt29rbFGDznn4pfMhN7DWXe?=
 =?us-ascii?Q?w4NrTP2rZE/VLe6y8C9kQXs6REeBnX6B/GRLgS88UYw6ZUcGSl06p/RjsTCn?=
 =?us-ascii?Q?TIZ0sSlAej+I72Ku4ebMx44HeoLIyg0N/1CGmscz9sH3uGwpbkumIj4ScL+J?=
 =?us-ascii?Q?6YZltSwGcUYJjlL5QwB6r+yPYJAAeOWI0tBBo51TWDxvxzdl5UWAcfNFfts6?=
 =?us-ascii?Q?TjJGYHoeRm+V1gPHpcpOEBhFH5FYyvtJ50MEJmW/GGk/I57NWx3Qlr1y96iT?=
 =?us-ascii?Q?Dviptj9KsZCxJjFgyipmj8mAVsc3iiNrL8seA4Gt1he/TtP1V8vuf0KG1qb0?=
 =?us-ascii?Q?GtdoDzYSb/JDCRk+/7Go/phf71FHdbfIB9fqwh2H0SHbuae/0g7TUKo6kTWr?=
 =?us-ascii?Q?8I/65zoSXNExpwdcePqMp1Va2Z5Ygdjlh6dpLj6BuuHC8Wa/7NYJciOPMKPf?=
 =?us-ascii?Q?hcykKVh9aBLPatnoKrVJ/LaVjtUhSniTgTpzCu1mhVp6wBbI0QlHcr8m3u8U?=
 =?us-ascii?Q?fJ2SLsJiuo/+iZ64XepGSkCix9wvlCcTLPCTJq+La4dShNn38PcWkVJYg2pY?=
 =?us-ascii?Q?R38jtxi4o0aKU7plxbZlOfDaG28NnKV4Awwlp98lWWVkwffdNMuDXuRYOvix?=
 =?us-ascii?Q?+i3mpgWvLZratlzLUwHUMwMrRV1hXOubNNF1vWwq36uf9BD9vPN6A2j64jRH?=
 =?us-ascii?Q?6KpmRQlYNqBrb5OhjPI26e3g1zXoeqZST64MK0A+mUwwLDPt2DVBqWEKVMv3?=
 =?us-ascii?Q?f8egBG9jawgZlVhnxDG/Ks7AgAofW5HFHQOvKeSe5w+nn3eM+Ln3eErjPotJ?=
 =?us-ascii?Q?goy5r585jO37fSWxruWaHu/As8rLr4ysadB34bdTOlz4NWpvGiNV3KRLJcaf?=
 =?us-ascii?Q?CQyz29Mrs+YdsM9qOjWCiJ1B2WYMABu5YbuPONFErRB/6Yf6We45mqTVCp8o?=
 =?us-ascii?Q?5F2llm+lWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e2dfb-0c21-4998-b72e-08df07661fe1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:45:31.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6bAbisHsmC+U3chtMdS7pfHzUkTxen4tCrZsF85cXOof/70jAgOFAbC1C9VgyIUxzGLkvMhDHIJnl1b6Beivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

With proxy execution, the task selected by the scheduler and the task
physically executing can differ. A blocked mutex waiter donates its
scheduling context to the lock owner:

  D -----------------> M -------------> O ----------------> T
  [donor] blocked on [mutex] owned by [owner] preempted by [task]
     \_________________________________^
          donates scheduling context

where:

  D = blocked donor
  M = mutex
  O = mutex owner
  T = competing runnable task

During a proxy execution switch, D supplies the scheduling class,
priority, and runtime budget, while O supplies the execution context: O
is the task whose code physically executes. T is a competing runnable
task which may preempt the D/O proxy execution.

Consider FAIR and EXT tasks with sched_ext running in partial mode. FAIR
can be replaced with a higher scheduling class such as RT or deadline
without changing the class interaction described here. The possible
combinations are:

  1. D is EXT, O is EXT, T is EXT

     D can interrupt T according to BPF scheduling policy. O executes
     with D's EXT priority and runtime budget, while T waits in EXT.

  2. D is EXT, O is EXT, T is FAIR

     D is visible to the BPF scheduler, but cannot preempt T because
     EXT is below FAIR. Once T stops, BPF can dispatch D and O executes
     with D's EXT priority and runtime budget. If T becomes runnable
     again, it preempts the D/O proxy execution.

  3. D is EXT, O is FAIR, T is EXT

     This cannot represent T preempting O because EXT is below FAIR.

  4. D is EXT, O is FAIR, T is FAIR

     D cannot boost O above T because EXT is below FAIR. O and T
     continue competing under FAIR. Once O releases M, D wakes and
     resumes normal EXT scheduling.

  5. D is FAIR, O is EXT, T is EXT

     D preempts T as the higher-class scheduling context. O executes
     with D's FAIR priority and runtime budget, while T waits in EXT.
     D is not visible to the BPF scheduler.

  6. D is FAIR, O is EXT, T is FAIR

     D competes with T according to its FAIR deadline. When D is
     selected, O executes with D's FAIR priority and runtime budget.
     D is not visible to the BPF scheduler.

  7. D is FAIR, O is FAIR, T is EXT

     This cannot represent T preempting O because EXT is below FAIR.

  8. D is FAIR, O is FAIR, T is FAIR

     O, T, and D all have FAIR scheduling contexts. D remains runnable
     as a blocked proxy donor. When CFS selects D, O executes using D's
     FAIR scheduling context. When CFS selects O, O executes using its
     own FAIR context, and when CFS selects T, T executes normally. D
     is not visible to the BPF scheduler.

Thus, sched_ext policy and accounting must generally use rq->donor, the
scheduler-selected task which supplies the scheduling context, rather
than rq->curr, the task whose code physically executes. Without proxy
execution they are the same task.

On nohz_full CPUs, a blocked proxy donor must retain the scheduler tick
even when it has an infinite slice. Otherwise, a full dynticks CPU could
stop the tick while rq->curr and rq->donor differ, violating assumptions
made by the remote NOHZ tick path.

This is a conservative compromise that keeps the change local to
sched_ext, at the cost of a periodic tick while a blocked proxy donor is
selected. Allowing blocked proxy donors to run tickless would require
making the core scheduler's remote tick handling aware that rq->curr and
rq->donor can differ.

Moreover, extend scx_dump_state() to report both contexts. Each CPU
record now includes a donor= line. If an EXT donor differs from
rq->curr, also emit its detailed task record. The existing '*' marker
continues to identify rq->curr, while the donor= line identifies the
otherwise unmarked donor record.

Note that at this point in the series, CONFIG_SCHED_PROXY_EXEC still
depends on !CONFIG_SCHED_CLASS_EXT, so proxy execution and sched_ext
cannot be enabled together. The scheduling changes are therefore
preparatory. A later patch removes this restriction.

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst |  13 +++
 kernel/sched/ext/ext.c                | 128 +++++++++++++++++---------
 kernel/sched/ext/sub.c                |   5 +-
 kernel/sched/ext/sub.h                |  11 ++-
 4 files changed, 104 insertions(+), 53 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0e97fd0199940..38ffd6da516e5 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -488,6 +488,19 @@ and edge cases, to name a few examples:
   class, in which case it will exit the tick-dispatch loop even though it is runnable
   and has a non-zero slice.
 
+* Under proxy execution, sched_ext continues to observe the donor as the
+  current scheduling context. Accordingly, ``ops.running()`` and
+  ``ops.stopping()`` report when the donor's scheduling context becomes active
+  and inactive, even when the donor is blocked and a lock owner executes on its
+  behalf. The physical execution context is intentionally not reported through
+  these callbacks.
+
+  A blocked donor enters a running session only after proxy resolution finds
+  an execution context. The session remains active if only the physical
+  execution context changes while the donor remains the same. Running sessions
+  are tracked so that ``ops.running()`` and ``ops.stopping()`` remain paired
+  and are not emitted recursively.
+
 See the "Scheduling Cycle" section for a more detailed description of how
 a freshly woken up task gets on a CPU.
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 94d2e1507c54c..5f4956cf7e369 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -379,28 +379,28 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	 */
 
 	/*
-	 * If we're in the dispatch path holding rq lock, $curr may or may not
+	 * If we're in the dispatch path holding rq lock, $donor may or may not
 	 * be ready depending on whether the on-going dispatch decides to extend
-	 * $curr's slice. We say yes here and resolve it at the end of dispatch.
+	 * $donor's slice. We say yes here and resolve it at the end of dispatch.
 	 * See dispatch_one().
 	 */
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return true;
 
 	/*
-	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
+	 * %SCX_ENQ_PREEMPT clears $donor's slice if on SCX and kicks dispatch,
 	 * so allow it to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
 	if (enq_flags & SCX_ENQ_PREEMPT) {
-		struct task_struct *curr = rq->curr;
+		struct task_struct *donor = rq->donor;
 
 		/*
 		 * A protected slice refuses the preemption and the cpu stays
 		 * occupied. See rq_owned_post_enq().
 		 */
-		return curr->sched_class != &ext_sched_class ||
-			likely(!(curr->scx.flags & SCX_TASK_PROTECTED));
+		return donor->sched_class != &ext_sched_class ||
+			likely(!(donor->scx.flags & SCX_TASK_PROTECTED));
 	}
 
 	/*
@@ -1408,20 +1408,27 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 
 static void update_curr_scx(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor;
 	s64 delta_exec;
 
+	/*
+	 * update_curr_scx() is selected through rq->donor->sched_class, not
+	 * rq->curr->sched_class, so @donor is always an EXT task here. If an EXT
+	 * owner executes for a FAIR donor, FAIR's update_curr() runs instead.
+	 */
+	donor = rq->donor;
+
 	/* apply even on 0 delta_exec, callers may still act on the slice */
-	apply_task_slice_oob(rq, curr);
+	apply_task_slice_oob(rq, donor);
 
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF)
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
+	if (donor->scx.slice != SCX_SLICE_INF)
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
 
-	if (unlikely(curr == scx_rescuee(rq)))
+	if (unlikely(donor == scx_rescuee(rq)))
 		scx_rescue_charge(rq, delta_exec);
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1597,9 +1604,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0)))
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		if (likely(scx_set_task_slice(rq->donor, 0)))
 			resched_curr(rq);
 		else
 			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
@@ -2170,13 +2177,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
 	/*
-	 * Restoring a running task will be immediately followed by
-	 * set_next_task_scx() which expects the task to not be on the BPF
+	 * Restoring the current scheduling context will be immediately followed
+	 * by set_next_task_scx() which expects the task to not be on the BPF
 	 * scheduler as tasks can only start running through local DSQs. Force
 	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
 	 * IGNORE_CAPS to force entry into the local DSQ.
 	 */
-	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
+	if (unlikely(enq_flags & ENQUEUE_RESTORE) &&
+	    task_current_donor(rq, p)) {
 		sticky_cpu = cpu_of(rq);
 		enq_flags |= SCX_ENQ_IGNORE_CAPS;
 	}
@@ -2342,7 +2350,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 
 	/* see scx_task_slice_ended() for the save/restore exception */
-	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
+	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
 		scx_task_slice_ended(rq, p);
 
 	clear_direct_dispatch(p);
@@ -2903,7 +2911,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3129,6 +3138,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3160,6 +3171,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3170,7 +3182,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3191,7 +3203,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3510,7 +3523,7 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
@@ -3940,9 +3953,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3951,11 +3964,11 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(curr, 0);
+		scx_set_task_slice(donor, 0);
 	else if (SCX_HAS_OP(sch, tick))
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
@@ -4598,16 +4611,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	}
 
 	/*
-	 * The revoke that scheduled this scan may have raced the pick: curr
+	 * The revoke that scheduled this scan may have raced the pick: donor
 	 * may be a now-capless task, either one that kept running or one
 	 * promoted off the local DSQ between the ecaps sync and this scan.
 	 * Zero the slice to evict it. The enqueue gate blocks new capless
 	 * inserts, so no later pick can slip through after the scan.
 	 */
 	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
-	    rq->curr->sched_class == &ext_sched_class &&
-	    scx_task_reenq_on_cap_revoke(rq, rq->curr)) {
-		scx_set_task_slice(rq->curr, 0);
+	    rq->donor->sched_class == &ext_sched_class &&
+	    scx_task_reenq_on_cap_revoke(rq, rq->donor)) {
+		scx_set_task_slice(rq->donor, 0);
 		resched_curr(rq);
 	}
 
@@ -4840,14 +4853,18 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
+	/* The remote tick path assumes that proxy execution is not active. */
+	if (rq->curr != rq->donor)
+		return false;
+
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
 	/*
-	 * @rq->curr may still reference an outgoing EXT task after it has been
+	 * @rq->donor may still reference an outgoing EXT task after it has been
 	 * dequeued. If no EXT tasks are accounted on @rq, ignore its stale
 	 * slice state. If another task is dispatched from a DSQ,
 	 * set_next_task_scx() will update the dependency for the incoming task.
@@ -4868,7 +4885,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6354,9 +6372,9 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 
 			/*
 			 * Bypass trumps protection. Cycling clears for queued
-			 * tasks but current task needs explicit stripping.
+			 * tasks but the current donor needs explicit stripping.
 			 */
-			if (bypass && task_current(rq, p))
+			if (bypass && task_current_donor(rq, p))
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
@@ -7065,6 +7083,8 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
+	scx_dump_line(&ns, "          donor=%s[%d] class=%ps",
+		      rq->donor->comm, rq->donor->pid, rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		scx_dump_line(&ns, "  cpus_to_kick   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_kick));
@@ -7108,6 +7128,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8655,7 +8679,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8675,7 +8699,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 
 				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps)))
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
-				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
+				else if (unlikely(!scx_set_task_slice(rq->donor, 0)))
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
 			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
@@ -9658,8 +9682,10 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 		return false;
 
 	/*
-	 * Directly write only when we hold the lock of the rq @p is queued or
-	 * running on. See the write rules above.
+	 * Directly write only when we hold the lock of the rq @p is queued on or
+	 * provides the current scheduling context for. Under proxy execution,
+	 * rq->donor owns and consumes the slice while rq->curr executes on its
+	 * behalf. See the slice write rules above.
 	 *
 	 * While @p is queued on a user DSQ or in the BPF scheduler,
 	 * synchronization is the scheduler's responsibility. This write can
@@ -9673,7 +9699,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	locked_rq = scx_locked_rq();
 	if (!locked_rq ||
 	    (READ_ONCE(p->scx.runnable_cpu) != cpu_of(locked_rq) &&
-	     !task_current(locked_rq, p))) {
+	     !task_current_donor(locked_rq, p))) {
 		set_task_slice_oob(sch, p, slice);
 		return true;
 	}
@@ -10572,12 +10598,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 }
 
 /**
- * scx_bpf_task_running - Is task currently running?
+ * scx_bpf_task_running - Is task the current scheduling context?
  * @p: task of interest
+ *
+ * Under proxy execution, this reports the donor rather than the task whose
+ * code is physically executing. The physical execution context is intentionally
+ * not exposed to the BPF scheduler, which continues to observe the donor as the
+ * running scheduling context.
  */
 __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 {
-	return task_rq(p)->curr == p;
+	return rcu_access_pointer(task_rq(p)->donor) == p;
 }
 
 /**
@@ -10638,10 +10669,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
 }
 
 /**
- * scx_bpf_cpu_curr - Return remote CPU's curr task
+ * scx_bpf_cpu_curr - Return remote CPU's current scheduling context
  * @cpu: CPU of interest
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
+ * Under proxy execution, this returns the donor, which supplies the scheduling
+ * policy and runtime budget, rather than the task whose code is physically
+ * executing. The physical execution context is intentionally not exposed to
+ * the BPF scheduler.
+ *
  * Callers must hold RCU read lock (KF_RCU).
  */
 __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_aux *aux)
@@ -10657,7 +10693,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10681,7 +10717,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 7b61e3a3a11e8..8c5b64b57b24a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -285,7 +285,8 @@ void scx_rescue_charge(struct rq *rq, s64 delta_exec)
 	rq->scx.rescue.budget -= delta_exec;
 
 	/* per-cpu usage average feeds the overload victim pick */
-	pcpu = per_cpu_ptr(scx_task_sched(rq->curr)->pcpu, cpu_of(rq));
+	pcpu = per_cpu_ptr(scx_task_sched(rq->scx.rescue.curr)->pcpu,
+			   cpu_of(rq));
 	pcpu->rescue_avg = scx_rescue_decay_avg(pcpu) + delta_exec;
 
 	if (!scx_rescue_slice_remaining(rq))
@@ -557,7 +558,7 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 		scx_rescue_admit(rq, p, slice);
 		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
 						 &rq->scx.rescue.dsq, rq);
-		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		if (sched_class_above(&ext_sched_class, rq->donor->sched_class))
 			resched_curr(rq);
 	} else if (p->scx.dsq && rq->scx.rescue.budget > 2 * scx_rescue_quantum_ns) {
 		/*
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 8f2425bdb9530..24357d8c5e335 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -167,17 +167,18 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
 	return SCX_CAP_ENQ;
 }
 
-/* the cap @sch needs to preempt @rq's current task, 0 if none */
-static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq, u64 enq_flags)
+/* the cap @sch needs to preempt @rq's current scheduling context, 0 if none */
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq,
+				       u64 enq_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 
 	/* a kernel-forced placement preempts regardless of caps */
 	if (unlikely(enq_flags & SCX_ENQ_IGNORE_CAPS))
 		return 0;
 	/* a non-ext task can't be preempted by ext, own-subtree needs no cap */
-	if (curr->sched_class != &ext_sched_class ||
-	    scx_is_descendant(scx_task_sched(curr), sch))
+	if (donor->sched_class != &ext_sched_class ||
+	    scx_is_descendant(scx_task_sched(donor), sch))
 		return 0;
 	return SCX_CAP_PREEMPT;
 }
-- 
2.55.0

