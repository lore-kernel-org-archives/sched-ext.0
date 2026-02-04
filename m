Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38513A7F66
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227797; cv=fail; b=KQZA4BFQpSDSGZP6cxm9nMZOfZoYgVrh6PaKCnvo5YZoljcORBk0bVqGf+JE7KtnZkRFJ/CIGXs3hZ2cUY9ZdNCTGdgyhXk3T1reHyF8L9e9fN/8B6BP9sTsi1UPabGJi2RGkTufk1R2Yv75s+WJe5nRPUTYsYivTbVcVRTLQtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227797; c=relaxed/simple;
	bh=F6zu1rCdHlD2cQj7N0+I5mH6xL0MpGzd4ZbtBuNNCJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HzXLdkaZxSwoBANZwbVx02r4CumfCLRXUCm/rpNm3Ko6XGMr2MgI43XVAEtemNoh0val6/RUvLvJ3Bdjrw+qhxArMUnvso6smTkNYkkcYX7JRRxMunV/hSMHQipBUipc6jTVJHgickXVoHPZlnQTwz1aL66bFEo/99QKEtAlHVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EZ5GEgKM; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZ5GEgKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF8Nm1/zfZndismU1TpILRH5eqOjmkUCC+zECryWQJa9pxSiUSXQwHpDXbPTEFehoJhlhROOXaQDoMJKoa/jZYEI5D17uqz3HDWd00SwbP/U6ZXuqe4pAJq4xwvOITvsVn067SFCBiS+FZ4PplUQRQ62wt1Diob6zPtPrIH+K7TsgCqO+fuLZmxT4uh6ioBO0XbumhgeplWzxYGo85HISJMa4vwEnvsaRLaNGWilTcM7uYQdeaowNGH0JY4ajL6uuvk1hde2jEaCKM+20BpN3r/Hgo1jZSDKClYre5e3eLa313/lclCm43653Z0IUJLI0+fVMLnP6T0Q0MgKtLgjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRvuwU8PI+Tv4pqhzBKMjhiDLqLFP9liI5GdLNidZuI=;
 b=DxQOyVO/aUP495WD0r5hU9elNtAjl0st3fK9nvqb2Fi0p1o2sg4TGbZ1KaXekrRC9yMoDKcg/ecglvCyjiGshOTwUCNBX/gDkg4kOtM64uboQdpqtdbwcIvtK0C0kvzKrTTwkoS3Z1BtUDFEfWiTQcZUGCy+Cm651NIqK8SVtmW/64Otdr3D7AcmYGPOgy5tn0INAELOxN3cwqHfb9OJ0+EQHHnK3mcegzrTC99/VrMGjAGfFgagA7P1JoFNkhc73e1cT5bc5jNnPjFwE/Iv3g3GfkyWwjhaSzsMPveKvi4BvU8zeeRuQAfgalGyEM1WZgBL8rsXv9OTHqW9xjSQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRvuwU8PI+Tv4pqhzBKMjhiDLqLFP9liI5GdLNidZuI=;
 b=EZ5GEgKMTJEztVPW32od2pr6oTpbGSVTus1PgRkd2uOA3X4f4HLqpq3okfjoNxF854VAt3E5/z1W+/eohVGJkh2XxGwpnywtBNyQfoGWqkJIvc8zevLBC0l5Fmti2WL0esVqdJeeJ8OzVeXtbmlpBXgT4amBfXivro1F9AbkzZqtoV8DWEcCZeypLe8ka93KEdovhS0tyYpmEl8+3aK982pm2/ujdj+SO7oTshknVtR/AKhm9Vcy9u+XQQDl5dYHlK5pbi0z3rkqIWBdxstdaTD8LzJlTw/AU32e4bieA9jl7US341qtZlrHaiVBqOiEYrtOe8BvegsjYQpIfzMa4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 17:56:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:56:31 +0000
Date: Wed, 4 Feb 2026 18:56:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYOIRZosqGk-k3l-@gpd4>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <DG67IMOVU2GX.2CKP769EXJS12@google.com>
 <aYNnmI26oS7YNuMP@gpd4>
 <DG6C5HB3PHH3.2JRZX83QMLK2X@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG6C5HB3PHH3.2JRZX83QMLK2X@google.com>
