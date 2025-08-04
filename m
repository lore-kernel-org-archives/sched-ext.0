Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516525D208
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311888; cv=fail; b=And66RWM1pxv/kMDF/xN0au4lq9vq8AwZPOhMadhAIHOZue8bVeidSEND0oXl3IFj8gQQ4wJqiv4PDiRSxt8xAcq2PdqQp6GifdXaLc0QT0RpWb/emafK48dkYZ/nWiyobC1MqgvZRJ3fsCUMUCuWQ3SMHqys3Y+EwejB2da0AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311888; c=relaxed/simple;
	bh=IpsIT6FEcBoorPDwBB1wGcFGRe/31xgey0hSnB88YV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDEvw4KnN40tvsWpvOhPu8tf71nYSdgtkPocwJ3gp/1cZgU3oGVTyWQxrJS1UQKse1BxynnthDwHJm6URaG8pTk+EaLaetTaIEmeis007wwt/n2HTwD4qGX7Wr88oWOj542jgWcfJUMbLgEo1huKegYpUy/rl/IuWnLA+M3/aJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jH+fYcme; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jH+fYcme"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkOEqf5cdR7OplzlM09kjCgvtyyIumcRGLXOdQ4ZLctFkLlhUlgQ4bJlKz4IcCPbp5Tpq/msnmssKwQv9Lsh/BKHwAQGn2cZ0A5UV6TolGkgjbohZHiem0pwATTehpDGd8YOhyaEAJGvqbHkJNBvWTXTl8h55M+kvV4xbT6umckHxMm4DLWcx6d18r+P5gNhhacS9XIjfPZSW3AOTSYsDHTPG0Upm/phGgIGohuEJB5NCkofnspYTwXgij8MmDWCdM7VtasHKbqZGWtrtaek1+pE45+ezrSRckmqnOoCvuPOpmZEwU/PYObg1XzyyuIV51cdHVHqLZ1S/7SDaFX11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRS4NdWs7xFu+q1vnZx0k0s3OBE8lW5QAviA/79RE0k=;
 b=vQXGuAuLSOAv+LUQCgdtW1lAvEw5wDw8Kmv5AQ6zeRSbnoGoBQGzUcRHVHTSF9shi3EQstJvhtY4XD0xPQMuqXCkrHycN+wLR0CUOILT6K2ZI19APkSs0sPD5GGzgErkZTj4BDa05ghc2H9YtI+Dmy4GUOfV09vm7oMLWbertTffNbnbCKrR4ucmmf3H7YDKVA74jMB3jG1+FiqH/pilfQOwN1H0Pvk92rkdl1e9Rj88YoqWgONGzoknzwokYVEunRKywhDwKIBqR5s9tPPzalkLsLg61JIqbovjzyfb7qBArJd37+bGxn+mWv72tjMFMjMLuvHZUZneeTxwrelyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRS4NdWs7xFu+q1vnZx0k0s3OBE8lW5QAviA/79RE0k=;
 b=jH+fYcmeg4AzCFF/BzGF5437Al03SghQswVXLiOhe7Q2vMDg4rvBNhCPOz8PjbyJcdhfuEmULycSEVQ2yCpjRjbLf/Qe3/8eB9mgbcH0zoVne83u9MW48bxI9w+oOvsddRkl4DWFZ19hpzXz0hZqPKMl1RrznUJ2oVbiZsdWWtS/ZHDZQkV5xJbMfIeGJkSmx3Nw4zweluRQ0ALp/hPXy8gcZrEc9aOggWDcQWTEH/cGw9pghyCjPbPHbrAeaLHfhdy4/3uqeCMhL9D27Jjv2s5EJ9LZfpyjmh8m6SKe4cEZNM0q1aC1XLDwHXU+oG/okgn3BwDWi2HrGNdIRIwt9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 12:51:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:51:23 +0000
