Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C24437465
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705486; cv=fail; b=jCjHazNNrkzq7YUYCHbGdPRaV9w3V0LrOwuqf03FNoY4Tdu/VV/RlbIGR963tyxeeP9EHSaPu3nw10/Jbp06gJOzyhTvpIO9l4XHsdpTBbCg8IUdoxkexJ8tHwlKfFmizTr2MibNRFyaCWv0iRdJGLs3E6tfpR4iv194BBfB8AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705486; c=relaxed/simple;
	bh=amqCOVClkV3i4sjhS8MR+RGyLfq30TRbcIPPCtdPq14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJA6rPZHIGDXFoaVJMUS8CmwFYxHMLhqQgQYdtYXd36yF8niL4IRIbLCF4aqyAM9KlP3BRFDZO3h/+rhLWtQNUySI9183TecR/ZIFTXJbx9imeBwevcYKep82vA1z5tBdE8dQeSIjI8436+mFFAOutpvxrw/togxJkYwrKiEJ4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGvy5t/c; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGvy5t/c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfMcvKAiA2y3g8tFTaGGuzBukTd8hC8582YlJ+IMOmPwlvgPxG5OSiaSadJc4saYIEsxySCUZt4WYhEOtAgK3o9UXpgHEqcTQeL9WcIncykqwgjkzWVpRY3pQPNHUog1adY8trHuDwEVJzUFvuTCJEiRUjTi7kZfpYb7k2u8WWt/PBefae4V+fFsT24Yn3Wf4B/ddpjutAXF+a5g7ngef/SEPaCiW0fCNk5ArRifJ8MgFT/HR0Ql38/6PDVzT1N40W5mEsCJtgD7fCMMWKjvjytj5sEwO4iOmkYxl9T6YGxvZljUeXbBTm5dLd1RKSf3LEq1LvZdGW8+zTWhHqMUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt9/Qc8Ol9/4rYngC/IQ31Yfm+RJSChCmzwHE4/U9eA=;
 b=bSQ26pfBdqRm5JU1ZWbjQWsNEA2jSICW6G+FuaR5PnsKhzBq2t3aRIzngmYBWX5Z+2nfhPBsVW4EtrYmHzW4zHm0CsCM959PF03ZpTMiQBqF63p2U86h2tiIToYDmot4DlmKF9wwskdPyCxDYj0rDXan+WFiFT7pZkMGnnvYn/xdttELHspTfLbP8bBr0BfiGF0tDyYx7gIuRdhfLmEUf4FxvY4sTGdtzzc/4I7ASYE5S4DEPhcp3yh7taSu5lVDMa8xIeMtcsHWt5EcJ6ZGlAWHTnzZPd8/gVQWgOfGWhD9EqCNVegvb196MwTtEgjz659TR3UVL05n7tlDTsubhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt9/Qc8Ol9/4rYngC/IQ31Yfm+RJSChCmzwHE4/U9eA=;
 b=tGvy5t/cTOpBqLRoAeUqxM/bRCaF2SJzJMjdyxhSojo57P+oFqHuPJANH6ayYQ/0aAXBA+3cjfLXKBtsIlsAPsHQmzjCBg44DyWOR3YEj04x9WHCV7MaqLS5SgQwdJcVZ8jU6ZwGd/ItNHQXL/GkmIc5zouFPhIsxtTFSXRUTvW60vvC2dtX46HaphyjjewBd2AW6k5esv+4NhQWQO3+7OyorzuG81bgge0BwbdDioGjvyMNWrLoDn1d4xvYACpI8UL0L37n0P76+q9wOrzObYttwQmB32O6qUXqYg5B20ITf5MaVNLA6dBeh2A7WXfcrA8Axv+/06JlPzrXZFPPMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:31:09 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:31:09 +0000
Date: Wed, 22 Jul 2026 09:30:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] sched_ext: Build the cid tables privately and
 publish them with RCU
