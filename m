Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD836920F
	for <sched-ext@lists.linux.dev>; Sat,  5 Sep 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636370; cv=fail; b=W9iOdThlQwgYqedtvhep2ZICY53rwpnIgyCu4uNZ7/nN4XJZmHBAOwZRSpbulYG1jeBVPfiUUbHiH7lsedxsUQlTH4IOO5FUjSYYTWqfLJsCq4GAtQRRECc10JDBzlTTNMKE35fdnS1QQf2XVhA8u5sLC3WWYMWOiyQBiNhULtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636370; c=relaxed/simple;
	bh=zhqqIqoZERWh2pG0ZSZGE+LI5ca8OJVXdDp7++A2hDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJY6aOEiT2cjhEgp3GKNSyLUIn4yUOIFN2mh5KhkQva4qfEHDEIlQ3YCgnx7WpQWZ15zeVhzD0AyVspCH0eqXIeVIvTYsqn11mWZSaHHL9/TYHhUs0b2kVMU3gCSpLfl4Zi0V98vXuw3dYbGbQow5VJPdGZuhu48EddxZKl/8W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYLs/AGf; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYLs/AGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYPPzZ/bdYdUIg7Qq0D07gxPQg3H3ywM9aXao7abPbW+SpkKHkQlEGc/8csKU8BFKIDytBTuUgeblbqP029QPhoeG0qIaZhzJh8cIXxpnM1ifFL+R73TJLTW/+xxFHqmjBjcRr+hf97pbKAB8H7VtejWp8X+OvuvrOdbCr88EoSeXZMtmZtP5oNJWWfz7tvdfb/WbbWej3AvZltZs/bhZt7veJoGaXen5EdpTdrELFtpga/rL7A1XUiVPnEe+f04FdRLCVxMi9AyBLke0JHr7+MYDglMo6/hRGEQycNjDlTYZBx/I50zgjogO4sU+v8K5/esn4JW9C+FADctn62E9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7GSbWhZijwiE5AmOc4JyRXCgK9zYCjgwSynMAVUqoE=;
 b=qeTPJTLQuatQ4A/Vv5xvvWrL2r9YQHsQzewzGR1UTjlRF4oHm+zi3N+bJgEi56X3IfaShkthgkeTIfjhdgMhjkArQ9tzWNDM0wr1QNlTv/2FCIKrM1GiQe2O6kQj6Jddm38uLTkGbegGWHZk4AIrbbmFCdcxN3l8AbdC18FWx732vCtHQXgEUQwPHhM1FtRvhLkhmxiDcngsJuKwxUQsFUKuSZZZ0wPqsriN3i6a/eKqCcnlvAEYBxxON0vZwzGiI+f0MdklpSSK8K5NGzS9ke9UtDhuL4T1inv3qY3KYx9moUA/MlHEr/C5PV9gz2afqwYtprGIwzw2/ziPamXQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7GSbWhZijwiE5AmOc4JyRXCgK9zYCjgwSynMAVUqoE=;
 b=sYLs/AGf7EzArtmz20mEiifN4uE/tYIrYg0w8hYIkg85sVg82Haa9oOeiqgT7ARWrIKImCkNzqt/KTLpP09uV77ZCk5NLDhmu49Z6dNQL3vY6SzSh+KggHChVlc9fv3Z1L0QxLAZWtnbhK2jwchEqz1cTrLmhhwM6xw21mYiGRExJ7YlKDRQuMXubFlXKRDgEEIfCzs/HJZnR+X1fOZfvaWrxsRBH+dnVtJZI3cf4CLNdhi2PIOJa6U2Y34vRGVrOTRN7pDBinH9BoYNi+ZURJiN3BairwTm0XNjH7bWMIgpuegjouA10sSlqCgnzbgDa2/t/+/X1cT4mhUi/bqdNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 19:26:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 19:26:05 +0000
Date: Sat, 5 Sep 2026 21:25:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix keep-last for
 sub-scheduler tasks and two scx_qmap placement loops
