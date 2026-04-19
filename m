Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506ED41A8F
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625340; cv=fail; b=cWmThbF9iA+LbVs+7wxjLqu06bpqXqmRghaG6NS2RbHM7iQRINPM6w7HsYT7Ox2aySPNqrnG68xiVkCQa1nXTAeP5bpGhlR1BAuL56agVqq4jI7WRP227WDuGCrRnHa7MlRZmmq2QX0F0MNwfIlxe8abca+jYN9fB+YQjsEfbUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625340; c=relaxed/simple;
	bh=O9xUdqvR8Gp9rqdpT/X5HYcF1Ue7/vWK7ocYCHZgQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iBYeF6BIb14rNRrTkvduRz39RWXE/s0oR4FlfqGHY5opuGXIzdsz/RCZLKm8YOTgyF6lQwAGI4GzYCqGplNKEDOA5gV0lLpyoHa0YCVpuz0LyyQcqPRDHCIv7m07vYRhr1WAJJnDh3Zd/XVgQSmOH8kYhhdVsz5OVJe5SF0fCrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9ymCOP9; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9ymCOP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxAiIotL/LS+SVjWt43cm4jv7saZd+XZ8wA8tXTgMJGSl7J7NKYYXFD8HQ74dkdSj50B+yO3gjkMpee3ovxHk1vyLg4IXHuMcIG6l8LO/Fa+kpx+tjyxluVQUm87fo2JriCFCAz/yyPDILpQuD7eBrR73a0YVIGsnm9RDcqKHksuEowOnHByYuZqNbbmBUSwE0dXIrxa56ruNKB6J5hXbNNzq4xegcFK4Zjl/lpx8fYBwAHit6ntcQ3cCwgt63kNAwoanUz3AQWm2W9xUm575He1B4p/x8CIa174vOgq4HX//4u5K3V/ETDvxSu/JgPxy7Wvg+NYojzmlCBxedP/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hluKL/h1Fh/jyqW0l1/FnQLNt+S/GGPYGtEnYRJvcU=;
 b=SRBL7GYYFJ/M47J4vL0qVujf1T9q8caztEhT+zcX5U2gVB7lTTW2JwE6uKKU+HcpKSqer18KxQ2UeUUFYMkGSNgct5/7/AHubyk39PcXiTvHwLAIs0TGYqB6mSyoJBdiHwKChkAurIY9h4IB7hueOuA6kENO1yg04tKk2T5T86BuWUBddVLhGIybhviPGhzh+Rq1hw6Rf/50Tybf1hVassXqZbpYIodYHsCUcUnIkKaeKDeHMiGXMh3G8NCh9B1Zgq0UNfD/HqpMR1ApYfvFqFu4yI7mcqQzGhsXYjesC7euBeZLkAKuYlb1ARbd4VxKIEs/7KMDjPNx9GwfSzIZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hluKL/h1Fh/jyqW0l1/FnQLNt+S/GGPYGtEnYRJvcU=;
 b=e9ymCOP9ngvUB6iOhqYzdfzmMVPP828c8w3na34Slfm3LnkwaNMPa6p/qwr707dK9mBr+bJGWx1oo8o/zHHuQibwZxsHJ9n6HErFPKecTEmyHH2HL1fqvvoCGAyfc9NQzOH1AacW9PWLRGqgK1kvKmhnZnsSejrmgQRvXmSPOfsJcIgfCeoP5rL2Mr478cbpTLauRcuYsitGJeeG9OdpwiR7tH+7i034AI6wDxN9FN651+IWTO9sEeSxWinsBizFMeJmcWLunhjr4NUm+Pjsf92CET5lixSNkquYi41u9V5DdShlU25hsrNgNLvKRm/FFzBGgzzUNca680G9m+9Zcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Sun, 19 Apr
 2026 19:02:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Sun, 19 Apr 2026
 19:02:14 +0000
