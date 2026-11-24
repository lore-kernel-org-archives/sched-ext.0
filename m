Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519883;
	b=qWSBbjNM6Un8NCFuhufFckJuOn0+NMDVKIDY4RByIVp+NeSt9vO8SMOjq0kd+A3AGrwL
	 SneUBHvjZgidZryZ+idleKYeBnuDoNDrYf3+Ko7UNJ+SZgNU15NyOzhCmb1NYClGSQnc0
	 PnOr2QTABmA2i1DcVbRX991QNXYrEYCIeo3uEDTfNLQQ85Z77xhiGB0pi8gX5dNe6K5CN
	 BemkaVXfDvjkoyShUq3Puf4E25m2VtVXDstMrTLqBbtPNOis5L+jnf7nuyBzlrhf3PYqo
	 /61zzj2Pb0jraJYsjvrifaJqel/TLQs6qssNf0flGC4uIYPBB10BywG7Iotf7VVbiUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519883;
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
	bh=7bjaiy1SE3xpmHiTS9z48paGZ4A4OsrVATHeP6Nv+iU=;
	b=uWX/hkigJBOFSVDyK2jqA4SmdYjEk/XCByUge2pI9zzw0YbQuNKshDlvhX3/28bBiy1Y
	 dmNjAOCa2UkSzCaDWcEaOKmAoIFFX1xppSQR3zOQsXmhdiX0AflY5aWzrzS2xVkw98ApM
	 b1Eg3aJZtu2+PDgv8+ttjOor3EfU2qssnmTSgGoZuARrjbShF3a2QA26o/gniMq/IVSUV
	 Y83yJEFMujFy+2Bp9vHx7CJFLZMydP+pZKAxDCTV7McvRO+2MqDK4qsza5dbcHERg8Myr
	 zzEXUEiNfBk6SsGFXAWwBUqRDcF5FHnasI2GLW9I+jmvdC/wcLzG6q8Odt6jeLy3gpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ENNNkfRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.15
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EB606A322
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588EB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ENNNkfRU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYEYYyBOQqJHe4Z/b11RMkC6S5bZfx6X7E9wQl8VrcraUTX4QeOp3TF8sfOdqmIkRAlXSzvHSzqJLFXqL3zPFiT7kSPNO2e+4oXjC8ttLf2iq2VVfXxFWVzAQFAag++r/tO4/rOlpUs1k3tZfDfCarxJ3H5Z5chIAmYboYCFcjTJGA+AB8zbca/6+H3JUd/el1ijPvNfJXEC2xdmEiQgBNT//N4AB52RkCaNVD2j5MQR9SlFdZ9zzJXhTeGSKqVU9FxmZjr5BRpC/NJ1YJHiIPZgRdzKITsF5S6VDEk8Ex6zWg2d1VY5UQnh6DHG/uiyFYdqujSyUjMfIhUbkTcghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bjaiy1SE3xpmHiTS9z48paGZ4A4OsrVATHeP6Nv+iU=;
 b=EVoKAm4u8yl1uKiV3/phJE5nZ+cVCnT/aegmDkPHh9skapz1Ik84v0aFOJxJlUr+GV/t3nzeTxhPpojMKalkdNpfjevi5gAeUUa0rhGSb/W64Gs4/4aqNxuJ0O9v/aL3VApZJAbnHAjwPkCf9JrjSp0posLG3wh58rcLQPc1dIPEGbUStR2+f6kTpFjjdCvsUFBZmONblmq9rxhFRmNGugHvIMxPkNoGbG+1fWsUgqN/V1hAPY4wVqoyz54krj8lcPs35DQ3dW26z6rIYagUmuh30myJnwZYD73izNk1yaXJubeEZnxyJSs+sHvFFLD3v4reNmdVRUfG2S5/VMovXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bjaiy1SE3xpmHiTS9z48paGZ4A4OsrVATHeP6Nv+iU=;
 b=ENNNkfRUxgRq93gz2+zoHH7iv6OpwQhiIDQxfNP9yeoP3TzNS07O92mYb9cMAzbE2g+KcAvoz2ddaZBUAGLI/5Poi2TZ1VOK3m30Q4r6bi6tBrQD+L1SCPr0clVL3Ea/Y1tFWkcnm/tMCcTKxlY3yQqHVj/oo1qh0BLNaMcJnZ5/PiqzJYPp7YWQRsKRGIKOOgTdyb3swRz1sW3DfTeerK+LYT5hNjzqO/PEg7Tz62l/IpMlQjMUl1IZhKm20gAadQ+3Gmw3Lk/0lym0e70Ysf0z+WWn4aZ5AqSsGcfQZy1wkVeeIcz47CaaNTJ+5xk6YXz/JQ25l6Irow0z6dZDZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 11:31:17 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:31:17 +0000
