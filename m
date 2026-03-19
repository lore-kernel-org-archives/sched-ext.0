Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C56126BF7
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898234; cv=none; b=upFbhSCvK35QyapplLYbanHeWW8gyW7gQ8whChNx0A7nyr+h5DXc4bvAby+KsKUcGfRsSnx6c7qSYWvmA5tZJBnl/5NVT9Eja2ES3dlqphdkDIjQdb0gAGPoCiRBxKJ09VnFvbfeJCoD3R+LkSY+6OlXx8yKwnPsLNhRelZL6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898234; c=relaxed/simple;
	bh=Ek61n9huulxfy9S4sfy2ex57jC6nZwtJWxjTvqgzVBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+e9aP6BssTL3pu0VyzyHpl1TV26XpI7j0AK/21qj1numKF5jmETbZUqG8boIxHcthrW+JCTSPyFovpZ4Xrm1O18adSzjfqSCbN/mHbltXrQpGk9Svd4PeLKtyMjvOCul2HhYiQpgp32GvVGDGm3ji/57AelTymQrMyOLrg/a/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ/4Sbsf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ/4Sbsf"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82a655cfab5so660050b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773898232; x=1774503032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ugIXPnzqH1xh+AHf3bQwoI+E5lGp+P/M5xBeU3v2KE=;
        b=GQ/4SbsfFBmrsOy3ZfS6xi9fi4CWLcwLERF5BcHI1WiFXkXMFeaHnc5PKR2BcTuLvl
         fYGHEwiugrhcCIjE6cpEEbgoMyCBB/1l5JT4n1ZpQ2lJzgXf6qOsYvzfjUMqf3m9mBnH
         FVAjZUvRaH0iNxIXDjZDMqxIyAw0ry/Dv1V5yxXlMJZz+hYmUjiEMQYdDFxIDgoIZKiW
         0MlFr48aWQ5v+Qi5/IGU+Hl8PO3obq4NShMWjrd3fQn/Y/ONuNx1pz3dxcxY4FpK9CJG
         ZJ3oIKaY1a6SkOZ+vUq19Mxnk/dVRKNXd3Y7t3/nxD0XVg4PByyixc8Z1mklD2mzC5oL
         iaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898232; x=1774503032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ugIXPnzqH1xh+AHf3bQwoI+E5lGp+P/M5xBeU3v2KE=;
        b=laQMRiHdW6slLYs5jfPtGxp2+Nd1oQ4vG5kP6c2XgydzNEZGr4/vhlqrzXzihYjEkK
         upJ9zBryFXLwf1CpfJpUtE1kL5qj9CLsEcdDDbJXnYiBjnEtCd2lq0AgqLxeQ634NilK
         r7yx7zMjQfWoeAQXgg1OLfR5CQXQ0puJqSn2eIkgPw/kP2x39AEu9xnWuNGQJnhUvUcE
         gV4V4zkqgEprLcIzAm+ydJJ9JISzB2SwLtMgRR+2RZ32MTQ7ZooWFgbJV9DTnoc1irsz
         koGiztj6SxDfJf5o/Ynz9EzVzjuJVXhOfq9X4+m3BoQrheZnEaaw5i1KOcbrTnQdrPX1
         y/rA==
X-Gm-Message-State: AOJu0YxFj7FKv84KH2QH5CDIC130XTyiudJ2iMKbkl4CuDYiss3Fvxic
	xPiP2Qy7wVXix6nJ1BI52680gmuclHQJh0P6ejXSkUhKLqHw/Zd2XXb/F2TmLQ==
X-Gm-Gg: ATEYQzwPxCsJiE24xyEZCHOytveDyRwUQ8evDPnG1xVs3zo2+v+nVla+I+mwt17SF0i
	sYCyZplmfXwgSfF10wqqQ8g9WIHoqYghzb8tsHRWT8MIJFtL6ge45q4SLr4DKc2adAMncKe3d03
	ILiciYv43p6HGT96szDpgELDGlDvGlgc7Lam9KoNq7CSqtgtykrVVVmUBN/i4NRfERdg0tVMMI1
	KnbzuYbxmhHggrEDYljDGZcPpNdKZkLkFVwIZh/IW5DWmg9/Yqhi6W9i+c6su78YAa9Sgv95dRF
	xkI0Ta7PLfvxVsxyXZyAUxzBpZUFgxZ2H87MwRVDIHhDgkEc5K9R9wtYu3Dep92N0+2b4shCd+h
	Cr9xlNnj1C8OkUb9o4NnxQDddr2eo7rlGC5KKPdavDXAIxg/e2cYuBtxv+EIM1twhmHDp7OyaoN
	ij2FJ8CXjYVTnbgov80fmbx8ye++GupwaOZ1a0dtyuqd42cOBqttEfQ1/C1l87ZkkGYvdNYjd3K
	FQ=
X-Received: by 2002:a05:6a00:12e1:b0:829:837b:9068 with SMTP id d2e1a72fcca58-82a6af0da63mr5364651b3a.29.1773898232159;
        Wed, 18 Mar 2026 22:30:32 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b532155sm5488403b3a.7.2026.03.18.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:30:31 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 1/2] sched_ext: Documentation: Document events sysfs file and module parameters
Date: Thu, 19 Mar 2026 13:30:25 +0800
Message-ID: <20260319053026.447892-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two categories of sched_ext diagnostics are currently undocumented:

1. Per-scheduler events sysfs file
   Each active BPF scheduler exposes a set of diagnostic counters at
   /sys/kernel/sched_ext/<name>/events.  These counters are defined
   (with detailed comments) in kernel/sched/ext_internal.h but have
   no corresponding documentation in sched-ext.rst.  BPF scheduler
   developers must read kernel source to understand what each counter
   means.

   Add a description of the events file, an example of its output, and
   a brief explanation of every counter.

