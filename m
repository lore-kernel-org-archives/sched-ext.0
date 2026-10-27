Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102057;
	b=vyITeu4m22csjizLOyLKPCw8FcpFslnaW/CKn05tzyBg89jcsCzyGv/Y8uC6HqMNXAGT
	 Pc/40Uf8nY0Pmrs84jlx8DM8X50izK4wrP4fR1J6fdYz+I+lrnJ5tJP1Nevyvs/KPGHS6
	 eGNKgPhULx5tInvIg+hHD4IxbzAFFVISubV41kiSa8iKFw4HPoka5xEyBIX2XXmnBhN2K
	 RnsmfgjD+npIN12x1gnSffM6TPl4fPjZZUOcK6QnWfx2jD2Cbwyu/f7dgZrvr+UGXS2nr
	 fQ0QhjTTJXwITpMYKNWmuJa3xeIqFs6SVTLeoH4jb9qw6W/eAuONSS7dTlmEviSyDGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102057;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wJQB7n8JnxMUATD+GJvxjgtk7nAmzv0emR6KFf8YfPc=;
	b=tML5Nr3kUzZvqwxpJv3TF39NyhZvzaeJLTGb35otzf9OOFB2THokNtgenEci+lYF8C1V
	 rpPXyDE9snWYDNUkh7jqAG+nzToe9ctbF+2Hv9fimBoKKAurlMo3a0fY2OL31GJn+6zF0
	 Q1VSFfeKDjTFi4k70kHPTqJZByEnz99Cl00qXz2CH340PTEK7nSKU8W/ZR3YQGWLvBkpy
	 t/mu1tKtGi6SnUEefhfGvkXcsBkFUrS1czgm65jgJtRePyhdgLvCuOE2pus7S3ZgdLOcs
	 KzK/SoVE2Cbthmn+TkHL9Ngltoi+6wrzocfWI5difaDq6sfhf/jI4GZtUtaxFVvsAiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GM32159G;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B5606A31A;
	Tue, 27 Oct 2026 11:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 091B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GM32159G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJQB7n8JnxMUATD+GJvxjgtk7nAmzv0emR6KFf8YfPc=; b=GM32159GJwwlVPPJOx38dIb2Go
	/kIJkZZHIyidazcz9osxlX6NIv9yNgYYwrN+/IAdPp2c3icF7I9moNnAf7wY/Qa/aNGP9+rVOoMTl
	kTxtnuk0d7W8U3cikyPPaj6GJ+gN8GyiPd+V+K4+c9E/4tFbkMZPo0wNMChCyNjGp0uxNbfBq4PXT
	NRf1lUfJgik5pdHr+Qzx11E0+yUTGKnPmgkkVWVb10IVcDhS6FRBAi5ZToHNVlkrwiF7o6iBotSA7
	JjRkzzEtz/lPJY+MWWjXOLHlKHIfX01S+siTWV1M0brtxwDqNl4rriIc/OIBlO9JDIEhEl6Yn7SLY
	yW43JkAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfkp-0000000DLx2-28gn;
	Tue, 27 Oct 2026 11:54:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8E76302F53; Tue, 27 Oct 2026 12:54:10 +0100 (CET)
Date: Tue, 27 Oct 2026 12:54:10 +0100
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
Message-ID: <20261027115410.GK2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-6-arighi@nvidia.com>
 <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
 <auBLYFDJ88gTxtLM@gpd4>
 <20261027105056.GE2668564@noisy.programming.kicks-ass.net>
 <auCJHU4_ugxayy7i@gpd4>
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
In-Reply-To: <auCJHU4_ugxayy7i@gpd4>

On Tue, Oct 27, 2026 at 12:21:01PM +0100, Andrea Righi wrote:

> > But should we not cleanup first and then add shiny on top?
> 
> Fair enough. Looking more closely, I think there're only two places in
> fair that still use p->numa_preferred_nid when NUMA balancing is
> disabled at runtime: find_idlest_group() and the fbq classification in
> the load balancer (via rq->nr_numa_running / nr_preferred_running).
> Everything else is already gated by sched_numa_balancing.
> 
> Assuming I'm not missing anything, we can probably add a preparatory
> patch that gates those two on sched_numa_balancing as well, then make
> scx_bpf_task_numa_nid() return NUMA_NO_NODE when NUMA balancing is
> disabled. In this way the stale value is never used.

Sounds like a plan :-)
