Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1431F990
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253523; cv=fail; b=GFGKDUz0+2C58yVK7Cm6zvBbB4V3gVlMnr4Uj+vgy086TfRIFiKCHU3/kGnPkd8Rj78s2KdCN9wt3E8yk2nG85gZmv0QHnNP9lzcHSHXkhz7Nk1WLlya95gx1keh6aTwN2mjPhFEBFSpNHZw8YgVa7rYkBp5dw44ZxG6sbVHmxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253523; c=relaxed/simple;
	bh=g1xsAxwkbMFWW79IPpxXJdGGE6Gl16y4HkjFNNTbUAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXKPROkKbJldNqSwFesmWFJMwIzfu9EiRIHxhR1ztwxeycMhWjb4bOmKCVAoy7/rFVBiwd6t4mCHckbXmWZvNUdBCoHvPVQ0us/R5Vnaqp0xXhCL6vuIeF9ajSywXlc2leDBs11mArHTiVx0Y7X/D4BPo1r5bPJwwn3MJ+rcV0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sj+RwAul; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sj+RwAul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZGImfs5QmDoomSDCoraR39CH1FdeIGjtpTXgm0lj8U3HLsNXhCvfZ9I4t8htqjR1xABpHavpKI1SsacbOSfmPKr1wB9nxD9eTsyhXKBMgcalXRHxbjedKsqJda0b7dEC8M0rIJ9yXhmLw/8JGB16aLFOgzvACYKGsKaXECD+zZemqeE1E3WjzAKMwPB2dsLqv38xh9uuOlcroWL3jgp+8XF18aMzPFlIyRq2OOal16nN39QgbMrw+PCM7gIYPmkGxl9dJpKwIw1JTFO5tVcog4iW0nQJvSTU2TZZTUGLUITUWfUsp+hIFXeSQAAuHWR9N8vLEBwy0+qfwCPfhe3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoUGcaTwbADlQHh4cqN71au7GI06oXAk4HXRKUIIn0I=;
 b=CyAV48p8BMbXbMCyanuw4jClzTRz1ihCCS/FhWp7ygWGEljgaFWTwIcOcCmbEbMRuI9LrhIZUwzbJUP9WF/Y4IOYD/XU5lglKPheQzVC1ickX9OD4Uebv/YjWM0vuNSZwAF112gjyw7F/NgkbYglVz8bPM+GrgvCfI5J3yxY1N7BK0Ve5VYZtYojePh/8RxGxofJtp2kpb0FdCK7NvQNZ37wXVkclXTwLeKCWrW/u3r1TdN8pQwa4uFPUR9iehnfvfpW/+O7RGSM1xaUADnTcEd9GTVzZ5ccAMrmgHZu0kLBM1munP2N0DAXAsRJl8Pfmkv4XJzntfudWbEUXGl+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoUGcaTwbADlQHh4cqN71au7GI06oXAk4HXRKUIIn0I=;
 b=Sj+RwAulRguRqkWvJk6Yf77UmrWxdCihTSycq4Rmxj13lUaBVhHxYtOYvr+84Iv6r4cGcAORIGkbrAVdKdgNGsygN/6YFVk/DXqMZxmWrCZCDbQtIYxT5B5ZMVcZj0KNhhH0GWO77GxKFlCcUOSMDy8nUMfk1K5Zw3GhbJM8an5wx6FBO1J4rvyP8evgXeSNv7eUMi4HtfQSlKZQ0pneZ5qmLmdigH8zLTE/ciF1Wc21uGAbjr2slVN1oxorclfmZwaxwa3UrJhHt3V6N5M4ZCG6RIFZ5BRlMJ9lEraGnKSvhhzcWcNafrLeOfENvDl5dH+r8mCcEA0G/GC/01SLAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:11 +0000
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
Subject: [PATCH 06/15] sched: Add sched_ext hooks for proxy execution
Date: Tue, 28 Jul 2026 17:43:24 +0200
Message-ID: <20260728154425.1549660-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: b10b3996-e57a-4215-93de-08deecbf350f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v4DAp2xSyMmyi3GEc2mvGJQTuByZMU//MI8jzzdp224nVxFuVtFsOWfeGPtJ0ijM5hqtZXRSoQm/PYy0wwoPu2StHxg/kG2mG084ZbcOnP2Tr2idSV/NQUTY8/US4yomQidkQ2LMSVL8Lzto+SE66Cgr0ivrYTWBfJe8/jwAm3R0K07qLSQ5C08Gj2BaZgUrXAOdi5EDPSxlNKlj50W0IOLssfN4H+zUQU+Y66BGCbuIpd5lWlqszU/Vmx2GLr2AQVumJ0hT/mLaXoMl+ILSslFKCJNucR9r14OxUZQ2QMqAR6J+7LCEEL56Yizg8Xv8Z1MvB5QyHdJp/FQrIQMWgz9NLPCAwbA5Id2xY6a3zUoUMr6L2AZP5cpa04S6QuTn0VAymdvvfgBPkqAduUby3WMWHRmYhgY9WyqedJpk8tp6rss/ozIIbp8I/0bivF4LVIZagXLBIUz1BVbXnoHlDoFf+LtgDW5dJdZxsSsfwafMIEB5HUx9JqIaHvplRqKKyaPpM9oBIRkr4CYqG8pPR9Yero5xJhtXp7h7zK2bZ6eXRaiTvi/7dbAJxNarcHkmAGgSQ3Nq552XZIp7lTaHjf0wgTQRSe992oxKHqZzy3AdHY9m0DgR8RIrd5UTGsvS3j/iywHgwsCaLwihqKOjrew54fkamjymvcYY3suRywc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2+FpN9M+kq9lNaY/q1rCWIpqulq89TjRHacijsgOyZNqiMhalIql33gMHOs?=
 =?us-ascii?Q?z94UjWauzZMRSOHfkLeqn2J1ZrCWvoBcztttFCfXF/jEC+Ho36BZbmok0G9E?=
 =?us-ascii?Q?ydB+RggMASd5moEehHHGblF0I541LLhP8zGTPXwhwCYvtY0eqZ+9GbnfZ0CG?=
 =?us-ascii?Q?OedNrCZTdrlUXFrW41eiJ1rBFLkpfgxzMukSbSbhfrCoECer2pD795EVcaIC?=
 =?us-ascii?Q?1pqQ35Mev8yOn+2VFYulupbWGsTP/wOR6NMn6tD0yWKz90ZVh5U3MdXKbhNy?=
 =?us-ascii?Q?Pdv9o/+CWJD+17Aj8ogWQXWzXg1v3WdH/R74b+x8SJ7DWjJh6Jw0scYxT5UU?=
 =?us-ascii?Q?YQPyq6nVcu6Fw5qXF9rbBHweoEDyzClsPvKljDqx/LtmhFdtNjJ43rDqndfY?=
 =?us-ascii?Q?6l6XbeNaC6wDRDuCEH4DvrVKGp/Kb6pZQD6RJvAiEUeB5G2bFRtFEjdic2nm?=
 =?us-ascii?Q?5tk2czfmjPb3XhOSgjlsDIu6sehkiM2yXEiJ/qC8Nc8Kwg2du9Nz8ekAuTCM?=
 =?us-ascii?Q?uva/5awz9qX32Qz9U8UUk5i/w9w8EDq/qlnlRhaABVMPPlFchAKe6Yqh0xwM?=
 =?us-ascii?Q?8O86Q6piCWOq2asaEW2eZ/OaIO2dKtmFWA9ALQqd+9EriFFoF/gnzkwd1SqS?=
 =?us-ascii?Q?KIAZ/e06RV/kJRR19YqfFdwE7A7O88QRkSqXdToDhtcZgne2I4G1W3F5lpU7?=
 =?us-ascii?Q?Mfl58VxvduwDhGRnogbKHiYhtHyk5rnQAjwBhJbqCAyHy4J+ce+48bOc0Sc2?=
 =?us-ascii?Q?6zMffl2E3I7nb/MnffnCPB8aRE7u5PAwbGglhyisqhssx6h4v6kqB4BNJ0RF?=
 =?us-ascii?Q?mCzz4mL5bH8bbraX6X09of5g8SB2IO7QLyu5scrp+g+lzWnBotZ5CIwoiHVl?=
 =?us-ascii?Q?mgJ4ZodheahjN2HC6KwI7z3i/75VQI2b5ZG5hQvk1d1kPKZo5IdQxApSDV58?=
 =?us-ascii?Q?P7Whc/D8kVmwVq0286lfsXiozzk67DE0kdfpJTELyqW3U4n7NZPPoC20P+xe?=
 =?us-ascii?Q?H0rqDmO5TETUkfStYYR8UwzVrDkUMNEZQj7yCMfVs0n+uMwt8LL/TdwaCLBb?=
 =?us-ascii?Q?Tb84BKMB/mDKCpFQReuUbEwBGGdH9EMp0Hl6OFOoqSiwmc7UV+RiDD33vbOP?=
 =?us-ascii?Q?xZJzviOZZQToxMqtDFYIVXp6yHV5d9CSIElmOov87dEURzPrbK8DIi5jU3b0?=
 =?us-ascii?Q?afwHhntaQI/ieeylpkMypIaX5groXPp718zRDnLJJdVSh+IucX2OC+M6eKzc?=
 =?us-ascii?Q?CztVK9KpjwLb8m9z3F/2YhRijWic/5FOgu7GwxhFsXV+O57wZ6WgZ608zCqe?=
 =?us-ascii?Q?gUFuEhjZ/PZuYN8nAYUYd/15xrpMOAEooIIQiCA1nSscEDMfs6w3ZxKxAmL/?=
 =?us-ascii?Q?5hWDe9xu+E2Xn7Km6RMx8UorIolKLTLhYgfjgc2MengvvCQDZHxvdWI1rIof?=
 =?us-ascii?Q?1nrt/ej8P73HJXwhjt6OBLTDY9jWUUCYkG4z7GkPUFt0dhuSo2UXah0s54aH?=
 =?us-ascii?Q?/lbTCrxABMpLPTdvbNuD1d0o0k8nUEV5HVBlDfR5zwrPiNyL37HvzlSBNy1U?=
 =?us-ascii?Q?VPS+52Ynq6uFIFqSLo+h4apNLFHiFHmnpcb6DtVqM79iNLhUTS35NMWZeBCu?=
 =?us-ascii?Q?2xcOt2ay6ac4G/uZC1igcq96W+Nz8SkBC+CBvuu9YBKuZn05NAFhkxhvvE+7?=
 =?us-ascii?Q?IcbUomRPBTXBSapfbCZcicvmxE4OG4tuaW3NwjHgu0rnqnqDMSHgMUCU69e6?=
 =?us-ascii?Q?RWe4S0nBmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10b3996-e57a-4215-93de-08deecbf350f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:10.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El6Cd4mPUTMpSq/ySx2IsXhFnHew3Y+6e91h3mP6VB2vh7HgGXQa+91JCPBkya7U0Za2UUcRC+JA6JfJPL5JAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

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
index cff007d8b5e26..7ade08aa09dbc 100644
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
index 69ab59d176ce0..8bc83070720ca 100644
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
@@ -1053,6 +1058,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_resolved(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -2957,6 +2966,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
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

