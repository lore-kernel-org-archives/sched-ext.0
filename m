Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166C2E762A
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275777; cv=none; b=ZyXdgpDHoOzJCimpFkFMTsK55tA/v1FXv7HU7otIZeLh3QfWx8IX0Qwkx/4xPU75V39YaLzG1RYzkAP90hWsXEbYHCut1Skw/OOauKyOihy1C3tNiCt1aWwb9shWy6ScX8nK0WutMLnttDCi1Q99xv1O2OdFRTK2bZ4Vf5d8IGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275777; c=relaxed/simple;
	bh=/Ol/71ESiGhX9u+xNlPQyGVY93r/ye6u/egXxRn8kWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Txf1pg7jxWnFo8Q5M7GIrzN5sknLWuVfM27XhX6NoVmxcsqEvsZ27So6LUYFV0V7POWNBBi2df+/bTGxWew2mz23elNd8LYWdf+lveNl1Q4GRt6NM1Rdi9Whn8sincYkNE7gu4+w6fYqoPFIjCoBWe9W6yhYLZdYaB8AGSlByMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRwowSaF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRwowSaF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748feca4a61so3639416b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753275774; x=1753880574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYG21Cc4qNNbg7z7KUAy1/SSfsljM1uISQRU2c3c1x4=;
        b=HRwowSaF53hd78vAvu80H6PQrQjq7urajaisAIJZjkSgZwLo0YkFFDSsqtqbywXbhC
         d79tEPtJA9sw0VlfLrjrs5n7K/dVuIvhXjrBl9MYVQ5VrRURockzmen6rD0/p7QA+vcC
         Ef178zsS91YClvT404JcHXxdzTGhzYNjWpeUAhb0Fw8CYD+QvP6OOoh6kCkKS0aHYA0+
         EV0u+YbaGB/ZVKrdrDjlcQWka8qi5GIzIW71YALWWEFvG8mzTwtOgSGH8r3EaFA+Eb+Q
         OzOHzgl0vqrp1vgUnRRM/OUm+ZaSXjQtYl8NDrfm/2oeaJL5uNPLwmoHVSN8DcaZLuqF
         232A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275774; x=1753880574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYG21Cc4qNNbg7z7KUAy1/SSfsljM1uISQRU2c3c1x4=;
        b=p1wT4vO1zjxWg9tMpofCDOGVpmHNVtdFz++NAfRWeO0VIk1J8AwinINlfGgUf4POaS
         gL54W/g6/dPBo7g4cSF9Bus+KH/nyoWM/D/oXn/EntlAv1KDFa3UEZjAGNR9atNqtZOy
         WDd+ugWkBbMW6aFtGF8r3mAmhtinfhxCTqmGAD0pyrNETSvvl3ckMmZcDIknVpAkUPAv
         ce3O5K1rjqyRHDsnZJLmqLXS+8z/Th+uRCemsKJwyOROPCosIJ4/AV0npNH1XSUc8tlO
         vh+YKbG2sV7MzR/Cdaj5a/H8VjiKvr3Y+Lf8OA4X/N+BIn4Ik8MmfQvQMSOZto1m9PcT
         5Cnw==
X-Gm-Message-State: AOJu0YyJGgpFc84Co9oD1uM/KNoSOG4QIKEsOBCrYlWyEJKO5v2+or0D
	vxYB58SAdnMC6yAgx3POPHBKQfd95Ldr22WkW/1iLrAPqKMTLAucSIo5Rir/eysjVzs=
