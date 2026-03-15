Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413EC23F26A
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567655; cv=fail; b=nO0UOQpDXuHnK6Vees70dMVX0GEJ+X+FJW/nZh9n6P2yaBZLm7sDeF6j7YQXYtbyBYJY7VH+f5xuNTVY/tXCEo0yaZqLZi/xv4Edcp6SRdXaz7zaas54w+h6FffVZaFRKBdcEhlHE3pNYoLMJKQiQoMeuvTGKr7Q2Ph70cKc7XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567655; c=relaxed/simple;
	bh=rwU8njdsI3Wcv7RhDgZDeAunqLnopt7B8zDr3Ptn4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XT+r9sU9+eAbTyCMXyoVdPLGcMAsajFvetDjgOr7Tf8bgNZNGJ+O1zFx9aLGrjgQ90fsiuQ2AQxsp9F35K1fjE9lFHk2PrA7IvP66bKifajDcIBAbzqQGOkrxB6jFQvRsFickpX8Z7fM8dOO3yceycG5OEaxfIWfC+fSPzHAG/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FycMioAE; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FycMioAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyxPhnMCrL97O31Sec8YiDu7FIa/vKnDLlhdBves+6CM3RHZ/NMh9yjwyn3vZ5ICfcFlDldasYqJUHDdzh1ACr+isyEy246kYAei3M4sLJaHQ2DBqta5QFwNSI3fHcb2wtI/xB4dqRZEYxKNDzdwHuFZgPvxqv+JCeaB7FJSamai4LV9015d/AvW7aiYdvrHydfyMlbmQO5GumMbep8R4XeMTqMQXFyEg2YFqtMWEIz8MfeveGwEb0+MLddTBP6R0evthRN7FRgBmrBWLAqUtWBC6Vulm2b0xOI906FFx1MMHY7VeGtV3AsCRkcKqKhelBhknXUkTzSvC066mWJaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erryuojk2qyqKFHYJIJjYdF85G1i8wOmueq/tGu8jso=;
 b=yOtC3WJ9cIcOGmxjerx95YfuMdNEBzGq9uUVcI+80/XzMSUBkyHLPJUCIwZ+pZMrQbQtudmlNjFxu+uXg4DGdTMIJ3Mv2usfezqUl7ZohbTR130mcT0Yp0R/DYxTy435TjJkungzuBYdprWsv8gKaoyOe5PMZJePEwPJ9pRb6dUlWZb2KrQvBXuu/vaD+K3jnHNjOU7vfTPx6WVdFY69MTzsAtLE746XlLgrOUD8RnediwUxEqWtTwONYc+shequVpvuVMufY4Y8nkC47xed4hMQgAxorr4k0ldbToquVE2z+lC3EIcu11YAF4NDoba2YNtxAUbTcrvE3ZkHU6hqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erryuojk2qyqKFHYJIJjYdF85G1i8wOmueq/tGu8jso=;
 b=FycMioAEVeIs1rLHTqUJJJ/7BhRTZlBj5mJxXoUMCRErX0a/oQ7fn9ohTqS0TYrK3M9bRO/hGph26lg84b1xWHdhKmmscSoE1Sk8FEzOEmxNyCYA4yvVxDg98xHCGozfaz6Nvro4qCPFberD6pQ0QxX1zT6JffZbudszvCws6bZRhmPg62aNXM2mTQfuqnrrN/LK799U5MICN0hsaS7K2JfMKgCGWVYt5zy8rqxSrBJ2+lPiKoty5GyaBX85DmhB68I6BkdWykztAvM426n2Gs741mNkwWtHoyPMOmkDu/k4qudMMGsWWPLtBRSOj6x0XHSX0fRX3h/Cbu19ZpeC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 09:40:48 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9700.009; Sun, 15 Mar 2026
 09:40:47 +0000
Date: Sun, 15 Mar 2026 10:40:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Reduce DSQ lock contention
 in consume_dispatch_q()
