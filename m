Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C740B371
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959704; cv=fail; b=jBgIFczeRr9CLSLJ3ZuByQeSUcJka1nAQhu2C1QK+8BOE5K9HT0PvtVct9YMGX+kq1c5ia2oyPIEDaeCvL8IOC+NWOfHWDpqQhqxhZRaHtE1isbaUVQEv/q1TjrDfWDp/LTftkUz0qQc5mFx/hQhOjiDGvt92gjRVkTfL1avYaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959704; c=relaxed/simple;
	bh=q3ncI1jkerQczSKdepEeJNMon7U3tBEPkMXjYYnjYTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAZcvErzDo6W8GaCWxJuLwZJ0XzsbhX6/AvMI4jqirdFmcGEt7k1/0KMEGnn9QqIwyD/85FgmfUoXctj5ykR8iRKvH00qQscygBoO88zb9j1qaU2aIvJizly5rABP/HW8mPhNjwHsH+I6n3H4eeV+MjuET7dA3mi0jiQYf7zB9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elVFCp5/; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elVFCp5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu9LeuFhX/SNR4PqDzKd8FaO/4ywOXUCfbVeEJtsw7KC67O7hG20u8+bjpaIl1IQGesVWt6XrE82QknZ7EKT1hbu93MA6PxCfneXvdUDnCc8hoSjNPpNrZvSEPD+jtDev8m6SrnIao/EkO5pUOvPMafIWRXP4l2f0FBUUpukYEaL111ZKVkggVYAsj9T7KaRAwIFxU9IbUn3DVu7zxycbWA9By4uQOgTMGw+OCuB2XyFaxNseas1X0dG1ry1U3f0frN1gEtAdclOqVgFN21hNh+dHNbAmzP0M0bwJOT7Sz7O6/HqjOowKgbPMKtK/llZSbVtIzkHF79e15pw90hRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQKjXPTJDieJUTyJa94+9lSjq1hX95BV+60krzKL8gs=;
 b=sGkCk2jHW8EHgx6Xj2cAn5drHNLTd/Tnkds3RoDoVvEtwyUzNL6uDVEFXFKsl/DccFL7Rywlpr2iDxgV1hcctDoTppr4qcUJYObSX3yKHKIHmKkrXDKXMgJ6Kgc28YfsMBGGEWfK4Dh7QlQIz3I6Pf2O+wy9dqEiqgBb1uFkrf8JvTvTxvnzE/gtwF0oXVRsv8R/oWpPuovhCke2ZoqjMHi8Phdx5GkxlYwuqMv3VHkcc6hR6GhXj22eJxCPMWpKOTzA0JPl6nh9wJiMkbAnsuaFNqfHBmPTyZXclYPvVNN88EA6DlctaOEE+AZT59AHGVmhF0CvEZEBpGT3Itzhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQKjXPTJDieJUTyJa94+9lSjq1hX95BV+60krzKL8gs=;
 b=elVFCp5/Fg+xL2BUJ1Im4p6UllUJkDvxAfEy7juszql/sf9tIiiit7pYmvOwAN+DWe/voKC6668U5VdZhToZUc9XUwcWsdqcX1hiTZpRWYGjpEB8wkp95yJv9zzprAZGvXkhJV50IjA+WAIQlT0W6rHmo83PPehyMbLuX8uNlOn+jDhO2GXngw+NtTtVA8gS+mw1xMa6TNPNJopSuMGt6el24XmfvQQuVB943r5Min6sxm3Bp5SurDqyOy1IqcSFJ+tNG3i/KaZr3Y16nju6VzU2e22nAJqJ05tc83rJLZ3CCftBQGN9wZwQiMMblZoRDQOv0X8NqBHuWZzzuCo5wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:32 +0000
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
Subject: [PATCH 01/10] sched: Add helper to block retained proxy donors
Date: Mon, 13 Jul 2026 18:17:01 +0200
Message-ID: <20260713162112.26785-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 24de90bc-8ac9-45d8-bfce-08dee0facd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xUgTcy6AcO+jzVnOOlC8xbknHp5IFwI73hqtAn+HYaReR0SiiKsCHNpcwygcJ6KOxZCYkFnbmshdBe0IIpRO/LuuKWbtbaxY9GYG3ERfXhLOySndwMirP7YdLNQQpBQD9xsNhiKE1/cTWSH/oPxJY4nstkRGvy3+kXPffWtaUYliOoYEyPCkFTsIK1EKuDGtjpvZ0d0PR1pPJulCVIEvD3GpfpNni9qXKmwyQkQ2Xyu4YHtcbPTPJX5dYhzFwl+t8mBxeehUKkYhi7Q8NLbzHXH6DGJKL0gnkD0DqjviHzHVmgGvY7pMCfB1OOud7rIpKtgROXIYgl/h6B+dE0nNoa37T0kUZmo1fimT5i+/w9S7lbFuJ0HAouvEKdRp28cR8EqpD5mldCFAQA4564xkvvnN1DV5lN218vBE96rbSIK7E2h6JJC3KeIM3DKm4VLhy6m7I0NONPoRKfcaKlU2xcuHudpzNC3YOafFJRJeDfmEikVG1djJpS+93wJiNvzI8pM7xdBsBZHkB4A6dDKb5dn6SjrU/38Mp4DtRDoSDq/vXMp6W3eKQgln9jRLLtkx6e1r1CQ94tZWLi7hJrWjRfjquf7k1VK3cBCN0XAlLkob1x8EwqnuaeWZBPqSAkqCTuv/IGhzL0v9hMl59MT5QPldE9hgA2LbzbtzEbq6P+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4guj5NJERWCD0taai14ICm1V1pRj4VaMh0rQhhung4HRS9psPioWDLAJ+p+P?=
 =?us-ascii?Q?Qj4WiIeUed0IfOShzMY4LJIBtAMOxZu2IVPktosj9v2eQtKEn9RB4nKZjElK?=
 =?us-ascii?Q?BRVRbXTA8GBZo/YPSq3aMnaH3MQNQsYzaSnROfXUBMBKypzpX0Xt6N7tVO4l?=
 =?us-ascii?Q?siqYbhvrVYQt2BYtQW5mXYMlRwTI6zCrMYD7BbwLiAc54g22LRBtyDxQg8p9?=
 =?us-ascii?Q?pnjUdxt1NDPsuI1YThn9KeKo3DYncV773gDqYkU8wM/gyon+7c1PX743MI2U?=
 =?us-ascii?Q?D0iXYQF7eEqt+NnNEnigQ+C98+MCD9TmaiGJow3dE87N5u2A4+o1BvRuKiGN?=
 =?us-ascii?Q?DB1nAqI1UbxY2uQ3ferzmq7ugEfRKaD7MA+H/wqcUthBWKqKloUIv/d+8u3g?=
 =?us-ascii?Q?8onHHTXI/UE/V8/2mhQ8awcBa9nsknTUWFf49fYddG0HSR/jI9ToWrbaiibv?=
 =?us-ascii?Q?RxJxv0UH8MPlt0+ZPWKZSwVi+6ZIxASa3Znf07PBZXkZ+7Qr3DedRkwkaLbs?=
 =?us-ascii?Q?QzSld5/d3alieZSLAJpMc9wP4YK/R4cIswcQPAjSz64ostN+RgEWOcpHTilK?=
 =?us-ascii?Q?URcKcchW59MddtNqNGjTxmETBiu3UXwsEYfy+aeaotO+XSDGLsbMXpya1/ut?=
 =?us-ascii?Q?EMwIYOEJYtOJN2XaboM5orHXZ9/oSJpWLmL2M8WrZlRRHAkyZk6jP31knPjc?=
 =?us-ascii?Q?xgSwkOQsV0RSho0Ng10NY9JLcSafG/DCBGdDRnhLizSmfGM9d7haZvTETcPT?=
 =?us-ascii?Q?58HRxbOQKtgdhP+T07ltYLy98dRGQNwlDvuYwyoZVZCNE+N5fFCtS1affhuL?=
 =?us-ascii?Q?cYp9OU/+Wr10XJ+k2FpeWoJRmyFquRv0k5Av++TSI21Wob3xqKAsfK0ud6IZ?=
 =?us-ascii?Q?GIqTuWwP/f8U5BraO8hFKj3r79oidSvtJiihn4GaXBBCv4LH3YU1aLl046Ij?=
 =?us-ascii?Q?nXp6sLSbmWfEfN40n+HQMaHBuYplhF3DlQLCYPw6ZVwbpQFevHO05sbrQ+Af?=
 =?us-ascii?Q?A55eIizWOyBscY3HQEg3H/sFjd2knmprr5uo/kVh2NvyGTF0Dwir0V8zm986?=
 =?us-ascii?Q?Yaev9PVTzJAEQQJ8HnZt3G9rZpwmS641bDsiE/11mZffUhXKEB7J53ZRfp1n?=
 =?us-ascii?Q?1Je2DwMRhMAoktyfDFcCYYKJb0xe4sJHQhE1VZD+a4C9cXzUYPhK1W0nQr7x?=
 =?us-ascii?Q?FWlUlJGJOo/WQ2OpeFyqeGm5qTKBF03TvPVNluEd7aKBvofk9RWKRTXUrdAR?=
 =?us-ascii?Q?JN0UOTily2MS/wimT5HlvmKG+QzMOPXa1ybfjkU6hwnESK8UmMZO+qAsoIeT?=
 =?us-ascii?Q?rTRpRPCNh7t8e8ve4ZFkA3Nh1e08KXxEMRFxVw8D8/FFgCD8BiVMOtOI2kfY?=
 =?us-ascii?Q?2WhtUWxA87KGVh9AtreG6s9pq/QCBS4bRX83fGuNccLCsHKxNReO42rkgCk5?=
 =?us-ascii?Q?CfZZ2jjMbxA4YeOOYTnAI1KeWY8JwZO8dSVErCMgmD9jmEwOLKoQdoXYzTrU?=
 =?us-ascii?Q?L6ouMthckyfcs/kl2aRq0QJZvDr+02Vq2PRrrhdQEu6N5WkVlO+TbU6aC2DI?=
 =?us-ascii?Q?R83T0SC5PkPOYraD3qwohmM7DdVMBQVrejBdU757pT4AKp/r8PxOIUHy6HhP?=
 =?us-ascii?Q?tf1Xusbb9W5QAN+ppNVfpZfmbDvz8j0s5pkrVJHK3+vjRfA1zVKkOadkuUi0?=
 =?us-ascii?Q?seFrzyLLotLi3591vfnez/V/fxLV72Vi8aL59DZvXkCyiuVewCeHKG+EqyK5?=
 =?us-ascii?Q?mz26j8gG+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24de90bc-8ac9-45d8-bfce-08dee0facd39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:32.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6CXGvngpFuWUI21S8Pt37c5vnG4Z96N5zj0MEbm78m0ZTBF78LawWRn0zk/Xyq7hRgxIEwlPXFlagW2PM1GHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Move an active donor off the
CPU first, and complete any delayed dequeue so a following sched_change
cannot preserve and re-enqueue the task.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..17f37ad639680 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,45 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
+ * drops it from the runqueue.
+ *
+ * Unlike the regular schedule() path, this must leave @p fully dequeued.
+ * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
+ * which would let the following sched_change preserve and re-enqueue it under
+ * the new scheduler. Complete an existing or newly-created delayed dequeue
+ * before returning.
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p)) {
+		proxy_resched_idle(rq);
+		/* Kick the execution context if @rq is remote. */
+		resched_curr(rq);
+	}
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
+			     DEQUEUE_NOCLOCK);
+
+	WARN_ON_ONCE(task_on_rq_queued(p));
+	WARN_ON_ONCE(p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80b72d934ff37..dfa0cb722c00c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2471,6 +2471,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.55.0

