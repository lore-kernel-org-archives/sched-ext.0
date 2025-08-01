Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424C1F4181
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059643; cv=fail; b=PtPbBY1Td+XgHbO1nHeKGRstBluYCjSMFO8JBJwvckFRcKJ6SY/WWIhNnQ0oX5zZgUD7erA/UnoE5CWF1n1P82UHq8UtzR3/8pn8hzdypQRFRJch/JEM77M9DlKUr1ey9eEc2kNJ+seYosCOXHYtrEZiDozlp8AcnMa/dCgXwIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059643; c=relaxed/simple;
	bh=RCOTkbBDKqCBzTt5UM+8wlIwwZVh5MwnVoPhXfNDxTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bRzl3rf4WwnAWNJKE3zuhvSEIOYqV3c9UYi7hf2gkYJHmVvO+MAlnCrQGa3sCvGa2n+Qf2jJUKJ9gcul/Wafj4ijod9iZu2CuTw/7ex/j8W9Zf88WqlNVWXlZfy2IZNoqoveRG1TKDHfV3HhjeqPPwJ2SUJ0iXVpox7Mj2jveaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o3TXQpoh; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o3TXQpoh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxyzDDEP8e6LxEDYfhBJjc3zGglwheIG/jrmyVS4Rav5y5JDgkpb0fwboTZ2A8UoJOyqvZbeSEB876N7Je9V1wfVJnEV5B6p5Q1YeoIqxzpa/RxOmRAID+kEOPHXBZBOGHaSW9H3/eKligWtUkLVFpPpO77r+bRaJXzdsu2MRZic2mEI/G+uuhaEUvozWjFFDlqV6F9zPth+43loIdjagQFxaZCEk59N3VO7qxtYohlHxtbbL39NOohsrVyx+IdOFdAB8MVzIhasQWzKNsC3ceJIYqnLvwErsUUCNIbpg0MK7YXYnZK125+8Y07DPYmBsEZzoFvTbJBLBQ8B9TU+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsbDP2oGreYPCRK5mkrrPxyZIYMupJJZZ4Hh0SzIOFg=;
 b=IBuvOCr3Ne5z+VS8zSH4q880KOexfFOLkmdyn2355HD7uDfbw3RtTuv7K1sL7xj7E3/V/w+/1b96NnppjRdbO0LmGTrv/zgkG3FmDApDRto9zTuszSDc3u6tvcM6zqL4QariYgkd0u/NnDX/nCK0HAWfP+VJSytps5ecFY9oAsRQzjJKrEhiIgM4uFjrGyelxI7L89JnBXcls5CfA1TYWxZT6boW0pQT4DBONPbd/5M58OELjxhRPChboXMAHSZQodHoJ+xUkY5zt3qogiRATrFSTvVYabudPqEIUQQWa2N2+/uD3Hc86Jje8qgI/FvO2bqkbPb8iT4xV9iC7ccbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsbDP2oGreYPCRK5mkrrPxyZIYMupJJZZ4Hh0SzIOFg=;
 b=o3TXQpohgEcofk4SlEGvjmqFd5UmpaOSVJS/Fi2SooyIzSllCETkR//lGe8O6aGkZXKcpcxFo3NFJOtVMLz6Lr7V+L3+3kjfk3H7QjIP2dkXW9DALyr5ShTYFChfJQ9cd/3kGAiRA+QvGpGoGoYjy3guYQZxpDUuWak/gq1zesD6Hdz/EBnhjgRyeTx6iIaJNsLR1V3GIpXQHQRsVjtiL1/EZqgJl2pW5urC4fxRYzlLKZ4OMiduIDQ+hW1o922JkvvXbklKNHuDILhQz6Eic6sHl+JH6qk+ebS7vTZq4meEhYKmWbLt2XOKnOENPgFQU90F+BTeMGZH/xWW5vCMEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 14:47:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:47:18 +0000
Date: Fri, 1 Aug 2025 16:47:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
	void@manifault.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 2/3] sched_ext: Provide scx_bpf_remote_curr()
