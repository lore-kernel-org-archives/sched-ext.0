Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B662221FBA;
	Fri, 14 Nov 2025 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084023; cv=none; b=NcOA3P7GctsWwMcy4AGyr8S4WBmCZWV92mp+1D+ZV/IBDVaWNaHqR84KQDZeS0COA3L1+dp8181Szg2D1mTPWLZqxNfm4NZF8/Qz72eroqEK1BTDmiouJzOl4cA6sE1uu/I95fLy15B2A7Xp2If8EtdHbK45/SE/d+3QDJZtQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084023; c=relaxed/simple;
	bh=A7abiV9wvTFDaM0sqOLHfnN4ia/2tok2GZk8WPgtDko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCefxlqpTb9E0o0v6t1XsOyIa4L2Zqa+vnGBlgXmYwt/12nC120lUXAxy3qtYRnR26PX/AU9/0+DtLfBRGBi2Sv3Szv/NQ4aRxIDkkGQvxlyhSQdDE1ma2hUO/h3bEDWuJetphRG5JSMAkkeFyvsvIZ/1350c2/Np1+Nj8K7Qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8q5/tep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8q5/tep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED46C4CEF5;
	Fri, 14 Nov 2025 01:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084023;
	bh=A7abiV9wvTFDaM0sqOLHfnN4ia/2tok2GZk8WPgtDko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8q5/tepgEoPPQphV/bNoguFaeSFj7DIRdcWUpndIYIYTEnbPWwoyQYoDVR7X15qY
	 cZvcM+++OW6z3V8aZpOmoCssVT5dhwfVCKTFnE9tt5strrfQZm6ISlZFxEG5wD44Nd
	 nR/+Lzx7iBF8s6CHRHcItDeSxIJDtcmzX8it82TNWwxhQ6pv+SIzVprPQzwg8l7KfT
	 A7Mo0Qw7OY3rGI3+jrs5r/LswFUGZbl3T6fv/mI7G+4V5YW7u7iMd/gq0JYPy1eJnz
	 aQnJ8GbYUMey/00+0xRRhTumKebRoyDJWVOGwWxNSRUXT3eDlAAsX4B9ecQJW7qazI
	 4qXqX00fsM9Vw==
Date: Thu, 13 Nov 2025 15:33:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter to
 scx_hardlockup() and add docs
Message-ID: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
References: <20251111191816.862797-1-tj@kernel.org>
 <20251111191816.862797-10-tj@kernel.org>
 <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>

With the buddy lockup detector, smp_processor_id() returns the detecting CPU,
not the locked CPU, making scx_hardlockup()'s printouts confusing. Pass the
locked CPU number from watchdog_hardlockup_check() as a parameter instead.

Also add kerneldoc comments to handle_lockup(), scx_hardlockup(), and
scx_rcu_cpu_stall() documenting their return value semantics.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |    4 ++--
 kernel/sched/ext.c        |   25 ++++++++++++++++++++++---
 kernel/watchdog.c         |    2 +-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 70ee5c28a74d..bcb962d5ee7d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -230,7 +230,7 @@ struct sched_ext_entity {
 void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
-bool scx_hardlockup(void);
+bool scx_hardlockup(int cpu);
 bool scx_rcu_cpu_stall(void);

 #else	/* !CONFIG_SCHED_CLASS_EXT */
@@ -238,7 +238,7 @@ bool scx_rcu_cpu_stall(void);
 static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
-static inline bool scx_hardlockup(void) { return false; }
+static inline bool scx_hardlockup(int cpu) { return false; }
 static inline bool scx_rcu_cpu_stall(void) { return false; }

 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8a3b8f64a06b..918573f3f088 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3687,6 +3687,17 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 	return false;
 }

+/**
+ * handle_lockup - sched_ext common lockup handler
+ * @fmt: format string
+ *
+ * Called on system stall or lockup condition and initiates abort of sched_ext
+ * if enabled, which may resolve the reported lockup.
+ *
+ * Returns %true if sched_ext is enabled and abort was initiated, which may
+ * resolve the lockup. %false if sched_ext is not enabled or abort was already
+ * initiated by someone else.
+ */
 static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
@@ -3718,6 +3729,10 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  * that may not be caused by the current BPF scheduler, try kicking out the
  * current scheduler in an attempt to recover the system to a good state before
  * issuing panics.
+ *
+ * Returns %true if sched_ext is enabled and abort was initiated, which may
+ * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
+ * else already initiated abort.
  */
 bool scx_rcu_cpu_stall(void)
 {
@@ -3750,14 +3765,18 @@ void scx_softlockup(u32 dur_s)
  * numerous affinitized tasks in a single queue and directing all CPUs at it.
  * Try kicking out the current scheduler in an attempt to recover the system to
  * a good state before taking more drastic actions.
+ *
+ * Returns %true if sched_ext is enabled and abort was initiated, which may
+ * resolve the reported hardlockdup. %false if sched_ext is not enabled or
+ * someone else already initiated abort.
  */
-bool scx_hardlockup(void)
+bool scx_hardlockup(int cpu)
 {
-	if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
+	if (!handle_lockup("hard lockup - CPU %d", cpu))
 		return false;

 	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
-			smp_processor_id());
+			cpu);
 	return true;
 }

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8dfac4a8f587..873020a2a581 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -203,7 +203,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		 * only once when sched_ext is enabled and will immediately
 		 * abort the BPF scheduler and print out a warning message.
 		 */
-		if (scx_hardlockup())
+		if (scx_hardlockup(cpu))
 			return;

 		/* Only print hardlockups once. */
