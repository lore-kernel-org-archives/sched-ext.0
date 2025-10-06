Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E41E412A
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779392; cv=fail; b=tUjG4jCXweuuNVdUAgJKNMs9QY90Cxz1TRV1o8ndHul0cSfhtOw/LWopq11Nad+fCsqDhXIeujMoKBzjYTuUSuEKvojJkXUhJSECbTqeDt+cFjxi9exaBGZIiRsYC/VhxO5vcwBiNwXpgRLYd0HTdsG5wLB1BOoiWTFkgXyfXRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779392; c=relaxed/simple;
	bh=j9ngZRuVv3yuDBVtL46nuywKCp8fDHFwcc846+eIrzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I6+60fRHSsja0GnLjYGBnF7toRdkdCvctj4SvO8Ed/KMiKeKCReWzevZu4sRBjvOCu52FV9H2wY//4hrsLaqNDErTtUaO+qWpNlzg+MDkO6z7Qw+Ntgy63ykxBZwe122eYmxnu4B3U2CXF1x0pOXFFdtYO4ORKFHlNrJ1hrLXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+4ntqgo; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+4ntqgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2QcUu9caCNgX16vTqMvvzLEnMiLLLtRPRbM8G36G5BGlkcvQ1aLESDgLIaLCnmk65yPEG5EL45x9p3TtggpSpU/OBCo9yzQA15zrApqsm1xZqsrNAXBQn++iHqZY4f3ldOg40TookpWZOfhEdwIj7r/iu/Dg7XzkIZHLW4KSwHQFZiOmPFAou8u75unFN8OPa8eZUcAydRK+Tvh5gHCWDKZV/BirD9tIZYNAXBZc5heQPeyWanCY/eM/KCPoUhAF5zbXkbq3Mya6inMYfykDSm99WZeFCyDHAQUCFx8xkItGYF//Zt8c/vhVv8c2XhNTIW20QtrF3g5dOoiJHo48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmTCD0ez84LmPDP4OTxGKzIc6J7IDEdOBgXSOGxt1QQ=;
 b=yR4SqTWhvnKuxlx5G4MdkfjzhFyv2Dh3MzMTRojwNaKhTF/ouFEfCSDNKgdLr+UI7yOHrG68RwjVcUiF9+vSNgcIfZe6/uFnlYkTj6iSRHNV8ryR5MOYc4UXjJswnbcAjE712FC3Oc5DQvIXns2buRjuv8jba5NvPqKvjs4CZlJwxkkl0wwPVTy5++A7xV61W5KATStIBTKQAVOaeqyZemgLPboqzig6KSX+FuIS6Xyg/7QkcAuGAFTZAc2oOcNutUq6ZQEhApockLTcRTeLuZFo4+O2OLQQEeAKIpo1cCWcbXM+fIBvSwwpqrYXQBZyRTnpzMN2IUc/hVEMlTq6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmTCD0ez84LmPDP4OTxGKzIc6J7IDEdOBgXSOGxt1QQ=;
 b=I+4ntqgoTxPbD2Tnrkkd/r4NDJLjrBA2amr6O4XEVY1OijfviEzwSFsxjCfP6UzfhCbKZfpdJ4dA7neNSfm09cSoxk1unaqLRMZpyAzaBfPm806ztnbsnAXZ/996TUHv966atsM4QlXwAkpMa/xZpc6Zuq0v8PjaRZKNHA+vmF7AcnMaVL4xhgMdpynmgL1Fvh//KbWSlnkslqhqiYZ37aKIqto+m/XnsGHyA9TWale2K31OFFLMMicPFthbOJ/GMUS5+xIBixPkvDuvFKaVyI0NCke7ddQRD+2wWMzuWg6mvl4S+ttKSlfv6T3AOleUubj4Q/960gYMG1NriA+/AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 19:36:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 19:36:21 +0000
Date: Mon, 6 Oct 2025 21:36:11 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
	newton@meta.com