X-ClientProxiedBy: ZR0P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be7873f-99b9-4d2d-bdd7-08de6416ba34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXQ/XyY3olmDp3JhZOUshT8tzcya3OoJCxbQrsLEuCU5MFKIlIRZSED06giM?=
 =?us-ascii?Q?/zyk7OQCKmXJjCDHvecsM6wKQl+fBOK+32Gm9//hgIwLSuEft2XCmPgxZEFA?=
 =?us-ascii?Q?3Ws/FgfFNBM95LT5ZI8uuLpy4z/T1X/bCpQ7+TRDr4/3PyyyRPf/kQO0LKhL?=
 =?us-ascii?Q?yGjoWhdCE8dV5v1gKbdFVvde1YZymJw7zv1MnwQWZDnOb6d1dp7/mKbj1oNu?=
 =?us-ascii?Q?lwqWsEUYU3K9sjsj5s4yTnAduS6YQGVpxA7Gr2R3VplEGz1mx65oIiwesQxF?=
 =?us-ascii?Q?bU0DPevLF94BMI/V8e/Ho+CWR0yx9Ey+09SpZ1Cr6455ndi11bSFw4yVOqfK?=
 =?us-ascii?Q?/se029OLvzRs+L/ws8ahElrdrQsi7yM66gaP+N5DycK34ecKCqrSrRFRIQ13?=
 =?us-ascii?Q?+YDa1AqKoA/DyNwPWh8343OjEPrvcHPfsZraRW4oK3gpq18P+0a8RE+Fb04r?=
 =?us-ascii?Q?/FcA/1E2tdlnt5t0YGJ6g5go1IGrPT1ep73AQo+a7oAHz7QoCWhPNHsTnJQM?=
 =?us-ascii?Q?1KIfVRvyNnLk+UF1/vcM1rWzzRue+gWWnQxO81xG+YhT9ZGCENsKX+xx3YU2?=
 =?us-ascii?Q?fCyQKwWjwV92jOQNRhfzJlsIKrQPYTZYTmPexif6Z7ZhtHOS7CEl1LnsrZsU?=
 =?us-ascii?Q?ly4Ff5WHQYDsxgP1yAxUr+Dee4eJ8KhtKZGBugInZcFT/cMhCp/oaiJXFpBg?=
 =?us-ascii?Q?8qNqYxWp2Yd/ss3YxdAfcHt7RC/8TQzTACDBAZFNhDRWIh1xid6iboY+Al1v?=
 =?us-ascii?Q?rV4fuzN9zUKhklFd+JqIZn7kCTIMOtvLr2ae1XeHJTPa4SRtaMlEi6cvKAa8?=
 =?us-ascii?Q?HAjGMEjZvgTVflcaQi6CGKgeaKuZE1vbOGi6LZuOpTduXdC2L5UhoQXZkt0d?=
 =?us-ascii?Q?pxNv19YawbIxKMbPy8Fp44Cmig+kopVMjs0RmvJg9V/Axm4OC/wof6XcSrGG?=
 =?us-ascii?Q?skTTa4p8/v3eySXzKepGd6Oe50JiYS6MAiDqq5I8HQ5ys47eYYFUVE5Yv/ac?=
 =?us-ascii?Q?AcRQDlULg13cXyqMfE3UtuWfaYBSxQ8ZUjAcSmAy71lDoLHWqqhLFtEecR4s?=
 =?us-ascii?Q?codrWgiIkevGzj+sFGTl4xvG1bQuNhnvQKTe5bJ2u/8lClOGJdEEVp1qPq7C?=
 =?us-ascii?Q?IOhMt1sIbqx+eQFI+lWYX23E9fPLwqGaz4VwSe65+XgV1ButhtBOKBTInz0Y?=
 =?us-ascii?Q?5fecoGK0G0hMms+i6Z10DGJREvyIYBRCj1mDE05letoxpFhAELZ3w1yXvTrH?=
 =?us-ascii?Q?yvcV8mC3BzYTKIzY3NPLtG8LTj9W76+9hFFQJvfuuewbLp8Vg2gkgWfMwdUc?=
 =?us-ascii?Q?TTdXoLiwvAxIrVqBFduwA5aNsafvMTa8F1YCRnap4wbvFaR6QZ5aJ9UzV4zV?=
 =?us-ascii?Q?ETLx+1Gy0K1p8PkiY0uccCIk3DszblkhYZN8f+reCTfOYKnynGgpc4g8rO3S?=
 =?us-ascii?Q?Htcfryvpl8rKGt3JRQaeep7sz/jxjAZcMcAklU/pZtlbvZ14tR+Cx55b3N40?=
 =?us-ascii?Q?/U4Z9j1eHMfxFaIGHQKgPVaodCB/TKl5wq9suJMemvgL7dkXoNobzzvLeMdJ?=
 =?us-ascii?Q?DNfZGY/yJDEmQA5p07E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdncVEoZx7DdFm2FGufzV6OMpY6xbLUvkk58kW1j/vlEwVTHPhKuZpmgTthD?=
 =?us-ascii?Q?wWJeHDlKTSdE5mHH9XD9e9L1q6C0+P620oKXpDKhomoYGEFX1CzDA52Gk2hh?=
 =?us-ascii?Q?wut1WiYH9X6hwfJzHT/4BBBev18SSgQwjn4WkOYXWIifSGyQLRyMb1ZNc+9T?=
 =?us-ascii?Q?zheCyq0v6j2iyhbqPiWhJY/HwmjaUWxD7Wz3HZMOl+K8OqHrvjv/y5/D+jZr?=
 =?us-ascii?Q?erQY7Iijf9tPMMEX5JVE5s6Ehx9AeOiywCCwFKgcm3nvUG1q9/hb6bAYKksw?=
 =?us-ascii?Q?oWi5GO0iqa5MzjUqpiKW5HPETTT8Z5+AuQiGIiQt29xGNts28AGvQeK6Wy1N?=
 =?us-ascii?Q?eh2PcNF0B00VIBD+E0kubnU0yxex4uQi5smWcX91lCDV57GOBXK+ZhFDDcJp?=
 =?us-ascii?Q?vqhjjZJyYTjHUdq1+ldIQhYKvnhYwpnTIt3Q3/hA01DYfvs+Pa8RbTMPCtEJ?=
 =?us-ascii?Q?/1IoaW3/WYSc7ykz2Jz6ws9/zPXbifuzZla41SNdINkCTQHRgJjg+4smErJH?=
 =?us-ascii?Q?P1nne/x6Z8dQY655PisNgBmkXIm0QfofrszTcA51nkI9j8PE/lmaxlRf+Cnw?=
 =?us-ascii?Q?MrxbYrwfgPPRyOHtIa0gDcO1oNKLXDV0jhk50qX8VFqcDWN1Tp0PW0hSzRC/?=
 =?us-ascii?Q?0JNLWltMzFTOBh0CBs86uZf+ETyLVLhO/VycWrxabfcPFrATAYTvsqPM5zk3?=
 =?us-ascii?Q?pcr4Yb4prB2Zy6N+00/5mVyvkZEPt6eK7CUGt4qeQkP8npubvHq1Lc/jmspN?=
 =?us-ascii?Q?s68BBTnp9eZ6jU973DleY+jksedCNkeQJjV/l6AQlOcjJqwD/lRicE9A9FMh?=
 =?us-ascii?Q?GrGRiKXlrxHVV2C65YYDFm10RUI3/qoIlZk5LqgXCpERJTUDNrZc2z3c9TLG?=
 =?us-ascii?Q?pxZSlUSC9Ybl+UgXTS6A1ap1waSlOE8yAjMach6Ou/F+HqYa36p/FV18usTD?=
 =?us-ascii?Q?NKL7b0S3lbuAXlou2FN72JkLxBtm4rADXIsXH6AGBKg2qx/Irqkrhvcm3sap?=
 =?us-ascii?Q?tL4PxqN4Oas+EWk/8IYgw4MN9DfOfywbPIsF9yHGMXa3SuvBxPJA1Ctaxn8j?=
 =?us-ascii?Q?W1FKE+uW1x/JzRCvJg6RsFueYnsftzTn65aRB/vFDsSOvXZ3F9fnWYTfYzmz?=
 =?us-ascii?Q?XF9G1RRXPv29APe4jcYWlPq09XI0vuqkJyCbuxYgJHtrBiUxzEWXxb8CGfgt?=
 =?us-ascii?Q?ik6DKnY5FfhtzUrCCDxs/Z+JfR3nSqLsuyw66myiwALPzedDKX2WB0trvqtV?=
 =?us-ascii?Q?79IrYg6B23mr2TZDYnqcd3twPCjrMfvb3vi5UvkV4s7pK14LvEfnzTTcFUoG?=
 =?us-ascii?Q?6fNihnVp07Siwli0w52HRC45TQgQFNqj0SvLUFRwjl2KqIR3R5waayChCze2?=
 =?us-ascii?Q?ePHLtR+m+qDYWk8oKMm+EB+1dcD72LrOKsKeFh13khnxGatNv3XIMEV/IGyS?=
 =?us-ascii?Q?5n1x9tAReD9nDzlnT0WiqQTO8doR0jjVMBp4VTdfLQsf8wjQ84Ee/HTQ4rKV?=
 =?us-ascii?Q?Ffk6p9R4tnI5WrVqEpfQcKChyA1L8+seEi0S1afl0yXqS5Lek8lij1MvAF90?=
 =?us-ascii?Q?Q9M1wc7Kn4F8j/LECeDL35qUTg8uzWlrn0V4XVUxW1HR9BHKO4pJV/JRg6JS?=
 =?us-ascii?Q?6VR21tNh8TUjM5uLvOsj/EWUO5oKZELvQ3hj0Lh4ETBkKwTZZ7aRdLU1hpBy?=
 =?us-ascii?Q?3VOxpYxk8eeZmsJtOQdQVCtGW6UO4cKBazqd1RuxsZCzekDFao9z2UZxivVp?=
 =?us-ascii?Q?kB6EvEzYYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be7873f-99b9-4d2d-bdd7-08de6416ba34
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:56:31.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev8DZfXpB/t5/jE42ns30wsmBUMagE0UeXUvHQBLaYdlu29ioXUZIEBT66LU0Kw7PLu0O6ozC3oEjUcZtJA8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

