Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704334B1A4
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223325; cv=none; b=YtUvkCZfDe55AkOHu6wkE+QvaaQTnO5wBK49ariGxGGJadS6WX/a/cK7ZQvn0lyvNXBf6DiPi9hIRY/LHiuIC17NLvKF2IeweBjvCBh28+imeqt/+jSKQAlF3LMrBdZv2uzqT5u/uWMf1xd7HHilTKFTh4Lm718qofH+DcQ3BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223325; c=relaxed/simple;
	bh=+PdaX6SU01vYj0Kyt6Ca2pg2bZ5zB4dRCXnSiiULQvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDLmqTOr0lgs6B+fbtztREsLkAeqWWjkzKGJTwH6woiPjB4Re3tM40Wn/qFBSxt1wlDyrcIMeUjULwYtxiRFpkoy5CANbf12v3OCC5RpLZr8QCa6zvNrNUtTqiViBYKNmkqcU7UXcKR8Y7ME5+LvkrsiIg/AqF9D46bvCE7zQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLtJOHbf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLtJOHbf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba4efedbeaso12144835ad.1
        for <sched-ext@lists.linux.dev>; Thu, 07 May 2026 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778223322; x=1778828122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3AzwFZgpgejyXKWSisGZHVUMIUs7uzAl/MKo8Us1YA=;
        b=sLtJOHbffSidJCZeMHq3KMLgxe+TV8uK99D/kcHNiW0ieVdRulgDpgURP9Zc5veUf2
         BmLFP3vPXbQrXka08IbDSnASkVATaiEkMZGfx2QQGd441JZj0TW/lYgRbwxHEDIWoUlI
         iWCjt4dmgkCSjxufSkWHxuDKxQfVoXWTWSUut8wv3eRm+kYa93fJI+52vu4ZNxbteGlt
         5SU4IiX3avIKH0mWSRvHFsmXxUmyBIqJN2coC3mMS3Yau4KxYac5hbdfRnviboopIocA
         9oBnjm1CM1CgV+ZSZyenHLrGzRE7TJeW27hlHhsCAp73WF8LMlOnKvC6n9NuQcWGkxzI
         VMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223322; x=1778828122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3AzwFZgpgejyXKWSisGZHVUMIUs7uzAl/MKo8Us1YA=;
        b=sxOd1FJyKhUgwVnv1fEPjwQwDGMUtgNclLbSCw5vw3+BHZwQbziyzJOAzl5s1uUQ6c
         4ZbjdqCfHCxRyC6vS5Xo9a1KSws+8KkEbLEW78xBZNN9YN6cfba8mKnOlIO/Jdo1OWi1
         ceZZBSdAX6lVg0+VMViIlR+mMqxGKiAeuV01tWvd+h57AP1A9tyXCe3dh+qDQ9d4A1Pq
         00sPAGxfHoe0UNv8Z+JgPGNJvVGOLGFk8t5Jj4L2feX1sU/WwoLEjtRHiei7N39qN0Lt
         Kb81QZmfOgpBMCKhsXRGfE4ivYLhT714owwQvSxtqBzU7z7GVudqcDSK3XsQVQP9X8HS
         Gw2Q==
X-Gm-Message-State: AOJu0YyYRuzgxdFPgSkHLHXHTWKCVMhMvpYLdmCOM9J77kBT7luqaRJy
	Id1f6EXjqNA+3hC90rmZzBtyzEUN/xBqU23qWj/ecOnl5he7+juENBVvuAP5Cw==
X-Gm-Gg: Acq92OHHvzHgt4y2Kqo/8QsmYHWqF5egjtnN1hTYLXI52EYgvyBEQlHDnDE7H2A3GOy
	3VJr5SfoXxTxwHdGDHkn7OH1CfNIlnf2bzcAp1LNMh0Ph2XQ/Zy84j2aDReNEKex1y7Oh+/VByU
	qPcIz5w5TYtaJYz9zBCDH4OeDar1YoPbOgnCSCX3UQzc5nrhjwQtVm0FqtBK/Jd8WVd1gVZ14ji
	gSTmUq9ZhMT6vMcaX6TVLmjdxqmwpqxrNO+QM5FdiwmnkvojIG/b/VIxER131zaPIYq68xWcNWm
	+xOCBIKuTs8b+58XIEdlRMWHZZ3Xg70dntdlsVp2CwElmj880bzfqF6XIqW8x4Rt2Bi7aLs80ZQ
	RXRI5LA6JPxmSWtl8K3kE2pzfDh/YWcjZcsp07qw2LNlisOSEEoZmP6xJ9/2y7uOkQvMmVLdosl
	WD7Krhgi4l+l/wTPGee+9F7F49p5ONZEpCvn/WyjgQo+EL8Wwd8+Dz
