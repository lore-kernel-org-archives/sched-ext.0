Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DC3002D8
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854396; cv=fail; b=KJUV1K7s/GvsKFYkq37BMYzmdtNBzPPJ4NAdblM+qSiohdlFuBt7fGprvWtmufbOJJlzajxNzG/ZPhkFR47Jah0uya9ggo6YEALRil+wuLAGBk1vRhSWQo6BZtZRczWXHdv5e1baPK9tUjXO1L3uifEx01QTBb7l9cosKafraC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854396; c=relaxed/simple;
	bh=n/FbxXmCXl1c6Zqk+z4unaGpIkjQqV8+63yH4W3uxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4NtSRVf25HC6uFc7a1JtPm9ew1DO3456yFqFiCLixWSrEJMdNX7sOKxYuHMyxmEKdM37hpM9u4nF/+XGKd+t+Nd+4+EnGsslYbVIYeyUbxEwio+u3IbgbZxdLkjNVEF70cC1Zw9jukT6/1DhtGK09gbKzBZIrfeaEXZL4YNt1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQnQk10x; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQnQk10x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSG/STNHcG4cbjuxrwUE/XbApbIodOtZ6Q7fyEOoWe1NsQAPjPA/Szx3XajPzcAS5eQpBVo1/tSQzTnkQZEuB7QsAbDx37fmJm6sFzPluu3Zeq20rdkkDk5PLynR7FzgALYiw5wmfrar/nn2J1FwZW3dTWTn8cvzcDNx+/JZUvOvxxFlFg9jaf7wgf7Do2Ax9AcevSchFSJCkGne1xzWlqYSwv0w9KTf0h8fBx7yRnb3zlXWTRRyfLs3kkfrZSyTgly+XKka/ua/6piNutBU1GvfitBVR1T71Ra4mMcG396ZILFcEDkxYXsT8mfWTCaW6fyYGUnYY5dQeXxWZUmM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkOwulIFBTVGqjbaoho/L2mlXrx4y54vIpm4J8Ekr2Y=;
 b=qiTBqcNQMik/AOF1izyUoNsIuVF2h2AQwVmvXlXoEbS/vwVPN3LUuqcIDqCMBSZV83wNDIjZO2Ux75q/LTtLMPXZbQyVzV9eYem4jgDW07TgrLj98zBCKKp2lsm8rwN1IbLfykjLaeFrYOLvMQzYNW69ypPMA9OX4uYpJA11lZ4gvZRE3lNeYVqIpWtWY5fhXTSp0b29zkq1td+qLqgvQS9GwPgl/Dl4NDnJBUB9QKUrQoK1ziKdPpbwXQmxEQlpmqSSO4ypOkAl3Vc6iuNS28x1OaGZRX+MUbS/X8q9B+57qwiC9lDie1Gq5KSqIJwuNPmyRoFP7T61O4/0NjNHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkOwulIFBTVGqjbaoho/L2mlXrx4y54vIpm4J8Ekr2Y=;
 b=pQnQk10xhOXzVLMeZhHCfWUfg1s9c6WpXiaRgtNRcx0ChOIVMCfClTYARr9xAseI5Ggt/43O3g8et/WgbkzJY94jbER05NKavFI7JGnAlGCPcJdDU5tzEcYasSgAJbqJvlte2aYnvaIY48UYar05kEolmVwQZmZ0wPZEPJyAqdwww8hkzKykDNteUMbi7aPUbMbho8RlNmNxmmgthsUZov14D2e+8/tct8w48ddbM8On7n5PUuGVXYyaNgpzvYAGCUDUUooQ6X+x8TFCiQ0EV1qCyA/ZtpD3iP40iFRJT7tC8v/5bLCM4sPix+g/5ujWWAndCZOewkXZGAMOK94c/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 07:31:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:31:28 +0000
Date: Fri, 19 Jun 2026 09:31:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: check remote rq eligibility
 under task's rq lock
