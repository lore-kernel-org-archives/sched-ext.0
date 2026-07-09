Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E4266576
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629693; cv=fail; b=LpYqzO+1UmIpfQ1TK/JEdQCH5HFQ7YbVvYjT5XkSW19tfo2nVujZmsA0qyr7era1OdgJi/lNXrvySVAZDrbWc4/gv9HLr8bAYliI3MGatxzf0WAr8akljoaIrIB0kYDEREOCnjVAeZ5AcieG/yIhr5YQxkK8+nTiBOVAwNzfWLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629693; c=relaxed/simple;
	bh=eXA7f5XPbc/uk0R+osr/PxTptTNCmneQB5tTWEbOhp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmW5GvX3q1l3s+8DXFQhnjpPXyfJtRzOecwsMjIJdSSBk0Ecs2DqpNl4LDkhUho98ptA2qfXD55jkBAQ/5dAH3P1T7XBO6wth6Xyr1b/58m5ncb2Gil1ui0GilNt+hmu0X337C1q+iknhWawwey0c6J9E1PsR57ztFW9oPNyFhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZZukDEf; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZZukDEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8JVX4eMutfTlwkp+xuIZtzQSNc7KCV0otHRONgKKxCoz0hHn913Zg2oXmIuL8Z30KjmZkY26JwPDF0qF3QaMd/SjgFuVpDW0XdXMRt3WYXCRc2MAPck9yUrCc/aEWVi1CXUZgixe0ltZjO6Da2YLICa5eoYJeQR+jmuAjvjp2U6SmFc1nfWLLXPT67/2NYS5kqtKq3GgW3qXdI88KMz0wXZp/gWV3SkTuU6ESPS8K8g3Fv1o1bsS/aAXVWB1apIa1ECEFXqs+bO61GpBQq46DLsIzc9NVgDyBW4pXR3V3nEMAAVyS5IziWY+PpVcUZOhmf23I1IQAXZ8KJB8lWZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oExazeskezcjumy25mt4/GIz3SY4leM8SjTob9lrJTw=;
 b=xMMy73JFd6mKp3adeJIS6JwIUaOn/FyBDAuIgy6FBgu91z6aWYCGlsiqmWUxBnEgLpCppr0FI4Yu8mGCxou7CG5TYXLmaAuIHsfkXfqh9/sSZ61Yw8ttiy+uvVMWI5nP6+Uob05bm65I2uGb2YxZagg+VUu4tluzoHq/pWTYs6vgEcKEEFxcABGbE5DqmaOpnWH4meSMBZHnY/JhmxVifEuFyXRjJf7LIYn91NGKxb1euMJRSA1OQriku5tExDX6H5tb1rZsW29MNVOqNIn5ltIHnWTMyCv0D1r58bup41dj44pwrysLKsrFTEWkj6Ueh4SEfwqjWDj9zWH3VbUP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oExazeskezcjumy25mt4/GIz3SY4leM8SjTob9lrJTw=;
 b=OZZukDEfH0h1e9TocWjBBp5ookHX7cgQAzNds48fMkW4PDCHi4oNjfYRfXSoeUHz13gUc7oVEyba36xPhf5LcEk89b1SIgPlLADiie0HqWwyVe8qhNsH62HpRcWFHsn2ElKhlig6OvKK76+mQnhvlqToh7Xs60kX0EsmgNlL1vwusaeOWGy7+cm/2PvPi8AH03ewdEIFbeFvaM6snwF0DmpKSNe0KxhMCeCppDquOCqxwymz92MJgyT+oAClMo/vv1gXRrpEuG7nAeTnKs4WOkgW93aEsrSy8xX+YwDtAK8K5v8YYOKWVg0eZAUP/cXkdS+Ww9xrt7RAME6e/qKZBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:41:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:41:27 +0000
Date: Thu, 9 Jul 2026 22:41:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 05/40] sched_ext: Add
 SCX_CALL_CID_OP_TASK() for cid-form op dispatch
