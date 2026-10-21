Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566349;
	b=Z00cCNTiefeXDN9lY6TGtPWuSoUodPQjIA+e5WNXDBLRoNz2NT3k+bMyZmqIj53CX58T
	 d0F35ZgFcYqbPt/BIg6scpCdu3cc5tTqaCL1BHaEaqswgzl8mdztkPbAqojqV5i+De8ky
	 zlv458tZBx7d7nrRTR4kK+iPaqyacVMW6T6TKhpQC3v04Re5sdQb/GH/t3fJe/ypeZLkD
	 LtKYrAQqBN58I0PGjPLWacjlk4ypbCL5xOD0yLrKO90iDzlsrbo0q2YtLshlM+5Yj8F2a
	 TQTq4XWBiKcF1aI2edWofIVGaG7DJRG2Mb7RM612TcCIXJ1zm2WfnTolUnoW6X2R+Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JsTLgYZpIKvHbJB359l4psUZPWxPsc34vO2eSdQufJg=;
	b=nBTlMaxJnvh1maLOYAbyY09jU68NXFCZWsW76iyXBeGeMBasIC0pWclB87p/yAVLRYyF
	 459T+80FypZQEBWdP3ki88G2/wGWn2F6x/Bptp+uy94+Ay6bA+6c8LPCioLzjvkhCYYZ8
	 z6ruZiD+LedPzNlauiP8GrxUmxkeXRW4yTrRGPiGh7LLNi//lF2ZhMC8ATHta4MADjah/
	 46GDUVhpsCt7/2BtKlLcbGvvomOJz4MlXr/v76BCov1wOnmnpKF/E03CWy4ZKgi0L+/7G
	 9av4dmc/1kJ7O9iQ7DeW3ElOAhO15f8OAxoXLtqNQX7fuEcH1H0pc5hz1s7NyGBQkrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PvG2UNJj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86418606A319
	for <sched-ext@lists.linux.dev>; Wed, 21 Oct 2026 07:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86418606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PvG2UNJj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioCmuOT2Hy1BzlKhnlm0UBbkSnaBBIH/rakADWZaxQ42KoLCRmpiwLpV1gcID8yX7ygRmPpdjPA3jJwb5WsYacAMq0ybWwdRnUhyC2JQv/40HHt4E1g2os+QsE5C8f0aGxQlBY7/TNK/52FvR6OiHDg3ams/vhZw2UfWsI0z8DaeC4J5raraewX1M9DkaBbIisvAlHf2/ZfbR2xzivylV0brOoanm+psR9aRlR4II8ECAab0yvsjPF4FFQ9d2srCn0hbV1jHwY7DKkAw7XNciuDWk8KlaQLKbmO6I3Byig0VsbQqOTWMGqLFVzLm9vio6RoKmk6MxmAZrLff/coixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsTLgYZpIKvHbJB359l4psUZPWxPsc34vO2eSdQufJg=;
 b=CTMBva1obpPH9fvIIKtAbSd153LtAdAjevgxF/67dc9m0krxk3lBIkd1AX09pmQP6usKFhpxBBfzp8uxdIAYAuebuDRYi2c8FZ11dKPAOvdm0d5EWcPmddGix5SlDIfeoe/Ug1XQmL2mzLGzUcakoNfb3HyB80J8kWvRqTWNTTKDjP6GtMftXXV/eb2lTEsIyqCBqHmwXX53frWMhe+2D97mQ0fyKb1KRuwZh6Ayt8Yb5LZf++/LlIDJ9i453yKonbYYqSHFnz7K//fTZVf5781bBwTGJn48PpLY0/B6wa/BjN3Uheds+D6ftXZ/Fni4+NsNZLETZEXCuS/tjh7ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsTLgYZpIKvHbJB359l4psUZPWxPsc34vO2eSdQufJg=;
 b=PvG2UNJjxmZKmY0Pm9dAii4guL6KUO/tuOuDVe3965yaYeTss8oZ5lT5EQjco06vqi+cZpNK3fc/VSXPWG1eUlDFru+PajrqueSeK2MRfcuICVIuXIStMdT8hh8UX4ZivxibBXRi/QxYvnk5VJmBC0del/hMUzTyBFM5d/+diKR19itzBH9Nk3+sXkuJDDTksdjmm4B10fTSTSonAdj7VpT9hY0PEC2OjDLtTYT+wJFM9AImjcZj4F7yUHeM3NNFmu7Gqk9JZNKOOgEwyHhvqwEqsjYYmG3pl+gEO0zhaCR0azwMhxWPpSfSNVSz0AkUBrgwlT+76kLfZuhhIv4Wzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:05:44 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 07:05:44 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4-fixes] sched/core: Avoid requeueing a singleton balance callback