Message-ID: <ajTwP6tQxR_6UGsQ@gpd4>
References: <20260618170047.283701-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618170047.283701-1-jpiecuch@google.com>
X-ClientProxiedBy: ZR1PEPF000077CF.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::406) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 364db3ee-042a-479d-a67c-08decdd4c65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|3023799007|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LvfNIMpA3TMwYqL7zzMwQpUVzFKA5GjKAeuvHIDv1o8SP5j/R9a2+m+WWFn69/KotOoj+QRY6eiW83NN9ZDPqB1q+dzX7vZFpZsvUExEn3Yk21JW2fVABnAMwpERd/kDnWJSH2JFLp1PDr8bMqAKk+pm7mpiqOI47sHf7cdemeOsd3qJA5UYkXHHLPEaRKnLp+8uHNqEKhhYJ9tSC9gnq0PNxqL8Uj+qn6w3FESUuyrkILVSrfOQegGpyS4NOgfGhKY84RI7tDZS6uZZNzbsmCoAzVLSDNHMC8pW5DV7ZX+2I2H4zfeCij6POLVohDT92JZZIXlo4+MQwmVBOhjU6k23Q86B4uvzZGcM5IdoJMsOACn2K8VZLg8jBrviA0igKE8hF/1DeSMKWvkTB1OHjRKyvsqgW8nfKlRuDOvn2sGNys4Sk80MCzCiEAAKTER9WTNRUSfxmcZaAvQyFNuuP+hoSbogWyN4uJoNIDq4vXYN6ZQmShHP/Cv9dCymmOrmHxD9dURXwuIvTrAxcZWFLksS9b4p2+6YUvZyAtOQveIbshtd+hC+NwSpIJJys7wk0CjvxDyPIfDa7djAB656IlqG/iTOyRO5VDavJqldfgvxKVm7DZzWTv2cqcWOnocckvkg4TNCyj5Y+bEdqrRBU2ypDLhiprT747gp9qvOWU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+MnoFXCCeSaHkra4G1HW5S+WlMoGuMlg7xr/9qf11olQRhEK6nOgy6waW03?=
 =?us-ascii?Q?A4UwBiCjupTtWZhCxB/rm3OxY4IaCMqr/D+aEDrJgHBinDJHdZCf/6ji0G3Z?=
 =?us-ascii?Q?R4wUrjC982ukUQCahk+y43Bek2D4g1a1Wzk/H9XWoEfaXpx5oH58NCOhLGTZ?=
 =?us-ascii?Q?bNMmAp2lt0P9m42bZRen9f6GAFmTT3qS9sMgYVfSrWPO9GcPfRy+EtQxOPZI?=
 =?us-ascii?Q?DjGaXBwfVzW3j/nChHfUwomf85PggpjQHNIvNCNdj8+MlLjCOtDYOyjAHoTn?=
 =?us-ascii?Q?einh9uOFjrw6NFm7CDe9aqStcZ+MMuxnfgBG683akDMDKK7iZodTHHuTBCPL?=
 =?us-ascii?Q?Hmwhue8BzilxKKUWMeK5T9kCFhH4JxJnLnOxxri9r/mRB6uAHqJjwbo5//Yn?=
 =?us-ascii?Q?ze2d04jnZxeTiQ+15TWpV6dV+7HHIalmsK8GkWVdrZoSVnSqYNLxiXpKr0UY?=
 =?us-ascii?Q?/IpprkgzDy/ZuLGIM/YbntQ3fVrR/Q6SAWAMAZH05aUM2ZElGfuRZ7pf6jBd?=
 =?us-ascii?Q?mAflhaZdDZa3FQ3e1rIvKUohAcDtA5Clvj/2VzCwEHo6OkM6o0aWdFESG4Mp?=
 =?us-ascii?Q?ObFQgMPeBbEkH515UtGabVzvKADiaxjDzt8eXheHagzmfQr3RFb30sZ7EgfK?=
 =?us-ascii?Q?JJ0BZo8viVtcaRGLqSt6+QXHviJQlzoapA7zs35Nhu3sfvv3ocncRIUUu2ht?=
 =?us-ascii?Q?9WP1E/tXjnF+0UurBb40CwnCf/ZkZd67LLX9VDD9owirAbB2N4aQbdiyQmGt?=
 =?us-ascii?Q?CcwEFEnvJlVtHLebZSQwR7/T0IMpWUCHieZB/Z4Aj7t/waWU0pZCPL84DkYh?=
 =?us-ascii?Q?tZMYtn+YNT7nxkWkaS6aWBWMyEoYrtvGvgLZlnhWoQ4nNxgOh9kYd3BBoeyI?=
 =?us-ascii?Q?h6/NH6cuyl+wfeIcCvWAT/8msH2hjNy0gETUMS3qIqaRD+7/Z9evnnZL2lxK?=
 =?us-ascii?Q?51zVR0GVURWyasuWS18Dr1YhmSfnyBgeJhvT7ezcxlx6+ZXkdFYn7sjphGcn?=
 =?us-ascii?Q?3IbsoM6hoEQIMkM2GTEp7v4iZFh5GHFv96YimEHYlXTypdjGDMp0QNCvLypU?=
 =?us-ascii?Q?cvzgqVgTqNhyg6uAODplBIs1vF6aRSkffNxidHlNqTbQIKCK+XGQDnZo2oXG?=
 =?us-ascii?Q?H1dwyrbH2MlJ+hkioMI2xEQwwZbjMVDMrzCRA44jT3DkAdhHO1/NZ63iulfq?=
 =?us-ascii?Q?Unug5srSIgQwWHaXqUwIMrPwoSJgohZhrCn2pK7UdC1MpXXx17Krij+Z6kKe?=
 =?us-ascii?Q?T4nA/GkmIObUT1hz+YnC/7N49/uRyt/NoSs1jgIMxxElt+yflTXdfokZP8+j?=
 =?us-ascii?Q?PwnNn0XIe0sBUEONumqGhJN1QfeN2fZvTxy4i0AqjztK8JeeqygwsES/9ecf?=
 =?us-ascii?Q?5KOgK2PhdAOvNwNABrygNk1aEOWs+ZL+sWzvm8TeoTCN7AjH/dsZJci4/Cs0?=
 =?us-ascii?Q?hgUTmow6bArfxurxGk5ZvIcOIOoaRd1AKtjMecDW7jfH62AeKhDvf0l7F7q7?=
 =?us-ascii?Q?+m55X6PeAkMdlNxXMyGj73NwEYRGUR4AGGuSwksqUI3VezWZ8P/bjRmZXqSp?=
 =?us-ascii?Q?wOqeNbBhLbCwsXGfCWMBx2iRaokggUmV9leSRy8q3pzSEOxCXhAVr9pEama5?=
 =?us-ascii?Q?VOUkknxUWZAc3eC44FhAEv+LKK+kMJt+fuHIFEWCWYJ9b/yR+qJRZLvaScvv?=
 =?us-ascii?Q?UXsOx7JdIFvlkDzY1SAdNlTWYOaA6Piz4vSMaTV51/lOB0VXXCzupYx1q9gs?=
 =?us-ascii?Q?nJwEFL1Wjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364db3ee-042a-479d-a67c-08decdd4c65a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 07:31:28.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKnVwtQ2HSMkJgN3VSpA6cXwOHCrXEl3NNYjy1bKMWFvQzSKWpFk0TpxyBFVIv5JU432lDCtFDRcCP/HFmRmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

