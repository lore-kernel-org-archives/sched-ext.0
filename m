Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447274C8FFB
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527198; cv=fail; b=UAPv2ywlYoe1nxyd4kXGCaKSTtxpkT03uaQIrqlPIoFiakXSswO64KxoUpKauccJpruuR4Lff+atw8Y5wJjI2pEPu52l4A+C3RvrF4rbXTY+Tgb8Cn49dGSzM2fe1f3sVkRbMVNX4+7Sn99ibjrrRywOVT1YeuZMsjUfTCEfxtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527198; c=relaxed/simple;
	bh=fmJbN+oPZEwQH0h+jrEdTvRUiM7T9O9tSAGEEjfUS9w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R9e4oBEddV9bgG2ArKDdbl/v+kVW6r6DoXCVVh8alcFQ+AVtq6b4qO/tWfWkrK+xid22eRvpYZX77P5k+q3qaxc6CKfF8iTGjcq6TBOBAOYsmAgf0E0Gc0p68544jjmFAWmXMJ0y92x5i5kzLl8ZxhvAN+T+2x/iDWzTkrmNv70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iXJ+48xY; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iXJ+48xY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4UGNo9TKsM4BK38JCQQhirFDfI4rEC+yfebHZbUY2AlcsWTUokfMnkvoEpYFJw0XRAdp/3DECElRFl8Il6lXeyMyaCHsW9v2LB+3YSwzNHSv/NqT6w/f8lvaiP25yH1mOrsgtmwgzfxU9SljqZ14JSOc1BPjr2YVlNkMjPK+JYGPEwA59XB9RTdae0x+25YgVz4irr5v/1aw/C+2Gq4QgG54T11fHSmA1t4FQF19wsKHkbMbOqJy9sGUAA4sXnKrvSwmNJpgHuAEGPd477eFG+dqW+vmK7N9YagZHBf92hpqh3yiVPFVPUI1v3Q3XAgRj6IszLRhwXs22hdd59uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKR7YYb0EslcJqS5Y11uPJlhEDJ8/pKfX4dHWfd1uOU=;
 b=VFc5N1hHKzc/wwn8yHLUl0q+SO9mT/6o7U3Pi6YdvqJdO96XLTZeraIPPEcHVBC+RTTcB+AjYBtntMdxyHjOAS2uhf2H7dkbzEt2ga4l5P+aRhbu21ZLyQmejI6KpyRCwEP6xtkefJ6ouXT4MhTlr5rA4odtCUxuRelifspyF4m9z2Sc+qjH2aI3JLd0h45zFb303cIoNTCmuMglNR+bD7sC6RduEJ/nwTy9TcROtEwXXNMp44TO2nx9SB5kEp9VbWma24Hw0nBULih+ns1Dt4eqF9lFdV+th759b7PBy0ncXz7NKR914xVv5Fprn/630rsikn+483etHc5zO+MP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKR7YYb0EslcJqS5Y11uPJlhEDJ8/pKfX4dHWfd1uOU=;
 b=iXJ+48xYo60qnwB0wqw6H3qB048jCDPBFIpJkYh7pCYoT5j74UdeBz7aGmbz3GHL70o/3m7PjQR4h6l6aQUnuHZ3qnQ43zPHOD1EA4w+8j4u+0Cz8lPOQcCDj4h/g3U4gPo2xMSye5DwVPzeWitANK/RlZ69L4UxHx2bjgRoJh6R3V5dX9qcH57BS96mVzTq+wXtTP8QUH/DD7l7NuV3iApwdGmlgL5Uyp0Y4U78YJEygI/PYRYg3mFJr65A8L9VGlJFzFPg+ZTPu0TXMhuztYHrf6R1fbswBWBpFgBdCIBFYk1ZWlW2IP7VT6ZVaNGF2SmaACdU4ZFa8O4PeXFTHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Mon, 11 May 2026 19:19:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:19:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Replace tryget_task_struct() with get_task_struct()
