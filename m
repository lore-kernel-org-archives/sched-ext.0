Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB843A4F37
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127301; cv=fail; b=ft3Dpp7Uq4VAWSL7bRUNlPBzCptgg1nACUtUUC8Yahb5EDxFRCXxqcBQ2IR5u4f2D3adq7TMMzM9DhfIj18AbWiB/fKwFAlRFAAlMvDiHbJUuuC8oRW49PSsHa4S8/RSbMdevBoxo0YVuKVKrJ/T9t1E9BaBAVLsrmfkzsHbM2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127301; c=relaxed/simple;
	bh=5OlnEzZ6d4Pnu8jkmE8SNoI/Nk/1EYUB+KPaGj+zkSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvKBK67nZlnxDLFb7qWV9/PGFzb8pzzUWJhGeLjDepSuF28zWc2Z3ngqV3KmHAdfgfdEjUEoXn58HGSvtdzLawIwlUrovSM7/OeHWySFQZDeTzRKfkURRWnPj7EKeQ1l/sAp/A0V1SK/3vUwT5hXfp8pvdlCmipCUxO/1Pirx00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vj4xdY7g; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vj4xdY7g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh8VI4iHhPs1gFOTPgULViASLCT56hG7LwhlQORYW6rtW2ha14ogTKCx38MqT+JsPC1eQDOvkSKA9bs72HQ/Ozh/2uf9z5/+dtkI7zfCevqyXmh/Y/hUVXmtm6wN2zUObew9zWwlXClCMpF7ZDS5e6S1b3JCqQdu87VX1LVkB7FCKd7JzORoHaePs6J1rlxlEL6gtXoOr01aQ6uBSyE3D/v4Aw3IEwrpshGDf990n9/ycSsiv1ThyKZH+bsaKA+ALZPGGK/njompGmUqv+en4JTAy0XiyRmF3z383RuXuYfngqWscdl9fxC2ONgUM/460ol/W583xGgXYFmZnFl6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp5YhMx/UinneG9Qm5zudoG7pbEOU/DpYGclj0Oes0U=;
 b=Je5bg+o0ZySmWDlk/UyrERf7f7oLfq3IKh3vAEErIy+O8D8paIO4dD7kYLlTSTK7SLIFDTOr4wC1qxFENxPXbFGqOSiQtJbNUWedAVOm0N3aVk3BmWcm2M+VtHHZSWsvKDNaNuVdaZvtD/j7D/ucODRODc4Z0MtMlvAT/ONCMe/QKqe1k32A4n5+3lBRQoTkgEz+4biu9EOTUrnYmx21YU7907DtBMYjSqUt1LVCHnsPUQtdYlphZn+m6Bg467653lsBRDROTHFF42KJmKEPmnK2qwMBxA/7ovkS3uu7N9uSPvwOZQVUPcsFhOclCMYZ+4vSIapxWSOU4xJKGwYOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp5YhMx/UinneG9Qm5zudoG7pbEOU/DpYGclj0Oes0U=;
 b=Vj4xdY7gt3GLsjuzV7Inkohkrk/e/rykM68aeIKGDHj9chFfNfoTASqXmvnGnRSdqE0DeGXDF2myIXnsJkV2q2X5fthh87DxE1MpvgrvhC2YTn9zc8nTX8NCvkXFMtTYpxv811Vr2k5Yw32cquc7NH1IncWWPQBJcEobPGh7xLMoKvoyqABCdofdlDvM2flYqciEgxp8YAE/06qw68z9xxKoFkHNVXDGT2F1tQVZetqpUk3epsJGztE0vZMKVWUJKnXCmOT16mRSN74czbPG+umSnJZYWmQRLlnFxgVDIvDiLWfUN0NqwvHSaI/ar/ftmVN7cZq2Qex3En490LOiow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:01:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:01:34 +0000
