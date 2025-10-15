Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47C23D7D3
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493445; cv=none; b=TBOqPaifgHSmnK2vl8OfnqXH6+5MSEitZ15Z1XPPKFFqQ7KNek7ZaZG8+lDCPSkFdVg72mncI2utxfKfi9Q6uCK08FBPRpPwTYS1PlJS3L0K4D5DQsiY+4TQnilAvSPSIlSFdW2BjneNk+EALj4WPzA3jU0yJ7bcFo8jbDCFWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493445; c=relaxed/simple;
	bh=/cVyorIkMsFWVSCnGKCrbbEYTu4fe5GBf2CabcXfTrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0aMo+pyFL3s0EsThXAjkkEPkfC/x5/BzKga2i/RdjEHF6WifrjK+hldVYlAUuaxslEcgJtNJVpC/pgz7gZrD/mC578D5EMM6dzdn5+LiwUfuL+W9eDHOXtlC+qe1a4/lztUCoTkamDOl7DfIBYU9wJaZusHzdqx724i5UYXWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+2yKinZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+2yKinZ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93607aec358so108110439f.0
        for <sched-ext@lists.linux.dev>; Tue, 14 Oct 2025 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493442; x=1761098242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeaP8NLxfmWjn/koiHnTCdCJDPT9I5Q4QaBgGQBf3WQ=;
        b=d+2yKinZeV0FsKNcfZfHPIRc2Br/WBt/8VEcD67zl9iLm7qyvZc+2KXphIvtEGCjpF
         J2X6HsTvPkDf3XFEQC3g41gYM1JleHPbHRaEr3a2YrVQVA5Ah1JxWks3RAnbekg/0jR4
         5QHEnolACi/sblpfXTl14ZG5rt1hWsTE9JTsaKq1iJIxSQhOFg/a87W+WVKiZi89Ul80
         dDjL/ucQNYM705NLm2dZp9lLkTidDBymPbppmW3TWWNJ288KP0kPlVantH9DMteQoLxi
         8NbrqO9W9zvzuZRTnTogcKFAzygvBYBQEdw2Itr462CjFYcG4k2pq90VB9KRLDem1iRi
         g+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493442; x=1761098242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeaP8NLxfmWjn/koiHnTCdCJDPT9I5Q4QaBgGQBf3WQ=;
        b=GduiH6RMkfL0A1ekmYdwyQEcAZWNSw+AHwSJm1ArWvv3G9l54F81UJs9AjrgSJiTNF
         4dvyWimWoFb/NREqdLWStYd5JXRDBCelvfiQ+VVixGAdBpwVRzAxCqYIYiFXTBQ7rq6x
         GuPl477C6pg7In3K4tgPGhek8IU3tkbxtzTVw4M4QCBT/BadWfbzMnNByOuWzCdZy9HX
         Lf2jpo1aX9NG+5WrMMMcNodzBjDfiYek1qn+gAen/gUnv5T8o36uBYjFB0EeRGFw0tei
         v9T3n17psEsWboiRMHZLPfjP0T8o9FDdBfBIc049OBoj2n6TCcXsv0o+DbtQl6JNkwL/
         /1og==
X-Gm-Message-State: AOJu0Yyan8XdF2fdLANUq5oYgH65x4d3ZCIQ3gWOGvDbwyNkHo+iqnG3
	xoIU7wy2F5pDey2ceo+/685TBE+YDNvY2VElJ/NlGnUfnogOkQuo96DM
X-Gm-Gg: ASbGnctP4i1fIPVLucF9KxC7AzAPfdrFXD0F67rJ35+aIvTvHtjKFA+j+q3rIcl/sPv
	706D/QMhmHbo63Pmy7N31CxYxl99mKK4mDNVkoDZuLq0CaWRPVsmJ0ZN0FIcFz0F8OJo/PfCz34
	gWkzexKVD7cfMN1Xnmh2Njitj6Fez6tUn7/TthG7bXJd/JhB8uz+sbU+AOuzfZiLuASPsTAFdyf
	LZhMcnTycKl1DDDCAWmFM6yxzsilTszMqzbnRjAqBtl0LdH0Mlw1dBrsPqjJH2y9A70rhNdLDr/
	Lu3PvjQM4sdLrC96wGpbxPkZIvdT99MGwF/QRha2tAgh4sEczXywa/1QAS8vmADJgLDxJC9rLJ0
	3JicqethW0ocKnU9IuHL+tLOvgwhTEvueVSlVF9A8kCDGT4wxFQcuTJPfLCZPoKpsNxNizd+dG+
	Pr/S/JxVLAahB4NWuoao6L6zmdAXcsyFu7NiN4+TOI
X-Google-Smtp-Source: AGHT+IHONv40Afq4USs4oFY8rp4xprbCzgrbv1IRyEssSifN3C6Iy08xejlgJRMY3XfSG8EFLXW1Rw==
X-Received: by 2002:a05:6e02:184d:b0:430:ae26:7c28 with SMTP id e9e14a558f8ab-430ae2680aemr2267505ab.1.1760493442295;
        Tue, 14 Oct 2025 18:57:22 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c496ed8sm5254772173.13.2025.10.14.18.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:57:20 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v4 0/2] sched_ext: lockless peek operation for DSQs
Date: Tue, 14 Oct 2025 21:57:10 -0400
Message-ID: <20251015015712.3996346-1-rrnewton@gmail.com>
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
Changes in v4:
 - review comments (from arighi@nvidia.com) addressed
 - make the test much lighter weight with 4 rather than 100 workers

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
 kernel/sched/ext.c                            |  56 +++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  18 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 251 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 222 ++++++++++++++++
 7 files changed, 548 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0

