Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A41A9F9F
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733937; cv=none; b=f4qnUzly6G9xTURXkox+/gZbgG+qpFM1iZxZIYBZ1Zw8BGmRc3MXbCeYUGa5wvhuoYhswAp+bCD8DggvMAB2emvZ2uv4zk40mXvhKo+VX6d+rFqR62ejpuJ3tJTJoD7GgGX+g2uuqNFXLx4tTFAfQfm7HDGA8YMgYw3ZtmCMGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733937; c=relaxed/simple;
	bh=fujh4qVUVGSwwacEgAeejIs052X4LPQkmwfOiXg4bus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/zWtXbZ8ZAxuohy7YcbtB93fkR5P4pDbAizCgRhgJfAr5A2SLvvScFOCXrTzVTlybnpZZOjd8xb/H0lv9i2iKKQ0/SGY4O1IbIeSt4szsY7WflsEvCKxDZqSOnu9IFmGIe4sGnjZz0p9RaDK8cNrcBgTWLBiGXOlOCQOMRl8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEDtgH4k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEDtgH4k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b05761bec1so2086075ad.1
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773733935; x=1774338735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNU1Y8rNgKwv1GCl8ajLXubJy8RiZOiKGavBDluj1zQ=;
        b=EEDtgH4kKKFKD1HaoomzdORM3NSoQ5xVUK11yk6vhrDsYyPNLJsOibhM7CD2MCPnsm
         oo+A1fIDqnCFiBztZ3X5E/VGhW7PJrJ73+1SLa1C3vN+nlhpmyi3pzMGGxHrVFJww+EP
         a0r0OxhJLis8MeVfdhpOjax7N8LbLFMSxSa/u4v8uONU2nQpFLMqXLKdt0Ncpsxudect
         lYvPEtqcfyCt8YEjMqzUp/0UwVQBqIklHecgCoDchLLNK0el3yHyPtXytxTEI6EwntQ6
         j4U0Q9BUkCDaboWEGGejrZeVSqQqq7EyENpEjHlIf5XHC8Hv4aVI1G/nxVZTc2Tp6/9K
         sP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773733935; x=1774338735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNU1Y8rNgKwv1GCl8ajLXubJy8RiZOiKGavBDluj1zQ=;
        b=lHuUsXtVDS9WRhH8iak5gQa5SPD0FKcm4zM6N0tnReG3UzTZQ7Mw/yH/2EMbHxn9iN
         k2ZCkZ1VihyTcmoPHfj7BQ943tSspZfMEXDP63l79sGgH29QKcLpqs9bE3lorZEcO4qd
         uTFxPLnvtts+geYiSbEq0UNAbkoCpqf83xmcXdUFLePmWJACkOgf6hyR23FRuegZ3Mpw
         djWcJCBa6S4zamDG2e1LSELvwwomehdaNtPjvFGJ6+6VcE+qN1UWuKr2zFkwKmE16uux
         9XItDDFKFC308DhzDaLi7a9iVR5dpnOBRQRezwr96llAs6Xcw14egZQqIAjj9Vl95c8a
         rmOg==
X-Gm-Message-State: AOJu0YzQ0jIEFxUSJ6YXIQ9+pJEQrQAt9B7ooOZn1YX3aPteSSA4AWFD
	bPY9D3OVOisAdch/V8VaihyjdMtP7BXBq6kftki1TUhjtsdUOVDGbau3AYLW4A==
