Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B5313272
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837549; cv=fail; b=uqIyAcOligG1rLrqqmmoLXDeHIdqnIBDNW8h/yWuJ7zLYvfTGA7Ymb7ZqC5k9+yJ4yGutZe3jj0J1H57bUMI1PQ/K2AEtH8ba5rE57azHrOkA5JfTfA6oBnKSyLLHqyJRE/gt20XXJlIisLwdnzsjKU8heO36ou+StKiV6jkAZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837549; c=relaxed/simple;
	bh=2Zs/nsO4+Npbz7NlwY4MKMOZ7F5bkzMf+w0IBe/C2xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyzdYwOdcQEtyya/qEk2x7ByLQqukGFf2cAIMOXtt1Cz8BiCLkg7/lK/SHmUj9xgvyYJ6g1Rt1KQCiygU61v7U+Qgz1YF9QVXKFvcxJVc3saFum4+P9B2wYi5DJ8R0992I2bOuzFhq7MPh7gT1BkbqZFH1MlFlpKKrcQP9bTAfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfXwTbR4; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfXwTbR4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw3ksOsyYnbg2eKqdudRmQlv6RlQQvm1F2H6mz0+yx5u5tZ/4odNQ5j9618yCsUVNpmX6OyDsvPW+r4chYznFJVqW3T/iSGOB4NNisFQnk9OzTd8TcjLyli+q/n6YoBDGotmOWvNKuV1Hz2IsUJSUEW9Wlxg6peZ/+ZP9E3azlVVnH18hk9CPDWBcDmEXkjErZ2mOFHJUUX6IXLTk/xSmrEl4Kp6wQpD41ySGnkLku9PgssyAIO9uhuQdBSk19JMJJodmPACrhtGoJ3IWxrov9rpTsGS5lYuobwaeA2DWCOdUhpw2ILEkirDAMArppTxVQpVre2q7RIDRan7SJ184g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBPZhFfxDzYKf6O7lY+ACmRnkOms6FT4CpFR/8OsIt4=;
 b=q4HcVyNYeRmTcNDbecmWGqIbfjsMYj8EfPD23XV2iqhp+OBUYtAStswID3E29Gokio6AWvaiy9YYdu+Asg80aCbZkmDjO9T+F+EnzqapVv8XhQ45YtiDT3G0d9nduT+hswChJ9X9rUvy8rJxFLQusyUZr4fEz/bgCVjjYkPl8xvW6Re5nS3zEiXCnRDPGGM2+syfg4d3yUhXXF65TqLFzjgIqtohCpBDgoEhuE96E+wwm/rYZPs3/ETlhr2p8yVGA0uprL2txN8tGRsc8DEoSuI63ePGghKCwN6xYxXSLajuh0uIxkXTGihpwbWHTJvj6NJqv5Gd64QxSwGaWhx/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBPZhFfxDzYKf6O7lY+ACmRnkOms6FT4CpFR/8OsIt4=;
 b=kfXwTbR4j37bwraOhk1Y2YuIIQv+7gbJJa0ROxcCrUQVmu073a9TIdCqE6Qx3y/aMkkmZ2KsL7FE3Ri+RcWXiwvyHCO1uxDdXG+PW91Du7p8xGKE46uwV67XcVkjeBdEvyMoR066EnIs9oa8pREw2NY1NIMyKt33EAwaglr2ExNOXjXHmyyjKvHgW2x7T2wrkJr8edZRRvoJNOh6qNGVqZinOyaEW+OOsJEHNU1Op4ptUXnlGMEsEjDW+j/bghYPW27aTpfExJijhN2fgBwSJbwFMfla36SIgWKns2jNDrPj4dJ89Dm3lIroVskLZE4Kyq5w6YjAPl/8q3niowROJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 10 Apr
 2026 16:12:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:12:22 +0000
Date: Fri, 10 Apr 2026 18:12:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] sched_ext: Track @p's rq lock across
 set_cpus_allowed_scx -> ops.set_cpumask
