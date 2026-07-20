Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265633120A
	for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540482; cv=fail; b=PF3f6lEK8eyqWG4ROsl9Y9NMURrxRg//OBoisl+K0GUJgq54VTXHOOKsrfdIB1GQYInkZ8WQZrCG/O1QcKne6qF5+NSB+TelOSd7WzEH40pvI9AIVh+qoZlrt0qmRhmMTTYilor+pzpB+uMpkPtsYvhAAopMTd724mCY6WRzdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540482; c=relaxed/simple;
	bh=AizZ8rsOqnGtSClali29l1t8yQ7RyfhaaK/akpqPhtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1o+0mx/qizbn7LhhBddJpeeZHt4aAob24LXpQ0bFe5pDO4fNF9AFd4z/2Q5ArC71z4iCWUZUa/zSJR9VuqhkL9DkEyVRWB3kZvCanZnQ8lGzCORVzzuxXtkRGrvivzPzmhNz9s6gXxCZX4yHCBIiM03c/khn306lu2ybABrnzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U31/rNco; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U31/rNco"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqXU+Sb5kkTitbeewjFN1xWmFQRDWjeii1jL434ADfOhyod7wi6k+H3tmIt8MV/q++pKjr3RL5UGpMjZjR3UJqcAQ1sZvqhJrb21SxoUNcJ+8jeSpZc3oN/ZYHMAzteOUnUdTQDKmWR+rEKlXNLFnk+UwKyLSIrQiB6RZrv/0AXMvEpWrkHEn44xOiPEwMVxF85PXPd3sQw0WvLSRp6KOvp05Q8grtcu5PZ9wQWk7YOJ7RWFifUAjU4/nJy/qKOLhdeTttEr4If9eKFeZhRPOe4tLTy93Gc2WS6TaukR87tXvSMkkTZGLULmKKPDrCjwd44CAXiZINrkkpMQkY7bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VaUXBL2Lv7QuXH+OKvZyGFokjil9yrocXHULn79ufs=;
 b=Qja/CfSbQjVc0Y+aweJAOTcWw+xHUB7/dZjCo6hbccwxrBAlXR3exl9wnIpB8zSnQx9+OiyIlHV9YslKSggqI0veWWLRM/axXtuHt9AxviZ4xIE2JMLgyOznsBhLNG9IjneetyXlpDT9mAErBnrKplrMFNOkRuPLhRfUP48SPSAgDc69NEg1GM17nEZi1qWT/XOZAs7XAmqZrw9iHCJmOa2p0sG0Uxn7LW8QKmxgCSCvvyHgQ9wRm4rx15ISTGjdMfFLU3IzbiN3GmjmQC81MuMNpEFQLCwV7qdfyQlsJYbVefvYsS9bMVzSbTZOoMS7YHTZWiKwy7OEYhS69vVssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VaUXBL2Lv7QuXH+OKvZyGFokjil9yrocXHULn79ufs=;
 b=U31/rNcoPqUMkGp2M336mkiaU+rq3DzLJXZ9rp0HeRrd/Uo97TMrb2rw5pATAv2owASaaJ8+3IIikzfh6DaZQNOEThme81id3zbDhJuv/rE2ZBHwyICjdSSnpz71f2PNw+0mp4mcoN/osmdzQv2PdGV+AiAe94gjJwblHMhrOvoTP6KirBpIQBAPKeStw1dT+Jd3iHluTuBfhxAWJWKfL9EkmhkE8HFQy5nrt/qbpoTZB5NZweh/25OQuxK4Gll80oXz6MY3APX3/y2QsHWpsC8ixbOs0J8przD4mKkohaDHNbhJSyITAVOY4qOiVywduL3pPvRbxv6nfI/ID+ffXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 09:41:15 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:41:14 +0000
Date: Mon, 20 Jul 2026 11:41:02 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: Guard the cid kfuncs against unallocated
 cid tables
