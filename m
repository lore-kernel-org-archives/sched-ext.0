Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792447432;
	b=5IXpwxyBeID0rtPOAM0qVckPdMc9QPeZCn1yErpl5a1lqwdiYu5q1PT+BCf2zllBzDOn
	 CvGnxasRDwuz7VdLKJThg6At1W6MqTWx9PCeDX6Ig5g7dysLR8n36M7Zvx7vLw7RSOp0g
	 oHGZY5YHDlhS2IuRiFH0GqD8lYtvNR7hgeHwId9B6dZUffxiWA3aayhy8D8Bplk4KiXcA
	 KzeADCSqM1mC8IYO94Oqs5bzjGuBeREL90jI7Znl32vFalpwr4rT0m3M2XS4nhUCKEyqP
	 iFqeyDr0PFqzROh9IVUF25WpwL3RV1K8sGS0KwTfQXLmc23RFd0u1XzLp0T4uQgPi7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447432;
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
	bh=q1QK71bn+AbLncP9hug/0LrTeFF1y50arouKOUky+yg=;
	b=0gT+uCSbwChJwo5ebPvhkbvPqVtG//vaJ17rKtWroJ2xgL4BpBprcD4txyLcaYNFNipS
	 lQL3YIzRX/NdlcjCEPOO941ers11tgXt8NFy7+s1AcZg9mGRKNRTnYNJCZmCwNf5+ss16
	 MnNQcO213pUl1JRLdtguyLL657zHYLBo6O6GV+pS3TPhUd3s5eFhrc0Ke9nHyWiMdHt2i
	 ki8d7hGzg0XnLPE0N1BhmmhfahpC33pXOHWQ0qTEXgFqFmO7kHWIA8Qgbmkf1Hn+xXjWB
	 tCVaU2zt9qSd6SvVJZhAUKPi5QeaHX8xsDqqwfgg8uCBTdtDGq5rrTUYH6IyoB6WQ/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ad79eAoy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.68
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4D606A31C
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 22:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ad79eAoy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjDRKM3o06gYzCESVXr71dynhv0RvMuq5fTkTj/xjO/I/bInxBq8YGPoEj9sJ5FFVFkfepVo3mQQE0CW2eow/8/HtdTMLDbjKYSOcFXRNrDY0U2sb4jqBWoxWxn+4FFkfVxdfobjPTxeS3guJHAyJNeJQG6tGErediqXDBPTMANl40QOLQed1XTyo5Ou/DbQGrr6vi3Fj10EhzEPCL+eyhE3X7NNXl6yLlKHnIPysOxm7uWnXHVxrko0TDtISY+Kf5rJVpKvZpRMxyVwQwmvursP4T3JuKhIhJE8i0OEpsOcuRufhW34YZqgEIwVkuwtINvqbOjgaVbm+mzdEPo5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1QK71bn+AbLncP9hug/0LrTeFF1y50arouKOUky+yg=;
 b=cI7WU6za94NrO0bKifBiO6WSEQpKS6+ippNMKKraANan0XSgq6sbmik0eYBO0WWMn22AGBvPEf8Myu/EnJgqHpZ/EHAwLvPNt4zofd0uXQ+gI7L1Wr3fa47qXS+VQVOIKY8jlh1KXwu/DYy2U4EgGa63H+yVjUPM8UolACUt5N7hO1UP0tdRp5msUGJrLCvBJQ728797mytKEokAcBFHAJUgFhY4qqHusQv3KCxRD5jGUqpZi0eV2PafGPk7rH46X9JKiUVp7vvgZQSeN1Aj66Lb+KypKVr6Q+xK6nPE8lcGrFCbIE4AcJMG2W7RDXnWSK8/rO6hRHtWgHJ+9AdDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1QK71bn+AbLncP9hug/0LrTeFF1y50arouKOUky+yg=;
 b=ad79eAoyiszXd1A6t2MMTrgRBhd3uoM0xSoUNhGdCqIJcA94QtqgjaPl+3Bg9q/wZQdghzcmnw25YQlrFYoeCJ2FnNek5R1mSBTj25+UQuHHFRaxIohuZiZ71EB/51YeD4KofgEUJoqstRyNwk5HWWNaIDHAogM2u3F7prxAclG91aP1NdVSS7qJGI1cx1K6hYdXW/p/oWuhHMwTJbZ+6x2xNpXK1MRULBxAptLBlru7QHjwr0mchgu6qGk9sM4WRj9u2VeAdZRJE954ySd8RPOtH2jfDgmWir/eK4OkhHfq3DsUUp+XCjSgHHE4kskNgYEZr4WUXIw7yiF8dsXSMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 22:03:48 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 22:03:48 +0000
