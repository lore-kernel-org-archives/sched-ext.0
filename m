Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770F359A89
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477370; cv=fail; b=DenCb9eFaR1rehio8EdHKtgJoXKTCvYWA/jUKRsJNJvrtHP04Yss6FOGX6PCGIzxnXlrGrgzn3evV4HUInA/8ZDapE7v7Ki2XaO5eLM63XjDQ8kDjircB2JEM+dPmSlm9v40TyElrGxuwEXQmq9rDVfMX3XencGlJmc3vpFV3TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477370; c=relaxed/simple;
	bh=z+ISzAlCe71nqBLEtCSKvqWLFpwAD1ZAV8fuMUeTZrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXrzppxBmVwQ+sVCzHzw0XNS21T9nHiKfGMyhGLb/NXcuAgEs2SCl+WSRBPQ32T0EyswXtHuxIg/F/VmTPkjskfJhfG4KczNpTMdJjMfjD7uMPm0pBCAjTxclNBc7+VqrAteuORhvBPwsR7xzdvvgHcsFkJO1jeOk9pKrQFeIgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDgCgkHe; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDgCgkHe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akRu11AQUrUo0it17sB2GIMOTpAYm+9+2pvtvGkK5lhsI7zHxn/tf11siF2Iq7a8wTw13x/8aKBXBkc1iDTMTsJIVIjXKSp0aKIo7aCYRF5fr+A6qtj/9V+ZBaNW8IvrE/kuZ8PMu8zSANDa0y4wIddXoswubyufjZNNcvZsS10VnvARAQmoKTUrkCSLwZ6fqOhHCbaELIsN1BSd6hAirmtuEV434fTEt5FbLYV2GufWmxvYPXI80UzygqjHQNPUuwRFDKR9VXX0vnVtXNjQwM1caOGSE7U3LwLCvh2+UJh7ei+gPd5iyV9Ir3Lgk6UOqS53JNAmMcSd6xbfbBPqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ShoCwCBBe7csTSWd03nvxU7MoV6DUuKYp7hauasFyI=;
 b=Gnz/CXKjFZmN/RBbNzivnNl8AqzczPRMy8dLN31bMdB/jrqYWlSp+FVMbp9v0KO4CF6JEd1mnLsjLU3XDRhNoQZHhL4rUTlCjc8rKvHxxgAF+otd9Gl/WH8liqUNuFe0r58+7qJl5Hym8CN+NfZGCG3rJp9i8aK0hqp6579JaHJI84Y1AB1xHAlW54Y4ghaq9uDuUnhhqPhSJcgnvnJhScxNFOI/R3Ou1ub8NHDNDdd4MJhkxW++SU9bfnO3hbK+JVtPhdy8RJdGJ2haB7/gMFaarPc2fXgWBh4mK49nhze5GVPgNrvU97NV5ZsGup3bGgmZaMl6CEMsrNKIIV1JSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ShoCwCBBe7csTSWd03nvxU7MoV6DUuKYp7hauasFyI=;
 b=tDgCgkHeyCVnvkRWuuvPu/k2DoQdfGeE3B28Tw5knuZhG0FvmmVrEULWx7AtdavMU+PW/KgMAYHgcYopjIzj8Cs+0f6FXN3z1apj9AERoIe8uYZbuFRjlCQARsp9OqLdGt8KMbEaostH8wGYgHUefylf7TtyKv17mliDw99vjF+vr6udswzbW08qBgKd6M7DTL5+g4ycsk+DhlDi1geFVe7Hm9Si/CSWR2v6Pyicg3Z3V78IdPkJm/fSoKKchWpsniSlnkF7bD4iNt7fZ9RCJv3PFMLaRWMCwHohdXGbXXXlb1BY6a8fSvuccYtXRfJ6ke3iBn41M87O81JLy2ow7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 22:22:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 22:22:42 +0000
Date: Wed, 25 Mar 2026 23:22:35 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: honor built-in idle disablement in node
 kfuncs
