Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13B15A87C
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272488; cv=none; b=PUGb3EJBBgtY3ylEWoKRnkZSdVwSy5hxynjKIKCWDXBVS8OOw33eGPN2qv9WqYw78vsoPmrJtfXLAA/HhT3FDfWHnWvY/qa5+mTtX4RBAbsFZOTLypfNbJIX0I0EA79AgRPOiAUBIR62Wxc9DAO46La8MB2A7TVt8T7ec0Cm9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272488; c=relaxed/simple;
	bh=9s8BX60bsvD+5V1xntvMWHsuhfdoP1AxaYA/lwDJC5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4WIKzC7paQdxYaiVeczhbMUTq6uB2RWL/DLr2/seUMqxkThQbP6QjheXY9KOHLGq1IYxtLMetsrjj/D7mP5pd4TtBOdpDakiWMlRaoApUzz3vEGGfYQACgscXDQ2JjvIMsK3V34yGReLtDfVsSrjwJI2bxUEy/zJfhJGcVsFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjNO1WVC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjNO1WVC"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748feca4a61so3606062b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272486; x=1753877286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9MiJf713T8No3hPEVikqE3OcTr+T1u6N9x0bV700CM=;
        b=GjNO1WVCHVH5JIBy7266/ClvE6u23txz7gX2aqN+bUUDo4P3NlvW9tmPyUPpo90ubi
         2/8RgT3Ip2+GTh+LKXAvp0Y3nMTcDvUD4RhJIr+bsiMzESf/OeP2NvoXkiwpjGj8nASB
         iNzzZikC6DaxLkIEqNpYo4NwtyojTWuk0kTCvdM5aZUXvX9yAy4cqc2XYVuFxatYWiGY
         hqEQHyWlwp9dCE7GjkE584WEVr7qz96APPfYtc0xyxI4GgrjALIO6YQ6XU6DPqVVH2aR
         OiFiwuDaqtbdyWi/AOzEnorpSUJQT70dNXrENc8P03M9awlQUIAF5pTvj8pWZ1XWXQqi
         OLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272486; x=1753877286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9MiJf713T8No3hPEVikqE3OcTr+T1u6N9x0bV700CM=;
        b=OWLbR3Lvm48p/SuFYutIAC58MzvCjKIMTBaq1TPJAn310/zHiq5NYQ80UODTIwGgC4
         c9/Y0vQwLmB3ZQklKX+7GzFQMUveITG2mEfXpjmMJ6qNOI4ns3V8qLXHZ+n0tjNpSgLU
         ivamgJ/DFtId7LZ/48TtU7Wy4DytdOWR9XNjAZL1nxaT1gzPTEivkPXbjX79imF19hwx
         mI1/b3HnIUOP2p/AfewGnFWBq71zVPtA0GRrF01qdRG4Z9kgQkpgPS5AcTbOIH4AYpFW
         OOd91JJSV15/H4eBS+GEbIfYTwdGhr/OhqiUmX+HeirBb+3cL4HNNTpkkEk3Un7QWjJc
         +A5A==
X-Gm-Message-State: AOJu0YwkufjNRfiZS9DqNA5V9GHIqzrfbbm7aOYQ/Q4Z3aXLgPKYueQG
	4B7QE8mR4dpQ13OXEQvFgqneLoOsfShBtGloG/z36OQE2q7bSlGBw7NfrEXWqq4wtJk=
X-Gm-Gg: ASbGncv59M3m11VmlsKi1SDRSkW4WaisudyDQhsyyaT8hr4Kc370kxtusJPhu7Czz7Q
	mR6iqVGZNArtEVO2dhIrfbexnZ2eDt3jVlu9UXnvVHH/cb0kWhBg1Ios8cpT4u6N3dgRiNxuabG
	UedTD+wmfkkmRNj0zgdoyZjeavg8JDeUlU/ieURo3eaVsp8HYMwUL0gZ735Z34LEvY814eC0D7w
	GIhyiL1fBFPrcv1WfuWIcfdfO+gIg+njJSa9uPrDv78xz42VF/5wfIrlQhmQVA2AsPe6w2xIj/J
	c9qvT25ekTNp6x/OdYzyUDwXHmCyAXome4ULOzy7oQFmqbJlezb83fIkuC1xtPxpCcMMMSvwSax
	U/sSsokFLVmebw4pcWwM+Uh3Bw1F5LydESWZS+JPK6NGSQS+euGC9
