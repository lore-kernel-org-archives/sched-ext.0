Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0875378D8C
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939073; cv=none; b=UcWCmDA4S07neXIW4i3tW+p7b11lcx5/3M2JXgKPE2C9ZhYQy1tNroHU9oBNHCW7D0waWwMZB3Kw+Xgu4vJgesw6I6VzdOVSOLDaDCnhjQCl7h6mac8cXHPpQZ43YCCLokGcFn8lP3+Rrb65GF62h4AADySl7pQUzSy+upQTowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939073; c=relaxed/simple;
	bh=Uev1A1IJqjGUBY+XI/CF9FiL8iqdzS5rd7OUOLXiuXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhLx9Wx6cTGqa7PGv2JFH10OD08Y9VaSEOyrH/H5uw/beOu1jfwxEukkeJTmlen1EJoQQTJFyolAoJF+qOjcgqgSZxPj9ykEsCl6FH0Jq89aZwqfOi7fXVLfElsDZawMp6o2v5B3Wt2OrLml2NWYZsBEhaotkkkiCkfXz4+CiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4642FUD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4642FUD"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso4528985a91.0
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776939071; x=1777543871; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oFzIyjZgewpt7kgyc/KhZdPraItJdPjiKhMNmR9bZs=;
        b=L4642FUD5kBj0fv725csJBM2TKW9jfe4bk4rsbBBwtc9Rw31qbEmLBZUgBMhgdG4fe
         2ZqZgsZC8EQqGSq6QujoJOsIGiiJkMwJIN57HEPAFMu9mwYO57hX4w+RyaItQctqWfB6
         d7MCHI/FmDAXgSXKT6bFkYOmGnjhJdDDpP+qUXZy/Ds3k1W0u85XTdPxDWEO7MOQttqB
         r7dRcmH+kHYsvoX4ql5mV8WaQwqrc1O7CZ5wCwI+KYbbC6aMl7SH8grehMnOJLaGTXOw
         bq5MuxbnemeNRQMr4Q47yOGJIadwpLRoCduvgcJu7O5tnOMeRBcFjOkqH4tVyFBmEDIf
         GzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939071; x=1777543871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oFzIyjZgewpt7kgyc/KhZdPraItJdPjiKhMNmR9bZs=;
        b=HDqSyjv2uqdkbyR/MhPJzYKJPOkyxeFV+JZdAB8WFXdPMxh5X4/BjtAIALFRGRlVGh
         bRhDeIdDySu4Jkll0oTIgjPCWPVh7y49UiI12Oj61kr0THcN/yB3vJJ4x11XHgF7jQEx
         C1mk9rXGNjs9qUtLGpxgKeg1wEHK/p4sHrsw7PVPW13pj6ENx/Enj/DJMTdaWQNUxwfF
         BKzv6TSJZdkNTdN0AGtol1SjhioNWurJ+khMHIoJ99gDZl4T6gDX2eUCUgm692s052yK
         RaJ3DQyUcHzd9Q1Q0P553L70y7jDGhcr3E0ASEhIu5AOzN63EyzdfVvYnsZN+GuE/ea5
         b0QQ==
X-Gm-Message-State: AOJu0YwjqH72QFYW6JksaBWnTNSxl1F+H9M0JmkS4zAl8CqUf+i200Mh
	sh10cJ6I8QMhOCj0e/f5lRacQ0PoV9QbEo6F7llwo7V9Op7ke5ac4l5W0KhziC/C
X-Gm-Gg: AeBDievlbvu9KzBiQdgqiEOht/psDrF6b0vfjLEd3F9lq3hZi0viP4r6OHyNZ3VPoBZ
	fH6PaZ+fRPJd6HTr0AjIYn6cNAMc7IoRHYER3K1B3+LF5UoLpe/6I4h15HITAZ08UTasBU5xbSI
	iTHDbI0lsYblPPyYX70999p2ExUmOFq6ld3cEbFKSf1M5EGoMk3pBy3TbC/20o/FmSXjEo2375l
	sQTKBXkN3qlMRlArzdzMQDuKHz4SRPtBKpsBZcXjkevYXYV0tym0r3rwjeA/8ToUHg1DBFzA+6W
	FWupL55qp2r6thb6CoWGslMmwb1VRR7aHzu8wz48QV1zP+ZcNmSa6JE7dEVetfSir9lInOn42hr
	b6heGgCsSNXTcvw0ghGSMur1+VQddjWsIw/cKqmjMwmPijPHZCadUw+S80cSxktI9RFuxPq0nGU
	zg3GaRIKQGdziGR0/lzCVMB/GwHNPGTFWxRNupHbc=
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3614046c9f7mr26637893a91.17.1776939070891;
        Thu, 23 Apr 2026 03:11:10 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:8fe7:77cf:52a3:6990])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caf1sm199909175ad.42.2026.04.23.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:11:10 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:11:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [BUG] selftests/sched_ext: reload_loop failed
