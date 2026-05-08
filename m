Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA43E5EC0
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249691; cv=fail; b=s+CWNqBlHIbK5379C1uNH0JYkaWAs6Wgp+GiFkaT4r5nkn+CfV9THPjQ8KJzEnn2L2vyuFIB7+WARpe/L0smHzEW30TYsryg3kFD8gxXjEY+xatIwzfg6cjq8DMxgAPBiqaGVCsyWGWtTYJ0V0OIK/9G6Ol8d/DuNsN1HpgqsGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249691; c=relaxed/simple;
	bh=FOjbj78tqru7pf9uB2vXkLwL2xvEaV18QyZ64oiKCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jeRKnTXsVugnxM5qO6xjuht+IzErL4P0tjfvvjbGKOAv0f2tvo62n/LO9FQa7guxXkCCxZaxdMY18iJefJ3lXRAL65H56CT4ibPXZsccnTsI1RQ4D8AJgfuxvoAA742yQzHBVuQJDwBNEGwbxgZck/DdrtWB54mIuMjzzLuzZCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKwWGu8v; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKwWGu8v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2HnaptV6ojCT1cpQlSEKsbOh5LJPpXIL3j+9gUMOHHDPX6mMPThPZk7w99fAq0ODQKXRRVnLsfPoERifU01bK+9FFwYuiv0ZOmpJ/Nz7BxLIoM8nAvZcPgicA6/M1zI3897qWdLEscH7nDUaOYcg6OqJkiyMFl1julZfG3OZ1WS5XpP+XwQCpLPebJhWF4OHSia0OIpsEMNeNOHpANQB1HhfUJQZglLO+fzEwT++rs82WYHawLhE334BTliQEjG4Z7sMiI/2dnuzkKtRLYqY5Ygd6sVQ5wC1xHO2v2FPbBK2GMPqUj1TFU7XXNWNKLyUJBpHLE0dh+B7CqS/Jrtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hg2XgI5ApE6URHXmX6vJYqdg8RfF3b9X/fRn69KCeE=;
 b=MpEZmxZzum9fhsY7b2Iy6WPTeldRbs3kOfg0uq6Omro9dduWU4JDqoYJ8dEaIm7dp+l2eLPPDY29eRIZ1CQkDj33eAsW0GmdGmAWFlQxgluutJS+MIbAKV0gfhXfc+7TcBydOBRAY3m/3UFvrO2wC13IZ680fzLg3+nsPsPwCTn3+O/FphWGEy61N/7fN+T3ukAFrzePIJHnNH31uO8ec4oSHf/LHVuLPvzmNSxodggT7DFH3j5Vj0oQZIrxLkz/hybL+XCuX8ghUKS3PN0ZUByfrMAioKizmfDK8CyBG/nHAU6cc0FfCO/r95SJ9Ia/tHgiGzUBcgE8EwQ5KmurLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hg2XgI5ApE6URHXmX6vJYqdg8RfF3b9X/fRn69KCeE=;
 b=DKwWGu8vcRi8xyTA2O3hOOGQW9Q/hJQw0wGm180syxSUhHZPMc2fXd+rmtWlqg/Bo874u4XOrXDLVS4wDECHS2lkycdjoSo4u5OOEZMfP8+jy9efVCEZ+5YIu+PXw4H6E0/rJC8C1bhnTOL4wCOdmBbDFb4u+9OWFcoLx6+3lkbhs8QN7exao95QCFd0NDNN7xmqTisiKZTPn0KEp+g/EzwQLIEPMDkOo0m9nfCv2sDDXubwdVEo5MpkGf3141kUn/3rzg7hiqy6KZ3hAKyLzT+URvau4uZX0HMDZu/VsML7dZypYPQO+9kl7X0uThWzHMJdPxMhwOloSV4kBOoq1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 14:14:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 14:14:43 +0000
