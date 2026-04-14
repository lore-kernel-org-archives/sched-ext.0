Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83C3E275C
	for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170325; cv=none; b=mOcUrM7WT5tbteI1MysirriwjHTcTwQOCbOF9r45y/6THc/SK8zc6loA/r78esh9UV/hS8TaDR4vmXNTNq8gZnF/tcd9lK//BldY28iFKDWKNQ9rTrXbe+32Z7m+Fwxl6l6wdvhEoT9ZjVjoOyvbnMKiXAaxOnQOc+C18HYuigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170325; c=relaxed/simple;
	bh=IDUHEoc9IMQmEyJ7zaOyhXp5dECdabqPboEfWiFbLas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx/M4732lmH3TuIxifDHkBDmMbXhRroBjzOXd/wFRHUfi5aaQzqdmPEPU5dRWIBf/YD9j/0gm7nNXlwT74ZpRElCVMBTkz+b1heLMju3UkBxZk+5dt6+WlV8Tmrt1afGN8Ac3CA767GC9CUfmu07X2/8Dph1b80brBJZ72HC1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRmzoz04; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRmzoz04"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso4773322a91.3
        for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170324; x=1776775124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNKFB9lrr4XL7PfssPaK+M9NZgQDIRZgrK0ojBUTM/g=;
        b=MRmzoz042raBmJFfWSDLYiSClu47UU18iZi/gaoGzMLLAABv+UeQBgL8zw334L3pEV
         rNILlModK7cTJzzIyBTpf7yVWszpYRzbNZHo43uW5JrLfCF/lMl8M9O4G/yhFDBWzPHs
         kaeJ8GspBwSYPG2QnOr1n5seRcOsV/Ph1j3AzE1UfPMK5BtCBGLVQ2VkQICafft4AFYT
         8hdNSLaBVuku5K84ri+F6s8rjLLrfeMHfu4yLuioZaye/lchouQVmyXbhgQiSTtN2W2J
         pGL0FmonGKh+FqChNYaysPGKRjUIzYJsMdb4zoOmTJBC3LQHzeYw+wvuM43ZbxTqoKXs
         ojvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170324; x=1776775124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNKFB9lrr4XL7PfssPaK+M9NZgQDIRZgrK0ojBUTM/g=;
        b=BbHXlpHFpA94XcMlVHLNdLc9BixUQRj4aaB0L7KU6+r24VXoxHFiNvXp3m03Gtyrcd
         xOyyQfIeX0T1134+qLB/JwyY+BrUYmKxxVEzbwq95gHI2Xs5dMrupcfsu6gCgY1ZAAuI
         jLcRf8MeyZYZ1VcPudpXq9kKhdl6MzmW8m6xt9n6fIoWBW5IaDFUw/yVSxYCBkRG2Jz2
         83Ug64/4Thtu/wMS9KjuCvWFMrs3d6oAE5o3BcQiuFL6TYER7CG4xhj3XKs656TWscTV
         HKLMBzDUcCclM5aHNi+N72SzKvuhPA/UroRE5/Jk5e81HnLFyJ/aqnPqsyS7YUBq/h4q
         YY+A==
X-Gm-Message-State: AOJu0Yw1v/FVIZT915AUHdZFafR75TSclHXbjPVIDZghSZ0iuTBgETWx
	msrBDhNRjJcN1B58yznzX89qODknCgDi7PPBlM7hwfj0k3Jpf6jASt/a
X-Gm-Gg: AeBDieuDuQx0kws/8xYkZWSvtrbMcDIgcaJES/P6UoNF5/USlK2M9uKiruJTUBgWs6e
	8P5Kc94HSerWc0cDjIRf5UwTZvTxP4WjkmAbH1gdNKvMCWbQujxFlzNdqgpg19dQ9Tvb+PfIult
	qucP6L1LhpJqoGN/9NlO5GNZdfhO7Hkm72NbEdg6Q/HZ/fj2Wo9wR+3ERi/cwigwE+0IOWux6Bf
	mMIwuzGHHK9QyYMVGWNqzRn+7W2xdUkADGp8XmYLLewp7UZ70CcbaglXHkZJyvqKEEtE72LwC07
	3iVbBKc1xXDwuhPMXDRrMnwpiXvSldtrv/GvHgiNEJ/X6VYADyRQr8V5FzdC7DUmx4FCHeUk9N2
	vqPdAimrbgIWS/95Imw3tR7S0BVxiwwbvGWiQLeorAqxpec6cjVXH2nNytYnY7h3dr+LOEc1D2u
	w0AjzSZFimUGsbZEBeBpl6yIF/4zXh
