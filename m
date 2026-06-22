Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3482737E0
	for <sched-ext@lists.linux.dev>; Mon, 22 Jun 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153954; cv=fail; b=lU8A0z9sxeKYztRIg1BvWxhnyGa6DnVf+WRsC90QNVwNwQYHAB/Er24oQR0niPKKg+npu6RI8ZHJVsVwJFx2D/tUiPfL8+76Niy3b21QovOcUGHYa5gaBVRYABHiGpjLoOjgMv4pMpK93acVPWhgFbmE/vuhbmJNxRzlTrkGLyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153954; c=relaxed/simple;
	bh=+up8ySj5b5JHKR0oNOOwQnDcLXLJzkObExgXuH18m6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tGLUw66U1gk8noCqln2JIiQo3EgGfeB2Wtmf32bzPfnNvzSAP0DOfJsp+z1FqO0FS7EIYyB6xIALe7uS1+WboLELmXXJHF8q7S41k7WdOKbVH4pq9D4K266GYCMdRCVWMdBV8U0uIlG95CaQ8Mqco0+3ZEONSagnyBfY7+DnJTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OH0vRhiK; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OH0vRhiK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ15QlfDpi5TUniOVQemu98s3bNEYB85Ako3oX6t5HmCHJpyqIv9cMg3RT3tapPi92/O+R2CDlPlWNtCweT2R2Ryk4Tcosw49wHepH/RWL1VelKgRIJL8ezyeM7ibLoByRJ/l/fKhj1pc1qt5EKxNOWPmrSETA9eWuq3gOZp+6laNpQ2PAdD5KrxmtG5mRW3MJM+pd3W/yInf910Gh2EVt5TmENevHEnABxhvIRusMZQmBmik2W6SD705/jTK/OkMDbqVMsDClleLb9Sus4G/y7zWrsm8I5YtppbOourmj7XwCnAVl7+wlJDYBOqvt69r2Q9VeXrdpWZ+GCC7eZjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0V56ONv+gmX3dbE6+1RxjQAvCKq5e4KageNzfJtrvg=;
 b=eFH5GpS0G9Zun3NI2ZmvJ3g3REf8sd7jd237+cBCbL6yj98zYhBxRURs2sbLMUXzusNgyPro2ZMu1xI84pUzVmXaeRKkDY8pe/b7XaVDGN2NrCyghJby/0VEA62tO9ARxwCaFx2/4UEEy4Zrv/0f7aILE4dNsVnc6m4CcwUnFjmWLFvkKtD2m+ykVMKUzxH+1QtGlFTrSchYCkGsO9LMB4uvT1PEF5kxr3ZpZtzzQCX48pjMnSBpNfT0LxbgN6WeH2arN1LVfU3tAy0eVlz7xh3sau8Ps/s86uqtm4rzpI9aRW+LJpt+IF6/lYkzQSONo+Vvz2xWvuzm4a9cpeRzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0V56ONv+gmX3dbE6+1RxjQAvCKq5e4KageNzfJtrvg=;
 b=OH0vRhiKnqxNzwWmvnb4WRNFJpGp4CjTw5DuDn2qXKu8XzuFCx4/8klQc9seMgPtF5WMVK5fSNs9A2wQV/h/inQcLWLi8gV4DlrWwhg6pTqNrQaqFtff935lol/OVc/mJSTcby1pJINnBVx0EtnEZv9GDpYtCXF81WWZt+/BimYNyuW4yBnKVJyg29d7+M8m6JEvW2Bb3DqibE7Xpoy/z+i6iBDRU3KNbv/9pxFRiOAR+FLLy+h6+jme3kTfkPFxSHftXb1CrgoWyY+GlyTP0j1cVIv9QfBWbnErQE4N27r6tNzGAp9542XfSPB4wvuWeMnAMBlobJ9N+xNNs9Zk7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 18:45:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 18:45:41 +0000
