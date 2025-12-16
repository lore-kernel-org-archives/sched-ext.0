Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C642C0276;
	Tue, 16 Dec 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887699; cv=none; b=VKpa6oIc8RStXe3ztoaLrIFpoLxkGYaobgMbw+MB7j5wUU32Zj6d34wR37BPkhK1uNJHyEvEOr1Zu+VcyqZ1aKSxI2i+hheSqx0iQlRi0SeVwPRUacNKDPQ5enfSliUDhRHJQFZkzHwIRHj9T2v6IRZ+8rVhuU4Oq8WKM9yBtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887699; c=relaxed/simple;
	bh=C4ZCtGaorY2iNcS2xCMFxHm2sey0F2S4YUTWK0bJQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT0YClI2EzRFJ+Shp8OfSftIAoemcfGAnl0/0jaSlKW5OyRRtC5nnL+YHk1Zi5wYTvIyhmg/46jfAUsK+A3RAIxSw/yg2bPNpj298GcNyOkw32qhvhW51QjMEAZRqWYLuXbIVRc1Ew2yCNpzGH2k/rCPGw25Evp1XFXUoa7kGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hmxnV4TY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hmxnV4TY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=luuWbl2V6fjTWQjqgSt8uiagh+rMcmA/i0xVdu1b7MI=; b=hmxnV4TY5JqOsp5efqDwifnZqh
	CqdWFyb6ZmC/3gAdrumkzPzjg+PBci6vcqq0w7sPTcqOaOsotRg5Ya68pu9TGJAaZjx+PjQrRLJ7Y
	2+wQrAEQZNvos8ZdpMpL8MkuVI/lTouV4l3GejRz9h6w+QRzw8XG27Z0w55Y+1bcSULNhgEmk3MfR
	KYTnnhtaUd9urfrN0qS618qW1Sadc0a3lc7cIqOG0t2vNfA5PdsI3eewFa7jSJsPXxJz6MfSJGlQZ
	6z7fNksV4Ui4Z8eCz6CjQSeDcuB8Dpsn0D3CuyHj/NDPPEDPxVn0WcQTm6SzZCynho+Rfpq8Q3nZO
	aVXwwweQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVTC1-00000004haW-0DlY;
	Tue, 16 Dec 2025 11:26:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20050300220; Tue, 16 Dec 2025 13:21:27 +0100 (CET)
Date: Tue, 16 Dec 2025 13:21:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Subject: Re: Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at
 sched_change_end
Message-ID: <20251216122127.GC3707891@noisy.programming.kicks-ass.net>
References: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>

On Tue, Dec 16, 2025 at 05:09:52PM +0530, Naresh Kamboju wrote:
> The following boot warning is noticed on qemu-arm64 devices booting
> Linux next-20251215 on wards.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> First seen on next-20251215
> Bad:  next-20251215 and next-20251216
> Good: next-20251212
> 
> Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is absolutely unreadable due to all the wrapping.
