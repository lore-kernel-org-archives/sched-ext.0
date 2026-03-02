Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1454774
	for <sched-ext@lists.linux.dev>; Mon,  2 Mar 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437649; cv=fail; b=tGF2HKfGyVF2vZYDUjt9MWmQQDXeba6VQp+0MdQ4W3cwVchFfE4RHs3Oe/zYfQZ5QbIKqaU9peO0/qVzFD0ADRCtZBtL3EFFj3EvSCfJTST7Elt1/dczvCqtgQI3+L1Qnablxw5RnMx51WHHdV79/q+mrQ67pn1+WhBO9ESLktc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437649; c=relaxed/simple;
	bh=nK5U1UpXwtOT1cCDhT4VL9w+rkdmZk/5v6BzJoRPGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afApwbJF28nMKvkXNT9+A5R73cwe+pEoLrlySdXWLrEy1Opn0h67quNOm20J0iGBspOpFUr9Q/YsvfSFkuCwvvWpkF1skFztRhJthhAXadyUiNpSTeWBOhGVWkwZ5KAqSJdMSvyM+E5e7OX3HAExZqyorWVqgBvhIDIQImjppiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBBn4zHu; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBBn4zHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn4nx8cYXQw3gkk4077JXTaapjP3IzR0y3sLFmVUusiNQGlMA6cgaVfhrqXCtrD01X/G6wI/ZJKYovYCnTTO6QruetEbmIivGpoDXdpemL4Duf3EWQsD2c9uaSd9pq68AUP9OAGO/ox8xdog7hnXvUIfBU2zSjmHGGPrZ567vnqdWagEkoYHhpM0J4XzYL7gB+jLWB+rSsI5rKYyzEhHK2lx14neOsM3innHbjb6adaZMAqm4wd3i/xvQt1HVuogeZaXcVs51rDg08A0JHtWobleqsZDR8c/XxtheXIHllkI8ILgHddLJ5KZMJyLy/psUzNOdJhqE5WQYhQSMIaEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg6iXXm7QNUdyCETDNrV+4socV5Thyz28qCj7ycmLJ4=;
 b=G5mOpCRMFW5S3pMVhxvIfUpAhMAp7/eZX54A4Zk/BLxDaW1j7t+PH6zVBX2p/FuKkhPTmZp4M26qbR3Jc0+5pIXIgflhx6VQXZZxOcvxZKRBa32f8NYJ3LVXouUWGZBcBRss5cDX2okHib0Ca4egGKIzs9P5FXfbWn5fY/mSm/5hOwL4Jn/RTE/cti06NI/0ahpk0mccFTOxJgLOOiyP+fUh1Jc7yswSRfrbh9G1duzpFP2OWt2mK/T3COLRzwEyiDDO0sOZT6T0+xK13d4adFvmqENUW+liLZja95RF/xGhuC+pcePnOPMezc1vj0ZFskU2tahCsnidqrhST/Zk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg6iXXm7QNUdyCETDNrV+4socV5Thyz28qCj7ycmLJ4=;
 b=dBBn4zHug5I4A1ZWTxGAL1hWI+A/Cz/2kjdWUO2NY0x1h9i/uXHBkF8kj/erLOiju1qwpbAvwJVwE/WYzb+7KeR0h+CVO64H/2cEyiCVDls7GjAD4nPfWx7kOaRQQxq4g3NmUKAE/eRbq+xBcErnyjwhFIe9RGsdoQUgZUOfB65g7Q6zcJ6TA7/TRRMe+JIOKJLTuoJ2mgaCGZlYnKiY9R5Eszj5GLi5nHL/RmGXqzLterW6W5g7A1IYp1N9ftUDiROAV5czHZ/DCDTTnnQoQL1sK+Hzhpm2Nnt9UJqmGkRLutZHaOUshF5THMG6SGvd/n9NSn0niZvErUs8KLij7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 07:47:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 07:47:24 +0000
