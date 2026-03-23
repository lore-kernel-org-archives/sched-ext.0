Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB53C1409
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286517; cv=none; b=C7ClQTd4HzNh2yIyy+GtE4xZEb1RpOa4/dm+ypx0c9XVrI7AWaBKj6eCbA9hlOUNWy9iHuj3uag/VT1YxCgvLiIvJB8dgLGh9W/8TYS319sHFYOKXRfj3BKfTHONHuU2flEhz9iv1U+1XiiL6EMr5HTudCUdHMP5sLcxmFeXc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286517; c=relaxed/simple;
	bh=NW0BJiJDkc4fUmsfi7l1yoc4CN6o765er8TJ7l0S4cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Awg9WuSRzWzqIkkXnl6SFl/NL+gIbYR+yEalZDME84ASShBRhqHK4vds7mXskZtrbmJH2+UbDGhREvsdDHrRZfsy/eilR80EKfyTEqHn7APnIuC4htTSb6ju58IgmM87j16Lhe7lT5OP5mTEorssnWV+XTyaX3QoxCU1i14nnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5FuUcRt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5FuUcRt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35ba749f441so349063a91.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774286516; x=1774891316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLKxKqwKCuIGZlDCcAvuuHKvbQAVgjj1BKnMORR8klM=;
        b=a5FuUcRtlI920fpr6RIlT38Fvx5dTdMT8BMWazd9Uh8wRMvSEW8YD35LkrGE5HPxat
         qwXuoS3ZKlKdV0gu9iahjeOezwX5hGwFK4DmWFyg7Xz3uI3McF+w9nhLVaQtwNxRUYxf
         JpR0aTayjm7uKhEFRYDLr0MN2KPlb3yR4GQSTNYVVmF7zLIbnGQYHfGhScTTtxarjz2P
         +9yQmGqLvWmz4dIz+bphjc635Doh8mnIhA40GZLm/N9iRUqkv5VQXwtepvKUJCGv1Y90
         fImWr5p7aInT3EZ/0gX912PV3k9RB20KQW/zBX29Tg9/HeEUwyulS3+xzIFtxym5RmfJ
         NSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286516; x=1774891316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLKxKqwKCuIGZlDCcAvuuHKvbQAVgjj1BKnMORR8klM=;
        b=EDeoS9X9dYN75sNzlWQW2puqXVY1SyZzs0eZYJFr8v7A7IOK8OHzaUamz2vLNK32HK
         uHaCXA5m5OfyU/kCgLEJdzWbQIHz+O8WDydjSesS3zbJn0LyuqGTbLLeVktRu/7/MuVI
         ILCbSmBrTVRIKmFzxchs9L4kxqbIwcJg3j8vp12Dlp/4zoOirEwWmPhkzMIx7U8Xxg6x
         +5VmApJy0RyHf4sF4PKwuc2otdmWdrN8oadrlfrZfajHJMNMMMYhDY7vCfu2Y5EecUNk
         tKjxok0okrUjv9NfKDqnVB4XeQCQRV5nk4+tVjspj8yHSsCpDNRqN7mIECXUH/TQTC8K
         n9Cg==
X-Gm-Message-State: AOJu0YxTSWJjON5JtZ10dft4sJVKqfjbyro3nJgEkjPkXTsUWOBtDHxN
	zlVFVH/dGbgCVGP1oFFs1ugY+xKR5U4lI5AIfi1IAFWFm0OjZt8Gof11Ue8rQuuc
