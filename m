Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CF34A3BF
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641627; cv=fail; b=HC1gftrf/FEoA+6IlcrPBRTCrqwhgKVx2o5qU5mqXgdkwsTnT0mqqBhzzCMJ8DcXwA28YXsBLH6Mnc8FpLa5F1sycCmBcgVtB2GAG9ot7muwbWzmdhPrOqeEQ+i0U4+FKmShQXjAxgfMM5VQjh1zLDjo8hQGHjQTLgH0ZfaiFco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641627; c=relaxed/simple;
	bh=Z4HEMPOUz9BU6RMJZuGDwHjatlGXaRFgr2P6LTY74Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJ5efq1z3dxLvGwKDTog3jZar8BiCLEDCN2w2Dk7rh1PoiOY3WPJMs0jxszfyfHC/MqSscKABovN8X5F7XFLCd+WrzwBJm0ACGRn6heVkFQjYkQoFyqGutWE0Big78LLY6Wu/B+OEsciDVbS8+7Vd/92V8sHkMEUoyXWKD0lKuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBRs18mx; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBRs18mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYjr3ba6e29pVLUyp0l1sqPuKPVrGcQAuroBUMzkA9rjLqSgtn8Q/7n7JALXOB8oiXPuLArbh6WaqCZXz3j/I7LO9MptaaBwM3UMe7EFClzofmsGih7AGRPvRrAbl2NOLtG3PP09l8oqQ+39ppBwJyCPvkVHxsV4TivK/H34j+tywxkhkYovXoY3fT1vdJuOb/ltbYC9vja3e4Rs0HJ206Ei849RK1Hdl3lC2M8dpb6XbhHXfbuPILuv/VXu+aMO/2BbaYdUUyPalCE1W9h12Nj0Z14b8Fc5nJR+cHS5azrmf5+D4IssAgDiYa/UBwqM1MrEMjMyyB/J10yl/w0KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3CVYwABY6hy7sELt3DJ3+H8X1aU8AnhlOEq1DY6ooo=;
 b=V6+ophq2n2a7TD3Ttyxi7kXJKJ765ZZM9RKu4rb/5eQf86AFcdK/h9YAKEPVsXcEgaHgxWZKSFTpn24zhwRaANSidl3tCsP/iDfyTStsp0+UIjvTf0kj8sgz0YQdUp5NTSEir/H+sl9pgUC7r8ctopFL+u28ZwXWypcUOnaL4vJZOQanJTZgof/Co15JHIWvwQNkhG1w0yCe6QU3hDFhLBv+kWpK5US/5866nX4QQxDag1jrR2A4RdwbuH7RfuqYgO1rPV1eLz9xY1sK0OTZqtl/4pf1lZPA1B75Qr0JQ7M2yTNQbiSNPz3QbXl5JyMTEPvsuoJQ7iv5nkpflOQ0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3CVYwABY6hy7sELt3DJ3+H8X1aU8AnhlOEq1DY6ooo=;
 b=IBRs18mxuhOEeD/43vewKyn9CpfdS3B4ZBP/OQ3Kp0ACkFoILOnX2uLP4z18q/oE6/p4Ho/MskTBL5PKoaGUkQ6eFvz2009bXa6LjtwN28SoBaU98c5pz6G6DozUghjHvBnuHuSYqFpMnQtps1FsVp2e/0B6Kp5+DJYHYKhiMT9AlEprBp5T2XeCyIoGMzvqKtq8kLHLEhQMkPLU71PWB9WWbh0x1smL/m6a64NRhe8UybrOTciuJWqCy+VuAE/0EJyWdJtCKmZcEuLPQioywpiy4t72QEq1O/Lzux/QAy9KpuCXwq66zIGnq9XKGVJBCobmI4wrPBhwJ3oR9Utq/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 06:13:41 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9700.009; Mon, 16 Mar 2026
 06:13:40 +0000
