Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62F3FA5C6
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690961; cv=fail; b=McoL3ZbCl2xHF+sMtl3bcLLs9Mz/Qaa0c5vqVFv4n1HvzQFMtoaU1W/AQofCd613sDguptwrfVB6Y3L0JH+XPLoBkZokUjBd+u8j4SFBXYyZWkUPUdXpHxRMFfZa1D8aCBzWxRX0pL+U+sOSfhTexv11ywEhjY99/6FMaHyjfts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690961; c=relaxed/simple;
	bh=6WMuTJP/vyOXfQKb5ZlDngqW7M6JyUndWZ96sY4TepI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aLyveDyLTshiuctlAbHy7Dnquc6byHWJDTd+toKdtcxV7B3kUfHR3JAo/y0kgkPo4GbahIHGn1YCkyUVOj7FGVfl4lbp75Vc2azRYkB6idnhGgYufy8A/El7umAOkx2DDT5vZF7YGLYz27ruKzq9CD8S+i/TobQOSSw0h0yEkoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z85QlDV8 reason="signature verification failed"; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z85QlDV8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/1AsCm1v1xVWw2FQUHJXOOqQIfGnaYSClRu7tCyDG4h9LXGXnc69p4S4bUJLMt6WyGQ2//WZqaoVME8ARzmiRaUwMq2QqfB4QJYScnYV2iNhwBNkDZaVAt4FRIYcvN6i7jWVUP1FbjgZulqcC6RR+y78kgp7apc87IS5S88rebFdINQRJi4/raHmIgk/u/J1zmCsTdCcQ/guvaALVR/9o/kuMaSDPGCdTedrGhjsNpmOYDfl/sEZ1sVZLn5Rvx8yYjUGoWla2e+1NjDGZYwjXTqmvoWGwzwfTFi4tf5YG5U0zVD6d4hcWxTrN7Y7C8CVIR6KoAvbe2nxmQA3Xqo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TluttUsQiv+y4K9IT3CC0GIibz5P9dCSsAm48iQFZXM=;
 b=hD6CcPjidDhHTmT+DI/NwLUJ5dzLdOlB2VdGPm1VGfvu7bSBFdR1DO6DhzGV1MaZtbBgadrZNFe6wzIA8O4ucHdvabTZzm7XF2Vvf5Rrs5Bl4lxjM3lflPg8HuFmJAE9WiAfOXe9E8yLZJbQU2iel2OwcSg3VAr2aF/v/oQSRiSwU1z+72tPLQWSmsBg1ugULK+ZhiGPZg+aR8jasTy8WAti8bBkHnQOrqxqPQ5G5wMJDns9t3qbyg1go+OyBAtsDdJrDG1jGkoVpOgiFt/goow9Ak7OMMCTRej+xLDm+hfIXvJMKeFDVycbzDLCfnWJNIc/rU3LUdk5IAc26e31aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TluttUsQiv+y4K9IT3CC0GIibz5P9dCSsAm48iQFZXM=;
 b=Z85QlDV87kaMGMW/wgPolW5J3ZeSM+GeZKG7Foi/kyVcj3SzCAirSvl/dgG8BLKxJppzpNkxYRs5siAbSYEdHmrTNTxTnjPyhzNJXFqD6cQMRXj5/+6VE++t7fRmHYmtvyUvcSFg3bS5jPQ5k7ejVb/2CtmKl8RCaT6XQ0jUHDsMm7YHprkJEGDkrsKwWn39iRjThYnu8K290BUswP5wt6GGKMK2yqD4RlWAOx463xMl4UBh1L0cxFeh6ANw6X3oY3PwSL7J7hgAcHp4hRzr1b6oGoZDW97d8c1fNrfTqZg0fkS3xp4so73V3wCgjao0ANKG0p6aE+cmcccbxUHgvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 16:49:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 16:49:16 +0000
Date: Wed, 13 May 2026 18:49:07 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agSrg_UpQ5fdQ_OL@gpd4>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
 <agSpf9QRx4zqhZxx@cachyos>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSpf9QRx4zqhZxx@cachyos>
