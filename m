Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7D12FF69
	for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771748749; cv=none; b=OqdqP18TWPSOyzTYqDyQNheeantajVBA4PgPPcat1134zmeQtSR3tXssWpl36pfgHxrCWkKgXMbpYg5x7LPtXhu9F8yMkjWyit0fnC+uklGl/OBgQKuKV2iiwlvbbogbRaYntSlC0XBy8ttMTFRQYIoLalcb28gmJUGRpqlffa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771748749; c=relaxed/simple;
	bh=Mob1xEGeQtHlS148VL7ugjBD4Y4GhNEVyHzbrXPodwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGANtegfXezH4/XnwnPhlAg12ga4kzPxxUjXdyHktDVA6JGtJRLrP2q0kmCHvTDHCl4hF72kgpxIoxhR4rY08tPtH4ALs/A3T0poHLz4gpBtNnWx/nGbsi4anqt67+CZNYXq7vcMx4NioRF4VW3qYtfngZl5OHoV6YGMgj5WopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbqDqE6B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbqDqE6B"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35851eadc17so1946966a91.2
        for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771748748; x=1772353548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a11r24azpG23OigxKQeh9aCNn9Oh9JrpgbH2uwSs3VU=;
        b=ZbqDqE6BgkP+YGqDMaOWihCkZHRory4NIicc1pEzb7tt2CRp6PAiuP7xRxIutnR/LM
         bORep+EZGdcr8bLAwNBzfjszfe2QJzjDMm1Xwum4mGkem4AyG+VPtcY07U77HVMddgSd
         8R1P0yfgcq0o6tSEmHQB2Zi+RakudQ27Rhp83u/l6vtyF1LeuED2K5SQ5+vu6o0kWv+A
         uj9rdHami3SKdmDcbaIWjvSrcaUQlzNWPW77Bi9oV2d4k4sowKz20LerGwkmCTENbAim
         Hbux7jOh4R/iO1FhDkk60mSjK0lXIG41s4E1tZgF86NMV52gmqq3jdHNwVum1oqHApZl
         0bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771748748; x=1772353548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a11r24azpG23OigxKQeh9aCNn9Oh9JrpgbH2uwSs3VU=;
        b=pSQsIYdMWQlrK4EPb7CI/SQSOWArZf2RlItHjiHY9Wi3SmdWJEwWGMwlxoW8dBtYo1
         s9fNk3BnmixQUA0jh+pl+KZXB4CjCYkbBiWQy8Nx/dy6o/LjvOanN6yvMj54Af1+XRIV
         pxj689Fvcz0h2U2lvhVXMU2VS9GmzhMP8nsfqPf6RbXqonqLTgI2BtQuAsIOTNkGf7O9
         KFoTg7SFrVB0SGtmnjBQIhqfvg/PnQEXQJJ6IoYoxEgLoY1explWVSjB09NL++P//SPE
         KFIEoltGdj5kXH5TFlME2D0CkWfIGv9dOhYUc4gqCWsvgSUYTY/kGfVkPUPb397vc/HO
         ccqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYdle/g/GLIXyvoorYQUijQvBocASdVll5eisH95WXrG3UVUt4eQ/hbHZ5h+UOcDAjx3gz9oFauM8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxdEYR1X183jZkR+m93sQa9pkFWp9memvAjmcmAaDOLJo/ALJIb
	HMa/SJlOlS8pR3UD4ncau4y0Nq2m6AiEAV1CnuyYIKQUPp8ZGqluNFDV
X-Gm-Gg: AZuq6aJhrrEKyQDBb8o/w8Sa844ElxoKf+KuYnSf4xP3lcunS9FzgYyOiAzKSNek4Uw
	99wWVrB9ar0tj+gDhFXwoZVYLXAjh3j5BHtGnoxGxfy6F8xdgGxsjipD1P5wPrZGzF6pVKGSWfr
	NSalrEuYENzgLxBkV9vv4Ne3PjVK2JDJI71x7gt1frni546/API8sayDlx85/da6AaA2RnKJLdQ
	E7eUf+/f4ZgL9lDpJit3NwTIRNw0y/YiDXAa4BIGcVuKr9bbMc/qEK+axPzddDsD9HkMTjngWgh
	rqInG8mOg5ehlcZ280SIaVoXk5BgHVAxZB4imEYFxuQqJQNDzhz3uRq3azuMwb79EuilbBHA0mW
	yVOD1pksZ3asPRLrkBbwa9v9DbRA+vMn2xRwjKBRxV948E7Un3D1Ei/2m97Q3V602gmrEHuZucl
	QU8f609GDhKDn3kJQGfqSSUgpC/JTEXQwE8uQaDnSvI4aTY2/YLubH
X-Received: by 2002:a17:90b:4ad2:b0:354:9bc2:881f with SMTP id 98e67ed59e1d1-358ae8db465mr4271668a91.28.1771748747671;
        Sun, 22 Feb 2026 00:25:47 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d5ca:4782:9e29:6b2c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d8e3dc5sm7105332a91.14.2026.02.22.00.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:25:47 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] selftests/sched_ext: Fix unused-result warning for read()
Date: Sun, 22 Feb 2026 16:25:22 +0800
Message-ID: <20260222082522.1173859-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aZoJgm2FS2MPvqyO@gpd4>
References: <aZoJgm2FS2MPvqyO@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read() call in run_test() triggers a warn_unused_result compiler
warning, which breaks the build under -Werror.

Check the return value of read() and exit the child process on failure to
satisfy the compiler and handle pipe read errors.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
v2: - Clarify error handling in commit message (Andrea Righi)

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

