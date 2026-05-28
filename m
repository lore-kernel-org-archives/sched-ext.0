Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672183B2FFE
	for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973970; cv=none; b=lyLblN5njkdBytdMugqph8o8nyXAqJ5EuWqnfmj90/iyiniznin09UWvuj1XBTeyNaBh04ZRKyQM4NPgABgbNPX4TixwloqOoROvJiWmY0VvO0+oI4wg5pgusZz7HNW5YEiPWamBWDcO4+eueCYwCCbtcbc5+77IKdWHsoMMjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973970; c=relaxed/simple;
	bh=i66rAQ3zg6Hqrj65fMCkYDh2ZQF0MQhtxxmF9pxUAYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cztlDkJfweAxOFX18+hXmD/JPk3kBvb8B6arveMWatLIcFRTVEwpUWkG3ZFKG+4eYgpHcdrtnhxf1rW1kG13e2D4I2edEitBzdDOGJDmMSaUXbXebBGBOQUHon9OTGQ6U4rzexc3OTtjn6AiGKiHB3iK1yqd25jpmY2IEt9ehYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhJnxx6Z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhJnxx6Z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83d31ac4017so6445319b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973969; x=1780578769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcfHENymJGZHtdeIVFKzzwGhB5oFtix9tlsZ2996z0M=;
        b=HhJnxx6ZcQv0r5Z3Pnx4sf29AKrQSxkB+dyjKFhjl4zbrsFxxoGWSBRqXsQNo0XaLC
         MgzyF3SLxPpfe5p0rxxSfFuE40PWUZos4qJ0hOnZpI0DJp+bUOWXN18T9E9nG6labqgK
         1hnTg8cUE29kl0O5we1CF+ADDUIiT+ZI/wr980QV2hGuibW3xchfrc/CmSuIzAjuY5mR
         xy+zlWH26luMLTffsfLfiOCiLrolPkmwDSChhoeW7d39Edk9b7tCs4n1EURZZHFu5N+I
         1kU+QwD3VmhFOVV7GNc1sR04mtBVce9JAPDI9WfQUwbvk45J1/2uZ4Sjzv2tEmXsiOln
         OtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973969; x=1780578769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcfHENymJGZHtdeIVFKzzwGhB5oFtix9tlsZ2996z0M=;
        b=eYIz3Xh54aN00qTwuTPA3VaHKXbhO75wa7UDnKhn5RjWQdHqZ0IGyiMGyu4fkQEt47
         Xt6eS640QCUXEdV0tJh8vXwaI94sK4V20kbQ54zQ6r/YgYwA1f8fqqXtXaHjgUB4blk8
         NIyUL4QebfHNdwllNSWytRNBT9QFsWuC/saj6gOFjmFnnnp68xFORemJbIkaI3B4JLVc
         wEJqZ7X78+TWKilDjW2YKVwH0Nm37T1d9BnYnYc/Y9rmq6+1puelPAfruLIHb6DTrKjA
         Y2ajdvmPcQNxq1qqXR/PNQsrrjm89149TeEffoxqztuNYnJjYznoTJPQOGZ8UEqXJf60
         le2w==
X-Forwarded-Encrypted: i=1; AFNElJ80oeIN2lGE3jB2V+lv3LiiG+/XVWuU5AAJw+9/oW4QVkhZBTXtCocYXVlyvnrizL3U941AIGPOdjs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWR77ra4ID0iGeu2bv/skp8c6qdr1fL/vAykCj5Pwa5ptS0hmf
	Q262ufJpmPQvT+w+GvQwyWDn8nEajhyrn9DnSS/4+joyaAcBx0BEw+hH
