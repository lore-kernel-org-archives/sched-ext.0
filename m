Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909022;
	b=0IGDMGv+xTpvtAGpPJmkxe21BvmtmgsurPfGemKGGJhH/iRl8YABHV/9ZtU7PUKOhBcC
	 wRELewl0z4dxpBGv45vJzOVPudbR0+knWLWjlGVsEa3wnzpb5rm4pJ1J0LZOT7kQsbnZ8
	 WiExiF+WmGrgcawZj7G5BIIt9zJfoFB0ylzl4N/ZBTbqHLIjvTkNEvO9Yj4ovsXMBoNm5
	 1xvRCdXH2If7I5lYgDq+iGT+89zJEVhg3O2SRl937Sn38rFyBI7tcZ8EKbWUX+FWRDVa0
	 d+dwC/piXdnRuSpUEq3VIwaFTXrMpFFWV5YcV6gmr77SS6SztTYHZ4TQEFmmVBK3Dgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eUndeKM1lXiQmSrjKdK8oJ85MDpRLlG3+Df5sxKGbO8=;
	b=O9QIpJT/AH8IDoasXqOkBNeRU9HGWGe6p+/8NhXohswAwAFHSYJUC5MP4iqIW8TuGnMc
	 Ir2356olHEK63j1xuzPcNrdLJ/Xns9hdO56F4eZg/DfK7MozszPyOrXiE0ChifDM6947L
	 2UeOhl6aznFMJqQIYZoSlpGgH87H82+xtqcHtthpOtD+o+Zn4mcautvIvKa0HNq4C6Oxi
	 dLUVgBCP4fq/7jZUdoq4bMrYr+f34Z2eyy5cAwFTiTitQgajz4+u/3tbFdARdB5iKy+VP
	 Dfuuf6STHnJKQkhkTFR6kKWPObxyunmivHEhmmHH30YSubggFxyGOuVs0A5s6AgRpwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkSK+UpY;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156B606A326
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 20:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6156B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkSK+UpY
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so17694265e9.0
        for <sched-ext@lists.linux.dev>; Thu, 05 Nov 2026 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909020; x=1794513820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUndeKM1lXiQmSrjKdK8oJ85MDpRLlG3+Df5sxKGbO8=;
        b=IkSK+UpYkCtDaJEC+pETFCSIKFO7Yp+K02OFGeL6lMqeX5jS4GayupkZNT/Ocv2jIy
         ica+nBTYDgTaPs7vTa8PxkPeECbWW89AdFWZnGAe6MiJv9HC2cBnoCW0k4sLxP7BRkZm
         gwXQ79QimXOn3SWgyaufS8SaQkMNclAXA4jq5+994uKgUvf+uO4BKov8+26ZAB4Rgil/
         8HME8+t9LWSvrEyvho/kuk/9WK9xaav4Psm8QSkWXAh1Mr5f6wr+YiInH0VSsB9UbONs
         AtLweJ91cwhx9L4PAHZJkA9IcwMNvO3yPEUPPluKoOkn4jVf/JCBsC1xunztqP8W44v0
         hK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909020; x=1794513820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUndeKM1lXiQmSrjKdK8oJ85MDpRLlG3+Df5sxKGbO8=;
        b=B8lrT8F7cB6lewG/OxHYF1Qv5dhNTLypOIH6CgfJ+0q6pPMRIOeh4q18YHkhN/hmes
         cpfTyN1DI4vQsLD9u0RH1lDDLsJoAEUodJ9AHoXYk/cjQAleWzqNpUdpDzrXkAj/4o0z
         drudvcX7wGBrTqwop86kqOb42YztPB3RrHDBuwbJ6rS5GLcU+PVqiMKY7FKgCOVyqVdl
         9c94YKqIPSXhrwHirmNtinvKwZY8I0HrbqRK8Rgq9g2rYASE9Tol/pBgkuEFmTSSpqdG
         bVkksuaan4tjt2h3ztRu87p1U0dDPJrQCXgAeqeqW5tuMu1ks2aHdXXg8aayVI13+QO7
         Xubg==
