Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112D348C46
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012792; cv=fail; b=EJD59XpSGWrxcJhh6AF+fwEjj0oNwj0FtFEbqdUpbeSa0bTt/sN3uyWXStQp3Nkvrw+1sKIZ3J96cE7tt9yQ0HCoUnRjRVPNUdA6HlrNUn/fcU9o82eC2J2nxw5HteyGMDRssSqDBeTB0ppBGfahN2k22EiVzysztShy/kmqY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012792; c=relaxed/simple;
	bh=2crHzDvJQ6ZDwnMwFvBZbatBKQoGxUD4qrg30P9RU7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxnBkxtvdREuSQ955c9o1uFtX08biZwO6O7Ibia8xEckUyrAyM6cfQhl5n6uHN9GgX+kqrV1CcCGQhui0sFRmy3TF4N10W0FWumwhDCHmpDznnVZG4/gCMOQ1+ORBRKI5HeX3I17icJVqXDO+GO/l7zp1u7L6y82wIeZ31Ax+FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkMkrSCS; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkMkrSCS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIoaeFnuf/LNe4CIssuc0iTaHdriOSXuXjtcDMe1FRLwJBvyyA1Mi/L8gGcd+qNgdDFa/RGaHZt+BfXpRygqrGAGTZBxyWdU1Y7FN6LBhnzqfwOmCZhb6QoPnt2VIC7+tb7YlrYsQL6LCKHCCXcr2+H0CBPtIyT2dY8EWsm3xLc6/D9V56OwzYowDqpThqecrxKH7D0MyXIlfehkbgqUg2Dbl7opdG2t3QjMChqqW4+oFqLaGTxBpBfeyEE7pSMcc2kiLGPXaHomO9vCTOEhwxBsTceGj9Ls4g+jxl+jvM6drePP5NhNYUZmti/JtFlsC7kfrq4Hbl1miPH71bV+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+aOFQJvH2EEvexQyZJQnF87mCXfWk2FJZBIhBNIbH8=;
 b=lRKtROwwrkiHRMRQDauxVCM35xzrK6loaCBSDjCbWqToR2S8MfggHDUGfnHKsk2ezwPGt/wlwCo/N59pn2Ns2No09fkeuSpxE9UQD3dFlOCwKEgKiARoukm2104/roTDIL7yISJwljsT/mUT0IFWV++qclKkuf7/J8wcus0XvAJQTWM+sT2XOWypZlqZGSJtMAXQXeGauxhkKAMKzegpjstc25zhyheoZ9vAV6W2OxE53vR3T7gNFjBxTr1qmsHjGtSH0hFUsnt5ywEb7k91E013njPFxLK1HDbXcuglZSbykRqE40c4DrIbF2jd++aqI681jsfjoaDvOB1GMG8xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+aOFQJvH2EEvexQyZJQnF87mCXfWk2FJZBIhBNIbH8=;
 b=SkMkrSCStvs0SPrMfXML6UTUmDmOCnUA+GqMeT/gJ3oKbU9vLwp44YK7E+jtsquVZGL4LG5tNZQdjt5PBoHRPBVUDqRYdFOs4u1oCqUXBEBlLX/rkWUcKQnuzOPr4fwRJ1b99EbHnorZifceyCFrMl3d8KM08x5+2Y/P1HsGoQ77ZB4VOEKEnszfVO4kWLl2PxSe5lZ+l1xKLSf5Qs0kjc0kkmwEU+LS6YWBSY4aFPncbsS0KRr7V52fo8YI8n48NE/hTOGuPUNsgy5db4Fof5BkZHflgqEZG4KJowWSkJ+R/fW44YloC7jvt6xQ353S4MMYWl2Tyxk3hYz38XCDmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:19:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:19:42 +0000
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
Subject: [PATCH 01/12] sched/core: Skip migration disabled tasks in proxy execution
Date: Thu,  2 Jul 2026 19:09:17 +0200
Message-ID: <20260702171909.1994478-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ff1a7a-1f93-42a0-6d93-08ded85e1b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|7136999003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7nOLl4wndRQJt4kUxjWZehYWEGx11Y5uxZ62i0BS/IH/w2iSPcuP8cHBjISrJ7AdjSDgB2EvX7UuRBIZS8dUymx6bEwJzZAbgheVuEZloi5EgXPVoccQVYzKBlzLYfKO4LZK82xieISrwfFCnxYCtFgCnDECLJT0V+QB8fowG5/yEpZ7KEARxyZx5hP83LSkr+hUtqtLR6EoBkmuUX/GR59Gg02/3NLbhd2IaFpU0/x+41guuq8PMdl8wIww1LmCljl1UHZyGS4oeIDaEQJWZGOjYLUy6tVobwRhdPtKsNKO47mnwHC1U1NgZofnHHj72NlK9zeH+SwsbRQHe372JMPSpvLW8+xOSNXMuxIHAnmPTgB84oUycFbF4MRh93Gf4sTJ7vXfKGcI7HYh467dnCH0Sxb5zSgOPyyE8bhnm6PrVPpueozGcNf0umSfEYb9L5//SyQMLaT5OIlH2Ac3G3Q3gLYBG+4IG4fRLAt/QOe2j8RnZH6Iw7N9SWBNOHBApHE/+uzfCUdoPdvD11QMYW9B1UolB7sE0MQ2kimnT0Dick23heV/P0Nrh3Fw7NtzUTWek6oYV4xiNe7ugqRNGwytPtK1ANp0P90AdSH7rUY7eEju5KJSRRT8TYN8ALXrjz7QJbfnPBgRsvrpALRI0YB977qsg8b/OnyBXH+wJuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(7136999003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKMHa9jt6xL0EjqksqrIsyWnG1UjX+sRX2EblUxs3tXeFyd0o+tNjbdHxn+Y?=
 =?us-ascii?Q?xhRrDee33wDGzNDKJAg5wSZ+Hw1DERgR7xheo/EjuMSMGvwdKdbB75mpt8pF?=
 =?us-ascii?Q?iGuQi5IQ518y6BXebKU7pcU+1oEdYVBlL17Xqd3/dmlx6uu72oYdEZIK6zB4?=
 =?us-ascii?Q?gfs4fpAyklVZ+97XLpZLLbZff+Qo0Kz677MsB2gesrD1QT2JtdBmVmtY+yX8?=
 =?us-ascii?Q?v0cgXHbYR4jN9DDuyACdleAo14vneEU8fy9T4wWR2DAkgdPCXrZAE6Ued1My?=
 =?us-ascii?Q?GtGw8gx9/SFPUwwjhH19metbAVlnsqipKHmNxxGSnEuOlzRYGVmPSN7D7yOZ?=
 =?us-ascii?Q?XOjuyDOmEBmNFjLs0Rnrdx0fz7SHZ7eVwhEg0xiZfvUQzuTfO4ZDhN4hlHAq?=
 =?us-ascii?Q?Pt1jqfPxW2dUeeCUw+6U+6BDd/b/cohlvMngyDtwBHdyKfL0t97cvgqtu2nh?=
 =?us-ascii?Q?1XwzULHxDvHHmZnLmEZPD4DAsXvU5brHRZ+nEBojhfLVzL9znVorU8REiGnz?=
 =?us-ascii?Q?0jFZDWNmljKXm30RUVY+t1KotVdtmcDcZRFktWw9sZVqi2bBcWf+k8O0aIsb?=
 =?us-ascii?Q?nmj41n3M2Xm+j3x6/mzCOxnATVb7y2JB/JO+L1dMyDkBmphr941MtGPUJFtr?=
 =?us-ascii?Q?unvZgzT+g/ye1xV2vMuwzpUMD9B7eEcz89qiC75hLGTb7E4TAX1CM4fey5Qm?=
 =?us-ascii?Q?DV6Bc8czjYM8ruesa8fvt7GQzayQStxMayF7jmbiy6p/qe/drbHdsEP9WNqI?=
 =?us-ascii?Q?/PutgqhzUZWmtd2nhkRDW41Han6vj6wuHuX+5MG8gZWuJGzCBrlkEbByh8ZH?=
 =?us-ascii?Q?iKUtDSHMaa5cqV37+fN7d9ANyyr8MuZZ4KjUpDSsuNAFZiYD/yF9Q+rTiZqy?=
 =?us-ascii?Q?E5sWE5dFPF83upvIybiNXoVXwWTV0DWIAtlt+TBLiyMrycTIhRP3XS/ypjdI?=
 =?us-ascii?Q?gs2ga4Mj6iHMuNyvj3z31CcwXSCSLu/5JE2yiqQqnsh+3xlElz/JcsO59MPz?=
 =?us-ascii?Q?mCb/6Jbkbnh2HxUi3JEJwTpRpBcnu/6Ilwq8XylAAcGZr0G3wgaePfWRgeOq?=
 =?us-ascii?Q?9Znio76FEnLxofdw3L917l6VFIkndtv1UAsA2sntMDOQgXbwMIOTYrKu+X5i?=
 =?us-ascii?Q?EH7s4KqMSlkoh/a6oFNDANoSUAtrlEAXnyzYvTmMh3asX+IQT6JgRGOriHcI?=
 =?us-ascii?Q?aJGiMbLKuNcBAPyhrm5aHRhVuBNbYidyu/Xxvq3cOuT9SloELjdxYeYAVxA1?=
 =?us-ascii?Q?uXWkpHmspwYu1Nen2y6qwqATH9YTyBYVvy7aSvSukzpefkNJeMivhHpKA8rg?=
 =?us-ascii?Q?3M+WwDYQyGEX1KEW1hDDs2C4bzQzFxCr+J9Jh1hFf079pkt75260O9TmkEb0?=
 =?us-ascii?Q?pc1v4Dbd/yfUzxtNMS2+lvAsj9FfFCt3rK/AD2UZlARo5pVQKyj+9JVVmhWs?=
 =?us-ascii?Q?ig/KEcaksZ1ppkB0wme2zY3PrNF0jDRlZOn3dAW7qvVC90aoNuJCwPWstgwt?=
 =?us-ascii?Q?P5+OOC7kHtS9JwjQ31v3wjloo19Ihr0Qm33Nct16EG7O86wKO3Nq8OBv0Mzv?=
 =?us-ascii?Q?HoF8VPmpwy5r1cEyu1djltRTqWFeOGvecTBDPcE/FgksZy9Ch8Vrcl54NeXB?=
 =?us-ascii?Q?uqudrdb2kklFPhZaXqSkuxiJIeMAHTUfPU7S5zvRyZPQlWLIhkDvCdQVIc/D?=
 =?us-ascii?Q?Rg6nPoszeSRHd6K07Pu7NM/0Xd+9OXSVGLc2V3ryNuctfP8le+GWcSyYvr5p?=
 =?us-ascii?Q?J1RSmaC0bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff1a7a-1f93-42a0-6d93-08ded85e1b14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:19:42.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Csmq0XjJ2qSbK/omezpIzznDnsdMFlxKZM4dlEipfa95jDLfQVE6VrP/JsK4yXwfsNkHV798IzFZ+W6XgxO12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

Never attempt to migrate migration-disabled tasks or tasks that can only
run on a single CPU when switching donor's execution context, preventing
task pinning violations.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..8a3eecc7caf5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6936,6 +6936,20 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 */
 			if (curr_in_chain)
 				return proxy_resched_idle(rq);
+			/*
+			 * Tasks pinned to a single CPU (per-CPU kthreads via
+			 * kthread_bind(), tasks under migrate_disable()) cannot
+			 * be moved to @owner_cpu. proxy_migrate_task() uses
+			 * __set_task_cpu() which would silently violate the
+			 * pinning and leave the task to run on a CPU outside
+			 * its cpus_ptr once it is unblocked. Deactivate it on
+			 * this CPU; the owner running elsewhere will wake @p
+			 * back up when the mutex becomes available.
+			 */
+			if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
+				__clear_task_blocked_on(p, NULL);
+				goto deactivate;
+			}
 			goto migrate_task;
 		}
 
-- 
2.55.0