Message-ID: <abZ-li3Dq9_PXu58@gpd4>
References: <20260314235231.684671-1-arighi@nvidia.com>
 <abZ0nerzU1j19BEG@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abZ0nerzU1j19BEG@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: cedd014e-5961-4001-095c-08de8276efcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	F9qTKYFaxwjse31ioLZ/wgg8incKHGrvENJv3Tu3wizoEN+hZpHQxWr3dMHc3+0+8nIRRFq9mVo6utsFTkzmIvV1XoVYFbFShtbo7BaIuBKW8vmavlO/kib+7Tf2k+sZeA7DX6lBL0Zs6wksHldDtJmeX7KssWq2rmqVQMFK/xqx+LPfZqjkK9jy0Fqf0n5+hrY58eVheGAq+F9rKZsnBkhHH9vx2Z8VLNvNTQMlib09DW4GE/zY2/axX/PggEc9NuEAbzGrQ0u1m98On/Eh9c5Hicrk65a8LQ1wMBFuxl/iCgvhyWzSB14TKBUKVaXkAeFJznhmOLMJcVwZvC6XssAangxrgX4R6J/spvFX38RBNf53S3/rKgfC9NpfxPmwpb/E+Ghmkr5eetW9rBAl7Zt1dX+VAp/97cLUZVA6Znei8Z391e9y1Do8Iq1Towfo5VR5pSymMAZXzjClZ1nZ5lxD6ydW8dlPEdJQZpALaXwtHoATokYTJBXYAAYuKaNSViiFAlTUokMozhoIVR6hVP81okJmc74SMJTvZPOYto5+V2BhTu6aR/rFPL8s2njFJr8HMX2YiCEutXouJLmdBnV34b3UsbvdgHFMfdDH0ntkOMwfX5KbawMrDgt2pRDtos7fMosOQEjf0n2/zS5uc9lG0JqnzPA4v6fu3+t8P3WbKy9PCXpmh+Bb26flxOA6q7vusIlL018zFuRS6Qp4L8VFOCAxJt1ZM4hZ2iJAIl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCulg4cwcNY4aYhHf4U4AcUu7dTAlW0an6gJq/tZBQL4CcZwcH6BoH0Q4TWW?=
 =?us-ascii?Q?kT6mtREHXk6QR1QcUoWmA9CSRgrNO7J+GQX10LRZhGRXUfy5X8InmSqQOibm?=
 =?us-ascii?Q?yCB3NHtTtKgTF7OHdSTI3SxbtqeuPitb0GSpf/nOmDJuSAAeQvrWeB/hq03B?=
 =?us-ascii?Q?8iKdndrm2EXXdOg55ngWLwB325bDO1p31dG1EquOmT2TGAQ25AnZWwJk/Hjj?=
 =?us-ascii?Q?qTr8LH7P7KRsg2QtAFMyEs6FOMZdpYMNqYoXkPaTX7H6xWn9CbIY2vpdA1kT?=
 =?us-ascii?Q?4yLFHQ1QDYZRNDJepsMqQ8+603AKE1AMoYo8+A6KkFd2Rw8bUjgY2XETg6KV?=
 =?us-ascii?Q?RCZ5rHTQoU8/Sbe7Tz6q4T4w7QXXdO/avlOTSey1w1YgJBkbmVywug2gj1pB?=
 =?us-ascii?Q?NW+h7w8GOKZ2C+tOTzt9uSO2KbDePP2Jl0RDRDHyN88bi/nA+DNjapw5aQin?=
 =?us-ascii?Q?/a1I/LOOwxOLAc8r9e3FifQ+n1fagmm3ahBko4a+NjOh+SmvhGeHKB85sQ9B?=
 =?us-ascii?Q?kLylLOdZO/FfwPmSKq5mI5NUV4Kc2vQOFgAYfWAyJr+Y+cFWIwRX8ObnCxdj?=
 =?us-ascii?Q?gzFyP/qVifJ9PG99BTSVez9N0xax90jgfAzFUe3mdn6gTPQo0oGKTltPP33U?=
 =?us-ascii?Q?bqGq7qCoE2nkLaiQN4dWHqjJ28pWxwwvRDGS9WGXUsCOb7l1rEDcsiN8/l76?=
 =?us-ascii?Q?qijYIzqy5ZuKuaqA/gYbRQsv/pQh40xzFYAxpUhtUwsh8UumddtQ96IzCdGk?=
 =?us-ascii?Q?u8ewkZLIMHIN52Ya0rqrpwT6qNIM0c1k9ZSrrw36lKEs+yCX8eOhfceicLqc?=
 =?us-ascii?Q?khatJYEQfBHpY+b3mcdCaqMlKGQcfLwWpYkbkPaeeKVKJe0kv6JEAVy7z3QJ?=
 =?us-ascii?Q?pZO9pztjTLWsRsV3+6nSlBnizKBO7lqHPBwkMKkt57lhNnVe6Ra4zVZMuXE3?=
 =?us-ascii?Q?dxNZPsj6yPFr2y0xuEWGuYMp7rik/g/H9mF11VkwZAShlGoETu2fd6sds1dd?=
 =?us-ascii?Q?0pADSRLKZuFvccJxNBMvd/xGggXGEmuAGrB3EU18V5sGwRkeN6D3IfDEE0Yf?=
 =?us-ascii?Q?qnTjNS43y1T37rSYvaZT6peq5dojyqVvdzHNRaH4nbrptc1ZMHcQndFM2TPJ?=
 =?us-ascii?Q?QWRCeIESb3AqQq78FhWxc/ID6O1HV2AFxrdP3OCelQ+igYgxkr+3idPoY+Sl?=
 =?us-ascii?Q?fhHdqnspUF7feOcJUb+MmmQZOqQC94ONob1eMJsoA3vgBRxKxdYN2HoLYw2V?=
 =?us-ascii?Q?sr6CChX0Hi3p9vX2SnWn6CeGjTYzZrhmf2ES7gFlKKcgR1Poy3Qjgz2d5gtq?=
 =?us-ascii?Q?AyAbkCifJnUi5PydgdumJ6ekeYHizKnDrEjaKZgfwnTP+LbE9NNwtXrp3aoL?=
 =?us-ascii?Q?s/dg3VE+stSaui4M1lsrmzBkzf3c39uXlnkauham2hyoEGLctZgYBzU2dVdB?=
 =?us-ascii?Q?qeTf7Txe1v36sLDTAJitvulbq6I2ma/NMUpN9mfnqYc2wfx+WqwrKSJS3mUc?=
 =?us-ascii?Q?kfNI7acagQyaOZNQbPpZYtq/Z0O1jXBGYa0YX1sc0kgRufPYWkM/fcthCzuu?=
 =?us-ascii?Q?Kjw37cHokC2a8AyJgEQPueOsHLWolr4EIL3PqGAvq/Iaj8qxrhCW3gE4+IKv?=
 =?us-ascii?Q?xNR73qehZakkAAqkvSt0eBQlC1KnUTpYxLCine2nIimI88tusb88FWl+AB5s?=
 =?us-ascii?Q?REJdqs2XW7/EJBRV91Hh9HaKueHSdKKotS7hBVLI1ffA4A0NSkoXqdu4bNFP?=
 =?us-ascii?Q?xZsQs4Ql8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedd014e-5961-4001-095c-08de8276efcb
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 09:40:47.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49JkM+CIAUCNaEzETdlfQBalx8WdPoJJxpc+fs2zND55HIcqA6b92TwxvBYAT7lT5bR/5RKjCQoLKCysRi1coQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155

