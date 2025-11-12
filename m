Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778821D3E8
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970917; cv=none; b=JGvZo43Sg/pwv94vzC1SWYKRJXN8gKlNB/mIlsZ4BZ64Zw6KGg8UkyY7aekToss+o/BEvWPlV1IB8L6Jl8dt3VRg2xSA9HJvUR+K7FcSCSpnuoFLMRTWGDjmSEDAO6whdNNQYcEvORIoxNFF8HfRhlvN5x91uc78JkGWWUdRDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970917; c=relaxed/simple;
	bh=SVjdf5Aj0rdJj6A5awPo5qb+JCAch7lvbTPIcP4rwcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pfujtwn9iGFOcbfIAkPXHp4IvXLYGyyZoGnfWyXNUcjZvIcDSA3lEVg84He8z+DN2zMUvUJyFu9sj5L+ZbmFdhBZPJEL61BNujH8ThINWH75ngZsNC6D1gSGv1FoTkZafGGa+16F6PiBj06vpSFGZqBycHFcjGGTiglfO20/3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QDQf8ylS; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QDQf8ylS"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACGQQu11246012
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 10:08:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Tw24IjkIpxorSSaLtl
	toXikyFgjIwYXd2FO9mDBuUdE=; b=QDQf8ylSJGe2UJKKhYhy2u94pxcno8IkaU
	hJ6UljUVfqVyb/kIGXc+ZrDnY69Wn8THGAx7zm9mXub9PUxj7Dbo2PM+ZJC4joj8
	LVrKqYAE/kHJTZJ/8m665/ht/HOP18KD8dp5NQup857qTMCn+ow4OlRtuIv3IU3R
	6lCFZThsDQWugPaNIzqWr52RH/P+aBWrZ0x6J8v/n4ptWOUxr/kq3sieS5niI7Q4
	E0QX/9nRX6McyoHJf7EKeP2cq2RcIqSMa92/sxJfs64zmNkirOAtzMAjuGCw3KPS
	dMT4bxYkPjl8tanvH7dDKyZkhR8AgP7HcyfdT9LmYAWv9B6udZgQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4acwrv0xwh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 10:08:35 -0800 (PST)
Received: from twshared125961.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 18:08:20 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id BC21BB794947; Wed, 12 Nov 2025 10:08:06 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <sched-ext@lists.linux.dev>
CC: <tj@kernel.org>, <arighi@nvidia.com>, <changwoo@igalia.com>,
        <void@manifault.com>, Emil Tsalapatis <etsal@meta.com>,
        Emil Tsalapatis
	<emil@etsalapatis.com>
Subject: [PATCH] sched/ext: convert scx_tasks_lock to raw spinlock
Date: Wed, 12 Nov 2025 10:07:55 -0800
Message-ID: <20251112180755.1701048-1-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8gkHWxc2a6OokChU11xvWNb-eONAMMzr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NSBTYWx0ZWRfXw+A2oF9FxjvO
 kA8HXwjyjbwNejqODQTxM5TERzNSJgn62Eo3sOqo+x4hAXV5U9vS9VTC6pLos5x9UszLY89+CMe
 7ggj0vtSdKF5gP9IFJyjXDPsLPrCqMCiltgbAOTO1/+vXTspb9cgOYOJZYrKCR6cq1d7JX1GUD8
 RYhFpnHYbMoU/KmD8SpMUGSGCIF+XT/ZZjUA5PX5SNFHl7SsMKDyJB14DIM2EWAUOY8+hwrBZZK
 gsdsWvVXTS/Eno1PvItQZjSQx2/wGewEWlZWz1OIrh0Vm35vVSh71ts1c6fiWnZtaRl7XtHuHVs
 qVhTq4l8iseDDZT14lV/3W/MvcXl6GJbxlndGOKun8QQraJq9Pjq1D4rbQrlEGVrwyLhmRlGPQA
 xEvIxUrchlDIcvTLMLQD5YoIdBqK+g==
