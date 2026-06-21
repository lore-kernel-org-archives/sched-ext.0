Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509E274B2A
	for <sched-ext@lists.linux.dev>; Sun, 21 Jun 2026 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068981; cv=fail; b=BpuhzmxvmrXX7FWx8KT1mn5NvV/zEx5essxAbTYso+YlpcY70ZlEfpHCs/OnB8Lu1ZnYBDb1c0XKc3t/t4SJkThPGzkkn8KmrnW12B12VDGmOWQHQqG0Rk2o6dW8dW3Xb8mCbRRxb3w1AhGCpQoJtqn2sGVLztNs9iOLrkDsTnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068981; c=relaxed/simple;
	bh=0MrRj7duCHMx5DinJPAY9jgjR7B7SwJGTw2KFCFbhL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZEKqDktRerVjv2Jo5vYRXAJI5pLtDt2pVp+j/WH/2Mo7SIMahcgEGBiDgYhZx8qc193Fp+uK8yV65P/2TwjyPYCQ5l+R6+79CobKuyQSl+lRvXz2zf56ZDtFUFDBqIG1D/hLq4VHaO1h93AcY01OS8AcHwa4CPwFCkz137u9JFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7ImVqAh; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7ImVqAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szC7Bhx+vh3vWRJzpPo4QocROQHzO12rD3B4Mw0pR2bDjQDYwEvISu986r7PY+QESSA3napb5tKqy2YVm2cY2osKSql4hq+UsmlIFySskMjHAVTcuJlYnaOZ9wFRxGNz9G6twAGJRW45b17tXZWoKTQg8h194/Zjkc9YkcVxoWT4um6oy5KwQGtc7RfIID8AATinrgl5gMPojyd2WUCwIu71psnGf8Cb5sonqIGh2bgyfIbpjp/oFDWra1FUJsycm8e3rir6+soc9v5Yel7mYk9mQYan+sRPx/xBdSruJpWaYrUXhlsCa9WYYJ6f3eHughVpzcM9t0ZxvsrQ5CA5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRNMqD0DcTfdwFTAuG8T0CeAcx7q6AO9/4j4aNX7q5I=;
 b=Pczgfx3//m4NMRRHvstXx2/y0BUZT3p6tJKZSjiLtvGSeLwb/oK84+yAZUT/cRlDY0LiT72VIRka+qbveIdQz215Awkq+iANSaxvLZGfVoPq/yJH9AS5++bcwyS8By8PFzM+vbDggmfwUU3qjGGjD60cwdYkz3GGR7mCqqfkvCG+wnAOSZnBKJNFWrY5elcdJC6p3AZP3R0O4SZ/6A/GO+qZ9lPmxKWJZTI9VkJUxO6MdsCG8gPbpurgv0dh/jWviWawrBYi82nVSB7TzpGzY+lq6i9jF1BdtAZXuuj2scoQQKoCFEEm9k0uay4BAsVzi37Si4HMu1xOj5XCp/1y6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRNMqD0DcTfdwFTAuG8T0CeAcx7q6AO9/4j4aNX7q5I=;
 b=V7ImVqAhwLeLsllOv40adiZHPvK9p8MdFUG+xPAOhkFypROmBy8vWmqyzh3/asVJq8vfqR6CUREtcsVY6grl7C3g3oGRzG1b0oClzIv6BUWT+9pqfZYHysTeEHmS5y7bDmZ0jWvktG1MBfwkgd44FXbjREFqe7x8spCyCdq4PFjzXRkTsWHY7mDdV8DU9BrXU3eJTgAmclCXQUyamAG/vbklSZk7lz8O5wJhYRUCvyGP0HuK+xlINjan9QoU52/uC49JTbStovvcU9z3Sy2HXEub+C3AB/F//79XGdOmPtWqoGvZKaHM/vdGzd2uiVUIG+ibGxIbkGtXIVpIV5P5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 19:09:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 19:09:34 +0000
