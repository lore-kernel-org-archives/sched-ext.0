Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FF1DDC3F
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563118; cv=none; b=WAD+Gjf45OMske7N+bgK3qTe0OBqEUHw2fnQ2eUkK+J8lCAyZQjGFCUUNsl8/bpLrxRzyXt0uy73Fds1CuK2dYk8SwsG5OeBz2uGFSk8gtWDJDIIVJV5JsS8UjhZHce7YVqC2UdN+4P6wRz5OdKbYZwCmicD0hbgr9e1amBxOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563118; c=relaxed/simple;
	bh=elKL0+lU9Ul+QBbnzDpg4X9WuonkGlSfn3LxW9WvkLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdgctMmgnYwK20r+e8Ebp+C+7N4tyBONAUdrmrgfUz6BBwkG1RwremoT2ykT8YMgcSINd1vSBnw0YizmUgwpiUvMGQ4VwSsSabaN+MPdbV58EvaS6nNA+VO7MCCrdwfwVE8JuJwVj7nyZ1R3yY2eESqiXQw5Jn3iaBTQ66VkPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTQcKmll; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTQcKmll"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1749728dso1246549a91.2
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563116; x=1774167916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRq0fWhQuURYFsasMWMR0xZg8JatfazDNaNyyosxrXM=;
        b=BTQcKmllJPhNl9GsSas8vtKW7GL7Gnbt2bO8vyA9/sk4z08zkx+PnHG2p9JMpRzlkT
         7nRpqJeTtngZBHD0/T1ABJ6NunbVSdD3KjzZbyS2meZyzd2Xqep0cO7Ml12XTae6FUeZ
         8RZvvNoAxtCDP1mRbGMZf4lawvxxmW5SETOegVXt7ho7PryNrXbGkWLO+0TfTizCCEcB
         9hnG0V1600bGUhnxUkpOfzAXUNuC01zxM6eZt2dV3DEhU6t6w8W1mJoP4eSRAFuOGb2o
         i9ob1yr8x5JDADo6LYK28cvlUMx+rxrz27qr6jvAQUYBgUYwqFUnMU3Ec7MBJYuHhROO
         abtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563116; x=1774167916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRq0fWhQuURYFsasMWMR0xZg8JatfazDNaNyyosxrXM=;
        b=Uz7YY6tRJ4nXMUcTVWV2wQE49WcBxxpAp+fjDYU+QJLqbTUEHuuOPT+Akgv8N9RBDN
         mvLp/SJejJTW1xyyCxNtgb8BUYOUakl0cVTCmFajg3g/iQmBGYim+J+YaD70zaSiiCRs
         0NpPk6wnmitQKyGaafm4Iw97nCC9Yf0ZM1gMQvZ/AncLZ0Z8W038RVecoKQZvVI7kK7D
         2yoOQyLnP8r8yzBMg6kfDo+rZ50tAHHICc2nVOV4lTXHiRBjdmDozU6smOKQy5bAu9Ii
         4nwiw8IP/j5tHzJSyCM5076z2QZ7BgWzYr0zukJs2IwWHcwLu5E6z+GQs1kJmh1FfRog
         qFvw==
X-Gm-Message-State: AOJu0YxqZhF/AUeUSckqwSSeEDYe7UjCtrt/4+HfzpdWC66aeZLQlgtK
	dQhkDDY6IGqF+A/gje8kXL/1jbXV0O/+9BvUa83O8CE+EfxXXVPBhNIlfnQEvAO0
X-Gm-Gg: ATEYQzzhFxbiTBvrjpJObx0YS1XuOE8O2H+92keOLDFB2llYoP1i3/FfSzmgX2bgsyN
	2rPwVWXRZkA36Ufx1hMcwFGd1DyqFtJIZGbd7YVTTVqYlWwVfdwm8U412JuJAb817jEDdtTzG5V
	q5+Um7POI5hX4r22pS76daCDtbB8croe5s39ajC11JEKWkF+fTcfmASWTxEYj3Pr85uW9GvfxKz
	aojnMlEwRsWQPsMR2VzihcNY/U8ifm9CB2WeGQTiaAwFTYTvXUCsgKBUKaAAryju8ukGmej97Ug
	ADoVK2tHgq4vBqUrsN1MlXs1FwGa3f6ZRN0Zpxc0pbkCveQa+SOuXYbgrIzy64lSsII05p13OFK
	UaCPlcSaFdHX6n+CtqgKIvG5pxnsnt+ley5SPUzZMD7qBVxQScvNDWlT5bpmdmtzWNTblApoCJc
	xV4cOs+1Fs3XL6bNHZ0/68YTQndnXqOU51rU233PwtBuYZUyKiwkvP