X-Forwarded-Encrypted: i=1; AKwUvBxizQcCCI8Lz7Cn3MbRheXXR+RnND4B5g23PN6Nl72mqUSWP+5TdFxt9T1cpOiERi3tREyiDuDCfTY=@lists.linux.dev
X-Gm-Message-State: APuU4Z9H8TexGtmUK3gFKAl/YuwZahNzsczLdxxfMFti0Y2/BPPpd5wN
	eHq3CGBXPWrO+3JSBvPRT6+c7D0eCDGUGV8YGuH3KcX28SjJGKyVPf3AOlKqmTNGtfE=
X-Gm-Gg: AYBFou37HzAonyHmh7tTBBJVkU/RJ+oNx4oHY7fhl/rRqCCg4dtCFsEN88Zcex3RLlG
	gkHpBESfFHO+hvxsEzVokm5qm9SuNqJJBHFnDAsyi7dhPPSi4N10l5Q77LiPojoKnIxqkli0MAg
	YaETUr8EJej+DqLMuwQ2VjNldQ/S6nNXUqOBNCilgPe1WBT6KDRd3omo1u2ebLSesWoBH+4psCn
	Lxfjq62nWYPPYjw3GviJlcfiyN3viSCXbSU1LSQk7m5+dNiCOomKqgQaaxafqW46t2k6x9OqnfO
	MMwZf8O+bkw3tNoFu6PU5oMf2auf/v8/5Q2wR928wAtdotbLS/E0uTpyI9oIJp5qO02dbmq0m5b
	GXj7f/bfptmQkqnQ0afVyeLPln8Lp29y1DbwGltn8HKD2Ez8dXTENtAUHBESV2gB1wUwccUkJuO
	2gl/PjWzvjCvunGtzQgK6GUbeyrox/vkjuGzMv8t45FOpc87mrQSTCa4FM/IFhXXMXJzWn7vP2t
	jHWUblsll6Pf24Evj8wjyAhay70w5Mctqz1H106n7FkxNnskQuE7Jui4WcYUzXl6PGMzPEc74zX
	ezLT6auimRR1sH7REHmCB6Zd6aCvKsfpmpnTeqYdtg1itHnpc/ozqiCTO2b+6R0BQ9Q2M5a81Sl
	71w==
X-Received: by 2002:a05:600c:6385:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4b6e0549157mr3090895e9.34.1793909019547;
        Thu, 05 Nov 2026 12:03:39 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm88965055e9.13.2026.11.05.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:03:39 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	tglx@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Radu Toader <radu.m.toader@gmail.com>
Subject: [PATCH 0/2] softirq: fix idle accounting for an interrupted idle task
Date: Thu,  5 Nov 2026 20:02:03 +0000
Message-ID: <20261105200205.1178097-1-radu.m.toader@gmail.com>
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

tick_irq_exit() skips tick_nohz_irq_exit() whenever the CPU's run queue
has tasks on it, even though the CPU is sitting in the idle loop. Under
sched_ext that is an ordinary steady state - a BPF scheduler holding a
runnable task back, e.g. a cgroup at its CPU limit - and with an
unstable sched_clock the CPU's clock is then never resynchronized on
the way out of idle, so the idle stretch is charged to the next task as
runtime.

Patch 1 adds scx_tickbug, an example scheduler that holds one tagged
task runnable on an idling CPU for a configurable stretch. It exists
because the in-tree example schedulers do reach that state but leave it
within microseconds, so nothing accumulates and the bug is invisible.
Patch 2 is the fix, one line of behaviour: ask is_idle_task(current)
instead of sched_core_idle_cpu().

The patches are independent in the files they touch, but patch 1 comes
first because without it nothing in this tree can produce the state
patch 2 is about.

Measurements
------------

Two kernels built from this tree, differing only in patch 2, booted in
turn on one 16-CPU x86_64 KVM guest with "no-kvmclock tsc=unstable".
Both are needed: tsc=unstable alone only marks the clocksource,
because mark_tsc_unstable() clears sched_clock stability only when
using_native_sched_clock(), which is false under kvm-clock.

Load: one thread spinning 10 ms in every 100 ms in a cgroup, pinned to
the CPU the scheduler holds it on. 20 s windows, three repetitions per
cell, arms interleaved. The figure is the cgroup's cpu.stat usage_usec
over the thread's own CLOCK_MONOTONIC measurement of its busy time,
which is an upper bound on the CPU it can have used, so correct is
<= 1.00:

  hold (ms)   without patch 2   with patch 2
      7            1.32            0.964
     13            1.21            0.963
     23            2.00            0.963
     37            1.69            0.964
     53            1.33            0.964

  control, fair class, no BPF scheduler loaded:
                   1.005           1.006

