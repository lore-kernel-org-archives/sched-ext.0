Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115873EC2F4
	for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949084; cv=none; b=DANXymTs6mQYoscmjfb2twYL6wjJnPudmiWVa57OH3sgp0szvhjQSopITB9sqx4pF7a13BSouxOxgLAGTCS10kTH79K/DWcMgMR16UE9o8fFY2EWJtJbxfeYPZGkCVaMrqZ19azkZMG8P1b1qqqJhz2h/+Yl/ZHZdgd7ODfglm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949084; c=relaxed/simple;
	bh=ax3eNtzuubBkBAiNVtVqjkeVxm5BE8roTfPErRXXHFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azoukbYJkp1W9hDKxENR2oIpGu+lqXZ55vG9emi+HVUZpUDpoXDSe2DSfhurSqW5plIkp05Q3g9Jo6AGeJFkxwNpFI0fBP9HIIc6wzYDWAt+SPHgKooyfpUj+E8B0MG/B+IbLqRNkU/KTFDUpdFKZx9hLIKSvVYNmPBoX03BauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwdyEEPR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwdyEEPR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a7539851fso2471119b3a.1
        for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774949082; x=1775553882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UpawA4z4cQVaoaPOAVVxLR1eQDx8dtNjmlA/PdTfwI=;
        b=nwdyEEPRnPfw36CCULc/HHcmrH00Mi3lltey5lqP4rv4lAGEru7Qq3cGbnwpr3EpZ/
         TWTW0y5ryWmnyuoFOJuj3U/W1BtPc84C4hD1enOy9sEcGe2Fo85fXt0BOyLM4iVrWK7y
         SdZJxFfAFKaNQdApz5fIGRWJg04nAa+bseztJ9jXEBPXi2KczmhuzUlfjSsGDM2MfVuF
         em4pDfk64HkEsdeYcZ8edogm9egGnNk5KTTuXim4mftfisPFM09GU6jFI78XX+nYNPLC
         45pkLGZo8opZBSX6N+WNSbEmoLmWsariAUo6nLQazlCHI1KjElGfodXRGL4TYJHpmDa+
         YNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949082; x=1775553882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UpawA4z4cQVaoaPOAVVxLR1eQDx8dtNjmlA/PdTfwI=;
        b=EytWuEv7Ick1jaAwDs4au0fjsS1LdRf5ptWwdz+9wuo+pzODcBjoxGLYFD7r56wdC+
         7xQmUzQGGAUc7qfE5yNv2NQWpB/FdJl1Ct+K4honPRWxnF7Wj7+r/1e8GKs5DOcj3Xmd
         onOzVbyD/jT45VyJXFv3U6VnzDk+B8RkCjL+6/s/X0Po5emNLlNFjOP8xWQ14HR2fXg0
         jOw75NPqgSQS1EB/8K+FRcpOrCH9FxdeGDFc/eNSQ+ZFxHP6uCVYkRgSwu5fl29qrTah
         ZDVDg+BN07HZlmYfJGqrRNGkvFetZG1jlvugd2kWQpE2NvMq2XoDOD5j/NPeIuL5jWAW
         IvoQ==
X-Gm-Message-State: AOJu0YwebHaO6L/lnYULGPY8dsysLEtqVcyfqepNJkWUf7la9iQSKMOr
	9EFoKgD0pIV71+zmuEvAlrtT9UiQFTjDudYoYRzZJUw8XY6CvVBWSGT8lm3FVQ==
