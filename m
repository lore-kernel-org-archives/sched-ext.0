Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315104;
	b=zBgpQPdzPEb+q6tTYxcOhoOZLOWKMUz+bxII9Dh0XCsiym4gOcPWl1IVuyOztqJ2g+bF
	 2iGovcRkfzjuSEn/ADAeCqZxCHnuX+n1uSz3bhCrO2y1ohpqr7bj52F7ZXEMBfNJs40XG
	 yK5b4bLUajck/1HyBYsudQXIvHXyR19FYXqJJ7qujEnJbo9vTBiky+BievWy2+NNMbhX4
	 9cdbM/LYDldoOVh0W3TT0aNUyc5dy5uaQdKQ8FUs9wEVFgcbYFOqxon5gdRiGpKCFJqao
	 KCynh8uPeGDomI6tdtpXobHyQYPta7zPncUQ8F9F2O9RSXe1KtBevhBzvbSfZvQvIXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315104;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VpMjX1ZlWeKbqLlUjJa7WcR6waZGO36Cz4JcaOxa92k=;
	b=4kf5SdBZkppJ8bLl/RWkWpLD3FUpcASvHWYs2dojQ9quvqxKcH+Sht2y25F4K3On2KOF
	 yK25WHqebVx2m+TpszDONqtZC4k7DNOw6+9anWwsnUq9lPUER6aaqPLrjbyGa1MY++0cU
	 mvv3HsqmBn/CYSAdgSNS3Y+qBpSFKuGMO5TJ59BxrSCkMjCAgUyY0TYEhvIVRPnSEaxB3
	 JXq2oeOlpFOUL0GW6PtorXqeclRm/gIjYyiiYOU3gJBJhYyru7LXYbF4+hlbRXvkHbjxv
	 VWqynFD+bMx5GU5SQOttDBSX1Jz45afwKBoje0c7EYb1qxo/OApL3P5Jd8TqxkpR4CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jvy4Uqg+;
	arc=none smtp.remote-ip=95.215.58.170
Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282260A2616
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1282260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jvy4Uqg+
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Al1wsyj6h7fNvYGbVdskQYiEUmtzsBOzsT/z7s2ggFY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315102; v=1; x=1794919902;
 b=Jvy4Uqg+u9aMTo+tNRUG0Dhj4dae70DEFf206+6d24NRqsYMHiMzNfBMCmEgFlF8nCwluqrx
 jq9YoB9yj/Ew+w7LNdi7TyAK4jKWEOcnS66qSDhOpOnE2vYvFxP0gs66Ah9kvmR5E0AO+ZOb6wr
 qaawHxPiYaiJcjDO45qnYVfw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 7d0c9879619f7df7;
	Tue, 10 Nov 2026 12:51:41 +0000
X-Mizu-Trace-ID: 7d0c9879619f7df7
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
Subject: [PATCH 8/9] tools/sched_ext: scx_userland: Check dispatch buffer slots before inserting
Date: Tue, 10 Nov 2026 20:50:00 +0800
Message-ID: <20261110125001.4167503-9-cui.tao@linux.dev>
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

userland_dispatch() pops up to MAX_ENQUEUED_TASKS pids from the
dispatched map and inserts each task into the global DSQ without
consulting scx_bpf_dispatch_nr_slots(). The kernel's dispatch buffer
holds 32 slots against MAX_ENQUEUED_TASKS (4096), so a single
   full dispatch round overflows it long before that many tasks
pile up between dispatch rounds the insert past the buffer limit aborts
the whole scheduler. Every other tools scheduler that loops on
scx_bpf_dsq_insert() (scx_central, scx_qmap) checks the remaining slot
count; scx_userland is the odd one out.

Break out when the buffer is exhausted and leave the remaining tasks
queued for the next dispatch round.

Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_userland.bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_userland.bpf.c
index f29862b89386..0a6daad84528 100644
--- a/tools/sched_ext/scx_userland.bpf.c
+++ b/tools/sched_ext/scx_userland.bpf.c
@@ -233,6 +233,14 @@ void BPF_STRUCT_OPS(userland_dispatch, s32 cpu, struct task_struct *prev)
 		s32 pid;
 		struct task_struct *p;
 
+		/*
+		 * The dispatch buffer is limited. When it runs out, leave the
+		 * remaining tasks queued for the next dispatch round instead
+		 * of inserting past the limit and aborting the scheduler.
+		 */
+		if (!scx_bpf_dispatch_nr_slots())
+			break;
+
 		if (bpf_map_pop_elem(&dispatched, &pid))
 			break;
 
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
