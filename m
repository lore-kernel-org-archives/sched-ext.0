Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1053FB7D5
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677888; cv=none; b=V7A/SJUUuZAPPuUwTUTV2wBR+p8wqq/lLtOhUUtlNiG6AbDSeK1bNyE1dU0rDbj+ejtObhLZzHUQ4xJ8mEsvazlGSquSG8OAcWtQbCcpF9pr9bYvtNdiUWvcBaMK2wlICrkhBpjfgUFuzSXmk5b3ip0c3C4F9lKtY4gbpBTMEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677888; c=relaxed/simple;
	bh=1/T6l30OSc/13ghkKigE/EraxxH+hq6Pkoy8zdnQBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKiZDAPyNcLRbGzVRh3yuwhZJewmnwpdXzI4OrsFuoqCXWthI768iky2QLckoMaYQPCyMB4B25OlWhor4Bp9SegVESpO5Up8qZfKxIs+X6V8SDNPuKuz+T2YD9QbI5m2azR1RZJxCfOdAPh4DfiggN3EhXZOJ/+vNt/kfyjKq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=hts2WApI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="hts2WApI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47d70879764so481768f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783677884; x=1784282684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=hts2WApIerViYgXmW9YGGIlO/5DXW07e82nVO36iBAlxaVDUAaZ+dVI1MHOH445pfi
         VkgVsySVh+eRJ706VHT/Hc8yYVvR1znUI8ZNK6c6H9g14AJcD/XTIffxx+PrIDua3LG0
         yoak/EjlfH3PLw4bohycL6y+11g66roap4eNjFufQ4DJNcAnn9PPULFsta01jCUIVuo1
         fsJdpwHPIqzf2Je1VhQfB0njJVix1TL1LLR3TTttmVIZ0z/e5zx++hb/YETOZGGp24d5
         GGRhybvKY0qfL5J5jgp1H+l3xa0QcyCGdXLp8Nmqi6ePSovblkOVA4E+/Glc0VJ1F+45
         vz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677884; x=1784282684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=KKqHBWt5rLMX9dvXAUjoGx/RNH6d39VKls+3Uu05jZXLiGSDNHPS5K4TUAi+9e9AeQ
         s8Et/I4KbUH3kbWpYAD778Di208qEigyGisw04cb1rJYW9n8voKPlVryQVHt3AEohii9
         UUNCQF22m57j1PGnNNk8q1Q64xnwUoFj319caucVM87Zi2YV3yDqjJjKMw3Ypno2Yh7F
         M4gqgvaRf8a+K6F7j+FSW0OjEuLNei25Lv34CNyIGbjCUUAWSJfb8cVGWxPp2ZFBU2Ig
         00u69jxwYKhU3yxjqwl5tSkIS79HckojQr2jA46Lgz0at5mNmdHq/0NBCN53ITQ6ZJ3W
         oIHw==
X-Forwarded-Encrypted: i=1; AHgh+RoQckGULBLNoNChq3dOf12QRZd9m37pbn0qDM0dR1e5sXMw77tyywVMx0Wm1sTGgcnSk9BCCxQFS38=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo6alx7IRG3fjrFq7NMahkYvhjxkJKjk2kEfHAinlXrcc2h4Bo
	4fPiJjL6/fvIgAk9HHe62xrKmjWFAa5m5xpkhuP3lDCZMG23g/vcX4EaV8rOg5OIYRU=
X-Gm-Gg: AfdE7ckZ1WBYsR2G4q3ASg/PUZ0cTkcyYWPcSQtN70rEC0216t4GnNXUV+3f8Tn7m+9
	bZGOmFF94tnjerw62I7rHCMSFeosEZEuw+9qLbLw92A8e608DSpUKD5V9eobs13Z5lcu9f9sbhb
	GAA606R4h5R6iLYoyP235bUTmHBSkB+QJtvU5A/HcVJJrcQnmR6+kiD4v3BXop2mn8MCFlds03j
	11dwEZktTEIJHVEupVi8Vw+uYfhUI2uwIPmIAWpDltktVU0zybCsReQnpCsZF07UmyAKgRvyO08
	jgNNZUv36uh2YTx+IENs7HJgel8YoxRzKRvoh7o3bNkZSyQHfJoCJST0y6HpshPDxNWn8a9hQ3h
	ABvncIYlwi/8OTeg0raKF0FKm0XYuAYXUDqpCi3iYnWgDcrMYeR4wvO6Mmnv9QXm+Xy+Di8Ee1H
	vfe2qV1iRDUQOcrxs=
X-Received: by 2002:a05:6000:402a:b0:46e:98a7:232b with SMTP id ffacd0b85a97d-47df07a8676mr12628273f8f.10.1783677884305;
        Fri, 10 Jul 2026 03:04:44 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26a0::3d9:1e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm61261033f8f.21.2026.07.10.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:04:43 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Date: Fri, 10 Jul 2026 11:04:41 +0100
Message-ID: <20260710100441.2653477-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

scx_root_enable_workfn() currently takes scx_fork_rwsem for writing
before acquiring cgroup_mutex. Since commit a5b98009f16d ("sched/psi:
fix race between file release and pressure write"), pressure_write()
holds cgroup_mutex across psi_trigger_create(), which may call
kthread_create() for the psimon kthread. kthreadd's fork then enters
scx_pre_fork() and waits for the read side of scx_fork_rwsem.

This results in a deadlock. The enable worker holds scx_fork_rwsem and
waits for cgroup_mutex, while the PSI writer holds cgroup_mutex and
waits for psimon creation to complete. Any concurrent fork blocks on
scx_pre_fork() behind the enable worker.

The hung-task detector captured all three sides of the deadlock:

  scx_enable_help:
    __mutex_lock
    scx_enable_workfn
    kthread_worker_fn

  systemd:
    wait_for_completion_killable
    __kthread_create_on_node
    kthread_create_on_node
    psi_trigger_create
    pressure_write
    kernfs_fop_write_iter

  python3:
    percpu_rwsem_wait
    __percpu_down_read
    scx_pre_fork
    sched_fork
    copy_process
    kernel_clone

It also identified systemd as the likely owner of the mutex on which
scx_enable_help was blocked.

We reproduced this on a 128-CPU AMD EPYC 7713 by enabling scx_lavd
concurrently with writes to cgroup PSI trigger files. Unrelated tasks
piled up in scx_pre_fork() and process creation on the box stopped.

Fix the inversion by acquiring cgroup_mutex before scx_fork_rwsem in
scx_root_enable_workfn() and releasing them in reverse order, while
preserving the existing exclusion around cgroup and task initialisation.

Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/sched/ext/ext.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..ba89eafe7964 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
+	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
+	 * operations may create kthreads while holding cgroup_mutex.
 	 */
+	scx_cgroup_lock();
 	percpu_down_write(&scx_fork_rwsem);
 
 	WARN_ON_ONCE(scx_init_task_enabled);
@@ -7216,7 +7219,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 * while tasks are being initialized so that scx_cgroup_can_attach()
 	 * never sees uninitialized tasks.
 	 */
-	scx_cgroup_lock();
 	set_cgroup_sched(sch_cgroup(sch), sch);
 	ret = scx_cgroup_init(sch);
 	if (ret)
@@ -7283,8 +7285,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 
 	/*
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
@@ -7369,8 +7371,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	return;
 
 err_disable_unlock_all:
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 	/* we'll soon enter disable path, keep bypass on */
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
-- 
2.43.0

