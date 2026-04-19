Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB31A6831
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592324; cv=none; b=f0PymCze+0nB8wDErzA8fmUoeucvAOH7VZSeL/b9GeXBK8yZtBP4v31Gf7E+ciSU3NqYoxMjKHiMoB7GF+gMNxOgA1dU6ZgLWocAemvwcrsFAvH0Tc9eyTfUTV6awr5k7snu5aL1UtUauiGSgZfpDqaqJh4ntWxMR9/lzFaCbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592324; c=relaxed/simple;
	bh=oq/2U6SDyEdU+KxhwbSupW1FBoYFcxz8oHw1mwRC/IE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ADwFB7d1PDTdv36bAmxbfyDnI+Nw+Ad81hoR1Rqc9r1XWNinCDs8kXBHo7Z6Ez3vsxwX9Y92B49FqNfOQf4tOTivX82ISSoLHuKDbUL/GPJRXLNNBCcn/tJyJGLXPoB/uq7YQIVKKYGlmMFNacTpdH5+Y4ouNeXge0+LxlmQ3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhBUBFuH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhBUBFuH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso187125b3a.0
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592322; x=1777197122; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrxGyHBOGlRgOFcxVrhPMsX9l4cTFmEE0L54GVvhu1Q=;
        b=nhBUBFuH/s5x3LYziqmXZG4M9d02TBbBgqiYJ7mM/E0HUnUuXidXGiqbnlLs7a8Mo+
         8Hcydu+eDOPON6PzqpxGNtneObj3VHXbSk9rZ3tBnupARxLi2KPuxfmf30+MsH8uq1hF
         bhd/tuaRNGKZRLt6GG08cjYLtvG2dyg8Gm+7zWdNKvbZggu3QmT2zeQktx2JaIxMyb5e
         /L87dmtyJEZRJUHTgWeTksjoZf16ccNyahNegotikUTUhPMoQ760oDsO3r4EXyW5309b
         JYgPigdiAxTkIoK2cMlP0OO4rvXJFptbuzRU3lniuIKaDnrJ2yR9dLuxsAMljWc0hpcT
         nwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592322; x=1777197122;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrxGyHBOGlRgOFcxVrhPMsX9l4cTFmEE0L54GVvhu1Q=;
        b=pCH5lS+hpzApO1/2AKadZodOpu5uCy1s5ULECXBoRpXC3CcpZOjcDFdHu2/EBDKfJI
         iH4L22dN1rtaXggBKFjz8bKfVS5TLL3N5NjJiO5GFulYMCO5Ct2iBdMKlNle5fQT/yU6
         SJeb0J0scc3lDPMz85QgcmmzVXfQEVOCelozUAq28HF58ZwPDeUMi5Gb3aCT2eu90sM0
         7uHi0GhEJK14z6XeO+1pztJgeB347GdkKu1k+K23A867XQqJ+bruwShTgvfkGBZzwltD
         AS7WGD+oa3PDI9aod5CdrGiZH9ZNwQ6kuKuj1hiSoDdstT2pkYL+X850BBS4xkX/uPdU
         /rjA==
X-Gm-Message-State: AOJu0Yx4l5StrnMWE/fYQxLxtSHdhRxSGGhK/jtCUXyNk6BeK9V5oFaM
	MJvICf94iz+nHWGowIQV0E9jB1kZcbfduiwMwBp8Els5iuZWjNnOOoUHc5QF0g==
X-Gm-Gg: AeBDieupG3GwYEc3Y77GZv5V+TB3tdxDADBKRM/WCzQg1FtdDUYpGvZrPK41euoNBeT
	Rvt7V7wbvi5l7O/WfGK4atArcqTI8yCONQsncjrW2OuiMdVPTksAtjIUQCryxxzZDCXSwBGUksB
	7GXxTAx7EWv2gkxl/togqMqAzy7eeavLGky1OupNLkN77k5QNqQl5I2oT9lx1KiBaXGRoqtg4Pj
	ZkNrXFLdSs9XsqDAvhGzmv8BOEXqpbxSGhJeIAwQbT2VmhcxY7/RLY0nPa6Nir7GDAkyjLC7x6W
	vRc1TONSMVhSDVcS2EHZ03wFL1WqPXT5+FKfIx0rDtr7U5J4ZBWCYZPtXO33DsbQF9zBvxktvHU
	8HEHhsfJgPzU3S4JqIEQ37ztk4AJbSxiO/IGlHa7Jnoe1seI50prgwHouoeRiJ9KeqQ3h87TDGG
	4Tw4g7N6N2+1p/1Xw8RpGR5v3N//Nn0TJGXcH+nkMDEQSEFeVa2u2j2z8tvB4WiiODiuYZhPHA3
	icaYpQTtpXfPQKO
X-Received: by 2002:a05:6a00:14c2:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f8c856e48mr9744797b3a.14.1776592321694;
        Sun, 19 Apr 2026 02:52:01 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm6847244b3a.33.2026.04.19.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 02:52:01 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:51:57 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: [BUG] selftests/sched_ext: reload_loop failed
Message-ID: <20260419174413.Gf28b@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I am testing based on commit 5425abc222bc (tj/for-7.2 branch) using virtme-ng.
The kernel config I'm using: 
- https://github.com/sched-ext/scx/blob/main/kernel.config

While running `./runner -t reload_loop`, I encountered the following error. 
I'll begin a bisect and provide more details once I have them, just wanted
to bring this up now in case it looks familiar.

