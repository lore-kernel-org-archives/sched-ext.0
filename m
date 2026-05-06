Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A54921AD
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089629; cv=fail; b=mKYJoK5XIYzWMePy4g2wtYdkJvuOtVyWRvivUcfeHzBWbu2vhwB+yimh+mVIBUi2llWLNT0YfIY+MBmf6uBzqGkX9ZwEtBY9/c07sS56sUKPmPmJlKTaShchWwYHjEoBNlRCZTcqLN+DcsMl4xlkoFL85RCqk5Gn68r4PUYt25o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089629; c=relaxed/simple;
	bh=3e030VE0QY3zX4DejZAvjQ5mmJMWWVaU4g1feOTzVdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B8fKDUGWBo0TGTyxgHAeYvnQeBlnhrnZXgJcyDT0ZHX7Y6xSStRHzPJBItXgY0mMYhxNym0suUJ8cTEwfXkl1LQlB8akG8Zr5eI7Ejc5a1kAQMAYRgi6F/fTQ8VHpBvKQjzG5Wm1zaEXnwRnb0g0UxRGfln4fNuEXh1TZjppmPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgyfFhic; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgyfFhic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csmKLG5wh6+qMWj4HnU0bjIdl+CcWgK2rlzemCUYFmvyfZkou+ti3phBwb0vPsUbGr5Xjenk/gKphtFpMV3ubI74ya9RUB+I1nn5wEBLYy5V4YfOxTAf/Wyz7cs7NBR8jXq0bhi6vpB1AAsA4nvR1tLcVqhgHj+lAvKENjkBSMT5LpF/QysYJVSyHE0TAC1hX1GGZ61gSVK4KoC+SZuSiQA+dNrLhilne9Mow+ZcnvGeXngGHbeDXun0DaDYj2yoIuYAYEhlP2Ga7fT6orhgy6yxAinnNe4+bdZHahZiouAGBgxLJTU7Ow8Mj5hzTH4e9Mdiu0fc3QvpNl6bgTnkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFgYFfH28KPWSShjbsztDEOJxOUYwiwTIYmD820FdyA=;
 b=ujdwwv/vxkQkBrGnMB+s9YBL5Kn6+8WPUKJs4t54wA2UNYvPzk2YVnTwgLiFTR3qwhDzBRmKQYcOzM06T5wo7V2UBIbYnc/pFvOa0C89TiMokT+gERcrTRF0ouel65WogQyFjl5lEOlafpeRyHy7hxsTOZJxpYgxE4fxxuMviFpwlTTr/lfpajnsW78MhZyxnjCi2xlgxLjTomje0pHankJhn1Y+YdoASJdwWwK6gG07an2IBVMiy5ZnMgHw62xBRRxltiXAn+QQn39Wit4UMkoEyprbY5D3+WxY0G0rN5Z8HecnhjVXaIakQ5j+/fyD1R8BVNonLqbazelid3i/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFgYFfH28KPWSShjbsztDEOJxOUYwiwTIYmD820FdyA=;
 b=kgyfFhic79OD1JajO5PCURWymWV/KmT751SbkCXK4a92jO8vxRQdZGXmc7KKly+hrMTXIJ58a61+6+V9vuEGQEVe+g298TU0dUW16q0/gKrZyS4cZwq0mwAcYrYHhuAIPGzzM4fsrj8Ew+JSmJZo/1qEsZnhNlqil1P4+PZ2/3tGEUHWeeQ6YZUrjraV87BmaEK70zNV0Nl8MJ11JVmxIyNcS+ikfdj+miWPunUk0ujf+i2QI7JmisMct1UG/hY0Fon7v1zx5dPStltVzXcpHP5IjqhOohaVnSSZcliE84Af9xrNMVZE9ZkG/sc6akonW7GJlJUsZHOtLW2SC4b3fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 17:46:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:46:55 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy execution
