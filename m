Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E847CC9E
	for <sched-ext@lists.linux.dev>; Mon, 28 Sep 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589381; cv=fail; b=McwByBg+bxoAOOrTfsblyejCq117cnFJlnsS8NN5OV40UI49Nl5Rqqf4AGt4U5o6psZqG8F9hFxEgcD/fgNcvOPdH910SPYBCqEqAkpdQPDUwczV8kqu6+gznJLy9J9kPPvlT15f+qUgMPJwORe5+fUR4BjKjk3C6nrX0Mxbjuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589381; c=relaxed/simple;
	bh=QIqHklMevGe6ODzyeExUqSVH1uPq527fdYPC11RiK8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dtUSkAeqwo4IM6+zupHSoZthj26wUw1leTSMhFYJZPAjxr0UAa3tksCTYuto2YedHgq+NPMl81voYy0PrtGSyVI2ie1zZfZIvTqSjDJ5NH4yBTH6ZnWnYptfx7DUquNs6Ue+WS66Cijz8ZmDod8e630zOyFUfoj2bIJaQMJP82c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oaFQPmk9; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oaFQPmk9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMra+uG0qCDlSxl6QQYKO/legceqsh+tMQE5jqv/3o6mf54xHxjiNAwHyBG7iKsw5lzs/HKHrqq+XVZkMQA3EWCrcLBmr4pCsuez1N2Y5wpJwJ43QtZ5ZtRaFCXOX4wx6iL03mEbCNo82Ud1HpZuaCzxVVICMALN43AOQqQlNhR/00tYwm+Id8F6ITEzkntRq+VbW5vwfiSzlDmM/aYUk0X02MuFOfzlhwajyNlZZEiz2sHwMBGv6k/ZRgy9YdGC1LrTVa0MTKFAfHw9s21WN+OaA4imMpfdYg1UlL2KOWyMKPCTvAkgWM4YsgyP1n0LMZkfdwPT0y9qmx+w76kcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWspZCSM2x0jTQdvEHBYdwfoQs+bQFMjCN0vfqifdcI=;
 b=nqSoTmLV+weYsu18jrlchPWyOGKTbxiObvye0T7Ml3suAudLIrbTsuX9kvY52FqSl7zgkM6HEGpfZDk3SYcIxZkGOJmxGVSfVa5NjkqfZCB32dP2Zqix+3tM/aG1DIdd3Jnyw0coD6mnLS3jSXq9lll/s6oql5ROiAL39yudweojvQeN00GGXMi0E4Uox6Tho0B/+SpgJKH3wBH61kdQEblnzag+eQ6QT2wqJ2udtQltW3BPQWwb/QlarcFlyR5Ckl4Uua00mzWAx8Njnaogsl7l8JjtrW1o+I5/aw8eePbkTMD6fUK4bRyYP2TGP4ZE1KgcD53JHPWubLsYHwk/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWspZCSM2x0jTQdvEHBYdwfoQs+bQFMjCN0vfqifdcI=;
 b=oaFQPmk9BgaECos7gOk5UwNwqU7nOIeQoWghUah3XFpOw+6mhjmHHpBQfF2zCeDqzdm3VJKa9ST2WGqL/ywa74sJm5f5hy/oMI5fwrP4yCDETy5dXZkRHTT/eXHc6k4b0EK0vTP0BZDZkunREoQ0o4VKYprStMnkXSjTFXr8YjkZp6EGszgZkRVgsUYi3nnRFUNeBJQbpIX0/g3any+fIjs+s1j989IPn+or/L3eaP8AXfDdVx2mbDBOl8oRe2Uk0mEm8sVXNyUUcwx1wvAHL7S0tpYrx8Jql76HaX6wluG6vKeA5R4BwDGWeBjjcuBg9F+pKrxNtjsfSQiWY5mh0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:56:14 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:56:14 +0000
Date: Mon, 28 Sep 2026 11:56:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, Alap Mohan <mohaalap@meta.com>,
	Joonwoo Park <joonwoo@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix CPU hotplug hang
 when a dying CPU's tasks sit in the BPF scheduler
