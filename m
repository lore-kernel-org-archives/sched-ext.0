Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC183330305
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000238; cv=fail; b=pMKg0CooQKwiMrXhRB/wwjbos/6XOdtepPnFQZNZizNVUEgJ41VmvMnN+HHEm2tY+XfsffatOB10e/nZntqgQW4KBtTfdoY/cyu56pu6oT4Ou/pKMDRf+5awdy5zckDh910S1oABlTKjqmRfSqTmwxnG+kG5Tp/KJSEtkQWdz+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000238; c=relaxed/simple;
	bh=oBfMVNqcN28hLjgfiHwUb1c8nZxJ1Hgy/l0GPbB2vjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBjKXC0iiIw9Nf/JzZT//54B1gS5nW0ZG5ZluHl605QsbdgjwvElPs4uKFbCwe/UA5Rjbw5kLdi2VQ4SwNXYaOoh7UHo3PqcUpbt0xwiuoiy5YS3b8903eU7MefbpoTetu6eZDdLTqfdy6CPhZTSr3ct6jVz1Tg0nTz1b/3XtG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiyZkman; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiyZkman"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyaGfdYrEenV84uah35Al5IJO3nKKDYJdYFEugBeahNjJK+s38m4fCKHg7z01XhHGSJD66Vdd/PnLcCOnN+icDTuJZvbalzNUdxLeO2KWaskYG6aRaxgSb6ZZ37JvdPWW6/9w2oVqm4yZDKn23o/9TyUPOrkyflBfR4Mg+xub/g5YjtPEbQbNUxf4J2sChIU59w7E7JdHtiUiAnvC5TnLNNcgQJTdqlg2z/WqrOZSe6C0e3bzg0NZOuwS25v+RyQyBdEtAMbLamaZ3vQ7s/BwZdPeB97/95Z+nK44J9VvX4Hp9IUCPwN/Ypn/y1X8UnbklpcpimOZQF4rftGN3OSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3leeGmdYHUNRhzG2lcIzw+5ajDYWVVdz1+BkRmSYH+I=;
 b=ys682NOWD8pSYsAAqSTB79cJoAEmZ1fkflPx/3T/iWe4sK/JCCtcO6DLuPtZh6/4Cjal2mpzCQBlMUh/smEZQmZmKvx/x20rTVOJFk5XRKa6leY9pSDAiC2hP2/yW5A7ll+Kg/1sIucdMyFzubJJudMIuyhJ3CRFfvhIO6kYCSIzPouUE7gqoxMwzOYmJRH5XN2hGN2rz52i9huqY3KoZHIl2Ml9BunqUQx0zzKfdQ6z5+YwnXE5BOng4/fcZbbKHznDMU21lxtAfK1GUW4DKu7Zt8pJ0Kood3Z/CErWmLbMc9IEOOwHIBVEMMso/spRWfrImHJQIsR58ITaixMtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3leeGmdYHUNRhzG2lcIzw+5ajDYWVVdz1+BkRmSYH+I=;
 b=TiyZkmann4V5XKHUJDPvmtRT4iqxOZtnw+5V6efYz8W19HL55ebjsYAr1UpgIIpmFQ2Dsvf4LlUvwzQ8pO2SqSjNcIi6h3WhkvIcXKUiK2A9ZneIt5wFthj69sU4pzK5pZpaLfNFsVDUBBtZD7+E8cPtbZYErYcsltJofN9rRjFk9YvVAYo5cAMlY1sRqvr5a8R29Lct8Qex9arcwndjJYR/2g4juT8RfJsuF49M/lBBWtSxIu0Pe4Qgo7on3W/zsE4RCr0zHxxePL+9TxYuk+EDLJIgA8u/GhrsLaVdB1bLjjHeuLABKMvLGTih698my7UCJ/DDa/SCOrSmB/kIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 12:57:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:57:12 +0000
