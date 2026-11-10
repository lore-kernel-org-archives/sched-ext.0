Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315050;
	b=l6CoGDGmZK0zNrqPsgat/osJ8vv6h777aveg7qJjiKOrEWQ1sS3hE3U6swkARSLF1rW9
	 h5vItt6RLik9i18w/NNsOKmtNI20l5uUPyg8gbIFo/1Zi2PK4+umXT73ruTp7vKxxWeRK
	 12PKtcTDf3uIbgza63jycMgWHHtmXqyRZX1akppEg/XjBA5VneeqAWKJZoumyaRxsxtkf
	 /mgjdQ7QEEh5EWgGAjeWUIs+gECiX9h5fozMKhtiDJLRle3w1tgWVxZCUFQqbCmAix5I9
	 hgD6rFWUCNCqamhRO9gIxqsyLXIPaLVuRERQbaN6c/1FwDCcPUDCDW+LiB3IdDY/FBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315050;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MoXBY7jP4//KMMEHW8C36nJPg5ZUiDBZiR2+vsM2zFQ=;
	b=g8CEvXKJb7htVKxZziz+wIYXll1dfsIxfoSAUMiuRKKt3Ip7slRkLya+W9/qVgx6/NOK
	 YX6mnebAatd+tgJptnjUCotk2JQzXWrRHTlhp+leWSwZNP8TZD1NMR08RgxdKzmiMOH86
	 WtijxZeGvVIfJYuBA8JdaAP+72KjkchvDk9//Bupr++jG3tjgp8hYu4KMcG3HS1ULO+QV
	 rdxxoeJm6KAWn+cDsBeLF+i2ByRzEvi/DSN4TwAA6MgeQYCmzJiHlBPYpf18GrUgyX2Dz
	 uLvYEhNVTTPtLRvsokGuab1h45Lu50lqBSiX/FeI1W+gmndvcDVObfVgquoSkcEK9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JOfSgr2z;
	arc=none smtp.remote-ip=91.218.175.117
Received: from mta0.migadu.com (out-117.mta0.migadu.com [91.218.175.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFB606A330
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38EFB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JOfSgr2z
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=nG74Kvi+0FYK1AbhxFJPmegfJsg4ATvaQ+d7OJ0WtK8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315047; v=1; x=1794919847;
 b=JOfSgr2zP4cWKwOKgIM7zFM+qWhKRL2ihindkVWHTKf/gIsyxweoeKOgVa343gcPS2pyqqud
 HcnIjf2Pp1wr7nqCUPPTyX/P7Gc3bNN3x5Prtl90yJ4eF9vjYehWN4xmfyktpJCahF3zTmZrbJu
 BMt/oq0d0A89A75BI0voqQkk=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4f35b2bbf5b7c11c;
	Tue, 10 Nov 2026 12:50:47 +0000
X-Mizu-Trace-ID: 4f35b2bbf5b7c11c
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
Subject: [PATCH 1/9] tools/sched_ext: scx_flatcg: Reset the stats baseline on restart
Date: Tue, 10 Nov 2026 20:49:53 +0800
Message-ID: <20261110125001.4167503-2-cui.tao@linux.dev>
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

last_stats holds the previous accumulator snapshot for the stats
deltas and is initialized before the restart: label. A hotplug
fail-safe reload starts the scheduler with fresh counters while
last_stats still carries the previous generation's snapshots, so the
first stats interval prints u64-underflow garbage.

Reset it together with the rest of the reload state. last_cpu_sum and
last_cpu_idle anchor to /proc/stat which persists across reloads and
are intentionally left alone.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index a223bff3746a..4c3c2cca2b85 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -140,6 +140,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
 restart:
+	memset(last_stats, 0, sizeof(last_stats));
 	optind = 1;
 	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
 
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
