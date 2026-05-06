Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069947D934
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083471; cv=none; b=ULcY8D/O8oBIPR7kG1sLySarnXfDYd8lHC7QtqkQs2qoqbL3yxbk959upjdU80zDO+utyUhXNktjDBEfR5SURTVxhe/8jMJ7WIYyWJlzo3db9X3l60KXBJJDh5MkWLGAtyUDBz8EeupU3KGLq+J8zmMEjaxWvjtOBvpX6KY99K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083471; c=relaxed/simple;
	bh=vCta72I1y1lAsIVv3OuMfmN+FyaDE6dPYoJkMNoGpGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bezdo6pMbyLMuBcIL5lQ/uqnDg/Eahu1YWbUvb+e1IoEcWAXNxQLEG5mBTfbGYLR017oUJ9QHuWtLz6w3yJ+bWkcvMeSU46DuW/oiugRnyDa7AjykVgkBXQtPI4+nZNsiq5beULQy8UYkhAwLtjiwoc4dPl/3X3+gQwTIyPfXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKuH1+xM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKuH1+xM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso2437640a12.3
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083459; x=1778688259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LxFk8UGP88fYtPMwFeJp743ev28tbX+6MG0pYBjAyo=;
        b=kKuH1+xMIDikZghOeODuHjMevIRr4Xz7X7gX1XGV4pl2aFDPgUp1K4hW3gSOyMYKTc
         JipameviF55ujV9qSFmdf2GZZHUkFnhw8qcT68IaVYhZ6BEHc3hNi0wy2ciR3nmBnufx
         53pJpwENvE8mtGGYxcN6GMkNVWWEG3jttcDq/JGAxJ2TIDjsQbdYN8pgLDxGUMawunAP
         JIHxJaFQNc1GAHLqJbF/6TD4g5NMmJjfM2JuZjwzXWEP/hAgO8mY8giaqhpSOjfQa1Jx
         yy1ckKyNdRAs+FvLq+ZuK189gEslh0l1DVl+g9a5aTWTRmrV0TSjx5KS4dvC0Aj3OEKO
         lkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083459; x=1778688259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LxFk8UGP88fYtPMwFeJp743ev28tbX+6MG0pYBjAyo=;
        b=shvgOHiTAIZy7T8kyo8IQhntDFKuz8leu0pZm+WpOs2JlvRqvkLAxPuxMV2KLskihT
         2w6aUMr1l6KLYnhPQ6+i7gAgN/HYdhMri+WwPuFLVt91lL6P/UOx+SV9JmSTex45OJKj
         iQlahNbVGNghKu5lZhsqmzniVltL/RMBCub7kAQFfsTxEQYX6msIybyG3TT3bbpkRqFK
         sovOsu1sgZ7LyLY8/QdS2bN8ZCZbqZaXcNAQEHpJ3dMIz3Os81TEueRBR01Y3u78vAAE
         +ZaTBcRJT1UP+ALLpw3tY7Ic6KA1jfF3KO/2mBGOk0HKeBoAcfl3wjoqJkNoGTbLByC0
         0XTg==
X-Gm-Message-State: AOJu0Yx5p2v41pzwXV19QL/wAJzY+tZPDRLcb86lAJquj2gBh3XN3IJy
	tbiZEnzA2i5m26C6+yrDFgODov7uQnlGmXUr6EN9RGly2krdSQPdwaZb92uhxw==
X-Gm-Gg: AeBDiespUaiZi3zWLqbsKEjY38EDkzNl0I7DHKqebYFbbIkJq6C1B9lpd0K6RIExVJj
	MyLjamgK1RBV0cJ+sVaM2J+c5h/K84B1epKi3AqyJPMrpmGHohjqnUVBMGp1TxMzcm2dTlYi2an
	EvMzifr5LKlILmebUnqfml19qXyL/r7RYsyWs2uSyLQr9vi6M/ZkA5Ng0ZiViND9NZflgMMACKq
	F+DIzzMWeY/LSDXqYG8gfw2qEpGSr3cPkpel7GosTua+Du/SeNDiLX2Xs/zp5L7iDpr/DSfNRcV
	l5dagdWw6WrNRo06pVLbxJI8nDjDwyQJK1rLR7VjpNg6502AMcv82RFj55xTntLm/9SnIuDg5jS
	xeJ2Kbm3o4ukre367glESebEyo5JLH0BJLVrMKTyTdFMX7wRmnjsWGOWmtx4+DyUUoHkNotvMHu
	lTy/xmk72eDKKadxprtDNkHdP83uJzWMcopGGKKPTG14FouRfmyuRg2m0Mve4jxwFkv1paAq8J
X-Received: by 2002:a17:90b:3a4c:b0:35f:ba3f:e04e with SMTP id 98e67ed59e1d1-365abae7786mr3837673a91.11.1778083459007;
        Wed, 06 May 2026 09:04:19 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:5aa6:d56d:38a9:469])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4fb36f4sm2777448a91.13.2026.05.06.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:04:18 -0700 (PDT)
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
Subject: [PATCH v2 sched_ext/for-7.2 0/2] sched_ext: Add cookie API for early qseq capture
Date: Thu,  7 May 2026 00:04:00 +0800
Message-ID: <20260506160412.522199-1-yphbchou0911@gmail.com>
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

Patch 1 introduces two new kfuncs:
- scx_bpf_task_get_cookie() captures the sequence number early, before
  any pre-dispatch checks
- scx_bpf_dsq_insert_with_cookie() inserts using that early-captured
  value, extending the window. A stale cookie causes finish_dispatch()
  to silently discard the dispatch. This is intended for schedulers that
  do not implement properly synchronized dequeue.

Patch 2 adds a selftest exercising the two new kfuncs.

This series is discussed in [1].
[1]: https://lore.kernel.org/r/20260319083518.94673-1-arighi@nvidia.com/

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
  sched_ext: Add cookie API for early qseq capture
  selftests/sched_ext: Add dispatch_cookie test

 kernel/sched/ext.c                            | 69 ++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h      |  2 +
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 38 ++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 74 +++++++++++++++++++
 5 files changed, 180 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c

-- 
2.48.1

