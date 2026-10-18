Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79C2AD32
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306889; cv=fail; b=L6L97f0RnayI9HF5WqLCgHGbj2kvbpRc+Qh7hEnqSlE3m13sEdaxBkK9YcDKKjsCSswUVp+sGg9jjXJdnj9N+ESUhbEMMSHp74imBV0+wCDdmlt9n5P1ZPwJPeZx36fUul+hmq0VIMSAXHHwARK7ix0O+HYsrtTPhS87zD33a3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306889; c=relaxed/simple;
	bh=fXuch5nCtOPx8UF0Qb8KUMCubdl388esgYqadR43r/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h2DlAKYanHLm2Pe/bctR5ER8Qz+MPdpQo00mrW0v27AnW125of/V3HQCbCcyWzTyItIazIlsJGq+OYv/HtmXqOJ2KplCzyULaRoeVW3/1+ZAVOrWk8/VTNRTuCPb0GJc8i5qMEO8GNiX9I9SEE1yfokf6XgSlf+o+VlxNW3sLOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTKRhsym; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTKRhsym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuuXiFgqg+shV/M025sNUFXKbtW0qctpYKKw9zBTbp0PNNWf4Y5w3sLdlZChBDAYwS+wYw+9hE2ZJTecxJYVmNu8psEq4L1lA3cEleTM30kr9Yq544M0qS2QVJ4f59h9MzyKAJ/EWRb7lM/oE/9FlQBFRcxHTtuAQZEsDeJh1PSw3HwEd78Hkg4sUtFJA9I6D/NmS8oag9y6bL7LTbeLIXsGbwAV/0sftDrJ/NHjac7dCe7f/gcgnLd15Ua1TrWXvsvHwkrfUYXce/fVS8Kvqhm+cnMQEm+ozmjHyjOREiPIJibhnjaOZR08LXShHg/9aNZ1LYdvGpFayMkxBpoc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Gy0hMicwAQFnEaTC+UubXv0nBZt/Zxam/uI6tkOxo=;
 b=w7aOhVhHHM5q628aMtWhmfsqRhpSzJXisr/XJKRimgEcEq8uEZP9Zbx5l3tndFyuvLXcGqRsa93wGDQZ24fXLGcjWiXcktz0vFsRhJ7oE5qPz8sBKpAisRabx1LziJam2OZOefgKq/yDcJ2Ayrn6SjwX41uzYxZ8mKoWi3YvrnnzRqU/EkmFaDKRzY7g7+ux1qECi4Q1m1RQXdN0xTvEUZcp/G4rs17WmdWNCdSl635zvvJUIEqiHS9k3P/kHpIElKu3S1EE3z2WYdDaPB/WfsgsX05tDFYoNIIGYN1jHTlHjknMr61oAIiaTy4apEq52ia9CQ1mD8LpzFFH1M3xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14Gy0hMicwAQFnEaTC+UubXv0nBZt/Zxam/uI6tkOxo=;
 b=MTKRhsymn8XVw6ACkX5ju/Z2+gzWC27xzeWew5rcdT5iyiI+neL0lxWP5zxhjv/Fyd4muTDXsZrfAqIW6K4/MwHb5vlNxFpQ3DCalHG6udUcyckrlrmwewzhCulWDws866wcY1N85yQDpPLu3ylZve2q+Ev4mgn9aoC8r2Y5i/XNvv0DG64gDQMmNrCMttRZdRqe5T7szZulsdp/nl+sqcIG4oEaWPENIXV01SFvF3gVz+NttYyhkulLg+6zxtjJbXVE7mZ9YJDywNalKjRGn8Cfy+zC+xBLbPTjHzyo1xDOAomLO5FTjKI8CYEvrQdwlThqq2rljbIjT3AsZREmbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 07:01:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 07:01:25 +0000
