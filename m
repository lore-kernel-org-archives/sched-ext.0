Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E81389F46
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888886; cv=none; b=KlRaRSaeoU8qx/f0oIgsr/MSjvlIbKfAZF7VZ/HyP2GM/acsZqlvSng4huy4h6BMFdQ9dcQVSNUTIqJHqKagTlYY+vJ8y3RdPsz+0++xoCaYqv9uNviwZS39VQejNMVw8gQaVggHPIA9bU2oxuC/h/XMSqj6GJefYmex5vdqFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888886; c=relaxed/simple;
	bh=mNAfK2P7/xMRs1leXA0nxrVuc08WKBFquhUlrzjxV3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q6VNdh1xBY/I0wxd0YvjL64nvJnOBsRfJMu6O3vPO6FZHTRHiDG6I8Fseq/U1aCTa4uxeO41y24BribX1xqQed4TDmy6BmIXOF+K0gVjYVEFe9jJfU5EEzuc1+osiGOlgCio+bv/WBdN8zgYpMub/kMBgqftRmOpJKuBWFmAsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfEAfyTc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfEAfyTc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bf5c7eb21eeso4714664a12.3
        for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 04:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765888884; x=1766493684; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tqd9Mn2sViDs+yA3hWXZAb16PsprztksN/BIHQvEcoM=;
        b=zfEAfyTcC9IvNZbNrWaBp0VuNKKSZ8hGF1dniCz1Ov320vHvzS/SmDRa9szgvEPDAj
         uaiPLplbf/VM/iXbeublLgB3dBWroOVrc2O9eHYOP9YNUkpc+0aTkhKXnbdN7wSNBTMb
         kbrKzkPNkx1OD6yqtcON+plcDlj815SNv7JyQIC08/eJFOZCCfI0QViwqaoWPfK2b+FD
         +5VSSVANXVau0ZHEkQZsdVXCpP0Usx+KAXSwtA2NP5CZ1pOUtTDkIklfB5qjRgm5WVPc
         T80XSxOuEidUXB512RgxrhvVNbnd45wX09YxvgHEv5J9WCKiJttNmsdbQrfLod+BO7l/
         ox3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888884; x=1766493684;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqd9Mn2sViDs+yA3hWXZAb16PsprztksN/BIHQvEcoM=;
        b=A2yNqM6gTLlCj1ydpMmDNG2zDSQ6VgmzlYoBhJq/ZUDMxBs/GyhKmOEBIPd/FwG3be
         tpvX5hD0z3XLvz5vjZSWNiwlWMHBXxky5hkT0kM1VIxZ4qcjb5zP46lD6nbTd0c6gcyv
         sgroJWsyJtt84ETB30XGqFYjrAemqj6g2SaypIE+VNGnJoH/MjkiS1LMNG1FZURM00qL
         09Iq2Bb/bcNIWQm8xNFPY+Y0O7ruqHdIxULud3WU12h+q8YQE+40o+bCt1cBtPZtb+Mt
         WIah0Q0Wx2MQXJVOo85OnxAKoaDKAjy4RoXnGKwFMl+2kNwO9wDXmeVs4jhXc+VfSh4g
         fRBA==
X-Gm-Message-State: AOJu0Yxh0v0TyLCpuwTVwLsxf19xymLFGe2CvCjOhYoeOnhCapQZLxHZ
	EK1NWGX4PIq5j3MfvhszEfkkHbwl96EMGgIABXg5tcVZn6p6921hgfK5W3UpZwJErlo8T1ZJODX
	hsKJ+QAcM/vbk+4+Ef6YwlB7qmLJe/b8TCWgEHXzPSJ3EwR4XgP8O3wM=
X-Gm-Gg: AY/fxX5hmPHtfAzVj+tTEbhrVaM3VF7qNgc+2pSTUkUUhOsS954B3d4+4B6jjKtxNOa
	wJFbmxDtegI0WpSUwvbCp9xoPOazx8E4RRmXMxY39TELFcEFYZcaSXk0Y5+jKxCXjr07sMYoOti
	StQRnNxZjudZ0aE7SVCSCNc1fWPgDnli/VnvIvnhGelT3ylc0QzB7Jvxx4IHMzkoRR9Jc3hnEZq
	1qiUmjqVkuxt7gTSn/uZSMjw+B56W+2mMGBXw84Vz0/LSfMmRtSk480ZKVkIjsM0tola71Ytzjc
	VmWpM5mh9q3Q4Tglabgbf9OSIb16
X-Google-Smtp-Source: AGHT+IHf+sCGgk7nPxOZJL2Pq9ZwqwyDOBzjxgc7KdbVgPmGZD0Ouh4ael61pMPx5PGGuLUb4Eq+iaiEG96mQBLRkkE=
X-Received: by 2002:a05:693c:60c8:b0:2ab:bc9a:4d55 with SMTP id
 5a478bee46e88-2ac301a5198mr10395919eec.17.1765888883648; Tue, 16 Dec 2025
 04:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Dec 2025 18:11:11 +0530
X-Gm-Features: AQt7F2rjULB4g4ipAShU-6OO8MDdMqMgbHM2O2UGEbjohsb8g2WX1FcJCiP4iRw
Message-ID: <CA+G9fYuUYboYg9Kq24NL+LY3XqCELWkwbGZ8bh9EjQdoj2k7yg@mail.gmail.com>
Subject: Boot regression: next-20251215: arm64: WARNING: kernel/sched/core.c:10851
 at sched_change_end
