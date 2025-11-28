Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE723771E
	for <sched-ext@lists.linux.dev>; Fri, 28 Nov 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368993; cv=fail; b=SXhB0sJ3AEarosvJAZuaeDYdPVNgbcMIoAccpp61otSjqcmjzbeuCf/IGzFTU5XjIFFqB8WzB5/y/c45aGQiWj/gCpIQL5/D0vmMZtkBrBFZgRq4My488QPhAvNEQhszAdBZzfGpRvuJgAp54zFohDB1HCSdij/0zsgeq6r22IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368993; c=relaxed/simple;
	bh=n+Ag8RqYOqyfsnqlrgc3s1cXc9wQ5tDOFw/1WwSiYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqj9MN6FslXoXBcNvzRLuGyAfjNblY/pZvWAXUGa025GeTvqgiWuVez72LRv7Tja2Eb9YuEpjZvPuYZS1UeRGNskzw+Rj7Z0ft+y3tIzYX9H/t6oEWICqFBB5Uh6RF7iRBnHH0YS7rSohkUUKt76wtlDtraFtehsNsmQQ6t8KeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q14uUnOT; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q14uUnOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMmrB1f9y7vCp/MRPS8L6dDPbQVNcYnIRCk720xQQG6/OUVCGByeEIu9MgdioyWVhNPuKWL9tmE+fmZ1SZSstiy6MqwY4GlJGuuzjZHMGdCVIFZHW+UywO08Nl1ZtMelw4lDlXkZKfKDex5CcUEngvLnfKAy1Q+RWiutsjaaSVCNihX1Y8OvciySH8U5K6wusm8184RB3705wnWGRQ+gBj4dtLLU+I5yjqApBnj05C4E1v3wo/JD2Zcax7mCCRqvvU04wavf6YCzj8wbLK487h1irMnUTSotYI/uXWYNa1GqFdne56j/T771uUvpu/RVvK/Q9qhu3LKkKow3eM13ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eONNseU2iG3aNnw6tBU6DToDsQD3tcyAx8DqGmN1CT0=;
 b=ttqt3HirUB5ODYYAnKt7WyQzXW4lugDJbdUgy1fDV672B8SS8vj+7ycda5pz9zNQFQm0hbFf0SvVs64N1z01eEaZyC2HwqJPbVM0CPajE/sXnOBPtsnNGy0y+dFMPH4Jr8yksiDdA1f050PpUJpnU2oloJkDqxpRnOLIEszYo1r9DYOLlgVJRa6YaG1PxtUv9g8YFTtsXV8Sf9eYLp+iwM91Yrogb60Y3dCAYbc/inzXA0jm21QGpNiQaaD3jOby6t/YQqn+SRuwnCoFXJqLIJ672/0ykIJYmumjxORhi4I47XTcCdL52kbIzk96k6QH8JdIT6t6r/5YuvHxoG2kQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eONNseU2iG3aNnw6tBU6DToDsQD3tcyAx8DqGmN1CT0=;
 b=Q14uUnOTxi6IZE3jk1BV9rlMQUI/sOE0NdZ4bJCVyMdxONFMRft6jyzdwuTOSHfhDUBvtYAK1xehlcY4pwriPm90ll7sJTtQx5gzK0mamwo9ZO/1XlMy1Raowg4VkyYFQ6l5HY7nWR1mTE4LP9Lo7D+ZkQFKYnZ/cxQ1Kbt0VKoKvT7FhMNjijE9sauvvPGb/9GtzOHugEeewuAZwAFp9ME8iJWgqrCuMbo/njh53p/mvgTVLzELjcPgD8Z7dzRp3JH3wJoUvj9h4YjF0rBQ8H8Tc8s9owHhKB6JfiM1w/1yQVb0oF49c9SyHP2ydsJNX/dqMN9KWW8dKaSbGFd/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 22:29:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 22:29:47 +0000