Date: Mon, 11 May 2026 21:19:40 +0200
Message-ID: <20260511191940.119539-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bd48b5-2977-4e14-74eb-08deaf924622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/ltYacQeU5C9ENTX5mIoguOdbRPuBMt8SmpLvfUWFI85oeCfbVZopOt4Xqhw5zlYtuFQw2VXk5r6ONXBaA3gUdmkpEvU0W+5nGAzZfKy5DIO9vQCllv2LPnxaWW1lBOABoQEj6hfwHtzKHc/NYmaro6M20DAsJVaqlRRMbUZ8MVBuxaw34aSQpYT2CYcSTUHeE2DnuHJ9jROP5DY0GA2OMSkNYAlRiqKtp8i2PIhQeBRVz4iKGErUlFV/pjzNCB43yi2CZur0d0AMMTlG0aYqsiGuZpKftcHi5xzmkPdGD0dzGlsY2DNfBn/Rj7yMkJPsBRF5XZ9cQO/+A3sfK4J7DKdrzBsRD/CprITeHuLedX4nziRBzxteWTU6gMj+zRqSuOg7zYvjtCE8T2gkH+YtsBqU0cMUyby+WHa4EeVIidU2HH1mKHr+Y5p2xa0OivxQOUVyBCrkA7NVmVq/mjRm0rCQkK7K92FVNhhIjpgPq0OY8dpgRK9S5Tgy2HNz3Ty8ekM1TE0+2ZuNaKbvbhW+fqlkS5EtQoGb5flIPCDckK0s8aoB9WkiA3AX4+TQ0vapYqr0t/eeqvYtkzGapS3998KOdFZ/f2DVu6/JT2+9xMjr+hHJn3P0JrcCTdiaCrhXM1cpJhqs36OZRx8nR4l8q9D+dGdQCAQFEYgxnaQQB+JUtjX/q4KSZNUCw+ZWAU54vrN6kxdE1KvgALypPq89Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gokEj+apn4VEYfBh1em26U0SB4bqEt6fGj1bVxNO2+vj2sgW8cpVt0cgyXU7?=
 =?us-ascii?Q?QQrVxC2uiN7v+ebwiYbKKbHGRNylbIM5/2x4xNchwl0z5jr1uzE3YAGEMEPo?=
 =?us-ascii?Q?yoZmpAokfQdBzIdgmcVHypKpNurY+wgDma6DNBLeC1vGhsCHFvaJ82KGGJCw?=
 =?us-ascii?Q?bKfmA90DyUFCw6x98yksyPPrrsD/pP9j4sKOLSv2GpzoR0YcoVGtzKDcE4Ic?=
 =?us-ascii?Q?6At8eu5EiSN28zMzIxaiEPRw2LZz0JGH/izKdm+i57EdIYXy5HyfhcwnEuoN?=
 =?us-ascii?Q?hRAYUScGqX01lZKouNoOwaNSZE1ZT6hPf4qqP21Ve1PsIhrGCKJIFZINvFph?=
 =?us-ascii?Q?gaTRtgsb7wWvI+izgxU5p6iZNqC8wuOV5efrwgW3i1NG8AEvk87yIyzFqBbc?=
 =?us-ascii?Q?5+Dt8ubZ47GXlEjydISrXndh+ALL5EDsrnkEIMsDYuc2r9AbvQDqpl/jPFJs?=
 =?us-ascii?Q?3tdDgLmeBGdHIDcZHFBsFMgx1q/SiuFRnQrxI/u6XX0I4t9O1mfbwbMl3bbv?=
 =?us-ascii?Q?FGd2JKdpN4VcgP7bnkOUe1XKaUZDXlwLmBWNaSR0dCGUwWbmTxBlhCOCYBbF?=
 =?us-ascii?Q?IVJbeREgyBHHofJn06MtilpFqpETevBVRyjat7dE/a6olzhgyMK0amekBg06?=
 =?us-ascii?Q?I4PAeARqXlPQptWp71na9OYjs9xdu2AvNIqShdMgr1rofTHUd8w3jrBdVVJj?=
 =?us-ascii?Q?rNtxy2hvPY18u/Z0kAu7zy3k/QLQz/FG/nP+0IIiWsKKAzUx2r62Jk48z6lb?=
 =?us-ascii?Q?mKwwAWGRxa8XdgCiCZ8j1l2Hw+P8Ctw26QGPz/NQTAuXJCWYtdLyjBPxYKQg?=
 =?us-ascii?Q?UdHCTvrod8xfPT1mUxV/12ITLZi1hC9kEVKJS+6kdG2mlP7vny9kLARwUsh2?=
 =?us-ascii?Q?UCS+ZUM831HU8ot2p0Xx8LwGijzmaLs/4gvmlSP1H81XdMbnKnz2o9YzAH8Z?=
 =?us-ascii?Q?W2PNByvL3AAeVYzWZb5NHaZ3xguLd9UXAUNL2zNlR/RFvSnNWQIxroxv32gu?=
 =?us-ascii?Q?G0Wwt6/9BUFg4XvJCBW6EIb5jwqBad8TsPew8GjzhKHEr9QXN+Sk9bnj/yx9?=
 =?us-ascii?Q?tu0NJ1Le6iCT01KqwW2d54tYgTzFTRbzJRxPHA4MpozQBKCDp/OtqFBrG+1l?=
 =?us-ascii?Q?qhfu3HoZ+eiLoS9Uj36SkTFU3yaPKe4Lf56zgeH973+2qHTlZLYomNvP38y6?=
 =?us-ascii?Q?J5lb3AMEx4Sg2dzzByrkCkmsbEnVzzZrUy9VcQhnixS9EROucN4+JJrDtTEp?=
 =?us-ascii?Q?RvCBYxgXQfNQKtV7HGyWiB5eeU6Oplu8cVCHYVMfqdoEJ56FyQD+iNIpiooi?=
 =?us-ascii?Q?M3M0okT7ym/mFzTGaPpjGD5x0653PjCt2fd9uUJ92ehlYSZ9fRU+ShwqTcnk?=
 =?us-ascii?Q?T0uZ34fbO8w46pX8TUdFBhEluYams7SkC1zRNkDecI2MtQxiZ0AB9CSon/nT?=
 =?us-ascii?Q?Bozv8g6embRMlsPaWWNhNVnbYZG+P+csIwbw93s8ZI26POqaYhnCehZMXb8+?=
 =?us-ascii?Q?smMa0KCM4WStsAyUtuWn+0goXjiKWCJ40Yo1DpZZVqFbPVq3RinlvYFF2BvC?=
 =?us-ascii?Q?NsG6njieUqg7UXMzUSVfTefps2b304WCx5kna/Y0n0FOd0tf4W5YC+1nvhTq?=
 =?us-ascii?Q?Q/6xk4C2HJnXTz7oH6tjHTRrFq5roASt8HsTHJDbrZgD+DlK2OmpTUs3bCoC?=
 =?us-ascii?Q?v6kJWr7kohASgRnt5nQcyZVtCYUbXu4wQexDZzD3I7hQNvjnj8rf2/GQFi8d?=
 =?us-ascii?Q?LmgmsVPVuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bd48b5-2977-4e14-74eb-08deaf924622
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:19:51.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnDCuNqAxU5gwKkXPihtC78L8gEyEmarax6XhH3so6M8qqPO5SQQNnjmGVuCIcJIzq7DvF7Ap5Oa8dKNzPGPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

