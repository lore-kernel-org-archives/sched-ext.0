Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C591A3029
	for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239627; cv=none; b=bN5jrqbhE13C/PPCEMdmjQAN4yfRoj7bQyU3mwin9cnLlf1yP4i8LZEDm+lyKxWqKc7FQJabaSCXkHc1gjNvjE2HsdQ+BSL8M/HnXAAEKFu3AJ+kQ8yJ+0VVDSyVCuPRjLn5ZcKk2zx8A2324R26dWtJpj/kJwhMfAmXKYQoZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239627; c=relaxed/simple;
	bh=O0h4DeNP1NUXy7UicRAX/X3Ji9f3uJH1iiaJTT+bTEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaVBdY2Ux8FOesjAUfPt2HDchnoG+/Wb3PIg9BW7qmYIWNhsQssde31ecDLRfGyg78tpA5KhwUSoqiavkktCSDcNi1yDrxAbY96853tkKzUYQjW3YGeLdgxoTqh9Ic8viitQbPuFFmPxRhujb+F8CQZf24khv7OBVSeOeKunPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdVYDij4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdVYDij4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8230d228372so1842546b3a.1
        for <sched-ext@lists.linux.dev>; Mon, 16 Feb 2026 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771239625; x=1771844425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evx2Jzb4NruyvIcx3qjB8Id2p8RJW5u6FvrNuvokA7k=;
        b=gdVYDij4PnwnWb6ZXn3ZrXkm9E+avlNiiGMnmmagPQh1cNvTXGYofs/J7E7R5MfBl7
         Bb9qwVZp2JrM4vc4wnZK1egKBmmeQ2tNw1mbN62SqfUL0gTwAmdgj73hYKRy6QrI5ptg
         6jgvapXk5ht/l3gNQQ1iMwDOvoCelhaJ6RqnVVBQkkw25n0L2m32D40OxSMCOrExLkRQ
         g7rcOR8/zQwuqi4GeNZ3hb/r8XKx13VUfZp6DTXygK8h1nrDwuC5Ys/2gKAYXecVo7VL
         gdGlSo0gj6Tsjj8mKLHPp2h5OQLgTxpIZK8b/TY41Jwv0wW2+op4kbI0gMZN+0CeNV1i
         3H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239625; x=1771844425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Evx2Jzb4NruyvIcx3qjB8Id2p8RJW5u6FvrNuvokA7k=;
        b=iW7g59nLuD8fB6d4Cc+5UAaxIbm1NDVKGoC58fuKIHYqdZPNigYvaQj1g/Eg8L92dd
         nM3m1+jshyzdccJJ6TMbOBTIz/6/9Y9eeQxN4M2afIGfljJYXrEQ9ZJFW0FFhtti4XaB
         u9/NU3fQw9EpkqlrP/HqAKDuKZrZnqJ1y19RStruMh564H9BdzfefJIOWIoEL89XXI6x
         QJH5Zo6BWXwPd5V4r3MI9SPN2+kmbZ61zyk4YhbRymTx34w+bAruXXo9zTP813TBz/hY
         WA2vmU6tYN9xJYZeHoY9iL5Dq1QOAgo5IntuD8ovR9B/mbZF7i9FJeJvC7isi+KKO4Po
         +h6g==
X-Gm-Message-State: AOJu0YzmCb+4cMCRQZ9KKVuLtSs7bQ/q2Xb7MHPqu36If59XVwtDLIPf
	WVwBexyaKmvz7W7p+Ea8KNh99+yGL4mJm4YzXkYY3NlfyGvwtHxWbAAIA2E6cQ==
X-Gm-Gg: AZuq6aKiZAF6YlqiMSQ3sIi2GCgQo16qsBfY5Yk4p/pM9efk6pd895KqKVDlAZkD3M2
	SPbkKfJAI3R3JKCFQiCbix0lh5jmsfeC7ist7LgCDi6Auo3qYLyBY7eK5XIZirYLZlRa2Spirmh
	kF3haSmWX4S+vEON2Mm/zzRayupiX076SJtWfCIOWZG0QJI3WI7h3OnNv3RJz+0tsz8s5UMknPr
	QJKMhaDiBXgNDOEJB4snycO7uDgDOTJ3yPp+ZYz4tJRuAjydHHCmleTlLmVH0D8Wv4O/zOCmiLA
	9F0H+fQksyRLWy5fI4EDYaiavdsLRZU8vUELwLM309Pe+S1sxZVTmkRjZ+cqtr1FJiRxo7ddsBi
	Z1O8zla2sjEm+hM9gP002czt6qLo5Fh+6norHxspUmzjVkPzE7uD0wkcwb0D9Pc8jjOXe32fNdX
	OHFUjCKFDS3uEDC2+uCYbw/aE+v62nl1WufUVXynYGs3SC2WC0TlmB
X-Received: by 2002:a05:6a00:3d9a:b0:819:5db9:6ac0 with SMTP id d2e1a72fcca58-824c95be43fmr7388398b3a.37.1771239625107;
        Mon, 16 Feb 2026 03:00:25 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:87b9:1690:2f70:403c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5596sm9978994b3a.58.2026.02.16.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:00:24 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] tools/sched_ext: Add Kconfig to sync with upstream
Date: Mon, 16 Feb 2026 19:00:14 +0800
Message-ID: <20260216110014.771335-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260216110014.771335-1-yphbchou0911@gmail.com>
References: <20260216110014.771335-1-yphbchou0911@gmail.com>
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
 tools/sched_ext/Kconfig | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 tools/sched_ext/Kconfig

diff --git a/tools/sched_ext/Kconfig b/tools/sched_ext/Kconfig
new file mode 100644
index 000000000000..65b6485d0bd9
--- /dev/null
+++ b/tools/sched_ext/Kconfig
@@ -0,0 +1,71 @@
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
+CONFIG_PREEMPT_COUNT=y
+CONFIG_PREEMPTION=y
+CONFIG_PREEMPT_DYNAMIC=y
+CONFIG_PREEMPT_RCU=y
+
+# Additional debugging information (useful to catch potential locking issues)
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_PROVE_LOCKING=y
+
+# Bpftrace headers (for additional debug info)
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_HAVE_EBPF_JIT=y
+CONFIG_BPF_EVENTS=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_UPROBES=y
+CONFIG_UPROBE_EVENTS=y
+CONFIG_DEBUG_FS=y
+
+# more bpftrace to make that work
+CONFIG_IKHEADERS=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_IKCONFIG=y
-- 
2.48.1

