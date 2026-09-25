Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18F3AE6FB
	for <sched-ext@lists.linux.dev>; Fri, 25 Sep 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322419; cv=fail; b=GCgCyRW5rI1nJp9N+T4SbebuHdFicS7E1PGql2CTNltZNPSUmiOgsVx9Zu5XasWO6pAPeBf0n+QIIWnpj/OgNKCzLmzseG7/85qnNtnSk+e60MuLDwbzN6SOZIuBahfRCuQ75ZPBNhn5qsM6P3rdwlo51P7xECyGx0KHPlvC1zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322419; c=relaxed/simple;
	bh=y4V68VuJn+pGunNedmSr5WnrSR98AEfzTwahoL9YfYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LwNkbaYF9SrHdwWmBQSlAeXNwaG3Fv41Tp+9uGCNLnC26ftzLtyNvvOteryc+yUupQ38s9PO5eILZkFmDnpdgXm2zlFjaaIxQaCTKVfjTTcs8/UnFiZ+k8pAGS2E285Ut4cl4xJ08f9A2hm+QqjovUGFRF9vjoxEe73O1Tneh3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AtCcrTU3; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AtCcrTU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoiNptk7R9Pm70OAMJoWH8XbqFTWfH94MKnRAqqZqwOCtdJb4BDDMn7upkyRjdW+C+QNxWaxnZH5r70AvCerwDSeZ4rH9GCrlvteqjsGaJqsxlKYM8aDAFHhEXg59zRvejGBqQew2zFDPmc6F4uBGDsfqEzEOrIZFx3xzt4kozSir36MmiD0qp+jmBg6uGRYl81IAJ5jB2xJV8UO/lpbuYCN28fMdUGeSOqBcI8NexIIBiQq+rIwCooQamIvte0+G8+XmaNnXs45E8bq5Y83c9MVQXGV7prsJ1VlVsDHfKzBcXw41w4RijG9tIFRHiFekFSfW+qsbkbUvn4ueAMGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us5z7RoyrMVLLkJ7wFhHmXsb3LS7g0ULbu3+OnjHmuc=;
 b=O0AaM1lbFira3GtPqGsNMcil5k3kSf5rFeun4Qfwj5woGFuk196bmXIkfLIr4oUp0lFckKBgxRrOgEGjU9ZDAU8LcxNKe8PpEF2dCj6iIP6MTFDB79PZOyfP4oKJSmgkDglGmWFbzVFaM9UzvDRDnSWhvHXDadJTCpiYK8Cdlc7mBwvsV+LBG/ymY8wgwFQB/id7DkLYiV1a2U1aEYb5otGNle165dBiowy3OuEIv3iiVUFxEI0efMRrhrcDUrodJrx6QGrv5ayrmplUo5igwZCiZGP2TzIamTUa62CbeEt2ihOwjHfY9Let21xQNoyUppWI9RVWb+GQLywR2gwpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us5z7RoyrMVLLkJ7wFhHmXsb3LS7g0ULbu3+OnjHmuc=;
 b=AtCcrTU3yruBdIP6Si26GVY5O0rsxyUWseTGHayFzc7+u4C+OIOLUmgU7bHJ8Q0Ygo/xaMMuScP7OyCrWRm+BjdQkL16RapCxqvS2gNnRKTG44iovvC8iSbllgDxIXbETtoinL4tkEDQivHJsXU9EM4zo8zfXjmhLLib6fZBEeZ5EcmXlu0pF18H/ik7vszkmHnQgfHU9iYKIwPVTM1DbCaxNp5m97Zmjcm2oRYJv5adVj/ZaJX6odYW9Gnm+s/fuds9Ey0bNwbeMoRVFXUfqhs5Q0iMv523lfaVJA+2gto6Tmq/oUpFbi3Vu1ZejxncyX0F9kBDFEzq15Zszcuq4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 07:46:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 07:46:50 +0000
