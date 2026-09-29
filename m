Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACA3E0725
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651054; cv=none; b=iRyiDiYSMZBHXLopZmQFevX6JaWl7eVRXbjKYKCKQYCP+BXr+d7Wg5OxTjpcqaOkISd/OL1D6YhEal5IhysJ9Je7pvfvYUd3Vco4fkMwwPW9RFa7qkyAKKKMEYgQUDrokMdHXY9rtcOSUXSItzNvtAT/6qNjuQ4kP2JmRscCOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651054; c=relaxed/simple;
	bh=k6Q9Ugy2H8XSt2j/evkdLrrZlYgZvuoZoDmg+WqA2Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oeKoSUCishS2vocSMMHNRePBAD1PZhIMXO7X3gv2SmhVKGZGOb9LQtama4NYNMj0dWVhO9OyeR+5+caVXa4d8QVt7zeNGTiDJe0zL+IEX5rqQpDpwd4dIxo5H6KEsh0x6t0Mm+BLY7SpNNVgCk7XBD/vbWwGSI7fD1kVYpgTa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6caf3520bbb211f19a56ed5b684f684d-20260929
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0c7def89-41a0-48fe-9870-6a8be788afac,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:973169bfa7903bd3b1204ef97fe3155a,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|136|850|865|898,TC:nil,Content:0|15|
	50|99,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6caf3520bbb211f19a56ed5b684f684d-20260929
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1690560105; Tue, 29 Sep 2026 11:04:02 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH v2] sched_ext: Count cap-rejected local DSQ inserts in SCX_EV_SUB_REJECT
Date: Tue, 29 Sep 2026 11:03:56 +0800
Message-Id: <20260929030356.3454280-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260925070500.565561-1-luoliang@kylinos.cn>
References: <20260925070500.565561-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

When a task is enqueued on a local DSQ without the caps its enqueue flags
require, __scx_resolve_local_dsq() has three outcomes: admit the task
anyway because the rq is draining offline, the task is migration-disabled
or a migration is pending (counted in SCX_EV_SUB_FORCED_ADMIT), divert it
to the rescue path when the enqueue requested rescue (counted in
SCX_EV_SUB_RESCUE), or divert it to the reject DSQ to be re-enqueued so
that the BPF scheduler can re-decide.

Unlike the other two, which require a draining rq, a task that cannot
migrate anywhere else, or an explicit SCX_ENQ_RESCUE opt-in, the reject
diversion has no preconditions: every other cap-missing insert lands
there. Its traffic is currently not visible in any counter -
SCX_EV_REENQ_REPEAT only counts it once the same task fails its
placement again, and nr_rejected counts tasks refused by ops.init_task()
through task->scx.disallow.

Add SCX_EV_SUB_REJECT and count the reject diversion so that the events
cover all three outcomes of a cap-missing local insert.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>

---

v2: Rework the rationale in the commit message and drop the Fixes: tag
    per Tejun. No code changes.
---
 kernel/sched/ext/internal.h | 10 +++++++++-
 kernel/sched/ext/sub.c      |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 0bcceab612de..36da1a6560db 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1308,6 +1308,13 @@ struct scx_event_stats {
 	 * caps for its cid and the task entered the rescue path.
 	 */
 	s64		SCX_EV_SUB_RESCUE;
+
+	/*
+	 * The number of times an insert lacked the caps for its cid and was
+	 * diverted to the reject DSQ to be re-enqueued so that the BPF
+	 * scheduler can re-decide.
+	 */
+	s64		SCX_EV_SUB_REJECT;
 };
 
 #define SCX_EVENTS_LIST(SCX_EVENT)					\
@@ -1331,7 +1338,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_SUB_KICK_DENIED);				\
 	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED);				\
 	SCX_EVENT(SCX_EV_SUB_CIDPERF_DENIED);				\
-	SCX_EVENT(SCX_EV_SUB_RESCUE)
+	SCX_EVENT(SCX_EV_SUB_RESCUE);					\
+	SCX_EVENT(SCX_EV_SUB_REJECT)
 
 struct scx_sched;
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 10567196be96..3429b84f319a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -748,6 +748,8 @@ struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq
 		return &rq->scx.rescue.dsq;
 	}
 
+	__scx_add_event(sch, SCX_EV_SUB_REJECT, 1);
+
 	p->scx.reenq_reason_caps = missing;
 	p->scx.reenq_reason_cid = cid;
 
-- 
2.43.0

