Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A53ACA58
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806646; cv=none; b=lmDAwdtcovLsUxZ0K8atLQZnZqX7FbApiNcD9CigdhGdHWY/9nbaMDuR99aaUwWyDh4KBwuUcNHuu3/s+HSfdMuQP45Klkb4hRZgpeEkIwCT/UhpvQG3Vxk0AYeJ00WkLl2THPiwZWSf6hk3UGiVy4/YmAlEfjHvOWkAUzl5zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806646; c=relaxed/simple;
	bh=uzRhG2waj9YPKA+eQoa5kyWaQhKsS1FA6irUTeRvHuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfuSBs3FIrxbv/xKIqbRYs2AFrhYGfQeEdsJbfG2DujyS/UAlUf7EAYQCUwuwVXEBHtkJJnWew9nvlJev8sdCp0yjHdp649XJz1pPzCeherv+f7dYsq9bCbtILzJnC0SHn1ujjGsK/1livl3UAGnycU+vSnGxtPhGaJ/dZWWd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K97AKPkZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K97AKPkZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829abaaa92bso139810b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772806645; x=1773411445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b15QORKSDrTLJTIKvMf1+ueicTFAHfVm0j93qNup2Mg=;
        b=K97AKPkZFgKM7XsursJfx4Ujyq5XIRHyoFhtsrAqV7+MhBSLZp8T/tlG4Qin7K/sME
         VipAQC6W1y4QGI1FVdQKSafFPqXo72K88mCs6BCY/tO79ChhsLtViqQWzRNktbN9j5D1
         rRVD/3OZb9u6hYNPlzHkXDf8SNkA/4xeQF5zKAJQMVb35Kz/+BRaJOVKouX5jDgSmscZ
         aDKVVgO10gXCAOsjSYi1C7oJ+bPsX5vWt8Fnsd7kjNEmbK0chlOCBqDSv7ORQMbpO5Pa
         f0TtJqrwg+7emUqoOcDQZm7T+2BAjOgLN7t6VeNRxa1a9m4lfSZHQ5/PyNUAKVfksChZ
         isCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806645; x=1773411445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b15QORKSDrTLJTIKvMf1+ueicTFAHfVm0j93qNup2Mg=;
        b=DQHxK69y06USCHnaCw9n3nFA2sY/emb5g/JS0BLMeZB4le6DLw2TXijMOLfB/ExmMB
         dMHjZTZW/XoaHcO+H/8OGZB///A0HyVmnOh4/ol5KZqwKbcqBF3lCT+jhN0qWhkr1WbB
         0KQhI6eyBBdUk0//GedjOghzHgTNU5rLvisKORIotbUhbAj2bypw6l8byaYm7Aap4Et5
         Z14pA1NUCSACdRd2zun1DNm0cQ6WHWGQFppVfB3TNRcMPuzGU6NjgTAoAOuTiY4RBrk7
         5nS0jlud7wDDB9Dcq7eHpMs4vOsgkLqSoc+rv+JJNcDMfXbnjAsAv6guPkNZFSMqtrN8
         MBrw==
X-Gm-Message-State: AOJu0Yz+IczYOkDjnJQqpRQl4F6KelH3QVmcy1X8pvKdS6X68TdSm4Ek
	6JYgvCd5EgLVbkZmeqYdSv778DYG7wNpIuoEaJEkmQPsrG9CsqvqDc+fcOti4pXG
X-Gm-Gg: ATEYQzxp46zQpwU5t4GwsOss5WUC8Chv88B6n4AHoyy03xv5beYiL1aJ5GR+2f6EFnm
	93PXEDxUJAH4uUrEXR3YWGm0KMuLjSruIMzJbm6R5jwvV4ZaxYvB1yX/hm59Rwr5PMvueu/IF+y
	0iULMzKgNhA50NhrKf6wL5eZjTjpJq8uI700MI6OM1LP5r9mwz9pwrold3c2o3JqP1jt4LV/gYP
	H49+lOubSiUUlYcUmFKHxNxcANeCDYWagJMMKhRSFzGiOHQoZOsrCNLARQf0fCZlRvIo6m7LcR5
	h8CUAKv94vCfQDP7MSSpV7wb55Gs/dK9G1ssSr9np7X6z+ztNicwXFCY8UuYbz/z7bH4Rie7c6j
	LI4PiGsgLJuhyQwvd/rit+ToCohpRp87k0rMjDeLnC1o51xmKd43/eDX9khyH8WxfvJqr0Q+aKG
	rQKFzk7umiChei+qsbiv5oGhBf9+gZ6FwU4tgr9PXvcmS+dDbq4NFNqv0wJEKhn+w/sgaP6hqh/
	m4=
X-Received: by 2002:a05:6a00:4505:b0:827:4343:4c1 with SMTP id d2e1a72fcca58-829a2e39d41mr2103832b3a.29.1772806644725;
        Fri, 06 Mar 2026 06:17:24 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4866763sm1920504b3a.38.2026.03.06.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:17:24 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH v2] sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer
Date: Fri,  6 Mar 2026 22:17:18 +0800
Message-ID: <20260306141718.2721073-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306105901.2543743-1-suzhidao@xiaomi.com>
References: <20260306105901.2543743-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_enable() uses double-checked locking to lazily initialize a static
kthread_worker pointer:

    if (!READ_ONCE(helper)) {
        mutex_lock(&helper_mutex);
        if (!helper) {
            helper = kthread_run_worker(0, "scx_enable_helper");
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                     plain write -- KCSAN data race

The outer READ_ONCE() annotates the lockless fast-path read, but the
write side uses a plain assignment without the matching WRITE_ONCE().
The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain write leaves
the pair incomplete and will trigger KCSAN warnings.

The error path also has the same issue:

            helper = NULL;
            ^^^^^^^^^^
            plain write -- KCSAN data race

Fix both plain writes by using WRITE_ONCE() to complete the concurrent
access annotation and make the code KCSAN-clean.

Fixes: b06ccbabe250 ("sched_ext: Fix starvation of scx_enable() under fair-class saturation")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
v2: Add missing Fixes: tag (Andrea Righi)
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9a1471ad5ae7..c4ccd685259f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5355,9 +5355,9 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (!READ_ONCE(helper)) {
 		mutex_lock(&helper_mutex);
 		if (!helper) {
-			helper = kthread_run_worker(0, "scx_enable_helper");
+			WRITE_ONCE(helper, kthread_run_worker(0, "scx_enable_helper"));
 			if (IS_ERR_OR_NULL(helper)) {
-				helper = NULL;
+				WRITE_ONCE(helper, NULL);
 				mutex_unlock(&helper_mutex);
 				return -ENOMEM;
 			}
-- 
2.43.0

