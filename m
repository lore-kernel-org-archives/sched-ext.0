Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084275;
	b=EU32ZVAmNzM3rlErmhEdWCG1UrMQYqjccdMa4qNVYlgQ5KXTWOmaSQqRBN9m1umNnkah
	 P5AAJCGqeCZ3ioxCoeY860hobeZKP/t7bI1GdaE8U5txLg4Hw1DVL1o5Cgd4ahoi3T8go
	 BNmaUQRYc3xuMcyDSAikZqU1DRrCkc5O//FuYqT2yf+KKM6Zo3o8pYtQBp7BXQGX6k3Zw
	 FKcCJUtNkPnmRbh3pka0ngNvIhiNvHHeIL+YwKCw4dD0gwtueMl0X4OSEe5oMvbkQsaor
	 R4lWBKIust/+Wx3/tAsmpU5r5s5NU43evwCvGH6CWDlyU+KM8TLTudhfeSMyj1ICm7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084275;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nVrSRLplUAfKKDDkfVH3HPGihsl/xXqf8RFYOoo7rMU=;
	b=WLw/T4FQqcyLk0QPwLfnt51kdKy+1p/jQ6cKGC+aKDj22Ie+0mWfw+/mW6b55WDH5yGg
	 Yy70wOxYDH2xSLDb0qpyEPkSMC9cS+hQj5J89SxIcZM0gjQEiwA9EcFvFsT0YisG8y4g4
	 CYS+MkSQlAHkmwrDJPB4/6nYcKWPchDeCJ53jLxAau5PMdqXnudIJBgOxc9+G5ramflFR
	 8L8nA96F1Tryx0nVI9CKIjMCt3ksg/ZyPY5cRaxfhgBkmkU6VVSVuMsPC+ggtZ0fx9D5f
	 6ArRLX/HWAf27vtFgYMQ4fAgywfssjrPYAMYLp/c6cdQhdKgzplwDRyMcaF+l8IP0cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E6HbsoeD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.62
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F7606A320
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 06:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 152F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E6HbsoeD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA8f384YVerV2vavkhKgytTeyR6WTUyENiSJ/t7Yx8reBdrJ+GFT/Hrj261RSVhaY76P2pLtlSlSVpYYH3z0ZVZ5S6kPjhaGkDNKdRl0NLukEDYXdOmWGmTU0tSnJQwxyTWQRWsI8KN1xmnPiaH9/LQ85AonA7bOlChQuP2it8F3KRp7Rd9ar/ZLB9EPsZduyFI0ydGDkVaMvXH74n18HuNvUmWI9v/lmwXWNMpmPH2R0Ftw4qNqPR31yxt4mmGkXSF1yCDIJwYH9EoXg7IhQHltvAD/+jFhZHvgMgkStdsamSr+KIIZ1b0dm1JJTk1K8CwxbI2oeNO6OF7rVoyw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVrSRLplUAfKKDDkfVH3HPGihsl/xXqf8RFYOoo7rMU=;
 b=cW/f5yXUTklT3iasq06+N/TJBKixYrS9pC3JSfvcRXQhLjuYQoz+PQAqT75bfTHH/G2F7q5iAQfxp3CCt4lLwwRv+QaCIQA/iSEBvkMbG6dR2ql225zTaJ/P5/6lypO2plr0jK4KZRvQ0beOb1GO4Ri9tBCO4dp7NLrou1CinwFuo7FSLonPKVWbC0MS3ad0skN0Mdup6SQxaXsZZ1SHx9iOp2NuvDLae2DR1hUUwXtqxq/j9Ypi8b0Xhy9i124u0caYdMnXpFF+sIn+0YGjA6T/b7PhcJH3anRHdrCEFMWEyZjUL3Ycy4vggU26kXI8xAFy0n5JUkgpGErkh8Y+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVrSRLplUAfKKDDkfVH3HPGihsl/xXqf8RFYOoo7rMU=;
 b=E6HbsoeD9VJKTfKH5dDhqO28uoe/WOjb1o5hsnq6auBLWG1z3YKeDen6i98BFBeQ5utou4Wpn3QsdAlOuNHvPAU32WdPw0r7oRxkeQFukYydUM2qFMnKJ4ihCeneXY4EJPvdCjFWqdSAnVHWD/pi/aC95S5Jo1q8O4m1I8fxXMo58NCGGeM2ZUVxmxqO0+vnmMTxdO8SbHiTa3rpoER6zot+feAntUh1zSpTZKmIFWGS4V6orXIoEtRseOhvc6I7UPOPdsmsageVkNLzAaJjXnT8R05TTdyhcYZHzV05jHTK0GRw/SvEGQpLlHQEHhk3q+KoEJu1b5qmQM3e6vBPIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:57:43 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:57:43 +0000
Date: Tue, 27 Oct 2026 07:57:36 +0100
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Add a kfunc to read a task's preferred
 NUMA node
