Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA09348C56;
	Mon,  8 Jun 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935820; cv=fail; b=bZdTwKBkGsbvMdPOpc7gGXWlXFxo7ijZSwaun4yT+b191k7t2k+U1OKhTUYI8yoxLusmAswc8e0MuBXBqPF+Yq2nzUHq//cWQuTuLbSlS9dbppFcWH0zDkzH2AuBCXZywO3nz2yhx3yVTMWaSOnENot7XngWtGmJD+PldtnXF64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935820; c=relaxed/simple;
	bh=WRtEtA2wINU0nPhNddH6TwVO12qCsY8VD/f7akdwM5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=trI6nUDLnnzWGWQhEpmKlm7UDxs+yzXEkRsMW6QNI6QP22csi5YBUr0bbVUNe2/GAWg5hB0xwX0iyevZf3ki4ZoJEKb/PAOQ4rvdujzRCMQtx/Gppt4cXTcLIZpw3pgNkgq66mw9ByTzUUAAuRI37yufvTYr4Iq5TPmKUjZzAVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bojdYGdv; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bojdYGdv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDldDqIequvt9P3Z2xVSF7SCB6ahb6JEltKvMwRipNLmvs9cCeGFFchgp+RIShooYompB/yfT5ezpb5eXZASbv9/9VJ5GK1ZLCNfr9U0vm7lyMbbSzkiAH3Wlhm1E38AeI0FY2UN5/S2jDhFgprngTwFbc2vS488H+gudOpSHKHNMx3K22Zh9d+6lcuXdCZhjhY1FVINDDFnO8P8yAhwuULmhntm5hj2YboKezmlr2p8c+knsqWw/gOPARQvidOTVioPYBqCYDkpOhYY/6spFgx4g/wTGq5ydCU3lNBoICfg6MbWATo+Y2GHd7johJIWyGrM4kR2fq63sRsPQvK+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRqf9qTKGg/Tla4wAAQXRLYO5QMS92LP1zjux7JZIdM=;
 b=Eakm+9XLjDUdKOQgpIqbuKgcNc0wrqiBFM4S3M01PztLUCO9PC8+T7syy/pOuVj6Fc7PSKpz3XCwhGR9KMCRKyl+EY+KbTrxo0fQYwRllISem4dNCs+Avy+fxZyfwLZY8zNaTMKkFTFKG/Fph5g3APfP4wLQKqPo8hCJj/Md/drbnHLpuJlr5/fSxl8R3C1Gg2+slau428HxzjSBzwjrNvf6eCu6TwJLyqaFbi8L9LGmOfBrqsZ7dUQ0wB1Tr1csMeN/XqkD8hEz50YArGzw5BHh0pwu/TayAG13yvSEom3eM3f4Qo1WET/u7pxY3FRyd/dJsbt+NdcIgeHOZRSHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRqf9qTKGg/Tla4wAAQXRLYO5QMS92LP1zjux7JZIdM=;
 b=bojdYGdvsbAZhHXPevOnfmgfT3kyGvCRaCa8yWmdMgqzy65EI402uZKm1VzAEQlcgZj1QMgoMoTGXjtS138xEnBL3ppfP3btWKJBC09Yp4LVc2dXCSitX21B/cC/Ybh0b6neDLppcfR71c6x2SIeRL/KOU503eL/jhsaLwld2NYjZwjR9gPABHv74PYTVnbpBGS0cM35P04qb3BFs6CuQIlltsrNylIY9ii8qwYSqr+4EEoFwnCWnFXobN8prBg4KzmHoPzv611UkjV3SpvoMglFLzChfDua7HJXoRb2WDhNKxIbJc/WDa3cTBEg7E9Na9CBoclrRasUY+B5f78zIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:23:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:23:33 +0000
Date: Mon, 8 Jun 2026 18:23:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Reset dsq_vtime and
 slice when a task leaves SCX
