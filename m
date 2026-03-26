Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DA34DB59
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508777; cv=fail; b=mFO5i9Rtg3yY8KVxcK1o09ZUU0LfmvvFeUp6smCVOiLCYmHHrFvZ2UVpL5pu6EVLxT1LQBvswmfmjOHMYfLOxF20j/bLGyklem/XtfF8T090XJKw6AvxISP754p5NT1Mcz2Dnk/XtQsVtYHE+9gsw95bz88wmoUfl5/JAImNsr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508777; c=relaxed/simple;
	bh=E4LsHnLXWrvMHs1LB03Y4UYTT7L91uBVa+iPjElfPVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RPnhbu3pSmVwcfceQGeWudMdUSpNdTK7Oke/4xNztO74QfQJDtkTvHuQ6Kp6stT/qAFLAPDFF92Bp8kNK9UOlSimMi2/rz8tj2OsT1LyC78qvma9zpZzsgwedM1/8wAsZl6a/N+WKB0q7s6TlIrBjC/OutXpdZmxHF+DaRz4cug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9+EnHls; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9+EnHls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d11Phtjhegep6QakbhWEcHOUMTb6Mzvcom2upIbKMQ7OpGkxs3OeSncHBY49PFAlnLCJ22HqUjIMpyki417StXFhP0oZlp9oTIXUG7rxF645xPoyv1NkX0Q7wdHdkf5to/xWFm9pE80k/TuBVFiIBTW+N09g/Dr9tNUD95BeJaqYVyWm2x/cfyldt4iF1egOrYBeM7a84G5lxBHhRa3+ZADNzan3IOQslvt1CCTic60rKoI+YmiMJVzZrlpNnot91hjyiC+r68uNOpE8Tct92ssiDMtqhl6k/MGLkp5ZtvE7avNGzVnMIPqJBVlvau6QJvUBuvUWfxUdLSypc74TMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej4HvGSxVybnU73jZNCDYDgYJyX1Qj0+8LGNJ+BPBCA=;
 b=H/7szGOuDMEuYTqcXvAhN1KFLLwbXzckWLUT04VX7gQU/WzhzO8bKVWzhOT3vIoXycUZaRE73VWnMRQuVevYznwNj50I5kGAMnGaMoxuI59r4+y8Arx5fu2yolUkvUpeyqEbSN956r4qN9Rp6qqnENic8e3GqZSjpEkBkfdJoDvG7yYLI3G6T3Wj4iM6UQupyfl5r0P+6ExOfIua62dVZndD8U6d7CGQjzq3MYkr+X1ffF6iKiKQkuVlD6bdaXujheed8StWAz+sze89s9eQfGoeGLTT0ocijOPxUlx1yC16Ro/OrLWWTLPXBsY9ZvYTLTdOh5pyQ4vGuKy3chPBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej4HvGSxVybnU73jZNCDYDgYJyX1Qj0+8LGNJ+BPBCA=;
 b=g9+EnHlsDEEPU9yEvNzbh1LI+axEr0ja5jwVr0CT9OgSO2b85DJAHQcPQ9gwKm0V5UkBe65VDfx+OgEfX1DYG7Y74Wjy1U4ojfkVEjV4ukZjJ0mGphzUbo7Fv5ioTQpNbKww4BM1/+zhCNktVuJ+y8aKw3++TAroHIp7k6v1J+U93MlNWk/pR2i5dWtoJdnWsv4v5fQC7RevQpPGOX/juKgCXjhxIvaygkdSm6mjBWmpQaSkdfiUxZPdOHdVJmx1YaQsRcFQrIiVmaD363DYgc75Oh/MKnidxcBmxpTfOUA1VUVSRCyVNMYLnVZhDRfwjP4AIekLo43L3uGdLLIqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:06:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:06:12 +0000
Date: Thu, 26 Mar 2026 08:06:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, peterz@infradead.org,
	mingo@redhat.com, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 3/3] selftests/sched_ext: Fix consume_immed test
 reliability
