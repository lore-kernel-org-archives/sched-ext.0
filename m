Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691845;
	b=3im64tX2n+UmIPYgu62qYGTTvinIDoIOrAe8quPwJXg4IcS2ed2Pzkgr9uZgup6ouQil
	 QysEsu5yK4BtqVGhIa7sQcwFVkzd6ByOoGHFs4prb3y8qpEtxGTQKR4gPXqbQHBiVb7ZS
	 apJQBGdLu32h1/r3azdUUkiCJa7M4y9EAC+WhRzOqjVfQNwipLicJSelHGOQTj2Uj3L/+
	 fXeS8QURV7kwfi+SqWv8OWuYpx2rKcPlbXIPW/xDdF4q4qw4I28leOGoY3cKD9FWv7jT8
	 gw69VwT/z7H/98f9/0/dbhh4hIit5D9R34aJ14cN7w5HGdNsn8ZTjQsH+HWBRRkUIOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691845;
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
	bh=mGhzzx2JBiSXZmN5NsNNhJrvMUg/IkgLVCZMKuQMxJ8=;
	b=xTZglSkX7ytGh9SZ71v64t5anwR3rixzIwDyuTBLo09HiEJCtPUfvAatmkEFrLgzV8nf
	 xM6GCIsYO1ZL0Jz8eRKvwGp5plXTzrv1oMVvcUuiH+QTbWktdR+CDP7tDoRASzP4sY3OZ
	 h49jKHr6WzreH9Jm+w6GuNPD6NQlDKvnxWV7bmlB/wTAdnMMvx/U/IJo0chQranbgaPuE
	 XEda2aeoqzlIXcDmEW8fFWOIMoXpr0jiusT9gZ154ThY+ZlRuT/Fj/uUuupMWLMUgAg0P
	 lV2R7w9fZyFfT5m+qQw5vRV3Y/pvGFNeLjJIZG3SrFXXC6BfPScPA9Y1TSVHyYA5uew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dgQ0mlnD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.56
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF45606A329
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 11:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF45606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dgQ0mlnD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOE0nZexfLz+ZrLeiaUc4x6emD4qLz5ElOyj8ZFIhF9QrwHwtBria8bokf1Zc1iUqIeh9Es4JIJU7t7eyLPJGaplfdOy3uS6NCISo2i4XmKySGV/ie9x7SOz4/9afIThlqCQt/mgIkmB7uT2Fj0IP3SM/XsNLZAeA0XsgXV5vbfTb8zGA+33yhsFdPz7v119cGPTGfvoba/HK+d8KgLne7r5HxThv0CHF2zG+9JVouHAG/OleBUzsAgUFdTmjGTHHvw2it24nN8tovt4FKzoSDWxxgyntzVZer4iR3GNuIkGuVZLUO0Y6XMX46mKXz82ZuD4+tj89F0MVOjtglMbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGhzzx2JBiSXZmN5NsNNhJrvMUg/IkgLVCZMKuQMxJ8=;
 b=GaZuyCz2rJsdwjlmULyyl1VbpzSqGeEOwnazjDO4yqRhIJ1OK1SxMCQDltrWhvuoPP0aZBwKXSYjb8k6CGvsErj6YMZboyJm7OnIdczEst4+6cqoLbOhwjWdeVyHkaogVdHdzbu75Lv1gaZtAq3bcOHGNUqFz9Y97z/+NiIIuVTTTsj1BqGc19hMaAi+Z/V2YaQA+pgJW1/x/6pSfOMhHIePnIDj8CTyFWr5HX7iyY4d+jJwd4h/wUdOWh7UreeKbU4ItmoOIy4FjwuOMXW8XqRtYK0ecBrlfWUab1Q01OA9Pbg00SXDXEr1FFraJk2MKmnEqeRAFxhLcEygJP3fBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGhzzx2JBiSXZmN5NsNNhJrvMUg/IkgLVCZMKuQMxJ8=;
 b=dgQ0mlnD/s6zZ0jgO9rUho946v68vjvhz92x2bIgPXa9G1bxv+egkTHBKU1vPoM39b0OOakgQHtuwWLElo3CzqeES5d/Nv4qiOU5pwSAqiPSyXc5rB5vGR9MAYMe3Dm7Qxwgoq0PVhO/7ET4O6KKklav77NeRiVmI1VwNHroNR7j9hI335uk/DcbOjsP3uJqiVLvznxqh58IOtPnbOrPQvaWIctqWZ/fPv8Lv3eO/nRqr202R/np9pX948BOXq9Pt/qnQNY/ORyaQJiAB+pA7KSDaj+PBWqLau4FI+/5HmkVoTUwz2HtWiaWIJzlvDwO8APgZ1mP6gaJn5PT4v0jBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 11:17:20 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:17:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched: Remove sched_proxy_block_task()
