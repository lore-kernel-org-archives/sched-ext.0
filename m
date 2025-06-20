Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248402ED165
	for <sched-ext@lists.linux.dev>; Fri, 20 Jun 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451582; cv=fail; b=WOUJq/bTQYeq0WGocwrX0zywfHNWVcccQX7W/96cGbZeyIARflEPjasKKmHWV24Rttng7aLh1jHUgDDn2smeS82Oxk4itAOvHQlQsq0uGV/vkp4ICalHpGgKtqAyfoqVD7ewx3u2BhzpnfDKDf9mceSTVsfYbJqe7NFEAffOrd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451582; c=relaxed/simple;
	bh=W9kO7sx1FOLADnvGJdfDcIH6hRw9yOvz7JvASiIQd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQsHfKyvrn5db8UVZZFrJ06vGUmfIuzUUHlJ/xApkiMV36GsZeskXSmDtZRL06h8toAhJcRSnutaNim4EJyQ8gD5VeIDSSW6KWUEjMhIbix4A4ZBWxY9vOEiH6JGZALn+aBJ/aOnEz1192HpI9f4qO1Nly40uZ3f/mca6VUiIC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLw9yKEB; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLw9yKEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brPK3re7bnviKOnSQj8LRalO+Nqf7SR59PjEdu1L91Rx9qyS0UEkkqAVItePZeDH/CamW9dY2vWnDMZ+0A1ifm//WegLwMg5hdjW+6ukPCVgtesicK6VjyoogS4DDFAs75tUI4VHfNbkUsFVsDtW8oBSu9rlvFKsNEiDUSz6yRlkgqPpRwWEMrogBeVy69uSd8xJH0a3FQ2vfRVjjbQ6AklqT55ONobjEmxrTL3Cn5sGxEUKo7nkzaWXsNCkzQCAjUDK+Bqvc1G8ILl+N+cEJ/MsnjvO+i1v/OMJNphK4XWDPO4zcHmGN52duoQSR61Qaf6/M2HpUTbmy0iAYLyNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLUFeZdYbe2wau8LJCUPjunRVUOiwTZXrBa48ZXaZCg=;
 b=Y2Dg35jdK9iqPgJImbmd5ytitalSJuwjs2tTT79MPBrGMtOUAW4C2ls37F0BYKU5WvcsAyuVe6/SNKkGRnpZwQ4tDWdb2gUTYSkcJHhdhJpoSZKg0uedVytxB6ua+NGCKM1KosY3IwG/8QL6eMojIfzS+ZqLL/Z5JrM6hlumkt83ayqrzntZDRo+Xkg0Clq7y+X9S5hwlUtLsPifrKcx1tmzdzcGYkJtYOt2zLK2Vod2TEZl5JwF/oiiAWRynN/akJKQ6O7juhCPj/XYsa9y9hn0jTvSqxFFY0jjQwWEmrzc7rQjxGDtwFRQUye8fm91b8A0zwqxtDNe5Dc8ZkdHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLUFeZdYbe2wau8LJCUPjunRVUOiwTZXrBa48ZXaZCg=;
 b=gLw9yKEBEl7I9t+g+aLBzqauejnWlRDE4bPkCbdGD71pOJklmvCH7FTrPQ+QBZ3hPRA8Wg3KyjcMX0pOLQaXxbSF0s6aRM3058+PtoPNsdKFRO4FbextYeZwnnuPzJBZkwZZ+ID1oFFnrJgkS2y6uzBSNUNcuuNWXo7Fq3K28tgftKR/Jk+0cXJwZmCss7pIXBvdtI4GgZrPZ1gbEcg/pCCRme8EhmwHMBoU3ITNDEagcjmYooTr7KXLUM33Zgd/L0mNb+qtABJuRy6usGDRvHLxtCizTNIx0nvJQiCPwTzhbbsWOH65SJ660OPMNVr3d5nGnYJWJsThrezdzFmx9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 20:32:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:32:58 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH v5 08/14] sched/ext: Add a DL server for sched_ext tasks
