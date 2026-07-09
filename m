Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56812D0C7E;
	Thu,  9 Jul 2026 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576987; cv=fail; b=RhAAzhsKtWcGcYWUdnfvxaRXoXi7E3RW1FZtc2VFcj0RAxvJEpSlJqUb+/OOwnVXp5r7D4s4lTM1ZmPMF3ZcP15mhwGYSNR2zBKbnwemYRNOzwwT8CB6Qk1yUXZK4ZPkZ35tF7+NTmJ5K/s+d+gyjdhkkJcHrDMba7wHKZwoe2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576987; c=relaxed/simple;
	bh=O937hWG4/wceMczmKeaW+Mkls8Heip745NG8VyPao08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WdGIwkeS4v17It7f6mTc1RMN6olyHmAkcpEilHTXVNXEESzqDLeCOGSyG1C4paMAAMgE+sC4rRV9HMppBBQlo+dVVgNJKDVD6hk1fGj/jKz2agLL/M+ts3KqvvN++v/jz2nAvUHL+K8tyi0Bttli4v6Gy0Q1CVYWtzgasvYb3Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tH08Ouyc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tH08Ouyc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNnT9P1G/0/XwUCZxjgJYPn1Bu06kVCB3RdxhSXRYoH8IynaKLbgN49cHOsUhnbiTYuMrA+d526p/ohhjHQekVECOBXgmO4UT6LDsJmgxOMuZ3v5/rbzaOFe+bz8yVxQauf38JTkWorDVfHOH6l3tLOyIlD0RTkitDFUZlggFlNWRPUbwdY/fnNksEa50ugWHPcPJcHqZqHmECcIKY27qPPEdvN02IXH6EFV+tJuOYKRHW7qmVEOafKBSkDD/UixrNQHUKLZxIOCtX/WztCyNC2q+mf5L6lO26/o+8Rc2DLjpZx9haAwZmO0c00zfogKQoRyhk9QVlDWr25UkcLubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oThNWLvrhD03StO2kCUo6i8wIM3KcIlDzBKlF1nZwZ8=;
 b=WsJtygy7o9M/0+uEq7wlDKPT1Onm8GEKFEYNDY6yrpvpB5YICuvJ8u2zt9qaIwXhEXEr2kBbuEIAyUUEy3vNOin/UqyyMdGVVhRykOtOg/50ns+E5cD1cmGPEyFNlE4y0PpzXV14eFnO/XqD7AiaBA2vrckA3UQXZU34VGWcT2wK8fqpVWZUVBHK1bpbdbV9dGojWH2CSbXICeOhcW1WVgiJEn3dtQV/Vdncw8X4Rls9CcMaZg0E76VBX0zuAxHQbAS2rbzbfmXvzxv6fqKFvCUUr9Jo5Endu8WzbxgGqRV9WzlL0FaPeESFSA6n98I3sQzdJCntzQa8XJ87bhJGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oThNWLvrhD03StO2kCUo6i8wIM3KcIlDzBKlF1nZwZ8=;
 b=tH08OuycJ9/5w9K1zPjqhVq+FOq9vvCBdaQUyx7BeKVJ+eSJuaY2MGHQkn4EvcHfPjoDN1pi/iT/+x5gUHxSI+3XUPdiqxC9x4EgBSS++0JRIAzQhkaFwSVIvyguEdQUgbQoWi1BQnPivTJtsreQdYj6eO6OoDoJCIcY77uIWSg7MxOrOhmEOn7c0W91HVIc9QdaiTyh97rJ+OVY8sCfNp8e36MdPHqTlxw2tkxS78nncD+SA66mPBshoBoxW5IQSnPkAxHBDIdJpXyNNPfImHDPihT/w71It5fZ62GA5Cnr93vmZCtS8D5LQtfPXohSS3wGoNk76WkOZGotd3i7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 06:01:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Thu, 9 Jul 2026
 06:01:44 +0000
