Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA74B8DD9
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089683; cv=fail; b=Vt1wM9sEpr09IFwwwrE6WpVZm9OvvcUXuyIy0JMbAfuj9sKV+WmC9FTaqjAQDRtJ381kGNL/nvZ4d8GEidW9FjoJTxEXgzFnMYuMLSNUh75OKWsS6l4y8fzVYma/zRRN+6vY/sDZfopGCagmd2523eEtb8pKCJM1VMfx8LaXVmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089683; c=relaxed/simple;
	bh=+lcXzadfLaGDTyQMz73I4WVWYJ+DAAAMYHwVoVfcYXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s1Ym69dSFiyyg0gJG7o+GiXfAKiWZ2DGcvqOCXLwtJhkfSmztFfhwyUJpkvWzHjWQfFRz1klO7pEUOnv3UQ/CUe+W7gtXgkJqeRswSPy5fAsC+4OW7VG/thL1sZnPtaaCrlUgm7dTndczWGncE74n7Wg7BxLAZ1w4LX4ps9sVsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJ1AI+3H; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJ1AI+3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiVVrSh4/gkxCqLXGooqfD0QMfFxdIB5q9U5jZzWoQaWezfeuTHHp1HgaeTNpB04gbMvP2SCKfqeEVwTwQxGbYaBjfkqPgGe+g03pJoBjO8YVdpE/u1BB7Pa5MpjyUyIXk6OQWFC+Uq6gO8SVOF3sadjJZDhONSEfP1B7trCCSRei0O5cwQ5zs5rV10EJitEUQvFefqkfYI920lqgOqOnASO8yCyJ5yoZZO06aN1FT8XflvqK+oFVE58ZGoWbQAS7dAZnEKEyhXmwpqSRTx42+YERr49qPx3EMRGzdEa2Rbf3iNyWy9m4ffBuq1iI8wuvmQh6SQfjP50zYkLftp0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htXhEH++GBR1NdBQ+JF+H+8Z5cQ0oRbOuEXdj3mqxZY=;
 b=XlbK9FhuaXkC/Bm3smUl12ONRL899QEEL4ju03DHIYo1NGrYa7xRDdt7l2i7RsNia3F7t9RlrdjV4tGc0BggA7Icy4a/ljxNPqKJonAax7Prjmik/jMFFuzMhTtwSvxlTdxMqf++oPPUkvawXijhHFbkAcp43TOsLTOMch+NU5+vaqRNWIlwstn3CdJOTUzP7rJtvHdmMo3VRDNJ+bTnoLVwgHIJRQRSslMctYweGofMMNCd+e9q0vJbr8+NAnnKWVSarmm6Z/TiuUAgAykk/gf/tMv+y1uqPNhA9ss4YTww4mJDfvOoR9TGtXtMtf2gHTYr+wOb4W2cM3+JElbkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htXhEH++GBR1NdBQ+JF+H+8Z5cQ0oRbOuEXdj3mqxZY=;
 b=EJ1AI+3H/4UEqqRsxdENqyj4RiNLkpgPiAada18FjYj9wdo+z0wqLsJjH0BxytuMtz7EHNEcO7xBLf5wcEziFgiWp0e1pAuYtNs8NYRv4avMEex4+FISNsVc6JVIbUnXw1Q+oiKIjC+NFPEJtI8zJC43mcABL5524Te3DkNVvEuWnrKVJRjvv5ug3qwwPSqINjbIrlRcFNmEZQnj0fAJ+Cge8cC5eThS9kt4tbhCUH8cgfnUhTv8nxtBvHt2EeIkwQ0Lyzn0H9oCQ4Zro6vKJihqfznNuYnyM+pjlO/ENGzebEc+gov9QxHdWyyHAUkHMxaXOorU4TotnJUTuNYEXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:44 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] sched: Allow enabling proxy exec with sched_ext
