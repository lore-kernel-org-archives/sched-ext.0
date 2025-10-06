Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BE23ABBF
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771593; cv=fail; b=EtNvdTB3GBoSfjiS+RvREc9czBVCTs3O2UR92p4YixVguernYpK//NsobYC5Qscbtrppd5YDOluricH+bVP0XjJl7p5+vsYH4fATqar7qBE/Xixi+m3+WuqFS9Rb/Nnk3E3QvIOHUdsba+A/uRPM4hB6y6GGfOWw0OnNS3j2hSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771593; c=relaxed/simple;
	bh=o7TZB2/68eKXw2Tv51VBYz8sdskba9swhdYZOjw8Yns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3GWtTT7p8H6Ym8KYbBX5W4uJilEsMB0/56ybf2JdRHw3ZKm3H60E8fAQtTGendrqzILI2Uvi2D2ZKBoRx6M6JTZQ96Mh4v+FdEXnYYuX37nmIuecK0VU+HtP9vmEwP9Y6v2PsLN/g0CvEzgbaZ0r6TJ9teMnm7gTlgjNjniS24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8u2rD2e; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8u2rD2e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDVM0PoCrBlDmVKm9GPJ3+kzpDba9Afmm+3oXDQTsZ2oUORhDJRJsCdY4ETrZ7fOwiS6d1fbNQAcycSwn2j7E9nll4mvTXlCWNSSAfw318Yu+LMtrs87G4UpzpnaCLqwYbWLP6Wreo39EeW23B//EDO/KvfAASCLT4/5DAVW38H5WTPCKbWL5bZ8s+PrXBt1nG7f8NJzAp83aI9m0aMahoSzQxu+mW/SGsKM+nlJnoZ4c6ME5tKAmpO+RiZfb1xArMSAeQugJzjl+5aH7LgaTs5P+8AgV4CsSvcpLwRUD2zQig1iWkSYM2HDwz2ghdujII6wPgGvC8xwmAJnrYQkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4ZXI67KCSOpcIDhz5NJU+mtmAkhTTMgJ9aVQ18cwnw=;
 b=wFTbfkJYWzJ+xX2sEC0LEO6WySt77kLcbQnrCCCvL+T428nNTji0axp/aprFy2+hZ+aY25v60JStkkTQilOQ5k0SoMjH51rcOpnBtm1NFrADzGUT1NVv/FiOJ56rRa6EJU+VeF9ODY0qy4msqJuuH0PhkWq9qTD0yrnG4KrgNLu1RtJaPGZw+snIWE4EKzJXTJX24G5NTZAazLYqLUaIaNKfDiFaehPn8HJV+2ylyrlGZe/RiGVk9gIbN85LZpvZHmqK90l4DgiQ/jsjr4rLAQNU/YM/DQ3TsBizVodoWESJdBFqmLVyigAkhlJbDrL2P26D9/NHuqTNoFkEsY9aTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4ZXI67KCSOpcIDhz5NJU+mtmAkhTTMgJ9aVQ18cwnw=;
 b=Q8u2rD2e/ln0bbv8HZrRNogP5Q6mcXqVO2pwiX/5Uui79TAPGRcHCsF1Z3opqHgZfr2iqS+QgAQZ8oN7s3cmSfb03plUoVOXZndp3oezOqHJ9IzXMVw7qH7tAPDvhQwPp/Jr6r/jXA/0uqZgdPPHYIvpTR3HXKdpB5AfnAHMEzWpD5uyGngdLUiiEMGsXoBNhisoKbOTnQtLf6lilAzXl6pNJwh+y1/SiB/q48Cb2H+s4xIZ1JV9zKi9fo8oOh/wcUhX+/2WC0azuBx/iFMIkidl81jqp8T92Z88VkqKUom5s8dpb6q83b1rezpWTaTNjyqY6bKPkVjLLjzHaj94ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 17:26:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 17:26:23 +0000
Date: Mon, 6 Oct 2025 19:26:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
	newton@meta.com
