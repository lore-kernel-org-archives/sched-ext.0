Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDB2ECD3A;
	Mon,  3 Aug 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789493; cv=none; b=dCXXl5PTvh4Jxl9Q75Jr9s/ZmTFamChYjihqL57enGwyeoOcouwD5dLByYMwOeLvNA+bNpGzlaS5S4BP49dbd1r2pXMXPMwVqsKb+iltC/Dr33GshJK3+kKE8WcXR7QyKL6mL+DtOvCRSoQxAnZyu1vsuhHqiYfmUcvfq0cVeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789493; c=relaxed/simple;
	bh=Bw+pKWWwh4m+F0WLr2fticQuCJ+NtEP9Ya5Gvpxzulg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoDuQpLXAe61XEVl8VEFYOKQ/4ng5woSIGFC7KgSlreafpvMTLTFkRreRmkx4iRF6D6NhRuTwiloiE7gmdZluHXEp/TusDjYtvKqhKlrJOVXYc0MsJ/ADpeKMLZy/Flg0Nn8dec10YiBETAq+84YvqwagpaeT2OgQDFEjfFJMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOvIXyqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOvIXyqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D51F000E9;
	Mon,  3 Aug 2026 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785789492;
	bh=JFzQYayJiB4mrmlyGS7Zp4tEcSazY3qDRnAtgXDDhvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOvIXyqK4Vy8Flquw427itKcUouOYfY1znwM+1VgmGTZALCXU4Idfbqn5S/LI3+rF
	 BKy68WmPpDPbrForJElvsPLOVis0USs4bsFiaPzGcDUSZRgraMmoPuTa3yL94cSxn3
	 yoi3uFloGUfx96M5G5BWtv0sxgrv6r2NamroCa4mkbNOKtDzzPD1Qf2J5KO+AkeGz0
	 Q19nOfAjA0MgzqQBHOOjmvN7A/FP3ThMMcANmLxFBah+/HDYQLSl8gs4in9o6n2ojb
	 QlTxBTL/tw810CGGxgqD0+dtakjmcGEnY7ME7WncuJtq6yB5ooZ0fDjhR2PgABZWbs
	 27wwbL2C9zFnw==
Date: Mon, 3 Aug 2026 10:38:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <anD8MxW5H0jBCppN@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-10-arighi@nvidia.com>
 <anD7hCGZ5v1TggPd@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anD7hCGZ5v1TggPd@slm.duckdns.org>

On Mon, Aug 03, 2026 at 10:35:16AM -1000, Tejun Heo wrote:
> On Tue, Jul 28, 2026 at 05:43:27PM +0200, Andrea Righi wrote:
> ...
> > +static void scx_reenq_reject(struct rq *rq)
> > +{
> > +	LIST_HEAD(tasks);
> > +	struct task_struct *p, *n;
> > +
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (list_empty(&rq->scx.reject_dsq.list))
> > +		return;
> > +
> > +	/*
> > +	 * Move tasks to a private list so a task re-rejected by
> > +	 * scx_do_enqueue_task() below isn't revisited this round.
> > +	 */
> > +	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> > +		u32 reason = p->scx.reject_reason;
> > +
> > +		/* migration_pending tasks should have bypassed to local DSQ */
> > +		if (WARN_ON_ONCE(p->migration_pending))
> > +			continue;
> > +		if (WARN_ON_ONCE(!reason))
> > +			continue;
> > +
> > +		scx_dispatch_dequeue(rq, p);
> > +		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
> > +
> > +		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> > +			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> > +		p->scx.flags |= reason;
> 
> Can you separate out code movement and actual changes into separate patches?
> Even for relatively simple changes, combining move and changes adds
> significant unnecessary review friction.

I wonder whether the reason can be carried in p->scx.flags from the
rejection site instead of bouncing through p->scx.reject_reason.

Thanks.

-- 
tejun
