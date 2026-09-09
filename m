Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6756C64A
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965578; cv=pass; b=KdgFlwpoCH+WSurYcGcgTFGxVk4hwfZLSzNCBy+HOrwV66hNctuSjMuh3IFznn56lJrO8YsWBdUZv1FhbP3zc1f2t1/DwOzXMo5Qfc0SlO6dVguziIkKsZ8AYpwpphVs3hLKd4emgDeLeNT2fZFPZx9GEV93Hnk+zc8P9wZkZk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965578; c=relaxed/simple;
	bh=IvuVgXtzg+PW3WsJyb8eWnV+a5ycZtkTPhA0W31/AqE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sJ7acnYGrstUmTAIREhVnaEdU5EmpC+U1He3WkAFais49sxg3alYyVdZkToDocC5Q7WqhEIM0o4l77RhV5LMPd12NbAy2wTPxIu2XRZGsYDKmgWKoq2uFGHZlQWNflDOjU3YhTdUNBlX+OX4EscsrQqxGg03YvQNK0MRlOnCCfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egeh8z+5; arc=pass smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egeh8z+5"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66fd0af9eb0so1372249d50.0
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 07:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965573; cv=none;
        d=google.com; s=arc-20260327;
        b=KtBIXE+2TVfEwR3dhaAqwJyVAB3lOB/qQROrKwbwoCSjnjfu4OoLdinAVO0iZUPK/D
         8KDrHsYFn5+3LIA3lK/VQWsiOCFjjqnyDuj1fH8IZFym2PnRFZ3j0WmnJl+FC/mXlKz5
         3hgZT7gLn53gRc7iPc2hksNQu+T4s9CW6jCwPNbCjfGuWl3Ddkof2eG0tHJBWsbiMuKp
         udBlmeX6PuwCXW/WMlsZIw5HuHcpNIXDP+4yscolrI/BxVpuZ7kc6+sxjlzpspVOQj3D
         HSnuqDNogn8cjKm2/8yVDFAHC0LUcZhN0daCT4qVc/knhErSQOaWJ8UHSVpq8dGbn6S8
         Av2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RwJ9BaoNRw2XUxKdRuqOWTaCFPLrZEbkBSC1yAfl2n8=;
        fh=gAV7PT0E4mkBzphXICSgEQ3QZT6iVUM/OwbPpnlI4+M=;
        b=Y5YMHq9C4xw0HSq2OoIqTT059kXrHw5PX0OolQpXGHCL/ZKeKgRKm72jlmn1CWcIAJ
         m+4tcIyWkO10I+vCzf+NL9kiTga7/pJ76axEzh5MMyPYG8D6Qd5Nqu14q2uJJZKGNCg5
         Nw3ab1RFu9BCZ8GlPcegt+VXaoRfmrhnJpTHPGNtbSfvtYvweIOfaccnJuHZ+7Itn72o
         3O+jU4GLShJ+ks8F+JVaBOmFRTwXrqjUNGwkIT3+ouTeiIDtkBYeTFo3Ler74xcTTZU+
         +rCAy4G3y7KgqOjAIQeE1wYWsZvdM+WIXfR6uBQpW8IpmTe7CccaXaFsCOEdyrloAZHa
         2GCQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965573; x=1789570373; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RwJ9BaoNRw2XUxKdRuqOWTaCFPLrZEbkBSC1yAfl2n8=;
        b=Egeh8z+56tmedDEULJldu3MitvgCGeTQRgMjnGjvSHHuCCkQCrBM0bBwsxsv8vJV2K
         SWb0hOHHoIcpuHH2vnGPbI1DrKmDhWVGukLVB7rcej38pbvnPq463q5dOFZY/KSEBfgp
         0gUd1DK6BwfK27OjIucFIpcGPTAtZiL0EeilGCGSGbV3As+2UlSm0xWv2S/QASQybcs2
         lzd8ovYLGgJvfB7GD4U9KPvjEr9Ll3cCwnR0uhuaKtGxnsdr7SCxBeqzxK3ravpbrRwL
         KlmFqylgJUARHy0byIXUb/Yu/jcHxgUHqDwAv2e17q79w1aJgdc/i0CQ+I+TvtoKtRKT
         lrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965573; x=1789570373;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RwJ9BaoNRw2XUxKdRuqOWTaCFPLrZEbkBSC1yAfl2n8=;
        b=CG7ePU9soexg+bspnodsBdWwlwEJBoTmxZKbtYHnayvU1xVZ6bDIvdEc1MbVIUYaFA
         VSwkzY+bWEW+kUTsbUgD7NwKtuG0z0eA2n5K3YnZQq/WHxI/5XI002oV/0zJIaczadl8
         02ELcO/Tpt5kq05sqPLZfcExaxpQhyhM5iliMFV4qx5fBuF9uAbvrLzCn1AFOneQoq02
         OOKsCsZQ0vgYzjlw3cpsWT+Y/rSIxTC4QOb8bRO4BTxfoRkooRmSNHth0k0OtUx21Y4+
         Y/5NzLgX1gmNxCLZMkW+WgmsNysiisrHL7naGP11bspPotTQJCyHBw0zPNi8iGb+9qnn
         BNKw==
