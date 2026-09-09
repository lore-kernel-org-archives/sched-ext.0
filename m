Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313F53A89E;
	Wed,  9 Sep 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951855; cv=none; b=hMQrnzrkN3NdIqQE6odDsC3D7fHhy/cTGkwgAHr9atUt6ZR0y6pjC+7Yv5+uuACmxofnvkXHMTqQ5eqmhsYJrf1to8Lk+ANPOiJU4UHR+2tW0Bv2yLQb6pFAh2SgwXfNIC7mvTQPTu6PloKEa1t0aKa0FchiuomGHeo6xjymOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951855; c=relaxed/simple;
	bh=B4+5ODZ2NwtAW1xstLuz8NlOC9l3lopUlrDf8GQh800=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4gKUkZpWhrESRUHavPo3hgZoGHWFDr17z4lvyD+KxfRdwSk3pcoGuKHMqM3BTZwqhU8tgGYoqGlkaUU9BD/BIsrd6xWbX+Ehz85x8CFqGL06qmTyG8cKxpLpHMCaVp8fFQYkNkhJz8NAs5JCkZ+iWDR1+l1lMjoRR/b3YrU1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rPsprBAL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPsprBAL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TRMlATlyjfTqXYSIGq6rKSCntpJ8yjeuUoQlFGDtfSk=; b=rPsprBALUGfKX75it5yHfG00DH
	y8ORxtW/sqkwhc9KNB8gfayuousmxZPpwh8rwCYpj5QleStHKye7L7Ay6Pq/DnCHQMTlRv2fMtY1S
	R2bqIPQ1VTyzeTF512rrzea+UJoNVgLmbJecvdWtqdcH8/brdMXo/tVwDqH7riV9AIDCIcpgKqqNV
	m4fYLaq4uok0dC82LIFUTxkCmb5V+AMOO1w6EwLm2diiCxJhcqW/H05ir1QFH+9WybFYUvx4nkfpv
	vKL6ou+tc4c1VQ8m8vED/Bkqo3k8dmPPjAoTWRp+/rzWZv/GFCXOxHhtyliJhN9MFEJz58b4HMPET
	DA/eEscA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4G5m-0000000169x-0gxS;
	Wed, 09 Sep 2026 11:03:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 99AB73005AF; Wed, 09 Sep 2026 13:03:48 +0200 (CEST)
Date: Wed, 9 Sep 2026 13:03:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hui Su <sh_def@163.com>
Cc: mingo@redhat.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
	kprateek.nayak@amd.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, connoro@google.com, jstultz@google.com,
	arighi@nvidia.com, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 3/5] sched/cache: Drive cache task tick from execution
 context
Message-ID: <20260909110348.GZ4120091@noisy.programming.kicks-ass.net>
References: <20260909092901.2989564-1-sh_def@163.com>
 <20260909092901.2989564-4-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909092901.2989564-4-sh_def@163.com>



The result at this point in the series is:

~ static void task_tick_fair(struct rq *rq, int queued)
  {
~         struct task_struct *curr = rq->curr, *donor = rq->donor;

~         if (donor->sched_class == &fair_sched_class) {
~                 struct sched_entity *se = &donor->se;

~                 if (se->on_rq) {
~                         unsigned long weight = NICE_0_LOAD;
~                         struct cfs_rq *cfs_rq;

+                         for_each_sched_entity(se) {
+                                 cfs_rq = cfs_rq_of(se);
~                                 entity_tick(cfs_rq, se, queued);

+                                 weight = __calc_prop_weight(cfs_rq, se, weight);
+                         }
+
~                         se = &donor->se;
~                         reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+                 }
          }

          if (queued)
                  return;

+         /* Update state owned by the execution context. */
+         if (curr->sched_class == &fair_sched_class) {
~                 if (static_branch_unlikely(&sched_numa_balancing))
~                         task_tick_numa(rq, curr);

~                 task_tick_cache(rq, curr);
+         }

+         /* Update state owned by the scheduling context. */
+         if (donor->sched_class == &fair_sched_class) {
~                 update_misfit_status(donor, rq);
~                 check_update_overutilized_status(task_rq(donor));

~                 task_tick_core(rq, donor);
+         }
  }


And that is rather weird given how task_tick() works. Please order
things in a single donor_class and a single curr_class block. A second
donor_class block makes no sense.
