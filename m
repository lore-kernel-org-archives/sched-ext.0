Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255E7478
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777352141; cv=none; b=n3jbV1HypFbQBroNnJP3uN0Ad1rDcngRs2Vfs+LP74izVk18DTTdlni4hpfw8zFAU+mZW66FYcBCh2UG2Etq8Kh3O70Mcn/TV2pxcV9LuTaf4s48nwbNe7eIfu23hFpdIEtq2sM7BM0SKI0BSPkxk5g8kH/sqFQpODjOyk+pXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777352141; c=relaxed/simple;
	bh=lIRixCcOZTf2wqdBJyYqk7RRKkIzU3jO8gWckEF3IKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbn+8GY0sOgXgcHXFF+QQzTxjKVol9r14jepAZ6S/iklUffBaRBJAyuZ7vPzHOyOAeZ1HYcMHvUfTqiJG5rYocxX5QVnyOIl+N2GbGw3nmZDRiS4QGAKTYm2+h8mEpvsUdlyPXx3XAWxCkJYKAfx3gVuRQ787HD4Wr4Wl0A+8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iowGlhvf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iowGlhvf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f1f6103afso5074788b3a.1
        for <sched-ext@lists.linux.dev>; Mon, 27 Apr 2026 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777352139; x=1777956939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbhY1w1oHBopXtgLUUFbd/4WhIrw7MoyzmtFBwQnMK0=;
        b=iowGlhvfo04hEoFXzTCGY4juPgWTMnLr5xe/j9j8Zm1Dm0w9d9cT87NA1cnBsJsdbp
         O7iKy0e2t2HJokHRZpPbVjpKe51lpkuMUPBhq7xoig/v7yhXswfEAoYGVK70ZXtvMliA
         dO2htd11/C6yHUyb3YrEPEUpbMZ1X+2KH5dhDuSFTcg5wrO3LpjFS3ib1jK45ijlFxcM
         nIPWo4tkgwBv9GvPIpJA+SCMjXR3Qvyx0txQiGm2sweLC4HK/VozdUEkF75aa3QXPcJQ
         u4gtE+tOpNzqbmhKoERlcDDokGTlxa44c0YO8Zw5C2M4bdvtb25UBhpeZtPlM4k8rglT
         ss1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777352139; x=1777956939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbhY1w1oHBopXtgLUUFbd/4WhIrw7MoyzmtFBwQnMK0=;
        b=MskZ0DbovFZvzcD0Tzp3r527/6q3svSGC71XOlHRRItGv8mZwP3hbFg9u2DI8LmfiU
         hwc5YdGYBYZX7wAAsjH95GQVxlaNgFxdRlW72NaW3t1uWdAkrjgInusbcZ41kykAMZ2M
         wIrE9hfvW7pnfGMoZiaedPYelzgO9E4uEQvB6kHe3Xg7h30VgvuGfyeyHYjiHJcgf+Pm
         r69pYu92fzn19RX8HmtMiEAb5NaFZxx8fgoXPjvVfIIJAY8NbYGPK8f2XohhQmlrJRF9
         ChY6L/7L52XnZS/xLGSZ/kTijDam1GrHetDi6gOka7x7/Qc83WhzG9GNciexfdhI5fwB
         /6SQ==
X-Gm-Message-State: AOJu0YxZlWrbxvxUGW3M6aJxcYH7BR0RDMvHUNfk97dJEqVK+EGXMFef
	oqQ4gbauIQJOPV/bpDPZ55DaAPgk6Nqb4/6zHOGB3f/o9sRfQrG8i0wGfpCpAA==
