Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604B46E01E
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655187; cv=fail; b=Mt/3T6geQaNBX+wR9FQGTPkfxDvEVDC8uPrqkhymfGmIlFDiAiqVbLdi5bfPaKcnRTo23de5/1YrbumtJClq8LUV314qtmmJQ4TJAmNpjugBb4jPsxLhyiHpmlavvmLDvA7y6FbX3PKFGOkfKGN38ey3AvfQnyTFqF6FRBV3mWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655187; c=relaxed/simple;
	bh=EFqruEJ4kJ53ijpRUV5TlNiTmVqEYfKEfmU1Su/WSac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QY2shg5q3Llz1R83wbOIAzItsBBOXrjT50rM7WfemS1N664ympQQJBA1Oy7QJOfGkIQhALra1XlciLylUu0Tue2BZVo4lYrGeJrA4bmaXdgvfMoeVE0gX4tZf4d7tK2+TRg+GdoOq840B6ce4vTRRj86mtY8WcN2SCIjQ9iPYBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCgwiDJG; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCgwiDJG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b41Xd4sf703/3D+brh35TOaqEsJXRi26rKxAk7E9Nn8/AeAbj2rzBeBla7fynn4qFN2NWNZ09hTyvjnYgMoiD0yYmwGn7xZ896zOpckRPWPbXpdgBtUW2p+h8WGYGflD+VcendArReZMJpxSELGmDYrUb5SPWp1kMv6tgHVAHGBZ0tZnQHxAfgyXIincsqritRz2Jxour/ZUGDSweOX+ZJ0UL/Qw5/BeXo9vAtoKkrb7M3cnlB6mzYXVKlw4M8+i1RBNtXs3ctz7Pfh8L4n+QpKmv7i3ZfZvDXs0xtsmT30bTLZm+5mtQ0gMUcBiUJSiB9z+3h7rafGYNV5O/Vllcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYSha/N+hhsjGHAqVaOw+fHRB5H3RV2AtDFjFsrQww=;
 b=Iwnd4rDtGiE55waZxLKrIrRemSVdsic6C1k9OXOaFMAVYsYzCQTx3ehsLsqjacVUBxvwrba7COBWh2pvTFNBFe+0wZn3zViHjqJsYW1/t89nPp7+r8Ow0hWUkPGSJszOs9b6dIyk+oe+Bu3x4if2r2a56WiIKONUkmGrvN1ra+JH74VEYlznzXK1TwFK98rItQhK3tfajzDyiRwDCLL1/VUkGroAetvVmoxHeJccHEe9fAwrI6S8wuvWN3Buo5BC3BCP7yQM/YnMlQZuC9WsUaS4ZuU99Jh36mA8o4FIuVT4iaECv0R2Yr7cOhfa7TPxjFtae/hzVCvX+NN+weA65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYSha/N+hhsjGHAqVaOw+fHRB5H3RV2AtDFjFsrQww=;
 b=XCgwiDJGzFaZnmiF922rd3zeDhDTIlcHDpNJ9kdhSZeNkvuqVsZ0zsDq6Hlnwu96hJOmlo+9lLrT0FMl1+wcQT1yOZR5GHL5dbIumfYJX4RLLU6BIKG1a7PgbEHz+4b32CV3ZI+wsD145yowXwYYP9/FuxreULg4UtXrMICRBONoLi2967GYp0Z/ZlRGLeihCnO4Psq4UpFdZFFOrJ8H0YHJvmhGr8nXy3l2Aecf5cMKRruFc51pjEb124H3jpM/OVijk1ft4p3zR1148dUcyvL2nN8K2F2Th8cqdQscVwes6HVvffrFO14C1hIGeZv5Bx7oVJMp94jUPJrB4m9i6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:33:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 17:32:58 +0000
