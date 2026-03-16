Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551793B5855
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676312; cv=fail; b=esFAr6ekjkv6T8cppuQ62DZAn4v50Ld3BnfTJpoFIMabOz8FQ3lKSrmvIiuBiIh5jY+2Bk7Fx3fRNRnMp2unwfIgsvyTMsXC97ufCtfaurKeNQ4ljEcFyMZS7dBTsJdk8/qI1qd0gGpZYx8Um4hbPXXQDCH7bCJQaAzASq81tkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676312; c=relaxed/simple;
	bh=MLFOaLMgkIJgz0TokiAgGyJryu1WcNwM++411MBD7h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SdoFftOhbwPBlrEvkGoDN2KOp1/UNySkAmjvYTldBoLRPOnGfx01l0so1NHcrVLXJJOrjmOdAn9DfCXhSl4icJuflyPH7/qE6G6g2atSGM9jPwjounfX3QOu1NETImY2AEQcSWOt4IAWugfve4AgLpXZHMsBaQ3J4g6K1ZC+12E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFoHDvtR; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFoHDvtR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ9K+m/W2xzATYHYG1rW7dChRy8IauFTpZjx6mGiYKE9GFxi0L3AqOSLMms8P7X5oXmT6Rg5NWFL7KACrnR7tdEgVsmIb8rbyRLuR9t0DY+TQ9OKaUWVdb3hP1fmon/Te8m4k0JhjfKVwuN9czmfOY76AWlbReOD23mfGN2wemaIDbtkwkTaGLQKDZYxWcbYa3PQD7uYzZLDL4VLddjBGvGQhV/HkTAiN7iZeM0/LyaCFRLEoKwqVydMvBCrDCgAHZFCeSC1IasXCHgylZULA1LXXiE3Dg9HhbjRO2Egu8JuUXqLxemOFCo153FhKmG7xIAjZFpro7BBSaayt5umCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qMp3Z6qzRK+TCPNec5yMkuQleQV6AaU7l3m1iNQdfI=;
 b=ZLyqgYvIf1ZyepV1DWdR3WMXePjML3vx1V9iU8KwtcmwxGngfdMIrloEiAZROJ8fCcEAtZu2bVMWFYerJ6fpL0f6KOoXl9AJ4Hof7vH45dYwjDgTAYWdru2/e8pArqYBuVmqNqo9W/vWR/LHqiT481TwzDQge6/yNKRdvCHFxFRSdviMZd2X5hVskrdX3IWFciYGdA3drp45ynNyMGMIgBW11irMOqSNcg8f2w9uRa1/6U7WJZesY2ZnGVJST+ts6GlIaE7R9JtseyKFrvygxEQU0Mdtze/kYBHf8PQzXnEHX8o94oMoqZELcNBdedh07fvPiPSD36ajPuLv2Ei5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qMp3Z6qzRK+TCPNec5yMkuQleQV6AaU7l3m1iNQdfI=;
 b=rFoHDvtRjcaKVsix23/D43CWuXZbG4WG6m3BsM9+10C9OtVURbagduKF7T8FUyJwe2uROI2U/MoC05L448ByO08S1jfm8hNl73I66eSZp+DZNPgD8WcadEDm8TJBkg337ET9gLgyqHSB7rBQ73ZsDrKpmunvYIEBWbT1TcrG7SrPQg9aElPUbsX63mXtWiZpZZzZ1m3Dl8yJ/lkklg9hbTfRTFA/Bc78zEG77rpZUnt+owXcE74N3ZCrPD7QA3QogzGga3xWE1AlnX303BMwt7epOk5UQfMq7XD4TxXiJLWYFEXeJwRW3IdHHu+4t4jiWlmoafykX9RcRLPmSurbWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 15:51:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 15:51:43 +0000
Date: Mon, 16 Mar 2026 16:51:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in
 scx_idle_init_masks()
