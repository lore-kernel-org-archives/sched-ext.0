Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE938228E
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806162; cv=fail; b=g6t3O1z12IhZkghdGzxm/oS5NZsvRQJv2vpoQ4GJY/2+MmKgxoTlJCetJvAudc1sEGoPdIU7e6+YkR0zwAtKMWmvBshFhog8TES+XDrVCeve+o0HJhpm9z1g8Hau3vjojHFmMonzuAjwFmbjKHqliNngovqJS+lTUkKuFf5DiQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806162; c=relaxed/simple;
	bh=9uro4CdIAzDiIlA1yUXCZJ3sL12NXvavVNs/Qm7Fows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L19dDXqDk0iSeXlJ5cCWEcD29uhNVm6TrZ7j2qaRPZ5VB/CzB/jhkaydnmCNrBtd207Ho+J/JZ4byjVM5NCNT7lW/MllaP0GlF57WfnKfonQwfaTQ7kXaEPelmLTFpOI9qq/0F4PxEh+9G0LGDk3phhNgrLqTR5CCjn4sCklmOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PsyqWP0N; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsyqWP0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCqcaim/XL6lujzjSRAxBP6ZZBCmC3lR8+tDvDTcLVrhCQbrNV5Zv81PI338sWXCHwdnRGe2T7X8rLAVgMFnTv+DgztMRwxcU9zCdJZ5iIU/koqTcwJVyrEh/TXAWwkXhXF1nuPkRR4lnStBvSFDZrJLO9aGB06NF4GrMhIvF/N23XMM8FY+j5KJ6KFd0LPSa67khtfK5o3cFgUVkEyESL5Zp73alF2lpqlKugisEZu8LNovW0n0kCWPYPYb3XaXGri0DRdG7I9ZkFMWQ2vaZnYwAvp/vIc+f4ebAPfRREotRP5OQgzra0J3DuQdQkEPBuxtl4eHslkz/IK5Q/N+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgn4qxJhYZ5dDNWQo22DKSwuhbL9aHBmjn0BcYnwPe0=;
 b=JtlcsZ/AVlfn/7vEod7Of4TebDk6GGKjwgAJ5TwyRjaJpGZzKh+Ifw9s4LaD/76sA/2gnKfsRQQp+hwOBAkyg0j1XqP/p3/7Mex+1gwkbjZLmP2thtYZP9SCPaSSJhCNr9FZJhnDI9vMYnTtcfhGTnZzl6AbkkirJSqspfGcASTUds19Jba/gbajlUfHMEpq5PFQLx4/yrFmAeCH4IVhjNaPb7I2KyEYgqma8QOOA94vSJOB+FLzwnNwi59s26wWwI+EAEqpomfGyi5k6jrKE87EdK5Fx2YetViG3vpoEGinxGQ3Cqf4FPL/Jpi5phZ51DCPcEoFD8YusQfQKbuN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgn4qxJhYZ5dDNWQo22DKSwuhbL9aHBmjn0BcYnwPe0=;
 b=PsyqWP0NGAB2fHWe6xmi1gn4TmqcwsjyfbVcNd1rHx5YiucC2H1PJ3foDROSwuSCT4M9Wt1dx+fq4+G09v6UHjCMphy4s9zCqSM8UmS38wOUgsEO8DYStmLJ5BghFUfCVD5KEc1mAS/IHvk29k/gG5AKS1TxGeMwDci9gq8wr39tQY4V9vqaZ+XQFwFnvfqUrNY2UryzjDaCkFBfoJR1ArIyMLM17CKzkIXB7P+LIcJEDQYB2PtucJKCcLydKFDhGdafq53t4pUr8V8eVGx/hTP5O2TW9FUzCG0Jie27pueVbQYLvXoqUoFWEYcZDJHQvy4LCumJ4YBUJl+H3hTCYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 14:09:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 14:09:14 +0000
Date: Fri, 6 Mar 2026 15:09:10 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, peterz@infradead.org,
	mingo@redhat.com, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH] sched_ext: Use WRITE_ONCE() for the write side of
 scx_enable helper pointer
