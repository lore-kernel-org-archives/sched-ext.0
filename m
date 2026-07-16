Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B07423EB4
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208213; cv=fail; b=SwwhX7pG4sg6ZU5Gy59uab2YdynsAxdLvwM8w00xpGWCKjn/QbS1CI7mMALRvkiIGOrPBSAE7q9XNs9/oLEXtjt9BLtLTe0XI4k1s8cUq2Kp1WuWNY2NxFUnv+X8wKZdAymcJjbRjkmDRa3EG58QtV5m8pog1NNEN9mgMG5Yw/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208213; c=relaxed/simple;
	bh=B0AkcEBJZkmG117kVX8/bu5GjSGzVLMLgcvWlb1XW1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=js5wNuDXnm1r/mSFe+4gBlTTTVdQx2jVGa+NSYRkqWHSoQqe5lqyrnf8f1h+pY2WsKiSLGUqqNvE1ddySqsa94EAOJE6c2KYLAvqDe3dGSwwSpiyg7iXNsa+98jJ8HdcBe/MplP/Psv375i5FCX3bFEU2zbfCBmFCViZXBZ5+t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tKNuYfyl; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tKNuYfyl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ6n79zZs0C+f7eKaO78KX/em1t5SPsY5foa550xz+vFQm8ychnwT2bkQFkDA89obPNiP/1xApO7CAmn6UxmpAM76SMqlRV6M52KjQtUPgnatXyHENh9+mucQ6RRxVm2t4JGGYMlZlLr+TM2Zf4KSbzMgmLQ4TKSlosyQZOKQiILVe1rGaZigk7YXBUWh8vm0FniMkgke/j8T5uD07oRZf6GRhBxnuVdvvV8ym78V79Zc83rkq0GXdW454jjio4KjD9R4hYOKRECz7xyQbr8CA0vnlSnx5ZtLsdrxt02JixtzrDn4gT1alJLysCzdnzlc6AyrCUGhkExoyTYszivgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSJfnhoRYw6SsO/Kg4FWWuiUIr4S7awzbtvH0hf2Vp4=;
 b=dhHfIZRPNVxZOIJ1M79iDHh3brxtG83VdPEMWjboDfBGbXZW11DV7xrnnJPBtrD/hROeKPA+OuSfHhAlV4hUd/2YavzytvWTq2ucXY67GMVKmUokGV7PA0cYSjIj2U89kKMtMPXVTc81s0GCxPOYwjaTJTnl085ZHvkdDv/0ulPcyKst5WeszLmYMe1ydk71vRnS7lz48amr8yH4/oVSYM8tyCA642OJlDEQW4RgIfSKl/OXXdNJSiRtDRxRfsA+0kLO1g4qJwQZGpfe2pEJHuFXjd+rzROQzpkVJcokopdTz/E+dpwxh0zhSDIF3vAq8l10PWiI9E6T+TzTJ1OTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSJfnhoRYw6SsO/Kg4FWWuiUIr4S7awzbtvH0hf2Vp4=;
 b=tKNuYfylOGiGEc/6MDUPtilatO4EiTb9KuKRbcPiKhuZTetelnkhfEC4sxScR9Byy77X26ni60gOGfcxgn/q0TmyKOrwd9iesQZCP1kUtDIYZlWu43m/iPbYiu2+xxLfC2b+0URMNX3NKtsKzJrvawWVveX++dPdNJouyWL+Xlo+DKT+f/58cHh6YhgxGs1hTtSuWczYgZrQE9Md6ajyZmerzjauSNQ1O44EdSQmB3vRrHhBUJyc/08vX+BihZdX1tKRgF6gHz04QfcQrgeAjUBHtK6XsaLMF4P5D609Zg48uz59ePIOHsPjdQBnRLjN7ZBhDu65wy0ezojRY8+adA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:27 +0000
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
Subject: [PATCH 07/11] sched_ext: Handle blocked donor migration with proxy execution
Date: Thu, 16 Jul 2026 15:20:42 +0200
Message-ID: <20260716132229.61603-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf995ab-ea8e-4191-ce7c-08dee33d6b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kUo+pSsRGgUFUkwg5NGHVo7+8USOblmZ1rNDxt+ej253zhr2IERkmJLVJlQS1YKWgJ2SmQl1Q82XBGdc2Hd+zgzYRAnT+x2UVeJeY9uxkxkb8mZY9fwSUEz2E0YFVJKO7y2jLcuBtuePCXXfqyNtRqrFfvpFigEl+wwXp0NFKkbUZQ7g4PE8Ej9Ft1s5A8kgbIhsX3prUkMJi1fXhTH7hGh0NuzTTqo58MJWIA+qOYDRv48ffIOUuk5CQB4QYRRjQ4Giiag8FGwRo2kNR+xO5N9jVyuV0K0GFPV33ZM34pGIDDQCQUmN+Ehm/UDx+l0tKwgp7MDHFBbHfZnxkFhOLxqg+oPnpEicLvLJAq3KwcGMylYjShd27UPEZoVL9B8TdAL1kwklRRfvWcLLx10LRg38rKmUicrHVIG7KJ44Xn60bH41R+f/nJV26/JQpqExMD0nj5mSOTPsrbopOU+2KBA1pkIe667vbkaIkSb56TclKZTvo3I8k5vHKAqFm/vTyLd/+5pohCdXPA1WTlvnsijkG9XoC7iP5pNf0DW24/z1xt/Z1iSdy8bgSCgs7pIQDQETlt8tWqI0bpET87z3VIvikoIxhLoiggSF6sZtAEFjZs9AOEE6OAyDzz/TAv1+t+9fQw1gOp0/kSnPpphQUvCqEJa1371HFEeZ2IXFegs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nXrUUjtT0FtUVhIvqIrjoSGNQt4VuhcvQ19figyzaqndOO2CR4m8CSR9d20T?=
 =?us-ascii?Q?QidXtHnNahjj/yDEpZKa77DShfLlsR9dKKLUlAe8flS1c1OMGhpsoQp+rnms?=
 =?us-ascii?Q?x4qGKvP1+HJ1CQMJe8nBV5ZgDGGaW2KghZ5i2tuxcTZCb3nB3/2Z+M6TG8X5?=
 =?us-ascii?Q?VFM3pz0y3fG2v06y6DJV1iIQ2U2iLbUYKJdYwGYj7zz+QOWsvdfrQujIfgTQ?=
 =?us-ascii?Q?8G0g7y4bwi6bvyulCXAmXOmaZiz8nqB6keRKpFHbWY0Ts2qDTyFlKqwAJ8qT?=
 =?us-ascii?Q?DU3lM5XsE/DthppbZSvNwZ91679rrv2HnE7VKPEW9qa4YHTmszbINYtEx8r6?=
 =?us-ascii?Q?gRsyE00GOq8a4TJAQbdeIvOuhsL+A2jYHZQWf5PhrmPJRt0XQBdmFtLcdn2w?=
 =?us-ascii?Q?+aRxN8rBWTRfUBkug9+BExHptzMjNYd4yWvRawCcOCR2ZvPxmVLL2T8qLYKE?=
 =?us-ascii?Q?IXMZEn38cyEITaobrSd9vM03aoDnXdTHyUC+mB0ma5wdcfi5kVtpcnCaSYMY?=
 =?us-ascii?Q?8yZBxT2/UwX/lHS169swhwS2RDl+donhrXRb7T+RGPARdouhnfn6KFypkXFW?=
 =?us-ascii?Q?chiRtUnTnBOeTlpVIuQ91XUat2w2/4AFCJW8Xm1nl2ZRVN2N9uO3H+6xqiit?=
 =?us-ascii?Q?0FjWpQqvL29qRANbtJiF+x93H5g4cGLICpjULNcY8uZh2a83ZyT0DJY8a0p4?=
 =?us-ascii?Q?FTtc/A5Db2CEb5xXaDt80yKAXdTD+EdwzgKcbjckqQR21zz8ceSAHhZg11Us?=
 =?us-ascii?Q?AoY6lAwxKp+MHC8I1RlzqKGVE3iD8lljOIB+Cu3hIw+qZPIXJ03bHVfNwEHf?=
 =?us-ascii?Q?xPJm87obtfGdXakbi2gWbuwxNcATIFUbSBGFH+vV9DvLqcYlp7mSryvNnEFx?=
 =?us-ascii?Q?04TBVyo0h59Po6AyfTTDqRoArAdhKJHWsNb6Dq3WnWXTwHUpQDa1/oJzIdtz?=
 =?us-ascii?Q?qvvKwRbV/ECuW5YI3xqr+I0CoZd3bYgiDOBnF9R8wPk7MA1FBajhuGED5y0Z?=
 =?us-ascii?Q?Z1McSzyPy0BcMYyLR4L4Z66LC97IKnMY1U1CuzDPlQJDCF9ZubhwPlW5aWwJ?=
 =?us-ascii?Q?iuOYcSmhL8IxOuLmm7e9LDWUJqvm7YbGxbzO2Oqh4QVVAaDRiq783l6eE3AW?=
 =?us-ascii?Q?Hn7bGJBN//A9S/5Ftqa06UoZB218qdmbRgw+W7xUWiOjKMjnX0c2ChEpPxYj?=
 =?us-ascii?Q?Obk3oQk+g0K48hl49Z8RHBahfPVbvUrSiQjT0aLkn2u87ePmxUQR+z3Bmjfn?=
 =?us-ascii?Q?UZclUj6iaICEFLEtxm75YK3Gv4sD8awyUhCVjL9pwimHlDgekbRE4o4/7xqO?=
 =?us-ascii?Q?uSpVmlPCq17n58fCqiFMUbh+QmBV9mB5yb7ZDhJ+rgTEPPGjj0D5BRsYC4lI?=
 =?us-ascii?Q?WlEJBBMpKhhGT4eBHNha1qxYaMb9jqcYng3z+LaerU9xfael65bcsztfm9lO?=
 =?us-ascii?Q?L5E6PWmh0yc/cm5XC8tuvIBZ8UnZVzuXw8nuBHKhe5DRJ8vS4+eclpoUIJxS?=
 =?us-ascii?Q?E02WUixX5WR5YkTvNcCiLXJZH9QO27xVSXDzi13ZRSDDKGlwlUQbiJcCa7Rh?=
 =?us-ascii?Q?kn+u/SgU2bvxRF/QCGKKHCWjFCOTNbDthKxSO5Gd5JTKY4uKAMiYvfqOs85Q?=
 =?us-ascii?Q?ibemP7khqTzv2hgLY4sUa+36WifKc0BQHeM7OvWMoTqWSfQSBG0MABWxeyHc?=
 =?us-ascii?Q?ngsiOeugJEfDcasATZCJ21ygpqUuEwsUC1qRuK6zs6O5zteNRGzdgFxfnSmD?=
 =?us-ascii?Q?AeO3f+Dmuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf995ab-ea8e-4191-ce7c-08dee33d6b88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:27.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB33+CaP2KlkCtOJyGJXS7AgYv/txaS0x+qNbluwGMcK+Z4sQIHX4PFx56Oa39EuCjh+Q51eSgj/rE7GnKJfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

sched_ext may normally relocate a queued blocked donor. set_task_cpu()
updates both task_cpu() and wake_cpu, making the destination rq the
donor's new callback home. This remains valid if the donor was previously
proxy-migrated: the BPF scheduler is intentionally selecting a new return
destination, which the next proxy migration will preserve. The usual
migration-disabled, affinity, and rq-online checks apply.

An active donor cannot be moved normally because the source rq still
references it through rq->donor for scheduling-class operations and
runtime accounting. Moving it would associate the task with a different
rq while leaving those source-rq references in place. The core proxy
migration path avoids this by switching the rq donor to idle before moving
the scheduling context.

Check active-donor state in task_can_move_from_locked_rq(), where the
source rq is held and the result is authoritative. Keep it out of the
preliminary lockless DSQ filter so a donor transition during the rq-lock
handoff is resolved by the locked recheck rather than consuming a dispatch
kick and skipping the task.

Allow normal sched_ext migration of blocked donors unless the donor is
active on its rq. In that case, defer migration until it is switched out
or leave it to the proxy machinery.

Keep blocked donors on the local DSQ when they are put so they remain
visible to the proxy pick path.

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c924af485224f..02e3ea7add16f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2444,6 +2444,10 @@ static bool task_can_move_from_locked_rq(struct scx_sched *sch,
 	if (task_on_cpu(src_rq, p))
 		return false;
 
+	/* Don't move a donor while its source rq still references it. */
+	if (p->is_blocked && rcu_access_pointer(src_rq->donor) == p)
+		return false;
+
 	return task_can_run_on_remote_rq(sch, p, dst_rq, enforce);
 }
 
@@ -3093,6 +3097,22 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly so pick_next_task()
+		 * can still see it. find_proxy_task() will either run the chain
+		 * owner or deactivate the donor so the wakeup path can return it
+		 * and let BPF make a new dispatch decision once it is unblocked.
+		 */
+		if (p->is_blocked) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