Date: Tue, 24 Nov 2026 12:31:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix suspicious RCU
 usage in KF_RCU_PROTECTED kfuncs
Message-ID: <awV1fKEL2vbN8tf1@gpd4>
References: <20261124103043.339553-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124103043.339553-1-jpiecuch@google.com>
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: ffac2e1d-d3c6-468b-3818-08df4a1e7467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|260925022911599003|260925021911599003|11063799006|5023799004|10067099003|260925021311599003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tVKrPIsZKrZqHdzMMGNKTUNNwZ6kl7mxmzTxM5Nur0tDzrcFp4ArQ6x5o+RqrAgKfoBIE9W8sq6pwTSTmT+svNPU+39aN18xLZnVF1VLSlaiytAE75QIm6P9eQRDjyouI2J2VQgxaLxYpnqLgKkFh0lyFxrpr5wKhjheNeAUzb7gGuJyGkeifE+MEC6PoUXZxSTj+9SuiUcwF/pmNhpzAuKpWp7lZMDJM6M232prMmsvwH+ybEzXGeADu85MSIhJueFiTbKLJZYG6iYeH+Ch/bWMp89uh0NSx4ow9TD3F0P3jx6W11/l9nAHT0NSKJT15vfDi9rvMEm9V4hvoLfA+5OeJ2MH1CfCt2xi03Wn6gMqcsm1ivV7DfcvZLMJXpLg6qJlsKC2o9dQNXWPLxQFEPog5HbO9lM+CO8WsLaEIGYgtfJv/hTmD+t3etdEwF1Gw2HgOSZjzY7kBcOKYUx5c4Eo5RloP2v1ts0J5fksKtuwsNhc1Nkc3/CqZT1e4h4FTX/mag46HG0u0D3b4Yl5MlFqruPn4Nqac9VJirSnEUAurfq197mQZ0xls9KFyI3fWUPKy+hxq5JcONQiDTJoDuxWQr5Ac7Guq4Es+r6u2JlYGX+StxhgDzyJBmGOBqRNeCt1WVgP2DNQ3cGOOb1qJ37s+3DOaJbI2l5i70BPHK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(260925022911599003)(260925021911599003)(11063799006)(5023799004)(10067099003)(260925021311599003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cR8hY+9fiNIy32uAm57zkCJNF7PdeqW2/RuQzXO4RAaZFAMqiO5Zf7TyQ4L9?=
 =?us-ascii?Q?3XQvVX48N0fgujYd5HWUJNCzM6StPswBRKGkNgKCXrUG02JX5vgHOaQp88cF?=
 =?us-ascii?Q?2DIx2wQ6ZiuptAczy7MSMncxNQygl93qy+yWcdQmMFVMNHZu+P3rX+Uo3qlS?=
 =?us-ascii?Q?hxeb2sdrkTLRTTvk7ylR6r7sTuKhmjN756iBzHknrBhhUM8KkBICpsuM9gTr?=
 =?us-ascii?Q?Jb2qtWAu7coWDNiIGhSXdPnUQsa5fayZ05bnHwva2SK2o3C6BpWnVn1zJC/J?=
 =?us-ascii?Q?HVh18df2/cz5tYX/yewxUW2TAphVmYTPbyVToxKLu+ZmU7x1NvnnAXZkgQNf?=
 =?us-ascii?Q?s5mRJz9PrbdN2EGQE5T4YSpLprsAZCh56dVRqjXqyYTMz7wzSNB5NvT5R+yN?=
 =?us-ascii?Q?NUkg0GZ0hmhrVKaZDd4siXHO4r0aRxN2Q2J+dOTzBqSB1iTBQ16VLzNydV4g?=
 =?us-ascii?Q?D42MwdR+xagHY6UeL6MKq9vZSsF0PprKgSWgBgsyzfNfafxglmwGNUUhB3s7?=
 =?us-ascii?Q?KfI/gY/jJwv9Rl0HS8SqrDRiLDjUI7oe1tEuNvKxr0YqOVQmM4wMxtazBh+t?=
 =?us-ascii?Q?IVkOD6FXtcSbGoJy2QTgkZO5721Dx9kSGFN4YZnSgAFIQeHm5+zJKHybQUmx?=
 =?us-ascii?Q?+sQXcwjeW+0XX7RVdoSPgu4Rr82lUrejXv825iKiznKWnhcaIy4nTnoUDogd?=
 =?us-ascii?Q?RMQApuVtwIVnSgTrj2pnjMt8NJCk6D5Y4WIyDjwQjSPGDQuzuMMrau6JTXlS?=
 =?us-ascii?Q?n2iNg7ly94HKPM0N5m3pIXWTFA64I82oOiOSvwCzcHdSs8Pkduv7gk0A251y?=
 =?us-ascii?Q?lqwLIAV3AV5Pxa6DRJ9VJlCTte1HScIPvnrKnA8Byiv8GYbGuVx8mFxq+9bA?=
 =?us-ascii?Q?ZmGqlpw5QlbOGlJuzWiForGwkjiEVudtDPINkx71bV1Z4roADWdNBKhhPMeR?=
 =?us-ascii?Q?0AF9q4nVxACAP18tN9jVtPVMD4R2zbzGFjzpwJapq6DPrAttkg5reT9sWD2E?=
 =?us-ascii?Q?zWauN/VWEtVXE74Fa4V7dD2ak0Or/qbzNLEhdGmw6HCwI3CT05T8pyyPTXax?=
 =?us-ascii?Q?A2UWH0MnUuAgvy9zu45m4EjE6roT7bJEcccQmDaVRN4kN7XCUvU5J+yWCVir?=
 =?us-ascii?Q?q9yaIN63SZJUfl3A/FivJexuCigUmbhbY7Ckii3oPOBSRrj1GjUK2FbH95E9?=
 =?us-ascii?Q?sQwKA4u2bcYDFTAkn/HLKlCSB3Y/5AmBZN3m+kMnkpXoUbBZiM0OI3VtngO5?=
 =?us-ascii?Q?XM1VUp/CtkbLseGAqW22s5lEbpwn4mAqpTPH1trh1k2XXQvNV//m7FpUNT+c?=
 =?us-ascii?Q?w9CpEOGgImuKRnpnrd134iJR2Dr3Qkl4IAgWLhtp3/QqA5NYbU2KaTCgVKoH?=
 =?us-ascii?Q?4cee6G8HpvHu77IAHIhOrIDSzufdSMateu/yEe0a59HAhdbU1SzO8PoctilD?=
 =?us-ascii?Q?kedaLpVuTgoioOMVLyXkXoPiLmuFMVJmN6xe3dev/L6bDr9Msq/qjz74avSB?=
 =?us-ascii?Q?unACyBekH/i8cZ/hKL0cQOxPGMws55u3r1ejTa61m3xaIvhKPzsJvZ1f4cNc?=
 =?us-ascii?Q?8oRsdDmwNNJhVrMQ1Bemph36RO0RHFtn9ZdoBDuNKHuooaIbgSmk3BUiMPGY?=
 =?us-ascii?Q?mLMDyfVPnlyHEDMgFuhaLooSLYTdMcPwcmOUOWtO8rwX6lVokNaL3TE35JX0?=
 =?us-ascii?Q?7lZVWKEWaSHYXcRkFzzrbQa8R0/azQTxQGXOdt3YJGCH4MeOJuJgT+H1KIcY?=
 =?us-ascii?Q?kle5xAYm+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffac2e1d-d3c6-468b-3818-08df4a1e7467
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:31:17.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S0FoiciTyoYcjnK3OrpoSZBx2aPkZ/ZkX0kJvEisIe+N4QkPkEPa2HZxJV+fTTJme2zkslHB2BIgZKWawYDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

On Tue, Nov 24, 2026 at 10:31:14AM +0000, Kuba Piecuch wrote:
> scx_bpf_dsq_peek() and scx_bpf_tid_to_task() call rcu_dereference()
> without taking rcu_read_lock() and rely on KF_RCU_PROTECTED instead.
> However, the verifier treats every non-sleepable program as being in an
> RCU read-side section, including bpf_timer callbacks. bpf_timer_cb()
> runs those from hrtimer softirq without rcu_read_lock(), so calling
> either kfunc from a bpf_timer callback triggers:
> 
>   WARNING: suspicious RCU usage
>   kernel/sched/ext/ext.c:11170 suspicious rcu_dereference_check() usage!
>   ...
>    scx_bpf_dsq_peek+0x7d/0xd0
>    bpf_timer_cb+0xf9/0x130
> 
> The same happens from a sleepable program inside bpf_preempt_disable().
> Both contexts are RCU readers, so this is a lockdep false positive, not
> a use-after-free.
> 
> Every context accepted by KF_RCU_PROTECTED satisfies
> rcu_read_lock_any_held(). Use rcu_dereference_all() in both kfuncs,
> matching scx_prog_sched() and rhashtable_lookup(), and convert
> scx_bpf_cpu_curr() and scx_bpf_cid_curr() from guard(rcu)() +
> rcu_dereference() to rcu_dereference_all() as well to avoid redundant
> per-call RCU read-side lock/unlock overhead.
> 
> This patch was written with the help of an AI coding assistant.
> 
> Fixes: 44f5c8ec5b9a ("sched_ext: Add lockless peek operation for DSQs")
> Fixes: 41e3312861ea ("sched_ext: add p->scx.tid and SCX_OPS_TID_TO_TASK lookup")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> Changes in v2:
> - Use rcu_dereference_all() instead of guard(rcu)() in
>   scx_bpf_dsq_peek() and scx_bpf_tid_to_task(), and convert
>   scx_bpf_cpu_curr() and scx_bpf_cid_curr() to match (Andrea).
> - Drop patch 2 ("sched_ext: Take rcu_read_lock() explicitly in sub-cap
>   kfuncs") (Andrea).
> 
> v1: https://lore.kernel.org/all/20261123145927.577162-1-jpiecuch@google.com/
> 
>  kernel/sched/ext/ext.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e8c30a21e03e..b8702b81782a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -11167,7 +11167,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
>  		return NULL;
>  	}
>  
> -	return rcu_dereference(dsq->first_task);
> +	return rcu_dereference_all(dsq->first_task);
>  }
>  
>  /**
> @@ -11908,8 +11908,6 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
>  {
>  	struct scx_sched *sch;
>  
> -	guard(rcu)();
> -
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
>  		return NULL;
> @@ -11917,7 +11915,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
>  	if (!scx_cpu_valid(sch, cpu, NULL))
>  		return NULL;
>  
> -	return rcu_dereference(cpu_rq(cpu)->donor);
> +	return rcu_dereference_all(cpu_rq(cpu)->donor);
>  }
>  
>  /**
> @@ -11933,15 +11931,13 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
>  	struct scx_sched *sch;
>  	s32 cpu;
>  
> -	guard(rcu)();
> -
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
>  		return NULL;
>  	cpu = scx_cid_to_cpu(sch, cid);
>  	if (cpu < 0)
>  		return NULL;
> -	return rcu_dereference(cpu_rq(cpu)->donor);
> +	return rcu_dereference_all(cpu_rq(cpu)->donor);
>  }
>  
>  /**
> @@ -11958,7 +11954,7 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
>  	struct sched_ext_entity *scx;
>  
>  	if (!scx_tid_to_task_enabled()) {
> -		struct scx_sched *sch = rcu_dereference(scx_root);
> +		struct scx_sched *sch = rcu_dereference_all(scx_root);
>  
>  		if (sch)
>  			scx_error(sch, "scx_bpf_tid_to_task() called without SCX_OPS_TID_TO_TASK");
> 
> base-commit: 2f7928516314f37d7cb334675656b4412edc8be3
> -- 
> 2.56.1.831.g720f3f5937-goog
> 