X-Forwarded-Encrypted: i=1; AKwUvBzlhrVY9u8jND58kV7m/fjLg/R9q46mlEhOknAUnMfaVE7pfXYQ90LCazal9qsHAEQasXtiWJLiVHI=@lists.linux.dev
X-Gm-Message-State: AFuF++mcX7ArUFxH/3t4CeHml9AIdu46d4aeSuU+8JclLPgIcY5sL7XH
	5qLABI3D3C5B5aQrNZMTzg0PaUdamj638r8Vbk+Gg5NqifmZje8eDvbJ7Uhwg+e/8Qjk3jb3Eaq
	5KGTe1pGAcGa8Bq4eNANYuCWusMOqc18=
X-Gm-Gg: AYBFou2mxsiSmR9jr6FSOGa89DKabQzfMyX3ydsV/QjVIKR0N6XYWFkmAG8ErH4gLGO
	puCdc1BqcEOgvw8T0V0e+c14vK0TihRj7V/c66Yn2g3zxTeskRiYLYeXCCUyegH4CZdg80I/Lfl
	0okTBECTtARbxVLMfdL1bZ0VlcFYt045sKTS0FSChThWuM20v36mEcQKNnvKE1NNshlF3S0iz04
	t/TnrZisoyV3UTCr8VntLfqZrvk+A23wDgS66T6LCfwcN6sX8dh5uYh69/TiHlUq1E9Btgm4adD
	qXw1gdUrXtp2+nBztXbgF5RsMRO9+gxxGK/cRGpFOLOM0JsS3NmtSQ==
X-Received: by 2002:a53:a44c:0:b0:66f:c1bc:402b with SMTP id
 956f58d0204a3-66fc1bc4611mr7449425d50.88.1788965573319; Wed, 09 Sep 2026
 07:52:53 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 07:52:52 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 07:52:52 -0700
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Tianyi Chen <diannaaav@gmail.com>
Date: Wed, 9 Sep 2026 07:52:52 -0700
X-Gm-Features: AcwNN1W1BAWoXddrkNiAeAET4QY2y25VwsVKw_MOPnWrmOuHsPqYEsTulYrFU6Y
Message-ID: <CACGbirQ-xfWymbY9Z440sjbUseLRuaPFT17mBAwddeN7wqVi-w@mail.gmail.com>
Subject: [PATCH v2 RESEND] selftests/sched_ext: Validate select_cpu_and mask constraints
To: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tianyi Chen <diannaaav@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Tianyi Chen <hi@tychen.cc>
Date: Sun, 06 Sep 2026 22:34:48 +0800

The syscall test only prints the CPU selection result after checking
whether BPF_PROG_TEST_RUN succeeds.

Require -EBUSY for empty and affinity-disjoint custom masks, and allow
a legal singleton candidate to be selected or busy. Reject unexpected
errors and selections outside the custom mask or configured affinity.
Check cpus_mask because migration disabling can temporarily narrow
cpus_ptr under CONFIG_PREEMPT_RCU.

Grow dynamically allocated affinity masks until sched_getaffinity()
succeeds, retaining that allocation size for pinning and restoration.
Restore affinity on all exits after pinning, and skip only the disjoint
case when fewer than two CPUs are allowed.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Resending from my Gmail address because delivery from my previous address
failed for the kernel.org and kernel mailing-list recipients. The patch
is unchanged from v2 and still applies to sched_ext/for-7.4.