On Wed, Feb 04, 2026 at 04:58:47PM +0000, Kuba Piecuch wrote:
> On Wed Feb 4, 2026 at 3:36 PM UTC, Andrea Righi wrote:
> >> >
> >> > When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> >> > and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> >> > re-dispatched using up-to-date affinity information.
> >> 
> >> How will the scheduler know that the dispatch was dropped? Is the scheduler
> >> expected to infer it from the ops.enqueue() that follows set_cpus_allowed_scx()
> >> on CPU1?
> >
> > The idea was that, if the dispatch is dropped, we'll see another
> > ops.enqueue() for the task, so at least the task is not "lost" and the
> > BPF scheduler gets another chance what to do with it. In this case it'd be
> > useful to set SCX_ENQ_REENQ (or a dedicated special flag) to indicate that
> > the enqueue resulted from a dropped dispatch.
> 
> I think SCX_ENQ_REENQ is enough for now, we can always add a dedicated flag
> if a need for it arises.
> 
> I still worry about the scenario you described. In particular, I think it can
> lead to tasks being forgotten (i.e. not re-enqueued) after a failed dispatch.
> 
>   CPU0                                      CPU1
>   ----                                      ----
>   if (cpumask_test_cpu(cpu, p->cpus_ptr))
>                                             task_rq_lock(p)
>                                             dequeue_task_scx(p, ...)
>                                               (remove p from internal queues)
>                                             set_cpus_allowed_scx(p, new_mask)
>                                             enqueue_task_scx(p, ...)
>                                               (add p to internal queues)
>                                             task_rq_unlock(p)
>       (remove p from internal queues)
>       scx_bpf_dsq_insert(p,
>               SCX_DSQ_LOCAL_ON | cpu, 0)
> 
> In this scenario, the ops.enqueue() which is supposed to notify the BPF
> scheduler about the failed dispatch actually happens _before_ the actual
> dispatch, so once the dispatch fails, the task won't be re-enqueued.
> 
> There are two problems here:
> 
> 1. CPU0 makes a scheduling decision based on stale data and it isn't detected.
> 2. Even if it is detected and the dispatch aborted, the task won't be
>    re-enqueued.

