Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698B315D22
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421684; cv=fail; b=iffp7P9TRE38wIf9dkAqDlpEnuaEZbrxE1Ls139k8M7DJsVqVpRJC6KUbL7+VrwD+h1L19iooI6sGdx3UcqGhzK45tOxwn7agLsEtSQig8rT6dFGh+jKEscfG6bDjmmb2s8lA/e+Ks/MVulmnWAAvsN2OFKDHze5dHLn842SMAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421684; c=relaxed/simple;
	bh=wEoD+Oj2poxjcA5mm1vQYOzlcO1+anrC0JeAY5nLe/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQAQ3JbMzMl6L46zYzbHwIGJ11//oFWTfYe477c24/h7pADXQnN5bERyxr9xAqrCcvYXSEtR6gnS/+6sL/BojY/GtYPgr0ZG811b+tbcgNydR8E8IHYAs4A1NewxIsbuSeM3JjB0ZCLKDH/+ohfloBLukmqHODTfRlt/rMt+/Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzRRXWHX; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzRRXWHX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs0mVom5dj9jZhpOE7k+fhRSLjFQt9hTNNljrW533l5xwQKNqilf2vLMcQ9aIcIs/tzDJ7IueLRg3OXfhfX1q4yMjhcWvdIPQj0dPtAXlEihz/dwh2d/jORFLxZ52U3uYgCJ8BNwGsxydM/XG9+VB+pDKZ8U7FamSIfx1sSBuAl1NHwO1LiCYj9NuwN3KgHoeNuD9UCcGhG/87huPy88ijEd+FgQDiLp7LfQh13aJxfeCPk9zkvmp67b5zGnIyLID/4ZfzrWZx/vsewJzY1x3h6mnVIUOlqjGtH8SniAgJbnwISMvbks5zCM7UGff/ZTPT9+NERP26BRz67scWkyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vraHMj923dOF/x6qHSjS7PG3srmHU+TxIlouof5CcQI=;
 b=X8YLgZPnmzD3AjgIIj/Z/LAAllvMlcYJuIUfukstj+22Eg/uk8T7vYdztc2aJUWajl6SzaErdyV5CVTJPep0uMhg8u5QgRfXCqOTiTfo26yjwN0wt+HzuRdYQXpGhJFkZSDh7p+7CpP6yX85l9LtunleN2k4fM4F4QPQ1wirnOxaKGN8FJpjNA8Y8oDeN0k8KMj3QqbIibdt7qmaO/4nAip8vzCtSgj3sUqK0scBYk8eHiuRDJ8k15ro7eP9THllYlZYl1eVcEeKJ8TwcWahoPp+QmBWSsGbQtLzIX+iWJeck+dzWH/qS5md6JjzJrcq+IPI4QpC8X6z4J07Z3LQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vraHMj923dOF/x6qHSjS7PG3srmHU+TxIlouof5CcQI=;
 b=mzRRXWHXSI5kM53C7q32j1y/3E41kHWVoMnV4sbdoU3xdKByz1WGa5CQhlLvZTMvNRYlUYGfhvj+w+1MDIX5wGEI7Gy5B1/HdS2eG2KQTsKTIlIxIerEO+8ovlDFqSSmvH0Kw6Gnq9+xDfLz3kQa//1DfOUjEtug6v9zr3jn5vMfIVMbUlaxu3GY/f+4dxOCe/jMMpViMbmCOlYntX9uvHHlOLoqCMlsh9wgwKeZp1vZJy9pe6rbFHHN7pPUw7Co8zP3pPXGDzZ2V+TRVlu1v0Iz1w57hKWyjaDRU9Zj2krxc1wAhmMQvybWPSrQB1q1CKtrT1/3VhbIcnYlGZ+H9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:18 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] sched/debug: Add support to change sched_ext server params
