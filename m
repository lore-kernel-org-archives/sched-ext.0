Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0588377ED9
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287235; cv=fail; b=US/iY0QEOSjGm3RaNz4RwHD28XOchUfsTkzmbF/C5jx4jeGwZ6vxKjz2iohcmZKJHREaiAArsD58yrXvSfnrrNTtb441DOJPxthokhBN5cJzszz5sWYQXjuueSRvzqArU01NKIy9LBBNKqoQeM/le+y6VbZ77eU0KgMa90msoPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287235; c=relaxed/simple;
	bh=w2TFGH9RqRspFZ1AsHXO7JctoK1QVV2CZ4BZb9XNZw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPGDzPYSInoozUjac0NsJDpJrT7qzmBNQRhb9FAT4ItiTEWShkZHgaSuq1UPE8PZG4ex+8CPHaItS1esaSDWgMOX0N1oqgOpPrQM/lC68lTMDRB1YYxA+Q0gfBE5iZdO9Zi1UOLvvsh3ohuxe7c4loWQyOrc8uKv+hgxirw39U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQdDBL3o; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQdDBL3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUbASxrl4PWB1xpoAFRHyRzPbT0BtStR9a30Q9QQE772EbMeEbXscWkLZ/BeJCKmqtbAMMZEl0D/g0L8yLW+bHzYl0hYWOCebFtUIlprODqm8d6R04elEmihT8wos5YezrOIWcU/MPsYSSqddl4Cd0siai+KV1OS8IaW9TCas6h1db1f4Za9WY9GWi6jQPOX96GocdE8VXLEqzH8ESPi+Vv6p6KbzpzA6vVdIpywv1yU4tSIfcTH9RrbGfyq0TTYp9ctS5L/iHupKf81gbN/7Kcx6kuku8d2XMnclWzKtyxhyTkNzF+5QQ49iXjJwDNTOWrnV3aT1DwfPyQKl6cnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMDZRqk26TMrc0Ka3JIOcHajklldoNJk+tTJ9QaToBk=;
 b=OVZ+6ason9SXgOvRDuiSaZz5YGtV7m2r1KswOXReLdmQ/bWuTQWCGxBK7ECLP48htkmdJATb+JgB4P9qyqijwk0HswSrFFBY/6FSyK0o86lQ9wbKiUWh3HVyPcINJ8YyCsEvhd7bvm3TJaBKTQ+WOeTcDCEQJ+9VAoXPJ3UuTFHTlfdlS48LxSX1JMvr98q5ULta+Dyhf0exdGUqnplP4eEdRhtsTsKkD27qd28sn6KzB/k8KcmxzBC+Mdj7Vm/Lcfd7EE33VO3VRoBvvL14zmUNowk4hrAd+BDOVgkOPicK1Ko23rH7ThthfmGeU75TCJI3pzzTQPbTWJXe+oXIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMDZRqk26TMrc0Ka3JIOcHajklldoNJk+tTJ9QaToBk=;
 b=rQdDBL3oV+Yj1+abDDxw4HoaUy7glAYvNCeG6WMU/2QqNePvatldJm2zWApo4ulfs22UiZSWYknM7XnKZk6iDkzWMYwhbnVE5swU6w/YY52KLTqqu7T2I8HJbYynhWUkdGdIh81G7FFRiFnhO07TELdCisw76gsIzOC7rDqwfu2Zp+k6PvzqTl2W0ig0eJxxEY9YhJvWnbURmz5VHYnj7ozq4PpT3/NzNPj+ZDKpt8CX0RMd15magtfJO6LmRUT3S1LxEFQXV/8QJTUqes5F1q77vin9xJvlyHE/nHdAyWpUMuZFoRRfbryE0xOQ7KwlMlgagQcZ+ga5po0FfDxlLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 18:00:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 18:00:26 +0000