Message-ID: <acTa2k5Fkhni_e7L@gpd4>
References: <20260326022827.3826287-1-suzhidao@xiaomi.com>
 <20260326022827.3826287-3-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326022827.3826287-3-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce9928f-32d9-4c46-b445-08de8b062a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3k8w7uu1nKKENBV0U5MpPhmHjJKrBXhpm/RKJOyl/iusElnn8bqa8GLuf1t2RIkILQTVIahCCpuDs/oYBy9t0CR/7S9aPyKQlmt+xW9+RWkU8mR0o1oREqbm4d45vQlS8hzXWt6iTJm1RRi5gr0rZWf6LzJ1ZOkKajvGu6qXMZCO1Cbt5lLC3S0wOAnNwRXr7nuy0VOD70ixoU4eJTsfrjHjVZ48ipvOXUTh6VgEfYQn23UGlO1eXI3X7g2LAm2GESRQLyuOtYSMKYVQ/z87aj3Szt8MRA5AWy+UmQn5ziXndD0WdJLIFECgDKNzW3sKkLMZsYTmf/GHnS9IlJuFjT//z3uibulepM/UH+ugKbYVSq7IuzirbjBUtOOKWlKdC3+QBDY/xCOYbEDiAxRDRWWcubIc6d1GHIbepJieKxcvM3CqnBdUI+g2y1RajtjzGDgePCy+kWU/t74rRMWcPoP8hNANktudlaT98tJ0C/+Xsp8/GZd3VOUwyCQ0mAj/TUfUwApMO1OVrisR7w/TJv2BUnoU9seLQ7Kl0xTZY5RpWl5qovTLI4xp7pNOHHg1dcnyNHZDU8bVzdHokFFKAMRsRrMvbaROt/ZIIfFlotcMoKHdWowqsRbL2nG7wtL93dfj/Y8N1t/fQhE7mIhdEcBdtSPPSesAI8BfGkp60U9MddxeYCj6DBKxQps+NtO5jwGC1T/ZiVSVubokOn7b0VS4zHQFwrH3qtyseKwtlXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3acU7lLINMdXp+96HAr1zflrYbj7oO0XZriaL8zDENk46yQ27PC+jVnVunvq?=
 =?us-ascii?Q?iObv5xXL0ThFJ/lHnndn42wzXwd792tugiW/CyZDf88TMhym8Mo7FRHvBpA1?=
 =?us-ascii?Q?NwHbEQZSJRSRCI9V7ttNYKbTS4bXTSX84xbnM9ti+oPblIWMx6qr48XE1uXl?=
 =?us-ascii?Q?01QmE0OezZe+1nh2uimwGUfhREz41RA3ee1mXh8sDUTAZgEhIsoPRrh+qxof?=
 =?us-ascii?Q?ruCXyJLl33kRd3l2MQGxNzJbwRTrG9a0ceWhMTglHfk9nRjlaFWQJ4D873vH?=
 =?us-ascii?Q?/asJ1uVZxbi5r3upzY3bvExC8Nkh4SBgKbAMqnPnoyjwItn+KAxgwYDhY/Ym?=
 =?us-ascii?Q?Ou+fCWTq3FpsS1+dPw4Qq3l2Xslm8BD4gK81PpwwWuYXs3l/XjvbdWJ12xCw?=
 =?us-ascii?Q?OgwaKQMqPCaqFI8RUQbCI/OyaTAqp89sn+YwfWk1a/FhGr+fViLr7hmSHAeR?=
 =?us-ascii?Q?ZwLbkxzEm9qfC/tYw7Lj661JQ1b+uux3Q0MY5hrCj/5nmSHv9/T7Bb9PuAJ+?=
 =?us-ascii?Q?wf+o1YVN1GKk1XVvgjQbESQuKa58C9jHyaejhagyTT40uvxPmJ6C9ZS2mvo3?=
 =?us-ascii?Q?q/RiQxL9Amd98lL6OLHgUQcn4Cy4fhb+j8bmcaUk/HgQgDG5LrZH0wVooaLv?=
 =?us-ascii?Q?BCpGKLP6QcKCCE5Wmj+E8rV90GKXzOgV5WHULeogP20wdcDNCCrPsms2X6ZA?=
 =?us-ascii?Q?JyT+eLZCoCFhow7Kd80FHamR74lC9wiIKCV8KL4Tk3mkW+mE6oa19YD3bgLv?=
 =?us-ascii?Q?MGS3S4H1W5pAgTBCfBNYwm6I1tLsL/naBjKXPX8EJ3LNvRixD7fKVnAv0Urn?=
 =?us-ascii?Q?Jrf7TAojsGc6TGDGP4tZ7RbrBBr4ba14Hz2ujRWZPgE9kI/3zdC1rA6BjUdw?=
 =?us-ascii?Q?7rfHmZryWtxe03fGExi6+OzZFQRJLGxMIHe0gawqZa+q4gXLULteWcuPal4e?=
 =?us-ascii?Q?zBFQV6kTruVGc/ZyqXkLVh9N+HXhhqfCrQMw2auoyEDyJ1SkeRoI89vZk5dy?=
 =?us-ascii?Q?KErZDyHr5WMDLOP3Aip74yFIt3emTqpd0rrn8EJOR94Vi9RhRAER1KXlskMo?=
 =?us-ascii?Q?G2JIor3m+jCm7T9zoHfUDhWm/u0dQgjY7b6RW7psGaBVLyd/N6GHF+dsxwuP?=
 =?us-ascii?Q?6YPBDYmzKmCX5eB6Y10AYyVPSPjaiMyKnPItK4ZJ8IxrD0aUXNKvV8h2kalB?=
 =?us-ascii?Q?Erzk/C/UP3GE9V9+0VJ3twpixDjZhBrg+yGoV3jMrGbRCqTuB1yHhpmbXq8R?=
 =?us-ascii?Q?LDR0p9hwA8oNkPy91hFexJzc9WyI9umMXmwuyD6gxMGuXRYnmgE6uIEMFyjY?=
 =?us-ascii?Q?Euhq6YcfnLrPDUuwhQr2A3AuMaSYk29UaoC7c2Ydb53Suz/F8pmbA73bE3qy?=
 =?us-ascii?Q?jIgfj1NlOZf3t51BqrItkiqDw8rvcNwH/ZDNzo207+R2quYNg1POIs48iCJ8?=
 =?us-ascii?Q?WKIjQw4T84VoHuWK04P95Ef8A07lNYpjVfWWU10bS9FebJKiyvvOoPPk6F1p?=
 =?us-ascii?Q?ciJ49flavZStCdLepDTQrZFDdyDmnYSmn23vvBvnyk9z8gyXoyoK15JcC26N?=
 =?us-ascii?Q?ypP0sBc0S8XwTv071cYX+3QsdtlFJL7Pek1qnyy0Gug5PWv5AHEh9HadhcPk?=
 =?us-ascii?Q?VS9qNe+GbBS67Cpe8m7dKnFS7cHCh38DQHXf/8e+UGNGA7B+lcd6hTzC1ccn?=
 =?us-ascii?Q?HAfalFGl8L4D8FAR9jL2dZqrHsRxT/6g8L8caWnlolGFR9hNXHL/PDxTZdoZ?=
 =?us-ascii?Q?F2tDnAbT+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce9928f-32d9-4c46-b445-08de8b062a01
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:06:12.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFhJ4BWcy2Xbb4z3YpcgctUgryUqMalJb3qbp7nQXNvxlgOF8qcCEPXaTXXgkD4kbFAbDA8IzY9DmznCOXCLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928

