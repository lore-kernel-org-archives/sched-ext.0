Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8B3BB101
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627766; cv=fail; b=apvZx+kHwVQpcadPZlqNLGDB0d7kmxlKnnFfzqSfH6UiFrFo+AcCFrzTggTEghcpLAo+kdPSReuxQYooG9RJzJM3zoSJciuT2Hexf4xp6r5L5BAkqosxeeDIRTS3tNQfwQtdxZABYP1amyP2nzxF7R52QRmbEdlU+FqMJOme4Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627766; c=relaxed/simple;
	bh=+m2dq9N7U6YXozTP+ZmdXVgaROudf7qhcvw6HLDUJQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSS+By4Ttcn9w+p47+46dxhEzHwMY119naYafYcdW/0uanA0vZPu1xQHUpWaCY0c7kub+hM53JehufL0SdvR0HUbm2F7jxfHTuqUbdBOHLUlU7yEXf9zSQXjVyvSK7hjog7N7bgp9SfwK/qj0h+M5PrjX3GsU+Y91dQ3Z0Z36D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiL1LYfn; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiL1LYfn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZCHpUci0B0Q7rMcTpQbWtuY4hN8bu0H6TFLS10vW8VCXv2eOq3dZDZMtTxvPnh/NQJ3anod7x/YEnNup5QcEfrcvQ+UUh10mSjwfyzN9QamBcEwlqys2FTFveUuQPBe1JwuKbaeVUG7WVWfZf0Xc0VaOlHh5tIN34xAIZxZk2PhvKVSbh8x6bYS7zkKW0aVsqvsIaL8uaDqjzKBTW8H6GEY9f/sA8tOgwoWjUduAYHvtsy9cEt0Plu3EXVNENuYLYhkfsGsDdEwqwBeuzF/SxWz/hBRAKsJpS6eNdWOjS5NNUWZQEYqmakL9yvtQJohLyN4aNKLsgSZpH1zMckZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AySDgSm1q7PORs9dM7L/lFVIt1szX/uMqy5IGDzm98U=;
 b=YvDr1+A79lPCd+214MRBh5J3AcOUDcv9xP6vKm8FTKH9eFmlA5K6uXRhWwUk4f9tTQ7yFQ/7J6OpPtYxfXmnXe8oI6h7uyLQWPdmZvd6zEdIL54BSqQCPH24FQO3p9vnv5x6RhIgQ/9Xtk1JBx6q9C4Bc0D6rBKUasqnMKr01hDSyNDfwiLLw9Gi/e+RNw3yObwdiTMLHc2LTS6Yog3fg7b7REHoBMIoTpr3uY/IPi5BWi+sb7hn26o2pNIkOOAs9G85h4V0bkXKuMzKSEw21EaQsk5NHjp9FSmS4gcz8FmC4mxU+Xn22qUxcAcpfuwEbdtsx0JTIkWOqCGFwXT5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AySDgSm1q7PORs9dM7L/lFVIt1szX/uMqy5IGDzm98U=;
 b=QiL1LYfnQdpwpQl0gfiiidjUNR8abiwSe1tOP5cCF+b6PxNnEhgYri9upHh5rqHtiUL8sSgk5GurucCV5noaOSvBr9lshwruU8n/GGkRU68nUJ0SZxoyffNjc2kVKarm0PFiPooBnUi5h27RAFy+SQqOoF8J2nXJ1waqIYB7JSbdBzbkNQGAdYfEC6rXV2GocSs/5DvrdONQeEH0GSXh6vD6uJsP+y+PKN2lgPMLBILfjEbL9tWhCQTw6SPEqGomVnsnCrAQxzZ7Vj9ByfZhwLD3NWsOcYUVbueZhRFArzLaZYpgKYK6N6m+icnlnsvJ8gms9VLipL3fJPC+2PmPhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:09:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:09:20 +0000
Date: Thu, 9 Jul 2026 22:09:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 34/40] sched_ext: Authorize
 remote-move inserts against the placing scheduler