Subject: Re: [PATCH v3 1/2] sched_ext: Add lockless peek operation for DSQs
Message-ID: <aOP7t_obZGikuo5J@gpd4>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
 <20251006170403.3584204-2-rrnewton@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006170403.3584204-2-rrnewton@gmail.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: e84a35b4-b59d-4dc3-c7e3-08de04fd78bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBsqBsgEm8hG8lG6jS26ervlGaeZCctXgetjsGNINfUJXe90yIgriNW7e+Dr?=
 =?us-ascii?Q?74O7PZmnPrn2Vg8m816rJcz11awO1NSQbyLiJ9pPBot9wIaAxEhTVEaZgdmv?=
 =?us-ascii?Q?ifhB9U01uvYum/Ittyv3usV9JTM8/8Ha+a6hARzYtbSpDElurr7tDOgA8ojA?=
 =?us-ascii?Q?azZCBQXAWzxyXqo2dc+9owcFBysObpOXKyvWRfyp2Rxo8unnAtTRI9VxZv5c?=
 =?us-ascii?Q?BDMP1eDLsDZjT2g5gqjD/ke3+QwkxMT3FCXJDG1ahPB0zhB5VQfqTPlRxxSU?=
 =?us-ascii?Q?K/juVvgNp2dbBCo79FWAglY0JhfAz+gje9NNKmgcy/HHfj4C8go28hyX9Owx?=
 =?us-ascii?Q?+YyMuM/QVCCifmA+7ZeX9sbH7Nhgx5B1hvRHx5zYuAaAXEbwVFE35mreoD9h?=
 =?us-ascii?Q?cc0ICHC713tD8mjw9YFlbOF1V+qhIRErweWjVVn4GORsZlrCosYZb0DHwCtC?=
 =?us-ascii?Q?f1MFaUJVuuneYDK0l/c30SN+wBksg28EYVVk8clLatco0KIgxpdAYIeaW0C5?=
 =?us-ascii?Q?svNyqN/O4s8Vuza9uBk0chvxRZ+f0FlZGwIOa5Zc5YmbnzYqH2+LlRE8h0tG?=
 =?us-ascii?Q?gbMr2AqTcra0Da5StQCqZ8JSW2z856USUVTOrltNFQQgT4FEGrmIKuZESeUQ?=
 =?us-ascii?Q?YS4ELgPeVAc3lkWcms3m3B7qWQAFouX44zMREsuQ1gu0GeCoPnJnEeebiz6g?=
 =?us-ascii?Q?yiR2bScNW30t6BcEVfibLaYlR6QKHKhmHTnycFgRA0zusfiNZHdfAk09jHQ4?=
 =?us-ascii?Q?v/wA1MFmn0Xuo9qI8FgEscwN4dGbLQNQ+dscYlBDZSE3H7YIz9XLj3CHtk8w?=
 =?us-ascii?Q?K44SAj70K6mQvH5wUAzCsrTkzJLO+vklOhREikacyBsyLnURFvnJRuA6OoSd?=
 =?us-ascii?Q?FMk43aJwjUx091d1EP+wBdOyPQSjqHXSDXtyCZFsieAoqrqxby1PO4wrXg26?=
 =?us-ascii?Q?U9pfxzuw1pTGF2SDbyIbsAepS+gxI7J9VaR0a5LBAR+bawx4FF0e384irnuq?=
 =?us-ascii?Q?8vRw1Wl5nTu1p1y7xU2NsfXnTx8MdxaizcCY0Y5RBcIdjgOqB8vordKAMAB/?=
 =?us-ascii?Q?Lvx1KfFXjGVa8GqnlWnUGjtf+kZ9NQtF3Cy2XFemvfFhyNmyBADbviXgkUh4?=
 =?us-ascii?Q?4aU5icqcxpLRHh3IZzioeHKlJQ5qlOMR4wKtNIAkWRG8AsnEsf45lDxgNsPG?=
 =?us-ascii?Q?okHtyuiU99dxXs+edsdxhck9egXPWueoeqgbUFPJL8lD8m2MJvXvwzMAoUU6?=
 =?us-ascii?Q?CKqWT9GB973szEzvykR21sFNq4ewbn0eJcTOFh+1OjY03Z0uUuAbrPWy+xMc?=
 =?us-ascii?Q?R7nQDwQ9cNotW2RAw39C7/BNBb086cBfde8OykI13cgIZSen2qOWj5CpaG5n?=
 =?us-ascii?Q?5hQw8dLMb2f4pVYksU/j6MOf/NAmlHI4hzbrjHSigyuBMGE33lGQxIr0BA7W?=
 =?us-ascii?Q?GSebejH3xBuAmxKoJZoPSktP3veO1fiz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kqy/wq+Ap+53aQwD4s5qJppVwQ+0eM76vB3hifLqDGmRd+/9woZSwekBSkjH?=
 =?us-ascii?Q?GQg39ixnopTPY8DmHxdvYzxQcyvF6M0lfzo2aSIw8aSb2acH08WKAJ0c5W4h?=
 =?us-ascii?Q?3MmPcda318YaLEkqzYvVGs7MU+/3p9fsyvsq+3CfZIcvYSVcuqsV/2njOjCz?=
 =?us-ascii?Q?GvFF/UTkiZhAsl8HbSRTFO81NfVp2PDGhjMxoGTztPrADETzF21VLkQK+uzH?=
 =?us-ascii?Q?rhhSzUm2VScJMtX5h7DQiJdUwk6DQoUT2x3aN3CnlNcBdSipSLWNZ47Bk4U1?=
 =?us-ascii?Q?ICMDuU1A3PZnbUr6oGnnUuPsxiaG4ArsunjNlZ08myXZ1ipX6lEsqfY34Ntc?=
 =?us-ascii?Q?PGLS5Pa5ZQGqiadznTDsuh0BsU0b7tPzAj5PD3jLsz15orIrT+GAVglV/q4h?=
 =?us-ascii?Q?UjMtAETO0bNL4oU1lH/mrBnlIxZnEXCZliyHwXqrbioDUcKgsv5aJA0M4bhw?=
 =?us-ascii?Q?Y4Fa/hdEeQ/OHvVByC0xh/TLyxZDxpRXme3UmfbeGsMYZsdCBNgTUt4Dgjuc?=
 =?us-ascii?Q?fv53CCEHngLxaM9Unx7PRdpQVt2guOS3cwylrOYzwFmOwYEKhuZ+kvVuITO8?=
 =?us-ascii?Q?Df49meVGc36At3Tz5S+6L7wiqX8sbmQDytToGF0hyWsi6V07AqrcYb4hWxlW?=
 =?us-ascii?Q?eBtKie5/mI3u6sUktXFnRssZZz/WXBLpBRa5Dn/fjpAg1EpaE58GGvO/8vYB?=
 =?us-ascii?Q?d5GecC0Up0MEaQaxA8GIYhDFbiAJTPL/Ns5kDctgi4lpBcneS/pRlouNl+qi?=
 =?us-ascii?Q?KQUANKlYJjkICNWMp6tf6REOOfqAYjlK6LELWZZ99Fxg/PfxpUjiKn5E2JTE?=
 =?us-ascii?Q?GIT0abtniPZcNjDKG+VsX96LaKq5lWXybB+yElPw01JTGwRnJeds+swG2vOu?=
 =?us-ascii?Q?Z4OHQMbGK7OdY0TfoHnP+DqC+jdq4vLndWftwMXmeKgd46M2Kbhpksi/EMYu?=
 =?us-ascii?Q?LWKIQ5v/mRnJeYpWsuM8rZ9yKZUENpNuyzkRdjz+35daDB5K64XhUxA6HVJY?=
 =?us-ascii?Q?TVI/3QvnLF4oZiqap+NFVtbLfIRPLTste6Rzls6nu8G4J+6SoOhz7xKez43p?=
 =?us-ascii?Q?rLUgcCQSOOM+4av6rQA3+xeNL3P2M8SJS3k5VkzU5QhZ1+z6uuOlx46neKLo?=
 =?us-ascii?Q?8csa32y2zGW8GmBhAcYis+PHXl+2k5XS7KBD0zTpT6rprQHNgh0CIxa89Cr7?=
 =?us-ascii?Q?P59A8GwfPgj4SqryF9jEJsS0AHVcgCkg4EsRZLhGynkpV7kZBBPITouNhfT+?=
 =?us-ascii?Q?v5LhRqF6BLIwCOzFz9BwAgZk/7EkPfMDKjpBlKdhgWZ7cDJ+Q1GeUty9r0kr?=
 =?us-ascii?Q?l0v8skqB2VcBBYXxfYkBnZbwA2S7jU2wz8hxgGT3X2UYOcfh76t4+ubMd0Sr?=
 =?us-ascii?Q?x1Q6STrd99Badhbz6LUAWYEOCn1YblhECrZdLk1EWi+sZ1vj0fAIwZ7PJWU+?=
 =?us-ascii?Q?qpzQUPmBmRg0wbSKlHDOQP3zSc8IdorBGEvf+4h0UKeZZ+HlS4JA/8sgpjp+?=
 =?us-ascii?Q?dg+gqoCjkzCT2zhIoabwuyV9E/oKFCaYhMPlNWRsWGDRugLHzAZgE0VjzNXl?=
 =?us-ascii?Q?1h3PVRrYSP537MK/eGqSL6iDGNgEPdH9sSqAfdpX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84a35b4-b59d-4dc3-c7e3-08de04fd78bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 17:26:23.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AywB4khBi7g/AGhGGovJSxlYZizN03z2+RJFL222nyMqf8nZODBqKZKYbzX6gYSPJ7pYlu+be7sIa1Chx0MJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808

