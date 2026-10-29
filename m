Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317973;
	b=g3B33CWy2+3hutrs1NCmIRqPw1mtRQZzIr7XOkwUpN4BG9+Accgcuq5Q+wfr2plqxIGk
	 Dh0XQtwubj4O8BTob+rrx1+q75XdWImPf6gvCrhZJVGAgMOU/6UvlghOtVdotCbLU9ob6
	 WfWAtdLfrneCApGFuEiPixRaSm4iaTLzV6/umN/aqSv7POdOINVlPsyW/LTfFjWArZSqr
	 7zHZ3GAs/oYq502GFMyDxnj+3zXC57h/lXm1JjGX51dz0WtaLjIlfThd3PT+nFg10tbmA
	 Ii/ZquaJ/dGRo5qQTmYYtbLbgN7JTq99qRvjFX3KecexfYrTNbToNrKCzC44pGT0eJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n3CQjXlMe7ga/JlJAS8WSDbxQFbDLHqky0D3xu2exuY=;
	b=sW3D7y720R89nSNb25xLYxh6qWiw3LFranseRijMZktSt2HNoYp6rnC6iNK3ZNs5A6Ft
	 wseWjcymxXPbufxGbKhYCuvr895Fi9XFcw2OmNwqKDWl+YkpyW208LPy7E7x59kD0Ok0n
	 ZzOf0tZmIxTq/2CbpYy9uRuaGZU4TP+fZ6zqsguAc2kG2R/ZNNqeabhyN3AL1xA6H4JQP
	 q9IJoaZOrY+lZeTHlaxWKjwJT6q2psd7fvtXbS+eeRf1esSgIDfcyQdNUAM4bByiPtnZW
	 CEExjiUx94e4ZUAP8n1EeXqhftuIMqp8R2hImP5yBnondmOhe6Ync6xOGzs1mUrZqnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lut52GjZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC37606A31A;
	Thu, 29 Oct 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lut52GjZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324A11F000C1;
	Thu, 29 Oct 2026 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793317972;
	bh=n3CQjXlMe7ga/JlJAS8WSDbxQFbDLHqky0D3xu2exuY=;
	h=From:To:Cc:Subject:Date;
	b=Lut52GjZd3tC0Hw070A7Y2aH86ylcK9cnCp/KhmXQjM+ovdaLUpEVV6jl5LJZ3uyQ
	 /fMnt2hMkblZgpA6owV1zjvkqhAer94mh6T9sNNcE/RxgOVh0UQZ27Ipf8LA4CxGFv
	 uB0XQ6sFO7MwMVA/sLm5rpiUWrTBgFJYD1cSRnpc2FA+U0EwtjhfBP6iAVLjQVSX5R
	 OPvAW8953dNIVqmFbczkhC8HPt4vX1OjC5o1tqH7S+yiMBXN4E+AocNq99f4vKq4+8
	 Q+Js1jPNJzznMfVv1eRd3Hcqyi+iStk+8JNx/1jwD/eAI5uWA2u8nPCSYSfpGzNkSg
	 4AD573BIZpYqg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix scx_bpf_dsq_reenq() kerneldoc claiming NMI calls are allowed
Date: Thu, 29 Oct 2026 13:52:51 -1000
Message-ID: <20261029235251.3235814-1-tj@kernel.org>
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

c659e506f9a7 ("sched_ext: Reject NMI calls to lock-taking kfuncs") made
scx_bpf_dsq_reenq() abort the scheduler when called from NMI. The kerneldocs
of scx_bpf_dsq_reenq() and of its wrapper scx_bpf_reenqueue_local___v2()
still say the kfuncs can be called from anywhere. Update both to exclude
NMI.

While at it, fix the wrapper's kerneldoc, which says it re-enqueues the
calling CPU's local DSQ rather than the one SCX_DSQ_LOCAL resolves to, and
the SCX_RENQ_* typo in the scx_bpf_dsq_reenq() kerneldoc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 15123f181b5b..cd923f9f1f2a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11115,7 +11115,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
 /**
  * scx_bpf_dsq_reenq - Re-enqueue tasks on a DSQ
  * @dsq_id: DSQ to re-enqueue
- * @reenq_flags: %SCX_RENQ_*
+ * @reenq_flags: %SCX_REENQ_*
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the DSQ identified by
@@ -11125,8 +11125,9 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
  * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
  * - User DSQs
  *
- * Re-enqueues are performed asynchronously. Can be called from anywhere. A
- * re-enqueue of an inactive cpu's local DSQ is ignored.
+ * Re-enqueues are performed asynchronously. Can be called from any context
+ * except NMI. A call from NMI aborts the scheduler. A re-enqueue of an inactive
+ * cpu's local DSQ is ignored.
  *
  * %SCX_DSQ_LOCAL resolves to the local DSQ of the rq the current scheduler
  * operation is locked to - e.g. the rq being dispatched for in ops.dispatch() -
@@ -11223,9 +11224,10 @@ __bpf_kfunc bool scx_bpf_dsq_reenq_task(struct bpf_iter_scx_dsq *it__iter,
  * scx_bpf_reenqueue_local___v2 - Re-enqueue tasks on a local DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * Iterate over all of the tasks currently enqueued on the local DSQ of the
- * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
- * anywhere.
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the rq
+ * the current scheduler operation is locked to, or the calling CPU's when no rq
+ * is locked, and re-enqueue them in the BPF scheduler. Can be called from any
+ * context except NMI. A call from NMI aborts the scheduler.
  *
  * This is now a special case of scx_bpf_dsq_reenq() and may be removed in the
  * future.
-- 
2.56.0

