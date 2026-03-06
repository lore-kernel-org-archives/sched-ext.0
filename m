Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C834CFAC
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809354; cv=fail; b=GGpyD+9UsPWi73MZ6PFvS4xzja4qiVNHFaOogGOr3Ui0TNfllZawTDoaw/l24pDt8HgFH0VYeDtjWfeuszyCr8TT4DxdkQeu46SH+ISpr02D9EW5QSciIxOObZVCstc6HJH/TE1IxczwEZ16ZP1k13KpFzTxZles0EDYw8fqdV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809354; c=relaxed/simple;
	bh=NGHlT3lGRNI/KOQCbzXQbnF9VX45mO8x/vC5ZdpuKo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LH/QC2KYbdVLA0EaSt2HN1hYfiwmkBu9wNVfWmSLWQrnOtzheg4+pRlF2nf41cEH4We8pqRMhAp64bk54FiHfwbHDrsY0Hcw2p6FxBRnnjKkJVGhTzFABhHsxGqnNyr72gBioALa7wA/CTGr8O7NiCxiWK9G1u/hI/ikJjdHTGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnKmHKhQ; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnKmHKhQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccRTXE6SSA0mZHa9xpWOL4vIGo4ApLDkCBB0rm9yaV/wyWJ7gmRml0cUfRm9Bv60wkmhD57VlnD4ZZEipEwM1v9MbVCPVptu6wkyTCIQmde/J2mOTC3NpXb3FvTq4DBiN5avc4aYgyLuXl9zn/WG1cFKcGlLC0nV9p4CKNTAx0uEu1Pnz/ay8vNtcn/3t8QTxuzWTbyw386PYizj9K4jGb+mrVxnY0DoRTDDF0x+VKSuOMEYVUFDo1HdAI86SWTyi5gOm311mo8wmTP1YUsfkWcSs2KPeBPvQXuXsPCNdzzoETao0+HcWU5o+eV2UFdH6pSEOxSPgbkzoeDSzMLYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z69vhUoq+aLaLmaN029RQqKsF+KldoRTK5772KwaTfQ=;
 b=j19dZco9Y2h7Kd5opA4tuI+0VSx5jIVbCYNkssCiM/axxldm/x8xN6Si6lLwb6spQNemn3o9NWiwb5xkI9JEcMAPeLMc9qqtqVFsQamyVJf7HL7EuklNRGsVXXoTAhSouKTWSzdaQFAsXQkm3bz2NUZxG1g24SR50xXywcIbJCB2qyDnQJ50aPmcIMeYkRT5vsrIWkgRTZhncRWOdexazXNxf2CZ5oX9VfsVSaODOFzkWCADI+IL6UlDRh5+yxtgbZyse39CwxNgNDgmJ1rjGcR/IS64F6tFR8uybGMGhzsJckcPOrFgZV8J+SegLOhg0NMazOJDvwg5cQwYAaO+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z69vhUoq+aLaLmaN029RQqKsF+KldoRTK5772KwaTfQ=;
 b=EnKmHKhQT9uciJokt8WZKHRt2tl5NLo7+N1oEHQ3jbWPAOgOFavobiZf5E3p6oNjI5BtFetoWqb01DTVGoVmlMZW57dY4S8bdwO6iLdmc+KxDA3dPuwZdSpQob+RMGE3CSRUEiKhAshX19EF8777F54nBQgsSNDuP2YGtf9bNajDlQ4WUrS2OyP/O8wcKZ+zbXmcwalQT0mzvHp/45qDKluFrUgAtM6W540XmjYPTSAtUpFZGtBcq7U4Qxd8YvQtdP9AVtKRc5u5nYCg4iDBOlhXBa00UJMUXD9maldObky6JpOYBFohZn6a/abRzzU3QcRC+ha+T4/jaFzk95bTOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:02:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:02:21 +0000
Date: Fri, 6 Mar 2026 16:02:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: tj@kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, changwoo@igalia.com,
	linux-kselftest@vger.kernel.org, Su Zhidao <suzhidao@xiaomi.com>