Message-ID: <aIzTcxGC6_5Ntm18@gpd4>
References: <20250801141741.355059-1-christian.loehle@arm.com>
 <20250801141741.355059-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801141741.355059-3-christian.loehle@arm.com>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 360e038d-41e7-4eed-d347-08ddd10a504b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUn0Owt8co32mCLOFFT6APuZNyCv+Kq2eUYH6deIxR5iCV3mOogzEyRm5Oo9?=
 =?us-ascii?Q?L/8mjlNkn7g/YpaDuXyVayj+/SGADdDIeiLdYfnNU/0lPqa7NwtI95vpQrEy?=
 =?us-ascii?Q?f3RKpsgujXEH573NxO9fadW9XQ/tfr3NgZ2wR8oByQXzUmD3LHnaGt9iNQHg?=
 =?us-ascii?Q?A+nbN/AjgnIf9zFXtK6RtXzUrqAXvmyTettndZO2vSLJaTfmnVCWlSRKoWk0?=
 =?us-ascii?Q?OI7cSh6EElDm0CoHvFO9oYMhboBF13Zez8cXEky18trGaF4d7wcCKDzYrK6i?=
 =?us-ascii?Q?t0y6CAa88EbyBf9qksth+10mcIEsPZ264qklNE5uBchcPJoGPX8QPo+5YySr?=
 =?us-ascii?Q?rt2hjIF3kKioqNeDtvYPZ1q+mjfbP/OrdlsUSJX9Y0rLHpblhilz5VoywQzK?=
 =?us-ascii?Q?CveEnAGKWF2XKDq5ZufvA7liuWDm5NA+aMj9wyTi1H5KIEGjhYDHTMStKo4K?=
 =?us-ascii?Q?II4e5HncL2Bn6tqsQ/3yac9ik8kuTpArAwZujTbljmztYh8ehAR8rU9W636V?=
 =?us-ascii?Q?ypzG/DQBGTEM7gB4CB2hzlsInWJRbT4s0Wx1O3Ar8VjsTYBfa/m9iAM9+d6d?=
 =?us-ascii?Q?ALS32R+agRsBVPnjEEYUDL6PeIlspeuu9h0s10KBU3nhrLo+I838fUJlb0uG?=
 =?us-ascii?Q?wDHZgh/kcB1hyqADKD701czoUss2eiKYRx9BDhwBNgPG3xXb3mjeBzNWyvbV?=
 =?us-ascii?Q?Z39eamy5ZAqksHARv2ZihlEhakB2BlTln7Jn9GgiJz0CuQ3YPu0aKH8LgqP7?=
 =?us-ascii?Q?hrIDqj4Pegg2bAUuiNdIYWFyLAb20X8Dc/VLwwM9gMax1JAS6dFOvNpJZ3nM?=
 =?us-ascii?Q?goXfKy3/cSFbirbjCE2Y90wjEK2MjR8rxZ+6JWyHIXXk3ZfqD4AdIe+2aJH5?=
 =?us-ascii?Q?ORt84C7/mQSHwqLJw4UxbzSJptYj4SGaCICMmU/aCGiXtlAll/OO+GI4bYFN?=
 =?us-ascii?Q?iyxqEsjh9J/4lqUpNefUsJ//D9a3qaqJf0po9G2LmdqosUZJSfzgr4B4GDm5?=
 =?us-ascii?Q?ikemjyGuS73PMPyymOGozeB3ERwD95ah1A+6XkSBxLWoIQ9J1iE+aSMbrLvP?=
 =?us-ascii?Q?Mb+y6KbvnkjCDSBSOWXJDupBkA7CVgvpviKVyLG2GKPDJFdEHKapR1wOwvVt?=
 =?us-ascii?Q?zpJzCdYh0ohR5FO2P15e3oTbqa2rHznyWwoxImDLFnZz+QRSx01o/eRrh8lz?=
 =?us-ascii?Q?GXnJDHF1MceUPqRpJGW7Kq9aX4JaCcnmaC6jWIZQ7xRpS2nRJOafjavY5YIW?=
 =?us-ascii?Q?SRBuDS4+yp+gtdjNY0MNYmHReU0/Ns+gE/C/c0Bq5rzxgNgrm5wS9rI8SL8p?=
 =?us-ascii?Q?zAjCBguwVIPP1fyJujcafqdWlP/ZCwTZvmK8e+e80euwTZQYdnFAF5huZwcd?=
 =?us-ascii?Q?lQqK+H/iqYsNB1GTYRW9B82EAgEs1WRnnVgtlb2sh5FhDwc9Fu4LOfT/Pzo9?=
 =?us-ascii?Q?eoqQ2QI1m10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHoto03zJquN7O8+UaqVkJC2xJlGWi7TxiIMbVJE/JzgMtbZS1bFHG8Te/nY?=
 =?us-ascii?Q?8czC0GdruxRQLcVUwQ0jVveFJEe/imRC+WtXYqa2eY1eKMhaMwPnBGIz9Kll?=
 =?us-ascii?Q?sPcAAXnHIBpy4KFrVeBa1FktS8zysofmTec++S5M45IbSzvaB7pOTto7FO0v?=
 =?us-ascii?Q?LdijbxPiFxuJtQYVKIeWFh3HiIIC9uqijfBj3/hJkl+RS/AT9ZSJud+6Dfft?=
 =?us-ascii?Q?HQdDuNFK0ZvWrxBHuHU0xGKLNora9i7z6MFFxU3Aef1mcuRQYPsWrlSIEI/p?=
 =?us-ascii?Q?COcKittXIjKT/asThYpwhbvLKJ58TTYz64F57GKxJyTNTQx3kNxyG1nojYfR?=
 =?us-ascii?Q?mtNLGkEdoGMFGRpSZmVLjsPJ36eRgcxw92IidX2YQCQNcijPJHi/RdbWoM+o?=
 =?us-ascii?Q?LDfcwv0kvbLD9VN3Fuh0Wa46BmpMclFP2JoAgE6pi/MOXIHZgWMEiiVE68ex?=
 =?us-ascii?Q?TeOkbMyfngJ9oWXMUkrjKOQdGewCmRoFJbgWnSs4gwPbXq9tvlxZf3TkgzdR?=
 =?us-ascii?Q?sABkUUU+iiszPHKUgirWrPGCecyDBLdFRN2rxeM3a0DriYlUbtpsLptl2FD9?=
 =?us-ascii?Q?eDkjxWYoH2LKTQsAJH1e8NaC+v3XOVFrtPmABnTKoTX9pv1nknzvmwZLrkl/?=
 =?us-ascii?Q?oHfk9O+6Fa5W4w5uDn9lap5urrjkrCJvAJFM+FI6vw95EYhiMlY77zot+Ep+?=
 =?us-ascii?Q?vhYo6EsXGjEPuB5up/5C9ID4qeeyMD59G8ej15ALesyVbXa5p0zM1Cg7VBu3?=
 =?us-ascii?Q?yRhH6R/+xexrcRBJ9rEeqcG6IVR5CRhEo1zqCHC1oJW9jepTCvbH0MohnQS/?=
 =?us-ascii?Q?9ObyGSkEKkQ0vD1bPGdCRG0ABE4HGD/V2JG7LdufbYEs9zPJMWnuhHBOziMe?=
 =?us-ascii?Q?Qa3T/3BffzEdc+4KFMSeNMtco7sJBtp1Yw09H+JZzVJ5JOe5zl+hKHJGASLm?=
 =?us-ascii?Q?txKhH6BmNOxZ8fnBrYQUONBOREi1JcURRdMM7g+Uz3C96l68VljI3aVdIPyo?=
 =?us-ascii?Q?ynW2Z1qxSDS2vOki0Kqha1ZNCAYREqLZpYTzdd8VyzUJIlfY2lCfyJ3nrvKd?=
 =?us-ascii?Q?GCUbiPLwQZ4czegrGC/v58myUtWKzmJZRlIhgFjU/bQaP5wm/4JJGV0U1eL1?=
 =?us-ascii?Q?ckH4QkZOJhSCX24sMNkkBoLd6ea54wuPUBILzUEFlb2CuDjmNXd9e36ev8fs?=
 =?us-ascii?Q?z/2hunz2Hp38+iNNWvI4Tz0CL9BZeMUaX/A1WednXQuvY4A8uqmLsre56Cnq?=
 =?us-ascii?Q?tc0rCjNOIORsmuMhU3s9ixrf32BnQdP+2qObBNdI8zZwX0td9PsBTQ38J7KX?=
 =?us-ascii?Q?BOwhDYbF1bA/h0EBY3nOXYk7uT6RXC+PeSoAxK1CsEyFINAXGdPwgxxfw4zY?=
 =?us-ascii?Q?JyMzLhYXeGZCga+LzW37fOlaP5ecaYASUZ9l4ciwomFBRbJfb2+8u+Zmq6c1?=
 =?us-ascii?Q?qHDZYml4+4Cm1D0gBUjPdYVdzN8wSaQA3jxHVaC9uN0Rd1hIIvko0mXpnLV2?=
 =?us-ascii?Q?iwpZPKEuIP6X1eJnEQ9oXgdZZhdiUzGXdv5YqBtZLQEaN+Dz/LH35B+Ob3aY?=
 =?us-ascii?Q?RtmpjD+X7fFIu+NG8MkPs39/Z7Drikg8mfeIlaf5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360e038d-41e7-4eed-d347-08ddd10a504b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:47:18.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S480vzLn+o+xGlckKw0W6tMMRWXF2DBMhMQd8Sdup8BM9gmEwS0Fg4G4jMySoeu2S9nXGQPIN5UfAeVlRe+mcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

