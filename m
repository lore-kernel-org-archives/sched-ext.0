Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BC208D0
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019443; cv=fail; b=aCqz/8XaDKxJInLaGQRWlOkvFYd+7JdppMJtAxJqXhfXUkhEnkBZNOrSo9rLu7TZHTaMgaig524U5cICDrp2CnOtKssOTuw+QW3xpWYpj4Ee4CB1ZZxALKaYfpJa/yLwr4Jpu7xAQz6P1L4kyX2N7bkbneOVSlhp/9G73R9vdHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019443; c=relaxed/simple;
	bh=YyjVKMD2t41oSCNKcYGNyorHoINmBcc1dvTRHJahlms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ocG8nbArOySIhyfmJh/sBur7MIez11HGY0CJxABnbNRLdjo0yJ2olma+jA27UUdMD5fggrth18Ej5W8sFOcu8MZ4RktO6ldH0EU/E2ihCaDfRZqFVRPjHm2ZBkfa9JgPLgEBYBg6kvQgZEa0rrY4Dc1mQtDzv8684vhMupfGyDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q70aEERb; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q70aEERb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aALG806uJte1e/OfWsvW0c01ePUEb5/ZcfPIJMN9g2bE7mWyfTG1RtgqL3MzY2ZIDye+nfr+dCakUAejmibOZHAD7sIdSMENZ6tgSEx5Q2E7ILE6axWTcb3uu0KzByR6q8SXCjIZbb3/NkinQnpIzpWb3mVnH6iVbXOmbBI0b2xuPIXFW1azSs90CxHKKmAAPVM7Pq74C2XDZURzcgZZsmv3S9K9t/q8i7fgBe5GeK5j8pk39OWiCa3l3WQkXPKc9sBYHmmX3CTkB0+eirhncqvzs9oTogxvjuYw2zDHRyAKmFs6hbzmBrT0rIKz3+kOnLtdy1UxERE33Ul9CKTnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ieftqi5gQeX+6Ekl6qbIx7qVX2kHNR4yHpsh3N3i6g=;
 b=f8SXBh8CP+OrLAYre4BdPiNXSypgA6elpEsfCjSKp8UYPMlzFxniUa3zEIVII5nHZu5XibvHEmVDbdFJxFssDH/nqTbmFBDCTgEZSfwpxUClU3CX3skmQhXLzIX7fX/XZFGWXBcdL5jmJtxcXrIHoaguW9VjHQ7YKVcHbhx1Gi+fHME7nS9s8rhaVKQLlI2EXBP6xfHc9FsLWeOsOgulIxKyhiR8LnP4ABXM/v3IJ/oMYc6SNXGa8kCR3123FhKITqZf70ZXoySSBgi542PFyuMEFhQp8JuUivwBMrY7n3XsbajlANzLPXkZ9cqrxFMvZzEbLwFO8NBVH8o1V6k7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ieftqi5gQeX+6Ekl6qbIx7qVX2kHNR4yHpsh3N3i6g=;
 b=Q70aEERbqTpp3SlSq7mkAsmgefifD6WOnCns+8Fh3MiEq9LQ14hUxPlqDOAHE+dbLBWJfOebNRxyf4LY30Wnvvqe+Ht4V0xKad3kOea2l+hZrepLPo4xl/yrXbFNTYnirLgax+NRhsnRYRmHykElAzudmS60Dur5egDwdt2A7kruFd09biunhzP0fZYaTG1l3b5WMZxbwbVmwkGSGpdu6AemqaK4jlNCnpTBr+TAwOsQXSlhm3xSftE3/1DBdG8XzfMnFL1ocXWEARudn8Vg9LmA2UQr0/+Cu4lfAbfE34AMNMZT9GT5zrTDOKPh8OMFmoTIRWEOC617hDoxs91RJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 19:10:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 19:10:26 +0000
Date: Thu, 2 Jul 2026 21:10:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
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
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aka3msgKMEt8UDHS@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-10-arighi@nvidia.com>
 <191a3d02-1dd0-4f74-a977-874678632b7d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191a3d02-1dd0-4f74-a977-874678632b7d@amd.com>