Message-ID: <al3tLtPZZkFjMveK@gpd4>
References: <20260720082605.1451945-1-tj@kernel.org>
 <20260720082605.1451945-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082605.1451945-4-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::45b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8c3ea4-d3e9-4cb3-0e23-08dee64308a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4xOMFEbCnydgAMcMJcQ1iVwGP2vU1JVONQX4xFch2UZ7lGbXtwWJ1YHic0dRvvOv16mTnuk+DOiebYoRXMAq7To2by/LWYceILrtrpGu19INohOfjUBUJvWSRfrhcW2PldiTrXai79GiVEbCC8jKra14UTk8eGPvGBRH0yN20acdTVCgLdoWg3Uihoan9SyQU5LZ0+7isrCzTf/jMtV9Fh/rwKgS4jm3zFHJEX6NQjePIb6saRr4XQGMFQPz5iirYzkwKWKWAZ5/erc8xryVktpZa3DPDQvOdjmn0fJy5JEQyC3pClff7LyOMdkbwDSk69HJGvLLwSgnNJt6iCvFDNTwp3Pi5jstepajpur5FEfS32MGLxKF9HkUtp9UFOFn/AocWfyVB9HI54FeEKrQdZezSyenlGIDPgaYqrbhCfQPmcsqKVoO+RANskWfPqLvlr37DJsFW9nru2nyh0N985J+9yg02EM3jh9lQ1Wd0t61WuwV35OmpNGaL4W7VE5wcu8shcspPJU3JrxZpJwe9lQHPRdpKpZZGbpqcSfr9iW4TfSPimEgFhnAchsXM3H8UcbYrAxWeRTNAFnj8reXc6DJ4G79unpt0sn2if39ER77Ukh6yXiXXssJSR4ljtzNAImVAKLzXbcvn4fsA9wD+gqW1ZI6Qoh1JVExNRRauns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hU4WN9WHWnVqAKcPJn7nAAkEcD0qp14mie/pdXv7LE/wEWf38+Kx9PEHZHri?=
 =?us-ascii?Q?oWHYApz4aBJbq/pvq1Ui0yzErthM1aiVRnw+hB/qteINNPGHbBH4A5lwJPeM?=
 =?us-ascii?Q?2Cg2TWm8at0oUXY/pKf4NCBUDH9QBeVanT7DIuuC5ttslwbzMdoX6hxddg7k?=
 =?us-ascii?Q?V8+DZ780TOFqG77IY4kgiwW6bdI5Fn3olmqWiorHsi6BLXrmUpubyfHigoBV?=
 =?us-ascii?Q?SpdY9mu05ZPMbE/6HYkGmTUUJTNuxpKmTwFxEzDVhTb7rkhHbJ9C0ZqOLBsU?=
 =?us-ascii?Q?nXAnFkNVp/pG4qlecFd47/2CXe1nDQDfWqw9l1PVcUTIJyFGuT6ckd8DGkSV?=
 =?us-ascii?Q?JGKzwJWWVXPRK3PHzQKWnZ1g02wBS75AZjPpu7tRmZPBm1IwJrPxDRaXtf7o?=
 =?us-ascii?Q?6aH/KUGZiQGEx7rycoUlh/1zc+r2V4I1+ka4+50y0yy1IcZRR9t/5Mmyp6ch?=
 =?us-ascii?Q?yuF936Pmd2290GNll4zxQ/PmgL5IRKv0ra8vMLkzDYFlP/dtE3GgGN9REQBO?=
 =?us-ascii?Q?YdMz0qTtvCVChPEBnDSVXhAtekmxZqFpeavwj4be07sAQEhnH4Uq2iyUvUPm?=
 =?us-ascii?Q?fZPGiQ492bzBh75iZdFROwf/4fvAxh7GoqMGoU69yz910IVk07pLnjH0HUwe?=
 =?us-ascii?Q?XKP69rkYzt/QlIqATPacyYgJynXuBUaTjM9v8aS4BUKYLKNkxIzwvKttXJJ0?=
 =?us-ascii?Q?xBaFZRF+LJnzCsta7Cwu4H/nOR1s5hioaWZxl2OjNA4N7NXjrUmudxbyBY/E?=
 =?us-ascii?Q?OMGjFQ/gFQU9cBWlByusppj2fzzO8EqjCOATIkXDnKcudfX93ZUTDGj2J1gi?=
 =?us-ascii?Q?3girvEEV8e4xhK0TYv4n6pegYdgFtJsze3s9vvq5PLFADcg1qqu2Ee8nkznC?=
 =?us-ascii?Q?n4WGdnf07K9eKBZ2UHj1v8lkE80uRwQlgEDGJ5kHZJZ7erlIfezlkPck92W9?=
 =?us-ascii?Q?e+O85+H4kkZ+XihYvQ4dzTH/KXXDvRycuNzYaQJ6bl/xJVW2uPhBpIwgiuwf?=
 =?us-ascii?Q?QsAbSJXGHhu6lFePtxa6kcxOdvoPh1BDgl8SiUcl+xMQIuxdH5YvEyxWkW+d?=
 =?us-ascii?Q?NWOOsbhWhRF7kCT8kdDrWNfvdlq8s4ap461zhIJJr1z8F5ZRUYdXDMODt4oX?=
 =?us-ascii?Q?HBv+U02ojlnjPHQJjNYB6eMz/47g7LZsad5zXy/9hsJ3llQAIdAXepPA1Tu2?=
 =?us-ascii?Q?wnVelERiRvA9PVhdGmHPPXodhTzoL6PMmmTrfYJJhii0bEPhr9EuTKpI8rJK?=
 =?us-ascii?Q?+9A0iTHcenpUwwWZhSoAKnIpovuCRHMEQalXCn0zZWtfP8pgU/hHCbrORo+5?=
 =?us-ascii?Q?hAXiZIJrx7brnA+DDJk0H4lDvEI0Puy5UrD+V+K0qUcdfDAqtHtrJTgTsePD?=
 =?us-ascii?Q?IKI73BV/HW6ISAll7vwiW82A4Zi3p29L/aXARByWRNoO6guvQPge1OjmcnII?=
 =?us-ascii?Q?jPgXi5Hv944oeGq/WKVyqbfkgoOZBV8SXTQNu/vMlQDAqGtxOHPHyU/lMLRF?=
 =?us-ascii?Q?7ESIw6k0NEE25jm3RIyEmMoS9KLtWwaQ7X9/IxntQKlSxodEQ9+R206KdIv1?=
 =?us-ascii?Q?PEvV5bF+9xGYNgCHfG1AuJFOJDTDtlIl/Hzipo9E41E4upGWcwVKFNO7rUAc?=
 =?us-ascii?Q?a3yxkVhRuDNyNWjwBF4tFC6nc0DAryJtGkS7WbW48Qny3GOnJeaiIcGF4Dwu?=
 =?us-ascii?Q?Rd9u9UntZGC2fS/xTVUjsr+nodk9miAim8BffKDXEr592jjGaUo0YRGw4cMr?=
 =?us-ascii?Q?fYJ779GhBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8c3ea4-d3e9-4cb3-0e23-08dee64308a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:41:14.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NGJlsY20mR+s0pChZowhL3+/Y7W7MVuqcBMd7NfyLTg04CFrYRt3QEw42/ezGFsqTEd4ruJosw0k1ZVImPyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

