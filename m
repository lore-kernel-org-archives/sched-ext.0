Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC23CB2D0
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837824; cv=fail; b=nNwyEbuxcGv82IoSJBPvVbjU97SRKZAlshuyb5aA37AwYTaDJMWbGnncrNPdg894QbvK0BfMiAkxiqcgnU1p/XA9dAT14uPQBwzbAN+oh8CdrOIGujvYBDbjN7I+HZKEbxHDHZZrBjBMv0JTBTGNeVo4Xm8DqbSRq65eed2Xp8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837824; c=relaxed/simple;
	bh=Sc1rr6LnDWLBfJYLucjbP7BRqYhwIx0OGm9dYjC+zp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gSt3N/AGhpZ6ampSa1ITFbzao2qJNwsDN4QCtcke/kjW8RNEOZFeKoga2gwy/2Y88wvsHtzxDVYzV4I3zl6VQ+Q8bQ+TbU1MwH9oKvBuyibbA7XChy/N+eqNkU8NG+SHtKlVFVGyjjmrkbncsGsHi+zqcE416Ilkucs2spOISMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nza5icxI; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nza5icxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3qDte+ylK7K5fINBcK7/LWN0aqKoM3hKzyQtXLu6O5/rmctGudfKMc6X3EL/ixoYCWX0wrA0PSxfYVCzV4Kssi1wMcqDCPKzcFQifwai/TtWHNEnZBpvz+4dzNjEXGX1TffUdwLKetJNJujEr7i6q3E8+F0TTpYzcznWgb1/16nwVnrgbUqkzsN7rrYiz73OFu8TC18I2kOES6GoqqkUr5dlcBrkipejK0sXEzqD6kD9X26vKdumrjrPjq7zWeG+pYA/wNJahg29K3gU0qsgQg66APlFAZOQwfSNuSXsOYJazE6yeYsRpIucseyw8Auv8L/GM9FiRAaZ+dFg7nvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMnpiT1Vc31EsZQUPrgSrT8nc82YuSnYg9TvZHBidTo=;
 b=XSEzk/blOFWrYCtoKLTddci1D4kW5A0/TAfKdEgOfOU1xpA3EMXdCLgS+SOQrLHpbgN5/H5dksW58Ih9D6DOWZhtbQlN0aEmBDS2OPDmvLZLTBon5dQ4pFCqGDaRY6x0P6cIzgyjMJGJzUPbIU8WhayB096yOY5XFkT/x09/ALumuIjxBeSf7ZUsWCgUYoMkEfSruI5M/QTU1WDqnZ0NWYrKAvc2ZfAQ2+wY5dhROMdkSfj8Y+38qhGuPrD6SBqnwdUXDp8mEpAeQy/4dQRrpia/i9e0A86fj15TIS4YZonCnFPeosN526k9ApGL8lY7wYEetULhT4oJLsyM8ua1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMnpiT1Vc31EsZQUPrgSrT8nc82YuSnYg9TvZHBidTo=;
 b=Nza5icxIUjYNijuUGNSEHdipGAx3xAyiGrOnNdXT1wVvWvjJfwdzp6yzl7wZaQBePxg+tcyS6yAdR7tR7RwtbTRY8PavkF4INeLi82HjTdtHhZ7XpqtUrOwzJcWGpkpKXCi2KMN8Cyb1FGYJA/QQYxuJ6VsgIUX3j+TFXvYUXpjBVr3ia/rAWWYNbv4SpxfHZhOMLHjmETnE7ABdqENLgbykmVup0FGwpna6oFiucGtjdpctss8IDWtcaffhB6s863lvaOsxp3b6xJxPPl/itAZCVqOacO7bIxzOdKJk5DL7wcBcs53zZZKfmuF8akszLBmKMN0pYFK5PgvotQTmuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:16:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:16:59 +0000
Date: Fri, 10 Apr 2026 18:16:51 +0200
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
Subject: Re: [PATCH 04/10] sched_ext: Fix ops.cgroup_move() invocation
 kf_mask and rq tracking