2. Module parameters
   kernel/sched/ext.c registers two parameters under the sched_ext.
   prefix (slice_bypass_us, bypass_lb_intv_us) via module_param_cb()
   with MODULE_PARM_DESC() strings, but sched-ext.rst makes no mention
   of them.  Users who need to tune bypass-mode behavior have no
   in-tree documentation to consult.

   Add a "Module Parameters" section documenting both knobs: their
   default values, valid ranges (taken from the set_*() validators in
   ext.c), and the note from the source that they are primarily for
   debugging.

No functional changes.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 Documentation/scheduler/sched-ext.rst | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index f4f7d8f4f9e4..6fc7e720a956 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -93,6 +93,55 @@ scheduler has been loaded):
     # cat /sys/kernel/sched_ext/enable_seq
     1
 
+Each running scheduler also exposes a per-scheduler ``events`` file under
+``/sys/kernel/sched_ext/<scheduler-name>/events`` that tracks diagnostic
+counters. Each counter occupies one ``name value`` line:
+
+.. code-block:: none
+
+    # cat /sys/kernel/sched_ext/simple/events
+    SCX_EV_SELECT_CPU_FALLBACK 0
+    SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE 0
+    SCX_EV_DISPATCH_KEEP_LAST 123
+    SCX_EV_ENQ_SKIP_EXITING 0
+    SCX_EV_ENQ_SKIP_MIGRATION_DISABLED 0
+    SCX_EV_REENQ_IMMED 0
+    SCX_EV_REENQ_LOCAL_REPEAT 0
+    SCX_EV_REFILL_SLICE_DFL 456789
+    SCX_EV_BYPASS_DURATION 0
+    SCX_EV_BYPASS_DISPATCH 0
+    SCX_EV_BYPASS_ACTIVATE 0
+    SCX_EV_INSERT_NOT_OWNED 0
+    SCX_EV_SUB_BYPASS_DISPATCH 0
+
+The counters are described in ``kernel/sched/ext_internal.h``; briefly:
+
+* ``SCX_EV_SELECT_CPU_FALLBACK``: ops.select_cpu() returned a CPU unusable by
+  the task and the core scheduler silently picked a fallback CPU.
+* ``SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE``: a local-DSQ dispatch was redirected
+  to the global DSQ because the target CPU went offline.
+* ``SCX_EV_DISPATCH_KEEP_LAST``: a task continued running because no other
+  task was available (only when ``SCX_OPS_ENQ_LAST`` is not set).
+* ``SCX_EV_ENQ_SKIP_EXITING``: an exiting task was dispatched to the local DSQ
+  directly, bypassing ops.enqueue() (only when ``SCX_OPS_ENQ_EXITING`` is not set).
+* ``SCX_EV_ENQ_SKIP_MIGRATION_DISABLED``: a migration-disabled task was
+  dispatched to its local DSQ directly (only when
+  ``SCX_OPS_ENQ_MIGRATION_DISABLED`` is not set).
+* ``SCX_EV_REENQ_IMMED``: a task dispatched with ``SCX_ENQ_IMMED`` was
+  re-enqueued because the target CPU was not available for immediate execution.
+* ``SCX_EV_REENQ_LOCAL_REPEAT``: a reenqueue of the local DSQ triggered
+  another reenqueue; recurring counts indicate incorrect ``SCX_ENQ_REENQ``
+  handling in the BPF scheduler.
+* ``SCX_EV_REFILL_SLICE_DFL``: a task's time slice was refilled with the
+  default value (``SCX_SLICE_DFL``).
+* ``SCX_EV_BYPASS_DURATION``: total nanoseconds spent in bypass mode.
+* ``SCX_EV_BYPASS_DISPATCH``: number of tasks dispatched while in bypass mode.
+* ``SCX_EV_BYPASS_ACTIVATE``: number of times bypass mode was activated.
+* ``SCX_EV_INSERT_NOT_OWNED``: attempted to insert a task into a DSQ not owned
+  by this scheduler; such attempts are silently ignored.
+* ``SCX_EV_SUB_BYPASS_DISPATCH``: tasks dispatched from sub-scheduler bypass
+  DSQs (only relevant with ``CONFIG_EXT_SUB_SCHED``).
+
 ``tools/sched_ext/scx_show_state.py`` is a drgn script which shows more
 detailed information:
 
@@ -441,6 +490,25 @@ Where to Look
     scheduling. Tasks with CPU affinity are direct-dispatched in FIFO order;
     all others are scheduled in user space by a simple vruntime scheduler.
 
+Module Parameters
+=================
+
+sched_ext exposes two module parameters under the ``sched_ext.`` prefix that
+control bypass-mode behaviour. These knobs are primarily for debugging; there
+is usually no reason to change them during normal operation. They can be read
+and written at runtime (mode 0600) via
+``/sys/module/sched_ext/parameters/``.
+
+``sched_ext.slice_bypass_us`` (default: 5000 µs)
+    The time slice assigned to all tasks when the scheduler is in bypass mode,
+    i.e. during BPF scheduler load, unload, and error recovery. Valid range is
+    100 µs to 100 ms.
+
+``sched_ext.bypass_lb_intv_us`` (default: 500000 µs)
+    The interval at which the bypass-mode load balancer redistributes tasks
+    across CPUs. Set to 0 to disable load balancing during bypass mode. Valid
+    range is 0 to 10 s.
+
 ABI Instability
 ===============
 
-- 
2.43.0

