Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60D432BEE
	for <sched-ext@lists.linux.dev>; Thu, 23 Jul 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800819; cv=none; b=e0SbvCn/aUyA8/IpzMZKun6PPoGgtTkN3zybwQKx5ZNuX/R6rPEofQBllF+sYFfkUO/8WKt2uYyBLn9FYkmh2RYANU3D1zUvuwtFeibFSpbleu/iycpfa3RRrx6O8KzXgdJNZ5E6VBQmkxeiwrzK4uC0S2S2ENArEDARyRj6kIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800819; c=relaxed/simple;
	bh=JJ4ADESycWpAJrtKtP4EarjSeTRD2hvpYuqdUvN7ww0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KuaKx8OpaodqtmsBsxJh/wKgYxzOca+5l4j+GRh6JM3ZOcF1AKLOTfdBr/+IDqyf+1oD4bJb5oi2Hy3YDe+awIEqVvNZRBH7kwYGQHvEcOJXQFXwYyuYaEqk4S+9MTUCQIqa8bG0OPccb6dmK3nPSjBByisolgvrU2+4liNjOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRx786lo; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRx786lo"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so4123465e9.3
        for <sched-ext@lists.linux.dev>; Thu, 23 Jul 2026 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784800816; x=1785405616; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKxBAqWAIB0Dm6g/9qu+W8Gnm70FoQBMtCNd2PvBBII=;
        b=LRx786lo3VGTCcyByUdh5PMnp/uzZbMs8RUIbMUxCpxBDVUF4RK2/DXb7mVPFde/QO
         zvh3j9rvnagR9LB1egWZEu81uFLSWhnhU/XQLcH4CrfmKmLsjzEPcmFx3kIEV8FpRfRt
         wifjeZiqyUt0DFSim9KLx9DLJQgGV/0j8QuAFWPovw0228jneyLAfMa8EmMwwntqJ9GZ
         RWlvtzdAJq/pkBVeSrgXodoTldMObJ4nab10qmxRVUKE1/4gDXTM+bYLHKfjxbTfTCDz
         4W4O1W3tSeLhOCZnbKmtRwGKTtZn3Mlafeqml10HJgAkRnjy/N6xXRlJABMag+hDtjRW
         +cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800816; x=1785405616;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKxBAqWAIB0Dm6g/9qu+W8Gnm70FoQBMtCNd2PvBBII=;
        b=Waxa7/vdbkvPTMlaVhbLXf2K50kPkII6aY9zkE8vRvKENHfiofT2A8z1c86iVG6znX
         blZhvH3ydaLhD7OR+ihstOxBL4pkV9ApUn01jmd0UdWyBLSLRSzHNcD3Mu1/3wQwhHd/
         EYc0hMjfbKLZsLCysWl9WlFGWiOhvtr//4XENcP11u89aeH9v6pC7RE3RMJA4YCHyRAE
         FgIzgPsq5uPlVyqFB1fvapigJKlEU0apB2ZbwbqZMv6lL7KJGJuueKJe4N0YDnq3r+DL
         gaENdujsnh+Gb3zq+E4TvejLkSrzro5mIwAQwHK7usvEjXvRxia+25zMd6Ykkrvl1vI8
         sA0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp1uC4vZrXSiEhNRKE96208w9hvyiPoJcHxIKyXCIoxXIW46NqpPGFV1Xs/uO2hY6WIGxu2pDEmCdQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YycMfUzByoDGG9JSm3V8iR0rytHXaQ8Fh8VTP2cMuvMdtIddKkt
	1rU2wrsZke/7UlsQo9/fjsuvGNtFPz6SwttaqrjN3TGV+f+9IX5xxcoJsSNURFnhmzfddND3795
	dVaaXhvox75OXEA==
X-Received: from wmpr21.prod.google.com ([2002:a05:600c:3215:b0:493:d3c4:6a28])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c091:b0:495:636b:e519 with SMTP id 5b1f17b1804b1-49573cfd67cmr25196765e9.21.1784800815871;
 Thu, 23 Jul 2026 03:00:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:59:55 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723095955.1415621-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Handle sleeping
 task affinity changes in numa test
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

When a sleeping task's affinity is changed, task_cpu(p) can be outside
of p->cpus_ptr until after select_task_rq() selects a new runqueue for
the task during wakeup.

Thus, the task's NUMA node determined by numa_select_cpu() can be
completely outside of the task's cpumask, leading to
scx_pick_{idle,any}_cpu_node() failing to find an eligible CPU and
returning -EBUSY. This leads to the numa.bpf.c scheduler abnormally
exiting with the following message in dmesg:

sched_ext: numa: invalid CPU -16
   scx_bpf_cpu_node+0x120/0x190
   bpf_prog_0a34b8e0f515771f_numa_select_cpu+0x108/0x14e
   bpf__sched_ext_ops_select_cpu+0x4f/0xb4
   select_task_rq_scx+0xb0/0x210
   select_task_rq+0xa0/0xd0
   __try_to_wake_up+0x196/0x650
   complete_all+0x76/0x100
   migration_cpu_stop+0x22b/0x300
   cpu_stopper_thread+0xc1/0x180
   smpboot_thread_fn+0x16b/0x230
   kthread+0x2d7/0x350
   ret_from_fork+0x1c2/0x350
   ret_from_fork_asm+0x1a/0x30

Make numa_select_cpu() robust against this case by returning @prev_cpu
if no CPU could be found in the selected NUMA node _and_ we have reason
to believe that the task's affinity was changed while it was sleeping.

Fixes: 5ae5161820e5 ("selftests/sched_ext: Add NUMA-aware scheduler test")

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/numa.bpf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index 78cc49a7f9a6..6b4515c28aa0 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -34,7 +34,8 @@ static bool is_cpu_idle(s32 cpu, int node)
 s32 BPF_STRUCT_OPS(numa_select_cpu,
 		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	int node = __COMPAT_scx_bpf_cpu_node(scx_bpf_task_cpu(p));
+	s32 task_cpu = scx_bpf_task_cpu(p);
+	int node = __COMPAT_scx_bpf_cpu_node(task_cpu);
 	s32 cpu;
 
 	/*
@@ -48,6 +49,16 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
 						__COMPAT_SCX_PICK_IDLE_IN_NODE);
 
+	/*
+	 * @task_cpu may be outside of p->cpus_ptr if @p's affinity
+	 * changed while it was sleeping. This means it's possible for
+	 * p->cpus_ptr to not include any CPUs from @node.
+	 * If we failed to find a cpu in @node, check if @task_cpu
+	 * is outside of p->cpus_ptr and just return @prev_cpu if it is.
+	 */
+	if (cpu < 0 && !bpf_cpumask_test_cpu(task_cpu, p->cpus_ptr))
+		return prev_cpu;
+
 	if (is_cpu_idle(cpu, node))
 		scx_bpf_error("CPU %d should be marked as busy", cpu);
 
-- 
2.55.0.229.g6434b31f56-goog

