Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD125288513
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759891045; cv=none; b=Kdk1f0vjSDwrOV8cTBn9R7fEqGNw5xLPt+xTJEQqJSrlDm7WOaoE5g7V/1r7i/5hJHA/ydMbDk3wAxX0SJIRizhckvvf982S9oQfFBurEHePFY5BFF1ZP3Oal/uQRDRszlLPzMUuX17OT0gxs5NlVFn+tXkFrw9HWhjPAzM+TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759891045; c=relaxed/simple;
	bh=EZ4OzVCojIpK53t+JDF/3YQ2rUwT/gdZNi+ytJTZpN0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hBCrYEE+OuGEr4mgW7aY3Cvm6akc8cBGSPR206uTBPLg6MgSxRDx5rBChvF/0Gwb7ba8ngtLk6dqjZ5qELS4EZAKHX8/pFmTwWc1/QDN2OcjjZaw+3HBYInlvqUvrOqEpRRQGfcQGfPrqfwVrHJBlJbuVJZOE8KXFL2imR8hnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTvc00iV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTvc00iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26567C4CEF1;
	Wed,  8 Oct 2025 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759891045;
	bh=EZ4OzVCojIpK53t+JDF/3YQ2rUwT/gdZNi+ytJTZpN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTvc00iVy4/mN0PP2fJMaKWdB86Fc/GAH9VtVdYO4DUopsDwETaFpKYqVgKgwSJ99
	 VYTtbgyN26OkbjGaDqiN6lD/6Yi5IIcjBvFgxs//Mvg/a6uRUVApDYIewkJIFlyL/V
	 kg0s4gNzP4phac/ti5V6aXR87tL+TL85YeoKXdBAULjY4KnszFgGMvRwe4cU8aVGJD
	 l0zSXhvLmvYBnsk6JfT+qhWQHLf/7mE6w2jm0VSQ/frCeuRgQB6WZsvhQwjg3Aum3z
	 rqH7k4dZnuB8VbjCfOQLt77l9QD9M0fOq0BcuGP59OxOhz6H4/SzkElPnfE67hkA9A
	 brmwqw5gSnCbw==
Date: Tue, 07 Oct 2025 16:37:24 -1000
Message-ID: <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: sched_ext and large cpu counts
In-Reply-To: <20251007133523.GA93086@pauld.westford.csb>
References: <20251007133523.GA93086@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Can you please see whether the following patch resolves the problem?

Thanks.

--
tejun

----- 8< -----
From 4d7f7d24e90fba47bb08ddbeb8668123b4bbab1b Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 7 Oct 2025 16:23:43 -1000
Subject: [PATCH] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using
 kvzalloc()

On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
boot because it exceeds the 32,768 byte percpu allocator limit. The allocation
size is sizeof(unsigned long) * nr_cpu_ids, which becomes 33,792 bytes with
4224 CPUs.

Restructure scx_kick_cpus_pnt_seqs to use DEFINE_PER_CPU() for the per-CPU
pointers, with each CPU pointing to its own kvzalloc'd array. This avoids
percpu allocator size limits. Additionally, move allocation from boot time to
scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
consumed when sched_ext is active.

Reported-by: Phil Auld <pauld@redhat.com>
Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 59 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..042fc73fb141 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -67,8 +67,13 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
-/* for %SCX_KICK_WAIT */
-static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
+/*
+ * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of sequence numbers.
+ * The arrays are allocated with kvzalloc() as size can exceed percpu allocator
+ * limits on large machines. O(nr_cpu_ids^2) allocation, allocated lazily when
+ * enabling and freed when disabling to avoid waste when sched_ext isn't active.
+ */
+static DEFINE_PER_CPU(unsigned long *, scx_kick_cpus_pnt_seqs);
 
 /*
  * Direct dispatch marker.
@@ -3850,6 +3855,16 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
+static void free_kick_cpus_pnt_seqs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		kvfree(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
+		per_cpu(scx_kick_cpus_pnt_seqs, cpu) = NULL;
+	}
+}
+
 static void scx_disable_workfn(struct kthread_work *work)
 {
 	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
@@ -3986,6 +4001,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	free_percpu(scx_dsp_ctx);
 	scx_dsp_ctx = NULL;
 	scx_dsp_max_batch = 0;
+	free_kick_cpus_pnt_seqs();
 
 	mutex_unlock(&scx_enable_mutex);
 
@@ -4348,6 +4364,28 @@ static void scx_vexit(struct scx_sched *sch,
 	irq_work_queue(&sch->error_irq_work);
 }
 
+static int alloc_kick_cpus_pnt_seqs(void)
+{
+	int cpu;
+
+	/*
+	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
+	 * can exceed percpu allocator limits on large machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		WARN_ON_ONCE(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
+		per_cpu(scx_kick_cpus_pnt_seqs, cpu) =
+			kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
+				      GFP_KERNEL, cpu_to_node(cpu));
+		if (!per_cpu(scx_kick_cpus_pnt_seqs, cpu)) {
+			free_kick_cpus_pnt_seqs();
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 {
 	struct scx_sched *sch;
@@ -4490,15 +4528,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	mutex_lock(&scx_enable_mutex);
 
+	ret = alloc_kick_cpus_pnt_seqs();
+	if (ret)
+		goto err_unlock;
+
 	if (scx_enable_state() != SCX_DISABLED) {
 		ret = -EBUSY;
-		goto err_unlock;
+		goto err_free_pseqs;
 	}
 
 	sch = scx_alloc_and_add_sched(ops);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-		goto err_unlock;
+		goto err_free_pseqs;
 	}
 
 	/*
@@ -4701,6 +4743,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	return 0;
 
+err_free_pseqs:
+	free_kick_cpus_pnt_seqs();
 err_unlock:
 	mutex_unlock(&scx_enable_mutex);
 	return ret;
@@ -5082,7 +5126,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
-	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
+	unsigned long *pseqs = __this_cpu_read(scx_kick_cpus_pnt_seqs);
 	bool should_wait = false;
 	s32 cpu;
 
@@ -5208,11 +5252,6 @@ void __init init_sched_ext_class(void)
 
 	scx_idle_init_masks();
 
-	scx_kick_cpus_pnt_seqs =
-		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
-			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
-	BUG_ON(!scx_kick_cpus_pnt_seqs);
-
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 		int  n = cpu_to_node(cpu);
-- 
2.51.0

