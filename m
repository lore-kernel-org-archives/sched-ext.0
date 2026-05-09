Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD733A9D6
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353953; cv=none; b=e6ilHl5ZBMniUqjTM8q8b+Xl303BP/4/TJNdfYYu/VYLJ8Es3WkZmZUSUDC3WW3tlHl6fIyhhlpFccMVY242xYt5b5PFn95g5rnrrJUTG9yPEx3osU3/Xk1RB6Q98Z2bUFs8x1v+WKhVUjTSyvsywEml/I+v6+8a44O/TSX2rBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353953; c=relaxed/simple;
	bh=XAeSVdfuvjERxkZ3ivnHkiKnAK1996w38I4ORrUJbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0yqGemrLLjtmC95RC19zXncJ4ngNQG9fh+aAsNASXgntKWKipd2m24dF0M7bKPwqOcDGx16IOYCP7IMuMS5DRbfNckUtu4/0adeMbQJY8xAQIAelzTxxEqBPWGzsFYZxbJSBXUfyDcfkGKiHABraD5BXsrk3NDSXiIm71dwzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoaKWfTu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoaKWfTu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835b78c3797so1294050b3a.2
        for <sched-ext@lists.linux.dev>; Sat, 09 May 2026 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778353951; x=1778958751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiyCBih9Y3h/IyulpuTJbjYK6Wcs4hbA5aLTRTJlwe4=;
        b=WoaKWfTuxmqRxVp6KrqTck6y3RLoYg/RT9EVMFfclqqiT6PMFdtW/rQuHqtoob8aVd
         3oYSQwMzOyxCd7cj6fR9OUfRPAA79ePWOSm7qamCFoSh6mZzkGRPWNWTxkjMtkFsGh+5
         J1KzgxGpWgLmmjFZEdGWjIe7BAeP5EVxjf4Bs7aC5OaeIMbIcDvPNl7qUDmA6RaXVPqX
         m+ixXrWABjknpyj+M+yATee88ummO+iqEvd2kpiyGgZq24qvteQqfws/TPfKbwZkmm5E
         zJeDxvsghxZHTQGml09h3f7aqMldvuNboNw0ta0qJCZYjVws52vRq9VmnfGrq7Bjf3D7
         KVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778353951; x=1778958751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiyCBih9Y3h/IyulpuTJbjYK6Wcs4hbA5aLTRTJlwe4=;
        b=YkgNbhI6/FMG/CjF/pjnwAszGFQS3AN5ANfpUpJUB+c8Q4XbiR4uIipWheuQ2/B1Gk
         JYaGjgKUu8cg23CoAQF57MlJrohNkKUjukuuvmZSC/NLynINe0mG7L9GRTU4XyqgFGXd
         MqafN3qQpUxnVuVAPESabCSq4VuXQlw7/z66h5XkTZZaBX7bXOfyN48M3n80uZ2rseQp
         YoueDYGh5VfOzjN2YsNL/JH5B343euuwCjNinC0RIrPWAafoAuXKLVV0ApwAHMY+ry4G
         X/oS8AhXwTb5an8teMNenkhg0gN20AAIbKsDMFy9ODQk+M0ZFB6KIVtDqNTVyvxpdzNL
         V08g==
X-Gm-Message-State: AOJu0YxnwJZ7GkN9vx/sOB1qR9kfWOCxu8jzbR6uxHfcXY9DsoSu5G2R
	oHEGSDEf1waKkug0U7GpaLiIPzeK7ov04H6IeFXAdkqr6bnZTppW770ciDVVEg==
