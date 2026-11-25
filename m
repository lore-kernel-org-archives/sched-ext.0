Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606122;
	b=UGG1UwjJXp9MwzAYB1uRvR6AAkdqgGgcLCtWv6EAp/c855ie2dLXGvPTU+8PC4RVbsv/
	 PeJSYYFtP+3VRQiQFEiN/ZaKCLT4x6iswhbacMijkREfwpa/03nEGQvaoR4YV2wGdwXRE
	 egJN4ZqY7GEowsDIO44VxNO6FIRzAGdusmHwryxa63tJrD9DOQeqzxhgLqeOV9lcM0tXm
	 36lBMy3FGsATHxaULnbnUVi6v7wiBX43VQcXpnZZa8Bz+kj9T4tpPsZGctLG4aFXKg0lw
	 TfrT9/LFELOyYix2+Ci/jgA23rQPq+XszTV7kCyWtGjkWajJjEMSFWBq4EK3hrjyBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZYZwLQfYchu10NlP8wZM+iDrPykFs3AzjnpE4jR9w34=;
	b=gnVxFxiYzg3f9Ji9gEiVzQU+1FGt98woOl9aq2HH3HYh5gCENjJTm2pRHYAALLwABsEd
	 dMpFfBISpvIKdiCD3fMC1AuXDr4vUCiGMOpO0GN9rpFrVIj0h1ooxtqi4yFNkSpgKsdqX
	 h/r8/FhpDWNTSlBZ0H/yBs8qZUk7WXexfJs8x4qmG/4D+63x2AeAPu/xNH8xr4vEGQGzI
	 tKDL9RRywboNn/lG+llMf/SMNZGoR0mjta+BVHpr08asU3XH1H7KoBUIpmztIU12HXOEh
	 4L8tvOfOkxuLn2XoL0I87OkJwOYzMLEYduTRCu1W+aX/g8tXRYyfus0mfIT9TpOE3mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PusHJyW9;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73A606A327
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E73A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PusHJyW9
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a7c864000eso3334797f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606120; x=1796210920; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYZwLQfYchu10NlP8wZM+iDrPykFs3AzjnpE4jR9w34=;
        b=PusHJyW9rLycbzxwulSj7P6+sWFSW2C6AuH/v8HVdsBmcFS11cvvVW+yODQB247nb/
         BDU7JrtzSJdAKuMThewXZ49OUte4ZC7DNjx8uOeeQz1pZGTphz6Zr9Fz1e3kne4NOXD/
         GB+1AGzi9wMT4dTM+0c5w6k1lbbxqhvNAALGGiSxLWRR8XITH/6+CgSMrtDaoBtJhBGe
         18cw4AkAfNDlqNalvfKuw7kPJrxH/opkLs96dB7xKEllhGs5JblA66Vwow/8qHRh61dG
         fh16z5a8Je919aOPPIxVa5wnSE6aFFuwJpynoV2qkiKNgvgGXTJe7OVo/ORSV2gW8UdA
         cH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606120; x=1796210920;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYZwLQfYchu10NlP8wZM+iDrPykFs3AzjnpE4jR9w34=;
        b=kYtucXw8ESJYpIWXNAXemr6x5xjMpXyCzdXe+MIkxXvCvuVmYaKhmqqvtHkcbzaMo+
         gliXwATmTNY7ZN0w2UOSmABiTRk8HPUvFDP473wsfVoU0IywJ02YAt8JGQodt/hDknPr
         rpmSbUgSi0onxMerth0sW5ijf42UDi8d1Cr2rdAJHSKp0I51CWbS2LuKuh1YLooZ6UVe
         bLr5S7NvElzdyeSvTm9A8KoQI6RdntB3E+0nTZkB7JjVhhQ6/OKkmc1doY3m0QpND5x4
         kUSmZ/5GCDtmB5aPrK5e3xB6Qxv6bSx7evFurjhmD5+lsTLNoAzmaMIyuOxxlPMG8iq1
         xWiQ==
