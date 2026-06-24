Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91A2D9EDC;
	Wed, 24 Jun 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294058; cv=none; b=O68kslcw882sAVak3mWRA+qRtnrBMBR3bRJstwHXDuYPAhgsG8odTx+fyqYtmVWppvnmbShCzR501M1G2n5/ZU9g6KuFSRsE1r9IgcctnMq720bahPj39A444NC/dGstdeLwMY7V7g+zJjltXd/WlhEwUe+D9DScAVnytc/9hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294058; c=relaxed/simple;
	bh=I9TS+AIyzPOGG0RwTXKN9efGVklTHpmYd4PoZEiLAZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx0KuG6VYVCtc1E08XtTTRynaLa9MO4YaUH4nXrz1IYU2u6CFA3NBOBmete1y3MGRRSKMyoSoWPPPRhCTP4KQDxgQfsa5FADN/QYuOhiWw1m+Kjbkb8rXgUT73OImsUDLQvwtUU465CYkjaWxUZfKjdlHxF0Ke11o5AB394PROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kjV3t4Yq; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kjV3t4Yq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vzZQsswJjvFugFNEBHLIENXWTIjQBInRGr7YAOgWBNA=;
	b=kjV3t4YqlpvI536dkHsrOrh55Mqp7cJnMI9Mf96/ZdltZpRhNv2Vyl6uOUMO85m1waLXF3Kr0
	gF7NMHFcZsI81X9QFxjeFBw45rJePwrq1t53ZSitPE8QWCLqKkASlXJbx0WRSu/naJn3YRm12Fj
	tGjW9to+Gbd5EBN5uLe1NPM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4glcC66Y1Hz1cyTM;
	Wed, 24 Jun 2026 17:31:46 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CC08940571;
	Wed, 24 Jun 2026 17:40:50 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jun 2026 17:40:45 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Jun
 2026 17:40:44 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <sashiko-bot@kernel.org>
CC: <sashiko-reviews@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<sched-ext@lists.linux.dev>, <peterz@infradead.org>, <arighi@nvidia.com>,
	<brho@google.com>, <bsegall@google.com>, <changwoo@igalia.com>,
	<dietmar.eggemann@arm.com>, <haoluo@google.com>, <joshdon@google.com>,
	<juri.lelli@redhat.co>, <kprateek.nayak@amd.com>, <mgorman@suse.de>,
	<mingo@redhat.com>, <rostedt@goodmis.org>, <tj@kernel.org>,
	<vincent.guittot@linaro.org>, <void@manifault.com>, <vschneid@redhat.com>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <quzicheng@huawei.com>,
	<quzicheng315@gmail.com>
Subject: [PATCH v4 0/2] sched/fair: Fix fair load state when switching to fair
Date: Wed, 24 Jun 2026 09:16:46 +0000
Message-ID: <20260624091648.271891-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530050609.0D0FB1F00893@smtp.kernel.org>
References: <20260530050609.0D0FB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100012.china.huawei.com (7.202.195.195)

Tasks outside fair may leave fair's sched_entity load state stale when
they switch back to fair. Patch 1 rebuilds p->se.load from fair's
switching_to hook, as in v3. Patch 2 keeps se->avg.load_avg in sync
with the rebuilt load weight before the entity is attached back to fair.

Changes in v4:
- Add Tejun's Acked-by to patch 1.
- Split the PELT load_avg synchronization into patch 2.

Changes in v3:
- Move the rebuild into fair's switching_to hook, as suggested by Peter.
  This lets fair prepare its own state before enqueue and avoids adding a
  sched_ext/fair-specific fixup to the generic sched_change_end() path.

Changes in v2:
- Move the fix from scx_root_disable() to the class switch path so it also
  covers partial-mode SCHED_EXT to SCHED_NORMAL transitions through
  sched_setscheduler(). Andrea identified this missing case in the v1
  discussion.

Zicheng Qu (2):
  sched/fair: Rebuild load weight when switching to fair
  sched/fair: Keep load_avg in sync after reweighting

 kernel/sched/fair.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.53.0
