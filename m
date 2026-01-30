Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9436C0D9;
	Fri, 30 Jan 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776870; cv=none; b=C5qEdgQLhj4my9vL8dwWn2r5YQAWB4gBR4gxuK/nOJWNlpYJ9Jlam1MnTSN3zaOC4Zyv0e8EQUA7O8n7wxQB29j8xuT4oVqX2+mLG5stYGMzc5lrg78oHvVz02NkFtcu02JAHzsmolw7hNmmbRMxmVQQxD2dTjEoLRQzN5JAfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776870; c=relaxed/simple;
	bh=/bnf7Um4yw5uSYLrBZyEad2Rkh39Lo/4F4LY/O1adIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBPhK0HaHDFN8NhDKut5tmDHNv4mwQ4jtSqcLmi71EML4ZKwOefET6Gg4HMBjwn4jO/CmqGLqzv/WMWk5TUynZ/+uTGUmR9PRbi3sPtbn4shBBMtbiGIUAAUITbEtEXtHUHfhrj87/KCLeblH3vzfohnr8PNfvIpoK1qc1F2vvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GIaUyvts; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GIaUyvts"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CBxGMWJyuuY8FbTh0s5cNeX5uQWsrplZ213ErXSQgXk=; b=GIaUyvtsg/PB76eGB9+fScgg1j
	fE5VBApCb/DIFQB1kIPHds7oxDaQHMj5hUFqHlEjJ+uuFYJbOLRSsJ0GUMSM0GAg0pCtfO5p4aXK0
	ZShm9yZxUoDqcgDbBo72uvBajo1tY2oBPxoNnRthnCRI1wSqjR/dpmuABx6SV5sRCO/ky4YoaHC1e
	li3SXnQ+8qM5ePAx4U+pfd2CJgpujams96NQhLosYnLQAp4JRUYB2MW0o+jXf1QtJIHTVOqUikCnU
	qPxHwiCvrMEBlaTztk7QjAUuM3g7HxvNb9gw+2JnICY09td0HSznBFiQCXAOLOxYgE80j+5ccPBv/
	VWnWpKNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlno5-0000000CAxj-3IFV;
	Fri, 30 Jan 2026 12:41:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7FB98300BD2; Fri, 30 Jan 2026 13:41:00 +0100 (CET)
Date: Fri, 30 Jan 2026 13:41:00 +0100
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
Message-ID: <20260130124100.GC1079264@noisy.programming.kicks-ass.net>
References: <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <20260130122413.GA3306656@noisy.programming.kicks-ass.net>
 <20260130122620.GB1079264@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130122620.GB1079264@noisy.programming.kicks-ass.net>

On Fri, Jan 30, 2026 at 01:26:20PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 30, 2026 at 01:24:13PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 28, 2026 at 02:41:40PM +0100, Andrea Righi wrote:
> > 
> > > Just to make sure we're testing the same thing, I'm currently using
> > > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git, branch
> > > scx-dl-server.
> > > 
> > > I'm running this test inside virtme-ng:
> > >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> > >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> > 
> > Apparently you also have to actually have that runner thing built from
> > that tree.
> > 
> > Anyway, all I seem to be able to get (on x86) is PASS: 1 :/
> 
> Argh, that tree has the dodgy 'fix' in. Let me go revert that.

This seems to work?

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 80c9559a3e30..aa3da4d3b8e3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1036,6 +1036,12 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 			return;
 		}
 
+		/*
+		 * When [4] D->A is followed by [1] A->B, dl_defer_running
+		 * needs to be cleared, otherwise it will fail to properly
+		 * start the zero-laxity timer.
+		 */
+		dl_se->dl_defer_running = 0;
 		replenish_dl_new_period(dl_se, rq);
 	} else if (dl_server(dl_se) && dl_se->dl_defer) {
 		/*
@@ -1654,6 +1660,12 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   dl_server_active = 1;
  *   enqueue_dl_entity()
  *     update_dl_entity(WAKEUP)
+ *       if (dl_time_before() || dl_entity_overflow)
+ *         dl_defer_running = 0;
+ *         replenish_dl_new_period();
+ *           // fwd period
+ *           dl_throttled = 1;
+ *           dl_defer_armed = 1;
  *       if (!dl_defer_running)
  *         dl_defer_armed = 1;
  *         dl_throttled = 1;
