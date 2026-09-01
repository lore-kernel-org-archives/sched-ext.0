Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB130D419
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230477; cv=none; b=neQcEkOCo/XD6jW5S0mL+P5RoFU9tNqM1doJ9LqIbfhKW4L0QJgRfVdWqoF7IVLJUMhJiZuZs3Bz7rXfhZkBnFajKygc0a1YwpwwYXm+bcOuySrD2gpeja/jac/Ty5q5D6M7ETfKbotFrHoULSVrwBv379ExTWwDJ9LsJxIq0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230477; c=relaxed/simple;
	bh=+g8JFj6bSuPhOwWMaBi1S77p3N0JoJc+KMCCgtIXAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqoBe2DZePrPRlxOsDPAxzua5IYLNZOYOZ8fg+wXq1WbL8MWjHng5AunrMOQVZumjOkpZrXsK8rmtYlg2h8VIf/G9+x9eU1A1COYJQLETf/eD5gzfbpssRtfDnnnLUq2tlZtOg7+L9+JNnLOIp8b8e3HzaV3YlOc7m2TWnwKKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LfvTh0FN; arc=none smtp.client-ip=95.215.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LfvTh0FN"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+g8JFj6bSuPhOwWMaBi1S77p3N0JoJc+KMCCgtIXAqg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788230461; v=1; x=1788835261;
 b=LfvTh0FN43rOVOo09URUo19lOKDNohwxrxEfLNJFn9kiQccjQ5VNlklzE17m9oT7hi85bIIp
 GWqEiFVhoa792eTXaz+4iHRjsXY8hbCC+G0rxSdqzJSrnIQjxgCA0JG60LTTATrj7FdN7NTTrSC
 jKzvBVuGxQM9RbBmAzDmnBMw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 04d6f9c65dfb2da7;
	Tue, 01 Sep 2026 02:41:01 +0000
X-Mizu-Trace-ID: 04d6f9c65dfb2da7
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe
Date: Tue,  1 Sep 2026 10:40:38 +0800
Message-ID: <20260901024038.730424-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901024038.730424-1-cui.tao@linux.dev>
References: <20260901024038.730424-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

cgv_node_less() compares cvtimes with a plain <, which breaks once
cvtime wraps. A weight-1 cgroup in a hierarchy summing to 10000
advances cvtime at up to 10000x wall time, so 2^64 ns of cvtime is
weeks of continuous saturation away -- unlikely but reachable on a
long-running host. At the wrap instant the plain comparison puts the
wrapped node behind everything else permanently.

Compare with (s64)(a - b) < 0 instead, as CFS does for vruntime. A
cyclic comparison is valid as an rbtree comparator only because
cgrp_cap_budget() clamps every node to within max_budget behind
cvtime_now, so any two nodes are far less than 2^63 apart and the
cyclic order agrees with the true order.

Compile-tested and smoke-tested in a VM: weight distribution and
dispatch unaffected.

Fixes: 7b742aa2c2c9 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.dev
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 454ebb820c5e..be03b409db5e 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -144,7 +144,8 @@ static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 	cgc_a = container_of(a, struct cgv_node, rb_node);
 	cgc_b = container_of(b, struct cgv_node, rb_node);
 
-	return cgc_a->cvtime < cgc_b->cvtime;
+	/* wrap-safe: cap_budget keeps nodes within 2^63 of each other */
+	return (s64)(cgc_a->cvtime - cgc_b->cvtime) < 0;
 }
 
 static struct fcg_cpu_ctx *find_cpu_ctx(void)
-- 
2.43.0