Date: Thu, 9 Jul 2026 08:01:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accurate
 in the consume path
Message-ID: <ak85QFTqe7XNvkof@gpd4>
References: <20260709051708.306636-1-arighi@nvidia.com>
 <20260709053349.905291F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709053349.905291F000E9@smtp.kernel.org>
X-ClientProxiedBy: ZR2P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f0fef0-d2a3-4c74-dfd8-08dedd7f8ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	givuEolhKazc+ujIAvd/mJA4Ogzo2SKpDnAqEjnpZAc4ty7F7XOxEhU67CLmkdWDZOTkHEEJctAeNNS5l9T0a67NtuXYLA6v2NnMTLYPjEYfn5j/zCSN1vs5LmseetQV0MacPYOqL20wryL4Q7tvq+w8STE3TzuMub3a88/2zKMlLUhydSAhrDMhHHvNXa7aOenu6NpynHbwHSlynFYLQr2xraw+x7l6BSF4peW0F7v5ZX6KR4y7nxAfOd73RFd5x0EKwQ1BQvQE/tXbmSd/XGlGyUAmf65o5Z3YeQVnquly5KArNGQtHTLvjMH4kGWUj57CJXjzQWn2t644Wc5vXaTjNiHFsnt24dQuNXCdD3r3WaISPAZQrA984I/1SnTJnB0V5ZGiM6tTHaWuqjkcXnUcK/EyPN2HwNlpNeUxR5Nyy4rjdKRBEq10Shv58mRDcbLmlwA1fV50sg4F8ZnfD8MIYPfZk4Kf7qSOV0NnC37Z9tdP6gaXAbdqJ197/1GRfiAh/fJV2Di8zDO7pZBq7N9gp8b9bsU6CGz6Qk9E6rf5AsQzTFogRV6gawRINKXXuccLSSpV4xaljVnqbHF7hLhVtayGNbmUALnJx2wL6lQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7IfGEGpaTHmEwLGgCqcCFmgBbGFtSJZZokPLgPF3NPyko99oPU9e486/8D?=
 =?iso-8859-1?Q?QeosDT5j4tj4KUJUdEpK6mQnfSLHzFYscp2DLGPpFSSuoKvaxhyztKAkiz?=
 =?iso-8859-1?Q?lrw18Wua/3RltXaXjldul0/JoOLtB2CG2CgQb0wui/RdxAtccSZvKLgViU?=
 =?iso-8859-1?Q?8G8G2eKY7kra2f7V8RwOmWPlxxIFEM0LCwariJyJB9ialFT5w3xAxOQtHO?=
 =?iso-8859-1?Q?FHAj7NHX10f7UoRpx0+9KfEhXytitcgLaQFVh07Czlnn/oJx3ZyDXOOSVM?=
 =?iso-8859-1?Q?EgpVcQcDaqSrS0aLwanfLDKTooCN0xoj+r0SaX0OfrNMbeHhBiQxx/4hHL?=
 =?iso-8859-1?Q?BSLH/2yI6CWn5v4P/DT4dM6CHlb9THEQXq8LGijXhxBDmIcdq5/ugDsxKw?=
 =?iso-8859-1?Q?e9x96l31ryb8m/yJHvOE2+5gy2X/Z9fNVsIIFEzFxSOYSeYC6JOTN5zSpP?=
 =?iso-8859-1?Q?6n6048RxAT2/IDwMemkUlcEKKG1FUO9Y9CNJxgbPnTtDqoUExBfFhLGr5w?=
 =?iso-8859-1?Q?WNzzqlzmRnP3U5Y2ERzctdGA7m+rAkvEqyX+DJvFSyX4FOFoM4tfJFaPNe?=
 =?iso-8859-1?Q?o22teXrEzKX4XR/K2xdeapzwVAjqY+IfhoLwYqrAYpfvAa26IsiecOngHe?=
 =?iso-8859-1?Q?sGCLfKiyg4M6AwAYUxY7x3s4STbtCuDvy8rA6WJTFbC/XYrgo1cnaeufaw?=
 =?iso-8859-1?Q?D5LJfOdJJw7rJHx3JX37CuLYlpazaYoBXxsU+ofM1J/C6SL9PIRM+QNPkM?=
 =?iso-8859-1?Q?trU8gsEp4ZrGId1odzffwQJB6BRunUq5uZ1ne2NLaFpjYQDjbrgme+768e?=
 =?iso-8859-1?Q?gKE/wmjUfKfs+iCBgAbNDDxHhjtBkkfn9plldk1laijXpzCfpMSSX7eWAt?=
 =?iso-8859-1?Q?FIEz8NqVOx0s5A/p/B0OncaTpOqcRYdg48q7YYckq6wulNJE3XrUa4THcH?=
 =?iso-8859-1?Q?iSAe50y/aK5AmPGp6UF1tW/49plv7OS33Cj5XCtqrUSa7jczYifnBASF6q?=
 =?iso-8859-1?Q?pJRItto3ZAlNpeXoz1XDkxcLNGuTJwGZnKMYE52twt03LsNVWFNWQfSu7V?=
 =?iso-8859-1?Q?i1/2uU7F5U68WEgTCs2iaUOWhTeKz3eu7c9w2ZopJRy9pfmU1KNTZ4Tt+P?=
 =?iso-8859-1?Q?rglvqyd2btCzWwsBdZrQSvUHaxQJis32NDnEzYLp2RUL5Of8kRRkdoFDdW?=
 =?iso-8859-1?Q?qIaHfjETQD1jciTHYwmocHyUnR2KSXNtJ9itoVipodoo4Uhk7PwdcTj+Qu?=
 =?iso-8859-1?Q?Urkw00fSSPLZFkWpIBQjf+zV9LyH24crjZ/61tE4IEVHvaqvuEixuQBcRD?=
 =?iso-8859-1?Q?N4fiW2070pnR/6mhpw8psmfT+28j+ZBaShtC7pNXxB/Kx//zBXrj7jd68q?=
 =?iso-8859-1?Q?MZUn5olqvEpmXjhZjdHe5xQutmBw9piCk7SYCp0XTpTwWGW8CEP9/uEfqL?=
 =?iso-8859-1?Q?GYy03ektl9hGtTyZLgfrlVZriIwwRNvNwWe/5dsjKyDrRLwEsZN7fr82Pb?=
 =?iso-8859-1?Q?JuE1FnNP6T2gnnCc53xZAFXBIU7yvHYZsxoyWupd+1OxUzOyTCvRA4YQxz?=
 =?iso-8859-1?Q?ZhTXXsl7T5OPL2RW92o2Q9apP7euXbt5a4IYdrls+C2mqJo9oABLe9pq1Z?=
 =?iso-8859-1?Q?z1bwljzzubF+5n3F69NXbzqpvDPoM4EwQJm/T81Hl5NuWEe6fqD6vrxygK?=
 =?iso-8859-1?Q?dVuz1ffuEM/Ic3lwNWYDn6eN2o9JtPixGjkpirr/Velq6jEHM0GjnojQ6R?=
 =?iso-8859-1?Q?7SXvOrVT0wTw9SwD88w8c50JvLekEgF6AwShyVqtuMVjQ3fSBK8ht7fUGB?=
 =?iso-8859-1?Q?0g5l8nNTJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0fef0-d2a3-4c74-dfd8-08dedd7f8ddb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:01:44.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvo1w0Jib49AZpQjiOmer8sbgUpYkM0wZGQImUgsPdAopztR4mSJsSMHizKa/MlW+MmFWntEQ+Mc9xtxouh3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

