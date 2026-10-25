Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792923666;
	b=BuZa1hA8Pj21z5q9ne4K6uuoc0auF1G2KavxqoiuT/PEgX3vJx8Dx0litdQNugZSD+0B
	 Hgj1WViZvwrdkPRAEoPg39N8NhW7ufIcuDN91NreNQQznoYF6uoQKlKnOfTDqj+G9t18+
	 gl4Vh8qzSJMewZoIbR/Tz10wRCxf/giThxZr2DpBPKsvLUBg0+nweIhy0lpRVlkFPRBwx
	 I56PayfqiPDb6zRSrBSMOEuuoabDatpN7jh5V/DmnpZeTTMOm8EVhrZPJ71JESjsvrdNp
	 BXCs3gwIIuxe7rNHfzWk36Cn9CFfLrBEybzWZKwRiWPeIwPa61lRii6EoUwlYFSSBiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923666;
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
	bh=VT3yDjoVFBMeA3NRTEExtEQJlQkfQyUIOlTiWJ1bijg=;
	b=MKxo9GuunZkh431TuaTIOoe2Y6nZZGDfTxRPN62H8HpaQ70URz2gPfPgj3MPrxDGY+7J
	 b1dMfxyrlXQ4/63lq0PhzhCohtsrp0YsFaRDVlhC4fwS9ZfhE511z/3UKchuprf6sb+7v
	 Rpmr5ur9uhl2L3BCz/CSNz4tTG/34blzpxjminOOGwg/NIKcaX9mxKoJFmP4Pwb3Hm/ol
	 41SKylWtdMQ9za3V3W0kTAlozwTKuhM8JNRhn/4HL4TwFWg5+mnBOkdqyZHXXmCFxydip
	 QN6GDActrKk6HdVQfOQZM/IB6xTdqQYIkrirDlSJGqrnmye9t96XQk2s6iR9iWOpSNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=axvh91vK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C8606A31B
	for <sched-ext@lists.linux.dev>; Sun, 25 Oct 2026 10:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB9C8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=axvh91vK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKkXgKCzYeu8SnNIrwZ8BFzMRo6YYNsnK3jM2FkTHSBmw+RZo4xb7321qj0uiH1pIAhSH1kqtP8eVRJvp9FO4cxAX3WgrFRIh2y+SXeXQd6SikaYahCtKHiTJ0u/ZZuXvPA3OY0J4BWZIClSRvS5ugBqwKPS425bqIjVIoQkzYwwbTDkkJra4jyBUouuUdzdrcrYxH4lV80hUfMqGN4hhl0YKWi8idKqBGF5jmvf4AEpX2GXeE/k/8KfjZYzXbkeO2ip8pQZuE1NAfzvj/Hc6u8Fu40+tnPjQZNaNCGc5PSkSuhCw7HEjGfQoF2A6Y/sTC2gY4Ytw8Hu38l1tipY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT3yDjoVFBMeA3NRTEExtEQJlQkfQyUIOlTiWJ1bijg=;
 b=trvlsjwuZJD+otjacXSL+XcdA5P8o2hLCEmhI6tsindqWMHtB4kWk2muOFRwwlsKIkKlWQnaXqzl2AECrUHH9WixzgHbmpyDpfqp3UxMJ2XT53+2MjZbPUSXAaW351Y5XHoD01LFWETxqM1q9yeDCpUzpFGc9Eywb4UfpVBN4kA2JUIi5mREWEyphqin1UTy4TJMNa6JbzTs68F/QV1zQoTkx9o6rTgGK5ynF+c04WWoT38MCfAZbJTgb/KFv4iGzEEJjozqkmlkNaDW8p50mGsJRgeZAdJ4a//LQPqLo9hzNpjgoEFrFBOBAxLz/yxyrIUihxAYGhFS67ZDBtzVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT3yDjoVFBMeA3NRTEExtEQJlQkfQyUIOlTiWJ1bijg=;
 b=axvh91vKCzrqjPWb0xZUOXgLcWNcSD9HEHHpyuUAe9KA4W3UcKgC05wnVdmlGYmdWB+pPwwMu7CwG3OpbSJMQbx5XDiucD0HdModUIhnOp7II4gdKLmiLqodlIyp4ehhc+85stGMy8RsfA522kSR/SC5dKTJo42UDeSUT4TScJfs3hR71TZQnFfHfvPNorQpuiuiDX1MQhnG/NQxvw4wP66Pxpr6VG346OEpzRQ32vkHxuz9eOyW+hatikveikRp0QGrS7Lzyb83sDsqoMUJmQp4fLaUp/7IU8fiRINTvWZV/tEUwSSiqFcsFW4X8KJIouWutvqf/VpUzsaJ1aH7Mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by FT1PR12MB455478.namprd12.prod.outlook.com (2603:10b6:170:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 10:21:02 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 10:21:02 +0000
Date: Sun, 25 Oct 2026 11:20:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Don't sign-extend unsigned enums in
 __COMPAT_read_enum()
Message-ID: <at3YBauZxfWw8su4@gpd4>
References: <20261023232102.1124938-1-tj@kernel.org>
 <20261023232102.1124938-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023232102.1124938-2-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EAA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44e) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: dcb5cbbe-809a-484f-bf82-08df3281ab60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	xMo4y/rdzHrsnEGYHd/Im56Q0RIVMdEvwgyNh832aXUPJYdHr8sQ5LN7qWNQmf/mN8wVr79XvH2CsCuzyX+loqOefUgPXEtf6Or3TefRlGljFS52W++D/8iuTlRGIgjTji3wJsEpz6Yj5EiHUHki+NjR3K9RuOb9jrYtd9xtysVxG0miaEY3A75kWApNZX3jvs5GNMSKnduPA0VhhmFDHb+JXuWDKGRi3YPNBkXLspCtzF7SK0y4gsRuiHCvqRLlfm6pgyuj7x5Q/N6+2PJCbDAzIiYMr2dyBWsKOppzVtyAW89uN21qmqtQzQc6sOOefl/H8PwtbK/aZ3BeQlXxCYeiM5JfzuOssOZgIvgwWtgXVJN+16C1xxLujdG0/2Vvty9iPmU26jlwPjWn8WerbhYDY9g0y1NTZrdWAsD/I4xRawqGg8Q91KOZ4ukU42tnoGRgpBO/T/Znc2xGhMq1SyTBEy/LOpQUhOmNCf5RWT93fptZ6QepSL6GqPl3ccR7oVCj2GWy9VGUq4qra2VFHX/DrK+18bF1e7fY7bHVfw/zqR68Te1wusG5qwyiM7/dhZByD/VJAfNvoWyKON6yUs/my/wBlZ6agpIkvkPUNiorOTd8f2BwrKFT+F/Ma4MOiZLNpE+VGswv9fr+gSvkoYfz+XTvUM8uPDl9n079cqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yk8f2gB7Ci+hz2LN7Al7c2xvo6P0zBihsxckVNHK05eKX+/MKKuO6ShaXQwl?=
 =?us-ascii?Q?1Y1p582b8zO3MEbyff/CcCRNJwFeW0dYFlkponxxZz4/s5r+Ffji5vHMFqBb?=
 =?us-ascii?Q?quRN5t7gw6xgmAS1j/lZJODOOjrQMDVqLM85pcms2x2KI56FrpcMWtVRaDmz?=
 =?us-ascii?Q?nzhzB3zMCyPuAUeAJ0RrcLd3fMtQFxp7TDzskBT+U+A/mLV8aCby8+AMhOby?=
 =?us-ascii?Q?tDb8cja/45BIefBuBNOGUadoR54FU4Pb1VIABFnSS4yV6co+OrqGV6QD51pG?=
 =?us-ascii?Q?0RP2eN7fbPbP6oTCvTa2jv8Jj207qF5g/Xb9dmgHeWWQukwt8LLMl9PyogPG?=
 =?us-ascii?Q?4qpBmrwnW/p8ASVtBc/Q7qjvm5fAyXyCkQNmPRGrBfIhVg4rs+dBa/9Mt+LO?=
 =?us-ascii?Q?TuhOVLcScCDajkuR2jkK6w5uz9zvO0qKduiuYfE0zG93WE8TjOhiy1F3rTiZ?=
 =?us-ascii?Q?bldj37eq4PEbEHcatMAFNeCVTUCtFGv7+KX8zuiu0IRXLSISqDSkv9oi7mOx?=
 =?us-ascii?Q?TWMbwbCnEPyqmoB2o/kjbOSh94jYVpJPopFQ7zvcEMq34UqUxc9gTnPCqLKm?=
 =?us-ascii?Q?pFA3p165/MvFE1Zh1AAew7VqAvkGQ+C7fdSkS0DZd5G5ws7ZzMe/Rupt1wmn?=
 =?us-ascii?Q?tZLVYT80Sce0hlKtO2W4DnnNFWNi6TJPL5DeX7M2sY4CPGSwOpNNtdCqM9k5?=
 =?us-ascii?Q?YSU0HdfBeIDxYvuuFr0a0Czkk6gdkBWHVYhQg1ePdDGn0yCxMjJwuPveqxFL?=
 =?us-ascii?Q?X6JKEpA28GpFXfxFw7Wkh5CnoYbn3e3O0chEBoirNUqnuOX8YANb+FwlT+Ue?=
 =?us-ascii?Q?G05CFk7M9j70/VtFgAKgvBYc1XyVUIzglunvNlZqqHm0w5LCdmd0ibz97V1s?=
 =?us-ascii?Q?p1ckC+LLZZIWTDxbcICJ0DLKzUJgCYdME6njA4SV5VUgdaABdeuOLMuosACk?=
 =?us-ascii?Q?ollmJxgsiXeF7G/T4yV93fwhOU6X258yTE1tUTqdaKlnjUdSCjvIAq9+8UEI?=
 =?us-ascii?Q?YkphmZ+MCLdgJzBglScLj3/SFachAGbuzbXDP7wvKZSMOUyfnz4yn0fWpCxk?=
 =?us-ascii?Q?ehPcOqTd6h//+YQ9lhn88iY00pOyuh1xy9uxO8JeNWXXcjKKfqUItgKOUeTC?=
 =?us-ascii?Q?WuFp2ncijnpP1ed4J633Dfjuh2MQnGMf1rLO8ruQzMsQGq3IOwZwvP2SK1mC?=
 =?us-ascii?Q?uXFLwCsi+8Z/cezaMqeeQlHRMsG4zAKU4Z92H6Di4GO174qmnx03L+B1ekrD?=
 =?us-ascii?Q?EcI67XT6uBIN3NChYZTiTnPWAICQp+tpkar/NzyksKS1UMTJNATDgze21JC/?=
 =?us-ascii?Q?+w0sMAqyere9tiipEgAvwpYGpMWprUB68RPTF6dbDt5VuyWfp3KzIhOAiUII?=
 =?us-ascii?Q?iVT5jsWoPS9Z5y6q/Y1Z+sXVZE9qibT5c4EwweVB8VvXbVEFrq7PVWoRhG3K?=
 =?us-ascii?Q?U1B+Okuv5gfz1RDJ+tFyBqYJL2Lo6gmw4rustrTJfxCGZZFEggPFMW3ABSWo?=
 =?us-ascii?Q?brE5QxQTCEIHB9papdYLyRUP+B7qdPhQ3n9eiv9afrZ+bVbDJZMeJ1OSeY53?=
 =?us-ascii?Q?xrjk7V+rjzm1aPlLGnM4XE64h8KJVF0CRqWxrnykRTSt2bt1LYPlvpJLxI6e?=
 =?us-ascii?Q?6c85gUXr6TSE0501dLNeoP+c7gMJ83HGtgidlgxCEbHlYinfcjT++z1eDAu+?=
 =?us-ascii?Q?w150RdkSeDEgBFYcvrpNk4JswyLtQKpDK/w7B3V8L/qCOjQw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb5cbbe-809a-484f-bf82-08df3281ab60
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 10:21:01.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUDYnZMDKD3GjjDoQ6fvhlKHYBUAfzmgCsQC5fnzpP4kbTcCEkyJFdl1lRjrHVQp7PWbMfhiIY0TIN600C9Xgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB455478

