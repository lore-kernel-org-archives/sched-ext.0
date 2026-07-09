Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBF305E19
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629482; cv=fail; b=twa53rhtFYYFhP8At1PjhYqolkiMTqbIRk36zL+SfX2MVDKQFhLttkADJrjjPqzdUqFlaBpuwlQ9g2Mg3mi+AmcK09y2AlHAPpgzPN3girls42IxlbdrNRxsVq7i7ndLohccSl36I6AUVUX5RQzpDhcSeQxXwhKQg2x9heKx6Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629482; c=relaxed/simple;
	bh=fAnlGg3jIZNpaqa9djoouItbVMsIgx8jr4pNWdTFPko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rhH8gjQBNFFTB/unMuv2Koyym5MUnmFOifV8dDkY7854Wx0XQMZd47oMFTSs85LLStgH/u+FSUPuw/Er9KV3p/leQdncYFKhUBKDGscQs2/eqXv6rhwMlOes5ekAsyI8/OU0o3axVnO8FWky7F7YzNWjFRCjoNK2pqOifsXFxt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKlLW+d6; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKlLW+d6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqnULbStjFk3ZdKCPUgzYY/VQs4yAFrc450Sgk8k77tXFs+v2IaAGoVRUg8cp3ld9D4PrAyIwS4ZGCrA276LbzwZgNBLbzDSB+x3OmfGTu6frSTnqdRiRPPjPO1DWIxxs1VLU8BcUdr4Po9JEnQFOohiH/sJFKf+kCXE2L+Mdnuh+TTNIDeGm42dk0nWZZQqkuMyXadWyyNUK/TkJecgFmQIk2twv+mCQyBhtxHw3g1YQwJrq5bSRR4JFY8xm+8AESGPYKPI5RwgbdJhRPvOxQTK/CohxrhYKVEUO1eZ1fVqHJ0R68lXs3DzpDM04bZp4V7elStUrq8JhGiVx77pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rbuYTz/seuhxrLqwdKy1mOC0e76NR9b65qD/KczFyM=;
 b=dO98+I1rvLLguK1zZ9XX0ctjpFDqX8kkDgacnLVAVuYykFeLkn3ZoyIY85oxUkR2sWykoLvBF54YvE0zYuA52dgtCH26Xual76fDaF6O8xpBTPA1rG90sHSLUNbKQlV2XNL6EiiIFH7vWVhpADUGfKezA9eSxzVwMl2LaHzuJwtNRjDY8TGltnkY8kVGDhaDUHenmCf+7dtCIygCpRj4YD1NLZxXXqsXZ6UzrODbW4xspZpqIhd+gcUR1CUBXB9n6lNuoGjwPbDGRK9vQyywLveMVEHd7oYhlHAOlUBM8JF67bdj8GNSDlFahG+qyz6vxDomMypJOaKr/RN65zO1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rbuYTz/seuhxrLqwdKy1mOC0e76NR9b65qD/KczFyM=;
 b=UKlLW+d65k6baeUA9kvc0RH2ZHSRjkwxUaHnJK7UINKgINjnkmdp2Y84abJreuyJdFmYALWUFi8pyuTq/QSaQf8Aa2Tz59i1mHbDQ/qOG19UyGHK6ncHtGZiGu6+WVyur0Jd+bTwCqN7O4bbzaXnvP7wrnq5wHdK9bIxqVZbGMqUoe8fgGGGSqDVdJAjY7HIx5Q7NkRuCNAZK7iEJWl7RP4jJV9iV7f2BhIfnpvjfTVoAlwBYS9g5gnRc0x2up7HPSCwyS2XBYt9pwAbHkUe9E5abffXWjAAOH86zaSnfRUFfWkIrP4eu4k21qJLXpzJurafshl7aOxSMj+o6o5tQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:37:55 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:37:54 +0000
Date: Thu, 9 Jul 2026 22:37:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 01/40] sched_ext: Record an error on
 errno-only sub-enable failure
