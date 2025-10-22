Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532203491EE
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145433; cv=fail; b=KMVExPpaSgbEN0/yNyL9yJvgKvtz7fjYkETsuMbUPth+4ETi+6fXh49dp4lP6hU/YCZZKrFp3Sd66FXejwnfJtY5NSP5TMGB7ln0/wdXZG8FEkLZHwu1G3v/FWW3DrSEa/utjgLFLoWstI0CHp6soh6uaSPj/tb6StwxL+pus+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145433; c=relaxed/simple;
	bh=Df0HknJR4NREjLR7XwSnazrWVxKDv//bvZNXb/39l1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJ/RhUOn5uckGrLETIzKVlUWfOFYQQw1+ouF6InqSv3Ub7KxKsY+3bzJK/hDrdn8w3X5WZgGct9yzmvw6x40btHQexMssbWtal8vHi8jGI9zhKP1AY33RErdVjMgJciSFea8rLYXPKYt2elB/nMMLqZ3gdpbcq73rfvtjoICeLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bcoA2f2d; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcoA2f2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzlTbYM/q3oxx3nQLz5uCfCq9qrFf5PT1W+g0h1KhLn/B0Kq0IZVRDZ6fyJ0cq4oTf46TfusDGqtz+Lm6V7zinB2RJAvDBFiu+6VEczqSbO7XBijMOIggc+sZB9mQW4hVn10yhKKFwMwhj6e8tPH5MezOt0m8zAa/K58xSB24iea+GhHjni7NMy/zJ3uDyPLW869srrMW8KaIn/vxleXtxDDVh5rqvRj3Us/+5ALK/pnu8SNwyd/NusT06MoprDKDmyFjN7qAW8W0FEzn0V3UUYOdehanG2gbi8BPWIp5vrpp+rlnGKK4DWunuRGHya7bSZqMI7PzjHdVOgDI0MUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DIpnPBv3DK1HncYmtHMHj2awR6unRpfZs90BMMhKRQ=;
 b=ecr2TfIk2KVSxC/3uL1IHp052+UGPVm4k0EB+Wl6LbBTqoWQMmq7Ad/Y3sMvk7Aa1nJoHPq9ZuGkYWq2yWL14bgk4J+/aUx6uB8K7L3aLC9bixkRVpM9xMQscaJPJnL1Ahr5QahCJnJWojVyS8lxgq5JpSVl1dGKo2tpxIdg7YlOe1kE6EOiAu99CA1Uso7tZq7Knb/fq+M9GzSChAPD5tfpzLXk7htvSJU1DlsdkUHu5a2SliX4v2e+GjgpgX8+9vlwcUEXNHJHSbdX841l7RI7iVYHaffcg4vngvmaD1J8/L+kg/ALuoyllXRVik6BKe2KtRPOwuFMjMhZrkgf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DIpnPBv3DK1HncYmtHMHj2awR6unRpfZs90BMMhKRQ=;
 b=bcoA2f2dmBLLy7JXMjDCZ9fcniaRdddJtFNHpTM2LzzXa3voQ62mhMeNlg/K0tJrmuB++T+YICfs+nFwFIvx9pKKuNuHprx9Rbo5mxYz2hhww9bcOeNsS9J/hoGvKfkyLY92EsWcLghHFiD6TnZKVhwsYJTYqKr4+fBnm27Xdr5zLxUgqGw0HWQk1ccFUb8b/Yb8Dau018HMOPKCegPAzMB7DKKA1i55Yjy4XkuYtSvHJhiqV3lYOWRU/XwbG/sKHEl7WVsecBPIp/+SkKSjJEQ4yUitWJvNNo492LfkLPLpp2qAug2PJajzM+o8ul1rxEKwOiEII04F7ocv4pHBjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:03:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 15:03:47 +0000
Date: Wed, 22 Oct 2025 17:03:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Use ___v2 suffix for new
 kfuncs and fix scx build errors
Message-ID: <aPjyQsHoN62zEKOE@gpd4>
References: <20251022093826.113508-1-arighi@nvidia.com>
 <CABFh=a4Vn+FCe9DTLt_p7RzNBSJFU-he+OhNqTK_Z3C5NbP7KA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFh=a4Vn+FCe9DTLt_p7RzNBSJFU-he+OhNqTK_Z3C5NbP7KA@mail.gmail.com>
