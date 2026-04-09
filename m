Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDD2F49FD
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713504; cv=fail; b=TJolW8JZLBtgoKX2jH0k4KSizJ6BfPngZ2T0wmMdnXfekWVadeqD6KZFs3AKSF41beCIyllHtOYwLsFieUz2x8FIFx+0afORvfpRIUgRerw0sC9VTD7/ZSB1o3UgGhhyTqZ9YYAzDpYM+WJAXJl5SjWWQS3CS//P5c9GymWIjYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713504; c=relaxed/simple;
	bh=+tJ2yxeOrV/oBQBSi+2L75MoWQp4OGOMYdoJl++XmPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMHyE+9xWhwGhy6IVmFyakBgOcXVNKWFAT3MNvGa5LztOP0QLqNR3oFDifCRQzuUSfOiGzujT8pGpwYYHlCVP7eVfipOB3gehFUuIuywJynEkVYS/F22bL0ej6R4kmJ572N2C+o3qdDuJfcz12soeYQ4iu297kyk2cO77TlgnXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ti/Kl1IG; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ti/Kl1IG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeWMq3GWO+CCr5MbP+6rfh1yjVxqMqDA2nEDvxLSOx0EZFhO/JS78nbdii97bgZ3kFRJkL87IeP3S9OLNOmxKt5pGGthqkSaLFTXxLOOsmSUH02fx+p4WmmWPk/Qh+gEclVvovjozTnFj6EwjqBZYJaOijvRGuTXca6BTpBwfP5Zfk+p5trBETY5+oLQVh2Sr/b1OjsqpLjMXIPFd9hLIZDbARYSkVmIb6M+JeiBha7ttmdRxGw5xf5C2A8EkI+clojdX+R6whmkuBk3sTJAZt0USknjm8TEJHpBynbun2XzQtEpGTSXGU+w6ld+Vb0yzn9q2NcKcHl4n+t8GWcyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/rcP5RpYfjSWKyJN5qpbeyn8swzq4H9nldRaTL1qwE=;
 b=ULYCzbYkY7c0WWoVfB1sPWNQmL/EStk9nypRjgeKGDzyCaeC0WhscsfQ1GNrwly1N/+FTSXxXc1OCNQsByExxowYOinAFTRxziv2FLJYj6Ac6HC7rpCQTGZugvaK0g9/M9wL2KNhe9yFDATgIxQcf/4Q3UkU5lsYZcBBSWBtuFzcIkkNUpcypKO0wiTShJ55AaFgre8gB3l4BTVg2hpLfn9cSCngQJr8nta2c8eZYr3Y9XKd81hGdxtuT+BbTwJzsm2JdKW3MdycrOBR8n52vYpoU31IZRSIytShvHVC/Uvn3TdIO6D0alwr6N8QdcePM1pYBAqQrUxF2kgZTRN/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/rcP5RpYfjSWKyJN5qpbeyn8swzq4H9nldRaTL1qwE=;
 b=ti/Kl1IGIbmgznuP08cY8zs2niad3HwrWH4e1VQNMPMTyAKEDKkWpeHc/TuEbVzb7uwkM5vsMCI7zn+mvix5qX3ksyW4ZVtZLhI27cYm5BFMP+yzDneTXn83ZQD8gI/jTVmNLvuGE724WAHOsPFNzRQnAELngyNsnkMoqGIXyKz4Vt5MICAcUeq7Z0fL2wUgTd2MN7GwlnWD86H5DNcU+GEPOEsl+eHmisbAXng2LOkly58odaHj9QdAX0JGSVWovq3Q6ziezZLG6CsK+wmf4A56OzNAalDEkAObuolTN1h7sCD1y5SjHSd3j8mA2ZUAFDPtEtKb2a2ADhoLW5Hyyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 05:44:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 05:44:58 +0000