X-Received: by 2002:a17:902:8641:b0:2ba:6ffa:bde0 with SMTP id d9443c01a7336-2ba79c20bb9mr90486055ad.19.1778223321620;
        Thu, 07 May 2026 23:55:21 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1e70:8174:f80d:ff44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm9481265ad.54.2026.05.07.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:55:21 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix select_cpu_dfl link leak on early return
Date: Fri,  8 May 2026 14:55:12 +0800
Message-ID: <20260508065514.1723906-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If run() exits early via SCX_EQ/SCX_ASSERT (which calls return
directly), bpf_link__destroy() is never reached and the BPF
scheduler stays loaded. All subsequent tests then fail to attach
because SCX is not in the DISABLED state.

Move bpf_link into a context struct so cleanup() always destroys
it, regardless of how run() exits. Also skip waitpid() for children
where fork() returned -1, avoiding waitpid(-1,...) accidentally
reaping an unrelated child and triggering the early return path.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
I was hitting this error when testing the defer SCX bandwidth patchset,
though I think it shouldn't hit the bug under regular testing. Tested
this on the for-next branch and everything still looks fine.

 .../selftests/sched_ext/select_cpu_dfl.c      | 54 +++++++++++++------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
index 5b6e045e1109..7e342c0cec65 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
@@ -6,6 +6,7 @@
  */
 #include <bpf/bpf.h>
 #include <scx/common.h>
+#include <stdlib.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include "select_cpu_dfl.bpf.skel.h"
@@ -13,29 +14,44 @@
 
 #define NUM_CHILDREN 1028
 
+struct select_cpu_dfl_ctx {
+	struct select_cpu_dfl	*skel;
+	struct bpf_link		*link;
+};
+
 static enum scx_test_status setup(void **ctx)
 {
-	struct select_cpu_dfl *skel;
+	struct select_cpu_dfl_ctx *tctx;
+
+	tctx = malloc(sizeof(*tctx));
+	SCX_FAIL_IF(!tctx, "Failed to allocate test context");
+	tctx->link = NULL;
 
-	skel = select_cpu_dfl__open();
-	SCX_FAIL_IF(!skel, "Failed to open");
-	SCX_ENUM_INIT(skel);
-	SCX_FAIL_IF(select_cpu_dfl__load(skel), "Failed to load skel");
+	tctx->skel = select_cpu_dfl__open();
+	if (!tctx->skel) {
+		free(tctx);
+		SCX_FAIL("Failed to open");
+	}
+	SCX_ENUM_INIT(tctx->skel);
+	if (select_cpu_dfl__load(tctx->skel)) {
+		select_cpu_dfl__destroy(tctx->skel);
+		free(tctx);
+		SCX_FAIL("Failed to load skel");
+	}
 
-	*ctx = skel;
+	*ctx = tctx;
 
 	return SCX_TEST_PASS;
 }
 
 static enum scx_test_status run(void *ctx)
 {
-	struct select_cpu_dfl *skel = ctx;
-	struct bpf_link *link;
+	struct select_cpu_dfl_ctx *tctx = ctx;
 	pid_t pids[NUM_CHILDREN];
-	int i, status;
+	int i, status, nforked = 0;
 
-	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dfl_ops);
-	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.select_cpu_dfl_ops);
+	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
 
 	for (i = 0; i < NUM_CHILDREN; i++) {
 		pids[i] = fork();
@@ -43,25 +59,31 @@ static enum scx_test_status run(void *ctx)
 			sleep(1);
 			exit(0);
 		}
+		if (pids[i] > 0)
+			nforked++;
 	}
 
 	for (i = 0; i < NUM_CHILDREN; i++) {
+		if (pids[i] <= 0)
+			continue;
 		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
 		SCX_EQ(status, 0);
 	}
 
-	SCX_ASSERT(!skel->bss->saw_local);
-
-	bpf_link__destroy(link);
+	SCX_GT(nforked, 0);
+	SCX_ASSERT(!tctx->skel->bss->saw_local);
 
 	return SCX_TEST_PASS;
 }
 
 static void cleanup(void *ctx)
 {
-	struct select_cpu_dfl *skel = ctx;
+	struct select_cpu_dfl_ctx *tctx = ctx;
 
-	select_cpu_dfl__destroy(skel);
+	if (tctx->link)
+		bpf_link__destroy(tctx->link);
+	select_cpu_dfl__destroy(tctx->skel);
+	free(tctx);
 }
 
 struct scx_test select_cpu_dfl = {
-- 
2.48.1

