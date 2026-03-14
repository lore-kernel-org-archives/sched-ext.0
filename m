Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40D1494C3
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773532372; cv=fail; b=RoV9Osf91aOgwHkX2NtIgEXtkhaP5TwgCIz7ky7Q6uBskvoaqYdRyELNp7cj4aySTleeB7HUTJo8SLOV/DWWr7xrxdrSVfjxX9zOK/MfF+oDBTAd1ODdZX86UUXO9JfLehEA5OHscqdTvklb6ZJHIRAA/8FBtzlt7bMxcKiGe1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773532372; c=relaxed/simple;
	bh=S53ecuYMY5RLbGUmgycnn94bJBOAe3izSeO4skbL6hk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QspW9tbzbjc4Z8rYYriTASl8m7CT7sX0cDlea4wPhhpUpA9jijUsdr/ezPOVOl4aNyCTPlHPbAGkCmbJM5ypVJtNYaoImjOiWQJLUFekiSkeFgu95fJjrUx34kqSGf4A4pSMm4xNWvUp4I+JcNlr3KDxxcTtMDymSoc4g5cOJ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DzWI/wfs; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DzWI/wfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUpT6K+8naORiuSImPIBbNQM8MkN1iFIjN4JaGUNAXvithslh8itbGrR1/xO0KZEnQdt43EXhATqqFGjokVp8tVyPULvLW9KgMDOHzjKoxKTFMUlU0Knb2uX03Zo20iR1K02GNqZFcJpFChZUYprElJAhzQgqEm4vjKZx2sq35UFGBc1TaOno4oXlNRRNhQ4CH5g7GQueoBxFoWoJv7EF55h2LNTc8XzRWOREzir/wE62FO21FCOvkf4kHcSCkrlR86Fc+1nezn7ma/K9Nag+2/fZ4cE7HcjLvY/Jn5BaFndwmMur0TmfDAxYHb1vY3uWuFOGm+5U5BbuUTFDkdjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTrOrLgG3JOyFfsLwQpUNqUFBe9gxdVTGlo28ILn7Tg=;
 b=r/1U7lh72xD36MHLubVfJS6T9WH6/cQg6ocFB2teVMKOMAgFfBl9yfRw/pxij6WG3yl5TnNHZPENyXUcF4j/RLTcbNnqRyqZ2MI8veP1j7/88zmBX2F8nKEMyvwWv3FFehM1UzcL0ENj30ivwCdVNTj7z+8OlUfZ8J5ZMVnpnI0Pg8ksdkGomK3TkwWqLY3lul5qYEV+6fzwlIuy9v/fDSW8CmjK6aGIMODDqbzyIl2KNNHXvoj5sF8nyp3h1X4V5gST6x67+IpVErFbQcRJUTG5UYxNL0fXSqSDLy3hyR6L6WQG4aXiVMoIEMZBokzH8e1lwEDR6kGMre/zb1o57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTrOrLgG3JOyFfsLwQpUNqUFBe9gxdVTGlo28ILn7Tg=;
 b=DzWI/wfssxTSieqgnWPwGXqyvyf13trPorvyPwKbCa9mZASNMb+G3EDhvzZiq2nImsrNBNEfyEiJXDCy4C2zZ8VE5ulW7IN8+bkI/nDJO/AQX5+r9z0ekgv3xd0Pzac37DjG4t6xl35hUKfN7SwQFhGwIQwac7hjf9T+qYnCU+6fxw8aYNfBMmTHNi6o6rA7LH6DolGkTWqaNuzp6LRwZwaTJcwClqj0dq9QMa+QUDQ0sCBuJNBp4Z8GWlwQzKVmep6uHEMTu7Phe7xC6/VBz9XL22SlJUZr09Sl8WTZdFm/pg9q7sVaCClnrQatC7JTHH9zpM7V0/dRIAq/Re6xIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sat, 14 Mar
 2026 23:52:46 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9700.009; Sat, 14 Mar 2026
 23:52:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] sched_ext: Reduce DSQ lock contention in consume_dispatch_q()
