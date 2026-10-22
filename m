Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705121;
	b=FCbxTV5Xv5UNxU3JG4kUijXwYr5KwgO/kHbqOL1ICWQTVSTSh/xJSKDMNkh3w80e/aUm
	 zfcQjxpfBFYLFjIV3Zm9JCim5kA02Eux2mt6QmpjrlW61CO+gE4U6ye9kSc+xBt7xFckt
	 3e6f6FbJmlMIXSm6vESpiSCBeQbjDG6B1byi/OZhaFtOEhqLU4wMeAGWxa+aGwJhTCpND
	 aBET+LFQXATuzYr41dML2syjjeN0NWAZ8bZv/CJAmHs9Pxt2MeWBq2pk/AnhyhQMdPM6X
	 kcdNnPu9lYPcCutmba61TNIcUE/nJBDU4uRkBZi+tBpELCJfQKvepLxqlHUi/b0EHpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1yAwA9pUm466ezJDd8Y8Vs1FFHhG8k49ArFYwVO8RkY=;
	b=UHZ2lFhOrLLcvb9HeaETbU5k6os2g0cRDGlgwOPZUf+JrOv7CQh1sJh9dUPeB8plcnI7
	 6KIUQoKDFOmRPW8SBmSYW2HZ53NgbAydYnnC0hYFvkWNz+2boblN+/TuE9hJqAchFbH3O
	 ZkPs4Zw4teB66l1vX87LSnJHnAMYtToasLrxSPyBAJSjEMy0GlJHugErLkAvFI0ZyoHJj
	 0u236/vXgfVqzmXqYYLa8C400cBL32q00cqZsldz0SnMUKT+/17O4Hogeq4SjgJjIP7/r
	 am2p6FlyuUAicT5DvEg5PMUnQu78gdv9x6KPke83LPaLoCz2OT5aCNb3tvCt2wefH9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTEV4sbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3B606A330;
	Thu, 22 Oct 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTEV4sbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429E41F01828;
	Thu, 22 Oct 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705120;
	bh=1yAwA9pUm466ezJDd8Y8Vs1FFHhG8k49ArFYwVO8RkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTEV4sbZPAxezN9WoUGz5Bb62xK2Ip6p94lKogBHf1UIcvFrOqSBh6JRjt7EFZuuS
	 8IgQWHG9GXQUsJEAOlsNL1ae9pZyX7t/NhkCO7Yj6wKlUFepDnqYMFcsv/Q6y33S/t
	 LLJHZb9Aq4TX99Ew+mqv1JKvXDJ8/W+pJRwsrFWUAHcVYAb5cnVII/vNPOZqvYTubZ
	 nKNJVl5x6g43N8yXAaEJe1aHtWnQOQIremB0Uj3R8ILIlNTjP6VWpWDAFKEtycIKPu
	 imnsaMCPMtP82N86cST+l5j9rdaLqTIjT4E4YM5O3/6qZ50jeXePKcNdXXxihbLXbC
	 hClCP3JY1/Spw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/14] sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
Date: Thu, 22 Oct 2026 11:38:25 -1000
Message-ID: <20261022213836.2259069-4-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
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
into the host. Each such reenqueue counts toward the reenqueue limit.

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

