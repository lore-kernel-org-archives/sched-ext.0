Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F292848A0
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444144; cv=fail; b=rcMTpv5wbw98FYRfeidqHnJZEz4FzZ0yzWm/5aZ4W0gpTjFfmV5FHTZXWM5NFacvXUWw7XEnO8zYk9OothHtnCLJo8eNfUsjY2QeF44kOFAXtzVNAhEM59D6yLDCnjdIVBfAP9RayXTtdUdVvxR7rahi8MLXsIYqmPT+gm7NqGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444144; c=relaxed/simple;
	bh=QKZYXzyUm7jwXRdmVEHXdElIq/HKLUpblILQiHeQY40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPjWm7xr7FTQxYs0RP15XG5vyshFbKfjr62dYIdMtaVeo81Edg8fRbp33v58+n1TR1ymvmDrQV6sFes7U2qHagFLADoAKjxMxe3DXZ7Llxpt0agOopXq4xQhMgeNsf8E3oeHzPY/XA+zQtNWkf2lrlLH2QKOHT+JCqSVI1bzzfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJedR/te; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJedR/te"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub5hD6zH+V044CXF85rIH1Fms1YmPa1FFf8wBYe8orbd9Xm+g0SP3PrjJA2pUcUScI1X6HtfcT6H/BJX0Pz2LS8IMk47qJhhCXmeJw60cU5eVn3DC5dmvnW6IPfSYfSG906WLQ8iOZOioRoUdikas6Up3eeRzb8j6Jek8d03353YgSdo2K5TNoD6ES0ItQYgMSwJJU6r3lvbn4kGH1uimBHVQooXtFemRXJKJEEat16gItQx0FDENcbW7SbPoqo4L/AxbV08RLRw0YuHSEaPRm4sATkXMgZOu1y5JWgD0jUnE2TFFFUF2a4fDBEJt6Z/QTxsm2JlsoL3fItQjtfkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jbMpqkESqNgVoGXfAtjDOJFl8LKwIGYyj+e+H4GiHw=;
 b=is6TSKW48sUzXJxDdkJG1t6/zUFyGYiby0bny28LNi0jdPua/YkRv6dKSI4nt9iyL20s22lXDB5xmpR/EgcPwViBEHlGYjNmz44SQzdCOFu51N3tRm0XnTAtjdY9mTCgK+pNNoxFliV+ltvrP4F2WLctNCnDs4jTVbFtudDMvHru9uhZwDdblczECZwQ4fjcT1ZO32faiQs9eo7BMqZ1VDGQ8H7854LQrE2iH6pEu6QM39gIGCq+wKNKV0KBZfRYd+bxXyR2gHNvfsoimO97ZhbQWC9TxWImhYvehKqZ1iBS/XOL2sdpy74QtGqfmf2DpikORYHSyFqOsuwuPnyrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jbMpqkESqNgVoGXfAtjDOJFl8LKwIGYyj+e+H4GiHw=;
 b=lJedR/te1zdPHWMReAHpC79KbwpHNNS9bmu+UW027Okl9Y9wuTK7KiVn+kFUtcpUZdRNGHY1doXUxraeODiw8dRGM2r5Bxo4C7FinQLgqLUcES1D4jpIMiQOV5HYq6TfQizElAdrVH1lHDjhbTnytTblNzfa3Yne9rdXAhSV/raS7vymO/+ahs6VzSST8AtKfZinZQvZmcUmcpbUP8JL1xXJjGEekgyQ0XX7gdDq4OpBM1PGuQY1BprADt4qfdNCV8c2vgbJmhXKSOEeds9uiJS8qMe4R675QvqlUb/Ad/aKJsAIuu8xy/a9mrT3xPUdMb8NYFfvCKZk6dg49CWmKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 10:02:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 10:02:17 +0000
