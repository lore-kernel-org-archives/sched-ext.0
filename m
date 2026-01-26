Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95031354C
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416999; cv=fail; b=uJFeOjusrRFjCAdIYFxcR/Jb3py9h2nWHJlE0S5td6wTUhZA6qog6S/mV3O6f/Nb9E6/GVnkRu2eiP2E5x3eHoZIvQtvqNaxI/vmYsIhmny0i0dSXIveedK1uCfj6l3tSJNdndqZ4WCKjcSqgWU4rJI6mi2DQ78RRMwl/KuCdy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416999; c=relaxed/simple;
	bh=qVMPDCTccK/kOnSv0ztL8Ka2eLyWnMtubghasWhpNDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5uYqnKvd9USWZGJ2gD8WRcbFbaKIaWmVoa8SwtEGRrXHqw3RBEecoHatllQO9fWNJttN3WUD+S/SB9mDANuGiX2DzEgq45T5StYMJystVomsKsK5qIDZWzmcwoTg7XJN4wSCpDsoBpiNpIP4SOV9OdxjPvTlzTGQ8QL6gVlsR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBBzYqp3; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBBzYqp3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBea7nIo/Qmsu33H5KnwMNMfnmjjHPSLBP6zFiz2Ady/j28s5SgympEibDKQEgIRG4NY7wSTSrwqa0PVteVDS66voFEvNWxv8OTzoYVPiwMd6rqEtB93RVqzH4qkNaLrYIy78aH7umf1q99KjNHyoonLYcSsopbpERTkGAhf10RiT2VyxFgNMyPQ7Ai56u5XugvugfI51t7wjYpPco1hZ/BLWJrDm+BMmmsBkRHT8jPeI9tpcWaI+TguldV7AVds+0iXMQQVBtc8VAH38x+0xV+oM+6Q3BioCd6NyZNcrvcMN/PSPvExLUdbcWOOjwxB+UAvNVJTDphLHdRAiM0MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vArXSC5xiNfiXt+u8sruudYvGTOegwG9D7PX4UWCeUk=;
 b=AiQn3xEW9m8YAd0PhRKQBN3kO5HpKh0spAL9/83fkTV02hbv2KjF6xzcreAZPFkwb6v+y6K2Bje41r33Tlsha/bjJxC+cvF3nWgCxBE3we7uOtSPLE8AJno+yULaA0uLF6W5F49TCGr4Qf7GPxBueF1XmMgq3yDNJUEG5WctzymEXIwWZTfV3TUW/xHVwdf0pSA1mtMgowaxDRFb9WZuiwpIv0pfT8Ur9Q9y/GYlKnVb5QtqNR8qv3nquZ07Z3z5TwHGVR17T+GI2CUo3AxqdNBvbJ8CwQQMLHKWGUJZ74IDahXaIqobAWNL8IBy4o+nZCUdTOl7OEs94F132HFV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vArXSC5xiNfiXt+u8sruudYvGTOegwG9D7PX4UWCeUk=;
 b=tBBzYqp31REzMsIEVGp+SNlGa1SzGf9oyQ/Y0P4gQhgx30Y2s59oNp1tl4NRKUGDrIioNhA/bOx9NnmcyqVboJr6biGnVg7eznBhY5khEFqaUcyw4pdvpBBdChV19t8g18FPrPTv0D2WrADc9xpv7GKCuS+Kj/Qq0RUVAphFA7c9b3OlS6xLD/wU+BRAnDwpfxip+uUxwzfOBi8zHr5zLOPJpY7Va1lbFbuCoYnIW7fFbqUw8VqADTsCmG3ONYEi7lXm0kmDkaNihYRG7HqKtjDTcegFJGRzyq1Z/jvaQzVkiy5wCi/stXFgEkzlrQkBFIV1IWKUBTucmwDuKaX/7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 08:43:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:43:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Date: Mon, 26 Jan 2026 09:41:49 +0100
