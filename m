Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7773ED11F
	for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110010; cv=none; b=irxoGZijiIHes6oduxPtqKZ6GQ+oE8SOZSJ/uvcRpjHA81u1j0r31Jsxqp05OgS7iypkFYAChZa1LV1jD5bmq5gsLrqZbD2yBQYsila8vdcEn5OVnJ3WK838XMGkRBUaqRdID74JaGMMJnQlepFCMqTwHEr2q8Om2n7hRy7jKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110010; c=relaxed/simple;
	bh=GiEkZMkm2x4I0jKruTe/O1TNuhy40/QVV6JTo4QA6sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJJV+CWym/mWNgejI0FV009OY5lkKyAdRzlFIJ7UO/upN7DRtIHMAO3GExFetEwEoDSXajB7xDh8T7EJTN5/J6eM7qdno0kb6KcPAUgBhaqNu5FScePg8lFifjozDTowMfB3407n5WrVb+wUDpYn0qoYfFWa1ZFBSn5B/BrPkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlLPuDfq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlLPuDfq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so1302520a91.1
        for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110008; x=1779714808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16E2PQZmiE6IrGqbWtSpGp/RWymtbpDf21NqZrAM3es=;
        b=TlLPuDfqJDmRxArhODIOxobLLg+LO+dK9/KOTaW5KgQ1d8WjVSrj8ET8AhQjpN3Ytv
         B3rHPO3xCha6qvUZzONUQcI+a+oRDed2hdVmevLph0WgXFb9AgaMKAJgLJJnVHGbI5xp
         BpvGMj+Lz7Z7FB7HhxJv8PeN7hmVYAQFg9Kv7d07/alCLQtRToI+KNguYKtjapIGWDHr
         2TiXpKchwjATolJthzIphwkw3t3zGAqEyJqZzfGKTEzAPcNvXstSYvmvO+2o6/dJlrto
         MlaFI/oPXLVo4eeYYieI5TpAyS4AL/sCkdmeHwu4+bitgrWw2D7KZpOkYrx9iHVjLd9M
         6ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110008; x=1779714808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16E2PQZmiE6IrGqbWtSpGp/RWymtbpDf21NqZrAM3es=;
        b=qSRKUMkL+m/33yBp/vA6O+IYDjw3LwVxIncB8gzwPmL7p19Z66EteLeEVBADX6m+Ns
         DUNfg1d+ou3diyJOXOtrVYlz0baqMonZjOBRRinN9ZDrv0nROcuOzqCuWV0k9N/p/xNf
         PoRhRvDMUigyL+x0NQlw9Y23CMK5herAFB5HkNi/l3uC6mSRajbXEuhhLMtyksxY7N75
         IwmoAdbOLLIGsKvtrQFO39CqpwafG7VO90VQdcl8zp4snPZp7qNLsS87o7dfuC/wK+dC
         gl0WCC5Pa6zEmA5JQSDeumuKkDbIAmWbwMQjz61DGv+zJxBFMd1HfPE2VDG3Xa2xEnb6
         Wdww==
X-Gm-Message-State: AOJu0YwWM6yZw0ZTwbEDCkrwUQEmQOl+AwwKHa9FLQdtiByphf/tr4XP
	2mC1gGzoWdX66IicqdpBneMOPtWcWYjhnXb0m2AGRm9gqYZOnHAJvroAq45XIQ==
X-Gm-Gg: Acq92OGCP1o3mnFZYVhUd0j9QdGo2bJQd793qMGLvBQ1sjff1UeRLCd550sBsWhijbn
	P3JFohYBLdXSQ/AUwuBtvyJcjBVWzyhXZav45RwG9WtC6OHrNOIcC9g82EWfjG3gj7VeZew7d4J
	j43zK+YZYhDAP+xmjcZmhukthunE7iGZg8J/fEEbpz/srQ6JjudA0oq3idkxg7alTBR+lfUlWuH
	ziJop+iq0pxTW/kOYM3jFkPtto1Iy/WuNF0kKfjoO0zHOmNA9yidpvnTEkE63OS4EnRw+9M9BU4
	jzl3f2hwZdgsoVSMyaRGZDFcITGP6WNCb2U/EKkVkfbukA4ncNA48/iBJiHdKXn7qZstfqQZ3b5
	NVOFepGmCSD+G8wBdU+DLcYXuzhP/wXj6XDTSNAvEZQH65D8geMsZJDyrCVZtVnOb4KaD1FI96H
	rFSOpGH+gJq98NyMResEAqHo7Mry4VaAzUUg+LsOi9ffoa/KMEk4qa
X-Received: by 2002:a17:90b:2743:b0:366:4a47:f267 with SMTP id 98e67ed59e1d1-36951b83b77mr15475516a91.16.1779110008155;
        Mon, 18 May 2026 06:13:28 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c31b:5187:c514:ac40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm11241781a91.4.2026.05.18.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:27 -0700 (PDT)
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
Subject: [PATCH v3 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Mon, 18 May 2026 21:11:47 +0800
Message-ID: <20260518131311.1170786-1-yphbchou0911@gmail.com>
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

Patch 1: Fix exit_cpu accuracy for the hard lockup and softlockup paths,
which were recording the detector CPU instead of the stalled one. For the
RCU stall path, use -1 as a placeholder until patch 2 threads the cpumask.

Patch 2: Upgrade panic_on_rcu_stall() and scx_rcu_cpu_stall() to accept
a cpumask of stalled CPUs. Both the non-expedited and expedited RCU stall
paths collect all stalled CPUs and pass the full set to scx_rcu_cpu_stall(),
which uses cpumask_first() for exit_cpu and includes the full CPU list
in the exit message.

Based on sched_ext/for-next (d83f90561532).

Changes in v3:
- Drop patch 1 of v2 ("Normalize exit dump header to 'on CPU N'"),
  already applied to sched_ext/for-7.2.
- Replace single stalled_cpu int with const struct cpumask * in
  panic_on_rcu_stall() and scx_rcu_cpu_stall() (Paul McKenney, Tejun Heo).
- Use cpumask_of(smp_processor_id()) in print_cpu_stall().
- Build cpumask of all stalled CPUs in print_other_cpu_stall().
- Thread cpumask through synchronize_rcu_expedited_stall() and
  synchronize_rcu_expedited_wait() (Tejun Heo).
- Use cpumask_first() for exit_cpu and include the full CPU list in the
  exit message (Tejun Heo).
- Pass %*pbl directly to handle_lockup() to avoid intermediate buffer
  truncation.
- Falls back to cpu_none_mask on allocation failure.
- Link to v2:
  https://lore.kernel.org/r/20260504161543.674488-1-yphbchou0911@gmail.com/

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat (preemption is enabled there after
  nbcon_cpu_emergency_exit()).
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

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       | 14 +++++++++++---
 kernel/rcu/tree_stall.h     | 15 +++++++++++----
 kernel/sched/ext.c          | 17 +++++++++++------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.48.1