Subject: Re: [PATCH v3 2/2] sched_ext: Add a selftest for scx_bpf_dsq_peek
Message-ID: <aOQaK--p1-6TEun5@gpd4>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
 <20251006170403.3584204-3-rrnewton@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006170403.3584204-3-rrnewton@gmail.com>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: b008ba74-5642-4e7b-9e8f-08de050fa09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4W/XbL9CI5lRksF2g/rW0AiWMz8Owj/R9dct3luynLd30QmAQvhjpOoVgB2?=
 =?us-ascii?Q?59sDbZkz7qsCHVEnAa6UenZCN1WIXkbEnG+6HH15qssogiMA4SOi/0nabOhP?=
 =?us-ascii?Q?HsWqSY89MR0WdUIlopPvkDZA0qvPNc6HS38mg4RFwdMLSo6pATd997gWxBjo?=
 =?us-ascii?Q?oe9Qx3tUxRXHwF8YaWs4Ey7C4MH9zrbJMhx2n3J1cEnCpmRIsqQVfxrAxM0M?=
 =?us-ascii?Q?5XMJ/wtdeh87rM0ZkOS64mgqHAQhBkeX21XZVABtB+mcy+ilUMs1uLgTAuy3?=
 =?us-ascii?Q?FPOiCQ0Lv0EXEoDyRzwWOqBlKZtJ4zGBsN2M5IMi2/y29ppu1tSbKL1IiK9v?=
 =?us-ascii?Q?tNlzUHitnBYwMiXkz//xYTltrYCE02VYE3y1hedTembBNTtHMT2ryeGo/DIg?=
 =?us-ascii?Q?Gmo0gqpOhNYrCo1nm/dpRcVBLLI+S6isC+Y1mQVubfnWpwkCQrNrpQc673/q?=
 =?us-ascii?Q?yOjBfIfBWeFQnkh3q6TDcyh0DEMGsHIoqyw2LwlVL6uIMKaceOdN9u2Yxzfm?=
 =?us-ascii?Q?beRJoQ+jK8CwIzUrEy+myfEf/uMSgRBidoJc3Dlk2kYiIoMj8KpKzL7KuSbF?=
 =?us-ascii?Q?sH7NS9r021woFrhjxW6vXAKA+QbyZGzebw23XedbiZwoRvWGTJr3xUpzZUR7?=
 =?us-ascii?Q?LQQ4ghUb4HKYKwAydwakDstmck9ChEnr0k5amvdRUDmlcF7SBaoQ4uf/Mdi/?=
 =?us-ascii?Q?ilE09LjDmNVeSI2CHE2yPwPdTr2xpHvtS4bnZJOkiER82GkZ8pcNpTDzwpte?=
 =?us-ascii?Q?Ps4PMG6hsFBvxx4NX0UZJfbeNiyqcqBnczjQxLUrVqxbjCmPaBucUMmMi+tu?=
 =?us-ascii?Q?ccUwMWt4+zwNtknFr7s2bjAk8FmbG6VCIe2c1RRm/mJU+b2B0u1l7Z2Uyhyf?=
 =?us-ascii?Q?6u7i4niiewgr3G8q62Bas1BDWqg4x6N3kck2k4ZQeG36o6YTWwZCfCapvq3n?=
 =?us-ascii?Q?cIGqRyCR5/VWJ4QG06w9XzUJ7PRPjC4lf0Ei2IBqyvG3VtSjuApiAQieoFFf?=
 =?us-ascii?Q?y2Gr+yRhfs9cdanOq7qVnpwW0T37v/uxdKU1CNsMprS6fzqGua0NEd6jRCfi?=
 =?us-ascii?Q?cmG0wt1sfPTltMsuPJioFNzUvJebcR5X9zmc9gKje204ExQeu7sbI3oRUi9O?=
 =?us-ascii?Q?SOavhi8RP7FUGjYHHTuQMaXWfieR/e+Frrw2VeWWDB3A4vo0Lqi6z7v3LDnh?=
 =?us-ascii?Q?TMymaRwjGnVrqvuBhangGt3KzDuLOf+puimq7bHlSv0DmguTwxGsSFo/7KC/?=
 =?us-ascii?Q?3HUCRJZ4sOfusWh+LFGfvpziFIbZE9xBSgXl+eGKLJYi/IwsIL35Kg4Iz7ME?=
 =?us-ascii?Q?cjVtOOubWQOlWCqg2t5QXx5Zm7jroxaWNjaEKOtp8yESVPUC53tukb+6rFSl?=
 =?us-ascii?Q?HFReNpdBGCETV7OpBikyTDxEW+RryDnREyj4ALXdBKDuMkDpCLwhuPMN3lKx?=
 =?us-ascii?Q?sxUq8EF5AK0ZKBq2d05n7/ClxO2+MZk9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AA89lZPd9dM0frRpNodtrT3XnjK87371Cqb5+Fj+GteRjWKrTrc5puVlHvLR?=
 =?us-ascii?Q?iVYRLlf5PzdS0R1Uk7Os0p9zzmQ3n5yHEg0gZyoHdJlpMn5Gb4PiT/3+VDrF?=
 =?us-ascii?Q?wjicWS4u1iU67pnrF0I2hvyihzYzREtYl4jmMZKPNl3BJz/4DZ86XncHUvn5?=
 =?us-ascii?Q?WYuWA5b/YxQJoY9y2Ckr6A2j1Vt2460bd5HX/rYwWy+oKGxwZ0zCW2dJpx5t?=
 =?us-ascii?Q?/a6aLZl5N/2FC4sas1xdLA8I1YBtenrh4eqY2jAqSt8MlE1qHp0DrJpV5Q5j?=
 =?us-ascii?Q?bGQ/OqrQSrqwD9O6wEdhyfkgpZZ6njYf0yA00e/8RDbHznoApi79sp7FBxF5?=
 =?us-ascii?Q?WWN1ylIPeiFLS2m3t+3K9jdbCCWCHF01TypYAbZ4Lmset0Rp0ZBm0mRANFJR?=
 =?us-ascii?Q?jUHk0bgpqbGb+1r18iODK6eHOVQOjN7Wdf67799RgCJI5yfh28MU0KqhiCJM?=
 =?us-ascii?Q?mN5C4J7QpD7YG+QtkXsMWufuuglRFiP6a3DZJWS6UvjmJf41Whc3UHxljc3m?=
 =?us-ascii?Q?iMCOG0xHd1a45LsPN1OnicezRzXHxp09SJ2FSkORI0KfUTGgENW1rS0tuYvH?=
 =?us-ascii?Q?+bqCRTPEVxQwUWuCjqUcrRmNb9RwiiRwQSURIW+vqhk+uxQK569P2ETlJ3rj?=
 =?us-ascii?Q?52iCaqzXwRVuoFrZKAv//ZatOfn4LrjcdR8SjHbOzKbnjW2x4hrQST0xV1a0?=
 =?us-ascii?Q?zqfphuGhow0e889Vl6ItVo1PZYOXpdIJXhtTBTbzC20NX5HQgYuokQIDo+Zi?=
 =?us-ascii?Q?AfZEJL4Jkt5RR8chz0tJLzthYETafh2HP5IQwfq6nCRItROlNj0H3rpVsglb?=
 =?us-ascii?Q?lrSWiJ8721Somn+A/pLxrRuAIa0aZ1/NW+hYYX8AWhYKnkQnTH7tZK/31aor?=
 =?us-ascii?Q?XXr2qJHIKJUsFbKQKBS0v4dVookRH/tNDdClwAk3Zu7kitg6pEi6aQNK5f6l?=
 =?us-ascii?Q?7d76A24vg5RPbwQvVbU+T5DcrSUyxOEoctk3H3sVFkprP0XyuDp4Oq7XJAC0?=
 =?us-ascii?Q?HH4nsmKp+jcxmQWv7AvAcrlZrDnyCYXhAQGk1VG+ufSgc3jfwkGziqt/DK+z?=
 =?us-ascii?Q?WP6jb9Z79NBT+iMtNK9CEWHMPB9avrMgMFWINJ1hceoHzMlnYLrr6YMSFBKR?=
 =?us-ascii?Q?cGOXL6YPxWiI9n6/py4C/b+m28erM4Rqp7ktQvn8nDhkoNjowX49zLttv6AC?=
 =?us-ascii?Q?fNnqYzHW9Nrpco7z83esIPuzrr3OHCd+Yvnie0SFcmiTlsj/kPRxLB+/Wn/h?=
 =?us-ascii?Q?Q3L/eDTbk+eClFzyIp/0d84l0/3eGFJQDkdNVxWky/IGl1qTO4MjWOY7yxXs?=
 =?us-ascii?Q?fmJ0J9pdbeo2HCsgvDK/MQ3bqhgjoQ4lAdUzZYg8BlZJdNWPlBU/cpfyhedv?=
 =?us-ascii?Q?E610Cuq2Ckl/CCkZO+PksE4zfpUYU/3dWQJx/twT3hwl7gO/1GIhqrNCMT7p?=
 =?us-ascii?Q?VtkgZqn+J+ZT2yWb1+cZKn784kGmqqs3Lkto3okeogQEtOVMznYCzjIayoDM?=
 =?us-ascii?Q?GmQGxfXcbrJy0DDES/Nb8u7dgWKNvJPJ+q49+t+mokjbklCnnEyQlKXydfuj?=
 =?us-ascii?Q?mWrfMkcf2Qri2Tf9y/vPGr1zIQZR5jRihzp/pxoq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b008ba74-5642-4e7b-9e8f-08de050fa09c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 19:36:21.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fayTMWq5ZIbpr8gpCS3FL+4JpqCXMNZyev5SGj4umc163I2DWkpAFVRsSzfKjcJkSFktqKcQedFCObN2NEK8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9501

