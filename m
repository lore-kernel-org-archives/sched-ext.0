Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE135351C04
	for <sched-ext@lists.linux.dev>; Thu,  3 Sep 2026 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407850; cv=none; b=Ns+PrEc9NhwjoNny7/1A6DunklAVJcVR91uGPRfVp7mLG1GPvyzu6eabbCNZMk0R2nHr1K0lHZRMEycH0+gzzBUdWiG7LOlzg+g0zW40NEAsmAYbNw+UAgV4CP9Pv9AvEyCcnANJ5MaDihWxeuS8xkCm0+oBGJqV6PkOqUyk0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407850; c=relaxed/simple;
	bh=R8MCB0fZPp2kqpX8SMDkl8QbZkpnPzGATyB+nbfhggY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GM0OPYNcMp8ql4OmoNDWv47xRjcdXyTdgwlS3oXnxAhDz2g5Wi7z1QHVJTRjubn41yI0hHq6BjwQajMrnSCYpFCYsXzYSvEZ/bUa3vG5/KFMYLxKExtquoQSR7aQf0Z4TMxYKrDql712YVvpu/nE6/kxiFlRqpp9as/XxnE0lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 91e76e82a74b11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:155ee8e6-6ac1-4a87-8f4c-bfc556ebb13e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:585e62760e82be758c00727469015eda,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 91e76e82a74b11f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1093751082; Thu, 03 Sep 2026 11:57:23 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liwanwu@kylinos.cn
Subject: [PATCH 1/2] sched_ext: Make scx_locked_rq() return NULL from NMI
Date: Thu,  3 Sep 2026 11:57:19 +0800
Message-Id: <20260903035719.721445-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903032953.659847-1-liwanwu@kylinos.cn>
References: <20260903032953.659847-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_locked_rq() reads the per-CPU scx_locked_rq_state, which tracks the
rq locked by the context running on the CPU. Tracing progs can call
kfuncs from NMI, and an NMI interrupts - rather than replaces - the
context that set scx_locked_rq_state, so a non-NULL read from NMI
falsely tells the caller that it holds the interrupted context's rq
lock.

Three "any"-category kfuncs read scx_locked_rq() on their success path
and take an unsafe fast path on a non-NULL return:

 - scx_bpf_task_set_slice() writes p->scx.slice directly, racing
   update_curr_scx()'s non-atomic read-modify-write of the same field.
 - scx_bpf_dsq_nr_queued() resolves %SCX_DSQ_LOCAL to
   (scx_locked_rq() ?: this_rq()) and can report the interrupted
   context's local DSQ length instead of the caller's.
 - scx_bpf_locked_rq() hands the interrupted context's rq to the BPF
   program, which may then operate on it as if it owned the rq lock.

Make scx_locked_rq() return NULL from NMI so that all three take their
unlocked paths: scx_bpf_task_set_slice() stashes the request into the
atomic p->scx.slice_oob for application under the rq lock,
scx_bpf_dsq_nr_queued() falls back to this_rq(), and
scx_bpf_locked_rq() reports an error and aborts the scheduler through
the NMI-safe exit path.

The kfuncs that take scheduler locks reject NMI calls through
scx_kf_allowed_ctx() before reaching scx_locked_rq(), and the internal
callers only run from struct_ops callbacks, which never run in NMI, so
no other caller is affected.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/d84b31727f04e1ed0d40042ba1c09e61@kernel.org
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 kernel/sched/ext/internal.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a67277b0fee6..809e0ee0fd5f 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2218,6 +2218,15 @@ static inline void scx_schedule_reenq_local(struct rq *rq, u64 reenq_flags)
  */
 static inline struct rq *scx_locked_rq(void)
 {
+	/*
+	 * Tracing progs can call kfuncs from NMI. scx_locked_rq_state tracks
+	 * the rq locked by the interrupted context, so a non-NULL read from
+	 * NMI would falsely claim its lock. Return NULL from NMI so that
+	 * callers take their unlocked paths.
+	 */
+	if (unlikely(in_nmi()))
+		return NULL;
+
 	return __this_cpu_read(scx_locked_rq_state);
 }
 
-- 
2.25.1