X-Gm-Gg: Acq92OFAfNSuppk32sDZcH8emQrq3vSecF5utxUDJGMEgbc+PvXHfZ7fNITmuuo1/35
	SwXq9gTeyMVBn1t2tTdQNZBVcpdbi/T4yE4nwEgTSZT5c5tyZNcuWjMsK0aPWEFlFE5+rLfuQrY
	TOnzzCSxRTfQnEvQMEsbJaNbw/xtCxbTxCss2SAb/liqlPU+NUNVYWQoXkX3hueGfb2A3pIMY56
	+UWHbWioMm3zwhvaNijNCiqiVT1ioXa8blcoTGuanmMqrjm3Joz/mCbnhy2L3Od7F0ScS2ynaI7
	riq9WyuMAs13I3YrAbQVh2M+1lFrcXAjPU7CJW9VAa+9SBnayqS/My5osJnW89+4ldYivv/P5KM
	2oHDPDAMdNPmu2mkWe4kLKNhpXXS2ymrHTZWSlt6p4o36jtfN12LfutE8JMZ9YsKE2j4Psn9cAn
	VBwNoe3E7AiQ64UTPF/vUZ2V9NFYGdICqSm0tQLfQ6UfnO0d0h72jP
X-Received: by 2002:a05:6a00:44c7:b0:836:900e:8743 with SMTP id d2e1a72fcca58-83cf6d744d8mr8022409b3a.36.1778353951122;
        Sat, 09 May 2026 12:12:31 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:7487:6815:7f54:c796])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm14470222b3a.43.2026.05.09.12.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:12:30 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v3 sched_ext/for-7.2 0/2] sched_ext: Add dispatch transaction API
Date: Sun, 10 May 2026 03:11:55 +0800
Message-ID: <20260509191223.168648-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_insert() captures the task's sequence number at insert time,
so any pre-dispatch validity checks a BPF scheduler performs before the
insert fall outside the race detection window.

Patch 1: Introduce a dispatch transaction API with two new kfuncs.
- scx_bpf_dsq_insert_begin() captures the sequence number before any
  pre-dispatch checks, opening the transaction.
- scx_bpf_dsq_insert_commit() inserts the task using the early-captured
  token, extending the race detection window. If the token has gone stale
  (task was dequeued or claimed by another CPU), finish_dispatch()
  silently discards the entry. This is intended for schedulers that do
  not implement properly synchronized dequeue.

Patch 2: Add a selftest exercising the dispatch transaction API. The BPF
scheduler captures the token in ops.dispatch() and flips CPU affinity on
child tasks to trigger dequeue and re-enqueue, verifying that both
successful and stale-token dispatch paths are exercised.

Test plan:
- Applied this series and ran selftests with vng, all tests pass.
- Confirmed selftest skips on older kernel.

This series is discussed in [1].
[1]: https://lore.kernel.org/r/20260319083518.94673-1-arighi@nvidia.com/

Changes in v3:
- Rename cookie API to dispatch transaction API: rename kfuncs from
  scx_bpf_task_get_cookie/scx_bpf_dsq_insert_with_cookie to
  scx_bpf_dsq_insert_begin/scx_bpf_dsq_insert_commit (Tejun Heo)
- Rename internal scx_dsq_insert_commit() to scx_dsq_insert_buf() to
  avoid collision with the new public kfunc (Tejun Heo)
- Move __ksym __weak declarations in common.bpf.h into the API commit
- Redesign selftest to call insert from ops.dispatch() with CPU affinity
  flips to actually exercise the race detection window. v2 called from
  ops.enqueue() where the cookie was silently ignored (Tejun Heo)
- Skip selftest on older kernels lacking the dispatch transaction API
- Apply the same fix logic as commit e18002d2c791 to the selftest
- Link to v2:
  https://lore.kernel.org/r/20260506160412.522199-1-yphbchou0911@gmail.com/

Changes in v2:
- Reword kdoc for both kfuncs to avoid exposing qseq and ops_state as
  implementation details (Kuba Piecuch)
- Add __ksym __weak declarations for new kfuncs in common.bpf.h
- Add dispatch_cookie selftest (Kuba Piecuch)
- Link to v1:
  https://lore.kernel.org/r/20260506075925.371138-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Add dispatch transaction API
  selftests/sched_ext: Add dispatch_cookie test

 kernel/sched/ext.c                            |  72 ++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h      |   2 +
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 102 ++++++++++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 100 +++++++++++++++++
 5 files changed, 272 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c

-- 
2.48.1

