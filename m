Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7142849F
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010983; cv=none; b=Kj5g9iyAJScmhmutBpqnlFU9qDpbjUMzrOrraFc2nssRa8YtZ7/L3khDVZOapqtUE46RT9eMsE6HitfFRNbrBk/VF5nBmlYJFZPPRnSZgfCWsUJudNAXK38ip3ZfaWOUOvHBjOeAxWGQE4OLRwMZ+iFRuO+/6Ow9KPds4vfEFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010983; c=relaxed/simple;
	bh=PcU6VNAvh43K2EcSWdHGH0gTAGl3INnGhpZduqtmXHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDFGN60WtFYAGvNTgniofLbV9yIxgfC9Ce3RPAylDqTZzprdUTI+alOyef5A71bcU7JObHCsDFKpYzGVbe9OXVL/nU1u5OLlUh8/JhiX1dgR4YyIuCcVZdHkHGhHabQql3vU1vmixGD1GDf/H3ahFZcxxIqNKPHvbmFUP93XdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iGILqUe5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iGILqUe5"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LDLQMg2826258
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 07:56:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=FjlymfLqklh2maG5V6
	f1jBGqedD5PWTW0PsD/kntaVw=; b=iGILqUe5fDXRgZyQsrJyr0xN9pW13HQFat
	7Sfws2WZLt0orF3Qdd7WsV3sQ55P/ZtKapqekW8eJ9pu0CM5Cwmxj93ylcvUORss
	eFL0H9lcqpjZyOldEoQkhQhzTwaSbRuLt+lPTS3yD9eWZKdZFihDXUMaqrz/tzxy
	LisO462ZXhrSBAv65NGzyVwa6eXVWSW1JlBQaniJX1ww9ua4c6HDBRaE3eRAbQNB
	HGp8CflpSG25U6CYEN/PuNeVKfQs8rS9S0Kn9LiN2JiMuMDYTVFufjbNtlzI0uHD
	05zlEFzX40c6mg9h+cVlpltuBYDH2De6MxpgUfdxKZOIA06/0/ug==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4btkamngwv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 07:56:19 -0800 (PST)
Received: from twshared6524.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 21 Jan 2026 15:56:15 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id A4A913C4F6B0; Wed, 21 Jan 2026 07:56:03 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: <tj@kernel.org>, <void@manifault.com>
CC: <arighi@nvidia.com>, <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH] sched_ext: Clear direct dispatch state on dequeue when dsq is NULL
Date: Wed, 21 Jan 2026 07:56:02 -0800
Message-ID: <20260121155602.598130-1-hodgesd@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEzNCBTYWx0ZWRfXyiQWPZj2jWea
 aJAatbjbF2tkctdAE9Wwphv2/pW3ct8c1ubmhKY9rncVi4RZEsVEOuYcwefcAiTZGLBTpaGPqau
 gc3s5PAw88HRb4482X+Emo+NHgtRkST3PjY17ePY820e7G96v5zIJKCEnOkd0gKb/PAD4FYMxdy
 XIvbkhesDbHyKL8Cy0+FC489JWDN78rSbBooe8F530W+Wb6pgbhcQrLB+I3/cjEE8Fl5Lyey5yS
 AOp80ydy6SY9FEgy+6cIDWSX1IXCBhcWmwb195LPrk/9yvEM3dSf22tpwd/fAKcuUKzQitiwRft
 cMnkv/OpxllnlIgnrrfgpgsqRTDd9VW0Q8UQbOhGfJkhNLfW5Yb5c5iFRs7HJHtGCZioBgoc4D3
 9aIOuu7gPmuNOmh2l5hFFuigP+WbC0MVaLXj9y+YHlIJZCXBQ4gSmAleZ9T33JJIdZ3HiiqGdOB
 XQpxQgM3QUnCJlLVzUg==
X-Proofpoint-ORIG-GUID: YgwnKh0_w1SMmtZlFePnlQlSfUkPQljX
X-Authority-Analysis: v=2.4 cv=YbGwJgRf c=1 sm=1 tr=0 ts=6970f724 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=iEjLA4A8eM0iqIfbA4EA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: YgwnKh0_w1SMmtZlFePnlQlSfUkPQljX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01

When a task is direct-dispatched from ops.select_cpu() or ops.enqueue(),
ddsp_dsq_id is set to indicate the target DSQ. If the task is dequeued
before dispatch_enqueue() completes (e.g., task killed or receives a
signal), dispatch_dequeue() is called with dsq =3D=3D NULL.

In this case, the task is unlinked from ddsp_deferred_locals and
holding_cpu is cleared, but ddsp_dsq_id and ddsp_enq_flags are left
stale. On the next wakeup, when ops.select_cpu() calls
scx_bpf_dsq_insert(), mark_direct_dispatch() finds ddsp_dsq_id already
set and triggers:

  WARNING: CPU: 56 PID: 2323042 at kernel/sched/ext.c:2157
           scx_bpf_dsq_insert+0x16b/0x1d0

Fix this by clearing ddsp_dsq_id and ddsp_enq_flags in dispatch_dequeue()
when dsq is NULL, ensuring clean state for subsequent wakeups.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class=
")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 kernel/sched/ext.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b563b8c3fd24..fdfef3fd8814 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1143,20 +1143,28 @@ static void dispatch_dequeue(struct rq *rq, struc=
t task_struct *p)
=20
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
 		 * @p->scx.holding_cpu may be set under the protection of
 		 * %SCX_OPSS_DISPATCHING.
 		 */
 		if (p->scx.holding_cpu >=3D 0)
 			p->scx.holding_cpu =3D -1;
=20
+		/*
+		 * Clear direct dispatch state. The task may have been
+		 * direct-dispatched from ops.select_cpu() or ops.enqueue()
+		 * but dequeued before the dispatch completed.
+		 */
+		p->scx.ddsp_dsq_id =3D SCX_DSQ_INVALID;
+		p->scx.ddsp_enq_flags =3D 0;
+
 		return;
 	}
=20
 	if (!is_local)
 		raw_spin_lock(&dsq->lock);
=20
 	/*
 	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_* can't
 	 * change underneath us.
 	*/
--=20
2.47.3

