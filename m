Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC063F4F1
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973061; cv=fail; b=s/WQRxlywysBmJi7JzprkagWpmpuZ9sq+xizggCjJ2f1KM6ls6f34HxbjKQ4tIdDv9f1mwGcGjmAvtfQpGKRz8ZBnPd56Kgkfg2eINxtQFzIgmPjUMCMj4E3kAaMBeKhlVR7/00RpG9SUIKBZsF9P4neuM9EfyWEI/0onDC9OWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973061; c=relaxed/simple;
	bh=qZepK9qphh1xxlhTvvNojdNFg9VRwBLMvaWkdOoHRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHa3HnH2C0T2lZRNWctPwQxlBEcBgMmir3NF6sAwVybYxOmR1UPVK1Q6i0zBca+AybI7FADKVtFmVegi2JgWyN2kcx0F+sXe7zKGI+LcaVb8Evmo3JICDkeNymxnRAe+B9zFJfXwOtBNKHTgWH7ZXyCLNyihXLIC7vd61iTpcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ejQqI/jP; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejQqI/jP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/zNsq6PPkdhUzdK/JlRQ6gzpCxbaMon1I1cMpVTtBHgRLichUTZOoKs/m3U3UXMSPzXYa2DPIg/rWEOCdJdsSjOE5y6roj+zksjkE6GBNztQ3UGdFGJdsDTHa9WvBVObNDbdpR8RS77JG4qeQn3jWNerAMG6EwjFKkUQBo25VGUzMEg5pjW+CqlAOk4GbucNR0Z+h5CgrlVelZ3WFyc5GYO2PPkNCqkPno2ZbvQ5hGPiG+L+Fk97o0DpTFWOXTbSCrSmzVT9zSSXzwxR1FBA4bqoOUZIkmLPaJiiTMAKv4bmOpl3R6t0FwefqKpIiYELXsGagpl83FFPzUmkbU72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GId4w8KUyEcdIDwcPl61mrFa2hiltaHeGBaDrcn1gys=;
 b=mJqzp9+wwesrOBpUKWL0KT7Z08LwyFq8fS66LVj2GEJs2EhZZugApD4x1sQsk+3IAfZXC9wucdwMS3GsIzXJX4ya/UyUfQguy0CIIvJFBN4aTo5NnhfTeDPya4CsFjxdjbDc5NrYlzwcqVaBLw472e8gtHOUbPhPYFDgql77sE1CsH+S0pZlMgDkHd/05DTI8L7IvstTMfPgP2IcjIUKgUvO6FzDBPuJ230DNkkejp6DW/LD81nCjosOBONY2LBHnge0R04no6RgIqcCellVqONBvFOgHRDlUjkyux1PuDXhVH6cWhQ73Ltr6WFqbErp1+UVtnW85JkfPUfW1zjnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GId4w8KUyEcdIDwcPl61mrFa2hiltaHeGBaDrcn1gys=;
 b=ejQqI/jP9lp6zJCTZrRh6L3cillkXyt5npMZnCFo11y3hXjQjnEC38cr7pMfO4tSYbUIQYGdsuIbOi6J8zt+zYk9na2HrK1k+2oDY7pNjCKTNscw7glJpb9PGEM4oL0S4eWsfgdS9l4DMbXPDE8h5bf1EcxWJVdA8j4X5+9x6iYj/qCl2qVAPomkz65MAg1G+QpETwTKS43fJ2fEhZ2w+EWIPfBLM/Em+ycJBFsdBGKY9jghPsRArfGKGFh+xhE1aH136DxugZwj7pmbJhYRT6itqRubiYXqzrfoIJaGkGnLrDxvNtVUDrC8WAEO1NzK5nUYeSMzcDTLQaFhym2ZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:44:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 18:44:16 +0000
Date: Wed, 12 Nov 2025 19:44:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <etsal@meta.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, changwoo@igalia.com,
	void@manifault.com, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched/ext: convert scx_tasks_lock to raw spinlock
