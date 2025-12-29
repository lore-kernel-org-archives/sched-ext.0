Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102C32ED29
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024692; cv=fail; b=pLCc2wwETwbpSpONn+B6En7+pFMxBGFzIKnEB7ikIuZQhAgV/+O9hQmuOeYvzivktCkwAk1dBsZpBH7jbXlJD+w6ye+aGax9NlR8825J2V0Rr6abkxc98GCeYGrsXjuvri1AwGcZAggQWvE+VcEd2RJRFXDaPm3aC9Aqboqn1O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024692; c=relaxed/simple;
	bh=bzcrjI2Kh0HbINcSJFeLDCmgH0Yef/qZFCoRtzTlA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4+FBnWx7iNmJgDmcJkcwhnCwI7UeIT+tgUKN9MjbP/hYQLweEU4meiVkRBEqjZzCHGH9agd2FB7ZIcfmRdVU5wYBv6895+7h9i/ld1T8U89kOVW5Y1SSmJ0pd9Gay/D87laxQOfc+y4dlc+0Ex/WYOGT94flTcXobQI8s6Y1LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i7PPR/k2; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i7PPR/k2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlSoCJIZrfXmt7yr94Epnm97zh96G52f374SJ6C/mSmuCztwM/b6KRHx759QexezNrblO7JluGf368SCoap7Eq5n192Qf3ebxdwtdSJdYVRylGgdN10WhiaItetxiGMlnjzhV8BYC4JwQABLz6AIKAmUHuRYUhpSBSc7NeANDRETB2H5fqPCDwCCo7FL4+W393dNuyKiw691KKXTUSXGACWH/G1gNzTut8n/s4aRgnBGez9/tO5Oe+3f/Vx7wIg33FdTbzOgMTqW49SlKbzfSxhLWjGtBwuSFaaxApgY9aVSXlXQtLebD7J2Ta1eMNeKCQvxGPK6rqXWnb6vXoCQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ltCucFwL48oCPPLoMMP3Vh5XSdg3VnUdYRt8JzicU0=;
 b=NZ8G3cBal4skUyzn5aLJdoFrPhS2ogkSuWQYRnBPA/7MsSvLyhQN2Nla35asoehp44ZucacaFlz88eds487GxT/ATsA4VXeTW9rNvdNv9qYm7C9q8avWytX1kXymKDTWxONgRAG6cn1Nw7d8HN/XybvXVpvgnLiMoxAS8cYL+T8c3J3Qe+3UUMyUyuwkGaQ5/VaXlgfAsQfcNYu2TiCn17gH7a3h+es3fwq940T2q/EE0HFYsWmW0wffULJMuoGHGW8jMKNjR44HYTg4uZHvmr9buitoen0DYdHzwMGtSiQDc1fcN8s7pBv44Xl8W5K+jggDRHwk9S8P0vfW3wihTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ltCucFwL48oCPPLoMMP3Vh5XSdg3VnUdYRt8JzicU0=;
 b=i7PPR/k2iRpjeLOfD9LfOLykwPp/5sTn72llFMmgr3i6zdcPB/C0L0/1ve9GYVmVo0Qe6oYqgwhBFcrG5lSyKfPo/WBznbR9mkSCUdDazdxFyS7bi14f/S5r8Z4JdsQ7DYXbWn3e3mvILp3I99h4dLI2fAsdjQ0FCs8uyoRBOB2zR+Z+3VrMct8VF9cqGviEqWZGrfu4LlIdRDxdDoE8k7QMROx3X/oFW63hSoKccinSkY6YK+4mVL0YUOxVScZ8+GJZluVCKVwmUDCsGnzjywQguaGts/dhKdcPZn+asZhYjt9LHmDuudxD+F9OP0CXSXWGcb7CPUDUjeJNmvim2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:11:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:11:19 +0000