Message-ID: <auBLYFDJ88gTxtLM@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-6-arighi@nvidia.com>
 <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ed3952-729d-4b56-7526-08df33f79998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	q2VpcmDMwPgiIhF1qpb1ABUVDuQzK4BqJufZpAkfDEp0M2kC2wNrUroQMOy5819oX1v1v7XictmITcI4PlRm+Gv82HAal92iPovbH8rt6bECBUhAxSp67omwlaNdJvC/PZMkvszLR6zQnEN7DpmfTNADfBmrFRPFKDdFUQsXr7O0APJsd3btDC5jDrt4IiscIN7VD9acJa2APEpK3H9Xc2mdCMm68ng2asm0cxwcHkcvNFE/sWLMc+AyLfJj8UR/i3LVhXhyzZBchjB1UB2EY0nYS32stB1izC1n2r2cXwZq9aLfGkbh7zD6ZPSL3oUEvCrtdZkA+IGzTlAUYXlcaynOZ3kpQ8ofE2UvsU3gYXacQwk+gN0VpiQGHTW1RDpoDVUlthlbfZqSrkqnQVo4X324IC8UgS9mNGmSL1CixtX7ueSt03nVFR59EXguVhNUccohz7ftkUNKYQ2kpPU2Mwa6edOPx8/7tcju9pCg8XcUXaMydz89DOYTGHDo2U65Vr7bB5DrQgt8+Vjgg/a4CG5E/kSH3i/0YnS/MlUHmVydCcysTj/rxkMmM+dJYjYrWfnFNUftoL7WYTTqEQ5tYb8Buyg3HNln4T0IvMZjwTqKR4jT357T17V6UDB9125y1NIPOuEdFl7vlHfCetUK5/5pGe2FxvuzJSDcKw2r4Fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0fmRqLIq078P4HHjQxOflTbRT4EcsTrQXa+TTf9c8BZInkAaeHu4Tuzdkn9r?=
 =?us-ascii?Q?rOtDUCXKmFxJhQBjNIJB8MU5sMi5q8JiLU5IdrPIcwRVGl83FavldrS8Babe?=
 =?us-ascii?Q?/5g5kIlcJ5zAXNiugqU+v8EewFquynrMbJdcu7xPX2hrP4yD0hT1JmBvYyn9?=
 =?us-ascii?Q?BP3MCTcImMQ2FMTKr/t1ocpW8hl5It+QZrUvJZwRnX1WWR3cIWi+ftvV9rkR?=
 =?us-ascii?Q?N92rP210vBezLF9dOa4CkF+V7H9A2gxYVrPsoEoeUKPQJvWM1kX5vfkRLY6S?=
 =?us-ascii?Q?t29/m9NBhEvuDkb37D+qdWsiaAx7wP30RnpaZE8UmboOuBvKEhwHEIiGZEP9?=
 =?us-ascii?Q?TVpt4fRTJzCjF+FQFU/Tj31/c5Rsnhqb7ohKJPbbA3kSr4IUu6OXJXS4XCPP?=
 =?us-ascii?Q?AUt6/UUZaBo8r7juk8ebuvJyvfESdHf95e7qrQTHqnIVqM9ndS96k2IoIp1/?=
 =?us-ascii?Q?Wk1UgaDy4RuB+TKCJedi14trEMwVdz80wbz+2vN8CZDBtgSRSVqM8ly1Tr4I?=
 =?us-ascii?Q?walK4Q0gLcgwE6ZQxliWQ5gHzimBxeVXLcHdmlaalOZqBQETDg2fvQWnnKmN?=
 =?us-ascii?Q?NXLKOgkys5HtckGFWOaxRNPOEji51jw5vSlYyedfenuVib6b/Z2xAsl4bqtc?=
 =?us-ascii?Q?4tBBWo3B984IMGGanOnJcZ1ikYzRbeLgHTLRdwrzyPuGUtRoPe806wlRk2K9?=
 =?us-ascii?Q?2UA3sRrZJva1CEujngzrxpPzmKBsP3CPqRy2FKp3i27hDhIbeK9cLHxZQSZZ?=
 =?us-ascii?Q?pkMuPzAXgwP6Fwj0GE2VMf/h/xoXywfSj9ePlnVQ0UWf/bHWRLPSXfrAqrM7?=
 =?us-ascii?Q?W2K+NW5Fl8mbwWzrP7SVSzXfOGBNrBDexZHcf+eAohqJ/M0DJqVjDZUO1APK?=
 =?us-ascii?Q?8F5Vk/sqHNmnZma+HI2TVK2O5HwRoXQpJoq/KGAJmCpJ4gsNJ34WJ8lzuGq0?=
 =?us-ascii?Q?ld07YXIZZz7NXpA3XtnJwCIcobGlj9TfX68J8zsR4tCDU9Sk+jCCa4cZwKXe?=
 =?us-ascii?Q?9YpLDmxK4VX5hmIb1aE6Yj6d3B+jd2GxRvm6Urd89Z/s2oiP4vJJtKzjnSje?=
 =?us-ascii?Q?YO55A/e3HRqFp+zsH3MyrjUQXDh0NYU369U2Jel9O35As11e32dwldrdIPDk?=
 =?us-ascii?Q?n1avgwN1X5MsKzRb2v3LwX/xEmdxnmWCflAopxC4bpnOK8lp67XSqz5KhGoF?=
 =?us-ascii?Q?RF4ESG1BDHuk+zt0eSv0IL4KdMRrCuubar9Q4cIviBFEhb6TMJWAMNPXUpn9?=
 =?us-ascii?Q?HY0k1KSKen1gUvf6XFkPmKGea7pCGGQmSIjv8CZb/TApUneb4W1mKrLEppNc?=
 =?us-ascii?Q?IHYsbOuWJUAJFJloplrWjx3UDphESK6HXFSXri/SfuXeX0B/4p10JpKAc4xX?=
 =?us-ascii?Q?yUzaTlw/1oNikmUxSGLppReB9E5q35EYGLb7GRlUbkB2AFAoZhLaVPqHMswe?=
 =?us-ascii?Q?Rp0Bn+ABjmtrtMgL72c0OqShE5+EGZ6MRmY0fxtmRTAfD+bdq7P9qR4Hm56Y?=
 =?us-ascii?Q?RXoatMizMr9Cs3SBbh7InY+XkINF0pkAJaxeSnhHbSzUozUAagyQbynhqz5h?=
 =?us-ascii?Q?QrQiPPcEC+7lAI/C/XjtDsu+AkTjelNT1aRNC6sNiYPHdtsc3nJdyDd8tuZv?=
 =?us-ascii?Q?gW01ZyrUxuDKr/FRYlsKNUc6OvbXpS1X8sKzuXj+u4DlbvnDURyN6bhFa2Cm?=
 =?us-ascii?Q?2+am4QdEfObZdkYbGCW0GROMshAIY986O1FUjGaMGXbxX3hMWZBR3+oP0u9d?=
 =?us-ascii?Q?4nwj5vTR1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ed3952-729d-4b56-7526-08df33f79998
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:57:43.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+I92bsOIADeBdJbCgXlmWS4gx9kI/gSDWwmim/DFGDUjrYAh+lEMQYSSlC285qVQC36om0pgTbI8ArEgxnUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

