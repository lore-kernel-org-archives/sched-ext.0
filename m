Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FB348C46
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321515; cv=fail; b=q6eXJVt9JU4WkYOnWnE6w5QwgDGcdeVP6gT6WXNST3YbYJh92O+B3wB/zNCT1AQxnB9WDl3lhhMcVANuI2ghtrrqQkO2Gpd3E926tQe8r9DE7bIYVSx+QPbQpatuGsi387/tawNUAOnRZI7RLMvw36V5W1WyvhmcKVXQY6jJ+dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321515; c=relaxed/simple;
	bh=2+xrtTkR+nl8YqsZNm2Z+f48aWjqbheNBZ/TgRfFsB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iG7o+o7lpSBsiOss0lAh9Ef36zeAXm3tElxJkPFwCG52w47j2stPJm/7BmGQ9x1UsPn8ec/RzhrGjlvkhPyLlVtLeY2PS4NlPk9Yl7FVnw8F/VaxHqCZnN8wSdx8CQc8naxOnf4+2+5/RKZMUWS8pOiztAqreCA7fKT5IiqWrws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b61OGoKe; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b61OGoKe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icHXhUSoRi1P8NpCYb9fLWH8DG4s4gM/BKNxgZv3QV1dY8+dvqSIpBux1PjYmQ7wnbxF+1vRBDJrTZBzuItHsyMTJYyGXWI/OQP97sHIDb3VgcRPPM82ZHMyb1P7AiewPrWxUJMkldhj080C2f0ctSOYQ8szhoboReRj7NbnnNQ1MMt6kscL+HicmHFUcEmljKD0HGA/Oa4LgVnKvDqxQI4SShBaTpCXFf0DJDOtT54l4a176P6ciLzLU36wK+bRXkn131w+JuVrYUQonwBJwhx0DNfVGIvZANYEK7y2ZPTy0CW9ZsABvJ4obkLMAVYbn7d79atVT/TIvyzVg4eAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp9lqvkMGcAHkNQ6JRoh9MWeBxiK35UD9j3d4rgehHI=;
 b=OWaS/2Lg7aRg42xaYK055o4TOQ926jZtuKjXhPll4tCoZmfozmcX3UxVsNb+4KRghcVyhSU6gvX6xwFc/y+KPAtr8Aiw1iy4Sw2xZFYljBryvOmL8zUICvChXXT8VOZWXbNUdVOSoh9nYt9aoIZPrZ+lPgSJADsiITw72aVjjRH1Dvmu974NO4NBtt58nbpavzbmzBs0R/8gIVFrlG5hz2OSjtFmmFCZZ+xrc+fGk8NhC8RrtsKlaGu4o3tM/qsCdow8+bCSBvM6w0R7PPPKEhHmjP/hBlk7rjmJlHGP/o+HmHNcJqEFFQPIgWIIs9yfCLbXJemZcd9O7mI229nnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp9lqvkMGcAHkNQ6JRoh9MWeBxiK35UD9j3d4rgehHI=;
 b=b61OGoKe3bcukOvbFkoEd0ftNw9SK1VGkohIlZuIIOg9tZ1inHi5MLj16qCXuq14yRNNJcVs9z9+9r2lbxiJdhMiKMsHPAjRLmqTpyuWQr4lD6+b1c0AYgELDp+zTbPhG/ZcVohnnEuksUHWHctL3scx/9yWkmjc+AHUeqTiBUVpYwbA5EuEAERV+byaYu6TnhLkvUTkB45/LTV0hpHpZHun4K+KOt6VQyms33DnnC+83xBAkZcMjv1t6UXZlrT4aMuVF+frsA3rzRJV3oa1a3m0DoyoUzOC3dpX9WYbGUpScNC3ZsNFd8Vo7CaPR6zlaLihLtuMBR7U84a8f2TXaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:43 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:43 +0000
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
Subject: [PATCH 3/9] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Mon,  6 Jul 2026 08:50:58 +0200
Message-ID: <20260706070410.282826-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 402f16c0-17b5-42df-3d43-08dedb2cdb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/iZYHP1TMsNl0at4d5Lk+lU0KklNuaFd/OXr3pUeRu9BzqdfIU0UvCy6ZApXNwCLFcV8FWVuH4nLWLcs6sOpZCD5txkXKdKW66CsAoh3rPhLj2HLUbv4fcPUIXdpjj9hVPH+3u3fh0Vr2enq+3UGi/T8SmJ/5hp7mdUqLqNYzYLlhv2JDTVlcwNzipJ16sB9HoyHjv2Yw/wi6lQjcRIETJqFQVx8ZWV7MDu7skOFvzFf7QmHgIGosVPJtmdCX+pi667H92h1tvWmIEZ3yOL6f8aeI6Z/bgJYYuRcLNtUqppjrjhrclbo4A/kTtqsxwTBHfo9b9l9yZKxDCF55W+m4EQXbOsQoAc4mMT/P8AXqNFr/B0GWfMHStd78HXktEMPGWb9ABjiRa0VkZjA+WMTxTJ1FE7hcqzvzJ/kYu0kEwamrny4Y/BzEabskN1Akf8/J6HKplkCDHforRH2DH2OXDVXjvu1DqRt4WuGA0JW10fjWPMfIrUWuFAPTb/hT1qxpwcRT3IsCjcqDC5S4p64kW0IsfjV74dzU6HeRg8tHbPrZUf/D/j9HINoinO6SrYuBCJIcEqlG31pN0FUvZ9+iv/mPTksl1hzhmHKLYmp23G2ve7X6pf2rUzu1f9EiVHzggahALqZI5p/436SWIZNi1G07EOYaVCf9QNjhhhIO1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1V8mrcc3HVflfKj19BhckOH+b+rl3UKPVQS9gchVULKjB/RM6jloom4LxvE?=
 =?us-ascii?Q?2tYi/zVEt9fD5WbVG5sUZ/LHSg2tinmWxA4/2BDBNq23DSztFYwNRWS9t936?=
 =?us-ascii?Q?La3m6o2i1JvlIR/d5wGJAcg5NQ8GqMmjINUwsfaleCqGPF/L1+1pK9KVThX6?=
 =?us-ascii?Q?cDF9GW/a8GGV9Zy7couLWZ83foxKQFiXcnj96+k8c/Vrd7RvxTxGk2V80dJm?=
 =?us-ascii?Q?F94UvrgjPVsE8sp5H/8UItnLCbvq69cu7mY3pqnVX+2s5BoaW2cMXkdLm12b?=
 =?us-ascii?Q?JuwZJxIfB3Ol4nlkRwotO5mRR93NVuWYyKYLqcOaSsavyzy+kgU8R2FUUtmv?=
 =?us-ascii?Q?6cYvPQnhEygr54r/K5L4hroKa1wrb2U4tnHO+rzi5nHfRIay7OszgWe+mzxR?=
 =?us-ascii?Q?sLCzKTlbmyeO06JkFj5uccztWjLS7hfoxKd5fDLNIyXc0Z988cU6dRoGdWIA?=
 =?us-ascii?Q?clOS7XH6z7kIxxyQ6FDvr52lcJiUYaplqZ+b6mg9EfmFjG+k95lhqE7Km+nW?=
 =?us-ascii?Q?DcDhEMy/zIWg8uXLEdy+koZBhez9NoIVvtU7lmmOwdaJz0JwAsR+GD/Fm2a+?=
 =?us-ascii?Q?Bvs+EFAIN9OkK20EQVM3FN4z+j8iiSRwa+GjmfPrzTqsNFczgZSfviVb1wYc?=
 =?us-ascii?Q?bqu779nCBg258h5hQAg+DFhvAHuXkXioFkix14WSBb0C9evVHEQlieuGqFjF?=
 =?us-ascii?Q?60DUU4clhRMb3rVRyqMkbbYtZwPXDcUUegy0tkzSsE0Dza9j67QeI4mmG7Qw?=
 =?us-ascii?Q?/q4P9RRKw7TJf+5d8fgc7TVbBSfYp6B3chkO7+PCrGF6ocBDHf3zA+rZeNfy?=
 =?us-ascii?Q?MptH4Ngzt1dJVj39HI8RRhJS/lvHoptGQJ2YUtTqjCgjqvMjCQJtVf068y8K?=
 =?us-ascii?Q?iWgAaL2TyRRLh7EfwlFGKX09wUe/YSa0XWroj0IirM4APsaArgD5eUBBOSfE?=
 =?us-ascii?Q?u3dc8/V/ZKEBoGDiZI0RSWwXmKUnK3xk0riANPIuM7VmYmv7KbZgsP4tB7AS?=
 =?us-ascii?Q?JBE7MSham+3nwkAFNr24zUYKdQ9JuNlTIDpB57w2VOLWBEFboVdDyTxzbPEB?=
 =?us-ascii?Q?29hwqUUBi6E1Ha1gJJyhcdgxUJllFgOrKpSVDRPuS51dSCB+aJqV1h1gYeJQ?=
 =?us-ascii?Q?fJ2Lfm/U5YLSWsKv62VxfZ6O9l25mJjrs0PlEH7rbf5TVUi6meFNC1SqJgcQ?=
 =?us-ascii?Q?iHewVDYz5JZQorEeCRtG5q+SBKN2QgYeqeN9uSBFVNx/Q9/L20avrucZmN09?=
 =?us-ascii?Q?9FfelSKAyDMdWI1M5JpQynpBH+HqmATgzDz0OjkUGPn6SRE7P6uVi/Qz8Md7?=
 =?us-ascii?Q?jQCsFubeJ/uPmIKMTWwz5p/lffq4jTxOLZHuI2J97STlLTIHFYFXK1vGOc76?=
 =?us-ascii?Q?FJ8ToS5Ler+e+EAgM6WkZkWiS/cZAqe0BztagcUdDQEa1ShNJwvH64s0jQfV?=
 =?us-ascii?Q?EKFSVUozYI8X4m00UHcjZ3OmI54fkyIwpfSR3IR0oHJ8335rmLzTV9+dZOKS?=
 =?us-ascii?Q?BFguSbskBg5b1mqAyrCguuwQPF4YF82ro4dr2Zj5N6Du4/czVsXBXL3If93i?=
 =?us-ascii?Q?JX33qr66C7icS2/V0yJ+u1u2+5x8go/EYScpt0CKS86Fk5DvaxCaCODAPapr?=
 =?us-ascii?Q?7hgKN0hXG/qg8lq/bH6oTkG4Dm0Jprbeb//OkLswCgxZ3sTef2JdYII/87kS?=
 =?us-ascii?Q?SRkjFkzfH3o08roM+jaQBZKDCkSSwHOy5nSWnC8ZQOGuX4WYgjQQh+MBDQHw?=
 =?us-ascii?Q?AWhd4GfKNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402f16c0-17b5-42df-3d43-08dedb2cdb16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:43.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvsTQgnhg6zBrVNbWBLPiUrtq2l2nZsKDdvDK9EBSboGJZr8sxXqZG9apSwdWvGpBcLYS7RRufGVMfVnz+AeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

