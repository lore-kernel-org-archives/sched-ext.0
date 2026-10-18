Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D444949E8
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325704; cv=none; b=cM9TIKCHwRxBtmIomRHQstfOYQo4yJoFSSa5edlNfmK4NEb0br2tK/nMyxK8R9LaPjmnUJj5BakkYjb5w7f2WchS6NMJPsx+lBSiZ9QhQCo4v/3FPw45ojZK1e+AQexVkKT8LPEnO1wGsIQ+BgX70KBHILZBFl7ArKdE+ltsvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325704; c=relaxed/simple;
	bh=jJzrwDcLPPwtfFvIwpbsnemnHUZlCxNXhbp9HY7MxhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sr7mj3utcBlrJAE8oxS9Sf0FaYl37FyzN0Mx9lOIvmK6XmoDBN3w/jOOrHaT/suZ6EQ0+TdKFuGvXYPPnGhpwflpaUOhO2ZZ5mQNxoM9WHbPcm67kg7j5YRpgwnsgOteh8gDgOwRifUz4grpZkia02PhGwcX2baNGwG+Ti9tPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aops+2GS; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aops+2GS"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c41dae9db9dso67538466b.2
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325701; x=1792930501; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FwDexhyU7jAUc+oJl4oPya3q4dZ70NmO2jnrwQScHtU=;
        b=aops+2GS2hCsQ+cO54YwbgPQAYqLb48u3Y20AV0m7kmVjj0nj/6wSPKPLAwDGayHMK
         wtUJ/SkHZAoxAITnow+YVuh/SEf7/bzKfNr2AMte41mGrqnZgZd0g9MKST09rbGy6rm1
         QfiSzbdnKRQJM0t6JsaVwuZ7OBp0DpC39N7aLz5vh3zvf6Xb+pzUTb5JE2BzPNo4zL2k
         HJSc3TzjMdE2wywFyCKLqBlJt1f6ymXpSfQbECEIo8cCqdtxdkBF4LW0T5a5zmSPhhxl
         ZmNiLis1GLv7N6KjdcohjToSTOKesv++4CwMGWdkVPiAbY+L/KVJdnt0mG/Frl8W0/fu
         VB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325701; x=1792930501;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwDexhyU7jAUc+oJl4oPya3q4dZ70NmO2jnrwQScHtU=;
        b=hbAA4id0TcdqkhbPBAeeEsVBA0LaoSXha/qF9i3SWReiNjZxIYqMimxtM1aFe356eB
         hXgyVUlUI1nqgM0WArOWiy/OQUalFUnlyXeW6ry99IlC4d7ItN4121Q8ulS8qcZKT+kr
         /HIZDpQDZE3EsIB+3VaKOyJzaOio8jawi6X7zWy/qAaGHSL4aTpuhnFnje1/WN8DGoj1
         a7BkCjspx+nzJDDVod5YBEQ+MtA/gynKjDipT6sB4WOs7yKGqf/O/pYViaKyWXVLBDmm
         GGfOc/bVYXhwHOTuK8jUhVHFlLbUPFQErldt9s4ZUqcTuT8sZFLiBlMKnBgd1x2brvaF
         1X1w==
X-Forwarded-Encrypted: i=1; AKwUvBzbQr4NptIr807AcLsSm7Jufnjr/VGMCb1kIBqXd3CVO/87sfYJCBfUB0Vmd/hfBIpLODVi+1XhI+Y=@lists.linux.dev
X-Gm-Message-State: AFq9FYKsihz/Z0BUO1JgbSkP+5aGgsx85KiZBIVF6VsGtg8m+wYVs+UU
	58tnkNT8p/G2KmJPvngob2uc0TQsJd7rbpIYfCXe/zZK/2jCihca8BQhnU0Jsk4gYYMWksaeoy+
	9tNkOL1X3qUREiw==
X-Received: from ejsh11.prod.google.com ([2002:a17:906:584b:b0:c31:533d:60fe])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c510:b0:c2e:5f8f:e60e with SMTP id a640c23a62f3a-c41a01fd45emr300164466b.38.1792325700997;
 Sun, 18 Oct 2026 05:15:00 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:45 +0000
In-Reply-To: <cover.1792248922.git.jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <177fec80ae740d23baea0d5e50fb231ce165057e.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH 1/5] sched_ext: Make legacy scx_bpf_reenqueue_local()
 target the locked rq
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The legacy, synchronous scx_bpf_reenqueue_local() can only be called
from ops.cpu_release(). It assumes that ops.cpu_release() always runs on
the CPU being released and re-enqueues the tasks on the local DSQ of
smp_processor_id().

That assumption is about to stop holding. A following patch emits
ops.cpu_release() when the task running on a CPU leaves SCX through
sched_setscheduler() or a PI boost. That can happen from any CPU, with
the target CPU's rq locked. Picking the rq from smp_processor_id() would
then trip lockdep_assert_rq_held() and walk another CPU's local DSQ
without holding that CPU's rq lock.

SCX_CALL_OP() already records the rq the operation is invoked for in
scx_locked_rq(), and scx_bpf_dsq_reenq() /
scx_bpf_reenqueue_local___v2() already resolve SCX_DSQ_LOCAL against it.
Do the same in the legacy kfunc. Nothing else in reenq_local() depends
on running on the target CPU: the local DSQ is protected by the rq lock,
and direct dispatches to a third CPU's local DSQ are already deferred
through ddsp_deferred_locals.

No functional change for the existing callers, which all run on the CPU
whose rq is locked.

Also update the kerneldoc of scx_bpf_reenqueue_local___v2(), which still
says that it works on the local DSQ of the caller's CPU, to match
scx_bpf_dsq_reenq().

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f1b9d52f624a..f64438290218 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9501,9 +9501,10 @@ __bpf_kfunc_start_defs();
  * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * Iterate over all of the tasks currently enqueued on the local DSQ of the
- * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
- * processed tasks. Can only be called from ops.cpu_release().
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the CPU
+ * ops.cpu_release() is being invoked for, and re-enqueue them in the BPF
+ * scheduler. Returns the number of processed tasks. Can only be called from
+ * ops.cpu_release().
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 {
@@ -9515,7 +9516,13 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return 0;
 
-	rq = cpu_rq(smp_processor_id());
+	/*
+	 * Use the rq ops.cpu_release() was invoked for rather than the local
+	 * one. They are not necessarily the same CPU.
+	 */
+	rq = scx_locked_rq();
+	if (WARN_ON_ONCE(!rq))
+		return 0;
 	lockdep_assert_rq_held(rq);
 
 	return reenq_local(sch, rq, SCX_REENQ_ANY);
@@ -10057,7 +10064,9 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
- * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
+ * rq the current scheduler operation is locked to - e.g. the CPU
+ * ops.cpu_release() is being invoked for - or the calling CPU's when no rq is
+ * locked, and re-enqueue them in the BPF scheduler. Can be called from
  * anywhere.
  *
  * This is now a special case of scx_bpf_dsq_reenq() and may be removed in the
-- 
2.56.0.176.g3575e65682-goog

