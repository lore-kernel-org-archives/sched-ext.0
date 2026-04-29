Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30523F7AB7
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469393; cv=fail; b=hvI4SUGIPwXCuKrkhzNjT4ErxgTlg7S1Z27KUYBPVH3KHSVL4ippFStsu7+C0DgQXgL/FswR2aNOMscPulstCBqcBBo1MWNG1iDUtfp/ElPS8RZlU+TCebM2jdWEd2GRs1FWXEIGbNbUL8ubCFs0BcdNnDfImYgATFtsA6MIuxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469393; c=relaxed/simple;
	bh=yFtY6G0CIG5onALmFsQMwzO9a3+Ns817UWE62JJjFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7CGUw/Ht9IN2uL3/7krIDUVTPyduJex2kzZFv6P6T1/jy6NB6ituFY0b0OESvdloX9Ey/GVwmz1Ql2jao9CkGse4AeRwyglj3hRGggGmgeCpMfYLWkvveqLwlOkypj8k0mDnOClks16RBanUzbBHyfwhhmuI628WOHJ4Nb6T0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+12Ys0P; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+12Ys0P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgd6Mr7SO3/OCreho3OlwPEaq+YeM4CJ1Is4t8M9ZBWYnuvXPJvJsHtwKleyCiaM6297urwwCr41rwQqQx902oxdb650oYxKNOAqSiFI6ZG6rAp0qFtO8xTvTQ7zsNL3ZwaWYKGivZGQlJ/RW41QwD7r/y/LV079lHN0Z9KjQz0K61qKJCTeDDO8xXFBlePmPm35WDmOLHpArfy7EEwRUxRNXoMf/FF75PaAEi7JeOaCZusyv/RRx3rMdDep/jTcYTwi16Gt/85fXNZ5E37uzvk+YSshM1ZNApnAiNevGwOWhkf2axg1C3obx9C1WFSIP17SGR1gV1QGdf1BOgNm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTUKS43JXzZithZePsoCcIpWalecGjctm8hMdb3btIc=;
 b=QvgF3sOHy0QB2zhdisxw8tdxNcxd2ySXDp6C5txVhzMe8gnHuZOcDxSGJGZmUPCy3ylEs6ANOm1Q5ns6boMfijssFE6uh1cB8AdDn23uM7MgV+4WcVR/JbihmqC6iQsAVCAhbB92cjzsqAsV78gEYggsNlxDlvQuG4/ONi6B8rxc7vCxLDlMExzLBy/hRAK2R7OCE+uVAWlacWB2jJlnpoCmGXdmpHT+NUbUk9s2g/kXqjvgRE0hPau6RWFXPPWeo0vbs1h4bT7eIYFweyqL9s9t+tyA4RXc0Wb/5T3sewPge4buNXjUk/fUu0v6T9uLyIaRx0f70+HjM9N/dogXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTUKS43JXzZithZePsoCcIpWalecGjctm8hMdb3btIc=;
 b=U+12Ys0PRfpAgBwUB2Tjxokk9YL9GfwyCOaONxZFfdkNQVCnp8yFSEMUGgesF/rtImqLyU6phP2FbBQYvm9T8kZBeEhvGIGybL5tYwRokTNWIULPjGzdo/iAIAFIkZ5QYIwg0QTVdHkekQLt/NsorZKbnthXPAK7IV0gxGFM9PTNpxbTHoACT3NvXcQ2TvQnsH8W8teStBTEcbgI/c5X2fsSQEeRYGeb/nfTjfs92fLG6Jgk5PS+OwLVeZ3Kgq5uMt1cs9S9Blasx3QU7uIP4jISpULU6+04rVVs2AMP4QMzIjPzeZdQZ55JnDrI3g+rBLygakVkHKn8VWZvjxd/tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 13:29:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:29:42 +0000
Date: Wed, 29 Apr 2026 15:29:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Topological CPU IDs
 and cid-form struct_ops