X-ClientProxiedBy: MI3PEPF0000753B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cd) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 563b2401-6fbf-472e-2957-08ded86d9318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wfEcqsjB7K7IZfP7+dzjzVXDffMxp/n0kFLYx/0FmMGyHNHtq+YhErHlPqMjGEdz7YMHzJBsM5DMCShxlX04mESlpRljpgagd1NR+9VP7ebojijNn5Qwed9LXPS/dT7BgO5c6dlENcmAe1aake2n6dPPVfSnjU1+9xFyvyy9cXxdC3UERztosa+Xp6pvEtsRS8rh1iNMF2gCgma+CcnWreKnK+t2kp5upNfkpdjy19qooE0xMEbs9agVzhIpDg2o9ZKFGwEXeG+6hk8IP61mzCyr2QPedK/yxbEw/OsN+mqcrdGfbZtglPPuCEa3L7WkjG/6qYzsHBXjuB2C8JQEBOLeYSNgAgP4TImyxREpwpODcagXthO8tdP01sp1tX9Qh7tkIDO25BMh6rfovJjLRoQLvA4wQRhN05TOAXODokJ4392CoMYXznwChIY39IyeP1nPra6dFSCZPy4XwmxdeDVxHJZr+ypah/isH4nf4aLJ7kM2lFQ8Kc+dH0wdXubq7DzLIal7epan52b98a1fORogddfuzGaqyuGLwgVqqhuknsc/OtSmmU4WJoP7mKoQiK3qIr7QRAaC3DparD0ENbNVsYpswLhhi4XhS36d1MnB5xriuMWQH1SgBD6SSJP6tNIvmtGi/rDUy62HsZ2gyP8Y73J8AOW1X7Du0SnEILA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jv8fNbatsCrlbr84wPrlLmpjjxlwGdb+s8xVjsdPlefdWlXCITOBXFJzAPvs?=
 =?us-ascii?Q?iupiWRvmCmoxYmITXaXWp/ZAv1H+87zBcgfrDMurilxIt9MyIw25rH2oPzYf?=
 =?us-ascii?Q?ALLRSbFO1ff/nTSmoE2PrdB6JroT4sJCsJkLEoDdhMDaucsvZHAQxLskoGf+?=
 =?us-ascii?Q?1BKftSTDutihPtKJKz+sFOZUVj2/2WeH00CtZTd6KXX+vP8xs3tMHYCyfiFo?=
 =?us-ascii?Q?MXZlBxKJ57LYBHy0r4PsVl+2X3Cuzf7gESTSnofyGmqayNjaH+02zJe4TsQE?=
 =?us-ascii?Q?PUS5EaP8AgtgvrF+AI6pJ3SrwAGozsfkKrZom3EqbPCi0X97HNnCUP8aJyet?=
 =?us-ascii?Q?i7pEqp7tY+7d9/1cKN8/7hITs8rL+9UqhGHSGVPd3MOhMP+g38nTqH42qw2o?=
 =?us-ascii?Q?AZq79YteBsy4aSc75HhNcsrUqxgcLt0Y4jDe4OxV+6wWc3F5H6XZ8kC6PbQA?=
 =?us-ascii?Q?n5i9VGeHakiq6YhTwC+eNpPLITno+PKU7pk6MSxv8vOVM0c8l6hVrDA44xx6?=
 =?us-ascii?Q?4jzW6EIsPY7lLxSajiEVs/WfUqjvmH6B7mE0Bz0YjnULEmNG+g3c3OCA71E/?=
 =?us-ascii?Q?gN6poKcJ+OyHSfuIWnucNUBawoRsEQp7OBi9rbDj2Ea7gsJo+LSfShFfxJAi?=
 =?us-ascii?Q?G8im1iGINvTnWaiRnq3gNuUbrXpwrF5FnkO8QjIfSz/SKu+qOfOkcgEffA95?=
 =?us-ascii?Q?X2XpXM9AxdpdhtvT82OrgnRTKkaeB1eqb3+gxD59ZKXMm+GXPX0y1mT0FTro?=
 =?us-ascii?Q?nC07eun7gNtBxsM/c6ejFbdnjktXg5bvr2TdtwkgI7roHT9+UwpTGueFNqPI?=
 =?us-ascii?Q?FECpKsE65ES3tHL0hv5efnfIv5QwWnTY5EjGw9B7l5ZPTBSa7fS82Lhez1Nf?=
 =?us-ascii?Q?VYsIEE+34HoHRkfFrYpEI149r81PGBp7hJ64UyCkPCljUHcaOtyD3ciThifv?=
 =?us-ascii?Q?xyUZsYHmZ1eBrhpUbri04OY4eL7pRCpd/ltVUc0iN9o41kUwstMF5QD6YJQm?=
 =?us-ascii?Q?+bsm6W7KmX7Nh9cjlaQA8WGxRx9XnWaKVftsLfSj+0b0AuQMLmmBzKR8bF6H?=
 =?us-ascii?Q?X+0qucG6eK0bCoUo6TjpZJocvHcXSeHg2NxwvQeW2GGU1cUEn8C2QR8d6MOi?=
 =?us-ascii?Q?TrEDtJUkxz8O9o95p5oQYMc51I+FbqAt6keN/Dqh1JcAtZz1cXmDD8pi7I58?=
 =?us-ascii?Q?/YYDANAyeqj8f8oYwfu8iB6rnMTdlqT0NWCUjTlFfRbdRw+fRPeEhJmQniHK?=
 =?us-ascii?Q?JLKtw+phg5sqY4l4oGrCygZZ2Sn3z9qXdWYSt9MKyUFkIU1i4tzilrcCaJpz?=
 =?us-ascii?Q?VWGjFsOfE4Z3qY9JwnnYZ8d/+ayOcsqZcCE35Q3yqbjxOn3WVKx0TdyVydu6?=
 =?us-ascii?Q?WUhcXHdqbWs8vguawM3lGylrnm34cp2QvxxZQHsVmXsPrgQTYd/0Ff/ISoWD?=
 =?us-ascii?Q?QRi7dNIhW2Z3PlziijjjH/xONv3+QbwELRhKPcJbMj9CQpaQxz7iozTR2zzh?=
 =?us-ascii?Q?6SYF+ok2ruEruNxV/eplA+1z1EmtRKX/gOcEHyMCc359Xd5tL61NZRGxC4Kf?=
 =?us-ascii?Q?YPaLzlQ7hFEsOLX06sZ1jv9dBkQNZpDtoqggQYhaEeBQPIbclSbpxm8zE0SD?=
 =?us-ascii?Q?3zHgwcHbW/Ye0FvWYsB7asD0Zn9tX9cNmq05cMdXpKBT+4B8tyaFdRv/woMl?=
 =?us-ascii?Q?r3Bz7Ow0seQBTx54pQoO+gxnI7T8wX+2uPhNQeN3EnbbGqmsLDYM62R/NU6R?=
 =?us-ascii?Q?lLrmFDt0Uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563b2401-6fbf-472e-2957-08ded86d9318
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:10:26.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gkkbJ6xhHAlsyeayIwAgofBOvL3eaz8wgF4cpqBCaF19ufnYCA3W/vP9u2QnBhRuVJTGf7MMwinYy6g4Fx4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274

