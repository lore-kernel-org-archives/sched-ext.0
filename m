Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A01DDC3F
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563112; cv=none; b=U3FYSaRGnFY7bLp5D/Xrs6DoRAFDkpugZ5KSHbUWKrZfFfq1QSZ6hqxW8Tpwq1z2w9+sk+3LpygHComxw5JtPWoH89luEOlNkeswR1v1uAmXTYxGuVWfR6hNI6ChWZF4Q8sqIVg6C4ObT+Sxezh9WkQqUjONGwgbaNLZsW1323w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563112; c=relaxed/simple;
	bh=QMtz5269t7rwUJlWRITIrEEe6K40O7l4jAIc2sTJ0t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSEu7hPX4MOGD0vpGo54UDQvXE9ETK5JPGSDZSbZ8+o9c+tVVI3EBmj+biuEO2Xj7LwZUldQL0xPSl/jNKYI+2fd8JSsQP/7u9LyKb9GAd2xBF0gDFWM6rHppzMYStXTuy/zfnOt5U0GWZvnuNsYsSJ3mks4QTV1GJuDCs9YpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alpP2mQ9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alpP2mQ9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so1889214a91.2
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563110; x=1774167910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwoQWT24/opGQhCohPiOPzVOQM9uT2yfWa+q+H+8lh8=;
        b=alpP2mQ9o8etaQZ+zfrHKRu41Vdi8IlhPG7bqD/DGjRNskjsHpGPySenu/RsHiYEC/
         mJLLsSaXv3JQE5dx9Ec36h9/xUf7QaxuSrpuTRRA5qYgMkeaoxVd0K2JfHdpzKvEKdB0
         6UhkzGE7bNNKURahcCHF6hASlpYHuU5FNBaR1tIyFbDbpLhOVl3uvEOA/RI2LXehq/Mk
         a8UETJBOI1pXqbXYp5VhatOl9RKQQx9Z/6/enxakJb7ZoE2EOgKkwTE1+n2bmZTpYIHS
         5EEG+8ERMKZ6XXkSFY9O2BuvXxzKqAWeM1IsoXWkBw9HWRaqliLBCvxrJhGVc7ATsZ1B
         SFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563110; x=1774167910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwoQWT24/opGQhCohPiOPzVOQM9uT2yfWa+q+H+8lh8=;
        b=W0v3mfak7fKYbdcjtLFH0smOmFkJeZkTvPrik+rZPwmlM5k8ErRRuT23Q0CZ2R9pN1
         Itg+lt+qBcDTz/x+c9QvoeNnOeepQuZg92661EqrNxtJX3J5kIO5TLwR2unJnOh5wdyZ
         6kdcWBaRpWiVBQ3tt10VDBQyAPANCHGwcINL0jX5KXOroo9gtwIbCihIY9phpJVjZUMb
         ilUto3eS/hiJ5Nf2oOq+d48PtBHIXizdd1T09+HmRoy2lzpQsFuirx8bdbEBZmYCWnsb
         +Ha7PEJZ2guECsrh4Ao0e2QSprWcLD0zXBqzG9jDkJry5VCO32R8E24VZ/9is/xxpMM/
         MymQ==
X-Gm-Message-State: AOJu0YzugA/nicoa1vIBXZNuhCDSwupbD+ARZi26BqIzcLA73GChOWKs
	symUoTB4JY7iseomgpe9lSmKuXve+N+FUdcyzpe0GtOD6t97HCCJJjfRo/8+lAMp
X-Gm-Gg: ATEYQzzKgaLZjjrur083bzJhN4vscMS5hHjZVXYL3trhtDWzZ5RElP2qq+TM/FPDo+p
	d8wcVVuDSgD71ZwIB/4F/ZKg/LX103bHhP3pC+fNzxxXaRyiDdmW5Z19EzXadtppb4KuCHHkcm4
	1gA549/2IJ6Vld6b/+m1OY9tVVvK0xIWPx3E87z6YNW2vbQLScix88hHPgBMgyu2mmJDLxKmKoH
	+2gEdWn/5GQt6j0AtbSeqZ0Sxf5M3/UgRzjhG7BvLr70VKMN/NLGkCrnFXagpcFAc/Uh7IgzcNq
	89n8BjTI9wAScdwZ9j3s02JwMaBBEqayAgAJTHLw4DW/DLS2g/akLdojrFI0V2hhNTnEf8pBiwL
	TuVuamBumrab6TL0HVNCPUNF/f12lrm740+cQnmuq70JmDdK1cdsDqqpFsmTgFZEbIDvzLNZf1v
	pDQoIqvM384+zQShJ7THZNMwnuQUdrsrml02ZpvLUk+07lBuZQKTtN
