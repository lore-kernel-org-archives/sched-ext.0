Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9E5304D6
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079980; cv=fail; b=fQQOlAVgKSVu+SXrz58JGYn2M8E+vKWqmW13aF1rSDsmoF24cmaty4BVbEmc8AnGM95G218vgc3EQsFrNmpLyWdIHJNWVBrGTXwLkL6oLoi0GTFF26c4Rod1DuO8AadamIS1/DjjZYnn77c6Cu4UsAHJPUOYQPKbfxjOWNtB24o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079980; c=relaxed/simple;
	bh=bthgiPUP/H8tKVQdLJXzXNYfm2i+xONjcq3zdSuYQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PXIFgwMj2Wn22sylmoWHrKjXbpBYUIdVyVIr1U4/Ba0TtdMCR8ZhbbkdhnSxyoal5a3+bVcqfFISziRmULzS+tZGpiITuHeOxzTsuWhUhP4WuHaoLHqqMC00niucfPvzVc1dU5EymUFT02AWci0WGu8syZyVJLGgpSY8ebPTgBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MIYiehMA reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MIYiehMA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeDmK+9SIrYHbZ/OCOw2OvN7pg0gVlhEK+FxDfOjWj+QzrivdgYN20a8aq3emuViS2WmfZRT17OnKemHklv2BTrgcJj6S5XN/RRX9BZQbhFYj5nH32Yf1Pd6/InYVxdUNA09xUHKOkmpDYBfIt/oXg95V/ToLHI1/54T1u7zRA/Wl1TGYzSBuBucAgDrJY3i9OmBUse4Y38yOBMM17IcIMcwyZUUzcmFsrUTmO8n/RchNwh04VP/Ns/lTL15MvWF3mVio2nnkzh/huuNNW0MnOKs3wQiNgR4XQ2KdZUt2EGYJf7oomHEnZS610spzeJ9cmxAiRzCmqL5eZurgyd0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqZLiAh+/UecXkEwPyCwUybj5NoY9DaNZcMDT9pHp2w=;
 b=ZVvkrZ31Q0EpRRGvO+cYyE4jdMxHvVlkrLgvHIMBsfc5ylQXSQ1T8DeU+lD8qNlwCg605itHJpnyTiYR+lu1E/niDD1Cfzvr6+4T/EQ0anFnb9HDljIU4bGQiPzUMb0YXsSJqoZDmHc9CoMVfyTOSEnO66U5EBS3LkPHf8revveieR+aPuZI7KnLg/buEAO3EaV6Te1prLOXmdLZ/Fq9XAZcrgjoLyQHO9Jcb3vTqjz6zAVNZE6UBgZaTSazMuczfbqV8WoDV/+9scj9BcpXG6b+802ktedrzgihcqDc7FCV7haKTLRp7bup8Whk8gh3NL2j+AtrnuMEYsUs1RtOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqZLiAh+/UecXkEwPyCwUybj5NoY9DaNZcMDT9pHp2w=;
 b=MIYiehMAP5TqXRLBUcDaGwC4SgTWuhGm+AC+rigD7V2hmUgdeWytjcekViGSrlwLsfoepzUoS/QJ6G8OPON4xnl1NB5su045a754PGEpcv7xkcKBHL90oBptIyeBcZJy3HOkODDA871DV/atvO4YuD+uy/H9cWbh6UcKF0b3nrADrP2QmQr08wEO2WKRMVfyj+wuTSC9gUe2XB+tNuh3Hf6zfM9MvBhW2EZyNoqcmUvScF/VJBvMu0vHjldoAmliS2dTR6HRo/WNNodQ6lqy+nzA4EZHJ+bx8z0b8Mhp9Ouk+Fr4yM/vHjVRfOk7vG+VCrmhNeSpH1JVbauVuNQSNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:59:24 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 15:59:24 +0000
Date: Thu, 15 Oct 2026 17:59:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, trilok.soni@oss.qualcomm.com,
	aiqun.yu@oss.qualcomm.com, abhijeet.dharmapurikar@oss.qualcomm.com
