Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454285;
	b=Dye40XtoQMAJuax/KvrziRZhhK+kZie0dt+mYMpZsEDq4Nd/AqsyML3AOyz7Bq6JeHF3
	 2wObKl+fWN0sSuua0+eOhQsY7Orlzk8+V1W7OkpzxQ3PG37iNWK3XY2EeU6QwPge2JPwE
	 8qvQhFGCSB6YJ1Jp4GJzcJi/T9bZ85/dwN4r0FYYeifhJWxcppT4AXGs1E9sCHEqF+wz1
	 4WARDgyBrSAJd8338RlO1uznvzqBiQimIEYk+JjKlRTcFkuZZlHcXfTOSv7eX76n6zAae
	 dE4pjk+6mlcozJgIXbMiHJcY4LU//C46JbK6azYCCQv2F4FE7uxxDhO0noDLWmmrpUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=SjPU9PszbvbGis4LQNlKF5kEGLQKetvEHjZ+pbNntGc=;
	b=VxaGjP7MQmTYorAZljRH3t9e1n6ZlsX8dSNh35FSoaaY31B3MDdJpGdHi/yrlbflzgc2
	 C7DqpZDnCBS3C1JrdXsSM/RTcn7oPEn4CfjFGpAM5PoCzc8e25BSU0LW1fs06+XuC5Rxa
	 if/BiwtLqSOlqVTEzmhZNSkQQHSkbIVEbL5nLFQFxe4vAip7uVpo2O/twLCqf6Vz2cKTm
	 pjGetqqHFsPbi5hitmLkQHZej2UxzocEOkqZlEOiXEHBSyrLGgLQPjtMbK+F1o/1LWCG1
	 6uBDDG8xsELp1wsGtJ8JkYLeTxq1DfTUldpAxbZHRqH0Z7DlJ7rmomrIl6rx/h1jvfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EBJxy17I;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74C606A31A
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F74C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EBJxy17I
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4915ba023d4so2165175f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795454284; x=1796059084; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SjPU9PszbvbGis4LQNlKF5kEGLQKetvEHjZ+pbNntGc=;
        b=EBJxy17IcHGIcR/anRJKcdTG88BW0PIH01o8oLGN0WftuoIoZ8JfRDZ6Y/MaaSOHOI
         az/CsuHX933tYCq2lwKT/CRMnuoAWbiWGZ8fbBLC0NugrAx4BEmNbDHU1rjYPHI82KCy
         8CmF+r3zSm1jwFE3eOtNZoY5qOVoauz139GsX0a+r9YdiMFsIi0CtjxcR83p2PrYEG5Z
         EmDPUyv0iASZEgc9+Sl6ge8m2m3IIYt+D4TO9FX6SmgC3SjfFQPwiTNczrCHAWWQ5yKH
         J4Sa5zqtd3CAwiz2/H2zim98J95sARs7+OXkSs0atjba8+3arTCE144+Q08XA01vAVa5
         JLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454284; x=1796059084;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SjPU9PszbvbGis4LQNlKF5kEGLQKetvEHjZ+pbNntGc=;
        b=jw3nWqvU55WtdIWlhleiFCdcJ9yP/xF/w2Hz1BTpC9E0dG3elfBOJ3FblyPrfFA7eW
         NFSabuk4ZUEe40XAqY/ZzvEoBvnlzASv9Q1+0y69J5u58V7rtnQ43Cq3TZsInsf9Kags
         t6qDA1VuORfYSFs/5OwMg7EzUwJaSP9aIfrrlpubWS1v9gwubbxLuX3bcg1HgQ/J6poF
         0dESfUuU3QjaamnD+XLe+cxHHdRofm4JVpD6Kl//E7oB/01ykjXriMK8dxMCePTowxqh
         qK1Alw+H3qkBPDiom3U2ugei1Goo19WWSzTMR04X/99LZYIKz+uleKKpOINxCl48PLLs
         ge+Q==
X-Forwarded-Encrypted: i=1; AL+hErH8A2/PoYA2pbJ7kQpUCAwqKRzetMWRxMDRcl+jeuT7LXcc4eZWxWAJOHC+KgHu6pt+/yJFpfCO98w=@lists.linux.dev
X-Gm-Message-State: APuU4Z+s0pykyefJarwTtr0LPH7A+q4QBS5cRy3nkOLId8viBjAIAAbT
	+FAi8/q3cr838MR5EreMkUHb94yyQPHqdehGqGruA42GWSFztSQFaq/4LJzHkroH9YYUZ7KPede
	He3gA7+AMTP057Q==
X-Received: from wmbgx21.prod.google.com ([2002:a05:600c:8595:b0:4a1:f1e1:c6d6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb8881e81cmr262843005e9.29.1795454283534;
 Mon, 23 Nov 2026 09:18:03 -0800 (PST)
Date: Mon, 23 Nov 2026 17:18:00 +0000
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
Message-ID: <20261123171637.3859594-1-jpiecuch@google.com>
Subject: [PATCH RESEND v2 0/2] sched: Fix SCX_ENQ_CPU_SELECTED for queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SCX_ENQ_CPU_SELECTED is meant to tell ops.enqueue() whether
ops.select_cpu() ran for a wakeup. However, wakeups delivered through
the ttwu wakelist never have the flag set, because sched_ttwu_pending()
drops WF_RQ_SELECTED. Schedulers that set SCX_OPS_ALLOW_QUEUED_WAKEUP
therefore cannot tell whether ops.select_cpu() was skipped, and
SCX_EV_SELECT_CPU_FALLBACK is undercounted.

Patch 1 carries WF_RQ_SELECTED across the wakelist the same way
WF_MIGRATED already is. Patch 2 adds a selftest. In a 4-vCPU VM, without
patch 1 the test reports that all of the roughly 100k queued wakeups in
a 2s run had ops.select_cpu() called but SCX_ENQ_CPU_SELECTED clear.
With patch 1 there are none.

Patch 1 changes kernel/sched/core.c and include/linux/sched.h, and Tejun
has acked it, so this resend is rebased onto tip/sched/urgent.

The bug was found, and the series was drafted, with the help of an AI
coding agent.

Resend of v2:
- Rebase onto tip/sched/urgent (f4eb2ace3efd); no code or commit-message
  changes.

Changes in v2:
- Patch 1: Reword the description to distinguish the wakelist path
  before ->select_task_rq() from the one after it, and fix the
  ttwu_do_activate() name (Andrea). Add Acked-by from Tejun and
  Reviewed-by from Andrea.
- Patch 2: Give each ping-pong task its own two CPUs and dispatch to
  SCX_DSQ_LOCAL. The waker and the wakee then always run on different
  CPUs, so the test no longer depends on tasks spreading out on their
  own (Sashiko). Skip on systems with fewer than four CPUs.

v2: https://lore.kernel.org/all/20261026114429.209588-1-jpiecuch@google.com/
v1: https://lore.kernel.org/r/20261023144811.2230393-1-jpiecuch@google.com

Kuba Piecuch (2):
  sched/core: Preserve WF_RQ_SELECTED across queued wakeups
  selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with queued wakeups

 include/linux/sched.h                         |   6 +-
 kernel/sched/core.c                           |  10 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/enq_cpu_selected.bpf.c          | 111 ++++++++++
 .../selftests/sched_ext/enq_cpu_selected.c    | 194 ++++++++++++++++++
 5 files changed, 319 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.c


base-commit: f4eb2ace3efdd8b6e3b0946bbd316166edb1a51e
-- 
2.56.1.750.gf70dc682cf-goog