Message-ID: <20260126084258.3798129-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126084258.3798129-1-arighi@nvidia.com>
References: <20260126084258.3798129-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de52a53-3846-44b8-5eb9-08de5cb6f04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcwsZuK2TYR5Stzym8McPN9WczdSAA9L4d9GPp6RqmNwoRFL1aPBLxrySSYX?=
 =?us-ascii?Q?F/xfir0mretDAp6JxpfLBswWqpZKGLEqkxt1C6lbBTmyVrHstlUlJ06J9VQR?=
 =?us-ascii?Q?SD2hgIpb8OXU5Lmq30ltnePsJO7kqQS0QHYpMPUEe+fB4lWLYNo4Z06bDBcB?=
 =?us-ascii?Q?F1HRVmTsBd/ISOR+fN1wMTLLz9pyDyawjR/Sr3gP0LHBh/qKzT1hh/GJuyRi?=
 =?us-ascii?Q?WaF7QVcLxJy7RIngZHHQEf1nbkyPS1emzDGY86B7woHQENzTf9nykcX9ymEL?=
 =?us-ascii?Q?aFwL/mWmcfSmfvs6Vh+jTEU3ZqmE/ysq21/GlACYKO0Pzoi8iif349+mFYXj?=
 =?us-ascii?Q?kMc0nGzToBQz9iFJ0TZdFY15Ir2DHBHZOVQiSKYjbeOzgoTaPIK0pUEVYqFM?=
 =?us-ascii?Q?Wzik++v9YrEYc1sG85bkXKHNPR2Vstm2g1s4UwcOJAOkJf5pUPKUySnOxgj2?=
 =?us-ascii?Q?4wmqxS0P8ebsUODF2nTgdttHZ7+EXWJdR2xOb6bVyomQjo43WqFfylGfFu1H?=
 =?us-ascii?Q?bNyGZzfZ3UE+rfkqaGhPGC2rBbL4T2kNFxFeQelQ9I9o1wobiSrEG7CuhmNv?=
 =?us-ascii?Q?RHOelukbcZirkgdl0nwfo1GPK9UeTSWfi0HYCP11JVzKHF3x3KckfOKBYDP9?=
 =?us-ascii?Q?4oWr/Mcu7+Z8gU+BzQzXPsGZ49EBCvdwVGATji++6WJ33hRIIKhMOGTR38C/?=
 =?us-ascii?Q?1Q4H+8LM5w5XD7zi3qJPtGdclAcUizxMi2gcZPl6Vjfc/lqBbUgWrnrXlQDw?=
 =?us-ascii?Q?h8Wl0m/osUVeKbWVPIGlv9Zu2PqUvAwVt6DxicDJR7zKca9AkA9SmtGLJc4P?=
 =?us-ascii?Q?/dKEW+2HyDk565LxM4DKWPk9IgfExNLQwAZOagryaiUf3sAjoObKfbwieAAq?=
 =?us-ascii?Q?KpdeXOMfqcZXH74sC6D9OQTAFYtGz8Ip+oNS8kY9BqWByQGqfKVzshqaPnpd?=
 =?us-ascii?Q?kYKdZ+AJE7K5+BhWqvDk1q933YCCw7ExqMNR2q4lMb0S0yLOomjexFw0HuWm?=
 =?us-ascii?Q?JAlpcOKbCaj0eYVEwvNpTmSOFg9NmVM5NmJFuQ3xGYI3y6HqpmUVncbjlL4E?=
 =?us-ascii?Q?kuRZu7LCgmz00Imn9y7ualDtKH2Qa3vxS/fGo5OomaWy3h+eiVTUmWvssLu4?=
 =?us-ascii?Q?CxSVb05SlfUWDZR6wPHdVUu/XP8ZizTx7mIQP1nWgsdsPPQp3k3KO+scvymD?=
 =?us-ascii?Q?AQ+YN4Cye8yToQF5dUVJy1ZIPjMdwlzckvIHxb1WVE8Kby+NWwdXifABHBMC?=
 =?us-ascii?Q?4UE83Vu0Dwr54MuVOqfk9eFzAqpu49zaRf481T2nGSFvGn2pz/Thr/LUYMfZ?=
 =?us-ascii?Q?MD7o98ynIfYrJDG2fiHTfMsJwv/zewxYDoi1nT8nNBdG2D8wro5TT3NNk8y6?=
 =?us-ascii?Q?UwKyaA1Y6ydirC/Y3AbWULrrH7XW5f4OhOI2yKAN0ZBrehZERtKNtJy+L8bL?=
 =?us-ascii?Q?FDLBdo7v6i03quZAbk7wFKQhIEfURtYRvlPU2FB837PhydVyuyPIrZtM0DK1?=
 =?us-ascii?Q?c1T8W/AApO5D0w4RygsQileF3L2+jdgpmPUO5jKV4XqAnT8WZRI359ifVmEV?=
 =?us-ascii?Q?huE3BbxRaRjX54zJVFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YprudxAna3oQnp1DkH2TbitEMp7ObJ86bAL1+dgq2nU2Dyd2AB5Kp81Ig6hT?=
 =?us-ascii?Q?Ss/qzcjg3Gvt9THfuAVu5t/JXRY93kMD+hK7jFCOD+NeA9ZcpTsh9ZK9MGK6?=
 =?us-ascii?Q?KixKSYQ2K6C6g/zTq3YrYc3Gk0rex4TRrCn5t3J+VHRtZ0FT/TxPu0OOOJw/?=
 =?us-ascii?Q?Sq3DS7fN3IjUwkCVZbH4frN+E8SqZZ+BX/yZDl/84NqCKQu++Ie/MkVVyQXc?=
 =?us-ascii?Q?BP08NqZuxRJgSWsQA8IryLEAmUOUIQd2zAmiV1fONwB8DTxS5kdJqkafyQPN?=
 =?us-ascii?Q?SuJzMmGoR6FVMz92GUPQek0X6vhC6EI0I0VIHD+RanXNriVTmBDsAd4zaScX?=
 =?us-ascii?Q?gQEbnZH1A9KLzgJRikbaiJExv2ZBmqI1ty++7GTVbvtlW6DO8EzI1Y1P5WXD?=
 =?us-ascii?Q?qna1rGC3zPHKcVc8HiaYYRx4kY8u7eiscW6thDhzJS6qWAHBXQkuxnYOvu/U?=
 =?us-ascii?Q?S10P0No6AgmfCLHB28N38bH/4AhyEFAfBxb8yHyFha1F6bPwQT9jEnHhGi5M?=
 =?us-ascii?Q?Cqiv+Ml9Eomd4aA6ejbCOSWxDwG5HaT9OyUW1mt8W2Cro7qI7+jYmqBF3Ko4?=
 =?us-ascii?Q?fQpSmz7uWlaJdMEnsjXA3waQbZhDnxhxSoEu6XpgVkJTM0OCXDYa74lKCD/1?=
 =?us-ascii?Q?hkDqBO+8CuQJcMZxToxVcN5MF0Pdj0CYxvEi8M0SYmCY9zEDUMohaXLoB6x0?=
 =?us-ascii?Q?yzI4Zv6dac+IIQzGC5GPjnEcSmafOVqUYXDDNySn8ROcuOXjanTkQaLLXwfI?=
 =?us-ascii?Q?lFZPjZnwGtEi6rz5teOqCV/2rfn6dT1MLeMzUrhykl1CRUbsOf7YeKnZw1PB?=
 =?us-ascii?Q?hcseqnJIZ3am1s7nlDGOUAM1q8FdIWugqpOasca7ZApLkHiWpDqprqUfqtd+?=
 =?us-ascii?Q?RXy9mG0+ll47+6IOFnOkLVm23BTs2Bqa88euBsnTyZK11mvzys098utoPo3C?=
 =?us-ascii?Q?/NTenFa73okwwwu6GfXtbTbfMq00pP3/hHLDZDaW9ICTf8Gko3lcAvzdp9vR?=
 =?us-ascii?Q?U3ET/KU05en7kQzkuyCJb89i52kVHSRe2os01c0PWJe8vLEttxVQzUlXeDH2?=
 =?us-ascii?Q?WY/2sRfERWaZcyvHAruJNgmk4ldhTSwdisLZyDCtR4CBK0eFLWAS8AH+bylH?=
 =?us-ascii?Q?GvyJYN/34BVo5w3XOufq2WKkyWIl82miGsbXjcOmq/SAH+U4PNGoBYZplvI+?=
 =?us-ascii?Q?IzJglhey+yk/NCMRjViPPfDY5c0XC4/08tKzYBWQy7t4lGCEx95WrmNlTFod?=
 =?us-ascii?Q?UUms2zBste9zPEAzYCctp9zQ4BLyr/qwFgYSvfEJneCGtRin5neFAR4Pltnt?=
 =?us-ascii?Q?0/RsXBWWZwBHRY5WhtO4YHsC0CloKhrXsbQrdrGTUZtnK2GpqGg2Z2iMT+RF?=
 =?us-ascii?Q?NNtDmeUDOa+XV9fUfcc+QcQpishJpjuLii0kf3/4xpsGa0zme5t6gxcTM9Ov?=
 =?us-ascii?Q?7WgkuTiMkHq5t81ANI3nVwNKaO1JjHOW8cIaMmIlK5vcjD5PCAGHGkQmPWvx?=
 =?us-ascii?Q?PHjJ7KGWD17v6wcmjdXpfUBYhYSup6Dqaz+qIY7QLraqZ19g+lndztvghrMF?=
 =?us-ascii?Q?rwUP2D/nx5Q4HC/JcTDYzDfBZW3TRCry3LiFdteCZnpR6vOMSG7QMbf81CxC?=
 =?us-ascii?Q?au12V9oBlnwgbzcDZ+/RgwdDRiNCX3OTzzPqxUJ1UsvYLgZ31DNue38caN2x?=
 =?us-ascii?Q?HxrfnojZJ6RidFjJrfGF+mL5/zLW/ssAssNNv+jKienzCNbE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de52a53-3846-44b8-5eb9-08de5cb6f04f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:43:12.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3euYLZi9SRbg3Ulj/ChD1sO2LlF0INWATM96dHZiEaiUF+hN0f/aqdrahaIuQFaENsTB8dV3pqRvZt/xsJIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Currently, ops.dequeue() is only invoked when the sched_ext core knows
