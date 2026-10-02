Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D5328B71
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951048; cv=fail; b=pqjW42Da05JMHi2t8gwuy8KA753uxgPrj5DA/iCkKQscAYJRXoacMVOOldPkEqeg0oNU/3cZTw47i+2m9td4e12DUO0NZhE8cCz1IrJhaKOZcAx3dL/ygDxjwOwCju7lUpkhq2HW1ia4gvCTYmwPURWtBwz1E9BH0r0tQA9AkGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951048; c=relaxed/simple;
	bh=sMLlRMQNcH+Gn7tFCBeUe3yQ+F7ftwbBNEd4w9FU0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fA23rdz7lu2EtElNlCscuCU7HYGgamBYm2M5GOcJ4sXnxcJkpqe3pdkc+fF5sWbBWD3GJUckCgrvrQRwJ9kzn7ksFHV2RKZRnIgenNrNcCMXCnL+edD7BJypNV3mAKJv6Rgh499JPR7ulfbSCySaQ6RMx9jefm3lFaHEAKIpDS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QS+fRIpg; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QS+fRIpg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjSHtVkxoskEiJU/jiUxKGPD4XavhleKw5aZvCRapqxxpMIkzlR4FjLddUbwXHqmHwd2uAyz+qqPzL4CxKBxUTTKhifBGyvkCBR05r6QeBZ/qp3eQRNPxLhaOC26LSS8Jb7S4DVO53zbRM8ASpHlfNZedKQgcIwFCkWPBKZMm+0q6jzm1q1vJ1Nu4VOTliHdqVfLa1btZKZgzyFNtkn/PpHi5EtGA82F/7uO5duVM2gKnZ4HRWoL5/Vlw1qHgbwHfTdiilsOCiRA64DWJkVXOpLyWyOT2DLdePObOcgu3LhtHOnMiwz4ANwzZKeWO/eYrdm1twz3uh749apXwgPPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THezMQbgVnErsfGSUPDTd1u28V0DxX/L2d5a9tiDw40=;
 b=NUuUAjdiwHnrqsciI6A9zrrX020SMSSEXLOMmaXygG6huoeff0J4EJIWFF0mFlfmvisaiUG+wq2GfTqAY9WDacsFGzH+DsW7Bo6cvNBdSrlh0deMPUimN+XUXWbp1z7P3NJkL9On39LlXPbSRIKnLoUuKgodqfIxSWP/ZnqF8pk2PZXIay0HUnPgdTc4rz3IEa2hgO2qjEXkeFPC7yE7tSp9A2jSF251NVKWShOqaRfa9y+t+jUv8+v21HgG7lFuPS3eBpV7A4OLCF21zcZ2U7mvh5H5EIly/FQFpUMSnojuTutYnEf2GTtqa0of6bIi0aV8AX6yZEYM44NtPiNxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THezMQbgVnErsfGSUPDTd1u28V0DxX/L2d5a9tiDw40=;
 b=QS+fRIpgeYxtKH74ZP+kmOkQWfAd0f4/LuxouN+dG7hVSIrahYarB+m0sV8XFx2VaK3Yto0W99/SK6dJLgsMOk4rKepDKwkNfkgaZolDGdP4nj4dlRHLY9a0RpWkBEoWL6DWVISppISraQQR4zKtsSbfaNfyQRNcM6XhqT4EV8hkwMrqhFYsktBoCL5rJHiAx0qWCdw+zt8bgRUsaFy4CK5lMZ6v4Vxa7lZGgYJaAx9PrY4NsAIcVEV2Qwemsyw7UesJNhRAyLaUyaDMhy6GHghe7kM9ipbpMO6pDfFEmE2vf/Ae4qlZCo3SYPGPZGip6myFj6Kj09hkyUj9GRZIzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:24:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:24:01 +0000
Date: Fri, 2 Oct 2026 16:23:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, Hui Su <sh_def@163.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched_ext: Drive the NUMA balancing scan for SCX
 tasks
