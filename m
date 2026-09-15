Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163A499F18
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488337; cv=fail; b=o52tMz1GE3b6y3yMZ5dyghJQBGJezHcgcxzNUl3VeRs8LUWu8EULUSHZWNp66f8YkPx8cpLmKrXytz9dSZBQUXkIHu9CRST6bzKBjZ4Ne+C//Q+hcD8yaqQ/XgwTp10SFF1dLYPTrGbEmSfnFwfIp47bzIx8hjPGYNPmCvruq0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488337; c=relaxed/simple;
	bh=x1fe9LoInbjdaD2J76QJGiL6I1edzskmUmgLV78oISU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oG/ImBP2jBL33CT1PlCkWnHxQtgWosIw7r+OT9Uux0t6/TWHqXNLYboGYQiTmYMb1SOgwd4iz/r/phdZ6/6fBDDFJeHZ5UI20YjWiF3AJZg+f6DHrmsf4NkSSaLLYFmc7kHTY8NKXdGrqKww8OoRaru+O30+oOVFJ/H/1PcmDHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WiSwYeVL; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WiSwYeVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4kxpypr0Gm0KVxcH7H20ZDp/KhcpS0TldYiyNvl99hWijLcsGWVODgSQ94SMnLRs3J4gVypeK3/SxSzofrPySHtAjJO715JteyvF+LHGAudrKqy3d0rotqIEhV1edMPiW6U2hBNjy+VlDkuX19qxtLQsUr1i7jeV7dZZsk2fbYt1Wa33JqJLWvXwpCy/HWjYfUEKi7p0Gw/p1EUi3QFlfnYSCylyXbD9or2Q5V4WQ6hIfbVQxU+3dbv2hnxI56n0hM55UpMg4/7rKXmCnKSesPNo/xZWo8/EzQ9RZSmR2+8puMtoKc7u+s95I6QHs9DhOLALxs8UtjtxMIncV23GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD4pJIGSLyafi1ZiKe3AGfJSi9NqNoSc5WwZKBzNhhY=;
 b=bwQugOdORB73MbUpTRZnidDXejpY2H38sZHPH8eBli6YVY4QxwHNwdCN3RQkJgbTZmqwtcZi1ZCZvNpOyUjCpzWsuYDwd5l+N6aBvipSBHC8izaEaGiVV7kjbk3rA+scyecbIxarN914zVBGBHFHZxsA4CaG2FfnK8Eb/uQWTHunPj6WWlR9AYFBflsYxFriHPKKtW/xIKQULc7M+vtuovH9f4advDJfkmI6UVZHLkDqVtWAyDGp/+gyiZZxxYuTBsZiBoyHmATxq7I2KFnH0rnQCW6CfyrmBfSvo0wrIAFJKVvoZE3k6EQqqOj+3vzIPQfD05LNUWiT5tRFByv4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD4pJIGSLyafi1ZiKe3AGfJSi9NqNoSc5WwZKBzNhhY=;
 b=WiSwYeVL94ZPRHR4VuZCa0CTfULHumrOml1w5OFarLovKY6V0/YAR3PPiN2HQPFJ6LHQjwl/IvVsmIJ8wD0VmjH/HnaFgFf6OsSXCwOfp3cuGwFl/ViyA1baCXGHy5fjNb/9kxkIFC7OzA5VqyZuNIIxI65rUe54Pvk3NL4pmJfv3DpMSDwHsEFVvkuwi2MzWdgcbnE00IlABbH1UB7Og7MGNIruWKpNPbYHZ5DwZbaQUB8xDxPKWUnxq2tMJBN8KOolSdN7EcGp72D5j7j46zLx11wvhGBfDvQO2ynJUHE/wbRvv5VZdczvUy2SblcNm4cvmxaNe4+H/Jp4fM/pTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:05:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:05:18 +0000
Date: Tue, 15 Sep 2026 18:05:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] sched/core: Avoid false migration warning for
 proxy donors
