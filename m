Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45A1B4224
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866098; cv=none; b=g2WyTYqO1sVoaAJrFMLeHcXFqrorFCLYnDXfcFxoqy42jB83+v3B2qmC7KJxhqcHRp4eVjBWzemnfBkwkSV/Z4uxzTIJC63eyamOmNdttNVBA5yi0AVFM6nXI7SbbSDq6dD5lRmmjZUaanIwSL6whfi2bsfHUbxWpVkr1nmL6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866098; c=relaxed/simple;
	bh=wopLSiYWZUYJQGU7S3xN8kB06OjSk1qmClHaDPILScU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayubBQQxJiBd/s22qhwV+1Tj3qZZlaKNv9oNPim+MuCz7kgL/Q1SHzEPDlSAyXhW1LQ3LuSghwMPAljqXw9ldJI+BTp0frtBp6SOvgygzDaEbwbTx2NpFZkO0n6l+vJiSYnxJbXJld3smnOuDyS6F9rYOrUB18xdHFMRKwKbBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEa/+zcR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEa/+zcR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso64200b3a.2
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866096; x=1779470896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEaZOPq5HHimmzdxWliVnbIt5bH7OFDlR29q4MX45bY=;
        b=KEa/+zcRtLUFS6dq7UKDXYT3FqPupkeIAhd5GMOq5znYU7e3Qs/OeDB70OL5cuj17F
         fM2hJXOtAMwVJalAi8CPsibwJePKUPJr6dvhIVuZWm9FNKldEZxh8NpLSAbNySTOJhjF
         ZlbiuXw+ScPGWvWUFP2k6ZnyysWwyig3bJaW7Nh0nM9DGCocJ64y/S7Z1Cp4BoOrOgqs
         afbIYb79GqtlWwD/NSu9wU2Z0eYBLP/JTfEpQLBOJuTZULIjjvWjd6EIqJA3Edc1IDgC
         6VgOnc2O/EMjor3DuKeNfm+t4byNddvqcDquC0rDjFtwbfUa1H6t7zgLGw9tNt8FCr9t
         p3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866096; x=1779470896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEaZOPq5HHimmzdxWliVnbIt5bH7OFDlR29q4MX45bY=;
        b=IVAE6OZ89J1NlUUBGZ8CYKzYCgWKsNgKG3RtlIub2fD1j4k2LeWsi00B6i9MiyZUR8
         pUzIMoNu+nBFQ8klt+GZaCOHnCAeFW2gxGbF7yYJ0SyzuyQ22IRSzv2iqTFDitUFAkD2
         m9lcBW/irUoOqiJZ+esLdAgCxLwCbdfFcUdfB89iTKjBC9nBhy1CnpnESzIywRgonzP6
         eYhYsSLO9f1fR415xnUhF+BKHqyPiIB8dsj4rFlLfUMy14sU/dH5KQDHo9xyCV7zPeau
         01dD7pj04mxwkD9wqgV5Tj8819+PFToLwppYxA74+7OP1I9ixNLxSPT6c31OpEcFZNhF
         pU6g==
X-Gm-Message-State: AOJu0YyfIESDK2cWrQh42OLjHGimP9Z5PEC0Rrq+E5335K2c0TdGuObt
	tueAWzzVs7YeU6CCBlTt+vPJj/7ErfgZtR0wiZFIl2Fd1xW9/yKKIM03Yc+Atw==
X-Gm-Gg: Acq92OHIDkWL2YkkKdu+QFL+LQSXE7eb+i1rLFo2Jm1VZxlVkGs3oul5nOy2K0jV54O
	eNjkRCxI0PHazwPEjv1MsPe5G18ZWrMp6MfTur/xheL1aXyMh5WbCtUFovEUKjE2FwBI2FslTvu
	2FFEOQu46c5SbGuWz/37GtTSHqLygvsHlNsBd3PSPWyuMTjaE2dYCJ0V+8q8VjfQTUNokH6RkHM
	F5ELx69wlAi/2xc3tEq1AZu0Xfa6SllUgRp2GWv0Zr85PaRSJicd4SajCbf2eDZKVCyfx90HuDx
	bMm2e2b2eFUlnmL5Sxv6P2Uy7xhpJjW3YdC/bCABLmv9F57ygT5cbUAFnRKHwB+2ghXdMLXsF9F
	cbsYQodHWpm784j+RoRsMZ0XiTaiaU6b7f53eijLj0c8hSTdZg9iYA3msWpS5l8gO1sklzxfwsI
	4c8XgVWtHV8qz7CDsLCayQYTQdRm+eC6cAJbz9XycPVSCUgBjH2+r6
X-Received: by 2002:a05:6a00:8d1:b0:81f:3f03:6846 with SMTP id d2e1a72fcca58-83f33f2b93amr5502240b3a.47.1778866095575;
        Fri, 15 May 2026 10:28:15 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:9584:f97f:cff9:ff7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b71fsm5973035b3a.29.2026.05.15.10.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:28:15 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v4 sched_ext/for-7.2 0/3] sched_ext: Add dispatch transaction API
