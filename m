Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CF367F5F
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170382; cv=fail; b=MXt5vpLN74JB4JuZCTsAkZdh7yq6Uy3MQBqMdOQilDIUqjajJjF4rqK5OJ/jzHJJ+GUekuwsfXHeO2sxUIaWhT/vzX17cUoXpXIlawUKmYzcQOXvbUL+2/zZbj8gmJ6yZVqXoNZajOXud/5jKb1dd1WBkDApkDabUVwRqKYHXC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170382; c=relaxed/simple;
	bh=r/DzB6M+E4Ge9PlCVom6lQhNfVDyc1Y3sFPofafTBuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jaAfIxIMc+xeRw5XE01nyXACAipyYRMgh0Y7SmLTma0LWPva828T0tC9u0epzwgn8j48SPmQwNILVu2s/IohyKW9c7d8NFPjZxHRBAhHaW7HYw8cYQ6N/XgXSZG/PJ38Kg/K7ex+2baAuDfEk0n5UM0B8ZlaKKhKusnSfNLUL1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmGQeCQC; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmGQeCQC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiIr4pIbiH47aHJctWk0yK2G/3I7B2i15/8qRXM8aMLI5X2lEZcZdREAzFM2cyjpXupBypSEB2dRhKmGKjJvpENeKNiZd5QbSdxTwqJkjVHwiJwEkOrWQMdvFpP3nfoBBdGm1t2K6rFwdatXpTE6MeDAhteVAxqga9qqzh4a5+ZyeKXGh3tfw5veq84bt+N3PkrR/BUd6d9d5YV/9ffQ+ILDjVOmPrQ9EK0eQpeJHRcHnkFGE5sqLAzACBJYOyHBiGUFScyMqelIQDM0/sUYlGSpoQbxk/C7c45XPw6umWm9q/rWRC2XPbkWAQAG7dkG9VpBny+x2fgYMVaLL329cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veoRxKfhZhrJwiU//us5oJbetO7TWZYTfIWuIqtB+yA=;
 b=XoD4x4gVZc8gbp9H5FxxfeOj2+W20egSKRP9rq5HPkswaTPQ1T1/KBhgYiGNyN9si18J/8onaAIiYrhnmKgu4cnWcuFgPlou753fNCdHwiTESjItZO1ekGzXLHkMs3uaggTvPjdTz1rjbxEF5VmJ8GCIJpX6clxtbrjVLWrKvT1dnAMIjFjdEL3GK7bB0MYf62rPewzJtANA38paqsS3uW9lzVM1W+ud5qh1wMloqZHWSRRYzKxcxPHxQW9uHrZQv2i2X3POLYsmLeWQhdofLBrSnrLKS6jvuYLWdDFZCs2AhGPNaDTp+NjrdLDqW/3dLJnhwtfUaBBpcD85NfpBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veoRxKfhZhrJwiU//us5oJbetO7TWZYTfIWuIqtB+yA=;
 b=dmGQeCQCs7P9FEDMJFUf9tAbW5Elo9t1OFKDW7i7TML7AzpFx2mgMlZET4TKhV8UcJBv5lz1agkyqfaKumxGZ4pMuwHQFrLiG8YVTnWsrOegDF/m1JtQ/AbgkZuXGeI9ogsSJ3FJEDy6j1a47RT5gUkKUZWZtEGZIXwXiAwJ6LgzJcr+lpkVDwUJFkreGpRrzieGYKLPJpuDPiC82svJnHebLWki7+7C7qdHvYDLP5/RL8gn3YqIYp7TgQ9eI1lmdt2nkw4xuQVDIhBeJAdGPchHBiiG9dB1L0qew5CAWEBNZOldIk3oB8AekAv1CsD0pYwOwKDd65oGzke4neztkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 05:59:36 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 05:59:35 +0000
Date: Tue, 19 May 2026 07:59:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Message-ID: <agv8PYhW2qQ1vYwT@gpd4>
References: <20260517183614.1191534-3-tj@kernel.org>
 <20260517192930.1368685-1-tj@kernel.org>
 <aguOlyk581-y_Ru4@gpd4>
 <aguYUvewD7bkNXbn@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aguYUvewD7bkNXbn@slm.duckdns.org>