Date: Sun, 15 Mar 2026 00:52:31 +0100
Message-ID: <20260314235231.684671-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cae6d3-eb39-4d00-ebd8-08de8224c9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ug4UPDZv02AH1jqgXHYp68FZvjZ8p0/D68/TlB7hp8kG/xQ6AAvP3NMWOU2K7KBLYXzGOz1T3Za+jd0mTWA3GgrEyVy3gKi2YX8KdZPadU8g3hEpGKoUgEbHqdsQxRBFhhs5BFJmHXab1epfc5Q1NmJOt/pgr8FJGyPssKnM0dfL7PHq1jHAJZGlWoBouIC+agX+twAjG3w/tVPeOs5saT5cf8SL7JHpL5S/0DNeI8Qp9oUUiv9/t8zzOf/3guL20RmszIbDL3Z+LaooNFLW0VElGPY+P2d+kxA0yMRzk6hT7O+Drf6/LaZtYBUwVcxVH9l0vPenoZ8gk3t0qd/MP7/X9kJvMbUeWDjX05Yr6epqQgF6uJ8CtKfAN19no1PMxmFEoa3WcT6Wk/QJdScZS0hbDo4ALzUL/PH1lD+xnT/NxgrBYLEveLza4WjSkM56SvW/8h4odAWerCms4YrfdSpu7POlWOWpDfx1gaBNitQ/NveHe8zn08OCNt6wh21OpocKVS/CPdU13Po/v0a2IMRdCEEZ937NruoUt1V/mjIEt/4TzrhpmI+GhL7WD2WXD19j/mx5gq7B0oJCr0Sdbg6FF+BFL7PfRVOfCsgXFo2YdQhEsqknN/hSEcAkqEcGgkRs0QzXvsWg8wUePp1e4ZNQ12MxDB7hLHWWiGfR3cGF9k8bFd6LooZKty8vxNjjboAmjrxvlknguDaV9V8rBaUP/Kb0kZm8elc66DZaOu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kDn0F0gMUvSBWaiDrauk4KfBnK4LtOudUBdTnE63wA7aAfI8pskncmFYbY+?=
 =?us-ascii?Q?hEcG1CJUu6Q+1NAHVa6YIpL7jIJstTon9D7RVRP3HYuzzhku4LnSVOzss5BJ?=
 =?us-ascii?Q?HEmCHDXd3848xqYzOHmjofRXvvYIk/KFtebPiuD0KU+4Hczbkbxp5IYmwMMA?=
 =?us-ascii?Q?Cfaz2ilFWpL/rPfDpbZ4mncsKnjeNimUfiDBlxB+3UOaHYSnT+453fXqBm0U?=
 =?us-ascii?Q?A9o3on15xh5hSRaaHdfnxNXYSZjWT9JL1000cZ1X6VjfehYGiiAq3WWKwMpV?=
 =?us-ascii?Q?We2fpy6KW3ulVDFrCgwU9DOCyWwIhNHJbwbJTbI/49eDhvmQAxS/l75AkcpC?=
 =?us-ascii?Q?bXMotjXf60b4nwqwpQ4NXL8i5xcN3XO1SVldU9ymB+riCXxn+g36CWAvXOfX?=
 =?us-ascii?Q?CXve7DZd7I8Wx3FtiaXRxmnP0BJIdfgNSA7kM+rXuhseJWmFg3oZPj//PPEY?=
 =?us-ascii?Q?oAoB7T1a1aW/OIYUnSYM1VvWJrk0O5zgZppijaGtl63Gp1OzWCP86pIlA3om?=
 =?us-ascii?Q?vN7Rh5VZxxAUK5yya9bNII3kxqLMqamfg2CS+mRhnvcyiKFI/2RcsJO3NatJ?=
 =?us-ascii?Q?O4hJAKutY4ntrj8uvKyINN59pejG9cHRsWSxOfuOOIOMKWDhpoEg1CbRuCZJ?=
 =?us-ascii?Q?oTOCvzsWsL8w9zHTQTpQIiRaDGB2IJnmx96z5fzfQPV4AvI/isYH/AEE5M0G?=
 =?us-ascii?Q?C9bC0SG7swxIw0Citai+LegBsnKXqDw/H+E0z5jsf75dSKMbzV9QBwqsZSxD?=
 =?us-ascii?Q?z9rdyrflLlWNtAWrl9ONmrTjrbzv4i3gSiQixF/GGA4vhzUlYpV/rzBIA4fJ?=
 =?us-ascii?Q?rw8/1u4Bo/3Inz0APIivqlgknOGH5lewYBoJkexydoh74bnlM5/JblLnxiwH?=
 =?us-ascii?Q?5mLpZJSOsjZmgA4ptgQZ5w6SYzxuklMls9G9ezfYELB7IWwRJSZ2BTvGvE93?=
 =?us-ascii?Q?TSYwxUmHsQZY7o98A/DUf73SYqGt0lxdBWNwPjQinlz3EgZPFW1Wr3d0BZL1?=
 =?us-ascii?Q?CEtXGG2HUmtZH+De4Ehm/Oeb8EG/DYsXc1C4TbmPL8jriiUSvZoGogzRmXUN?=
 =?us-ascii?Q?Vw4joAx3kIMwH2K8cfaXxcmG7TRkJywA0ZrvIQmz/NOhxtOMXR2xpG4gT3zT?=
 =?us-ascii?Q?ENpLA1+vHPTq2MaqHeorg2LsUgS/oHVKgM1wGaVHj2z3MDIsYelVy4e6OCaF?=
 =?us-ascii?Q?61QsGcP3ANxqdyfjdAZwBbuARMKWNmEQlP9lox81gD5ZvS6ixwfPZwIrc7Iz?=
 =?us-ascii?Q?Mndj4uAW3syniibDxlZZdJu/C1VkAJ5Jh7MyFM95eVnm/QvFrX3xCN5fRLcH?=
 =?us-ascii?Q?0fhnzTwDM5fdjY/1d27tAD63RNMt4Srkr10DTS8q4qB+Znq6DiE7l3dPdSC6?=
 =?us-ascii?Q?6mrVBSBOaOjfQLvyaC2vaUEojImaJAA9FynE98OqtNeG3VOJiKuclVvijwIT?=
 =?us-ascii?Q?xYqtM41quASkTuLIC4W9ilgeX1VD5i9rCvTAHq3U/j0tjdq1FISguYHaw0lo?=
 =?us-ascii?Q?FDKLSjUtLxwAmyVvOg5iRZm1jQuYqHp3Hhb/EK2g/jQ5FiATASgYNauVivJo?=
 =?us-ascii?Q?65ZnhiEARHBV99E1qMWAemLaB1+SDHmbIrhVSXiuUOGqiO6VHL7b/tawNQfT?=
 =?us-ascii?Q?zNHtwqgyS2JRfQp0XmKjhdOJX3l+GmZ8hqH+f0MLU/uYH12yHR7VCY6Fs4sT?=
 =?us-ascii?Q?sYx3T0lVM9d9NOVd43f1Mb2IKukcCSQ+O/f84ySGjJ+vO8n4zoNyXWV1XnVA?=
 =?us-ascii?Q?vEr0ykscyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cae6d3-eb39-4d00-ebd8-08de8224c9f8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 23:52:45.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfh0ud8LQpdYhXppkvAalRd3fIeoS3l0IYKpUC8pYgeW4pG9gWbCeZ2dBNQUaxuUpMAvavkzD4aACr08oVewhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

