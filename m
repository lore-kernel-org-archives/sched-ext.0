Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A73E9F7D
	for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044940; cv=fail; b=Fwjw49aPEtDLGczE27wOizb/U7Zw9wbMzB4jv5EOER8Vbo2tGrgMyHHVlGfrGY2kgn4TklGppD7YEUv91X/w85yawveuE+Uw0ZZZXwE/WXJnVsiP7qLRwl53fVjHVFpcc4fmrV7zXPCwcpzN7+vRjG8Ske1cBQBp51+PeEc3jow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044940; c=relaxed/simple;
	bh=JR+slOf4dUo2pn+46KisrLRKdLg+qbfEo8hp60LrCCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1TFCZ5QQvZojXPZqodMnv/V3efmsyxWODNUILZsJRjgl2FSDpCYpiu2CrEUoilzSveIU981oxXjYQO1xB9LsXkM4R5riLnVnPje9DYQOUPGjAUoJkFF/ee/kYvTNI57Wv4+BwTYjwg9q8NaWu1ZLx2WBvs8UL0pDEBYWZ74/hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZq/ttIX; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZq/ttIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edao55VBTjr0p1bzAWEnGE/kzSubw5CWtr460ZRfb/WeEEqsB/yRyYZUt7gW6rQPscp2Lw8Bq/6+n7zlAHMAbA6rZdVgtlIo8a+lqwU3v6I/g3XjY87/Y9b51Y55deH9U7j9yEU006RE3qIdbuq7Zt/P/txG0diX2tFXHzyjf1sc+iIF+hC+tRJfPH3hKdGLCjwJgCUkBxfsYdEKNoAHCyZMI8J/YXDAofGnV3SLTniJ1vBDjjO7+f0FkHA8JNMo6nCDk9gnb3vDELirDDvst/nVp2o7GJo7x1ci+qjVPswXo8JsjE6tDtyOJE5YTqzzXkDvQC2/aZZQ1veM3Bph7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdEYI6khyEmaOTRo/+sjTwfWhd6UDbYaEQJa5hjG6gk=;
 b=MXZKF8MskNKftzFc3sePDHdamToUj93SmhTAUZtQXUvNRLnHts0F0At1dZ+jWVIrCfzz7tP1VJYFiiPCqehFX1z1pPcrpjv2ckq6+xCVxsjibfU7XaZbwIuSYa/DsCUmVJmw9/vXM9ovbgX7hcsL/9EsEX3z7cOqQL2K9/hQK0IhiD5wF04KtuOQPlNw23EoFoSDpDyuPiN9P2l4YSUzxk5wMYvbz3Fb8eKp/mH068uHoa7fvMhjTwL6aUi3EQN1ueGOftfHSS/ncEW/5sYzTQlTRIyPqVZUxwoiMtnsyNbHgZj+MN2WTtL9HMVu4E105rvTVWjyFH916j2S5Xy9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdEYI6khyEmaOTRo/+sjTwfWhd6UDbYaEQJa5hjG6gk=;
 b=lZq/ttIXp1OwHrCqBZuRwE7/woXcrS348chMp4Quiup3mNsJSDB99yimyujLtAEtqc0X1zOaSp/sq9mYjDJJaeC0fApm+eJJsTGiYkKDZmfO4RPNwg4Kh+N4vqTxuiHWk2Bks3gTUmal5dBPftHN0PUutXaekNS2w6b9R/3qi8dQjtUyU3H+tp9CDRx3F7KTlNQn7ftanGMLcQGQRGsF4RIJ74kVBXZaY9LAPlM5iWTzE81YvJOPIzEf6SWKuOvHKAxnc/pt06u3fse23wuAL7R0n89W1Rl8Gj6cimuJ5AkfM1eiJAc4DHB661jnPGXUEynKnhdV44IIJ4G1ah3c3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 18:42:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:42:09 +0000