Date: Thu, 26 Nov 2026 12:13:59 +0100
Message-ID: <20261126111649.208476-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126111649.208476-1-arighi@nvidia.com>
References: <20261126111649.208476-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 810c9997-6d89-4bfa-1ef5-08df4baed620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|261022105027099003|11063799006|261026140227099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ovJihJjFjph0XoGt37BvyGP359+pPfhRWecPvOvjLpjo30CBQm06WCapjHCCj6mkDWIUotIepy7XT9AsyTRB8DyJigWhRk6/SxPH3onXYT4tpIKNEYRwQh11pbwck9IvKbfLDnBwoeFaW8CWNP1gmnuZBmzN8xpx4ndMCDkFCaift+XaCo7xhHtaP0D94ixOyzZihypz3sheLabB7HCAeRbs7+9437DidmGuzsDyT/cEvi6PdghFem6Fdk1cWODj8NvCK7MQiU0GTYa0+LGtbquziqAcYXo63Nymp8C0Amn/5TxixnkzjPC9ZTzyKdmyDVzpl6O3SOKFTQBken68OC9eukbRCjnYWZSd/9d5MX8NckMOn4XMcwEmnQHcuBsAhKpMBg/Vu21RCKTTKjTgpswufZGZcJnHbpCr2hTLO0RensqVCO0b/8P3ThQutIZ6QpRJfueG6qWwz+7s3gIxUSuxGuZ1G2cdArXiCWv+H0SqT7Px6463v/jeOJ5e+UY2Ad/kawItHDkWK4iasRff32/iJkBbpeSM9hwN60n66vDjTF5hrq9lGrO6bvAsuEfBTMI3KN2m49DMGVGdr2ND+fAFh0JXpijPWfop4AQem+VfNsAwdyAh3gKqahNGq96mIub2fJlKMWGFh2unk3TscZN36M+4DqL4b24oowdNu58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOfS3HwVohTX0bR0lVFWeblAOMKe7WbFE8cRRaxFv7czXI1qvxy7gxmfUyxW?=
 =?us-ascii?Q?bp/4d1TbIA0o6XFMV+q/Ix7r4y172EopT7JHE058ZDkHTXxUpvuER8VgcDcB?=
 =?us-ascii?Q?75/gQpKb94JmOITwV4ctUAHYnltyLBfaYg2VDVeI6l2vrMj7G9P3EUgABMaO?=
 =?us-ascii?Q?qVU2esgnc8eivx2HZPIglu/2nvxXSuQRcELDB8PeWfBR4JDa8gPnoXr7RHG8?=
 =?us-ascii?Q?BiYpGgxfoF/Xaoz+IzOXxq8Aghdgv6ftxoRthpPOV26g9UGWRe38kIipGKKH?=
 =?us-ascii?Q?BJ5QVAMH75FZRn47q/QZZ5Y9sbvaj3wLxKVrgnF2DsGEyTf46yzSv9euAtkY?=
 =?us-ascii?Q?aMQy2p+lnUjZe/GVau1zRGa0MvH51B+cSehHveJhoDJneldlEBiSvlLeiihM?=
 =?us-ascii?Q?ZI7zjZnArsF+7LV/+9/ICxt40yCqSprtDWbdjOfz/U/PQMhza03/j31dLAlx?=
 =?us-ascii?Q?kfMk34/ToDgUAXZaWtdDDUsK6jW9Upl+vDzLmuO0WDUuMgLv/oGJFiBMHgPz?=
 =?us-ascii?Q?FajROtUhOwfC0s8lg7zuzlqECYcxsilfKM0JaDSakPUNQ3vtOlOzRsflXiSy?=
 =?us-ascii?Q?M3xPDs6w5BH+wvKhBiFgfwQCP/iKIsVljj6mmSDF8oqUcf4yh+wMLsNT8dv2?=
 =?us-ascii?Q?XdjL96UnnmcKC2bZpLfbRm1nX0JSm4WR2rB9AoH6wi0uoV22mfKLYSx480eU?=
 =?us-ascii?Q?JPwo/PVKVeL6t0JOEc4zJ5WcTh5d+KVCxqtHui+lz+Zg62DPN0QeMWf65clk?=
 =?us-ascii?Q?j/gS0CZ6ldVOVcPANrfZVIwUK8tGg/ud1C82uJ4UOA95gjqmL/TlY29VYLPk?=
 =?us-ascii?Q?zAJ22gLnr1wkZHOjrAg36XtQFO18V8Uw4UWDD8OhNhl/JuocS/BMc4ZDoRAW?=
 =?us-ascii?Q?s0Xd+o2I/fb4WZPJFVIrLyMjVGRI34+vABs1YfMpFLZIp1e7zzH2eUEhVgKx?=
 =?us-ascii?Q?IjoFA9rVkxuRYdISLIpszq8OVmmEM3yIysRi8t30fNEPlrQLp44RXtpl8sG/?=
 =?us-ascii?Q?07YuXb80Y8xjWCPRRwyWd21QxJCl9fU25UlyEtDKplwZLFx0uSiUO4pK3RsP?=
 =?us-ascii?Q?BaHG/ja/ryNgS/X6pphp7OUNYhQf537gIq9LTmcbEIeRVuOX8ujqA8/ucZ1G?=
 =?us-ascii?Q?QulzRIGnWO6/iohiKdXq1R+fOKz4RUH1YRQCUiupwlIl27ivbd14VOzpn+62?=
 =?us-ascii?Q?1T+y/RkcmY3RjVClzOw4VmZPJiBznNeV5MxFlhFRxX5/9Ack1P2JVPCvxWjg?=
 =?us-ascii?Q?bJIOn0oAs1llxzodG7/YFKo5K1i3k/6M5bXq3fKTGCuuwQHKln3+4LwTLiJa?=
 =?us-ascii?Q?YoFnRrMAaph2xVFL+kNjrqnX3j9hQPcMrrtBtfPHhTzpVwyDUwh/nytTiOe7?=
 =?us-ascii?Q?klvmX+Gu3vzNJzG4hMVCicsGSKoFew/cTVRswIY/sXOGkx0duvGbsSwf+/Mq?=
 =?us-ascii?Q?PS9GQU0ieqShv+qvdDVmQ30GrH48uckhiaIFVI8Fpj40GGHgPVcuGGP6rRf0?=
 =?us-ascii?Q?NBjuO/SXdipLziDUkYvjYEx45jIgEXfi9hqHA9TFlH6rolonPvPXqE/vCOn8?=
 =?us-ascii?Q?sm0Xi8zfDMjaVyfomiRVU+Cn/M/OoymXJW1n4hY8hkM5IcqJOLBSJud8j9gU?=
 =?us-ascii?Q?Gl5CA/o9NQDaZ4dS4jIblwzhNp7QnHcMgfrfQ9wNUqMYWhJ9fEzXeVZWFQUT?=
 =?us-ascii?Q?0iToBLkyvcXMOkXzRdOEhodEK/jp4e6CD6Xi4T3QQVcg24jl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c9997-6d89-4bfa-1ef5-08df4baed620
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:17:19.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5zMe+34I/dL2HKtQLqUHfuk6fMgp25MM7HWKTZM8ndmRgRRalrRnmaHjPY1RMTbRb/KW7UVMWPyZ3W2pES8Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