Date: Mon, 2 Mar 2026 08:47:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	shuah@kernel.org, sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sched_ext: Fix the incorrect logic validation
Message-ID: <aaVAhdw3ZO5kHJ32@gpd4>
References: <20260302064851.370327-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302064851.370327-1-yangfeng59949@163.com>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 655601d6-43f7-4c16-9d05-08de782ff15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	g6KiT49EiY0bvv+MJUpFM67z9Ww9kxwEVwt1PqmC0ZpReqdis+eqxqrqsw5N+5hc7YldFAtFLIYW2CjaMrW74LuuQudydULOgDa0uET+1TBCuxldNrHSmZQ+a8aG0/VoQDGmk4Dl/ZTo2Ue9wLfNaqlZyf/Gktg5w4ZfSfwm8c0dz4WlZAbvkbi1SXOAUMD3ZRdr+TfOUlAiIhoGT2KNU0HR8sA4Cjfh2QIkgwUKBUbB0QZ/j9xh0eYLqET8LhlMhnlUbR4YgqIxwCGt8JxiSrdurfcdiOT9e1y2aQjCIW+WkbtsykBzweSRKlDOIDATxsKFluPpexme0s1Nxep/zqzb/MQzaLcQ0F29Z30/2nhD0ODa7EkWsgTVs3iEurl63w5WNYZMSgMUnM9m9WdNAEih2fZEqsDGt85FWKoF30lFZmGn9UHxENr7XmgurR0wL8rh0Pmr3v1Q6oWaVuigKChwH+O96SmVpHXxLqO+fzl2FREKBHOxdOXKWQdDtfU/bZ8MVBxJVEwCCiUtd8+Jgq7f/+OLQEodY5cCLXO8tCPNSmyfWedcVZSnYFfhqN0EKe6X26fRuO9lswyqFPjcDBXnwEZ/IKZqYRVxyW5yzg2jFhKEX1G6qTS7VCy2AWVSCiTHbw6fJQTwLOq9Pu5AuBilOkOnRnDB1F6mVU3FLv0TV59X95aXCSlJ5PjQJ+z4/b0pW6sLiPvXnwmuto4R3chljTqbcNkvPOu8kcpCaWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7yp0J8sZvSlJn0IPzEnwjDrmy3HMCcmHZbOmOtGQYLVdzMEBdnAFXq2BW6K?=
 =?us-ascii?Q?kTA0ktj6WcI6FGFuENjDH1ZOYogFXkN3OW9WeItJWqluD4z9mfzpbEZ5Z2rj?=
 =?us-ascii?Q?tCJQzqYQ6jQjGKZXi9mJPxWyYEy8j4QrtYeo5JAOKGdCorgAilmi6OJls14o?=
 =?us-ascii?Q?shmycXKKBBaEu9o0SawKATFrWnXf0YCi84AoVncYZaK+b3i3IYrGxT1TduRk?=
 =?us-ascii?Q?YtLz50IMAviXi1JqPaHi9Xp6npTuSjg3JogZyC/X1/lCpuAkr4WuoZbTJfoe?=
 =?us-ascii?Q?64IVYdj0o9e4P6uMJvq6N3Z3pC3wMw8BFKqZrxOMkDXDv3pbfgSY7xoxyHq2?=
 =?us-ascii?Q?Y9EEIUlW35QZjclb658cVKt3VS0IjZnKc1QLJUj9xA5YRTLznQF7J46JNIeO?=
 =?us-ascii?Q?nBQn3DDjZ7Q4ONgRuzoudr+cX19ZYLpygiil1clanY7AcUxtvu1UhDpSWGKI?=
 =?us-ascii?Q?nNHkRv9pGXXDhG2/MhhLIMsG5jGlVePj1k3TqBjMStJwyiQbCpx8P8FLlKnK?=
 =?us-ascii?Q?ciC57imrCXiMeGvd/yBFRVruQg2sRr7f8FqJ4PvJ8ExUxox8h2VwI7z5On2E?=
 =?us-ascii?Q?6eFM2T/a3zgEbcR7/DJ66eQ5QuqJjJJtbkrdqxLM1XBekrcsth+9R2cmu/8O?=
 =?us-ascii?Q?hnS6/EVK18+g7OoqtxSgSp9ml9/yRJkUGjjJL0llckydyTG7jDKZF5w8yf5e?=
 =?us-ascii?Q?vQEmPGf5IvLl9piwGooM3xZnkZSpuq63p8GBf1FkKeAwN4kuW0s3Iuro9LQ2?=
 =?us-ascii?Q?UpkazlJyBeqgHgaoeJkBukKl2noINe3Cnjx7rJVlGh4facNhbj89GrPlrBzS?=
 =?us-ascii?Q?QmHxpK9tbX+bJ+JXefnwd8OaLLmXkky+H+i9Is2VyovAkKz/57xCvpbPzVqy?=
 =?us-ascii?Q?KKg2C6hjVp6bE2A460/3HEksJfsc/L8tNeAx1qEBol6VwS4RnHBp/sl7VgHx?=
 =?us-ascii?Q?CceszHUNWbSeb5D1N3eJQZfJaDswD9RnsOy8Tt5RN2CYrxtnVqXPV5wQFpr5?=
 =?us-ascii?Q?iWWESQBSkkcoP6NMmpDFEuA4kkGI++y9p9TqPBrRt5Jg9MkMue9TwqchuJmx?=
 =?us-ascii?Q?i+sELb3aHbfmQjv/4m7zCU8ahAkx7Pu81Kkwg9fYdAs2O/6r5+peXdP5znrq?=
 =?us-ascii?Q?VVfZWY70mQDxL1qsShioiaPjaCHMXg4clGbl8L+kgNn4BDVRgvB99v4EW18X?=
 =?us-ascii?Q?Dwn1+yAhJqzhXGKw/+w1Bt+xBwktYeVBXsUgIUujx1gpDehZzhDqjfy4j3Lf?=
 =?us-ascii?Q?KUvUIqqDV5vNPBjva4vKRnKGdLGZjaNoo9g/i9BRcapyjhGda+VVwEB1bDhF?=
 =?us-ascii?Q?lcmgCRt9sFvmVHwM70ZUV+LNl8Qb3zzdqS3+c8UhAnJxqREuu8+S6DIimSYV?=
 =?us-ascii?Q?6ef9kUh3kCnvreP9K+I90/ty8A21zLvYINvXVvynqoI4vtOKIGofK//bkkHM?=
 =?us-ascii?Q?Xxw2arsM5dhSuwneShNk4KPFe5Qo28wxxaXB2+CtUXbWUMqZOTSfM1VUR4uN?=
 =?us-ascii?Q?XNufYyin0MrUU1pGnl36ClIetImxGR1Q6n8Et0GU+dQT+xcR3s+Cd0KQn1Z1?=
 =?us-ascii?Q?bq/UPuJhcHbvpstJkwYhbWQ7Txkqteq8HfMvGif6dq6NZWDdrCEPSQQ7mJu0?=
 =?us-ascii?Q?51pk91QsHaOvjB1MEKR1f4D2vpr4OAhDFDDkJpoTVbvHrY+9T31dWnktkilU?=
 =?us-ascii?Q?fvbHrgEoPw4fb5/Eokgy8knMLoCHxihCa5mqFPEPs6ubII5v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655601d6-43f7-4c16-9d05-08de782ff15f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:47:24.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGYuBYKjVEsKfLUxMLn4bVrpG84QarnohvioRDIJ84/R7s3v0J5jmvu4xHmvaF0Ww1OyBizY/LvTTYS+vxNaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

