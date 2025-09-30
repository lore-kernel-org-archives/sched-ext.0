Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B17211290
	for <sched-ext@lists.linux.dev>; Tue, 30 Sep 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212672; cv=none; b=aDcck3sQ3Q4vPwAzX9UU50CvaeVOXyZaReKWwF1BdU1+YxC4CrriJyRbXLaY9KWeNdfKYH4XvdTIF5LP+q9fBoRCUFVLyRle7ynAWRNcxQxMn0EUyYe0feSC6HWYcF7U6gbvbZK/vFV6SO5QtJnkRvTOxkTmLW3JgoGMaSKtlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212672; c=relaxed/simple;
	bh=OKtwzObm746UbmyVAjpVwKeRZvohe4n/dLhJxbUjSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d70zOh2s5WZAqT43ZlG7wAIKUh3U9MQ8M8RqZYX7fPQPEsG0SNXXdzFf++u41OyySsxIEPejRtJjAiRqJPFq43SJFWoRIj5S87yOrGfNNRnuUHJGhrkiIKiA5AbBPXIHLer9CyTSQ/yaidfqHnXHq6L03pWSjt9QThqWABjII84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CplzIEqj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CplzIEqj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7835321bc98so2633307b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 29 Sep 2025 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212670; x=1759817470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nR2uIZObkTs1yBjw4Xmy+f8XsVDHniquW/u7nHFG3VE=;
        b=CplzIEqjrlNAn87reM04AWDU5RzYYwvWMPxwxtLONlU84LdRb8cmaYtI2hEjaVGDYp
         vbo5lmdGHiJTYWLuqt3N0fVNEdp0Jhr6ETj7tJrPTGkDlF1q/ifp6sm6NvVHJ4jc7qqJ
         x9vtDHVdKGjxeFaRt/d/LxnU0dvZ+o0mxU/UPS7z8YFfN+74sa9SLSTHYW4rGoRYVf6O
         ltgnXO+8I/nGZ2wvdoQWy9DCkcK26u8NklwS0mNPu5z2jpLXm3C2NrLMI+SMYssHEK6g
         xLdqKipsM0vKmcxZbDtvTNCjq5X+74tSJJCsabTzeJtxqhaP0dDGC7ZMAAr0NhDlh2BZ
         D0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212670; x=1759817470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR2uIZObkTs1yBjw4Xmy+f8XsVDHniquW/u7nHFG3VE=;
        b=PjYO5+fkg8zqrYFCyq6WAuxwNxASJpfTHOpUOfcl9Is0YkQ4Fdsi/DIrQUEWjb5anX
         Fhk6DmQeXkrJPmo2dmScRkO+qS0CPff/AjcfGgO6Ka0iq6dcrhex52A/QREPoEJU1krg
         /v9BDjO4l4Ka0dFMkDYCO7aM9mE6RTgrNXc6rsslbZxD+Ez/heuAwKfjKdyTLDRgCJDY
         3cal1qoC2fuHA/2sNblmu8IoX4V9qQ76TBAj6NRXWROjiE9TMz//SqmycMKU7X7Lk+9v
         SmV+xtiHcjIc9+7DFJiMUe7JUfz0U8fkgt96ZTtF6MdciyFlc4q6n5rhtRG8y4OnoRa5
         +sXw==
X-Gm-Message-State: AOJu0YyNTAc8qUuIAV5kx/+PhTqY12fadEhoJ4M996RK6A6mFAmJzcr2
	XwOrYbUWvqXNIuBz7cSVKo6WU8ZeP6n37M0bKoPrZVNMAarLYutjX76D++YigtSDIjA=
X-Gm-Gg: ASbGncsQufkNahhw84PU1JWBeAqWBTuMsrqFHbh/O7xDRHR/mluAOTwcn2IU+jKxwmW
	pM7rxmDP21jadna5fDTGNNM0osolBTtuaKuIvqq9KRH6TrJLWM0RjER+lTWfchn55eHSikF/C/v
	wp8HSr57C/CmyJ+X/NhDzv1+jenDsk0IIFAyLME5e+MgNAqBEA2gtGzB9ogtrC5m7csxYNPk82R
	WflppALIsZq62VqixFBGycG/gm+/5ks2T61qjuTRWR+eDQhi6+8nny/KV+ZGquuEIE02SJtwlM1
	MFTJqPaWgM76VPFaJfqUy/DMimA2rCAtXcfW1ZEyz1BNX3cGAG4LGFVbFBojpwU97J4mhyffunb
	7Q70s3/Lc5CcNSrv8qSYDFfYv3Dm1NAszZniiUbnvpognp46JiAQ98qGDklFBta3o49gcftOYcn
	+nwqLgkFFI77LyY8nu21VKaaY=
X-Google-Smtp-Source: AGHT+IFj32i97hNN4vZKEtpSEbZ6MFOWNVr26DvcSnKPsixSzW4wCKwPBewPZ1GUjVPfjqycQmXFgg==
X-Received: by 2002:a17:902:f60f:b0:262:661d:eb1d with SMTP id d9443c01a7336-27ed49b301amr218395185ad.1.1759212669862;
        Mon, 29 Sep 2025 23:11:09 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69ab0aesm146964515ad.113.2025.09.29.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 23:11:09 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Date: Tue, 30 Sep 2025 14:10:45 +0800
Message-ID: <20250930061045.743507-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

Implement the missing cgroup_set_idle() callback that was marked as a
TODO. This allows BPF schedulers to be notified when a cgroup's idle
state changes, enabling them to adjust their scheduling behavior
accordingly.

The implementation follows the same pattern as other cgroup callbacks
like cgroup_set_weight() and cgroup_set_bandwidth(). It checks if the
BPF scheduler has implemented the callback and invokes it with the
appropriate parameters.

Fixes a spelling error in the cgroup_set_bandwidth() documentation.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 088ceff38c8a..72bf2ad382fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -688,12 +688,23 @@ struct sched_ext_ops {
 	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
 	 * interpreted in the same fashion and specifies how much @cgrp can
 	 * burst temporarily. The specific control mechanism and thus the
-	 * interpretation of @period_us and burstiness is upto to the BPF
+	 * interpretation of @period_us and burstiness is up to the BPF
 	 * scheduler.
 	 */
 	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
 				     u64 period_us, u64 quota_us, u64 burst_us);
 
+	/**
+	 * @cgroup_set_idle: A cgroup's idle state is being changed
+	 * @cgrp: cgroup whose idle state is being updated
+	 * @idle: whether the cgroup is entering or exiting idle state
+	 *
+	 * Update @cgrp's idle state to @idle. This callback is invoked when
+	 * a cgroup transitions between idle and non-idle states, allowing the
+	 * BPF scheduler to adjust its behavior accordingly.
+	 */
+	void (*cgroup_set_idle)(struct cgroup *cgrp, bool idle);
+
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
 	/*
@@ -4258,7 +4269,15 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	/* TODO: Implement ops->cgroup_set_idle() */
+	struct scx_sched *sch = scx_root;
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
+			    tg_cgrp(tg), idle);
+
+	percpu_up_read(&scx_cgroup_rwsem);
 }
 
 void scx_group_set_bandwidth(struct task_group *tg,
@@ -6004,6 +6023,7 @@ static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *fro
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
+static void sched_ext_ops__cgroup_set_idle(struct cgroup *cgrp, bool idle) {}
 #endif
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
@@ -6042,6 +6062,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
+	.cgroup_set_idle	= sched_ext_ops__cgroup_set_idle,
 #endif
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
-- 
2.43.0

