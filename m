Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2634A77C
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885206; cv=none; b=kgfwiAByr9IMnkBRNA0xWjeeqsZV6L+LvHWtJ1aIOViDmoD3OZTMjUsl/HRniPz3Y8GJxoIqPRXVOSzzLX4S8jXKRl7MDVxIIRm0VV7sk7NsDvhrmIOvIidBO9c7K48DQrp/+igMe7YsFqY1e+TNl9f/l9NtUfL/nBRHcQjSytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885206; c=relaxed/simple;
	bh=aFZv4ORD8UDW6rSsLJslO1wQfw0ZUlo5Hp5SQAX0reY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o4SqRRz72Vk8ywQxenLBqtepe7HN2bzafNL7gNLJvxkmwDAGyXAKRCBNJB4+u3D8pGf5WpLOfOmgDNEOMcauZxhA/EBi3vcEB3a3ETjkz03SrBf6xJhsLKDugCb3MgIlbF931yiR37HO3qGN6vFo1v7+Ut5qYunTov5I65ZgQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vf7c8GSV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf7c8GSV"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso3826320a12.3
        for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 03:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765885204; x=1766490004; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSyHMtjVUKh4Ma2m7ZWJjLOCRX0u/xsERO0Xrl/HMD0=;
        b=vf7c8GSVuul0ZENbhWWRmH8yvj257XtRlBimLBZk+HRq0kAAD8M5Ibsp9Hj/RJHVmc
         ijaPMEtLDAtJuKLgoLXY516S668JuDCS8udjHmhdEyfWDvGZOV1WRT47vA2VVoejRwel
         9sAvwcZJ24fpw3Pghkwt3TDL4HO8ZY/Ee0AUpLZTqT/Qp4Z+i/hzm3qyzYPOZkkXoM9O
         Huqw1qtAHM4pVPkA168zY+ZSfE6Xan90JEZEJe91Yki0VF7NvTrd3ktXaZdcp1Tu+l+0
         vv8kHLqpC6Wrpj6USGsxCHnbo2rF5JJiCxyXme5GOog3YilFFYrpgFJClBpG+8W1qKQj
         G4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885204; x=1766490004;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSyHMtjVUKh4Ma2m7ZWJjLOCRX0u/xsERO0Xrl/HMD0=;
        b=bZstN7dLVBTGWavKBOZvaGX+wVweXF+aHcm4BJTqJ6pFGPhRWeov+HLY02C9b2sEEY
         BFlG9iJO/apRQEnFOjrCf3eEqnu7c/MwYBUGPFXNc7g96/4+mzik58dCxvokF9FX/N+e
         Xj6EHah5FxJiry2KB2NkjvxAeXUf8VZtYHvBigV1WU4PIZFWn348IVwrLhe+15q2rs5X
         HwL/CY5PAaJkUmI6iKYAYsliQSP/r6SaPBOg2bmj6oyq/472RlazP1q3JXiSQlZxlYyX
         RzyXmCHJJS7YfmdP7kL7w91IO7Hco23ZYW/SKF8UH5tviK3X3mx4T/BspdqrYks9GJzR
         L6VQ==
X-Gm-Message-State: AOJu0YwH/aJFpGedPpLHs4l5+tldNvpEXEmSQL14skiMpWI4sPcCk37E
	o9Q9Kee5yTZMz61nxTNYpB778ZE7NBdTiiTLM6cfdk9rTBheZCU8vVWiIPhS3kzzNh7j294NTW0
	Q6y4rc8Q1xb98Mf4WoSSs0mnCX7CwGr1BlKh+LrjJFYhmDaMEC4Jmcyg=
X-Gm-Gg: AY/fxX7FI402NiJ/dvdE9FDAkmwUx6s9daOFClRBOuiYzmA5lsikcbbRzsYhhA5iTd7
	VQBXq6lqVt9YINwXV+fDb9igeVPTPJUDlqmTE/1dKolph0LJlEQ+ZNfSn2Dc1ZZMJvb9AlJ8n3i
	10uFSBm1g+pWuCLETxnYV12XHEX5lVShtMtnldEAY1gbbDTi40v2sSFFhkmmy5d0UZJhtT6xvzz
	rvjvbzp2drEP4jagtApwwhAb1/aDW0f1RLhh3q1S1sOhsB5es0rUjaLkBt57Ye4GOzXJa2Z4UNE
	3MSQej61HvZqzr75gK4DLfEtrP77dLgzhouqqQ==
X-Google-Smtp-Source: AGHT+IGZ/11CKLjxb/HoP8YLpfYCy3CVKtnkBqwTfc8yz1K4ZaEdwyUiw5cdAC4g87FK61UnBH5V0VMj+SciV+J/DzE=
X-Received: by 2002:a05:7301:b17:b0:2ac:155c:6381 with SMTP id
 5a478bee46e88-2ac2f8dfd71mr7621850eec.17.1765885203847; Tue, 16 Dec 2025
 03:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Dec 2025 17:09:52 +0530
X-Gm-Features: AQt7F2rE3XpjLvcO0LNDq-dZED_zuVLX45OWNhsf70eCD5XclDbdORkxnNqSHQM
Message-ID: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>
Subject: Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end
To: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com
Content-Type: text/plain; charset="UTF-8"

The following boot warning is noticed on qemu-arm64 devices booting
Linux next-20251215 on wards.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20251215
Bad:  next-20251215 and next-20251216
Good: next-20251212

Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

$ git blame  -L 10842  kernel/sched/core.c
5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10842)  ---->
      if (ctx->running && sched_class_above(p->sched_class,
ctx->class)) {
5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10843)
         rq->next_class->wakeup_preempt(rq, p, 0);
5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10844)
         rq->next_class = p->sched_class;
5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10845)          }
5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10846)
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10847)          /*
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10848)
  * If this was a degradation in class someone should have set
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10849)
  * need_resched by now.
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10850)           */
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10851)  ---->
      WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10852)
              !test_tsk_need_resched(p));
6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10853)  } else {
6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10854)
 p->sched_class->prio_changed(rq, p, ctx->prio);
6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10855)  }
f0e1a0643a59b (Tejun Heo      2024-06-18 10:09:17 -1000 10856) }


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
