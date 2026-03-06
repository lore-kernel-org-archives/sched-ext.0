Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6635F16A
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837659; cv=fail; b=PU5HKoYKpDsThuy7aEfZKvRDD+ZmwoVJOeGYQ5gsf6GGorsHxGG7vhuhMUL8IjLhkaQ4aHrE7rbzRpkKiBnvUwkD5N3Ifwbl39NlXy01BAQ2Fu0V8lDS1WDXO1/FODc6UXCXtg2NNvabyDHXGa46Hc3qenjmtGm4B0S49/Xnfc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837659; c=relaxed/simple;
	bh=gj9NZvXUr+X6thSiTkDBb68h/yt6e3ToDMuiYdWMKBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0KzeieO4eVhNwyaWXE7ZvBAKR8m/twJEKNU7+ymrySJrRTypp56yOIervLrpp24eT+qrMRK6Goz1uReOhhNZZ9DC9xYEUEIsgbz72fhkm6D9alhK7nWUnDmLOeKztV2IwcHf981LF5IEKb6v4Xc7tr5ZOWxTMSfht799f0bPW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9h0gIh9; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9h0gIh9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND5IGXxXHsHaCI8kSlu3/WPlJIAu3thpcELemNXjMbUy6t2dF6l21fKLq+hdrfjC4TfzzdGSUwb8F3dTGUtLlhEPGk1iOhU3SFkfJzhuLhCPOiUiS7xq/NuLL/Za91a6G0SmQpoXl5NY+D2QZvQOPFEBEJqFIAMBapvjDnDbfvDp6Vdq27XxjLPDJeBl7hxdsT44+0UDVQC4mykF6sVjMDytwyx3g6w1d2QvMU9Y68BYCULcQoOZ8pQXx03Ha5AtGt6Kh9xzicALyIH5tLcazDBFkSZx9KNgZ+OG3TRSUVGhj9WQZRJ2VTX1cDbcdS+92I4TnhGx8+FvVSpugNiIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08jw6kRy/n3gKMf1VuZp/NGou+zwLhmd8vg31ZMZq0g=;
 b=vrPj/5Xr71iAcDVae6KagK28F5jtABT0Bzl6MbPdWEWNJyvEbRJiH+29+F0NQ0IFvydgVl/y/LCPXsV0RbGf01hsYTBoOsDOpl/oZxGIgdWIvhB+1czu711OtB0in35+VFkY5SgiaEQWmBVGAOdsTWjzmRAfheEZVGzD854ZlBJmn+T/0nHOeS52DSguvEDqdJapP48n4MIlXPl12MsnQ0t5o/Tai86+15qnEWatnNbABZC1RPXM5xXCXMkkzEVK5JEC1rHsge7BEmclrTB0C6nVKRkBgu5IDj76stJxL31cCoaWcgRb8OtYGDbN2VjsSadbxXPsfppPDl8qciy93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08jw6kRy/n3gKMf1VuZp/NGou+zwLhmd8vg31ZMZq0g=;
 b=b9h0gIh9sFWATKqXmzgv1jpV6MtL7WB8kdT4WHNHXur+124tEJsTdXnYTUhVaSUglgACR6/BVocMRJFadShkoMkBLqgFwlEKjhOT/vIG9UTfi0t1IbfTVQ7iyh0cPgZLnCW2j8waKM13/cnXPhc/sI4tTmQVBmiAkqLVlLWAgKOVulAljeWTBvxsAsr647yLnGSuroDasX/uybPEdulMu4cEPyeLWhZIb98mHYIAMA3HUKveJbIM5uG602gJMRQ8ijAH8GZVAqhY/lbsQgLYmHlEGCX/jAu6iwS/+xHxAnHdd8AGLTv/x0TMnmB8J56Lktlk8k2z7voKiGJ+LTQ1nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 22:54:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 22:54:14 +0000