Date: Mon, 4 Aug 2025 14:51:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 2/3] sched_ext: Provide scx_bpf_remote_curr()
Message-ID: <aJCsx7hbCD9f5RK3@gpd4>
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804112743.711816-3-christian.loehle@arm.com>
X-ClientProxiedBy: ZR2P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9539c435-7b19-4533-58d4-08ddd3559db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bP38kF1zvYmRVuVSMJpzelNFHi7C9K5NVwc6A0d/NVah1FR75sGBSFdVvTsi?=
 =?us-ascii?Q?hxxuUbHLT1v6MYsyO06A+f/jkmfaDLFJEmq8CDKWQTs9yi1Os/ytdvQn3xFS?=
 =?us-ascii?Q?ynVgU5Nmeie3+IpuFhF/K6XM8JWIyYmfjTZLvrF4/N86PYShFNUl/udO9W4q?=
 =?us-ascii?Q?fkX2wWIKT7nJAKFXcRcgmqdcNc6M0mt25KzWXxMQrwDMZ8sNye1rzzYz9apg?=
 =?us-ascii?Q?5NOhbplYGHDpxrUla/AA+Aiuy0gJpaLZcvtvZX0mFBbVCEHprhihX1BVVdQs?=
 =?us-ascii?Q?f7yoLnJhQs3A+HVOSUNzhIQKj+5eR+HIF9lSnMP87YslMH6N+VcOEOCApq3F?=
 =?us-ascii?Q?APL8L7QQLwsP8gqbgTlC8f6clW/hE/5yuB3g7atMWTG5PykeWNUwsPGLRK17?=
 =?us-ascii?Q?/NjDlh/OnOSQtgepUOEdis0uDEh9Sc2jgiHxNv2vz9blreDb7cksS3iLd4OT?=
 =?us-ascii?Q?X6S0fB/fglpJtukeWqDg9UkeyNaY6EW1wGGnU7oRA3O2qWYogpLIUp2yNTIu?=
 =?us-ascii?Q?oG3ybEstVyRj6bx7zR8JtX6yzIFfHQnHhcgl5PUVmFZTfXh7GwWdQf0dFJi6?=
 =?us-ascii?Q?HM1UZkIuPIOpDe58lMbu5lep4mP622HGQWLjJXQiSKI4pgmPSddqwSivl08d?=
 =?us-ascii?Q?Ps4V6MyElPdTHRy4sENAV7xCRxJnXiLa7Bpozp/YzVBsy5iK+BLVgodWzZc3?=
 =?us-ascii?Q?Vel/ud+/l/0MDIou5xJR6Sg420/Sf5+XjWAslIu7Rq9Is2V7Ots+VQxswCvf?=
 =?us-ascii?Q?CDq64X/M2wFbBOyZMq70noIWRotVA17cHS0n6h+q1IAwq+BRVOpKcKemCu6A?=
 =?us-ascii?Q?c4dmUxoIfyLk5acxWAS0fnWDhdaGCDzatpxDjPA0dOhirfbD7OrqdQJWhGwf?=
 =?us-ascii?Q?jr4y51qVStPIJF4h5qppBHUUhGOAVrAxp6RH1vTYX0saIGUfzb9Xhkekr9Fy?=
 =?us-ascii?Q?BMLjK1WjX3N3zbzGbcWg5nj4Z21EStfrAb2wOa40UmuC4q06noqQhsnj/L9q?=
 =?us-ascii?Q?dZeA2sValmOwEEoDM8PFZDmOG0eAzSM1bH9uCUgxOnc+ZMQKMWoEIcnoLDVZ?=
 =?us-ascii?Q?1Wtl7paTQIxsF4+MlI49rhYJVvMk7h4a9jn/eEqUn21gJVlG6LMbLcPCyTsH?=
 =?us-ascii?Q?DSwUI+Yw249FXH8XeE4KdD/uowcBTElSuZEbaBTiNvEF7pCQklBG0tegWHsh?=
 =?us-ascii?Q?3FmGV3iK+FvofsRDydACj1blSSzfVIYtV6QnLFMvkInryYfme7WdNmDilldi?=
 =?us-ascii?Q?k+6F9ICpaKBw7KjaFi9/JeywmONMNr9NjZ6hH6PgSHvwBIcXbuyUKKx1LFQa?=
 =?us-ascii?Q?qNZP+4VKHeYdkEfXRxFLaTN4G9A9iwJ07oP6VIKgNPUB3f2jBXY9ENENAoHX?=
 =?us-ascii?Q?/tU25NLGS7O8YNkROGvE9E+RegzF8M9wZWg/z7nod4hjd1WEB1tPzAESCZVU?=
 =?us-ascii?Q?JIKVE7Sn+eU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d98lNisQgtF6a2v23gIOA+OQpmRtrhl9P03jIJ1ta3cm3WfdV1KKlkiNtHJP?=
 =?us-ascii?Q?KemnvCycNNSI1ejR0xbLQpw5vexzQrKI7XM/4oYUN2Xh1IbBBbJITrnWCzbO?=
 =?us-ascii?Q?JEj+Di8G+qKDx8ZY5CvYRGNRZ2zy5QhpNC67VKOPKT2KfbmAmtAW3tJF7knb?=
 =?us-ascii?Q?zhfGaDDFHRvgpNa44YgArN2lFyTBtQVZR/9CCqbvcCH7guzPkOpoW5pAJVoW?=
 =?us-ascii?Q?18hrOFsbfzjLN6l8jcWThnEg1bpWY/pM11kjwQsUpVXBQr9uJiuRM+5kBByB?=
 =?us-ascii?Q?6B5xIyxV+WgUFGTh9QbLJ3HNxDX3o3qg7uF/yEerEFgtKHHIOn9oVopEdp+5?=
 =?us-ascii?Q?1LY9eramyGgFZrvbPv69FNXfckd7sJkmC8XxZcbRqU5FUqvyqSOvF6g6bN8x?=
 =?us-ascii?Q?PVxXBpK0sLj3ULmxcy8RUWfKB4Yay6YpjBNCD85Nz7Ac8nuV1y8mtYn7+uPi?=
 =?us-ascii?Q?kxwuxYnV3oTNHNq3lOxUtXOT/AEPeHsOfZHku3YbArIZ+PET5KdMRrBGa2HA?=
 =?us-ascii?Q?EBJi2xRnCkembFOYZto7nMDoJIcUy02PjhNstdUYSG/fY/j/YAsfQnJmp6L3?=
 =?us-ascii?Q?3IiyZbSlw10dBAkbDur4/zz86KAiOt63PC804gSRN1//7nm39CI+umtkqq3Z?=
 =?us-ascii?Q?t54e2ddwK7xqgvc8uZs7IWYnSuRunxyxyCOrZQ1px4tOQVgc6yZ+0BjuTQIr?=
 =?us-ascii?Q?uPtk/zJUfI6ixGtn1ZGALpuc2AF2gNCPgjbNmvDst80AuyNAyot/APf7cRxp?=
 =?us-ascii?Q?4Gfz+eDXTYiHqpORY/VKGcXuznZ5k0715N6rdrteurUdFKMsBW6lZ0AHjRRH?=
 =?us-ascii?Q?M0f+7+3ksZrSlI06Je4cZXLnUQVx/bJRMawdJMK6GSVCY5aK2cIqByvURCnL?=
 =?us-ascii?Q?aHKDKDa+byvVC0kF+/72Np/5o73KXn++L2m+X+H1c5o4Y9xoZFIlaPVyVCpY?=
 =?us-ascii?Q?NUW0IZvqsq05L67HCRWXGLjEWqyH0zyNT6B0yUjBB5ngZR+N3pkPv8Oxe9Nk?=
 =?us-ascii?Q?uuFLYrYtwZ5znWnG/+/FJDFc8gQnwSjYfdppxOMRjQLoYBoRL6WSU53hfiAv?=
 =?us-ascii?Q?y77UYRI5vMSn9U+PCEXYk6iidwdRFte09ybRN7ps9IoLfxGUL4Pz7gJfCG5D?=
 =?us-ascii?Q?ZGWmPv6eNPOImehvf2PfHiwSMzM2/XToFkeW24u16SOCzFb3MQYCv5P4G0ko?=
 =?us-ascii?Q?V3bvM1fOYPQmZRO+Liry2Q8JQmaqOO/mTDSylQdYskX6cFZ8FlLJjjWh3BGH?=
 =?us-ascii?Q?NblSSTUitH/PLdZJ1mfzKrdfV17rqxoUTcsQ6m4QOoP0ng6asGkkhiwpPOEV?=
 =?us-ascii?Q?YyW73VWkJfZGOHgT/GLaXgGEG8b0sceWw+N00rFdWY6q6izVT08MXOjWPaBy?=
 =?us-ascii?Q?vgBqqrPZts1bBtm8CuTnNMYF4LtYngYjkKTMU2QIbbAagdXM1BZg88V1MVHg?=
 =?us-ascii?Q?OvqzWWM8u6xvU5MIzT8+m7cOe3gzRstNNbsE8Nu9mVO4+TQ+5xTakye2XbC3?=
 =?us-ascii?Q?LdOnbPK5SQQSsk64uYGk2JnaO3HLesm3eHjfvLtEellQW3BIxgGR5FILK2Yo?=
 =?us-ascii?Q?ZSbnqzQa/NGcdC3rcC2b6UAxevCbuoGsBQ+MoOZc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9539c435-7b19-4533-58d4-08ddd3559db4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:51:23.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezh6GSiQ3gqJD2+l+tleUAVNJS8pV/4mn0gRyB/TRjyDXv77wTLyLTTOIUrQtievpf5yCMLd4vhN5UFPdBd7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