Message-ID: <aro5tQ5gsoOdHeyO@gpd4>
References: <20260923223825.734003-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923223825.734003-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0214.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 377dad82-9c6e-4de8-29b6-08df1d46bb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	SOHtTD7QHsgjkVGXrJatScnAYcDzJnB+PYRMOZcWQcJhgyfxFUsnw9H0BMHSki8samitax59Sk5cZhOHRsrNNllGQ8UWed0i824CEbPGrs5j0TEmYpBqNAHHgE5p0AMmV88dpTPwlxXEKgWf53DnWDooP/QZIqCL7D6OWgowaL0fcGMk4HvcljDewZcQMcqeH54PppUtRhTwoOaRhkNdM9etD1rBKuf/dQdHIvVzc4/3TCDpJc+G450vpegBWmt67koiBPzOSTKnHDSibXHSqdW0bA9jjVrJaL08DXgLVHCjEp/prFsmHEk5iUWOeFaBicsSi0uxh+0VzPIn3XJvAaOyx8NEJou7unCY6FyhlkKzCl1QW8y2reO4sMYyckoZs8zHP3dF284HPuX/zhT0B1Qc7laLQqBUXbuPbn9g1qYtdf5ArSxif+PxXl5X6zmFw3qisy5qlNnr7i8gIpd8io2HDrVVgesw9508E9jmRGLD4ZBwtSdDS12C/Ahf5avstsEc+bBrHlXNoLbx2EH60+n6wccB1Frg/ezeJKUsPdK693dSWWm9HVSPM2+8isA2Si44nZU3ZVlEYV8P0ojm9hIyNoa/YSqtNlK/kwpLmBFG1IJk7M8mrXQecNndVQ2x/CbIh/8chgkNQ+KdvpzhLlvpvM4RCFdNPfnNy4SyZYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UNTUpg5PeV5ZAvFY0BmEuvVnhjXw9jgt9JegidaZyGhCRpsjxrkbbwNUBsO?=
 =?us-ascii?Q?zlZhMPBk/PCryLv8u2n7gN6mvQtD3CyR3XmOSYJ/xElaiL8oQ+oL02hvYeu5?=
 =?us-ascii?Q?ixDJcOHIGvjF3JXJC97CEdLpOIAiV0SJ2mCQGqWnicwMajWi/ULdXE+gVeOc?=
 =?us-ascii?Q?uUyp4cFS3Bl4i/gxFMvkUiWR//4VZCbpuymX7zLWk+1xiYoxJXlHwDRj8Xyh?=
 =?us-ascii?Q?oos3kQdfwn7fz5XCUiaDJE2tTB/Yfjg7vsMMHsveWgb7SWDU0+t3lyNg59sJ?=
 =?us-ascii?Q?FP8anavEvNn3gv0pqXpc5di2p8FIn5NbG1GRjynXLl3avOvjUQ+/qHhQDfGo?=
 =?us-ascii?Q?C5Xad/rITVRmG4ETq+wwAFRJHyk72UDX8o2BbpUdAfx3BLijKt6szQrPZ3VD?=
 =?us-ascii?Q?pfuOhxW/4eb+Go+wcQMlWCpXgX3E/i48EITHkP1hS3OgL2NhJCqOmPhzqU7B?=
 =?us-ascii?Q?9PLBNk8Do0m6i6N7svvz3/9X17ji7MT+DEHb1eCWGqMHvk5JV/BSIzW2CFZ4?=
 =?us-ascii?Q?dkIMiidOxbUmtQz9BFIiS4Zqkr++YgCODF3lf/CthMlJ2CX7HirZTwdG5fYk?=
 =?us-ascii?Q?zqQkCTfbr1nHsdHSoYbBI/85dI+9M3ObIuAkEWJ1w+l0B5jOiuCL8OLRvUsZ?=
 =?us-ascii?Q?VCDvFtYKf626o9tT4E9eRBBcFWSNVdgMdiodocumtHQOwBrU5zkpaAxJFyxg?=
 =?us-ascii?Q?qh8gTKZKmeikjNyXYCATO8JSNbaZ4TC86YSNjkKFOpZMVuySY6AqSlElgkgQ?=
 =?us-ascii?Q?5E/VV4ola/WWh4oiaR8pfiOLgVye8zcvqgHFqRhJVysCO7PgdRK/I0EJDU6b?=
 =?us-ascii?Q?e6i+dFngKUPgMSP+QH4Y+d83BFZCyBot/kZ4E0KdrkHGl+m4hWXQ2W0ooJry?=
 =?us-ascii?Q?dbBkjS39XmUtgMw365y9ZCg5meIts+SlPvNVMtI/Pswex64ZOe6uiyYlon3r?=
 =?us-ascii?Q?Uedqgtju2t3hdlmEAWqnvTxJjGRQtfEWuDwwy9EouqfqylfxKJw7OPLE60rx?=
 =?us-ascii?Q?msP3ya5eTCzSluPfFsvfGzGEFLyBy7VoUmJTYydsu+Bkd5fJ+SkTtFH6onit?=
 =?us-ascii?Q?DeE7pWW1YrUTffDgFxithZ4R8L6mdQVnT/lyWXSxPZ26xqajtlUknHVtI2AJ?=
 =?us-ascii?Q?q+f0P+/hRI3XTmaNAqHZm9ulQCdflXgfwyQqE7+vNiwLFiTJea6bTxl7l37K?=
 =?us-ascii?Q?vDY/VpH70gtbOUSeRwIB1RXpj+f3ZAxmFQaupujkOEb0CC3RweUV1saVCNMN?=
 =?us-ascii?Q?2IhghjW7QiMJmPQfJKiVPLctn3mSHbowtS0dmO5PK6a4xuFy5HCe8nDLomFM?=
 =?us-ascii?Q?ZhG0wPd9RwxAHsvuax5QUBw9pNd4Lw6IeJJNkqYogG4MF2Tjo7BBl9ChpZJW?=
 =?us-ascii?Q?kr1JENu2dgxjp72ZzCwLM1Sdd4CRn6MROjYhBwz2U7vDXdUbE91ntf3lzOeO?=
 =?us-ascii?Q?b928dvncngl9Yv5QJbOySnoArdJEVdeyI6JcAk/X4w8N2D+yCnEzfMW9OGTj?=
 =?us-ascii?Q?dIL2UGXp+SBrCx08swWlhEU+UYf7ksiYgHbBVbm0Zpkb7GY7wMcHViO3kV9N?=
 =?us-ascii?Q?F/KwBqVROyBGFm/2SnW8XHM0IKBxmPt9kRJraFl77g5b2pdq8550d90q41gS?=
 =?us-ascii?Q?UbB57eiwM14v/SvzMYX51WEb4XknNPIQAlyrgmrC6uw91Ry5b6uUk2ct2SW5?=
 =?us-ascii?Q?lWab4/5R/1p/krpPcGsNazYA1SXBbOAOoVnu1NcUzi0+OpDUvGh4Q2H7N0IM?=
 =?us-ascii?Q?wtQs9AliHw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377dad82-9c6e-4de8-29b6-08df1d46bb65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:56:14.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFoPdCKEi3HEIfX/P3rnVC2FsyN6FJHHmYpWSEx3hQYqcSF9wduTU8pYY/tthgjK/VPNeJFWhY6OzNhaf/H7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

