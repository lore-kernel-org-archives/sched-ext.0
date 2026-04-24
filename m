Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6E2BE026
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067209; cv=fail; b=oV7I11vA/wkXjCpgPsQyK4Bcmpgt5Bm+aDZQ79y7Pjt4vJvpPWZVf0p2v25mKcROk0lMYLzWfY2QR9lUkfgJD1si/SDIiwRKabsrld+9SjfOckxaNAXHg/WEbkuKO4estLFHbJZ6nMYxm0iW2BI1HpIocqMkmzIIM6nKT8jAyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067209; c=relaxed/simple;
	bh=lcD13DEqqCFocUCamPtMjkCy8TG8K/+2z3OrRk+PcLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D/rOtsbSMAyukNGF4/x4o0p/Yc7du5PElFPzUrpzhtU+LQSw2hJiussg0p7eTmzxcjIGr3noPRwBnrae0O26itOYpe/uHu2JxFQdA4C1TwAdfh9naGFJWOyR/khSv5yBT/QckJ6bf5rtOwJjdVPGawZK76ZtQ5UwNLuGeG8xqMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A43X7Z/1; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A43X7Z/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9uRotsjU8T8Ns1zsFmgsm0wdPvjSoSHF5X90ql92d53WTYQg1/lnPj2bSDdLnIqoq5Dee10UsesagGdlw1nv5rqG4O2t4kB15ENihUZKwPJAKDmY5GiZ0ZsM+3Ab66SRtWHA+IReq23WQoDu+GkRYiFzc4TyTguZioxeTeWoGjA7VDuva4wq29ABGfYmDk0qGRWNdk/Hwd6VZAkiLEbMjaQ0/zStuU7+eaSl0IKGKo0ToOk9LCRhqzlyrfLR7qyUL21noJ60R5E4zggpRVV3mbcawSRwLEyeQQS3F/INdhitMCTJGh/LPRVjSJPY1d05MBezTsVbNB9gFWQy/6SwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+el6b1PID+P3OmbtDpRC2nCA6ivkf95SmzbCtpKfFvE=;
 b=FJOhdxmj+AJFJ62eKtBlMWTPwFzybCH9jFyFB2gSwpq/MM0Xn4831tSBaggWnK7SqHwvqtdhDGOtMTVo6F8yLadnTMnBISkQpZ2sxz1xuDIX381Q71bglh+TCdRSvcHBBEqVxVvs/4dVVurGdYIp9GtMFS5inhOasbX8mrjrREhzdpGN0FR+LMqK5r3JCmTByKBopefltgpAxJx214Dw2cXGRvU8GtV7gtR5VoSnMfV/R/A9xwjLxnHALiLxPILGY91v+79tJt0tPEn3oZAJjP0uOfFYAM4SOum2g4fzda8dfkiPMRVAD7MpvEDvxC3L/KCzo58Gy8ntIRzDCt5btw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+el6b1PID+P3OmbtDpRC2nCA6ivkf95SmzbCtpKfFvE=;
 b=A43X7Z/1H8GjIwRZGxqN3ACR1nSMaB1KjNKGd6CDGFvllIY9uvGzlUQRjdmh81Xl0gtwsRIAjF1jKeHjQ2vWZm3U9zQW5rfxOezcvcRSJW2dPzGaT+5ucGlp8erH+tGPMI8x/O9/Cyv1L/38L+9gVBKOTUX/KDCbzTNyNKyLrKi1wWGus1MKPOeUsqc5cqx+JolQWYLko+JodXEZEbO+6wKrlWiAmZoAOL2t7GSin7UtTaGVnIB5Y/yWUjAJUNE75Wgej+9wQQg75oJTdJEbvqnzwaqe0I4TJiZDGRbMLLV2uvPh/lNwhiE5OHoU6dASx0xTu7bmkTj/kaIJabTllg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 21:46:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 21:46:44 +0000
Date: Fri, 24 Apr 2026 23:46:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>
Subject: Re: [PATCH 13/13] sched_ext: Refuse cross-task select_cpu_from_kfunc
 calls