X-Forwarded-Encrypted: i=1; AL+hErH17LWfFohhL/2DSEPW3yknzVKw7FPy8CAiRT+YvHNRuxK3ju0fPkcn5t0Vk4oA3pqmNQJ7VrAAbTY=@lists.linux.dev
X-Gm-Message-State: APuU4Z/rSnojEeQvD43UCIgrYIx8KrosubySiZfTqaZmwr2tBZ4c1Fc6
	MHIZXsh3IieRUoQjhFhfsLQVUwXprulxNTUjgKU+O6mR5OTY2Fx9/OkpRyzge0bpVv2bcFM28Kc
	l1D9tfB3gkFXIYQ==
X-Received: from wrpg9.prod.google.com ([2002:adf:f3c9:0:b0:4b7:8eec:f673])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4812:b0:4a6:bc53:247f with SMTP id ffacd0b85a97d-4abb7d45e6cmr30551834f8f.48.1795606119414;
 Wed, 25 Nov 2026 03:28:39 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:34 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125112553.1539758-1-jpiecuch@google.com>
Subject: [PATCHSET v2 sched_ext/for-7.4-fixes] sched_ext: Fix ops_state and
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

Patch 1 factors the holding_cpu + SCX_OPSS_NONE + switch_rq_lock()
handoff out of dispatch_to_local_dsq() into
release_dispatching_and_lock_task_rq() with no functional change.

Patch 2 clears ops_state in scx_dispatch_enqueue() while the target DSQ
(or rq) is still locked and before ops.dequeue(), so a task found on a
DSQ is never DISPATCHING. finish_dispatch() now inserts a remote task
into the global DSQ under the task's rq lock via
dispatch_remote_task_to_global_dsq(), using
release_dispatching_and_lock_task_rq(). On a destroyed user DSQ,
scx_dispatch_enqueue() clears ops_state after scx_error() and returns
without falling back to the global DSQ, leaving scx_bypass() to recover
the task. SCX_TASK_IN_CUSTODY is only set with the task's rq locked,
lockdep assertions are added, and the now impossible QUEUED &&
!IN_CUSTODY retry in ops_dequeue() and a stale comment in scx_bypass()
are dropped.

Patch 3 removes scx_wait_dispatching() and all its callers, as it can no
longer find a DISPATCHING task. ops_dequeue() keeps its own wait.

Patch 4 makes dequeue_remote check in ops.dequeue() that
scx_bpf_locked_rq() is the task's rq, and adds a scenario that inserts
tasks into SCX_DSQ_GLOBAL from remote CPUs. dequeue_remote fails without
patch 2.

The patches were written with the help of an AI coding assistant.

Changes in v2:
- Split release_dispatching_and_lock_task_rq() extraction out into a
  separate preparatory patch (Patch 1) (Tejun).
- Patch 2: On a destroyed user DSQ in scx_dispatch_enqueue(), clear
  ops_state and return instead of falling back to the global DSQ,
  letting scx_bypass() recover the task and dropping the bool return and
  finish_dispatch() retry (Tejun).

v1: https://lore.kernel.org/all/20261123170846.3165648-1-jpiecuch@google.com/

Kuba Piecuch (4):
  sched_ext: Factor out release_dispatching_and_lock_task_rq()
  sched_ext: Fix ops_state and ops.dequeue() locking races in dispatch
  sched_ext: Remove scx_wait_dispatching()
  selftests/sched_ext: Test that ops.dequeue() runs with the task's rq
    locked

 kernel/sched/ext/ext.c                        | 264 ++++++++++--------
 kernel/sched/ext/internal.h                   |   1 -
 .../selftests/sched_ext/dequeue_remote.bpf.c  |  34 ++-
 .../selftests/sched_ext/dequeue_remote.c      |  37 ++-
 4 files changed, 208 insertions(+), 128 deletions(-)


base-commit: 97e1c7d467d07734f8f5c8c64730e1f7c415bd46
-- 
2.56.1.839.g22a8290db9-goog

