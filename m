Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DB30E84D
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839628; cv=none; b=ASDoruMki+AsA9MOgBRXuIDVM7gkTQlSv4ApnrfYwqy46yL27Od7xDYLnNtsw7SAzmWfLMDlAKjO3hc1ScjXivqdg/UVlAgKHkpJ/iof+qm8r09k4j90ofLz+ni93fpPZmNQoqzIJlMgbjtpX70s+KB1+x1VN8Om4R0hLBoS4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839628; c=relaxed/simple;
	bh=gFeiypU5qclQlKyGSympAwDRn3JZ+YXx7QpsThI06dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ/jsJ/uEQS3ZwLJIZmSLw5+Jt6KwVin3PO0zbtOxxP8y4KfjnW5huqIGOuB2W5laE2QdbfsgU8RiwMj0CEdCUdAx22qYDhmiiDAbAZ+Un9btLTJ9mYdQ9d5GZZ4K2pH4OsH0zLuDZ5PrE49CL7MObFIn7VI/ReoDJKsDU2UIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlazpfPm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlazpfPm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adff872068so24327395ad.1
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776839626; x=1777444426; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVY0Ul7cq0NSPU/FuepEJhjqjn4ieUx/hBL/nitwkMs=;
        b=RlazpfPmY+fKmnhtjVxRA2ed16WI41zvAS3/RmFSZKApvI+qEZNqpLwcqBbFAXiFQT
         w5Is32FkwNynma40puff3gMpCS7DHJMUqRAjhreyyiaFMT2XQK8KKRXRUi6UyGpHk91S
         SJNjj41zcicrxVIuDw6blCz+I1giKeY3gk7w0rVJr3EhoFcOdmSC3gDVtQq4NA4If3OA
         Yrqte/QBChTbYct5P1OQex4Ch3ZLW5Tu6c+dJBGvOjA8MaivwmWn5jjpO2I06igJYsOO
         JDh7h8RVLp+dvVoc/nFzvPOH3ijIWRa0WplCuRuEVKhoHZlH7EbgXhJCErX/FJmWAvs1
         gGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776839626; x=1777444426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVY0Ul7cq0NSPU/FuepEJhjqjn4ieUx/hBL/nitwkMs=;
        b=IMYweUCNmtFajbSWMWhWIBg5WJS9tHDE9uPpssioINOZLYH1w8QQiUSzJMsUjqHNct
         2zUD2Gn4YG2UmKseoDVCe8FJs+ufwmA0g29w4V5MWoAJ6HOfE4jFIPir872C0i0YsXxi
         PT0xbVRnaqFxV3SeZQb53nP32s/HEhkcv5/RN39Fmb4KGr/aNrVEeJ4XXW4gHpJehFmB
         2jVZ3CJ8EektvI1ygw5A7SbZTv0ufgdw6Zbkkoc4+kTTPbR2pLM72OA7OtM6+3HI+bm0
         HlKLBijR0nd5Mw6UHmym0Zdqvh8QzcY1DGcORXnD8PfxNKHXwzFP7pdZdTY/xP3rDhW4
         YL5A==
X-Forwarded-Encrypted: i=1; AFNElJ84lJeqMAsEeHaDh3kz0rD/vd4ptLXrJ4P9vSko2om6XoF0NSQN3kgXRuFzWw7VyLpznE1NiOaBj/4=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt4r3+6r92o+2/PN8YbEIBd0CVsumkCvLNxQBcosxi2Y3AJkIE
	A4czC+bn2pSRBiWkFojMOWmJOD8yvN3rYLyEv3V8+HJ2tXesiRKefs/R
X-Gm-Gg: AeBDieu6aWM35n8u9ZiwqCROqELN3oRYbBBiah50NAcnHnGp4IRsRnYq13KYI0V+wwW
	+tOzaebEsU4V4yetnTzCRpA+y4UM9HllYtyxwtBwt2By6FjkpEz5G6zTHBk412/DAB+RSrmkJBS
	psWylE5KBneEpB1Q4YTZPGSumL1J02Jm8wE0gh7PAsbzlj68VMUPQzgrYEUkyFF+MqASXGdg1gN
	cOS1VvDM/hHqldyIO4kJDVNr6E9Z/iRBZrLFj+5K5SzZkpn1+bxX9CAm4dHX2n0LCK/ksPRw7uD
	C69vR1pUbyMHirbcyecAKfvou5rN+JsKyHOGNeASc9J2UJAro6Wb6CxLfGpHCULNTja3LcWB3AS
	iBcZrhw+OOwjUg0UYIHQsOuV5y9MW8L3V8zqmfZi5OyLxJeTxa6auJBA9ot5T5BT+k78jagz4jp
	wCXdCuCBNu1+3WIzg7WloHOBp/eSlkQlqKHIdGvUrdl1w5KM0G/R0EAfrpEg7w0rdK987aMHSsT
	INJ/Pl25fL/uT+q
