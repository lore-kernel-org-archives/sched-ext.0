Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26428412BF7
	for <sched-ext@lists.linux.dev>; Mon, 28 Sep 2026 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576798; cv=fail; b=Rr67f24Off4ISJGmDK9RvvyVM+R0SYSPAj7poQVj0R3rrMcSO3ybH3hQuM4JLtVO5j1rvYYZNwtmzGqVu8weHnZEmqZc6LuOB1A34yhU5/VXJYh/EnmtNIsSlTrXD/AnTkzcSvbXO49BL4UJYb1anzstKjTe+sVl01wUm79LD/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576798; c=relaxed/simple;
	bh=JePT06tIm6tgoV7Ovg9xxuFXqUxP8CLgRJ2FWbXcPKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N1QAb8O+Je97KcAxW9FiU0kSideAInQPoXMpsMRVsnQiLag4oCpJKX56GnSwoy8SeJshd9MA1yyOd20Qi4xZ8EvvNAzKyz+IeHAaZzndz47khtVtWiVrmOHkRwI+CxWIC/K9mlw1pKoRA1bXroIZcB2Et6IkS+Jm+agrK7R4Qrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jVQg9fyb; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jVQg9fyb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo7hrfmgiNjEAXIUD1buu3QmZJnpATYhWjqC8iwa6IDMhdMCop7f6i2rHeyDtTYEspD1cFeEMjaNEghuzw03Z/ZP8vpbYLxExG+1DpBXDI3ktaO2gSTN5Qhdd9Efw/Q8CabNh1C7wMX+Sf+gCc9dKA4lXcl6FWyHfMoVi9khVOiYViLyoJH+hPDE36iI/EXYozCXCZw3hIRLfySsjAC5UrbImaE7b9S4sego7qjSURD/gA8KmFrChON7rKYNi/47qnUhJ/q03nBSonjmtBP5I3jgxBmrnahB6M5tcTj5FYJRWtgJ6CA61cwh8C95QhIFO2/5bAez0wtm2OvN7WXVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScNISTr68T5LnXKOF7WP61DLECV+DUC4p59s0q2mgn0=;
 b=r15Z/Wg8Ox32oNTnWoJkjsRtvUBiuLexmnxtHAjy2Ekzhom3YSpul1fLZPKeFiyyWMkI5RowTGMOWYRDalK7V1EyfnMXnOU4yZQ+zWPR76FzxV1gYldOluzALeLUG5r8ureUS4w+2acKjJ2k5PlkWWaUznrVWSopazmZRQqXBsYzXHoL9/IjuiLOGXwxG5njQdt74hDPejIM8OCBrrfLxpEiB36FFk67YTz4I9HH1zXsTo6HELo7+3jpSIJLsgEMJvCSYggBCOU424aada1S2Lhao05229imnQuOatPwQalqa7IPW/QSC073jyMEQE1DGqa2spHFQQ8Xb9R8ODu6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScNISTr68T5LnXKOF7WP61DLECV+DUC4p59s0q2mgn0=;
 b=jVQg9fyb8pvGqW+YE+6lyzyW6palD45rLOMmJTW3BVj9Wl+Im0oO6y0kb+o+LdszpLAMJrcF/ncFtIAFzbjiD2cINYVCldIsxkqF6RTS97B2SB6UkVt5I+qdtMiHxz9IF1V97qDJuxIQFjprBpV7P8vIU3p3Tyb23bLojAC/+mdJMqqypfcWhCJW8dDWBGwdfIwJo7FhyMFagQHoeM2mF0LmEpQQMgcEdYv6ZehDpi2qRmzpv5Fe3Z0NbMEFOl0MJsa80jrV8KFbENPZ1j0osjb2TEUtTi7luh0xEB31Dj82bbEL+Fttb3MFecLEhmTF3CVcXIvcxC5qyWOmCW2nNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:26:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:26:32 +0000