Subject: Re: [RESEND RFC] sched_ext: Support RT task within sched_ext
Message-ID: <atD4U-L-Dx8LKFaT@gpd4>
References: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e1538c-038d-4f62-f174-08df2ad54832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3ai6DlPJNR5A5FwzaOFUmUdZHUYLe/A16iXQb9TRDvddY3FOMa9liTRpR8zCN/eWV0+8wfd7TBHq9Pyca9ZhBh3VykyyGLYMB3mAjDB/qf0UJZFg5PgKT86137QyRmhUR3E+NOy2U4NOR1zp+Eex3WBOpTRx1Yn+1Otf9CJ/Wb78OBznpTdFm0kznB8dfd34uOXUdypeOASvxmgOboRd/iuAP3jI9k+sbuXgM84KsHtN5mk+92RMbNNqJi62ei0s6nSPGwityfc+NuA86WktJt2laHWkD107Z147WknKlS1ZuA54iJKmRZ77T53sCuUIVm7EWhS38oTCl0ITCailRd8W+3RN/f/OKRt6TxM+gvfMOXCg94epJXt7wroVDR7OOR+j6RsfbtbUsFlfVguCKzKQrTocDOJ9opqmluv8lZ9kvP97/7OMX9kCI4cZLXVJ4Uwho6DpcIgGHafEAyNbzpFTAsiiHavOzgXY5PEbP0crfeNeUjX4eE49FqtUnw1cWG66U7rhMVCWyd/yvOOeKD8eoKH+tZ9yb7E13N/pOOdTUFAhO07z3ATe0YQhhHnST6YnMaSkKrwIL+5LNpCFXTlg2FHvaQjbUYrDygecJKIahBh7GKQ/hletHr7KgvzcJjeFFEu27C1JBGBcqmUBLuxjH0oFdTfIKIZhECCe29c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?eW2O7Mhy1gDiewDYK1+Qtwfwq+6EMgEL7DljoFzVXYnD3no3TE8JFtlRPF?=
 =?iso-8859-1?Q?flrqujGKrsfCEDThHDtW3YCXo34DO3UBrxTFZviWvEpxLPoPJb1dcL0NBZ?=
 =?iso-8859-1?Q?BVlfsCb5Sh7pHUSh0/b3XXQhwfmjIoclLLhHvyq1czLEBG4uf4XoUSiU1W?=
 =?iso-8859-1?Q?CJuXG7bM9Ow93oMTYRaj01C0wqetR6WpVe98p3DVLBGQqscNURRVBlIdkf?=
 =?iso-8859-1?Q?MSG9BdB9Nh89HHjUBgsamH3x84VxA5n3jn35dxrraMif0zi+mTJ53Uxr65?=
 =?iso-8859-1?Q?k+1LyIyDRSaDBR7Is1BefTs7XbqQ//Tz1SjgVJLLupIsULxl+Uz+430be1?=
 =?iso-8859-1?Q?aNo6jssRirtRYHcxAR6boCtpNd9qEmVBvUgMtpAkTsN+kHBOKKDZIh/LOY?=
 =?iso-8859-1?Q?YapGFXyqi4MwOoP9JIsK+NrSCFZtQJXlBTLmEkO3LiGCRsBQknuZs1sPyE?=
 =?iso-8859-1?Q?Ptra1SzFmJmKFO32W0QMhPTQElj9vBrtnq0yf098e61eT98y/Rdf1QI+W7?=
 =?iso-8859-1?Q?HxuWgGTtiSR+iUc2N2Qq5jHG3dd9qt2Oig6nJib2YKElCnK4ItPvcGg81Q?=
 =?iso-8859-1?Q?Cz3GnbRL1IZyvN3iaLtgoD91M71YJiGL3mfNSNRHaXiH4XMvH+MmAMcEve?=
 =?iso-8859-1?Q?Q2A5hhH0laWU3psQ4W3K1B7CRz6mdFUO/T05M9uFjfLEY369HPyvPeS6DR?=
 =?iso-8859-1?Q?GJDF4QMSRblkRQDik+Z1Zek0zJrjLGeQLYPvh79MqDzsDX5/gvC6LrZZvl?=
 =?iso-8859-1?Q?0xpIw5z2H82UUP/X0nkCu7altTDoBuDosRmpmE+Yqf0Q2Oyy/lswIlU0KY?=
 =?iso-8859-1?Q?QEhm3j2zau0wZtuS1VRR11N/sazSw93gFGZjCg8yP4sm70/CKDOSFXK4yl?=
 =?iso-8859-1?Q?SD8FntqG6oEUConMhrBqA1zgfgVUWlH/FW71JTZswHszyJajKe1SbUPDMl?=
 =?iso-8859-1?Q?cNPEhXZjRCG0Qg8a1wu02zZ6/WYlNavfoFG+IK/ThxR0gsvKLvEZNw8fdZ?=
 =?iso-8859-1?Q?J/TUb+idKTXuz+u2JHRIxb0I8usB48/GGA0QulEY5qtSyzIPA9CnQbQBJ4?=
 =?iso-8859-1?Q?leWUsP2VFgT3rnA8467iLMfUi+swlyKY8bC9shs2Y8q8KlfuJYb4ruuS44?=
 =?iso-8859-1?Q?6ReUIUN7C5pMqn6fIGWz8p8YVL5Dsdr3K5exAti8iMOoAr3+mrBDYViXW4?=
 =?iso-8859-1?Q?qBAfxuJSgkHIlAV/BZfJuzZGSyDoI9YmHEukMmekCp2V8HZhRZeN+o8b/N?=
 =?iso-8859-1?Q?HboaVKlraKNQBBCVt8db7umqYYkqHLAcn1XGCoehduqjUT7C3Xe52Sqyh6?=
 =?iso-8859-1?Q?G7OYb//FfPCHlqIrUColP4rRqCcLDWnP7s7RbKBmwuAQ5bc330KmTy3a5a?=
 =?iso-8859-1?Q?RpnUWtUXSw6Mtm3OpYtK3ylIdacrMVQqgBW3S8T/LqP7Fwb8TtlhGrWTvA?=
 =?iso-8859-1?Q?qWJ+YRqEUnrCoH/Bf8AndnXSY+WL0sjsd4GSOdRvwbLT1fv9MhRxIgyYOr?=
 =?iso-8859-1?Q?n7mxyQ2tPPgFenETxo3Uz7i69T9hO5AlTyZ2ZG4xbqm3RCbg2u59LsIoIZ?=
 =?iso-8859-1?Q?JHkj9EqH63g+5P/GGH6mGgPuVALLmqc8nrKq4Y0Oi5jWjjU3WD4lpGJMMw?=
 =?iso-8859-1?Q?cabh9sHyxPsCFZMxszEXTl224Wufly9E2ZgG3257yD8bh8SxzjIzn3QcnZ?=
 =?iso-8859-1?Q?paE75lqZiM3iWubmwjLkc+evz1NHu5fZ8Z7XbYQITnkRhoR5ZZJseGK0k+?=
 =?iso-8859-1?Q?uDpfJ4Hsd4WU3ngiLOJq9Jnvd87My5CehNWpMhMhCIOBC5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e1538c-038d-4f62-f174-08df2ad54832
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:59:24.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZbZniYNYvt5vxtCma+w2GrB/EDKe2lwIk7xyl8M5Dy3Zy9fAqgVY6sUZtGLYQAvq+VQ1rNJOx8Fj545QvR0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

