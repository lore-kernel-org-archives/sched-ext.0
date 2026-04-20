Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CF38F25F
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677363; cv=none; b=rLhukv/p6BPa0nNlhffqCpcJ7n5pERnVU/BoGJqPgbzoDV6WZBCdqygRPHyryBX+5dRk0ZsKAM6+y1d5ErqRhyAsGa3mG+cddgf4YeE+BZOat7cYGxNSU/XrWfP8QftkxfYEhb7GgU2QxwKQWvsYE56wwg+uV4VelqpwmYTTEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677363; c=relaxed/simple;
	bh=6f+3HveLBRlyrNqDNfWWEFTfBIzS2IVqgogPa+x1nu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGc3iRaMiyPXzYCfzU9cTgYv5BY6z7jyavIAxxKTXTWB6qNbu8bzfZuFJqpWe66zpV9dYNcwYUBFP1JxYNnc8aXUW4igVRwKj9yaW/VPyqqhKLNXG8ZfebgX5GqFb/wdV3EhkR8dzJP2Z3/L5CENjPKCjcYMp1N3UpTGRVB+t7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj3iDyMm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj3iDyMm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a9296b3926so15334535ad.1
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776677361; x=1777282161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3EVFdbeaJOlri8jnz9uqfWqt3RNkM4Q5jy8ObS06jw=;
        b=Rj3iDyMmm+nko2oQ1PLx6m0abNyR3EUqP2uWC84YZ3dAX3f4hFM18ND4M0yvhQuBui
         Tn88TomGpL50XtZ07dEuDqLHs4HrnO/BLl3aa8pBiEburibTbA+/nQABdlifJ+9qoBG0
         rx+QVH4k6+a5uro4sGoiQ7v9HArDXZ7r6teUmh0vGaRVSyIM2ob+v0T664KET0GjIIs/
         YwkhvKGY+iiaiRQ3psm4p4nT4LYNDtRmHlVq8zzAmgvGsGdREvcXF/HsSZlMRqVuT145
         OaqpWrX/E86Csgr3OCQnkUqi/UBIsp0pzR6y5xTW/SFAMfejeINwMUS+H2N4C7L/aHC8
         WAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677361; x=1777282161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3EVFdbeaJOlri8jnz9uqfWqt3RNkM4Q5jy8ObS06jw=;
        b=okDq2M5iDJtg8iKjxXCUt7+744mkdDThy6PBVzsBj/e8VPmhlE7J1zNCPVpZdH5QIg
         CYL749rad6B8UqpweUSgvI38U74ojZoVVCWvMAkxdLbCH1rxZsCWSSL6UtOQT9Avn3rA
         j1OBwrYMG43B5vxhK7hQ+vJETHngVI4xe1hbucIpvdP99moHvfeo84l6m+M2j7pVn2gO
         PoQ4UuStFMEGwQM2xGWLUbwfk+uWAFfWaik1UTmidZ/HV7QjqMeG4tDEyeu12wh+JIhB
         q5PzEZItoly6ZNYCxUicsSgczocI5emNCgrUG37cHd/SZe+VeMVXwCJcjDZ1KxXARhn1
         LTWQ==
X-Gm-Message-State: AOJu0YxQy5Tn89iAq6tWm/nxTf5snQM9AIz9yhBVkIbHapp6RHyrI2P/
	r4+KQb81wQVO9wDd9jJU/qkOEBTm5wUAdmUyBgLtWm6hP+1hKhLWpE0cOkGyCA==
X-Gm-Gg: AeBDieuZeggAW8U/lM0PB1kA7Qbb3G3VjsoZigXHVKvVArm5EIvfyRuz4Er1kMgjv0O
	gRibBudueBKuiyysMkarrAb2Bt6vioO3ilwlSs3zV3h8Wzu7OGIcoVLk+KJNYkDJIG9HEyIXOZa
	Dk2I44Pfc779VD0cPrXkO5EKrLcr3iiTzc3ClCAN+c32HlLlSOnZb2OpS10xZLbr3sIWDH64OK+
	2DWWugMpozILljOKkjwphbb04jGMBynOCdTQHLO5RGZBvhDps4iQHbwPwl+Ri4hI3xKtrBlNZnI
	U9pDjSy4s/MtMie3/mGx2ONwPQKBJrutZwcBbnZ/1A8bpXVnHApusjQnIg2HD+IqKm9jsEyL+gJ
	Lmx6YJ1H/I8r3h7FZsVBWU6oJSja5REQOTmw5STOX/L/IF7ElO+9CDRX8GNIDPx+OW/oErMJ8kN
	ODCHyl6zYHMz8J3PIB7eE/WaEX+DAx50jQEN956Nn9ab0NNLkTCFDZnntipn06Q188sHPSprwx
X-Received: by 2002:a17:902:c9c4:b0:2b2:eb9d:1648 with SMTP id d9443c01a7336-2b5f9fb33dbmr83192845ad.37.1776677360729;
        Mon, 20 Apr 2026 02:29:20 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:21f5:5215:464d:5ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0dafcsm101273545ad.52.2026.04.20.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:29:20 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1-fixes 0/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
Date: Mon, 20 Apr 2026 17:28:46 +0800
Message-ID: <20260420092913.440989-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], scx_kfunc_context_filter() currently allows non-SCX
struct_ops programs (e.g. tcp_congestion_ops) to call SCX kfuncs that are
only meaningful inside an SCX scheduler. This is wrong for two reasons.

First, it is semantically incorrect: a TCP congestion control program
has no business calling SCX kfuncs such as scx_bpf_kick_cpu().

Second, with CONFIG_EXT_SUB_SCHED=y, kfuncs like scx_bpf_kick_cpu()
call scx_prog_sched(aux), which retrieves the struct_ops kdata via
bpf_prog_get_assoc_struct_ops() and casts it to struct sched_ext_ops *
before reading ops->priv.  For a non-SCX struct_ops program the kdata
is far smaller than sched_ext_ops, turning the read into an
out-of-bounds access (confirmed with KASAN).

Patch 1 extends scx_kfunc_context_filter() to also cover
scx_kfunc_set_any and scx_kfunc_set_idle, and denies all SCX kfuncs to
any struct_ops program that is not the SCX struct_ops.

Patch 2 adds a selftest that loads a TCP congestion control program
calling scx_bpf_kick_cpu() and verifies the BPF verifier rejects it.

Note: the reload_loop bug [2] I posted before isn't related to this
      patchset.

[1]: https://lore.kernel.org/r/f2ab3yg5niso6hxqe7sd4jmv5xzdizk3khcspm5bylfbn3mj44@tpyiezvs4cod/
[2]: https://lore.kernel.org/r/20260419174413.Gf28b@cchengyang.duckdns.org/

Changes in v2:
- Extend filter to also cover scx_kfunc_set_idle: add in_idle check and
  set .filter on scx_kfunc_set_idle itself (Tejun Heo)
- Drop "context-sensitive" terminology; use "SCX kfuncs" throughout 
  (Tejun Heo)
- Break overlong early-exit line in scx_kfunc_context_filter()
  (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260416064715.1008437-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
  selftests/sched_ext: Add non_scx_kfunc_deny test

 kernel/sched/ext.c                            | 32 +++++++------
 kernel/sched/ext_idle.c                       |  1 +
 kernel/sched/ext_idle.h                       |  1 +
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../sched_ext/non_scx_kfunc_deny.bpf.c        | 44 +++++++++++++++++
 .../selftests/sched_ext/non_scx_kfunc_deny.c  | 47 +++++++++++++++++++
 6 files changed, 112 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c

-- 
2.48.1