Subject: Re: [PATCH 4/5] sched_ext/selftests: Add bypass mode operational test
Message-ID: <aarseQkKjysu83E3@gpd4>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
 <20260306140325.2710927-5-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306140325.2710927-5-suzhidao@xiaomi.com>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcc1aa1-bb05-4b13-5a5a-08de7b915dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	pPgmvlvUdw9dQ+HGqEiifxkcey3HiTkSAwSEjwoG8KDLXjuDrRzTqmvwShA8GW3+td4FMVLWE0QRpTVrM9GeXQXmyejN5HCqOmG91ZlQcTMekX9u3Bgis5JdR+o0hvfsgZmdbdVUkB817fVNFpDHYDafaAi8xnCWxXEmtlEG6DeC5zwcZxs2/rEpZLDjmeBcVgcDznz5vns4t/MDBBxiE2h7C3yZ60hvmuxa5/5uDXNSyH0cspza/ZcGZM703Y7khQOiege7wEubBK8LPciTKK/1enLdZ18y4qPTuMbCJ592D74PnO2dRWG0YcRxBwF1/PY9yBTYoAq9Kfkm1Qy8mzbhKXoGAWX/24bOMA8tOUfwSyfPdiRI1NN7DHJGMkC7q6s7PV6LwbwSkTT5hxiiIrbDP5QJkiKe9hA/ghTDAEJqq61xi29rRdsAzhbYrNdeYqtDZcuh7HlH9fJj1eOAeJmt1o21/vHld8fjf06IWK4F9sHz/UxGdwsg0D5EjRAZdRb4VZ4mFwKq/03H9G0fubVJjC8rRyi2RGPUPYKB/05H3qkrNpIc+c+UwWuFnKzqfde4zYWFS1QrGVIerFlrJjLqT9qT/23ZlWXasnQpLQdX7J6OZoqe67DWjLbQrKvr1mDbfyzQCDTqBj3k6andszw4qC6zzv7+x7W6P9I/Tj8dtxZbDHFnwHLJOMgRB8Wd+VN9PXBggCqE9hNAcTckHScbCfTbQSakX+VDKeEfdj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//P2ahZS11Na009gkhmp+LzyJsU/qdP9xMNdbkad6EZSYmNprCxy0OOPPRDp?=
 =?us-ascii?Q?J/ptrAkDTyqh7um9kMuaBm5ZHkpCFBUcrQESgZQkWwD2h8hL4l+gLaZW84Ct?=
 =?us-ascii?Q?C3kvPbqgs/RlK7NXxs9DjnwbjtnYynQCe35Ek1t3hCgYfCZKVUQvwN8i7zn7?=
 =?us-ascii?Q?SgPjRLonup2D6x51b6FVkcq/Cuzxx7Hb+7bz/+XA/HbpFhY4W4BuUPxy9FAe?=
 =?us-ascii?Q?Y9kEmR3SO2Kl9Qx2ZA+oaYqGq0KYocHVYJWR23CqsdzU1Zf6HdwYNLcwdtlu?=
 =?us-ascii?Q?Emb52L7VWdKCaWqJ7ZwL/ykyCuki7sVNVxTwIy843DpIrAA2gUY0HHl0M5kN?=
 =?us-ascii?Q?iFagB87BWzsU32zDOxMbhroq7xCHsnm9TxoPkBaE5dizZ0PAet4bQqttgYIe?=
 =?us-ascii?Q?b//0v8wyYDjo77gELpC6GheZ0f6Ee2EwThCG6YQyGQXB7mGUcbsVFneQLU5J?=
 =?us-ascii?Q?5WgUFsbBJwfz3qI4Y4Cno5MQ1Uml9GHcIDYbYYanBbIyCvNM1QHtqwITBujx?=
 =?us-ascii?Q?lwK20NShPm4h93e4hena/NhjoetyD+7P6o1Tpd8Z2rT81KxsmZZemy82RQtT?=
 =?us-ascii?Q?rYG6seBhGfsrVjT0kzOK7v4mNcjCVPhPJXNbId6thjOBvvHqCNf6X9xxo/9M?=
 =?us-ascii?Q?vnnMj34i+9tL1GBQ0ZCWxDFgihM/8q8x4Q+UcfI+t9NdnryCq5uC1tSwkR43?=
 =?us-ascii?Q?FGwocAUkAV3S5yQyU3gSKmr20ngK2cG8br7lb/RAY4edWST0SxkLD78yB9k5?=
 =?us-ascii?Q?81Ou9Bt4itrpZsaJcTqs/nS1ZhgMIOEcYI6oQG8zY3oEG04Se6lnW80hZ9AC?=
 =?us-ascii?Q?sK7p5TaqPXuH/GXPX2ZlGiFuBK6mFAD29g+CVWoX5uvwSPMcXMu6mKfth9Co?=
 =?us-ascii?Q?PhzzaM2f+3pSxRAwpS4y530ZyNi3oIMZsUL+b9/MiNWgaiA49cHeZj648s+x?=
 =?us-ascii?Q?Wx9i9B7ILoLbaHSb2IkUGq7wyUYQOXMl2xEON26kPnXOdlPi9QoOELdacmLn?=
 =?us-ascii?Q?456KfXPLXyG/FULtDUxLyMbN+p6QyxSWPFwg5jyP7TSPCCFOaBpzhWOuufcz?=
 =?us-ascii?Q?PXLr8BTKa7z9mNzl7XHQxjKqboYiP5/8j8N5jmmRUD6+SXadqxp6W/fxbGa4?=
 =?us-ascii?Q?X+6nKahJK9B6bvx5y8zQO6196Qv8Y7DzU97QK6pHAO7F/dErXZGSFFlhRu+k?=
 =?us-ascii?Q?kX9RiIL1WJR0YxVN2BlIl/pc72/Xb8kWNc2UATlCvLhX3cfdyNgbTO5YN94+?=
 =?us-ascii?Q?JXNiur9LnK/RWiSOFRij2PSUBnckNDE72SYz/auf5osqROZchiD3OCCeTWrL?=
 =?us-ascii?Q?tSw90bLo+EdrlLrC1thmXXMFYWDqIBLobqDu5lrpymdcxQJg17865iSPItRJ?=
 =?us-ascii?Q?1jX9UJWRqLMHKgvpuMSCGkXhoab24p1gIssmdi9aX4+J7H72mjp1qqFGdhce?=
 =?us-ascii?Q?B4SZuyEpPqFdhQZTgL9NacONAdbpLZAsQGM975+ynE5axk79bRAY+MOpUqIv?=
 =?us-ascii?Q?Ok/RsRtogCr4W9SKHavYpt2qKgvyBkVFOndFpPCK+z0/kxtzRfhleXQ9jIs3?=
 =?us-ascii?Q?gJUnau3wwrmOXnWVNWoedS2IeOatmQDdIA1GNsxpWC50iv/JSKB0qc6zaICq?=
 =?us-ascii?Q?3eW0bSbmpsV1CRcA9tqZvK5doDJTvXDIcT6UEi2dbeTVnyvKJFrl6w9isk4/?=
 =?us-ascii?Q?dOWI5Z5ND6QmvT1cYjYf0I7a30pConc9ufpMhBKH+fUYjRDdsBjd5caX+khQ?=
 =?us-ascii?Q?cMWKS2RIDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcc1aa1-bb05-4b13-5a5a-08de7b915dd8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:02:21.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szyoFMOobGUltphSE/hqBdp0G9u+K5dJe6/VfZazDkq7ysI5mTYxpmY+EZhUYvv3kPzeKrsuIri2P86MFtrcnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

