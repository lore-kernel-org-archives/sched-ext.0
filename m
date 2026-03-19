Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4834DCC7
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903000; cv=fail; b=kn5cEXmRrrb45eHLPsCvp5Y3MCtBLDwL+9C4oM5gcg/g1wa6uClMKDQMHhMz9dFV1aGJsGSX4M6t1+65dfRTStuN6RNMMGsQ2eBf+cP73qUQ1rv6ZHacvd71WCxVtm92mZdkOg/FGMu3GtWeBudBt+wRIkITDaQx4ywZo1ePfn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903000; c=relaxed/simple;
	bh=769jwllXlR0HkEWe5CaK4hz3db7d84E5CWZTFpnP5vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HszRlGG3bbGIZy6bQmwc55LBoE8JKCvYT4WciQ8b8ny/xKpGBY6erhoiLkp12C5srE0+1ZiUxLto6hpWafPxQRUxyNPqXvVdSYDXe/ZnHiX4I8eVpIwmmEjCb8IcPsRcJO0CRL5wF2yl088ga9xkaozB95evUTNcfDIO3lrXu44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cKsW63jq; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cKsW63jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ5nQjBojatv2cAWQ5N/qbOisLQfOzQsjTViygzapgPCDCq9eHfp9PNcFjkTRjtzL49g6w6ilatfTnBbFgRheEe5/mtHxHFsXtmpio64JyA0p0PJMjAcDyHryNU3IkqYhNsoJo31orSf4BSsMr4KYVPP9R9rVIhMDti1BBZcOuRG7UMcgEB8hniZPLx1u3pWZjWnR5QlNJT2WS+wmxfQ/0t8KycA+zRv3SnTqPM1VX9jUG2cvcgwg6XlhCHwJj+qBTBF0BEtZGbl8+KDH4Bi9l/2qIFagfeP8YW3xBhqyWn2NUVUSGG1t7XC8Dy4ngLVXaAc6uAqkVgVXu21KarjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mCizkTYAnZo9gInINXGqm1c/xMRiQwU/BnF5Vntcwk=;
 b=Z2bLLRBOoClQiA0VYqxHUf+XcM1SvxILl+uGDzLRqTIeMqC+fueItp4h2xuzUQGJ8ZSmCrRjYp2KFkCtxkvXUaBLKkVXYTYZVg8VxD+N3i9zG91P2jGkaDvHpiMdCeF99EB1kOAHkLuWgbFehaR2SJ/bWp8A9IbU+pmr06Xxa0k5GbFeDIttnUVpGZrPvBZsXDwNnsx0RQa6lTqLJZ/4lRTZijcxqmi4uOSwuKJrbis9NiYWxaY9F8Y2Z+7AvPSWfUK4zG4d3rTsvKpE+erCwm4uWeX2kFX8Y8IpHcGPO7bdYk/ysNX/h+OB7subih68VIVji6Q8McWn76RFhfz1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mCizkTYAnZo9gInINXGqm1c/xMRiQwU/BnF5Vntcwk=;
 b=cKsW63jqE5B7F+b+ksSgMaKnefJI98N+AGe+vLW2osF7FO41Px0ZWYeDNDk++BnAoyDZOGn47QryczoFe1EGNsX5XrRGJpK1J4PzO7Nhv6ESXEvnMMBSzIsLwkH74Ih7lLnenc6CK9drmumeEN4nit6Yazl0bVAfR3a9nGx4vuswU/KOdEo2bKG0J4I1Ox/2rG0y+kvrGpgYWkVFKfx762gWdlDBEn8EVdxRgc85XnPw/pzN5ltooPCaio7VuMMcqfuwnuP50X1t4pbCWnjDZCxD10xGImZi+JzE30xnkFLSH28tzSCNqH9va1L2H2A+4q6yPjWzw26IMVMRuoFbww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:49:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Thu, 19 Mar 2026
 06:49:53 +0000
Date: Thu, 19 Mar 2026 07:49:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, peterz@infradead.org,
	mingo@redhat.com, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Return non-zero exit code on
 test failure
