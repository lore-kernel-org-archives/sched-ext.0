Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D46236453;
	Wed, 24 Jun 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294055; cv=none; b=uyPPGehVkZmNL7ja+/u3l/A+kYRIIPyKlHLqVz4UywgonUK9yEoZUOmanbp3P8mWEo0I3CzbFDPrzIM05SeMGGSxSYeIa1Dpdsae4EAD5FWb/CQ+JG4BbD6OzMVO00aoT+OOLiQ5Pal8oEsT/enIG+CD6kMAf59xdLOCVrhtqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294055; c=relaxed/simple;
	bh=tT27IDAuXIjVYckOZ1Q1mSGk8t0bXJmn2Y5yivwiA/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1z6m9qq4mPMk8+ZQEmG1rgpxv0ZAfgSnsREaev4OvwgE7wqNMZtjUYcXmx+BklLtVFBNronqJK3CnqAnU1ThRlpfiIIdjH5Qs0d2OnM+fHI2ArlpowXiimJIEk3uUv78tTXTYdTrSzwZwQV2sclkCy4YKwfU8870H/qOM+MKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bRz9KT1e; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bRz9KT1e"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rNHX1BfC0QKNibPspyDmD9iG11VJWd6nZncAxWH+f/w=;
	b=bRz9KT1eAlznzLJgDND17LoitwvHvOd8MLENIGEKywJQi+P88Uud05b7e4LX+mVY1/pvkVpXH
	FyeCThQmId96vhjN4oaJjA1yVW3AC574iuSCFDsB2LJOPTxmlwtFu/k3rsC9WyvMS5Z9h4t69+s
	rWbo7yGXDY7E3+TuEc1SwPg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4glcCQ2rH6znTVR;
	Wed, 24 Jun 2026 17:32:02 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 51BA440575;
	Wed, 24 Jun 2026 17:40:46 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jun 2026 17:40:46 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Jun
 2026 17:40:45 +0800
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
Subject: [PATCH v4 1/2] sched/fair: Rebuild load weight when switching to fair
Date: Wed, 24 Jun 2026 09:16:47 +0000
Message-ID: <20260624091648.271891-2-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624091648.271891-1-quzicheng@huawei.com>
References: <20260530050609.0D0FB1F00893@smtp.kernel.org>
 <20260624091648.271891-1-quzicheng@huawei.com>
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

Tasks that run outside fair may not keep p->se.load in sync with their
current scheduling policy and static priority. sched_ext, for example,
uses p->scx.weight as the active scheduling weight, so p->se.load can be
stale when a task moves back to fair.

The fair_sched_class expects the sched_entity load weight to be valid
before the task is enqueued. Rebuild it from fair's switching_to hook,
which runs after the class has been changed to fair and before enqueue,
so both sched_ext disable and SCHED_EXT to SCHED_NORMAL transitions get
a native fair load weight.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
Changes in v4:
- No code changes.
- Add Tejun's Acked-by.
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

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d78467ec6ee1..edb11065a9fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -14998,6 +14998,15 @@ static void switching_from_fair(struct rq *rq, struct task_struct *p)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 }
 
+static void switching_to_fair(struct rq *rq, struct task_struct *p)
+{
+	/*
+	 * Tasks may come from classes that don't keep se.load up to date.
+	 * Rebuild it before the task is enqueued.
+	 */
+	set_load_weight(p, false);
+}
+
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
@@ -15379,6 +15388,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switching_from		= switching_from_fair,
+	.switching_to		= switching_to_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
 
-- 
2.53.0
