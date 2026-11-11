Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390182;
	b=GwHBA/WN+sVvUbpiVeJfGIW2drVU8AwnFiUw4w9Ub9ucSi+ZSAyTwXK9UAnkZoWD5NsQ
	 dxOQe/XF+g4NUErcEvH1uBFKMbvv7RyK0e7QoOqkQLQnDfFgWBGGSXFRmOEbTYbcFCuEQ
	 cTlKqEadGa7xaGcIKRK21iH4pXjfylFRsjWuA0JOLMBOjdE6hz6iQkEnzngpl7rQtYypW
	 3wKp2fyiMjrgM80yLPkxB9Yof8BDACVZC9H+0jONZXzMQnSyykFR7vMDFQsFV4LkhOjKS
	 uFNdW20B4LOFr/Tkbi43aNY00u6+ED4mdtX3JqDunpnWa+eQ+JcOdRi/fVReb1yrzeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390182;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=h6ax4dIlNvOyZOxsgskELRPbrZjl/raMdjGYwOqgRlw=;
	b=E5lB9/wTEEpqoNd01zrEPhSaEhfy3yijBdVHIVsjs63G1jGuY6x5NOdqOJ0jmv3Wh9tu
	 kyDIJ163t50dj2dihCqB+EPzpDklD346HjJ7++SNu9rvfq6B/dSvpHq+Ge+EH+sXO9xP2
	 SSGf/GsruenkRonnVb1Ipz1od9Fz5qOEjl4poaVyoqiKNvDhoDKmAs7t5VjBibmrvvds3
	 cQ0EovTzNo/gaW19fN7H2AvoOLn1a0K89w4G7jgdlaT/PVd++AZERy4GFoZJNRaYSCCET
	 uPVDLZzf8FSNqb/7oCzEShDuLyFK6u/54XwmOR1J7v8DyYfWcUFMtdCfVKQXFcqHl9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=i8cPZpHv;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D10606A326;
	Wed, 11 Nov 2026 09:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=i8cPZpHv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h6ax4dIlNvOyZOxsgskELRPbrZjl/raMdjGYwOqgRlw=; b=i8cPZpHvIkykFMbkn1LwDTMDtg
	zTpbGvQ89Nzmww0M3FobcEXqVDFhSofBgKXIqdlp1RpqFTcCZuuzg5Ql8+k+Blgkx16Rlui/bVnIw
	qqsX7UXKFaXcCeEfc8yW/R2UsAVH9zTKAVdQg3REwsZUnWA/8K7UhP/9qdGw41sSnJmdWB0OaFhIq
	eoShPwUX83e7gay7o8P/rpoPQIRDzOMe920CM2mjHfu0XflJK0hdOkW4uyfWCiSuxjCk92fSicVJi
	L8oohW2YF7Jomx+4QZ9dbw33C4crW1FPJ/aoD4T01SH5CQ301A0ScPkHtW18fWlzBakFdFkXNDOZq
	OazZ2QWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR4r3-00000008zJW-0xgu;
	Wed, 11 Nov 2026 09:42:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BBFE30025D; Wed, 11 Nov 2026 10:42:56 +0100 (CET)
Date: Wed, 11 Nov 2026 10:42:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] sched: Lift cgroup update locking to core to
 prevent CFS/SCX divergence
Message-ID: <20261111094256.GY2668804@noisy.programming.kicks-ass.net>
References: <20261110151857.1864222-1-michalblk@google.com>
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
In-Reply-To: <20261110151857.1864222-1-michalblk@google.com>

On Tue, Nov 10, 2026 at 03:18:57PM +0000, Michal Blaszczyk wrote:
> Concurrent writes to cgroup control files (such as cpu.shares or
> cpu.weight) can lead to state divergence between CFS and SCX.
> 
> For instance, in cpu_shares_write_u64(), the CFS update is serialized
> by shares_mutex (internal to fair.c), but this lock is dropped before
> scx_group_set_weight() is called. The latter only acquires a read
> semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
> and act on the sched_ext update concurrently.
> 
> This serialization gap allows concurrent writes to interleave.
> As a result, the recorded state in CFS, the SCX internal bookkeeping
> (e.g., tg->scx.weight), and the BPF scheduler itself can end up operating
> on completely distinct parameters (pairwise distinct values).
> 
> Similar races are present in tg_set_bandwidth(), cpu_idle_write_s64(),
> cpu_weight_write_u64(), and cpu_weight_nice_write_s64().
> 
> Fix this by moving the CFS locking up into the core layer in
> `kernel/sched/core.c`. By acquiring these locks directly in the core
> write handlers, both the CFS and SCX callbacks are executed atomically
> under the same lock.
> 
> Fixes: 819513666966 ("sched_ext: Add cgroup support")
> Signed-off-by: Michal Blaszczyk <michalblk@google.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---

Thanks!
