Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7F3E3C7F
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938285; cv=none; b=KJS5F1FeRLTP80c14B9wJTL6xA5mQhnJ/EMX+lIKnca324k6FI4KO3mvNMuDfOJFlpvhd/0Gk1HtWCrb1Yq0Nt3dMuD0Rr4jhKmitrwsi27kVTuqTlXw+vJ3WqF2pEjCesA2XN8FWgytyxJKmIjYbb72sdB1ZhVVaclk7xYGwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938285; c=relaxed/simple;
	bh=T9xOPEIRVuEMXwzsoJF3rIE4dGPO2GTOdHElauuWTg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4W2XhKacu6+hVed9ysgH1D3OlW/63bFbnTD6QvyRSfrgGtEGg1ePOQHvQlEESWBFzEnR2wtEItBKV5si8xoF7M4D3JCp3NASu3PkrGHrWt2u8/XGmykEzEol7FlSL4p2JmyG9GrlmeW+lUZWifK8RpdWFLHxk3TwPtkz1Dqe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InMgqNnu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InMgqNnu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c796163fac5so3880360a12.1
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938283; x=1777543083; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOBvdGdTDz7yqfdSpLpE+U5JGv9TC/gKhZxbG4r91Hs=;
        b=InMgqNnul7E0j8lugvGHcCdcL8MgsqqVfZmDk3oFwmhfsndMdgkkEH79AagxISSO7s
         dxeOvWah9IFjUxdYGanmYO9HgtFIudVCrvchKwiduwFXNAt7QXFHYRw/GgaMm9wLM9Y5
         4jZ1ylP2Ewa5NtzLFD7vqZrkSRuEy7mWxiVM3pY26/cqKERk07fTDZSEqwRV1qfpdu6M
         YX4Ss9VrJqJw2QrVFunGKi9SwVYSAvM0XwSUoR3Yd9X/EzJ/JGhvAbcPovYj55MnZSlc
         aD21FRkgfnx9NRmb0vDZbbOOQ9kegpv071zKKZonLql5CUqHgeuXTSGfBAW6h2Zch6pZ
         ISHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938283; x=1777543083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOBvdGdTDz7yqfdSpLpE+U5JGv9TC/gKhZxbG4r91Hs=;
        b=R807/W7f4q0Il4fILRzWW5FRft9wBw4YiuPgp+3Z+nRuBwosO7e3/vqe9cPL3PGUoe
         Xu6PNrGd8DcMR/oSmBGDWYG2S52dZZVP4wn/XdpeOqc40GHMxQ70LbOnZhQXrHKAqjpz
         V0QpCB5oKfuoBUxQgHgtHA8uh1n37MG7Pa6HIFojt349ee0pNfuz0KKQ6+RmsALC2JbR
         fTJQ1eJlmfaZrj7oSTfqs1kC7oFxJ4rH3Y1hWOKKaXhhEK4Cv2uHA1PeqCiic0DNtKQU
         5M7IlKHxCLBe9v4dxRi79k+vOPXRM8aezCFL9Wt1pXy9C7NM1jXnPDdk6eASS/JAqKt2
         cKbw==
X-Forwarded-Encrypted: i=1; AFNElJ/7r6FvDjllyiGbpnBZf9S0BuFtVZnZas9bFZOY0MUZKaaOfI3eXqo07JFpoGi8azeFjru81+jza2k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8hJVyh3A/R5LCxdhkjwRKbW1z6Y/FE12KG00tOGFy+7WK2XJZ
	v21qNuO3FQovoz27hc6JMs6nPY8h7DWsCZ19dcH45d/LmOdWLnvWckUt