Date: Sun, 18 Oct 2026 09:01:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
Message-ID: <atRuvuRosQI4JJZu@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015952.1499528-6-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EAA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44e) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1e8670-ebb5-485d-a501-08df2ce5a01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|5023799004|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xZp7HGnIl26T/eTiU4znoFWWaPuizL6aIm/u/2J/pPVJTpaAv+KArYBcUCB8iaf1rh9NDfDSZBzji2NLDTvJ86PauAP+4bztuYA9eo6VPL1mwd679NaQj7P9nxr+U/AihLDBHDIHhAL3gqgEOHkbg9SDVootr6VBAD9mTsManmGlKWwgpnXnVpcnPZChyhF41SSKquDVo9tAm0lmzkjRgfzhaR2z9EFQ0Pgkx/iorhXup5IEY0VIXpWv56mIDNynOmCa5f+SikHIdykHoZFVn2xRj6drxhQL1p/9eE7KlEL97kibiphZRTdsZMG3H8eGNivt4es2A/J2Y8JWk5nb5gMvJPJMLLlWDI+ahBvUZuxGVdcIae4ojwFczv2HV5DHZ9plt3oINKZWn5IWQQv5zbJVMSWoMJAq1pelvv1ZdxT2X9KMVCqWkCBlgmyf7dmMYTCRgw0ugtEmtk3M7OetDEOyeFcu6ypBNH5k4HKRv+5M+dhkTVahKRO4qnIhA1xiyuvblMFtQe/ohH081nApxzMI/yVU+qc+YXbmcPalwtIyqB1ooDGO7As6Y9z42UQgzMx5YXFNgiKf8TEm61wCDTsThvtGi5BBwp5pRidKOc7nNnzZVjXe3JgWhHigpMmOkiUSETwCUjPWe7lIlNEDb9DFvM5OgDt4wr+8w2WS3pA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlsrhQtGXb71anRv4lvaiFaAj5MdhLLG7+IvE/ylGmhBQuKLr2bnKl66H/2R?=
 =?us-ascii?Q?LcXEyRvyBh0TMNAukdcMBzjCRymB0vj+YhOYQn7V7Xf89kZqPyRDMj7Fjjng?=
 =?us-ascii?Q?+n4DGDH8Z+RVFQK6i3ZiTwATVe9OCRiDQPY/qr4LxmS/WlLwM5DyWzjSUdBa?=
 =?us-ascii?Q?EdvkprAGOv/UcjsFrQT2/D7+J1grDjE4cL/z7QMeX/MfIYvv7VTB8QYoLavB?=
 =?us-ascii?Q?5MCMhVDIFONS4x6PiEMDIj2PqMTOY7/pIPOYIlWZhfSDE1F5BctahgW0uq7E?=
 =?us-ascii?Q?2o74uo+3snLjrOyVjxl3vBleS6aXvzReWErPjNzh3GAZLpLpaxkJIlVnVZeB?=
 =?us-ascii?Q?wPR47MEcNNyPp+wkrGjFJxWKtq5mqwTKpHoDWVK2Dp3Ifn8epAhIiKyJ5avB?=
 =?us-ascii?Q?E5WcXwqTfj+55jiap0VY8pSFgTGSmjR5ajkB8L8azoeuTmdfmbb71OioSZMh?=
 =?us-ascii?Q?zuoYc7L7zxiIjveNPbQy4I/rQtXosqWZbNzvd85JFHcQBtTPRRjVFFWK6TLm?=
 =?us-ascii?Q?7aF5797Aj2BY2qfn2Q03kHicSMKc78CYARKsaZQTIDKktwrm28oyG3c6TqfF?=
 =?us-ascii?Q?MkollfDbntMGcqDgMOBhMq02uFFL47Q8/YoRK/bbxrJ12zOI1bPRS+HihsFw?=
 =?us-ascii?Q?FLOL4AI+fz66an9DVXUEB9ZkJclr3iXMgMO/ZENZLvydr+51dVzySKoo243B?=
 =?us-ascii?Q?KMd+tD4+46ijU6xhKPYNyCPc6MI/gG96BV2mxRyfaKYuL6VhduRPI9+1jMWd?=
 =?us-ascii?Q?CkU2+srX5pWmdIbtfR5MmWmLp/YepDX/lkMeRqPq4HzJnZ8FsyUF+H+Noo48?=
 =?us-ascii?Q?jumUgzvI5Qfp5THvLCfzIDf44cbMZKZXPRdDmKWhpfrDkiONpdDYvuC1WxbY?=
 =?us-ascii?Q?f7dNBZq2OkNC6ZuoJqPMygApe94aSMa9bv9OUaPqHUJCO5t2p4+XAkT2jwHL?=
 =?us-ascii?Q?Ucy89ZoVfJEG3Aet++GxZKE704q+spZlmyd+LJotB1jMvCGC6CASLTpQA9BP?=
 =?us-ascii?Q?cxD3l8mNgRfw/wBgUL1rvqbyzNwL3PUbM+Rhyl0W+S3RCFIjgpshfOa7eAEA?=
 =?us-ascii?Q?BcFXCTQ0gFU0bsR8jC9iw/XloBB/XSy8jz0zOtXai34E98yKdqw+aO+/F5JH?=
 =?us-ascii?Q?z8X+nYgvlSSnfiElRxDPFW7IfLCM6KBz2Ctb2+I5dgg/UH2vBO8bs+ecmsQn?=
 =?us-ascii?Q?EX2Tj1iFr3Tzyi2KJ8VAoENjDGSUi9640NYPjoN9awl+c3Bg5uRzSCSyPmWf?=
 =?us-ascii?Q?+UuRoTTk0QdmN+hcJDfDB1nKMX+BlhamysHFgAfl3dOMuMdNQRe2TJWaBsyR?=
 =?us-ascii?Q?u/gwL2TpwaxoUz34yplPjvNGNp3sPj7h/sF+vKM9LqM9BIv4hdwG0T705oQL?=
 =?us-ascii?Q?58swMrP6P0mtUqspztdvQBRltGzURTtEFysLCuJtTOb0SdKxMaOWm7qRMCAZ?=
 =?us-ascii?Q?9O8rj0CrKT+KkoplUFxOSrt4BwRyWxbfxhEMw3LpwCh8eUcrVx1fEuwYSbtM?=
 =?us-ascii?Q?dE3EZRatR82ikfII4LS0UzEX9qwjs66BBUmUFhMtj1IXIcO4I7PKmNDIu68D?=
 =?us-ascii?Q?+qJ4zn/6eBWmYLwQ36EKG6c+0/0HTbvNnVdOB9CxE3VxcBIt+21iGKuc8Q5K?=
 =?us-ascii?Q?Et8AQezeEyKgQS/dbHJ91g2V9fyQ2oqjYoNVPD1HwjV/UdYnPpf9gFSuJadR?=
 =?us-ascii?Q?eN6sFgso9u9x0n38JOaUp/zbyQGMO3M7kSky0Lr3uWO2TrL32npwFa31P0ZP?=
 =?us-ascii?Q?AdbVCcapEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1e8670-ebb5-485d-a501-08df2ce5a01a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 07:01:25.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia9o/tgD61BjJ1CaUG55jSHEDdnlOmzNElJvqtT3CH0AuZkLoH7TowQONRJh4ktvrCJowYUAijAFmUzTqu2/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

