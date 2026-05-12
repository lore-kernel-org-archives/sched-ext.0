Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18E2EB5A6
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616516; cv=fail; b=OIJoYeMCaYrH1cwV3W566/RbemMd0eQ5+D0aIkXJmv71Cidw6l/MlciGNe0gosNQAGOYVHgppffBaQHJzTPAV0yhtSOx4Be5p8lCT/YeGODX1c0PitR1VylCtEkrigy8WPvtqlYR7WAv0UMhMqEc/IiLC3QjRbR1LpwuG/ONZSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616516; c=relaxed/simple;
	bh=sObEsNukDNhqFxjg6H3L4OLQFi3u+/k+WAfJ1cjALCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7eHe4ecFcW2Pxyn2IiiNYxgmOTOa9twXHL8F1dMfvjy/A7uu7TrMKH4be6rfU8Gh1U5KG/pit4MQ+9oy49F60v/2DVjX3JNjCglLtikoXHalXeMXdNrXI+6wneu+M9i1MbqUMkljsHXlgXoWGd8odFMAF2yfSzb3L3jZyta+oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZ5HH1k0; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZ5HH1k0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdNZ0Opyjs6SX+YocjU5mQ5aX2kwmn2lizE6k4cQU+HIp0AZnymvGOBxGUXwJMhkO8nth+KURrwUlYT/C/LETFLK6BpHImJpjXNOYzXq4oESGUtGvQVNOC1C3+5AONA79BegcHoYhEmIBnniFRD8AZcomnh/4T6RnxnrIj5/RJFAGpxeyxp62+VyPOKuRdCMPjOK29juXKEbvBEPLPA6lZDJJtmOdSETznyYDoLNTdB5yAzrgi2BrK0/cATM3a9vu1YDYSOieIkX01Y86SLzOg6jpmJ4V9ZAOyxfzY6DYhr5FG6T05o75jDkDzeCaDf/3sM8zL3aE3yfBLAaLJ4iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzheuQ39HEpeMGfcvEIUMaXPXBX2IfOliLjLP1rG7es=;
 b=jF7k8Z6CRR8JPkY+uiwefcYNDaZs42xdMHsVMCza7AWWJU9SW8uUGz8tU9R9aJ1QfBw6woUZ/qVtJmtCRskamQujUXHNxb7nsDt+Dg88ttbKFJYeBz7EExESzi+eDFlpOcilkh+7F2nBxVwkCNRAmazmiKcU0Bza1Hsz/RKoINxHaRCETvWYMlkxVsG/Gvg1sDHoBTRjcPQTXUOuJsXnMdrblHZMiy+CQg+5gvTmb+9pV5VmArJ+qqEwpJBkjeWr33qeG3+t9ROog1/Sz0x22ItE9d1tji2z2Lsksnz+k3DQOT4BiEftKwn447V/mp9Mc4VTm2lU2wBpfhZ5p1WlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzheuQ39HEpeMGfcvEIUMaXPXBX2IfOliLjLP1rG7es=;
 b=rZ5HH1k0HGZgku+0ePqvoD1ZawzlmnLV+WPgOot+CMzf9gultLVSpdxssY1f/LWl0JdjrBdS21Zw1AaL57p/MP+XFUrxsqo+du+WxYbWUzDv8T0lrwJ43Q+4HsJreVLE9ZSUTFixT6HNSXxgXzFvBrHPI0WJoQ2bvmaT0kbn/VCdwNl+ErVzbCCxmaZBKaB++XkZqlu6Y6WGgU4uARTJ/mY+DELntWD2JnwLvcoEW9l/d9smpu4n6RjtOnWUNSWpM+5IVZBiSOKj7iTYyK+t27YT+bTJbU2eLmQ33OKfy0aVh0oaksJnBiLEeY4x1DdPFqi0AqWLJ1N2I79aCop/3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 20:08:29 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 20:08:28 +0000
Date: Tue, 12 May 2026 22:08:20 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, sched-ext@lists.linux.dev,
	emil@etsalapatis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Drop %NONE early
 return in scx_disable_and_exit_task()