Message-ID: <alAGml78WoUn-p5e@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f06033e-43d1-4d97-ffcc-08deddf9f42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LR+07CDjWxTEhlCG9rjSFkTbMWoElWQZvFh2bbY1J0Wn4N85hTjVfOiyw4S333BRQNPdA81qEGEnnTng79MOYQfzMpjWIVzeXXh53sRewR0LZ0OLkciWhgEdpV9dotD6KArhf3d5qhAX7aqJgjGJyfTQQU4U2Rse6uLoIW0fEbg9Vt0mDSyeX8p7Ka57oN1E7oYqQeCa92u1nH5EWR6C77G7/dWRn83ndLjmHSFMJh36lUcYAsVI5263RGlkXDnpADJTkoeuLzdeMtRONcnV4LnN5nEO20CDh971CiIvsmzolnP33D/CgqokM6OehBN2iDdY/J94fiRf0ClFl+31YOxSCRb4fEXUdUImQLNUg9MdDnTLKA8QpCUxP3WEOaq/YyzxxssfdUJ+9vR4H4mjAK2cmLvmSjU4jfTvyCbgJZl8gehdKfqj7WjmJ6fehHWoarvgjfYw3zi1FVMfLVR4LtFPkB2VVExhbDnYDx4bts2wqbcL+/b55C8CkMnMJC2DWCu8qGTbaaNr928dVi5mWqcVhoqzNPuoHObxDj+qYSGQBO/ZpoehSHQLepclr+NBSoEvENznwgR5sBP/wc+7rdmA02HAR12YOfj1ECI5R+BgpQvqDecpX60UomGMx8V6pfOrWZ6O9YGmI9Zntz4h/IEk5TDC4l+f9+3dmqi1XVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQkDAs1r582aukvj9yZEjaDhF9OTrSYkEvN7gb6+JxtSLnYZ4wXMuSscdIna?=
 =?us-ascii?Q?lXpC0ksQodTD87g8Bm22sdigyqbEWqprk5XH/YBEtmrK/2nutZE58tPpczHX?=
 =?us-ascii?Q?nwHj3HLURZXgqozBx+t8OUwX2cWWNss2I4FFyLXsiKee26/K4OUGwbBSp9nl?=
 =?us-ascii?Q?o94wFfVBUXbggzg3FJxTj1w6a6WwKXJuSSiUeK44kEB3BHMylcakVdgboXSG?=
 =?us-ascii?Q?ELOGjsWeURcRjHgrDE7cI1IFVO/c01lzwzE1iQ+sq/6g8RrPSlTyQqiYg60d?=
 =?us-ascii?Q?XkEiTu1sj/S5+tdZuGU2FyXB/qK6Q293Y3dsJX646CFBVtbdVc+7ulm1gzWF?=
 =?us-ascii?Q?5W38ok+ZLFhHwoU5LLAmnHAWrI0yJgAMPBWWZ0csRFd0lA1l7vAa/MmGzvT5?=
 =?us-ascii?Q?KA2Dx14GIC1qTFi618rqJ7yX404dZiRd0WhwLcbG5PVT3ioSJBsI97ozUvP4?=
 =?us-ascii?Q?WB8eAQNys1o7Bo4odncWOGIKgvywySC1q34pkTrvMUbOrktlGGtSi3MuxOYt?=
 =?us-ascii?Q?0BcKnYd395xRnm1aa2zZDePzxtygiPsiCOhwlG2QQqF+KuFFviGyx2eKNz+a?=
 =?us-ascii?Q?QB2uYY9C8xhh2erO9ziSaMhlGf7ma5X08Ba/7ZAgxo6013RvRAIsVmljMB/r?=
 =?us-ascii?Q?Ydf1fegbzbSgXkoy1e1d0qDxARswYg/WQ/g6sqvtZhxOX2n+nnFrYtcYRkUg?=
 =?us-ascii?Q?QlASEVdlOREIOgA8ebxRY0pbbcGvynk5l7Iw2g8Eu/TGilmS8KWVEHXaHPbi?=
 =?us-ascii?Q?aKt2F7Fr0rFIMxa0bHeOSnjM+/ASVO4WCT/z1kSD5H5AzdhNSO9M0D6AuqOj?=
 =?us-ascii?Q?DiNu8I9pa/TyP/RWLiVBgD9pTxxW1qOPTRC2JPK8gTkY4D2HZX5Ij5mRxiu9?=
 =?us-ascii?Q?SykEJ/DuEuTtxGvKRhjw49ed5vkgvVgj+RZN8eMBPKE6P3Tf/C2w40rNAvBp?=
 =?us-ascii?Q?bdckUEB05QpriG0MMS5nSuGbJZhAI+VJlZBwFcQASuEhba7r4whwO+zpM7xM?=
 =?us-ascii?Q?daDc8zXDlHmwTvubNrJwa/Ixo6Ubm4zdvaeOezF/N5vlYtV8hQv1YfT1gFZG?=
 =?us-ascii?Q?HmMObIO1OnO8HOOYOiQR2ZDrpXQUlw3mHE7v0u1eidY2ppykk41v2KRUSY6S?=
 =?us-ascii?Q?qOMme8VrBTMFqiUrSFH5Y8e4NJo3LUOzk2k/QpwhrZoRgnuNYLBNPgNtlpKy?=
 =?us-ascii?Q?aeCsGpFgjXpMazmg0ZBjNvT70vlcKbyekdSN5HTJ4dRwT+S7yOTrbWDOtF/v?=
 =?us-ascii?Q?uInfdl4MtSwxxRFn0ZsqTPVm3mP5RN9EK3xUa34hUN+7kyq0a6/ojo/kVKZb?=
 =?us-ascii?Q?7kyGILo6brVeArag7IvbaGxL7VwuVxlgdzS5PsOGXE6T5XO0uiOrEhHAGXQ/?=
 =?us-ascii?Q?PeZA++SKPfifYJH2BYVx8yMH0YKCI0ghnU96OeEh126poNaOFP4ogvmvT28p?=
 =?us-ascii?Q?N0qibO+vMbFSMIaTTwre9TKiJhErx1OPsGRjKtR98LSBgHGAWgvaCHAt03rM?=
 =?us-ascii?Q?HycL7Fsg11AHbxv7Gv3Xli/N/JNYXAPQdTHouDRIoblF/Pd9CodpWzVSjPMi?=
 =?us-ascii?Q?63jn5NNY/Gc5neSlrLdvKPlLHMVvTGvB9tBYGj7QNu0bI8uIIJPKAN43sr/g?=
 =?us-ascii?Q?7N2axy91qRI5rFYJPvOaZ6acfCFsHBf4NhVLQZjCRr22YcBEK37o+Z+3eMOV?=
 =?us-ascii?Q?0jA5SzXBJMMZ7v139YQv/yO1J9WcUmJIK4XC4f/QxOdwsaIYlOtZu9H/S0GJ?=
 =?us-ascii?Q?NTMB2Mkurg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f06033e-43d1-4d97-ffcc-08deddf9f42e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:37:54.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAPl0Rk4veY56x9BEZXDFVzDH+S4cdc4ef55IdZjiCQDMFOWrBu/ST+KFx6ebvIgauRQcD6vWfdGcDxtPn0dPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On Wed, Jul 08, 2026 at 11:23:50AM -1000, Tejun Heo wrote:
> scx_sub_enable_workfn() has several failure paths that only return an errno
> (e.g. -ENOMEM from an allocation) and jump to err_disable without calling
> scx_error(). scx_flush_disable_work() runs the disable, and thus ops.exit(),
> only when an error has been recorded, so an errno-only failure leaves the
> half-initialized sub-scheduler linked.
> 
> Record an error at the err_disable sink so every errno-only failure runs the
> disable path.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/sub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 050420427273..ce76ae141e0a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -570,6 +570,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	percpu_up_write(&scx_fork_rwsem);
>  err_disable:
>  	mutex_unlock(&scx_enable_mutex);
> +	/*
> +	 * Some enable failures only return an errno (e.g. -ENOMEM from an
> +	 * allocation) without calling scx_error(). Record it so
> +	 * scx_flush_disable_work() runs the disable and ops.exit() fires.
> +	 */
> +	scx_error(sch, "scx_sub_enable() failed (%d)", ret);
>  	scx_flush_disable_work(sch);
>  	cmd->ret = 0;
>  }
> -- 
> 2.54.0
> 