On Sat, Oct 17, 2026 at 03:59:51PM -1000, Tejun Heo wrote:
> When a cpu goes offline, a sub-scheduler's effective caps on its cid are
> cleared, but neither the sub-scheduler nor its parent is notified. The
> sub-scheduler keeps treating the cid as usable, and the parent can't act on
> the loss, e.g. reset the cpuperf target.
> 
> Report the loss before the root's ops.cpu_offline() and the regain after its
> ops.cpu_online(). The zeroing at offline was the last change to a sched's
> ecaps outside a delivery, so they now change only with one. Syncs on an
> inactive cpu are processed instead of discarded, and the reseed reschedules
> the cpu itself, as they got no resched when queued. Suspend and hibernation
> now report their cpu downs and ups as well. This is temporary, and a later
> patch leaves them out.
> 
> Two things need care. A cpu going down marks a sync for each sub-scheduler,
> and its hotplug thread waits until each marked sync has been processed. The
> cpu's own ext picks process them, and the ext server is started in case a
> fair task holds the cpu. Only the marked syncs count, so a flood of changes
> on the cid can't hold up the hotplug.
> 
> The detach report reaches only active cpus. It holds off cpu hotplug, so a
> cpu it skips has reported its loss as it went down, and no unreported loss
> is left to drop.
> 
> Drop the cpuperf reset from scx_qmap's ops.sub_detach(), as its
> ops.sub_child_ecaps_updated() now resets the targets on the loss reports.
> 
> v2: Reschedule from the irq work and document the regain order.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

...

> @@ -1313,40 +1347,69 @@ void scx_online_ecaps(struct rq *rq)
>  		guard(raw_spinlock)(&ps->lock);
>  		queue_sync_ecaps(pos, cid);
>  	}
> +
> +	resched_sync_ecaps(rq);
>  }

