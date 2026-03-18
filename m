Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFB1A9F83
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794336; cv=fail; b=gVd8N1nbtFc0Z8ItrbRoJhjoYjLO9QiCRxciizlqhJSHdbHUZT2gDboe7ug8WPE6rK9E91eo94kDH5wxUh1TciQnHiYKj1IsSYJEg4d6GHYwWfiTB2EUSH+oO3df896/+NYJQmBniyPv3riBzO+Rgyt1VeP0EuMOcAhlZg9ACes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794336; c=relaxed/simple;
	bh=4OQijln/AZ/bKy1hKLy0Z9r1+tvaPhGGinB/Y2o7pdU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n8qDXCwP4UtFe2w3BDuhKLj0QjTP6aptvDM8x8/IdiVHlS0aFl1r/aRKKohQK76EvjH3VPCGA1pKwY8Cs+beYyAHFAPKbY6p91ZnU83vjoj7/S4Rrmx0PKoLA1ObAWSSYL6mVtdlDShUffOpfR+7HhR0qWXwll3E2DAh1XOuuX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DidKZe1/; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DidKZe1/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crluqAVIAXXVE1ZdiQPQj/CGnKyLpkhbLbUDjMt/hxa1na3bdtet5xBqHULq3HZLi474zEcXT2ALBktIYVC0h4mkRAOLn8LQZ83BU9P3TrvoOEbu+/u7+VbAXqOhqHaFNNXR8Ia+K3dtVj3rT3Rz+k3ABSJ8vbmOE1ne4XPidGwCvtraXEdmtrUEk4DiCrHqiFH7caX5le3r1BDcNfzCANZtrInPZmUtsuOiYCt1i1+3VFXkAZyBB/GFAIgyRTQdHya1409V90SQK0M2SSe0YlFNGmGy8l4mBtKd7YAAEEO35dyjyC0aHpzkYaOSQ7hsB5L9XiRjTripEuTw4FTI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWgLE6xQQSUg8PUzPSVTRfPrGkTP/Uc4hNB1XSnN4G0=;
 b=GeVeS0VlayPaSReAc4eDjd+WbsYcL9Dt0N1PzhYGZe+jrOXmrBRdsLyXIkQFwZf4fHF8y6xtPb4Zwmo1qMjP7l5O0jF6Rd0HNc3Y3ERfVOirg2CGFJIymX3cOpoT2e+kFb30UwUp4h5OnkoGI29zAcgI669JtJ2igWyXe4glE8XDtPkdvC1eYi7xzVa0vJg0DYZMFjA2oc6oUOy11rsl8wBWIaRS+9AEMluH1i1lPbMn17oqPQh+sjL0c0pO2Nki3fn/Up82ratqZ0PXfZF2RfnrxKsXDeKtwM/Vk6Ldn/0dj4kcj7M6+1gkEODHn0vbGrkSnwb9ZhO/C/YUT/m1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWgLE6xQQSUg8PUzPSVTRfPrGkTP/Uc4hNB1XSnN4G0=;
 b=DidKZe1/6aj7fws4E8e+vYNpmS1xpinwrIXCW/gwz5tO9EBuhtDYOBc+jReyLuyxhGF6hXaPc8qiFSf8iTlme8OpdLHJ4C3DYWijImdGcb6+hE3XTNkqP0ri/kh2por5waIsmky/fnXysHzomdt9SskQhqi4yefHXrkvRzX0cj5psQ3ng+JP7S86n3ebyu4pmRPFLNKJ9IGicYpz8EsteFypgCnaAWc9v4RlWWxBdzMJHQbKAHHiGbDQ9kOJptDQKjYRYKTognTozguFVos6wxfZQewJh/cpJlqjH6CaSg3m3D4R6TzY4LB9ZdAxXtAuCORpCO9/ytwzJB1OoYwNkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:38:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Wed, 18 Mar 2026
 00:38:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT sibling
