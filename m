Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6891A2C04
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115159; cv=fail; b=cRtdTxEu+gjHMxZuUG151a0NcoLvkp3+edGmEo79mw429OCdICGXDQpdwwTrBkGs/4gPZiZ3OkUvnc3rgh5+1YXGvMAXJMOkpsBV5hjCv4pgttjjnB6LFvF7cx2PtZHNf39z4f7TQS6qTdOhSNvNEqw/uHFnPDfSeUTUnzeb2zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115159; c=relaxed/simple;
	bh=jtRa8X/NmJ758yFqGmcNWGRK7/Y6KPCgK8Wkp/Mx/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mnRE1twfnkoh5uUcJ9rlfLsK9aCRGjFMHtiLZQ7Ug3rU88VJZwXQ6q76YsSCWl/W6yunxFOQM7075sj3BB95by81tMh7zNSThl8BcACEyvWmzw6grx2BT1U/OJIlM0iZ4K7xUBnfnhIIwiebq4RpWA92ypHT7/v/KkeGn6ybF4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sUaFFcX2; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sUaFFcX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOwcNS3Y0i+aYVgFXPOICuxmS9vuIuk1TmcO3yzkMAnDDrSgfVM2KWzvrtGlboAKgtR9SFmUyfNO+XWTG3aEmosugV7i4lPZmSESxcWSRsCLrgyVlAZMoq5gRtBZKcXh5s+SPwsVkQw2BLKGLFAUBPPisGN/YupIBnhOaasDNpyV47/4OifN1nTV5s+DnSd/Cwuo/WudrSK5F/eS513odkwt88ZUL6Axvb0ZwVLZTbWCymRPySLMaBx/rBzyUVLmma8UA/4S4Zj5SA363KYRugcDw2FIIl+8vHReSYbnK7AaIIUTtlFfxSwrSa+nsaa6CX97GJENJ9QAGS+fDTcg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/r+Nm4dAY+k7MMK4ZBxvJ5WBXelnJkYs22yi3oTwX0=;
 b=p1PYaHHRDBR2Wha1/LIS+khp9CuNdiK9ltIB8/gFJluhZU4CMFnh1zICWMOlCadejAEQffGrIyd/By4Hvkc3q1rW9yxNa3u1Blj85SWPYezr6y0V5Ysjiy+4pRLH3RgsWn3HHczH9urC3YIN4zV9tnQEnnjhr0NwlRSGzi3Ojmi1bvLRyHHZ++Tg7L9pV76tD2WP9E3KuhWmu4hWIWj+BMYDiF/rVDv4kVf2Xeu9iTP0GLyBzbc2MURv4P9ERRCFv6JbYRVRI0ldVvBuiFRIYInQ1DR8osdSSsSW1AETu+7zCFGdqs743NY9ZMzUnRDTwebNY/GRfeLBoryg65UeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/r+Nm4dAY+k7MMK4ZBxvJ5WBXelnJkYs22yi3oTwX0=;
 b=sUaFFcX21Dtf8rexysYDXl7c8k4sqaFqQ5q4oFU6qt8GdN/grsT95zuK9Ltqqm2DY6+TSd1GcAET7pm5zfZxgKndsdCmfWYv6475dAJD/ZOj43jaRlapl4b2kxmSMfQnyD6uhZ3Zj9s5P3ZxEGEz0Bc9uIWWH3blx5uiR3Sc6OecGgWwEolD5uUtHLRnXk3HGHyLMtTjKFUZj01LUDAdXS6hPUU2SeBnziykvQDNSnYNzcaKIRfQvh1KBHXDIMYfkEfCCrioJzx/yOeWhbtUDiPHEIkfZNvDDMurN65iI3O7CQbf5IWpwqLiGcjkIZuSEGXi+Ug/A7CgfBIFct0gqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 17:45:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 17:45:54 +0000
Date: Sat, 21 Mar 2026 18:45:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix inconsistent NUMA node lookup in
 scx_select_cpu_dfl()