Message-ID: <adkicxAILlBloRY2@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-5-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9e155f-0549-46ca-80e7-08de971c977e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8pi5AtJhVhFd35gP/mBID59opDp/STi2mCrCG9+ro/sxeSp90OpjwUH87W2SBgcECQHK03OuECqyZ3vTcuz+d4FLt76Q3Xwi0OFZoGtl/dCAT3M5gA4b1SkNCDD8ly9X0bVHTddHHKNFEK0B2Okg/Z1VYjZ4bt0l7z+xRONHZCTWdPPs5DcsbNPN/Wt/YqdMlebS6RQ0/dv0sW8A2poo5qPzGc+2zN0r2LfsbpJRa9VBhQXLmC7r9EVy3+YQ0opyS3ik9PKRA4eGBQqZKwyr1XkPXrqUvgH1Rv6r8WR3iAu8VKxY/TOtvTXVhTZFFcYw1g9UbkyZ4c9BB/PxWWJwRGxkfY2JBM4qEO9nkTNOwkykZhNq/ZpCc7f/ZoDrlQr3MaFj2UA9w6XBTgsI/XTuCM/1xdBNZdfbHPAKAWP24BKhqpcN4PwB9O4jWs0NJOdriJk2CeoSw3K+U53eyz5LEvVRdiJ4SE6j2ioVpteAFS0HyYhM6XCxYGLIB2VhWOKaAtDYt2soWEOPX27JPMEGEUBSkEipyypglEv0xzZb9YetHaaBC3J0OV4hyJnTkNEiCMAz/3wbnfI8Uf7EcH9DP/O6/s/eWWyt9kK+iFHWSq6SFfXtBF7PlGQJvAXcXFJwBjL5M2rNnqg3xDk3iBQa61rZ0bhK2ATIhIVATGi688rzMhN95FZD8htCo/J/BwiEDCDQXzLCl/n3hf0juz2rkAq6Ld6A7Gm+Xa+g7UordhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jd+VmTLOcBIWl/CDdRYKsWQAPZk5vx7sYGyrK7r5f8hhHurmp9Q/k7EL/B3b?=
 =?us-ascii?Q?LTYsqz0ooYexQkGkTeh/I2DWlek9VscB/PZhQ+JyuBRZ25kvFK8j8C54QN4k?=
 =?us-ascii?Q?amNjMda9J6MVxuIq5Ym/zd7XY4Eua+wZs8PDlYlC9Lw6zJ2CKqTImvDejaui?=
 =?us-ascii?Q?qpvfO2ftI5KTFhCgRDVQIJRQbmTFiJtvv3k6ncgwUyCcd1O8tzn3aiuu+xS6?=
 =?us-ascii?Q?jq04ocTsT0tb0boKyoJNoippsXNPLxCrM5i29nTVcmP7sKJHC9z0gKz4Ztpv?=
 =?us-ascii?Q?n2h+T5TvCokqJ9dA51AiXD83wGp3Nid6i+xY7XZJhR/yjjD3UVgtt+/70awb?=
 =?us-ascii?Q?u/mwe1DKoAIIAHiQZX1wrfgITA6TwmDb8ZuU6EB/1XsSgakTKiMZrkuNzxoq?=
 =?us-ascii?Q?Vjwp0Il+1mUeRwueDVnAI7BxokKeMi9b0NW8KactzP2hrcawsftGhKiW6M8f?=
 =?us-ascii?Q?XTwsuJNksIr8nAQTznWFRby533uGz0uwsZmuVi1R2e1nGbGcGKPxoWo0MC71?=
 =?us-ascii?Q?w8jCh+MnmZkNiqAGP/0cQd360oHjhHSt0/VzdIaZZxA5ZGNmL2XwULtlCH1m?=
 =?us-ascii?Q?MRk78WetZgZdzHq6hcuzOQ1dBDD4dh7cIzNiNiUnnyAUbzbxkAjttWBmFXCK?=
 =?us-ascii?Q?zegAX2mtwAf0dM/N2I5ecpXwVgntoHeC/CGEWti46Nco9DzEc4IOwRwVp85c?=
 =?us-ascii?Q?xVb665qqtXEBDqwcQ6Yf6bBORJUaIeYgBnMj5R4O9LO3RTBDgK2bAYv7uqaT?=
 =?us-ascii?Q?cVJQNn6BA5EnjKZrTGMloofybjcT1cle6JS4IKb6919KWNVRo2U3mfubKI49?=
 =?us-ascii?Q?JehGUDezhmtIurbSFftWmuH0Fm7qcDbOhRJ9WI8Qo0S61G6d2bLoYvdj8P+q?=
 =?us-ascii?Q?KZk0y7+r3k6hGjP6z6b/FGy71d2PlTjWgD+KDiSBMoi4wXq0zWS9hwDrRcxV?=
 =?us-ascii?Q?dgZe0vfDvXHMx00UEcWwwYtfbIVlmW7m+ljIjdRHOPw1OJetjPuaROMa9dsl?=
 =?us-ascii?Q?e87uV4J7M4ir1nLMqnCfeYpX7auL0KDlr2XOi4zyFyu8qSwjnvnosAZtcT8V?=
 =?us-ascii?Q?ccGRJ0Gj+7hdl7xbnTn9Y+1YyBqjGCavLRLaqGUOtPNyVaaT6keRsbUdHgC8?=
 =?us-ascii?Q?3HjOEr8KoClPiwNtGl01tuts9OuxZ/l05xPUPl/u6nc4PIREK0sxAAJ0Es31?=
 =?us-ascii?Q?ht2CM23QWN30sPSA3F42N0mDVfrGKwMdB8R3vp1ZsEbDAJ4WORsLJqhRhFBO?=
 =?us-ascii?Q?7H6t/No/yIoW3+LPZDDy96+xlYxJCUXPAdMyqVNUlVxY4NurKMB4/xtFBW7E?=
 =?us-ascii?Q?5njuriSOz9doesmMvM9CiyXv1cF6uV7FF5aoD5SpYYeYK6AFTn2P5qb4+fyz?=
 =?us-ascii?Q?ho6jTxqdbPhstRY/5SnlubHhS+j9KPMuDbMG9boN30nBv4whQK8NC7NoCvuf?=
 =?us-ascii?Q?ARTMyijLfaoVRq/BOVVgPn8dIkORQY5qlfunf7uMuXEINNs0l6tFFMjxHsKf?=
 =?us-ascii?Q?7Xo1v9wVnUligV83NB7iP+07LlB7BRI8eHOZFGrQpdm3K6KcZSusR8lq2vrD?=
 =?us-ascii?Q?O06RWJVtl1bBIx2x3Uc3xxtNQk6armuJFMIkz5cWmn5MC6Q3ra3mp3KpCdVw?=
 =?us-ascii?Q?1/Ze/TEy+jDOHb8yG3TdYL2IX7r+/vaUOB20ThOudNhYXOXieoNybhaNAtyf?=
 =?us-ascii?Q?h47SLNL6/DbvmaMAecDcBeI2IdYhE/ctDBC1axGhvIgmrM9TqJIPhz7mwt/v?=
 =?us-ascii?Q?c9jBlK6ijg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9e155f-0549-46ca-80e7-08de971c977e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:16:59.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6G+kjpca120+DdgLmFzZMXsI97SxpPzg4KAMIBjYnRME3ULQ0QLh0PXcyPWORd99yrFxIXc4DAhdl//emal1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760