X-Google-Smtp-Source: AGHT+IHuN/7fdq6xsHhtlPHKp/BfYgImMOxe6bVInAh2CB7yCVl3wXsNPWiV5sH5/8gUoFAPQw7lBg==
X-Received: by 2002:a05:6a00:2446:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76034510546mr5032498b3a.8.1753272485178;
        Wed, 23 Jul 2025 05:08:05 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:04 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 07/10] sched_ext: Sync with scx upstream in tools/sched_ext/include/scx/common.bpf.h
Date: Wed, 23 Jul 2025 20:07:43 +0800
Message-ID: <20250723120746.52847-8-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 102 +++++++++++++++++++++--
 1 file changed, 93 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..86abdb3c3142 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -24,14 +24,26 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <asm-generic/errno.h>
-#include "user_exit_info.h"
+#include "user_exit_info.bpf.h"
 #include "enum_defs.autogen.h"
 
+#define PF_IDLE				0x00000002	/* I am an IDLE thread */
+#define PF_IO_WORKER			0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER			0x00000020	/* I'm a workqueue worker */
+#define PF_KCOMPACTD			0x00010000      /* I am kcompactd */
+#define PF_KSWAPD			0x00020000      /* I am kswapd */
 #define PF_KTHREAD			0x00200000	/* I am a kernel thread */
 #define PF_EXITING			0x00000004
 #define CLOCK_MONOTONIC			1
 
+#ifndef NR_CPUS
+#define NR_CPUS 1024
+#endif
+
+#ifndef NUMA_NO_NODE
+#define	NUMA_NO_NODE	(-1)
+#endif
+
 extern int LINUX_KERNEL_VERSION __kconfig;
 extern const char CONFIG_CC_VERSION_TEXT[64] __kconfig __weak;
 extern const char CONFIG_LOCALVERSION[64] __kconfig __weak;
@@ -107,6 +119,9 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 
+#define SCX_STRINGIFY(x) #x
+#define SCX_TOSTRING(x) SCX_STRINGIFY(x)
+
 /*
  * Helper macro for initializing the fmt and variadic argument inputs to both
  * bstr exit kfuncs. Callers to this function should use ___fmt and ___param to
@@ -141,13 +156,15 @@ void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
  * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
  * instead of an array of u64. Invoking this macro will cause the scheduler to
  * exit in an erroneous state, with diagnostic information being passed to the
- * user.
+ * user. It appends the file and line number to aid debugging.
  */
 #define scx_bpf_error(fmt, args...)						\
 ({										\
-	scx_bpf_bstr_preamble(fmt, args)					\
+	scx_bpf_bstr_preamble(							\
+		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args)		\
 	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
-	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+	___scx_bpf_bstr_format_checker(						\
+		__FILE__ ":" SCX_TOSTRING(__LINE__) ": " fmt, ##args);		\
 })
 
 /*
@@ -229,6 +246,7 @@ BPF_PROG(name, ##args)
  * be a pointer to the area. Use `MEMBER_VPTR(*ptr, .member)` instead of
  * `MEMBER_VPTR(ptr, ->member)`.
  */
+#ifndef MEMBER_VPTR
 #define MEMBER_VPTR(base, member) (typeof((base) member) *)			\
 ({										\
 	u64 __base = (u64)&(base);						\
@@ -245,6 +263,7 @@ BPF_PROG(name, ##args)
 		  [max]"i"(sizeof(base) - sizeof((base) member)));		\
 	__addr;									\
 })
+#endif /* MEMBER_VPTR */
 
 /**
  * ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
@@ -260,6 +279,7 @@ BPF_PROG(name, ##args)
  * size of the array to compute the max, which will result in rejection by
  * the verifier.
  */
+#ifndef ARRAY_ELEM_PTR
 #define ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)				\
 ({										\
 	u64 __base = (u64)arr;							\
@@ -274,7 +294,7 @@ BPF_PROG(name, ##args)
 		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));			\
 	__addr;									\
 })