Date: Fri, 6 Mar 2026 23:54:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCH 10/15] sched_ext: Add per-CPU data to DSQs
Message-ID: <aatbDPw3wcY0b0Lx@gpd4>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-11-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306190623.1076074-11-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: b3001a70-cf7b-4a0a-150e-08de7bd34a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	lcb2S6Ykg0nOLz3TVcqUCdUAQw0S7rovasFX8LlOZMT4kERD/6FHWIxW0NYNf5mXUtW9m4FRSz/+yGnUPQOiBJY0Ddge+eWyr/HMfTSueNCH7jmX2XPGqF9yBoHXBtev7LWmCoZ2EoPWjis05nSuMkZMTJ+LLhdDZ5Zike8j25vvFwqYtdylRZv3wjoEdsCD9FI9Uypxvn92exeVMqmaSNeeSrgL6aNHS3PO81LVgRlFzl2j9tPl9sgmN7XnIxuQY1XygUhHJFc2s4Iy+GBOxWl70ju3zqTN6KeQ6DiA4iWB6CQorgz2kTw6YAbPfPf8DMwz2Qe/TvhfDWnnByb+moAFLgAZWfLdRsbj58XqifkuN35aex1ipqhA8Sb4INtxseBith5hwdBWA662MUhtYXX950xo0LkH9gFQZJ6EEmkfGvz03hvZRDdD7v6GTYwTtL7lpmvzqWrllalOcJz00hD0j+qehW/xwGWDNV46K2b+CYuj7nIirZESkbWhhbf2Oi/WWsahg4p9EYA6nbJsVKoXgvmjIafNPQj2Gm8Qvkt6Tib/z131nKShCZF5T+oUEHNG5OQly1Bo4/Hf7Mxy7EYyyMFnnXDM5yAhugPtnIPmGFCYnHixCGAAoCmllAj9cAq0adha13Xx+a+2BCf/uNvj30Qxd+TYAB5/Zob44JZEEHMiuiIU7TMeZFeAhO8dGeORwFRy3qDCrVCmtH+F9+ovR4UD+V7quORIrpR1crQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3WLBcMWGgyE+gvuJWU/4JxS1IOGeqqPjZNA0+FwzqSDGy4kwqHGh4qNvG0p?=
 =?us-ascii?Q?WXBGQVMbB4OF0COHIbAfQWX6IruMzMHE6CpyLNPeAO4rgMhv/j8upsPJGE5m?=
 =?us-ascii?Q?c/TuMCpPn8dcWQVG7Va+pST1uDjXofze0Ye//HLLIV2n6aPyXbx37BsH0AEH?=
 =?us-ascii?Q?peimgrD4h0bnJdZIFMaFqBqqMorfU2tzSMuSajclFoIIRvMvGaYjXljEYLO0?=
 =?us-ascii?Q?7g64AIZ+XfbAaRBb8dPeCu695uyEqAWT1wWbexemnWJF8rPQ4QjyJWM6EjsM?=
 =?us-ascii?Q?T6F4o86fhTfsovRgxjJm1fylbHfGpWkuxxbQiorXarCy3LV+Z6C5MONRvrvE?=
 =?us-ascii?Q?52WXg2HLZ61nWnKgCAkzfCBqSh9qsxLh/HY9fgVHiJAgg9EH52J8AG5a97St?=
 =?us-ascii?Q?Fq49HJ7pDZ5L0dZcsa1k16x3Lr2tQsA2Oz0b4plDmfis7zJ745t3sYZrFq7k?=
 =?us-ascii?Q?s9gWoELFMisKY3TB/GdhphXSF+jgv9nQ+kOBBjK6odTwpYGPhDj0qVZpYdjD?=
 =?us-ascii?Q?1kufzldlXF3ADvydD2tSk/7yUoy5gPlW2KNzqig4s71FXIj/4H6jyr9qQOuX?=
 =?us-ascii?Q?cLWiaBjs1vc01sZt6AdbWezZ+elNqP8enqpRYL7eqxZthVKByn27Larqby7d?=
 =?us-ascii?Q?tcHXta0zlcwHluDQySYnG12ps8rbJYYC1b7sRaCX1FTkHh3AmYmAeeOmeAdj?=
 =?us-ascii?Q?6SEd2dI0s+Up1P7DC9pDbDMfO5oBElllSJPChb4tUQnasXWFJu4WBK+wte/P?=
 =?us-ascii?Q?feE3YYZ9c7rj6fEvbeQt2oJ3gZw5OZ59n1VEKg9ix1NlCpj5R4zWmlqp3QKc?=
 =?us-ascii?Q?WU7TXSvwyTIshPN4AFdpAYqTDR7QUlEnEtspafLK5egleK6zQV6h84Ukheob?=
 =?us-ascii?Q?Qe67Xkbu6HB399alelXb7IpJpfhKfoTppZ2Dl78BxAIrczj+pUZgDvQ81srV?=
 =?us-ascii?Q?xTdwpikNNaqmyQQJ2qWam/C2swHQofvjSlC86SdUUCR3hfF7Z0VeLshTFsQJ?=
 =?us-ascii?Q?gdqhh56qKEf0yn5JNpDUgOYidvbCKSmVvEEZSXghIymB/nDtCJiM1fJDcMbb?=
 =?us-ascii?Q?Ypqrw62P/0tU1EOQ9o3GxE9KGkBtr7Ja9tMLvlVBCpL0LqxOUh/aZlgx39sP?=
 =?us-ascii?Q?RawnC+aXtF+kyFZsr3wBM6V8/XTJcO3qYIbaRRcKBHchJPrSnGV0iQ9Ao70t?=
 =?us-ascii?Q?s4E/F9ZpJU7YjjmKHF8MEtdaqY0kQqes/kzZTyiSCnDTEifHJJfZStW3U9X/?=
 =?us-ascii?Q?PAhVOIP9iYEK/gLsMXfGg3fC3neMZ/LHM53webSyxJgB/ZbniqEiOSTKGUmN?=
 =?us-ascii?Q?yruAo2/LA6vJhYoD81rvMipHMcIMTqhlwXDI/U8TcIrG9M6M4zbRnDdn6Nd6?=
 =?us-ascii?Q?7OgPP5wn371dYAYf5QcfHHt/g6Si5sfLvZc2S6bQ+F483GZu7iW2OdryT3jE?=
 =?us-ascii?Q?2/io0jq7qrIKiuKQ/wi22+W/DlzsntES0XhmnUPFQq+VANxrI6LX8O0v7y42?=
 =?us-ascii?Q?aN+wNgwqxKSszdIMHAunIR9Y7buTTbyhiZ7xgSVFQ/oTDatZRud9R5fz/5Cd?=
 =?us-ascii?Q?uIDOyoinild1o1BYY8tYI5ccOJy14AO/MxrJMicqPya2t9Fru3gfvDplq1bP?=
 =?us-ascii?Q?WtsmTnFgmV64qq94xw6n8JKdAe6ShlPhOSImTMeOobiars64Yjvh+EESPvUj?=
 =?us-ascii?Q?Z3e+eYotDYEVfihN0I+2W4YSQbOBAlI+sc76f08t95kYXjdhvk9aUTK3F6jK?=
 =?us-ascii?Q?x+iZKIk+CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3001a70-cf7b-4a0a-150e-08de7bd34a02
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 22:54:14.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5l5K2EjIS0MeBgu2UFBxV7v9Zvmjq7x7t7bIcB/SberbdAG5HnhybEF3ISJxoltpU0eoQmMYesTwYWvW6svKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