Hi Prateek,

On Fri, Jul 03, 2026 at 12:11:40AM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 7/2/2026 10:39 PM, Andrea Righi wrote:
> > @@ -7148,7 +7181,8 @@ static void __sched notrace __schedule(int sched_mode)
> >  		 * task_is_blocked() will always be false).
> >  		 */
> >  		try_to_block_task(rq, prev, &prev_state,
> > -				  !task_is_blocked(prev));
> > +				  !task_is_blocked(prev) ||
> > +				  !scx_allow_proxy_exec(prev));
> >  		switch_count = &prev->nvcsw;
> >  	}
> >  
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index c48d043dbe58f..8ffbf857acd51 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -23,6 +23,14 @@
> >  
> >  DEFINE_RAW_SPINLOCK(scx_sched_lock);
> >  
> > +bool scx_allow_proxy_exec(const struct task_struct *p)
> > +{
> > +	if (!task_on_scx(p))
> > +		return true;
> > +
> > +	return scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED;
> > +}
> > +
> 
> What happens when we switch in a a sched-ext scheduler that
> doesn't support proxy?
> 
> There would be a bunch proxy donors already preset at the time of the
> scheduler loading but I don't see anything in the enable path that
> would take care of those tasks by blocking them completely.
> 
> Is it handled elsewhere?

Good catch! It's not currently handled, a proxy donor that blocked before
sched_ext was enabled can remain queued after being transferred to a scheduler
that doesn't have SCX_OPS_ENQ_BLOCKED.

We should probably deactivate existing blocked donors while switching them to a
scheduler without proxy support.

I'll fix this in the next version and add this case to the kselftest.

Thanks,
-Andrea