Message-ID: <aRTVc4J07gTuESFY@gpd4>
References: <20251112180755.1701048-1-etsal@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112180755.1701048-1-etsal@meta.com>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: af2bf7cb-df8d-45c9-aabc-08de221b7b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AILzbivyD2/OFZv/A3WLdyZif8LBQ+LMVQhNBYXxoSo9RznU7VEr2yqF0CIu?=
 =?us-ascii?Q?qT3/vh5Bpk+7j7OxQgeN9kmGY3pEsNfshgBlLC2TZE3caF+fpAz1TSsvs92P?=
 =?us-ascii?Q?Q47z3YjAzpLSZQPr8ChjSpkKNyIEe1zVF3Ou0d2BAwbTx+gSetPot3JqqKKc?=
 =?us-ascii?Q?ddKVgG6i6HMEjmAJ1LCB2H+UADmrlZdJUQnbnOqZKJ0mqbytwEIT+Npgjd8G?=
 =?us-ascii?Q?SJLAdYDZA7RHJR6rVVEzOdzfTTC/8CZziZogkKzccNHds24zCkwhouyJcq0u?=
 =?us-ascii?Q?OYQwHIW2zvkNLzHt//UnnsIaJe9i1j4twxvVIJOOlD+cW9zCxdWOnrrMVuEP?=
 =?us-ascii?Q?OSITxi1UUG/oDAuBM8k4wCZF678Rl2Nw1hi1VjjJ78smbr6KDZ20H0jUukf/?=
 =?us-ascii?Q?ACrWeBGVJhuQOeVbeE9GC3Jq9a8T7VJ4v2HRV9dj0hSDjBTy/7K2hsk+YaSw?=
 =?us-ascii?Q?9DOQgNFCvkumzeVYQf8/CmQX2GikoD2JgP7OK/PpsjEoeUN5N+ZCgj8dpSJp?=
 =?us-ascii?Q?XqCK8JmV5hRQfZeinZds7KWBZboxmbon3qcMTnrsfsMHrh7Iw2FvJlp28jUT?=
 =?us-ascii?Q?NnvJSb1NLwAxOaTIMIQK3wYh8v/foVGDpn0ZOSg9Pm2Sg4RpLofNrosoutsN?=
 =?us-ascii?Q?2YyYTbH/zXE2YahSLsjWY1ZpezivvobbgsAEEulDK9l0XcR5egmN6xC5BheA?=
 =?us-ascii?Q?vwSDZ5Xyn6mJlPx+wn2acLJus2Dj4kSl8tS32aUXROLQAXyNoVHlJJlYdaRG?=
 =?us-ascii?Q?zHfN+20oB4Dvq+ndjYWlWIf/dZuDLbq7qfhG7BIu4OPiKmbASZnDzb0ZGZvA?=
 =?us-ascii?Q?JJ/WUpYmBS3WjLCOJSPZjjzQ8LCcF0RfR6ZqQBvxUcyACu2DIf0/Rcc1lKm+?=
 =?us-ascii?Q?/7STS5jymfXKyAgq59Xxdu/L59ORBrrlAMZV7VFv9L1zDPsdmKvGekiuXIyf?=
 =?us-ascii?Q?zXoRX1lZbGIlzVb9BB7EJctOl+pw5JwfNsxO+r8EQSDO3Me0hSkhKhmpS8IT?=
 =?us-ascii?Q?e+VAxQVeaolrX14aIEMBPRy//bilttdzxpWnBhS9+wECU0fJsE0kV7c5vcyE?=
 =?us-ascii?Q?kETx6QnBncCfGLqvRClBNGH0RNzrGQRHbCRA1dmvimfAATS17b+s4vBPqVDr?=
 =?us-ascii?Q?FoC9j8/gerJ4+ebqJo+BcQbR5KA8kHdvgH8+BMSQzHnuc6SOYoBnXvHb87rS?=
 =?us-ascii?Q?uEcjtkOC+xDxEImUrEJBDJRKElmBKSnVptuyKzCsLFTGBF1w1GOiJsowh8pb?=
 =?us-ascii?Q?WTHjz8ZRBwXuOskHbAchBxNRXPxzKzFkT8iHS/8kEsRDTIc5CrScBreFv57y?=
 =?us-ascii?Q?+tt+A+msAcoxdRuoPHYz8lPvxm/RKtYqa3eVYlpxPmboY4bGqCr5Nu8K5MBr?=
 =?us-ascii?Q?mmQEgf09oEgCwK6vfOcNRy/sxy2fe7lqg4wHMSYVWdnZVmJ+DDi1YZ6DXA9w?=
 =?us-ascii?Q?PbCJdclblvXwRW9Nst4yGrtO0dmsht96?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hocicz9ANPyNhIjyCE6ZVYFPs2lGDB8aRD0cJy2/QXCOHr70NlBX40x/iaxe?=
 =?us-ascii?Q?O9IgGVT8QJB/7Mt2U844GD2SBR02xTtnZmJmRpCIYh1GtzE9AO2gTGyrPJk7?=
 =?us-ascii?Q?ywgEeJIXUhtPw1hXu+1GujGwdgL0ZtPrBLrwGV2w55g65V0lOdk3chaFZAHS?=
 =?us-ascii?Q?ClfDfS44aV5p2OY0YFf7o3f17lVKmJpaERvF8vBWIsF7ZBLe0rFB8h1gHB69?=
 =?us-ascii?Q?a9gLTjZzf8aeDyobEQd1bJK64L/6zE1WUUSyqF1C4ebTGdHzc+t+Y2+8qtJP?=
 =?us-ascii?Q?0zvQym9LULn5taiHL8K622vFCbZcvy5vR20iUk0drQplRjrUbJ6++Z0Z3W1M?=
 =?us-ascii?Q?5deSGJvs+z6oRezWJY/rVsVORNVMKrCKgUp9VB16fKaANrVN5GIRl18YmPnj?=
 =?us-ascii?Q?GBP9M9tob0l7+wS04DsY2lkaGlW0IAQeKhN34cxS1hMkSH5JSn1tHSHYoUDK?=
 =?us-ascii?Q?Mitj6aiQKQAqIsV1db1cnvtq3gpwfeHH2OxpD8Jfz/BLy7R0YnQ+80OWXhcW?=
 =?us-ascii?Q?5+Nv5BRl6r1IMeMwyVDecuXCRhCwgzH4Xp0walX4mjqaSk82V3UecuGbp71l?=
 =?us-ascii?Q?SZoAYp2Bsr6Q7bxGcNFHdLDrWEX2M5sU0TKGg8uWiBEZEMkS9pq5leJt8nUM?=
 =?us-ascii?Q?Af1N0m3VURseklUI+oqlXuTaqItMG/cTRTNwcgtmE7BByNTXR1KvFwWKi74o?=
 =?us-ascii?Q?WhyOt/y5SqU6cTGc5lwPT0Z1qjE47nWvDuDK/vMcUg/DSUboRyRAnwvPMCpu?=
 =?us-ascii?Q?Gf6SYU2ke5fqJwoPe8sml7BNHCzBwfB4beYVY2Hh89yYFSkgDxiQzMqIf275?=
 =?us-ascii?Q?LsJNTa4Irf8hVbZUYYDzA2WCS6dBGem3ljyAYBuEoZE6Nvr76w6nSz66uRzo?=
 =?us-ascii?Q?h9tXGHV+H2V+Wcm5NSq1+UyZL+u+EIZ3cMU9TWHSZ/5rNwLhpg/EA5KV5pjY?=
 =?us-ascii?Q?57j6ol4yZfhXxzA7JvodX8voBJklW+V2ULVUEkVpYNdN4ipb8UrMkoix3Ag3?=
 =?us-ascii?Q?TMi1xf/hCGN3+phcFW0qU8XH2zCKXF1oNxfy68G3wZ0eX+Ph7vyocQZ9eiqY?=
 =?us-ascii?Q?1juGkybeYG8IzS/O82RzfeQLI0my2Jnvll67ahvBUte9GxeKKH+RBzrZ4MsO?=
 =?us-ascii?Q?FhLFF0e0x3qnBvYUtMIm0Typ19BVlPHRnYW7xHiq//mR8ywubld/yyQwXCGH?=
 =?us-ascii?Q?hWKAwnArDP8IJeWBEwI6Z6xtYBdpw0wB2Hls/eicMMHa0n0UTw5V4Z+x8xO7?=
 =?us-ascii?Q?xZbiRbwpM21EPtkx4dfjIkIS4cbcEO8l04yAUFIudjUr7YBrZJ2Fxjt0KhpD?=
 =?us-ascii?Q?wjhJAqNLM+t7K/R2iRvNPlvtuDugBFyHi8K2pi+B9pSNwtcNk6ERd/5NqQeM?=
 =?us-ascii?Q?OKO1na7ORsFHBIswpqoOKRwzB16gGzjyMnP2drC8S4ZxO4ZZl9sUZIpjolud?=
 =?us-ascii?Q?3t1GNcsY4HJ0CHXaxLiPLWusKTodL42XTgRo58QRY1wEm+s6T5fC09sjXYvJ?=
 =?us-ascii?Q?Kn9xXBXXFklhLvmXUbmNXC3XhwfYlyYZJiPf+CevxUgJ0Tzhproc5qmUd2OR?=
 =?us-ascii?Q?iMt++uTseDdROEr6eCUkok/LkBbDMmAiN0wCbDZ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2bf7cb-df8d-45c9-aabc-08de221b7b83
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:44:16.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFJIdZk8XwmWOt0DS6mg/2jK+Whi8mDQqet9bOuaNottcgZEFUKatyX/PvfmLKzJvepVxW2d18a8IdOOqp0VBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

