Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1921A458
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889532; cv=none; b=L1z8A4iGG/E+VZtghs55MCQPoWGDjJRRhrObH4JYNsQQhBM/bDu0w8fzkBuoSNHkQIekWxJf5Gx2f44UyxrjJPqedDwmZt2w/UHsEXO8zYMqigTCoYwcA/uoAx0t+mE5Lrsg1xsYqIbKMg+dRAU0QESq54VM4njkfQnpkBvC/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889532; c=relaxed/simple;
	bh=i2EHr2yFOvzEk2nw9aqlx1F3BnQnl5hUTpMRYd4KJeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1x4Lh0Up86E4gpz6kpfgYlXdgAoL7CSWX6IXKgpzzitaMlv1mguKr5Gpc+JXOZWrGb4IGRWvcs8J18y4agHe8ADQscqaACWNdGT1eIZ9WEZJ3shXSqEyX+DXjVqCwOinDq1zP77Ek8cqECKLTSNS7KzfXj5O0PoqhcL0N37q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1bn1nOv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1bn1nOv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e776so56466155ad.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759889529; x=1760494329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdXIcG8jCEHWHqBSd8qVzKFmP2x2AR7ZX05huB9bKT4=;
        b=a1bn1nOvWY9B9oq11TOzfXsCMF582Y0GDgbYb34ZI76tuMl/QIp9+HeCZ7/yV20Vx2
         okUQPIbpm0j3JvJYmDi3ATRYGux9PgrZ1p3R+gKK0Yl8rMdzEvIDjzkzswI3pqVg5Nz+
         P224PD9K5ctQWmMvPrY8v9IQmnqiAEYI4JEbtEU57CeBIoT8lei5yshsO8DrDmXKSKV/
         AaMKAFc+IYKnkKMKag2LJBytCLIu3S078k+nFaNrdq9VXmHzy5yirRQ5H3PsFtHQ/vaN
         neSDiPaUCdbSfDEiVSEmAhPjz4770PPKnXRh3Epeewitz9r849mSNs+c40UFVRnVUoCG
         +EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759889529; x=1760494329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdXIcG8jCEHWHqBSd8qVzKFmP2x2AR7ZX05huB9bKT4=;
        b=TP98cV7ryxjJ8dkYh32FlLxkNhmtENetm05f2Gns7u08/kSUMXPMjRPkXw8ZyAZ3wz
         aDx696wr1AIhh5oM/tDgRfhJbn30d2NAbIb2OofptH4SS0lZOtiIQjRHAiFz+gR4qqtL
         h7CG22gscIgZp1huevjNSJYB64pZADZqBjmWQuX01eJStD+s1zThuAz+8kUGPfr3WLOB
         LJ+F6vGxRK/EPx8j/k990LmuJ9K516YNcStXg1+IUlNOJjaIxSuBsnfqqtdhwXJWoqQ6
         27cgJgJwaUGKT1cwPeSOw/tMIDrYsChx6CYO/GcPbB0xn2IszcM+S8CZfnsS+kRi3dgp
         mSPg==
X-Gm-Message-State: AOJu0YyQjgFP5F1hDnn4bqyDE0W+Nz5H1z9mW3SvS0Gktgxn69ld06OB
	mQRL2+GNafhtPj+Bm1gcQUDbXZaTS30YKFObMzsaaxZsVyOGqBDTYI3X
X-Gm-Gg: ASbGncuyyg4oMykCm42eHA1sfn0KTEoyWXwwKPOj0EpWVsceNya4xEE3mF7wo2BotaG
	KehQq0QSyumY+IjkulTI4xrUZFFFTnP74esIWyfbeTi9INxM4H0WRSlJyMFt6NlTEcupZRmhrfr
	qiXeXeNAmIoc2Cv2fFX8Svfai4OEqaDmUO5Tk7j20btJdO71b6hc9hcdBDZDszKDICUxooyQao2
	3bsKS+NLJJ9BQjB/g0AxRNE7oqDJcm3R16hdLTeRh2a2ZcTp9awRXaqBlB6sXZL8ZCan5BsZu0N
	ywlEAS0SiOSZAi0aXNlEP5GEJajqM3sYgJ1UMOkENtzcThVaUGwhO7GIz19aqaJYAGcdR8xmOGo
	4JmrWFqhkw3bkcMBAEznyHahQXedpzplxHe3R3TTpyFclJHgoJRGZE6sl6QEeJLdcaBlYxNL7RY
	P75BsbC7i5IAzhZMy5qs+X5VE=
X-Google-Smtp-Source: AGHT+IHpi3egXB6hToGhGljc/KqzV1+lAHIZ+VWpWtC4kLU0szDdktoNgRD28vq6wnFeCh+Gh9738g==
X-Received: by 2002:a17:903:1ad0:b0:266:64b7:6e38 with SMTP id d9443c01a7336-29027383104mr23875905ad.46.1759889529106;
        Tue, 07 Oct 2025 19:12:09 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm180030465ad.36.2025.10.07.19.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:12:08 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	suzhidao@xiaomi.com,
	zhidao su <soolaugust@gmail.com>
Subject: [PATCH] sched/ext: Add tg->scx.idle which tracks the current state
Date: Wed,  8 Oct 2025 10:09:39 +0800
Message-ID: <20251008021031.630303-2-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
References: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an idle field to the scx_task_group structure to track the current
idle state of a task group. This field is initialized to false in
scx_tg_init() and updated in scx_group_set_idle() when the idle state
changes.

This allows BPF schedulers to check the current idle state of a task
group directly from the scx_task_group structure.

v2: Add tg->scx.idle which tracks the current state
Signed-off-by: zhidao su <soolaugust@gmail.com>
---
 include/linux/sched/ext.h | 1 +
 kernel/sched/ext.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7047101dbf58..b65e9abafcb6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -224,6 +224,7 @@ struct scx_task_group {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+	bool			idle;
 #endif
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 72bf2ad382fb..a2bbcc34e5d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4103,6 +4103,7 @@ void scx_tg_init(struct task_group *tg)
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
+	tg->scx.idle = false;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -4273,6 +4274,9 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 
 	percpu_down_read(&scx_cgroup_rwsem);
 
+	/* Update the task group's idle state */
+	tg->scx.idle = idle;
+
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
 			    tg_cgrp(tg), idle);
-- 
2.43.0

