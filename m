Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464834;
	b=Wprc3WJXL0KsqFe2uSc2xuZg/pjo4H9+80ygsVaoX992O624Vd7fbKxqrjXRexhrg7R0
	 d3upiFrKQ116M9gVwnfrPMUCXcDCvZ1YYgvbq8fFaDDhFh85fBj/2pjhqReJkoBdwABLJ
	 5xU5Hw4nurO0p5E/kRjzmcY2scSQyIBqKNcjIY7rnn0fkyPV+MoF0hO+fH2lGxoLz2qJi
	 s1EF6Kv98LNOW0+QfSHeGFAqlSqkd/cjHbICnxFrInAYwXvFVm9oZH00jpqsGfUatgB+z
	 7+yLNwjNo5wFWPaw603zp1mQf2jMPZyBMbRAwlwxrogc9OYWKKJBSSs90JgRq0erc2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
	b=GbJ2QN6iHMcMGrG676s0wKMJzUuh5X1K5z3V5Mi4IdOsnuhZKu60DQMMZTvlWh19ukYu
	 HyXaALG+52jhnyX2rcfSrDPG6xB9+fKf1YMJEXfLFPKEVU0nhg0fMnVuzPCFTiMLoTWQ3
	 TTkBocIpYB2Y2tGjf7lC5TMOeApm9G3QiUHrXEQ2uWeSbzEg1qnKFQEUzlO1ZaGehG0sh
	 YfHDpq1j1dq3YYOiD1DrxeG+GIXnVcNrm+3L0PzGa3NbiXzfrTDaibTJqPncAet/7hHMS
	 Y5cl1kBVVPjRXGcvhuhrBP5yDFRd3F0ds++jeMqtzb+pHXBpurN0EaJGkeKwAMw0J8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RdRLY+Hm;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42573606A31E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 20:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42573606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RdRLY+Hm
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b63b9665so2868954c88.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464832; x=1796069632; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
        b=RdRLY+Hmj6AfXRrAMf8hPGEs4l5qRZCgYfgqT/rKarPkb1LLCycZKkJjiCvtY4SVz4
         C02AICQX4dQydnzOUOLh2ujj6LHnDYoOpsmlUzEGpASNtMcoGcU4iu6PnVE5CziGp1K1
         ZM/HMjmj0F+BfD4zkTH6upiLoxvvKnMJflCE7ZvLBIiczEl78Cp3AkybXdL0C1s3snKW
         X/lug7sybvhyxIBHyNw0eiD3pCUiYCax3DUbV2+Vtp0wY8ExIMOGOHFSibuNK8uI+mZI
         hCRjiLYUnRBEN+hoxKz1zguK/xPR4Jl4K+rw8k8ssCDh8y3t+Cbb9K6qSHKzlfMzfdxs
         Hb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464832; x=1796069632;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
        b=hW/mM44nY7adHZ2/06yfICy7zck/IXe93In3ImluMa2hH1ALbXU1MHJr19fT/4Zu11
         7pDV6+hISTqRLxFeI9S+RZf/ejk05S7Gz6o1RUwVmAYHbKux9i+WVLQpYNDPWNQxw+ep
         ANs7cjdMPOS1D+RQknB5MIw+KAVZfwzUJvCV9JBPLtdGh5AtqXuAbGeeCLfdDLH8ppxG
         tDPyxKjRIjox44NPSoTxfI0F09HD6spHadTyV84YiGPbJDIBoyg2+DuxVL4Qf6BpDfUb
         +1sZgrM5kN+xadPe6v65Vx0b1lh6G/LP4jFumohiYfSk92icwUUiMkzUQTrTYKxzg0k3
         pWoA==
X-Forwarded-Encrypted: i=1; AL+hErHEnvsTvfArNsIYQZcGw8jUfeXXgcHrk7/cVvUjRdgL7CoIqUaHVjY25KOjQv3Peoc+DVVBkdsFIbQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+D1ANBA/REUfXIew1Sm0k5gm7RSC3952QJMT8sUakqeClmLX3h
	KfQ7LXwIUhbdtxU0z01Fljxxyy/aVFYDPpFZw43E9ylCdFktG7YoGl81nU6u4raLoHQT+7br5Vd
	qt+grmQ3iRaBBTxlc7g==
X-Received: from dlaj23.prod.google.com ([2002:a05:701b:2817:b0:1b2:4c55:e320])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701a:ccca:20b0:1b5:71bb:6800 with SMTP id a92af1059eb24-1b571bb698bmr4130548c88.3.1795464831930;
 Mon, 23 Nov 2026 12:13:51 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:49 -0800
In-Reply-To: <20261122015729.2512645-1-penghuang@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <cover.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 0/2] sched_ext, sched/fair: Drain blocked fair load on scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, Peng Huang <penghuang@google.com>
Content-Type: text/plain; charset="UTF-8"

v1 [1] skipped rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() when
scx_switched_all() was active. As Vincent Guittot pointed out, that hid
the underlying issue: once all fair tasks switch to sched_ext, fair
blocked load should be properly drained and propagated rather than left
stale in rq->cfs.avg.

Investigating why rq->cfs.avg.util_sum remained non-zero showed two
causes:

1. In update_tg_cfs_{util,runnable,load}(), if the group entity @se's
   _avg had already decayed to 0 while its _sum still held a sub-divider
   residual when the child gcfs_rq's _avg also reached 0, delta_avg == 0
   caused an early return without clearing @se's residual _sum from the
   parent cfs_rq.
2. Tasks that exited or migrated while sleeping before scx_enable()
   leave deferred removals in cfs_rq->removed, and switched_from_fair()
   only visits cfs_rq chains with live fair tasks. Once
   __scx_switched_all is enabled, periodic blocked-load updates stop,
   stranding unvisited leaf cfs_rqs in rq->cfs.avg.

Patch 1 clears residual task-group _sum values on zero-avg propagation
while keeping parent period_contrib divider scaling for non-zero
averages. Patch 2 reuses __sched_balance_update_blocked_averages() in
scx_enable()'s per-CPU scx_switched_all() loop to drain cfs_rq->removed
and propagate blocked averages across all leaf cfs_rqs.

Changes in v2:
- Drop the pelt.h workaround from v1 (Vincent Guittot).
- Clear residual sums in update_tg_cfs_{util,runnable,load}() when
  propagating a zero average (Vincent Guittot).
- Reuse __sched_balance_update_blocked_averages() in scx_enable() under
  scx_switched_all() to drain remaining blocked fair load (Vincent
  Guittot).

[1] https://lore.kernel.org/r/20261122015729.2512645-1-penghuang@google.com

Peng Huang (2):
  sched/fair: Clear residual sums on zero task-group avg propagation
  sched_ext, sched/fair: Drain blocked load on scx_switched_all

 kernel/sched/ext/ext.c |  9 ++++-----
 kernel/sched/fair.c    | 42 +++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h   |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.56.1.831.g720f3f5937-goog

