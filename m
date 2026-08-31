Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8452D2C7
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183888; cv=fail; b=NiUpsyxRLgV3BOridRsYLCGQfoo/PpK8cVE4b2RWBteO3hZjwlpXAcPZ1uk/rO7uKeKYHfq9TPQ3NUX9XoyI8CjdaqFhHdMNKjd35o90xtzcjgCX3dzYx2d9gvoPbax0LkXq8qMiDsqPyARSNBgqb979oiIeK7dKBso70LMomqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183888; c=relaxed/simple;
	bh=35bvazm7SojRiBh3+gEFTUESQSsJxugCNIGyr7xqdzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWRKuHTRQiJed+bNNO9aivE7JhlvjZv9pYi4/ZaS08oekFJHr3EOFl8H4AB9vIXbE7EXUH2vaQIHSFLmTnnuyJ/wS3dJv6xpYY1KkMgee4jkIurIvuYY/FVd4O5kZantD8YilD5oyLZYZJcoBnu4gL6YIRGVkBAsjedIoR+JE7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbVGi6XQ; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbVGi6XQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrrrY/P02EA2wcRt3onoNlfrBVhEcx0ofvad0Oz+AwlV5EDptmCLE10XSNk4I0D6jxyn/omyT6sKN0vHqThAvHBOrlsVZNimE0sAEdSYsbNjIjaksq5gt0y4iV+qLZOunPl9c93KI5bdLDwufxv9BU9YV/ERGnePa1WkP8c1KP8kSc6FxLitirhi4kPCZIivjk6bhYlA1wCE8bvWZaKHvDUVBWWDwo7v0gkt8A474cYjUPjs/QAgEzzCMGNgDHSjH18CtaUfonwxTAvXhx4ue4wxJtUEwFMU4z7US5HDuqjmfs8f/NDE362h8M9cda8YQs1Tl6shEgog7P0JIjB14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLFhzl2ice/rw60n/fu6CFsm8ZXmVQxn1FCVDT6ja+Y=;
 b=WHP5zEc/F8eqHgOYjQwe/5GannhiI4SjUiyne7FM1rI+7Ail3Lf7X/IzoeJHiI/B/h3ACbFSpmhB2OS8IIFqM+5w8WkgKAo98DwD2hhIiDPWKAoLSji8i+mZlkf1pjcJvL2UvODXOwOjuc9okhQWZBrcNFYY1fyV+6R4ruhmBkFlMen2tNosawp3g4van6qU+FqPiEi7NPrbZeJSjpZpLXfkTiQc8+PV6poM+w0GCmItz+dXNgdL5bDJwAMIzBJ3Lq9h/5qV0z4+GBRGAKuslUVk5rkgA0P/kUhZrUSdUa4yno8miG3QEUy6oLVLVqG8SlWLKPwMmrVHo6JvzorjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLFhzl2ice/rw60n/fu6CFsm8ZXmVQxn1FCVDT6ja+Y=;
 b=tbVGi6XQsxyisW2CFBJoeU2RoLYXjEx3YOiwG5XtZfCKFU99MHwOzcRWh52FTeoQRCpWE8PGKD5GDXhEFqbKmbSILVIB1WjIc4CYGKEcUdlnXd/1Ooa6EuIuhPpgrLRRX8ZP71h9H9qkDF5Kc2vQ9IhD+1lLpGGkHeKl6lKwh5HRKLMc1mgTPUCrXpYNIMKjvXb2U/9NISMtEepY9SoaUaMNzZ7j9kH/V+CVz9XzvxAyGJqbZLT2uogYlSHGGRNl+qDpWrX16o48/nKDeIGp6zOaOkNFtt8THuTNAIwynn7jZogIuwISPoy51q6+4FFZyB4jOFw2IW/0Ovfhlz7Xpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:42 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] sched: Add sched_ext hooks for proxy execution
