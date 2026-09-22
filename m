Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3056E054
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096121; cv=fail; b=AELSpaNFD0cZPW/RL/pgr2AcEoW2ZRjBj2WBGhEJDtoPvsCZVNlIpGUYMIbrk6d3P18dOLYYM2Cn7MDOSYFedPehd5REV9EdHv5wZ9z3Ch+oxmg72Gemh5mA/gAToWBTWTOpk77vmLPxLy/osld1anV4s1zh8mfZ1g0o+uvAn6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096121; c=relaxed/simple;
	bh=eIrHhFYSzHc3/XDvaFBXvjMbI9YN6WjUETzo/I4DiHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHFfrlGtWJBdoI7jXfUHk8sLWB4eMEfqAP65RwwxRemond2U/W7REljMslE1nyDiAFh3w4f6Mjn28mJ4d8BB5InF5P++wxT9hDL/FvlOvzW9D/KplOSi3XW8k+IuwRaZ9k0Ym2GqQNtzWkFvFbmf3Z1mOr7Qnr8jRHflX5i8wzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SxxatHiL; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SxxatHiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPEiZ558DSun3uHI2uwKqo34gkbrkbzpsW+N4Tr2Z/xikJDwI6Yq3Fafzq1IzchIQCPMvIxKCoAGc3zcZ/p5kVGwpYT0uNEsOoLMQQYeo6E/v3QNK0rAku2FDfma0HruVEzLljAJzWe/yGyN3zY5AIjD7AYlc84vLgPCQAZwQWxXHIVBC0RMX/GSmu7r2PWE5pxmZZsXM2uv4187mFZ/O49y74ESy/lR5LJ9RHOi58feSSASysnmB+v3xWvvyROB4tHqoS3rZk4U4A/3UlojYUuq69+d63cY2+JRi86Sul7nSXIhJGMh18wmCA0Ytx8/LpDAvD7kow1Vlnw+d0w8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUcx/C/uYtImBjprU/IhK/UOnOjFNVs65RbU5BMwlYo=;
 b=A7SQrEdVMEI1MZ/rtWTuH0NOPQ0NOyelyC/onEfX+0GkruF8GRQRGqIgyJyTiXt9sRWRq9P/u5mmSETjp0aZJ/+gx/uZ3hIqnccXTKlh8F1QKZCoLDesxVQ+/Plkw4/NQ2lg6C1TlRNjj2mBgwsKbPn1ZKz8+yQb6WmP8w3JvieNJ6Z/5mj2hQwWpa3Iekt3x+mgkibEg8t+2Iq/9WdB9sx7EHXJai7WnsP1mXkZ5KWhOYrfHpAU0cU00GoBWJz+Rld8+++gHycgGrYxIq7xIJpqntRPQNhUs8LW034+5uNr89lxf5/T8PQB604cP630Swzld9cvZ91mcU0G9xUqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUcx/C/uYtImBjprU/IhK/UOnOjFNVs65RbU5BMwlYo=;
 b=SxxatHiLzRo4utzgadpGHtN2KWFtuB1bYqgeIkmMIhDWng/u4ulHG6No7y1EwCwpSQw4QN1V3oQtNsrg2YRsvlF91jaqtrzWKVrQhnC8pRx5pDv/I94Z+cgQLU5BNbFn5ALgANV09LhIz/26Bi2sjo8RthYV2aD8igjYlUf33Ctu8gZ/CnW+28utAFatbHTujcvfFiCEwbGBmrra7yH4X2wvGQl/houmMd7nPxraibPY6SAhALRpPLcLiYwC/hxLFndgx7nzIFGPABDSOgpO5O2OLRzLwI+D0WRSDoYRg50ik5hTxrn8SAcDZE9J45P7SEtZ5mVuOVEYEbMzM8TGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:13 +0000
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
Subject: [PATCH 05/16] sched: Add sched_ext hooks for proxy execution
Date: Tue, 22 Sep 2026 18:51:44 +0200
Message-ID: <20260922165445.943315-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0243.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fac2bfc-657c-4e00-4665-08df18ca4526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2QUpQ1GNWhVuAwu7g5Pt5fjK6/NlcGl0nkFCIACangTZbmnbjUFsXGpqeGt1EbmvGsLsl8tmD+OMqoHCDO89Fq6/gsPrTa8B7LTnULSMkU0jVun07VT/d7XbZnwES5Bz+6olL9LohQGIfhDKUybDrSOHjGEbHB5dcATQLjHoZVnQiSHtcRGojngtpjCYBVdwfT6fLBVxAp6P94RaSZUDLb+ee9eTVJUls6jx0pQQtgaWwpV4IzJg5KfcN/ULSfDpXP/0BDmaQVXx6jswc6dz00VPnfGRhXmCkRosfOWieuwk3xCnBOTxJySsM6Db8mL/rczsd1o4w3C1uRpS57CR2uRYIMTW/RE3ZYBNrb2Iw92RzO5Kb6ZGBI06d92uVmMM8k4v8dz+hHtFRSdI1OxxadMt92JCUe5mOCjP+b4B3DNg31W7lRRsdTZyJoDqIKnoUn9QgbFK6tKn4y2Rzth4UCbGpvFawDJviOnYkKhpNGOoCSZ+V4FaOuVG/uKLXQc8iFYGuVhZCG3PZuDauLrvg4Jn7pXyP5ukbZjb/IH2ZUt0tgeVpbvaYgJ3Hn+/dA4Sq5QAvNUw7fVAuZq1kO7e6eMLqVGAdwo4Ysz7jMsTit/5Ebj2/Dhq5pG9KJUhwblZE9M1Ori4+2qDi/F0mdbGMNFpuR+nmwtDbWe4/8oQw9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dKlTBFS22v5mSPTp3FhgqxRwfRuWU+r62hLbfsPH8Lum0/bTiUXk4ND1aFY?=
 =?us-ascii?Q?jb9WDrDduz+lOGkeC/SNL1ovtUift45mdD7ArrBOBgw75pec1AHGx3izIBXW?=
 =?us-ascii?Q?mhqp5mzzaW6hpdNcyiBzOLGJUi16DVqrwjOhn68R1r8FJIWAGeRKtok+reot?=
 =?us-ascii?Q?cuQgBlmeClcixS9Azdulhy+IEBUi4r7MnGkGJ/rkJNCxpdJrQKekxeE7Y8kS?=
 =?us-ascii?Q?qp4d+H1w8nIa9DBzl6l8siwKzow3h6C9iuDOnMx3P7qfBTYmlCpdst5PyJEw?=
 =?us-ascii?Q?Fjqy0jAbZkqT+2SEFrt1fHoB05Nk2g4DgblSBtYvexk27HV0HAHu4p58Hm9X?=
 =?us-ascii?Q?+fuJyuE5fIHGAiMdMlUR8hQpw7e58Eeq3jOAzybQHG4YQ5JHg1vivve1fP0X?=
 =?us-ascii?Q?7RWu27y6TuyR4zx1MkiCTt/EmXIj/A3NypbjtzowBwJua5TG6lv5rssePPQq?=
 =?us-ascii?Q?0OnZItWkhP+FgiiI/vjKCXZVgpEiG2qbxvkKx8ZH95Lzs1sNe2X2vD23/98P?=
 =?us-ascii?Q?5TwWepdT7X/B6brRW2OX+iHDR5fOWUwXTpE3w5vGsca63aCwMh1H0vnqGZXf?=
 =?us-ascii?Q?AkRVtspz3xMXfEkogGh0zWzw9sy8qCQcV6NiEp/0gKJpBUx9IfcZgzC5bjWQ?=
 =?us-ascii?Q?fhbvDgWJ6jR1khO10mELATmqsjWmYAhaRYWf6SFrnZs3rtVyDIMb3DM6hZbz?=
 =?us-ascii?Q?zwDWuDvcqbWG7EJKMr25FLFFqDA6FPRYQrUl9lZplY2gY81LgqfF8beuwiAl?=
 =?us-ascii?Q?Wt9OPMYqMrlNjxPP1ZW3FE7gRegNIkk0TLLn2p4nJtRkZaDbTScp9cYvxlCe?=
 =?us-ascii?Q?iJqGWfzp3j94SHpR0I1kIJYdznaB/1EX4X5VEiYJR92Hn4qb8mKV7G3b0dxe?=
 =?us-ascii?Q?X979VTEc2h0uvCVmJcA0IO4Jb/HdbSX738UfxF2xPPcs1KBvClJZAzk5ucZq?=
 =?us-ascii?Q?GHFCamLS32fLFe4Ap6gAZ2yXRYqvKWbGZLKjfPXMTIVQ2Ccpwd0D8htXi79A?=
 =?us-ascii?Q?CWUY9XWqjGfolZBpAryLnoe8CDGITwn+CaR9Jllt1jewVYIGm76y5VsZff6j?=
 =?us-ascii?Q?9WqBJ5Zanmx75tCY2RKy2NlZ/OwX6MXX260JOQsEClpauCOxRPK+ZQr2F2iM?=
 =?us-ascii?Q?uJIr7/LqOOQFscIz9r6ZB2026NXq+GVQgaxNPZqOxzBP0k+qxVKh9V2xx0Cz?=
 =?us-ascii?Q?tXJ+i68VIqtA6uI0YIa3kNhUTYALIW9qY6RWbQV3aQQTO9MHw8/lsohm2FBU?=
 =?us-ascii?Q?sUxl4mKVKaJbEx8px/9pH8OPgE/DeaMbWIb7LJVFo2VR0d5OCwxSHio8AaNR?=
 =?us-ascii?Q?l+CzCbNa/jyOZsjxWi9xEY5yVVLEtueK+GXVXb8HxlqvXbq3wVQTjDTZGI/A?=
 =?us-ascii?Q?S3HqO9umnlVtm77sq33gj898bh8/RzYshy/LivbJOCD6ny6d6uCCqvWbXyYd?=
 =?us-ascii?Q?GGcxjLpOhLD4QAW0WZtH0ZUPNsemYY1xq/e0dthDOgeRnI4JliCCHzUdk/zS?=
 =?us-ascii?Q?6NFtn5pMaC/GVschcbgSgln6ylulxCFkOXDg8XOqaUKfdhcu9LwaUiXo2NLi?=
 =?us-ascii?Q?smRZVediNhafR7rDf65pbEHqE7k20p0idIjUQ3nkBZvVnkY2NqFm+ESAhdqL?=
 =?us-ascii?Q?QMXCzn1BoT6O6GjNVXSrvI6gHm+cc4p5ijneZheh7N6uN0fajnS0wIk5Fku1?=
 =?us-ascii?Q?d9xr2ojlJEq/75FmiECL0RJctEuEWwl1hz02JMMYV6I5rWrmoX2Rb+PaLQ44?=
 =?us-ascii?Q?gcAG0nL9aQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac2bfc-657c-4e00-4665-08df18ca4526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:13.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/cNeRrsFhQDcOi+H3GtNX8JUuiJ9hlIf1t0xVUYO/uHAmgrvsbnO+5eFvKwzfg3N1E5c/rDe0Ql+N4pF2YZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

