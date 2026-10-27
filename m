Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793083100;
	b=puCRIMBA0qPQ5i9u0OAgUhFvNW+vUVCkGLizTKrBrRaPd3PGDViHGVVxvh4aaajMq0zL
	 BcIXZfGnTH58hcUs9OSzmmKwRVPk2V7BaunP2vhs8xaMiYu8l2kd0FGkbnMJw6T6KFwKI
	 INSeFWiFYEL2Owzj8wMZxF8Vark5uUKZIhIINOlKw7DwHspl+Tpk2lpC9f2lP2SY8LUcM
	 HVGZlNSKo7J6KNNlQC7oOT+FpmPNDLg3HKHUY6z5KGKSmRBsQdamh6LufJVbbvHRN0R/s
	 30q6tLPoCDnq8Tk934kmNQYVGRllpaWwmxI1z2M5WZDT1QwA0k4zfuhrxJTmxZcN6xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lIzj9UagPQr+reBB8hC3wCNCIhgZ0CwHdI9L3VBUv9s=;
	b=0qVOSOz9iM0+K//HerfBnjjIDjbQRR28b7Xm/+EjSwLw6q7Kl/dF67stJ7camI67U6qP
	 oGe6DbyNUdMmHPaXu4MDxlbBSEFgzAkpH+EncO2UT2Grz28QDRkhN+vRYEiIELGxixGe6
	 e9vZcxoHeDhfPnUgYuW2Tm4A2j6FULyrZo1lfHYiVtCLcHLL1k5wIIyKdVlBKOfqCNSKf
	 P6zcgDZ72pwYMFMP8fWgN+inagWyK2ygCXi2x+I7X0KXKtdvmEiRbeI4722O0YPdEO2jm
	 O1yNL/OKtmx5bajYIaudf7e30FA3VFmyBjL6d/THjfMW3/L1Rdwtkl3gfoHWsewix8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VUFJ3vIF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8C606A32E
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 06:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C8C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VUFJ3vIF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsF9p7pzI6E3i0mdWiQ1jIjUWQMy0ptlzzTQehP+I8y9k2NbHjyDLZPIq/sTdAeYLg6i2XB+k90XYAJ47YQUz6WDMewRitMjuypM0TN5jWIhTXOHd0R3JNooM06V5recU2/G1kQgjxpenYYoRWIZ6hUK2hGWNKropL8rMHR2vG0+T/DCmIzSse1VsS+/wGSgjieF4SGfzCUx8FgEceMLnpjANM1KTTA4cBxpwlpyXJn/YZrHyw8kH7k/m72tV0sU2NdP2JeKoxetRklUkrG9uuZTqVsM8sWPqz49GZqcK8AieuOMli8/MUjCl7B+hcVaG60hTbP7ZgPSCx5uzU0NpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIzj9UagPQr+reBB8hC3wCNCIhgZ0CwHdI9L3VBUv9s=;
 b=PY4o6L7RaZchvq66hF9XJVIlKtYzi0vjYZYeJIb6vQLZ9rEhjXWY/Y1ozkqTwy9TDJaUF/q88JUNSU+tr8aqkUF2lMgEQ6AiI7F3fyVBNZln8EGmgVNzFdO9pvQXhzuPxWIO6saVXOZ80JVCSkkMEk52cD6qz3K5k0qSfJAehWyfkTJwsDiBl/72vquJem8FAPwLTyv2WInAZ51ZAGgT54A1n7ve2wUJGoEoN7Fh5i3XZdEdOw0yRKIxvZNCCT2FnvaH9oVVzKlTxyjuxDn1uV0h3OwkjKl8aLDTqXMk7B3pWoTa9wJ6/w8tuSGedQNMs2Ml4e3t5XAnDwQYooRn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIzj9UagPQr+reBB8hC3wCNCIhgZ0CwHdI9L3VBUv9s=;
 b=VUFJ3vIFYIdvnxGviXSSONDzq9r99WBwfc3WQ4cmClPV5w9wDLjdIShM8SDVnsNxm1uS5zAt6HWPvSN7Axxh263q3JheyLFQXx1F1+A3yWmhyCcgWN5yWHaFp4rjZLQ7o1cfyGtEapm5mmZOaxUkyrhY7vHiEIOHmsohYLIpKlEMzyrYSuEjfHwPtaf92tdjHSYSMLNrA++gZNbJ869ER+IwzNS6vKzGMLYX0pplaLziNgmCzgHzI61HoN9tV7jId69FYUCbjU6xHgPyK58bGmvNTyrjtndFkRlkiZaRaVCnlIeShnOqBMw4zDpsAnbSYEiUUtasMR0V/WmXHzRJrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:34:32 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:34:32 +0000
Date: Tue, 27 Oct 2026 07:34:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched/numa: Notify the scheduling class of preferred
 node changes
