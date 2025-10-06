Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAA225414
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771365; cv=fail; b=NK8uppqhPSTaKeyAuPBUB4d6FAxxyD7/NEJa94UjjR7AHZQtep+qEXujk1Sat+LRD5T1gyDg4z6DKrNO4HYCb6A2Udqt8FDSAW8tRuERHYqxQRo9bEX+PBqUFfY6WZ1a9n/tgNH/q9lIABB+tVIrfq5D5ZMbIn5ildZczgLcMkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771365; c=relaxed/simple;
	bh=CyzlJzQeNKRuXLAwxv0R3/JF38ObiR+Mj5gC45xQm8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MTVHW0Xfs5bum4++2EPtG+LbZExhFCX9D1Q+a6n64eBH30rFjbq4gfYDEeGQx0Lkm0BcN4d+op8dW+Q/x6jM66vZUNoBben8PNonY511SrIGfUysXgY3npK+in3IASyxSP+lvRBjq8qE/mbea0U7waQUPeJEZSEZTWwVDwiErF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSfLYsp9; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSfLYsp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzI/c90/t+1Ep6BgWRb++D6DnSXpyos5YFHpSsNOkoHyLwvZBzR7cdesT2ULzZh8kvlBF4PrduFThvYyonIAnhqq/dQ7/+DxMyACtVUp8B3jKqVjlYtPkADB0EYBAPC6CueTg8WxOQiwds5Gac7lIQEIzXoQGojo8fhTsTCJbEWT5Bdtex6Ufo9lG2lfVTtVZZume5axs4t0AtM43BUWBDKf1YA5eluOO6vJggtWncptu16vc4C71yL0wS0ZF0L4OaR38k2wv9YnCZDJuet4/7GQW26Zsz5wk/PS8UwVaRaMDLk4hO4CSfuQKZBEO5hvoZfoItvhJAsnaHjCdhfV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chRXifS6PL0Zj5UjHQHqoec4XZha52JRABraogyGliY=;
 b=sT2d4ukKRTHDajuc+qcm1g9L6GNnA4513GLaLW4MjG4bd7ButCxpOZW8Uha3OW9PJ12J9VHUmOJytO6RTd8bx0Ys2/AymqNAzIZ2S67517EULy5Bz311X/Bj0MFlcJjZc0tCPzz/Xo6zIBTzK2+uBoTh2ZsyQBXM/RiLRYZgt0o7BMY7KMKk6nvbnjgszWb8y7KWAw06GVdcLs5pu0C1Ujor5WbdSZPn6e7XJTj3FMDpuQHSVdP/cywQk89aiVHkyn7KHfxvrzkyNbZe1TuOnCyUqNWUO6+SRAyFZa39FLT80MIgI6TUIVeNOCuLSFQR7KbNeEzddM8pIu2trWW1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chRXifS6PL0Zj5UjHQHqoec4XZha52JRABraogyGliY=;
 b=uSfLYsp9NxyAGDrAIZKC5RvjTC3Vto5sttVtZrrp+MwZzfn3UVpattv/yuKCxt4CYthRQrb5BARg4xBrU0d9g1ieF9GfLIc4PuEWHqWKTJZpe6THIOSVRmJ9Z74xDVRUQpZBwnDKUd0VcgQ0OSZ+gMLkMqU6oK6FCc/ADLVhwR75+HRljFEzoQ7P8Kh+9ygGr/lqjUyxZvIDEx2xjbFRQnnBKHKjgXB/bxzD1qglOgYjgAx86AFla9jXxZj2/W4qkZdERg175QZ5ZS3YHbwhiixCMsMx+Kv2OHXMhZWARD+HekryoE8UgUV4tU4ngpAkmFsYSk4b48Y5AXWxJPtFUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 17:22:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 17:22:38 +0000