Date: Tue, 20 Oct 2026 00:03:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: scx_qmap: Drop the
 compat code and fix a lowpri starvation
Message-ID: <ataTuzRFTRm_pax6@gpd4>
References: <20261019213221.2919481-1-tj@kernel.org>
 <ataS89RDe7vZ6nGg@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ataS89RDe7vZ6nGg@gpd4>
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e0cb81-08b5-4d17-a683-08df2e2cd9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q2BPbg62cHknpfpCEN6p+n24srfhToMf2yb60jYI9ZuYpJIv3+PEbrfR//OqMqxbqcKtZXFCOnUJeW8E7S3MJK8PlmJUGeGtoHbhoMom2yxlNo45tVbgSompNufVE1sOg7l9Q9AJOjFzgRkqCxsQgUUcGhCyOwIkU4sIJY4mmN1K5x+PmCccxOt8HNJts/ytM5REJOog4DZwmgttMLsAi4UtC6X0tGDM7AydCF5UVI86M0/Y8eNVwSMYDD6TZ6GquXIYVLyT0Qmj9vdh3ElSi+zrZ3RsVrzWsps/OszQ+QKPMecDrrRKjA4vxPT+l5Y0exRTkKDe4fcRfJR4umhrfgXBDyRENSAPrVTBlRNs6BNadqNyBMcPAiSWzQXP/loIFQS2DKs/bCQUm97itKxJgHLZ/UIFbssbNp4vPvHPOzdw1WGP3mXIuoMuxqxrvt4O9xOkgr9eVN3qmAwi17fjnCuNIeNTb7kKOSwq3fn73W47GaMXd0Vn/jQ6d5IBG/qsgy6+49ihypERlP7t9lOCDnG4v1tfJFe/sdR2cML2viLvS23vpHMQOK/txrsIkAXN7F4etiYQBaTkip7vdnImkVYgYlDnBF+hRxw7bo5qSXy6U+9H6moAd6emA7/y6RBIRMYD+iwawqFwrikFuN/hk1PACeyEQf5VK0j56vlsRX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OCs+L/9z79o1Yae2cLVF3ty8qucsYy70HEuPJp3tMeRawHsDyiOy2NKo2rru?=
 =?us-ascii?Q?y+xpiChgVvoiBwlyT39gauv5/V9LxOtpjpUm3nX6pSfERVo7t9ZJ7VBwQLMC?=
 =?us-ascii?Q?/HxN49m8/F0gaYgJY8a7ZGIkFVddm0hih9hiXSuTdcpKjHAYAZlr2hmoDV0j?=
 =?us-ascii?Q?9Vkz8FRkr9xb8cuM+1LNzu9xYOE3FkoonjPhSFV3A0BfMMVel7qGxsHPnwJ6?=
 =?us-ascii?Q?IbLqQn4oEbc534PzPhRD1ZZNN7BSveIx1cbc88rw25xHfftwksUlgJxKXrfw?=
 =?us-ascii?Q?DBTvD0tY9FJWcQUvuHX2+GGOSLi043YOt77SvnN9TqUAmpUjbjg5YrO81pPx?=
 =?us-ascii?Q?j+ymlbo0nODUpeacNrBv4ELkTBDTQDCXrawStxfG4bs4trvKL0iIuoK18HOp?=
 =?us-ascii?Q?V9AGHidsYnHER+xS4Q1XCw+J+TIKR0cGVfvNd377oMXi5JeGcNk+oU9ACTBp?=
 =?us-ascii?Q?rf4kghGu0AbGL+nlpa7x2+rSo8860Lvj3p4XwHC+egtf75LHp+74XSXORNam?=
 =?us-ascii?Q?pikHERTFng1vTGwXJtlXP+kc9s/uHBMy1G+uKnmB0ZHgMrntbEJ90D1g7KH/?=
 =?us-ascii?Q?nBtLDcPd7u8VGIoeooqBqHgm36GWN1uopeXztV1Immqch/VWxrVHG5hlBUMl?=
 =?us-ascii?Q?A535xbIF8tmFlThLKcZ0ue8AnyJNb99jnjsa8lcri3iFUGyugjMyIoWv6+VH?=
 =?us-ascii?Q?SVEU5r26JUaMwwzF8A1PJz3VicdpAdzlMCtvqXdYyIu45pdnBJ6HNpE3mj0i?=
 =?us-ascii?Q?qrLjIrrw7GG6jkmFoiJgIvBMuQW+GAFVRrzE2FDXQ8xmBw/wddtbtakKfm/b?=
 =?us-ascii?Q?obeVseMabPpNXRUXnJEfSUJQqzDZUtX2gxe8IL0DOgchOu9K/h28nsKe5ebd?=
 =?us-ascii?Q?zSyd7OMK2FjhF1Y3v+v4zQaIiuMyuMdgLYxArVgoee8zRocuIiT7KDwkBYcb?=
 =?us-ascii?Q?Y2VHGzC4wDDSa52kX45rRzUiVbQIHugjr23ADbon6qlXx8Pa+mwj84NCVYEo?=
 =?us-ascii?Q?Xzktmoc1eAyAFyp5USHalHv/DNi3xZNzG/9h6409SclTivSOhJBmIv7Wkc+E?=
 =?us-ascii?Q?GHLA9XrnDcinoYh/UzWBC4Y1oIbFgi7+S9d+BJrYkMp4g6ZiSYMrK8dL3lhR?=
 =?us-ascii?Q?CB3JK+hRKkX6tDO76dL0WdOo3TWqC1HDm1vimNaZLCbFNykju5V1Q/XY/NRf?=
 =?us-ascii?Q?nqYZNBdnoYTFwxbE3cfjBNJYSaihXeFYllua1ug9EHRhw312HPrYus3b2FAN?=
 =?us-ascii?Q?iD4D29EGfqa99uwwBqtPDIKeHabynYp4WdDlzer/riH9oTFKQ2IHnV2pNPm0?=
 =?us-ascii?Q?y8QCowtzcu6+XzdHXSr0lkMn5vYPgY4KquPX8ySTid3x9kVQj+sXEQVAJXA3?=
 =?us-ascii?Q?ueKI/Vqq5EVca7xPPs4NUyAcyfTuhuBwh2QNsW35erHHKixXCn4JLKkHqzI8?=
 =?us-ascii?Q?oTSgIz3wE2qXB+R0rOF7XHP4nOuctM0Z17sQ+leT6lFjdrwfvqlvFBklTQgd?=
 =?us-ascii?Q?TKmEsta48AtNyLUuFJXv9YA7/GJkUflKkPXmOuf9tYDtjUoQfJHHGgFJIk8f?=
 =?us-ascii?Q?tWLDZGUdIRf4r+vGAWElNtpR18kJdDrR8SPIpEe70qXYD6I7dA4IXo4t3l6V?=
 =?us-ascii?Q?/zZnpfk3AOyiBy7ss5e2GxNAKWs/HbMUIdZXUdhVybnM3KFikvf99lF4wxz6?=
 =?us-ascii?Q?79RPFKb2Dmvfv+KArpB2l6N+idWUbAVu8dwDmXvBKwhmdMzNIcAsP1+Ed/CS?=
 =?us-ascii?Q?OLExBlIf6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e0cb81-08b5-4d17-a683-08df2e2cd9f2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 22:03:48.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3TtWBRVNUruuX2HoOfx01MQY77JcZtQYuIlwwUSizRoDgPapW5bYpi+LqU7FjIRd5eopkkt8lGSdAzD9m1iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751

