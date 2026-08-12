Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC83395AFE
	for <sched-ext@lists.linux.dev>; Wed, 12 Aug 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566360; cv=fail; b=PTRFiCLDRM/NinQBue4GsR1cZ3Zg0PErgfjXsbQL/r2uj/beSONrbz3GBkdfuuTDqO3mtdZgCFASf7QvsaSotRrubpNg1I4xiV5gHXz7O5b63zy/IoDqdET4A3d2YCQabwv/2k6G/P46gjj8RJ4N+SuedgnFp2PDM+g76MFNW20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566360; c=relaxed/simple;
	bh=qNw9MlpKbILkSscdowaV4r+Pj78jNPSRN5Tzw93ieD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjKgLKDISqHhAkx+/qPjn0ZfewpctZctxeVt0CMohBzTxEA7jKR0ja+bFATwG9/XZxdqrIR6Qi60mp36CTuZKBD6kdsEZGXB4IZlPuqodSZ/n62qfNq1xWR53OM8kmqchtIXMQEEX5hevLLWOoYW4yokAshTToE5lk2nOv87Gko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMAXer+8; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMAXer+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VniMgVrQ3KU3i77T5ZBEeHHpd5cSgjtQp7VXR903RXnRhoc2gGCWRaqymNPVgD57RY8WLSoKQjaDv4VWELOXMreCorSW8GrGHCgI1JSd1mqMRBjN4FsQqL+8jurEDw5hKRMKXp5M2e7uqDMuvPvqUUurvlljcZWG/iCWOQ7+IHKGFO0fXW1bt1jkDpEy7JwzY2I78QHoXZFkgUQ1gAABkijLTBf83Wc4DCIV6/5hADlZUq7PhcxDAFcHNmSmecy/Th2BIPQveIPsw4PKp9Imzn2RO9ADpn3HvplIR+CkESjUB2/JudGm6HN/kQ22rgfTYyqo9E9dJC59oepEtnxe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1WlK88v2GVzDsLzweNG30Vo3Aj69+9gN11sUhxHDA0=;
 b=MdwbwrH6KZoWC4oXEq24lqe08GNyAgjIi/LbOJ64/Q05EeM6ai4D0obJbReExeGAlOB1QFraAgNoWWBu4q73dFKy99Xg+hSf7xjH1ag7rbV88L0WEGWjRaSRqwDyBjbVPqTB7SQKC9NYc6pgyJsRByeyzsKA+clxQ+xAGAyhEHlLkuO/fFzVVT6xhehpDg9nZmEMZvJeb/a1ge/tKaKP4Fe1n5sv68M0UTzzzbtsW7Ze0s4dSQHtzInE6uziNhEBjQ53nLdO0s+nRImnKy8qziWE6mibRlrQQR+/T70ibhh/DG0YOwANatqUaZeEawDKIBEjOQG+6DieGqCFZSqZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1WlK88v2GVzDsLzweNG30Vo3Aj69+9gN11sUhxHDA0=;
 b=fMAXer+8lE15eteyFvYPPOOMTHW9Vr/1aau/LVqd2Up8QqsqLvNtyot94WQeBq3q/Ex78Adf2oc6MC4F8UmBmQYq4ENLrGxN7AZzS0Un2woSbLGeOzO5S+QujGm3HdWwIRs/lwkHHlr0+GcyPNAFk9lau//S4nh7X0mKMDe9iClI2rOw6WNQ/xVDKvdnGf7zeyRPvHX84hJ7LxzPgPItBMVibmlTEMzK36+iyjhAii/L2k4oxQsLkoIv1Z7c9ocXIWCY+cqiiY/EDscMkq93cRPfX3ZFmCAxX4OeBgKhtOH5tCinLj3OPoVv0YnuekJOZVldtVD1YA1fTDV7vAp2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:25:55 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 20:25:55 +0000
