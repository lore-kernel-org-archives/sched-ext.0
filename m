Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976442050;
	Sun, 16 Aug 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920352; cv=none; b=TryNWbkF/5thlrmSNgwElzteftT3Q6Qw8LWbUslE5dEmtTVN/LK8Th8C52hq54FpKF3IXe18zhT8asvkCqV6U0RoJOp/MiUUBjEiqGslzlIRbzYXTfkofKMEwKOWa4+ipnAGwCQ2P7PVn3Gy/FROwz9/S50jcwVwgdzJnBsTSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920352; c=relaxed/simple;
	bh=hA+QPlfq4suuQVmbGwIr+Hd8nRLoIGL3HU1OZGJN03w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=V8rxlsCRew0R3g62rLZ48FPFqUcKu9yOwfrK3ZyOFkcfupj8DTD+OTfoy3UTrf2wHITCqCWshWv2xRMYC4wR1VTCKhYwwX6UYeaemkGEniVEo439fmdVQs+xsTmp5XRQ/FkwenoNVktMye4Ll8TCWf4fpY1CUZH65kjMOThmn7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3IWBO7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3IWBO7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4051F000E9;
	Sun, 16 Aug 2026 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786920351;
	bh=fvQR3Dhbt7QOGt9Lsfbl5J89iC2nn6hpJ/ZoY4ClyQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o3IWBO7nuTqwVGwjeTIPDnfSc5nY+VyEv3WqehP8Rn16rAZhhNtGN5QHsxmYfKO+r
	 BK5vcmQhJjAXCIUH07kpP4bkhv/Ww3beRJobSKGWaqTEKdT1cpRXWn8Deio/WhffjG
	 eV/iRl1Htx14969YgcshcZk83yTuO1KduNQEa8mzjDA50CRY6Far1rWC6p9igYz4Ia
	 qMr6TqONe2mjMQ91YAYsd8g2LvjIjL98/J5gEHpSRszb0/Pu83VcfJKnRfUmKhZov2
	 fvLV99icnpMx9F94iEyi3s7A4NCN8JbqfXjEet4Ipq+NzzKz3thuEAe5//ilZi9Oc5
	 TRGEhvTda8pTg==
Date: Sun, 16 Aug 2026 12:45:50 -1000
Message-ID: <f3ec3ccd48df8f75d6fb944151f0f928@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] sched_ext: Generalize the reject DSQ reenqueue path
In-Reply-To: <20260816173732.17162-12-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com> <20260816173732.17162-12-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Aug 16, 2026 at 07:35:09PM +0200, Andrea Righi wrote:
> @@ -1807,6 +1806,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  	}
>  	p->scx.dsq = NULL;
>
> +	if (dsq->id == SCX_DSQ_REJECT)
> +		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;

Two things bother me here. scx_dispatch_dequeue() is a DSQ unlink
primitive and managing the reason lifetime doesn't seem to belong in it.
And it leads to the following in scx_reenq_reject():

> 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> +		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
...
>  		scx_dispatch_dequeue(rq, p);
> -
> -		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> -			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> -		p->scx.flags |= SCX_TASK_REENQ_CAP;
> +		p->scx.flags |= reason;

where the drain clears the reason just to immediately put it back.

Can't we keep scx_dispatch_dequeue() oblivious of the reason and instead
clear it explicitly where its lifetime actually ends? ie. Clear directly
in dequeue_task_scx() after the DSQ removal and in the
SCX_DEQ_CORE_SCHED_EXEC path of set_next_task_scx(), and keep the
conditional helper for the reenqueue sites, maybe renamed to
scx_maybe_clear_reenq_reason() as clearing is conditional only there.
Then the drain doesn't need to save and restore anything.

Thanks.

--
tejun
