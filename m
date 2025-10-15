Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C421D3F0
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544164; cv=fail; b=ugHyMr35DI3baaZr2O050C1JRSGkMWttwjMSO25PzR9jKEqV8PrYtTwPluVmLadnM8Yb1kTZtbms8MJx2hAxqQa6BNEXWFSF+ZSAq9SRUaUE0XqO5+3bwd5MfJNHbwgMbb8bRbCHC5V7PqzUiLGTvWr79pnfPG1Xf/n8KO6Mauw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544164; c=relaxed/simple;
	bh=pjyRSEkWFbKrLboWTLzXpyF7NmB8a9LnAOGnBliYkw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nY6KJwwMVrBrI2NimfFroxE9PBslvd0q7ng5Z49e4hlHgTYO9e51YcTsXM4sbzA0Peowfzcyhtj9r0B9bEwRJWVdFzsqYPacAHQfvNOibl8XOjDlRwZMOC5lMbjssJsleavUoju622VD+tsyzdCyjq6CVZH13CFB79boCNG32jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCCimhvm; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCCimhvm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2FJRsJBXAXmvG7eBUoZoRmoaBshtXWubrR72LkswBoIzo2rz0ykwArfo/V6U98mCV6nXrWf6DTPhJFs8L/Rslebm00tEYvYQhYycss9i2ewAgJoAEwhGxwxVv4EE7xDMakA5SH1ROXIml3c2X4iBs/eF8NpeKUwwywu6Z5MNgdlcT6tfXKVsf/eUQztgcLjjylosryUN8yicrZD50lphM0o1oqB10JPX+mTxSrVHwDSniIlSVg5f3QPETtIUtiM5WDesLJ9Rdud6qJccpJExMTzFY1USJo/N2zIsC7WFNWLWUvCAgUGxervr7+gVX7qMRmJqbD82vuwpGCZOmD6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX+PYDKwlyz4vReEWJJJMS71gt4rb9Ee2VBN6cL/89M=;
 b=GG06VxudFRiSoUslxCPv7HFWxgSEjSN+Xpkb12vr2lPdNphZBxCt5dMTCfA6kQdrHXXLK1pR5XLN9NeC/m9cCygQOUEkV6/UogNjExIR+45TO/USbaX0hnmp9OGZIldS6/NciFxsYZmQ4eGWLYNKlBLOQnPu7b3CuA96dOCQwTVMqtJqpn1+YZJ+zIBMnZxvvAfv6L6r7Du2mV1mpfhH1XW8eQQMTBc9vwcZpoSThHc5qNb6F40B3kis2Gd3j8fDqh6IyBxvKqFP3rD5Zp9WMGmSiWU2JOJ+b6EyGp1r/HObKxpYD19bACOrAozoIlNXJNBW3UT5NB0TeIYQS7cD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX+PYDKwlyz4vReEWJJJMS71gt4rb9Ee2VBN6cL/89M=;
 b=mCCimhvm9Y/wqMnUDNO6Wbv7GQJSw8Ly7vHUfb5F4egXa4qbzeFzIG2gk+ORQ53gAFFf+UKMpiIuNxF8ozYCDB9fjqTw6XXxPmdKCfoC/d2WHtfSVQ+ZVf5uq643aiVD3duLNQOGbmldq+FVDz1MG/QfxAb5ckPtzOy9HuQ7eOZLoFTL/bH/inSc9JxHPtAoprQNYLE8iRsy5vsZP7Dffugpr9UBP0riiVyAfstJ27Z2Q+wbD5tw+dYHkIBEbloJp1/51622ZFsoC0RXmdHWJDTij21I6lHkcEuIl2MKpl+98UPZvHE9CgOPn0bHdfK/2U3acMMmiSBmqeNKKWqDbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 16:02:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:02:39 +0000
