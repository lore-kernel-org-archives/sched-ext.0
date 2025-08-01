Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AC1B95B
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059879; cv=fail; b=oZiNUdwI77wO3BZQ8KYDtrfQOAy5ZpDA7nbPJhgCLs6RK/47yMKYbfJZotMmVVcWq0NGgQk55vWigfEsaDt/4jRzkW8GhNtmeQ8iOFeMkLU5s7VpekYvXhbXOVMd5fNEcBGa8OBjuFypuO2tgv0ccLLdX7tfy38j4fn6IJQUWb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059879; c=relaxed/simple;
	bh=0u5WWsuG93aGKlOMYt+utWPVcpr3rxGtWrqu7wpbQMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heKlcpJB9l4TYC1VKwsYjMjkHvTS003NmtwSMPBfNwsNNTMi5CRivL2WMy8w2QsaTeXv1Z054FhYHTLSWCsicWcRUiip12kko026dETe/pON0SRDuXMnm8rawGzYFRImkrm2PLWAqji7PFeQX39WomrGoolDJtXAWV1nDQCu+Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KaUo1f49; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaUo1f49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht/NZjzoOJdukJjrjgj5aZ/h4HM6QjpthASsNVlVRZU71H2zgXXVSLZqxjYCOgtmorDkhHLdVwi1RtELfIl+ny45ILLQ8h091vYI2TwwV6bPx0D9l10HfDCnv8PegDVGS1BKCIPDThK3CB35vRQaRDEYh9Tmp6X0qz7bxFrrR9XNXi2f11zw0ErXbrouSsJVCeVXcpxvvElkhChpAKrBbYW8M5/aNybD3DPmV92hOOu6Ov4DfM1KV2IaxMnouMTvL5KgaV/DIJ2jtgkUIG0fJuixrZ1kjkkNGJI+rPWmel5+W6udOWQsU2dzVki03ZS4lUy1xiwhpKRRZ8mbZZqnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8N0e3yMjLmqFwUlpWAKDQi1Q17EOIfaDEI9vJortv4=;
 b=TEcSxEu37jOJDglhGtWYWS8W0Z8yEIvkRyGQjRWOZjmm2zx/b/+zrsE8zarAtEZgv/FD/+l48OdFfBQU77rigG1dkWNh13EECq8p7ZpRa94TLNgp/aIYcDt0rHp6z5+3nZ/BASzaK94k8miCFRePISzxmzo4/5sH3XB7Xoriy71QI4ffGTX+R4KdEbX8dbqKUxbMNtqrK35MGD61Hn3Ly34doQHnzmLGNqFt6SPLmvZPE5wN8IY7ificVqy9D5dxsmBq7oIrCA0HFAay3dMnzZIZ9bBbqTbLRca7U7OxPF+FMQzVAcbBvDTyuCzKwSvZAfvJN4UgzUw4wa1YjFBy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8N0e3yMjLmqFwUlpWAKDQi1Q17EOIfaDEI9vJortv4=;
 b=KaUo1f49iNCBGhrS/npC7P1P7ycVsHp3xYPeJ9+KaZtzwuoy1zR6eLN6Vxhc+Rc4Dze/7UnPZ8txLWzPeKPr/v7jGnHlwAnYM6JAGa4GjNrKWJgfSnbqHJbEOEUBA+eB2wA6FKzI8pL2x09NE/LlQOIhxn1miklQhtddRmOJVToChR/oZJ0IldJDfp5H8kz6dcgpAiWSOco2ceUr7QmKzJRGMm6dXShmuklA7kN74Y/yhfflqvsR8whu/Uzir4UuOZnxRJchOiRGz4QCDYmqGtEYrbSMj9F3Lv9ObQ8fnLucdeSKqZM4KsIvAXf/YiOVJPNmo63ZHp0QgOgXv8SDUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 14:51:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:51:15 +0000
Date: Fri, 1 Aug 2025 16:51:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
	void@manifault.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aIzUX4d0KRXI4E8O@gpd4>
