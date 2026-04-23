Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FE3C13F1
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935048; cv=none; b=qYhD/ZlLk4DypRgc1DkuyWEq1gDhPA8JZ8FWBwbb1GQWx/flRNRUH0xOuGgZnTFKZl/nbWCZSXLstJhFtQ208J/PFbW1wZcza0wsrxN04/XADLjNq0Kdk/IfFbCTA1vFOJtgScwZrfSBTJsqG8PYIpO9BdhejjPLlCrL7id4Avw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935048; c=relaxed/simple;
	bh=Zaz60fF/kKnLGmp+S3l5tFUH4qXRsuBSPNCrlGFSkVo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MfDL+YDcxQ/w87jiEpTcivfv5MuXm54tHdgTA0BzmFpylYqAVUD7xF3DI+H/e4rTAoIYPdtgZx23Ql68XIe25qGIWZ0YEcASk/lxRas4Zp/XquunEtj0rTXLoDN1J5LacEs73nEtEYkx+jx1MaNTH6eBGb5NF5ROWrSe6cRwHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BAua4687; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BAua4687"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=MIME-Version:Content-Type:Subject:From:To:Date:
	Message-Id; bh=JYNqizZRZ1tUhKPs+d+ikguRoPrKQ9mw7PP16CidapE=; b=B
	Aua4687M3NuQzExlxaV/TBs8jkSg4ZA+15hTf+mzGWiEVWwvItIbNqGDq+4igwKx
	UJUghJ4V7yvfthBtSRjhF8AC+mgAdxC8EL1uGNYIMQ2OQ0eHxTPj6Svt+7z0z3tt
	CVlytOqYGix2s4B5ttSXSmVUcnxQr4GUsqozXYOmgM=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3z7pb4OlplEibAA--.16094S2;
	Thu, 23 Apr 2026 17:03:23 +0800 (CST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
From: Zhao Mengmeng <zhaomzhao@126.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
 sched-ext@lists.linux.dev, emil@etsalapatis.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260421071945.3110084-13-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-13-tj@kernel.org>
Date: Thu, 23 Apr 2026 17:03:23 +0800
Message-Id: <177693500312.275653.17323765149266875001.b4-reply@b4>
X-Mailer: b4 0.15.2
X-CM-TRANSID:_____wD3z7pb4OlplEibAA--.16094S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrWxJw1UCF13tr4DKr4Uurg_yoWxJF1fpF
	Wvqr98Cw1DJa4xZ3Z7tFsYqryrCw1kJa1xuw4UGFySkwsFqay8Jw1avr4UX3s3ur1vkw1D
	XF10qFW7Gr10k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1rWwUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlxwkm2np4FwFiwAA3G

On 2026-04-20 21:19 -1000, Tejun Heo wrote:
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
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fcb5f98d670d..02bdd393bbe4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9968,6 +9968,42 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
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
> + */
> +BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
> +BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
Hi Tejun, I'm testing this series, and found sched_ext selftest failed to 
build with following error:

non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
|      ^
/root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
|             ^
non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
26 |         scx_bpf_kick_cpu(0, 0);
|         ~~~~~~~~~~~~~~~~     ^
/root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;

On the one hand, non_scx_kfunc_deny.bpf.c has it own problem, it should
not declare scx_bpf_kick_cpu(), on the other hand, the root cause is after
this commit, the signature of scx_bpf_kick_cpu() changes from

`extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __weak __ksym;` to
`extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym` 

After code analysis and test, I believe scx_bpf_kick_cpu miss the 
KF_IMPILCIT_ARGS, just like the defination in scx_kfunc_ids_any.

So here misses  KF_IMPLICIT_ARGS 
> +BTF_ID_FLAGS(func, scx_bpf_task_cpu)
Missing KF_RCU.
> +BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
Missing KF_IMPLICIT_ARGS
> +BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
Missing KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED
> +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
Missing KF_IMPLICIT_ARGS
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
Missing KF_IMPLICIT_ARGS
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
Missing KF_IMPLICIT_ARGS
> +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
Missing KF_ACQUIRE
> +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
Missing KF_ACQUIRE
> +BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
Missing KF_RELEASE
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
Missing KF_IMPLICIT_ARGS | KF_RCU
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
Missing KF_IMPLICIT_ARGS | KF_RCU
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
Missing KF_RCU

Please correct me if I miss something.
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
> +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
> +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
> +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> +
>  /*
>   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
>   * group; an op may permit zero or more groups, with the union expressed in
> @@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
>  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
>  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
>  	u32 moff, flags;
>  
>  	/* Not an SCX kfunc - allow. */
> @@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
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
> -- 
> 2.53.0
> 
> 


