Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0451632DD
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616588; cv=none; b=tGrWFWe8AwTw+PyU+F82adWnSWD4u3QpMuWrF2jQF7FMb1JQQqCGEbEVqbM9oO7pocsL2tNnL0C2ZUa2+Q0fatiWC7iBH5d4Jhf0F3l0zrBiAY9JjyCdCq167L4Rz/h8AtA6q1X+7LVUtU/bd7rGWK6s7zRO8PLFT9RhJ+3V4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616588; c=relaxed/simple;
	bh=r3OL4BICCjtGwFo3R9sqS2HeZS47jWGgkMjnEh6KZ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAYrHdgtYaQqZo+FrK+OLYozvDyA6MPece2/B7I/w03uYKWkS2584+4bLXQPTCOmZro95lJALUEdK8laqeCoJqBoUIJGj6h4Zjw56X1zJcTuGRLbS+6wPNjUIblqGr1gWptz/KqrtMzQM8xh1XpLFfdpl4tziyrbVoPeSl77BW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG11Oy9o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG11Oy9o"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fdac394so21263235ad.3
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616586; x=1777221386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye5nElVj3YknKsdiMJqP+E3AWo7oswtZe9nb9fgPhjQ=;
        b=SG11Oy9o96MwU6uToG2LNlsGeVwa1RSY0dSVaKtcRmQrYqf7BojDScwDTwzzmiHKZh
         oiw0R/Li/+zpDKX5nwph1QeUvoUneCtF1wDNf9OwWs1Bk9ky/mxQR6M4bMWtugE5wo7n
         bjgDo25bLLHGUhAdSzeG+UpcfVc7dZvEP0nVjlkYdI51nsungqVc48n/7pElndFCJFAk
         c6fPgxgao3+7ewTCV1rmUp3gv9uc/BcUXVdJFg6af/bD7nZprJelZWJt4LbZH33T7czn
         1abZ6a+KTB2KNFLoJNQ65VpjnsrGHttMux2Ve1vSutEZsehjC1d7GNfg17cXjtYn41tb
         G8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616586; x=1777221386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye5nElVj3YknKsdiMJqP+E3AWo7oswtZe9nb9fgPhjQ=;
        b=ozYce79WpcRFMs9E2hXOc3CnJrbN2kV5PJebXGJ9DCdKJVX+o+P2xjuQ2XGCA3MyBe
         mrGz+QSmxDPgD0f3qX0ZtbkEet1Am4w4qexiagnD0Jn1ef4IyJ3nCtrvRELdJyy9QBlJ
         6CFpyEYuRSDyRQ7VS4e3T6r4oJimZ2MCJ320HTB4EwsSzE3XxOTyFG+ugyfDzwBB3G1i
         Cyz9ybUglqKjO32lll8nXiYgUlOH/gO0tEN0nmjW267QLyPESpTKCkKNbdJ0Ms9WkRjE
         rjr5xtXLPK1sPYyyXStqzTTuIgbyD64+69UasjZW6MGcH+iQ0AQ8+gt5vhIOeXZCXUcZ
         Vj6Q==
X-Gm-Message-State: AOJu0YwJW8epUOF3/G4jWHpa63KSSnHsGsLq7R9kM6B2c/PW1ICkTFvi
	jERsINfzyLmAjpwxkvj4Lo938B+Kce68Bc7XKtfjlT9Mp+mtKfE0WYqBu2F7fQ==
X-Gm-Gg: AeBDieuJYQI+UZ6E1Gt4Uw/XRzQ9qchDQ1xZlecEmUBOknsuFBmFsq+CVIOMbd/gp6A
	k7EOOK81CDZXtb1wfcZzWcbKk6egn7/VnJ0wKsCKDLqHpUTXEPHEdQTMJwdXFjqwT+A0UYxBbC6
	EzHfzMvn7ueFpqFMRSRWdO4f5sPL44UyfGOAxGS2PAcgaSWvNDPX+r6fDZJ3Mz01MOT6LiIHxcE
	DO88xiu0D+rYBocKU+AcT9Dt9KK0LymY6pqtUx05ekvN8+HuEkUOOnVKI5ToFefje20cEeFJ09A
	/t4nFCPe3IEl6qs44dijm67irnRZtHG0XsXWmXWQd4oBcP5N+Dc3jlNNnv+7sgVn7iMBSVbCLqt
	iGj3eO2Kba5w7NBseDo05ixPpsUoztu6vzzHNxc8go7mTD64U7PLPMGXf18rPbd60diAtBtkriX
	uCZaS45a56ygevbBmqESzWdVDb4MnV3mSk6Wn6M5/5TDxy9ByzzGYYKOUBRLhzs7M=
X-Received: by 2002:a17:903:3585:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2b5fa013092mr123747155ad.39.1776616586006;
        Sun, 19 Apr 2026 09:36:26 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:2604:2a99:5447:dfea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab29398sm78652005ad.66.2026.04.19.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:36:25 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: Remove dead -d option in scx_flatcg
Date: Mon, 20 Apr 2026 00:36:13 +0800
Message-ID: <20260419163619.254122-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -d option was non-functional, only toggling a variable that was
echoed in the status line but never used to dump the cgroup hierarchy.
Remove the option to avoid documenting dead code as a feature.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Remove dead -d option, since this is non-functional (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260418092247.1541377-1-yphbchou0911@gmail.com/

 tools/sched_ext/scx_flatcg.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index d865c381589b..de2bef86d64d 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -130,7 +130,6 @@ int main(int argc, char **argv)
 	struct scx_flatcg *skel;
 	struct bpf_link *link;
 	struct timespec intv_ts = { .tv_sec = 2, .tv_nsec = 0 };
-	bool dump_cgrps = false;
 	__u64 last_cpu_sum = 0, last_cpu_idle = 0;
 	__u64 last_stats[FCG_NR_STATS] = {};
 	unsigned long seq = 0;
@@ -148,7 +147,7 @@ int main(int argc, char **argv)
 	assert(skel->rodata->nr_cpus > 0);
 	skel->rodata->cgrp_slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
-	while ((opt = getopt(argc, argv, "s:i:dfvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:i:fvh")) != -1) {
 		double v;
 
 		switch (opt) {
@@ -161,9 +160,6 @@ int main(int argc, char **argv)
 			intv_ts.tv_sec = v;
 			intv_ts.tv_nsec = (v - (float)intv_ts.tv_sec) * 1000000000;
 			break;
-		case 'd':
-			dump_cgrps = true;
-			break;
 		case 'f':
 			skel->rodata->fifo_sched = true;
 			break;
@@ -177,10 +173,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("slice=%.1lfms intv=%.1lfs dump_cgrps=%d",
+	printf("slice=%.1lfms intv=%.1lfs",
 	       (double)skel->rodata->cgrp_slice_ns / 1000000.0,
-	       (double)intv_ts.tv_sec + (double)intv_ts.tv_nsec / 1000000000.0,
-	       dump_cgrps);
+	       (double)intv_ts.tv_sec + (double)intv_ts.tv_nsec / 1000000000.0);
+
 
 	SCX_OPS_LOAD(skel, flatcg_ops, scx_flatcg, uei);
 	link = SCX_OPS_ATTACH(skel, flatcg_ops, scx_flatcg);
-- 
2.48.1

