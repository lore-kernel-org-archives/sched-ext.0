Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442128;
	b=3KqrPMFyB61+g+nrzbKJo0M0ZRTTdGz9F5mk1veKk4K02kT7udo9pq8rlGH9Jej+2hpm
	 ycnis5ZtP3dJUtunoK2z+Ec2hg5NMnLOFLvqKM4NQX2Ki2BD+Uxr2yJdFonNF5DIkWzV3
	 CpUhoAc8Bm3GR38nbDcgUYoPQZ9qceSAqRcvsYAZMHeHOJehbNIZ/3RREAI5eNbgbAuHf
	 vl99fAJ4PkcVMSgr/P05HXUvWXBdZ8repfBfr1LYKtNYwNE9h/8TE/+7NiNJTN+eRmgET
	 HaZkLP6ilHdvr242xYJh/ycVlYnoTqslRMYriB2F4F9PzFm2tM/Fa1cRAN5HAd2U1Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=083CZZDs9hJjuz53tbRRme1ywjTKXEoDFd0O3aKN64M=;
	b=zp8JhfItgrHQaAGAXD7xpXmXrXPSGXEvNZSZs/A39BKVugTj1BcGYaScqNuC3zWKGJAU
	 d8auXc9L6sEFF57FvK00r2IXOJ5Ij4w5/FVldK/DvjNBR9P5Cml2JlQcMeXYs4VAmAVf7
	 Oq8o+CQ4tyNKdTBrAQfBK2P1RB1BkNZHRBIDSdnXTqgBZ5gkkuu18YVc+Ujocf6ZLq1FZ
	 qrvZQfMweNC+MRhf0HTiiwOyHYbA/CxjbjZryO5UuWaVCsLmbfPyD/SwJsF5p2Z3BBb0e
	 f9lXNkG03JImxiOMSEbmhga0hyXXylTpaQQG+m94hYz2KH6//76fTL3r96UJhXTMWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4PbtcL5;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA9606A31E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BA9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4PbtcL5
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso17227125e9.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795442127; x=1796046927; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=083CZZDs9hJjuz53tbRRme1ywjTKXEoDFd0O3aKN64M=;
        b=S4PbtcL5N+xT6OwmqNRw0hOBG++mRhs0wZecHHnhTFAsvN/ti1O38IJUvQRs1R8tAQ
         /e98WuuIAQ+YngehdED7hSCTz208dEG+9pHeyRLPVQYIiSW9kBBZ2ov4cPQSFfpH0hvB
         ZgLiQ7Sz1i//eqwtVdvwe8h/TXi0NfcgFeOSwZWzcAnAvkHmOYL4FWXoFHlLrk44qMgZ
         en7RUn5ELQA7UG5FKuEKww6YMtFx2osFfqmuwD3WJ4jqsinqXCYvrx7GlmnbW4dMonXO
         0HM1twNn8Lte+iBi+RiVME/C+MFHM+YuYlMmkfGJQUO0o/1oQP89eNQ+4g/ZVJojeO9Q
         8JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442127; x=1796046927;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=083CZZDs9hJjuz53tbRRme1ywjTKXEoDFd0O3aKN64M=;
        b=x3xNXASIFzU4lTSvt7l7t721q/qQG0g42hYZdAHP8QSl72IgQh1+TBvgM2sKxOMs8U
         znu8gEBy9NOxUjxuxwPQoY6vNq54tQdSev0vt/kkHRwNPCfnv11liTDIVE/7ohGZFi+d
         nsPvA8FkfMVVn5pkZqdTGkgaSzsB8KeIsPM+V+DmL+b6B+1n6JBADJ1ufxFlYXg6kCRG
         n+T5nVJ9hrHd914X+KfoL+5ZTJQLansyhVZV3qeSBQEJyW4va17eBe07zNH5dQg6m4JE
         bNs8vQOVS4zZCVDcdAGU9pEdj/1/LmIWVWWWtPbGE0uaq3P6AnnZZUXu9Cn/UWU6epGA
         6rBw==
X-Forwarded-Encrypted: i=1; AL+hErGq5zBHXSx1Q9/oXrdE0lVS0yqYnbOJSe08rD1TxBKXgNMOo9U3lmrKKET/5tQWOcg8RhsdAHjiyjk=@lists.linux.dev
X-Gm-Message-State: APuU4Z83tUehMpmtov6gk++nIqh+ShP5K3+o/YdylN5pGz3w5dDeNVEh
	HX0WgFM2wQvD0W7asAwD1e1htMYGFPM0BlCK2i8IuS2q5ll6Vzic7qRpIwC48w6TlVevIWhEUoJ
	MlB0r9RJHR4NmCQ==