Hi Tejun,

On Fri, Oct 23, 2026 at 01:20:59PM -1000, Tejun Heo wrote:
> __COMPAT_read_enum() looks an enumerator up in the running kernel's BTF. For
> a 4-byte enum, it assigns struct btf_enum.val, an __s32, to the u64 result,
> which sign-extends. BTF records the enum's signedness in the type's kflag.
> The code ignores it, so an unsigned enumerator with bit 31 set is
> sign-extended too.
> 
> b1c2a6b0d90d ("sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through the enum
> lookup tables") added SCX_RESCUE_DISABLE to the enum lookup tables. It is
> U32_MAX in enum scx_consts and the only such enumerator in the tables. BPF
> code sees it as 0xffffffffffffffff instead of 0xffffffff, so a comparison
> against a u32 holding the real value never matches.
> 
> scx_qmap, its only user, narrows the value to u32 in userspace and is
> unaffected.
> 
> Sign-extend only when the kflag says the enum is signed and zero-extend
> otherwise. A signed enum keeps the sign extension, which is what C gives
> when the enumerator converts to u64. SCX_TASK_CURSOR, 1 << 31 in a signed
> enum, still reads 0xffffffff80000000. Verified with a probe against a built
> kernel's BTF.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/include/scx/compat.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index 07fb55e63c57..c8d7280ceffa 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -143,7 +143,11 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
>  				if (t->size == 8 && !strncmp(type, "scx_", 4))
>  					return __COMPAT_recover_truncated_enum64(type, name,
>  										 (u32)e[i].val, v);
> -				*v = e[i].val;
> +				/* kflag marks a signed enum */
> +				if (btf_kflag(t))
> +					*v = (s64)e[i].val;
> +				else
> +					*v = (u32)e[i].val;

nit: BTF generated by pahole < 1.24 never sets the enum kflag, so on
those kernels signed enums are zero-extended as well. It's harmless
today (SCX_TASK_CURSOR is the only affected entry and it's only used as
a u32 flag), but maybe it's worth mentioning it in the comment?
Something like:

	/*
	 * kflag marks a signed enum. BTF from pahole < 1.24 never sets it,
	 * so signed enums are zero-extended there too.
	 */

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

>  				return true;
>  			}
>  		}
> -- 
> 2.56.0
> 