Message-ID: <aevkvAQnKu1r_Zui@gpd4>
References: <20260424204418.3809733-1-tj@kernel.org>
 <20260424204418.3809733-14-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424204418.3809733-14-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::45b) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: fb139e34-d351-4ef1-7112-08dea24afa32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qcN4cjb9vWq+03YxF3aZSAQD76p8rDGNxWx6/ixa5xO0FdLxhZ0FzfjVGTHuNRfXZodAfO/nq93e0D14pzsAl9CB4mWhNuf5lBaCjioM7HJ3rUvtlulntRYZADECqG+cDELVze1vg+4bzXhSZqzMTDf6ntKgZx613eYBWafhhmlu4o8zZGGodVlMdXxUEeJ2j7tcwRyW3eZFZTI4ZZvwrUXrtGvk6KFbGvldRiKBHoIXbrGqm+zGPo2RwICrRbcpm6EZp92ObtdvqTEMIAAesJli2tWMqc3T594mAwGFIs410MPotxSavkAa6BJqmxJJQmwftBGSkUDJsw5YpkSE+cy4TE39xxSB/+2MC0VxA3E1ZpXTZUr7tEDEhqAp4c/JfFVP5RKNx+gbeNHyX371HzO1+hVLLWX9BzdArTAIUO8reVAvZvnUPAbaPq/milPsXOeyI23RZNRUt5BaoJaS8Bq1DFiDN9QAht7oFfKrqr5262G0VWvtSJzfjlsNOfy937FzmKQYLwplLEHrZ1x8BwArcP+oFOCw737s+RmRNq/93gXKtAH3ybCG1dmXOWeCAgubxVt0bAFS4gK2HKt0n4gb4eikocdx+Qh0CExxYhweq+yIPQPPueA2E52CCnfgr6z22il5yZgMjtQuodJ7VZlPLqwlJzt0Tv9IhMvygzGhA/L9MtBLQ0NO9DETzVzA+BIMkd1pa0mr0PxvmgylrOKGpZeFZar3bUViOfD7E7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ow+x78eEoJ8p+1UEBu8LOoygpQdfNji57u+6B3C0Fzw5My/laXCKyGFjSiDP?=
 =?us-ascii?Q?pcXIFMiIZAnCF/3YKIrKtYXPhO55T8edRB0Z5g1J2FfmTZZ1IV5f0fZ5kPY1?=
 =?us-ascii?Q?qIgBIKLnuSVImJlB2aiTDe2zO2umIFyXw1Gk2aQdSdphQ0NRl8Fr1jw95yGH?=
 =?us-ascii?Q?GH53kfMtr+HNav8pdYupdylsJ3EHo3Qhoi6nIsQDj0/EJMc3E9IlUMvFBdhB?=
 =?us-ascii?Q?KcT+GFsS4/9l61NFN0vA3itdYVi4M1sgycRVZMRQe622AZFi0xXVZnAq8No2?=
 =?us-ascii?Q?PaGDEqwewtdliIjN7A7cp5+kpnstiHHHvRUOyMmyCX99AZQzd9757VhAcN22?=
 =?us-ascii?Q?uCyQSl6or6Zhm3tBPkrwyuGuasIrjezImSGI9J9oA9152KK7esCuny1gZYpH?=
 =?us-ascii?Q?Qt9XK62yGPHGiO9foJX5wq+MCG5xBHWYTHjwu16WUgJIpD1gqCz5D2dT1qI5?=
 =?us-ascii?Q?Z1PDdD5/8GAWqFqhIshygSn1HASih9Pl4k5DJf0OF/lDaF+F27wMIUOFSOqF?=
 =?us-ascii?Q?c05BeIODEcdYF4ager26IOplXtuS0qNV37L9cgqrlRwkaAHI2Bii1nHdN4gY?=
 =?us-ascii?Q?2EJbu1BzwY03Jzy9hyb6zlIKTrMjaF1f2Ss0DXanTzp3eyA5G3LRCPfqxCcu?=
 =?us-ascii?Q?/UMxEOg73sDmg9q++XnIh9Q3yjMGcKE8Dexd2Dd8eJnb4BeKajcSGBB2498z?=
 =?us-ascii?Q?ghLwthriBDnA4ESvmCIOSv7EJ6r+dblQTmeSntEzrXLuDhQUfPCzW4+0UssR?=
 =?us-ascii?Q?AM9PF3qlKWbi5+IpNNBiTCXiCVmo+uQPCNpjUF/5rfnohJo9E8E9Xth7JcJZ?=
 =?us-ascii?Q?6yT/MxtkJ0noIwqZg2OM74raaGa76jIaTweYxrnelQmFASyYxJBKMOs9Ea+x?=
 =?us-ascii?Q?XT+bt0GITIHxKIsBBvBnX5nHXEmZk4WRcYwIgmXJNCxvlYn89V7lxtFqtV+q?=
 =?us-ascii?Q?/7IvU0/scZJRB2T0CAIl5fbfb7eNUReM2dP0Od7BwOEZOVWjH7Qgqm6Hcjgz?=
 =?us-ascii?Q?MzZaKZDBwZkjcVsodqC6k9+6pFNTxqZQM6AmNT6MJbDygA8EJD5Ahv9+lB4Q?=
 =?us-ascii?Q?b/QvV+9TG+KBrirXdfSBOtIFVsmiVjNu1cYQmrINdDF45RMpr3sWKDtzj6Fk?=
 =?us-ascii?Q?SYXWu71Tr+b/XPLJnTADMHVhjUYHwIO1g5QdGjwGONNJqdNVW6KXyZxfA3H+?=
 =?us-ascii?Q?8liUcfEsdqjzYM0/5aioPV+gH5JJSn3wMilQJYp5DeS4LDjxSCyHI5gukK4N?=
 =?us-ascii?Q?UnUrDNwZ8oQ81JxzimYWEM0RMoqiTQPkwEsKD3rFmKmBSBOdUm6xijkpXzKA?=
 =?us-ascii?Q?RZRglPJGP2j0kZoSYPvmLIiM8enULkNMuLGPWJJSZv2esuLMY7eZhmcdhW7e?=
 =?us-ascii?Q?BOTsVq4Ij+8Nh51u63sUsaOuLnT7c9PqVYWS07rlcPBPfgGoPgc9ovLHNYwX?=
 =?us-ascii?Q?dL3fXkh5uoWeY6djufSXPedW8hc/S4a361A4tRXCL6inNz5mvJsmDcVl6zRR?=
 =?us-ascii?Q?8SfEETM5sk3nrf9WOsi7aaCE0UPnGw7g90v6Cz94uyRuccryKH/4Q4ZAvqfu?=
 =?us-ascii?Q?g/YJkVYPpon3i6KvKmpxNLyKlzYF4rCTstNnP9IuHWBM2a1rTEtjczAKn2s6?=
 =?us-ascii?Q?Mahp0i7m3wnyx4o0k2XEanYPPOxzp49bdH4RKE+o2PwTQn6d0Sx1qjn5o13N?=
 =?us-ascii?Q?plzEhV3L3V0Zkei3QgcyokDqpjFu7Fo/1ysZL3c6VLBarBy//O+hVj6HzEov?=
 =?us-ascii?Q?HnNn0+NH6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb139e34-d351-4ef1-7112-08dea24afa32
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 21:46:44.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE+GwsNf6PNKfPaUr2VdtXfRteHxjK1eN8rxyMG+yf8vptrykMdPxiBK9Y6dNMzdRd2yEcz4o6ubzWchM8VHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707