X-ClientProxiedBy: ZR2P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b09fe4b-63bb-4d50-68b3-08de117c339b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ok1Uwwz8RjEOhl59C/2I0QKvVtYzhdH2vQnT14+8Q0Jsm+rJy7COYX6zjBTH?=
 =?us-ascii?Q?hIcrzbrQSsKICviCP9uIbb+j5SSWg9dKunZBGH/22iHu/RqtQ0ijYnbEfr3s?=
 =?us-ascii?Q?8wJgrIGhypM4vVTj/TWICpOgqAAaI2flWzjG5MX281xhe30+Iw6jzSXz9G5i?=
 =?us-ascii?Q?CIxzieCCeBrXl8hreHZ81Y0drXrT4d5F/m5Md6xnzhExd0I9eiuujrRjrRbw?=
 =?us-ascii?Q?xoXPCB1pk7ouwYzvyNnzQ0W0j7X2Ir6VXbMNOKuViZUd0iILj4Y9ySpQ3I2i?=
 =?us-ascii?Q?7YtxjynQgi0JC5D4MQvylikKNlLVWx/ucc5E2BEo0POiLTKLKlm3ewBHEhR1?=
 =?us-ascii?Q?8Wdtb7xbg2pf6WFS336GQJbn+QYXaV1VWgbahUrPzQSQm5DzVLq7cLRdmNBo?=
 =?us-ascii?Q?mQQyVZWEh47vfnA8k6f6/Eryo2vPLvVeywma1W022zpU0qjqIk5gr0Cv2UtE?=
 =?us-ascii?Q?OSVZB9Vd9yoNKcuRumMpNhVOtp/kkgCZJS1A6NLwzquLW2Eo2MHsNZwKh4jj?=
 =?us-ascii?Q?PF4egc2iYgZL9A9OVGpi2mqbarRIucWaw8IHFNiJeadKxDknJqaeWcsJrk6V?=
 =?us-ascii?Q?YdcL59S2/zJhvrxJiV8fiwDN6h70ERZVSZ8++br2hgNQRaSVa99qLxWD5Avf?=
 =?us-ascii?Q?UM6jixtnrh3LhqoULk4HOUBsiBQFvuqyzEGJ3Uf3MJ/6hvFdrh87/WT5GjXM?=
 =?us-ascii?Q?w1pAupk0xulgN/A1HKI0MkrsUod/fnzjZbPGbQVOWJn6hlC9b+oGaSmTmEu7?=
 =?us-ascii?Q?WHyey846nWS37CSjjQ6BYj1lipDNdh9ebLOSvwwG/f04g0lqNAzPNxFK0W32?=
 =?us-ascii?Q?yoVw5YzWpPkWQGXyocXMR6pUh03wsnUVlHN2DEMkt7dVrq/tgOEGyo5A+36N?=
 =?us-ascii?Q?XYhdr9rB3hAbYvNJ5ES/c71Fix9OfwK3RAcWxoAedq8MqMtgVSRUeuHoXAiC?=
 =?us-ascii?Q?wS0GIiGj0NihxWRipHM4Y5DHNCFYfCQxfldkt+uH5YSd0/UVeomkRyq8gr7g?=
 =?us-ascii?Q?5LEuktpZ/t6m+UWVxMD6/VyBu+xLT+FRkgCTSFHWkiZeNGmyDrimwEiXvcQa?=
 =?us-ascii?Q?sZEk4+xIsOVFanqxf4ehu8g49cYr7jTZsfH9z4ZUutbru9tGFCyHME0o3fbF?=
 =?us-ascii?Q?r/LtWglNzJDWBuKtFYxS0sUbEWsOLIuZkN2DGe98IxXaCTCwYHVpK77tM/kB?=
 =?us-ascii?Q?CHGsX5j7VwFmWhsL4dtEFf0jy1iQCLQyAERuoCvNdoiawd4GRKXBMiI+sX71?=
 =?us-ascii?Q?QlqzNtpZ/QWhtGNdDlabV44/gcJYWCgiRWTrX3uuhQj9/dxZbOrcCL/WVX66?=
 =?us-ascii?Q?t2lTZ1aRL/6tC1tC2i0IgIHbcZ4GRRh5O66tawKtPeJjKmB6MFHX1AB5hjd4?=
 =?us-ascii?Q?3s2kBmY11PmtQwTTiWrhdpr7++fGVfSlKaILhTPLKBO0Qh2Hjr62/E2JCxg4?=
 =?us-ascii?Q?6x2S1KNZvkDwMs7895TyJo+coc4ynXfJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btm0cVapVvPuzHJaHWmWG6Tmpe9t7eU/RF+kT/kFg1+Ad3mqSZElaYiodGdF?=
 =?us-ascii?Q?48E7xZNB1McXWufnkNJQ1Z92ZbffPBLTZmDWyc2Vzqa2wbFhaKP7Fmkcex7R?=
 =?us-ascii?Q?S8uWA4ec5SVkMjvoDGm4GuuXYD6jZ0cSuZYnV9Nk79XH/IKz11fIBNfSKSG0?=
 =?us-ascii?Q?cCWvq3be2re/as6nFMDOxQ4H20jbqzaZFaNUlSCZHhPZQ/oAI7TH0n4uTl0u?=
 =?us-ascii?Q?/+ghcz1Kw9O+iGnnuHy4SiOrV7O0jZu3pXhmvRhtfG9Rf2PMzsZWEJygv0Rx?=
 =?us-ascii?Q?WWTevd0PfLvT60mPC9w/CJINhYbcA9cYZWxG0IUyrcQO18PIKvtffD8yTp+o?=
 =?us-ascii?Q?bFiHmNtEwEDZXZO87eCqpQdDkGbLwM2NFj2ISBdBSLAuIV2odRznLP9GdZnX?=
 =?us-ascii?Q?i54il0zGciqry0Lr0M82OCqve+JDAHy9BC6BTrf6GnOlwfwdL4YiFVpzf2cf?=
 =?us-ascii?Q?bsBFuCWBg4HPin34LiS3Ohd67ySZbnyH6EWXuNpZ8hX/34sTY5CyRgf5vfMN?=
 =?us-ascii?Q?R1Qs4w7D5uAxqKrpUcsGkAuqnOvoox/Uf+aqQu5uJsukFUrUv3yRxZR9rnMU?=
 =?us-ascii?Q?Hr/Tqf1jdQGN9ZP7lffvJN1t9y864Crg0KpGLTbS3JOm/pNXXoJC+DvkHHbV?=
 =?us-ascii?Q?STW9nOrG4PQ0Pyc6gyFjXU5iClsj1nBPXMKknCzRMPJScfsjFxkiLQzWYmch?=
 =?us-ascii?Q?yx4FDtaJeCRW5o+4K1QyNIoUAnLHrweRRBDFytHNByrsOzivDJTA2ITN4yor?=
 =?us-ascii?Q?/iMGZWILtX6fBorwBnMu1hawPb2/9n3HWAwrfHl8UvVJmwhJdPbdSjuzuzDa?=
 =?us-ascii?Q?phYEeB/d+eBHemfJ01pmQ+JzUPMPZMekHjNeKPg/kyaXLVczZHLYUUD2j/mu?=
 =?us-ascii?Q?NDHVtfrRRwyZLVlNPuTdZ4WMUDf3hXvRaBgt5bm3TKSfdNwYP0SH5AQ8CKFm?=
 =?us-ascii?Q?oEf+JTc9cy8c2KZ5W3rLXP+EYgGE83Yb76aDgNKOwHdn6DkszqoDcdzwTKuz?=
 =?us-ascii?Q?AmSPqdOGijbviV028vNo4UfAmOfPEQ+ND0Z4AbsH/am8hTJKB5baQw797AgK?=
 =?us-ascii?Q?mt67O91b2+7rntVoAzpKhnPg6UEDvfjZdM6MHGAs2z09P+YqIfHQELWyXiol?=
 =?us-ascii?Q?Jiahf6jAko/nNKmTRlgRaQSCuKY09mIRVSueO3rjcliyWbOvFD9zG4gppK1s?=
 =?us-ascii?Q?HwT29mGYf3TLfdC2M3/Mv730sh5UxVJKeYFeawDEiqGnBAAP5/tzGx/9ntyX?=
 =?us-ascii?Q?l4yz2a+0ZfPeKNMj76mQxGn+uoUHwfQLkhY885fbGBvWLEqx9d//tLrKsqBK?=
 =?us-ascii?Q?qCKt2shdTlW4kIPvpDQg92nfFaoGFGRWV33fHnnRk6jkpsbLTJX3MNmriDFn?=
 =?us-ascii?Q?/kmLKmkWVsfBGueuak/I9wmC42KDRjiPfE25hM+fY2/HtYHldD3l/FvPRt8m?=
 =?us-ascii?Q?/0N+YWCqiniMOkY0WbBLbCkOnKHya3waXfgajuQwEcNP9pKTkyuvH/dk/Igr?=
 =?us-ascii?Q?ZaQrA5mUhxEfJ4mGKOT0p3/l7vMfT5R8rSj1Xj2oiNsdxp5j6VKucHNa9WKk?=
 =?us-ascii?Q?/WDhoucpsKLzy7pJbWNIzH4TMQWVxOpLNk3g+BS4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09fe4b-63bb-4d50-68b3-08de117c339b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:03:47.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piywjxj6jSoFAztuJZ22o5oPpE3trHQlc6TIRqsnVjE4dOkffYjLvy/FYVpAfmNzWx8iOBj1AwrGrLhMv9iHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590

