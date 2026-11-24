Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795507382;
	b=YZlP2gLQcDCt6U1ocj8mAqCOgbM20NdzIz2LSQBESXaA99lxgZSOreTHGULLhsB9QloT
	 JtP1YQcKE4UePnhd3rTm8WXIh3CumAZ5eS3qqoRXKMkLW9Sd85TUA4e7n68LRxTeWE7hx
	 sMN/iGeUgAVMtVy1oIJFlJzj53K1Oysvi2e5FjilLcdvN7YVGM23nTdbOYnORqfeuUnxX
	 FMOfNafTYtAs79QtmuscFq6GG5Buhdwl90yPacKh/gc/tZX8lQ9u+HdisnwWv02TGuVW6
	 a0yo1gQLmFhg2XWFzuXw5+gdWlPfVEJhWkubokUsBySjN0YgC3/lp/bTmlKZGOtC7Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507382;
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
	bh=B33fLrYpcCoGBkLiRRKN/GuENQqIUYW7DM+kFPkUoxk=;
	b=ZIwighCLNYMNkM3iyXnnkfuLv/BrMUSj1Dg2A59Yhz/d8x25RdWwQ8Zb9q5Ic5ddolK0
	 iqpIzQ44KzAOfIkabopxyITA5HLEc1Pyw4qLL8TTneifzh3uNOWiRNqIiMi8INIYCh5ey
	 CoO+ONjqwhBOpAF2beFuT7QrqN3HVVc/osBn/yhJI9TEFQDYt7SM63A9Jo5XoxIbTr/U6
	 STiYE0AfAX8At8MMl3qrRNQ+Qk6dA60gZLjPFWGXncQG577StjLIqxR7yLhJxcaBDyyVH
	 e/GM+n9J6DEv7lyha3tQlpn+URQwxLJQcSiY+OwVme0dNkDkbZF8cv6f5iLWEeV+/Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Woph/rBR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.3
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FA606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 08:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8FA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Woph/rBR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6RwDo8OaHkesnhMJoceR9A08fNNUd/6TgxBSNcW3VV5VTQ+lmjBXpX1AKOfpTF/IX+KnvP4tEWcvW3WDSXVekNl1bU73gAMyPu/oIXzCAJTHYc+2bRau9lmQEfSLm126BjYAnGysf0vW0/shqczrVMWOTGEwHHQfQ05bMRZri4v/M59qFKxEQ014zCXI6Tb3h3pmtKRYxniGPL8BnBlbwmS8v44/H06KN6Q75VBYhHbw1YJJajQBoiRZHUB0suYGwjSv1uDxPBlukQJMqIkfPAKdaEMQiP7eUG2nzHrCHLS5xUs/2fEU01bq2kxCRHLdeY3AyOlnYEzSXTEV8zbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B33fLrYpcCoGBkLiRRKN/GuENQqIUYW7DM+kFPkUoxk=;
 b=fPfzxcb6hz9pGIZv/M96ltafjkW3hrd8P020/815VnSyxtgwIJPqHuF58AyA8oQMBEuA4rPkXXMGz0rnUQoPJBAjZHj3QsUm8km1wkt4salSiQeZHIPUVhFSN0WpL2rJgNBDVUZxe4SwZowaQBVHp+vGqa6U+lYYogGB8SbNup0JJU5dXGa9En9ejZBokO7bEn+ma5a6CxHERwSaUzjIfP4Nt5AsLFNVlFzujvrauUtw1YPM0iBoOtrAXzKvaUFq8pWpl2NOhbtDY5KEsvnSAkqgIdw1psCzdK6fm+BO23LpVIHVxW/gwGjnwdwh+c8pF1uTzfsb1FeYArMh72mmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B33fLrYpcCoGBkLiRRKN/GuENQqIUYW7DM+kFPkUoxk=;
 b=Woph/rBRAteB0Cv+xluU4IKFcXlJbCH37JIE6DXcZXhrjGpPJq+21/Js0LGOTv+A6FgXybznVsPNsOM3M1i+OpWkLC4FPUz1gMFxbhd1OmDnelMdMzhdB111y2FqA1HgxM5G28AHwByPFc4SIYKBYWlLqvQQgLzHMRZONz+OHQD5zwSTTRXvFMEs5DCZtB9S9zHymPTeJRaEtnzYfI9M4+PbPvgC7UaojhBzPrgEBEUXKjmQapQl+r3COScfY5ZkasjLl0cP9eQGGx6HK4Eiqu6Y4zi2UgawYYVEzuCvscSm7tj7cZNyCYVGsziMYMkux0myppl7yY761//NrO0AMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:02:52 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:02:52 +0000
Date: Tue, 24 Nov 2026 09:02:48 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Take rcu_read_lock() explicitly in
 sub-cap kfuncs