Date: Fri, 12 Jun 2026 20:00:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cui Jian <cjian720@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext:SCX is preemptible by the Fair scheduler
Message-ID: <aixJL-hdL8LfOA0H@gpd4>
References: <20260612175113.110447-1-cjian720@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612175113.110447-1-cjian720@163.com>
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: e416c7a2-2e60-4c11-86b0-08dec8ac7add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EsA/zPDR6wL2m6GAuqeP9juaxv0wrvv93H/iK6BSPulW0CcczicDpSbwHtWf6eglCbiD5jFrbkkxppgYkw45ExcaahgEXZuRYwRlaq3Ey7MqoaKwUqm8cA+QZTh38sF8pWCVeBSFNkG0xZ1s/x3zDCQvbLtFLbMWhkOYpX0HRp7uOvktf5pSrhNS7/blNiALZ4RAxF7kMkp0m6/N4h8HwOT5zKR3C3OJkPNOBnyo/eYBzK0Oq0FJVZE9pbCkNBQmpJp353Rj+ZqBCbgceIkAjnWzjz2t8an2v6j2cLLzYZcx3IT3FUxkV6aStW3IlKz1lavZ6MR6K7IdG/ZORqKYTtczYzjpXfRlPyqv1GDx8bg2hSL4C8furPGPOFV8Y4NdxhbvUcqcrUbJmONzi3GmDRy8TZxiy07mZOOXofcS4terbVOKjyMkUwoKe+MISA63CCp42gpeNRUy3XhmatYpPdqyY775fYW/czNuQaPrkI3E3nTy1ITOfyOqo8dK9y/6qkQB68k6O8WIjghHsXw20V0XY5F2hkvMvZXnOoz1U4WNFpPnU2V77FZir0i/NKuiRoc0J5p1YafDZ9je5bDozi8yfDZWOLujZewdBs2BJ1kwoViH6UnX7IUGTk3hFRtx6ltU2Ik5aBIY/AVdGU1jZuV0g8OGEDXrIaFVuCLuBNjtVSN/+QL1PsS7Bu7awTkF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/cBIgkC85jUOV7rjOmfdcf+izKdyaXPbvKu1YQwWS1RNVtqelyAcjjawYVzz?=
 =?us-ascii?Q?ztN4DoDoL+banYSOrUEcimSX6Jgd3kQdsvbwiQEUDUhAfVn9Hcv8CLQyILM7?=
 =?us-ascii?Q?yyjT9mN7fgliGpKY96PPL6ZMaePrAjCMOIR2UVsxE470qCbv1LYbnR/ZcAyz?=
 =?us-ascii?Q?7LfYnRp3Qfdagab20mJqAqYMtLXs9FkkREZyrQL1I57+nuKoiovr6y/rRI1w?=
 =?us-ascii?Q?r3ME6lp/KaIujjpP5pR8OwlJmVec5auoKxhTTDE5uQpeLPiuvrzif3aLHBwt?=
 =?us-ascii?Q?Dlwsic4UA6GF29wTmGXKUqgzW9TmbbHtevJbru/oU8U4LBgiE8GvqYWqA2nm?=
 =?us-ascii?Q?qY6rRm0YoA6UOZoLQfMQLUWY0MGSHpE327HNgO4U2KhpReevE9p5BJbRFI8M?=
 =?us-ascii?Q?ASxql2BECCQ3ImsD8ICeun2+ix4xvHtYRy5xgvLs7+L/BgptYopL759DJs0A?=
 =?us-ascii?Q?degkiVzJjPmGvCc3vieX/2/hgTDfcoUPTED69fWd6uxmxkX0uvQfCPIHrIyz?=
 =?us-ascii?Q?kpIimN5+1BVPeHBCtttk6Rt8UTxfddMbMMx4FG0YYAsTd4m8Mgoe3B/LfZbW?=
 =?us-ascii?Q?tMy1yleQLnTuZsku0m3/fE8d1WynEoJcElQ+tnzpqF29fbU1OWBrLKgrw+Bg?=
 =?us-ascii?Q?ELT/R1YTWatlsHCyJOt2I7U0Zq1UMhN+gUpi6W9SO0PQO6dF7oIIzr96WM5w?=
 =?us-ascii?Q?khSEmBnogYlLIeFegVYKD5cOvR71esxNMo8a2jva2pgJc/wYSRDi3Yzg++o7?=
 =?us-ascii?Q?ejhvm0PGa9rWQCFerfO2W2fdg7yaI8ijrzgxgxWuu/L/jIOmv34hKkWTX9hW?=
 =?us-ascii?Q?DAoY5XX0eI6pSWkyUgDRjKh4TUsqfFzW/Y3fv9yl6OM5uryizjrggeqFqQsY?=
 =?us-ascii?Q?K1UfY5JvjW2Dps9+uW6EQ4YJ9FyjUNcpiHs2E4G06r0ojzeszqXj8YpKkYB2?=
 =?us-ascii?Q?NmLiPKRuOWzcZHFlKNJEnvV1jJTGZg9RzLqp5+j1CbolkEKnEfBLWR532/K/?=
 =?us-ascii?Q?At4WZYfP7JQ8My9qPEpQV4mIxJcGR+CE7jmKMzEnuhNx69i043FmzAFrd5iA?=
 =?us-ascii?Q?esWTsE8q6gdyhhnXm81KClBxUZ+UJG1raHRqwef+nfsQYhE0Wj8qaBEB8cc0?=
 =?us-ascii?Q?IcSPgd02a7+1TGvgbp8NqoTsvy1duGEwSSG/bIL5KSn+19HcpYoCfGfS6xUA?=
 =?us-ascii?Q?JEZVlVpLY29ES5TnZu3g4W1PeAOiiO7d0a9IvkrI+pSmMtKLlcxTsKJ0ptRW?=
 =?us-ascii?Q?goY1IwvEbgmdVprOSzgmOPGewBClPXrCiTl20dKuCMdRiwfwZLwOqzgYfeka?=
 =?us-ascii?Q?tMQHFrxiBTyLYN6GiNi+3aKEDJ99ALrr0G+r0qi5qTbtOgflVMpkFl4d3E+B?=
 =?us-ascii?Q?qDve7AOMLOj8Wp050+fJlmwgbMndQgS/d4hWyiS9+v7AQ+YZu27EZQQAECTT?=
 =?us-ascii?Q?66/weZ8HHdGlNETEIXlAvu0vcA5kz/G1ee9RLcN3fQUe9DUHWdHOUm/mTOek?=
 =?us-ascii?Q?55Tg3qqss4OzqqoWMYuEO7JiJs5V9yzmgftjHLQvr5gTUEvUthL2P347Gbwm?=
 =?us-ascii?Q?Jh2xFe3qbJUwQrn/RFC2Qg4vzArYjpcaoH3rwNmT5+GhNyUkh7gyHT5CgutS?=
 =?us-ascii?Q?644Arw7RK/vxIiSrYlX645Jk7eQ0t61ab96Rrk+N1NSdq0L4B8rmrde0aubV?=
 =?us-ascii?Q?9LefK4qJod6ap28Xy38d4zAOkbZu7sY5DQqIqXiK/Izgxf6c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e416c7a2-2e60-4c11-86b0-08dec8ac7add
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 18:00:25.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo4pSa003sIpwwSgHz4HUo44ZkFEkSi/FaHRJEyOY7lbhdpnNG+XvqnLJDRrkJpi1CIp9RepBvWqezzVJY4yPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

