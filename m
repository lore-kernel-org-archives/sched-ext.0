Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098263;
	b=J4L/AJWCzNUadToPNoScwm7mRKQwHmq+rx9cfsPPPfFD/sK3mk3Mp/sh/uKWMvAYr85Q
	 YW9+4d5orG1e0rN0B1vwvgNWkl2IHtDeaXYTlvJxhEYShwrsUSX6ZkPBAcISHMLvj/rmt
	 85G2yeDTTEQB03R0qmSG8feL94CTq6fB2gNBx3KdBQTw8O0eQu1cbvZozFa765bJqCzy1
	 l3mEPPssp0ACXGL/JCjyOwB70vVUWfEY8YHRJOwEOMl/n4XdgEzcOwu0BvCxB8MiLPXlv
	 Y1TuA1EZ5JhtFVTNlY1GQbXoMCGX5zsxZEOPyo17H5gAv6L6TBgO7XGEb8hsT+7lB6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098263;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=k8fB5v0VJD9/B92Z+D7rduxvwMbh/rnBZw1GKRbsluc=;
	b=35sfyyDjNk814HLS+EL+U6xxu03zx9Z0DBmyh3V1YBCz3rOA/szpIJ4eD9VCpkSfyT5C
	 S5RFO1C6VJwjBm552TLuAMYtQAf/9pDMNixWj01QyYvgtDXi92lE8mLbimW+GyU0BaeA7
	 KjJxtcyWEFXS1kC55TRjxqqAd4ZIIF5uLgd8Keny4MqciibU6p0V5K8eAkfazwPQy+ycT
	 qDBqS6FJfGegINLYYdx8lhuRFc5Qg+UYMOwMomNr9SZdBek1yUOB07dVtPe9Ka+2UGH2v
	 Q297hTi+IKmhsltjzPftnoldF2o3OnmKZucRRIofze+H3XA1OflhM+7bRcl4kbq56OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kGxwJ31t;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EF606A9D0;
	Tue, 27 Oct 2026 10:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690EF606A9D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kGxwJ31t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k8fB5v0VJD9/B92Z+D7rduxvwMbh/rnBZw1GKRbsluc=; b=kGxwJ31tGZi1V4mqG2+XkJ4o7S
	EMkxMaN4gcTbHkJWaBNg7kdo6hKOmJHbCU72opmVhDU1b9ekcLuyDrfJZdJF/i0nRdddLkMHHSlW9
	9cZYiRFYX+sblIyqa6AcajKUws9VNBlQ0DV/D0efrvHw1r9PWfwryDYOVXezCAwlf5wC8yCydxpDm
	LpOfQeobfAdRwKlduOHm1JCp78kugjfrYVMYGknjcjUhhkh3P84vCr1o+Pwh0CmSCrmks8TAEsPip
	XUtuhx8Tc/oDNu3ZwOfm3KRT0PNchA3hebST6M1dtcv2Izmxyzg1Qtm0XcIezlmSVLnWdFPzObwOb
	7V5Kx7lw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLeld-0000000EkWe-499M;
	Tue, 27 Oct 2026 10:50:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5D0C300DB9; Tue, 27 Oct 2026 11:50:56 +0100 (CET)
Date: Tue, 27 Oct 2026 11:50:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Add a kfunc to read a task's preferred
 NUMA node
Message-ID: <20261027105056.GE2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-6-arighi@nvidia.com>
 <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
 <auBLYFDJ88gTxtLM@gpd4>
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
In-Reply-To: <auBLYFDJ88gTxtLM@gpd4>

On Tue, Oct 27, 2026 at 07:57:36AM +0100, Andrea Righi wrote:
> Hi Prateek,
> 
> On Tue, Oct 27, 2026 at 11:42:22AM +0530, K Prateek Nayak wrote:
> > Hello Andrea,
> > 
> > On 10/27/2026 9:43 AM, Andrea Righi wrote:
> > > +__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
> > > +{
> > > +#ifdef CONFIG_NUMA_BALANCING
> > > +	if (task_on_scx(p)) {
> > > +		struct scx_sched *sch;
> > > +
> > > +		guard(rcu)();
> > > +		sch = scx_task_sched_rcu(p);
> > > +		if (!sch || !SCX_HAS_OP(sch, set_numa_node))
> > > +			return NUMA_NO_NODE;
> > > +	}
> > > +
> > > +	return READ_ONCE(p->numa_preferred_nid);
> > 
> > Would the ext scheduler need the raw numa_preferred_nid when
> > sched_numa_balancing is disabled?
> > 
> > It may just be pointing to some stale value if NUMA balancing
> > was disabled at runtime right?
> 
> Right, if NUMA balancing is disabled at runtime the value stays at the
> last preference.
> 
> This is consistent with fair: disabling NUMA balancing at runtime only
> flips the sched_numa_balancing static key, p->numa_preferred_nid is
> never reset, fair stops acting on it in most places (e.g.,
> migrate_degrades_locality()), but not everywhere, find_idlest_group()
> still uses it in the slow wakeup path. So a BPF scheduler sees the same
> value that fair keeps and can decide whether to use it or not.
> 
> A more accurate approach could be to notify the sched classes when
> sched_numa_balancing changes (e.g., resetting the preferred node of all
> tasks when it's disabled and recomputing it when it's re-enabled), but
> that would be a significant rework, involving fair as well, and it's
> outside the scope of this series. I'd rather start by making ext
> consistent with fair, and then rework both in a more accurate and
> complete way as a follow-up, if we want.

But should we not cleanup first and then add shiny on top?
