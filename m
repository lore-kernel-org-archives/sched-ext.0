Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C93C8C5E
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149038; cv=fail; b=Lmzj+YNcOsLNo3F5YqtBG0cq2E9OoRgg+yllmWVYkavXBsSBAjs5tFegjtlCpgc+d6dVvXBomHZqkZbdoDZRmdPtNQK2epG9pVMPPTAoHy5B1zR1qZ7EFub7KigLKOYzfC1PHnWaNKXiT2juYG29+4xCc0/p9fx6ZigqUUJiInU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149038; c=relaxed/simple;
	bh=VqagT8MbLwznteo3cwgN1v6gaoMJPAQ5hJT/lICHpqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRJoCNre/Q2C6AYcIJOJLJ5nkR1oiHgPeO6G313xCDXhAXGqB9SmYWNT4I3teA0V/LhIMFcZzvx0r50s81qsY6b6n9oSIAFhB71zcSRKbhXMVoiHc69rJjaHQW0EncXEob8eeNj5rDPwlQJNMjb9q7SZEVnJgBRCTUV6j+18APo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsP0sSWB; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsP0sSWB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h45JLdRls9IPG2dta+DRu9p8Pxx6BSuFemrjo4MFDvpTFvd8e4H/lQUEjoz8OkCalNFwxxZSyoPZp3nte84CYPpJx041RAdlxhGKWmk6uoE1tiMOwMnCzAmQqdiQALC2yqH5jwqez9RjMabQGSait9wz/GSLLvAcTpC7NhvKt7avzRKbFM26xcyke6Fz9+UKSup4XDsfvEPtaSsqR0MX6Z0KKQeMglxN0Pf9wh9PHh8kVPAO7NLIhLWT1iPrJA35M606sY5WWBeikF141c/DwPhZos1b9CYUj4phXrACFD0GDdLClxpCcfADQnwMToplI6mG3ASdehsWYDHrIkLx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YD8InVpnYMOdmW+bb7g5CBbdvTLAVYr0YIu85PZnVk=;
 b=D76qXslwS+u1hqQhrA/JC7j+J0dF7fNa9sPWrlYhGuYyk7mQQ/+UHEFXHJj6E+0vWdhKtkGJhLB4Wtx+G5hkGhprw3DNXv28LwdHmv9Wqw7/bbfubL1+ulRekXo3eQRgEJ7VBc8E1br4bnQO+mjA0P3QNLrn3zEWt9EEBR+kylCx42AC68D5yK9TQwnv9aNDx6PBERbfgeku8auK91TwEbtNL+S64dFC/0p+xjZA6cLBsBl1FqnwSufjNX1r4xvNyCRrvh7tRDqtNVuHh66Y0l3g5XuDD95XQDHHPjceH7DfqOeDeFQQMP+T/S4CFV/PnBCUVM+oIQfQLn/5N26Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YD8InVpnYMOdmW+bb7g5CBbdvTLAVYr0YIu85PZnVk=;
 b=XsP0sSWBCZcM2yh7HtwYXWeF58dl3Cu0EjBKgUoPfqkrNRHGjDB4avXYqJcZ52MwswZ9JbUrcIKldVx1Q8f8zGbf8OHtWiNgfO65wnkMEXD3PAKYrTf1+Om9HioJGf9k6dCbKmrev48EwIxHwQ+xw+NcJw8VfLLU1F5ZZQCvLUDl5XfyfT00azL+EPH0WAzNjY5OwBXfsHtv5RI7OiHqS/BLEfmkgK6+TeK+WbiHiejjRiJIBUBvXOSCFqo1S0tcQrwoe2mZ8cL5ZdzxGuBo29HZ4j5pqDNW8/e5Zud2HF3XV/D6NCO7UjuBz0a7Xkv/CJA1RpoNXW4iCMX87nmCqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:57:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:57:06 +0000
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
Subject: [PATCH 06/11] sched_ext: Split curr|donor references properly
Date: Wed, 15 Jul 2026 22:54:14 +0200
Message-ID: <20260715205622.276220-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B8D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::414) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d4c88a-9820-4a8c-339b-08dee2b3a0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xqSn2b6aOa6Mf8bHkkBsXR5fRsNEBwqmoB4nRAcvr0F3i8CDj9mWFDf7w9fr1Z57hdkxyggZytgWUnoPEM/mNO3v7PzUWxOSI/VfeH1CXVbUwzZC5YytwPUy3sc/z5KD5m0Y4GWcI4qszoVZyGfsDfutIPzH1qwsMBCxS6PaseJsxFI//UvSx4yLoVegca2RAyi5AvAAsftPDGH3EVLCqlEtLzaAMe/xT97NjmN6vJEbP0oPN2tNI10FCW3CZdiaHCW9vL4gJXvO5puOEqAzzyEkbArLlLntHwoD77vTKqmacwmteoIBkWnz0nQ9IlHnvX28UO+VIplatofrqsrNPp+smwyRhMRpAU8oVJNgO3cyR6KWmCYuntppDVW7Y7ZSprIF6BP1qkUqlZ0BBGe13iTd7vhcVT8JgrWRlxJ9G0faCg0pi+UoSbOm9eNKsTidE2IfM4nrNqypmhuV3Wpdtn5mt5z+U3cNIMmB18JXwqpqfwDcGvKV8c2WikPipf105N1C2C+SwpI32UCPTWCWcn6IVcip64YTPwr9PcX58KJo1v7BrMAAhpEEZR60HeCx0JlCDf3SnjnGMq1esZTCB7jqXAPp3V/r2ZjnFCvdXmF0Nlv0lz2JXDbCNFIVuhr7AU2ddVFbtb97vaqusnoftTMY6c4kJof6B1ugx30AU3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TyxRrS68jWHkWusHKrlBRHjQXFpwyXZ4g8MM/xjxZsTvPufv/g/FsqXQZyAt?=
 =?us-ascii?Q?dX7FG39AdAXcec76929bFqnXGs/anyqEoGB1KPIM79Zf6RxYNoozJmKkQkvw?=
 =?us-ascii?Q?2489JulOAlVKvM5HIh1dmP3tChFVY53/VVOPFFpzuBKDujN03uDfoTGM+2oo?=
 =?us-ascii?Q?yg0VM7AR7ya9PCBC8t+//wfvHs8MKHw66ThzqlwVYLE8zHygiuOu5eq+1FZy?=
 =?us-ascii?Q?d6T8gzTOq7aX3tpexAJVy8/CQqjwmPyRZ24wlU5Z+qQXDpKJ0HFxaEA7Xuvd?=
 =?us-ascii?Q?fUZ4PFhG4CifC0/pQ3EpBUj003bWHg7wtSEaL6q4XZi9ZRiAc2roM19I+RbK?=
 =?us-ascii?Q?H5DEPepKvjlayJHDzhGZ3Wun8SY5fOc9bDHNZm6ZF8kqmLCgGa5yj/qnwqOh?=
 =?us-ascii?Q?0UnUiJsj78pv0ksvG8j6tMslR6CAC+IVYhIfY16li1nJoSZO5nYaEt5URkIt?=
 =?us-ascii?Q?OvN+fhfRdNbAjUbhJkIgwHxwTf5vYfvjHiI4CBdTGpg6oK5SsyR7Mmh+3Brc?=
 =?us-ascii?Q?aNqGs3PK/nFk8njKZVJOARSP7cp1hfGlUFRix8bI52B3TDRzemZvKfjx+V5S?=
 =?us-ascii?Q?NE7WmsJKiz4BGPKxqoJEOeKBQhE5zTyZPx40L6/Cjwl+cUjc/Td/1eiuRTb8?=
 =?us-ascii?Q?WDYllEd6VAFXQ5Btmf4vxzjNLmywaeVwPmGfZmOHQAaHOV61LUmStAHZso8z?=
 =?us-ascii?Q?frRONrayicjzBA2KD4LcefJ5H/QqBnGPFxZg9lsIhXmCFqhPmWieI2hUmWC5?=
 =?us-ascii?Q?FVXJL1qBh85yiLmta7PrZQwhO4KWNj7EjQG64MM4fQ1pAPo71zO3SFdTLxNW?=
 =?us-ascii?Q?R5OOFFt3jW7p68SSZOnMZpQwqWHAw4AXfoxJrsEdPXXyV+/c4pNC4rLDOvuI?=
 =?us-ascii?Q?ILyJ0Wl8l581UEu31OCgJUqLubhHg9BxK1aid3jyZtcTChYUdR6PJam3pUkZ?=
 =?us-ascii?Q?VH32r2rmqu96a7IxDVRfYfcCAS+0PAYoFKWrcRuh+qBCRptQMardyhSsm4ZM?=
 =?us-ascii?Q?aHKtbTyLsXA/mmYct4L3EVHhQXZcRDjstmpOqv5/edr7MsRJrKoVKIa2arsY?=
 =?us-ascii?Q?8AKC3YRr2HNilrQRzQSFWfvAZKY8V2b5/rzG3/7Ywk9x0euxQDPPoo2SKa4e?=
 =?us-ascii?Q?VnIhV4NBfIYrcGRa6d74Nnh4bABXHZr63t5MGwbEalb+A/NSMf0Cgu2dE1J9?=
 =?us-ascii?Q?52wsggB6HQjAT1Ne8nmbGS4DhMa+5vjuSp/sP6xhQodvdjn+4wVSyfKjQafA?=
 =?us-ascii?Q?J9bxOHLwx9EtBPzVDyKoNf2NiI4EeeQL7xxKo6R5hweRdg/pUW8upP9+UJf2?=
 =?us-ascii?Q?dkCYOEFOGvyUWWIs7VBnQEjCHs7e4Yu65WWhbLkrpb6kkFU+gPiGuYLMv0su?=
 =?us-ascii?Q?/ddbb2/Iq4oAA6FfiTNmj/ZXVwq0c6zylTHEv0lzxTGcB4a1bLt7AQh0FK7n?=
 =?us-ascii?Q?ZifI8Zg+ORZ0v7R7FN8Mn2AScjOs8WH8kyP3csc/jTjewOj2o6yc00n2nDbs?=
 =?us-ascii?Q?JUqPSwENThd4jIsEL9TW97linMfQKTRQT5mNWZz9taeu6w51Ki7ilH8qA4jj?=
 =?us-ascii?Q?ZMeLCW7koe5ce3V5aQl87RiSu6c4rZD93DlfdrSfuMTPI+I4xKYK/9lDiBXV?=
 =?us-ascii?Q?V+G/Ty8iDxkWAcZPNj9kXaaDk3YMOvhskVvakAUGWvduMXRxe6UMfHXPJX3H?=
 =?us-ascii?Q?qFdPDluw04nuUNFe0TNpYaubUjT5dsZKQQWgqu+Xe/Ns62dWxzgkbxBhUOoV?=
 =?us-ascii?Q?q2YPHRGK8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d4c88a-9820-4a8c-339b-08dee2b3a0be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:57:05.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qT436ltEF7Q5KQcWqUfteMaUGZZz8gtle5IGXhG9eNuZJVnmbVfNL/eW3S9yUTbYh2BkM6PQtxtLYyqx64X4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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
 kernel/sched/ext/ext.c | 67 +++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ca400f765cb7f..6f6884833f8dd 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1332,20 +1332,27 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 
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
@@ -1515,9 +1522,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		set_task_slice(rq->curr, 0);
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		set_task_slice(rq->donor, 0);
 		resched_curr(rq);
 	}
 }
@@ -2720,7 +2727,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2931,6 +2939,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2959,6 +2968,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -2969,7 +2979,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -2990,7 +3000,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3165,7 +3176,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3525,9 +3536,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3536,13 +3547,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		set_task_slice(curr, 0);
-		touch_core_sched(rq, curr);
+		set_task_slice(donor, 0);
+		touch_core_sched(rq, donor);
 	} else if (SCX_HAS_OP(sch, tick)) {
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 	}
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
@@ -4348,14 +4359,14 @@ static void run_deferred(struct rq *rq)
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
@@ -4369,7 +4380,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6464,6 +6476,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(pcpu->cpus_to_kick));
@@ -6507,6 +6522,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8019,7 +8038,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8036,7 +8055,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					set_task_slice(rq->donor, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
-- 
2.55.0

