Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6632F5A3D
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808806; cv=fail; b=N6MdrckcEyqeqR48HY8tvYDFZxU6FcrPqQw5BOTrK18MnjDxw/syXtVSVrgOOpxs6d27BKqc3icZCWeqfT2ovXtnuQz0E5EnaFGcs+dNmE1P7SRBohwfThmCVKla6ysyy5XPrasKtiwIq9ILA4A1teGWBloHLZJxiyclALqWAqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808806; c=relaxed/simple;
	bh=OejzDTh2XeUs2TM/gMNw2kZDoAJ7V65Vh2UoHgff5Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F4Usi9Ox7LZWwXVEo9JpNcoF52Y5rwidBFswW5SxnEQhLEEdjxI31ialZW43ZnhD5Ae1iIYh+yVLndOtzuwZuCx4ZbXrJWmloNk1GVgd7cy32/3x39P5DfdWUs0UARjTI6HF5XhoipVRFA9Y2m9H3AxyrOnXaBBJa3lnP7EhaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HrIxpZ+P; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HrIxpZ+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRoIbwzvbBRpOnws5GJH8CGoT0mmW3vWTJStUCEKdyJ9Sx1n+GP5YCAk7kGROOcmVbIiYkKIhbeZtrYgFM4D/LV1TKilVaKO87yElpwiL2q7qOXjVm0LJaN2662/zokFAoySGGN+QrAFQcWZ1OEzOh/8BirE/Bjsj+0MEv1cJWKsEERGGAudToQeChNjQmJSSxs2hhO6cPv4vpV89aF6v5yYUpKAxZ1zEK24t2NkuQTqBkpuVJy8FfFhPNF/f5yELP+WbxGf5/K0yOxKaYoz0VCahkhhf1jDUJPUBqUQ+FuuR57AU4LMsdnXTjPr5oH2EuXUCyxnt4b1lfE8aZOO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7iVZ1DWomWemeivLoaaQPL2XrO4ATQY7VFHGCnj1ys=;
 b=vpFIb8WQAwyd0IvdK/7HFePlVwwSZSV584q5yWLDC9k9dXLVF6uH8N52Q3L9GRgJhJ0acCfo662KOMocfbav70LcVshatfBC/xTsdBAxAO0F2GNStaASDcUyD9QhKxI8cDRPROS7UGnwfMGL2wJbdQ7crqzVjwBrM8pfSrnVWIlI/mXlE9bM6+qmXaCz10FnDtLl4IOuLtlNzahLYy8xLZ6Afn+GE9ecS7LE8WDFrs/hsR5GylO81SQ4C4Ip/aBmycv3G3i0dbflf7KbjTpuuXK5ZSY5agUJXc8ZfVvrgontS35PfmrQPT3HdohsEpik/ww+l15ARwK9XmF0LiOjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7iVZ1DWomWemeivLoaaQPL2XrO4ATQY7VFHGCnj1ys=;
 b=HrIxpZ+PGjx57IaF4Mgk30WWPd3dKi6p0RPGYlNIewG9jX4+JqBx9USZj1CMOy4e8zLMkTpVu5NVh2BSTXdPc4dZ3eN/gHu3WF6kppi1acTcnkuOh7qdyofftXbUCtLDY7qCWB+3LGRmIuTpzvsxxVFGmFFgz8JcOsannH81a0AYGeeDLAEHlA8wAbJyyhmb0AL29pZ2CGvg0jWPkk1LXIdSvYGh3E22lVUqFyoCXtcR8nyMFLWZBO+GZ/kdvHsv1P6oCNwgf2Vclrr9l8+QmZzgbZei9EJf2iWRXc0+cKvOqWOrpU2mfwF6XeCNhSyStSnUEdXsU9yyz/gquveHQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 21:06:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 21:06:37 +0000