Hi zhidao,

On Thu, Mar 26, 2026 at 10:28:27AM +0800, zhidao su wrote:
> The consume_immed test was failing because nr_consume_immed_reenq
> stayed 0. Two issues:
> 
> 1. Workers were spread across CPUs, so CPU 0's local DSQ rarely
>    accumulated multiple tasks. Fix: pin all workers to CPU 0 and
>    increase NUM_WORKERS to 8 to ensure USER_DSQ is always backlogged.
> 
> 2. ops.dispatch() called scx_bpf_dsq_move_to_local() only once, so
>    CPU 0's local DSQ would contain exactly 1 task after dispatch.
>    The IMMED slow path requires dsq->nr > 1 at the time of insertion
>    (in dsq_inc_nr()), so a single dispatch call never triggers it.
> 
>    Fix: call scx_bpf_dsq_move_to_local() in a loop (up to 4 times)
>    within a single ops.dispatch() invocation. The second call finds
>    dsq->nr already 1, so dsq->nr increments to 2, triggering
>    schedule_reenq_local() and the IMMED slow path.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  .../selftests/sched_ext/consume_immed.bpf.c   | 25 ++++++++++++++-----
>  .../selftests/sched_ext/consume_immed.c       | 14 ++++++++++-
>  2 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/consume_immed.bpf.c b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
> index 9c7808f5abe1..e99bea0b2c24 100644
> --- a/tools/testing/selftests/sched_ext/consume_immed.bpf.c
> +++ b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
> @@ -11,9 +11,9 @@
>   *                   explicit SCX_ENQ_IMMED in enq_flags (requires v2 kfunc)
>   *
>   * Worker threads belonging to test_tgid are inserted into USER_DSQ.
> - * ops.dispatch() on CPU 0 consumes from USER_DSQ with SCX_ENQ_IMMED.
> - * With multiple workers competing for CPU 0, dsq->nr > 1 triggers the
> - * IMMED slow path (reenqueue with SCX_TASK_REENQ_IMMED).
> + * ops.dispatch() on CPU 0 consumes multiple tasks from USER_DSQ with
> + * SCX_ENQ_IMMED in a single dispatch call, causing dsq->nr to exceed 1
> + * and triggering the IMMED slow path (reenqueue with SCX_TASK_REENQ_IMMED).
>   *
>   * Requires scx_bpf_dsq_move_to_local___v2() (v7.1+) for enq_flags support.
>   */
> @@ -55,10 +55,23 @@ void BPF_STRUCT_OPS(consume_immed_enqueue, struct task_struct *p,

We should define a custom ops.select_cpu() to make sure all tasks are
bounced to ops.enqueue(), in order to have more inserts into USER_DSQ,
something like:

s32 BPF_STRUCT_OPS(consume_immed_select_cpu, struct task_struct *p,
                   s32 prev_cpu, u64 wake_flags)
{
	return prev_cpu;
}

>  
>  void BPF_STRUCT_OPS(consume_immed_dispatch, s32 cpu, struct task_struct *prev)
>  {
> -	if (cpu == 0)
> -		scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED);
> -	else
> +	int i;
> +
> +	if (cpu != 0) {
>  		scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);

Hm.. this should trigger an error, you can't use
scx_bpf_dsq_move_to_local() with SCX_DSQ_GLOBAL.

> +		return;
> +	}
> +
> +	/*
> +	 * Move multiple tasks into CPU 0's local DSQ with SCX_ENQ_IMMED in a
> +	 * single dispatch call. When the second task is inserted (dsq->nr > 1),
> +	 * dsq_inc_nr() triggers the IMMED slow path via schedule_reenq_local(),
> +	 * which calls ops.enqueue() with SCX_ENQ_REENQ | SCX_TASK_REENQ_IMMED.
> +	 */
> +	for (i = 0; i < 4; i++) {
> +		if (!scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED))
> +			break;
> +	}

