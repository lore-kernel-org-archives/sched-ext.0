Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620864;
	b=tbPr9TWVT7IpWmnJ6lvP0iJX8B8mHMip+ACJO2vQKDRHlALgd0KIS01v5dlfHH1WJiPX
	 p4rHeKy4OK/FDt3+vn/OmahkkHsifD4sZYgRpZfd6sbHus9YR2206w6kQntsstt1b3rs/
	 MdaAvmiP26ZlZYu+dFgAWZKRdm+ZP/S90sP0QIpUUuyxxOOmCj0mJtTfcJZ4ED+gn8Cz3
	 smouMt9fdnGaqDsZj78K1TKeKbEQgOuIsZ9OiQwc/UTcTE5XtejijwaT64dPyy8SRwC+f
	 XCv6JixLcDFCUSYsm8/taMr0k/wuvhwwwI7R2jaAXL/3defS2C6rTkwbYNVaEbBP7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=R7Z2Nxb9Dkn3+8HSWRoWVKJx7ZKoiDe9jHtbkxoITTg=;
	b=UR24PakHal1sla3ioARIfnTWvnuzJUoBDLzsDo/Bso6Dv391zoM9g8tSPtYoGUgxGZ3H
	 wo79QodnPvx/eZfwqbxxXmBPueBAI7aIlOvOVQ6Pae2XTyTPj/xrvlvhf8wXcFVNdxnZk
	 NRdQzLOCSyq1kaP6n6oP9qRlvgyu7wzytfHpU5+Q3DSsJHa44DbDw3joTg3zOiZ93k8r3
	 cCjBV5suDKcsmeuWyweHTOcqSBRmU0KBwmOk0RAHr5u5q5sptuacT7CarV3pKl1+FMxxY
	 FRiopeYZ0tvUbug2JEJ5MlZnUJc72S24Qpq1OWCUUtrW3cnubkbLkRI5FSM6iHM6R+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="M+r9b7B/";
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D3606A31E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 170D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M+r9b7B/
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4d4d318759so158550366b.2
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795620862; x=1796225662; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7Z2Nxb9Dkn3+8HSWRoWVKJx7ZKoiDe9jHtbkxoITTg=;
        b=M+r9b7B/oqGbZdHPDCPWECIVX3sr/3xxCObiXjK9rlhbRCV6tgaVaQ0L6N6OShJYJg
         CwVGxF42xUsoWWrJo6D1h0qYLf/c2XxmEyqG0YB5LoY5iVYJiR200VJN3GRM3R9zbhRN
         Ujs3vliusmtui5NgOkK4qAEw7j/HXxShRR+ibzV/u02YHtauHqLdTJ54W4PGZpC1FuB/
         bScX0oI8FLGpwWxNG9tPmWrqg+vmzgNkYnkRiCG9eB431wwEv/G0qOsC7SgQHOweOS91
         5HbjyX7TUO80s1NxH3kZf5tdpJv73MYEz7RArvhQiJaQBAbrYTiLfYB5EcCTprL/I1De
         IRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620862; x=1796225662;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7Z2Nxb9Dkn3+8HSWRoWVKJx7ZKoiDe9jHtbkxoITTg=;
        b=rYDnnOVP86O0jqnZdmJGSDzb/N203X6CYLUaJraH8HsfIQlcmc525g6iAw0HB/v2dN
         xnnsqN67AISmioOkI+RyoynuUfsq4Mm7iDFQBE5+b0zc6dzikvs2PyEa8cV5x1C1nSHl
         ElegNTIThVu0X5v3VIoQcnFhrUoag8+6AREqgRuImb3v7TIWHaGZOP1iqKDz6JYJXoPy
         +J4IwMFc7/QJUJMR2tRD4lZyU36FWe7qNfnuH2qLGSs24YyYjIaz6Hojs+Ere4XG3JIV
         akbYohUJEpUGKzJTSlkYzKNmYjdtCXtoNCcQPmzEgoqQ8b77kxwnpxYge09fv5Zgsw2M
         0gAA==