X-Gm-Gg: AeBDieuEKTjkHZXw7DS9gKMCaVR9yDqaSASpWyTCkMv3RMrHpZKwmeYoEWxWyMHwr2r
	9LDbQtxS1Xeivj/1m+ICdYs+oqpvwidREEYF6fgWNIiyLrbJb342RqwNrjjUrrEuiU8Elo9qoTe
	3ixSvU0R6hgWUZOvQfLPF1IeBBPgy7O2CGkbh5FRXEKr6S/BoixqaGpIEawErbcMHijD2Vd5a9a
	ASUYPbo/bSW2vu8rJyVMj0ipiYtXCDmPgd9cGRXO2cH8GyXkIa7ZdFkTQx9vZn9aNfvXxz/Isxg
	+Zz36Z7p3mEI2jccHOHyQEg1BEHUFCLVfU3yPnW1Bgb1YqDRZXUU5V/JFnaGyQ0Rml3VT1NnvaR
	weNQUpjobhFCjkedSQ1Tc+2NAJMJ9lEZPcyWszsWzigVY5QeOj1VgKk0yExLrnkYheOf4LQq2Hu
	beo7Rnqf9YHnE2H41PvSsqiLb3478SuVISgJ7TmosNeOf2oJGwXFFpJzZGh8k+/9E=
X-Received: by 2002:a05:6a00:995:b0:82c:9fe1:aa4d with SMTP id d2e1a72fcca58-834ddb2d0d8mr1550485b3a.13.1777352138993;
        Mon, 27 Apr 2026 21:55:38 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d715:a25f:f79c:e921])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf30c20sm1266129b3a.31.2026.04.27.21.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:55:38 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix scx_flush_disable_work() UAF race
Date: Tue, 28 Apr 2026 12:54:57 +0800
Message-ID: <20260428045529.1670916-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_flush_disable_work() calls irq_work_sync() then kthread_flush_work()
to ensure the disable kthread work has fully completed before
bpf_scx_unreg() frees the SCX scheduler.

However, a concurrent scx_vexit() (e.g., triggered by watchdog stall)
creates a race window between scx_claim_exit() and irq_work_queue():

  CPU A (scx_vexit (watchdog))        CPU B (bpf_scx_unreg)
  ----                                ----
  scx_claim_exit()
    atomic_try_cmpxchg(NONE->kind)
  stack_trace_save()
  vscnprintf()
                                      scx_disable()
                                        scx_claim_exit() -> FAIL
                                      scx_flush_disable_work()
                                        irq_work_sync()      // no-op: not queued yet
                                        kthread_flush_work() // no-op: not queued yet
                                      kobject_put(&sch->kobj) -> free %sch
  irq_work_queue() -> UAF on %sch
  scx_disable_irq_workfn()
    kthread_queue_work() -> UAF

The root cause: CPU B's scx_flush_disable_work() returns after syncing
an irq_work that was never queued, while CPU A is still between
scx_claim_exit() and irq_work_queue().

Loop until exit_kind reaches SCX_EXIT_DONE, draining disable_irq_work
and disable_work each pass to catch any work queued after the previous
check. Return early if exit_kind is SCX_EXIT_NONE -- callers where no
disable was triggered (e.g., scx_sub_enable_workfn() abort path) have
nothing to wait for.

Fixes: 510a27055446 ("sched_ext: sync disable_irq_work in bpf_scx_unreg()")
Reported-by: https://sashiko.dev/#/patchset/20260424100221.32407-1-icheng%40nvidia.com
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
The race can be confirmed by widening the race window with udelay(5000)
after scx_claim_exit() in scx_vexit() [1].
[1]: https://gist.github.com/EricccTaiwan/3b6e6c3519747b057138613af9be3465

 kernel/sched/ext.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..4f4726ee235a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6086,8 +6086,15 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
  */
 static void scx_flush_disable_work(struct scx_sched *sch)
 {
-	irq_work_sync(&sch->disable_irq_work);
-	kthread_flush_work(&sch->disable_work);
+	if (atomic_read(&sch->exit_kind) == SCX_EXIT_NONE)
+		return;
+	while (true) {
+		irq_work_sync(&sch->disable_irq_work);
+		kthread_flush_work(&sch->disable_work);
+		if (atomic_read(&sch->exit_kind) == SCX_EXIT_DONE)
+			break;
+		cpu_relax();
+	}
 }
 
 static void dump_newline(struct seq_buf *s)
-- 
2.48.1