Date: Sun, 21 Jun 2026 21:09:21 +0200
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
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: Move sources under
 kernel/sched/ext/
Message-ID: <ajg24WhH5kK-oc4t@gpd4>
References: <20260621163026.434856-1-tj@kernel.org>
 <20260621183444.485350-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621183444.485350-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B8C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 50061edb-d896-429d-c581-08decfc8a144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	1vq3MG9RTlvWusV7jwQNsn5EX+XwRE8ANtBY/9UsrzgGuXTOIIOik4zxzeYsLX1kQjS69Msjorm2qVuOwJs8qP15NlBEl4lLuit/CJkpbTbmZ0AZb+A8n7pIy1OF3L9KFSUtOLjjUhAl+aCDfrW/6DBqT4ee6VPC8nifWjWSdoigZCRP+cYdwMeZjS/YG94XRnjC0i5gCgWpHl6Il4uPHbOFuxJ+ww2h2OVPPuXluQpuroWbis324p9B7lC3nrfI5VIwqnXYDJW4qj8o27qR1EFQz47vpuM6lgQgYcNmI73t2lOU5kzOA2vpIK1GIomUYIays8GfzJrS309FO5sV8wlfgCGQeH6XUDDO0VqusGWTNd/S9t2co/x4fr2iFreLTm/D2Oay10V0nFO1lt122uXFKhRNxhsckOvGn1fPAz+oydCV/YJSU/Xbaww1fGtn6C+5bUd7JjL6Dc51gN8Y6cJYLP9MdJbeZ6KmW2LsBYWkiP6/5x+QHN7YexW3vMhVMa5px8j5d7HVCYWknDUtAutCVo0iWO4MnTeSN+JPZYDSXS7DZD+bYh6iKOsNfCRECF02f0inJlroEd89lDdrlAqhx56GIIRRYeUE0/p+B2xVc6vKU6LPOFNHx0lZM+7RKr9iOHtF+npxAdtXZ/fhVM2YzIdVlRmCcFunGTKzQuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stnCDzkA4oPQdlkRwnFuF7oZePsMdDDAL+yiI7kYdiSAXuyyFEurjw1AHpB6?=
 =?us-ascii?Q?S1v44NXc/46ISH567PvR4bREcfFYxWajcpG/I3Pq3shz0TkAEM1QJiTPug4A?=
 =?us-ascii?Q?EBIQh0Cvr0FCI/h4d2KOf8Y31M2qW+TMvYtUwjR4mbKSNK6XfdCw5bTp5MdM?=
 =?us-ascii?Q?lsHETTZVwWjgfyHfjWfqBuoFwBiqXEhAkEYlcffQ7CXDLfh66RXGb0A+hDBP?=
 =?us-ascii?Q?fJYD5R4LP616n2pRa34pA7X+VTCguh7cKpBITcv8OM1srMXLuTdg/xn+fyzj?=
 =?us-ascii?Q?5nE4s+qSroXve+uOZxxypRfYSHn2nVsIci0BktjPFtssLt2JsqboSpHMaZlM?=
 =?us-ascii?Q?Xu1ntGbdZGen3EQrSnQlAkMPbwQk3HaXkGuB4N9Snz2Hn5EXl0GM3h5X5Wgb?=
 =?us-ascii?Q?pIrDDOx9vDPPLeRQRHFHwaQr83XgFj3U/YwmgZYU3Z2zunJ8+3Je8M1+UihH?=
 =?us-ascii?Q?Sw2/X4OLUn7gkGVx+JVi2SjnUfqBArDBrcPATcIr95HqI2k0pdmPchm82XEZ?=
 =?us-ascii?Q?u9fXH3X+EsJ43ZjQ0/4CjVJvepXSV1Dh2/TCqzWg8DFVOxMEKpf+OE6DXOPi?=
 =?us-ascii?Q?DdAfYUzvgsUJs/MLI1fz/QOcIIKvsMwCRO4ToIQf5FlYqmEIQoe1nMJELHL5?=
 =?us-ascii?Q?NWmuaDXWrVtJ/V9r3gOCK9BFy2sNuY8Pn9WZ9XwVCzP6rcKitw9WmU+X1OR5?=
 =?us-ascii?Q?hoSIdSB/DDZ/hoNrk44TP+xwoASryX4Xxo/pFGw/BGvti4DZJhYE0p41i7nq?=
 =?us-ascii?Q?ejy595RqR0wwNpYhAis8FXNxuRSCAIAIYOGNqDiJfIlltHM0qxGxJEw6eGc6?=
 =?us-ascii?Q?CUXz2IYyJG9lF075GwsHP/Y5a+NQDl2KIPyhzLrIjqu5i4RO5FQjRwfr4x6H?=
 =?us-ascii?Q?pJpv0M/oipwxmlXerd/TcaKmT6vscT78Hx/Gyy7AGECgIzrKiVlpV0ayuwXi?=
 =?us-ascii?Q?EsvJDGCOQ6wbMXrMDDzYGZf8P76lgiQbj32E7pTd8EnBJU+on0wyFQSf/WCa?=
 =?us-ascii?Q?mix0dKx961heUh3T1MvQ2ZG5zmp4vUFSntgCSIq55FaO4fWIUBAkLMvw2V6T?=
 =?us-ascii?Q?cfvNH55Skv5qa3Xvv+aSeCBUSMrALDopKCG6iLxKV/M8NiBjyqsQ0xX4AStU?=
 =?us-ascii?Q?/QoPP+HztUrav1AlSs/v8sYtaQShtgRruWythqFsjX7AYzQHdArEtWlTjccD?=
 =?us-ascii?Q?Z3f0iUvtYpH6WFN0glGdS0dne0cp6Cw2tB+2yM5F9QgyjGpNzdU7QO8UnwD4?=
 =?us-ascii?Q?KRXWl52Sbu43AFXEtprRRvyAC68Qqp2uXa1aTUOZrKuJC582Lvi8FdfdZbpV?=
 =?us-ascii?Q?/PPascJ9fuO4Yn17//3rW8J49efzpC8V9KyQKsecpFdxfYQhAOBJ863RGdJO?=
 =?us-ascii?Q?oVYnW8kwrNL4mtQFWTJduYdUiyfQdwvnZDF0ha5CGVwfVuRMAddtbtyrHuU3?=
 =?us-ascii?Q?SjB3XH0r6f1VrjaTYhyHNJziknyjl64qbGXlmpeBvZqpLtrAGtqX1hmu8nj2?=
 =?us-ascii?Q?q9bd5oSOs6CbjQaUP0bXayx/8mjxbuLHsTxSAQxroYijZ3Isc9j1/imikZpT?=
 =?us-ascii?Q?OKC11inT09vYy0JklK4a/ozU5Ru3AJ4qf2eMDC3qA9b4Q5Jrq0bZyK9GPca8?=
 =?us-ascii?Q?ihF8zzDA/Ke3wK2+0LhQIaX6ZvHEKRIGpi8mHZrEQJiX3CHMnKhtEeTtQw+R?=
 =?us-ascii?Q?5CewbYllJRCdwFyF+Q5mFQ/1DUNUfrNpOsQQZ7SFfqoHJyR15XTr3PVNYwo7?=
 =?us-ascii?Q?D4k7h5vmEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50061edb-d896-429d-c581-08decfc8a144
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 19:09:34.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoQYPHsiYBpC2A7EmIDics9kxhDze+C9XFnU58s6Uud977noWTgAdUx7ZR8IlbpzUaNMe+bF2wMqbcvHubEwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

