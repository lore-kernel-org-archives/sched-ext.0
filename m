Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335775C613
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776996953; cv=none; b=oILe4rAn0YNCPFfynWJvFlY80HxPaHYC2hxqRPs1Fs4NupWkIcUbhhudLpGogcFHJHI9Sda27DwkUiXGMdQF0eKW+q4EqJCohDVUSXv7J4xEMV0LWQEnPdsFNXeI0CfQHDgadDOw1dn2hXsvelKw8FyS1VnuYfq9o/WLMEtTrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776996953; c=relaxed/simple;
	bh=EWEga4Hx/REbXRDAw5nXTvkDCVY9XcGJN3SBRJ0qYx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsBbyCLlCyCp5oyWHDpLB59vmmJnVf+gYVy6JFXETpYWhzTCyEfkPJuD1cgARAOseO4ytkA3gFpATTi2r5ceDMPs2Q/Zm2CuvnTTk6lRHK80ImqM8rl/odgeTA+b5kQuEGQlcQOR/OQZbnHxvpKHbMpTAlEObgqZF05V/fZv5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YUKxd1pU; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YUKxd1pU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=7FPZhbLqYU5Iw+enx1mmaE0zlrEFpEgYksqzk7Gr7Ok=;
	b=YUKxd1pUbm4w06e9huJc7+mwmvfzF3ASMNEHEcVxjYL1xeyhddWhJ5Xdx79R24
	sIVMNc4JhiMWowB7L+TPM235KebzXgPncpS6RfCLCohOCtV1hk5bmfPhgLYgzp9Q
	NQiVtL39OjS4cKaykRVsQd6leadU70561WFKs81B1XQY0=
Received: from [198.18.0.1] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3h2400upp9tkVAQ--.48720S2;
	Fri, 24 Apr 2026 10:15:16 +0800 (CST)
Message-ID: <90bb684e-e8da-46e3-b7af-acc74a70fb81@126.com>
Date: Fri, 24 Apr 2026 10:15:16 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, Cheng-Yang Chou <yphbchou0911@gmail.com>
References: <20260424013220.2923402-14-tj@kernel.org>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <20260424013220.2923402-14-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3h2400upp9tkVAQ--.48720S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWxKFWUArWUur1kAr18Zrb_yoW7CrW8pF
	WFgrZ0kr1kJa97u3Z7tan5CrW5Cw1kJa1xuw1DCFySkw4qqFWrJ34Svr1jq3s8Wrn5G3yD
	XF10vFW7Wr1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1xRDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlxTWTmnq0jSa8wAA3X

On 4/24/26 09:32, Tejun Heo wrote:
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
>  kernel/sched/ext.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index abc0c798150d..37f37f31b025 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9979,6 +9979,47 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
>  	.filter			= scx_kfunc_context_filter,
>  };
>  
> +/*
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

Build it and check the vmlinux.h, no signature changes, selftests build well. So looks good to me.
 
Reviewed-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>  /*
>   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
>   * group; an op may permit zero or more groups, with the union expressed in
> @@ -10042,6 +10083,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
>  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
>  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
>  	u32 moff, flags;
>  
>  	/* Not an SCX kfunc - allow. */
> @@ -10079,6 +10121,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
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

