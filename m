Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79D42DFF5
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510125; cv=fail; b=szJcc4U+/dPRg3s2GYxMODmg3ieZcP3PrI8YQdGi2+z2GmSwO7VrYST6GeLbH66SE8ivCj4ln5hyP9FZ7fmMQFQOV5eYZ9KXQYi1tGUUWg9kKjwfGEgFONmOSa1HbJ5s4XQIG5Ch7Op79YErtuOvJXd/ILkGW7HxGUaGUbmJZs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510125; c=relaxed/simple;
	bh=IH+GNEkO8G8M5IrOlKpSiojRXArENQCNJ1ippOki/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DO6lIXOIOt5zNAVHoAnzJX77HXZ5s14ox+5C4TpXWBYxsS+yW9Uxm4PyPxyBPEiYlTHPrRjG/+kNo3pTYteev6OT9OpR9wLArT3z6Klk9FFcKYEor8BJqBqX985CtwDxCpqGljcs8kUkQ8ULDCnOSMfCXXssGCdmqE/CNIO1RkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ScRDM1Ub; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ScRDM1Ub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7yO+ODaXZPBTVmbmTfb2yyDLwiSyJP9/eD34TNZV1p0Ol7yAVt5RWEiCNl7BZ25i90wdrPfMJIm6JXRRVPOFKS0EcJB3D80PAtDDbl4vd2CY/XGKgGvWm239StrURNBkcSHg5QlvIszUd8U5Uwi8QqW1d/VMxRChg1J1h+HxeLNX6TrSN0JfhnvU9lhErrQFwuh5hayMXA+C5Y+P3fxhbOg8UeQ8o4t0wZ+S4z8h5p8ObkThVAYDw6VfQGS3JBlGjPgzFyFg3r+M06f4iEcVQ8YKTxfHF1E3efirs1zm75h+OB15KfKyLPho6esox2OAiWCEwIAeySjiJW6tiJ5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAr3bTP4VO37OcWdn7sy0lw2RVzbbHur4l/a6XMeKOY=;
 b=GIizLgbDPARV0Zz9pIXkxEJ7Nm6vLE1N3CakzRRNex5ECCKoxBhDI6MXZfHCKlM18kCRZJOPsHxAbpUuPV6WMph7Iw/MROBS2pLxw8zzNJ0Co9aHOril1AiJxHG1k9BavIIsskIW+MIV5cub5gqPIXL8xHqJjZboUeMZC07PFzTodKGjXhkyp23V4/63PlHoeNiwl7dMuKx3yrg6jIOg7OKsGHNRakoj0d8HDl1pj7SuVUzhQ+lHg8aEMdm1sOZBqkoP7tMAQjRHCqvN6qYKHYMrYVxTBcHWiajsU7HkFdx72eZktTpvoe3ol1vwKLfBuqVfCGxJawSHxwI7x4Ob8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAr3bTP4VO37OcWdn7sy0lw2RVzbbHur4l/a6XMeKOY=;
 b=ScRDM1UbcnwuNRcKIJn8TMI02V+3zipzDD+7P6YYkrnqVtGa9NzhADh2eqvbOvpzXSgWH1PuJqgOMywuzcUnxbtAAR0MFpD0xlMV7XezfZVv6ZBEBwIz/ep/jLexyxJIYlmnpB+TN676KZOF+GewVvA51P9QUiGgh+PoskcXwQenSfiTVy0HmsDIDqdkxRStYrXozhCqaiuYid5vFHOPj509WyfVxGNF5Cgihusjv9PwyUOEeWlwh9aXK0YDHrx5A7pje744s1gZF/ljNvRWVGVzUC4X6VTs6cMMxCC7ZhVhXnViQ1SV43p0MPyHnuwAPqT4hvRiKLPLni3GRtzeCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:01:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 15:01:58 +0000
Date: Fri, 31 Jul 2026 17:01:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
Message-ID: <amy43SABGSjpJaZk@gpd4>
References: <20260731090334.2911948-1-arighi@nvidia.com>
 <20260731090334.2911948-2-arighi@nvidia.com>
 <DKCP3MW35928.SLEV2IOR4IJL@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKCP3MW35928.SLEV2IOR4IJL@google.com>