Date: Mon, 10 Nov 2025 22:06:29 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] sched_ext: Add scx_cpu0 example scheduler
Message-ID: <aRJT1dbGTmPRw4-p@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-12-tj@kernel.org>
 <aRGkHhAWTWdWELAY@gpd4>
 <aRIyfJWJ6fcW5frO@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIyfJWJ6fcW5frO@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: c402d988-cfb6-418f-86d7-08de209d0977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/6KFzh8+Zrq5RLybFzi6l5ANKWC22ZfC/Vi8lk0KFD+T8+FIPsD2w6OuF7Z?=
 =?us-ascii?Q?B98TtfFIFgv1IAYmlPGSZcfw1somM9+rNMEjI0VM6SsyKy4yZvDipJ23nNr8?=
 =?us-ascii?Q?TgOlTboUKEzlXVbgDcjcq10v5fevKi8wQsk86aS6ibGMmaW7QY43cnXFN2gH?=
 =?us-ascii?Q?hMDZFvuxE+BkX/a3pFGc8wug0mTl6V02/hAXj+ATCj6YgzBl5n8WJsPxLR0r?=
 =?us-ascii?Q?5hIewbIuSMtwFm030/QaQMFXLf532u/3lL3Eir9l+dWs2vWCCdqyGeUIX84g?=
 =?us-ascii?Q?o76E7Kuh8gOvZNX9TNpx/nCl7t1br9KSzMGSdIWSMvq14PQJPxU2m0SULJPB?=
 =?us-ascii?Q?Ph+M2nm4aLv5zCvMWEWrG5lWr7HtYAb/SOHr0S1rmgdNEFKtQ5KATQBNdYvR?=
 =?us-ascii?Q?H7v2TwgWhueUq0JzsdsygP52cUvHmBiQIJI2EWB0ukjV8+YG8ibituU8M3D7?=
 =?us-ascii?Q?QHvBMAEEM+tVQ/jq0mEPJFZphIhc+DBtoFmu/WJe4VC21z6Uha8mB+NwcKIY?=
 =?us-ascii?Q?5pD8JveLXAUM5fxyiTtvZ7gQh70/Qy+ExNK+7/5DBBLZdE4+ZG3upjb5dCyD?=
 =?us-ascii?Q?GaSlhhhtz+Y7XjFwmvM2ihrEZzpAwYFfE1Oo1SRW2R2RLTsNwOfm6vmWgEoB?=
 =?us-ascii?Q?djYm9ZRjrIsj3Dgtbik7sbBMZYnLnHlnnDF/2pPxOrtYXvsuT3igSSZEq7BK?=
 =?us-ascii?Q?NX+9tti1B34antx7WUL40EQpebQ82Im+e9r0JRrXZophyjzkjtLDdH10+QsX?=
 =?us-ascii?Q?fYiICe2O6VYRuGF5dsUt+omGj2UgWxwx3muTIxU1udhvrYVY8cBhz0GQ6n20?=
 =?us-ascii?Q?ybpeqlmUVsJKVmPsdTtVxmLtNt8glB7OIlxCyinFXYO4t8xBCsQh0m6ITB6h?=
 =?us-ascii?Q?3GicWAIUd+hwES4bcKQdBzcG4cDi88jfjPy4JdiMFKzhortLJ023CZbspbRZ?=
 =?us-ascii?Q?mpdLx7fi4pY9cVox3DG+eb76xBffyuuP4cl+7PQT09f9AqyCLOu91gmhV6wv?=
 =?us-ascii?Q?GNTj/GfVSgu96AJiQgJH3+4MVDMr/A1rIXA36BggY8qQAZJpoleFDZENJA7Y?=
 =?us-ascii?Q?qucn9+/5e3sF+t3rx5WHf4AaM+sn5QCoK3XhyP+48Cmqj0pcX9AN2dVzoiQJ?=
 =?us-ascii?Q?rbQHOBl/+fNKwDX3U+VrcFIGYh9ykRQnwtsDitfaMAFUOc5i5fYyetjPDG+f?=
 =?us-ascii?Q?g6AuGIYcsE5eEij8OaWKGYaFByoY3ztkkGWyYKCD6OoJa3WThNrQFHh4TTSt?=
 =?us-ascii?Q?+F4C0mgr1Xkxi3AJ1SPMT7ctgSpBHQ0NV0fzP3td+Iza9L3kurbPKmG4t4Zd?=
 =?us-ascii?Q?ldtL3pmuge7QUhPk2Jt2fYJk4lQLXWbtV7wG7xqG/3z5HgANiGeos/l5QUzS?=
 =?us-ascii?Q?rW+kYzsFRZYhTL6sB5GxQz6wNsCkOrNc9ODylSaI9yEdwMxrDETZ8fn0TgDN?=
 =?us-ascii?Q?IoC5kPLBz0PyidjUsY8A+gRzGZ3ukwVD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHoKTgyL9zIECkE4ZsggcP/AiUmTy3UleOeDBZhM545GEVvdMT0vZi4WfreS?=
 =?us-ascii?Q?9mW7swbeL6sg4EPWVKehS1emnvciscjac8uzR46HkHsyk2XVv4cAe0+9l1yU?=
 =?us-ascii?Q?1ugrMhmqzSNl5ppFtTDmbCX5e2idPluw1Tmc/3jWUWw2J82GbCNRST8XZ3ec?=
 =?us-ascii?Q?0sicG6wgh6C19S3s3vahn8q0XAdEtV/RAIwd2NOTkTHIyFg37Z2Pxg6lvCO5?=
 =?us-ascii?Q?mNazCjMVSF38815QtW28zipZCF/zaIykOKVxmasYneuJfhE+zOiBs1FKRuTL?=
 =?us-ascii?Q?cMYcLM/48SFV9ELuvOg1kOfiw0HjnbkdfSF09j0OZlUKgy+Spt6EcNhUT7C+?=
 =?us-ascii?Q?2MqGtRu0Owaz53KSUIVVVpzYRbJ6LQUw0nrVwtTu0X505ZB5ORL0WAVoSIQf?=
 =?us-ascii?Q?rJ0+c0U3cxT3VRLquiIi7pNbVrvRlkDZbzm3bcAMto5qmwMrrSk1B1kj9G2V?=
 =?us-ascii?Q?YlgY5Go1bXpD5RcpE5jbziFsZ+g8Iph6IfUcjh0sYm9vT+9vDYW7OqzDB4wr?=
 =?us-ascii?Q?gufH2fmgzq0ZDNoIpwD3I+m07PGrpS16Rld/wnLEQQOslF55AwnQ6518sjip?=
 =?us-ascii?Q?XBFuzukFZZCeeSgIdyjznAmZ1Mjq723J6XvB9DlgRZKKdNR63xDIv/SDaUaG?=
 =?us-ascii?Q?WUR2j3V4+4oHlQaZzCJ102+mS/n3yMUcMBIsk08iorECARQx9Dar5JRAKXUR?=
 =?us-ascii?Q?GfEbA2Rmrln6FgpO0RPzrOeqgkEQ/o65E/fKaFybGohJdmLeROA/4O03B5AX?=
 =?us-ascii?Q?guIg5cdZcP5It+jEFXJm7Yhd/n1t9trh7wSInfYGJC9kvhpmiVvvE32M2VbE?=
 =?us-ascii?Q?3agY3a9NxBHj/l++9x5w8rtjvIUfvCBAxkRhg208HHYH7YJbD83eUUjLPIoR?=
 =?us-ascii?Q?gDwtOflgxGAmItXbVsnK+T18JaNjYF8zXlxBiXwiwvFVb8zSyktjvRs9konF?=
 =?us-ascii?Q?3qgTgnhJhlNv3xND6Qjald1YkRgDUCQvvkxDi6Wbzp9h2LO5tdRc9qiQOZwW?=
 =?us-ascii?Q?3j+SOv+fOMZfK6yyeo02B5DWqrDg/Kmw5kpxhtotCid9ILVb3POK2ynabZDZ?=
 =?us-ascii?Q?l2fQqyPCSFSHmR46GlSmd6QEsZB1kkieYcFwVQ4iojP0EXe8gUjkqBIHt/zN?=
 =?us-ascii?Q?LHMAIinFiQcswoOrTTjyrLgfDOX7unIlytzgT49gcUec6iRv5VaqDdf+fDrt?=
 =?us-ascii?Q?DJPBtM5Q0SY6NfjrYsuJwgqpJdxH6tfPtxqHfrzsYOdogfxnWK+zGjuASJDE?=
 =?us-ascii?Q?YjxwcRi1e+IogwUZbrahvozkTbAY9hSyA49VWF+PSP+Sbw4BCoNqv08eIASE?=
 =?us-ascii?Q?uCbz9rMrJglur5qy9jKAwOaxd6jaPudnZafVWUqhp4FQEMuvSucimbgjgLEm?=
 =?us-ascii?Q?CpfXFAGOiFpPgmmW4auQU6CiM6BypDm9cDt4iMjaQWy4VzUZ6t5PQ0uWL236?=
 =?us-ascii?Q?Ec2mKsV2UiYqmzkek5Sy6kKFizXDHJ68bk1TTVAGp3syOM5A141BQ69iinoe?=
 =?us-ascii?Q?UlLQIn2toDg1rClk15PvV1Eem2r86PxRI0Q1CQ4z7VF3SD4mI85dKEhV3tVs?=
 =?us-ascii?Q?f9GgUt+yVv/Ef2uQkuqeIZ3QGuAByy6i22Mtdlqd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c402d988-cfb6-418f-86d7-08de209d0977
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 21:06:37.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls1GAsg2kJEueBbshaxEtE0YWFNGD9TMwLyV15Y9SE9CQAI5+vTH5gDEJiQFSwsfBuPOtKvTy8FVUzFVlQTBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066

