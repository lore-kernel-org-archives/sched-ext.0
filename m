Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B52F60B5
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161909; cv=fail; b=uk0BF6wVi+H4aBwDfmr9YRWy68XCDLous3nA4EY1CW8LLINoJ2/nnWCIphtylnxgJZAQDD6xdGV7mmLOWqvZ/Crt1pjzgmJRxvPahBfiedjcbqRxIKTfTWkdzdK/Ic8rxzPZH5yBcqc6tGI43w4MjHOhucgWySSQjrK6b1VHq3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161909; c=relaxed/simple;
	bh=qsupy6ZhJq9I3eFVluUDhSJoqv+FcOAQ4f9wYRejQy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyRx7nAkglismQMYw83u3PA1TUliUqyNzDI8IjjjmVt82ZhJuXkptwMejtB35cJ8+ryECmPjLw32UwHOvDOLAQhcmUeprR1yDF0xGuUjQ8g5YOk2eb52GbL+AAUW8SM94+mTxziRaq1PdqzIQbfY/Dl62b7jyDodDBSW+BxoRlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PIV0gHEC; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIV0gHEC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1SbfU96cxX7tlYB7yfFhKuHNDCbb95QSHIUpn7azI8NRdqEozK51Xud9cwChhy8X1MxiXsawYC1IvvZf6pIi/eu8/oxBMhSQKmtwyCWZaRXJEoTzKlByZYDoAyGbK2DcjZEAj2yEDYGDQAsl839NI1XJWMZBGv2V+mraGoRYXg5Ir5AiDYF+pubR+KI24HoePpxSDwSZlJlUGRyI56/zlzIkvybC2PoRUDpHFjXG97rl29KYxNEjmNFZneoRqS448dIfyqrENAjBWdr3ZDBdNNJwDvNc/dmgkkPyM3jj120S317AQeWUoiggwsa5eo6Pc3G/KcywfSDB1kSGe5grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30MzsOrQG2RUwGO3jMl1wLigCJJK/3eOGg8eL1CbBzo=;
 b=pK69XNO5NFjdluOaBjXbsNLwiPfRhtOr8roiSN7joYeWK0PYl40e9xwzvnYdyhaxHcX+xw2lG3Q2ZvhDLzwWxka1N2d32Mzn1RIQWc1ArjciRXyq1Rn5HBbs8w7r9ZPMerbVv7BtNQNLPaXTUATvoTIm+7U7xEaxydu7eh9jxlEGf71jLpBhQiTVHshcDN+TumOOLED9Dx7F2wcZSZN8BUuPTL1HdkLqy6Rc1f8jJIWkDiuIO+dcYo9Nxflp4P4ZSQaWn/Ahd3vgijB15xI6IHUZbXvpvc5EdmexvB6QvdsMaV/jRSJQK/tHRhOK2S+BhLGHZjmsaZ8wxEKuKNi4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30MzsOrQG2RUwGO3jMl1wLigCJJK/3eOGg8eL1CbBzo=;
 b=PIV0gHECeQWXoF6PLEdP7NJuvDZERgvqWfwsWBsqoH7Bayjtfl9y05lpoYHz/owu9xxd0EKCcZQS2Trana5wXlAbd2NO8GSeiiIDvSZkhZVrEnDk7I3/cSKgL8z0TIJueye6s8lC7c2EO+4SQ0y9DN0ueIx44yWYMxjfo1wjte+DoHJrw42ftrcOs1N+B0RYVksdBav8fTHryEsAuyq4inwaiqFrpkK8/AVbOc8YH0scSTNP40pMr0+HZnRc3k9wEvsVw+fcCess+s9a+HpX53LDpqq4KUfFqVK3rbqN2wgrayzQKVXB340fLV/zrO+HvVEeIoLAme/AXRev2CGMJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 19:38:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:38:22 +0000
Date: Wed, 22 Oct 2025 21:38:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.19] sched_ext: Use ___v2 suffix for
 new kfuncs and fix scx build errors
