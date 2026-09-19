Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9D305E1F
	for <sched-ext@lists.linux.dev>; Sat, 19 Sep 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821196; cv=fail; b=qVjVTKKWdCgzHM3zpHDILpurhfLsdXlBwCwHMbdmK6ZP95MQvggHd2WgbTS4WyxL5fJ06wYxOQRIvo2dYqcd2bT3tAZDlm9QrDZcTc7sb8Ae/X3FulL/9zhJm4G0oLj/fi0bDPjv8g5DJ2AKnOImADbvCo9gFcfwxcQoPpt98wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821196; c=relaxed/simple;
	bh=EUgR8RZIe1N515qFDP/R8GKiFMic3eDKic7Tos1vnLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FPmOeKUy888X9YCD68qLhiiAGPGjUU+myUu/mSqg1CxgwiBpcIf457rl/FcbcTUV3sdYYRC/o9pZ0GuokzZxRgOUFnNu6xGe8Os+YSx2HYf0CpIBkBY1xDFWPoq5WSUVdE33xh0o74Z2v6Rfv/0xcu1nWdgz/Ox6Lvl09KczEzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTsSCMjK; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTsSCMjK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ5iXYvkSr/fajXuLtrYLGC9w1FaoM8TRDAhZTxcFh+T4xLOImmqSznN8tCbBOFu8Nog/8+oXX5cRjMKhNTDBst8SDIy9ztF1UR0ZFaQ9l80NAN5dEu8ROioo1P/T5iLcxF2qNI38+vKpfeywKqfaIidFHIngRLYVs7/o1xbB2GE0l73PFI9+2sscfLSvZcD3lMqadsNjfRih0PNuacq0WzHYkHYBA2JFR4XQpnNeiXibtttqbBQp78ACmZVTIyutNA5+sSItGJ+SIIS76fuB3yzdanhSKI0wsrt15fffMinEPVZCRb4FI9DgBvU+TOBpJsdxYNOF4f9dIGX/HpwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTgUUxe9oR7DwXjviQOisUG2363FVQ1nZIJC2eHZpCI=;
 b=uBJru0mSsL5W7MqSYqM7huD0ftq4YgwvQQZypId/6b4hmUpku25DQv6w7zIBL8D6GSX/Dos80fkZ16z8dc8/tZKJiouok7M3W7na0L6ognniokX0+aZZYu2UA4kRAzpIGTHVt3JeX3Pcl8twOusbaLiJ8+gjmdz0nVkSvHesJlAACOp7uqp/ZCTCb03PEPuTXE6XVX5O2MQMBnDD4zt0rZALpVgaz56yc7jSvFG/bk8HnNBL7XjUAPfBSCBiCjaC2UXT2dXjLtIQaKS+4fuM7EuGej4P2mMXECDwJ4h0SMkdnKbjlGebVKFXsWCo3SdF0CLV77gmRl3zj9ukjXF4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTgUUxe9oR7DwXjviQOisUG2363FVQ1nZIJC2eHZpCI=;
 b=JTsSCMjKgoG9tNPIkmFdTTtf8J21XfV2ZuQyiEk9/bmqPuNgH5/BQC+I6Lyv3p9P0f2HC0LnD8HfLaEpyfC3PE8Ce3vG1lTpzYD9fjvJIvnqWxD84bJaazH1UQDJU1404rmur+dxtoosqcox6CaDJ8uUI4lWKvv3SCxI89qlhigKFx23IGg5rJ+vRq6peV8acQhSKVYCrC9AEuz0BunsooVh+C1ftRmEpT8fEoXsCkLHUJB8S3hDD0Y96LOwTkNuTeWEeskOqGA8S9VwcH2Q1ahxEIYv4rErYa4hwDK8Oa1S+SdimlAsX6JRl5FPNw/e8QQ/4qLmuCRoJ8dQoHsJ5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 12:31:04 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 12:31:03 +0000