X-Gm-Gg: Acq92OE+WBlsP/Jm8iLvhOMBcVhK0biDJdf7msj7aGCzhJnVMbvrmOQWRKtRctEapl+
	wWtghba4FvPdViRVkz2xtZsvi5N122mroJtYqWoGSQctdJACBp755MCocIInYAK5xbOTmfeFuxi
	3WDy1Hq+5spjfPRnTSfpV4zeNsiPdpfA50eSFVTcVE+qUF6qCmL8eoqkTuvRS/gocRDh3XRLj1z
	LxQ0btpD3LWJW2tBLrfn9fsdZN8bB9Xkee4CRmONJkJL2sBK6d55F8jyFOk8gsxB5KSf4Jplsz9
	ZXxBfIrCeO4xBdrYbHI+AQz64E70zmD2XXnXpDwP4VuOEoChPifpXRukTb6UygsGxudrBo8pcky
	dIMmkGEJ3GpMazATulksI9aCnr1MJsUhjIoyBNkVN5w0pSv0YTDVoSa4+ob2qRr1UxyzdST8FpR
	WQujj/HMmD1DXNqnzscOVXdlZSw3t/MGf4L7+rrQlxri8=
X-Received: by 2002:a05:6a00:2d8e:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-8415f5db43cmr27481058b3a.20.1779973968589;
        Thu, 28 May 2026 06:12:48 -0700 (PDT)
Received: from VM-0-14-ubuntu.. ([124.156.198.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6d60d07sm6710443b3a.0.2026.05.28.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:12:46 -0700 (PDT)
From: quzicheng315@gmail.com
To: peterz@infradead.org
Cc: arighi@nvidia.com,
	brho@google.com,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	haoluo@google.com,
	joshdon@google.com,
	juri.lelli@redhat.co,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	quzicheng315@gmail.com,
	quzicheng@huawei.com,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tanghui20@huawei.com,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	zhangqiao22@huawei.com
Subject: [PATCH v3] sched/fair: Rebuild load weight when switching to fair
Date: Thu, 28 May 2026 21:12:38 +0800
Message-ID: <20260528131238.3879110-1-quzicheng315@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528092535.GC343181@noisy.programming.kicks-ass.net>
References: <20260528092535.GC343181@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zicheng Qu <quzicheng@huawei.com>

Tasks that run outside fair may not keep p->se.load in sync with their
current scheduling policy and static priority. sched_ext, for example,
uses p->scx.weight as the active scheduling weight, so p->se.load can be
stale when a task moves back to fair.

The fair_sched_class expects the sched_entity load weight to be valid
before the task is enqueued. Rebuild it from fair's switching_to hook,
which runs after the class has been changed to fair and before enqueue,
so both sched_ext disable and SCHED_EXT to SCHED_NORMAL transitions get
a native fair load weight.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
Changes in v3:
- Move the rebuild into fair's switching_to hook, as suggested by Peter.
  This lets fair prepare its own state before enqueue and avoids adding a
  sched_ext/fair-specific fixup to the generic sched_change_end() path.

Changes in v2:
- Move the fix from scx_root_disable() to the class switch path so it also
  covers partial-mode SCHED_EXT to SCHED_NORMAL transitions through
  sched_setscheduler(). Andrea identified this missing case in the v1
  discussion.

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ebec186f982..3a21ceefcadf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13837,6 +13837,15 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 	detach_task_cfs_rq(p);
 }
 
+static void switching_to_fair(struct rq *rq, struct task_struct *p)
+{
+	/*
+	 * Tasks may come from classes that don't keep se.load up to date.
+	 * Rebuild it before the task is enqueued.
+	 */
+	set_load_weight(p, false);
+}
+
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	WARN_ON_ONCE(p->se.sched_delayed);
@@ -14233,6 +14242,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.prio_changed		= prio_changed_fair,
 	.switching_from		= switching_from_fair,
 	.switched_from		= switched_from_fair,
+	.switching_to		= switching_to_fair,
 	.switched_to		= switched_to_fair,
 
 	.get_rr_interval	= get_rr_interval_fair,
-- 
2.53.0
