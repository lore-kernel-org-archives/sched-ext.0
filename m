Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A163F0773
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821271; cv=none; b=S/e1ln9EXoDpR/voR9y0eNk1F6ynaOSEpqDN5alVGhAFDC+W9ohPRkuJ+x3CyLeUDyZnXTaRr/0+XNrdrh7hX36AllhEGmT5Llkq/6JOMCkj/UZ6Pa90XpUxvLPaRNWOuHp92SsZdrJkSyazyucSZthJsC1RmLP9rmTpHxfHAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821271; c=relaxed/simple;
	bh=lYFG4SFwG5lsDXjJpUKT7LVwCKTOyKEi81+tBlAo50U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAJY83XYwm+QpmsoN2cSoaQ6Z+h1c4OSoqo5ifr8l4IT4Q0UkQu02yMj3skqhT3HW+KZrXsys6junhq2I9qGvwKm00zulTZMX6wiSZpgMb06PrCyw20dy5SmY4+Kpu5o/IYf0mJNi+faPfPyYVgYZdCK8JTqGkCV4uxArlf3bWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTIxWQj0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTIxWQj0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso5892096a91.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772821269; x=1773426069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgz/IXywt+dBRTWbksu+iwD9ylAkc6vGeaLBaZqsTnQ=;
        b=YTIxWQj0bpx49V5IcFoL1pleOGAQtnNcda2OH2ddvlpjpvlgYSAxi78GFZ9i07K7F4
         yWer/mnhj58vM2b4ceIaIOQEQqZzt+bLC28+xKEiQwqbKkR9ywoFGY+OotBhUk9RgeWF
         kcumFg+tjYxX0lIXSQ0ixKUzG9Rky8exL3NtXyIp1i+Gqd9fGz5zJD7gkJC/CQoIEpWE
         cZsc74AgHBpSUWsjrpJmn0BPUaUANFpF5Fcx+IPF2i5jMbl+RFhN3Gt8GyO1tlXPOIk7
         Rxh0F/i+qPi6UwlNnDUA35xjHfxjPGXFnqyq10I8fITe8P9XXXgbVEXQaRibiC5erqbZ
         7gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821269; x=1773426069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgz/IXywt+dBRTWbksu+iwD9ylAkc6vGeaLBaZqsTnQ=;
        b=kMVmv2UhPuq2z035voBKMYd+K30sageiV2ueUH/kT71Awo79IFxS/XIQa+Nc5JBtvh
         ZA2Kp71/oaROgFKbfwOf3hWtw2vqUnDyjgUNIfffbIKuTs0q4HWRsYkEIztVHfnZC+UE
         cQ9YXTvvp3MSZ42i7bZz/W5WaNikNd2aDUv7TJX6Zr+IZR4H/c/ukgGUAblCQUzMyQ5+
         QhkY+kVpVaiIbOEpOic0hh4R0tcCXVofHyAEzZ6Gu4wdgX1lZO/4GECe82CUxGSAgcFP
         woQSseed6CJpNJBSaWynFJDTPRLnW9aswvygUw00q4VcS8mURWmA8d/H+PBZKSHfoKUT
         lnAw==
X-Gm-Message-State: AOJu0YxM1SZqjcR3hm2UmpqTnEGS+jVTZ84hr8JgA7VNzgqyCFrv3WTs
	oQW1M+CU/vCHWQbvJP1wW1Xsg4HnCRGrgQKB61g1qWYxqWjgir1ImQVmR2729r4D
X-Gm-Gg: ATEYQzxrrVClJx57fOyr2zCnj5nir0gtx5JUD+xvbpM8XOIdRpXU1c6Gab3+L/JtUl8
	pmGhSCh3z3j8P/plNB0uQgaA102rmaD3ur6glHbh39wXYCustC9aJdWFIw1dBu2jnB3aWNbvm7A
	QBN3lC11KG/lUdwi8d6cVUbyBmKs1a37NCFlmyx8ck3ns7ZCgoKFWaXjQb19ahd8zG0sxDMcTsb
	1Rt63aw984kLUwjHsIKfqVX/frCii7Y0lPZF3mMKFPwMXNNigyKJGDeLYxs6vzP9uBiXi9TEP8o
	jZVtWzO7Ch09r6ni3GGAt6qd5a7SBGqpGrYJa24HTKV27AzHPNofTcZDhfQM9Xtt126xXf0futF
	vGJRuwP3Ayu8pdVfuDDKRN4DABuXDtx3w2u/9qv4But0R42imiPsrC9nO2w4VlMSGN2KHNU7/AW
	1q1uGTMR8tP9zUu5LEpfiqD8023VnpwE3MHVPZLayY5dPfCopLw3oa
