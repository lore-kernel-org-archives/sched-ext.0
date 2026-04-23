Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4303E6DC8
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937724; cv=none; b=YiKxGJIb6hZ4hUoEPcuORSxS0Gr29RrdU1HQjqmTSVHDgiGXQUZkWgbf/EmtPUpCjXWqdEvtNv0LM5ln+b1sECBz65WmQE4XiYO6BpnHTEZkidrw7JsrVTtqCXk+4pg2O5cQKYvp4ITI0lvGBuBhljSHZTe9fZIEaCHR+5qcTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937724; c=relaxed/simple;
	bh=NKsqtJTPZyuB6xMamNcwvPploJSAGf5j7STbZRll2GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGi6MmI8jAUJRCsdsXyS+biP0ln9zgtZWZoiGj7c47Wdhc6XPGaDhDBTbdJ3exKByGA7vUAx2c0UYEPb2XCbtVq6mVoM4NQ5H1qf/8Na4GREVtaVfhZjZGHXhIvmCBL1iQAUvXXjxNqaxdHxQCzn6oxgQB8hHB+Rl58RTZVYepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puAjoIff; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puAjoIff"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-356337f058aso4148276a91.2
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776937722; x=1777542522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmqjA3vEKjIsbVDwMsu9CfTunPb163g7TCnyX7uTBUo=;
        b=puAjoIffhwWfDL6NHiKnSwvppRBN3JqCD0hb5SPOhz2clyGrxTGSTyOuv9uZM+AT/J
         FcX9TQs7wADJvXaBnp12br9nezs9aKhmnlVWm0cgK3JkV6UUf73MNLyIg6uv0UuoQTmt
         1IfWjLXudOw/YBnR3IZKbdBxfRCVLnpUxQn4K+csVETsO8k7qNSSxATyABZ+F66AOIik
         86MQEhkWKCknChbNdPFzN4IUIAIVKI7YseqXdQYAttkOtL6VzGU6NhTgoqBvAqxW5O/n
         gvWqChrlsjQmn65etd3GUfUeiMAwXOUAGGsIFPe6O1DzxH/d+oCWQ7QnLMqy6kc418DR
         TWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937722; x=1777542522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmqjA3vEKjIsbVDwMsu9CfTunPb163g7TCnyX7uTBUo=;
        b=SLgCN97ZQlFp6qKVnber21NSIW6VDQyL8xp/mqn6MUTZH8ru8x92q0gp/vGBbEoozP
         OzeMqaxWHMa1cMXVYXsHX7A8q8HA2149kNjHULVcv6+fRzpihD6zi+FJfuxmjvfPx+FZ
         RXvvUNBZuyO8MSKAebM0rgkkp+plohgWWoFcCU64RSPdtBAOKMh+h54o6NhD/j/9CHZ2
         Jh3y+VwsLiqHM44Od+ijN2Cd1VFscd1z5Wa4bEfj2b0MXCJrb6mbAXFpVlRNys9IYMoV
         GsQ/RsZW5ozMJPv5r4u5cAWGJkdmeoyAt6z8caz9K1JUuBVviTBQk3nWPJV6eA3oJFJn
         w+zA==
X-Forwarded-Encrypted: i=1; AFNElJ+ozo0lmOoej5mowRYV9IAmxcN780DBp2g4OS3sVpIVl0XYXCZPc3FesgTxVC11ZWESUfOpoQp/92Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd7SRzK9E30d42wsdXtuFmXAQXek4kzrHr/T6S8aw/ISplN0i0
	n5iVhFnRYkSXTW/ff3UKiXWBhV/bIT9mH0KReMrEl0EOZtNfSKX0FKmc+qiN+soa
X-Gm-Gg: AeBDiettp9OAYlDxTG/cF6UA7oTMXLBR09+zrz/GJHSqaJ1l0pevUYOWl4S/Qf+kA6U
	8ReXPFf/yAJ9RZkvZHB4Z1aoSSdUh/XfKZHbbAKLSLY7S8ruatYwdyPTlzR+bUVbUyst9RmFtqt
	Yyex9Pj1qkGF22oRunINbiUmgKlQUo5f8ZjWaVdFJWab0x1rOZBePZy8gSgctnGGoQFbZzWRgih
	8ZKYKSzTuHiuTtaDX0OzD4AMMUDpB/RJBcEL98Lv4Q95ibP8nQ+nwOgHcYBso/q2ZaH98sPBg8A
	g44ZfgZJtwJuka9qYCKBnTAIyMgpuBzHqxPc39VcioGQCwSjfiJKzBcOYky9MAQdNj77cRy27RE
	nJaQZH+ca06lvcnbpmeaoXg1tbU4sdxlCzMAKZiHwzMd8Kqez9lHmYh3GeZ9x6qxOUMkDkDqZvW
	YnIM5F2A26Dj8vg3VbNLTbciNMQYVvMV97aEfaHao=
X-Received: by 2002:a17:90b:2604:b0:35d:a6eb:197f with SMTP id 98e67ed59e1d1-36140226cfamr27176637a91.0.1776937722046;
        Thu, 23 Apr 2026 02:48:42 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:8fe7:77cf:52a3:6990])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7ab7sm25107557a91.10.2026.04.23.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:48:41 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:48:34 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, emil@etsalapatis.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
