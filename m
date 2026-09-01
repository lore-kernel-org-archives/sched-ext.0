Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6946DFF2
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294508; cv=fail; b=DYpKJ2boocPl7uvL4gMMl7bTmpSSkyBVbQ02NQBO1iYbdkuAhJcSBD8VtdBn9uWXtEivXAPzvghHAfLN5gNTPPk8cHtHlBcaPTZzdkjjTpQYcqu5J/a5+V/5zkB4Y/hhM8lIZCAFQ/rkab9+/BCDyy9d6vzMFoEB6xPISTDD3eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294508; c=relaxed/simple;
	bh=9IySQ2bvBIiWIGUW41rKkKxnElHFpUAUsq1W/DIemEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rtb6E5j3SzZ49hMQP3N8V64iZ0wxbmgFjSUM9bniwRiIOBlpHWI7f9bTIwGDz19a7bSb8NLDH9n5ew+kcJdK86stONq6vPFjWySDd63xnZ+KFfL/wrRjgCI7PgTwLRYdK2nN/CAP2pdAYS3nbO7zjW0r4flgeonTNexH8U4YZkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dJlmcH0K; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dJlmcH0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQHi9YM3D9VY5jtVbPBjb8Pg4Qe+GzAS/zJm4GveSe1hPqqxdzBvH0ApyMeA3RpL68XP19Vf5DHm6FSfw5WlSUEFeiZmoWwNLMTTwrJL1xEt4gPSmG53zhqvqzUmilJ/opBa/K+0NO1gz6Zku1kPRdK1xgtDCHL8KJd+a4zk4wAotT+XmbOXvqut6Vml8uwbnJrOM9jxiA1Ma50kvxyZJ1NKaevH4Yc5txJ9MLa8KfIoE9chV2Pj+RQ0JfqDtwBK4xQYWBTr4R4+48q2ohhz6IShuYjasmoGnSe+qUgv0WW/uABsIcKpN3A1/5nXlYbEthf6Q6zIeHMBtEWmJep0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AznXV5lNyjgg0Toy9eUxcdpwbvL8TBzVr5sRT5t4aDA=;
 b=WJ8U07asRx8o3bWakPDvb+neBtbA2mYK/hcktnderjeXLlsj0mvbG1eaDAviHzdtE9V0m+yjSnVP+isVTFXz0gOXiKEUMHibhgzIm1PNxP7LVtDUsCmJ7QSkVYCZBzifTqJXko5ZfOM7kQp+KdyprksfkoI/ReCWVYF/rdq8K3EQuF8SVWQlfhm2GeKQg9lD/1RUKg/btyX/S+P3QHNxgv3FZaoOWXy81rX4dbmBEW6PEpOTRV5SZu6XlhbQImIgDMC3CJfI61s2YtJBBJs4OKqJ/9d8dg5EblqU8rUQh8PJxgNB+MBm82vnBjR/Be8wrslZBtWxiD+Uc7jNAMpwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AznXV5lNyjgg0Toy9eUxcdpwbvL8TBzVr5sRT5t4aDA=;
 b=dJlmcH0KPffWfmqsGxh8Bp6E5ESHjz1yN+0rvcJp3v3EtQjvl4VhKkXuZWhZxulHjFGeinbyK6MX1loV0vTRyqKbYjR4VYYQC6XX7N4Ce80uCiwXnNzCMlxRm1IWOGM/HzyllhdGdAQScfGG5f9dFKDGzZkGMBkCCqK3d3Vnh7OsSeKZypT1yM1Lee3sQRo2Px00hUgRHgvEQeE4hFmAQlH9KzvK4tZireZBTPZuQyPAtGBkAYa38r/JlljKf58KxQhGqzBT2Sn3jwYYsw9u0guUEeZ45UT0T+2nsNat8Rkwmi1fzMTL1YdJpDRF6U+0zuPhz+S9yo8drs0eTiM4BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:28:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:28:21 +0000
