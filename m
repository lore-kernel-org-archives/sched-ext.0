Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198D288D0
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829784; cv=fail; b=CT69b6plo9Kbfeuy3lsHFDdwtxAwKBnbmTAqZYP0+r4vmart4qS+EE0MVFs11v47888PSXHa//iK2kFYYwy47Nl3bl95by2D8gj+wDAVMwrfqU4MxQ93ax7odmpoffjiw2DRzm2FVV8NXv3ejv2z5dlPakMACACK5uLS1EpmX/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829784; c=relaxed/simple;
	bh=7yX0adC7RGqgfYCeMvFZVYO0RuQdADJHaEsHZAu0k0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l4atPtuHN3VJC88H31esoFK+JFx8LgAHEoKGAtdgiWSi4axSLZYA+P5zdfB6nk3UJwNDVPDbneZiTjuoONAM1gN6UuAJomIMZBOpAIGFhvs5Zz7tiahamWPRNf85nhlSK2g4Kwhw4NVQtM54Hh8mghAT+ibpLD5Xhng37QfedD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXQWC/gl; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXQWC/gl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3EDFoNI7qPYp1D5lJAi6RajZSHTufrqS88qNJdLA/VjHar0htGwRH8kVWmQ5xSyMVEWb32PDebjothu8gBESIziKrvkBERfQr52Xh534WVe771rxM7GgfvnTZNYwCNAjdAs6q8SAZD1aHlWwTdVDbMmVgCQyxQBpBkyQwseCbYJD5KV3pTGQ61Jucj7tUxzZVL0vDimnTB1wabfCs0ICKV7qgaTx2rem5fhieJRr42XDR2i23bIw/pDI1KTo8Q7M3ZZF1x2dj385t1+Sbvh4jfC0A+Twa5h3Mpnkp0bPaYDlvDD39rd74Rj0yaIZFX9B1o5ZIPz0/VPnZ4MgZTXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAc77OJOzbCgArKMPgyKY9vfx19gzLUPT9+bntfBppk=;
 b=lJT0KaL30Nkh0xgid/GtjiPMVwfenipQIhKHRH3tXOfNkbrbjgN8edrLTXKkhuqiiGq4c8hZYm3bjNuMt2zK2s8eQoXkDAxurAexqL0L9um9gJl5Ar3orGQDSReXOAts2/BNH//KWtV9ZEXe08C7RZ6Qy02+OgEL9slIzB1zcbZzglS0zAjq32svFVdalBXEUktICOLgf35s4ZAso/3PohSzOuDGqXY7Py5/doE37GYQEoK/7gGswrWCrvus2Wj55vrTJ9KBuwQNsbxTsgPhF70ZRvpdZ2C7p7Vea76lI1gs6q4HDhXj1Hy/c9Fvl9RUnQ2Y8KPjrO+uWWaLjnAd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAc77OJOzbCgArKMPgyKY9vfx19gzLUPT9+bntfBppk=;
 b=qXQWC/glQz8nBfVJ+7OKwjgBsnZmJCeC4wy24QPdA69J49tWhxaZSzzIN38p1bNS0YgTfcvFDuRjSWIhtUB4219uXSmpM1Vv82P+x4vJeA/TR+hN6AhS7gF/4tfz3R9LMJjHU4L0bou2ZlEuL4sDwncRASH30awbi2NtOic/mjNhedXCPNtNcNKkUXZx4RfBSE8WomA9iBnOUEeX5sL5kInbfixYFrqwjFbhu+J2nJOZ6tA6s6yJaL5ImcO34ur3z3b+P6Oxgvywg/9KYbGSJKm1qaCnScaD+RG7LJ1Ovb9j7FX+ojoVhPzbPjO+RTbpx6isdLsvEQS6ql/cu/OyzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:29:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:29:36 +0000
Date: Tue, 30 Jun 2026 16:29:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Replace open-coded event
 lists with SCX_EVENTS_LIST
