Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DE33F5BE
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012818; cv=fail; b=fqRKXWrOqGFqZgzpam7OU0JFMv1uXJqYuw8WijtC6jeWe9iFpVQaDrPRpVJ731kBWkZ7EjT63CfA78uY7y2d5tiznIVfpcVowu2kBknNC8LzHfq2ldFzyk1Rro2xJXjktRjFHQTmZWFMjKDzZTkYwXu2oByihkcgtvaEBFmtec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012818; c=relaxed/simple;
	bh=++zmNdlyZUOju2a2Y6ORCCVAJ1wD8soC2N1SmCwCXJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHTBw53YXyxOhWmvtD50J0Q2EDSWovCVs71sK8g3D6HqWi5ESKwtBTcoNMFh0HKLO/9lvW1s4PdNgCCmo1khMtUmNYSMEXPCJX/US/cbe9hLZRAhiW4aXM/cDn1pfui9H2cprgDNtrvW11HXvDcU1RukkR+Amhi+uqNFddbsyho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SdTl4C4W; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SdTl4C4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVWKcnXLoNc+V+uhoUgrDKakEL+LqejKaA3F8GEPjj/uC1cGseuhxy5Uxx8S/itwz+hcWwX72EVjhrlJsjCOs7ZUh+YZci6z31rhpjF88lcMW5kSAjDXwiDdqR6mqxjL0rtN2r3c5rK1IHJMUtUPqe8GZyAbLp2l/2XsOCGT5pl8rDAsunukctGRLPltNWlRJrbT1r7eQrzQXctKlFBtJk3mLHP8Dez2kI8kZFcvrFLYcjkO4jkBP0x6iU8mwSqOuthuwExHG3eHUFpUqqQRh6GUh9HlEJUUrZ5S214CKS2y6l3TScOQ0Ec5ETKnkDeF5Y3MAnODvxxif0mXvs6/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMJImA3NiDleObUykKIwehPadZ9igIhkwxYNz/LbaUo=;
 b=K3mR55/vUH354dP5kCNf930gjLxFxu6DG1QGKn3Yn6MeGV1xFvO5xfhOOvBB4m+lf5QefWk9cq8VtQb42u18wY9ERvliDd7HHpicQUzcmOzgaU4F80a0om9JViIwD0GMWMwWc8UWtsWJTxlW4jlzBZPXhehAryzM4gzbBywn3l+caNZhS6EREZVqAQVpYr9ea62e6caqNp3fe/GM77DYbIY64k1PcAjIRE64LL4dzyPydIDiWtmjHYUO/X/jF2A6a06DauKoQxiKlIA2x6o8FlGSsXCaESlua/+/VXKDVCy/8XSMO/XKqk2fI1gthLGpVpgdz+OQJuMted/nc/8UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMJImA3NiDleObUykKIwehPadZ9igIhkwxYNz/LbaUo=;
 b=SdTl4C4WRFtkJqwoKALIjEEO5QnyKifRQRiEMSuUWI/2raSqmuNFS6g3xss0Q+welLzNJXNzk7zoCENph9x4cxZXUgidvnvVT+XoWQTJj/EQTteBzU1EVrFhn+LoZsPp26DHtji59a/PhVlhgFZWIa1FdEAZmHFx9el6Nb9dGEL1MKmjYbQ8s/U3pp7cQrqRNzH4PCl6/J22JgduKMhMT/EFL051oO0WQ9wtQavx2mbJNVPUZ5G1UyT0Jp0Rp/sJphkXTX+HEkHyWgCVrawNztwT1u0EbBlIM6Fw4rOL1tpDhMbuj7kYf94JHot+5XRdgFq4UTlqhoFHHrMbNIHAZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:20:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:20:12 +0000
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
Subject: [PATCH 05/12] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Thu,  2 Jul 2026 19:09:21 +0200
Message-ID: <20260702171909.1994478-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c239ed-a6db-435d-047d-08ded85e2cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KoyML0Pk6Ek9Y9Oqt2NQYNtDkgCVx7aysS8mA84FJfH8xqTLz5Ce3HCoW2cSuRVKr3veZVAYospEqnJ4sNzuXazfxB2ZTA0g3G0yDbNK+/xSaYKFLKCs9+WBABCE5mhMoUV1V6/4Ed0dvv+evwP+EeN5u8oRq+vR28npUZEFkRmgXcj8AIliT3Ec54aqgb3H9QGJK1bcQEZyBt/RVnoQV2YoWG/Pk5/FmuyPtiQSqjkbnV6uyotRIlATjxfI4in2pDOn8efiIAYkIu9iHl+XaG/vQniVhqxIhVO8nHDla5LW9DXzBCK6VwLiS8I6OlIYhWuFobMi/r0oCLhgqmK38vbSdPfNk5wv/8XMIpYwd7OfwIdZpBL7mX6zV4ScDo+GyZ/PzUn3UdxNrXfiGswoDM/fOrf0Dbjjx/kekjB87gmwjgkEev5ZgfiIJV38pyjeCXYJ46ShHyUunyzmrhlKW/4c+i3NFbtOcSOZbLQ1YhDOK49bstKZNMrCzUs3GCqVcrXD8ZgKeIMSMjbMulh6VFZf01qy0ZmBd/OKO8ClrFmtrM6lr55dsUSwnkFGICo8hz9+JpcZpuj5MD7izIQE4BFCw5xhnf66UPaNLtHYb1tQTYKhtbw5MQUINCYbNqb1dg0v2jcXHNG4BcHwTGYMV/nbgY4XLhXcTe1h6D3D5j4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1L6DuEjZMjdYdZRSEeJysiIg6DDBvk/M6IZ3EQiZKYyhnMnFa1d2JW9ImihN?=
 =?us-ascii?Q?y0WxVmflZl3ZOxtPAnXBcHl9cFpXFkpeSkkJm5RG/Xq0byHWsd/wJ05S4xvV?=
 =?us-ascii?Q?JXbAY8wVvwDE0H1QbZGvsR1/Gw2nDN+oAbI+hRNMOsFsuirMKRN/xQUtT278?=
 =?us-ascii?Q?kGszcWFB2B1COUnpxxRKc1yFA+prT9FBuztocJeHGddWxgIqoD7mVhqbKRiA?=
 =?us-ascii?Q?PlLzpiHWbpyz8m3MbcSG0OT+UCERoy4ot96LIo5jUViKAR6+f6YGrrHeBXei?=
 =?us-ascii?Q?RH3nllZl+evGjQ1kOZntqeaJmYMg63GAYDNOZLaL+h4b8F3dhm7jz5i/3NAD?=
 =?us-ascii?Q?Gfor1yob7EvWGe66UOYKW1dJi2KJF9THCubyD8cC8jlRhSzI2340Qseg3179?=
 =?us-ascii?Q?KMfjpBanhhHfrPquVk27v1677wB87acXmGCxEO3QFiP0mcYvWkq8R08ojxZP?=
 =?us-ascii?Q?+L0CZiEL6gGg/Uozjj8GnwR5vKXCGO34rkm+M+Z28H76Dr+ErhQdDTxg9AYa?=
 =?us-ascii?Q?GuRLE5nxX/6cL+e+EZYsKypjNeBCtjXsF4cfXh/PZAFx5AkI036SMM/7+BsO?=
 =?us-ascii?Q?dJnGDUial8Yy48K+BE4yBKddry2UpTa+Toed9ZJpLK5m8+/Zf2C5tC26rOb8?=
 =?us-ascii?Q?fv6z3pUsWHtkLIuTWqNYXvf82EP8zst3JYd+RETB40pMv9JZZchZHpKvOXLw?=
 =?us-ascii?Q?Den8TDFQ7Ib9wOsBRKNlkryj84My8cxJX94DAqgyqf5WHE2Ng3ldnH60s02q?=
 =?us-ascii?Q?5U18LZBtYgHUrtdNnF5D7NYccpCK+GIQ8eEqqqghhc2tspoOxzlOz76Cp7jy?=
 =?us-ascii?Q?w3VUSoiqT+jBW7odkLt3DT0/XfPiL6R0cbmJjvYo1T4Yu+GbBvrPuscFu+vN?=
 =?us-ascii?Q?iiQeqH4Dqd2Z5qHzlM45Ap2eEE1vtONQynpLjgc4g96xpiF9TGMJpHeU7YNA?=
 =?us-ascii?Q?E+l+SSD9KmKUFlOXwokQj4duH2+DUCHePd346s6VtkbhrgSc5FaH247oro8+?=
 =?us-ascii?Q?KZM3TTZmq82YaybkewoeGGi1Nak+DwwnfLDar1nihmTVtpAdWskDzcdDRrvu?=
 =?us-ascii?Q?cMlDmgd1+9e/hm5irS0Qex4/cfHzYu+QQjCeko39njv42Pf0WKbZXPk95kpU?=
 =?us-ascii?Q?nKbWY8tQd5QBc083ga0dbLrhthJRAq+/nHhwbShyZbtlTrziRFJw0HU1OpOj?=
 =?us-ascii?Q?2y6Cpvht5WroN3qzqoUI5uWJXfodni/yPn/e1kiVRkfsku+LAnimHZRbnH2n?=
 =?us-ascii?Q?9ps+eMYm3SocXguxXCDgsnglmtywN0ooOlamWUBadtAqyAffiaUDwgW76jgL?=
 =?us-ascii?Q?MQ4aGcHHUsa+ylH2Ir8DftfGm2e6xS3IW4UHv2Hpltdl/xxEbR1rbDiLOx9Z?=
 =?us-ascii?Q?tRNBHBOe3S37R67klFSa1J0R0ZUJoY88RVYpXHYu7oBcgvl4L2eCbOi8S639?=
 =?us-ascii?Q?c0aOJj/4yvJLL6uakB36Emb44WazmY8cc8B+zgDgIPT/qIhwBaDauGbMU9iZ?=
 =?us-ascii?Q?UK5Dmek5Al+pRsQqd1T8mXQcneJ0rINKT0c/wMRDwvC5Nzv9HqjvE9rNeXn+?=
 =?us-ascii?Q?BVBPOChgXy6seyyU0FNeYzJ+C2VdWXev1cmfyfXxWjaoUgpodBXr76qBzfd/?=
 =?us-ascii?Q?6VmS7BfB+cAvjt3zGaijPYwzFy+PuD55fp/nhSUgzkHiCMvBagP40SYR6UXq?=
 =?us-ascii?Q?5kNbpXVPxDQlw4u2khVQbRl7qsip2anriiN4l9VO5kQSZtdE1gpKeW6KSmVb?=
 =?us-ascii?Q?qeHcgGQ3eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c239ed-a6db-435d-047d-08ded85e2cb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:20:12.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv9cIoFleA4hdDvL2rVEItSYu14fZnjS0w/1MVA9IYxFpGabQgG+cAR1uadd+DMj1m2yDKSngWzQl3LZIAGsNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