Date: Tue, 3 Feb 2026 15:01:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYH_urViwKNiamo0@gpd4>
References: <20260202151341.796959-1-arighi@nvidia.com>
 <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
 <aYDy-tCqsH990lW9@gpd4>
 <aYEOdPEkgA2eUcTE@slm.duckdns.org>
 <aYEqGSGzxrYU5PZt@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEqGSGzxrYU5PZt@gpd4>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: e908f05f-e76c-45f0-3ea2-08de632cbd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWM1jj+DALJ8OefN5CyRalGl4Gwhnf1BzNbuxks+wOeAkF4Rahi2JdDWsPWD?=
 =?us-ascii?Q?189fbC+2ebE7FSsU9Eh531otsIaE/UI6+wDzQjkdBT2Y30Bs1861n9fz41C8?=
 =?us-ascii?Q?OOZcuAZ+ELCF/PAs6prZxsz8vwNyNa66ikHFLT63cg5B9lIueXCZwCag4JOv?=
 =?us-ascii?Q?ZNTvILwwdyhez2V1uSi9Tae7rMSlYFIeyq/OciWrTcWuhGfuqRP9XmpS8ERG?=
 =?us-ascii?Q?BOosnxWX+knNARJ+jrobd81JMFMlOFrJ04OLEgRZXzoIpm24jBQCtrB8T1zf?=
 =?us-ascii?Q?ingPFPCuFO0VQfY5Q6PpJOlX/t0JvegarCJdGykqlFujw3Y+o9CtRp9192XF?=
 =?us-ascii?Q?y3GP1FuCppPe/YbxU8aUii8qa+mbanMKKEk71MK83HxezKa9eTBNYXCefzgM?=
 =?us-ascii?Q?mMV5NXs2ORVktZtJku7+c/YY1J9bO+qU4tFtkLu3aQfbL5hZ6GmCcVJ+nF67?=
 =?us-ascii?Q?mgWFCz+Uwm9DRs1PbkrqmxU+lXBdyf0FhUiQyOyvGDT3fAZcIx7gwS/wg/DC?=
 =?us-ascii?Q?LCFHtNWqqMwmP1XpLImV+XRvypl9bC1k8De0+STHewOIgzxVx3jPWbY+yHL1?=
 =?us-ascii?Q?kk1DF4CPNxx9ecUxrXzWdyrv6Hb7DcNvMWvd2HhIOJUkrv2gQEwQDFW1x6a5?=
 =?us-ascii?Q?mOm5V+S2g+DAyuI9o0nCmxMUaei4RAawgB6yP+6ChPjciN/Iuki70NAMxcNb?=
 =?us-ascii?Q?ydMndRcOldetqJQnVD5+oCSQDmXREWRafnqyDj+IQSD/YXAKXTf72maHWSJk?=
 =?us-ascii?Q?mrSyaqcjJyhEkOakGuajxSz0PhU7Tp5dDUeyTf/jzhuNvKgQqwpEtKdutTvI?=
 =?us-ascii?Q?DtHWudD6hdTkqB4qFuYN+D6bBW1U2od41qD5NxhVnu7DpNNlU/L42xJyYJ9L?=
 =?us-ascii?Q?RB+hJO9uReCW8f+dXRtMzv6RLG71yKcixWCtuJr2sVezH84OopemQnb83EFW?=
 =?us-ascii?Q?gHi8WwMuHCG763UrjP1W6KRF+62TMnrVqQu0jqOeH+noErS+ByPSuc2+osVP?=
 =?us-ascii?Q?xG/SvOcpsvwcY/mx2ftye20xXppS1KQi2V7A750Aw6Yc4mL5FeJhNoVY89OK?=
 =?us-ascii?Q?WeNulxS7F5WX+1R6GemYMh3ew+treEwN7YIxV6RNP9Nde6daGcUzJVgupdlq?=
 =?us-ascii?Q?5AfpoC+MadWYVpHI7Knkd5Mjsmiu7dOBix9TXndcJ8z2TrrGy8UbDhLBnZ1f?=
 =?us-ascii?Q?vCy6AIwqF1ILkFSa45M+AIvaCrzLMo7HNm1CH6Jw4KIvq02wOnJZHijhKrEV?=
 =?us-ascii?Q?4F6veIzIqCFdttc7mjDhj/+p62ABiUwSIeCC4KcUsPSwBRohXwzRFySgqSP7?=
 =?us-ascii?Q?6UkeF4tG8DH0U4YSKFd+GkLaH9H1FKIJq1YQ3WZvYhkfPnPlOgaGHyiP0Hq2?=
 =?us-ascii?Q?JQIB57Li8ofc5r22iyZ4NrnNKLjkD2aOPZbwCo4/NrbP0emSsbfGKT5dQgS4?=
 =?us-ascii?Q?G/9NqE7Kdyd3CoLe5NfbyFLH9Uqn+nLIs/E8i34VBnUZ3ay6IgCvPsc8kVBw?=
 =?us-ascii?Q?SRK7PYsivEh5iyqahjr9ScY+V/jBaRaL+7C7PX7dxOjyzdiEOtqqNLOHuJkP?=
 =?us-ascii?Q?u5/RInki1c8zvzwrttosxlwEkfg34EVnxSW5heDR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZxG+AFNE4Obl1Au0ONziNZS0Kf8Lry8668P8KUtH9NeM633tDnafDjpxnJx7?=
 =?us-ascii?Q?p7s0HvUUWcnK+WovDk8B0Sv1x+tOBlVItXWr1Dp0h0UrYCOJfRTRsHAPc1eS?=
 =?us-ascii?Q?zGVEkLd8D9UcK6aESbkU5pvIp50DBEHLSjjzaIi6mhg1fXHAEiSEUTFLD8aj?=
 =?us-ascii?Q?qfJ+QH5SdkeZiwL+i0A7/zjaX9sxk/Gnz6XEYJK2sFDw2I4n1zW6Btc1K1AH?=
 =?us-ascii?Q?hz5uhQM0LyLMRKJ7sCEsXDTPdNtHcLM1k/cj52dZvU7VG4eSRlQaQ4fMEzmq?=
 =?us-ascii?Q?MaLfd3pM41y3WWTW0nBH/kW/eW1AgDEtfhFRmkG2hVb9ofBu4NJUATSV6XB8?=
 =?us-ascii?Q?1X+hUT4NcvmNaVVKyij3/KfBG2ZHdPvj0mr8VYmMX9dMwWPsO72SH9cZDQHc?=
 =?us-ascii?Q?YuB2FtGim/RkxR9zgmW7c5UoKDL+L+vIaWsVET5BKJD/PS4v8GShnpHha8Qk?=
 =?us-ascii?Q?uMI2QxTynVRJ870I8JefDqWAWaibVFEU2LwyUWi0U3akJe5ZRJ8fJ9LGBNPi?=
 =?us-ascii?Q?yhJgQZHYG0uzq0c5VXbGq3vq+PGgvJcJGRcofaqyK5VQO9kH3Zq/U3IRt2zc?=
 =?us-ascii?Q?XDTCCo2fH49AFPvVtDRX19SMsdiUw1SpqH7SXlLAzFD/VOrbOP05vSWkzO4o?=
 =?us-ascii?Q?IGkIk8++EQkpzXgFk2ekyk9wrvegw+r+5hrrpnsOkXtKXklTKzu52cpkYVNE?=
 =?us-ascii?Q?fk2hKwa0oiTupNRjvEgqgZ95qPqJL/7niXRtT4PWydm5n0eRPKmbijx6zCyl?=
 =?us-ascii?Q?ABnVjX1watGcNPtgMjsJeU+/D6O4e2IVo1jMjKywaHJOaQuBRkdSrGEj/Byh?=
 =?us-ascii?Q?C6zBJnd14TcpTfPq9gnYQKLk570phyuijzYQ385cK6zlAZVfbi/5d1CAluUu?=
 =?us-ascii?Q?iS4DFklMU9IxbQqvTVDMjLItZoVu8rbm+gogf09vCHTEk8rBRp0FbbU+zqSo?=
 =?us-ascii?Q?n/mR2wZ+0b/JEuyBIwlRsf7sf/tGyig//jC+yHOUonKzdvcgHnQ+MdyHAW0g?=
 =?us-ascii?Q?D5714sNDk7a964gNqvrYGdf1dTK2cjzdorA6CewpYwahTK4a9WMd3AibXhjA?=
 =?us-ascii?Q?Y64+D8/PJTiFLpPhoKLS2k4O1dMZk+NrGTBv9qpmiM2y+ADf4z9Of6HVqEB/?=
 =?us-ascii?Q?huaFkATSk9cMoTivgvIe/YPfhsVIytE4g3TiTlyV6QeWyEm9VmMPbJUBdx15?=
 =?us-ascii?Q?7HzrlA1Z0a20oDjCv3K34DYVwIXuuovIsSFOGYLYJ2VtkjIJ0kNpTNZvpvzG?=
 =?us-ascii?Q?Z1qFBILk49LMp+orRpte4t3ZDr6A7i0ltc9a7hVREwA1Fg1Fq6HAPuvUHJfr?=
 =?us-ascii?Q?CviFaHFngMLAdW7ZbUgX0ApyKj9Ev6nFBR9RXxRO372v7cMrmM9+jlujmXRW?=
 =?us-ascii?Q?MBnIIHA1JM3//zL90zuE34m7OQXk5Y+ofEapxH+vVjhMcVYkfDim9E3UmKIN?=
 =?us-ascii?Q?T1/KADGoAGePJjBGcCmpb7INiKQ34KXJNjJOCWX43WN0Mas5yvmsEPCz1xpF?=
 =?us-ascii?Q?QnwtoA9yVtWuJnzczAJNNB2r4cQvcKd/kCWhO4RPuBYi+HGgSirlGzIpHFhe?=
 =?us-ascii?Q?viaLoTzKfIlIlgeMI+q9jydPHQch0SP5lfIVsiYxsjh+SBQw3rInqww0wLts?=
 =?us-ascii?Q?HJOCIKBXI8sbf157UIs/xVYn81PTfuhM/+MqeYu5Hz5OtaAXdCystjZrt2t3?=
 =?us-ascii?Q?yNqRSzBmVzBiMUqKCAIwn9adIF+eftbEY/Al2PODObPGsvQLNTngdIMQbSog?=
 =?us-ascii?Q?GSwIhBFlyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e908f05f-e76c-45f0-3ea2-08de632cbd2d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:01:34.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwK6vjEu5Hul4B78w9Va4+grGkk6OK1uZaVF8iGaR+DG7BtGHcljsvLzevRg441B811YsZs7FE8U2ffYBkjJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