Message-ID: <abgnBgO83uXd7Xq-@gpd4>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <20260315181017.1377138-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315181017.1377138-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a0a960-0ced-4235-4e6a-08de8373ebc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZCY2riXRIxLBRYvRyY52rjywRQdJDRDzZT4Q5TU33RzyqHu/RI/b5LcM8FFe5/fhJnoOjicF6niBMapzXK4DX318ANqwgQ4vHAWuEPGn3lvAK2wlvR+NV3VBC3Kt5i5p1O1qCLMtyfvPw64f4Q0FDefTXohmlL8XSoFu7Zd+/8+AjAHpOXPUpVTUZx61XRdlKNQNl67E5WP7EFXiiM3ry8/dLcuLjrTSlVnuMr3dvYPmrlAVgKu0lcZUtD4iSfOTpzTZ4pZDqcVn7UiMBcoi4pDBJuBWBis0D5pOuPMKCdZ/tr3vQSuCtCuInec28gdOJolJVZWqaNEzZrkuCXXwdReFQPDDC8gezcafSNQO+PRB0VT1FiALxQRL1N49hiHswzHhxO19R8M5wSQ4Up6sZwEu5cog3Tc8qYtPiQe9+zclRPFlnb9a+hUKcmOyfNpXSo7DYYgve6QTz7TEBdFPtWjrSStpp/XZOjNPSPr7YDuD1tY2hfBe6Q8mWrF8kF0I44w/77EWYfzRIAozlJ3exCkdg4dwkBu2n/FagSn9ijnd3pLkfD0iCPsIHh8o6+V3JtVV2wOWOzo8bdBlXrnl73YOyBoiwTI0uUhRCiEcq5xobj+bXUaN2Gj+tBnE8qC83DFlWtjuowJSrrGOKdmOBh9tsfhd+/89ESPnthsLqgMhEVvRb29FwPAl7CqRU//Mm8O+rtDDAg/pII01se2Fy/mGYLYD3zbwJ/Lx6x75vew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wufXaR5bTLuCtKlOCkIYgLekvAmihXnK1I4kM9Ekyli5vzMHx2161SBSGGBu?=
 =?us-ascii?Q?LHyMQDQ1y7UwEYPa3sDDChyf3Z1uMkUTvUVmo5M3LlGdfkf31RsACrxEnnII?=
 =?us-ascii?Q?lZjkWFtNrJhy9qZahbc/4FriZD8PICeQPGwUIVIFLkrSBAygOWlm0exlVPwU?=
 =?us-ascii?Q?xaFYEqmdBDzQcnN0Ldwp9kKQi4kx65YLINGLdnU+AzvkvUidRYwpbaWXzZxQ?=
 =?us-ascii?Q?U59PYdtBivkTaSFxGuvIEpaaSO8zQv1DrGSSdCp7OWL/9tVZxGlif57RZvaa?=
 =?us-ascii?Q?Jn1FCpLLj3FSMptepTVDwZpud6dOEsQhNrayd+j16q9Qsdbn/iHlxleDbOjM?=
 =?us-ascii?Q?McPya/vkzETaBkhV1/KroFuXd3NiTyEOS63cCrGH7eVKp4pliVu1qhT3WdqA?=
 =?us-ascii?Q?s+6gOsVhYryNCaoTkwybiLhcTH/99TitKw+I2dbMst7l6XwcXK0hQT0kWouF?=
 =?us-ascii?Q?TfJZBiJ7pW0hYmxal1adT4WP7jHoMEc9LT613BDu++R2r019lAKPRrdaARmO?=
 =?us-ascii?Q?M6/eoljO/t5xaFWTvh7/Q6IX9skr9ka0j4C8sw6EIsHEVCw4UbDDAzPkjemM?=
 =?us-ascii?Q?+weNC9u2TKfZZfMTrPfTy6idJ9hWK67bDcwWVcez+TWQG4p2/lxUYK6hgvbF?=
 =?us-ascii?Q?iKaIoWvK2LQ/Pmlt1SdFZ7+9zAjM/uWf8wfSiyQqXR1k86EQqlZK/CLlBrvt?=
 =?us-ascii?Q?b3uwt/g5hu8ywmbcZvZbnjwn3le7jkEEiS+XfIvDPEWYQA0GSDP4p3RXUNqi?=
 =?us-ascii?Q?rFRu0kSxXWUcrUBL2SGND+V8zZYgLdruPBGh2O6E2dcLJtjDQThrPQ5Z8xO5?=
 =?us-ascii?Q?7lnVjRejDD5Gj/PXylucIPNiNhtg84oFV+fqSBfKFcZ546OtkvipOii6bQHq?=
 =?us-ascii?Q?o9TaWZCKkSMS5WVZzfqhP9HnkZiw8ZpugK19hTAUg85oEeAzL/5lZvIb2XMp?=
 =?us-ascii?Q?64TDe7X6Mi3AVXuaphA9PVIxdGFgM1hZzz5R0L6jxuQD3GbsjL6JcyOd7CA1?=
 =?us-ascii?Q?uJXO2G2Zh5NnQw82+UTOpnq3pI4sxKfQLkSY9F62jqZpZmIUaGo/wzwYWPdx?=
 =?us-ascii?Q?MnSHxdGGhJ/cygV4k2UG1lNaQcfCCh+QIa8qjjtlOevv/Ty89VWM6z32pqsx?=
 =?us-ascii?Q?zS+S3BNyPiqvEM6TZKAvyhRM4D8zwuvrpfTw7FOoX8Fqup3Tz7JmZpVPtPw0?=
 =?us-ascii?Q?90MQDIdldW3HZThrkA3lML0jWZ6eGMsJErc/C4ZIUC/Tsx2CvLkKuonmzAXs?=
 =?us-ascii?Q?3S2xe98lJ62P67wSKvRsgwPaJiMlDgdnpljCQAX86hEvakWB84EAn0yLRX/B?=
 =?us-ascii?Q?J681rpgZ8B1qC3GSp2kVSVkSJqsX9L0dEge2WAsAep4TyxLzpjeWjUB9YyYX?=
 =?us-ascii?Q?lHykW2brejPDrmc9zcbIhqO+QXfF8RjUvNAWYORPI9/2BEva0NuBbP6RcGzZ?=
 =?us-ascii?Q?b+3/bqNJPy2CnhSEteR2VEnZVvFDUzCO1jfQQvsrDKoyTBU2kvtL2f+7w8hF?=
 =?us-ascii?Q?6elYNjVMbxSUqUF2T1m3JQMI748PUmapO8vSpQskPwcn6jcZCMI8muK+9kWF?=
 =?us-ascii?Q?sG/sK7Nnk1SW0O3ewu0bFqyCYPhTxluQLEesX2xaov4ag/jzmrmISEeDy7WQ?=
 =?us-ascii?Q?XCkKq1BmGf2YgDV0IdC32aSvnoDJzYAQ1eGRGEpUQ5f2tKWZ+5OihRDQui0n?=
 =?us-ascii?Q?bhFXXOtbNUEtT9oHSB566m7ur2Cdx3tfINfRH5gs5lhNQvMRlOylWhVHyjpt?=
 =?us-ascii?Q?VNkTkpohiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a0a960-0ced-4235-4e6a-08de8373ebc3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:51:43.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vne5xwPFbaMTpuUpgXWED6yG3lJ8/VCBmBqmoVB6zzON++Egiuq/9Cn26wKH/UuGUWRhkXZAasy0RVseccgNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