Date: Wed, 25 Feb 2026 19:41:59 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Prevent null deref in scx_dsq_move()
Message-ID: <aZ9Cd1uNC5M88jdP@gpd4>
References: <20260225181624.427916-1-yphbchou0911@gmail.com>
 <aZ89Tyy-oQ7skH7z@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ89Tyy-oQ7skH7z@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5e27a3-a205-47cf-4c52-08de749d94b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	B+q/olxxUZ/cQzaLEtCEp6NAqZnAubjcuH+vSHeWRMIFzlzsL4e+AeZG43ffb+1Onb2ijDq2njKkIb15nMNSGHlcO5UI6CXP1lXWW9c3cRK+CRkgn0kRLmWP/biMVi5hGtcG1g/iTaEo66Hk3UPv6aqNYo0WCMKRyautuXUy3ebmgjlKlHwl7XuCwy79+RPl3E6kMfhfsiYtkvhnXHp1DcDXqAepL3ZWPadi/e+LrY/IAhA1Ja5C0P4EqelHh8G5T8ApJa/IigKGlu6wLe8/as8y22nUHGeTQS7dHirhJjpY2+ZSFdK2EbxYr583nwvbX+pSlCr1SfhWfhsVPVvL70msFUWuIRPLjYqRs7gN5PAoZnTMYdaglkgJoCGxBvssxzoJ59cgGIkPAkSMQUKZW2n/kTaaXEg7QZR0a+RzypOWAlV0vJAa9MULBIBjv9ZE74xw1sFx5tXjfk2MdHpc7Tb79q3xuogp7RBsfnoGNwWt+okV1vh5KaKiFqXjSMg7SAmi92dLRH7391coM2bz1DJ2JEx305GNhGqHoySKVYxz2+p1woVAIuIect5zH3CgnBkQLSIhkG2Hi28Rqe9imFIXKtYizhm3+SSwuTcXkbKevsOJ4Bago0/wnYVwk6MpgyU4h80bP++YXgQw7yrJPGmckJ5AYQjYwhICKSD22MVlEKOV8EKw/NsVICvzGlv67a00tKYDobwbNHceX5fXUcf0wzWTuLLODwsX1rGp7CA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3QwJxA0vsgg19dF+I2gg3Krr4ay9O9riI1eMp+/bUT+5UwlJZtZBb7q5yvw?=
 =?us-ascii?Q?bFR0ytfKqnB9nP3HE0XWKWBS8hsNMlZ7pw7VklsPtIfQ5AWKlDX0rpP1G/+L?=
 =?us-ascii?Q?R6PAPkdxC510GNLaXxYpVhOPt93oh1qk1JwoYU1QDr+zKv392yZOduZk1pb5?=
 =?us-ascii?Q?t6TWi5qycK5jQ/Ns1YbSsi2zNK8OzZ47+qRx8DmJFwk9Z77F27woucAYdt0e?=
 =?us-ascii?Q?fv8MKNu006Brzb52pka1oQV+Z9c9kFbIp/7ULUYbAhRDkRaMpscC+RQQB0jX?=
 =?us-ascii?Q?2cMZr7FmiiN+sXg4f3uvMHPq1hJGD3xO8ne9gGMznnM0NTdnfLL8KqWw8KCI?=
 =?us-ascii?Q?YfO7E8iVM6L37FjJEfD++LHQs6cqbVufVibXX6wy/iHORXbgkrxlS142vPwu?=
 =?us-ascii?Q?lXy/UFLrLveMc7HGQgPDcUwl25UUmXtpukXw7DoN3sm8vMRiBk6nNwnJwrM6?=
 =?us-ascii?Q?Rx+yhtP5RPrfXDOw6Guv7DpLBEpeDQIcDe5WqTKpPKpzJhWXfuB+O5Wln0SJ?=
 =?us-ascii?Q?JSXx22zR6vRsqGeeGonvtEolhaUEjj+cDYZsAfXxSfLSDzo03i395OQpgh8C?=
 =?us-ascii?Q?QbhemgF3jJyGPa8SIyuJ4p26DjY9emBZXL7XBE4XjwttlVwYX/G7ZiAEd0gL?=
 =?us-ascii?Q?72BkMiz7mmtva6AQ7wnjgTO7TC5IelilTMR5ut3HOI43a9rFmxsfgQvo8aVZ?=
 =?us-ascii?Q?AKFfaa5GzXBNtUgGnHuKfSJj5BcPR7isxglX1IioarrGtdbZ75iHbdxtueQI?=
 =?us-ascii?Q?dlFIPaV7ZhHLHT3fwGYYci4lNap7T6oYYiV1hI74sEIH5VWuNDuijANjxkL1?=
 =?us-ascii?Q?7JE2wGZcACdNyjNiFSPV7SC4sTwF3mNa35JYIcw3fer+cp2OMA7yvs1s3Q66?=
 =?us-ascii?Q?D1gxUWDUwugTm2Z3IpnBqLvfnK60bFTMaRpIbaw0kPJgzJu8Vl9n6XUmr+X9?=
 =?us-ascii?Q?lIvXh2SXTOnSExLLUvppDHdfXDkvO0p5NmqyWrz6YOJV8tUrFunz9azD421E?=
 =?us-ascii?Q?giVjxis4MAr4LjnQDoKUqbQ2HR1qiW7QwAt/zymIJLJLRTHcIo1Z2DjOoi8X?=
 =?us-ascii?Q?TPWhlZQUaRef/8MeZuJe2O3xXs2o1CUJ1N8oltYYZHRQeVIgbHUsI6OX1qov?=
 =?us-ascii?Q?CKiHQ44hyMa1i4lc1IIgS0F/XfeUCJIsmGiDCq3KbIVK91Y8tgUzFMXt2dxp?=
 =?us-ascii?Q?0tPlGZgaA6eFz0JvdCiXpLHdiTLGoZEqnsOSzTPT38nU5dDtN54eJZ5eIg9J?=
 =?us-ascii?Q?+/iA54WoCwqJy/K4+WjU3skGxsq3XsMvKY5vZL8Jlq5kA1V8NkWon2eYMXN8?=
 =?us-ascii?Q?cA0pplbdB/ZgRodpbr0/nMzJOxsH96betjSeIb8jPSbdllUleERy4ymm9h+2?=
 =?us-ascii?Q?4P5ShoeIz48o1K4l4/mhBOpKzEdPjDpdptyIbZ70ZsQpTKStVAEGhUUwqFdH?=
 =?us-ascii?Q?BN62jR9Rak4smmkAjOu5jDCa+MdSf+ZGiIUKQhsZfeP85WpTTR01OMMQGCHc?=
 =?us-ascii?Q?zCsHZxQk3E+JNmld8hSbHt2QzxicHItFGwnKvIK4INKO3WJ2Z1lmzPBLHcvC?=
 =?us-ascii?Q?TJnAxgkhkKVp4QzjNDmDWNJjT/AH/9tmNehgXmNDEbdeAlmyQ8xsutELigEk?=
 =?us-ascii?Q?c6xjML2lgZKbK7N7IEXmYrw2GwJjV/ImGDsVFV5O02G90rCjYR0+tRAPOgoi?=
 =?us-ascii?Q?/oWST1C/9+SBaTsJqJgh3cQcPW7SCo47eylFQVmvr/lLMW3+0SSbqx2D7EI1?=
 =?us-ascii?Q?UwJ0enwTbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e27a3-a205-47cf-4c52-08de749d94b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:42:09.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4U4CQuEqwVptemA6GqCY6pgEv6xfJh/GAT3IOrb75phtjlkIc0/qRFVi3fD8PMRZJ3FxJ4nKyKXEkq7ioz5JFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

On Wed, Feb 25, 2026 at 08:19:59AM -1000, Tejun Heo wrote:
> On Thu, Feb 26, 2026 at 02:16:24AM +0800, Cheng-Yang Chou wrote:
> > Add a null check for the `sch` pointer at the start of scx_dsq_move().
> > This prevents a panic if the function is called when the sched_ext
> > scheduler is not active.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > ---
> >  kernel/sched/ext.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 9280381f8923..79d8184e4e11 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5990,6 +5990,9 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
> >  	bool in_balance;
> >  	unsigned long flags;
> >  
> > +	if (unlikely(!sch))
> > +		return false;
> 
> But sch is from src_dsq->sched. Can you describe a scenario where that could
> be NULL or do you have repro?

Yeah, scx_dsq_move can only be invoked from scx_bpf_dsq_move() or
scx_bpf_dsq_move_vtime(), which in turn may only be called from a BPF
scheduler callback.

If the scheduler is inactive, this condition should theoretically never
occur. Even during teardown, all tasks are migrated and no CPU can still be
executing a BPF callback by the time scx_root is set back to NULL. So, I
don't see how sch can be NULL at this point, unless we have a reproducer...

Thanks,
-Andrea