Hi Kuba,

On Thu, Jun 18, 2026 at 05:00:47PM +0000, Kuba Piecuch wrote:
> task_can_run_on_remote_rq() operates under the assumption that
> p->migration_disabled is stable, i.e. if the kernel observed
> is_migration_disabled(p) == true, then the BPF scheduler must have also
> been able to see this when dispatching the task, and it's the BPF
> scheduler's fault that it tried to dispatch a task with migration
> disabled to a CPU other than the task's current CPU.
> 
> This assumption does not always hold. It's possible that the BPF
> scheduler saw is_migration_disabled(p) == false, while the kernel
> observes is_migration_disabled(p) == true in dispatch_to_local_dsq()
> -> task_can_run_on_remote_rq().
> 
> The crucial thing here is that with CONFIG_PREEMPT_RCU, migration is
> disabled while a task is executing a BPF program. So, if there's a
> situation where the BPF scheduler checks a task while it's not executing
> a BPF program, while the kernel checks it while it is executing one,
> the BPF scheduler will be killed through no fault of its own.
> 
> Consider the following scenario:
> 
> 1. SCX task @p is executing on CPU A and CPU A gets preempted by a
>    higher-priority scheduling class. On entry to __schedule(),
>    p->migration_disabled == 0.
> 
> 2. In put_prev_task_scx() @p is enqueued on the BPF scheduler's internal
>    data structures, making it available for other CPUs to dispatch.
> 
> 3. CPU B enters ops.dispatch(), pops @p from the BPF scheduler's data
>    structures, checks is_migration_disabled(p) which returns false,
>    and dispatches @p to CPU B's local DSQ.
> 
> 4. On CPU A, @p hasn't been switched out yet. Execution reaches
>    trace_sched_switch() which enters a BPF program, as the BPF scheduler
>    hooks into the sched_switch tracepoint to detect idle->fair
>    transitions. On entry into the BPF program, @p disables migration.
> 
> 5. CPU B enters finish_dispatch() -> dispatch_to_local_dsq() ->
>    task_can_run_on_remote_rq() which observes
>    is_migration_disabled(p) == true, triggering scx_error().
>    This all happens while holding CPU B's rq lock, so it's not
>    synchronized with @p switching out.
> 
> This patch fixes this by moving the call to task_can_run_on_remote_rq()
> after @p's rq lock is acquired in dispatch_to_local_dsq(). This way, we
> synchronize with @p switching out, since @p holds its rq lock all
> the way until it's switched out. Thus, any BPF programs that are called
> between put_prev_task_scx() and the end of the context switch are
> guaranteed to have finished and cannot influence p->migration_disabled.
> 
> Also add a lockdep assertion in task_can_run_on_remote_rq() which
> ensures the task rq lock is held if enforce == true.
> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good to me, but we should also update the "Cross-CPU Task Migration" doc
in kernel/sched/ext_internal.h to be consistent with this change (see below if
it makes sense to you).

