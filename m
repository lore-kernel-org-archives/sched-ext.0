Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062D3A9612
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901891; cv=fail; b=GVIQcUXnRV4LMmijQD5vImGWPpvFLh/PXJUOja5J8u+Les0YhLWte8vTh23swIQE9Hu0mD9KJbwClDeiIPkPr2id8vGMixxJebrxga/OciCh3Ey/y73RupJr3oQVDbUpZqzeU3Ag3aJIxf+242rbhlC/ja9IHRCyebkyAIRY7XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901891; c=relaxed/simple;
	bh=WYIM1Aqx0ZLCkuYhr+VKeo2BvR0k0kjJ2LWsewBh9bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KP9gyYa7mYp1dHnO9tvfpzDCqz/9RNpxgWYfd7bM2Q+qr+FKG6E6zOCmCwtEgxHYviwNnTsdYP39Y+XhuJQQk5WakBT4BM1vSrwcu47yXVbf99Dm3fCSBItonh5D7rT49n2Q+9e2y7UoifIBVcbJlPjlqxdcQ/ZJkko3SqWbly4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TWRo8Pq4; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TWRo8Pq4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH3Dv0FxKrVPaoYmgNTtIL+8dZ96ylnVoNSJb8lhSvCajNsYH7uLLl3nhOBg/13hB0yyWb88MejoPDhdtbJPqMJo5Z4Fa+0s4obn6yeghOT+WzDH7tkT3GIh7cNnE/+HNoLim5b8zWNFw6LE5p4XyBojtaLoiiABeXHClAxKznRJJc7oUmovBgwnbcfI9uNwLbhdR7dlxqvIGQy+w9NS+nlNCgfOZHnHDNuwK4AyhXnN087C+/wHSomMXe0R9OF9o+95vXGLp6GOeAhfGIPp/bt69v+DL/vPLUcNQBLbalAg1i40IL48a3Gs/xD7cTcp/iumKgakYu8gMczubIg1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OTcA6XGSbU1zKxGskg/jXcV77dDLe3ZiRIA5y2cGtE=;
 b=aiGELvql18frdy1CcXW1xAlLlA9RHVgkYa1F3PsS01kAHtu1TPOmzPVyPSo0Sz9+85T9MwssJ5brKoL+ErChFy/Mf9SHC8ZpXX0AQwvdLl+qV690gjGKwl9dUTZ4e4nLBllqmnXY14lw1SrGdIhElxTxiy0nL1HcIUl8SjRObq49OTHAA+0Lmz5aQhGNHK7+UDNCMpQ4OKR/hMFhNyPnE7+sa9wTNYpv5DT1jdPtfBnCc/AdEq3jbVpWdCZYCuE8/Bhf1cYLOS3GyiOI6P6o9v1ZMdtMxrIAe7Lvkds55M2LkprZLJak5AA5L4BbR7fNHh10Z2ITFyrxpGSF8e/+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OTcA6XGSbU1zKxGskg/jXcV77dDLe3ZiRIA5y2cGtE=;
 b=TWRo8Pq4kC021Iu5vZIhR3BdCbZBEYKRfcT8ZwIXroEG4dUcOwQ1vLYXKBwrwQBazZRwFpU9uNwVAmZ8KV58A8pH01SgGdvppwgTQ4TKmXZ40vFmNGBnmO3XY08hjy9M5iIphiGC6ghdbplARqaUIeIWDXgDwor5iscUC61SSEs5yzELpAB7lLw8GXm/XtK1CwAUOhAkwP/CupUUrbnb8CRUhbZj0yJXEEFlUvl4C8kHKf/eSPsPo+irwx+pYnOpJ7e/DwOILQH/Df+Or3MKAaOxZLYAVYluE1+ouXr8O3/uBgigke7bG01Y9so8Gu3jBQHbnFaGOAbFkaqeM4XGug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:06 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] sched: Add sched_ext hooks for proxy execution