Date: Wed, 15 Oct 2025 18:02:31 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, tj@kernel.org, newton@meta.com
Subject: Re: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
Message-ID: <aO_Fl0Zpeh9pvMFB@gpd4>
References: <20251015015712.3996346-1-rrnewton@gmail.com>
 <20251015015712.3996346-2-rrnewton@gmail.com>
 <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8fc42d-e304-4a16-0afd-08de0c0443d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNf7nAiZfIBz7ewfFE2Th+/V4X91xpG/P6HumwJ0k9uRV/ewigSasIQ+FvR0?=
 =?us-ascii?Q?QYpGzx9MnHt0QdY+Ucis9qUSXqkaPLvQcHNVEtf+ashALK+gRSBO2+cBdCGN?=
 =?us-ascii?Q?vf0D9iIj+om6NVfSsHKCxCLG2mCwZHnqO/j7X4121J9bNa3r9kP/Gqlm8w3c?=
 =?us-ascii?Q?HTN/HY5/ZNp2jG/zf3SWjrPSJUWprNlYMtWv7Uf716diYMZEMzrOCRAvWoXJ?=
 =?us-ascii?Q?h9TkuXMQirDcn0ShnzQnW1R0VE7WDObnc6r/6i+TC0WlKDCmfcryGW8EbIu/?=
 =?us-ascii?Q?SLno0hvXyhrsKlKcK5eptm2gjhIgIw/9+eybIB/rgOVBD8Yxc387H6UfbADF?=
 =?us-ascii?Q?JW7WJ+M43MMJPyho+aYuThbyeIPHn4UzBRh7tgHQJe2ijbKklCm+NOrz+2p0?=
 =?us-ascii?Q?N/E7GJABkmqnqjIk+A0313gYtLy636mQruApoiMTms15h1DX7Rtx+/8yFcFt?=
 =?us-ascii?Q?f7ELQxXGkXJK6e9o4uRDpQJ5Qf9MkFKW/UtebA7MLTofk2jpVxxWoocm+8fx?=
 =?us-ascii?Q?eJZGth2QJb+cSohUS5xY0AIPRJ+0knTOYCE+H6n1asurFSsRGa0aZpWAhNcl?=
 =?us-ascii?Q?Os5Rp4alXXTVLjhXJDsGRSAj07sDbM7fOgBVdop8wF2ePukU7LYbALzMzWOm?=
 =?us-ascii?Q?rLOAYWr5fD/kKXexImI9yY2JWDsJFSsJV+N7Y/qDG3FiC1+ivHkfUtMeHs/R?=
 =?us-ascii?Q?bzh+7g8cVf6iGx7355g5B/M6qnMut67gNCVeC/DZpTfU7zkU9SEGbjV1H4+T?=
 =?us-ascii?Q?SQT+j+0kgu32FSmxvaRxRUi3t3ckRomeudbVVZPzXwQkwmVVdr9LCO2pcd9Y?=
 =?us-ascii?Q?1puDe5XoYmZYQvkI4oAP/nWw8m8aekwuXNA+rHo3mceQWR3as9xk4pqqQjML?=
 =?us-ascii?Q?nEhcYEfVH6OFD6GoYCkJTUUYfB3Dfklr9R4jrGYABB7mU+ic1I+vHdnCaKuB?=
 =?us-ascii?Q?0sqy+NJt8j+xPIb5SajcfJiSoBGWv44ygieldGxKqI2gv9JhI5MaEOsaW3cs?=
 =?us-ascii?Q?qix1VHH4Je6az2ScBJLF0ldN2GnCkatULDtEgNGjeiD5JNUR6vBCuRbQwGk6?=
 =?us-ascii?Q?VBIGtFlzmNlFSRZGOZE0v4fvbmUSP4PgxfVPkApS4oclpbLwdIo+ReL/nh/f?=
 =?us-ascii?Q?5Jyl7B5yRFxey4Jzn3IXM/0vS5Wa40Fc02/myVV3X2bAbBMAQ9sirFQ2p4f1?=
 =?us-ascii?Q?Y5uzmYjTyZ6xJc+NbIMz/FQcYIR37zBeKBC4SlgRAl0PTq4kxVkaV/UbOBza?=
 =?us-ascii?Q?p5oysUXwGFrqHDRYhwQiZs84ZSFtDkhMxP75mJQJPjHxl1xavEF3YKc99/g7?=
 =?us-ascii?Q?YrOq0nFCtZOO4d6BUQXz1JqCXErW4sCNYvb7i2KTKyKIJQsLpTuihr/qF8n1?=
 =?us-ascii?Q?odiYpynds2FnAwLMHJQbUtjAnw6q+m7bkMm3ax/RDqHh9QU8cyNgZMAduwXS?=
 =?us-ascii?Q?q+WzC4PzfJTqg8j6qDSvDVU2XLF20uUN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bu3wI65sL50+MXDfXW8ac9siOXOUKgdhqY1wqt8i+pclBp32Qo8bLqpwrtqI?=
 =?us-ascii?Q?b7Jklig2Q6ctbr2tJ32JV/66nUWYSNdD6BHSNa5cpHa43ptBhUMYoCNwLP48?=
 =?us-ascii?Q?OQ7/BEgJtr82O9JsWjsw4ljUIC9Itw9VXbKX5RgYLtW2qeThUf9WBWfY2eH0?=
 =?us-ascii?Q?8Hu1/6TaU7+PRbP94QgloKOIsLR2EGshFU1LgPKLpIjK+Q7+ymAlP9s81XuF?=
 =?us-ascii?Q?f0JZhMsEIeEHqDLGfPRDhjSWKUTtvAhHyCKo8NZKpgqHMNemR3Z4UsNK/YBJ?=
 =?us-ascii?Q?KZvpmm7DmLz5ukx5C1htQE+Ch/UqTTHLrdeNffOKiqVMwO7jdagOjlTGdrdE?=
 =?us-ascii?Q?hoxXjC6FRgYgk5owTquG76k7EIQh2ZRweL+YOEGn1yizVe+9L8BdgOe+BXSM?=
 =?us-ascii?Q?n1I96O70OZPgzXsCLwwhAvyfImII5nW1s3S9QNqeqyzZNZCl9d2yZZBVl2iA?=
 =?us-ascii?Q?fKI+bh61s+nQeBhp5ILhROoA4R8o+g+8DYCV9JLmgLUkqykpr0XnD4zwXwZZ?=
 =?us-ascii?Q?HEDeSdzz3pXudV3cnJZxEmIUKmrG5M8ozWT21cVDkz1nfEYCIKZHutxxlDNV?=
 =?us-ascii?Q?gDaR9TbS9y1SrT7AJaXw7NnrAjJBuPyeruYv4QUQAZOzJmD9JrfyKZKBDQNO?=
 =?us-ascii?Q?ZpDubBV2tTmVm84/MkEjMnDoLolTwkYOibMlVnRkPQAOd6dxHibIU508XGIJ?=
 =?us-ascii?Q?Ny34pEGuZvHEl3cwGUOERCunhbqhaNbQnwKz0Q0B6TOYZyzdAG7xLLDIi6iu?=
 =?us-ascii?Q?TuteUQYZVY3qGpGZB+cgJFrfpPLwlngktpY5nW1XAJlqGy6BAEKZa3nNLdNn?=
 =?us-ascii?Q?IXVISE0fvqW+g6vstAj4Qa+eOxuX7QR/ea7jLtQyAtBQ9lhk9Cgims1EOD8n?=
 =?us-ascii?Q?dephBdw820GDfD0SGePrsmbRs6U4mQ2Ad21hNbVIUhSh+YTLIdz/LllVWhfp?=
 =?us-ascii?Q?CuX6QulNQ33iIJOeZRJBC30JtkH7kubOIrzeVopFf9fFVYyLtvS3bpZ/Qaf1?=
 =?us-ascii?Q?Ac/+Oq334hmjXma9fCEPaM5q10xWIthxUhaqjumtl+yOoy5yUl7Mn9kGFEJM?=
 =?us-ascii?Q?U838i2HV9gwfeT35bMP0JhyOLBWJbFtVeXl7HBMDA8pHcPi+CzD+ph7TDl+p?=
 =?us-ascii?Q?12K2v4Fs2f7+YNaGJTfTMUJ0uhcMNJC7/rvKWSE0RHm//e78+49hV2oG0tKJ?=
 =?us-ascii?Q?6dm2OOTa5vTZFE5onmmr1adkqDQFy7QaTU761RsRqOqmLfJ9t43nL2BTets5?=
 =?us-ascii?Q?8UbehBVAPGLYst4Z0qlULqLUOAmwNm0qYuU+owMxPBpfS1jAPn2ha98Gqm9l?=
 =?us-ascii?Q?beTYoutN+z59aFITX5/we081ERkLzrE+ICnxzJA0+njmMZ0tQalDyq4aY0Bm?=
 =?us-ascii?Q?GpvoxWB9YQosFLOtZNu1L8lzTascgXuw94SB+z6F4z5qt8QrdIBzuYVgr0Pd?=
 =?us-ascii?Q?bqXup+v8C+jK1Che1e0qfDG4TICXAOWkcMF4vgzzTs9ErTUcC+5/Xz/tq2rk?=
 =?us-ascii?Q?hYX0SqBU1/xnfxa2pSBAne5lfGcFuRs18Yhvg6o2W4xyEZc9TbuX7Lpoy2kC?=
 =?us-ascii?Q?XkBwzXfkJ6a0ZmRdPgyzRWFrAqrJl1EEEfu/fqkR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8fc42d-e304-4a16-0afd-08de0c0443d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:02:39.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+2LqrFd6IkEbF1UviKVOcazs0LZw6bMbDXMPaya0LRbwwPJKI/i9BAZDST1kIOKbUdxVOhlovmE4PZzrl1hhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

