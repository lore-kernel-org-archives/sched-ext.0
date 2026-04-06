Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619412DB791
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490747; cv=none; b=Ernl0QLXqIBKOi8FBztZLB1029OQhOl0q9d6UfXL3nXFLzy0PAEnTF5elws8TIF7NCtbq4vFjgzztECXuxgrArcLWKIeqGBB4HOgRiBuNWQ05+o03rrylZgfzyRNJ+KCjA+Jnavkd5nachmtUWKUzmTF5R6gjP8UgTFzey2rSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490747; c=relaxed/simple;
	bh=IjxgiLtasVXf4Q7aIh29hwEt3CmyjTxitIdDxKP4xNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qePf0KReb6PHXTxiflEbM7s6cG1PKng+eYskKH0bqGLjWmHsCg88S4Mq+Zz2meuXEDwpKmgNCapySG37IS4qooQsWjk6gSydLz1boFh+BoJl5Dpn+LZR2/axSpnlNjx1obCyvHxq9nWuiQd8N7YYFuHRLxaAEoW2RuHRShvEB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H08034w3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H08034w3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso2503449a91.3
        for <sched-ext@lists.linux.dev>; Mon, 06 Apr 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490745; x=1776095545; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/82eLXLa5m3aJk5eLGEqEuqy3BDLr/HerUOUqzXbeI=;
        b=H08034w3hvWjK9CzD6BybeoLqcy6zIOsnwTgkvun7hYDv1Vxdh0qbk5rHkfYRqGsoO
         QaYUg7LMYjtqsLCIe4spFM0oAtRIPVabIwdm6iddb0aVmysqOjQBt6kLalxhp03AQyGs
         awv2SHbsY7qaMcUas/0X0S1JVn42vy85+jDANsqU62h7Y4xT9CIpFX/IEep5LwBqKnis
         5ImGw98O6RcJTPA2Ne3xxG4QZ+4PiOqzBgzGMCgDDMNtb0ysTpC+iLRbnybxkRXa88lc
         x18xvfb9S3DxlG4Hv/DByuShq9qRRsjrZqhQM6R6uVaJRB+1W3M7jHSorX8nZk3p48kb
         B9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490745; x=1776095545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/82eLXLa5m3aJk5eLGEqEuqy3BDLr/HerUOUqzXbeI=;
        b=nPA2AqBDS52tEh8lxQFr0NgL8rcd8wnQhtrYefqYvOgMM6jVMgbsX33K6oOyyWJMAV
         A1rkub1GFzy8xSaydAmg9Gwgpg6zZFuUAioK1bDkdic1EfwD28h0EgWjYVrYzn8R+xGu
         2JWFx7LGtsWRDHeEIGxXm0O5QdpGTw2GP2DvoD20wEqnYasrbTv2GfVCUAkzkfKTB1B+
         Fv7DypVFEVdGskA7lRfsp7btnWt7ElTSaYyeLewggfiXQl3wuOdfTM1UVt4rw0ccy281
         bAg4/3C1hoRZBms+mf89/pLd9DIwEjkDK9+TN54umfdDaqexWWRsGBAW3HScb+f4a3Pr
         8B7g==
X-Gm-Message-State: AOJu0YyY1QN+CJd8S1MagsPo00oBFNHCa9wrfwT7YFnUCn+RRA56TqlT
	BJuxRIWlW/UXuMt6EBBmSAM4mTVJ8eKOYJt92Tidti87WatragoxLyZaZ/22vw==
