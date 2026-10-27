Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098155;
	b=trL+iQ89u2MfzkTCnQETUuWfeoc16t/A0HFQnYQarrZeXmdqPdumgoJIn31qPU/muMC7
	 dQy/MwLhH8ADGj9WVCxaoBk47QvGXdflJyUL6GuV3hTA4HBsxGQM+Dextf3Iyj58enVKu
	 beJXSM+AJb2pzkjlOESr6vDK4oP+3Sp9VWSQ4AXnWwSidYufWp1kAQ8dqsK7R8Lkb059J
	 Dm8BuWbIa/E8D2DJcLfQFP/JXqUZcAftxT98NslQmJ3ESe5/ZYcp6q5eep1hIp2V0at8O
	 OilDp3nu+wzcW8+vaxZ3sZXduJHWhRLvEvDAMReY0Rg/S1LyoRN/x0GDx7P4jEnZIgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098155;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zPGzAkjhF9jYNNS0TSlj8VzbvpVXh28Fd+7heFECekw=;
	b=bOr1CRKdl5NBmQBn8kv5uvJctnFXGoV0FVVNxZpuzZfgAtR7Ps0mC7+aSIHy3bWf+0nI
	 wgGEt2g5L0lmM+duUGSoS8thM8yHupOeHeUVeVdwvQqi7uO5qRPD3wsTZ7TFh9ri6t9SS
	 AxSmQqO990OPFQCawiAdS3CvwcwFNjDen60KcImvqIhG70ThBsrjejtE16zmoDSXgv2o1
	 u6e0m152k4adJuqgqqBTZxO8KsAly0JCyREe6+GNzYJ9HIqWDHxfeto07UI01zWnXwp53
	 ingI6YzM5yS2ZlC6+WutkxeluHw1zlQLH3N1CvAdfoqiskNNwDiKt9rLb3INLlknTYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=I2oxQpPy;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A7606A31F;
	Tue, 27 Oct 2026 10:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C72A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=I2oxQpPy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zPGzAkjhF9jYNNS0TSlj8VzbvpVXh28Fd+7heFECekw=; b=I2oxQpPyjn9P8NRLi76d3V3cY0
	FniO8gJXqdDhaYn1+X26JdmAezcJPIUOWApGbz2ePbNYSvm/bHlv90fH9vB+2BR/gIen5/DohuaKw
	fyYMhXl9DuIEakbK/RZkzNp/PlppGTACYtns0qiarILtV0I6foFYOeJD96NVCfd0gIGik2Kv667gP
	HGyGFWo0kJWMnwDCAeK3XqNsmAfL5YalvrU9DQ8XtT8Qxf+6wpyYeCT37fHT3KksUHHXm5pB/b6nS
	OBlk5sqaKwakVNaoO2qfPNn9rkvW1yqekEU7Up7MF8jlkk6ZpdVqudFPv8IQqht7j7tf4TlEkcoIr
	TP6suoWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLejn-0000000D3WM-022z;
	Tue, 27 Oct 2026 10:49:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DB463300DB9; Tue, 27 Oct 2026 11:49:01 +0100 (CET)
Date: Tue, 27 Oct 2026 11:49:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] sched_ext: Report preferred NUMA nodes through
 ops.set_numa_node()
Message-ID: <20261027104901.GD2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-5-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027041536.3317971-5-arighi@nvidia.com>

On Tue, Oct 27, 2026 at 05:13:33AM +0100, Andrea Righi wrote:

> @@ -4528,6 +4543,15 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
>  
>  	if (SCX_HAS_OP(sch, set_weight))
>  		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
> +
> +	if (SCX_HAS_OP(sch, set_numa_node)) {
> +		s32 nid = NUMA_NO_NODE;
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +		nid = p->numa_preferred_nid;
> +#endif
> +		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
> +	}
>  }
>  
>  void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
> @@ -4834,6 +4858,20 @@ void sched_ext_dead(struct task_struct *p)
>  	}
>  }
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +static void numa_node_changed_scx(struct rq *rq, struct task_struct *p, int nid)
> +{
> +	struct scx_sched *sch = scx_task_sched(p);
> +
> +	if (task_dead_and_done(p) ||
> +	    scx_get_task_state(p) != SCX_TASK_ENABLED)
> +		return;
> +
> +	if (SCX_HAS_OP(sch, set_numa_node))
> +		SCX_CALL_OP_TASK(sch, set_numa_node, rq, p, nid);
> +}
> +#endif

I dont get this; why are you calling set_numa_mode() on enable? The
signal was sched_setnuma(), but now you're doing more.

Should not the existing enable method check p->numa_preferred_nid rather
than injecting this weird extra call?
