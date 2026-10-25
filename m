Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792923721;
	b=fHROQDSwB42AnEV588d9fFjMoA8GARUhkS5T4g7u1y+y+XjHvOzBbBtmmhnvBpvwL+Nr
	 Er/6YdYQGzMcvE9yh85hpUBRsBtCwL6cvdIsnBKjC3jWZmbHGykF7BA1K/RTd08eqncmN
	 6P91i9lPKRxxLIhJtBaxbmsdCG3k+VqTxqVEv6iOg9HE10h/D8s0bREyLcDJd6Mu2cODI
	 wUYwMK7fmoVCoVB+g8FNtKuv9BY67qoV4AOzNXFjeORqw/4+oozePcdyfb0qawe1sL8Sm
	 IWPXZsQ1jc0IJh+DvgkhBj1ND4cobanw56QWcsE13+elc9iniMdJ9/zJZ+9yOfF2z6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923721;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0qOYGgLvEzyMr3buvUTFf8mKClm0tUk+ro19wcSfIwk=;
	b=1Zm4NkfNu50OoBDt581eT/SJpUFXFfEucaAAg5PuIxtYCqmYBl6UgUuJMZCUBfdfxv+j
	 qK6bvSNEKwfQIv8ag/un6bvTsSK9Ul9qaJ/oI5gznkEj7W+MPDFqvkkyWQKn2Gr4Dz74+
	 h84zsP1SHJRNdbYMnjxy+J2Jb8jngCVD68P6n/3Oide7mj9h0yFOPAqPZX3WSsyrZSWMm
	 SgYa+Jd46kRzXlMFoWCIOlOL/13pme95Qfc1KxT3MX3xQ3wQCtahV2Ox45LzXxWjyprJe
	 R8xKSOrVLUGLi4gSK96ynT0suZtJflvAMhWb9ioZ4EBMiT/yhZaDuw/omQAM8qM5eYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m0wQESzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.32
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5D606A31B
	for <sched-ext@lists.linux.dev>; Sun, 25 Oct 2026 10:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C5D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m0wQESzV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eunIP3bgfDkLQUXRsYSZuk/J1v6Nbhp6/zmCZ+dx3D71hGuJwySgPkyqJRjV2AqFbznHAXiORqZPfAXi38+e9EK21aGT/poAtkyvIwJdcKjjJ5eJJCEWNhYeTd/lt0oG7eY1lotA8zalOtfJCO/Qs8MLp69Lg3UqmDebmAqGyCbVbKF3dFZ36v08dA9lF16O9ZEitmCGrkTymXwGcHz90ZgrccbiS0Ti/EiOYtD1r3LLvyz0wiHaHokUaJL1UxJz5ZD78LvA5njmyrwhE7k/QW7NIXvO0gVtxeb1zZTRAQkrQucc3+rHFh1MeHnLMHR3OE3rXykbYsiosTKsmAgdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qOYGgLvEzyMr3buvUTFf8mKClm0tUk+ro19wcSfIwk=;
 b=h6Xbm8rK0YMd5ShkBsE6HaZvwo81XNl3fKEH6MZXO7k52xdpuHg28xFW2mo9AWiJ1OoTZF+tQM62xp2K6a6MedaJ4msSSKWFjdO59QPiOdw1dgOtVbSkzK/+wJ8WNPaD9RY8QoVcisB4+MG5yoeodygk7U96dvYsk+EJQkXC628qWapzz/+0QmXhGK1GKWc50My86SdSPoYbPitnE6TiQR33RfruhrvmPn7LuneESMKnOiBqf+00Kw2uGhBXmhmzMSm9EP1HD6IMjKWCEQwu+4h1jR17FxVQXnkcfDNXLj8gVO+iMKnvhC/BY7Ut/cT4pIwl++qg7QBGsJ2LII7v9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qOYGgLvEzyMr3buvUTFf8mKClm0tUk+ro19wcSfIwk=;
 b=m0wQESzVnOegtuNRQkqU8Dw4lzARCSbZl401e6OjOsZBB1CDplzkREXSsijjmoHNUNZWYyuTXNyo6PVggPkYLfkMXvxSuLH7Yi9vQ1blY3d72YGWqSfzHqLDigkE+sAZ3or9LVTQiNgtf3khX7rw285wKlKdq53uLkV2owM8l6SLKHTlgiqOL3aNjXMplX83dMe9EPSNPTa8yXExJiJitds6je+ayXnCHmibNHjqOXryFYaOhiokKzgmdyZopK+iDntIHMQtxbWXc1iJoJL98FSny3EdM3Uu+B+xNsfJbN7GciNdrX7jt3UO013+wdMTB0W5kIYex8eRXKPalQMUKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by FT1PR12MB455478.namprd12.prod.outlook.com (2603:10b6:170:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 10:21:57 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 10:21:57 +0000
Date: Sun, 25 Oct 2026 11:21:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Sync tools headers with
 scx and fix unsigned enum reads
Message-ID: <at3YP-bVKwyfVKBT@gpd4>
References: <20261023232102.1124938-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|FT1PR12MB455478:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e95b4f-6335-49f9-10a5-08df3281cc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	LmZQMUU16dkDMV0sN/2W+1dgxjuhflZMC34cnbjt2CGyyQPwWEJQLCSBWK08g6eiV+/AuwxE8sOG5a6Bf4LP6284o1HzF/W7O9Ne5+2Ux1RYo4o2oiIGMIbQlci47RjWG6zQ1eebpEshdlLX5yOXVQsXuaaypUc80W6wRFJpp9YkpfSQ48/70+mI+JtInssZPQzVunMtOhxjVEnXQ9nEvjyVyROUbEOgEUvAbIBagdbMp8loeIBWIqJokZpjYsc0E+CCcbLNQkSwlxaPeR4odyuY1CA8yd44/Dnahhvh6/n9SQbNsrrhvgI5N4nmznsazf3ZGlo1/NzgB3tUaTEpI0K3XIP0M1jFXr/cdU3oR/xFpyYPVMODZWpaVGIBNM8rjOITX0APwWvCjRB8vWNH7iIQn6xCbjH/4prlfnrYEgELlIg93fS7le2CvZ/gFaQGPni13Ne3gGDPS13GFGyyTlF9jscOVv5Mv0QKh/qDJTG8y/JkFDSF53uDx9ogw81bNvY/TOLxDTrFVRTllmGk3UwbX0/b+aCHGGx9cTp7Ubiy/yf99h1muLKuThO2G3KPMS1H2ZeA+rP2JnkiNsvD38n16Dok98UIFggRo0eMLbnDCERB46rLfNHWsdYiwNXH4k+ofU5OjCbmdGzdhZrDgWyj/OPrnefK0ahT0x9jS3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FmN1Vd0U0dajAmy7zybMvD89HvOXMF7lFUF9kDUVO0WeDwTtoXyoGgYrDFCL?=
 =?us-ascii?Q?GCrqMI0e9Ms4lTFvq6Tz6TYtz6uopsZbs1AeTI7L+pxFkTQBB2KcqlDLCIYU?=
 =?us-ascii?Q?V422btfjhRFBbqNxgQ/tjO7600dJOtAZUbEOVVErHHa8PFQtBqvWhXQ4/H6n?=
 =?us-ascii?Q?jEdSyctHFkny04jY4EdBaj91SkvqjNhyTERDEf3mb3wGx/FmFpTidiGFc0R3?=
 =?us-ascii?Q?W9UR1QgFI0Ol7u91l0wcURCF7tTCYTMEdNtkN2bJXYd4FsvQlN6cXdQhjfoT?=
 =?us-ascii?Q?rAgCt9qEm2XSUhVWkG723zeNd6CZbA7e+ppuXPt6uVNGwf2YPBIXdSRCIlp2?=
 =?us-ascii?Q?75OYLdBA+HUN8FxtBZczN7a1q6Y22riQSDEOpKnqOkOk+//FcvMreabbMAcq?=
 =?us-ascii?Q?9uZm+bBRNKfLCVokV0Ev6dvvl9H41+cVA3ozF7aJUMDp8AVRPFMOZAA9uFnC?=
 =?us-ascii?Q?lbo2Ae6FTW9BZiEQi3eFHwrmSxh1zsPH4DW16fuCiuuqfgS6FqYmaBci7dvc?=
 =?us-ascii?Q?EfDmSfPitkPrQJYlAHb+54FRNCM5eY7odpuUE/rGyQcT9+hmfaJ4xZZaDFS6?=
 =?us-ascii?Q?BPQNMciVn9F1WGPvtj77IX1JbNIR9IyegKMd/0Muecf46n92fDguzl6QfK00?=
 =?us-ascii?Q?BDOGGO13qXy8VHFNF1RtEpbUkB52aQkFE6ssjr0GTWLtTQgbXdOuwm/sl8pW?=
 =?us-ascii?Q?wQAKQacwmKfy4szjFUYgIM5cCb+b5NX9hrCXO4HdKoKVdB3/R7oON8/33fNv?=
 =?us-ascii?Q?YkbpRA3Z8mYzrXPDGCvMJlzFrC4En1AZ2JhNmHAhXjg/LXsbOkRXolP/ydQ4?=
 =?us-ascii?Q?VWOc/0SnZbElzbBmg+ukuK7drFoaBKW+MOiGd2SfMAO67rGtaGlNiIbxicdD?=
 =?us-ascii?Q?AYzB0GFdvkh+GUUgVeFGfOOZHToG19Pyi/UAyI0YeTkJ0M+oZmHyXiY8fZDg?=
 =?us-ascii?Q?eFCm6z+ameosAbUyYpirpH0SImPErcXcs1UCGm7xEif518IsENVqS4yEBAAE?=
 =?us-ascii?Q?5sMMkh6wDWHpqo8OdISTmEeuS7dF2CsVRK77r1NZ+9BXb3IlTwc9NwgI5m4A?=
 =?us-ascii?Q?sYzmRWQmjv0hBhxJ1jtbNbhjVO7oCTAUFDZFDNzV+FkWX8GGDK4sxfbjERSM?=
 =?us-ascii?Q?X2oSzWky5x0tzNndVIUUVSvoVXB4fpK/vlhF23cjBTj74jTMf0N2RIxoGZuz?=
 =?us-ascii?Q?zyrHleQBtG60HGPoaqt6GNZ0PXqHGGlSsMllgmiiC7alqD2ZBpoL8vrDiTv2?=
 =?us-ascii?Q?3I6mz/GCHOfcXesLYkXwzO/lbRPv1rcZrowfJ500nO3Cyc//RTRhOhA+mww9?=
 =?us-ascii?Q?OhKJbULvT/bvPulYjHJ7gP2EAYoDwcc1r1DXzL9JS0R7i4DSMa7k5v8tzend?=
 =?us-ascii?Q?aKZrGkVoxw6MEDIcBkbMabPBcP895yMBBa43vvdpeg2asDiHHRRqlNR3QO/9?=
 =?us-ascii?Q?8AuoF70e+Lqnf4h6x42C2a5yxFJqTE9j7yMrsyQhuYTPsiMzkE/yQlVTLdSb?=
 =?us-ascii?Q?f7cDZ79IzEsQQHh4bd597p4/14EEKQCip6twtWLdgv43a9reN9o+87Ymo4jr?=
 =?us-ascii?Q?jCiUh63Yj023NCVA5MSz2ruxKKS+y6NDbNWjBVuqpNSVos9SvLO8axLJvPTQ?=
 =?us-ascii?Q?piNjRGoyD0IJZAKUtzYWu0AwogEeXThA7E+5hzltMH1ceO0b35J4Zo/K0zrn?=
 =?us-ascii?Q?EkeUr7p+a4JrCwN2ITiS+P5utamA4kLNcJgGqb98aYCACfzk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e95b4f-6335-49f9-10a5-08df3281cc90
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 10:21:57.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj5VGdVZ8KADm8pPqpAqxggl1xoCYHTBT7T8O31XW+RzYG5+D4OD0hRysnsoCZs8Ly1VtH3q+Imm7VHfkAMNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB455478

Hi Tejun,

On Fri, Oct 23, 2026 at 01:20:58PM -1000, Tejun Heo wrote:
> Hello,
> 
> This patchset fixes __COMPAT_read_enum() sign-extending unsigned 4-byte
> enums, which made SCX_RESCUE_DISABLE read as 0xffffffffffffffff, syncs the
> shared headers in tools/sched_ext/include with the scx repo, and drops the
> enum lookup table entries for enumerators the kernel no longer has. The scx
> side is https://github.com/sched-ext/scx/pull/3930, merged, and
> https://github.com/sched-ext/scx/pull/3932.
> 
> With both applied, the shared headers in tools/sched_ext/include are
> identical to scx's except the two generated tables, enum_defs.autogen.h and
> enums_abi.autogen.h, which each side regenerates from its own vmlinux.h.
> 
> Based on sched_ext/for-7.5 (dd3b1d9be27c).
> 
> This patchset contains the following 4 patches.
> 
>  0001 sched_ext: Don't sign-extend unsigned enums in __COMPAT_read_enum()
>  0002 sched_ext: Sync tools autogen enum lookup tables from the scx repo
>  0003 sched_ext: Sync common and compat headers from the scx repo
>  0004 sched_ext: Drop stale entries from the enum lookup tables

Left a comment (nit) on 1/4. For 2-4:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
