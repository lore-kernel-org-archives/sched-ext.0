Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBE41D22F
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374984; cv=fail; b=rk0KboDOK9mwgUgjKNSdt+5kZYOFcfrThuBR1QMxMkiPHeWxXn8+3IRk56R3/xfeJmztAdvCyaATY7VieGFRbCz1vp25Ts4qSYEyLm/f5CNOHRqUmqXwu29UEJp0QVYX77JS7vgHORYs4cyU/+fu8JBO7n3JGC9JQzz0MojXGtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374984; c=relaxed/simple;
	bh=EYhBvZCj2qlf7zkAHilG49lvlk8tB5WeOPpfjB6mqak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsDXaM3w+b/QOY1y4nMCP+nDSztVpK0VWTEqE+gR9pdT9b2/7gERjM3n+EBQ+fBJyKD8rWc8MuBrSJbg4mts6qqatPEAieAZnHOnVedjzc1fTKRVeMAWw6YK4ZGglgvQSE/ys6xeBtnUXXp8OdB1PjlihXORP/AEgEH/sdzB3fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXI+qAZ6; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXI+qAZ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yix5R+ibBMFae++lTXHipujyfn6Acco6OPVMwOmdmsodgDxcqLrVQr0+F1X+6wZ1dM1F/3HqBOOzVYqqBCZmPhuMFfflLFfYw9+yvxOS0u7PnI2y00AlIOzc17NhEKjBbFIEu1EtFPzEdnL6V9eUMV1fDcXH0wlaMRuXuSWXjcFOCMrma7GToBG2O0w+XMQcLcRaXNlfBVGVRobjZQc9wKxDhhqI+UK8boFMD4cTjqQ6qTTUBMdrRrA5X57MAJUH6fbiAEC5ZW5BJEOvyk/zov02wvOB+Xg9bvOyjt2q1z5G21A3psfLlvBW074DmiQWTKcHNBVmZM0B4Zbmb8bP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h/K5uhK6PXlDUSYKXZLAQH1Nm6IJ35tOAfyjptXquk=;
 b=KDoAICJQTfRiE7RgK8SSMFj2hkn6bTcsEcJCiMsecaBne1Z2njUh1G9TIKCx87u6bnIwha674W+SgHf8/ZFCKbE43593V0eDdlqFtdmZ9FbOBce5c/hwdSKs6ABrxryJ1NVYXYp7kR+W79cmKYBAlXGZ6BACX32k/Cgiut5KZdYIoVI+EuO+zZnTf7YFG+uRHlaSaHPdWzeOgju++vVjyPM1F5RAP4eNK47JIQs6XbybS6OQoUktlOyEMEKVWrx2vwtIABrwht5PEJniY9rs0JDpgzdunMOW2jKeIiRUIS2yA/v6ZZDZFTnuBrgYnyII2F1WmuomeBE0XOJJ8GyhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h/K5uhK6PXlDUSYKXZLAQH1Nm6IJ35tOAfyjptXquk=;
 b=oXI+qAZ6qFOPHBeo61aIEp++jCFkeC+NZQnaGzO591/9Y3+1VDF7snH5Z9zSA/Zk1e8Vo4BCYmVZB/mtjnC1pSoKx4XXxDZjo6oA+/cCkKawc3/Itt8ajpLym8WciGY07pWZNkMFOrB27rqHRcNx82KlBWKKw4gCRgKgxyrbYDArmXp4lw4MVL8pse+8loOU6Aa9MjI4XOXx+iaI/RGKWeRPAfg2ZiDbmL2pcrnynqAsIySZmfudxWRUDrHJsiAURcIsKv3T03OvtoqHP0erdtMRSTt04qVq5A+nWHC9/LJ3K8Rq3nhXnGHqY8VBa38/I4P+fs5Kx5QJwtOqbsZXMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:11 +0000
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
Subject: [PATCH 04/15] sched: Add helper to block retained proxy donors
Date: Mon, 10 Aug 2026 17:13:50 +0200
Message-ID: <20260810151523.86994-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: a572382a-dcce-4590-f359-08def6f24f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7Zwi/xomQjNx9HKkIVqOutAoM07x+g0/Brocn0O/z3Q6h5f5UoYETfKDjxCb3seVK6EpiSLy5VCwfG4Gm9NnvzfTENfcieUnOnIerh8zBtk4tLn6anll9gs0vxZg/oiZ8xUnznXZ+fXPBAgu3acZBRjzJkghFwPH9nJSWK2jgqzz0rQFYgJwYSWSnBm5R9FhAyuGSwWPi4QzXKFwg74fW5N5Hs5QMFFPBubsUmsYdaYRSXYs2QRq9TWpQdM4YegJICCeGMo/eGMYJvIQ/IvLN33fxXQH7+RTKldaDG4YJmM9KsMjkqWRJN8qpqo9HDeLrOtMvrnwDkjwosZSXoRINtHPQKflkZlmc+Ss0gy9VFG/0hbhAbjqDGLVvwKWXJVQIvWqlJMMuwB4eAT6rmAgNfP9iw4t4vEeuFLqcNeIsa1L8j/0wt0kchwIV5/CBEPP/DMQbNFnafGAAfXHAp7SQ2fD3fUGg8qsq5xuvE2kHdKpHaXzkwEIP8HkOC264GtgKFXLaNRMImkao012FjKn5qJK9lcza0VDQ9555ItxBNoI0gAHEB9OofsizmIZNgltRvBIxShedlwx33MtisKLPmo+dw7ffiPrZSBQZDdlRoqmg+12kmuH97yx4P9SIQYs6QR+ubV3ar3B8UHkwRRS9C8qRQIfKacoET1EQw8bfLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlrbEXQ8u3RIiNfAnTZBnuHPj7J3cclJJ5+I9ECGnkPckBGr+USujlaiaARa?=
 =?us-ascii?Q?DhDNJNkt45cNVaXFS7X73I1PvhuDRyP+3d3n6sm+uH++WnlWXsfF4DgABbt/?=
 =?us-ascii?Q?Fg3rxwFo2URfFcGXXd6VmdU3pP34CJfBiWSzqg7SDIQ8u0o0MrCJVVqdCRZa?=
 =?us-ascii?Q?H5l2EpktAyzFebCQzaiPRYNE8Rblq7Oep55XmDAOLsH7t1IG86200fupkTvp?=
 =?us-ascii?Q?Vhq3KhNu8RUlgbY/pKvmmNeqG4n4qd2juRpBlJ5az63vHO6Od5Bqn1w4rhLB?=
 =?us-ascii?Q?FMZ2QJpibuFYur6X8xLY+hGTHqPpCQ2mNi2p0CDouHOZ8wDUw3izelNrSrzD?=
 =?us-ascii?Q?CgbMfZn6hy/wRT+4Aj76lrz2pzhFwUP4BsDeyubE/+6kL8Wmv24HhF2MgJGX?=
 =?us-ascii?Q?K2lg5t0VktcGnBqRcMypvN8jqlGwwB71p5jh/xYlOZh8GicurgAqdMEh4Vsd?=
 =?us-ascii?Q?0A39VJfZ9ZtUQO9obwN1frWEFwbGUuTw8p33JqWgXZ3fJ/vnJoEriwOqeWYF?=
 =?us-ascii?Q?e4hN2vVkM5wlme/btYiHc00yh6LCwHE/+bfRglNUcWLI6NuztYx03dTqGH/f?=
 =?us-ascii?Q?G4ufmwixRA+k2gpfO6Ximni2cN0VPMGCfsLX47mOyhHKN+yL1NfIRUs9lbRu?=
 =?us-ascii?Q?LYmFalsOk21R9dx74aCZ0RKskH08urfjVi8i6UiP4uaBpq8ftUEiY0hruSWx?=
 =?us-ascii?Q?F8Je5WA6f5PAdGT8FgJ/+zpiLyTSAcsaFrbw7yK9vmtELw5fbDIn+Sd0FTQR?=
 =?us-ascii?Q?c28AM41sHxo48pP6W3bMjQQB8oF/IkoAChVBloB04V0fLvKu9hPIHpr/BRv6?=
 =?us-ascii?Q?zew1Q6+wAKcMAV2cpHHoYwaVr0ls19euSWziCgl0BNuCWswBfSKIcRvvumVi?=
 =?us-ascii?Q?qfIydwt+kHAcekPrqMH3JHSSmkDKfTI42sEIysj747yiNGpBJq/+dem0Lb+o?=
 =?us-ascii?Q?Zt1JgIlSkqKQVjlZ/AagxhaHUPOwVCYurVzfBRlp5Nlqq+GM/ogOrscqUps1?=
 =?us-ascii?Q?lyP6zDXflV1ZgIetENzx2nvN6/NnT5sv2eHivsOImMlG8p2D9JcoqKRAMngK?=
 =?us-ascii?Q?F9RsLiuGwgrmBSAMsS1ATFIuUC8WZYVo6mLLGJIC015UHJq8x3K1/rQHkKEh?=
 =?us-ascii?Q?Ca+EPbvbH5XjMr27ONuXIK874nt+uUiFHtN+UPRHE/BW4AMCOYxcR3rbATe+?=
 =?us-ascii?Q?7QKUSKkfFlxi3+rptzkZ6CuI+I/M/WCezoJTon4pzgGqLFp45VotoNb2DWr+?=
 =?us-ascii?Q?MomGHvbYmmyD27g06uMj9eVAs8zQYKkMm7ZlQjuFMz5qnj7SdqDybOxohr1j?=
 =?us-ascii?Q?/U1vmJH58p50vv1wiFyeIi6CLbvbhiDjOBF4Eyn1S+/UhShQvMFDas+3oqYg?=
 =?us-ascii?Q?RzRK4gYG0si2OxRKPeb4dJthCyaf7215KwYbP3RknCOjl/RA4I+PrNb1lAb/?=
 =?us-ascii?Q?sy7szBn9WBMpZNE1NElh6xoet/bigw99255LLmUDkXdaGXdvRV3sOoqCeVSq?=
 =?us-ascii?Q?BLqp+E2oyOVGYUDCjUAyRZ8Vm7ORkNT1eZV9HFv6B8vAqCmcRhM5jcqb7yhZ?=
 =?us-ascii?Q?IZjKylr8ydC5msFCzAe5wdWdbdlZPB/tTXXh5V6pNRDPduWTzq9SbK0INBLz?=
 =?us-ascii?Q?b4ckwpr62T2pLg4FKf+/cMaW7uil0aBjfcHR0EdUqxsBqSCqO9yLDVtR68+T?=
 =?us-ascii?Q?o2xj1qLNFagmuw1H2SFm4SHfIawijvu4cPkTpQmnYJ0pj8uFuNwOYYoZuNy/?=
 =?us-ascii?Q?X1YphgNRIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a572382a-dcce-4590-f359-08def6f24f6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:10.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdQllChpTcSooalRGRbZSiCVPFqMlfGLO3NEeISj84r2fzJZWpWkOiPLr7NZTRzyQpEhSSrwH3GG0CDFUXeLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Scheduler ownership changes may need to turn a mutex-blocked task
retained on the runqueue for proxy execution back into a normally
blocked task.

Add sched_proxy_block_task() to perform that transition while holding
p->pi_lock and the task's runqueue lock. Reset an active donor to the
physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
donor queued, the immediately following sched_change_begin() completes
the dequeue through switching_from_fair() before recording its queued
state.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e71fd07254d6e..fe142e3bb78c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,34 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
+ * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
+ * queued, switching_from_fair() completes the dequeue in the immediately
+ * following sched_change_begin().
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
+	if (task_current_donor(rq, p))
+		proxy_reset_donor(rq);
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+
+	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7779bcf7c6a12..ee3ba7b5b11f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2489,6 +2489,12 @@ static inline bool task_is_blocked(struct task_struct *p)
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