Changes in v2:
- Check configured affinity through p->cpus_mask, avoiding temporary
  cpus_ptr narrowing when migration is disabled.
- Use zeroed, dynamically allocated affinity masks, retrying EINVAL with
  a larger size and handling restoration and cleanup on failure paths.
- Rebase onto sched_ext/for-7.4.

Validation:
- Build and allowed_cpus tests passed with CONFIG_PREEMPT_RCU, including
  single-CPU affinity and ten runs under load with preempt=full.
- A guest with 2048 possible CPUs and two online CPUs reproduced v1's
  EINVAL. V2 grew the mask from 128 to 256 bytes and passed with both
  full and single-CPU affinity.
- Injected affinity-read, pinning, restoration and BPF test-run errors
  exercised failure handling, including restoration after a BPF failure.
  Forced mask growth with malloc perturbation also passed.

v1: https://lore.kernel.org/r/20260906144029.848978-1-hi@tychen.cc
Review: https://lore.kernel.org/r/53d04980eecb0e5f6eeea25a5cf0dcf5@kernel.org

 .../selftests/sched_ext/allowed_cpus.bpf.c    |  24 +++-
 .../selftests/sched_ext/allowed_cpus.c        | 129 ++++++++++++++++--
 2 files changed, 135 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 9dd72d0da29..f14d7e5bef9 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -147,23 +147,41 @@ void BPF_STRUCT_OPS(allowed_cpus_exit, struct
scx_exit_info *ei)
 }

 struct task_cpu_arg {
-	pid_t pid;
+	u64 pid;
+	s64 custom_cpu;
 };

 SEC("syscall")
 int select_cpu_from_user(struct task_cpu_arg *input)
 {
 	struct task_struct *p;
-	int cpu;
+	struct bpf_cpumask *mask;
+	s32 cpu;

 	p = bpf_task_from_pid(input->pid);
 	if (!p)
 		return -EINVAL;

+	mask = bpf_cpumask_create();
+	if (!mask) {
+		bpf_task_release(p);
+		return -ENOMEM;
+	}
+
+	/* A negative custom_cpu leaves the custom mask empty. */
+	if (input->custom_cpu >= 0)
+		bpf_cpumask_set_cpu(input->custom_cpu, mask);
+
 	bpf_rcu_read_lock();
-	cpu = scx_bpf_select_cpu_and(p, bpf_get_smp_processor_id(), 0,
p->cpus_ptr, 0);
+	cpu = scx_bpf_select_cpu_and(p, bpf_get_smp_processor_id(), 0,
+				     cast_mask(mask), 0);
+	if (cpu >= 0 &&
+	    (!bpf_cpumask_test_cpu(cpu, cast_mask(mask)) ||
+	     !bpf_cpumask_test_cpu(cpu, &p->cpus_mask)))
+		cpu = -ERANGE;
 	bpf_rcu_read_unlock();

+	bpf_cpumask_release(mask);
 	bpf_task_release(p);

 	return cpu;
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c
b/tools/testing/selftests/sched_ext/allowed_cpus.c
index 093f285ab4b..773699d120e 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -2,7 +2,10 @@
 /*
  * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
  */
+#define _GNU_SOURCE
 #include <bpf/bpf.h>
+#include <limits.h>
+#include <sched.h>
 #include <scx/common.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -23,17 +26,19 @@ static enum scx_test_status setup(void **ctx)
 	return SCX_TEST_PASS;
 }

-static int test_select_cpu_from_user(const struct allowed_cpus *skel)
+static int test_select_cpu_from_user(const struct allowed_cpus *skel,
+				     const char *name, int custom_cpu,
+				     bool expect_busy)
 {
 	int fd, ret;
-	__u64 args[1];
+	__s32 cpu;
+	__u64 args[] = { getpid(), (__u64)(__s64)custom_cpu };

 	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
 	);

-	args[0] = getpid();
 	fd = bpf_program__fd(skel->progs.select_cpu_from_user);
 	if (fd < 0)
 		return fd;
@@ -42,29 +47,123 @@ static int test_select_cpu_from_user(const struct
allowed_cpus *skel)
 	if (ret < 0)
 		return ret;