On Sat, Mar 14, 2026 at 10:58:05PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Mar 15, 2026 at 12:52:31AM +0100, Andrea Righi wrote:
> ...
> > Benchmarks that generate many enqueue/dispatch events (e.g., schbench)
> > show around 2-3x higher throughput with most of the scx schedulers with
> > this change applied.
> 
> Can you share more details about the benchmark setup and results?

Just running schbench and perf bench for now, it definitely needs more
testing, but I wanted to send a patch to start a discussion about this (I
should have added the RFC in the subject, sorry).

> 
> > +	/*
> > +	 * Use trylock to avoid spinning on a contended DSQ, if we fail to
> > +	 * acquire the lock kick the CPU to retry on the next balance.
> > +	 *
> > +	 * In bypass mode simply spin to acquire the lock, since
> > +	 * scx_kick_cpu() is suppressed.
> > +	 */
> > +	if (scx_bypassing(sch, cpu)) {
> > +		raw_spin_lock(&dsq->lock);
> > +	} else if (!raw_spin_trylock(&dsq->lock)) {
> > +		scx_kick_cpu(sch, cpu, 0);
> > +		return false;
> > +	}
> 
> But I'm not sure this is what we wanna do. If we *really* want to do this,
> maybe we can add a try_move variant; however, I'm pretty deeply skeptical
> about the approach for a few reasons.
> 
> - If a shared DSQ becomes a bottleneck, the right thing to do would be
>   introducing multiple DSQs and shard them.

True, but then we also need a load balancer with multiple DSQs and moving
tasks across DSQs is also not very efficient. With a shared DSQ we do
really well with latency, but under intense scheduling activity (e.g.,
schbench) we get poor performance, so all those scheduling-related
benchmarks get a bad score with most of the scx schedulers.

With this applied pretty much all the scx schedulers (scx_cosmos,
scx_bpfland, scx_p2dq, scx_lavd) get pretty much the same score (or
even slightly better) as EEVDF with schbench, without any noticeable impact
on latency (tested avg fps and tail latency with a few games).

> 
> - This likely is trading off fairness to gain bandwidth and this approach
>   depending on machine / workload may lead to severe starvation. One can
>   argue that controlled trade off between fairness and bandwidth is useful
>   for some use cases. However, even if that is the case, I don't think
>   trylock is the way to get there. If we think that low overhead high
>   fan-out shared queue is desirable, it'd be better to introduce dedicated
>   data structure which can do so in a controlled manner.

True, and I think with moderate CPU activity this may increase latency due
to the additional kick/balance step when trylock fails (maybe control this
behavior with a flag?).

That said, the throughput benefits seem significant. While schbench is
probably an extreme case, the improvement there is substantial (2-3x),
which suggests this approach might also benefit some more realistic
workloads. I'm planning to run additional tests over the next few days to
better understand this.

Based on the schbench results, it seems like a missed opportunity to drop
this entirely. Can you elaborate more on the dedicated data structure you
mentioned? Do you have something specific in mind?

Thanks,
-Andrea