X-Gm-Gg: AeBDievgGslaRkNdVdNGNg+UTlG88UeTnpjOEEhF9I3NIfcsWA6Uc3+Sy5zZ3wrjtCf
	PFNaFqlRaBNMM2XwuEpUPaP/PQf0p2jxiVR20P2hmPplv+XUQCZeM33cJx+OtgsiQQwbb0ZmtM3
	ZLM7vk4VYRCPZ6+ENG0eX1bVtSxP8dUZGI/EPCnoXk6wWAMzNdv08jLpjr/M1XMJSG9zt4dz5iF
	FxcnKZU3nbAV5jT1OzZNacv6lEoMVdmrI/tzTh+tyJ4cVqy2SdIPPDwU+59lzAkjvlLiO+6EYlQ
	3q44nybRKdBpvakr2IkjCx4oODlKRCpqb9SfaHKcA+dBkL5x/yZXfE6K4s2wRk+JGKLOpYSBkNN
	lnKnWtHfp9Nl5k5K1jPDrn7Dan2pJ2tma0SkSLcBuSnWMbhz1Ib+6VFs6CVWJJ/ISnNIkmB0+mq
	/EN1gUClK2l1WxzpptmpIi8h7k2T4seQX7G1VjrBQ=
X-Received: by 2002:a17:90b:384e:b0:35c:d01:d3dc with SMTP id 98e67ed59e1d1-35de68ec479mr11600675a91.18.1775490745357;
        Mon, 06 Apr 2026 08:52:25 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:6100:c268:4a0b:d6d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm25129050a91.12.2026.04.06.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:52:24 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:52:19 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, Juntong Deng <juntong.deng@outlook.com>
Subject: Re: [RFC PATCHSET v4 sched_ext/for-7.1 0/2] sched_ext: Make kfunc
 filters support struct_ops context to reduce runtime overhead
Message-ID: <spz2f2bt32ln3xbtkhwek7uqejxrrucfqytirrruy5lu7xgvwp@juanrgxr2te7>
References: <20260406154834.1920962-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406154834.1920962-1-yphbchou0911@gmail.com>

On Mon, Apr 06, 2026 at 11:48:30PM +0800, Cheng-Yang Chou wrote:
> This patchset makes kfunc filters support the use of struct_ops context
> information to enforce SCX kfunc restrictions at BPF load time instead
> of at runtime.
> 
> With the improved kfunc filters, SCX no longer needs the mask-based
> runtime kfunc call restriction, so this patch series removes it.
> 
> Test plan:
>  - All sched_ext selftests passed.
>  - Tested all demo schedulers (except scx_flatcg) and multiple upstream
>    SCX schedulers (scx_beerland, scx_bpfland, scx_cosmos, scx_flash, scx_lavd)
>    under stress (stress-ng --cpu 0 --timeout 10s) with no crashes.
> 

While testing this patchset with scx_flatcg, I encountered the following
error. I then switched back to the tj/for-7.1 branch and tested again,
but saw the same error.

Therefore, I believe this is not caused by this patchset.

For both tests (patchset and tj/for-7.1 branch), I have applied the
patches Andrea mentioned before: 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=175b45ed343a9c547b5f45293d3ea08d38a7b6f4
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61bbcfb50514a8a94e035a7349697a3790ab4783
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c405fb3279b39244b260b54f1bd6488689ae235

Log:
root@virtme-ng:/home/eric-wcnlab/dev/sched_ext/tools/sched_ext# stress-ng --cpu 0 --timeout 10s & sudo ./build/bin/scx_flatcg
[snip]

[   94.113441] sched_ext: BPF scheduler "flatcg" disabled (runnable task stall)
[   94.113783] sched_ext: flatcg: stress-ng[623] failed to run for 45.289s
[   94.114026]    scx_exit+0xa3/0xd0
[   94.114189]    scx_watchdog_workfn+0x4e9/0x9c0
[   94.114417]    process_scheduled_works+0x922/0x1930
[   94.114644]    worker_thread+0x4e4/0xd90
[   94.114822]    kthread+0x3d4/0x4a0
[   94.114979]    ret_from_fork+0x557/0x7b0
[   94.115135]    ret_from_fork_asm+0x1a/0x30
stress-ng: info:  [623] dispatching hogs: 24 cpu

DEBUG DUMP
================================================================================

flatcg: root
kworker/u96:3[168] triggered exit kind 1026:
  runnable task stall (stress-ng[623] failed to run for 45.289s)