Message-ID: <fyeso4logqty357oe3vmbxy4nylb2c63ef3yp45zlrx5wl227t@mddzgld7y6nh>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-13-tj@kernel.org>
 <177693500312.275653.17323765149266875001.b4-reply@b4>
 <20260423171156.G698a@cchengyang.duckdns.org>
 <177693691666.302051.8681445792423127931.b4-reply@b4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177693691666.302051.8681445792423127931.b4-reply@b4>

Hi Zhao,

On Thu, Apr 23, 2026 at 05:35:16PM +0800, Zhao Mengmeng wrote:
> On 2026-04-23 17:21 +0800, Cheng-Yang Chou wrote:
> > Hi Zhao,
> > 
> > On Thu, Apr 23, 2026 at 05:03:23PM +0800, Zhao Mengmeng wrote:
> > > non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> > > 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> > > |      ^
> > > /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> > > 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> > > |             ^
> > > non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> > > 26 |         scx_bpf_kick_cpu(0, 0);
> > > |         ~~~~~~~~~~~~~~~~     ^
> > > /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> > > 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> > > 
> > > On the one hand, non_scx_kfunc_deny.bpf.c has it own problem, it should
> > > not declare scx_bpf_kick_cpu(), on the other hand, the root cause is after
> > 
> > If your point is that a TCP program shouldn't declare scx_bpf_kick_cpu(),
> > you are correct. The main goal of non_scx_kfunc_deny is to ensure that,
> > witch commit 2d2b026c3ea7, no non-SCX programs can use SCX func.
> 
> No, I mean this bpf program can just `#include <scx/common.bpf.h>` at the
> start of the file, remove the scx_bpf_kick_cpu() declaration.
> 
> diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> index 9f16d39255e7..0d6fcc8e5eb6 100644
> --- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> +++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> @@ -9,12 +9,7 @@
> * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
> */
> 
> -#include <vmlinux.h>
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
> -
> -/* SCX kfunc from scx_kfunc_ids_any set */
> -void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> +#include <scx/common.bpf.h>
> 
> SEC("struct_ops/ssthresh")
> __u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)
> 
> But before this commit, your code builds well, after this commit, it
> failed. That's why I suggest Tejun to add the missing KF_IMPLICIT_ARGS, it
> changed the signature in generated vmlinux.h, which I think we don't need
> expose aux argument to bpf program.

Ahh, thanks for the explanation, now I get it. 
Are you planning to send a patch to fix this, or would you like me to
spin one?

I tested the fix above, and everything works fine.

> > 
> > > this commit, the signature of scx_bpf_kick_cpu() changes from
> > > 
> > > `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __weak __ksym;` to
> > > `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym` 
> > 
> > Regarding the non_scx_kfunc_deny.bpf.c build failure, I'll fix it. If
> > needed, we can test with another SCX function that doesn't require the
> > *aux parameter.
> > 
> > Thanks.
> 
> Like I said above, it builds well on for-next branch, just this commit
> trigger the failure. I believe your test case is very reasonable.
> 
> Best regards,
> --  
> Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> > > 
> > > After code analysis and test, I believe scx_bpf_kick_cpu miss the 
> > > KF_IMPILCIT_ARGS, just like the defination in scx_kfunc_ids_any.
> > > 
> > > So here misses  KF_IMPLICIT_ARGS 
> > > > +BTF_ID_FLAGS(func, scx_bpf_task_cpu)
> > > Missing KF_RCU.
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> > > Missing KF_IMPLICIT_ARGS
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
> > > Missing KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
> > > Missing KF_IMPLICIT_ARGS
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> > > Missing KF_IMPLICIT_ARGS
> > > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> > > Missing KF_IMPLICIT_ARGS
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
> > > Missing KF_ACQUIRE
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
> > > Missing KF_ACQUIRE
> > > > +BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
> > > Missing KF_RELEASE
> > > > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
> > > Missing KF_IMPLICIT_ARGS | KF_RCU
> > > > +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
> > > Missing KF_IMPLICIT_ARGS | KF_RCU
> > > > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
> > > Missing KF_RCU
> > > 
> > > Please correct me if I miss something.
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
> > > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
> > > > +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
> > > > +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> > > > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
> > > > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
> > > > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
> > > > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
> > > > +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> > > > +
> > > >  /*
> > > >   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
> > > >   * group; an op may permit zero or more groups, with the union expressed in
> > > > @@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > > >  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> > > >  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
> > > >  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> > > > +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
> > > >  	u32 moff, flags;
> > > >  
> > > >  	/* Not an SCX kfunc - allow. */
> > > > @@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > > >  	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
> > > >  		return -EACCES;
> > > >  
> > > > +	/*
> > > > +	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
> > > > +	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
> > > > +	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
> > > > +	 * intentionally permissive to ease gradual cpumask -> cid migration.
> > > > +	 */
> > > > +	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
> > > > +		return -EACCES;
> > > > +
> > > >  	/* SCX struct_ops: check the per-op allow list. */
> > > >  	if (in_any || in_idle)
> > > >  		return 0;
> > > > -- 
> > > > 2.53.0
> > > > 
> > > > 
> > > 
> > > 
> > > 
> > 
> > -- 
> > Cheers,
> > Cheng-Yang
> > 
> 
> 

-- 
Cheers,
Cheng-Yang
