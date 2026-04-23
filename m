Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE51349B1F
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936080; cv=none; b=ekY8ynk1KaqfFyBxTgPEmTac/E+hJW406lrSOAEyG3Ei8jt6bOZ/L2R1C9FxoskguPwW6RWE7USTw7MnmvmhiXIaF3x6COdyYAZbe5UqjAknYq61twegGsvdUREC7ZwZZat7EeE872kUniMgEnVXxY1etN73NZgt4ZHURHkHVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936080; c=relaxed/simple;
	bh=V4Mt7UTBRqduL+DbL4vVk9UpgpA9rLMOPyNCswxxBYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww+WyR0DYRDwLDzpKTdlXYJLGFQp089uuQ0OrpT3pX87vcR7GBV93h9v9odLYMcCATvylIaptSGp0iVurw65EcGLo2/A6FwWvJ6oW91AQpKL3PRZ8kd3n0FXrIM+c5wTVe5bhASJAyFxjVICjNndL1bFJ6PjKW/i2800Yhm7viU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+zXS/WO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+zXS/WO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4469139a91.1
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776936079; x=1777540879; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSYCYEdIs9iCX9srVmQAVlFmMGtaVdekW9Bp/Pgyh+U=;
        b=I+zXS/WO7v/2g4VWuA6SgOZjFeNzAddXOSxfdB/jOFbOHm5OXMuJV8d3rkIwlrvTxP
         JwCiojY0MTUYoqEHlh+2WTpOS3jZOC75iLi8uWFXQx+zJNVr0aDDo7d1MGoAacKDfyao
         QIC0N9KuNv5GnGI9t/rgVWlweHGjp7bK6IOjjQt/xXZ3pxP84sMZnov19YzL8lQGFwWv
         KKTCCLKILKfFKXVU+JcPXiwMe06K0flZFQ4bxNsCvbjFDKqAPONri3tsvhVUSKluftrb
         DRieFM0nFJJCCdsHMglrcocfpxG/Ct0gAHcMKAm6LdKWd+JD+Rmi6pOOOAxJvdDHsYi4
         +BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776936079; x=1777540879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSYCYEdIs9iCX9srVmQAVlFmMGtaVdekW9Bp/Pgyh+U=;
        b=HtcMXa5/sTrjyc/tMfCg87+Xyhh5M4uIg1rEBbEnNOxDPl0UrciaxyjhBGsxTCcQyi
         tk8J2+GocLattfI6Wn/RD+rq6V4VEQljgKvMUjASmW0D/s3g+15mze1M5t100TItfcah
         4yZIzSpSLuhWyn+MlFWNVB3D4ZhTgIwggfKAqesPSpf1yf+uxVbHqb4+rCVsZWJE7rtw
         1OOgzesiwy0v1NSrgrajLVwTUcEP/Qcl3BdThU0zNVkuiTiijxLu/ulw/KJejxc35Zg2
         J4e5ZGqXLiteW4dN8xKYloWmoeW1GP0pHfg3Qf7iWfo2RAUfei11m6ukKqdXShqi0c+X
         oPnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QBL3sAshCQihU+IWHT1kKwGINwSDMcvGwo4rjd0jTQOlIY6GrxhffYyPC5g0UkHNPZ01L7/ucDfA=@lists.linux.dev
X-Gm-Message-State: AOJu0YysRoNpGQpUSmjNhVBejIG9OtPzXcWSg/rNAo1g9z8IgtXbxdNs
	eH/mmKc2iPulzbojvfx1qGnxE8UhoodV0Im1Zi36bI5gCeneQn2d0ZJb
