Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C393451AA
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281776; cv=none; b=TuIJteqmCHD7WYA9UeAddIUYJ9+wMaDDp1uUwkz2s3d8boKj4wrdAoqLXgYeIZ+lubccoU6de5A3OBZheY28je+bhMQdTJnRWvn3WWtwki9vm2kpX+/HFrdMRjr0o0kV6qZITiiPKtVqb3a7nrCztl5JIwAlgPGr4TAMPcN3VrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281776; c=relaxed/simple;
	bh=3PJEU8igOIlkmnCg9XmCLrfQJ/utVhcr8k3kYGS3Obo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSiLHrBHarFDaJYUan+6Of/DsmwVJgYBTg566uUtr5AaA++D4GmUmXoD8CKPVyamChn30FzGPbl9mobdxIvsyQEPL2YCLXrxBDklOGDMWwSto/+0tJENZQ+Q/1OdFcsEgaADcOQlL48GVYYFbP4lGo7CjoooQeygAp0b8P8tDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6+s/avr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6+s/avr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c79662bbd2eso20235a12.3
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281774; x=1776886574; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz9bMfi91YOLLJ4kszgcbcahbPfD11cvB1ZlFvmz24g=;
        b=D6+s/avrB6dlB7W+ubcPZLAmCNxQCX40wbThNfK04cd2iSbTzBV+EYGGG+CZkVqB+0
         NBG0Fh5/zHq4zfson7KLJ8vYWI4aLIGsDbCHIUc+74wEyUdmVRBCSl6RB5Ya39aYzHe1
         NPLUE7RfNkcR8e74Czh8Wx+p0zTi5AbbLrp6oRs1YHYtpOp68CDTSju8Wd673bl+QWFd
         gLKFjm0ietRvccNJNJ3zb9tyIOlIf4Q2HuXs56SIA94GE2wI7AFugnW7U0L1k+QIlgF7
         XXrYU7Lk6ls/8VSJuzwud+He90Vq1TLCZ++Yb53kdK2eO+tYWi3885gl3FgiiOpla1Ns
         BJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281774; x=1776886574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz9bMfi91YOLLJ4kszgcbcahbPfD11cvB1ZlFvmz24g=;
        b=LoSv65cVHR4/k2phUvRb8nL6A1r+PCDxGxwWJs8zXd4AqBg3Ps/Spu3g2Hq1hbztIz
         6VVn5nzTcuEMnW6zw9DwoN5GDfpdI9Jl4QIF6mKZsUwAStIgsw4249nYGSxJ/9yYhCSS
         zA5B/nlg+S4R5JVz9kNlyFqXvXv6fGCFj0aElrNwZOurJzgmXmg39K+lIyGBHdOyf/qU
         eulkSDdfzIWhTX1ch8dZ+tJ7WWT92krnEhQCk1SHb46PEd3l9t0vecV1v+AolLlZ9Ye4
         Ir6I7f+njzog6pSBK6h9mCoBHjgR60nQOAvbXEhuuiZnlpX1Zxiki0hIXmqLsYrX0I1U
         ffIw==
X-Gm-Message-State: AOJu0YzS+07DLobGGNIQ9ZrMvF8rhO6vpQCGnY4Eloh2ERMDs73YBmIh
	jzSxItV6T/2hKfEuNH8ONvWhTRiZoUz2ugAkqKf94HUcgof4kzW1dtS5C7B1jc9W
X-Gm-Gg: AeBDievu3G04BLUtKv+Ahplifjfk8Kka/bhyLK5/kLQIIy73RVnJYSmAi4FjCXFeCDX
	oTdCLsMZxcfevjE7J9yqwniGyn2160G37p/HLubSVN5Wacv9o3/VZpDRhWcWM75Y1SY6EPco2lY
	6YiR8UiDbeDPH7uIAxd4NJG79QoJieuaS1F7QbTZntKN6pCfulSny/eLJTriMdIg8pQnrfqOqfK
	pXFZJl2vTKVlWwInnwyxfC0VEwIDDWSUQRLeCMj6vfvDsmWyYKBo01oV03kBH6sxkoiyXcoqCKe
	McAVbo1wyh2lDldaBw6+1HoeIYgeI1mXrq5FPscVIfPYCuCGE4yyaX/6fIKDnB9rI2PxkZiG8i+
	aTvEe5wNXEjE6mIzX7Za6Drfa5gqYmFy5WzWUQ6/b9Gb1ABlv54oae3KlwGlimJvkloT/vab1Pp
	yhWX2xMypUxo0fTurPffleLNz9aWy2TReQpJtsSUBQQlfkg6zPX7T2w+Cj9xeM
X-Received: by 2002:a05:6a20:7494:b0:39b:9644:6e93 with SMTP id adf61e73a8af0-39fe3c748demr27510095637.6.1776281774367;
        Wed, 15 Apr 2026 12:36:14 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f741addb1sm1069076b3a.42.2026.04.15.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:36:14 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] sched_ext: Prevent RB-tree corruption in scx_bpf_task_set_dsq_vtime()
Date: Thu, 16 Apr 2026 03:32:44 +0800
Message-ID: <20260415193459.933175-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
the rb-tree sorting key, mutating it in-place violates the BST invariant
and corrupts the tree structure.

In ops.dispatch():
	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
	if (p) {
		// This illegally returns %true
		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
	}

Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
vtime modification and trigger scx_error() if the task is already queued
on a priority DSQ.

Fixes: 3035addfaf28 ("sched_ext: Add scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..7a54f9bc5e7a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8540,7 +8540,8 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's virtual time to @vtime. Returns %true on success, %false if the
- * calling scheduler doesn't have authority over @p.
+ * calling scheduler doesn't have authority over @p. If @p is already enqueued
+ * on a priority DSQ, scx_error() is triggered and %false is returned.
  */
 __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 					    const struct bpf_prog_aux *aux)
@@ -8552,6 +8553,11 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	if (unlikely(!scx_task_on_sched(sch, p)))
 		return false;
 
+	if (unlikely(READ_ONCE(p->scx.dsq_flags) & SCX_TASK_DSQ_ON_PRIQ)) {
+		scx_error(sch, "vtime modification disallowed while on a priority DSQ");
+		return false;
+	}
+
 	p->scx.dsq_vtime = vtime;
 	return true;
 }
-- 
2.48.1