Date: Fri, 20 Jun 2025 16:32:23 -0400
Message-ID: <20250620203234.3349930-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:ee::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b514f95-de39-4cd3-f296-08ddb039a4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wPfiERb1z/wmYLTeHmfJ9aH8g1B/kXitzLOhxF8aerusOV+g17yIBuZIydp?=
 =?us-ascii?Q?ULs50DojZZ3BXJS06xOmj44oV+BlplvnOxPC9YgMVIQ9ZJ7+o1sQDPwbTCmL?=
 =?us-ascii?Q?J7/l5uyt05YK2wJXW0XoBfvh9oSguToKyDVcjnrMVtLtJqNp47MpsxzLfcb5?=
 =?us-ascii?Q?PTFSMqOZfjov57cNYwNlKBHSTi2mNeoO4wvT4M2GkQ5x1noq6D2TVUWit6ke?=
 =?us-ascii?Q?eJLtVDUoUSUc6D0zINychCAayUJlfftl6i9y4e+WdZPM2Bss5Le7K/qr4LW2?=
 =?us-ascii?Q?Q29s3uOEM1r4BfqGh5xO/Rh9TlE1lKxkLRWftWVxO5fKN+RBglZ9T3CDC0Jo?=
 =?us-ascii?Q?rT5/THmcidiT8X25/+i38aXyTv1beVLuxTPtFfhvcZ0sDfberw7laGxfxlqu?=
 =?us-ascii?Q?c4DeEkHXkonrumeg2VujRQQRZMz7YvXxUREUJ+FgoaL3Ft0Tbk8aoXxSUiTK?=
 =?us-ascii?Q?bg7hRftiBE4R6t8im0b3TskG8R5UZtQzxnrzaLg5Rh+CjauRRf2q8Ud/pgiX?=
 =?us-ascii?Q?rYF8lsl3HgmpTAxyCdZbVdzv3m/tueuiPUFN77vr6/jY+m/wQ4tOzZp1Ouv0?=
 =?us-ascii?Q?jpUVfnoXY41aMRkue85XCwWnjSzk0oRu7zsqrZyc87eS0QIcKOQcuUAPfKBo?=
 =?us-ascii?Q?UrVhc5X34vzR6LdQxzPFlUs69zXfxCyw5b/0mpAUB7yfcaJE+2470VEVPzhf?=
 =?us-ascii?Q?BM2DDNQcETW3f/u4Am2g5dVUPqhzapm7SRekutLo9Zz/gr5RF45I1npnIyyZ?=
 =?us-ascii?Q?ZZ66yrYV2x5QLWAx2kD8015uEEt6eAj+7FA7FNT/fLl2lbUWXHOU91LkvKjH?=
 =?us-ascii?Q?noSLfL+oMiIEfCsJ3UW/7hO5bsDYl1pXfZwR6s0caCJ95ENuHBsps4K5zs+X?=
 =?us-ascii?Q?FE8kOyxHuwg4OI1ReVjvEpowcPcKMUM9NUAmRPIggxY5c2lXuSy7e5hr4nLd?=
 =?us-ascii?Q?lmt/g7JQor0qm9rB6XTSiaBYTgGcTLc5aOIUbEjcHoP03ITT87Lgz69Q8bLp?=
 =?us-ascii?Q?SK79l2+nkgXXa+y1z5PF/oWEemVq8bXlfipERU18uR7JV+CiP/uP3c0VpvEg?=
 =?us-ascii?Q?Kc+xjqaz0OpI7C1UeyKdTwQ9jlhtJH5VG9twUNB8sH3/T001FNBKDSccEFc5?=
 =?us-ascii?Q?ffYhRWnO/JNy1v4EgMXbhq5sbxC9jlQFj4sHRXR47WvMTTTeVk4jzXFlsGjJ?=
 =?us-ascii?Q?3q2WmWFQx2dDPDogiqzLgCwj41uUlFomqY54SK2PxqqZlSS6FisPTAn0dzFq?=
 =?us-ascii?Q?Ejrp+MT2gQQLpj30cc3YacgjM4JOagq0aB3rxUJr/ZAzp1elrM7reX6zLaui?=
 =?us-ascii?Q?xBYlWx4n2FmXA8I4a6Gbx5mHzoFWb5EhCpzZ9ssuQQx6uwZTaxrQ/Kz2p0AC?=
 =?us-ascii?Q?L/vreCPyTOklxHceQHBQXkjba3ku2uv6sNAHGgGxghPnuqnAC3HpqcLv9vkV?=
 =?us-ascii?Q?7NRGPSO8XuazuN5V/q7sZJMTPP/Q7h1iNMWtMGzX53KSSYLlHF3dug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2fTpJsSjRjzzXy4FBYU/vz4ppbGhACiVZcA7gf0gdUZ0OGkHFG1WjPEJ1fq?=
 =?us-ascii?Q?E95RzEp1936IBYbOpGDbbKmYD2xR1F3W5aN/QsQHirOb5Ro8X+yLRQnhfRfX?=
 =?us-ascii?Q?B+MMFvfF20cqEkq7e8dRemxkB9mPQHekJx0XUVfCy5dudQkrKnrpN6VCxz+0?=
 =?us-ascii?Q?GTdOlc1/IFksyWjwbG6epmt4X8h2Fkfq7iSEepjVSTsVXEpVOsuaPUfvWOl2?=
 =?us-ascii?Q?BpJxKq4oe+qP0pxyThbH7yZEPbqclCD9Fk1mPyha+v7rRvRYCDPqYfKgSb5+?=
 =?us-ascii?Q?Ho4EDMzBx5ZSoJtrtQIl6d8jgF5cUP9AZgzlqqn9QNKNTBFoQU7HKK4j5hqG?=
 =?us-ascii?Q?1AZms9uPpxAM1jRPFCKubG3mtNBUsMQBcAOrXZnS5+n4b/3tV4DnbJ6MAVQp?=
 =?us-ascii?Q?hzv/dA1T1dCKbXMAlHZPm2JzNcz1JHW3l2kdK1HOAdBZcZHt+F7o6WIOO2I6?=
 =?us-ascii?Q?Tl03hYbcyToR1MrbmVNqf10i8gofnD3zhozraXbco+atoXrp7UShw7PtrOt3?=
 =?us-ascii?Q?oEzfgaGVj4GJFM4sOYnksOps5Pmm2qx/lQ44+IprVMAzCqSwcLkHd5o5hqzA?=
 =?us-ascii?Q?IDKR7kEMeKvaPvazCwdcmO7tJnEJGLzBOpA7Hq0dEZb1dcB3C0IyinjU0toq?=
 =?us-ascii?Q?kT8WpTPI4ttLcHEK35Dsat5Vo1frH83sYDshS73Y67lMZibu98oubFUKfl6D?=
 =?us-ascii?Q?dZ4rzSqcozeQpZZhP34pUfl91WBQ8MK9XdGos3291ixst2NrfhCQjF76XL29?=
 =?us-ascii?Q?mShN90vOzw+Gvdg9+eHzfGPJGfFvf9qwghHXrgyIJMFSjXizypf6MQEr1ImN?=
 =?us-ascii?Q?7KbD96/CfojHoZMpMYkQtdHpqDwcqvEQ/AEfgj3LLw93GfwsgWYtuutLAdEO?=
 =?us-ascii?Q?1KPU7rB369gv7Gs4Y8NUIvBGgVGHNL2kkoxFGMF4DpcoVrd7SqdcAulDgawY?=
 =?us-ascii?Q?G9ZDrfZJB2zJm6CTIdlSe3CjlolXekQa+VsNkqsJLlv/xvcTRcVbczWTOCnq?=
 =?us-ascii?Q?fIRoBYW4lr6Zn/hnX+b2FCwDYiq0V/XKmTWB7NYg2taPG9vMbOzrudyHl8SS?=
 =?us-ascii?Q?+Al/CeOGqr2yG2ecOKK/hAfbKeKEwo03/MGrRr11rYz4gM3qJjy3dgDqzXdM?=
 =?us-ascii?Q?cJJ6w7+t1u6fr0x9O4OKQ95Bs2DbSkfdgR8f+xuO+q6tLlcQkSmiO5pAQESo?=
 =?us-ascii?Q?o4Kmqq1BQSvDJfx7KjtiVj7mSKrlS0aMw4iHe7XAaEg56WipO/KSw5ocBdDf?=
 =?us-ascii?Q?SJ8Uwv49BAtKh62XV2IQ+CWHqEuYr/u2QHHf90UuHnPHtri3py8RkXx2UJbB?=
 =?us-ascii?Q?B7+JdNfNXTKzg/64vg8zD7X7w4sMd4DVuZqE4VDCn2cHYCTEtQGsh83TeCgA?=
 =?us-ascii?Q?jHIAtLuGS7tv9ctLHrU5awMVpODPsQHDXNVrBqrYhpf6TO4OspDpEpvdo0V7?=
 =?us-ascii?Q?nKS3mrj4Q9x+HQ+UvhrhR5og7pGjcj8wpQp4Nhl/s235JLK659ARDuylQtw5?=
 =?us-ascii?Q?zQbzB6mqNBfkX3F7ju1eCtFGJuq+9+qMI994pT6cbn8rPyky8Ffatbb+hmcw?=
 =?us-ascii?Q?8emFSEGbKu0k+zHQPq5qeBd9cR2SAhAGkOJixT0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b514f95-de39-4cd3-f296-08ddb039a4ce
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:32:58.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/uruWGrKK5qfqn21EOorHBesViU1Q5Ce14sFh8tm3YIMOXnum8g7jFwGo2VlKD46kjZDBhKh2xNWO17o69uvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
ok 1 PASS: CFS task got more than 4.00% of runtime

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/core.c     |  3 ++
 kernel/sched/deadline.c |  2 +-
 kernel/sched/ext.c      | 62 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  2 ++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d856d8dcb94..a1ee241a63ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8650,6 +8650,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 562e1e7196b1..c61752c2e052 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1570,7 +1570,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f00bb75ad539..34c95100fbe5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1909,6 +1909,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -2396,6 +2399,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2495,6 +2507,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -4050,6 +4067,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -7310,8 +7336,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
  * schedutil cpufreq governor chooses the target frequency.
  *
- * The actual performance level chosen, CPU grouping, and the overhead and
- * latency of the operations are dependent on the hardware and cpufreq driver in
+ * The actual performance level chosen, CPU grouping, and the overhead and latency
+ * of the operations are dependent on the hardware and cpufreq driver in
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
@@ -7603,6 +7629,38 @@ BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+/*
+ * Check if ext scheduler has tasks ready to run.
+ */
+static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->scx.nr_running;
+}
+
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
+						void *flags)
+{
+	struct rq_flags *rf = flags;
+
+	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
+	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1ac2fb398982..576b69cee6b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1137,6 +1138,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.43.0