X-Received: by 2002:a17:90b:4c0c:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-35fb7f5117dmr7302972a91.3.1776170323483;
        Tue, 14 Apr 2026 05:38:43 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:839f:5f0c:bfd1:44c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4306b900sm5325702a91.11.2026.04.14.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:38:43 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:38:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Juntong Deng <juntong.deng@outlook.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Add verifier-time kfunc context filter
Message-ID: <f2ab3yg5niso6hxqe7sd4jmv5xzdizk3khcspm5bylfbn3mj44@tpyiezvs4cod>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-8-tj@kernel.org>

Hi Tejun, Andrea,

On Thu, Apr 09, 2026 at 08:30:43PM -1000, Tejun Heo wrote:
> +/*
> + * Verifier-time filter for context-sensitive SCX kfuncs. Registered via the
> + * .filter field on each per-group btf_kfunc_id_set. The BPF core invokes this
> + * for every kfunc call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
> + * BPF_PROG_TYPE_SYSCALL), regardless of which set originally introduced the
> + * kfunc - so the filter must short-circuit on kfuncs it doesn't govern (e.g.
> + * scx_kfunc_ids_any) by falling through to "allow" when none of the
> + * context-sensitive sets contain the kfunc.
> + */
> +int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	bool in_unlocked = btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id);
> +	bool in_select_cpu = btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id);
> +	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
> +	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
> +	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> +	u32 moff, flags;
> +
> +	/* Not a context-sensitive kfunc (e.g. from scx_kfunc_ids_any) - allow. */
> +	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release))
> +		return 0;
> +
> +	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
> +	if (prog->type == BPF_PROG_TYPE_SYSCALL)
> +		return (in_unlocked || in_select_cpu) ? 0 : -EACCES;
> +
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +		return -EACCES;
> +
> +	/*
> +	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
> +	 * guarded by bpf_ksym_exists(), before check_attach_btf_id() sets
> +	 * prog->aux->st_ops. Allow all kfuncs when st_ops is not yet set;
> +	 * do_check_main() re-runs the filter with st_ops set and enforces the
> +	 * actual restrictions.
> +	 */
> +	if (!prog->aux->st_ops)
> +		return 0;
> +
> +	/*
> +	 * Non-SCX struct_ops: only unlocked kfuncs are safe. The other
> +	 * context-sensitive kfuncs assume the rq lock is held by the SCX
> +	 * dispatch path, which doesn't apply to other struct_ops users.
> +	 */
> +	if (prog->aux->st_ops != &bpf_sched_ext_ops)
> +		return in_unlocked ? 0 : -EACCES;

After reconsidering the concern raised by Sashiko [1], I think we should
not allow non-SCX struct_ops programs to call SCX unlocked kfuncs.

I found two concrete problems with the current approach:

1. KASAN slab-out-of-bounds in scx_prog_sched()

   With CONFIG_EXT_SUB_SCHED=y, scx_prog_sched() blindly casts the
   pointer returned by bpf_prog_get_assoc_struct_ops(aux) to
   struct sched_ext_ops * and reads ops->priv.

   For a non-SCX struct_ops program we could hit a KASAN bug. 
   Verified (See Full log [2]):

    [   46.496052] BUG: KASAN: slab-out-of-bounds in scx_bpf_kick_cpu+0x29c/0x2b0
    [   46.496175] Read of size 8 at addr ffff88811167bd10 by task scx_oob_kasan/633
     ...
    [   46.496478]  ? scx_bpf_kick_cpu+0x29c/0x2b0
    [   46.496488]  scx_bpf_kick_cpu+0x29c/0x2b0
    [   46.496494]  bpf_prog_746ba9ec0529bae2_test_ca_init+0x27/0x29
    [   46.496499]  bpf__tcp_congestion_ops_init+0x47/0xa3
    [   46.496506]  tcp_init_congestion_control+0xad/0x430
    [   46.496512]  tcp_init_transfer+0x537/0x8f0
    [   46.496519]  tcp_finish_connect+0x1ef/0x700

2. Non-SCX programs should not call SCX kfuncs

   Allowing non-SCX struct_ops programs to call unlocked kfuncs such as
   scx_bpf_kick_cpu() is semantically wrong.

So I think we should do the following:

1. Add a filter to deny all context-sensitive kfuncs for non-SCX
   struct_ops programs, not just the rq-locked ones.
   This makes the runtime OOB in scx_prog_sched() unreachable.

2. Add a selftest: a TCP BPF program that calls scx_bpf_kick_cpu()
   should be rejected at load time.

Wdyt, thanks.

[1] https://sashiko.dev/#/patchset/20260410063046.3556100-1-tj%40kernel.org?part=7
[2] https://gist.github.com/EricccTaiwan/d1787f4f1fa5b5d42d436fbe7c0e2b3b

-- 
Thanks,
Cheng-Yang