Date: Mon, 22 Jun 2026 20:45:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2 2/2] sched_ext: Move shared helpers
 from ext.c into internal.h and cid.h
Message-ID: <ajmCzLPU6Jo_2iB9@gpd4>
References: <20260622173904.1169407-1-tj@kernel.org>
 <20260622173904.1169407-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622173904.1169407-2-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::450) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb8a2b8-46af-4f6e-1736-08ded08e753c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	EfECR38PYBfNs3TGcI9E/rzWFdAgx2SbAdwFqreBHUyWvynYUYDk9SQ8er7gi4lKL5utzpmlJcr+SrxQD9Dll7qR7bjRd2XSqADC2oSJo2lUlaGOUjieDnDf+Oeeuu0Dwbu2QATmmRInIc+kXK17hh4/P3nmke2OqfvGWt4QR0D1jKaAEnRVQHHqNjywu2gh4+irdKPiC5rS80czPyvlM0oP8YR2t79868XSdoGRvZBl8qtAPsS/ZUAaHlLOdw/6ZsDxVBG3jKtcXuNKkQcF/YfxdfIS8aezxn6w+MFvV40Lg9VxybHjX//vNekP8vwsybXSUC7yGAJ5TxLIeb9qc8LCSkYq9eWSjY2xWiMIkdJA/RzpB3/PU3YWtJetGo9ilVC26hY9d79Qb5LyDDLIz3wdC8cpYpJYl9Zzo4s2DZXoT7EbzTBM6ReZF1AFDwtj+e+98isU8Lmv2/FjfZEOgSTgPD2b4sJL4LKeOAg06IzaK2LOP9JrjkFqO/tVT8lRnT79y0fRwF+oWQWiEwMCgWrMMvsSERPW0Jz0UBCE0h0QV318vdE5ssk+XH8DQap81pWyV6HHkJHU/ipdIfGlHQxlgEF4KMwrHdl57LRN2gFvKqWySQ66n+5jx7HjxqfJd+iDfilRwq0FISv8CDckNxTzKsf2mrnXayFQk788ALU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuMI4AqZ5xM85nWD0repLvCPIzf1oRiC+RyTjz+3A6lMB07abTmr4JrXDJ+b?=
 =?us-ascii?Q?zoEb6P6/7rqQkiAZ/lZjVWQPPaaf9lWFYL19M9yL+3wBvMWrJtEj66VDbXNs?=
 =?us-ascii?Q?FeUDVO2OZnJFdBW/RyXjJ34Lajnhh1dl9zEHkdIZpU9PgQrHw+rVuE1ATUrc?=
 =?us-ascii?Q?U7SdD/zbAgwbSE/6GkbcP3z5jaBjI8vqrVv480FzVuzhef3UmQEnCIrm1Enx?=
 =?us-ascii?Q?TC7crfWxaIrvnl6w6NNDJtdy5/wZSEWultD2LxqOKoXQdPdQrMRkdeH24q6h?=
 =?us-ascii?Q?iW22dgirBDReswyFAFwH4vGX6e3CDvHGsYSYqxK/wmUxu4RgDA+7ognMoMLH?=
 =?us-ascii?Q?xuZH5bvPmO5sGCgqpe629VfKaTROJnYDx9GTNyhWtxj/YuZ3fkrzN4lK2EST?=
 =?us-ascii?Q?ZlaKFb1LwSt6+PsmNpIb80PueMR6kHKgl99I/BdBqTdKQRraqLiQuXYgMtEf?=
 =?us-ascii?Q?u5cOU9W2dhpNf8Le+Jz2LI7vTqARsvWUAiVwnKCYycUpTdh7b1fiD4+J/FjC?=
 =?us-ascii?Q?4KmE52xXz3Td+aTvYyhmav9kiwR2Sqx5+/qrttA258qbP6vnJpfC9WkcqbL/?=
 =?us-ascii?Q?CTCPcv9Yo7nAo8fuM9ufmYqjf3OVYozD9fv4LGrbU1ULxD7V/M6SGGtL6BIV?=
 =?us-ascii?Q?Qn3mxTszP8KrGlJGAea5weL7LQT1obwFbK6AjSvkiguedSYCsA4OX7I+sQgs?=
 =?us-ascii?Q?1OwU2Eap/oKjibM8cwjidJjwk+OtedyOsH0LYSfAKyXj5yxEBPDX7YQlXble?=
 =?us-ascii?Q?UCdEcXU7eYSagSYf6N6doZLrkTfvlne8N8Lw9+Xwqam7pq6TfhLeE1JTVnZo?=
 =?us-ascii?Q?oaIqMuxmScEvGj33JkQls8o7Qvu3s2Fjha9tx34Y7iG6its8zDBJqbsW4Qdk?=
 =?us-ascii?Q?w4ydV+c+UGRu08RqdIHhkK6zjITlobEhbb35X8nDxXgYoyycH84e+bxQqaSk?=
 =?us-ascii?Q?UuzWi/7KGYnCg29/iKC7WYZJZnP4cPzTHvwZn0RO8MoRda/O5QkH5F2zFTBx?=
 =?us-ascii?Q?cK4iMVai8UKdodj2E26LvS6cLigLjruS3ab560dqCZMAk8C+V0UhQf9oULLk?=
 =?us-ascii?Q?6joZPsXKC8zVk6JMogHH870OQ6WbeT+Lg69w1s1vhMbAvKUtL0TMCGHCXsYI?=
 =?us-ascii?Q?hTxXa/W6LgGsY2yLGxED+aeS7A515F2ox3S8kkzjZXp4XnTzATz3LPyDYHbM?=
 =?us-ascii?Q?jqocoOI5k5qCkhK06lEHadmtNq5C3c6adt24eqiKJWDq2giJyzJkAh3bFSoo?=
 =?us-ascii?Q?dHBl/HodIILvBE7Iybf4iVgqqpdoikpOO6EvoV33onSu3Ai8ikgOLzTRzLGa?=
 =?us-ascii?Q?O2i25XDGvla17qr9z3r2L7b+kc/vF/xa21cR5M7a/ynvZqaTBHAnwRVDT0fQ?=
 =?us-ascii?Q?FpiKOsDStMhid09zklXIsZRja+nymU6Y/uFLcBiUoz0nN9w1fd62ZyKwVNYF?=
 =?us-ascii?Q?z0DUGC9XI3gzxcEzuAdKqsAejP9h5ro+AZq7l7OYuvk/McoJ6sXDdzMxqhB0?=
 =?us-ascii?Q?QfbvNeayE30zBCnngLA/HOjZzXFs1mzPNcxTdgTP/LHaSNnYt3rRlWsXBAkt?=
 =?us-ascii?Q?KTXCIgcJFW2zv6NHmjLk7T2/5QRcawiLAUuGUDuZw9R7TplS/DvUesN0xw1A?=
 =?us-ascii?Q?n+t4SbrsiCRM6sgBK5MQAnJQuTrtj7eVKYShXiq3Y6HnxUbz/QJ/LhheNfZI?=
 =?us-ascii?Q?GzUs9YcSPtawni6dxbpaCmSLdJs/L6ry60p4XR4R45awtp7tn9Nn9plf+phO?=
 =?us-ascii?Q?hzmNNIXmUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb8a2b8-46af-4f6e-1736-08ded08e753c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 18:45:41.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lJ5FXeuYLK6xhcQmCw7D4W5o0Uhkj5UJq59upxyPrDoL+oRchF/BU5r5g5zfJpGqL/z+RJNmvt2gUJFE4TNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