Date: Mon, 16 Mar 2026 07:13:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Use kobject_put() for
 kobject_init_and_add() failure in scx_alloc_and_add_sched()
Message-ID: <abefjW5_L1Q3x5Xz@gpd4>
References: <20260316054328.838304-1-tj@kernel.org>
 <20260316054328.838304-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316054328.838304-3-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7d80d3-9b1b-484c-983c-08de83232b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	eZflaLSejw+orZwufVGGt8DwnhKbKls+LNdPRDrR8gtt0BdnST7Y15uPuKXi5TbqrI0VY4zlycuR0O1MM66vEQdLJDdzyDaNyXIx+FNxKhVq61tDw+yl6CGmocSjlLnYWC48g84Czv6cNyb15LwcNeRwkbHmrYUoN7ix1/OKgmj6CXCkc6RvE+D1Ei0v/Icx7rE0smt+3R3zBCcKaeqRltqO3eC0bIWjSNqXKjP75kJQGTo+t5rZpvGNjFa0NhyaZpywoUOidNlMUdQMrJ3ogyiTOU437RpviyzlFpMlcCPGrSbZ+sO2yptk3/sH1iRa18HjDjgA++QxjX+mj04L2r6SGSUWE6dDzXJGQuAAUX9BEzjtVzOCO3SWa1qBx17uu6nHTvn1Gj57ChLQYHyTQtLgIkKtmqwb0ARJOvqveksXck6ZmIJEMQ7qAQvzgEjgPlBpm0C+iPcr8xcDV9B1eT5zWVQ0+v60CIbZXj8YybsGNKwOp1ZQ5EyBOqKIHsx/pTtrOs6Ns1j1D46bHI+ZJkdBktZiLo0KhXHcBTi6ecJyzVxhtOPcVNaN14IHLRSbll93WKAvZoUS/OSoHcXayyLxKT70DgC2DhgTF+/TpaDyc5ZQc8cy1Sfl0SMoQ8bc4mGzAxWLXPav9vvEOcrOxm35qKNBRfUCY+I9axK6MrSjVYTLpuARLfHGXuZkf9MdpYVRepfqYUcVQkfRpO5/YRkDFbg08g85hUKYBNSr4sY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ySh5+TkLKRmL0jurUPNwqUQv+qV57j9Vc062TH8XIvLm7kGKtaaWzxaJ+lD?=
 =?us-ascii?Q?HV8fqS+DUWiNwd4JFMERbtsIkn/tWSyjb63TPYn+jAnJC2l53tqxt5hg8vua?=
 =?us-ascii?Q?RQ9it604Gy9WeDbJsjBDOfgMBhS/GeLqjH1ND+MMepAfGjRxi+Yp9QlnSfPp?=
 =?us-ascii?Q?kBwSDJmsF7IfPSnaanpwUsxSEyDj/s2maK5JGB+ugYc4zpxdFYqbK+9J2/UX?=
 =?us-ascii?Q?KD594vfP6zn6cti9jug1g/UcC1sm95L7KiP9/gNh5h3mLwirQlcfo09W5EWj?=
 =?us-ascii?Q?kyLhzoU5JFEfDgyTnnNdkEAn4wRxDCLIw9lyRn3PWYxmXDBpBxEFyWmiIbU7?=
 =?us-ascii?Q?HV8HIxuon7J9LZRVRV4lMxrpUyvKx9R46Tluzfrz5zrtwTWx5zqoudJsuGLO?=
 =?us-ascii?Q?qAFhbo887ebo94pJk7l+ZfLrKPFah5VsZnvpIQt5Ww3BXQA9Kkw0ewrolyfQ?=
 =?us-ascii?Q?4yJbow0xXJQy2S1WHaauiX1KvDB3Lhw9qUuC4q4RmoPCJaLJVNw+ZrKwQmz+?=
 =?us-ascii?Q?NhDBiuzhG5aKGi2WvCKu1CfMPse3zdLXslyLAfIjrJ7lLaco4ikTzjuVnYOw?=
 =?us-ascii?Q?NDOoyLXYIumZ8VyWPmu73jHRj5dOkJai6aSPh7yZDc5rg2CaPoIIZxTxPvMl?=
 =?us-ascii?Q?/eyz+gDwMB5uBG5zOFxN4Z2JUGyUw2ouSntXRZLc7Quog6flyff2bV6mEb6j?=
 =?us-ascii?Q?BIu+ccxfjg5jsVnNZvhxSNfZiYVsEuChQKeAnWlFB/ZseniKAoGvQQDnVWas?=
 =?us-ascii?Q?sRUu7sYH/D48j6/vgJLapqNmqP0U8ZyoBGwplqA+2htNTsH4ZoSKKlMUE1z+?=
 =?us-ascii?Q?7MZLMikhEbg2ch0u5eG/O/tgoI1hCqf6oeAGf1sSqSP+XvygvIX/1uTAvBfP?=
 =?us-ascii?Q?PtK2/7xRYcVnmbB04gyuqCW/SDlxW7TBNISAqFgYVtkKkK1dpEN9pnJX2yAb?=
 =?us-ascii?Q?G+Y8ctEcjDFSTlKIl8zhgAg4J/oT7WV1RFYqufHvuFsryhBZIj0X+YcwKc2p?=
 =?us-ascii?Q?o15gsOxUc9SdLYvT9aXc693vR83I1hH2DfdWq3SwPwaMF8ecC1Ig0B5/fMME?=
 =?us-ascii?Q?PsHgoT+qDYczKaC/BC1pmdkG/iO8ykdOAwWJUV4e37UR4L3LSBf5K7VHcWop?=
 =?us-ascii?Q?xZJuMFWYkia/5Hw7fOekgn7LoDEnMhTNsDTvFVblMH/enptoNQ3Jzwdsmcyb?=
 =?us-ascii?Q?vC/GcJ/zdnSkYDbLtCWiab46NN+ovYDl6RwpAGn/z2rcV495oWfTrVSrbh2A?=
 =?us-ascii?Q?0ZrpnZB07jC8TaPWJ6xEpFhf6UjGqVQzFJETl5HDTVwrxj2RWXIXPFUVOUEl?=
 =?us-ascii?Q?zY3XOoeTp4LGOUGrNvTcgmEbkA4veOOtAciat/qfV2gqm7fnMfy5pDcl0yZB?=
 =?us-ascii?Q?6uq0JGYc8vlXdIv8waoc+BTYFZeX2g4pCPZ/59FwF+mBlOgFPZfuI5eBZW90?=
 =?us-ascii?Q?qBzsKOfFb/5XP6g7wHdLgzubjymxwaH7FXCJ3hV6xprzfc87zl+KB0HHBr8y?=
 =?us-ascii?Q?Yj2ylkjJd2PACkWWoo9EF2IlLb7uR+tkyaMJnMq1vhJN9XhBbJWEGUH1iO/J?=
 =?us-ascii?Q?j0U7phr+E4Ckr8yJH6N3/kFNLlq4/xy15FlLyu823jMoGzanP7eRmnKRPUwR?=
 =?us-ascii?Q?uhJ8jO2vuomGR0lAQu2myGsLKpcttFDbVVLm55DCamG9bjUjgKkxX7tXfRl5?=
 =?us-ascii?Q?ofi8EqGgyrt6SKqhuOFJA5zTGBBrqC+9eJSRm3kXolBGd/NTXNPoKAswZ5tK?=
 =?us-ascii?Q?FbxFGFxwXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7d80d3-9b1b-484c-983c-08de83232b58
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 06:13:40.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh06PgpLd375Z5X5MLcD5x2AbhxDF6UNHIE/IUZmQhuw8q8OeBjNnB9PfiLVjnqDhBJ9Fkw7dJ19wpos/BKDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

