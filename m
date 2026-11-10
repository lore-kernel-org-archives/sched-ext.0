Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315070;
	b=WHD+vMHnmQhLjdRY+GtYObl7r6Ieh0mBb0Zsruw6PCF+DrZn6zZyJtt6PgyvOb3tBTwT
	 5ZDSK92zG5sOUPGOzbLZoXjgjmWl9G2yWJQDC6gJvtHsaLLspzipWdRSiCyOp7LQC6xuH
	 cz7PqRVazJD+18SGkbWTe/QSPQwaKiEPeVpmgsc/D6VpuaUu754opd3SeFYyL7hhe3nU0
	 03JnFB+jamSS8ylRgK6SAlgLRwWvuRmpqQ1iGIQEqYOF8D+7IjkAvsN9jwwqUhASJJK5C
	 0TIzDHLy08T3ItT3iIxSQcQgBxcEkUOEmJQR7MOfkPuNsJ+RTA2pFeVOjKEm6HA9YBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315070;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uiX2+KfbHdVEaimIsqCTOjf8NSRl8J5NyXmT1fSHCP4=;
	b=3gpb9+EFsFlC19JX93grniq8j+0levFUShXuYlJ9xxGmoOGHNujUrDdy6zMPW8w3w5yf
	 BPIneAApAkmYmYNfNp9HWm1nO8w6hheUAc7CXCeMqcuLJU1IuU6bQgmX7i3j/Uia5/NsI
	 VJSiy7/o5KAa/D0k9gGIDcBqj7QuFHkS3kkXUkqHxKnzjIXFPfXXgUFDLQxvsM/bwULnG
	 CVv9ZMfOH31tfdwdQDFA28AKSA+SBewQ+FtPI5b/CdfYz/Dd2UQizm4rsK0rjsKYyYLBQ
	 i3ae2GvGHUrVVvWEs4FyC5jCfoTINkbDulKPTblkM8cWbYqlE1gvQN3LIdIJGbIFnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LxAXxpMW;
	arc=none smtp.remote-ip=91.218.175.136
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B360A2609
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0B360A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LxAXxpMW
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZZIvINl33gHb4CRuKTL8hmDAGvZ37dC3WvaTtAr/R6c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315067; v=1; x=1794919867;
 b=LxAXxpMWIPDPvka+wv4RqEo4c7SMasgwW1xzSDKCZPJcajKfxUqXdfrfEfZHjEuYxupEZX1N
 6p2fg7nfZPRsoolIsUto+0xsV7fye91wRngSYdqP2ohFUZJtDgDlOgFZ9Lv54pYK+Zb4TBS7qyj
 AcH+ijkIWRJwBvwPislEEtZ0=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e07a28e4e753e370;
	Tue, 10 Nov 2026 12:51:07 +0000
X-Mizu-Trace-ID: e07a28e4e753e370
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	devnexen@gmail.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	yphbchou0911@gmail.com,
	mingo@redhat.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 4/9] tools/sched_ext: scx_pair: Don't attach after an interrupted initialization
Date: Tue, 10 Nov 2026 20:49:56 +0800
Message-ID: <20261110125001.4167503-5-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The cgrp_q_arr initialization loop checks exit_req and breaks early so
that Ctrl-C doesn't make the user wait through all MAX_CGRPS iterations
- but the break falls straight into SCX_OPS_ATTACH(). Attaching with
part of the inner queue maps missing lets ops.cgroup_init() hand out
slots for cgroups whose inner map was never created, and the first task
in such a cgroup aborts the scheduler with an scx_bpf_error(). On a busy
system the 4096-iteration loop takes long enough that hitting it with
Ctrl-C is likely, so the intended responsive interrupt turns into a
scheduler crash dump.

Exit cleanly when interrupted mid-initialization instead of attaching.

Fixes: f0262b102c7c ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_pair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
index 00f595b58f97..35c8a1a07f56 100644
--- a/tools/sched_ext/scx_pair.c
+++ b/tools/sched_ext/scx_pair.c
@@ -161,8 +161,17 @@ int main(int argc, char **argv)
 	printf("\n");
 
 	/*
-	 * Fully initialized, attach and run.
+	 * Fully initialized, attach and run. An interrupt during the
+	 * initialization loop leaves the tail of cgrp_q_arr without inner
+	 * maps; attaching in that state lets ops.cgroup_init() hand out
+	 * uninitialized slots and abort the scheduler on the first cgroup
+	 * task.
 	 */
+	if (exit_req) {
+		scx_pair__destroy(skel);
+		return 1;
+	}
+
 	link = SCX_OPS_ATTACH(skel, pair_ops, scx_pair);
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
