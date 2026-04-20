Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB92BDC2A
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698938; cv=none; b=srrDozcW5FrjwOKQ4tFljtGp3GQ/yGubXmTSBD/3c950Qhj4JRWWuyfJSLAe6Q8s/6JcY9XCnef7151dAAQrGfKSSQQJEEO+LCikBu6XwwZBLqIzbUyL82Ef6DlKYJtCRF9D3jgorjJY7Hf6L25zRnq3lt7Y42C7PgNucVklISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698938; c=relaxed/simple;
	bh=j2lNLX27uSv94INu8iyMX5QdGDl/jTKWzG0XfROtqG4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EOptKww2pyqSo9U7/bxY2C0tpWAPCKo9gCQPuhgPTorkh1QbjZNp/GvDHk6pA8cMINCKbXAwCqjOHwFmr2n9RAw5+PJjkBCWBE9xS26MwL4oPlk6hPjaU8D30cBZiCTqlbhRsiZxrUbcwgr9G63SmEd4czhHCWZ42e6qa4PLyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wi7SkACN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wi7SkACN"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4411a572dc5so819405f8f.1
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776698935; x=1777303735; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDHIhd21CO55vv8wW1IQ7iOUTjYPhqTSEDEgVsLeO7M=;
        b=wi7SkACNNrjN0i3WAJJsIfVKhblx0Cb2CQ6QOGXPn/QpJez0aJjek1maR0Cm9IhgXx
         R3lSPeuIXbKEz3f43Q1GW5uENW/el+vU3MUkzDRhKb4JjnQGhVtuMwKL7mLM9qNTvil8
         sA4G+VKMnYn4tCYlXKhqP/md0qh7o4xAlWWoPIsbQeSr7dEK2db+S/57SDA/1X3HypGf
         VJjB7GapiSiJtI3dMheVKuYppTeM51lVpAq+pyU8mQK7CiFbUp5DFIVgIoMWAevbs8H6
         pE7MltnuDVwnbBrb9rWb56eiPwwwBRrg7MGkABAhVjM+JIIcafa7DVSRqffYI+5gcxh9
         GXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698935; x=1777303735;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDHIhd21CO55vv8wW1IQ7iOUTjYPhqTSEDEgVsLeO7M=;
        b=nwya0m2jpLyqZtTWKXhku7UzIpVrkGAYVZjYkO59FI8XOXeEBArjYEgA2jYJD8eft7
         uPmgz/nzZyLxZHALcZ8FKmhSVlZRxwSuR/U/EcOQNH+q41Bstq1pXFO8TI4Ak2YO0vBa
         tG5aDh6GxdsvRva0aNGrxnNt/vZo74v84bur51BFSnZ5u0KEfvmoMFPsK/uNpYue/YRn
         0Pl0liqaIntAhqrD/u2PPW8JIdAHiAdcKduOjdKmHAbXGF6AwE15JHonhqNWR6Jlk4mh
         T8c8/upBnLEZhOt2FsAC0kjMJqLdiYsNa0plLL9XLjCke3tv/uYT9tj0TVCcT1HMGJ8U
         pluw==
X-Forwarded-Encrypted: i=1; AFNElJ9v5kA3MeAviPApJm9jBHfw8HjDj14WqB5wU0L1DjYSw3LdQ1Ac45AhVIUHgHuc3zoCkr4Ce6DNyFA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHIY4zkjG6Ois3HSep9dPk9g21GGBqmo94KnH+jZXEFJ1nIPq+
	JQEeYLmDnZaWkSKeKu9tDvrABUC90DUdHqSzJUTpb6fjmwk1u41979/StRCGa0s6pLXOBZQVUBw
	2Y4TLyRo2J57m6w==
X-Received: from wrot16.prod.google.com ([2002:adf:f050:0:b0:43d:710b:a5d3])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1acd:b0:43b:4aba:8f38 with SMTP id ffacd0b85a97d-43fe3e14242mr22235488f8f.47.1776698934834;
 Mon, 20 Apr 2026 08:28:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:28:47 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420152847.3690794-1-jpiecuch@google.com>
Subject: [PATCH v2] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Commit 84b1a0ea0b7c
("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
introduced the possibility of ops.enqueue() being called multiple times
in a row for the same task without intervening calls to ops.dequeue().
Document this behavior as it may be surprising to some.

Acked-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
Changes in v2:
 - Removed redundant line from commit description (Cheng-Yang)

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