Date: Fri, 28 Nov 2025 23:29:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com, sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
Message-ID: <aSoiTfFgYV2PZfKE@gpd4>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127154725.901391274@infradead.org>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 85df5a22-4055-4fec-5c93-08de2ecda338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fhcnubD6tL+Vhkplt7RVHm6IyjfAwjDSU+1PoHqlVPoYr7ysHECpXiap1jtR?=
 =?us-ascii?Q?Vi33fvnoczDsXX4r3a5+vco3F3OeTRHYq1IA0drSteGqhiMeWDbD6oLT5V1D?=
 =?us-ascii?Q?jnewddIFuq8f4HLS4lJsIrMcGPOnzWX0n6iGXsZElITwd72Y0Xh0zHQQUJYv?=
 =?us-ascii?Q?15CoJI2zwXRw3hd9dHkKLGa+xIy5n7xQZ/fbDGWflsiMkS6/xNzZBSraohEX?=
 =?us-ascii?Q?QBD8ByK0x2pqbIGHp6Ky+if9WiivJpP2LsS/UpGfbqmoMklE3SCNHaDy0viA?=
 =?us-ascii?Q?nHL3PlON4Nu3/9lPySkrbvhlpYnGuo69WlknNiThpkXyT+tQBsM7CqdI09/U?=
 =?us-ascii?Q?jtqNefW/VpmumQRDO2hKEATJltg2KrHwUIiZ84MPomXNHbQJ3CN5FIwO+8Xa?=
 =?us-ascii?Q?ly8i+0FVMJvRS8m4YvcBAn2U8CclFNUOM6YJuZzfhsm/U7ze426R2i/zESiO?=
 =?us-ascii?Q?yGEhoEGY2qSVlVPppK9zF7tmZc/PB3oUH9+B8WV3KTnGmUCoBA1ar31aykjZ?=
 =?us-ascii?Q?oyG71YjKKpg+t0Hs2/Em02YEdm8y0pVfUNQNmQ0gelL6atJJAussyyiRf9At?=
 =?us-ascii?Q?5qLQmKWyfGrDxXdCZ69m9csNG/8OmKcMrSoLqJWbpHTflcYnU1O9aVwTgITZ?=
 =?us-ascii?Q?O/vGnQ7wtEWZnwAkVbI11/mDciM2VV5OBuTjowee3Ab16D8feegzYOiAra7X?=
 =?us-ascii?Q?V+FdUKsmjiAc8ccVnA9rP3e+ahhiHVe/hOXFomEFpII+d8kvrXYn4nFuNprb?=
 =?us-ascii?Q?Lu5g6aKiLHP4ZaOZib78gMnhSPhfMaSm8WXRrUAGQO5fTtsbNUY4hFiihezt?=
 =?us-ascii?Q?NH9NtoxmuwVyeJkEuuJ6x0bwF+kjUhHZqv28meRNNdKll/5jlgGAVCPE1x3W?=
 =?us-ascii?Q?xAewEGxsA9uAXLvM2DvhWMyPQMGdu6p8pOdUn1YeKrQlVeKnMfsQWLi6de1J?=
 =?us-ascii?Q?ZBiBZCwYLtXU0ogMu8Q6FeFPuoeH2TAckXGFEaprzQ+ZMB/+m6sa5uHsoHyY?=
 =?us-ascii?Q?lwNQuGoGsprUq3QDHnTwPXyIO/zgXEOnBcqnE4t77UAXeuRpjXETBxod48as?=
 =?us-ascii?Q?exV9YdX0LhMuj6G5+/JBRj1zNlh92eI0HHBRzAuSEcDrkMLLaJxVkQOm1DnU?=
 =?us-ascii?Q?t0nxxj9tYkQXbos+Lc9t/dNJAc/P+Z4Mx8/0/NQTTi+rsV/ex9PkZ3gwLVMv?=
 =?us-ascii?Q?c1/iTVFz6uTbAT1LtPZk5xvOXLueisP7/gaLZFR6d8DYyv6jiLrVhco0TyRE?=
 =?us-ascii?Q?WsoOFfBj1nukdjTNeqmMUszjugkx7tUBQSoiF0sSFK8LCuRrJMe4OjDEK8H0?=
 =?us-ascii?Q?8xGK+1uLchG/mjAqY3m+QIxcF/7zBm0WhoPW/JeW7KUqh+M0hLDi71MWWSIZ?=
 =?us-ascii?Q?ky1z0+nVv0GlloF0EN6lRuBnIzLx4WRWf7nTqU+0Czb77zuncFSrEQ/ikyD0?=
 =?us-ascii?Q?qbZRACjc9EpGWtNFR3bK6hAp4ax0/rV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkQihOwRcEJDVSxQMXvbkmIjXV690bIsporCWtrlGRs9nPHWzseZHk0OPm+m?=
 =?us-ascii?Q?7hqgUmrp8bwZ6JwfcVQ9APRFYAFeB0sx78B7L6Z+H2xsqxq5YPtlH5M6dZ61?=
 =?us-ascii?Q?l2DeNg9aZ5m5ObhsIQpLGX3tmFiXVf/RLh/3U83Z/nSNN4IrLaM/m4GCnSaS?=
 =?us-ascii?Q?SSWvdb36n2mnFcqAxZGiRwSwr1psRKemYbySDHSzNIfaJsr4vDakI7SDRlAs?=
 =?us-ascii?Q?sX4863nNa93byASDERp6A1wJGW0RkTlQfnIE1brqUsC6jpTBKWEMkQIicq6x?=
 =?us-ascii?Q?H5JZNHK+eyL0yubCSir75hS2OIdSEmo86PJQhYFOFv7BZDtFCsAztewt6/RO?=
 =?us-ascii?Q?oBhd9ocFEP0g4pOFHNmghoq35hrTZSevbKm1IHdERcKSepgUT0H1IVyhA2s/?=
 =?us-ascii?Q?DdlV7B0emRiIg7t/GRo+sCJCZeUmWQ79SxkJ30TU6R8iUo7GEhkHGwwUUZqH?=
 =?us-ascii?Q?KSYrK7+4cdEIvqWtE7xEACVDXatWiOqPjTCV5/q1fP0qW9PgUsnxvCPyGALS?=
 =?us-ascii?Q?PmNMScKhUAXsf8pdIgOS5RenvjNYbY8ZN1npb1HJLy7T9SFLyzqQYr3+dpbn?=
 =?us-ascii?Q?3mbdPr44moTqruvNF9jcEQjfMRcC23exvsiohZsGjLndajAA3iEm9nYjssmF?=
 =?us-ascii?Q?BQipaOB420sX9MSmLqgI1aysqlxkgX5fPz4aU9ZH8d8Ga3VJoOrW7P73NsWf?=
 =?us-ascii?Q?SVVh7wf7MZbzB3E1gN3vN8aO39Fc448E4ExDeqGNcQAmF6GNokzFi3uZ1Lzw?=
 =?us-ascii?Q?kPOBh+mPHTQddjjzvDVZ1D317ZomuLVe5M/gTuIuMviHYkywfaAxItMd0qRX?=
 =?us-ascii?Q?gz17TteBOld8G6M3GLvgMcoxwHA5coRDGKeO87xUVNEs2cd192wGXWGzDsOI?=
 =?us-ascii?Q?iY1/SweNNsodCR57a/BqpbPnVQ76rikQ1Ph7gDVv17zceYD8XmjnALryCXKg?=
 =?us-ascii?Q?sUkImpUiLe5NBnOiiX+913nLefthAzvwc4ltoq3QtkWz5d/zXHqZ1YwsmwHY?=
 =?us-ascii?Q?YWQ8NYV4cJvDSUW6UwFNhGHHCK4mthlEq3dim1m2LaxpsZCK6ZsBfiWVLoXT?=
 =?us-ascii?Q?1XObdUeZbKPsS/96c3xvOyKnFokbItB9SQf/mRtgYyLD2qGJ8Krb5tOpL+hK?=
 =?us-ascii?Q?ufeVPSoGhW+5mW4GkhaASt3s/MheQXLWlRc30IBUVL6EUTH0WOjYMznriFYA?=
 =?us-ascii?Q?QNyxDqMv3GmXoYUUc579N+uIsKtq2AP6itMgQgy3ZTNI+P5+JaO0RIbHEdBf?=
 =?us-ascii?Q?yqBEhiDfH76sSI0hws1r204nqs+LkT79Kn4djX5W5a+ZFYznhEjB8JYJrQjw?=
 =?us-ascii?Q?Qc1k7zhOLQpCAQhr7Ui2OyXxHiH4zrVGTgaddctMl/JOSTwW0jf9fq2cJ/lU?=
 =?us-ascii?Q?M5Nq6cGCl8aAmTNfu2b1oTcs+CDoRlN8SOJS5+gqh0DnXxu+8KDCuhP29XpA?=
 =?us-ascii?Q?4rxi/4aNhIVZCl6yEDWyh+6FboDrtD7l0ofqK/mLE4AyT9OiF/ArKiwC2+Dg?=
 =?us-ascii?Q?aeKS6gUbbCp6qmnLiFrmKHEoqeG2NvtWOzyzXOGMCdZdKz9W1D/S5lrrlpgf?=
 =?us-ascii?Q?ZH2oMv56vVHY1LoIVZRPgG86M3WYpqPSdulHwhF7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85df5a22-4055-4fec-5c93-08de2ecda338
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 22:29:47.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niyIcFUaGSjaMpFCSWlzhN0wcyKoNa2njCjREIVWL1/QDtfqQfdHg+Dcus9TePVtpko0ATI40ctKAgEU0FA+4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

Hi Peter,

On Thu, Nov 27, 2025 at 04:39:48PM +0100, Peter Zijlstra wrote:
...
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1119,7 +1119,6 @@ struct rq {
>  	raw_spinlock_t		__lock;
>  
>  	/* Per class runqueue modification mask; bits in class order. */

We should probably remove this comment as well along with queue_mask.

Thanks,
-Andrea

> -	unsigned int		queue_mask;
>  	unsigned int		nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int		nr_numa_running;
> @@ -1179,6 +1178,7 @@ struct rq {
>  	struct sched_dl_entity	*dl_server;
>  	struct task_struct	*idle;
>  	struct task_struct	*stop;
> +	const struct sched_class *next_class;
>  	unsigned long		next_balance;
>  	struct mm_struct	*prev_mm;
>  