-
+#endif /* ARRAY_ELEM_PTR */
 
 /*
  * BPF declarations and helpers
@@ -438,8 +458,27 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
  */
 static inline bool is_migration_disabled(const struct task_struct *p)
 {
-	if (bpf_core_field_exists(p->migration_disabled))
-		return p->migration_disabled;
+	/*
+	 * Testing p->migration_disabled in a BPF code is tricky because the
+	 * migration is _always_ disabled while running the BPF code.
+	 * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) for BPF
+	 * code execution disable and re-enable the migration of the current
+	 * task, respectively. So, the _current_ task of the sched_ext ops is
+	 * always migration-disabled. Moreover, p->migration_disabled could be
+	 * two or greater when a sched_ext ops BPF code (e.g., ops.tick) is
+	 * executed in the middle of the other BPF code execution.
+	 *
+	 * Therefore, we should decide that the _current_ task is
+	 * migration-disabled only when its migration_disabled count is greater
+	 * than one. In other words, when  p->migration_disabled == 1, there is
+	 * an ambiguity, so we should check if @p is the current task or not.
+	 */
+	if (bpf_core_field_exists(p->migration_disabled)) {
+		if (p->migration_disabled == 1)
+			return bpf_get_current_task_btf() != p;
+		else
+			return p->migration_disabled;
+	}
 	return false;
 }
 
@@ -476,7 +515,7 @@ static inline s64 time_delta(u64 after, u64 before)
  */
 static inline bool time_after(u64 a, u64 b)
 {
-	 return (s64)(b - a) < 0;
+	return (s64)(b - a) < 0;
 }
 
 /**
@@ -500,7 +539,7 @@ static inline bool time_before(u64 a, u64 b)
  */
 static inline bool time_after_eq(u64 a, u64 b)
 {
-	 return (s64)(a - b) >= 0;
+	return (s64)(a - b) >= 0;
 }
 
 /**
@@ -547,9 +586,15 @@ static inline bool time_in_range_open(u64 a, u64 b, u64 c)
  */
 
 /* useful compiler attributes */
+#ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
+#endif
+#ifndef unlikely
 #define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
+#ifndef __maybe_unused
 #define __maybe_unused __attribute__((__unused__))
+#endif
 
 /*
  * READ/WRITE_ONCE() are from kernel (include/asm-generic/rwonce.h). They
@@ -632,6 +677,26 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	__u.__val;								\
 })
 
+/*
+ * __calc_avg - Calculate exponential weighted moving average (EWMA) with
+ * @old and @new values. @decay represents how large the @old value remains.
+ * With a larger @decay value, the moving average changes slowly, exhibiting
+ * fewer fluctuations.
+ */
+#define __calc_avg(old, new, decay) ({						\
+	typeof(decay) thr = 1 << (decay);					\
+	typeof(old) ret;							\
+	if (((old) < thr) || ((new) < thr)) {					\
+		if (((old) == 1) && ((new) == 0))				\
+			ret = 0;						\
+		else								\
+			ret = ((old) - ((old) >> 1)) + ((new) >> 1);		\
+	} else {								\
+		ret = ((old) - ((old) >> (decay))) + ((new) >> (decay));	\
+	}									\
+	ret;									\
+})
+
 /*
  * log2_u32 - Compute the base 2 logarithm of a 32-bit exponential value.
  * @v: The value for which we're computing the base 2 logarithm.
@@ -662,6 +727,25 @@ static inline u32 log2_u64(u64 v)
                 return log2_u32(v) + 1;
 }
 
+/*
+ * sqrt_u64 - Calculate the square root of value @x using Newton's method.
+ */
+static inline u64 __sqrt_u64(u64 x)
+{
+	if (x == 0 || x == 1)
+		return x;
+
+	u64 r = ((1ULL << 32) > x) ? x : (1ULL << 32);
+
+	for (int i = 0; i < 8; ++i) {
+		u64 q = x / r;
+		if (r <= q)
+			break;
+		r = (r + q) >> 1;
+	}
+	return r;
+}
+
 /*
  * Return a value proportionally scaled to the task's weight.
  */
-- 
2.48.1