When pulling a task from a non-local DSQ, scx_consume_dispatch_q()
checks whether the task can run on the destination rq via
task_can_run_on_remote_rq(). However, it then drops the destination rq
lock and locks the source rq in consume_remote_task() ->
unlink_dsq_and_lock_src_rq(). During this window, the task might become
migration disabled, making it invalid to migrate to the destination rq.

With proxy execution enabled, a mutex-intensive workload such as
stress-ng --pipeherd 0 can trigger this race when a donor becomes active
on its source rq during the unlocked window. Migrating the active
execution context can make it resume with IRQ and preemption state from
the wrong scheduling path, triggering sleeping-while-atomic warnings and
subsequent lockdep corruption.

Re-evaluate task_can_run_on_remote_rq() after locking the source rq. Use
a non-enforcing check because eligibility may have changed during the
lock handoff independently of BPF policy; reporting that transient race
through scx_error() would unnecessarily abort the scheduler. If the task
can no longer migrate, clear its DSQ association, reset the holding CPU,
and enqueue it to the global DSQ instead. Normal consumption filtering
then skips it on ineligible CPUs while allowing an eligible CPU to pick
it without forcing it onto the source local DSQ.

Also reject tasks which are currently executing. Although an on-CPU task
should normally not be available for remote DSQ consumption, checking it
explicitly prevents a stale or racy candidate from reaching
deactivate_task() and set_task_cpu().

