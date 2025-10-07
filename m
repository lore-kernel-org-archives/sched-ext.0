Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6712DEA90
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857926; cv=fail; b=Npc8ydLXDnXTbH0p5Z/URTG9qpSUClU7uq/BlSVxAbDTlR/6CxYIioBaI0d79X5eLw5rhNXGdpeDj+AwwKTvDm89VK8fE5DT3zvBhJbgUfOnjIZ3eZHRdKn3udeJ30ojNnrNvwwOyZRWY1sW8ym5ZT+Tb6i61dLqV3uXyOho0As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857926; c=relaxed/simple;
	bh=beHsa/JDvpReKbNQ6XRRcF34vqs47fpukmsovbGX+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H2ziachjSgtpO40tQt2US0mnA1mo2FLisY1XDrCQ9m6PtFYfnIPzTDmDU7rVlhpLB6zd+l+2R5+ISm40gv3vnd8QQfQJPCy9VDdcc1M9dzUZoaNkUC75ovhK2t/5MnDMwRnrk8tqIfICxJDSYfZDf9tKYxtfvDnXgpNdHOvbalM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+/blt6v; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+/blt6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQU4bnfZI1Bq/Ocg5sNLsLqv9wCItBwOJdCMMaQ3iGDF/piWt0wcKAkwAg5pQpc/Z7kw9ikuGRZaYln0T2W383MN6TsXj1r48g3Mrmd/mHe+VOYC7v1xyvDIPZ3m0ifpWC5vvkd1etCUWlB72Ruvj/71TMlnS7JDeREM3p27N3puyneOnFyTC6Tn1+h2EZmyfRCgN1FqKPoFEHaL89CFJlV3KzH2HwAnmAcxsi1vtIcN8wPDi/IUM5y/sPmZNh2BSTFZjKUo2Fhfx2G01WdyABZIVO4ZCcjrgne4DKv9dct/TMqO2+Ke8tvBVDrj9qIomCgTPdHvLfL/tspBft2Fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpIn+NLER5s1nKbr6UDThmDa6D2xv9hHObmlWpmloo0=;
 b=h9O3Rs3Mg9nFwCLPZGgboLuYmB/6bKPcs0Z5j65MtPz/X07nbTyTRUeq2Z7YzipQU9+g4FdePPdO2xQFZnXHDQWEn92CoT7A3q+WwTMmd1qAndsRmdSEjybA07pxIFNdrfM2BxYKTT0DrbaQxIyfv70nPXwVlVPCASv3xl+JUkCXWF/+flJ6lS5+3dTuNoc+IUkWlhwRpnsePfhDYfFiM9j3cSnuCM3E4pY3MfUU/KknHuj4ruy7Gb+ZNSjtJ5ItiQzuoQiujylCqMXm+m4NrFkF1KXE9U8r2gmKwWDuV1C56Ir5hk9s/gb8VGAYWSst5AeMUIeDMU0MqAfCknDf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpIn+NLER5s1nKbr6UDThmDa6D2xv9hHObmlWpmloo0=;
 b=X+/blt6vhMCvTwsKO+vruO8yHDrmFYU1of1K1dTPPijYF4Gip9iuMeMsJP3ck1IzLyzhgcWYuiJDgS7NF3od9mHiFJc1JGAW1fcow33Xpdfw3P0SgV2bxnbzSZFVJI6P08ydF8D2M7+n+iTjrLwvB+BCVBF/AlZ5PPY150Z0pVN9VxVilaTj89tocekiFoKYxV5BUJPprtfTiFx/HJyqWIGTHUsyQ4YtLDE5YD3jYH03r6pTE3vX2YA7Nj2uhbKHpD/i8Uw3uU3iVwsCu9CKPLVbOPHbqfH6vx5ZzvHdNASzM0j84PdhY8T8Gnp8No5I3c8F2kE5h7/latGNNNf7Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 17:25:22 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:25:22 +0000
Date: Tue, 7 Oct 2025 19:25:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
Message-ID: <aOVM-Fnc744FAxKA@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-5-tj@kernel.org>
 <aOTgMIGoeBuOGldz@gpd4>
 <CABFh=a5QHpNh8CAmw5-REJuz1Qzg0wFEp1ZeArM9O1UCN5ebtQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFh=a5QHpNh8CAmw5-REJuz1Qzg0wFEp1ZeArM9O1UCN5ebtQ@mail.gmail.com>