On Mon, Mar 02, 2026 at 02:48:51PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> When __COMPAT_scx_bpf_pick_idle_cpu_node selects an idle CPU,
> it reports that the CPU should be marked as busy.
> 
> Fixes: 5ae5161820e5 ("selftests/sched_ext: Add NUMA-aware scheduler test")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/sched_ext/numa.bpf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
> index a79d86ed54a1..98423628b05c 100644
> --- a/tools/testing/selftests/sched_ext/numa.bpf.c
> +++ b/tools/testing/selftests/sched_ext/numa.bpf.c
> @@ -44,12 +44,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
>  	 */
>  	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
>  					__COMPAT_SCX_PICK_IDLE_IN_NODE);
> -	if (cpu < 0)
> +	if (cpu < 0) {
>  		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
>  						__COMPAT_SCX_PICK_IDLE_IN_NODE);
> -
> -	if (is_cpu_idle(cpu, node))
> -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> +		if (is_cpu_idle(cpu, node))
> +			scx_bpf_error("CPU %d should be marked as busy", cpu);
> +	}

No, this is not correct. The CPU returned by scx_bpf_pick_idle_cpu_node()
should be marked as busy at this point (bit is set in the idle cpumask),
essentially it has been reserved/allocated by the caller.

Maybe we can add a comment if we think it's not clear enough, but the
original code looks correct.

>  
>  	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
>  		scx_bpf_error("CPU %d should be in node %d", cpu, node);
> -- 
> 2.43.0
> 

Thanks,
-Andrea
