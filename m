Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793069914;
	b=BD7ac0i/MFD+NaqdmHjGHWOzEgY3fmDVSNd8858HwM3NomzPKC7r7iPNjciMN5Adsgup
	 Q33tzON2n/nG7HTTFtAoqLDmRmCrsBUqBImvSMD9EgdtiflA0+s8FtBohpKcf9JD2ew9p
	 67lsYeyD10T8dzY7N+G+1tQs3R+7KA7eUAw1dxUkTEotbs9JzWglt4Pb6xuTWsZtTZYEy
	 mKuU1PTAnkHc+fbc2BRyxgSwzPHKwektbSdaCJCYT3mFZYRom6A3H7Rn59dxm/F6M/rK3
	 iQpoDVNcjs3pUmGdNsuHd/reEllhEZnEU4rShfmyBS1AQieueRNFHqCQmRyOuc/AhEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069914;
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
	bh=NvexSPThcyEAMNOheDjejbtrlrQU7xxEmqzobi3edvg=;
	b=exG0SvKKBaG95yhyXa7jHsYt6ypKB5x22hpoL0++OfHwar/w2h5xYWtI73AYXfaFAdO0
	 VlJS31lZm1uZdzq2iDHpaTgFGQ4O24SN/fiztBXqwH4g3QOYbB0gPetLC+IBm4L/Tjk4L
	 uV7qRBWkvFsbJEjSP3TFOFzxIjY4OGpJ/dCN+2oBWWY/DP9uL+c92c4/z6d0yrH/zNR8s
	 hDdVuMGeSb0+8/8gmIbi0QuWEg3HOht+gNQRYB04E8B5YPrqmCdN+2QmCJxxp0vGnvupc
	 Brehel926tiLDSr+gUh5aKFZ26zChrVtkPod8dg76H3BMsGpJCHVNIHFtCAdJkFnCmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=emp9iO6N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.60
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65A606A31B
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 02:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A65A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=emp9iO6N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWhg/EeRKrx9ERzCG8IeyeHwBRSeql9ms7xgBDfB6Q+cs9bafsLGEgqWM41AvuUvId5ailylwEA++ylFLLlJgVQKMgkS0/rgyv2xjM3ArrsEFB83fqFat7saQrNyzS8mc03sldQ5A6WtHqP5ricRF5vRBsz0xGgK1hw/y5sFp446uKW/ZGEIY45x08VJcntTEtxAR0COEHRT56+Wjo5dndEwJ1Zpd0Pnm1eDIbpxINnNI+8SBIZ905/C/qYqpjsqZL2Qlz6hzOqAnUG4MPZ/lIdb27xvMMXSpNvM/w8634qzdm+QAczb0gygN3KmzYLrCUTawiRwy7Ny/eG12qOihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvexSPThcyEAMNOheDjejbtrlrQU7xxEmqzobi3edvg=;
 b=lNeT/j6A/fjaJzmqN1L92jGI9fsEvedlz+/qRHIKcaNWxy6HaS30hT0JDrw1XVxUZXccJMbaUMpKO1MkUuqqXgXZ3n+MKgsgB/84eyolyyEtJGcT54PgqM/DoHIaNK4th2ut/MKokr2VKoyaQnyIxvcbBrp4PDbQG8g4vKR3rL7YwaT9W672faCD1AOPHYT0HhH8VrYWYkjzanKDL0n4w9+MJIGkMNOI5LWwyzxQwErvZO1PPOMQVIupN3ARrosl8B0f4CcP5Lxbud2Sm1RZjK4uuknJiFYGZeX6q2gnmnXC8buBjTS2go5vWyQS+Xsn7SF9fIcuUQrd/U+BabACYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvexSPThcyEAMNOheDjejbtrlrQU7xxEmqzobi3edvg=;
 b=emp9iO6Ns7N3tJpK6/ii0AN7Z/CFVF6f/NI3FH26wxOPyw0Y5clwcVTzuqeAOgbOEd4sSDN1G/aQGcQhg/29KHRHBndvxsETGcER4antBaioY3hbqyaNYiVY8AQXNT5LbnwiytWEqQD7DVreKQQsPDEt3+olG7gEKmNExJU/3S8DPTFP7rFQ/jDc76JdmY8NFXz2S5cuPkhtX7RpObwOtah0T5ovF3mY/1mEkMv98x4iYv7WqHFlP/1OKvzzHXOoqSQ5kEfwsHJ7qplothAd0hIk8o6PUw2RZ5NNay2V8nwQWhY8wXb7xn58u7Cm+fKLwzZVab+js1h5+83PYSQrSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:58:29 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:58:29 +0000
