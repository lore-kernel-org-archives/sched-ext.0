Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC91A683C
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900416; cv=fail; b=fqqind1aj585DAXCnEDIOEqkdFLaxSKVnynYw+zSq+pw3PNznkjjooYfOf7LqF3RxEUdjpMdI/f/L65KE/zJ7bprWm53l//EfErtBy853D8rZBUu2djo5iP019nXLwvqIx6xf6+vQovtS7kWA6rnhWnxKI+hiiFULsoj8fwoC1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900416; c=relaxed/simple;
	bh=pXAXaWJHMI4E1ZWDo7ndb1lpSZAGE9vWZ3+nJv0RY28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EB3fPheZ5wnZBtvSW9NKQJyZMf/8U1FdmVvH+A3FJWH/onKysMjhD+R9AFRsjbK+U5WQ46hIGKBXhC47HkjRfImrtE4n2lQ1IYIBslN7b7LxEcMCwcj0FRV+3/Nj5TWgs8cXhlO3BfuZM43on3pm4n2md60ldOeogv78jAQQhGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2BCxcK8; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2BCxcK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceBcu72vKc0HBINUan9ZnuS7mPyFb9PjTa+B/IipQ2Smtykx7R0bAeniXp/YD/r4D4g5lgt1gtjoTsT3MsvdcwCB6jD1bqEh8NS9zegYNsXGSS0BAZC07Fd2TLlc/TCAXyczbBhlxLuYOKQcpbelXfjq0KFQ7+6PCMXdXBvOxWxzvLyKO+AYKWpzRnydZd7FOqZD0fYfParC1+AkdzulpMhGBuBUalYbx+Itm1rE/uImhphVB3mOs0CONWq1m9WmtglpLpfyDso1VHTq/h7JKLvUJXcsuScKXFNO8bSNj4HIAN5PoHj/ZqZr/LUxIuT8ODawFuazinFC8qZ2jzkiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5G7lvGtOC3qtINb9EPeIRKaIrbQffdPPrbrc1nkwvM=;
 b=y/YNoHm2Axo5AyXKoAaQdzUQ0UtXEjTMSI0WWlu0mYqkrUSNA1M3OuGQU7fFjbaEkoOQ1kk5LMnqwbCQAJAbK2k5wvvQVCyb9N+T9mbBsAxcYoWMS1Mj8BrkcyhyVdwfzx1A97p0uMtpuOyoTX0GBLp1dMTJpxSPj2kw9lrNCkUisHcWqeN93OwnimURpZTx7OcBe1V8jWSOiHqC2AeUjOWLffCMXi67DO9IH/IjfHQJuA0KvEBjwAoHCKSkUqN4nr+PZ8IxHFBWIsNaOKJOri8wTvHkVZVX5Q6hK8DSlLBjabk/g7GVwgmyc/a+5z7mY5r4AIGY1ItUhr6Jhd0XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5G7lvGtOC3qtINb9EPeIRKaIrbQffdPPrbrc1nkwvM=;
 b=G2BCxcK8qLGRcfOp8yFynjnytliSbCKNjnDm/ISUXgzRkjUOzmMgvuU8Iat2a4b3sGfB2NQkSCRqeFti4ZKP+DsBsQ0oOmmFo2pOi0CvujMdybmv30n28/EN6kqnB2C6rj44Dw26XjdsfSqQPBpwjYab6mwsaFFG1ptAGnCEKEtnvfkQ4ictSe0hyOKLHKxVtXWUdQ6IHPCOJKQBm5tHlBWBlgpH6olypRiofscJslUwyhlbSsoVxupJXA+kOtiRfS30FoBQvp7AEZLlyyY9fcQssjtkUD0loyI3Su77FST1sMXd9zJXnCBqfpSOYC/VTASFAavh8GVzXJ8nOc5Z+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 10:06:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 10:06:52 +0000
Date: Wed, 1 Jul 2026 12:06:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Split sub-scheduler
 implementation into sub.c