While the destination rq lock is dropped, clear the tracked rq state and
restore it after reacquiring the lock. Otherwise, a nested ops.dequeue()
callback can attempt to restore an rq which is no longer locked.

Closing the race and preserving rq tracking across the lock handoff are
prerequisites for correctly supporting proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 62 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 242f6ffbba350..4c6cd694c86db 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2131,8 +2131,10 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  *
- * The caller must ensure that @p and @rq are on different CPUs.
- * If enforce == true, caller must hold @p's rq lock.
+ * The caller must ensure that @p and @rq are on different CPUs. If @enforce is
+ * true, report violations attributable to BPF-directed migrations. The caller
+ * must hold @p's rq lock to avoid reporting a transient race as a scheduler
+ * error.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2150,6 +2152,10 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Don't migrate a task which is running on a CPU. */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2240,20 +2246,58 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq,
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
+	struct rq *tracked_rq = scx_locked_rq();
+	bool consumed = false;
+
+	/*
+	 * consume_remote_task() may be called from an SCX op with @this_rq
+	 * recorded as the currently locked rq. Clear the tracking while the rq
+	 * lock is dropped so nested callbacks don't save and later try to restore
+	 * an rq which isn't locked anymore.
+	 */
+	if (tracked_rq) {
+		WARN_ON_ONCE(tracked_rq != this_rq);
+		update_locked_rq(NULL);
+	}
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
+		/*
+		 * Eligibility may have changed while switching rq locks. This is a
+		 * kernel-side race, not an invalid BPF placement request, so don't
+		 * abort the scheduler on failure. Fall back to the global DSQ, where
+		 * normal consumption filters can select an eligible CPU without
+		 * forcing the task onto the source local DSQ.
+		 */
+		if (unlikely(!task_can_run_on_remote_rq(sch, p, this_rq, false))) {
+			p->scx.dsq = NULL;
+			p->scx.holding_cpu = -1;
+			scx_dispatch_enqueue(sch, src_rq,
+					     find_global_dsq(sch, task_cpu(p)), p,
+					     enq_flags | SCX_ENQ_CLEAR_OPSS |
+					     SCX_ENQ_GDSQ_FALLBACK);
+			if (sched_class_above(p->sched_class, src_rq->donor->sched_class))
+				resched_curr(src_rq);
+			raw_spin_rq_unlock(src_rq);
+			goto relock;
+		}
 		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
-		return true;
-	} else {
-		raw_spin_rq_unlock(src_rq);
-		raw_spin_rq_lock(this_rq);
-		return false;
+		consumed = true;
+		goto restore;
 	}
+	raw_spin_rq_unlock(src_rq);
+
+relock:
+	raw_spin_rq_lock(this_rq);
+restore:
+	if (tracked_rq)
+		update_locked_rq(tracked_rq);
+
+	return consumed;
 }
 
 /**
@@ -2363,7 +2407,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.55.0

