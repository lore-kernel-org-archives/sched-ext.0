Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CD3C9452
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164089; cv=none; b=Y2AerFFBD0Ovh/S/zDdKOi8IUN6CFp24EpXIefwA82BLWLTMp66yjqyjViR+sNwz6lmq8Yo4OTaZXnjVEWQyCi/F76TiH9OFMzK6Tk6nvPuC1EPqZq+7H1/Fz4iLlSUvbdfRkmPDAUHvVcL5UWZJ3zdCw9tbz3ObMQ4O+ylr6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164089; c=relaxed/simple;
	bh=BEnpJbHzZy96A1uuDd7KZ4sS+kZwtaralk9OwUPqGho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYJcBgzjBfLmdHVzG/NyhJaCy+WQcC7OtrvWaZKD86UfAs6tYXUJhhTBkem/TQzF6SMFZIPZI0Zc15VD2zRsYsWY8l99F/IyiMFE3fZzyrkpXwGqadzQ9ST2DCoaMi0ftA7gWPxzlrXgL1LiYqC4lY1aqFjmC0J8+DhMrBS8Ne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8BWmGRh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8BWmGRh"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73a12af63cso2355879a12.0
        for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164087; x=1773768887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNmYccxP9oD0FWkfewonvt6xEz3bMY6fptxTnp4Ll0M=;
        b=E8BWmGRhPaEHkq99I1GovjV7v4MkY0tgis3ENOMaWfECJKqS5Cr9PLxBKL65UsO/Ai
         auYe5/tB8cLffzthn09N0m57WTG66SJpHIJrids63zK7Lz5c1DXJjL4c2xBsvBsN9LQb
         EmYNm98HrGq167bUZLx0705Cnl5n0I7luvTqnAaLZssX6v+QtvnFX7xACwmHOrBWPHN8
         nf61qwurvH0V4ynU0WXHAvLK1TC5rxHW7bP+tr1AN7UJOnDVxVVDjMcwotx8PwZntyG+
         eVMUw7YJNHbGVXVfvHRuX3/TNWHQ+D/A1kmjBE7MSPbn4QQDLDqtsmgOxxwNt4aEhFQW
         S3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164087; x=1773768887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNmYccxP9oD0FWkfewonvt6xEz3bMY6fptxTnp4Ll0M=;
        b=hciHUR8rO6hEJ2qdm9azgIflwaJIGCPBugWla2alOd+NKLdIIJrufOK74HMVSdJg8Z
         VZjrH38ygZh3w9OWdPE4LOiIQr7qTvx00+77Uv+WYFj2jqEfINqR2KXmsi3y/XTotPdk
         rMf604rd1GTGJqUoe6+gWlFkNEtA8GVq0seRSnqJ3Kav6lpYEiJcK4Fdh+ykqWF85OGR
         yKGAozYi0WWoXeindVzYtX8Pk6oHjPtlwYymMsBro3PBcT5aZx2vI7F0jqW5urQeeAq6
         yKBjyNDF/+yOYq581sod/3yk/9U4GdPZh41AF0qLGZ8pCAmOZv4QYqbcZdHHpy99OpAG
         jbUQ==
X-Gm-Message-State: AOJu0YxDAW3F0acULc7P9QNa5o7RH3z5TbztD50gsxgo1umgCv74lG3X
	1Z6s9fQ/bu8DuMPpoWOnMkg6P6SYB3atusN6Srj2gqRzLf7YrHzr9yLNKrdWeGJi
X-Gm-Gg: ATEYQzwMESr+/5f5Ekj/acdiw6U3L2Aj1hEVP54BFT+vg+LiioBGFUlgmLEmYJfcv2b
	7XhM5YWaWHf2Q/EvfKPX6z3mjDhD/tshbmq8Uxzq0ePpDytgfQ/aBvs/yQ36KakvzVwc2urF+Al
	FsHIyh7Z7aNTIC65LsH9juB/mqHNcsEW9laXADXI6wyWyKps/zWApbuO0n7qU+NoebbUoWkYKeU
	m0hpaPBEH/jjh6DwXjZ417FcJr2qLOKGGYKxfyn8NTY9WSQdn88NQq+G/CHPGCIHd0T3ERT8MZX
	H63ppG17Mt55Q6tUEAhrubvKR4XbpHsqnkOAJ+nj1eiygWpE4leAE4pUMZ9LXK7ePl8NR/6DWXj
	aIWU4nkBa4RmofMtCZK6eKj019sIEgRrP6sBnzNkdJA4JHZmQZ5qhkADaMf3Sz2Zj4iYMsrRtc3
	ZfxFlYgqROs88J7MTh1WD27ji1v9tNy71o7zlfRleLzI9eMs0A8KLC
