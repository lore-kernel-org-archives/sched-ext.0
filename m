Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8252877CD
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694222; cv=fail; b=uozYaUksP5OzoMWUFaMMsQ24ESZG6WYFMxQzgZKA7zfWQEx1Gn7JUaFkY+ETBYoM2583NqBE/gfInSTO5zGBi2ZllYZH7DMdPvmKO2mat9W8LPo730JEcppKtPpT0qBWSuK21+thdjqSskIwG2kVSuoG9kvkyn512ll81m5e8Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694222; c=relaxed/simple;
	bh=3nB5mNhVZU3QCVueHkxj2mZQxct7tVASFLaT/lxjaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EAej8GUGvhoZzU0TrXfq9g8nUy7sZyFsjMsoqvbw3QWtZVoCyze7kXCqvsXIAk1XPZiT/MlVJYhCOp0bReBS69Go+u2Ltcb5x0nDVleC/gzR6DgwoIK9UtBl/lKL0S5jOdkdbUBPIXMriDWjMvarHgLgtMxS5ce2h9Me5HK0Rak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOEdk6UX; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOEdk6UX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du69Ib3qA89aCRe0pPMM92JUO46XVLIb1NqwiuQ8QY4kMgI2MbMaNH460Bbo0uZ7hNSZAdkzqAMpYS1275dFB43qkFIVcY4OpFvhmOpv76V8s129tos7NMxvAJLJGyckYP/BNBQ6oSfb/tPyqdTFjLKMTvQzyA3BiG0zBExnuTVrJyZAZTec6srM7G6SYqBwYA1eoKWMEUrRx1F6PD+1X+fBGKBkGgIWOeVBUHaZgN22+tZVCK+3kShzaiOEzmTHsrnZ4Vxbv3PvWJ2xa+Qpz9NeahueiLH/lVTAu8PYW1y5pQxpBmRsI+UBr/7toDMrAazHpcXp0e3+K1bxxQ2jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x47Zjf3y90ONW1OXTlOa8J7nv9pqeNdNkwMZrzZYqQE=;
 b=OmO9KzSjcWtGEhdi78E5fbFiEucVMNLM2pxregExY1d8ZF640lkVFLk2xodsmkUX0GzxrHbUzkaue+bK9L1KQGjvoUmt6jN47frp760DwjWLBJopgaV85h4xRi//IwmYNa1ge96uig5SsIqKFRLJe1VhuYjoQaI6de3jkVXqRNd+2yN7fHbA67lGe1qP6IhP5fPvptmk6dRQw2Wd9Ce10rOa/8Hc4G/Ml37NSdnSJO37/i3JNgVKTTpMWSmg7TJf0VWglnind5mYERW+pRt6JfUij7tTJIuRroo1l92NgJ18Pk1sFgvlR3zYzxLeXIcHB++GU2FaEDX60/rksOwsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x47Zjf3y90ONW1OXTlOa8J7nv9pqeNdNkwMZrzZYqQE=;
 b=bOEdk6UXGhsiaShkSHIQmi4I4r6Ynnh45ui8hOAOOIsDBx2+aVsDSkc+g9SOKvM6xuK9f41rerBFFt584uhwwzKc8VbokWDqwy++kxWa8f07qYjT0pL6yjGiijJSe+RRH+gWwKK/5J9XOSD+6Ja4YvadQnmDj+RvXNXKVh43vnZaTLckx/yLZhpLjI6xhs0JEp3byArdlW5voVpn0Bmd9oA7xjf0KhTGS8XQnipKziHQmED3p2AxOKj+3lFvP4Mt0IGzPZ7n6CXIm1viKLM1rhKz3OgoirsjgYCprcpYWQj7AagFM8zMFV1Ipps//iUAyjA74Fzn+IrAwFusTo24GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 19:30:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 19:30:12 +0000
Date: Wed, 16 Jul 2025 21:29:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, jake@hillion.co.uk,
	kernel-team@meta.com
Subject: Re: [PATCH v2] sched/ext: Prevent update_locked_rq() calls with NULL
 rq