Message-ID: <amBxlrYlktixsrmT@gpd4>
References: <20260721223118.2268529-1-tj@kernel.org>
 <20260721223118.2268529-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721223118.2268529-5-tj@kernel.org>
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: da52943d-f71e-47b1-9897-08dee7c32690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c6AOr/tv8vEM+O9mx2a1vVCnYmJpyPJU4XQbSVyBgXSKGNZrsalLMi9TEKHAaeDHRWIOamobDQ4m5e8xm3qzTWosUU7yA/f+rvlcIS9TTg7YW2shnXq0s/ryxJY72JwbS6kGloLiPGRHRtLgoGPpN4PgEuMs9I8zU4PzQD/KoMICy+HmFSlIAbtTA9gkswv6BmHh1y7rEDjNjCcr04CciA1QmbLqtOOh85bMMzCEAy3UNH70QqlEWfnicXk7IrFqv6DcGXIqRX1IePyxk8leW6ZVOzHNarn+mTJjNpURzf6diw5P2RMGEt6WezgruP5v0OwLRc6fazneQyRHng/ooylbESGeeS1boPXqLIYr6yrL+7MNltZifS67++MgBkFfEV22htiIyA/5QV6/z8jGU4Sji7h0elLXEhi5fKHVU0MAHl/j4jLAcgfXQYRXltN4WTN0gPbdIo7oE0doHjJoco2GCRQR8wzMsEtdnikIYulWo77eCJH7OWadpRKflxm/DR50fURSsdEIqyx8i9N0ebQuh213XhKmnqK15eBdS1FhgOJ3BDuSwQ+i5whYFsb8jILYO0KWVrTzgWvKJeIB35VOPlkMOclPwrafo4u1eGci0h8wAAfkWOLPmdCnGFE91V8+R0H8c2p5ALqRfVfov37fiwSx+sDyIB49GyFtJxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCiGMYeHmjPI/EwZuiHH+UPolTO7v2yVnF4nEKq+N5g13NOWyLVd6vHM5fv1?=
 =?us-ascii?Q?0mg1Z8KN0DpjFdU2/6En8o46s0xAF7kEvpklJBXjm5d8Es15S8lAR6BMWTA7?=
 =?us-ascii?Q?+2IDhTHMc6UtLTdnfJeEVThW0rTvD8nSBsmSl9zlk9yZQsw3Ly9Bq9BR7Spr?=
 =?us-ascii?Q?RMeKatCeIYJ9pCW6vEmiW2E2dRSP8MVA3X+jGc79FFNBWOl/gGKSaSGmpSdX?=
 =?us-ascii?Q?eQjp1aRZqMHmB0ayv/0mz+XD3uJ0X+oJkfADr9hSDXg8E+ZOEMtJ24liu4v/?=
 =?us-ascii?Q?KjE6Hh6lkLPnmDWWQSp7saYweAaF2sClyHOh2MUgc9TMuqrezmA9hvZ+RE7o?=
 =?us-ascii?Q?1NQDuFyUGLOpK0+cMRNxX1OB+mz/B25LTFfkupfirieouK/yipblAmoxSzXw?=
 =?us-ascii?Q?am+10oD3BY/DU/JUa5unGry8I+skTwE1R+UFRlRr+FOixlB/MXJfLujUgREQ?=
 =?us-ascii?Q?aQKO4poV8uxMbPb+kAgG/k9utoihW59hXeMV0+84IMmn2CaZHyqa0HHDwK2a?=
 =?us-ascii?Q?6daVvqmthQSQqc/4Tw9V6Axo+D25uq2WZHYbp8Pp+TOI260J79anvKCQrG0p?=
 =?us-ascii?Q?QCQzq+WBQTfoTWvjsFNQDXQcy48KZtpKIHo50dfuTR3bYV8hYw/AUPpQ3kiR?=
 =?us-ascii?Q?P2sV39+RoXxtZD49kglMWB9Xg22t7qYNg6jcl9ItxGYo0jRKMX/5RD1qZtcP?=
 =?us-ascii?Q?heeL0Ti0zRRycJsG1J1ZyiwmWroF4X31xy3KmIYhaS+YCZVOTqjpz0v7IcEo?=
 =?us-ascii?Q?UeVNwgnXcRxiQJfEfAMcNqfWcwfwRDBHwEGoqbRI4eqbadze9N8+Lzv86vBj?=
 =?us-ascii?Q?FdfTjh3FqKQJ/gr6hppd/DUSBf0IruRagHP1zi3nFwSDHIuLgNg42QNMOV6S?=
 =?us-ascii?Q?SW+7UCiq8+nwyy3FMvLbENE5jvH/dCQ9XPWU/PIUwCL9M+b2ajF7vdTAh7Ln?=
 =?us-ascii?Q?jhGfzo6+88zn51X4RLRKLBWyaoZHs2uLT1o71WrfZGaRoYHBp+p52PXoqsH6?=
 =?us-ascii?Q?+Lr63oR4FKePW+exA2Prc3hCBnDkrSPNoJF4OSUUTnL6L+scYUNzTmpeUueT?=
 =?us-ascii?Q?me/SnhvfQPDsn34tVZHtBfAHdu0hucOIg0VP3K3XqfHcIrAkrvbz4Rs51IMA?=
 =?us-ascii?Q?0uHc6BV6plfJ7RBBg/oAT41wGujdjdP+p0bvdn0j09CXVpFDpZq36vEfNFQB?=
 =?us-ascii?Q?x6W6ga4GsQWAR/I6qhErkyw5VWcBy4l+u/YTgFfhvM+x3pufgqtZxQzIqNSG?=
 =?us-ascii?Q?4QBcCQhVjoGu9OI7VRHjIGc9w93m6x7CVIm38PMCFkbJkkNXu2ghzYIPUScB?=
 =?us-ascii?Q?NxfibbF3dCzFdgtj7qeGPZSDSTkFICQjZuCN1BHntoPdqunFrlnwImkGzjvo?=
 =?us-ascii?Q?hl5yX9diiXw62TPS0oQMRevF/LgkJw0hdvddlSZw780f5RFfczjMcMsF/snz?=
 =?us-ascii?Q?z0CxUmNvbsUkfw1a1S+h7nHiyt3EhRH3rTQxjShuCI2j9wp96t1+v3sGaj/U?=
 =?us-ascii?Q?zYywpT9UZsJDs2ttI30CFYPQ5psW7YoeFuG+rtuTPCL1pIoWYX4VUR9GLE9t?=
 =?us-ascii?Q?bDa1SoIlpsx+Rr4vUu1r7jnoo32PDJCO8HJkZ/K3dH8h1yirvFKfik+u0C7i?=
 =?us-ascii?Q?Zwn8+k171H4Q6IHZVJpBypcYya5n/Zm6/pF5256muAPmdLEcrRn4wdlpKk8j?=
 =?us-ascii?Q?Nz4UZHMZWiGm4CaW2kUAc1l1+Q0L43ATzAPGF7wsrdNZgB9rBKGHrTj5qSd3?=
 =?us-ascii?Q?FGeCv+bP7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da52943d-f71e-47b1-9897-08dee7c32690
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:31:09.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bH9dRNnOHBTiWj2dTTGpvI2CG/HZRMMWpTZpAZs2ElW3Ee3Q/4VRpC3klmPLM3iFZHWOr5cAET/lmIk9q1hcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465

Hi Tejun,

On Tue, Jul 21, 2026 at 12:31:18PM -1000, Tejun Heo wrote:
> The cid tables are visible to the cid kfuncs while being modified: the
> first enable publishes the global pointers before filling them,
> ops.init_cids() overrides rewrite them in place, and re-enables rebuild
> them in place. A racing TRACING or SYSCALL program can read unfilled
> entries, including uninitialized memory in the kmalloc'd tables, or torn
> topo updates.

