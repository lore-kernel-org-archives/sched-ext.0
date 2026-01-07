Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C62836E
	for <sched-ext@lists.linux.dev>; Wed,  7 Jan 2026 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767343; cv=none; b=iLwgoV4//ntGYrftO3Fcw+dg++mLFPYhvp8Ci6K4zoO75qAyGOh3x7NYjLGcBWsq8ux8aicNBgQDWsxOpR+6bT5NdqnYXJflmJXxaodECzPs5wEQ6y1eupjn+yq8pDMR1o279aq+8gKSRRCxSFueJD69G3lx8/BqlcOpOby8W3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767343; c=relaxed/simple;
	bh=bccEfQZSo2wIz03lmxTzLUXYkJk2mu8JxCkaKrw/Edc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz+fveVplqxmsEnLxmCftMTYT3sc+MPplpd3IQg72Dx5qDl+SN/VyVkRY3bUaivBzf3T5ppUSOUVbkezuo0ltuHakphOyJjrSzEdWZOOcs04/snx749O8eLiZVDoz6B00/nCDGW5K4cY3Jw9qp+BKgHjoipeQckCS5nEetxDSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wxe12LBb; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wxe12LBb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767767338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/oiYJ2Ws2ogCF0FGMb165sNKAEX9DhUjMnSrw8Es4UI=;
	b=Wxe12LBbbtZsc05b6uzAfVGbxgLdQdH6znYB2uhMgMujoCrY1QrAh2tL67tGb5FpHpuBcf
	6yEDyAZPwt+J8ipcyXTIWe6SjqUVlUBS2YXpa2q/1WCQk2r1CLFwIPdHggT6q6ya1jgh8D
	ju7s6fiF0TH1duFYq+kYf0se4JFpSWU=
From: George Guo <dongtai.guo@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 1/1] sched_ext: Add error logging for dsq creation failures
Date: Wed,  7 Jan 2026 14:28:51 +0800
Message-ID: <20260107062851.82471-1-dongtai.guo@linux.dev>
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
- scx_simple.bpf.c: simple_init()

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/sched_ext/scx_central.bpf.c |  4 +++-
 tools/sched_ext/scx_flatcg.bpf.c  | 12 ++++++++++--
 tools/sched_ext/scx_qmap.bpf.c    |  8 ++++++--
 tools/sched_ext/scx_simple.bpf.c  |  8 +++++++-
 4 files changed, 26 insertions(+), 6 deletions(-)

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
index 2c720e3ecad5..f7830e14b9af 100644
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
@@ -927,7 +929,13 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
 {
-	return scx_bpf_create_dsq(FALLBACK_DSQ, -1);
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(FALLBACK_DSQ, -1);
+	if (ret)
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
+
+	return ret;
 }
 
 void BPF_STRUCT_OPS(fcg_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 3072b593f898..16ed8f867ad9 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -852,12 +852,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
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
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index e6de99dba7db..50e4555459de 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -131,7 +131,13 @@ void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
 {
-	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
+
+	return ret;
 }
 
 void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
-- 
2.43.0

