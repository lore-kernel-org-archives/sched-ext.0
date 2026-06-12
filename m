Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF663FC5B1
	for <sched-ext@lists.linux.dev>; Fri, 12 Jun 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281964; cv=fail; b=h7c+fIuDNl2EOHiPUyhNRyUNZkmf05W8sh0e6sBxDRlyvVrNfZX6+DwlOluMRws2oTvmiZ5g4aj7x0DOkwd61iTXe+Zr2S118c+BnoMImRM6swWW8r8afoHdyS6N7tQeOQZ+0Car2Dq4UDICj+/BRCdK8ghtzaBDiT0I4pmjq5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281964; c=relaxed/simple;
	bh=Kr2+icY0mA/umF0KHiuT56fgkYUQLIdccltxgGhPEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HeIvLLkLf2ln4NpOuYqdoGSC4gTJ6HVMHsdXhnUVBOz1tF8aTv2lY+K6aENL6z2PPTumaPk+Ex84CYpfonhWdW48Hy9+aD/ONSNmlVZ/ByEWYgBa6sX2V3lE6tEvp5qUPIVtRBWeUilXqEY4ygatp0Cm0V1nlzfh9WzIGGcCeyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nALPhCRS; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nALPhCRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI298o48NdKoRysXNjB+9w3f9HI8Quxp6jBbgKz/peoB3+cBR/lWLaApJ8nLXuiHlxE2/YhhoWvWJY8OOk0tb86TFSIcvhBrmZhcGZ3w6zDkdeWfO9DzBATS5nRGEFDgFGpO279xqzo9GzWQrmSI9rQT6rlcl6QCtwL2fXFqjEDQdC5UEKXpMRMCdBy1FZv5iceuqYI4++yCYGBuBoDYKddXnQQS4HrGLl+wb4IaDY0qOL6a5fosPNZFQ5HoqJLfXv1bM03cakP+j4w6uZZhF7zweVV3FFEZhFHgAhiIDPkwWvCmZlK8Ch1luwVl8yzaeldV3btX3IjfwEqM2pvoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNbdWfK5zmcQmXKgQi7QrGruwWhx/OvbTO2cGJxBJYM=;
 b=alwV6oxCXpAARnDNshsgFOD8orl+IG1eyj9QR0ZM2BvLtgehkirqs7D+y7TjBv7YrGdPSq1SvjZuZugqdhQ/YAFPdKeGubSJaq4iLQXHvN8LeXSwThryn+N7ilJ3t2dzhHGizEl7bUNOmcvSJ5Yj9WxrN7BRgz1aelqPw5R0t+/1ZWmlVxHS/hbHQX7nZ60a8SqSBPJdlYC5faAbXIprZG29+Ps/LgbHp6qeTdUU9UXe0Jkf5Cus6jstF4sNWOipuoDUDK3ZV6qiLkVA0Wz0zn3I8nAHdBu9LMErV4JgKvaSBHcvB2qbLaO6NLcjf2OTrzmN00xGIypmFaOoteM09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNbdWfK5zmcQmXKgQi7QrGruwWhx/OvbTO2cGJxBJYM=;
 b=nALPhCRSNVERALvHpThSzIIvuZkhujg04sA/9owKPb1VoK2110yhtoAXwzY/J38Sqjt0EHNJqCRAnpfBIQUXCmSdAFXuzMSVPdANf6bROnMUWcgYt+Um63n2zPdVYiDAJ1L+577vJgweCUXTc6t+o+QRAC4T9Go8y4mikEevgwnuGOrSiuOXbGwGG4GCAI2zsFdW8tvcAQYgh9EUAgkMs2cv2YR9f61dqdzONC3hra7Iu7eXHH/2n+0KnLCdX2c7LCuoY0vYPvvngPHfjzONABKUSkB2al1tyGyVUI5HOed2AUPeQ7IWGnYqTZtVtdWVut3fU/du8FVM1lQV4X06eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 16:32:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 16:32:37 +0000