Message-ID: <adkhXirmNiubcgFw@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-4-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 29219f43-f053-40d0-02fd-08de971bf274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ssP42AJAry8ra2TE5GKNfOsV+oA0AmaUQWjj9juBVS3y4Wx+lpHc4HgFBxVhLJRDkl6K6Pl/nklNcBrDTtVAZ/H+fVPoIbyIF1omdqKbXKOTbXVPA5yJuO8+QZ0cEo0HJJIvr0WBPtsn/rEUe97sM658Wz43jnccztKeHLPyFsKSRyfojzwgMXAP1nrR6CrwyzGS77uCUbbksRN3KOp/g9iiZisAXaGrHVeATeH/G7bnwWOf3oBUdH7FcD7Jt1/GeR9i+sZHRrrOyup4+hUg4YD6p6k8g0hVD2r3AUB8ftVieesItJtHmxsg1fmQ0l+ch2inN0LCllpN0abRWUUTZR1lTJToksaHf5IhmVWxO7ZJLLrze4Yj+Nk9KWUQ6sqiL/cVXd7GwGjjF1ehf/l0gxMtTGR0g1dP4YcE03cfvqMo/vOA20xxgcuO7Bu72yB6JgKdIzY2z6Tf8pvGg3D28ePj9xwcPYw5rr5OAuTxuk1d09IW30qnpX/BS4ixT/wQX+ooosxmOX6KGeV1cAAKqTM6y8E7dlYiInb7hPEQXgB7Ydjjwz4ODN1pSpTyPEUu9u+m+unzH+caeNowA1o6l42ysMDzgVKzy+Q0tnCdmVeg0k8xGdjuxGZP9YgcKEC+M7QUM+cN8eEcFf/paSrh7wTgBrxPFCFfmVKj7/fVfedAikTlF/F9DK+DrW2b4YffhSXRIefXyPf3bQ/AeBfd4urnyGwsgwEuOIL8nM6p4tQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxGA0DSD4rKVmVzIc+Vu2zOsjltTJ3BZFH0B+LHfLvNaECoWkb0axy4OzKIo?=
 =?us-ascii?Q?Nt+rsU0fJh16xnzQqLy+a3XZvYyflJfzNqfPPrbclKATZKVMu45eHbwQAbOh?=
 =?us-ascii?Q?C2ZKBSK7pXU6DnhCpRzyqagI55o6441qiFkL+0COZChuScm7TXNFnIUEqRrY?=
 =?us-ascii?Q?IsoFviEL7XMryGiX2tpFYL6zyolKasy1087Wx2H46d6dfJ4N7okWKkGDwLQR?=
 =?us-ascii?Q?hJlr8Jxg6N0gejIJrX0o0t0HhRnopEIgDGTURMBoiBYHP7td6UyxBnhBoR9f?=
 =?us-ascii?Q?/UVic0fCaDAQYCq3xWD9ZrZftqVczBYI5LVI/ohguD0uLtA8r9DU8J2CNTvF?=
 =?us-ascii?Q?bVv9fA6FgpYKIcDTs3jPDw72RD0PAlrOGqMlFSuDUL1Kl2znBaz2B8+8oEzy?=
 =?us-ascii?Q?gWpSXwk/RaGiEmfZcNYcWVH3UzkIhLtFW61c0iOJJzd9QgnAghCQaFMFzkkh?=
 =?us-ascii?Q?i1pqjx289hB/wWU0I9AGgm09KcE26ToNIF/biPCqtq/R/rXb4dh0cvcDHIfp?=
 =?us-ascii?Q?75BS3nAp9HTEt7qU5rRpY2ESlnEThrYaHoVUJ0GxbObK+lnQifVU+OBZqsFp?=
 =?us-ascii?Q?4tKLH3KZYPYkZlnMePhsIC/nRRZBPOUCpLZNt17ouSOCcGC9ABNuAU36XShq?=
 =?us-ascii?Q?GrW1APkzaH/ZZGqECrX9YgyIFXEYRZGW20dtd41b8VxzbnKsTUxvybnU5PY9?=
 =?us-ascii?Q?2/O/YZ6it4Xm0HKR0JFKAScd/Zto0Bm7s3YrtUMov1nAUvrldLWMbpljIVlb?=
 =?us-ascii?Q?OzEA/0xQAc5aaXVuCXjpsaJfo06/MTHgbsgvRXt3X0rspML610xc5Fog9XVr?=
 =?us-ascii?Q?zS/4zT/nYNg9gQXsQL3g0Gi4VV5cuDZPKJvfT9joGjvmrM6vAmoG/m6Kjnp3?=
 =?us-ascii?Q?4tazGlEzLgRtaCsFACEjulXGOBQokdgpXsg0Abr7fHH+ma1hLLzViDb8dflJ?=
 =?us-ascii?Q?VZhm6uTRJprEfIux8o4qd6Rh+bOmg3u0dojoGXAogY85KKKbx+SHNlm3Hsu4?=
 =?us-ascii?Q?IuhXAxvtDXktkK4c//0K4c63vteGI2HEqp9l+ls/W4liyEXQFODm59X0X02w?=
 =?us-ascii?Q?OG25LN2/Sv7YQeUbE1ZM5PfrQFIwqxgj7W0dZFJiZHMDFLfS8d4gOj8cjs3D?=
 =?us-ascii?Q?TW14k9wEsJKsQa1U9rjED3+b72yq/jGNa/nj5NdaPCX1X7QgNfxucdWZQtZp?=
 =?us-ascii?Q?VrACiBxJgy0N6gP1SiWUhSV8y6ku8B64ThRCZv5BiQhcoXtKJlop9+SYDoN5?=
 =?us-ascii?Q?IVgmz+y0XtEceg+IT0saXx5FZFB+da4qbEjXm2Ejp/8tJZEpEvTatx76qeMu?=
 =?us-ascii?Q?Tc5pD6mIhr3vfQnfRUogoVymPj7J6CR5LkmkwKrXX/YZE28LInZt8uBHkTCx?=
 =?us-ascii?Q?gMiAXyBsnamz2rLu5CjfH7U49zwIEdiXnFtqEbgtqf+JOq3hiVFRSUcrES75?=
 =?us-ascii?Q?6RP/CuthBy8OpuRf3htbdpOeV4GNYX5TWqm2tyuLlgDB8KlcnR6RB4WY65AS?=
 =?us-ascii?Q?2tzmZFLctHPxJANhA/gxFKBJRSzQbKH/4sHnyxA4ocB8lgQtNDBQCg/BmHbl?=
 =?us-ascii?Q?AHa69+12s9QJtsVTdnrXoR15EITWypvVnDK3cidtDLmGW1fgP25VlAxgNSKv?=
 =?us-ascii?Q?4rfv8P59BIceLnQjk3ZeXotFo6MqThHYHOBhGBXph6wrb2d7rZlv3IALw5n7?=
 =?us-ascii?Q?ToeWeKeKrNtseu7MYe7BG9OyNweF7VOicF0pzylHhFpO9FJbK7YulVKNLm3F?=
 =?us-ascii?Q?6RLfc0riFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29219f43-f053-40d0-02fd-08de971bf274
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:12:22.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHirJfhirpxUnt3Ie1EhUHk4QNeAC7V3qlpWsypvZ95nLAHUeWXxp0AFL3JdIfBFWPO95Nf5GDnduh1bgvEyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B

On Thu, Apr 09, 2026 at 08:30:39PM -1000, Tejun Heo wrote:
> The SCX_CALL_OP_TASK call site passes rq=NULL incorrectly, leaving
> scx_locked_rq() unset. Pass task_rq(p) instead so update_locked_rq()
> reflects reality.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Maybe add:
Fixes: 18853ba782be ("sched_ext: Track currently locked rq")

Apart than that, good catch.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cf441fb4b1ad..6ca0085903e0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3360,7 +3360,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>  	 * designation pointless. Cast it away when calling the operation.
>  	 */
>  	if (SCX_HAS_OP(sch, set_cpumask))
> -		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, NULL,
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, task_rq(p),
>  				 p, (struct cpumask *)p->cpus_ptr);
>  }
>  
> -- 
> 2.53.0
> 
