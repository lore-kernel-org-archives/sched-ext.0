Received: from out0-214.mail.aliyun.com (out0-214.mail.aliyun.com [140.205.0.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46173A95C
	for <sched-ext@lists.linux.dev>; Mon, 23 Jun 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750653149; cv=none; b=IwJc8C8tR8FZkN5VJs1p2gb1rRsAXPGbQbBlulBEyqYDlVymPRCT9vGqhpx++IwcoEWWaXm/jFZp5Frj8hDlPG87QApDyUX/hbO1TXY2YucYMpE9SuLYpVefXqdDoB3U4h0yULMNt+WJUAejWzQetHbfQFORGH7OjoJFOD587V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750653149; c=relaxed/simple;
	bh=jJ5cIpu9E1ejxkZbGbSIUanoaem4NN9qJhhZaHR2xBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NikQrUwGRz54vW7G1Pc8UZBwVDs3B+5peAkGNOwQsy4NT8ax347r60cNbBKU8GmOKQUJLsGNhZATKrTsH51Odk67/iqIHIjiIvFJ10VDF2saf6T3W6mctzvSDZbpGTeLPpi2rpvL6o1k45bKdeevOz8J5mWJSAI/omxaHI4mOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=it84hamb; arc=none smtp.client-ip=140.205.0.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="it84hamb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750653143; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8Aq+Ad1yts9qqSBkV1zLPW3r8bTbyOMzAX46gIlSrpY=;
	b=it84hamb+PABpkMU/nPWtWuvVRmJcsoCtbR80I8xUrBgAC6sCxjSoR5jak+UxihTPBefI5act8ELFifJ3BqTC7/x0NgNoob41JGkeIo6JjDA8m/UvvPnSxPeRSYOnWa8BYpCC99fpUGSxYw18Lec0aY+7Bv23Zeu2NjDr8ofDkw=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dTqDjeO_1750653142 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 12:32:23 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com
Cc: "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <sched-ext@lists.linux.dev>,
  "Henry Huang" <henry.hj@antgroup.com>
Subject: [PATCH v2] include SCX_OPS_TRACK_MIGRATION
Date: Mon, 23 Jun 2025 12:32:19 +0800
Message-ID: <20250623043220.63793-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our environment, we need track task migrations to update per-cpu
map.
Implementing fentry(on enqueue_task_scx & dequeue_task_scx)
is a feasible solution. But there are some limitations:
1. Can't modify p->scx.xxx
2. enqueue_task_scx & dequeue_task_scx can't have some
special compilation optimizations.
3. Has more overhead compared to struct_ops
So we include SCX_OPS_TRACK_MIGRATION to support tracking task
migrations.
If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
would be called whether task is doing migration or not.

For v2:
1. if task_on_rq_migrating(p) == true
   set DEQUEUE_MIGRATING to deq_flags in dequeue_task_scx
   set ENQUEUE_MIGRATING to enq_flags in enqueue_task_scx 

Henry Huang (1):
  sched_ext: include SCX_OPS_TRACK_MIGRATION

 kernel/sched/ext.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
Henry