Date: Fri, 25 Sep 2026 09:46:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <arYm4PPMhevWQWsK@gpd4>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR0P278CA0209.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::26) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9905b44c-f15f-43ff-2ebe-08df1ad9287f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LWbohQjt4FZRG+YtrvkakuqSCqOVKwDKI+X47mvmiFvBIBPB0bU61vZyuNOE/+64TqmE+nD+Uy8QImMq0r1Bfxt3/vwRVylbrkzWqCCnxj9cRtRcLIc2451lgho8FtmL8ziZLF68YNzAa/TNyTNxTK6Qqhu92PwN/Xd4rZEmAQa+ZteMl0R4dUtyWrIV0kbKDaoylIyW91qzyicxXKb5FGx1X1Yj+xhzIdATz5bsC8cZHvx12maqnClELgyajDqnkcEsS1B8SBptDq9gkVJS6avPXp1xWI+1qA6ZRz/F5Ff+C5dNuU7NGznMXCLVZk802wmH39vC1eJBzNAgXMWIZSeGbRvT0zPrhRrKgKY4hheqPxsFoxzZzMPQK8Nyp26YzpEpb6YeTp0CK4y9qLVJ1r6WObE2O3L5wOPeuDJIqXibbcuHweoFItiObUxjyMoDhVne3ULIVw5opjq+PocUwvBRy/1NUe3LIvbDj7boJlZWqYG8NRb9HIfPdpq1dYMP8BQ2x+ICCGWPbntQjkDbzELCHQnj69doSVD6yIwtMEEZPtMuvEVFXVBuR9e7lkZ//AHND/3fMqxMW7QTKtYJP31uYzIPv2f/kYGoicd1xsmsxW6r6TMvtXRCLGF9+HGlxqh9SzketZk7bIpn/kc0lLDm3Iz1r0GMB2hM8Qv1HeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPJ9BCsTyW8qgn6MWqvTcRAPASSaNc0kdDM6cQ/kZDj9QerPJLJxl32pJXl4?=
 =?us-ascii?Q?aPdXFHfeSBrSRhf+42AOZKuQqmf/OgV7QvhAq4QYSSWVIqc5n9dZIiAjw0ri?=
 =?us-ascii?Q?TDNBpB2MC6+YvZsdD8UAzxd291x+LGGiiaQ8xtoTlEXEfrJ10N4pEgrAXkwR?=
 =?us-ascii?Q?Yc09mIP5VVr50nGcBp9HNIFGaHOvycflllzfiVAPzrXgeGIhc+pcd9RioJrK?=
 =?us-ascii?Q?n7WqEgAYaD7bKUOwex+5BBrVPn8TPXcTPu7T/6bjxqAazpSPTKG4QmT9jXb6?=
 =?us-ascii?Q?Lln3GyvGZcOHfyefDHsNyZmNFGuEK/3LzxoC/5cotTuvyShRbIaIooQHISLy?=
 =?us-ascii?Q?yc4ynR2VTMy6lMrS6094cZDtYw2DoNx1p3tgBduEVYp9Ep3NHFK+9AFpwHUK?=
 =?us-ascii?Q?iBTm8BVmVJEUTFHPghf22JHJqpMlA671RAPRiJQ8r2MBdA2p+VXCfpQHKp2y?=
 =?us-ascii?Q?is6PgwRA2DqpB2segEuJX0Dxj6mN9N6fBlWb8DdXRCgXNJOvIkXtPHRmRnW9?=
 =?us-ascii?Q?w/CCZicfrIb92BHbSxcqxn+T0XVuFFQZysD6PbdJdzWfXQpfMwALRT98XV7Z?=
 =?us-ascii?Q?ETB/yBHIQIN3TQ1PPIIuanH0/6kXKfErFJFzpMjMwwQrKJ/4UkrmSQTBC/og?=
 =?us-ascii?Q?fbv5OzSKbFH9ptCcTwKrgbhxyvPYuwo2/ghHcKs04jSuAIA4oylvDlRZshU4?=
 =?us-ascii?Q?0GyD1t1cLckjgrR9NrQnqj9QELQjFV/FeTJZibWP1aCOcBfPhOonXKKKlLNf?=
 =?us-ascii?Q?0rGj3ydUSD6MoSKj+Sjod0qO8gSuqRfGnCa7Rs6OGZ483n6jdNlVX4dYqzFe?=
 =?us-ascii?Q?cgtiyZDOvt0xAqwwDz1cwskzMR8Oa3S1qc9ktmrhZ+lMndIcAnO3krAsZ6Gp?=
 =?us-ascii?Q?0QSAG+6aXn4bt2zwmrMZPKuXpfRgEGgOIzMlBzaB/DXez02LFVi7bAL46qJg?=
 =?us-ascii?Q?si7NCQ6UtDUCa/YehS4PMZwldGbHCiHzDgV/FRXXLUZEQw/tnHtlwdsccjVb?=
 =?us-ascii?Q?qMUa77EpkpO4CGMPcMIa8kQ+xha+XZ6ecMlA3tF2rbSuWqEb4/SebnU1RJC7?=
 =?us-ascii?Q?b9Qs7rfHHF3MSbl3mLUH1zJlq86RuxGbKrrI95uiwaKX+H0iEXA/Om+Zl7I7?=
 =?us-ascii?Q?TwuEgoqGPQ1/v9i6ns8KMZ04qd2semV5CEpnIuLsa/6ERd5lxRHKwLqCkbel?=
 =?us-ascii?Q?VOtoX0XBvWnDVZZt1ETp17XB6P66lU2om88Rkr989U7ieq8z7U8caDE+0Ahc?=
 =?us-ascii?Q?I+zZDuwXvL7n0u8Z5TrJwvROLO4PmBAOJQKOptCfuhUpyFBd1jq3QQ/X1RT0?=
 =?us-ascii?Q?jm93l5+beDluMN09ox8dIwEQ8+iUjwP/AvqQHSGbQ6uZZgWOUXNkhaIq5Qk+?=
 =?us-ascii?Q?+x/+vbREFinQ4sJt80GZi8mekHFCTpyL6vy8PXPTxGz5LjMoUD5JBCdkssrl?=
 =?us-ascii?Q?VgnVMwhj/TEYqEyLW9Zq7Z+HHQeyGDjsaWqg+2wRN9s7agnw8NTKTXurUxSY?=
 =?us-ascii?Q?kYSEWaprlSZeeC898Yx3ZhdFd62Tac7sNZCl4Z1GFh7BK4ZQaXssJy6Bwdoy?=
 =?us-ascii?Q?jaqi6TFlxHPZJe6JtWRT57cz8Zx57WQ84pUlSJN2WKiUlWZxytr4tO7BW3WX?=
 =?us-ascii?Q?T8wyX0wBZAIywJ6PvK6GQOrJoTnJ4Tj94Q3dcZd/2E1wq8/ZNhgKk3LmwiWs?=
 =?us-ascii?Q?n53MiKaoyij1NkJ5esvN0zfqNje4I2E6EM6MlguFIglok1GxCO9FA4DVqxDQ?=
 =?us-ascii?Q?CrMBCStXLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9905b44c-f15f-43ff-2ebe-08df1ad9287f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 07:46:50.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHmTtZmjO1MAqdpV3dMIkGcdjhdyUI3x+lLnYrwMWh5yHS0GNtouek4LGmZDXO+yUoNnLrLS7J6juqCuqr/R0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C

