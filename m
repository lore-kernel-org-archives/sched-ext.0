Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5783AEF56
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672796; cv=fail; b=Qmb5uf6OcJn749DDB5gcTgQBs4jtOOXsYDCp9knpxu6DrVhGiYfu8Jt4zbntmaQQ8zA02x7JqwKYcfVVVAqi6GWDD769AvDvZnblea+g7CW2AMNu994GHnQM/A6PPBAZFi9aD+MRGPvuJV7erlaI+xXJMG9St6rZLCMHwV7AGYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672796; c=relaxed/simple;
	bh=yptuKcVvkvKB6ZSsmp12Uw2SXp9XVz7VkZnvEl7nc0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajDH61FE81KmnpowbBv/iA0XQr+MazDjGbjv5QaCKFOeFd4s28ba8YeEd2X0szTVqqlkWW5yft09XHPk7h+3XUmHGfq/nrHlkZwk3CRQPnXO29d2QOvusECp/qYz9fxjon2ld5WefVMar3QHpmMgKHPcVNCkw6qoXDDfI/fyeb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAv30mbG; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAv30mbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r24GjjgkEcIzZ5cWR58N3Us5Kkkviq6I77kdLfcdqj8mbOHecoPQL3QTTVaHfeNTJycsD4N3kZlj8eFJOx2HXn18WfjoRju4pHLYwrYwHtEuKnbkL1/T7qvrs4ub0zyJzPD9spe/tJJNwfFYzKpJyaAELb6HpP4TSQ5CSznWgaGmchGFOOMYug7UXNbIi3wu54CG3jx5dQAY03sHQO907O53Nl+SKfVPcKDry0ySAwRrQgc0ukP3n893B5mp998f3KRywK/Kupf+K/SxLbSl4pQSNdioxc7MruZcmxmVeEVSiXh7FKdTMk3OBKHu0bJYDSlxLxpQRW9ZF9bz32OowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH5iUGaGFfdmhZelIGaM042YMLSqA8Iit5srIKY9waY=;
 b=M14S/GpImRaC0iNyZCl4CffkIr8RZLbzwooPVWzFBNZxYyOeOTabTJUancjs5gYdkjTmaIBWlGGflCWH0KUaho1KqcyF7QjxXmAH+In7NUqEyNtuGhNONZfD2ghcrWTv1Tz142OT37/6NJRkjgDfRxACOVVy4AM5MNMOMQoIj6MaMrF9R+WQKldFaN47doYV4ZFszPQboFjAz3HAb8nlwPonIN69lAe2g3TfqLLJ9Mr1/DRUCyIHZEtXaoCkWdZ4ZfnnxAjawtmhF/Fmag8RHDxTs4qGzlp4xFvjikLmfre9KIx4b5/EcRn5xbDpny4bj7ikSQTCGcimUgjPcMHLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH5iUGaGFfdmhZelIGaM042YMLSqA8Iit5srIKY9waY=;
 b=gAv30mbGGDx4BZP4brS40Me3NCht8sVXoPVPstme+QJh/XJKZCu9bEfLj2iM1+15Use/9Dl/Zmi0kiTgckBLPDW8fGH/gg+hMMpoPanTvmPT36lTSE3f30mybBNt460v2bH2T6hqHAnFNZaFsF7UnUkK5ssJmBgOTqrqhYY6PdLTAxmmlMmDxBG3rhAGPqEoOQV5LcfeW2mqCGMuVT5c5C1rJI33VvqXTxjGXRZN6jiTgYdnG9gXUVtJjwXHklZEb1CV0t+30vksbNdfsTf1hRsICzbf80tjoCAho9Ojj9id+fH8N0u0S+cKAbr5e3ArW4AvvgxWTKu775taGdAp2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:39:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:39:48 +0000
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
Subject: [PATCH 03/10] sched_ext: Split curr|donor references properly
Date: Fri, 10 Jul 2026 10:36:27 +0200
Message-ID: <20260710083913.30573-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077A9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::43a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 413401cc-4277-40c0-0bd7-08dede5ecd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UNgRbEkVfiND8vvkiDSiNdHiz4/g7By7nSijSpaW61S09zoAc3cs5kKZpXl1Q5Xpy7Z6/HCO7GaxCEMTYSNhS8sUOOoH0eA/S8sfDvSUfDCs9WWzopJfE5Z8ywPot9LZMCPEVhcdhJ4CB2FwqcBBbeNBIY5as0rKiHFWby67t3ZIjHMrf3c4TdkvmsX3iBRGyNbERd9TdNtP/5GOah+O6EUUKBt/9RyoDdjwXHkz9PgVd59l6CMZQDuo/XLg4yh/r5HO44McW2hmSHLqKejAGU5cig88fZ0KjNfw8yJuAUoasC6878ye8aYKniA03aOhNN2lXX1DY63eRjcnzGIGOKPJOxgcPr191u0N1oT00AIxLrXsBg2M9jdjQZfHMXsDbHDXPJAxz6TxlfnODQMk9PBH/46Ww61K32JK0Gskm/TMeaYY+rXIwL1DP0joxfRtS1SFxU0Oeq4FHbXAqYiz5iPlpseWJZ2g0qnw8T/58TDbjszme1yyZSqN2mazdAN2P89M454UcVuH5CoQsLEHQP7ClXYwjw9p6feDt63wFijYEmc0cqITVH9HslbUOx3aJuyB+wcJorgyS7VzUqq112vrx3O5KgxeV+N+o+nfJN9moE+SmNzCNyg3SRipB/YScXdiNuCpLQz7a/VAGe0/OhkU7YEnITpZNgfU4KLUy0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jLiMV/zNJubKksJwFfebLcqaaTdnVCpGxYKu/YnzwUnh1u87y2HqIuL8s575?=
 =?us-ascii?Q?6aDNTbmrBHogqrHFd/2TyV2LIIbsFge/qpUJ07IrzWvHun0ulgq5I1WP64YF?=
 =?us-ascii?Q?VbsYd7VXaQ3MLmv+Rp5Ks0Cg6le6yxqevw4r4iIW4BraagYWKfbW4seUDy1i?=
 =?us-ascii?Q?9cXboOybOEEkuqV+67xVB2TaaqceuAuDmtGzzqnQ0YiuJ62gbef0JmNv0Xfa?=
 =?us-ascii?Q?+shEurBUG1cn/RTnAC/gH5bQjA86uD5stc8vNy6XmSxPc4zCYqirmhRxX3Ua?=
 =?us-ascii?Q?RB6HY8ddk+on6KnJ7Ir9O8W3LnnH50864BN32xsKVqWdGw7Xir3Kr7YZJZKH?=
 =?us-ascii?Q?luIFC4ZtW4u0UEfDwTGiHfWKcch9DJP9N322Akf8HUuTmotdPb95pgFmOaIH?=
 =?us-ascii?Q?jZaE9q86s/j2H65Qa6EJv/oVTFS54fZFPS5vczTcGWyHjdbsLLKzzs/uKkiv?=
 =?us-ascii?Q?MJc6nw/0KeUIfXkJRNXYLRg/B2CFx67JpZ6YtbtJo5WA32YlwXEgLwocpLPu?=
 =?us-ascii?Q?4ZFXAzAk6gIKQNTyp1g2VR8kJ/peDPHZyxpB1r+EdjHpeK5U3dxlm/FHFtxc?=
 =?us-ascii?Q?HCl+M7KUBUtt156m86yauxtLmTxwnPv38b7qaS+WXWu9ko3HMM1C+uNMzJP8?=
 =?us-ascii?Q?ZN9KFIb6NwnZeS2eo4JqtLgZeqngL+/gV2r/DzPuOUsuCnM8sX3JhNhUWm44?=
 =?us-ascii?Q?ynqClNuKPCKl48xJepmLD71278knfjRzP31Fdeebl0DqbVe7/UptY4jSfCsX?=
 =?us-ascii?Q?XGzQf3SOKSZpF79IbW4ydS0+A/jWy73D5gcXQNwKUSzKFFA5sfLyxqi6D3M7?=
 =?us-ascii?Q?e5NnOX29EMEfidDkoJBu9A4WDlVlTVveiOKAGw/HVRG9A1dnhZtYTJDfV0OX?=
 =?us-ascii?Q?eyzW7G2yNkwAjX5e0r4TY2UoT/NC7Bq64FAFJezxHItQNP+YPJowjeCbC3nm?=
 =?us-ascii?Q?OE6a8Bkaq2aoD3IrNaAiwClXnWiBi1f0zAyA55S5Emnlp2jIBTF0fHNYCVRi?=
 =?us-ascii?Q?yTlp1cIzRfPKbq9jvNrzO25GOmh2MwPGBJiXjAvltUc+Boe52jXCyZeWABKm?=
 =?us-ascii?Q?1dyyi7+7aiC0tsXslLhzDIRolMct22Ss0a9RQKqNaHX75ozOZhfUA++nyNBm?=
 =?us-ascii?Q?BbZTxb2mncaf11ufrETxedeJaiZhU7L8UIBVk7HlX4S/+y0DMXqaQLR5BU1d?=
 =?us-ascii?Q?bemCGESpqR/RayIQp1+SQLP4P1HjhMaCHYxLTr4E4Kv6Z6pbXeeL03lV4Q4V?=
 =?us-ascii?Q?MpUcvy5tXDoaY8gsmWGTypqr4tdPqFun1Ze2TQVh2UTih8LbYS5VtLEeHNM8?=
 =?us-ascii?Q?xdJxTNaWjKxt/DK7wKjC11AGqrc8eEE77P7ufhdrb0prCkIvth7dlvBaqlOm?=
 =?us-ascii?Q?4etmxyuuRD9nFWefZYb5JAp/F71A+i0W9Sdgq1NvOErtLgGJ8g5Vp9xs+yI/?=
 =?us-ascii?Q?uiBiKVXbRdPZus/cIIPn8x64LBXpFrDl1wr2otTKdEPUQJndAYYHicLp6InB?=
 =?us-ascii?Q?qIVPJq6Cmh7vwrYbxPVflK8Aa++ULTZ1bVVAoKqJwLBg4HQQ9wVLd9JNe1bR?=
 =?us-ascii?Q?tqgrSGmnz7yebe3DPNa5g3Kgob/dSAU83R2TBpZOanlF6JO6mb0O8Regn/tQ?=
 =?us-ascii?Q?IL5Fe17jHZoZgGCoED/hKz/C/KdK0niVlLSxv14dMzLsH5OmQAdnclC5fsrl?=
 =?us-ascii?Q?rYpgqNWfdgY9j1gA/mxlGp0sSN/dzs+xbpqSZFPWx3FdIgQ6L5cVNrnDcWCN?=
 =?us-ascii?Q?akX6ybRi+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413401cc-4277-40c0-0bd7-08dede5ecd45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:48.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKZNnEoKv9GqyVWBwfpnhjOvTr9vRlLQamVaHJU9xSDROqZEVBxREv/B/mCUX0ABkD0OKeuEfUCdMLqreXbcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

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
 kernel/sched/ext/ext.c | 53 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6b7efb19d2843..1946824f3b8a9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1149,17 +1149,24 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 
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
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF) {
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
-		if (!curr->scx.slice)
-			touch_core_sched(rq, curr);
+	if (donor->scx.slice != SCX_SLICE_INF) {
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
+		if (!donor->scx.slice)
+			touch_core_sched(rq, donor);
 	}
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1320,9 +1327,9 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		rq->donor->scx.slice = 0;
 		resched_curr(rq);
 	}
 }
@@ -2470,7 +2477,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2678,6 +2686,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2703,6 +2712,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	clr_task_runnable(p, true);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !task_is_blocked(p);
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -2713,7 +2723,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -2734,7 +2744,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -2907,7 +2918,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -4060,14 +4071,14 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
 	/*
-	 * @rq->curr may still reference an outgoing EXT task after it has been
+	 * @rq->donor may still reference an outgoing EXT task after it has been
 	 * dequeued. If no EXT tasks are accounted on @rq, ignore its stale
 	 * slice state. If another task is dispatched from a DSQ,
 	 * set_next_task_scx() will update the dependency for the incoming task.
@@ -4081,7 +4092,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6047,6 +6059,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(rq->scx.cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(rq->scx.cpus_to_kick));
@@ -6090,6 +6105,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -7518,7 +7537,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -7530,7 +7549,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				rq->donor->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
-- 
2.55.0

