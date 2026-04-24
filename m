Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7051A6812
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995128; cv=none; b=toGSUgovxaXVo6WT4Msv2QJZbqNxrzK3Svqb4g0KhSEOmoiIdJWippwfRwPoFjaG8Oda+JUTBG2kxT7ObJ2ODLE13ivFAUxgpeLQlcZrhrZYL74hiTb3FhGRHSZjlbx/1Vf9j8UuPs0nCvGnVYKNKuAkYQ/99sxKasfP+d7K2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995128; c=relaxed/simple;
	bh=hfgslwX9LLRaFCjNsyjLsf10qkCXHgosE2XLKPgOURA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjJj7Wwng9qEkzFa/T7aMhyQJzlcRBNvTM8rj0II85j/h6y7oYWKoeKYu2oHFuMd5M26nUi+PijxNDFTkyU9fpBtznrVL013EWFml99qvrOhYKY5UYN4/BZm5JLOdNg/gtA77HT/0Q+TvjkPKR/IoHjIqfJC0Re626EFglLaP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UEY32+pf; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UEY32+pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=NlxfMqJofm07iylPADZhEb2EO4Dgn96db1mTA0Wxaow=;
	b=UEY32+pfGVOX2S46bC8Dr1EDg3MnwWx/zViFifHL4gkp4KWNdnF+HKFrHqSiS3
	SpNdaMeHkXhVvcMA2cvr+/tKPOavSeWT9wFGvFB+dTfEfYQduBYI1kcEHeohminO
	fbzRxEUU6SZ7hh50sZ1WcKlt0dhEhPQki6JCr+WhOFI9U=
Received: from [198.18.0.1] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD37+cWy+ppTKDXAA--.60881S2;
	Fri, 24 Apr 2026 09:44:55 +0800 (CST)
Message-ID: <8632d618-4abe-4c88-b7a9-75ce9b1afe28@126.com>
Date: Fri, 24 Apr 2026 09:44:54 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: Forbid cpu-form kfuncs
 from cid-form schedulers
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, Cheng-Yang Chou <yphbchou0911@gmail.com>
References: <20260421071945.3110084-13-tj@kernel.org>
 <38133c3fa792e3a5d5b425729f59b9ee@kernel.org>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <38133c3fa792e3a5d5b425729f59b9ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD37+cWy+ppTKDXAA--.60881S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWxKFWUArWUur1kAr18Zrb_yoW7WF1kpF
	WFgrs0kr1kJas7uan7tan5CrW5Cw1kJa1xuw1DCFySkwsrtFWrJ34Svr1jq3s8Wrn5G3yD
	XF10vFW7Wr1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1VbkUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqhcNhGnqyxcl6wAA3l

On 4/24/26 07:04, Tejun Heo wrote:
> cid and cpu are both small s32s, trivially confused when a cid-form
> scheduler calls a cpu-keyed kfunc. Reject cid-form programs that
> reference any kfunc in the new scx_kfunc_ids_cpu_only at verifier load
> time.
> 
> The reverse direction is intentionally permissive: cpu-form schedulers
> can freely call cid-form kfuncs to ease a gradual cpumask -> cid
> migration.
> 
> The check sits in scx_kfunc_context_filter() right after the SCX
> struct_ops gate and before the any/idle allow and per-op allow-list
> checks, so it catches cpu-only kfuncs regardless of which set they
> belong to (any, idle, or select_cpu).
> 
> v2: Sync per-entry kfunc flags with their primary declarations (Zhao).
>     pahole intersects flags across BTF_ID_FLAGS() occurrences, so
>     omitting them drops the flags globally.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Cc: Zhao Mengmeng <zhaomzhao@126.com>
> ---
>  kernel/sched/ext.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9969,6 +9969,47 @@ static const struct btf_kfunc_id_set scx
>  };
> 
>  /*
> + * cpu-form kfuncs that are forbidden from cid-form schedulers
> + * (bpf_sched_ext_ops_cid). Programs targeting the cid struct_ops type must
> + * use the cid-form alternative (cid/cmask kfuncs).
> + *
> + * Membership overlaps with scx_kfunc_ids_{any,idle,select_cpu}; the filter
> + * tests this set independently and rejects matches before the per-op
> + * allow-list check runs.
> + *
> + * pahole/resolve_btfids scans every BTF_ID_FLAGS() at build time and
> + * intersects flags across duplicate entries, so each entry must carry the
> + * same flags as the kfunc's primary declaration; otherwise the flags get
> + * dropped globally.
> + */
> +BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
> +BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_IMPLICIT_ARGS | KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_IMPLICIT_ARGS | KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_IMPLICIT_ARGS | KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_IMPLICIT_ARGS | KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
> +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> +

Hi Tejun,

Looks good to me.

Reviewed-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

> +/*
>   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
>   * group; an op may permit zero or more groups, with the union expressed in
>   * scx_kf_allow_flags[]. The verifier-time filter (scx_kfunc_context_filter())
> @@ -10031,6 +10072,7 @@ int scx_kfunc_context_filter(const struc
>  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
>  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
>  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
>  	u32 moff, flags;
> 
>  	/* Not an SCX kfunc - allow. */
> @@ -10068,6 +10110,15 @@ int scx_kfunc_context_filter(const struc
>  	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
>  		return -EACCES;
> 
> +	/*
> +	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
> +	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
> +	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
> +	 * intentionally permissive to ease gradual cpumask -> cid migration.
> +	 */
> +	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
> +		return -EACCES;
> +
>  	/* SCX struct_ops: check the per-op allow list. */
>  	if (in_any || in_idle)
>  		return 0;