X-Received: by 2002:a17:903:3c70:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b5fa02f3famr229855325ad.36.1776839625681;
        Tue, 21 Apr 2026 23:33:45 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm193209615ad.14.2026.04.21.23.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:33:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 14:33:40 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <20260422142633.G7180@cchengyang.duckdns.org>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acHJED4iAeytdC2l@slm.duckdns.org>

Hi Tejun, Andrea, and Kuba

On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
> > The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
> > once we know which task we would like to dispatch, and cancel the pending
> > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
> > on the BPF side. This way, the "critical section" includes BPF-side checks, and
> > SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
> > critical section.
> > 
> > With this solution, we can throw an error if task_can_run_on_remote_rq() is
> > false, because we know that there was no racing cpumask change (if there was,
> > it would have been caught earlier, in finish_dispatch()).
> 
> Yeah, I think this makes more sense. qseq is already there to provide
> protection against these events. It's just that the capturing of qseq is too
> late. If insert/cancel is too ugly, we can introduce another kfunc to
> capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
> stash it in a per-cpu variable. That way, qseq would be cover the "current"
> queued instance and the existing qseq mechanism would be able to reliably
> ignore the ones that lost race to dequeue.

Since this has been stale for a while, I prepared a patch to implement
scx_bpf_dsq_insert_begin() as suggested.

Is anyone else working on this? If not, I'm happy to send the formal
patch to fix this.

-- 
Cheers,
Cheng-Yang

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0a53a0dd64bf..0215a21a02db 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7933,6 +7933,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
+	unsigned long qseq;
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
 	if (ddsp_task) {
@@ -7945,9 +7946,16 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
+	if (dspc->insert_begin_valid) {
+		qseq = dspc->insert_begin_qseq;
+		dspc->insert_begin_valid = false;
+	} else {
+		qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
+	}
+
 	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
 		.task = p,
-		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.qseq = qseq,
 		.dsq_id = dsq_id,
 		.enq_flags = enq_flags,
 	};
@@ -7955,6 +7963,39 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_dsq_insert_begin - Snapshot qseq before a dispatch decision
+ * @p: task_struct being considered for dispatch
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Capture @p's qseq before the BPF scheduler reads @p's properties (e.g.
+ * cpus_ptr) to make a dispatch decision. The snapshot is used by the
+ * subsequent scx_bpf_dsq_insert() call, extending the race detection window
+ * to cover any BPF-side checks between this call and the insert. If a
+ * concurrent dequeue/re-enqueue races within this window, finish_dispatch()
+ * detects the qseq mismatch and discards the stale dispatch.
+ */
+__bpf_kfunc void scx_bpf_dsq_insert_begin(struct task_struct *p,
+					  const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
+		return;
+
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+	dspc->insert_begin_qseq = atomic_long_read(&p->scx.ops_state) &
+				  SCX_OPSS_QSEQ_MASK;
+	dspc->insert_begin_valid = true;
+}
+
 /**
  * scx_bpf_dsq_insert - Insert a task into the FIFO queue of a DSQ
  * @p: task_struct to insert
@@ -8134,6 +8175,7 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 4a7ffc7f55d2..adc4f1c01b56 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -989,6 +989,8 @@ struct scx_dsp_ctx {
 	struct rq		*rq;
 	u32			cursor;
 	u32			nr_tasks;
+	unsigned long		insert_begin_qseq;
+	bool			insert_begin_valid;
 	struct scx_dsp_buf_ent	buf[];
 };
 
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 64dd60b3e922..fb68a7d7e201 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -155,6 +155,8 @@ static bool dispatch_to_cpu(s32 cpu)
 		* reflect the migration-disabled state yet if
 		* migrate_disable_switch() hasn't run.
 		*/
+		scx_bpf_dsq_insert_begin(p);
+
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr) ||
 		   (is_migration_disabled(p) && scx_bpf_task_cpu(p) != cpu)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
-- 
-- 
2.48.1