Hi Prateek,

On Tue, Oct 27, 2026 at 11:42:22AM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 10/27/2026 9:43 AM, Andrea Righi wrote:
> > +__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
> > +{
> > +#ifdef CONFIG_NUMA_BALANCING
> > +	if (task_on_scx(p)) {
> > +		struct scx_sched *sch;
> > +
> > +		guard(rcu)();
> > +		sch = scx_task_sched_rcu(p);
> > +		if (!sch || !SCX_HAS_OP(sch, set_numa_node))
> > +			return NUMA_NO_NODE;
> > +	}
> > +
> > +	return READ_ONCE(p->numa_preferred_nid);
> 
> Would the ext scheduler need the raw numa_preferred_nid when
> sched_numa_balancing is disabled?
> 
> It may just be pointing to some stale value if NUMA balancing
> was disabled at runtime right?

Right, if NUMA balancing is disabled at runtime the value stays at the
last preference.

This is consistent with fair: disabling NUMA balancing at runtime only
flips the sched_numa_balancing static key, p->numa_preferred_nid is
never reset, fair stops acting on it in most places (e.g.,
migrate_degrades_locality()), but not everywhere, find_idlest_group()
still uses it in the slow wakeup path. So a BPF scheduler sees the same
value that fair keeps and can decide whether to use it or not.

A more accurate approach could be to notify the sched classes when
sched_numa_balancing changes (e.g., resetting the preferred node of all
tasks when it's disabled and recomputing it when it's re-enabled), but
that would be a significant rework, involving fair as well, and it's
outside the scope of this series. I'd rather start by making ext
consistent with fair, and then rework both in a more accurate and
complete way as a follow-up, if we want.

> 
> > +#else
> > +	return NUMA_NO_NODE;
> > +#endif
> > +}
> > +
> >  /**
> >   * scx_bpf_locked_rq - Return the rq currently locked by SCX
> >   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> > @@ -11836,6 +11877,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
> >  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
> 
> On a tangential note, scx_bpf_task_running() just does a
> rcu_access_pointer() (resolves to a READ_ONCE()) and doesn't take a
> rcu_read_lock() so does it really need KF_RCU?

Ah yes, that's tricky. KF_RCU doesn't mean that the kfunc takes
rcu_read_lock(), it's a verifier flag that allows the kfunc to accept
RCU-protected pointers as arguments, in addition to trusted (refcounted)
ones.

scx_bpf_task_running() still dereferences p (task_rq(p)->donor), so p
needs to be valid for the duration of the call, and KF_RCU is the
weakest guarantee that the verifier can enforce for that. Same for
scx_bpf_task_numa_nid().

> >  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> > +BTF_ID_FLAGS(func, scx_bpf_task_numa_nid, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> >  BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)

Thanks for taking a look at this series!
-Andrea