Hi Tejun,

On Fri, Mar 06, 2026 at 09:06:18AM -1000, Tejun Heo wrote:
> Add per-CPU data structure to dispatch queues. Each DSQ now has a percpu
> scx_dsq_pcpu which contains a back-pointer to the DSQ. This will be used by
> future changes to implement per-CPU reenqueue tracking for user DSQs.
> 
> init_dsq() now allocates the percpu data and can fail, so it returns an
> error code. All callers are updated to handle failures. exit_dsq() is added
> to free the percpu data and is called from all DSQ cleanup paths.
> 
> In scx_bpf_create_dsq(), init_dsq() is called before rcu_read_lock() since
> alloc_percpu() requires GFP_KERNEL context, and dsq->sched is set
> afterwards.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> @@ -5849,8 +5884,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  		goto err_free_pnode;
>  	}
>  
> -	for_each_possible_cpu(cpu)
> -		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
> +	for_each_possible_cpu(cpu) {
> +		ret = init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
> +		if (ret)
> +			goto err_free_pcpu;

If we fail here...

> +	}
>  
>  	for_each_possible_cpu(cpu) {
>  		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
> @@ -5932,6 +5970,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  err_stop_helper:
>  	kthread_destroy_worker(sch->helper);
>  err_free_pcpu:
> +	for_each_possible_cpu(cpu) {
> +		if (bypass_dsq(sch, cpu))
> +			exit_dsq(bypass_dsq(sch, cpu));
> +	}

...we are still calling exit_dsq() for all the CPUs. We should probably
call it only on the initialized ones, or we may touch uninitialized mem.

Thanks,
-Andrea
