Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C1309EFA;
	Mon,  2 Feb 2026 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066813; cv=none; b=WEUQmqbeob5ui94i4F8asAN8pLT3eO/acCPLEtCntIiPPaiqW9AY2uf3jMVdVHGg/Ih5W26qf++iLnmALemXMx5CVjqY+crHAirFIf7QHESnxc1RTSGpwjNiB8YDzAMQgeWHJDz0vezQirDZLjxQ+9Yj0qREfz6aL469QJqS68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066813; c=relaxed/simple;
	bh=A2TEDCmHNQw3KfAOOiitf6cZ0UH3FmjMX/ogFZgqS+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpiRgooH0I4Jp/BXgjw9v5rMHjpBxmdw6qLczhCHo5v5k/nUipYlJbGGJgCihOWL7HOWojTaFjtiL4ZzZcLF3F3n1lOZUB8+WYaalwiQsDBROUh8uDQeSZxq9hoKXVvmp2f48QrcMqPNyknzU4S3SPcNV7a/mOdIa0RTrHuqtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O0nU/yTX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O0nU/yTX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RZ4hDmr1BgzyifgTVLbUwlcl2C+wpvcV5wphlWBqXh8=; b=O0nU/yTXeNKPdE8sNYooMdY8YC
	SpeBEprb4k1NVzv0KKCZ6DzC305fXtW3ZDBzgzTaclEx6Dt/3D3+7VxJzavxKXcQ6a9oiBoTDyCmP
	R3o84zevaa/6AK2eWT7Cd+17nreMwvCwVDcw004NBGoJKVRZ0eXaYaSTI8QLFzK2nNstO5wGGorCj
	19HFfnO+cT57mE+dNcM6iiXxeE5E+XX8fN1DpnBZlEwLb9+B7HQTmacyOcAAPXPRyIWwRbpF4FJuJ
	sTUwQpNeWsEFhhIIjci4Rp+yfsXxsafIDDRoINi3ub6dtm06YdN+D5Ryj497VI91OSzqwrSduoxow
	e9SMLK/Q==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn1Ec-0000000FD4L-2cu3;
	Mon, 02 Feb 2026 21:13:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30362300BD2; Mon, 02 Feb 2026 22:13:26 +0100 (CET)
Date: Mon, 2 Feb 2026 22:13:26 +0100
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
Message-ID: <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126100050.3854740-4-arighi@nvidia.com>

On Mon, Jan 26, 2026 at 10:59:01AM +0100, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Currently the DL server interface for applying parameters checks
> CFS-internals to identify if the server is active. This is error-prone
> and makes it difficult when adding new servers in the future.
> 
> Fix it, by using dl_server_active() which is also used by the DL server
> code to determine if the DL server was started.
> 
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 93f009e1076d8..dd793f8f3858a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> +		bool is_active;
> +
>  		runtime  = rq->fair_server.dl_runtime;
>  		period = rq->fair_server.dl_period;
>  
> @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		update_rq_clock(rq);
> -		dl_server_stop(&rq->fair_server);
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}
>  
>  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
>  
> @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
>  					cpu_of(rq));
>  
> -		if (rq->cfs.h_nr_queued)
> +		if (is_active && runtime)
>  			dl_server_start(&rq->fair_server);
>  
>  		if (retval < 0)

Suppose runtime was 0, and gets incremented while there are already
tasks enqueued, then the above isn't going to DTRT.