X-Authority-Analysis: v=2.4 cv=Scv6t/Ru c=1 sm=1 tr=0 ts=6914cd23 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=SUdZJXW00YaEYDIkTfgA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: 8gkHWxc2a6OokChU11xvWNb-eONAMMzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-11_03,2025-10-01_01

Update scx_task_locks so that it's safe to lock/unlock in a
non-sleepable context in PREEMPT_RT kernels. scx_task_locks is
(non-raw) spinlock used to protect the list of tasks under SCX.
This list is updated during from finish_task_switch(), which
cannot sleep. Regular spinlocks can be locked in such a context
in non-RT kernels, but are sleepable under when CONFIG_PREEMPT_RT=3Dy.

Convert scx_task_locks into a raw spinlock, which is not sleepable
even on RT kernels.

Sample backtrace:

<TASK>
dump_stack_lvl+0x83/0xa0
__might_resched+0x14a/0x200
rt_spin_lock+0x61/0x1c0
? sched_ext_dead+0x2d/0xf0
? lock_release+0xc6/0x280
sched_ext_dead+0x2d/0xf0
? srso_alias_return_thunk+0x5/0xfbef5
finish_task_switch.isra.0+0x254/0x360
__schedule+0x584/0x11d0
? srso_alias_return_thunk+0x5/0xfbef5
? srso_alias_return_thunk+0x5/0xfbef5
? tick_nohz_idle_exit+0x7e/0x120
schedule_idle+0x23/0x40
cpu_startup_entry+0x29/0x30
start_secondary+0xf8/0x100
common_startup_64+0x13e/0x148
</TASK>


Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/sched/ext.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bbd7529fa420..4b1007e06e9a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -25,7 +25,7 @@ static struct scx_sched __rcu *scx_root;
  * guarantee system safety. Maintain a dedicated task list which contain=
s every
  * task between its fork and eventual free.
  */
-static DEFINE_SPINLOCK(scx_tasks_lock);
+static DEFINE_RAW_SPINLOCK(scx_tasks_lock);
 static LIST_HEAD(scx_tasks);
=20
 /* ops enable/disable */
@@ -520,7 +520,7 @@ static void scx_task_iter_start(struct scx_task_iter =
*iter)
 {
 	memset(iter, 0, sizeof(*iter));
=20
-	spin_lock_irq(&scx_tasks_lock);
+	raw_spin_lock_irq(&scx_tasks_lock);
=20
 	iter->cursor =3D (struct sched_ext_entity){ .flags =3D SCX_TASK_CURSOR =
};
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
@@ -549,14 +549,14 @@ static void scx_task_iter_unlock(struct scx_task_it=
er *iter)
 	__scx_task_iter_rq_unlock(iter);
 	if (iter->list_locked) {
 		iter->list_locked =3D false;
-		spin_unlock_irq(&scx_tasks_lock);
+		raw_spin_unlock_irq(&scx_tasks_lock);
 	}
 }
=20
 static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
 {
 	if (!iter->list_locked) {
-		spin_lock_irq(&scx_tasks_lock);
+		raw_spin_lock_irq(&scx_tasks_lock);
 		iter->list_locked =3D true;
 	}
 }
@@ -2983,9 +2983,9 @@ void scx_post_fork(struct task_struct *p)
 		}
 	}
=20
-	spin_lock_irq(&scx_tasks_lock);
+	raw_spin_lock_irq(&scx_tasks_lock);
 	list_add_tail(&p->scx.tasks_node, &scx_tasks);
-	spin_unlock_irq(&scx_tasks_lock);
+	raw_spin_unlock_irq(&scx_tasks_lock);
=20
 	percpu_up_read(&scx_fork_rwsem);
 }
@@ -3009,9 +3009,9 @@ void sched_ext_dead(struct task_struct *p)
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave(&scx_tasks_lock, flags);
+	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
 	list_del_init(&p->scx.tasks_node);
-	spin_unlock_irqrestore(&scx_tasks_lock, flags);
+	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
=20
 	/*
 	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
--=20
2.47.3

