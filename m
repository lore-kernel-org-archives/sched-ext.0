Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453837;
	b=SbmdO5uX2cgyo5TRaQQlW9wJeHi9/yGCpq3d4nkABvtyf7Y8mj/Dh/aXXMlq/VKy7d8q
	 uJ245R6vN8Giu4zApirlhzQd4W1TLwwHc7/i9446TjIoip66jb7+BqkSpyMbFczIvPoxR
	 9PuN/kE/AOsQOuQlfRlNDZ52EhRd3gCFXKosGZyv1QkpmKvz4SyKaGlH6KN4u2YBWBX+Z
	 u00YPlR3CbQPpmeGMwZVUZd562fFe6EsSnX1xUqXqXM6Ux9EhMp8ZNR7TzGy969IRQfd6
	 WTZBdURCiez9wS91ZXnVi2p3ukgehopjWMSdUoBclo7TIlP2Pshldsvcwe4uLC1w2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=PCqMmm7ydf0lsdxDlwRQHmJxvbfNPyH1GOn4s2cFrCY=;
	b=uJ+swA+mUPQavfQASOXw9fCK6xF70ZUvdtTrj0E3bIDFfxkyTi/7ZstFru3i5ktfTqnz
	 tcImy0iARq2Yd59T7jlXueYu5kUetGCXuBuIUQxtA4robex7m0wXDAPolFH/ej1ijd4uI
	 cbqAE2Vioii5PV7gWhtBCgGEyAXWpN5n7kJ8QLmudihiJd4KGJ1jDI7+jijtht1ZBwMka
	 9+3hsqniv7wCxS7H6u5pXOkEV28RNxo/AgUuNB02RWVkaONF8Fzyvs3MJtzyAZrmNWFfW
	 ewCPfU4RV/v492dYHKGX3Ms8qDAyGaYAfD4ERccb0tPpHqr+J/q8u4fOL1nUQDIjVxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=akRYLgIX;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDACE606A68D
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDACE606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=akRYLgIX
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6ba62acd927so2560770a12.3
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795453835; x=1796058635; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PCqMmm7ydf0lsdxDlwRQHmJxvbfNPyH1GOn4s2cFrCY=;
        b=akRYLgIX7G+l2IOlMFt6gC+3kmk+5MZqf7thEunzjkVn9vnvqh3rS/3ErPV3IUBGYF
         H2ub3WFn/a5Fgf+NjA2vhhjClUoQLUszEkV4VcXslOsRC6Cf8Wp7bcSZkAusriUOK0T3
         xQP8Kf/UTX6RSPbL1qTzmcpWspMBOMiGgM/0OtKGIptnpqhaybgmFHm/oCQOXz3vWbFq
         +xxg8dku38WVCLnDQiPUT01WsEnmmf+tXV1N95wfZzH2417sdBfDI0b9/j9TeR2nkZXA
         7PNfXlQ2NRqhw58JS6j8dlZFZXQzujCdMFeIbUJuORqXmJ6gXS1KzryQhWczXEG+Pcyx
         FQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453835; x=1796058635;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCqMmm7ydf0lsdxDlwRQHmJxvbfNPyH1GOn4s2cFrCY=;
        b=iaORlMJYkLttadi8FHjA4TxzN3VmHEJVJA3F5hxtSo0TJxmWkHad9dOXK53UtJZaza
         z2CcV5wIR80ZjmH7o/CJzUtM8YR5cUANlm5WJOftbVLpXsRyx+tl0MUpbda8WV92WX0l
         IZK24/fo8COyQniFL2tADiOAQh6L9Wh63QlmrCLMmVuzh3Pi3ouIzO1fWFWRcgPFVURk
         eVEiuig/O29jbHy7IOTJLyfnmcaeKSkOumUNDvbXicfFIdCWm0N6O3fosPlgIyHbEFEZ
         MwMzbqchsn1n6yyh7e6RZWaxkIknKHZFyXdGb6FlRsCuXXR5co8g0aTqPTeoRLHDRYgQ
         9nAA==
X-Forwarded-Encrypted: i=1; AL+hErGkC6qoHDBoW+LOBKClwcLk2Mv7JmMpXuHzUy3Fa1wfcxHdE1F2M0Ep+4wajPsaUtn+tOdeB/v3LGs=@lists.linux.dev
X-Gm-Message-State: APuU4Z//AmGiVcVWDR+QTrfOhbEqMD0T/o65EFHM/F8YwxyXXnqtNHyN
	HirDEO07DkLObeH2pwB0koKV+OMMY03+9EOHxNLRcsbULyhe2aCsFr2jpo1qH8BkkGpc/52ACNW
	PpOmR4in7dG8s0g==
X-Received: from edai38.prod.google.com ([2002:a05:6402:f26:b0:6b5:77d0:adf5])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:23d0:b0:6b8:8706:59cc with SMTP id 4fb4d7f45d1cf-6ba37e69d7cmr7007358a12.18.1795453835053;
 Mon, 23 Nov 2026 09:10:35 -0800 (PST)
Date: Mon, 23 Nov 2026 17:10:31 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123170846.3165648-1-jpiecuch@google.com>
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix ops_state and
 ops.dequeue() locking in dispatch
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

