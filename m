Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2B46D2C1
	for <sched-ext@lists.linux.dev>; Thu, 10 Sep 2026 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037662; cv=none; b=nZp5j9gOibOh8zRQmuXt5TBP8bxiLl0obk+JEplWfaCC2tE4HJXda/7nSXZg24c9GTdEJdEFW1epAQZgQiOwjiyEW3/j6GyWAQTqkW3Bm6OmaEi1YAmoKXHVgaVW0T84tASFhpr71QiQoBHIonQGg5ocosSlJTuSUtYNNA7j64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037662; c=relaxed/simple;
	bh=RbXmQFeSH7mmKX56IZaeqWN7oWfNBWP8fIZ7+tLYk7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWgnk+86dya8xzLleGf1WvlWHBx32pwKgF9omW55ec4BhnoVqL/PV9tyEa1cAqpgPYyZOSbrE1CNMNc1/Y06h8+1Vc+IF3RHqFYg5MdmShc3OgrSyLJl80lnaFJX0MgsEgKSrM3r/IJSO/9dkXIZJcaU3CdBb68GRamAMKWAF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i1hAAaBB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i1hAAaBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bP
	xug+HQ7zJoPKSaqtgyc4kVuXMtxt4YXY2vEMHagmw=; b=i1hAAaBB/sl0qesTxh
	DXwOgyZW8q9UDuAJDUbuPH5KYyqxNZnLzunZI4efNYR86lhw7DDDO6bn6DGAOJyQ
	JwgMDmZfwqo2rOOOxq28jedJuVE/LjnsvMtR2OZM7K+SctB0pvhGdHO46ewcnajV
	cJ5r90IuQSgcTsy95mUOdJdQU=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHs8EMjKJqpHWKQw--.37487S2;
	Thu, 10 Sep 2026 18:53:01 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 3/5] sched/cache: Drive cache task tick from execution context
Date: Thu, 10 Sep 2026 19:53:00 +0900
Message-ID: <20260910105300.2781275-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909110348.GZ4120091@noisy.programming.kicks-ass.net>
References: <20260909092901.2989564-1-sh_def@163.com> <20260909092901.2989564-4-sh_def@163.com> <20260909110348.GZ4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHs8EMjKJqpHWKQw--.37487S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1kAF43Ww4rAF48uF1xXwb_yoW8uw1xpF
	ZIk3s7WrWDKa1UXF17Zrn8X3Wfuws3J34j9FWkWFW8uF90qFyF9r95tw47uFsFy3yYkFy2
	vrWj9r9rKr1Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK4EiUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ1pyGqijA1kAgAA3C

On Wed, Sep 09, 2026 at 01:03:48PM +0200, Peter Zijlstra wrote:
> The result at this point in the series is:
>
> ~ static void task_tick_fair(struct rq *rq, int queued)
>   {
> ~         struct task_struct *curr = rq->curr, *donor = rq->donor;
>
> ~         if (donor->sched_class == &fair_sched_class) {
> ~                 struct sched_entity *se = &donor->se;
>
> ~                 if (se->on_rq) {
> ~                         unsigned long weight = NICE_0_LOAD;
> ~                         struct cfs_rq *cfs_rq;
>
> +                         for_each_sched_entity(se) {
> +                                 cfs_rq = cfs_rq_of(se);
> ~                                 entity_tick(cfs_rq, se, queued);
>
> +                                 weight = __calc_prop_weight(cfs_rq, se, weight);
> +                         }
> +
> ~                         se = &donor->se;
> ~                         reweight_eevdf(cfs_rq, se, weight, se->on_rq);
> +                 }
>           }
>
>           if (queued)
>                   return;
>
> +         /* Update state owned by the execution context. */
> +         if (curr->sched_class == &fair_sched_class) {
> ~                 if (static_branch_unlikely(&sched_numa_balancing))
> ~                         task_tick_numa(rq, curr);
>
> ~                 task_tick_cache(rq, curr);
> +         }
>
> +         /* Update state owned by the scheduling context. */
> +         if (donor->sched_class == &fair_sched_class) {
> ~                 update_misfit_status(donor, rq);
> ~                 check_update_overutilized_status(task_rq(donor));
>
> ~                 task_tick_core(rq, donor);
> +         }
>   }
>
>
> And that is rather weird given how task_tick() works. Please order
> things in a single donor_class and a single curr_class block. A second
> donor_class block makes no sense.

Agreed. I reordered task_tick_fair() so the final form has a single
scheduling-context block followed by a single execution-context block.

Patch 2 moves NUMA handling into the execution block, and patch 3 moves
cache handling into that same block. Misfit, overutilized, and core
scheduling work remain in the donor block.

The resulting layout is:

  if (donor->sched_class == &fair_sched_class) {
          entity_tick();
          reweight_eevdf();
          misfit/overutilized/core(donor);
  }

  if (queued)
          return;

  if (curr->sched_class == &fair_sched_class) {
          task_tick_numa(rq, curr);
          task_tick_cache(rq, curr);
  }

This excerpt shows that there is no second donor block.

Could you take a look at whether this layout addresses your concern? If so,
I will carry it into v5 and post the updated series.

Thanks,
Hui