Hi Tejun,

On Fri, Apr 24, 2026 at 10:44:18AM -1000, Tejun Heo wrote:
> select_cpu_from_kfunc() skipped pi_lock for @p when called from
> ops.select_cpu() or another rq-locked SCX op, assuming the held lock
> protects @p. scx_bpf_select_cpu_dfl() / __scx_bpf_select_cpu_and() accept an
> arbitrary KF_RCU task_struct, so a caller in e.g. ops.select_cpu(p1) or
> ops.enqueue(p1) can pass some other p2 - the held pi_lock / rq lock is p1's,
> not p2's - and reading p2->cpus_ptr / nr_cpus_allowed races with
> set_cpus_allowed_ptr() and migrate_disable_switch() on another CPU.
> 
> Abort the scheduler on cross-task calls in both branches: check @p against
> direct_dispatch_task (the task currently being selected) for
> ops.select_cpu(), and task_rq(p) against scx_locked_rq() for other rq-locked
> SCX ops.
> 
> Fixes: 0022b328504d ("sched_ext: Decouple kfunc unlocked-context check from kf_mask")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index c43d62d90e40..ff4d1b97437d 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -927,14 +927,24 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
>  	 * lock or @p's pi_lock. Three cases:
>  	 *
> -	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
> +	 *  - inside ops.select_cpu(): try_to_wake_up() holds the wake-up
> +	 *    task's pi_lock (stashed in direct_dispatch_task;
> +	 *    mark_direct_dispatch() invalidates it post-dispatch).
>  	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
>  	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
>  	 *    nothing held, take pi_lock ourselves.
> +	 *
> +	 * In the first two cases, BPF schedulers may pass an arbitrary task
> +	 * that the held lock doesn't cover. Refuse those.
>  	 */
>  	if (this_rq()->scx.in_select_cpu) {
> +		if (p != __this_cpu_read(direct_dispatch_task))
> +			goto cross_task;

I'm wondering, what happens if in ops.select_cpu() the BPF scheduler calls
scx_bpf_dsq_insert() first, then calls scx_bpf_select_cpu_and() (or
scx_bpf_select_cpu_dfl()), then this check doesn't look valid, because
mark_direct_dispatch() would set direct_dispatch_task to ERR_PTR(-ESRCH).

Can we just check scx_kf_arg_task_ok(sch, p) here?

>  		lockdep_assert_held(&p->pi_lock);
> -	} else if (!scx_locked_rq()) {
> +	} else if (scx_locked_rq()) {
> +		if (task_rq(p) != scx_locked_rq())
> +			goto cross_task;
> +	} else {
>  		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
>  		we_locked = true;
>  	}
> @@ -960,6 +970,11 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);
>  
>  	return cpu;
> +
> +cross_task:
> +	scx_error(sch, "select_cpu kfunc called cross-task on %s[%d]",
> +		  p->comm, p->pid);
> +	return -EINVAL;
>  }

Thanks,
-Andrea
