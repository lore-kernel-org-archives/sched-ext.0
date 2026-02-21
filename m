Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B914A0BC
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771678593; cv=none; b=bI9SUF1wNgulMPaygSx6L7PELc1Q3tONv7+qju4MKYl3xav409GULm+Coc/ldGF2KPUtNfR48RpUQLwQJDWN/z6HrDNZePJLGw+rW0JqoUHHpQ+lEtWj7ThPIw3GqHuB/Rw3NYXoKIKdd2DIXmcH6Q1vyz7QN5wtYA78V7QSQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771678593; c=relaxed/simple;
	bh=SrRO67JDibQhdAq+R4K0rlqzNCUL0cyLogGPLdQ3gsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DubqV9+64t9eVlLj8pB38TNgPKjkdV1ForM+3oWjyGyEd0clvyWDvLSUleiKn349TfknWB3cAyNUXYlQbfeJMcOWqAFt5EXzwaSKNfx4EZFuWGLUEz1A+oxxmA6oq0l/j/MQSaLjAK5gdKNE1jvXdSAFliNzxhT1hJtPtFguvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+AK4iKh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+AK4iKh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a23f5915so17018305ad.2
        for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771678591; x=1772283391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ+jJmMJ1CAmp44v8GdLnXRLazTuHP4BYKQxTq5ys94=;
        b=V+AK4iKhqcVZytM+QtWrA/kSs4UrzZqbyagbUTWfvg5tPNXVhfmaYakAH9r6p3X21a
         kFZD9FBm55sJc1OG2DVulrDJJ1POX3Xf0GZAN31FiNmlZ02Qw0d/wU370hlDdoL/gzny
         TzrNwGw5icWArcKUrEUXCTORQnnH4OfmWHv9Fc7qkXXfzNkSVgMdl+sgdoJJ7pjt17xX
         cWdBiplDNNENpyMD3eqsZVoUpBKabreWXiG1KjWx71pk6jVD0q4GTmcQFlsLW+Ig7yQa
         wnDoYimu4td3xc3cTR4Jn5cpYYQJcypihIwqr/rGL+mBjn4KT9xZoeaDNABl9MuSJHUq
         IGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771678591; x=1772283391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQ+jJmMJ1CAmp44v8GdLnXRLazTuHP4BYKQxTq5ys94=;
        b=k3k8/iY4QZDbl/CYzcrWCb2dsf2NVWDo4vIOakG1BTRBWcQVREgqtZcKuICnUvSPdy
         UD4feZbQjVF2Q2fmVkN4mbddNh3oyEGVmxNKujoZ9ZefO97XTGVRy6Gfx+2lqpyEWKPl
         /ctQaZEWsFR5nfN1dwTG5wcFLMgGKIYYJQuJ+BojdTISLSOHeLUwlO8HC9QzS64NwGf1
         s4KWFqS5p5xShOke/IQW/bWiEeNxaT+cfkCXKXYUoovIztKFed7wUdKNgYSqTjFAjlTG
         F62JU1Pm1ATdBql7kxugoCJlX6PEGzE+5bh3G4sVCoFl0u/BqIJ6T96qCWUJi4DuVVOy
         W6iQ==
X-Gm-Message-State: AOJu0Yyib23aagO1LasrhkjUzTnwObhRcMBhyMvwDemiGv7RuMHPllvw
	wgx87uOs5NkyQ3qCSZlfNHZBR9k0YAFg/IZeBi2zhVHaz36Ffsn8Z9StcKBh+A==
X-Gm-Gg: AZuq6aLfae+CoVG5Xqg0eJ/MLMvXhYx+BorO5cZE0yb3odkdPcR7Pko6bOkzXhNXS4i
	xIb6zyEWx2pEAgcsrPrsXkWoshujjUqeqV/F2EdudyBuzf21uZTv2O5pbIf9jtuHv0iktCnHe2n
	mvJfipU/A76UAzzDg4fY1TpzSWOkzfH/SCuH3P5l2/85kLCFA0w6uGFtepdqR/pxKfLsdW/Dk+2
	hoHLXWCBj/D6DcCMGqBMNq4gjHadxHDcsd1TLyQFTiHcIQOM81oh/mPDdWEpwJF2AKIfgB7TV1V
	DFFXhpxsq3A3W1CVZ+WhF3Ku34Z2Qbu6KqzoiLLDtDS5snCQ5hNL8JdrAEemSElIN3ooG9oVRqd
	qVKiqfyB6KNBwtx/Uy8RsvkxgBfhPaSSj7geYfnPKd8bQt59GsJF0t1mst9HbdTlsNwZd7DiQ41
	F4eSPUVfGWY+UeQuXtKkhlauMgOfgDkpO2d6uh1NBc9kMYxLK8EQ==
X-Received: by 2002:a17:902:c94d:b0:2a9:4369:6426 with SMTP id d9443c01a7336-2ad745941edmr21902735ad.57.1771678590868;
        Sat, 21 Feb 2026 04:56:30 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:4f:a1e9:3b8c:51c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e29asm20742195ad.44.2026.02.21.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 04:56:30 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] selftests/sched_ext: Fix unused-result warning for read()
Date: Sat, 21 Feb 2026 20:56:14 +0800
Message-ID: <20260221125615.1119571-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260221125615.1119571-1-yphbchou0911@gmail.com>
References: <20260221125615.1119571-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read() call in run_test() triggers a warn_unused_result compiler
warning, which breaks the build under -Werror.

Check the return value of read() and exit the child process upon
failure to satisfy the compiler and prevent unexpected pipe errors.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/init_enable_count.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
index 82c71653977b..44577e30e764 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -57,7 +57,8 @@ static enum scx_test_status run_test(bool global)
 			char buf;
 
 			close(pipe_fds[1]);
-			read(pipe_fds[0], &buf, 1);
+			if (read(pipe_fds[0], &buf, 1) < 0)
+				exit(1);
 			close(pipe_fds[0]);
 			exit(0);
 		}
-- 
2.48.1

