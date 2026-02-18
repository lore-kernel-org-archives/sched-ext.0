Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B562DC328;
	Wed, 18 Feb 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432420; cv=none; b=Q37C9waDu45qCx5jpwxBX+UgTRlJgVRV2ZgDftDZ08TzXOOQxYoZBg8702h8nca74sATI2gIO4+Ijhzi+32nKWhbk135t+z3YSbqnPuhWQq56H6Lh1SQXCSibc37ZsLp4gNjzfHoonNLngrEnavAE7WUbkNiku6f+YMHsX8rpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432420; c=relaxed/simple;
	bh=UezUegroxjJ9WXHfEGN2dMy4JB01XiJRvt9dgmtlGAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv3WUEUVRS6Fk1/fmQUw7Qsct5NG9uDbxWNwUDg6KN9lDGBaut87yXjF81UB3XKng0mGKs6Ow54U4VLtyxyjtIAGBzB655TIArft0YcO+t4d4MC1L+czpxwhrkyPs+8+PngKvbo+pUv8gqbXErpCl8zhZ3YF7rj6iBGuD/DhAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aXrmMhoL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXrmMhoL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q8gPFwjxGWukNyPFZBo6QBRLPK+q62wEePj5YHotIpg=; b=aXrmMhoLE5wozk2U5h4cvkNz4V
	7XblU4DZ5JaTU6p9TU0GsGnbVccjXwtr5BZ2dT3AiLyoeJ1QNsb5l4Q6ZX9Ha9qlw3pHWPOw+BD6S
	51hvUTj18yvDunOLuU/H1rGbF9JDUjJSwJYViisHdd6Mpht6b/Mijc3qoOpBkwqRG+S7fLENtaHYQ
	pgVGRaJ5aLsDxv5/BVdWBPi+8AsH/YtEXu+XP17Biz39sRAg9deX7YgEGmZYoYtq2fxrvDTsovIsw
	7VZyo5MkcRcIf0M/GNP5oS4/hU8UcNBMZ3aIw8PaIG7ISGzviczmg6PLQ3mUTi/ynQ/u+x7WyKYUE
	oAT0sfPA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vskUU-00000006HX8-3oWD;
	Wed, 18 Feb 2026 16:33:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA1A7300B40; Wed, 18 Feb 2026 17:33:29 +0100 (CET)
Date: Wed, 18 Feb 2026 17:33:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, sched-ext@lists.linux.dev,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [linus:master] [sched/core]  704069649b:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20260218163329.GQ1395416@noisy.programming.kicks-ass.net>
References: <202602122157.4e861298-lkp@intel.com>
 <20260213144417.GL3016024@noisy.programming.kicks-ass.net>
 <aY-iNnrhEj2XuRcH@google.com>
 <20260218094053.GD2995752@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218094053.GD2995752@noisy.programming.kicks-ass.net>

On Wed, Feb 18, 2026 at 10:40:53AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 13, 2026 at 02:14:14PM -0800, Sean Christopherson wrote:
> > On Fri, Feb 13, 2026, Peter Zijlstra wrote:
> > > On Thu, Feb 12, 2026 at 10:08:04PM +0800, kernel test robot wrote:
> > > > Hello,
> > > > 
> > > > we found the kernel-selftests.kvm.hardware_disable_test failed consistently upon
> > > > this commit but pass on parent. unfortunately, we didn't find many useful
> > > > information in dmesg. this report is just FYI what we observed in our tests.
> > > > 
> > > > kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:
> > > 
> > > With the caveat of PEBKAC (it is Friday after all); I can't reproduce.
> 
> PEBCAK indeed, I managed to consistently boot into the bad kernel :-(
> So never actually tested the good one.
> 
> > > That is, ./hardware_disable_test as build from cee73b1e840c, doesn't
> > > work for me on 704069649b5b^1 either.
> > > 
> > > Sean; is there a magic trick to operating that test, or is it a known
> > > trouble spot?
> > 
> > Hmm, shouldn't require any magic, and hasn't been known to be flaky.
> > 
> > This very decisively points at 704069649b5b ("sched/core: Rework
> > sched_class::wakeup_preempt() and rq_modified_*()"). on my end as well.  With
> > that commit reverted, the below runs in ~40ms total.  With 704069649b5b present,
> > the test constantly stalls for multiple seconds at sem_timedwait().
> > 
> > AFAICT, the key is to have the busy_loop() pthread affined to the same CPU as
> > its parent.  The KVM pieces of the selftest have nothing to do with the failure.
> > 
> > Here's a minimal reproducer that you can build without selftests goo :-)
> > E.g. `gcc -pthread -o busy busy.c` should work.
> 
> Whee, thanks! OK, let me go prod at this with something sharp, see what
> falls out.

This seems to work. I'll go write a Changelog after dinner.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 759777694c78..b7f77c165a6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6830,6 +6830,7 @@ static void __sched notrace __schedule(int sched_mode)
 		/* SCX must consult the BPF scheduler to tell if rq is empty */
 		if (!rq->nr_running && !scx_enabled()) {
 			next = prev;
+			rq->next_class = &idle_sched_class;
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c18e81e8ef51..3afa96d5d1ba 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2460,7 +2460,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	/* see kick_cpus_irq_workfn() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
-	rq->next_class = &ext_sched_class;
+	rq_modified_begin(rq, &ext_sched_class);
 
 	rq_unpin_lock(rq, rf);
 	balance_one(rq, prev);
@@ -2475,7 +2475,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	 * If @force_scx is true, always try to pick a SCHED_EXT task,
 	 * regardless of any higher-priority sched classes activity.
 	 */
-	if (!force_scx && sched_class_above(rq->next_class, &ext_sched_class))
+	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
 		return RETRY_TASK;
 
 	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e22b7fadd70..8e5864ec4cf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12908,7 +12908,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	t0 = sched_clock_cpu(this_cpu);
 	__sched_balance_update_blocked_averages(this_rq);
 
-	this_rq->next_class = &fair_sched_class;
+	rq_modified_begin(this_rq, &fair_sched_class);
 	raw_spin_rq_unlock(this_rq);
 
 	for_each_domain(this_cpu, sd) {
@@ -12975,7 +12975,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		pulled_task = 1;
 
 	/* If a higher prio class was modified, restart the pick */
-	if (sched_class_above(this_rq->next_class, &fair_sched_class))
+	if (rq_modified_above(this_rq, &fair_sched_class))
 		pulled_task = -1;
 
 out:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b82fb70a9d54..43bbf0693cca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2748,6 +2748,17 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 
 #define sched_class_above(_a, _b)	((_a) < (_b))
 
+static inline void rq_modified_begin(struct rq *rq, const struct sched_class *class)
+{
+	if (sched_class_above(rq->next_class, class))
+		rq->next_class = class;
+}
+
+static inline bool rq_modified_above(struct rq *rq, const struct sched_class *class)
+{
+	return sched_class_above(rq->next_class, class);
+}
+
 static inline bool sched_stop_runnable(struct rq *rq)
 {
 	return rq->stop && task_on_rq_queued(rq->stop);