Date: Wed, 18 Mar 2026 01:38:42 +0100
Message-ID: <20260318003842.762275-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f1c18e-da04-41ee-06cd-08de8486b888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yyMb/wfWN30dHk3ztTswBiKUD+qfDPUqyI5N22z0gmvfnBMyN5+iSzKKs7VQRYWtzVdcfhtsBeU3H6Gj9oqthZQ62WAuD4TKYJb/e9QdBuMNcG5mUuhmNwrk5FHoGEN1Uq2w2nmYZSz/nkNMVvDcxmJcXcYjfJUBteYkxjwAT3+dv0Inu+x0/qvMRORKRM6BD8Sn+G+4oWTZ8P6ENjhfgWCBb95CrZYuHBZs8qdzZHhk1H8jOLRr9e8rcSVq5oFJjjmNFDkHcJ/GsXfIJpkUyXB2pHmXQO0bi9sT+5F7rFuB9nqDB17RxX0TIJdR3hOnNpxxHqtJWO1tVNuZ0rkuHUXv36TZQJIh3Hh52es8Yp2al+FGz5DLsUSaNf97ACEq1qbvma9BJz/Ayidl34B9Y0iHRhvX14bQEH2yTAnpUlK4juG0U0M9zO1bs8KS96PMMIi+cTQRBYMMTXvdd1AJIBvs69+R9iQynKQ0VB58bqrOCdgpgyzKkPyxeIAZfiGVqy6gzXf8JQdmV3aUVg5kpE9EmeusbBwHTaRwGw8wcsZxjdSA3esnRdMeIdIfpJp+pDHPVcpy9uAXn0CMyhOi9388eawSAdojLcfa76w3CPeS8+WqR9zVyaV1rSL3eP/lab1GNowKnQ+sdisgfsXCRHqTWuX/9gP/OpgWZsHXHdY8Votp0C+//z7IHMPs9SSujpkOdujnHZEhAwTA3iSg0i42X7GEgGuciRuTcsUBi7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+qgwNFMmBRRaqMyMIPaiTr8MMLriLxMyW4zGSKWBiq4gJhxLmRxtFVfO51G?=
 =?us-ascii?Q?LOcDT+sPKSfHtt9lmKyvwu2uE/m0zTMelT0ecao/pfO7NewhYM5i1zzQcGca?=
 =?us-ascii?Q?Mz4PKqv83WaSsFrCYN78P0PoL+I1LtBiYcirOPaBs/Vk4KMR6KJlPskcSxTm?=
 =?us-ascii?Q?3JIyqyEm7mQdhsnHpun4TO6PY5k9sMWDUq8Thi1S9GDUhuKnLgTC5dGxnsqz?=
 =?us-ascii?Q?qkJgfFnSFlOmDQXcovQbhmHr0w1gyu6TACsR6f119xwAIwSCx/ulWr6BgUH6?=
 =?us-ascii?Q?RKj5DtQxQtL5mh9VXS3yb9ocaEBtPbTrlGS5gyg9CrPoZNWO32b0NfWR8l1C?=
 =?us-ascii?Q?TL/dDXTPWczEUXoP40JFfEZz9gVBl8J7qmjJb7VFPo9S9pcwktlJ9FU1QA+e?=
 =?us-ascii?Q?gD1Tw61w9BknXwn3+LYA8UpirqAsC4lqK/KMF7iNiYE+dZ1Lg6dAnVC4U7PD?=
 =?us-ascii?Q?/KH98tcGx1rYpIR9SusUfnvz0YjZxZPAZRkt3ImN17xHJa1SEb3VYDATP78z?=
 =?us-ascii?Q?vsAO19R3q0CVVzySo61N66jaYbLKQ2SThB3d+GzQJRxMyk4aCUWorLj2kQgD?=
 =?us-ascii?Q?6bZSoZJF0mAsijPWG4gfEm6JE8MxSyqWIuYp7nR6JD3RWVy+Z+p4ze/tgl+L?=
 =?us-ascii?Q?5JHUCiSqTZkMRdaF5vEeMWdVfWwZdyiWUyQcnTXNh/C/2ntOUAVf+x7Wfgoa?=
 =?us-ascii?Q?SQEm6nMx5uqfl3MiVKUim7gNMyYUqZbAMt+OgAgDWpG3e8Zzamms1QXKl9on?=
 =?us-ascii?Q?+o0kpbnDyT9tx6gUBM/0kLI/jIqQJRUPX/1w7T/yoSUTCztpf2L5+2iZEAj3?=
 =?us-ascii?Q?4YYrUxsXVTgtjBq9g0z+NLKeeP7YCfocAeenKlYRsvUtgnF8BEfMRlSMQwX5?=
 =?us-ascii?Q?KG23QFOYpZM7VkrtX+ghDPw1JsWYmuU6BpUPAZ12v0erUCsS95G2yHJmn3I7?=
 =?us-ascii?Q?CYUp3y6Dx/5dQ9ycB8i/aoYDFbd3kLpRTmSmEcS86wWUO86z5Od6A4RUONZO?=
 =?us-ascii?Q?PjmYroOTcS/iM8XtqGTwOyTQJTsKIUyuOkAkbHHj1dHwZMgzvG5agm5E4MWl?=
 =?us-ascii?Q?BQkLNYLa7UbsjG1E+UBYeggto22oqbyM9UYseXaRy1nRte+HUFsfBFCQjDe3?=
 =?us-ascii?Q?3y/jUFlZN4YCsqsBWHFCSf6YecnVtRKvEySO14FOU87mjaIuJqoGdTx2g+fE?=
 =?us-ascii?Q?2kirhvXGgKeIjBv1Zx36x4qLQnjHTE75IX6Zfrve2PiIHv3aVQbooTlV8a2w?=
 =?us-ascii?Q?XYRXPutTsKtDWs04RsH7bVjyjNyBhSYcE2mY8Uc9pPLE9yk0SJHkdBeNNyZT?=
 =?us-ascii?Q?tkbD4TBXQ6fw8FyAO8Fxpqk3UZbK4URRf7lNtPPic/CDLVb0xmhW1wWJKkHI?=
 =?us-ascii?Q?on5B7HSRN0+LcBi+GHD7kDAJZr4NPjO2zK+IdNt/0m0gzYUuyArs1feVSkdx?=
 =?us-ascii?Q?Kw6AiRFshORPcqAZrlCk1KFRw2ACPqOTb9igjtTDp7IyijEma6Swxv5AjJEF?=
 =?us-ascii?Q?5Ml8wJkaqi3Nq5gq2ZQoU0HymuaH9SOnfPmMpilW93RgUD76dDN7dsprfhrh?=
 =?us-ascii?Q?1nZLPFwDTHzoV/hPaG+kFg3cJsHS70dQ8gCiUorkJmV2HyEgYOnuhYIrq1KX?=
 =?us-ascii?Q?zIjq0/f8GUIxJ5IFm6karUq5sd7UVsSHdphEEKCspW5bsCTgxNUYbTSwB7AM?=
 =?us-ascii?Q?g5sfnVRWlCMQSMWEiMaxFPPPdThLPAZ0fqlSywC8ObtBZKS/R5OvS0AisdK9?=
 =?us-ascii?Q?XG2iyV2xZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f1c18e-da04-41ee-06cd-08de8486b888
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 00:38:49.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmsRYDQnro45wrLHbYwqzyCoiekcRh3GeknbGpN9bLcxOaeLJQOLZH9GKvnAlSlFB6k3Z3NQ7R+LHhMacTbwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

In the default built-in idle CPU selection policy, when @prev_cpu is
busy and no fully idle core is available, try to place the task on its
SMT sibling if that sibling is idle, before searching any other idle CPU
in the same LLC.

Migration to the sibling is cheap and keeps the task on the same core,
preserving L1 cache and reducing wakeup latency.

On large SMT systems this appears to consistently boost throughput by
roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
the number of SMT cores).

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c7e4052626979..e0c57355b33b8 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -616,6 +616,18 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		goto out_unlock;
 	}
 
+	/*
+	 * Use @prev_cpu's sibling if it's idle.
+	 */
+	if (sched_smt_active()) {
+		for_each_cpu_and(cpu, cpu_smt_mask(prev_cpu), allowed) {
+			if (cpu == prev_cpu)
+				continue;
+			if (scx_idle_test_and_clear_cpu(cpu))
+				goto out_unlock;
+		}
+	}
+
 	/*
 	 * Search for any idle CPU in the same LLC domain.
 	 */
-- 
2.53.0

