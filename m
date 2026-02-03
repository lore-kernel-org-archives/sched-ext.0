Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC3347DD;
	Tue,  3 Feb 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114860; cv=none; b=t0sD/Ft2dupzPkyAer3L+x+R5HHMHSdZBaINNiOcCKKDd+9MkauaPnD+4rWLu/v4e+oGXQtAVrPJyVd+hUmxYUqKhTL32l/TgoSU7lU+qSQufcCG9TBOWsvxp5mWYmrawUSYGNM6b4oPI2NdgVAMMNxLyCfFpQV8MDtD28XNP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114860; c=relaxed/simple;
	bh=9Ij8gdp4iKJxOZtyzJY6jYqNLHMEVBxJgwE046lVyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3oLL0o/DE/SFrfbCe51flHn6EGQ1D4l8TrrhUQCkmXe/p6mAJPssRZrR59RshHG2QF30voc21twg9MXip4ajYrDVRN0mdytgT99e0rj6CuXG7J601e2C4V2KzLlw+3x7wXZZz2wQl+v1a0/AyYTY4nKwSdYO4Vp6YMBzP8AKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gSjGUMZa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSjGUMZa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RE7rM3lWTmjRsWrI3KCV1ZwEGvzb4j7z+A5njPsdaak=; b=gSjGUMZaNewFuP9SX6hAOCJutM
	uteAq2TyQgODYDrfk1qUnHbEYOsfdahiaNFL23U5LyRHRwwsczXHH4LnMFgQcPr6dXo3zkypUXgs0
	5EbN0w3sCW46gCOW8FPgei0oG2z27oOSC/tVZMrLM/zD6lgCCS7JNd/kCEDzr+svTZE9Wv9QmKBaU
	mGW3PrWsjqNmnymm00wz+/yumzCdfiMvyyanNNqWDOE1SUWWQqMZzEK9S4li7V4zdjKjcE2wwajw0
	8RXqgD5Lr6TU8aF2hHKaOP0PDF3ZmlFyejDCb9JBejyePZV/cMphu4SSpZGZV18diJDi6CbRqSYhc
	wu/1URLA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnDjV-0000000G35b-0DVD;
	Tue, 03 Feb 2026 10:34:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6FD13300208; Tue, 03 Feb 2026 11:34:07 +0100 (CET)
Date: Tue, 3 Feb 2026 11:34:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/debug: Stop and start server based on if it
 was active
Message-ID: <20260203103407.GK1282955@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
 <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
 <aYEnK57vUwtgGXwH@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEnK57vUwtgGXwH@gpd4>

On Mon, Feb 02, 2026 at 11:37:31PM +0100, Andrea Righi wrote:

> Or:
> 
>     pr_info("%s server %sabled in CPU %d%s\n",
>               server == &rq->fair_server ? "Fair" : "Ext",
>               runtime ? "en" : "dis",
>               cpu_of(rq),
>               runtime ? "" : ", system may crash due to starvation");

Yeah, I noticed it was a bit wonkey. I made it thus.

> > +	}
> > +
> >  	*ppos += cnt;
> >  	return cnt;
> >  }
> 
> I like that, it should fix the issue.

There is one more issue when dl_server_apply_params() fails, in that
case we should test old_runtime to determine if we should (re)start the
dl_server.

I've ended up with this.

---
Subject: sched/debug: Fix dl_server (re)start conditions
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Feb 3 11:05:12 CET 2026

There are two problems with sched_server_write_common() that can cause the
dl_server to malfunction upon attempting to change the parameters:

1) when, after having disabled the dl_server by setting runtime=0, it is
   enabled again while tasks are already enqueued. In this case is_active would
   still be 0 and dl_server_start() would not be called.

2) when dl_server_apply_params() would fail, runtime is not applied and does
   not reflect the new state.

Instead have dl_server_start() check its actual dl_runtime, and have
sched_server_write_common() unconditionally (re)start the dl_server. It will
automatically stop if there isn't anything to do, so spurious activation is
harmless -- while failing to start it is a problem.

While there, move the printk out of the locked region and make it symmetric,
also printing on enable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |    5 ++---
 kernel/sched/debug.c    |   32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1784,7 +1784,7 @@ void dl_server_start(struct sched_dl_ent
 {
 	struct rq *rq = dl_se->rq;
 
-	if (!dl_server(dl_se) || dl_se->dl_server_active)
+	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime)
 		return;
 
 	/*
@@ -1882,7 +1882,6 @@ int dl_server_apply_params(struct sched_
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 	unsigned long cap;
-	int retval = 0;
 	int cpus;
 
 	dl_b = dl_bw_of(cpu);
@@ -1914,7 +1913,7 @@ int dl_server_apply_params(struct sched_
 	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 
-	return retval;
+	return 0;
 }
 
 /*
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,9 +338,9 @@ static ssize_t sched_server_write_common
 					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
-	struct rq *rq = cpu_rq(cpu);
 	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
-	u64 runtime, period;
+	u64 old_runtime, runtime, period;
+	struct rq *rq = cpu_rq(cpu);
 	int retval = 0;
 	size_t err;
 	u64 value;
@@ -350,9 +350,7 @@ static ssize_t sched_server_write_common
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
-		bool is_active;
-
-		runtime = dl_se->dl_runtime;
+		old_runtime = runtime = dl_se->dl_runtime;
 		period = dl_se->dl_period;
 
 		switch (param) {
@@ -374,25 +372,23 @@ static ssize_t sched_server_write_common
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(dl_se);
-		if (is_active) {
-			update_rq_clock(rq);
-			dl_server_stop(dl_se);
-		}
-
+		update_rq_clock(rq);
+		dl_server_stop(dl_se);
 		retval = dl_server_apply_params(dl_se, runtime, period, 0);
-
-		if (!runtime)
-			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
-					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
-
-		if (is_active && runtime)
-			dl_server_start(dl_se);
+		dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
 	}
 
+	if (!!old_runtime ^ !!runtime) {
+		pr_info("%s server %sabled on CPU %d%s.\n",
+			server == &rq->fair_server ? "Fair" : "Ext",
+			runtime ? "en" : "dis",
+			cpu_of(rq),
+			runtime ? "" : ", system may malfunction due to starvation");
+	}
+
 	*ppos += cnt;
 	return cnt;
 }