X-Received: by 2002:a17:90b:5345:b0:35b:93d8:6ab7 with SMTP id 98e67ed59e1d1-35b93d86c97mr1915520a91.28.1773563109781;
        Sun, 15 Mar 2026 01:25:09 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:53cd:7adc:9650:ee87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm9316523a91.4.2026.03.15.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:25:08 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v5 0/2] sched_ext: Update demo schedulers and selftests for deprecated APIs
Date: Sun, 15 Mar 2026 16:24:39 +0800
Message-ID: <20260315082500.597204-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two sets of sched_ext APIs have been deprecated:

- Direct writes to p->scx.dsq_vtime in favor of
  scx_bpf_task_set_dsq_vtime()
- ops.cpu_acquire/release() in favor of handling CPU preemption via the
  sched_switch tracepoint, as introduced by commit a3f5d4822253
  ("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
  anywhere")

This series updates the demo schedulers (scx_simple, scx_flatcg) and
selftests (select_cpu_vtime, maximal) to use the new APIs, keeping them
in sync with current best practices.

Patch 1 updates scx_simple, scx_flatcg, and select_cpu_vtime to use
scx_bpf_task_set_dsq_vtime() with scale_by_task_weight_inverse(), with
the delta computation moved inside the if block.

Patch 2 replaces the cpu_acquire/release stubs in the maximal selftest
with a minimal sched_switch TP program, and fixes the maximal and
reload_loop tests to properly attach the sched_switch tracepoint via
bpf_map__set_autoattach() and maximal__attach(), as both tests use the
maximal skeleton.

Changes in v5:
- Fix trailing blank line in select_cpu_vtime_stopping() (Tejun Heo)
- Fix prev_state type: unsigned long -> unsigned int in
  maximal_sched_switch (Tejun Heo)
- Link to v4:
  https://lore.kernel.org/all/20260314033708.26483-1-yphbchou0911@gmail.com/

Changes in v4:
- Drop scx_qmap changes from patch 2, already applied in commit
  3229ac4a5ef5 ("sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag")
- Move delta computation inside the if block (Tejun)
- Link to v3:
  https://lore.kernel.org/all/20260313014944.1234667-1-yphbchou0911@gmail.com/

Changes in v3:
- Use scale_by_task_weight_inverse() instead of scale_by_task_weight()
  (Andrea Righi)
- Link to v2:
  https://lore.kernel.org/all/20260312175527.1220540-1-yphbchou0911@gmail.com/

Changes in v2:
- Use scx_bpf_task_set_dsq_vtime() with scale_by_task_weight instead
  of direct assignment and remove redundant bpf_ksym_exists() logic
  (Andrea Righi)
- Mention commit a3f5d4822253 ("sched_ext: Allow
  scx_bpf_reenqueue_local() to be called from anywhere") in the commit
  message to clarify why ops.cpu_acquire/release() are being deprecated
  (Andrea Righi)
- Fix maximal.c and reload_loop.c to actually attach the sched_switch
  tracepoint by calling bpf_map__set_autoattach() and maximal__attach()
  (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/all/20260312042001.955675-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Update demo schedulers and selftests to use
    scx_bpf_task_set_dsq_vtime()
  sched_ext: Update selftests to drop ops.cpu_acquire/release()

 tools/sched_ext/scx_flatcg.bpf.c                  | 12 +++++++-----
 tools/sched_ext/scx_simple.bpf.c                  |  6 ++++--
 tools/testing/selftests/sched_ext/maximal.bpf.c   | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c       |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c   |  3 +++
 .../selftests/sched_ext/select_cpu_vtime.bpf.c    |  6 ++++--
 6 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.48.1