Message-ID: <akPSxgP6LKir2OrX@gpd4>
References: <20260630140645.8855-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630140645.8855-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b63db6-2e64-42e1-852c-08ded6b402b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nUfFjZue3mZQlFYCqgLUbG715+zvmQeKDVX3y+sw8HXAOeDVpfilPw8NQcYlfbdjsCxooAdDW26sf8Xgov9aBW7w8linZDeJVVjm0oB8OI3nIl1LLI+2pPcV5HtL8Aq0GRUFAXK8QFvtUad9TUvKP3sIbalfC92QSCXCDgFVBrfJve3LBlbdgq46fvq3h2BC10RpmFYhX2zIjS1gPABQ59i+RlyP5aryFFwcKcA5F6v6iu45khM0eQUWLVZVo4HUkQ+UgFqwyn+mNiOVuaw38vwR6xLp645FUD2F16v705tAKsUlJmET8j50Sl4A39iBQ+Nrn2ACdGdwK1hEMZEANDk5nLYRNP72wAa1dvRF9crp6mTckYP6L0k4LfXz91DO/n214kI0TgdvMp7YpFNWkoLrxSX6lPnwHqIJXTqQwtIbbQal6njQFkJJYX0DTEy4ceqX77jhQTFmfGW06O0k63OhZS6K9DH7E8Thah2n6h1cGajpO0audnQAv4ia82BAqq8C8ivUg2bT2C9QO9edAeYnvDgIZFt/ZHMGuIdDy8ceq/uk3M7hwk3ZSM+1SB19afDoPvuEtS1CUEQW75sXV3RLGpTrWn5JX6s27+7mkLUKEpqiT+6kw+USzpGngjeEuRwEoHlXRx3pHM33PjPfd9XKz/elsZmMKe4lFieSwNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSsbfh+5F4FXN6du5c2EtCTakY7dQUjSROsjvECLQb/A+K7XYdBL5+e4YeO2?=
 =?us-ascii?Q?iwoCj4FmkO/3B/MqgZbW1Ce03/OWLwGdZ4E7+yfDmc134r0Kq2ZJpdoT1ttj?=
 =?us-ascii?Q?lBkeLCSjMvCz2jkcV5uFyPSLdvD8JXjQHXTdQOmQqsBI6jxQwYE4B5HzKWVM?=
 =?us-ascii?Q?ntvY3sX1kRY8vbEAFgjJhOzFuoNuPNqwPd+ePa4CWlBhqXudT36muW01H8u3?=
 =?us-ascii?Q?jC4LyplNGhiU3kcoWYGLnWU+Mpb1eDI6fnJJEQyUMvOCK54En+a2r3/VxIib?=
 =?us-ascii?Q?PlwKlMrszEXHrnkBLbvi5OwsFDXr32JsrDgw82XgnpSXkLNTSB2QWE11sq57?=
 =?us-ascii?Q?Co7EGRB2LIqmbMieZ2e0dvegnEfRqCQKwbx4yE7QntPIb7t9/GcdQcK+Murf?=
 =?us-ascii?Q?g4DZ6RD0w2RDnvgkapnk3lWBTKFFxtQXs7NWWefRKBCJqSpUiOliAI/6lcGA?=
 =?us-ascii?Q?2J0PEk5ndmnq9zRHOszZ5cWKWrom7pEylVio+hxvwSNW868K9nikYr6SztwC?=
 =?us-ascii?Q?CsJLiWlFaZcJZKU4badGwG/XEJdrTLR3AovBuwEKLs5yT8gy2OI3u/RTpFN4?=
 =?us-ascii?Q?r0jrM4oGdfo7GdDe/s/ZUuHv4DtX9oydLnXw9AgZmn+oXN4fNxO/+LqndTcE?=
 =?us-ascii?Q?L71pFc9f3uW7Zf5CfslG5f6GXWtvB7MwG8wcCzsR+6inWtpe1tzkT3A0gKgh?=
 =?us-ascii?Q?zTnhqGnjWHuHxCyi48gfPHkVJR0inTMB/REl/YhoB82zxYozp+fDTdafzzie?=
 =?us-ascii?Q?f7zXPmsl8kGeMuOvjZrRkrT24anN318OaJxgOfUCqpD2qsN5SgiFqq300He/?=
 =?us-ascii?Q?Oj0hadZxQEidKfBS0IXJrn65bY6arIMBmNcg9pt/l2LnhxuQtPfzn7jn754f?=
 =?us-ascii?Q?q7q1zeE1G6rsxrfx6+7KrZs6MaC+e2HBUNS0Xjfp7duZPWlAVEOpzqM903uV?=
 =?us-ascii?Q?gz0RQBhYpQzGnJB+I4P6nWOUFiJ3Lz1eg//L205qQ/NZCsJn0U7RdFL4h1a7?=
 =?us-ascii?Q?6JvcbmFxr82zdJBiZKRPRI4f/NDCnWd0s7g8LE0HZejaBma0lF5ZDDMOqUrv?=
 =?us-ascii?Q?4jAX4HQkAs9pmqKIq/EONs4GzQ1y2enn6oFr3a0lCk7oC6Z+Q0fx915br1Kp?=
 =?us-ascii?Q?M8puxJ4ZKsk0zox+z68MMkn4MbtYPkXTWeumz9KxsKg7+hKQw6EsAQfFYaer?=
 =?us-ascii?Q?IaNPMt1ETSw25WjVmzbLlJkLyiNfScqY/4V3+T/HLWZGVFzbXozKCjpveAsp?=
 =?us-ascii?Q?8RYu0GwWZazlcDhrqGXJrUH8ABkbFqTeOX9B4TIAlcPfZzaP4iQj+03j2CPO?=
 =?us-ascii?Q?syjNfaq40a5UHx/c7rs5IR5sFTSjvv07njvt3HRwKkskYvNyFksdkcK/Jm2l?=
 =?us-ascii?Q?M3b/xtBC7RFLuuJIJKmlE6nwn1k9xoHsuuihkfyrq3M5NzI5l7yb9laCrRqU?=
 =?us-ascii?Q?pbWbDLvMByFDMw7srXkd3IhAaI7GWlktv29d0J4FLHcEhZCEXjZaSkAIy1nj?=
 =?us-ascii?Q?aAeHSDAJLO0bIFKVKXrYlQoLtSxeDSX7Dst4tDYkeAMEYYW/4csjCG9bRUKx?=
 =?us-ascii?Q?J3X+XTsEiyntFXKc1SiRUFWkEo/axg+zCktqrIdCs9z8wTyWdB6kKNOku6IV?=
 =?us-ascii?Q?SY5qpZr0QVFrn8am2CuN9UT3RgVzLSXrKuNVYgPLKXqTKfFtf4/tlXa+BMCi?=
 =?us-ascii?Q?l+wZ9m8cUlAH4EcC8mb9gaNdvR2AiMidbXC4xmO7qZxU9gopvV1LRPr7iyER?=
 =?us-ascii?Q?PDaHmyaJYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b63db6-2e64-42e1-852c-08ded6b402b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:29:36.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFgI+SRYgN9BVJwUJxWFaz1boithHgsyfh45SU3omO0/ZhvG3M9Rve1Eixmpk2fhvnErCa73F1ZY0+/YxO90hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Hi Cheng-Yang,

