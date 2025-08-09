Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110902BEC5F
	for <sched-ext@lists.linux.dev>; Sat,  9 Aug 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765318; cv=fail; b=Pnl9EjCScL3Pf70wyJoPHbmiUi0f+WlJSb6yKGYHQKs4KwaycsBz6JIGSarPr03ZaERj2IrU0TVNwcZiTyc9v9TBiAWMaxYeNDfNx4vQYkogvgRaPBXWNYW6bNEzxaU76JGMGr0Ccwtt8Rp9TTgt+gHggRRC1GB1olsjLetXbC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765318; c=relaxed/simple;
	bh=uQH7p9dJ+rjg54GvUMD02h8Ygloo5kbaHjylS8otCN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dR7k22XusZ8NQ6oUM4mSgexrIq/cNnGI2Cx9tlpWtpSZo7UG/x5wdDY96ga9HKhITb8zHfbhRmQKbp1H2kWDWaycVnmJKfww7l1sYDrqAJSbLfIvzs3g8DNruggoYdPsolWdkN2wP8h9xnoozw17KM0FGGjn1szaSX9cpEY6vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CYVRIhDC; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CYVRIhDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtdRe5uPRtKdnkra1CCLUcm7Qltt0tFuqkzycvLackpbhme2GA7qxqnrDoCXVkxary7VIq/Bw868uDmkOEdIlboANsfFh4dFq17F9JRxFz+UlpAZV8UbcTxFU7TMk2VzCJzRc9uv0Z6zzp99c5MwJJXPPHhvyr/VIlByE9XgWVR01HF6JwvVuOOCxUqvLchTwaGsVp+DdWkhXDyYyHkgdhaiYgwDNUlAHvnDqukBVyPiCO00p/774Dj7Z7JjUMFB3HgAk/1KovqQDjp5tYP9t3ANNKLIlmVdb90oX2OwjBQZRDk/guXvl5lX+lrSAGColYtBGb+XpOwgalKRexgSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSpOTnAG5kp0qnQYs6/UCkqiTrQ03myb6xjH0kECvqQ=;
 b=kA0enEAkqP1zg6IuCHi2t7GdfAqXQ9smSk4aUmMO0SkyE1n5uL/e/f+uyQHHoZx1rGkoezIZswv8uwuXvTIbG7hO1vo5y0EKLYD8EllzmW9JJmnz8ctupgBZGn3Ow8e+BMtp5iDOBklnecPfQkbiC84h4zg+t+of+Fg0F7etZgvzGElqBIQeWKT8F3SeObmJT52+fdqQ5gZbneKlqltWQCojabiMTuTboG02yg5m/gDB6MH/JYSGeXm8IHmuLa2BCztu4PRqcbnxWZL3Ns7to7/jUe5t5EJe5YUHVVvpj2NQol2MszCZgtIn0fNZyiqw6FsZJqqB5W3ctWeFHeT64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSpOTnAG5kp0qnQYs6/UCkqiTrQ03myb6xjH0kECvqQ=;
 b=CYVRIhDCLREOgdRzI1QmjC1l6aMu62GBWiLWDr4tGvJCalFAJ7v7uEMU/X2cmjww1c9Q7VGJjvmRBC9O/12Wyvlnmu1y6RZPm2NDh9xQmKHGG2xWBgvqXJRfjn6hAb3KnHouSu+2XkAAntmtSbds0nMmB8BnQEJSg1USNwUTdLW30SCI007yaZdtaOKnrheQfT3Aje8tSM/O3q8lPyrLUTuU7Wixnvc0A0hYOowdsi1/cbmjXzFxZAkv/afm+ZowO/kHFI157qDmujs9Tf7L4KXYBuw8Nrdfe2UUfQ5sgky7qoQRFcF5ZCL5D4qArDWEuSerOMeLYjJ85d+Je6TLaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:34 +0000
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
Subject: [PATCH -rebased 07/15] sched_ext: Add a DL server for sched_ext tasks
Date: Sat,  9 Aug 2025 14:47:52 -0400
Message-Id: <20250809184800.129831-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adb611e-232c-4f8d-54c2-08ddd77557fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AP+kpsGKKxpcOLX0KGz7ktrJhwYU9jY406xaU73hJvsLGeokYk+clAFcLNeW?=
 =?us-ascii?Q?Gbj6H5WkO3My1ysnWkNeCVokr+pfrZH1ddSuw7aFWwPF18sSZMXX4b7rPvox?=
 =?us-ascii?Q?oib3du9pFnIbzLBDBrElhcLNc5MrZSDSsjEMyZVFGSvNyYpzohWMRoBG5sMx?=
 =?us-ascii?Q?WM1P0J+tp0VPDioY6EE6p00QkJcQ/Uk0WctzhV4O5TmTEdmI9u57ATeFKKDQ?=
 =?us-ascii?Q?T2Mugbt0mSt0jA8XM3u/pTYqjm8H5tvyWI/wFi20PcGuaCbZYYv5UfcOTbnV?=
 =?us-ascii?Q?2Dy6wDfly4ZxHPa3+SRHvr6TbWcJ6isR0CLyQXjBu2Rv3fLru3PnH9Q4bjJB?=
 =?us-ascii?Q?smeD4q6RKk8ewitHUXYjPRJamHpWfuCiwv40pnHJSpEYDwtFGLjI8+5U/NII?=
 =?us-ascii?Q?NOabyeeseYAP2TrVuQekymMbW2NYH4CW6ZUR2eBBJ9RCwVw08oELhoOEwl8m?=
 =?us-ascii?Q?dzWo7P71Jb6UOwUl26bmVdquY3bvxke3wBBNvpDHsZhth34+OTG553cYRDnU?=
 =?us-ascii?Q?Qc1g+ydlj5ff1aI8pLqv2ent5Ud9rEttEFRwnl6p2ue+ho8/yKgqGhdXybHK?=
 =?us-ascii?Q?vCPTVJ0QxMDePOSdxeTNGIjleBsQxmdlBhGShMttsXqiEZfHOpCTXfbnSu5f?=
 =?us-ascii?Q?sLyXPTtwGB9FXkc1AgL/h4vQ9+qhtvn6jNzgdLOfDb2uc8Lw5alMTuje1uq7?=
 =?us-ascii?Q?PTP9QBJgmrCMyDwM1R83C6V1D1M4yMlfMmH4mLWUDHzISCxZKYtPJEfbVkkU?=
 =?us-ascii?Q?lr5B4lSEKDZsbjUNRsmrd9S4+qgVHgJ3xkxgjKXORXSMHPP8mSRJZJuo8hZg?=
 =?us-ascii?Q?UKDWoNsqAUewPNY4MdhmyuYPikmerdgr+dzf6Ne9V1P+j+qKzkVx3lBeDD/d?=
 =?us-ascii?Q?CX2S/TnABEn39IscSJCsmlP2ocn84BXa5zOQNBMHleLqXx2CgY+4DLadFjnz?=
 =?us-ascii?Q?8rmHMmayTxbTy4DhVdI0DDSL+Rm7jIRdq7l+Klj18+1Qq29AR+wT11I57NBr?=
 =?us-ascii?Q?D5Mbh0TZdjcqJUUkRTEpODLeIxw4etSuQxjMMCT45g2zbzOhRaMazLLHZYf+?=
 =?us-ascii?Q?0dgSeG1JeHPBaKBIR/w9gN2QvheLHKBhCBeMYbZLbUZId4reRKSMFTTuZ2Gp?=
 =?us-ascii?Q?PrIDvqXZWRgtoA6UjV8/A470uHHO61sj5f84SgzIe8a0FLhPR/faYAdLrF7g?=
 =?us-ascii?Q?SAxXr55+QTAbuqY0fxoE4mQHZUARQmyLbsSBcH1p8UgASWTgGOZRcssKuKuu?=
 =?us-ascii?Q?GzQTq3sceFkFMWAM88yhAvziAvKgzJfIqrHHUeuqJiOvA237mrCgAlUGbgsP?=
 =?us-ascii?Q?PiLQxbnUeYAektooGK0cZCfkl055U6BLDLJ/i6Xg56QTTUJphfDVl8VYNYX1?=
 =?us-ascii?Q?AGTEDoVDPOXp6oaXC4PAWKdtDKa6/faPIaFWzp+4WO7uW1nDHNcsBjZIsYMQ?=
 =?us-ascii?Q?evt6konQAfy1A6y84T6cEOPs160Sm7hZLw14vZMpZ9P2j+mwstbGNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pl3i/gM4Ov+CO0FQnqB1CBV1+gReeH9mvLCZMUnHl3AEG0SmMIVsHdT7E/0R?=
 =?us-ascii?Q?ztczyqy5/Q7I4/qzUgCD7KeZsc10CgKSOMVTzyKXXbqR9MVszs3I22p6LRDA?=
 =?us-ascii?Q?pS4zgdyj0254OY5VwF6e6Lgv9ZV/nkvW0vrY/zZJmjFSmUDETVHEE1h6Mtug?=
 =?us-ascii?Q?F87mfw5xzAE4CY55kYUWD4dGd4ihVYKz/uZ0WjnaK4MU4J2AxZr0+Gi0gHjZ?=
 =?us-ascii?Q?qNF3GCQ8NF/Cu7GvG8MePC/tSkz5GlBhO+IWWug47PHaOSCzbAM3oD9GPp/r?=
 =?us-ascii?Q?aDLiLWJVeygNHBKCiiMfd+nHZ1JKk3B6roU+qzCBhGSCwtK+FsUC+98KW3XQ?=
 =?us-ascii?Q?GCDpM7imX7kZYm3YRCqL0tHOv9wfC+Mh3Woo7eHWb80203DTIKvItfMmO0yc?=
 =?us-ascii?Q?lu8Y+PnNLWaUGFc9YLgzGwXH5IhlGQSaNztfWZuq1AcJAllZve2Dn8YmM/A4?=
 =?us-ascii?Q?fZ7jFDTfTeiQhxLk0tMJM4DpsgSID7N13QXOWMoeHmrgnUdJPaOWZ5oHUjVy?=
 =?us-ascii?Q?HmWKUmIuYt4qldOcEXNZKwKjWbBUcNm7tTHLNLWgAPPh5tZTE8quX061CBmM?=
 =?us-ascii?Q?jJXof3VYXcsUUuM5yY+pGtLctfuhckz5kNx6WlRc27I5bg6jiwc+m8s8SvZ8?=
 =?us-ascii?Q?KqBnhfHq7oov+9HHDAWD+HeoCJkxQYCjP25kU+CTeyX8/3Rg3XNrsBKQuRQH?=
 =?us-ascii?Q?X7N6F3we76+Q2oqCtOO2epDORU3d8WyJ+OsLq1pDRiEOefrn0w4+JRE/go4q?=
 =?us-ascii?Q?hkiX5i2hzH4Urmq80uy7Vp6nuDRHDzaBoQuZNpNMF0e0YneG5cLBjUUh/E5u?=
 =?us-ascii?Q?CXEqLF+yGDCEFHCw5uP0t2vtgVPs5kgzbAkEXMOrNWgerXnViTX3jzu1Lbhh?=
 =?us-ascii?Q?F3fNpyB3qsawEEP2007Ghg0jO0c8jJUO81X5/7ZzhsrYt/9meZ47Kudk1KNV?=
 =?us-ascii?Q?JIMZ4gtNNUvoozzVjH/dn+PCgL5mZ9HVkCWnxJstPxcaHj1idId2oWtMyaMT?=
 =?us-ascii?Q?Y36NVR+QET+rqpt/UY8IACBmXHybTkQg9JKxavz4S5rPoHu4W4/eX83a6Krt?=
 =?us-ascii?Q?mbLMkhGAV2t25MKqE9PACdSGSXGGp5ymQFtixkAxFiKs1oFVjYMYrOZupEJ3?=
 =?us-ascii?Q?dz4ZmlUByP+dFafRBF0pg26UMRo5yCF+TeZ1fVa3EKWPYDPP53UPYy3mpW6X?=
 =?us-ascii?Q?pexH2+/sQngwK9oH9WgVwtUlzI+xE7KG6gzXxL/K3AclHHN8/yP0iUpDWhXO?=
 =?us-ascii?Q?q8mQwyBAW1pLgzNq3yy61G/zBGfsIwkJ6FGPRIvM54VTLOoCLo0Nz/+yrDPW?=
 =?us-ascii?Q?mjNkspRRNyKxmCSyEAoHQ4Y3QgjPRM6BKxn50c+ewNO3wnendnoxou1305nq?=
 =?us-ascii?Q?ZM/igaqo3z4X3Le0M2fY2RaDAurStXi3pMOpOjJlHYA2w/QmjKDWItQLWEpz?=
 =?us-ascii?Q?oGoBrgE23AZt+Xore1klfuVksrMzPZMlTKSWwTHgBYmyu+K3gCxzdvDHx2a+?=
 =?us-ascii?Q?KKWo1PWfZKZzVpGhTsOQr6wu9SgoTJPG0RJdRdxIUgB8PxnPKLR8GAl1EfyW?=
 =?us-ascii?Q?Go40fTsl0WTcDwA32QcQ02ojP+P8VDYMOiVjXQAH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb611e-232c-4f8d-54c2-08ddd77557fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:34.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeetFHHT0slJDR756NIAUlgYgwUgDNzOzJIThxoCt8rFF4Vr9bzwvH1RhWVjd1e+xXJVTeNa+Pu954BWr3ZmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

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
index f3a26d13b926..ce5b51faf9d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8808,6 +8808,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8b3535b8fca9..00bafa434fb8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f6a55cb823d8..1f68f9e69d03 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1923,6 +1923,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -2410,6 +2413,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
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
@@ -2509,6 +2521,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -4045,6 +4062,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
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
@@ -7315,8 +7341,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
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
@@ -7642,6 +7668,38 @@ BTF_ID_FLAGS(func, scx_bpf_now)
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
index 2c73d538f34e..51ac373554de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -391,6 +391,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1125,6 +1126,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.34.1