Hi Ryan,

On Mon, Oct 06, 2025 at 01:04:03PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> Perform the most basic unit test: make sure an empty queue peeks as
> empty, and when we put one element in the queue, make sure peek returns
> that element.
> 
> However, even this simple test is a little complicated by the different
> behavior of scx_bpf_dsq_insert in different calling contexts:
>  - insert is for direct dispatch in enqueue
>  - insert is delayed when called from select_cpu
> 
> In this case we split the insert and the peek that verifies the
> result between enqueue/dispatch. As a second phase, we stress test by
> performing many peeks on an array of user DSQs.
> 
> Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
> empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
> the buffered insert. Unfortunately, this is not viable within the
> enqueue path, as it attempts a voluntary context switch within an RCU
> read-side critical section.

This test is a bit difficult to follow and it's completely hammering the VM
where I'm running it. I think we should avoid adding selftests that are too
heavy, as they might trigger false positives and lead distro maintainers to
ignore or disable them in their CI/CD.

Maybe we should go with something simpler to test the basic functionality
of this new API and validate the expected beavior.

For instance, most BPF schedulers using this API will likely implement
something like the following in their ops.dispatch():

	u64 min_vtime = ULLONG_MAX;
	u64 dsq_id, target_dsq;

        bpf_for(dsq_id, 0, MAX_DSQ) {
                struct task_struct *p = __COMPAT_scx_bpf_dsq_peek(dsq_id);

                if (p && bpf_cpumask_test_cpu(from_cpu, p->cpus_ptr) &&
                    p->scx.dsq_vtime < min_vtime) {
                        min_vtime = p->scx.dsq_vtime;
                        target_dsq = dsq_id;
                }
        }

	if (min_vtime < ULLONG_MAX)
		scx_bpf_dsq_move_to_local(min_cpu)

