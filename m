Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946717D7
	for <sched-ext@lists.linux.dev>; Tue, 24 Jun 2025 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734203; cv=none; b=bAqhqSLpEf1SCzADyx5lBTqD2REEfKMSfQB1IRNw5pzg/d0c7lsOxibr7qc34CJz7KKm7md/my+qLwmPXgKtmxzMLlY05DmMtOwsOJiFKsMDU33324/cy/6J/KEMXQgTOjJpX5X3tPJkUCoDHMunzSiHqxnTIEvIDBqzgkvSNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734203; c=relaxed/simple;
	bh=x54Hgd8Vb+9uKtEoLHQMTz4ODUR4o+1AOHqMpq8qAJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DONccDg69odA2W+7ZwGn8xkdny3Ja7HQnNvl8Sfo038bopicFNuznE1ArPKbUcL40LTlosvmV32dhVUX3K0IXdQJ+4QsFrWPT4teZS7iVE1fHfPVilAfWQkErMBtNb/FTcQy+zdc5ZYBiEoajWJbwNpZBcV39UwMCavQMUcwc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Exouejk+; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Exouejk+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750734197; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h+0mi8eC+J3xUw5Xo5AFUvG9XykWYO6OhaS3iBZj/a4=;
	b=Exouejk+B+rI6efZq6es2rVxCtfNbJj07VR2RIqnM1DWXDKAOQhMBFRHTjeO0XeVXZUixmhWImnHNm6G2WV7zwDt8eMrqZZ20RV1xKzfvoz89W2tYCHopHaFu6Y6hngoR4qrYSoAg2h9erL7Lb9v3q+dZJFSEotHY75xu/IPQc4=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dVBuTMH_1750734196 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 11:03:16 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: tj@kernel.org
Cc:  <arighi@nvidia.com>,
   <changwoo@igalia.com>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <sched-ext@lists.linux.dev>,
   <void@manifault.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>
Subject: Re: [PATCH v3] sched_ext: include SCX_OPS_TRACK_MIGRATION
Date: Tue, 24 Jun 2025 11:03:14 +0800
Message-ID: <20250624030314.48808-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aFmWGi8n1ndB1K_M@slm.duckdns.org>
References: <aFmWGi8n1ndB1K_M@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 07:59:54 -1000, Tejun Heo wrote:
> It's rather odd to invoke runnable/quiescent on these transitions as the
> runnable state isn't actually changing and the events end up triggering for
> all the migration operations that SCX does internally.
>
> In the head message (BTW, if it's just a single patch, it'd be better to
> include all the context in the patch description), you said that this is
> needed to udpate percpu data structures when tasks migrate. Wouldn't you be
> able to do that by tracking whether the current CPU is different from the
> previous one from ops.running()?

We will traverse the per-CPU map information in ops.select_cpu() to select
the appropriate CPU. To reduce the competition for the rq spinlock, tasks are
likely to run on the CPU selected by ops.select_cpu().

However, I can think of two scenarios where passive migration may occur:
1. set_task_allowed_cpus
2. cpu_stop
There may also be some passive migration scenarios that we haven't thought of.
This could lead to incorrect information in the per-CPU map. Therefore,
we hope to track enqueue_task_scx and dequeue_task_scx to ensure that the
information in the per-CPU map is accurate.

-- 
Henry

