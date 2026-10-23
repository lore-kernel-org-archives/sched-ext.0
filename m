Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766909;
	b=Uzq20hqbeqysVUuz7YLgXUZiSmzX8949VGwHnCKzSzgTX4tvaK4ya1sTSWJfx34oeF5C
	 7UKFha6VSOiY+LkJ8rH6rYcAdV/dVpQhyaAD57RLOXUTNEc0A4D9Ywugdhpnk9NXaxGdg
	 EF8y92HJuSIs+rpkKQ0sPW/+fah/KVHUIUPTeqlGNcZ0IMw+qST+Pk3mxvQ0M3EXmBZiV
	 WJI/6vJP2Ya6Rh0zgNUtoQYfT/DTBC1l2yearj6ghr0syX0XonPfLvqKsVKzKK0bxPDub
	 cOeXrMRqiOK7146Fu11dZurBUOxpPWzR+psF3zOQLCcN2bQwKSve0AxYOMOKn5fhcVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nVhDQqSmSQk8KmRrLiX/9SHg/WhJQ9Znl0xClin8EXU=;
	b=hbEar7xEEOy4iZBuKOZd73RMer/8+QSUkAM43nPVScRKekaISUVVPcDp3cChBEdP8u+q
	 k14zl7phsx0vtCCpeWCFmxCu8X/n9MmLfCksO8DeTg8IcvB5/Q+DN/bvPE+H6M9YoZXgE
	 f3XrxznvhtDnAfCHfr87cMUZ3Mo9XRGoXYOmB7W3eXBePCLeiQ8aBkG3UUtKAsEtEYg5O
	 U0f41+i+mN1cVFcWfhhuLKjNdRJIQj469+JuAFNE8DWN7ueHZ9baQKJrV6RWsRZRyl7/X
	 S51WlkMMfIul6UgRZg1YvaAjqKZdxqnwbU40DDycJSbci4vRS6N5/f68de9DdJY7gvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=coR1caHS;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816F606A31F
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E816F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=coR1caHS
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso7619695e9.0
        for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792766907; x=1793371707; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nVhDQqSmSQk8KmRrLiX/9SHg/WhJQ9Znl0xClin8EXU=;
        b=coR1caHSaUcWP6ctR4G5QrDkU3asqipBGqDvM/I5MQyFkBfVCzoxG6SAejUFuKiz1c
         sP2p7FiTWo88CumeeeirJOrh8cH6OSMMYZ3q0lYyFYBdZnioNLM7gj0e3DApSNxyZZMm
         xl17GnxRrRGgBfqCPy+/Pty2MgOypoGovgYXH+6m7JDrex2zwKxxFlFkJLaeEDdJ3FgJ
         kDKEZ9/xj4BQDRwl8uIrnqhiIeRdyvqVTIUfq2GdHN1YVtbXSvhxVxu4+zQF3aZL3LOP
         DjUSbl+Cjrt5QJvG6EgPw2Vx9Iy0icQTryhprhFZYqE+I8V++ISXccgggzPv79cfA10t
         wOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766907; x=1793371707;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVhDQqSmSQk8KmRrLiX/9SHg/WhJQ9Znl0xClin8EXU=;
        b=KkLbnC5jqN8of/y7DVB945XenmXbmRCR4Y0/n08AUuBRVhUNSUxUjL1mV4B7oCXuth
         xlH7T9QjJ1Vd13FPgD6yhrjd7BnzxtwdiPxLnsYktubeIhQOZB8FKMA3gwm+TJuTRxu5
         CVEXOcZTt4bg83sZKr3L80Rf1u2S0vx2I12LnwoMw0dtCOS9bjK8w6j2M6rNJlejXuwD
         0CLz20Cy6cD8aaWeb2zCzKZ0f+vvMbSn9EslvgmlSmKUX30s8UKt9DgZT8vv6AMXklmy
         ypk3P74MKtnkym8j/cwl5a50rJ+z4ADj3UPMGosYybX8FX5XQh8EwG9sBByLC2cVQF0u
         FYwg==
X-Forwarded-Encrypted: i=1; AKwUvByO6K/FFrh6VzE20pjtkrABkKCW+TsWqUeJ/WQUI4YZA8L/HuRtoUVQQLD85gGaMazQ4wNkR3f2bZw=@lists.linux.dev
X-Gm-Message-State: AFq9FYJYlbTT9uqjCpIpjM18kX7330noXWAvqZ3B2kjyoXwYmVbFyRZs
	gHJy0CYNrtDL0pC4gy9exUGdYKe5nXtlol4W4rIVKQliegl2iRU3ZLAS0pCxjMD5scDNZwoKdc5
	BInmyyy2ZeFOgNw==
X-Received: from wmcq4.prod.google.com ([2002:a05:600c:c104:b0:4a1:dfb3:2e66])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4eca:b0:4a2:10aa:271e with SMTP id 5b1f17b1804b1-4a2df9b4c54mr5707975e9.14.1792766906962;
 Fri, 23 Oct 2026 07:48:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:48:03 +0000
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
Message-ID: <20261023144811.2230393-1-jpiecuch@google.com>
Subject: [PATCH 0/2] sched: Fix SCX_ENQ_CPU_SELECTED for queued wakeups
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
patch 1 the test reports that all of the roughly 110k queued wakeups in
a 2s run had ops.select_cpu() called but SCX_ENQ_CPU_SELECTED clear.
With patch 1 there are none.

Patch 1 changes kernel/sched/core.c and include/linux/sched.h, but only
sched_ext sees the effect. Peter, Tejun: I'll leave it to you to decide
whether the series goes through tip or the sched_ext tree.

The bug was found, and the series was drafted, with the help of an AI
coding agent.

Kuba Piecuch (2):
  sched/core: Preserve WF_RQ_SELECTED across queued wakeups
  selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with queued wakeups

 include/linux/sched.h                         |   6 +-
 kernel/sched/core.c                           |  10 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/enq_cpu_selected.bpf.c          | 107 +++++++++++++
 .../selftests/sched_ext/enq_cpu_selected.c    | 149 ++++++++++++++++++
 5 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.c


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0.257.gf7497c7d27-goog