X-Received: by 2002:a05:6a20:d807:b0:398:8546:c3e1 with SMTP id adf61e73a8af0-3988546ca4bmr9694309637.62.1773164087247;
        Tue, 10 Mar 2026 10:34:47 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:e341:b739:1bd5:7ceb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0a70a9sm12234081a12.5.2026.03.10.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:34:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix incomplete help text usage strings
Date: Wed, 11 Mar 2026 01:34:39 +0800
Message-ID: <20260310173439.3032814-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several demo schedulers and the selftest runner had usage strings
that omitted options which are actually supported:

	- scx_central: add missing [-v]
	- scx_pair: add missing [-v]
	- scx_qmap: add missing [-S]
	- scx_userland: add missing [-v]
	- scx_sdt: remove [-f] which no longer exists
	- runner.c: add missing [-s], [-l], [-q]

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_central.c              | 2 +-
 tools/sched_ext/scx_pair.c                 | 2 +-
 tools/sched_ext/scx_qmap.c                 | 2 +-
 tools/sched_ext/scx_sdt.c                  | 2 +-
 tools/sched_ext/scx_userland.c             | 2 +-
 tools/testing/selftests/sched_ext/runner.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 710fa03376e2..fd4c0eaa4326 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-c CPU]\n"
+"Usage: %s [-s SLICE_US] [-c CPU] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -c CPU        Override the central CPU (default: 0)\n"
diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
index 2e509391f3da..61fd86b44c40 100644
--- a/tools/sched_ext/scx_pair.c
+++ b/tools/sched_ext/scx_pair.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-S STRIDE]\n"
+"Usage: %s [-S STRIDE] [-v]\n"
 "\n"
 "  -S STRIDE     Override CPU pair stride (default: nr_cpus_ids / 2)\n"
 "  -v            Print libbpf debug messages\n"
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 9252037284d3..46d96c68dc91 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-M] [-d PID] [-D LEN] [-S] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
diff --git a/tools/sched_ext/scx_sdt.c b/tools/sched_ext/scx_sdt.c
index a36405d8df30..bf664b2d3785 100644
--- a/tools/sched_ext/scx_sdt.c
+++ b/tools/sched_ext/scx_sdt.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "\n"
 "Modified version of scx_simple that demonstrates arena-based data structures.\n"
 "\n"
-"Usage: %s [-f] [-v]\n"
+"Usage: %s [-v]\n"
 "\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
index 3f2aba658b4a..616043c165e6 100644
--- a/tools/sched_ext/scx_userland.c
+++ b/tools/sched_ext/scx_userland.c
@@ -38,7 +38,7 @@ const char help_fmt[] =
 "\n"
 "Try to reduce `sysctl kernel.pid_max` if this program triggers OOMs.\n"
 "\n"
-"Usage: %s [-b BATCH]\n"
+"Usage: %s [-b BATCH] [-v]\n"
 "\n"
 "  -b BATCH      The number of tasks to batch when dispatching (default: 8)\n"
 "  -v            Print libbpf debug messages\n"
diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index 761c21f96404..90043fd74a60 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -18,7 +18,7 @@ const char help_fmt[] =
 "It's required for the testcases to be serial, as only a single host-wide sched_ext\n"
 "scheduler may be loaded at any given time."
 "\n"
-"Usage: %s [-t TEST] [-h]\n"
+"Usage: %s [-t TEST] [-s] [-l] [-q]\n"
 "\n"
 "  -t TEST       Only run tests whose name includes this string\n"
 "  -s            Include print output for skipped tests\n"
-- 
2.48.1

