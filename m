Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADE41D22F
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374985; cv=fail; b=PljxBwEDxKrw19spb/RJhgHmdaKqndg67SuC1ea+4aSM+u6v4wHg7WVFXukqPhJpGDHY1KvYz6Yr+JTCyt+hMXfRXJ40/Ru/WsmYWlEFS3EVzhZHhF5UkHzVQZA+yysdu85uRJDkuLrkRshUUPz8Q3ozGijZOwd1ZcyneQMEWRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374985; c=relaxed/simple;
	bh=dsnMlJKY5OurEEWf6Mq2UVhX3i/pVXxYzRfcxdypbLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2loP8iK8YHg2EjeeRNHmb6dWjfJG61UTaT6eMXPumbXOm+7huwIy4NteClE6AKTX5t2QvMu4Pek9WP6etjQITuZHbsCBWMCQiR8ZfIoewD+Qmz3Mn+9OCzh07+15A4isPhVuVjxMzbFWgu7VrJ3DR9pH8uyH6PaVxGN8G9MJgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GwI8VbpA; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GwI8VbpA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOnGURXqLdoTDWUK3aGpQfTs57T3cWIMNpieyzuQK2ZCIm4o8aKmOOZHClN8zBQ5XsCXaWUCC4VEFu7IPQas8Tdv8c7/MpFuZsuO6sOupTVF5dD9t3+GDiAefA3+xTSEZthFSfJEaohTTLtl4oYj2Kf7ursH+w/tibEn8eTDkt9FSZop6YOUy00ZB1oMqsyVs7iWoHJ3anoO0bZBJVKEgJZCXRtFYCQIyQM0oourNXgNfFSgxu3DJJv88wxJ2CJrpxjLzRstWnB+5S5iV579BtiEJukJXeJa6Plu4U1/VmS5HjMEsUjX5+PqGU+p1ta5rRixSYyww5GUxznCUs4xKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG64vQpiP64MU7CZSqYQYuy0YAki2np7edTeFkPsc1g=;
 b=P0zU8i6Q+ZI4LAQP35t1tM0ZC6aDsy/JUumcC1KfsBUASh5SBoJsZYdTsOtHnIfqc3+zE3PM+/zA7WFWiR6NfJGPCURGg0m0/+jir3ZFS5ujyM02WPp4dDhMvZMeEfzEFsvVKdqy1SNGMyNvghLlNV6Da13DtBU3Efc2yjgry3RlIlGRkEN3r+504kyXl8ZMHZ8FiwsxD309ojsrGEjLh16kO2Z7k4wZSO70xHWnTsiX+UGdVQpxVWYiOAfmYDQc7siJWvdG827CAx18ZvvrOldXXYOlQ4O20Oq/JvjtGdlMKbsdosqWqunQJE0kQ6j/yYjPXPDG+5O0AuGSnhJcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG64vQpiP64MU7CZSqYQYuy0YAki2np7edTeFkPsc1g=;
 b=GwI8VbpAAB69ccYe74GUPYHhHpzRAg/sr+9ir3to7AIgEVrMKRWktGBAlz9CD4/DhI0AEtZU8R2dshml01q+YThJnTKqbiyx7AaIkJ25zEVMmrZWRYJDpaqp5xaJQSzhe+21dMAxjbnYyWIAdnC7wAOxVHG6joPl6IljFDESLIg2E4qvqU8EBV9Pww4dEPKdAUBfEgCaZzlRQLiVavHCjvrr/stgfAXCJucF9XKjKjS+Qm9mHA2Wx2mUUHnchKkkkROpZsvknomQrNug1FEkhrlWxgMPu/5zjFAaevsVKZmJF92cxf6Zy0Uxki/cruK4osNhEg2Jy9rturXr0opg/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:16 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:16 +0000
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
Subject: [PATCH 05/15] sched: Add sched_ext hooks for proxy execution
Date: Mon, 10 Aug 2026 17:13:51 +0200
Message-ID: <20260810151523.86994-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 95073c46-c93f-4644-4201-08def6f2528a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5NforNoXEjqwnA0oa2BYsrx2yTS2g3MHQFbqKaq2yXpNNyeY0A7XqUgPi+15SG8Mq78uyQYiP/aPQwfoom3q2IPSaGtkBCvjg2TOitcz9PtoeGiiEvWmeqVoS24GsrTHQHTNwaubZRZ0ncfl6sosYbicHYhlWgTx9HM9RKaIaeFV870UFTXaExxjNINKH2fUKkd8k1CkzMBuqGhbZt9WiGzAdi+0UJwFu+mVhk4Jde9d5Iy5FIiiGr/G9xvGzQ/rzRE7WiKiKMSZgMdTgMTOGfbAZ81UjfJNOig0E9jlYibqyfqYR9bLQVYPCi9qI7byKYcxZq/kPJYacEQp7UFIMvme6ivLHQy1Aem1xkPeQpc31Lf1rToUUrCM3404WmbCdj8sN/CBjmN98G0S57L9r2NLa7VVLkJjRn+cFu+m6z+P4b6Aa0ki2yl1jlkTSR4sP8cPD/GXBEXgauLl+oYQ5njYbViP3RUSHHZ6HymSn/N9Oqlsq21TnvPfN5k7R7cr1QqstBAgX0rSf9MDhqiHqbPU99hAIlasioV8sIrnBj1jEypwCSYuuTMxiM7kEZn43l5NLrcEWCumJGuS237pvMNqFBR5N9L+K/88giS/GjWvbbDJCf63FAiAIN0GWmz6b/cbwmo+W79jWOSabbXE7Tn6PkqB7A9Px777gPsQrEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUJczyaEjz05BZj7TGO72Yt0huAyx0MLmu0RxFE3Ad1gbacDTkCc4m5CY5K3?=
 =?us-ascii?Q?i5QrhS2KN6wBPr/Bn+g2WvkpflH8HC9IsK1Alwqwm8MpfOBhVxOA+qiaC+5R?=
 =?us-ascii?Q?e2pskZMP9Ymv+m57AJn8LTUCiigxmHoV+vdsZajr1Yu0uTGnVX5s9QjzGYx7?=
 =?us-ascii?Q?BoRvd9mknfVe7FjzXpVx7l+gId5xwFbAqL7SwG6c4V61CQSALQujjRSLCo4J?=
 =?us-ascii?Q?5CUVu+B2xpZS5aYQWHsWur0ZylJntloGGC4Ksprfg+8sm8f0Lvt4pyxJhcv4?=
 =?us-ascii?Q?sw/RkVlqXAfgzpKQMP/GmPlYv6qPFnjUgG6RFPnh8E4HVHvrEF10Eer9gZw0?=
 =?us-ascii?Q?mOfWeT1JnNpF5DlWp6WaX67wEXLzcOOKqVKxxToL86/u09Zzc3etzG+ujbzz?=
 =?us-ascii?Q?ZlF38UV+3oami4AhxsBdhij2MkrwIJbBrh/0bjg4/Ih+ZSqKJlty5TzIN7y9?=
 =?us-ascii?Q?31COfnFQtNOJVVxxIO/sXouiGkqiPPz3FbT+B8NgdPZ6Q5Qw6XjHv7rSNYF4?=
 =?us-ascii?Q?lai8Q27TtYrSSVkf+faFXt/bfvEGhRfKN0f07XZ850VeRHVK7hMBdnSrH3I0?=
 =?us-ascii?Q?NyC/Q2YvfLeHfVEjxBf26cAr9ZzVUiBtYWi7AuskZnDey62BbbqVfOHc2EQg?=
 =?us-ascii?Q?FzR+tlDUxHPDdjn2KJkBN/LygfSuxWOkmBd7mkTOzikmD04iuXXTVVvjLVG9?=
 =?us-ascii?Q?o9S+8L8iHrv5U1AdlfwIAAIrklDhH3zYRBFTGIm+j1WifbY5eYrltM9PaqO1?=
 =?us-ascii?Q?c2dJuTWBSpZx2fJ+0r2khGXQ1fkP9zXc4CV5K2uxIYjOV3L6+9SKS9ccMif+?=
 =?us-ascii?Q?u6j2zgVZpdusx1QF1Dc+RutVkRPqxcjV/o4aEhZ9GBelZACUWxj/Fs+TcyXg?=
 =?us-ascii?Q?+ILbsZgQLPoSgp16Kbcp2XnV+Zzs9irkMYywcci1vqj2HG+e2aSA0oSst/mO?=
 =?us-ascii?Q?sVD3nah12FrqTKTt9P6zcl76HRa1U/v32Q7nMX/YI5urlL3trhx9ppC6FEu4?=
 =?us-ascii?Q?NQmTmH1TYaYe8bZgCFBwnzqRhpeGKT+SYTWZ+xu8PNEF5SpZ2D2E6JeGA/D8?=
 =?us-ascii?Q?KyzqqVKHwI+nWBb8XZflyGqQgryxTrPZ/ILp9Lnj+AYYUlu2jBWMaduFiXhs?=
 =?us-ascii?Q?sIMvt+Ypszhj8PayykfSE+h7ZvI+NMLzlndBI7Be/cu0beQeyWGlFj/4/018?=
 =?us-ascii?Q?L0UCMiB7C6T0BEdfio9CyySU3dUlHupK0l7mRPs0h6WtmlEMOeFc2tsSJeY3?=
 =?us-ascii?Q?P86onIA8nsRPV1HzDrEFwYjwEm00Gi/qjXWaM9CICMTGuDReCu5syre4nmpU?=
 =?us-ascii?Q?kPwR95nD6lIeFcEG6/eFlZplJDxJhbX29ktFfzp3cJPYT6kqppm3OZO5I1j6?=
 =?us-ascii?Q?NV5l0Kqn6FTIaFjNc8l1w0zi5A8SUWtRGUMFf4cPzRe5Z55Bhx2L1yLiqnfB?=
 =?us-ascii?Q?6Mb4LTq48eODlGaFKeYBKtMmnIIDcnPVCCdd57rDrS/7Te/wkCq/V1TBbEcY?=
 =?us-ascii?Q?g8317aPIJBWFeI60RDWGBbSV5Uy+noPJgKJbAoT/d8ShQgj0AAe4XbRC9qCn?=
 =?us-ascii?Q?IDPDdTR3kmhmjAky3/Cb77ZUMXUKafGJ2bxVjC0KaHNUTyiWpt4tBJe1/j9g?=
 =?us-ascii?Q?Yx/ZwzDndEneed9xwpNL7OgzMRW378pgoEACSJImfRI/hEsdV44vEdhZ2iAY?=
 =?us-ascii?Q?woDRSP+qHEReOAMGtqQX8L75VWYgJoZZ2WBWQT94SUUsO11qu1SxSev5sKCW?=
 =?us-ascii?Q?6QoCtJ+8uA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95073c46-c93f-4644-4201-08def6f2528a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:16.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8cu+PY0t0KjDg30hGVyp0a/ne+dzufwbCgl/fiz7qEajjPgEyqAUDfKdiGCSExIdrd3Z5IpTB4ppRYseDtddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

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
index fe142e3bb78c8..08b4245a8f6b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7156,13 +7156,12 @@ static void __sched notrace __schedule(int sched_mode)
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
 
@@ -7183,6 +7182,7 @@ static void __sched notrace __schedule(int sched_mode)
 			}
 			if (next == rq->idle) {
 				zap_balance_callbacks(rq);
+				scx_proxy_resolved(rq);
 				goto keep_resched;
 			}
 		}
@@ -7203,6 +7203,8 @@ static void __sched notrace __schedule(int sched_mode)
 			donor->sched_class->put_prev_task(rq, donor, donor);
 			donor->sched_class->set_next_task(rq, donor, true);
 		}
+		scx_proxy_donor_start(rq);
+		scx_proxy_resolved(rq);
 	} else {
 		rq_set_donor(rq, next);
 	}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 17dab1543f012..4f2b0f1583989 100644
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
@@ -1062,6 +1067,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_resolved(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -3104,6 +3113,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
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