Date: Sun, 19 Apr 2026 21:02:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <aeUms-ccHZhBNVKn@gpd4>
References: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 868ae82d-7d9e-435c-145b-08de9e462b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CkPBcPxO0aPavNmSHQih1RcsbvFJmrnQjOwckJb4Iw5H2kyO+2A0u3VZRJIfqftwIORI+yE6o4bZvYxeZQSJ/n0n0BeRCBW/OLwxSTL1crKj0OSrc57R+YpCK1ltXnlKXH/GZTqfCzO3G5IXUEXdhj2VMBjvwQjz0JZDyqM6dj166n7kCzmUSbdj/Mzxo1NeGR5pC3n2BjDr1gMHFUN5RubRvch8tDzXhol/vnIIFymiyG+BXyTslwL8Mpu7KMd2GfoWX2FGwKw6aM5dPugTg0Qi7vbaSkIvXVYu9iRxohCXGsC2kwhRVhxnVUskkQUIj8NiTQyQKY7tlD8q1JOECJf9lnqt874atAkLQufZCcsj4ZS0NTplTNIzxTmdrYZtR+/FbBMe1AQrRqzJpFGnB+X/KrpNTYA8QYaG2XJZbeSFHNT7em6JxKUim+u0TpeOuRnlaM4L7yKd9QBqZZ9U6loNmiM5RMvFaY6EQ6nhc+Xq/IuztflpCi6qZiGESXrIShKWT+YZXDTBBfakCcK3iG8BQkjK11qouxfrDCZl/nXofNcxslhEekUhq2jGMSo5721U83SKnRwjYmWZIAjSpcftqpwd15UMxlUWWAwCGcLLuEpnZBMpOa6+iHSsvzeikh5HS2i9DOCv12y9njLlqH3y8+YbzFUQdY7+4P1ZXyI5DGQ5NsRrLJQHKQ/KwOWOtvvWnSjU0SPIdOkHt72FRc1u8QFqbT1q3PSysjgJZEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2H4+U3ZAXPfCJrKpaAjiUTYuBxwgNhV0OzsFiQPX7fKeysdvl4umwz3WTIR?=
 =?us-ascii?Q?kO7zFG1QwzHIBrEUVcu9m3DSLsBol923f7yExcfjpjNg7Kq8L33jhHec5but?=
 =?us-ascii?Q?VpW3Xq+yHo6/GplEiS2mibnGpmhgMYZMgwk5ycKJutrhhzr2Z60GsygpGXNj?=
 =?us-ascii?Q?cwkbxKYyH6LaHyBbs1aTX0zfQg3vpjQc2QbiZ0ULIW5Em55IZcXHWcJGFor5?=
 =?us-ascii?Q?76yRWCo8G4jPVDeNn/t0jhEVZhPfzcs7RnFOF8Z04+2lw8/qvzOb8dtio2fJ?=
 =?us-ascii?Q?lqfA4PLA9Tp8xwq1hh8EljooeQ+x7qaE2kDFS6jWJKFBNZkWWUEklQsqSAPH?=
 =?us-ascii?Q?nT56maIM88ZGfKXVtwPyF3OH6fwo4Wo3bNGIDAnxPh7r3uUc6Lxihf5inYYn?=
 =?us-ascii?Q?4r8/E2Ya081MKv3dl8aznX2FHVjYQfIvMH/tXyvR/i9PvAwhGKYmM/P0geoa?=
 =?us-ascii?Q?95pb2utEXsebQ2yFwirE0vG5tIu9XgGy2maGQYHa8B3F9JQ7zTy0QkgkCS0s?=
 =?us-ascii?Q?cgu9xnLea3oMQrCWoPDBy4/aswAB3SnCOBb4N1e/qoELcC1ZCeRyWnRMOLRg?=
 =?us-ascii?Q?GIYCxAnQZf4FlzaKJsRaPaVF3mHiOrtoktlCVB8WcQ+bTpB7dHUhJhNd3ULw?=
 =?us-ascii?Q?GN153s5KHJ7OhgmSVPQ9p7xWLOzYBhrbvL68DHfspYW+dL4LUsk/TuVStWVS?=
 =?us-ascii?Q?GZvWeBSk4Ae5P9+v77jjSlcPLLFowoxvDnPb+vbUdRKtsGlQPsUwzLrxc95y?=
 =?us-ascii?Q?oxb7qT6fgvbs5qUJEpdzbHCnvvXN8GBM8BW2IxiwgUcbgcNKPN1Ijof6vF6W?=
 =?us-ascii?Q?wk5a6tnBmqgmPUBNUhOpkwj2RVsvNZgj78rryuf/2562G0FTe8qRx3/PmmOE?=
 =?us-ascii?Q?/UJnTUvta9Wv8F+fLFvN/JldaXyEpggw+T0mwK+pTfgGk3Pi2RVk73ZOMySR?=
 =?us-ascii?Q?p8AacTTX/R9a4YtrCWkn4fBWNYy6IQ2kS9747ODoGvfkSNppOj2SlKFgO8XA?=
 =?us-ascii?Q?dzzGSo4UNapVrBGckXrsbGPHBo7Hv2Min4HZn+Xj/x9aRrfyrimAEVEKvPez?=
 =?us-ascii?Q?QBLnD7sh1+RG9HY43cpMWMKSK6Ot+A9Yk+Xs80Bs0ECGFDNmPlQPzJ7vxo2E?=
 =?us-ascii?Q?3nZKMBWBxffQ4yzRzuiRkzbJCoAx6j6HakQkLQ7xRq+N0wVSUFxt8l/R+0+I?=
 =?us-ascii?Q?yPmdrI6o33JFXc+mNBF1RQxHRTSJ4XzHuBPYKFTKYnl5wfONYvQ++pq/hFvd?=
 =?us-ascii?Q?3+wSS/WbD2KBo/i63eT4Lj3P06GnJakH8AxvHVgJeshqvy0RDaNgPaeGrPeI?=
 =?us-ascii?Q?3lrVEcbRkj09aSL2pii7K9T4v5/MR+r7GRrk8U8Xwa38QYHRDe8ke/8BT2CT?=
 =?us-ascii?Q?ohTzFUKP9OUrt7vJJoGZd6ROuxyc7Bn6Chl96aMngXbE1s5FDczfAKs9YzsN?=
 =?us-ascii?Q?5dXa7LyGO01LAMspjT8JyvboyAbywJSFS94eS1HxXl1FquM3jzDdMa6OdWNv?=
 =?us-ascii?Q?8SFJBor/PSlIE6Fwc7TdRRFlazGy2p/u/2CwsiNvpWlwhJDUCmGNp6L6SVtQ?=
 =?us-ascii?Q?vNYroua+CqHxs6TExG3TrVH7a1OHKXCbCfzj8lj/oeYiVNxhb6dt4yPeUt7M?=
 =?us-ascii?Q?0L5Dx5dCgErg+I1Rr7Bb4AWLu+3H75/mkHEPBoiljVuvy+n8qpZImuOYveJz?=
 =?us-ascii?Q?2ks1/oUzh/Uc/Ybig3wCUktS3a1KQF1HvcFQTXCbRY/i17+gRpTDFeXACe4q?=
 =?us-ascii?Q?l3kN2lpdtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868ae82d-7d9e-435c-145b-08de9e462b47
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 19:02:14.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqCEwEfhi6dnV/fAZcZHzlrE95NM1LeDSjCShdLicZP+xNHKnm5AcowOpsxNOCIIdXXPKj+E2hBmawfeqGpSug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80

On Sun, Apr 19, 2026 at 08:36:45AM -1000, Tejun Heo wrote:
...
> +static void scx_tid_hash_insert(struct task_struct *p)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&scx_tasks_lock);
> +
> +	ret = rhashtable_lookup_insert_fast(&scx_tid_hash,
> +					    &p->scx.tid_hash_node,
> +					    scx_tid_hash_params);
> +	WARN_ON_ONCE(ret);
> +}

Hm... WARN_ON_ONCE() only fires once, it can be hard to catch subsequent errors,
especially in case of -ENOMEM.

How about triggering WARN_ON_ONCE(ret == -EEXIST), which should be considered a
real sched_ext core bug, and use scx_error() for insert failures (ENOMEM).
In this way the error is more obvious for the BPF scheduler and can immediately
exit if it happens (even if scx_error() is probably a bit of a semantic stretch
in this case)?

Thanks,
-Andrea