Hi Ryan,

On Mon, Oct 06, 2025 at 01:04:02PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> The builtin DSQ queue data structures are meant to be used by a wide
> range of different sched_ext schedulers with different demands on these
> data structures. They might be per-cpu with low-contention, or
> high-contention shared queues. Unfortunately, DSQs have a coarse-grained
> lock around the whole data structure. Without going all the way to a
> lock-free, more scalable implementation, a small step we can take to
> reduce lock contention is to allow a lockless, small-fixed-cost peek at
> the head of the queue.
> 
> This change allows certain custom SCX schedulers to cheaply peek at
> queues, e.g. during load balancing, before locking them. But it
> represents a few extra memory operations to update the pointer each
> time the DSQ is modified, including a memory barrier on ARM so the write
> appears correctly ordered.
> 
> This commit adds a first_task pointer field which is updated
> atomically when the DSQ is modified, and allows any thread to peek at
> the head of the queue without holding the lock.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>

With the minor nit from PATCH 2/2 this looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks!
-Andrea

> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext.c                       | 54 +++++++++++++++++++++++-
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++++++
>  4 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d82b7a9b0658..81478d4ae782 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
>   */
>  struct scx_dispatch_q {
>  	raw_spinlock_t		lock;
> +	struct task_struct __rcu *first_task; /* lockless peek at head */
>  	struct list_head	list;	/* tasks in dispatch order */
>  	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
>  	u32			nr;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..6d3537e65001 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -944,8 +944,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  				container_of(rbp, struct task_struct,
>  					     scx.dsq_priq);
>  			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
> +			/* first task unchanged - no update needed */
>  		} else {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> +			/* not builtin and new task is at head - use fastpath */
> +			rcu_assign_pointer(dsq->first_task, p);
>  		}
>  	} else {
>  		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
> @@ -953,10 +956,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
>  				  dsq->id);
>  
> -		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> +		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> -		else
> +			/* new task inserted at head - use fastpath */
> +			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +				rcu_assign_pointer(dsq->first_task, p);
> +		} else {
> +			bool was_empty;
> +
> +			was_empty = list_empty(&dsq->list);
>  			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
> +			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +				rcu_assign_pointer(dsq->first_task, p);
> +		}
>  	}
>  
>  	/* seq records the order tasks are queued, used by BPF DSQ iterator */
> @@ -1011,6 +1023,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
>  	}
>  
> +	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
> +		struct task_struct *first_task;
> +
> +		first_task = nldsq_next_task(dsq, NULL, false);
> +		rcu_assign_pointer(dsq->first_task, first_task);
> +	}
> +
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
>  }
> @@ -6084,6 +6103,36 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  	kit->dsq = NULL;
>  }
>  
> +/**
> + * scx_bpf_dsq_peek - Lockless peek at the first element.
> + * @dsq_id: DSQ to examine.
> + *
> + * Read the first element in the DSQ. This is semantically equivalent to using
> + * the DSQ iterator, but is lockfree.
> + *
> + * Returns the pointer, or NULL indicates an empty queue OR internal error.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return NULL;
> +	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
> +		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
> +		return NULL;
> +	}
> +
> +	dsq = find_user_dsq(sch, dsq_id);
> +	if (unlikely(!dsq)) {
> +		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
> +		return NULL;
> +	}
> +	return rcu_dereference(dsq->first_task);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
> @@ -6641,6 +6690,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..fbf3e7f9526c 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
>  int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
>  struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
>  void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..97b10c184b2c 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
>  	false;									\
>  })
>  
> +
> +/*
> + * v6.19: Introduce lockless peek API for user DSQs.
> + *
> + * Preserve the following macro until v6.21.
> + */
> +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct task_struct *p = NULL;
> +	struct bpf_iter_scx_dsq it;
> +
> +	if (bpf_ksym_exists(scx_bpf_dsq_peek))
> +		return scx_bpf_dsq_peek(dsq_id);
> +	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> +		p = bpf_iter_scx_dsq_next(&it);
> +	bpf_iter_scx_dsq_destroy(&it);
> +	return p;
> +}
> +
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> -- 
> 2.51.0
> 