Date: Fri, 22 May 2026 12:02:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Message-ID: <ahApoVJfD9AJvdeW@gpd4>
References: <20260521174509.1534623-1-arighi@nvidia.com>
 <20260521174509.1534623-2-arighi@nvidia.com>
 <20260522083655.GM3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522083655.GM3126523@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d200bda-39f6-4122-4269-08deb7e9346f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	XFsPJr3U8sd2iN90/rGwW4uokNx2sDGFUfVJ00VdU+/MXurhJlYuij4FU4/GiP9yaNArX60Is1Fv6BtYfpZF52Put7a32Nc2KCHiUqeE802hpZI1Adw22R9UpXycUb4FJGMytnXfEITAT3/FpN/vtkJOcbxrlKPcmDDJp+nczqFH2aZyoeic2w7gyqyTJUEY7vkaZsm1XR1XKtKu7pQL9J7rd4DgBT+FH2PM6ATeeRdgKTn/eY1efwT0p8rQGh5Dg7Yb8DVxCB/yqFp9mGjb7+RN3VG4oNUfk+lQ4CbAe94zncHoc89386WoKoQ6uvZrnW+r15H4TY4DlVLTJFNdU7JxknB7NbUpEUj1gny2hRI9cvxs8GChxuMH5WDhqZgRrPpKMDVebie12Q1OOqq/9a9kP/pK0wANFwf3nS+yEcdIzDoZMU9kgaq+yPXE26Bbx/wYYOtgFJg9+eqUUklRldEtygsqsgBJ6rEwCYgPBG3vjG8Ad+W9B9qsOZgpcZsTkYXSy3yMvM4okgarrsQV7P4x0IozTK3G/NzBmjt6+pSOB3IRsUQkpqsMf1zykLyxCp7W4o9MDp5xRKrYVU/15E/KzCD5GvjBvCxXlDIIFnm0A920Y9tm6mKaazX1XGMOx4SV7bWjx5JtJqsuH8q0qyzM81fk5vFI1LCz33J7BX1B/yi7yNV8F7E9gHSk8OgF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oO0Q2NvHMcVzMWe466Pt8noWE8tNQrh7pgUjgPR6iuLombzcPN1ZrBv4AQr?=
 =?us-ascii?Q?3S/S+klCQ4Xi1Hy/M57YBH/Z3aQh8sGkMej0/yiaEoVWeBUCnaA9JqdyULb7?=
 =?us-ascii?Q?6RGmOnPqf9F7ZUrcmBJpmttP1x6q5q/sfNT2wmBR31rIjVVGnUL9DeW4DpJO?=
 =?us-ascii?Q?CdH6yj9GVEN5wK59suMy0aRo8VCvd0T7Guwq6QssoK4TqMiP5Bfq43B2RD1n?=
 =?us-ascii?Q?N/fRGH97eg4Kc0kSr/pL9d8ne1jdDV7SCjo4Z9Ny8k+lSxn0X8bh1TWEns1+?=
 =?us-ascii?Q?9uVVelPN0WNP6pslyoZ/Vn2Buk42SCuJIVacxV8y429SBbMJt5UJq8gVjKeD?=
 =?us-ascii?Q?Iner7/b2n8eixKuFUtL8k5ofaJVIWqTo83+tGeiMWJ6OLkmDc+ihAm/OSPaA?=
 =?us-ascii?Q?/YUgCL55EpoVnX9mVn0GuIrUZ/AcBmMIDgEocJhytEpgty5eaTi5VOEeRHZe?=
 =?us-ascii?Q?OpIia/wDiS4JN9/n+gM1C838Cf/jcvwBvb8QeG8k5hHJrsTbNAjvwww1rSAQ?=
 =?us-ascii?Q?CCGMWLKoBHB0tPzwmMcrb+hnVlV5wc14K0ZX8c97xV/rk0fPv/Mi2p6DbjTB?=
 =?us-ascii?Q?SAffsNNYFJBjy2aOWJCBPhKzLJ+1iiRl7tUhsvdDFj8C+Hp8VaHVU1p+PImj?=
 =?us-ascii?Q?9XdVXGGmAyxJRHON4uQ4jDbyS+f+5RWSbXRwpG/6LlespM2oeeIQzmMEO2e8?=
 =?us-ascii?Q?Y+TODg/5Swiym+8Vg7V9EDZjZtpZfsGYFp4LQ6/+zlhlHRFtl7KGvKPj97Ae?=
 =?us-ascii?Q?YO1VWnHnd1N73eD/o7k8LBPYx3DQzMz0+886hHwBKpPyHanva2U7GHPa65fy?=
 =?us-ascii?Q?O5Vg7+R+iXyY0vXuKQsXDtKxZft3XSkRSy8OSErDUZQ7rjwtI68KS56Qjbea?=
 =?us-ascii?Q?RGYBNoFgwIBql2qSHR8jbT0WUJyFriXC7Rz3A+syyHbzGum5uEHayOW68ieq?=
 =?us-ascii?Q?JlQoiCcDDvjbY/gr+Zl+sOhghSghf2etPWVo4pruVEia9dTIW17aNdXjc9co?=
 =?us-ascii?Q?Ggc9nft8ckLbtQxdlVWKtjeD3Pk9b9xsPWhYhqxui9Fmxi0iGsZuNBhQmm7W?=
 =?us-ascii?Q?Dipa6Mbz7zph492Fggh/5cR/pEA5Z9A9iyAtL2SGL1/G5zNZlb8RJaue/m0k?=
 =?us-ascii?Q?gJONGqYXxK/JtGSzHendGEZkHTm+wrCBK+ug2H52hWVRJB+xLQjLxy/3DIJy?=
 =?us-ascii?Q?VpzZumh97mPikS21zIrmAaq+apo1JjFTpbps+6lyoCrkBVoOknJ+qybGi5JQ?=
 =?us-ascii?Q?AKttvokryvHShN90czOG/kAj68XdDlv8LS+0Ky6gy5N1TLWw6msnFgbS7EuU?=
 =?us-ascii?Q?jz3pCnoxeQKWoZhRgX3kD96Qg2OqPivxtCCMufQwKQCfwV07f4xFFkp61Cn4?=
 =?us-ascii?Q?0irpYVdQYIVg23FU33Hl4LYa0SJ3OFoZmGIIX3t80WBZ2/qp8JzxTRVQfDrK?=
 =?us-ascii?Q?Ls4sMW+WvbYsxg96rYBZN7z4ddvVgOTmTCs2BBg2iZKzjH+omgZkG/ELQvRL?=
 =?us-ascii?Q?+Fp4ZZl4a4IzSPLONc8eqUdfHi7T4tPuTaOdUz7eDjq45rVstB6S4FU5mRpY?=
 =?us-ascii?Q?uHrMSrF9C7PalUzRm4m4xH03eVj9P9CdNTTkb0TLngcxpWfxpxIbpzxwGaHE?=
 =?us-ascii?Q?NlL8Q2AlHpE5nh1PPqJVpP/A1s5QQR8fG4S47CMB32LAey8El2sgEDnmazVU?=
 =?us-ascii?Q?+3+BiFTX+VZHVsYPK/wuMbZ6Ry9z5yaZRpDrsN3Mv0g0WL/RwoNt85ZOCuKG?=
 =?us-ascii?Q?37R0ge5ffg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d200bda-39f6-4122-4269-08deb7e9346f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 10:02:17.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOSd+oGOTtACzuw+1v/BE206OJgO4c6E2fXDiuT81wb8bP03ktYRo4/sxKdjxNB4UhPrpaTKChklqfKLGTMkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165

