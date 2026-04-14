Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38D335575
	for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776138368; cv=none; b=gv+fsnAXAjOtUH/B+OvVyDQWgah1ufboneaBwRgE+8BwfXf7Dh3kYg0C71MYoSCUrb1JTf4eNXhHHpPC+5JJegSefCwE5IJp0ujd2w1JBJamOu2K6h3LXsLjLZtUCJvnuT3K8qvUHyzyFz2orsIs8H0rQiKXfMU/8QTaySgcehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776138368; c=relaxed/simple;
	bh=aWa5U3ltlhlo5x2/e/sJfYlyme2X8vEq3+xOqsQa4QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+fD3hWAplkXV0izCbnoJQo1n3RXI4ra2DmE76XXVZZoWP+0FL5OVgqggLsKZabTsPC4eYyamhHWnmsHlbfASW0KFaS6R8T7kYfacnQrlsHlvcYWmpw++6ayenQuCWwjqkYRO8XYIwanoTUYMdvnYzpGetGPjoDZBPh9pYeR1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGZDT1kj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGZDT1kj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d965648a2so4269494a91.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776138365; x=1776743165; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpbkxAyyUoxbp5VHRfKTHgQdOh2r/Qv/j5kQ3gccgaY=;
        b=QGZDT1kjP7rM+mpshcdsrA3IBfZgbl/ij6o0a1WRWusqO/fBzEtOluo6/PJE7lH7HV
         AhUL/i6WBrTOkAKNBvw4PwASFfgnPG9TB/HY9DUOr6OJsraqtoyqQQguymcnmO3OlcgV
         oXoioYxcObQD3J9KVapZn7XPVCoHx6eUCeDHWb8pF/u7AyqqqcRMI1L6CpxikfamvQ3W
         7l1eGgUQ1el7uaEPiI2vLkf2HZttWWy24TccT3mWzagg3x++1UqqQSK1rR9x9eASqTmX
         pc2hFpbJQhHa9Aj4uDKsWGWUBn363l+grcjHD98FyQR0ob2v/PBWTbx2k4PqKyr4r0n/
         c5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776138365; x=1776743165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpbkxAyyUoxbp5VHRfKTHgQdOh2r/Qv/j5kQ3gccgaY=;
        b=R/wP/pJjJu/PMb0mcfqgjQIUrAILktlfRCQC6slY0zT6KVliWUTjHTKJycu5AzsiXE
         3KN8KzA8jxWvNXq0fvyb7UzI0+mjbgXStYwfr0erHQZcNAF6HD2un5ICTGKmEsj3FfGF
         ylUtHXraGJ6uUf11+m0u20Iwpsx3n7J3qF2ii9W5BElt1uFYhkR54KXmU95YNHs7Q9uB
         ehJ0rTjH3Isqs9neADj8m7s01JA7i+R4osp4fiXEvFk96ss2A6Yhu/U+IzLsG1oldm9X
         i+y+iXkxLT8cl+qtCEVdjCXrO2y3jcsheykJr+fjB05gySz7DHa41cjFZI+H87sODweZ
         mqQg==
X-Gm-Message-State: AOJu0Yx3M1QlayikGMX6mrKd4YOPC0r+DxA7aWIjuO31Ir/QE/sawdlH
	7h7x+QZQPanepk4vU+OjlHRjpz9OO+TmYnmUwTFQisg9rwalZjLJY80f
X-Gm-Gg: AeBDievXMD14XbIEp6CaS9Ge2Ft+gGJKrKfLMqAu8HW4+foV/pfQahDsOd7MAIgEqvO
	QAiL1yYcowx/Vbv1s/czpymvatmxOB779G8ksSw/SKDs4YHNcdQ8wjmV/McXLvs0rqPjm61/Evg
	lxN+Gu4Gp7EJqLIKKZQ2KXJ4EpJHGaBhPO2yKnRyVyG3ZB/Kz64Kmyyax7dnD973pEdTaTwuYoV
	71QPSP4Kk0q6SO02+keZEkGqveK+JlHLQIqFL6gajrQSwYakifnQK6AKQwm3RNcy3mE6CwE3brV
	KAB1Za1dsxmv7a4ePKo6geQ8iI3H9a3YAVCbpDPDIjWGakcSGmRG1dV6Ur+i+Rvn2yUWhbv24iM
	iKgBRo5KXysLtH2ifKvLfwIeKK+uPoTM/2Jmaquzhhfh8IKegkNpmCJQd2TR/3vysfnNiXRIUPg
	miloh52oOcggKQ7ZnsmnsOGP/TMOJg2m7Y1rdd9Q==
X-Received: by 2002:a17:90b:1850:b0:35f:bcfc:27b8 with SMTP id 98e67ed59e1d1-35fbcfc2b0emr4870572a91.7.1776138365445;
        Mon, 13 Apr 2026 20:46:05 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:c704:5352:540b:7ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6fa6faasm492520a91.17.2026.04.13.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:46:04 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:45:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="coi4jkoxjfoasg4x"