Date: Mon, 26 Jan 2026 10:59:03 +0100
Message-ID: <20260126100050.3854740-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 482e72b5-4fad-49be-de0c-08de5cc1d8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBKJcZhWf+IzC9OSptkbSSTERq7LzMBdV5T7gtHOMB/BuJKnHkCllepFaqik?=
 =?us-ascii?Q?DdIcZyyaqHDNVplb+4EYyvDJyXSLWEFgGdszNxIMYPB3XqftYe3A4ctQOZ9b?=
 =?us-ascii?Q?3uRqhX8+N0dQClJoMeSF2ygt2WFeYWQGuL+G6aFnatQtKmozt+E6Cv7Uwf6F?=
 =?us-ascii?Q?/bc1izXH2/bUiavL4K++Tit+et7Rf0VH6iMP1dTZSZug3T4Z8xn3es05eARD?=
 =?us-ascii?Q?Rpje/bkPgsSnh/+TbxlY2V+1EEXkE7JjozK7a+7uVooPT2FTlMRkJtOjBroA?=
 =?us-ascii?Q?RPvwqtbgy1LMSKL1/owtnIo3+KZvEEfUQIl+bI9UoCrszWdjXAZZ/hJ9y9c0?=
 =?us-ascii?Q?eXBrhrXxW3da5zS2HfD4SamRy0W2Z+HhV348YcOZgVz19RGsTM11Q/IOw03M?=
 =?us-ascii?Q?2Mu0kvBI3iKwSXHg8FdF5sS4TNDHOyBitGrb36bBwxGpxpam2Wisiy8FdL2Q?=
 =?us-ascii?Q?wmAkuxwkpZ8WZIk/SmmJRNlu50cWfnhbNxmcAfzRVGFCefGMGspmNT4qtw2p?=
 =?us-ascii?Q?JqqCs6S7pf4f1+xDlgGXCMs2keuFNyrO/wqUFOqpbwQuiMA0IBm0gTOjv0+N?=
 =?us-ascii?Q?6wwbeORk2fNai76Tw4+/2UP1vGjS8TiwwAvcYvyIdt0Yz21IvEFlzbfSPou4?=
 =?us-ascii?Q?G0DLyNybYPStE9vu9ptwJXFdy2dIaZDjLbFbOybat2tONGiA/tnkH5bHVZ2d?=
 =?us-ascii?Q?RBzbR1ZG9/6NL9Y8phFa9DgTxtoxTSodsmyNzXyBGcGdtcltbznUFEogHhA1?=
 =?us-ascii?Q?KsF3nRgSX0+r1zb2MamY2hU85FlE/khOe1CzkDBynwbCU5JUJx7Rlbb4oxcA?=
 =?us-ascii?Q?SrWaODxWFVS4VgsDwDNPzpz+iWr0eAcJwjUo+zA7kHlXwPkc0SXhOOupqPzX?=
 =?us-ascii?Q?KkL3xBD7YWvF0Ndu00bXfqn2Ctno+LOOYv4Iczfwu4qepxjlcoLMcxupAw/C?=
 =?us-ascii?Q?XI6SGH1V/wmtazCLyHq3dR89aJpTn4DKvXOcJ0qo5suoWX6cSPO8z2JRfSIe?=
 =?us-ascii?Q?CFSjSGr+NoaJ4ssuS9/JTGplgf9xVUDjMnkkjRqFiM4QHx+G+OOk4WDE9ICx?=
 =?us-ascii?Q?1WBZ6Omr/NTM2xx84kzbSMoIzM1GSvFvk+pDZeJ8jzOnQ7guxrKYSbnqA0FY?=
 =?us-ascii?Q?Q3OQZ9D18+uolKa+zcf0o0V+TFhmCmS/A9kfLo0lgMYnNTN4Yj3+KiBN7hol?=
 =?us-ascii?Q?z/Gg3cvzabc8l2KSKKq136jXEAw+errpIuSffoUJEQMQLEi/utEdZv408zjc?=
 =?us-ascii?Q?BRbJ3Hu+ZOQhfqrvPnEVmeS6wsQp1LZie2y65kcmCHPsjA50VuOEjinKFm3X?=
 =?us-ascii?Q?Vp6sQiFvgPaWMuWL7g0OFD7oSvxHzKvTMCn5PWark4sxwpuxuHI2p1UYUtoW?=
 =?us-ascii?Q?YIdx1AN2I2L5Pp4YHUbXjAH3qwJ0e1HjxiJ1zlcYzBOJ/HANP2dqZXKE6c65?=
 =?us-ascii?Q?WLEx2J/sQv1hiXt8P7ic+uDauxjPRwXNwUa5WplXf9BNZsFBl1txyGQIpmrX?=
 =?us-ascii?Q?U5fbfhFz3nJo//IiGOZOhRiLdZtyF2H22dT8JNIwJfbIvNQobxUh/VkHOxa5?=
 =?us-ascii?Q?izIOQA7MohIvNFoxxPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYwaN9Yx1jhyeHNYkpUxurnqHhXG8naqvotqgOZ1Z7MEqKkHu124f46Fx/yq?=
 =?us-ascii?Q?Lwzr399ptahMUcvASZ0esVAE2YuzuuLJNFqCXxebBBX4Gze6ETwmGfuufobe?=
 =?us-ascii?Q?UwlWul5v4149PD7FSxpGxAi2ifLMMCbR1fF4Qd1fxGpCDoYW7nAeoNjO5QG8?=
 =?us-ascii?Q?EQrlzgBBMdBVqljNfAWuLJVhleu44/uHvqspUoBvh8Y++h44VJGaNgMScNkA?=
 =?us-ascii?Q?LucxxfoEbs/14R+l8ncLEz8Tu3zmWdI9np9QZeH+eCvNdCDmfggNiK3lY1FP?=
 =?us-ascii?Q?2ehxqhTYwwkBM0kskCjT9uzHTBuxiuZkf1oduEacEf5LOPG+qZPsJwhafhxR?=
 =?us-ascii?Q?Sqwu9S4F8hUBPnNBv/XKvYyUNLRoOPoQQHWfVQP+RoLebps+ZKmWloQQ/Y8v?=
 =?us-ascii?Q?5ljbeERyZja+nkTrL3zkQd1LpvCN4O7d0EUKc6w3pFfK7KNSRSe410wIYLnA?=
 =?us-ascii?Q?Ua/KOdbe8qx+hzd3azXPzOGewtz1z97M1rr7rlTYQQUiNiBQVd/a0DwVwNbf?=
 =?us-ascii?Q?xVv9zbVzyMPbw3oCWdt+PS/84xicWok89a6quSJx1Y9CqpBQITYRAygQO84b?=
 =?us-ascii?Q?Vc8mPY+v2cQ/SLPHfGjOI7wkgOKsAL7clAx6wVX27AXKEXXujbIc6wgPBxLa?=
 =?us-ascii?Q?RZWWcwEOI1nv2y7YhYDVCc9jqCHK7aCrPcsMRoM+gcCp2mgVG1fuUAQLbnIK?=
 =?us-ascii?Q?nKEh6pXt5vCzbb95ev73OZDUsLKssypS2zbAuIHlDerCiS2PMz53euZIIuUf?=
 =?us-ascii?Q?/h/6Uw7PBQEF/u0OPvlex17O1EN4XqPPb/7PIeomTiF/wlX4/gN88CMcpQ8S?=
 =?us-ascii?Q?kzINMoWTon8E3c7/tQMuvDxdZK4OwVxjtI1bs1NgPW9djaVmDXmD4LbOoptg?=
 =?us-ascii?Q?JTqlPgo+9VM8YbbsAa9jO3SMiBqn7yeh7o6TYlqOIKzRwBvE4DmnCnKigRpu?=
 =?us-ascii?Q?Ff2GookxQFrq65h4XsZ61t1rd3zZH/g0agYTbSAHdZw/Mnli0VsKcDMiOtdi?=
 =?us-ascii?Q?XQ/XO0Ev27Mz6w5a9W1Yh/SRQl8rbxeOFUaYKAv4G5e5B93F6TPdaxvQ8oGG?=
 =?us-ascii?Q?EWWWzCrGJbP0lW1NPDxmcuxso9t7yfJlP32M1kMT2kpoJ8TwuBsjxQ9fS+37?=
 =?us-ascii?Q?x5XdzndN6g917ITs0X2W8YHGZFU7ijhZRSs2Fn2uoiV6qEZBeY6axB+JQHMw?=
 =?us-ascii?Q?RJfI56Z8Pt9/VY7IL+kj8qs4r89JGBU2Y+dpzk/oRXbxBOtibqKqOXi2k7Oe?=
 =?us-ascii?Q?yYHsk5Mr2c/CIcpkJs1rLWjcvxK/mZ+5nCpOQKkWGGOY1Dh+lNWtVJQodyRQ?=
 =?us-ascii?Q?Prl/9uIP9dSOZ3vNlG7L1azijs/e1Hz0aGmfsy4ancPtQfJOpNhGRuh6Z/Tc?=
 =?us-ascii?Q?vFKCr8OpP/IgiKgN7NlqSwJRfY9uyvhsmVRxBjGXxWNJgQ5UhqwmEUBwJLYO?=
 =?us-ascii?Q?DAytEaDnJq4qqmDmOqYWDQsLJXsyx4sYvYDj3+beVWIocEefim0SWSn83BOa?=
 =?us-ascii?Q?zRPXhgC1wK4vCtnzLjJIVoF1Bn6+9QI5el6Ae3JFWjr5wyVlJnCccmYO8pnR?=
 =?us-ascii?Q?sNi9ph2knVEE3MIOq9bue5Do/DhotsQ2wB4yuuJYSY1QSQ/gpw+v/gFRCvrN?=
 =?us-ascii?Q?4TlRts5W5vb/vgf14N6O+DObv769tqiMgqQ9+5FVF3U5uVD6y/mKr4BDknob?=
 =?us-ascii?Q?YnqaTgNSpey2ZI9Pl+tPY9MTolUJskkBQeApBnmqfX64yg8i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482e72b5-4fad-49be-de0c-08de5cc1d8e8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:17.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6GYcTo27aq9EZ9ndQvGO3cxMl2Oli5l3itvKeLY/I67+ezHPvODID//5Y6SPeIjBGxW4gpNhbu2ChK1qsE8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in the fair class are
automatically moved to the sched_ext class. Add support to modify the
ext server parameters similar to how the fair server parameters are
modified.

Re-use common code between ext and fair servers as needed.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 157 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index dd793f8f3858a..2e9896668c6fd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active && runtime)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,57 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +520,40 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +577,29 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +638,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_ext_server_init();
+#endif
 
 	return 0;
 }
-- 
2.52.0