X-ClientProxiedBy: MI2PEPF00000B79.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40d) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b04c58-a080-4e70-8e92-08deb56bcdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	qCCqrRHe+c1daHxbn4QIU1K8+4HvawNC7K3TTGyOeV8r4IRMerHBv7qjhUY9iTiFdOkskcJVSMoTXqkv098Jn1v7EhtEnrwnFN0ze9nbzibBj5hjzWa7WLZmldUvpgu/dXC0voYQwhWdVcae8A4ab33PB9Z3P4PmA4FBrCmquzM8O+dIYNFdntBpHLvUloWMTX1FkrhhjTh29m80scROZmvnEr89o1t/hRqCHP9W5xLKxyb8KyKLH8H3VKQvrUCEawhdQhcPRieqPBiIsRu+ZZVeuKYGBr0Xh7tb+nQzXEiJmwKPYR59ypZuYCmID/h4ENjM90dH3ThORMZFV8krDVldMSgG2HAzg7GEn2GxQHOwpu09K+dkSUJpcWlqIEbIqeWhH0jvdjjDzLXKU9XvzQ5zJovI08wQGF6z+6lhu+cZb+HQ8ipr3qpqbXtaVC+Vgp3dYIGO7MqR/wqAXPBLDAY0Uj7u2UYSlNbtFnyUXzAbN1aZd0Y6d8emJXdo4eutgukAMxBK4t3X1gQdo8j1jfTBJx9jzouuN4Elmq8oRsphZ+yTl03XQmWMj4FvuLeBDszv3vpzMlbrOTRlDrQjWbjPEQT5fDS4iek50szmN7nRfrWeztoKIZDkQ5oQiyZ3iNHE2QpbRhQToP+d9Dy/u1s4iUb5EeFR8sEf6wSo4uEW+lnytYlsjA2o99oCen3m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IngvTVRJai5nQ9d5+dn7Fv32gPZAeGvhnYEKbnh1bR5Elu2vq92y2f59u+Mu?=
 =?us-ascii?Q?TYzqf2rppXQwOGEKui5k1LaJL+FA8wiNedOZSIwFH5v86oTlLRz40p6pKOVO?=
 =?us-ascii?Q?36AV2/014vPeVWQMc7LWu/Ru/kYPln4+Eqqf2Hf6vCRK8jyLg4VxEFqxrOuQ?=
 =?us-ascii?Q?0J1JuqDEcFxk2zyoiGPA9NvR0qpWYR8xrC9J3Ur0T4XgB/UNZ3skkmGuBfq3?=
 =?us-ascii?Q?OFeXtnjPXsqAs30U+R99nCGQXckGImFy0kpQgCoUF7GFDvJBayvJpjkr/E9S?=
 =?us-ascii?Q?N6E1Sfv/be0xSLPZoiDbZC7rElMG0x8SL132/zfYJGPTn76eC2eSQtwJJlaQ?=
 =?us-ascii?Q?GNHovVuhoms2u9OYuHFsWRsy5qju39vBIBzP6n02/7+wbIMJwMynHceOXWlk?=
 =?us-ascii?Q?Dh/jzCrOUelnsoIZ5OsY1k7OW/jMDMamYv/8N3d6XlmvXU0RSmOz8dKpUH/l?=
 =?us-ascii?Q?lri+ObOsPSzG3zI587jpHiTBU1H7IC7J2oHbH9Q8yGsUPX3/Z2nYUqWzB5jh?=
 =?us-ascii?Q?g7dWLb5qV6rIquDCHFqRm84cR7dTHUiRluzop7FLkdqvQ6FjFCSWpczIjQ9l?=
 =?us-ascii?Q?UMVPtAyoHD9NrXgq3XjtkNBN1Jg+rYkWCCo6Ov4Sye5GQ7QM+1LRtlrD/HAe?=
 =?us-ascii?Q?z0cm77ykGNzulo/SqWwMREd2dWTto5B0rfFOCK9YltiC4wUSZctqDZ0ZZ+ZP?=
 =?us-ascii?Q?BJL67fLLaXEmBJxBJXCbu2nulwBKdb5nWcj6XrGOwLbuhZkXBbJltiMr+ZQE?=
 =?us-ascii?Q?kO6irosxLasoFrxr2Bip9f912PljlLmwhZqAqg3LZdbqA8DNcuSe33i4hhE3?=
 =?us-ascii?Q?/7aJiZC5vr06p4Ewdm+SRJSQUUsOkhHjslnF3H7+qseMBcHNUHX93LUB6ADu?=
 =?us-ascii?Q?y0QF88s+ANkkUOWlyo3DLRVzPQYG8b71njHIQnwbA6Fm9NSPad2/zm5z7bx5?=
 =?us-ascii?Q?epHCJCv4dOX6NDLLCpw2WdmVnNN/3t/2zBMaCqsmRqfcyZGqe9oBKgk0JwLZ?=
 =?us-ascii?Q?7AdMk7nzKjdA5mvZ9a5ISFoiV/fIAfaSktRN3RxNy/m65rA7qKufpS18eCGw?=
 =?us-ascii?Q?ylz/6MUSRXHOa5M+ZhwGPKPFmBgXCLDUdKkYf9ZSlp82iFFqwIWh1GBg2Jym?=
 =?us-ascii?Q?tOSnLQwxIakui2YlqpMFn3HVMG1d/GEhBotDbpz2BvnLHf6ue5VMgzOCCXZO?=
 =?us-ascii?Q?9tnkC6NZRX/3vmNAjs41N+NhtC2sNcJ7yDjQgqf+GUcFqJypCkgu6fN/5ycj?=
 =?us-ascii?Q?FntKT+GWFwPIcC39MgBnPkyJPT/dxNJN8BvVKMO8kvvoaOwqlChqLauzva4Q?=
 =?us-ascii?Q?4IDktZZ8lHuNCHcLLul66Uy92AuFnG1HRaOhb8lcO28yPDE1nkTYFbTm5pyd?=
 =?us-ascii?Q?WvSy78qM7XRpx+9ubSvaJsJTLKTC0QtGkcfhEDfbz5bdQUR+SHjEG9/4rC7f?=
 =?us-ascii?Q?WGU5xQr33ngPa6aqJa/XZKCZv/Hvapu/F6zjRH0FqpN5VTM5siprTNl9gN8Z?=
 =?us-ascii?Q?Cb1h7rP3EvBB+pNeQZNHDhDXI2UfSiBx3qPpzkYxnfXgvlbhljDWBboywMNR?=
 =?us-ascii?Q?Xj8TuvZBcy5HFhk/usq13WgZcRDcB2LLDvuJORKdNY7HvRbhKIl4M3Yu6/GK?=
 =?us-ascii?Q?yNp+y1UFRsB1X1VC1HuSLkirv/8Ad2dHQfiBSJ1+oniGFPVLy9TxI2ST7aLu?=
 =?us-ascii?Q?bsVOhYx6t+wWKUMNwINHlu9aotC/D5uCdkwHNT3GBeud3Omv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b04c58-a080-4e70-8e92-08deb56bcdf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 05:59:35.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/qnYK5xL9HHDZdgbz3RYpzgXtoEG6+AOTZYGy1xKbp1KfAlTTUhX0j/pEmq7Ce5mBioWjE+NCIMwyIdnL6WJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF

Hi Tejun,

On Mon, May 18, 2026 at 12:53:06PM -1000, Tejun Heo wrote:
> On Tue, May 19, 2026 at 12:11:35AM +0200, Andrea Righi wrote:
> > > +/**
> > > + * scx_cmask_reframe - Reshape @m's active range without resizing storage
> > > + * @m: cmask to reframe
> > > + * @base: new active range base
> > > + * @nr_cids: new active range length, must fit within @m->alloc_words
> > > + *
> > > + * Body bits within the new range become garbage - only the head and tail
> > > + * words are zeroed to keep the padding invariant.
> > > + */
> > > +static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 nr_cids)
> > > +{
> > > +	if (WARN_ON_ONCE(SCX_CMASK_NR_WORDS(nr_cids) > m->alloc_words))
> > > +		return;
> > 
> > Considering that:
> > 
> >  #define SCX_CMASK_NR_WORDS(nr_cids)    (((nr_cids) + 63) / 64 + 1)
> > 
> > If we pass nr_cids == UINT_MAX here, we have:
> > 
> >  CMASK_NR_WORDS(UINT_MAX) = (UINT_MAX + 63)/64 + 1 = 62/64 + 1 = 1 (wraps)
> > 
> > Should we simply reject if it's greater than a certain reasonable upper bound?
> 
> I'm not sure what we do matters. No matter what, this would be a clear bug
> and an unlikely one at that. As long as the backtrace is dumped, I think
> anything is fine.

Agreed that the bug is unlikely to happen, but the WARN_ON_ONCE() wouldn't fire
at all for nr_cids == UINT_MAX.

However, IIUC scx_cmask_reframe() is internal kernel code, with no callers yet
and the upcoming consumers will probably drive nr_cids from bounded sources,
likely num_possible_cpus() and such. So, the wrap shouldn't really reachable on
the kernel side. Therefore, I guess we can simply drop the WARN_ON_ONCE().

Instead, cmask_reframe() is the mirrored version that is called from BPF, so any
loaded BPF prog can potentially pass an arbitrary u32.

How about changing the CMASK_NR_WORDS() macro as following?

 #define CMASK_NR_WORDS(nr_cids) ((u32)(((u64)(nr_cids) + 63) / 64 + 1))

In this way CMASK_NR_WORDS(UINT_MAX) returns ~67M instead of 1 and in this way
we'd get a clear scx_bpf_error() backtrace if it wraps. WDYT?

Thanks,
-Andrea
