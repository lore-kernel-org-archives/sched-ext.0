Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485924;
	b=agbxHOqWCrFuu27wdvkllUJURHtSqpBdKYIMaRJoRGuL76wxMUd7K/m6WJ93rkk16lsO
	 1bE+lMsKZmFHl3p3aQr5EV48PprdXI1nPUx9G3y7y9Jhf6d8l5uIrju3bd44S986IQOqs
	 kEfbxBoFIhHj+qtdG4DLzqrgWgcKYLtR9oOfzRo8Ep2eHTrjHiMrscTndJR8MIKjAiAG2
	 3x0CBQKOWnw3saJ7SfjvHBpJwt4/hEO2IUQBvdq9Wp9kSl0rfqpFLn6bZnNBT0/YHahhN
	 0MjW+6EISbUPdW6+Yw+VBs9fyrdf4eRivGbXfUpz8QAmnitsCtyqiBaAcO/64PNssIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485924;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nN89bvKSx49xFm/0n0QA/nkFL20mY7JiqkmUoJfNfO8=;
	b=zdF7Ar4isFWqXxqJlNl0qywk96o3PZU/foMts470nH0VLmUG9lgGMmSFR1p9tvQ1AUGS
	 kwdYGpztyVNe/Dx2I32lsIk9mN9NP9Mvoy9p3DDWRlLcOT3lyToSVqDcFsgU9pkU6rfkB
	 15ktjya8IzDgr8q/Dh857ompwaMWLgturB4/HtVs98Y0+mrKPZqSWuqM5rY4Ka/6r6II/
	 XC21pBFxBkE4QcAUmHSIVaVSwkrP40kKjoya7DIujb8ijleJRiYW/sb35wcjOTiWceebW
	 Lew/kxpbD6NjCGy+cNpi0oxgHTgZTkLprfBgy94RaBQbvUZ2J1FQCAHgGRWTxSoO9dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YKEMHkBQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827860A260A
	for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 08:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A827860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YKEMHkBQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK/ZmIMbBfMjGBYTBqwYfpl0Wis1UAzf4Hc85ig5hBcqyeua5CwTLhNHTzi9892skrdgjU107J50F6Pe4+7FJ1zJMiyCwBYx3wdJ6e1wMTC22FwiwS08kKu+1LPVfmNKOaBLjYAUBYxMwaFHu3Ly5Q+xz1Bw6BoN8IWL3lDUbHgd9l699ecod9RjeXcj5+3DszuBz+C/EMd6JoE5tW+bppsbQtfjB3fXyUSiHrqb2uuqy6cX3xu8zWLxIfERFbUov3PSlOQaUYxaP8SXrX/7AcpuSmnGUgJf9N9sA46HBmpOTsCzSWwQ9+iilIKOroZEYfWLGKb+jFrZFPSGV/xF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN89bvKSx49xFm/0n0QA/nkFL20mY7JiqkmUoJfNfO8=;
 b=r2i5xIX2/MTWx/vL2HzoCGP40x1pTiuG5/vPmNbqOEmDi4KYOS/pB6dfJ7fDM4O8GGMYQuNsvlzNbull0ReN5Rn3eCVmgBBRhixS28dAEllfNPFhmx4Fx1yXHi9RbYc65o6tokg7PJxOJl/7p77k8yMhOyXKYDdvk0qEtPHFTa0KYy1bRNSqBQa8IZrQml6HtphgxAt9i6hRABvjUr1gTOVuMkVd5yl/UNmLBBVutLyVk7IsZkkq/ErKYovGHYxm79Jq2G1NL9uMonXgpdkGO/FwKqJBH6Hx/Ok4gTinGsbXjOyEJMRp3GUXYRMQ1UPoJVF/yoie/Zel/fibZ6qGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN89bvKSx49xFm/0n0QA/nkFL20mY7JiqkmUoJfNfO8=;
 b=YKEMHkBQk9FbLcRInDCxGWRUe7fYLN9CCp1A7uFq//sllZm4et7sJZIOOpmIrGTD5A5T2ITvamZ0E5xLfkxtNOf3H0pdKdCnaoaXM6XLz+GACS8TdKC+2oCN0U2yX4VGMYdbiDzzpbPOxtgxf2W0JIsPLIlvlmUszaCYi/G7EPQF+oMGrsgIwFF2SZZVfDEXuJtT15jTfZme5Ve0fEDA3WrW3uSLHVAzeLdLu+m35m3C9h8Ac3u9OFjYGZFrm35cHwrjtbKwI/7XCUihAPDCmZ069wOMcbHBT5GyZhRrWQyFzVe8TNcrPbLHriXtoMeFIaBySuHabx201JRlmZN19A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 20 Oct
 2026 08:45:21 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 08:45:21 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched_ext: Use irq_work for deferred actions with proxy execution