X-Forwarded-Encrypted: i=1; AL+hErEnjSdHm185wQSEBseOek6xdVld786OR1smaM83nv0o2dZEtJZ3BVkXnHAMqJRLqpl9Vw4hgS6A8M8=@lists.linux.dev
X-Gm-Message-State: APuU4Z8x6/cFRd4f9JlN2WHhwBKc1IIc5NiL5pqu91Tf4A0AbQOBOx38
	OK8lE2nUWmIwLcv1IVRyhfCODR6au7IDvBYwLOabKZK9hUCQZTM78KCi2nv60nUq1x8FXxrhWza
	Mj83qzffOZtgQbg==
X-Received: from ejju8.prod.google.com ([2002:a17:906:4088:b0:c3f:b33c:8124])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:fd15:b0:c40:9e84:942a with SMTP id a640c23a62f3a-c513aade153mr1536137166b.48.1795620862190;
 Wed, 25 Nov 2026 07:34:22 -0800 (PST)
Date: Wed, 25 Nov 2026 15:34:19 +0000
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
Message-ID: <20261125153353.1364467-1-jpiecuch@google.com>
Subject: [RFC PATCHSET sched_ext/for-7.4-fixes] sched_ext: sub: Don't run
 ops.sub_caps_updated() in an SCX op context
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_bpf_sub_grant() and scx_bpf_sub_revoke() are in scx_kfunc_ids_any, so
a parent scheduler can call them from any op. Before returning, they
deliver ops.sub_caps_updated() to the affected children synchronously:

  caps_updated_deliver()
    SCX_CALL_OP(sch, sub_caps_updated, NULL, cu->cmask_arena_out, caps);

__SCX_CALL_OP() leaves scx_locked_rq_state untouched when locked_rq is
NULL. Unlike other SCX ops, which either always run unlocked or always
hold a known rq lock, ops.sub_caps_updated() inherits whatever context its
parent happened to call grant or revoke from:

1) Inconsistent locking context across calls. When the parent calls
   grant/revoke from ops.sub_attach() or a BPF timer, scx_locked_rq() is
   NULL; when it calls them from an rq-locked op, scx_locked_rq() still
   points at the parent's rq. For example, scx_qmap nested three deep runs
   a grandchild's ops.sub_caps_updated() under the middle scheduler's rq
   lock when ops.sub_ecaps_updated() picks up a pending PART_REDISTRIBUTE
   in execute_partition() -> apply_partition().

   ops.sub_caps_updated() has no scx_kf_allow_flags[] entry (only the
   universal any/idle/cid kfunc sets are allowed), yet kfuncs in
   scx_kfunc_ids_any consult scx_locked_rq() and the child has no safe way
   to probe which state it is in: scx_bpf_locked_rq() aborts the child
   when unlocked, SCX_DSQ_LOCAL in scx_bpf_dsq_reenq() and
   scx_bpf_dsq_nr_queued() resolves to scx_locked_rq() ?: this_rq(), and
   scx_bpf_cidperf_set() (for example on cids where SCX_CAP_PERF is
   already effective) works across all cids when unlocked but aborts the
   child on any cid outside the parent's rq:

     CPU 2, parent P, child sub-scheduler C
       enqueue_task_scx(rq2, p)                    // rq2 locked
         SCX_CALL_OP_TASK(P, enqueue, rq2, p)      // scx_locked_rq() = rq2
           P.enqueue(p)
             scx_bpf_sub_grant(C, SCX_CAP_PERF, cids)
               caps_updated_deliver()
                 SCX_CALL_OP(C, sub_caps_updated, NULL)   // still rq2
                   C.sub_caps_updated()
                     scx_bpf_cidperf_set(cid of CPU 1, ...)
                       scx_cpuperf_set()
                         scx_error("Invalid target CPU 1")  // C aborted

     sched_ext: BPF sub-scheduler "sub_caps_ctx" disabled (runtime error)
     sched_ext: sub_caps_ctx: Invalid target CPU 1
        bpf__sched_ext_ops_cid_sub_caps_updated+0x57/0xb7
        bpf__sched_ext_ops_cid_enqueue+0x50/0xb0

