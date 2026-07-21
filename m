Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2246EF60
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662694; cv=fail; b=LhpWo/3Xsex8gAocwot+gqhmMrWL6sek0Cwcy+EGKSlVlULs7cvkYBdAUeJkV0CqGXQEztYZBlX4L2NFBZTaPSpT3JAYHL+OSXqDkJiBL7YbGTIuzYRI3djyqS65zEqJtBQZ9T2asu+zK+JUi9KYQ7yuRul36N/zveAWBRyJna4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662694; c=relaxed/simple;
	bh=yPazfngumULHix8jI2370c8MG0D5Iye8iP60MIOquwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rvI1BH+Xm0Idb54legmotWlR+M3ftPiniPrf4D+7xhjjTSc7a+jR4xNECyRKQlBLxnqWQfJQl3A68cyhCiI6Bs5kUJz79RncmoZYdOh26UQuth1BpfHSm1Llf8MhVrRpFObSq8cd6Bsf+9V6gPq/iwdcEJENCkTLfT+se/RcuQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2tsn8Wb; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2tsn8Wb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX3oqTyaESMlcGj1JfGrZCNYCHlUWar+Mok+S7smuY6pNXTa8NcvXxJhwwIDme6YGwbiS5Y+qE58e57gmT4/MbzV0zsiJKXIsjKbIRAYGmOAaUT5HVHlC3gWo9ifZy5zjSsUjtJB+YLtpJdkFdrewcxfXVBFjK9Z6clocmG1CMN2DvWGowixou80wk4S/snsUCTtjdldo3k9qwggGy5gWWJogdPzqmdKOSgHDid0ig9cNnq0RA+t4Qkrjn3ictj1eGNVaghnQtQORjPe2F0ljbe2Lq0s1VIQOYMsUsYP5FEpZgrhTSSvqUD4ltL3NEl2gxMhR57nl9Y9wlJR6FKU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idzMqmP2L2l4H8s+TLQVSb1bHo+BUammNpzxWvsDDYA=;
 b=UmDJNXkIsYuWVc9BRh3q1X77nD2Elg1EYMtHeLE5+FFBSYhUaLWQYMbBSCdW0VZDoBM9Xa018BKuMQ8VbPuMTF3ueiZElMsN7zvxmmPdt62KJDdwDN6+NhhQdp73sv09LYQRNu3Iei/upvJ6++xZ1WAXfE8NoJ1uxSf0XQkcqkhg+vSHSwcJ1bFPOOOirvb4OaqB12u1HVwxF5uep5L5yq/p7u2ZA7VhtyZuCGvWl8nGnCYUa2gkSpFkkHK90WwW3rZIlMme3ZmhRci8mzAP5qqPycgzHyTvYsLt3VD1OaAa68T18C+15g2RrlPTWtKHH9vOqgldEzbwmCApX5wn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idzMqmP2L2l4H8s+TLQVSb1bHo+BUammNpzxWvsDDYA=;
 b=E2tsn8Wb7cG69AknUqodjmpRxgk1+zTiLHbbdFc4yBKZeSIgX2NzC4D1b00P2MHkovp9sLwsdg3gF6MeAdV+XQakom8rck/1vWs9ZhFlI96anF2VTfc/OuP3YpVtme65ceOf79dRtrt9Pskzd6PsnuigBqTYXKpIsxK/l6obElbvITxkcNNYvZerYOb0xDCvQJAXhfezmqedCFcs6Epo/w4BdOywBgS9BdHtiNq/JWvqqYoh24CweOR13U+JFl7jyqDZMnamyoW1t+vNu/91+9bhA1sQXRDbzYG+7xZN4Ye7pX+odhmfOb7WgGmt+0wTDpCtgE3di07PA+a5OdKdnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:38:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 19:38:01 +0000
Date: Tue, 21 Jul 2026 21:37:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] tools/sched_ext: scx_pair: Convert to
 sched_switch TP