Message-ID: <akTms0YBgtR7aXoE@gpd4>
References: <20260701031429.1892218-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701031429.1892218-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF0000753B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cd) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cef34b-ac12-414b-f3c4-08ded75878f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LHEvugCNEUU1YgFrnk/ehPL2beBhGO0fLhTMBVPjZvY40pTEnO3ruyLnfW1vqLh4PMvIzPGDvH1Tl0wSVEgvRKmN/j6bW5boNNT2PnF23AuZnz57CUac8Wlx4rHRnYfal3y2Pb09Eb1bOxsJ/HaVpBO57fwLHe9WmXzfc+aePQchtU6SlhRdzTZC9x5wld2j8d5HJMWRphZjrqd3NF9mMBwYc3UVFHkSnWn+qTMfpR0vJoS+KbYJWz3Mr3m0RkJxsxr4hYK4l5NUUu2IITjrLuwXxVQDQylORo4o2vNTTVuVD4sGonNjrU+m3knCGtPekYyfxl6kw+b1mIcCVJWW24/9M3r8Uu0pBMSXETHZOVYcU7i16V7+iDm0g+NU4GWnmH5EWPRhkfAG34uzCECkR05PiKZR4FYWtxtB5ColulTxxor4aSHaXv1W7q6Op3kMHmUW4tqJ1U8BYBrMHf67pDG1UhAo68+nV9yhQ/Wssoee4Ri6JR4QZIoPx1ONP9rTLSe/5tcFw+LDMzKoru0MW7iX139DaGpToTBiGmFBeVSLQdw2uysvhfvTmk/g9h9oDFW479XNE9gaK2C6HOPJHhMevQx4yYjpD6rmhLOXqcJVwP3n4II8qQZy8CsByw8WXtP1In3wZqOpw/InGsMoBcChCK3cpQ1HfJokYCDfMS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Yfu+2W/jXqpPPXKG9GKE0J3gd/3XUNYa1bXH+VI+1s323ebj4kyd8bmmDOC?=
 =?us-ascii?Q?mM7mkAkXL+0/beFfhkJDzulWiEJrMCIUOnveQwH4vrA4qIGNk0UPGL3V48Q/?=
 =?us-ascii?Q?Hy30JitE+mTnd1fOGJgUn693WzUR3ZNImvRfAAsDRhVewJ1y6KV45dnlhMhi?=
 =?us-ascii?Q?/LnoOD2A6f4EqHtC7sjha+L4n0abptTvmDpen/zYSb4SVnVmeLR83ObfUVF8?=
 =?us-ascii?Q?SZ89EX2uHzbHhzm/+FTLGFb2w01cH9ra0NJARkQWv5XR8HBSpXZPgo9vasW3?=
 =?us-ascii?Q?DOCMtzDrxX0pAiFSyllKK1NLJh8gIsR71xlB0fGY/ELFTjhDklQw41Y3WDPz?=
 =?us-ascii?Q?anF1PvTNrKwDVshMLe5WrkhspMJzuKjvA29aIPzwfIvZ34GFToow6vwvYWRW?=
 =?us-ascii?Q?uUy3/lLvXl2uUlGLCuHImhJpAX90LXQC7jxCbjWFhbGHIVwR4ftyELtsS6LA?=
 =?us-ascii?Q?jr5c0tGfTIAy12Mixj58ltSJYI5ypVX3KQtzySStZnMFwjo+5wv3sE8/wOm1?=
 =?us-ascii?Q?QeBP/cpJ2ZZk/KmFDjcmDg+DYMo/xxNGOcFac6BCek1oI/YQ6tfhlr5BkHWb?=
 =?us-ascii?Q?QKURR1d56yEfEb7BQsoCgIT7KIBiGU4kXtMIju931gLqjpr5COdtU3j/Xiex?=
 =?us-ascii?Q?7eUeuW8FIQzbggsf3I+qqh5QM5y3aLsfrjAybS0iV1tGuaCTjqbMG91tWapc?=
 =?us-ascii?Q?gvxeYvWMyXQ8Ngz+a17kpdHfPfbqMQAra6j/bnC5qYwIxdaUG2AFv8h0vVX4?=
 =?us-ascii?Q?1uhBzByxw/jDCOXSR4Mn3gTPesM5iLwR61GCygpNzVvAIo0bGLWNtDOL4ACy?=
 =?us-ascii?Q?YoPM/NQKGtv0SdJBHwcu8jn20qzUZYHU+mU0s0N3zDwVBLcnWcMSKKYtNNWp?=
 =?us-ascii?Q?tJGr/wrYr3iCp8SpJ9A1M7VxUiD3MN4clYWN7C0K/HfLwrkszzSeEbwor5UA?=
 =?us-ascii?Q?y5trky82eUnUWMRQnuN9MVZ8cM+HzAZjwi+BBTt+2ORn5HeBraKAwlGeMClP?=
 =?us-ascii?Q?q4gq1Ml6NL/FATvsoQWPA6oC6b4uFsHd196QmIh+WzP9IUp1ZcTZ2VJSIw5k?=
 =?us-ascii?Q?emhSUmVkZGoSZ/AysdLifbMj3pLLR+TRjTnTGL9yOYQcIMh4Qluv55L+KVKi?=
 =?us-ascii?Q?MqfTlsvTrrhF1EUuBvcUs87ot9jzeXtYgcqWVHNGddqh3FJPLyGryPVJTIIu?=
 =?us-ascii?Q?b7kmM32JgGjny8tlNpAOvfN48xCII4ofcVaZ97wR6m97Lqbxhc5IOAKoaRM7?=
 =?us-ascii?Q?33dY7ZLKFhVVkaY4iSFu86gLfFbJGJ7YRXbUCwkMEM20RmRGK5Zn00k4fA3k?=
 =?us-ascii?Q?Kw3to+wiwjKo8qcptL/xDkstk1T3WlccO7hwFCL6B/qZuRVBQJiXtaoryNgC?=
 =?us-ascii?Q?4VzHJK3YJw+GdPvY0wl7SSWJRQtqscpUuOGfdSOZt4r1u/mnUn+6FeXDd9jQ?=
 =?us-ascii?Q?vtaLnhvYXm47fcMf+Jlnnu4wC6/8+qt4k24XTBXzCRuu5X4UxvzYr7qIfygn?=
 =?us-ascii?Q?TQuNRqQNnmvoDlUea+zDKJzOQd0Wj4LwzvPhMWnB+5zybrEcw7jhE6UArCta?=
 =?us-ascii?Q?b/PtU2OgdhsJhAyvYEZuHhCQPXTHc7hz8kLgTbd7+DGfFdBgWUG1VGlb3yOb?=
 =?us-ascii?Q?R3EBCDZ4SZzTeulObx/RQRuIc9RUzco3D6oD11Efcqo7k0iiW75kE5I5yZEf?=
 =?us-ascii?Q?T7QkCqpJEyI90yYdNv9ONZ22faEVnim9S7YwNf3DkIKhIdV+Ge1uLedPmVoA?=
 =?us-ascii?Q?7RhafI8C1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cef34b-ac12-414b-f3c4-08ded75878f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:06:52.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPGGxDhXnygkqfomxBdKoJBw/wgW2MROD0eOu6flhbbxe9hu/5q08osSt2pops6ZRbaRZ8mBou8RwryFtPrwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

