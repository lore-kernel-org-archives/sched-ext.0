Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778182;
	b=LNmB1kILWvX1L8iiz/Tb94dXm1oXx5JUrwoEQvMHeWBZoxAZhphTZqqO1mK6oFRXTbPx
	 IH57T62WTy+eoRpUqkkZrJN2b01S+GDIJkl6KkWma/fVE3Vrnp0Cq8Vh0YeOdSO98CpRK
	 +eXMQFo1sKNjGPA+COjNlM6D2kqGXi+ntwN9sCIJQrbHEIlwchCgH6KGa/jlv3y8SvyNN
	 tRgKzRbXhigk7qShN89XNr1yUSgdje7rtGVRCIJzD7A29AA4PFHXiWnbFjncju39Nimqi
	 UGipUt0M1LbtI8+Pp4o3kobOUgwsMJpQZj4l0Sjzjc6VlfINPz5Tzd1s6g0vPYJkgLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nsq0kfH1yyT3WcFvoL+9pgr0dEUQSUxSyclyC6ykOMg=;
	b=PPLhH1yhvQuJ3D7ji4tMXr0YUJDx+jGsrmkx/loyh+dlMj4QuYSP+Ltqtgux9UPTfND6
	 /jTxJZ/y8MuhBcS7o9zEZ/xyoRere2txAmKa+txEtmJ6cx0/kDu/IJpRkNFsx6EWsf5wY
	 Hodw4vhSggPjB2ZcskP78It2wABMOyS5WhsFWedZgnJGwY26kTZ2cZ3X2DesmMYr1h60c
	 V3yw8ygIFcj7MIFjrHn0XryB8r92B4JzZsFPx87xhkecD6Pre7HOHIEYDc8mlRp2msabo
	 vTUGLDTHVEyzhuwnx2m9rC1FgtDGTkuxwY6cavfCLAVKof7qEYrrw3HV/jkwWONKkdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a7rJ/I+r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC7606A32C;
	Fri, 23 Oct 2026 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7rJ/I+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11F21F031EE;
	Fri, 23 Oct 2026 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778182;
	bh=Nsq0kfH1yyT3WcFvoL+9pgr0dEUQSUxSyclyC6ykOMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a7rJ/I+r97BYQcqJUXXSSImIP6/wjLBFjrMNRoGffF3vFGmULXpGyivOxIf3JtTim
	 z1LW8BNHIHZxZhY4a1VN5OsMYmvnGYFowG5QH5crsAidIa7LXQ4THe3m7Rnpx5DI9K
	 SntSEjOVYcZ/7hl/A9DD86bxUNgLPTDz7hWskZF45x0Crq+sWIapJXl1re1LRDoHo0
	 CxxfN6DCX9EQOhBVxlEv9jv3F48XlnBq9Ak5e2BbCUXkxJvtcjw9ZRqDLj3QiKLoMx
	 o6kKvXgiIP5PNa4i9UtT5zWspOWtQA5mJNZNMqp29C1hrm8PWI23e+bjf7qsSTemfS
	 oMs+O7MVEiJEw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/17] sched_ext: Expire prev's slice in dispatch_one() under bypass
Date: Fri, 23 Oct 2026 07:56:03 -1000
Message-ID: <20261023175608.4120910-13-tj@kernel.org>
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

The next patch keeps a bypassed rescuee on the local DSQ and needs
dispatch_one() to keep it running too. dispatch_one()'s keep test refuses
any prev whose scheduler is bypassing, so another local task could run ahead
of the rescuee, even an escalated SCX_TASK_PROTECTED one. The test exists
because a cpu-form scheduler can write p->scx.slice directly from BPF, so
the slice can't be trusted under bypass.

The refusal doesn't hold anyway. Since 025b1bd41965 ("sched_ext: Implement
hierarchical bypass mode"), the host's ops.dispatch() runs while prev's
scheduler bypasses, and the post-dispatch test in scx_dispatch_sched() keeps
a queued prev with slice left without checking bypass. A task dispatched in
between waits behind prev until the next bypass tick zeroes the slice, at
most a tick.

Expire the slice before the keep test instead when prev's scheduler is
bypassing, as the bypass tick would. Neither test keeps prev on a zeroed
slice, so prev rotates. A kernel slice survives the expiry and keeps prev.
Only a sub-scheduler's task can hold one, and sub-schedulers are cid-form,
which rejects direct slice writes, so it can be trusted.

Drop the stale pointer to scx_disable_workfn(), update scx_bypass()'s
kerneldoc, and add a TODO noting that the bypass slice handling can be
cleaned up once the cpu form is deprecated and the kfuncs refuse slice
raises from a bypassing scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 072153416256..6dc6ab2cb29c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3340,18 +3340,33 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
+		/*
+		 * Under bypass, @prev's slice can't be trusted as a cpu-form
+		 * scheduler can write it directly from BPF. Skipping the keep
+		 * below is not enough as the post-dispatch test in
+		 * scx_dispatch_sched() would keep @prev on the same slice.
+		 *
+		 * Expire it as the bypass tick would, so that neither test
+		 * keeps @prev on it and @prev rotates through the bypass
+		 * enqueue. A kernel slice is left alone and the keep below
+		 * keeps @prev on it, see %SCX_TASK_KERNEL_SLICE.
+		 *
+		 * TODO: Once the cpu form is deprecated and the kfuncs refuse
+		 * slice raises from a bypassing scheduler, slices can be
+		 * trusted under bypass. This expiry, the bypass tick's zeroing
+		 * and the related slice handling can then be cleaned up.
+		 */
+		if (scx_bypassing(scx_task_sched(prev), cpu))
+			expire_task_slice(prev);
+
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
 		 * Tell pick_task_scx() to keep running @prev. If the BPF
 		 * scheduler wants to handle this explicitly, it should
 		 * implement ->cpu_release().
-		 *
-		 * See scx_disable_workfn() for the explanation on the bypassing
-		 * test.
 		 */
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
-		    !scx_bypassing(scx_task_sched(prev), cpu)) {
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
 			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
@@ -6828,9 +6843,10 @@ static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
  *
  * - ops.dispatch() is ignored.
  *
- * - dispatch_one() does not report %SCX_DSP_PREV on non-zero slice as slice
- *   can't be trusted. Whenever a tick triggers, the running task is rotated to
- *   the tail of the queue.
+ * - dispatch_one() expires prev's slice before its keep test as the slice can't
+ *   be trusted. Each tick does the same and rotates the running task to the
+ *   tail of the queue. A kernel slice is left alone, see
+ *   %SCX_TASK_KERNEL_SLICE.
  *
  * - pick_next_task() suppresses zero slice warning.
  *
-- 
2.56.0

