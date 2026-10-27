Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093455;
	b=bMTKEKUb1AQZu8cIvcgId4ZirQEVAxM4q7E4+GPpik68LUV75BckYaHdASUbOMhf6/Eg
	 YaHwJVYvnuihMsBvwLM80ebv6J5rIAH/TA5BNSdR/B5uOlzmsM3z3GBqzwlaSb3+rSc+M
	 h6nR6/bJbTZwH3BMryqvEdEpx8yIlrFZjnPUND1MKZvkD3wGCJYMPrlNyD1VxFILHJTmv
	 uccAYKdvIgiV6p5c8l2upoa/LEFB817jZUAanOJ3sazDlDsSkmEdUem0TpJNw/YsEHyfM
	 AGtVZvr73p1HW4Qm3oHpLMinPgbKhoJ5pjkQVKWHQFfhdbgNIJtC6kcqmjwTu74JiZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093455;
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
	bh=TJ7RfmPI3iqnpNgWO4PhRwGMAeKa2mc7mIcA07/teDo=;
	b=2O3r64IB8cn2u+SthIni/SggRd2l7ADQN/cJ4a5cDwxVEOLfn2IEj5mFm+vwR3/7ACuC
	 c+MGolBr2mXGEMrum3MSYKQ+FCfRnT/T7yhifYWuJ5ONDAn8c0dVPLcwI6cAMAC4jkqF+
	 fjSFyBiy6X7Yqf48WsD5j+AP2eCV/iAiFSDVZzrcB7WSx1PUgJev8rao5UTNsCQGUTOtY
	 /gLRicFHH5zwY9ErmUFrxIRufsnweD9WeDAvArGtjcqu3M7l09PR4SyXzBCu6U0ftb6dM
	 6NgZ1kMa9D4pT68kiM0C0/1SpFAm1Fy4GytXkTRqCdLiZ9HQ8agVAg3Q/cSn9/3mmBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tVnT5n8E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B3606A31E
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 09:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 916B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tVnT5n8E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L67pv7MjQ07IoLO44g8tlPe3+QkdHTbVAMW3EWpee9ZlqyNdSA/W9MIKm8c3jShdU0xFWu+XkerU1ez6XuyEMV13SKgu/msThmLDIsRDRGMGuY6vpiP+4LHRFe9j5g3A09QTaUEV2uUWzg4rxRF7qLeQKjZNOoQbc5aki53U5ezC2QwnXnOznndp/bhcMVszu6ziaPmOLVrJaicSRk5Ws8nMJewyFdM0Idatz3Aji3FWnYrLOpLF+KBqzkacFMlgyHL9wlZ+xDhXwHbMxT2e/sJ1ogqCHJe+vCzkyz0xjkf7c/lmpAq5a5uIclv1UzFDJCrvRTjMD+iFt7ST5EYwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ7RfmPI3iqnpNgWO4PhRwGMAeKa2mc7mIcA07/teDo=;
 b=wqLzmHB+TQytQ2H08gh71rtpJSAF5PV0BPjncoaLxu+Org2VxItnvAaXaJ7Vmydq2RocWBeio8oBG5rdMiqTl8zHplNgzIr9JBQufBY8XCGqjHVWPuhiW/Z/GB5l1HCFK+rG9lUaPUQ0LauPsp16TyaWSx29WKAvMtn+btupNtTSKadjcAteVWenKjPmwEdtbnJu6JhccaHhw1FNYmqAjCSjb8LwvFLLNdjTf6AYGU2U20sk4CdxhDP77VOlGvj5XPfxKynPWLr2EP+1od14zF0/JRR0MFa9WNsJvKtmXFoRH1sRjvbQYVli2hdPkgZOTp/bdVLzwTAunSnqznmsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ7RfmPI3iqnpNgWO4PhRwGMAeKa2mc7mIcA07/teDo=;
 b=tVnT5n8EySnMqizHfVxriSjHPp1bOd+HMCDm1r5n1YAZXhVZ6PIKN548xkksTamwxXC4owS+/Vrb8uvdWJwha3wC3HH+w74DFUnpo0s4y2yhPehKRZfTTjOv2w3yZD8ro4yH9SNy8unZzdJjCVTWfKAz9eaxLxPVc0jtL3s0pnNG7tl9+lvx4OkWryS0Pn2nnnWOFAxJPos/WKxN2o2W2e2C1ZnI+5GBRY+cNcx/VKo+Dq6kga/Uku9NmLg5d5h49bYALs1X11wDIvx7E6EwkoT1slowr7kI8SzvW96Ar4SJKm+N4jRMNuRfBsYxBBgqSqzqJSyHDlK8k/lUwik33Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:30:49 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:30:49 +0000