On Mon, Aug 04, 2025 at 12:27:42PM +0100, Christian Loehle wrote:
> Provide scx_bpf_remote_curr() as a way for scx schedulers to
> check the curr task of a remote rq, without assuming its lock
> is held.
> 
> Many scx schedulers make use of scx_bpf_cpu_rq() to check a
> remote curr (e.g. to see if it should be preempted). This is
> problematic because scx_bpf_cpu_rq() provides access to all
> fields of struct rq, most of which aren't safe to use without
> holding the associated rq lock.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c                       | 24 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 3ea3f0f18030..1d9d9cbed0aa 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7426,6 +7426,29 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  	return cpu_rq(cpu);
>  }
> 
> +struct task_struct *bpf_task_acquire(struct task_struct *p);

Can we move include <linux/btf.h> all the way to the top? In this way we
don't have to add this forward declaration.

> +
> +/**
> + * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
> + * @cpu: CPU of the rq
> + *
> + * Increments the refcount of the task_struct which needs to be released later.

Maybe we should mention that the task must be released by calling
bpf_task_release().

While at it, what do you think about renaming this to something like
scx_bpf_task_acquire_on_cpu(), so that it looks similar to
bpf_task_acquire()?

> + */
> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
> +{
> +	struct task_struct *p;
> +
> +	if (!kf_cpu_valid(cpu, NULL))
> +		return NULL;
> +
> +	rcu_read_lock();
> +	p = cpu_rq(cpu)->curr;
> +	if (p)
> +		p = bpf_task_acquire(p);
> +	rcu_read_unlock();
> +	return p;
> +}
> +
>  /**
>   * scx_bpf_task_cgroup - Return the sched cgroup of a task
>   * @p: task of interest
> @@ -7590,6 +7613,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
> +BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL | KF_ACQUIRE)
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

Thanks,
-Andrea