X-Gm-Gg: ATEYQzyH2+06C8QAq6NBEr19NPAHdzvqyhQn6Xaj7zgvlalSrldsRQREl21Fw2xekt0
	KFVJKHHmrG7bBI9e6ZJt5B9EgeGQdReml9HtB47s3oldUv1EV2rjV7LOEdvdn57dGpHUMLn+BFK
	8/jZkc+rtAFuPDWhVcGygqB4pYnTvPvHb62Sg3zKWFDbyegenVHtPU+iYH7hItGQd+kC2nHyQOT
	yz1sCtjjEMel330N6Rlt7cQe6aY4ljkd9upCVerq/JSY5E7EV+tIveDJrNCIN7zpPdf+Ae4O1+A
	mMMnsevv2AH5LE1i5mLzCL++ZAoa/EfKEzwLGj0+lPxh+rT0tcQZsCqPx0bmXf37lOwLEsoiG3t
	O1LyOwL4nUWS+Pt0G/U2E63tV4Go4peMQSXkPeAe6yRFWIDC/0rjPXOqTOmLAZrcJeCRCMLFrV+
	Uuy7dYuSKGjSRTniiN/+KFhKcdFkTy
X-Received: by 2002:a05:6a00:4095:b0:823:3079:7c7 with SMTP id d2e1a72fcca58-82c96001c0amr15112618b3a.29.1774949082019;
        Tue, 31 Mar 2026 02:24:42 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:3807:91f6:475e:6b8c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8465785sm12397142b3a.18.2026.03.31.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:24:41 -0700 (PDT)
Date: Tue, 31 Mar 2026 17:24:35 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload
 zeroing
Message-ID: <wyp2r4ac6ddkiubgjm33nesl3hmovqrlcvfkstcuvqgtvzgryx@yd44lc6xdhn2>
References: <20260331091901.219894-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331091901.219894-1-yphbchou0911@gmail.com>

On Tue, Mar 31, 2026 at 05:18:33PM +0800, Cheng-Yang Chou wrote:
> Test plan:
> - Add a temporary sanity check in scx_task_free() before the free call:
> 
>   if (mval->data->tid.idx != mval->tid.idx)
>       scx_bpf_error("tid corruption: arena=%d storage=%d",
>                     mval->data->tid.idx, (int)mval->tid.idx);
> 
> - stress-ng --fork 100 -t 10 & sudo ./build/bin/scx_sdt
> 

While testing in virtme-ng, I encountered a bug (see below).
IIRC, Andrea sent a patch to fix this.
Has the patch landed yet, or is it perhaps in a different tree?

