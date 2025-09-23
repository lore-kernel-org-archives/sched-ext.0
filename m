Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369753101D9
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612060; cv=fail; b=LUQqGTBWzBpdHDsYfxkccvX86DsnntYjNiic00txWpOir3rUID8p1VaK+y9tLR9KBUPfn64s1AzSQN6+Hm8p+pW2dJGPLMoHC8NtNLbaw+tlkCn1OoV0eeMM7kP4JsMmaZeC1/TiWR6Qls4JWeT4LZTcwZymKw/oIGrCbG0AlKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612060; c=relaxed/simple;
	bh=TljLFCba8Gcjk1mUvJ8ASNXvbOC8MgHqOKseNPfxC3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=porwKNJqywxnp/3gVN76WgkGVRQtDtWoe1z3f0ihAhJvcL6yOEQWXOtWkiOwPkoCm7Pzdg0r/119SxcjkPZftpo2Yd5UfA3pindK5lQIM3W2OFy/3V2+V0WHvTyoOXbkGjLb5qSU0I9lmdk36Xaa1U240iiF7oR9e0uWO+tXy2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AbyAG1Re; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AbyAG1Re"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+Tanrp4fgMeAnMXuQyRpsW6mDtJ1dU1dA3RkcVr+cwhWbqiCH3FtpvVZpTpaL/JT6QEbiKbHTsfKuIf7d1WGZUSwRLRMQAEonwR1MKneg92a1oedxdS0mLmlnDCRuwqivqAzCfdkcCOjZxfsc3OPyQVGH4qWeZMxP3lupryp+XO/Ehh7+2Cdkqwo2KRaNGuwibCOmt5UIvyuw5Qjw5sf92qfTkPEI92Par8bEH5n0+lmi3x17q7iyOwV4Oml/14/5016Ap6GOtE9IQjEDNBaKwHUR7Z2YGo5EFDrO1B2uNvd0QHuBIzhlUGddgR3TzNIcZ+cJskhnx0KRrAx7cEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf5Imie3twugRh8pwjyjWc+6rempKsY8QDKMTbBtGX0=;
 b=kttQz6Z6OVx1Rv/nb/UEoLunfN/Nv7vxdTN9+hbPtRIRh3QtpYytkqKWmqwISZvg9+r1KC8ca6IEx/cBFn8z4pe6ZE+wkSHw9gQX7YmulIAq27HMWx1b1R9wVskV2HANtdH+UYYOluLCPYh3L46gDfhs1pTAqLwGo+PM5+0SZPAZ0/LtGD/9cLuMNo6HSNvQbO95PhHHWsZNuAJiW10sW7QTuGb0Zi2SEle1/7F/ZG5m66O8UePUBg5kzSZdN1epPIiUxWn7riHaCbRgjKLyq9zeR4RfUVivA6HFND875LHjTPmAk4WfH+9M09ZGP3vAiqgsttf0i/ocMy3iMS9S3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf5Imie3twugRh8pwjyjWc+6rempKsY8QDKMTbBtGX0=;
 b=AbyAG1Re+q7PcAtV5exVRwW3zop5in2+KwugywVjPKKy6A+ES6zuPUU6cE+fNSDpSnoxU/gWRRJJU8/zUcddG1avDjEjxbWkRZeXa9GXnrp4uigAou/PvRq4tf+zRDNTD7eWIN0V4jt6EUgeWXJI45FKmK+YMOjy1aSaL+bktOB6VlSF+dM5e8uKSqDUlyOHPlg69LlydXa/bPf2pIQmuwUvl2CDRmkuoAl3DOALX4hfGrBf5fjSy2IALsvbrGEAih7WDDoyVwrkpLM4RPAVlOgA4kEHjxyW3Ajy46HqKNldgpaWEXvWBrROQ8Sd53jFQF4y/amZS/CZgoGXJ6YT1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:20:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:20:56 +0000