Hi,

On Fri, Mar 06, 2026 at 10:03:24PM +0800, zhidao su wrote:
> From: Su Zhidao <suzhidao@xiaomi.com>
> 
> Add a test that verifies the sched_ext bypass mechanism does not
> prevent tasks from running to completion.
> 
> The test attaches a minimal global FIFO scheduler, spawns worker
> processes that complete a fixed computation, detaches the scheduler
> (which triggers bypass mode while workers are still active), and
> verifies all workers complete successfully under bypass mode.
> 
> This exercises the scheduler attach/detach lifecycle and verifies
> that bypass mode (activated during unregistration to guarantee
> forward progress) does not stall running tasks.

I'm not sure this selftest adds much value. Implicitly we're already
testing the validity of bypass in the other sched_ext kselftests: if a task
is missed or gets stuck due to bypass mode, we would trigger a soft lockup,
a hung task timeout, or something similar.

> 
> Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../testing/selftests/sched_ext/bypass.bpf.c  |  32 ++++++
>  tools/testing/selftests/sched_ext/bypass.c    | 105 ++++++++++++++++++
>  3 files changed, 138 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/bypass.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/bypass.c
> 
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index a3bbe2c7911b..5fb6278d3f97 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -162,6 +162,7 @@ endef
>  all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
>  
>  auto-test-targets :=			\
> +	bypass				\
>  	create_dsq			\
>  	dequeue				\
>  	enq_last_no_enq_fails		\
> diff --git a/tools/testing/selftests/sched_ext/bypass.bpf.c b/tools/testing/selftests/sched_ext/bypass.bpf.c
> new file mode 100644
> index 000000000000..cb37c8df6834
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/bypass.bpf.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BPF scheduler for bypass mode operational test.
> + *
> + * Implements a minimal global FIFO scheduler. The userspace side
> + * attaches this scheduler, runs worker tasks to completion, and
> + * verifies that tasks complete successfully.
> + *
> + * Copyright (c) 2026 Xiaomi Corporation.
> + */
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +void BPF_STRUCT_OPS(bypass_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +}