Message-ID: <yww2ljjozzwsoetokd47w7inmpd4uvyh3hxdsievq5hnmgyvh5@3uzx7s5en2eb>
References: <20260419174413.Gf28b@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419174413.Gf28b@cchengyang.duckdns.org>

On Sun, Apr 19, 2026 at 05:51:57PM +0800, Cheng-Yang Chou wrote:
> I am testing based on commit 5425abc222bc (tj/for-7.2 branch) using virtme-ng.
> The kernel config I'm using: 
> - https://github.com/sched-ext/scx/blob/main/kernel.config
> 
> While running `./runner -t reload_loop`, I encountered the following error. 
> I'll begin a bisect and provide more details once I have them, just wanted
> to bring this up now in case it looks familiar.

Since i'm testing scx-cid branch, same issue hit while testing NUMA
with virtme-ng.

===== START =====
TEST: numa
DESCRIPTION: Verify NUMA-aware functionalities
OUTPUT:
[   42.567360] Oops: int3: 0000 [#1] SMP NOPTI
[   42.567780] CPU: 5 UID: 0 PID: 642 Comm: scx_enable_help Not tainted 7.0.0-g92f8cb8241dd-dirty #14 PREEMPT(lazy)
[   42.567949] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.568109] Sched_ext: numa (enabling+all)
[   42.568179] RIP: 0010:update_rq_clock+0x6c/0x280
[   42.568263] Code: 00 00 8b 83 20 0e 00 00 a8 02 0f 85 89 00 00 00 0f 1f 44 00 00 83 c8 04 8b bb a8 0e 00 00 89 83 20 0e 00 00 e8 d5 43 05 00 eb <75> 48 89 c5 48 2b ab 10 0e 00 00 78 62 48 89 83 10 0e 00 00 48 8b
[   42.568328] RSP: 0018:ffffa775c1547c80 EFLAGS: 00000007
[   42.568356] RAX: 00000009e92dde7d RBX: ffffa2efb533d900 RCX: 0000000000000000
[   42.568367] RDX: 00000009e92dde7d RSI: ffffffffd61bc543 RDI: 0000000000000002
[   42.568379] RBP: ffffa2efb533d900 R08: 0000000000000002 R09: 0000000000000001
[   42.568389] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000004e
[   42.568400] R13: ffffa2efb5498260 R14: ffffa2edca374000 R15: ffffa2f00ccb2000
[   42.568455] FS:  0000000000000000(0000) GS:ffffa2f00ccb2000(0000) knlGS:0000000000000000
[   42.568467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.568477] CR2: 00007f2cde9cf680 CR3: 00000002d984c000 CR4: 00000000000006f0
[   42.568575] Call Trace:
[   42.568695]  <TASK>
[   42.568792]  sched_change_begin+0x1d1/0x2c0
[   42.568899]  scx_root_enable_workfn+0x871/0x9c0
[   42.569048]  ? kthread_worker_fn+0x50/0x3b0
[   42.569060]  ? __pfx_scx_root_enable_workfn+0x10/0x10
[   42.569069]  kthread_worker_fn+0xcb/0x3b0
[   42.569087]  ? __pfx_kthread_worker_fn+0x10/0x10
[   42.569098]  kthread+0xf4/0x120
[   42.569107]  ? __pfx_kthread+0x10/0x10
[   42.569126]  ret_from_fork+0x275/0x340
[   42.569134]  ? __pfx_kthread+0x10/0x10
[   42.569145]  ret_from_fork_asm+0x1a/0x30
[   42.569219]  </TASK>
[   42.569275] Modules linked in:
[   42.569686] Oops: int3: 0000 [#2] SMP NOPTI
[   42.569699] ---[ end trace 0000000000000000 ]---
[   42.569779] CPU: 9 UID: 0 PID: 0 Comm: swapper/9 Tainted: G      D             7.0.0-g92f8cb8241dd-dirty #14 PREEMPT(lazy)
[   42.569830] RIP: 0010:update_rq_clock+0x6c/0x280
[   42.569840] Code: 00 00 8b 83 20 0e 00 00 a8 02 0f 85 89 00 00 00 0f 1f 44 00 00 83 c8 04 8b bb a8 0e 00 00 89 83 20 0e 00 00 e8 d5 43 05 00 eb <75> 48 89 c5 48 2b ab 10 0e 00 00 78 62 48 89 83 10 0e 00 00 48 8b
[   42.569845] RSP: 0018:ffffa775c1547c80 EFLAGS: 00000007
[   42.569845] Tainted: [D]=DIE
[   42.569854] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   42.569860] RIP: 0010:update_rq_clock+0x6c/0x280
[   42.569876] Code: 00 00 8b 83 20 0e 00 00 a8 02 0f 85 89 00 00 00 0f 1f 44 00 00 83 c8 04 8b bb a8 0e 00 00 89 83 20 0e 00 00 e8 d5 43 05 00 eb <75> 48 89 c5 48 2b ab 10 0e 00 00 78 62 48 89 83 10 0e 00 00 48 8b
[   42.569881] RSP: 0018:ffffa775c02f0e90 EFLAGS: 00000003
[   42.569888] RAX: 00000009e93aba75 RBX: ffffa2efb56bd900 RCX: 0000000000000000
[   42.569891] RDX: 00000009e93aba75 RSI: ffffffffd61bc543 RDI: 0000000000000002
[   42.569894] RBP: ffffa775c02f0ed8 R08: 0000000000000002 R09: 0000000000000000
[   42.569897] R10: 0000000000003965 R11: 0000000000000000 R12: 0000000000000000
[   42.569900] R13: 0000000000000000 R14: ffffa2edc0988000 R15: 0000000000000009
[   42.569903] FS:  0000000000000000(0000) GS:ffffa2f00ceb2000(0000) knlGS:0000000000000000
[   42.569874]
[   42.569907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.569909] RAX: 00000009e92dde7d RBX: ffffa2efb533d900 RCX: 0000000000000000
[   42.569910] CR2: 000055803f00a000 CR3: 00000002d984c000 CR4: 00000000000006f0
[   42.569913] RDX: 00000009e92dde7d RSI: ffffffffd61bc543 RDI: 0000000000000002
[   42.569914] Call Trace:
[   42.569916] RBP: ffffa2efb533d900 R08: 0000000000000002 R09: 0000000000000001
[   42.569919] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000004e
[   42.569921] R13: ffffa2efb5498260 R14: ffffa2edca374000 R15: ffffa2f00ccb2000
[   42.569925] FS:  0000000000000000(0000) GS:ffffa2f00ccb2000(0000) knlGS:0000000000000000
[   42.569927]  <IRQ>
[   42.569929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.569932] CR2: 00007f2cde9cf680 CR3: 00000002d984c000 CR4: 00000000000006f0
[   42.569941]  sched_tick+0xa1/0x3a0
[   42.569956]  update_process_times+0xa4/0xf0
[   42.569967]  tick_nohz_handler+0x8d/0x160
[   42.569976]  ? __pfx_tick_nohz_handler+0x10/0x10
[   42.569983]  __hrtimer_run_queues+0x72/0x340
[   42.569999]  hrtimer_interrupt+0x114/0x250
[   42.570015]  __sysvec_apic_timer_interrupt+0x6a/0x1c0
[   42.570074] Kernel panic - not syncing: Fatal exception in interrupt
[   44.017037] Shutting down cpus with NMI
[   44.017495] Kernel Offset: 0x24000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   44.022221] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
qemu-system-x86_64: terminating on signal 15 from pid 940918 (htop)

-- 
Cheers,
Cheng-Yang