Message-ID: <agOItIWJypCx3o6z@gpd4>
References: <20260512183018.705960-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512183018.705960-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2e7343-19a4-4a88-0d77-08deb0623b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EO9g3VVuCv76Ah5TVF3DJWkcyrfnwE8dcijQStQsEdPvzijYxMo/d3B1PcQtAaqOCu0T7LcJrmoiZfu0YQgWlcOzEwj1+S0m9ZMoVpNmM7f4ZIVoFzEdFr9Mox7UYgt0pMfhrQhznpr7AI5Ysdm3hU+Int6U4fJpJhYa7XRIBLIag1N57W4XsaVEEqEUOtmmnUbh9XpL4DF/NV01oWhoNOHymH6ODTjenkQCk7f0++hlmdQ/Y8yvfn4xlyy5tQOIbMrVM+sVjFZ4tIoGQuvzB66YCQCMbSem7GlWC0se1w9LPFBDJm1PgiB6oWnuj0dL0CFdr/2970yeURvPO3EQvpFP8AR3LK6Wf9jMTtEjfNA3n1kA2ibrD4kMmXxVj0IK/p6HPU2TazTlJAI6LKTX7CEI6+POyuaZJDC+5QmqSm3FrFv8Ybm496LtDUFjOk5rMy2k4MElyQXtGus6V4Jkrk/TGHEOnJEN/CalFdNY4s3eHwqY580Z6QQduosfxJIiie8/JD/wpiMfOVTf2K4hTyggRTEQk5Qpd3Uil7ulH1IrrwfpvlLKGVCuPD/tRtATnVEicMdBy3X9Q3NbsBy+OFO5M7wjDxV+vc9VyWW57X+NDO+0wTNgmJ9o7Eka8PKx8ApM7DitiYq7Hv9knNDzU3dWHON1yG8W8muVJ/Jbjoq3DqJm5ITQ28a11p22lmWC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnZswk8qMyQ07SO/uVON9LIqk2TXc22tbGwCql+NLkhsTtEql2T7jg021iiX?=
 =?us-ascii?Q?m85YATmDUDrU75VzymcORpte6dix7I3Cb/Tz0ULouhR91jsGXwHKh/itPeSW?=
 =?us-ascii?Q?hHV4UgMPrZUfnTAsyGMZ8owaFYBpA877Zm1KPpivd90MC2GuhJmwmi8wcNu9?=
 =?us-ascii?Q?Y4RecsHUV3/GQoJLcgnldbYk1q7WSnkyJ2xZ0tj/TDbTowgvoo8hTBQenChj?=
 =?us-ascii?Q?2G0O69SMbcA3dLoDPA6ZDFtNmGfUa8j6g0ndRELlKQV6su4lR3VUE9Pxb8sS?=
 =?us-ascii?Q?8TPBMOgtkdlb/oyjDuZ8Bx9mLVMFxZeTAbKBOUJmrGnLyRR+6xY1t8YVX6EC?=
 =?us-ascii?Q?pd6DcN+08ByWaeKvLdZcalGnywNc56XQwYzkSxZF7ZZ6hjh19gZ6CZrerpw+?=
 =?us-ascii?Q?vH8DhHYHxZBMSxnO6MZqbUTqswOO5Z6YPJPr+bPxns9swR823OO5K2R/7bQ8?=
 =?us-ascii?Q?AL8F1NIWMpRIbsj7EHxKJgL7NE21wS1AcQII2Cpwwq84jbSqnWDU60VBdkLm?=
 =?us-ascii?Q?r/wVFNgDv3J+O+GIDdqMnnj5NvTnKNN2JzOUINCXQIcWuUFwD+Ien/GTRHET?=
 =?us-ascii?Q?fR8JsNM3ZAORNjGCjWl5wZGnHBzU2te111kaT39l9R/Org44JB1dG4RiILtt?=
 =?us-ascii?Q?nyOxpqyUrRnTIs3DYBzVIK0xZr/K5mshcfQqrisabPxruASl3fr8ISKCqQm6?=
 =?us-ascii?Q?GY7eXrbWtPycUZrpCMhUmonhnD1oxUQZIlmaBPAOlu+inGp7s3XMdqX2luEu?=
 =?us-ascii?Q?MIfAq4Ybo3aEqW4ja+x0Xzem25esbK7k3qsT0YMNhXpzvBNPJrFYGpsC1Deg?=
 =?us-ascii?Q?k1eq0qspQJDMK5VpNCBMDixfv1SCUsgjd79zeceaN5w9Qn/R0mV0B+8BsMVE?=
 =?us-ascii?Q?xDPlfer/m/Xf6NZJ7+veT30El4mKTJOmpvYMz94ZY0T0Y6Sxpe5o51r2Vb7B?=
 =?us-ascii?Q?OYH7gz/kSCKIrJlG5SE6wui2+SFpAGDrIH2cjKNvxGvkoRuD2wNhTEuV86Zs?=
 =?us-ascii?Q?ETtqrnZBtk1lpnStY5/Pm4FTEvZl8SLgPTzQtoqU6MsjiCgGnjbWSz4Bo49+?=
 =?us-ascii?Q?OdnEa8rNh9FshJGLL8tSB5Db9cCjHg4soP5IeAVAgY+vw2ru2QemrtVbsuLS?=
 =?us-ascii?Q?ToYjS1NV34X9XgrQN7fAjTSr785P/thJesEp06MDYMSuMj4NL55Nkp+seuR3?=
 =?us-ascii?Q?QBjGUJQJEqgOgSkSOshwZjzQptiYtywRCe9Dn+SM5jyWSz/GWDD65yZEiBBY?=
 =?us-ascii?Q?EUd9+xKXnzxKS0ZUzFsaaqpmTypZjOHrn38BlIXIQFcU5+UJXeUJgbEUyche?=
 =?us-ascii?Q?lfeZe+LBVzxzJCwWw2D+5vzoNQyB11Orgp6n+xK0AD0bFWr+RqVRinTQJKpO?=
 =?us-ascii?Q?NiRqnbphwQmY2UzCtVMfbCcm8Bnu2KDHM9KqFGYWvazBhx8mwwKHBjWg59Jx?=
 =?us-ascii?Q?fr8cPXfHzuPL1pfKIPkI7eIIGn8+BNYGWpkBPET/vhpqta+/27nhla7c8aap?=
 =?us-ascii?Q?G7OzScCDbfFUuzFQAcGdxSVU+aMy+nUwZXLbc8XzmiJY7bObs3wV5yWjcfrD?=
 =?us-ascii?Q?0lilvfrbcpsvGmh5TuZAH4StYtWCB4GT/pAaKViknCT0iEXdFmvznM5d8Q5a?=
 =?us-ascii?Q?osOruboJbTjK8haBJ1j0y0E7xTPl2oVFVIDBYWnPc0V5U6O7qlir8kSP1f1H?=
 =?us-ascii?Q?/KBe/dfxpzy+AbVbfaT87y2H3+BmqAMKmB6nKhYen8r1ZRrr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2e7343-19a4-4a88-0d77-08deb0623b94
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:08:28.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGZHvtA3MZxaBNbZqy4RW80fuHRWrDqTaUEmTcp6ZhVjFZYDl4nAbXN4z7XxIKkEowsGOjkxSl0l26bdRbEGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

