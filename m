Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794746341;
	b=poJ08+Ctr/2IovxYNRl/xid7MUqyUttjwc3QYnp3wUR94h7g6Lt98wL7t2xXE834+49c
	 Gp7hFRUEkcW/3O1FX8R4wqnyBGhA4q2GuJC5KgpMSYEX/ityAr0J8pRW9VwkcqokksjiE
	 xKoyyYqSF+wyE7PnQ5WU5SY02uAE9N4OHCjoShW+KEAsEr6mVBhFpNitbvGYi/x/0HGjt
	 o0/2Sdl7czAyMSgU06pzBGP7/xleacdbxKoemeHTja400TY7REe7TEeWd1+qqnmAHRyx7
	 Mz0HuyVTNFFUq8xJ7cLXzDVe6WR4hRLM0menZycB4BnIEydEpHdUM925IICOYHezpJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
	b=k1PF31yWD4Beepr7//ID7rYb3eUwl3B3fb+b1OYlP6aG+lyMonNe6wPqhBdzIV4bw7PI
	 31f7I92tIOVGivaDIgQiW3TgHWCwI+RzmElBDbFJ7uNz6oT9jS1a2BOb7OU4EhWYMwbIW
	 okXzVBAEo2uxFH49KMDFhzN8U99pgWqfU/w5LmxUyGpBzmHcP4wiN9LZMoHoGLzxWKTBu
	 5J91t+2ZtqLPMxxR/Zxo6KkkFZCM0gCEr4Nr2awX0caJ2aGK/XD54IBL2dHN3qVUtBsWB
	 BS2ZGTmYD+LGyQYeXLXU5nf3wXqrXG3T8iWpXMM5lOJ6Np3BvS3iqXa5EDBlKfabYVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRRce821;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A4606A8B4
	for <sched-ext@lists.linux.dev>; Sun, 15 Nov 2026 12:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7A4606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mRRce821
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b467581b98so19437095e9.0
        for <sched-ext@lists.linux.dev>; Sun, 15 Nov 2026 04:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794746340; cv=none;
        d=google.com; s=arc-20260327;
        b=JstqPNpMlFT6StVl9laVgS0LR4nGqbmDjaO/jwIXVh6xCDNqqfS02IrDsHq1O1Xem6
         cgYs0CyXJfXQpIrMBflfIxTVOsNlL7zxOzQxVfTbKYAxiwjNOAPO4ngHt+nkS2gqOmSY
         TTrnGaIhB7OxlQKlGinjb/yEFfHGnjO5VTgIE5XW3cOF56/RPOVOg0zH7C4nkZFOcODV
         ap722ZxhJm+VY3wkuDyr3sC3ltHFFUxOOWDE8h7o0iMEpUHVkXqb5ElcZtFrB52v4rNp
         O3X3l8VAxRxcxOg+B2HYwlmDoebZSfOAnWGRn2+Dr3a2Uugf+NEby8l0z8BtuZiQGoK2
         G3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        fh=OL9S+spmCa/EIFLCEtudmmlZSAWyRZa2XJzWsA/SNgc=;
        b=ifVs8sQE03FSPhnPPzuKF9FfjlfcwMq9nG0tByOdV5jBfRi0/ZRsrAGkrurs+0SR4q
         oNWZibTljFDn0H6KAPOVb+n025FfvbsIzy7wAanCuBvCZIExdJazY51BY1hshmlnH78+
         5LPY6VCGbrmQJlhv+K9MUARRHPzHiRjsaY+GBtz22SWNnlZvewrXjUow9XbUjk+U/pni
         C0BNQgiCgxlTH1GzjN93qFdz/6W5xeLNd89H18Nq5QhoEkSiONdz4Bs0fPJKUhuLO6kz
         estRWrhBkI8yhiAivDhxONSDMPccQZYDInRWwXtp46+DebSDnLS9zQQLF8brKYgc78uk
         MPhQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794746340; x=1795351140; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        b=mRRce821addQYcT6sKt1Apyxp1AYi9OagFzmGPbl6TAha9RSvhlBunmTjYYrjP5tsb
         Qg/WN768MCYQO+gzQP3n2qZXZJyd5ZytFP8FMywZeQts2LmeErih/4hjmsO05uHRAapL
         ono/F7PZYa9VZTnUNkpeInB9THV/ft146ArET92CXhfhA6rCN8OeiKM5L0BkHSdBy+9F
         DRDHbyujMos44yDhyfUOsSnbytQnwD5pmrFdOOh9pGPPx2W7zGIdr2OA7r34sAh5LW9e
         PBMh/ppjuz5oT67eJX68zogkbGzbmFwBWrochKuLbXfp7j28lteTu4G76/nh9Z3yA7rA
         0RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794746340; x=1795351140;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        b=gHU0t3t24johawBhhwLFzEL+7bZ0eZKl7U9UpqSjWo5Bs6hugXjc0uOMIaREIdEQIM
         DWhU12wGhVd9cjbr4004GTESRAmGrRd5WMioS0Bgi2+xBXN7umbCIBvkJCCCHIg3GK+O
         fgzRyxlIZMvP/EAMnq/avEF1/LqWjOR+IW7LKVTfTvMOVFtesw1o04ZNH/fmYdhQeZ3S
         tn+Csfq7Jr5LHzL3B0LG2BxihYM/5l7OTH2GE7rKiF+w5ZzQDV2fW+XPjT/Xl4KFFF8n
         Kq5HaufILyrqx1dhJrOLSjmC95mGdZKAQHelbMfCrWAM8bEhnXGXgmSHsrmqK+AIhZUO
         JWhQ==