X-Gm-Gg: ATEYQzy2pgKDvLHsCzcELlyFkUuvIpZCyzDZQKDam9d036wmEs/TFXoZnG74eX7MR8o
	Hgh7UK9zgaY9DU1U/B11dnSbgu8e3ZwD2aZnrLG9cnuU2vt0zr8VPvkC1RbQC2VEi3mXgwTy+Ly
	QCPvPc+IKmG0eDXOsLPCOxr0P70ieSD4ny+fH4uvSa3AWsw2zJ95QWCmz1an2Shq1fUHzaVP606
	AgFDriAgeRbG8SfKCgeDuCqQrSgUSMCk8+E+UZub4dEb4fdYCtKQ16BUEXikEZWdX7gHFQ52EhE
	UDqEFnGhIYL4hFdy6ODzPjIJ33FgJWeH31UsoI5Q/7QrUQih4CE13jutH/ujtsEur6kgrjKeSgV
	gvPGO7AWS6Hj6kfDJ5Ym7AzTx9kF31D5cEnYIZjWZ29SdLt8OlH7to59fMLuKyjb9LzLDYHsCkA
	+Sv3c3Yk3IBLyqX/10uUPBvUZ9HgEymKXARzgst+d4Ou3k/HyiiABN
X-Received: by 2002:a17:90a:d446:b0:35b:982a:28c4 with SMTP id 98e67ed59e1d1-35bd2bd5848mr9989128a91.3.1774286515602;
        Mon, 23 Mar 2026 10:21:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm13552672a91.14.2026.03.23.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:21:55 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [RFC PATCHSET sched_ext/for-7.1 0/3] Remove __COMPAT prefix from BPF compat wrappers
Date: Tue, 24 Mar 2026 01:21:27 +0800
Message-ID: <20260323172145.25689-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested [1], move away from the __COMPAT prefix and make compat
wrappers transparent so schedulers don't need code changes for
compatibility.

Patch 1:
- converts the __COMPAT prefixed macros and helpers in
  compat.bpf.h to transparent static inline functions using the
  ___compat suffix pattern (so libbpf resolves them to the original
  kernel symbols), and removes the now-redundant __ksym __weak
  declarations from common.bpf.h.

Patch 2:
- updates scx_qmap to call the renamed helpers directly.

Patch 3:
- updates the selftests (dsq_reenq, peek_dsq, numa) likewise.
  One exception: peek_dsq has a debug path that explicitly checks
  bpf_ksym_exists() to record which code path is taken at runtime;
  since scx_bpf_dsq_peek is now a static inline, the check is updated
  to use bpf_ksym_exists(scx_bpf_dsq_peek___compat) directly.

scx_qmap and the selftest changes have been built and tested on both 
v7.0 (via vng) and a v6.14 kernel. On v6.14, dsq_reenq is skipped since
scx_bpf_dsq_reenq() is not available; everything else looks fine.

One thing I'm not sure about: the "Preserve until vX.XX" comments
attached to each compat block. With the old __COMPAT macros, the intent
was clearly to drop the macro at that version. Now that the wrappers are
transparent static inlines, I assume the plan is still to drop the
wrapper and move the plain __ksym declaration back into common.bpf.h at
that point (similar to how scx_bpf_dsq_insert was handled).

Please let me know if I should update them.

[1]: https://lore.kernel.org/r/b75214fecccfd6256768f87daa7edb29@kernel.org/

Thanks,
Cheng-Yang

---
Cheng-Yang Chou (3):
  tools/sched_ext: Remove __COMPAT prefix from compat.bpf.h wrappers
  tools/sched_ext: Update scx_qmap to drop __COMPAT prefix
  selftests/sched_ext: Update selftests to drop __COMPAT prefix

 tools/sched_ext/include/scx/common.bpf.h      |  10 +-
 tools/sched_ext/include/scx/compat.bpf.h      | 140 +++++++++++-------
 tools/sched_ext/scx_qmap.bpf.c                |   8 +-
 .../selftests/sched_ext/dsq_reenq.bpf.c       |   2 +-
 tools/testing/selftests/sched_ext/numa.bpf.c  |  22 ++-
 tools/testing/selftests/sched_ext/numa.c      |   2 +-
 .../selftests/sched_ext/peek_dsq.bpf.c        |   8 +-
 7 files changed, 104 insertions(+), 88 deletions(-)

-- 
2.48.1