Date: Thu, 9 Apr 2026 07:44:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
Message-ID: <adc81Une7-LrDLrR@gpd4>
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408031113.76005-3-changwoo@igalia.com>
X-ClientProxiedBy: MI3PEPF00004E9B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::457) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: a5564379-97fd-43b3-6d7a-08de95fb226b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dM1gxA4hiR5VChLjIjZpHvuKs4kqlrQH+qFu1VVXVQOd6TB/nK2O1if/SnqUXEhwSk3pxXRUYM2wTQWhVK0Ua5c4HgBZt9aeo9BOy8sPn5+S/qYu38pShnviK4udJ8mc1ejILHxnxLM3JuWw3Mu8U+8nqf6NULFT6Eq+gNf1ZtIfhcKiJSwoRO+P/WtdZRPTncf08h/ENBgQ/+P4+wUVOBnwcMANJrtj8UI+unLs8qTwlFu7KSbsGxqWi9lo1mP1rfSMGn3AJA6/6SgjP2lTUNIWpo/z6zMTL/qrmalWEQDv6k1ZEDvQMa22moIzmuV8gcFPGg6REkNkwaVtX+adgzoMhg0Fvq/5sNvDPCiO5lmDykgDrIIRed9ZNudqfQwvTKPO3gzGZNzAL14eCQzkfbuBc9je7H3C76aG0478elZHmYsfuJ0w860DVzsoVpqV5idAFm1R+HKw3czJgLjSHVGn9r4mAdUayHjJc5Fhb0V9W2FM3i9BiIIJANFzrejwQWp3+uSq76LHnNTT1iAQ2c3BpZ62OHSEDD3HIPymQHouIj/2MhLpQ476JrapG1E4CWr9Mt0nnOtCTyLz5kjbYwGu+9wJkd0Z/zPFEYqwzjZvVzTdgb1WRtQwhPREgCYboQIdAYx/BiEFb1Da+EKCstMCkabmrp9olhOia0buP/dU1qT7bOaqEVuhTxiCdb0kpwzW7nGOFh50RNQdVKHZHJlFPf9GYc22wsbIzvVvCmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kkfqy1T3hWzG94bo/habgsea+ZKBoMvmxl1bqvuOHUIfXCHu50iE9nvLTNn5?=
 =?us-ascii?Q?QuoySLI2hDQNJvXfz6wQK+nP5TE885wZcAAbtn99NIoLcL0kNKOrd0xPEfTp?=
 =?us-ascii?Q?ZMCdc1MZHJuGLS5E7nVkqRRs7TQlrVhl15fkkNdk5qZNyEtGeKASlM5XCRl5?=
 =?us-ascii?Q?mF3UYLe2yUw+fG+flArjMzFADL/w0d3loa0bHhG/uiq63OJ1eh33MeOcmWd3?=
 =?us-ascii?Q?bTeMBfDsw9hz31Tg9oh9/gnto+8ys6j7H0tvD8tWXxTHhRFKdoVXf8Y8T+ik?=
 =?us-ascii?Q?KwdjVVs6qxOBGgvJX0BlxRFxFjgoMVpMXuMeHVEoTtP6Qh31ZVi2nvU2ZTW1?=
 =?us-ascii?Q?uTGFgXLDULCv/IgTju90o5EljE+E77Kxg0NpeUZLbxs5qto2oJNXmStWxXeX?=
 =?us-ascii?Q?SzYObmBxe0zF69otLfn0If4F9QLGmqCjHidl0tEFCm/H3e0BM6mz1dry8WrW?=
 =?us-ascii?Q?oPofwTL2vqz/EaZQAIUebhxWKOp39lm7nmKV0lR76NZN8dG1K/tgha080eGi?=
 =?us-ascii?Q?OlOck0iLYlh/b8BEapKGI0FowzgzPX+22X5RmQ35kELT36GdfPaeX11UB5Fv?=
 =?us-ascii?Q?6RQUfqpU3jXDpzMVbcz1NQPY65Msfsd6E+M/EinRsDWLKNYEI6lEdbytxFsA?=
 =?us-ascii?Q?I/AR9uKJhwOBGxsED3mhcZhq8adan6yVjSFsHJN08pAgr+dAIcxtlgdwEDxV?=
 =?us-ascii?Q?8zT5hwppdSXH4x7yti7wDvVggZL+nHBNz0ClPSogPi5i1IK2Epktgwoj2br/?=
 =?us-ascii?Q?VaFKqpBDSMoEiNDHOqYuIVLLQIaBZtx5VKboyPvma1H5e1q8oIlNL3MFl+C4?=
 =?us-ascii?Q?yWqkSR9TBTg4UFzzSM89ZnlhEZ7W8od5UIP8vGMa+P9NP1jpc4MUCXt3iiTg?=
 =?us-ascii?Q?Gi+dt1VDVQo4BZ5eHlZ8cwbZrki+jFfeDhmjz02CgzSZTwcmhY6LxeIkRZA5?=
 =?us-ascii?Q?HH5raB6ai0qJX9Kswk9iRcHX0l6803hRRUr5W969cBYJJHDKprz6zledZw51?=
 =?us-ascii?Q?Aq5Y6RNmY1YVj4pOpdVlsTZ6FM7WzQaAsaWjdxj7c7I5MJgEkeo9xEg5TTgW?=
 =?us-ascii?Q?aYtYIEgnG/NCXg8jnbqOySD9cby9Gj675gW8IvUxJ4kwct8/DLazf6ajuQ3c?=
 =?us-ascii?Q?WOXbRQKBiq8kelZ3TV2sM0iZZJDrpGeWfB7moN/9S8ybIauACuRodNJJKHyK?=
 =?us-ascii?Q?pbT91DePaSaUSr3mXmDa9PdPUl46dN/iNy1viCprWdyAnmN1SRcpeZz/FzEI?=
 =?us-ascii?Q?P6vxitv5fogBiaZPrYZ4Urnj7uGAUgEaynhHsmSphGNk2pwjti0UwpqY/WQn?=
 =?us-ascii?Q?CNKdYpehgb1jSooj1NBO6d6IuVmRnVIkkf8nCl/DunGxPuVODHwa1rkfOiY+?=
 =?us-ascii?Q?5ynEyNE6AEatj9UFQ+lQZkpmvsC+QbUHWIlFTw3fsv2gV3bTpIxUh60YHE7Z?=
 =?us-ascii?Q?BRBimFfRdW/bf7pdLcd9/SCehBO8aEqiRYdX4wwj6F2E8gRya1GjhxGsjoRn?=
 =?us-ascii?Q?eI6TJq6oeaXxqyqpSmloYN0Kps8mGE8o/q1Zh51/cwMyPxjquiCpt5m/TGka?=
 =?us-ascii?Q?yRnby0T/x6s0Kcp7AZjKyDSbMdQogYfKUKkDCxl4f7Ah4p26i2qkEHa3eQJG?=
 =?us-ascii?Q?nJFlhkc9Y3QQUSniaVYnztH4peZ3SaS5bqU4PrmrIZ5OZzKIi1rVmuotrLYz?=
 =?us-ascii?Q?FWI/onRiDKikil1REg1cdGYAmCH5+IXZzCJ/NemHSk4BFlBeKQpZuSQakZmt?=
 =?us-ascii?Q?3+tKfZ2ENg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5564379-97fd-43b3-6d7a-08de95fb226b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:44:58.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES6PlfYqj1F592zdCerAwxfsw1NdmWYrBRX2inkpi9EJJBmIxnUfCl1LqkNA++PU6KO4RaYir1C7q3LxpFHyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