X-Gm-Message-State: APuU4Z+YOLhuLcS56UsNbzViRgsapFhAd/y/gyPf60dPAykLTBzKmTGQ
	z8RW7ekXFZYUb+cdcsH3gcNGHZEumr24PV+aMc4NfndUx8JyQagR456RcTM97uBChy6hvNUpX49
	4GBO7XTQZEVuNyCLrPW6ksTwpCmD4A1QxNY3bXx0=
X-Gm-Gg: AYBFou0mQtF2tCnvRCtouyCk8QzRnBk75NXsahL7C9IZShP+NPTqzT5HxpHlwDDgM+V
	i5qYi+l9uRSV4LnrxkOmI6FS9ebRIbXRBYWcVYhVUSvypi/LWgFjU2WdEe4qzD6/gu59yFHxs5O
	ukbi/wv6pra44aLfur7bDPYl9jbBFpBmVgFf9GHRmHMZqkYWbzdF2+e33NM346BurgeZYorWl7j
	xWfKBvwiQUL8vHKOPB7nXSUT6F1h30nE5npA1fIc2+SZx1pPadRlB7HJUCyRUkRuHcHZF4TiO77
	Qh6M9FpVDmDyhO2EbcsO/Rm2fQ3S+EhMLhQkzCSIBUYwVbxw0T9CmQVL5254Cc6yvY7g/vqCd7z
	WMStVf4z3Qrk1Ndrkojofk7rSAhg30X+2u4bgy7VsgVTlyBGxay92EGiVlTHER9y5Gpk=
X-Received: by 2002:a05:600c:608c:b0:4bb:680f:9a3 with SMTP id
 5b1f17b1804b1-4bb680f0a64mr68135785e9.2.1794746339530; Sun, 15 Nov 2026
 04:38:59 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Sec Ops <infoosec.ops@gmail.com>
Date: Sun, 15 Nov 2026 18:08:46 +0530
X-Gm-Features: AclHuK8sSF4ErKQa1M440LXIVvLA47LPhhDqUdjyYivbtwpIdI3z5E0qGskC3lk
Message-ID: <CAOW9kW-N6ZU8RPd64rBukjfYkGwfj5QgLF-sRGfkd-nGtFYbfw@mail.gmail.com>
Subject: [RFC] Security observability of sched_ext: sub-watchdog EDR telemetry
 starvation & BPF LSM / tracepoint mitigations
