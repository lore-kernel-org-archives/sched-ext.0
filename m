Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FA3EB7F1
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760489; cv=none; b=eCjuCf1SBh9qU7K+sDXQdkLlRUco7j0wiXsICLGoTIH8fARljLHdXaYA+YbJRtaEHYuWaG6ZF7PkHSSc1isgN+P5+ICNhjH589oMWSL0kNmcVPEbDRXTekoRuEvLxWLirAQiniDK5ede3Ych9UGmXXb/xb1D02i5UmC5pbRd5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760489; c=relaxed/simple;
	bh=c7KQmZK5Y6yOkyPYwhaSIEckbinFQB5PhBs/rVqZDlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7QABhAISmpdde92q89Gcvzw5jY3IEGddpKHRCWYG/eWD6vcxIIxwx4a19rcOVSzB6D6fHRVifLzQ6KLHk9syLPxa+qZxRPTWnUwFDwgK8s6YCbrlkMjZg6AA+pZWMzoWqZna2zBeu7qf0jeoYnqYA8q905lphEuI1c7CJAYSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA3zSz3q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA3zSz3q"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82418b0178cso3514734b3a.1
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760488; x=1774365288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbjaFw4k51gyw6yQJI7IsnXrDIhax19lPondEpenESo=;
        b=iA3zSz3qpynDx6J1/OII712+FKd15y3pcBOTJIdNuJSXa3elah58L4DkxstS6p9151
         LPdvyya/QXDk4INDZ9G5C1GDCzVAAwY5fpLuAhE8V8jicxQp+TP/S7HBaOkHSEgEP9aZ
         xuJZHY0/qSz002gfsOAKHOFrLt6PwWCs9HQDGbB+ZHHtB77US2ONMc+RU2ThIxGWp5hK
         cVRYICPoNB7CgHGRj2TmsB1r5yOgg8Ue6C3gUQbsE1VJBmLB752Wr0R4oeC6zNjmP3Tn
         eA8Wu5lIFUPbkp9fmUwG4798LG18IYazyAFdiIvsOd3eKB1CJtAPmTQcmpQ5EI3p/xEb
         kPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760488; x=1774365288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbjaFw4k51gyw6yQJI7IsnXrDIhax19lPondEpenESo=;
        b=PXzCNJpX+78DtkL0uP3jpFSyh9bJnRHS5iCX0RxvHnPxeDY0mcEQd34RxzKHVOEF1K
         knhyOqFAHJZKnS1pWARCaev3hNfUZVvmA4ItCBfR5HINZgPR65VOSXBldowT7LmQnvfD
         j3TgrsmVARYuoIvFa/UCTFlM1qOSQb0QNcOdCGx1JVrRBt/57uYDaRtzeDdDb6+nY0Dm
         LrzJKz9LROriCNVpez+dm4C8TG9z/kKNCQAWd+QyGnu3xDLpcR1fY+hz+3n5FofPmujI
         DTy27UUcJJBvxn+a2s4DcYgs5vrs3mfjKxScPBHh/3rjwGrVg2qPnQPQFANpPuCp+Bi3
         rHew==
X-Gm-Message-State: AOJu0YwhBs2qBLRsNlDtWdkrYtUoRYyqYqM2jNaZ3z5UxGSxwvVLDTbO
	G8LYo5D40CGHE5jCvouaaU3Qu4f9eGg99NTcO13wHBliqcqvTWX7dUBsg7HqDzYz
X-Gm-Gg: ATEYQzwLy932ym9Zz5X5GofHM7tlyWhI0FBnbk3wxR02dGbS7JDZ9xvjGu5eA1NMjlT
	L6EQBg2KLaYZ9DB44tE+C8IR7ERMW+iX9jFe9PRFk8/WXPr1mMyS5U591vK6jSPBhROCXzb9KoW
	xHOazV983Jhadamv0HjtN2CvPybrQB2JNqhNH0e1ymNxDaocK33u6inYoVAgA0LCtGwIXMFNOBm
	RxiaL7G8V5oFhxhrlYSxOC4Z21JAsaOUKxPyk9JIjOYX1s/JShgYtcFf0pZEULfGPNL9xAkpDuh
	YHqx65uHobcujv3oQJ197GLpJzBcPFtpFcen3wirMh8RkiMC216NoU39qUBEAbTK3j7ryabGawo
	9CgQUcyKFhYomjZTk0QC/m1Fr0c04dxpV7YioF5/Dz4uPTloaUSd4OWhziGaCUi1CkzW+wWiaZZ
	ABzwZ+zVjfLllQmQlIjrMgVWj6QULqLArwUH+y5emBa4xml3+77usn
X-Received: by 2002:a05:6a00:94c2:b0:824:adf4:5a32 with SMTP id d2e1a72fcca58-82a198b4d94mr15483943b3a.42.1773760487474;
        Tue, 17 Mar 2026 08:14:47 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b45f:6469:4218:c64f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727c40esm16833108b3a.26.2026.03.17.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:14:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1] selftests/sched_ext: Show failed test names in summary
Date: Tue, 17 Mar 2026 23:13:11 +0800
Message-ID: <20260317151406.937519-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tests fail, the runner only printed the failure count, making
it hard to tell which tests failed without scrolling through output.

Track failed test names in an array and print them after the summary
so failures are immediately visible at the end of the run.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/runner.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index 90043fd74a60..37ad56c3eb29 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -133,6 +133,7 @@ static bool test_valid(const struct scx_test *test)
 int main(int argc, char **argv)
 {
 	const char *filter = NULL;
+	const char *failed_tests[MAX_SCX_TESTS];
 	unsigned testnum = 0, i;
 	unsigned passed = 0, skipped = 0, failed = 0;
 	int opt;
@@ -201,7 +202,7 @@ int main(int argc, char **argv)
 			skipped++;
 			break;
 		case SCX_TEST_FAIL:
-			failed++;
+			failed_tests[failed++] = test->name;
 			break;
 		}
 	}
@@ -210,6 +211,11 @@ int main(int argc, char **argv)
 	printf("PASSED:  %u\n", passed);
 	printf("SKIPPED: %u\n", skipped);
 	printf("FAILED:  %u\n", failed);
+	if (failed > 0) {
+		printf("\nFailed tests:\n");
+		for (i = 0; i < failed; i++)
+			printf("  - %s\n", failed_tests[i]);
+	}
 
 	return 0;
 }
-- 
2.48.1