$ vng -m 2G -v --rw
$ stress-ng --fork 100 -t 10 & sudo ./build/bin/scx_sdt
[  111.268570] irq event stamp: 24073
[  111.268577] hardirqs last  enabled at (24073): [<ffffffff98dcc597>] _raw_spin_unlock_irqrestore+0x57/0x80
[  111.268654] =============================
[  111.268655] [ BUG: Invalid wait context ]
[  111.268732] hardirqs last disabled at (24072): [<ffffffff98dcc277>] _raw_spin_lock_irqsave+0x57/0x60
[  111.268882] 7.0.0-rc2-g94555ca6d0bb #8 Not tainted
[  111.268952] softirqs last  enabled at (24060): [<ffffffff957da30c>] fpu_clone+0xdc/0x520
[  111.269016] -----------------------------
[  111.269180] softirqs last disabled at (24058): [<ffffffff957da2b4>] fpu_clone+0x84/0x520
[  111.269282] stress-ng-fork/703 is trying to lock:
[  111.269762] ffffffff9aa64650 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_sdp_contention+0x107/0x260
[  111.269996] other info that might help us debug this:
[  111.270098] context-{5:5}
[  111.270149] 3 locks held by stress-ng-fork/703:
[  111.270279]  #0: ffff8880060a2820 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x6c/0x4d0
[  111.270563]  #1: ffff88806cfc9b20 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150
[  111.270747]  #2: ffffffff9aa65560 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x97/0x290
[  111.270933] stack backtrace:
[  111.271009] CPU: 23 UID: 1000 PID: 703 Comm: stress-ng-fork Not tainted 7.0.0-rc2-g94555ca6d0bb #8 PREEMPT(full) 
[  111.271014] Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  111.271017] Sched_ext: sdt (enabled+all), task: runnable_at=-8ms
[  111.271019] Call Trace:
[  111.271021]  <TASK>
[  111.271023]  dump_stack_lvl+0x6f/0xb0
[  111.271028]  __lock_acquire+0xfaf/0x1f30
[  111.271034]  lock_acquire+0x1b4/0x360
[  111.271037]  ? spin_lock_irqsave_sdp_contention+0x107/0x260
[  111.271042]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[  111.271046]  _raw_spin_lock_irqsave+0x3f/0x60
[  111.271050]  ? spin_lock_irqsave_sdp_contention+0x107/0x260
[  111.271053]  spin_lock_irqsave_sdp_contention+0x107/0x260
[  111.271057]  srcu_gp_start_if_needed+0x1b9/0xcd0
[  111.271062]  ? __pfx_bpf_selem_unlink_storage_nolock_misc+0x10/0x10
[  111.271065]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
[  111.271070]  ? bpf_selem_unlink_storage_nolock+0x92/0x340
[  111.271074]  bpf_selem_unlink+0x5c7/0xab0
[  111.271078]  ? __pfx_bpf_selem_unlink+0x10/0x10
[  111.271084]  bpf_task_storage_delete+0x3a/0x90
[  111.271088]  bpf_prog_c5eb66872eaef407_sdt_exit_task+0x257/0x25e
[  111.271092]  bpf__sched_ext_ops_exit_task+0x4b/0xa7
[  111.271096]  __scx_disable_and_exit_task+0x2b5/0x6f0
[  111.271100]  ? __pfx___scx_disable_and_exit_task+0x10/0x10
[  111.271105]  scx_disable_and_exit_task+0x16/0x110
[  111.271109]  sched_ext_dead+0x1b5/0x3f0
[  111.271112]  ? __pfx_sched_ext_dead+0x10/0x10
[  111.271115]  ? finish_task_switch.isra.0+0x69d/0xa30
[  111.271118]  ? kmem_cache_free+0x10b/0x5b0
[  111.271121]  ? finish_task_switch.isra.0+0x20b/0xa30
[  111.271125]  finish_task_switch.isra.0+0x70b/0xa30
[  111.271129]  __schedule+0x2ab1/0x62f0
[  111.271137]  ? __pfx___schedule+0x10/0x10
[  111.271139]  ? find_held_lock+0x2b/0x80
[  111.271142]  ? schedule+0x2c4/0x390
[  111.271147]  schedule+0xe2/0x390
[  111.271150]  do_wait+0x14c/0x460
[  111.271154]  kernel_wait4+0x103/0x1e0
[  111.271157]  ? __pfx_kernel_wait4+0x10/0x10
[  111.271162]  ? __pfx_child_wait_callback+0x10/0x10
[  111.271166]  ? __pfx___handle_mm_fault+0x10/0x10
[  111.271171]  __do_sys_wait4+0x109/0x120
[  111.271175]  ? __pfx___do_sys_wait4+0x10/0x10
[  111.271181]  ? exc_page_fault+0x66/0xc0
[  111.271184]  ? handle_mm_fault+0x151/0x430
[  111.271193]  do_syscall_64+0xfc/0x670
[  111.271197]  ? irqentry_exit+0xdf/0x570
[  111.271200]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  111.271204] RIP: 0033:0x7f66078e1ba6
[  111.271207] Code: 00 00 48 8b 15 53 12 17 00 64 89 02 48 c7 c2 ff ff ff ff 48 8b 5d f8 c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48 8b 45 10 0f 05 <48> 63 d0 3d 00 f0 ff ff 77 10 48 8b 5d f8 48 89 d0 c9 c3 0f 1f 80
[  111.271210] RSP: 002b:00007fff733cdb60 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
[  111.271213] RAX: ffffffffffffffda RBX: 00007f6606ff6b00 RCX: 00007f66078e1ba6
[  111.271215] RDX: 0000000000000000 RSI: 00007fff733cdc14 RDI: 0000000000000a5c
[  111.271217] RBP: 00007fff733cdb70 R08: 0000000000000000 R09: 0000000000000000
[  111.271219] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  111.271221] R13: 00007f6606ff66e8 R14: 0000000000000a5c R15: 00007fff733cdc14
[  111.271226]  </TASK>

-- 
Thanks,
Cheng-Yang