Date: Mon, 28 Sep 2026 08:26:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
Message-ID: <aroIi7aE6wdJH3Tv@gpd4>
References: <20260928030955.12353-1-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928030955.12353-1-zhaofuyu@vivo.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9add081a-c2f6-4658-7cdd-08df1d29704c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	nC0+KkjkjIZwvb6sOaZZ9ULfzYq8515EV+80ccYahRXaF6N74yuK7q8tNuNfz0kIaitF7MTUxZR4MQM9GPhlvxnSbSnYtm0HZLk+6nmzyOhtgTYc8ctjVA6Hb9CRF9W3CtPFU5CFb/uqwLm5gyW/827KuJl5fRq2VbVMQrNz4HtRZOJcjTvIs5kCwG96i3k+tptnMVB2klSFU5ll/psaARuB6ncjKPrvxpXyehjSeAbImRTC00fnRbpX/mdGEbelbnGpmr+AzqmvzzNeI5jwJDKSGdjGmBbV+QMAyIfJ8BAYK9hk3obphJTxna7Q1PRc6Dx4W+/rCPb3Ww6IJycAWRrxhBskZL88s1NcXbWAJyHq00YG+uOwLWEqy6RVZiiq3m8yxMpXNVx9rOmVfII0wFMieaFwp/CWIYkdA+sHEkR7ni3vZMT01tibCH/QBTGuXjzjeSmJ3dY5D1truc6YWiGQ+JEWMx/Mz743CmtzTtTNPmJjuDWZ+O9VAJwfE4dgIyekv+S1QnYPC76ZYbDryAmIyWESQaqkSGwENqDLk+9LR60cvGn7qmx879ICabZykTdaU5DWAiSh7T4yWOfQFe9pIMSkhMlr1say7T8CB4/EyPnq4bQQJ7pYuoSL4jDuVX210tFTlQ3zPghvlOS/31qR951RqKnfxdEkKDdVnE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?upmgV6idoyuhF71jaqJU5s2wNUt671GWPgKhRmISZCZhVtyVk/QBmO343QHS?=
 =?us-ascii?Q?vomandFJZ6a7G6mOqiIRn9BW3rcys1+JPwZdqQXfr50peJqG6jZWD9RtCpfB?=
 =?us-ascii?Q?yWgU/UMeokQQ8iwIUNpCeMB+HaIfrgCaxb4Fhd8HWnX/TjPV0EqFuKario18?=
 =?us-ascii?Q?4zT5yuJz9lmpIbmBNeDJIsGWTDkTJcdWDcdWB2Q4b4lBUly/N/RetxpJHrBC?=
 =?us-ascii?Q?++lyG8CQkvdsJhWGkwSZH1pEWg/DsTZiHl1ZrsrlfQBviKKoiUhOawyN0BcX?=
 =?us-ascii?Q?9M/vAzpZy0s7yYiSNHTUIbOcDqpsvfv5f7aPNBA98jrQF6w4wLpR61XRx8WM?=
 =?us-ascii?Q?YqosVVzPVlAuvQvu4MNC8vPMO2Rwgvq1V/qabXy9dsLkM63SYdxC/Ujo+WHY?=
 =?us-ascii?Q?pDe8pImx4amRjMLnw6XseJwEHzkiHcPAsj4P0s9p1gPGG2m2FKnTXvcVM4A8?=
 =?us-ascii?Q?JuCxOBrg7jkoLX4Lw140N3Ez9lqqlmPbG4gv4riq2zO0mQbn4dwHhUmIupRx?=
 =?us-ascii?Q?QxUbWkdwUQxTVfSJKUY7moRoD058afUn3SPbQO2sR+j8SLh24kOxcDa5bvYe?=
 =?us-ascii?Q?q0tsVtrpyTNZGUzXXkG746WQ/q6orcEer9XJZZ772k9qwfBw5CMVxdzMu5IE?=
 =?us-ascii?Q?Fit28zSxYn427YB/IIF8ZPkdb3CY+XuITL83UKitvwhsaJTtYRS3W0b8PlJf?=
 =?us-ascii?Q?zVtuSPRFpV6S6lsP3CMqujXrT85pZ75uZKbvU2zeFLizw1mTn0TtJKkOQhFx?=
 =?us-ascii?Q?nZCLtSzBg49WwguttAFyDz19kqHKCC8zirWdUsraZuenhW5UT8X9Jx/59msv?=
 =?us-ascii?Q?FIsU2HvtFBz16fuW/Pi4O90Cr7OyzfCJhSAveQMxb2Ulg/Ax6FoMJL+ftJOU?=
 =?us-ascii?Q?EFFKvSXlqHXYae0CNPqYzsIOBB2+WAYfamG0L9zic32RsQPK4IHywzkGcZGM?=
 =?us-ascii?Q?wAtARxfhMtE7Uv4ewE03tvSaAHy1QgNfh1XZfioW9s9FANZCckivnOzaq10h?=
 =?us-ascii?Q?JCsS5EJQ79YDWOyRa/4R6/IHY/sPdo0l9oRpiuYLMZp1yk4tO8MHM8aW+JrA?=
 =?us-ascii?Q?yFFhy4SMjnDx9X2iqdmgzTvURD2tFIoF3AWR9iEF9U/acasQJoo6xkUf2D1J?=
 =?us-ascii?Q?hyzCc02c6pfrmxYSWr8Pe/sS5KU8IifClIzIU1eAMvTo3Snfy0ql2CNVHzBs?=
 =?us-ascii?Q?bX4VJhLWj01SwdjpaP0c6wxW3wQzuhF4rIl0v5Cj0uf97wkFrSRkyQiZ9aJ/?=
 =?us-ascii?Q?YggFTUdEeOx0+t0RAf2y0iFteiI+i32E8zEQlYbeeL3qOHKCXTMcRAy9pwaJ?=
 =?us-ascii?Q?veIcdUWwXCv4UmtCj4EJHMYKeUFmZo1nWVl36f3na3XeegZp4xF7TzuH6J7n?=
 =?us-ascii?Q?v3liJ8m2Jz+URd8LjoVDuEtvUYxOEP+I5ywvGzvZ4Eg3Pa7abQMc1/33i7Hm?=
 =?us-ascii?Q?IW2iXk4CcyTfI1bbPHYpaZDhx8RK0p4sumaLa92uCMt/gDc6jD5+zMBOpbB5?=
 =?us-ascii?Q?HX7pHTccURWYtBp45V+pNk3bvVZN/vn4oPkMumfFIsl3640ywWXZ0/VZR/KK?=
 =?us-ascii?Q?huIvNcxsKMOKFGKuMdu7t4Uw1KTaVMeCBy4N3w2efCcp7vRxR4Few3fhJZ6L?=
 =?us-ascii?Q?Cx7twHv0i0xNfDOBtyxPam/qkUkczFIzXs2XDRxR9qBND3Zx0AhF5gnGQyOD?=
 =?us-ascii?Q?u7osLfRqanmWI68Upzjr34SXzzUBUeB3HT8UJbhivxVXRuqVQQP9TuT+L61P?=
 =?us-ascii?Q?zzZm0l2R6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9add081a-c2f6-4658-7cdd-08df1d29704c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:26:32.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pih0MWfy4QkJgoLBEKIBjJNMY7H56vV1hIFvkBhjMBjRskQgme+jCGghZAg93pR8ev3RJBl4AvOkwlR3OGI3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019

