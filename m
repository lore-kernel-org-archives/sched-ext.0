Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE463932D6
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078302; cv=none; b=gc7uouY+ryyMqwIwcf5x+nfoz85s1cVLONZoipItkQsYtZH2PJ7Genxk75oVVnBcFPe+ckEcx34yBw6ruAaQcz6iPcbiq5QABmhk0AqsZevm0v4K3ivPXMmy4u22n8RC/armdUH3wtIqf6KhDHl6WudI6cO0S7Mz9RXJt+PqP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078302; c=relaxed/simple;
	bh=xLJMTwgDJ6vF3NdH/OM/IUOdZGyd37vGtYLf99snYsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7SIrDTkL5seA3szsKjMjGyvgXrzs3oMoi1ULTD3wyylCRET3QV9LL/CbiiPHLEGoDIoL5dtHIRuVmCixwF6xyu/SgbWrkufc+KF3OgQcwfv3GTRAKH/en5Ri7fhRZ86/PqV1RBb8+3gRi3k9iKyiP2EvI1DvsJgh3WfmV9uEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOAEVlsg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOAEVlsg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2751144a12.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776078300; x=1776683100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1cbgaRb9eoOdyEuplUCaEAaSE29TmFZHSOZE4Dy31c=;
        b=ZOAEVlsgHN+3CHwOJPYtF3HE9LwYD5VqT5YJzIwRjKuOTxA501Ww+NAv9Ob9q/ntd1
         H7Khww7yni4DSDfMn6qr3VeF3PqoLg5DWM0diGtaC77z0iusagHS2HXN3DOiK8uYXc+1
         pnQnxweu1cX777COL+tbXKXRGgk9zeEum2mLNRc3MDDNYETzzGryM+vB8cGM0NMPcnwZ
         Jb3MQk5OEZquOb3RHtJ6ldGpltaZ11+/tfydYcnLVr+74x1gp+rXSa2UDYM0EKDkMOsj
         E7Y2C91kqsrHKKQKLeJAwHkjUFYuzlNwZtxp8uQJlhu92LoU4OGOrMB4V8Vi5sTj9HTz
         zimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078300; x=1776683100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1cbgaRb9eoOdyEuplUCaEAaSE29TmFZHSOZE4Dy31c=;
        b=mmUUiPnkkfmpQZe5ig9VRHuzIwcwlzX+gVH2CV+xRMMvB0vGrqa0cjGkpP2dj1eErK
         fS1z6YEfLN8DnlDF6XzHHY4YTDJpgDGz0sk3J7T6VYImrN1h3nA/DBlVg2gZ3Z7IJf6T
         HU3od3VM98aaos7r8jeO5i25Wtkp0BNvbbryQbbT4N2Bxn9Oq/WrIKIrnnmzuluZDpSM
         dDJUP1kk/hJozG5r7rh4fGEHP/T2xSP1LjmRTNFaIyqIcnYyRrsNoOcEp71lnV4nRkZM
         xR1bGyCfrvBvFxJ/K5A0BvRrRlTFlA8YxjRY/g9vxDl5AolomoCsGKuvmJ0u6pMIzU8T
         oR+Q==
X-Gm-Message-State: AOJu0Yzzq+XFFypdneM3ilV9eqpNMGZDrevbM4fp8NiA0H4eptm62tZM
	Gq9Arn/SCq1oz2lZCBy7EMNhiC9m1CHzJFmXtnw4deb/DQy302aeMgQhfUbIFA==
