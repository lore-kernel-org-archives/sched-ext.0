Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732906;
	b=TPhBcMcB3w55xXKGbRHKCweVJ7niTR2FXzboMb6fHIBX92FuMCcv30GHLnGQcRpR3Hkl
	 fLcITRvFFXhtwWNlbgEeLj8nufjEdGb93UpjK9G+8NEfMxMnVVykwbyGR/0Fi46sPhwm+
	 48O/Kz2lczWQ05xWHM0GvfndSeC01y7bmg9zJygEad9ntHkZ77Aj8k9JV6zjM2US07Sic
	 vGxmJIX4QYnzlRKbffGLJhIZotnzm9hze9siPzBvQS5grPB4N3cfJo6uk1FFNg2zi4NMj
	 14uEvH/EkWlxwTCBHEpHAIX5R+0WHne6iJKY/wNBm4Sx3/skN/YPxzQfl4EEZ2W99mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mkHpoiy9NrAU27w/fCLMy36ehuNB49pcuvw9g5jd90U=;
	b=LTZZc6cIEVxf2zeqerxpbEAGFVwi7Drxk123/yTN660o5eoWTKwqaogi1qyv/c4E+usz
	 pIKMt/Xp2DlKTCSQ921cIBOFGNPLL4ZFMKoaF58CrXMGfGqXT9NtUQ28ljUobNygZ25Ku
	 GaOmcb3Io5I2wxHnmIQ0O9hjX1U4TDZJxa3biHS3VOd9fqNKd4BNu6twtNT0xcULT7PRg
	 hV/24P2SixkvU3nNBZ5SRRhowJLGzNkM6eWO+dZHZqFQpl2dIIL2ul1HHnyx1i7NcsNC3
	 H43knKWdcH7etdKiWukJina0L3kEEXtbrG32RhdzPFcR8oLjQJwkLHB+AVr0pooj7UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o4H5cmhV;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B0606D802
	for <sched-ext@lists.linux.dev>; Tue,  3 Nov 2026 19:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F8B0606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o4H5cmhV
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1bc2e62d5so5578134a12.2
        for <sched-ext@lists.linux.dev>; Tue, 03 Nov 2026 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732904; x=1794337704; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mkHpoiy9NrAU27w/fCLMy36ehuNB49pcuvw9g5jd90U=;
        b=o4H5cmhVH/FpJzwDtgDDtlI/qsBfnx5kJtmV0cPDKu7QFrLQx+ojQ/lRZvEReoGnYc
         WWIy6+j0tcLNy7pSffetzuOzMwfVcImzASWL0pbHf+GGwG1ShIkApaQFnRUYBaTxJjwz
         n1uF+TJqjv5FEyGL0Ln6aJI2YOh88ZG9K0hR/UQ2s1cEL6/gkmXKt567rvDI4/txw/Kq
         AD5VETb76M4AxPPdLdHEqAgf9nYvNpGfRTo1IAfpUCAhh9aucE3H5vJOTM308mCTMHa1
         TV9GJAtcY0ioeJaAmmd29ophQHWAPTaSN37q4VZyFSLTh+w1GilmmdVg6olPApyQbsuI
         +4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732904; x=1794337704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mkHpoiy9NrAU27w/fCLMy36ehuNB49pcuvw9g5jd90U=;
        b=tBX8SvguI+mXW5zCfQo6M14UpMInnqPLbNMGfEXcS4re3BFz580/qnIBL1aly7dmNP
         urwKP0drKWuJeUD0d75RX958/qw8j3wKUSQYoJsjdy/EcCeZ6EaC6NecBXkBVWD4WpNY
         YiNIHNoCs30BTVm6GHVib0wJyX982nO7y7qQavLIzMpA/NFsj6ow27N1eJdULuxedNsK
         pgZHSyC1pgEhjFU8ztlCNROv3G5ANhjzf5OxLNwN8yC0lLOzklBu/HU8ZRNZ5KmVgLrg
         QjxCszpV36NVhpQjcWbXWP5hvzDgCajDEBqD31DfBfOw6By1D5bGuNVnWB7Wg1LO8GR1
         RecA==
X-Forwarded-Encrypted: i=1; AKwUvBzSsOkP+Zqx/OOnhYfBlXVzvAV+271AmJhisUWc2I0ZL3sazw7ZlU3RerEVwBVboXMlpf1MejqJ7h8=@lists.linux.dev
X-Gm-Message-State: APuU4Z+CEiURrr45IafAJgRwcH+fNRR1du9zPJHcudt2n4OlWYJPBGEO
	4tXTvzIfWY4YV3g0Ms/ZkPr0FAw5/2H+K62wBADXu+uM0eK59/MYsNBqE8Enm8/gVuXA9ru/hTV
	99PiMa+vW9zWPlg==
X-Received: from edi11.prod.google.com ([2002:a05:6402:304b:b0:6ae:1894:66b2])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5007:b0:6b4:9919:b54 with SMTP id 4fb4d7f45d1cf-6b4d5ce4182mr10898033a12.42.1793732903558;
 Tue, 03 Nov 2026 11:08:23 -0800 (PST)
