Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794757731;
	b=g0vNTmLPkpJ4Mp0F6mzO7Y+3q7MpKWcE+oD3nPquA63jRD99wj1wDPYFtLe6usa2TckK
	 VlrALtD14KrnzOOYVr45CVBCxshfodB2OY4taxiwjpkLqGXvkmTgGexL9VJ4pZA5JQUS1
	 AF71wjGaS0GF6zTqgWBiLmi4e4LfS+riLzX1WmKT0bR90QDLZ4pgs2XGn8paICSz6SoJb
	 ZLn8fe4iyRC5sfeyT7XqyWFc/lfE7rujseqlKsSlk1BWsSK5xJFVE78rhldaYFbKF/OHS
	 fjkqXZG4TRwOfQq7ovKTUdl1WQTj+j1GIR4+ig3HQQryyYjqQAH4m6GUel4xSoYshRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757731;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OW9emGnBoCUYz266/7sJ3pjbnwJTg9P7eRaeka5d3kQ=;
	b=DHlA6ti3JbEwOvuu/HQQ92qafWGQsBXGyu97onxkNEQd9G3nrUrfAXPmP+RbOlG0ycQD
	 VuwIX052h2gKzhueYUNGAH0rdkj6EO3r0ViFESSoJ53EA0TS925IrJwysVSkhRdjUGPcw
	 kEel1il3FaYuwywxVTWbiQJE0+kNmBPwMhWr89A2jQaVdgcGXoXFNuaO9FtMX61/Rdzaf
	 yrkMa3pLTfwnrJNein/hF9fviiHlkDSYdsoeQ7ykdt0R6Zze74rCRKXCzMtESO9h5f1az
	 JQM0Pq77PRhszpIHB+fOB4aw2JFhvMZ8k2QiyCyQmDSUtLv19In8XvqZLsZJU/7OyDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sztl+P2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.10
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E19606A323
	for <sched-ext@lists.linux.dev>; Sun, 15 Nov 2026 15:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E19606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sztl+P2n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddUNcq53aM1QO1a7lAUYknftbSkq2IXpA6Ryap/Rx4CPDXHUJGqBiqyu3jNngj+fvQEozN3jC6JyUFALzWDTqXyZhpQtSXOtGtwAQegcHTY6BW6b3LV3TrEzBD3/P41/I3R4C+RUlvG61tlGVrnEDnGOg0EU+oczBZLUQdOiAQITdU6nf/asW98UoUQ3YmDdZKIfzgKEih+DmoXqYZ34yQ1X41jvnkyKX2IKyAeUn0VU3ZgbwSANU3aOXQVA9OiQBWa4kybrLNo79i2tIFghRZ0xZQsrXbHJ74G3asBhjgeTEgQCx76hOp72iGdDKK8Di5r8gDuSJHduoLOkm/EWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW9emGnBoCUYz266/7sJ3pjbnwJTg9P7eRaeka5d3kQ=;
 b=y1e425NJs+XjQXlH8GVzskt1BZQKCVMqKh8S155zLmKE1iF7fjClcmhY4EngfNGQ0z6r2oUKKDHmtEEbZOBKF38CpwBZXasdUVJN1Pj5bqDiMWl7vhWkZu2eIgdkmPJJ5Qp5GQ3WvD+DNkrAGftMbYy1qfVdjAn31LhwgYZPZEMBOlcyxpQmB/7FlZAfOLI852uLO5DO7bG5hmOgBeVsg2rMI5huPz7KvnUgUNn4jUNIEcarPUeCW9J75AgnhSlAuBaL0OtCTI5EdibPY+BrBzUjFkB0xQv4RYMtl2gT8wFsnxsessZ679lpKmBFLT3v/Y6BCnWzsUJXqaXADvmncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW9emGnBoCUYz266/7sJ3pjbnwJTg9P7eRaeka5d3kQ=;
 b=Sztl+P2njVvdqHXx3KLOSS3GM2WBgBdqdz0W1H3UgIWF/A64zbdBbHL8bHNqyyPg92qS65whI57NfEuLJwqXU3t6NxI/8w+pAMrOw+CPurtRWBWcGEWYOK4Dii2PBNf5DgEBrDopbbrSaG5/64sUu6w4p/jAX/iYpslB97qoJCmTGeuIOo/sJZY+1lQSD2cwT0k/UQsBr+mGGnnSf5o+WO0UE95lMYvNZq6QWcoWU89HwFZi/IMoWooPiFj9Ls9THok2Lyu1ZM9hZoQ0iaaGm9LwOy4yM6Qbde80uBHC+eNaFe9XAAIXt5A8sNUpa02G0NkLZsGttwNJc8zSnQJIiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 15:48:44 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 15:48:43 +0000