Date: Mon, 29 Dec 2025 17:11:09 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue()
Message-ID: <aVKoHUp9KblXVEo2@gpd4>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-3-arighi@nvidia.com>
 <DF9J45056GT3.9VDAT91SZW7T@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF9J45056GT3.9VDAT91SZW7T@etsalapatis.com>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8d31a0-ca51-4f41-2d6d-08de46f4e666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpUBTNosi/Pwqi3bZK8Ycoyuiza50MCjZuqENi/1cW2d/EfOtUehs582LPD/?=
 =?us-ascii?Q?fsSO0dXKHCho9tLz7LqJ5/dF5Xs1eLPf5UwiK+YksdyssWPX9KGBzMIGjD88?=
 =?us-ascii?Q?07ZicZSmvhsOhA0097efhzQ7BNiTSSd1ih65p/bRffx9axF9BeUXmo0NaZt8?=
 =?us-ascii?Q?qGYAkHgIKbqxgUqDl6p9YA9PB6Omve0NDbFjXU4TopxVSK0sbA7sY4osiocy?=
 =?us-ascii?Q?NTIbOUWYroPvgjICprJuzrjjmC5EA7vwP3helPFCQPZbTal0xjutXScplloX?=
 =?us-ascii?Q?SSKwDMmmE7/dttyprEQnGknDVRPWOK9YmwH3PXBbMKCz6igC9zl4s9KnBasb?=
 =?us-ascii?Q?s6ZAOr1R1jNQdub5JnkV9IOHy4+Wabh+Rs4qfdwVzIdzdvkuHl0vD/+xayqA?=
 =?us-ascii?Q?5lfa6bndw8Lq/qIxXCGaLzwBWikYBSV2RxxHGp1kKJNCLZ7BqhMtMlrMgSXO?=
 =?us-ascii?Q?gbIwdcEdHVQiMagSL37gwST0gqitwTzOGOEawFFzNrDGpzBVYeNgFPG/Ywia?=
 =?us-ascii?Q?i++QQd6yFpaQKnP6rb/0K5Mgdvdwojme4ztp2ryPNP3zS8T7+ITBxlrmy8u0?=
 =?us-ascii?Q?9YcYIi4UCXD45Xb8zWyUG0Lmimen/XAVx+8d6Jhkge4FadFAxnwgy88LaoOE?=
 =?us-ascii?Q?JeA3MDUqbM9VBH3/iJy+vhqetbeUipdl9xZomaT3Y9xBDQ5UXtCvSmQcgVNS?=
 =?us-ascii?Q?JS1391WesKclTjKCC242hdMmGrHbXJ88oTTmeTV5rKbDKJlqcZI1fqTFCSUQ?=
 =?us-ascii?Q?gcpsvYnxRkIwrXVOCLq5EMA5bHRgWlZ2bQEPLGfzMiIvUm9IQn8R7LwodN85?=
 =?us-ascii?Q?PS30XRU2PyfdHxzkvRRp5Sw0rEnHPBaKy9vzve0mHmwBHIe4Fsd8ilmVfpPn?=
 =?us-ascii?Q?TO1KSO2zMywAWsLkz+ZHd1OrC1+fv7pIoWwUXoCEybA69LZpcq+DrbLmGOn7?=
 =?us-ascii?Q?vgY+ScgkkeGieYTME7ZlY6amnnyn65/xMGpxRGSVkZe7wJO7GjkgQmBgvKAh?=
 =?us-ascii?Q?ClzOJhgbN7Mk5+r08EK+i05Qjz19S8JY8GwJXrrZCiUEXiRystL1kofUvr8P?=
 =?us-ascii?Q?5w7xU0q57rjhmweIol/sib1NMUudiPO2KXoik6wv92RCj+5vh8PYRZuErKGv?=
 =?us-ascii?Q?B6QhBhDFe25YmSXQJjxVlf9cZOIWulCtSwEkKU1BwcKRVr1mXSOnfVVVb3om?=
 =?us-ascii?Q?+Kmjd7bNnmX/qqfuXr7tJipeeJ2TORS6+ZXTQXxBmcxONxUaP9vnmuN7/5xJ?=
 =?us-ascii?Q?M0QQil4ps6fw1cHrTW4m20X/9t3KFTyORu+TFd9J52FI1l+c614Mf/DGPg5E?=
 =?us-ascii?Q?AMgDTX99jqoQIIUL57EuhoZjmQUbRMFTcWy3zQz5ccHk70DB/LrSrzHIXmO4?=
 =?us-ascii?Q?FicZUStNYx3Fl9cT8M7J1TuJWUXW6myOvXgyug8VkpD4ssNMDWP6mgBRQoip?=
 =?us-ascii?Q?uOKBdwuCN88kKRwsapIHqrGZaZwOnKPv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7y9qh7oF+Kq5dj/Se4TuLdansy5W9p899I4baqCUVkAeksFP3KtMk4LYSyxq?=
 =?us-ascii?Q?qFw7cKD/VErWlgc+8ilBxBVznP1muMArHNahb1K4FsvtuAjFPmbSykbrUNNT?=
 =?us-ascii?Q?MIsncjl8+CCxQqE30i4cCHpvh8KABIt+4EVAwTxXImi9MS4qUSUU7NlyOIvn?=
 =?us-ascii?Q?FPssAPMkFeWmUanpk0FCejhinhvdN/2qSJF4QBOatOm+QhEFWCxrOTqgpns4?=
 =?us-ascii?Q?tJLWWl3HxqpJLT5Ut5jY+MO7xBcSOGd+Z3A31BwjA0OhZQXfOGv2sm3u7gzk?=
 =?us-ascii?Q?YKPb3OuxV9cdfK3qOgpy5luNiONktLiXJMsTBNs8gG20zhb3oRUbEW1mJtBd?=
 =?us-ascii?Q?VwCft39JlTXZQqQeFBkeZ/cXUXGlJAyqcuZc/penH+lQgYcapYxYjFbH8CvR?=
 =?us-ascii?Q?u1fJ4YvteEl4mtBDrTokS6Jen5qfLnc75sNxU3zbdbwu+707mwsPWglEYOXz?=
 =?us-ascii?Q?Gi9TJtIpRSSpu7d/3fFL5M64jZNv43T6fphFXNNFyGDdPcjL0nB2NKmKQgNe?=
 =?us-ascii?Q?KkL9qnPWblwOJ0vBsqSXLTl1HTz8cvcffmH5G0B20Nt5IjUNL592VQiIBcJW?=
 =?us-ascii?Q?5JBdcRnZLhPzcOUB1Lt9MR5apkE7i4yHw7qfKbD24YK68K3/hzFG/OwYsSfZ?=
 =?us-ascii?Q?fBiw14Ot+CyD0/unqgRak4A4yFkUcp+RmO5D5LVARkznwkGZEZ0BoTO3cJgO?=
 =?us-ascii?Q?eDqaeHKDdVtlck7i77uPfsQ9tzjafePOXBUNCVE2YY2OPTZRfJxWFl5IjoyA?=
 =?us-ascii?Q?oWjz+/OjJ4Yy75PThnENL7pgmIxkKfnpldyDvm54GGVQOpNxsr7p8aMvCOgv?=
 =?us-ascii?Q?PP4ig575Ahdll+4ban56WMA/J3zjOuqt8kpnbbRje1ui3sCxKTl/oroRjV49?=
 =?us-ascii?Q?LIhwSeZARy4FzDdviI35+hFbH9RBHlXd4TIdTwuBs4vCvWrUUo6sf9qmLzKG?=
 =?us-ascii?Q?kZbw8kjFQXj2tz3kdUqaBRLpDPBn9eNyuOIH3O26iYO5/3XtU1aycA9MOW3W?=
 =?us-ascii?Q?eTGy6i80R2SYDRtgWHrugocbakwGpiO9id5Mitl1NrLAC4GV2VZSUIRJMdke?=
 =?us-ascii?Q?edZVqB8wzBBqayDLinDgdVgiYwtHQeXVvTZkcA5LL3Zkq3cJWtB0JocyM+zV?=
 =?us-ascii?Q?bP4QPBTeLUgtBYfictxmPodd3KYxDi5UqJpSMnaCefvziClIyNNZ2I/xPYWo?=
 =?us-ascii?Q?jp3Qr5RkHBLfZFrt3/M2pMm+07cX0UO52mlSP0MJ9T/DDWNMFqD8zSwhO74J?=
 =?us-ascii?Q?T//c7GAr8qmqh7SNspNXwpQXlFicVC7Dv7ahBW54/3GIayR1S8puy2hN2Zz+?=
 =?us-ascii?Q?2GO39vOZuMLD1hE5oOLIHU1F50hGu8IXOxHPa+eibZjpzvEcxXzk8sqlFNmX?=
 =?us-ascii?Q?UdZHASvkTTo1B6V+utuFPVKrHKCti4aCxqAe6z81bdrGrPkxrw4kXlcA6iAL?=
 =?us-ascii?Q?8mNVQPe9d7nAH2xQNaTBRY8NCdF1rgvc/a6hKfCwBz/MsBvOVzRm3j8wQwQY?=
 =?us-ascii?Q?uppo3RWAIthDpz/f6E4jYlLPg/umFOIwSXBmPGCNpIRFO9hOcvuNPunRxRN2?=
 =?us-ascii?Q?kz8rUO2bSMtmrkTRStTihKBb2q34CuwwSqIJDlGaqMbiW4alH57ThspGugQ0?=
 =?us-ascii?Q?1XpxLax0hWK8rBIkWLbgVNfogRBPmpC03asW5bTppUh9xb2H+wYn1uMtkR+K?=
 =?us-ascii?Q?KPlX6eGINJRZSpAX6aOzXf4MRJob6Y2AO7BnCPLSIYrtj+2e+c8poZyhQjIm?=
 =?us-ascii?Q?H41KKN9FUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8d31a0-ca51-4f41-2d6d-08de46f4e666
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:11:18.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 370tbYsymO/qnW7H7oB1FR3pN++4VZ3uisgBUswnv2RUZVdU+S9hQ7qaOhOZKX2LAJWUT405hKCiyNvi6fE6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