Hi Cui,

On Sat, Jun 13, 2026 at 01:51:13AM +0800, Cui Jian wrote:
> Hi Andrea,
> 
> While this callback will eventually be deprecated, SCX is still a relatively new scheduling framework. Incomplete preemption reason enums make it difficult to analyze interactions between different schedulers, and filling this gap significantly improves observability for existing SCX workloads.
> 
> This patch does not modify core scheduling logic, introduces zero performance overhead, and adds negligible long-term maintenance cost.

Please, don't re-send a new patch just for this, at least you should add a v2
with a proper changelog. But in this case the discussion can continue in the
previous email thread.

Thanks,
-Andrea

> 
> sched_ext currently distinguishes preemption caused by STOP,
> DL and RT scheduling classes, but preemption from the Fair
> scheduler is reported as SCX_CPU_PREEMPT_UNKNOWN.
> 
> When analyzing SCX scheduling behavior, it is useful to know
> whether a task was preempted by RT/DL classes or switched out
> in favor of a Fair-class task. The lack of a dedicated reason
> makes debugging and observability more difficult.
> 
> Add SCX_CPU_PREEMPT_FAIR and report it when the next scheduled
> task belongs to fair_sched_class.
> 
> This change improves scheduling diagnostics and observability
> without affecting scheduling behavior.
> 
> Signed-off-by: Cui Jian <cjian720@163.com>
> ---
>  kernel/sched/ext.c          | 2 ++
>  kernel/sched/ext_internal.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5d2d19473a82..6e0281218197 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3015,6 +3015,8 @@ preempt_reason_from_class(const struct sched_class *class)
>  		return SCX_CPU_PREEMPT_DL;
>  	if (class == &rt_sched_class)
>  		return SCX_CPU_PREEMPT_RT;
> +	if (class == &fair_sched_class)
> +		return SCX_CPU_PREEMPT_FAIR;
>  	return SCX_CPU_PREEMPT_UNKNOWN;
>  }
>  
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index a075732d4430..3ce07bec58a5 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -241,6 +241,8 @@ enum scx_cpu_preempt_reason {
>  	SCX_CPU_PREEMPT_DL,
>  	/* next task is being scheduled by &sched_class_stop */
>  	SCX_CPU_PREEMPT_STOP,
> +	/* next task is being scheduled by &sched_class_fair*/
> +	SCX_CPU_PREEMPT_FAIR,
>  	/* unknown reason for SCX being preempted */
>  	SCX_CPU_PREEMPT_UNKNOWN,
>  };
> -- 
> 2.34.1
> 
