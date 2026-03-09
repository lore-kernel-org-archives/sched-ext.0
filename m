Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E52010EE
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024380; cv=none; b=dQ9Y0M7771RTvMJm/lXxtPq5MJ2ouyMCxAO9WbH+CUptg8qZeHzPpg0D0k3C4C+gCG9j1IDC2gTxUIhXH1lbKC994AgRwhFhtDy5r4IcwGShPygAJfCTRQr9KEBlY4LeZpqLpJnr3F5wjFBkAvWoDvowR4LqPHwSYM5oWfZjuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024380; c=relaxed/simple;
	bh=Sg1D9HjBO3m/odg94MJ84wn+zeMo6wLYIVUrLbdEDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oucrn6cXd9FWu0oYK4mDbxJOM80wnrR+xEDnLOz7UPW2EiFpJMIBdIRx7RQNohbyibXI7iOvUReQ0uDkq9O1Tn1fhRovrfF1YG8p6qGLfqxnWhwpGtW6+6GE5cWboiV0hwp14fCSGg29MHOc+MxTBO+TiR/58a5w3Zv3619SGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOPLUhfj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOPLUhfj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so4429628a91.3
        for <sched-ext@lists.linux.dev>; Sun, 08 Mar 2026 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773024378; x=1773629178; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FyvztfjZ5OoSdXXV3mRbyT+pJ/bhNLbffqVWxVVswQ=;
        b=DOPLUhfjObfddm2MgZGZarN+ON9Sumt9I2D23CrmOh4z/LkDS1FrVSgNkWiNjvJjXg
         w484Ic5m99wR4IinOXbYpf9/BSOkF0fTW4HYetwQn/OD9fpS6sXFSECLxEyl2UpJ2jjK
         IVAVpQa/cshloaUgzxOpVLLElhEMSHrB8PXfqZq+xX30LoKnSTMaV3zD5wqC8UWJQ56s
         meqzYQjO4m7ikeXloPyzUHkjmc2rPLvoDtylMQwdGwyb1wBB2KLIVBreWyICXAIDejjb
         w7xwhOSSwyWSGK25g8d/TY17nEH+YIr5WvhwBGQMIXk0L3+omT0FyDo7pXqqONk+lzeK
         m2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773024378; x=1773629178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FyvztfjZ5OoSdXXV3mRbyT+pJ/bhNLbffqVWxVVswQ=;
        b=S1FneOt731auRcbotQg7P+JxNFd3OR7nhdBnYc3uXI9Hm6Rk841xKWjiWGWupDafGy
         K38Nh9ZTDZ/W+WGe+c/pPTJ9Lx9aZOs3dBcfXo5L//jsLtNPa5wmT8Odnfzj33xnsAqq
         Qn2KJX/LWgi9DgTlgYyoQrYdqBicSWEh6n0wz3e+JU+JwA/XL5NO5zRLdRkktM/oQkLu
         GKNsNQY/D605VNd3uL8glCCBLL0eCvFbR5k2RjSItSKGgNU4JqGFD33e9pLqRxuab6tk
         RgLg1z8vDiX8ttZxxayDzbVMtoYeSq1XcOerGhrRwjPAFxSJCFzc+l6xgt9qcGxCz4vF
         0EcA==
X-Gm-Message-State: AOJu0Yw7DOdhlAQaV7MHNNRA33l3iC9R7ww0Jz+sHHkbU2WLVnY+ldAs
	tclwC3ybE8bOCuUnGrDh0wwnyQDKhfppc3GI+9zEdNzSfJ76v3tWfS0JnEBVqA==
X-Gm-Gg: ATEYQzxkrGAItlptKr2UGMn1RM6C011NwWAuG0krLAzpWNZcgqxZZeJn/yxdlpQAjtS
	nD/UX3AqkZ6wJTFDGhC2VFCiupT6+xd89/qvD51ASARCS9r2Ld8lfwWCUux1zuPToxt3rTt8FhP
	mN6TuLtXNNKFo5Q2n+Eo2dVhUhy/8+nt+RlMWHnOwkjSfQ4ejzsDWqh/T8eShwg9No51az3EsbX
	fP6/lpz4o2r3y4lgs0p3nRiYtsOTQ59OJCbP++U682goYItQk7ZSiJu4aDpOnMW7MkYlUZheyof
	+E33bZsLynuknByX+u7H35vE37h2zoi0lt55xPDuQjCDxegrP73JIpanDXtjyUCJvcAxkoxsHU/
	AoH4lJCUwWsaraIJcJFgnY07B5FbrK3ZlZdwOVjcSgX4s0NDz2egJ3bwXXg4J24vTpEAL5yGJg/
	1xzzE+1ztqa6e70x3qSO6mf0fgnF4SE+FNCcohbfYZzWkJm/5BXJ1GkpXDaYyRLUy3ZMii6nC80
	XF7r8elez49wQ==
X-Received: by 2002:a17:90b:4c09:b0:359:97d3:5c57 with SMTP id 98e67ed59e1d1-359be34986emr8694554a91.19.1773024378509;
        Sun, 08 Mar 2026 19:46:18 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa2fa5sm97986595ad.70.2026.03.08.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 19:46:18 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH v3] sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer
Date: Mon,  9 Mar 2026 10:46:12 +0800
Message-ID: <20260309024612.530874-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306141718.2721073-1-suzhidao@xiaomi.com>
References: <20260306141718.2721073-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_enable() uses double-checked locking to lazily initialize a static
kthread_worker pointer. The fast path reads helper locklessly:

    if (!READ_ONCE(helper)) {          // lockless read -- no helper_mutex

The write side initializes helper under helper_mutex, but previously
used a plain assignment:

        helper = kthread_run_worker(0, "scx_enable_helper");
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 plain write -- KCSAN data race with READ_ONCE() above

Since READ_ONCE() on the fast path and the plain write on the
initialization path access the same variable without a common lock,
they constitute a data race. KCSAN requires that all sides of a
lock-free access use READ_ONCE()/WRITE_ONCE() consistently.

Use a temporary variable to stage the result of kthread_run_worker(),
and only WRITE_ONCE() into helper after confirming the pointer is
valid. This avoids a window where a concurrent caller on the fast path
could observe an ERR pointer via READ_ONCE(helper) before the error
check completes.

Fixes: b06ccbabe250 ("sched_ext: Fix starvation of scx_enable() under fair-class saturation")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
v3: Use a temporary variable to stage kthread_run_worker() result;
    only write to helper after confirming validity, eliminating the
    window where an ERR pointer could be observed via the lockless
    fast path (Tejun Heo)
v2: Add missing Fixes: tag (Andrea Righi)
---
 kernel/sched/ext.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9a1471ad5ae7..63dc7cf1e2a7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5355,13 +5355,14 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (!READ_ONCE(helper)) {
 		mutex_lock(&helper_mutex);
 		if (!helper) {
-			helper = kthread_run_worker(0, "scx_enable_helper");
-			if (IS_ERR_OR_NULL(helper)) {
-				helper = NULL;
+			struct kthread_worker *w =
+				kthread_run_worker(0, "scx_enable_helper");
+			if (IS_ERR_OR_NULL(w)) {
 				mutex_unlock(&helper_mutex);
 				return -ENOMEM;
 			}
-			sched_set_fifo(helper->task);
+			sched_set_fifo(w->task);
+			WRITE_ONCE(helper, w);
 		}
 		mutex_unlock(&helper_mutex);
 	}
-- 
2.43.0