Hi Peter,

On Thu, Sep 24, 2026 at 09:52:37AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:
> 
> > Andrea Righi (16):
> >       sched/core: Drop mutex locks before proxy rescheduling
> >       sched/core: Dequeue waking proxy donors before reset
> >       sched/core: Mark wakeups completed through ttwu_runnable()
> >       sched: Add helper to block retained proxy donors
> >       sched: Add sched_ext hooks for proxy execution
> 
> Right, so these add:
> 
> WF_TTWU_RQ:
> 
>   Used like ENQUEUE_DELAYED; could be fixed by generalizing that to cover all
>   of p->is_blocked.
> 
> scx_allow_proxy_exec():
> 
>   Hook to kill proxy exec for scx
> 
> scx_proxy_reenqueue_retry():
> 
>   Like put_prev_task(), but for current. Ensures current gets put back on a DSQ
>   once its done running.
> 
> scx_proxy_donor_start():
> 
>   Delayed set_next_task(), confirms donor will be used.
> 
> sched_proxy_block_task():
> 
>   Almost like switching_to_scx(), except it needs to change ctx->queued in case
>   of p->is_blocked. Hence a new callback ran before sched_change_begin().

Yes, that matches the intent, with one small clarification:
scx_proxy_reenqueue_retry() doesn't directly put current back on a DSQ, a task
that couldn't be reenqueued remains on the reject DSQ and the hook schedules a
deferred retry after proxy resolution.