Message-ID: <aargBvjGr_7lwOKD@gpd4>
References: <20260306105901.2543743-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306105901.2543743-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ea6371-8681-435c-482f-08de7b89f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	+N8Dyv40yre8SDtu3dmvYWPvAvImDggT66uquokjJ8DhDQJfKY65KtELnfzJj63+CKFUP7mVPZ4XH7VOkICnmCqRCTVqUKZR7eT6WZpVbxKdbIu3P6+i7nfeom3kM/MGlzCX6KKJBJeFkhhA1YDcI2M3riDH9PegbsTnfb9grMIV+BQCI9aZsRB4xxAEPHEBmx0mexcaNd3oz8iNMBkcC+QpzuU8M10ssgFvvn1WHiXelgzgnP005Gs7YNfxpVgAHM2s4v+i8RQK9J2s9jT/oqZgphwqR/0g7rXEbsB59ZNhTzRpqOor+lMODmfUDnPD3ZRTsj7kM0FP2UeA9snqpYnz7f7yPVND84TXa6vbh+PZBYqeJawhORl3N+sPWK9FRXud7J4OauhN+MgyIt8/kmRXR38sWrUow7Qy0ejOFDG+6nyOrgRlaA3tDDq8PbDKse7CBFV3LaeI+HCv9R6gJLu6vC8smaJ4twXTacMJIrdL1wpF7hYEZhEgX5KdbaN5TpRchcD6FDvwiNOSLhDs8UOyz5hfdbJ9BCaPa9stS3eTFOwNZzbjjvbx8q1RCnQ3hrYhUPZQuwZmJ75I575bQpD+33AnJPgR7TYwiq9zSESXQTKKzXQGE41ObQ4gP1pzTgL7ZiaSIgQJgZgEVQH3HlmLjPqMg+9kPvR7ms58mH2pHrMJN3ECBQ3aDIsfIprondwoySYro2xFBYmJt00tYNkZ8xLAEnLbHgMCJcdvITA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYcq5gkGZY3akmS7JwMusCmIdUNaHXrxyO8qxHM5148v3B4ucGvxI6IHmuQx?=
 =?us-ascii?Q?My6ZKPcrWIpnjY0fOJW+099ZHooSQtXEYcSJ3JZxhshxn5kLN15jd2CDf05f?=
 =?us-ascii?Q?IpUZXumaB8hbpnuSSIfIqW31+RZ16oZGQfw8YYAgb4SXKHtXAy4rKNjWSGSn?=
 =?us-ascii?Q?f4ZhsoHOWFcYWyUQHaPZCsZtcUfTSAhmcYClDcQhJnz9CNneFKmAIM0vqBED?=
 =?us-ascii?Q?rXKJ5xLlw6DZtThN1T3A0oe7/girQcwIJ6mxEGjnMsMqbd89TjLuFAwNfW2u?=
 =?us-ascii?Q?yXlqAenAOHfFUwcz/n79KyFil6lUxwscJKrrcYDo2O9zCJSEy83KPgTuWpeM?=
 =?us-ascii?Q?1+xMtH3R2NQatmx2JuwZfVCb6/q30IBnSDUZA31RAfdcLnoWTPyTaja9BlsL?=
 =?us-ascii?Q?WJdny/eabOKNBe9Ct8saxDidfsuqi1fZia2y42DEPVwocuOMxy3yNUX63YWu?=
 =?us-ascii?Q?5ffgI9k0UPCsfmkec0BscfD4vAxWc8d4AZe4SB+0egdsY3KdxHaYnP6QVJXV?=
 =?us-ascii?Q?MxB9ZC6NurXjQV/fCq4HToUvG3+kdMawdGYCcDpKwwrHSLPHCvkPCGpmmrRg?=
 =?us-ascii?Q?4aihn+mp/U6HN6wPMd5Kx8Ub9Syvfs9dm7tJ8swrsNxclXJs2PSXAOdfBrWY?=
 =?us-ascii?Q?g0OZbTUghCdJJSjubwdeTaSQN8nZqvekmPQ9aB9w6dSOnE7DUhlEUn3zy3EO?=
 =?us-ascii?Q?ItYNUXUkpuZoivw6qS5AdtO44tpwgIeUBFgtdAMwU5FM4N2SMiDTckezoG5K?=
 =?us-ascii?Q?ydOlZh1DocmjV7juIlbc5g1/pSWRk1Oz7ZAszNd3BbDZ+OhBKQSfFJ/rNKKP?=
 =?us-ascii?Q?Qb4IQrnonWSOYzAdBVNA1GATYCjiUdEhCQIY5CtIJd+8SpTbOEj5pK2lrOsy?=
 =?us-ascii?Q?g/FoDx6Kg1xe44eIrTk8pj/YS4WuuOBM9gdkEJYH+fIq1WlX7PmlGEk+gmHb?=
 =?us-ascii?Q?8cxyn+Ge6gSa0SF0RotRIYMN83+kyksnK0bsIIwM1SNop8SVtdzjLfMKqA8d?=
 =?us-ascii?Q?DZAqDQMlw+Mzx/w9bpjHGqXskl+FyRO/Y2CjiWgRH7khBKpnCn7rxD7o+fRl?=
 =?us-ascii?Q?e1JfDBQQdizXYtf/03NlI6fBpZ1AkR9SGcvqENkrR5wXwnlBOaYH28VxIb1b?=
 =?us-ascii?Q?4wfpWldUnWzBLXgUqB/VQ9uDHb9aJ615HKS5cP1A2vCRELGzwgEVVk6lyWEq?=
 =?us-ascii?Q?OFx8Iw0Ya2zDRwbcXnzGQfRdCIlMGE7NKP2IZEGzAJdt1IgQgSeGz9zhEZGB?=
 =?us-ascii?Q?yJ3LMdBVWHMPw5uEA8DKrtqTcsgLgfnby1JZz2JbWkFeNIZ8GKORFVmG/Gte?=
 =?us-ascii?Q?RP2Ki5c9VHUqE5ZCpYpZGkoom3Ia5KOBoGZ7Jv785S1cZBQkqcvSQVtT8c1K?=
 =?us-ascii?Q?+YtVJxTAk6uahc1xpU//cxdV6LFuNU38+Ow+tMcNjWM2niAAXRPhuwVDSTa0?=
 =?us-ascii?Q?RlE2MXyFRzeti98cqIbpbDJxnnMo8WhLXSsEUbxMtzQYPJiQoP6D3W4zZSIf?=
 =?us-ascii?Q?nsFmDti7iZNZMfZYyOq/pRNbsiUyXxfxLgy1UYfWr75uA0waUMZ/QRfVdfMl?=
 =?us-ascii?Q?tAVjFbBDPZtGrxcpK+479md8Lv2QJYspcVmcCZUpnUB1NkYmN2PjfFiXtEsm?=
 =?us-ascii?Q?z77d5PRqPxH6XaJSCTmctJBrCULqMoQh6a9ENEVxk56Kt/Nx1MqC3Lc6Ge3Y?=
 =?us-ascii?Q?01vmwSK2ZJWx8QWS59FgnnOeAj9TpRlaXae3CHyVCajyhCtD66MVN2rUYI5j?=
 =?us-ascii?Q?TaqAXs8AaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ea6371-8681-435c-482f-08de7b89f260
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:09:14.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T1WgzDh0s6Fd3MNzjEaKwfX1P+eVnByzjy9U20t7HLI+w8bqJTFvW8SBNGUXBqnBScAjIKfFVYS7lWStYuPqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

Hi,

On Fri, Mar 06, 2026 at 06:59:01PM +0800, zhidao su wrote:
> scx_enable() uses double-checked locking to lazily initialize a static
> kthread_worker pointer:
> 
>     if (!READ_ONCE(helper)) {
>         mutex_lock(&helper_mutex);
>         if (!helper) {
>             helper = kthread_run_worker(0, "scx_enable_helper");
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                      plain write -- KCSAN data race
> 
> The outer READ_ONCE() annotates the lockless fast-path read, but the
> write side uses a plain assignment without the matching WRITE_ONCE().
> The KCSAN documentation requires that if one accessor uses READ_ONCE()
> or WRITE_ONCE() on a variable to annotate lock-free access, all other
> accesses must also use the appropriate accessor. A plain write leaves
> the pair incomplete and will trigger KCSAN warnings.
> 
> The error path also has the same issue:
> 
>             helper = NULL;
>             ^^^^^^^^^^
>             plain write -- KCSAN data race
> 
> Fix both plain writes by using WRITE_ONCE() to complete the concurrent
> access annotation and make the code KCSAN-clean.
> 

There should be a:

Fixes: b06ccbabe2506 ("sched_ext: Fix starvation of scx_enable() under fair-class saturation")

Apart than that LGTM.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9a1471ad5ae7..c4ccd685259f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5355,9 +5355,9 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	if (!READ_ONCE(helper)) {
>  		mutex_lock(&helper_mutex);
>  		if (!helper) {
> -			helper = kthread_run_worker(0, "scx_enable_helper");
> +			WRITE_ONCE(helper, kthread_run_worker(0, "scx_enable_helper"));
>  			if (IS_ERR_OR_NULL(helper)) {
> -				helper = NULL;
> +				WRITE_ONCE(helper, NULL);
>  				mutex_unlock(&helper_mutex);
>  				return -ENOMEM;
>  			}
> -- 
> 2.43.0
> 
