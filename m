Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61F274B55
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614962; cv=fail; b=jnim+0Wpa5/yhbCrlBiGn5gEEaPH3d47iibFj8HNYMkos23NelsH/g06VCgT2DaW4Q8hbeVEKkX+zKnc62KfkTg0F55HSVsum40JTt5ndLsbIt5BRSb011bpS2tJoRK681+DC6c4o1k9w8AvLco3GlVKdm0OcIRsq0pZ/PycF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614962; c=relaxed/simple;
	bh=JbDMEb5AkKfQmdhcQkhRMPA+68olUHbtV9UXvxT2b7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pfYZm2TWtY4MiLEN+4A6BKrOlSxjWsHA0R51tWYJDfg3TbfWDzFNDL2aICE+q0UbgjTmVZ8icu2xEaimRDLzhBp3GiZ2F6iTmKFaPYjER6QFcGVFrNUham+vuDyNEyg/pwl6qKToHKZRPh25aQGVzZASIMu/rL7dXdfksaXuBOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjihJq3U; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjihJq3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHbxcgdFsCIMrn1k1Me0sabBIu0lQocbK56p3JjeOweDYLMo8kiQV+b8memLeCVBOkIvlY41udngzUbxKaWG8O9YuFaPB1PSxHezlqknAxsi7JUUA+K91i5uefleM8N/cm0HTPeTp3SgVz1WbMUEDTiymR1WHe+9e234j6lyTfhDR9N42RFUwmLl7+plATRgR31+MF2ptCvYLrc0jyyU4snJeLNQgJrCAhbhdCi2dloFBjm5HAPkigB9llgtDgqAvCZjDMFoJ7ri/rseE/Ye7xX0ng1v0ket+K661JpYW3d+oj9lJ4VVu7j65bfwDqhpUDB9gzqeEEwZ8dwWymzsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNiKDkMphLRxGfzmBKoktSadjGIMKgT2rUmbHtFY4y4=;
 b=kICzqD24P+O1pvk+ktZ609cfNcu3gXRDzSBulIYzMpFoQ4+DW6SzUS68IsG3nrvnsbVaQRFQImAQwnZTMz3s/TGj7zd72VIWF+5uYdRwPKzDPCT9PrjeECTzzFYZm58TaySKc1FF75gW90uFXzB8kiNbhbs7NgVcpn22ceUKSraRsEc8w7TmMrTQhpvpMOHerKc/0hkSEGOFKf0LOTznpZo3rs7GQibyfEef8t6BqrNhtDT+3DwdW5vpBDv/4+ozwVsGrPFCJzWGOIWcnifShCNPwPl2vsHhIppHFpXvVpGg7egldqkw7p+kcGs80nPiBT5xEIi27Aj1Ivu5eF02iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNiKDkMphLRxGfzmBKoktSadjGIMKgT2rUmbHtFY4y4=;
 b=jjihJq3U8lf0Pr8B7qGMBjpCGYGAdgACR5v93ceEiI16z9crpp/LwBRwoqkB5vCtSHDysVXTbZ9uY5hSxhNyio4/PNROYZjdg5pKPlhsaw/yh48uoSJ/f9k46jrN3UQp2ljZTHwmbf774eXGEBN8c2Pt7/HM0xp06/fFLaBVlj0R0a4/Obn9GttPWdPKJpZVz81Lp0NZrzz5OjdEcocoN5Lj7w7hz4tRKXeLuR69kcc4+xUec0VcqYfj1r55YteVFlpBVAii5vWLfDzQVmYSZHVv0dIBqe50rvD54UNC71l/zxuusXfOdv3Jb3zecQongHcd+lgP0FaR/L//FkNmRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:09:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:09:19 +0000
