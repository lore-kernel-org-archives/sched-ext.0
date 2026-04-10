Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9630F7FA
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838894; cv=fail; b=TkZxAt9Lak1ABgJpF8tSvP5TVuI0pxXuvsPBaWx+v/jy6BW1WWvO82/MZ3kT4U7/T8k7SySfHXfDPtkJy0Jia8CVUVjDnsjQFcsmRUntFz3Q8jl5rR1MbZUmNLMyWhQspuDxKyjmqe3PEMNeRqJfmy4SK2GYrOMglaJvZAmBQLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838894; c=relaxed/simple;
	bh=0fHOGPMR5BVmYaxGg0SCoYExXumc//EFLcOdSabHP2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlBhUO+ATC6Q8SbawtL6nD/cxvYQoz+TuBlVDW/2Ue9xoJh9XQdIrblvdfiFOqxcyITEErngzOdZ+p3OV+XQnUMVIDjmnAbCBtGTjNKRZwtI+qVPuXz6cpUPUITlFMcPAcKGbRqAlRIWJGSvdGG7sO1ZJf+hTISFcXHTUpwE3+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CU12ovBr; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CU12ovBr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv7x7Y7rVC1iEXcr76SzOErxEOa7SWTTkdtw/5aLXiOkMu+TIlJVmM/VH5ZWHpY+Jj9GjM/emFA9Imx4GRDP1BfskYo7Hkk/Yi1nB/ivyZ8+TOEO9PbBBDaUcHlGb5AfZ1lDuKjoPpNEF6dpzbWd5nn1fXXLZobx2vA4L8tJoCliMgpQrGKHvr4UWvOs1UH5bnsLka9KmvU/3LkoHv904GwaVPkC1RTtAN5LGrkG3c2yN/htl0yKWFA/ZukUmR0ocd9BN3xfe/WNhIKgSaEMhKOdWVgmD0N4tyoMMTsmiMUrmXBBrl3YiO9h1GIfVqizM1ppSXdpcQs/ya8f2HNB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie8wxoOPcoZXb3/q9djgW/nI3ABkUuh79ooLOmBEvUQ=;
 b=Pv53OIHub4xuuT+tI9rkaRIS+9bdQXO/tWRhpvP/GfENtR4fdEWZE4B3LRcruxtVsLpCx19DSG5BwNFMNxiNCcZ4SSnl2t/omxGTgCezpUDGu/bHaAuGWaEwb9sxJjjh53LTBASJlJ9n+HZU5qD/lKZ/Z7jjO2NW5m0oPa6/rgI23RFemk8z5ZrZoxpnBUVDJKgdG3lKvdSfk6wRjfFF5wOpewUFqokq7/d8zUX+ITpH2gijJ7l9ucy0/6QIFFPYVHQdpLfHmw29jp37kSj4b3ufgf5NMUPoxEHOz0xBLrOHzqKUGJeacHJRpTaAiQppG0aoLO2jbVOKJnLWJ4A2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie8wxoOPcoZXb3/q9djgW/nI3ABkUuh79ooLOmBEvUQ=;
 b=CU12ovBrhNunHAHdaqjMxcF20cj29bxoOL1Fy8RQTaRC6+BotxHPd46ouowELCEIgAZRxH+mpuxSZmGSGzWSFOfiDK0HGFJldW6JpWX6nkiNN9dIkKAZdyhoXVRVxypx3zjFG23Lr0va8SgimAkmsUsgZA2K+r+FDuKilW8CPArteXpLqOl7mKu3uTwT8PzTuC0eHkKf5FGsZFpvL1tjtUti6eFB6BdS6/uVr28/QZjwVP2uNV6RWX89jMEJeKbyzMFice69GEq9EcgVWi93vwpItDka8tUBycgV4pV+RlYMfxj9vzbLcJVj2lwAIN/pqxRNHiEUrMJsCTfPjQFQGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 16:34:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:34:46 +0000
Date: Fri, 10 Apr 2026 18:34:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] sched_ext: Decouple kfunc unlocked-context check
 from kf_mask
Message-ID: <adkmnZLc5nD2e6OS@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-6-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 543625ef-f470-44d2-bc68-08de971f1349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J8OiUpG6iyaNphml+zMLytrxn5qBReGEEInRz6+3ViDuHaUxglrU0nuJ46kOWL/Xioc9e5lP7smoRmucGM3q1cwxZ4sxc9yiMrz4mPkus2xaG8J8WX+1W3r+KZhQHCiOjiVbrFsRzx3BJfoCkQUfofjt3ZwkUAF0hbCQKwFhQTHk7aDzRMsQDqS/jU2A6nZ0sYZuP5gmQEopvJ+6lVoYXw+4xxVes4WV3n4QwUroExzpYqK23W6b4WA8c5syUfxL6Jngs8S8Fr+WH+ikHQnxDT+wZYtUaDh+HoH9//HO7/D7DPT+v8Zldn/bN16Z2itvnYNWqtjzgrhLYkvawGuXpMQjn8uryE2BVNz2CqaIPci9jJ1lD1s80sMUYTsJXOVHTS2JxYrJK47uhsYL5fkBFdiwUiCKG56xPz8Ydga8B9E+h0seH2fVr38VAIzxJs6niPI6K4XDCM4bwFuBjJPN3f4JdwqCfKfaKx9/U9F+K2/9ClXKLLJqWVYWh0jEVoYU0JekZNC5Fpk39jLJwaaTYnirKGIeQ7gEwHZd8zrVcGAtnA6x61ijSmlTlfEqGkGGXftAcvichqs6TnG++J7NNrtlHB+sQIIekbSz+x5Phf8wRF/m3qV4vf9oGbSm/M1bNPIg2nqDIEWztkWIgc1AvP7B26wYjt0JiMGymxQB59MhP4wioFnxzJnNrhqoyGnbJpBjk8v7Fh9u5h0SA7JfVYmKJNUYeS0iVCoVs4W3fFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPEPzIw/Sg8SdW9Ym8dXihR7UDcMzK/sPJ/e0oK9hQPzxuTNdKoFt3+8UAY2?=
 =?us-ascii?Q?STbOAeRZLJc7V+KxI4b6eIxkxoxRB/lR2hnm58H/+HqYoISqJ6OiYbJCvb4M?=
 =?us-ascii?Q?vhYwzPpQCI9q+ytgYnY3k/UXXnuRYCp4QPePjyHNRi3B5ARCjYXMvyUcBV7N?=
 =?us-ascii?Q?jFo67Ihj0kdkDDKil/K5b+2FsDEM35dcz6Ayaa6KSXDqhmp0jVOXL2f16+Qf?=
 =?us-ascii?Q?4fFZdMOPwXOOuBe7BvBDg8Y71cJJz8jz0Q+6Af+V3LftCQ159aZMMSjRA9VO?=
 =?us-ascii?Q?97DvRa/hKzzLRtlgtsLDaEZHrmL7UpJZlm25OsnO5CG1eKmna67Qs3fb2Dc7?=
 =?us-ascii?Q?ouO/7hVi9E3bDtFTUSbpP21oRfuTtorY2ElF0aDaSHoMrdfq96iyUvKXeEo5?=
 =?us-ascii?Q?ibsLnMt6rAd09iCPr2Zxl8Lg0pCjMgrjjB0u0TdEsB1z6Q16wL+UI1ewFpUI?=
 =?us-ascii?Q?BQQqYj8kaRtMztSdLRF6PzxTY0KYYYvhZ5W2lkmJUpH0Y5b20hW9BeHGBQrZ?=
 =?us-ascii?Q?Bvr5na6A7a+0c8Ms/Y7iJ1f2tlTXDQPUWNfPGDPaRDPUhSasFWBnk1j7cKUR?=
 =?us-ascii?Q?NPY+mxsfGk37a+prhShE3rg2NVfcuRSzcJIfZ/5hrFvZRScLnFWPf317QiNq?=
 =?us-ascii?Q?HPa8BWJIFVagNDvNsJisGOxlzRpIJQCwrSNMD90UopPwzEX+LPH1jUEBrvYh?=
 =?us-ascii?Q?rXCgdjp/ZdyuS41f3aqwkxcTm/jnrRbXjsvXKSUJ2NcBZA8mwjBr1RyAAcs7?=
 =?us-ascii?Q?auvVImEfP6xvxpEmWIikkHN2QihKgCFcB3qE3vH9w8VRgHNcTDpIboYh5H1/?=
 =?us-ascii?Q?rgPwRq9yWWrY5SZubDvAOrknujveAdqzA5u/0budCibUDmZsuJDvT/kqG23S?=
 =?us-ascii?Q?LsUs/A9RGSSYwj3OUXahYypHc83FQoyzML92B0ZYvtI1gft1Ke3HV2XtCvm7?=
 =?us-ascii?Q?jyWQNHyb5EEb8gWUo2tRTvfl59+YHKyqohSLK0B8cGCBlGdw40Gc9aqJj3BT?=
 =?us-ascii?Q?3rpG5xiy35YU2jUhVU2htTeehm7SnBTeHeZiuiZTInbjQMxyYjO1BkOZw3N9?=
 =?us-ascii?Q?5aI2TfmpfvHuDqgXfbq78q/Y6Yjj0AnYjrf6lp/gm92Ep/fpdlE4WrKEyrC3?=
 =?us-ascii?Q?Xs+tvEBA9MZo5d4eKskKXMdf5NxG9z/Pu/BK5sQx4S0ejCg8rxYPo0h8WBlH?=
 =?us-ascii?Q?dux7WSz9dmELwjt75zPdL4+/LaF4dU1Bkqa2jfQG1G/bJ35cgczIsp26ERgH?=
 =?us-ascii?Q?8dflgKkZyehuYLTH8uNn06cTDzOebL2iaW0kRQs4rb5uREuAS4b0CCAhhhmv?=
 =?us-ascii?Q?BR5ROxi8r3bRm/+sX3dcr0kixsKQb/ywu8yYuwMdIuY4T/Ky6JG0UbJ6vFSq?=
 =?us-ascii?Q?2eqzjFTjlG3GpI4UuoLZeRgGo8vLz4CPYz9+7Hf9+BUpQLXI1hXn8FqiOeKX?=
 =?us-ascii?Q?nGtROiRbNVFtQVN09YN1uz1yvVVwzPaHhjQxRy09LmLx10KKSuTZUa/mpwrK?=
 =?us-ascii?Q?edrKn/bd15xt5aT5WKoLQ0zMa9sBVBJIgKfbAbkavB+hh43GVsoNzmoHnmYI?=
 =?us-ascii?Q?BrPspUHNZnhPLgIW6MR+lc8CtSRH3kpyV4cQ/2U7z+LGVWYx93l0TV1nOCBx?=
 =?us-ascii?Q?olCZK4SLNC4CR40iDbS77IzRIUITWE/2xPAzqRDNNrLFcg0DL8ErI1ZY/0Rl?=
 =?us-ascii?Q?mw20aLPFVp1PyejAuT9Y8L+HAsCHVAaLcchoPGwjXdSt8s4XNVHTkGRhOCDT?=
 =?us-ascii?Q?crmOWb+mQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543625ef-f470-44d2-bc68-08de971f1349
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:34:46.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf91YS9foNrvNfocOmXYwOrHfB1h3tfw3o8M0yhZYE1ZiVm9ZWdGUF0noKKotOtWZWCUXV328JT4aZiXCeGzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664