Nothing in the fixed kernel's figures varies with the hold, and none of
the unfixed kernel's is within 20% of correct. At the 23 ms hold the
matched pair is 0.087 CPU of real work charged as 0.173 unfixed against
0.084 fixed, with 173 and 172 releases respectively - the same work,
accounted twice over.

The unfixed kernel also understates how long it held the task, which is
the same bug from the other side: the scheduler measures the hold with
scx_bpf_now(), the sched_clock that is not being resynchronized. For a
23 ms configured hold it reported a 5.2 ms mean hold where the fixed
kernel reported 15.2 ms for the identical configuration. So the fixed
kernel accounts correctly across holds three times longer than the ones
the unfixed kernel gets wrong.

An earlier measurement, with an out-of-tree sched_ext scheduler that
caps how many threads of a cgroup run at once: one thread spinning in a
cgroup limited to 0.1 CPU in an 8-vCPU guest was charged 0.27 CPUs, and
four such threads 1.12 CPUs, while a sched_switch trace and the work
completed both showed 0.100. With nohz=off, idle=poll or a stable
sched_clock the three agree. That scheduler is not part of this series,
so that one cannot be reproduced from this tree; patch 1 is what makes
everything above reproducible.

What is not shown, and what was not done
----------------------------------------

No loss in /proc/stat. The sum of that CPU's fields 2 to 9 over the
window stayed within 0.6% of the window on both kernels, so in this
configuration the kcpustat_irq_exit() half of what tick_nohz_irq_exit()
does has no visible effect, unlike the forced idle case in 548796e2e70b.
A kprobe on tick_nohz_irq_exit() filtered to the idle task counted 998
calls per 20 s window on the held CPU without patch 2 against 1321 with
it, n=3 each, but those ranges overlap and the two kernels run the load
on different timings, so that bounds the mechanism rather than
measuring it.

The ttwu_pending widening described in patch 2 was reached by reading
the code, not measured on its own. The control arm above bounds any
effect on an ordinary workload (1.005 against 1.006) without isolating
that path.

There is no automated test, and I do not see how to write a useful one.
The wrong number only appears with an unstable sched_clock, which takes
a command line, so a selftest on a machine with a stable TSC would pass
on an unfixed kernel and prove nothing. scx_tickbug reproduces the
state and reports counters, but it asserts nothing and is not a
selftest.

All of the figures come from one 16-CPU x86_64 KVM guest on one host.
No other architecture, topology or guest clocksource was tried.

Open question
-------------

The Fixes: tag on patch 2 names f0e1a0643a59, the commit that made "the
idle task runs while nr_running > 0" reachable without
CONFIG_SCHED_CORE. 548796e2e70b is arguable instead, as the commit that
fixed this same gate for core scheduling with a predicate narrower than
the problem; and the ttwu_pending case predates both. Happy to retag.

Tooling
-------

The bug was found, and both patches, both changelogs and this cover
letter were written, by Claude Opus 5 (Claude Code), in a session
measuring cgroup CPU limit enforcement under sched_ext. The prompts
were about why a cgroup's measured CPU usage disagreed with a
sched_switch trace by a factor of 2.7; the model localized that to this
gate, wrote the fix and the reproducer, ran the measurements and wrote
the text. The content is tool-generated throughout, per
Documentation/process/generated-content.rst. I have reviewed it, I am
signing off on it under the DCO, and I can answer for it in review.

Radu Toader (2):
  sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle
    CPU
  softirq: Treat an interrupted idle task as idle in tick_irq_exit()

 include/linux/sched.h             |   2 -
 kernel/sched/syscalls.c           |  12 -
 kernel/softirq.c                  |  12 +-
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/README.md         |  13 ++
 tools/sched_ext/scx_tickbug.bpf.c | 364 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_tickbug.c     | 166 ++++++++++++++
 7 files changed, 554 insertions(+), 17 deletions(-)
 create mode 100644 tools/sched_ext/scx_tickbug.bpf.c
 create mode 100644 tools/sched_ext/scx_tickbug.c


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.43.0