Message-ID: <acRgKzZodHT2Xn1n@gpd4>
References: <20260324194235.942952-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324194235.942952-1-joseph.salisbury@oracle.com>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 812b6450-2c0f-4793-b5fc-08de8abd085a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SC2hCQdzycBpbOsG9WFvv8hq8kg+kYgQiWRcLsIepQUB52tTgnpFVKizxHhya5XBU9zOHJMUtLpgQOof7POYCq46PR0uaeT3MP2jQ89gJBtandAXtFC/qhSL1lk94EaF1T81jKZh2nlEJhFIWo09wM3a+m7MqUQtnRDgCPZ9liJIgI0ni9N6nwnCvuU/0C+5YeBoYlyn3JiFDk5UJmLpEKBURG+NDvvae8GkPqqSg4E92f6bVscRgHJzEqYiVgPb2p9y1tmHDRu2T7LnJMoOpKyKtlHC7ZNe5NYmznAvD2miX848et3xrzdyZDumoSjXwCrd05d+3s0ILKpyvSsMIYbBs4XN6QDcrINdZjFjaHR/c8YY/hod5I6PEGUbvwUCOEIvQrmPZBidWDFbV6Y+PHcBEWkR0KoyPAPRoq4nXQB4tbKvHdG3NaXrG6hCx9F75fyhZJGk2ENHw2mpE3TdbXYGfg+8zKtvhIGE1KtVZxpK3pf2HUALRwaep5LiIC/pAt0NomEKRjA/YMdVgpj+cJRAGzTmG1E81TBU4NJztCaY9AI7P6Q4xKup4iwxrxUn7BUj70HtE0+zY910Fx6ig0yeDOUWwZC5GTQV1veRjyOAD1HzDw4pVnu0GuiqvWxpZ2gTONzrvNwrS1/rKPiJHsaVm69qlk0YmrFzdIgXDL5IWGpGSyG6R3hcZIG6noP+04CHSjaxKZh2IcUgnbhYvypWfOSj9tNQMTsAFL+WMpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rynBOIv1ATeqESvru9iYoU0EmAWl/NKvR+MHcUePC8zjynTp6bdUYnZC/SgQ?=
 =?us-ascii?Q?/bkQRsgbfudTBo5QTFGGl540O7iTwIp9F4mCmnSYz81/7RJEiRA1dvrQkv7T?=
 =?us-ascii?Q?20vhnJg+6l+0z2/40L1E5XaapiVI4kc2YfEcfHrqbwULZ9nwGhUtzmE65tDx?=
 =?us-ascii?Q?eno1eOjgmY7yIHZNlyWQCAxk1ul6h8AAZhQZ8nnu81cO2rOvkxEs5HBQTPdQ?=
 =?us-ascii?Q?gc8wi88+9xDOmc8Cs9c86I50SbJSFbkE4JaLBaBs6KBLaeIxRE3f/siOs8Lf?=
 =?us-ascii?Q?qqNcbuYHrOdZjHo21x6jGjtVBc6h4tdR98AT+uE+5xGCl0zlI1/o3SA8cAIW?=
 =?us-ascii?Q?d/40UXzHj5aFZ7yKwTXWRHyoAEAaIrmVzDjaBJTcX1+MzGre9gPkx3xEETYZ?=
 =?us-ascii?Q?zmghUfeOxG8+y6LeNJ1GU+N2b+CmsvFzhtNY6UO3LovI35ZNWU147W7aNVLp?=
 =?us-ascii?Q?Gbl0N4UL6CQ+KjA7oDnt/pZ7kSyar2h4S50TDfiyLkV7BoCcjnEVU55zFBMO?=
 =?us-ascii?Q?WSYDAkwYoqHziy0wCR9wpl44cUvFxofVE/RwUZgBoBTrTwSkNwmhMIVrOvJX?=
 =?us-ascii?Q?q8ssx5mqEUESEulHuHJB3LUzQpRYd4DGmy8fZygdRP58hDt3pAJXudtYBRzE?=
 =?us-ascii?Q?d928svWXJxdpMTmxuGUauAx3CP1XCWrTLzcknwGRurvSoccZFdMISL3HY7oU?=
 =?us-ascii?Q?5JuaZXo3+Xv4HHmB4MQEhflWyOk7oEEEytb8U2XVUFM86mhmosRJUF3udbe1?=
 =?us-ascii?Q?iqi2Weq2/OieR6Ltqic31dkPKYDpm5qdSQ0ko8IU3cVOJlIO/JuH2Aigyhdk?=
 =?us-ascii?Q?f/nveSdmCFlNGzUlte/kcQzBW6MG/bWJBY5MdRjAbY+258ma/p/IBvPJU8Cb?=
 =?us-ascii?Q?sacIiP0DtrX1nOV5hWmu0VOu2fnHxxS3KhNG+KRnEC8VfohpD2OVEcMOIG8x?=
 =?us-ascii?Q?U1wCJC7H+389EiTSOj5iDKTedOR7XemleAVycYofUMrwwvx8AskJ0oZni5eQ?=
 =?us-ascii?Q?qmmfDSXw+JfCKz2HrtR8Fdn2qS9vWw0oaSTO/ILYHTGTzWPzi9DZigA08u5i?=
 =?us-ascii?Q?6So4dSQzBMUYwDYGOtees/20cKZjEQqbAg8TPRY5CHxhYhSS0CJvTS6tyw0V?=
 =?us-ascii?Q?VBzlu6YJ8LF1orKh4fm4ClSTN89fMhSS7XjVpGxNatuCEy1V1EnVMpNOBke1?=
 =?us-ascii?Q?L9S6cQRa98qk7fNoPtiy1dQI2zQkp++YhWa9GYCx1DstmbeZ1vBGk1kco4eb?=
 =?us-ascii?Q?qNDkH/dknDqyM/RFry6KJxkQuxW2NPugYHiPjvHO15zIA/bHfKPh2JKSCP7p?=
 =?us-ascii?Q?xF+ZP4AEV/tpXGe1nvE5/ZXpPhhAfRRx1BdToFLJA1kgm4R3+AaJ9ZCCWEWp?=
 =?us-ascii?Q?YfdLITNZa5PHZCbH5SRnlloaCDkoidiyWjMzZVt/24w+IWyoxNEAkHfJB1pE?=
 =?us-ascii?Q?oOXfoh6YexIOPAihxCCz75Xd23676507TpxhsRDrRRpMnGn6x6MNPex3F6Ya?=
 =?us-ascii?Q?b66wtGiXLFDfLSBzdHSsqWkDowThQT/qLpJ9BI1C1id9UoWd9SX1MLDmTf8w?=
 =?us-ascii?Q?Dm2EM5enokX9LoAo/vusxSS/b5yA0Rik/GkNQrnXWK15dhfgEbrXZavx5b4N?=
 =?us-ascii?Q?J68OuCR+v2fhPf3cwkmLnz3lqUCVvvfnH0QJ/0EdQkfYfRq7wpJn394hFHND?=
 =?us-ascii?Q?lP6Y8qEyazw+cEhlYgBuasEHATLZsyDn5Lo17tzxx9VyGQyjwO5EropjaAAb?=
 =?us-ascii?Q?TzRVtonhzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812b6450-2c0f-4793-b5fc-08de8abd085a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 22:22:42.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cyq624AX5U4Qlij9hDKqbfsl5llHURkSLGx9khQ0aWM8vBiNqzPXVwBKzAT+ozNx4A3g1sUVuQwcfoXrdBVKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572

