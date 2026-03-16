Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F627B34F
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683392; cv=none; b=iravszD0FCds3N1PK7qlrgipI7QSfM53gcmTQ6viJHth5qFnL7FnZmzxukr6H3aPArxLXPcbfFyZWR+F27t5kuhZEAVq8zJntv7o49aHZ0OfBQcnQNF2duIQYb97m/w3/p8RKPGEeSja6Xya6+fRpLOgJJ3aWNicAfeuRLpOMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683392; c=relaxed/simple;
	bh=DU0n9rJChBDjHgkUlMsa1lxwPXfQaZZ4fNEfJ3pcPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSyGwaT4Pt3HJmuFgKsjR4Ay5uFFK+c+XSc50RrQGFNGUgA3sm9XNOVkwSfuBsVTRlD1lUUnBGzNxMFuujVZBtC/PhbkMzIX4uA1lwE5wK4tGhZOKx+gdNkv0FCrz/I2qZ6R/gETwgnDg35/mq4L8AHfid8z/74hUtVIfdtt/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=likpNa+D; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="likpNa+D"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2793969a91.0
        for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773683391; x=1774288191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYpHLLwWXDBDFbH6blUU7BN+FfUISkohJ/re1DCzvfA=;
        b=likpNa+DsV+OBpm0sME5ICkKe+J8zcxsTxDNROARXMcLlKo9EUW/GVs4k6Wek2xW7B
         ArMk50ZHwl1nAbX31LUCJZbERTVbShARtinex6QjFWKTFGlLwSuts16BxzT9fwBHG4nA
         UiOx9tS8uJzyRC+nSocZT5JimxJ8IBU5J9nQpSqjcEu5uM/tIsSkgHD8D1LZy3do8BfH
         Pyd4s81lCzxZy4vMhJ+ntCS6WpmvTIQEsOZ7ngDU7NzFzdJ4gUzKOpOy7ChuZ2o9nQi5
         HWXUt6AKB/h8IdupP0WPVDZn6jNYaQRnfyjPBhsU3qtbwCqSxzyiEa/9snqe6op9tGwi
         rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683391; x=1774288191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYpHLLwWXDBDFbH6blUU7BN+FfUISkohJ/re1DCzvfA=;
        b=GGjXBBGLKdl9um5LBQHy1esI1//LJFKARygdqLQd+1M/M1EiEzcXwlwofsa0KawSkV
         Yd1COX7kS5s2kBk4u3/+vewcaiskTRwlDLdF6Qicpiji45bdBXZTmKNVqeKq2u9jn1dc
         Pz10IWxnetVIKRyq1J3rXYezQ10cTg+H3BaeaDo/4+pG6lMpGRxQozX/y/NRapBagDQb
         7fwyN7WvsTxi17NvunmiO2BLJExX8wHCK9bwt6SPcq94cbEnqZmduRrGJnmMRD95007H
         2DcZs5PZ4lmOBbcCPR52vqktTh/OyO6rL75r7wDcHSP+01o2rnMpqHcA9cEcjCHr7iFr
         xuqg==
X-Gm-Message-State: AOJu0Yxb59YPWvCQdxdCqJJbp7abKIMurz2ITyNdwitVeMEjc/rPr7DE
	V/WRZ7rP46BqhItVGK5Ynk/fFQyNJKZOVoiEjv32isEBvVKTjBuI0q4fiF/4QR37
X-Gm-Gg: ATEYQzwqRXVk8tv3+M1k1Y80rBteEPGre0Gilgsw/1A5iBhKxWH0+MSi1sjk/yIZdqV
	+9DZndErjCjmQZc31iTUlzDSzXmvvG6yut2FiTML2HbLkQKCDnkuXNH6zkEnYd55I+BSN/fdn/Y
	rUBBhW7WOlGkmbi8wekiXoaoM7j2xuxJ4jvYjAICYNWT/ibcHCW/n7jzygs8MdIAU3HNjfy+sw/
	ZapzcCCGnZHOl2xQoMNhTosHKhTW/P3NBM5pqfeZkwTMugOwbH63l2vGIp7G+gTIsOAyj1OR8wN
	gL4JR3v51YRxVpQYe30tSb/97njHu1vYajr6JcHAq5zDHNju19b9njNUUCLmPy7sW/Vq2dXZYN2
	eorzsviHvRUmbyx/Ewl7BEqjuRp146qOHQPpVRPiHET3m3kUecyfKA7G+pt92bcOAhzBjR0SwgU
	oDgjZbjyzAchZDweQ8zLf1rvPxQoZKkKR0Ings7qXTp+U1npvQKhomC6hvJdsyrCM=
X-Received: by 2002:a17:90b:2683:b0:359:8d2e:6f79 with SMTP id 98e67ed59e1d1-35a21f6874bmr12777204a91.14.1773683390536;
        Mon, 16 Mar 2026 10:49:50 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:6521:1510:d053:7359])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bad8a4507sm300368a91.0.2026.03.16.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:49:50 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1] sched_ext: Fix slab-out-of-bounds in scx_alloc_and_add_sched()
Date: Tue, 17 Mar 2026 01:49:27 +0800
Message-ID: <20260316174943.82077-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ancestors[] is a flexible array member that needs level + 1 slots to
hold all ancestors including self (indices 0..level), but kzalloc_flex()
only allocates `level` slots:

  sch = kzalloc_flex(*sch, ancestors, level);
  ...
  sch->ancestors[level] = sch;  /* one past the end */

For the root scheduler (level = 0), zero slots are allocated and
ancestors[0] is written immediately past the end of the object.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in scx_alloc_and_add_sched+0x1c17/0x1d10
  Write of size 8 at addr ffff888066b56538 by task scx_enable_help/667

  The buggy address is located 0 bytes to the right of
   allocated 1336-byte region [ffff888066b56000, ffff888066b56538)

Fix by passing level + 1 to kzalloc_flex().

Tested with vng + scx_lavd, KASAN no longer triggers.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b942918fa364..ab8150b8de57 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6365,7 +6365,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	s32 level = parent ? parent->level + 1 : 0;
 	s32 node, cpu, ret, bypass_fail_cpu = nr_cpu_ids;
 
-	sch = kzalloc_flex(*sch, ancestors, level);
+	sch = kzalloc_flex(*sch, ancestors, level + 1);
 	if (!sch) {
 		ret = -ENOMEM;
 		goto err_put_cgrp;
-- 
2.48.1