Date: Mon, 6 Oct 2025 19:22:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, tj@kernel.org, newton@meta.com
Subject: Re: [PATCH v3 2/2] sched_ext: Add a selftest for scx_bpf_dsq_peek
Message-ID: <aOP60Wz6qBAYFmid@gpd4>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
 <20251006170403.3584204-3-rrnewton@gmail.com>
 <54151879-f2bd-4e87-b5b5-5e916ee1e743@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54151879-f2bd-4e87-b5b5-5e916ee1e743@arm.com>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: fa237762-9163-4f8b-a7f6-08de04fcf2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mPtO+3Vd/Evo67eBl/glpWRm8RzEPXWaJZ5ii7v5PvCoDsGNZfjUO0fL8fDi?=
 =?us-ascii?Q?smx4pcxO+B6hC7yyOhEOQQZ5KPN72M2ou/UTpEfVhE+LKJ0KFN61/rqnwaUN?=
 =?us-ascii?Q?AzV9nqL6N8y+tD3T5u07YrQUvV/UDMa0owR12N6IrUlWoyBrCybuNsLbB0t0?=
 =?us-ascii?Q?Dw1VAl4tIGCbC/TtKltXPWUYCM9LbT5JHGwXIh9/hMK0jqGFjdtwLDJ2hLNY?=
 =?us-ascii?Q?LsFh9koHwtLkN/VSe8/T1Z1TQsiOhdpj5UIYWIiaaSkKGiwNRp0+xUcq2AcC?=
 =?us-ascii?Q?dnlI5Xcy7HaQPqm3K3qKizKwD7vdQsyciV78YwEtWBYZI4wdtlAd7gp85Fer?=
 =?us-ascii?Q?80LaCy2cHMkjrSwIHW3k6UFPyLxw4/JZHDHvXo9XhrUN4NIN2/zwcK9/Lmbv?=
 =?us-ascii?Q?qyyL75a4/Ki6ngL64XcDaXg+MBnpKOfthygAr2DgXLbqDV2HuOEahenVfkyI?=
 =?us-ascii?Q?9Fwidbmp2TV5uEMf/0LKbn3qhmQxqfkKtsrqyEv8frDk45PepqGQOi8/BWTd?=
 =?us-ascii?Q?nUzXFU6trXi7WPMmS/QyKPkC7OGPyEWODskURJnjy0RbTXmQ/4Kw2LGxtCuk?=
 =?us-ascii?Q?Z+9yKc/2KqlheZP0dSVT81I0+zwxO0jf6e5uxG5uJ3AmADGFzkUTxC1WoZgM?=
 =?us-ascii?Q?mlYLeQNqjeCDsk1wuDXq81X8+O7m78h6U5yE0TzLtw75KT42CgaSE4nL+iNa?=
 =?us-ascii?Q?6lUpqELEK5KWcWztUxKT0AoL6qp8/f2+buBTSH270eeYSZ3g5pp3KAcE+TgF?=
 =?us-ascii?Q?mGEP5ff6gBCG3WAuShoe7KRxLFbQJq+Unr1Lj+CtaNYMeOLdAAa3mat8c3h2?=
 =?us-ascii?Q?hPIUBj+E9bnRodWfExAJXJzSaglffBndgOqT34KxnFcikR6c+zUDGibfXjT1?=
 =?us-ascii?Q?UBa01Iuys4Z+mtUlMogh8ACVoFfE/S4YbJ31iqBMhpeaU+yQs0v9n5Uhq67w?=
 =?us-ascii?Q?jT/tgTk03aNR99aqvsxSXi4iC2r3ItjuBXy2VZqGw81bQzr+vL/rHE2rmk5e?=
 =?us-ascii?Q?a4QMznTjUp4qwuJOfviAbqrKIvJFVjhhw2nseVIvDRcs2SAycq+lZaiiTfGm?=
 =?us-ascii?Q?nE5xQNOWAP72Uy8gaLAGQ90fa4nVUaZJUVtdxCJo//bluURfVcjVcqr1otb9?=
 =?us-ascii?Q?KmHmAnW8yQQS7uO86L08tHqobAOOzUcBk2AZouh1q3tMEkCiLKYGbcHjFksR?=
 =?us-ascii?Q?vZlJeUtb04VAbQoF0fwIpknBtTyK3xPc8OesWZTFLPHZCaTeqEbiNPu7vSQy?=
 =?us-ascii?Q?/ukPwvgbFedHJZvrfoIYFtifGuqz9gTDUmlwWudh4VgyxAWt8YIU8oyyIAt1?=
 =?us-ascii?Q?xqHEJKGtyzLDVcQw5yWKD8srFMscvI5QCeLfGdrSU54ayWAkpCRr4B10VyIV?=
 =?us-ascii?Q?56TAQ8w+HpnnbaScJtfgIcOahckhxeWuFLCgradOWEkhiyVOdxfLYtVy7M29?=
 =?us-ascii?Q?V4JgwWM1yudw5j3DypARROskPAh3KdN9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDuJXKHDdhyF5KZeY0f1usJGbD77oVWD4DQWHqt/MMqp9Lmbh90c5dfDXUSK?=
 =?us-ascii?Q?QkLKixSEFQx0Ej2ie851GMvNP7Y54pov4J+5YkhyrjuD/9aRuhEiiohi/D2T?=
 =?us-ascii?Q?296WgjSIze8qw0L+tePm7EMcusSoRO8z9FHKEurzPNqiEh38Y+K5sB/ib6oj?=
 =?us-ascii?Q?JSilaxd0o7OBDp2AS6DG3gBc0T+Sx0HL0WVXe0Xo6krwAcd5BxGPijV3VTT7?=
 =?us-ascii?Q?O1EOUkgLwYnuZ7eFMJPvdPLdJ8WnUuuYSNujjK5i8cgpjhfQR5Y9PEuRlnXm?=
 =?us-ascii?Q?4O3X5Sr4WSNMbl48mr0b8oeIz9E6KiBnehMFNuYX9RIavABw7L6+gVdfMqs3?=
 =?us-ascii?Q?sUEdu84Cz3CCt1+iAbIJSPuJkE8YYN/xw/tFGi9ixmOhbzPRXT5/VQ79pXA2?=
 =?us-ascii?Q?jLqsiizSPA/iFgNrgym2PUOhafQeTGArmICQEJFx8YqlJIMyARmFGxgp6tdK?=
 =?us-ascii?Q?E5aHBH9sQZyhLiAliLtQJiOXIrG1CJ784CqllSNRhyxVYgf3i0R/VdSkDdpH?=
 =?us-ascii?Q?WWMxRshTKdrL6qZQsFSbFYUZDmn6L6udJsciUWZAOhsY2U8J9v6zi3gA+Gsu?=
 =?us-ascii?Q?KnZZ2jYeCNNeZgqUvC+bnAQGp5awVxA2Bg4o0tQwqrobMyHVMBPv2sw6gjNQ?=
 =?us-ascii?Q?gAcBvJ0ir+8kiuw2j+vK/laZr9zgHy2gpz0zm20VD/z0ZFjVmvnMxixlyFCX?=
 =?us-ascii?Q?+Yw6Exc6hgfXNbbjNMiQcX4tm/8jVNO6pYTi9v7OIEpozcXsGODNpqnC85iJ?=
 =?us-ascii?Q?d2b2LI1TJGidHa5X9fvLEPYeoy816rBZpCBMJbvTcbXWOF1ARmY2aXMsy7YG?=
 =?us-ascii?Q?8gbVJid90PtfMHud4Z+v+k+I8dfQiEygnMksWG/Qcnf1d/xfbL/4BVPA377A?=
 =?us-ascii?Q?DSgFBvN//o5gTE5s8VI8yX3QWaHAcYbf5wR0eDqBW/fObmZKw04zYdIRAE2x?=
 =?us-ascii?Q?6ylT2q84ep2nIrkZEJo435oqZpakDFTsYe3nX+65jy2I6oriG3AVe9IoS/8f?=
 =?us-ascii?Q?48T1rZ6fMXVbF0V0KWQmz/9wnBjs+CunhtLS5D5dgOYAzD94E+Fb4eeBJXN6?=
 =?us-ascii?Q?6avsntMGI/tbcXiSTNL4GlqMt2DF4K5h3WMGvnQ2pcYhNj/asNob28sxrPGe?=
 =?us-ascii?Q?2fIA6TMlcHzO24nsNtsHOZVOkvkuTn1THt3NZ2LVrQiHK2UGoApPlCSm1e+4?=
 =?us-ascii?Q?AqpV96CWxq23kgZxtVD9CYye+Zv/I0CcdzjIKIQXIkqZiRO0xWo0Qj6SMVCs?=
 =?us-ascii?Q?NiESiQSXKqVGjhafLXF0oa8DKwP/2psfbmQAZe/Klw+kE+49skvTg0p7ZbSc?=
 =?us-ascii?Q?BiDDFpJ7SGDkzlvMqVM90vn1Q8z79qb7m12+8Kpgya0bSkUaKwGdUL/ALURT?=
 =?us-ascii?Q?RqOeYdgAeHdM+TUSUj3BzkOTPHAFPcUCOZaqyB8RHAeZ5pyVrq9wEcP/jktA?=
 =?us-ascii?Q?L6/aqlSdy0m7alx8ulkpymf+h5+sQHAEFb2te8YZEymcxp5jHaPg4/jb5jhM?=
 =?us-ascii?Q?rb4LqICQpzEkh+37uKQqaVrSPvbNhxA2mWP5qzJ6S4sDgDz9mjI26JVVoniJ?=
 =?us-ascii?Q?ToAUBzUt0LVJKYabg55l0PyjODZ1UYZPkGLZRCkz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa237762-9163-4f8b-a7f6-08de04fcf2b4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 17:22:38.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAsxu0qR0dYMVOFUwG2DVy1QVqAW0ryogY8v6TjEfRA5esSmx1YrlLlNDhFcK2Jk/zvBxUjvLactVhlwQM+y1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228