Message-ID: <ar--fEmqMyX8odNn@gpd4>
References: <20261002124559.10367-1-deliran@verdict.gg>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002124559.10367-1-deliran@verdict.gg>
X-ClientProxiedBy: ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: b198c000-c70d-4874-976a-08df2090cdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|22082099003|18002099003|6133799003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ApWaaJriOvXjlJng1WYvVpdkqsQWNC1NUUtp0Rk+LiHIbvozTyhG8ykWhgPD6S0hSd6I8rc74K+f310WXiL0sFDa2DWMIF9FGGMQOrLtB7ZlXqOoT2htsIz77caMAdGpHOA27zde1gIERQDgK/DW4hv95IV0rIpFMjhdqEQ0pRGpBVSEfJtCTx3rPTuivZHZnfu93Yh2uWWcQFx4OX52MORT2x56Bsky8RDpzi5BeD75ALrUlW4P/41LeHAqfMyd9xPRKHIDKBdlG5JQyOOAGU2TEv9ArBYdxOn3CeoFbJb23ER0GitHrSPtJQpJndEeFe8w7MH2jXErUg5fYqlQJ1CkL+3lYZJsUeoXC3fwv+hRYbB2O/RjstR4L5VKhiGGqYfSUFN8LQZvfpvK7oyvZP7jPT5qfYWFpqH8CkGMzKNPNesA6y9DG3Q9DtIYeKo/HfQYcxZOWpaVQUNUCbzfF1Kdz7BIaTUfYotcsMAmXI4BCqAwnGoR1wk+Q3mOOUL2lY2CWJkOpBMULwxcJzjoLajS4Ab1KaWNjVS1ORl48GZndcjytCkdQFVkGn4LgX6Xn7UdP01Vl8ee2wMylsijBLJ709s1gXm5qjJ9JbcDPnbctFibJs6xiU49ALGFqsZJ9MSAPChw3NJET03t7/BioiFzW9E7gRo3YY50HV4ndMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gF4GfjRQ9p0QYJEnkAzU/JFz3/mLJaey+fERcNsfwGP7A1067kBXRC7p+sR?=
 =?us-ascii?Q?qbGDEkWWJj+eZqOyqZOY5m4oWmXKzWoVVx5p5bKbo+ezptIgyVpG58WoRieM?=
 =?us-ascii?Q?Idbn5EsR8bm8fJH/EEMpUVFe+XsM6jvqlc/B80dNHpJifsFeCO5Zx5t1WqQa?=
 =?us-ascii?Q?qroHDyISBHAee+Wz1t0gxBoMSeNK9LJwrz8OaXKecE9WeO0sMv6L0qT3/W2K?=
 =?us-ascii?Q?lk8CiGdkiqbuuF3GL9iGo0WFdz6YFCQDoMDXAhCnYAcB0F//KNSAOL1HYzlM?=
 =?us-ascii?Q?VM/hD9qPD+jAE08YT6BxmKYSo20G+Mnzb60m4Z1kxqcywjzROnzEzOaxyh2M?=
 =?us-ascii?Q?1Rzg5R1Fyx3IO0qFEanWq7SCHQMAJ1BHsqXfykot2vqGttGNlfKyE4B1572c?=
 =?us-ascii?Q?Jjagnb6/JgNJTaIw+MzNZu2Tvzwwrv86vwd7yEINcNOEfHJ1RAkvVB/DiUqG?=
 =?us-ascii?Q?4qOBAC+8V3LWpZkiRqG6lvWrxRaZu+9XcCkzDyGCscG8CP5abXKKIbFptZQE?=
 =?us-ascii?Q?qe12DaXH55Mpu/7ZxjVeP9qhTsLkSUNqCYJGXT74wYYM2bsS8iLSH0dkOyJL?=
 =?us-ascii?Q?RkF100Ty+teyeER27+JME8ZJraC5dOeuVq9hRCF4ciuLpkM3S7bduIJVoo1o?=
 =?us-ascii?Q?uCGeWDFRUca3PhYN0lb4ZgWT5lTytRB+qXjSDenTKb5fDRyrUTT9A0EHrA6g?=
 =?us-ascii?Q?mrVsOMxw68CnMporJ5BMgTmqVphcy17/iNj9faW8lECmho5n51V8WhuCY18z?=
 =?us-ascii?Q?mc+ukeI85Vi5GNhHKyb2RV1Oq1n65WUn+yFeLmiPOtkAmT3qo20b29Kj734S?=
 =?us-ascii?Q?9WPwBSYUsouq85WS7Qh/XUfl8h5LriMByi6W2UnE9o1MKMhZBc5jmYxLQVY6?=
 =?us-ascii?Q?+z/3ShJvDDcxj9V/gTrweCIBgYs714sFPIXS65BtC028VjHlWcabjNDfkhmX?=
 =?us-ascii?Q?jStIKq97Wqa8qzaNXNTwfarI230lFt+p3QjgWvBvqB+ymV4r+967FSPL/Caf?=
 =?us-ascii?Q?B/MhtesKA0efI4Cp9Jtq+DApj/tEC265R51szmTvekpcMUsjtUdqr6wKGOLo?=
 =?us-ascii?Q?O5FwHjhK3not1Lux2QOnb0aWXZCGPJ/KmnpeLgloP26z+Ctd/nqilmrxlUZx?=
 =?us-ascii?Q?2ssf5jSQ+/B+JB6eW8o/J98CmWPIhhQtDMAeZZmM5O4ofVWfmJ/iUc6gIoB5?=
 =?us-ascii?Q?qzKLPAm5vtpD0CxRoHzcnNHQetuB94AsrEHAGGdhqrNoKtVw25uWxPyFGMR4?=
 =?us-ascii?Q?rB4OsbVOujhEVU0g81bvxDRbIlQCo9teKco14EpCPFLSrXukoUl8FTubJsdh?=
 =?us-ascii?Q?lytQWVR2+725XpoRfuPIitZGnk5lNv6zxqqF7qCyjRAreNNqeAPCkFNW2jtj?=
 =?us-ascii?Q?5dA7mVUgsED8DUhJ04I2F4HwsODbBW/lduSdFoVuglTj75S5NoFlxn3jl8GU?=
 =?us-ascii?Q?HgcZOfkH3AHZoxb/vjfCFhHPsumhHkRlDuYDx0l+4e6CvAXtIaXoK0FrYW9A?=
 =?us-ascii?Q?UoZSuFX4ec945F3aFhkU64dq7B2NBRnZSBnbXSX5oisMhZD4BsSrZ/0TEF5y?=
 =?us-ascii?Q?ToIqNCtM7W5RQmu1MCvlD0m0cKliJbwQifwHYd7cwIjxCwyxeBFkK/+rS/TK?=
 =?us-ascii?Q?v4YxDfP8WjPCp/3crOWAmzJ1JOK7nrSHm+8uII/GQuUuvGA3PqXcSR7uWchR?=
 =?us-ascii?Q?xd4XECRK3AX1w9CP7q6KxWs59LZVE+RXLLIz08kytEy7uk7m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b198c000-c70d-4874-976a-08df2090cdba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:24:01.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NEHiVCdvE2JhL28yno0wiz2qjfOcUEGHP/SOFh1IXHkZTzZHf1idRDEbYyuqgaZoEECPLq7KD8uiBPVSs0TrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