Date: Tue, 21 Jul 2026 19:32:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cui Jian <cjian720@163.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix stale errno in scx_sub_enable_workfn()
Message-ID: <al-tQH99wT1RBfnd@gpd4>
References: <20260718201713.17890-1-cjian720@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718201713.17890-1-cjian720@163.com>
X-ClientProxiedBy: MI1PEPF000008C8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::436) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 76241a14-dbe3-4e75-1c93-08dee74e1af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8xkpp6M/NPFdqtdrrHMUGJKIV/ghH98B3gk5eNxt1U3UUiUfYNLmikv479ZgATRyYw1dH8HtjsKkH/osJNR4G0kq9ZSreCop0fZTIgAb6vdJM/nN/eDkyIRI+zFIm79Ez/yhi53aDHC2vv8WspAc9Eo7VicrCcrNOlwX/vgmlmj8lWHGDNz/peO0dTS3bN3wIO0pkZkPrZYYoDOG8dk2M5TEFdHnHJ4Piogjc1ldOFCQmAj41ENL9APORj8W+ClcnkfjAQzHBxK9nP0qyNXXmH/F8eLOA7i3ODBqZ3CUHdjL95AkEYdluzEYPVC7gu6zDI9/lSpv6Eqe9VKFlLmShF4gL9QMcMFe9rFCKUf9FZGwkbbTGvS5xC0BoFTGDx4uC8PhDl7DFi+DDKJz2xAz5k5lLoxUM2nq2TD5QbxBzWOevRZTgZD9f6F5pM9VOQslF0MGPWh7MYn4Hqnrh/zfP5hphXplwELfgx8cyNq/qS4ujC/gu1z4dkSLq4fQgR0nsnaj9KOaOKuUTX7et01zpRIMoEyYPcB9belfKQLmSFmZgBDpfnvSE4TQILM/OPihSbqOdClVVGe0SPA/1eJbFrLnbp98JnekzmHxmEQECxzkfJaoNngX1XD+ira5dLKiMemXAV2aJjiSHMNd+cLNqs9vElE4Yp24Ukr8b0GdAJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zOsTXb2BhMAS+uQ+8NSExXwBOusu6BjUSJM64FR5JcZnTf264vtNxcoLpaP?=
 =?us-ascii?Q?bSK5VV7iUFGSEa10zaNTJDHufjhAj2c048ToVniDoYtS8f1Mgcc4QniUqE2K?=
 =?us-ascii?Q?Z0lGEt+CvQrJ+4S8vOZeUpyn+oPnTyfI7kT22YuRSRy0nZIC+e+8M2fA+zXL?=
 =?us-ascii?Q?ca4Pb32mEI/M6atC4/Vl7zA4bmO0LZL/2bKh6QgiVSsrVMOUD09UVx/PyIO3?=
 =?us-ascii?Q?WmdBh5X47dHvxgCKWmcBdHSFo2Dbmfg3PtMFKJU/QsJZ62KeYdjIV8u/I3mO?=
 =?us-ascii?Q?ipctRKDVnw4vzuSOYhWqdHfEPxeEAHt/1Oyvx5h18Lze46W08G83vUVOtK5D?=
 =?us-ascii?Q?cZmdeukSGKVMhoJk3Gqph5rlUZhhjmvV1HI17zwy2Gh4+15JC7qSJH2Dp5nv?=
 =?us-ascii?Q?3Ar0Y3fj28n/YNm6Xj1wPUl7ncmkvJaqjZ+vXyJD615FPwZVvR1lSA/F5txW?=
 =?us-ascii?Q?WwCRjWwaLaajNDuunDQJae7M9x3m8I34gZJC+B76ZQcBJIhQXgRnYwrJ9GkE?=
 =?us-ascii?Q?j6baL1EzGpTwN9lPDhhtZwAo5VQ+7pl12BSfTxg75oPM35HyyNjmzilq4X6I?=
 =?us-ascii?Q?yooXWumsTJZ3286peminUsu8yuj3TR7BR2tzT3Yumyra+XvJJ219G+ycF3NZ?=
 =?us-ascii?Q?/3EgYutzvVcevymfu0anxVrxC62rGFEYVYsiZtXbrGki4cSHF8CsCL8l5Wir?=
 =?us-ascii?Q?9rZdyIir5lKD/OBBJmHoT1GqKy0HFMV6fIzhG/mU8CBM6pcZ3C4m7LL9S0Wo?=
 =?us-ascii?Q?t/hBXHwOmTkjtgsJkLtmMn8B77EwQkZ5uzwRRBgiBY78BfuK16UELQCRavR0?=
 =?us-ascii?Q?czd6+pt/xlvGG9HJ14pD3yFjNQPwXgMKS/WXtuMnoCZnIqjMWQB13K79fUgI?=
 =?us-ascii?Q?PmBCuYmnjFsI4uvxj1TvPBPvAF2gLx9MXRiznGL1Qse9T12NAs+HgR+VwiLt?=
 =?us-ascii?Q?J/q9J0mXE85/dF+8P9yE/cjasPcAVALJLVX3xrlxscOO+VoK6ssbsNwvVMLc?=
 =?us-ascii?Q?K98vzX2SYbvDuEI9QXD/DVWd9J1jc8GiftStCEWTjAK42zOUPMudwzowPMSo?=
 =?us-ascii?Q?2SWbIUe0B/w4igqmRaDJkeUfyAr4O/9APp9v0zz1XNPaR5Px/xxUDZPDM4O8?=
 =?us-ascii?Q?ilBc+M7btNzoXpkmoRn9lZdDcZ4JV1NPtySnNITY42ZlNFRX1jtwFxiip3pG?=
 =?us-ascii?Q?jZ5BEvySIzynftXWIzgb2SuUpPBN7W6KnMA6aO5x3+ffUX0bSoY1+MHhS8Jz?=
 =?us-ascii?Q?vf/h8yhS21UI+4Bkls/CgsnmFlBt7SqQoKhuS/oII8RCTngj4VgWEpYJeRF1?=
 =?us-ascii?Q?RRajQMFZGp2mp5jzsfkx+5rpIelcWe1jsRo2L4/Gce/yzVf8eSeS/6U9iXrf?=
 =?us-ascii?Q?L2lkKSRBuk0Jrd5fSHgXGsVNCfkct348raOCkUidSSgc0nH2+ksLUpHEXUMn?=
 =?us-ascii?Q?oJ2n5i/KavehFYM5JYfPZGGWAXZjlJlpAsLcrr7ifs+IjOLZ2iRJ84jzLhQ+?=
 =?us-ascii?Q?FuJEAewC1nT4rvWmltc4STZ+fmftbWfu6s7fLXRrfPKFoXaJlMneHp5DalnB?=
 =?us-ascii?Q?1mDeLSJmCtnbBZ9g50ij75y1nfmuJ9OEywpXfYB1AWaPBYyll7l/0Aw0DAc/?=
 =?us-ascii?Q?Bnm6MgRWCUdkO/Ti20HEBu7Vo9kDwQwLc5hjmJvErAn/WBHc7g3uf82UVkha?=
 =?us-ascii?Q?qsVl6E7Ci5p9o7xdhbB5j+nkQVIwTZCDdJ7Lv7XcNheSuZDRNFO8IVR5VPBu?=
 =?us-ascii?Q?2LakwPZ73Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76241a14-dbe3-4e75-1c93-08dee74e1af1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:32:58.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8Y9TDBL8DDedXdE+ddk5cRickSTLG6/7vKCjvPxTALH2cGpMZDMEtq+TcuTbwWHVal01mNbJvcBVJOpNO4mwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