Date: Wed, 21 Oct 2026 09:05:35 +0200
Message-ID: <20261021070535.1256337-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0065.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::9) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: afea0e3f-ae71-4e91-6709-08df2f41b96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	IAkGYPPb4d94hKrRqguAJhR7Ygep9B9W0aPLHQgoGK0vPjC3POEMmH6hqwcVOTv/5PzP9smPMM+AXUg2x9IBREsNGiN0atwrfvyj2sOMHrAM2k3o0hWCxyffXhcfNh6yzTUOxLCtOT8WmKCKffYvvhfGpUj2C2dqSWXcKOoO4X8dv6YAZvU9wxb2sy9B+vPQ0qdFGsRXnmwwpc8aRwoWc0dKZ/uJWO9xQs6DROfWlru6hTaIcXT4UUpuCdm6P5H0OY7btqDDRddh8MMcpEAffLdZXKNNv9Gbf+y9x0lMWZUMWVV1ev32d7KvRXKkJUqETUkb6xafI6NH50dezf/Lb3GtSMEvVtBZ9oeSTOb/NLZPtQvWTK+SjRmgdnr2FSISWJrQzq4fNAGUxVVMIWsMNPuoGGsvZCicTvcdS1ksPNv6j59JrcbwvWaEK4SsJx7jiQ7b8EYStTrdK15NbDUcsw4lO1vLwtrlQojPvfSL3LZ0gFTZSeYOyOApwsk5JWqVupdnBMl9nXDAHZPuTV5dOe2Npkbu7lR8Dl6x6jwPg6SARNy+kKuKt+3MK3D+lsq0LNR2VzFDEGl1MVYRKcViCSxQYzHyH+IBKzZJNmIeRzWs83jR1ydRDBvyiFI7v0KObauX4iURCJDuJ/1cgpN+yvPegymuCJDyU4bIY6UGfjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRrmm9xaz6SWvaghiqwVzF2xVXQoJuSamJZyM/WY2dxEnONrl5I184FoYBMJ?=
 =?us-ascii?Q?wz3ipLRTMcCRbFhDElFmn1Sz3cHvVNVQH8uBKmDQdU8SuozZSRtykmVAUrRT?=
 =?us-ascii?Q?qzoiFDeGtCq9UVHeauilBcN2OQCzP0FqIkA45v7lsJw0/0Rby1mi4UdHUWPu?=
 =?us-ascii?Q?eAiDEs8rXcTIS7rLfsT9ShcVTEB4tIXpvZK0UlRBTll/tVRy2Ex3Ikb63YC4?=
 =?us-ascii?Q?ISpcaiak9Q/w9z7dSsezrXOQClHwnR8eWymzJJW7Ba8dOawsaX5GglS2xpwb?=
 =?us-ascii?Q?/WAgr2cmn9oycAJkL2FiGSL/QkVvMOck0L1BaUh5OrDs+AXtUYia6XFFBMTz?=
 =?us-ascii?Q?JlaK7KjbPQaosl+R5kxD6dOVohArY4so717v+7X0C2zqmdxADUPYDCX6D/35?=
 =?us-ascii?Q?0Nyfpbi6AwU2laDw7Ec3pJ/n5ObTz39LLPnX7UF/ECKu8HygOjxKeY3Y/Bbc?=
 =?us-ascii?Q?mNYAGIhxpXBbmwhKDC50PI9ropjFVqrvMIU9ku+qd5cWANAgCApr77TzbHVr?=
 =?us-ascii?Q?74wU3k7oiAJhZFcOUWw7u0AJA0mk5+vsda8zqUtrDhTVJeQ/8/5z2mm+paQW?=
 =?us-ascii?Q?C1svZs+JAN2zTvJGs0RjW2cJ1pQJnSDK5/XBCIQ8rjEUdsyv3X3LqTGX5K8b?=
 =?us-ascii?Q?aTtJK9g/iK+7uOqhpV4Rsxr/PddPvvUDRem4OlGZ5NzEgpHmWCbLjXE+6Trm?=
 =?us-ascii?Q?d8B4yTfhbC6YRcNstw7TXfSBCJwWWfbv4emSXvW0/ZWFj7JMCeMbNapwM40i?=
 =?us-ascii?Q?MKX/d5CFX5m9CYj7h8OzdKYxEYiMN2UbyAmajBoToY+wS7jKddAmmk0mmEMw?=
 =?us-ascii?Q?hCIOsulhEIAWhuM6KgDrTL6h/XTb5e5gYrpu7bcukNLaLw3TaJG302ygAfjw?=
 =?us-ascii?Q?U/OcNgcWOQAnIAQjKPRKmC2fMmwHe0GXGHI9RGE834cJBJ9Jbe5DOk/CPNoD?=
 =?us-ascii?Q?F6RahE4wOXDuGF4FpDngclZPmZeDqzkvHR7TBU6DZDIx2RXK3ZHT2MBboct9?=
 =?us-ascii?Q?uiJgRGBktcQ96O0gIlmQcsAMkTJinqvpBz4vNcxUizC/H6yCplY+hC57izAd?=
 =?us-ascii?Q?/qzAIP4dDUp2zTpqCh+W2nPwP0TMLQ7z+0BVQhD7ErQUGG6JT9WTPlAOiXuY?=
 =?us-ascii?Q?1wOxBN80jeqU53UWRqV6JmkIyIkDptDn1qXPuig075EG7Ar/qomMSm/V5/AC?=
 =?us-ascii?Q?6DboUWo2HNawBWE7YEn/ZSrLUfEPOuJPktJ6eXo53kzac4sVLTfKUMNEQhDn?=
 =?us-ascii?Q?Sok2PJUnM4ol65nad79Wgdk3hby3ubNLi21zCsmNwU0jZfkyZgObFFt76OyS?=
 =?us-ascii?Q?mh7pA1YYv/eEyI7D/Mmqee7ymSlTJv7S9wXBcGtZ614PigObZfRlr4eY+aml?=
 =?us-ascii?Q?NPoNj+tU9wUZj0nrdny8ciGfoqh5iostL5vOicoP1/Eyr6geszYRzyKC/xJX?=
 =?us-ascii?Q?eYcOp75tZ+erFuOQylKQ9YwPflt5RQZLTjb/BNP4i49LEOwwhBEJpDYzhqnE?=
 =?us-ascii?Q?atZqNX0VrCSIvCXWt3Vl+LYdJbUyPblP4Tce0Biwcx+ILS/oObd0oBWMAR6o?=
 =?us-ascii?Q?WqDq6x5Xn/qc6jO3HI3H9og9YnSpqPgCT1Wkd0YehnDQOiW85NMmxux9+rbH?=
 =?us-ascii?Q?89TB170SRpcpqZqmsu+3W9b/+ajD69r2NieJFMEt6Xq1TDZLBUNtFUHktW5W?=
 =?us-ascii?Q?UK1NL4fhhR092YIxbQS8mXZi/Cc1qSEy7ecij/3FM57FzMOX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afea0e3f-ae71-4e91-6709-08df2f41b96f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:05:44.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad/VgH4GreyYqFmPeNGG9wki8vWxk2dhUk/7aymmzYm/JrkSk6bYc4tTbCZl4/j5wOydSJXF/ulBhRm5Ws9iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