To: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

[Re-sending with unwrapping]

The following boot warning is noticed on qemu-arm64 booting the
Linux next-20251215 and next-20251216.

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

First seen on next-20251215
Bad:  next-20251215 and next-20251216
Good: next-20251212

Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end

Are these expected warnings ? Anyone noticed ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Full boot log links provided at the bottom of the email.

## Boot log
[    0.000000] Linux version 6.19.0-rc1-next-20251215
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-16) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT @1765798467
...
[   14.659447] mlx5_core 0000:01:00.1 enp1s0f1np1: renamed from eth1
[   14.691267] CPPC Cpufreq:FIE not enabled on systems with registers in PCC
** replaying previous printk message **
[   14.691267] CPPC Cpufreq:FIE not enabled on systems with registers in PCC
[   14.694920] mlx5_core 0000:01:00.0 enp1s0f0np0: renamed from eth0 (while UP)
[   14.696414] ------------[ cut here ]------------
[   14.696418] WARNING: kernel/sched/core.c:10851 at
sched_change_end+0x168/0x188, CPU#12: ktimers/12/117
[   14.729321] Modules linked in: cppc_cpufreq(+) arm_dsu_pmu(+) fuse
drm backlight
[   14.736718] CPU: 12 UID: 0 PID: 117 Comm: ktimers/12 Not tainted
6.19.0-rc1-next-20251216 #1 PREEMPT_RT
[   14.746190] Hardware name: WIWYNN Mt.Jade Server System
B81.030Z1.0010/Mt.Jade Motherboard, BIOS 2.10.20250506-1P (SCP:
2.10.20250506) 2025/05/06
[   14.759217] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   14.766169] pc : sched_change_end (kernel/sched/core.c:10851
(discriminator 7))
[   14.770519] lr : sched_change_end (kernel/sched/core.c:10842
(discriminator 1))
[   14.774781] sp : ffff800080d33b90
[   14.778084] x29: ffff800080d33b90 x28: ffff07ff822f5500 x27: ffff80008e0c3660
[   14.785213] x26: 00000000000000f0 x25: ffff07ff822f5500 x24: 0000000000000000
[   14.792342] x23: 00000000ffffffff x22: ffffb4099c0d64d0 x21: ffff07ff822f5500
[   14.799469] x20: ffff083e5eeaf140 x19: ffff083e5ee9b290 x18: 0000000000000000
[   14.806597] x17: 0000000000000000 x16: ffffb4099a40ee68 x15: 0000000000000000
[   14.813725] x14: 0000000000000000 x13: 0000000000000000 x12: 0000020000000000
[   14.820853] x11: 00000000000000c0 x10: 0000000000000c60 x9 : ffffb40999b8d640
[   14.827981] x8 : 000000000000000c x7 : ffff07ff92ad8400 x6 : 00000000ffffffff
[   14.835109] x5 : 00000000000000ee x4 : 000000036b338800 x3 : 000000036b33b800
[   14.842238] x2 : 0000000000000001 x1 : ffffb4099c0d63d8 x0 : 0000000000000010
[   14.849366] Call trace:
[   14.851802]  sched_change_end (kernel/sched/core.c:10851
(discriminator 7)) (P)
[   14.856153]  rt_mutex_setprio (kernel/sched/sched.h:1813
kernel/sched/core.c:7368)
[   14.860157]  rt_mutex_slowunlock (kernel/locking/rtmutex.c:1341
kernel/locking/rtmutex.c:1466)
[   14.864422]  rt_spin_unlock (kernel/locking/spinlock_rt.c:86)
[   14.868165]  __hrtimer_run_queues (include/linux/spinlock_rt.h:44
kernel/time/hrtimer.c:1398 kernel/time/hrtimer.c:1843)
[   14.872513]  hrtimer_run_softirq (kernel/time/hrtimer.c:579
kernel/time/hrtimer.c:1193 kernel/time/hrtimer.c:1861)
[   14.876600]  handle_softirqs.isra.0
(arch/arm64/include/asm/jump_label.h:36 include/trace/events/irq.h:142
kernel/softirq.c:627)
[   14.881125]  run_ktimerd (kernel/softirq.c:325 kernel/softirq.c:1144)
[   14.884520]  smpboot_thread_fn (kernel/smpboot.c:160)
[   14.888608]  kthread (kernel/kthread.c:463)
[   14.891828]  ret_from_fork (arch/arm64/kernel/entry.S:861)
[   14.895396] ---[ end trace 0000000000000000 ]---

## Source
* Kernel version: 6.19.0-rc1
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 4a5663c04bb679631985a15efab774da58c37815
* Git Describe: next-20251215
* Test Details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215

## Boot details
* Boot log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215/testrun/30561916/suite/log-parser-test/test/exception-warning-kernelschedcore-at-sched_change_end/log
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215/testrun/30561916/suite/log-parser-test/test/exception-warning-kernelschedcore-at-sched_change_end/details/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/36sbHUVfnUKPzZ4LNkOCLdiFOin
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/36sbH5DQckAagO0V1UEWBBkOB54/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/36sbH5DQckAagO0V1UEWBBkOB54/config

--
Linaro LKFT
https://lkft.linaro.org