When pulling a task from a non-local DSQ, consume_dispatch_q() checks if
the task can run on the destination rq via task_can_run_on_remote_rq().
However, it then drops the destination rq lock and locks the source rq
in consume_remote_task() -> unlink_dsq_and_lock_src_rq(). During this
window, the task might have become migration disabled, making it invalid
to migrate it to the destination rq.

Fix this by re-evaluating task_can_run_on_remote_rq() in
consume_remote_task() after the source rq is locked. If the task can no
longer be migrated, we clear its DSQ association, reset the holding CPU,
and enqueue it to the source rq's local DSQ instead.

While the destination rq lock is dropped, clear the tracked rq state and
restore it after reacquiring the lock. Otherwise, a nested ops.dequeue()
callback can attempt to restore an rq which is no longer locked.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 43 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9a672b9a55f6e..189ba9c42043a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2248,20 +2248,49 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
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
+		if (unlikely(!task_can_run_on_remote_rq(sch, p, this_rq, true))) {
+			p->scx.dsq = NULL;
+			p->scx.holding_cpu = -1;
+			scx_dispatch_enqueue(sch, src_rq, &src_rq->scx.local_dsq, p,
+					     enq_flags | SCX_ENQ_CLEAR_OPSS);
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
@@ -2371,7 +2400,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.55.0