I think this is the specific use case we want to make sure doesn't break in
the future.

A way to validate this could be to use a global counter (vtime_enq), every
time a task is queued, increment vtime_enq and use the value with
scx_dsq_insert_vtime() and insert the task to a DSQ from a pool of DSQs (up
to MAX_DSQ).

Then in ops.dispatch() we can always consume the task with the minimum
vtime, using the logic above and verify that min_vtime is always
incremented by one, or something similar.

That said, we can go with your approach for now and improve the selftest
later in the future, you don't have to completely rewrite the test. But I
think we should make it a bit more lightweight at least, maybe reduce the
workers or similar.

Also, few minor comments below.

> 
> Signed-off-by: Ryan Newton <newton@meta.com>
...
> diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> new file mode 100644
> index 000000000000..8d179d4c7efb
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A BPF program for testing DSQ operations including create, destroy,
> + * and peek operations. Uses a hybrid approach:
> + * - Syscall program for DSQ lifecycle (create/destroy)
> + * - Struct ops scheduler for task insertion/dequeue testing
> + *
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
> + */
> +
> +#include <scx/common.bpf.h>
> +#include <scx/compat.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define MAX_SAMPLES 100
> +#define MAX_CPUS 512
> +#define DSQ_POOL_SIZE 8
> +int max_samples = MAX_SAMPLES;
> +int max_cpus = MAX_CPUS;
> +int dsq_pool_size = DSQ_POOL_SIZE;
> +
> +/* Global variables to store test results */
> +int dsq_create_result = -1;
> +int dsq_destroy_result = -1;
> +int dsq_peek_result1 = -1;
> +long dsq_inserted_pid = -1;
> +int insert_test_cpu = -1; /* Set to the cpu that performs the test */
> +long dsq_peek_result2 = -1;
> +long dsq_peek_result2_pid = -1;
> +long dsq_peek_result2_expected = -1;
> +int test_dsq_id = 1234; /* Use a simple ID like create_dsq example */
> +int real_dsq_id = 1235; /* DSQ for normal operation */
> +int enqueue_count = -1;
> +int dispatch_count = -1;
> +int debug_ksym_exists = -1;

