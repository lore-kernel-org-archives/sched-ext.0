Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD55314A62
	for <sched-ext@lists.linux.dev>; Thu, 18 Sep 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211236; cv=fail; b=DhyWjuaD5JCHwUSvlT7IgTZBcQ9XLTzBVhGAr6HHHR09fXccRhxp3HT+zS3TEf5h/v6luDKWlxdpswpuwh9F1QGhaWFnq9qWCk4GWs45l3bcQ9392bPRiqE2z6AFdALAnlSNZAyXuGFoDwAFeW5ZW/KqkXj/t3PCpgNZFiBzL6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211236; c=relaxed/simple;
	bh=5ctZlgsZWOH2zA3S7kMmARbqRtwJsTx37mU6YB/D7FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qPhqH5jt2Cc5xbp5frJMA1Xrln13X2WyMpInwAmbdbDJzr3xM9obg25CN1Uou0fv+P37VAhc83u236sig2152AAT0B0u9Y14Gc/huMrf+n6dLEBl4uXie4rQLILyHZGopw/PF+uVqyFE+pkYRZs5JGJ4XpiTG+vF76LlgJNGUoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTtEGqBf; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTtEGqBf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMv341n0OEImB9IFa08Q46VHn/EyiAONPXYMmesFlxrsF/pLZnXq6kzS+l2acof5OF69nL2u7rf7cUyaCvodkHn477fzkyW/GyrHDqE0ZdTHpWWZQnHOs8vAveDqSBZCqBNSQv41UfqKWaO3LUd17Il2fy4/LAdRlZe+no1bx7NhR66QAFGNDJ6UJac1BsS3AXar6jErzP+ML5fAcs9XRqJESJ1+yJpYUEwQBobA+RZafRa6asdwSeJXn1keHqaNVB3lPIUewu17b0AVSLQz9JMRR4j5WAKnUfuw21lwfE77cK/FTBA06il/Q5GbV81X13PXmmTaEUV8VD0ghFcYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lQNpk1ktfiVPNEfU/NoR7XdyNtdUju20CzDGrKriXc=;
 b=Jr+L9CafNZCc9M0MrfodEzDpWOhTdrOU9az8q7jQYbnFgTk+VP48u0RILe8u5RseiDYcwf/u0oORuPVGBHXSZJGF/qDM6aRmBLQS57A4JBdu6c8KjX6kjU4pNATHJvuCjj/8wPH3eQv8OP0It1tphr7tY3KQpRq82dQKkMz7hrBBjHrXnciCjBAVWRa482Sp+WSXv/cPtFIYaBoVrSqUEf4qbK1AuhttmWuJ87ctRM+v/1IwclMiwq5YEhY+8cfniqd5XHG2gX9IT8zdJd+3v2fCCakKRXS/2usxrx0GmSuiz2xROuwHkAfXwTP2te/2gEdLeaD0oc4f9sS8kUvMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lQNpk1ktfiVPNEfU/NoR7XdyNtdUju20CzDGrKriXc=;
 b=RTtEGqBfY1GBfI/GnoaSJ5It6c/nXhHfjRWRaP/4dRckJzPPuA5JECHRY/F/b6bLRJizbbAHpLOKhxlnNpLpvPjyISFQs1SSayPIeFIYRuC9M7zV7G3oCB4YrtnXkKuqzIwKfrtcW3dj8DsdVWKZYvgf0aS3KwA/QIUa4vBd4DpkDJpG/XHOm00tTzirI6aT+72G5/CtN0fG1D6CJcL/LH875UlXuuHHjvxpS3ibCZ/HrxvAGNf1OcOLOQ9UtC+NJHOKvtloqHcWaiCot2AO+qMp4ZgnMruKJVrzCm0u+DL3F2RD17q6Z6+7WjUUVTnLs9R/bfhay0V0oUgPo8tXRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:00:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:00:31 +0000
Date: Thu, 18 Sep 2025 18:00:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Add migration-disabled
 counter to error state dump