Message-ID: <aibse9eipMHn8Cb7@gpd4>
References: <20260608134908.3232097-1-arighi@nvidia.com>
 <20260608141112.56A621F00893@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608141112.56A621F00893@smtp.kernel.org>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: c6533f9e-889b-4354-9db2-08dec57a4913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Pej+ueW8sKLz/UkqGQRnfwxA3IlPzUZZq7lE62T++z+AnhSVsUN9uIdSwbdbjTQZavYL7o1J+9XqhREAlw8TWcZ2sWbz2yH+4TbWVJ4U+2tXkOLWH3CbAoTjUvQEshGaGYdNZWN7UGseoyoEWuTBbhq97TDEZdUH5++stWTUCKyh4kJX/Or1p0Lc71CfesrmBqkKWnxKn0E4o/n9IcQkNIVZqaLfnXLWj/bcV6+HAXB02XHzCna2CWqVCz08pG66yjJMMHeTVzgCe5rDdTVrlRpVhkAvS2rRqeUA7TA2zOARefvJ87KtpHubzz5YhpD/iGm1Bwn7lrtTAJoO1zhQMp7Nubys4Am1l9vAmrZP7Cg4U+6/ShAsZzG1vb8/ZaLlCxLzpZgILR3IsfgraaE4GK7OchQjcfChWTZ+EGLiB5/gElFcAv4y6re84UT2IcBXY6VBbEXNLTxGeOMbGBifHCMR5zvk2rswq8KKUQM4u7drNgCKPepk26pGVor0UzPeLM8d0KjRGu8341nFv9NaGpyzCb9urY4m9vYPZtWXrBufqHy5SkklrVfNV33VaJcHxnFNrxUm1hi00VJt6lJ5HMMdUpNgbaC10HBar8gv8t+XQYTkXWUbzVtJeCoUgEeb4vc0A1VZe1afVwmCCiW1evZg3XHnKqtW2tOlcxwqTbkxU12zdyV5P96PBHvH0LyS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNl2+usktJ3xnDikVVreaO30w9qf3SzEYEhY8r6HPL8GNGMPPw5m1cLV08gS?=
 =?us-ascii?Q?sBjSsvXavd1T9Q6NTBT1TyDUBUQ5C3nCsCcnOyOJNbCZryFx7jJK3XH/BTXS?=
 =?us-ascii?Q?3cRSRmyADzf8BR04FRgzOtC4mdRrMtIBSPKVand+AikyWClE3v3gazEaRlyt?=
 =?us-ascii?Q?LArxQXDxs6LAXVGHCABJZrKeexuMxCLWMd1N1SyrGRVudhSOmR/eiHHQFwNP?=
 =?us-ascii?Q?ytpC/tIOyL3U2Rp9cpR63DdcIIlpor683hstLYD/gVQomGhURo/G38b4be49?=
 =?us-ascii?Q?OnPT8GwyQkYAY9Zr6Tf16CKSWFqnQcBpw2A74zAmu8P4HpdGq5j+uGkVcxpW?=
 =?us-ascii?Q?xEIYR9pVS6dh2iWXQdI20LS9HxV6cBGVQa+Ad3dbFv5S6zSgvo+aRR0j8GeJ?=
 =?us-ascii?Q?0azhe6HUv22m80a4szJAEZfgh3SXh53c0WAR7CZv20gPmSDkasFZOhCCVW6s?=
 =?us-ascii?Q?xta8J8xBSsXsE1VCAb+UnFjy+H4LF2v2KmtDHrRkXcU71DvpUjo0MZ0CyreL?=
 =?us-ascii?Q?sdOOcoFWUITdvdyuFybsE64X5x8vF/OQDnwWcDSt7QO4FT/PNjdFBODC5X8z?=
 =?us-ascii?Q?ktW85hKjwHlANjy0C1+WbJ4xgcIcUxTjvXPjwESlGcBx92JJBmj9/wuS1IjB?=
 =?us-ascii?Q?QXaJWnSAMaRx/BtXESX1Jgl9hWe1HQEUMrYQUdsIqMUH09llM/G/+tXSLuM7?=
 =?us-ascii?Q?Zeuqa/a1CrFTFdDl9yyysZ6epZpu6YOs2vgPtGFBtaEARksLk2E6a15DGI5Y?=
 =?us-ascii?Q?6VEw0gNwTC0ft3qkgd2qy+xnshrAH0LEGuPGY/zzxDdTaKNUi0FFME/nNvyb?=
 =?us-ascii?Q?D3q05TBcJHsE/Dj9VVBr4Het2udIBJRvIWH6wPwCiSBgRYjAf2ujQrQT6Olv?=
 =?us-ascii?Q?TufqiX4nyt9M6aqJA7aoEHjKgAn5K/HwGUVlIT5/y4rBKkUh3iqOPUCT/RNS?=
 =?us-ascii?Q?hQb7YjYq3zbLBtSUzpAeBEgSNkYNytwVUwRwF0oVxLUBUrrABeuAwn0M0LL8?=
 =?us-ascii?Q?81V9K+agYVJKJGiVgVamFHcpqAiVeVZFed0wy1dpk8dh36BVxzL9mQ/VAOLy?=
 =?us-ascii?Q?qOg2JmkZ/wnONpBYwiFqlMHuUx1zZSDnlvhCa4lCoBi7G4lICOKy+w9Ht2T3?=
 =?us-ascii?Q?0lhpU25U288QNmy8q7gUaf5RVECsjA1IZeYniw8HPIKPo79j5sI44KzQfVmR?=
 =?us-ascii?Q?tGmlGnwMGHt8H/xXyVdBOIf2UBjCZgCZk1Y5La93zoCbVX0LuW4/FFSSnIU0?=
 =?us-ascii?Q?Clp4aviMGxNc+g+hW808LG0Nekf0nCHdamO+kYWSsfVbEnJBkHhdyIeQ/0LT?=
 =?us-ascii?Q?6t4yG1478HKUJN/phLUrYOHg8zx9rIxryw6OBmqtrZkM5zOPMPDN0UC7Rmd5?=
 =?us-ascii?Q?OGahkWDgEa6N1L0MF70HDTZum1NXR1XdkQ+VCqP1WeubRHt6rTR9Ic5JrPbm?=
 =?us-ascii?Q?dL2q+gJOzKcRRGssszEZi9IwRbXuk4IIBw7J5WI9wvsLuWqlEQolaUCJjshB?=
 =?us-ascii?Q?ZAQguQlqpMGBoWrH6Yh1tVRbqr5/R8MIwKFwyBFCOs0eOnX6N6t81aw34D7l?=
 =?us-ascii?Q?tE36LcWH1ct3OKrhYTMUs+rVx5T7AntZQNhroW0GBAoGLlCLYO/HEAmCSaBE?=
 =?us-ascii?Q?cGYPX6IOETQv4UNlB423gbkyUUcdMIXlGSUcrlHpcXu74Q9qk2fW5f7OBS+q?=
 =?us-ascii?Q?rR1BwG7kDdB0yLAAR9wvFYRyb021r6cQ+B0MFJIITfG3T3dM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6533f9e-889b-4354-9db2-08dec57a4913
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:23:33.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXPpzltIZ7E9sA6hKo1HCff8byQmVfBrYOisRIYvhYVsVdrD5MznKkNl62ww4ROelLnv4zSTmRooidIb8Ifd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

