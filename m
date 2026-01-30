Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC02E7635
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770537; cv=none; b=T7V5B2JShsasAT4TOUOruuMz4BHrpWojXUwVidF0TEnqkQF02g2NtCYFpo5JPk/+8x6BGnTmdGfTQVQ3eQf6/MFyRbD3iDNdPgyvEcy9DMqQbHwnupVgDwC5Nn03FyZ099Qy/ot9Wgy/exdkOL5pB3mSn0TBaf+wkfNVlVS6rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770537; c=relaxed/simple;
	bh=AaPeK0VmM69mFjreiitpUQAEejQt4aFHjIEG/tY27w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9k4CIpgwqn//7teGs6RXG835vEL/bOZ/+nQra4zFSE/3aufwmVfUb4xRmO3mAZMqjJAzxuVJX0TfEfBsAJNrEMDjHU34uj78lTqvuCQzzecyUGw3jTdvnAF22FWEk6TzOLPA7N9gw6aoKuRJ6yDCO7370UTCCAiNa4U+LRg7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+PqE+kI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+PqE+kI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c21417781so1058080a91.3
        for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769770536; x=1770375336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRv3bSPigsfGmDwQFDWnV3Nevq7ozcWAGXJVJ3SjVX4=;
        b=D+PqE+kIY7BUyZKnFdCZcjjHqaWgg9Z3Jav5okMjrev+SaQrKrfARW534c/6QUNDfK
         5nUsfTolCpiFrTy/YW/s3oLgY/pqjh/b3+XcDTwy43ApiRiHvmtGAlBg7fBLYsEmS4dE
         XK0iIm8DgXdatOhBhsq6rYhoamnAUmO5pUYB34dNR67nZjom1efJV6ihkeA9H7yh/CHW
         otJmrLU4jvuxTuGfMJOtQ55QUmpC5EMBmKgtM+5IxJ7ggYL7530RcuC8m9Te7ErHJ5ov
         YmYxDHIUtqVUC4ASvK+Ka5OJryoNGh8jUc/eAPFUjhnpEGuYBH7yLjIC2J99wYXohoYJ
         X9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769770536; x=1770375336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRv3bSPigsfGmDwQFDWnV3Nevq7ozcWAGXJVJ3SjVX4=;
        b=Oe5jkeT8/PTN7PxEnrCGyqctLccLboBBIzSSrVcoZn9JVuWZVn1l8kD30XSJnDBBlm
         LMd/TvznJS+v3LbENTv9UoZ87AAHB36o2ZS8ZtMU+Vs7YIYLJux2hQKarVcxv5fi78q2
         Fw4FeG8tqPVYqp3UAyFUVzO8CjnKOuq/bYz8IP95zGtvGOvYCLsyxn1nP9A0iv3eUaXq
         Dks+zxk1d6/Ppz12B5W+VJ3qzQ8bJ8ZGBiLpeb8zSzTP6vE/hJA4RokUKriDFcnaQQ+x
         sSw//7yJboYc4eJ3S1NzceaXuPs/rqtHwAnd45CpTWjXgKtRKBeyqRgi2NxTB4jgO2iV
         pblA==
X-Gm-Message-State: AOJu0Yw0A5O/a5VLZ5GbuNCiRAiJJuwNDqXMy74KvAeb3IJfmebZm6G9
	Bqne2urylg7MHtFfH73kCVF44Pmd7YU/kU7RTxa3yD07YV9P7fmpIPhR
X-Gm-Gg: AZuq6aJc76Ph3npQO9zxdv4eOxgjwoctjHwKqyAe98CaCLSmT7lEEC3dRrMz7IyXa2v
	FzT89wagWaZpA8FUB6ljqYJdoWxyYsmJZ0fXXrG/ypKJy3iBy2tGOwsk8xBVqSwM954T7tEEzgt
	JHWYueuwb704QWrhclpGO5WkcvSuDnPgSPmfNhftowyU1LrW+CslhnySl7mY79ctbD0peUnFwCh
	EUUIn+2BOgp+stkj11zNhA0cm28Iy/nIK5+jDJKev1e6oVQfi6ddtD08o63AxADX0sOFTKD+htv
	X9+uzvs/rZPXNWRLqKvYrJ7A5Kzcvq+ZGtWQHqnM/fj5e0ueZ5M85zMGLDyY4hEdfHtq+0Snuxb
	cTQcogJU8tbtCpymADILzvBGCzR8jJMEglElj4AiKN5aZTVvh4j9kbzuYOL70QI2VahmTUheJGA
	vsyhutNUiNAjOrlYj2coHaLm8An8ezRZ8hr4oD3XmdUJ5fMBICqLVpUSZhSfTPIw==
X-Received: by 2002:a17:90b:2244:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-3543b33884cmr2530907a91.13.1769770535916;
        Fri, 30 Jan 2026 02:55:35 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d607c98sm663154a91.12.2026.01.30.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:55:35 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com
Subject: [PATCH] tools/sched_ext: Add error logging for dsq creation failures in remaining schedulers
Date: Fri, 30 Jan 2026 18:55:11 +0800
Message-ID: <20260130105511.250947-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_bpf_error() calls when scx_bpf_create_dsq() fails in the remaining
schedulers to improve debuggability:

- scx_simple.bpf.c: simple_init()
- scx_sdt.bpf.c: sdt_init()
- scx_cpu0.bpf.c: cpu0_init()
- scx_flatcg.bpf.c: fcg_init()

This follows the same pattern established in commit 2f8d489897ae
("sched_ext: Add error logging for dsq creation failures") for other
schedulers and ensures consistent error reporting across all schedulers.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/sched_ext/scx_cpu0.bpf.c   | 10 +++++++++-
 tools/sched_ext/scx_flatcg.bpf.c | 10 +++++++++-
 tools/sched_ext/scx_sdt.bpf.c    |  8 +++++++-
 tools/sched_ext/scx_simple.bpf.c | 10 +++++++++-
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_cpu0.bpf.c b/tools/sched_ext/scx_cpu0.bpf.c
index 6326ce598c8e..9b67ab11b04c 100644
--- a/tools/sched_ext/scx_cpu0.bpf.c
+++ b/tools/sched_ext/scx_cpu0.bpf.c
@@ -71,7 +71,15 @@ void BPF_STRUCT_OPS(cpu0_dispatch, s32 cpu, struct task_struct *prev)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(cpu0_init)
 {
-	return scx_bpf_create_dsq(DSQ_CPU0, -1);
+	int ret;
+
+	ret = scx_bpf_create_dsq(DSQ_CPU0, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", DSQ_CPU0, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(cpu0_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index c216480c3ee0..0e785cff0f24 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -929,7 +929,15 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
 {
-	return scx_bpf_create_dsq(FALLBACK_DSQ, -1);
+	int ret;
+
+	ret = scx_bpf_create_dsq(FALLBACK_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", FALLBACK_DSQ, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(fcg_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 48ea18614e28..d965f7d209de 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -691,7 +691,13 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(sdt_init)
 		return ret;
 	}
 
-	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(sdt_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index e6de99dba7db..b456bd7cae77 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -131,7 +131,15 @@ void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
 {
-	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+	int ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
-- 
2.43.0

