Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB634A3DA
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243167; cv=fail; b=NraNonZKssWypwhoP8R9/oysxAAouiUrYLvtVtzAPMnb6eKLv2QiTN+sERlGm/HDJGz/d+nI8VWN+AZ+0xY8INGYNVDMH6M6IHQkyBDVP4Fpeuc5PtyEriO+prE9/CE6/m8sS/wZKwsSRRMvu9Q1+zwNL/GLubcoCgpkJyGQG+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243167; c=relaxed/simple;
	bh=CQ9IX9qpzbrDhkFpOCWerXc7XVBvB5lUL0tchWgJ/44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eaeelq+52GvtZLcSh8HN6gkhAV61+uovdqF8O3R6OJrAdCNTekgSWaD2fGruBXGLQYEVPExaBGZJp/Pt6orEpL3begT9Ua0TRc32fT+LzjLOpHnCBGaDJ0mKkN9vOGitC8hXt5mDAYYRHEacOBA1MlD7R79+BrOuldg0kT9KYDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j862gJy+; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j862gJy+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3uRQYSwfgLW/pqa+wi6gZtjcs28fW2G64bu/1wXAKntzElqxak5kiu6RVDyifq29+w9t+6WTkMUmRRl0ffzUJHX5zWXASJXNd+NORzg8yGpy0oibJN3SyY6/oolBx/9QiAYH+GOlarVHzxCY8rakiq6YlOc7ReEnDmSEoJ7PvXBm5NEiWralueGBvNgndNsA9JrK6Io2KSqyxO7b2PZcKOLTLeQsF8Ej2R/y9jhDU/sUTGulKefiw5JSkvaaC6jc7hkpKxp4mlTjA27R9Pqm0J1CjhCH5qrDLTyjRrWx1D+UREaTUi3T0VjecxIQhZOevvuIZm37tToSd6Z8CUqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LpjExh2RENivOvKZiCxBCjXp6dtu6O2uIgv0VRg8tk=;
 b=h7wz4Xr2YpunEhGQyfTfbLJVWOYw6ut6k0wMZMzb6Nks5Ojxst81YzETIy9UYZCrhMup4DsQ3UjMYtKGeynfUtoFt42bEPUJGY0yxrPWLEZOF4QGIOvAAqoLj55Xodo8AfhLU5OzOL5J2cz9kOJxRZUMJ0QDQiZV756RjQ8bJRWSG/0F7YvQVfMEU8ZDyG/n6ZWJjhgKOk1rpuMxVx8ZcNErCRBhgwqlCglknhBmex6RdIZ9RwipngROZNTbfuzEsHBnwt84x0M61++Nx+Oqgn4mn+KkKsj34mzFpopppGpa8wY/FTHMxnWsWaCmWFHmgwSAsmz/ZEeBNR4Nax/O+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LpjExh2RENivOvKZiCxBCjXp6dtu6O2uIgv0VRg8tk=;
 b=j862gJy+o37UuC/sV3MKRWA6YODYGHi3ltz6ONCahiE0mFeN7Fn+J0GFOJKoqbLxNAiFqCCqaguT2qcpSILw+W96EfIi9IJYu9Vsbm5ExyhU+DDiEoBQx1la96LcTuW/4IV/jNtgYZVKVNlzisDXT3MB9ED394MTl7LxKv2FCUBnMtyZ4KpdY8vqa/CMmFb/NTsf6Hetm9qJG1j8IRJEg/jnKsSqKXzsFWgWbJwemKqtJDIH8/WLKSHlQtzVCPmjXIh1D2bauURp3qThS8oWF5Z8jsnC3hHJWLuvmnau1VkiPnYA68hnIdJ1cron4zZgk+Dg8zaaR5X5RlC9LDVyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 22:12:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 22:12:42 +0000
Date: Wed, 4 Feb 2026 23:12:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Short-circuit
 sched_class operations on dead tasks