On Mon, Oct 06, 2025 at 06:17:50PM +0100, Christian Loehle wrote:
> On 10/6/25 18:04, Ryan Newton wrote:
> > From: Ryan Newton <newton@meta.com>
> > 
> > Perform the most basic unit test: make sure an empty queue peeks as
> > empty, and when we put one element in the queue, make sure peek returns
> > that element.
> > 
> > However, even this simple test is a little complicated by the different
> > behavior of scx_bpf_dsq_insert in different calling contexts:
> >  - insert is for direct dispatch in enqueue
> >  - insert is delayed when called from select_cpu
> > 
> > In this case we split the insert and the peek that verifies the
> > result between enqueue/dispatch. As a second phase, we stress test by
> > performing many peeks on an array of user DSQs.
> > 
> > Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
> > empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
> > the buffered insert. Unfortunately, this is not viable within the
> > enqueue path, as it attempts a voluntary context switch within an RCU
> > read-side critical section.
> > 
> > Signed-off-by: Ryan Newton <newton@meta.com>
> > ---
> >  kernel/sched/ext.c                            |   2 +
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
> >  tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
> >  4 files changed, 498 insertions(+)
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 6d3537e65001..ec7e791cd4c8 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -6120,6 +6120,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> >  	sch = rcu_dereference(scx_root);
> >  	if (unlikely(!sch))
> >  		return NULL;
> > +
> 
> Accidental whitespace

Yeah, this should go in the previous patch.

> 
> >  	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
> >  		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
> >  		return NULL;
> > @@ -6130,6 +6131,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> >  		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
> >  		return NULL;
> >  	}
> > +
> 
> Accidental whitespace

Ditto.

> 
> >  	return rcu_dereference(dsq->first_task);
> >  }
> >  [snip]

Thanks,
-Andrea