Message-ID: <ab7ZTcjlC1sAF7su@gpd4>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105503.869337-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: cd459c8b-b587-46ae-2819-08de8771b367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+aJ7Wn24WTpDS90TqeOC+DfLZGafysL37Q6TdeXXe4iFGPVsjbYFvuVTDJ/ySIsCwo9mQixV3FGUfS+UkXPAlCnvuhYereQuacdu4sT3VVJzVAE9GiRfzd/Q69RkmCMvQHmT3bD+9mB2PJWNTsxYIB3mmyuMwi+QbWAaFlfJ5ZVhMT1CdjfqZ4V0ZiHOWj5MTOjAy3oZ4pROLfcQ8xFUdgUOFkuPmM93ZAocJVGJb+bMTHR00cBfBIQgv0gzA52H9gIvmGdONtUmmEF4W6PAJzuqT4ixhD8czCuOn3GFujSq+Xhn98+RfLmLw334/LlyjrGTK312iV4W/tgLf0iOOHJI8pDRMVo4qWmFhIy//jYs2Fzwu1ZeRJYJlh0QQAArBqsvvMG+f/Vft1DchXQ9JpnKvYTdYyC9HpH6zNleQOcMWbaO6746c4UcdFZgKFWXDllZOBgZTssaFEOg32lUW1+Ub7sOU9NVbC9XXBpIioZd25bB/e0K7f6t2bX5nS4hImslEBtwlfN2Xb6hCu8ZHOZxkcxsDFClVtO5RoKuerP1nJGacBaYiUvKiCybojPLPteCxPwCsHwhPT90R7r5mCyzAKburKWZNyAIbjWA4PfUdY0juIpoP3j8xFGxZIkUePeYgc0ZRkyuBbDQCn5jFDaApEF52PoSCUbCSTrB0N3tgna5AmZpoaynNTdeGzbyUEhtkZGoROgimQOJOz0FPYzuHmRkMBv7Au/YLH7MOQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yhymLBiZ95niyUDGGFXnKJyPw/rTo46ZEUG0+LCcxKqffRntQ+HPSnVwk7H?=
 =?us-ascii?Q?+A8b3l/RAiTde+HzYLi04QQwjcHLXrFWJWLY7lszfNPvGmCGFuLM0rHNVNMN?=
 =?us-ascii?Q?xRwpD9p39NsAh9uKsX0pVPO7GFUwzJtZqxbim7AocT+yQmhuD0J6bWG7K4L9?=
 =?us-ascii?Q?BeWii48fYdH74KfhjG7/NG7t4FYBPut2C7h0nbiCdN8b9i1L33NEzj2bJIP5?=
 =?us-ascii?Q?8KFnmDVPBA4YkXP+G3DDLJFZ0/T6krESbZigHYwJBHWepRAbRKAfYjamJh8/?=
 =?us-ascii?Q?q14bloWeTQbiceBDZi6PKtH1qa/Ly6SBimsl4PWG06rCRrP7FgPwvIG8qaB4?=
 =?us-ascii?Q?52SvuQmFhfNfYteNJ1LmIeyDwdqB7BBM8kMH6i+4E5EZakdEbDcR6qwJsNGg?=
 =?us-ascii?Q?Nl/0Zgxth/d1lTYyuLv/J6eJVTLjHCqo1CeGaV9uJ/j5o/qv0V5hJFAGvrHS?=
 =?us-ascii?Q?Zf/1Zz7N2cgW/dI5zjpfAdhqRpgbDT05062uFYILaZx1DxQCGs61nUaQceJn?=
 =?us-ascii?Q?LbH5sVdMAhZF+K6u5O9Ex71a+BbM71eJCfDvj5qJTQkG95JbOMLpUgeNKZYK?=
 =?us-ascii?Q?Yko1shiK+rhjv8+N9wLkym1uJshcTqCw9fb8x8i4aHl9ns5WNXRKcGh4ZvTn?=
 =?us-ascii?Q?gyFm2V3ZtRPVLT3fdX2/XkOD0eJQ6pHUvmLKjITC9O5bN95TMP1zvdNGMnCY?=
 =?us-ascii?Q?PSSfsr6qbU6Y0EhAWC7Sa+o6CmYq5wmAlxaIRZVsrB5Ha48Cm3WXDtziMXdG?=
 =?us-ascii?Q?CCCOiSOY5h6rv9vGdDpNYSwlHc7CQPR12oUnoqXLtQjpfQg55XlRDhzADVZ0?=
 =?us-ascii?Q?FVBFwNTyVnSW6w1LGGnezpdk/dF4GftAG1Ox+jX/5qsUDOzQLC698VxpFx6x?=
 =?us-ascii?Q?p4yTHMrOH6XYA9h5cn9WYHNxYBnMtp/49epxSHxQxABBVK341aS/UvdnbAgd?=
 =?us-ascii?Q?wsBQU9sQmB2+iM9+TtzOAPgUKSTq1SVtKLYC6uvdC5KfmvlXtF+GvEXKu/ON?=
 =?us-ascii?Q?CoOPtY5NcU5R8m8+NEG3np3eMwI0U0H3Q00mGXxAkpDe2WjuAngw9ERNfbwd?=
 =?us-ascii?Q?qbBNw1kx6vd8PKeSYs3IgLthUQRHZGk/pHEQgnuEdk8h7R2Suk+04Lrf3xS9?=
 =?us-ascii?Q?AsoX/VXerVnyaZbqinwDR5KyoJvygFAg6iyFRQWQb+AQYSbqM3ejuy3Lwlo6?=
 =?us-ascii?Q?C3TGUgwlTM7+T1j1Ezk9ZLGfYsTLsuDXa04cVKCHnsafb1TAMS65ESW7cLjR?=
 =?us-ascii?Q?qBClP0aHL4+ytszKx+EJVYj8lm20Ae8AF9dihdr3eYjlawrPosSgROGNJvtQ?=
 =?us-ascii?Q?TMspRheHQErJ91C72jp8N4/UXsfssq2f5UKzoOy31QksGjUej6AnvgqdybIw?=
 =?us-ascii?Q?i1iU0UoIdog5UCnjkVXi4Rv7ANxRgiW5bdQ+efGFI9StH3Qh4jtGRqKbb1XT?=
 =?us-ascii?Q?sUmlg/4OVYlUIFgLNJ45PCcGQ5mXobegzDs4WjWwooHregf2PTmOc9JYCskV?=
 =?us-ascii?Q?Zt/pUPMASoDG6QSF2NiDFg0BCSJ9NDyK81wLdLuXHeS/0Bt8WzM+QC88M5YI?=
 =?us-ascii?Q?aEXfCon1yHW0D5AbwkDM9x4IUn63YMTovPQ9i8UGt4bjl+2G1E9G4cKQqAht?=
 =?us-ascii?Q?+XY8ddW9Uf1yRQAePShInnyPiY4/bC+/kS3KFOqvqt3mapthBJjw/4devttv?=
 =?us-ascii?Q?3D6oiI3YuP2NYsCGHYW/28WqtoCZBWYKrhjdT8wsyBRnvCY32VW0lpNtxErP?=
 =?us-ascii?Q?DtUnLT71Ww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd459c8b-b587-46ae-2819-08de8771b367
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 17:45:54.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr/tfmQDkHx9J0gQ3RszYOdgX7i8Gpqz8o09zYbKONSUCkagYuXfpmImLVQiuHh3F3Fyf0oqn1vr1TtpSBHJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