Hi Tejun,

On Sun, Jul 19, 2026 at 10:26:05PM -1000, Tejun Heo wrote:
> The cid tables are allocated by the first enable's scx_cid_init(), which
> runs after scx_alloc_and_add_sched() has published ops->priv. A TRACING or
> SYSCALL program associated with the enabling struct_ops map gets a non-NULL
> sched from scx_prog_sched() as soon as ops->priv is set, so a cid kfunc
> called in that window dereferences the still-NULL table pointer. Only the
> first enable since boot is exposed as the tables are never freed.
> 
> scx_bpf_this_cid() and scx_bpf_task_cid() already handle the window by
> testing the table pointer. Do the same in scx_cid_to_cpu(),
> scx_cpu_to_cid() and scx_bpf_cid_topo(), returning -EINVAL / all-(-1) topo
> as before any scheduler is enabled. __scx_cid_to_cpu() and
> __scx_cpu_to_cid() stay unchecked for callers with the tables guaranteed
> allocated - ops invocations on a live scheduler and the enable path itself.
> 
> Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/cid.c |  5 +++--
>  kernel/sched/ext/cid.h | 23 +++++++++++++++--------
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 9dfd242be34f..699cb8db228d 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -875,17 +875,18 @@ bool scx_cmask_empty(const struct scx_cmask *m)
>  __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
>  				  const struct bpf_prog_aux *aux)
>  {
> +	struct scx_cid_topo *topo = READ_ONCE(scx_cid_topo);

I think a non-NULL pointer here doesn't necessarily mean that the table is
initialized. IIUC scx_cid_arrays_alloc() publishes these pointers before
scx_cid_init() populates them, so a racing program can still observe zero-filled
uninitialized cid_topo entries.

This also applies to the other enables, where the tables renamin non-NULL while
being rewritten. Should we add a defer publication until initialization is
complete or a readiness flag?

Thanks,
-Andrea

>  	struct scx_sched *sch;
>  
>  	guard(rcu)();
>  
>  	sch = scx_prog_sched(aux);
> -	if (unlikely(!sch) || !cid_valid(sch, cid)) {
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
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index b36a1a28eac8..1498efb81549 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -90,9 +90,10 @@ static inline bool cid_valid(struct scx_sched *sch, s32 cid)
>   * __scx_cid_to_cpu - Unchecked cid->cpu table lookup
>   * @cid: cid to look up. Must be in [0, num_possible_cpus()).
>   *
> - * Intended for callsites that have already validated @cid and that hold a
> - * non-NULL @sch from scx_prog_sched() - a live sched implies the table has
> - * been allocated, so no NULL check is needed here.
> + * Intended for callsites that have already validated @cid and where the
> + * tables are guaranteed allocated - ops invocations on a live scheduler or
> + * the enable path itself. Prog-facing kfuncs, which can run while the first
> + * enable is still allocating the tables, use the checked wrappers instead.
>   */
>  static inline s32 __scx_cid_to_cpu(s32 cid)
>  {
> @@ -119,13 +120,17 @@ static inline s32 __scx_cpu_to_cid(s32 cpu)
>   * Return the cpu for @cid or a negative errno on failure. Invalid cid triggers
>   * scx_error() on @sch. The cid arrays are allocated on first scheduler enable
>   * and never freed, so the returned cpu is stable for the lifetime of the loaded
> - * scheduler.
> + * scheduler. Return -EINVAL without triggering scx_error() if the tables are
> + * not allocated yet, which a prog-facing kfunc can observe while racing the
> + * first enable.
>   */
>  static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
>  {
> -	if (!cid_valid(sch, cid))
> +	s16 *tbl = READ_ONCE(scx_cid_to_cpu_tbl);
> +
> +	if (!cid_valid(sch, cid) || unlikely(!tbl))
>  		return -EINVAL;
> -	return __scx_cid_to_cpu(cid);
> +	return tbl[cid];
>  }
>  
>  /**
> @@ -138,9 +143,11 @@ static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
>   */
>  static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
>  {
> -	if (!scx_cpu_valid(sch, cpu, NULL))
> +	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
> +
> +	if (!scx_cpu_valid(sch, cpu, NULL) || unlikely(!tbl))
>  		return -EINVAL;
> -	return __scx_cpu_to_cid(cpu);
> +	return tbl[cpu];
>  }
>  
>  /**
> -- 
> 2.55.0
> 
