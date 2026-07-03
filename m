Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5E314B95
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105808; cv=none; b=rT33dxjLjWPxOVm8lrmLhbu5BXDyS5zS900xT8TDiAixxIi/0E0If38p43ra9iyiKy5dzqGZnNp+17BCrGt3n8oR9ECZ8qcz4KsZs2HLjv2GkFtSi/W0VA0uGxoWs4rRadq0I7UjPdHhspfewU0kEerXDgx6fWXu47YVVc+KuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105808; c=relaxed/simple;
	bh=ZlK7z9//RnFfOfskycYtIQa0klINO7/vYVNzgYYGnm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7tMk3yHXKm7/65ilVsBsOd5dhlT1/7AxvRadgl+z4krOqcR5MwLt6XGNA+iYMs/3t9MIekFt6pzlPZRRaOwLRbk9QBSjYJgnDbf5Q2fEufwE9hdRQt9MCe40Qcn6jXRtFd1cmiM3Yeg0A9znrCfbf95/EEGTRLJ0CJ3xNKn+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONCQpyU4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONCQpyU4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso672285f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 03 Jul 2026 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783105806; x=1783710606; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9N2tBl8ViVZews9y8opzseXm1ElhkkHecx0+lMTxLKI=;
        b=ONCQpyU41vQkVtBSjQAZ8lu3NprKcXHelqw5c0iMg0qT8CP+ssn+F/uhnr5xIzRM5/
         ng8fB1IqoW/qvph/jBifuCEuX0rPeEAe9bMgZu9Tn1m9DWfXNrICSnyzau51g0JJXeYC
         XOQ71MmkswHXs3uSMyPBptJXZOXmgLGwWLqGK09dfPJFU2jfeHktiLmNA2xnvVtL5r5s
         DP6KI4kUzxzwdLtq3rt+zUvxfq0QIJBq4XfrUBr44TB+JqvTMgzYnKZwO1X+iRFal0Cm
         0LTWP4fR8jwZm5+8w8irI2qj5ua/gNoKNLwMPAwgb+uE/w5oGleFExAKdXcqWVRiK/3J
         6Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783105806; x=1783710606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N2tBl8ViVZews9y8opzseXm1ElhkkHecx0+lMTxLKI=;
        b=SjdOR5t552RCnaaft35ufnfjgBFzLc6EgWp3rFl28QU2wGjxHNkgPNuWfcvj7yj1PQ
         EUNC/QdxQgW+OYvIfHfgY2I8u1V0Zy/B7dYgk63W2QHX83X80RvzOlLDWJ0KNBsQHNRk
         qJYbo/6kqPf6zxje6MWuiDhScfXJqTx1GGw36GFzRiRQdfHHEf6rFHcc/uRVUgP8pcm9
         Hne31x0UTdVZt6pwttQ4rvjxHEIdDD79D/Pxb9cBODW24LXi836CI4q+gD07jq66utfU
         BK68Gb7cMbSLl5qeeFMuSDU2EdrEQwQ3XK3sXS0jWNLiV11i6Z46uhSc+ZhZDoUf3c7U
         6YMg==
X-Forwarded-Encrypted: i=1; AHgh+RrzzAz7m37CZMcJDw4dUXuubG12vlMvUZVPKa1WJ8l/OxipHzGspkSksa6aBxB2qhE4zU14BDsvwWY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp4obY2BCn4UduNE9f9Hf6blzXmb8PdvneFZMyYut1yMSMYax0
	Mh6PGi3Sgkc3Tb0mme/QvLM7TSiZwRdc9N2Yk4T8lqw3BOmh99VhLk2K
X-Gm-Gg: AfdE7cnidYBFG8bj01xK/Me72tzILqZfzRMuptK/kwh/1Sux+H0HH24rPDDRNv8Tw9D
	1augJ5Gq63aLffbXeg7c5BK1bvOSZy6ZyfcGWyjYrDtACc8kthkwWaF/Bb5jJ7h1k0Ee+NAuLzm
	RYPJlQxy2RwE0neI2XWr1ShdH5VWruH4pNpkDxPHuaQ9vuHy0LziIol/XB9COSaOsrt3piGdbOn
	nOlwyV3HcrAo+T8Xwm3OvVhCmCGU956npmcWX+cN83t3xgxpsVq599HY4//CZSfXsAwnynpvQ6V
	yNIWJERAyW93duPsufZqT+fwD+qdRa2YJDwv2Yo6ChEIeM5PXFdqoobHbocTEKrasAWivj+lQ3b
	26OdGv+FHrvxUue3ep8yYMqp70wNA1ISBEsxVZcna9M3deooeDZC08Z2t1lowjeDw5LX6knM50l
	eaVpD6MHM3U8EVUr324/YzkG66ENX1vl+wHSS4T62qv24PVdWqMwx0dqbzRLtr2cz4mZfj/KXa
X-Received: by 2002:a05:6000:178d:b0:474:f3b6:537 with SMTP id ffacd0b85a97d-47abc2e5765mr414012f8f.14.1783105805326;
        Fri, 03 Jul 2026 12:10:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm1434801f8f.9.2026.07.03.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:10:05 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] sched_ext: Arm the exit on the sub-scheduler enable error path
Date: Fri,  3 Jul 2026 20:09:57 +0100
Message-ID: <20260703191002.804763-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling a sub-scheduler fails, scx_sub_enable_workfn() jumps to
err_disable and calls scx_flush_disable_work() to unwind. That flush only
does something once the exit has been armed, which happens via
scx_error()/scx_exit(). Several error paths reach err_disable without arming
it - most commonly ops.init_task() rejecting a task with a valid errno, and
the -ENOMEM cases from the arena and cmask scratch allocations.

On those paths teardown never runs: the half-enabled scheduler stays linked
in its parent, ops.exit() is never called, it is left stuck in bypass with
the cgroup subtree still pointing at it, and cmd->ret == 0 reports the attach
as successful. It only gets cleaned up later when the struct_ops map is
detached.

The root enable path already arms the exit before flushing; do the same here.
scx_claim_exit() makes it harmless for paths that already errored.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/sched/ext/sub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 050420427273..12e2e0787b13 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -570,6 +570,17 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
+	/*
+	 * Several error edges reach here without having called scx_error()
+	 * (e.g. ops.init_task() returning a valid errno, or -ENOMEM from the
+	 * arena/cmask scratch allocation), leaving exit_kind == SCX_EXIT_NONE.
+	 * Arm the exit so the disable work is queued; otherwise
+	 * scx_flush_disable_work() is a no-op and the half-enabled
+	 * sub-scheduler is left linked and reported as a successful attach.
+	 * Mirrors scx_root_enable_workfn(); scx_claim_exit() makes this
+	 * idempotent for paths that already errored.
+	 */
+	scx_error(sch, "scx_sub_enable() failed (%d)", ret);
 	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
-- 
2.53.0

