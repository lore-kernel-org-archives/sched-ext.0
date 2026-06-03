Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A9330652
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494478; cv=none; b=ThVnBq8AtQVA+/xj/VsdG8z8FRH/t6HMIrIqB2hNVE3psIM6V6jsqilxS0Et6rfwMqbefu+r2pwpVEYpXd96FCIESxPHkBErSWrBNcTSxtGOV6zz479rsjEXx2DEgnFV5lsHSWhJ8PRIaYvU3BQU31g0nliagQiXjv5DkE99qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494478; c=relaxed/simple;
	bh=0GWT/xRUsZau9mIQphOhWFX0ah2neK2mYMBqtklBqwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFflAJPEm2w04n64zFQlpoLpL43yR1rpVGBpd5qqBknzX2yORo9uzEcUNTWjXuW8e0zgj/ULPRKv7XnJ7IMMRC7WAGjajOe0xgs25MaN9GERCAEoi74SOALdHDskIiEc7e+jH34Rm7rDGHUUKxcxqWGxFMjWMifjKVOsCl/e1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXdFB5jE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXdFB5jE"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423f1d8902so1515381b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 03 Jun 2026 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780494474; x=1781099274; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5z4kf7p8Gt6uCX79FL5V46n9tu3upTdO4mEiwxD3wDc=;
        b=aXdFB5jEXlVb+KHdIOLJYMPma1dMftjyuOS6GaUpBIgUt2h3NmfUqbxxI5T/PNtlH5
         Ar2LzNnHUMaH0xWHOa8Y6vM9LLro1j6HOJ0c4/MBTiTk6fUlChJPxVV+FApFRjENvlbj
         Z9Bb4B7LFcZfDAMXpCzaxaoVpLuyjMldQIdFOcPevCIHE0UPGW1z+G+M33wpKsH7Vfs+
         6cH5Vmlr6TUGRB8kwZFEuggcFQ/fsdBr5LSSTPO5eR1ppgvz0yEUC6RpBYGQWxHYFyJX
         kMPEZNaGw4bQ0i+ABAyx9ezPB6sAxYqkhHMiGwFtW3CPiCydaXv1W3zyY5puZl1sO/sk
         e73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780494474; x=1781099274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z4kf7p8Gt6uCX79FL5V46n9tu3upTdO4mEiwxD3wDc=;
        b=gVwadsbh9xE55ph8xIhzVWFH4aXzdgkiT3QrhdC5MDs/StSmhFC7vMXHu1VuSdEtPD
         ds92/UyrSsDuILoGoWpAZ0EG/AORLGnXJlizAiZF9ebKMGapMLlq9UoyeAa/LGdnsRCH
         XpFTOJ8V1Ff1e2Ts5G+8Yo/Lcv5CPyg8GSBXFoyHa+RndpqtL5wELxHvOa7Xlfnf9OBr
         BPC9xaGyPZ1pIomUgIKb0h06ByANuBCpBz67pIPF/eKBWO5kL5SX6TqdgJ6irvPAwBh/
         /e6qFjcKXfAOj/NZ5fR0X9+ejAmN5LkLOduJCgY4Vk2zafVA1Tiy9uE3Dn00RR0Onmk5
         +f2w==
X-Gm-Message-State: AOJu0YxliOdmrcVhbLDqXg3aXE5YWkVNKqp4cuZ5nvVI+mNd2gooZv/M
	BrkxZHHGB3VDczCN5Dp1paRLdZxqs7be6vMG634zMewAhc6ZbVI0TrWS9p2JBw==
X-Gm-Gg: Acq92OHVCU9HTzcKs4PN6BT42DwSRh+HoLAzyuHSzKlUTY/uVAm7c5hyCpRrcvipKiN
	YZJ3rpa0/P9+k5qNxzeDrW78zOlfEeHKLUnovip0lP5gI/n4ZYPvOTqzqNyLFzvsAtO9B1iF86z
	ndWjtflEmehp2DsqfpkKrILuiWpk5rqjD5HW6eBR7hAVZcwVGI+EogLXuDDAX2jC6M1WKyh4l9B
	rKfHDrEeb2wrbfyL5z7f68JjSQpFkFAfmAehqubf3tG/elL/FOpSlQttgrGyK7UGk0ACw6YE2cx
	CLPtM7H3Hzz4LvmkZD0DK3tJ6Nhl+EikDIxRFAVwolKB2QtjM5ouWCGiOII+kL4J6zi3I9C+o+c
	YcuMcdMVh1YCT7gqoq32k8gx9qEKRwoeLZ7rquR6SPPleVUbx7hc09iiQBEYtHiNuvH/xp8hVOY
	37z6zba/6so59VXe6fPYQ9ql7WsmsZrfa289TXnKjcuMOKK38HX7mfrRABlZVo0+NMGon+JsqBr
	0h7E58SMKBqoxEAe9+bnehFCUltGg==
X-Received: by 2002:a05:6a00:c90:b0:83f:2568:d45f with SMTP id d2e1a72fcca58-84284f5f588mr3501480b3a.23.1780494474238;
        Wed, 03 Jun 2026 06:47:54 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-195-133.dynamic-ip.hinet.net. [36.226.195.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372a16sm3866048b3a.18.2026.06.03.06.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:47:53 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:47:49 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH v4 sched_ext/for-7.2 0/3] sched_ext: Add dispatch
 transaction API
Message-ID: <20260603214527.G0c85@cchengyang.duckdns.org>
References: <20260515172807.254804-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515172807.254804-1-yphbchou0911@gmail.com>

Hi Tejun, Andrea,