that a task resides in BPF-managed data structures, which causes it to
miss scheduling property change scenarios. As a result, BPF schedulers
cannot reliably track task state.

In addition, some ops.dequeue() callbacks can be skipped (e.g., during
direct dispatch), so ops.enqueue() calls are not always paired with a
corresponding ops.dequeue(), potentially breaking accounting logic.

Fix this by guaranteeing that every ops.enqueue() is matched with a
corresponding ops.dequeue(), and introduce the %SCX_DEQ_SCHED_CHANGE
flag to distinguish dequeues triggered by scheduling property changes
from those occurring in the normal dispatch/execution workflow.

New semantics:
1. ops.enqueue() is called when a task enters the BPF scheduler
2. ops.dequeue() is called when the task leaves the BPF scheduler in
   the following cases:
   a) regular dispatch workflow: task dispatched to a DSQ,
   b) core scheduling pick: core-sched picks task before dispatch,
   c) property change: task properties modified.

A new %SCX_DEQ_SCHED_CHANGE flag is also introduced, allowing BPF
schedulers to distinguish between:
- normal dispatch/execution workflow (dispatch, core-sched pick),
- property changes that require state updates (e.g.,
  sched_setaffinity(), sched_setscheduler(), set_user_nice(),
  NUMA balancing, CPU migrations, etc.).

