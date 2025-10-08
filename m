Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FA189
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960098; cv=none; b=R63fASzlb8uDzAJVFYBgfkvG4kLYgs39hk9sXo3Ch9iR5QeZBm/aFcq3PzqlzWpgr1KezwQwdd44Zg5LPQjg7ECA01RwkZ6glZGhrL3BAHTVytL/0BILh7/gF6eQQgrb2CYQNK4OD0RFeZdH7q6VMhRp8FRH978w9Nx6ZrRWq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960098; c=relaxed/simple;
	bh=hnN6sE/0pFAjC8RoaLB30VPKKyUpugKKyrkJm7M89gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe5VzgWvC2kDEwr7lSOuG84CdziDLc4TOMzK1qBl0L4ytv8wHBPi+TbeC5Qe10MY8x32SiWN37OZcmqxZvPGDzKttodECaMrHnq16eH17m/Z0eKDF54bV0GYZkky4IzPu6KpSLmfUvJYppa7dCbCel1kO9rJxys+XE73mAs/UxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+vc8dkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+vc8dkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F258C4CEFE;
	Wed,  8 Oct 2025 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759960097;
	bh=hnN6sE/0pFAjC8RoaLB30VPKKyUpugKKyrkJm7M89gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+vc8dkCm27n1UB3dPu68m/ggQ41hOimZXyOeeFxWmAJ9UJAHXxPvJ010IsxiD2I+
	 jP9NDvvD65FMDgM1QLKN5i2GACgukDsi9xGGqNIQrFRNs/ddIHSp5c1RsoxcNdcdJL
	 L7E1/0AHLft5bt/XV28IaPU5p5/Mf9RIYe2ckzz2c9Z67FU0zqeu01AHVbuclKiO+F
	 iuHIMNSgZaVE3cCbeIENb994z8JsccCTZbKK14/iy5PqIN8t4pdEIz3D4EIteacMWC
	 b4nTfTRE3MqGi1xyQGVOf3wvQmBFumK6kMWZlHIGmXkp1NJi55gg77PfYzxzGMWlwg
	 GHHf3C1x1Oc1g==
Date: Wed, 8 Oct 2025 11:48:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [PATCH v2] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using
 kvzalloc()
Message-ID: <aObcIMFpUoMy7vJI@slm.duckdns.org>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObPQF1-o-Uek7bd@slm.duckdns.org>

On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
boot because it exceeds the 32,768 byte percpu allocator limit.

Restructure to use DEFINE_PER_CPU() for the per-CPU pointers, with each CPU
pointing to its own kvzalloc'd array. Move allocation from boot time to
scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
consumed when sched_ext is active.

Use RCU to guard against racing with free. Arrays are freed via call_rcu()
and kick_cpus_irq_workfn() uses rcu_dereference_bh() with a NULL check.

While at it, rename to scx_kick_pseqs for brevity and update comments to
clarify these are pick_task sequence numbers.

Reported-by: Phil Auld <pauld@redhat.com>
Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 88 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..217c80d0105c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -67,8 +67,19 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
-/* for %SCX_KICK_WAIT */
-static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
+/*
+ * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task sequence
+ * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
+ * allocator limits on large machines. O(nr_cpu_ids^2) allocation, allocated
+ * lazily when enabling and freed when disabling to avoid waste when sched_ext
+ * isn't active.
+ */
+struct scx_kick_pseqs {
+	struct rcu_head		rcu;
+	unsigned long		seqs[];
+};
+
+static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
 
 /*
  * Direct dispatch marker.
@@ -3850,6 +3861,25 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
+static void free_kick_pseqs_rcu(struct rcu_head *rcu)
+{
+	struct scx_kick_pseqs *pseqs = container_of(rcu, struct scx_kick_pseqs, rcu);
+
+	kvfree(pseqs);
+}
+
+static void free_kick_pseqs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
+
+		call_rcu(&(*pseqs)->rcu, free_kick_pseqs_rcu);
+		RCU_INIT_POINTER(*pseqs, NULL);
+	}
+}
+
 static void scx_disable_workfn(struct kthread_work *work)
 {
 	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
@@ -3986,6 +4016,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	free_percpu(scx_dsp_ctx);
 	scx_dsp_ctx = NULL;
 	scx_dsp_max_batch = 0;
+	free_kick_pseqs();
 
 	mutex_unlock(&scx_enable_mutex);
 
@@ -4348,6 +4379,34 @@ static void scx_vexit(struct scx_sched *sch,
 	irq_work_queue(&sch->error_irq_work);
 }
 
+static int alloc_kick_pseqs(void)
+{
+	int cpu;
+
+	/*
+	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
+	 * can exceed percpu allocator limits on large machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
+		struct scx_kick_pseqs *new_pseqs;
+
+
+		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
+
+		new_pseqs = kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
+					  GFP_KERNEL, cpu_to_node(cpu));
+		if (!new_pseqs) {
+			free_kick_pseqs();
+			return -ENOMEM;
+		}
+
+		rcu_assign_pointer(*pseqs, new_pseqs);
+	}
+
+	return 0;
+}
+
 static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 {
 	struct scx_sched *sch;
@@ -4490,15 +4549,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	mutex_lock(&scx_enable_mutex);
 
+	ret = alloc_kick_pseqs();
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
@@ -4701,6 +4764,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	return 0;
 
+err_free_pseqs:
+	free_kick_pseqs();
 err_unlock:
 	mutex_unlock(&scx_enable_mutex);
 	return ret;
@@ -5082,10 +5147,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
-	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
+	struct scx_kick_pseqs __rcu *pseqs_pcpu = __this_cpu_read(scx_kick_pseqs);
 	bool should_wait = false;
+	unsigned long *pseqs;
 	s32 cpu;
 
+	if (unlikely(!pseqs_pcpu)) {
+		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_pseqs");
+		return;
+	}
+
+	pseqs = rcu_dereference_bh(pseqs_pcpu)->seqs;
+
 	for_each_cpu(cpu, this_scx->cpus_to_kick) {
 		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
@@ -5208,11 +5281,6 @@ void __init init_sched_ext_class(void)
 
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