X-Gm-Gg: ATEYQzw3HPG4C4qH11eyv2JhuBv0wyVeTxozlxAj0JvaTSWvzuSuViKzNmljFbzJGpY
	S40PXs7s8somKinUGKpG4vw3pSrTQ1q5tjqpFUA5N5JuHIf2DVFI52Tk6xCqohebFR8BrPCsWfH
	TY4fNJM/JY0abjYc3zQnHeRvh5Nyn5yC918xqISdMSMYaST2fkKfKUUNw90pQeGiDIk8Dn9aFrC
	1YYw2IkBGD4/DOUFN3qs4gSfmUGq7C+XapSIc5iocEaa+2Xzjy3UazlzDVArrSgwgyLjhVSymO1
	xYyMMR+IkS4A+LL9PMk4EXp9ur+IDLHh1qnYhLxG/sBDpeacycjL+TYb8btwzcS0IxQ4iZv3NtQ
	e94ppRie4WG8/lf14p4Xy0/B+hBQzoldyfZdDN2uqLkpMC2FDSflfKUMBZgrJBJmjo1EMT3b8bT
	TnOGXPz7ILeYoco0sh5mSVKGIPEGYVo5GXCXeJBPnMQhODGPw+D1Qt5bkLniFt7cG4Ioy69utYn
	u8X
X-Received: by 2002:a17:902:cf03:b0:2b0:506b:e6f8 with SMTP id d9443c01a7336-2b06357ec87mr23739075ad.5.1773733935362;
        Tue, 17 Mar 2026 00:52:15 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56defbsm119560655ad.10.2026.03.17.00.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 00:52:15 -0700 (PDT)
From: soolaugust@gmail.com
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Fix typos in comments
Date: Tue, 17 Mar 2026 15:52:09 +0800
Message-ID: <20260317075209.1197766-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

Fix five typos across three files:

- kernel/sched/ext.c: 'monotically' -> 'monotonically' (line 55)
- kernel/sched/ext.c: 'used by to check' -> 'used to check' (line 56)
- kernel/sched/ext.c: 'hardlockdup' -> 'hardlockup' (line 3881)
- kernel/sched/ext_idle.c: 'don't perfectly overlaps' ->
  'don't perfectly overlap' (line 371)
- tools/sched_ext/scx_flatcg.bpf.c: 'shaer' -> 'share' (line 21)

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c               | 6 +++---
 kernel/sched/ext_idle.c          | 2 +-
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26a6ac2f882..dbcedde85d7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -52,8 +52,8 @@ static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
 /*
- * A monotically increasing sequence number that is incremented every time a
- * scheduler is enabled. This can be used by to check if any custom sched_ext
+ * A monotonically increasing sequence number that is incremented every time a
+ * scheduler is enabled. This can be used to check if any custom sched_ext
  * scheduler has ever been used in the system.
  */
 static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
@@ -3878,7 +3878,7 @@ void scx_softlockup(u32 dur_s)
  * a good state before taking more drastic actions.
  *
  * Returns %true if sched_ext is enabled and abort was initiated, which may
- * resolve the reported hardlockdup. %false if sched_ext is not enabled or
+ * resolve the reported hardlockup. %false if sched_ext is not enabled or
  * someone else already initiated abort.
  */
 bool scx_hardlockup(int cpu)
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ba298ac3ce6..8fac8dd9625 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -368,7 +368,7 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 
 	/*
 	 * Enable NUMA optimization only when there are multiple NUMA domains
-	 * among the online CPUs and the NUMA domains don't perfectly overlaps
+	 * among the online CPUs and the NUMA domains don't perfectly overlap
 	 * with the LLC domains.
 	 *
 	 * If all CPUs belong to the same NUMA node and the same LLC domain,
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f2..88465b0d0c6 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -18,7 +18,7 @@
  * 100/(100+100) == 1/2. At its parent level, A is competing against D and A's
  * share in that competition is 100/(200+100) == 1/3. B's eventual share in the
  * system can be calculated by multiplying the two shares, 1/2 * 1/3 == 1/6. C's
- * eventual shaer is the same at 1/6. D is only competing at the top level and
+ * eventual share is the same at 1/6. D is only competing at the top level and
  * its share is 200/(100+200) == 2/3.
  *
  * So, instead of hierarchically scheduling level-by-level, we can consider it
-- 
2.43.0