Hi Changwoo,

On Wed, Apr 08, 2026 at 12:11:13PM +0900, Changwoo Min wrote:
> When a watchdog timeout fires, the CPU where the stalled task was
> running is the most relevant piece of information for diagnosing the
> hang. However, if there are many CPUs, the dump can get truncated and
> the stall CPU's information may not appear in the output.
> 
> Add a stall_cpu field to scx_exit_info, thread it through scx_vexit()
> and __scx_exit(), and populate it from cpu_of(rq) in
> check_rq_for_timeouts(). In scx_dump_state(), dump the stall CPU
> before iterating the rest so it always appears at the top of the output.
> 
> Introduce a scx_exit() macro that wraps __scx_exit() with stall_cpu=0
> for all non-stall exit paths, keeping call sites unchanged.

Should we use stall_cpu = -1 as a sentinel to represent "no stall"?

> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/sched/ext.c          | 31 ++++++++++++++++++++-----------
>  kernel/sched/ext_internal.h |  3 +++
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8f7d5c1556be..671a1713aedb 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -200,24 +200,28 @@ static bool task_dead_and_done(struct task_struct *p);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>  static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
>  static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> -		      s64 exit_code, const char *fmt, va_list args);
> +		      s64 exit_code, int stall_cpu, const char *fmt,
> +		      va_list args);
>  
> -static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
> -				    enum scx_exit_kind kind, s64 exit_code,
> -				    const char *fmt, ...)
> +static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
> +				      enum scx_exit_kind kind, s64 exit_code,
> +				      int stall_cpu, const char *fmt, ...)
>  {
>  	va_list args;
>  	bool ret;
>  
>  	va_start(args, fmt);
> -	ret = scx_vexit(sch, kind, exit_code, fmt, args);
> +	ret = scx_vexit(sch, kind, exit_code, stall_cpu, fmt, args);
>  	va_end(args);
>  
>  	return ret;
>  }
>  
> +#define scx_exit(sch, kind, exit_code, fmt, args...)				\
> +					__scx_exit(sch, kind, exit_code, 0, fmt, ##args)
> +
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> -#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
> +#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, 0, fmt, args)
>  
>  #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
>  
> @@ -3433,9 +3437,10 @@ static bool check_rq_for_timeouts(struct rq *rq)
>  					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
>  			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
>  
> -			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
> -				 "%s[%d] failed to run for %u.%03us",
> -				 p->comm, p->pid, dur_ms / 1000, dur_ms % 1000);
> +			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
> +				   "%s[%d] failed to run for %u.%03us",
> +				   p->comm, p->pid, dur_ms / 1000,
> +				   dur_ms % 1000);
>  			timed_out = true;
>  			break;
>  		}
> @@ -6337,8 +6342,11 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
>  	dump_line(&s, "CPU states");
>  	dump_line(&s, "----------");
>  
> +	/* Dump the stall CPU first, then dump the rest in order. */
> +	scx_dump_cpu(sch, &s, &dctx, ei->stall_cpu, dump_all_tasks);

