Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784B274B26;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258496; cv=none; b=p2KHsDQQBobYY+Alu2FpvkK6uB5YJUoCetUXXmGasZ+bBf56DWdYrcKwLJ9QwQCCYhH/B6nQDkpgfbD6NYgr3FhLDBiWb6mvPPAWIdGwBwE4i31rB4DX/O9xpSjPTiaK6IHTxiruPDz4SpMSSqkWNxmhxW4ze7u75afaB2V5+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258496; c=relaxed/simple;
	bh=hMTMVAUYzHqRhAq4AQ2jLbHCsiI29ze1O2ZyB081erI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SAFnSIXcE7X9Z1F+QaBd7tTs1/ZDzYNs1PM+ezsm9xhiJd/tsH5CWoc7eR6RfQefcaAfV4LqzLn7KQTbIMh2+hrTv0hxMc6+eiwO9rDJhgDg9qAPyAMBAYMo6ylq8Mh9MpT3Fo347L1Bsj9fmHsRi57UNcu2izNztrFeavJWvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTweGNYF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTweGNYF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tgxwiFXzP97N3LBO7St/JOaxT4aGfObT4S6QZDsdMv8=; b=LTweGNYF2ab9N4MOWFGznNg7cH
	led6361kIdq3/I+pQMzKcJYM6sB0dhXIKQmfHqIPlE1H6aAEMyKQLDnmMAqzPFR8EZXlEfYhjpbmo
	5KUkBwaorC7l8aGBj6ocuZm5IwcjwbeedV4PE1jZq+5AsEilcIkWiwntUy9JIHxMvi4z3lz7MNXWP
	z2RKBdQOnDt1Vrut7gWGa+bsDrZGSRyLRo5AcdhTSqoG34Pxfo7gtmMuKWMtuvcizbA9N6JqL2qNY
	Tt7yQEd/3J119trETSrBRD6spmNmlFEzXFLI921bPW7+UcrF4QUK/RwIrxxFUs607O/Aby9B1i1Fw
	WUeNSFtg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeE3-0000000BwrB-4268;
	Thu, 27 Nov 2025 15:48:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AF590302D3E; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127154725.647502625@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 3/5] sched: Change rcu_dereference_check_sched_domain() to rcu-sched
References: <20251127153943.696191429@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

By changing rcu_dereference_check_sched_domain() to use
rcu_dereference_sched_check() it also considers preempt_disable() to
be equivalent to rcu_read_lock().

Since rcu fully implies rcu_sched this has absolutely no change in
behaviour, but it does allow removing a bunch of otherwise redundant
rcu_read_lock() noise.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |    9 +--------
 kernel/sched/sched.h |    2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12853,21 +12853,16 @@ static int sched_balance_newidle(struct
 	 */
 	rq_unpin_lock(this_rq, rf);
 
-	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
-	if (!sd) {
-		rcu_read_unlock();
+	if (!sd)
 		goto out;
-	}
 
 	if (!get_rd_overloaded(this_rq->rd) ||
 	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
 
 		update_next_balance(sd, &next_balance);
-		rcu_read_unlock();
 		goto out;
 	}
-	rcu_read_unlock();
 
 	/*
 	 * Include sched_balance_update_blocked_averages() in the cost
@@ -12880,7 +12875,6 @@ static int sched_balance_newidle(struct
 	rq_modified_clear(this_rq);
 	raw_spin_rq_unlock(this_rq);
 
-	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		u64 domain_cost;
 
@@ -12930,7 +12924,6 @@ static int sched_balance_newidle(struct
 		if (pulled_task || !continue_balancing)
 			break;
 	}
-	rcu_read_unlock();
 
 	raw_spin_rq_lock(this_rq);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2009,7 +2009,7 @@ queue_balance_callback(struct rq *rq,
 }
 
 #define rcu_dereference_check_sched_domain(p) \
-	rcu_dereference_check((p), lockdep_is_held(&sched_domains_mutex))
+	rcu_dereference_sched_check((p), lockdep_is_held(&sched_domains_mutex))
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.