Message-ID: <awVEqEZdHReap399@gpd4>
References: <20261123145927.577162-1-jpiecuch@google.com>
 <20261123145927.577162-3-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123145927.577162-3-jpiecuch@google.com>
X-ClientProxiedBy: GV0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::21) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d834d5-66aa-46b6-be9b-08df4a0156f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|3023799007|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+NiO4NKrifUKuzb1o/W4zzCn/s8ul4jjQb31VGpWw8YRJGk76h0xjNToBF4iYCJtA3s0wY+Mw/wRSSKZSKW3y9Im3hixtRFOg3JgGsf/xMzFiu8TvgLcFaIWYEFla/FdG2vHzsgCBpgS2zCBT9k8C0JyUBfsUXLxW1XUSKC89YHf1YIRsKfPcNwBm5xSZM3l/BnaIf4/CaI2RKp3cDeYjri3sll2C+LKxHr4fkRXzGLZ/WGLPiX6PBxKrXFCtLqQ33TrauaaPglv/PDLdP3/OO5oQE2WEMVjX4Ctacma8aMsKObUdMQzG0snkHnC5eSjSCM/+qapXpV15FNw+fsP+m79Juc72czLsHijGBfrrORF2FCJKdP4P7mjEVIr6ASdizUgRSsK9zgawTxqzrJJJGctigy2RF3yuLjyBmIDv9RY0hHyfPePpbOwb+ApHGSjPvZ60Q7I2JwuDphzp30Z5MhmxiNrvDHACkcFjVysIQHOlvw8VqaUA3VAjxYb5zfF16Kk1WghwNpOtW/NSwJGr/YiYr8Mj/voQeFcv49axtvENLfb7//kJCYdlAuMCxN6m2fjSqFVYIVj5pq2tDh38b53OeOUZkkWQywWLqoOFN+D4ezSq7/EZzzAmh1n1sg7KvQD8fAAvVrwfREbBGKULtWIC02WifxotiNP9csO6VE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riWid1mAjeS2xaVbue3lTbc5pDVRuw9aietbXog8RYCbSQTYtyNjHmmboSfi?=
 =?us-ascii?Q?MGzBK4uppcTbWxXjQmD60cfNIT4lEtE9G6WqPRtbZMmAFSMZcIyxzLN5zdRz?=
 =?us-ascii?Q?RL3+4UiNXs8gHKSsK5JT9GawSGeDq5382riX3MNpxH5nGAdsahmgETaJ4OgG?=
 =?us-ascii?Q?VAk++FQQiG+ULDtKXL5eRLdpP25b+2z0QrxzgRc9KoBg3sj8qTefjtFlwPWi?=
 =?us-ascii?Q?psyNKeRxdRhJpvJfCSth1emRpF6YbGzYJNeYtLgEV72tHcTZIblUvpDtPOs4?=
 =?us-ascii?Q?l1qJXsHYbSOB1FGDw9muu5Yg4JexavaO0oVWdQEJ2IMabUliJQ5VGEky7hDT?=
 =?us-ascii?Q?F+I86llAXY9aHAmIO1Sfu8k+asrNL9wfRA9006mvXHxXPi0d/Z+tlYTaozuD?=
 =?us-ascii?Q?+T0dSVAXbXlN7KAwmqlqFqQeDBVchsGYJcO15RocqZELO6+oNpl4kvv/4clg?=
 =?us-ascii?Q?yylDQTBgY6W950bXyQutGy2nXv9ndy+0bSHk3+AnCK5UzYEi6p/KuEhKclAl?=
 =?us-ascii?Q?Mu2vJWloNXJCelIAO1GMdJ1UZD418I8S+3nsm+mJgkqmIK68BwipdmY/vKL2?=
 =?us-ascii?Q?krcUg4C09D2Lpu6xxxME98Jd/xuA1IEH2kPrff+sH01gdEFGESIJPDwx4B6V?=
 =?us-ascii?Q?FvdjMZ5bOlbPX9tsQ731GlYSJz7rXDZi+LVmwqFxb7cskOoVt5An23SI12lD?=
 =?us-ascii?Q?Ix796mhXU19tRRzMVL2cNvopw1f25IdG6mFUeMd8z/zFRRG8CKfxqV9c9xOc?=
 =?us-ascii?Q?QQxCHFmdt9/T66dZpuknkfDXau3mpWdYG9Z8KI+JTIHrefnvFo6+X6xC/j5I?=
 =?us-ascii?Q?DtWMxUQw/utD9+XHYv5e2Wl+PjvazNJJxHQsl99u4rjG0i6RXo8o9gl5qSdn?=
 =?us-ascii?Q?wkE/7+zL6j75roL9JM473EDCH0VQg4+aQm/KWhjEyOzonjZiOqLWgQ94mSqW?=
 =?us-ascii?Q?b/dIaOA8RaDiHbC7vOjXB/o95DTSPl0a+2PPCBDhFgO9hfddL8FE2aoKqb+4?=
 =?us-ascii?Q?jmFhI7eljs+VLwapJKF6PctgqEdeWTb9LKhiAGyc77iW65pBtkQZVVPyLw0z?=
 =?us-ascii?Q?OHsMBIH1yxI5SOQiSIBgYVNLI8CimGjr3PC4oEfphpkI2JYCLO2QHDZh+tZk?=
 =?us-ascii?Q?pGoNgmQrm2uiX0O8tUpoRxBrAXTL0wwyzhFoLrXc1K77ss6UakNcAK1Jo8BI?=
 =?us-ascii?Q?iqHkWbtPRO6F52YEt7uySzb5vT6CdhIXDUTPOLvdxNlcLi4o3cz/YIf2O4nI?=
 =?us-ascii?Q?2YUc0xAJlhBpYAyV0wuDmjKBoH9+usMhTjVZeoRztBTIJMd15axzQZ80meAU?=
 =?us-ascii?Q?bJ1LdIYzq3pQwhWY/3466BN0GH6YZYxnkoQAPz5M8WNRqG5eMhEC3ifZYpRY?=
 =?us-ascii?Q?E6O6iEiE9deOzfZvBl99m8yH5VJSP5wA7t5VykII3TpzO7RIeTyhokJ4H87r?=
 =?us-ascii?Q?9vM9jJFC51enOJ0YMa95+YNNgMYtZXvb8Z/85aq/+EDOKO4Xbp2iSLOvHlEZ?=
 =?us-ascii?Q?klodWtyzN6Fw3HprzEtQ+JYR43DlIVduo3SUR0WsntXmAi7boPEtEcnQJkxP?=
 =?us-ascii?Q?V7ljV7NvUxA8EmVWgYvo1Z6cbBqKZ9PEGD4p+gdtuizwJHN/4wsOfKS4zpT5?=
 =?us-ascii?Q?nkwy97s2ku0bqRFAmuBqNgATDh2S/w+6xJGXdHjnx/j1pHYbOSE3vTaeXAnk?=
 =?us-ascii?Q?m4Ph06zbntHjqKnXVAc37g5r1O2oiNrSa9894/4sx/aDyLqR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d834d5-66aa-46b6-be9b-08df4a0156f5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:02:52.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br3VS8csJP71l5B0jLm4Z2QEuA98G9brl2bdQlJrgZtr10KKE0RZ1/Ium1Qu+uruUzE0W8aY4t4+9uKXtXygng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Hi Kuba,