Hi Joe,

On Tue, Mar 24, 2026 at 03:42:35PM -0400, Joseph Salisbury wrote:
> The node-aware idle kfunc helpers validate per-node idle tracking, but they
> don't check whether built-in idle tracking itself is enabled.
> 
> As a result, when ops.update_idle() disables built-in idle tracking, the
> node helpers can still read per-node idle masks and attempt idle CPU
> selection.  This violates the documented behavior and can expose stale
> idle state to BPF schedulers.
> 
> Fix this by checking check_builtin_idle_enabled() in the node mask getters
> and in scx_bpf_pick_idle_cpu_node(), matching the behavior of the non-node
> helpers.
> 
> scx_bpf_pick_any_cpu_node() is different by: when built-in idle
> tracking is disabled, it should skip idle selection and fall back directly
> to the any-CPU path.  Make it do so and match scx_bpf_pick_any_cpu().
> 
> Fixes: 01059219b0cf ("sched_ext: idle: Introduce node-aware idle cpu kfunc helpers")
> Cc: stable@vger.kernel.org # v6.15+
> Assisted-by: Codex:GPT-5
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>

We are already validating this at load time, see validate_ops():
...
       /*
         * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
         * selection policy to be enabled.
         */
        if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
            (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
                scx_error(sch, "SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
                return -EINVAL;
        }
...

In practice you can't have SCX_OPS_BUILTIN_IDLE_PER_NODE set without
built-in idle enabled if a scheduler is running and we are checking for
SCX_OPS_BUILTIN_IDLE_PER_NODE in validate_node(). So I think these extra
checks are not needed.

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index ba298ac3ce6c..948f6b4f8ab5 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -1082,6 +1082,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  	if (node < 0)
>  		return cpu_none_mask;
>  
> +	if (!check_builtin_idle_enabled(sch))
> +		return cpu_none_mask;
> +
>  	return idle_cpumask(node)->cpu;
>  }
>  
> @@ -1137,6 +1140,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  	if (node < 0)
>  		return cpu_none_mask;
>  
> +	if (!check_builtin_idle_enabled(sch))
> +		return cpu_none_mask;
> +
>  	if (sched_smt_active())
>  		return idle_cpumask(node)->smt;
>  	else
> @@ -1253,6 +1259,9 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
>  	if (node < 0)
>  		return node;
>  
> +	if (!check_builtin_idle_enabled(sch))
> +		return -EBUSY;
> +
>  	return scx_pick_idle_cpu(cpus_allowed, node, flags);
>  }
>  
> @@ -1337,9 +1346,11 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
>  	if (node < 0)
>  		return node;
>  
> -	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
> -	if (cpu >= 0)
> -		return cpu;
> +	if (static_branch_likely(&scx_builtin_idle_enabled)) {
> +		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
> +		if (cpu >= 0)
> +			return cpu;
> +	}
>  
>  	if (flags & SCX_PICK_IDLE_IN_NODE)
>  		cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
> -- 
> 2.47.3
> 