Date: Fri, 8 May 2026 16:14:27 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com
Subject: Re: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
Message-ID: <af3vw6Sjh1dW8oEA@gpd4>
References: <20260507135642.692290-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507135642.692290-1-christian.loehle@arm.com>
X-ClientProxiedBy: ZR2P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e80bdb1-e730-4ab5-9575-08dead0c26c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z+W3FG6GgjsbD0dfzlyj+RCSmeJ3AAovZ+PlFGigzW/8/rYp+okJR5Y5RCp4KNpWYawB4xZWTh1ItcI+jZxaNncAhI9+m42ga9V5KeRFLjEOD6SEDvnktX/Q9WKrQ2V6HYUWxGT2q8VCTKC9zMZtOIlDxd8r5KySQ5H2QUvM6qjuGaRUHkkN2yw0OeGU21MkH2K3UscqNp9NM6aAN513Drhp+KaxjamXnEDV+py+2+w4BCQPBF53rimqBVcngayf2q0fAj7DLFxcUWt8E0k8TsPN4VJO6zfzxulpugLWlzmg1LBzlClFjj4SvzdMY2EKwaf1oXt7pWHjVDjqKmp+O07sKZd4peIVGO8r6oh7h/WjLnjq0rXthTIeeMV3ERqonFduckYOHPTrLcZWSWQ8xd1di/JTRbtUljY01dAcRbEdysrb/yx5GfxC8ZA715p1QBl8bCGYMVb9Q2PDLRmQ8vVHyA4euxkA9FFKEStixcb/qwy13ZwS03zusnzZHO8O5yDyk9zRcF73lFBlLUfnUMYZje5n0SBj59UwqswIOuD02MavUY/gjxbZ88s8riQC+zOzewo6ixQEmp+DlPDSim5+V7w/R0ChF4zWHoPRBKHw178UNSYZ1nMnVlweuwTzSjrm7u0Y3ueYirNNoU6VUUzod8ldxsB8ljSpZDTMxwC8S7rG4lLNeJsNn9vIaHm9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rRikoMHo0XNdSFknEbd3WPBihdm9KZtqPM3w5MHJEZog9Iu+XI/yJH6BFALR?=
 =?us-ascii?Q?yWZ9ELJ+4gXMGAaJaebkT6907mCC/pAT7X3ZxU5BMPrCDFiHfPLe0GBRUoG1?=
 =?us-ascii?Q?1uD8e6wdnD4Z0caj5q5wenJrEyKSZC6M8tXmJ+wtPArOdtJqHnSPaOcCoA2x?=
 =?us-ascii?Q?kpviL4vv+lQhbNQPX8uNjw3urmZAIxipkRWqnOVdLKsAlpWEIG1afsVObbcE?=
 =?us-ascii?Q?P/1tGYoHgIJb3vzRU+4l+6Ysra1e1HSFDnKOGsDMx8ym9R9noOlJeinY9py0?=
 =?us-ascii?Q?sGihLrW846bxoBNkP3iqQ+S+MLWo2MEtPxkgkfqW3EoIRZqVvmT6D3BRaWQw?=
 =?us-ascii?Q?jsEo1E7tDcc/0k3xnVx3IuD/uncZLyVUSLRfVTB3fGHyNGAlew82hN2tc8C5?=
 =?us-ascii?Q?ueyX0k4H+2IKNFMqPE7CZAUCCwdBXxanj2oZa0JKTl1CPscJ8fyslTNHoATF?=
 =?us-ascii?Q?bhJuGzrZMoy2H21iIYWGfP5CZq2h8MNyEHeoEE4J5fjlWHcnZXLnD702eQ3I?=
 =?us-ascii?Q?6rslxGn1qZqwGhMWSpoJFTwg/IJVFZwmqzbuaFE+odtiOE0DFPHev05UDWTJ?=
 =?us-ascii?Q?egSeTWNh+walyo+QSUmfxa4/oxPVlbFzzMQBkb+XhxzCrYjM09KRMqAsIvtl?=
 =?us-ascii?Q?fA9hiPegiDRdPehwpfewW9HOtZuvH7UkTo8/lNlkL4L+mrIOaP/xNNcM9JpZ?=
 =?us-ascii?Q?DR4HMndZhtqj03/qmEuj59M/Z4dJYanUBP5IGJl5o9Ejq2QK8yJHdkUns2qI?=
 =?us-ascii?Q?GMscoGOWjEXOZGxquY4vyaKz/KKxFBMeTXguGu4vTcQI5n3l7sMZpj0xtIxo?=
 =?us-ascii?Q?EDAROFeu5vXn4zxLeiPQmMjo7TXV798HxG5B/zy5Wtr7mHPoOG+Z6WZ6ndgm?=
 =?us-ascii?Q?H7HWbgQImpH+wkiU9qwhXnxa/1r8+7aaM+/EtK10t0aNTcbHyqRZ1jxPioYN?=
 =?us-ascii?Q?jQzUBWVM43GgpVSonx1pqkN/lDr2UOLR0FhSBgiC30kGaGrxT17h1nU9B2xd?=
 =?us-ascii?Q?y0jibYLbSjXzkSPoYPBU7ivWt0f7mYG/vsTruyB1zG95ZMW3icIzHRngQtJi?=
 =?us-ascii?Q?JYMYZpuWt4MMZBhaJaIRYRpddc1c93UuxpJIxEv9osAcFkQecULlFD3t1Qw8?=
 =?us-ascii?Q?ZnhC961V0mcVZrPNOpmvkAHqeOzVw+xKBgUsJ8REfVR+/2wnFqxHGU+COvMY?=
 =?us-ascii?Q?MW9fGsvCcs4TQjMWP5288lks7G5e0htMwlVWllt5AZ/AhpXSqi5ojH6NwBIH?=
 =?us-ascii?Q?ZGo4ww9oihC5JMlA/E3h1pPJQBByhH/h6x2NGVKRW4iVJRXW+HmlNiSTUIhJ?=
 =?us-ascii?Q?mIhqiOIVHqGtuEmGy+I4GRMLja6Qf/Kbp17T0YhAtNwpRkuiQtogi4+5IYNq?=
 =?us-ascii?Q?QCJ9Xx0Xr67VARdYI4coD9K5AZKre3mNP0EwAd/e4a8So8LXfL43LjnF1i1w?=
 =?us-ascii?Q?2TxJRb4Yy/dwZr4NlZgbL89OvYThprZK2wak216ZvW0SU4e03LcOMPrnMbL2?=
 =?us-ascii?Q?epO8aDm5EvEbX+qqtUKqiQSohInmiFXDW82OoLmXyXHP+I84yHc49193QmHz?=
 =?us-ascii?Q?SwDO1f+yjv59Ypd5nyrD27DJTtiNVPm7jpuQiKMTfKM6Kpfu10CHn+R8T3nh?=
 =?us-ascii?Q?J+E+f/X8v2plNcty4hKy3mCWkLcal7dhFRmJ3tmJxkntKoAVj0soIsHyXuop?=
 =?us-ascii?Q?0Or9mi3GNMjYZSJCuOS+u9DmzEPx2wJg4jGyou3AmSagDIpffciE/dQJPTbi?=
 =?us-ascii?Q?qRW2NKVM/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e80bdb1-e730-4ab5-9575-08dead0c26c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:14:43.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOHTYCgaFLICSOf+xX2JY1nTuWEKHKsXtq78IEbf8kJ1tTIHQx5y2kh+7Q+QCJHZwTrz8xmwYduhEkLnzllx/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

