Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F182DC772
	for <sched-ext@lists.linux.dev>; Tue, 28 Oct 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686153; cv=fail; b=aHLHTjs+GDMKR0gGKonDJ5pY1Ie8kxRE1M6Dl/y0x6fzaM2tEm+dL1VbH72k2hY5jQzdcfg9cs1jCbvHNxqpn598XwdE5jGis00rYfYO+YpOfVLOQ2QbFThdhunQvLKj6JwA+s9XZor5hRS07if0hOOMxdjNdHWHyE4ZlF2UhqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686153; c=relaxed/simple;
	bh=AW4B45D4YSAvYXFZJ3AAFSbgushjyrI0PxQEYjqv66g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWTsiHyc98Ff+GVt2C3EFqQHYCtKOiM6BlXmnkd+Pa5VG/sqObXajFUDauu02tNT/giGNQ0fP9JKKzpvjoI+ZOPgO5wIln/i7ySHI7ksTwInnN7SYk6wcMmunRVuHclW0+/pJEnqRGHLsXrXgM0mh3q+s2LDlDVt1wRRnjTKwFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L1mWXNt3; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1mWXNt3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4jg0BAJvOcnZTdQryn9Hk/meToPVO/atP6z0RBSiBr3H9oIW0PS+Sloj1uc5qMhgGMCoatXGLtsj3Pmb/xaGtwkX4hWmV2aYfpTVD3eJ6ezP9iwOyC3870Ie+2xycWaqPArOSwj4Bs6kbPWfqsaov1K4uvUQcdXifEuZpJkPiC+8oi1J+o3ryu0hI3sZQghPCxu5AKmEMnYxu/3ryTbn+O3zoXi2RCpmt6wHU8QGJTPInu5obGFctffL3R57E1mJEzkj78cngx6o6hgmb8KEYH1uYyWZgmqGsHWxKX2HyIwVCcEihe367v+FDKvaHyaR+WDXxkQuZipolmwlmyE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm6t3lbNoQLKILsDY3Au0jRnM6nfw2Nm8uMZuGXAj9c=;
 b=l/c8lzsCv0oCr79glvwkkVQlEOY3FPgxujYrrwOk0lNbwyRbAY7r72Q4Gux5nFWPt/OxMsvq903muCDEIIF9BxpHJJKSwN+gVedDZkWgmfwF4EJKXAQqag351pGyHrZPLEXwu3BqRHgi6/a6c2bb2A87i618KDtk9lU/GFQuhFGIN4Hwqp67Wade61Z7cOe7hT00sYdaVKAf76QiFOvhuRkFlXJbbNxuJQ3zdEP3/x0ldw+iDKJjwhRM5AYFtXEv6S+q//MX04NBchtf9nEiQgsvki5AmXDXSe8EekZddSGAPCxQx3Z/h2BAjQha9UC5f8jsjCIbpTMyCVWWhRAOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm6t3lbNoQLKILsDY3Au0jRnM6nfw2Nm8uMZuGXAj9c=;
 b=L1mWXNt3b4kUlY0JMW7U10jgbZxQUZ/X6RT+wpsiq7sxicEEtjtc+2duQXgOuFj5DXkXb3DACE+b3UyRLNQ2GvcNexjgXkeRJlc4ousPhKVIBQlspm2zVuCayZTGYisACqqMa9j1kht1gK46EI//k1Zqoeudv7QUmwVzpVL5zwRfeSjd1v28tHyCdWucRIIIWEhFtw+0ZjdjHCWYOHYo+dsVQybN8uSuvOveN5qar5VfGhVbBDJdA+D71spicNYThX71ItTgn8Ltb5E9pVY9Gz4qTIceQ2Pv0qlFjpYEgWmuvIfW5Zm7atY4oa75Nr1TZzG4rFZws7zel4ktMTKk1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 21:15:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 21:15:47 +0000
Date: Tue, 28 Oct 2025 22:15:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Use SCX_TASK_READY test
 instead of tryget_task_struct() during class switch
