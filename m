Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489038;
	b=W2U/znI/ocNBbpusl0h3fh2sNkOA+jT7WM7X2Y8Bf2ahbi9L356EvV6+pFfxrXqs1TxY
	 62baSCo/ed1//Xn6rXO+b2OqfP2Ir0W3uSYZsr5ucFIoLjsAd7BxTjgZu4sDlhjFED0Kf
	 oVHfnabhV2HNSaivduWymfWr8gJi57J+H+NzfWvMp+LgB0QLaP7cxZK+fzO2pwFWHuvcO
	 vrc+pXtE/5zbo3L88QKngMABmloo7ISPTFI62bctoWwZMeDdmFB7ZSFrQKSS/69Wy+Uh9
	 HaITvjw4zNw/MlzkwPHnxS9F6I8ug2PjD6AmVtSCfimZbucKYFKQnqSAtWPif7Lh8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489038;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CpuKkXH89DE72g3q3A2BBjC4W8j4PRXj24oxWP7atUI=;
	b=z0ukzKw/lVimkKrSJ9zuDIeTg/uqvOo+Vgl7Hum9OpEQyMppOTZy/IAchA+KqTygtG84
	 aiTW+/3LNnb0Iv72aWgcOODLoQB1wbHn+VA9hMcGkrGIlC5BLFjAt1F2poazS2nYOYq+0
	 bUq7v6dVaa4dS6tE0WkoY6gomcztmdwCUA0zo+n+IOnUgsFnOfitBj/HLbbpzcJGgE6zd
	 qe9v1shTONk8fjuM9Qi1HwiiXeVOq2fu3+ctC8c4vgnDEz5dgN5cxdoBWmCQ4NR3I2E8q
	 A+PANVyssBRLPml05/QlGhpT2kwsXAmRLnhWiJYzCWmHpG2h+nZFwQ7hUEI5qYFjnQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MPp9ma1+;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF4606A882
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 13:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BF4606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MPp9ma1+
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=FR3xtWrOv3CbYRT4VvRu+Yy8kCQGznQLHhChKo1P2Dc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489036; v=1; x=1795093836;
 b=MPp9ma1+69EGc5SS0xzpV9Qcfse/6zWaQhbiPa4c3rKsszYw3iM2wbQqIAb43slvtuj7Lk2h
 IJEkmCW+fsXceR5drcL3Sre8TvCceFyy659u25xDQkbGlA3QjsTWNrneC0NOgQQ0wzcDX0a2bTz
 hJhByqnNTylZcpbwRO0y/YiI=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d1fb0a55dd6491ca;
	Thu, 12 Nov 2026 13:10:29 +0000
X-Mizu-Trace-ID: d1fb0a55dd6491ca
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 3/6] sched_ext: Return -EBUSY from a pre-init scx_bpf_sub_caps() read
Date: Thu, 12 Nov 2026 21:09:31 +0800
Message-ID: <20261112130934.563321-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
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

scx_bpf_sub_caps() flags the scheduler for exit when the target's caps
storage isn't up yet. But the guard's own comment names a legitimate
way to get there: a scheduler reading its own caps from
ops.init_cids(), which runs before scx_alloc_pshards() publishes the
storage. An init_cids() implementation that starts by querying its
caps, a reasonable thing to do, kills the scheduler it is still
initializing.

Return -EBUSY instead: the caller sees a retryable "not ready yet"
and the comment's expected scenario stays survivable. This mirrors
how the cid path already handles the same class of pre-init window:
reads before the tables are published test the table pointer and
return -EINVAL instead of killing the scheduler.

Fixes: 86094b95efcf ("sched_ext: Add per-shard cap delegation for sub-schedulers")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/sub.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d2da4d2322f8..55e637e7a54a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -3081,8 +3081,10 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
  * child - the literal granted set. A sched can read only itself or a direct
  * child.
  *
- * Return 0, -ENODEV if @cgroup_id names no direct child, or -EINVAL on bad
- * inputs.
+ * Return 0, -ENODEV if @cgroup_id names no direct child or the caller has
+ * no scheduler, -EINVAL on bad inputs, -EOPNOTSUPP on the cpu form, or
+ * -EBUSY if the target's caps storage is not up yet (expected from a
+ * self-read in ops.init_cids()).
  */
 __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out__arena,
 				 const struct bpf_prog_aux *aux)
@@ -3124,15 +3126,14 @@ __bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out_
 
 	/*
 	 * The target's caps storage may not be set up yet (e.g. a self-read
-	 * during ops.init_cids()). Pairs with the publish in
-	 * scx_alloc_pshards(): a non-NULL pshard has every element set and the
-	 * acquire also orders the cid table reads below against it.
+	 * during ops.init_cids()); return -EBUSY instead of aborting the
+	 * scheduler. Pairs with the publish in scx_alloc_pshards(): a
+	 * non-NULL pshard has every element set and the acquire also orders
+	 * the cid table reads below against it.
 	 */
 	pshard = smp_load_acquire(&target->pshard);
-	if (unlikely(!pshard)) {
-		scx_error(sch, "scx_bpf_sub_caps() called before caps storage is initialized");
-		return -ENODEV;
-	}
+	if (unlikely(!pshard))
+		return -EBUSY;
 
 	ret = scx_cmask_ref_init(sch, out__arena, &ref);
 	if (ret) {
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