Date: Mon, 31 Aug 2026 15:42:17 +0200
Message-ID: <20260831134338.1531664-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0132.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 897eb2d0-75c5-4989-511e-08df07660295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9xDSuPq9DyqHsqYT45kLTGhKwau1GJg3SilK5JuxodK7R9cEBdcd9vyQLeV4gvYnu6bQXRhX77GELBkC/gk/2vHzkesRYBeZulgZLi/HCt5LvyIv/AdSdROD1xEhFPv5DBBMVxu+BQPkbwLGrWRj32sBBKDV+PSrqEIWm01UrPYMN5bXlrF8DMEcXrHsHnpv8iUxPkjwQu0B8NQ6vtx1iKYBf1VBldlu7EEbkOM8mEnm02bBBRRd5xTxvRGpu0NrlZj43DX8JzG1ue5aK4MeuMJk+EGHVxLCFM3QUtu6VLZQjm04vQORet36DwhQD2uCAC0Q+qQwJmGwG9pdJm7ThONMS/ncUeC+17IcqJC6iuo7LBXL57AY95IZJzJJY3nJqSPDoBwNm/2kgHYfXAgl9qRx9w49EnyUYFIWVXcXPxykAJ21WjkRkpe1OPISqwuscvbuezK67g/adRj8AexcEFFyCNGqyLLhB0wJbjY1tSSDG6nYHykmxkiX9poBBWQm5sYLCruCjtblnkHbgcifYrK/HV9vByTdbowJQAGHhRQFaCINuO3Z+SZ5DGBicyYarle2BUh86W0r2igQEcZjAUSPcBDswX1ocMeCLjC6k+yR5PqJgZRD9AU0BFX7DETLipG8EfS0Rw+GF5efLhiAJiClONw7Bupeio43dky9ODk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+LyqAOk9BDztNDd4KJt8WEUSRmaCgE8eIZIvAm/1RBnuM3iv+G3Xl5yDgZS?=
 =?us-ascii?Q?c5cAFjxLuKN2qr68S00r6cmqz7jM45UdH/3oaSVMeimz5kbGXB8h3rnSp89G?=
 =?us-ascii?Q?nUbBDBVCMJf8STy7gxSi0GUbDYgdNbR21tPdSb4BIKLcdoL/c8WaH5FD5XiR?=
 =?us-ascii?Q?zW9kjmkem/Ls9hGWBehR5acVAlAUpD/K/dV9oEZ37wfNP5eQ+sDe18tp8xMl?=
 =?us-ascii?Q?HDEgHOJHnEh+bY3GpqyLg/hYNmXcQtMw3CPAFhqdbMdqC64jbLbvcgv6zr9j?=
 =?us-ascii?Q?m6C18uZEnGNkBk4bJUnorgPiyYk6sTOaOQpWoi75tsHq2nyyKDGO90o6yuzb?=
 =?us-ascii?Q?NHwj1LT2ldpCRgTgQAA6kRzm2ovFdfT9SCwr3Y+TEb4QqWkC0y83O6Qw7LLB?=
 =?us-ascii?Q?NKGbggibVjWt6WijBjOIYtzaUxIbchk14ylheA69N59Or4yrXfJ5m1bqNC3G?=
 =?us-ascii?Q?ZQnAXG3snj11AXxxZgp3rly/ASttexsvxD8bYwtTkeWtSLqFrVy4SCy+kSFx?=
 =?us-ascii?Q?vaDABtmxtkXQufW21nrYHvpTGSbkztwdAWMzLAB7nd0DOdJOyiz3BIWk7Ag1?=
 =?us-ascii?Q?+B4Zd8VoxYo89LRPL/cy3qaJ58fGUPSODkN6NtY/NVILRmsKqKxq7RZfSBvj?=
 =?us-ascii?Q?YxvgHQDQxarCT1O8B2iYbJU3L/z2M/hYYFw8gwNatsOvJ7MAUJVfRNbkbFhz?=
 =?us-ascii?Q?JK/IOFZxBkeT+J2YXD7TlBuM8cTQboT+i/nLFz/MVHS0PZUwFWvaIxr3FtnL?=
 =?us-ascii?Q?Iile+Fm60ZIsmJEj87SJSGpQBB5ud/x87QUKr6vF3LJR9OP1+4Gv3cUPM1kg?=
 =?us-ascii?Q?ayCWMTPZpo4ZNsjpCOvJ1zjKpZ+KqFiyADyIu8wuN12ixeB6WzJXEl9Qn6XP?=
 =?us-ascii?Q?gdJLGZexCfZCxVqShgqnxeJS4Rg9haqeqHwIKoa5duTnHQWh6TKq4Zr5Mw2v?=
 =?us-ascii?Q?9Fh2EAEslDiRSjn0F+TesfEMc9jhHAz2F5t7rZF7O/H6krrBUOrrC34R/Ypz?=
 =?us-ascii?Q?jBOLH3dkgt70Zz/9+f/R1FYD5xc8p7LNtBcsBAEoQ0laG460ceyNHVnmXA6X?=
 =?us-ascii?Q?fdit/fDnpKErsEe5L0eqt4NUQ43WPXxInxDwP4NE9lT2qVzKblDXqWR8eDJg?=
 =?us-ascii?Q?z2FEla1Lk8mNN0mzcsOEMVNzwNKXwNZ1QLV0RfP9gckzpnO4rr9WiSQmaLSM?=
 =?us-ascii?Q?jYpuWW0+VcID5lLbjtBv5JpE9AuycHwcpqKzs1S8VpgY26nLg1H5uLyozzUr?=
 =?us-ascii?Q?B+27ygPdmiWUQgX7Ym89ooXi3NY/ovlWbsznBtTX3+Zd/0rIaSSuNdijFD2x?=
 =?us-ascii?Q?LheXU5wxRgnQBgy+oC0w6Islk7B2cWPaeqwYe4eqZxl8dnf3Aw61QMt6n2Hl?=
 =?us-ascii?Q?B4a6Yk8TCzHr1zHLwIiBOspSw2ydvKDjuXc/To/9yEHvKYPClHhATc/2b3A0?=
 =?us-ascii?Q?ZkMMExilUbRkZHknlg+ueIlCdc9PFoln1arcBhvPdiKDfwr2JqCLmCIEVZXf?=
 =?us-ascii?Q?iaRVIdwzlMa5B6jkCDdRaQ9coN+D+z+sirg/woY7PbuamTVRZrOOvH7e7Mx2?=
 =?us-ascii?Q?8vlc4USVYr+wHaQAnD4g4q7mkERZOZhsnQWjIam3KfrKYDdEa706pQNMRm4p?=
 =?us-ascii?Q?QzdPCOp3i72XITKU7e4eFBGB5nQTtfLCIGRgelkl8z41RjAxu80i9iR+jCyV?=
 =?us-ascii?Q?YBJ5p3zOGhNAAtot5vX9uVMqYLjI2G9UNkL6VCFuQfckEWbE/QtndMEq5dAp?=
 =?us-ascii?Q?oNigvqATMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897eb2d0-75c5-4989-511e-08df07660295
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:42.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRMO56eqj9Jw3nYGp9f02+JbiaS1Hcj/hIei4iDPdrcBJkxMlmCPydAhjsXqznHkbjLn4dVwXZfjHRRpE6E+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

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
index bb79fcfa21cd2..d578dd635f2eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7217,13 +7217,12 @@ static void __sched notrace __schedule(int sched_mode)
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
 
@@ -7244,6 +7243,7 @@ static void __sched notrace __schedule(int sched_mode)
 			}
 			if (next == rq->idle) {
 				zap_balance_callbacks(rq);
+				scx_proxy_resolved(rq);
 				goto keep_resched;
 			}
 		}
@@ -7264,6 +7264,8 @@ static void __sched notrace __schedule(int sched_mode)
 			donor->sched_class->put_prev_task(rq, donor, donor);
 			donor->sched_class->set_next_task(rq, donor, true);
 		}
+		scx_proxy_donor_start(rq);
+		scx_proxy_resolved(rq);
 	} else {
 		rq_set_donor(rq, next);
 	}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 00c368e2fc82d..f3e59f4fad4ac 100644
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
@@ -1079,6 +1084,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_resolved(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -3062,6 +3071,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
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