X-ClientProxiedBy: MRXP264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebcb851-b296-4670-08da-08de05c67ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQG+9SKNgl9ClXimDpeRTcbqfhjFDBQL4nSBXzQfzEQGKcDg+fGqFEZx+M61?=
 =?us-ascii?Q?Tdc1wd5izwHI2UIelmTpXj2OlqDDDLlceEw2swUj1sfRKe7zWMsWthhGpdtY?=
 =?us-ascii?Q?zM0cNxoAcWhME6qYwDkPzMic7D8ISCHALV2PkOwLsDgfR3O5qCBETKo6JQrN?=
 =?us-ascii?Q?cAL7XXCzAECsSJZJ33OCbwqdZCa5S0C1taMk8KeowVKxSpwc9oMjSgPBpaZa?=
 =?us-ascii?Q?cjJrkIv6kjqTA7mrJ6B7+CngcJVZvRA9FjEzY5Llkf3ZJDpJ2vzMmrWx5PDz?=
 =?us-ascii?Q?+vbwojnHsj8p10qA0tHm4sWFf5zPi2dgw4zWJVRvjiVGfaxeakotHFZu2RW2?=
 =?us-ascii?Q?dPhPPGEo+/UBNiW0glq4WH2Pjnq/GX6MZnY9+ICMAB9KU7K7kVXwfh1dZdiK?=
 =?us-ascii?Q?zMkDeNXa7qQIIvfRvFWbUiMsjzld0leYl8Pn3S660be4T9buadtuE1kgS6+c?=
 =?us-ascii?Q?kwPPzR45lSisCB7D1K/HkE+lxy3s12kabaNtBSjcgXBTkMQ4grsJayDH1imD?=
 =?us-ascii?Q?+0FP/nwF+41+epxMyzhjaoSdUj9fDOPfffA7R220e6QI92ItX2ELXByrAKNY?=
 =?us-ascii?Q?0jFIXfwAX+7pfvXNycfnmOMdkPQ0gV+SUhecVlVZj3Rrm5ygpZNXtS+zXlXG?=
 =?us-ascii?Q?kfalIKHVdGwduTmDexKisCNcYyje2YV7DqxcxmlMdYPgTLz0DJHgDL7350VY?=
 =?us-ascii?Q?au/fUXXfMS/Apcy41LYJOPlwnkrYD/9ePiyulKv3yvXSklrKGtvVQhVzhKfj?=
 =?us-ascii?Q?aZ2pa5p2QmprtSJf2H7bPqX0OXqG0HoC4rtryHguV4WXissUJkzLe0ftIMwR?=
 =?us-ascii?Q?ps67AT7wwPPbyqGIwze3GLewQiSBLj81OK6XUZtGsFvU1nPDH7MxGzeBOKKc?=
 =?us-ascii?Q?BxZ2JLSrzM3eueCqTZAFVUm1Eg4fxVTuGx4LpsBpKrxXEFrL8MwDAo2FGfc/?=
 =?us-ascii?Q?QD3kVG8U+ISAvkHGb7Foc29z8aFZSK7xGvopjlVzsMPUJK3ybYuVaTiuPeaZ?=
 =?us-ascii?Q?0LYUwLUIuL557O4An8Md5tyBia/oJsb4goVPolgAqvNU9QjmLCBuLg9QUMSe?=
 =?us-ascii?Q?1WAJ/RpR4dmdbbW2pQDCESSCWO4mryYZKa1kGzmSyyl1USC92ZH20x6+fzMb?=
 =?us-ascii?Q?9AAymYLpJTvNv1y40hskY+YdrBbRX+vAhA8rLsaCd6FFBrZ7mrefu5Ein8fq?=
 =?us-ascii?Q?qO/ClqS0G4+pEwAo0J1TyPO9yvl8R1l6hfgfQNM0gkTIyLA1tLMh5hBuA7Cw?=
 =?us-ascii?Q?yD27JKIsZRbkEHyF/yoMrUjLxAdKtPwStzRMiBUQFN9OUwXPwLIEqhivqyah?=
 =?us-ascii?Q?d9JSs9KUDT6+ij8cKDYt7XUdSRaZr5ekdfvC/39kdes1Yj5H9128Ta6z8Q+O?=
 =?us-ascii?Q?bj2+jLrju9avFhbE/JSJ8jPyy9hSrdm9kxoxo9YXekU9nOO2OgvO/5iB1gSq?=
 =?us-ascii?Q?uXgEg4jBOiQWAOtjQyyQ5JcWTuT/gXPe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMuj43vgsDUWx0Peinsmcd/5E9QMEqhXYsyNditF+6MZ2IibTfryNCp3H6Et?=
 =?us-ascii?Q?fsB/Qn2MNgR8WeGaPZhBd9elMnz+t2rpzf3N6e/mWe+1eQFojDhNquleE3A0?=
 =?us-ascii?Q?D8ajRZLBuFF+99XQx+K2GYMzoUGw7I8JEzvlx7bVPSobJuEM+EPfKa170QFS?=
 =?us-ascii?Q?ySiQTV7SmOLXco1puNWiB+lYnSW5eqb2ocBoWW4LxJcfC+p9rzIF5Nage23m?=
 =?us-ascii?Q?U9bgwzegvLVUkAsrk4DzOCIQxaokSah+OGPpKOWNBe910wQEA1F1bSU7i1I2?=
 =?us-ascii?Q?mzaxM1hNaYcX5uD+xq59x7Eh7Y5XQAUaIHL/2gFlPM71wa+RzhVekPZvS5du?=
 =?us-ascii?Q?JJvGEHbg3+EduI3TXUqFsOT7jyeoCahfsOyK0oaoDZmeduM5dwxRgGfY7Irp?=
 =?us-ascii?Q?gZVJysuaPx9iyIzceE66q28qY2IhuvvpVMZTb3Cp1+1z2r+rt36YiVWUDaUE?=
 =?us-ascii?Q?OtBxOUYnXkHmpV1d4KFuAJf9iAkFd8O5mzwSf5/Cn+1RjTPP+/H2Tn2uNL3B?=
 =?us-ascii?Q?ojiwwgOsy8k5qUCkxQaD/UbwGKwA+1DEpjShoVw8LU0bshtuGd/NBiOJsz6T?=
 =?us-ascii?Q?3upTaSO/PrVuGTo0OHh7f5/9S33ZaQ1IVcyY206SyjgrULWXaRBBIcBnQ/sg?=
 =?us-ascii?Q?q4itbQ0zLA0gNQP9VFiQocmcPjP57Mm06ZzIgok2FCh7OFUgvFvB26/yGSP7?=
 =?us-ascii?Q?UUvb7kAwQ8fxbLf/8IycloK+C6GDbFPPCsxNy1ayltcfKFCf3uvGZPSvU3DP?=
 =?us-ascii?Q?9KQ6rHhHxsHDRAxZNb2in64Vajic6ki32jHXeU4k/Vgv4Mzye1FfO45uibMj?=
 =?us-ascii?Q?iEtt7YaGUx3sa1wgO0ySuTQ41SSaGBSUXnznxeEAREAeSnYrp074D+sAkCL1?=
 =?us-ascii?Q?lvq1i7dHq7qasxSNlvSdZiJNlgwIiEPMnIw4V5vtWoTf3rdqFXox8sUGrC8q?=
 =?us-ascii?Q?kykgstyHco8solM8CgLkfgcRZpHVso4O1gDI1+W1QRcraODydJkaydIPMwIB?=
 =?us-ascii?Q?Nz7vPholQwMg8sW+VG2xQ3p5mfB4yEixqkNgr/xVFMesqN72SrJfvAwbuKxm?=
 =?us-ascii?Q?s3Ko0hVU4mFiznYeqhm1aBh0CqtkxTGcSNQztuoVXbdey2um333q4yZmvb7R?=
 =?us-ascii?Q?w0g+ckoVMaP3iCLY3DnetA/tWPvW0EoMD8iAfjhJR8FbG8cPhQZNcUotDD6B?=
 =?us-ascii?Q?8LcCJ0E2vGT15s89RAHiIr7LxCmaOCqAAgGdNoCY+G236m/q+IraZyWxWkdq?=
 =?us-ascii?Q?DomNyrgZaiRkiLOnAKs4B9S3NOzuzD1NkKLekiKv5C+0TxU0VB/OWhPW2HlH?=
 =?us-ascii?Q?k+d2oorzFitFvybQUBjSbrggkznm8HKAa6AFr6j+nVBYxEhtZf5xCKqDh6pi?=
 =?us-ascii?Q?gr7BItrvdFKR2dVQVn3WJB6TqPJ+MXJMzVbddzJlVvyGU1hxP4VQ5dCviHTm?=
 =?us-ascii?Q?uOnVNmeFfNBrc7PelpefB/D3oQ842g0x0xWubMEyN7dmw+NSp2c/UYd7PpM4?=
 =?us-ascii?Q?r34L1XoYPfTdReRMwyEY16isLGKgsy7QS/27fvTgV2cIdv5BXDmdsgqJLe+E?=
 =?us-ascii?Q?SaMtNLC0/t+RTC2Sybc0PW5zutVjmuVzDC7BeW46?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebcb851-b296-4670-08da-08de05c67ecd
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 17:25:22.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zlb8gYF/Hg9PNjd4c7BVgiwF5IDIVKT7gO/9x5zSX4Tdf5BV9pPAvOoQFCJ5bHEie71IQzCZLMiCKdKm95dt+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

On Tue, Oct 07, 2025 at 11:03:04AM -0400, Emil Tsalapatis wrote:
...
> > > +/*
> > > + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> > > + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
> > > + */
> > > +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> > > +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> > > +
> > > +static inline bool
> > > +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
> > > +{
> > > +     if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
> >
> > I'm confused... where is scx_bpf_dsq_insert___new() defined?
> >
> 
> CO:RE relocation ignores suffixes if there is no match, so
> scx_bpf_dsq_insert___new() defaults to scx_bpf_dsq_insert() in systems
> with this patch. When I tested it the symbol resolved to
> scx_bpf_dsq_insert(). We're not really matching the name, we're
> matching the signature and trying to find a kfunc with the the
> scx_bpf_dsq_insert prefix in its name.

I see, TIL. Thanks for clarifing this, Emil. With that:

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea
