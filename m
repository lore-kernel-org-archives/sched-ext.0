Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DD2E7635
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008874; cv=fail; b=ddPFTH0K4Wn810ARuCprF0nk5ey1uVa8BNamOgGpnX8BpqSnB40JEDjakpMUM4ttmCkbzUF6MOZEYmsip3UMKh1IqIzECGC3plXLnLsZfGXcQGql3zJ2lMpa1qEbmxnwUMMsNYLZAeaSho2VO19tz2qP8XfZv6IF3Z1AL9Mx0jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008874; c=relaxed/simple;
	bh=djYIqiaT9yichY8nmQzDprQ6b83yzkP9wq5YZFMnJ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dA+D5op9Cs2B4o1XGF3Q6hqS/drv/V3FoM8IxU6lRccCK03Y9u+mPg2mlu72z8YkD5ccT4He4obN3cjx20+vnZqPgyAGCor6vW4Putq4vNIGuLnq7OiRmJ3w6ppBHqKZbKeHVV77fk+6+QXEDQsIlxxyO/zlN0TfpEjFT4UWdkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oR0i0a8k; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oR0i0a8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZsZ0X7UCg1Edzqyk11yds0r4yA6Mo+rmDzPB2y1AZji5ldbeEwfkJ5+++vH59Sr6phIKtTJI3Rp3+5QKV49AaB2lelrxSVYzmbCQyylz/9qBEKEKXVSY8tl0QaUPzQ5ZFsn68hT57ZHlCYhzlGDzAvs/dYRhdXoed0sISOjqTac65180nHipgcD2q5MvnruG8bh83iir0VX7XwMHlGcminrZMq/jAB0+3uAlsvrgiA/jOPUWlYi1QOdQEPqX5JaaRsLD08iyhONgnn34Avom9XXwAKv3J/cOqcLP2G5QfF6+HimV9j/9g5pDUpVKuOUimhN0J0vYC7VdZi9Eclz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4xRlsO0n32ZwwjiOW6h4d6TWIikuysZCCJMvg/jeHA=;
 b=lR5StxW5gZHBUwr43OyTe5qInEp5qNXxyRB/pPM1+7iefF3rc5wsydeJj8vbL3YRc6nHBu+CrwzgRWxLqZGpH/ijH7s2xsrneSJ0PPT/U81OnqWQcOpPKPcBmEaQhTlVMkk/IMXNZRbjKB1aHqj4w+QmgmJJ9i5VX8kcWGSx9ASORWh+JWDdZHViFEB3WLMT3qWrcFgZeFGneDQoiLwiCuPhXQmOtxyWp577ZaXqWJYoe8cBHvK4Q3Dkqrmnoe+tQ2cZvFehApPj3504XlzlnErGhSOFIjGfDHxcCk/cDVYUaH0JET20YNRCPKHzTKAYyUuRJEJMHckyfVAffpulFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4xRlsO0n32ZwwjiOW6h4d6TWIikuysZCCJMvg/jeHA=;
 b=oR0i0a8k8yXmV0upBlGuDb6LlqHAthNTcrSSwULhzyg50lHw/kFWNKfzdelARHILDyGf6bAbAWAmLkspf0G5rk8eLlRmLtQJpz/ZBJ0CORuGBxComWWTr65IY+RybKYwikJMlRfsGdklrhL15LoGvXAdmPxTbC7yr3psicKduqmaTBUbKqBnzQwv3HZmYr9R3blNCC9TeSJ6YFRxyc+pxkB5qwNgsc7a6ifo48zBOTj9vQeApIME4Ew8Ck/1wM+4nEAUAfSV4og8zw/DIfHKelQ+M+guJiFVeUc/pn2SNWwwczVyOgWCUkLDkkklBqOajs61JqkA78WB16YGjUsA7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:01:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:01:05 +0000
Date: Tue, 14 Jul 2026 08:00:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 16/33] sched_ext: Add
 sub_ecaps_updated() effective-cap change notifier
Message-ID: <alXQmHduNITfgdct@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org>
 <20260709225041.1695495-17-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709225041.1695495-17-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00007543.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4ce) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb793a1-f865-4afe-d973-08dee16d4ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+L/xjxnfZTpeD0sxWGZ9yEFX/iHzq9bQXaGHH/zzeDnQO1YApSPVL5tZUtS42FwDyTZtdWkJfL+lhCpXflFHXm1gjz+2aPQwmm3UCiO314iwZT02OAA1apjXjenm6NEue3qvlV5h/AtXS6Dyo7VwigFeudEO1ABUSv4/6MsO4QY20rd5pn7nMO+Ug4oKK+pFL8RAs3+pglIoI9gy8bJ7ecQunzjtZf+nPfou/2i49n2xgLH9T0S3o+fH3/aFpxwtTkkO/piKKBO52DmkieEvvGBCBeqcg7B0jvfN9ZaR3GHbHWipA53TU4VlE9Feh1rKr7ggadDCpybGmwH0HOAR067M0C/EhSbZzN6lxoxySJ/pL2A0gZ8hSBanbyEQjZoE7SylzKvqxiJVto42YwJBPhg85ezNCTkkog/rQ0Nz5zsJ944XNLG3rC9u+K0y5MUYxy0QogAisnbJEJG9fpjphOJVmCVEtaC1qV37khnmrP6bZNwnNffGW5DcP0rhHfaeR/GodTnrwynaRoUB7KQbPFW1HLaBZcmVvdEoXerHhPSNIYmcOB74rteDdpSyRlZbcCCzl4HzNUWQw915X7V3eG4ebeP548Wh2/b+kzUdXY9Kxv2jEHxaXW2MuxPo9Q1NTWhHHrvf8Li3HV9QJ/17y/1oCQoWM4vucyF35HJ0oPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Di/+PGX6yK3L3YNA2IPTFKWH5HvhdBM4g4E3e89WkmPnwYhMprqfcxzVho/M?=
 =?us-ascii?Q?DerjKChNONHVkCYzLSltJdvS9O3+6WsB44AoeioFJtwvpq1GJSN/2kDMFgaU?=
 =?us-ascii?Q?OrJzfrMYxo9zyFVJjeYYq7IUrFGfDnME+Ejr9LMLaEmpJLrKrBWArGHYdBru?=
 =?us-ascii?Q?K+xYgpqGWivU5F3cxYD0qtJPrdep/dm/yvJatTCy2bg2FfyfH8HAfnX/koAe?=
 =?us-ascii?Q?HOyTJY9pQMAYDW6Qltu4db6wh7VXOf21+bRiOs4FbljIRDwcppRkdD6RH5uC?=
 =?us-ascii?Q?wmp8bIKhhLhnRrxLuvzyxkyp84oRRYwLIci7bVuhiPwSWXkf9lppO/Dq6wCg?=
 =?us-ascii?Q?Uc8ufQN1avdJl08sDACn1eey7eWhv0kPU8gzzGomTcHLFY6CUHiJoh0buYGH?=
 =?us-ascii?Q?Ehpkzk5UBXf5OWBC2OyJC4fzzLgcmfxU2VVDBhyHJvk3ERLOWq9E544CZSLG?=
 =?us-ascii?Q?o1uKP1aV0iibri3txq5+runP6Lf7K6kAUXdmkDD5oNezaNur7EBhBovPdaUV?=
 =?us-ascii?Q?KaAjP+cZZNb1UJmAEZFbWL1W+sg41pXH9NvdubSPLmwSxGbj0KpVweOiSBa8?=
 =?us-ascii?Q?/3PV04u1Tp5TFvVb2wmURCzIhU6kbmHyFPKVLfQ0rvEbLvvUKzwWV/mNNk6W?=
 =?us-ascii?Q?jRUau+ML0TQVrwY14j1d3lTDL26NPJcIyyyGlexW7GKx2OCOmNDOvabEB2Gr?=
 =?us-ascii?Q?NXFbft0eSPFEl6z4wJ5vzUTg/pDxyK7HqhgXyiejYHsn3Oux2teeXydsCJ8H?=
 =?us-ascii?Q?JX3wnny0tKLssc7LhKGtNoea0B/ASLhB23mPBFyADINMsOomwq8zMGkTMiBB?=
 =?us-ascii?Q?ZQ76QQBY3cBcEZ6/mX0ZYzwPNwy9InnFx/k1bRgH+M5TkppE7HvxuKWaH+/M?=
 =?us-ascii?Q?dSmS+PS1PjftyVSZMv42qeIT7qMLeRsTsiJuVr060elwtbxZ9dRt1Tzri8uj?=
 =?us-ascii?Q?tUjgfjvY8NmA65hnHQSwnLqxLPJKIokxZYAXsxtjWzj1HrMA1RKNV5V3+4h0?=
 =?us-ascii?Q?BqqEJ51OobjUFzBaiD20mTKrckrpfs6qjLvgMCliWh2PM4pXnOxWtgaQ5vLm?=
 =?us-ascii?Q?2viVlrWp/QSSAm4DUgX8uogxfQRWfBcsi4McECyLdFf1zIKmOX6A3ZI1kPoP?=
 =?us-ascii?Q?VPRjtntzIIaXP3o2IYfknupdfKA8bDyhfJ5Qxp3su3uHQDuvPlH0XSruJ6WP?=
 =?us-ascii?Q?Ro9u6QFl7yx0k/4ApFaauFwxsTw3GrWRg2mnd8I9qObhj0F6254dXv0mlO0s?=
 =?us-ascii?Q?jG1Tnw8K7drrAOFarsvTgi30Q+zBLKd4C3WgvvIqdzdzwzUW9YiBNWlTNKSA?=
 =?us-ascii?Q?QdIXTD7nnwgIYWn97ypcqelFsYHEnF+oECkt7pbY77ZGnGk4YRYRdZ1YftHH?=
 =?us-ascii?Q?iO1lN89DAuOSKX3AsBnDAL5ivtqJxoSlHPbAxBTSPnli4Pv4/vNW5CjTgYVs?=
 =?us-ascii?Q?QyGIP+TSq9QskAw3wfUTeaX4tEMPdxnfc2TjPPFPvyLSEuqGJrIChNjLxkUg?=
 =?us-ascii?Q?S7fPAabEM6Dta6gSorbDRFZIrEHN0vaHliYNEzudEuH62n+TKcktXXZpSej3?=
 =?us-ascii?Q?mIu5b5o+7VdbuvwYbYn364l6BXGJqj+cQc+6kNt2NtT0T7RkePhyvFsEMNDl?=
 =?us-ascii?Q?KnNaLFfpa9eJv8d6SmvW1RklQ6OwUi3W1R/9PE1dB+gk7dbfILniZmjHh3j8?=
 =?us-ascii?Q?Yqrey17r/nirJuJUzXaHO7T7mBYZLdK04qAMZIkHr6YWl3kWVF2eO9vU31fz?=
 =?us-ascii?Q?Ko7lj3l7gA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb793a1-f865-4afe-d973-08dee16d4ac7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:01:05.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LePuMKAdIVrtho54n1w3AIVtrpGUB4k6uQ6SRr3aZjZTUJrOInpqJyFNtKP8RVDRR8ouwEQAqnXDXILzhkQ+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881

Hi Tejun,

On Thu, Jul 09, 2026 at 12:50:24PM -1000, Tejun Heo wrote:
> A sub-scheduler that gains or loses effective caps on a cpu may want to act
> on it right away - e.g. place or preempt on a newly usable cpu. The existing
> ops.sub_caps_updated() doesn't fit as it is delivered asynchronously to
> scheduling operations and can arrive before the per-cpu effective caps go
> live.
> 
> Add ops.sub_ecaps_updated(cid, before, after), a cid-form callback fired
> from scx_process_sync_ecaps() when a sub-sched's effective caps on a cid
> change. It runs in dispatch context so the sched can insert, kick or preempt
> on the cid directly. @before is the caps as of the last delivery.
> 
> Cpu hotplug rides the same machinery. Going down zeroes each sched's ecaps
> on the cpu's cid, with queued syncs discarded at consumption while the cpu
> is inactive. Coming back up queues a sync for every sched. reported_ecaps is
> kept across the down/up cycle, so the resync fires the callback only if
> ownership actually changed while the cpu was down.
> 
> v2: Compute cid below the active-cpu guard; discard queued syncs on !cpu_active(). (sashiko AI)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
>  /*
>   * @pcpu's sched was unhashed before the grace period, so nothing new queues.
> - * Flush its pending sync so the pcpu can be freed. scx_process_sync_ecaps()
> - * takes nodes off the list before syncing and acquiring the rq lock waits for
> - * any in-flight walk.
> + * Flush its pending sync so the pcpu can be freed. If the cpu is online and
> + * scx is enabled, drain via balance_one(). Otherwise, discard under the rq
> + * lock.
>   */
>  void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
>  {
> -	scoped_guard (rq_lock_irqsave, cpu_rq(cpu))
> -		scx_process_sync_ecaps(cpu_rq(cpu));
> +	struct rq *rq = cpu_rq(cpu);
>  
> -	WARN_ON_ONCE(llist_on_list(&pcpu->ecaps_to_sync_node));
> +	while (true) {
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			/*
> +			 * scx_process_sync_ecaps() takes the node off the list
> +			 * before it is done accessing @pcpu but does all of it
> +			 * under the rq lock. Off-list observed under the rq
> +			 * lock guarantees that the sync is complete.
> +			 */
> +			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
> +				return;
> +			/*
> +			 * Discard only when the cpu is truly down. cpu_active()
> +			 * is already set when scx_online_ecaps() queues an online
> +			 * resync while SCX_RQ_ONLINE is not - so test cpu_active(),
> +			 * or that resync would be dropped.
> +			 */
> +			if (!scx_enabled() || !cpu_active(cpu)) {
> +				discard_queued_syncs(rq);
> +				return;
> +			}
> +		}
> +		resched_cpu(cpu);
> +		msleep(1);
> +	}

This is a nit, so feel free to ignore. I was wondering if we could wait
indefinitely in this loop if the target CPU never reaches balance_one().
However, I think the only way to never trigger balance_one() is a higher class
monopolizing the CPU, but this can't happen because of the ext dl_server.

In that case, should we document this "dependency" here? Something like:

/*
 * The active EXT deadline server guarantees that balance_one() eventually runs
 * even under sustained FAIR or RT load.
 */

Thanks,
-Andrea