Message-ID: <aQEyeiN_HEqRtQw6@gpd4>
References: <31c2ba69c73dc25b022533ca00300256@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c2ba69c73dc25b022533ca00300256@kernel.org>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e0bf55-5117-44e6-e77d-08de166729ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Auy0AABSDir4T+BSFjiCzWuY7J2z9rKN1hS/UarDNlW/chP/6rEZ4xSF7F+?=
 =?us-ascii?Q?3bR8j2QkCnSUGnyORa49zkgqdSYvJjcyJRs9oEOqFCzpk41OVrGA0ppB/Laa?=
 =?us-ascii?Q?8q9FtxXX7WRg9vwwGSd4rZAwiuJaHDIwKQuSKpzrDb5nGKpFvNl8N7iL5yal?=
 =?us-ascii?Q?bwds+6OwfIxWL4XlnuAHOLX5Q1NzMyvnYoRANgDQcs5Fc3LKCzcn47lBbnbh?=
 =?us-ascii?Q?Xv3GAmpt1C7shBsiaIPadOa4LMexpWXquAp0hLqrsKRB6Q79INO/vuPVY/Ls?=
 =?us-ascii?Q?WxEyeB+jU9G18BMGBKJTGPy7nU39jgnN9KTGarCOGwVfKiURfwq16bvGcEvT?=
 =?us-ascii?Q?rvgtN2Lw5lua/LA5lc9e4GudG8PXS2RXpPscov/hGvG8spoP4n2zJT3Rp94Y?=
 =?us-ascii?Q?BpwlF+FbHZxKwmCUJwlyoXMaYYfdoBSsQGmOx2z7X41ZWUIi5nJbWcagR0AD?=
 =?us-ascii?Q?KJURgZCE+lMn5ofhYsSQcbvOuJKQ50L21andAa+XfR8QOD9cf47WHMpyMqzU?=
 =?us-ascii?Q?B8l/neC4lpTLP/VEykklYXRUUIDQWfUBEbk2dhTOAmpwf181x9aZjWBE3wmo?=
 =?us-ascii?Q?fiCjhV3WS4i/YcLdaVgMTKSS6AG660EBtuwRxw0+VrL5w6d7NTIYEhjLW3L0?=
 =?us-ascii?Q?E+I1yoh36ysUD9ykl8ib6kFOviJw5B9gunYDl4mRAZeoa7bn+Ge8OsQRFQiZ?=
 =?us-ascii?Q?0Kg8p5anQX259p4Qvs7qTYB1DIPOdqtnsUyYeK0apkSlYqBTM1OEAYcWOAFF?=
 =?us-ascii?Q?IYbcEdRIXH/WNCeelk8YG1yV0Tq0WQUdB+5UuvHo0k3/JhW+D5kAoPzFrsg7?=
 =?us-ascii?Q?zFQ5hfjCdmahTkzRuL56kL/hakbgpK7a3fjoIcEKcoS0Dp22LP+3fLAvjsrT?=
 =?us-ascii?Q?VFqhJKm6M4xYvjP+XWY5SA2a0ufEgKri7fCzQ1BO8p3qIknBzMSYz9IuEkBo?=
 =?us-ascii?Q?JAX7FanpziDYyC3u5/aZHPHvpp+c2FyPLcIthuCOfSlFgAq7oCM0agkpj5eV?=
 =?us-ascii?Q?WgAF/AcshqD1vNkfGQndUZDtM+PRUD8QL3P1dQmfBF1MYsnIRp4kt8Up43HW?=
 =?us-ascii?Q?tW2FRV1cGAZfjk9wxaUuVHAl1jihIJSMuPkonGSX9rNmOWcZj0ZiLP6y47dc?=
 =?us-ascii?Q?FE6kMqlUfnruC+Q9eXkETdgqV4QMGBS9uRGvz1v2UlWSHB7OYTVVIgcqRKAO?=
 =?us-ascii?Q?tEtNHCDE0tbyMjutLPRnNr2MS3x6eiMMSqHKR2Kzh5lBoRM+eSMg8mM8hFxt?=
 =?us-ascii?Q?E8wgO9g20w3Qs/5QJCUcYNTz5D7aSXAAZmcvcfxL4vmxtHAHNMnk+9OsxgGe?=
 =?us-ascii?Q?QpcMY9JLtjIiLVA7+kSTG/D9qKEaLtv7bc6xhTYlQLoE/qhbAfOgLsi4glLk?=
 =?us-ascii?Q?jNNK7l+Xg0gJXxyQ62WbjoRXs+BZvK9m07Umyi8eJjVFeApDYKtFuCQ78GDr?=
 =?us-ascii?Q?JZg4dqAcgp2dFJUGgItiCUMKELg92OXl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHv+/qfy42NXZQI4nHNt3hdENYVxw+vdtOet1f7gUb58KnkkPeMD57um71PK?=
 =?us-ascii?Q?q2NrqSUXtAWSIYAoPjglXxEuDM4ilSDezye2Hmlko8Si7xj6lpkz0YY4ZoAe?=
 =?us-ascii?Q?QBS+jI17vWF8DTlPPeEfJgYnHdmkjNIRVzlKLKHFOH7PY1YmBUSVXLuDJoFa?=
 =?us-ascii?Q?UKrGTVTmOycsVPojNTbiS6l1g2eWlZ7I4ex9CGKBfsIMG1N65q/9QFYIwpIP?=
 =?us-ascii?Q?AQ9TP/xUh/q2AEdKHT25hBSvn9EUA/lrLBuOMP81XctAyL0vNmjhL5CUdR7i?=
 =?us-ascii?Q?l4j+sR/c8UaGWwcYPdJj8wUCaJ9c3I/hQrGblZ7SJ7X66tBudnEXvzgNwvho?=
 =?us-ascii?Q?HDoYq70jG78cAapxaZ9klYZnO3mnyTvjsM781kF4VitkDKvpDSgZih3G99fW?=
 =?us-ascii?Q?QvkZhDyMgBdRHBMsk4ErjObvcBaZnHiKtRlK+jZvpmyq+GCAfsbaalIdvV3s?=
 =?us-ascii?Q?Ug+b6O6m1slHFAUmHi40ykpFv8oIuYwH/vG4nAgkYFoRmUIWzdLf17F35td7?=
 =?us-ascii?Q?nMBL3qOsaP0DOwZXWdS9F5UkV9lD2U4m+RnhMG8n4YbpQ2bLQ9OXctJLGaJd?=
 =?us-ascii?Q?72sTx27qBymL6npOKFuuTjBqGry7vT3lFB70opo6BKRBWs47elurCkFuRK1O?=
 =?us-ascii?Q?b+5aqUXtHj3uyEvT7YJ7Y8xtLZ3D1+Ow0haD46EiL+kX74p030V2OSQqbOBR?=
 =?us-ascii?Q?dSYan0KBXIYecG0z0LzrWmKCFFcCroCXTME1iefj5iM30M7aqTeWuQv7kTh/?=
 =?us-ascii?Q?CCIKK4XEj1wPbzUhBFagqNAFvm7xM2g+e4M7zWDVRJHcPfyuC+tYaBfVXdhi?=
 =?us-ascii?Q?jDmyWs/Uw0x162V5vgoL0mTk0/347LAxyFprRh6AmjeG/gfqAAr0UH7fzsOz?=
 =?us-ascii?Q?VdCbQ+R98Hh8pQRnUDB2QiZoTkRCZ07jvv+392nKwgN6UZBPT8xmkdTDCE1d?=
 =?us-ascii?Q?cQ5/l0Y7thAUuINqGJUbhPvZLb4H6XWjR1Ha7vn0HctuEIg76d4KcGxeWhmX?=
 =?us-ascii?Q?SccahWv1+Y66TXKEGPW5h4iW9X52VJY+dZq7A51ZFTtPUoYIxV2BOW2WFcAQ?=
 =?us-ascii?Q?VpnC7HRIlasCwrNbDVu49kHTzqb1tLROh4yMwNiVsIscX85OZW475lbLxQ5F?=
 =?us-ascii?Q?VwFJVQMcE2julfjR1FfwtCV2cv3Dnkr9Ziah7DM+CSbI6ma/SHOjmVypQNCr?=
 =?us-ascii?Q?K7D/qm1SWmE7OaNoWvjdgSwBhB/Oo4Y1M2cJrVeH6lt4ZYPHHXlbPLPOK849?=
 =?us-ascii?Q?gogN+zuTNDW1l87TLdzd024k8mEnK1tBelB3uJ0tL5DzUsUNy/LBI3fiMkFn?=
 =?us-ascii?Q?Mg3/cQ5efDNyj1CibfI68E9iCpg1jHKKx2JifAchAKm3o2h5estLy/Bwu5G2?=
 =?us-ascii?Q?+0PgTuZmxcWAzfe9zi/WaZJmqJwGYf09erIqVWYYgVid7pq9BK4e36J4N7gc?=
 =?us-ascii?Q?Emo8bvjQ/Ttrnzu1x8LOixIEgyC1n23Y/mQdBOWKWyJ90ZO3YmJNTujkjQao?=
 =?us-ascii?Q?QPUW1/owdRjeeiCP0UMjjOl7aHPIbc5Jw+nyrhHmwESa7slGmnqQbDDzJGXi?=
 =?us-ascii?Q?2MFeJ8ZHIrwDvnhyzSAGV7ziZHH+DnoQfSI4RHDI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e0bf55-5117-44e6-e77d-08de166729ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 21:15:47.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nRDxoVpjUbQyO1gIwxlfaBVoagdnXYf/AnaK3icijXwzrhRxCKPCU+9PpK48NGOcdB+2MrDoNLytYbvTrF2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