Message-ID: <abucjYB136uIIrmb@gpd4>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
 <20260319053026.447892-2-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319053026.447892-2-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: de1fc704-e2bc-4aed-dce6-08de8583b959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ITUaRD8yIGUaOkarXl0VCWENohU0dhjCt3sYSByHTeZA0xtYalMlM3+d7cOqrX0UcWmDO/hI1H4JeN6XlUhABB0MXxJExjqs+J85rT5ziuG+qMnlR9qukmNOZxIwcX7x7bBVwk/YmwRAVujyTvVRaBFgQFGMWnGHnPvQk1EUDob4RdmUGS2imd2RQISQQ/Ujm0Gsg2FrXIrBNCHUAo5Ipy1LjD/qbb/kQInN5OQW88orWnDXTzBpdPSjGOaZR55hKG/qyKcnRLnn2QCoQ/+ctewhOzro+Fc9liPj6X7rAwjFK9Rz53rOPjvNbOLRwF0EP2BtmIG5qNskn8p6IkJD9TeStQJEK4OQfumTTwrZvT3Gmd4TzeYY9hT5zMB1peOauNaNgJbWvfZFLdlUciUOnNAc3tmblPdAQXDWL8NDbIEInbceDufW8FC59+3j3QVLO3rpF2zlH1veMptx21TeJyqmXFHb4mup/aaNL9WVy6j+0lcBOPWoVd7EuiMtRY0ZvhtUL219vNmdKJwrb4CT/3s8jaUEMquewHxRPTMdQLz2fB2EXgrUnyyhTJpTwa2eX647LZcwqQvQyDnh/84cI2Nw1ngx8GfghZjtJaEBjhZwZFpKA33ROZkKw/iB2/SDtnLqP0kjXpOTF32rwzJAvu4Wu5RIVJ+9ly9qlitIIKhLyhm+8rqkGkaKDxhAYEUnzdUCWtVVDggbsjKAEf8319ICetMewUUYbVKGmWQRMkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaykQ9NlsDRsKwmyOmD0VGZpzpk9KUXKsaUdroQAYmVpxBWTQafxmV0JlxBV?=
 =?us-ascii?Q?remmlyUulFTUpWc/kHahDjMvVEj5GCf3qfwqUWhSk+jTpyf/TC/TyTwYaxr+?=
 =?us-ascii?Q?+wkSCdecvpy9cscli9uJfsNAGrW006qfuhiWbzgwJ1ZhRSXvRPeZsEaZlMhT?=
 =?us-ascii?Q?VU0IlHrNMjRYz+pCWLchSmJgO1qmt0eFglMD99RcwN4/gct3O/WIDdKsLbWW?=
 =?us-ascii?Q?uLglMa84/ILK6P3++5v4+1f+NSa/izV9diDaZmE7EMpFU7FsJAfXANIFKJae?=
 =?us-ascii?Q?2UW0z3MGJ8rC86RNuUaBUmFUW5MBgu5oKNxEkJRQ0AWYL0p/HssFX8GU7q/m?=
 =?us-ascii?Q?ebdDaJjDuT+YFFsBB54L/BXRJVIDXbPpBI3IJ78qcDNujmO+S5dLpMDz5PoA?=
 =?us-ascii?Q?vVFw19KHBT5WFa4kYbd3a1//72MisSJYuQSWOitoQRsp9QTnFKYKm9FIIxUo?=
 =?us-ascii?Q?xADskHJfR6Pxnbd5dxHlbCSvCznGLtSwuNH2P9XiJpAa7r9X2u7VlGz4qu0h?=
 =?us-ascii?Q?81676YSNMvY/znNoc5Bnw2uYj5fc7zkp9qm4INtlOxqqalOidB2I928cLoP0?=
 =?us-ascii?Q?I6UuVf0bllanNkmcvaGpjavqy4UkARMRsMzDsgU/4IH101iPU6UcI5MqO4dm?=
 =?us-ascii?Q?858NG9AXxWOFzPLPX4BlQz0Ywfto4BBckcCwz+hYakdg6rxX+SnSJ7ASJ23g?=
 =?us-ascii?Q?ruqrm9qtsvaN5AJuKjtgHvLhFusxKdazOco3PkvIgYlmv9uCm9xUjFlTb0Gg?=
 =?us-ascii?Q?mpJCUHLV0aSVxGZsCSTFddEGA5kpFqJkyRk47uV5YTDTPTpDJ6hlrzjluuTP?=
 =?us-ascii?Q?+8BAKtesD53Uxjidc8O/3qLNfV3oYpFQGf7a87GaaCVcYZfevP8Vu7WM/7yZ?=
 =?us-ascii?Q?G1r0JSvsnw5PKlx0I0gotJJ66sR5y6nI7cn8dJjNzgz69U3vpPMyn8WcP36V?=
 =?us-ascii?Q?Pft0dSfbscMUNCmap9VaWLcV4R+HiuwlPqvE9Mpl1Qpsi6u/Nrib2Pmv87ch?=
 =?us-ascii?Q?yFyvb2DqpyahGEACTUKkPNA9A0x1xWq90rSOde2OQkf1NSItQ0ozsFEsM/zF?=
 =?us-ascii?Q?PH4+2kXXzmyi0sujgN2ZYW7LvSBmaCHwM1Tl0CjI3M9QpiPQE/eIjMY+hI7S?=
 =?us-ascii?Q?55EtnvF/agnx+koMAmBJrLvV7s6hHTF+uikx5DSeEWVeLvYfNMtiHKbJfadQ?=
 =?us-ascii?Q?8duGkQ97eqI+o5DyL2bBuCg9MI7Orrngthu+nBD7aH++v1ZaaJYeq8CNvstK?=
 =?us-ascii?Q?fodadqw0ATARY+mghMo/wC4nnAoC7FVWkEUYiCZb2ehbcflZeilNbr2LtM7x?=
 =?us-ascii?Q?TVL+TAZYw0dQAkBGzfphIQRwdgThUqGXV3Lmo+qeez0vf6Ny+02lU6tJECmi?=
 =?us-ascii?Q?+RydHcKxAYt+EOFtDB5MMlbp+V+0+SzM0XcfXLmPU2ZOVpQb6Do793OFUcNY?=
 =?us-ascii?Q?YwWfZ2dplDtnbQkWNypckS9UjRkDJUt7jcRp9ZmLWLpDrTlKjuDwVy7Yk3Mg?=
 =?us-ascii?Q?WK9T8+cxBESOPGer531i2Ra3YlD9TfsvCHsp/z8Pa3SjLFTjdQpqxWqcmwvK?=
 =?us-ascii?Q?eGtdXjdZT0kDss2+LgNcnfULbtDcPtj53YkOuFUp/bdHlgKCbvlOSElHf4oF?=
 =?us-ascii?Q?EAaKTA4xGSSkOpCdTTGCMxJOkfwSajRxQ9YgAGXLp2P2L/eNKO3DEKx+x/XG?=
 =?us-ascii?Q?ugMOaq6m/pOp6SqCa3jc9XHETvcepjTnT4gsIvNwOS1M53ty?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1fc704-e2bc-4aed-dce6-08de8583b959
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:49:53.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3c91oEidFQKDr0Kl70d0ygGpds9S0Psuq75cTlDmvUsRv3fn5+9FQhQ9Ln3du1a+2M1c6+F1O6bsaRA27+GiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

On Thu, Mar 19, 2026 at 01:30:26PM +0800, zhidao su wrote:
> runner.c always returned 0 regardless of test results.  The kselftest
> framework (tools/testing/selftests/kselftest/runner.sh) invokes the runner
> binary and treats a non-zero exit code as a test failure; with the old
> code, failed sched_ext tests were silently hidden from the parent harness
> even though individual "not ok" TAP lines were emitted.
> 
> Return 1 when at least one test failed, 0 when all tests passed or were
> skipped.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>

Makes sense.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/testing/selftests/sched_ext/runner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
> index 37ad56c3eb29..4c68efa1512a 100644
> --- a/tools/testing/selftests/sched_ext/runner.c
> +++ b/tools/testing/selftests/sched_ext/runner.c
> @@ -217,7 +217,7 @@ int main(int argc, char **argv)
>  			printf("  - %s\n", failed_tests[i]);
>  	}
>  
> -	return 0;
> +	return failed > 0 ? 1 : 0;
>  }
>  
>  void scx_test_register(struct scx_test *test)
> -- 
> 2.43.0
> 