On Mon, Nov 23, 2026 at 03:00:38PM +0000, Kuba Piecuch wrote:
> scx_bpf_sub_grant(), scx_bpf_sub_revoke() and scx_bpf_sub_caps() look up
> scheds via scx_prog_sched() and scx_find_sub_sched(), read the cid
> tables and, in revoke, walk ->children while holding only
> guard(irqsave)(). They can be called without rcu_read_lock(), e.g. from
> sleepable ops or bpf_timer callbacks.
> 
> This works only because IRQs are disabled and none of the RCU checks on
> these paths require rcu_read_lock_held(). A plain rcu_dereference()
> added to these paths would trigger a lockdep splat when called without
> rcu_read_lock().
> 
> Take guard(rcu)() as scx_bpf_sub_dispatch() and scx_bpf_sub_kill_bstr()
> already do. No functional change.

I'd drop this patch. The IRQ-disabled region already provides the
required lifetime protection and the existing checks recognize it.

If a future change introduces another dereference here, it should use
the check appropriate to that protection, such as rcu_dereference_all().

I think we don't want to introduce additional RCU read-side bookkeeping
on every call to accommodate that possibility.

Thanks,
-Andrea

> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> ---
>  kernel/sched/ext/sub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index d2a20114eaa2..45aaa333f9c2 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -2870,6 +2870,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
>  	LIST_HEAD(to_deliver);
>  	s32 si, ret;
>  
> +	guard(rcu)();
>  	guard(irqsave)();
>  
>  	ret = sub_cap_preamble(cgroup_id, caps, aux, &parent, &child);
> @@ -2999,6 +3000,7 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
>  	LIST_HEAD(to_deliver);
>  	s32 si, ret;
>  
> +	guard(rcu)();
>  	guard(irqsave)();
>  
>  	if (sub_cap_preamble(cgroup_id, caps, aux, &parent, &child))
> @@ -3092,6 +3094,7 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
>  	struct scx_pshard **pshard;
>  	s32 si, ret;
>  
> +	guard(rcu)();
>  	guard(irqsave)();
>  
>  	sch = scx_prog_sched(aux);
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 
> 