Date: Tue, 23 Sep 2025 10:09:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 6/7] sched_ext: Make qmap dump operation non-destructive
Message-ID: <aNJVqrlshhD7mAla@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-6-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd32d62-0edb-49a7-a27c-08ddfa787ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Em1VbJ0UXG3e4tx6Pkl97moLRyYEg1auLzJSir7gMdUE4kU9ejnkPnrqo0Zx?=
 =?us-ascii?Q?k24ROIS2ckNPDSUvRiDT/mOQXvHYPgoke3QKfexyM4zTpYT8aRbWP8FgGFny?=
 =?us-ascii?Q?jqC+Py9jBzG78PIDVGh0gsnArkmQR6VNZyIYumm8qvnm0yEUVc1TvW2d1rLS?=
 =?us-ascii?Q?IMNg4eG6Y/L7xhnyq5S/dJO2P7JGoRazFK1MN/NFuj7MW+jlB0RzDeSEClMR?=
 =?us-ascii?Q?qZQBJEV/0QUn8Zp3GksuOGKupV/nKzokiODM/LEJA9e7HesfmHiZkRIIew6b?=
 =?us-ascii?Q?/WSsMN09o/Pf/dzbpuTscAalRtGmWWEuwhboReUUZNfHcQwAFMePobx1werm?=
 =?us-ascii?Q?T+j/uhdV1LFiEgZ1uK7C/iBYBx/l8K/A6H8s9pXbPJ3DmzJjk/DO7V0TQuov?=
 =?us-ascii?Q?rcHVUlYpPGQyDvFJzn3/1ivJP71BgNlI2In22ceA7XBzzLqpo1rSo0WBUx7G?=
 =?us-ascii?Q?9tm+tD1eVfdFmRN6/1eZfLi6KR1cbUnHlAtH0h7q01eRvW1CDh07h4GxPByS?=
 =?us-ascii?Q?xvb9jYTliM+axLH79XKHW/xQpbsafJ0KSy0gFS6p24pP10wb917+Ah/+WnNv?=
 =?us-ascii?Q?ji5eKLj35qYCGzaMn3HvvtDMU30cXtDuCLFRNNq/GRD4tlNxvbaRl1eZ5NPs?=
 =?us-ascii?Q?hTcDLITpIy724PfW8y90P/IRw93+bXm2ZZj9/QTJn483jPaG91wzu/OsJoCn?=
 =?us-ascii?Q?f93tTDDtDUDp2mB16Dt31ueKGdNJTU/q2XQejP9Mr5xFWSYjeUMQtuDkokIR?=
 =?us-ascii?Q?icss+vUkTGoYMP87kwPhtiBkXU5sn+BPXMuQdmuLUFd5Y0SKw/H4eihrfuiF?=
 =?us-ascii?Q?tQa2k0MYObfuKsRUIDb+gZhQJW5wnezIwt2wRrSAT5b9WunyN1Gf0GNHEdRq?=
 =?us-ascii?Q?NBGjmPFh/nRskL0G2THVx9vi+9THjEMP4b1gQvmfP0IJyEp2pT1zUqWGaOT1?=
 =?us-ascii?Q?u+3sQvSqNVel7FKZvFuKXDPAv60OAepoXP9ZCKQX+XPdliOOdXNTv7+A6Fjy?=
 =?us-ascii?Q?7ju39r69SJDWRZUVX0+bXgVls1JUFPB9G4WuYmVAiS70z/MrzT3/+UuPVchf?=
 =?us-ascii?Q?FfHzhOjn5jUEw5O3n7Z5tAZ5TD6AOi/zll7U1T64f7IFEnpMaBL1Z4HheT8B?=
 =?us-ascii?Q?Gw0Q+waqwby95hMhiAAmp0sc+RSh9Fbu5ajV/xnAMsdqrR43cahWy5zFDvCw?=
 =?us-ascii?Q?ozJo+MG7OWPBBVn2UVDNTxVY+QYUE1Ccsc81R1pTIyYZnY4djQ08BdwNUZ3v?=
 =?us-ascii?Q?W/Ti/tJ1++Jt/3xA8aRB7t5NwaAZezpjHGTP4dMHICXvetKkbg3CX116nrJf?=
 =?us-ascii?Q?vgVDSG/MGaLbtFixEOGXJH4NpZbncmyXUhONGaWBtP2tIthIZKUE7J+DU0aJ?=
 =?us-ascii?Q?yOoLjLN2S/WuKCvVbaZr9wclzdIm083u0yn1KEEkZri7MDNM6OLq1KGwtr32?=
 =?us-ascii?Q?RRHl6tB/7eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIvuv40cNgjVKrwuDSQ84s0cybIY/9IrJIlreJeyCjoh5MfZH4qz1OyHKLbj?=
 =?us-ascii?Q?DY9u7O9umcZfDCZBFOl5MhKOV2MyR0HQpkcl5ofm3Jk8AuUnTyovxMTPu1ru?=
 =?us-ascii?Q?xeQ0PsFaZIJ3Ukygc1jg6Vi5gq0/er+15JjbGYAD/A7coiKog12OMVJwAXaK?=
 =?us-ascii?Q?S5W5ksSHblpY8jNQmGVueq9YQjLErmUmW2GFHDawRBRlR9LVcT6FaeA0EbT6?=
 =?us-ascii?Q?QZdM6LhYy0kU9iE6rfSfGGrKEHS2KSKyBhA/FrNsfzm6bi97CDwNU5IQ3eli?=
 =?us-ascii?Q?1ZcADFD3mMm5hkPsKpzXAHLFEYmDmUIBmqqP82/Ap2sh9M2UEODC0V9NsT7H?=
 =?us-ascii?Q?W3CPwQ8j3mvtFLR3df8MorGT4bVm1vG7rGUQJsDLwKRAcxH8pHJ/kfIqNHc3?=
 =?us-ascii?Q?3RMYWtBOYZ4gKXxa1x0CtzMHQmckSz7vbER1HfghubHNW1l0KgRiCiWYt3ro?=
 =?us-ascii?Q?MI93ycreA+b+uN9CewXleaGlGuQnKW6aOESqaCVWG34yTJ7Sl3HQ0Yf9CzY5?=
 =?us-ascii?Q?nTIUlzSJVIdvEL9RSs5XKwY6mmtiTztpQZgps6F4DHOrTzz/tjUJgD+43x4f?=
 =?us-ascii?Q?XjMoiq6NKE0JSnmk+GRZ+0eCFgCQ2TJxs8AkFxx5fVZ2Ex2AlnUxaUXXqOc9?=
 =?us-ascii?Q?4Mdk09Cmw9RV1Tzwf3l2gBzasZC3p5EyEw4oR+yA6tswSq+bdHwMWrrEiSny?=
 =?us-ascii?Q?o1cY/L+UGXAW2LTC2/n5wWQnsh6Vt+Ce8dm8wxssOvPl4YccqEcdpLE+Q7tj?=
 =?us-ascii?Q?Mtzzq+1CNbebKXx4eTrAIXTcD+UyBNsLhCi/1/wGHLkpXDTUBPWRuUEwQCyN?=
 =?us-ascii?Q?97ra0qaGhp/7AO/r1eRsYsV7aFzR12qKXl4AmsW6vtAWXsMgKWyrMCvrSsTN?=
 =?us-ascii?Q?KskAJzRMAVTNv4r6zPFRTvtGLWVngGGD/7HvbguP4V9dimagegx7pkwoh56U?=
 =?us-ascii?Q?Z49Hh2PbU/skxYaB8R03cf5QmyKmVFmaSrgKxnNrHTt52xoUwh8dPOU5a5qv?=
 =?us-ascii?Q?4sRB+Yc1g42S0J84Ljgpy3LYLTWKrwfTUthfNhRcQDb1o2c8AHXZzf6KCXKQ?=
 =?us-ascii?Q?367chBZ8sXz8sBRrLIQrsOl6oYG0A7ezDXp3qz+32qLi0scmzgiYj2T7VTMC?=
 =?us-ascii?Q?5QhmXD43kktCfNnzztwIv/XX6Ldjp8a9VhTUSG0+AzmGv7pKw8LTBMFRMXHX?=
 =?us-ascii?Q?sXKCvadodCqU/VewqyJqukMfOPKxJsbWYyPdJuLU/oQA6vX/GbiwBz/9LAi8?=
 =?us-ascii?Q?RkgdrxnXENs8+MNu/PMtwS+9bb8oA1tQWE6qNcgboVrU9wpJqugyZnCx6IMm?=
 =?us-ascii?Q?5PhjO9hD7qxGbf6tnSd4RQF1FwgRDUk2dvQScHpGttSxdtDCZ5q3ouKlG+n0?=
 =?us-ascii?Q?NUbUFwGtzRClP45f6VAGLDUcTgET/BFi9BGzWJ+Y82kC0yPg2OY0NRpnkDzZ?=
 =?us-ascii?Q?ir/42G43QQJRlm3Nyb+47TREelc4JbFQeqKX03ZEw9NVvVPoDu7AH8IZaTXt?=
 =?us-ascii?Q?GMjEfWIZumvsBYwB0pPYVsYcgVSou6P+E4nBcOHOplKpI4tWLlLR5VjNRT3B?=
 =?us-ascii?Q?sEdsxcKQD0dkK4Hx2WLqxvcKHvWlDdMy5+cRy8D2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd32d62-0edb-49a7-a27c-08ddfa787ef1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:09:19.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0rQpurFEXj/VCZVpU8zh977YVqHhQbOMi3KNWuTwIpsGOyLo1bVBmJIuvuYgmvucesBq4YDvIsRUyoYSBQ/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

