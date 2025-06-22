Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC37261F
	for <sched-ext@lists.linux.dev>; Sun, 22 Jun 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585322; cv=none; b=YMv3T6Up2r4TeAtUYcSStn8aR51IfZDLBz6Am11g2cWF+e1H3jtTZG8hexdvgSG+1JMDZCC8OhOyg8Umg4S+rOQ3SfZgtf2DxVXqIWGysDVEMJi++bc1uOaP8CBAdBqn09n8E8KlKopv/droccifEF2dbCqr7wzlFxubYfhrT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585322; c=relaxed/simple;
	bh=tn4ctrA+Ql5qlX8LCziOLYbqWSA2PszJ6T8t+I5JtEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LC7/tBvpw0lWMGXTyLCYoMDkMrR7plDLMI7VTlMQNLAsstLbeZkW90tCvRI21l4aotXaPAcJBpfdAmq7an8CHcwzUFLc2xAIhdxdiqeUJR9gjW57qSWFD9oJPVwMeL5qmEeh0/0jriF+oQPoAGYYIiT1/mWVwO8jmaBet8s51QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=OsN6sb5R; arc=none smtp.client-ip=47.90.187.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="OsN6sb5R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750585306; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YZ0WrFk9y/8LcKmpn+H6dmv5YneL/+xqjv3QHshdfdk=;
	b=OsN6sb5R2RxieXauicgCnCJYsBdKpnI5etpWp6BYdxzthU/U276cqsVQeiFkc0+XXhy9dh153swxvV++UVZKCWy6DoePEE+qmkfjQ+2+dh6DxTUOLEFqR8JL2/uZtr7mlFUYr+oHhIBws4T/hXLVpZllRWCfZmQA3OVpoQmSg2Y=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dTG5lZl_1750584987 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 22 Jun 2025 17:36:28 +0800
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
Subject: [PATCH v1] include SCX_OPS_TRACK_MIGRATION
Date: Sun, 22 Jun 2025 17:36:20 +0800
Message-ID: <20250622093621.1669-1-henry.hj@antgroup.com>
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

Henry Huang (1):
  sched_ext: include SCX_OPS_TRACK_MIGRATION

 kernel/sched/ext.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
Henry