> 
> 
> 
> Now, I have:
> 
>   https://patch.msgid.link/20260917-sched-fair-hrtick-restart-v4-1-4dd1414da81a@gentwo.org,
> 
> pending, would something like the below on top of both this work?
> 
> (although I'm not convinced SC_CONFIRM is actually making it better)

Yes, this works.

I applied Shubhang's v4 hrtick patch as a preliminary commit, then added the
SNT_CONFIRM callback and reworked the proxy-exec series to use it. sched_ext now
confirms the donor in set_next_task_scx() and scx_proxy_donor_start() is gone.

I tested the updated series and it passed all my scx proxy exec tests. The
branch is available here:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec-next

It's not an obvious simplification, but if we want to go this way, we can
express both the provisional pick and donor confirmation through the sched class
callback.

Thanks,
-Andrea

> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1876,7 +1876,7 @@ static inline void uclamp_rq_inc(struct
>  	if (!uclamp_is_used())
>  		return;
>  
> -	if (unlikely(!p->sched_class->uclamp_enabled))
> +	if (unlikely(!(p->sched_class->flags & SC_UCLAMP)))
>  		return;
>  
>  	/* Only inc the delayed task which being woken up. */
> @@ -1904,7 +1904,7 @@ static inline void uclamp_rq_dec(struct
>  	if (!uclamp_is_used())
>  		return;
>  
> -	if (unlikely(!p->sched_class->uclamp_enabled))
> +	if (unlikely(!(p->sched_class->flags & SC_UCLAMP)))
>  		return;
>  
>  	if (p->se.sched_delayed)
> @@ -7268,9 +7268,10 @@ static void __sched notrace __schedule(i
>  	rq->next_class = next->sched_class;
>  	if (sched_proxy_exec()) {
>  		struct task_struct *prev_donor = rq->donor;
> +		struct task_struct *donor = next;
>  
> -		rq_set_donor(rq, next);
> -		next->blocked_donor = NULL;
> +		rq_set_donor(rq, donor);
> +		donor->blocked_donor = NULL;
>  		if (unlikely(next->is_blocked)) {
>  			next = find_proxy_task(rq, next, &rf);
>  			if (!next) {
> @@ -7283,8 +7284,7 @@ static void __sched notrace __schedule(i
>  				goto keep_resched;
>  			}
>  		}
> -		if (rq->donor == prev_donor && prev != next) {
> -			struct task_struct *donor = rq->donor;
> +		if (donor == prev_donor && prev != next) {
>  			/*
>  			 * When transitioning like:
>  			 *
> @@ -7298,9 +7298,10 @@ static void __sched notrace __schedule(i
>  			 * on_cpu.
>  			 */
>  			donor->sched_class->put_prev_task(rq, donor, donor);
> -			donor->sched_class->set_next_task(rq, donor, true);
> +			donor->sched_class->set_next_task(rq, donor, SNT_PICK);
>  		}
> -		scx_proxy_donor_start(rq);
> +		if (donor->sched_class->flags & SC_CONFIRM)
> +			donor->sched_class->set_next_task(rq, donor, SNT_CONFIRM);
>  		scx_proxy_reenqueue_retry(rq, next);
>  	} else {
>  		rq_set_donor(rq, next);
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -5069,8 +5069,12 @@ DEFINE_SCHED_CLASS(ext) = {
>  
>  	.update_curr		= update_curr_scx,
>  
> +	.flags			= 0
>  #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> +				| SC_UCLAMP
> +#endif
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +				| SC_CONFIRM
>  #endif
>  };
>  
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -15887,7 +15887,7 @@ DEFINE_SCHED_CLASS(fair) = {
>  #endif
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> +	.flags			= SC_UCLAMP,
>  #endif
>  };
>  
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2636,7 +2636,7 @@ DEFINE_SCHED_CLASS(rt) = {
>  #endif
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> +	.flags			= SC_UCLAMP,
>  #endif
>  };
>  
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2641,13 +2641,17 @@ enum snt_e {
>  	SNT_NORMAL,	/* set_next_task() */
>  	SNT_PICK,	/* put_prev_set_next_task(): prev != next */
>  	SNT_REPICK,	/* put_prev_set_next_task(): prev == next */
> +	SNT_CONFIRM,	/* confirm pick */
> +};
> +
> +enum {
> +	SC_UCLAMP	= 1<<0,
> +	SC_CONFIRM	= 1<<1,
>  };
>  
>  struct sched_class {
>  
> -#ifdef CONFIG_UCLAMP_TASK
> -	int uclamp_enabled;
> -#endif
> +	unsigned int flags;
>  
>  	/*
>  	 * move_queued_task/activate_task/enqueue_task: rq->lock
