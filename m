Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491925B081
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380212; cv=none; b=V4ldvNMrrNNDSkMFuT4AJaDW+jx/fhAkhLr/wLQnAfFOPBwex//jgQIknDmE8jgN6WpkEuvgXfD2K+pPTvITHMHcCB1tBaU9gX+hZ1Ikk8xCi2BKUipe478Kjwx8ZYohLY2MGd2SS9qUwKSF0vlOo8qzesBG9B7xUwKN/MaVAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380212; c=relaxed/simple;
	bh=P62Cyp5plWaUgw9n2uFlaZ514koIx+Z2Xn5bP2ce7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pr9zXkJTTkijQmWkEgaw1q3tVcNDHAShNE09sA/fSnPITyqyRXlXlytZcbAo8pA4YYOrkKB2/blbkByq98D+MF+O2coWaDzyx60mtCZju85L+dlsViqwXilUDuyEZnhd961vHza64cAmW8+L81sFLTjIqVaDStNkD25nWPZbZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCoGyn3/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCoGyn3/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-83d31ac4017so3108476b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380209; x=1779985009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQd6/fi2In6zkfYaJSiVJvX9BwZpPa+F+dRko1X3xlI=;
        b=NCoGyn3/5IpnIu44l9EYslEAIFFGg5u+xJSpoyGbvhwbC7fKUdrEG3nyqkQUKOBf3a
         g+oAfz76W7bhd1+uR7v2iLyxlIMcdO1b9Mej7oOYincYaCRwils9VVNDAGFbynzeBBgi
         5bXARyATiPB2HLkp770Q8T/Kkn4gTGNNuBRXd4dlTmt8dOiFNl3kL4RlXWp7TED9hPdB
         qWMv1dEYsDSi7ykwMP7WzsWOiJx4+DDJcVfKuTrdoiCE2SYI5EpMn5eqMcIbzbq+n90a
         QzMomKzPa8KL+p0RWjqyzhbjKJfyfvR4Ci60177UekQC8kAopV922D/5YKdn2B5GPUN5
         Zt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380209; x=1779985009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQd6/fi2In6zkfYaJSiVJvX9BwZpPa+F+dRko1X3xlI=;
        b=QmC3yYdr5gIzKKWkZIhRJl967XnimnZmo89Ljc7xpA/v7iA2s+g+OIg0ZAAjOKYFAK
         a7e5Hbb69lyMfFXxVF0eRYMSAYuEFEcCSL94UI3OsaPuM6QCka4CfDBwar/sjv14O01U
         pcHfIfv2nofc6Pt4ghjCcVlkTQBThrHYHWPOC865Ud8QApzFI+Yiu3GXFoU8+Omp+y43
         dNo8MtAehQ1K7JDHbJcHc2hBup7FyCddTXBV12x3xrkSC6q+PCR4Lx0qMckQ/k0HlxDV
         B8+X7MRLlLRKOQlUKZNWKblvsPs5GaHu0OBwChVkSCwGhjK3Q7kWNSyWoqQvE19BeUgd
         p+oA==
X-Gm-Message-State: AOJu0YxqpR/vTWgmW5G+HcRHHnRJhQLpY/t76T2eVtls04U+0Q79vIE6
	qjOdJOjpilXbZfY1XwzbMa6m0GHFVr5Tn3WPw+8lrm7ttJ/zkWUnlketyxF1VQ==
X-Gm-Gg: Acq92OGXdopS2VQqQlEhCSwOumGhequJHkpPmixLPXzc4Ch8ftReOPRfOif+meZikMk
	9J3lfSOsh5eCVFhgSfmGT3gYCEAk/t1xaxb6UHZc6z0wsFfYI84IhkJk2f5gJlqD7lmYKc+Ed7k
	JCewI8brNlsgSeHgLSky6S6FwVWdFKtuiWI5fqOCRXetcYgshCghbjnEhvhpz7CqHVklTLhGzy1
	uNorVHWeI7T5i2Fr8Re9/71bEIqCo9ZSPGqS9qZAwHQ4Rj5GckPOo7bbafM0L5P8h0dnhxkKmsK
	p2ZHzuQJ1TERSxI3VAVMTeLXocxkPOZjMfU1fouz8/RV1QOgYsTTOdjuwFm4OPqElhVKsXfXFgf
	upvZi7yB9ZomTaAUY2TMPNINHmprkI0yHtUyqwHcadJxwk6TB4O9CWXyz7EPxXaFBSmFNDb63Uh
	oQmMOBUCd6HvK8aZldKRjX3xlF4v9T190roD4iRDaOyCw92csRkz4bI0rhbk4sPDxaKSZFab/ZN
	w==
X-Received: by 2002:a05:6a00:4c8c:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-8414acc6e8emr3752411b3a.21.1779380208635;
        Thu, 21 May 2026 09:16:48 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:431c:aecf:2272:9090])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549c4806sm1729493b3a.6.2026.05.21.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:16:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v5 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Fri, 22 May 2026 00:16:08 +0800
Message-ID: <20260521161636.1893894-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1], discussed in v2 and the subsequent
review thread [2].

Patch 1 fixes exit_cpu accuracy for the hard lockup and softlockup
paths. For the RCU stall path, -1 is used as a placeholder until
patch 2 threads the cpumask.

Patch 2 upgrades panic_on_rcu_stall() and scx_rcu_cpu_stall() to
accept a cpumask of stalled CPUs, stored in scx_sched and piped
directly to scx_dump_state().

Based on sched_ext/for-next (515e3996a4c2).

Changes in v5:
- Replace dynamic cpumask allocation in both RCU stall paths with static
  rcu_stall_cpumask and rcu_exp_stall_cpumask (Paul McKenney).
- Link to v4:
  https://lore.kernel.org/r/20260519171745.1551340-1-yphbchou0911@gmail.com/

Changes in v4:
- Store stall mask in scx_sched rather than scx_exit_info (Tejun Heo).
- Use __GFP_NOWARN for cpumask allocations in both RCU stall paths.
- Link to v3:
  https://lore.kernel.org/r/20260518131311.1170786-1-yphbchou0911@gmail.com/

Changes in v3:
- Drop patch 1 of v2 ("Normalize exit dump header to 'on CPU N'"),
  already applied to sched_ext/for-7.2.
- Replace single stalled_cpu int with const struct cpumask * in
  panic_on_rcu_stall() and scx_rcu_cpu_stall() (Paul McKenney, Tejun Heo).
- Thread cpumask through the expedited stall path (Tejun Heo).
- Falls back to cpu_none_mask on allocation failure.
- Link to v2:
  https://lore.kernel.org/r/20260504161543.674488-1-yphbchou0911@gmail.com/

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat.
- Link to v1:
  https://lore.kernel.org/r/20260501131521.161852-1-yphbchou0911@gmail.com/

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/
[2]: https://lore.kernel.org/r/af0Gn47y1Lj2BAqd@slm.duckdns.org/

Thanks,
Cheng-Yang

---
Cheng-Yang Chou (2):
  sched_ext: Fix exit_cpu accuracy for lockup paths
  sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled
    CPUs

 include/linux/sched/ext.h   |  4 +-
 kernel/rcu/tree.c           |  3 ++
 kernel/rcu/tree_exp.h       | 10 +++--
 kernel/rcu/tree_stall.h     | 13 ++++--
 kernel/sched/ext.c          | 83 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 92 insertions(+), 24 deletions(-)

--
2.48.1