Hi Tejun,

On Tue, Oct 28, 2025 at 11:04:18AM -1000, Tejun Heo wrote:
> ddf7233fcab6 ("sched/ext: Fix invalid task state transitions on class
> switch") added tryget_task_struct() test during scx_enable()'s class
> switching loop. The reason for the addition was to avoid enabling tasks which
> skipped prep in the previous loop due to being dead.
> 
> While tryget_task_struct() does work for this purpose as tasks that fail
> tryget always will fail it, it's a bit roundabout. A more direct way is
> testing whether the task is in READY state. Switch to testing SCX_TASK_READY
> directly.
> 
> Cc: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks like a better check.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4662,7 +4662,7 @@ static int scx_enable(struct sched_ext_o
>  			__setscheduler_class(p->policy, p->prio);
>  		struct sched_enq_and_set_ctx ctx;
> 
> -		if (!tryget_task_struct(p))
> +		if (scx_get_task_state(p) != SCX_TASK_READY)
>  			continue;
> 
>  		if (old_class != new_class && p->se.sched_delayed)
> @@ -4677,7 +4677,6 @@ static int scx_enable(struct sched_ext_o
>  		sched_enq_and_set_task(&ctx);
> 
>  		check_class_changed(task_rq(p), p, old_class, p->prio);
> -		put_task_struct(p);
>  	}
>  	scx_task_iter_stop(&sti);
>  	percpu_up_write(&scx_fork_rwsem);