Date: Tue, 20 Oct 2026 10:43:20 +0200
Message-ID: <20261020084400.845842-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020084400.845842-1-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 709b6123-b5e9-4df6-0540-08df2e8679a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HMNwEny98gOPpLoPRGmOZvXSWCULxAHUX9gvFR9p4G7uwS28mpJD1Foq3nS3+qhQvYBZyfLfRrj/lc3aTVKWLi3PM34+9Zg9YNiQoRz0h5AmH8UrdurXCwZ+JbK/GvFPpD6X+005jQolQ1enVjxvJFduUuPHNoGdrHCrZGwTMOvqtkbPuIfg7Wrp6ktWFeT78PFU91dVX6g279yvHqXW6uUKdLowDQDlmgKDkqvWuHzJ3dG3qk97QbYWb5X+8rRcueFJQEIkIPPkI5kIoxwNKQhYQhZ17FzNogqxD6smv9OfsprVkUNs2b4p7kEtOOQWts7+4PVv0f/6exevjpOyk0cNgD/vzE0w/lK7BWt9WkhtUb607O4z0jjVXt9hmFzBYsD1MoAzTNbfyvIRCfX04YSGeqaEkAIVytEydMScpNSiVRoYozuyFj4kBURZA1Tir9t0lYB/4pn46KdhH6X2MnoIampT5gCC+/bZoDocgoWmvximK7z1bLpNGUPoH293T/iwhPAyeh6WCRkufvOOcMHr+C47/AXcGXvgH6i9fv2YPSaX4UlO+MIn9IF5rpnA5/xjKzcjphbkJr4dbD0PaGx+HX5h69HWq6faOAYJz1XKCpLRG1m0E6XWBjPG7XqeA6cIPyYFu7/D1idA/NIyjUgUyNLQEh6+/SYdk6Wo6vg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZuIEB9rM9Kb/aGiywKoMBTrd5sFqTxI4PFiUF4NDRFCisHe3x2f1KmMB0yld?=
 =?us-ascii?Q?yRcjfqYeZbogw4NiKFsdLiXGl6mb7k9UHR9iZa/Z1BpEp1x3Tdj1ihajUyWK?=
 =?us-ascii?Q?AEmWbbEi+wbx+Acaj468wSkEg0pSjNjFaGaAcYbnMAN3AN9RpYLmyidLWrtU?=
 =?us-ascii?Q?sp5pnZZBKUy0WTWchCXBq0HXYuO4zn0MqWDcijUw9+ykJpwKCVS8Ay5IV1ZY?=
 =?us-ascii?Q?y714LkZxiXUp5VdB2gF+FNtRC6Pp0BXdIS61juHWyqWRSUzMVoWpY2KJpODA?=
 =?us-ascii?Q?buo+YYbuGCr+RfuK+bzI9NoFwPVEHAhj2h2OT0ofop1Pi8g7gcl10pQ1zXSo?=
 =?us-ascii?Q?i/QFoWaBZFJP7QIyodGc6wMqxPOrHRlnP3NdB4OL7Wn/A/tvRndMmjWIv0H1?=
 =?us-ascii?Q?tRmn80mQNj67PPQlcVzqUeGOyh39x+L1KlRrroZ03Gs/cQ6bsuKvtYX19Tvy?=
 =?us-ascii?Q?4zeBPBsspVEj310gqfbpGds/qRLs8tOD1VzuRzAreKJonn38FA/0mxvpkLUH?=
 =?us-ascii?Q?WwrtyCuHvvXhILcU+lLhP9N03xRe7bnswxPvpkchvV6tSH5QAqWyGTw+FJb1?=
 =?us-ascii?Q?rhzI2vhTMfW1dtjpfqbCSk2euoBhraP902yaUTXDm3y6DCVl8kjUNTIQDfQZ?=
 =?us-ascii?Q?azdINCwcUYYbI6qXGpcMpxQjyOMHZmYwgd0smwIqxE3fqY9Xh+/0f+qGVUE+?=
 =?us-ascii?Q?VPcSWd9jjHgQX1v64wtEBXG8YuqyFP8YGD4sZzjrzkmn8qSV7OrypyDWWJ+F?=
 =?us-ascii?Q?nq87PhXo/iukSrqVfk6/KpJxkxzINnrUYdJVsjZPgiFTBFYmrJzdngJ44o02?=
 =?us-ascii?Q?pb2rkRsVIalvA0e29UOEBlW5nBW3x6fyhWL1K5bK/jbJCxGZKfOPFJ6Qj+zf?=
 =?us-ascii?Q?nYIhACV26+fOOFMO1rkwsSkm6rO0dR7gvQEJLxzrMuz+yBxbs0I7GIUU9C66?=
 =?us-ascii?Q?6WvKQBsQvaQGb9B3Rk744g/zxC+PkJtWK/eFArR62D/jdW9bMCGK1FrVrKsk?=
 =?us-ascii?Q?YpzBSujDbE+NGuX51FAovd3osY0APD8wWCZaFBV+MRwbtvUKtz6mLXMQpZjs?=
 =?us-ascii?Q?0ELUu6rC9oo4ja+67jnnUc/t3ECQ0PFqdAqc1qDw6ICA5+pnTb2kyQQ4DpAK?=
 =?us-ascii?Q?RWy8iIs3tYoypK4CG5usXtQ3rzXuyA1InQ27p8CIbWyFgQBs3yLmwd2O4U1V?=
 =?us-ascii?Q?6f4vE+5RckN/7Nc0fDm6owXLD60RhXujjTFtP9ZHB5ljnyDJEobJoegeKMi7?=
 =?us-ascii?Q?i+Q9z3bhScHlDVztjSFlcGQ3X/WiYSmJ6FJgy1doLn12NEUaEcYiffinu+X7?=
 =?us-ascii?Q?UfMmla3IcduGFv4oTUzuopIquf6/b+rPP4TVq7YfmSSCbc0E5eCMpLNkjSyJ?=
 =?us-ascii?Q?2EqDGZvREuGjlE74gKdfqZY27EG7yqvdPGHk7MZ+EIK6EBQZlJj2TRO2KNM7?=
 =?us-ascii?Q?UnfZrBL9hdnfHaohxfvhyhsgJct2Y/RxAFzcYKbZkdzN+0U5RJuQj1KwJfWE?=
 =?us-ascii?Q?utB1+ud2Ag1/Mf0Ec1aYVeiXjg+ke5tdsaopJ01Bpn9xrKTCoGT9/hXl1Kcs?=
 =?us-ascii?Q?vPKjbVf6bLMW4hcyTqRsEnz9fhGHc1x5lS2cxEOEEzsY+UZ2vXgUPSY0hz5w?=
 =?us-ascii?Q?ow6FkbXBtmNSqTXzhQSdtW81wnoGRDYHVOHvvp8Y8JvdRPjPPsUyapzZ7DcH?=
 =?us-ascii?Q?ybGiPlXWRkwr+j16VxdKoa3wbsgqrDmOWc8H342AVEpIhMkM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709b6123-b5e9-4df6-0540-08df2e8679a7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:45:21.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/sbIHsAe2GELAOjyB0G1geNnDg6x4LVvUTlgiLNcIZOACrXsE8yu4OsIWZ8sPippoRv9pZ9zQo/f1bqJ4NiIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