X-Gm-Gg: AeBDieu5Sh7gwxyP+cD+8idC5CNCR/h5CDoUfHaJmy6NBq7ZIoDMgJ1Y/H59jY9uHdA
	sGH1Si97WiDyi4I4l6MrUhacsIrUWm8AdW77iC7VWH1Kqpyh/DKLb6R5HDN4ZhwJF3ZQAsasvxr
	6oEyWZ8u31maNJZmpegEYFtyzHsGmY1ujzvj0nt1/AVtQ5dQW0TthCzU/AOXf41mOd9uX0Zuf+L
	IXgAVDVmuTcByUxtevJGXvGvktL3tRIWHLi8+AE5qRxXRif9MVCxLzRFaG/yuRFBwWS8iC0m6mJ
	YwaGYUXCTxgcPst82fqDR7UEpyj4+uvcnLswscgHfu/yhxwIVNBrMWgEeiK2gPi1EqbSLSPfg8g
	NfI0Bphy0py6JhoJE/jYPrxtDQx/+QbTUIhv9ya6clH/NmSZGJTSohoPZdVwr+plrM6xKRQNoPD
	lWHeafsctahGheuL/xFtbf3nAIfoZkrNgDU07PJXP5TF8H2bNX2vEsxqvSGBCqxuM2N2qBQUk+Q
	shaacOivxCzV+/hsgYP4Hbgcoo=
X-Received: by 2002:a17:90b:3c8d:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-361403bd142mr27188937a91.3.1776936078450;
        Thu, 23 Apr 2026 02:21:18 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7cb5sm19663803a91.9.2026.04.23.02.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:21:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:21:14 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, emil@etsalapatis.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
Message-ID: <20260423171156.G698a@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-13-tj@kernel.org>
 <177693500312.275653.17323765149266875001.b4-reply@b4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177693500312.275653.17323765149266875001.b4-reply@b4>

Hi Zhao,

On Thu, Apr 23, 2026 at 05:03:23PM +0800, Zhao Mengmeng wrote:
> non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> |      ^
> /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> |             ^
> non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> 26 |         scx_bpf_kick_cpu(0, 0);
> |         ~~~~~~~~~~~~~~~~     ^
> /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> 
> On the one hand, non_scx_kfunc_deny.bpf.c has it own problem, it should
> not declare scx_bpf_kick_cpu(), on the other hand, the root cause is after

If your point is that a TCP program shouldn't declare scx_bpf_kick_cpu(),
you are correct. The main goal of non_scx_kfunc_deny is to ensure that,
witch commit 2d2b026c3ea7, no non-SCX programs can use SCX func.

> this commit, the signature of scx_bpf_kick_cpu() changes from
> 
> `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __weak __ksym;` to
> `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym` 

Regarding the non_scx_kfunc_deny.bpf.c build failure, I'll fix it. If
needed, we can test with another SCX function that doesn't require the
*aux parameter.

Thanks.

> 
> After code analysis and test, I believe scx_bpf_kick_cpu miss the 
> KF_IMPILCIT_ARGS, just like the defination in scx_kfunc_ids_any.
> 
> So here misses  KF_IMPLICIT_ARGS 
> > +BTF_ID_FLAGS(func, scx_bpf_task_cpu)
> Missing KF_RCU.
> > +BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> Missing KF_IMPLICIT_ARGS
> > +BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
> Missing KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED
> > +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
> Missing KF_IMPLICIT_ARGS
> > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> Missing KF_IMPLICIT_ARGS
> > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> Missing KF_IMPLICIT_ARGS
> > +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
> Missing KF_ACQUIRE
> > +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
> Missing KF_ACQUIRE
> > +BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
> Missing KF_RELEASE
> > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
> Missing KF_IMPLICIT_ARGS | KF_RCU
> > +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
> Missing KF_IMPLICIT_ARGS | KF_RCU
> > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
> Missing KF_RCU
> 
> Please correct me if I miss something.
> > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
> > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
> > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
> > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
> > +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
> > +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
> > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
> > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
> > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
> > +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> > +
> >  /*
> >   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
> >   * group; an op may permit zero or more groups, with the union expressed in
> > @@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> >  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
> >  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> > +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
> >  	u32 moff, flags;
> >  
> >  	/* Not an SCX kfunc - allow. */
> > @@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >  	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
> >  		return -EACCES;
> >  
> > +	/*
> > +	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
> > +	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
> > +	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
> > +	 * intentionally permissive to ease gradual cpumask -> cid migration.
> > +	 */
> > +	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
> > +		return -EACCES;
> > +
> >  	/* SCX struct_ops: check the per-op allow list. */
> >  	if (in_any || in_idle)
> >  		return 0;
> > -- 
> > 2.53.0
> > 
> > 
> 
> 
> 

-- 
Cheers,
Cheng-Yang