On Thu, Apr 09, 2026 at 08:30:41PM -1000, Tejun Heo wrote:
> scx_kf_allowed_if_unlocked() uses !current->scx.kf_mask as a proxy for "no
> SCX-tracked lock held". kf_mask is removed in a follow-up patch, so its two
> callers - select_cpu_from_kfunc() and scx_dsq_move() - need another basis.
> 
> Add a new bool scx_rq.in_select_cpu, set across the SCX_CALL_OP_TASK_RET
> that invokes ops.select_cpu(), to capture the one case where SCX itself
> holds no lock but try_to_wake_up() holds @p's pi_lock. Together with
> scx_locked_rq(), it expresses the same accepted-context set.
> 
> select_cpu_from_kfunc() needs a runtime test because it has to take
> different locking paths depending on context. Open-code as a three-way
> branch. The unlocked branch takes raw_spin_lock_irqsave(&p->pi_lock)
> directly - pi_lock alone is enough for the fields the kfunc reads, and is
> lighter than task_rq_lock().
> 
> scx_dsq_move() doesn't really need a runtime test - its accepted contexts
> could be enforced at verifier load time. But since the runtime state is
> already there and using it keeps the upcoming load-time filter simpler, just
> write it the same way: (scx_locked_rq() || in_select_cpu) &&
> !kf_allowed(DISPATCH).
> 
> scx_kf_allowed_if_unlocked() is deleted with the conversions.
> 
> No functional change.

