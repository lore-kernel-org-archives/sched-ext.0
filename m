Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060274;
	b=RAL+TQezCTHMQLWIThLSchwAaFY3dXPAaCTdXoMBrXYNPOqHGhz7C+FVJMHb+234YIVO
	 KEz70i4iXXBPuc4m954WgEd1lHWCvd8LXuKwzrCtUUrmLygzluaQYk/SJ65ptkTB2q/uY
	 /IymPb9arO040q4YETrfSupN7n8HhHtw5eY7S2v6+2FXMrI5rPHII/09dqJApkSptrzXg
	 CKIkdhKlIzDueFr4VHyvYHyzsg5QgCRqxqdejkMyQKbKjGTWYERr0++QUyhTXHyLHBYg9
	 90zuyWv4uHpBINoCgQ6NHuP/E+n3AForByBcSPW1juzybvdvxs9B7NyqhtG5rdZeN7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RjZZZ0ui2vo/vQGMlrejhiBDFWdvSVttcysNIxUnpSs=;
	b=nQBvfuQDEM62OWCjR7JILSCR0j+ymDj57WAfyCdfZ/RsFY5FRaaKI1pCMk+Sd+aR1P0L
	 dOmXbO7LZLqGsfXXRkhYvtSND4FSsGvhzRz8USBLe2psrbrynnArfG/Dqz5mhIUepC8BV
	 Z4o4oay724vHtdjhNfZf+I4byO//VtZo39fEZxxblwRcW9m5erl32bNNxmh0FebY6K5eE
	 +2DOQCs2kmiblO3KhQKmsWgnIt0IwyCJNZWJxGX4jC4pbi0JHddm1cmLrlDsfx6/gYNWc
	 jqXc39nB/ahb3IqOysv60rjMcDlAT+wCLsrfzepckedtremG6b9n51O5Ngj7CGjNhUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbWl6BQU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219B606A33E;
	Tue, 27 Oct 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbWl6BQU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D541F031E2;
	Tue, 27 Oct 2026 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060274;
	bh=RjZZZ0ui2vo/vQGMlrejhiBDFWdvSVttcysNIxUnpSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbWl6BQUbICYGrCla+G2fxyexdW6/CgigGDI9Ir2Ef6bwJ40NtVJlQ7C670vTho8Y
	 +j89yK7Espt8CcnjhRR8dEWcZUZd0DKjEKaWdYMQnJhVO1NitqvBcZvaz22AFl+GY1
	 9/AHCOX0+IS30YVHM+ovjg7QZHzlSop4VKEAMVrrEaNYvxWZsdeILq49Q2MRul2Pxf
	 6lLVaBOD6zYaIDeavcfPy/f3tz+RfA157rIFl/44apgEhfvVuWFLwyW5Gh9rVti616
	 XGheGkx9XPov5CEGYW7uT+IZILYZf4DC1ygsuCi7cgtdNNVVfe29B4bjOPmD3LvRtD
	 k50cI4sI/ZfYA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/18] sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
Date: Mon, 26 Oct 2026 14:17:35 -1000
Message-ID: <20261027001749.1821379-5-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
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

Bypass exists so that runnable tasks make progress without trusting the BPF
scheduler. A host with SCX_CAP_ENQ_IMMED (BASE) but not SCX_CAP_ENQ on a cpu
cannot run a single bypassed task there. The task loops instead:

 1. a bypassed task lands on the host's bypass DSQ for the cpu
 2. the cpu's dispatch descends into the host, which holds BASE there
 3. the host consumes the task into the local DSQ as a plain insert
 4. the insert needs ENQ and the host lacks it, so the task is rejected
 5. the reject drain reenqueues the task and it is back at step 1

A bypass consume puts a task on the cpu being dispatched for, to run right
away. That is the IMMED contract, and BASE is the cap it needs. Consume with
SCX_ENQ_IMMED. BASE is then the one cap a bypassed task ever needs. Dispatch
descends into a host only on a cpu where the host holds BASE, so a consume
never lacks it.

A consumed task is first on the local DSQ when dispatch enters the host with
the DSQ empty. That is always the case for the root and normally for a
parent dispatching into a child.

A consumed task that cannot run right away is reenqueued like any IMMED task
and goes back to the bypass DSQ. Waiting on the local DSQ would need ENQ.
The task cannot run right away when a higher class or a HEAD insert took the
cpu meanwhile, or when the parent queued its own task before dispatching
into the host.

Each such task waits on the bypass DSQ for the next dispatch. The reenqueue
is not counted against the reenqueue limit, as the task's scheduler is
bypassing.

v2: The description says that the reenqueue of a consumed task is not
counted against the reenqueue limit (sashiko).

Fixes: 701b7bcad868 ("sched_ext: Add the SCX_CAP_ENQ cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/inlines.h | 15 ++++++++++++---
 kernel/sched/ext/sub.c     |  6 ++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 8de9d8fb4b25..1e39d12678c4 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -39,10 +39,18 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (scx_consume_global_dsq(sch, rq))
 		return SCX_DSP_LOCAL;
 
+	/*
+	 * A bypass consume puts a task on the cpu being dispatched for, to run
+	 * right away. That is an IMMED insert and needs only
+	 * %SCX_CAP_ENQ_IMMED, the base cap. Dispatch descends into @sch only on
+	 * a cpu where @sch holds the base cap, so @sch holds it here. The same
+	 * holds for the consume at the end of this function.
+	 */
 	if (scx_bypass_dsp_enabled(sch)) {
 		/* if @sch is bypassing, only the bypass DSQs are active */
 		if (scx_bypassing(sch, cpu)) {
-			if (scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0))
+			if (scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu),
+						   SCX_ENQ_IMMED))
 				return SCX_DSP_LOCAL;
 			return SCX_DSP_NONE;
 		}
@@ -63,7 +71,8 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
-		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
+		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu),
+					   SCX_ENQ_IMMED)) {
 			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
 			return SCX_DSP_LOCAL;
 		}
@@ -135,7 +144,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	 * scheduler's ops.dispatch() doesn't yield any tasks.
 	 */
 	if (scx_bypass_dsp_enabled(sch) &&
-	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
+	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), SCX_ENQ_IMMED)) {
 		__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
 		return SCX_DSP_LOCAL;
 	}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index f7f33fd0c5e9..a7b14ea16822 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2722,6 +2722,12 @@ __bpf_kfunc_start_defs();
  * child schedulers. The child scheduler runs its dispatch operation to
  * move tasks from dispatch queues to the local runqueue.
  *
+ * Dispatch into a child while the local DSQ is empty, when the cpu needs a
+ * task. A child holding only %SCX_CAP_ENQ_IMMED can insert only IMMED tasks,
+ * and the consume of its bypassing descendants' bypass DSQs is one such insert.
+ * With a task already queued on the local DSQ, such an insert fails and the
+ * task is reenqueued.
+ *
  * Returns: true on success, false if cgroup_id is invalid, not a direct
  * child, or caller lacks dispatch permission.
  */
-- 
2.56.0