Hi Cheng-Yang,

On Sat, Mar 21, 2026 at 06:54:58PM +0800, Cheng-Yang Chou wrote:
> In the WAKE_SYNC path of scx_select_cpu_dfl(), waker_node was computed
> with cpu_to_node(), while node (for prev_cpu) was computed with
> scx_cpu_node_if_enabled(). When scx_builtin_idle_per_node is disabled,
> node is NUMA_NO_NODE but waker_node would be the actual NUMA node,
> causing two issues:
> 
> 1. The (waker_node == node) check always fails when SCX_PICK_IDLE_IN_NODE
>    is set, preventing the waker CPU optimization from ever triggering.

When scx_builtin_idle_per_node is disabled, SCX_PICK_IDLE_IN_NODE won't be
set, which means !(flags & SCX_PICK_IDLE_IN_NODE) should be always true,
short-circuiting the ||, and the waker_node == node comparison is never
evaluated.

However, ...

> 2. idle_cpumask(waker_node) is called with a real node ID even though
>    per-node idle tracking is disabled, resulting in undefined behavior.

...this looks like a legit bug. I'm wondering how this fix impacts
performance, will do some testing. Nice catch!

> 
> Fix by using scx_cpu_node_if_enabled() for waker_node as well, ensuring
> both variables are computed consistently.
> 
> Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

We should also add:
Cc: stable@vger.kernel.org # v6.15+

Thanks!
-Andrea

> ---
>  kernel/sched/ext_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index c7e405262697..8436c7df0a56 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		waker_node = cpu_to_node(cpu);
> +		waker_node = scx_cpu_node_if_enabled(cpu);
>  		if (!(current->flags & PF_EXITING) &&
>  		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
>  		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
> -- 
> 2.48.1
> 