On Thu, Apr 09, 2026 at 08:30:40PM -1000, Tejun Heo wrote:
> sched_move_task() invokes ops.cgroup_move() inside task_rq_lock(tsk), so
> @p's rq lock is held. The SCX_CALL_OP_TASK invocation mislabels this:
> 
>   - kf_mask = SCX_KF_UNLOCKED (== 0), claiming no lock is held.
>   - rq = NULL, so update_locked_rq() doesn't run and scx_locked_rq()
>     returns NULL.
> 
> Switch to SCX_KF_REST and pass task_rq(p), matching ops.set_cpumask()
> from set_cpus_allowed_scx().
> 
> Three effects:
> 
>   - scx_bpf_task_cgroup() becomes callable (was rejected by
>     scx_kf_allowed(__SCX_KF_RQ_LOCKED)). Safe; rq lock is held.
> 
>   - scx_bpf_dsq_move() is now rejected (was allowed via the unlocked
>     branch). Calling it while holding an unrelated task's rq lock is
>     risky; rejection is correct.
> 
>   - scx_bpf_select_cpu_*() previously took the unlocked branch in
>     select_cpu_from_kfunc() and called task_rq_lock(p, &rf), which
>     would deadlock against the already-held pi_lock. Now it takes the
>     locked-rq branch and is rejected with -EPERM via the existing
>     kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE) check. Latent
>     deadlock fix.
> 
> No in-tree scheduler is known to call any of these from ops.cgroup_move().

Similarly to the ops.set_cpumask() fix maybe add:

Fixes: 18853ba782be ("sched_ext: Track currently locked rq")

With that:
Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6ca0085903e0..f7db8822a544 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4397,7 +4397,7 @@ void scx_cgroup_move_task(struct task_struct *p)
>  	 */
>  	if (SCX_HAS_OP(sch, cgroup_move) &&
>  	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
> -		SCX_CALL_OP_TASK(sch, SCX_KF_UNLOCKED, cgroup_move, NULL,
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
>  				 p, p->scx.cgrp_moving_from,
>  				 tg_cgrp(task_group(p)));
>  	p->scx.cgrp_moving_from = NULL;
> -- 
> 2.53.0
> 
