Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB33563CB
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975152; cv=none; b=pvbXPc4sEc2MYb0fO1ztnWg8sa2XGrl6KEQx7l4F8uiP8Kisp6UEZPiI8w1Zmk/MxwqsKpEpVJBL97r5A/oaeFV/9bD1bnimg3KorTdCNp9vBQa7UtCmt12b3hVXinWI7tMAXKjQw8ZM2hoC8U9pJGuomsiZ8SMvv7g6DnlUsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975152; c=relaxed/simple;
	bh=YIrpUC+oeOE4ylHDYX2DLU4ie4KcMcSSo19SJwV6rvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2/fb4r6XaVsj0aJQrP0l2ZZzvCBsSX92CKOHTMr7tHDjoo6sK0Q8G21MWTrIBTX9pOHnpzgBRhud7hFKzoGX52VwzB6cgLPKL5UrGsxgRr/UV9PCMq3PSeksuS2CAjkQ/ri6Qn3GoEqtizP3VaswtTqhcTIzAt5Fk3Nw+/Ra/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rdgASSVQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rdgASSVQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767975148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LpBKJHmZTTL5RnDb67ycBCxAn2yjK2Wyu+bDg+yrQx4=;
	b=rdgASSVQpLvybRHbeMPEglDcUsH1+lMvRcpBSEdpCCjRae+1jrBX6tPPqiZ7kP+ESoHmtP
	KxLNhZzID30t5NSeWU+syQ6qGqJa6V8R7ZMJ9K1uGhw6AJtqpp1vherZ1ITuyseeI4G7Qx
	LNfpSipKggzoL+/XQC3Tu95jN5mRxnA=
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
Subject: [PATCH v3 1/1] sched_ext: Add error logging for dsq creation failures
Date: Sat, 10 Jan 2026 00:12:14 +0800
Message-ID: <20260109161214.94419-1-dongtai.guo@linux.dev>
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
index 2c720e3ecad5..06def9121f39 100644
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
index 8962dd4ace25..ebab55f36e48 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -852,12 +852,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		print_cpus();
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
 		return ret;
+	}
 
 	ret = scx_bpf_create_dsq(HIGHPRI_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", HIGHPRI_DSQ, ret);
 		return ret;
+	}
 
 	timer = bpf_map_lookup_elem(&monitor_timer, &key);
 	if (!timer)
-- 
2.43.0

