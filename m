Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794755503;
	b=nzSXDiQwwQs6JKYEs3OqW/U8zgoSQIKTbYDiXOHRvVipxLcQlI3LEuDI5f6sFFK5a1zF
	 dXQ/Li7SJBf35jK++WJdb6U6X3MPKxIEWtFjMHiW6ErCsXVaIk3F0t9+4Dg7FWjUTBcbS
	 o6CBI0eiY6ugHQgHWd/b4uohIUyobHCaBp2ZGJR2X+TWZ+MnhX3BpSWgItVLDPSOWjMRO
	 Sd2ztLzsIWDJJeQFUX+8PH0n/+5A95VFPQHzCHmWk2scrVGqO035gXYu2C+/9jeIPcr0P
	 dNvFosJU/dUnuWptetRL4iCBbOiCIdZJ18lGQifdlpR/XFuZ4zgO07WSZPPyHTC6SQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755503;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dBDaQS3YuLlX9/tz/mx6HVXCXKV6gxoWF0rGHwlM5YI=;
	b=SFXNbHl9H+zTsGspIXhfRKgazvJcw23bTyFFqJasYatZ0aeO4qNawXiTwM8Mfs5AJ0dV
	 g7nK7Xa0nF1KjUXXsKFw0bGGaQkiFdW422KqI/pBysyXNJ3jqidX0S6F2x9hz9mOGKJIv
	 iBKnKe9Lkha+UbOVKoStvs2iBo8NAA2ucC6Z14pRo4YdKyUrp6rAOiAcstIztRFW31DNs
	 qGnhfQpL76OCuhAOFy701SsuyTo4VCApqc0zK6u0MidsVQ3S64fhRGjyIR6oe3G2DsJtE
	 P+2fYviI4sQkfCnDwZr4K+BzVdM71zOjfed6KON1izZ/2B/jqAcij2q46vFLKiOQM9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsHGoUuF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05F606A31A;
	Sun, 15 Nov 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsHGoUuF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794755503;
	b=NHHDzq/shpWBopJoQoXZLRIVvH8gns62d6vVFMnG/I1reTMTSWJtDzsDEwCZyN1r7Vnn
	 wB7ZFLUyYQL/iaLmt1jc7gIZFoCkOhnE2By8NrEir58fbzqcsCQfznZrgUf9xTBncB2E3
	 JCAynMI6n4GmDQ1DwsHA9RQsmtaZtp5jt3a18Gh5hbYK390yVv+ErqXPJZW9d9Wr5hfiZ
	 mEQFWLYcNVgtyxvqyntUTvmgp51nrfg8G9iYV10nI2qIOuU8LbVr0s1p/CiEF3tFb7tfF
	 alDu0Li6owV5LYjAYDuHS976zMeFQ3wXGxo2zTbs3e3YQbY5JByPGc+ntnefaxh6URg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794755503;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dBDaQS3YuLlX9/tz/mx6HVXCXKV6gxoWF0rGHwlM5YI=;
	b=ruqUUwoNFxbV4aB7jxfnXaKaXMlcHKytN7MFc7O2BQi7PJUYmvTzFrzp/8kVo20B697K
	 dPQ7J8MiuSFUZOogH+FX3KIfCkPEy1kldZsxC5sptTxga5RWs06xZQoVPjdQqy3j42f2U
	 tfOqO11CWo9om3geaz6fUx9L4Uax13ww6MJ94LYtyWh4efz7AQqAMvRb+yXxrc67mV1KN
	 e8o1AtAkVuJI8LYwpdw01xDV83fK0VTpnTyWdSfFVJMPM+oMs8jpJu7l7VE7GH5b6BQNv
	 Kpzv28Qpy5hLUeaJdeern9r9W4EwkrpM88EIR4IH2jZVIx79+Sbls2wCGda2vDzLKZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7E67E1F000C4;
	Sun, 15 Nov 2026 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755503;
	bh=dBDaQS3YuLlX9/tz/mx6HVXCXKV6gxoWF0rGHwlM5YI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KsHGoUuFwj/bRhnc2pJL7CUBLID48MJC6ObuEhId8S6U86g6jl++nzLEeSbOiXQ5n
	 2c/zkAAtch77JeT4hzBCX4D9zo5pwrLEJTnTosa0PJ4unXe0E2gGp7KU59a9f+qWPk
	 xZ/c06tM/1YKT01TYEaa1MQ8XdwFPUUcb366XRl2y1RV0b23L1hzfrPJhQiaSJxHEa
	 T4MISUDroKCyJRkkL8nd/YmjBvIvVE5dR5JcIx9oIoq6F2ZU+GKtRGCvrXGk/weVad
	 mEkG7xZW3q1A+/BVclPQYqBlMVWiXjK4kaJXX+aC+fwRl4A55y8vvFBGnhdwciIj3c
	 13b2gypQv35ug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D32CB4A0EB;
	Sun, 15 Nov 2026 15:11:41 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 22:11:23 +0700