Message-ID: <alAHbgsxUZgAtMMW@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-6-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00007538.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4ca) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bb1260-cd80-473a-c323-08deddfa72c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|5023799004|4143699003|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	UpwytnY3hg8lZaJKdBUSANVrp4neO/S5HIrBemwKdR2fB89VSCouQWgGVdOvnVegu6ijLpt3WSYGuAZPh1fhxZtusF9yZaNGvCsK3m217x7mDR8fa9eE8V+amjODy0BVJqpbKfi6FpdvIXJlxlVoPteE46PUEs6JrxcT8L3nsawzPj5jYTElXyECF6J0HZdYaXH0/7haBP6eihmvNscNo/NjtWNPJmlFonRJwJOF28UO1PyadvQmDfo5THk6r41dMsw8ZDGCwkxLAdihUXrAQJhQypW/MY4iKD3Axc80tNN/nRMqvNx8qtA9gf1V/ZKLAU60dRjzQw2FDB8o+dTe5fToMWOyV/7hBxaQT/UCXQLaCuRLiD0w961aCuus68MnDnpU022xeqUKZZu0vehMTVyeUkQ5jhr4+07Chaa95uywX4Bhw7MN5ZhuLOOKEMIhy/OWax0kIka1e3X6NTAiu5Axxp+rD7nu1QCj4T5klApgCB0cBQe6R9ewmtQ3YWx6j7Db6tFkJHbxN4ulhlYlYSwclm4GN8B1LAhFfJ4h0SyEKXyMSvSoq244i37HfmsjFkup+LorBjYXKfeBbjteSUNB+ecgSA9mC0pwqXuAD/OuB+L7vBON210H2v6PDRr7jZ2FObZvQVY14ewIXYaxapH0E0GTKMOnR8sF+xEXhcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(5023799004)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zvCwG8l1+eOSZOdZUzqRhuRYpeDC9izo+FO4mhaM/vdMNLPmyVSBhGZrDkc?=
 =?us-ascii?Q?6SZM/rgN3munC6NPK7iE8tRpivCsbrHKCDRiNqYc1Q57l/vVK6NIm5C/T2aq?=
 =?us-ascii?Q?JWczz3gjJW+Ma8eoydcNTwL8rEV00w2sA8MputD/ORN/8xxzYhvlbjQTOg4W?=
 =?us-ascii?Q?wZSr+ZVsxAurMJR8jzQ3+hbp0RE5gRpGNcCSMYn/qai38C7ZcuPYeudd0HT9?=
 =?us-ascii?Q?4s0iRpMGehvZkwxZphy3Qnt2evzv6vnir2zNTEXSsJCb/sPfXjUdBm3GFGDx?=
 =?us-ascii?Q?H3+/AM/CCs6S6aZCN9ZwcDNxaHqa0YLkxsEd6L1Ab/IJxuXlKC7nqQrYnpaO?=
 =?us-ascii?Q?s8S0KUg8dGzi4YOjmI7Al8Ug0c1AwbCUeYSMDi2Crgyx5whZuhxZo7IqM7Xy?=
 =?us-ascii?Q?cUluSxWES4LFqwcybJmEVJto/xDZig7hErRcJOtkSkPfvZpLEMpVnGgggzqg?=
 =?us-ascii?Q?a8nPMBXoSJUEta70bVRnt8Bp2+gt7Mn8h4U5JZexa9FnI6Ugr52yUXLDIhIP?=
 =?us-ascii?Q?6H+xkWp3nwoCONmN8UCP0H8Hrwt7URP35B2kqGg2K7LCwQXZ7IEjN8OVEjCG?=
 =?us-ascii?Q?lzONzpax68tsop4hNTzWorptGlppvuYkoQTTJtEAQG/Fdq1Lo9rDWhJxz5pC?=
 =?us-ascii?Q?PMvskyqAWyZyeJb063aNeNfptE3tuzgLxhjidmrXmeu9MtKJM6nAQY+KEHFN?=
 =?us-ascii?Q?bTWRNSe4aATehAf20pURRSIZyoejgVlZxNhs4lteH64FEH6VDqoi5IjXY5dz?=
 =?us-ascii?Q?oW+VnZqwsZtTpX/5s1SOZ7Q20hmg31kcrMI8RzM4xezBa6T+oCpTc3oSg3TU?=
 =?us-ascii?Q?wGc1U6Mrk0gQwNYniffSXf09h3CUtuznUa+ChKOZq8zoxLdA15IDPiEC1+z4?=
 =?us-ascii?Q?ArRsDiYU/RtDaEGJ6og4er//9HxyX8janQrgssXs9Lrxv2MMMre1tPOV86nb?=
 =?us-ascii?Q?WQSmeVmbjKmDJVeAtgBWBOXAl2nUf2AX9MhGV71c7Uh5LU6BF1AJC+Q3Icqt?=
 =?us-ascii?Q?lFvzwfbSLgxvxEl2uuLgysbuRRRuaLRDVwfeH0zTC5LMuEvHWUZ4VCDNUwxK?=
 =?us-ascii?Q?umgBamKCQk8I3Rv0sZ13BEdy/YZX+apBdgfsiYrbShTOsfUakgQhVGGy+cSE?=
 =?us-ascii?Q?p0MiuzTsi3mTjbNRqYyhzwYxbkm/a1Xm6eKfAYYl6Y9VGgEC8lQhpxk92KqZ?=
 =?us-ascii?Q?t2K9YBflkKhoyPy3waTkni2kJHl90TbjNQHrAbQe8pnDwPymIebgInH7CJHf?=
 =?us-ascii?Q?DX/6V0IN+aJDpN/ZOydAvTP3hj6VcFUJxsqBQ1sGaZv+HY7wT9aVK1K9hVTc?=
 =?us-ascii?Q?+aryWXIKDMcTsLsmI8/zIB0CSFZbXtiEdIkR03tAXGNmyrzr6/kn08Xm8yam?=
 =?us-ascii?Q?uzxq4rko0PkYpKfaPeJ6iLxxNu1i6iFZqZX3/RV0yI4ABuvXoJTRrTHRXwTB?=
 =?us-ascii?Q?1bWX+oL9isnh93NftFndN7tRdUBrYweaba0ZzoTVhcBYGlTqo27iEqywxPov?=
 =?us-ascii?Q?Pb9drS2TJ/oWUkmA5hD2V9FHBhOJbPSVNyHy4VHKgAQtRp/Fjkd/v08LdxSv?=
 =?us-ascii?Q?ZEkKgIviRk4vmlU3JJEJq2hCIQsW543MiWKeBMoChad7EaqFQ49DVJVu7Kj0?=
 =?us-ascii?Q?Q5Wso18AUQe2loqL6nca8jbGAWe7J4+vzTIkAjhLCU6EjkCazeIFlUCoMIVO?=
 =?us-ascii?Q?7SY43yEd2g3+RXl8VHifDjf4Dr7KVDN6ElOEB+Gs9u3pAsXj12+H/hKuDlQt?=
 =?us-ascii?Q?SYEgPuimiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bb1260-cd80-473a-c323-08deddfa72c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:41:27.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQXd31Nr2T1eg2r/NfJYNCD+lJ7WTLoWQDgDA2s5swhhHyj5i/PBxfAPx+D7IEZKJEF+oxmQ/KmY6X4JLGlwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Wed, Jul 08, 2026 at 11:23:54AM -1000, Tejun Heo wrote:
