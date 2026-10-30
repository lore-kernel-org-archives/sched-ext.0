Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370220;
	b=Ttd5w8i7iaBXfBlHnbIrVnz/GVg1fO2sPznVlR9/m2/jnBm7KEl2YbNG7eIitzZFfDnG
	 InLleO3GiZXDQKGB5A/TA1/EjN4lf4DrSaTvMeuOHcxNDdhqAUuF2HMZfMH/UOi8W9eKU
	 uXSh+h0REIlmVQfpvqfTLDPYdxi1lUcdA6dfm1pMeMZ9r3YzfvS4sKL2wfW8Qb8ZGNfNK
	 /08VWhfwLvxCu8aCnOL9DRIrH1c4QEX+uqdi2bZycwqfCugMe7Yu/rVIkdnorcgLTAFDZ
	 4/HK99CskdmqhPgHEwugPNHfUF4R3DhSkIQNQyON65IO5oliQhCtv8sFVCyZrPXuTlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZEQg28jwro3K5L2KhzngzVzraJ2WGxfB9b1+b0RvAeM=;
	b=o2xf3cPKFc2VCNKCEdhsk5gPgW037/322y/GIiwQku3e+PT++obURZhqqRKI5Q6EUF9G
	 5sr6rpOO/5ICcbYxIHOfST0ZR3++YxicjJeZrSvnDUqlAYa/YsITB+SmLVLPq+LpccnhJ
	 l431maXO4jWRg5Xom31uuY7sI2PXYylQ9bHysl1JrHDIiY4pfaYEu3+zpsWDU4kC0iwBt
	 u/96SjhCDzsLH/1GHBl1wcJyReaoGzrVVgaqpOWQmgTFz5e4FfNDLhzXwKDV34ir2tTxK
	 DLo9c8/fEZIGD1QmZQ0yK4qpgol20f1h6d/OqD6Vq/qrMlWpMB33KKqUTsCCvy2t1sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQ9+hrZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0D606A31C;
	Fri, 30 Oct 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQ9+hrZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324A1F000C1;
	Fri, 30 Oct 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793370219;
	bh=ZEQg28jwro3K5L2KhzngzVzraJ2WGxfB9b1+b0RvAeM=;
	h=From:To:Cc:Subject:Date;
	b=gQ9+hrZ3y+eFjTvNJhcvd8JIeJjJbZIJeJ3qherhyoFzKzEa9gk8W1BAI3ex3kvfF
	 rKtfmwUP+HsuJtHEsCxx+iVLrhG05Ghizm9JgMX33g5VZSLsIUwOg/CgysmcOfNvUL
	 IdZcFYUcx8cuIROnkgNUTXRB9J4+1q2yx6ihhXw2FkKpGukRFpro/TcRz+tdgvH12j
	 s2rJ2neAc63q5h4vT5IuMROQR9e2sd8XlQcJuaSecFLxn+Nu35GnpE8aXSiJ5gVISu
	 KaDtXmIFdJxLrsTz4LM5BmIyf2DVtWcfeu579E8uhve5uMrtwofJgC8dy77p3MckZf
	 SiC4kOpapQZNA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when a wakeup resets the donor during dispatch
Date: Fri, 30 Oct 2026 04:23:38 -1000
Message-ID: <20261030142338.3453484-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

With proxy execution, do_pick_task_scx() passes rq->donor to dispatch_one()
as @prev. Unlike rq->curr, the donor can be moved to another CPU by a wakeup
while dispatch_one() has the rq lock released:

1. dispatch_one() releases the rq lock, e.g. to move a task from another
   CPU.
2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
   proxy_needs_return() dequeues it and resets the donor to rq->curr, and
   the wakeup enqueues it, possibly on another CPU.
3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
   on another rq.

The other verdicts are stale too. If the dispatch finds nothing before the
wakeup enqueues @prev, SCX_DSP_NONE picks idle, and put_prev_task_scx()
parks rq->curr on the local DSQ with nothing to reschedule the CPU, or trips
its SCX_OPS_ENQ_LAST warning. SCX_DSP_LOCAL preempts rq->curr even when the
dispatch would have kept it.

rq_modified_above() catches the reset only when rq->curr is in a class above
ext, and the dl_server pick skips the check.

The verdict, whatever it is, describes the old donor. Restart the pick when
@prev is no longer the donor, as dispatch_core_pick() already does whenever
the dispatch released the rq lock. The retry runs with rq->curr as the
donor, and proxy_needs_return() returns early for the current task, so the
donor can't change again.

7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
closed the same window in prev_balance() by reading rq->donor instead of
taking @prev. That doesn't work here, as the dispatch never evaluated
rq->curr, which may not even be a sched_ext task.

Verified with a synthetic reproducer.

Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 15123f181b5b..3119a1938c6e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3936,6 +3936,16 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 	verdict = dispatch_one(rq, prev);
 	rq_repin_lock(rq, rf);
 
+	/*
+	 * With proxy execution, @prev is the donor and need not be the running
+	 * task. A wakeup while dispatch_one() has the rq lock released can
+	 * reset the donor and move @prev to another CPU. The verdict was
+	 * computed for @prev and doesn't apply once the donor changed. Restart
+	 * the pick.
+	 */
+	if (unlikely(prev != rq->donor))
+		return SCX_DSP_RETRY;
+
 	return verdict;
 }
 
-- 
2.56.0