Date: Tue, 27 Oct 2026 10:30:41 +0100
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
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
Message-ID: <auBvQc7-lfMMoQPm@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
 <8464e356-d1d2-4aea-8702-40429c63bac1@amd.com>
 <auBIGwZfPR9oDPH6@gpd4>
 <d63c6e92-a722-4061-a9a0-5e84a3313c43@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63c6e92-a722-4061-a9a0-5e84a3313c43@amd.com>
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b43daf5-6961-422c-7357-08df340cfc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|261026140227099003|22082099003|18002099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pcnFkVIfyfgjt9jcRXUxdQQqXWYE61MiMVlnhdzsga+DPQ4Yr7twRLRlLBmi7eU2WxPv8SmE/86HcqOF1zKeRURxvcR2RJgaGBEoqJBRohwCNaa5+xwGtyG79jkXQK5LvA0rc20n0cUJ//Za7+wpwIZfPeW7optRBO7Xn5hiLUjeFnxRQvuQhXjoKMZWSXozaZKM3QpsfJnU62PgAmG6CaDyBwQKVwU6qw43pulfbSTZpIwfHzfLcG956c4XSHvAZvNC/2vhBi/AI+cQ6sXb/4nWqCO3pi5fPtjTZJqcY3c955OyZJz10J+c0+zU3zS1lnI2O5nsgnHgrRH/dwU25YHaJmH7yacAAxEu13yUYxjwoSE69zJu09gvsKwddSy5vfKeyau0XXpGF+1lLwE+gpgwOBXfgepJeft6CN1CFeLUHIQ6AHz7IVEXnN4iiJsTJRSGbeCLecAXIl+M4RPsKQvDmpii0r9pSQyPJLokOKlRcY/C3mjUkSH88MMv1N6YkgZ8/hOW0of3FUZe6P+VaMC/Ub6KuaXgqeyvfXZvD7jxYdJehZaN7e+8YS+BWXQCxeUCXL7R/Zbx5WQgmOjEJeYE7mA7zMRUZOlfws1w/MaHqOaSb0PQhjmV6NZcc6TFNYiZzwn0cD4JMimcYtYrc5y5+NRKvzZCCfulrbu8ESk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OE7YU7UPw9aDBhGME9cZ+chtsXdS8q/OBx/d9JapdNUOeazJKSRakm2iv4Zq?=
 =?us-ascii?Q?FPjaVSTyfB/MgZBgOgaLXx1UEDXj5p2Rop9u1q+UR0e4CwWmBn6xMIwY0SLz?=
 =?us-ascii?Q?DQE2GsUkHrh8nD6vINJelU6PrXcSZAa07GKdu2HDTctOg9pGafUZmNjwZtVn?=
 =?us-ascii?Q?aEZJnaDplBuzsjjhV0A6WShSelANLX5d2y6kKkF8ylII3bsnhjbTHN27uFzR?=
 =?us-ascii?Q?BiP7CtjOPtFzG6wEehiGzxrjQvUDVg23Pc4mMFAV4rftmm5zZ1XeAKEHv4St?=
 =?us-ascii?Q?rmMMGGiy1U/vlZDcPZCwQqqwqyfgghGHlifOZKHtIsYeN00Nx7YuO0TYZBnP?=
 =?us-ascii?Q?MB0nkFsdkfJvcEfTL8jgkrPpkEVZ6NAKsZF0QOhOvVqhwSS6ka0RfskGPNB7?=
 =?us-ascii?Q?tvhwN5EPOxdlu7mM83zcb1FJX22FCCVQ4F5/e1hocTwQdN3FFBq2w+HbmWOn?=
 =?us-ascii?Q?jT4negrR83efu83PQUUmHlSI4kphXCTD6qs5PH78nJpQsOjeEbyPT2gqghLv?=
 =?us-ascii?Q?MFZd00Y3sCVRZMQZ3eod9G263tdvnPZ16PUIpPyFklk8sjCiA2RhsfwMKKMJ?=
 =?us-ascii?Q?DnVySlo/kfGUqgZLSY6vCro9reVw+NHlMSJIwek4TiU9FJg3x9n4HSXFVFLf?=
 =?us-ascii?Q?DIPOtnknlJprO1Hg2kVnkUhZ4h6Q0lrYqDibfZZwFuNL/tu8DJso9cPCDCYz?=
 =?us-ascii?Q?X81GfQfyPEBRSNRRLJAKddS7pTxyP0S3DAGAPtm4VdEwLzqMPRNu0l/TdEoi?=
 =?us-ascii?Q?wxZNeh7nNFOpRXRZiBJeWS1tsgAnefbjUEAjb7cKXBJIU/iDGJVgtagTxsjp?=
 =?us-ascii?Q?DVD9SgPUKhwBijX2Uf2D6Ojf8Wkq3iHKOv0KGd/IMTWUeDmkfNoSRv8qfChS?=
 =?us-ascii?Q?YJtz7g+MKIlPGh9D8+9hx+MLbWVC27omyL18OniuJoiIizIjkm5lRhp7fPOC?=
 =?us-ascii?Q?2A0xzgFuknjF+VM3XP7nWnIvwZwUqYZcYAXp+e6ALKmg1LYuMSEDjro9OB4W?=
 =?us-ascii?Q?NdrjRcgJC0O6XJIQ9cfsDgfbgPot/wO+U1/1yEdnz3ddGr26bpzxtJBFvOD6?=
 =?us-ascii?Q?U9iLd8JAe64W4QSsLrL9W+HZuCuKyYmvcgRSTAhx7s7MltpeHql3jHsvO7cF?=
 =?us-ascii?Q?DaK/GGBoQShxrgmmOmbhCE7H5et7ODjIy2w4PQhnWtUHB0sCdJ97+5RvENFm?=
 =?us-ascii?Q?W+2jEsOuuJx3eOVswax4fn0YgPZkfWRAoGOcQeQ2U0kw9flF5R1vKxH1fz23?=
 =?us-ascii?Q?mlybFBpC6U36aBby/j5ttHsWeGfAUafvq/JWKiq8K4jwyXPI6dDB/hIqpDqb?=
 =?us-ascii?Q?5FxQIjfHIp6iwM2nWEGl2Ndn9jCP7t1K4vdW4Tn38Or7ysvFKd3eS1hh6WnB?=
 =?us-ascii?Q?9eqz5CAstVSYcQLK9ZyE3L9I+trWSoukIrzt9goUQRSrArwFtxKXXzOiJSuY?=
 =?us-ascii?Q?HzmKzm9phOvn3P06cDlYxQqyRKEAwVX1rkHUf8Ia4gYqHdahESfSEf6uY5gh?=
 =?us-ascii?Q?H99jb5OoJ+y57dT7sWo3km9olKQ1m6HLnhvTkhFpK+JDc+J3OOTxvdmKbeFn?=
 =?us-ascii?Q?xP3L6ElM77Lr6W0JnkvsL8QjAHLbBv1SK0tEuQnNQLiyd83KmAy+ZO3YQRHr?=
 =?us-ascii?Q?tpzU/M1g0zkgmsW0sSok2bIqVW9K0NxYfI0AuBIQniEeHun6HHyI0rvq2BOP?=
 =?us-ascii?Q?k2FJGwVA6Vg2S0H6qq+msYoJ0jOD4mXA6aJH+NK0AjGtkDNzqP9tGRopGf8X?=
 =?us-ascii?Q?ufvyXyQ/0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b43daf5-6961-422c-7357-08df340cfc60
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:30:49.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJEoAA3LARbB7dQZZIs1j2syivf9sd3YG2GgqSdzM01oDV+Qba4l5qHvwdmZjiZ5h1dJkMRwubKR2KoUhCDoDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