Subject: [PATCH sched_ext for-7.4-fixes v2] selftests/sched_ext: Fix flaky
 rt_stall measurement
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-scx-rt-stall-v2-1-926678b214c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NTQqDMBBGryKz7ohjg0m76j2KlGmMOqBNSYJYx
 Ls32G2Xj+/nbRBdEBfhWmwQ3CJR/CtDfSrAjvwaHEqXGeqqbohIYbQrhoQx8TShZdKNZsNP1UO
 evIPrZT3u7hDt6LqHW1PR+4C6VPjL2lwcJSYfPod2oaP+37AQEioyhi9nbapG34aZZSqtn6Hd9
 /0LK0V5WcEAAAA=
X-Change-ID: 20261114-scx-rt-stall-ca1767a8ab4f
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794755501; l=6833;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=FSo+4bW4QOIKlFrjYLYQ3EtTSbBrBmlB/68VUcbr1ss=;
 b=FceagnOTWXvzpQtn0WkIGjrgs071OsTsoevYM6tFcOJ4Ll77863C5RVLidcQjy1bR++6XXhUB
 ZqRnRl+ax0IABPOOhk5TBswMIfOlQCyOYEm4VSKgaUeZZdjt8ZGa5EP
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

In sched_stress_test(), the DL server budget on CORE_ID is shared with
other FAIR/EXT tasks, including the parent task when unpinned. The
parent can also be slow to start as it has to wait for the DL server
before reaching sleep() while the RT task still runs. The runtime of
each task is read as a total since fork instead of during sleep() and
is measured in USER_HZ units (10ms). These 3 factors skew the ratio and
cause CI flakes. An EXT task got as little as ~0.18s on CI, which is a
3.0-3.9% share against a minimum 4%.

With the parent pinned to CORE_ID, the RT task had already run for
~0.95s before sleep(), so it was measured at 5.69s in a 5s window and
the EXT share dropped to ~4.2% against the 4% threshold.

Measure CPU time using per-task CPU clocks via clock_getcpuclockid()
with deltas before and after sleep to get an accurate measurement
window while also pinning the parent off CORE_ID. With the parent
pinned to another CPU, RT measures ~4.75s and EXT share stays between
4.86% and 5.10% over 20 runs.

Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
Link: https://github.com/kernel-patches/vmtest/issues/458
Suggested-by: Andrea Righi <arighi@nvidia.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
Changes in v2:
- Read CPU time with clock_getcpuclockid() and clock_gettime() instead of
  /proc/<pid>/stat to avoid USER_HZ rounding (Andrea)
- Pin parent off CORE_ID so it doesn't share DL server budget (Andrea)
- Threshold unchanged: 4.86-5.10% over 20 runs, but was unable to 
  reproduce kthreads noise similar to CI, happy to lower threshold to 3%
  if needed
- Link to v1: https://lore.kernel.org/r/20261114-scx-rt-stall-v1-1-4188a9378067@gmail.com
---
 tools/testing/selftests/sched_ext/rt_stall.c | 88 ++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index a1552b38a6e8..c5027fd6b682 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -21,6 +21,9 @@
 #define CORE_ID		0	/* CPU to pin tasks to */
 #define RUN_TIME        5	/* How long to run the test in seconds */
 
+static cpu_set_t old_mask;
+static bool affinity_saved;
+
 /* Signal the parent that setup is complete by writing to a pipe */
 static void signal_ready(int fd)
 {
@@ -82,43 +85,57 @@ static void set_sched(int policy, int priority)
 	}
 }
 