Date: Sun, 16 Aug 2026 19:35:05 +0200
Message-ID: <20260816173732.17162-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E97.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::447) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: ab078725-66fd-4912-c695-08defbbd21a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jAlHL39aJDsac3A1VQl35kB0PUH/TvxjFPoESXh9c3SlxNc27iBdP0qCPbk3mMX83nNNMIzQchUIIeiC2RwAoHpTa3JdvSN/ypv2s2EXXyZqSz/Dy9dMy1Ipq3afHhxXanZizWArrUUjP40qK5tQBg7+oabTmZd2VFfWNxNVVmNTRCZ4hZUsl2+BSLEGRoXPn3Z2xVZqTlrFuH84VXHW/y6sksttDSGx/KTbQjKhy+ALMoWiKjId+emGqAYWS5R44MsEHULPeszPnhB4qWcvmVZrdfPwvzBuRWWhQm21Ks75Ff7yCS+lIIhI/nhqQNpuQ43RoUg2s8H3Hxn9/IK6C3wIc+YzsT85W7S0zcIj+tVpaKok0Zgps6S5hxna5UPrFturU3gpRZ6uGjHCGCRyD9KnOcZQeFBCExLbIYQLa1eCyQFkjtsv0hhrC9NOK/VwgCgb/Q+ArnlM72AGCQI4IIwBXuejDD6FxsSNczrAMZzBSMkwsKuFEQBCA5wfBWjgoiUTOvRgMlxx0nUS9mqW7HCe8oOeKrZTkAm7e63CU234DVOquoyaed/Cm3/0iVnAI+PGHp4y5nYA6a7RFdO5pprytCv9xckUxF66Z5Fhf4jJ1caOdDp4dDokEEgPaB85G06wTi1unL4b3Va77+HwwNXwMqPIqjV9kXr128jCZds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JV2UKrsMuDuv3hdBJzKubUojQswjDOcAue5W8+0KzL5sloYvMlbdwve+4jhk?=
 =?us-ascii?Q?32eKEJ5KVs9c+UU4y0le3exPK4elnEwkcbTjFhrwiMILGnqfGQJHk0czckqB?=
 =?us-ascii?Q?dcG2pwkxStTsLEdbMDWQZeeypBDoObw9yCYNE+zfOmagfsBB6HMrSrQ77Y7Q?=
 =?us-ascii?Q?g0GUAR/PDnADhc6QywVD14edBg3o6frZLZ8kCT0Ztm2TeuMkI8JMEZ9bQPTT?=
 =?us-ascii?Q?U3uB4PKMhq2CIZFZF1MLpfkTbhHtZrXWzKXetVqXWpGvewMcGmr7g3fZNwef?=
 =?us-ascii?Q?HnkEGoUbKjM4ID+eBODY+itVftIrxAPYlDZlfo/rhszjgr9l6IxcAp6dXpYo?=
 =?us-ascii?Q?fJMKJ82ni3uZDsWdtkd+ChQTy1G7SCbnYFJhaDLsQqsg0flqFYEiTQV3PpT/?=
 =?us-ascii?Q?wVuYdNreqdjfAC1QjDMGaikFtQBGlPZ+0TTJN537z96rTbQY36OiLuAPy9SC?=
 =?us-ascii?Q?Qv/Sz/tB46aU9Y8OpNmfcGnHn7drBj4pRRvX1iIYZgIXaoR2/dq7j81eto98?=
 =?us-ascii?Q?O9Kd1gL3kx+9ztmUsfzVdiFqfVd6F4fxCITUjolAHdtbWmhFbDNkYuirqCum?=
 =?us-ascii?Q?f7KzKwZzfwHvc9ljpJosMuz5AfzWvtgo+GsX0URFXz7+nJXU5grUFVT1O47u?=
 =?us-ascii?Q?YGQUWsRcQthq2NZ2CdyUv/51HuRpF7RBNvHFQKN/bUuqxRbojZJo0JGqQRfp?=
 =?us-ascii?Q?epgau9pc7OcMkpZSP7IyY4BWEFx2zKWCJCIFuFsLoGdn2pg2mk6K0jpfdVpx?=
 =?us-ascii?Q?rof4u/bfuhR1w07FVjgIorCVEBJbMT4w7GezzP4Sotqve2AqfwKhbKEGEu0A?=
 =?us-ascii?Q?cVBwCSMHqF8oy479PHQzqZa4sWPM5+3bx7f2cTmW1t+HRliGOxMdNUbgqk5d?=
 =?us-ascii?Q?ye3snkYiV35yqYXzd77vJYyv3dWSvtaZZeRJ0LS+I38pcFME3h01WwJ765dC?=
 =?us-ascii?Q?Mde1fOSaz+wgpV520rgAQUS3HQzLdHBJpwkYMqvUCWDnmxIOv8jif1xO6Qka?=
 =?us-ascii?Q?3WSa32NYjKi7ACwuFFsCWahsKeINyUoHGxJSAlFP41aeCHax/ygsG+LzI6Eh?=
 =?us-ascii?Q?OzLKrA2lhr0PnHfBGeqWBjeq1LZ2T13x8A9K49nKtwy7ob4fY26PZYBG9l7Y?=
 =?us-ascii?Q?WgyGhhDJS1oIjKRh9CAheB0AiMGTX/usHu3yfB8HI1bFH10CPRhjiGeUsrSq?=
 =?us-ascii?Q?t0f92M4GjEMXT2OyCbrlumYw3sRVsrmRfcRnc24+XJKWRi9lI9xyehPtHAMZ?=
 =?us-ascii?Q?yCI7th5zRXzRuk1cA8fyYOFxiIIxRAovISjZnIaoKCtZnbi1KnGNpjvnGtbA?=
 =?us-ascii?Q?LEn2cmBElC3NpIf24eNTTodgy/ErD26PLtEfiggzcvVl8HOUNFxedUli/fq0?=
 =?us-ascii?Q?oycfoNpzG1xt+gUNxNXlA1WNh3C/A0oGVuys4MtiH+2S/333ORaPE/jTBbP/?=
 =?us-ascii?Q?CshJdOPtJlgxqBOdcJbUVOsn/qbklKL5nqLaUEef00uLJRS44n+ljDiO1Kwx?=
 =?us-ascii?Q?GaJxErLYQZyId040ZED561/o6zyibsioG5Q2otYwdCcwAkDx8gv3jJZQoPN/?=
 =?us-ascii?Q?oWLJaLo4d5H575oeX7EqpD61U+B+WTCAUKpmTh/7AOc4L2QHGd4v3/q/J9T5?=
 =?us-ascii?Q?gVC9NhGxYlkqH8+kR2ofP9jQeY0OWQnnW86GG1qzwdhVt0yLELR+zFNelyII?=
 =?us-ascii?Q?Mwrc/aVVqP1pvfnWYKJFGO852abFbZUgHC+zPveqPldjtNkho3vxFWsHDTNT?=
 =?us-ascii?Q?ZPsh4KdHIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab078725-66fd-4912-c695-08defbbd21a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:06.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uctdspZcGX+8l+gIliJMXaneUOQs6MNF+7cR5IoxC8B9trD61+QK5uW2AdplqwSu0OxSCqC4j8NwjbVX3ttr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Proxy execution splits the scheduling context (the donor) from the
