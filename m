Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D99149C6F
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842931; cv=none; b=GDeP0gHJdclip1xpL7sBYqxWtlVQnEFAYOa4TYteh85EI4Mp2Va8IfegUEVQ9to6VwuU60wbVWaJKD/rqFKQ/RqhP9vZHiCunRbXLqspPVeyjsxyrDSWSBVIjpUqp7QyCuQZD23KNg6/OVXrSEZ+TghrAms48BL7HktgnkCdbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842931; c=relaxed/simple;
	bh=kiIUbKm/qO9Fh8fEWlt1rXYaT9Qro8dA+G7qf4CmuqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXSpxR53nZcWBIWDF3YBSt3gtqeyNgRkEwvQww5PIFhvK7Lb70rEUglNEnT2knmqObnKaS7NxJosZwwBxYWvqmYvwMBVK9z8Hl1QP6wAWt+hBXk7EInRM2q4vWdyHu6a4IIzJcahK0rjR6AimRqyOI74y5FyxrSdzhGJWenEztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzjred4V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzjred4V"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04e6a989eso30039815ad.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773842930; x=1774447730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mygKH1Qnqk6rNslpCfRSmZp6tWQQrA5Xs2EF9JGl/Q=;
        b=Yzjred4VQ57F8WCKldHd7W4roml0sWLxtqdMTBJ+GyunXcNrCCuubvBp/S22iYL8I0
         TbjrWoex4brN1uqWTSTHSXlkLYhH836l83tDIrZGEtVuQYAF84g1LtAbv2t7r/KAu5pf
         5Dsn7Qv86Rz+K+fMAeHXEWJZ/fbLN9dI8nCSd4NoWmNl0ONWy33SqENDrr9Y1mdABOGV
         DNVrVf+WL/saF1zrbT28FMDRgkOP1RMu605MewZjiri5ZmVQA97ZDcelO1Tw5PIZZz7C
         mL8wPh0JppZgOkZQJ/BlOKc1mTNRKQ1B7mHbhRi7Ri49vhSzSQSH4vJI3gN1n5Z1g/KZ
         wfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773842930; x=1774447730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mygKH1Qnqk6rNslpCfRSmZp6tWQQrA5Xs2EF9JGl/Q=;
        b=bll+rilvc302Tui28kB0Bhmocn+tRDlXVsvxNAKUv6SOnCVx0KCMExshNlYbyL4CUK
         T6Z4mbIcdo0yaXludjMUr9nYdX+nAMTvDrg2SvcVjcLw7gc2OnnLAJfJS4BXL1tdmnGq
         5aDIRYHYgnPnUDyBcXJKvU86RLi6os8s2HD4w/QroTg2SQ8ICYEPjqeJ7sJmrtKHMSqt
         c3lM23N8U4wMhDTc15xpo6GxdfHjQs2y/Pxd6JywctUBnej2z51hthE6QWol9+nQ0gKG
         5AxCmIUAeru+kY7oGv9241DDL82UlUoZQ/+ZQMi9IfbhRM2+QsvZvp5706l6QdscrM9i
         p0hQ==
X-Gm-Message-State: AOJu0YwA34tA9s+ya/OaQA/qXKkHUnxkLl0A8NoMFa7NnWhqCNn+19Mk
	v2dNt8MyeBrKNDpaKspAqKfnqWutIeSSMsJTxpuXRXxL5kokwSYJJ9eFmKPyWOS4
X-Gm-Gg: ATEYQzxWSkAaQIe4XLTdanTcPiyRgvfSJYkda6ekSUBjA26M2srqEfjRrup5xv2P1j0
	J9CzZFrCvr78ClrjaTusmE2DcQQQm7SsAe/O4EjvVBYAOXW+8wRC4i+MoO/s82E4DNNKTZzMFwB
	MMVPNLzW8LxeQd76oU8pdIzKzGfb8U2t09zFXfgJblSUPrbVllAeAlQvXdKtEs9eZHeyc3Q6Duo
	WLkC6qH9i0pKsjmlKh+MNY9gxNx5UoANwzeNQxVD/5m9+4fap9TTD+wUtvaC+HtR2/u0qXj4ovN
	k7MrOr5cbBg/BeNAlVCOVTVourhO8lNtlwId59x2DHKd+XKcht2U5ZAbRDDbDwd6NWvL5c2UDwA
	42RvD1RKN/IxWiiYpyi2Oz0mxnxUPqMw1hIsL7X8xhdjTt8ir1cVGKQ/vIpPyOVATjp1272wIib
	O219XboRQbxA95IZ8s19+pv7KgXcFMfTbHr/lQK0irDR+krQp57/s6
X-Received: by 2002:a17:902:e5ce:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b06e3e1e0fmr35914335ad.40.1773842929839;
        Wed, 18 Mar 2026 07:08:49 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:780d:fd0e:806a:3569])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e44a42esm28856895ad.33.2026.03.18.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:08:49 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Add error logging for DSQ creation failures
Date: Wed, 18 Mar 2026 22:08:22 +0800
Message-ID: <20260318140839.497706-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_bpf_error() calls to scx_qmap and dequeue selftests to
improve debugging when scx_bpf_create_dsq() fails.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c                  | 4 +++-
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f3587fb709c9..a2412be12763 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -919,8 +919,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	}
 
 	ret = scx_bpf_create_dsq(LOWPRI_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", LOWPRI_DSQ, ret);
 		return ret;
+	}
 
 	timer = bpf_map_lookup_elem(&monitor_timer, &key);
 	if (!timer)
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
index 624e2ccb0688..c7d4fbeeef3d 100644
--- a/tools/testing/selftests/sched_ext/dequeue.bpf.c
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -364,8 +364,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
 	s32 ret;
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
-	if (ret)
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.48.1