Hi Emil,

On Sat, Dec 27, 2025 at 10:28:11PM -0500, Emil Tsalapatis wrote:
> On Fri Dec 19, 2025 at 5:43 PM EST, Andrea Righi wrote:
> > Add a kselftest to validate ops.dequeue() semantics with direct
> > dispatch, user DSQ dispatch, affinity changes and verify that any
> > ops.enqueue() is balanced by a corresponding ops.dequeue().
> >
> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> Hi Andrea,
> 
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../testing/selftests/sched_ext/dequeue.bpf.c | 139 ++++++++++++++
> >  tools/testing/selftests/sched_ext/dequeue.c   | 172 ++++++++++++++++++
> >  3 files changed, 312 insertions(+)
> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
> >
> > diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> > index 5fe45f9c5f8fd..764e91edabf93 100644
> > --- a/tools/testing/selftests/sched_ext/Makefile
> > +++ b/tools/testing/selftests/sched_ext/Makefile
> > @@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
> >  
> >  auto-test-targets :=			\
> >  	create_dsq			\
> > +	dequeue				\
> >  	enq_last_no_enq_fails		\
> >  	ddsp_bogus_dsq_fail		\
> >  	ddsp_vtimelocal_fail		\
> > diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> > new file mode 100644
> > index 0000000000000..aae19bfd42f04
> > --- /dev/null
> > +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * A scheduler that validates ops.dequeue() is called correctly:
> > + * - For tasks on BPF data structures (not yet dispatched)
> > + * - For tasks already on DSQs (local or shared)
> > + * - That every ops.enqueue() is followed by ops.dequeue()
> > + *
> > + * Copyright (c) 2025 NVIDIA Corporation.
> > + */
> > +
> > +#include <scx/common.bpf.h>
> > +
> > +#define SHARED_DSQ	0
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +UEI_DEFINE(uei);
> > +
> > +/*
> > + * Counters to track the lifecycle of tasks:
> > + * - enqueue_cnt: Number of times ops.enqueue() was called
> > + * - dequeue_cnt: Number of times ops.dequeue() was called
> > + */
> > +u64 enqueue_cnt, dequeue_cnt;
> > +
> > +/*
> > + * Test scenarios:
> > + * - 0: Dispatch to local DSQ
> > + * - 1: Dispatch to shared DSQ
> > + */
> > +u32 test_scenario;
> > +
> > +/* Per-task state */
> > +struct task_ctx {
> > +	u64 enqueued;	/* was this task enqueued? */
> 
> Do we use this for anything? If not, can we remove it?
> We can also just do an extra sanity check with it during
> enqueues/dequeues to ensure we have no double operations.

Oh yes, the intention was to use this to detect duplicate ops.enqueue()
calls, but I forgot to add the actual check in ops.enqueue(). I'll add that
in the next version.

Thanks!
-Andrea