Hi Tejun,

On Sun, Jun 21, 2026 at 08:34:44AM -1000, Tejun Heo wrote:
> The sched_ext sources had grown to ten ext* files directly under
> kernel/sched/. Move them into a new kernel/sched/ext/ subdirectory and drop
> the now-redundant ext_ prefix. ext.c/h keep their names.
> 
>   kernel/sched/ext.{c,h}       -> kernel/sched/ext/ext.{c,h}
>   kernel/sched/ext_internal.h  -> kernel/sched/ext/internal.h
>   kernel/sched/ext_types.h     -> kernel/sched/ext/types.h
>   kernel/sched/ext_idle.{c,h}  -> kernel/sched/ext/idle.{c,h}
>   kernel/sched/ext_cid.{c,h}   -> kernel/sched/ext/cid.{c,h}
>   kernel/sched/ext_arena.{c,h} -> kernel/sched/ext/arena.{c,h}
> 
> The include paths in build_policy.c and sched.h, the MAINTAINERS glob, and a
> few documentation and comment references are updated to match. No code or
> symbol changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me. I also double checked for any potential stale references after
the rename, but couldn't find any.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v2: Update two ext_cid.c comment references the rename missed in cid.h and
>     ext.c (sashiko AI).
> 
> I'm applying this to sched_ext/for-7.2 and sending it to Linus before the
> merge window closes so that for-7.2-fixes and for-7.3 don't diverge
> unnecessarily.
> 
> Thanks.
> 
>  Documentation/scheduler/sched-ext.rst          |  8 ++++----
>  MAINTAINERS                                    |  2 +-
>  kernel/sched/build_policy.c                    | 18 +++++++++---------
>  kernel/sched/{ext_arena.c => ext/arena.c}      |  0
>  kernel/sched/{ext_arena.h => ext/arena.h}      |  0
>  kernel/sched/{ext_cid.c => ext/cid.c}          |  2 +-
>  kernel/sched/{ext_cid.h => ext/cid.h}          |  2 +-
>  kernel/sched/{ => ext}/ext.c                   |  4 ++--
>  kernel/sched/{ => ext}/ext.h                   |  0
>  kernel/sched/{ext_idle.c => ext/idle.c}        |  0
>  kernel/sched/{ext_idle.h => ext/idle.h}        |  0
>  .../sched/{ext_internal.h => ext/internal.h}   |  0
>  kernel/sched/{ext_types.h => ext/types.h}      |  0
>  kernel/sched/sched.h                           |  2 +-
>  tools/sched_ext/include/scx/cid.bpf.h          |  6 +++---
>  15 files changed, 22 insertions(+), 22 deletions(-)
>  rename kernel/sched/{ext_arena.c => ext/arena.c} (100%)
>  rename kernel/sched/{ext_arena.h => ext/arena.h} (100%)
>  rename kernel/sched/{ext_cid.c => ext/cid.c} (99%)
>  rename kernel/sched/{ext_cid.h => ext/cid.h} (99%)
>  rename kernel/sched/{ => ext}/ext.c (99%)
>  rename kernel/sched/{ => ext}/ext.h (100%)
>  rename kernel/sched/{ext_idle.c => ext/idle.c} (100%)
>  rename kernel/sched/{ext_idle.h => ext/idle.h} (100%)
>  rename kernel/sched/{ext_internal.h => ext/internal.h} (100%)
>  rename kernel/sched/{ext_types.h => ext/types.h} (100%)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index c4f59c08d8a4..4b1ffd03f516 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -114,7 +114,7 @@ Each running scheduler also exposes a per-scheduler ``events`` file under
>      SCX_EV_INSERT_NOT_OWNED 0
>      SCX_EV_SUB_BYPASS_DISPATCH 0
>  
> -The counters are described in ``kernel/sched/ext_internal.h``; briefly:
> +The counters are described in ``kernel/sched/ext/internal.h``; briefly:
>  
>  * ``SCX_EV_SELECT_CPU_FALLBACK``: ops.select_cpu() returned a CPU unusable by
>    the task and the core scheduler silently picked a fallback CPU.
> @@ -496,11 +496,11 @@ Where to Look
>  * ``include/linux/sched/ext.h`` defines the core data structures, ops table
>    and constants.
>  
> -* ``kernel/sched/ext.c`` contains sched_ext core implementation and helpers.
> +* ``kernel/sched/ext/ext.c`` contains sched_ext core implementation and helpers.
>    The functions prefixed with ``scx_bpf_`` can be called from the BPF
>    scheduler.
>  
> -* ``kernel/sched/ext_idle.c`` contains the built-in idle CPU selection policy.
> +* ``kernel/sched/ext/idle.c`` contains the built-in idle CPU selection policy.
>  
>  * ``tools/sched_ext/`` hosts example BPF scheduler implementations.
>  
> @@ -557,7 +557,7 @@ ABI Instability
>  The APIs provided by sched_ext to BPF schedulers programs have no stability
>  guarantees. This includes the ops table callbacks and constants defined in
>  ``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
> -``kernel/sched/ext.c`` and ``kernel/sched/ext_idle.c``.
> +``kernel/sched/ext/ext.c`` and ``kernel/sched/ext/idle.c``.
>  
>  While we will attempt to provide a relatively stable API surface when
>  possible, they are subject to change without warning between kernel
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d95d3ef77773..ebd76d0367ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24164,7 +24164,7 @@ S:	Maintained
>  W:	https://github.com/sched-ext/scx
>  T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
>  F:	include/linux/sched/ext.h
> -F:	kernel/sched/ext*
> +F:	kernel/sched/ext/
>  F:	tools/sched_ext/
>  F:	tools/testing/selftests/sched_ext
>  
> diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> index 067979a7b69e..d74b54f81992 100644
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -61,15 +61,15 @@
>  # include <linux/btf_ids.h>
>  # include <linux/find.h>
>  # include <linux/genalloc.h>
> -# include "ext_types.h"
> -# include "ext_internal.h"
> -# include "ext_cid.h"
> -# include "ext_arena.h"
> -# include "ext_idle.h"
> -# include "ext.c"
> -# include "ext_cid.c"
> -# include "ext_arena.c"
> -# include "ext_idle.c"
> +# include "ext/types.h"
> +# include "ext/internal.h"
> +# include "ext/cid.h"
> +# include "ext/arena.h"
> +# include "ext/idle.h"
> +# include "ext/ext.c"
> +# include "ext/cid.c"
> +# include "ext/arena.c"
> +# include "ext/idle.c"
>  #endif
>  
>  #include "syscalls.c"
> diff --git a/kernel/sched/ext_arena.c b/kernel/sched/ext/arena.c
> similarity index 100%
> rename from kernel/sched/ext_arena.c
> rename to kernel/sched/ext/arena.c
> diff --git a/kernel/sched/ext_arena.h b/kernel/sched/ext/arena.h
> similarity index 100%
> rename from kernel/sched/ext_arena.h
> rename to kernel/sched/ext/arena.h
> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext/cid.c
> similarity index 99%
> rename from kernel/sched/ext_cid.c
> rename to kernel/sched/ext/cid.c
> index 66944a7ef79d..aeaea88f34c5 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -71,7 +71,7 @@ static s32 scx_cid_arrays_alloc(void)
>   * scx_cid_init - build the cid mapping
>   * @sch: the scx_sched being initialized; used as the scx_error() target
>   *
> - * See "Topological CPU IDs" in ext_cid.h for the model. Walk online cpus by
> + * See "Topological CPU IDs" in cid.h for the model. Walk online cpus by
>   * intersection at each level (parent_scratch & this_level_mask), which keeps
>   * containment correct by construction and naturally splits a physical LLC
>   * straddling two NUMA nodes into two LLC units. The caller must hold
> diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext/cid.h
> similarity index 99%
> rename from kernel/sched/ext_cid.h
> rename to kernel/sched/ext/cid.h
> index 5745e5785e89..6e657fd147b0 100644
> --- a/kernel/sched/ext_cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -43,7 +43,7 @@ struct scx_sched;
>   * possible-but-not-online cpus and carries all-(-1) topo info (see
>   * scx_cid_topo); callers detect it via the -1 sentinels.
>   *
> - * See the comment above the table definitions in ext_cid.c for the
> + * See the comment above the table definitions in cid.c for the
>   * memory-ordering and visibility contract.
>   */
>  extern s16 *scx_cid_to_cpu_tbl;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext/ext.c
> similarity index 99%
> rename from kernel/sched/ext.c
> rename to kernel/sched/ext/ext.c
> index 0db6fa2daea3..00fe6cc6d7e2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -513,7 +513,7 @@ do {										\
>  } while (0)
>  
>  /*
> - * Flipped on enable per sch->is_cid_type. Declared in ext_internal.h so
> + * Flipped on enable per sch->is_cid_type. Declared in internal.h so
>   * subsystem inlines can read it.
>   */
>  DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
> @@ -608,7 +608,7 @@ do {										\
>   * @cpumask: new cpumask
>   *
>   * For cid-form schedulers, translate @cpumask to a cmask via the per-cpu
> - * scratch in ext_cid.c and dispatch through the ops_cid union view. Caller
> + * scratch in cid.c and dispatch through the ops_cid union view. Caller
>   * must hold @rq's rq lock so this_cpu_ptr is stable across the call.
>   */
>  static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext/ext.h
> similarity index 100%
> rename from kernel/sched/ext.h
> rename to kernel/sched/ext/ext.h
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext/idle.c
> similarity index 100%
> rename from kernel/sched/ext_idle.c
> rename to kernel/sched/ext/idle.c
> diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext/idle.h
> similarity index 100%
> rename from kernel/sched/ext_idle.h
> rename to kernel/sched/ext/idle.h
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext/internal.h
> similarity index 100%
> rename from kernel/sched/ext_internal.h
> rename to kernel/sched/ext/internal.h
> diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext/types.h
> similarity index 100%
> rename from kernel/sched/ext_types.h
> rename to kernel/sched/ext/types.h
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c7c2dea65edd..56acf502ba26 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -4211,6 +4211,6 @@ DEFINE_CLASS(sched_change, struct sched_change_ctx *,
>  
>  DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>  
> -#include "ext.h"
> +#include "ext/ext.h"
>  
>  #endif /* _KERNEL_SCHED_SCHED_H */
> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
> index 9d89bb57e201..db247e42fb45 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * BPF-side helpers for cids and cmasks. See kernel/sched/ext_cid.h for the
> + * BPF-side helpers for cids and cmasks. See kernel/sched/ext/cid.h for the
>   * authoritative layout and semantics. The BPF-side helpers use the cmask_*
>   * naming (no scx_ prefix); cmask is the SCX bitmap type so the prefix is
>   * redundant in BPF code. Atomics use __sync_val_compare_and_swap and every
> @@ -33,7 +33,7 @@
>  #endif
>  
>  /*
> - * Mirrors SCX_CMASK_NR_WORDS in kernel/sched/ext_types.h. The u64 cast keeps
> + * Mirrors SCX_CMASK_NR_WORDS in kernel/sched/ext/types.h. The u64 cast keeps
>   * the +63 from wrapping when @nr_cids is near U32_MAX, so cmask_reframe()
>   * bounds-checking the result against alloc_words catches the overflow instead
>   * of seeing a small value.
> @@ -281,7 +281,7 @@ static __always_inline void cmask_zero(struct scx_cmask __arena *m)
>  
>  /*
>   * BPF_-prefixed to avoid colliding with the kernel's anonymous CMASK_OP_*
> - * enum in ext_cid.c, which is exported via BTF and reachable through
> + * enum in ext/cid.c, which is exported via BTF and reachable through
>   * vmlinux.h.
>   */
>  enum {
> -- 
> 2.54.0
> 
