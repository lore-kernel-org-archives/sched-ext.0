Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BC2C2346
	for <sched-ext@lists.linux.dev>; Tue, 17 Feb 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313173; cv=none; b=XMmVyWV2xPYsz/8zIkZMjKXdR7QfNup1XzYJpdHaOy/8b+50NexlK5gOzxbRV7DCo9hkTjbKKC4aQDuJ6I1+cDZL3ygCAG+EqmykTyEzrjlwXaBOPCCiIkTfIODZ3GoSw33pE09yHEm+1D2OHUWYyx6wlCaut62DIWy8z9dxzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313173; c=relaxed/simple;
	bh=TjvdjNF/QwM40b34vUvWAY8KQ8+tab/No9lp5MpdYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwc1zVY8ZgbGqL1EmWMnCPLo4xojctlmJ3CdKQ4TDsvyMKvoLolmB/JvODbbVhgEcyvFbgrMRkh/unSRGzOe5RRSTfHJ7N0KZR2ZIDVEMUylnA52QcSYVrOVWD+rPkUmzQ8KawxswdrHMD2Z14b6jtHwnC4PwHIG5r4IFhgxe1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjtQTGiy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjtQTGiy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a871daa98fso28471855ad.1
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 23:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771313171; x=1771917971; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KnAQ88mHuYNYy6ZsiOrAN6V7DkNrgonTA0jFVIoiKk=;
        b=CjtQTGiyJXQqVvlL7pO4L79Rtdm8t37HqAquBGVvg8Z8hXgIGPDn/esQBz2YuhXpLR
         xRvu6fBTdRdNI/Wxv6djhLnTcFHYIvf7vERzpjKEljah7PQ0ikiRqvmpQUvHt88fupDv
         bGer8+c/zBP9FqQ/UuTYl+jcfsAbeyK/EDY+YZKJuM0QJVC+HOLHh0099o4X5H5nOCG0
         H0s4ZWMmcpmCTJ4k8fgzTdMLEpPDmCmDxjVrx2sZsBYLEywXq6ghub5FHBS9BeIRASld
         romS/QclNBOsHOGl3YX4OA2lGBcWn3NRyeeik5l4N3xllU0taKGIpYEJ51duxRuCOT45
         h1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771313171; x=1771917971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8KnAQ88mHuYNYy6ZsiOrAN6V7DkNrgonTA0jFVIoiKk=;
        b=C5NbJWCpT+EbbRwtfKwI1CuoDlGH/SAKvB6W9UrbjDBuVYuw5ufwIue7C7Ahl7u8jW
         5jO7MmWvN6D2yskAwakmYVDWnYNndQAsgGkywyPMLtbiNldnxdmqYmXq00xGWJXUJlWd
         XlIXfwstmCrCtzuph7Fi1LVS2qJ6p6dyZmgB6Qsxrjh/niH8LYBP0i1TBk/vRt6wVQOP
         LvKorHSCErh3V4WanGCM1VZ57LDbsATUHvPh7Hf4m2O5P3K8dj82JtUs3smULJyD0TA9
         TbfFZBjn7Gjs9zruGM4PYPJb4BlcrTXHNcbac+y3paIcG4in96HoSJCdQA79kR1dk/Qn
         6U/Q==
X-Gm-Message-State: AOJu0YwVVVxt1DXpnfFqgmrHh6StJ7u5KdcBmpYJ+W11eD7bYYIkrd9j
	LRqK7uNwIMKApnzzWHgP9PeIblGBT4i5Z7qPMN81HmIAHsw5JrsjmtNoYiIpPw==
X-Gm-Gg: AZuq6aJbioyQk908wgyLWAoqKp0n8omcBfxlKBvNnq1qg5KPV5Mk8Z1cjGYKG9oah0o
	skLhPf/SwXQo9hrNmOVVfWCz2QQ55pn5WoOIQNeLpx3lyuxNjoT6sXQpiCctG1G4M6pg2LUUgek
	eboOU7jGy9QJG3snXNuNy1t7hxbOtrLuM3nbEtMibxzIeDzqWHvm0dDk7U3WLoMcJ+UTHrTY91z
	SXqlCCGme5xC5aO1IE478sxjpBxnzOCy+XTyOQRob/IKGF8WvfTii+JoBvQ5EOPLvGZxFq6XAvE
	IkVKnXTVkoIw3p4Q3+BAyKYqBQftnmB+OZM6uVeQc7nS5tBNbchS7uU8V7K6sHpgZ61o6ZeMIxh
	rmigPwMJOZpITLF5FUQ8rvU1HoEoIduOkq4PZsTT1FhFzWcnkiAe/fCRGYhW40W/2kF9xFZCDu4
	U2DoWDwgh//SfvuA8L/BL5MMhHjKXDgmEhpSnHwXoktGeGvOCAi5rD
X-Received: by 2002:a17:902:cccb:b0:2a0:e5cd:80a1 with SMTP id d9443c01a7336-2ad1752e437mr94811335ad.41.1771313171449;
        Mon, 16 Feb 2026 23:26:11 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3f49:4f7a:a0d9:2554])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaf4b31sm85528405ad.86.2026.02.16.23.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 23:26:11 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/2] tools/sched_ext: Add Kconfig to sync with upstream
Date: Tue, 17 Feb 2026 15:26:00 +0800
Message-ID: <20260217072600.953197-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260217072600.953197-1-yphbchou0911@gmail.com>
References: <20260217072600.953197-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing Kconfig file to tools/sched_ext/ as referenced in
the README.

Ref: https://github.com/sched-ext/scx/blob/main/kernel.config

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/Kconfig | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/sched_ext/Kconfig

diff --git a/tools/sched_ext/Kconfig b/tools/sched_ext/Kconfig
new file mode 100644
index 000000000000..275bd97ae62b
--- /dev/null
+++ b/tools/sched_ext/Kconfig
@@ -0,0 +1,61 @@
+# sched-ext mandatory options
+#
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_SCHED_CLASS_EXT=y
+
+# Required by some rust schedulers (e.g. scx_p2dq)
+#
+CONFIG_KALLSYMS_ALL=y
+
+# Required on arm64
+#
+# CONFIG_DEBUG_INFO_REDUCED is not set
+
+# LAVD tracks futex to give an additional time slice for futex holder
+# (i.e., avoiding lock holder preemption) for better system-wide progress.
+# LAVD first tries to use ftrace to trace futex function calls.
+# If that is not available, it tries to use a tracepoint.
+CONFIG_FUNCTION_TRACER=y
+
+# Enable scheduling debugging
+#
+CONFIG_SCHED_DEBUG=y
+
+# Enable extra scheduling features (for a better code coverage while testing
+# the schedulers)
+#
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_SCHED_CORE=y
+CONFIG_SCHED_MC=y
+
+# Enable fully preemptible kernel for a better test coverage of the schedulers
+#
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_DYNAMIC=y
+
+# Additional debugging information (useful to catch potential locking issues)
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_PROVE_LOCKING=y
+
+# Bpftrace headers (for additional debug info)
+CONFIG_BPF_EVENTS=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
+CONFIG_UPROBES=y
+CONFIG_UPROBE_EVENTS=y
+CONFIG_DEBUG_FS=y
+
+# Enable access to kernel configuration and headers at runtime
+CONFIG_IKHEADERS=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_IKCONFIG=y
-- 
2.48.1

