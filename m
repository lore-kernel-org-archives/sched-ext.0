Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E34751D
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012811; cv=fail; b=r2/5AQHHDGLcaDxc9QXCdiR0h6DuKIQq0DFng7Az7VnKPQENCCcGo4gdPxymYDNMA5Fl6FZ8ipKvEEEC/vanNpH2DKt4/SinyXyYekgStkrlW4ewWRynZ6C+NfgKGXq1AsoSg1GkKJgSmLc55HPU5qQLy/XnSmwFBKC491bOE+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012811; c=relaxed/simple;
	bh=bwtcBgu0y9OxW4bigwmQx13xN/JV9+wUp/iKoblqJdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lo9ANOEWtJqQaFR41+ZWyDMRRVDFvkojBxUg6hVyRE4dq7MhoERF6httBteEDfDDOt1uVhl7VqG04wOpf+ITOzeB6gqD3qoSf6Q0gLxAM/S2LKpRbwnjcJRm4AcSWrtULBkczvNjsWz8BhVtRvg6SSwV6PhfirBYd2cr17p4o/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sds6w9kI; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sds6w9kI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrMjQJHcP+QMFJZRW4IJytqpJD9ZahvchIxwtBxmAwlhNBvdwwB5Cy+RP/PbapADZcIvkmjRkRJq44jysN7taFi4wGIf2lybmX5WOztiWJSvmk7WmfelpuoSFliVqHJrB17ozwU6PodwG58M/YjlRj4TqT0DGLoz+5+60BRJF0f0ICsictY6y/LL2eybekjG+wcJzU3C+vS/vVB3oizwcWYXsBM+/IC0LGwoxab8W2d77acvaK0nQfyz2MFYspMwHrVcz2+6r86eoFoSVoNk1RTtaX4LyrSaeouQU+1n36gI+devm0tPq5BdaJfegISkvgfiG8HCVfMTN4rCCmutTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNh4ySPU5z9pTPk69NU8Gf6Yj4XRSwUEWrDgELdiraA=;
 b=VSN7ij1kzd6/4UACS46Rqg5Ayljc1h/Ul9KSV6KwEx0fM6Nn0scI+mnIfE+KNq170eVLBozqCBRe+otiE+lhPhYZDzW9Y0pmqsNxjEPqlpID2tNDubOzSzMtoCMkREIyqZaP5mn35JLmLDl1HWGBBh1lQxRS104uFKsCUEgXFWx6xSqA6VdFef7btDb5YJALtUlrmE7+MDWKpWeMN2wSR1iWFZOVEoF94f+s8meWOQa/Gq7WQegcGz4b4Jy7SrR0P2cGP3onFIAByoptsW2gL+oMbxPGsBqquAetl1dhL3995pR8ZocEmMVTMftq0xtLA6ll0ToMdFOvrkGNaBLlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNh4ySPU5z9pTPk69NU8Gf6Yj4XRSwUEWrDgELdiraA=;
 b=sds6w9kIzVLNqzY6qaL2Q+1h4j0kJHmZwh9tm3XqH3oFPOu79HGkby5FVa9TsLXZMF0J/IjeAReOzB9Mf86OUQKzujJ+mgQCNSXlhnNncszsgBUHgwzLzTzHbGx235hOrQhI2yLqlUeqcxgQQvGvCB2gKN3Zy0RR7sIRcFMUPT2427H0Abw+fHn04I+37fgjuin2vUostAvt4Oyh6A80hAu8DTfuFv8vhWTxa00Hvi1Wtsl9Ui/mgxOy0pT+R8mqtDXQ5EJw9P7xaPvspJlZqzUD2ZApTD9Pj7LwaWZVlFxkCqOGmH93vq1VeXilEuJiWRMDGGr7jmMPIuBML8LA/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:03 +0000
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
Subject: [PATCH 04/12] sched_ext: Avoid migrating blocked tasks with proxy execution
Date: Thu,  2 Jul 2026 19:09:20 +0200
Message-ID: <20260702171909.1994478-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c10b16-fd4d-49d5-0ea6-08ded85e279d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UCTLhocy5w/IO5VHaY6vZi5CM8LP4kPajplprtyT+8nuIC2G25AHEjMKBXVbBB70ddTFEw+RIjr3w+YGEOo0ANPTv/ceEVETjK8PcMIz6nd6+G1hvFvvsMF6XtTJ7zh1nR36UHodSgyKCIBhU3wUYKZMMx5aM7LWvYAkAAomdcP3c5tzBGwr7wTC/ahgzcYNiJHfgHhrDo5EC1ZVsmmB/YVl5AO+Sj4geVN++fWSnpzUJvU//qxFB5qGJntsZ9vQDD3SWyVuqU8ngk2fcEf4D863xGqiAZ5CtXJTuOzPMZWvHPFEEsehSV5FMLpBuRXA6i1jJ/7T/ZUKCRlw0VU2+Rqkxy2Nta+ZQFlcH3BFVtNQvUjGJxGhsKORWrDvVKYhbIdZy8KE5jYhFfn+QdjNmUYxU6ud0c7Dg86QSY8sGVY2t2qhJvhUV0Gu5EZzuFdW8oUAjqgFSHv5ywFPJvloCMifu/tlGABsIxYMyKk3EvFYcpYkkf/6nF4aA/EW7fuLNlIlrdBjNPhT44zDQpP2hafaRKuMTsNlSZKjBGK5SGLMDtY3orrhx5gTe7f+GV6rud+I0llwBGLXfKyzUZYp5aL+x4X8x9OhSNrR92v7KMfx/rSQJuUQy7/pHb6+Gl4ZVvAgnf+vAv4khDl0460Tf9ZvTdsjNyFEODCr9fjB5pY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPIx2xg/2X44JuNIQ6ZbQP1NQ/GRY0S7PB1wwg14s1a6stit0jrd1gXQ0RUF?=
 =?us-ascii?Q?ka4OlhQmfwT6LFNQKeUWi1/4CXpTBbxsimzR9lMPK/0Q/MSTdDUQZIM7y0IF?=
 =?us-ascii?Q?ZjLc6BFz6fE5PRKeBUMPgtoTYg0u7IQQzkAuuPI4qFJrvhB/sk4Wjo+JGPF1?=
 =?us-ascii?Q?fPqr1MtCnXg8UHAaethwA6N/PWZypV7f/yeMbX8wGOZKyYR2A5Qz0Ua9iGCD?=
 =?us-ascii?Q?Ac5QEg3SI2hSBtrWv4HrO24GEb+vuavN5xnvmybKqbN90wUSwiAkMbb4tQVH?=
 =?us-ascii?Q?J2OgD8iCqVoU8M72kXmiFAoDhq1tS8wRklAdgVEQb5lLAv+7/fXseTNV3bt7?=
 =?us-ascii?Q?OdR/97HhS5zKGdLTqK0briMlOX94LNujcBU/ubu0OmjmPwrUlcaFbdvUMmn2?=
 =?us-ascii?Q?zPa/OxGBeDp4GSEC5kSLybbYqZ1uFVPx/byp2x3Fut+eN4yXBXLkoYUNQxIw?=
 =?us-ascii?Q?PAfPI8BJdToOrx1ttU2xxWqS7DnnjiXzjqhhoMXMJ6eIrj8nmYNAsl09UgmB?=
 =?us-ascii?Q?4bizklSHoS/yceJ6TBhu9Fe52enk2s24dKfvI6aQOT1vf8rFaLI5EJi9lAt0?=
 =?us-ascii?Q?8cVqTjDi+XYbIn0RnLmzXp6G6qW/6qouJWqZo3NwtCOfbHCjzuvzmBqbBG58?=
 =?us-ascii?Q?ppKTWkhjmrqElfEZbT7YB0ww9iCXHWY+I35Sn0AjvaSjzfgw2/l7sB5HeyJN?=
 =?us-ascii?Q?61Z87hqLwlpKxzlAfAseYZru6sHlQE+lRJrHkwkKCi8zF//4SogHUtvcc3Ks?=
 =?us-ascii?Q?a6nS4dZ5gRQDQqQgtuLGXiY8xEd8iDg3r002dSyFrU+cH4fyr9UylkB9BRs6?=
 =?us-ascii?Q?bFo8vD1UaANrtplcnXsTsyjf5tjmbsof4/VApPffOfRi+V8L74hBow6CkeUA?=
 =?us-ascii?Q?b+mKVb4UAr1sX2/6a/M2yhsbvXhB8cy5+zedgbZfpAtAo5ggj7rZkUluUhYD?=
 =?us-ascii?Q?T5xeof6uKIg30R78GLYZRCA82WaGmSx4l7F2j3KaKijizHhXmJFN1Diw0J1q?=
 =?us-ascii?Q?8g6JIEczcKoaGLYAH3uJQT/pDpEkPFi4bVcta2LihTyLOoNHq/no8yvkyPM/?=
 =?us-ascii?Q?iRHTwTujGJfZvaCgNaMCijagv5cBK/ZvSwdc1xxruwa1FIUaYJHacQSJaOPw?=
 =?us-ascii?Q?XCTOCgCamI+MoAeRzwknvnhni/4CYPliD1VHQPMG7u69Z0nWwboJ3tJUgK7Y?=
 =?us-ascii?Q?hoIlQZ8EAzlbvSoUtpR0/UK9ACcrtnboQjkr8El4Fr1bqb4awsdvrtFrrv+M?=
 =?us-ascii?Q?qWLK1E2CmzpGdx7DBN65wKSvc7/Zh3aVM+00lr6wTblKFp+2JHjyIpvZBfZH?=
 =?us-ascii?Q?7+jYR4260AAxTYz+kxfhSYcComPDmkdrq8QoA5pxhsndPJHSXiRD4ea90sMj?=
 =?us-ascii?Q?ce7KbCEFvpiEDxv4iquJ2q6TeXnm5fWvmrHJMlORr19T068j3wPgJPJlquQs?=
 =?us-ascii?Q?hbApYWfRd/xRJQEps/Kr/l0guq1NAl/M+q9ZNvnhI2FeRZFG+OuOGqDOJB45?=
 =?us-ascii?Q?uvkpdECqfBulgVvyEZEwd3UDEQ+eQ7bfmwARxEANziLInZkIYsTSWFhSAPMz?=
 =?us-ascii?Q?xEaah3zNEKAkjw+2p5h07pg2ejF99n+Yv9z48V4y14zF2yTyAKVPsuIUOQJs?=
 =?us-ascii?Q?wrfXvOlPes0ogRf3KEP2pIDV5grajRK7bxYKqUJM7TjNrAKo/XqB9iukGnnm?=
 =?us-ascii?Q?DQ27yFp7g8eVfHuAituTv+L84ZeuR6cdLsh7C91HusBB671tBHj6eB5hGry3?=
 =?us-ascii?Q?hKEVGb+B5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c10b16-fd4d-49d5-0ea6-08ded85e279d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:03.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWtU2Xdx6igfrbPQpi3ev05X/wMMj4+i/WRbCl3i9qFSSH6afLVusc+28OAbLtqz84UHbLT6n8SJbTMakR0Wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex blocked tasks stay on the runqueue.
Later with donor migration they will be migrated when necessary by the
core scheduler to boost lock owners.

Don't try to migrate mutex blocked tasks, the proxy logic will handle
that.

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/ext/ext.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1588565050679..9a672b9a55f6e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2150,6 +2150,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Make sure tasks aren't on a cpu */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
+	/* Don't migrate blocked tasks, proxy-exec will handle this */
+	if (task_is_blocked(p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2784,6 +2792,23 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly, so pick_next_task()
+		 * can still see it, find_proxy_task() will be invoked on
+		 * next->blocked_on and either run the chain owner here, or call
+		 * proxy_force_return() and let BPF make a new dispatch decision
+		 * once the task is no longer blocked.
+		 */
+		if (task_is_blocked(p)) {
+			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