Message-ID: <aPkyphtSDYDydnUm@gpd4>
References: <20251022093826.113508-1-arighi@nvidia.com>
 <20251022153610.20111-1-arighi@nvidia.com>
 <aPkHqpPGZ-9EBGUz@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkHqpPGZ-9EBGUz@slm.duckdns.org>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5a75f0-561f-4afb-c630-08de11a28f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xfxg/Cc8JQ5bKXEfr3pL1M+G5RlriStjKWMU/fX6oK2RYxxFJqlMySXF4Nt?=
 =?us-ascii?Q?lcvMw98VlXct92Q4flh1q3RNjwxJvQ6dB5geLkv+HvhmR4pGK9YYMwlC3SH5?=
 =?us-ascii?Q?FXTkEbNoW0khY6ZyEwD9o8Sufb08T00hCeSI3pVxgsAioPw5DkQhdRVd4Nfl?=
 =?us-ascii?Q?FtRhoz+FlkdkgyydyyC7yl5WxZNZBwnXxbYH1AiDTf5rZBh1WKs7JesRmMne?=
 =?us-ascii?Q?4pxcHA6OBwt2t+nd7z3G+3AWv+rh6mxp8jxKNsegySMpEO4MEWLA8QPAhCFf?=
 =?us-ascii?Q?dymNDmqNb2KkodZaxFWTJL47fkfcdAUGzMIManRA+hu26jdgE5yfITRtwdrO?=
 =?us-ascii?Q?Y+nQavWHDs+FLzk2Pm6KtTkv7YNRHS7abRjUYKQiidYzc1aN5dT698eAYYYK?=
 =?us-ascii?Q?4thg87hXMZ3xO68d36EGOC8g0A1dMPIyz0XJyh5lhN+Dx87OzeQRGHcQunaF?=
 =?us-ascii?Q?M+LlT8TZOH+45H3qSTUMwRXkqS/2OczFLl55r2+B0MvNlUHr6RcdzkC/NYpT?=
 =?us-ascii?Q?gtaOAhQ1p6WfdRCWUjZla0JGreh83aE3r9v29V+4bByfRJ2wkMRrRRltngcb?=
 =?us-ascii?Q?sBdfq5Jf/q2lku31g5EB8EiD1PeDkQJId/saFqO+hoowmOSVyMlTNIE2+nZz?=
 =?us-ascii?Q?zy+yxN8TDjVvq1IU0mWkXRuJHNqiDWDOqRJy09DqOJnoqVUIILEO3xy+5q5E?=
 =?us-ascii?Q?XcwFF554C/HcNPuur0LHzNkrL2HPmp6tjtCZ7VJv7W9PRPnWpcZOt/SG1feR?=
 =?us-ascii?Q?D7KSEOcy6pGekKdnH+Rl6hmX5mmM2eUp2gRehUeQpOcjre/tCc9CACeBwYJr?=
 =?us-ascii?Q?6o3qMU/UVr/S0NfTCPOxsQXXcWak9IYsa3vbbnLWNlqIwbifSZcnAMZ8Hv1C?=
 =?us-ascii?Q?2ot0FO6xZMG2xTZE7WGUHfqvjS5z23mAENDR1kEmyjEF6FtiAcI4ikC2Xm3G?=
 =?us-ascii?Q?0KqjIOvRVwU/wyezp/I/cg2BIikb8vf7+YZq+20Zp2Mxo8pv5Ybg6IQOlVl9?=
 =?us-ascii?Q?JHsxqWkkD8VRUZpQe6uRk1loG3fUVUO9SRYnAH3URwohg+gyjLNDu3pYq1uL?=
 =?us-ascii?Q?p8n8eCdrzqlRfhrwyN9ciM9kzVF+ew9dekvSNxlATbM/ztM9u3gfyFg9P35U?=
 =?us-ascii?Q?8lHK1+NH4S2rjYXabu1xH8JQM4tdSQv2b5ACN+LBYew4gR9GFgo0T5HM5Bml?=
 =?us-ascii?Q?9xjy/SULG2XfNDw9Wkur7XvRhGdEDNlhLpa8VatPPEOrTcGi6cqBwJNcgaGM?=
 =?us-ascii?Q?aJ1SfPBe94Q0qcPMGpvm6XD5Foda8WMACj/337bzNOCtf1WseKDd8oyjO8RA?=
 =?us-ascii?Q?FyZHERrHLzCJWy4gW0vtvRQsXrPYKi3BDrQuJy+adFd3NZl0aTIWI5XKuJ7j?=
 =?us-ascii?Q?pVZco84UU+zNzZJp6NSpXzDHzZYg+4L3ag+OMJE75BVjZhbHU5QGH3rVireP?=
 =?us-ascii?Q?LrhEDxmiaMej7EMT32BfY9u2v/OzB4xg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nz8PbzQ1IZhtRY/eXTb1OPvLUW6KmnD3P0geSk6vQBYAG8UQBUzCn4v7oepG?=
 =?us-ascii?Q?6dGyRKWyto686/deplldWansJu6B0tHs5ChNgu9OqlRTZaKS8/AVqFBFugkS?=
 =?us-ascii?Q?QVMzT6KQY7c81+Yq1AG5SiPp6J7r3BsraH3Djrh/r0QvJgWoYNci0g1u55Se?=
 =?us-ascii?Q?X9SLpw6w4t/L0keP3gfoPOVs/lYcn/SqGFF8fiee8MjpTkCcOFgnsLBxG8Gy?=
 =?us-ascii?Q?boon2qA+tdOgSEdJZzkwoiVAD1RshVt0kbk2S4gpILUAVZra5JuNEozVGis3?=
 =?us-ascii?Q?C2ME/w3lrh8jnICHsoybIkesKcSc8EZETCG3VqYlIe00hNW5z2nksicyEoTc?=
 =?us-ascii?Q?9kWFNvId07Dc41PmPoaWLXwAUzeubTa5N5pAwzBbI5bNvslSpYAIKhT568ob?=
 =?us-ascii?Q?nDYVjy4RJ4SK1FpCNI5MM4p3vEjUWxOswgsR7wiKbOU5FWx+iCc9q9zcRTl9?=
 =?us-ascii?Q?aCo04zN2/zoE9+YMeI+7zwzB7BifQcO9XRQvfsInwZrB2Ak7ABpDulQaRgtK?=
 =?us-ascii?Q?nSUNkAtSYcmGsou/jFas5ekrgsIEz/0O88nhahHrobn5cjlhmlV0rg25DHa+?=
 =?us-ascii?Q?tLYetgERrCqA0HGV03rNM3HMO0ypoVTEN/kukFYZKHD+0p35K6D3NB7IbZUB?=
 =?us-ascii?Q?klEyebJ7wy+NheootSYfAc94jBc/0DosGbRFu9ts7zOKiiSfH1DBwrUt8+r0?=
 =?us-ascii?Q?uqzKJVM4cfegds03XmXFQH2/IwPQkUhliqw93Blen4iB8l220FWrM412OW/L?=
 =?us-ascii?Q?MjGVAFu7fwPpXBQ1x80zJZakw22vTNivdAlGTGXr3mcDzw2ez2lVRG6AXkkh?=
 =?us-ascii?Q?M611bf0c05MXPH7skcN/PC637rWRfZZM8tE7lLFwpM7psoXJdhfjx3OjsUYa?=
 =?us-ascii?Q?SZzyQVmf7YUy4LHLx4777Qi4h+5fLi7hw7n+OuLDnj3olnwiJARQ1sZ1o8YT?=
 =?us-ascii?Q?t46DtscrM4kWkxT2PWvVl92Tl7LriDyPL2RD85gvfnXxcdXHGaa3M3PbBaqd?=
 =?us-ascii?Q?9tncEMRGqeXIwhk44ztAXqqw/mfHYHooJvLNuiPrbsw1+mxp9CBF/HugBwP7?=
 =?us-ascii?Q?EeodIVv9qkGipGbM0az0G4lwZmFht4QUoYbMo6zssWAdELHsbolgTMh2R17n?=
 =?us-ascii?Q?j9CG5dDI0HOCAgYdlsBjAJhzFtXZkTryUfPMCABGW6DyJ9ahwrQlrnicB4mJ?=
 =?us-ascii?Q?szIeiSUUvnAot1h48ksbl72XoT25ZwSdH0GBD5X0CyEkIWI4KsPaHkGQvc8C?=
 =?us-ascii?Q?iI8y53GYDeXy1+o6bjWx3C1F8j2xK96gEp19dCgZUM1U8Bj2xB4hzMUO5kCC?=
 =?us-ascii?Q?kO095f0/cUSUemzuLbvzfyNQB26wigbe5jijB3MwdLTfeyjdd6BNXJ09D93f?=
 =?us-ascii?Q?plgZ8CzbZ8QkwnsRoWTf6TB8TvHDO8KLy9ENJ341bBs3v4w7pDb26TYUl8xZ?=
 =?us-ascii?Q?vTw6ZotZE7lv6JEABzEoaOMI3LLYGNazdfTwO1OPZ05zYu+z0KVTWmymbgjg?=
 =?us-ascii?Q?aMgJnaTf19EbNgARd2CHCBfxMXYuJbITbTAYiWwD803tF4B2oZOqM7OiX5C+?=
 =?us-ascii?Q?z8SGadO1Ozx076MKbEeBXRgHvv0IEjSupzsIHv4E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5a75f0-561f-4afb-c630-08de11a28f93
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:38:22.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz6fp2J8OS05c5m6B83yXxInrbT3YI6L4/gPVjxhgcHCjxZdtw83btnD51zQ4WWQa6LAnr+/qIsqvpU3LNl4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