Right. At this point I think we can just rely on the affinity validation
via task_can_run_on_remote_rq(), where p->cpus_ptr is always stable and
just drop invalid dispatches.

And to prevent dropped tasks, I was wondering if we could just insert the
task into a per-rq fallback DSQ, that can be consumed from balance_scx() to
re-enqueue the task (setting SCX_ENQ_REENQ). This should solve the
re-enqueue problem avoiding the locking complexity of calling ops.enqueue()
directly from finish_dispatch().

Thoughts?

> 
> The way we deal with the first problem in ghOSt (Google's equivalent of
> sched_ext) is we expose the per-task sequence number to the BPF scheduler.
> On the dispatch path, when the BPF scheduler has a candidate task,
> it retrieves its seqnum, re-checks the task state to ensure that it's still
> eligible for dispatch, and passes the seqnum to the kernel's dispatch helper
> for verification. If the kernel detects that the seqnum has changed already,
> it synchronously fails the dispatch attempt (dispatch always happens
> synchronously in ghOSt). In sched_ext, we could do the synchronous check, but
> we also need to do the same check later in finish_dispatch(), comparing
> the current qseq against the qseq passed by the BPF scheduler.
> 
> To fix the second problem, we would need to explicitly call ops.enqueue()
> from finish_dispatch() and the other places where we abort dispatch if the
> qseq is out of date.
> 
> Either that, or just add locking to the BPF scheduler to prevent the race from
> happening in the first place.

Thanks,
-Andrea
