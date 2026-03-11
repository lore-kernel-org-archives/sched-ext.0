Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C148218AB9
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228856; cv=none; b=nifhgh4MLs5c5opFkZMIbtv9B49KyJ6kTcJLcr00WX74xyfnsXy1IafVYcUtgP0jqIVbyShljU+u5ar5KcBt8oaeYu7P3Aj3OO7upKvPHvbSVV8sXc+PzX/nRBT3T6ULZmgMmHvK02NbC/jKggWDP5QeysutUsWxOszKiFjT6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228856; c=relaxed/simple;
	bh=SrfjDF8a9T0Df5j4DlHL+zstBhlnj32QGRtL4KgUu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe5pchfI4PhnISFMIVeMwwgAjOiaaE8HCdeFIzlmfnL5nwupC0PV5BWXn2tonfPcSQhKYtLf5p2rUKpKTPZFkFkIymWCIfqxPJy5GWuzvB6OzW4oN+WeuaFcCac6v48Shrc4SIT5vxeqyu0wZOSrUSdFwF5Nn583wLsJ1koV8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaUlANnA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaUlANnA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so7114235ad.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773228855; x=1773833655; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48WhMybWUEQW6XMJODMFVw6chPzH3eEqt4cJWKmzEQU=;
        b=FaUlANnA+2P0RkPtqPWvPm0Mu7WZUwl6teoUpf2pq83o7Wd2iugxzLlwSVvR3zNfCG
         YR4EU2Q95Ur67Udka0MNKzb5b9jsyaUgEL8W/BFQWlNw/bk3c8O2yQJy8pMfvZFoQcu5
         hN67fguMKDu6PXjwMGDPSXsPfNTEMiebvTvUSkiKsUbooelnWtTjYZ6cH1hGleFvLflb
         joqy8mmgJyVD5In45YOrlVgqHXL0CAVq+xZqV9NNE3G27HjzNPfGZvhNpDJVeHWwl6t8
         nMf+XzIp4cYh5c8HsIBiru/NlVAOHdixox1ty56OZ174zG9oCOhonfa0gg8014tmpz2G
         iiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773228855; x=1773833655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48WhMybWUEQW6XMJODMFVw6chPzH3eEqt4cJWKmzEQU=;
        b=gKY60rCS4EWJCpAKOqaqJ6636RZ8kyuQIJVXotGMPZuC1w9sxzIFKR5CQCqhe9kYf8
         OAUUdxrhu+WOmadWyQvTjVZ3Otcjy4JjqcyNzp5DHX3tNFl2nQAHh1K4+psaAYk5rMNf
         CsqephZ6FdJJuRFOvQT6EnzAGBnFUGajt1nivFOJh7Sg/JDDLok4mKIJch7Un2P3UIy/
         vPLb3g6RT7ENwj1JTrHNZ7KxtK8Ql7TOguywyCKLQSoNTESGgHDa5IFKaMZ6VcEvxY0H
         zQfQk1tGP1BhhMduZkYM+zshVQnpVyMI/n7UX0k0BkIPG1BgosEfC2OKuaGWiAg9HE9i
         z5ZA==
X-Gm-Message-State: AOJu0Yxew73X3gTO0POBEccJghRcysI1uuLghYW7caywYSVO/dkYlwK/
	NhopZWzoiXCA57JCVm8tUnHMVZaSWeqgShJM+Jhcu2CpXYH3zM9d/lndif187YDF
X-Gm-Gg: ATEYQzwbRhgUCy31k9TCdkdx1b8RBrgH2ErnGx71fL58ecUaTx4hcpjwDy2hmJgHEpV
	Km6ZYtXK3LJeEo0BECjqDX+UbtFXnOkZ+P+xXmcLVkHEdGRMA4HlIVYcRysFnjQy07vnfQgUPxe
	KNmnIv5DxgxondV7PUJ0wTZfhukoeW26gZqDuh5iWU1XMkk2ZVwmtCK5sWYWT3cmTQ4MlVAUPYl
	ipzi4LUPCQwtg9bTdwx66duv6pajUd1MblxQdsfMmbzUJA6mRx2A8bZ5QaxQac+1Au4HOucNewr
	iz99uzjvl1UWZqyU5+ue4mLhzOhuO7Rg7aP4gfpi+o9kj/3NUF79hqFgYuZxTAB0PKVOpWbTVHL
	qx7APs+Xs4IeoKWIol3j/NwS/ekvmKeYFhD8/J8jhigQMNaChrp6J71R/UnVmzZCrgjo0Zff7HX
	g4S2zGgwVxTGGwMuM8PAloq4R2dUzinZw48AbIvj3Biu023pMhPaXC
X-Received: by 2002:a17:903:1a0c:b0:2a7:c188:bd1b with SMTP id d9443c01a7336-2aeaecfbf23mr20572245ad.25.1773228854672;
        Wed, 11 Mar 2026 04:34:14 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:e341:b739:1bd5:7ceb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm21416055ad.4.2026.03.11.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:34:14 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2] sched_ext: Fix incomplete help text usage strings
Date: Wed, 11 Mar 2026 19:34:07 +0800
Message-ID: <20260311113407.451739-1-yphbchou0911@gmail.com>
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
- scx_qmap: add missing [-S] and [-H]
- scx_userland: add missing [-v]
- scx_sdt: remove [-f] which no longer exists
- runner.c: add missing [-s], [-l], [-q]; drop [-h] which none of the
  other sched_ext tools list in their usage lines

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- scx_qmap: add missing [-H] to usage (Tejun)
- runner.c: note dropping [-h] (Tejun)
- Link to v1 : https://lore.kernel.org/r/20260310173439.3032814-1-yphbchou0911@gmail.com/

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
index 9252037284d3..5916bbe0d77f 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-v]\n"
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