Backtrace:
  scx_exit+0xa3/0xd0
  scx_watchdog_workfn+0x4e9/0x9c0
  process_scheduled_works+0x922/0x1930
  worker_thread+0x4e4/0xd90
  kthread+0x3d4/0x4a0
  ret_from_fork+0x557/0x7b0
  ret_from_fork_asm+0x1a/0x30

CPU states
----------

CPU 4   : nr_run=1 flags=0x1 cpu_rel=0 ops_qseq=11 ksync=456
          curr=swapper/4[0] class=idle_sched_class

  R stress-ng[623] *root -45289ms
      scx_state/flags=3/0x3 dsq_flags=0x1 ops_state/qseq=0/0
      sticky/holding_cpu=-1/-1 dsq_id=0x1
      dsq_vtime=539683794 slice=20000000 weight=100
      cpus=ffffff no_mig=0

    asm_sysvec_apic_timer_interrupt+0x1a/0x20
    ftrace_likely_update+0x6c/0xc0
    __rcu_read_unlock+0xb5/0x5f0
    kernfs_root+0xf5/0x220
    kernfs_active+0x7d/0x130
    kernfs_dop_revalidate+0xa9/0x6c0
    lookup_fast+0x4e0/0x6e0
    link_path_walk+0x695/0x20e0
    path_openat+0x23d/0x2f30
    do_file_open+0x26e/0x3e0
    do_sys_openat2+0x131/0x3e0
    do_sys_open+0x9d/0x100
    __x64_sys_openat+0x9c/0x100
    do_syscall_64+0xfc/0x670
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU 5   : nr_run=1 flags=0x1 cpu_rel=0 ops_qseq=12 ksync=1510
          curr=kworker/u96:3[168] class=ext_sched_class

 *R kworker/u96:3[168] *root +0ms
      scx_state/flags=3/0xd dsq_flags=0x0 ops_state/qseq=0/0
      sticky/holding_cpu=-1/-1 dsq_id=(n/a)
      dsq_vtime=46302895 slice=20000000 weight=100
      cpus=ffffff no_mig=0

    scx_dump_state+0x12de/0x1b60
    scx_disable_irq_workfn+0xce/0x110
    irq_work_single+0x14c/0x250
    irq_work_run_list+0xa2/0xf0
    irq_work_run+0x4d/0xb0
    __sysvec_irq_work+0x4c/0x300
    sysvec_irq_work+0x8a/0xb0
    asm_sysvec_irq_work+0x1a/0x20
    scx_watchdog_workfn+0x55d/0x9c0
    process_scheduled_works+0x922/0x1930
    worker_thread+0x4e4/0xd90
    kthread+0x3d4/0x4a0
    ret_from_fork+0x557/0x7b0
    ret_from_fork_asm+0x1a/0x30

Event counters
--------------
              SCX_EV_SELECT_CPU_FALLBACK:                0
       SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE:                0
               SCX_EV_DISPATCH_KEEP_LAST:                1
                 SCX_EV_ENQ_SKIP_EXITING:                0
      SCX_EV_ENQ_SKIP_MIGRATION_DISABLED:                0
                      SCX_EV_REENQ_IMMED:                0
               SCX_EV_REENQ_LOCAL_REPEAT:                0
                 SCX_EV_REFILL_SLICE_DFL:                0
                  SCX_EV_BYPASS_DURATION:         34046683
                  SCX_EV_BYPASS_DISPATCH:                0
                  SCX_EV_BYPASS_ACTIVATE:                1
                 SCX_EV_INSERT_NOT_OWNED:                0
              SCX_EV_SUB_BYPASS_DISPATCH:                0

================================================================================

EXIT: runnable task stall (stress-ng[623] failed to run for 45.289s)
root@virtme-ng:/home/eric-wcnlab/dev/sched_ext/tools/sched_ext# stress-ng: info:  [623] skipped: 0
stress-ng: info:  [623] passed: 24: cpu (24)
stress-ng: info:  [623] failed: 0
stress-ng: info:  [623] metrics untrustworthy: 0
stress-ng: info:  [623] successful run completed in 10.47 secs

-- 
Thanks,
Cheng-Yang
