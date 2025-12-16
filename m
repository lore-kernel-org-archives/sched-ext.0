Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A331ED71
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878064; cv=none; b=jM6Th1jW8wOJnilx+PgAEFPaTZ0bV5RdcCj3k4VZepIHYSx1JFHDkjWWWdyw4xJ/5+xMA3bgOfqsuazP/SP6iwjy9hnlRslRIS3WtwW0/4Ri2IvaxpCnP11L0W4hhr4I2uA/4SSD4nMx7twfCUwL/scZ7I/wIcJVrKM5agD8J94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878064; c=relaxed/simple;
	bh=ian1HCmpPfMBUGbhu+jQ4O+bb5HKrZ6AOXw/FMWN82g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HzRC+VPAxHgudGjrRCpxsgFG9bnUheXPatHihyBNrtXdHuI5W8rxDKcMe6HxdwPjy0UOWIJ4QHZnvOaWIqM9VUO2HddZ6T+50JmQZQkr0P78W8FlKliObUK85+QoGwSIXvlfTbaaViQcJwnrF1qxK2ywxy9fR45pATzyo5lmI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RvVGaoma; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RvVGaoma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1H
	03rypn4InVAa1IkAxNLTiMpVkp1eKlHZ5j0/aYBYw=; b=RvVGaoma4qwAfeMYI9
	4P4FyPrj87JKYdSyhUbhIcsQ5m29oNlhYNRtyWAqmwDSqy54qCxt2edSnmEhVqxc
	LP1lBMlv1gXEQtBAzyaFY/UvU27xCfP/n04hU0m1jgvbyoU4f0ol+uW1TQQEaDhQ
	6VJw9i7BpiMInM72Hcb9OVQ1Y=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD322ftKEFpK8QMAw--.951S2;
	Tue, 16 Dec 2025 17:39:59 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	sched-ext@lists.linux.dev (open list:SCHEDULER - SCHED_EXT),
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: liangjie@lixiang.com,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] sched_ext: fix uninitialized ret on alloc_percpu() failure
Date: Tue, 16 Dec 2025 17:39:55 +0800
Message-Id: <20251216093955.2928453-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD322ftKEFpK8QMAw--.951S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13uFWkJrW8uw48AFWfuFg_yoW8Gry3pF
	ZxZw47tryUtr17K3WDAF10yF1UWw4xGr17Wa1kWrs0vr15Xrs2qa4jvF4avFyYkryvkaya
	yr1jkw1I93ZFkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jpc_-UUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbC-xDwEWlBKPCrdAAA3h

From: Liang Jie <liangjie@lixiang.com>

Smatch reported:

  kernel/sched/ext.c:5332 scx_alloc_and_add_sched() warn: passing zero to 'ERR_PTR'

In scx_alloc_and_add_sched(), the alloc_percpu() failure path jumps to
err_free_gdsqs without initializing @ret. That can lead to returning
ERR_PTR(0), which violates the ERR_PTR() convention and confuses
callers.

Set @ret to -ENOMEM before jumping to the error path when
alloc_percpu() fails.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202512141601.yAXDAeA9-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Fixes: c201ea1578d3 ("sched_ext: Move event_stats_cpu into scx_sched")
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 kernel/sched/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 05f5a49e9649..8ea243b04dc9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4761,8 +4761,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 	}
 
 	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
-	if (!sch->pcpu)
+	if (!sch->pcpu) {
+		ret = -ENOMEM;
 		goto err_free_gdsqs;
+	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
-- 
2.25.1