Date: Wed,  6 May 2026 19:45:50 +0200
Message-ID: <20260506174639.535232-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 311dfd40-a835-4bb4-8249-08deab9793cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yV/kJ56eJUBKlFmme7UdIHQ7s2joJ5CQ+1eMGukHeGpkVJSeIx+YUiKZw+B0z3o89axgNNzbugrAEopLrHG+TE3//LjkHUO92844D+zexpwO2x9BxnQkMHDcPMV66D6NvYy1o4TxhUcwxGXpN3hyQsM8wbikoTbzxof93s6l7rooNe1JPq+Zb+StlPYQyO0Sb59vi9RXDupetQ8jOUd3n5SRF0WsyohJAd3WsoqUh6ImY5XYnojSXdvodUaMksLOiTkglQe6ga82h6fI5lVo5Qh9CQQLtxivB3iJXslsLv3aotg4Uk3K35qQDQMPHaGu0zDVa6vj50QadOr76dHVTrGO45aD8yS5o08QqKKNGRYpFBum/PJRnZEpQSOhDSKVp3uDE7/yKzhvFxm1NY50PHM7scdz/9keuNKBN8nDdpusQl6jPLbfR3bHPq2z2ubZfuBAyZ9UfUBdhDFNaLSVeQPtBnocal6Bie4MZ2iIV0Khv1ojxvjGZFMJWp84uE09vIfzX8T9F6TVKreIza9VHgatBIZfgv3k+yzDecXuk0UFj0+xXfz1bwUjOQYoPdkL0GMre/6OTmT12Arf8/x9d16T3BpkrB1EqC60oy2TuR1+St0iqM+4w4MyUahRmtr806sr6LCE1wbx20rkHbXjYhSOfysy9ypnOemiz7MAQZuwgXCiRkUZ5RAwQ17bATo3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKYybTCJxMNKU2TcveKa1vvF7/n9NoKjPpm4FKArMnl5EtA/xf1tI7cRSLAz?=
 =?us-ascii?Q?DWboWL+tF4QFGe69IfEWrrY/3n0Hl7oJJqYLbO/qCI1bWZeWmJCawwk/711R?=
 =?us-ascii?Q?VvDEep9eMC2ZjvvcVBFW/E+mhpMlv050AkEmrikavzTg10D9i0Dbs+eOYvxt?=
 =?us-ascii?Q?oInZPxPnsCWdScfKl5yDJXsR6z3PGLRSPVT5QiX02nYjFYohWBlEUmEQ6KhE?=
 =?us-ascii?Q?znYjuMOGEjgtx297SQnYA954SrpRvW8thIKNk9t/SHCH2G4Vq5osYvxoV6zt?=
 =?us-ascii?Q?5i+PGghEwsgvBLontNDcNquZtJa0QSPt0fVil4sdMRUZ4NNVpKvRgCw0F21y?=
 =?us-ascii?Q?4vowMJf+dl6nD+KSQ2qIfHIjKSwa+ptdgQW+Za0DgN9RkWUeKIHQiun6dhMt?=
 =?us-ascii?Q?cD5RlCelWupCwCe2OwpD9PxdQUq8GThwJaqPQR6E3Pk1FnNpzmcqu2kt7hCM?=
 =?us-ascii?Q?B1fuMdajLAdmksUnqua4X4ZWY9M+LdF9tmbBuvXAQMKnBBlLzQP9OhNb7FVq?=
 =?us-ascii?Q?zv6lhqo/MYy0PFAoCcciF3CWRGJkocNbpa5K4vot5cpxRmKqzFiokuY+Wxap?=
 =?us-ascii?Q?wtCpn40P5e2pzXh3oVo1dRBwRyrg1BRLMHbl/OOe8FRmPMh8PnI4UofD6c6F?=
 =?us-ascii?Q?xfCz9yx+PL52QcWiHt++etlHcSktaA3Nov6jF/LXkEhyxecZAGFy/d8bMRsQ?=
 =?us-ascii?Q?vRP+se1s7ddIwxhVW5ukJGK2ePLLlwjs3U9fEKRce31lE35AHAOct/wKZX7A?=
 =?us-ascii?Q?mEhdKGZ1zRKiedazunLSnWqQkPHFBMpdNiVCM0i6yPdT4uuFryCAcMpT8Rs/?=
 =?us-ascii?Q?ajZcT0qotoWM7kz1K7jfssONih9/BUUqvnLLiNuLWLejU7NmpUESZ32Slbg0?=
 =?us-ascii?Q?WTl/GMU77NRc4HpYQfwYHpu+sHkqgcP4c5cNdmnx4VuQnURyTraV3TYjCbHe?=
 =?us-ascii?Q?1yeECWBWyHx0ytMFOTk74vh5g5HX4Vz/KfaOTa0wa1/QHryg21aMy/ROhFEV?=
 =?us-ascii?Q?zd1qFGQYqcZBxX6GWY7eNF4MW/PWUoZr1cnGNytVRYxM/NNOt6YO404IDIsR?=
 =?us-ascii?Q?glsnNa5qH8LQiex5n+GioLOCGgxEYdCeQf/yt92x3eme25aTo7XZ7de5TUgF?=
 =?us-ascii?Q?0ju+3VgsnIX5wszlXzCO/rOj+J3ebm3Kiqi0YVDvXmmQklNQjxmI1+TRigv6?=
 =?us-ascii?Q?0eG0bc1MpA36xhGmgmr6LtjEFevpB0N7uTTik23sIaRZbc4OdSEhVHZcMnbr?=
 =?us-ascii?Q?MBnx6fxP0j3LLMkjuGKEFeWKVjc2pcSwLJ3wgWE5/WlrV+XEdSRx5m/Bu0A2?=
 =?us-ascii?Q?nMEO+RnqfuJVCTNqclSwwitio3cAH52p+4DReBDAAQ2if4yhU2Fv9moqqfV/?=
 =?us-ascii?Q?u8f/AcBV9SqbqaYr5Xwa7j27FGqCJXLJWIlk/TK+YD+RKzJ5EdBFJUwLHLTU?=
 =?us-ascii?Q?ZLOHa6ZYbuXKvVABxP+0+UxR0qpz12r8+fGeod0ovFhplFYwnYTaIpSuuE1m?=
 =?us-ascii?Q?z7SITSZumLWpPDI6hbhydVhTD7i7j3hiowN2URMybO3Xn+xGYbmtQwbjBG5i?=
 =?us-ascii?Q?AMYWRAss7l1gH0MYHVnHCFhbTnD7kHJ+12OLzX12syxouvyGKg95/Y9/2BhI?=
 =?us-ascii?Q?haizuZxPseA3FlKU4mgwgJLKWEq8Og04DgrBL9TDsUZc6v5iQ0obrPCmHaJ1?=
 =?us-ascii?Q?bzTdXtppJQpXFkiGq9dm5EQz4/NBhYe7sd7IwBwSDcI+cnPFbXddR9Rk2ug8?=
 =?us-ascii?Q?J2Ow8aS37A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311dfd40-a835-4bb4-8249-08deab9793cf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:44.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW8MYahuoYQqb3HhQeYqY9nw4t84CHo6FZvwvK7nHJx2RwAugAxou6pusMPO9Gle7wNktkmYLHxjy4k3ejduiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Now that sched_ext supports proxy execution, allow enabling both options
together.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308aec..6b18ba7263f0b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.54.0