Hi Christian,

On Thu, May 07, 2026 at 02:56:42PM +0100, Christian Loehle wrote:
> When aborting, consume_dispatch_q() breaks out of the task iteration
> loop entirely for non-bypass DSQs. This prevents CPUs from consuming
> even their own tasks (where rq == task_rq) from any DSQ.
> 
> This causes a deadlock during CPU hotplug:
> 
> 1. The BPF scheduler's cpu_offline callback calls scx_bpf_exit(),
>    setting sch->aborting and queuing the disable_work on the helper
>    kthread.
> 
> 2. The helper kthread (and other tasks) are stuck on the global or
>    user DSQs because bypass mode hasn't been entered yet.
> 
> 3. No CPU can consume these tasks due to the aborting break, so the
>    helper never runs scx_root_disable() -> scx_bypass().
> 
> 4. The cpuhp thread is stuck in balance_hotplug_wait() because the
>    dying CPU's rq never drains.
> 
> Tasks on user DSQs are equally affected: BPF schedulers can dispatch
> RCU and other critical kthreads to user DSQs, causing RCU stalls when
> those tasks become unconsumable.
> 
> The aborting check was added to prevent live-locks from the remote task
> migration path (consume_remote_task() -> goto retry), but also avoid
> holding the dsq->lock for too long.
> 
> Change the break to skip only remote tasks via continue, allowing each
> CPU to still consume tasks already on its own rq. This unblocks the
> helper kthread, lets bypass mode activate, and allows both hotplug and
> RCU grace periods to complete.

Have you been able to reproduce this stall condition?

When the kernel forces bypass, scx_bypass() explicitly walks every CPU's
runnable_list and cycles tasks through DEQUEUE_SAVE | DEQUEUE_MOVE so
dispatching stops depending on BPF.

On CPU hotplug the helper kthread (and all the other critical kthreads) should
be also in the runnable_list, so they should be moved to SCX_DSQ_BYPASS and
consume_dispatch_q() should be able to consume them.

Maybe the problem is that in do_enqueue_task() we keep tasks on the local DSQ
when !scx_rq_online(rq), instead we should prioritize the bypass condition.

Does something like the following make sense to you?

Thanks,
-Andrea

 kernel/sched/ext.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7ac7d10a41bef..277110d950c30 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1901,6 +1901,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
+	/*
+	 * Check bypass before testing the rq online state: bypass mode stops
+	 * processing local DSQs, so tasks should be routed through
+	 * SCX_DSQ_BYPASS rather than dispatched to the local DSQ during CPU
+	 * hotplug events.
+	 */
+	if (scx_bypassing(sch, cpu_of(rq))) {
+		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
+		goto bypass;
+	}
+
 	/*
 	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
 	 * is offline and are just running the hotplug path. Don't bother the
@@ -1909,11 +1920,6 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (scx_bypassing(sch, cpu_of(rq))) {
-		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
-		goto bypass;
-	}
-
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