X-Gm-Gg: ASbGncupsloc/ZPBFDXaHc3oEDpQMAdKPCXD8nPIlpSheNzkO+dEdtLlt2bmOOyUJ6u
	gKh6N3F39+lqpTn20Fbc3kCXsjgdt7Hj5Ila8mr+TP8tWevIShLp+JvDsd4xJ2ImN/TB7Qs/IW+
	9qm0P75Eng8VCHEas1gq6dEeTx0zbU4uf9uq3nzIA9mEz78hmk1vbSkEaw2JYpy2KtNZxbYpWIa
	W0nWKFIXJ5VmvAGe+i7EONDDZPXlmPOdoEeuXgkugfQwJkQKTfvAT2FLhRP4VpuC/95ydRv7qYF
	Z4PFmAnBAO6caKAQ0Dj43981RqeOpKN6reiKxXV8ttHPOwziHaym4E8wt2L/f1++WR4oLZw6pfJ
	TRKl/EINerqVlVzI2NchrupZiH/adm5qpuON4IlvW2gF8v0MSHPHg
X-Google-Smtp-Source: AGHT+IFF8Qahjjy51afczWp175eLCh41KxUXvm2ILf/oUSAspILyf88uJ7AuEq4lueIqe2JmO+cGBA==
X-Received: by 2002:a05:6a20:7f8c:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-23d49133f41mr4668065637.30.1753275773965;
        Wed, 23 Jul 2025 06:02:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26fbsm9687662b3a.27.2025.07.23.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:02:53 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2] sched_ext: Sync with scx upstream
Date: Wed, 23 Jul 2025 21:02:43 +0800
Message-ID: <20250723130243.53691-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h     | 102 +++++++++++++++++--
 tools/sched_ext/include/scx/common.h         |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h     |   5 +
 tools/sched_ext/include/scx/user_exit_info.h |  49 +--------
 tools/sched_ext/scx_central.bpf.c            |   2 +-
 tools/sched_ext/scx_central.c                |   1 +
 tools/sched_ext/scx_flatcg.bpf.c             |   2 +-
 tools/sched_ext/scx_flatcg.c                 |   2 +
 tools/sched_ext/scx_qmap.bpf.c               |  23 -----
 tools/sched_ext/scx_simple.c                 |   2 +
 10 files changed, 110 insertions(+), 83 deletions(-)

Changes in v2:
 - Squash all changes into one patch
 - Link to v1: https://lore.kernel.org/all/20250723120746.52847-1-yphbchou0911@gmail.com/

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
diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
index 1dc76bd84296..b3c6372bcf81 100644
--- a/tools/sched_ext/include/scx/common.h
+++ b/tools/sched_ext/include/scx/common.h
@@ -75,8 +75,9 @@ typedef int64_t s64;
 #include "enums.h"
 
 /* not available when building kernel tools/sched_ext */
-#if __has_include(<lib/sdt_task.h>)
-#include <lib/sdt_task.h>
+#if __has_include(<lib/sdt_task_defs.h>)
+#include "bpf_arena_common.h"
+#include <lib/sdt_task_defs.h>
 #endif
 
 #endif	/* __SCHED_EXT_COMMON_H */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556..36e0cd2fd4ed 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -38,6 +38,7 @@ void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__i
 void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
@@ -82,6 +83,10 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
 	  false))
 
+#define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
+	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
+	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
+
 #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
 	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
 
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 66f856640ee7..399697fa372f 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -10,55 +10,11 @@
 #ifndef __USER_EXIT_INFO_H
 #define __USER_EXIT_INFO_H
 