Hi Cui,

On Sun, Jul 19, 2026 at 04:17:13AM +0800, Cui Jian wrote:
> scx_sub_enable_workfn() drops the return value of validate_ops().
> When validate_ops() fails, the function jumps to err_disable with
> ret still holding 0 from the previous call, so the fallback error
> added by commit db4e9defd2e8 ("sched_ext: Record an error on
> errno-only sub-enable failure") reports "scx_sub_enable() failed
> (0)".
> 
> This is currently harmless because validate_ops() records its own
> scx_error() first and the first error wins, but it leaves the
> fallback broken for this path. Save the return value into ret,
> like scx_root_enable_workfn() already does.
> 
> The nesting depth check and the cgroup online check also reach
> err_disable without setting ret. Set -EINVAL and -ENODEV there so
> the fallback always reports a real errno.
> 
> Signed-off-by: Cui Jian <cjian720@163.com>

This doesn't apply anymore, but the logic should still be valid. Can you rebase
it to the latest branch?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.3

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e3fa7b2fac9d..e623d6375f66 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7559,6 +7559,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (sch->level >= SCX_SUB_MAX_DEPTH) {
>  		scx_error(sch, "max nesting depth %d violated",
>  			  SCX_SUB_MAX_DEPTH);
> +		ret = -EINVAL;
>  		goto err_disable;
>  	}
>  
> @@ -7580,7 +7581,8 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_disable;
>  
> -	if (validate_ops(sch, ops))
> +	ret = validate_ops(sch, ops);
> +	if (ret)
>  		goto err_disable;
>  
>  	struct scx_sub_attach_args sub_attach_args = {
> @@ -7613,6 +7615,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	set_cgroup_sched(sch_cgroup(sch), sch);
>  	if (!(cgrp->self.flags & CSS_ONLINE)) {
>  		scx_error(sch, "cgroup is not online");
> +		ret = -ENODEV;
>  		goto err_unlock_and_disable;
>  	}
>  
> 
> base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
> -- 
> 2.34.1
> 