maybe_queue_balance_callback() clears SCX_RQ_BAL_CB_PENDING when it
queues the deferred callback. Proxy resolution can then zap the callback
without running it, leaving the deferred actions unscheduled until a
later wakeup or deferred request.

Use the existing irq_work fallback for dispatch-time deferred requests
when proxy execution is enabled. This keeps the work scheduled even if
proxy resolution retries the pick or falls back to idle, without relying
on another SCX dispatch to restore a discarded callback.

Fixes: a8ad873113d3 ("sched_ext: defer queue_balance_callback() until after ops.dispatch")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5efc3ad1b1198..4b7d2602b4d40 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1129,9 +1129,10 @@ static void schedule_deferred_locked(struct rq *rq)
 		return;
 
 	/*
-	 * If in dispatch, the balance callbacks will be called before rq lock
-	 * is released. Schedule one.
-	 *
+	 * If in dispatch without proxy execution, the balance callbacks will
+	 * be called before rq lock is released. Schedule one. With proxy
+	 * execution, proxy resolution can zap the callbacks without another
+	 * SCX dispatch to requeue them, so use irq_work instead.
 	 *
 	 * We can't directly insert the callback into the
 	 * rq's list: The call can drop its lock and make the pending balance
@@ -1139,7 +1140,7 @@ static void schedule_deferred_locked(struct rq *rq)
 	 *
 	 * Just let dispatch_one() know that it must do it itself.
 	 */
-	if (rq->scx.flags & SCX_RQ_IN_DISPATCH) {
+	if ((rq->scx.flags & SCX_RQ_IN_DISPATCH) && !sched_proxy_exec()) {
 		rq->scx.flags |= SCX_RQ_BAL_CB_PENDING;
 		return;
 	}
-- 
2.56.0