X-ClientProxiedBy: MI2PEPF00000B7F.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::413) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 130c1567-dd8e-4b9c-45ae-08deb10f9184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9PC8uaZ4kkkoJCFyY2i9QrSUCzcsj/RLXC/BIyFjcQm2b86WeEEm6806wpYLMLTEDwp9GOpdnTk9xdKtMeke4TCzw/ETxEWzTfyi5FZbKcxuoOcgUGNQTKOxfwYZJsabSczUfadn31+Bt09DYoKI7+p2B7ZXXONgDuiMfJexI6pRDfEtE0ZtWUl0kqK7OwVpyqyOlshxXh8zVpxFG/IuG96gAjHJe1CwtCeXM6jZNRIwGlrmASNCwAfdAFXr8UBPLoXVjsOLfhGb5fY8K8CVKRbVw4Hl5kTaLaIYkHKvYgwRjtQSePH8HUf5PBbNPZYYJV7t8P4eHCA4VuC6EymK43NcOO7wwNwoHiMf0IpjktcLYy1K+woRrDB60MMIFjVm3NspjElf/JM6VQb2T17QpzKaq1RHRIK/JZ8T0KdkUJytyTrj+8Qhs8gnDudAm/fh+ubuGFSV5c1es84YqMsVtkGy1fnYJFN86TE2lZGhfnenoMAnhgkDtm3wVAvn3Feh7oYtQlARGbPTrYipodKEQ9B6WQSgOHO4inQGAq1yyAOKjtFBIvo6RPEPojBFvNx9w1DF0luh9cHDhlSX7cvG8n6vby65jYEpAESSBOY9+d8exHg8DJVGC6w2sUbOHyUIkIXHIb2HFvjIcM3SZGmqY4CrBA8bJYLS5cP23swPQ4KgVyQnYVSs6411Sq4ELlVA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?xlZOgqnkUxUGctDpd2HPJhiaE7gUezLibThpvHx0au19dNC15EXSe0rKww?=
 =?iso-8859-1?Q?CIiMOAHknnpOmblWikSbBawAcmDi/MutSBb0uEsjvoQVU5ur+oMIH6UScn?=
 =?iso-8859-1?Q?pQS45TrLWetdwn9D6/Itak+A7BvALPYiEmriJOkPzAibzpqSafMcaJ1ist?=
 =?iso-8859-1?Q?JmQ7uEy87FrhnIlIXU2vQN2ZXkRfWI8oQQ4icebPkwme25j8Ty23sqtkxe?=
 =?iso-8859-1?Q?9vCSM2+yU+W65rMxS1z4hdBIooCZCt/FP+65ei4wqturig2OquU0IE3JmF?=
 =?iso-8859-1?Q?C7KjcRwUEY2qlKBwzIsA3dd6Bn1w9ycB8P4E4QaPsj71aFYpuFOQQcdB1+?=
 =?iso-8859-1?Q?bvvj9NF/QI4O9PXVUG6F/0rN89NV87E3murIF4XOfEwlgMMzQxiSA9eyKI?=
 =?iso-8859-1?Q?OTOwQYXuUEo2za84kXs29ixFxZNT4kYhoPRdUQFi/c4HxzLfJD490QyRGr?=
 =?iso-8859-1?Q?7MhKs/r1GYiG/NVUW4QTC/iYUZj284Q6tSV4z61dEq1not+w3oGSz/1iTb?=
 =?iso-8859-1?Q?7RIkyJ5PYFXsLws4J6iMjD+RKFBT65VdRMk0kFbwqIzPFVHHABRbXnB45P?=
 =?iso-8859-1?Q?WhkT1ALlfI43v8XbVAtadui3e9CpFuFmdgMhZZXQORwwweRe8pxZ9GjSIT?=
 =?iso-8859-1?Q?5JmaeDsParc2SgFaR3KncgKLDlaJYKXaPPLF7huEa/p8tgXORhTHlwiREt?=
 =?iso-8859-1?Q?xj61rmW/GEgXC1ctcyMYfWmJe6wNu/h0SJOIYu3JQdJTX79FgBKjyEO2U7?=
 =?iso-8859-1?Q?/o+aQpactcvGgR5xeLXK/sfJ/XVZQ84NNszVtsWnTWTCONF/okcT+v3Ly8?=
 =?iso-8859-1?Q?b+HlJxKsjQjvL1J8kvjGvjn/302x9gEIE0+Am/OX/eVyPxKGkuaAr+f7W5?=
 =?iso-8859-1?Q?4OMeeBWCVvNs30xtej17Zh/SYWys9v5YLQQJj8e7k7ioAWYu9/iOUwnCDc?=
 =?iso-8859-1?Q?uCU/CIpiFkFAFqCxG7ibBMxuFtSz+ZFWF+rarLdpLOqvCLDC6NzASNFP8p?=
 =?iso-8859-1?Q?mrEXIxrdCRxf7F/eWv1dDkZBCK2p/sp/ymamrCJCcqCynHCHDfND2iK2+j?=
 =?iso-8859-1?Q?Ec46HouAtN9DlEcour81JugT5jucX3480bTjRP3fgih4IH0gJ4TncjkOQd?=
 =?iso-8859-1?Q?ab7IgURlmozb97XtVErA5IVsOs59KIpLIzRcBRLbcoIiogSHI0faBnFu3i?=
 =?iso-8859-1?Q?RK0s3Trj7oFDa5UXD6+mG36sThIb5IWj3WRRWlYFFNw/+FL2YI/t6OT0c3?=
 =?iso-8859-1?Q?FYe29rJU93/zgryaHi9Et0ZbDKo4egBFDT+Xkmx6sTk+WvZEi7iqGA6vJW?=
 =?iso-8859-1?Q?ysz+h8kMNeyTyZJCzkfZRRxycHG7lqUXi2OO+3ybdfbYpL1iPMiQtSxvjS?=
 =?iso-8859-1?Q?kw27vJAJSrWh5B3uwHx/tqiF/ijLbuXNxcpc51hEZBrWwkazjdbTLpHZVN?=
 =?iso-8859-1?Q?L5SHLl0g+h9flzW7vucg7x7hU8lZs2dwklkPgfAaIss5D22gNbeMZ9WahL?=
 =?iso-8859-1?Q?Xv/Kz5R1ZofRvq+qBSPufJTOztq7tZceGyjPIsqWIaW+K83nIvmRNZA60r?=
 =?iso-8859-1?Q?JA4NGk5wVxnV4CCG3MZYjZ8RYzeuq8MTr2wwkYgaggha014hDCgRDEhveO?=
 =?iso-8859-1?Q?FJezs0BIwBbXT+zG1Wy5tFM/6GH20jEF7MFbmOTueDSm175qUKknuFETNY?=
 =?iso-8859-1?Q?kJ+DXkv+o9KMmu6B7aVq6sN+T7OFaMVFIyo915uAyjt3/Nm19h0Bk5Uu+q?=
 =?iso-8859-1?Q?cjK/SDDp+kwzDmvh+0Eiu41BOqwMYHPZklGnHA3wfFOeTjtNJoCrD+R0Wv?=
 =?iso-8859-1?Q?JyhoAmU7KQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130c1567-dd8e-4b9c-45ae-08deb10f9184
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 16:49:15.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoFWkyeLGVRZmzqqy2oAo75WeDoviqeyveoIGKHXph23vPn6GTI2fmPpTBms5TxzyeOFfwMgjoMgQNK+qesjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

On Wed, May 13, 2026 at 06:41:26PM +0200, Samuele Mariotti wrote:
...
> Thanks for the suggestion. I agree with adding cpu_relax() and the
> retry limit to preserve the original WARN_ON_ONCE() as a safety net
> for real bugs.
> 
> Given the improvements to efficiency, I would also improve the non-atomic
> read of p->scx.flags by using READ_ONCE(), preventing the compiler from
> caching the value across retries and ensuring each iteration observes the
> latest value written by the concurrent finish_dispatch(). I would also
> lower the retry limit from 128 to 4, since the maximum number of retries
> observed empirically is 1, so 4 gives a reasonable safety margin without
> spinning unnecessarily long. 
> 
> Something like this: 
> 
> if (!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY) &&
>      !WARN_ON_ONCE(retries++ >= 4)) {
>          cpu_relax();
>          goto retry;
> }
> 
> Let me know if this looks good to you.

Yeah, that sounds reasonable to me.

Thanks,
-Andrea
