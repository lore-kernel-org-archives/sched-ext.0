Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF719399342
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995613; cv=fail; b=oBqR17H0Px/rT9Z/wTx0wAYsKocqDv5nPXGH6eh7kCNwFZ6s+uPbGSj83H6LBeijeuzcrOxznfNkcfBIbLVveO4qAB3Xft3uXQbf0IeQXiudAlVtSgjOoWUAZfp33uLa4MC9IWpqDma2HB8RrNh++7uyGuCB7XyFE8hCT6drH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995613; c=relaxed/simple;
	bh=QVt5OVXDi/coXzDDYD3+d5IpqoSbupRfQBOv0Rp35Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izQq4Yih0feoa6DPLEKAO9//aAnPRG1Xj98rkI2Mtgtfc1Jr9aYC8MVtlbtCLmuD5dLiAyTQo6gXbNQnZv/xfe8cuZrrXOiA2oKhYREKEwXy20aMaeC5V1zeEYHwwHVG7iYIUewOJQuNRSXDsdInxgPl8Q1sdwgrRfPTpycgtK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sP6XmQwZ; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sP6XmQwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcfvV8VyEZe8+mMbaNLktXlbtb7A03n2YffhSNuzXZTjlkrAgEpjSmouIQ7BmTfPy0tnfwl76eX/9WInuQ29dIoJDfHE0y59d3Psl/n0ESIDecpSWZsvr3HSuv4JXfqptFiYmjWheI+4dWEPUUp0HI3L7U3xuzAw7L94K905UsX4b8YOq+BL+vnyJnzBAPqtadFvfO0ehSyrxWmPu2XvvxvOAzx36pvjAdkMGBnF73/SV6mC2q1is9H08hF2vn4nvrPFFJyE8FhsOnUPDclZUUaj+YSu8NRNYLiJ/utT+5vD/EAV7grGvH901GZmTf+k0P+vcoSvtKWmsZEbFKYiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsTgxE+vJNGaggWXwM8NlUtZsVMs33StDYeCoopvGLM=;
 b=C7PoQpiePRiA+E+/CzDTWHIFIx8iq/ZtwKPRRNnT+ytC0Nm/t31K0WqWcI85dZKMkvaTdWb4AqcGnf8WgjyVBSmZnz3LbNZNzPsUzbmjQmHQYU8I3XvsWAtYBsRDHFo2bzmI+imlYciW7exiRGdnBcBgEQbxNJlgRfZnx0/UBkn/5ZYf0HM+Y7693qXYbIcbFcCM96cShqo5SgYWqV5+HBdr0ifSqC2sUobpwgw79IGQUnE36gSCdWc1CxOwSOYlR9Do4ycsGt3dhhrEMrTFTSlKjqTLvb1llWNLFCFhazReuaXtVB615rJ5Qe94U4UfcOSqLN0iTe5BO3VH2umPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsTgxE+vJNGaggWXwM8NlUtZsVMs33StDYeCoopvGLM=;
 b=sP6XmQwZklXeIMHPFNGvoEGjAv229u9PTJG2zM+u+XTdrerPbNtg08eyMBnjfs0S+kySL6vxr0xVYbQOOQ3J2iNiniGyS/dURb7EGLyY3nOqjdiwxXznUJyDembFaVCWy5eWTScQA1dDfV+R7KsFm+4Q3vUUa3IUEVaR4cjFebo9G3wSvBqUgGSyB8FGw7L3iNKuio4Km34o1D0s1yqem2tqk9+Fd+SmGvsyKDU4fySegHqJNJXEn0WpYtYdTmCpQkjHQrtwTmmIx80IQwNXS3jqe6AQpYjFFGWYusk6lWtvJLDiw8d8UAqz7nzNOUzvHtQ7LdGrblwHO+NrctwQnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:44 +0000
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
Subject: [PATCH 11/14] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Sat, 25 Jul 2026 18:04:17 +0200
Message-ID: <20260725160513.57477-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2dd20e-17b7-4a66-0569-08deea66b8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hn8pAk2/WB2AKFeedj5Xo/9AZiLrNjxjjxamZOWGsybg9Na56g6J6S9myOSnPvDR6tOtu4uc0TT7bxss6DDbjJ9v4EVzyZrQJTcmM5fzTOsWwPsAYl7E7BQHtCKHdQCmzUpa6Elb2sZbjMeXUwJXzqZBOjWF/LXp+zPvOTozudxj/RhY/iqzJoGlr38fdtGMc3h5RmA4Uao7xoZP4z2riRr+y/O5+6g1KzZT+cenbWuFFbFg3qz7BUG31slg3e8yPTL73Sr2LIJvjm6lhEVmfGDRA6oIMlxv20NNZfDipAE+eQ6u5CPuGn6x3FJRoFfP3zquZf0qNivx1pmDdmov56R8QR82yp4joN/vE+4VLWGXaWBorqO/jXHUqD5r5CdnDhTSKw4gqh5VK7Zu4MVgy2x4rg42PlcD56GJvD5Cyb/T4OX8vVefZMySCI37384YdS/I6mNQW+d2rYG0YMGrGCABfVS3bUmtvMYzzGQ5g4t6zLvyRYY/lJvw49PtztZGiz+/dcTmdgTE13CbQ//f/P+GEjD/BK5YMbj2geRekR33QvgLJmHV0cdV+rqP8DXZHeZuvfiKqDQpoPhnAIMDA3sCy0o4wHUSqCtb+hw2rFDLeabiyRXwVMuqJ2G9zGB2TiKWgmMnZ/6KXFw4bgxYwOJfPy9GVV1UqIs/dwYg7mY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LoeAG6voBNd+vwfQtyJP5Br+GB7rFMJ1KrVb9lLTAeJgF9oPePmswqzxxIXI?=
 =?us-ascii?Q?PmRkXKHKzld0scxtacM6ThLMJqfY5IlmtbJ13pBfWeayeYMZ5I9tmuu8O2ej?=
 =?us-ascii?Q?krs33UzbtA2PrEkQ1nAVF0V1GButDPVv/aATerlqbAVt0hmmDPNOk05rnWMY?=
 =?us-ascii?Q?HaxYqi6PUDQoW2npwdWLStw1fnK3fQat7pzEeTPrIP8q0gNqvNQOjP0rySwD?=
 =?us-ascii?Q?1/kQgzDC5H5pVwmS2cWkbE27wp23Vig49H+asZgQOw3+tETg4s3hH4zpqt6j?=
 =?us-ascii?Q?OdnW413PWeuB863NOJ96vfsdUyHgKc/eCbIpXNynQFxm7xjgSwIrMpTq+1UG?=
 =?us-ascii?Q?FtxdM87ZVicFpNxW142ESZhaxjrtYmlNsUhzSIq7ntx+9019lYOH1kvIcWTR?=
 =?us-ascii?Q?aVrYaE1nI4bNZnI7PU1HrD2PDHL71mxfmV7BPGhzG5te5Re83jC5cNJqdE4D?=
 =?us-ascii?Q?QXUQ5lCTlQL1S3Gf15cv75RuygzWAbxPYMFvp+TznUQVRqGKSFD2j8e1bFbl?=
 =?us-ascii?Q?DzpxRSX8XLDdXMr1LHlBM8WUcDcSNwBt7AfyhhaJdbk7Nvlq2kcjGZ3Ski3t?=
 =?us-ascii?Q?DrrMmXkYWJQsX1lf3O+LGvSgpzCziJ2vi/DSea0AV+8C46Y9m2x4H2OYZF9g?=
 =?us-ascii?Q?FkwyVlrIedm8DqvUkWX6SQSWLVTtDx8f7MW0s8mu21dXidkyVosVkjDP27M7?=
 =?us-ascii?Q?XGaXP8OYz8QCSS7YQcdoVjwEU+BQgO6PtyMYkq49Zv7cnQPAfS/6oBQIF9QF?=
 =?us-ascii?Q?L1Cq2sD5pHRDkh8nbIvQq2T+fnQy0LUsdLrs7dmz8H3JoY/QqAvMV8s63QWL?=
 =?us-ascii?Q?VDdn7kb32D3a/00ZvkSq0+I2d8JX7jytTJw41m/IA/yzACnDJkt5LeWs3JyQ?=
 =?us-ascii?Q?3HRp6iIuwhBrrtQWZbbxUA6aAyGckANu88hu3sV+A/nXmm1UrDj1Ipt6OUuA?=
 =?us-ascii?Q?qj8idBi+MVSt5uDaXwge4eDwIUJc4e3mPQ449Navpn11oeVi+vAK/NWsi/io?=
 =?us-ascii?Q?AfBHjbEnBhAiGDKL+IMzl3yFqwgBgdZssB+zf/qolInIzmLzRcCaeAb61Ac3?=
 =?us-ascii?Q?QqBuzL1YogBQCpOh9OLJbmOyKzB3Ls6N+86R8grydVEGQeHUaDbpPWZOufuf?=
 =?us-ascii?Q?QKEf6YSXvgpEV4obB0x0yx/ydqknEXr+0jfND0yV1bu8MOCvj0X1/Ewa6e54?=
 =?us-ascii?Q?0gILm26Wp7yQsByYK3RFFqYFIFAiZroqvEc9OulbipCsQMRfdsqhhVP6uE6O?=
 =?us-ascii?Q?mdb9gSyDrzebGziotQ05IZaMddQjfMiu7jGcm4w813OSAEH5kAv7I6OBNDCl?=
 =?us-ascii?Q?/cCnFqq8OHvGZVL2RdbPQ+bzYPeAyjITnVEcYiqOEzXfuce+aGrsB1qBU/Ch?=
 =?us-ascii?Q?JVv/anjrgJX+gQxGD+/F59s18ilz7yeOJBRpYicGnagjClVCAvKRFA6WDx6k?=
 =?us-ascii?Q?Y2Qo7AT7fRw/V7oSzV8adqWym/ewUm4Csbb+JepXUmjW1dS8PF0LKMMWFxVQ?=
 =?us-ascii?Q?5z7jg06Is5Mdu/8i+xAN4KyfB0TEy6QbsTPv26JBXIzvtG7TB8uD0/PBj2KN?=
 =?us-ascii?Q?8lqsuoIMVJq+VNBbKf0WHQaDF31ZraIPvtSAExyd8nwZpffYUj+dEC9x6dCa?=
 =?us-ascii?Q?fBUUr2Mf6g+55jbOYVGK1BaH3AzeOioT2vuFRvIIOoMOItmiHoHThT6RJ+r9?=
 =?us-ascii?Q?LOWFOr2WyFC/DK8okQIkLpnV7wNftW7mtA3Eme+p/teReOOvn965RlnAC4c6?=
 =?us-ascii?Q?bfwNgCZBxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2dd20e-17b7-4a66-0569-08deea66b8d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:44.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsthORJGATDmXFPin21vSyiTl2PCGVyXiD+yZcMXCYMGbfIIAb6vY4f1K6sjyG/TPhzDGU/7d71jYRLho5jzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Proxy execution keeps a mutex-blocked donor runnable so that its
scheduling context can execute the mutex owner.

Define SCX_OPS_ENQ_BLOCKED as both an admission contract and an
ownership rule for retained donors. Schedulers without the flag block
EXT donors normally. Schedulers with the flag continue to own blocked
donors and receive them through ops.enqueue() with SCX_ENQ_BLOCKED,
allowing BPF to choose their DSQ, CPU and ordering.

Once BPF dispatches a donor, proxy execution may move its scheduling
context to the mutex owner's rq. This move is distinct from BPF
placement: wake_cpu continues to identify the donor's callback CPU,
while task_cpu() identifies the proxy CPU. When the donor wakes, the
normal wakeup path uses wake_cpu as prev_cpu when returning the task to
the BPF scheduler, which can then choose its next placement normally.

Apply the same admission contract across scheduler ownership changes: a
retained donor moving into a scheduler without SCX_OPS_ENQ_BLOCKED is
fully deactivated and remains on the mutex wait path; a donor moving
into an opted-in scheduler remains queued and is handed to that
scheduler. Tasks without an assigned scheduler retain the generic
proxy-execution fallback during the transition.

Blocked-donor enqueueing takes precedence over the exiting and
migration-disabled local-DSQ fallbacks, so that an opted-in scheduler
sees every eligible donor request.

Putting these rules together, the donor admission flow is the following:

    D ------ blocked on -----> M ------ owned by -----> O
 [donor]                    [mutex]                [owner]
    |
    v
 +--------------------------+
 | SCX_OPS_ENQ_BLOCKED set? |
 +------------+-------------+
          no  |  yes
       +------+-------+
       |              |
       v              v
 block normally   D runnable
                      |
                      v
          ops.enqueue(D, SCX_ENQ_BLOCKED)
                      |
                      v
             BPF admission policy
                      |
                  D selected
                      |
                      v
             proxy-exec resolves
                 D -> M -> O
                      |
                      v
               rq->donor = D
               rq->curr  = O
                      |
                O releases M
                      |
                      v
               D returns through
                the wakeup path
                      |
                      v
              BPF handles D as
              an unblocked task

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext/ext.c                        | 155 ++++++++++++++++--
 kernel/sched/ext/internal.h                   |  23 ++-
 kernel/sched/ext/sub.c                        |   6 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 8 files changed, 171 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 4d16c225e9af1..c0fe88c2a9010 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -103,6 +103,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+	SCX_TASK_ENQ_WAKEUP	= 1 << 7, /* wakeup enqueue awaiting wakeup_preempt() */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c6720e5c78dad..7bd1b801448da 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,15 +26,51 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
 static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
 {
+	struct scx_sched *sch;
+
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(rq);
 
-	sched_proxy_block_task(task_rq(p), p);
+	sch = scx_task_sched(p);
+	if (WARN_ON_ONCE(!sch))
+		return;
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(rq, p);
+}
+
+/*
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
 }
 
 /*
@@ -1916,6 +1952,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1948,18 +1985,24 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
-	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
-	    unlikely(p->flags & PF_EXITING)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
-		goto local;
-	}
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
+	if (enq_blocked) {
+		enq_flags |= SCX_ENQ_BLOCKED;
+	} else {
+		/* see %SCX_OPS_ENQ_EXITING */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+		    unlikely(p->flags & PF_EXITING)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
+			goto local;
+		}
 
-	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
-	    is_migration_disabled(p)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
-		goto local;
+		/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+		    is_migration_disabled(p)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
+			goto local;
+		}
 	}
 
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
@@ -2064,8 +2107,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	int sticky_cpu = p->scx.sticky_cpu;
 	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
-	if (enq_flags & ENQUEUE_WAKEUP)
+	/*
+	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
+	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
+	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
+	 */
+	if (enq_flags & ENQUEUE_WAKEUP) {
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
+		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
+	} else {
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+	}
 
 	/*
 	 * Restoring the current scheduling context will be immediately followed
@@ -2270,11 +2322,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
 	 */
-	if (p->sched_class == &ext_sched_class)
+	if (p->sched_class == &ext_sched_class) {
+		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
+
+		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+		if (!enq_wakeup && p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2389,6 +2454,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home.
+	 *
+	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
+	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
+	 * otherwise normal BPF placement may repeatedly pull it back to its
+	 * callback rq only for proxy execution to move it to the owner again.
+	 */
+	if (sched_proxy_exec() && p->is_blocked &&
+	    task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3018,6 +3097,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	bool can_stop_tick;
 
+	p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3169,6 +3250,37 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * The rq lock has remained held since scx_allow_proxy_exec(), so
+		 * @p's scheduler association cannot have changed. An associated
+		 * donor stays queued only when its BPF scheduler enables
+		 * %SCX_OPS_ENQ_BLOCKED; delegate its admission to that scheduler.
+		 *
+		 * If @sch is NULL, @p is transitioning into the root scheduler. The
+		 * root is published before tasks enter EXT and cannot be cleared while
+		 * this rq is locked. Preserve generic proxy execution by placing the
+		 * donor directly on the local DSQ.
+		 */
+		if (p->is_blocked) {
+			/*
+			 * If the donor is the same and only the mutex owner
+			 * changes, avoid triggering another ops.enqueue(): the
+			 * BPF scheduler has already admitted the donor, so it
+			 * can continue running.
+			 */
+			if (next == p)
+				goto switch_class;
+
+			if (sch) {
+				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+				scx_do_enqueue_task(rq, p, 0, -1);
+			} else {
+				scx_dispatch_enqueue(scx_root, rq, &rq->scx.local_dsq,
+						     p, 0);
+			}
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
@@ -7337,6 +7449,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
@@ -7723,6 +7840,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (old_class == new_class && new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p, sch);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, new_class, queue_flags) {
 			set_task_slice(p, READ_ONCE(sch->slice_dfl));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 351ffd1e02fb8..800a29ca6069a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -213,6 +213,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -221,7 +234,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1651,6 +1665,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -1947,6 +1967,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index f4ce5b74b7bfc..b4055a1044537 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -748,8 +748,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	scx_prepare_task_sched_change(p, to);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -779,8 +780,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
+	scx_prepare_task_sched_change(p, to);
 	scoped_guard (sched_change, p, p->sched_class,
-		      DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7757252d52e21..0e83ebfbee2b5 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index da4b459820fdd..79b31eb7db7cb 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -55,6 +55,7 @@
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d2..7efe7b9346b49 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce3..f8fbeb7fbf95b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -47,6 +47,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