Hi Cheng-Yang,

this has been sitting in my TODO list for a while, so thanks for looking
at it. :)

Comments below.

On Mon, Mar 16, 2026 at 02:10:14AM +0800, Cheng-Yang Chou wrote:
> Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
> arrays that store NUMA nodes sorted by increasing distance from each
> node. They are allocated and populated once during boot in
> scx_idle_init_masks() using the existing for_each_node_numadist()
> O(N^2) traversal, so the cost is paid only at init time.
> 
> pick_idle_cpu_from_online_nodes() will use these cached arrays to
> reduce its per-call complexity from O(N^2) to O(N).
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext_idle.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 03be4d664267..623a0356d6c3 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -144,6 +144,14 @@ static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u
>   */
>  static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
>  
> +/*
> + * Per-node sorted arrays of NUMA nodes in increasing distance order,
> + * pre-computed at init time to avoid the O(N^2) traversal on each call
> + * to pick_idle_cpu_from_online_nodes().
> + */
> +static int **scx_numa_node_order;
> +static int *scx_numa_node_order_cnt;

Do we need this array? Isn't this always nr_node_ids - 1 (all other
possible nodes)?

Also, if nodes are sparse we should probably initialize the array with
NUMA_NO_NODE items and skip them when we scan the array (in addition to the
node_online() check).

> +
>  /*
>   * Search for an idle CPU across all nodes, excluding @node.
>   */
> @@ -685,6 +693,36 @@ void scx_idle_init_masks(void)
>  		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
>  					       GFP_KERNEL, cpu_to_node(i)));
>  	}
> +
> +#ifdef CONFIG_NUMA
> +	/*
> +	 * Pre-compute per-node NUMA distance order so that
> +	 * pick_idle_cpu_from_online_nodes() can iterate in O(N) instead of
> +	 * the O(N^2) traversal required by for_each_node_numadist().
> +	 */
> +	scx_numa_node_order = kcalloc(nr_node_ids, sizeof(*scx_numa_node_order), GFP_KERNEL);

Considering the comment above, we probably need only nr_node_ids - 1 items.

> +	BUG_ON(!scx_numa_node_order);
> +	scx_numa_node_order_cnt = kcalloc(nr_node_ids, sizeof(*scx_numa_node_order_cnt), GFP_KERNEL);
> +	BUG_ON(!scx_numa_node_order_cnt);
> +
> +	for_each_node(i) {
> +		scx_numa_node_order[i] = kcalloc(nr_node_ids, sizeof(int), GFP_KERNEL);
> +		BUG_ON(!scx_numa_node_order[i]);
> +	}
> +
> +	rcu_read_lock();
> +	for_each_node(i) {
> +		nodemask_t unvisited;
> +		int node = i, j = 0;
> +
> +		nodes_copy(unvisited, node_states[N_POSSIBLE]);
> +		node_clear(i, unvisited);
> +		for_each_node_numadist(node, unvisited)
> +			scx_numa_node_order[i][j++] = node;
> +		scx_numa_node_order_cnt[i] = j;
> +	}
> +	rcu_read_unlock();
> +#endif
>  }
>  
>  static void update_builtin_idle(int cpu, bool idle)
> -- 
> 2.48.1
> 

Thanks,
-Andrea