On Thu, Jul 09, 2026 at 05:33:48AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The `scx_locked_rq_state` tracking will be left permanently stale on the successful task migration path, directly contradicting the commit message's claim.
> - [Low] The patch introduces calls to an undefined function or macro `switch_rq_lock()`, causing a compilation error.

Both false positives. See below.

> --
> 
> --- Patch [1]: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accurate in the consume path ---
> commit 0f65257c6efec221d0687e563233c82e3c63e9c8
> Author: Andrea Righi <arighi@nvidia.com>
> 
> sched_ext: Keep rq tracking accurate in the consume path
> 
> This commit attempts to fix a stale BPF runqueue lock tracking issue in
> consume_remote_task() by introducing a new switch_rq_lock() helper. It
> aims to ensure that scx_locked_rq() correctly follows the lock transitions
> between this_rq and src_rq during remote task consumption.
> 
> Link: https://lore.kernel.org/all/455e701bca66bdecde530d225f4dba0a@kernel.org
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 691d53fe0f648..9644c37c87c58 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> 
> [ ... ]
> 
> > @@ -2386,20 +2387,22 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
> >   * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @p is
> >   * still valid. %false if lost to dequeue.
> >   */
> > -static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
> > -				       struct scx_dispatch_q *dsq,
> > -				       struct rq *src_rq)
> > +static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
> > +					  struct scx_dispatch_q *dsq,
> > +					  struct rq *locked_rq,
> > +					  struct rq *src_rq)
> >  {
> >  	s32 cpu = raw_smp_processor_id();
> >  
> >  	lockdep_assert_held(&dsq->lock);
> > +	lockdep_assert_rq_held(locked_rq);
> >  
> >  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> >  	task_unlink_from_dsq(p, dsq);
> >  	p->scx.holding_cpu = cpu;
> >  
> >  	raw_spin_unlock(&dsq->lock);
> > -	raw_spin_rq_lock(src_rq);
> > +	switch_rq_lock(locked_rq, src_rq);
> 
> [Severity: Low]
> Are we missing the definition of switch_rq_lock() in this patch?
> 
> Compiling this throws an implicit declaration error since switch_rq_lock()
> doesn't seem to exist.

This was triggered because the current sched_ext/for-7.3 is missing the
for-7.2-fixes merge.

As mentioned in the patch notes: "Based on sched_ext/for-7.3 (daf8e166ba59d)
with sched_ext/for-7.2-fixes (cfe950d79f524) assumed merged".

> 
> [ ... ]
> 
> > @@ -2410,14 +2413,11 @@ static bool consume_remote_task(struct rq *this_rq,
> >  				struct task_struct *p, u64 enq_flags,
> >  				struct scx_dispatch_q *dsq, struct rq *src_rq)
> >  {
> > -	raw_spin_rq_unlock(this_rq);
> > -
> > -	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> > +	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
> >  		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
> 
> [Severity: High]
> Does this leave the lock tracking state permanently stale on the success path?
> 
> In move_remote_task_to_local_dsq(), the physical lock is swapped from src_rq
> to dst_rq (which is this_rq) using raw spinlocks:
> 
> kernel/sched/ext/ext.c:move_remote_task_to_local_dsq()
>     ...
>     raw_spin_rq_unlock(src_rq);
>     raw_spin_rq_lock(dst_rq);
>     ...
> 
> If unlink_dsq_and_switch_rq_lock() updates the tracking state to src_rq,
> but move_remote_task_to_local_dsq() doesn't update it back to this_rq, won't
> scx_locked_rq() falsely claim src_rq is still held when returning to the BPF
> program?

False positive due to the reason above.

Thanks,
-Andrea

> 
> >  		return true;
> >  	} else {
> > -		raw_spin_rq_unlock(src_rq);
> > -		raw_spin_rq_lock(this_rq);
> > +		switch_rq_lock(src_rq, this_rq);
> >  		return false;
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709051708.306636-1-arighi@nvidia.com?part=1