On Mon, Jun 08, 2026 at 02:11:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Tasks returning to the SCX scheduling class receive a zero slice, violating the intended baseline and causing immediate slice expiration.
> 
> Pre-existing issues:
> - [High] Tasks with an explicit SCHED_EXT policy retain a stale `dsq_vtime` across global BPF scheduler unloads and reloads, leading to corrupted task prioritization.
> --
> 
> commit 7f8eecaba1a8e23922f489ed563df593e55f3478
> Author: Andrea Righi <arighi@nvidia.com>
> 
> sched_ext: Reset dsq_vtime and slice when a task leaves SCX
> 
> When a task switches out of the sched_ext class, p->scx.dsq_vtime and
> p->scx.slice keep whatever values they last held. This patch zeroes
> dsq_vtime and slice in switched_from_scx() after scx_disable_task() so
> the fields are reset to the same baseline a freshly forked task has.
> 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index bd8a3332999f4..38157af00fb77 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> [ ... ]
> > @@ -4097,10 +4097,11 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
> >  	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
> >  	 * NONE -> READY validation failure.
> >  	 */
> > -	if (scx_get_task_state(p) == SCX_TASK_NONE)
> > -		return;
> > +	if (scx_get_task_state(p) != SCX_TASK_NONE)
> > +		scx_disable_task(scx_task_sched(p), p);
> >  
> > -	scx_disable_task(scx_task_sched(p), p);
> > +	p->scx.dsq_vtime = 0;
> > +	p->scx.slice = 0;
> 
> [Severity: High]
> Does zeroing the slice here mean a task returning to the SCX scheduling class
> will receive a zero slice?
> 
> If neither switched_to_scx() nor __scx_enable_task() resets it to
> SCX_SLICE_DFL, it seems this violates the commit's intent of restoring the
> baseline of a freshly forked task.
> 
> Will entering the BPF scheduler with a 0 slice cause the core to emit a
> warned_zero_slice warning and trigger immediate slice exhaustion upon
> dispatch (falling back to a 1 nanosecond slice)?

This looks like a false positive. And I think it's semantically correct to reset
the slice to zero when a task exits the SCHED_EXT class. I'll rephrase the
"freshly forked task" part, which might be confusing.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the approach of clearing
> dsq_vtime here miss tasks during global BPF scheduler unloads and reloads?
> 
> If tasks have an explicit SCHED_EXT policy, they remain in the ext_sched_class
> when a custom BPF scheduler is unloaded. During scx_root_disable() and
> scx_root_enable(), old_class == new_class evaluates to true, so
> switched_from_scx() is never invoked and dsq_vtime is never cleared.
> 
> When the new BPF scheduler is loaded, will these tasks retain the dsq_vtime
> from the previous scheduler, causing incorrect sorting and prioritization in
> vtime-sorted dispatch queues?

This one instead looks legit, we should probably reset dsq_vtime and slice in
scx_disable_task() after ops.disable() has observed their final values. I'll fix
this in v2.

-Andrea