On Mon, Feb 02, 2026 at 11:50:05PM +0100, Andrea Righi wrote:
> On Mon, Feb 02, 2026 at 10:52:04AM -1000, Tejun Heo wrote:
> > On Mon, Feb 02, 2026 at 07:54:50PM +0100, Andrea Righi wrote:
> > > I'm able to reproduce the NULL pointer dereference in set_cpu_allowed_scx()
> > > quite easily running `stress-ng --race-sched 0` with an scx scheduler that
> > > is intentionally starving tasks, triggering a stall => disable.
> > > 
> > > I think this is what's happening:
> > > 
> > >  CPU0                                      CPU1
> > >  ----                                      ----
> > >  __sched_setscheduler()
> > >    task_rq_lock(p)
> > > 
> > >    next_class = __setscheduler_class()
> > >      // next_class is ext_sched_class
> > >                                            scx_disable_workfn()
> > >                                              scx_set_enable_state(SCX_DISABLING)
> > > 
> > >                                              scx_task_iter_start()
> > >                                              while ((p = next())) {
> > > 					       ...
> > >                                                p->sched_class = fair_sched_class
> > > 					       ...
> > >                                              }
> > >                                              scx_task_iter_stop()
> > > 
> > >                                              synchronize_rcu()
> > >                                              RCU_INIT_POINTER(scx_root, NULL)
> > > 
> > >    scoped_guard(sched_change, ...) {
> > >      p->sched_class = next_class;
> > >        // next_class is still ext_sched_class,
> > >        // overwriting fair_sched_class!
> > >    }
> > >    // Guard ends, calls sched_change_end()
> > >    //   switching_to_scx() called
> > >    //   scx_root == NULL => returns early
> > > 
> > >    task_rq_unlock(p)
> > > 
> > >    sched_setaffinity(p)
> > >      set_cpus_allowed_scx()
> > >        sch = scx_root; // scx_root == NULL => BUG!
> > 
> > Does the following patch fix the issue?
> 
> Nope, I can still trigger this (with the same modified scx_simple +
> stress-ng --race-sched 0:

A quick reproducer:
https://github.com/sched-ext/scx/tree/scx-bug

 $ make
 $ vng -vr -- "stress-ng --race-sched 0 & ./build/scheds/c/scx_bug"
 ...
 [    3.375119] BUG: kernel NULL pointer dereference, address: 00000000000001c0
 [    3.375836] RIP: 0010:set_cpus_allowed_scx+0x1a/0xa0

It happens almost immediately.

-Andrea