With proxy execution, __schedule() can call set_next_task_scx() with
SNT_REPICK and then SNT_PICK for the same donor. Both calls queue the
kick_sync balance callback while kick_sync_pending remains set.

When the callback is the only list entry, its next pointer is NULL, so
the existing duplicate check misses it. Queueing it again links it to
itself and causes the wait to run twice.

Also check whether the callback is already the head of the list to
reject the second insertion.

This covers the kick_sync callback because nothing else is queued
between SNT_REPICK and SNT_PICK. Requeueing the tail of a longer list
remains possible and is outside the scope of this fix.

Fixes: e2859566ffbc ("sched_ext: Queue the kick_sync wait from set_next_task_scx()")
Reported-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
Resending including Peter, this touches kernel/sched/sched.h.

Original post:
https://lore.kernel.org/r/20261020084400.845842-2-arighi@nvidia.com

The triggering commit e2859566ffbc is only available in sched_ext/for-7.4-fixes,
so this fix is intended for the 7.4 cycle:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.4-fixes

 kernel/sched/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 499a5649582e7..2584d1a7f6d21 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2158,7 +2158,8 @@ queue_balance_callback(struct rq *rq,
 	 * balance_push() is active, see the comment with
 	 * balance_push_callback.
 	 */
-	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
+	if (unlikely(head->next || rq->balance_callback == head ||
+		     rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = func;
-- 
2.56.0