Date: Tue, 1 Sep 2026 22:28:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Wanwu Li <liwanwu@kylinos.cn>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject NMI calls to lock-taking kfuncs
Message-ID: <apc1XBAIV3AWQ3jt@gpd4>
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
 <apcsyS2j-N8j5-BN@gpd4>
 <apcx5yUysXEuEYAf@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apcx5yUysXEuEYAf@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: de3055a5-1cff-4125-10ff-08df08679093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CSogJRYEhD8L1FXTPuDQoIlP2yQiRM6MFiaXl4tk+hIpRV7GOXXPw+BQL2LZ4Y13L9DAqOr1e3n48MOzYkb13oJHiHVxorYPUoSBugUR5iYtrCtcCXqptDgfqQyhps4TSvP9/4XBV1GaKUKW9QcxsVaUPQQ+igxd1eoYzgDWpaxMs5Ftk/6qXb5kurK/Y7qa/qsmBYDkSmrvnu2GbP/laStqOKGnZLhTDiowXw7ywogXsJKGqm9vjJBhoqgY/CnV9v7Mn7z9LF6urrCCHBMZpctbhc5AEGXiuPvr3/4VH/fD4b36ty5dm1EYUMeOwuOU/3v9Ocvj/Tk7jZ2UcJnhrxI+EnxoVMaVJWhXmBK1Hx2FpA8OwUE3Aiq4jXsCiQLP5reabSMFKvTaUC2HR8C+E5S8MTYes8gw4m3vMcdgKZSKknBUz6AQyiJCXeEBBa5ZG4VO1eWzpt0XNXC1pFHMZnAn7AAyGX7WzYLFGAbFYTaeVvaQbHmGMGA6L8obrZb3stLgKPP8ZTJwfyoVmCWS5MP4gzfUZOj0XwXhf7TQDavViYy9MjXu/EJ+z0TB+2Mg26Bm97jNSGZoaKaD6g56w8il09vjZlVhytR6PkDd8UANSfgXIsVe57uDC1v2AMNsVe+/xyJ7mMQM8x75j9WkV2WwEpnNXOmgHwznNTdePxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzrQNcZIQdGD/3JmAn/mZ8ciMqEj1+nVEHQpS3c+rWe12I2YeryYGnc52Lqg?=
 =?us-ascii?Q?G7S0Xsjy3ktnzvFSTgL3nrtnyrv2Z+NKHpFjm/SvekTc53UlFQjyC/IuCLe7?=
 =?us-ascii?Q?fNCRrrj97iFjQPXFz1qBUf2QZJSD3/9dd1j9R96aq5L0bCVDKxBBBqVSTsKC?=
 =?us-ascii?Q?Ydp3XLjk1qUmJWlEKNTsGQPr9FPgoZhy/5lH4e2GFmPHbUSb5dWFLt0uZc6Q?=
 =?us-ascii?Q?97T7JIF3lU5m/zx4McrZajdeU1C2apeZvWw1bVp7gGVHf0onuD+OCW1p2gVF?=
 =?us-ascii?Q?xowF1bTA5exj7V7WSiSDCqML4p33PkfMRMB4XvPcgVycQ0wdAH4H+iCi+FGy?=
 =?us-ascii?Q?gTW+jNuGDNtY4LKGB6YGbtF/RnrkCW2AqVR4Kj2L+LpcDKz08SY2goZ1D2G6?=
 =?us-ascii?Q?1qmAxqyPPa3Lkh3H4ZjKflsK4c96oaz2g7PWDamNRVN5Ju98q5Ghm2Z48Zjy?=
 =?us-ascii?Q?mGj2BEETuB8wrL5hspMx1sE2XB8Vqq32E+Nef1HuPLNXSn9fkBLATAR0vZPH?=
 =?us-ascii?Q?+yCbgZPO+FoMna7kLTLLcIbqUHqiOajxAgdBPXBi4ms5dpMI/QE6pZI1E2QE?=
 =?us-ascii?Q?FdZE2VZTAkEBeAo+XMMew2r7wakH/hPsVzXyB1kCp7vvzM8WQyj3cowJ5DF1?=
 =?us-ascii?Q?cTdK2e1W3bLY7NZa9otf+DjUOPh0v9B7WWw3LO6SOClvokOeQbo5L/cWuIhk?=
 =?us-ascii?Q?FsQIcmcDRnwUNXcfPOzmHVT5m4Axmk5BYxurUpRnPjlAuDBjBdFJSfAjgtNK?=
 =?us-ascii?Q?NoPhEhEoqLGfTEtJDHOrc+gNhPrDc/3bLNqfbJqNgnU0b+rNqM4AS+/jKKtW?=
 =?us-ascii?Q?YTTMtHzctno3/vsxmdi0lgB2TkiTec6IlhrgF3n/h3gK/hIhtwsVw9JxuZdw?=
 =?us-ascii?Q?54+9RtKhRX14AnkKgJv+70e1HKcyZUKcq5uRgyxuedqZDjXFkvQXmMmChxFH?=
 =?us-ascii?Q?R/AV6znKNCaOUffGlvfoFWzHflMp95poSEwxxu7RTJyb+oXRky8MKRTxFBs1?=
 =?us-ascii?Q?fIY6vCMadUJMxEeYy0KpyqaQFXRAeziFfStvdW/05NBrVim4ULnHinPP0JId?=
 =?us-ascii?Q?/i1ShIKcGj3Bv3coGQhWeMoDz/wW5Gh1AD229jiSOCq44b169uIO58QkKPs3?=
 =?us-ascii?Q?kA3UUBDTznTIdNvNy8CzRkSGLhJkQTdOn3F20E1k/v1aJeVcDxTPdVBlcopI?=
 =?us-ascii?Q?cwBgDmSQ70ik35dA2tXTQ7UqLew9VWjnEPBcJeWld1wH4qBtEHUQsx7Gcum3?=
 =?us-ascii?Q?NRO8cN7+IFEIg4L509KNSP5Y2sIzzyEYttvVuvPIFB3yw9MF6spQ9ukYJzuJ?=
 =?us-ascii?Q?tHjS4r2eSFaBsTQYppgBJEqZhoIJe0OXYgeejGK7yuo8ncQnqSdAVEAC9QlX?=
 =?us-ascii?Q?7OlAGXqjdXzLyuugpCNcaSrPcHrhqHVWW2uK22LVbKRSsYnuENOQlVVkNSOc?=
 =?us-ascii?Q?iPkOhfXG55X3WWgHFf07tKqsrYAKaLfr4+nbIzPWXLF4XpwRsOV7QOsc+Tze?=
 =?us-ascii?Q?LIfS9L1JNehy0Ke7USTssnEnCGu2XcCV9npWeERcgxiWh6oJBc7pvz+GXe9k?=
 =?us-ascii?Q?OA8CMPbEDOa623NrFAlf6+LdMdaSkEPk5oVIPTI2JjoHWRxb0V8v7+cpHemD?=
 =?us-ascii?Q?6SHE84FFWD3nouK8o3plnqgum8ij+Kqd/nNYQ5esVfDZIe0eWE11q/Z5llY5?=
 =?us-ascii?Q?g8Y9JB6/ZbxCXtTHYdbKmxMGGWYWiFRr3Qdqs4LJd8fpjHFKEKeA0lIXHKFu?=
 =?us-ascii?Q?9pXjEr7kFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3055a5-1cff-4125-10ff-08df08679093
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:28:21.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCwqpaxrd86N9Uw0l5m2KlIU6necFk9mkrbZKtsD5+v3izn3rwSG+EG9Qo+U0z8hh9vOlzkclACtbQhiBUyQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Tue, Sep 01, 2026 at 10:13:27AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 01, 2026 at 09:51:37PM +0200, Andrea Righi wrote:
> > AFAICS, the lock-taking and state-changing kfuncs do not have a meaningful use
> > from BPF_PROG_TYPE_TRACING. We could move them out of scx_kfunc_ids_any into a
> > separate set registered only for BPF_PROG_TYPE_STRUCT_OPS. The read-only kfuncs
> > could remain available to tracing programs.
> > 
> > This should include:
> >  - scx_bpf_kick_cpu() / scx_bpf_kick_cid()
> >  - scx_bpf_destroy_dsq()
> >  - scx_bpf_dsq_reenq() / scx_bpf_reenqueue_local___v2()
> >  - bpf_iter_scx_dsq_{new,next,destroy}()
> >  - scx_bpf_cpuperf_set() / scx_bpf_cidperf_set()
> >  - scx_bpf_sub_grant() / scx_bpf_sub_revoke()
> >  (... maybe others that I'm missing ...)
> 
> Hmm... but it *is* useful to be able to e.g. kick a CPU or trigger reenq
> from a trace event, no?

Kicking a CPU, yes - scx_pair is actually using that.

I'm less convinced about the reenq case. We used to have the famous reenq from
sched_switch use case, but now that we have ENQ_IMMED and deadline server, are
there other concrete use cases for it?

Maybe we should decide tracing visibility per kfunc rather than exposing every
"any" kfunc and adding the runtime check to all of them. But this can be
revised/improved later. In the meantime this seems to fix a real issue and the
approach looks correct, so:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