We could also remove bypass_enqueue() and sched_ext core will do exactly
the same (implicitly enqueue to SCX_DSQ_GLOBAL).

> +
> +void BPF_STRUCT_OPS(bypass_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops bypass_ops = {
> +	.enqueue		= (void *)bypass_enqueue,
> +	.exit			= (void *)bypass_exit,
> +	.name			= "bypass_test",
> +};
> diff --git a/tools/testing/selftests/sched_ext/bypass.c b/tools/testing/selftests/sched_ext/bypass.c
> new file mode 100644
> index 000000000000..952f09d76bdb
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/bypass.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Verify the sched_ext bypass mechanism: spawn worker tasks and ensure
> + * they run to completion while a BPF scheduler is active.
> + *
> + * The bypass mechanism (activated on scheduler unregistration) must
> + * guarantee forward progress. This test verifies that worker tasks
> + * complete successfully when the scheduler is detached.
> + *
> + * Copyright (c) 2026 Xiaomi Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <sys/wait.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include "scx_test.h"
> +#include "bypass.bpf.skel.h"
> +
> +#define NUM_BYPASS_WORKERS 4
> +
> +static void worker_fn(void)
> +{
> +	volatile int sum = 0;
> +	int i;
> +
> +	/*
> +	 * Do enough work to still be running when bpf_link__destroy()
> +	 * is called, ensuring tasks are active during bypass mode.
> +	 */
> +	for (i = 0; i < 10000000; i++)
> +		sum += i;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct bypass *skel;
> +
> +	skel = bypass__open();
> +	SCX_FAIL_IF(!skel, "Failed to open bypass skel");
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(bypass__load(skel), "Failed to load bypass skel");
> +
> +	*ctx = skel;
> +	return SCX_TEST_PASS;
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct bypass *skel = ctx;
> +	struct bpf_link *link;
> +	pid_t pids[NUM_BYPASS_WORKERS];
> +	int i, status;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.bypass_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach bypass scheduler");
> +
> +	/*
> +	 * Spawn worker processes. These must complete successfully
> +	 * even as the scheduler is active and then detached (which
> +	 * triggers bypass mode).
> +	 */
> +	for (i = 0; i < NUM_BYPASS_WORKERS; i++) {
> +		pids[i] = fork();
> +		SCX_FAIL_IF(pids[i] < 0, "fork() failed for worker %d", i);
> +
> +		if (pids[i] == 0) {
> +			worker_fn();
> +			_exit(0);
> +		}
> +	}

There's no synchronization with the parent, so on a fast system the workers
may even finish the loop before the parent ever detaches the scheduler.

> +
> +	/*
> +	 * Detach the scheduler while workers are still running. This
> +	 * triggers bypass mode, which must guarantee forward progress
> +	 * for all active tasks.
> +	 */
> +	bpf_link__destroy(link);
> +
> +	/* Workers must complete successfully under bypass mode */
> +	for (i = 0; i < NUM_BYPASS_WORKERS; i++) {
> +		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
> +			    "waitpid failed for worker %d", i);
> +		SCX_FAIL_IF(!WIFEXITED(status) || WEXITSTATUS(status) != 0,
> +			    "Worker %d did not exit cleanly", i);
> +	}
> +
> +	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +	bypass__destroy(ctx);
> +}
> +
> +struct scx_test bypass_test = {
> +	.name		= "bypass",
> +	.description	= "Verify tasks complete during bypass mode",
> +	.setup		= setup,
> +	.run		= run,
> +	.cleanup	= cleanup,
> +};
> +REGISTER_SCX_TEST(&bypass_test)
> -- 
> 2.43.0
> 

Thanks,
-Andrea