> The cid-form ops overlay their cpu-form siblings at the same struct slot.
> Ops whose signature matches the sibling are invoked through the cpu-form
> call sites unchanged, but set_cmask() takes an arena cmask address rather
> than a cpumask, so scx_call_op_set_cpumask() calls ops_cid.set_cmask()
> directly and hand-rolled the kf_tasks[] and locked_rq bracket that
> SCX_CALL_OP_TASK() provides. The hand-rolled bracket reset locked_rq to
> NULL on exit instead of restoring the saved value, so a nested call would
> clobber the outer op's locked-rq tracking.
> 
> Parameterize the dispatch macros by the ops-table member and add
> SCX_CALL_CID_OP_TASK(), which routes through sch->ops_cid. Convert
> scx_call_op_set_cpumask() to it and drop the hand-rolled bracket. The only
> behavioral change is that locked_rq is now saved and restored like every
> other op call site.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c      | 14 +++-----------
>  kernel/sched/ext/internal.h | 23 ++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f4725698f5ef..c050a68189d4 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -410,11 +410,6 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
>  					   struct task_struct *task,
>  					   const struct cpumask *cpumask)
>  {
> -	WARN_ON_ONCE(current->scx.kf_tasks[0]);
> -	current->scx.kf_tasks[0] = task;
> -	if (rq)
> -		update_locked_rq(rq);
> -
>  	if (scx_is_cid_type()) {
>  		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
>  		/*
> @@ -423,14 +418,11 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
>  		 * the sole user of the scratch area.
>  		 */
>  		scx_cpumask_to_cmask(cpumask, kern_va);
> -		sch->ops_cid.set_cmask(task, scx_kaddr_to_arena(sch, kern_va));
> +		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
> +				     scx_kaddr_to_arena(sch, kern_va));
>  	} else {
> -		sch->ops.set_cpumask(task, cpumask);
> +		SCX_CALL_OP_TASK(sch, set_cpumask, rq, task, cpumask);
>  	}
> -
> -	if (rq)
> -		update_locked_rq(NULL);
> -	current->scx.kf_tasks[0] = NULL;
>  }
>  
>  enum scx_dsq_iter_flags {
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index f9fe7c6ebc4b..5ca44ad88786 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1751,8 +1751,11 @@ static inline void update_locked_rq(struct rq *rq)
>  /*
>   * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
>   * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
> + *
> + * @ops is the ops table to dispatch through: ops for the cpu form, ops_cid
> + * for the cid form.
>   */
> -#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
> +#define __SCX_CALL_OP(sch, ops, op, locked_rq, args...)				\
>  do {										\
>  	struct rq *__prev_locked_rq;						\
>  										\
> @@ -1765,6 +1768,9 @@ do {										\
>  		update_locked_rq(__prev_locked_rq);				\
>  } while (0)
>  
> +#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
> +	__SCX_CALL_OP(sch, ops, op, locked_rq, ##args)
> +
>  #define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
>  ({										\
>  	struct rq *__prev_locked_rq;						\
> @@ -1796,14 +1802,25 @@ do {										\
>   * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
>   * while a previous one is still in progress.
>   */
> -#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
> +#define __SCX_CALL_OP_TASK(sch, ops, op, locked_rq, task, args...)		\
>  do {										\
>  	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
>  	current->scx.kf_tasks[0] = task;					\
> -	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
> +	__SCX_CALL_OP((sch), ops, op, locked_rq, task, ##args);			\
>  	current->scx.kf_tasks[0] = NULL;					\
>  } while (0)
>  
> +#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
> +	__SCX_CALL_OP_TASK(sch, ops, op, locked_rq, task, ##args)
> +
> +/*
> + * Dispatch a task op through the cid-form ops_cid table. Only set_cmask() needs
> + * this: it takes an arena cmask address instead of a cpumask, so it cannot be
> + * invoked via its cpu-form set_cpumask() slot.
> + */
> +#define SCX_CALL_CID_OP_TASK(sch, op, locked_rq, task, args...)			\
> +	__SCX_CALL_OP_TASK(sch, ops_cid, op, locked_rq, task, ##args)
> +
>  #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
>  ({										\
>  	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
> -- 
> 2.54.0
> 