X-Gm-Gg: AeBDiet1TKVi+3nJDLgNsBQQkZoMTBm0e4JToXINidHT6xUmasa9ZdyDRF4Q9Zr0OKf
	0PL41uvedvj9LWVD1vWdHxVMJrsHx1Nb1RhUXyKfIHf7VzoW7JWTYKwymRMQWiYb5JrwFKtv7r+
	MZHoZd0xPwsz8RaVbvl/AP0L/v++nz8CV8xIJgq9/8c5Lrcagkp9ZCXQLl9eWEDoBowm4Td3tTN
	xvgMF3rsKErrv+oKE6kkIpXGuSkyqtBeOruON8ms5rgO0AWRpJAyTRrQ4iSEQCVthnsKUAo2u7w
	rsjA7ZyHqdHZui5pTrFLDia1w/ZlHYqAwO3QJb/AsBVEU6T7rkbdptcu787nfP4HaSjV68vFljV
	kClV4kSucsx1A+z/d1OsFpujwz8jIwl75XhtpPpC8r4/0pbBZ8O7La30qXZlmaTK3BGl7cwb8zH
	duitt6CIlVBZ633Xiovrq6y0is4V3/6YT4Dc7JOEo=
X-Received: by 2002:a05:6a00:22cc:b0:82a:1044:3563 with SMTP id d2e1a72fcca58-82f8c902bcamr29389328b3a.23.1776938283106;
        Thu, 23 Apr 2026 02:58:03 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:8fe7:77cf:52a3:6990])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3fa2sm19950118b3a.29.2026.04.23.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:58:02 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:57:58 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, emil@etsalapatis.com, 
	linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
Message-ID: <c4hm7eabmsqxlbt5s52xpxdikwkmytsgjsv4boirbv6prtsn27@iqt6o5s5up2c>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-13-tj@kernel.org>
 <177693500312.275653.17323765149266875001.b4-reply@b4>
 <20260423171156.G698a@cchengyang.duckdns.org>
 <177693691666.302051.8681445792423127931.b4-reply@b4>
 <fyeso4logqty357oe3vmbxy4nylb2c63ef3yp45zlrx5wl227t@mddzgld7y6nh>
 <c46b7b93-c80e-4c5f-ab72-aaf1fd6825a5@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46b7b93-c80e-4c5f-ab72-aaf1fd6825a5@126.com>

Hi Zhao,

On Thu, Apr 23, 2026 at 05:53:13PM +0800, Zhao Mengmeng wrote:
> On 4/23/26 17:48, Cheng-Yang Chou wrote:
> > Hi Zhao,
> > 
> > On Thu, Apr 23, 2026 at 05:35:16PM +0800, Zhao Mengmeng wrote:
> >> On 2026-04-23 17:21 +0800, Cheng-Yang Chou wrote:
> >>> Hi Zhao,
> >>>
> >>> On Thu, Apr 23, 2026 at 05:03:23PM +0800, Zhao Mengmeng wrote:
> >>>> non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> >>>> 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> >>>> |      ^
> >>>> /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> >>>> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> >>>> |             ^
> >>>> non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> >>>> 26 |         scx_bpf_kick_cpu(0, 0);
> >>>> |         ~~~~~~~~~~~~~~~~     ^
> >>>> /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> >>>> 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> >>>>
> >>>> On the one hand, non_scx_kfunc_deny.bpf.c has it own problem, it should
> >>>> not declare scx_bpf_kick_cpu(), on the other hand, the root cause is after
> >>>
> >>> If your point is that a TCP program shouldn't declare scx_bpf_kick_cpu(),
> >>> you are correct. The main goal of non_scx_kfunc_deny is to ensure that,
> >>> witch commit 2d2b026c3ea7, no non-SCX programs can use SCX func.
> >>
> >> No, I mean this bpf program can just `#include <scx/common.bpf.h>` at the
> >> start of the file, remove the scx_bpf_kick_cpu() declaration.
> >>
> >> diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> >> index 9f16d39255e7..0d6fcc8e5eb6 100644
> >> --- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> >> +++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
> >> @@ -9,12 +9,7 @@
> >> * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
> >> */
> >>
> >> -#include <vmlinux.h>
> >> -#include <bpf/bpf_helpers.h>
> >> -#include <bpf/bpf_tracing.h>
> >> -
> >> -/* SCX kfunc from scx_kfunc_ids_any set */
> >> -void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> >> +#include <scx/common.bpf.h>
> >>
> >> SEC("struct_ops/ssthresh")
> >> __u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)
> >>
> >> But before this commit, your code builds well, after this commit, it
> >> failed. That's why I suggest Tejun to add the missing KF_IMPLICIT_ARGS, it
> >> changed the signature in generated vmlinux.h, which I think we don't need
> >> expose aux argument to bpf program.
> > 
> > Ahh, thanks for the explanation, now I get it. 
> > Are you planning to send a patch to fix this, or would you like me to
> > spin one?
> > 
> > I tested the fix above, and everything works fine.
> > 
> 
> I am working on a patch and is about to send it, I will add your Tested-by,
> WDYT? 