On Tue, Oct 27, 2026 at 02:30:31PM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 10/27/2026 12:13 PM, Andrea Righi wrote:
> >> On 10/27/2026 9:43 AM, Andrea Righi wrote:
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 36df9a4dde534..5064c7b707f4d 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
> >>>  
> >>>  	rcu_read_lock();
> >>>  	cur = rcu_dereference_all(dst_rq->curr);
> >>> +	/*
> >>> +	 * Never pick a task under a BPF scheduler as the swap partner: its
> >>> +	 * placement is left to that scheduler, see numa_migrate_preferred().
> >>> +	 * Moving the faulting task alone to the destination is still allowed.
> >>> +	 */
> >>>  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> >>> -		    !cur->mm))
> >>> +		    !cur->mm || task_on_scx(cur)))
> >>
> >> So if you are here, it must be from:
> >>
> >>   task_numa_migrate()
> >>     task_numa_find_cpu()
> >>       task_numa_compare()
> >>
> >> but task_on_scx(p) would skip this and it means a fair task is looking
> >> for a swap candidate when scx running in partial mode right?
> > 
> > Correct.
> > 
> >>
> >> At that point, it feels fair class should be well within its rights to
> >> call shots on the swap candidate even if it is an scx task.
> >>
> >> If scx has a ops.set_numa() defined, it would have accumulated hinting
> >> faults and the CPU it is running on is a wrong node anyways so the
> >> migration shouldn't be bad in grand scheme of things. If ops.set_numa()
> >> is not defined, then the scheduler doesn't care about NUMA placement
> >> and it should be okay for a fair task to acquire that CPU.
> > 
> > The fair task can still acquire that CPU: with cur = NULL,
> > task_numa_compare() can still pick the destination CPU for the fair task
> > alone, and once it's there it'll preempt the sched_ext task, since fair
> > wins over scx. What the check prevents is only the other half of the
> > swap, which is fair moving the scx task to the source CPU, overriding
> > the placement decided by the BPF scheduler (the idea is that fair should
> > be able to preempt scx, but not override scx's task placement).
> 
> I guess that is fair - if there is a better target, it should be
> preferred. 
> > And the fact that the scx task is not on its preferred node doesn't
> > necessarily mean that it's on the wrong node: the preferred node only
> > tracks memory locality, but the BPF scheduler may have placed the task
> > there on purpose for other reasons (e.g., close to a device, which is
> > one of the use cases that motivated this work), using the preferred node
> > only as a hint.
> 
> But is anyone running ext in partial mode expecting good performance
> without having moved a ton of tasks to ext beforehand?

Yeah, partial mode has always been a bit controversial, users of this
mode are mostly those that rely on fair-specific features (e.g., EAS)
but still want to experiment with sched_ext. And to make it work
effectively, the best approach is to statically partition the system, to
avoid mixing fair and ext tasks on the same CPUs.

In that scenario I think it's even more important to not let fair move
scx tasks around. Hopefully, once the ext class is able to provides all
the features that fair provides, we can stop supporting partial mode.

Thanks,
-Andrea
