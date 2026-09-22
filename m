Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2C56E056
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096153; cv=fail; b=PtS66odiW7g0c3rD6vBZ9LFd9pu4DHe5kGh6uCqc1gk26h3rVcI0coxd4g5IXixInNMnQFXiCdN8ebzfF0VjF93NrIBCy1/NUiiDjT+tM2chwdYKxFNKaQIdAsSKdEnx3FzIKY8TuP2Z+wHhgd0FmY3H12E6LXC8pcej8XS9Yeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096153; c=relaxed/simple;
	bh=axw/y4wMIdwk/q20SYMP45wmUJMEMn4/+2zFiJ/0LoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cf8zSe/y/VSF04SiedaDobuZYMIAZrJofw7kStVsvQMdtJfxzow7sHv5T5QAp/Oezd0aVsU8LTjKuCuu2G1w/XfZwQWG1uLi6rKI2xh0VJJfLCmsq58Pa6QsyQPzCfrl59ybRZFaA2o6gqEb+9bym5b6hC4FQsz964ACpZCZPGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoMysIPL; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoMysIPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUASUs97A5vzRRqoJPcxVm2tesVg+6Rp6rsxpwTMAPLElHeueIgtLgtq3FlZjtA9oEDQ54Xz3l02yrFxDR5QCPdJhtp6HFTWMJWW/WimgwgiTHzIErEXI3DaoNklkHchbuPCIN2c23/7LoqswWsBjl5Io/n1UYvKEB+HQwki8XFPrCYPg+C8COq+QBNLfnRnbLviDjPBEiLNV2ZNt6QVtY/7vrXXDa62+bS46NQBqLRaaQ6fD18BAxmUhzZPkB8c1TBe9x03RDPX6J7iFQnzNq0kk0K5Cv8tytN8zWATsLa7Ah8RjLjFba2gFi4nXfvwUjCusXGVXF7z+5X1U0dCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05zADi9aV2yU5MUMlvlk+jHIqTozoKHDxGXGBBzK5Sc=;
 b=eBRYk1PxCCGOAAtMWx/rFp6CKinGcCLjxHI4J6WPjte59mx4Nbavre566lzFPiIZVL22MMUYP0gOv3zhZUKB2oqnDMTfpVFik/h74fYhzyTqzpUxHIVlGaHr5At48PZyl5EfOfWGWFmRffTuzeoXtvMw3jEkIQOXVSnfZpmRIp0Via1jgHs+jZEE1y7ggwLrZFt/yPbUd6cyQdB6A15FIr8EYo93m1xE13syj63ProG7EzSZyON4esQO7a5UyV+/ARZta9VXwgKHfyzG9FUbRR6KGWZT35DTXWyn8TUj1QehXCyKg/6aoW7sxUG1mVPJWiwKF4X31O2UEUgtF+gmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05zADi9aV2yU5MUMlvlk+jHIqTozoKHDxGXGBBzK5Sc=;
 b=uoMysIPLAnnKnJDts1FeIXsvfvDc0RyZyaBaIHKwz91jre51zDZsPlQgAO8SgiMtyWOUUwerGl8dJS7L25XtDrLtj8dlv//nbMe2DTzwzXpV2hsN5yaRcPr5VjqKpSJ4ackEpC82xRLJ5u02k/p0yVa9LhROc7mLjDf5tDBn7kOgp4fWjpvrhHTj5CB1BL0x9GsqbJczH/twH3RtBSE2n68NGG0UVJ+tSQhJLF7mwd4zRQYqana2TjzkL0L9m68w8NHiU4oKrwgyh5u3SZ1P+OJfTJCQiuC6BDWyjC4RmzOEx2UZtHJh8CECK1fkCPoKH+RZoZk6Pp7NVkchcaDwug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:37 +0000
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
Subject: [PATCH 11/16] sched_ext: Split curr|donor references properly
Date: Tue, 22 Sep 2026 18:51:50 +0200
Message-ID: <20260922165445.943315-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2819a4-c0b6-4129-7e8c-08df18ca5398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	IzCQ41N/eBtFuE8+4dUF5h41kXhwsXZQxJJik67bp4xk9eRd3Ql5mCUDUaQQEDrtuiR5vvB5Zq4thtqB7ceaFh6GUzzc8DaRCsmePdoAlxcejqEBU9E3nGeUG9M3GLaiXzwCFIrdt7aAu9VhIspXMtiayuF6O8VAGAsBHphUhXbCvo2uVS8TuDhocwOc8SfED0uKKk/FtDbfaVTBvXkI0XsY2jLEW1foiSmONlXtFg0UWlt4usO95UKCplOJjle4zS3fmftLhoSCO1ZQCliEIigOJqf0CYzMST80sN9VmdQZbLR2J/r/2bAJiz4G8mot9nErv7qdDiex7OGCIPdDNLaJdbzlRBY5BaGZ2+/mg469lqnUEKrL+1zF6n6WeLIUPy9NXQCr2y2Zwi2UP5BwPEA2CJjMLFe0ZmOsHHuQq2lu9uWW74XxgDg4aMhsq9aLB77irSJhNEKBi/CuPu5QHaxmtwqzjW+oAkmVZlXKET7BnxuDawoDaZVfXZq94H7wyqtadPXDdx+L+fYSuRwBOYmYvnJxopRnfVAZ6/OnwlHc1gBsUErbUtnEy47hAMJ5vUiZabRyGCsVP7HYb4ZYN1TjzeiKcBQKLUpnv9HgLK3Bz4N8vFharJn25TxKWlh/rfLKwxRDN5/csRRGBJ1dpgmzO0ZHWeT5KBP6G6Aefes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0yAmvrs/ZIkNdJVosKl/WfTaKA+QC/nXLlMF8cPXd7AmxvdvhnLcq20u1YZ9?=
 =?us-ascii?Q?m0nsEs61paEhdbAeSGjSB6BVBwbgzOaa2vAl2eV+bZKTv9QM1A9pavZnaQtA?=
 =?us-ascii?Q?kzZdWrXrXIk4Pat7Sa3shlxZ7gDGa1EKXH0YErSnKV8iD78HEdKBHr5w0kv6?=
 =?us-ascii?Q?bYIpP8j/uGP0tvtHkVjrlOzBXag/mKZk1ql38Ip4i6YAQAbrv1CIm7ny1wLL?=
 =?us-ascii?Q?eTE1i3c7rDxt6SW93VT1zBLElkQZDMr9xzYyCexQ2IIiryBPYlcviBa149v6?=
 =?us-ascii?Q?7uEWXXWr3jbSBIOYYd6B9i8SxJFBEY+SKQ1rZ4MglbgmJvcgZIpbwAv70Nzu?=
 =?us-ascii?Q?q5F16VDUmMkxM3GetkUQQ4ZMONKmLwi7QYOqVzkd69Mzvlz0KBQ+WqZfqfq3?=
 =?us-ascii?Q?Dk08a5CgwXrHZdqIg+CjYC1ZXJPSNrl1n/LSse0cPqmDdcG2NpORRzeyCqrg?=
 =?us-ascii?Q?bJvy5Zf7VaZsitaZyldFQR+oiLulykHIjq3i83xAbkT2HOMCZj7MfkEdc33Z?=
 =?us-ascii?Q?34bRrE//kQaxusUqAUagUWP/yCbxhuYZSCLkxZS9FSlWAA0YDz96T34xEf6o?=
 =?us-ascii?Q?XdL5PlFAQHc3Lv8hMbNHubPI2QjXwIt0Uau9VDxt06njtCjKF/mWgYK+30z0?=
 =?us-ascii?Q?fiqL24aUGSVN9DMdn0tQR9NcxOtC4yca3e1LTE1Kyd0vMcwG+ayuqchxNBvK?=
 =?us-ascii?Q?IZ/ROkps0Q2PAomGgGWrw/utYjbAbmSgu9WdcGo5Rk+oxMNhW7M8C2Ik1avu?=
 =?us-ascii?Q?+4ubi5cDYMlDcwijnj/k+ZEyDmoYknZ15e1g9AWGARzv4+W4QK+WEZNwRck3?=
 =?us-ascii?Q?A3PHBoLlePv/TEWTGvaDINf80yy5mW2PqV7Ubh6FOk5o+sjEuPyXPaB7thvw?=
 =?us-ascii?Q?4h7rwsOxHr/BGqsNKycNEV9USrKE/SZ54b2UH8pmRMM+bV2iYWRStX9V0ts+?=
 =?us-ascii?Q?qoK9Xf2H35kUz9u/omijrAjc0aXwwIfUpQSYlJRfGqG4gGB6mSgtxej5dhbW?=
 =?us-ascii?Q?aHzQmm6VpEAPPjEDDsTGPlrKoto2nKdsgp1af39s/Km8TRAfmMpKQtQ9n2Q8?=
 =?us-ascii?Q?gRbDV5bak6b8jLGZ58MsWnJAhfjR5/x6DeEwaOLrj0lVnEkpJtDCmjwvtNpt?=
 =?us-ascii?Q?Q2+hmhbPj5lfethOJxmxiFFH637WY0fKhWpRciJj95jVZxOTRi475wytKSpB?=
 =?us-ascii?Q?SNV3Vj4vU07Nla3ew6P0zf72Uw6Imu70jrcfKR7mwaLwYKneqlA+caLVtYpP?=
 =?us-ascii?Q?ODOGLIPf39PxsfNu1myYlciat5NmuEQ7MKowS0D1bVelzBIRI2fAqNWu6neg?=
 =?us-ascii?Q?q45IT4TjbAJKpXIKS4DvX8OcDJzWsVIzLvnCG5y11KHwC08g8YK2OS9lENWS?=
 =?us-ascii?Q?3ofzsj3xtD7/yEB7KMH174mkDtWJ1Rc4uCYMZE8gtLliFWKlBH3IwCjyUeTG?=
 =?us-ascii?Q?+enY5RTxV2IwL6uLoF3Wjk6Wr51PYGzJWJyDDNoDdNklZuL2xfkLyB9HHJSN?=
 =?us-ascii?Q?nKkNdCeMmZ0UM/HntNZikuzKu+L41/jTb2Sz3rj5YVcRohhg7xSRvHxZH7qT?=
 =?us-ascii?Q?n7Xkp2LvtQSaoRRNno8/h9/X/uRp9rQTBQgrKLBqyER556MhSm7UtKZqh500?=
 =?us-ascii?Q?jVf1q6OPrx4+Vo0ZPxJ7j/7oO+jbuM7BVZ8+3Bm3Hw0W6G/dPFX+/RpiGpP1?=
 =?us-ascii?Q?PYxMUqH4wWtza/9gVxscHPJAwam7hhaeLGxy8Xibcw9X7ByEJWpyTHKl6NPT?=
 =?us-ascii?Q?qNXQN5o4Kw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2819a4-c0b6-4129-7e8c-08df18ca5398
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:37.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tUOTq4IXP4J1+aR15S2IIdhJG1DoaJDtxbEXc/Zoqs+gXLg6jhQlmxqgcEar8aNuPQw7derPtF+XUbHjEXDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

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
without changing the class interaction described here.

