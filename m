Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DD395ADD
	for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462544; cv=none; b=tSkdPhYhkHXwyihF+x8h3rXj+yh/oUlS/pH+4R7EWT68foryN2wV5ExR2G2/VBJ+dgtWrqQL4lAsKd28KPUBgfr2uMVhjZiCoSh1kA5wLkZ3Zgk3fEnj4nx9ItDL6+jMsx3F4dA2sBwFNjNKTQMPjRsTyTJIr5LF97eSWmH1WkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462544; c=relaxed/simple;
	bh=bvbZOa+pI6bktDnH6DHO7bYVkxST9iPVANHv1h3WyZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAARQ6jT5QCF1cOjU8kX9xa0HVbLA91xnqWVJJ7leWgC1HvMOTy+f0aV3FgxzR9EqG8E88aUzgeUc0GNWgIZZ7WKQgO7E0rtHKe+dPj7THModY741FK808y7br/ur4fAjLC5SbKcWkHyG+gME1mVlcOtlMPw1A8X3rqpCNkJi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+e5RkHp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+e5RkHp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d0407aedd6so792075ad.0
        for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462542; x=1787067342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U2HdHkSW5AxpRW0WCfKQRt0nOrYP/Luw+WazkPMWsWk=;
        b=c+e5RkHp25cwpQ2Cln8L8LhPHzvr8GcscmzSsO8FaL9RKPzL+VrdsrQkKY3G1qBUSw
         bqTkFGkNIhl0i0pMrIsAdLyGwOUe8zstgWsHHW5gjsDs1NuEwA66mO1pOULXjG0c2+NH
         GzaztecRyiBZJSxKm0L14ydIcFdsH+rujBRt5FXV9LRjComz7NUQ/fcUmNTuk6crt2eL
         UJejuLE0b6W4WJsvV3Ef23P/4iH9c59ehwjNfN/ABPT1R3uGljOn16myxWV//j5bYCKr
         MSq/M7/+JjE5kqkLADkpV7NnAdKM+4WCm2tFp8WXZbu+oe3eUURF8LyKDAz963Keorzu
         oSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462542; x=1787067342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2HdHkSW5AxpRW0WCfKQRt0nOrYP/Luw+WazkPMWsWk=;
        b=rsxuGPFF8BTxoZoCE013QbTBKQFjroAatE3SCQAlgY/nhdx/RgNPUsKnd325+Fokzt
         dCWjEcn88DjrYsD5p2CzZ9VSG0SxEeYTL4jTNbpLGZV6uTpnBeweY1CTHA740opj8GgR
         D6gQQ3j3G/UtbNWGaa7UJwAKnsEcVTT7/0dxqcPr2GMo/Ey8NhpbdG510NT6OlytvHiK
         9frvz0Y2yyyUj/WQXFmk2f1ylhAPAcKs/muvLfyUp09q0+ps6Ag4oKViguaowOm2iT3s
         TQiptUcWImNIRMg8ZY6I9AXS61gDfE/UX0dKN9aZOomgbUA8JviuWyZLTNu2XXiZZpP5
         Muxg==
X-Gm-Message-State: AOJu0Yw0uNKtU6uDfn8vn5I5tHOvjrd4CPSrNlLNNP1Hr0fS3hXUS0Zy
	VIuF3jYUk0rIvvBbWYkq2J3PEZaZs07iIVHWtg1Rp6GW1Ty08ftAKzECH0dcaA==
X-Gm-Gg: AR+sD11cRrMaqBHQ09tPBLnFs4QzQGmmc+gFLQeIK4c+f1QYVUFPU5aBeCOLJmnnoSK
	GzL/WOJdS7B2o/Ty0atTvbiq+3StTVqn1/FGyRSclE/Qm4QDDMslITcizzbTB4OoCJxGZBsvmSs
	r7Swh1cEK2yYT4K4EMi/z/4qfTdWENW1dmKnI6xZViASM+gBlq0xnYl4E7Fr2wAtVl3wOb3iqSB
	YRRnuHzYEqod0pu/Pncl+Rkv8Kqa5SdE8F+G/rEVGhuZbxzbFqqa0XLdflUWwKEGi5p2kiB6OeT
	uGuP8ro/YfdIpGAQmgRpk1JIqUpmTiR9X9hhtcrNCIRp6A4eFWWqH0BlOiVcoV05T9nyCzMJztk
	jEE8zgBk4ngZquio7jfqlreWDaZj2NdaHRR/U50uIE22TounwY1wzveotwctStMpL5LFutxO/v2
	wPr3mLxV1Q8Tq/+l/JKOtpPeMgX+VB3myOwsI/tm52rZSJZQQRhBoZVWzllS+0u392Qs7fqd73N
	WPsKerr0TsVpZ4BSlQDGFUGEQvnzc6FHM83MFF5KMBUZrtTHgIeI8h2Vua+cnaKPpGNcWujLIDc
	IBA5