Message-ID: <apxsw4KfJifR7qJx@gpd4>
References: <20260905160958.1565156-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::459) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: b67de1b1-389f-451f-3219-08df0b838758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c70d14dlMq1vITdUw4eiQQlMyQb6secMhNvLNQ/5F5OCszlIO+4NoPUfAbpbOSqSCWv7yDKuBPqqgRw2cnL6s1Lb4Nwb77Xm3lS0tYdPXTiWYlJM0G5P6GUVBbltdC3JBpw6xfeXDVQCO2gvjR3u5OyNSrA87othFkalUgDnuah446A5SkP0teDVYjAd0kKOlRnajlygWZano4lizeZr1LWz0uxh/S3joDR3mU/M25dFZh+e0WKCw/Bl02smSWWg7NRMJKDaGI2ASateEaic3Dx/KKlkVc/dfsUmufWmT8K9PBR/9ol4c1KFY8WjYovGqyKwAO2BdBPwB9boA59T3G59b0L/ksbVpq4QkjtfCyaDTbh4WR3P0i5rVUvy7bUXMVcO2m5o+Co0/RJ+H8ZQ1tNORcxfC5zu9hTuY2KnY1XQ+slSGowd5gIzhUx5+PdmL23klHMwEY+HhTLVICHzMebxqU6bQTZ/fCteN5aasop5FLyMivzJDLMPdfdpG08q5TOosc24fiqf18udYb7pNj0578PdK6MG2Fd494cXpVUUmRr8g8Se3EStMvoJ+a0GqimYB+8+7+lKr8qp6AyB3eFHZYMKUUNxV5UHpqfvncjicQlMn6LkwUQOcpdF7jGFhbjw4IDZpP2ZRmHqtWqlFmKNR6Uty5P6cdGXC+5h6pA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bd7cqes9aiuyulK3biSaYDzt5FFtYG0NsARy6AgeB73xLZU2IwwXFdYrSlhg?=
 =?us-ascii?Q?vA+RKjikMAY23WdbODKl+dlm4xrDD+Jqb87t2maLV/xJeDszrTy7dJ0wvYzC?=
 =?us-ascii?Q?vS46WApkAWqdwx6YVgapC5RFG48jpi6gD32j0M1g03bH8VQoTx1llw9ct3/G?=
 =?us-ascii?Q?8H2lS21LOjlQjY39XpJHj9hBL1FgRO3LLcbq22zpedtRSCzJo0AgfxFVIBzy?=
 =?us-ascii?Q?SfZ36bXZ2jXAkLRD9cURtQWjMVlIOwNlo/FuzUHsynRWzBrmT01qTua15Y8N?=
 =?us-ascii?Q?0F2h05MmGMXXwRLvP2CRETBB//BJgJhpxvoOfZ6jlACEQZQ96969lpnQjTV4?=
 =?us-ascii?Q?hLqbD869OMtXh1OTs7aJcXwVUhWf8suIqYGE8ONg8+AYs0oeqwRe0HCfVwqh?=
 =?us-ascii?Q?LlotAp5GaFiTo8YvatgWt4/+K0j9L+/k9a6LoNL4vo4PlAjii6a72I4ZRtCY?=
 =?us-ascii?Q?uMaXn8ae2sKqLud4ntq0RnXJJxgVVC960yQ8MecYah9pJ+y04vmkL9w8W6zw?=
 =?us-ascii?Q?ZWpdKbLftZ8QQ/Wn4olyJN0fyV6Rc/sAKYoFkC2RqWKSrFC9A1N1C5tYzdED?=
 =?us-ascii?Q?NlcJCERPPKy8B03/nlgqayWvetqXqqr4bhiEiUsTCDBK7DYjhFXnCOf0QuZW?=
 =?us-ascii?Q?0cqquV5m0k9EaT9GeAVV0Km84e+fNcY4EjnrSuUrYNv+oi2WhAjMGO9d9Pm9?=
 =?us-ascii?Q?wzeWuSqPJosrnOIQ0OLpB1FNJ+oPW5q/6z3gDFKuQeLzBNt1N65YLpKJp9oR?=
 =?us-ascii?Q?7uUQ4dz89GDQwyIAysv3FYOdJlFihhaQirMm9IvC79AFHVG1En+V+dL/z11g?=
 =?us-ascii?Q?LjFvXoulg7ceARzw5aiZVJ73uReXLv79GLMWFHH1vnkr9mYVl2fEYMsBbrt5?=
 =?us-ascii?Q?PH6DUj8qSacM3lf6C8VE9niggpTBEHAmtHFX7Yo4M2oyADFPx+VNB68nUAQG?=
 =?us-ascii?Q?RMsRvjFjF489iLS25Rs5Y30jt7LtbTJLBvonWtOVBzEqa77MyqXqz0gRTSUv?=
 =?us-ascii?Q?rHUcHIyPmN+LxDpxsapjVomnjJyWAzfh2eF6WwTaIu6TYyNk1Ui9IFAihmEK?=
 =?us-ascii?Q?zvqcpnkq23+52U+aIj9PzT7IQAJHxHhSx40641ZEDL6xZIuaL/1IsEg6Y47I?=
 =?us-ascii?Q?Gk8bmZJBtuyHhzozk/XkSJi76caWvn/G9JGogKCI7mlBfOwrq0xlSRlqt3VC?=
 =?us-ascii?Q?ANW5iMvBRidWNTfgo5CFdtFFAdoq0rhhxzQBhoUk1RGqLLuJu+SdpVjttDR8?=
 =?us-ascii?Q?IzvLvVJnY/oPdJDXT1uS7YVsckA/i1sP1Nry6EnYowN3A+zPvTozyA3HNjme?=
 =?us-ascii?Q?M4WwKlBPT5GwrZudmWorB/T76vNrq1IkAmniP38nsB2nRR0eznrNElhwKgYl?=
 =?us-ascii?Q?aSejoRNX8b9HJbJAgUSVN81j65fsXV/Vl9Z8AdPEZdjzvOIdMhADaBuQGfGn?=
 =?us-ascii?Q?30YzFYToNPdPkX29muxjoA8UtY623+u9HOrRnzE5ZeMPEpq5wPeJK7xFMYnq?=
 =?us-ascii?Q?0u5E709L0DxmXlZ3cH/Mx93rx/+ojw02GrVbYabnuA8DKNWP3a4KFklZuHkz?=
 =?us-ascii?Q?fAfympAkHH3WTC/1Xyegd8zlYn0vnJxM/5Scm+qtquA+S7jv6oIczAvlmcTR?=
 =?us-ascii?Q?H8oFcokZDJknCfXd8jXJt3Vy5WyegpKBkv2cgOaGI3Ygvuj/zoZWLzOe944f?=
 =?us-ascii?Q?rm7FnU8Pgs9vJpuhmvlXHpiqRiXAgRV//4t2UNjslcLYFb1bNKfW5dclF4vL?=
 =?us-ascii?Q?V9Bar/y2+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67de1b1-389f-451f-3219-08df0b838758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 19:26:05.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdF1bcHhvB/VT1tn/SKbFvXVn/K+GyxK3oxqVyDOB1NtTqKLfTJUHMMs0FCyuOWLxiHhk4BYQn5289s/nDGj3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Hi Tejun,