On Sun, Sep 21, 2025 at 03:32:45PM -1000, Tejun Heo wrote:
> The qmap dump operation was destructively consuming queue entries while
> displaying them. As dump can be triggered anytime, this can easily lead to
> stalls. Add a temporary dump_store queue and modify the dump logic to pop
> entries, display them, and then restore them back to the original queue.
> This allows dump operations to be performed without affecting the
> scheduler's queue state.
> 
> Note that if racing against new enqueues during dump, ordering can get
> mixed up, but this is acceptable for debugging purposes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 69d877501cb7..cd50a94326e3 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -56,7 +56,8 @@ struct qmap {
>    queue1 SEC(".maps"),
>    queue2 SEC(".maps"),
>    queue3 SEC(".maps"),
> -  queue4 SEC(".maps");
> +  queue4 SEC(".maps"),
> +  dump_store SEC(".maps");
>  
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> @@ -578,11 +579,26 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
>  			return;
>  
>  		scx_bpf_dump("QMAP FIFO[%d]:", i);
> +
> +		/*
> +		 * Dump can be invoked anytime and there is no way to iterate in
> +		 * a non-destructive way. Pop and store in dump_store and then
> +		 * restore afterwards. If racing against new enqueues, ordering
> +		 * can get mixed up.
> +		 */
>  		bpf_repeat(4096) {
>  			if (bpf_map_pop_elem(fifo, &pid))
>  				break;
> +			bpf_map_push_elem(&dump_store, &pid, 0);
>  			scx_bpf_dump(" %d", pid);
>  		}
> +
> +		bpf_repeat(4096) {
> +			if (bpf_map_pop_elem(&dump_store, &pid))
> +				break;
> +			bpf_map_push_elem(fifo, &pid, 0);
> +		}
> +
>  		scx_bpf_dump("\n");
>  	}
>  }
> -- 
> 2.51.0
> 