On Wed, Oct 22, 2025 at 10:44:02AM -0400, Emil Tsalapatis wrote:
...
> > +/*
> > + * v6.19: Mirror the following _args structs, to prevent build errors in
> > + * kernels that don't have these structs defined yet.
> > + *
> > + * The kernel will carry these mirrored structs until v6.23 (see below).
> > + */
> > +struct scx_bpf_select_cpu_and_args {
> > +       s32                     prev_cpu;
> > +       u64                     wake_flags;
> > +       u64                     flags;
> > +};
> > +
> > +struct scx_bpf_dsq_insert_vtime_args {
> > +       u64                     dsq_id;
> > +       u64                     slice;
> > +       u64                     vtime;
> > +       u64                     enq_flags;
> > +};
> > +
> 
> This redefinition seems to cause compilation problems when compiling
> the selftests on 6.19 w/ the patch (errors below). Turning the definitions
> into declarations gets the tests to compile.
> 
> Maybe we can gate the definitions behind some ifdef? This issue aside,
> compiling the tests on a 6.17 system and running them on a 6.19 system
> still works, so everything else is in order.
> 
> # cd /linux/tools/sched_ext
> # make -j9

Ah bummer, yes, we can probably put them behind an ifdef, let me do some
tests...

Thanks,
-Andrea