On Mon, Nov 10, 2025 at 08:44:12AM -1000, Tejun Heo wrote:
> On Mon, Nov 10, 2025 at 09:36:46AM +0100, Andrea Righi wrote:
> > > +void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
> > > +{
> > > +	if (p->nr_cpus_allowed < nr_cpus) {
> > 
> > We could be even more aggressive with DSQ_CPU0 and check
> > bpf_cpumask_test_cpu(0, p->cpus_ptr), but this is fine as well.
> 
> I did the following instead:
> 
>   void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
>   {
>           /*
>            * select_cpu() always picks CPU0. If @p is not on CPU0, it can't run on
>            * CPU 0. Queue on whichever CPU it's currently only.
>            */
>           if (scx_bpf_task_cpu(p) != 0) {
>                   stat_inc(0);	/* count local queueing */
>                   scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
>                   return;
>           }
> 
>           stat_inc(1);	/* count cpu0 queueing */
>           scx_bpf_dsq_insert(p, DSQ_CPU0, SCX_SLICE_DFL, enq_flags);
>   }
> 
> This should be safe against migration disabled tasks and so on.

Looks good.

> 
> > > +		stat_inc(0);	/* count local queueing */
> > > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> > 
> > And this is why I was suggesting to automatically fallback to the new
> > global default time slice internally. In this case do we want to preserve
> > the old 20ms default or automatically switch to the new one?
> 
> Maybe SCX_SLICE_DFL can become runtime loaded const volatile but anyone
> who's using it is just saying "I don't care". As long as it's not something
> that breaks the system left and right, does it matter what exact value it
> is?

I agree that if a scheduler uses SCX_SLICE_DFL it shouldn't care too much
about the exact value.

My concern was more about those schedulers that are quite paranoid about
latency and even if something isn't handled properly (directly dispatching
to a wrong CPU, a task being rescheduled internally, etc.), we'd still have
a guarantee that a task's time slice can't exceed a known upper bound. But
this could be managed by being able to set a default time slice (somehow)
and it can be addressed separately.

So yeah, in this case the exact value of SCX_SLICE_DFL doesn't really
matter probably.

-Andrea
