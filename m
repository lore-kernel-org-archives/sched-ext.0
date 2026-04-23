Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2F1FB1;
	Thu, 23 Apr 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963236; cv=none; b=roiQiiIC9TwTGGjhWS+HHKD0BHlFjHIud0BhTMKsCNylijS5AHm1lAGv9Em3DsyjaqzByg+ogC+AvqoBBjU1wyz7MuXGxp6KBH1bGTjFqwbyu48/rpCRRcbhT4hMlAJBLj7J7jG1AL4vzqT0K3Oz0pV7WHtqkAWC6+nDcjg2HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963236; c=relaxed/simple;
	bh=RMc2Cj4+xJCb49ARauP82+IOBHhr08GSgTxz4uEz6Ro=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GuSZ1jK4hwnABnM/bCcoCw4u2QT9vDTt9/cXLtVQDTKRVKZ/sUIVLAyD+X1bWHSade5xJ0HsqqCk4wcxHl/KRnbX0CBjlmuf3AtbuTmtMdDmFvvDYdLhURIHRog/PS+sYhO1NBAKsX9QWu19sjzxRtMJ1pdQdWtPEBHKvK/i6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWLw+oDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWLw+oDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B2C2BCAF;
	Thu, 23 Apr 2026 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776963236;
	bh=RMc2Cj4+xJCb49ARauP82+IOBHhr08GSgTxz4uEz6Ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWLw+oDfMr3O2xB9XYAy9NR2KK66oQfpfpYirfWgDby3toj7wQwUYbdyELEhSy5U/
	 JGF4/9xvtdQd6YeAHOj7qDC5xolTlvbWEY3FGe8+QrnQSRXyYI+S9Q8PEzoPdhwG8a
	 mjXNoRHdmsZH3ob85SezcgusihcCJTPGHn8BiVTgRdmf4UhkMqsxiXDC5CSQ1Zk/GN
	 F65D7dTdjbxiKAeU8mgCXUeJrH59R03aicQuLV5HhRFz9F28DFpQh0Ra621AKkFCXF
	 3RFljK4jCFqy5LjY/IXqo+9ec5HBE7A/ANdTSMXzoN//qDdulW0Yie1+fx/oFfYutY
	 0onr8qXVnUO7Q==
Date: Thu, 23 Apr 2026 06:53:55 -1000
Message-ID: <ad24a49fd02d7b397976975a13767bb4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on local DSQs
In-Reply-To: <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com>
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>
	<aej8cmhZVhsqogr4@slm.duckdns.org>
	<DI0FTX13UW17.1IZJ9TMG9EFRA@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Thu, Apr 23, 2026 at 09:48:11AM +0000, Kuba Piecuch wrote:
> I'm not sure if we should limit ourselves to just remote tasks.
> If we call wakeup_preempt(rq, p, flags) when adding @p to @rq's local DSQ
> regardless of whether @p/@rq is remote, then I think that should cover all
> cases and the patch above wouldn't be needed.

Sorry, I wasn't clear. I meant adding wakeup_preempt() in
move_remote_task_to_local_dsq() *in addition to* your nr_immed/RETRY_TASK
patch. That combination covers both cases:

- Local (your stepwise scenario): the task stays on the dispatching CPU, no
  migration happens, so there's no insertion-side hook to arm. Your nr_immed
  check in do_pick_task_scx() catches it on the RETRY_TASK path.

- Remote: move_remote_task_to_local_dsq() is SCX's analog of
  move_queued_task() and is missing the wakeup_preempt() call that
  move_queued_task() does after activate_task(). Once added,
  dst_rq->next_class is bumped to &ext_sched_class, and any subsequent
  higher-class wakeup on dst_rq routes through wakeup_preempt_scx() which
  already has the nr_immed reenqueue.

Adding wakeup_preempt() to local_dsq_post_enq() for every insertion would
work too, but I'd rather keep it in sync with how core sched handles
move_queued_task() and only add it where it's actually needed.

Thanks.

--
tejun