Proxy execution splits the scheduling context (the donor) from the
execution context (the lock owner). sched_ext needs to observe that
split at three points in __schedule():

 - whether a blocked EXT task can be retained on the runqueue as a
   donor,
 - when a donor's scheduling context starts driving a lock owner,
 - after proxy resolution, when deferred reenqueue work that was blocked
   by an active proxy relationship can be retried.

Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
scx_proxy_reenqueue_retry(), and add their call sites in __schedule().
The implementations are empty here and are filled in by the sched_ext
changes that follow, so that all the sched core changes needed by proxy
execution stay together in the preparatory patches.

SCHED_PROXY_EXEC still depends on !SCHED_CLASS_EXT, so the new hooks are
inert: they are compiled out with CONFIG_SCHED_CLASS_EXT=n and
unreachable otherwise.

This is a preparatory change to support proxy execution with sched_ext.
No functional change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c    | 12 +++++++-----
 kernel/sched/ext/ext.c | 13 +++++++++++++
 kernel/sched/ext/ext.h |  7 +++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2bf1bd5d6a98b..5a7d2a723f1db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7216,13 +7216,12 @@ static void __sched notrace __schedule(int sched_mode)
 		}
 	} else if (!preempt && prev_state) {
 		/*
-		 * We pass task_is_blocked() as the should_block arg
-		 * in order to keep mutex-blocked tasks on the runqueue
-		 * for slection with proxy-exec (without proxy-exec
-		 * task_is_blocked() will always be false).
+		 * Keep mutex-blocked tasks on the runqueue for proxy execution
+		 * only when their scheduling class allows it. Without proxy
+		 * execution, task_is_blocked() always returns false.
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) || !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
@@ -7243,6 +7242,7 @@ static void __sched notrace __schedule(int sched_mode)
 			}
 			if (next == rq->idle) {
 				zap_balance_callbacks(rq);
+				scx_proxy_reenqueue_retry(rq, next);
 				goto keep_resched;
 			}
 		}
@@ -7263,6 +7263,8 @@ static void __sched notrace __schedule(int sched_mode)
 			donor->sched_class->put_prev_task(rq, donor, donor);
 			donor->sched_class->set_next_task(rq, donor, true);
 		}
+		scx_proxy_donor_start(rq);
+		scx_proxy_reenqueue_retry(rq, next);
 	} else {
 		rq_set_donor(rq, next);
 	}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f60894dbf0623..aaa6ee66917e8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,6 +24,11 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	return true;
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -1110,6 +1115,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_reenqueue_retry(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -3119,6 +3128,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 }
 
+void scx_proxy_donor_start(struct rq *rq)
+{
+}
+
 static enum scx_cpu_preempt_reason
 preempt_reason_from_class(const struct sched_class *class)
 {
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0012f708a5504..cca3f7c97b788 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -20,6 +20,9 @@ void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
+void scx_proxy_donor_start(struct rq *rq);
+void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next);
 void init_sched_ext_class(void);
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
 
@@ -61,6 +64,10 @@ static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
+static inline void scx_proxy_donor_start(struct rq *rq) {}
+static inline void scx_proxy_reenqueue_retry(struct rq *rq,
+					     struct task_struct *next) {}
 static inline void init_sched_ext_class(void) {}
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
 
-- 
2.55.0

