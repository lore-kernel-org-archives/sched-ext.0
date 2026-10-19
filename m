Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873434FC8F9
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417900; cv=fail; b=WQEVj8tIOKGu3sDRFVCRBsMrCTI0KBdd9g57mSImZ865jAvDihuNNZiCzd+4k6k8V4uEfZIyf6CZoCx7Ka8SPsJoiu2BWyByz3iPj/4PBRppTvtWpfm5QpMOBJGYnwC5ep4yIpqJ+xKVY6riFBFrrPn8cDwL9TjmTVMAof4e/3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417900; c=relaxed/simple;
	bh=iB8pUP/APs1+XjOPnHq/fdd9F8zoXmwOQe5GedyATXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1u8yFJbaq0WItUok+CkYxV5Cwn5PqsQ/ZbZR5D/tY0ThTxqz0yYHdLvUO85Ij/sDfdV7NJv+Z2i0j+xoNfXuEHBnxY2JCz8GNPZmn2Zg/J63y7tSqeltPlFuKuXWzJ0vl9seoTDGs88710ctIS/vPl+Mn53yTJrlinNCadRFOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4kVCcLU; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4kVCcLU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVBoi9vN/WztKspO6U2PfStsVVYMDl/A2VqJQDRRHF7FLpTelyirvbizu/LkbzAM0INwvAM4cy3ktvAoIw9b0yEq1sz8yund5T7VsGigO4KBPls8KSstHVIs+MJHCbpgw3MSNCweUs+0kFTvutSwP/TxWW9CS+568onReKaCRQX/dAmaUsIFjgZ7NNzuwW1DEUVhJRVv1TblkNnXaY7ZnFH0kIJcXNnK+3St6deeJc8+yw5WCI/6m/8oPGCTrL4NP906Ggis+xSx8vwRWc/jjPxUg7J8S/8W8oJetOBFTum3m9rn5JKH8SbiVPYxXkWXmgCORZRcbQ/ge5WzB8Eapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hS8oqXDBECKU4SlPBCMNb+mirUXz7NS4TqOnhiIO8=;
 b=raeqc/VeAwmBcqjROE0JW2nNgnF8fMl3TQr7f1lFD+dD7nlJ4H1aov0kMBkpafCLCLkcRez9Jfz5CeqXVIc9NUrJT499oRZ8ujPBkua3XhVnO02y+4QsBP+9SE0B+dVXa9lyxh8pV0Z5gYTjVUgpAZi6bqcVesYweL1ZopaG08OzpadIaiGO77RjngnHBGjhWjoqsIJXtZPwm4ux1Fht3+m463/momA4pi7LYEtsfNepWfhXYSoRRDKgnY1nUgSvQefP+RGrjHGqlD4dkusT/IMUPCAKQpTSWtSFAFAqH0XPjm8/KV614qDQZcs7Sx6s7VyX/WWi3buz7oRprWO9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hS8oqXDBECKU4SlPBCMNb+mirUXz7NS4TqOnhiIO8=;
 b=m4kVCcLU0/6/i2yfSkMGX2S+sdeCZx52mBbN0Lmg40OgsGHnFLQqU9mRzEUGonKiGDUQ2Hf/040KKFxTXrPvcJCnbrFdy1g7F9vFD82h+Th7IKThiq8ruV30K7hJEDs9gp0j2JZmgw/dJt1MG2TMbIl8xxyxkcGgq3w8DtgYqAsMBnPOalNB5FJ4UV1SAlr7BC2fsFFs5o/zrzcAlekxhkOENegrzhXXFewmv64QwYn697821SWZ6JT3D69UOkQGPU2HQfr4nOU3FwLVb134phtMCEGBiYtgPANsDnnKb3BdkxfrXI4PChkvg2BeiCCc4MXvLDtuMkIj0cyi+BtUtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS5PR12MB015052.namprd12.prod.outlook.com (2603:10b6:8:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:51:35 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:51:35 +0000
Date: Mon, 19 Oct 2026 15:51:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Reset runnable_at when a task leaves its
 scheduler
Message-ID: <atYgXtpPSGsoWmZE@gpd4>
References: <20261019124146.3582127-1-michalblk@google.com>
 <20261019124146.3582127-2-michalblk@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019124146.3582127-2-michalblk@google.com>
X-ClientProxiedBy: ZR2P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS5PR12MB015052:EE_
X-MS-Office365-Filtering-Correlation-Id: 833b0dff-a375-4431-ed63-08df2de81705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UOqPAOSy0ZlIG6IRALsNgXOoXISQB1KJ+L6R6Y71cdCCeY6zE+OOoefB+mb2ByFv4a3/bcm2pT0HOT2QFdQ+KqRJpDAwFb7VHRVXjrxSKpApGsI8+CfJO15eiAPhQxiHOQY/cdOB/g2dS80AUyA3+084sPwEOjwOSj1oEq/u9hge8jL65rIks0KhCFw1y9oDsPGz9hZYqDb9ih5V7SNeDT2HfGCdrZWWGXlZxDYzDcDvTHeI25eVn/oTgDKCJ1JoLXMxSDHeX0cEdPJfyymSmIJeyTSdEOV8di/1Fg84S/uPIzf9TPfej1hfAmgwFTTO9vQi45DhGjq01GWY61/B+/v7hdlRb8dLwFIBMKT8XxIJDbje4sDFXECT78kihb7kK/+7HQQJLvTnKTQhBtoMIMq35v4kEESz9u3iqjR0ja647AzZKm+aFeN5d9NlapV4BxDyevKJ2xmqluw5duQHgPzWQwzxCOD/bjNKjQsFQKMlaKTw8gUqvDrYEItIU1zAVwnorUtzfGXLkkN8AwUFpCGfepDsL6XmOoS2HnZlPGtAMGh4kPIXBM0t/VTVZxyCgH8vMa+ystsn3K9+qE3x/SEkcRzOXBcix2+4iAGliWSWritzHZPGMpU6oo85Oui6YgBH+lDnLRtKRrCv7dFuEe3yoskgd9TMlLpUJEWp9bM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZdOG6Jvdq8mg5z3kwBmTbetFCqgtuh15zBPJvAxHKZtWWlqzIvWzuUeKwwF?=
 =?us-ascii?Q?a0aq9ht3a9Vi6dBQyjZh7nwAbqt0K+0iF+E6Z8/P95FT6bWh+A83z2sIQwrl?=
 =?us-ascii?Q?w1YO3lHX7YSQBNmZXEBuGEnqFTVGXMjuB8i9uxOnqY6bqMhN+wmwJ6WU8ObQ?=
 =?us-ascii?Q?330CeO52SCjR60VJ8SeBa+Xf6+SudpHAFkXJrgUiL76bo5AX+K6MjYiChhji?=
 =?us-ascii?Q?8kY6CHT/4oMGomk/jzLYRa1BiY3bae1jIB5cQbH9CotB78nmm9CmLxaVoiGv?=
 =?us-ascii?Q?LO+MaXViik0pmq9mYGUy5fwgG3vkvaFgmq1f+BeS1xfjIoTFIwqkp4A/MjtV?=
 =?us-ascii?Q?reueiFjRwkcLB/2Y2zc0n6e5/xzicQ0k8TSh8M3at/+g/Q01FR4DsoUsz4G3?=
 =?us-ascii?Q?g3pjUoC7FMJRWlzdPtf6k6hoH7D6aPIXtJEbSkbQYW9s6LSJcXYmF9Owzq2O?=
 =?us-ascii?Q?/WtcZS0/35l7oQKuU0+sQg7jIK0ZIsA7OJdvrHbkmppCMilfVvOAc0bXOMv0?=
 =?us-ascii?Q?Arjwj3klyhA4H+qHUWGjZjL2AbcOWwJ3E3GDZew8ylrdX2ZRKm1hmiuqfa+v?=
 =?us-ascii?Q?5yGRulPE1XN7t504HM5CtqL51RLPoL/6xEajqb3W6jEUV2fl1WX55L/wLJ1p?=
 =?us-ascii?Q?rbTAwUGDfS1x/kzMc7EKHgboesnVzkl7XIKnMiRM+C2yJMa9k64DYZC2EnBW?=
 =?us-ascii?Q?XBfxJBQ5i9f5m4odV5cVaX3JT26sF4jO25FJ8dkRPBjnePVOiJdIufCMLPL2?=
 =?us-ascii?Q?OnW0IQdOnT2QitlahdvO4qdFPQv35hXxpTcbiE1kvykQpOX+XlKuAnuZMtty?=
 =?us-ascii?Q?z8MkS5eK5WAYlzBH/frc/4BZokIDacNg+VBqwB2g0+ze1NFm6MDeI3h7vejR?=
 =?us-ascii?Q?vNKv16NSdZ6Y0jMCtLC3U/VISK9VnBddwcRvfooaT+VC/4D071oSaKYEQZvk?=
 =?us-ascii?Q?5QVudt023+peXoYEhS5ygHRgpVdZBfvOb3YEGGY98hPOEV6Nq4wWlh06wcxg?=
 =?us-ascii?Q?iTNFPGiwOMUA4/Zw0cW9CoRzH82kwTNjrKgUSF545N76tZIzb1vmWA0P/eKz?=
 =?us-ascii?Q?MCLNUsZeFEp8fg9fPwOyxW7njF8/jMpZByyrM1qjNYq5E4v/kBMXFdtCp6nO?=
 =?us-ascii?Q?0t3pjI+AsS1Nq8J5iqbNOOOMUDwhwFARPWm5sNemD5SDkjukHhk6Jws2V3zL?=
 =?us-ascii?Q?LAzg/sjmO6q5MoOydwsRq1Ag4YAiFfJq3ZK1cwETc+rgQFvlwliJyyhonYyI?=
 =?us-ascii?Q?ekcEmC3A6ZLpjl+kuKRXKQAFqZh7IXFzBa3azS+U/80I0yJkJGstXDu/E6iW?=
 =?us-ascii?Q?KW934Xikbg7FNGvJzsgok7ckRrOmVI1Sjc6pmXEXWfA8aDBq5CBABlzLumIG?=
 =?us-ascii?Q?sWUcJNJ6UJJYYwl/wc4XnJint7iTrYRPCzwDdW55vDqgoBDCI7V53yILLuGe?=
 =?us-ascii?Q?gSM6a+sPTNWJpLIt6hTviCF1PWMQxcduA/U1+2l7376jEPo7FUIpNsW2gNCV?=
 =?us-ascii?Q?uU7Q01pxyt6MAGSHRmIIEOQJJhPSY29eaupDToRmIa41Y/VIUCgP9io7leUl?=
 =?us-ascii?Q?8BMS4jX+0yMKEf2v+rbzEZUR2+7dt7FWqrskPK7zY2ZvkUMrwUXovt/4LHXV?=
 =?us-ascii?Q?6fzofld00mqie73Pb62AB+T71MhSu3ru4kbvP4nHIaeAX2hqFztzVwug2Nsr?=
 =?us-ascii?Q?J4yN9YcHX5lQq6zq6C21TaZRgSGzZM2xMA+zn8uIw2aux0ud?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833b0dff-a375-4431-ed63-08df2de81705
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:51:35.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG4T0L3a8eHe/VlAoB+s94wyOcOk/lpnmSdkEtYI+/v4eCaLFrS8K/nvtYN4zLfbAt1ymQhWGLw5QK6sXUuJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB015052

Hi Michal,

On Mon, Oct 19, 2026 at 12:41:45PM +0000, Michal Blaszczyk wrote:
> The watchdog measures how long a task has been waiting from
> p->scx.runnable_at, which set_task_runnable() resets when the task becomes
> runnable after it last ran. ops_dequeue() never asks for a reset, as the
> dequeue of a waiting task is temporary, e.g. for a migration or an
> attribute change.
> 
> Leaving the scheduler isn't temporary. A task which is switched out of
> SCHED_EXT while it's waiting keeps its runnable_at. When it's switched back
> and becomes runnable, its wait appears to have started before it left, and
> the time it spent in another class counts towards the timeout. If the
> watchdog checks before the task runs, it aborts the scheduler:
> 
>   sched_ext: class_switch_stall: runner[418] failed to run for 3.010s
> 
> Here, the task waited for a few milliseconds before it was switched to
> SCHED_OTHER, slept outside of SCHED_EXT for three seconds, and was charged
> for all of it as soon as it woke up on SCHED_EXT again.
> 
> The same happens when scx_sub_enable_workfn() hands a waiting task over to
> a new sub-scheduler, which can then be blamed for time the task waited
> under the parent. scx_rehome_task() isn't affected, as it moves the task
> through SCX_TASK_INIT, which resets runnable_at. The stale runnable_at also
> skews the default core-sched ordering in scx_prio_less().
> 
> Reset runnable_at in scx_disable_task(), when the task leaves the control
> of its scheduler.
> 
> Fixes: 8a010b81b3a5 ("sched_ext: Implement runnable task stall watchdog")
> Assisted-by: LLM
> Signed-off-by: Michal Blaszczyk <michalblk@google.com>

This makes sense to me and I reproduced the issue (thanks for providing
a selftest).

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  kernel/sched/ext/ext.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 07857039aee69..120df09b9e0af 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2424,7 +2424,11 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  	struct scx_sched *sch = scx_task_sched(p);
>  	unsigned long opss;
>  
> -	/* dequeue is always temporary, don't reset runnable_at */
> +	/*
> +	 * Don't reset runnable_at. If @p is waiting, the wait continues across
> +	 * temporary dequeues, e.g. for a migration or an attribute change.
> +	 * scx_disable_task() ends it if @p leaves its scheduler.
> +	 */
>  	clr_task_runnable(p, false);
>  
>  retry:
> @@ -4517,6 +4521,14 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
>  	scx_set_task_slice(p, 0);
>  	p->scx.reenq_cnt = 0;
>  
> +	/*
> +	 * If @p is runnable but not running, its wait started at runnable_at,
> +	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
> +	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
> +	 * doesn't count the time @p spends elsewhere.
> +	 */
> +	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> +
>  	/*
>  	 * Verify the task is not in BPF scheduler's custody. If flag
>  	 * transitions are consistent, the flag should always be clear
> -- 
> 2.56.0.176.g3575e65682-goog
> 
