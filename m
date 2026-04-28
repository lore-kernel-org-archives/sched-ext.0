Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4544CACB
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397786; cv=none; b=OECphvJabW/msmxgkJPoE6KsPpBQscvXxeCLMQqxHwSK8DL6qiNMk/WtkbTQ5WTxQEaFEZmVVIF37UxzvDDoUh6ShLXvYe1E8adozCT+KLtUFtfOrr38Sky3yUEB1d4YRYmDsaqipUnK4nS2/IzXfTWB7l4TJWaMQGLgdrDhQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397786; c=relaxed/simple;
	bh=hTUk4OLuQYWBkVmnhgaz+izlMgTUYpWRMhfLim5YkQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVKOh7c5DC00NN417mD2rBSYHBWWmGyR7HIa0LVg+n+7yHUStPi+jxRlrSjWbfqNvN9ZTBE3WLt3LzY4YJCWu98gao3pqX0g7Ci/tG+buHyNG7n6L3zH3sTGLMGRWo2nfh9WhSxs/o2f1mvZWU54NC/xDBA05A/Rz+Ub5SdgRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmyW6iC3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmyW6iC3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso8093363a91.0
        for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397784; x=1778002584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvLxfJ6iqRD9D8JArCPJM6ENyJK8Q5vMXFsFMBYFRps=;
        b=NmyW6iC3LG9s4zPUN7CQsoMvoN+NON4XJU4Eudy1vZv0KtAl8XUKhaR3WTkHP+Y6ue
         9Ho6EmmCr3hsSyKBY42V1n0NtCAnBe5hW3MsUz6CnOYp87Mw4G2bQKHRgCvKuH4eYQQy
         8Xbb2QBrk4INqEql5t7O3mHCG4sO4z8LJ8o2RZR2pGpfmYoe6VUFP0Gjapu2gL+2fI+O
         67XCPOOHJEDCN3zISbZUC/QCjvdRsb6sPzh+YvnMGwPW7qcdsoLMCVYVNNywDt1pxZzp
         eS1A7LHhTtge++a1GsgqrMGrNjlyJ2vd4gjYlKFCtkc93AVMLaWhCzStw2psRMSACUTt
         ejYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397784; x=1778002584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvLxfJ6iqRD9D8JArCPJM6ENyJK8Q5vMXFsFMBYFRps=;
        b=AkFv8C0vRTpIjksXdbeSKdnQvzF5mftupNhNz6bmFdBrmegCvv5MI1OsbmkldxVzRG
         jJ4CQ44Us2WbcTavPcjQDU+48vZlB41MhtzwJXypI9DeQwBv9sN0FmZeLhMXXHV4rVed
         KzOCnHBQsF4/yPs3IGRfTw10rgSRL/dvkNXIu6UtO+A3f/9H6oVuvbNvq1andrPCSkeX
         U959VcWjxKJvirf+hmTsFBtxgW3uOlGN44WJ6czsdUr/eGzQH9xeZK+6x7xO8rjtNV3W
         kTP1gpCircfl/eeYwC4cnT7cr7YpZvw0nBwPOIGh1n8ZyhWwLg6dFnDuKM/oh1DBUShj
         BnQQ==
X-Gm-Message-State: AOJu0Yx708NdMBC7Em46ExYsrrVUEQ1PmRBG31YMIxcCSoNJvQaIYyLp
	ZKM4lF93r1mNgFOgmD8FOIqW0J/PTVJqG38pkFojfU310mY+w1q9jEJOV5tJoA==
X-Gm-Gg: AeBDiet5x3vX97kfnRsjei8yXgDJi2tzgNcFRrhugRfK4ftkiGC7R96bOI/FanWa+0y
	MZguKBAyhGL4Yj+pbOke9k6o4C4v8a2Li02SmRZeOe4rGpfdHDy0db1wRjtyWz3ZH48V3iSB5zp
	Zm53iE+mP08sjIgkg0quvMSKkTwplofUgzDs9PqwcxrGnJSVxgDbSuKDuwBDNImDtUVrM3pr0pw
	U0FAlOev5edGMIY+8KAP8/G7kZCiB95wPnHbC7LTOb/W4ib0n9y8Nri6CEzK9mwxcSoPFOZT2C2
	JXsbx62A5HoXo7Dt0qRrcn7WR3B+6xJtoc0K3FiBFlm+YQ0FsxqK1U+B0aWks5L71ODDQm3zLbB
	T2dLuqx9lc8y3oggzBxUrvCi9GgrF+GV2trb23wZqEKM3Ay+OAG6Cd1xrc+PVAILxR3pTFg/jOZ
	iyUX3AzTU3GvlKK+XHzwqpvgXDvmIhLtY4alYmpGWvHIyWxUEx1evy+8W2CGULqw==
X-Received: by 2002:a17:90b:2548:b0:35b:e52a:6fe5 with SMTP id 98e67ed59e1d1-36491f89c0cmr3943173a91.5.1777397783892;
        Tue, 28 Apr 2026 10:36:23 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:43e7:c5b6:1e5a:97f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303f52sm280894a91.16.2026.04.28.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:36:23 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix scx_flush_disable_work() UAF race
Date: Wed, 29 Apr 2026 01:36:12 +0800
Message-ID: <20260428173614.65965-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_flush_disable_work() calls irq_work_sync() followed by
kthread_flush_work() to ensure that the disable kthread work has
fully completed before bpf_scx_unreg() frees the SCX scheduler.

However, a concurrent scx_vexit() (e.g., triggered by a watchdog stall)
creates a race window between scx_claim_exit() and irq_work_queue():

  CPU A (scx_vexit (watchdog))        CPU B (bpf_scx_unreg)
  ----                                ----
  scx_claim_exit()
    atomic_try_cmpxchg(NONE->kind)
  stack_trace_save()
  vscnprintf()
                                      scx_disable()
                                        scx_claim_exit() -> FAIL
                                      scx_flush_disable_work()
                                        irq_work_sync()      // no-op: not queued yet
                                        kthread_flush_work() // no-op: not queued yet
                                      kobject_put(&sch->kobj) -> free %sch
  irq_work_queue() -> UAF on %sch
  scx_disable_irq_workfn()
    kthread_queue_work() -> UAF

The root cause is that CPU B's scx_flush_disable_work() returns after
syncing an irq_work that has not yet been queued, while CPU A is still
executing the code between scx_claim_exit() and irq_work_queue().

Loop until exit_kind reaches SCX_EXIT_DONE or SCX_EXIT_NONE, draining
disable_irq_work and disable_work in each pass. This ensures that any
work queued after the previous check is caught, while also correctly
handling cases where no disable was triggered (e.g., the
scx_sub_enable_workfn() abort path).

Fixes: 510a27055446 ("sched_ext: sync disable_irq_work in bpf_scx_unreg()")
Reported-by: https://sashiko.dev/#/patchset/20260424100221.32407-1-icheng%40nvidia.com
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Fold early-return logic into do-while loop (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260428045529.1670916-1-yphbchou0911@gmail.com/

Thanks for the feedback,
Cheng-Yang

 kernel/sched/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..80d34bafe59c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6086,8 +6086,13 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
  */
 static void scx_flush_disable_work(struct scx_sched *sch)
 {
-	irq_work_sync(&sch->disable_irq_work);
-	kthread_flush_work(&sch->disable_work);
+	int kind;
+
+	do {
+		irq_work_sync(&sch->disable_irq_work);
+		kthread_flush_work(&sch->disable_work);
+		kind = atomic_read(&sch->exit_kind);
+	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 
 static void dump_newline(struct seq_buf *s)
-- 
2.48.1

