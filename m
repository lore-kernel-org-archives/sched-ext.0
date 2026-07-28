Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3959447814
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253508; cv=fail; b=R6br0CD7prdKZdVTShhEAcVZ14GNONSMp4lDPZTI2l53ch5nqHBezpEP6waPj0LCpwkSZ1Vg4pCFBRpPzfck2FWhgWr7Dq3jJd9v0yuhHeq5N4VC8cM2Ojp3c9TsRaEhiQ5mACryFT+C14LmnOxhTtWm9DqZg+rLpeKU5UU4Asw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253508; c=relaxed/simple;
	bh=9n0B1mKpKqO7KavA2AjVFym0DdWEVyRP60aPubZMuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+VvojFcUS9ooWLjRT/8fbvae/A74kslMwvHYCnRPonD5QVW7l6OAnWju3H/niHE3ugbhj/z7PPeQX1ri4lcEmLZ/1UHXwZf/YAyCVZzGn8SSxjwDpBtgILBIf4koSNzNh5ILcatjxnMqCZ1IoAbnrGjyKzqw68Cue/85rjgTwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfYhPmw7; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfYhPmw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtVGrFtHjWNbw1QuTo6BpNVsUlWvepXaPOe9Zf/N2PagBAoWOAe0v11Iy2bO8cdBL/mUdL63CNsG2frrBBiOV55sHJQ9DkliWpl+X++dRLDRrFFe16QZNuNsN18mXbIEa+ucL5+a2+g55eKNdBzuLrxDXlARk5jEtr+WUVn8Pbsdg1dqnVqkitbNqdqZmxp2tPCz2OcCcbXjwtLX3SnSzlSvJqf1wslx6DrKBZlpp8C7Gu2giGOrTH6SvdZrf8t/E7XSM1ChrjqEhyw5glW7dU6yRQHBJZRq5y4rbCXRFNL3pdyfSYUwqpqtrurdaQqsIsqe4BPA+T1jpq6XTpbCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe53CNrsLWMEoWIS6NQyyNKWqwQ3DTCsAttFLNnJ2vo=;
 b=alt7LOjTbVRNXt8KPf1FoqO34qDgt1nb2Oo7tMGyoeuoEAdrTWMzq39SGLNoWE5LZyA/5rKZ5eushRDehuSG8F6oQMU5zsuOSz6YNhh9ff+JWzpAkinLub2PlsN6ZIWdWoInyD9bXyRk+E0wepd6lMFOhrKhHHE6TAXbG6JDWMglQjtELn+asFsowhfDqBpXUsjUX4E9HEbrJjyN/ptk04g4jXq0NRLDzdKW+uKg6poqq8/jW7M1AwGNJVefVpBnZTUOfaqWyVmPvufIK5LmaRw/rVWQO9dcM21GMaxmyDfxeQYiz0Gg6ZNmJkeSjLJpsZdyhkZOUxr4qDwJCxkytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe53CNrsLWMEoWIS6NQyyNKWqwQ3DTCsAttFLNnJ2vo=;
 b=UfYhPmw7x9e4K0lAAVboBEj1oYDY0HVnqjlq0ZjhNYi49jxsD8WTKaUH5epMwqGdPWI5JfXz2tAGlEO2gxc3tFeCB91uX1LLmQcVAewy5IytdAP/RHuDS1Coz44yRpNa+w/kU2tx0qHFAZjoDStXrbcnzJKv21uU3x13Ea/B093or1RTiYy9z4b/IknCMrb2+rBopYhhzB2QR/CW3AlqIOTf83aGnQZ39PEEX9HUVStmHKwsjDhd6Iy2MgyNjdCJ4Ty//RbLrasaiAkWF6+CUzpaOzLxQCNLB1duaUhzBmd3GZjkS5D0kyBEexLNcRw7R38PI5i7Hsv+XIpQg/DFkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:44:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:44:57 +0000
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
Subject: [PATCH 04/15] sched: Skip class callbacks with SCHED_FLAG_KEEP_PARAMS
Date: Tue, 28 Jul 2026 17:43:22 +0200
Message-ID: <20260728154425.1549660-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: ca232af2-a473-465c-650d-08deecbf2d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qfFlg8PiMrq+0aMu9ao3a0b23h/HrB8eJYQy8v9h3uIbemc7c4RU34k7HL+LPmoVxKV9ToFBBED5fmFv0x6009ojGWaF96Q+y3eu8l7CUzzXIf5wb4mUnMO6lwEX5BKOBJSRidvlQmY+zoMDVMXUkiUtU9MA9dhfcVhcmiF4pkgRzJEPQ1SNXd5foYfbHWM6fAIJyx+eiruDE8Vrd42MAYm9chz7NSBGwY8YBFp/gBKSBCgahGHxRRvB7bv42beuL5hJN5Sz/8jkNCCT0NCdFycJE+CrVFFIEY0o5YP0wJyjUQgV4diXB+3lLR2iEJLeKH2x3xY/vO0lVdgi1zMdUhHMq9QOEoz4o9GLAlVoDiwnPUHDxMSoVjWmB9T09qjIn5PZ6LXZRAeQcZd/joPKneA91YzO3EETgS05kdjD47dYkzZwCrdVxY6zkyZCJGDdGDogjzi/3tNvqpd0ql6pmalvV23wHOnEEubKaShqRIt6YCh3LB+P3nPoX06ITkLbpL0lvrEMs5IAe+Wpi+MahLfKbNqPfJnUZpgyHk594YJSgeXK69fuuttkug1s8CcUiyWjfpzYpIdUtSMV7PrGX+uiKoMGUm6ZHOcgRfSc+7yYldGc/vwKBSoF8NQ9Ptmmo+Y65Q3bOMZsLmSiZWo+BurV0ZjxMdA7tzgCxOvqLIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRd70PZIcSoQaC0B2txv/4kUm85pCuHeyHoGLlYj7mlMhWvWxLJaYFRAst9x?=
 =?us-ascii?Q?m+zt+wyERuoF6u/EFu5mqGeooWxerDAISjlfhrFqhxkWtXtE3S8zNmeXMLGK?=
 =?us-ascii?Q?TTmJ0t6413IaroMr0FNkDUyw9jFCWZ0JL1RTKWcZ0Bf/WzK5craoIxtwvwrc?=
 =?us-ascii?Q?plq+nURsShKWVFdsBerDCQpL0i2wEGukVZUxYnEUmmwXt8c5pUhX7WE5N/J2?=
 =?us-ascii?Q?CGqOf4RwItWMnfVi2abUSh/Uo3igB6+s2OlolVWe8Vx6FsnQ8tLHNtBxwAAC?=
 =?us-ascii?Q?vs7XZPWmAE67khQoSv7n64XRMXfKgoaKxZAHzlxi1rXxj29OPV9LrKP+EExE?=
 =?us-ascii?Q?jzbqb6WLJlK9sOiql2tpF5fguHsuqdtBL0eIcH60xwSVsaCrEGd9KhHrSS7m?=
 =?us-ascii?Q?d3KH5dCaSo+7ELvPAWL3n8NVuIl28bR1D9frNq+gCYZ9J5aP2M5F4UPOBow5?=
 =?us-ascii?Q?4MeyCFTBfdC6XuwLFA5N0rTLUEIh46giscgnP3SsG+dZowe9Dw5u1vNiozNg?=
 =?us-ascii?Q?8nCKP+ZMRGJxOTHSVx/X2DoQGTyIaiCFcdWYNML452iYcfgKvv/bmW+9W3nU?=
 =?us-ascii?Q?5vOmjgbjmyM8RH9XIdKpUbAIiprAm7M2o+OcmUX83lqOhL907AGKXzzgpkmm?=
 =?us-ascii?Q?ue/NBmnudvBAabGNJrsxYd3jDxYX3eMT9cnP4Y13+t5ng4e+g+xYKYe1lKYt?=
 =?us-ascii?Q?kXT+njNMwnxlR1pdTOOqTiqt6eQJyMU2/cCkRjiQZl642iUyniq3DIAdkxxI?=
 =?us-ascii?Q?iSAAUI0PmcMy6PYTY4sqAN2g+LZIoJPCY3MqC+I9Dfm5IUFCLiENrGS+/DwQ?=
 =?us-ascii?Q?22J7HBeURe2UbbQFEyTIuXRKLhOAwZ0/0MQVQNH70Sn4/5gVwWr9SZmM+NNZ?=
 =?us-ascii?Q?3+i0MibxjZ9fRvcmonE9BuRcDg7jkzQ2xjvvuDEH5RRQjxwv4KXcnMTsfnZH?=
 =?us-ascii?Q?6oriCsmPoOK0c5N3/GaltAwZ4mZZhQxfbfhwk6p38ScoYDoHJ1iHms/rRNaB?=
 =?us-ascii?Q?0ECYZw9IS0nDiNaUVvnh+SGaoGxwhrKKm15L0A/d06iiURzrU2VlchnGmPI+?=
 =?us-ascii?Q?1KIKQRmhQ3DcWVfPGwCp46CJt3vpb2FaKxuz3bZZ51QPWh2FFJgDjCYsxpcF?=
 =?us-ascii?Q?ixbuM1fb91oTHy6WUWHFrX0FFUSr3S4BWa9Z1mwscyf9Z1ZghbuN/pzwxGsy?=
 =?us-ascii?Q?8rQcSYWOeUqoHhW5N72GrjZjt9pUW5XKpwld7xj3TsdEllvbVvglEJH6iGiC?=
 =?us-ascii?Q?OQZd1RH3UN8PqoVjBetZhyzzXeqWTg7QW4+hgMSqg9K2YWnYv4DEru1rqmrx?=
 =?us-ascii?Q?eCc6Nd4Gu8s8JbSydcxruZQ1iZfu06tClMt8zOfbWzi4ryu3jGbn0erfPgtf?=
 =?us-ascii?Q?XXY2mV2/1ta3QXoNW27Lnai5FyR/I752tIGaZ9bLHC85CjcESktwUer0zoW6?=
 =?us-ascii?Q?RbBt+XJbpsyuWG0uftCRe7o9aZUiD4x4zxX3uqf/DEozzcZmsdpch+58BhFR?=
 =?us-ascii?Q?sGWW3cW8tB1BcojZ0inGhB1U7HpD4QDEnduZYUD1FJdhhA8UD60I2nNyLeYi?=
 =?us-ascii?Q?u9HVdQf+6feytJqNRtL2I1uN87ClIc7fDgiB75/WjVWhT1f9O3tnpQScPlyI?=
 =?us-ascii?Q?g0XbOGsCEbF7v2RRMNZZVILfd6aKz2HLsKDLGW4APJ94YePPDB0XIti0+33T?=
 =?us-ascii?Q?XRSnVIezaTgmsI6DXEVYoyzSFmy715BxxJtkTPjEp2GgEpi3kL/oL4xtbLkX?=
 =?us-ascii?Q?8t/vMyZE9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca232af2-a473-465c-650d-08deecbf2d2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:44:57.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +anegEzCR/3gj/L1V9rRwEY/ijon0nezSBvqGJ7Yx6wehvmWDCM1Kuu8l22SZhNLMN8+/RRYzFfMIiq8AgGHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

SCHED_FLAG_KEEP_PARAMS suppresses scheduler parameter and class changes,
but __sched_setscheduler() can still set DEQUEUE_CLASS when the class
computed from the requested policy differs from the task's current class.

This causes the switching_from(), switched_from(), switching_to() and
switched_to() callbacks to run even though p->sched_class remains
unchanged.

Set DEQUEUE_CLASS only when SCHED_FLAG_KEEP_PARAMS allows the class to
change. This also ensures that incoming-class preparation added by a
later change is only performed for an actual class transition.

Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/syscalls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a60..903b47f5d0b74 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -675,7 +675,8 @@ int __sched_setscheduler(struct task_struct *p,
 	prev_class = p->sched_class;
 	next_class = __setscheduler_class(policy, newprio);
 
-	if (prev_class != next_class)
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
 	scoped_guard (sched_change, p, queue_flags) {
-- 
2.55.0

