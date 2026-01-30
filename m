Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1266376BC2;
	Fri, 30 Jan 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775864; cv=none; b=TWTTRgy+tL+n4EYW6vQuYV/yETlSklfH8eEjWr2x2n2QEHvMy0zzX303OEg52XnqBtF8fKMgMbxE/7C5JDHIZ+Bj92zq+jM/qPFMZNjRl/4hKj+9I8AD9wig4itd7gtrQq2fnNLNno7vNzhMspg0ooua++QTn84VKzLX9lWWG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775864; c=relaxed/simple;
	bh=/U227tzly+Nw5nB93ctGDn5I49WjItoZgg3MuYZY5qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfJTDW7tw3d0EGCZPRJTn4IpYhWwUXYqZZXahmyPW20QwMp0xVTHiLa1sa1V5Zpr9jzIUAPf2SPzvfyRTsg5daBhb7bh2mC59A01ztOoV+Ejtd/wOerG1q2Ki2LwRcBuNxsT5gx0Hy9lyqGwUrFqUEvRUfClLHRHVC2dxoV6Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qp5OkFwb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qp5OkFwb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FHlKIUcRU0UGcoGtx1r8/+/NdwEqSNyxWlc6HG+RZvg=; b=qp5OkFwbblWYrWlPazjpJO3zet
	kqbutQokItFDRcKJqU2jS43Y6uINHfODdwltc4XqGqd5u0p6o1fvyL7tsoqN0POnEBGBMiKr7BgxI
	gUI8TDYFWpjFJzFkT63mb/cGEyIocWckWrpVy+cmfJTp1MhZWt5gZB1USHcFhz7YM9tsnsffEkLWo
	vmaun4bBrCxEfu3Vfkzs85MsTKbpJBTPiZcQthwpHPeQTkDcV2hYGhpiaHs5CNBj3/cjK0jq4cQ7q
	p4yybF0omIQd16WjtmZBGXkx9X6V9+cqNSWXXSMzb02LTrOi0/dGe/uN/bhOi0W2sut/UEFBrlqI1
	NwffKZWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlnXq-0000000Bls3-2GCq;
	Fri, 30 Jan 2026 12:24:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7636C300BD2; Fri, 30 Jan 2026 13:24:13 +0100 (CET)
Date: Fri, 30 Jan 2026 13:24:13 +0100
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
Message-ID: <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
References: <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
 <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXoSFOONWJmdyCQB@gpd4>

On Wed, Jan 28, 2026 at 02:41:40PM +0100, Andrea Righi wrote:

> Just to make sure we're testing the same thing, I'm currently using
> https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
> scx-dl-server.
> 
> I'm running this test inside virtme-ng:
>   $ vng -vb --config tools/testing/selftests/sched_ext/config
>   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall

Apparently you also have to actually have that runner thing built from
that tree.

Anyway, all I seem to be able to get (on x86) is PASS: 1 :/