Date: Sat, 16 May 2026 01:27:38 +0800
Message-ID: <20260515172807.254804-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_insert() captures the task's sequence number at insert time,
so any pre-dispatch validity checks a BPF scheduler performs before the
insert fall outside the race detection window.

Patch 1: Rename the internal scx_dsq_insert_commit() to
scx_dsq_insert_stage() to better reflect its role as a staging step
before the actual DSQ insertion. No functional change.

Patch 2: Introduce a dispatch transaction API with two new kfuncs.
- scx_bpf_dsq_insert_begin() captures the sequence number before any
  pre-dispatch checks, opening the transaction.
- scx_bpf_dsq_insert_commit() inserts the task using the early-captured
  token, extending the race detection window. If the token has gone stale
  (task was dequeued or claimed by another CPU), finish_dispatch()
  silently discards the entry. Both kfuncs are restricted to local DSQs,
  and commit() is callable only from ops.dispatch(). This is intended for
  schedulers that do not implement properly synchronized dequeue.

Patch 3: Add a selftest exercising the dispatch transaction API. The BPF
scheduler captures the token in ops.dispatch() and flips CPU affinity on
child tasks to trigger dequeue and re-enqueue, verifying that both
successful and stale-token dispatch paths are exercised.

Test plan:
- Applied this series and ran selftests with vng, all tests pass.
- Confirmed selftest skips on older kernel.

This series is discussed in [1].
[1]: https://lore.kernel.org/r/20260319083518.94673-1-arighi@nvidia.com/

Changes in v4:
- Separate the internal rename into its own commit with no functional
  change; use scx_dsq_insert_stage() instead of scx_dsq_insert_buf()
  (Tejun Heo)
- Restrict scx_bpf_dsq_insert_commit() to ops.dispatch() only by moving
  it from scx_kfunc_ids_enqueue_dispatch to scx_kfunc_ids_dispatch
  (Tejun Heo)
- Restrict scx_bpf_dsq_insert_commit() to local DSQs at runtime:
  targeting a non-local DSQ aborts the scheduler (Tejun Heo)
- Expand kdoc for both kfuncs with the full problem statement and
  use-case context (Tejun Heo)
- Add scx_bpf_dsq_insert_commit_args struct to stay within the BPF
  verifier's five-argument limit imposed by KF_IMPLICIT_ARGS (Andrea Righi)
- Selftest: pass slice=0 in commit_args to preserve the task's existing
  slice rather than zeroing it (Andrea Righi)
- Selftest: use the first online CPU from sched_getaffinity() instead of
  hardcoded CPU 0 (Andrea Righi)
- Selftest: clarify that nr_tx_stale counts attempted stale commits, not
  rejections detected by finish_dispatch() (Andrea Righi)
- Selftest: skip dispatch transaction path for CPU-pinned tasks (e.g.
  per-CPU kworkers) that cannot be inserted into the current CPU's local
  DSQ; fall back to the global DSQ instead
- Add comment to mark_direct_dispatch() explaining why qseq validation
  is not needed on the direct dispatch path (Andrea Righi)
- Remove duplicate scx_bpf_dsq_insert_begin BTF entry from
  scx_kfunc_ids_enqueue_dispatch (sashiko-bot)
- Use u64 consistently for qseq in the dispatch buffer path
  (scx_dsp_buf_ent, scx_dsq_insert_stage, finish_dispatch)
- Link to v3:
  https://lore.kernel.org/r/20260509191223.168648-1-yphbchou0911@gmail.com/

Changes in v3:
- Rename the API from cookie to dispatch transaction: kfuncs renamed from
  scx_bpf_task_get_cookie/scx_bpf_dsq_insert_with_cookie to
  scx_bpf_dsq_insert_begin/scx_bpf_dsq_insert_commit (Tejun Heo)
- Rename internal scx_dsq_insert_commit() to avoid collision with the
  new public kfunc (Tejun Heo)
- Move __ksym __weak declarations in common.bpf.h into the API commit
- Redesign selftest to call insert from ops.dispatch() with CPU affinity
  flips to actually exercise the race detection window (Tejun Heo)
- Skip selftest on older kernels lacking the dispatch transaction API
- Apply the same fix logic as commit e18002d2c791 to the selftest
- Link to v2:
  https://lore.kernel.org/r/20260506160412.522199-1-yphbchou0911@gmail.com/

Changes in v2:
- Reword kdoc for both kfuncs to avoid exposing qseq and ops_state as
  implementation details (Kuba Piecuch)
- Add __ksym __weak declarations for new kfuncs in common.bpf.h
- Add dispatch_cookie selftest (Kuba Piecuch)
- Link to v1:
  https://lore.kernel.org/r/20260506075925.371138-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (3):
  sched_ext: Rename scx_dsq_insert_commit() to scx_dsq_insert_stage()
  sched_ext: Add dispatch transaction API
  selftests/sched_ext: Add dispatch_cookie test

 kernel/sched/ext.c                            | 112 +++++++++++++-
 kernel/sched/ext_internal.h                   |   2 +-
 tools/sched_ext/include/scx/common.bpf.h      |   2 +
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 120 +++++++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 139 ++++++++++++++++++
 6 files changed, 369 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c

-- 
2.48.1

