Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B11344056;
	Fri, 30 Jan 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791242; cv=none; b=UMaE/hoVcVrNV07RO60anVz1l1QIu+XLet221TP22fQGJGUL2x9pjGIj1EsG0pRJz5/fAjhX/31IV9dE3NqakpB3do7KyUQqfh+DO9jrjDwAh0ZB9tfsMMJ6nVESxd06jB4DAgNuUbz03rCdmeWb0RYM8PmrkkDD7UzlmeLOhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791242; c=relaxed/simple;
	bh=ehyrSej1LcyTnj1aaEipNg27ANyexeuHTEm0ePeqtfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+LhqDcULg6il6Alh4YPR+xcJ6rNey7DmeJCPghooNh6fPirewjIgKW4E/T6V9EYNGm2KFLdOrqrpCm4DbfSWBr3PFzmC0zZv37MmHp/e0ph++tof4V/vtyCXXtxbLhz+m2MvdvWGxv9Cg1f/02ljilgFUM2aD4ScEvs3xFWOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZUHGOHZW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUHGOHZW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GB3r7ylEOOrPG5XQwJ102X55JjjgqUktXUXOxJym2y8=; b=ZUHGOHZWQF6pNVW/fLG6tXQ6yr
	dltPffnmcfxE6n22ud5oDaFqHHSob7E9gIQWZhxAORXf5VoGfQ7FvS4bP56s8ol4JMvgsV5a5hXvT
	V5pGSV+7WWx5yZqOn76Sk8p1Qhyg/czOwCnunDJf7SvpPmawUuhr6Qc1p3Mtrp152jqkV/A2Swgp7
	zpvP8iCg65ipybn2cmBZ2cxo3uVneHyNDkWAvgG3D7PDTYE1jH+9eIlY0splWLi5BYoBfTCk/vy1w
	3p+WUfrQz25a/xOQoRY9liogqvX0GglDSTrNCPnjpqRqjtLFiJWZBH0Zg+zLevQU5gakIW4YsjD++
	hk3yC6bg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlrXu-0000000C4Er-2P5f;
	Fri, 30 Jan 2026 16:40:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D577F300BD2; Fri, 30 Jan 2026 17:40:32 +0100 (CET)
Date: Fri, 30 Jan 2026 17:40:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <20260130164032.GA1206760@noisy.programming.kicks-ass.net>
References: <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
 <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
 <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
 <aXzblMyzyUoyNF36@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXzblMyzyUoyNF36@gpd4>

On Fri, Jan 30, 2026 at 05:25:56PM +0100, Andrea Righi wrote:

> > This seems to work?
> 
> Great! Makes sense to me, I re-ran all my stress tests and everything looks
> good on my side. FWIW,
> 
> Tested-by: Andrea Righi arighi@nvidia.com

Excellent!

> Can we route this through your branch / want me to send a new patch?

Yeah, I'll write a Changelog tonight somewhree and stuff it in tip.
