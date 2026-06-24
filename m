Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DB3AC0C0;
	Wed, 24 Jun 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294060; cv=none; b=uhph5/ALKA7nk7o96JzeXyigY9OxL7C7B7VkTHIkhtWMGuPAkd53GqYhkZz1SIKct4u/p6JsWgL/01PVOJ3NU2RKiVr27oU5bIkjJZ7Rw9N2piI0rYG+UEpNaOTJ3Q6r3CBEylsr4TWfs8dEP20iCFU/gpGvbJOBiNyrDQ9SOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294060; c=relaxed/simple;
	bh=WtogDav7iLKN0XRE644mr+Eg2pdIJDhFYkvChApuJhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTdn7ubh6/E4LLMimUds7hDcPoC2PaGPGV1WyPmHEAYIpQi+84dThUlA7P0vGEUmKcH2cIvOIsPU5urnQUJq/SZRHxpgrHiTmOGJkSrQL9lJVpUbLxMTHlk57UAryuE/1REHyH3cma1D8Qzwt46HW4wXpXrMGTUMpMpsHm2cPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UbjSaNpy; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UbjSaNpy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UfOkfsueIOttzRBEgmVqLtFsTmLmnSnzTKLWrhgW4vg=;
	b=UbjSaNpyFX0tYsytqBODyB28ERANsfxdWuLxYHNL5dpdmLvRkuh3v+q4A2xZXCuiVgzW0YEJs
	mlac2BZXV/ji4vZmldxvC5jOKQbcnQ0jR6jU1tp0a9DCe4PXUXtlyD1UWdt8kqV6vph42spZI60
	HWHi9nDgBXL+EKjfz7WE0w4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4glcC30RpbzRhSc;
	Wed, 24 Jun 2026 17:31:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2053840538;
	Wed, 24 Jun 2026 17:40:47 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
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
Subject: [PATCH v4 2/2] sched/fair: Keep load_avg in sync after reweighting
Date: Wed, 24 Jun 2026 09:16:48 +0000
Message-ID: <20260624091648.271891-3-quzicheng@huawei.com>
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

se->avg.load_avg is derived from se->avg.load_sum and se_weight().
When the fair load weight is rebuilt while switching back to fair,
load_avg must be rebuilt too before the entity is attached.

Factor the existing reweight_entity() calculation into a helper and use
it from switching_to_fair() as well.

Link: https://lore.kernel.org/all/20260530050609.0D0FB1F00893@smtp.kernel.org/
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
Changes in v4:
- New patch.

 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edb11065a9fc..19270132a506 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4663,6 +4663,13 @@ rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vprot)
 		se->vprot = div64_long(se->vprot * old_weight, weight);
 }
 
+static inline void update_load_avg_after_reweight(struct sched_entity *se)
+{
+	u32 divider = get_pelt_divider(&se->avg);
+
+	se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
+}
+
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
@@ -4692,11 +4699,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	rescale_entity(se, weight, rel_vprot);
 
 	update_load_set(&se->load, weight);
-
-	do {
-		u32 divider = get_pelt_divider(&se->avg);
-		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
-	} while (0);
+	update_load_avg_after_reweight(se);
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
@@ -15005,6 +15008,7 @@ static void switching_to_fair(struct rq *rq, struct task_struct *p)
 	 * Rebuild it before the task is enqueued.
 	 */
 	set_load_weight(p, false);
+	update_load_avg_after_reweight(&p->se);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.53.0