On Mon, Sep 28, 2026 at 11:09:55AM +0800, Fuyu Zhao wrote:
> Add SCX_OPS_OPEN_OPTS() and SCX_OPS_CID_OPEN_OPTS() to allow sched_ext
> schedulers to pass bpf_object_open_opts when opening BPF skeletons.
> 
> This allows sched_ext schedulers using open opts to retain the existing
> compatibility handling instead of bypassing it.
> 
> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v3:
> - Add SCX_OPS_CID_OPEN_OPTS() to support open opts for
>   SCX_OPS_CID_OPEN() (Tejun).
> 
> v2:
> - Link: https://lore.kernel.org/sched-ext/20260923035613.20099-1-zhaofuyu@vivo.com/
> - Make SCX_OPS_OPEN() call SCX_OPS_OPEN_OPTS() with 0 as the opts
>   argument (Tejun).
> 
> v1:
> - Link: https://lore.kernel.org/sched-ext/20260922031618.2858-1-zhaofuyu@vivo.com/
> ---
>  tools/sched_ext/include/scx/compat.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index d2e4384df..3ae6e0ef1 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -177,23 +177,23 @@ static inline long scx_hotplug_seq(void)
>   * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
>   * - v7.3:  ops.rescue_bandwidth_ppt, ops.rescue_quantum_us
>   */
> -#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct) ({			\
> +#define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct, __opts) ({		\
>  	struct __scx_name *__oskel;						\
>  										\
>  	SCX_BUG_ON(!__COMPAT_struct_has_field(__ops_struct, "dump"),		\
>  		   __ops_struct ".dump() missing, kernel too old?");		\
>  										\
> -	__oskel = __scx_name##__open();						\
> +	__oskel = __scx_name##__open_opts(__opts);				\
>  	SCX_BUG_ON(!__oskel, "Could not open " #__scx_name);			\
>  	__oskel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
>  	SCX_ENUM_INIT(__oskel);							\
>  	__oskel;								\
>  })
>  
> -#define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
> +#define SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, __opts) ({			\
>  	struct __scx_name *__skel;						\
>  										\
> -	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops");	\
> +	__skel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops", __opts); \
>  	if (__skel->struct_ops.__ops_name->cgroup_set_bandwidth &&		\
>  	    !__COMPAT_struct_has_field("sched_ext_ops", "cgroup_set_bandwidth")) { \
>  		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_bandwidth()\n"); \
> @@ -232,12 +232,18 @@ static inline long scx_hotplug_seq(void)
>  	__skel; 								\
>  })
>  
> +#define SCX_OPS_OPEN(__ops_name, __scx_name)					\
> +	SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, 0)
> +
>  /*
>   * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
>   * every op the load-time fix-ups above handle, so none of them apply.
>   */
> +#define SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
> +	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", __opts)
> +
>  #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
> -	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
> +	SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, 0)
>  
>  /*
>   * Associate non-struct_ops BPF programs with the scheduler's struct_ops map so
> -- 
> 2.34.1
> 