An active proxy pair can only have a donor in the same scheduling class
as the owner or in a higher-priority class. If the owner belongs to a
higher-priority class, pick_next_task() selects the owner directly
before considering the donor, so find_proxy_task() is not entered for
that donor. The blocked-on relationship may still exist, but it does
not result in proxy execution.

The relevant combinations are:

  1. D is EXT, O is EXT, T is EXT

     D can interrupt T according to BPF scheduling policy. O executes
     with D's EXT priority and runtime budget, while T waits in EXT.

  2. D is EXT, O is EXT, T is FAIR

     D is visible to the BPF scheduler, but cannot preempt T because
     EXT is below FAIR. Once T stops, BPF can dispatch D and O executes
     with D's EXT priority and runtime budget. If T becomes runnable
     again, it preempts the D/O proxy execution.

  3. D is FAIR, O is EXT, T is EXT

     D preempts T as the higher-class scheduling context. O executes
     with D's FAIR priority and runtime budget, while T waits in EXT.
     D is not visible to the BPF scheduler.

  4. D is FAIR, O is EXT, T is FAIR

     D competes with T according to its FAIR deadline. When D is
     selected, O executes with D's FAIR priority and runtime budget.
     D is not visible to the BPF scheduler.

  5. D is FAIR, O is FAIR, T is EXT

     The D/O proxy execution has a FAIR scheduling context, so T cannot
     preempt it from the lower EXT class.

  6. D is FAIR, O is FAIR, T is FAIR

     O, T, and D all have FAIR scheduling contexts. D remains runnable
     as a blocked proxy donor. When CFS selects D, O executes using D's
     FAIR scheduling context. When CFS selects O, O executes using its
     own FAIR context, and when CFS selects T, T executes normally. D
     is not visible to the BPF scheduler.

