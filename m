Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78306196C7C
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770253; cv=none; b=sdx22IVVQ5JNZY2eESExdZdVtpbEaCmqpy5IuXZz8rp/lp9jovPtIZvJbcJyG/sscL0U+cr8tV8iH4nrYzoQhrw869kjwyZEz/YAJiFsSWa6YBtwwLhlhaZisT+1Zg/z5w0SsGsVTfTMSXOvxWt7XWAVcKa7920ukuFVORPeuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770253; c=relaxed/simple;
	bh=Tv75a2Sne1jWALQWl4dpTmCSFJsBFUMprPNrzXrKlKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjrZm9rJR427FG+yhY9buur74ZK4BSux+JzIcxwZBJBuNiIjVdi9Dg1hBLa45BBtI2cKwhz/Z4vD+FMjalW+V2rJmBVocrw/voCysmBr1agnzzcFyaKTw2O9K+1282FqET5zZi0nrFywJl9pQb8/XTekAOd7KKxUj+X1/QgDhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCc2iHHi; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCc2iHHi"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92b92e4b078so215495439f.0
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770250; x=1760375050; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7JzPEIVulkIwciGns1doC5yUlbB1c8Y4/uVe7CVnMk=;
        b=HCc2iHHiIdDWtt+Ca7N8fpx7y2sXApfocg9j0wPToaBRHinHLO8Jixdmg6vEI7eUXK
         YnGXV1rgnFtBVlgeiLhnMereZIiFt7GftLXewqx4Xw6+v5HRWybCZWgbITAs5/5vL/7I
         6MiVUsca5s2fSzYkNLzj9ME+lSf6i8W9wIGsPvowTK4qbATItMCgjWne2U0sfEfHiR71
         huWvUpVE2JsvWMyJiRi6RKgnPOH1V9P1aPaEsdJVnA1DdcAYfKKpDTs8Yg/qRh/4P2i8
         JHBrwCNot2U7JWWrVPTkv6+JTt0w/Uu6Di81e2QPo9W5JVJhHssa0ePPBxvZmW7VmOCB
         Llyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770250; x=1760375050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7JzPEIVulkIwciGns1doC5yUlbB1c8Y4/uVe7CVnMk=;
        b=t1hq5pRPDrzKpZniqX5Y/dQtH7IjMx4NfVzJwQ3guJDNvUe+PPPBn7qzpTlFksy6fN
         7KPyhYFoJaI3QI7Bl51p1YNWJWjpFtjh6Po0Q8FTE4GL6dx0LYUs7CUGAQvomLhqGYtC
         DiILijqxcW9Rp/1Kh44dJQK+FbC6AyXYHMweTiYgilZUFzD1AtTxbUCoPBsJcRg9Syia
         S11OZrEZaPaqMhwCJHbFDFaBP6siq8ZS+8Si9xikdMQpbyJM+m01KRnMZ/Gd9YHuCpO1
         9n9zCXuse2FybXyfTbaycqX0CheY1W2JcycxG2aM85U3CHoHB9hSdm5JbWRzFVsm8Wz6
         6CLQ==
X-Gm-Message-State: AOJu0YwtA4mkgYBW1Pv6GmSUIiRsGu40j0yWADZY7qjfbzjzaJpeCs4O
	x/SgWEVl8DWxoYgdo25edT93pNaD65JwGPUnuihBGIGG1j7xm11zy9kZ
X-Gm-Gg: ASbGncui6leXdbzhelmobjFgTrCDUGSzQQaRTFmff9XXIXrBJ8D+xhwa7ArPEg2RIeO
	uBOrt1/iNRROY+IU2/IjKdwQz3C9k+eYT4zH5GXTybi6HX2LVaDLC1l0/q4Su5NsCgyzsWNopRY
	Oporuo8tMA296Tw8Z2CX9Wyq1glvTcsvYKb1w26kqqdgLS2pc39WI0VucqGcJnPxPFpvqZSzqPq
	Q1tOEv3FQgZatFmmUq6uOT+NPl+sKXII0FXyxbGPoQ6lKY0UAB25vj59N9c9tT93ToClGjH5aJN
	yLALWKTyFFfRVUyV7RzmLJjBae44v1NswGmQ/lqWD/y8TfCdZy1BiA5vYODD83TGEILCIJGg2fJ
	1rF8hZqjPNUVMFD/fy3CxwLNCUIm89Acspl/6lGFnZlseQ3yJYmjQDXOCPe6Jr2R8pPjz17h7FW
	bRvseeJFOIRXCe1n/Zzb4PJGvmAPX4ocqUAwXj2ulD6k/l9stOTINRzscG
X-Google-Smtp-Source: AGHT+IGXUEayRywAtX56oYmi4iHaqM0HYrVnCrirNkC9ObeFhcKTuwkabcZToX/MKLlHrqsXsvyWvw==
X-Received: by 2002:a05:6602:3412:b0:918:31ac:52ac with SMTP id ca18e2360f4ac-93b96949592mr1855311039f.1.1759770250110;
        Mon, 06 Oct 2025 10:04:10 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb84b4sm488589539f.18.2025.10.06.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:04:09 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v3 0/2] sched_ext: lockless peek operation for DSQs
Date: Mon,  6 Oct 2025 13:04:01 -0400
Message-ID: <20251006170403.3584204-1-rrnewton@gmail.com>
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
Changes in v3:
 - inline helpers and simplify
 - coding style tweaks

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
 tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
 7 files changed, 571 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0