Message-ID: <ak__5beR_STJ5OsU@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-35-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-35-tj@kernel.org>
X-ClientProxiedBy: MI1PEPF000008C2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dde1510-e54f-404e-9fbe-08deddf5f63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7J8twduYkmcK238yB1AhUUDsYtrL7gB7RkAW4OLMRstlM7EQ4MJdWpVOPR1h4FOhh+PDaCj4Dok6a3t1QX/UBcbKQ8dT7lCWZCU4dHRxOsX8xqFEicwNO2AFJX1AmZ1+ycYFJ8nuq9P6KIH8GuJtKcf6xqtj+rvn4PUU09SLYK8jHhhEqR86Zm0lOmE5zEdaJ7zRJV8y7sX1ADeUdik7+wGkESMh6RZ4DoxItUxz7SeuosAQuigVilONCpox3SN46gDzw/m6MHSJtl5G30TSg9QhmGWGZZH3D1naK5adxiRbO+Mkh6V2MJdjEz12kdDEQR8dT8xWXw0Y/httlWuUYRg71y3QpDYB3wGK35z79XwqDxKZ6LXy6lPO/gnqQj7mzDwcv/MZpQPhggoSaSKVsinKty0bojXO4ab0q/Q5bHX7zhWDpaP6p77UBwKNk6XOtX69zRQ/1eOcc+v3hh4QSQQU8wY3RwNM9GPoUGc7LNnp8bwd0c1wqkxfDS1WZOxn60Oo06P8kRttmqyYa935PS6GaYtw8A3hPd/WcjmOE23gulGm2VcyNVryerHpRKsOKwEmlpnXSiRKo9nAzzyl5UX47boPnt42t+nVIsAUxFCXwcawCHLegVZ2q1DhUc2aH0wzaejwRrGJkzvHv5hy7t1s5o81nFHS1JKMGZ36LR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+AzcrteJR7a0G55kGg+u5+3J3W71wowr+USP2GKUnGFtxmAzpH1zFif+I/f?=
 =?us-ascii?Q?M9o8A3CMN5ubyeMUAzrj2yLuOW2ozGx1IwTYGkMLtY71oFuLLDqMJ9wtQJbC?=
 =?us-ascii?Q?Q6Y+lSPBjCfmc3Gu6qn+yjibQLmUiffNz4Ba6sB8ZzaWKic7LMpnraez3Jzl?=
 =?us-ascii?Q?uhX6zjgW5qJpgMYjCkWzlMKaR67u5LZW6GwQGuL7Ecmejw1JQMUqTHgjHzWu?=
 =?us-ascii?Q?kI4q1wBIgt8XkHp1hNoiotLPbjoQr1Op9AlFuKeZpBy7VbXYyfEuPzyRbNo5?=
 =?us-ascii?Q?dOjqXHPS0ykSQzB8xWkIsxextNDXU0GgVZ52LSjsl69G/isBqRvWnqJtxrmP?=
 =?us-ascii?Q?PxUUcFWifUk+9W4VDp57uKfe5ro8A1ci7hT+hi5jTHAyrI7/GH6+PyoT5n/G?=
 =?us-ascii?Q?h3Q54VMNPdX8dO/vkIqz3J1QODECSkc6Rc7r+5n9snqRU1bmFK7bf1fD79XN?=
 =?us-ascii?Q?MCh+YIpXitW02wClbWwU2sYRm7UGzt9zmgUFmjr0/I9ZUZAPYizQ8j7GaL5G?=
 =?us-ascii?Q?t8lBAFkyUH//fiv3JXUFU5RXw2OIlSPyMFfJIPrfguQcJL9Cat73ZCDrsO6Z?=
 =?us-ascii?Q?2SeZqITtrX3vnWL4SzKGzPsnpvJhs6flXtIJ+suukQgvCfy+a0pnboLCHKv+?=
 =?us-ascii?Q?vWLn0BLAHKchcGd7BKM9UAB7bFj5JHNiBI0JZrqD9bjlk5QmXH5lkKqQZrXC?=
 =?us-ascii?Q?sGz0RZirX77HfI3pG9ASkbQhlEbLufJF8K9NIclm3QAuOguOh8kedyC990sJ?=
 =?us-ascii?Q?31Z4IKNPAw5fHelgh8K5KcsdqVy9iVVTbz+mCXh4H4BicxVRYwK1Xenxhxcj?=
 =?us-ascii?Q?R7A2oV6VBIa9Tv7wb5TGcSKg34OCO9PI+uosStSdh8s9ppCyKwJn/yyyEFXG?=
 =?us-ascii?Q?7zRs8N3r2QeF4MzVaZGHHcXN5zO1Y+LtC/oxDTa8yDsL71kSjg+z/DgVOIb2?=
 =?us-ascii?Q?jHuy1pHpvz/bMqN3aN72oR1CzAtRrHqVyolSkxkT46/P3lk9KR7iIX+fNnws?=
 =?us-ascii?Q?DuaWeHOTvpu2m//U9taVnGCtZW9pF6V5lCgLdZt/a0Sqnu007uFiRnb9Hu66?=
 =?us-ascii?Q?b5+OhpkjkMk70FNzj2XnFBJeenLqtTa+FDY2PayUKaFkLDxnDErZb7skUNkN?=
 =?us-ascii?Q?YwbADYy+GwftkUNyVoYcKLKPSlJoq0apa2ro8IqJUPuSI+b0FE62ZI2UgH9c?=
 =?us-ascii?Q?sqLx/zGPQiKJjDwCqyrJEVK4ZkVJZANdKlXBOYScz9oSd0QvU6Avw1hhj1lh?=
 =?us-ascii?Q?fXZT5lhKtS/4WhjHYkhK8l7HhDLywpGcDKtuDYC/AC7lBU6kkM4aF5hLBwuA?=
 =?us-ascii?Q?A8HXwM/+UZIeEcDwh1gqQgSbBQ5jANMbcl1TUTuJxQhdXOAmgkRmak5ysFme?=
 =?us-ascii?Q?m40zhaPqWq1hgBpbyUNKHD1n9eZGs7eM4I6C7Bb9Fxyl4XSMERb6g8KyDTi8?=
 =?us-ascii?Q?SEVPMTnew2SZ0CtL++xki8Xufk/DyU+W0WtAk0tBBeSw2DJDbrFhBQfYx83u?=
 =?us-ascii?Q?5fJEy5EEIPPwUaQwC1OH2EMH9z4Y16XVXsyQD3C3A4FwlFUV0jzoOXwZD7Zo?=
 =?us-ascii?Q?xtYNgeIKUPwQ/GdLV43IrxSEbcanl8dOkUESKtY7CVtKm3A8FYZtPnMIwAdZ?=
 =?us-ascii?Q?V0Ke/NsG9ysSl6VZMDvzs1MzeeVdd7R5sSssWBIGhbuFQrob1dPByvBUU+/o?=
 =?us-ascii?Q?F/aZkzGB4Lmn2E5HJoU5NhND4m9bDlvBSPD5UulFhQtMRpRNRLtcToe82N4U?=
 =?us-ascii?Q?mnjX4Y9sIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dde1510-e54f-404e-9fbe-08deddf5f63a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:09:20.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAGaik4Nyn3t6dExDU+32zkN8wxLe90IdEgRF+w2eErhH56V8ISY/TvOHt+zXgRAb8RbzR+5xEG9YVd7O3BEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