Makes sense. Nit: it's more of "no semantic change" rather than "no functional
change", because we acquire pi_lock in the unlocked context scenario, instead of
the more expensive taks_rq_lock(). Apart than that looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c          |  4 +++-
>  kernel/sched/ext_idle.c     | 39 ++++++++++++++++---------------------
>  kernel/sched/ext_internal.h |  5 -----
>  kernel/sched/sched.h        |  1 +
>  4 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f7db8822a544..a0bcdc805273 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3308,10 +3308,12 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>  		WARN_ON_ONCE(*ddsp_taskp);
>  		*ddsp_taskp = p;
>  
> +		this_rq()->scx.in_select_cpu = true;
>  		cpu = SCX_CALL_OP_TASK_RET(sch,
>  					   SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
>  					   select_cpu, NULL, p, prev_cpu,
>  					   wake_flags);
> +		this_rq()->scx.in_select_cpu = false;
>  		p->scx.selected_cpu = cpu;
>  		*ddsp_taskp = NULL;
>  		if (ops_cpu_valid(sch, cpu, "from ops.select_cpu()"))
> @@ -8144,7 +8146,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	bool in_balance;
>  	unsigned long flags;
>  
> -	if (!scx_kf_allowed_if_unlocked() &&
> +	if ((scx_locked_rq() || this_rq()->scx.in_select_cpu) &&
>  	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
>  		return false;
>  
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 8c31fb65477c..f99ceeba2e56 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -913,8 +913,8 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  				 s32 prev_cpu, u64 wake_flags,
>  				 const struct cpumask *allowed, u64 flags)
>  {
> -	struct rq *rq;
> -	struct rq_flags rf;
> +	unsigned long irq_flags;
> +	bool we_locked = false;
>  	s32 cpu;
>  
>  	if (!ops_cpu_valid(sch, prev_cpu, NULL))
> @@ -924,27 +924,22 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  		return -EBUSY;
>  
>  	/*
> -	 * If called from an unlocked context, acquire the task's rq lock,
> -	 * so that we can safely access p->cpus_ptr and p->nr_cpus_allowed.
> +	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
> +	 * lock or @p's pi_lock. Three cases:
>  	 *
> -	 * Otherwise, allow to use this kfunc only from ops.select_cpu()
> -	 * and ops.select_enqueue().
> +	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
> +	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
> +	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
> +	 *    nothing held, take pi_lock ourselves.
>  	 */
> -	if (scx_kf_allowed_if_unlocked()) {
> -		rq = task_rq_lock(p, &rf);
> -	} else {
> -		if (!scx_kf_allowed(sch, SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
> -			return -EPERM;
> -		rq = scx_locked_rq();
> -	}
> -
> -	/*
> -	 * Validate locking correctness to access p->cpus_ptr and
> -	 * p->nr_cpus_allowed: if we're holding an rq lock, we're safe;
> -	 * otherwise, assert that p->pi_lock is held.
> -	 */
> -	if (!rq)
> +	if (this_rq()->scx.in_select_cpu) {
>  		lockdep_assert_held(&p->pi_lock);
> +	} else if (!scx_locked_rq()) {
> +		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
> +		we_locked = true;
> +	} else if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE)) {
> +		return -EPERM;
> +	}
>  
>  	/*
>  	 * This may also be called from ops.enqueue(), so we need to handle
> @@ -963,8 +958,8 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  					 allowed ?: p->cpus_ptr, flags);
>  	}
>  
> -	if (scx_kf_allowed_if_unlocked())
> -		task_rq_unlock(rq, p, &rf);
> +	if (we_locked)
> +		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);
>  
>  	return cpu;
>  }
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b4f36d8b9c1d..54da08a223b7 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1372,11 +1372,6 @@ static inline struct rq *scx_locked_rq(void)
>  	return __this_cpu_read(scx_locked_rq_state);
>  }
>  
> -static inline bool scx_kf_allowed_if_unlocked(void)
> -{
> -	return !current->scx.kf_mask;
> -}
> -
>  static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
>  {
>  	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ae0783e27c1e..0b6a177fd597 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -798,6 +798,7 @@ struct scx_rq {
>  	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
>  	u32			nr_running;
>  	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
> +	bool			in_select_cpu;
>  	bool			cpu_released;
>  	u32			flags;
>  	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
> -- 
> 2.53.0
> 