Why 4? Two consecutive scx_bpf_dsq_move_to_local() should be enough, right?

>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(consume_immed_init)

We don't see this from the context, but to check if SCX_ENQ_IMMED is
available can we just check if it's != 0, instead of checking the
_scx_bpf_dsq_move_to_local___v2 symbol?

Something like:

if (SCX_ENQ_IMMED == 0) {
	scx_bpf_error("SCX_ENQ_IMMED not available");
	return -EOPNOTSUPP;
}

And remove the same check in consume_immed.c, because we're already
checking it in the BPF part.

Thanks,
-Andrea

> diff --git a/tools/testing/selftests/sched_ext/consume_immed.c b/tools/testing/selftests/sched_ext/consume_immed.c
> index 7f9594cfa9cb..61cbc0fe3663 100644
> --- a/tools/testing/selftests/sched_ext/consume_immed.c
> +++ b/tools/testing/selftests/sched_ext/consume_immed.c
> @@ -12,18 +12,30 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <pthread.h>
> +#include <sched.h>
>  #include <bpf/bpf.h>
>  #include <scx/common.h>
>  #include "consume_immed.bpf.skel.h"
>  #include "scx_test.h"
>  
> -#define NUM_WORKERS		4
> +/*
> + * Use more workers than CPUs, all pinned to CPU 0, so CPU 0's local DSQ
> + * accumulates multiple IMMED tasks at once, reliably triggering the slow path.
> + */
> +#define NUM_WORKERS		8
>  #define TEST_DURATION_SEC	3
>  
>  static volatile bool stop_workers;
>  
>  static void *worker_fn(void *arg)
>  {
> +	cpu_set_t cpuset;
> +
> +	/* Pin to CPU 0 to saturate its local DSQ */
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(0, &cpuset);
> +	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
> +
>  	while (!stop_workers) {
>  		volatile unsigned long i;
>  
> -- 
> 2.43.0
> 