With this, BPF schedulers can:
- reliably track task ownership and lifecycle,
- maintain accurate accounting of enqueue/dequeue pairs,
- distinguish between execution events and property changes,
- update internal state appropriately for each dequeue type.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         | 33 +++++++
 include/linux/sched/ext.h                     | 11 +++
 kernel/sched/ext.c                            | 89 ++++++++++++++++++-
 kernel/sched/ext_internal.h                   |  7 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  2 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |  2 +
 tools/sched_ext/include/scx/enums.autogen.h   |  1 +
 7 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 404fe6126a769..ed6bf7d9e6e8c 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -252,6 +252,37 @@ The following briefly shows how a waking task is scheduled and executed.
 
    * Queue the task on the BPF side.
 
+   Once ``ops.enqueue()`` is called, the task enters the "enqueued state".
+   The task remains in this state until ``ops.dequeue()`` is called, which
+   happens in the following cases:
+
+   1. **Regular dispatch workflow**: when the task is successfully
+      dispatched to a DSQ (local, global, or user DSQ), ``ops.dequeue()``
+      is triggered immediately to notify the BPF scheduler.
+
+   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
+      core scheduling picks a task for execution before it has been
+      dispatched, ``ops.dequeue()`` is called with the
+      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
+
+   3. **Scheduling property change**: when a task property changes (via
+      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
+      priority changes, CPU migrations, etc.), ``ops.dequeue()`` is called
+      with the ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
+
+   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
+   regardless of whether the task is still on a BPF data structure, or it
+   has already been dispatched to a DSQ. This guarantees that every
+   ``ops.enqueue()`` will eventually be followed by a corresponding
+   ``ops.dequeue()``.
+
+   This makes it reliable for BPF schedulers to track the enqueued state
+   and maintain accurate accounting.
+
+   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
+   don't need to track these transitions. The sched_ext core will safely
+   handle all dequeue operations regardless.
+
 3. When a CPU is ready to schedule, it first looks at its local DSQ. If
    empty, it then looks at the global DSQ. If there still isn't a task to
    run, ``ops.dispatch()`` is invoked which can use the following two
@@ -319,6 +350,8 @@ by a sched_ext scheduler:
                 /* Any usable CPU becomes available */
 
                 ops.dispatch(); /* Task is moved to a local DSQ */
+
+                ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
             while (task->scx.slice > 0 && task is runnable)
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d8..59446cd0373fa 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -84,8 +84,19 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	/*
+	 * Set when ops.enqueue() is called; used to determine if ops.dequeue()
+	 * should be invoked when transitioning out of SCX_OPSS_NONE state.
+	 */
+	SCX_TASK_OPS_ENQUEUED	= 1 << 1,
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+	/*
+	 * Set when ops.dequeue() is called after successful dispatch; used to
+	 * distinguish dispatch dequeues from property change dequeues and
+	 * prevent duplicate dequeue calls.
+	 */
+	SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,
 
 	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
 	SCX_TASK_STATE_BITS	= 2,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..18bca2b83f5c5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1287,6 +1287,20 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.ddsp_enq_flags |= enq_flags;
 