Message-ID: <aYPEUNo4oGY8-Fw0@gpd4>
References: <fc034891cef55029c16122f4279e4057@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc034891cef55029c16122f4279e4057@kernel.org>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 172ff848-54db-42ed-ffab-08de643a844c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BygmgdvbAkM2YsdJwIWhaLsKHTeXvxdP1iYaBTEmfpbVD+G3zzaVqH3mhR6d?=
 =?us-ascii?Q?H4J4OhjsrzATc2mXwmCSgXrvBzitVqHWJJv9/OU5Dw1tfYJ13A5JEiPTkfii?=
 =?us-ascii?Q?y1MLNg3kHgoALtzfQ5kQQnHwp9lStGGzhZQ3nGhOp6uXJYZMeuWLELl31mHV?=
 =?us-ascii?Q?7hvxjQGYS6OKjPy9zExRU2L2u7uEQ+MY+QvQK86M5J7YmtFEFsrEpv0t1Xtf?=
 =?us-ascii?Q?gOw0YPf5KZVvKE9gh7bawh9ZVWk/ig0E9EBYVlWn2Xn0c0mLlm2206WqJ/mw?=
 =?us-ascii?Q?kM7jkqKW/2edCrizic/yfPsQcQZxMSJrjJUTgMWSuSATRsqDH1XEsaIJxNvj?=
 =?us-ascii?Q?bYX4iYSXWwp54RWN2xks7my05PmF80XjJ0bpX/DhRs0KSC28lexboCDNM2+3?=
 =?us-ascii?Q?T4lV21ATIeyEzoY1FEb7ycon82vOA/Gs78kFo/OKnrDl8WwdLaAKn6K1cImC?=
 =?us-ascii?Q?e+FH75MYezSnEiqQqo8BdRMkXKPBJU5U+J9CEo+aMmPy89yxdOHvphSKchKO?=
 =?us-ascii?Q?SSvseu6Ne8qjzx+U/R1xJKc1zbGyCdiNCXvV2jmVtSTQIlO0VhlxefAvKS7P?=
 =?us-ascii?Q?Y50QzicwfzFXhilukd5Pk6k8xLHD2DWwtLyezp7kFpxd3CLxA80Y8EEnBGgU?=
 =?us-ascii?Q?DDVZnqkicgbN4Ajexrq9qziZSzgCQY99005EygSLZNUzEH6u2Q7jsl0ry7bC?=
 =?us-ascii?Q?JOK1a70RQN9y5vRCnyUnGOAmV5Y2HL//UsYL/uF+CUHei66Lpqvsr7V9hHLp?=
 =?us-ascii?Q?nz5i0hAvzrDqywS5FaNKIoN5qmNRf2fRW1sPcL6KEa4RS9f/qhr67o6sUZYT?=
 =?us-ascii?Q?oChSLb3PiMs+G7b8KMvx6ir4UuLOi0Ofe6z7AyVexf9Ut9Q5F44uF9P/9ROz?=
 =?us-ascii?Q?ItLGPp3deJlgFgMJWX2NPbsD7XtNubEu5/04IxPSmT7bDQhrZDHDcfQHN5nF?=
 =?us-ascii?Q?0Hp7j43w3BVaNMpurPMcTyhuulYn2sFTpaBS7PSFAGd2qok3nLFycqsbnuLU?=
 =?us-ascii?Q?kgkUeool0v40WNQkpLjWSTe77mA60KhxVrNzxjfWIz2ukoIoR/TS5CSu4nZt?=
 =?us-ascii?Q?RKMAg1vI9OoB+otjibkOCiUqBJ6wGKOmpGWuAaEDBrI2rpCA2sk/RupYAd8J?=
 =?us-ascii?Q?xDrX/UAuGSS4CwS5uhKYTjBXgFmtsRZfpkdvfTtPoizevsMqJ0wsCwF0rxgu?=
 =?us-ascii?Q?mF1LofpKIU4qpXNKr/9nUtC8SxiLE9sukIZeofq2kaUXsmi2opItqoUiBAlC?=
 =?us-ascii?Q?0WyQzcQr+uKOWoi/iXqWSFgqy/tpC95akx/yVmgohA82ITWSWJ6dqBIrNLad?=
 =?us-ascii?Q?Wisvv9C/qSF2wdbdY2sdLk+VOkf7UuHv0sQT9L1xU3D944bK7onUEr7GBLnc?=
 =?us-ascii?Q?C9UH+92VpLtfvG0XD0Uszz7CtO7lX+si9mfT0LF6neOk9ZYWWGiDvm4bT4UW?=
 =?us-ascii?Q?h1PI0o5tl+qkgRlLXu6IJnf3aeeiAIJ7U3O2sV1MWadLt458Hxed0M4qleu+?=
 =?us-ascii?Q?xS8khkFyqTPAfKQNi3tAIHeo8jH3wot8o9DuEpBv4xiP9f0vLHbjQnrLtlCa?=
 =?us-ascii?Q?nmcxch+WOI9Sv9wGUZZ2JSuZhIQ2eeN/1rCh+ve6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUCVR9LevMaSpxRkyjmTk8GAdgDXLGC3OKzyQ9pJwf/qBf5EviKxrVHgPyqn?=
 =?us-ascii?Q?lOrIarcTOlbFFewmXB7U8rEptwvHI9Tu0m/WjsnGU/JGqIZSOHYNWCU9/AqV?=
 =?us-ascii?Q?5EiOl0bKbn2OzBxfGNpotudV/+5ub47VU4J3fDNwm47aDBQF/VWPWGBfntm5?=
 =?us-ascii?Q?lkdkwemPdbFs1aldEvnoj5UI2GuN7N5eKHgY4MiVIdmj2py+4BYOl0N/nLns?=
 =?us-ascii?Q?8ZtUWZ4thTlADBWGXPOiTvq/3hfwqmdwqgVDClcNC4iYkKO9qpKRhCx1N60F?=
 =?us-ascii?Q?5e7yFLnitIZ2d923D9JIBteXsadTDv95AFO8Fv2okRK5MDuWoPP1MNQLIF5R?=
 =?us-ascii?Q?HKPmt/UXhnHZeXxYBDB8lEMu/DsUu1bdizxtN5eKrJfQBZ9a0LRjo6L5SDDf?=
 =?us-ascii?Q?pzvjRTzx6rlKuUaoEtf3m4eaPC3Imm70d7E+YIPX+jCreYW+cL6JEBb7+AWc?=
 =?us-ascii?Q?hNoEuaXwNv6lkiUwX2qJVp7y1J7sQV5FntgaCMYAztemlay4gKjSvcXKu/rL?=
 =?us-ascii?Q?PPcFs8xISOl8rrlfmdGazUI9xjbQhzLJ88+CHiIAimZXyGSKqhrWRunwxHkS?=
 =?us-ascii?Q?7fYO+xttJ4oTLAeVUZdq+CICorysQ9+piTwAFNP2asBEzLlT5RpNCHVSb0fx?=
 =?us-ascii?Q?fFEkQgm9fTBJCHODd2aYtMcJ+4TkJk02LY1iWmIeJqFZn+xKy43KxyWJ7B4s?=
 =?us-ascii?Q?N3Mk9it6ngo2HM6wRcdnbppAGbvyxdDHy3N5T9+eB3uUkS4NMVePxfwhRypI?=
 =?us-ascii?Q?nbDfkMGcLcgXevVJfjgBa1R897VByOhuFG5C8HeCTnjze22Ft3rWo9Lq1Fdf?=
 =?us-ascii?Q?0xYZ8/eXkYFsUAExhbywejF9iSu4icM1GxluIlxicJ8bsfE3kN2FtaFwXMRq?=
 =?us-ascii?Q?Hl8RMKl/S5OkvpcpUQJXTqZ5yudgoFyGt+wFQtQPNEqNbr830720KR6cdEna?=
 =?us-ascii?Q?Usxrf6Xn0dOGl3N9dkuQPRX8zkoKa3tHOtlarQagQqLfNeLILdtmKmhMQcVw?=
 =?us-ascii?Q?VRTQlO5bGMfO6Nt3SxB1fl8GfedaLTYQ/O/kimf2BMsG4t0P+UJ0aH9IlFwB?=
 =?us-ascii?Q?ushaWnGxzoP858hxyzAcZyyBOAcraqo7rQ35lK/IWb7zMM+hghTB/Yc4wJ3D?=
 =?us-ascii?Q?+lfEAnIaGdRzUIRc3LMHGFN/QYE76ACpZ1c0O+AhlmrCbOiFoCiamqmRWFv5?=
 =?us-ascii?Q?WNfckCUfsykkujHImy/SyLbJIaf6SuAejFNjDSrsc75/JmepaZsQiQ4rXCVq?=
 =?us-ascii?Q?+E/yuFzf/Osad+Avg/A0e0DHBqxSLePXyOlOkbEJLjJWauzYA+c8cmNim9wc?=
 =?us-ascii?Q?gIBR07YFo2WN1PlxjsM2Eet/nkeJYwKD7YAUg3dL2u30eA0RcJhgCM8/ogNn?=
 =?us-ascii?Q?LOW7NBjqsT+2yDhrSzQEVLySuUFOdZYq3Cns2SfFdIe9YZYksTg3tz0h3Am1?=
 =?us-ascii?Q?JOpOYhBC79aOxLFMZJhWVICqwlG0+ahH538Fdw9G8hKVgMmN5f209Lvv83g5?=
 =?us-ascii?Q?tioR/quBtmqS1rS10a6KzZGNDDO6v0CTtYGulojYbhoh9C6rIiu2R8ug8LVq?=
 =?us-ascii?Q?3ElLND5Jmcxd17dI/AP6j4V5GHSSFU3tO0BcLmVHp0KABpEHTZbEeO3P5jNW?=
 =?us-ascii?Q?n8Px0bcS5InFIHn0RlNyOIXPCQ6VIAUZkINiglFrrFfL0kjcboGTaHx8WZrr?=
 =?us-ascii?Q?UPLoG5WzCtekSzFLGROt8MLQ7RQRS0J7WL9gJU+OCDH+Lud//184zh2SwLTx?=
 =?us-ascii?Q?HKO0UlIgAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172ff848-54db-42ed-ffab-08de643a844c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:12:42.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFYKEyQyD9F1qwPnPgyUsn/dMCqPlRY5EjHGGfKyKjKme6hkSpcGdHTZ7kkT+9jRbTd+k84xCwwWSUARagts3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