On Tue, Oct 20, 2026 at 12:00:29AM +0200, Andrea Righi wrote:
> On Mon, Oct 19, 2026 at 11:32:19AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > scx_qmap is often used to exercise sched_ext features as they land and
> > already requires the kernel it ships with, so its compat code only keeps
> > untested fallbacks around. The first patch drops it.
> > 
> > The second fixes scx_qmap's lowpri path. Nice 19 tasks coming back from
> > LOWPRI_DSQ go to SHARED_DSQ, which is consumed ahead of the FIFOs, so enough
> > nice 19 CPU hogs starve every other task until the watchdog ejects the
> > scheduler. They now go to their FIFO instead.
> > 
> > Tested with root and sub-scheduler instances under nice 0 and nice 19 CPU
> > hogs. Without the fix, the root is ejected within seconds. With it, the runs
> > complete and the FIFOs keep being dispatched.
> > 
> > Based on sched_ext/for-7.4-fixes (ff343a94e44d).
> > 
> > This patchset contains the following 2 patches.
> > 
> >  0001 sched_ext: scx_qmap: Drop the compat code
> >  0002 sched_ext: scx_qmap: Queue re-enqueued lowpri tasks on their FIFO
> 
> Both look good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Oh... and as I sent this, I just noticed a small nit, there's still one
compat in scx_qmap.c:

    ppt = __COMPAT_ENUM_OR_ZERO("scx_consts", "SCX_RESCUE_DISABLE");

We can probably drop this as well.

Thanks,
-Andrea
