Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CE577E38
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096163; cv=fail; b=SluQJqWZq9XJrX2QRZffqij6i5yqzxnfQrtymmeRau1FEbO3/ajfIS/AQNr0emwK1UXwrNkFX4Kh1dWo6rvYmlQB7TNaF6H5h5+E+X5lALm5WlPsqtzHtrHzJPw23plgBMh59JSB8A5Oeo3rI/FeL1MU+jrb0/NbhrUz/TRqLFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096163; c=relaxed/simple;
	bh=xYvnzM2nzu7gwkH63VUSCauAzfPdLt5wPQjzS9VVAtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYs+b8WzdyhOa1J6L6VcGQMxHMWUll/OUO+7h6nHKU3kDS3E0vvFisgz9EIAPQxSZgLG/YBJV17a2Rcluku8MyRu960Ry6FOaQvAu9fVaG03G9AQ/uHe3KuPxNdnUL9AA+H6WfJ+ZTi5QO8vcpC0yTT6AXPiuCDIksv9eSfwg2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyHdgKMT; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyHdgKMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foYgtrmmI250e3Ehh7/XCozvDP9+BpxmCkiupJFSJXQGgpi9rLm07bbofhb7oMDENzBTj2TIFx0TvRxZrfaD+Mui4TfjvyYtijmTY4AuL9NSSIjA+AR8m9rKNPm8/20r7ApugES1Na3/viJuy0p/Iuime2F7baQnKZfhLs9Zoxn5sP+ZLUlRtvSFRkilbB+oeyzgUD0fENoyq7d4M+ig/1C9X1VdlqtM4n3GccrOvijkWZ5ZboM0wrFhyy7/2c8wZFcVb7RthgXXAQZ527wgM8pDwSRLobZ3dagyaXFJssYox+9HZLHpf37JLjgsuOyYpfaOmxHEQ3zAQnNvT1b6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HpVoXHfVUxlfz3nNPyO2pE3tbHWYgb4nJeUUekwaes=;
 b=mDXXOtKLP3lzlBg9v3YHfMTotnDbhPL8bM2PDpJn5YSTGD3GRdDUj22zlOImJshkM/TEu924gQ5pQDjRPp6w5CvWpt0ll13P/H+80LopxSN5pTGD3CazzH5pqUAZOceWOGfV5NW6FZn5u2ckEC97KBIrNhpzMZuNc+ZY7J7P8jz1JuXJqI0cConfOI4YTvHI6o7oRj0DXOFLcmw1X1TBZY3vjC7LRuUKCJWRl3B1jxFJW0TRz/85V0k5xm2jz1FOSkfCT6UQAeEsYZqOxoojup+k1kjAXIoJiR2KHTutd6bPB0EojDz+Uj7eDHqMs4DBX6ohyiR/AxDbJl7ubIZIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HpVoXHfVUxlfz3nNPyO2pE3tbHWYgb4nJeUUekwaes=;
 b=YyHdgKMTwnhaIEFMiU2XaQQ7Mu+EGo5I6U6qzfSXGLeOdlDn0siymuiJekwUBw52ryY1/zoxmKd9kYLRHEOIWYAJheTx5Oq3qZsYQFo0ChL3AnLL2jpF7yfFxTIa38g4TOIuvUIDloSCH92zlA5GewrkWLZ1S2HMSl4HNg5CX2yUJpTAHavvMO6tBMImVzcs31a4t5PccdcC5JhEti0EzL7M/zgQwYCIGCimP8yUPiFyOXMlZ4MSx8l5nijWX1KTEhgk4wjUl8Wn7dot71nv+dmP9jU9bxBHmel7GFQDJbYy5QBLpXGTnJYKI+3XiBLxbd1iq2HC8Mlbs4geuqzAuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:56 +0000
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
Subject: [PATCH 16/16] sched: Allow enabling proxy exec with sched_ext
Date: Tue, 22 Sep 2026 18:51:55 +0200
Message-ID: <20260922165445.943315-17-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: d72571a2-93c2-485c-a366-08df18ca5ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lXUmoaId3L7YTweOisToxiBnBzKQfSCaYGvVNzB9eu7Q+hwu1+bdQhdmqUHPSZHOz1pwEawLGkx+1uMlEmRJq1iOM7oSdsMVcfcsBPeW8WDJaDhM2xpf5d+ZSD6W2LBk1hLk/xCbX4ZJyNywACScjmMhLINVy02h8tpV/aOykL7uvCyuGAGn00qsnaBF8DpUAnUyVPBoocpcxwmmjvNoFfbuAQKp7ERffbTChIC6IL5hlakgG0xmg6tXX8swrLEUc7AoSQwUCbf7yOGgcrl6HTzEEdnTGZxUoew2+I2+pJU/cKuNfg97AwOmLrvlCZBXiYsyl4PqCoLFxs1Ec7UGvZV7tiIdUKFG+K10qZaD1Av96WGOo40PhhVtxv0NWxGJ/27IDsQDfPgmfS5HYXDJqxtn3j7/h3zK9dgny84X+M8n6d971dpQm47E6HBJAAt4I7FO/yG3XNEQnFQicAmcZAlh48fOZZghY1spKl9+KX0RgtAMvNL3Yg+AN3CYgy8UZ2VedVNHipTuwsR497yvI5vJ3CM+8g1hix40qgU/90AXaN2UZLlw2cjOF0rKJMkYMG7gvaJubgUY0il559mJqQUy7J4iwfjWxya6B8zg990Q1+X8XXNDikCVbiGFivNMmxXGnSc2PIk5uXVlmq5vHJOmJ/QltCu2niW9GCaUkuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7DA+OY8js7IN03b9S1/5h61Vmif0rxYVPAWlW1cBLSbDJU7iJwAq2TFoB3c?=
 =?us-ascii?Q?EQd2zqKRq+PKQ9oGVGgX3kDM0ubbpBX/rnZ63jhcurMCZF2nWYG5SXluR+T7?=
 =?us-ascii?Q?2t14onTtJd6l1XLte6G+HY7RGW20h9QcSxrE3g+5AIDatHuFahgaUHEIZvqy?=
 =?us-ascii?Q?3PM01wLYLL2hmBk72QHBLsmN4j18W0v9ah1vQYRXNCaNgtfOhHSQaOxYyNv0?=
 =?us-ascii?Q?WhnmYmrjJGu3Hfa69WgGvZW4KWe38iVIrfViDOefLTimjmCjx/7saIPfmFkf?=
 =?us-ascii?Q?EcnKD+C+cGNKlyGSsSMoc/mHM7n39/flm/6JNnxf6nzQQfc9HyoKvNGJWTSc?=
 =?us-ascii?Q?D3BFAdVb+ySypgHwNxkdRM3JB63G82bAaUeyF6tclG/zJNCuydcTFKn3sS0m?=
 =?us-ascii?Q?uR3bz0ab1Rb0EHrtNBDbaELSCX04/9UGTe4fXpWoHn72uPUzFvheMqAIrlZm?=
 =?us-ascii?Q?8nefnRTyU+V0Spa2mPQejkba/4ovIwhIlhNF1kfiWzTlbKV/0BWhiiOxHg+R?=
 =?us-ascii?Q?rlM3wfdX4m3rpl0kWh2DKARGx1flWoDD6ITqva+XC6w3n/ZjIkR6MEtdKAp4?=
 =?us-ascii?Q?aC6gBISA6tQpm5cN2MF+ofBzNJTzG2lcOgfTE9cXA1bl0GyDfrPMGGIJxd9f?=
 =?us-ascii?Q?ufsOojJZcovZ0aKe8FAmiJ3DjFKu4er7syWxCSpCerif2EXW22ZTt71jpC0P?=
 =?us-ascii?Q?jnsjHySPlgMaMdycq1BZCG7BqUxZDrHuMJh6pX+5AkmwqNUD/ABpdXug9hRV?=
 =?us-ascii?Q?qbKfo9Gzus6ZtTdnWLt+EZ8etmu9VKekWO5vm7rQ7Qeodd3HsRWA24HLyGSh?=
 =?us-ascii?Q?IPD63inwbXxVKf3GH2HLzqe+wWoFuCQk9TluCabcsgIEoTBq6cCH32Hv9g1a?=
 =?us-ascii?Q?Mv2fpSs2GpChBOuSvChacGWlSpU9se674lODlJXjI0Xh/fekoJkdAo6jy+W9?=
 =?us-ascii?Q?hOux1cApC7wmtsvYBX4PhO8O8z5bK2YUsYccGCBXssSLDlzSIaAGB0VnK0lr?=
 =?us-ascii?Q?4ncW9Okzz89bwm8gTjTzQZPEsbzmXBYMaVaf6l9DDseSOutgVqSdFNnzN36p?=
 =?us-ascii?Q?43zQel7zhFOVrm9STcizWL36fZQff6RPCZuzIA6gcP6GGVfVltjE05WaORvV?=
 =?us-ascii?Q?h6KoIxWJkPw0QX+bU/NTbvzeznX3IvWxFSycBiuCdxrHELvLv67Quf2MUbD6?=
 =?us-ascii?Q?B/Cktlk0kUIrwvzKZr18+E8pykU3eW0AU8n8oz2pTfwxl11cbcv6YZRvmtQX?=
 =?us-ascii?Q?oSu9ellLBJzCymkRBSAsb9zmzkr60WYlJiVlPbtYkYnfXeJUyGa4fRvl2uW+?=
 =?us-ascii?Q?lOX5pYUXpywiBChn0l7av1jXTjnlr5FfOJSyLDqhJCNn/xqzSarnRtSmqEnE?=
 =?us-ascii?Q?TijlKLzvKvnWZXTL43k+2Wh/MIfut+TtpnFFVGHQjmH4GX55L6DBRLgsgX36?=
 =?us-ascii?Q?Jrv0bypzcQsp+g0zDV7A7QwWNcLoBr0YoEOMl8Efj6sY9wTOdbFheff0YPeq?=
 =?us-ascii?Q?FnUjO5xBkSdjSG9DIBxHVvrc+Apcg53OmW4LR3StNHZArPspa1IDsw5k75DM?=
 =?us-ascii?Q?UQdsrTitimutGbgZtsmTAYx4G580XxwX8SkOg4p+1ujDVolhH8cwp82f0SEu?=
 =?us-ascii?Q?ssZinNZDEob7ZyevmbIaurAo1WCuOj4UvwuD8LB12jHd+w5JbZr5ZklYk/SD?=
 =?us-ascii?Q?477K50/66ZD49JQX2F3tEzYr1OfGWUw+dtgNC2Qc7cT/XNw+VDE7jdJ5BGom?=
 =?us-ascii?Q?1XihWI8UIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72571a2-93c2-485c-a366-08df18ca5ef7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:56.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzamC3JEJf9q+PeltoNcgzNegyUDpcmMXIbxyntoEjTmJcAMVrmMFzkSa5+2gt18tANlHcYNNfiURmV/Ozmt7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b53216..f9358f15a249c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -937,8 +937,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