-	fprintf(stderr, "%s: CPU %d\n", __func__, attr.retval);
+	/* test_run returns the signed BPF result through an unsigned field. */
+	cpu = (__s32)attr.retval;
+	if ((expect_busy && cpu != -EBUSY) ||
+	    (!expect_busy && cpu != -EBUSY && cpu != custom_cpu)) {
+		SCX_ERR("%s: unexpected CPU selection result %d", name, cpu);
+		return -EINVAL;
+	}

 	return 0;
 }

+/* Grow until the mask covers the kernel's CPU range, including
offline CPUs. */
+static int alloc_affinity(cpu_set_t **mask, size_t *size)
+{
+	int nr_cpus = CPU_SETSIZE;
+	cpu_set_t *cpus;
+	int err;
+
+	for (;;) {
+		*size = CPU_ALLOC_SIZE(nr_cpus);
+		cpus = CPU_ALLOC(nr_cpus);
+		if (!cpus)
+			return -ENOMEM;
+		CPU_ZERO_S(*size, cpus);
+		if (!sched_getaffinity(0, *size, cpus)) {
+			*mask = cpus;
+			return nr_cpus;
+		}
+		err = errno;
+		CPU_FREE(cpus);
+		if (err != EINVAL)
+			return -err;
+		if (nr_cpus > INT_MAX / 2)
+			return -EOVERFLOW;
+		nr_cpus *= 2;
+	}
+}
+
 static enum scx_test_status run(void *ctx)
 {
 	struct allowed_cpus *skel = ctx;
-	struct bpf_link *link;
+	enum scx_test_status status = SCX_TEST_FAIL;
+	cpu_set_t *original = NULL, *pinned = NULL;
+	bool affinity_changed = false;
+	size_t size;
+	int first = -1, second = -1, cpu, nr_cpus;
+	struct bpf_link *link = NULL;
+
+	nr_cpus = alloc_affinity(&original, &size);
+	if (nr_cpus < 0) {
+		SCX_ERR("Failed to get affinity (%d)", -nr_cpus);
+		goto out;
+	}
+	pinned = CPU_ALLOC(nr_cpus);
+	if (!pinned) {
+		SCX_ERR("Failed to allocate affinity mask");
+		goto out;
+	}
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (!CPU_ISSET_S(cpu, size, original))
+			continue;
+		if (first < 0) {
+			first = cpu;
+		} else {
+			second = cpu;
+			break;
+		}
+	}
+	if (first < 0) {
+		SCX_ERR("No CPU in affinity mask");
+		goto out;
+	}

 	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
-	SCX_FAIL_IF(!link, "Failed to attach scheduler");
-
-	/* Pick an idle CPU from user-space */
-	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
-
-	/* Just sleeping is fine, plenty of scheduling events happening */
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		goto out;
+	}
+
+	if (test_select_cpu_from_user(skel, "empty mask", -1, true))
+		goto out;
+
+	/* A legal candidate may be busy; selection need not succeed. */
+	if (test_select_cpu_from_user(skel, "legal candidate", first, false))
+		goto out;
+
+	if (second >= 0) {
+		CPU_ZERO_S(size, pinned);
+		CPU_SET_S(first, size, pinned);
+		if (sched_setaffinity(0, size, pinned)) {
+			SCX_ERR("Failed to pin task (%d)", errno);
+			goto out;
+		}
+		affinity_changed = true;
+		if (test_select_cpu_from_user(skel, "disjoint masks", second, true))
+			goto out;
+	} else {
+		fprintf(stderr, "Skipping disjoint masks: need two allowed CPUs\n");
+	}
+
+	/* Just sleeping is fine, plenty of scheduling events happening. */
 	sleep(1);
-
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly");
+		goto out;
+	}
+	status = SCX_TEST_PASS;
+
+out:
+	if (affinity_changed && sched_setaffinity(0, size, original)) {
+		SCX_ERR("Failed to restore affinity (%d)", errno);
+		status = SCX_TEST_FAIL;
+	}
 	bpf_link__destroy(link);
-
-	return SCX_TEST_PASS;
+	CPU_FREE(pinned);
+	CPU_FREE(original);
+	return status;
 }

 static void cleanup(void *ctx)
-- 
2.55.0