On Fri, Aug 01, 2025 at 03:17:40PM +0100, Christian Loehle wrote:
> Provide scx_bpf_remote_curr() as a way for scx schedulers to
> check the curr task of a remote rq, without assuming its lock
> or acquiring any.
> 
> Many scx schedulers make use of scx_bpf_cpu_rq() to check a
> remote curr (e.g. to see if it should be preempted). This is
> problematic because scx_bpf_cpu_rq() provides access to all
> fields of struct rq, most of which aren't safe to use without
> holding the associated rq lock.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c                       | 15 +++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b734f55f3318..92e66bb0b5f2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7436,6 +7436,20 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  	return cpu_rq(cpu);
>  }
>  
> +/**
> + * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
> + * @cpu: CPU of the rq
> + *
> + * Neither a rq lock nor a task reference is acquired.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
> +{
> +	if (!kf_cpu_valid(cpu, NULL))
> +		return NULL;
> +
> +	return cpu_rq(cpu)->curr;
> +}

As mentioned in my previou comment, this should be something like:

 if (!kf_cpu_valid(cpu, NULL))
 	return NULL;

 rcu_read_lock();
 p = cpu_rq(cpu)->curr;
 if (p)
 	p = bpf_task_acquire(p);
 rcu_read_unlock();

 return p;

We may still race with CPU hotplugging, but I think it's not always
possible to use cpus_read_lock/unlock() here. Also, most of the scx
schedulers are restarted on CPU hotplugging events, so... one thing at a
time. :)

> +
>  /**
>   * scx_bpf_task_cgroup - Return the sched cgroup of a task
>   * @p: task of interest
> @@ -7600,6 +7614,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
> +BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL)
>  #ifdef CONFIG_CGROUP_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  #endif
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index d4e21558e982..e5d4ef124532 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
> +struct task_struct *scx_bpf_remote_curr(s32 cpu) __ksym;
>  struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
>  u64 scx_bpf_now(void) __ksym __weak;
>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
> -- 
> 2.34.1
> 

-Andrea