Full log below [1]:
root@virtme-ng:/home/eric-wcnlab/dev/sched_ext/tools/testing/selftests/sched_ext# sudo ./runner -t reload_loop
===== START =====
TEST: reload_loop
DESCRIPTION: Stress test loading and unloading schedulers repeatedly in a tight loop
OUTPUT:
[   32.195847] sched_ext: BPF scheduler "maximal" enabled
[   32.255630] sched_ext: BPF scheduler "maximal" disabled (unregistered from user space)

[snipped]

[   39.337182] sched_ext: BPF scheduler "maximal" enabled
[   39.401119] Oops: int3: 0000 [#1] SMP NOPTI
[   39.401785] CPU: 22 UID: 0 PID: 0 Comm: swapper/22 Not tainted 7.0.0-g5425abc222bc #4 PREEMPT(lazy)
[   39.402044] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   39.402275] RIP: 0010:put_prev_task_idle+0x13/0x40
[   39.402588] Code: 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 6e 56 ff ff 66 <90> 48 89 df 5b e9 23 e3 fb ff 48 89 df ba 01 00 00 00 31 f6 e8 f4
[   39.402654] RSP: 0018:ffffb3b680153dd8 EFLAGS: 00000082
[   39.402681] RAX: 0000000000000001 RBX: ffff9c8835d3d900 RCX: 0000000000000003
[   39.402692] RDX: 0000000000000000 RSI: 00000000022e6ac6 RDI: 0000000000000041
[   39.402702] RBP: ffffb3b680153ed8 R08: 0000000000000000 R09: 0000000000000001
[   39.402711] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9c8640961b80
[   39.402721] R13: ffff9c8835d3d900 R14: 0000000000000000 R15: ffff9c8640a05280
[   39.402776] FS:  0000000000000000(0000) GS:ffff9c88aa133000(0000) knlGS:0000000000000000
[   39.402788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.402798] CR2: 00007f56a6465280 CR3: 0000000102907000 CR4: 00000000000006f0
[   39.402892] Call Trace:
[   39.403013]  <TASK>
[   39.403108]  pick_next_task_fair+0x902/0x9d0
[   39.403196]  __schedule+0x375/0x1ed0
[   39.403216]  ? ct_kernel_enter.constprop.0+0x128/0x150
[   39.403227]  ? lockdep_hardirqs_on_prepare+0xdb/0x1a0
[   39.403235]  ? tick_nohz_idle_exit+0x6c/0x160
[   39.403246]  ? tick_nohz_idle_exit+0x6c/0x160
[   39.403263]  schedule_idle+0x23/0x40
[   39.403272]  cpu_startup_entry+0x29/0x30
[   39.403281]  start_secondary+0xf8/0x100
[   39.403290]  common_startup_64+0x13e/0x148
[   39.403336]  </TASK>
[   39.403514] Modules linked in:
[   39.403917] Oops: int3: 0000 [#2] SMP NOPTI
[   39.403928] ---[ end trace 0000000000000000 ]---
[   39.404022] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Tainted: G      D             7.0.0-g5425abc222bc #4 PREEMPT(lazy)
[   39.404045] RIP: 0010:put_prev_task_idle+0x13/0x40
[   39.404057] Code: 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 6e 56 ff ff 66 <90> 48 89 df 5b e9 23 e3 fb ff 48 89 df ba 01 00 00 00 31 f6 e8 f4
[   39.404062] RSP: 0018:ffffb3b680153dd8 EFLAGS: 00000082
[   39.404067] RAX: 0000000000000001 RBX: ffff9c8835d3d900 RCX: 0000000000000003
[   39.404070] RDX: 0000000000000000 RSI: 00000000022e6ac6 RDI: 0000000000000041
[   39.404073] RBP: ffffb3b680153ed8 R08: 0000000000000000 R09: 0000000000000001
[   39.404075] Tainted: [D]=DIE
[   39.404075] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9c8640961b80
[   39.404078] R13: ffff9c8835d3d900 R14: 0000000000000000 R15: ffff9c8640a05280
[   39.404081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   39.404082] FS:  0000000000000000(0000) GS:ffff9c88aa133000(0000) knlGS:0000000000000000
[   39.404086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.404090] CR2: 00007f56a6465280 CR3: 0000000102907000 CR4: 00000000000006f0
[   39.404087] RIP: 0010:put_prev_task_idle+0x13/0x40
[   39.404104] Code: 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 6e 56 ff ff 66 <90> 48 89 df 5b e9 23 e3 fb ff 48 89 df ba 01 00 00 00 31 f6 e8 f4
[   39.404109] RSP: 0018:ffffb3b6800b3dd8 EFLAGS: 00000082
[   39.404116] RAX: 0000000000000001 RBX: ffff9c883533d900 RCX: 0000000000000003
[   39.404119] RDX: 0000000000000000 RSI: 00000000000a8e06 RDI: 0000000000000041
[   39.404122] RBP: ffffb3b6800b3ed8 R08: 0000000000000000 R09: 0000000000000001
[   39.404125] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9c86452ed280
[   39.404127] R13: ffff9c883533d900 R14: 0000000000000000 R15: ffff9c8640985280
[   39.404131] FS:  0000000000000000(0000) GS:ffff9c88a9733000(0000) knlGS:0000000000000000
[   39.404135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.404138] CR2: 000055ddb6fded10 CR3: 0000000102907000 CR4: 00000000000006f0
[   39.404141] Call Trace:
[   39.404148]  <TASK>
[   39.404159]  pick_next_task_fair+0x902/0x9d0
[   39.404222] Kernel panic - not syncing: Fatal exception in interrupt
[   40.773443] Shutting down cpus with NMI
[   40.773924] Kernel Offset: 0x7400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

[1]: https://gist.github.com/EricccTaiwan/02375248d3d0f308a85a101e5319e852

-- 
Thanks,
Cheng-Yang
