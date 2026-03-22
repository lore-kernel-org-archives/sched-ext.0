Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0F3112BC
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774162314; cv=fail; b=O6PyQF7EoGT/goVP2STrmYK2l2hf0bOfE0POzLQHK4xOXQw2mh+eoOKLn6+ZE7CEnkYzq3yoAByU55UqwgiqITcHByRVrQedSLMXv1JxFHx1jJQm3dSmIxTUMeaZiwMFGUSywblFb5PLNi6yRSr97X+5JeZ2keEIR5gdl34K/wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774162314; c=relaxed/simple;
	bh=4Fsy9dN/2GOC9v+8tgNHlo8Smtk1wdZoJ32kA51k+Js=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J2YuySWD/3h28TSDT4IVJRpe+38lkjkbwixbEd4cykMaXunciJvw4BrKkpfU1wn8GMbEAAPtafJHUx8NzzmPWerXyNMoRCMevzkof+BqrKKcdnC0GxbbYxSh8ZACUy9rYJ3A+v9I1SxOa4BcwNbPGcLpuV33LKFYdG0vfPbwM+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MFaw3T8t; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFaw3T8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5W4Kw5jO/7SMRTgB+f7qtVA30NBLBJYYXk4/XSKzXsP1Guuv9siJoyzaTyb7wPAFyjlSZa8kgwEMaIa0DV8VqMGYT0JwnDfx4WPbm6KdXWAWjkJFSQNUjNTDIq+e6P3BT5d55x4ElXTlqpju+RveAbtmxViKeFf5t89W51lpvTOGLYLHELFYhm8dh5dp8HWcz5VC5HMbCrY4it4R/JSc5x3fCFbzSUsQW+6OAmbx/6xTZU8CmVhn3nXytepzndRa/zDf9oAVqjEf9xylEBN/DlH4z0fZSOLG9nARRn3QN5p+n2mEi23NFz0YhZNSN9MZssktOKeKugHoyfT9HlORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgTSUUveDDn+MMEaJImvNZLsg9HwhCuGlxpzpTeqKs0=;
 b=J3YVvEOU08QcW3KZZNmruDnXaJJ4C9SQ8rZ7sOCs08M4W9/Ripkwo6kNNwGHP8Byex1aNF67ivOyyra/PpGfSELjWfJ0suGd58za6qGQlUAa3smGZG3UcWkjGAvOUuhA+SP7iIJih335cCjkCozSFDAU81ZjY/beBpm2+04B5/2L1eBro6sXfyIXixjD0S8lmLZ1cT/ECIODbIidQHNtrQyWYKOQ3fFiqOFba0dXvIfQnLmqmoV0lhZNSNaVkt6hGpfngCPlajl0dCIigHnuZwu8/cpwzi/faGuNDCLfJgNeSYgEQ3BpGlZ3SItDx7MskP9IEWJn582k4J/I19V9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgTSUUveDDn+MMEaJImvNZLsg9HwhCuGlxpzpTeqKs0=;
 b=MFaw3T8tk1er9wRaMlJnVkt8ZGEYLcCxKuC3jLE3Be6fQAesIa/aMQ+nEJFwJSrYYNaL5YTpOXzd3afLagoQidhbO97o7IqSds2jfJ6Ejw6npF87WEpY2j5EKg3bhbVzQhLGiMpcV03uEN0GUAL3hVuy9Asi9W2/b5wYAfWnTxNePS5XQmNthJ55LGi6FW5/zDgDWRhZuajyYJ+uGXeCRY+28CCDVirt8UukGzFh59C0t+rbEz2VlnFk6ZyYMaKEe5uGjl92QLziFVuUs2LGpaNRMkbrLzN3zG0PxJyJccAZMqkhWdP+4sJcbTkEFGoN/iMIjAvnria8uy1vR3WmBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 06:51:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 06:51:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH sched_ext/for-7.1] sched_ext: Guard cpu_smt_mask() with CONFIG_SCHED_SMT