Date: Wed, 12 Aug 2026 22:25:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Fix core scheduling
Message-ID: <anzWxjE_Tv8MB3mm@gpd4>
References: <20260807210221.232543-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807210221.232543-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E99.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::449) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3703d4-f996-442a-5014-08def8afe925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	NBza6+6FJIy+2WcDKiOLChigvhoejIBnDl0LHdJweftxMHWl8haXU2rz253sicH7rl3IBuNdfnbHKujOZmnGcXk//WiGNIyHKsA0kvM2lkMCgKyJKZ07ych6H2jwNOfUUXZogLg+iIzk0vVf8lBF+Js3oqdAuh+j1t2rq5ezHqkGmPDAuA7hSJtz3+npMJ71HzT6QOS6JPRVxQAqq51FES39xb2KjjSJan/AEHfknn+ftT6deZdGWfpFvgZjO+cysNyFm7BvSXgoR8TUyA98lK1po1UUOfcfA9MoANI5gfC/J46aWPtPcAEc+/YZUhWkNsU3atIzkgkiRX3B6mw1PiujGnETDfhe7vmGZxz3+Gvdgar8zZSKHpQez6VSXMSSiPqJsi4/HeUerfWCz0/nmivcYAuzRDL4TZ//E8J2Y/dXMHAdEndj9/4t+W8At0N2ymkd9nKRb1pF7KwBTXQc8he43etzEclRko8Na5+r0o1eCa31jZQ0Ke/PpH0omyRJyPxSeFEurHooJNkS5g6cHoEWDfML1r0auiSgVHMrsMyW/HVlwi/Mr8G4A2qm7R0h9qYrghwVlHEKeQZSyBl1L5tM5/flmSue1d8ikzgi7OYUExvoiO8iI8bujivJZnC08u/eAYtxBidBdLnrTFn5J19zgqphSq9AcRdbC2wBx/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KhbEZ49orar8SmWTVFxvohMV3xt5qf2hzCbRqrPcVPw3Z3ySAoBg/3AjAQi?=
 =?us-ascii?Q?bcdbZRwHGX906bc8uh+JYlxSsor74ovL4wcY/Jj9GyHvU0Ei+mGRvT4K61aB?=
 =?us-ascii?Q?MTrWZ6+kmc3j84XMrBh0Vu2RgwCM+UuQZ3U6Yel+yp9FX6RstE7/RFlgVFat?=
 =?us-ascii?Q?Lq6qxub5FWVpg5fNAewtJlKbHEMkSipVeRPn5kHJaHi6fuJ3s2sgQIf1YtTB?=
 =?us-ascii?Q?p0JSWLykzsv/yPwaszCYTRJ1lJCxr6I7gPUVlhPEIg7VWEdRO+LDxMg4HHru?=
 =?us-ascii?Q?LYoDKON995iC7HNfnpbtMBfype8mQYfd2U0RRHns5EtkdesGO3R327eJ8Wpb?=
 =?us-ascii?Q?vi/0K3S/iL1VEnU6kMGfmT5axNoMJ1dmqRzosAXOMS4SYXsYNBa2gZ1cHuAx?=
 =?us-ascii?Q?YHVS7rQJSZOPLXPYtWY9VbtZB0vkTe5JhLYZkyLeVmgUoidqeU76G25sO83O?=
 =?us-ascii?Q?AGpBxYjiEnCPAH8Q7kthjy/eZGB6HJm4Wpwp+7M9fMdGaz8yT4QU6bqUR1Vr?=
 =?us-ascii?Q?6nDhiilaxCDljYqDi7jfsJXbgIF4+pgYwbRyG8EvWEunWnIrhdAKKsO5ObVv?=
 =?us-ascii?Q?Pf68t7t25x8m2KIimA1cHP2AUaWV52Svwe+Z/IwIxksnZkxWoKh4ZVWOYx1D?=
 =?us-ascii?Q?qoGCGS8+qh40ACujV6yI/uYOrGrIIg+9umoQu1x6F2tZZZ8LT2LR0CFyXtE9?=
 =?us-ascii?Q?mFjYlQdL1ZvA/y6XeKdWznMPfXZpr78qDNGos70My3G0v7XKNcFWrZK7LMgu?=
 =?us-ascii?Q?iRLtJVo6DVWZGXtJfzsZQg/em+iwnNKswssnlDdB5CY/wuxScdn5y2qy4Mnn?=
 =?us-ascii?Q?a6Kf7cbjIN5nUgxIgKQsEHdLFcAzBHZVXkEu6zsv10yMPIEc6ww3vLD1rGPa?=
 =?us-ascii?Q?r1fxYBBUBKZC5p0egGDORV/XYF6aD3HqRtvzol0IF85AEmNyuSsgwij1iXLs?=
 =?us-ascii?Q?s+2Sky3Hs0tUt8LQtsoeXzAyq0a+QbUpOqK6ISanhCm1UR+PxDXjV7FsuBrh?=
 =?us-ascii?Q?NoTcsRHnU9w1bULJqPKYxCjBaM2ElhZ4NwzuiSNQziWh5o0OlT4O0zRpt39w?=
 =?us-ascii?Q?3W8bLpzxtgkUxl7KSqQtuhpIfTncOskhxqjPShKFjzJrIFmOjFIKoZGcP3ow?=
 =?us-ascii?Q?GbmygOecnE+TiZgOP9ajzWwDuEs/6+urWkenbG6eJqM40W59xD2k8uWgIFKj?=
 =?us-ascii?Q?0gCrvTCQ05JNkMzdpzIKN/Z/WBGRWy6UoH0TurnF1YnnsW1PT8Mg/yyN7nM+?=
 =?us-ascii?Q?dtu2RumK5GSQExpHpMl8YrJdvQXEWFxVniIxSCYVoLVpag/zCSC2UCv6gOh6?=
 =?us-ascii?Q?MlTSSjetWDXgeoh6ybaeVMmW8eBLGg+sTrOY3U8OcLrKoGimQz3vVBvc4LF1?=
 =?us-ascii?Q?JuQEDYTKc/w0qZ7W7O1oIGXYuv8AY/5EQHgtPVY0gcJsSYuAzJ2UD2yrLg73?=
 =?us-ascii?Q?OHhj+8ULjLwC86Q4ybogN0PRHGpatt4q3LUm/8+V4XFqopxWhoUC8jCGzIqO?=
 =?us-ascii?Q?JmpBtSBFM8wO1jshtZmyid2nHK8aULQD1SITfj+QYrs1/PjL4XfTHRG3Umey?=
 =?us-ascii?Q?FTuyhXHtDWf0v18Ws2Dm3C8mFWvbN/Iz1Jdmak2mVqsO8wC/5UAx/vkadDWn?=
 =?us-ascii?Q?jZzGNpaOvJxxMVsYCqxfOcBSBBmlFEeRQ7vDz15A5YdAhA8Im2oPJWt69CUY?=
 =?us-ascii?Q?tfD6nPpUzfGJxaLYalf7tIkAZ6x66syg4Kjp0QVqY5OBDelLzBWYiUpbErzy?=
 =?us-ascii?Q?i9+4UfCirQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3703d4-f996-442a-5014-08def8afe925
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:25:55.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7utbtRnbz7RA2oOb2Ya+zkRGrEIHTm8DaoUSEk/eXxALixJEa/3c1Fsvjp9UVpSYVt7uUPpR/Shtp9+mKXVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