> 
> In file included from scx_simple.bpf.c:23:
> In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
> /linux/tools/sched_ext/include/scx/compat.bpf.h:170:8: error: redefinition of
>       'scx_bpf_select_cpu_and_args'
>   170 | struct scx_bpf_select_cpu_and_args {
>       |        ^
> /linux/tools/sched_ext/build/include/vmlinux.h:83614:8: note: previous
> definition
>       is here
>  83614 | struct scx_bpf_select_cpu_and_args {
>        |        ^
> In file included from scx_simple.bpf.c:23:
> In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
> /linux/tools/sched_ext/include/scx/compat.bpf.h:176:8: error: redefinition of
>       'scx_bpf_dsq_insert_vtime_args'
>   176 | struct scx_bpf_dsq_insert_vtime_args {
>       |        ^
> /linux/tools/sched_ext/build/include/vmlinux.h:83607:8: note: previous
> definition
>       is here
>  83607 | struct scx_bpf_dsq_insert_vtime_args {
>        |        ^
> 2 errors generated.
> make: *** [Makefile:176:
> /linux/tools/sched_ext/build/obj/sched_ext/scx_simple.bpf.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from scx_qmap.bpf.c:25:
> In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
> /linux/tools/sched_ext/include/scx/compat.bpf.h:170:8: error: redefinition of
>       'scx_bpf_select_cpu_and_args'
>   170 | struct scx_bpf_select_cpu_and_args {
>       |        ^
> /linux/tools/sched_ext/build/include/vmlinux.h:83614:8: note: previous
> definition
>       is here
>  83614 | struct scx_bpf_select_cpu_and_args {
>        |        ^
> In file included from scx_qmap.bpf.c:25:
> In file included from /linux/tools/sched_ext/include/scx/common.bpf.h:765:
> /linux/tools/sched_ext/include/scx/compat.bpf.h:176:8: error: redefinition of
>       'scx_bpf_dsq_insert_vtime_args'
>   176 | struct scx_bpf_dsq_insert_vtime_args {
>       |        ^
> /linux/tools/sched_ext/build/include/vmlinux.h:83607:8: note: previous
> definition
>       is here
>  83607 | struct scx_bpf_dsq_insert_vtime_args {
>        |        ^
> 2 errors generated.
> make: *** [Makefile:176:
> /linux/tools/sched_ext/build/obj/sched_ext/scx_qmap.bpf.o] Error 1