On Wed, Oct 22, 2025 at 06:34:50AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 22, 2025 at 05:36:10PM +0200, Andrea Righi wrote:
> > Following commit 2dbbdeda77a61 ("sched_ext: Fix scx_bpf_dsq_insert()
> > backward binary compatibility"), consistently use the ___v2 suffix also
> > to the new scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and()
> > kfuncs.
> 
> It's a bit subtle but the assumption around ___VER is that that isn't (going
> to be) visible to BPF users and will eventually be dropped. Here, it's a bit
> different. The arg packing is something we'll need to do indefinitely unless
> BPF lifts the limit on #args. So, we will continue to have the internal
> kfunc which takes the packaged arguments and user-facing wrapper that hides
> that. So, I think __ prefix (something more explicit works top - e.g.
> argpack prefix or suffix) is a better option here.

Ahh ok, so user-space schedulers will always continue to pass all the
arguments "normally" and we just assemble the args struct via an inline
helper.

So, IIUC, using an _argpack suffix or something similar (instead of ___v2)
should be a reasonable solution, right?

> 
> > Introduce __COMPAT_scx_bpf_select_cpu_and() and
> > __COMPAT_scx_bpf_dsq_insert_vtime(), to ensure schedulers can transition
> > smoothly to the updated interfaces, and temporarily mirror the
> > definitions of struct scx_bpf_select_cpu_and_args and struct
> > scx_bpf_dsq_insert_vtime_args to prevent build failures on kernels where
> > these structs are not yet defined.
> 
> Given that there is on capability difference between before and after from
> the scheduler POV, I'm not sure we need to make __COMPAT explicit. There's
> nothing really gained by adding the prefix. This has been evolving over
> time, but I think a reasonable rule of thumb is:
> 
>  If the SCX core introduces a new feature which may affect BPF scheduler
>  operations in a noticeable way, that feature should be gated behind
>  __COMPAT. The BPF scheduler using a __COMPAT prefixed interface should then
>  be able to handle cases where the feature is not implemented. If the BPF
>  scheduler depends on the new feature (ie. it doesn't want to stay
>  compatible with older kernels), it should use the interface without
>  __COMPAT.
> 
> Here, there is no noticeable feature difference before and after for
> existing schedulers, so I don't think it's necessary to introduce __COMPAT
> prefix.

The problem is that some schedulers (i.e., scx_bpfland, scx_cosmos) are
explicitly checking bpf_ksym_exists(scx_bpf_select_cpu_and). If
scx_bpf_select_cpu_and() becomes a static inline, we break the build and we
also break binary compatibility. Hence the __COMPAT for the inline
helpers...

Thanks,
-Andrea