In commit 67edfa9eefe6 ("sched_ext: Forbid cpu-form kfuncs from cid-form
schedulers") we mentioned that we want to allow CPU-form schedulers to call
cid-form kfuncs to potentially ease a gradual cpumask -> cid migration, which I
think is reasonable.

But it might be helpful to explicitly state this rationale here to avoid
confusion. Something like:

  cid kfuncs are intentionally made available to CPU-form schedulers to support
  TRACING/SYSCALL programs and to facilitate the gradual migration from CPU to
  cid. Consequently, a default CID mapping must be initialized and published for
  every root scheduler, regardless of whether it is a CID-form root.

I'm suggesting this because, at first glance, it may not seem immediately
obvious why we need to allocate these arrays also for non-cid schedulers.

Thanks,
-Andrea

> 
> Tie the tables' lifetimes to the root sched instead: each root enable
> builds a fresh set privately and publishes the per-table __rcu globals once
> the layout is final, and root disable unpublishes and RCU-frees the set. A
> non-NULL global is now always a fully built table which stays valid for the
> reader's RCU read section, and lookups stay two loads. Kfuncs treat NULL as
> no-mapping, also after the scheduler exits instead of reporting the stale
> last mapping.
> 
> Every reader must either be gated on scheduler liveness or NULL-check
> inside an RCU read section. Fix the two kfuncs that were neither:
> scx_bpf_this_cid() read the table with no RCU or preemption protection and
> scx_bpf_task_cid() relied on KF_RCU, which doesn't put a sleepable program
> in an RCU read section. The hotplug callbacks are instead serialized by
> retiring the tables inside the cpus_read_lock() section that clears
> scx_root.
> 
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/r/al3tLtPZZkFjMveK@gpd4
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/cid.c      | 258 +++++++++++++++++++++++-------------
>  kernel/sched/ext/cid.h      |  57 +++++---
>  kernel/sched/ext/ext.c      |  54 ++++++--
>  kernel/sched/ext/internal.h |   5 +-
>  kernel/sched/ext/sub.c      |  42 ++++--
>  5 files changed, 274 insertions(+), 142 deletions(-)
> 
> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 5f990d95735f..bee106d7eb94 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -11,20 +11,20 @@
>  #include "cid.h"
>  
>  /*
> - * cid tables.
> - *
> - * Pointers are allocated on first enable and never freed. During root enable,
> - * the default mapping is populated and then ops.init_cids() is called which can
> - * use scx_bpf_cid_override() to change the mapping. The mapping stays stable
> - * until the root is disabled.
> + * cid tables. Each root enable allocates a fresh set, builds it privately and
> + * publishes the __rcu globals below once the layout is final. Root disable
> + * unpublishes and RCU-frees the set. kfuncs may run before the tables are
> + * published and must check for NULL.
>   */
>  u32 scx_nr_cid_shards;
> -s16 *scx_cid_to_cpu_tbl;
> -s16 *scx_cpu_to_cid_tbl;
> -s32 *scx_cid_to_shard;
> -s32 *scx_shard_node;
> -struct scx_cid_shard *scx_cid_shard_ranges;
> -struct scx_cid_topo *scx_cid_topo;
> +s16 __rcu *scx_cid_to_cpu_tbl;
> +s16 __rcu *scx_cpu_to_cid_tbl;
> +s32 __rcu *scx_cid_to_shard;
> +s32 __rcu *scx_shard_node;
> +struct scx_cid_shard __rcu *scx_cid_shard_ranges;
> +struct scx_cid_topo __rcu *scx_cid_topo;
> +
> +static struct scx_cid_tables *scx_cid_tables;	/* used only during alloc/free */
>  
>  #define SCX_CID_TOPO_NEG	(struct scx_cid_topo) {				\
>  	.core_cid = -1, .core_idx = -1, .llc_cid = -1, .llc_idx = -1,		\
> @@ -73,50 +73,102 @@ static void calc_shard_layout(const struct cpumask *llc_cpus, u32 shard_size,
>  	*nr_large_p = nr_cores % nr_shards;
>  }
>  
> -/* Allocate the cid tables once on first enable; never freed. */
> -static s32 scx_cid_arrays_alloc(void)
> +static void scx_cid_tables_free(struct scx_cid_tables *tbls)
> +{
> +	if (!tbls)
> +		return;
> +	kvfree(tbls->cid_to_cpu);
> +	kvfree(tbls->cpu_to_cid);
> +	kvfree(tbls->cid_to_shard);
> +	kvfree(tbls->shard_node);
> +	kvfree(tbls->shard_ranges);
> +	kvfree(tbls->topo);
> +	kfree(tbls);
> +}
> +
> +static void scx_cid_tables_free_rcufn(struct rcu_head *rcu)
> +{
> +	scx_cid_tables_free(container_of(rcu, struct scx_cid_tables, rcu));
> +}
> +
> +static struct scx_cid_tables *scx_cid_alloc_tables(void)
>  {
>  	u32 npossible = num_possible_cpus();
> -	s16 *cid_to_cpu, *cpu_to_cid;
> -	s32 *cid_to_shard;
> -	s32 *shard_node;
> -	struct scx_cid_shard *cid_shard_ranges;
> -	struct scx_cid_topo *cid_topo;
> -
> -	if (scx_cid_to_cpu_tbl)
> -		return 0;
> -
> -	cid_to_cpu = kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL);
> -	cpu_to_cid = kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL);
> -	cid_to_shard = kzalloc_objs(*scx_cid_to_shard, npossible, GFP_KERNEL);
> -	shard_node = kmalloc_objs(*scx_shard_node, npossible, GFP_KERNEL);
> -	cid_shard_ranges = kzalloc_objs(*scx_cid_shard_ranges, npossible, GFP_KERNEL);
> -	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
> -
> -	if (!cid_to_cpu || !cpu_to_cid || !cid_to_shard || !shard_node ||
> -	    !cid_shard_ranges || !cid_topo) {
> -		kfree(cid_to_cpu);
> -		kfree(cpu_to_cid);
> -		kfree(cid_to_shard);
> -		kfree(shard_node);
> -		kfree(cid_shard_ranges);
> -		kfree(cid_topo);
> -		return -ENOMEM;
> +	struct scx_cid_tables *tbls;
> +
> +	tbls = kzalloc_obj(*tbls, GFP_KERNEL);
> +	if (!tbls)
> +		return NULL;
> +
> +	tbls->cid_to_cpu = kvcalloc(npossible, sizeof(*tbls->cid_to_cpu), GFP_KERNEL);
> +	tbls->cpu_to_cid = kvcalloc(nr_cpu_ids, sizeof(*tbls->cpu_to_cid), GFP_KERNEL);
> +	tbls->cid_to_shard = kvcalloc(npossible, sizeof(*tbls->cid_to_shard), GFP_KERNEL);
> +	tbls->shard_node = kvcalloc(npossible, sizeof(*tbls->shard_node), GFP_KERNEL);
> +	tbls->shard_ranges = kvcalloc(npossible, sizeof(*tbls->shard_ranges), GFP_KERNEL);
> +	tbls->topo = kvcalloc(npossible, sizeof(*tbls->topo), GFP_KERNEL);
> +
> +	if (!tbls->cid_to_cpu || !tbls->cpu_to_cid || !tbls->cid_to_shard ||
> +	    !tbls->shard_node || !tbls->shard_ranges || !tbls->topo) {
> +		scx_cid_tables_free(tbls);
> +		return NULL;
>  	}
>  
> -	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
> -	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
> -	WRITE_ONCE(scx_cid_to_shard, cid_to_shard);
> -	WRITE_ONCE(scx_shard_node, shard_node);
> -	WRITE_ONCE(scx_cid_shard_ranges, cid_shard_ranges);
> -	WRITE_ONCE(scx_cid_topo, cid_topo);
> -	return 0;
> +	return tbls;
> +}
> +
> +/**
> + * scx_cid_publish_tables - Publish the tables scx_cid_init() built
> + *
> + * Called after ops.init_cids() where the layout is final.
> + */
> +void scx_cid_publish_tables(void)
> +{
> +	struct scx_cid_tables *tbls = scx_cid_tables;
> +
> +	lockdep_assert_held(&scx_enable_mutex);
> +
> +	scx_nr_cid_shards = tbls->nr_shards;
> +	rcu_assign_pointer(scx_cid_to_cpu_tbl, tbls->cid_to_cpu);
> +	rcu_assign_pointer(scx_cpu_to_cid_tbl, tbls->cpu_to_cid);
> +	rcu_assign_pointer(scx_cid_to_shard, tbls->cid_to_shard);
> +	rcu_assign_pointer(scx_shard_node, tbls->shard_node);
> +	rcu_assign_pointer(scx_cid_shard_ranges, tbls->shard_ranges);
> +	rcu_assign_pointer(scx_cid_topo, tbls->topo);
> +}
> +
> +/**
> + * scx_cid_retire_tables - Unpublish and retire the cid tables
> + *
> + * Called by root disable after the readers which dereference without NULL
> + * checks are drained, inside cpus_read_lock() to exclude the hotplug path.
> + */
> +void scx_cid_retire_tables(void)
> +{
> +	struct scx_cid_tables *tbls = scx_cid_tables;
> +
> +	lockdep_assert_held(&scx_enable_mutex);
> +	lockdep_assert_cpus_held();
> +
> +	if (!tbls)
> +		return;
> +
> +	scx_cid_tables = NULL;
> +	RCU_INIT_POINTER(scx_cid_to_cpu_tbl, NULL);
> +	RCU_INIT_POINTER(scx_cpu_to_cid_tbl, NULL);
> +	RCU_INIT_POINTER(scx_cid_to_shard, NULL);
> +	RCU_INIT_POINTER(scx_shard_node, NULL);
> +	RCU_INIT_POINTER(scx_cid_shard_ranges, NULL);
> +	RCU_INIT_POINTER(scx_cid_topo, NULL);
> +	call_rcu(&tbls->rcu, scx_cid_tables_free_rcufn);
>  }
>  
>  /**
>   * scx_cid_init - build the cid mapping
>   * @sch: the scx_sched being initialized; used as the scx_error() target
>   *
> + * Build a fresh table set. It becomes visible through scx_cid_publish_tables()
> + * and is retired by scx_cid_retire_tables() at disable.
> + *
>   * See "Topological CPU IDs" in cid.h for the model. Walk online cpus by
>   * intersection at each level (parent_scratch & this_level_mask), which keeps
>   * containment correct by construction and naturally splits a physical LLC
> @@ -131,30 +183,32 @@ s32 scx_cid_init(struct scx_sched *sch)
>  	cpumask_var_t core_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>  	cpumask_var_t llc_fallback __free(free_cpumask_var) = CPUMASK_VAR_NULL;
>  	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
> +	struct scx_cid_tables *tbls;
>  	u32 next_cid = 0;
>  	s32 next_node_idx = 0, next_llc_idx = 0, next_core_idx = 0;
>  	s32 next_shard_idx = 0;
>  	u32 shard_size, max_cids;
>  	u32 notopo_in_shard;
>  	s32 notopo_shard_cid, notopo_shard_idx;
> -	s32 cpu, cid, si, ret;
> +	s32 cpu, cid, si;
>  
>  	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
>  	BUILD_BUG_ON(NR_CPUS > 8192);
>  
>  	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&scx_enable_mutex);
>  
>  	shard_size = sch->ops.cid_shard_size ?: SCX_CID_SHARD_SIZE_DFL;
>  	max_cids = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
>  
> -	ret = scx_cid_arrays_alloc();
> -	if (ret)
> -		return ret;
> +	tbls = scx_cid_alloc_tables();
> +	if (!tbls)
> +		return -ENOMEM;
> +
> +	scx_cid_tables = tbls;
>  
> -	/* clear shard ranges and reset shard_node for repopulate */
> -	memset(scx_cid_shard_ranges, 0, num_possible_cpus() * sizeof(*scx_cid_shard_ranges));
>  	for (si = 0; si < num_possible_cpus(); si++)
> -		scx_shard_node[si] = NUMA_NO_NODE;
> +		tbls->shard_node[si] = NUMA_NO_NODE;
>  
>  	if (!zalloc_cpumask_var(&to_walk, GFP_KERNEL) ||
>  	    !zalloc_cpumask_var(&node_scratch, GFP_KERNEL) ||
> @@ -166,7 +220,7 @@ s32 scx_cid_init(struct scx_sched *sch)
>  
>  	/* -1 sentinels for sparse-possible cpu id holes (0 is a valid cid) */
>  	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		scx_cpu_to_cid_tbl[cpu] = -1;
> +		tbls->cpu_to_cid[cpu] = -1;
>  
>  	cpumask_copy(to_walk, cpu_online_mask);
>  
> @@ -209,7 +263,7 @@ s32 scx_cid_init(struct scx_sched *sch)
>  			calc_shard_layout(llc_scratch, shard_size, &cores_per_shard, &nr_large);
>  			shard_cid = next_cid;
>  			shard_idx = next_shard_idx++;
> -			scx_shard_node[shard_idx] = nid;
> +			tbls->shard_node[shard_idx] = nid;
>  
>  			while (!cpumask_empty(llc_scratch)) {
>  				s32 lcpu = cpumask_first(llc_scratch);
> @@ -240,7 +294,7 @@ s32 scx_cid_init(struct scx_sched *sch)
>  					cids_in_shard = 0;
>  					shard_cid = next_cid;
>  					shard_idx = next_shard_idx++;
> -					scx_shard_node[shard_idx] = nid;
> +					tbls->shard_node[shard_idx] = nid;
>  				}
>  				cores_in_shard++;
>  				cids_in_shard += cids_in_core;
> @@ -248,10 +302,10 @@ s32 scx_cid_init(struct scx_sched *sch)
>  				for_each_cpu(ccpu, core_scratch) {
>  					s32 cid = next_cid++;
>  
> -					scx_cid_to_cpu_tbl[cid] = ccpu;
> -					scx_cpu_to_cid_tbl[ccpu] = cid;
> -					scx_cid_to_shard[cid] = shard_idx;
> -					scx_cid_topo[cid] = (struct scx_cid_topo){
> +					tbls->cid_to_cpu[cid] = ccpu;
> +					tbls->cpu_to_cid[ccpu] = cid;
> +					tbls->cid_to_shard[cid] = shard_idx;
> +					tbls->topo[cid] = (struct scx_cid_topo){
>  						.core_cid = core_cid,
>  						.core_idx = core_idx,
>  						.llc_cid = llc_cid,
> @@ -283,14 +337,14 @@ s32 scx_cid_init(struct scx_sched *sch)
>  	notopo_shard_idx = -1;
>  
>  	for_each_cpu(cpu, cpu_possible_mask) {
> -		if (__scx_cpu_to_cid(cpu) != -1)
> +		if (tbls->cpu_to_cid[cpu] != -1)
>  			continue;
>  		if (cpu_online(cpu))
>  			cpumask_set_cpu(cpu, online_no_topo);
>  
>  		cid = next_cid++;
> -		scx_cid_to_cpu_tbl[cid] = cpu;
> -		scx_cpu_to_cid_tbl[cpu] = cid;
> +		tbls->cid_to_cpu[cid] = cpu;
> +		tbls->cpu_to_cid[cpu] = cid;
>  
>  		if (notopo_in_shard >= min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS)) {
>  			notopo_shard_cid = cid;
> @@ -299,10 +353,10 @@ s32 scx_cid_init(struct scx_sched *sch)
>  		}
>  		notopo_in_shard++;
>  
> -		scx_cid_to_shard[cid] = notopo_shard_idx;
> -		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
> -		scx_cid_topo[cid].shard_cid = notopo_shard_cid;
> -		scx_cid_topo[cid].shard_idx = notopo_shard_idx;
> +		tbls->cid_to_shard[cid] = notopo_shard_idx;
> +		tbls->topo[cid] = SCX_CID_TOPO_NEG;
> +		tbls->topo[cid].shard_cid = notopo_shard_cid;
> +		tbls->topo[cid].shard_idx = notopo_shard_idx;
>  	}
>  
>  	if (!cpumask_empty(llc_fallback))
> @@ -318,14 +372,14 @@ s32 scx_cid_init(struct scx_sched *sch)
>  	 * shard, nr_cids is the count.
>  	 */
>  	for (cid = 0; cid < next_cid; cid++) {
> -		s32 sidx = scx_cid_to_shard[cid];
> +		s32 sidx = tbls->cid_to_shard[cid];
>  
> -		if (scx_cid_shard_ranges[sidx].nr_cids == 0)
> -			scx_cid_shard_ranges[sidx].base_cid = cid;
> -		scx_cid_shard_ranges[sidx].nr_cids++;
> +		if (tbls->shard_ranges[sidx].nr_cids == 0)
> +			tbls->shard_ranges[sidx].base_cid = cid;
> +		tbls->shard_ranges[sidx].nr_cids++;
>  	}
>  
> -	scx_nr_cid_shards = next_shard_idx;
> +	tbls->nr_shards = next_shard_idx;
>  	return 0;
>  }
>  
> @@ -417,6 +471,7 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  	s32 *cpu_to_cid __free(kfree) = NULL;
>  	s32 *shard_start __free(kfree) = NULL;
>  	u32 npossible = num_possible_cpus();
> +	struct scx_cid_tables *tbls;
>  	struct scx_sched *sch;
>  	u32 nr_shards;
>  	bool alloced;
> @@ -438,6 +493,10 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  	if (unlikely(!sch))
>  		return;
>  
> +	/* called from ops.init_cids(), so the tables exist and are unpublished */
> +	lockdep_assert_held(&scx_enable_mutex);
> +	tbls = scx_cid_tables;
> +
>  	if (!alloced || !node_counts || !cpu_to_cid || !shard_start) {
>  		scx_error(sch, "scx_bpf_cid_override: allocation failed");
>  		return;
> @@ -488,7 +547,7 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  		return;
>  	}
>  
> -	/* Validate first so that invalid input leaves globals untouched. */
> +	/* validate first so that invalid input leaves the tables untouched */
>  	for_each_possible_cpu(cpu) {
>  		s32 c = cpu_to_cid[cpu];
>  
> @@ -503,12 +562,12 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  	for_each_possible_cpu(cpu) {
>  		s32 c = cpu_to_cid[cpu];
>  
> -		scx_cpu_to_cid_tbl[cpu] = c;
> -		scx_cid_to_cpu_tbl[c] = cpu;
> +		tbls->cpu_to_cid[cpu] = c;
> +		tbls->cid_to_cpu[c] = cpu;
>  	}
>  
>  	/*
> -	 * Derive scx_shard_node[] by majority count: an overridden shard may
> +	 * Derive shard_node[] by majority count: an overridden shard may
>  	 * span NUMA nodes, so assign each to the node that owns the most cpus.
>  	 */
>  	for (si = 0; si < nr_shards; si++) {
> @@ -516,12 +575,12 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  
>  		memset(node_counts, 0, nr_node_ids * sizeof(*node_counts));
>  		for (cid = shard_start[si]; cid < end; cid++) {
> -			s32 node = cpu_to_node(scx_cid_to_cpu_tbl[cid]);
> +			s32 node = cpu_to_node(tbls->cid_to_cpu[cid]);
>  
>  			if (numa_valid_node(node))
>  				node_counts[node]++;
>  		}
> -		scx_shard_node[si] = pick_max_node(node_counts, nr_node_ids);
> +		tbls->shard_node[si] = pick_max_node(node_counts, nr_node_ids);
>  	}
>  
>  	/*
> @@ -532,22 +591,22 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_
>  	for (cid = 0; cid < npossible; cid++) {
>  		if (si + 1 < nr_shards && cid >= shard_start[si + 1])
>  			si++;
> -		scx_cid_to_shard[cid] = si;
> -		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
> -		scx_cid_topo[cid].shard_cid = shard_start[si];
> -		scx_cid_topo[cid].shard_idx = si;
> +		tbls->cid_to_shard[cid] = si;
> +		tbls->topo[cid] = SCX_CID_TOPO_NEG;
> +		tbls->topo[cid].shard_cid = shard_start[si];
> +		tbls->topo[cid].shard_idx = si;
>  	}
>  
> -	/* Rebuild scx_cid_shard_ranges[] for the new layout. */
> -	memset(scx_cid_shard_ranges, 0, npossible * sizeof(*scx_cid_shard_ranges));
> +	/* Rebuild shard_ranges[] for the new layout. */
> +	memset(tbls->shard_ranges, 0, npossible * sizeof(*tbls->shard_ranges));
>  	for (si = 0; si < nr_shards; si++) {
>  		u32 end = (si + 1 < nr_shards) ? shard_start[si + 1] : npossible;
>  
> -		scx_cid_shard_ranges[si].base_cid = shard_start[si];
> -		scx_cid_shard_ranges[si].nr_cids = end - shard_start[si];
> +		tbls->shard_ranges[si].base_cid = shard_start[si];
> +		tbls->shard_ranges[si].nr_cids = end - shard_start[si];
>  	}
>  
> -	scx_nr_cid_shards = nr_shards;
> +	tbls->nr_shards = nr_shards;
>  }
>  
>  /**
> @@ -849,22 +908,25 @@ bool scx_cmask_empty(const struct scx_cmask *m)
>   *
>   * Fill @out__uninit with the topology info for @cid. Trigger scx_error() if
>   * @cid is out of range. If @cid is valid but in the no-topo section, all fields
> - * are set to -1.
> + * are set to -1. All fields are also set to -1 when no cid tables have been
> + * published yet, which a program may observe while racing the root enable.
>   */
>  __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
>  				  const struct bpf_prog_aux *aux)
>  {
> +	struct scx_cid_topo *topo;
>  	struct scx_sched *sch;
>  
>  	guard(rcu)();
>  
>  	sch = scx_prog_sched(aux);
> -	if (unlikely(!sch) || !cid_valid(sch, cid)) {
> +	topo = rcu_dereference(scx_cid_topo);
> +	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
>  		*out__uninit = SCX_CID_TOPO_NEG;
>  		return;
>  	}
>  
> -	*out__uninit = READ_ONCE(scx_cid_topo)[cid];
> +	*out__uninit = topo[cid];
>  }
>  
>  __bpf_kfunc_end_defs();
> @@ -907,6 +969,7 @@ int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
>  {
>  	struct scx_cmask *kern_src = scx_arena_to_kaddr(sch, src);
>  	u32 base, nr_cids, alloc_words, npossible = num_possible_cpus();
> +	s32 *cid_to_shard;
>  
>  	base = READ_ONCE(kern_src->base);
>  	nr_cids = READ_ONCE(kern_src->nr_cids);
> @@ -921,9 +984,10 @@ int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
>  	ref->base = base;
>  	ref->nr_cids = nr_cids;
>  
> -	ref->shard_first = scx_cid_to_shard[base];
> +	cid_to_shard = rcu_dereference_all(scx_cid_to_shard);
> +	ref->shard_first = cid_to_shard[base];
>  	if (likely(nr_cids))
> -		ref->shard_end = scx_cid_to_shard[base + nr_cids - 1] + 1;
> +		ref->shard_end = cid_to_shard[base + nr_cids - 1] + 1;
>  	else
>  		ref->shard_end = ref->shard_first;
>  
> @@ -946,6 +1010,8 @@ int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
>  void scx_cmask_ref_init_kern(struct scx_sched *sch, struct scx_cmask *m,
>  			     u32 base, u32 nr_cids, struct scx_cmask_ref *ref)
>  {
> +	s32 *cid_to_shard;
> +
>  	WRITE_ONCE(m->base, base);
>  	WRITE_ONCE(m->nr_cids, nr_cids);
>  	WRITE_ONCE(m->alloc_words, SCX_CMASK_NR_WORDS(nr_cids));
> @@ -955,9 +1021,10 @@ void scx_cmask_ref_init_kern(struct scx_sched *sch, struct scx_cmask *m,
>  	ref->base = base;
>  	ref->nr_cids = nr_cids;
>  
> -	ref->shard_first = scx_cid_to_shard[base];
> +	cid_to_shard = rcu_dereference_all(scx_cid_to_shard);
> +	ref->shard_first = cid_to_shard[base];
>  	if (likely(nr_cids))
> -		ref->shard_end = scx_cid_to_shard[base + nr_cids - 1] + 1;
> +		ref->shard_end = cid_to_shard[base + nr_cids - 1] + 1;
>  	else
>  		ref->shard_end = ref->shard_first;
>  }
> @@ -976,7 +1043,8 @@ void scx_cmask_ref_init_kern(struct scx_sched *sch, struct scx_cmask *m,
>  void scx_cmask_ref_shard(const struct scx_cmask_ref *ref, s32 shard_idx,
>  			 struct scx_cmask *out)
>  {
> -	const struct scx_cid_shard *shard = &scx_cid_shard_ranges[shard_idx];
> +	const struct scx_cid_shard *shard =
> +		&rcu_dereference_all(scx_cid_shard_ranges)[shard_idx];
>  	u32 shard_base = shard->base_cid;
>  	u32 shard_end = shard_base + shard->nr_cids;
>  	u32 isect_base, isect_end, nr_words, src_off, wi;
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index 470ac9224da4..1f74d1f331f5 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -48,13 +48,24 @@ struct scx_sched;
>   * See the comment above the table definitions in cid.c for the
>   * memory-ordering and visibility contract.
>   */
> +struct scx_cid_tables {
> +	u32			nr_shards;
> +	s16			*cid_to_cpu;	/* [num_possible_cpus()] */
> +	s16			*cpu_to_cid;	/* [nr_cpu_ids] */
> +	s32			*cid_to_shard;	/* [num_possible_cpus()] */
> +	s32			*shard_node;	/* [num_possible_cpus()] */
> +	struct scx_cid_shard	*shard_ranges;	/* [num_possible_cpus()] */
> +	struct scx_cid_topo	*topo;		/* [num_possible_cpus()] */
> +	struct rcu_head		rcu;
> +};
> +
>  extern u32 scx_nr_cid_shards;
> -extern s16 *scx_cid_to_cpu_tbl;
> -extern s16 *scx_cpu_to_cid_tbl;
> -extern s32 *scx_cid_to_shard;
> -extern s32 *scx_shard_node;
> -extern struct scx_cid_shard *scx_cid_shard_ranges;
> -extern struct scx_cid_topo *scx_cid_topo;
> +extern s16 __rcu *scx_cid_to_cpu_tbl;
> +extern s16 __rcu *scx_cpu_to_cid_tbl;
> +extern s32 __rcu *scx_cid_to_shard;
> +extern s32 __rcu *scx_shard_node;
> +extern struct scx_cid_shard __rcu *scx_cid_shard_ranges;
> +extern struct scx_cid_topo __rcu *scx_cid_topo;
>  extern struct btf_id_set8 scx_kfunc_ids_init_cids;
>  
>  void scx_cmask_clear(struct scx_cmask *m);
> @@ -67,6 +78,8 @@ bool scx_cmask_subset(const struct scx_cmask *sub, const struct scx_cmask *super
>  bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b);
>  bool scx_cmask_empty(const struct scx_cmask *m);
>  s32 scx_cid_init(struct scx_sched *sch);
> +void scx_cid_publish_tables(void);
> +void scx_cid_retire_tables(void);
>  int scx_cid_kfunc_init(void);
>  
>  /**
> @@ -89,14 +102,12 @@ static inline bool cid_valid(struct scx_sched *sch, s32 cid)
>   * __scx_cid_to_cpu - Unchecked cid->cpu table lookup
>   * @cid: cid to look up. Must be in [0, num_possible_cpus()).
>   *
> - * Intended for callsites that have already validated @cid and that hold a
> - * non-NULL @sch from scx_prog_sched() - a live sched implies the table has
> - * been allocated, so no NULL check is needed here.
> + * Intended for callsites that have already validated @cid and that run on a
> + * live scheduler, which guarantees the tables are published and stable.
>   */
>  static inline s32 __scx_cid_to_cpu(s32 cid)
>  {
> -	/* READ_ONCE pairs with WRITE_ONCE in scx_cid_arrays_alloc() */
> -	return READ_ONCE(scx_cid_to_cpu_tbl)[cid];
> +	return rcu_dereference_all(scx_cid_to_cpu_tbl)[cid];
>  }
>  
>  /**
> @@ -107,7 +118,7 @@ static inline s32 __scx_cid_to_cpu(s32 cid)
>   */
>  static inline s32 __scx_cpu_to_cid(s32 cpu)
>  {
> -	return READ_ONCE(scx_cpu_to_cid_tbl)[cpu];
> +	return rcu_dereference_all(scx_cpu_to_cid_tbl)[cpu];
>  }
>  
>  /**
> @@ -116,15 +127,19 @@ static inline s32 __scx_cpu_to_cid(s32 cpu)
>   * @cid: cid to look up
>   *
>   * Return the cpu for @cid or a negative errno on failure. Invalid cid triggers
> - * scx_error() on @sch. The cid arrays are allocated on first scheduler enable
> - * and never freed, so the returned cpu is stable for the lifetime of the loaded
> - * scheduler.
> + * scx_error() on @sch. The mapping is stable while the scheduler is live.
> + *
> + * Return -EINVAL without triggering scx_error() if no tables have been
> + * published yet, which a prog-facing kfunc can observe while racing the root
> + * scheduler enable.
>   */
>  static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
>  {
> -	if (!cid_valid(sch, cid))
> +	s16 *tbl = rcu_dereference_all(scx_cid_to_cpu_tbl);
> +
> +	if (!cid_valid(sch, cid) || unlikely(!tbl))
>  		return -EINVAL;
> -	return __scx_cid_to_cpu(cid);
> +	return tbl[cid];
>  }
>  
>  /**
> @@ -133,13 +148,15 @@ static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
>   * @cpu: cpu to look up
>   *
>   * Return the cid for @cpu or a negative errno on failure. Invalid cpu triggers
> - * scx_error() on @sch. Same lifetime guarantee as scx_cid_to_cpu().
> + * scx_error() on @sch. Same usage rules as scx_cid_to_cpu().
>   */
>  static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
>  {
> -	if (!scx_cpu_valid(sch, cpu, NULL))
> +	s16 *tbl = rcu_dereference_all(scx_cpu_to_cid_tbl);
> +
> +	if (!scx_cpu_valid(sch, cpu, NULL) || unlikely(!tbl))
>  		return -EINVAL;
> -	return __scx_cpu_to_cid(cpu);
> +	return tbl[cpu];
>  }
>  
>  /**
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e6c4cbe1f182..6a4e3a4f6098 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3334,6 +3334,7 @@ static void handle_hotplug(struct rq *rq, bool online)
>  {
>  	struct scx_sched *sch = scx_root;
>  	s32 cpu = cpu_of(rq);
> +	s32 cpu_or_cid = cpu;
>  
>  	atomic_long_inc(&scx_hotplug_seq);
>  
> @@ -3353,10 +3354,26 @@ static void handle_hotplug(struct rq *rq, bool online)
>  	else
>  		scx_offline_ecaps(rq);
>  
> +	/*
> +	 * The tables can't be retired while this function is running as the
> +	 * retirement is inside cpus_read_lock. However, scx_cpu_arg() is
> +	 * awkward here as the tables can be NULL after root enable failure and
> +	 * lockdep would trigger without surrounding rcu_read_lock(). Open code
> +	 * the translation. If the table is NULL, the ops are also cleared and
> +	 * @cpu_or_cid goes unused.
> +	 */
> +	if (scx_is_cid_type()) {
> +		s16 *tbl = rcu_dereference_check(scx_cpu_to_cid_tbl,
> +						 lockdep_is_cpus_held());
> +
> +		if (tbl)
> +			cpu_or_cid = tbl[cpu];
> +	}
> +
>  	if (online && SCX_HAS_OP(sch, cpu_online))
> -		SCX_CALL_OP(sch, cpu_online, NULL, scx_cpu_arg(cpu));
> +		SCX_CALL_OP(sch, cpu_online, NULL, cpu_or_cid);
>  	else if (!online && SCX_HAS_OP(sch, cpu_offline))
> -		SCX_CALL_OP(sch, cpu_offline, NULL, scx_cpu_arg(cpu));
> +		SCX_CALL_OP(sch, cpu_offline, NULL, cpu_or_cid);
>  	else
>  		scx_exit(sch, SCX_EXIT_UNREG_KERN,
>  			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
> @@ -6197,11 +6214,12 @@ static void scx_root_disable(struct scx_sched *sch)
>  	scx_unlink_sched(sch);
>  
>  	/*
> -	 * scx_root clearing must be inside cpus_read_lock(). See
> -	 * handle_hotplug().
> +	 * scx_root clearing and cid table retirement must be inside
> +	 * cpus_read_lock(). See handle_hotplug().
>  	 */
>  	cpus_read_lock();
>  	RCU_INIT_POINTER(scx_root, NULL);
> +	scx_cid_retire_tables();
>  	cpus_read_unlock();
>  
>  	/*
> @@ -7195,10 +7213,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	cpus_read_lock();
>  
>  	/*
> -	 * Build the cid mapping before publishing scx_root. The cid kfuncs
> -	 * dereference the cid arrays unconditionally once scx_prog_sched()
> -	 * returns non-NULL; the rcu_assign_pointer() below pairs with their
> -	 * rcu_dereference() to make the populated arrays visible.
> +	 * Build the cid mapping into a private under-construction set. It
> +	 * becomes visible to readers only through scx_cid_publish_tables() once
> +	 * ops.init_cids() has finalized the layout.
>  	 */
>  	ret = scx_cid_init(sch);
>  	if (ret) {
> @@ -7235,6 +7252,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  		}
>  	}
>  
> +	/* the cid layout is final, expose it to readers */
> +	scx_cid_publish_tables();
> +
>  	ret = scx_arena_pool_init(sch);
>  	if (ret) {
>  		cpus_read_unlock();
> @@ -9872,13 +9892,15 @@ __bpf_kfunc u32 scx_bpf_nr_online_cids(void)
>   *
>   * cid-addressed equivalent of bpf_get_smp_processor_id() for scx programs.
>   * The current cpu is trivially valid, so this is just a table lookup. Return
> - * -EINVAL if called from a non-SCX program before any scheduler has ever
> - * been enabled (the cid table is still unallocated at that point).
> + * -EINVAL if called before any scheduler has ever published its cid tables.
>   */
>  __bpf_kfunc s32 scx_bpf_this_cid(void)
>  {
> -	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
> +	s16 *tbl;
> +
> +	guard(rcu)();
>  
> +	tbl = rcu_dereference(scx_cpu_to_cid_tbl);
>  	if (!tbl)
>  		return -EINVAL;
>  	return tbl[raw_smp_processor_id()];
> @@ -9937,13 +9959,17 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>   * @p: task of interest
>   *
>   * cid-addressed equivalent of scx_bpf_task_cpu(). task_cpu(p) is always a
> - * valid cpu, so this is just a table lookup. Return -EINVAL if called from
> - * a non-SCX program before any scheduler has ever been enabled.
> + * valid cpu, so this is just a table lookup. Return -EINVAL if called before
> + * any scheduler has ever published its cid tables.
>   */
>  __bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
>  {
> -	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
> +	s16 *tbl;
> +
> +	/* KF_RCU covers only @p - a sleepable program holds no RCU lock */
> +	guard(rcu)();
>  
> +	tbl = rcu_dereference(scx_cpu_to_cid_tbl);
>  	if (!tbl)
>  		return -EINVAL;
>  	return tbl[task_cpu(p)];
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 26bfda216524..a9a853a71061 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1504,8 +1504,9 @@ struct scx_sched {
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	/*
>  	 * pshard[] size captured at enable for the async RCU free path -
> -	 * scx_nr_cid_shards may be rewritten by a later scx_cid_init() before
> -	 * free runs. While sch is active, use the global.
> +	 * scx_nr_cid_shards may be rewritten by a later enable's
> +	 * scx_cid_publish_tables() before free runs. While sch is active, use
> +	 * the global.
>  	 */
>  	u32			nr_pshards;
>  #endif
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 8d8737149bc0..d7842a609d96 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -138,7 +138,9 @@ void scx_free_pshards(struct scx_sched *sch)
>  
>  static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32 node)
>  {
> -	const struct scx_cid_shard *shard = &scx_cid_shard_ranges[shard_idx];
> +	const struct scx_cid_shard *shard =
> +		&rcu_dereference_protected(scx_cid_shard_ranges,
> +					   lockdep_is_held(&scx_enable_mutex))[shard_idx];
>  	size_t cmask_size = struct_size_t(struct scx_cmask, bits,
>  					  SCX_CMASK_NR_WORDS(shard->nr_cids));
>  	struct scx_pshard *pshard;
> @@ -176,17 +178,21 @@ static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32
>  s32 scx_alloc_pshards(struct scx_sched *sch)
>  {
>  	struct scx_pshard **pshard;
> +	s32 *shard_node;
>  	s32 si;
>  
>  	if (!sch->is_cid_type || !sch->arena_pool)
>  		return 0;
>  
> +	shard_node = rcu_dereference_protected(scx_shard_node,
> +					       lockdep_is_held(&scx_enable_mutex));
> +
>  	pshard = kzalloc_objs(pshard[0], scx_nr_cid_shards, GFP_KERNEL);
>  	if (!pshard)
>  		return -ENOMEM;
>  
>  	for (si = 0; si < scx_nr_cid_shards; si++) {
> -		pshard[si] = alloc_pshard(sch, si, scx_shard_node[si]);
> +		pshard[si] = alloc_pshard(sch, si, shard_node[si]);
>  		if (!pshard[si]) {
>  			while (--si >= 0)
>  				free_pshard(pshard[si]);
> @@ -198,8 +204,9 @@ s32 scx_alloc_pshards(struct scx_sched *sch)
>  	sch->nr_pshards = scx_nr_cid_shards;
>  	/*
>  	 * Publish only after every entry is built so a reader observing
> -	 * @sch->pshard never sees a partially-filled array. Pair the store
> -	 * with a barrier and READ_ONCE() on the read side.
> +	 * @sch->pshard never sees a partially-filled array or unpublished cid
> +	 * tables. Pair the store with a barrier and an acquire load on the
> +	 * read side.
>  	 */
>  	smp_wmb();
>  	WRITE_ONCE(sch->pshard, pshard);
> @@ -524,7 +531,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
>  
>  	/* @cid is valid here: the cpu is active with queued syncs */
>  	cid = __scx_cpu_to_cid(cpu);
> -	shard = scx_cid_to_shard[cid];
> +	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
>  
>  	batch = llist_del_all(&rq->scx.ecaps_to_sync);
>  	llist_for_each_safe(pos, tmp, batch) {
> @@ -618,7 +625,7 @@ void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
>  		return;
>  
>  	cid = __scx_cpu_to_cid(cpu);
> -	ps = sch->pshard[scx_cid_to_shard[cid]];
> +	ps = sch->pshard[rcu_dereference_all(scx_cid_to_shard)[cid]];
>  
>  	guard(raw_spinlock)(&ps->lock);
>  	queue_sync_ecaps(sch, cid);
> @@ -631,12 +638,23 @@ void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
>   */
>  void scx_online_ecaps(struct rq *rq)
>  {
> -	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
> -	s32 shard = scx_cid_to_shard[cid];
>  	struct scx_sched *pos;
> +	s32 cid, shard;
> +
> +	/*
> +	 * Only a live hierarchy can have ecaps to reseed. This also keeps the
> +	 * table reads below away from an enable that failed before publishing
> +	 * the tables. A concurrent disable can't retire them, see
> +	 * handle_hotplug().
> +	 */
> +	if (!scx_enabled())
> +		return;
>  
>  	guard(rq_lock_irqsave)(rq);
>  
> +	cid = __scx_cpu_to_cid(cpu_of(rq));
> +	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
> +
>  	scx_for_each_descendant_pre(pos, scx_root) {
>  		struct scx_pshard *ps;
>  
> @@ -2074,9 +2092,10 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
>  	/*
>  	 * The target's caps storage may not be set up yet (e.g. a self-read
>  	 * during ops.init_cids()). Pairs with the publish in
> -	 * scx_alloc_pshards(): a non-NULL pshard has every element set.
> +	 * scx_alloc_pshards(): a non-NULL pshard has every element set and the
> +	 * acquire also orders the cid table reads below against it.
>  	 */
> -	pshard = READ_ONCE(target->pshard);
> +	pshard = smp_load_acquire(&target->pshard);
>  	if (unlikely(!pshard)) {
>  		scx_error(sch, "scx_bpf_sub_caps() called before caps storage is initialized");
>  		return -ENODEV;
> @@ -2089,7 +2108,8 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
>  	}
>  
>  	for (si = ref.shard_first; si < ref.shard_end; si++) {
> -		const struct scx_cid_shard *shard = &scx_cid_shard_ranges[si];
> +		const struct scx_cid_shard *shard =
> +			&rcu_dereference_all(scx_cid_shard_ranges)[si];
>  		SCX_CMASK_DEFINE_SHARD(local_out, shard->base_cid, shard->nr_cids);
>  		u32 cap_bit;
>  
> -- 
> 2.55.0
> 