Hi Tejun,

On Fri, Aug 07, 2026 at 11:02:15AM -1000, Tejun Heo wrote:
> Hello,
> 
> sched_ext's core scheduling support has been broken since 4c95380701f5
> ("sched/ext: Fold balance_scx() into pick_task_scx()") made dispatch run
> from inside ->pick_task(). Dispatching can release the rq lock, which lets
> core-wide selections on the same core interleave and corrupt each other's
> state - crashing on a cleared rq->core_pick or leaving a dequeued task
> running, which wedges the machine:
> 
>   https://github.com/sched-ext/scx/issues/3715
> 
> The main fix (0006) makes the core-sched pick return RETRY_TASK whenever
> its dispatch released the rq lock, so that a selection only ever commits
> picks made under a continuously held lock. The preceding patches update
> the core-sched pick to handle lock-dropping picks (0001-0002) and fix
> adjacent breakages from the same fold that core scheduling support needs
> (0003-0005).

From a sched_ext perspective everything looks good to me with the updated patch
3/6. For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
>  0001-sched-core-Handle-pick_task-releasing-the-rq-lock.patch
>  0002-sched-core-Make-core-sched-flips-wait-for-in-flight-.patch
>  0003-sched_ext-Replace-SCX_RQ_BAL_KEEP-with-a-dispatch-ve.patch
>  0004-sched_ext-Fix-this_rq-assumptions-in-dispatch-kfuncs.patch
>  0005-sched_ext-Count-rq-lock-releases-in-rq-scx.lock_drop.patch
>  0006-sched_ext-Fix-rq-core_pick-corruption-under-core-sch.patch
> 
> Based on sched_ext/for-7.2-fixes (d4a00d61a5c2). The patchset is also
> available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git coresched-fixes
> 
> diffstat follows.
> 
>  kernel/sched/core.c    |  49 ++++++--
>  kernel/sched/ext/ext.c | 302 +++++++++++++++++++++++++++++++++++--------------
>  kernel/sched/sched.h   |   5 +-
>  3 files changed, 265 insertions(+), 91 deletions(-)
> 
> -- 
> tejun
