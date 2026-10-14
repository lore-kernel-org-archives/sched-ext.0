Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C88309EEC
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983619; cv=none; b=sa2OrNZmEGhY6M1aFZzuEixiu9c4ZNre+ta0MtXaba31ZYr07RGxZpZBlpkkPucAa4idOtFmOcyz0ZM6wt6NT78m+CVgqwqlobC9ba0Tca3Udk5G00TQ+Am5/W0XZGuB7BzrS7vtKWvxJsU+6tBryIeFNdbPrKrOJ0RE/rGG4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983619; c=relaxed/simple;
	bh=5+ZqKg9ntZIY5N3SSLGpmlnXaw4dtAbauVlNRtY8xtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDMJGGmrH2qFgjG6pE4GonvIBzSVJC05XuDfxlapQu0BLg8Yz6wHG/90QpbMFUKCKVX/0iU2dtxWMLg7xPdxD+xgIUWdFph3fGPbZIWjIMQ9+CJi4umNgh01vWWxEFU/p1qSNk+UbWYM9uW3+L/qedQ+W6uvkLH4pHbRrq+BWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXbJsdX4; arc=none smtp.client-ip=95.215.58.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXbJsdX4"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5+ZqKg9ntZIY5N3SSLGpmlnXaw4dtAbauVlNRtY8xtE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983615; v=1; x=1792588415;
 b=kXbJsdX4qQRzo6sWwOAHSXpL20E8OnwDgdtCM0nQ8H4Wbnu1CSJzFWo1iW/LzXRRMvHBHh5y
 2lmOcMa+x0u7YojPuJVrbI2zjiW9yygNOQyY/01aHun6xzeXOf49UKhZZ1yn+rDpdQss+x3Rnud
 EN5LWDaJ9K58Dr9AzfgP3Vuo=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 386999c4809f59f3;
	Wed, 14 Oct 2026 13:13:35 +0000
X-Mizu-Trace-ID: 386999c4809f59f3
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 1/6] selftests/sched_ext: Fix reload_loop error-path use-after-free
Date: Wed, 14 Oct 2026 21:13:20 +0800
Message-ID: <20261014131325.793640-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014131325.793640-1-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

If the second pthread_create() fails, run() returns and the runner
calls cleanup, which destroys the skeleton while the first reload
thread is still running do_reload_loop() and dereferencing its maps -
a use-after-free on the error path.

Set force_exit and join the first thread before failing.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/sched_ext/reload_loop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index 49297b83d748..a00f3964dba0 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -53,7 +53,11 @@ static enum scx_test_status run(void *ctx)
 	SCX_FAIL_IF(err, "Failed to create thread 0");
 
 	err = pthread_create(&threads[1], NULL, do_reload_loop, NULL);
-	SCX_FAIL_IF(err, "Failed to create thread 1");
+	if (err) {
+		force_exit = true;
+		pthread_join(threads[0], NULL);
+		SCX_FAIL("Failed to create thread 1");
+	}
 
 	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
 	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
-- 
2.53.0