Hi Tejun,

On Tue, May 12, 2026 at 08:30:18AM -1000, Tejun Heo wrote:
> d3e73a0808dd ("sched_ext: Handle SCX_TASK_NONE in disable/switched_from
> paths") skipped the trailing scx_set_task_sched(p, NULL) on %NONE tasks.
> After scx_fail_parent() parks a task at %NONE/sched=parent and the
> parent is later freed via queue_rcu_work() during root_disable, the
> preserved p->scx.sched dangles - print_scx_info() from sched_show_task()
> reads sch->ops.name from freed memory.
> 
> Drop the early return. __scx_disable_and_exit_task() already short-
> circuits on %NONE and the SUB_INIT block was cleared by
> scx_fail_parent()'s earlier call, so clearing p->scx.sched is the only
> work left - and the one thing the path actually needs.
> 
> Fixes: d3e73a0808dd ("sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9354da79e162..8861b2deb504 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3703,15 +3703,6 @@ static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *
>  static void scx_disable_and_exit_task(struct scx_sched *sch,
>  				      struct task_struct *p)
>  {
> -	/*
> -	 * %NONE means @p is already detached at the SCX level (e.g. handed
> -	 * back to the parent by scx_fail_parent() with no init to undo).
> -	 * Skip to avoid clobbering scx_task_sched() and writing %NONE again
> -	 * on a state that's already %NONE.
> -	 */
> -	if (scx_get_task_state(p) == SCX_TASK_NONE)
> -		return;
> -
>  	__scx_disable_and_exit_task(sch, p);

I was wondering if a task here can have both SCX_TASK_SUB_INIT and
SCX_TASK_NONE, because in this case scx_sub_init_cancel_task() (called from the
SCX_TASK_SUB_INIT block, further down in this function) would be called for a
task that never entered the sub-sched initialization path, which would be
incorrect from a task lifecycle perspective.

But this should never happen: SCX_TASK_SUB_INIT is set in scx_sub_enable() on
tasks that just successfully passed __scx_init_task(sch, p, false) against a
child sub-sched, so those tasks are in READY/ENABLED, not NONE.

Maybe we can add something like this in the block below to make this clear:

 /*
  * SCX_TASK_SUB_INIT is only set on the sub-enable path, so it is always clear
  * when @p reaches this function with SCX_TASK_NONE.
  */

Apart than that, LGTM.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
