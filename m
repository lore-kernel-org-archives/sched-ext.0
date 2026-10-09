Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534C4DE70C
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553292; cv=none; b=LnDD2vgE/ZcVpK6Wlr7bk3h5CQIC95YiVH9TwP1TEoWAsQCzdSuJrP2WtxUXK5++jw4b9KECuktGWwMw5TRTq2jGWTf/8OEWFLpuhqpM7DLRc2MYclyexZcTWWA0u1Tlhp0e2rAiyBdf7lno7qBYO5JwpzeIXI2Rds++YsbRZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553292; c=relaxed/simple;
	bh=m+ORY8hxGz5aNNUnB+kGMOvsrd080MWyMLTWuvKxy9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx3L3ypbTnnWbWZkRHefgtx1sVpQMq4mYA7FYWUxbHoMr+pV/BxJPiekuK6LoNMfwOqJHjrC0H7vHsQsSF7yjsInNKWSiPK7u57NDuPjKpak88XjzYWkQWL/ngL4+z6G/W2il7+a++ZsbkAMqgKHxnh/q7RzrYY4ZvMhTZgSq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvqjE2kW; arc=none smtp.client-ip=95.215.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvqjE2kW"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=m+ORY8hxGz5aNNUnB+kGMOvsrd080MWyMLTWuvKxy9c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553286; v=1; x=1792158086;
 b=MvqjE2kWYA79VcbFHWxJQBllc90EbRbcXb92Lb/jgOQTzMK2eeZxv5QZlGSXAYOQOMSfYYt7
 u8m0DF+NWCY1KBDyX/kB/DRGXI5WCD04QwJrx6WOHfySTCUbTmnSEe8Ipqe9KLTR7ptjkF33drc
 +7sKNLjzLMHkkpbElQ/n6G5c=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e9362a4655918920;
	Fri, 09 Oct 2026 13:41:25 +0000
X-Mizu-Trace-ID: e9362a4655918920
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/5] selftests/sched_ext: Fix reload_loop error-path use-after-free
Date: Fri,  9 Oct 2026 21:41:00 +0800
Message-ID: <20261009134104.296891-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134104.296891-1-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
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
index 49297b83d748..ecff86f59e6c 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -53,7 +53,11 @@ static enum scx_test_status run(void *ctx)
 	SCX_FAIL_IF(err, "Failed to create thread 0");
 
 	err = pthread_create(&threads[1], NULL, do_reload_loop, NULL);
-	SCX_FAIL_IF(err, "Failed to create thread 1");
+	if (err) {
+		force_exit = true;
+		pthread_join(threads[0], NULL);
+		SCX_FAIL_IF(err, "Failed to create thread 1");
+	}
 
 	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
 	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
-- 
2.53.0

