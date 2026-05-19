Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1793DB321
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211090; cv=none; b=OjP4ERDDwiU2fQIfmqllcEc5VGI4v4obT0ubw490PuZhjZmGAfV06/F0jjcy+t0cCon7X2MuH+eK2VDPJGzdGCAZ2gGc+HOfReef4Q/hkHusr6bMuMvFoqTJOK6PlsFZSLCaRF+/qijbw1BIQByyY/tu+IXlyxgqsj6VRbSQ4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211090; c=relaxed/simple;
	bh=jVJJDUj8+PjwISGS1w27b5BIwI/zVSAmcpFxz8EZ3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhBtsgp+BKc3WUfrv5LuXwCfQ1KblJzcAKSMbiUHJyKPKOnRKbkYeuzgv5tiyB7RjKRPdmvSg1rE79oxMn/oi9Rpf0kLOrGy3xBLJK3O4mJ2pgjbddoW6jBsh0ZCbDjBYuAQhLo8FcfiB6HB7p30mVqJsaXf6WKb8woNJd1kTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/MZKUc5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/MZKUc5"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so1949053a91.2
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211087; x=1779815887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TwRvLveuMRBQLS2zF3jBM94tcspTaYSUuwSyp0/s0g=;
        b=p/MZKUc5hSjelHaySAGSmFN05f6zXyXBOSpNcMD8BXicf6vdrnM6GLUly6sWzvJfl8
         Z9ddk/SrTcLBgCaalZG4rBE/T1YSHvkdnkYQ6e/UIlC1hFOc9TYfr7NyyDva06Qf7GJk
         01fQTCsBjdeaIcch/3sy9n8jYpVQl1INymc1s7YjAvKmDbOJrrNrHgkbYh8r/+Zi2Vs8
         q+ILKhTPJCbsKyQzVA9/PFqOO/imyE49EsGUlLXVAaTpBgitKw6pngw4bltm6zdt87cN
         t8ympXf2Lpx0xokf5BKp7FPpt60k0Cn3yRlXnVIcRiNVYm0ilGXe5MI2qVw9cjDcK91K
         ldnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211087; x=1779815887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TwRvLveuMRBQLS2zF3jBM94tcspTaYSUuwSyp0/s0g=;
        b=Ku6QOSjIOOdx4btG2sMjmCNBRdN79GRajjvT3mmXu1fIsFO57d/Aea6k3GzrXfgvRd
         6cmeZxhxL5oVQqQAI6Qq1yN2c2in/zBSgAa4g1l6+25EJR+vpIVtZiF+CKGKkjhJVAc2
         VLvqYvJ0WwubOqN/HJ7pzq6JUluZaTq9ySzxNleF5qEV2JS4h+wq1feXSMQJaDozQyb2
         e4SFJSaTKZt6DEeXowAhKkTYRplzf4qBLmMvxxzZMb06wiAIyv8F4DEcUOvuJwL2uLpl
         0d2+S+aIEndXA7xzDiBkG6X1Pw7YnvlvF7i8RvpiM/xptKJl4dd3ERNKfVGPk0gF4Inv
         W3mQ==
X-Gm-Message-State: AOJu0Yz4PUxjk3ZWYOKo7D7duEnKRkxrNMhUAAbNNh+TwFdnsE5kY91F
	uYsfKsQOz/nKslISD8t3u1YL3rzJehmGjS1+vPnJ/lnRkJmYVCKKe4czQCzoHQ==
X-Gm-Gg: Acq92OFI9Rf0JdyxTPGFJKtmrT9yfUUSYS0VE4/jGKX9bCkuxOZJP0w3PJ6uL4dZcKb
	P9RnovqY7tytHaT1Oky/xRwsush52E+RBPkX7Sp8ri0aBlPlWwHB/SftjHmZ9HohflAciMRuln6
	YrbP9c1yqC1rYLrasmXgkwwp+7VYf7gSnvP2ruw0wN+MJSN+YDI2UcHMxoBtU8NAVeCLmbUUng0
	ARVNggk4X6nFsKC7WdOIwGJ6v00O7yRN3uKFkPg/M7R0VwM5hC74QkRO2sBpWI4fpfaqj2xoNwh
	CiubamKPU4vIzeddH12zxxdaF5nIduXyU51juCrRZl8ccQ5OTTEaABrn6CXdCN4LLBzSoHpNj6v
	oMxTXf0QnjCXYt8ZaJAA6HfTAz0AAKRJb+RcOzGvsGNdQt2qtnZEOOr+/guuFg/WHLbb5ESYZmW
	3pifQLiJbq2WsDTSWr2CcD+S9EWzhxgW+wrgEhD0IdB4/TdY2P6w==
X-Received: by 2002:a17:90b:4c06:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-36951ca601fmr19693758a91.23.1779211087202;
        Tue, 19 May 2026 10:18:07 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:46ec:2327:9655:89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm14370012a91.0.2026.05.19.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:18:06 -0700 (PDT)
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
Subject: [PATCH v4 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Wed, 20 May 2026 01:17:29 +0800
Message-ID: <20260519171745.1551340-1-yphbchou0911@gmail.com>
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

Based on sched_ext/for-next (d83f90561532).

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
 kernel/rcu/tree_exp.h       | 14 +++++--
 kernel/rcu/tree_stall.h     | 15 +++++--
 kernel/sched/ext.c          | 84 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 5 files changed, 96 insertions(+), 24 deletions(-)

-- 
2.48.1

