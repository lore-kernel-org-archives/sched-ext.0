Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC1232395
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911360; cv=none; b=k6lwTPIIIene8geRve9l54coUtdtzARxwgAQD8bzCUQ4ba6YTsAPO84lINrL8at/EFiKjthWL/bv4KcBJmhBIyb62fRkwMGeodKumysAz4sEauLWyUMi8juowRsfFdXpYq0+5zXpbjNyB7da1BFK8+46rI7IArPPR9+C0mjvVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911360; c=relaxed/simple;
	bh=i2uTmw86oe4Zld1zoLl+oRVsiZdNKvagpwGiZa9Pcz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIO8b/i3j7bPScTAxi9gutxP4WtVBB0ZCTWtFsz2AqaxDUqDRjD4Z12Y6bVzoMbYoasVSYL81/+aReUsgh5ih4JfGL3IkiFKp43ysUIUK6V3aQskaT0y5R9qYIqsGpPheERuCWAkokJde7m97kg7njh51BI61ux7yeSFBlU8Ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQka8zpS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQka8zpS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso522341a12.0
        for <sched-ext@lists.linux.dev>; Mon, 04 May 2026 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911359; x=1778516159; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQLIOStAwhgu/CxvIZZEBshgUUBWgh6WL45RaSlH8Fs=;
        b=UQka8zpSbDFOKJo7qWyFPisOjq4J9ZUmCmTqrB4Syzy6jaJF28K2MBKZkkAZkQWbNB
         BL2t5p4v9S6SmhGlnL6YVQKwpYDIirwRLHLeXCD4Set6YjAjvTnfL8//dvbRC2mhScyG
         nONuQkaahCGt5jA876+3vpIcBbAZgT2bOLGyVEtvlaTl8Qq3i4UCeVhEHvQ6GdYROsSR
         5NNOEiApYllUmq2u4GtGTTFcrG1PjrSl5t7Sp1wvYzWEWGKDvaeec6slrCGK3is2NM/8
         q6x2RWaOlmR6bVBJf+lJ3FMGNzo47Wy6Ohlpj1Mw4HdD9NxrdecfkHM2osbn1KTHr3Uu
         CHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911359; x=1778516159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQLIOStAwhgu/CxvIZZEBshgUUBWgh6WL45RaSlH8Fs=;
        b=ay9Sp9AfvRkGfX7DrSnghQc+nH4IbK3ajorDP1m6tK2DVHQ/jpYuT8u6YcO8Te04ni
         pfhDNzC+YqVvYwvwBLZ9th11LXACDw7fU0uFcfV101ATQ1Gykih0qCdNB/l5BdCP2vcl
         x66OwzLjDnepFXyEOV6JU/Lih1k0itKL1Db/yrjdA1S3w7SGVjranvRyfTVB6jh6pjAb
         qzfbz3VLy9OMGZeFbld824dXHxpvV1DP+U8YV2YFlE4BfrPtbjvQxb1Wiv44AP1h/MqB
         +lNky5Uh1yi4Q+c3rNfMEAluiNIEVgYsKSCzLwvwkNSt+BKk7XRT9plQmWbIhBUF3TED
         MNCQ==
X-Gm-Message-State: AOJu0YwOa/kCj+F4H2Y1gY+QOOcQp9QCoXNY3vrLY0javNRxTFBXRddY
	VSpklT0OQvoU8ts/0wghJ+ReWACD52L0iEg9pqPxtD3gowkJsSNa0JTJyU53tA==
X-Gm-Gg: AeBDiesnbS925RMMlPWyTviuRCtwNK+5G/6e/uOeIqtls7RYV0cTAvDrEi9ki9Urf/a
	NB05ELX93sQ+dP0FYB1Z6edmi83T34bOLG6IYjEd40MQZp53Xs846WHh+miLsKpW9dWEDbaPsyI
	5dH6pm8SahPsSR678NZUFx9vRzu9mDf9EE/3ufYEXifL09df5OjEyzxkrU8QQjpORUXFQ2yv9Tz
	4g1dLZWpFTslEa1HSc+UAZo5yHVq9hf8TsqIjRX16ZmVIYZXjCRAq2fzFYhR4VETx9sKe0pe+zR
	3hzBOrcvF+DNK7MD0JB/X0faIhiPeH9Bn2oPeK+RjthuxkdIkEJlFcIreD7SKjUg0FJIGa7fxTK
	3miMOUVf3fcS4r/3kc2cZXRlVh4oOI/33b8I1gYBj9758QonhR959s6q9sfOHIFemtBIBngdXQ9
	LhJeeqregdXXsTWAC+5IZxAPj3G0/4o3Dut2cs9x5dDuZPDJUbXZtxQjicVe7zGQ==
X-Received: by 2002:a05:6a20:7d9b:b0:3a2:c685:f9b5 with SMTP id adf61e73a8af0-3a7f1c9b8d2mr9695990637.54.1777911358648;
        Mon, 04 May 2026 09:15:58 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d123:1fb:b1d3:aa01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba4ccf6a1esm2385745ad.81.2026.05.04.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:15:58 -0700 (PDT)
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
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Tue,  5 May 2026 00:08:18 +0800
Message-ID: <20260504161543.674488-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1]:

Patch 1: Normalize "on cpu N" -> "on CPU N" in the exit dump header to
match UEI output style.

Patch 2: Fix exit_cpu accuracy for the hard lockup and RCU stall paths
which were recording the detector CPU instead of the actual hung/stalled
CPU. Touches kernel/rcu/tree_stall.h and kernel/rcu/tree_exp.h to thread
the stalled CPU through panic_on_rcu_stall().

Based on sched_ext/for-next (88588854c283).

Changes in v2:
- Use raw_smp_processor_id() in synchronize_rcu_expedited_wait() to
  avoid CONFIG_DEBUG_PREEMPT splat (preemption is enabled there after
  nbcon_cpu_emergency_exit()).
- Link to v1: 
  https://lore.kernel.org/r/20260501131521.161852-1-yphbchou0911@gmail.com/

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Normalize exit dump header to "on CPU N"
  sched_ext: Fix exit_cpu accuracy for lockup paths

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 16 +++++++++-------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.48.1

