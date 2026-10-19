Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2224D956F
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413721; cv=none; b=nS7acTdVYW5kRYRC2CKPw8i1HWkFxMRddKXxdV3qoRoAX3JuxIOO7YQlyPoad7OzTGBzCthIeNyi9RsudQLjJdHuIze789yeOc5E5QCWV/Z+WzHJluhk3zvI0Bh59I95+e9SOiLpdfzmPTGKakELg40l23k68f3HnZDSa9L6soA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413721; c=relaxed/simple;
	bh=gHiozBA4b+Mydjj0WDx+4yc4fZiEG1xZdsLUi/YhAe4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=vDhpg0lPOIBy0DV+cOZCGjXWhilcCsT5IhmKkZCQuZqoi4nh4YANLGvMrZheOsIBGfPt+ibOqytNqQtyxAjmhVk78OUriB5lZqwzljLDaDmdmkLRU6TZQBI4SSNbqNstaW3OG4fULt41uODu+FytsjLvdv1AQjfT2gvPlJcs45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJnqTw7C; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJnqTw7C"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3f04e0e481so141924566b.1
        for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792413709; x=1793018509; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xG7Y20y+nUaq6lJVPnnQYX7VFSFS/lNQS0CTHINS8qU=;
        b=AJnqTw7ChsN2SK8rBB/Ov4TmXsmg9gsVq2ZsTdUZbXW8u5ld+NSpRBEND+YZlOt0A7
         6X1Sng71Kek6cIv1OjVUy/UIJ+Qro4F+yJ0YH1yVEKCWbgYyLwy9RBMcq02hmTxzJihh
         k5Cj39gfn4TYx1VJWE1ajZoT1EH93XcNgen9GFCJ6e6oOuXSzTXYBHmBCCLk9nvOOdgB
         JB8N/eaRHGUW2Mmf1KORYTiPmqvHsOYMrWGkmDlF2xKveTkbceCcC1CPQUm5JnLMC1Sc
         yDt/LtnMgPOtDx2OTgG+RnUpQV1tUT2yG9tKKfZPTyx+cpEfCzaYVPoT7WtAtsa/IRKB
         0VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413709; x=1793018509;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG7Y20y+nUaq6lJVPnnQYX7VFSFS/lNQS0CTHINS8qU=;
        b=xaGSAJVd2UpRLRgnnmdYITO59+Dh9hs2O4Lcb5fzs3ArdyhjrcGB4a1+FTV1hNcwQ+
         EpizDWoLtfD7qnw6KVKsiGkJxHh9ZMpuFU8yWYO3a/g6xc84bMVwYeTIVHbAb588TnbJ
         SWqG+3o3svR9PsJ74nedWjtqn0vDNoE3nB7KsnjPG/HuDUepUsQ4AdkKLGjVTMnB4HTr
         kUaIvQhhxFeFWYgatpZyhoOfRVH/I8rqDXZTqKlvWmB85tgb9gTh9xTNU7xLAFwjjUxf
         gqYVqdSVZMembIyfsN3anAdKqOXrkBMk+CtMRYceuwvOvwrzXlvooNHOXrzy3Zcb9HiE
         8VaQ==
X-Gm-Message-State: AFq9FYIelwGQgDUrSeKoCMOytO8fgxpqc8i2l+nkRW/FRpebWB0qTqOa
	aFM7rYuht4Y4SJncd2mY4LdjEDZL/+ORaneXqFQ45Bf1eZ0OIgq5mSLF46vaQHUYZsipD0iYdhU
	UCjFIiduf0dbYVqpe8g==
X-Received: from ejcaf4.prod.google.com ([2002:a17:906:9984:b0:c3f:a907:231e])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c310:b0:c2e:640f:f9f0 with SMTP id a640c23a62f3a-c419a844d6cmr533170366b.5.1792413709199;
 Mon, 19 Oct 2026 05:41:49 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:41:44 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019124146.3582127-1-michalblk@google.com>
Subject: [PATCH 0/2] sched_ext: Reset runnable_at when a task leaves its scheduler
From: Michal Blaszczyk <michalblk@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>, 
	Michal Blaszczyk <michalblk@google.com>
Content-Type: text/plain; charset="UTF-8"

A task that is switched out of SCHED_EXT while it's waiting keeps its
p->scx.runnable_at. When it comes back, the watchdog counts the time it
spent in another class as waiting, and can abort the scheduler for a stall
that didn't happen. Patch 1 restarts the wait when a task leaves its
scheduler. Patch 2 adds a selftest that reproduces the spurious stall.

The bug goes back to the watchdog's introduction in v6.12. The series is
based on sched_ext/for-7.4, and patch 1 also applies to for-7.3-fixes.

Tested in a virtme-ng VM (16 CPUs, PROVE_LOCKING): class_switch_stall
fails every time without patch 1 and passes with it. The other sched_ext
selftests give the same results with and without the series (enq_blocked
fails in this VM either way).

I used an AI coding assistant to find the bug and to write and test both
patches.

Michal Blaszczyk (2):
  sched_ext: Reset runnable_at when a task leaves its scheduler
  selftests/sched_ext: Add class_switch_stall test

 kernel/sched/ext/ext.c                        |  14 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/class_switch_stall.bpf.c        | 121 +++++++++
 .../selftests/sched_ext/class_switch_stall.c  | 240 ++++++++++++++++++
 4 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sched_ext/class_switch_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/class_switch_stall.c


base-commit: 1f5dde349ac2fca1f119ae8de3f0d2f1c2a8d338
-- 
2.56.0.176.g3575e65682-goog