Message-ID: <aHf9tlDr5FKLLyyX@gpd4>
References: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: f42dd777-6ec0-47a9-0ddc-08ddc49f2ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2AYH56zezcA6MMwGgnpuEiyCLlPG3cBekzvYVxCX06rYio/KDTtck3+aZ5+k?=
 =?us-ascii?Q?U8SuoJzqgtV9GgAlWdbOoOX1Ep6rCdvtIKIl97iHaN/2R+64QgqNOfQQm9ob?=
 =?us-ascii?Q?acAm+2INdkxBh/UsMpVKzhc79l1WWZ+v9Qpg2MwYZ5zzyX7Hc0/rdUomNmi5?=
 =?us-ascii?Q?Lwb0KnztSAGQTxJq2FRQX0iD7LFuqIPBnFDgiQRKyDOA8v/X9c+qQj18TJ4a?=
 =?us-ascii?Q?XtPV0BgFb1OArsa4azIf8wVKbqfzTwsG3t8u2thAl1blbdLwXW0UrtdEBa3Q?=
 =?us-ascii?Q?AGxuhMbt6zQMCndOoPC/+sEGj1O2TLL7ckcPS5dak5F/obHL+8BCTnIyIWHl?=
 =?us-ascii?Q?TUNFAtADPzVwKz4fBIVt9pKsQe776i8Xau1JjlWVKt8qGmNEyb25/Mwf8bMc?=
 =?us-ascii?Q?qGHa3iddbiSz9usL2ZMtgNbbhcvBnXo0kfSd8z0Nr/NradOqnP8/kFluANEB?=
 =?us-ascii?Q?zETOkpYWXcLlkbR5EgvUWFGE9XMIrJ+nLGyMmEmrFIRaj3StlTeqU4AVzFWA?=
 =?us-ascii?Q?Mxe+yHsnGeiXn/wkPUIhPMBw2nMsw1nbI/GZX4iCrLyx6EsX8JLzDyX9AI/P?=
 =?us-ascii?Q?BBHIfuwbAmCzke3TjCWRstiuXtnXJ1oy4v8/aga0yEEbZjK3JU/lXWUMZPQk?=
 =?us-ascii?Q?IyOT+g1L6vMJdVlmxfKnCUUTrvXOJ9kqBj7ErTYK5fc3RrGiWKve9WLjSbra?=
 =?us-ascii?Q?KYWQGj0J4TTXETdbLJyWWQGYjfA83Ulk2lxVDmvYFeS2E7qO6SkcjAap8+sL?=
 =?us-ascii?Q?HfY7e2FFOIQabwopPqQbNovx19fLdVSValFrYyf+XiYP+ZEH5fsfEn1kTuQi?=
 =?us-ascii?Q?mz34KGyNRwl/vjsJ4JWhsX0g4+Q5mYbRu8E3slN3uqYnAyJzaqiLjdDANWMb?=
 =?us-ascii?Q?R2nxYF6oF0vCzI/09N2FpT0T/KIRFsI6wCou4Qj4fzIwp2Yz7Z0FF09/Rk8q?=
 =?us-ascii?Q?F+c53JrKCbxzLiMsKIUonuHx5vdF2A3yoCe3W7t7czwQiOOj//acumeMmsiB?=
 =?us-ascii?Q?CXA7RIRg0m1rqTRmIvNo9j48e7vYcByVWxM+XI6yzotj225415f/zAc5T7Ku?=
 =?us-ascii?Q?Xh4WQU3/QEabNKJO6RBbkWrIAZgHhOCGcAvAVQF4wYrokhFthqpW0enuJWf4?=
 =?us-ascii?Q?MowW7nZw9gEG4cD2uwp41rA3Ce5VpQCxBic0wm8AtJBiHTGmX/Uap5gKQDiu?=
 =?us-ascii?Q?iqiTrbn1LUWiMbWDcip7KtAfwbPIfy8TnV9z763GXYkW2LKND4B3f4O/5jiq?=
 =?us-ascii?Q?Vzfg8h0JhaNy4G3BeUGNBM8js7F9BK9EuLeC31HL5fUhk+2poih7/mLc5W8u?=
 =?us-ascii?Q?b7ygcrnTHsbQi0+TwVROyTDeVYac5mgywW+LxG3hvjaXcQYnyn5OVMG48JVy?=
 =?us-ascii?Q?HgVosLnMdKMjX4kt9TcAo1OwzcSyZbuw4QsNt7DTzSZha5MT0mZV/06AbkOq?=
 =?us-ascii?Q?lT8/2s/X83o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHMtceUT/8IFEvnuW/7kiE5pCbeuqVoCUpYvj7QoxDotBmUjurAdV5AezHpd?=
 =?us-ascii?Q?yBoDYAF4uzDwDFUgGpkuoEPspWiNRatGJVsK5/e1KWxxl6J4K6FaVaZmuHYS?=
 =?us-ascii?Q?EQLBFQ+eynzAkzDj0AAZ4zYfmATVGp5vDmaym/GTJJssXVyND+deLhxsgP15?=
 =?us-ascii?Q?QWS0uYMsqAIr6BFae6PZNE4b/jvBhkGv53c706SR7oD3X26Sz38ifl5T5Fsl?=
 =?us-ascii?Q?dudbucJADwrc/Ds7NH7dsoqhtkr9rDaaq8msXlhtlp50OKJFGOXKhn+gLpjR?=
 =?us-ascii?Q?vjHtzse9i2icMF9CvcAKoGRQh7A8wIeVx2zOvD4wQDYtLW9vRIafFhBuBloE?=
 =?us-ascii?Q?93qyV73PGmSNFcdlWaE0/MbeZV8ln8fnswPXklQQQv2QxSFo3XvCESR8ntJW?=
 =?us-ascii?Q?Sqz1iokAWJziWAewpthn0fMa5L/3Wiof0Q7vMRpbTXytsIrx2g/0kXg7wMaZ?=
 =?us-ascii?Q?ktNG2wIciz02bHI5FBFl2coXJ7VEl2oYdZh0pY9jRWU/Q6DYGqp0BPDPbwAb?=
 =?us-ascii?Q?gaVg5CamoaC5OG23RDV+dP65bD5WDTjmOl8J1H+/n612K1/io3O25rhy1Yru?=
 =?us-ascii?Q?ij43iIgsTYkFnGHU+1tMgO3JhJHFRCUuHRYhza09LMAGrJF13EclT2qc+qcI?=
 =?us-ascii?Q?673J0FTDGIfVdnaWN75tx3PhDSQMk4bNGgW3duK5drHmvEJhOKDQYevQX5Rr?=
 =?us-ascii?Q?Ks1jNjqW5HqwogUVAJKE3cYiIMcYiQaXGxzSlC8/TbcxUOprDVN606LaOdtL?=
 =?us-ascii?Q?7enCU08GYuqDjSuahudZ2DZ0zcI4S+o0IJ2fUpwlIoOjKmPoFlS1bghT7FjH?=
 =?us-ascii?Q?duBn4HfmFMGhzEgzdaJve3ZMJbbG+9H9kRGJjb94lYaObdzyard7XAI416u6?=
 =?us-ascii?Q?PAoULy+Tlo9NxzDTN4qQ0cBBgECSpSez6g5l3zzmgXTU/PjTCQ938QwTrWdr?=
 =?us-ascii?Q?H1XuKr1LomIteCsiLrZBXOSvW+wqxy+ZdrYRT8tQ4ITH+g4kQRXSiI8xYnuE?=
 =?us-ascii?Q?Qoo25VR7WZk7KTZXwJBcU8nJIh9eRdYzdMPYaoDdzEdxAufR3BWe3jkyuloB?=
 =?us-ascii?Q?yq8TNrDu1Q5Ve3JZbtd3ip+3vRVDUX0rB8f/oJvIb4kFrb+Yjsdj1CXpl3GO?=
 =?us-ascii?Q?KDX6IezkiYG49h69PTntqwwMXywg3VFUCGwqQMiXnFGsY5+7pIO5nLkk2fkG?=
 =?us-ascii?Q?YVRUcxqCnPfCTAcnDvYhCxvhqfa19caldjJo+5mX87vJdvXdA54iWZ7O1pim?=
 =?us-ascii?Q?zCG7ud/vUb4dekxqaxnamV04h9+ABS/ToxE9UOIn5tZnu3YrNcYOx7vLoviq?=
 =?us-ascii?Q?JqdWXZpXcu+230SpmU/SaqAhVtktAU5Pll+ZmSWbQBXhQiyfNuoxWPmJNXc9?=
 =?us-ascii?Q?wWThBgIyEJPBu8SF4uKg/G2q4Hho/8p7kJKYCr1JijIFiIfoeYJVQ2JPqIxc?=
 =?us-ascii?Q?Sl1gm3RK+CLEzpYLKfnfTgays78pfHtyi3i6KEGD8LVfOHbtvRyBPyzJAf8B?=
 =?us-ascii?Q?OwAY7pEbiKBrr6cg1D3tk/f/2+THqeAKVt7SHG7wK7ZR6tvOSTV4a5va3+tw?=
 =?us-ascii?Q?eYMsQG5TxF3oHlFfFjFDRtK2z9FiYe83O0GG1pfb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42dd777-6ec0-47a9-0ddc-08ddc49f2ead
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:30:12.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuMIpiNbhnr18aGoCrBXqmtECMr8zegAigUqNC+UvC8+TQVcASGTR3cQHaBD/cKd4x90Y8HPhB5K+TWcm42kEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

