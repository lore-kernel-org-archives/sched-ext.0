Received: from out0-207.mail.aliyun.com (out0-207.mail.aliyun.com [140.205.0.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E081E6DC5
	for <sched-ext@lists.linux.dev>; Mon, 23 Jun 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661176; cv=none; b=u5Ket7qDwKDb9pQCjxY0UeGK2vAm+e3EWZ7mQA2TE9pXjsJW0MTWNPZqnlinjPOgcqxKFdroG4Ltpmhdv/TxNghLm3cPzeq4edDYmqqTEjN1LP3IHDFs9j760VKlFWPd6phPETYV5VkEtCjZN0VSCEbLge1ql2R6wxJKXmX2gDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661176; c=relaxed/simple;
	bh=8UB5J9QFz3miwngYF1CdElY7shv5f9JlCbEc0vPBKxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QK1OtydxPJNTxc8csOuDMPwN91A4ewdgUcTtlwYvR3SqTdTwZ8eQMrMds4bEoeiaMKelVYoUDCanzVOrEoX9cB+oQRCaSYHCEUzigeOa85K2KEDcB5ITyC5bG1FsAoeHY0s/+PAqj/mdnATV7sJEAm9hQJn+IeJbhTB4csgyXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=jSLW3xoT; arc=none smtp.client-ip=140.205.0.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="jSLW3xoT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750661170; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C0NvNwFf/o57be/X034T7v2QTbb/xicL+rUUX8Sv9Ac=;
	b=jSLW3xoTORwqYoH+vrsCYGDmH7Hu2yRFGLIxHcgakqKcm7yz3Fwn7DoScm01iiaIrFdx4AokX92I1Xo3P0zDjKIRgtm54IReZ1QMvOcr5Kx5pqANHMEeWx4EeP3w6CYLcfQF2K1/Kqzbd5iQs1LsO9+Io6fPmC2UaSZTASk/8ws=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dUAhwJz_1750660235 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 14:30:36 +0800
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
Subject: [PATCH v3] Implement SCX_OPS_TRACK_MIGRATION
Date: Mon, 23 Jun 2025 14:30:32 +0800
Message-ID: <20250623063033.76808-1-henry.hj@antgroup.com>
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
So we introduce SCX_OPS_TRACK_MIGRATION to support tracking task
migrations.
If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
would be called whether task is doing migration or not.

For v2:
1. if task_on_rq_migrating(p) == true
   set DEQUEUE_MIGRATING to deq_flags in dequeue_task_scx
   set ENQUEUE_MIGRATING to enq_flags in enqueue_task_scx

For v3:
1. introduce SCX_ENQ_MIGRATING(=ENQUEUE_MIGRATING),
SCX_DEQ_MIGRATING(DEQUEUE_MIGRATING)
2. change patch title:
include SCX_OPS_TRACK_MIGRATION --> Implement SCX_OPS_TRACK_MIGRATION

Henry Huang (1):
  sched_ext: Implement SCX_OPS_TRACK_MIGRATION

 kernel/sched/ext.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
Henry