X-Received: by 2002:a17:90a:d88b:b0:359:fd50:e733 with SMTP id 98e67ed59e1d1-35a220a4a06mr8222933a91.31.1773563116092;
        Sun, 15 Mar 2026 01:25:16 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:53cd:7adc:9650:ee87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm9316523a91.4.2026.03.15.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:25:15 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v4 0/2] sched_ext: Update demo schedulers and selftests for deprecated APIs
Date: Sun, 15 Mar 2026 16:24:42 +0800
Message-ID: <20260315082500.597204-4-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260315082500.597204-1-yphbchou0911@gmail.com>
References: <20260315082500.597204-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two sets of sched_ext APIs have been deprecated:

- Direct writes to p->scx.dsq_vtime in favor of 
  scx_bpf_task_set_dsq_vtime()
- ops.cpu_acquire/release() in favor of handling CPU preemption via the
  sched_switch tracepoint, as introduced by commit a3f5d4822253 
  ("sched_ext: Allow scx_bpf_reenqueue_local() to be called from 
  anywhere")

This series updates the demo schedulers (scx_simple, scx_flatcg) and
selftests (select_cpu_vtime, maximal) to use the new APIs, keeping them
in sync with current best practices.

Patch 1 updates scx_simple, scx_flatcg, and select_cpu_vtime to use
scx_bpf_task_set_dsq_vtime() with scale_by_task_weight_inverse(), with
the delta computation moved inside the if block.

Patch 2 replaces the cpu_acquire/release stubs in the maximal selftest
with a minimal sched_switch TP program, and fixes the maximal and
reload_loop tests to properly attach the sched_switch tracepoint via
bpf_map__set_autoattach() and maximal__attach(), as both tests use the
maximal skeleton.

Changes in v4:
- Drop scx_qmap changes from patch 2, already applied in commit 
  3229ac4a5ef5 ("sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag")
- Move delta computation inside the if block (Tejun Heo)
- Link to v3:
  https://lore.kernel.org/all/20260313014944.1234667-1-yphbchou0911@gmail.com/

Changes in v3:
- Use scale_by_task_weight_inverse() instead of scale_by_task_weight()
  (Andrea Righi)
- Link to v2:
  https://lore.kernel.org/all/20260312175527.1220540-1-yphbchou0911@gmail.com/

Changes in v2:
- Use scx_bpf_task_set_dsq_vtime() with scale_by_task_weight instead
  of direct assignment and remove redundant bpf_ksym_exists() logic
  (Andrea Righi)
- Mention commit a3f5d4822253 ("sched_ext: Allow
  scx_bpf_reenqueue_local() to be called from anywhere") in the commit
  message to clarify why ops.cpu_acquire/release() are being deprecated
  (Andrea Righi)
- Fix maximal.c and reload_loop.c to actually attach the sched_switch
  tracepoint by calling bpf_map__set_autoattach() and maximal__attach()
  (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/all/20260312042001.955675-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Update demo schedulers and selftests to use
    scx_bpf_task_set_dsq_vtime()
  sched_ext: Update selftests to drop ops.cpu_acquire/release()

 tools/sched_ext/scx_flatcg.bpf.c                  | 12 +++++++-----
 tools/sched_ext/scx_simple.bpf.c                  |  6 ++++--
 tools/testing/selftests/sched_ext/maximal.bpf.c   | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c       |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c   |  3 +++
 .../selftests/sched_ext/select_cpu_vtime.bpf.c    |  7 +++++--
 6 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.48.1