Message-ID: <afIHuXXJWHEJnzaO@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 630f32dc-ca6b-40bc-7091-08dea5f35efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1dUARPVt7hz5SfiupcyYfyvWrcNZTHsrDfytn0/nsvoTxDn6huE1ckLOEEFgCGu4V6yc2qaXQMv25hKI9yz0cnYd9ObBvfrxWGB0cuJmymieJR1Akcv7gXdhAsM+t7udkvcOjChsTiGcfq+RJvx7O4xDrMTzUfVWXbOg0rp8sW8tRhZagBRmpzOZEXAglzgVP5+zWHyGpBzekxDkmMZD6e8rhErXWcZmbYtnfXdd8Uam5jjo2fn/E1OgHC6JChmMADo+ezB3WuRtCXqohR/nwX436msMjwTqOENsoFxmcUaJ1SD3X8lY2/ECaJvv454YVw91F3bztgzKBdzZpYl7lfN8uYXCBn7CgbTzcVcybnf/cRQt2DsC/OG4o7CTz+i1dWlq2b+FL+UPBNqquR+8NjYzbSGicZ9MAz0HGf6s/rhHTR6DVEDJTSjsdQoGOvBKbsUJeMYGvgsdZOUNIDYrlg2XDeuZ7fwIzayOEuDNY8xxvoQRV6MG4lEQM9Ct/k9JcNHGBGTJ1t5PnEEDDbK848G7uaPvzQRf7pC7DDb7zidUVXrJiyJwdgd/8nhUj+fTjtL0h0PE/I+EWsreTWyoWWo369FZSSltnHehL0B8XzFTGmiHf89GvxcNa0c9FRaRDv6mSy2hlpkIrs99yfKYaHZQ+/XrDFxEIfD28TEqCyXD/Ps97/o3unX4MemCjFpTsteyUSbv3XTo5/DdLo2XfwqvEX4Hfw8xQwETlvOY/0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5poXnzXbDvCOsB/TgZjgOQWIM4PL/fFJHAzqxARL7o9ZA2GNyyikuYI/JSKl?=
 =?us-ascii?Q?K3ceGR8Seg5gyjhUmUcIoy3rGOSaKFvxjXO7LnBZ7uap5jiKWKPk0ktXQQNn?=
 =?us-ascii?Q?+ZDnfnclSOP4q2gcOe3U+bBQcDMdT+4nGmj60JkN/7wtH2kgp4qFUI3pu9f8?=
 =?us-ascii?Q?mygc0NPEyhmL1GXzR6pp88zALtYu/gqPgpQeOk7hqU5WiUqwNX2BYcKNDd62?=
 =?us-ascii?Q?WjKpN94QwZFi5ewIFzj2n7qXJuKAJFgP2NkoXcL3xModTTX6C7/fuukUBXol?=
 =?us-ascii?Q?vmD8cHgTHhp+kyQwUMpRKCes3hgRUuP5Cq8zg+RBupaGftjhGl3Ddjak1aDh?=
 =?us-ascii?Q?YbKTB7ZRvtc5m7UVNf3xZ5//Ax8JIePjvIYLI7W/+HbQsKxApdgcm08vn6CQ?=
 =?us-ascii?Q?pcURKp2LKAfi9bqqQ30frEQiDogKFp/mOCk/QMTOPSGCYryHEVVNlVE5Gwbc?=
 =?us-ascii?Q?a0WqHp8MNNsfs6GHS5XapwG5DNS3WlYqSejeCXB5njONXT9hOlxGd9T3ee9d?=
 =?us-ascii?Q?rD8pXYEyuXK9TAv6AojV9rHWuebqH2qn9r6r4ViMvgVgPZfqXz6ufPh80SzW?=
 =?us-ascii?Q?sv7Tknxq9N6G/u6QRbpRivhni2qnTZgw8tmOTJdZ5D1+YtVlwFW374tUBW/j?=
 =?us-ascii?Q?8AuLBIDCPMAapQGX/UUUFQ8RAbRZwJI74n1wSLJfLjb7t5QhR5uVlum+RmzY?=
 =?us-ascii?Q?NaxiyzvL/dx9nI6dPVL5raJRgWMHeTq9NIcO2jDHfbhaYGSoh5JAeBAPMWOo?=
 =?us-ascii?Q?WqzcpIWAJuGSFdvMrE+/w/BipLY503Nya6B7aFUSnXlpuRlhNlmNrvn5CXvG?=
 =?us-ascii?Q?2CT6qhtTfJSwFTUxGXS9knpWTuWOFCPHup9d8DTm4YPWackhISSE8VH+B0DX?=
 =?us-ascii?Q?L0Eo9vbpdiNJyUTilB3SbtnEzR8bbIiHHY/aIhI3Lmj6rRfJzh6leBlcEvjE?=
 =?us-ascii?Q?tCGkNrE5gPzuua1RdjcEEMqmqeW5/fLp81heOmeOei9O5DG31aysjt6zVi0H?=
 =?us-ascii?Q?gfu9gGgGnZks8ZvYnvttDpRUfRJIKEGECJO/dHcnoDpC/tPbTB7GRvO9avnF?=
 =?us-ascii?Q?gZaJWTeNV+nNHYIbL9dHvb/XPmVWSvS731F96gXzsyzNaX0mbH/NXtQqVv3r?=
 =?us-ascii?Q?fbk6bxWOmEnFKd4+V8vFYfzdl9G+7qUbfIHh8cEU9OHZeVPLvhd5fAKm0OLC?=
 =?us-ascii?Q?s97wwBhK2rkYhKFcAtHzWgnzW51VRW+MdcF0OW5n1wzff92vuHuokXUCtlEi?=
 =?us-ascii?Q?TvQQiZWiKi+tNko5MZrzWfAXM2gmFGBzx6QaDVzgEhXaEsGqsueuEYqzIGz5?=
 =?us-ascii?Q?65sDzOs3oHSpTenuH4GvWUMFoMPgaq5zKByVWEH2SIAGMTcAsHNJ93oVcvDB?=
 =?us-ascii?Q?kRKL/BXJD+aw9NKqVtcECnOmDglmOYT0xHfZUgHWqU07KBF8tO9yydDkXd9K?=
 =?us-ascii?Q?sLZCyrFEu5MNEdTR7H4ZgpaWeySkzoy4lqmPv2LoxVtV4Bb0Q00RxJyNi0Xy?=
 =?us-ascii?Q?RllnUzASEmL1kWFp6K4M1ctQ2rHoQQpVM0Zby+PHnQmg1m7W8QtUKsG3eUbY?=
 =?us-ascii?Q?RVLVA2Avey32UL2bbz+eDsJuHHeAFCLFJmDBbvA6zUPhoG6Eyu1V9tcHNN/z?=
 =?us-ascii?Q?kDcRCgZOt6YZzPg1JYP4xXL13CkzQsBq14znxSMpX6+5N30OBe3C9LnnS7Dl?=
 =?us-ascii?Q?NpXk+u/N5hiuY/WnJ8hM4RoCLA2TYHwFetOhGLMDUTsLgJNlN3HcGjGFCOXw?=
 =?us-ascii?Q?EDWgzbEyqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630f32dc-ca6b-40bc-7091-08dea5f35efa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:29:42.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EEzldzqY9J0uQOFihdPja4LmPdcEZWKkKpmV1UQSVttiN+DJrH0TLyLvYsfCEEMvz0Y8JKos9D392UnQUalTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

