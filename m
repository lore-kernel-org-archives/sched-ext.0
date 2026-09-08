Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF44DBD9B;
	Tue,  8 Sep 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862121; cv=fail; b=OoZA1DK0K8ugjcN5M21m35QRv3A6XcAUquMV7ddLvc9hbuJpShxnqGPiIEwqSRSFDoFcJqDTLkbqzvReHGt4p6ItrbqZJPt3ikO4A3vSLw4pS+yFtGL9YDJ7Jrlr7OV2PwlYOYcR+9P72DNcbuZnHWc3P4EKlUHZ2+DtSxUCLyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862121; c=relaxed/simple;
	bh=RJyo/dkaCpqe9pt9Tb8mTruPWwkxUW4pr9wiAHZfNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hjvF2e01K7hVkuMHrOuMc5QtrD/bA6oUtIYsefAJOdkOR7GsrvM8+HzMnJ8qk+9G+uv0/qHW2njWgB6Bg0rQhv3WGSOFW/Xih/asBQ42R0CCXEhP0qOSjsEruQ0As4By++oG28ajGaShpaCzR3hO6Ubx91a1Ej45co2IGEsO70g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4LF6ttt; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4LF6ttt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jubeR6/jPf1o9CF6eilmOVuLvoM2Qz1/kIH3oV7lzX+O/Om9+PgvPA5g05F9UWJGQnEkCRMu69ZMKOvl9oKOkh2u13NRi7KmEJH3JVlXFrRoEiwxZ9JZKVSF9h1HZoEpJS5/AHtJafbfMgRYhtgp+vdEyPh7C2Q6CwyfeaQ7fvy98rYL6LOoadUYNBO8Zwj66hNz3GunNNU8YrzM7UC6ci29ORpf0p9NeEK0hgVknphzudpaW8VbCsPEdS30zPyt2xk3uJ7UJ/gXwPqkqEHnWYL/m+cUI6tjeDNrdzdJKD698EhDqCLNlD6WKQkm0wEmljwPkSuoqaIJVnM4QjOTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+rSzqNW3oknEPjauvAMLWmAGKERNF5GasqiE7IEkL4=;
 b=kGXmIwJEl1qL8Tzn/rgChPbYpxhWDYOvVr7nTaoBMC6FEQW3ZwLJhwKabp2pXXk++CwXCl/5D84sXPW7of00hL0ohARCfkhwnp01yJqWBJTJcShcjFi4R59OO+cMU1HDg92yc0s9oxq7MeFq6tF4GW62luWywtZFwmjsyEXetS2Usmk/m4SEPr4Hwib1Wq5VLsP0xG9qkeg9X+mSTucG7G8Z+HJ/736bgSXqA6DazEg08deYrGSYdrBWSa61xZPOn3twzeVkr9u34GNB9/IYegs4eVp7bn7shiTzZ5nvRT7kBiEkI8k88PMuJYpHrxqDlmnHQ7yHNSvmh4jE6+BF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+rSzqNW3oknEPjauvAMLWmAGKERNF5GasqiE7IEkL4=;
 b=L4LF6tttVzEsj4TqLvtOIKU0ASLggzOCU0mUldBFGRQqOnl+hH7/ap0RVgHO9KAA1uyGrqddE2mBzPUCk9Kr0LUl6roxlj0w3506Yjt3UuSrgCotRaKcILEY0tdIfdB4JUjeftMkSH6jqmW37tLB1M+GYeLilK0uiNw15lX9g9k5Exl7KNZKAubGu7cW9d2FcRalw334DZEgEJ8FEbz3069fOvmdKr8rnP250cdb23a46+btIkbu5LTGP/eKo9uRUOs5nZSg8NDnqdojJm1XMUWbCsH8AjrODZpRwLuidJKeURX55Eo4SJT5VVc09pUuFY2HDwd/4NkZwwU441p5dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 10:08:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:08:35 +0000
Date: Tue, 8 Sep 2026 12:08:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <ap_emBJuNQiSOFXg@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-16-arighi@nvidia.com>
 <20260831180837.947171F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831180837.947171F000E9@smtp.kernel.org>
