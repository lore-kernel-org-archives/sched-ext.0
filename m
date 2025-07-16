Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E41A76BB;
	Wed, 16 Jul 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672999; cv=none; b=R4gwWqZFFOI5XGkTmKt+3x6UAemhGyttXMmfpd+/WF0ubz5NdMwNcIsGPhdJ5rvjgIcMXj2OXTMEuxs31EtUbztVgvcLFMo3UifdtatYHgJHR972R35dzm278s3v3LhEOoPGZXANQhty0gqlHKzom3C388zln7Wq7Hp98irjlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672999; c=relaxed/simple;
	bh=AKxGT5AMNeusYivSHXb8iYN0qH5N9KGc2AIgJkaPLKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9KFAvuRlcA4isg80MCQqDjkxJqOm1a6bbDt4LACfUFbtdjnqvMSpodj+qq3p4gtDYXcaJYWhKLzred93dxEGzAfhOMuFnNs2SMHTu331tAwL7/ZLN2jQ+LTQqQdyETc9QfMLUTYAKJLssqypr5r6oed9C9uhJT2I+AdY8YYooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WOVBcWbz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOVBcWbz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yTMgUcFyj0zsIpb13A6gWhzlFrFD+gidzrUP42fMUAw=; b=WOVBcWbzjWlfYZpJajfN2CwZlk
	DuUPv9MrkC/a81JDpQB35SkMaIfsWsH8Ziks/zAo8tCvb7emLsN5uzVwmxbHXLgBW4dF0NIVFwdOK
	5QdS0MFRJvZwLIpmGGYUpSpNAXtc0/oUJM0wOri58bGD1XrqGI+PuTCYOMgTwHm8NHG5PW3OwLWlE
	vnnx38kzZUh+NL6L4Drp0IGZ1ZCF9gxsTzrncx5oZiTAN6agtFI/khE2wqVCT6hWP2ZXWuOFOTXfG
	RYa1b06gqobcGSnF30KseOKSwyCy+f4/l/qf1qAAhB69P2Yvn94w9ODSfyvkan4etYpgLx4bmIB6u
	U+R5bFOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2JE-0000000GiCN-1U4a;
	Wed, 16 Jul 2025 13:36:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2F67300186; Wed, 16 Jul 2025 15:36:31 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:36:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHel4LvT_Y5gpYfy@gpd4>

On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:

> The idea is to track the scx callbacks that are invoked with a rq lock held
> and, in those cases, store the locked rq. However, some callbacks may also
> be invoked from an unlocked context, where no rq is locked and in this case
> rq should be NULL.
> 
> In the latter case, it's acceptable for preemption to remain enabled, but
> we still want to explicitly set locked_rq = NULL. If during the execution
> of the callback we jump on another CPU, it'd still be in an unlocked state,
> so it's locked_rq is still NULL.

Right; but doing superfluous NULL stores seems pointless. So better to
avoid the store entirely, rather than making it more expensive and no
less pointless, right?