Maybe use a bool here.

> +
> +/* DSQ pool for stress testing */
> +int dsq_pool_base_id = 2000;
> +int phase1_complete = -1;
> +int total_peek_attempts = -1;
> +int successful_peeks = -1;
> +
> +/* BPF map for sharing peek results with userspace */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, MAX_SAMPLES);
> +	__type(key, u32);
> +	__type(value, long);
> +} peek_results SEC(".maps");
> +
> +/* Test if we're actually using the native or compat version */
> +int check_dsq_insert_ksym(void)
> +{
> +	return bpf_ksym_exists(scx_bpf_dsq_insert) ? 1 : 0;
> +}

This helper is unused, we can drop it.

> +
> +int check_dsq_peek_ksym(void)
> +{
> +	return bpf_ksym_exists(scx_bpf_dsq_peek) ? 1 : 0;
> +}

Do we need this helper? I think we can just do:

  debug_ksym_exists = bpf_ksym_exists(scx_bpf_dsq_peek);

And have debug_ksym_exists as bool.

> +
> +static inline int get_random_dsq_id(void)
> +{
> +	u64 time = bpf_ktime_get_ns();
> +
> +	return dsq_pool_base_id + (time % DSQ_POOL_SIZE);
> +}
> +
> +static inline void record_peek_result(long pid)

Does it really need to be inline? It's quite of a big function.

