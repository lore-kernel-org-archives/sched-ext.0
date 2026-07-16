Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5F43F0B4
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208174; cv=fail; b=Q709qUUJdD7sLLGEAsQdkSCF+vmmXCeYZNGYoHBd3aJHNofE1c/jA6Iq5qoxk5ka5oWRVSbp8aGyY5kvjIEpAgr2aXs8p47MZysIHSSLaPDPAw/8HRXKtVOcYM9AosWtdkpclgZyiigWxW3yVZV2MqsOxkT9VRDmX+ULMqLGrg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208174; c=relaxed/simple;
	bh=w92jgfyqNp0AkE2vpYqYYSYjF3iM8zJdMoPi3H0NTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l88tKoZdpDf3qTtgPrsQZpgSPSlzPv9aHJP4Ru9Alro8LDAjUK5HBxmzseZJYe8YN6LrHTQasR45uyCINFQK5izAzuaredHVNk/4GXehDnHgG+CM+ctaU6GloQfE7GW+zLYtQCY7yiSbfH6fQ7aLLhdHXq7CNwE6gm0fEedJdHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYaaQOle; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYaaQOle"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+3Ut1FuxR+TTy5bkYnjGKA+H/zaWGxkmmfLPViAIUkMFc9SG6+PqD0AGbQTKw8/ZcTDLp9O7PxBzFYTa1Cii+DW9xJsOCSmP7BUaC/ibWk+8qnHSMKMCqjwG6dkp2FuZQzjDBzHejwGoz0HVUkmR10yGADg08ZcTrICzfYPcYZdQ/3EwjsFn985D923XDRMIlDEIZOUa3dVeUgPbLoYEESYYLasO4x5RvKg7E8c+QRLTBMa0HKsyGqvFuxTa8GI537F2Y5aD9eMCsc1pljsT1ZGzZbzeIS1gSrZyUxi47GVf2KBI6HbkBBFDL7BlViOHNqkSzgIuXUo8nLaB63E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8LW9yWhVyKP5fKsVIkdQDPcYokUSeUUZXbdqv+MWSM=;
 b=c8bEqloVnOhMf+924ORGstza47jpBpqx+sxojxrG3KBNYZ1GyGZNA29WC6CCeHV+lNgNK1/+I5AcGRgBXOqrj7SvbVKENx/2pckw//8CjP4OHlTc2mgwUi6i3ARSk+lmypAUEa4Qu/TlLWlB6XG45EWWGNkDYmGoGGjyE9E5+LZUTMrezNvI332ukg1NIvtnC/pfC1lylVa9gdqsqgOKjm+T1lNcZ6luI+dtYUb0cNj08Z5fwBlDRRmiEKfQegdrwc9lOOdDNipPNq3zekoRO6Ws6rRp67Etmvrd9UlpK9WG3hZdrBhQcS1cr6SaHiggPgnH8OpR2dW7S2PDI/cnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8LW9yWhVyKP5fKsVIkdQDPcYokUSeUUZXbdqv+MWSM=;
 b=uYaaQOleRWfcQrpQzAr56dcByPxBVdv1nAEC5vLYAMMbyrE213GNns+3BYycDXb8eFdWEHslrwfgIEy5a6mPfgZHol1scXqYjucWvfx5rJKEGXVg3Wz0p6R4oydk/jEM3fq6GnYOum+EMiHcT00hYpv8Ke60FZhhzHgdDurecNZniv/W0vHw/hNM2st1pSq5MIK4E6X5faL2QvwLcuRi9HEIp8lEI3vHCiIhSvBTREWv4nk61hGhjhXNKlKN/eliSLgcnS6KJnf/QgnLLutFVaRpcVR/Gto087w7c0htHsXR0Xm1kHd/SLZ/BCzvKeIPmY2pT3GdVM2ATka4MatilA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:22:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:22:49 +0000
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
Subject: [PATCH 01/11] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Thu, 16 Jul 2026 15:20:36 +0200
Message-ID: <20260716132229.61603-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da6e53e-4509-406d-6477-08dee33d54ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|3023799007|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CM60iYyO+RA7PDDpUyTP4r5fUfh4Rj+NNbd3bTzMARLSdDGN1RfOY5IC2X6d/cTjwvq3j+hNfUGFOUiF9shaa4x0NM0bCTmKRpB8/zETkmBHOq6PtFBya3/FBTxXZ1t95gFNja0IojL4UbRwN9N/1SXKDf5nUKDQMpFpNpQCTaLn+k49C3k1q26wHAbE1Url9ziqJK7NgFBsmubAkg0b6pi9VyQ/Fb7V/v0/xEwjH1XkOfeyegPzYBixFyjU+p8BHfX1GzrUHO8ayC+SLmDsbhobmW0sGVmj3WCt4hiIazaG824/EWM9myn3iUwExuMJ9F9TrS5KsREp7/9jX9PoEMSX3VLlTxFfYNq2YYjsVr83Jt1uVr6MELPfDT4YN6c/JSi0FCVkCnv6YkDxyQclIl77BuYLjEj5ucPOqMPJoCH9TO6S7+y7ehVaDakc809viM9oQVuI1vZ23WviepzBG4Lajb6YWtDnlhuMT0+YwBe6cfBvFegSpjzhrnWXhV8rtZNrVL5r3N4c4sL/CXBxiyyFnka+j5utRXUsPoQX4LkB3QhDxPI11uNCNh7zmb+6n4TH1DuwA8+i89HNS3jPttXhfUG/hIclsjYrmpBtEHHJnBhJzz1I7ZmWH9o7HkWYknnOe5+kcS7uTBxC/2ygZKj4Rymh1hJ3n+6ehzkwYIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(3023799007)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpX5ymKfouA2sjB8XDJq/tAsDimXMuxrM5+JmEeHZDu/LHcCINMeXjl6z1x7?=
 =?us-ascii?Q?XngdyfgvKiSlFStcl4FWPby/OPqTef/hc6IsmKeRX+hESdwiwOQbdOsdGuxR?=
 =?us-ascii?Q?6BfjQN1bd7Z7r9rl957jNwtR9opXADkOYQAzB5LElXP7moZlEZGIsXdw6ZIS?=
 =?us-ascii?Q?6cQ/DnU0650mSuEXviRtFy0K/pQCN6OEuUbSABE57SUWYuq1PJaO7i+Tqo3G?=
 =?us-ascii?Q?1WtguAsxc0K/mW7q8KQWNDg/L56nPxB9ztP4wKB/xiOx7VwTtFL593PFAhg7?=
 =?us-ascii?Q?J4QJMtHhsc798OX76Y4nOe+OqABV7OCHcG1VQfSb/T9BF4ePdHDFOyQ1Tpri?=
 =?us-ascii?Q?zY49DBOdwkXbzE54hEcw/zUlObg0+MrdjzvQnQd3EccXLSQJXVHQYRKs6K2d?=
 =?us-ascii?Q?tZLCLkNZb7FNMGarkAqtlSoThd6pxSAm233LW27kskIfO6jUgf/jIQf5K1cq?=
 =?us-ascii?Q?+D3nb7UWv55DFfz3j1r9W02Wlv97oiKlicB0O8O2jwPNTkILbV15ijUFnctP?=
 =?us-ascii?Q?trvT2pKQe67kVsclz8v6BfwFDvq6hwXRzfTgsfgI5MNtcm8NtWHMTb4N1aD1?=
 =?us-ascii?Q?0rRCtokwncKWrw/VxXHBVzxSAmJpKFfno2mH+QQrJ7GBlpIGGp4fSg+FiiO0?=
 =?us-ascii?Q?opX7X4Kc7BTyDBWjwnBcvLXc8/qAHAyfSaqfo6UeA3hOB/NHdmks8L8y/eIb?=
 =?us-ascii?Q?tqwj1Y9hLD3ugqXtVH2O7qPY7frnhQ+ch0zDIP427JRIeMEoyFZS2Kwp+9EI?=
 =?us-ascii?Q?iWyv+JT7cakjVCN/5kCUG0Rat3/Xv2nxUQajbCmTaKXR0MrfwLCAoJZmjRW2?=
 =?us-ascii?Q?pTsxZRKiAbBtmTTJphJg5lWIxoDm3qKbSLPU1f7c/EpMd7Wz9fguGptyQRUZ?=
 =?us-ascii?Q?GFfJsWWCdr4IkzWUPLtTSDO1erkSQBGcgOILZknjxCGNatw5w/8Uu/bvDLU2?=
 =?us-ascii?Q?fYv5EseGUyRyu+bpqPOUCQtqfkzmGReQsLF03x3JvrQJioDubnDVW/82tXpz?=
 =?us-ascii?Q?hrtyQVueosOW6hoK4f3ez6uGJNI7hD9tKbG9+40/5N/JG1acA/SCWBYAlb69?=
 =?us-ascii?Q?u6h1xSvCgbP1QGt7kYiFujR8Dhf4hfTVlCRViLu0d5dYw8PqWTCOx7X2KItN?=
 =?us-ascii?Q?b+jXmw9hLRydzlM4j0gjg+5MNMNUQFmbmnHVKWuqehD+0vSw13++iuNr0oak?=
 =?us-ascii?Q?qXUrKacapMK297X7HgMxUbrba6rW26GKNo9A51pY2lJTIe1ZtHeJndASIvwu?=
 =?us-ascii?Q?HWBTFGVfTCoXn8YAEdkyv6BC8XDOdco5ZbpfPr4WzgSVl7gTMP0z/9lbHSLY?=
 =?us-ascii?Q?tFyAHG7HrFwcVzEVt7ffzpsY7XxqIPxNne8ZK9N2bYxrJrWVvR1mF6N6kTeI?=
 =?us-ascii?Q?vJuaNkagosWXHlAkIwOWsK6vu4vs8CwksInGQE9L/Fdu+2tTiXTMXtetU9ao?=
 =?us-ascii?Q?SJ+v0/Qz3Oe0wr6UUbLXEbpABOmpX+oT+l1HFKUSQmR+USnCPQineKZMZL5d?=
 =?us-ascii?Q?T5tVLy5jNSwLymk0QzYhga1Jq9snRWjatgsPkdHxW9eMLZ+al72JdVB3D0lf?=
 =?us-ascii?Q?OJiP4YMxOvutBjjLbnukGq1lOu7uoMzMLfKUJ/TypowLrIdy3SDXhiwdiq2b?=
 =?us-ascii?Q?NxCi0oIPykNsXdcHlPuEUE3r+ssaFdgQxfIqgs4pIJFJKz+wh663QYYXRL+U?=
 =?us-ascii?Q?yf0kwPuT4IHc4TIvMPvDueBfamh+u1vbkkedQp6D7CoXq5fwBuIuJUXN38vn?=
 =?us-ascii?Q?24LV1sgHhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da6e53e-4509-406d-6477-08dee33d54ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:22:49.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVsNMJS4Kzuk3fs5jcFW1TH1YpV13ntu6keNBQbTZFLGpCVC73/4msWqPzE31YQUcVsbOHJNcVfjNxWpeiqZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