Replace raw_spin_lock() with raw_spin_trylock() when taking the DSQ lock
in consume_dispatch_q(). If the lock is contended, kick the current CPU
to retry on the next balance instead of spinning.

Under high load multiple CPUs can contend on the same DSQ lock. With a
spin_lock, waiters spin on the same cache line, wasting cycles and
increasing cache coherency traffic, which can slow the lock holder. With
trylock, waiters back off and retry later, so the holder can complete
faster and the backing-off CPUs have a chance to consume other DSQs or run
tasks.

When in bypass mode scx_kick_cpu() is suppressed, so just fall back to
raw_spin_lock() to guarantee forward progress.

Since this slightly changes the behavior of scx_bpf_dsq_move_to_local(),
update the documentation to clarify that a false return value means no
eligible task could be consumed from the DSQ. This covers both the case
of an empty DSQ and any other condition that prevented task consumption.

Benchmarks that generate many enqueue/dispatch events (e.g., schbench)
show around 2-3x higher throughput with most of the scx schedulers with
this change applied.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9202c6d7a7713..8f48472f70f18 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2451,6 +2451,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			       struct scx_dispatch_q *dsq, u64 enq_flags)
 {
 	struct task_struct *p;
+	s32 cpu = cpu_of(rq);
 retry:
 	/*
 	 * The caller can't expect to successfully consume a task if the task's
@@ -2460,7 +2461,19 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	if (list_empty(&dsq->list))
 		return false;
 
-	raw_spin_lock(&dsq->lock);
+	/*
+	 * Use trylock to avoid spinning on a contended DSQ, if we fail to
+	 * acquire the lock kick the CPU to retry on the next balance.
+	 *
+	 * In bypass mode simply spin to acquire the lock, since
+	 * scx_kick_cpu() is suppressed.
+	 */
+	if (scx_bypassing(sch, cpu)) {
+		raw_spin_lock(&dsq->lock);
+	} else if (!raw_spin_trylock(&dsq->lock)) {
+		scx_kick_cpu(sch, cpu, 0);
+		return false;
+	}
 
 	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
@@ -8185,8 +8198,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  * before trying to move from the specified DSQ. It may also grab rq locks and
  * thus can't be called under any BPF locks.
  *
- * Returns %true if a task has been moved, %false if there isn't any task to
- * move.
+ * Returns %true if a task has been moved, %false if no eligible task could
+ * be consumed from @dsq_id.
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags,
 						const struct bpf_prog_aux *aux)
-- 
2.53.0