Message-ID: <auBF7UTiwNblg6Uc@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-4-arighi@nvidia.com>
 <26d4c1d1-19dd-415e-beb4-05b7f34fecb3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d4c1d1-19dd-415e-beb4-05b7f34fecb3@amd.com>
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 74435d22-121f-45c0-f484-08df33f45c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|18002099003|261026121527099003|22082099003|10067099003|5023799004|56012099006|11063799006|4143699003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	xnKTd2sj/BVq6SgUK1JuSGFy9fuAjtltZn7SGKQnCm17JhYhveExdRgm+BcHu711aOvsnF7cW6Y2NM1U+fbQPGMGuiLDfWCct84ZwD+nOw09G1jrE4mGAXEyIwcbciqBnHLEa4btO2vPEFSq14TUiRenQVYp1KplRlIsGa923IJW7uAGnpTZ0jdrE32ctpLvvfXRA1e9DCbMTs5EsUYoIWLFdWqfRev6xpLsaLbaS7mpKjkdms1fucvW7TzrKSS6+Y2rnBOO7bAmCz8hTINLdmBG7FfWLkyZWfnFf4hpv4Ok0a7CeHjo8CvgwwIKZ5un2jxLcC7KMGugtmAEntp/NFMDmVX69qFXufqTY9aYQ3r/nfiBFBi1cocf5LB2Hit2XwWjXsD8JFzAAnsMYY6PKW0MVM9mb493qqh/4KtEjDry4ZLdagahRigOzbo/GhyelkcForZ69+h0RIdB3hsA3C4rMx+0GDaU67JqpFShnrkQw8SqI3rGYfuShZb5i3rtcLIUGrH6Vll0uUPZyEgcqWUm4j2fHtOlMdA4dTaU/TnFZM+x5C7cB/DQy98rjbH8Qvv9vuw5XL8e49mBFLpYZJnn3283AS+K/7H+jhJdUbchE0Mtg7WjfhMAl8sM1HvFFqqxW/NV5xNgKWka2mgh+rWoTSUhtoulvGmfVFWuB2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(261026121527099003)(22082099003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(261021121427099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j46lBtY4O/G3ktVhvdQhf93CrEhztsryCM5MSZpommUjwGM1LbWMAOQqBOtV?=
 =?us-ascii?Q?M8wn7ml0KFyrNG0f0P/mQZAhEgD0AFomoPniVaeAe9ZlRIK2HvuEWDQiu585?=
 =?us-ascii?Q?S0Vfb3VsT5bS1dc5KPHj7kBcIU6nkIxkZrGYG1TJJ68tLEHOsF0QWbctRn7t?=
 =?us-ascii?Q?uDlZBbHDFu2Q1dmswjrnX6vp+OdTrdhoCKay4LiojK8GUPTqxcTt10RO2VqA?=
 =?us-ascii?Q?GXrxUM+PEr1tSQsZTOfgge2FGQPLKKEnzMiWGL7xFHd2rr8QWn1rMuZ3Cuqk?=
 =?us-ascii?Q?RyHUljKNbiXw1CkQvvMkfnLnEiVtwst2BykK0S7/K/qlNh22QE4KH4wzUiFP?=
 =?us-ascii?Q?94jb/5vl8xaf2JVfc+Qu2MK6Ruu/lRmTdZQkgErZALXTe3wYZwiQtKYlIn3r?=
 =?us-ascii?Q?zQvgnGxbf7Xo1Dpo8FvJLt6Htjmuz0w8zbl7DbCftp4LQFuW5lNshz7poSd3?=
 =?us-ascii?Q?1GEa1W5uz6R1XBRIrgYrSfBP2vv6r7wjnD4OMO5TLtj6tf866JT5TXboDD4J?=
 =?us-ascii?Q?YTvHtAvQTFwlNFq3NcoDnQOSPL3CG/hAvoV5Xumkr/a++sJ0VBLV5prELs0Y?=
 =?us-ascii?Q?hi6+pu0sJs8FcGU6vxOSB8mDA8n/R/uH9UxVE+gHVZxGQ68v1O7akBOYxrdK?=
 =?us-ascii?Q?HASjgHJZBPQsLECJD+YteP59b0/HMIoKvz+yNdxUZ2pS/5Nh0EZZ/s2V+3oU?=
 =?us-ascii?Q?pvtimB5oxPBP9f0I7qjMI6Si4tMBWsbvYe34gzMGlqGM24fN5UEt6oy4ZptK?=
 =?us-ascii?Q?B0dSNC84WOvACaCdSYJc2NJYk7IjrmlMJvzaqdKmLBIzzvJFSI2VKQriDrlL?=
 =?us-ascii?Q?DW8LOQRyPHjDU32TDP5dOyRv5N3aNKneow591rmDoOM+GNjEVzccgM2SsTfz?=
 =?us-ascii?Q?Ma2XW4/s5mZ7LOBza1NXVF0oNum77pW2P89/hgQC5g84Ml200E8GhnzbWLdg?=
 =?us-ascii?Q?Y4XMYED6KnxFIHwMnMsMHpojS7sT9zxc1vSTEAiFDEXRanqTmAHxmMdu3J/X?=
 =?us-ascii?Q?AQiXtzs30VLRjkZ226KLBPaopW4SwmemLki9nO7zrcwFNwsa/v4piclNED1A?=
 =?us-ascii?Q?ZnKubVfDbHwwwR7gZeJXxEh86dzOZTyUkMchFqse1dNAMkVuXyug6k8BbsKC?=
 =?us-ascii?Q?anh9PHnnuJCojUYNJubkpysvRko8V/7PhlE+Enuet0hamTyQnKsiMhcEmQPE?=
 =?us-ascii?Q?JKWaKXcScBZI+w7gU1TuIucvOKzeKg009IAgFkMHcqtAVRBPe+Q/+lj7tsO5?=
 =?us-ascii?Q?HfuWc2zQ2sdxQVMX/VklxM4i393N1vrgvYmj6LbPnhfe3UUd8oyVXUFVjvZu?=
 =?us-ascii?Q?8YoOM1r0dBVJjExue/KBBdJwqILPoLAfbVYT8AM19/eddKu2NQCwenOvsKsO?=
 =?us-ascii?Q?v3flF8siizTakCakg2NwBbr1W9AoKpeNk0ExXh+RHBeKaovK7ZikOUVEl5Ja?=
 =?us-ascii?Q?LIPllDWiK/rAqshjc230ifMbvGVPueHDWOs6BXG6B5GZBjsOR1gNIG4TbUEU?=
 =?us-ascii?Q?z7A5/PSCUd6gPdU53Ih9FvhAjAx4gTgzyvpQ7nKLFaonNjSbVcjIx1PNQ7I/?=
 =?us-ascii?Q?godqCIo92JfrotPT7OTOioBhJEezHSu74NGGdCrVU8IrUWX1yb2nOp8wK4pS?=
 =?us-ascii?Q?kbJMVMZYl7D6WW4Ta6B308GF7DdyF7xWqrs8pE0uYRhA4wCqSRSw6K8m93Vt?=
 =?us-ascii?Q?Pa/J0A//A/WxvlIRGyHzWCxAHZUIzIXW4IfUNmbXq6zgGmVlLuccp8xdvuGu?=
 =?us-ascii?Q?9ONnWQxc1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74435d22-121f-45c0-f484-08df33f45c3d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:34:32.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX/2pEuINihVthJZERpMO2LhXIZITlgweg4H2diGtX69tCQeKzHZNv5k7C7D7QbPzS+s1WhbHn+QoEt6FR9O1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Hi Prateek,

On Tue, Oct 27, 2026 at 11:00:17AM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 10/27/2026 9:43 AM, Andrea Righi wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8331,8 +8331,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
> >  void sched_setnuma(struct task_struct *p, int nid)
> >  {
> >  	guard(task_rq_lock)(p);
> > -	scoped_guard (sched_change, p, DEQUEUE_SAVE)
> > +	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
> > +		bool changed = p->numa_preferred_nid != nid;
> 
> Don't the callers of sched_setnuma() already check for this?
> 
> Only one that doesn't is task_numa_migrate() but
> numa_migrate_preferred() only calls it when
> "task_node(p) == p->numa_preferred_nid" is false and "!sd "case resets
> "p->numa_preferred_nid" to "task_node(p)" when the task cannot be
> migrated.
> 
> Afaict, "changed" is always true here. Is there a scenario that I might
> be missing?

With the current callers it's always true for the tasks that can reach
the callback.

 added the check just because ->numa_node_changed() is a generic
sched_class callback and its contract is that it's invoked only when the
preferred node actually changes. Checking it in sched_setnuma(), under
the rq lock we're already holding, makes sure that the contract is
honored independently of what the callers of sched_setnuma() are doing,
now and in the future, instead of relying on each of them to check it.

That said, I don't have a strong opinion on that, if we prefer to keep
sched_setnuma() minimal, I can drop the check and document that the
callers must only invoke it on a change.

Thanks,
-Andrea

> 
> > +
> >  		p->numa_preferred_nid = nid;
> > +		if (changed && p->sched_class->numa_node_changed)
> > +			p->sched_class->numa_node_changed(task_rq(p), p, nid);
> > +	}
> >  }
> >  #endif /* CONFIG_NUMA_BALANCING */
> 
> -- 
> Thanks and Regards,
> Prateek
> 
