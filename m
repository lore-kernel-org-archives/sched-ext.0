Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4532FF17B
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903506; cv=fail; b=jogbQpRIR6tlBPTMHxrFy13I1efaVZaxf3f/v16YXVq8X6GqwFnhS67wfESlKSQK5CocRzV0dlgt5AF6itYx448k6rBYpjCOfq2CyhaNctZL2FgXjEK+Mo4Yf4pevDA5PKB818WW11ZsPZIK+olR23hJvQttjTU+2MsZQu5AA3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903506; c=relaxed/simple;
	bh=P0t8k+U2GZbQSSryAoNohPGiww6b3Nyql5t2dvvd2jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yj8CQB33To2rablVAtGhjJ63ERbsEo3a6ns4PXJibYfCBfbH09uoW/vPFdwsxyR6Epbvn1CCMddzQ0WcNTICJA3lt5c+MIgturz8CnKiUIoWxvPvOmj0zca4GJlZDqbQy3pDl3TEaowx14ehO8XFLd1hWQfCb9hcno40sR/5PgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnpUy9sF; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnpUy9sF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsIi9fop9m02dJ5CTSClzUbNb5kZ8pwqB/ukHqhjiALX6jk08HSXQAX6NT8BTbmbGIlmKfTsmvrHoD+51sla6j2ogz6qgI0Etjo5UMC5kzhUERezXwFWqt3wJ7JCGsAQBDUJWa5BMLv0IynqTunwEbnSchABhCvI07RSiCYolMv5jHGC3oTOw4vX5LqYbpzqg9X2aWgrLoFZxc4YXVGtnpI0tb+abEjaZ66LNL0J+tqkNdVZFOnb3D2l/VnpuwUdEPgr15Lng5vUGbbzQcdtAqLxoMOxUnXfqOlDe8SgfqFkHiH53eYFs6g7MnVDyaVxIoFX13CC1Bef+TN6DSzTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXq5eG5UeZE2h13Jwbg7myK9Qea0noJox0NB8tUlQN8=;
 b=hFGnlcNJcl1HHotuBtuYEnzC1Gj6dGFLbdUgZSmds8VbQs+VwEWnYtSgGiA990nvzeO4cK9VzZ6Dac3slZMhEUuqxGPKjP+7Xh5PTcXFHw81NODvrZl74rB+cDm42gG0cd1mqk9Etdf9LxaUd+OxtyYB2CHKYIxLqaCxs6vkA3S9SrpOGhJW3sTCdM3L6/n64//vSPwYlhiAmuWRy8T5UDj/LBBoRGs6wPy0wsGxm5pXIHiYMKahuVqEwBiHumhwGYjjOSlsU6VpQEIFG3CmsijKrRaTN1TxxvzGr6MLDbMoXPebSwnSCpwPOjV63znG3xZMFKESyF5xC345zC6eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXq5eG5UeZE2h13Jwbg7myK9Qea0noJox0NB8tUlQN8=;
 b=UnpUy9sFZu9OGdOendJFiq9o0erCF+ceJKIsQvcVOY6+QzNC3c18BUIuyT13sjo0OA4tt2rgP9FVrfbgmzEOOShUTOjUDGpzU4Z/Lg36BdUQS4CkoEfn8PcBeFgVtRzHvxmYMZexhcAkzmlwoHX7KjCWlwLnEp5w65tH9G8luxNclgJobbRruwjnVbu56tUbZulprh2OQfOstV4TdSdWJPJFfTqmgat46/Hcweil0hdiMJPZ+Rgdja6vkcXDxiBW8sgYa2fSVDQmhTiT0sdR85QBkpaBaJrp9hE5mgwWEYLXfieie9VFJ31ft1QPIJ249QytwlVggPnmcgJ1pOD+sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 12:45:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 12:45:00 +0000