Date: Sun, 15 Nov 2026 16:48:31 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext for-7.4-fixes v2] selftests/sched_ext: Fix
 flaky rt_stall measurement
Message-ID: <avnUTwcpMLKf1LwR@gpd4>
References: <20261115-scx-rt-stall-v2-1-926678b214c6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-scx-rt-stall-v2-1-926678b214c6@gmail.com>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 325adc1f-ec74-493e-3658-08df432fed65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|11063799006|261022075727099003|261021121427099003|261026121527099003|261028144727099003|261022105027099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MWmwdkKurhbrzQ42clpkAKGbBtSBUCWsBC4cFgC6XtWVXnzatrw1EJcZEOSkOgOCNw8sdxASCVyl6zRJk9JkbvBrAJ0hxUZosazS4EM+bWSzc/et5Qe6HkoE2XFurLNIMGOaSw6RPtY/+brA+0HSiyIr+6t213sFs/cOTcGZc7yunYrZtPAL6lqNMJPosj7JdT8NcIEhjFRV5Sq7ufTcvRG7KnUnlZ7tJC4SWTNWZM9gZlUhk14l4wdjrkdihPHKY/a8abLquCYMtywZaQKzuztuOrYMBqZBq2tTS6xoayJKsg+tnU+Nre/2xM9Mohv3xL2fwjzyR3wqXWjiln4uahMFkTFwyL5G7GKnDS+SvoyRtsYmO/OSuRCWlrJy0bzq+V3R0WaZJ8jkAptp693FZwZnVrI0IziBSNYXL0DybwbIzzkm93oVMSQvf/GT1TBzP2cb4WxS/2Pd3OSfWxkYd3hwWu3wdod3OwU7AdbwmKD49CfJvR2vGnY2zN5zh+63JAdHnQGHalkuJKKyrwnaG/mPm0NliMgJkDczQ5G++GvWWJdL8txyYTKkqBzMvlJjB8l0qzOJK0K7gGb/XD4lT4+wOtIjph2VR8P1cTQLBmRe8P81s5EKTyLrNxWiyXRPK8bEMO6KlL92UGlFyfVLkYNu2ixIz2TSZURnqQk+9Ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tbcy5dQQshhKKNtqvz6Pzggckg9BVZGbza0n05j3A5R1UzK2MucVQpJ7YWj2?=
 =?us-ascii?Q?Embts+zlCeXLG5JXeBAHj50bGNdrvpsZFQ/CYXzHZtrcKZ0h8FlwOymJV8r+?=
 =?us-ascii?Q?gsvNbKU6iTOSBNmCfPdzkQ1KHitghJb5FCP3ICsqIMTV5Lnouygrr0YzyBi9?=
 =?us-ascii?Q?RsVWghR9TGUxxa6wL+V2gNtG4roW+ZVLOlhR+nmg2GmqiTIS5D7M7rFcpaSi?=
 =?us-ascii?Q?nViL1ok47b2U4dSWe8XyKntXpuefiFK/yvIn8d42tsz0zkhhm9eQ176j64ht?=
 =?us-ascii?Q?fsTJPwG4Axqb2YjhVoozrtO5wwxr0lx0j/aIdxjT+c0iwbY0rowtXcece3SU?=
 =?us-ascii?Q?2BZ0TlfQdtE4XOusbR5xmdMxa93NRLT1utKCHudG6W7pKtAYY5Dgbad8lphP?=
 =?us-ascii?Q?LwLHNOYAmdULc8FYAL6b5ji2F7MCnEBrPsftfLRzamatiNlUIyi+ucB9lSyX?=
 =?us-ascii?Q?bilsmjcRKdMFuq3kkgnvE94vSYAi+SZbVS9AE+RyRETVuYnllDCKdgYxcF2N?=
 =?us-ascii?Q?dTsnfNM6GN/ehiAqk72X0NEnB5aBl3Ps+fFQHRETTD7Be3wdnhUDRGfXeyfB?=
 =?us-ascii?Q?/SyxNG8rCxthc56/fmQEp/1yxQNxdlce58ESfkhcIjER6UuiJl1sIOXG1YzY?=
 =?us-ascii?Q?wJ9l1uJ+QlHpbOq2rx4JJaDgtbZylQfQlNU51G+WNorCEM39+/+LsAipCfZC?=
 =?us-ascii?Q?QXfrc8LPju++psW5ULAowvs5HVzcsTLzAfHHvHvxlk9eQy+X6Mb3JZ0m7LwP?=
 =?us-ascii?Q?dabOu5RefPcaSngIvIcVbiCaOGgQKr/JwofaIVItCyETpGV/c0GhYK611hxR?=
 =?us-ascii?Q?wkt4SvfxNQT90wenXeBguMeE5AHmJs/JSVuAy2F8h4YpfBS6DOUH0dQ7Aft9?=
 =?us-ascii?Q?S980owC+uWXZHxfxPRy0yR11+Phq4Ye8j9nquhq2ZshAzRaKmzDEelfsugna?=
 =?us-ascii?Q?nFeRmqG/Qd+O7A6K9rCf5bbzAm5+SjVbj6FiImnfvqJQmRYwrcd2wMCkK6ds?=
 =?us-ascii?Q?P8woDbkQNdEnfUIe5O20RNvICnSK6OA7nSiKXcIeuvIbnm0YIgo4Y14Dwg5h?=
 =?us-ascii?Q?N4WXNUNaXwJWC2mQm3upicXJu8ldbcXzS025d1c90nv6Xkj0/s1X0ZlLVzur?=
 =?us-ascii?Q?qsgTngiy+dgeSFtXmG30A/jrQR6ey2bpc55KYrtJyG4DmCed3eEHd0N/MZXQ?=
 =?us-ascii?Q?ZeHdeNEJtX7PnNt4LBaNsUVjCrlDT/ls2ypZLSOLozTQC1u0IzTxBieKDBmA?=
 =?us-ascii?Q?SGcYBj6Lr36fx6MaM7MhpVCDUJj8JN1Iwm1MXbFvySPJOndxsca7UfVBY1rJ?=
 =?us-ascii?Q?nONS0kOzO6+P2XuHko3yehzoOCI29g91fbu4CBeLb1wtiEgxq0qKTVtAnfuX?=
 =?us-ascii?Q?urmBmfmYvo81dF/MWOHf7KGR0+LTjOihpqPypWya7Dck5oK82s5z6SgSAzjc?=
 =?us-ascii?Q?H/OApth6r9VWesCoertVn+7qPBA2Tywb81yDPbY1qqWAm7azAzCuzX45iuL0?=
 =?us-ascii?Q?HXtYAXXM5CvlzOQkTzOIt1Q8GtrAvUC/DhzpQReiCEswlD49KVQ/rBhWZqgX?=
 =?us-ascii?Q?dWkKZy8W9Gof7d//JJwliV67MYU8AsrdwOEhTt4u4yH/rIv7kS2SvBkOr3kf?=
 =?us-ascii?Q?6fOn5O14jotOi38SsSHUFnYzk1AzZptMwOuDWjcJHG6cFETyAXygzrBwl3QK?=
 =?us-ascii?Q?p7MTxCEyjCNmnx6X1pQR4hCIxW+02hTfO6f0Vksrwpt2vy+P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325adc1f-ec74-493e-3658-08df432fed65
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 15:48:43.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33I4oVG+HfmONqh20ofnbiny117pvdIYVmb7e+3YMNFZBR6Aj3X8oUNUyOeDToPDoREgxdrt3BHsFjRgdzu02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