Date: Sat, 19 Sep 2026 14:31:00 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Check the cmask cid-form
 ops.enable() receives
Message-ID: <aq6AhO2dGJNN8ZvB@gpd4>
References: <20260919002838.1960071-1-tj@kernel.org>
 <20260919002838.1960071-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919002838.1960071-3-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fab069d-b7ff-44f2-467d-08df1649debc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|6133799003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	gbuSnX408j1R0e/emAv3ZpDybO1IVXS2UVsbt56XKgXM4Cb/WWYUgykU8y58qc0Czg+rmXLbLMD7vCHfeoSRqK+/oECaC0G3Rl/q2d6V6Bf6Z3WfMpRKc+bd8hxucb5Nzg2DI2pMUQKSuWgD337VrwjNt43tpQpXtcFX5jB/+e6sX14VgJSy1GNqUvKqOla33ZVDrKIOgtzTh968aVjEA8rsTAkklS0z+R91BAX+dxKZGYwZGguOLM1oG32yGmyEIr8ZC5ox0eF/C6O1U/ZSlZjYyCG6c/uADMDQD8a8XIKuEz11cp6fcPGK752UTa2wEmJ6tZLm9k+B1GomlUromkmtP/stgeyxRuCsTAf8buUW7xEXkamwQLWB8vdMBWwKH40MngASy43lwn/0WqToEP93u7rkG9qpIxg4rcLhTGSqCzTjjWSFKXi9fmESuU7empRhdpddDRQTU5DItEzhRmwVU/+hHTi4AblwPT4mef0wdZmrV+ADD0H0eRfXU5BRVE1tvsNd04Kwbu3S19MJto+UJJTmXcGAdJ2LJS+zEganDSHanhdzbOJZCvaOKmwwT7eyL6bC9J7TpK0W1UEKXpM+sjrkRhD+hcX3GGtVoX7b0ksMxwETrDNuwXBWKTYQOFIWmaxoiIiRz9L4iFDPIPknIkS1Uqa1V+nLhha7WYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(6133799003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3SDJQ7JAuxmbvMnF5oyKVA+nb+yddOawrppmFB/SHKPEkrgRl4J3gpMS1by?=
 =?us-ascii?Q?ZZm2V/FgoqCPS6dB23mcuQBqGr5+GwYqi5IhK4D+VsOG2JXMCd5wMEzzAqUk?=
 =?us-ascii?Q?pigzZA87WrzeKgS4adkZXblbUuotdr+kX3Sb/EdGSS/lUzujBt/wf7beWv1B?=
 =?us-ascii?Q?6MbQRGhUr0zBPWzNc3vy03gkkuFY3WRDanyigggEzTTVd85mHkkno9CuuVzX?=
 =?us-ascii?Q?m1Vs8YOocLI84cq1TZcrxku2fOrU4qT7Z2clMbp12lHUXspWHLDKTv2zYiES?=
 =?us-ascii?Q?oEQtClTO5K7rZLDkyN7Gv2Cqn1k697om39JFoqBd3QY4rteMZstILIYR/KZ2?=
 =?us-ascii?Q?VUc2/1ynIi5HvXfv2RVprB3EEkBiY4xF6pyR6Sd0o3FxLiIj8cFeQQ+j9NG1?=
 =?us-ascii?Q?9oFMjq8fu+7kT6OO2PSe71xN3bFGvmWB6oDkYOcKnHdeZqFMgBQXdvfFhWL7?=
 =?us-ascii?Q?7sMO3fgkGnG+u09AZuJpC4dHH+mJ5VtV+WtVWskTgYNmEu18cvUUe4c3J5eo?=
 =?us-ascii?Q?iN6FNvVJLPfMkf7gmmvIADj+8GidMUv5Y8RHpjtaLKotvZZhJ1+VXBNwDi3w?=
 =?us-ascii?Q?7nHPI4sjgDzvolcXxmgdKlp1mygbhmDm2KB/EiF+URh08kXzPNv0xHxpBpZX?=
 =?us-ascii?Q?qwPVLiJxMglYoBOVuaOJiIC30m57eaet2Q4i28Tp2yhYktxlhgveTrNDzzs9?=
 =?us-ascii?Q?IWbu5c1TIYVOYo2Tp0j5CINVqAs1aLGfbM7OHNuLRRAzQYGrojZ4IEUJoOSr?=
 =?us-ascii?Q?f2iHp3UiQVFX0Gzmi3bVTl27lK+exVL+DNjtHnXxnBSj1qUrBx00MjrsiZ3y?=
 =?us-ascii?Q?hwwYk+HlHKS96P/Al93KL+C66xdyhTAw3lCzARrykjTyVjl2nYxxFizBxdRQ?=
 =?us-ascii?Q?dFMyncP3Gp3u7WhFeuuVc3Gn2qtP+vYP/x8mNgkj4QEzsvhRdxBdUHop+lXV?=
 =?us-ascii?Q?C9NJwrm0fIaI9wR38AjYTi86pKPoJyJPwFnAkNd7H8ccNsLWAZftHJED3GJ1?=
 =?us-ascii?Q?OTNt4Pq47CqwYLe0WvG1Q0Vr5kxxLfVRiM8e+m1AG9zJdX9tWXBSh4NDtFrQ?=
 =?us-ascii?Q?rt8KZNL6M/RnpQCZT79RgrN5FaXS31VM6h5t0dXEJV8t4516DXzFmvzyuk6p?=
 =?us-ascii?Q?yG39K8lZHn1Z5B6qvoxyaXxBUJ1op0Lta+rxgPdYYFh02Coe+C2gODbo/RS4?=
 =?us-ascii?Q?rjrcX0fLqVfc3BNgJROAy5Val93Py8n608bpbGC3faJjmRMBGaR7eYDSLjEv?=
 =?us-ascii?Q?fy/L554Biwrfh4BHJIVQExIC5ctnE4oRQRauOEbRl+NlFRvOdxSUW8+h87z1?=
 =?us-ascii?Q?4boA763EMb0AqdvOSLaN8eMaPh5x9xZESsLAnFRv/I0NXPC/Os6g2FOBwPW2?=
 =?us-ascii?Q?s6mI2z4Zc/Pmdq10TSAL8GMVAW/rw1FL0D7ywKjEWhIzrj83OHnvMv2qPO0K?=
 =?us-ascii?Q?K4pNbV9NlWQ00+GJQSILFNOo5NP91P9b88nB0SSRrG6HbQRJGam0pug2dwYY?=
 =?us-ascii?Q?IjdsK5Qzl6b0aIU3Tdbpri576iJUs8A+PXrwzQKngbMVr33MFckdG2zv7iUr?=
 =?us-ascii?Q?rlJR/SkM1rJGJgu9p5N32GEJTCQAbws2yxvsBI7e7/51of6BK7+6/VN8Vb9/?=
 =?us-ascii?Q?a4Zdsz9miNXMMWDDboDREKTLhwtaK6O/kUEAMhJ2gyqRn/tHXNvqrq0mbu83?=
 =?us-ascii?Q?Xu6vZU9WUduJo6HMlH3ixOLb/Rf/8BTK2JlBacg/OaBY1USw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fab069d-b7ff-44f2-467d-08df1649debc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 12:31:03.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUDRG7RXlzAvpNuxUE8Iw11l+uZ2IPfbMS2+QomlXCNdzMIgQDPXSzA0UludtgVxuFxncDU4OxL92mJDc2r1hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126

Hi Tejun,

nits below.

On Fri, Sep 18, 2026 at 02:28:38PM -1000, Tejun Heo wrote:
> cid-form ops.enable() now hands the task's cmask to the scheduler and
> set_cmask() repeats it right after. Add a cid-form selftest that checks both
> against p->cpus_ptr, that they match each other, that the initial
> set_cmask() lands before set_weight() and before the task first becomes
> runnable, and that set_cmask() never precedes enable(), across class-switch
> enables, fork-path enables and live affinity changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/enable_cmask.bpf.c    | 213 ++++++++++++++++++
>  .../selftests/sched_ext/enable_cmask.c        | 138 ++++++++++++
>  3 files changed, 352 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.c
> 
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 49897727f535..4e06d0baaeec 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -169,6 +169,7 @@ auto-test-targets :=			\
>  	ddsp_bogus_dsq_fail		\
>  	ddsp_vtimelocal_fail		\
>  	dsp_local_on			\
> +	enable_cmask			\
>  	enq_select_cpu			\
>  	exit				\
>  	hotplug				\
> diff --git a/tools/testing/selftests/sched_ext/enable_cmask.bpf.c b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
> new file mode 100644
> index 000000000000..bbbf989d2c69
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A cid-form scheduler checking the cmask cid-form ops.enable() receives: the
> + * header, every cid bit against p->cpus_ptr, and that set_cmask() follows with
> + * the same mask before set_weight() and before the task first becomes runnable,
> + * and never runs before enable().
> + *
> + * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
> + */
> +#include <scx/common.bpf.h>
> +
> +#define MAX_CPUS 1024
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1 << 16);
> +} arena SEC(".maps");
> +
> +struct task_ctx {
> +	u64	enable_fp;	/* fingerprint of the mask enable() received */
> +	bool	enabled;
> +	bool	pending;	/* enable() ran, the initial set_cmask() hasn't */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct task_ctx);
> +} task_ctx_stor SEC(".maps");
> +
> +u64 nr_enable, nr_initial_set_cmask, nr_set_cmask, nr_set_weight;
> +s32 bad_cid;
> +bool bad_want, bad_got;