Date: Wed, 3 Sep 2025 14:44:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLg4SsZHY66n3Vi2@gpd4>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLeANmpO03QiPgSX@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c2b7a2-1ad4-4643-7061-08ddeae7b252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0keMmDkjyRy9i2TbqJOfOf8cmee84gy/YOW0PEvRlWJs+tVNBDLHfYKxTWn6?=
 =?us-ascii?Q?xCBBT00p/Lf9bF0RXBF57ZQ6E2qAK/tjv3m0Pc6FwOxlOt2/NMhL5QSgRqPD?=
 =?us-ascii?Q?fjojYlPWYRiQom44XVgBL/DquXlHuz7SvYg9yUu9zoIslnrPqZ3kaH3VljXc?=
 =?us-ascii?Q?JPNkjmmZBuqKYAcT9kAmkDw0yXV3H51fxFPQ4cUBtQtbu+5Q8lTiNZTfgiEI?=
 =?us-ascii?Q?/YPrVjUZAvNkW83G4eqrTSU9VQYpJJ3yJ6rB5680I5HI8OqFVCDNJvbf85k/?=
 =?us-ascii?Q?1dCsHwiy4Tsss9jsiHYbjA8FEwG0HyJctklcZ3OYz3X2YVnjdy4L+KaXS4br?=
 =?us-ascii?Q?72X1v3sV6uzEKU14PIJhwVnWyvRWV3KfU+OwpvdvFbfATOEgbcVZDriGMYqs?=
 =?us-ascii?Q?Ig3l3MAti2lBTZIFkHthF3VeM3RIPcviU3liM3FjI6S3NZ0kWufr+ww88WSJ?=
 =?us-ascii?Q?2hGLaJ+ZEf9H6yNYjsfnmWXXxChMx/U2/CdE40wEpUnMWpk2UgWJvB+URNOc?=
 =?us-ascii?Q?lDKJGklRucf38xNeyCjHiSPR98XT1eRkzYgaxJzkxElLcGgED9Bxpt2F8qgo?=
 =?us-ascii?Q?UrNwKZgNd1FgW2eOaQMfUUjA5pR/5u08LmK1ov3hnSJdk4/V/8+4o3MqLHsz?=
 =?us-ascii?Q?itJeSx+veMSfS5k7l7bDGCIRh1tH6oH6XMgJWeMpqszsCpKr7eh7BxNFkRRn?=
 =?us-ascii?Q?7uvdJyLk7LttY4xBMPT7pCcJ/S63PUVqcQOgphPFkwLu0GsIIr1SiIwadVva?=
 =?us-ascii?Q?5ETAY080Du6R+y1Qchjm5DNOO2b6Kb8VV6aZGwhR8fKO5xvsMZD4GNinkqm0?=
 =?us-ascii?Q?pfW6qim9CyXfBOTTWvz6VIvhisI+acaB8hmYQLgOrO4hYseAgyJizOqWhgBJ?=
 =?us-ascii?Q?JkZ2ZKBsTdEZQstL0DWHMxbRYnT1P90qVOFRnFoabCKqAk1WDYSieyMZn7o5?=
 =?us-ascii?Q?GD2obf0fJDjiDgzd8+HA0S0SY24ZDPIyZyXFPGltl3umKZgeymowX/GOvfAb?=
 =?us-ascii?Q?w1W/LMrxIaf7StmhHHCIIztAlJ9cVMa3d/OG+ahqpkFnDwTQWyv0UY9ixUHm?=
 =?us-ascii?Q?bwQ8skqVOv+vGf7h5mOoWcrOpeL/Tst6R6s6n+QJ8Cbdz20TxZYpAz5IZMLA?=
 =?us-ascii?Q?Dp4WpN8BWBOi6r9O9yUl2BQvfCzyANUGN6ebJmwbf+QYIgBTlBpzAih7Vg4o?=
 =?us-ascii?Q?uBvatANjTxOB37dyGckRTXZvnNnjFowANdDICz49hKo90+EmOy3CNAZXdUGh?=
 =?us-ascii?Q?l+lNUDvCVrYxlg0YefhUkCYoIKZRtwV29kcx4yyPSk3MmFnC7BWCQoszUetZ?=
 =?us-ascii?Q?XVoIv3Wle7eFtZwEcBABInuCpMBMNJPGIfMYxm6pHGSDL5pa+Ku+thSCTMzo?=
 =?us-ascii?Q?LEU/cRKHgQiwdEEL/36RB7tp8Ryl+TVqiDWE4vScObTNmvzorPhWBNwcJ5ea?=
 =?us-ascii?Q?BuehJGagEpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxmIC+kP3P0ZfbqHX8m25yd51bY40E7ORPI75fHbfndjMCi1fixiWGXv/j7m?=
 =?us-ascii?Q?ZiJaYF27Cy/bSdiACnm2vLku6nMxjE30ZLE3R8dA8idbJHgJj0YNpzTS0F8f?=
 =?us-ascii?Q?1Lfi6mEXne5G0FZYiTLAGU13tmqTPyB1JLqs7oe8z4MwH3Eh8b07yqNzuBVq?=
 =?us-ascii?Q?gXRcsX6XBaHmQqb+p+WcwcS7zHjK3K9xKzIUSvtxurbtakK6M79lAPIiwK17?=
 =?us-ascii?Q?HDQU+6WuzvtInT8weRsoKZSIuU6IxhJk1w/6qYZi27hOXzDreCR2j/HFR4MV?=
 =?us-ascii?Q?6UQVeLuG8tsdde01ha4w0dCMN9KaKXzyy/UYEipLv+1ggyJ9HLOmeqX4GyTa?=
 =?us-ascii?Q?7pSIWCaxRlv5FjyIOryhDW4QyBygFrT1e0Qrz40W1ax88X+2Kn+j6NXcffWG?=
 =?us-ascii?Q?R1tcUySr57P7TAWgSiDVNkzPpf64SoUZbAfM8WuRzQ/54fXdnEttKtujF6ml?=
 =?us-ascii?Q?uhOb0W1x5fJB8aUe4ujMjBt/Ts1hiUJW33PZah6Inp3g4D+lW4/Rn2Z0AHZa?=
 =?us-ascii?Q?v2045tQiO8o/Ac5BvVWF2ci155RlvB7BcZ36tNamFO9KQGm5Wog91kZ9rn8o?=
 =?us-ascii?Q?qcKKICs2H71wDeJXFr+qIgkj7VlFsc2vHE55K2jkR4FpVjbIvibc8duhx2PH?=
 =?us-ascii?Q?K8ZLOZ9WAjIR9LkRFIDTM9U8WIcOXsy28o2qbc+/MOMrwTrwfDNNjNBiEnW+?=
 =?us-ascii?Q?Y83k4WxmaCe96vpum4GrNgGnNyAXm6NcZcTUEkR0E9RGLBbWpJw2abuHG0GQ?=
 =?us-ascii?Q?Lf7lRinWfMm9SrFqaCUnXXeK2KGshP0ztap9ktovYGNrm5ieDnrih4d5US+3?=
 =?us-ascii?Q?+g1S4WnRCgzBz31YB3VCRMDlLdixr9gApHHCavvhhPhXX599D7GcV23osvML?=
 =?us-ascii?Q?C5X+vU4Sgj4pV7C4fU2qGkwysmna/VWKOZbOPkBJmH12zQ6If2INJkPue9DP?=
 =?us-ascii?Q?j4cpMuss8GLa0WDn7hwUwKT8XDE9gZqypoOgfl2+sOryUStDpQIpjcGxj76j?=
 =?us-ascii?Q?/gpkiASsGb7y1Bbur2X0M8bytsQFHpJZLMfem9Z9j8W5T12reWU4qM57cjP6?=
 =?us-ascii?Q?JqBU1pWe31VjMqMvb6WjcpA0bPeRFEfRs/dxeYA98imQ+qPRHJTtX4SJWiho?=
 =?us-ascii?Q?bUyPymEplIBpusnD+HBOnYrWpGb5r+0KIquzxudQRuxtb6l5zMpfSAOnM7rv?=
 =?us-ascii?Q?dwu1jqUAx0WAQFHRn9MKhu4J7npJBLGCwKgrtOFHUjVZlrdGp6yLCCJRiUqQ?=
 =?us-ascii?Q?j0YoFxKMK9siY+uKVFyZu6Cd9+OxwqTAdC4UgyMZAFnwTkLjl7rm9ETyBOhC?=
 =?us-ascii?Q?QOyaPU1B/FNU6O9x72lod2SVxoqFJ5GTY8ZazFAKg3Nx51nM/xxkUE7obIJN?=
 =?us-ascii?Q?FY/qh6X7HjD1kKFSHnKL0bvpXkXZeTc3spJMOq5hjJT45QKj9GsJI+1gPlcK?=
 =?us-ascii?Q?8L1/Hwjut/LB7Wa6SajvPQEqVjYzmiKrKglMwXOGpY5KuIu9VGe/UABuQyut?=
 =?us-ascii?Q?6T0l6j1Zj0wvKYRfW11sIZm+2JwjtOPRh7O80+CTR2+YZO37WwtMGIQaXdqr?=
 =?us-ascii?Q?oxpfPwm8EL+4BgH2rCHBvTcWKaNITxQf5sAqTCWX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c2b7a2-1ad4-4643-7061-08ddeae7b252
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:45:00.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdwV8LihHnHJikV9OhDGCnVDyoAuU6DYQbcvE4uZYYoXUEtpgqgW3Lt4lnUhqCEq8jhsX8ZO7UOXpLU/8uSn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