Hi Peter,

On Fri, May 22, 2026 at 10:36:55AM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2026 at 07:33:56PM +0200, Andrea Righi wrote:
> 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 9c458552d14ff..15ba49fcba9af 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -6061,6 +6061,7 @@ static void scx_root_disable(struct scx_sched *sch)
> >  {
> >  	struct scx_task_iter sti;
> >  	struct task_struct *p;
> > +	bool was_switched_all;
> >  	int cpu;
> >  
> >  	/* guarantee forward progress and wait for descendants to be disabled */
> > @@ -6087,6 +6088,13 @@ static void scx_root_disable(struct scx_sched *sch)
> >  	 */
> >  	mutex_lock(&scx_enable_mutex);
> >  
> > +	/*
> > +	 * Snapshot the full vs partial mode before clearing the static
> > +	 * branch, so the dl_server re-balance below knows whether the
> > +	 * fair_server reservation needs to be reinstated.
> > +	 */
> > +	was_switched_all = scx_switched_all();
> > +
> >  	static_branch_disable(&__scx_switched_all);
> >  	WRITE_ONCE(scx_switching_all, false);
> >  
> > @@ -6136,10 +6144,24 @@ static void scx_root_disable(struct scx_sched *sch)
> >  	/*
> >  	 * Invalidate all the rq clocks to prevent getting outdated
> >  	 * rq clocks from a previous scx scheduler.
> > +	 *
> > +	 * Also re-balance the dl_server bandwidth reservations: detach
> > +	 * ext_server (no more sched_ext tasks) and reinstate fair_server
> > +	 * if it was previously detached because we were running in full
> > +	 * mode. Detach before attach to avoid a transient overflow of the
> > +	 * root domain's bandwidth capacity.
> >  	 */
> >  	for_each_possible_cpu(cpu) {
> >  		struct rq *rq = cpu_rq(cpu);
> > +
> >  		scx_rq_clock_invalidate(rq);
> > +
> > +		scoped_guard(rq_lock_irqsave, rq) {
> > +			dl_server_detach_bw(&rq->ext_server);
> > +			if (was_switched_all &&
> > +			    WARN_ON_ONCE(dl_server_attach_bw(&rq->fair_server)))
> > +				pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
> > +		}
> >  	}
> >  
> >  	/* no task is on scx, turn off all the switches and flush in-progress calls */
> > @@ -7314,6 +7336,27 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
> >  		static_branch_enable(&__scx_switched_all);
> >  
> > +	/*
> > +	 * Re-balance the dl_server bandwidth reservations.
> > +	 *
> > +	 * In full mode (!SCX_OPS_SWITCH_PARTIAL) no task will ever run in
> > +	 * the fair class, so detach the fair_server reservation and give
> > +	 * that bandwidth back to the RT class. Always attach the
> > +	 * ext_server reservation since sched_ext tasks are now possible.
> > +	 *
> > +	 * Detach before attach to avoid a transient overflow of the root
> > +	 * domain's bandwidth capacity.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		struct rq *rq = cpu_rq(cpu);
> > +
> > +		guard(rq_lock_irqsave)(rq);
> > +		if (scx_switched_all())
> > +			dl_server_detach_bw(&rq->fair_server);
> > +		if (WARN_ON_ONCE(dl_server_attach_bw(&rq->ext_server)))
> > +			pr_warn("failed to attach ext_server on CPU %d\n", cpu);
> > +	}
> > +
> >  	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
> >  		sch->ops.name, scx_switched_all() ? "" : " (partial)");
> >  	kobject_uevent(&sch->kobj, KOBJ_ADD);
> 
> For switching *to* scx, I think it makes sense to attach ext_server
> early and fail the switch if the attach fails. And only after the
> switch, conditionally detach fair_server.
> 
> Since switching back to fair is a recovery path, this isn't really an
> option -- the only actual option is keeping the fair_server reservation,
> but that isn't ideal either.

Makes sense, I'll restructure the enable path to attach ext_server early (before
any commit, failing with -EBUSY if needed) and defer the fair_server detach
until after the switch is fully committed.

I'll send a new version with this change, along with the fixes to the other
issues reported by Sashiko.

Thanks,
-Andrea
