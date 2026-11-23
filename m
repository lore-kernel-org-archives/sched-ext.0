Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446041;
	b=YPXQSeyTV19wBDX8OWw54M0QBDa1J2wCnzg1riBxkH8XCia8XXi8i9OU4MmyQzlrO4wO
	 eETQTHg7Jkru9wEacIEkiA7mD6YougjptjNOnUBShf47lrDfZT6UJmwK5S1G0oPBbWMKF
	 yJ2PI5KMBMIU29Is8GUEzkXV8SCWAj2gkulcyVU2FL3RDgohj6uNe5jy4aniSwkfzFDqM
	 4oGiOx4MjMqC150b+52o7zRYkCIA48cbLQJg2jJXUyyZfyG3i94Hr4dgTPGQZIhNl9n3Y
	 F+J1YvBR4Pk32069xD3R/hO+7D2gvZXegD5R86wCtdNW2msAJY6t/26B5IpGIkxDyiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=rZGIgt43Cw6Sh7wQQz7ZyN3D/rQTxkgTC4ooK6q+yrU=;
	b=XwDmnCX6JAelNZ5t9u7PhQ0pFPbNGLyulMT9VcGiCFDjgAzI+W8/2tyfEt1r6Mtfmdc6
	 tAcF4FL3RgVGV5LRJn/u5n2oVoHWUZvCP6OGrx44l5uTo0qXqmE2d2VLCGFUhdOvsgLE7
	 mDLj5cUAHansqIKrZ2gAQVBryFeWb+g1mEPTWa4qJnqetb2R/o1vvwqx+brznzzNcP7bL
	 3AZC40VuOKpMVGTfMuRHIWQep+CYvtHOztqwEecczV0q50BbG41TQC/568x8KIBST+KRq
	 de7Lcc6KeocgEqU5DprMxtKCYIONf32kbKeP5hkslcl7kyNUONVkfH8It31DaSvSUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IMIQM8kA;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A23606A31E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A23606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IMIQM8kA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb680f0ac4so21910895e9.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795446039; x=1796050839; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZGIgt43Cw6Sh7wQQz7ZyN3D/rQTxkgTC4ooK6q+yrU=;
        b=IMIQM8kAquQFdpptWq4tM/5UU6/gb4d8bDSPs4ILCdY9in/u/8oqC8w5ItezkeakBW
         hejFOzXlRkmbnuWNif5uxAZWdo7OUiZg5M1cYq9pxMaMhCpWdodMjFHhXggczzmkfVG+
         XoE0Mjw4trKUkSR3+HXw78HlkRNKvhGiY82yNMft6f7uK0xFf/JkWeYmyDjrIUs49OJr
         kn9GDWD1G0JCaFWuwwsHd5TmW/n5/5t0LJwmEbc6fTqzWG+rxgdSmfYu5UqPbiOpyEty
         lifNsOgK4I8fzc5bgBegDBAzbt0jQIcQHzW1BnaaatRKT85F1F4t/Rve4mOqMXC2hW0u
         iBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446039; x=1796050839;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZGIgt43Cw6Sh7wQQz7ZyN3D/rQTxkgTC4ooK6q+yrU=;
        b=I46OOwzt1D323sbx0IFFzrmbf6GVP3hSzJcoUjOAGs6lWQMNxN8CWB27IAfScp3c5m
         d1HnkiW662GuZsUee9inmCiATsYjEvrGUzXxZ4TnZrgMOgzgZUhw7paWIc+B+gput074
         SV+ZCCR/0lKRtw7ZqtJV+zJ8AqI65mPIT5OWwLvKj9LhE50+cB335Buk/QIXgUXsZpl0
         xFVgomBLMYOGraCZSuhIKV412rZYX/Vpv91/fhJsQa906bnP9QbEvd5JCn9YILBsSKVZ
         Mp8LjoMuD4wEaIdva+97M0cJEf6iqlwfUSHBnUbpaBsYzhQwp7TOtDG9a2M5lKd9lq4g
         wq6Q==