X-ClientProxiedBy: ZR0P278CA0169.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 264846c7-5d11-436a-8fe0-08df0d912497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/4OpAmr9wv/BR/J5eXSh4Dg7NNmQ3HxN4s1x06vmgFg4dOs4s9DA0NqHV276eMgp3kbwPBfuYqv+ET3QWb5rC5IDm7BfCH/+dYmpNFg2h1PEZEYYJFxJc3KsMVbMCgY7w4Z9ymaoH4dQWe6JZvJfm3mirzvW2tbCy3ut06SJ1tC/hCuvOYJn/tUim1XEf1+72qDQa5JGI3id3m0C0Jt9/yGF/TSC9WiN6g816nZesCsh6nSHI/RS4x1jy3HhYwcSHMJjtAdaxv3ifxCverthcplP+hVVb9Hgydo6krz7hJXsurTxjkyjLfG54IXf0kJlRfzchC8iIM3As0QQFliLPzyU6GtHGoieFynZ1mvbHrHGt59cE+n4Z1VHw/OgOZJkbIRdx/D+MXfPqVVqwmMG/ExfYmeCbe3dCwDVtlobANU1cHsKVutub1PUC6hY4gAOyXwdc9LRlKpquIB3W2cX6Gi65ceSxGWf8ZojSQW9COWKZHldLRc1i79hWpmf0kpjee22yuSFep86ph8y6GkRYsZDf+1CkVNYLhlcWF89atp4G5FSL2Jw1ciDS0FcHevcG2GDAYXPXotckbG55zOpuFOIaHiBrWqE1CChqL3YllPVpZUeP8boRiKRnERiUiy8Wa5GshySTRo/UNaNvNLG7H6JZV7YbX0lWsigmqdrPRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMwrQIEi+GkKimJAgtSUasS4KJ3g6Sa8P87b6N9EH+5aB75FZol68UOt7wLM?=
 =?us-ascii?Q?+KdUBt+jAhPaehbAEMnjR9Zndn0+KPO2TBiBKNQ8634rdnfRT3+Snbr7vLVD?=
 =?us-ascii?Q?CcMkBLoodio4svCwfSHtXvYmKWNQ6HNGw3AmGtvCMzCeAQOR0ercd3sWckA5?=
 =?us-ascii?Q?N0HZ661V+NldsfQzOpWXk0uTSi3csValfByTLO5sYGKH1vYXzRKecTXE97GC?=
 =?us-ascii?Q?mZJlS+GpHQGUAmw7+/JG/2EnwjGqnLjBf/DZo13Z7jy8nuCjlD4Fzw0m2Pnj?=
 =?us-ascii?Q?6ATijirwsx3aPk0E+6/AZ5VxlnTplwWbgrNnP9Nn7rfJDFtvhbSNl33qqxSO?=
 =?us-ascii?Q?dXH6DaYtW1SOVmbX9ONlo7jnFMRs1EugD/7YIw6LD8FgX5SHY8x9YKNKpz1c?=
 =?us-ascii?Q?BSrxJMen52PwWJ53NPmeaC1O3oYqbU4ffiWtTxhaRVNiUGyzGKDBkjbrIK+Y?=
 =?us-ascii?Q?KSBh2E7ZrXcAHL1SC+dpLyKDOD+jE3HEipnvux44Y4fJ0KBz4t0pm7ldDaph?=
 =?us-ascii?Q?TLtSmgEs4kONaJUTVhynHicBSn4NBfqAnyN5+zDadyY6K7BM+3v8ucigMw35?=
 =?us-ascii?Q?6KSuzKo5/jFhOOdVOooG7c6+kAQ6wFUlYoG72To/RRPz9BwxLk7KTmGTroHL?=
 =?us-ascii?Q?oaF9CJEJUfHlG9ZtRJxYy9m8N/p020U4f0RpcIP1Y3NCVJJ11dLiN9A4bS6i?=
 =?us-ascii?Q?GYzdxY70aSb/NwjbhGYGrx30tfgYOXxo4KbvVSltHWT1cEunqgLE8YavAKJd?=
 =?us-ascii?Q?Af4skz6NSq9wl02n14IKHdNOaoi76SrAOEcYdHPmC4desgrfFILzbK2LjW9E?=
 =?us-ascii?Q?0cpcpRPNaJU8qCmYFuLkCTJIz1+BXfs5vUkdHNRBmc55QpugL3XUFQm4TO7g?=
 =?us-ascii?Q?AN25+7l4siwgJtxHuFQ2qoH+IXQSeLi/UWLeUqMiUmxbmeuJ4ipRex6h3ik4?=
 =?us-ascii?Q?KbMZ7zKYD4f2RGVkF9nwpbiq2oMbfKYhy9m4cBi+fIOOMo2I2UwFGeAKJbpP?=
 =?us-ascii?Q?Dkt877KIcRMcI4NkTL0f8qgeM/Thf+FY+2q9eO4a4lBQKUun+9yC7CpcqkJy?=
 =?us-ascii?Q?O6Tk3aYnXHRb9fOrDphCZvIt6p6uYCABlrYax5hKJUinQOfFT51VWWK7vvTp?=
 =?us-ascii?Q?JLYj0ZMqLZgvQYdJNno3rEdDs6EmAscQs0ta/8a4rm/ml1u7Kj6wDbLtiwX4?=
 =?us-ascii?Q?CZIn/Iz+CINfEMb11Wf46ogvgqRZVynQ7guTzdcPWR4v0QMZUvvhoOSk/bb2?=
 =?us-ascii?Q?YRYKCrtP3cX5B4cSHl69GjDcG0YIqs0q3ecarrF+1aDVZ0RSgEbW59dMpOrE?=
 =?us-ascii?Q?BRseUnVNBkHHckfRGsq9AD/XlyEy9zJAnZ+KMIjP4F3Dkaeih5DZbJsrWDnm?=
 =?us-ascii?Q?Nzl6MLuQ6RAZHng0ToLf5npIy0GrCu6W/opNZt9Knmsj5tgOiQMA/8pIm/5g?=
 =?us-ascii?Q?kA3zDvyryQYFXca/3FrtPUcb3CrGkDO69Ckvq46H0xojDtFsvM3UafaFVsz6?=
 =?us-ascii?Q?40ON9jOozRdeUax/MhRSIUr7Rq9wwYlcVA9aOcCe0gNzI37TVONYiJsm+LOt?=
 =?us-ascii?Q?vwqpzNlk4W2m6qH/puRJrj5KoqOJKtKZm50E/p3aPx/jIV2+wYFGXZGVWbuS?=
 =?us-ascii?Q?kQYaFt/FDNIHyGRrMpJlwOeRRM/FUJcOJC4b1ZIhbLghFDEigRiFupjSMKr9?=
 =?us-ascii?Q?3Ztvu62XaGkogZBLfzSwp9byDYU1E5ZJNdJsrO/xZx381/DJTOFYn2yLjFCu?=
 =?us-ascii?Q?rfr4pE/eAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264846c7-5d11-436a-8fe0-08df0d912497
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:08:35.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0LeIKxVm4Je8jVno6CUgZ7OOl37dp5WcIr4pwC4PFY8HJpbj1Q8WB6Gg0l1pJIALRNf82dgxjXpbkX+GdTg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198