2) Parent lock hold time across subtree cascades. ops.sub_caps_updated()
   is meant to track held shard caps and propagate grant/revoke to
   children. A single grant or revoke can synchronously fan out across a
   subtree of descendant callbacks (up to SCX_SUB_MAX_DEPTH levels, with
   multiple children per level) while the parent's rq lock, p->pi_lock
   (from ops.select_cpu()) or scx_dump_lock (from ops.dump*()) remains
   held, delaying other CPUs contending on that lock.

3) Dump state leakage. When the call comes from ops.dump*(),
   scx_dump_data.cpu remains set, so a child calling scx_bpf_dump() passes
   the check in scx_bpf_dump_bstr() and writes into the parent's dump
   instead of failing.

Sending as an RFC because there is no obvious best way to resolve this:

- Restricting scx_bpf_sub_grant() and scx_bpf_sub_revoke() to unlocked ops
  would avoid deferred delivery, but would disallow repartitioning from
  rq-locked callbacks such as scx_qmap's ops.sub_ecaps_updated().

- Keeping synchronous delivery as-is, handling scx_dump_data separately
  (or rejecting grant/revoke during dump), and documenting that
  ops.sub_caps_updated() inherits the caller's locking context would avoid
  irq_work while keeping kfuncs deadlock-free, at the cost of an
  inconsistent locked/unlocked context and holding parent locks across
  subtree cascades.

- Deferring delivery to irq_work when called from an SCX op context (this
  series) keeps grant/revoke callable from any op while giving
  ops.sub_caps_updated() a consistent unlocked context and releasing
  parent locks and dump state before subtree callbacks run, at the cost of
  extra irq_work, hotplug, PM and teardown machinery.

Patch 1 adds caps_updated_deliver_or_defer() for grant/revoke. When the
caller has an rq locked, has kf_tasks[] set, is in ops.select_cpu() or is
dumping (the new scx_in_dump()), the to_deliver list is spliced onto a
global pending list and a per-cpu hard irq_work delivers it. Each cpu uses
its own hard irq_work so concurrent deliveries across cpus cannot clear
IRQ_WORK_BUSY early, and so a dying cpu on PREEMPT_RT doesn't strand work
after its irq_work thread is parked; if this cpu is already offline (such
as ops.update_idle() when hotplug parks the migration thread), an online
cpu's irq_work is kicked instead. While PM is in progress, kicking is
suppressed so irq_work_queue() never runs in the syscore phase, and
scx_sub_pm_end() kicks any queued deliveries once the PM cycle ends.
Otherwise delivery stays synchronous, as before. Queued scx_caps_updated
nodes stay in flight, so later changes keep coalescing into them.
scx_free_pshards() drops a dying scheduler's queued entries and flushes
every cpu's irq_work before freeing the pshards.

Patch 2 adds the sub_caps_ctx selftest. A cid-form root grants/revokes
SCX_CAP_PERF to a child from ops.enqueue() and SCX_CAP_PREEMPT from
ops.select_cid(). The child calls scx_bpf_cidperf_set() on every cid from
ops.sub_caps_updated(). Without patch 1, sub_caps_ctx fails with:

  Scheduler exited unexpectedly (kind=1024 code=0 msg='Invalid target CPU 0')

The patches were written with the help of an AI coding assistant.

Kuba Piecuch (2):
  sched_ext: sub: Defer ops.sub_caps_updated() out of SCX op contexts
  selftests/sched_ext: Test that ops.sub_caps_updated() runs unlocked

 kernel/sched/ext/ext.c                        |   6 +
 kernel/sched/ext/internal.h                   |   8 +
 kernel/sched/ext/sub.c                        | 129 +++++++++++++-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/sub_caps_ctx.bpf.c    | 136 +++++++++++++++
 .../selftests/sched_ext/sub_caps_ctx.c        | 165 ++++++++++++++++++
 6 files changed, 441 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_caps_ctx.c


base-commit: 97e1c7d467d07734f8f5c8c64730e1f7c415bd46
-- 
2.56.1.839.g22a8290db9-goog

