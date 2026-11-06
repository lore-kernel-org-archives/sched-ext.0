Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958229;
	b=bT6UI+E7fl3AfbMyOdWJo7SkHMtlrzEc+reKB7MBzVVwNo8k9s2fs1qHWErHDTMxHbNM
	 7XZaXe2Jpmu64Im8cnxHS06oxwJQebGXQVDgwbVIfX0udhYlkuX4A/aoGeE1qUOCJ1J9X
	 l3Iwwx9+n9lJ1AtJn1MNwa7XmJOFjc+iM6DHzYWW8e8ZuvwCbUa+qS+0FfV/HhxeocO9o
	 1XO8EK1zj2/KviUkwzUoOCCkW4X9nVYt4INPXtJQnidfJXKnpvIozareUgBdxultemQQI
	 218uC46eY7Rgu6DJIuZZXHwwYqsrBUmSrNhed92rcAeRLg6aoa8KYJkhvc3m/Dkb0mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
	b=ZIfl8joL0YnqdGJGXVBXuiLpOPDbNbu23+QXn4jryxmKbXc6w/NFzxk2KNw9lnUP6uv3
	 4G+qTJn5A1nD+6jAhCdLU67tI8cpjpOAEyEd91qIowgeFQNXzxJcvSbwRijdW1J5A98yP
	 J05b8oZVSYgBVmxiciKw+/YweQLTp7U0Ni/eBuF5vZZtXvG7pUQEFpYY4us3PMp9Wo6Xt
	 ihQ6L0elYmCrMnkJ0v9Y78qvANQ2xjfDNFsSaHufF1x1pvKSlXZeEK15F2xcC1ktIdGCg
	 z5ekJW4sJHz/hG8jAU/xLQbjs5cS0W6g2Fj3XGbzwrpBbXH9oVMXXA+ne2+r46jBrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sRkJrnAr;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F6606A900
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C6F6606A900
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sRkJrnAr
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-491846221ffso354705f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958228; x=1794563028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
        b=sRkJrnArR76Cec65tYGUd18ia44ubrfSrmr98mcU6ubia+dqWgbOsZKh0wCFIP05it
         UzCa37ysXKwVn2/3fTS3D+KhpjVywVzOqaWmN/HEqxFYsVFmqTQbUcbnWfT4MyIrSlp0
         kFmJl/sYrJ1V2w+bCw338rNO1C2mL50Fax1UgL5SelQTqA8eLnSJ4ZrtGcoHbtL2eZvh
         EnWbmysLIjER9MnbuPMtSK4QaO13jbby6qPv8WfM4C20BHmAhoSuaztV0LgNPKSDMZOK
         LOsSc1gRQ9k2pUBY3BLmtcv98F5Bq+Ha2q/6IjmvHzcniu6PyHAHqBWP+MP7q2UDBraC
         kCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958228; x=1794563028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
        b=RPFj2cPTR059gOcngBwnn2vKREerVmtQStjUG5Bk9tErSXV18RRxCdZ9UnOvmQc1hh
         SpYbtRLV0Ll9HQUhkZsimd3jfJGez5drNcGc4O6M1XrtEav3fyZAURy50otfgufc7rOa
         oOga0Do47S+UD2VEYiD+c7Kj2/4c0R/MNFkPY0vp3hcC0DkacBSvP1ehB3uluN78zko9
         nRI23XGSD4QHQPjhU7mszORkBYbTzTQ9BP3HPK+WG3mSMmywn9tKoBsiV71Rm6lGKoz/
         l6H3GPHMLysd7CsS4uM+ppcocmlpXUti0DjbvA1QRT1/bvNQNhdUpU7qxPYqcHwhq4GN
         FrMw==
X-Forwarded-Encrypted: i=1; AL+hErHJqUBlNmhK+qoU3UqNMtbNVBdM0+Vz3nio97obEnb/6dhlSKnwlinFBbD9LFKY9u9aasQNyV172Ro=@lists.linux.dev
X-Gm-Message-State: APuU4Z+FV/5S+lkXkyuu039P6Q+UVjpSEcEz/pVyOIYxo7ZIS9y89R3R
	utcnVOSBYG5YJGnCgmwgYifCzudoseHnYyHjDaFhAsFd28JdqFDm+73k
X-Gm-Gg: AYBFou0W6Yb6Ow2eEtDaZiQtS/YoIoqoeoAWokyshsOjIknrkKgeNHPzP1CuFzkht3c
	lX7IIoYyYnigNQpofKHiAO3KTNcTI+vKJddH8LZoAHfYN90llxIp0jCh29igEzyPfO+dydy211T
	AtWGHXrpxa/k3/h8SdHilH4aX1/Qk6hU2WQNCUKapw24w/JbiiJ2vv7c76MvvTfT9Sd2vdNUPPu
	edPOROkHYavXbLFi+J26fZ+uR05idwTkb4BMxaefnb48+jJukQq9ClAzzgPzG0ntnBuQ3OlNUi2
	Ily92Lz8vDV+EMC8yiACK2qd8SMA5NCeQd7JKEz64tvbh7bZTDRnsUAUw9NeWwQAaCoi0qL525e
	uUII3pUZB/+xH9o6riK26COaqtUxJ8orwXCMqyYtLOycelcivstpe3ghjrii3gEGXy9bMYmM6JZ
	zZG2CsWpnTIzzGyUncdeN8y+IVAeimvudnoEauOJlZv74bf8/51wmaITTdrIKlPAvRlS07Rw3LR
	kiHfseRnNVM8cPdUPQ9j2+p4HXF4YEz7UBuCloGCS9CRykp2Is0F3XX6GCVVarezCgYYJ3IYVTP
	CKW8uskyQH9j89y0jXJASFIMjRqknOvHXOl0KfDPsV7iehm8PuFT7MButKp2Cc8gkEnQb04ITPP
	bmA==
