Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99B342517
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574245; cv=fail; b=XKM5vgQ4G0HQyZ+QFCfalJyF/CsTBmvSWviIRhA38RzcldW7o1YsxHqL961wsLht3lu46KjKvbj8U0Su+3ajnng0wIVMbMhRkMYNxe9FttxmVZQjhqvaDOgH0uEZAUL3CakD0+8W3TBPEM+r0bFfUeQr7OH3B/hwdiRFw+9fY2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574245; c=relaxed/simple;
	bh=dv2n24yo3HDQ88UqlmGA2Euc/34aa+fHrwjgDBLfCe0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AxsZTVTgmo4B1jkWwigdFaYH0wY9oUVhJjFbSqljnZ5up3qnphLJRN6KYQxrkxNTOLImuGfngd4kTLcXSwbmfoM47g1DuC1XnnpGmuq+hnWuvYrZaM6T8t8Ydp9wRSZfj7avfiKXsEm42eKr2OT8xeZnLWwB+vMc+aifPyFYtCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6k/wQyA; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6k/wQyA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs0j/S0eAUwljDs1gALZ6H3iAL41lGP334I/O7qRnEW7HGzOSwa+gxuQqDO4L5HC/Zq8iNdzWkhZnoYF9M6GY4NX/pR49SLeAQR2ocX1mV93JEQqsbqrM7HclH4xr7gD5b7VkdVJM+YuozIYQi6YJkVkERzUns0bj1eaG9BqfgxgPW4YzQfiGbBfug3HWAgoiTzCEPn9E/7jbs4klhxTgZMoPdKlu7Q1HG7V0BC6KZlVWYgvxH3rS91sfDG1rE9KsuhB+lb5GX/ZLAEVek1ttmwzhq2IVL5Du/tgsc32GN1NWxZx6RNlO0bV9QsKBFZljoscme8u+tAVQvSLc3RBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VbSrCpZNsbOONxFdT3zsxY8ShEqO/zulLyFAuLo1A8=;
 b=ZNMjvfhCfKymaf7d+l/lzzamBcgdVBCvKFYOlyct70Sndkm8NcwyZhOPNWrUVb9mc0lsfTGM2an2KRr9zzToluI2OrcjHE4SaSVjJos6ORrmUtN9XuYCiJCxxYRM/FB3nJQ7e2XrnAZ0OwgM4m9Gvf7e7j1zJSQ0kEWIWxEUaqYtuhnVz7TOKmShacHrk6z5/WSLoxXFgrhynZ+L/idxePopiEjO4DPHPz6F+00PoKWuR9hk7yk5Npj5rIJxso5fgPMC7SijcI0h5GifHPAtEc9LSwH5uEvGBlvmomIE6MitT+pDFuAUO2DoT7n+KrCo/wLp43CGIgL5ERibpn9wPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VbSrCpZNsbOONxFdT3zsxY8ShEqO/zulLyFAuLo1A8=;
 b=W6k/wQyAFmK+RmtwRxgo9K0EaBhKpxxKtk6K2xnaDCEmlx56/IzAycPlit7W54zTeSekd9fZJHrjUjOtOnQp6vpM2zD+4VnIC2B08HHQizLEshnXaGBp64eUExe9HHiarLJX9pbq87mFaivrWg5IDoKBiGGICtoNExfZW4GMUuNYdpd/Jur6F05vS4o19WhiQeSPLJA8CwoGDnsjU+Jg+SK669ukEoHCsIsXolfdJgA3f6E6n1BOgJ90mrUsuqBxkereyrLV8wHVfKGrtvFazpaW4rhSYPFxaGJFwcl271UkIOkoQS2iVRmmXTxQ8PHrU9Yz5jx45G+4edHi9c7bMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:17:19 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Thu, 9 Jul 2026
 05:17:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accurate in the consume path