On Sun, Mar 15, 2026 at 07:43:28PM -1000, Tejun Heo wrote:
> kobject_init_and_add() failure requires kobject_put() for proper cleanup, but
> the error paths were using kfree(sch) possibly leaking the kobject name. The
> kset_create_and_add() failure was already using kobject_put() correctly.
> 
> Switch the kobject_init_and_add() error paths to use kobject_put(). As the
> release path puts the cgroup ref, make scx_alloc_and_add_sched() always
> consume @cgrp via a new err_put_cgrp label at the bottom of the error chain
> and update scx_sub_enable_workfn() accordingly.
> 
> Fixes: 17108735b47d ("sched_ext: Use dynamic allocation for scx_sched")
> Reported-by: David Carlier <devnexen@gmail.com>
> Link: https://lore.kernel.org/r/20260314134457.46216-1-devnexen@gmail.com
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2f70effcc4a6..b942918fa364 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6353,6 +6353,10 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
>  	return pnode;
>  }
>  
> +/*
> + * Allocate and initialize a new scx_sched. @cgrp's reference is always
> + * consumed whether the function succeeds or fails.
> + */
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  						 struct cgroup *cgrp,
>  						 struct scx_sched *parent)
> @@ -6362,8 +6366,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  	s32 node, cpu, ret, bypass_fail_cpu = nr_cpu_ids;
>  
>  	sch = kzalloc_flex(*sch, ancestors, level);
> -	if (!sch)
> -		return ERR_PTR(-ENOMEM);
> +	if (!sch) {
> +		ret = -ENOMEM;
> +		goto err_put_cgrp;
> +	}
>  
>  	sch->exit_info = alloc_exit_info(ops->exit_dump_len);
>  	if (!sch->exit_info) {
> @@ -6468,8 +6474,8 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
>  
>  	if (ret < 0) {
> -		kfree(sch->cgrp_path);
> -		goto err_stop_helper;
> +		kobject_put(&sch->kobj);
> +		return ERR_PTR(ret);
>  	}
>  
>  	if (ops->sub_attach) {
> @@ -6479,11 +6485,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  			return ERR_PTR(-ENOMEM);
>  		}
>  	}
> -
>  #else	/* CONFIG_EXT_SUB_SCHED */
>  	ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
> -	if (ret < 0)
> -		goto err_stop_helper;
> +	if (ret < 0) {
> +		kobject_put(&sch->kobj);
> +		return ERR_PTR(ret);
> +	}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  	return sch;
>  
> @@ -6506,6 +6513,8 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  	free_exit_info(sch->exit_info);
>  err_free_sch:
>  	kfree(sch);
> +err_put_cgrp:
> +	cgroup_put(cgrp);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -6577,6 +6586,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  {
>  	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
>  	struct sched_ext_ops *ops = cmd->ops;
> +	struct cgroup *cgrp = root_cgroup();
>  	struct scx_sched *sch;
>  	struct scx_task_iter sti;
>  	struct task_struct *p;
> @@ -6593,7 +6603,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_unlock;
>  
> -	sch = scx_alloc_and_add_sched(ops, root_cgroup(), NULL);
> +	cgroup_get(cgrp);
> +	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
>  		goto err_free_ksyncs;
> @@ -6887,11 +6898,12 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	kobject_get(&parent->kobj);
>  	raw_spin_unlock_irq(&scx_sched_lock);
>  
> +	/* scx_alloc_and_add_sched() consumes @cgrp whether it succeeds or not */
>  	sch = scx_alloc_and_add_sched(ops, cgrp, parent);
>  	kobject_put(&parent->kobj);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -		goto out_put_cgrp;
> +		goto out_unlock;
>  	}
>  
>  	ret = scx_link_sched(sch);
> -- 
> 2.53.0
> 