X-Received: by 2002:a17:902:cf08:b0:2ad:ad0f:bbc3 with SMTP id d9443c01a7336-2ae824dd271mr32033375ad.33.1772821269183;
        Fri, 06 Mar 2026 10:21:09 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:493d:4ea7:622d:5fe3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f770ffsm38233755ad.45.2026.03.06.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:21:08 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Documentation: Update sched-ext.rst
Date: Sat,  7 Mar 2026 02:21:01 +0800
Message-ID: <20260306182101.3085628-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove CONFIG_PAHOLE_HAS_BTF_TAG from required config list
- Document ext_idle.c as the built-in idle CPU selection policy
- Add descriptions for example schedulers in tools/sched_ext/

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 Documentation/scheduler/sched-ext.rst | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 100d45963781..b3c31eb38148 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -43,7 +43,6 @@ options should be enabled to use sched_ext:
     CONFIG_DEBUG_INFO_BTF=y
     CONFIG_BPF_JIT_ALWAYS_ON=y
     CONFIG_BPF_JIT_DEFAULT_ON=y
-    CONFIG_PAHOLE_HAS_BTF_TAG=y
 
 sched_ext is used only when the BPF scheduler is loaded and running.
 
@@ -346,6 +345,8 @@ Where to Look
   The functions prefixed with ``scx_bpf_`` can be called from the BPF
   scheduler.
 
+* ``kernel/sched/ext_idle.c`` contains the built-in idle CPU selection policy.
+
 * ``tools/sched_ext/`` hosts example BPF scheduler implementations.
 
   * ``scx_simple[.bpf].c``: Minimal global FIFO scheduler example using a
@@ -354,13 +355,35 @@ Where to Look
   * ``scx_qmap[.bpf].c``: A multi-level FIFO scheduler supporting five
     levels of priority implemented with ``BPF_MAP_TYPE_QUEUE``.
 
+  * ``scx_central[.bpf].c``: A central FIFO scheduler where all scheduling
+    decisions are made on one CPU, demonstrating ``LOCAL_ON`` dispatching,
+    tickless operation, and kthread preemption.
+
+  * ``scx_cpu0.[bpf].c``: A scheduler that queues all tasks to a shared DSQ
+    and only dispatches them on CPU0 in FIFO order. Useful for testing bypass
+    behavior.
+
+  * ``scx_flatcg[.bpf].c``: A flattened cgroup hierarchy scheduler
+    implementing hierarchical weight-based cgroup CPU control by compounding
+    each cgroup's share at every level into a single flat scheduling layer.
+
+  * ``scx_pair[.bpf].c``: A core-scheduling example that always makes
+    sibling CPU pairs execute tasks from the same CPU cgroup.
+
+  * ``scx_sdt[.bpf].c``: A variation of ``scx_simple`` demonstrating BPF
+    arena memory management for per-task data.
+
+  * ``scx_userland[.bpf].c``: A minimal scheduler demonstrating user space
+    scheduling. Tasks with CPU affinity are direct-dispatched in FIFO order;
+    all others are scheduled in user space by a simple vruntime scheduler.
+
 ABI Instability
 ===============
 
 The APIs provided by sched_ext to BPF schedulers programs have no stability
 guarantees. This includes the ops table callbacks and constants defined in
 ``include/linux/sched/ext.h``, as well as the ``scx_bpf_`` kfuncs defined in
-``kernel/sched/ext.c``.
+``kernel/sched/ext.c`` and ``kernel/sched/ext_idle.c``.
 
 While we will attempt to provide a relatively stable API surface when
 possible, they are subject to change without warning between kernel
-- 
2.48.1

