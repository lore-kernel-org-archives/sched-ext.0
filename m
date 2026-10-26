Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015074;
	b=kMabVLPM6Wpw4sN5tnGCEHCqr1VOe/qNZWuADc//ktRWB4RIDiAVmlPPN+RkZ49wldIl
	 gQQz8D2wD7zKZNmgd+kiCAUpaxSFPEer8TB94tDhhUKe9odMYHDotElMAuO6s3krtJIDT
	 Xi7ldMxjOdjqwC3/79u6uv0dBH1mKabIIEw5Q/q/Y6msA+jFSQuYwBYHuUG7W+KkMz4fU
	 pMLwsX3Armgz/QJEOxD/6YtJWcsgHMUh9ufnLrXj/TMqVjhqy/Deenvmtczhwm6vtYnKW
	 BoKS0F9a5HcbagkugnZ2SQ17006BRKIYQk8JFUSbaWqzx4rBy1keGriMxBhj94TMJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vqQ93B36gXOYRk9a5z5qRqknUPXtToTVq9tjvdoga00=;
	b=ldRZUFVJS/MsUVdGgb7Gv/5a/79ddT3hQgwNs49pOiz7271pmLxTCmIIIuEwVbKL7dVu
	 ThdTAxu/b9cIwndQh1gkRnRGvE8/QOLX0l+rGOQq+68jE5jfjnGmdvFpsQ70/XEyxW19z
	 +9StcMjXg+JC2Ra56fcBpW1h+bQrGtTIJf+R3rm8PT2mSkEUSiiAZasID9KbOuCIi0983
	 V9qnsmGNijfAjlMAoC665FfLYn+NgG3Dc+Aqpsk3FBPdGSF0udOE1v1lmnfqzqm/71TIW
	 FpD5Qt2/+jhpNfWKWVJd84Hadu4ay/nI6cwagYFO6z/5OI3YfUckflSynNmkjPiQciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R6QlSmpl;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C606A31E
	for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 11:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA8C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R6QlSmpl
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso1992109f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 04:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015072; x=1793619872; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqQ93B36gXOYRk9a5z5qRqknUPXtToTVq9tjvdoga00=;
        b=R6QlSmplp2aLJkE/zhMq33JpexInpwozZiG1me4i5oYGiUvxCzFhRn/pvJfSqEBo/T
         sAmx5YZJbfwhqNo17aZCE2fwMtunC3gZHgGKyiJbyLq6goZhqZWXZaCGXXVZ9WA17/nh
         yhIG122JjPOk3I5mqcZzCPnGKwwQr0O0uAnQv2ivVOjDAe1IQzczzHA8OejQJG5qYdZL
         +1CqcOa399Lq0WC93NnFwtSsCCHz4BfkBz8FCi9m/M+8fymHCNiVppzg8T5n6dtwWaAj
         Q5+1VkHh8JWKowXLsW6yA3z9I+hiM0zu9F+e3RT8/uRuIekPThvkHea9v5BQbHJIJvSd
         jHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015072; x=1793619872;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqQ93B36gXOYRk9a5z5qRqknUPXtToTVq9tjvdoga00=;
        b=m/lFJuIslXlZKxdeI0RAD7A8Ucr/Tnt2iGwWnenLDGau4LQ5pW+05VwKRrggwsw65c
         LThl1JaEcJTTXymp61bX9rIexKoNWWiouOr9BgkPtSVwlmOF/kcYno1gvW2ve6Jz7dCS
         oQ+OfZ3PX/Qt4e3N3uYFFGcjgCpSyd8QCMnzXiUO+/5ElJC6MLLSoD2Veb45mBSyR+0l
         ltN+5e/ahj/33Bq1QjX5/htRpoLPDrehEDrtir3OtuvwnbJsn9riRolHFloRdfatgpnW
         DYuoZCMvGuS/yt5gJ0xKkX6a16HNnNMuJr56f+1Dpuud1QkS27dYWBvVtzd/m17fo7md
         cW5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxiv+4EkHUGS4Ica34bvP7QTMJ+7QpqSf9QVo6tESS52uBBJ14VSUOhzBEo30pU6mskUGRAMxK9LHI=@lists.linux.dev
X-Gm-Message-State: AFq9FYLKlwal84E+ZCQ4XnvmUnDGNH+tIP9SeGG1fOPiyQxYlgFL/Lpl
	wwdYi4DKQwbViaQK7LSMUO/JOj/cdBvGRkEqBduc6hhufc/N5B7lK/dAZIWxJJojUPwbV78ZHA0
	iO8NuXMP2fHg1kw==
X-Received: from wmcq4.prod.google.com ([2002:a05:600c:c104:b0:4a1:70b0:32e3])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e87:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4a35acaa6c3mr119154455e9.30.1793015071769;
 Mon, 26 Oct 2026 04:44:31 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:44:22 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026114429.209588-1-jpiecuch@google.com>
Subject: [PATCH v2 0/2] sched: Fix SCX_ENQ_CPU_SELECTED for queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
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

Patch 1 changes kernel/sched/core.c and include/linux/sched.h, but only
sched_ext sees the effect. Peter, Tejun: I'll leave it to you to decide
whether the series goes through tip or the sched_ext tree.

The bug was found, and the series was drafted, with the help of an AI
coding agent.

Changes in v2:
- Patch 1: Reword the description to distinguish the wakelist path
  before ->select_task_rq() from the one after it, and fix the
  ttwu_do_activate() name (Andrea). Add Acked-by from Tejun and
  Reviewed-by from Andrea.
- Patch 2: Give each ping-pong task its own two CPUs and dispatch to
  SCX_DSQ_LOCAL. The waker and the wakee then always run on different
  CPUs, so the test no longer depends on tasks spreading out on their
  own (Sashiko). Skip on systems with fewer than four CPUs.

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


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.257.gf7497c7d27-goog