With a root-only scheduler the walk skips the root and queues nothing, but
resched_sync_ecaps() still runs on every online CPU, starting the ext_server and
queueing the resched irq work for no reason. Can we do it only if something was
actually queued?

Something like:

	bool queued = false;
	...
		queue_sync_ecaps(pos, cid);
		queued = true;
	}

	if (queued)
		resched_sync_ecaps(rq);

>  
>  /*
> - * A cpu is going down, and the root's ops.cpu_offline() follows. Stop the cpu's
> - * ecaps deliveries and zero each sub-sched's in-effect ecaps so cap checks
> - * treat the cpu as capless while offline. Pending and late-queued syncs are
> - * discarded at consumption by scx_process_sync_ecaps() while the cpu is
> - * inactive. Leave reported_ecaps. Ownership is unchanged, so the
> - * scx_online_ecaps() reseed reports only a genuine delta. No callback fires
> - * here.
> + * A cpu is going down, and the root's ops.cpu_offline() follows. Queue a marked
> + * sync for each sub-sched to report the loss and wait until each has been
> + * processed. Then stop the cpu's ecaps deliveries, so that none comes after
> + * ops.cpu_offline().
> + *
> + * This runs on the cpu's hotplug thread. While it sleeps, the cpu keeps
> + * scheduling, and a pick through the ext class processes the syncs, see
> + * resched_sync_ecaps(). Only the marked syncs count, so a flood of changes on
> + * the cid can't hold up the hotplug. After the wait, every sub-sched's ecaps on
> + * the cpu are zero, and the later syncs have nothing to deliver.
>   */
>  void scx_offline_ecaps(struct rq *rq)
>  {
>  	s32 cpu = cpu_of(rq);
>  	struct scx_sched *root, *pos;
> +	u32 nr = 0;
> +	s32 cid;
>  
> -	guard(rq_lock_irqsave)(rq);
> +	/*
> +	 * ecaps and the tables need a live root, see scx_online_ecaps(). The
> +	 * ext class isn't picked without one, so the syncs wouldn't be
> +	 * processed and the wait would never end. scx_enabled() can't change
> +	 * during hotplug.
> +	 */
> +	if (scx_enabled()) {
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			root = scx_root_protected();
> +			cid = __scx_cpu_to_cid(cpu);
>  
> -	root = scx_root_protected();
> +			scx_for_each_descendant_pre(pos, root) {
> +				struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
> +				struct scx_pshard *ps;
>  
> -	scx_for_each_descendant_pre(pos, root) {
> -		struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
> +				/* root holds every cap and never uses ecaps */
> +				if (!pos->level)
> +					continue;
>  
> -		/* root holds every cap and never uses ecaps */
> -		if (!pos->level)
> -			continue;
> +				/*
> +				 * A batch that has yet to reach the sync sees
> +				 * the mark. A sync already being processed has
> +				 * left the list and is queued again below.
> +				 */
> +				pcpu->flags |= SCX_SCHED_PCPU_ECAPS_OFFLINE;
> +				nr++;
>  
> -		WRITE_ONCE(pcpu->ecaps, 0);
> +				ps = cid_pshard(pos, cid);
> +				guard(raw_spinlock)(&ps->lock);
> +				queue_sync_ecaps(pos, cid);
> +			}
>  
> -		/* deliveries have stopped on this cpu, clear its mark */
> -		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT)
> -			ecaps_report_done(pcpu);
> +			WRITE_ONCE(rq->scx.nr_ecaps_offline, nr);
> +			resched_sync_ecaps(rq);
> +		}
> +
> +		wait_event(ecaps_offline_waitq, !READ_ONCE(rq->scx.nr_ecaps_offline));
>  	}

ame on the offline side: with no sub-sched nr is 0, but we still do
update_rq_clock(), dl_server_start(&rq->ext_server) and the irq work on a CPU
that's going down and the ext_server stays enqueued there until
sched_cpu_dying() stops it. How about:

	WRITE_ONCE(rq->scx.nr_ecaps_offline, nr);
	if (nr)
		resched_sync_ecaps(rq);

The wait_event() returns right away when nr is 0, so nothing else changes for
root-only schedulers.

Thanks,
-Andrea