With that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

 kernel/sched/ext_internal.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b76633c52c96a..b63d80ae21157 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1471,18 +1471,20 @@ static const char *scx_enable_state_str[] = {
  * The sched_ext core uses a "lock dancing" protocol coordinated by
  * p->scx.holding_cpu. When moving a task to a different rq:
  *
- *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
- *   2. Set p->scx.holding_cpu to the current CPU
- *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
+ *   1. Set p->scx.holding_cpu to the current CPU
+ *   2. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
  *      is set, so clearing DISPATCHING first prevents the circular wait
  *      (safe to lock the rq we need)
- *   4. Unlock the current CPU's rq
- *   5. Lock src_rq (where the task currently lives)
- *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
+ *   3. Unlock the current CPU's rq
+ *   4. Lock src_rq (where the task currently lives)
+ *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
  *      race (dequeue clears holding_cpu to -1 when it takes the task), in
  *      this case migration is aborted
- *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
+ *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
  *      into dst_rq's local DSQ (no lock swap needed)
+ *   7. Otherwise, verify under src_rq that the task can be moved to dst_rq
+ *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu
+ *      and enqueue the task on the fallback DSQ on src_rq.
  *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
  *      src_rq, locks dst_rq, and performs the deactivate/activate
  *      migration cycle (dst_rq is held on return)

> ---
>  kernel/sched/ext.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6567f626b3f0..4ae7ca4e0a41 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2422,6 +2422,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>   *   no to the BPF scheduler initiated migrations while offline.
>   *
>   * The caller must ensure that @p and @rq are on different CPUs.
> + * If enforce == true, caller must hold @p's rq lock.
>   */
>  static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  				      struct task_struct *p, struct rq *rq,
> @@ -2429,6 +2430,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  {
>  	s32 cpu = cpu_of(rq);
>  
> +	/*
> +	 * To prevent races with @p still running on its old CPU while switching
> +	 * out, make sure we're holding @p's rq lock so as not to risk
> +	 * erroneously killing the BPF scheduler.
> +	 */
> +	if (enforce)
> +		lockdep_assert_rq_held(task_rq(p));
> +
>  	WARN_ON_ONCE(task_cpu(p) == cpu);
>  
>  	/*
> @@ -2696,13 +2705,6 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		return;
>  	}
>  
> -	if (src_rq != dst_rq &&
> -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
> -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
> -		return;
> -	}
> -
>  	/*
>  	 * @p is on a possibly remote @src_rq which we need to lock to move the
>  	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
> @@ -2729,6 +2731,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  	/* task_rq couldn't have changed if we're still the holding cpu */
>  	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
>  	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
> +		bool fallback = false;
>  		/*
>  		 * If @p is staying on the same rq, there's no need to go
>  		 * through the full deactivate/activate cycle. Optimize by
> @@ -2738,6 +2741,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  			p->scx.holding_cpu = -1;
>  			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
>  					 enq_flags);
> +		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> +			p->scx.holding_cpu = -1;
> +			fallback = true;
> +			dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
> +					 p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
>  		} else {
>  			move_remote_task_to_local_dsq(p, enq_flags,
>  						      src_rq, dst_rq);
> @@ -2746,7 +2754,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		}
>  
>  		/* if the destination CPU is idle, wake it up */
> -		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
> +		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
>  			resched_curr(dst_rq);
>  	}
>  
> -- 
> 2.55.0.rc0.786.g65d90a0328-goog
> 