finish_dispatch() hands a task claimed in SCX_OPSS_DISPATCHING to
scx_dispatch_enqueue(), which inserts it into the target DSQ and only
then, after dropping the DSQ lock and (for SCX_DSQ_GLOBAL) after calling
ops.dequeue(), stores SCX_OPSS_NONE. When the task is remote,
finish_dispatch() holds the dispatching CPU's rq lock, not the task's.
This causes three problems.

1) The task is visible on the DSQ while still DISPATCHING. Another CPU
   can consume and requeue it before the dispatcher's final store, which
   then overwrites the new state. Without the waits described below:

     CPU 0 (finish_dispatch(), rq0)        CPU 1 (rq1 == task_rq(p))
     ------------------------------        ------------------------------
     QUEUED -> DISPATCHING
     insert p into global_dsq, unlock
     ops.dequeue(p) ...
                                           scx_consume_global_dsq()
                                             moves p to local DSQ
                                           reenq_local()
                                             ops.enqueue(p)
                                             ops_state = QUEUED(qseq')
     ops_state = NONE
       -> QUEUED(qseq') is lost, later
          finish_dispatch()es of p see
          NONE and drop it, p stalls

   Commit 7de9a6fb44ea ("sched_ext: Wait for SCX_OPSS_DISPATCHING before
   reenqueueing a task") and commit 2935062be771 ("sched_ext: Wait for
   SCX_OPSS_DISPATCHING before moving tasks off DSQs") paper over this
   with scx_wait_dispatching() at every place that takes a task off a
   DSQ. Consuming a task from the global DSQ then busy-waits, with the
   task's rq lock held and IRQs off, until the dispatching CPU returns
   from ops.dequeue(). Lockdep can't see that dependency.

2) For a remote task dispatched to SCX_DSQ_GLOBAL (or to a destroyed
   user DSQ, which falls back to the global DSQ), task_leave_custody()
   does an RMW of p->scx.flags without the task's rq lock. DISPATCHING
   keeps dequeues away, but other paths update p->scx.flags under the rq
   lock without dequeueing:

     CPU 0 (finish_dispatch(), rq0)        CPU 1 (scx_sub_enable_workfn())
     ------------------------------        ------------------------------
     QUEUED -> DISPATCHING
     lock global_dsq, insert p
     tmp = p->scx.flags
                                           task_rq_lock(p)
                                           p->scx.flags |= SUB_INIT
                                           task_rq_unlock(p)
     p->scx.flags = tmp & ~IN_CUSTODY
       -> SCX_TASK_SUB_INIT is lost

3) In the same case ops.dequeue() runs with scx_locked_rq() pointing at
   the dispatching CPU's rq, although SCX_CALL_OP_TASK() promises the
   task's rq is locked. kfuncs that operate on the locked rq then act on
   the wrong CPU, e.g.:

     scx_dispatch_sched()                       /* CPU 0, rq0 locked */
       ops.dispatch()
         scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL)  /* task_cpu(p) == 1 */
       scx_flush_dispatch_buf()
         finish_dispatch()
           scx_dispatch_enqueue(rq0, global_dsq, p)
             ops.dequeue(p)
               scx_bpf_cpuperf_set(1, ...)
                 scx_error("Invalid target CPU 1")

Patch 1 clears ops_state in scx_dispatch_enqueue() while the target DSQ
(or rq) is still locked and before ops.dequeue(), so a task found on a
DSQ is never DISPATCHING. finish_dispatch() now inserts a remote task
into the global DSQ under the task's rq lock, using the holding_cpu
handoff that dispatch_to_local_dsq() already uses, factored out into
release_dispatching_and_lock_task_rq(). scx_dispatch_enqueue() returns
false on a destroyed user DSQ when the caller doesn't hold the task's rq
lock, so the fallback takes the same path. SCX_TASK_IN_CUSTODY is only
set with the task's rq locked, lockdep assertions are added, and the now
impossible QUEUED && !IN_CUSTODY retry in ops_dequeue() and a stale
comment in scx_bypass() are dropped.

Patch 2 removes scx_wait_dispatching() and all its callers, as it can no
longer find a DISPATCHING task. ops_dequeue() keeps its own wait.

Patch 3 makes dequeue_remote check in ops.dequeue() that
scx_bpf_locked_rq() is the task's rq, and adds a scenario that inserts
tasks into SCX_DSQ_GLOBAL from remote CPUs. dequeue_remote fails without
patch 1.

The patches were written with the help of an AI coding assistant.

Kuba Piecuch (3):
  sched_ext: Fix ops_state and ops.dequeue() locking races in dispatch
  sched_ext: Remove scx_wait_dispatching()
  selftests/sched_ext: Test that ops.dequeue() runs with the task's rq
    locked

 kernel/sched/ext/ext.c                        | 261 ++++++++++--------
 kernel/sched/ext/internal.h                   |   1 -
 .../selftests/sched_ext/dequeue_remote.bpf.c  |  34 ++-
 .../selftests/sched_ext/dequeue_remote.c      |  37 ++-
 4 files changed, 207 insertions(+), 126 deletions(-)


base-commit: 2f7928516314f37d7cb334675656b4412edc8be3
-- 
2.56.1.750.gf70dc682cf-goog

