Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445545;
	b=d44lsulmpp/nBDratZBZ39uos0oW/U0zTNSN0t9xUI6hzmpFLA5EVHzWblSdCHeKZEgw
	 aVBO9kaklffh0QdcoRQ7gSp3FeLt7+JK+Zzu/rAvpMC4tzBwFcH2FRmPeYoXdPazheRrQ
	 oomj5qiu1HDKufu6/vHs08etfzy2kgw4lisIx14G+i6WzO9rjWgWIqf9ul6BAkEH8pySu
	 2w6WL72MBN+BROHQZZvgHbmyklLumQPA7c6jn/GcesA0DCeVmcD5q5gG/1gcIP13VcA54
	 XtU544swXxfpZ08SkLSbF058ZuDNjdxo71p1h8+kox+jQglFOWPoYm1pefxageUZm/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AxdRyI6gXuJrT7M7H+LUfe89+b/iyQHO8IJZpTB+9fI=;
	b=jspOllXkNRg7jAOrjTc1B78p5rQHP1rEFkz8pW37xh8ADpWSrypTjOSXYC2SGgDd/oL0
	 ra2EOZWIaO14qvz5JXcWluQzxAjWP27VRS3K676kW1I8ybVxm+iacNH76+QblUCCBWXLf
	 s5qXF47dUXQEjADcVhVYUl0qZUqdIoCLBqeLUiiRkQ3P8oHOPn5FAXK8s5kdogZxmyNyk
	 rfrK3o+GdDmkF76H0D5RF+a8oxrlXQbuQyzVU3yGdsjxSaT+3WySPjbW5JWPH2YdBxCWI
	 /vHh2zmoMzi86FuG9VYO/cN1fqg1lLU6R7YLAueBQn/11jEwljQBBzEB8paDWbDS7Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4eRFwz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBA60A260C;
	Mon, 19 Oct 2026 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4eRFwz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8491F000C5;
	Mon, 19 Oct 2026 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445545;
	bh=AxdRyI6gXuJrT7M7H+LUfe89+b/iyQHO8IJZpTB+9fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4eRFwz9etNKcRKpl+HRkEnxxyjGY6sdrDToLaVpAc0DENp2vc8hh8YDfFcpmh3Tz
	 UGj0HkbvbpJBV7VLKOwSIn7q4HdGDjshaSdElzT5mNkby0IjFCM0qwiE63jIXexR9A
	 Bcrw2ADFcrT6EZQoZ8aAwGDw/rjyAGBVaN6lBc5I2BOI8TopIGLXFcqfXtcOasyH3g
	 toMQN0cGb44DsWi/gCbKcT4Kw+Ih3fDrKK0hV8G48+RBuj62eMRejYejhzUWx0KgmR
	 XbecsjFSLS597JLUQko1hMYvJkFaFKjaU0ziPhn81lIagr7euYdOIut0xE8zp0SZUS
	 5l//Lmo/AAhZA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: scx_qmap: Queue re-enqueued lowpri tasks on their FIFO
Date: Mon, 19 Oct 2026 11:32:21 -1000
Message-ID: <20261019213221.2919481-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213221.2919481-1-tj@kernel.org>
References: <20261019213221.2919481-1-tj@kernel.org>
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

scx_qmap holds nice 19 tasks on LOWPRI_DSQ, and lowpri_timerfn() re-enqueues
them every 10ms. The re-enqueued tasks take qmap_enqueue()'s SCX_ENQ_REENQ
path to SHARED_DSQ, which qmap_dispatch() consumes before popping the FIFOs,
so enough nice 19 tasks starve every other task:

1. A nice 19 task's slice expires and qmap_enqueue() puts it on LOWPRI_DSQ.
2. Within 10ms, lowpri_timerfn() re-enqueues it onto SHARED_DSQ.
3. qmap_dispatch() finds SHARED_DSQ non-empty and doesn't pop the FIFOs.

With a dozen nice 19 CPU hogs, no FIFO was popped for over 5 seconds, and
the root was ejected as the watchdog work, whose kworker waited on a FIFO,
failed to check in.

Queue a re-enqueued lowpri task on its FIFO instead, where it is dispatched
in its FIFO's turn after its LOWPRI_DSQ wait.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 77f02fb70a86..3951f1f6e3c6 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -427,6 +427,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	static u32 user_cnt, kernel_cnt;
 	task_ctx_t *taskc;
 	int idx = weight_to_idx(p->scx.weight);
+	bool lowpri = p->scx.weight < 2 && !(p->flags & PF_KTHREAD);
 	s32 cid;
 
 	if (enq_flags & SCX_ENQ_REENQ) {
@@ -587,7 +588,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	/* see lowpri_timerfn() */
-	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD) && !(enq_flags & SCX_ENQ_REENQ)) {
+	if (lowpri && !(enq_flags & SCX_ENQ_REENQ)) {
 		scx_bpf_dsq_insert(p, LOWPRI_DSQ, slice_ns, enq_flags);
 		return;
 	}
@@ -606,8 +607,12 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * higher priority scheduling class, just re-enqueue the task directly
 	 * on the global DSQ. As we want another CPU to pick it up, find and
 	 * kick an idle cid.
+	 *
+	 * A lowpri task goes to its FIFO instead. qmap_dispatch() consumes
+	 * SHARED_DSQ ahead of the FIFOs, and enough lowpri tasks coming back
+	 * from LOWPRI_DSQ would keep it non-empty and starve every other task.
 	 */
-	if (enq_flags & SCX_ENQ_REENQ) {
+	if ((enq_flags & SCX_ENQ_REENQ) && !lowpri) {
 		s32 cid;
 
 		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
@@ -1357,7 +1362,7 @@ struct {
 
 /*
  * Nice 19 tasks are put into the lowpri DSQ. Every 10ms, reenq is triggered and
- * the tasks are transferred to SHARED_DSQ.
+ * qmap_enqueue() queues the tasks on their FIFO.
  */
 static int lowpri_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
-- 
2.56.0

