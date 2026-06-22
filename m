Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54C3446BE
	for <sched-ext@lists.linux.dev>; Mon, 22 Jun 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152796; cv=fail; b=iQJXVnXCU/Ro7+XxH/LvgphJQ4tmKv0tsFBpYhp25VmU04JCwj8GgF9ufwaowF9EV4+HVJc1V/B7omTKryUiF5lfW+dm54YWv+p8OPUefP/lAUM+Z7jrpsVq70EWORaoQfWe8lsQvCL/5WfUqsw0egqtKOqPFAhiw+ymgK2KuMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152796; c=relaxed/simple;
	bh=hoI/rmN4JuJUGcU0LPDNVXje3Q03sS7SaBkQuroPQ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NbFTyDhNMCcL6sBVJxQUblUUa6DZR86zD3F4oAX+9BzB9F52Ad9/0YXpVA0OUq66fJ+Im6Ia/NM9B7IROxINb3hi9wxV5DXgyqGFEa1HeclKToz9k8lLm2JYddtgeWAVsIkkY8zkVvUQOsAYt9l2An1TGhcL9+5WQ0jtKecWfhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jl0zTvL+; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jl0zTvL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mrz3n35YbvODu7u5Z7bKHd9MSad5RqCGMnJ5h73BYMPzi51li20u3EeVCjnFaHF0M8YcJZXW6UKLTQQ31TiwrEefo3TABE54LY+hwxD4FyNnsD2at6jUYY1Gt4H76DLQgX+fAWFYNvWBn7wUJ5V/Zh5Nmc8Y2jaUuF1FfV/V8pSGnT3e0QuCfwCmkWs/6kVk4PCyaW5JDKiAS4fWBR+nvGQbjO2nNpzpdGGDb6A2RtwLaXccugit+pyJ0D7A3pEMksendmUflmUZvFtPdafg0B/tfthZzAURSbF3p/1a7274uEiBJUX79pkZJIc+lqApP9/EEa5A486ZTQoLxkBWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e13WZl0Z1VN616Fjm4mkfMEmMUWgqTVsJPyVS8VvBug=;
 b=GDiFUem1/TgnFBCIRefcKHE6ZM7WCgortYhsiNj3kLy2gCRBjeBSX/3/VURZbcDAJ+0+wMq9OP2uJ1RSel1zYdZnY0VzvB07BQoTB02L8WXFjfabtw5czYXySWSO0mzpe/oypuqutcMnm9HIFvki4smF1qJ9RkzV1tcfoFc6dw8Ivmif7sz5aXr2sXfBbCurXKopXHOwXGp0xXeMRUMsZIcz6egYTHUTSfNjpyrbtPsddl7+mr72oNVLEpm2MKMjFbolpkRtHVPoPtdWq1ybTjKv7vwCXU7ap/ClC3AspkExT4ZJ1q1Di6FzLDmBJrqp5iXXnhqRU7ZnDK2db4mzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e13WZl0Z1VN616Fjm4mkfMEmMUWgqTVsJPyVS8VvBug=;
 b=Jl0zTvL+n4sz86bN7xy3AnTRRcnBm2knLAXD6KWKHgPzfQeBIMNSOBXiNuY9rTEiYz2rbYBHpiPrZWeoEtcHOrO1jKl/cnznmLrwejo5d6hn1Mnd1tWUO54zAxtX4t5ZV6wvp92eKS2BkedO5WVISZzQaI2WF0FAfB3wXBwinbdTEbOqA53gODS6AtNPZ87XJMHFySBhL9yq6UlcnENA7Ep/fgiEdNZWuqNuwqPHI+HNPt+jrQcQhpnHyVTMK0juvbUwgEx1bAp9NHwJJynl0tOgA7M+zasYxjDxx8z3zMyW/epZ7rRTHcuWdW2qZ6I/foXWi343LbNmfv1VDX+1ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 18:26:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 18:26:29 +0000
Date: Mon, 22 Jun 2026 20:26:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2 1/2] sched_ext: Make kernel/sched/ext/
 sources self-contained for clangd
