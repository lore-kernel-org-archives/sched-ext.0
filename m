Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AC3A4524
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695996; cv=none; b=Sd40z5M1wAlJMkgCYwM1O++f/1vs/bEqUpWowhm7c2+sZMJFNamkzxAqHbcAclexFCn8Wbh0RK43dID0G63+3tpdPb6731B+us8lYBlOIXBQHIkWe8yfnpD27+KbqrbuGSuRy5Ceyx7jUVvqkc7vxZwJfiLoFzXN51VnerIKZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695996; c=relaxed/simple;
	bh=1bQYWQQPZTm0fo/5dwbu+faYIgDvfi4Vp/l1hT2D92g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UwTbhhHmbuuTSe3U0kr4Wd0rVahi+9TQxneyR16qnpa7m5QRycWPkoYgQj1thNtlZuG1JTYq5a7oP84HGq2dhBGRSXVFmEgse0sG+1UZaWOxK4XVgD9joHMQ1AshR70atbAiMQ9DaH7jO8JYto97fz9DpzpRgy64H4VTLhG6bzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqDJ4rvg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqDJ4rvg"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso25240225e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776695993; x=1777300793; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxqxI9AIf4W3z8bVA2zxxlvVzCabYgXNqoP1Bzhfb7U=;
        b=PqDJ4rvgqFgyALGu/WsdgJi2fvf+nbynO1UqRzmF4k/tZ6rc4UzWB+raZMySvQ06uK
         NyBmPbXDSfe3Hui/jCmddm69V+3zbktpV38vwkVAxW5Hn9jIwCeNbD7JJddxW4GBnPoq
         WB6rUqoJJgL6Rv+Bciia1YJJ1RpUjC20t3Is9hS0gN1eCp2l9hSb/+9Um+KZuJ+ZJk7u
         kzto0HCM/9Ch2AycwVNEqjz7hNITmhe87+srsKrgoX4eY49+ZI85UFB2Trr8GXwT0P29
         mI2iSRQylL5YbE/NV99AIwGVE16HMcGjGUDnBS3J6T3SHOof5KR7m26ZP/hjxrsbhTOc
         bYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695993; x=1777300793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxqxI9AIf4W3z8bVA2zxxlvVzCabYgXNqoP1Bzhfb7U=;
        b=swdHnF38Oly5YpMp/X7BraIG11alYR0Sm1vCLmwYq2mpeYso4i+ggQECobsc0c2FBo
         6u1IHk2RGlC3SkpEVAfCUR4Vvm13Tv3lxm+JDWrn+6NSF8HGqjKznK6L4KgElfxj+Rdc
         tcfOuJSRJ2RQ++IjgEdbpzsxIlzndmeaX5XQyEYuU3U8C9LU46TXJeSAHVfiR0CbzkJc
         c2RhljqjG6PdlicUAKTqyZG6dB45PbU9Rbu71OCCsGymxs7BelAhhdki8zUJdgJ4PKF+
         NSycL12cMId80kjS1tXEAp0LcbW6Oi7qC0FLcIkbjvE7zVN5owYdliSrj8pMOrs8NwuE
         7sMg==
X-Forwarded-Encrypted: i=1; AFNElJ8oZDLTi0klWvO145rLxr4E+8vrgb1vM4JE6qF/84be+G7SBhNOz50yTE9VDKyvaboymx/XyalJi6w=@lists.linux.dev
X-Gm-Message-State: AOJu0YxZBdWESge86PLIjGXdoV5lwBi+/pmB9UqDCU6A5yZxr8X3JZJb
	prxgSDJNtQY6DMka/Ot94oid0QjvgQ1E9uTK8Ps3Bx/ZmtSQHOAwmYzwv1uEBj8xh+zvbQnuqtF
	K6HM3jpYOGHFJVA==
X-Received: from wmlf19.prod.google.com ([2002:a7b:c8d3:0:b0:488:9d54:fad])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1614:b0:489:1e8a:90b4 with SMTP id 5b1f17b1804b1-4891e8a91e8mr25850625e9.21.1776695992838;
 Mon, 20 Apr 2026 07:39:52 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:39:39 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420143939.3636883-1-jpiecuch@google.com>
Subject: [PATCH] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 84b1a0ea0b7c
("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
introduced the possibility of ops.enqueue() being called multiple times
in a row for the same task without intervening calls to ops.dequeue().
AFAIK this was not possible before that commit.
Document this behavior as it may be surprising to some.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 Documentation/scheduler/sched-ext.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 03d595d178ea..fba09aa1cd4e 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -339,6 +339,11 @@ The following briefly shows how a waking task is scheduled and executed.
      leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
      on property change / sleep).
 
+   Note that ``ops.enqueue()`` can be called multiple times in a row without
+   an intervening call to ``ops.dequeue()``. This can happen, for example,
+   when a task on a user-created DSQ is re-enqueued using
+   ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
+
    When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
    The dequeue can happen for different reasons, distinguished by flags:
 
-- 
2.54.0.rc1.555.g9c883467ad-goog

