Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B13016F7
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783109157; cv=fail; b=h2fEiNzHhWfPVHa3Lran/A+/4wzKyvkGIfwGWIfSGx0NnuhBUZZfrdLUCrDgYf76s5a2X5TuRkgWra8mDZkcHGqHMDZIoyGDe0tsfYCw5NoSArJTv11bS9ByL7NphAwtf27VsUw3o7PtzdskkibIV72+Jnx4YZ2blycYSdCqcpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783109157; c=relaxed/simple;
	bh=0xHSWUzYIvdeWjQK8oIZllJh5cZnVt9hH6WIn5YEcSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IZXw8Er0sD/Ly6Z8SohANiTWvXHErxvj3suq1VaWRDb9BgfeS9tHpsApgyGecgLMrabMU4+Du3/S2FoyiGbiTLMusl6WmrFJczXQ5f5p0AmIwaRuepr6B24Q/AYKaM1oiuDWDjskDu6uDVs3hFVMwAadgXnYbI3tYdYqrRlGoaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DaD4eV+U; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DaD4eV+U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/tLKLKpxt/WU7wVAR5ZGPOvB4aN6Lg4MEIuMtGjZBUbkxAmnRD8KOEfXhKEIBvRC4Ww717EWSg/VTH9TWRJ9G2t8VqsBfUihwxTAr0A3yyInto10OqmY6A/kkWhg6/aS5pAix+F7mIKYhF/nLsJ6H8TZLeh8VDwAPGwfiHOHQyZ5XxZeaAK2z9csvDuFWwR5EgmS4KED5rq749Hw4L08/OUGww9g2mx6Z2WMs7eGFbh+csEiHuAy3Ht3w2CxS9FaDv5DmTJpUS33jXd1wDfF2mBHnfXzs0DYCxRaUvI7m6IVmSXAXX9/VtyMb7jmMPxExg+kNGWodfqrEdoOmAnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnPtDJPF2M1dkMEQDR8WXa/aZtPGpq0x+4iS9XYNSoc=;
 b=Mx7uBwybiZatg6rsuk7tT75A4LVkzLfjb9enmCZhO3fmAVshVP3jFH6KIV9QEcGK9K3IziP9N5pS32nZcRcQJE8hM+b3dZ7Ks5AnK3xzRgcpW/fbZ1RmSm4BV5GUJEHTPzm4yM8wYDUTIj5uuhfF5pFdsvZy8dmMwiorNp5vqSBV05Ta2eL50TSzyz7rTGkvU1vMelndtqlfpwAE4xbnmmcVwJWUmfcEGtxKIbJnEMFRXDCQJdxNnqF/Vp1IKE27DYJpw2ETypYJjTcg6gpDRNhwokWAVynNXm9XrdBhdpaqWGmZ1g38GRwM+rtbjF4BBc6ZKhzCTYGwvpqcVcSOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnPtDJPF2M1dkMEQDR8WXa/aZtPGpq0x+4iS9XYNSoc=;
 b=DaD4eV+UGGX+aW+ATMgaJHWeB1U/WNpaGv2yix0mkIG+iSHnKwrwbH5xaQrLZPWZEYwQtKuf24DkFS2VNnZsSX/8CnKdvrs3+H130Ydybk34KU91phBKu/jburbyuibsmwp0JXIH5s/Kbk9dSE/S6U+bIxgc4UYbheSIyydbLkrSNfpsjXyIwV0bTuQRx5M6MSfBmmX8ZLRk05UDWI7VGlUQoj/eV0osOvZ3syBG+dotu8YhOzYIAJxBoaDGyCtsm6GdUGoxlCbIAqjyelxlQfLoPE5MHgXqLgHtaso1nMvzCMaBrvhU1YvI6knQSg2E2DH+X7/NhdF1lIA/eifYZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 20:05:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 20:05:51 +0000
Date: Fri, 3 Jul 2026 22:05:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] sched_ext: Avoid migrating blocked tasks with
 proxy execution