Date: Wed,  6 May 2026 19:45:41 +0200
Message-ID: <20260506174639.535232-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e78cee-39ec-4dae-88ab-08deab977659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	1nSxLsQx+W5kprPza0ZY0iDFhTMtTLKsiYxlJkhwot1m5VllfPM73IDFSCMp0slMAIUEnWAHXkVmHranbCuAsqeTQAbF+o+DWKeGGrxrFkWDeVj07TLvZMO99rb94vpOjBrQCa4d+hYKioS8KOT9gouGEIt3YhdfN2H7yXsfRkwQj6FBe4iQ+6dowN4hVrUEvHc6s0GyAcAvJv1dYGmgoaxMJDLnERt5SxgFsCK89sUezu/DGWJ0ubzNYJ3kXzEZHo7y19McgoEBLOWAUsIrTF8cUKggArQChNwdy6J8ukK5eqwH1ydBXuaAwokJnite+qn4Oar4XemKTkfC+2Y0zhotYW3cyMWoi0HdG68rpJ1ccPmAS9RRTRVHX1/z7a/9u//UkIqxrCaeMdJk5ynMp7loe3xOUVKPAzoD0/7SpPlPARZUZPUFfHljRlCKeFKS0EvxEABiO264mTjB/zKtW1HEHrF8fUV2BanH/THPScSd8oFUGGr1gsgHjAcKcmEsZD8d7FswLBQgbFSl4iv5cP6h1sIHzeY/vQl8tIlxrE2lXfReaiQrZyNZUejq6qVO2QXyG2tJg6HQEfjJ0Nk+y9P83BJeg/UJ+j01nJLKG5pKBD5rBF7ORzTFbQuHex5ES7cvsR456G6JqtnwbLLScCaWkLfEGgmNM+geyEwKWbWj8xKxFYDkO/NZA43pcIzH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XlMBOpCyvGJmhKKxay9Bxfe9Zfhkqx8TKztlm7P1e1iiCz6s1uNvCHFg+Y6?=
 =?us-ascii?Q?t/sUBCidSJYUVQF6JaB/Kn50QaTMak3bUbJKCcVUFbcO4/i5U6LcrG0ThUiS?=
 =?us-ascii?Q?nGTG70cvvd090OASOygTPVVSBdGcCZIUs6DJy9fySTxFyW6+wUTo4ZohwC48?=
 =?us-ascii?Q?h4hVfGhoZavILiuOHnLZmLA6Z/y6cylnVgas+tWxrUpXZaTfvhh4EYUBjYoG?=
 =?us-ascii?Q?YG3AXRfRtBiv+VzOjRukwKh2zt65ASLPoPyLhJujZ5yjG+2Ddu9LP+PXpL9l?=
 =?us-ascii?Q?KOo5ym8fHeB/RzvKphlFgqDk/1oQNASiaOlIdJdZKKkVQ8de5TauLNe5fxup?=
 =?us-ascii?Q?t2vlofte4g/PQjON5PAmETJEVFjZub0gMsni8l28C4vmoJY9vfL0N8t4I7ay?=
 =?us-ascii?Q?hhJJvZGooZxfSINvVjJIt7lLzZPYn8ysH2ktWZbszlArrzeDND65SPrI/hm+?=
 =?us-ascii?Q?rGzXuXn02Tea7CKftwSmW0ohBlK5dQkNKwJBNbIzOaxMlVoN3gA5pgRyPU9D?=
 =?us-ascii?Q?f8Yyq2UzGXik3Dfen/wvy+HsuszC43DvQVmk1ZkUJ5xwHdfg/djtkRKGLkXo?=
 =?us-ascii?Q?rwy0kMrVR3rvzrLj7C/uLSXQJm5bUdl2fA25fwtau8faaoty0zFpxhUAmN5L?=
 =?us-ascii?Q?anYbrvebjHlg/LKGmcnVqTGn3FdmmkYb0Tfh0cY+6RguRPJEh3FQuBq6OU+H?=
 =?us-ascii?Q?7tOdyqavsnRLxWFkAEMzMyIpyknSVhOIdK0FGbyglEKWZq8FCcWr6UhlB9EQ?=
 =?us-ascii?Q?G8xPkeVC990OGw70eFZdjaNcdUIBCn039mg6GgH1Gwv/6i5k9Ah0XZSpUEfc?=
 =?us-ascii?Q?iUYM43VdChgIsyJ1+F0xo/XnK1HsKP2bEYqL65HDCXYngsPA3haUH3XTwJs3?=
 =?us-ascii?Q?lONG1YDfLdFXPgV/G4Jqe+gQR1b6N8qNRnKDhdkvIb4PJMJaOgey2Qq2Fqrp?=
 =?us-ascii?Q?4y7WRZYY3KnZ8uW+4ugvzsbe9Lx5TU872VPkk/7gwsA/Go8/Oy5iZm3PGfqg?=
 =?us-ascii?Q?vfc53cAUeNXMvZnWsHtSouJ4uW5opI1rjbonkoiYdBCtxDIQS8hR70kPA5KD?=
 =?us-ascii?Q?5SD6Gi4NJnQIc4IIZQI+Jc3+RBSb50AqKqP8PgQ+KWJbXx2Vk+trkmI+f3eF?=
 =?us-ascii?Q?eITElc/AN8VfFYftSs82QYEOOOOzqz6NiJBnU/tyntwa1/laDu4P9dLvA4yb?=
 =?us-ascii?Q?Ws4lgv4hqfLMNdKZZ95LP5y2r6rBMytXlBaTghXo9idcrE/JUgvIuc/hHOa2?=
 =?us-ascii?Q?eZdYGXnjtSkYm0zcnpyyvGc5h8lZXXTDBQX6n3AyV3EbS1fDRXJXp1uToXTW?=
 =?us-ascii?Q?viE861CWqQVkpGzX/wtUewT1oIG+4gVvq5lcpnoEshLiSrov38s28RGML8KX?=
 =?us-ascii?Q?pZr/McV++AsYJtrNFDrNoUypJ/baAuhUXKo+Ac6mQKlbJ7QqJMjtj+ltzT1k?=
 =?us-ascii?Q?FfSurcPF7k314Cc1+0ucE77X14cV17FJlXJAe/xMBz+QgJqVjOznILsS8qGi?=
 =?us-ascii?Q?TUz/jZvlqLYQz1jQaYUFTqiIfGMnfuqs+yKzp+DiIF4gXPNfBn1Tjo8UdXR9?=
 =?us-ascii?Q?fWdBtB78tbD8WCsO9ZgQblrHBf0aKlqPvOm0Z7+kyqXpTCPf/Q3L27Woc6wM?=
 =?us-ascii?Q?D2lYoo5A+yO8PdwBcYLeLF7ILaZTZIbHbpf0mh+OlYj9UDUGYL08OnYPhkKR?=
 =?us-ascii?Q?IxSx/QuBs2qXYSP9JPqe37F7zogMVde+pQMKi2LTPpQUVQe/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e78cee-39ec-4dae-88ab-08deab977659
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:46:54.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOzg8+QLKbc/SeInnLU+SSjgUNT8Pk41hptNx5kXOHP88T6PTKcRe89UABwLw4JctDFJYHp87GLPVffFEombxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