Message-ID: <al_Kjns3FrkBgR4W@gpd4>
References: <20260719142917.34238-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719142917.34238-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2735fb04-f090-4f49-ef7a-08dee75f92f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|5023799004|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8asQ4grU7DHXsPj8fd64QKo3uP2f9ajFUyKWxEx1rmvKOP2kNzYucXuD3Sd21xtIiE/V5A1EslgJB29OK+lH4ZkjsxqS942Caxpl5SqzRUQQoyyQ9wD8k81e3WG8KD3gGvAEnzASz9HwDgqFGqXZJhQB3KsHDFagDgDqFeOHE352XwQbb49YTkbnmu6jdM61cJxXuZ4E6nvl+mu/TnJRia61JTXhgWbb8jR+XQS3xYifiMVZOYqLahjlD8m+y/mGiT9o3d0bUliN9x2twTtaWJO3TP81lxTNWH2f+0Q/n9eHAAW3uOf35YK5uEhmCVEcnKjfo5UWLOHVjd2N4HhD0xwK+a1jWQCTw15AyiAr2e+GTvjuLfJUckEsAwx0hxujE+AhrNKqUqLirybwRR5etoTA/pbFM23f9XRDgiwh+Lf9zE3gYis9kmbaNrn6jhjBpQ0m81CYJmzvbudRiCYPeO+GLZsGcTyTU2zYNRgcv3Kmbm8MWQ/OmFJnlczxMaOXVk+OneGd9hydY3sMvse0t7nbQ51oemTWb181oZO9ykEk3gIqQejQLr1c5DcV50c8p4Los/vWQQAYBIrSWoqWTZNpmTJcQvOLvudtMkmp2USMEwtyadlXyJ3OFxCePRhNQIj1Xfy4NmpM7rdW3VuAXfwReAEPQQUk7HALrJpeyYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WzAJzkwyhBm8Zd56ytgmJKvNeLgQO0qu69SuYhqeFfgqpEXWirdRmc4BjCKL?=
 =?us-ascii?Q?OQtJh8YjcW9e0ZO4jM96GFla/ZvWvXiDYJDwE/hcyWynPyoAhnfKUmCMlgiZ?=
 =?us-ascii?Q?tO6JLmENHA8zH9jMFdRM/SiLkhVm+UcrUaln9H2X0+W/z9SJOXtsq76JjxLl?=
 =?us-ascii?Q?9aDrvvy+WXWjRNR3q/MZP3q1DGwPXp2fQtZhsg2cQH4YnDYPc8R0rGFvB3Ix?=
 =?us-ascii?Q?ZWGMBpWdh7tSq0URtozckJ64SzKNVdRYS4nHigzPicSXOZ0LtjUlLd1InD7t?=
 =?us-ascii?Q?Jp59Qf2PMVxWutl4EhQii3RP+jbGmShLYWGdu9Mii+VNAiBlUab+Nitvp1iC?=
 =?us-ascii?Q?b0cBJ70XXm1CrBH9PVyz4JVT8uxea28RRIwAd/L4UsV1d4zWwRVP8TbHh7Yb?=
 =?us-ascii?Q?rFUCZIPAJd+SsOc5GnaWo1f5zet8PKwltJqGeUwUbrEe3TcXbRaBt7QJK0kk?=
 =?us-ascii?Q?9+KGxqRj9jURFmPi7NW7xWQtHfivOlWymWCnMkaCgBjzCwg5949Ga0yNSoKG?=
 =?us-ascii?Q?MvesSEwCUTBu1du8EvoVUaSsSm7074a14JrB7lVfT+in6a2rUVPqscSw31CB?=
 =?us-ascii?Q?lpUa02pW1wj/Cnz5NzKvAmtBaA0hvetGD2/U8E65JTY8I6KvFTWIaoDCwEB8?=
 =?us-ascii?Q?Oy57lxN/JMqRtizlYFiLaFrDDPr0sz9Jjy+o7LPfWtFVZYCnizczrNb3Xn1w?=
 =?us-ascii?Q?F9tIXN1XXdk84bLfZBBwBJKbRQ8UGEg3GF1oMempfio3IsPbGPBnAo+x2tBv?=
 =?us-ascii?Q?RYeDfNqg12e96vyO5MqamUIjyq4tAXrLZn36P1oewI5yq1Ij7s1xUPlo9naP?=
 =?us-ascii?Q?tRbzFHGk/hTteMsgvxSQSO3NCPJxImdQBTEMD7ZGNrnvY5fDQkBO7H3kwlPs?=
 =?us-ascii?Q?Ll0msGHB/NUUx/0U3Guyp+YkQ5lKc2+6xNOibdJgUlJywVs68fIe+fe1jYKV?=
 =?us-ascii?Q?HaBpKXrMyOPQAtGTZh1APyrqs+t2AkOHS/XIPkaDBat/thhSlSQGicvWBVxf?=
 =?us-ascii?Q?/e1j/ZLGOdFf8n91BD/E8f1W6g1gsYFEXLyvT8avp6AHLh3znRmHXSAdXXe+?=
 =?us-ascii?Q?LhlIfN47HDYkKJF9T73CrgPTqCjq0Sq02E0wunbhlJm15jPUs+Ywr6Wh9LpT?=
 =?us-ascii?Q?rYEFU8iDMg6qVlFrApFFGK/sitQ2YsZshuXpm64GnCwGubNcJro37cX9gBho?=
 =?us-ascii?Q?BFzUt/+uikMxUODBT6wmspaDUh5nvcsaHkrZY+CjmY8rKvnnKirAg1SQ9fkK?=
 =?us-ascii?Q?dNFvsjBaclhT4oGVjL3OjSIhubnbMeh6U+DkarNvi6JIllsp/qZLUb1Vy8bP?=
 =?us-ascii?Q?FFoiGxh6FWJcNx3+htOem67Q4cNhJ+Mr5CT277GshFVqR/DlD+A1hpwlBPOX?=
 =?us-ascii?Q?qE+R+6BVgmWkKr6vQ2DXifWKwrsbqguodnaH2sFn6IwRpbqT0FTUkjZNAreJ?=
 =?us-ascii?Q?ApN5S0eVDxKiEObp+yIYqM+4SrlVTYisiaa8T/e2yCFLBGzGnaSQ8ata6pr6?=
 =?us-ascii?Q?eLBZyBLVHneBDVV/sXI5KOTTTk9Nw2udFRxwqIER0711AZHMVV8IU5mm78Z7?=
 =?us-ascii?Q?dwPDv+3EzWKGLaqS0oRxmAvz7rkyJoaG7iAqY8Asqf3lfsXWoXkyz8s+PYfr?=
 =?us-ascii?Q?QpjqdmtZV39ZONmLh4dK6B+XBtjBCvjx1ukoCWosRqaQT7XN7icfro8wN69H?=
 =?us-ascii?Q?05ZmrH9RLLSXgbelvF52EQxn7K52Kcc72N53Tm1+715EjHV1KK0wsWqGT3o1?=
 =?us-ascii?Q?fdrEvm9kjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2735fb04-f090-4f49-ef7a-08dee75f92f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:38:01.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O2qudKnMRcKuF2Q3LEXkTVHdnyKxgo3p71v8NQ2V30qpoDsPruVFdbqrm0MN97/9CjiU/ZZeVeWHqMG8Howmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