X-Received: by 2002:a17:90b:57d0:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-392ec329818mr5002508a91.5.1786462542020;
        Tue, 11 Aug 2026 08:35:42 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (1-164-82-213.dynamic-ip.hinet.net. [1.164.82.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8913165sm57619a91.14.2026.08.11.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:35:41 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext/for-7.3] selftests/sched_ext: Make numa idle validation race-free
Date: Tue, 11 Aug 2026 23:35:01 +0800
Message-ID: <20260811153524.6616-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU returned by scx_bpf_pick_idle_cpu_node() can be re-advertised as
idle by an idle-to-idle re-pick before the BPF program validates the
selection, and the scx_bpf_pick_any_cpu_node() fallback doesn't claim
the CPU at all. Asserting that the picked CPU is absent from the node's
idle cpumask is therefore inherently racy.

Follow the same approach as commit 12da4723b679 ("selftests/sched_ext:
Make allowed_cpus idle validation race-free") and validate a stable
local invariant instead: a CPU executing ops.select_cpu() in a non-idle
scheduling context must not be advertised as idle in its node's idle
cpumask. Keep the node-membership validation of the picked CPU, which
is stable.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/numa.bpf.c | 28 +++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index 6b4515c28aa0..679b51d38089 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -19,16 +19,31 @@ UEI_DEFINE(uei);
 
 const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_NODE;
 
-static bool is_cpu_idle(s32 cpu, int node)
+static void validate_local_idle_state(void)
 {
 	const struct cpumask *idle_cpumask;
-	bool idle;
+	struct task_struct *curr;
+	s32 cpu = bpf_get_smp_processor_id();
+	int node = __COMPAT_scx_bpf_cpu_node(cpu);
+	bool cpu_is_idle, curr_is_idle;
+
+	bpf_rcu_read_lock();
+	curr = scx_bpf_cpu_curr(cpu);
+	curr_is_idle = curr && (curr->flags & PF_IDLE);
+	bpf_rcu_read_unlock();
 
 	idle_cpumask = __COMPAT_scx_bpf_get_idle_cpumask_node(node);
-	idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
+	cpu_is_idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
 	scx_bpf_put_cpumask(idle_cpumask);
 
-	return idle;
+	/*
+	 * Unlike a remote picked CPU, the local CPU cannot go through an
+	 * idle re-pick while this callback is running. If it is running a
+	 * non-idle scheduling context, it must not be advertised as idle
+	 * in its node's idle cpumask.
+	 */
+	if (!curr_is_idle && cpu_is_idle)
+		scx_bpf_error("running CPU %d should be marked as busy", cpu);
 }
 
 s32 BPF_STRUCT_OPS(numa_select_cpu,
@@ -38,6 +53,8 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 	int node = __COMPAT_scx_bpf_cpu_node(task_cpu);
 	s32 cpu;
 
+	validate_local_idle_state();
+
 	/*
 	 * We could just use __COMPAT_scx_bpf_pick_any_cpu_node() here,
 	 * since it already tries to pick an idle CPU within the node
@@ -59,9 +76,6 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 	if (cpu < 0 && !bpf_cpumask_test_cpu(task_cpu, p->cpus_ptr))
 		return prev_cpu;
 
-	if (is_cpu_idle(cpu, node))
-		scx_bpf_error("CPU %d should be marked as busy", cpu);
-
 	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
 		scx_bpf_error("CPU %d should be in node %d", cpu, node);
 
-- 
2.43.0

