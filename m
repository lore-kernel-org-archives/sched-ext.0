Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102165;
	b=lbWcnF0fF4R98ENFubeDtlqonvKOO/W9ssyE7Sg68xoa2BVI6XXeEo0eLygXz+b8LWsk
	 Wa891YpnaIv8js8uOGtxB1/IAiCaWwuRIQ2Y1kRcZsKcAd54O2JDfyGfPOx+LRwjecVhd
	 dMCADkRrjVclJ8Ho8tTt3OlKrw7kjYiMAaP6xYMdwQRzf2W9gJXvenHjlSprkL0HWXfOM
	 VVNvGedz3ECEjtfrW6yHaYB+NkqgJsd7O222DS+vmyIXxTjWT4eQGB4XU3/fF9AGwQIqp
	 8yGvMFgn4ioiscy2PLnZ3iWK2jHr95zqSQNgY50F8qyPyOH3IHOwKMgSY6IOot8yQfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=l8DQLQcXXChdw8BNf5nleHOTswysdszObtZfOfnh2QE=;
	b=CZGTDm9yk32zRW1hdzYQIfRNfyo+5Mis+xNPAn44Q6waQTCHASI7wursj1mkKOaGiHbW
	 pCiQV1SZDjO1ZyUF0QVoQNsa47qyIjtlvQXTueytm8A013JfDHY6q7qqU5t4loZs4FaG7
	 dq+Mkk+eQrCbS7xdEXTryQ/vfMEpMvE0shPg9h/nCYq01/Qo/sMnPJp7mT1gxkxk3ZgKy
	 IBmAJEdooNxu8qasGqIyQfZyemMm2sUc86jI9QO8D7tQ5s6UFcpa0Xkrm/MyTi7+lBo0Z
	 YmvkGsA7K3j0Idfebg8isPwh0IhA5jUDI1rci+de2woGWwtoZa53IrbdnuMMZ9PdaOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=DWbbIRWF;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFF606A31A;
	Tue, 27 Oct 2026 11:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CBFF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=DWbbIRWF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l8DQLQcXXChdw8BNf5nleHOTswysdszObtZfOfnh2QE=; b=DWbbIRWFUzvB7N+LuyeaAWtKhK
	SHrET7nN/q1mtpxtFwMELWMCBGMld5wu8jkWTWX8icikvYhhSOjfoRZ8Zn4rpPSFsy3HXfHqO5Z6x
	S7eKXZ0EW9h/j1yqPIgwbDn/kHrnYr16yMjAcdmOYPDCPYWIEJR/36aQPNtom8OrBtWIcZed5vWzJ
	AKC0ExQNqK382rhFMVSvyRLy0yI14tk3T8F7NxHTzwFAGLLcIg81ArLhbuKy5e+UGaxY1Dbrxi+p3
	xtdJodR7Ps9hf2QtVCTLuAmocKlDIBzCtl7PwGRBLJK/0YqkxiNSSOENhXlI1IEwpRQ8VBkqVg0C3
	n8meoByQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfmZ-0000000EtUm-2QP0;
	Tue, 27 Oct 2026 11:55:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7ECC0300DB9; Tue, 27 Oct 2026 12:55:58 +0100 (CET)
Date: Tue, 27 Oct 2026 12:55:58 +0100
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
Subject: Re: [PATCHSET v2 sched_ext/for-7.5] sched_ext: Add NUMA balancing
 support
Message-ID: <20261027115558.GL2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027105209.GF2668564@noisy.programming.kicks-ass.net>
 <auCNSY0fCBu9uIDB@gpd4>
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
In-Reply-To: <auCNSY0fCBu9uIDB@gpd4>

On Tue, Oct 27, 2026 at 12:38:49PM +0100, Andrea Righi wrote:
> On Tue, Oct 27, 2026 at 11:52:09AM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 27, 2026 at 05:13:29AM +0100, Andrea Righi wrote:
> > 
> > > Ideally the ultimate goal is to give BPF schedulers both controls that
> > > NUMA balancing combines: moving a task to the node where its memory is
> > > and moving the memory a task uses to the node where the task runs. This
> > > series provides the first: with the preferred node available, a
> > > scheduler can decide where to run the task. A second series, to follow
> > > once this one lands, will provide the second: a kfunc that lets a
> > > scheduler request the node a task's memory should migrate to.
> > 
> > Fair has no real control over the memory migration part either; why
> > would you want to give BPF that?
> 
> Yeah, that's a fair point and the wording in the cover letter is a bit
> too vague.
> 
> The use case behind the second part is accelerator/device locality,
> discussed at LPC in the sched_ext MC [1]: with multi-GPU systems the
> heaviest user of a task's host memory is often the device, which NUMA
> balancing can't see, since hinting faults only track CPU accesses. So
> memory follows the CPU even when it should stay close to the device, and
> today the only option is to pin everything with numactl and/or disable
> NUMA balancing.
> 
> But that needs to be discussed separately: as Gregory pointed out at
> LPC, NUMA balancing needs some cleanups first, and the right interface
> may not be BPF-specific at all (e.g., extending the home node concept of
> set_mempolicy_home_node() to NUMA balancing, or a device-aware hint in
> mm that both fair and ext could use, or something else).
> 
> The first step for now is to, at least, allow sched_ext to see the
> preferred node computed by NUMA balancing, which is what this series
> does.

Right, I think that came up at OSPM as well; regular numa balancing
would want this as well. This really should not be a bpf thing.