X-Forwarded-Encrypted: i=1; AL+hErHT9143rk4QqMhG4TUW9eLc4OhitmblPXZmsz+aV+5u+vVCeWHa7vZOtSTbE6EZzhSQhx2SICk9gMk=@lists.linux.dev
X-Gm-Message-State: APuU4Z9AX+PhxzfZTprsiCAGqjtv+QbUmI0nmRrGAgdiorKzwb65gvNA
	DHAFFuS3CRBVqOndW3BNspyV3ci3x5ROEroQQs+RBVFwkbYnRZDTzLt/OjNj1VFzt9tBXlYjl2u
	Gq3CabquGYhKf9w==
X-Received: from wrpd5.prod.google.com ([2002:adf:f2c5:0:b0:49e:1f29:9f51])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4bb88922c81mr246144405e9.32.1795446038772;
 Mon, 23 Nov 2026 07:00:38 -0800 (PST)
Date: Mon, 23 Nov 2026 15:00:36 +0000
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
Message-ID: <20261123145927.577162-1-jpiecuch@google.com>
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix and tighten RCU
 usage in kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several sched_ext kfuncs dereference RCU-protected state without taking
rcu_read_lock() themselves. They depend on the caller's context instead,
but that context does not always satisfy rcu_read_lock_held().

The verifier treats every non-sleepable program as being inside an RCU
read-side section, and KF_RCU_PROTECTED only checks that. bpf_timer
callbacks are non-sleepable, but bpf_timer_cb() calls them directly
from hrtimer softirq, with no trampoline and so no rcu_read_lock():

  hrtimer softirq
    bpf_timer_cb()
      timer callback (BPF)
        scx_bpf_dsq_peek()
          rcu_dereference(dsq->first_task)   <- rcu_read_lock_held() == 0

With CONFIG_PROVE_RCU=y this triggers:

  WARNING: suspicious RCU usage
  kernel/sched/ext/ext.c:11170 suspicious rcu_dereference_check() usage!
  ...
  Call Trace:
   lockdep_rcu_suspicious+0x11a/0x160
   scx_bpf_dsq_peek+0x7d/0xd0
   bpf_timer_cb+0xf9/0x130

  WARNING: suspicious RCU usage
  kernel/sched/ext/ext.c:11961 suspicious rcu_dereference_check() usage!
  ...
  Call Trace:
   lockdep_rcu_suspicious+0x11a/0x160
   scx_bpf_tid_to_task+0x2ae/0x2e0
   bpf_timer_cb+0xf9/0x130

A sleepable program inside bpf_preempt_disable() hits the same check.
Both contexts are RCU readers, so these are lockdep false positives, not
use-after-frees, but they make PROVE_RCU kernels noisy for any scheduler
that peeks a DSQ or resolves a tid from a timer.

The sub-cap kfuncs (scx_bpf_sub_grant(), scx_bpf_sub_revoke() and
scx_bpf_sub_caps()) are reachable from the same contexts. They avoid
the warning only because they disable IRQs and every RCU check on their
paths (rcu_dereference_all(), bpf_rcu_lock_held(),
rcu_read_lock_any_held()) accepts that. In scx_qmap, for example, the
round-robin bpf_timer callback calls scx_bpf_sub_revoke() and
scx_bpf_sub_grant(), which look up the child sched in scx_sched_hash
with rcu_read_lock_held() == 0.

Patch 1 adds guard(rcu)() to scx_bpf_dsq_peek() and
scx_bpf_tid_to_task(), matching scx_bpf_cpu_curr() and
scx_bpf_cid_curr(). This fixes both warnings.

Patch 2 adds guard(rcu)() to the three sub-cap kfuncs, matching
scx_bpf_sub_dispatch() and scx_bpf_sub_kill_bstr(). This makes their
RCU section explicit, so a future plain rcu_dereference() on those paths
does not reintroduce the warning. No functional change.

The patches were written with the help of an AI coding assistant.

Kuba Piecuch (2):
  sched_ext: Fix suspicious RCU usage in KF_RCU_PROTECTED kfuncs
  sched_ext: Take rcu_read_lock() explicitly in sub-cap kfuncs

 kernel/sched/ext/ext.c | 4 ++++
 kernel/sched/ext/sub.c | 3 +++
 2 files changed, 7 insertions(+)


base-commit: 2f7928516314f37d7cb334675656b4412edc8be3
-- 
2.56.1.750.gf70dc682cf-goog