X-Received: by 2002:a05:6000:455c:b0:48e:932:af0b with SMTP id ffacd0b85a97d-49276c57fa5mr2571846f8f.32.1793958227477;
        Fri, 06 Nov 2026 01:43:47 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492fc80e017sm2228205f8f.34.2026.11.06.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:43:47 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tj@kernel.org,
	tglx@kernel.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] softirq: fix idle accounting for an interrupted idle task
Date: Fri,  6 Nov 2026 09:43:41 +0000
Message-ID: <20261106094343.174905-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_irq_exit() decides whether an interrupt that just finished ended
inside the idle loop, and it asked sched_core_idle_cpu(), which is
idle_cpu(): false whenever the run queue is not empty. But a CPU can be
in the idle loop with tasks queued on it - forced idle under core
scheduling, and any task a sched_ext BPF scheduler holds back while
leaving it runnable - and every interrupt taken in that state skipped
tick_nohz_irq_exit(). The fix asks is_idle_task(current) instead, which
is the question the function means to ask.

Patch 1 adds the scheduler that holds the state open long enough to
measure, patch 2 is the one-line change.

Measurements:

One thread spinning 10 ms in every 100 ms in a cgroup, pinned to the
CPU the scheduler holds it on, 20 s windows, three repetitions per
cell, arms interleaved, on one 16-CPU KVM guest booted with
"no-kvmclock tsc=unstable" - which is what it takes to get an unstable
sched_clock in a guest, because mark_tsc_unstable() clears sched_clock
stability only when using_native_sched_clock(). Two kernels from this
tree differing only in patch 2, booted in turn.

The number is the cgroup's cpu.stat usage_usec over the thread's own
CLOCK_MONOTONIC measurement of its busy time, which is an upper bound
on the CPU it can possibly have used. 1.00 is correct accounting;
above 1.00 the kernel charged the task time it did not spend.

  hold (ms)   without patch 2   with patch 2
      7            1.32            0.964
     13            1.21            0.963
     23            2.00            0.963
     37            1.69            0.964
     53            1.33            0.964

  control, fair class, no BPF scheduler loaded:
                   1.005           1.006

Nothing in the fixed kernel's figures varies with the hold, and none of
the unfixed kernel's is within 20% of correct. The three repetitions of
each cell span at most 0.04.

The unfixed kernel also understates how long it held the task, which is
the same bug seen from the other side: the scheduler measures the hold
with scx_bpf_now(), the sched_clock that is not being resynchronized.
For the 23 ms cell it reported a 5.1 ms mean hold where the fixed
kernel reported 15.2 ms for the identical configuration. So the fixed
kernel accounts correctly across holds three times longer than the ones
the unfixed kernel gets wrong.

What is not shown, and what was not done:

No loss in /proc/stat. The sum of that CPU's fields 2 to 9 over the
window stayed within 0.6% of the window on both kernels, so in this
configuration the kcpustat_irq_exit() half of what tick_nohz_irq_exit()
does has no visible effect, unlike the forced idle case that commit
548796e2e70b ("sched/core: introduce sched_core_idle_cpu()") widened
the gate for.

The mechanism is bounded rather than measured. A kprobe on
tick_nohz_irq_exit() filtered to the idle task counted 998 calls per
20 s window on the held CPU without patch 2 against 1321 with it, n=3
each, but those ranges overlap and the two kernels run the load on
different timings.

The forced-idle half of the problem is not measured here at all. Patch
2 changes the same gate for core scheduling, where that commit first
widened it, but every number above comes from the sched_ext path.

The figures were taken with an earlier revision of patch 1, before an
automated review of the tool found six defects in it. Four of them
cannot move these numbers: the per-task hold timestamp (only one task
was ever held, so the global it replaces was never overwritten), the
ops.dequeue() bookkeeping (the load never changes affinity or priority
while parked), the release timer's pinning check (a mispinned timer
fails the run loudly, and no run failed) and the userspace CPU
validation. Two could: @target_cpu now stays in the idle loop while it
holds something instead of taking shared work, and a %SCX_ENQ_LAST
enqueue of the tagged task is now held rather than put back. Both make
the held state wider, so both move the unfixed kernel further from
1.00, not closer. The load exhausted a 20 ms slice only if a 10 ms
burst ran long, so the second one was rarely reached. The test machines
are gone and this was not re-measured.

Open question:

The Fixes: tag. The sched_ext path this was found on dates from commit
f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class"),
which is what patch 2 carries. But the gate was idle_cpu() before that,
and what put sched_core_idle_cpu() there was commit 548796e2e70b
("sched/core: introduce sched_core_idle_cpu()"). Whichever of the two
you prefer, or neither, is yours to pick.

Tooling:

Both patches were written by Claude Opus 5 (Claude Code), including the
test scheduler, the measurement harness and these changelogs. The
measurements were run and the results checked by hand. The one-line
change in patch 2 and the reasoning for it are in Documentation terms
tool-generated content; review it as such.

Radu Toader (2):
  sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle
    CPU
  softirq: Treat an interrupted idle task as idle in tick_irq_exit()

 include/linux/sched.h             |   2 -
 kernel/sched/syscalls.c           |  12 -
 kernel/softirq.c                  |  12 +-
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/README.md         |  13 +
 tools/sched_ext/scx_tickbug.bpf.c | 534 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_tickbug.c     | 177 ++++++++++
 7 files changed, 735 insertions(+), 17 deletions(-)
 create mode 100644 tools/sched_ext/scx_tickbug.bpf.c
 create mode 100644 tools/sched_ext/scx_tickbug.c


base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

