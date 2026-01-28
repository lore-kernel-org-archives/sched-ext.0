Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B802DC798
	for <sched-ext@lists.linux.dev>; Wed, 28 Jan 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597627; cv=fail; b=gNYXyE6PR5uHjpE/gTdLoK1Gxz40IgEH9pRezruF64J7I3ueUT98igAcG1sUpkesvQEfO3Zh6CzKfqpfW7SA+SMoqdLTU4h9pKFGT9CFGnhQHBfKW4FfQ4IAsvbknwVAhuwgfVPDBQPvO6Je/bzw1ny05xgJbuK6vyYdjfQbrMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597627; c=relaxed/simple;
	bh=Gkz+/SwZOsHdnXbA806xLWZlBVknYiPaw2c3x/FUmsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WVPt/eS1tE5sQ31/MIiUGt3M9ATTX0yFGBILaun0ffuHwtYMIWXuFaRhmVJsvUSz1rhj6ll6KHk1ZY1GiOvKdzhErlkEHCHKTbJpSUPjULjyMVG3tZ284FFcOJr+M3afbGDTHq38hEuD0lJx7cOSHRhHK3ofavCCksdJ7bw+Dns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adtLE98Q; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adtLE98Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctdcKTVZ3jompnvSfkUOtBEMq59Lt2QmI4/zVa0fMu+foIH5zin7blH0Fa8jmYnySU/q2X5o79mpicYoj8CQS3a8lPquRTwJc4+mG8r9GmTPiDgVFka5MDhoQJCpdVY6MdQGii1ihzJk8cF3VhMKL62+jeVkTlPSPervWnlLn9ncDhf2EvH5LBudnkjK7TOUIUknJnjBAXUNNFTrMsSymGvNLva01u97A26glS9S5ChNsgkyOZaoxwpGysd5aS8OjjIgfW9BBp2Ma0ENatLr9YoJ3n9dN9qsbIEv3cWiNoa6Hc7Y4pwv2qDlxOkBCgerRQGrMiZeZf9U36Km002a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asUyLKXvYQlyhjXJ8f5PTBitwPUvTUS2lB8DO2qGSSE=;
 b=qXx2rYcr//NohsSu77nIrH3SDIakqYgV7BxsDEgGyp2h3rU7qV7vmTu5A2FrgtaCngw5QRU7ifC8H4IpBVGNgkWZa9OgY2aHR6LZN+4f4ENc2tYbClpx4THaPsmO7X5kxc6YyOt4yfVInPQKR2J1JRQr0VaveS97HwXmsiFMBnIwUkcrz4nlnQTuT096ajqNYcd0FeSMuAUDRl7E/aMEDvgwXaHlE+ozG/ja+MF5bp86L1a8YdE/b4lPJ3bNmAJSuIxa0MHySWPTAQdxmjNAy/9f67GvLTMkytl/BjjjKNojk8dMuAGcBNqdTC2RJJsrHtzWh0YbalIbqROIqV221Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asUyLKXvYQlyhjXJ8f5PTBitwPUvTUS2lB8DO2qGSSE=;
 b=adtLE98Ql8ONWiXn1vV51EdGw5Dc6lND//wX1LKsJoZjTi6iBq9FR2PeeBrmUQd5502zfolG2ygilRwEklRSDrTXHkhWbIF8t/jvJW3XH5jtBKwcEI5UQ2pH+GqK925Bn7EiXP7GgJyxW4j7rspUIWFgS33SsuRkO3YRqWepC9IZIUo8zuh4MEFhJoruP4ZgN2yuciHzYNXHCnzYaP8sZp8ENQlbZn6gx6lbDs+yvsy+O17qrD6DiY5xORle6KT0fiFRrCcTI5aPYjeWiklr0Hwo8zdBD6IkVeCy/I3HlSaotb6/AnUEvuJcOle7NofL+rYiqLtMrYbKZ3Kp2G6dfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 10:53:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 10:53:43 +0000