Thanks for catching this! Feel free to add,

Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> >>>
> >>>> this commit, the signature of scx_bpf_kick_cpu() changes from
> >>>>
> >>>> `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __weak __ksym;` to
> >>>> `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym` 
> >>>
> >>> Regarding the non_scx_kfunc_deny.bpf.c build failure, I'll fix it. If
> >>> needed, we can test with another SCX function that doesn't require the
> >>> *aux parameter.
> >>>
> >>> Thanks.
> >>
> >> Like I said above, it builds well on for-next branch, just this commit
> >> trigger the failure. I believe your test case is very reasonable.
> >>
> >> Best regards,
> >> --  
> >> Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> >>>>
> >>>> After code analysis and test, I believe scx_bpf_kick_cpu miss the 
> >>>> KF_IMPILCIT_ARGS, just like the defination in scx_kfunc_ids_any.
> >>>>
> >>>> So here misses  KF_IMPLICIT_ARGS 
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_task_cpu)
> >>>> Missing KF_RCU.
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> >>>> Missing KF_IMPLICIT_ARGS
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
> >>>> Missing KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
> >>>> Missing KF_IMPLICIT_ARGS
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> >>>> Missing KF_IMPLICIT_ARGS
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> >>>> Missing KF_IMPLICIT_ARGS
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
> >>>> Missing KF_ACQUIRE
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
> >>>> Missing KF_ACQUIRE
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
> >>>> Missing KF_RELEASE
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
> >>>> Missing KF_IMPLICIT_ARGS | KF_RCU
> >>>>> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
> >>>> Missing KF_IMPLICIT_ARGS | KF_RCU
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
> >>>> Missing KF_RCU
> >>>>
> >>>> Please correct me if I miss something.
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
> >>>>> +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
> >>>>> +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> >>>>> +
> >>>>>  /*
> >>>>>   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
> >>>>>   * group; an op may permit zero or more groups, with the union expressed in
> >>>>> @@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >>>>>  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> >>>>>  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
> >>>>>  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> >>>>> +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
> >>>>>  	u32 moff, flags;
> >>>>>  
> >>>>>  	/* Not an SCX kfunc - allow. */
> >>>>> @@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >>>>>  	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
> >>>>>  		return -EACCES;
> >>>>>  
> >>>>> +	/*
> >>>>> +	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
> >>>>> +	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
> >>>>> +	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
> >>>>> +	 * intentionally permissive to ease gradual cpumask -> cid migration.
> >>>>> +	 */
> >>>>> +	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
> >>>>> +		return -EACCES;
> >>>>> +
> >>>>>  	/* SCX struct_ops: check the per-op allow list. */
> >>>>>  	if (in_any || in_idle)
> >>>>>  		return 0;
> >>>>> -- 
> >>>>> 2.53.0
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>>
> >>>
> >>> -- 
> >>> Cheers,
> >>> Cheng-Yang
> >>>
> >>
> >>
> > 
> 

-- 
Cheers,
Cheng-Yang