On Mon, Aug 31, 2026 at 06:08:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The new BPF scheduler receives `ops.dequeue` before `ops.enable` or `ops.enqueue` for retained proxy donors during root scheduler enablement, violating the BPF lifecycle contract.
> --
> 
> commit 2446f36cb7fab90783875259131bf6b0d4fa2d3d
> Author: Andrea Righi <arighi@nvidia.com>
> 
>     sched_ext: Delegate proxy donor admission to BPF schedulers
> 
>     Proxy execution keeps a mutex-blocked donor runnable so that its
>     scheduling context can execute the mutex owner. This patch introduces
>     SCX_OPS_ENQ_BLOCKED to allow schedulers to continue owning blocked donors.
>     A proxy-migrated donor returns through the full wakeup activation path
>     when the mutex is released.
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index f23e9f1ee2f3c..06067fe504a24 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> 
> [ ... ]
> 
> > @@ -8027,6 +8108,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  
> >  		if (old_class != new_class)
> >  			queue_flags |= DEQUEUE_CLASS;
> > +		if (old_class == new_class && new_class == &ext_sched_class) {
> > +			/*
> > +			 * This is an EXT-to-EXT scheduler ownership change, so
> > +			 * sched_change_begin() won't end retained proxy execution.
> > +			 */
> > +			scx_prepare_task_sched_change(p);
> > +			queue_flags |= DEQUEUE_NOCLOCK;
> > +		}
>                  ^
> 
> [Severity: High]
> Does this code call ops.dequeue() on the new BPF scheduler before ops.enable()
> has been called?
> 
> Looking at scx_root_enable_workfn() in kernel/sched/ext/ext.c, the task's
> p->scx.sched is updated to the new scheduler in a previous loop. 
> 
> When scx_prepare_task_sched_change(p) is called during an EXT-to-EXT
> scheduler ownership change, it triggers the following sequence:
> 
> scx_prepare_task_sched_change()
>   sched_proxy_block_task()
>     dequeue_task_scx()
>       ops.dequeue()
> 
> Because dequeue_task_scx() sees the SCX_TASK_IN_CUSTODY flag left over from
> the old scheduler, it executes ops.dequeue() on the new scheduler.
> 
> Since DEQUEUE_CLASS is omitted from queue_flags for EXT-to-EXT transitions,
> the switching_to hook is skipped and scx_enable_task() is never called to
> initialize the per-task state for the new scheduler.
> 
> Can this lead to the BPF program experiencing out-of-bounds map accesses or
> NULL pointer dereferences, as it relies on ops.enable() to initialize state
> before ops.dequeue() is called?

I think the described sequence can't occur during root scheduler enable:
sched_ext is globally disabled while tasks are initialized, so tasks always
enter this path from SCX_TASK_NONE without custody from previous BPF scheduler.

And I think the EXT-to-EXT scenario is unreachable. Here's why: after
__scx_enabled is set, a concurrent transition to EXT goes through
switching_to_scx(), which calls scx_enable_task() and changes the task from
SCX_TASK_READY to SCX_TASK_ENABLED. The second loop consequently skips that
task. Otherwise, a task being moved to EXT still has its old non-EXT class, so
DEQUEUE_CLASS handles the retained proxy state before switching_to_scx() enables
it.

Therefore a SCX_TASK_READY task can't legitimately reach the
old_class == new_class == &ext_sched_class case with SCX_TASK_IN_CUSTODY and
ops.dequeue() can't be called on the new scheduler before ops.enable().

So the EXT-to-EXT special case in the root-enable loop can be removed.

-Andrea