Message-ID: <ajl-SgjY16AiTTMj@gpd4>
References: <20260622173904.1169407-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622173904.1169407-1-tj@kernel.org>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: c90a3f3c-fc9c-4ebe-6648-08ded08bc6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CZndehW05UXNEnhVuqoHJCWMJInCJLd3HSjGySFzh3PP2fJqE+McMfzOcTugkVrV7uTT9nk9+uFVSIDGIh8VoB1x9ctgXIFKFjNp88IBdsFIlrFzxmCc14vJkNuj5BW2MyLJfoVOdGca1+cSHnksg3EX9gMXSFmPt7MKLs7Kbgvm4k9+a3TjoHhhwlBkjWOzM7/CpSxHYbbTnpOUuDAXMKUSTUgKpMUvvb1ZM4It8BKFPEJp8M2oEPZ1mFLIeNeHnXfSFeuMkRwyenhV9w/oZp4gxmbZNI9n/i91KNbUzBdAsVRB2UBjG0y4+8zD/yZXWc2k3zzqLQ/K/KRo4/PrbWOH0fJyGdDZw54KsUFL7SSspYNBHvSJea4wVstDPgD452tNdb0qkEVcumK/fhh0v8txe7JktG/vI5vNUasR++jSN7aniCFkFB02cIen6Upx2w5unlhqnuNkm2OcO9Z3K4ETH2UF8dL6Y1UW3YS/hOuTPoWYxdzax4f1FixFHxvKYLJ8w7ybNh6m801jjAZvssP2vRpg1n4ShaVd3QQprqIisr4yYyUUXemCkeQObE+PviVc3CQ0VXA1Lo6l2JN4vEhR+RqvPvqzd4XX1JcP3wFUHGOowcY5sX2tzH1ClsP6izLUIzPW1iymy9gAqcRDnh6mjEMMPyyJ9Y28ANBagqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y+6+bvxLJMBy4atuB4fXKxv+VkIqgTjzVxeX/+MdLLCxv+am4nssDFBb6Rzt?=
 =?us-ascii?Q?cfA8jLhOGyjGcItUVoA5dJ7E43D+qYXKlgEQi2U5w4bLCZpsrLcqTwbS+qqB?=
 =?us-ascii?Q?h5QOApVtLggkm43nl6zNw8xgLUdyo3QLNVc9c4txoaTOqP5EEo6Blr3EygEZ?=
 =?us-ascii?Q?8QqXIxSZcXN3c/ymcQzZ3P3shEOaXpe4Cp1W0pHp2PMKS9lDNVNLByIqlXFN?=
 =?us-ascii?Q?i7OoRvjKumEaUdsVhNYRkkhgltmfXk5OxXj5XCSen+8GpTY8PFYcpMRAqRib?=
 =?us-ascii?Q?CKJ3K0DqFD7Q9SbxgSCH72PMH/OTAYueDBR6fWcgooc8UlHqU9/XlqFaJBy3?=
 =?us-ascii?Q?0K1XwfR6r6tgMkoRY1Vc7tNvEfprYwUbOUp7zmj8Mn9Hd+SidY9tZdqfGCf+?=
 =?us-ascii?Q?1c+Wopbv1DCdwUDKowEnYLXsbgQ3UMxOHzHSs0tbMUWiBBOBi9oCsoW1KlHk?=
 =?us-ascii?Q?VT7u4fzh47lDWwENIKJ3zLRaCIXuni5yMV/asT4dH1MqT2PFCTlEstJvGLBc?=
 =?us-ascii?Q?E2Ognqu549k9cqiyQMHNRvr+ncnXkwaEgmjmiLXwIqyiH6ggDG2sNzpHsQir?=
 =?us-ascii?Q?MktwRBB/pYon2l5cmgdODeWDTShSSAVaJ6VOfesKwfYgyHsHI5KlSNnH2cme?=
 =?us-ascii?Q?/bJY/xPJ2YW9M11/1XrsveyNKYgWVf3n55ldlPE2ox5il9UNsmoRCSP9+nky?=
 =?us-ascii?Q?rI4SJJctE09ZHPTPdl2QOgpAcvkeG8jEYlLbt0EeHB31CjUrKBrxw7XFIxpx?=
 =?us-ascii?Q?Pt1J07K6O/RKJxprCJ9Tyyam5VTC8C4vOhpLFSyTMXqTFSkgPSgZnKz00YYz?=
 =?us-ascii?Q?O0CmvXPDJwPMWixDYzcLXENb21edVIkUhfRJorSZiOih8gkpJxKmt/uCacvR?=
 =?us-ascii?Q?1jFY7KkrwIcZPfmoNrPZHchVOf/KxXhzGzsCvE5UexhGsZG5D4cF0O6VL7NE?=
 =?us-ascii?Q?eSH8PgdnkaRqANtXZIghAfzOg7YmdfZtJukE1XuhwNk+QwLY5LJKdhN0EnaQ?=
 =?us-ascii?Q?KKxi+32l+3GkGjdfkNb6mcNkJy5m2Y2FgkihtgP7PWnbivR2LIeIE4nrylQe?=
 =?us-ascii?Q?gxKUHLAXAuFqZVvVBpC298k7I2D9seY928e1MwGmxMmUze/oEh6nyIUb0gmA?=
 =?us-ascii?Q?2Fq7e+itmSRRj+F5XpLW1GxEOe51cVaSqkTR11519+iS/+B0hZtSbH/Rv6M6?=
 =?us-ascii?Q?3d6r8sdaffFly0ZozsoZokANM6/1Z5mYSWg6YFWKYg8ensWDAhx8uxzmGl22?=
 =?us-ascii?Q?Ue1CKAG04rkt5UaHr6hcLbOCFbqq62VZjTbNdOhrZct/GA8ZyLA6zzMMRrPt?=
 =?us-ascii?Q?nW3p0HdQobiWMUd2e9Y60075LzKsAWKxTrEniAsOMc3bE9jSraK3jpiAxLn4?=
 =?us-ascii?Q?2g8uPGlgb3XWOHgabPDx3mk0Le3+vw0ZOETFjsrErxTjUF2AxUcKNRgCyvli?=
 =?us-ascii?Q?2OyByZqMPdX+6cIjjFLve6+2CAGt/ekUHvO+0dTEpfxpz4ssQIws3q+7ew7/?=
 =?us-ascii?Q?j331pSL7mafUwH0EJOK1luhZkBwYi+6VA/aVrDx7+kCiIJ8jARDs6nnur05P?=
 =?us-ascii?Q?qRcelQ+znai5joBXc3f6iv6nk6kv3+0OvHbnzXVYkMJQSr/6IyJb1kCAhjzk?=
 =?us-ascii?Q?8uy5jAfA85wGyZmFr0Xj3HF93UkB9ukklZXaqrDEu65wIth8y75hvod72PUl?=
 =?us-ascii?Q?AaJQESBpIJtoRcmPHD+ZAViwwJvnqQRJRjOK9EI/PnzCC4Z+SIpnPFOza+dj?=
 =?us-ascii?Q?aSKxHv4BOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90a3f3c-fc9c-4ebe-6648-08ded08bc6ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 18:26:29.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzRAi2tALUaivSHkPz8O1XF1YXgI7ZrzNLqVGqiSYGJ49dxELQI5M9eKZ4Ax2YHkTwUu+vpIv/jcNWWBQU2Yig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654