On Wed, Jul 16, 2025 at 10:38:48AM -0700, Breno Leitao wrote:
> Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
> in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Maybe it'd be useful to clarify that rq == NULL indicates a callback
invoked from an unlocked context. In that case, we don't need to store any
rq, since the default is already NULL (unlocked), and we can avoid
unnecessary updates.

With something like that:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Previously, calling update_locked_rq(NULL) with preemption enabled could
> trigger the following warning:
> 
>     BUG: using __this_cpu_write() in preemptible [00000000]
> 
> This happens because __this_cpu_write() is unsafe to use in preemptible
> context.
> 
> Ensure that update_locked_rq() is only called when rq is non-NULL,
> preventing calling __this_cpu_write() on preemptible context.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Avoid calling update_locked_rq() completely on preemptible mode (Peter Zijlstra)
> - Link to v1: https://lore.kernel.org/r/20250716-scx_warning-v1-1-0e814f78eb8c@debian.org
> ---
>  kernel/sched/ext.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d867ba210..7dd5cbcb7a069 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1272,7 +1272,8 @@ static inline struct rq *scx_locked_rq(void)
>  
>  #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
>  do {										\
> -	update_locked_rq(rq);							\
> +	if (rq)									\
> +		update_locked_rq(rq);						\
>  	if (mask) {								\
>  		scx_kf_allow(mask);						\
>  		(sch)->ops.op(args);						\
> @@ -1280,14 +1281,16 @@ do {										\
>  	} else {								\
>  		(sch)->ops.op(args);						\
>  	}									\
> -	update_locked_rq(NULL);							\
> +	if (rq)									\
> +		update_locked_rq(NULL);						\
>  } while (0)
>  
>  #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
>  ({										\
>  	__typeof__((sch)->ops.op(args)) __ret;					\
>  										\
> -	update_locked_rq(rq);							\
> +	if (rq)									\
> +		update_locked_rq(rq);						\
>  	if (mask) {								\
>  		scx_kf_allow(mask);						\
>  		__ret = (sch)->ops.op(args);					\
> @@ -1295,7 +1298,8 @@ do {										\
>  	} else {								\
>  		__ret = (sch)->ops.op(args);					\
>  	}									\
> -	update_locked_rq(NULL);							\
> +	if (rq)									\
> +		update_locked_rq(NULL);						\
>  	__ret;									\
>  })
>  
> 
> ---
> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
> change-id: 20250716-scx_warning-5143cf17f806
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