Message-ID: <akgWEu916YBYOBi8@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-5-arighi@nvidia.com>
 <1d647745-35fe-41cc-8712-aeeeca090837@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d647745-35fe-41cc-8712-aeeeca090837@oss.qualcomm.com>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b62c8-1ce6-4f66-d412-08ded93e7b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3mds15EoNWyABU7KyV9XLIqFXDRR0mL9io3QuNwavTUqtMYpdp2Xw52S5H4JrTJaK3CUQfUFvjPychkgsvyj6vJSq4ovYJ6dBgefMn2sRsSMWvdoBDnWIREywnEjwP433mavufK/tnAKUIPiuRJPbFtP2dsCbPEnJkMZfBrlIqzLpxxTYfFcrEcIphzeA+ash/WUHotbNdT4xlR2PfzyP8TGxHYAOLcu0dwK0e8xyrASvPZDvat5/ixi1TQiqf5dTfGV/s2AsmG9gyAvFZZC5dUTabrlsJJThEHPBme0HNB2YeiJu54/gJb2ebPVa6dY1mLOg7PK30tnJ4QjGX/zbSaA6LDvMVa9zBJsgTNtm32l8hC+aP00bRy6XeHI4I5W2NLIM3Krb8dojViikGDJSU+8hEE+9TN7r2dqCigT42k/dzuvSUj+JWFJqc8hg+M1pVGeqoNy4CvfARWJarvqW9LcxqPgRyddDvjAQfZH1gm/MH9q/ZpItPpUoAoPsNxoUVqzQVIlgGi3MlxGcL5I0daeDS59BEDh2Ej0J+tjkvTiCxF9SFAr27QK3EaVWtPdOu7ahVo0WPkMPP6bkD66E8/KXyIbuDr4ttsouagStUd8gABS/YCH+0P3b4GRUkbIa4zJwEdeJlokXwkxr6NKruSEGgHiwSudpCcECe3nN0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbKZtWJEiJ9QsGcoauhbKHOMH6dxd7SBPfojEmBMjzkv4jEIl8GP3cxpciQ3?=
 =?us-ascii?Q?QhmS0Wr8mEVxEdiCFfIxVa733cGu7GvgPctSSVnorJkOQrwGjtyfW5UxEtYC?=
 =?us-ascii?Q?Yr7M1ZPWkaQWS2+qWbnd+tFdge0pVzpTLIR4oqrnIOglzwd24jFagl+wbpOL?=
 =?us-ascii?Q?5WVsHKsjtc02YOIX4kXzMoH4LqKJHFWOH6gytvIKYDjrTd2TJNnMqMPBPdwt?=
 =?us-ascii?Q?wZRIabfRh6+TYbMFtQuXVGis/R2VAbAroyNc8T6tEBMH95y6OzCwGdFTUBGU?=
 =?us-ascii?Q?wplGEtXcdENHH0ycxEZPPz7hKvom36U8vcKj9CFYV8TwKZ7Wuvq36kphTgXK?=
 =?us-ascii?Q?7XHozQMbmtPcBPI+CVQaJtxZQECJBBQq5uDIVgx8e8e3m/uQdPA/a4clROKY?=
 =?us-ascii?Q?wtNUlFxXKvXR5un9mWVpku6/A7g7dQMcgOtsRtb+D6vd9ICkq5KnTtbo+uyz?=
 =?us-ascii?Q?oaHl0hHUQUIMAkgofGVpaeggM8GWJx0QLScRABW4kv/SGFMRBOzjQw1/ZouJ?=
 =?us-ascii?Q?9+m0mSm27lVj9WmEECfJ9chl59rbh4TI2EWuVH/nsmRQCqaUlTbG2+QeSZvt?=
 =?us-ascii?Q?oxRQHauVjHVsiuyLlBorYh0Mvp4jPnhq/19YnrAl+zVTjRq2uAkth7rDQZiB?=
 =?us-ascii?Q?BysZxnRRHkzyTAD4tFUFk3GOBwIONqTGTAnCh76NYlRPZaWEg4GrWNV/mY3o?=
 =?us-ascii?Q?klXIX9fW38FkGjWpHTmlSmx2Fmc0E//ycaA5F1sD0q0yKxulLrZfuDooxH2p?=
 =?us-ascii?Q?FrCS3VLP7N8bRTWkwVLDbEvHVhzxn+iRa+XOoK4+iyjOag5vjV86pr3fli5s?=
 =?us-ascii?Q?KJ3j3d8De27G3vKiAd5/xJJEBYNxDxnwBiLuU9H5bH1/YW8ZvGVagSqEPoZ4?=
 =?us-ascii?Q?YHbdMNZTSVXSFxBFrLa0sCQSX95PZgV4hyvdeqZe3Dlyjd+aRmUm/ZYJPpTA?=
 =?us-ascii?Q?9E9j3ydwwRn4OQnw1Knh2fiP8eLF1Lhu/HaAtyrpu4sR2oHkJSVV+i95Kj1W?=
 =?us-ascii?Q?nUIZ1uLutXn5QZ4dyf77p6ChBoSWqg6MRvkj3OsGNWv0QacAiddzJwdQiBuR?=
 =?us-ascii?Q?NnOdps4IjyymruIkYooXF4ycRZh2Mbf6ny0WKjW3sU2wQ3C5gGsVQ6RCyhsw?=
 =?us-ascii?Q?26t7+iGWXIMAEcsHdduQydd6enw7Yy0LVGeTOLF9R3Sx3ibObDLrb8LbajNW?=
 =?us-ascii?Q?vJJMr3H5xMKNeSQZfn4of5q8Me2xG4mNxeTjLJUj3y31lxP/5W0+g6AOLL0V?=
 =?us-ascii?Q?ucTZHbe+rPioBCBHQD4nn1Pm2BbFRnybmgostWvt/veq72OH6pNwejssoojP?=
 =?us-ascii?Q?DycmZVowlu6UmKYMNXu7R3cABAYrrpZvyVJRpB8MHdO+UqGijRbeo86t8OyF?=
 =?us-ascii?Q?hqNkiA3k/2NFpfTL5OeZbgRi56sLnXrWHLSMUreSCfcVKHRfQQsPCniw4wlu?=
 =?us-ascii?Q?HRz7YTxe4VHt7Y/Q4ckTazs4t5eDDUethUz0Q+NqXV4ylrByuwzR0T0JGYWN?=
 =?us-ascii?Q?wrr46I0o69l9zwvX5ybbGxdBDEFx4ZMsupZyNlQTjphKMTOzcCvpI6nZwvZh?=
 =?us-ascii?Q?+EXQOvP63mxdJhE+86iYAokw/ION68v3J1ic/iVUR/lVw6w9sm1TSfZj1xQu?=
 =?us-ascii?Q?f7fi9w7aRbmVs1wgOI8h8H6M820W3gNr1WEIDp3/r85Td9p0Id+0Y08bFW86?=
 =?us-ascii?Q?nUolBm2CjrXrbvqpBXqbB5UP3wV47pbD4i6XAHe0bsydPf0jkm2dMCMAr7u3?=
 =?us-ascii?Q?UFBZeECvkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b62c8-1ce6-4f66-d412-08ded93e7b2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 20:05:51.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXha9lB5S869gOsa4Y+/AL4c7DUDaLwVWO0bD9m7A4xaXwlLPYJeWqmJu6f0HjXFDHUKOd7OP8FIluqJTz4MkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

