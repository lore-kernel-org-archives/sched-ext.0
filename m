Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394B3E3D97;
	Thu, 28 May 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968007; cv=none; b=Q4aA2ypZ3cBXpp94yMV5QDjjgg1nowEldQepi7q/XjU3H/rjbjutaRtOYVcOx/3Q4//STj1+ti9UdcXSTeolLcT6533WKFDixxVfHCEjsA5Y6Ilz32OAPHm6PNnm4V2X5iWvbKz7y3sULHc+9lEH9g607GPqxA3Dos6ganLWKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968007; c=relaxed/simple;
	bh=JT6S69vw9tu8+C61XWe6OU4P35zkHsRxwdrIIGcss6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oehcQKObCcXFUiVIm+ix/7ixvFtP24s4/IwBZ+xdbydaNNibSc232EVigB5KcOTEpkDXfuqKZsqrq+7r9Df+vOxKZWXWOnFu2COBOupPVH6LYdrysrHVzbcHfG1ltuFy7Q5yytSYBf+eaZFsxQzXNuKfAi2C9RJ5XsENAJxPXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QGJBttsQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QGJBttsQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9c2VhDny6rdlPadMm2UdHAn3yzL39BpOKq2X3xvBVYI=; b=QGJBttsQsiCr+l3E6SFQ5H7M8W
	WbR1FjcnFk10qFuaJ2F8v6cb58EwChATaIuztSo/fCANihcSolBfM8TwaGjdSP0OIoXXVqil0TUSS
	/OdOwoGKKz2iT9OEGWzcZW2QWmn+K9rLVytlAD46HiN5RvZjXWjf/fI7EmC8eQ3k5ykv8aPiptgAS
	WytNJpEgwdFca94SjesqdKccxelsREpwn52/FSC/anrU7Jq9fGV5fMGKOtKO5kcpdgs2C7WRneHwp
	FMNWLTTjbZJD660JeuI1p3W7aiAV+HKSBtXgi9KvIgStjkCP1M1Veu1zEpPTXZv3HL5yYglBh2Ypm
	AXdEquZA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSYzG-00000004BJZ-1QXn;
	Thu, 28 May 2026 11:33:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD3B0300673; Thu, 28 May 2026 13:33:17 +0200 (CEST)
Date: Thu, 28 May 2026 13:33:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair
 dl_server bandwidth
Message-ID: <20260528113317.GD3493090@noisy.programming.kicks-ass.net>
References: <20260526164420.638711-1-arighi@nvidia.com>
 <ahblQnYT6Y9CTJMJ@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahblQnYT6Y9CTJMJ@jlelli-thinkpadt14gen4.remote.csb>

On Wed, May 27, 2026 at 02:36:18PM +0200, Juri Lelli wrote:
> Hi Andrea,
> 
> On 26/05/26 18:42, Andrea Righi wrote:
> > Currently, a fixed bandwidth is reserved at boot for both the fair and ext
> > deadline servers, and this reservation remains unchanged unless explicitly
> > modified via debugfs. As a result, both servers permanently contribute to global
> > bandwidth accounting, regardless of whether a BPF scheduler is active.
> > 
> > While unused bandwidth can still be reclaimed at runtime by other classes, this
> > static reservation prevents RT from fully utilizing available headroom in
> > situations where one of the sched_ext or fair class is guaranteed to be inactive
> > (for example, when no BPF scheduler is loaded, or when sched_ext runs in full
> > mode and replaces fair).
> > 
> > As discussed at the VIII OSPM summit in Cambridge [1], a better solution would
> > be to dynamically register and unregister deadline server bandwidth based on the
> > active sched_ext state. This allows the kernel to automatically enable bandwidth
> > accounting only for the scheduling class that is currently active, while
> > disabling it for inactive ones.
> > 
> > This patch series implements this automatic register/unregister logic. Moreover,
> > the sched_ext total_bw kselftest is also modified to validate the correct
> > behavior across the different scheduling configurations and ensure that
> > bandwidth accounting follows the expected state transitions.
> > 
> > [1] https://retis.santannapisa.it/ospm-summit/
> > 
> > Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw-v3
> > 
> > Changes in v3:
> >  - Don't bypass __dl_overflow() for detached servers in dl_server_apply_params()
> >    to reject oversized configs up front (reported by Sashiko)
> >  - A potential divide-by-zero in dl_server_apply_params() reported by Sashiko
> >    has been fixed in a separate patch (not introduced by this patch set):
> >    https://lore.kernel.org/all/20260526100502.575774-1-arighi@nvidia.com/
> >  - Link to v2: https://lore.kernel.org/all/20260526082954.550958-1-arighi@nvidia.com/
> 
> This looks now good to me.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!, I've stuck them in queue:sched/core for the robots to chew on.
There was an absolutely trivial reject in ext.c that I fixed up, so
something moved around there.

There is one little nit, but I'll reply there and that can easily be
done on top if we decide its worth it.