-#ifdef LSP
-#define __bpf__
-#include "../vmlinux.h"
-#endif
-
-enum uei_sizes {
-	UEI_REASON_LEN		= 128,
-	UEI_MSG_LEN		= 1024,
-	UEI_DUMP_DFL_LEN	= 32768,
-};
-
-struct user_exit_info {
-	int		kind;
-	s64		exit_code;
-	char		reason[UEI_REASON_LEN];
-	char		msg[UEI_MSG_LEN];
-};
-
-#ifdef __bpf__
-
-#ifndef LSP
-#include "vmlinux.h"
-#endif
-#include <bpf/bpf_core_read.h>
-
-#define UEI_DEFINE(__name)							\
-	char RESIZABLE_ARRAY(data, __name##_dump);				\
-	const volatile u32 __name##_dump_len;					\
-	struct user_exit_info __name SEC(".data")
-
-#define UEI_RECORD(__uei_name, __ei) ({						\
-	bpf_probe_read_kernel_str(__uei_name.reason,				\
-				  sizeof(__uei_name.reason), (__ei)->reason);	\
-	bpf_probe_read_kernel_str(__uei_name.msg,				\
-				  sizeof(__uei_name.msg), (__ei)->msg);		\
-	bpf_probe_read_kernel_str(__uei_name##_dump,				\
-				  __uei_name##_dump_len, (__ei)->dump);		\
-	if (bpf_core_field_exists((__ei)->exit_code))				\
-		__uei_name.exit_code = (__ei)->exit_code;			\
-	/* use __sync to force memory barrier */				\
-	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
-				    (__ei)->kind);				\
-})
-
-#else	/* !__bpf__ */
-
 #include <stdio.h>
 #include <stdbool.h>
 
+#include "user_exit_info_common.h"
+
 /* no need to call the following explicitly if SCX_OPS_LOAD() is used */
 #define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({					\
 	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN;	\
@@ -114,5 +70,4 @@ enum uei_ecode_mask {
 
 #define UEI_ECODE_RESTART(__ecode)	(UEI_ECODE_SYS_ACT((__ecode)) == SCX_ECODE_ACT_RESTART)
 
-#endif	/* __bpf__ */
 #endif	/* __USER_EXIT_INFO_H */
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 50bc1737c167..55df8b798865 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * A central FIFO sched_ext scheduler which demonstrates the followings:
+ * A central FIFO sched_ext scheduler which demonstrates the following:
  *
  * a. Making all scheduling decisions from one CPU:
  *
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 6ba6e610eeaa..55931a4cd71c 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -61,6 +61,7 @@ int main(int argc, char **argv)
 	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
+	assert(skel->rodata->nr_cpu_ids > 0);
 	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
 
 	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fdc7170639e6..2c720e3ecad5 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -950,5 +950,5 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
 	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
-	       .flags			= SCX_OPS_ENQ_EXITING,
+	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 6dd423eeb4ff..cd85eb401179 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -6,6 +6,7 @@
  */
 #include <stdio.h>
 #include <signal.h>
+#include <assert.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <limits.h>
@@ -137,6 +138,7 @@ int main(int argc, char **argv)
 	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
 
 	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	assert(skel->rodata->nr_cpus > 0);
 	skel->rodata->cgrp_slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
 	while ((opt = getopt(argc, argv, "s:i:dfvh")) != -1) {
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 69d877501cb7..c3cd9a17d48e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -615,26 +615,6 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
 		     taskc->force_local, taskc->core_sched_seq);
 }
 
-s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
-{
-	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
-		   cgrp->kn->id, args->weight, args->bw_period_us,
-		   args->bw_quota_us, args->bw_burst_us);
-	return 0;
-}
-
-void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
-{
-	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
-}
-
-void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
-		    u64 period_us, u64 quota_us, u64 burst_us)
-{
-	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
-		   period_us, quota_us, burst_us);
-}
-
 /*
  * Print out the online and possible CPU map using bpf_printk() as a
  * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
@@ -860,9 +840,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
 	       .dump_task		= (void *)qmap_dump_task,
-	       .cgroup_init		= (void *)qmap_cgroup_init,
-	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
-	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 76d83199545c..06d4b13bf76b 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
+#include <assert.h>
 #include <libgen.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
@@ -41,6 +42,7 @@ static void sigint_handler(int simple)
 static void read_stats(struct scx_simple *skel, __u64 *stats)
 {
 	int nr_cpus = libbpf_num_possible_cpus();
+	assert(nr_cpus > 0);
 	__u64 cnts[2][nr_cpus];
 	__u32 idx;
 
-- 
2.48.1

