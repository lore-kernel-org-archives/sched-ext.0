Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA3285CA8;
	Mon,  2 Feb 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770067053; cv=none; b=rGAVbiaBKbQiogbPBA7wkxVHPN06zMxe9NIfE5+282YFPl8phlhqni50w1vlIZOTUx3K8IPWtuT4ODPNT/DHakcptD+tZUHb3sEhQKx/BtYwMcuL0u1QiQRJP9Ou3S+ipuUG9hMVeveU1n8k5xmGFu7Fi8t0fyZozRAp4qJdatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770067053; c=relaxed/simple;
	bh=dIU8zNd4WpFz/bJGMPTDRvdcxV2bIAr5TuQtufWkhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSORnnUSvU/gVpi3MRA1GVrsd5K3RUse2YoRksrt+AqoUQXKhGGBDEEjQKlO0Lcum8JF7qgdKEkcAVBOX8uquA1DJb3PdmtQ1FO216SQmi036JMVS6wTzSHQmkDUmI2iqVu9B5MUwy9GH/dY8u690u0orIiE7oGYA1ztJ8xPSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Un+HlJxp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Un+HlJxp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h43KjqCs2yLDCuhf2wzJ8HTaDcwWGea15kAgtDbRnIw=; b=Un+HlJxpAHmLOpNm80izzcG55F
	yYckxhJLg7Qb3CRT4rCa62WfTXdsrOWTiVvy4w65zh6H2BICibIl+PpeQR9hIGYs7e5clgLlcW4fl
	TpgNG5JHeJ9UWecuoSADjiNP3w3Q/Qxp/tuOv8AE28O6X56uuUH0/etgFGD0HCOyJZFZgiwZhFupZ
	MymZjda4dYzbg3uI+pKQ43pXamI+DsfqrSgWpjZfenOsUylcP7PvK/konW4xZJ8MlmvvppMUn62OR
	4UR9jw/JqnzlGuRO5dr63mr8n+ah7QFKSKR+ieCnBXYIB3byUvO9nPPBppvolbg0jhtUkQ+F8Y3vY
	rD9aIaKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn1IS-0000000H5jo-0qiz;
	Mon, 02 Feb 2026 21:17:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A49223008E2; Mon, 02 Feb 2026 22:17:23 +0100 (CET)
Date: Mon, 2 Feb 2026 22:17:23 +0100
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
Message-ID: <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211326.GN1395266@noisy.programming.kicks-ass.net>

On Mon, Feb 02, 2026 at 10:13:26PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 26, 2026 at 10:59:01AM +0100, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 93f009e1076d8..dd793f8f3858a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		update_rq_clock(rq);
> > -		dl_server_stop(&rq->fair_server);
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> > +			update_rq_clock(rq);
> > +			dl_server_stop(&rq->fair_server);
> > +		}
> >  
> >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> >  
> > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> >  					cpu_of(rq));
> >  
> > -		if (rq->cfs.h_nr_queued)
> > +		if (is_active && runtime)
> >  			dl_server_start(&rq->fair_server);
> >  
> >  		if (retval < 0)
> 
> Suppose runtime was 0, and gets incremented while there are already
> tasks enqueued, then the above isn't going to DTRT.

Something like so perhaps?

---
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 59e650f9d436..884bdf7a292f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -340,7 +340,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
-	u64 runtime, period;
+	u64 old_runtime, runtime, period;
 	int retval = 0;
 	size_t err;
 	u64 value;
@@ -352,7 +352,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime = dl_se->dl_runtime;
+		old_runtime = runtime = dl_se->dl_runtime;
 		period = dl_se->dl_period;
 
 		switch (param) {
@@ -382,17 +382,20 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 
 		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
-		if (!runtime)
-			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
-					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
-
-		if (is_active && runtime)
+		if (runtime)
 			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
 	}
 
+	if (!!old_runtime ^ !!runtime) {
+		pr_info("%s server %sabled in CPU %d, system may crash due to starvation.\n",
+			server == &rq->fair_server ? "Fair" : "Ext",
+			runtime ? "en" : "dis",
+			cpu_of(rq));
+	}
+
 	*ppos += cnt;
 	return cnt;
 }
