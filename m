Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131733DD867;
	Wed, 27 May 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881201; cv=none; b=sAgG+GfUeFZ42zBPTDslVfmPyNTGoUTo/Mfo+hNkpLS/qEWYQEVu1W2fsc0v+CWuJ5bV8Yp9FhzYDCIVi13xo1GrztHTO/HCxT5e2ZQe+cOMbIVzh6a/0rCahocL9jWt+cthN07+30YIH0mEjrJoELGLjfipJi7EmklZ3tPWwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881201; c=relaxed/simple;
	bh=4hClCAa9e7Q31r3uLLheYM0SKS/nzLeDiouC+gjcNEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVMjzoYU4pTKpuAIs2yDagJZleLjuAi3pSVudwrwTYjmnJQBgwG103ktVjbFNsz39a8NfpHQiTCyXG+z95ABZCKVGTneQCKGYvLUIuisIavgTEzP3X97UJuBwnT4WCAdoYrxxui10uI1cyiqxi3GvX82F6xt7yIUg9dKxGKULQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MqPqWvVz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MqPqWvVz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zmz7gvXLNFVU4mNYIz/OPYF+Wmm1sQQVAFvVlSg3PHo=; b=MqPqWvVzeciw+9k9ZHFlL1NsYH
	XwfwCHs432mQts+AoUa/ZLJy3aEtYxuIuF774C+/KgZKBhKndWv51ijInjwM1xeIq789f++JXXEmK
	//fmn+IgV0eMhiUtEW0/8VdRpUzT1uesPP0O9wZIK5Enm6ULyqtQYDrKNJzKz2vDIhJQCyWpDiN2I
	JCxQ5TZb3EkX9Z1ihZ4Vqi4h1H2U5gaAQypqyQnX5XiAkpOKaTbWd2/11LudEwZ8xAkADQFUOcuZe
	oMdahRJSu0yvSiGvZWsEglPUZB8reyYzBM5h7DTVwyvF4J8utQMOaOPXWcRFrXIbg+hjPeGIP2bHS
	7JYdjYZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSCP3-0000000DgjA-34PG;
	Wed, 27 May 2026 11:26:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48130300673; Wed, 27 May 2026 13:26:24 +0200 (CEST)
Date: Wed, 27 May 2026 13:26:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: quzicheng315@gmail.com
Cc: arighi@nvidia.com, brho@google.com, bsegall@google.com,
	changwoo@igalia.com, dietmar.eggemann@arm.com, haoluo@google.com,
	joshdon@google.com, juri.lelli@redhat.co, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	quzicheng@huawei.com, rostedt@goodmis.org,
	sched-ext@lists.linux.dev, tanghui20@huawei.com, tj@kernel.org,
	vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched_ext: Rebuild fair weight on ext to fair switches
Message-ID: <20260527112624.GT3126523@noisy.programming.kicks-ass.net>
References: <ahXWaL2BYLU6ukkO@gpd4>
 <20260527094037.3494671-1-quzicheng315@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527094037.3494671-1-quzicheng315@gmail.com>

On Wed, May 27, 2026 at 05:40:37PM +0800, quzicheng315@gmail.com wrote:
> From: Zicheng Qu <quzicheng315@gmail.com>
> 
> Tasks running on sched_ext do not use p->se.load as their active
> scheduling weight. Their nice-derived weight is maintained as
> p->scx.weight instead.
> 
> When such a task switches back to fair, CFS expects p->se.load to match
> the task's current policy/static_prio before the task is enqueued.
> However, not all ext to fair transitions rebuild p->se.load. For
> example, scx_root_disable() switches tasks back to fair directly, and
> partial mode can move a task from SCHED_EXT to SCHED_NORMAL through
> sched_setscheduler(). In the latter case, set_load_weight(p, true) runs
> while p->sched_class is still ext_sched_class, so reweight_task_scx()
> updates p->scx.weight but leaves p->se.load stale.
> 
> Rebuild the fair load weight in sched_change_end() when the class switch
> is from ext_sched_class to fair_sched_class. This is after the class has
> been changed and before the task is enqueued on fair, so CFS sees a
> native load_weight derived from the task's current policy/static_prio.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
> Changes in v2:
> - Move the fix from scx_root_disable() to sched_change_end() so the same
>   ext-to-fair rebuild also covers partial mode SCHED_EXT to SCHED_NORMAL
>   transitions through sched_setscheduler(), as Andrea pointed out.
> 
>  kernel/sched/core.c |  2 ++
>  kernel/sched/ext.h  | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b8871449d3c6..c694aabc451a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11200,6 +11200,8 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  	 */
>  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
>  
> +	scx_rebuild_fair_weight_on_class_switch(p, ctx->class, p->sched_class);
> +
>  	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
>  		p->sched_class->switching_to(rq, p);
>  
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
> index 0b7fc46aee08..1f8248c897af 100644
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -35,6 +35,14 @@ static inline bool task_on_scx(const struct task_struct *p)
>  	return scx_enabled() && p->sched_class == &ext_sched_class;
>  }
>  
> +static inline void scx_rebuild_fair_weight_on_class_switch(struct task_struct *p,
> +							   const struct sched_class *old_class,
> +							   const struct sched_class *new_class)
> +{
> +	if (old_class == &ext_sched_class && new_class == &fair_sched_class)
> +		set_load_weight(p, false);
> +}
> +
>  #ifdef CONFIG_SCHED_CORE
>  bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
>  		   bool in_fi);
> @@ -55,6 +63,9 @@ static inline int scx_check_setscheduler(struct task_struct *p, int policy) { re
>  static inline bool task_on_scx(const struct task_struct *p) { return false; }
>  static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
>  static inline void init_sched_ext_class(void) {}
> +static inline void scx_rebuild_fair_weight_on_class_switch(struct task_struct *p,
> +							   const struct sched_class *old_class,
> +							   const struct sched_class *new_class) {}
>  
>  #endif	/* CONFIG_SCHED_CLASS_EXT */

This is truly horrible. We have 4 class methods involved with switching
classes and you stick in a random call in a place that is called when no
class is changed.

Would not something like this work?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 62a2dcb0d03e..a2eb43bd73b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -14957,6 +14957,11 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 	detach_task_cfs_rq(p);
 }
 
+static void switching_to_fair(struct rq *rq, struct task_struct *p)
+{
+	set_load_weight(p, false);
+}
+
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	WARN_ON_ONCE(p->se.sched_delayed);
@@ -15351,6 +15356,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.prio_changed		= prio_changed_fair,
 	.switching_from		= switching_from_fair,
 	.switched_from		= switched_from_fair,
+	.switching_to		= switching_to_fair,
 	.switched_to		= switched_to_fair,
 
 	.get_rr_interval	= get_rr_interval_fair,