Hi Tangfei,

On Thu, Oct 15, 2026 at 08:47:12PM +0800, Tengfei Fan wrote:
> Sorry for resending this as plain text. The previous email was rejected
> by the sched-ext mailing list because it contained HTML.
> 
> Hi all,
> 
> We would like to discuss how RT tasks can best coordinate with sched_ext
> for cpu placement, cpu balance, and sched load reporting to schedutil
> governor. This RFC is intended to continue the discussion in email list
> from last LPC[1].
> 
> One of the options we would like to explore is allowing sched_ext to
> schedule some explicitly selected SCHED_FIFO/SCHED_RR tasks.
> 
> We received feedback from Changwoo that the issue is valid, and in
> LAVD sched-ext, they tried affining RT tasks to a limited set of CPUs as a
> workaround for the scheduler placement, but we do know that it is not a
> flexible enough solution.
> 
> We also had a discussion with Andrea Righi, that he acknowledged that
> he understands the scenario and current problem, and he would suggest
> not changing the current core scheduler, but instead using bpf ops to
> bring the RT tasks under the sched-ext control. We are trying to explore
> more on this path, and welcome to suggest or comment here.

Yeah, we discussed this with Maria at LPC, thanks for the follow up.

Essentially, my suggestion was to run selected tasks that currently request RT
scheduling under sched_ext as non-RT tasks. You could retain their requested
priority as metadata and let the BPF scheduler implement more controlled RT-like
priority classes for placement and ordering alongside the rest of the workload.