Hi Vladimir,

On Fri, Oct 02, 2026 at 03:45:31PM +0300, Vladimir Vdovin wrote:
> Automatic NUMA balancing is effectively off for every task in the ext
> class, even when kernel.numa_balancing is enabled.
> 
> The periodic scan is queued from the fair tick only:
> 
>   task_tick_fair()
>     if (static_branch_unlikely(&sched_numa_balancing))
>             task_tick_numa(rq, curr);
> 
> task_tick_scx() has no counterpart, so task_numa_work() never runs for
> an SCX task and no PTEs are made PROT_NONE. The fault side does not
> depend on the scheduling class: task_numa_fault() still accounts faults,
> runs task_numa_placement() and migrates misplaced folios. It just never
> gets anything to work on.
> 
> Numbers from a 2-node, 160-CPU KVM hypervisor on 6.18.5 with a BPF
> scheduler attached, detached for five minutes, then attached again:
> 
>                          SCX      fair (5 min)   SCX again
>   numa_pte_updates/s     0        2.4M - 3.9M    0
>   numa_hint_faults/s     ~0       10K - 34K      200 - 300, decaying
> 
> Those five minutes under fair changed the placement data considerably.
> Measured from the BPF scheduler, as a share of task runtime:
> 
>                                          before    after
>   task has no numa_preferred_nid         58%       10%
>   task runs on its numa_preferred_nid    37%       83%
> 
> So under SCX p->numa_preferred_nid stays at whatever the last fair
> period left behind, tasks created while a BPF scheduler is loaded never
> get one, and memory is never migrated towards its users. A BPF scheduler
> that wants to keep tasks close to their memory has nothing to read and
> no way to start the scan itself.
> 
> Call task_tick_numa() from task_tick_scx(). It only needs
> p->se.sum_exec_runtime, which SCX maintains through update_curr_common().
> 
> Keep task placement out of it: after a fault numa_migrate_preferred()
> calls task_numa_migrate(), which picks a CPU from fair load statistics
> and moves the task. Those statistics say nothing about SCX tasks and
> CPU selection belongs to the BPF scheduler, so skip that step for them.
> Scanning, fault accounting, numa_preferred_nid and folio migration keep
> working.
> 
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>

