Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7140DFA1
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338136; cv=none; b=LBHs/D/0VDECzx9iZoNA0UECuJa5l3Ll6cl3gv6kBwv98FGsqKu6HD1QrYZkV8o3JxE+MCuAEIFjrB+MZbytIoAF0rrRi+SULQpd3OhzEFRC4Q0AR7rLPnIybHCuv89trD68qumwjP5hX5vHtqOMR6VBc9CuPYacfya3SYucQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338136; c=relaxed/simple;
	bh=DPp+fDwkF0Lz1DGCzTliX6r6qx+9ai27TTULgX3HOjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mswgZOawVBzKV0KnfNK/W8TMqzS1mjwLrlVd7fw4F0IvdTlxKP34GaSS/xjbbnV/SOhAPgXng6JMdi6VrU7ICySgSb5LJcbyKxRoXXK1hWaEd9aADXLCW7FGCuJjrJAeFwGT0rUohToIHBVmO3gRUauiRe6O8KQevHsHvF79a8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etymKDsi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etymKDsi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9516a653so6247925ad.0
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338135; x=1773942935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdFG60QcqovBGx6aKrom/AQDIgTY2I4d+E0t9Zp7suA=;
        b=etymKDsiiW+zYEWAn/arslhFW5MOV7gQ1J3bkqzvVfh1kWARUtvqhAXYFNbr0MKid/
         W7MQ/efeOYsCc6elv/r31QTCH8MqIDHYXpT6W/bjRfDnBo8lExHg1br5REg2qScAjgen
         rb9xrJUXtNVVe8Hk5d96EvvWniftTVW43/tM6Mx65uDX9sU0iSTC1h1ePjdH9JP00BHw
         Vso3J3K8XJDHTEdaK7Dgw9PN6hChLS4nSdKXLBK9Ic+zM+7IOo542YPxb6EO9ipzv/JA
         ln240C2LZVBp03JQ8N+xd/me0DpNNjWIVJ4R6lsq7Q02CheA6vRLqUrqYCG24+tvvaVQ
         WkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338135; x=1773942935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdFG60QcqovBGx6aKrom/AQDIgTY2I4d+E0t9Zp7suA=;
        b=RnBVyvzkgGRLdq3cuZ8ps4t0VRulRP6Dgvel1orDalki9h8R72oqjJCILw8K3o4FNT
         m3ETWzSkaWt6tpMXxdYjAVMzAz0QzJT6LltoorxdiuAl2ge5aluyJFL5bWs5qOeVHb7G
         2f8oScxXJ6ZFDuLzIhir5/xmAn78SMld7fz0JqY7yDCAkniLnihtssPwcxRR9MEXfaA4
         5oFP9p/tj5R6AJzinGDNQW4pOvhRgiywDg7X5uSxETnISZ/TS8jUH/ih6jOCno6QOIiS
         foCBEzbxJItJH/gAOvu/eVRz7M5tQFOQL///WdSYkEZl7fSkHuBO6YnxcJCCD3Ik0y2u
         KV+w==
X-Gm-Message-State: AOJu0YwOKt13GnXlwkG0pkhL4oAhDhx35V2jCOlAxUQgfZfy6eTk2IZR
	x9c6JbTmqjaQDTLrJwJHDV2LUcPh/P5w6AdOU/eQwdLkPvEjxYPvLhEN6Z2yz70S
X-Gm-Gg: ATEYQzzod16GbGb0lqWcIuB33hZGSZFc9YKEkHeeCVCO18T6sWEEFSjpS15CWyz4yuC
	ir5U0OUsENYdUaXqTiTEV8ZvYFku4Yjlg2+iIjZMLTt2L8hN7smJfL8N+o3nAhULzlSjiNHFq9V
	ZJidb5GpyCgY1ZBhnIgZW9nV33bsfHSa3ONBIUdUWvj1hCMKZQ61Z3+da2fQW+X4j4HDd3OlQ15
	f3a1uXrFNO2OvT+zvcNGDPndz5CdkeBxqqLjqJ0d4GIM6R64qTjG2n0AHOsC90DEvgbB3PLtl5C
	GxBH3yI3vegwIoReLThrjN6DwDj9uFZRDgYe4PNSTecbVJQ43e5+mwJHKp8JUKeLGPCYJnUcK1q
	1LWYo8TWRpE/5KXRzIx53jkyjpVar1y7LLrGwIy2ahlMbsSbAnmMHin5+soxYYRxxjfjvDPSxZ2
	BdhGTaNzZFjOqipXJFdPZRDgc24oCrTxtAJX8/MeNqIA03jHuAFUrT
X-Received: by 2002:a17:902:ffd0:b0:2ae:3f3f:67b8 with SMTP id d9443c01a7336-2aeca9a1751mr3408125ad.15.1773338134618;
        Thu, 12 Mar 2026 10:55:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf24c5csm6027353a12.12.2026.03.12.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:55:34 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 0/2] sched_ext: Update demo schedulers and selftests for deprecated APIs
Date: Fri, 13 Mar 2026 01:55:25 +0800
Message-ID: <20260312175527.1220540-1-yphbchou0911@gmail.com>
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

This series updates the demo schedulers (scx_simple, scx_flatcg,
scx_qmap) and selftests (select_cpu_vtime, maximal) to use the new
APIs, keeping them in sync with current best practices.

Patch 1 updates scx_simple, scx_flatcg, and select_cpu_vtime to use
scx_bpf_task_set_dsq_vtime() with scale_by_task_weight.

Patch 2 removes the cpu_acquire/release stubs and the
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
scx_qmap, unconditionally relying on the sched_switch TP. The maximal
selftest and reload_loop test are also fixed to properly attach the
sched_switch tracepoint via bpf_map__set_autoattach() and
maximal__attach(), as both tests use the maximal skeleton.

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
  sched_ext: Update demo schedulers and selftests to drop
    ops.cpu_acquire/release()

 tools/sched_ext/scx_flatcg.bpf.c                  |  9 +++++----
 tools/sched_ext/scx_qmap.bpf.c                    | 15 ++-------------
 tools/sched_ext/scx_simple.bpf.c                  |  6 ++++--
 tools/testing/selftests/sched_ext/maximal.bpf.c   | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c       |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c   |  3 +++
 .../selftests/sched_ext/select_cpu_vtime.bpf.c    |  7 +++++--
 7 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.48.1