Date: Tue, 27 Oct 2026 03:58:22 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix the stall
 watchdog testing and blaming the wrong sched under bypass
Message-ID: <auATTu6UWiFYGj5e@gpd4>
References: <20261026204300.3618150-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026204300.3618150-1-tj@kernel.org>
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: ae61cd75-ab0c-4567-751b-08df33d62dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|261026121527099003|18002099003|22082099003|56012099006|5023799004|11063799006|261022075727099003|261021123027099003|10067099003|261009223027099003|261021121427099003|261022105027099003|261022113327099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	P5fGhwNmvtxU3Yw89ucrjMY0u6gWFTvlD/jpIc0XTS1iFHuhO6kcyd72DbB46a6TgID97nPaqkZxeG1Z31WE7KZK1B0GA4y4Hc/Do5kE4bHwogXMJXt0AZ2nKx5HsNhWtucqmRLuZ1lntRXXpkr5cQglyxQHFrJD2L5M4iy9Zd9ukdfVihcWEHRM1VCS0jgur/JtnukwGQi1LI41/i1THVVUUmZxqKyVzniyAw5JM98NbPk2LO48Ccrv0Kd9yTG2eqnG7gRuXtb8nAAZDjBlej+pddQBSAjsX80R398HU0yWzRTtagrvpdf5F1oxNXnooi6G3CRzvkZKxxBzdXMbAZPqArm/VpDlrWt0YrM+4KzhtSeDJxGRXPn/ZXvSwyTOkAgbba7XwQznjy3rzBbjPE3q59M+GhLrfG65m5leifao1JIMqudlyamFVDotu5++RfCjoSeEqxnUuyAtYpffqY3sXT//GR4jnyRl6eG8UIAoMLDJ+8K0CTM/Cx+nbwPpYRQxO/ALdWjQEwzsFjXFgZ1n+diyjo1ur193b185LfVTxunXDaet194/QSujUBlylotldHzYvgdXMdW9OugII7nawTLz/glWX4y/XNc/nOsHL9R3csEFo0u2H56gWSQ6NNsAk17OhXJdWSb8/XXNqu2di5R8OXbHiyTk+5cEm9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(261026121527099003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(261022075727099003)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022113327099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hiCslPM16fWk1iEyyfeQjBO0r3LOLDFpNWSHGuQ5QT7MngLuRND67K0Xjiwl?=
 =?us-ascii?Q?79/LtiIa24KiOpKw+0RPy3EagQLh9+VSo6sobjOM7X1vMGkjVR8ogbQ17S5j?=
 =?us-ascii?Q?7MjZOqc9Lg5/Nw9G95AwCK0r+XLpiAH+/MFjERAewv6HRieG7fAIA8jKb74D?=
 =?us-ascii?Q?s1HEEux8mJw3eF9bpVxjw7+0kf1dW7fnokY7WN0j6eRxiWgBW+9VSjgDVn3E?=
 =?us-ascii?Q?Fu1tc+/SSLz5avt35RwkNzdkWttUsz0T+zgg0YhofrCEN0jNoVmlhJacZL9Y?=
 =?us-ascii?Q?MUnVLusQ7QdiaYb8p/z8OvrCYfefELPgMJIR2ypyu3yEwacFHNOQIqS6Vqzy?=
 =?us-ascii?Q?Va2l1OQznj3LHXz+y64YKPnlpwhaBxXRDHqZW/JtXGnOcFBGOHsvHEzPE/5x?=
 =?us-ascii?Q?Img0c4kmSXrYVRgb1RuVtcVT13hz15RfhHIFXImTj+GzDOUymP59d9hmbZrb?=
 =?us-ascii?Q?YxV2GV9xpiTWpWDham946a92dyFo6LFLTJuRnTdk6hsCF3R3z3yJ1wt1QOkk?=
 =?us-ascii?Q?rO/z77j012Hp3drSvDKkRvo6p/jo8KdgLn7qaUDJKz+GN72V9FPtzD6idCCG?=
 =?us-ascii?Q?cRRCYIhpY+fudfh6w0AnvQ9PzAlmAXUls76VtAfHdudVTlE8H0hugRw/9ihD?=
 =?us-ascii?Q?bMXQ+frwwIWNjAc6dvliNnb3Cu14Euk0IdQmOKDT8VhfvBtd891+/Z+uD2dm?=
 =?us-ascii?Q?4aI2ImJCOBDEIc0Ff/P94yZoZJ9MEW4c1YKJ4A+KVXBPaazhdAJc7xT5pvBJ?=
 =?us-ascii?Q?wVwLOyWLapRDNllsklYBKZvuCnj+77gFr+00fBrq10X1BplmKrN12vY7snRw?=
 =?us-ascii?Q?kpg+fIsHiB/nFm9jzs3LsHrpf9kSzimqq2uGy0dW8mG9MpcQMYBhZZgkwyr0?=
 =?us-ascii?Q?gGLw5uSBzS1seWRAKZViKTZ9i7+9I4LhC2QMC2+rfx7mk323jyKkOhihINk8?=
 =?us-ascii?Q?u//6Ihxb/ymCaPjfub5JYtaGhoszNmuH0c6V1575hYzGNNeHPOi38kcKgQly?=
 =?us-ascii?Q?p8pQHCiUG1Dr/J7xUCcEPOiqEyFBw4XjdS38SmPjADT+at2zHwY1LcLLR8Ve?=
 =?us-ascii?Q?hIp+AgP0eBQwZwcvs2eTDzEyp8SvdAzNYRa9fRWYFRMndtjgHwURFSe+qAlP?=
 =?us-ascii?Q?II+aS12MdHZD9ZbXJ59HEBsG/JBj+9+VrEDKh1LRNZRnD5Q7F6IynQL4qY8F?=
 =?us-ascii?Q?fEjXDYWwHrddWZpOsEYjq35LJWYIdRtnMU7/4x89T3wnrAJh0I5hFzwP6OiK?=
 =?us-ascii?Q?P4NEgXMmdNbNoE46bp8QSdXhIb98ssFJQX8AWBnn2myJmVA9ZueQLUWlYTz7?=
 =?us-ascii?Q?NmUX2y3ZNjdEQdMGW9cVFUt5CkkG1iGeD0M3QMnLH5YBORza1ImieWD3QO7a?=
 =?us-ascii?Q?+xUD0xGdFMur4LpbG+QsaKD33Uic/jwiTw9LFZGtkL2N8TZd7kiSnIIYW2FN?=
 =?us-ascii?Q?1KKkSF216D+WVRVRa42p6J/1SOQRnPNAvCU/rcOPkTTeOTI1YYePL2SiifSG?=
 =?us-ascii?Q?/Sso1e+dYs6x/B9SIuOnFngV1mE/i7hbQnZAbidSjfjOHuKoMN0HIz4snpjr?=
 =?us-ascii?Q?3Yka9pwmcuEkE8Ri4VhDshCN5rnZuzanZzP3+PMfcSH9Jq98dkJWEUILluyZ?=
 =?us-ascii?Q?MAVxH4WTrsiL9ig2OzqaSJv6zKVat2ckAMeYvHR8xlnsnS6Vv4OGhtl32YnW?=
 =?us-ascii?Q?sTblARUGDGXLfcGyB5qS0RWxKn91+t4iMxALTVhkDO+cZMle?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae61cd75-ab0c-4567-751b-08df33d62dff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:58:29.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N19kUP/mfSMKePwivARscXBnMFtBhhxJkBhL5a334iphJE0YAoEjtdZUJX3XPl8PparUpdpdOdLrclmHRdi4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