Message-ID: <aqlstkw_QzFqe03A@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-5-arighi@nvidia.com>
 <20260910100652.GF4120091@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910100652.GF4120091@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI3PEPF00007544.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cf) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c1a069-4347-4ed9-4fd1-08df13432281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2298RTQg4cxeAihDkilD+0CCwLJb0DBZfCEheXCR5DuC0p1i53BBUCy68VbHh0GvdFRmj3ulnXbafD4XHoYRa7TyzbR2WpcyVKfuv5l8+7wLCaz4Gv+aFnBTlENd3E8un9zYkLmTTvEwPRNrR4KGpXAzJQQrtr/4WCr2GN991DFpeP5oYe/gU5o2QElynCCJGE188AKgMTFIepnYkXLRgpV+FAINDQtta9oqDJgt00yJQ1zfJItaRXh4Eg24N8DzJSIRZ4zJjTWHPFvRnTm67qoDDT2WHf0giWdv1kAsDIzIXcqNm2LdGaXheYW3n8WM3VwFXwlywWJ+YLsvjpaRBeCGgjhEElFfCNE5BHKEBONlzctX8EuQeGLtleCboDiGe8yaGgQV6wjii3jSwPLD3d9RITpUsgnL2DYQI+niyJk44yVjyFqhgmFHMxEKiGJTjtAPWxNMQ6XpRLfNcf8uq8gF0hD8ZnbkCCsi1k5axtsnoMywBCDuTxac1G3DSMZWX0NxmzFzWutQRkr0MT+05XyM1ZIIsspOxn4RzfL22saTFJOdz2DakH8Nu5T72R4qzO6ApSgooenJGdVTyhdpRZO6jV3+ZepHC4eUPsbRvQSdFiwtNv5jDft+CESDgcQd8R2rMbGE2V+Ws0bd25ooWLyVH0IKwmua/Mi7k2kR6HU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCHKi4R1++rIff+8v62WuZ0rpAkJMTMJo+p69pPSmgWEH/o1apP1u0BurwuD?=
 =?us-ascii?Q?M8fDnk1KlOFNMN0zDwST7AgrgEDv9OhpIFgJUkkEtjZ0BvSO0kplWS+hywxO?=
 =?us-ascii?Q?d6enooU5PlBhTMBa3J+dtJsHcjlkJtc751xbZoVJ+xeSq5YcdGYlB63hqdGy?=
 =?us-ascii?Q?93pYUb2K6uRah6UBD4jwts1biF+LgvPic29gmVPYI0gzyeiofLv71oNCgHMC?=
 =?us-ascii?Q?AmDNhpneRGqpsyL6LmDmElbVUsVcPPz+NfENsu+tNa7jyYI4soetx6+T9rTU?=
 =?us-ascii?Q?IMQpO+n0OJzuijXH5ywU4bykpIyG20/ewFdamesyif5Vl+Nh07WK8gVtedKX?=
 =?us-ascii?Q?4O+0SIo3KsaMUFEz7gL0iHy/DMKraW0garBj7D+miqeGtX5s0WSrPRY+p3Bn?=
 =?us-ascii?Q?Gel4O0TSzVGMx6EnpE7zPmBy4JlZL1lwg0EyS7YUnhNtSWnq5uEbBVBh/8ic?=
 =?us-ascii?Q?jC22k64SeIb34ewguN7uoci6CArZG1Gn4cabMX5diwEXgH+vQOLgUj/z0k8H?=
 =?us-ascii?Q?KM8ydPdo/EsVc/mfLZa0UMbXxEPeE9bOeFFPo3IiKtVUvHPipSbLEbXTKU9v?=
 =?us-ascii?Q?Jz2oBtDDw8HSBH1g1sIpsYoDsaXJlbiJPdexRHWmFkx3y7+shZG7QBYHcEcu?=
 =?us-ascii?Q?O1YbedB1P//coVH09gPjoOmzWELluc+cHoSYDSdjSM59D+k5HLym1IJJ+mT8?=
 =?us-ascii?Q?u2U66Qp7AAel/rRAv16caZopPHCdsFmUSmusZJ36Tn7Jh3hbeoYwuMjQHdoF?=
 =?us-ascii?Q?wkFg2OPemnyfYQZ7WzT3TLo10n5L1Yr2oeUqFE7ASELSknjsXyl+ca/tTdnO?=
 =?us-ascii?Q?yKhy5NeO/kHFhvFM1otkswBivpuhgapesKcGt1FT6x8nUai14Bwhg31cKdUw?=
 =?us-ascii?Q?8k/Mtp1GFN4oMT6Yw5RSAegsndBfbaft5Ou5DTv69b5M4ZsgBVWduA2zjS2l?=
 =?us-ascii?Q?DMtNGyxNUgjzMZMn3MF3s2s4RJ2KN6G5FjdKzDifKPR3RJHbZZFkqH7M4HHF?=
 =?us-ascii?Q?w19Ek7Nntg2ruX1MX5Z0sfVdVOZPiiSc3sRaYj8F3f8C8QyY1pk8awwX7T28?=
 =?us-ascii?Q?nOrOM+DkiFirN9M10zsrREuISr9w6Ac30nJ6u8xkGMPYH7D190i+4VjMGykc?=
 =?us-ascii?Q?8mv80LHQxkyqt0nwTmR646QPhkCnRe+qxhOCQl9biZL6ePpFhLBDy23/3q4M?=
 =?us-ascii?Q?q4Yb1RQpY/htt5OIMSbXBYOisTEuBhVz7bbS8Nb6aQ1xhfYi6g9VM/SuQ9LL?=
 =?us-ascii?Q?iokG55Wln+x15lpmQVem/ImPop7SfUfR8XI7NLsc7IB6SAFOlJW19t4m3Nee?=
 =?us-ascii?Q?LVXzUbSEntiSDGLaKNrYbzbXUr6PwwYVR0qMHl+OsytBlcPdZ9/MdVVzIG8N?=
 =?us-ascii?Q?lAFFR2aLEZTT9bW0wnZAyRCNvmYaiOArZwUiyeHNyGtoYVKo6+jqLgDvN4hn?=
 =?us-ascii?Q?s8PNncAo66qc2QRIt+rSByWRvSNH/gBSxUbKTCmC+CvLS9g2XFEyZcwMQXnA?=
 =?us-ascii?Q?4Ggsc1qrOKaA7HjBAy6vzqphmpoWR3thxQMXGaLNtiu+eVaWEtx2Pdz3Jg3c?=
 =?us-ascii?Q?8Oc7ouAI68ADVZDvT5/Iziz+F1kbeLfDGO7x17JkzMxkuA1f1hZfiAbwSj7H?=
 =?us-ascii?Q?XY4CiJeUyuYU4gsycoDEUVHRsqOsONoNI05A4FoFisAq8DQH/Ax2NPhxAlIM?=
 =?us-ascii?Q?mqIXY35bBc3G8whD/db/Erg7OfnMYOXR7WFNVLh8q3ol63kNaNKLud7ZvvG0?=
 =?us-ascii?Q?YCSaq8iUhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c1a069-4347-4ed9-4fd1-08df13432281
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:05:18.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTSccTMIi0utNm9iJbyHsceB0kQkLCxTdCd0IJxWa+KATd+8R7ORhXFV5vaXgPFeggyy09JZfMD5f87Pol8L2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