As Sashiko also reported, these globals can be written concurrently by
ops.enable() and ops.set_cmask() and could make a failure report misleading. It
should be possible to move these in a caller-local stack struct.

> +
> +UEI_DEFINE(uei);
> +
> +static struct task_ctx *lookup_task_ctx(struct task_struct *p)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +	if (!tctx)
> +		scx_bpf_error("task_ctx lookup failed for %s[%d]", p->comm, p->pid);
> +	return tctx;
> +}
> +
> +/*
> + * Verify @m's header and every cid bit against @p's cpumask and fingerprint the
> + * bits into @fp. Return 0 on success, -EINVAL on a bad header, -ENOENT on a cid
> + * without a cpu and -EIO on a bit mismatch with the details in @bad_*.
> + */
> +static int check_mask(struct task_struct *p, const struct scx_cmask __arena *m, u64 *fp)
> +{
> +	u32 nr_cids = scx_bpf_nr_cids();
> +	u64 h = 0;
> +	s32 cid;
> +
> +	if (m->base || m->nr_cids != nr_cids)
> +		return -EINVAL;

Since this is checking the mask header, should this validate alloc_words too?

	if (m->base || m->nr_cids != nr_cids ||
	    m->alloc_words != CMASK_NR_WORDS(nr_cids))
		return -EINVAL;

> +
> +	bpf_for(cid, 0, MAX_CPUS) {
> +		bool want, got;
> +		s32 cpu;
> +
> +		if (cid >= nr_cids)
> +			break;

Can we iterate directly to nr_cids?

> +		cpu = scx_bpf_cid_to_cpu(cid);
> +		if (cpu < 0)
> +			return -ENOENT;
> +		want = bpf_cpumask_test_cpu(cpu, p->cpus_ptr);
> +		got = cmask_test(cid, m);
> +		if (want != got) {
> +			bad_cid = cid;
> +			bad_want = want;
> +			bad_got = got;
> +			return -EIO;
> +		}
> +		h = h * 31 + got;
> +	}
> +
> +	*fp = h;
> +	return 0;
> +}

Thanks,
-Andrea
