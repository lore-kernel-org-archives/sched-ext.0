Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38616320CD3
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606248; cv=none; b=gLzCvhAGwlowAGzvvVVHgIFa6zlB/1oatF7iC645lGg2gPhgd7mwDazzhcHG8h1cBXPfM8bALIMKssE6Yj0XF/7s97czPAKIiLk8bfLhmhreikhyJ1bHtEqohxLOS3q9dEoH6E7Mt/k+3RtY7yYMI81nsVvMU8KWcYM4O4MATEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606248; c=relaxed/simple;
	bh=0C4nfeUW0cQCoZoBNFWGljDSCVICrQaLdcUQuP9TITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqKxxS2rHNiKXRA2lEqtFsRJEm4ubtmLeQFILAzVPYjhoKxh/IRj5RCJgnn9332fp+v03DVNcZGw69T9JQ4U9gR6nZwGwNnkcgCW5wY9cjBlZOdrDhSTdSCgMadUwAxhoxtFCyDppn0o+9vsoLTG0rprO6UDfMYPEhxY+z8lux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk7Bg65/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk7Bg65/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3091325a91.3
        for <sched-ext@lists.linux.dev>; Tue, 07 Apr 2026 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775606246; x=1776211046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+7kAbpLrwW5IRXSx8ECfVEFFIVvOnJ9d6nm/XFf3uQ=;
        b=Tk7Bg65/ZWoiSScG46WfWxndyli/YmKL/evnysEkQopiu8dJVmferSwk47yGSjaZjn
         TVZ7tN78/BLz/QmLJVuGz1Te3sb44uAEync9w4pYDfPkEbZh82wRG5QSlyhudWmyjEic
         D96nrCJxrs//7qLCJbVmkfjwvGjBAmJrjCMDky6SDMH969EbAV2eawTADh1USpMpxIyA
         8fl2XhquaeWYfQM/6G/FI3WvWGtbVdJqLvUFjZFW2KumycshM6ejTRWksVYZZUiY+YRk
         q9H5b97buoVAh+Q4+YSveegWfpuYOHjfabTGHIbWPvFHaG2sbjPUT0q1ZdDDFb7rlGzf
         F0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775606246; x=1776211046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+7kAbpLrwW5IRXSx8ECfVEFFIVvOnJ9d6nm/XFf3uQ=;
        b=IjQN3/A1W0mLyHAE5+zhEXd0nO/GsZn6CW3ygH99LD7jT/uJtWX/Bl3T2es/g1ygWn
         407wXgbthyAoxbemYwGS1zX47LpxuPwexnkkkZ7aZN35OkC5mnGTO7UVp25CbmwadX9e
         RBSIR/r5Tp9Q3WsYmFob0RdOcu0ELLy0Vidl9xr/MCdEQqe/C0WwOO3aXcONcIyJ0vAa
         UYVt3q/XxJG2Hx50PgGMlzBxj7MwQym2L65pXiVVfed5TwLlB4CJfJ0fDG+wdSJTzP/v
         rFcCJqcueAcleT7Vw1jpifK9Ieyxv+yqdbLvPCCNDXeo5ayfSOTZ862TFjZOmL9fwBG6
         a7yg==
X-Forwarded-Encrypted: i=1; AJvYcCUOGoX9AcD3lkp16FfYJcqP+r3JJILUYPBN1oWJvTQg30iB+bLax0FZ9DdTLNh+T+uqDz9PzB0yD1k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb3GyRSPFQdWARzXRs1+lKmdyekXfoXlRkTh+dnEdnWlzXM12I
	y0iFO/rjedSiy1KuCG+RFCtpgfRZz5t2+YX1ETT8HKn8L9DhigMi9KoL
X-Gm-Gg: AeBDies/v2jAo0mMb6AwTgI+Z1xqTiPx33q3paVzM/nusuw/h8DqHS7+4IrDaUXrsDh
	hMgC+i2WlxjFsGfpuZ2LTuos/1OVZuUIk0cKZ77r7yXCI/xbh36CGY+4T65zsS2F2jAw15fOWNa
	6WLBIPe/FU+s98kzkuz+LgZIRqFYo8oAe8TNb7dsEzYPSe2u8a0nN8wY2E7Z3eV3J5u9aWAz8Bp
	C3JBBgbzZAWVT0eBg54Up3NPRp4h7bqtqk/3+LjFLYaW7osrfz7E7z+LYusyV6IDpJ5s+W9Qynt
	EfqiXON5ta7oTapX9nTFuXGCgtDMZ4UxN3CKJwTQ1MztrgXArPQTFXsNUfcm3ZEwsluL3nouQHX
	13u/1n9Kvw5jOvArSaFwZNRuoeEy9Y88Z+r6uT45o53ZCqm4bfS7Hdmeb7lIc6mj0o2zE5I/Vfm
	AbVQjvmy1TTbbZIVKV8iiK3blsMjOz9VfzCORUsI0HZC1X0K9Ze7ww
X-Received: by 2002:a17:90b:2fc3:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-35de6977523mr17374933a91.17.1775606246448;
        Tue, 07 Apr 2026 16:57:26 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:4c23:8546:f68d:c612])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e360bsm17038466a91.3.2026.04.07.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:57:26 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1] selftests/sched_ext: Improve runner error reporting for invalid arguments
Date: Wed,  8 Apr 2026 07:57:15 +0800
Message-ID: <20260407235715.3770516-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <f5f5e8a710d00c4ea4af4840fd32aad3@kernel.org>
References: <f5f5e8a710d00c4ea4af4840fd32aad3@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report an error for './runner foo' (positional arg instead of -t) and
for './runner -t foo' when the filter matches no tests. Previously both
cases produced no error output.

Pre-scan the test list before the main loop so the error is reported
immediately, avoiding spurious SKIP output from '-s' when no tests
match.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
v2: Pre-scan before the main loop instead of checking testnum after,
    as testnum is also bumped by the print_skipped path. (Tejun Heo)

 tools/testing/selftests/sched_ext/runner.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index d84f71eee049..c264807caa91 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -164,6 +164,26 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (optind < argc) {
+		fprintf(stderr, "Unexpected argument '%s'. Use -t to filter tests.\n",
+			argv[optind]);
+		return 1;
+	}
+
+	if (filter) {
+		for (i = 0; i < __scx_num_tests; i++) {
+			if (!should_skip_test(&__scx_tests[i], filter))
+				break;
+		}
+		if (i == __scx_num_tests) {
+			fprintf(stderr, "No tests matched filter '%s'\n", filter);
+			fprintf(stderr, "Available tests (use -l to list):\n");
+			for (i = 0; i < __scx_num_tests; i++)
+				fprintf(stderr, "  %s\n", __scx_tests[i].name);
+			return 1;
+		}
+	}
+
 	for (i = 0; i < __scx_num_tests; i++) {
 		enum scx_test_status status;
 		struct scx_test *test = &__scx_tests[i];
-- 
2.48.1