X-Received: from wmjq4.prod.google.com ([2002:a7b:ce84:0:b0:4a2:15af:d03c])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820d:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb887c3ae7mr227341395e9.1.1795442126571;
 Mon, 23 Nov 2026 05:55:26 -0800 (PST)
Date: Mon, 23 Nov 2026 13:55:23 +0000
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
Message-ID: <20261123135343.4131146-1-jpiecuch@google.com>
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Don't allow unlocked
 kfuncs from ops.dump() and ops.init_cids()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_kf_allow_flags[] grants SCX_KF_ALLOW_UNLOCKED to ops.dump() and
ops.init_cids(). That group contains scx_bpf_create_dsq(),
scx_bpf_dsq_move*(), scx_bpf_dsq_reenq_task(), and
scx_bpf_select_cpu_*().

1) ops.dump() had SCX_KF_UNLOCKED since commit 07814a9439a3
   ("sched_ext: Print debug dump after an error exit") because its
   caller holds no rq lock. Commit 4c30f5ce4f7a ("sched_ext: Implement
   scx_bpf_dispatch[_vtime]_from_dsq()") then made DSQ moves callable
   from SCX_KF_UNLOCKED contexts, and commit d1d3c1c6ae36 ("sched_ext:
   Add verifier-time kfunc context filter") carried the grant into
   scx_kf_allow_flags[].

   However, scx_dump_state() runs ops.dump() with IRQs disabled under
   scx_dump_lock, including from scx_disable_irq_workfn() (hardirq) and
   SysRq-D. On a live SysRq-D dump, an ops.dump() that calls
   scx_bpf_dsq_move() migrates tasks and runs nested SCX ops from
   inside the dump:

     sysrq_handle_sched_ext_dump()          /* may run in hardirq */
       scx_dump_state()
         raw_spin_lock_irqsave(&scx_dump_lock)
         ops_dump_init()                    /* arms scx_dump_data */
         ops.dump()
           scx_bpf_dsq_move()
             kf_switch_rq_lock(task_rq(p))
             raw_spin_lock(&dsq->lock)
             move_task_between_dsqs()
               move_remote_task_to_local_dsq()
                 deactivate_task(src_rq)
                 activate_task(dst_rq)
                   ...
                     ops.dequeue()          /* nested SCX op */

   Any scx_bpf_dump() call from the nested op also splices output into
   the active dump because scx_dump_data is armed on this CPU.
   scx_bpf_dsq_reenq_task() takes the same rq and DSQ locks, and
   scx_bpf_select_cpu_*() take p->pi_lock and run idle CPU selection.
   ops.dump_cpu() and ops.dump_task() already deny all
   context-sensitive kfuncs.

2) Commit 874fdc0e86e4 ("sched_ext: Add ops.init_cids() to finalize the
   cid layout before init") granted SCX_KF_ALLOW_UNLOCKED alongside
   SCX_KF_ALLOW_INIT_CIDS. ops.init_cids() runs before
   scx_cid_publish_tables(), scx_arena_pool_init(), and
   scx_alloc_pshards(). Its only job is to finalize the cid layout via
   scx_bpf_cid_override(), so it has no reason to create DSQs or call
   the DSQ move and re-enqueue kfuncs.

Patch 1 removes SCX_KF_ALLOW_UNLOCKED from ops.dump() and restricts
ops.init_cids() to SCX_KF_ALLOW_INIT_CIDS. All remaining
SCX_KF_ALLOW_UNLOCKED ops run in process context with IRQs enabled and
hold no rq, DSQ, or pi locks.

Patch 2 adds the unlocked_kfunc selftest. Without patch 1, the test
fails with:

  ERR: unlocked_kfunc.c:49
  unlocked_kfunc_fail_dump loaded when it should have been rejected
  not ok 1 unlocked_kfunc #

The patches were written with the help of an AI coding assistant.

Kuba Piecuch (2):
  sched_ext: Don't allow unlocked kfuncs from ops.dump() and
    ops.init_cids()
  selftests/sched_ext: Add unlocked_kfunc test

 kernel/sched/ext/ext.c                        |  8 +-
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/unlocked_kfunc.bpf.c  | 69 ++++++++++++++++++
 .../selftests/sched_ext/unlocked_kfunc.c      | 73 +++++++++++++++++++
 .../sched_ext/unlocked_kfunc_cid.bpf.c        | 67 +++++++++++++++++
 .../sched_ext/unlocked_kfunc_fail_dump.bpf.c  | 26 +++++++
 .../unlocked_kfunc_fail_init_cids.bpf.c       | 22 ++++++
 7 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_cid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_fail_dump.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_fail_init_cids.bpf.c


base-commit: 2f7928516314f37d7cb334675656b4412edc8be3
-- 
2.56.1.750.gf70dc682cf-goog