References: <20250801141741.355059-1-christian.loehle@arm.com>
 <20250801141741.355059-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801141741.355059-4-christian.loehle@arm.com>
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: ea761f2a-6475-4af1-4fbc-08ddd10add55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mz5si19zET+ZlSiuUuewxOML6ilIQHFGOPU/HcHebK2uFNmjPopoaDYGa4L0?=
 =?us-ascii?Q?Wmt8uwBTSeQCP1LoboHYk14BOlRDOjQ9smMWVfsfPryDX1g4o4IVIsvip7SF?=
 =?us-ascii?Q?AqYQU50KtV9FcqV6fvGuOHUqZAtbRYBlWCEG4NscpcrMUjUFMHCwpRG4yD1G?=
 =?us-ascii?Q?lP0AXURoVowbCAZlLAQomF+uLoC3fKZk1iH2RPwyM1PousfF9SDR3Y8NR1ed?=
 =?us-ascii?Q?s0NFuqZB8Kgw8ZpewOxSYbg8MqehBUs/r4kUBftHLEDgPHoP0YVJDPE2M0kT?=
 =?us-ascii?Q?XaPrB4dGoLyVFy9mo6cIVPju8UDHPjdWlKjcZteRYa8wAQNnDedtiXZXl7Fc?=
 =?us-ascii?Q?6j1BKyhSVTAcKa1izsllb5ZO3ssu1FBuF0Ca94ca2DqrjN9Qbol9wvm5K3JH?=
 =?us-ascii?Q?rzgIiP9AY3h6XBBbI9lyYgBLDSEkmbmMWI8mfTJ8tlqxn4FHIgzmYY4b/wSn?=
 =?us-ascii?Q?KRv3H4xIVkz2EM4xuvbMkOXZgM/9hzg64H1uI94TFfm7WsAh1Pko+PaAu7Sm?=
 =?us-ascii?Q?y8FMuuih+Zvu+Y3igu4e0Ti6euXBuXDzSQiTO2pv2iaGakk0Hjt89O3zwbBa?=
 =?us-ascii?Q?JsIQEyNx/lbhsSBHhiBvSOQbOxI7PsLo2bWTaww9npWwKl/+5Chz7BXhkHN1?=
 =?us-ascii?Q?hk5GXqwtObiNCiy99d7NCSKi7AscOh7J6JGKuiTQLVwhtrcUeegbYfjGmh7a?=
 =?us-ascii?Q?T73If4WBUk34RJICc0vD1SBRKDsB1jBgZRTZO3VqGgNAzPYtp08nCeKVMmw1?=
 =?us-ascii?Q?EJyEKPKN8Bc8MXt7QJ28k428PtU+hAbthxM4TgvcGcasT5Muv/U+7XE+B04L?=
 =?us-ascii?Q?/sCXGDzM/kIoEttwAom7vbLHjfXy9ElgG4ECJ+jmxbdR9BRuqQ/JbxH8zNdh?=
 =?us-ascii?Q?HeRcbH8qblEWFzUMticiqaXHpTZjWjxMwHtCepbh2pOh2tNnk/sFmD7r6q9q?=
 =?us-ascii?Q?gvL3W71g174kaPQsuBseEX2LYU7KH9hfJajCk//6z1SVBMrJDfVL8CeIGhma?=
 =?us-ascii?Q?v2j/jc2Qul80gNFDo+niS62pghes3VGuiU03mU1V/27OOTX/LvN2UnaigyhE?=
 =?us-ascii?Q?8EUWuPkyc9mw4bfEOYF02PXNmEfC22BZrKWHJM7ZqrZLiUi6Qx4CWCofoOoj?=
 =?us-ascii?Q?cBvFIvI3GP32YpBwhPCCPGJul2psgumyIY7VqrIJ6661T7Wu+AADfnbnn301?=
 =?us-ascii?Q?PHWO3n5LvOmHJXwIs4dORAy5rvZm0wgda6FSkKOw7e4nhf8uCfv1Xpuxc9n7?=
 =?us-ascii?Q?/UryQCcMPRbSN9ZEH7Jy3pMGqbLFo6lcM3ZNGHvG+//bdQgKu1IaVyoC+GD1?=
 =?us-ascii?Q?/Y3PUa7b0LjVucVf7/AcclWFUwKHrnYMPl0ozALiGV9OAmpW9VCoVX1J6XWD?=
 =?us-ascii?Q?uL4NlCrhbnHgog4iQVpm4VCHPYVxG/5pRXgrVYAOWYU4R/arCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uG0rsFDgyr4IUzk36WA6wWr4k/zy7umY3HdD7PjfodsgGapsJOpy6YNzea1b?=
 =?us-ascii?Q?S7AR6P4Ah0qxNMF4hj/X4Aq2p6G0nvIEufjDz5XIGBVqc4S9qN+ACgCMq6Oq?=
 =?us-ascii?Q?LVSHJ07id8/OOpK7GZ0tgRbLpN9zPnT/H3yV/ZTVarS+XwkDz7KGiGcLKxc8?=
 =?us-ascii?Q?sBoUmY0Y+cERv/sFs2g6q4KL2bg8McWYjw4h1OVj9fi5+R1FJ2YXw5PQl6Ma?=
 =?us-ascii?Q?ZTdKY3hV3ZE3W/Lhhy0eHdSrKEYShOYDaUF1PXlB2BO9mD33FlFRjnIQnOvm?=
 =?us-ascii?Q?S7Qt9PH1r38ne/tqfVnuQg2cIlWf5SF9LLcbHnsqEMziAxzdXnMWzl3JVLRj?=
 =?us-ascii?Q?iUCBTmAeTScAtAMBec+aNpL9DcRKMroK/OO9YWNNmTAsS6mBn+KY+Y2KPuIY?=
 =?us-ascii?Q?nam7yCiD+CCu+Ne9QKYFb94h4EZYXVqN05hfdYWJIALYsf/jstXDKJdJQIGD?=
 =?us-ascii?Q?L4Jv3qArzq4HsqDIZVqn/PARVRpxYWVz75Mgz8Z/cBfJeAQnmKP+ayItQpIy?=
 =?us-ascii?Q?ejVSqzAAcjk4Z6VTPeCZiSze+miE7NpXLWbhnqq+QfRUQbgNh+JN5Myzo9yl?=
 =?us-ascii?Q?3vrjFd8naPOH3QdzdceMiNIn7tGnIdshpOcp4jQ4PZpkRO9aPiZTDIkG8wj9?=
 =?us-ascii?Q?IV0dIpGXoDjBUIUANaaHmKLNmsIwTzsUeXgb1TeoN8FwSXKbeJycV4gbhaq+?=
 =?us-ascii?Q?LrCru5/xu9gH76d0yqWikkCHu4yCxnKu3b32Yc/QNQxo5pJDPVqzhcoF8fxm?=
 =?us-ascii?Q?jkotOgDMwqDd3rTUhc2SeUNPAsqiJt4RYNLR7FtectAS++62AyCvDAZAGSWq?=
 =?us-ascii?Q?ZM+pFsYLuAOV+ZoRrEXXASIP8jQGYg8rjRpuxhGSZuU/zj0krmQAHXGhN0Lw?=
 =?us-ascii?Q?880M9DyoMNcjDHKcb4koG0Pq4+9ppbdZ9l6GLJUXyPtdGLL7GQrmfSSEJFQ6?=
 =?us-ascii?Q?91rFsbvsrdxplDed1V/Xoc1FHwlXh/rrJ5AJVcqsT+JRIaa9vSO9hUt2cvvq?=
 =?us-ascii?Q?/hacnAzdTU5BlhTZQspraKEBLvgljA299NyscE4+Q5qiF3nB+6Y42ImHHn9g?=
 =?us-ascii?Q?dliWY91WNK4a4l8U63CkSgiHfBNH/51b3/ngD+bpVN6ieGtP218e57kmEPMe?=
 =?us-ascii?Q?7yGf1Bps8tEpvKXZOIfwM5bOQHyqdb1Orj8P+vhpSXaD+gHxVsKlnUp/A58o?=
 =?us-ascii?Q?SIc5w6U7sNzH91bu41hHqSS7pH81sxloZ5gQSvd2rJhGOb3wF3nL72q33IzJ?=
 =?us-ascii?Q?8QuVZEN/KI+5N1U+oZIuF+HjXF3PE3QToOfXhaD+ODJqXe+tZzAto3GU8wSs?=
 =?us-ascii?Q?/8XXfsybwBff6HnQgFhjqqZ6gS8Hugurxc3ivg3HZvwFgidQdrwvrtMMEcLO?=
 =?us-ascii?Q?plqZeK7sHUSiY82O9QbX8EQKYYIDD4GpAul9uCz2YUkdUnnIpyySRX5jRktu?=
 =?us-ascii?Q?VyPUKtnkep1NCvyFU3Egr8xm+ecMFOncjNPYhmyvc3Pt085sljzRsNM5xSQS?=
 =?us-ascii?Q?fTFQ5SbybF3p49Q8+qjLr0J7VIPnkvPsIVf5tq/gkqTV1R2rM+NReauUica1?=
 =?us-ascii?Q?Z/Pj9/OTXJbTJih3MCTOHA1M6mxQmIinVex55QAq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea761f2a-6475-4af1-4fbc-08ddd10add55
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:51:15.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeZGANyp6uBjTlthnCgzycsxt3RRIPx1r3Bq2TFRLO+8GFsBFkaQsRlC6Hq+b8JC/YpVVQcDy3l1lSxzd3TWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

On Fri, Aug 01, 2025 at 03:17:41PM +0100, Christian Loehle wrote:
> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
> Furthermore they become meaningless without rq lock, too.
> Only return scx_bpf_cpu_rq() when we hold rq lock of that rq.
> 
> All upstream scx schedulers can be converted into the new
> scx_bpf_remote_curr() instead.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 92e66bb0b5f2..627df3088fd0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7425,7 +7425,7 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>  }
>  
>  /**
> - * scx_bpf_cpu_rq - Fetch the rq of a CPU
> + * scx_bpf_cpu_rq - Fetch the rq of a CPU if its rq lock is currently held
>   * @cpu: CPU of the rq
>   */
>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
> @@ -7433,7 +7433,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> -	return cpu_rq(cpu);
> +	return this_cpu_read(locked_rq) == cpu_rq(cpu) ? cpu_rq(cpu) : NULL;

Maybe we should consider an access to an unlocked rq as invalid and trigger
scx_exit(), similar to what we do with the kf_cpu_valid() check?

Also heads up that locked_rq has been renamed scx_locked_rq_state in 6.17.

>  }
>  
>  /**
> -- 
> 2.34.1
> 

Thanks,
-Andrea