For example, the userspace part of your sched_ext scheduler could manage this
classification. When the scheduler starts, it could identify the application
threads suitable for conversion, record their current RT policy and priority in
BPF task storage and switch them to SCHED_NORMAL (which will move them to
sched_ext). And it could explicitly exclude critical kernel helpers, IRQ threads
and any application threads that genuinely need native RT behavior.

I would avoid making RT-class tasks generally eligible for sched_ext. The
sched_ext core uses FIFO helper kthreads for enable, disable, and recovery work.
The enable helper runs as RT specifically to avoid starvation during the
transition. A priority cutoff may protect those helpers, but it does not
establish that other RT threads are safe to move. Threads that genuinely require
native RT behavior should remain in the RT class. For threads using RT priority
to express frame criticality, I think a classification within sched_ext would
give a more flexible and effective way to coordinate the whole workload.

Thanks,
-Andrea

> 
> LPC topic:
> [1] https://lpc.events/event/20/contributions/2561/
> 
> Slides:
> [2] https://lpc.events/event/20/contributions/2561/attachments/2025/4612/2026_LPC_Support_RT_tasks_within_sched-ext_.pdf
> 
> 
> Here is a text-based description of the main idea presented at LPC.
> If you already have that context, you can skip the section below.
> 
> 
> Background
> ----------
> 
> In most of the Android gaming, video playback, and livestreaming test
> scenarios, non-RT threads work together with RT threads to construct and
> consume a frame. Finishing the frame on time without frame jank is a
> key performance KPI. A balanced workload across CPUs with fewer
> unnecessary CPU frequency bumps is another key power KPI.
> 
> More specifically, taking a gaming scenario for example, UnityMain and
> UnityGfxDeviceW are the critical normal threads that have significantly
> higher load and usually run on the most performance-efficient cpus in
> gold/prime cluster. Other than those high load tasks, the other normal
> tasks mostly have similar workloads.
> 
> It has RT threads like the display HAL tasks, SurfaceFlinger, and the
> GPU related tasks. Those RT tasks have workloads comparable to those
> of other non-high-load normal tasks.
> 
> In our tests, sched_ext runs in switch-all mode, with
> SCX_OPS_SWITCH_PARTIAL unset. It schedules the non-RT tasks
> covered by this mode. SCHED_FIFO/SCHED_RR tasks still run in
> the native RT class.
> 
> Below, we call these non-RT tasks "SCX tasks".
> SCHED_DEADLINE tasks are not part of this proposal.
> 
> 
> Observed problems
> -----------------
> 
> cpu placement:
> 
> In our tests, RT tasks can run on CPUs used by important SCX tasks.
> This can cause the SCX tasks to be preempted, waiting longer to run,
> or lose cache locality.
> 
> Here is a diagram for easier understanding:
> 
>         RT task + important SCX task
>                     |
>                     v
>                  same CPU
>                     |
>                     v
>               CPU contention
>                     |
>         +-----------+-----------+
>         |           |           |
>    preemption   longer wait   cache impact
>         \           |           /
>          \          |          /
>           +---------+---------+
>                     |
>                     v
>        SCX work may finish later
> 
> RT tasks have higher priority, so the preemption itself is
> expected. However, from the whole scenario perspective, better CPU
> placement could reduce this interference when another suitable CPU
> is available.
> 
> 
> Load balance:
> 
> RT tasks can be scheduled in the same cluster of non-high load scx
> tasks. This can also be a preferred placement decision. While the
> load balance within the cluster is also hard to maintain.
> 
> We sometimes see RT and SCX tasks on the same CPU while other CPUs
> can become idle very shortly. We need to check whether those newly
> idle CPUs can pull and run the scx tasks. While if RT tasks are also
> in the same scx scheduler, it is easier to make decisions from a load
> balance perspective.
> 
> 
> sched util calculation:
> 
> We also see a difference in load tracking. Our implementation
> uses a frame-window model for SCX tasks, while the RT load signal
> in our setup uses PELT.
> 
> The SCX task load is flat and steady, while the RT task load
> sometimes spikes. An unnecessary CPU frequency bump up can be triggered
> by RT task load spikes.
> 
> 
> Why CPU affinity is not enough
> ------------------------------
> 
> We could use CPU affinity to keep RT and important SCX tasks
> on different CPUs. This could reduce the time they compete
> for the same CPU.
> 
> However, CPU affinity is fixed and strictly limits how tasks can move
> between CPUs. If the number of background tasks increases, CPUs perferred
> for critical SCX tasks may still have spare capacity. With fixed CPU
> affinity, non-critical SCX tasks cannot use those CPUs even when doing
> so would help balance the system load.
> 
> Ideally, the scheduler should be able to choose CPUs dynamically as
> the load changes, while still keeping tasks within their allowed CPU
> masks.
> 
> CPU affinity may still help, but it does not provide the
> flexibility we want here.
> 
> 
> Possible options
> ----------------
> 
> One option is to let sched_ext schedule some explicitly selected RT
> threads together with SCX tasks.
> 
> This could let one scheduler choose CPUs for both selected RT
> threads and SCX tasks.
> 
> For example, if other cpu is idle, or running a low priority scx task,
> or running a low load scx task, an RT task could use that CPU instead
> of a CPU running an important high load SCX task. This could reduce CPU
> contention for the frame important KPI and help balance RT and SCX tasks
> across CPUs.
> 
> Such placement should remain a preference rather than a fixed
> rule. It must respect the RT task's priority, timing needs, and
> allowed CPU mask. The other CPU must also have enough capacity.
> 
> It could also allow RT and SCX tasks to use the same utilization
> model. We would like to study whether this can make the load
> signal more stable and reduce late CPU frequency changes.
> 
> Another option is to keep all RT tasks in the native RT
> class, but provide enough information for the two schedulers
> to better coordinate CPU placement. However, this would also require
> placement and load synchronization between the RT scheduling class
> and the sched_ext class.
> 
> After the LPC discussion, we'd like to explore option 1 and use
> BPF-only hooks to achieve current needed RT tasks within scx class.
> 
> One option is to have all RT tasks with a priority lower than the SCX
>  helper thread go into sched_ext.
> 
> Migration thread, sched-ext enable/disable threads and IRQ threads need
> to remain outside sched_ext. With this option, we will need to verify
> more common scenarios. We can explore the first option first.
> 
> 
> Open questions
> --------------
> 
> * Can sched deadline can used to optimize those scenarios?
> 
>   It is possible, of course, so we put it here, welcome to share the
>   possible configurations of which tasks goes to deadline. However, here
>   we discuss only the topic of plugging RT tasks into and out of
>   sched_ext for these scenarios. For different scenarios optimization,
>   there is of course no single solution. It still can have different
>   scheduler optimization to make a specific tasks a different sched-class.
> 
> * Other ideas?
> 
> 
> We would appreciate feedback on the problem, the possible
> directions, and what we should try first.
> 
> Thanks,
> Tengfei Fan
> 
> 
