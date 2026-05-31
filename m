Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6F345CBC
	for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241275; cv=none; b=BQnnUiZoRNEdpnihrIFJb/8H+s55e40HxbWbFF8Ho98RmtNnZVgeQPnbWw9a/HFfKDNwFf+WpWDDg7rjYrJ+PweIYvyDT+Rpgswf8+TDW9d86Pb6TpMU8vnQJj3dLdsghK3bx8UU8ISTYa4iEd18w5f9T+eunzrQvyMOL29lByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241275; c=relaxed/simple;
	bh=VjCJylqdfAQWj9+KnBFgVKqM4UADrEfypRh5XSComKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxrMlidWdYnE2t7slNJ9T/ZoDs9hrxpe3vy+73Nyq7SRxc/0ZU1HskICp+fzLBmGIfMhbg+x7Zfis3xn6+bA1V7aiiy5pDR0WL3TRrzY35ENy+cVtz/6J4mRkU0ojiKtKPh5mmojNSjNSbRvvQivaDk3WMxq2QnYs9+w9jQAIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eghrLDP+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eghrLDP+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0aa420401so6000505ad.3
        for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780241274; x=1780846074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8U6hfJxoj/rPCBmp3s7bgS+TKfume2zkXAj7Af2fpo=;
        b=eghrLDP+FdFOCv/V2xhAiXsSihVBYNipAgfiHKHtq6Nr+DiGAayYexAmR5Mgs6fykf
         0RY5dPSg1mk7flRpqvGMPrxrtcEbgD4M+W+VO1hNujFSiUS1zOqaCXRR6I09rGKrdA+4
         mG56ymce6iBkWMrT/SLtc0Lu3Fw5HOE+Pud5kxcpKz4kNDZIfh9lnNsmVd2RIW3TfSlZ
         EdghpMJM7cMD6E5ZR/4iEPlwy+WS6OciaoOWV9YlVkwBI1uVqYbD/bnmweLPKn3lCvzy
         QewZUe7zDaw/T6Qy1K206gjOlLKMmDdrC58/RPMLNfOTlXRHxO9L42Tr0FoRu0lKB7Op
         FzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241274; x=1780846074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8U6hfJxoj/rPCBmp3s7bgS+TKfume2zkXAj7Af2fpo=;
        b=VH2LGZw7qXkwoX/uxIwJDLk/ZPHgyPRMGQS4bOrl4rLg2+w5DQNFeFDbbwr7Ezkn7Z
         l8sdXsIDQeUiw93X5B6V3unGLV3kT3UmlAAWdiwg9zHC8pyCFYxdWx4Bx7bcYvDt7M8v
         y2vUJEac5Za6E6tSi/a6lY+kZNLb/dzJfoKgzErNbqVvxSGqgB0GHcdg4rH3UVFSzqrt
         Y2sygeoAmUQP9vLQuOa/mE38Ic3ZPGceBmXnN90VKzD4DFArtcik+q/pT2dhu6vEaTPd
         c3UBPBhF06SSIKS0kf3rQJBLqlK6cgVK0NHinOLpuLw999ilq6+gT8Yoo6sIheJaH3Ab
         iDOg==
X-Gm-Message-State: AOJu0YxFUncCJk68B2rs/QQbFe0jtq8sWputGg64+ctBUF5g/ghZNooH
	AGQsUfMFZxY52xNo1AIhREMdj9tMhkIkXuM4E9iJcBRqC8KtjlO2e7XPn/+rPw==
X-Gm-Gg: Acq92OEtIwjh6qxQIXeKBnsioeeOIkQZ+KgglShwU2e7i5Xs7Kwnb9qkjFNMJXOal86
	qj26roUrEbn0u9Eg3P1hNK6jhXCTPOtp9x59ggoqmxwDd/fzHz7+1vf67E1fxEIkEzy1+rETVPn
	VXuY58A7pWEjP8p5rDHqvma6QzHl2X/d9lykq/IQjpRtwTcQcOdhIHteBKttAe3cEweUi1pDN+W
	UHxmed8O7hk86tiyyFKy3FkYRixTrW1aYCspM1PaOgNzlmvAYEyeK0Vd7r4K7LKV+LddQHlP9Vc
	zwnRTpVEZyM9gyRuHaZ2myURvn7TW7k7LYo+GZmCh36VLRs9grjpS8aE+59RWENNk+Wg3/s41MP
	EE4xDrHHiN3lcEIJ3hgV19tlIY+rw+XsY4BG4JEmo1Je9FSjHlv1rHBA9FT/YlP2COjyqufhJze
	fAfOgZDyOqKnotYTryoGeJL9F2AuUDD+bJxnjganRSuvRs+L2DY/cUC9u1WlsyMnw=
X-Received: by 2002:a17:903:8c8:b0:2bf:2256:7334 with SMTP id d9443c01a7336-2bf36828b0amr76246415ad.24.1780241273958;
        Sun, 31 May 2026 08:27:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1fc8:a0da:7205:7281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00c13sm83921845ad.28.2026.05.31.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:27:53 -0700 (PDT)
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
Subject: [PATCH v6 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Sun, 31 May 2026 23:25:25 +0800
Message-ID: <20260531152646.1206799-1-yphbchou0911@gmail.com>
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

Based on sched_ext/for-next (b565a73baec2).

Changes in v6:
- Drop stalled_mask parameter from synchronize_rcu_expedited_stall()
  (Paul McKenney).
- Link to v5:
  https://lore.kernel.org/r/20260521161636.1893894-1-yphbchou0911@gmail.com/

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
 kernel/rcu/tree_exp.h       |  5 ++-
 kernel/rcu/tree_stall.h     | 13 ++++--
 kernel/sched/ext.c          | 85 +++++++++++++++++++++++++++++++------
 kernel/sched/ext_internal.h |  3 +-
 6 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.48.1

