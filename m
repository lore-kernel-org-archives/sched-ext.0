Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794259;
	b=4hED0607uAC7GZPALuv74zuYgBOTtO3qCTQUbygjiKG0RLESCcDVSxq+6l0tBPNOVm4f
	 CJju4G4j6wWJ07nKa5q5VNhzvHKNhCNvaroR4QC1L76SSODZTp2WKvH8kerK8NGe2X1Dr
	 m1LBYG+cIrZKb0DfP2DtIfUEwOc7GNcVHztiz5/sTsk4xa6CNo2UYxlZNcCA9sBZ8YgnR
	 fkpWPjU+D/nXBUeoprybZ3dbIG5SnO9yhFhWlSbP1hX1RGzoXHkb/cPAtuSvWCACD+7Cu
	 tcUYn5RMzmt1jZ39LFCmTy3DyRAY1uk4ymS6B9jkPf3VlMstRplSuXReuG0da8tGHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X6AFLb9s7u+Xon8/nUZ2rh6cB0uMWRXakMaXootNgic=;
	b=VEnDHuS2gTl7BOQT+HYQgnzsmfVtU9oJZ8W/Kw2ohhz0WebKlUITwjAaOSNXuwJPgEWG
	 5gGG4bjOM1v7Suxft3NWVNTce/A1IbMq0ROCfQmCNlKz/0kp29QGiL/ko47ag9MFVxy0v
	 65/EhwaykfKXYXn1LBY9uuAACOy8nn+7Rn+L9wqJKaKPu4i1+jOZS9E9OQj920zBK4KjH
	 3GOh/IEm5GAyGgcCLDF+zkh0sDqylEB8k6NJ+yPpGLlEdogIE2leMaKnqTbYD0QPn/eWH
	 E4bmgC93SazP+y0qqs0VNR9bgqcTG9g4D3bg0UFVBjHTIgDY2OJDPM83LVqgbAk75rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7WiL7JL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B783606A31F;
	Fri, 27 Nov 2026 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7WiL7JL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B56E1F0089B;
	Fri, 27 Nov 2026 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794258;
	bh=X6AFLb9s7u+Xon8/nUZ2rh6cB0uMWRXakMaXootNgic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U7WiL7JLSPg7FvatCbumCgs1MGCMjm9Nm5y728QK+G7lRYVXHxwktT87qi2z9USQK
	 tDWnZL+HxqlZMLRFj1KJHedUeab6URm4r0Uv2OTQKVhpKQjWsCKzLcriLdjNAovbpK
	 0R7JEoih7INrYNO47/8vIEr44ZIvoo2oHi/D3hfh9gMHjxju1dpUm/LvnJO/ZbrxN1
	 pYO9eLVNLP7zSudBIgi2eY7O8asntAHPpJ1+hdfUVKUv73zm4JVJjU/3qcDuOARfKx
	 BT+g4tF+qZn3EQpiudxCFZQ89wNGcDsvkp53ogmEhKowAHGut0cmezPb4vTRPERhta
	 jkSwYk0a/Rrmw==
Date: Fri, 27 Nov 2026 05:44:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Start ext_server from
 the tick
Message-ID: <awmlUc3KmK8uSQoz@slm.duckdns.org>
References: <20261125103420.2785659-1-tj@kernel.org>
 <20261125135723.GD2668804@noisy.programming.kicks-ass.net>
 <c3516afe34fa11bb42976188b7546233@kernel.org>
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
In-Reply-To: <c3516afe34fa11bb42976188b7546233@kernel.org>

On Wed, Nov 25, 2026 at 06:56:14AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Wed, Nov 25, 2026 at 02:57:23PM +0100, Peter Zijlstra wrote:
> > Could you perhaps punt the responsibility to the DSQ? Each DSQ has both:
> >
> >  - a count of how many tasks it has
> >  - a sense of what CPUs it targets
> >
> > Right? So can it make sure nr_tasks CPUs of its destination are running
> > ext_server?
> 
> The problem is that runnable tasks may not be on any DSQ. The BPF scheduler
> can hold tasks in its own data structures between ops.enqueue() and
> ops.dispatch(), and the newer schedulers do. Also, only local DSQs have
> target CPUs. Any CPU's ops.dispatch() can consume from a user DSQ. So, all
> the kernel can tell is that something is runnable, and only ops.dispatch()
> knows which CPU it is for.

Any thoughts on this?

Thanks.

-- 
tejun