Hi Tejun,

On Tue, Jun 30, 2026 at 05:14:25PM -1000, Tejun Heo wrote:
> Hello,
> 
> The sub-scheduler implementation has grown and will keep growing. Move it
> out of ext.c into a new kernel/sched/ext/sub.c. The first three patches are
> mechanical prep (prefix file-local helpers, expose shared internals, inline
> a few trivial helpers) so the move itself stays pure code motion. No
> functional change.

Apart than the comment about scx_dispatch_sched() in PATCH 4/4, everything else
looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3 (5df6a4506d06) with sched_ext/for-7.2-fixes
> (b7d9c359e5cf) assumed merged.
> 
> Tejun Heo (4):
>   sched_ext: Prefix file-local ext.c helpers exposed by the sub.c split
>   sched_ext: Expose the ext.c internals used by the sub.c split
>   sched_ext: Inline small ext.c helpers shared across the sub.c split
>   sched_ext: Split sub-scheduler implementation into sub.c
> 
>  kernel/sched/build_policy.c |    2 +
>  kernel/sched/ext/ext.c      | 1002 +++++--------------------------------------
>  kernel/sched/ext/internal.h |  136 +++++-
>  kernel/sched/ext/sub.c      |  668 +++++++++++++++++++++++++++++
>  kernel/sched/ext/sub.h      |   51 +++
>  5 files changed, 973 insertions(+), 886 deletions(-)
> 
> Thanks.
> 
> --
> tejun