-/* Get process runtime from /proc/<pid>/stat */
+/* Get process runtime from CPU clock */
 static float get_process_runtime(int pid)
 {
-	char path[256];
-	FILE *file;
-	long utime, stime;
-	int fields;
-
-	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
-	file = fopen(path, "r");
-	if (file == NULL) {
-		perror("Failed to open stat file");
+	clockid_t clk;
+	struct timespec ts;
+	int err;
+
+	err = clock_getcpuclockid(pid, &clk);
+	if (err) {
+		fprintf(stderr, "Failed to get clock ID: %s\n", strerror(err));
+		return -1;
+	}
+
+	if (clock_gettime(clk, &ts) == -1) {
+		perror("Failed to get clock time");
 		return -1;
 	}
 
-	/* Skip the first 13 fields and read the 14th and 15th */
-	fields = fscanf(file,
-			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
-			&utime, &stime);
-	fclose(file);
+	return ts.tv_sec + ts.tv_nsec / 1e9;
+}
 
-	if (fields != 2) {
-		fprintf(stderr, "Failed to read stat file\n");
+/* Move parent off of CORE_ID so it doesn't share DL server budget */
+static int pin_parent_off_core(void)
+{
+	if (sched_getaffinity(0, sizeof(old_mask), &old_mask) != 0) {
+		perror("sched_getaffinity");
 		return -1;
 	}
 
-	/* Calculate the total time spent in the process */
-	long total_time = utime + stime;
-	long ticks_per_second = sysconf(_SC_CLK_TCK);
-	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+	for (int cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &old_mask) && cpu != CORE_ID) {
+			cpu_set_t mask;
+
+			CPU_ZERO(&mask);
+			CPU_SET(cpu, &mask);
+			if (sched_setaffinity(0, sizeof(mask), &mask)) {
+				perror("sched_setaffinity");
+				return -1;
+			}
+			affinity_saved = true;
+			return 0;
+		}
+	}
 
-	return runtime_seconds;
+	return 1; /* No other CPU available */
 }
 
 static enum scx_test_status setup(void **ctx)
 {
 	struct rt_stall *skel;
+	int err;
 
 	if (!__COMPAT_struct_has_field("rq", "ext_server")) {
 		fprintf(stderr, "SKIP: ext DL server not supported\n");
@@ -132,6 +149,9 @@ static enum scx_test_status setup(void **ctx)
 
 	*ctx = skel;
 
+	err = pin_parent_off_core();
+	SCX_FAIL_IF(err == -1, "Failed to pin parent CPU");
+
 	return SCX_TEST_PASS;
 }
 
@@ -149,7 +169,7 @@ static bool sched_stress_test(bool is_ext)
 	const float expected_min_ratio = 0.04; /* 4% */
 	const char *class_str = is_ext ? "EXT" : "FAIR";
 
-	float ext_runtime, rt_runtime, actual_ratio;
+	float ext_runtime_start, rt_runtime_start, ext_runtime, rt_runtime, actual_ratio;
 	int ext_pid, rt_pid;
 	int ext_ready[2], rt_ready[2];
 	bool ret = false;
@@ -201,6 +221,23 @@ static bool sched_stress_test(bool is_ext)
 	if (!wait_ready(ext_ready[0]) || !wait_ready(rt_ready[0]))
 		goto out_kill;
 
+	/*
+	 * The parent can be delayed before reaching sleep(). Record each task's
+	 * CPU time right before calling sleep() so only time used during the
+	 * measurement window is counted.
+	 */
+	ext_runtime_start = get_process_runtime(ext_pid);
+	if (ext_runtime_start == -1) {
+		fprintf(stderr, "Failed to read %s task runtime\n", class_str);
+		goto out_kill;
+	}
+
+	rt_runtime_start = get_process_runtime(rt_pid);
+	if (rt_runtime_start == -1) {
+		fprintf(stderr, "Failed to read RT task runtime\n");
+		goto out_kill;
+	}
+
 	/* Let the processes run for the specified time */
 	sleep(RUN_TIME);
 
@@ -218,6 +255,8 @@ static bool sched_stress_test(bool is_ext)
 		goto out_kill;
 	}
 
+	ext_runtime = ext_runtime - ext_runtime_start;
+	rt_runtime = rt_runtime - rt_runtime_start;
 	/* Verify that the scx task got enough runtime */
 	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
 	fprintf(stderr, "%s task ran %.3fs, RT task ran %.3fs (%.2f%% of runtime)\n",
@@ -284,6 +323,9 @@ static void cleanup(void *ctx)
 {
 	struct rt_stall *skel = ctx;
 
+	if (affinity_saved)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+
 	rt_stall__destroy(skel);
 }
 

---
base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
change-id: 20261114-scx-rt-stall-ca1767a8ab4f

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