Hi Tejun,

On Wed, Jul 08, 2026 at 11:24:23AM -1000, Tejun Heo wrote:
> scx_local_or_reject_dsq() authorizes a local-DSQ insert against the caps
> of the scheduler doing the insert. On the consume/dispatch paths that is
> the scheduler running balance_one(), passed down through
> scx_consume_dispatch_q() and move_local_task_to_local_dsq(), so the check
> is correct.
> 
> The remote-move path loses it. move_remote_task_to_local_dsq()
> re-activates @p on the destination rq through enqueue_task_scx(), which
> reconstructs the scheduler from the task, i.e. @p's owner. When an
> ancestor places a descendant's task - e.g. draining a bypassed
> sub-scheduler - the owner is a sub-scheduler of the placer, so
> authorizing against the owner checks a narrower cap set and can
> spuriously reject a task the placer is entitled to run.
> 
> Carry the placing scheduler across the activate_task() boundary the same
> way enq_flags already are, via a per-rq field set only for the duration
> of the re-activation, and have scx_local_or_reject_dsq() authorize
> against it. The placer's caps are a superset of the owner's, so this
> admits what the placer may run and keeps rejecting what it may not.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 27 +++++++++++++++------------
>  kernel/sched/ext/sub.c |  9 +++++++--
>  kernel/sched/sched.h   |  3 ++-
>  3 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e15297c29617..896f8f9eea6f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2256,7 +2256,8 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
>   *
>   * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
>   */
> -static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> +static void move_remote_task_to_local_dsq(struct scx_sched *sch,
> +					  struct task_struct *p, u64 enq_flags,
>  					  struct rq *src_rq, struct rq *dst_rq)