Hi Emil,

On Wed, Nov 12, 2025 at 10:07:55AM -0800, Emil Tsalapatis wrote:
> Update scx_task_locks so that it's safe to lock/unlock in a
> non-sleepable context in PREEMPT_RT kernels. scx_task_locks is
> (non-raw) spinlock used to protect the list of tasks under SCX.
> This list is updated during from finish_task_switch(), which
> cannot sleep. Regular spinlocks can be locked in such a context
> in non-RT kernels, but are sleepable under when CONFIG_PREEMPT_RT=y.
> 
> Convert scx_task_locks into a raw spinlock, which is not sleepable
> even on RT kernels.
> 
> Sample backtrace:
> 
> <TASK>
> dump_stack_lvl+0x83/0xa0
> __might_resched+0x14a/0x200
> rt_spin_lock+0x61/0x1c0
> ? sched_ext_dead+0x2d/0xf0
> ? lock_release+0xc6/0x280
> sched_ext_dead+0x2d/0xf0
> ? srso_alias_return_thunk+0x5/0xfbef5
> finish_task_switch.isra.0+0x254/0x360
> __schedule+0x584/0x11d0
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? tick_nohz_idle_exit+0x7e/0x120
> schedule_idle+0x23/0x40
> cpu_startup_entry+0x29/0x30
> start_secondary+0xf8/0x100
> common_startup_64+0x13e/0x148
> </TASK>
> 
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Looks good.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index bbd7529fa420..4b1007e06e9a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -25,7 +25,7 @@ static struct scx_sched __rcu *scx_root;
>   * guarantee system safety. Maintain a dedicated task list which contains every
>   * task between its fork and eventual free.
>   */
> -static DEFINE_SPINLOCK(scx_tasks_lock);
> +static DEFINE_RAW_SPINLOCK(scx_tasks_lock);
>  static LIST_HEAD(scx_tasks);
>  
>  /* ops enable/disable */
> @@ -520,7 +520,7 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
>  {
>  	memset(iter, 0, sizeof(*iter));
>  
> -	spin_lock_irq(&scx_tasks_lock);
> +	raw_spin_lock_irq(&scx_tasks_lock);
>  
>  	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
>  	list_add(&iter->cursor.tasks_node, &scx_tasks);
> @@ -549,14 +549,14 @@ static void scx_task_iter_unlock(struct scx_task_iter *iter)
>  	__scx_task_iter_rq_unlock(iter);
>  	if (iter->list_locked) {
>  		iter->list_locked = false;
> -		spin_unlock_irq(&scx_tasks_lock);
> +		raw_spin_unlock_irq(&scx_tasks_lock);
>  	}
>  }
>  
>  static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
>  {
>  	if (!iter->list_locked) {
> -		spin_lock_irq(&scx_tasks_lock);
> +		raw_spin_lock_irq(&scx_tasks_lock);
>  		iter->list_locked = true;
>  	}
>  }
> @@ -2983,9 +2983,9 @@ void scx_post_fork(struct task_struct *p)
>  		}
>  	}
>  
> -	spin_lock_irq(&scx_tasks_lock);
> +	raw_spin_lock_irq(&scx_tasks_lock);
>  	list_add_tail(&p->scx.tasks_node, &scx_tasks);
> -	spin_unlock_irq(&scx_tasks_lock);
> +	raw_spin_unlock_irq(&scx_tasks_lock);
>  
>  	percpu_up_read(&scx_fork_rwsem);
>  }
> @@ -3009,9 +3009,9 @@ void sched_ext_dead(struct task_struct *p)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&scx_tasks_lock, flags);
> +	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
>  	list_del_init(&p->scx.tasks_node);
> -	spin_unlock_irqrestore(&scx_tasks_lock, flags);
> +	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
>  
>  	/*
>  	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
> -- 
> 2.47.3
> 