Hi Tejun,

On Mon, Jun 22, 2026 at 07:39:04AM -1000, Tejun Heo wrote:
> idle.c and cid.c are included into build_policy.c together with ext.c and
> use helpers that ext.c defines. Because the helpers live in ext.c, the two
> files can not parse as standalone units and clangd reports errors in them.
> 
> Move the helpers to the headers they belong to. The op-dispatch macros and
> helpers plus scx_parent() to internal.h, and scx_cpu_arg()/scx_cpu_ret() to
> cid.h. No functional change. idle.c and cid.c now parse clean standalone.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

>  kernel/sched/ext/cid.h      |  21 ++++++
>  kernel/sched/ext/ext.c      | 141 ------------------------------------
>  kernel/sched/ext/internal.h | 121 +++++++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+), 141 deletions(-)
> 
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index 41d0802c6af3..9c4f4b907f12 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -270,4 +270,25 @@ static inline u32 scx_cmask_nr_used_words(const struct scx_cmask *m)
>  		     __w && ((cid) = __bs + __wi * 64 + __ffs64(__w), true);	\
>  		     __w &= __w - 1)
>  
> +/*
> + * scx_cpu_arg() wraps a cpu arg being handed to an SCX op. For cid-form
> + * schedulers it resolves to the matching cid; for cpu-form it passes @cpu
> + * through. scx_cpu_ret() is the inverse for a cpu/cid returned from an op
> + * (currently only ops.select_cpu); it validates the BPF-supplied cid and
> + * triggers scx_error() on @sch if invalid.
> + */
> +static inline s32 scx_cpu_arg(s32 cpu)
> +{
> +	if (scx_is_cid_type())
> +		return __scx_cpu_to_cid(cpu);
> +	return cpu;
> +}
> +
> +static inline s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
> +{
> +	if (cpu_or_cid < 0 || !scx_is_cid_type())
> +		return cpu_or_cid;
> +	return scx_cid_to_cpu(sch, cpu_or_cid);
> +}
> +
>  #endif /* _KERNEL_SCHED_EXT_CID_H */
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ebf6dc84cb4d..dd41b84ae680 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -258,8 +258,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
>  	return ret;
>  }
>  
> -#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
> -
>  static long jiffies_delta_msecs(unsigned long at, unsigned long now)
>  {
>  	if (time_after(at, now))
> @@ -274,20 +272,6 @@ static bool u32_before(u32 a, u32 b)
>  }
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
> -/**
> - * scx_parent - Find the parent sched
> - * @sch: sched to find the parent of
> - *
> - * Returns the parent scheduler or %NULL if @sch is root.
> - */
> -static struct scx_sched *scx_parent(struct scx_sched *sch)
> -{
> -	if (sch->level)
> -		return sch->ancestors[sch->level - 1];
> -	else
> -		return NULL;
> -}
> -
>  /**
>   * scx_next_descendant_pre - find the next descendant for pre-order walk
>   * @pos: the current position (%NULL to initiate traversal)
> @@ -335,7 +319,6 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
>  	rcu_assign_pointer(p->scx.sched, sch);
>  }
>  #else	/* CONFIG_EXT_SUB_SCHED */
> -static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
>  static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
>  static inline void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> @@ -495,123 +478,12 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
>   */
>  DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
>  
> -static inline void update_locked_rq(struct rq *rq)
> -{
> -	/*
> -	 * Check whether @rq is actually locked. This can help expose bugs
> -	 * or incorrect assumptions about the context in which a kfunc or
> -	 * callback is executed.
> -	 */
> -	if (rq)
> -		lockdep_assert_rq_held(rq);
> -	__this_cpu_write(scx_locked_rq_state, rq);
> -}
> -
> -/*
> - * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
> - * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
> - */
> -#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
> -do {										\
> -	struct rq *__prev_locked_rq;						\
> -										\
> -	if (locked_rq) {							\
> -		__prev_locked_rq = scx_locked_rq();				\
> -		update_locked_rq(locked_rq);					\
> -	}									\
> -	(sch)->ops.op(args);							\
> -	if (locked_rq)								\
> -		update_locked_rq(__prev_locked_rq);				\
> -} while (0)
> -
>  /*
>   * Flipped on enable per sch->is_cid_type. Declared in internal.h so
>   * subsystem inlines can read it.
>   */
>  DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
>  
> -/*
> - * scx_cpu_arg() wraps a cpu arg being handed to an SCX op. For cid-form
> - * schedulers it resolves to the matching cid; for cpu-form it passes @cpu
> - * through. scx_cpu_ret() is the inverse for a cpu/cid returned from an op
> - * (currently only ops.select_cpu); it validates the BPF-supplied cid and
> - * triggers scx_error() on @sch if invalid.
> - */
> -static s32 scx_cpu_arg(s32 cpu)
> -{
> -	if (scx_is_cid_type())
> -		return __scx_cpu_to_cid(cpu);
> -	return cpu;
> -}
> -
> -static s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
> -{
> -	if (cpu_or_cid < 0 || !scx_is_cid_type())
> -		return cpu_or_cid;
> -	return scx_cid_to_cpu(sch, cpu_or_cid);
> -}
> -
> -#define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
> -({										\
> -	struct rq *__prev_locked_rq;						\
> -	__typeof__((sch)->ops.op(args)) __ret;					\
> -										\
> -	if (locked_rq) {							\
> -		__prev_locked_rq = scx_locked_rq();				\
> -		update_locked_rq(locked_rq);					\
> -	}									\
> -	__ret = (sch)->ops.op(args);						\
> -	if (locked_rq)								\
> -		update_locked_rq(__prev_locked_rq);				\
> -	__ret;									\
> -})
> -
> -/*
> - * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
> - * and records them in current->scx.kf_tasks[] for the duration of the call. A
> - * kfunc invoked from inside such an op can then use
> - * scx_kf_arg_task_ok() to verify that its task argument is one of
> - * those subject tasks.
> - *
> - * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
> - * either via the @locked_rq argument here, or (for ops.select_cpu()) via @p's
> - * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
> - * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
> - *
> - * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
> - * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
> - * while a previous one is still in progress.
> - */
> -#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
> -do {										\
> -	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> -	current->scx.kf_tasks[0] = task;					\
> -	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
> -	current->scx.kf_tasks[0] = NULL;					\
> -} while (0)
> -
> -#define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
> -({										\
> -	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
> -	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> -	current->scx.kf_tasks[0] = task;					\
> -	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
> -	current->scx.kf_tasks[0] = NULL;					\
> -	__ret;									\
> -})
> -
> -#define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
> -({										\
> -	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
> -	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> -	current->scx.kf_tasks[0] = task0;					\
> -	current->scx.kf_tasks[1] = task1;					\
> -	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
> -	current->scx.kf_tasks[0] = NULL;					\
> -	current->scx.kf_tasks[1] = NULL;					\
> -	__ret;									\
> -})
> -
>  /**
>   * scx_call_op_set_cpumask - invoke ops.set_cpumask / ops_cid.set_cmask for @task
>   * @sch: scx_sched being invoked
> @@ -650,19 +522,6 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
>  	current->scx.kf_tasks[0] = NULL;
>  }
>  
> -/* see SCX_CALL_OP_TASK() */
> -static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
> -							struct task_struct *p)
> -{
> -	if (unlikely((p != current->scx.kf_tasks[0] &&
> -		      p != current->scx.kf_tasks[1]))) {
> -		scx_error(sch, "called on a task not being operated on");
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  enum scx_dsq_iter_flags {
>  	/* iterate in the reverse dispatch order */
>  	SCX_DSQ_ITER_REV		= 1U << 16,
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 1f5312b3b387..145272cb4d8a 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1553,6 +1553,111 @@ static inline struct rq *scx_locked_rq(void)
>  	return __this_cpu_read(scx_locked_rq_state);
>  }
>  
> +static inline void update_locked_rq(struct rq *rq)
> +{
> +	/*
> +	 * Check whether @rq is actually locked. This can help expose bugs
> +	 * or incorrect assumptions about the context in which a kfunc or
> +	 * callback is executed.
> +	 */
> +	if (rq)
> +		lockdep_assert_rq_held(rq);
> +	__this_cpu_write(scx_locked_rq_state, rq);
> +}
> +
> +#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
> +
> +/*
> + * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
> + * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
> + */
> +#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
> +do {										\
> +	struct rq *__prev_locked_rq;						\
> +										\
> +	if (locked_rq) {							\
> +		__prev_locked_rq = scx_locked_rq();				\
> +		update_locked_rq(locked_rq);					\
> +	}									\
> +	(sch)->ops.op(args);							\
> +	if (locked_rq)								\
> +		update_locked_rq(__prev_locked_rq);				\
> +} while (0)
> +
> +#define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
> +({										\
> +	struct rq *__prev_locked_rq;						\
> +	__typeof__((sch)->ops.op(args)) __ret;					\
> +										\
> +	if (locked_rq) {							\
> +		__prev_locked_rq = scx_locked_rq();				\
> +		update_locked_rq(locked_rq);					\
> +	}									\
> +	__ret = (sch)->ops.op(args);						\
> +	if (locked_rq)								\
> +		update_locked_rq(__prev_locked_rq);				\
> +	__ret;									\
> +})
> +
> +/*
> + * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
> + * and records them in current->scx.kf_tasks[] for the duration of the call. A
> + * kfunc invoked from inside such an op can then use
> + * scx_kf_arg_task_ok() to verify that its task argument is one of
> + * those subject tasks.
> + *
> + * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
> + * either via the @locked_rq argument here, or (for ops.select_cpu()) via @p's
> + * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
> + * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
> + *
> + * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
> + * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
> + * while a previous one is still in progress.
> + */
> +#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
> +do {										\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> +	current->scx.kf_tasks[0] = task;					\
> +	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
> +	current->scx.kf_tasks[0] = NULL;					\
> +} while (0)
> +
> +#define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
> +({										\
> +	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> +	current->scx.kf_tasks[0] = task;					\
> +	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
> +	current->scx.kf_tasks[0] = NULL;					\
> +	__ret;									\
> +})
> +
> +#define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
> +({										\
> +	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
> +	current->scx.kf_tasks[0] = task0;					\
> +	current->scx.kf_tasks[1] = task1;					\
> +	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
> +	current->scx.kf_tasks[0] = NULL;					\
> +	current->scx.kf_tasks[1] = NULL;					\
> +	__ret;									\
> +})
> +
> +/* see SCX_CALL_OP_TASK() */
> +static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
> +					       struct task_struct *p)
> +{
> +	if (unlikely((p != current->scx.kf_tasks[0] &&
> +		      p != current->scx.kf_tasks[1]))) {
> +		scx_error(sch, "called on a task not being operated on");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
>  {
>  	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
> @@ -1633,6 +1738,20 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
>  
>  	return NULL;
>  }
> +
> +/**
> + * scx_parent - Find the parent sched
> + * @sch: sched to find the parent of
> + *
> + * Returns the parent scheduler or %NULL if @sch is root.
> + */
> +static inline struct scx_sched *scx_parent(struct scx_sched *sch)
> +{
> +	if (sch->level)
> +		return sch->ancestors[sch->level - 1];
> +	else
> +		return NULL;
> +}
>  #else	/* CONFIG_EXT_SUB_SCHED */
>  static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
>  {
> @@ -1656,6 +1775,8 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
>  {
>  	return rcu_dereference_all(scx_root);
>  }
> +
> +static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  
>  #endif /* _KERNEL_SCHED_EXT_INTERNAL_H */
> -- 
> 2.54.0
> 
