Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48116F06B
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543442; cv=none; b=h00QxUO/w0I9Q0bDlefeM2hs2GNI+3oTxI3ssfChA+zC9ncVEOBQDAnQunOSKT0h50MRxPiXqNagJiY/iMJGWm2Od/BdE7iQEphWYIxKobYyy3AK1dAl+Nt/LuRFlMLKXfdrpxCX0+z5v0mNNAEVjz/HptZt1qbQP5ZCmFDpeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543442; c=relaxed/simple;
	bh=3MYPajuQ2QWtBRwvH2nbfeYSKwoEPh79fX4y0wqgQoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIOSxBHnZic+u/ItsvgjLkP3RAn6Sceeq93I5bbYD9G/NjQpIk8Vohz3T96bjzJCTKsqDA5C/GXgvIAkqbkvydD+arOawX8Imif5q+Ej++VuIXXpnrOqLQ6nOaXR3FDo3rKUoc7xGBlJyVaRbziijx1yxxcaqV8ikte0eYA/SzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVFUA038; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVFUA038"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-91122373653so294359939f.1
        for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760543440; x=1761148240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPrAKu/IWOXmM5CfcFxeiP+a3NmUz9xQBz3ZjE+QAfY=;
        b=LVFUA0380XXYuTKG6sqYga6Inc7BucDieWyDP7Bxe2F9q+k1Q5AuwsFSFcCe9/7aaO
         wnoC2agSt0per7EG5z1XFiTeK5GwUeBjDK01alayr2pQuJgY16VlkEZkQ221KzKKuDyS
         hRKC9lUB0Ddu2zi/qoLSKYJWxpRdv/U66Jc2ppJ4axitopLOZMUksSf0v8BegEWl296I
         koS0kqtUPTKBn952YC4tXSqr2vr+dNe63siZ+dmaz1xDCtL4ANhcRYuKbyEnSaNHNTDP
         ZAkkVBq9Y5mM0p6stx1rPo31H+pcznkc7B/DMvIeWUc92h8eJKZel3ZoxMsgevurM5OX
         8UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760543440; x=1761148240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPrAKu/IWOXmM5CfcFxeiP+a3NmUz9xQBz3ZjE+QAfY=;
        b=MUkd7J6ZOc/sDdcL08/qohOtoapfpqglkvoATcfMVeagA3r7Wy9Hyh/JbBQQM4JaL9
         G2b0nCtimg9q9Du3duJvrw/lu286hQ/Fjc8oV5c5IJNHG4yrj0XjBaFdH5kmvNvqLhth
         VqQTe2wD9vJ37PBN8wIBszR5pmd5wAEQfrNtGddJumMe29YBr67baS+5JlKe5NHcgET4
         sHecN/F5K4L6ZFmH/jeJACtCeKF19HwF9I5e4rfCmxz+l9fcD4MWDbf9ON4E9cTryxrD
         hLHuvoSmO2GZNLDOKIkpxtyyyaj12dXrQJMuBeXSnBpyXg0wftPmTeNaM6Hl/U+lxhYW
         SJMg==
X-Gm-Message-State: AOJu0YzxH2JATUVE0h8fHHhDud9MTGLcKDglSCVSEqVDzZaD8JpAfKOn
	u+krqd5GScacOEOXDsKoLIrUFLtQA/MrxZlCSB9PE48QwCLoIkmG8W1F
X-Gm-Gg: ASbGncsf3E6aSu6FFVgL3oH5+KGlfWYe/SE3DpahZK9O3PxWXWRQO5fECG/p7o4OGwe
	ZbORSdIMwqZIvYEuxp130S72Nf/HBCa7tXMls+/AxYOMwdOGLvwyvUipemo6tfSr+6AsD+680nU
	bmlDrVarXU3wvjAfn4Z0y7kpZfcFFKWmjn5Drzeoi3peYmLFiDWYrG9DIR0qtao2tWQDg0BzZKZ
	wIEyERcS1OTS1T4CXWh7ZQVgP/25C+KSKa9TUaM2Q9EvRJ9b18yY/hzswTnGOmGnJp/WeKFFX7e
	a0XUYpJsjX1uI2WxKmyVlOr4dmGU+qIk5avymKygN3D3dq42QgXrXUoPxUcJQRID1hEbaQpUAFK
	cQF/KhVnGe+vQmvm/ofziypQqTNT09ibEIV8VTNf56zris0K5S6OCpMJqEf+SDQGozDoGFk19nG
	EEcAz0iRNM5pea/kk8xOIKze8/HAa6azTaJavqbT7NmFcpurFUX4E=
X-Google-Smtp-Source: AGHT+IF18Fh+dNim3Y+u/hzFLdFyF918bdyCY6/WjkMfV7iZC3Up53vEzOUqWIK53pLRVcDJJ5zPxQ==
X-Received: by 2002:a05:6602:2b82:b0:927:44ad:739b with SMTP id ca18e2360f4ac-93bd1989d4dmr3828327839f.16.1760543439895;
        Wed, 15 Oct 2025 08:50:39 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a67790sm617361639f.21.2025.10.15.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:50:38 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	christian.loehle@arm.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v5 0/2] sched_ext: lockless peek operation for DSQs
Date: Wed, 15 Oct 2025 11:50:34 -0400
Message-ID: <20251015155036.420486-1-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows sched_ext schedulers an inexpensive operation to peek
at the first element in a queue (DSQ), without creating an iterator 
and acquiring the lock on that queue.

Note that manual testing has thus far included a modified version of the
example qmap scheduler that exercises peek, as well as a modified
modified LAVD (from the SCX repo) that exercises peek. The attached test
passes >1000 stress tests when run in concurrent VMs, and when run
sequentially on the host kernel. Presently, tested on the below
workstation and server processors.
- AMD Ryzen Threadripper PRO 7975WX 32-Cores
- AMD EPYC 9D64 88-Core Processor

Initial experiments indicate a substantial speedup (on schbench) when
running an SCX scheduler with per-cpu DSQs and peeking each queue to
retrieve the task with the minimum vruntime across all the CPUs.

---
Changes in v5:
 - minor comment tweak requested in review
 - add Reviewed-bys christian.loehle@arm.com

Changes in v4:
 - review comments (from arighi@nvidia.com) addressed, add Reviewed-by
 - make the test much lighter weight with 4 rather than 100 workers
 - link: https://lore.kernel.org/lkml/20251015015712.3996346-1-rrnewton@gmail.com/

Changes in v3:
 - inline helpers and simplify
 - coding style tweaks
 - link: https://lore.kernel.org/lkml/20251006170403.3584204-1-rrnewton@gmail.com/

Changes in v2:
 - make peek() only work for user DSQs and error otherwise
 - added a stress test component to the selftest that performs many peeks
 - responded to review comments from tj@kernel.org and arighi@nvidia.com 
 - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@gmail.com/
 
v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton@gmail.com/

Ryan Newton (2):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  58 +++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  18 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 251 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 224 ++++++++++++++++
 7 files changed, 552 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0

