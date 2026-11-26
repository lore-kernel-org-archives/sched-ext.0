Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728813;
	b=E9rnoTsUtangO/50Y+AdcYMmrrBQ/oMe5xKM8EIcvKtO3k8xxKqrivUVdDdeaFFd8QdH
	 6pbeefBWtx+b3X+5eYuERwJl0ixkv7JDR83GUXmfAQt7kJQSHC4LJKRoihn7LbqEu2plJ
	 j1tqDWB7DjHpJJxGCcSs2TQ7mp1DUQhfL01BbzUFIL0CRQkHNqds0gp8tr/Q9r82a0WVP
	 x3NFdHkKxw2CvIeSoJpuwuYKBG84qjS5CNFs1e7AMfyhvaq2RWTHf2JSwUy+AttIe6pj0
	 miGvFCK01qOU5e+hO9ewN3+IytXRs18QaU5ziRkZ9eilqsWpVKHuEFnA8c7GA7fIXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Vbo+pKIjO+GhRtx4yJ4Jqz9PMjuckddFrEcKv85cuAU=;
	b=XQtNq+lMlYX7NQa5/z3dLWcyRRrOSbMUdUrIRmBoSo2yejG99KhITUKz23TnBV8mbcg4
	 YbUBxexuZCjS0h28IXHyDMQ0O5+rAi/YzN3p/uvr70LjHnz57npvwvvk/csIckd0hESNB
	 PGMi0rc9ZMkVNU7bhJkwHZjETcnn8xK6fxA/2k/LV+Q7j/AUYID+P0e50tVWb39KLj/4r
	 acpCuwKiUFhHpvLv0qQFM/7ZVMc/7zTJWezjZ0k8+1OBBDNvVijSmOGne2GNGzlURjPME
	 KJav6cfKs5WIzDu9+K8YdpPOCAclYDfA8Z3C82XlOgWg1YvaBpZaCxFeLzXpoDEMOrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lp/T0w0o";
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C6606A323
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 21:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A14C6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lp/T0w0o
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso52960815e9.3
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795728811; x=1796333611; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vbo+pKIjO+GhRtx4yJ4Jqz9PMjuckddFrEcKv85cuAU=;
        b=lp/T0w0ocIl7zt7HKeYNQ04fTq9X67SPCScDNfAgoM+D5gzgsy5PKIdRp76tuP3eNN
         3N67jcF5aiUznf0B9LFjbF3G2CJaw6G3s0oU0shNTyBsCyXY019ANe2wqbbPuALTs5eF
         solBe6Y6KI4uy6nM7xa2B+F3cKGVNq61Gx93k0y8t5QSbfQEKwv+LhqZviDjeigQQtCF
         60nizaidde/dW1bAAC7uoBtY0KakP55hwrrpKuKVZqzO2KstIS9hNoaHA0FG9JvYXXXA
         5btRTz7rbBZ1xtU1PY9u7up9MmX/rSdVT9ERKmt7Y0LAgff2a9YNfN6RvocNYaPL3k4g
         +VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728811; x=1796333611;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vbo+pKIjO+GhRtx4yJ4Jqz9PMjuckddFrEcKv85cuAU=;
        b=MoswIahETcqXaRda9DwKnAT44ny3cu8NXB6NGDSeeaOwA0AGJMqfzZYBMMxY4+wBdW
         9BbGHziIld/z7y7i5LQxWrjEvk1vg1qJFNXawPwRaZgagZktbc/HukqF5aIN79wVHRBt
         5H9pSSTeyWXTZa5ufK0y+SVgtN4jQMb+cv4vFaTvncCSJGgMOVOJOaPqVruVMy2cY8jg
         G+ISTw0OP222sL4S2vZTrZx5X0DPDRaIcvZUqIkC9MKViapRRovGx1NGdmlPJAbhUSY8
         ypffYfFGbngfKVHtF9mvBGKi5aXwynpmFGMHqooTohenQtTKfUw6p8jRHn6YZviFzAT9
         oX+w==
X-Forwarded-Encrypted: i=1; AL+hErH7YQnBoB0xldQrmAf/E3t25NoRdOre2n/bSEsssaEw+VOGpiF211TXopgNw2lhkQpElelloA0xQLQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z9UbBBcNpMQ4Mva48YuR5kvGAgkHwtgagjWS6CbWtWsKoAl3a2P
	c8jp3ZHEcw98DIbPUWZ8D8MnejNOrqUoNDDboiCM686sjmsqtB0zIY7AbqeqwvpRNJDWdAnX9uU
	/vgjVMYlU09S26Q==
X-Received: from wmjf12.prod.google.com ([2002:a7b:cd0c:0:b0:4bb:5d5c:ab85])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:e549:10b0:4bb:a60a:fc8 with SMTP id 5b1f17b1804b1-4bba60a11d2mr84875965e9.35.1795728810936;
 Thu, 26 Nov 2026 13:33:30 -0800 (PST)
Date: Thu, 26 Nov 2026 21:33:28 +0000
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
Message-ID: <20261126213212.3930589-1-jpiecuch@google.com>
Subject: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Enforce SCX_CAP_BASE in
 core-sched task selection
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Under CONFIG_EXT_SUB_SCHED, sched_ext enforces SCX_CAP_BASE on the
dispatch path via scx_task_can_stay_on_cpu() and scx_rescuee(). However,
ext_sched_class leaves .task_is_throttled unset. Under CONFIG_SCHED_CORE,
sched_core_find() and try_steal_cookie() select tasks directly from
rq->core_tree and rely on sched_task_is_throttled() to filter ineligible
tasks before bypassing pick_task_scx(). As a result, a sub-scheduler task
sharing a core-scheduling cookie with an SMT sibling can be picked or
stolen onto a CPU where its sub-scheduler lacks SCX_CAP_BASE.

Patch 1 implements task_is_throttled_scx() under CONFIG_SCHED_CORE and
wires it to ext_sched_class.task_is_throttled.

Patch 2 adds the sub_core_caps selftest exercising a cid-form root
scheduler and child sub-scheduler on an SMT pair, verifying that a
cookie-matching sub-scheduler task is not picked on a denied sibling and
runs once SCX_CAP_BASE is granted. It requires CONFIG_SCHED_CORE=y (not
enabled by default in tools/testing/selftests/sched_ext/config) and an
SMT pair plus a third CPU. Without patch 1, the selftest fails with:

  ERR: sub_core_caps.c:534
  Sub task ran on denied CPU 1 via core-sched (run=6 deq_cse=6)

The patches were written with the help of an AI coding assistant. I have
reviewed the patches and verified the tests run by the tool.

Kuba Piecuch (2):
  sched_ext: Enforce SCX_CAP_BASE in core-sched task selection
  selftests/sched_ext: Add sub_core_caps test for core-sched
    SCX_CAP_BASE

 kernel/sched/ext/ext.c                        |  11 +
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/sub_core_caps.c       | 616 ++++++++++++++++++
 .../sched_ext/sub_core_caps_root.bpf.c        |  78 +++
 .../sched_ext/sub_core_caps_sub.bpf.c         |  84 +++
 5 files changed, 790 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/sub_core_caps.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_core_caps_root.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_core_caps_sub.bpf.c


base-commit: 0919f8bea37e7e354b342c2dff52dd8f5b958d6a
-- 
2.56.1.839.g22a8290db9-goog