Date: Wed, 28 Jan 2026 11:53:36 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Daniel Hodges <hodgesd@meta.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Clear direct dispatch state on dequeue when
 dsq is NULL
Message-ID: <aXnqsCeN--uzQQ8V@gpd4>
References: <20260121155602.598130-1-hodgesd@meta.com>
 <aXFA4-b4WLPjxCME@gpd4>
 <aXFukGjN0F7W3Hoa@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXFukGjN0F7W3Hoa@fb.com>
X-ClientProxiedBy: ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e323cea-f6b2-4cd4-a396-08de5e5b80a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXuJ7WM5ivLECz/BbndJLxe1xFjSyvd1tT3eUOPMG2tAghQ+R2F0EiqLTXD7?=
 =?us-ascii?Q?ZmflvfUHWl/yvPoRW/2yYF5udlfWAcjkQIo+M0ueUuhCePRYGZ0uGHzZNBQl?=
 =?us-ascii?Q?uHTqOTCGRVtA6Jg0uN2fJI5NiOxpm8d5Nq41RRP+8ZbDO2bFNJR3euFKUFuV?=
 =?us-ascii?Q?vQmvfouC9fRImhb/3Ey+QgPWavsXstO/rZhHanZ0/YIoBAxM5rvM2VHEFJmM?=
 =?us-ascii?Q?9+El8Jw4x8ahzu1aHJ324XUj6SaFdtRlFKDAcCaRN5eCWolgl+yxhBJfMyqd?=
 =?us-ascii?Q?8B0xsrWq1w1mwqPcPGS2SYWzDRcDL6GK0Oc5v90sKTk4LKfN04xOGYaOpPRE?=
 =?us-ascii?Q?SgLZzQmf9UytBiAzNynCfrNkAsMrwgb7Z3YyiDzDpnwGqTJp5SJVxeDIIoxN?=
 =?us-ascii?Q?PBJfCii++xV9TmdkjD7xAw+wRXmGhmeuBhbkv+JakQDhQUB6FL6YWt8qW7qZ?=
 =?us-ascii?Q?+L+hAnk5OmXWfoQNMC1gwRJqetkSncsXjRCifUNq8AP7Gd5Y+iDrnu5HtZz5?=
 =?us-ascii?Q?INNlXgs17kWHncLgy2YbMZa6NNdQMbFH9mmyDUFfY71srmrX+9aMcHFA3/pX?=
 =?us-ascii?Q?VD+h7Cc598dD/jqUM7H+NjMGxaRzKSHCD2QxpPB+sA9Y8fTn6bR5ARbaSYop?=
 =?us-ascii?Q?FkXK8AKOULHU0YgH/pcgu6bVfUPUopYPgmNURDOa5aGi/w39Ei+EI9BVK5cu?=
 =?us-ascii?Q?wCm35QxRYOF+8udnxruKieWNe2y+QRHGZeOKtUNGKUrn+s3kRcVASecjh+6I?=
 =?us-ascii?Q?IL4+P1kWqxGXLxD/jleRubnbdC4RIUXSc1nzU4tkmZjLbB4SyiIpUWWF4QnR?=
 =?us-ascii?Q?VbL/rpFmS5UvmC0UzlcPab5+mYhOoVYFv8tdai0WQKO4exjWL+M3OkOM7jPT?=
 =?us-ascii?Q?7Fbv9DhA7iO+6unqI6gGqYSMWNAnsPjdYaxs/TWkBYYluz1Oic9LP1DoZucJ?=
 =?us-ascii?Q?D8KqJnSJ6caTxHH0/SJKGhh2rNgiKRZlRXFFpZeZHA/Di4h11N8d7sAGQIHV?=
 =?us-ascii?Q?t6e6gAOPcZ0LhMKLtnNhJMgaMDXrVYNAPmZmKYxKpU63SuMJPHs4sVAdTL5g?=
 =?us-ascii?Q?xLOEqFrNku5P5CB6F/603WIRQrMaSh/AziNU29zRttOkeLB3hGrzjjY9/MZP?=
 =?us-ascii?Q?WwBbngC+la0fI0g+mHxwxqbKxCxI4VNTysLaWrT//m3ECEZIiq0/WBh6+1Rp?=
 =?us-ascii?Q?fN72UM2PxEtWog+Q1du1APF+hL52znrfzKGW8jBlTPNCxab30ZfylxS87g9X?=
 =?us-ascii?Q?3/o9FVDJ0fNmJIy6c//07lt4b+l8rzWrke4sYuGMXY/hpGaipxJPFcd7/BPM?=
 =?us-ascii?Q?BSb3IaO/yXbU5VASI2+xuBmms5TbIWt1I6n9v8KGPgC0NT5qO37kt8SN20Dy?=
 =?us-ascii?Q?kka4dLTpygFbjrzI2MGb1N1WPtBxuZfHhyxJOw1AwRlzKD2ohHJbkhZ7fxxQ?=
 =?us-ascii?Q?YPKe8n++iwDxE+t2yqDgus46Z3w/J24XHGjI6BicHE4jY3FgTRW6t+IXpIK+?=
 =?us-ascii?Q?Ehh4xfbTt/ikZUtvOmCo5cv2Ynacovr7lmZyubLHOkOFWnQ/oHsxZBM8EGCC?=
 =?us-ascii?Q?hLedFL4OlTbh2rThugw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITdZJBbUuTzEGMiu5OSCorOo77oyPAvBX1NYL3lro0fdL6Dyn0SWyVQ78GH0?=
 =?us-ascii?Q?U+jSAPiUlcX8Semwzjn5fhGFoNbHStJtAcvalYbMDErR19s1/18EGcLSF84B?=
 =?us-ascii?Q?JKF+oE+StBMYBHsmkkvbpjVzDiNBMed5MN3hRQJmSaw61fBbjTDXtWKxvoVO?=
 =?us-ascii?Q?Q6nAckwVd/JprZckUR/ZFcNUjmNhKRI63Y3aVQ/9FMh3lt8czj78v6nifzak?=
 =?us-ascii?Q?AKYMR5slNvzVM8gUt7GGQwdtc/o1Cyu8C9xHtTC02Ct+QmC9lhbZti7R6S1Z?=
 =?us-ascii?Q?o/nW+5SPxkvO4DiaIPfcSGLooMDEnJ5Gd3YbV64Oa5EirhtsMKdTpNNsmKDu?=
 =?us-ascii?Q?lisa03TRk8D5UwqC/YG+kKOpv84TLHXUAqWzm+33fm98ZoHvl3jJp/RSe3Vy?=
 =?us-ascii?Q?Jiz04LGE+ctq1ySDA7EUXe1NKa6+2wV4wsrohwnUwD+EjJKECMAMMZs0r4U2?=
 =?us-ascii?Q?bbnbF/1G+TFNd60iRSM6eBNoqC5uhuAJAexmHgHB361MWmWzY4AgMrEol4Lj?=
 =?us-ascii?Q?jYQP0A7aUcBMVOdTntkpSsj0kc4AaRNesTGpsmA2Q43V1I/0KnGnEU6b5kZ0?=
 =?us-ascii?Q?J9jvDpnZ+uJv+K60q/+cKvf80XX9eZrQ7cfsqPIJqt3W4ECjSEtuDsCxwPqp?=
 =?us-ascii?Q?Ab4tkN88LygYE0Ncd9kGO1vW4ChnGqUScXCik2ckPRpeY1rq64S2uR/FYpBx?=
 =?us-ascii?Q?vdtYCnV/ffoSFnu3XXBq4V0mxP5IdqWMaaHbqmh13POGbnKn4emldXGDHNO0?=
 =?us-ascii?Q?B0szE3VCMoKY8wkpA/71DFov9a7NybzffcKXoD9cokTfbS5dW44nDtXvJaAQ?=
 =?us-ascii?Q?65tHZURJ0LYoniMr6jGXFdrvODM77wsqVRxow/jRkd2Dl04SLTSWOIQgJBNs?=
 =?us-ascii?Q?HP5LFqMfYV1LkHbdUMjotMHnVAYiRW31GNvCuyi8yODUlPFUPWyAFIV+2jxh?=
 =?us-ascii?Q?XWsnnqFHpIuVbd3OPManOaVubbEJkAl9LZxzM8IMjPdAVrXi3ifILNHeefEs?=
 =?us-ascii?Q?ft4WVz4u1CD9Px9KkDJLjxzPhmCxbYU38roLIYVWwzHOflkDvtqjb8v2B8qF?=
 =?us-ascii?Q?dk2nfithzLnDKy2TKm91o2/89ysm4LmBTXuKQEYHOjL5+N0UFfi/+jTXZp5y?=
 =?us-ascii?Q?lEe07tUW4tAhRea3zgwPT7OSnM3ddNj3kytEvBGtMoUrVirqyBYyPuefVc9M?=
 =?us-ascii?Q?zTwWTTDcN3pqg2Hh+/TS3aNmdJDQdBhZt+kOms3iBUQunqr7b5/+qY8LNxai?=
 =?us-ascii?Q?J55lYxBVBjQKtYEQisd5ElgK7bS97cMnkLcPo3XJGzeetYcEvy1svQpHitGh?=
 =?us-ascii?Q?Oa5sG0wE4XlP51DM09HKizt1uBz0JPTZDhLsA7d48RIzBANxYs04yqekgR3t?=
 =?us-ascii?Q?IZDRNnKzM58Q1PyJhmAIttmZ/JKNhQa5lHxew1fkTdilzEAe2SW2ccwVQ6ww?=
 =?us-ascii?Q?V1qRZZh00XzzNq6NqzyO4fariQfuNWMg7nG3X1h+5ZolBZC1pPxKIALPFYHg?=
 =?us-ascii?Q?W90iYk+0oYVguyhj1FnXqKOa3YTPmeMp9AE0drplYRXKGDkpSCyOYcnNL5fu?=
 =?us-ascii?Q?x9R6p3WD8HB56ppuLr1pKwli8IAI4ip6D/81ebFHDqsm1xFAQKv9lKl/LpyV?=
 =?us-ascii?Q?kczxyHKiOdMaEvGb+pePxs8GTHzqUo775PbFt7IZk7H4saFItDaxOyZzzws8?=
 =?us-ascii?Q?B40DS2VxIe3osUKlXr5v1dTSAfUlqyzyHC+fUp+ODcDUQm+F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e323cea-f6b2-4cd4-a396-08de5e5b80a2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:53:43.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sq7qSqcvdtJdERgfpc0K0jGtKYBhGZuYG2Ch5eKDSE0KfzmTT4NtzWWwyhs3vkotpmymQMMYpF6Ne2sQqMFPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

On Wed, Jan 21, 2026 at 04:31:02PM -0800, Daniel Hodges wrote:
...
> > Long story short, the only thing that was working reliably for me was to
> > clear ddsp_dsq_id and ddsp_enq_flags in select_task_rq_scx(), but I thought
> > it was a bit too overkill and then I've never finished to investigate the
> > real issue...
> > 
> > In conclusion, I think this is fixing some of these warnings that we see
> > and it's probably good to apply it, but it's not fixing all of them.
> > 
> > Anyway, I'll do some tests with this patch and report back!
> > 
> > Thanks,
> > -Andrea
> 
> Sounds good, I hit this running cosmos on a moderately loaded machine.
> I'll see if I can get a reproducer made and do some more testing.

This is with 6.19.0-rc7 + this fix on top:

 WARNING: kernel/sched/ext.c:1282 at scx_dsq_insert_commit+0xf2/0x120, CPU#13: alacritty/6070

Which is WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID) in
mark_direct_dispatch().

Triggered almost immediately after loading scx_cosmos on my laptop. I'll
also try to find a better reproducer (ideally inside a VM).

-Andrea
