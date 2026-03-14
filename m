Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59B27B340
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773462067; cv=none; b=FKPsq8bt7KnidDdcnCkUl8sTT3bsjCEnd9TGZGHyuXFe817F1S8WBi/sMWIZyg3zlvMGrxMUl4zabg+hvWKPsgszHn8X+QHrbh5KWx76F5bHAjfKyjl3bL4dRezgypqS2FSb/6pRMqLxjE1QyGYyF/JiJ2OEvXspSe+LBp8V7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773462067; c=relaxed/simple;
	bh=sICVE7dgS++qcFAxz5C11ahKe9GLzGKtWqPubu6Agh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foja/MHRYdV9xdg+q5vX4N9s1KZHLXmd3nicr0ruwT/p687Xen3l2n6NyGSMr8/pX8ylfDrc++j1CYDdahfsqgCJLBpF8VXAI3+anhwXdDoI4wO6AQvyMyzVjsnIhXIIgF2QIrLLdHyYi7z57gD6znr8ptoJHXG1F0bB3mG8Bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXKfrORd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXKfrORd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aea41d4fbcso12239645ad.3
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773462065; x=1774066865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otExa5GONqRAvcuEF0KgOoP9eruY4lPd9au13FHAj2U=;
        b=gXKfrORdgARfRIHkcnr0/gZHM9gyU6oQmlGITA/r7dJ0fPuBVGwG7wtk+xxok9ZmBO
         KZ/n3cs1hO31s7NdC5WUx5aQxecrXWmShJguhCibe8KvmdxcrJEzA/TQ0b/H7ONsGrG4
         7WFUSf2y+ux8UAMoFsNMeOk6G2uHXyWB377sTNu2CH9yEzUE9g2BrA8SjRi0n8t1kr3F
         SuOAzd/ttU+T6NjfPjJrZ06DCUdIAPWvvrzzxb1KQAv16ejo3eMJygmsGxPBbWmuOMnK
         xkXWGBakX9l5BNEYS7pEbnVZuK0Y+tUlGoKUW1BwwTtdAzUtYpAL01BEwHahp5x5+1je
         lZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773462065; x=1774066865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otExa5GONqRAvcuEF0KgOoP9eruY4lPd9au13FHAj2U=;
        b=QtTJEnohCWduuyIouq0C/j3xRSW82aGAJeJCekPtNtt6ZFCnPhRxG8piGtQSG3rgIb
         J2hZ33NqLZSwAG6+NVTRMZMBsC1CNEGM/xiM90LjLiBfffdbFgAmpM7oSUZ/nzvQ/RUh
         oBu4xaeNT1c4nld0unImx6+WvBBiRgyigsDefbIhqFt6TGtWByN11VI9/2Mno9VA97gt
         b4Fuf3rXMtwtS0fDV67r2pNRu+WU/s7+YfVjHxAmp3UHqRJLBStXzVqqVRiPunzIDHkR
         GikFbovKaFSZLTMJtdJLEJ6RYQlmjRDIOUZ5Iu217FV7rNi9laKyyrY9pUEDZ5bNjFBu
         H7dA==
X-Gm-Message-State: AOJu0YwiRLHALbR64eQ6uETl9hCof33aLM0hyIUT7APS5yi6gKuWQuou
	TvFRhPlyT3yvp0GTxAyuZzNNSzpjBfGDJ0zOcaN92yx1alioh8WeG1tD2TAe7Nqs
X-Gm-Gg: ATEYQzzMZaGvxqncWDoliDXvR9JMkkcPHR8gfPszeZofL3o7wTN4QBg/qS1T4qITyow
	jMHJl092TMeuqunCLFYUpoYm7YwC9vzWb5eitNgfDMphM0piGwvXPSP7Qqy9XnAGSzNQgCayMle
	XYRS6T3zvqCWQGID9ZMjmQHNxfqKlJVuvI7Q7QorbhwP5nfRjmQfBbvu33wKoD3V/ANuVXSPo1j
	Aokp7GwiLALzZduwjCg2MlIrArMbaE1kDkGZ8z4Hwu3+INt8vRJ0E3tncDiutXXSloZz/WdNZIv
	NpZsHjv33IGlUjWYuHWu9oM5GIddagX+2GT3nIsLQJt2tT94KSL4FcGHE799bQAp4OYpLdRjgUH
	z0CiSHGn/itRRoZ0maEI+/NIk+XSajJDaN5rlKFBGcKV/FYql8gyRPxhrhxtiWQKuhrBn54U7qy
	/0XC4vNpb9ZD8w5WYSZj28Use+HIx8JyL6HwKlhP8d0DNUdf7GDcE=
X-Received: by 2002:a17:903:1503:b0:2af:c7c:afbc with SMTP id d9443c01a7336-2af0c7cb19amr33362915ad.31.1773462065092;
        Fri, 13 Mar 2026 21:21:05 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:812:f4b6:2aba:4bed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece416212sm38553935ad.0.2026.03.13.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 21:21:04 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext/selftests: Fix incorrect include guard comments
Date: Sat, 14 Mar 2026 12:20:51 +0800
Message-ID: <20260314042057.29691-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two mismatched closing comments in header include guards:

- util.h: closing comment says __SCX_TEST_H__ but the guard is
  __SCX_TEST_UTIL_H__
- exit_test.h: closing comment has a spurious '#' character before
  the guard name

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/exit_test.h | 2 +-
 tools/testing/selftests/sched_ext/util.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/exit_test.h b/tools/testing/selftests/sched_ext/exit_test.h
index 94f0268b9cb8..2723e0fda801 100644
--- a/tools/testing/selftests/sched_ext/exit_test.h
+++ b/tools/testing/selftests/sched_ext/exit_test.h
@@ -17,4 +17,4 @@ enum exit_test_case {
 	NUM_EXITS,
 };
 
-#endif  // # __EXIT_TEST_H__
+#endif  // __EXIT_TEST_H__
diff --git a/tools/testing/selftests/sched_ext/util.h b/tools/testing/selftests/sched_ext/util.h
index bc13dfec1267..681cec04b439 100644
--- a/tools/testing/selftests/sched_ext/util.h
+++ b/tools/testing/selftests/sched_ext/util.h
@@ -10,4 +10,4 @@
 long file_read_long(const char *path);
 int file_write_long(const char *path, long val);
 
-#endif // __SCX_TEST_H__
+#endif // __SCX_TEST_UTIL_H__
-- 
2.48.1