sched_ext was the only user, and it now relies on switching_to()
refusing retained donors instead.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 28 ----------------------------
 kernel/sched/sched.h |  6 ------
 2 files changed, 34 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1b4ec78738861..4e05f6458a118 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6855,34 +6855,6 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
-/*
- * Remove a retained proxy donor before changing its scheduler ownership.
- * The caller holds p->pi_lock, so p cannot wake and migrate if block_task()
- * drops it from the runqueue. If DELAY_DEQUEUE keeps a blocked fair task
- * queued, switching_from_fair() completes the dequeue in the immediately
- * following sched_change_begin().
- */
-void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
-{
-	unsigned long state = READ_ONCE(p->__state);
-
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(rq);
-
-	if (!p->is_blocked || !task_on_rq_queued(p))
-		return;
-	if (WARN_ON_ONCE(state == TASK_RUNNING))
-		return;
-
-	if (task_current_donor(rq, p))
-		proxy_reset_donor(rq);
-
-	if (!p->se.sched_delayed)
-		block_task(rq, p, state);
-
-	WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed);
-}
-
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b34709723d861..36e0e28a34acd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2534,12 +2534,6 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
-#ifdef CONFIG_SCHED_PROXY_EXEC
-void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
-#else
-static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
-#endif
-
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
-- 
2.56.1