Date: Thu,  9 Jul 2026 07:17:08 +0200
Message-ID: <20260709051708.306636-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b9b3bb-ff91-48bb-12a2-08dedd79590c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	lG/D7Xwj25IlpeO0pPlgIW9ZkC3iGQL3Gui3ZBu/kJeEfw2qOEyEPuWODkyLeacIikNsZw2+UTo153xsVdL+5LKXpQNWHcISAPUFgmBPRl7QJ+eYQxRAr78KxQLEo09icg7x4Zp0lRO33O6LbKc4vyqY0orKG0+gCL43OHyJoPWuh6W4IuBWZ0pQnDrKkWYSz5mXYxOX/EaJL8syP5Jpl9TXCegI9HwDrUHyZ2ouXACfj7Hys9DB6aNhQvYNmY7ozTQerFR0U9Ru4iXgJpzEMp5V6gbeooACAQWjWO3hu8NCOGy14DS9ruj/BiIxAZmh5ZOwUqJB1Z1+0s6/aiAOlcpHrJRMyqFCnyNA4GWIo5Fqi0OjzvrKhY3CfTKpzfT41mGB57EmTEjaCHMt+qIVprK0P6SbVYLQs9klqRa7sl5qDxK3wyITh4Tcug4REAoki9CWvKb6lIMLrWEEW9Kkf0lnyLWFxAn+Imh9aFYg7WusqsmnFqlsougV/4Qpr9CkPDqqoSRrbJwq+IqBo9REi8WyJjmDR4p6QeLuIytDiap1R9n/emcNtNzVUBHWbBDvR223wPgosesseupl5BDvneeDnn7onsMK9flEuZE3DwBVB3eHoki/wcljSLTK9OQA6ebuWTXKUItO03rLJ9YWEHHkag3TgSpwnZXzOYaDuxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Q4YBjNehrOaXbN5WofzVZl+tsAFeUAJKCVhVPAKQyiTcaoatIqJD8kPtfJE?=
 =?us-ascii?Q?Bn/IiyPqwPz1osjnkWew15fv2hVzwv+VmvYPUcvJwOXl1BIbnZWn8sCZmuR6?=
 =?us-ascii?Q?bTAkpRNjkExGjBrIsdJu5SqgnofhkE+3t+ncGrZFTiAqy4tly+MiIhUfDeWK?=
 =?us-ascii?Q?lEWRnfNUBKG98aL3s/hDefBVTEWjBrLU4pd1BB7TMzubQIJnSWXQp0NYHm3F?=
 =?us-ascii?Q?Pko1Y+3iRmVzUghXqTg3ZOhK/9FrFy8oJjxVvBh0oYGzoBhfLrxgHPxHL7PX?=
 =?us-ascii?Q?jIi621alhQuxHHwV69/SGeWLmaZtONKQlFDzApgQRxd0S7cr211aPqOLiCJN?=
 =?us-ascii?Q?iwUZTHVTyr+dG00lyLSGkv9Szj5gPn+/vhYzMGKrtkZU6tH4ngRTX55qWREf?=
 =?us-ascii?Q?Bl4QmBOPoptNxnanbAW9VdJ/LEMwb0FushmO21mpfYhnqxBmJju5sMOndPFu?=
 =?us-ascii?Q?FecbN0X+3h3A6F5hDItVeyYCqUZ5LnNYZ/zulLwYnPjrNz2TE5+H6J6cNxs/?=
 =?us-ascii?Q?zW+9PgfNrjFOQTBaBOohi1iKWm8QfyMjV7G4+ZeARxSXSE+ApLET+C28182h?=
 =?us-ascii?Q?5HU0MAxcJxE/B+6ePRFqEKO19MpHjv5h/Nyxpzj2hvBO5feevM8v+sd/i5ar?=
 =?us-ascii?Q?h3LHDU7nLAsd9uvaU0ZIH02h0sOW/CGyLp6jE1jg8OYuftNEK52q+4w4jIX+?=
 =?us-ascii?Q?i3kKK3FCxuWQ9Q1SUYWT9iF1JdX//Xxio8+VxfxeUwtGcMx7uutczYfqcsZ1?=
 =?us-ascii?Q?ExAKlKjBEW/5C0jNvnqkOeAYgc3iU6eADtUs9tv2w2/lKD++4SUXcdcHuWz6?=
 =?us-ascii?Q?mant5CzEj2qVVh1pIbb7WE73t2p6Psajr/OG/FYvaCIpI/tfXP8uRzQNPW2V?=
 =?us-ascii?Q?uv/dMZDSbR43/hM/0WUZXvLewd1zf/ZgakR93bSj7YOO0RuPENREh+vjULiV?=
 =?us-ascii?Q?F9/JwokH+oBl1t1b/83Kj9fdaU/zxPnf55u/Nam+1X+YoUSSoCj3BcUlii2S?=
 =?us-ascii?Q?e7QazkeR0vzDdAjVbnsZhEWhs7x8Jd/3AcWqNsjPkEuaxweeGFjvQG/ygy3H?=
 =?us-ascii?Q?4kxS9pkQSvdRv79VbaFzPAd1RvprEEQJdsA4gFgXO56BPhr5PIsSlr5MVveX?=
 =?us-ascii?Q?9ALtjUdKMkvxx8I9riD3K1uii/WJ5vltzMhuW3k9Jfc31F0QPo8Zk1UpcqAT?=
 =?us-ascii?Q?I44HJgoS3AnPv5oPJoT8nuLFKYWeF9WP9IK57BocuKQg94yVuMVI1X0rEGmc?=
 =?us-ascii?Q?cQCI+TQlTcmJTyIaxJh6eTIqmRXoTyYGct4pUC3+sWW3lmmcqCCWanKiWtIr?=
 =?us-ascii?Q?AMvny5AJpmstEAhrEQoZFHXia1+YZrPWXeMoxL/EzSfDRglw+vR4BUw7UoZQ?=
 =?us-ascii?Q?c1orc+Wq1ElaWzIgnWZg7z12e8tz6rkDrI0iWiqCwYawDw6OVMGskA5D2/NI?=
 =?us-ascii?Q?VAYexwYYf+EInWQKLy1FuhRw8RPxroDwjOF2tlPodEbU8aTZDBmcnZ9ORUR/?=
 =?us-ascii?Q?AHclmjxNxlH+pxYbckm8S1LfxMV7fonb+HwtI6jf3rzz4Ms3npLD476xNjJm?=
 =?us-ascii?Q?3JuteQRm4AGxcJJ3W9uzpQJbW3KhRN/47KatY7ZXZ/G3mffiD34Kgfx845MU?=
 =?us-ascii?Q?2X6MaIBJ6/MQRhcr/VgyyhGqzZIK+v4sH0DWvPpce7EWJhvYSlsNeXAFkRho?=
 =?us-ascii?Q?QJ1Ll3zenBDq5j59yeU2sDjzL9X0fSFmJgHsuvaMRtqw4vqRcufVyqoFhw+q?=
 =?us-ascii?Q?tZG96L8geg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9b3bb-ff91-48bb-12a2-08dedd79590c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:17:18.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYxpXHNo4iiciDAK5et7lgeLbO2Y67Yz5tzZHGaB24E62nB+t+sJKgCRW7P6c79prp4bDD+3m3Uy29gxzsldTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