execution context (the lock owner). sched_ext needs to observe that
split at three points in __schedule():

 - whether a blocked EXT task can be retained on the runqueue as a
   donor,
 - when a donor's scheduling context starts driving a lock owner,
 - once proxy resolution has settled for the current pick.

Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
scx_proxy_resolved(), and add their call sites in __schedule(). The
implementations are empty here and are filled in by the sched_ext
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
 kernel/sched/ext/ext.h |  6 ++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb2b7faefcdeb..ea432bf307c1d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7208,13 +7208,12 @@ static void __sched notrace __schedule(int sched_mode)
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
 
@@ -7235,6 +7234,7 @@ static void __sched notrace __schedule(int sched_mode)
 			}
 			if (next == rq->idle) {
 				zap_balance_callbacks(rq);
+				scx_proxy_resolved(rq);
 				goto keep_resched;
 			}
 		}
@@ -7255,6 +7255,8 @@ static void __sched notrace __schedule(int sched_mode)
 			donor->sched_class->put_prev_task(rq, donor, donor);
 			donor->sched_class->set_next_task(rq, donor, true);
 		}
+		scx_proxy_donor_start(rq);
+		scx_proxy_resolved(rq);
 	} else {
 		rq_set_donor(rq, next);
 	}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 186a3f4e1a92f..6b1d9c98b8efa 100644
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
@@ -1078,6 +1083,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_resolved(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -3061,6 +3070,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
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
index 0b7fc46aee08c..859b9261a8a6b 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -20,6 +20,9 @@ void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
+void scx_proxy_donor_start(struct rq *rq);
+void scx_proxy_resolved(struct rq *rq);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -54,6 +57,9 @@ static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
+static inline void scx_proxy_donor_start(struct rq *rq) {}
+static inline void scx_proxy_resolved(struct rq *rq) {}
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
-- 
2.55.0