Date: Tue, 23 Sep 2025 09:20:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/7] sched_ext: Improve SCX_KF_DISPATCH comment
Message-ID: <aNJKVav0vog6_Smc@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-2-tj@kernel.org>
X-ClientProxiedBy: PA7P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9a0157-ac04-4cc9-ae36-08ddfa71bcca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5if5J39FEizcTbAf8X3y93OtDkn8CqItKncr6R+B+OakJB2X0orb/l2PvEye?=
 =?us-ascii?Q?4Jhrrt6FBX7g3TPJ4VNu1OrWKNkD6JOZaC76J1Azp8N2+Kiuz8HYwQKcZwJa?=
 =?us-ascii?Q?ZgCrQ4NqjJiDKsEvcTV0Hpj7TG2SUEaSCuNYTUfn/10BW9q+RTX1eMAkSBdV?=
 =?us-ascii?Q?uH9r4yHwySHFHTT4kQiI313jvTxVVM+eJxUJElUntdC5fnBFaj3TwqEHY8T0?=
 =?us-ascii?Q?jiYIh14ycOkDYiDS6geQdiDui5pzOFYS+mMhnNcH3kc2B1wLwjjQqgaRCuvi?=
 =?us-ascii?Q?c0nPGnKj/uqo1OAP61HVXOvJt4MZNdJfi9ydC2chZzh9xRjFI47uu77Juu2y?=
 =?us-ascii?Q?9Bno2SVRujnMa4zxv2g5RojplJD/sJc7cHI2U4Zc1Sp5bzdhaQbFfsq+VQMF?=
 =?us-ascii?Q?TaUkeOmGGhqI/7FJrWrGLPIwUm9NJJaGzxb9gptKzLYZPmPE/he0omkd2C33?=
 =?us-ascii?Q?WUW6GXNoBnGqL2szFH9KNXnfarTDV8VaDhMFJSm/CCXdtCkMyU2jcFglixEO?=
 =?us-ascii?Q?lmkh0tTiTd1ad8AAQfmbeTePdv+YfxJ3J7ywYA6/eHu4pCzSlBikQL70WvtR?=
 =?us-ascii?Q?JpOEOXzpCAPfxfmNR7Rf++4lZo1K046cQCFvNYnsD5BLTtKhDOqaqzHYEXFR?=
 =?us-ascii?Q?SM7H8D2x95d3SBr3fkhCbhTxV3aSYd9eMgn3BOww+BA+hn9He0EpPP5LF7dB?=
 =?us-ascii?Q?hzTn6cVNBEmEo90FAS1jmW5qgJlaC30wt+YTfNUHfghNbrq0kyoWpSDzY6Fz?=
 =?us-ascii?Q?1rPRG24MG91ccDVVhvfZxSeWbT7HQkyE9IypIyhBLncJ8QsjddVKqdXAXOpJ?=
 =?us-ascii?Q?lqUjRec+51e9K52YDItWF5L8hQhSTiJY09UPrh9WWi1ypHrvSn53vWSySq2b?=
 =?us-ascii?Q?/jICiQoznVP9ZYqRe3eHAPjeMOf+RDTkcOTfWA7Thga8AqTLTSFTMEHfys5M?=
 =?us-ascii?Q?yRc4cQPWbgl42ED+MbooevrjJqVzM3QswyTjtSRSOjAy2H/Lw7pjSmrl2ysb?=
 =?us-ascii?Q?PUjEQcpKM9xjkU0eKxe5J7VZXJRkN8qgTQakCsNorUyJMnzn0IIaz/1tUvQc?=
 =?us-ascii?Q?JncOBufziVFXH9W9ll2+Ijj/JX86GsawuK8zaFn8HRLq7rjUjjGdXnf4hddU?=
 =?us-ascii?Q?+kSZAKQS972qupFBDQ4JMpVhEknY4r263MrthsicEYPM9YDXNFHaUi9iOKvk?=
 =?us-ascii?Q?rc390ayshGyQyTavTzVL+BpPgfFyiIXY14rqjgfGNOpvWPrVu8dt1swXzhqM?=
 =?us-ascii?Q?39L/EVnfCfquqpOqxq9GMe5p+0kCPQe4wy2COZnzzuzH/sHOUNe2pzq6Cp8i?=
 =?us-ascii?Q?fKctoboSm9S/98sxjPA+yCsvO6n2AzbUeXmGbfj7o7gQB8XpZJU6e6Q1/VO4?=
 =?us-ascii?Q?Y+GDAmXKc/o0a/CvJmWbQMyg/kxQ0uNIWvq99aHU8LZ+iU5ezA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tn/BmOsZEPfVdaXXelES3sX0lCrNcU9OsOSH1ZNOycV8VA1naa71vz8u8vlN?=
 =?us-ascii?Q?2uyWdUl1zu0pARW+P+hAgcR3jX6VhnOzH3pZ+sTBQ/l3FbtcK1+iYv5zjElb?=
 =?us-ascii?Q?L87pDt2QcaLrCDkTEPdczI69KRQW6I6JpFm4rmw4WLxKibcV8JATkdd9KwNP?=
 =?us-ascii?Q?3yMNPyFsdAQCF5ymzO43HMZwzS/xoYot/TJwyuWg6BvaH4uaOgAj16BdHiNd?=
 =?us-ascii?Q?Dj09tTdzGREm5RVdMeYALufp8zZyxsINZEZbQhGpKkjoZxYCyXo1VJ/MlXMF?=
 =?us-ascii?Q?kOeO5b30kZLXHppiroFbVF+xomjGWPWXgVWmWqGBMYf5DL69oVXDJlfbDA6B?=
 =?us-ascii?Q?LOInpIjpcdKPH999pwHK55ygC7x4n6tgTk4IqgSPPLiNnIBSm6A0CpZPwa20?=
 =?us-ascii?Q?f96njP9eBzjZ1ER2SIW9kzawOCeg9Wou1NfV8Q/9m5Ey2/D7jv4X/Fl6txc/?=
 =?us-ascii?Q?hrFhsa0XuwBYv45aurNNqmmsk499aiSfhi7xzAAGjAcz/s1clRj8ghTewQv5?=
 =?us-ascii?Q?TMiMQuyKFQ28rEOhHQYPDYkZIuKkySUnbiLaiiAuwTu8Xm0dTl4QpfJBdKZm?=
 =?us-ascii?Q?FO63VkDm3I40Y2uR9ebWEHrvyFr/GsxF1r3+dFASi6L4dkVEQmS3QjKKgp2+?=
 =?us-ascii?Q?nzbtWM7geaFKBRe1nLXM2YP81U041aWMK+O6kubpvc0g/c7s9utSOVvzl5bx?=
 =?us-ascii?Q?tUvGpK8HQsrq8LvYV3hC8AtAD2xuqttxP91rwU2Y8tDeV+lnlwui9vOoWasc?=
 =?us-ascii?Q?NRG4X0evhQ61paSG95Jxh+ZsStmVFirpGbg14FUjCOAIaTK4YzwM9eF6B1WY?=
 =?us-ascii?Q?+zETrKLOz2eNWZsG/M2vIU9wqf0EKsfgDQ+g7wlfVNVJtW5HC3wteaM+A7Wv?=
 =?us-ascii?Q?W8oc47B/30SCv/h6oYs11k2jyqKlRWpZal6VPWd8wfxnpus56Ptnb5cNL4qf?=
 =?us-ascii?Q?QJre0VON0C8ldCyrNqlWKW+vG/D31dCPhg4tZYd3LsjMJYg1+JtdD3HnoZmj?=
 =?us-ascii?Q?6AWKDJZD62n8kTDFjdRb6i/gzLCuhLFaSf8Fk3GkHF1TXUQJKR+GRsoJkYr/?=
 =?us-ascii?Q?HsKPWYIZy95ggxVVjL7pxVA1dj0OwlT5mooANayjXFN7HrpcpI8HRq6svvH5?=
 =?us-ascii?Q?NEMlvSmn6qw8vZ3XyltP7oLlMzfeMtjxQnx7RbbVIWnqedFgAOsrzRw7jyRm?=
 =?us-ascii?Q?3I46llKDOW6eBBFnDHw47tGdyTiR8XHI4cn8T0o+a0h3AkMI4f0meaQIVQOT?=
 =?us-ascii?Q?20tiaswfREuTjS7dvgFmoJOO9c4L+UxCqUNnJPFxHNjInO4QYCwEE9Yr31WW?=
 =?us-ascii?Q?1QGqgM4EO1D0xwyYy+1JPtI4nsLSno6GGCBg3ywRMh8FhuVoj0XBQAaEKdV8?=
 =?us-ascii?Q?Ip9LcjTIb/avX6SD35WPioh6dzfWy3oFQCY5DZXLHnPcpmPQ7QQ5iPxvMvUY?=
 =?us-ascii?Q?9CYP87XzjAEpSLbHbkc815YgDhzaoGsqc//HKxZjPrCqY9VnnZ3fhRSSIB6U?=
 =?us-ascii?Q?8DWPf6dbKl+4nEZ1hooo1dP1MaWgNfKlfXAZCe9Uju9qXoBdYAz1Me0ECdqB?=
 =?us-ascii?Q?FTyunhFm+bz6kMuf3BQA7OgiUAyGldxl4Y5TNviA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a0157-ac04-4cc9-ae36-08ddfa71bcca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:20:56.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BswFIOvnjulpTen1AHQKmWwV9fb1xvXPx1IE5Rc7d3r6/o8LDMoY0bakh4yDJCc+SjRQvwZMlbgKLV6nVAokzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

On Sun, Sep 21, 2025 at 03:32:41PM -1000, Tejun Heo wrote:
> The comment for SCX_KF_DISPATCH was incomplete and didn't explain that
> ops.dispatch() may temporarily release the rq lock, allowing ENQUEUE and
> SELECT_CPU operations to be nested inside DISPATCH contexts.
> 
> Update the comment to clarify this nesting behavior and provide better
> context for when these operations can occur within dispatch.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Acked-by: Andrea Righi <arighi@nvidia.com>

> ---
>  include/linux/sched/ext.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 7047101dbf58..d82b7a9b0658 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -108,7 +108,11 @@ enum scx_kf_mask {
>  	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
>  	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
>  	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
> -	/* ops.dequeue (in REST) may be nested inside DISPATCH */
> +	/*
> +	 * ops.dispatch() may release rq lock temporarily and thus ENQUEUE and
> +	 * SELECT_CPU may be nested inside. ops.dequeue (in REST) may also be
> +	 * nested inside DISPATCH.
> +	 */
>  	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
>  	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
>  	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
> -- 
> 2.51.0
> 

Thanks,
-Andrea