Date: Fri, 12 Jun 2026 18:32:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cui Jian <cjian720@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext:SCX is preemptible by the Fair scheduler
Message-ID: <aiw0mo63sGsV-mnv@gpd4>
References: <20260612161403.105775-1-cjian720@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612161403.105775-1-cjian720@163.com>
X-ClientProxiedBy: MI3PEPF00007547.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b64373f-1ab7-4c8f-935c-08dec8a036c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5Sa0kU1rjs7Gi3poni5acor82zayvo6g1KcJPF7VtA9cUQ18pvKkXKBF7/mZKuqqoQ+v9Lnee1KHffKwuDNS3dKI1uy0HComSR7bz/KnaBLImQeKv+9NOYwW1/VJ1FSt3JkwLfhhoRgLRIqDIUkluZjbAHdreZbmOO/8McBm6GUuTBjTjcqxNMEkmflQaJlNBtjc3aWgf3m6yq9NtJ8qeW5JCBMSz8qnDKIQkDLlHy2HXZoY2ulvxHvPJrSUNoN7Kdj4hf87tI6GpjKIfcHsf4PzgFWJQPKlB4SqDE925oVTjU5v7VrDWyLasUyNbaCsOIImOMuo9xQ1bYKHoUlnUCysTS4wEQ0728ZGq5hdfTlUXj0J2tCJxMbbrnS9Xq0Plw00mL8cv9xEIp8K1TjjfxwXpNmxixOmW+zBx0wYte204H++/ptDCXPLFHznSNXf21hWb2ytRxCZGYaL5N64Jz1sRCERPQwUzfY5tBh6Wr/QTX3VCZNsqcRKeBuoEuvGeDUnBfSG1LWvy9W06gPhg6gQ3icJInFDaHiYX2jYtHe99HB2h6pZQcBi47tYpTecOiRMcVYX5M++p6D0bKj3ELsoyqvwI+1TRrZ2K+9gWWKIca/s3fmS/RWj+Tt2ZR6MupjOk8Ud/sGk1Tjvjf6UUQTf3wmiau14j4iJ2zdFWKa67FL4wwUQM+DQ9FrkUq13
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A47xomeFKn8+FxS5unOGTdrmcr1PvSNUEk+COQaAbZrTKd3XEXgcTDfPLmrI?=
 =?us-ascii?Q?CnbhjjXQT2+RO8vGS8Occ1u55RO5AsOozCGKV+iBfJaiEN9JzCMcWGSGBM5k?=
 =?us-ascii?Q?iiYtd5gcouHm89o88eM3gdyQ5hMxTPBv4YrfZwY4OIpfBsd2dofxTt2SO2Au?=
 =?us-ascii?Q?k9ok67i0399UE9sCqkXUHKrI8KLa/AXAuMmgyYJ/6YzAJdPX7uld+Yx64F7y?=
 =?us-ascii?Q?zvGSFyI2O0vnjtSVgVhrvb2fs6J1Q/J38lQrw+5535ipISET/RuAYyFZocBH?=
 =?us-ascii?Q?HtjcI0APb03nY3BynJojW/yoM03MxXf27Ha2SqJi1xmiZhpYdaaz+hX1ZwqE?=
 =?us-ascii?Q?s7tS/ljGwHfouhB5RrBrCJK/Jnzc7LNXZIspAHYgxHvLtiCA+QQ393RpkHFM?=
 =?us-ascii?Q?k+tTdi645m9ncVvSky8Cxi22pQHIJwx0oG2D1Z+vRzVBur3l/ziesOsVSUH+?=
 =?us-ascii?Q?TLHZrh/wB6XR9Z1rILgidBz4rrHjiY3Y4WFwYx8spITmCWNKdS4irmD14WPq?=
 =?us-ascii?Q?8gIYFShfSQQC5mydAQl4MEdU7cbPM/Y/q1BEqBw6GLsQtNYgX0+E5o+XBt36?=
 =?us-ascii?Q?rwTLh3Co8Z7kd2Rw+kkSibwb1fSTnM9UNiTPcS/NBYDIh8OX15h1PhKMdscu?=
 =?us-ascii?Q?m8dcPyHOVRBUIYoLz9BVIkC3BYJUvpuJiRlCsJeaLTTMAEf4B1tHm+0h1xbq?=
 =?us-ascii?Q?5ILgTkYpGVOXRlZNN81AdtlfjbR6K3reZmyTsoIhXuVCIOeLv1wuGSDXe2dt?=
 =?us-ascii?Q?M9Mya60IAlS1mZVsx/ZHfpNsAvR+yI8tZbLRx2fKh8IKWYVIsNCOyKtSYbKX?=
 =?us-ascii?Q?bedXEKOjI5YgQ0mFmMInsb90HrOJUZD4vPP9nzPcWL5OvRwK0OR7QWgymd7K?=
 =?us-ascii?Q?HEilnQdfXsqA/ksKRnoQK53fBdJOZQdEp4Z9Yl/qwmVBhz/GMrlPfsW7U+n7?=
 =?us-ascii?Q?6MwvR5w0zO8vHSouGK6xCmx2cPJpnCgOpDpIBasLEqUokt1anbgzC65vtGr6?=
 =?us-ascii?Q?lNedJF/dMaJNFClmkNQwXvY/BhBa1OUHW5NUGln+g2iH/m5Lv5JMT12bqFp1?=
 =?us-ascii?Q?ScVcnNmOtc4LqfQt09PdVu378UAr+kIKzc8oq7R1x17OmOmnIX4wdQMw0lCR?=
 =?us-ascii?Q?biFOeiJeyICJEZkZ70WFtAsjLFdJfcfj6tu+wsVqxtkC+LL6DwMrdo02//uz?=
 =?us-ascii?Q?Wi0zxs8ny4eGYwalZ7N5teefgFm2iu2M1wvXbQQ0X1pp81fuLq7pQIcFUjob?=
 =?us-ascii?Q?3Y8r4n8omgKXFcsc/Pouke0/Cl+d289TxcyMf3fK57qfGUFvOyQkQ3t2ZrRP?=
 =?us-ascii?Q?qJZjoM62SgA2tiYs318wfLZC3ze+FC40kX6pS36Wht4gBGNNl14M1jjWYZhz?=
 =?us-ascii?Q?uNlqmcEjeQUGpi3zSwlNrou1mWXBBTjQbEpXweqalH8yNAb4qlbKt3ICJM3c?=
 =?us-ascii?Q?2kOW3TicVI5EZReZgB/AZoHeNpFNq+mIKQTtJMJzZra4RWCZkC6aG+LbHc4c?=
 =?us-ascii?Q?iaK1lvwuYYq6ndqCdYZOhlUeFoFlYmkMd/+I/6pTw1jQvN4IsRyRJebTkN8L?=
 =?us-ascii?Q?ES5/bYxvzy90qMDHb68kDR98jSkNfq6jRFE/Yt0yY7zcghGr0/WXMYfK/O7+?=
 =?us-ascii?Q?CgWJKAEr/Kz9ZU5eJhujFl+F38ZAlWbN0XyKiJAnQEtUQr2b7bVbzM9/HOlk?=
 =?us-ascii?Q?zz6QHEI/fPyRxAICnyWWdTYhdkmk5NJPojMHDwMxu4pOxmWQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64373f-1ab7-4c8f-935c-08dec8a036c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:32:37.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+bwjnBzVu5pgEj953UyTmpoFutqwXAC1nVYcDpG3uutwvf5GYjAummAHdswqyAZhb8bTw2r62Xz/rmPIlGANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

