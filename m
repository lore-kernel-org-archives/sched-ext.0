Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628E39DBC0
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903688; cv=none; b=rIKCsfR1aznBOg7RwAt6QxuFRNXnq1TbvfiavZTyNuFXA7h8NxMCT5mtiSMuh2v9Y3oYjBpTTnll2xIwDbHmD0OljVbUsGiiXZgzIvMt/IM5zZMv3AGPjquvVZQMFdoXWw6Ws1U2OC+1AMxsPUafSIR+3M2KvWkb18jVemK4ivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903688; c=relaxed/simple;
	bh=Ig8Qidl4g7GxBDjk5CCcFxksDYaez31SFGaFRo6Aoeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQsGHroD5TDmtcrOv43CtAIYB1gs0Jlv31mSU6U+xMTrLIFD0Ikcox3aDvUgs5BbRaEl9RxWTWr2TKVJTcW3Ex2qQxqpmv8+Q/QyE1nVSZWD79fWzLwsm+KWe1kqua1J05VlgJrx9yApe7VbhOFTR40FyZ0ZSVukFmsuUFJnT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ERsyr+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ERsyr+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so410673b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773903686; x=1774508486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3L3nqRkUerT82JcbBzptz1tSxX46jhmu/lsfGDI2es=;
        b=C5ERsyr+c8hjB/87CdyKLYLJHyd4hpeU96YvAAWZHYFm4NERT0p6qrbvRKcplktsmK
         29/TAeW0B22Whg5EBfM2kJI3hpL/eSYNJNSkPHSOIJNN+ydyqiBQIS5FS9PioN2V5APn
         N5i4ml1HhY+HiIbQr0tD1KYRvPHl6Q1IgoU+Ta+BSb2JFf6qQ8KaTjTzzRN72AuV7euG
         E741NPTlxsSnKb7ZaqOkNnxJmrhY/D7a9lJxz5gC5Vb8kKwUDO/vptl1RE8XJiUxidvh
         OCDxlXBjxz0OM5rQ6T7QoFCmWUu2+gu3N+6Nql78biGbSu3LsEV8vuNEeQKrZXfuTEfE
         ea3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903686; x=1774508486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3L3nqRkUerT82JcbBzptz1tSxX46jhmu/lsfGDI2es=;
        b=jkmXSKJLZfMDisw2cSjF8JmJVoUDT/dVGlyIsCKwoJtEGw3f2/lTHf8Ew1GtjvLIUI
         A8R5cT7VSzujzuoJTvzvyChXo9NDLX/zRV8xWKrrTYqrCN5knfNImepAPn4vPbL+MD/C
         m9lO2vHQ1VDHtWoVcY0e7BeMEqDtXU1l/EjF39u6bUEfbdsMPsqgsUQ4OBlXzt7iEkYS
         +0gpKI+xxgOa/mi7KqkKZntbAZIoY6NFd/8cPMhxypitK0E2bf8ojcaXSXq0bUuD/lyD
         09H5pZ8f+lgnCwpTPf5ftIzRdDFnpaKSh/HkK36wE6y+8xs2EDLHMQTcFlA8yNV11Yq+
         rw/w==
X-Gm-Message-State: AOJu0YxFhiLWY2OgJiuCwSdxMDThbVrRWxOEfonQKD7QWf5SdQ4mjbeq
	yJHqtFzY6XYljimSrgfxtYO7p8rErUa/pqorSXTHMn9XGgQjj/hnRavz+Krs7Q==
X-Gm-Gg: ATEYQzyPmRLafe9qtoO5JhnTrB1MPRYpHo3E0XGfceamqsMHzJMukVRiw7G16EoPs3B
	Lk+m5L1f6lhwkp0/4uabJQz7ivOqnLwmIR+YoMfoFczWfaUEMogeemPl7KxKC18K5+fSrrvdlbx
	CuFqSbWERoIFoaxI09xEOSEkAmMvSXgNxytXKOtWMI+C7MGmFGc9itlQppuNUh0IFiBHkEkkV1M
	f+nYJIMcTlDEDKIjhK/Vb4lArJEyGmqXhtruF2bZkzyY4A2N37+6prqXTn/JsalTUjQTzAjf+i4
	3z2E4C9mlrMji39vqf68M1a5omF8wg/+bBGTSpt0cHr4CDWx66x00yG+M5DQbUpcTun6qTbHdkS
	dz8LzAy9BDzRx4N2sSBwzrFtT3/AojKlhUH1t4bT5MK4Lvi8UsF9tKW0p/RFODikcavmwCUB0Du
	HRKwgvIQhss1Ucn6e2zm9TzoxVU0m3YkzXvzW0NIYO5KfjzMT+8ViSBd0PLdMQXSwwFlYwbL22l
	hc=
X-Received: by 2002:a05:6a00:3319:b0:824:b181:f492 with SMTP id d2e1a72fcca58-82a6aea0e16mr5278227b3a.45.1773903685848;
        Thu, 19 Mar 2026 00:01:25 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm6599578b3a.43.2026.03.19.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:01:25 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: Su Zhidao <soolaugust@gmail.com>,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH v2 1/2] sched_ext: Documentation: Document events sysfs file and module parameters
Date: Thu, 19 Mar 2026 15:01:18 +0800
Message-ID: <20260319070119.575316-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319070119.575316-1-suzhidao@xiaomi.com>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
 <20260319070119.575316-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Su Zhidao <soolaugust@gmail.com>

Two categories of sched_ext diagnostics are currently undocumented:

1. Per-scheduler events sysfs file
   Each active BPF scheduler exposes a set of diagnostic counters at
   /sys/kernel/sched_ext/root/events.  Sub-schedulers expose their counters
   at /sys/kernel/sched_ext/root/sub/sub-<cgroup_id>/events.  These counters
   are defined (with detailed comments) in kernel/sched/ext_internal.h but
   have no corresponding documentation in sched-ext.rst.  BPF scheduler
   developers must read kernel source to understand what each counter means.

   Add a description of the events file, an example of its output, and
   a brief explanation of every counter.

2. Module parameters
   kernel/sched/ext.c registers two parameters under the sched_ext.
   namespace (slice_bypass_us, bypass_lb_intv_us) via module_param_cb()
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
 Documentation/scheduler/sched-ext.rst      | 70 ++++++++++++++++++++++
 tools/testing/selftests/sched_ext/Makefile |  3 +
 2 files changed, 73 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index f4f7d8f4f9e4..deeec22a9509 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -93,6 +93,57 @@ scheduler has been loaded):
     # cat /sys/kernel/sched_ext/enable_seq
     1
 
+Each running scheduler also exposes a per-scheduler ``events`` file under
+``/sys/kernel/sched_ext/root/events`` that tracks diagnostic counters.
+Sub-schedulers expose their counters at
+``/sys/kernel/sched_ext/root/sub/sub-<cgroup_id>/events``.
+Each counter occupies one ``name value`` line:
+
+.. code-block:: none
+
+    # cat /sys/kernel/sched_ext/root/events
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
 
@@ -441,6 +492,25 @@ Where to Look
     scheduling. Tasks with CPU affinity are direct-dispatched in FIFO order;
     all others are scheduled in user space by a simple vruntime scheduler.
 
+Module Parameters
+=================
+
+sched_ext exposes two module parameters under the ``sched_ext.`` namespace that
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
 
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index a3bbe2c7911b..84e4f69b8833 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -162,8 +162,11 @@ endef
 all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
 
 auto-test-targets :=			\
+	consume_immed			\
 	create_dsq			\
 	dequeue				\
+	dsq_reenq			\
+	enq_immed			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
-- 
2.43.0