Thanks for looking at this! I actually have a patch series in my backlog to
introduce NUMA-balancing support in sched_ext. It makes NUMA hinting scans
opt-in for BPF schedulers and exposes a task's preferred NUMA node to BPF.

It also lets a BPF scheduler set a per-task memory target, which NUMA balancing
can use when migrating pages after hinting faults. I think that could give
schedulers a useful way to coordinate CPU and memory placement, includeing when
device locality constratins CPU choice.

We're actually going to discuss this topic at LPC next week in Prague during the
sched_ext MC session.

I can probably send the patch series at this point, it's not completely
well-tested, but it might be useful to have it on the list, so that we can start
discussing and improving it. I'll keep you in the loop.

Thanks,
-Andrea

> ---
> This is an RFC: the patch applies to v7.3-rc5 but has not been built or
> run yet. The numbers above are from an unpatched 6.18.5 and only show
> the problem. I would like to agree on the direction before testing it
> properly.
> 
> Questions:
> 
> 1. Is the missing scan intentional, or has nobody needed it so far?
> 
> 2. Is calling a fair.c function from the ext tick acceptable? It keeps
>    the logic in the class tick, in line with the per-class approach from
>    the "sched: Fix execution-context tick handling under proxy
>    execution" discussion, but it does make task_tick_numa() non-static.
>    I can rebase on top of that series once it settles.
> 
> 3. Is skipping task_numa_migrate() for SCX tasks the right split, or
>    should the BPF scheduler get a say there through an ops callback?
> 
> 4. Should this be opt-in through an ops flag, so that BPF schedulers
>    that do not want the scan overhead are unaffected?
> 
>  kernel/sched/ext/ext.c | 3 +++
>  kernel/sched/fair.c    | 14 +++++++++-----
>  kernel/sched/sched.h   | 5 +++++
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e56c3c9..82c7d6a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3840,6 +3840,9 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	if (!curr->scx.slice)
>  		resched_curr(rq);
> +
> +	if (!queued && static_branch_unlikely(&sched_numa_balancing))
> +		task_tick_numa(rq, curr);
>  }
>  
>  #ifdef CONFIG_EXT_GROUP_SCHED
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 57360f5..669c8ab 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3642,6 +3642,14 @@ static void numa_migrate_preferred(struct task_struct *p)
>  	if (task_node(p) == p->numa_preferred_nid)
>  		return;
>  
> +	/*
> +	 * CPU selection for SCX tasks belongs to the BPF scheduler, which can
> +	 * act on p->numa_preferred_nid itself. The statistics used below only
> +	 * describe fair tasks anyway.
> +	 */
> +	if (task_on_scx(p))
> +		return;
> +
>  	/* Otherwise, try migrate to a CPU on the preferred node */
>  	task_numa_migrate(p);
>  }
> @@ -4630,7 +4638,7 @@ void init_numa_balancing(u64 clone_flags, struct task_struct *p)
>  /*
>   * Drive the periodic memory faults..
>   */
> -static void task_tick_numa(struct rq *rq, struct task_struct *curr)
> +void task_tick_numa(struct rq *rq, struct task_struct *curr)
>  {
>  	struct callback_head *work = &curr->numa_work;
>  	u64 period, now;
> @@ -4696,10 +4704,6 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
>  
>  #else /* !CONFIG_NUMA_BALANCING: */
>  
> -static void task_tick_numa(struct rq *rq, struct task_struct *curr)
> -{
> -}
> -
>  static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
>  {
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e656c70..f6774bc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2133,6 +2133,7 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
>  extern int migrate_swap(struct task_struct *p, struct task_struct *t,
>  			int cpu, int scpu);
>  extern void init_numa_balancing(u64 clone_flags, struct task_struct *p);
> +extern void task_tick_numa(struct rq *rq, struct task_struct *curr);
>  
>  #else /* !CONFIG_NUMA_BALANCING: */
>  
> @@ -2141,6 +2142,10 @@ init_numa_balancing(u64 clone_flags, struct task_struct *p)
>  {
>  }
>  
> +static inline void task_tick_numa(struct rq *rq, struct task_struct *curr)
> +{
> +}
> +
>  #endif /* !CONFIG_NUMA_BALANCING */
>  
>  int task_llc(const struct task_struct *p);
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.47.0
> 