To: sched-ext@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am sharing an empirical systems security study and open-source
artifact repository examining how Linux 6.12+ sched_ext
(BPF_MAP_TYPE_STRUCT_OPS) interacts with user-space security telemetry
consumers (specifically CNCF Falco and Cilium Tetragon) in
post-compromise scenarios:

Repository, Dataset & Paper: https://github.com/rootagi/scx_research

Summary of Empirical Findings & Artifacts:

1. Sub-Watchdog EDR Ring-Buffer Starvation (`scx_starve` &
`scx_forensic_delay`):
   While loading a `sched_ext` policy requires `CAP_SYS_ADMIN`, an
adversarial scheduler can selectively route user-space security
daemons (`falco`, `tetragon`) or forensic CLI utilities (`strace`,
`gdb`, `perf`, `bpftool`, `ausearch`, `lsof`) to a low-priority custom
DSQ (`DSQ_STARVE`) with microsecond-scale time slices (e.g., 50us) and
probabilistic dispatch skipping. Because the target tasks still
receive minimal CPU quanta, the 5000ms `sched_ext` runnable task
watchdog is never triggered, but the user-space ring-buffer consumers
fall behind kernel event production. Across 150 trials per sensor (30
trials across 5 intensity levels), this induces silent alert drop
rates reaching up to 100% in Falco and 97.3% in Tetragon without
detaching any kernel probes or terminating the EDR process.

2. Scheduler-Assisted Covert Channel (`experiments/covert_channel/`):
   We also evaluate a cross-privilege timing covert channel modulated
via `sched_ext` slice contention (`scx_covert_tx` / `scx_covert_rx`),
achieving up to 100 bps with 0.0% BER under quiet conditions and >20
bps under background load.

3. Immediately Deployable Defense via BPF LSM (`defenses/scx_guard_lsm.bpf.c`):
   Because standard runtime security policies rarely gate
`BPF_MAP_TYPE_STRUCT_OPS` map creations, the repository includes
`scx_monitor`, a lightweight BPF LSM daemon hooking
`lsm/bpf_map_create`. In active enforcement mode (`-e`), it validates
`BPF_MAP_TYPE_STRUCT_OPS` registrations against a trusted scheduler
allowlist and synchronously blocks unauthorized scheduler loads with
`-EPERM`.

4. Draft RFC Kernel Patches (`patches/`):
   For upstream discussion, the `patches/` directory contains two
clean RFC patches against `kernel/sched/ext.c` and
`include/trace/events/sched_ext.h`:
   - `0001-sched_ext-Enforce-minimum-dispatch-slice-floor-for-p.patch`:
Illustrates clamping execution slices in `scx_bpf_dispatch()` and
`scx_bpf_dispatch_vtime()` to at least `SCX_SLICE_DFL` (20ms) for
monitoring tasks holding `CAP_SYS_PTRACE`.
   - `0002-sched_ext-Add-scx_scheduler_load-and-scx_dsq_dispatc.patch`:
Proposes `sched_ext:scx_scheduler_load` and
`sched_ext:scx_dsq_dispatch` tracepoints so existing auditing
subsystems can observe scheduler registration (`link->id`,
`scx_ops.name`, `pid`, `uid`) and anomalous micro-slice dispatch
patterns with zero fast-path overhead when disabled.

For user-space EDR maintainers, we also document a practical userspace
hardening mitigation: elevating ring-buffer consumer threads to
`SCHED_FIFO` or `SCHED_RR`, as the real-time scheduling class executes
above `SCHED_EXT` in the kernel scheduler hierarchy.

Note on Methodology: Artificial Intelligence scaffolded the benchmark
harness and drafted the manuscript; however, all eBPF programs, LSM
defenses, RFC patches, and 300-trial Falco/Tetragon telemetry datasets
were compiled and empirically executed on a live Linux 6.12+ testbed.

Feedback and thoughts from the maintainers on the tracepoint RFC and
BPF LSM approach are very welcome.

Best regards,
rootagi