Hi Tejun,

On Mon, Jun 22, 2026 at 07:39:03AM -1000, Tejun Heo wrote:
> The sources under kernel/sched/ext/ build as a single translation unit:
> build_policy.c includes the source files and headers. An LSP/clangd editor
> parses each as a standalone unit, sees no types, and reports a flood of
> errors.
> 
> Give each header its dependencies and include guard, and have each source
> include the headers it uses.
> 
> ext.c, arena.c and the ext headers now parse clean standalone. idle.c and
> cid.c still reference a few macros and helpers defined in ext.c. The next
> patch moves those to shared headers.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 00fe6cc6d7e2..ebf6dc84cb4d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6,6 +6,18 @@
>   * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
>   * Copyright (c) 2022 David Vernet <dvernet@meta.com>
>   */
> +#include <linux/bitmap.h>
> +#include <linux/btf_ids.h>
> +#include <linux/rhashtable.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/suspend.h>
> +#include <linux/sysrq.h>

I'm getting the following errors here:

 kernel/sched/ext/ext.c|1296 col 26-41 error| Call to undeclared function 'sched_clock_cpu'; ISO C99 and later do not support implicit function declarations (fix available)
 kernel/sched/ext/ext.c|7772 col 10-11 error| In included file: conflicting types for 'sched_clock_cpu'

They can be fixed adding:

#include <linux/sched/clock.h>

> +
> +#include "../pelt.h"
> +#include "internal.h"
> +#include "cid.h"
> +#include "arena.h"
> +#include "idle.h"
>  
>  static DEFINE_RAW_SPINLOCK(scx_sched_lock);
>  
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index 2077373d8da3..8e8c6201b7df 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -9,6 +9,9 @@
>   * Copyright (c) 2022 David Vernet <dvernet@meta.com>
>   * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
>   */
> +#include "internal.h"
> +#include "cid.h"
> +#include "idle.h"
>  
>  /* Enable/disable built-in idle CPU selection policy */
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> diff --git a/kernel/sched/ext/idle.h b/kernel/sched/ext/idle.h
> index 8d169d3bbdf9..f75699d22177 100644
> --- a/kernel/sched/ext/idle.h
> +++ b/kernel/sched/ext/idle.h
> @@ -10,6 +10,10 @@
>  #ifndef _KERNEL_SCHED_EXT_IDLE_H
>  #define _KERNEL_SCHED_EXT_IDLE_H
>  
> +#include <linux/btf_ids.h>
> +
> +#include "../sched.h"

And here I'm getting a warning, I've fixed it adding the following forward
declarations instead of including sched.h:

struct cpumask;
struct task_struct;

> +
>  struct sched_ext_ops;
>  
>  extern struct btf_id_set8 scx_kfunc_ids_idle;

With these two additional changes, everything looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