Hi Tejun,

On Wed, Sep 23, 2026 at 12:39:20PM -1000, Tejun Heo wrote:
> A CPU going down has to empty its own rq. Its hotplug thread waits in
> sched_cpu_wait_empty() until nothing else is left, and the only thing that
> wakes it is balance_push(), which runs from __schedule() on the dying CPU
> and pushes off the migratable tasks the CPU picks.
> 
> sched_ext breaks this. A task sitting on a user DSQ or held by the BPF
> scheduler is still counted on its rq, but an inactive CPU no longer calls
> ops.dispatch() and can't pull the task back. The dying CPU goes idle with
> the task still counted, and one of two things happens:
> 
> - Another CPU consumes the task. The rq empties without a __schedule() on
>   the dying CPU, so the hotplug thread is never woken and cpu_down() hangs
>   holding cpu_hotplug_lock.
> - The task is affine only to the dying CPU. Nothing can move it, and the
>   offline stalls until the watchdog ejects the BPF scheduler.
> 
> When the rq goes offline, re-enqueue every task on it that isn't already on
> the local DSQ. An enqueue on an offline rq lands on the local DSQ, so the
> dying CPU itself picks the tasks and balance_push() pushes them off, the
> same as for the other sched classes. From then on no sched_ext path on
> another CPU can pull a task off the rq.
> 
> ops.dispatch() currently stops as soon as the CPU goes inactive, and CPU
> hotplug then waits for an RCU grace period before taking the rq offline. A
> BPF-held task affine only to the dying CPU and preempted inside an RCU
> read-side critical section would block that grace period, and the rq would
> never go offline. Test SCX_RQ_ONLINE directly so that ops.dispatch() keeps
> running until the rq goes offline. Only the dying CPU's own hotplug thread
> clears the flag during teardown, and task_can_run_on_remote_rq() still keeps
> other rqs' tasks off the CPU.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Fixes: 991ef53a4832 ("sched_ext: Make scx_rq_online() also test cpu_active() in addition to SCX_RQ_ONLINE")
> Cc: stable@vger.kernel.org # v6.12+
> Reported-by: Alap Mohan <mohaalap@meta.com>
> Reported-by: Joonwoo Park <joonwoo@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

This makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c     |   22 ++++++++++++++++++++--
>  kernel/sched/ext/inlines.h |    8 +++++++-
>  kernel/sched/ext/sub.c     |    4 ----
>  kernel/sched/sched.h       |    5 +++--
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2123,8 +2123,8 @@ static void set_task_runnable(struct rq
>  	}
>  
>  	/*
> -	 * list_add_tail() must be used. scx_bypass() depends on tasks being
> -	 * appended to the runnable_list.
> +	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
> +	 * depend on tasks being appended to the runnable_list.
>  	 */
>  	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
>  
> @@ -3731,8 +3731,26 @@ static void rq_online_scx(struct rq *rq)
>  
>  static void rq_offline_scx(struct rq *rq)
>  {
> +	struct task_struct *p, *n;
> +
>  	rq->scx.flags &= ~SCX_RQ_ONLINE;
> +
> +	/* sched domain rebuilds call rq_offline with the CPU staying alive */
> +	if (cpu_active(cpu_of(rq)))
> +		return;
> +
>  	scx_rescue_flush(rq);
> +
> +	/*
> +	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
> +	 * onto the local DSQ so that they run here and balance_push() moves
> +	 * them off.
> +	 */
> +	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
> +		if (p->scx.dsq == &rq->scx.local_dsq)
> +			continue;
> +		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
> +	}
>  }
>  
>  static bool check_rq_for_timeouts(struct rq *rq)
> --- a/kernel/sched/ext/inlines.h
> +++ b/kernel/sched/ext/inlines.h
> @@ -70,7 +70,13 @@ scx_dispatch_sched(struct scx_sched *sch
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  	}
>  
> -	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
> +	/*
> +	 * scx_rq_online() can't be used. Its cpu_active() test goes false
> +	 * before CPU hotplug waits for an RCU grace period, and
> +	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
> +	 * the wait. The grace period can depend on those tasks running.
> +	 */
> +	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !(rq->scx.flags & SCX_RQ_ONLINE))
>  		return SCX_DSP_NONE;
>  
>  	dspc->rq = rq;
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -585,10 +585,6 @@ void scx_rescue_flush(struct rq *rq)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	/* sched domain rebuilds call rq_offline with the CPU staying alive */
> -	if (cpu_active(cpu_of(rq)))
> -		return;
> -
>  	/* end the current rescue */
>  	if (rq->scx.rescue.curr)
>  		scx_task_slice_ended(rq, rq->scx.rescue.curr);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -4205,8 +4205,9 @@ extern void balance_callbacks(struct rq
>   * after which it is enqueued again.
>   *
>   * Typically this must be called while holding task_rq_lock, since most/all
> - * properties are serialized under those locks. There is currently one
> - * exception to this rule in sched/ext which only holds rq->lock.
> + * properties are serialized under those locks. There are currently two
> + * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
> + * and rq_offline_scx().
>   */
>  
>  /*