On Thu, Sep 10, 2026 at 12:06:52PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:14PM +0200, Andrea Righi wrote:
> > Proxy execution can move a blocked donor's scheduling context to the
> > lock owner's CPU even when the donor is migration-disabled. The donor
> > does not execute there, and its original execution CPU remains recorded
> > in wake_cpu.
> > 
> > set_task_cpu() warns unconditionally for migration-disabled tasks, so a
> > subsequent proxy migration or the wakeup path returning the donor home
> > triggers a false positive. Moving a blocked scheduling context does not
> > violate the migration-disabled execution context.
> > 
> > Exclude blocked proxy donors from the warning. The proxy wakeup path
> > restores an executable placement before clearing the blocked state.
> > 
> > This is a preparatory fix for enabling proxy execution together with
> > sched_ext.
> > 
> > Acked-by: John Stultz <jstultz@google.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 14d0d5c884393..0a2eabadfee02 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3351,6 +3351,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> >  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> >  {
> >  	unsigned int state = READ_ONCE(p->__state);
> > +	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
> > +			      task_cpu(p) != p->wake_cpu;
> >  
> >  	/*
> >  	 * We should never call set_task_cpu() on a blocked task,
> > @@ -3386,7 +3388,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> >  	 */
> >  	WARN_ON_ONCE(!cpu_online(new_cpu));
> >  
> > -	WARN_ON_ONCE(is_migration_disabled(p));
> > +	/*
> > +	 * Proxy execution can move a blocked task's scheduling context to any
> > +	 * CPU without moving its migration-disabled execution context. The
> > +	 * wakeup path will return the task to a CPU where it can execute.
> > +	 */
> > +	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
> >  
> >  	trace_sched_migrate_task(p, new_cpu);
> 
> I'm not sure why we're not hitting this upstream?

I think this can be hit upstream as well. I'll try to create a reproducer.

-Andrea