And here we can skip this if ei->stall_cpu < 0.

>  	for_each_possible_cpu(cpu) {
> -		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		if (cpu != ei->stall_cpu)
> +			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
>  	}
>  
>  	dump_newline(&s);
> @@ -6377,7 +6385,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
>  }
>  
>  static bool scx_vexit(struct scx_sched *sch,
> -		      enum scx_exit_kind kind, s64 exit_code,
> +		      enum scx_exit_kind kind, s64 exit_code, int stall_cpu,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
> @@ -6400,6 +6408,7 @@ static bool scx_vexit(struct scx_sched *sch,
>  	 */
>  	ei->kind = kind;
>  	ei->reason = scx_exit_reason(ei->kind);
> +	ei->stall_cpu = stall_cpu;
>  
>  	irq_work_queue(&sch->disable_irq_work);
>  	return true;
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b4f36d8b9c1d..a0a09e8f2ac2 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -93,6 +93,9 @@ struct scx_exit_info {
>  	/* %SCX_EXIT_* - broad category of the exit reason */
>  	enum scx_exit_kind	kind;
>  
> +	/* CPU where a task stall happened. */
> +	int			stall_cpu;
> +

With CO-RE we shouldn't have any compatibility issue, but would it make sense to
move this at the end of the struct anyway?

>  	/* exit code if gracefully exiting */
>  	s64			exit_code;
>  
> -- 
> 2.53.0
> 

Thanks,
-Andrea