Date: Wed, 21 Jan 2026 13:57:09 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aXDNJb-njXC1TzfG@gpd4>
References: <20260121123118.964704-1-arighi@nvidia.com>
 <20260121123118.964704-2-arighi@nvidia.com>
 <9e5d53ad-c347-4f24-ad6b-9abc1088e35d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5d53ad-c347-4f24-ad6b-9abc1088e35d@arm.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 7461f379-558b-4c3f-cf45-08de58ec97f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ue3FuPQo3Wjd22lZCpXlH2oziyXmCwZ9aS+PVY5QNTyBjCOQDfXNXmRj61+L?=
 =?us-ascii?Q?RH62SX7yRfw6+Avy4BRsQ7Zm9YZZFiPk8U4GJ6eKwnmaV7PTgFihbHz4wJ3k?=
 =?us-ascii?Q?/t9B7OYqjyLqI8IYoPBVabKFiLAhSsooswrG4DYpd6G948M0mv0HKqIQPTGa?=
 =?us-ascii?Q?Kdaol347x38dbIv0zCzgAO7wcHDe7X2RWgLPaezoRqH4Nl6RAeooLlswxdyN?=
 =?us-ascii?Q?Wja/AzW3OiNgH2J9IzoYL2IBjIapQvBUFd/2FvbrMJSnwnNDK1/t9EgmPhoc?=
 =?us-ascii?Q?XuyNLX9fMs98YqqW/ABrl3H/eYUnhGh5/y4/rK5SOGD//sVeK+OnlZetuJYs?=
 =?us-ascii?Q?T13G6bA4doYwzmlz0dDroevyBGFw+a/DT+BDGTYKjq4pjxJoatu1btqpyMyS?=
 =?us-ascii?Q?DzKYLQb/Y99VSxVRHoT/XHXj/MKPmKrq33Bl70LtFlzjG0g6dFObGdKcLrCd?=
 =?us-ascii?Q?57gxxSapb/zK4LSEMALr3QdbHDoPIAPzUxwwUL+b3gl+2e0MrOlyZkxDyiKt?=
 =?us-ascii?Q?r4qArBopMewYVUciUodYm4Rj1p/ZNSVnX4Mi47TR7WKb0k70zjfuhPg93VQo?=
 =?us-ascii?Q?ytaGsQdUhc0pN/1gmZPgXl5TIhzpXGPsl2JpRuRhuVgFrN/olv1XQs0g+995?=
 =?us-ascii?Q?H/BVhUo//iQeuXT84dgeVUbWhEOH8CjDDRWpnTsZLDuwWgKF6w+pjupdzKMz?=
 =?us-ascii?Q?GKhfN4lSogsqVCqiRSfxVQyP5uoDQspqhm7Y4jfpBJlUr3jfOPmmcsUrLIad?=
 =?us-ascii?Q?R2cdwKtIdUbM69m2JTTTEbo2TvqXorhrR6ahLXrnd9VpVzG35CJUSzAvNOnG?=
 =?us-ascii?Q?kZytu2SJiwCAox6t5es+ccNrRU9R9TwUdLGkSxHJw9Q/9ahX9XJBpYOy3qHJ?=
 =?us-ascii?Q?4p1RXcTHg3NxXJD50cMUsg50OC6OKBXQf5zDx6a6yitXv2RTXv1x+FRzcOrb?=
 =?us-ascii?Q?7hruTMdUUIOmlHnS8ib6Ws7PtcR7BkhLD148VlfIk+Sco/a9xiWDdxpHWnyb?=
 =?us-ascii?Q?zhvb5ouCa8myk/fFGTr2jn2g0T/4YfOqucFuSltlv5OviMzqo53R0Uz6U2nj?=
 =?us-ascii?Q?MwdS77V/7eW8NNdLnOEbvUqVcMWsAoiapE/vB0NFq27bPJaDnZ5p0N5L20tB?=
 =?us-ascii?Q?SxoSPC3Q+zf9wzXre7/nmpiTrMBvDXSqlpAL6kyivCMRJt7YupPa4FOc3Y5A?=
 =?us-ascii?Q?1mYsxCAA+OiYrJ1MKNSf/a2SFtBdp2Lcbgf0dKexmd3D32JxD25/ng07A9Qq?=
 =?us-ascii?Q?7o1Tjsei1QM+OeTFIHFwHj+g0Q9IYR0shpTU9qcuOUVX27Na5OPFGANbM0XW?=
 =?us-ascii?Q?eCVRV76NFwufjspbOtWV16qL/y1eNHCs/GYy2a6aQTpG+VcR0yZebxLsu3TK?=
 =?us-ascii?Q?3/GtoKmGfBsO2yPNJV/MVFeiUTyrRbOI7NXnWyHTFvOXdawT+Qo2BuS2n+X8?=
 =?us-ascii?Q?NKKGT0/glrv8bc8KmvdoJ+n3hhLjCB5HXH/df8sJGYbhtzcUvpDHYxxoOgYO?=
 =?us-ascii?Q?JRGFqVg08vsjgwUOxil4E6SBaRnQ4sC9aZUAVhtrQFG2xHzGBkwf+TaokDjn?=
 =?us-ascii?Q?5g4mz15fZwIb7ln63B0Uyi7e/FiWOvuNDAc4wWAK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0Kvx2P/33Yji4eIlPbKkp0L4VmXphRI/4LZDT7r0RxNXFxUHE/uuKkk4reJ?=
 =?us-ascii?Q?xK2lM45B4z+mgColKlhLGkz/oFh3J18JfvbwRz1lnyCh2RwDwfzbW8Sna4BF?=
 =?us-ascii?Q?6jaWa6VgGDIgZ1h/BK2SCrw6D06ge6Psj2WgQM0PRVWG0+DLhgHp3VTuTEEu?=
 =?us-ascii?Q?qe9CjX2f+8lJijIQnJoL2B5ElcWUtiLjgM8eekQKNpX7dxnlqczC0FfZEA4t?=
 =?us-ascii?Q?eFzftELs10Gzj9iamasoISxD6p0fEQ7dH5MtZoyp14dCvF7IGOL4UJalOXc1?=
 =?us-ascii?Q?seeak9lWwa3mle/45VvKBgOhKWjyXu09dZNDTtuDZ5XzgkqzvR7qXJmSjm0z?=
 =?us-ascii?Q?XNtJvFx1tuj0SvaTHJUzuDXR0pdIw7nIY+M0d/dWkxgblEd6a9YQPvO9HzkJ?=
 =?us-ascii?Q?4iDW1ajRHjwY+FknnNFDsMqFA3kvjiE0meKPvDdtpluXAKXoT6twNeogAjkq?=
 =?us-ascii?Q?BMG2r+ysQrczZJPLKiCJP5Ju1f0Xzk+TiWxWU/6VMrFzEG2zqpQvYcv87tOW?=
 =?us-ascii?Q?MvxuhcVuRri3onQWK7XAj2kbYGzHNXuN8mTsFs+UyW7mJvqeMHzIX3G3o6Kz?=
 =?us-ascii?Q?1XinI1F8XyD42oBA7cjmAFPJVWVPnbbVRhBKe+3uroasn4bujo3T6gwGmxzG?=
 =?us-ascii?Q?rIRqkXlc3BVdMJpell0/HysqY69MuzNkuafS6qZ6K30KjVyByrdRAC39rzAz?=
 =?us-ascii?Q?nmqfp5Wl9V4Rmh4xZpnoQePsbVKKMZ/oRzVjbvDiAbj86hLWnKmqGWPBRZJb?=
 =?us-ascii?Q?WsZosC6L31BYaNArJ2RaFDlZZSCGH5ZdH1g4zXnH4F6M440AQeUUe6uV9+7R?=
 =?us-ascii?Q?JLfb+fRPRznPeb31pGyIsRF8iZyif1XssN+gjzktCis9FpddXUhUPM2PLrkm?=
 =?us-ascii?Q?xAsUAC/o2L3o2PIacT01RkG27QgfKu/puvG8Sw1RrikVHX7UZ6h2od49k1Cr?=
 =?us-ascii?Q?mGC2zpfCyFmHADCGANPmtD/HVwSeAf43jNWN+4AhJPqrbWYpVVSEsBaktVlF?=
 =?us-ascii?Q?BwbxfJaRRAVOTF5YtjuQq5UqeBn1lutnBiJOk8EOguAoGt+Lhb1Jsx9Sdri5?=
 =?us-ascii?Q?pR48briVaBvFBm5kB0q8CXfPIRS6tUP1Xzak/BvadDed2BVTLeoQ0Jgdd5PW?=
 =?us-ascii?Q?Yl1lc8K6XNEGAlAIM7odZnzVeH/UFZoQjmDmKf1I7/C6yaPVGHyQVoWq2V2X?=
 =?us-ascii?Q?N62aVF9ynehH133kt7QS50zyVtnhgW5xRpLCTHinwvqfjcJzBm2JTPWBvXn9?=
 =?us-ascii?Q?73pCO2M6ZDQo5V3mfICGfUVuzulOfqxUJyPLm+Ggik4CK1SjomSZm7cWIie/?=
 =?us-ascii?Q?QPgDzcvjJD4JYRydp9gl1zq13AK8kbxtKP69tds6be4T9c7HNtBACcpfSM5w?=
 =?us-ascii?Q?wuF7s/z/WGuSpbQ+z/BCrUTVldL05UoUBy+3n1IRy6aizDapvjIcoY5POVyd?=
 =?us-ascii?Q?ZMlbNM+/HtAU6wRaZoy5IXaY5QReAXSCMe5kOyOOCcD5HDPyPyzcS0IernrC?=
 =?us-ascii?Q?uHHyT6qcbtYJ/7O/JAA9rSMplX+NccHZec2sjMp+bzoyE0D6qIDASNklW/sY?=
 =?us-ascii?Q?++Nbj7KKS+99pQZVTR62qZO8BoVfzP8vFYkU+iSomTwNRcf1Pdez4AIHqveG?=
 =?us-ascii?Q?1yUegnlW8fKnYOnyJ+hR0rUqoiw54JavSXz6iTnZQpGxIPwhWbidHFit+4Zc?=
 =?us-ascii?Q?/hSGpP755MYVjuNOZ63sJEBwgw1RNCAxVB43nnJaHiFdrFkJAzqm//mXZAN8?=
 =?us-ascii?Q?eSMJa0NCfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7461f379-558b-4c3f-cf45-08de58ec97f6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:57:11.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz9r6vshTpJawbwEgHni2QQxNBUr5Qj3LNo1bWIiz+1ekGE4KWHtWoo610gKbUv33Ze/S7Dtpjd/uWXwq1Bx6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

On Wed, Jan 21, 2026 at 12:54:42PM +0000, Christian Loehle wrote:
...
> > This allows BPF schedulers to:
> > - reliably track task ownership and lifecycle,
> > - maintain accurate accounting of enqueue/dequeue pairs,
> > - update internal state when tasks change properties.
> > [snip]
> 
> Cool, so with this patch I should be able to fix my scx_storm BPF
> scheduler doing local inserts, as long as I track all the task's status
> that are not in a DSQ?
> https://github.com/cloehle/scx/commit/25ea91d8f7fea1f31cf426561b432180fb9cf76a
> mentioned in
> https://github.com/sched-ext/scx/issues/2825

In theory, yes...

> 
> Let me give that a go and report back!

Let me know how it goes.

Thanks,
-Andrea