On Tue, Jun 30, 2026 at 10:06:23PM +0800, Cheng-Yang Chou wrote:
> Three sites enumerate every scx_event_stats field by name:
> scx_read_events(), scx_attr_events_show(), and scx_dump_state().
> Adding a new SCX_EV_* event requires three separate manual edits.
> Missing any one silently drops counts or omits the field from
> diagnostic output with no compile-time indication.
> 
> SCX_EVENTS_LIST(SCX_EVENT) in internal.h becomes the single
> authoritative list of event names, so all three sites stay in sync.
> 
> No functional changes.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

checkpatch.pl is complaining a bit:

ERROR: Macros with complex values should be enclosed in parentheses
#62: FILE: kernel/sched/ext/ext.c:4964:
+#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
...
ERROR: Macros with complex values should be enclosed in parentheses
#116: FILE: kernel/sched/ext/ext.c:10267:
+#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)

Not critical, but maybe it should be nice to clean this up.

Thanks,
-Andrea

> ---
> Changes in v2:
> - Use SCX_EVENTS_LIST() in scx_read_events() too, matching the other
>   two sites. Drop NR_SCX_EVENTS and the s64 cast loop, which assumed
>   struct scx_event_stats is a packed array of s64 (Tejun Heo).
> - Link to v1:
>   https://lore.kernel.org/r/20260629143532.15014-1-yphbchou0911@gmail.com/
> 
>  kernel/sched/ext/ext.c      | 61 ++++++-------------------------------
>  kernel/sched/ext/internal.h | 15 +++++++++
>  2 files changed, 25 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 9c9cb9d08bca..0c51f9826a77 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1004,16 +1004,6 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
>  	trace_sched_ext_event(#name, cnt);					\
>  } while(0)
>  
> -/**
> - * scx_agg_event - Aggregate an event counter 'kind' from 'src_e' to 'dst_e'
> - * @dst_e: destination event stats
> - * @src_e: source event stats
> - * @kind: a kind of event to be aggregated
> - */
> -#define scx_agg_event(dst_e, src_e, kind) do {					\
> -	(dst_e)->kind += READ_ONCE((src_e)->kind);				\
> -} while(0)
> -
>  /**
>   * scx_dump_event - Dump an event 'kind' in 'events' to 's'
>   * @s: output seq_buf
> @@ -4989,19 +4979,9 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
>  	int at = 0;
>  
>  	scx_read_events(sch, &events);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_SELECT_CPU_FALLBACK);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_IMMED);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_LOCAL_REPEAT);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_REFILL_SLICE_DFL);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
> -	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
> +#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
> +	SCX_EVENTS_LIST(SCX_EVENT);
> +#undef SCX_EVENT
>  	return at;
>  }
>  SCX_ATTR(events);
> @@ -6651,19 +6631,9 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
>  	dump_line(&s, "--------------");
>  
>  	scx_read_events(sch, &events);
> -	scx_dump_event(s, &events, SCX_EV_SELECT_CPU_FALLBACK);
> -	scx_dump_event(s, &events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
> -	scx_dump_event(s, &events, SCX_EV_DISPATCH_KEEP_LAST);
> -	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_EXITING);
> -	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
> -	scx_dump_event(s, &events, SCX_EV_REENQ_IMMED);
> -	scx_dump_event(s, &events, SCX_EV_REENQ_LOCAL_REPEAT);
> -	scx_dump_event(s, &events, SCX_EV_REFILL_SLICE_DFL);
> -	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
> -	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
> -	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
> -	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
> -	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
> +#define SCX_EVENT(name)	scx_dump_event(s, &events, name)
> +	SCX_EVENTS_LIST(SCX_EVENT);
> +#undef SCX_EVENT
>  
>  	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
>  		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
> @@ -10333,26 +10303,15 @@ __bpf_kfunc u64 scx_bpf_now(void)
>  
>  static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *events)
>  {
> -	struct scx_event_stats *e_cpu;
>  	int cpu;
>  
>  	/* Aggregate per-CPU event counters into @events. */
>  	memset(events, 0, sizeof(*events));
>  	for_each_possible_cpu(cpu) {
> -		e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
> -		scx_agg_event(events, e_cpu, SCX_EV_SELECT_CPU_FALLBACK);
> -		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
> -		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
> -		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_EXITING);
> -		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
> -		scx_agg_event(events, e_cpu, SCX_EV_REENQ_IMMED);
> -		scx_agg_event(events, e_cpu, SCX_EV_REENQ_LOCAL_REPEAT);
> -		scx_agg_event(events, e_cpu, SCX_EV_REFILL_SLICE_DFL);
> -		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
> -		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
> -		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
> -		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
> -		scx_agg_event(events, e_cpu, SCX_EV_SUB_BYPASS_DISPATCH);
> +		struct scx_event_stats *e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
> +#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
> +		SCX_EVENTS_LIST(SCX_EVENT);
> +#undef SCX_EVENT
>  	}
>  }
>  
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 75522a5f28f4..0256931a379a 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1051,6 +1051,21 @@ struct scx_event_stats {
>  	s64		SCX_EV_SUB_BYPASS_DISPATCH;
>  };
>  
> +#define SCX_EVENTS_LIST(SCX_EVENT)					\
> +	SCX_EVENT(SCX_EV_SELECT_CPU_FALLBACK);				\
> +	SCX_EVENT(SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);			\
> +	SCX_EVENT(SCX_EV_DISPATCH_KEEP_LAST);				\
> +	SCX_EVENT(SCX_EV_ENQ_SKIP_EXITING);				\
> +	SCX_EVENT(SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);			\
> +	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
> +	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
> +	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
> +	SCX_EVENT(SCX_EV_BYPASS_DURATION);				\
> +	SCX_EVENT(SCX_EV_BYPASS_DISPATCH);				\
> +	SCX_EVENT(SCX_EV_BYPASS_ACTIVATE);				\
> +	SCX_EVENT(SCX_EV_INSERT_NOT_OWNED);				\
> +	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH)
> +
>  struct scx_sched;
>  
>  enum scx_sched_pcpu_flags {
> -- 
> 2.43.0
> 