Content-Disposition: inline
In-Reply-To: <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>


--coi4jkoxjfoasg4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kuba,

On Mon, Apr 13, 2026 at 03:29:37PM +0000, Kuba Piecuch wrote:
> > -	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
> > +	if (p->nr_cpus_allowed == 1) {
> 
> If you want to cover all cases, then I think you should also check
> is_migration_disabled(p). When a task disables migration, it is not reflected
> in p->cpus_ptr or p->nr_cpus_allowed until the task is switched out (see
> migrate_disable_switch()), which happens __after__ ops.enqueue().
> So here, you could see p->nr_cpus_allowed > 1 even though the task has
> migration disabled.

Thanks for the feedback! 
I've attached the v2 patch with the updated logic.

-- 
Thanks,
Cheng-Yang

--coi4jkoxjfoasg4x
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tools-sched_ext-Handle-pinned-tasks-in-scx_central.patch"

From 038e42a0a2c6d0b23e6914eaafcb0de301b70258 Mon Sep 17 00:00:00 2001
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
Date: Mon, 13 Apr 2026 15:19:59 +0800
Subject: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: Handle pinned tasks in scx_central

scx_central only fast-pathed per-cpu kthreads (PF_KTHREAD &&
nr_cpus_allowed == 1) directly to the local DSQ, leaving non-kthread
tasks pinned to a single CPU to go through the central queue. When
dispatch_to_cpu() later dequeued such a task and found it couldn't run
on the current CPU, it could trigger scx_error() and disable the
scheduler:

  sched_ext: central: SCX_DSQ_LOCAL[_ON] cannot move migration disabled qemu-system-x86[223212] from CPU 1 to 0

Though scx_central is a demo scheduler and meant to dispatch all tasks
from a central CPU, it should remain robust under any circumstances.

Extend the handling to all tasks with nr_cpus_allowed == 1:
- select_cpu() and enqueue(): bypass the central queue for pinned and
  migration-disabled tasks. enqueue() also checks is_migration_disabled()
  directly because p->nr_cpus_allowed lags behind migrate_disable_switch().
- dispatch_to_cpu(): use SCX_KICK_PREEMPT when bouncing to the fallback
  DSQ so the home CPU preempts immediately.

Test plan:
- run scx_central on the host, then launch virtme-ng in a separate
  terminal to create pinned tasks (qemu-system-x86), and verify stable
  operation.

Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
v2: Add is_migration_disabled() check in enqueue() as p->nr_cpus_allowed
    is not updated until migrate_disable_switch() runs during context
    switch, which happens after ops.enqueue(). (Kuba Piecuch)

 tools/sched_ext/scx_central.bpf.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 4efcce099bd5..67b160a7ce18 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -96,7 +96,13 @@ s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 	 * disturbing other CPUs. It's safe to blindly return the central cpu as
 	 * select_cpu() is a hint and if @p can't be on it, the kernel will
 	 * automatically pick a fallback CPU.
+	 *
+	 * For tasks pinned to a single CPU, return the current CPU to avoid
+	 * an unnecessary fallback.
 	 */
+	if (p->nr_cpus_allowed == 1)
+		return scx_bpf_task_cpu(p);
+
 	return central_cpu;
 }
 
@@ -107,12 +113,17 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 	__sync_fetch_and_add(&nr_total, 1);
 
 	/*
-	 * Push per-cpu kthreads at the head of local dsq's and preempt the
-	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
-	 * behind other threads which is necessary for forward progress
-	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
+	 * Push tasks pinned to a single CPU or with migration disabled at
+	 * the head of local dsq's and preempt the corresponding CPU. This
+	 * ensures that e.g. ksoftirqd isn't blocked behind other threads
+	 * which is necessary for forward progress guarantee as we depend on
+	 * the BPF timer which may run from ksoftirqd.
+	 *
+	 * p->nr_cpus_allowed is not updated until migrate_disable_switch()
+	 * runs during context switch, which happens after ops.enqueue(). Check
+	 * is_migration_disabled() directly to catch tasks in this window.
 	 */
-	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
 		__sync_fetch_and_add(&nr_locals, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
 				   enq_flags | SCX_ENQ_PREEMPT);
@@ -155,6 +166,13 @@ static bool dispatch_to_cpu(s32 cpu)
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
 			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
+
+			/*
+			 * Kick the task's home CPU to pick it up from the
+			 * fallback DSQ promptly.
+			 */
+			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT);
+
 			bpf_task_release(p);
 			/*
 			 * We might run out of dispatch buffer slots if we continue dispatching
-- 
2.48.1


--coi4jkoxjfoasg4x--
