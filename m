Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4347E0E4
	for <sched-ext@lists.linux.dev>; Sat, 25 Apr 2026 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777084653; cv=none; b=h7JmjH2ljMrK5U0YcPF8z3o1iarN5jA0eliSXg92BMBVIOxUCH41tBBUmGsCcMvS08q/v/w5A3qeag1XOngIixHfXiLUEpp6yFaL1AwhsVkzOzQyMcySgyFhZiJ4caiteBm7VWEZl++gaXPoRKOrsz9sqyPFZDo68LVO3TjONko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777084653; c=relaxed/simple;
	bh=g6fsmvxbPRK9M+E8p5jgAkhYJGMaFBKbIiLh4IYZjuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pChLIiLOp4G3BRQI88RHpIL9EXOSzuIdzqxCuskcy4uDL4ajTXEYeXGHVN5unzO8gxmvnE9uaYt8LbH+8PoIFaY7PmXfAAioJeW0Zm2NlbtRk+WHUYJKVnxJSeOCepj1UwhQmLccPpeY7vWiuSIFno5waRpHHuZCJ6L+RsAgKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaOeGEfR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaOeGEfR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adff872068so42313175ad.1
        for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 19:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777084651; x=1777689451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R15ytLVfKC+tEnLcek6WjXzMp8CZTI3s6dQ+RnQlQ5Q=;
        b=kaOeGEfR+WtAmiwNXppF0wcLbyxDu6B2TXhu92RbiiAwybbwZSHSqMWioGCIj3bQh6
         2P5E5Kk/6ESbfBgBTCK4RbbhkqxB3CFeFdLRcuiHUexVX+3uZ/7TaRzoF60qthgQS3La
         B07fl+Eg97packciZSFL+UIEY3+4QZ+97HwrcGtoOeJF3UwNxNP6mSjzTkOEGB353XTk
         KH9WWUHkqCv6kV9zYtS0efOVDA5UAEpq4xz6u/NrE7toIgeEdgI18I0YGg6MMyfAok/t
         ELXXiXE0v9d4EcvNKS9UgMDkgo9HJrEye6aHU8kNf03tsVxu5b0Rwbz4CXPtPNXYH/VV
         MOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777084651; x=1777689451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R15ytLVfKC+tEnLcek6WjXzMp8CZTI3s6dQ+RnQlQ5Q=;
        b=cmYM9atNkeeiJSqaru5sfRjlLGuqRUxL0uWoJ1ejsVqUG7MCFqp0M1y5eBb7B9D6Da
         UFqVjEGuWO/jtUGOJAzCrDNn80BOEL4Nvke6RYOd2d0bC23Z8zLw+n8x+qnaVWGZJCaK
         hDhQPkd0h6AUH5E/dq/zC995F+T0p2LLfHg1omBw08rN39JkNw9b4lKiY5/U6O3Ufv7M
         Te7z//5QcSD8KUIEkSnVXOqJYSlknAE3BSobhqvwVfBxplcZ0DZKDN43Sh+yzuNNib1G
         wLVfQcZwdcf4gs55JffTC5Np0+3JVTu4hEX+MZ1OUtqquF9Dfq+YW2N+jqLpzNppxARl
         i4rw==
X-Gm-Message-State: AOJu0YwAbAaSTykBopESxIXA9VShuyY/bb7m6TUJw//hun1u9/7N9IXS
	uWSrKqP3CCuKz7aKh6HYgOVa/T/Oucu0g61R6Xm3bpeYLYSn4Rwz0jTpWlT0L9Mq
X-Gm-Gg: AeBDieuQ7FEvs5xf7OnhZUpA5uZ8nGz0ut8qa7RG9BHT05flsMHL4m2ns153+WxuYL3
	er79PwQgOBCLdJzwcHSYT3JwuY5HCSHL/O2sqMY4PuyF7uGOv3+jnrmF7icrlXjeTPOZ+cMsP3A
	+lx/z0j6CRk+wynqMS5ZA4Cyqqp2V2odLrOEw5iaClvqvMteJZA1Sns4rJzp7v8gR5nwOSbChff
	cs9zmZ2Gvj0F7R1oYLM4YqoHzyzN9Oy5ortbAeoo9eXgpHx0xVsy0VgyQlJyOAcgwVpkFJwcPK6
	X27REOp4Sk5lcagWjhEVchi6de9cWoM3S2Lo51H7JDDtp6Qc5bhnaE7jaeqsykEGNHjrDa6uWhZ
	v5JD9Xnw5MIrWOjFWUUWZHfL3Ez65Ns/Rs3y/f3xWhN3RvbI52tQCxJvRmlDzwlDL9d/COb6kSj
	lPGysG60XczzlrdKbe5wlRWyhs/w6JaQxoPyQKG/ibkv6HfxZcKlVpXGlOhmZY9f8=
X-Received: by 2002:a17:902:f549:b0:2b7:ac66:27ff with SMTP id d9443c01a7336-2b7ac66289cmr99361335ad.25.1777084651126;
        Fri, 24 Apr 2026 19:37:31 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:7436:7c21:658d:fbf8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm229548215ad.1.2026.04.24.19.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 19:37:30 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Use global task iter in scx_sub_enable_workfn() abort
Date: Sat, 25 Apr 2026 10:37:21 +0800
Message-ID: <20260425023724.1249914-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_exit() removes tasks from cg_list before sched_ext_dead() runs,
causing cgroup-scoped iterators to skip exiting tasks. During abort,
this leaves SCX_TASK_SUB_INIT set on those tasks. Since the abort path
clears scx_enabling_sub_sched, these tasks later skip cleanup in
scx_disable_and_exit_task(), leaking BPF resources.

Use global iteration to ensure all marked tasks are cleaned up.

Fixes: 21a5a97ba478 ("sched_ext: Don't disable tasks in scx_sub_enable_workfn() abort path")
Reported-by: https://sashiko.dev/#/patchset/20260424204418.3809733-1-tj%40kernel.org?part=4
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..1225349a8134 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7292,10 +7292,14 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	 * Undo __scx_init_task() for tasks we marked. scx_enable_task() never
 	 * ran for @sch on them, so calling scx_disable_task() here would invoke
 	 * ops.disable() without a matching ops.enable(). scx_enabling_sub_sched
-	 * must stay set until SUB_INIT is cleared from every marked task -
-	 * scx_disable_and_exit_task() reads it when a task exits concurrently.
+	 * must stay set until SUB_INIT is cleared from every marked task.
+	 *
+	 * We iterate all tasks instead of just the ones in @sch->cgrp as some
+	 * tasks may have already called cgroup_exit() and are no longer visible
+	 * in the cgroup's css_task_iter. scx_disable_and_exit_task() reads
+	 * scx_enabling_sub_sched when such a task exits concurrently.
 	 */
-	scx_task_iter_start(&sti, sch->cgrp);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		if (p->scx.flags & SCX_TASK_SUB_INIT) {
 			scx_sub_init_cancel_task(sch, p);
-- 
2.48.1