Date: Tue,  3 Nov 2026 19:07:48 +0000
In-Reply-To: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103190805.3487350-2-jpiecuch@google.com>
Subject: [PATCH 6.18.y 1/2] sched_ext: sync disable_irq_work in bpf_scx_unreg()
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Richard Cheng <icheng@nvidia.com>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Cheng-Yang Chou <yphbchou0911@gmail.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Richard Cheng <icheng@nvidia.com>

[ Upstream commit 510a27055446b8f0d29487ca8b8d2033dc2b6ca6 ]

When unregistered my self-written scx scheduler, the following panic
occurs.

[  229.923133] Kernel text patching generated an invalid instruction at 0xffff80009bc2c1f8!
[  229.923146] Internal error: Oops - BRK: 00000000f2000100 [#1]  SMP
[  230.077871] CPU: 48 UID: 0 PID: 1760 Comm: kworker/u583:7 Not tainted 7.0.0+ #3 PREEMPT(full)
[  230.086677] Hardware name: NVIDIA GB200 NVL/P3809-BMC, BIOS 02.05.12 20251107
[  230.093972] Workqueue: events_unbound bpf_map_free_deferred
[  230.099675] Sched_ext: invariant_0.1.0_aarch64_unknown_linux_gnu_debug (disabling), task: runnable_at=-174ms
[  230.116843] pc : 0xffff80009bc2c1f8
[  230.120406] lr : dequeue_task_scx+0x270/0x2d0
[  230.217749] Call trace:
[  230.228515]  0xffff80009bc2c1f8 (P)
[  230.232077]  dequeue_task+0x84/0x188
[  230.235728]  sched_change_begin+0x1dc/0x250
[  230.240000]  __set_cpus_allowed_ptr_locked+0x17c/0x240
[  230.245250]  __set_cpus_allowed_ptr+0x74/0xf0
[  230.249701]  ___migrate_enable+0x4c/0xa0
[  230.253707]  bpf_map_free_deferred+0x1a4/0x1b0
[  230.258246]  process_one_work+0x184/0x540
[  230.262342]  worker_thread+0x19c/0x348
[  230.266170]  kthread+0x13c/0x150
[  230.269465]  ret_from_fork+0x10/0x20
[  230.281393] Code: d4202000 d4202000 d4202000 d4202000 (d4202000)
[  230.287621] ---[ end trace 0000000000000000 ]---
[  231.160046] Kernel panic - not syncing: Oops - BRK: Fatal exception in interrupt

The root cause is that the JIT page backing ops->quiescent() is freed
before all callers of that function have stopped.

The expected ordering during teardown is:
    bitmap_zero(sch->has_op) + synchronize_rcu()
        -> guarantees no CPU will ever call sch->ops.* again
    -> only THEN free the BPF struct_ops JIT page

bpf_scx_unreg() is supposed to enforce the order, but after
commit f4a6c506d118 ("sched_ext: Always bounce scx_disable() through
irq_work"), disable_work is no longer queued directly, causing
kthread_flush_work() to be a noop. Thus, the caller drops the struct_ops
map too early and poisoned with AARCH64_BREAK_FAULT before
disable_workfn ever execute.

So the subsequent dequeue_task() still sees SCX_HAS_OP(sch, quiescent)
as true and calls ops.quiescent, which hit on the poisoned page and BRK
panic.

Add a helper scx_flush_disable_work() so the future use cases that want
to flush disable_work can use it.
Also amend the call for scx_root_enable_workfn() and
scx_sub_enable_workfn() which have similar pattern in the error path.

Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ 6.18.y has neither f4a6c506d118 nor sub-schedulers. Here, the flush is
  a no-op when scx_disable() loses the exit claim to scx_vexit(), whose
  error_irq_work queues disable_work later. Sync error_irq_work instead
  of disable_irq_work and drop the scx_sub_enable_workfn() hunk. ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f3e3146e5feb..d2460a88fba3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4207,6 +4207,20 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
 		kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
+/**
+ * scx_flush_disable_work - flush the disable work and wait for it to finish
+ * @sch: the scheduler
+ *
+ * sch->disable_work might still not queued, causing kthread_flush_work()
+ * as a noop. Syncing the irq_work first is required to guarantee the
+ * kthread work has been queued before waiting for it.
+ */
+static void scx_flush_disable_work(struct scx_sched *sch)
+{
+	irq_work_sync(&sch->error_irq_work);
+	kthread_flush_work(&sch->disable_work);
+}
+
 static void dump_newline(struct seq_buf *s)
 {
 	trace_sched_ext_dump("");
@@ -4968,7 +4982,7 @@ err_disable:
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
 	scx_error(sch, "scx_root_enable() failed (%d)", ret);
-	kthread_flush_work(&sch->disable_work);
+	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
 
@@ -5142,7 +5156,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct scx_sched *sch = ops->priv;
 
 	scx_disable(sch, SCX_EXIT_UNREG);
-	kthread_flush_work(&sch->disable_work);
+	scx_flush_disable_work(sch);
 	kobject_put(&sch->kobj);
 }
 
-- 
2.56.0.385.gac671c819a-goog