Proxy execution separates the scheduling context in rq->donor from the
physical execution context in rq->curr. sched_can_stop_tick() checks the
latter for CFS bandwidth constraints and only does so when nr_running is
one.

A retained proxy donor keeps both the donor and mutex owner queued. The
check therefore misses a constrained FAIR donor and may stop the tick
while its runtime still needs to be enforced.

Check the selected donor instead and remove the nr_running restriction.
The donor being a queued FAIR task is sufficient to require bandwidth
accounting regardless of other runnable tasks.

Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..f47bcfb25033a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1409,11 +1409,8 @@ static void nohz_csd_func(void *info)
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
-static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
+static inline bool __need_bw_check(struct task_struct *p)
 {
-	if (rq->nr_running != 1)
-		return false;
-
 	if (p->sched_class != &fair_sched_class)
 		return false;
 
@@ -1462,14 +1459,17 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there is one task and it has CFS runtime bandwidth constraints
-	 * and it's on the cpu now we don't want to stop the tick.
+	 * If the selected scheduling context has CFS runtime bandwidth
+	 * constraints, don't stop the tick. With proxy execution, rq->donor is
+	 * the selected scheduling context while rq->curr is the task physically
+	 * executing on its behalf.
+	 *
 	 * This check prevents clearing the bit if a newly enqueued task here is
-	 * dequeued by migrating while the constrained task continues to run.
+	 * dequeued by migrating while the constrained donor continues to run.
 	 * E.g. going from 2->1 without going through pick_next_task().
 	 */
-	if (__need_bw_check(rq, rq->curr)) {
-		if (cfs_task_bw_constrained(rq->curr))
+	if (__need_bw_check(rq->donor)) {
+		if (cfs_task_bw_constrained(rq->donor))
 			return false;
 	}
 
-- 
2.55.0