Hi Tejun,

On Tue, Apr 28, 2026 at 10:35:28AM -1000, Tejun Heo wrote:
> Hello,
> 
> v3 (all from the Sashiko AI review at
> https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org):
> 
> - cid: drop leaked cpus_read_lock() on scx_cid_init() failure;
>   BUILD_BUG_ON tightened to NR_CPUS<=8192 to match the BPF cmask
>   helpers' CMASK_MAX_WORDS coverage.
> - bpf-struct-size: use offsetof() in struct_size() to match the
>   kernel <linux/overflow.h> macro semantics (no inflation from
>   trailing struct padding).
> - cmask: cmask_copy_from_kernel() validates src->base==0 via
>   probe-read; nr_bits check is bit-level rather than rounded-up
>   word-count.
> - cid-qmap-idle: qmap_init() refuses to load when scx_bpf_nr_cids()
>   exceeds SCX_QMAP_MAX_CPUS; the task_ctx flex array would otherwise
>   overflow into the next slab entry.
> 
> v2: https://lore.kernel.org/r/20260424172721.3458520-1-tj@kernel.org
> v1: https://lore.kernel.org/r/20260421071945.3110084-1-tj@kernel.org
> 
> This patchset introduces topological CPU IDs (cids) - dense,
> topology-ordered cpu identifiers - and an alternative cid-form struct_ops
> type that lets BPF schedulers operate in cid space directly.
> 
> Key pieces:
> 
> - cid space: scx_cid_init() walks nodes * LLCs * cores * threads and packs
>   a dense cid mapping. The mapping can be overridden via
>   scx_bpf_cid_override(). See "Topological CPU IDs" in ext_cid.h for the
>   model.
> 
> - cmask: a base-windowed bitmap over cid space. Kernel and BPF helpers with
>   identical semantics. Used by scx_qmap for per-task affinity and idle-cid
>   tracking; meant to be the substrate for sub-sched cid allocation.
> 
> - bpf_sched_ext_ops_cid: a parallel struct_ops type whose callbacks take
>   cids/cmasks instead of cpus/cpumasks. Kernel translates at the boundary
>   via scx_cpu_arg() / scx_cpu_ret(); the two struct types share offsets up
>   through @priv (verified by BUILD_BUG_ON) so the union view in scx_sched
>   works without function-pointer casts. Sub-sched support is tied to
>   cid-form: validate_ops() rejects cpu-form sub-scheds and cpu-form roots
>   that expose sub_attach / sub_detach.
> 
> - cid-form kfuncs: scx_bpf_kick_cid, scx_bpf_cidperf_{cap,cur,set},
>   scx_bpf_cid_curr, scx_bpf_task_cid, scx_bpf_this_cid,
>   scx_bpf_nr_{cids,online_cids}, scx_bpf_cid_to_cpu, scx_bpf_cpu_to_cid.
>   A cid-form program may not call cpu-only kfuncs (enforced at verifier
>   load via scx_kfunc_context_filter); the reverse is intentionally
>   permissive to ease migration.

So, IIUC scx schedulers attached to bpf_sched_ext_ops_cid can't use the built-in
idle CPU selection kfuncs (ext_idle.c), right?

And that also means sub-sched support => no built-in idle CPU selection. That's
a bit unfortunate... I guess we could implement a similar logic in cid/cmask
space, maybe in BPF.

Thanks,
-Andrea