consume_remote_task() drops this_rq before unlinking a remote task from
its DSQ and locking src_rq. When called from ops.dispatch(),
scx_locked_rq() keeps pointing to this_rq across the lock dance. The
subsequent switch_rq_lock(src_rq, this_rq) cannot update the tracking
because its guard does not match, leaving the tracking stale while
src_rq is held.

Keep this_rq locked until the task has been unlinked and the DSQ lock
released, then use switch_rq_lock() to switch directly to src_rq. Use
the same helper to restore this_rq after losing the dequeue race. The
successful path already switches back through
move_remote_task_to_local_dsq(), so scx_locked_rq() now follows the
actually held rq throughout the consume path.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/all/455e701bca66bdecde530d225f4dba0a@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Based on sched_ext/for-7.3 (daf8e166ba59d) with sched_ext/for-7.2-fixes
(cfe950d79f524) assumed merged.

 kernel/sched/ext/ext.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2ad768a7689f1..51c24df7be5d2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2203,13 +2203,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 }
 
 /**
- * unlink_dsq_and_lock_src_rq() - Unlink task from its DSQ and lock its task_rq
+ * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
  * @dsq: locked DSQ @p is currently on
+ * @locked_rq: currently locked rq
  * @src_rq: rq @p is currently on, stable with @dsq locked
  *
- * Called with @dsq locked but no rq's locked. We want to move @p to a different
- * DSQ, including any local DSQ, but are not locking @src_rq. Locking @src_rq is
+ * Called with @dsq and @locked_rq locked. We want to move @p to a different DSQ,
+ * including any local DSQ, but are not locking @src_rq. Locking @src_rq is
  * required when transferring into a local DSQ. Even when transferring into a
  * non-local DSQ, it's better to use the same mechanism to protect against
  * dequeues and maintain the invariant that @p->scx.dsq can only change while
@@ -2231,20 +2232,22 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
  * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @p is
  * still valid. %false if lost to dequeue.
  */
-static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
-				       struct scx_dispatch_q *dsq,
-				       struct rq *src_rq)
+static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
+					  struct scx_dispatch_q *dsq,
+					  struct rq *locked_rq,
+					  struct rq *src_rq)
 {
 	s32 cpu = raw_smp_processor_id();
 
 	lockdep_assert_held(&dsq->lock);
+	lockdep_assert_rq_held(locked_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
 	p->scx.holding_cpu = cpu;
 
 	raw_spin_unlock(&dsq->lock);
-	raw_spin_rq_lock(src_rq);
+	switch_rq_lock(locked_rq, src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	return likely(p->scx.holding_cpu == cpu) &&
@@ -2255,14 +2258,11 @@ static bool consume_remote_task(struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
-	raw_spin_rq_unlock(this_rq);
-
-	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
+	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
 		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
-		raw_spin_rq_unlock(src_rq);
-		raw_spin_rq_lock(this_rq);
+		switch_rq_lock(src_rq, this_rq);
 		return false;
 	}
 }
@@ -2435,7 +2435,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * As DISPATCHING guarantees that @p is wholly ours, we can pretend that
 	 * we're moving from a DSQ and use the same mechanism - mark the task
 	 * under transfer with holding_cpu, release DISPATCHING and then follow
-	 * the same protocol. See unlink_dsq_and_lock_src_rq().
+	 * the same protocol. See unlink_dsq_and_switch_rq_lock().
 	 */
 	p->scx.holding_cpu = raw_smp_processor_id();
 
-- 
2.55.0