Hi Cheng-Yang,

On Sun, Jul 19, 2026 at 10:28:45PM +0800, Cheng-Yang Chou wrote:
> ops.cpu_acquire/release() are deprecated in favor of tracking CPU
> preemption from a sched_switch tracepoint, see
> commit a3f5d4822253 ("sched_ext: Allow scx_bpf_reenqueue_local() to
> be called from anywhere"). Loading scx_pair currently emits a
> deprecation warning.
> 
> Replace the pair_cpu_acquire/release() callbacks with a
> tp_btf/sched_switch program that edge-detects the same transitions the
> core used to deliver: a release when a running SCX task loses its CPU
> to a higher-priority class, and an acquire when the CPU switches back
> to an SCX task or idle while marked preempted.
> 
> Tasks are classified by effective priority (p->prio) rather than by
> policy: rt_mutex_setprio() boosts a PI beneficiary into the rt/dl
> classes while leaving its policy untouched, so a policy test would
> both miss the release when a boosted task takes the CPU and fire a
> spurious acquire when a boosted task replaces a real rt task.
> 
> A switch from idle straight to a higher-priority task is deliberately
> not treated as a release. The CPU was not running an SCX task, so
> there is nothing to drain, and kicking SCX_KICK_PREEMPT |
> SCX_KICK_WAIT on every rt wakeup would make the pair CPU wait out rt
> bursts it was never coupled to. The old callbacks behaved the same
> way, firing ops.cpu_release() only from switch_class() when an SCX
> task was put for a higher class.
> 
> The tracepoint runs on every context switch in the system, so the
> common no-transition case is filtered before taking the pair-shared
> lock. This is safe because a CPU's own preempted_mask bit is only ever
> written by this tracepoint running on that CPU.
> 
> sched_setscheduler() on a running task changes class in place without
> a context switch, so such transitions are only observed at the task's
> next switch. The old callbacks had the same blind spot in
> switch_class(), and try_dispatch() already bounds the resulting wait.
> 
> Verified in virtme-ng with the script below. The scheduler must load
> without the deprecation warning, stay enabled through the rt churn and
> the idle soak (the watchdog would otherwise abort it with "runnable
> task stall"), keep its preemption counter advancing, and unregister
> cleanly at the end. A PI rt-mutex churn that repeatedly boosts
> SCX tasks into the rt class was exercised separately:
> 
>   #!/bin/bash
>   # vng --verbose --cpus 8 -m 4G --user root -- ./verify.sh
>   # FIFO harness: survives even if all SCHED_NORMAL tasks stall
>   [ "${RT:-0}" = 1 ] || exec chrt -f 5 env RT=1 "$0"
> 
>   chrt -o 0 ./tools/sched_ext/build/bin/scx_pair &
>   PAIR=$!
>   sleep 3
>   for round in $(seq 10); do
>     pids=""
>     for i in 0 1 2 3; do  # SCHED_FIFO churn
>       chrt -f 10 bash -c \
>         'e=$((SECONDS+1)); while [ $SECONDS -lt $e ]; do :; done' &
>       pids="$pids $!"
>     done
>     for i in 0 1; do      # SCHED_NORMAL load under scx
>       chrt -o 0 bash -c \
>         'n=0; while [ $n -lt 200000 ]; do n=$((n+1)); done' &
>       pids="$pids $!"
>     done
>     wait $pids            # explicit pids, not the scx_pair job
>   done
>   sleep 300               # idle soak
>   kill -INT $PAIR         # expect clean unregister in dmesg
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

This looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_pair.bpf.c | 136 ++++++++++++++++++++++-----------
>  1 file changed, 90 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
> index 267011b57cba..0d61b7b812db 100644
> --- a/tools/sched_ext/scx_pair.bpf.c
> +++ b/tools/sched_ext/scx_pair.bpf.c
> @@ -93,12 +93,13 @@
>   * -----------------------
>   *
>   * SCX is the lowest priority sched_class, and could be preempted by them at
> - * any time. To address this, the scheduler implements pair_cpu_release() and
> - * pair_cpu_acquire() callbacks which are invoked by the core scheduler when
> - * the scheduler loses and gains control of the CPU respectively.
> + * any time. To address this, the scheduler watches every sched_switch from
> + * a tracepoint and edge-detects when a CPU leaves and returns to SCX
> + * control.
>   *
> - * In pair_cpu_release(), we mark the pair_ctx as having been preempted, and
> - * then invoke:
> + * When a higher-priority class takes a CPU away from a running SCX task -
> + * a sched_switch from an SCX task to a higher-priority task - we mark the
> + * pair_ctx as having been preempted and then invoke:
>   *
>   * scx_bpf_kick_cpu(pair_cpu, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
>   *
> @@ -107,9 +108,19 @@
>   * sched_class that preempted our scheduler does not schedule a task
>   * concurrently with our pair CPU.
>   *
> - * When the CPU is re-acquired in pair_cpu_acquire(), we unmark the preemption
> - * in the pair_ctx, and send another resched IPI to the pair CPU to re-enable
> - * pair scheduling.
> + * When the CPU returns to SCX or idle, we unmark the preemption in the
> + * pair_ctx and send another resched IPI to the pair CPU to re-enable pair
> + * scheduling.
> + *
> + * A switch from idle straight to a higher-priority task is not a release:
> + * the CPU was not running an SCX task, so there is nothing to drain and no
> + * reason to make the pair wait. Kicking SCX_KICK_WAIT on every such wakeup
> + * would stall the pair CPU behind rt bursts it was never coupled to.
> + *
> + * Note that sched_setscheduler() on a running task changes its class in
> + * place without a context switch, so such transitions are only observed at
> + * the task's next switch. Until then the stale active_mask bit makes the
> + * pair wait in try_dispatch(), which is bounded by that next switch.
>   *
>   * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
>   * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> @@ -118,6 +129,8 @@
>  #include <scx/common.bpf.h>
>  #include "scx_pair.h"
>  
> +#define MAX_RT_PRIO	100
> +
>  char _license[] SEC("license") = "GPL";
>  
>  /* !0 for veristat, set during init */
> @@ -308,6 +321,40 @@ static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
>  	return 0;
>  }
>  
> +/*
> + * A task is above SCX whenever its effective priority is in the rt/dl
> + * range. Test p->prio rather than p->policy: rt_mutex_setprio() boosts
> + * a PI beneficiary into the rt/dl classes with its policy left
> + * untouched, so a policy test would misclassify boosted tasks in both
> + * directions. p->prio follows the boost and the deboost.
> + *
> + * This still cannot tell fair and SCX tasks apart. It is complete only
> + * because scx_pair runs in switch-all mode, where no fair class task
> + * exists; in partial mode fair is also above SCX and can take the CPU.
> + */
> +static bool pair_task_is_highpri(struct task_struct *p)
> +{
> +	return p->prio < MAX_RT_PRIO;
> +}
> +
> +static void pair_cpu_acquire_locked(struct pair_ctx *pairc, u32 in_pair_mask,
> +					u32 *kick_flags)
> +{
> +	pairc->preempted_mask &= ~in_pair_mask;
> +	/* Kick the pair CPU, unless it was also preempted. */
> +	*kick_flags = !pairc->preempted_mask ? SCX_KICK_PREEMPT : 0;
> +}
> +
> +static void pair_cpu_release_locked(struct pair_ctx *pairc, u32 in_pair_mask,
> +					u32 *kick_flags)
> +{
> +	pairc->preempted_mask |= in_pair_mask;
> +	pairc->active_mask &= ~in_pair_mask;
> +	/* Kick the pair CPU if it's still running. */
> +	*kick_flags = pairc->active_mask ? SCX_KICK_PREEMPT | SCX_KICK_WAIT : 0;
> +	pairc->draining = true;
> +}
> +
>  __attribute__((noinline))
>  static int try_dispatch(s32 cpu)
>  {
> @@ -500,61 +547,60 @@ void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
>  	}
>  }
>  
> -void BPF_STRUCT_OPS(pair_cpu_acquire, s32 cpu, struct scx_cpu_acquire_args *args)
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(pair_sched_switch, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next, unsigned int prev_state)
>  {
>  	int ret;
> +	s32 cpu = bpf_get_smp_processor_id();
>  	u32 in_pair_mask;
>  	struct pair_ctx *pairc;
> -	bool kick_pair;
> +	u32 kick_flags = 0;
> +	bool preempted;
> +	bool release, acquire;
>  
>  	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
>  	if (ret)
> -		return;
> -
> -	bpf_spin_lock(&pairc->lock);
> -	pairc->preempted_mask &= ~in_pair_mask;
> -	/* Kick the pair CPU, unless it was also preempted. */
> -	kick_pair = !pairc->preempted_mask;
> -	bpf_spin_unlock(&pairc->lock);
> -
> -	if (kick_pair) {
> -		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
> +		return 0;
>  
> -		if (pair) {
> -			__sync_fetch_and_add(&nr_kicks, 1);
> -			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
> -		}
> +	/*
> +	 * This runs on every context switch in the system. A CPU's own
> +	 * preempted_mask bit is only ever written by this tracepoint
> +	 * running on that CPU, so the unlocked read is exact and the
> +	 * pair-shared lock is only taken on actual transitions.
> +	 */
> +	preempted = pairc->preempted_mask & in_pair_mask;
> +	if (next->pid && pair_task_is_highpri(next)) {
> +		/* an SCX task lost the CPU to a higher-priority class */
> +		release = !preempted && prev->pid && !pair_task_is_highpri(prev);
> +		acquire = false;
> +	} else {
> +		/* the CPU is back under SCX control (or idle) */
> +		release = false;
> +		acquire = preempted;
>  	}
> -}
> -
> -void BPF_STRUCT_OPS(pair_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
> -{
> -	int ret;
> -	u32 in_pair_mask;
> -	struct pair_ctx *pairc;
> -	bool kick_pair;
> -
> -	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
> -	if (ret)
> -		return;
> +	if (!release && !acquire)
> +		return 0;
>  
>  	bpf_spin_lock(&pairc->lock);
> -	pairc->preempted_mask |= in_pair_mask;
> -	pairc->active_mask &= ~in_pair_mask;
> -	/* Kick the pair CPU if it's still running. */
> -	kick_pair = pairc->active_mask;
> -	pairc->draining = true;
> +	if (release) {
> +		pair_cpu_release_locked(pairc, in_pair_mask, &kick_flags);
> +		__sync_fetch_and_add(&nr_preemptions, 1);
> +	} else {
> +		pair_cpu_acquire_locked(pairc, in_pair_mask, &kick_flags);
> +	}
>  	bpf_spin_unlock(&pairc->lock);
>  
> -	if (kick_pair) {
> +	if (kick_flags) {
>  		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
>  
>  		if (pair) {
>  			__sync_fetch_and_add(&nr_kicks, 1);
> -			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
> +			scx_bpf_kick_cpu(*pair, kick_flags);
>  		}
>  	}
> -	__sync_fetch_and_add(&nr_preemptions, 1);
> +
> +	return 0;
>  }
>  
>  s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
> @@ -602,8 +648,6 @@ void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
>  SCX_OPS_DEFINE(pair_ops,
>  	       .enqueue			= (void *)pair_enqueue,
>  	       .dispatch		= (void *)pair_dispatch,
> -	       .cpu_acquire		= (void *)pair_cpu_acquire,
> -	       .cpu_release		= (void *)pair_cpu_release,
>  	       .cgroup_init		= (void *)pair_cgroup_init,
>  	       .cgroup_exit		= (void *)pair_cgroup_exit,
>  	       .exit			= (void *)pair_exit,
> -- 
> 2.43.0
> 
