Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607F37755D;
	Fri, 30 Jan 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775988; cv=none; b=Katec0p+exFBNl2l2zWkXKR/g/NqQ4riEdCJrMvaQm4h6E2nfj+jT34+6LGj5Pp80SRPfaKR1ZuG1a3iL0LMbqrxLhY1LtOmdn4NTFkUx9VWbJ1k3HngqnWIA67WxdFFVl0JLk/IhPexIglbIRm9zJ/CSx+W18xxyIE/cjGHUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775988; c=relaxed/simple;
	bh=8NQTKZwdow21N+NI77FucccdUADGupKpYzFN0YYpVwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeDKHnK5kYt/uXKJdlIWoFF+29/vuoRoB12o/PM0ofx/TNRitkPdDBqerYjIwRIdB4pgKCTFwxwsrV/Ycj1Z27d0bR8VjLua7q/iEFgbjItvzPjO9uauOSHB698RyK22von9t04A7wNlk5vzC3jsn7mILwoNwo4gg4OciNcPJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zl3zlyOR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zl3zlyOR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fx+L9xs+ikPHiKEKkkUpgHA7pxhB9kWRY8VYwrtKJbE=; b=Zl3zlyORVPXRJbCU4yYM69aIfs
	kqvJzT238qG7OZ11WQs8cmEWqsAF46slILC5TVtA/dTlTUjahmydH+MDLAXzH6sh3iuhnEmD1Bj2R
	WKOR7Bm1uWus6sDvNu/ty9KZZLzhCXuhgMsboUCm4eKZsCvdKiB2Z8tfsnVYC16iQCAV4Md40wK0O
	/nWYGRTp+6FMoOpK3ieRKCQ1umWiQdMAdPRwPIaMqnykVt7pc4jOu5ZK2bJsWyj5+yGz7s59zWGiu
	teL3MIG+ZsE0y/DuJ3WU0hEAOXp0rf5hev6AzswYLCxD8ieX3sp9dTTG9pUzJ2cf8GlRuVSSLq1v4
	CggphMhQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlnZs-0000000Bm88-2laK;
	Fri, 30 Jan 2026 12:26:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12D7630331F; Fri, 30 Jan 2026 13:26:20 +0100 (CET)
Date: Fri, 30 Jan 2026 13:26:20 +0100
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
Message-ID: <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
References: <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130122413.GA3306656@noisy.programming.kicks-ass.net>

On Fri, Jan 30, 2026 at 01:24:13PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 28, 2026 at 02:41:40PM +0100, Andrea Righi wrote:
> 
> > Just to make sure we're testing the same thing, I'm currently using
> > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
> > scx-dl-server.
> > 
> > I'm running this test inside virtme-ng:
> >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> 
> Apparently you also have to actually have that runner thing built from
> that tree.
> 
> Anyway, all I seem to be able to get (on x86) is PASS: 1 :/

Argh, that tree has the dodgy 'fix' in. Let me go revert that.