X-Gm-Gg: AeBDies26nkp91iBkzeE7vVdrqMHdisQDXSSiMk+Zx0D/ysJbR22BenyTO53lT4qw2O
	250gfg8WBphQeVrGnyjpEixDURMhLbN9QrAfAnJnrF6VbY6Zddrp9Dn3aWEhZiUjn7Ty/ZP3Yqz
	US0m/BBX1pO9qVwKVLQ5IdnRFjgZCKWOTPAlj8IxpNNB5kXlU5uwepSqdH14Z3OZhPq13y50WlW
	119WImZqk5EU7hPEs0v5dJz+IseoJYlF21dI+vPRgE2ZTcmYzKLrxB2jY6YWkZ4xsXJJuSDMQoI
	1ccCuWpZ1IcBQCbyAZAVuvs04L+36ueJCI3MwRetsv3lcr0yU/fnR5Umb8dSilyziCFACGJmC+E
	m8KKL/vQRcmMEDPXyGfgJnGn/ESiAHC4NZjknJIDsKx+FWGBncRnfOiAq24mCrjL9w1h1yZ9KiI
	72LTB4krSIndWR0K38PXiwHcKtNxJnYhFDguqfmR/FSZvakMWybpQ=
X-Received: by 2002:a05:6a20:6a03:b0:398:98ab:71a8 with SMTP id adf61e73a8af0-39fe4041550mr15022450637.47.1776078300027;
        Mon, 13 Apr 2026 04:05:00 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c704:5352:540b:7ba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fff97sm10282158a12.7.2026.04.13.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:04:59 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Date: Mon, 13 Apr 2026 19:04:29 +0800
Message-ID: <20260413110453.357198-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_central only fast-pathed per-cpu kthreads (PF_KTHREAD &&
nr_cpus_allowed == 1) directly to the local DSQ, leaving non-kthread
tasks pinned to a single CPU to go through the central queue. When
dispatch_to_cpu() later dequeued such a task and found it couldn't run
on the current CPU, it could trigger scx_error() and disable the
scheduler:

  sched_ext: central: SCX_DSQ_LOCAL[_ON] cannot move migration disabled qemu-system-x86[223212] from CPU 1 to 0

Though scx_central is a demo scheduler and meant to dispatch all tasks
from a central CPU, it should remain robust under any circumstances.

Extend the handling to all tasks with nr_cpus_allowed == 1:
- select_cpu() and enqueue(): return the task's current CPU and dispatch
  directly to local DSQ for pinned tasks.
- dispatch_to_cpu(): use SCX_KICK_PREEMPT when kicking a task's home
  CPU after bouncing to the fallback DSQ, so the CPU preempts
  immediately rather than waiting for the next timer tick.

Test plan:
- run scx_central on the host, then launch virtme-ng in a separate
  terminal to create pinned tasks (qemu-system-x86), and verify stable
  operation.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_central.bpf.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 4efcce099bd5..5a02669483cc 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -96,7 +96,13 @@ s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 	 * disturbing other CPUs. It's safe to blindly return the central cpu as
 	 * select_cpu() is a hint and if @p can't be on it, the kernel will
 	 * automatically pick a fallback CPU.
+	 *
+	 * For tasks pinned to a single CPU, return the current CPU to avoid
+	 * an unnecessary fallback.
 	 */
+	if (p->nr_cpus_allowed == 1)
+		return scx_bpf_task_cpu(p);
+
 	return central_cpu;
 }
 
@@ -107,12 +113,13 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 	__sync_fetch_and_add(&nr_total, 1);
 
 	/*
-	 * Push per-cpu kthreads at the head of local dsq's and preempt the
-	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
-	 * behind other threads which is necessary for forward progress
-	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
+	 * Push tasks pinned to a single CPU at the head of local dsq's and
+	 * preempt the corresponding CPU. This ensures that e.g. ksoftirqd
+	 * isn't blocked behind other threads which is necessary for forward
+	 * progress guarantee as we depend on the BPF timer which may run
+	 * from ksoftirqd.
 	 */
-	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+	if (p->nr_cpus_allowed == 1) {
 		__sync_fetch_and_add(&nr_locals, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
 				   enq_flags | SCX_ENQ_PREEMPT);
@@ -155,6 +162,13 @@ static bool dispatch_to_cpu(s32 cpu)
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
 			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
+
+			/*
+			 * Kick the task's home CPU to pick it up from the
+			 * fallback DSQ promptly.
+			 */
+			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT);
+
 			bpf_task_release(p);
 			/*
 			 * We might run out of dispatch buffer slots if we continue dispatching
-- 
2.48.1