Hi Jonathan,

On Sun, Nov 15, 2026 at 10:11:23PM +0700, Jonathan Bastari Thamrin wrote:
> In sched_stress_test(), the DL server budget on CORE_ID is shared with
> other FAIR/EXT tasks, including the parent task when unpinned. The
> parent can also be slow to start as it has to wait for the DL server
> before reaching sleep() while the RT task still runs. The runtime of
> each task is read as a total since fork instead of during sleep() and
> is measured in USER_HZ units (10ms). These 3 factors skew the ratio and
> cause CI flakes. An EXT task got as little as ~0.18s on CI, which is a
> 3.0-3.9% share against a minimum 4%.

This may not fully fix the CI flakes, since per-CPU kthreads on CORE_ID
can still consume the budget, but it's definitely an improvement. Maybe
just say "reduce measurement noise" instead of "fix CI flakes". And we
can lower the threshold later, if we still see same flakiness.

> 
> With the parent pinned to CORE_ID, the RT task had already run for
> ~0.95s before sleep(), so it was measured at 5.69s in a 5s window and
> the EXT share dropped to ~4.2% against the 4% threshold.
> 
> Measure CPU time using per-task CPU clocks via clock_getcpuclockid()
> with deltas before and after sleep to get an accurate measurement
> window while also pinning the parent off CORE_ID. With the parent
> pinned to another CPU, RT measures ~4.75s and EXT share stays between
> 4.86% and 5.10% over 20 runs.
> 
> Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
> Link: https://github.com/kernel-patches/vmtest/issues/458
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> ---
> Changes in v2:
> - Read CPU time with clock_getcpuclockid() and clock_gettime() instead of
>   /proc/<pid>/stat to avoid USER_HZ rounding (Andrea)
> - Pin parent off CORE_ID so it doesn't share DL server budget (Andrea)
> - Threshold unchanged: 4.86-5.10% over 20 runs, but was unable to 
>   reproduce kthreads noise similar to CI, happy to lower threshold to 3%
>   if needed
> - Link to v1: https://lore.kernel.org/r/20261114-scx-rt-stall-v1-1-4188a9378067@gmail.com
> ---
>  tools/testing/selftests/sched_ext/rt_stall.c | 88 ++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> index a1552b38a6e8..c5027fd6b682 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -21,6 +21,9 @@
>  #define CORE_ID		0	/* CPU to pin tasks to */
>  #define RUN_TIME        5	/* How long to run the test in seconds */
>  
> +static cpu_set_t old_mask;
> +static bool affinity_saved;
> +
>  /* Signal the parent that setup is complete by writing to a pipe */
>  static void signal_ready(int fd)
>  {
> @@ -82,43 +85,57 @@ static void set_sched(int policy, int priority)
>  	}
>  }
>  
> -/* Get process runtime from /proc/<pid>/stat */
> +/* Get process runtime from CPU clock */
>  static float get_process_runtime(int pid)
>  {
> -	char path[256];
> -	FILE *file;
> -	long utime, stime;
> -	int fields;
> -
> -	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> -	file = fopen(path, "r");
> -	if (file == NULL) {
> -		perror("Failed to open stat file");
> +	clockid_t clk;
> +	struct timespec ts;
> +	int err;
> +
> +	err = clock_getcpuclockid(pid, &clk);
> +	if (err) {
> +		fprintf(stderr, "Failed to get clock ID: %s\n", strerror(err));
> +		return -1;
> +	}
> +
> +	if (clock_gettime(clk, &ts) == -1) {
> +		perror("Failed to get clock time");
>  		return -1;
>  	}
>  
> -	/* Skip the first 13 fields and read the 14th and 15th */
> -	fields = fscanf(file,
> -			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
> -			&utime, &stime);
> -	fclose(file);
> +	return ts.tv_sec + ts.tv_nsec / 1e9;
> +}
>  
> -	if (fields != 2) {
> -		fprintf(stderr, "Failed to read stat file\n");
> +/* Move parent off of CORE_ID so it doesn't share DL server budget */
> +static int pin_parent_off_core(void)
> +{
> +	if (sched_getaffinity(0, sizeof(old_mask), &old_mask) != 0) {
> +		perror("sched_getaffinity");
>  		return -1;
>  	}
>  
> -	/* Calculate the total time spent in the process */
> -	long total_time = utime + stime;
> -	long ticks_per_second = sysconf(_SC_CLK_TCK);
> -	float runtime_seconds = total_time * 1.0 / ticks_per_second;
> +	for (int cpu = 0; cpu < CPU_SETSIZE; cpu++) {
> +		if (CPU_ISSET(cpu, &old_mask) && cpu != CORE_ID) {
> +			cpu_set_t mask;
> +
> +			CPU_ZERO(&mask);
> +			CPU_SET(cpu, &mask);
> +			if (sched_setaffinity(0, sizeof(mask), &mask)) {
> +				perror("sched_setaffinity");
> +				return -1;
> +			}
> +			affinity_saved = true;
> +			return 0;
> +		}
> +	}
>  
> -	return runtime_seconds;
> +	return 1; /* No other CPU available */
>  }
>  
>  static enum scx_test_status setup(void **ctx)
>  {
>  	struct rt_stall *skel;
> +	int err;
>  
>  	if (!__COMPAT_struct_has_field("rq", "ext_server")) {
>  		fprintf(stderr, "SKIP: ext DL server not supported\n");
> @@ -132,6 +149,9 @@ static enum scx_test_status setup(void **ctx)
>  
>  	*ctx = skel;
>  
> +	err = pin_parent_off_core();
> +	SCX_FAIL_IF(err == -1, "Failed to pin parent CPU");
> +
>  	return SCX_TEST_PASS;
>  }
>  
> @@ -149,7 +169,7 @@ static bool sched_stress_test(bool is_ext)
>  	const float expected_min_ratio = 0.04; /* 4% */

While at it, can you also add a comment mentionig that the dl_server
budget is shared with the other EXT/FAIR tasks on CORE_ID (e.g., per-CPU
kthreads, etc.)?

With these small changes:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
