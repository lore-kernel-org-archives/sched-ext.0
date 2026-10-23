Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778174;
	b=YyxLcWWqWqcGq86pfQOAq0evINY6ehP+kB5zlBpEAxuLrVGHRSMUhco8bbcUa0utFcqv
	 ul22i1Jno9FAGA/ZQsbpS7Aa6LHjAZ9fOGf60G6KfxLiBc4YMoweSZZ8x4RXW4dy/G0Ps
	 asVxSPKVLAdFyi5rm0Ol02uTT8im5ggvWL1E73hPIpyj57/N6BY2amD4s8MYNLpvptQ0V
	 IyQ6iSA5hmg0K6UBwL3C5Dqf0/4WHKloQEjXbhroPBW2fbQwRV/b6xwtwjsbWLuD2vSdR
	 7cJ7r+SQQhsMrnNpHFKHQ4y8wOBt9ZkgRugkdXokyAHSb3nGdVTlldosm6pFdgdDgGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wX/GAHDN+GbI7TbYbnWWInaEhm1KwbklW3Ek85sxsB8=;
	b=is52CDysy9n+U7qRD6pZqsKi9r+pPw+q2jb3MUmrH0Z/Zr/O93nsgxL2awAsJASY2W67
	 wulDI6V1QVt2G02ozDEreU3NEoyMP0qCyqtmgKgiBxoerPSfxpCm4U4nZyOCCf9Pzsuzp
	 yDvXlm5H3KkFyyfqHNi1YYajjXX6Q0LBJ7F0zSKvVc7WXF0vclxQpu8MTYIOBiY0fF8uX
	 UKj8JJh7X69vjzKL4w/c22dhMpAMs5Pl+oj6D9nq/6e/gH8BWQOKCd3orfcc3cIRUshxN
	 pNDDssta1wfQab+HEBSHO9ayAXUEx5EuOYVSuWMDH+ZzbtrRC09iUxInMdA4tO0xK6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca1cXDHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F0606A32C;
	Fri, 23 Oct 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca1cXDHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D8C1F031E1;
	Fri, 23 Oct 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778173;
	bh=wX/GAHDN+GbI7TbYbnWWInaEhm1KwbklW3Ek85sxsB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca1cXDHKFCNvGlHXH9w3LVePUEWa0x9EsL8DUmq2hGNHvVLUYXKIqeYtIxnp1/HVd
	 L8j9dmo7aTlQJoUPzRsQkCmM0926P7MocvPEi9MIpBcUQb1ncCflavIihowdn2I08X
	 T3FiwNVWiY3W7U1aKSdvYMiSt30UBVHl7JBCtLYRd0bbqTABXiLurywXQJpny89lsf
	 +jTx9lvoT1rz6LICj9dcpCGZLVXktEGga1poATotaLPdOSPU+05Ob00lBr6JifgyTu
	 w0IPeJVUKWhvw8GgxWBJcyUQOdppHIy2UBLaNqqeuK+fseZh+ivnWbgB/yB3gXqcH7
	 uWDQImb3U2UCg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/17] sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
Date: Fri, 23 Oct 2026 07:55:55 -1000
Message-ID: <20261023175608.4120910-5-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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
index 1345e4174775..d3db1277118e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2403,6 +2403,12 @@ __bpf_kfunc_start_defs();
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