Date: Sun, 22 Mar 2026 07:51:46 +0100
Message-ID: <20260322065146.339038-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a185a9-cbcf-4387-25cd-08de87df7dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BxiBB8G9r5aRTEyDq8QOQkeZH9aaO2B+DJVfnsjZvjmH+0KF45PD3MF9gcje6ntj4q6iVRnz6q6EjzHN1k4LRExbdRoL4a1TvILz1AT7b9LP4AOetHsXsgg5JSHbd4Zyj74/bmi2Nw//rK9aHytsXdu4q7fP5e3IJsC3XffKc8XwQLpRP6NMekZKrWORLqJvMxlus5qTgn0AAgVE1MDxM6+D6QFs2ZjAGBpemp2RU3y0+fJMbq75zeA5zu9tjErzczyveXcrtqssCIh5oC/56uNJBBpKlSpQW0B3zPca+hQFm3Qd1E1Xa41paQNal9IytZ9ZwPk93yCyCy4s9E1tR6uo1j0Xsi+i8kZmzMhA9AlkBwafJO8kifbHKFh3tY0X1RpUdHz8XXWvjuCDx1FRw/07+jNANtwfVDeVtmaolT9l1g3Hy6Q4aIxWIYh1L4dQp1X4RhU8lHnAj5Pa+S+CmBSoPFlJpqDl7YJAEU6Wy4noBBKZcaDtvxvL2KIXVeHNanykBfM2M6WHlEtfa8ioWLAzpCzdx5UjthWY6ndNp0wmBZf8JsDpuFi6wOI4vLNGDXKCrfpF6tb3FJNX9r3Jtln78jbKzOU2zrPTmeEC0SLZHuju5g2Mr4F3rBP1QOQ0bb/6jtImbY86v1WhA7mFaP4xLrzPi4ITmrE/mT7QhDUE3Ig7QDq/nCZenrxGs4zNccqXf3JVVdK4nFQ9N+dCctkHejN1MZILLE+uv/2S6OPYxBeH2IXJ+RLCqkTsT98T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1l5MDte6YypGsB1RWRdhkWGkmuS5smx7ou2u1Wl8ilzK1Bzsv/MAzuRKLPw?=
 =?us-ascii?Q?NOwiN5C+E5qvSNZuhE9E/yYQnmCusZqm4DYNnB5EwpN9O/WsIrhF13KS2fa+?=
 =?us-ascii?Q?lMMXDLA7kC7XWEqTVs4bmiockq7RZB9LbO7h4G7ozYxXKV4gysu5Z+Je/NFY?=
 =?us-ascii?Q?EsRVpgQ3z/G0PuQ4B1Dy9yM62+BLbSbvRB704wBV8c/urcYaem5f2eIcihJc?=
 =?us-ascii?Q?UvC8Bjq4B+mOHkKgQl/YBkXSL6HStqUE8N0cZUNlgCFrfX5ZWIgFTWSQTkdJ?=
 =?us-ascii?Q?7ynyspES39MTzar25cMP1ZFArF1EqTHhp8oDOt1t6fnDv/LJ/V/deJk6K1S5?=
 =?us-ascii?Q?ysNJoPLBhCFYdnYQyEmjg7qSARnVrhoL9voSYgB4lJkyplGjiBcdhfDn6rXa?=
 =?us-ascii?Q?J4na1aVt1/WhD4bWe2eRiuT24iZj+fnfZCIvpNeBST0mwcGWUxhgf2w01ujp?=
 =?us-ascii?Q?od1BRw2tiBAil3I31+WF0nZKnEB7uKyqmciZRYNU6hYFv/lLyn/XX96SqkYd?=
 =?us-ascii?Q?LOcQG4SttiHUbf1HzQuS3Qs911QJfb3Q1C9/u7DJcN4VeM6rsSoHDT2Ok9Uu?=
 =?us-ascii?Q?8wzP2AVRjx/QMNIOqsxc8UxQmehNfmdmOdR2yfmhREh57mEgXzUbWMUL1Sl+?=
 =?us-ascii?Q?v3EHQh1MRAiOUvHfCojj6CCWlCmato7x4naMnc9MDleTrLEM72aPXgAW2PRF?=
 =?us-ascii?Q?/BH5ArEKzH3hpRcDLZOnIUCHCs1TSkN7jtKzCaDG2Tqi1VNiAuczgbl8dlyL?=
 =?us-ascii?Q?a2GeWMBFUHfxSJ+0/l5VSDfuVrY8R+Qg5OOVnXfPZIrcdKjbjHESrBbn2ZT1?=
 =?us-ascii?Q?39CzFtZ8GZlbhOiKXyntZHxRURQfi8kss1jOcaqRySUsHIwzzoJvFNdZyrdD?=
 =?us-ascii?Q?8955e8RxtXXxX3AYKIlw9T5CXVfb7lGI8TNGgkJAyxqjIqqa9oKCGMt22FNF?=
 =?us-ascii?Q?Zn824NZPf5/EyQGnK6AAEUhBnx4ErvYKomvCz3icmRAAUO/nmOjY3SVWvH4e?=
 =?us-ascii?Q?zkfh+AdWpV+XOyZppXRQqJpM5CGVWxsNwqxSQJGE2mH/oZDNeOZCZ2ysxrFi?=
 =?us-ascii?Q?5L8XvwaBmIK9+BLZzdkOh5CQ6lDlbsaCsp9TSrKssKooKLA717cOCueXSQdU?=
 =?us-ascii?Q?88DC/x0LN8C4YxA2wMG3DSGQ4poFpJc5afQTAlghn58Z565/HELFiJ9O9pW3?=
 =?us-ascii?Q?8a8/UI8TxmHDd1NbrtjC8Fm8cfUH6nK2DirCJvxYgkSRAnM2Gr4uD3q3qHsS?=
 =?us-ascii?Q?hfRIBWhhb9ROLLPitZmZ9edKNp29/f4DNLr2EGe54TBAdsduhWsjmHwXa0nb?=
 =?us-ascii?Q?UzvOEp+kbFGd9rZ+10rkJauG2gDzSphnJH98c02F88sDjxEZN9IEBSjpGrB0?=
 =?us-ascii?Q?i85EJTS9pDs3KhArETzqCt6G/V/ByC9DExbFc32cYZw/Vc908bxO1sN22Z+Q?=
 =?us-ascii?Q?Oz7KpTYy0zIMjVj4PcH746zTa8KAqz8q/dzxtj8Kmw6tPM5ccMPRHv1+5aVz?=
 =?us-ascii?Q?aowAd46LcW5Bhk3ecB8Ldlsr0XOTSxmHj1WByumMN3jv3S7zsMYTuoQ1sOmq?=
 =?us-ascii?Q?NDLIqQr+2lXWMNur1saz0Ob9gXfdjAHEkGSiMuZFJKdTYfWpmUOZSNWFZln6?=
 =?us-ascii?Q?lgzCOm5MLYlBATlTz4rmMDTEc3HMTqoUD80O7JRek9TeBrNZEUCO94INWsV0?=
 =?us-ascii?Q?hQgagbrbubnAe6vKmhpLB+XpzxB23geQqU8euxH3fcuJeu288a6jyO0765BQ?=
 =?us-ascii?Q?ZRqxjDs+Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a185a9-cbcf-4387-25cd-08de87df7dd5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 06:51:49.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjA/o3tVnnth2hkpAa1OPDCkyhBYhfqB5AAuyEhDbONXEtu0Ft/0YoXxyaQ0ho/9dcqbmDzRb9efTB/TE7jzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

Wrap cpu_smt_mask() usage with CONFIG_SCHED_SMT to avoid build failures
on kernels built without SMT support.

Fixes: 2197cecdb02c ("sched_ext: idle: Prioritize idle SMT sibling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603221422.XIueJOE9-lkp@intel.com/
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d9596427b5aa1..857d8e902b448 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -622,6 +622,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		goto out_unlock;
 	}
 
+#ifdef CONFIG_SCHED_SMT
 	/*
 	 * Use @prev_cpu's sibling if it's idle.
 	 */
@@ -633,6 +634,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				goto out_unlock;
 		}
 	}
+#endif
 
 	/*
 	 * Search for any idle CPU in the same LLC domain.
-- 
2.53.0

