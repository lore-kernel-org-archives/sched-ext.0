Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6E3382D5
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953048; cv=none; b=sUpC4z456ooqGbvjQqYKbEzxHrKX2deaTQtHDPG1AuWV202/85dZtwhiRxgzOREcmVA3V6V9f6O6JTIsn5VY0AtX1x/1BZ8qrpRsWtM/Q+HqPT38EdOBIXatkh5i3UWWad2Az8EJs/D0eNqD+v4nj+J3vbCSC3Nx6prMq0s845Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953048; c=relaxed/simple;
	bh=l64YA/a9pZe0qKlvL1UV6ClN06XKyiPTPfY9bD//eMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2wRcXsc7CxoW6JjcWvJ4ZQzcj9YnsY3620GSmcD6IJ+dMcUa1xVMTtqUDrz2sIjBFN9pf/8IimLUbq4AI5AoTZ0RAIBxYXy6mbqRhHyqOwLBOH7THI+pYu7UpiKT9A3AtJ0wTf4SgZoMcYVXZ5oW7LhR8yWRyCQnlFW5AxA05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j4fL94kD; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j4fL94kD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767953044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+RRfsw1fqdAdkMVTboqMRcK04eAAZUqITHstHUDpOqU=;
	b=j4fL94kDUDR8oNDUyWk3wU8cacMIaVT1KdyEQqVIWztPEVyCXZ+MJUOUH/CiQNJeB36mFg
	8z7vd7ZhtQswtCOChDUyd6gvt3In4SHkzj5N+K4eutfOkJrlgkhtmPVDA6zDRwIZ+BEsue
	Ld7eg7gQNzHaINuZ0ObYxsk0Bxnx4hI=
From: George Guo <dongtai.guo@linux.dev>
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	dongtai.guo@linux.dev,
	etsal@meta.com,
	guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com
Subject: [PATCH v2 1/1] sched_ext: Add error logging for dsq creation failures
Date: Fri,  9 Jan 2026 18:03:58 +0800
Message-ID: <20260109100358.93045-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add scx_bpf_error() calls when scx_bpf_create_dsq() fails in multiple
schedulers to improve debuggability:

- scx_central.bpf.c: central_init()
- scx_flatcg.bpf.c: fcg_cgroup_init() and fcg_init()
- scx_qmap.bpf.c: qmap_init()

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/sched_ext/scx_central.bpf.c | 4 +++-
 tools/sched_ext/scx_flatcg.bpf.c  | 4 +++-
 tools/sched_ext/scx_qmap.bpf.c    | 8 ++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 55df8b798865..1c2376b75b5d 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -301,8 +301,10 @@ int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 	int ret;
 
 	ret = scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
 		return ret;
+	}
 
 	timer = bpf_map_lookup_elem(&central_timer, &key);
 	if (!timer)
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 43126858b8e4..c216480c3ee0 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -842,8 +842,10 @@ int BPF_STRUCT_OPS_SLEEPABLE(fcg_cgroup_init, struct cgroup *cgrp,
 	 * unlikely case that it breaks.
 	 */
 	ret = scx_bpf_create_dsq(cgid, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
 		return ret;
+	}
 
 	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index df21fad0c438..5fdd83769405 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -866,12 +866,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		print_cpus();
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
 		return ret;
+	}
 
 	ret = scx_bpf_create_dsq(HIGHPRI_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
 		return ret;
+	}
 
 	timer = bpf_map_lookup_elem(&monitor_timer, &key);
 	if (!timer)
-- 
2.49.0