On Sat, May 16, 2026 at 01:27:38AM +0800, Cheng-Yang Chou wrote:
> scx_bpf_dsq_insert() captures the task's sequence number at insert time,
> so any pre-dispatch validity checks a BPF scheduler performs before the
> insert fall outside the race detection window.
> 
> Patch 1: Rename the internal scx_dsq_insert_commit() to
> scx_dsq_insert_stage() to better reflect its role as a staging step
> before the actual DSQ insertion. No functional change.
> 
> Patch 2: Introduce a dispatch transaction API with two new kfuncs.
> - scx_bpf_dsq_insert_begin() captures the sequence number before any
>   pre-dispatch checks, opening the transaction.
> - scx_bpf_dsq_insert_commit() inserts the task using the early-captured
>   token, extending the race detection window. If the token has gone stale
>   (task was dequeued or claimed by another CPU), finish_dispatch()
>   silently discards the entry. Both kfuncs are restricted to local DSQs,
>   and commit() is callable only from ops.dispatch(). This is intended for
>   schedulers that do not implement properly synchronized dequeue.
> 
> Patch 3: Add a selftest exercising the dispatch transaction API. The BPF
> scheduler captures the token in ops.dispatch() and flips CPU affinity on
> child tasks to trigger dequeue and re-enqueue, verifying that both
> successful and stale-token dispatch paths are exercised.
> 
> Test plan:
> - Applied this series and ran selftests with vng, all tests pass.
> - Confirmed selftest skips on older kernel.
> 
> This series is discussed in [1].
> [1]: https://lore.kernel.org/r/20260319083518.94673-1-arighi@nvidia.com/

Any thoughts? Thanks.

> Changes in v4:
> - Separate the internal rename into its own commit with no functional
>   change; use scx_dsq_insert_stage() instead of scx_dsq_insert_buf()
>   (Tejun Heo)
> - Restrict scx_bpf_dsq_insert_commit() to ops.dispatch() only by moving
>   it from scx_kfunc_ids_enqueue_dispatch to scx_kfunc_ids_dispatch
>   (Tejun Heo)
> - Restrict scx_bpf_dsq_insert_commit() to local DSQs at runtime:
>   targeting a non-local DSQ aborts the scheduler (Tejun Heo)
> - Expand kdoc for both kfuncs with the full problem statement and
>   use-case context (Tejun Heo)
> - Add scx_bpf_dsq_insert_commit_args struct to stay within the BPF
>   verifier's five-argument limit imposed by KF_IMPLICIT_ARGS (Andrea Righi)
> - Selftest: pass slice=0 in commit_args to preserve the task's existing
>   slice rather than zeroing it (Andrea Righi)
> - Selftest: use the first online CPU from sched_getaffinity() instead of
>   hardcoded CPU 0 (Andrea Righi)
> - Selftest: clarify that nr_tx_stale counts attempted stale commits, not
>   rejections detected by finish_dispatch() (Andrea Righi)
> - Selftest: skip dispatch transaction path for CPU-pinned tasks (e.g.
>   per-CPU kworkers) that cannot be inserted into the current CPU's local
>   DSQ; fall back to the global DSQ instead
> - Add comment to mark_direct_dispatch() explaining why qseq validation
>   is not needed on the direct dispatch path (Andrea Righi)
> - Remove duplicate scx_bpf_dsq_insert_begin BTF entry from
>   scx_kfunc_ids_enqueue_dispatch (sashiko-bot)
> - Use u64 consistently for qseq in the dispatch buffer path
>   (scx_dsp_buf_ent, scx_dsq_insert_stage, finish_dispatch)
> - Link to v3:
>   https://lore.kernel.org/r/20260509191223.168648-1-yphbchou0911@gmail.com/
> 
> Changes in v3:
> - Rename the API from cookie to dispatch transaction: kfuncs renamed from
>   scx_bpf_task_get_cookie/scx_bpf_dsq_insert_with_cookie to
>   scx_bpf_dsq_insert_begin/scx_bpf_dsq_insert_commit (Tejun Heo)
> - Rename internal scx_dsq_insert_commit() to avoid collision with the
>   new public kfunc (Tejun Heo)
> - Move __ksym __weak declarations in common.bpf.h into the API commit
> - Redesign selftest to call insert from ops.dispatch() with CPU affinity
>   flips to actually exercise the race detection window (Tejun Heo)
> - Skip selftest on older kernels lacking the dispatch transaction API
> - Apply the same fix logic as commit e18002d2c791 to the selftest
> - Link to v2:
>   https://lore.kernel.org/r/20260506160412.522199-1-yphbchou0911@gmail.com/
> 
> Changes in v2:
> - Reword kdoc for both kfuncs to avoid exposing qseq and ops_state as
>   implementation details (Kuba Piecuch)
> - Add __ksym __weak declarations for new kfuncs in common.bpf.h
> - Add dispatch_cookie selftest (Kuba Piecuch)
> - Link to v1:
>   https://lore.kernel.org/r/20260506075925.371138-1-yphbchou0911@gmail.com/
> 
> Thanks,
> Cheng-Yang
> 
> ---
> 
> Cheng-Yang Chou (3):
>   sched_ext: Rename scx_dsq_insert_commit() to scx_dsq_insert_stage()
>   sched_ext: Add dispatch transaction API
>   selftests/sched_ext: Add dispatch_cookie test
> 
>  kernel/sched/ext.c                            | 112 +++++++++++++-
>  kernel/sched/ext_internal.h                   |   2 +-
>  tools/sched_ext/include/scx/common.bpf.h      |   2 +
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/dispatch_cookie.bpf.c | 120 +++++++++++++++
>  .../selftests/sched_ext/dispatch_cookie.c     | 139 ++++++++++++++++++
>  6 files changed, 369 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c
> 
> -- 
> 2.48.1
> 

-- 
Cheers,
Cheng-Yang