Hi Cui,

On Sat, Jun 13, 2026 at 12:14:03AM +0800, Cui Jian wrote:
> sched_ext currently distinguishes preemption caused by STOP,
> DL and RT scheduling classes, but preemption from the Fair
> scheduler is reported as SCX_CPU_PREEMPT_UNKNOWN.
> 
> When analyzing SCX scheduling behavior, it is useful to know
> whether a task was preempted by RT/DL classes or switched out
> in favor of a Fair-class task. The lack of a dedicated reason
> makes debugging and observability more difficult.
> 
> Add SCX_CPU_PREEMPT_FAIR and report it when the next scheduled
> task belongs to fair_sched_class.
> 
> This change improves scheduling diagnostics and observability
> without affecting scheduling behavior.

The preempt reason is only used in ops.cpu_release(), which is a deprecated API
and will be removed in the next kernel versions (see the pr_warn() in
validate_ops(), kernel/sched/ext.c):

 pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");

So, your patch makes sense, but I'm not sure it's worth updating the API at this
point.

Thanks,
-Andrea

> 
> Signed-off-by: Cui Jian <cjian720@163.com>
> ---
>  kernel/sched/ext.c          | 2 ++
>  kernel/sched/ext_internal.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5d2d19473a82..6e0281218197 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3015,6 +3015,8 @@ preempt_reason_from_class(const struct sched_class *class)
>  		return SCX_CPU_PREEMPT_DL;
>  	if (class == &rt_sched_class)
>  		return SCX_CPU_PREEMPT_RT;
> +	if (class == &fair_sched_class)
> +		return SCX_CPU_PREEMPT_FAIR;
>  	return SCX_CPU_PREEMPT_UNKNOWN;
>  }
>  
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index a075732d4430..3ce07bec58a5 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -241,6 +241,8 @@ enum scx_cpu_preempt_reason {
>  	SCX_CPU_PREEMPT_DL,
>  	/* next task is being scheduled by &sched_class_stop */
>  	SCX_CPU_PREEMPT_STOP,
> +	/* next task is being scheduled by &sched_class_fair*/
> +	SCX_CPU_PREEMPT_FAIR,
>  	/* unknown reason for SCX being preempted */
>  	SCX_CPU_PREEMPT_UNKNOWN,
>  };
> -- 
> 2.34.1
> 