Thus, sched_ext policy and accounting must generally use rq->donor, the
scheduler-selected task which supplies the scheduling context, rather
than rq->curr, the task whose code physically executes. Without proxy
execution they are the same task.

On nohz_full CPUs, keep the tick running whenever the selected donor is
blocked. A selected blocked donor is necessarily awaiting proxy
execution, so this avoids relying on the transient relationship between
rq->curr and rq->donor during context switches. It also leaves ordinary
sched_ext context switches and non-nohz_full CPUs untouched. Allowing
proxy execution to run tickless remains a future improvement.

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
 kernel/sched/ext/ext.c                | 133 ++++++++++++++++----------
 kernel/sched/ext/sub.c                |   5 +-
 kernel/sched/ext/sub.h                |  11 ++-
 4 files changed, 107 insertions(+), 55 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 794ae80b3ba30..13ba2cb7831c6 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -503,6 +503,19 @@ and edge cases, to name a few examples:
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
index ea930d10cb383..1f4016c04d527 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -425,28 +425,28 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
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
-	 * The preemption flags clear $curr's slice if on SCX and kick dispatch,
-	 * so allow them to avoid spuriously triggering reenq on a combined
+	 * The preemption flags clear $donor's slice if on SCX and kick dispatch,
+	 * so allow it to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
 	if (enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
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
@@ -1454,20 +1454,27 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 
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
@@ -1663,9 +1670,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return;
 
-	if ((enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0))) {
+	if ((enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) &&
+	    p != rq->donor && rq->donor->sched_class == &ext_sched_class) {
+		if (likely(scx_set_task_slice(rq->donor, 0))) {
 			if (enq_flags & SCX_ENQ_PREEMPT)
 				resched_curr(rq);
 			else
@@ -2257,13 +2264,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2429,7 +2437,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 
 	/* see scx_task_slice_ended() for the save/restore exception */
-	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
+	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
 		scx_task_slice_ended(rq, p);
 
 	clear_direct_dispatch(p);
@@ -2990,7 +2998,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3218,6 +3227,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3249,6 +3260,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3259,7 +3271,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3280,7 +3292,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3599,7 +3612,7 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
@@ -4029,9 +4042,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -4040,13 +4053,14 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(curr, 0);
+		scx_set_task_slice(donor, 0);
 	else if (SCX_HAS_OP(sch, tick))
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
-	if (!curr->scx.slice) {
+	if (!donor->scx.slice) {
 		/* the slice can't be trusted while bypassing */
-		if (READ_ONCE(curr->scx.lazy_resched) && !scx_bypassing(sch, cpu_of(rq)))
+		if (READ_ONCE(donor->scx.lazy_resched) &&
+		    !scx_bypassing(sch, cpu_of(rq)))
 			scx_resched_curr_lazy(rq);
 		else
 			resched_curr(rq);
@@ -4707,16 +4721,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -4949,14 +4963,18 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
+	/* Keep the tick running while a blocked proxy donor is selected. */
+	if (p->is_blocked)
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
@@ -4977,7 +4995,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6473,9 +6492,9 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 
 			/*
 			 * Bypass trumps protection. Cycling clears for queued
-			 * tasks but current task needs explicit stripping.
+			 * tasks but the current donor needs explicit stripping.
 			 */
-			if (bypass && task_current(rq, p))
+			if (bypass && task_current_donor(rq, p))
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
@@ -7183,6 +7202,8 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
+	scx_dump_line(&ns, "          donor=%s[%d] class=%ps",
+		      rq->donor->comm, rq->donor->pid, rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		scx_dump_line(&ns, "  cpus_to_kick   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_kick));
@@ -7229,6 +7250,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8784,7 +8809,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	bool preempt, preempt_lazy, wait, immediate;
 
 	rq_lock_irqsave(rq, &rf);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 	preempt = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt);
 	preempt_lazy = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 	wait = cpumask_test_cpu(cpu, pcpu->cpus_to_wait);
@@ -8815,7 +8840,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
 					/* degrade to a plain, immediate kick */
 					immediate = true;
-				} else if (unlikely(!scx_set_task_slice(rq->curr, 0))) {
+				} else if (unlikely(!scx_set_task_slice(rq->donor, 0))) {
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
 				}
 			}
@@ -9811,8 +9836,10 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
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
@@ -9826,7 +9853,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	locked_rq = scx_locked_rq();
 	if (!locked_rq ||
 	    (READ_ONCE(p->scx.runnable_cpu) != cpu_of(locked_rq) &&
-	     !task_current(locked_rq, p))) {
+	     !task_current_donor(locked_rq, p))) {
 		set_task_slice_oob(sch, p, slice);
 		return true;
 	}
@@ -10783,12 +10810,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
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
@@ -10849,10 +10881,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
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
@@ -10868,7 +10905,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10892,7 +10929,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 9e46392023774..da8653cf9502d 100644
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

