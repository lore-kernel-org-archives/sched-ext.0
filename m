Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614C3A718C;
	Tue,  8 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854539; cv=none; b=hHL0VznMieD0zJ5UeTyq6u1jVKe7RVhPyteqUWrtbvbHuUn969b1Th+FDZFJRdgL773nHFdmiXXOp/k1s8wma8rHo/MeRcbhvMDLtbdQfim424uz3zjYdNKId82bzVf5ZYx7ZWdKZkzzyW385Rmh2OeYeOlHKsMIeFgkNvrlo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854539; c=relaxed/simple;
	bh=SIfeNo7QUvXd05ron26+2AO8RD1jSSsOlIre9dZiEv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdmhWzg4dDWEwslMG9ttcq1B4U2vmBdNLv8Y8wgQ28mPBswwf/k6X7feIbwCzwltdGXy+KoW3qsSyGL2Aer+Yz6ZVRDd/ijRc/YOJYjFqqDf6NvlsYj1jcEwBqgXsLyTF84bctB+7IbT9ZF01NYrbfdhEtSROEMuFQaMl++rE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hSptTPvc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hSptTPvc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sj5Jm0tKhZ5OcPXOSI+iQXmJY/DDoKrUk0kxaI0lQCI=; b=hSptTPvcqc2UXJkx9az/oisQD1
	9YHMu+syqlymAf9KMwdugHeq+ztUd8o74SFHOOBCP+toc7+YKnzf+TlN/gAAcOY8KgHhZnWQx9xWk
	L1DCMsrDPiArV+jleGG5riiVjLXkxgq3qt//JPHAe8sWDJ1OceI6rcLVdF/y9XAte0dVOfJbMT/ov
	7vOtpOQjZO+0vUkNWYbTnZDjNpa+nxn5OE/cKlZR9wFbQi863pkuNftjvk74CjK+r3Sm/I0JXslC6
	LOkmRqsrzPpeL2rkBYWZuIa8ErfLVGKlCNCXJKd413FfkUrlgm18QHBU57VUDx1zcpj0ZFlBg0Dzq
	wLLS9Isw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3qmN-0000000H5j0-3fQd;
	Tue, 08 Sep 2026 08:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE4D8300A9A; Tue, 08 Sep 2026 10:02:06 +0200 (CEST)
Date: Tue, 8 Sep 2026 10:02:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v13 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <20260908080206.GL4121339@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <apn6AdgyTr0btXDS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apn6AdgyTr0btXDS@slm.duckdns.org>

On Thu, Sep 03, 2026 at 12:51:45PM -1000, Tejun Heo wrote:
> Hello,
> 
> Other than some nits, generally looks okay to me from sched_ext POV and it
> looks ready to merge and iterate in tree. Peter, what do you think?

I'll try and have a look at things this week -- on a very cursory look
they do indeed seem fine.