+	/*
+	 * The task is about to be dispatched. If ops.enqueue() was called,
+	 * notify the BPF scheduler by calling ops.dequeue().
+	 *
+	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
+	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
+	 * Mark that the dispatch dequeue has been called to distinguish
+	 * from property change dequeues.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
+		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	/*
 	 * We are in the enqueue path with @rq locked and pinned, and thus can't
 	 * double lock a remote rq and enqueue to its local DSQ. For
@@ -1391,6 +1405,16 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
+	/*
+	 * Mark that ops.enqueue() is being called for this task.
+	 * Clear the dispatch dequeue flag for the new enqueue cycle.
+	 * Only track these flags if ops.dequeue() is implemented.
+	 */
+	if (SCX_HAS_OP(sch, dequeue)) {
+		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
+		p->scx.flags &= ~SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
@@ -1523,6 +1547,34 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 	switch (opss & SCX_OPSS_STATE_MASK) {
 	case SCX_OPSS_NONE:
+		if (SCX_HAS_OP(sch, dequeue) &&
+		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
+			/*
+			 * Task was already dispatched. Only call ops.dequeue()
+			 * if it hasn't been called yet (check DISPATCH_DEQUEUED).
+			 * This can happen when:
+			 * 1. Core-sched picks a task that was dispatched
+			 * 2. Property changes occur after dispatch
+			 */
+			if (!(p->scx.flags & SCX_TASK_DISPATCH_DEQUEUED)) {
+				/*
+				 * ops.dequeue() wasn't called during dispatch.
+				 * This shouldn't normally happen, but call it now.
+				 */
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
+						 p, deq_flags);
+			} else if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC))) {
+				/*
+				 * This is a property change after
+				 * dispatch. Call ops.dequeue() again with
+				 * %SCX_DEQ_SCHED_CHANGE.
+				 */
+				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
+						 p, deq_flags | SCX_DEQ_SCHED_CHANGE);
+			}
+			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
+					  SCX_TASK_DISPATCH_DEQUEUED);
+		}
 		break;
 	case SCX_OPSS_QUEUEING:
 		/*
@@ -1531,9 +1583,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		if (SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
-					 p, deq_flags);
+		/*
+		 * Task is still on the BPF scheduler (not dispatched yet).
+		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
+		 * only for property changes, not for core-sched picks.
+		 */
+		if (SCX_HAS_OP(sch, dequeue)) {
+			u64 flags = deq_flags;
+			/*
+			 * Add %SCX_DEQ_SCHED_CHANGE for property changes,
+			 * but not for core-sched picks or sleep.
+			 */
+			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
+				flags |= SCX_DEQ_SCHED_CHANGE;
+
+			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
+			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
+					  SCX_TASK_DISPATCH_DEQUEUED);
+		}
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -2107,6 +2174,22 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
+	/*
+	 * The task is about to be dispatched. If ops.enqueue() was called,
+	 * notify the BPF scheduler by calling ops.dequeue().
+	 *
+	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
+	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
+	 * Mark that the dispatch dequeue has been called to distinguish
+	 * from property change dequeues.
+	 */
+	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
+		struct rq *task_rq = task_rq(p);
+
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq, p, 0);
+		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
+	}
+
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 386c677e4c9a0..befa9a5d6e53f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -982,6 +982,13 @@ enum scx_deq_flags {
 	 * it hasn't been dispatched yet. Dequeue from the BPF side.
 	 */
 	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
+
+	/*
+	 * The task is being dequeued due to a property change (e.g.,
+	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
+	 * etc.).
+	 */
+	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index c2c33df9292c2..8284f717ff05e 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -21,6 +21,7 @@
 #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
 #define HAVE_SCX_DEQ_SLEEP
 #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
+#define HAVE_SCX_DEQ_SCHED_CHANGE
 #define HAVE_SCX_DSQ_FLAG_BUILTIN
 #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
 #define HAVE_SCX_DSQ_INVALID
@@ -48,6 +49,7 @@
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
+#define HAVE_SCX_TASK_DISPATCH_DEQUEUED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 2f8002bcc19ad..5da50f9376844 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
 
+const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
+#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fedec938584be..fc9a7a4d9dea5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -46,4 +46,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
+	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
 } while (0)
-- 
2.52.0

