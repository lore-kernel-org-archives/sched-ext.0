Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96821FF4A
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123591; cv=none; b=sOLAo3wr7TBJHnt6GrspmyUo3tCec3pNbr7ia1x67+TacKtirYtfRrBZZlylmAoMqtJ4ggQs6p+mKLMbFtl3WdUk7T0HC9nTF6z2jBpf7AGS+ZPMnIKdxbh8E4r6KGr4Z4S6qMYkWPO91mj/4Zy6c7C2NYN75zw8wWlayzcEKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123591; c=relaxed/simple;
	bh=yE00MB3WL8ptxHCRXCgfw/UvllrE82Y4Mae73pk8QXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yl/GH1MtlCajrOoNN6IeLY/pjludmYgaTvlX84YDAaxKDaZ5HrZ1HHNTzenM68V9XT3UFfz6CroxxhfUMD4hR7i5OwNY7U38/As8lqkoKGB36/60v01A+7Et8g9BPk46kq2aV8bxroTH861sXSgZaFiBW2y3QMtd5KS+S/SNfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KosCwuer; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KosCwuer"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59AH8XIn338929
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 12:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=tWqidGIJJyNYFSekDo
	LbAQaMx+Yyz7lrxgyC+vkveC4=; b=KosCwuerQk10y8IVU7Jm1pc4hrw2o/S66M
	2Dj8Tg3zU1iBg+TrK+bsPc/mJ7TPTqAXeakYvPsEYQr4/AbaV+SWEOhqdfsT33tg
	CVpQg3kzsfgjooOgtH0kp8p+p0r+xnrqgMSQMWB8w9xKn0vH3e5hvz4keS15STjT
	+UBi7kYwtI29aaVa6ZZKWvenEe8UrTks0nlqM1kgCighAVIOHMo1x0o+9Ojsrzv6
	EHAgnwYBOzo1xDBEpqeBhmnJsKYgqpiVFTZNd2jZRjDlpGZNeYBgbKs1Brr9243M
	ZBs63qKYj6+LfhMw/TN3N5u6p2PjQX+l9jNa+fvmGCTaD9MlrW3w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49px76mjj4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 12:13:08 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 10 Oct 2025 19:13:05 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id AF3208F16465; Fri, 10 Oct 2025 12:13:02 -0700 (PDT)
From: Emil Tsalapatis <etsal@meta.com>
To: <tj@kernel.org>
CC: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
        <sched-ext@lists.linux.dev>, Emil Tsalapatis <etsal@meta.com>,
        Jakub Kicinski
	<kuba@kernel.org>,
        "Emil Tsalapatis (Meta)" <emil@etsalapatis.com>
Subject: [PATCH v2] sched_ext: defer queue_balance_callback() until after ops.dispatch
Date: Fri, 10 Oct 2025 12:12:50 -0700
Message-ID: <20251010191250.3821639-1-etsal@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDExMCBTYWx0ZWRfX23SmZMqWDuyV
 KCjwcNNnmLdDK0RdSzBo5a+K0CcKOxstKZGWdtGjsH5Tfrd+0gIHOVguyflr75m4JuJrLWPnhJX
 Y1cdNTh5M/pEFPHyhj4bh7WoPWPixZn/Id039hICs5HpP8TaApvQo13UVAr6G20R58hJglukAfG
 Czu9/1A+/TjYuo9wI4IZ8Zn9USKbx+8d6vhb4iU900z5oTlxSlJY1ctTQ2HdRdL149NXatznT20
 uXZc62JIjOvKNj9dtxcA9pT0TXbRKVWmT+API+D5oRQEr4lga7/GcgixAGatyn8OMDWWnuDIQ1h
 Uh4+oXqEcmLTayIOfD6b5Swl4y94ylMJv1QWQOwsrqwmAVQbU5Va14CF2iT6qHvItSF6ILE1WCV
 v4hhxCVofM8X5dhx1HhGPsBKu4k7tw==
X-Proofpoint-GUID: AjUcXxpXqFkmsE8k7NCQ29tOzDfcY2_5
X-Proofpoint-ORIG-GUID: AjUcXxpXqFkmsE8k7NCQ29tOzDfcY2_5
X-Authority-Analysis: v=2.4 cv=R68O2NRX c=1 sm=1 tr=0 ts=68e95ac4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=CWErhr8FAAAA:8 a=Ikd4Dj_1AAAA:8
 a=XZtH-_9ENN-ZvTYtSVgA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01

The sched_ext code calls queue_balance_callback() during enqueue_task()
to defer operations that drop multiple locks until we can unpin them.
The call assumes that the rq lock is held until the callbacks are
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

Changelog

v2-> v1 (https://lore.kernel.org/sched-ext/aOgOxtHCeyRT_7jn@gpd4)

- Fixed explanation in patch description (Andrea)
- Fixed scx_rq mask state updates (Andrea)
- Added Reviewed-by tag from Andrea

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c   | 29 +++++++++++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5f957cff5d17..706d010fd522 100644
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
@@ -2003,6 +2013,19 @@ static void flush_dispatch_buf(struct scx_sched *s=
ch, struct rq *rq)
 	dspc->cursor =3D 0;
 }
=20
+static inline void maybe_queue_balance_callback(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (!(rq->scx.flags & SCX_RQ_BAL_CB_PENDING))
+		return;
+
+	queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
+				deferred_bal_cb_workfn);
+
+	rq->scx.flags &=3D ~SCX_RQ_BAL_CB_PENDING;
+}
+
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_sched *sch =3D scx_root;
@@ -2150,6 +2173,8 @@ static int balance_scx(struct rq *rq, struct task_s=
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