Message-ID: <aMwsj3SOkCdMNk3F@gpd4>
References: <20250918092928.402242-1-arighi@nvidia.com>
 <aMwqAP76eVSIIIDn@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwqAP76eVSIIIDn@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: d0762bd0-20af-4b80-0a08-08ddf6cc7e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhpLGDsLVYEsLpKE7Vm2d8050PSx6m1U1CQzPHKkt9/k7XaNZCw2Tg0tnTcz?=
 =?us-ascii?Q?uc8taUTtrKkeXqKITLQiRfdVIv7P1aDe8MoENqSA7i0e3EOnSZEDa/+UddyQ?=
 =?us-ascii?Q?yzEVRjhhXvXyettPzkpg6aaS3JVL2QrnJeSYAB7OQZxiHceYYRQS1SqbHM3j?=
 =?us-ascii?Q?2aIc2wQ2tEThHmMYc0zN8ZW9lnw7kz2gky/IalQHowkiD7FLgVhlYeSJaWNh?=
 =?us-ascii?Q?RbgaRPDpOLoTmV6Kbp979ttCvhXFY5Y8hfxBHLWY4GGDstQOlAItd5yVWrfd?=
 =?us-ascii?Q?ofj5gMCSoBzkU+ryerwgjt86limuu2XpbZLph28HAdr8ANY0iCF+NHbEgjP/?=
 =?us-ascii?Q?8Ix1IhMLlxClTnuRho4Lwi+WN/wIjsw+EkJTG+aD3Rf3S1WBIlk/2zrNVHXv?=
 =?us-ascii?Q?EOM6pP50IxJQYiPDrogyxivuCnDsjVyPKsZOae6w2EjtQVPNxr3uakenuCX7?=
 =?us-ascii?Q?ibkXtfMxB6cbpZJqM/V7wwU6hDwmOsLu4eN1UD+aLQWIAdgk5ETtmfcnnI2p?=
 =?us-ascii?Q?1lncP7Lxh+B1/fd61gDjuLyS0uUFyPKIuffiEiuIhalti70txvNYnAb52S9n?=
 =?us-ascii?Q?JmCfAJv6RVqTX5c8qUPAADXP92l+/Ih3WcUOIgxhn2zkMHK+1zcrbIcri1wU?=
 =?us-ascii?Q?Ti/4AvJkJYOwRa+KqiNEg3i+dWDQhUqTnrBl7TZD9TUwDha0IiCh1WdaFZPP?=
 =?us-ascii?Q?HqjWzdNwIS8Y5f6FSNhffUxOT8Z9cQ3rR+NXMSM/hwMTsCH0wCOyUyHFlaE4?=
 =?us-ascii?Q?adyxc5t2iZiSgUUakYn5aXsimJl4JPWsUhuUbThlHGXoi+hz2XqpaR1/uyca?=
 =?us-ascii?Q?Cejgq8SbY1dVRW8Iyj2R15j7IfrvRuk2lO94px8Ni/3/+ahazaXW1hGHBUKi?=
 =?us-ascii?Q?xokCbDs6oG+D6YB3MqSqZ0yie7QqyFJuT7kXN7628oklqGgyHEPgYiikeXzq?=
 =?us-ascii?Q?kuq20vTwk0nibZyqT0v3eKl1sIgvSOvGiyzhOHgZh2oSNK3gOM5oGkSV0KGJ?=
 =?us-ascii?Q?Skb6aU/3fDbbZdYoHlZBFw8vb+MghGrSz09nz7+hCth/ZKV97g+JBdkElctg?=
 =?us-ascii?Q?36X32sV6r2hkeTm47hKxw0V42w2OqCha+dcfa1jJaj5yb7tfD9BTOWYn3Cp/?=
 =?us-ascii?Q?CvPJ4lQkPlSealXiDWIjpO1/Ey78jI7o3fatE3EfXyuqfNJ/Qc0oqbj3alfx?=
 =?us-ascii?Q?80Xrr11roqJtL2oEX4eJbg+DZe2O1qcoO6inPp0/hq0IMv/FvLNXD/1AYUnM?=
 =?us-ascii?Q?NH+RzWUyYlJwDaSClv89ghG6Eu0Ttgcu0NCAfxACo2ofcCGDJMkoWB8mPFDJ?=
 =?us-ascii?Q?zGRDWcorRHKcbl56LUR5oKtX1SmEdRCVehv61fdYKzTe4IJZ4Txb3n586Ky1?=
 =?us-ascii?Q?TkgHVeG123pkbY3QxJOWNYB0x68zdqhzdi25mvQagl7mVVkKHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V++jdhnGGE7BV2L2U/1KYXafohwsP3OYBTv/JaOiFxgsexbukn+ozpymbYze?=
 =?us-ascii?Q?XvvDmwuAEO3TwklVhVVV1MoyA5z0gVrY4xtm08ayIibUxZUWrcPmHdLfOIEl?=
 =?us-ascii?Q?FLlObOZwtMnbjt8m1TsfDdjBGFXMGZkJU9WwGntn7V0ThHL1oK2/bc/6aWUB?=
 =?us-ascii?Q?+UWdiMhi1s7it7lY+hNRu9wTTGD02HQIpE+FkGDXB0VXazXbEJtNTDQosqfv?=
 =?us-ascii?Q?m8/fGXrcyolzD1Yu1BxSjLQimSfen7f8RjNA5ObXRCo3CNfd3Jqhrg6/ka6p?=
 =?us-ascii?Q?3MFjYaxyrCALdnhIHoPhQCAlO96vF1JDb31tXj4PqStfdOfviThA6KWnd4u+?=
 =?us-ascii?Q?S0wiETYPkQPXWGFNWycKus/REraFT5/OpOW9aj8jCnE9XyqsLQDrLOOoMEfq?=
 =?us-ascii?Q?Aic55yVZTORJWJiN3lk3Jtem5nfYENuY713PlbI13zjUW+Z80BQ8K601sFxi?=
 =?us-ascii?Q?41jhD3T5qqDaT+MJnUfniBAi+/W9pqGmZJuKVfUDw7QKRlq4sMYKxtt7mHiY?=
 =?us-ascii?Q?GwoDKMAr2v9wrtCg+zFTYG5h4OdFdnVeWTYCvP+nuFeTs5hJ1nuJZ2o4Lcji?=
 =?us-ascii?Q?YTGE0eXEi7uejV0N1FOZ3mnneBRkTm0hC0bP2HGIxK/RqBTsr2NfydcQmKLI?=
 =?us-ascii?Q?LaVUzPp3UDyEqrfxcR2EU+BNe9ecCHbDKsuxPilzE4O95xPun3Gq2jCeR+Uq?=
 =?us-ascii?Q?w0zs1xirl4pm1iKpxoVg+OI5vizSjPCSUv+ltS983h0bEEBSw2h+p//GkCbK?=
 =?us-ascii?Q?1y35rF38tu6H8MQQVfGQAH35ngRFkY7jt8xeON3gP5XmJ8jFNuKeExj1bCID?=
 =?us-ascii?Q?rwG6Hpffb9fxNxCiWLA+BdXLoofrTU+E2r1R08aH6I/qbkVkU7wY31fotLpz?=
 =?us-ascii?Q?pFasPVfTCXOf9K6m2OjpVIuc90hirS3Y7V9K7O3Xgp7+1UOUPVmJfdEBBJG8?=
 =?us-ascii?Q?+OTT55NJhHnSHwrNmHPpQVjuon1L602zxaqFNj5EkQ2sNTwRVtwveVxFYG43?=
 =?us-ascii?Q?40ehRL1PrExKFDKl6gfO9UpqPcdhUhq/vsH98veakiTj9yUb/kpzAu1qFgVH?=
 =?us-ascii?Q?kWA4oabB+/rZulXuSxfb4sqeMrlpLztP4wuEJKCGb7scT4U2CA636X/nqCFP?=
 =?us-ascii?Q?gB7Lc67crL1hLlLO8EVntxHQjkUw0kpHj3c0f38o6M57QnHO24G1sQze9G5S?=
 =?us-ascii?Q?JLApybJtU3L+EIM+drA2NRGD5eTv2XiLDq0CcovMtsz1bORIwMbmORuW+h6A?=
 =?us-ascii?Q?NQsW6Dz8Ol/TLTua9gQ7DzX3dmoP/PanSyTd7Ddj7nZr3eLkA+axKW4DD6Sy?=
 =?us-ascii?Q?nfk1/I2lgk9yBkXxRsXl8my2rNkdJM+VSclgvbgzxbaQ3JKSsd0OyO0UGGSY?=
 =?us-ascii?Q?nedFhgqAfekT9B3l8g7sDeoEReWc3xkhW4MXju3SYDkWgLuGMwD9PPCuCLtb?=
 =?us-ascii?Q?rWUVlvsBSS+eBZeomDT5ZE2BvKKv897wvHrUav650vomhB1T0M484CD/8t+8?=
 =?us-ascii?Q?gdJnWQxzP++wRn+08pQ5NEVFN32eU+a2NMgjTb1qgRWuerEPQ9XKkqQU/zgM?=
 =?us-ascii?Q?F93kuws6qCe8hUlCGL80K3uGLWpq09DUN9WSJFee?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0762bd0-20af-4b80-0a08-08ddf6cc7e6a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:00:31.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31wZC50otA3iNCjnlPskd2v0yGNjIxQF4zCFt/6+XIT43n4HJgnAOqMAd1DhyPVkj4XvWPIzrHBhT2zhPH1FJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

On Thu, Sep 18, 2025 at 05:49:20AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 18, 2025 at 11:29:28AM +0200, Andrea Righi wrote:
> > Include the task's migration-disabled counter when dumping task state
> > during an error exit.
> > 
> > This can help diagnose cases where tasks can get stuck, because they're
> > unable to migrate elsewhere.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 477eccf023388..e03bb51364661 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -4167,7 +4167,8 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
> >  		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
> >  	dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
> >  		  p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
> > -	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
> > +	dump_line(s, "      cpus=%*pb migration_disabled=%u", cpumask_pr_args(p->cpus_ptr),
> 
> Can you abbreviate this a bit? We have limited dump buffer size and real
> estate. Wouldn't e.g. no_mig= achieve the same with a lot less space?

Oh yes, good point. I think no_mig= is clear enough, or even nomig=. And if
it isn't clear, people can always check the code to see what it refers to.

Will send a v2 with this change.

Thanks,
-Andrea