Hi Maria,

On Fri, Jul 03, 2026 at 04:02:16PM +0800, Aiqun(Maria) Yu wrote:
> On 7/3/2026 1:09 AM, Andrea Righi wrote:
> > From: John Stultz <jstultz@google.com>
> > 
> > With proxy execution enabled, mutex blocked tasks stay on the runqueue.
> > Later with donor migration they will be migrated when necessary by the
> > core scheduler to boost lock owners.
> > 
> > Don't try to migrate mutex blocked tasks, the proxy logic will handle
> > that.
> > 
> > Co-developed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> 
> SOB was suggested to have the current committer at the last line.
> Not sure if it is the same rule for the subsystem here.
> 
> My understanding would be:
> Signed-off-by: John Stultz <jstultz@google.com>
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

You're right, I'll fix it in the next version.

> 
> 
> > ---
> >  kernel/sched/ext/ext.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 1588565050679..9a672b9a55f6e 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -2150,6 +2150,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
> >  
> >  	WARN_ON_ONCE(task_cpu(p) == cpu);
> >  
> > +	/* Make sure tasks aren't on a cpu */
> > +	if (task_on_cpu(task_rq(p), p))
> > +		return false;
> > +
> > +	/* Don't migrate blocked tasks, proxy-exec will handle this */
> > +	if (task_is_blocked(p))
> > +		return false;
> 
> what about return true here for owner_cpu?
> if the owner_cpu is in the move_task_between_dsqs stage for example.

Good point. Returning false for every blocked task is too restrictive, because
it'd reject potential remote placements requested by the BPF scheduler from
ops.enqueue().

But we can't simply return true either, otherwise we would bypass all the checks
below, allowing sched_ext to move the donor even if the destination is outside
its affinity mask or the destination rq is offline.

I think we should do something like this:

  if (task_is_blocked(p) && task_current_donor(task_rq(p), p))
          return false;

In practice, normal migration can happen if a blocker donor is not already the
rq's current scheduling context.

With that, the BPF scheduler should be able to decide the "call back home" CPU
for the donor, if it performs a direct dispatch to a local DSQ different than
its current CPU's local DSQ.

Thanks,
-Andrea