The tryget_task_struct() calls in scx_sub_disable(),
scx_root_enable_workfn() and scx_sub_enable_workfn() can never fail at
the points they're invoked:

 - scx_root_enable_workfn() iterates over scx_tasks under scx_tasks_lock
   and rq lock. sched_ext_dead() removes tasks from scx_tasks under the
   same scx_tasks_lock before put_task_struct_rcu_user() runs in
   finish_task_switch(). So any task observed in scx_tasks must have
   usage > 0; put_task_struct_rcu_user() hasn't been called and the
   delayed_put_task_struct() callback that decrements usage cannot have
   been queued.

 - scx_sub_disable() and scx_sub_enable_workfn() iterate via
   css_task_iter, which takes a reference on each task in
   css_task_iter_next() and holds it until the next iter_next() call, so
   usage > 0 is guaranteed by the iter itself.

The actual filter for dead tasks is the SCX_TASK_DEAD check inside
scx_task_iter_next_locked(), not tryget; tryget only fails on zero
usage, a state that can't be reached for tasks visible to these iters.

Commit 54d1429e7180 ("sched_ext: Use SCX_TASK_READY test instead of
tryget_task_struct() during class switch") removed an analogous tryget
in the class-switch loop. Convert the remaining tryget calls to plain
get_task_struct() and update the comment in scx_root_enable_workfn()
that suggested tasks could be observed with zero @usage waiting for an
RCU grace period.

Link: https://lore.kernel.org/all/agCLBxHEUqWIepx8@google.com
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b8dd3358959d7..64dfaf4dc5b2f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5933,14 +5933,11 @@ static void scx_sub_disable(struct scx_sched *sch)
 		WARN_ON_ONCE(!scx_task_on_sched(sch, p));
 
 		/*
-		 * If $p is about to be freed, nothing prevents $sch from
-		 * unloading before $p reaches sched_ext_free(). Disable and
-		 * exit $p right away.
+		 * @p is pinned by the iter: css_task_iter_next() takes a
+		 * reference and holds it until the next iter_next() call, so
+		 * @p->usage is guaranteed > 0.
 		 */
-		if (!tryget_task_struct(p)) {
-			scx_disable_and_exit_task(sch, p);
-			continue;
-		}
+		get_task_struct(p);
 
 		scx_task_iter_unlock(&sti);
 
@@ -7181,12 +7178,13 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
-		 * @p may already be dead, have lost all its usages counts and
-		 * be waiting for RCU grace period before being freed. @p can't
-		 * be initialized for SCX in such cases and should be ignored.
+		 * @p is in scx_tasks under scx_tasks_lock, and SCX_TASK_DEAD
+		 * tasks are filtered by scx_task_iter_next_locked().
+		 * sched_ext_dead() removes @p from scx_tasks under the same
+		 * lock before put_task_struct_rcu_user() runs, so @p->usage
+		 * is guaranteed > 0 here.
 		 */
-		if (!tryget_task_struct(p))
-			continue;
+		get_task_struct(p);
 
 		/*
 		 * Set %INIT_BEGIN under the iter's rq lock so that a concurrent
@@ -7487,9 +7485,8 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		if (p->scx.flags & SCX_TASK_SUB_INIT)
 			continue;
 
-		/* see scx_root_enable() */
-		if (!tryget_task_struct(p))
-			continue;
+		/* @p is pinned by the iter; see scx_sub_disable() */
+		get_task_struct(p);
 
 		if (!assert_task_ready_or_enabled(p)) {
 			ret = -EINVAL;
-- 
2.54.0