On Mon, Oct 26, 2026 at 02:08:59PM -1000, Tejun Heo wrote:
> While a sched is bypassing, its tasks are run by its host, the nearest
> ancestor that isn't bypassing. check_rq_for_timeouts() tests a runnable task
> against its owner's timeout. Since 2c91169377f4 ("sched_ext: Blame the DSQ's
> owning scheduler for a runnable stall"), it ejects the sched owning the DSQ
> the task waits on. The sched tested, the sched ejected and the sched running
> the task can all differ.
> 
> - Timeouts are per sched. A bypassing sub-scheduler with a 2s timeout under
>   a root with the default 30s has its tasks on the root's bypass DSQ. The
>   root, not bypassing itself, consumes that DSQ before calling
>   ops.dispatch() only on every other pass, and on the others only after
>   ops.dispatch() yields nothing. A task that waits 2s there ejects the root,
>   disabling all of sched_ext.
> 
> - A bypassing owner's task on the local DSQ is blamed on the owner, which
>   places nothing while bypassing. If the owner is already exiting, e.g.
>   during its own disable, the exit is a no-op and nothing is ejected. If the
>   host isn't running the task, the owner's disable, which waits on it, may
>   never finish.
> 
> - The wait isn't restarted when bypass moves a task. The time it waited
>   under its owner counts against the host once it is on the host's bypass
>   DSQ, and its time there against the owner once bypass lifts.
> 
> The sched running a task is its owner, or the host while the owner is
> bypassing. Test the task against that sched's timeout and blame it. A bypass
> requeue can change the sched running a task, so restart the wait of every
> task scx_bypass() requeues except the root's own, which the root runs
> bypassing or not. Single-scheduler behavior is unchanged.
> 
> A task that migrates while scx_bypass() works through the cpus, leaving one
> before its requeue and arriving on another after it, is requeued by neither
> and keeps its wait, which then counts against the sched now running it. That
> is what happened to every task before this patch. This might be worth
> addressing in the future, but the race is rare and the real-world
> implications should be limited.
> 
> Fixes: 2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a runnable stall")
> Cc: stable@vger.kernel.org # v7.3+: 30fb2b1e4d41: sched_ext: Fix the running task keeping its protection into bypass
> Cc: stable@vger.kernel.org # v7.3+: 5809f749fbdb: sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
> Cc: stable@vger.kernel.org # v7.3+
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Link: https://lore.kernel.org/all/at4l0yXTk7T_ouk0@gpd4/
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 4b7d2602b4d4..a9621bbdb183 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2458,7 +2458,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  	/*
>  	 * Don't reset runnable_at. If @p is waiting, the wait continues across
>  	 * temporary dequeues, e.g. for a migration or an attribute change.
> -	 * scx_disable_task() ends it if @p leaves its scheduler.
> +	 * scx_disable_task() ends it if @p leaves its scheduler. scx_bypass()
> +	 * restarts it when its requeue can change the sched running @p.
>  	 */
>  	clr_task_runnable(p, false);
>  
> @@ -4298,24 +4299,17 @@ static bool check_rq_for_timeouts(struct rq *rq)
>  		goto out_unlock;
>  
>  	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
> -		struct scx_sched *sch = scx_task_sched(p);
> +		/*
> +		 * @p's owner schedules @p, or its host while the owner is
> +		 * bypassing. Test @p against that sched's timeout and blame it.
> +		 */
> +		struct scx_sched *sch = scx_exec_sched(scx_task_sched(p), cpu_of(rq));
>  		unsigned long last_runnable = p->scx.runnable_at;
>  
>  		if (unlikely(time_after(jiffies,
>  					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
> -			struct scx_dispatch_q *dsq = READ_ONCE(p->scx.dsq);
>  			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
>  
> -			/*
> -			 * A task can be stuck on a DSQ that a sched other than
> -			 * its owner is responsible for draining, e.g. an
> -			 * ancestor's bypass DSQ while the owner is bypassing.
> -			 * Blame the drainer. The local DSQ is consumed by the
> -			 * cpu itself and keeps blame on the owner.
> -			 */
> -			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
> -				sch = dsq->sched;
> -
>  			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
>  				   "%s[%d] failed to run for %u.%03us",
>  				   p->comm, p->pid, dur_ms / 1000,
> @@ -6976,12 +6970,26 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
>  		 */
>  		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
>  						 scx.runnable_node) {
> -			if (!scx_is_descendant(scx_task_sched(p), sch))
> +			struct scx_sched *owner = scx_task_sched(p);
> +
> +			if (!scx_is_descendant(owner, sch))
>  				continue;
>  
>  			/* cycling deq/enq is enough, see the function comment */
>  			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> -				/* nothing */ ;
> +				/*
> +				 * The requeue can change the sched running @p,
> +				 * and the watchdog counts @p's wait against
> +				 * that sched. Restart the wait unless @owner is
> +				 * the root, which runs its own tasks bypassing
> +				 * or not.
> +				 *
> +				 * A dispatch in flight writes p->scx.flags
> +				 * without @p's rq lock. The dequeue waits it
> +				 * out, so set the flag after it.
> +				 */
> +				if (scx_parent(owner))
> +					p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
>  			}
>  		}
>  
> -- 
> 2.56.0
> 
> 