On Wed, Feb 04, 2026 at 10:07:55AM -1000, Tejun Heo wrote:
> 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free()
> to finish_task_switch()") moved sched_ext_free() to finish_task_switch() and
> renamed it to sched_ext_dead() to fix cgroup exit ordering issues. However,
> this created a race window where certain sched_class ops may be invoked on
> dead tasks leading to failures - e.g. sched_setscheduler() may try to switch a
> task which finished sched_ext_dead() back into SCX triggering invalid SCX task
> state transitions.
> 
> Add task_dead_and_done() which tests whether a task is TASK_DEAD and has
> completed its final context switch, and use it to short-circuit sched_class
> operations which may be called on dead tasks.
> 
> Fixes: 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Link: http://lkml.kernel.org/r/20260202151341.796959-1-arighi@nvidia.com
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me, thanks for tracking down the exact issue!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  kernel/sched/ext.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -194,6 +194,7 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "byp
>  #include <trace/events/sched_ext.h>
> 
>  static void process_ddsp_deferred_locals(struct rq *rq);
> +static bool task_dead_and_done(struct task_struct *p);
>  static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>  static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> @@ -2618,6 +2619,9 @@ static void set_cpus_allowed_scx(struct
> 
>  	set_cpus_allowed_common(p, ac);
> 
> +	if (task_dead_and_done(p))
> +		return;
> +
>  	/*
>  	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
>  	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
> @@ -3033,10 +3037,45 @@ void scx_cancel_fork(struct task_struct
>  	percpu_up_read(&scx_fork_rwsem);
>  }
> 
> +/**
> + * task_dead_and_done - Is a task dead and done running?
> + * @p: target task
> + *
> + * Once sched_ext_dead() removes the dead task from scx_tasks and exits it, the
> + * task no longer exists from SCX's POV. However, certain sched_class ops may be
> + * invoked on these dead tasks leading to failures - e.g. sched_setscheduler()
> + * may try to switch a task which finished sched_ext_dead() back into SCX
> + * triggering invalid SCX task state transitions and worse.
> + *
> + * Once a task has finished the final switch, sched_ext_dead() is the only thing
> + * that needs to happen on the task. Use this test to short-circuit sched_class
> + * operations which may be called on dead tasks.
> + */
> +static bool task_dead_and_done(struct task_struct *p)
> +{
> +	struct rq *rq = task_rq(p);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * In do_task_dead(), a dying task sets %TASK_DEAD with preemption
> +	 * disabled and __schedule(). If @p has %TASK_DEAD set and off CPU, @p
> +	 * won't ever run again.
> +	 */
> +	return unlikely(READ_ONCE(p->__state) == TASK_DEAD) &&
> +		!task_on_cpu(rq, p);
> +}
> +
>  void sched_ext_dead(struct task_struct *p)
>  {
>  	unsigned long flags;
> 
> +	/*
> +	 * By the time control reaches here, @p has %TASK_DEAD set, switched out
> +	 * for the last time and then dropped the rq lock - task_dead_and_done()
> +	 * should be returning %true nullifying the straggling sched_class ops.
> +	 * Remove from scx_tasks and exit @p.
> +	 */
>  	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
>  	list_del_init(&p->scx.tasks_node);
>  	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
> @@ -3062,6 +3101,9 @@ static void reweight_task_scx(struct rq
> 
>  	lockdep_assert_rq_held(task_rq(p));
> 
> +	if (task_dead_and_done(p))
> +		return;
> +
>  	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
>  	if (SCX_HAS_OP(sch, set_weight))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
> @@ -3076,6 +3118,9 @@ static void switching_to_scx(struct rq *
>  {
>  	struct scx_sched *sch = scx_root;
> 
> +	if (task_dead_and_done(p))
> +		return;
> +
>  	scx_enable_task(p);
> 
>  	/*
> @@ -3089,6 +3134,9 @@ static void switching_to_scx(struct rq *
> 
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
> +	if (task_dead_and_done(p))
> +		return;
> +
>  	scx_disable_task(p);
>  }