> +{
> +	u32 slot_key;
> +	long *slot_pid_ptr;
> +	int ix;
> +
> +	if (pid <= 0)
> +		return;
> +
> +	/* Find an empty slot or one with the same PID */
> +	bpf_for(ix, 0, 10) {
> +		slot_key = (pid + ix) % MAX_SAMPLES;
> +		slot_pid_ptr = bpf_map_lookup_elem(&peek_results, &slot_key);
> +		if (!slot_pid_ptr)
> +			continue;
> +
> +		if (*slot_pid_ptr == -1 || *slot_pid_ptr == pid) {
> +			*slot_pid_ptr = pid;
> +			break;
> +		}
> +	}
> +}
> +
> +/* Scan all DSQs in the pool and try to move a task to local */
> +static inline int scan_dsq_pool(void)

This is also quite big, we can drop inline and let the compiler decide.

> +{
> +	struct task_struct *task;
> +	int moved = 0;
> +	int i;
> +
> +	bpf_for(i, 0, DSQ_POOL_SIZE) {
> +		int dsq_id = dsq_pool_base_id + i;
> +
> +		total_peek_attempts++;
> +
> +		task = __COMPAT_scx_bpf_dsq_peek(dsq_id);
> +		if (task) {
> +			successful_peeks++;
> +			record_peek_result(task->pid);
> +
> +			/* Try to move this task to local */
> +			if (!moved && scx_bpf_dsq_move_to_local(dsq_id) == 0) {
> +				moved = 1;
> +				break;
> +			}
> +		}
> +	}
> +	return moved;
> +}
> +
> +/* Struct_ops scheduler for testing DSQ peek operations */
> +void BPF_STRUCT_OPS(peek_dsq_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	struct task_struct *peek_result;
> +	int last_insert_test_cpu, cpu;
> +
> +	enqueue_count++;
> +	cpu = bpf_get_smp_processor_id();
> +	last_insert_test_cpu = __sync_val_compare_and_swap(
> +		&insert_test_cpu, -1, cpu);

This can be in a single line.

> +
> +	/* Phase 1: Simple insert-then-peek test (only on first task) */
> +	if (last_insert_test_cpu == -1) {
> +		bpf_printk("peek_dsq_enqueue beginning phase 1 peek test on cpu %d\n", cpu);

No need the "\n" when you use bpf_printk().

> +
> +		/* Test 1: Peek empty DSQ - should return NULL */
> +		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
> +		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
> +
> +		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
> +		dsq_inserted_pid = p->pid;
> +		scx_bpf_dsq_insert(p, test_dsq_id, 0, enq_flags);
> +		dsq_peek_result2_expected = (long)p; /* Expected the task we just inserted */
> +	} else if (!phase1_complete) {
> +		/* Still in phase 1, use real DSQ */
> +		scx_bpf_dsq_insert(p, real_dsq_id, 0, enq_flags);
> +	} else {
> +		/* Phase 2: Random DSQ insertion for stress testing */
> +		int random_dsq_id = get_random_dsq_id();
> +
> +		scx_bpf_dsq_insert(p, random_dsq_id, 0, enq_flags);
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	dispatch_count++;
> +
> +	/* Phase 1: Complete the simple peek test if we inserted a task but
> +	 * haven't tested peek yet
> +	 */
> +	if (insert_test_cpu == cpu && dsq_peek_result2 == -1) {
> +		struct task_struct *peek_result;
> +
> +		bpf_printk("peek_dsq_dispatch completing phase 1 peek test on cpu %d\n", cpu);

Ditto about "\n".

> +
> +		/* Test 3: Peek DSQ after insert - should return the task we inserted */
> +		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
> +		/* Store the PID of the peeked task for comparison */
> +		dsq_peek_result2 = (long)peek_result;
> +		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
> +
> +		/* Now consume the task since we've peeked at it */
> +		scx_bpf_dsq_move_to_local(test_dsq_id);
> +
> +		/* Mark phase 1 as complete */
> +		phase1_complete = 1;
> +		bpf_printk("Phase 1 complete, starting phase 2 stress testing\n");

Ditto.

> +	} else if (!phase1_complete) {
> +		/* Still in phase 1, use real DSQ */
> +		scx_bpf_dsq_move_to_local(real_dsq_id);
> +	} else {
> +		/* Phase 2: Scan all DSQs in the pool and try to move a task */
> +		if (!scan_dsq_pool()) {
> +			/* No tasks found in DSQ pool, fall back to real DSQ */
> +			scx_bpf_dsq_move_to_local(real_dsq_id);
> +		}
> +	}
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
> +{
> +	s32 err;
> +	int i;
> +
> +	/* Always set debug values so we can see which version we're using */
> +	debug_ksym_exists = check_dsq_peek_ksym();

As mentioned above this one can be:

	debug_ksym_exists = bpf_ksym_exists(scx_bpf_dsq_peek);

> +
> +	/* Initialize state first */
> +	insert_test_cpu = -1;
> +	enqueue_count = 0;
> +	dispatch_count = 0;
> +	phase1_complete = 0;
> +	total_peek_attempts = 0;
> +	successful_peeks = 0;
> +	dsq_create_result = 0; /* Reset to 0 before attempting */
> +
> +	/* Create the test and real DSQs */
> +	err = scx_bpf_create_dsq(test_dsq_id, -1);
> +	if (!err)
> +		err = scx_bpf_create_dsq(real_dsq_id, -1);
> +	if (err) {
> +		dsq_create_result = err;
> +		scx_bpf_error("Failed to create primary DSQ %d: %d", test_dsq_id, err);
> +		return err;
> +	}

How about:

	err = scx_bpf_create_dsq(test_dsq_id, -1);
	if (err) {
		dsq_create_result = err;
		scx_bpf_error("Failed to create DSQ %d: %d", test_dsq_id, err);
		return err;
	}
	err = scx_bpf_create_dsq(real_dsq_id, -1);
	if (err) {
		dsq_create_result = err;
		scx_bpf_error("Failed to create DSQ %d: %d", real_dsq_id, err);
		return err;
	}

Also do we need to save the error in dsq_create_result (similar with the
other error variables)?

We could just use scx_bpf_erroro(), have UEI_RECORD(uei, ei) in ops.exit()
and use SCX_EQ() in peek_dsq.c to catch error conditions and trigger a
failure, see for example allowed_cpus[.bpf].c.

> +
> +	/* Create the DSQ pool for stress testing */
> +	bpf_for(i, 0, DSQ_POOL_SIZE) {
> +		int dsq_id = dsq_pool_base_id + i;
> +
> +		err = scx_bpf_create_dsq(dsq_id, -1);
> +		if (err) {
> +			dsq_create_result = err;
> +			scx_bpf_error("Failed to create DSQ pool entry %d: %d", dsq_id, err);
> +			return err;
> +		}
> +	}
> +
> +	dsq_create_result = 1; /* Success */
> +
> +	/* Initialize the peek results map */
> +	bpf_for(i, 0, MAX_SAMPLES) {
> +		u32 key = i;
> +		long pid = -1;
> +
> +		bpf_map_update_elem(&peek_results, &key, &pid, BPF_ANY);
> +	}
> +
> +	return 0;
> +}
> +
> +void BPF_STRUCT_OPS(peek_dsq_exit, struct scx_exit_info *ei)
> +{
> +	int i;
> +
> +	scx_bpf_destroy_dsq(test_dsq_id);
> +	scx_bpf_destroy_dsq(real_dsq_id);
> +	bpf_for(i, 0, DSQ_POOL_SIZE) {
> +		int dsq_id = dsq_pool_base_id + i;
> +
> +		scx_bpf_destroy_dsq(dsq_id);
> +	}
> +
> +	dsq_destroy_result = 1;
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops peek_dsq_ops = {
> +	.enqueue = (void *)peek_dsq_enqueue,
> +	.dispatch = (void *)peek_dsq_dispatch,
> +	.init = (void *)peek_dsq_init,
> +	.exit = (void *)peek_dsq_exit,
> +	.name = "peek_dsq",
> +};

Thanks,
-Andrea