Hi Tejun,

On Tue, Sep 02, 2025 at 01:39:34PM -1000, Tejun Heo wrote:
> SCX hooks into CPU cgroup controller operations and read-locks
> scx_cgroup_rwsem to exclude them while enabling and disable schedulers.
> While this works, it's unnecessarily complicated given that
> cgroup_[un]lock() are available and thus the cgroup operations can be locked
> out that way.
> 
> Drop scx_cgroup_rwsem locking from the tg on/offline and cgroup [can_]attach
> operations. Instead, grab cgroup_lock() from scx_cgroup_lock(). Drop
> scx_cgroup_finish_attach() which is no longer necessary. Drop the now
> unnecessary rcu locking and css ref bumping in scx_cgroup_init() and
> scx_cgroup_exit().
> 
> As scx_cgroup_set_weight/bandwidth() paths aren't protected by
> cgroup_lock(), rename scx_cgroup_rwsem to scx_cgroup_ops_rwsem and retain
> the locking there.
> 
> This is overall simpler and will also allow enable/disable paths to
> synchronize against cgroup changes independent of the CPU controller.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
...
>  
>  static void scx_cgroup_lock(void)
>  {
> -	percpu_down_write(&scx_cgroup_rwsem);
> +	percpu_down_write(&scx_cgroup_ops_rwsem);
> +	cgroup_lock();
>  }

Shouldn't we acquire cgroup_lock() before scx_cgroup_ops_rwsem to avoid
a potential AB-BA deadlock?

>  
>  static void scx_cgroup_unlock(void)
>  {
> -	percpu_up_write(&scx_cgroup_rwsem);
> +	cgroup_unlock();
> +	percpu_up_write(&scx_cgroup_ops_rwsem);
>  }

Thanks,
-Andrea