nit: since the function gained the new @sch parameter, maybe add
"@sch: scx_sched being operated on" to the kernel-doc block.

Thanks,
-Andrea

>  {
>  	lockdep_assert_rq_held(src_rq);
> @@ -2273,15 +2274,19 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  	raw_spin_rq_lock(dst_rq);
>  
>  	/*
> -	 * We want to pass scx-specific enq_flags but activate_task() will
> -	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> -	 * @rq->scx.remote_activate_enq_flags instead.
> +	 * activate_task() below truncates enq_flags to 32 bits and re-derives
> +	 * @p's owner, dropping our scx flags and the placing @sch. We own @rq,
> +	 * so stash both across the call. The enqueue reads them back, keeping
> +	 * the scx flags and checking caps against the placer, not the owner.
>  	 */
>  	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
> -	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags);
> +	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags ||
> +		     dst_rq->scx.remote_activate_sch);
>  	dst_rq->scx.remote_activate_enq_flags = enq_flags;
> +	dst_rq->scx.remote_activate_sch = sch;
>  	activate_task(dst_rq, p, 0);
>  	dst_rq->scx.remote_activate_enq_flags = 0;
> +	dst_rq->scx.remote_activate_sch = NULL;
>  }
>  
>  /*
> @@ -2410,14 +2415,14 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
>  		!WARN_ON_ONCE(src_rq != task_rq(p));
>  }
>  
> -static bool consume_remote_task(struct rq *this_rq,
> +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
>  				struct task_struct *p, u64 enq_flags,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
>  	raw_spin_rq_unlock(this_rq);
>  
>  	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> -		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
> +		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
>  		return true;
>  	} else {
>  		raw_spin_rq_unlock(src_rq);
> @@ -2479,8 +2484,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  			raw_spin_unlock(&src_dsq->lock);
>  		} else {
>  			raw_spin_unlock(&src_dsq->lock);
> -			move_remote_task_to_local_dsq(p, enq_flags,
> -						      src_rq, dst_rq);
> +			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
>  		}
>  	} else {
>  		/*
> @@ -2533,7 +2537,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  		}
>  
>  		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
> -			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
> +			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
>  				return true;
>  			goto retry;
>  		}
> @@ -2627,8 +2631,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
>  					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
>  		} else {
> -			move_remote_task_to_local_dsq(p, enq_flags,
> -						      src_rq, dst_rq);
> +			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
>  			/* task has been moved to dst_rq, which is now locked */
>  			locked_rq = dst_rq;
>  		}
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 9a1eac886928..f66e97f08ce6 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -237,12 +237,17 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
>  					       struct task_struct *p, u64 *enq_flags)
>  {
>  	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
> +	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
>  	u64 needed = scx_caps_for_enq(*enq_flags);
>  	u64 missing;
>  
> +	/*
> +	 * On a remote activation the scheduling sched (@asch) differs from
> +	 * @p's owner (@sch). Check caps against the scheduling sched.
> +	 */
>  	if (*enq_flags & SCX_ENQ_PREEMPT)
> -		needed |= scx_caps_for_preempt(sch, rq);
> -	missing = scx_missing_caps(sch, cpu_of(rq), needed);
> +		needed |= scx_caps_for_preempt(asch, rq);
> +	missing = scx_missing_caps(asch, cpu_of(rq), needed);
>  
>  	/* requirements met */
>  	if (likely(!missing))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c0a4699a6c0a..cdd21c814008 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -800,8 +800,9 @@ struct scx_rq {
>  	struct list_head	runnable_list;		/* runnable tasks on this rq */
>  	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
>  	unsigned long		ops_qseq;
> -	/* see move_remote_task_to_local_dsq() */
> +	/* both stashed across the activate_task() in move_remote_task_to_local_dsq() */
>  	u64			remote_activate_enq_flags;
> +	struct scx_sched	*remote_activate_sch;
>  	u32			nr_running;
>  	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
>  	bool			in_select_cpu;
> -- 
> 2.54.0
> 