On Sat, Sep 05, 2026 at 06:09:54AM -1000, Tejun Heo wrote:
> Hello,
> 
> Running scx_qmap as a sub-scheduler under scx_nitosis exposed a kernel bug
> and two scx_qmap bugs:
> 
> - dispatch_one() decides whether to keep running @prev by testing the root
>   scheduler's SCX_OPS_ENQ_LAST and bypass state. Those are properties of
>   @prev's own scheduler, and put_prev_task_scx() acts on that scheduler.
>   When the root sets the flag and @prev belongs to a sub-scheduler that
>   doesn't, the task is not kept and is enqueued with SCX_ENQ_LAST to a
>   scheduler that never opted in. This trips the WARN_ON_ONCE in
>   put_prev_task_scx(), and the task is queued without a follow-up scheduling
>   event, which can stall it. Patches 1-2 fix this.
> 
> - scx_qmap added SCX_ENQ_IMMED to its rescue inserts, which turns a rescue
>   request into a regular placement on a time-shared cid and loops with the
>   kernel's REENQ bounce until the reenqueue limit ejects the scheduler.
>   Patch 3 fixes this.
> 
> - scx_qmap placed tasks from the delegation split alone, ahead of the caps
>   in effect on the cpus, so highpri moves to a freshly granted cid were
>   denied and bounced. Patch 4 fixes this.

Apart from the comment about PATCH 4 (which I don't think it's a blocker)
everything else looks good to me.

For the series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> This patchset contains the following four patches:
> 
>  0001 sched_ext: Rename sch to root_sch in dispatch_one()
>  0002 sched_ext: Use @prev's scheduler for the keep decisions in dispatch_one()
>  0003 sched_ext: scx_qmap: Do not add IMMED to rescue inserts
>  0004 sched_ext: scx_qmap: Place only on cids whose caps are in effect
> 
> 0001-0002 fix the kernel side. 0003-0004 fix scx_qmap.
> 
> The patchset is based on sched_ext/for-7.3-fixes (0a85182723b6) and is also
> available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-keep-last-rescue
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c         |  33 ++++++++------
>  tools/sched_ext/scx_qmap.bpf.c | 101 ++++++++++++++++++++++++++++++-----------
>  tools/sched_ext/scx_qmap.h     |   3 ++
>  3 files changed, 97 insertions(+), 40 deletions(-)
> 
> --
> tejun
