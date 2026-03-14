Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB12580D7
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773459444; cv=none; b=V7u5UIyWnI6bPNf3SHzXcR95fp6KsWayT4QSeNmwdW5HtBMzLAHQNOl2tYwdft8rw62WxAzuah/G0apaoCYVdDhKAfkcftaB/REBlrfcE4tdXVC052dEOt00CNzuzD1KcW73SkhLKQ8m9e5tdJuieHxn9438Be5xTjSFdpYO9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773459444; c=relaxed/simple;
	bh=elKL0+lU9Ul+QBbnzDpg4X9WuonkGlSfn3LxW9WvkLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyDk/xIBnyRL/zYU2lAAzHWSdXGQ7xZF128oZg/52ujbfZNdp3VIJXk42aj4aV5uTofVkBKpyEE7z8rKKJSxcLdYDRAd2buud43RR5Hky5OqnswsqeGjU64miJhqBdh+Gr63P2SX9IYSeNEjMB7g1W/RyPWewRf0xbuix9rqGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccv3vNN6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccv3vNN6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8299c75f730so1624523b3a.0
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 20:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773459442; x=1774064242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRq0fWhQuURYFsasMWMR0xZg8JatfazDNaNyyosxrXM=;
        b=ccv3vNN6xDt+j2enqvMuhPYA3N/ynpcl692iR7foCtWQiCuyd6BUTLjThC23OEgVgV
         KEpt2UzatEor33uXWY3rga9AQxOo2wW3pbYjTTngHHIH/S+Af/FzB3q6WRJ8vVjZU3N+
         pu8aFba+i/C3N3/pl8HkY7mCCMRgt/dh7MOHXuxX4ukWcLJ6Mw/WPY+xYscIRSv2rN+l
         jojN75SF6FP414Af62iqbbfNYm5pH+LtzemV26RhMBsSr7HskeDJJ9qvWPo/uJDssNRI
         A5teXyJ8/LDO3GkGxeqpyWovz4wyDME8XUlYJIeCvgLa+gvKqUC5nrZXjRSfFoBbox/j
         5B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773459442; x=1774064242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRq0fWhQuURYFsasMWMR0xZg8JatfazDNaNyyosxrXM=;
        b=kdT9WLkHNjevWzrbymZqoMJZYvUAQXSsjuwGD2Lr78aA60k77SkcUncQDFUsUviGm6
         f9m0FWA7jSw+LCQA7vETAlkdFF1ahut/welfT0K/xkyowHq/D5XYyQw/GQm2sG19KUES
         Y7AcBmx4iISrBbC7CQEKL7olAeoX/1EABiPnVser47jZgrjvBLFpJfoTNlLyqEyMNoTd
         4j+SpbP7k2HBROF0ip9dG+BaTzBTCa6xYNHvhMTgI+11bsJZYT0JsBLPrL6O64g85jci
         X3AvA8vj6UhVnlk+3TpeoryHKJCJvXib181ZtLDej2c3bJIkfQjG5chWNeqjcffZdtv9
         WfCA==
X-Gm-Message-State: AOJu0Yx1DE8zLTxl4dP979I+e0Kxo7YhwRbJHT18TcZOpbANV+ptqDcc
	6e9F3U4SbiRJl2xM9wHEV3evGti2az7+2IcEiZ33uIH1Rfg/ONnUzmdkjZXJbxlj
X-Gm-Gg: ATEYQzyte6kE5tOvr2De+ffHoxUx69AbekE96r7Wufkqvtmnj+lcuB8/JthH8u82DiU
	FgqzrorcvO82Uytf/VDf2exS8fT4b2cyIf0rqYL9fjIphA6M1/7tjAt0RfuwLHh5ofNPLPlw/AF
	6WBMZKZ3tdyMfX+JFEKY7WVvforC5ohqWG3Gonm2+5G4xdZ8t4zwBDTi92et0S0VBfNizh/lZeW
	toB2kN2E+C5ZsYwZLzGtmEzdHdZUtRiZa8KdPgPXOtDX3tWkjp7qQrDhCDnP1qS56RSugvmlBpM
	zi40BxZMG3gJNzplYzgFs0NsXh8DJFJPsFI11KtmeKN+PTTUa2VaVs4oV59T67mOlwNlb60FOj2
	yiGYvLgiP2gIbWMsV2yl5pXS5xD8RSiecsNn/zV8T0UUHvN81BHFWJOkj0FFUAJROEcNkH6eIdl
	t9jYKFuQk+zrBWsTLqLDYIwjfkRM9LBXaUmCFzn0DsbM2b/tY2zug=
X-Received: by 2002:a05:6a00:92a3:b0:829:7a0d:68cf with SMTP id d2e1a72fcca58-82a072b9065mr7749353b3a.23.1773459442136;
        Fri, 13 Mar 2026 20:37:22 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:812:f4b6:2aba:4bed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073ad15asm7045304b3a.64.2026.03.13.20.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:37:21 -0700 (PDT)
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
Date: Sat, 14 Mar 2026 11:36:43 +0800
Message-ID: <20260314033708.26483-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
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

