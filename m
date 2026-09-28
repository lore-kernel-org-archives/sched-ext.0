Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA14F392B;
	Mon, 28 Sep 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625219; cv=none; b=YGf0uueYfEwr+AZ5nk5CRa8un+nF6W8w/H4BXj1vw+MWxzLZai1OcGDmUS4wAMQNTXhx1QfALTpULo9qlorMT6a/UPII47vRA65mrMzgBeKwYLiR2Vp5YCHm6uwrfEQevLBcvBm++l0Licl0mvZA2lvaC+ili3xpW5eJtoS5NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625219; c=relaxed/simple;
	bh=b/6bBnLWwtEcDI5tyLURZ/HbG6uIvVgPpI/dkGxbPPM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FgiDTQpwx/kMCQ4gk1ubD/kLZ8kQvsuFwFTvCc5LtsdVSjEjWbE2ybieHuztFosHRm2QCNLpzIf3IQQdEhWr9u/15EBKuW5em+Hsf8cVU60OGwk2oEGXco5yCUMIK0+bDXdX4mbpPnBnzUF++kYMRwTUl/vf8SxI24nQcUEIJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXv4/oPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXv4/oPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F031F00893;
	Mon, 28 Sep 2026 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790625212;
	bh=jMnu3Ol7KBz0NT66D+sJjyUzBHDUr7GTWSBEALAahNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PXv4/oPPrLAv5cuQziDtmGvdBZhxrI2pvlfWrO7L5a5DkiBw3YyJ7uIIXwgrL+fab
	 Mp77bNvIUY6mumygFAriMDyP6e4WMJ0JIvyiqVSOb1xS7Boz6roOFdLF/yoybCun4i
	 NK39H+B3hVUgtloaDl+I7WXSzmuPh7zNW5NmdCXB+aP/U9XGvuCdhgiH6V1ObiDL3P
	 uWMeUfIi0xASQIXPQMdyct7rZe7SE/JC+pQv4kCskhh6kaVdkIykR4mIvcsnQ1v4ag
	 Q2RWbGqeqCeBno2bvb7MnfwrlwbUSqSrAzKaNGT6d56ppolpHUjBrxjdqLfxi6bMtk
	 rWk74dmGLjgLw==
Date: Mon, 28 Sep 2026 09:53:31 -1000
Message-ID: <72d8d44fee50dc88f500bdb808eb21f6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Christian Loehle <christian.loehle@arm.com>,
 David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
 Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:
> Andrea Righi (16):
...
>       sched_ext: Block proxy donors before taking control
>       sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
>       sched_ext: Move reject DSQ draining into core
>       sched_ext: Generalize the reject DSQ reenqueue path
>       sched_ext: Handle proxy-exec races in remote DSQ transfers
>       sched_ext: Split curr|donor references properly
>       sched_ext: Track proxy execution for NOHZ_FULL
>       sched_ext: Delegate proxy donor admission to BPF schedulers
>       sched_ext: Add selftest for blocked donor admission
>       sched_ext: scx_qmap: Add proxy execution support
>       sched: Allow enabling proxy exec with sched_ext

Applied 6-16 to sched_ext/for-7.4 on top of tip/sched/core (be100c77178e)
with the following conflict resolutions:

- 07: sched/core's c72945693b90 ("sched: Restart fair hrtick after same-task
  repicks") changed set_next_task_scx() to take enum snt_e. @first is now
  derived as type == SNT_PICK. SNT_REPICK returns early as before.

- 08: for-7.4's 7a919c7f86de ("sched_ext: Test scx_has_subs() inline before
  calling sub-sched hooks") split scx_reenq_reject() into an inline wrapper
  and __scx_reenq_reject(). Moved the combined function into ext.c and
  dropped both from sub.h.

- 08, 09, 10: Kept scx_reenq_wait_dispatching() from 7de9a6fb44ea
  ("sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task") in
  reenq_local() and scx_reenq_reject(), after the new proxy retry checks.

- 10: be100c77178e already has the fixed scx_proxy_reenqueue_retry()
  signature, so only the body was applied. The rq_owned_post_enq() comment
  update was applied over the context changed by cb86607ada73 ("sched_ext:
  Don't run ops.dequeue() with a DSQ lock held").

- 11: Context only, the can_stop_tick declaration in set_next_task_scx() and
  the rq->donor change in scx_rescue_timerfn().

- 14: Context only, enq_blocked in the selftest Makefile.

- 15: dispatch_to_rescue() inserts without needs_immed() per a0d356696f87
  ("sched_ext: scx_qmap: Do not add IMMED to rescue inserts"), and the
  rescue comment keeps the for-7.4 text.

Can you please verify the result?

Thanks.

--
tejun
