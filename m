Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBB245010
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031407; cv=none; b=rgudQnF909kjRZ0PEkwD2zfSQ9p8OMDw4OyEMsKfbngXEcatNofhDoasjqjQ5Fr9i63M19qmilTmkH37Q/7fAnvL2xx33SUth6DFlmmhcKQXvzDncxYHHCnmy0bRvJhCiw9bc6F3pmlhIAx4CpxnWkSJlQPlkTs/yhj87jpgv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031407; c=relaxed/simple;
	bh=67eXXDfLutMJhSrLMe/KQHnpVp368mVPnH+4wKhxt5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEUeCqzvf5dGJdCm9a3mIweRCmdYizMjKsOR+7+QZw3j/vKvI0+fPXuOMy0fMmpkiAaJqFJIbSEbHuZgb56VW2yrFsLkC9PXzUGEl3Aqn+MdVJvu7vo5SUfY8GXUPDxz2kd6zty8E5VKvQUOcNT8la3UE3a9QVwOilnk/iIIVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gclhPILK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gclhPILK"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 599Fxq0M3581520
	for <sched-ext@lists.linux.dev>; Thu, 9 Oct 2025 10:36:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=yzNqkOELZBQ9DBZHBq
	JTqhHFlquSk5m/8WqpiPIeGx0=; b=gclhPILKP2WD6OJJleS7xVKYK68cW09X2s
	bP4PEQE24mvLD92KPqiKCc0nar+73a9d5rEJRGpMOQHYGqK/njQJNJnnR2UVb9L1
	UKMN85Re9oDI0LocKUE+8LRX5zSgAScDSNW6hMl5fsf5b6V2SrHPLmz4a+6XEt4H
	g1zhvCAKRTL/W+uMJyAPQxqTbcL9reI/1RdWxgQJnZn6v7CVsowQsNwJe9zQi1c8
	Zm4UBJjgD7fOd5JeFNqFZW1nFt4cUOqxjhjDwZZwbL9pog+L3NggpJwzPgpyOh+p
	QEdV/82/2uqUEEFOWJPpvQYGKQQXmw7cFIrSOcU5AmnWg1PSOO9w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49p9vcv5c6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 09 Oct 2025 10:36:44 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 9 Oct 2025 17:36:39 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 8559C8DC52FE; Thu,  9 Oct 2025 10:36:25 -0700 (PDT)
From: Emil Tsalapatis <etsal@meta.com>
To: <tj@kernel.org>
CC: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
        <sched-ext@lists.linux.dev>, Emil Tsalapatis <etsal@meta.com>,
        Jakub Kicinski
	<kuba@kernel.org>,
        "Emil Tsalapatis (Meta)" <emil@etsalapatis.com>
Subject: [PATCH] sched_ext: defer queue_balance_callback() until after ops.dispatch
Date: Thu, 9 Oct 2025 10:36:20 -0700
Message-ID: <20251009173620.1882642-1-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDEwNiBTYWx0ZWRfX6VISWt4eHECE
 F+Y6uc5eA91j7+rT67FEWqY79wpqLvxWL+hRJFpZ8t2b8OR+2iEp36WcbdtT58LqsTN80I16vDj
 geY6ViqFOs0Ubc2svVsXGlUHuuQ6bYLzzL97q0h2efLBjkvyWE+e1ieNK+qbthrOnI6Jdbu4E6Z
 B2N1u06ZhZc7RNSJLpvCi3Ly9jpUqM6ccFQOtKAhljZjHFXhAcsiE6U68Ge7y+3cBTvFs57SzRh
 XRlb+A3/fSlkUXewu8AosfMZsH+5ZFl7mGETI3+SUG25iWFmgR8gdzD4PXapo/g4/PPTzkTCbRP
 tzXaBAt1NJc3rdbbtD6Z0o2bN46nyCZoptW1LqviKuuBMlJa/+bOtY6pmZ1mS77miBOVjpeHZT5
 k8RF8kV6inCG6DFmHLbUn22A8Y/Fog==
X-Authority-Analysis: v=2.4 cv=E+bAZKdl c=1 sm=1 tr=0 ts=68e7f2ac cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8 a=ugpJW7kVbK6_yBFAyCQA:9
 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-GUID: h6j4Nm-w8sTi070pZdlnL08yc85e-ne8
X-Proofpoint-ORIG-GUID: h6j4Nm-w8sTi070pZdlnL08yc85e-ne8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01

The sched_ext code calls queue_balance_callback() during .balance(),
to defer operations that drop multiple locks until we can unpin them.
The is call assumes that the rq lock is held until the callbacks are
invoked, and the pending callbacks will not be visible to any other
threads. This is enforced by a WARN_ON_ONCE() in rq_pin_lock().

However, balance_one() may actually drop the lock during a BPF dispatch
call. Another thread may win the race to get the rq lock and see the
pending callback. To avoid this, sched_ext must only queue the callback
after the dispatch calls have completed.

CPU 0                   CPU 1           CPU 2

scx_balance()
  rq_unpin_lock()
  scx_balance_one()
    |=3D IN_BALANCE	scx_enqueue()
    ops.dispatch()
      rq_unlock()
                        rq_lock()
                        queue_balance_callback()
                        rq_unlock()
                                        [WARN] rq_pin_lock()
      rq_lock()
    &=3D ~IN_BALANCE
rq_repin_lock()

Reported-by: Jakub Kicinski <kuba@kernel.org>=20
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/sched/ext.c   | 28 ++++++++++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5f957cff5d17..35dfce06297a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -780,13 +780,23 @@ static void schedule_deferred(struct rq *rq)
 	if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
 		return;
=20
+	/* Don't do anything if there already is a deferred operation. */
+	if (rq->scx.flags & SCX_RQ_BAL_PENDING)
+		return;
+
 	/*
 	 * If in balance, the balance callbacks will be called before rq lock i=
s
 	 * released. Schedule one.
+	 *
+	 *
+	 * We can't directly insert the callback into the
+	 * rq's list: The call can drop its lock and make the pending balance
+	 * callback visible to unrelated code paths that call rq_pin_lock().
+	 *
+	 * Just let balance_one() know that it must do it itself.
 	 */
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE) {
-		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
-				       deferred_bal_cb_workfn);
+		rq->scx.flags |=3D SCX_RQ_BAL_CB_PENDING;
 		return;
 	}
=20
@@ -2003,6 +2013,18 @@ static void flush_dispatch_buf(struct scx_sched *s=
ch, struct rq *rq)
 	dspc->cursor =3D 0;
 }
=20
+static inline void maybe_queue_balance_callback(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
+		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
+				       deferred_bal_cb_workfn);
+	}
+
+	rq->scx.flags &=3D SCX_RQ_BAL_CB_PENDING;
+}
+
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_sched *sch =3D scx_root;
@@ -2150,6 +2172,8 @@ static int balance_scx(struct rq *rq, struct task_s=
truct *prev,
 #endif
 	rq_repin_lock(rq, rf);
=20
+	maybe_queue_balance_callback(rq);
+
 	return ret;
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..8f3935785fc5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -757,6 +757,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_KEEP		=3D 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	=3D 1 << 4,
 	SCX_RQ_CLK_VALID	=3D 1 << 5, /* RQ clock is fresh and valid */
+	SCX_RQ_BAL_CB_PENDING	=3D 1 << 6, /* must queue a cb after dispatching =
*/
=20
 	SCX_RQ_IN_WAKEUP	=3D 1 << 16,
 	SCX_RQ_IN_BALANCE	=3D 1 << 17,
--=20
2.47.3