On Wed, Oct 15, 2025 at 10:46:52AM +0100, Christian Loehle wrote:
> On 10/15/25 02:57, Ryan Newton wrote:
...
> > --- a/tools/sched_ext/include/scx/compat.bpf.h
> > +++ b/tools/sched_ext/include/scx/compat.bpf.h
> > @@ -26,6 +26,24 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
> >  	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
> >  	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
> >  
> > +/*
> > + * v6.19: Introduce lockless peek API for user DSQs.
> > + *
> > + * Preserve the following macro until v6.21.
> > + */
> > +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> > +{
> > +	struct task_struct *p = NULL;
> > +	struct bpf_iter_scx_dsq it;
> > +
> > +	if (bpf_ksym_exists(scx_bpf_dsq_peek))
> > +		return scx_bpf_dsq_peek(dsq_id);
> > +	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> > +		p = bpf_iter_scx_dsq_next(&it);
> > +	bpf_iter_scx_dsq_destroy(&it);
> > +	return p;
> > +}
> > +
> I think there's an argument to be made for this to just return NULL on
> !bpf_ksym_exists(scx_bpf_dsq_peek), the caller needs to handle that anyway
> and at least it's guaranteed to be lockfree then?
> I don't have a strong leaning either way, probably is fine if documented.

If we return NULL, the caller cannot tell whether the DSQ is empty or the
kfunc is missing. Honestly, I don't think being lockless is a strict
requirement from a scheduler's perspective, but if there's a case where it
matters, we can add a separate helper, i.e., scx_bpf_dsq_peek_nolock(),
that explicitly returns NULL when scx_bpf_dsq_peek() is unavailable.

Thanks,
-Andrea