Never attempt to migrate migration-disabled tasks or tasks that can only
run on a single CPU when switching donor's execution context, preventing
task pinning violations.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da20fb6ea25ae..75541e5bb66d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6793,9 +6793,13 @@ static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
 
 		update_rq_clock(task_rq);
 		deactivate_task(task_rq, p, DEQUEUE_NOCLOCK);
-		cpu = select_task_rq(p, p->wake_cpu, &wake_flag);
-		set_task_cpu(p, cpu);
-		target_rq = cpu_rq(cpu);
+		if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p)) {
+			cpu = select_task_rq(p, p->wake_cpu, &wake_flag);
+			set_task_cpu(p, cpu);
+			target_rq = cpu_rq(cpu);
+		} else {
+			target_rq = task_rq;
+		}
 		clear_task_blocked_on(p, NULL);
 	}
 
@@ -6893,6 +6897,18 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 */
 			if (curr_in_chain)
 				return proxy_resched_idle(rq);
+			/*
+			 * Tasks pinned to a single CPU (per-CPU kthreads via
+			 * kthread_bind(), tasks under migrate_disable()) cannot
+			 * be moved to @owner_cpu. proxy_migrate_task() uses
+			 * __set_task_cpu() which would silently violate the
+			 * pinning and leave the task to run on a CPU outside
+			 * its cpus_ptr once it is unblocked. Stay on this CPU
+			 * via force_return; the owner running elsewhere will
+			 * wake @p back up when the mutex becomes available.
+			 */
+			if (p->nr_cpus_allowed == 1 || is_migration_disabled(p))
+				goto force_return;
 			goto migrate_task;
 		}
 
-- 
2.54.0

