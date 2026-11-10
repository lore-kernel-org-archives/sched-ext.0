Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315110;
	b=AxBf8pmI9tJvgAHGUVaCkKv96N+pT39zzFDWM4ilR6x1VKBuIqc8Paf33JUL2Fj2+un4
	 sLkMBjonX9fFG7zS5QH42SISZ6unYu8Qj1qEpuaD++svQKw6/4CIXMD8Zps2ftPamagkW
	 M8QzEhabLcpdKN6km9WikWoXJqV6FRgZn055/R43b8HP11YNZQ14K+axUswOk5r/MtILw
	 DVlm1hiP9PZrf7hYCYyflyMh7L1oX6xppueeUOBwz50yeTpuB/PAR2NoAelQF6rHpTUyW
	 A9fRylOZ5HDe+sspFZtqQIOjzz/6uKQM5s7o1sITh/b4UYQ82F5kY9fN4ZXdf+ZuA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315110;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=pnvsCaZarFR934HQcBQJbElxQDjkJzNi2diqewrEMhg=;
	b=UjMsCnIHXYiCppWPAnglL3cn7nc8nxGjtfFvegJVbyVExyKSghRp74AMGxjPbUOZGGZd
	 +Z4sSR+Bqre1E+yWAZeRgoT1pi9LT+qKtCraGpWb7zNnfDvk+lXGHQcmaaZc363hnc8Ke
	 MnV/cihX1d1JbyikDFL6GS76dtEj5aj68ro9mSj3T6FiMuj8PAYR2wNzmBsn1oXbpEKnR
	 //qVeDjTC4xSPd4AD+Cm80PGwxj1vKKm8X/LI2PpzHmJnnTw44ssYfzdtu+Ou7zHkvcad
	 nY0JgeTBJPLNljW1lgUHMSR6CCKcCLkETzBJXrnaX/8gYPI/LVffTP4YP5rmCS3veEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=ixawTO8b;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4760A3834
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC4760A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=ixawTO8b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794315080;
	bh=pnvsCaZarFR934HQcBQJbElxQDjkJzNi2diqewrEMhg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ixawTO8byEIq2YYHy1lSYuF6NvK8R3YntTnrGkSIK9aBFuYvPjHkX2ulGaJz8VzAz
	 IOo897Y6XpXrZCYGoKpSyK1I6la+o44VXISJ6ZWjfTZW29UIwhoKe1WVHFRFGVM1di
	 sxiYK5RSizlzV7QxbJSCU58kAj4RKdoDceT5oun4=
X-QQ-mid: zesmtpip2t1794315075t461bbcd2
X-QQ-Originating-IP: zChssD5jjodbbDQewedjB0i9rLy8xA/BmneST00wK9U=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 20:51:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13638721071040344329
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: make DSQ iterator stay drained after NULL
Date: Tue, 10 Nov 2026 20:51:13 +0800
Message-Id: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MACXe2l6e7j9GH6PDCqUC4TKYU4Iuhqytqh0o8dj2C6gMOY0DQ6j7l4E
	IYw+RgPPGU0Bbg0V8QjWPOh62J82yLbWEcXw33OR/tSj0CLZq9WidHLkhinpFkPvV/g9jBZ
	XFiaqCAOYEahsLlbrC5KjIv893bEiMo68s8twJA1xIF0B3MHqNuaj+8UuMN/6mDbH/DjMJU
	QrzfXxLUEkSbl8K48WohlZ4WF4UBZK91SlAmegQZN5t5JLU7DqRDXjpHT+TFH0TCIjUc7E3
	6l84HACX6X6vseoQTHhRaLeU6FIg2vyjeN7/AVamv1Hh7Cmt/fjiFUI7i1BdH9Y82WJrcR0
	bFbK/Qf64uvfupw+8d0SwN2i8MDD7y46Np2f0RaBlq/oYVSoP7kj3JD865VIWuxhmT4wmSc
	bdBkw5vavKUiSml9aVFzlkst/ndyDqXa5p/CRXUxMIRGJ2foU9PQO8CghSNCUveUAaPqaZk
	KAZG+1DWBHLwvTcw2mulidq4PDHQXyjtqal+RQ1lPJ+0zmQC/bPgspijnnYhkK1NswEMtoC
	GF90poezJJ1StRGcQ0TXHDn9m0ns1LyV4xpgy6jrB+IzKAOSwPw5zoUvB2BXvlTsBASIDCx
	dd2vm46Hnz8jffjhfohse3mhUQG1RnAbtVxA3ZhJXCA80cnB28Jw46aBk4agqEWwgFktbw8
	YNR7uAt2HO4nPFlSxa4+NV0Kx83W/cfKPYaSWGFdOmNA/3Y1Mb0ccmDSL8pom1eQChKFF92
	+2q+A1K61WXgbrRsTOXbfzLYtQARZIk+WmRv0nDZDn60iTwaJO6jS9k9RQMLG8r4updxayR
	TdS71H3s/d7ICmL0efYFZbCNIfe0diRCbZ92UiM+TwSrjJppMo2zyTYek9uytwWPEkfPXdE
	ZFkBWd4OuvHWvDMkU4dDr7icwTorvKG6vn4Hm5s4FXCrwUnpNfeO7siFBEePS4nnIMNG8KV
	xoIylEIsf0U/Q6VY9fatehA4BhDTbzheQ0MoE/zGdtzA1Fft/lLjh+n1WhN0jWI3bZplSlf
	IYafDugg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

nldsq_cursor_next_task() unlinks the iteration cursor when it reaches the
end of the DSQ.  A later call sees list_empty(&cursor->node), starts
from the DSQ head again, and returns the first task of the same
iteration.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted DSQ iteration therefore hands the BPF
program a task pointer while the verifier believes R0 == 0.

Remember the drained state in the cursor flags and return NULL on every
later next() call.  The cursor has spare flag bits and the BPF-visible
iterator layout is unchanged.

Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 kernel/sched/ext/ext.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9bae826d69f9..03e0fbf17011 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -555,12 +555,14 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_DRAINED		= 1U << 28,
 	__SCX_DSQ_ITER_HAS_REENQ	= 1U << 29,
 	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
 	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
 
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
 	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_DRAINED |
 					  __SCX_DSQ_ITER_HAS_REENQ |
 					  __SCX_DSQ_ITER_HAS_SLICE |
 					  __SCX_DSQ_ITER_HAS_VTIME,
@@ -10615,13 +10617,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct task_struct *p;
 
-	if (!kit->dsq)
+	if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
 		return NULL;
 
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
-	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	p = nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	/*
+	 * nldsq_cursor_next_task() unlinks the cursor and starts from the DSQ
+	 * head when it is called again.  The verifier relies on an iterator
+	 * which returned NULL to keep returning NULL (see
+	 * process_iter_next_call()), so remember the drained state.
+	 */
+	if (!p)
+		kit->cursor.flags |= __SCX_DSQ_ITER_DRAINED;
+
+	return p;
 }
 
 /**
-- 
2.34.1