X-ClientProxiedBy: MI2PEPF00000B8D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::414) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f4c95a-4135-4416-3b99-08deef14aaf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iZmWyT83/dXkvyajjUtqcXcIOa/TfTP4DBoP3mlFZsUEcdIxGtItu+ox6J5Sia2wlQ+kgi/4Mzo4WTJDDC3lPZda0w5Pwsh/ufG3UtaG9niIFzJE5nuWBJTsDb2YRc72j3lDe3sXQbBTlEttcAp0cPHzpITr6r27XragyiCme6fJPYSf6BRIka6ZtcGZCwaILUSFoYMllfINEsVbD1g1uY6VB93vn7DwBAD8SZwO3Jsf6ftiEj/mUTjfLstaFlg6HYHUMsWMla57jRL1L1skfD1Kc+NVLzYllLWNN6fvXFv0YeNFrMKmebYGCoYYLo1x1igwqffvvxx5o8Ajvtt5jxyjceDbSWhv35GIUPUY+Mo8dFukIA1iw5L7mZDDZ1oapzQFyKzQKmLqm8mQVsvs2yL5pxakbZRn1VwCPPaPx739N1+RrbSJDszY5wWeL2ts0DlbEh8EdNmLa5BdMKP5DWOdxekyXeSrAInvvvodzU9AQdMGveUTvI03KjT8l/vBVonVQ8Yq1m/tjepuHg8S6DqJsNhp6SER8NCAESpli0b/Bs+FfRabX23q6J1o4X8PxAqYkGwKPzYZKtyNVcAEJAFijFhjgV8Y+iVC2tdYZeGsqQG/aB2wdCMneH2I6KcVDyqM6F5hYjsgnM29Am19AhxeFpBoGF+EBh0Re1hivxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGiKwRW1Fb7sI/izF/oYptEbsB78K7UIluHHQUXyTGVkIUkMGfnilICfdp5t?=
 =?us-ascii?Q?jRmbyUW+Sx+7kMh7QHLXGDyWANPLSkcPDaMoBEZ1gq7AlJPGe+IC6qGb3Ljh?=
 =?us-ascii?Q?sNkdC2UeoTsusZXumXUA6TmgzaypNaV5I/Mi99/C1dJwQ3d1vldlI3B1d8YO?=
 =?us-ascii?Q?wiB5tjLphNQQEcrej0U2wQS9UWU1vkv5XbkLgVuE8pAKLMGbfgLvlRQYjYiI?=
 =?us-ascii?Q?RdjgOB4pColw2lwNo0Wb+Jxj79/gPGLzejne6WZVdHwwDv8tHvr/b/7SduF2?=
 =?us-ascii?Q?Baxf7Vrhi4a5/1JZr5r0c2AGAXU4o821gv+P1kQY4Oka2Hcvc90MZwhAWjX6?=
 =?us-ascii?Q?2uRt1JcGj87DSKZw4h0Dp1YXQStyIbtaAXphHa9y5XzZeFEzMg2otEx1MCud?=
 =?us-ascii?Q?L19DM9d/pHLesmpPhZNAsD3lWoqdb1fEyzk27yooQhrbv2YKHwG6MDFzshWK?=
 =?us-ascii?Q?vdKH1uJaDeiGrZopgHBmHeAWxksVHBOk4BVu/Ifs3SSFtFIo0uTl5WBSpu5K?=
 =?us-ascii?Q?TSluILMWqdt0WTUfBcIxH2mAsElhy1E3ovWbWKv0pBZdxKMa5fnH4ujC3B+3?=
 =?us-ascii?Q?9nEuoLcQL0PO7UHBEvDlo6MBO6MDUXD31Te7u/TiE1VSyuJQ+QfFMeKIyCEv?=
 =?us-ascii?Q?W7YPoQziDTDFUYPMwIPYDZriOWwpNiVUy8mrulKol3kU3Rp7AqBbOg92vAh6?=
 =?us-ascii?Q?VXiHMplU+/nRgxuutzwDeypQZB8/hfBJfqveFAyTiBk1/PZtmYjoKb76LCd5?=
 =?us-ascii?Q?Qsm4G2k4RrPLSSyDJenLiEQ3Ek0p1BtWowGqu55msuCHREWsB7JnwZZ31j8j?=
 =?us-ascii?Q?M4ayw//S34f8dC0ozyRw0VA3XnIOvGkcjAWQK4eJ+NsgilvXVTyKusNBosjY?=
 =?us-ascii?Q?NfjLsbgKlVDiwm4WQioTv94zhsN4/vjn36Li+w0gv8ExjKc79xW0SnvjaqPs?=
 =?us-ascii?Q?C/A3sKKJvWD/6SRCaQpndfpJETK2u2ixHGuDsufBH9cW9EPAkD6WNvK4gSZT?=
 =?us-ascii?Q?FnIxzM1izdjalaTTDxxqMQe6aUb/Blx7dJvy9EMPACN3m5Ju8j2XbgM+0sAR?=
 =?us-ascii?Q?ZqRGWvHdQfTV/wgxSLQy2XHtK/5Ejml+xBwuxjdxniSQvI1TIRku2EToBTHE?=
 =?us-ascii?Q?7hkiZxgDb3zkE/cKSmMGuIn2oKop0g3uaqc12pzuH8uU/eavhgeGcUy/7OU4?=
 =?us-ascii?Q?BfwtYku8eipLSIYSnt1cY/gCLxXWOrkumEj68yskSvsb1mcSrEJ/fg90BkaF?=
 =?us-ascii?Q?e7A6n/78ZlslouGMoxKiaPE5xQ/ke3tmG1fRgLSiYgVnRPB5uJux6PHF80M/?=
 =?us-ascii?Q?XkFWagxC+ArYRn15gdwN2XGUUuTUhphZpK/fxgwIB3819WBXb5RgCQSi/GQE?=
 =?us-ascii?Q?DG+FsVPBjEyzolnz8QIpFEsiwXhNk0BjlLb2UqYfXAKARAzW/GSjhL/Jz4iH?=
 =?us-ascii?Q?RvgVnEYXsi874vNc3OEdH82RJzn87gLyaECira+WIZnuTFWZL5+Iapq5P5RW?=
 =?us-ascii?Q?5To/eVX5kRLMDQoh0SXHBj/2Evq8DmQRcJQVQRJWikVUrBV+mZP05ZTABNKh?=
 =?us-ascii?Q?djy6MCktxF60t42FLaiupqLezQj4z0oXx67JQnAMMvwPq0+AXQoag/T2yds/?=
 =?us-ascii?Q?KqEKk2cOaxCH9+ucL7vDuU4J5geQUnolpO6Sv6GhpO35VCD9Ly4wOKHuh68N?=
 =?us-ascii?Q?ANpj9twolEv27xrW90PV9sFReRBolPeogXiqllfBqNS7hUPrbqHi2Phxsn4i?=
 =?us-ascii?Q?0JzIRNdLQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f4c95a-4135-4416-3b99-08deef14aaf5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:01:58.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM/O5L/KbpUCiGvEhU0d7p+C3qUj1IX7qVhhsVdLd/JSXeKblP0L767OZnPVyPxUhuA6oQ9e6FrTgI/N7Ge/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

Hi Kuba,

On Fri, Jul 31, 2026 at 10:47:30AM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Fri Jul 31, 2026 at 8:59 AM UTC, Andrea Righi wrote:
> > @@ -59,11 +59,13 @@ static inline void init_sched_ext_class(void) {}
> >  #endif	/* CONFIG_SCHED_CLASS_EXT */
> >  
> >  #ifdef CONFIG_SCHED_CLASS_EXT
> > +DECLARE_STATIC_KEY_FALSE(scx_idle_tracking_enabled);
> > +
> 
> I was originally thinking about reusing scx_builtin_idle_enabled here,
> apologies if I wasn't clear enough.
> 
> My reasoning is: If the user is doing their own idle CPU tracking,
> in which case scx_builtin_idle_enable will be disabled, what's the point
> of SCX tracking idle CPUs?
> 
> Do you see a scenario where using one static branch is problematic?

I think you're right, I added a separate key because __scx_update_idle() also
delivers ops.update_idle() callbacks, but we can retain the existing
scx_enabled() check for that case and use scx_builtin_idle_enabled only for
early tracking. So I don't see any reason to add a separate static key.

I'll rework this in v3.

Thanks,
-Andrea
